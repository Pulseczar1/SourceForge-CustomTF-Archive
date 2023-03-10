/*
Copyright (C) 1996-1997 Id Software, Inc.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

	$Id: sv_main.c,v 1.97 2007/04/06 21:15:13 qqshka Exp $
*/

#include "qwsvdef.h"
#include "rcon.h"

// eqds
static void SV_RemoveBanFilter_f (void);
static void SV_AddBanFilter_f (void);
void IF_SaveFilters (void);
void SV_TimerAdd_f (void);
void SV_TimerDel_f (void);
void SV_TimerDelAll_f (void);
void SV_TimerList_f (void);
void	SV_CheckTimers (void);


typedef enum
{
	CONSOLELOG, // log anything that is printed to system console
	CLIENTLOG, // log client connection/disconnect/name change activity (with userid and IP)
	FRAGLOG, // old fraglog file for stat programs
	RCONLOG, // log all rcon commands sent to server (whether failed or not)
	CHATLOG, // log player chat activity

	TOTAL_LOGS // to autosize logfiles_t::log[] array upon any additions
} logType_t;

qbool IF_FilterPacket (netadr_t addr, int type);

quakeparms_t host_parms;

qbool		host_initialized;		// true if into command execution (compatability)

double		realtime;			// without any filtering or bounding

int		host_hunklevel;

int		current_skill;			// for entity spawnflags checking

client_t	*sv_client;			// current client

char		master_rcon_password[128] = "";	//bliP: password for remote server commands

cvar_t	sv_cpserver = {"sv_cpserver", "0"};	// some cp servers couse lags on map changes


cvar_t	sv_mintic = {"sv_mintic","0.013"};	// bound the size of the
cvar_t	sv_maxtic = {"sv_maxtic","0.1"};	// physics time tic

qbool OnChange_sysselecttimeout_var (cvar_t *var, char *string);
cvar_t	sys_select_timeout = {"sys_select_timeout",
#ifdef _WIN32
							"10000"
#else
							"1000000"
#endif
							, 0, OnChange_sysselecttimeout_var};
// MUST be set to ~ (sv_mintic / 1.3) * 1 000 000 = 10 000
// (else can occur packets lost if sv_minping > 0)
// if set too low then occur higher CPU usage

cvar_t	sys_restart_on_error = {"sys_restart_on_error", "0"};

cvar_t	developer = {"developer", "0"};		// show extra messages

cvar_t	timeout = {"timeout", "65"};		// seconds without any message
cvar_t	zombietime = {"zombietime", "2"};	// seconds to sink messages
// after disconnect

cvar_t	rcon_password = {"rcon_password", ""};	// password for remote server commands
cvar_t	password = {"password", ""};	// password for entering the game
cvar_t	sv_hashpasswords = {"sv_hashpasswords", "1"}; // 0 - plain passwords; 1 - hashed passwords
cvar_t	telnet_password = {"telnet_password", ""}; // password for login via telnet
cvar_t	not_auth_timeout = {"not_auth_timeout", "20"};
// if no password is sent (telnet_password) in "n" seconds the server refuses connection
// If set to 0, no timeout will occur
cvar_t	auth_timeout = {"auth_timeout", "3600"};
// the server will close the connection "n" seconds after the authentication is completed
// If set to 0, no timeout will occur
cvar_t	sv_crypt_rcon = {"sv_crypt_rcon", "1"}; // use SHA1 for encryption of rcon_password and using timestamps
// Time in seconds during which in rcon command this encryption is valid (change only with master_rcon_password).
cvar_t	sv_timestamplen = {"sv_timestamplen", "60"};
cvar_t	sv_rconlim = {"sv_rconlim", "10"};	// rcon bandwith limit: requests per second

//bliP: telnet log level
//cvar_t	telnet_log_level = {"telnet_log_level", "0"}; // logging level telnet console
qbool OnChange_telnetloglevel_var (cvar_t *var, char *string);
cvar_t  telnet_log_level = {"telnet_log_level", "0", 0, OnChange_telnetloglevel_var};
//<-

cvar_t	frag_log_type = {"frag_log_type", "0"};
//	frag log type:
//		0 - old style (  qwsv - v0.165)
//		1 - new style (v0.168 - v0.172)

qbool OnChange_qconsolelogsay_var (cvar_t *var, char *string);
cvar_t	qconsole_log_say = {"qconsole_log_say", "0", 0, OnChange_qconsolelogsay_var};
// logging "say" and "say_team" messages to the qconsole_PORT.log file

cvar_t	sys_command_line = {"sys_command_line", NULL, CVAR_ROM};

cvar_t	sv_use_dns = {"sv_use_dns", "0"}; // 1 - use DNS lookup in status command, 0 - don't use
cvar_t	spectator_password = {"spectator_password", ""};	// password for entering as a sepctator
cvar_t	vip_password = {"vip_password", ""};	// password for entering as a VIP sepctator
cvar_t	vip_values = {"vip_values", ""};

cvar_t	allow_download		= {"allow_download", "1"};
cvar_t	allow_download_skins	= {"allow_download_skins", "1"};
cvar_t	allow_download_models	= {"allow_download_models", "1"};
cvar_t	allow_download_sounds	= {"allow_download_sounds", "1"};
cvar_t	allow_download_maps	= {"allow_download_maps", "1"};
cvar_t	allow_download_pakmaps	= {"allow_download_pakmaps", "0"};
cvar_t	allow_download_demos	= {"allow_download_demos", "1"};
cvar_t	allow_download_other	= {"allow_download_other", "0"};
//bliP: init ->
cvar_t	download_map_url = {"download_map_url", ""};

cvar_t	sv_specprint = {"sv_specprint", "0"};
cvar_t	sv_reconnectlimit = {"sv_reconnectlimit", "0"};

qbool OnChange_admininfo_var (cvar_t *var, char *string);
cvar_t  sv_admininfo = {"sv_admininfo", "", 0, OnChange_admininfo_var};

cvar_t	sv_unfake = {"sv_unfake", "0"}; //bliP: 24/9 kickfake to unfake
cvar_t	sv_kicktop = {"sv_kicktop", "0"};

cvar_t	sv_allowlastscores = {"sv_allowlastscores", "1"};

cvar_t	sv_maxlogsize = {"sv_maxlogsize", "0"};
//bliP: 24/9 ->
qbool OnChange_logdir_var (cvar_t *var, char *string);
cvar_t  sv_logdir = {"sv_logdir", ".", 0, OnChange_logdir_var};

cvar_t  sv_speedcheck = {"sv_speedcheck", "0"};
//<-
//<-
//cvar_t	sv_highchars = {"sv_highchars", "1"};
cvar_t	sv_phs = {"sv_phs", "1"};
cvar_t	pausable = {"pausable", "1"};
cvar_t	sv_maxrate = {"sv_maxrate", "0"};
cvar_t	sv_getrealip = {"sv_getrealip", "1"};
cvar_t	sv_serverip = {"sv_serverip", ""};
cvar_t	sv_forcespec_onfull = {"sv_forcespec_onfull", "2"};
cvar_t	sv_maxdownloadrate = {"sv_maxdownloadrate", "0"};

// EQDS MegaTF hax0rz!
cvar_t	sv_MegaTFHacks = {"sv_MegaTFHacks", "1"};

cvar_t  sv_loadentfiles = {"sv_loadentfiles", "1"}; //loads .ent files by default if there
cvar_t	sv_default_name = {"sv_default_name", "unnamed"};

qbool sv_mod_msg_file_OnChange(cvar_t *cvar, char *value);
cvar_t	sv_mod_msg_file = {"sv_mod_msg_file", "", 0, sv_mod_msg_file_OnChange};

//
// game rules mirrored in svs.info
//
cvar_t	fraglimit = {"fraglimit","0",CVAR_SERVERINFO};
cvar_t	timelimit = {"timelimit","0",CVAR_SERVERINFO};
cvar_t	teamplay = {"teamplay","0",CVAR_SERVERINFO};
cvar_t	samelevel = {"samelevel","0"};
cvar_t	maxclients = {"maxclients","8",CVAR_SERVERINFO};
cvar_t	maxspectators = {"maxspectators","8",CVAR_SERVERINFO};
cvar_t	maxvip_spectators = {"maxvip_spectators","0"/*,CVAR_SERVERINFO*/};
cvar_t	deathmatch = {"deathmatch","1",CVAR_SERVERINFO};
cvar_t	spawn = {"spawn","0"};
cvar_t	watervis = {"watervis","0",CVAR_SERVERINFO};
cvar_t	serverdemo = {"serverdemo","",CVAR_SERVERINFO | CVAR_ROM};
cvar_t	maxfps = {"maxfps", "0", CVAR_SERVERINFO, /*5,*/ OnChange_maxfps_var}; // maximum frames per second for client

// not mirrored
cvar_t	skill = {"skill", "1"};
cvar_t	coop = {"coop", "0"};

cvar_t	version = {"version", full_version, CVAR_ROM};
cvar_t	sv_paused = {"sv_paused", "0", CVAR_ROM};

cvar_t	hostname = {"hostname", "unnamed", CVAR_SERVERINFO};

cvar_t sv_forcenick = {"sv_forcenick", "0"}; //0 - don't force; 1 - as login;
cvar_t sv_registrationinfo = {"sv_registrationinfo", ""}; // text shown before "enter login"

cvar_t sv_maxuserid = {"sv_maxuserid", "99"};

cvar_t	lock_cvarLevels = {"lock_cvarLevels", "0", 0/*, 6*/}; // enables levels of cvars for rcon accounts to be edited
cvar_t	lock_cmdLevels = {"lock_cmdLevels", "0", 0/*, 6*/}; // enables levels of cmds for rcon accounts to be edited

cvar_t registered = {"registered", "1", CVAR_ROM};
// We need this cvar, because ktpro didn't allow to go at some placeses of, for example, start map.

cvar_t sv_ktpro_mode = {"sv_ktpro_mode", "auto"};

log_t	logs[MAX_LOG];

qbool sv_error = 0;
qbool server_cfg_done = false;

client_t *WatcherId = NULL; // QW262

void SV_AcceptClient (netadr_t adr, int userid, char *userinfo);

// Equake stuff
extern cvar_t			logconsole, logclient, logfrags, logrcon, logchat;

#define LOG_RUNAWAY		4096

#define	LOG_NONE		0
#define	LOG_CONSOLE		(1<<0)
#define	LOG_CLIENT		(1<<1)
#define	LOG_FRAGS		(1<<2)
#define	LOG_RCON		(1<<3)
#define	LOG_CHAT		(1<<4)

// logging options
#define	LO_NONE			0
#define	LO_PRINT		(1<<0)
#define	LO_FORMAT		(1<<1)
#define	LO_TIMESTAMP	(1<<2)
#define	LO_FORCEOPENING	(1<<3)



typedef enum 
{
	LS_OFF,				// not logging
	LS_BUFFER,			// logging to buffer
	LS_FLUSH			// logging and flushing
} logState_t;

typedef struct logfiles_s
{
	FILE	*log[TOTAL_LOGS];
	int		logstate;
} logfiles_t;

logfiles_t logfiles;
extern logfiles_t logfiles;
extern cvar_t	sv_timestamp;
extern cvar_t	sys_nostdout; // for now
//extern cvar_t	sv_readableOutput;
cvar_t	sv_readableOutput = {"sv_readableOutput", "1"}; //give readable output names


cvar_t	sv_timestamp = {"sv_timestamp", "2", 0}; // timestamps: 1 = only log files, 2 = logfiles and console window


void Com_Log (logType_t logType, int logOptions, char *text, ...);
static void LogHandle (char *string, char *logname, int LOG_STATE)
{
	int				port;
	char			name[MAX_QPATH];
	int				success;
	extern cvar_t	sv_logdir;
	qdate_t			date;

	port = NET_AdrToPort (net_local_adr);
	Q_snprintf (name, sizeof(name), "%s/%s/%s_%i.log", fs_gamedir, sv_logdir.string, logname, port);
	Sys_mkdir (va("%s/%s", fs_gamedir, sv_logdir.string));

	Sys_TimeOfDayExt (&date, "%H:%M:%S %m/%d/%y");

	if (!Q_atof(string)) 
	{
		switch (LOG_STATE)
		{
		case LOG_CONSOLE:
			if (!logfiles.log[CONSOLELOG])
				return;
			fclose (logfiles.log[CONSOLELOG]);
			logfiles.log[CONSOLELOG] = NULL;
			break;
		case LOG_CLIENT:
			if (!logfiles.log[CLIENTLOG])
				return;
			fclose (logfiles.log[CLIENTLOG]);
			logfiles.log[CLIENTLOG] = NULL;
			break;
		case LOG_CHAT:
			if (!logfiles.log[CHATLOG])
				return;
			fclose (logfiles.log[CHATLOG]);
			logfiles.log[CHATLOG] = NULL;
			break;
		case LOG_RCON:
			if (!logfiles.log[RCONLOG])
				return;
			fclose (logfiles.log[RCONLOG]);
			logfiles.log[RCONLOG] = NULL;
			break;
		default:
			return;
		}
		logfiles.logstate = (logfiles.logstate - LOG_STATE);
		Com_Printf ("LogFile : freed %s log file %s.log\n", logname, 
			va("%s_%i", logname, port));
	}
	else if (Q_atof(string))
	{
		success = false;
		switch (LOG_STATE)
		{
		case LOG_CONSOLE:
			logfiles.log[CONSOLELOG] = fopen(name, "at");	// append text
			if (&logfiles.log[CONSOLELOG])
			{
				success = true;
				Com_Log (CONSOLELOG, LO_FORCEOPENING|LO_FORMAT|LO_TIMESTAMP,
					"*** Console Logging Session Started: %s\n",
					date.cTimeStr);
			}
			else
				logfiles.log[CONSOLELOG] = NULL;
			break;
		case LOG_CLIENT:
			logfiles.log[CLIENTLOG] = fopen(name, "at");	// append text
			if (&logfiles.log[CLIENTLOG]) 
			{
				success = true;
				Com_Log (CLIENTLOG, LO_FORCEOPENING|LO_FORMAT|LO_TIMESTAMP,
					"*** Client Logging Session Started: %s\n",
					date.cTimeStr);
			}
			else
				logfiles.log[CLIENTLOG] = NULL;
			break;
		case LOG_CHAT:
			logfiles.log[CHATLOG] = fopen(name, "at");	// append text
			if (&logfiles.log[CHATLOG]) 
			{
				success = true;
				Com_Log (CHATLOG, LO_FORCEOPENING|LO_FORMAT|LO_TIMESTAMP,
					"*** Chat Logging Session Started: %s\n",
					date.cTimeStr);
			}
			else
				logfiles.log[CHATLOG] = NULL;
			break;
		case LOG_RCON:
			logfiles.log[RCONLOG] = fopen(name, "at");	// append text
			if (&logfiles.log[RCONLOG]) 
			{
				success = true;
				Com_Log (RCONLOG, LO_FORCEOPENING|LO_FORMAT|LO_TIMESTAMP,
					"*** Rcon Logging Session Started: %s\n",
					date.cTimeStr);
			}
			else
				logfiles.log[RCONLOG] = NULL;
			break;
		default:
			return;
		}
		if (success)
		{
			Com_Printf ("LogFile : logging %s to %s\n", logname, name);
			logfiles.logstate |= LOG_STATE;
		} 
		else 
			Com_Printf ("LogFile : warning: unable to open file %s\n", name);

	} 
}

qbool OnChange_logcommands_var (cvar_t *var, char *string)
{
	// FIXME: this is silly
	switch (var->name[4]) 
	{
				// logc'o'nsole
	case 'o':	// -----^
		LogHandle (string, "console", LOG_CONSOLE);
		break;
				// logc'l'ient
	case 'l':	// -----^
		LogHandle (string, "client", LOG_CLIENT);
		break;
				// logr'c'on
	case 'c':	// -----^
		LogHandle (string, "rcon", LOG_RCON);
		break;
				// logc'h'at
	case 'h':	// -----^
		LogHandle (string, "chat", LOG_CHAT);
		break;
	default:
		return true;
	}
	return false;
}

qbool OnChange_logfrags_var (cvar_t *var, char *string)
{
	char			name[MAX_OSPATH];
	int				i;
	int				port;
	extern cvar_t	sv_logdir;

	port = NET_AdrToPort(net_local_adr);
	Sys_mkdir(va("%s/%s", fs_gamedir, sv_logdir.string));

	if (!Q_atof(string) && logfiles.log[FRAGLOG])
	{
		fclose (logfiles.log[FRAGLOG]);
		Com_Printf ("Freed frag log file\n");
		logfiles.log[FRAGLOG] = NULL;
		logfiles.logstate = (logfiles.logstate - LOG_FRAGS);
		return !var;
	}
	else if (Q_atof(string) && !logfiles.log[FRAGLOG])
	{
		// find an unused name
		for (i=0 ; i<LOG_RUNAWAY ; i++)
		{
			Q_snprintf (name, sizeof(name), "%s/%s/frag%i_%i.log", 
				fs_gamedir, sv_logdir.string, i, port);
			logfiles.log[FRAGLOG] = fopen (name, "r");
			if (!logfiles.log[FRAGLOG])
			{
				// can't read it, so create this one
				logfiles.log[FRAGLOG] = fopen (name, "w");
				if (!logfiles.log[FRAGLOG])
					i=LOG_RUNAWAY;	// give error
				break;
			}
			fclose (logfiles.log[FRAGLOG]);
		}
		
		logfiles.logstate |=  LOG_FRAGS;
		if (i==LOG_RUNAWAY) 
		{
			Com_Printf ("LogFile : warning: unable to open frag.log\n");
			logfiles.log[FRAGLOG] = NULL;
			
			return !var;
		}
		Com_Printf ("LogFile : logging frags to %s.\n", name);
	}
	return !var;
}

void Log_Init (void)
{
	Cvar_Register (&logconsole);
	Cvar_Register (&logclient);
	Cvar_Register (&logfrags);
	Cvar_Register (&logrcon);
	Cvar_Register (&logchat);
}

//qbool OnChange_logcommands_var (cvar_t *var, char *string);
//qbool OnChange_logfrags_var (cvar_t *var, char *string);
cvar_t	logconsole = {"logconsole","0", 0, OnChange_logcommands_var};	// log console text. 1 = buffer 2 = flush after every line
cvar_t	logclient = {"logclient","0", 0, OnChange_logcommands_var};	// log client text. 1 = buffer 2 = flush after every line
cvar_t	logfrags = {"logfrags","0", 0, OnChange_logfrags_var};			// log frags text. 1 = buffer 2 = flush after every line
cvar_t	logrcon = {"logrcon","0", 0, OnChange_logcommands_var};		// log rcon text. 1 = buffer 2 = flush after every line
cvar_t	logchat = {"logchat","0", 0, OnChange_logcommands_var};	// log client text. 1 = buffer 2 = flush after every line

/*
==================
SV_Stuff_f

Stuff a command into a client.
==================
*/

void SV_Stuff_f (void)
{
	client_t	*cl;
	int			uid;
	int			i, j, c;
	char		buffer[GENERIC_BUFFER];


	c = Cmd_Argc ();
	if (c < 3) 
	{
		Com_Printf ("usage: stuff <uid> <commands>\n");
		return;
	}

	uid = atoi (Cmd_Argv (1));
	buffer[0] = 0;

	for (i = 0, cl = svs.clients; i < MAX_CLIENTS; i++, cl++) 
	{
		if (!cl->state)
			continue;
		if (cl->userid == uid)
		{
			for (j = 2; j < Cmd_Argc(); j++)
			{
				strncat (buffer, Cmd_Argv(j), sizeof(buffer)-2);
				strncat (buffer, " ", sizeof(buffer)-2);
			}
			strncat (buffer, "\n", sizeof(buffer)-2);
			buffer[sizeof(buffer)-1] = '\0';

			ClientReliableWrite_Begin (cl, svc_stufftext, strlen(buffer)+2);
			ClientReliableWrite_String (cl, buffer);
			return;
		}  
	}
	Com_Printf ("Couldn't find user number %i\n", uid);

}


/*
==================
SV_StuffAll_f

Stuff a command into all clients.
==================
*/
void SV_StuffAll_f (void)
{

	client_t	*cl;
	int			i, c;
	char		buffer[GENERIC_BUFFER];
	char		*reason = NULL;


	// plexi: fixed usage line
	c = Cmd_Argc ();
	if (c < 2)
	{
		Com_Printf ("usage: stuffall <string>\n");
		return;
	}

	reason = Cmd_Args ();

	if (reason == NULL || !strcmp (reason, ""))
		return;

	Q_bzero (buffer, sizeof(buffer));
	strncpy (buffer,reason, sizeof(buffer)-1);
	strncat (buffer, "\n", sizeof(buffer)-1);

	for (i = 0, cl = svs.clients; i < MAX_CLIENTS; i++, cl++) 
	{
		if (!cl->state)
			continue;

		ClientReliableWrite_Begin (cl, svc_stufftext, 32);
		ClientReliableWrite_String (cl, buffer);
	}
}

/*
=========
Cmd_Reload_f 
reloads the current map.
=========
*/
void Cmd_Reload_f (void)
{
	char		reload[MAX_QPATH+5];
	
	Q_snprintf (reload, sizeof(reload), "map %s\n", sv.mapname);
	Cbuf_InsertText (reload);
	Cbuf_Execute ();
}



/*
================
Com_Log

Global procedure to write to any specified log file and 
automatically flush the buffer if the option is on.
================
*/
void Com_Log (logType_t logType, int logOptions, char *text, ...)
{
	va_list			argptr;
	char			line[MAX_PRINT_STRING];
	static qbool	pending = false;
	cvar_t			*loggingCvar = NULL;

	line[0] = 0;

	if (logType == CHATLOG)
		Sys_Printf ("logchat\n");

	if ((logOptions & LO_FORMAT)) 
	{ 
		// we can always va() incoming text if this causes problems
		va_start (argptr,text);
		vsnprintf (line, sizeof(line), text, argptr);
		va_end (argptr);
	}
	else
		strncpy (line, text, sizeof(line)-1);

	if ((logOptions & LO_PRINT))
		Sys_Printf ("%s", line);

	if (!logfiles.log[logType])
		return;

	switch (logType) 
	{
	case CLIENTLOG:
		loggingCvar = &logclient;
		break;
	case CHATLOG:
		loggingCvar = &logchat;
		break;
	case RCONLOG:
		loggingCvar = &logrcon;
		break;
	case CONSOLELOG:
		loggingCvar = &logconsole;
		break;
	case FRAGLOG: // fraglog shouldn't be handled here.
	default:
		return;
	}
	if (!loggingCvar->value && (!(logOptions & LO_FORCEOPENING))) // logging option is off for this log
		return;

	if (sv_timestamp.value && (logOptions & LO_TIMESTAMP))
	{
		qdate_t	date;

		Sys_TimeOfDay (&date);
		fprintf (logfiles.log[logType], "%s ", date.cTimeStr);

		if (line[strlen(line) - 1] != '\n')
			pending = true;
		else 
			pending = false;
	}

	// make names readable
	if (sv_readableOutput.value) 
		Q_normalizetext (line);

	fprintf (logfiles.log[logType], line);

	if (loggingCvar->value > LS_BUFFER || (logOptions & LO_FORCEOPENING))
		fflush (logfiles.log[logType]);
}

//============================================================================

qbool GameStarted(void)
{
	return sv.mvdrecording || strncasecmp(Info_ValueForKey(svs.info, "status"), "Standby", 8);
}
/*
================
SV_Shutdown

Quake calls this before calling Sys_Quit or Sys_Error
================
*/
void SV_Shutdown (void)
{
	int i;

//	#if defined (_WIN32) && !defined(_DEBUG)
//	Win32StructuredException::UnRegisterWin32ExceptionHandler();
//	#endif
	 
//	#if defined (__linux__)
//	UnRegisterLinuxSegvHandler();
//	#endif

	Master_Shutdown ();
	if (telnetport)
		SV_Write_Log(TELNET_LOG, 1, "Server shutdown.\n");
	for (i = MIN_LOG; i < MAX_LOG; ++i)
	{
		if (logs[i].sv_logfile)
		{
			fclose (logs[i].sv_logfile);
			logs[i].sv_logfile = NULL;
		}
	}
	if (sv.mvdrecording)
		SV_MVDStop_f();

	NET_Shutdown ();
}

/*
================
SV_Error

Sends a datagram to all the clients informing them of the server crash,
then exits
================
*/
void SV_Error (char *error, ...)
{
	static qbool inerror = false;
	static char string[1024];
	va_list argptr;


	sv_error = true;

	if (inerror)
		Sys_Error ("SV_Error: recursively entered (%s)", string);

	inerror = true;

	va_start (argptr,error);
	vsnprintf (string, sizeof(string), error, argptr);
	va_end (argptr);

	Con_Printf ("SV_Error: %s\n",string);

	SV_FinalMessage (va("server crashed: %s\n", string));

	SV_Shutdown ();

	Sys_Error ("SV_Error: %s\n",string);
}

static void SV_FreeHeadDelayedPacket(client_t *cl) {
	if (cl->packets) {
		packet_t *next = cl->packets->next;
		cl->packets->next = svs.free_packets;
		svs.free_packets = cl->packets;
		cl->packets = next;
	}
}


void SV_FreeDelayedPackets (client_t *cl) {
	while (cl->packets)
		SV_FreeHeadDelayedPacket(cl);
}

/*
==================
SV_FinalMessage

Used by SV_Error and SV_Quit_f to send a final message to all connected
clients before the server goes down.  The messages are sent immediately,
not just stuck on the outgoing message list, because the server is going
to totally exit after returning from this function.
==================
*/
void SV_FinalMessage (char *message)
{
	client_t *cl;
	int i;

	SZ_Clear (&net_message);
	MSG_WriteByte (&net_message, svc_print);
	MSG_WriteByte (&net_message, PRINT_HIGH);
	MSG_WriteString (&net_message, message);
	MSG_WriteByte (&net_message, svc_disconnect);

	for (i=0, cl = svs.clients ; i<MAX_CLIENTS ; i++, cl++)
		if (cl->state >= cs_spawned)
			Netchan_Transmit (&cl->netchan, net_message.cursize
			                  , net_message.data);
}



/*
=====================
SV_DropClient

Called when the player is totally leaving the server, either willingly
or unwillingly.  This is NOT called if the entire server is quiting
or crashing.
=====================
*/
#ifdef USE_PR2
void RemoveBot(client_t *cl);
#endif
void SV_DropClient (client_t *drop)
{
	//bliP: cuff, mute ->
	SV_SavePenaltyFilter (drop, ft_mute, drop->lockedtill);
	SV_SavePenaltyFilter (drop, ft_cuff, drop->cuff_time);
	//<-

	//bliP: player logging
	if (drop->name[0])
		SV_LogPlayer(drop, "disconnect", 1);
	//<-

	// add the disconnect
#ifdef USE_PR2
	if( drop->isBot )
	{
		RemoveBot(drop);
		return;
	}
#endif
	MSG_WriteByte (&drop->netchan.message, svc_disconnect);

	if (drop->state == cs_spawned)
	{
		if (!drop->spectator)
		{
			// call the prog function for removing a client
			// this will set the body to a dead frame, among other things
			pr_global_struct->self = EDICT_TO_PROG(drop->edict);
#ifdef USE_PR2
			if ( sv_vm )
				PR2_GameClientDisconnect(0);
			else
#endif
				PR_ExecuteProgram (pr_global_struct->ClientDisconnect);
		}
		else if (SpectatorDisconnect
#ifdef USE_PR2
			|| ( sv_vm )
#endif
			)
		{
			// call the prog function for removing a client
			// this will set the body to a dead frame, among other things
			pr_global_struct->self = EDICT_TO_PROG(drop->edict);
#ifdef USE_PR2
			if ( sv_vm )
				PR2_GameClientDisconnect(1);
			else
#endif
				PR_ExecuteProgram (SpectatorDisconnect);
		}
	}

	if (drop->spectator)
		Con_Printf ("Spectator %s removed\n",drop->name);
	else
		Con_Printf ("Client %s removed\n",drop->name);

	if (drop->download)
	{
		fclose (drop->download);
		drop->download = NULL;
	}
	if (drop->upload)
	{
		fclose (drop->upload);
		drop->upload = NULL;
	}
	*drop->uploadfn = 0;

	SV_Logout(drop);

	drop->state = cs_zombie;		// become free in a few seconds
	drop->connection_started = realtime;	// for zombie timeout

// MD -->
	if (drop == WatcherId)
		WatcherId = NULL;
// <-- MD

	drop->old_frags = 0;
	drop->edict->v.frags = 0.0;
	drop->name[0] = 0;
	memset (drop->userinfo, 0, sizeof(drop->userinfo));
	memset (drop->userinfoshort, 0, sizeof(drop->userinfoshort));

	// send notification to all remaining clients
	SV_FullClientUpdate (drop, &sv.reliable_datagram);
}


//====================================================================

/*
===================
SV_CalcPing

===================
*/
int SV_CalcPing (client_t *cl)
{
	register client_frame_t *frame;
	int count, i;
	float ping;


	//bliP: 999 ping for connecting players
	if (cl->state != cs_spawned)
		return 999;
	//<-

	ping = 0;
	count = 0;
#ifdef USE_PR2
	if( cl->isBot )
		return ((int) (sv_mintic.value * 1000));
#endif
	for (frame = cl->frames, i=0 ; i<UPDATE_BACKUP ; i++, frame++)
	{
		if (frame->ping_time > 0)
		{
			ping += frame->ping_time;
			count++;
		}
	}
	if (!count)
		return 9999;
	ping /= count;

	return ping*1000;
}

// xavior's hax :x
void botUpdateFrags ( int clientno, int clientfrags )
{
	sizebuf_t *BOT_FIGHTING;
	BOT_FIGHTING = &sv.reliable_datagram;

	MSG_WriteByte (BOT_FIGHTING, 14);
	MSG_WriteByte (BOT_FIGHTING, clientno);
	MSG_WriteShort (BOT_FIGHTING, clientfrags);

	ClientReliableCheckBlock(sv_client, sv.reliable_datagram.cursize);
	ClientReliableWrite_SZ(sv_client, sv.reliable_datagram.data, sv.reliable_datagram.cursize);

//	if (sv_client->state != cs_spawned)
//		continue; // datagrams only go to spawned

	SZ_Write (&sv_client->datagram, sv.datagram.data, sv.datagram.cursize);

	SZ_Clear (&sv.datagram);
	SZ_Clear (&sv.reliable_datagram);
};

void botUpdatePing ( int clientno, int clientping )
{
//	if (self.nocheck == 1)
//		return;
	sizebuf_t *BOT_FIGHTING;
	BOT_FIGHTING = &sv.reliable_datagram;

	MSG_WriteByte (BOT_FIGHTING, 36);
	MSG_WriteByte (BOT_FIGHTING, clientno);
	MSG_WriteShort (BOT_FIGHTING, clientping);

	ClientReliableCheckBlock(sv_client, sv.reliable_datagram.cursize);
	ClientReliableWrite_SZ(sv_client, sv.reliable_datagram.data, sv.reliable_datagram.cursize);

//	if (sv_client->state != cs_spawned)
//		continue; // datagrams only go to spawned

	SZ_Write (&sv_client->datagram, sv.datagram.data, sv.datagram.cursize);

	SZ_Clear (&sv.datagram);
	SZ_Clear (&sv.reliable_datagram);
};

void botUpdateEnterTime ( int clientno, int cliententertime )
{
//	if (self.nocheck == 1)
//		return;
	sizebuf_t *BOT_FIGHTING;
	BOT_FIGHTING = &sv.reliable_datagram;

	MSG_WriteByte (BOT_FIGHTING, 37);
	MSG_WriteByte (BOT_FIGHTING, clientno);
	MSG_WriteLong (BOT_FIGHTING, cliententertime);

	ClientReliableCheckBlock(sv_client, sv.reliable_datagram.cursize);
	ClientReliableWrite_SZ(sv_client, sv.reliable_datagram.data, sv.reliable_datagram.cursize);

//	if (sv_client->state != cs_spawned)
//		continue; // datagrams only go to spawned

	SZ_Write (&sv_client->datagram, sv.datagram.data, sv.datagram.cursize);

	SZ_Clear (&sv.datagram);
	SZ_Clear (&sv.reliable_datagram);
};

/*
===================
botUpdateUserInfo

Sends bot info to clients from the server after setbot(...) is called in qc
- also sends bot info to connecting clients
===================
*/
void botUpdateUserInfo ( client_t *client, int clientno, int clientid, int clientshirt, int clientpants, char *clientname, int botteam, int botskin)
{
	sizebuf_t *BOT_FIGHTING;
	BOT_FIGHTING = &sv.reliable_datagram;

//	if (self.nocheck == 1)
//		return;
	MSG_WriteByte (BOT_FIGHTING, 40);
	MSG_WriteByte (BOT_FIGHTING, clientno);
	MSG_WriteLong (BOT_FIGHTING, clientid);
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 109);
	MSG_WriteByte (BOT_FIGHTING, 115);
	MSG_WriteByte (BOT_FIGHTING, 103);
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 49);
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 114);
	MSG_WriteByte (BOT_FIGHTING, 97);
	MSG_WriteByte (BOT_FIGHTING, 116);
	MSG_WriteByte (BOT_FIGHTING, 101);
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 53);
	MSG_WriteByte (BOT_FIGHTING, 48);
	MSG_WriteByte (BOT_FIGHTING, 48);
	MSG_WriteByte (BOT_FIGHTING, 48);
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 119);
	MSG_WriteByte (BOT_FIGHTING, 95);
	MSG_WriteByte (BOT_FIGHTING, 115);
	MSG_WriteByte (BOT_FIGHTING, 119);
	MSG_WriteByte (BOT_FIGHTING, 105);
	MSG_WriteByte (BOT_FIGHTING, 116);
	MSG_WriteByte (BOT_FIGHTING, 99);
	MSG_WriteByte (BOT_FIGHTING, 104);
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 50);
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 98);
	MSG_WriteByte (BOT_FIGHTING, 95);
	MSG_WriteByte (BOT_FIGHTING, 115);
	MSG_WriteByte (BOT_FIGHTING, 119);
	MSG_WriteByte (BOT_FIGHTING, 105);
	MSG_WriteByte (BOT_FIGHTING, 116);
	MSG_WriteByte (BOT_FIGHTING, 99);
	MSG_WriteByte (BOT_FIGHTING, 104);
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 50);
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 110);
	MSG_WriteByte (BOT_FIGHTING, 111);
	MSG_WriteByte (BOT_FIGHTING, 97);
	MSG_WriteByte (BOT_FIGHTING, 105);
	MSG_WriteByte (BOT_FIGHTING, 109);
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 48);
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 115);
	MSG_WriteByte (BOT_FIGHTING, 112);
	MSG_WriteByte (BOT_FIGHTING, 101);
	MSG_WriteByte (BOT_FIGHTING, 99);
	MSG_WriteByte (BOT_FIGHTING, 116);
	MSG_WriteByte (BOT_FIGHTING, 97);
	MSG_WriteByte (BOT_FIGHTING, 116);
	MSG_WriteByte (BOT_FIGHTING, 111);
	MSG_WriteByte (BOT_FIGHTING, 114);
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 48);
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 112);
	MSG_WriteByte (BOT_FIGHTING, 109);
	MSG_WriteByte (BOT_FIGHTING, 111);
	MSG_WriteByte (BOT_FIGHTING, 100);
	MSG_WriteByte (BOT_FIGHTING, 101);
	MSG_WriteByte (BOT_FIGHTING, 108);
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 49);
	MSG_WriteByte (BOT_FIGHTING, 51);
	MSG_WriteByte (BOT_FIGHTING, 56);
	MSG_WriteByte (BOT_FIGHTING, 52);
	MSG_WriteByte (BOT_FIGHTING, 53);
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 101);
	MSG_WriteByte (BOT_FIGHTING, 109);
	MSG_WriteByte (BOT_FIGHTING, 111);
	MSG_WriteByte (BOT_FIGHTING, 100);
	MSG_WriteByte (BOT_FIGHTING, 101);
	MSG_WriteByte (BOT_FIGHTING, 108);
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 54);
	MSG_WriteByte (BOT_FIGHTING, 57);
	MSG_WriteByte (BOT_FIGHTING, 54);
	MSG_WriteByte (BOT_FIGHTING, 55);
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 98);
	MSG_WriteByte (BOT_FIGHTING, 111);
	MSG_WriteByte (BOT_FIGHTING, 116);
	MSG_WriteByte (BOT_FIGHTING, 116);
	MSG_WriteByte (BOT_FIGHTING, 111);
	MSG_WriteByte (BOT_FIGHTING, 109);
	MSG_WriteByte (BOT_FIGHTING, 99);
	MSG_WriteByte (BOT_FIGHTING, 111);
	MSG_WriteByte (BOT_FIGHTING, 108);
	MSG_WriteByte (BOT_FIGHTING, 111);
	MSG_WriteByte (BOT_FIGHTING, 114);
	MSG_WriteByte (BOT_FIGHTING, 92);
	if ( clientpants > 9 )
	{
		MSG_WriteByte (BOT_FIGHTING, 49);
		MSG_WriteByte (BOT_FIGHTING, (38 + clientpants));
	}
	else
	{
		MSG_WriteByte (BOT_FIGHTING, (48 + clientpants));
	}
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 116);
	MSG_WriteByte (BOT_FIGHTING, 111);
	MSG_WriteByte (BOT_FIGHTING, 112);
	MSG_WriteByte (BOT_FIGHTING, 99);
	MSG_WriteByte (BOT_FIGHTING, 111);
	MSG_WriteByte (BOT_FIGHTING, 108);
	MSG_WriteByte (BOT_FIGHTING, 111);
	MSG_WriteByte (BOT_FIGHTING, 114);
	MSG_WriteByte (BOT_FIGHTING, 92);
	if ((clientshirt > 9))
	{
		MSG_WriteByte (BOT_FIGHTING, 49);
		MSG_WriteByte (BOT_FIGHTING, (38 + clientshirt));
	}
	else
	{
		MSG_WriteByte (BOT_FIGHTING, (48 + clientshirt));
	}
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 116);
	MSG_WriteByte (BOT_FIGHTING, 101);
	MSG_WriteByte (BOT_FIGHTING, 97);
	MSG_WriteByte (BOT_FIGHTING, 109);
	MSG_WriteByte (BOT_FIGHTING, 92);
	if ((botteam == 1))
	{
		MSG_WriteByte (BOT_FIGHTING, 98);
		MSG_WriteByte (BOT_FIGHTING, 108);
		MSG_WriteByte (BOT_FIGHTING, 117);
		MSG_WriteByte (BOT_FIGHTING, 101);
	}
	else
	{
		if ((botteam == 2))
		{
			MSG_WriteByte (BOT_FIGHTING, 114);
			MSG_WriteByte (BOT_FIGHTING, 101);
			MSG_WriteByte (BOT_FIGHTING, 100);
		}
	}
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 115);
	MSG_WriteByte (BOT_FIGHTING, 107);
	MSG_WriteByte (BOT_FIGHTING, 105);
	MSG_WriteByte (BOT_FIGHTING, 110);
	MSG_WriteByte (BOT_FIGHTING, 92);
	if ((botskin == 1))
	{
		MSG_WriteByte (BOT_FIGHTING, 116);
		MSG_WriteByte (BOT_FIGHTING, 102);
		MSG_WriteByte (BOT_FIGHTING, 95);
		MSG_WriteByte (BOT_FIGHTING, 115);
		MSG_WriteByte (BOT_FIGHTING, 99);
		MSG_WriteByte (BOT_FIGHTING, 111);
		MSG_WriteByte (BOT_FIGHTING, 117);
		MSG_WriteByte (BOT_FIGHTING, 116);
	}
	else
	{
		if ((botskin == 2))
		{
			MSG_WriteByte (BOT_FIGHTING, 116);
			MSG_WriteByte (BOT_FIGHTING, 102);
			MSG_WriteByte (BOT_FIGHTING, 95);
			MSG_WriteByte (BOT_FIGHTING, 115);
			MSG_WriteByte (BOT_FIGHTING, 110);
			MSG_WriteByte (BOT_FIGHTING, 105);
			MSG_WriteByte (BOT_FIGHTING, 112);
			MSG_WriteByte (BOT_FIGHTING, 101);
		}
		else
		{
			if ((botskin == 3))
			{
				MSG_WriteByte (BOT_FIGHTING, 116);
				MSG_WriteByte (BOT_FIGHTING, 102);
				MSG_WriteByte (BOT_FIGHTING, 95);
				MSG_WriteByte (BOT_FIGHTING, 115);
				MSG_WriteByte (BOT_FIGHTING, 111);
				MSG_WriteByte (BOT_FIGHTING, 108);
				MSG_WriteByte (BOT_FIGHTING, 100);
			}
			else
			{
				if ((botskin == 4))
				{
					MSG_WriteByte (BOT_FIGHTING, 116);
					MSG_WriteByte (BOT_FIGHTING, 102);
					MSG_WriteByte (BOT_FIGHTING, 95);
					MSG_WriteByte (BOT_FIGHTING, 100);
					MSG_WriteByte (BOT_FIGHTING, 101);
					MSG_WriteByte (BOT_FIGHTING, 109);
					MSG_WriteByte (BOT_FIGHTING, 111);
				}
				else
				{
					if ((botskin == 5))
					{
						MSG_WriteByte (BOT_FIGHTING, 116);
						MSG_WriteByte (BOT_FIGHTING, 102);
						MSG_WriteByte (BOT_FIGHTING, 95);
						MSG_WriteByte (BOT_FIGHTING, 109);
						MSG_WriteByte (BOT_FIGHTING, 101);
						MSG_WriteByte (BOT_FIGHTING, 100);
						MSG_WriteByte (BOT_FIGHTING, 105);
						MSG_WriteByte (BOT_FIGHTING, 99);
					}
					else
					{
						if ((botskin == 6))
						{
							MSG_WriteByte (BOT_FIGHTING, 116);
							MSG_WriteByte (BOT_FIGHTING, 102);
							MSG_WriteByte (BOT_FIGHTING, 95);
							MSG_WriteByte (BOT_FIGHTING, 104);
							MSG_WriteByte (BOT_FIGHTING, 119);
							MSG_WriteByte (BOT_FIGHTING, 103);
							MSG_WriteByte (BOT_FIGHTING, 117);
							MSG_WriteByte (BOT_FIGHTING, 121);
						}
						else
						{
							if ((botskin == 7))
							{
								MSG_WriteByte (BOT_FIGHTING, 116);
								MSG_WriteByte (BOT_FIGHTING, 102);
								MSG_WriteByte (BOT_FIGHTING, 95);
								MSG_WriteByte (BOT_FIGHTING, 112);
								MSG_WriteByte (BOT_FIGHTING, 121);
								MSG_WriteByte (BOT_FIGHTING, 114);
								MSG_WriteByte (BOT_FIGHTING, 111);
							}
							else
							{
								if ((botskin == 8))
								{
									MSG_WriteByte (BOT_FIGHTING, 116);
									MSG_WriteByte (BOT_FIGHTING, 102);
									MSG_WriteByte (BOT_FIGHTING, 95);
									MSG_WriteByte (BOT_FIGHTING, 115);
									MSG_WriteByte (BOT_FIGHTING, 112);
									MSG_WriteByte (BOT_FIGHTING, 121);
								}
								else
								{
									if ((botskin == 9))
									{
										MSG_WriteByte (BOT_FIGHTING, 116);
										MSG_WriteByte (BOT_FIGHTING, 102);
										MSG_WriteByte (BOT_FIGHTING, 95);
										MSG_WriteByte (BOT_FIGHTING, 101);
										MSG_WriteByte (BOT_FIGHTING, 110);
										MSG_WriteByte (BOT_FIGHTING, 103);
									}
									else
									{
										MSG_WriteByte (BOT_FIGHTING, 98);
										MSG_WriteByte (BOT_FIGHTING, 97);
										MSG_WriteByte (BOT_FIGHTING, 115);
										MSG_WriteByte (BOT_FIGHTING, 101);
									}
								}
							}
						}
					}
				}
			}
		}
	}
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteByte (BOT_FIGHTING, 110);
	MSG_WriteByte (BOT_FIGHTING, 97);
	MSG_WriteByte (BOT_FIGHTING, 109);
	MSG_WriteByte (BOT_FIGHTING, 101);
	MSG_WriteByte (BOT_FIGHTING, 92);
	MSG_WriteString (BOT_FIGHTING, clientname);

	ClientReliableCheckBlock(client, sv.reliable_datagram.cursize);
	ClientReliableWrite_SZ(client, sv.reliable_datagram.data, sv.reliable_datagram.cursize);

//	if (sv_client->state != cs_spawned)
//		continue; // datagrams only go to spawned

	SZ_Write (&client->datagram, sv.datagram.data, sv.datagram.cursize);

	SZ_Clear (&sv.datagram);
	SZ_Clear (&sv.reliable_datagram);
};

/*
===================
SV_FullClientUpdate

Writes all update values to a sizebuf
===================
*/
void SV_FullClientUpdate (client_t *client, sizebuf_t *buf)
{
	char info[MAX_INFO_STRING];
	int i;

	i = client - svs.clients;

	//Sys_Printf("SV_FullClientUpdate:  Updated frags for client %d\n", i);

	MSG_WriteByte (buf, svc_updatefrags);
	MSG_WriteByte (buf, i);
	MSG_WriteShort (buf, client->old_frags);

	MSG_WriteByte (buf, svc_updateping);
	MSG_WriteByte (buf, i);
	MSG_WriteShort (buf, SV_CalcPing (client));

	MSG_WriteByte (buf, svc_updatepl);
	MSG_WriteByte (buf, i);
	MSG_WriteByte (buf, client->lossage);

	MSG_WriteByte (buf, svc_updateentertime);
	MSG_WriteByte (buf, i);
	MSG_WriteFloat (buf, realtime - client->connection_started);

	strlcpy (info, client->userinfoshort, MAX_INFO_STRING);
	Info_RemovePrefixedKeys (info, '_');	// server passwords, etc

	MSG_WriteByte (buf, svc_updateuserinfo);
	MSG_WriteByte (buf, i);
	MSG_WriteLong (buf, client->userid);
	MSG_WriteString (buf, info);
}

/*
===================
SV_FullClientUpdateToClient

Writes all update values to a client's reliable stream
===================
*/
void SV_FullClientUpdateToClient (client_t *client, client_t *cl)
{
	ClientReliableCheckBlock(cl, 24 + strlen(client->userinfo));
	if (cl->num_backbuf)
	{
		SV_FullClientUpdate (client, &cl->backbuf);
		ClientReliable_FinishWrite(cl);
	}
	else
		SV_FullClientUpdate (client, &cl->netchan.message);
}

//Returns a unique userid in 1..<sv_maxuserid> range
int SV_GenerateUserID (void)
{
	client_t *cl;
	int i;


	do {
		svs.lastuserid++;
		if (svs.lastuserid == 1 + (int)sv_maxuserid.value)
			svs.lastuserid = 1;
		for (i = 0, cl = svs.clients; i < MAX_CLIENTS; i++, cl++)
			if (cl->state != cs_free && cl->userid == svs.lastuserid)
				break;
	} while (i != MAX_CLIENTS);

	return svs.lastuserid;
}

/*
==============================================================================

CONNECTIONLESS COMMANDS

==============================================================================
*/

/*
================
SVC_Status

Responds with all the info that qplug or qspy can see
This message can be up to around 5k with worst case string lengths.
================
*/
#define STATUS_OLDSTYLE					0
#define	STATUS_SERVERINFO				1
#define	STATUS_PLAYERS					2
#define	STATUS_SPECTATORS				4
#define	STATUS_SPECTATORS_AS_PLAYERS	8 //for ASE - change only frags: show as "S"
#define STATUS_SHOWTEAMS				16

static void SVC_Status (void)
{
	int top, bottom, ping, i, opt = 0;
	char *name, *frags;
	client_t *cl;
	// bot:
	char		*bname, *sname;
	int			frgs;


	if (Cmd_Argc() > 1)
		opt = Q_atoi(Cmd_Argv(1));

	SV_BeginRedirect (RD_PACKET);
	if (opt == STATUS_OLDSTYLE || (opt & STATUS_SERVERINFO))
		Con_Printf ("%s\n", svs.info);
	if (opt == STATUS_OLDSTYLE || (opt & (STATUS_PLAYERS | STATUS_SPECTATORS)))
		for (i = 0; i < MAX_CLIENTS; i++)
		{
			cl = &svs.clients[i];
			if ( (cl->state >= cs_preconnected/* || cl->state == cs_spawned */) &&
			        ( (!cl->spectator && ((opt & STATUS_PLAYERS) || opt == STATUS_OLDSTYLE)) ||
			          ( cl->spectator && ( opt & STATUS_SPECTATORS)) ) )
			{
				top    = Q_atoi(Info_ValueForKey (cl->userinfo, "topcolor"));
				bottom = Q_atoi(Info_ValueForKey (cl->userinfo, "bottomcolor"));
				top    = (top    < 0) ? 0 : ((top    > 13) ? 13 : top);
				bottom = (bottom < 0) ? 0 : ((bottom > 13) ? 13 : bottom);
				ping   = SV_CalcPing (cl);
				name   = cl->name;
				if (cl->spectator)
				{
					if (opt & STATUS_SPECTATORS_AS_PLAYERS)
						frags = "S";
					else
					{
						ping  = -ping;
						frags = "-9999";
						name  = va("\\s\\%s", name);
					}
				}
				else
					frags = va("%i", cl->old_frags);

				Con_Printf ("%i %s %i %i \"%s\" \"%s\" %i %i", cl->userid, frags,
				            (int)(realtime - cl->connection_started)/60, ping, name,
				            Info_ValueForKey (cl->userinfo, "skin"), top, bottom);

				if (opt & STATUS_SHOWTEAMS)
					Con_Printf (" \"%s\"\n", cl->team);
				else
					Con_Printf ("\n");
			}
		}
	for (i=0 ; i<MAX_BOTS ; i++)
	{
		cl = &sbi.bots[i];
		if ( cl->state == 666 )
		{
			if ( cl->botent && cl->botent->v.team != 0 ) {
				//bname = strcat("[bot]MegaTF Bot", i);
				//bname = "BOOOOT";
				bname = cl->bname;
				frgs = cl->botent->v.frags;
	//			bname = Q_strcat(bname, "%i",i);
				//top = atoi(Info_ValueForKey (cl->userinfo, "topcolor"));
				//bottom = atoi(Info_ValueForKey (cl->userinfo, "bottomcolor"));
				top = cl->botent->v.team - 1;
				bottom = cl->botent->v.team - 1;
				sname = cl->pskin;
				top = (top < 0) ? 0 : ((top > 13) ? 13 : top);
				bottom = (bottom < 0) ? 0 : ((bottom > 13) ? 13 : bottom);
				ping = floor((rand() / 1000));
				Con_Printf ("%i %i %i %i \"%s\" \"%s\" %i %i\n", cl->userid, 
					frgs/*cl->old_frags*/, (int)(realtime - cl->connection_started)/60,
					ping, bname, sname, top, bottom);
			}
		}
	}
	SV_EndRedirect ();
}

/*
===================
SVC_LastScores

===================
*/
void SV_LastScores_f (void);
static void SVC_LastScores (void)
{
	if(!(int)sv_allowlastscores.value)
		return;

	SV_BeginRedirect (RD_PACKET);
	SV_LastScores_f ();
	SV_EndRedirect ();
}

/*
===================
SVC_DemoList
SVC_DemoListRegex
===================
*/
void SV_DemoList_f (void);
static void SVC_DemoList (void)
{
	SV_BeginRedirect (RD_PACKET);
	SV_DemoList_f ();
	SV_EndRedirect ();
}
void SV_DemoListRegex_f (void);
static void SVC_DemoListRegex (void)
{
	SV_BeginRedirect (RD_PACKET);
	SV_DemoListRegex_f ();
	SV_EndRedirect ();
}

/*
===================
SV_CheckLog

===================
*/
#define	LOG_HIGHWATER	(MAX_DATAGRAM - 128)
#define	LOG_FLUSH		10*60
static void SV_CheckLog (void)
{
	sizebuf_t *sz;


	sz = &svs.log[svs.logsequence&1];

	// bump sequence if allmost full, or ten minutes have passed and
	// there is something still sitting there
	if (sz->cursize > LOG_HIGHWATER
	        || (realtime - svs.logtime > LOG_FLUSH && sz->cursize) )
	{
		// swap buffers and bump sequence
		svs.logtime = realtime;
		svs.logsequence++;
		sz = &svs.log[svs.logsequence&1];
		sz->cursize = 0;
		Con_DPrintf ("beginning fraglog sequence %i\n", svs.logsequence);
	}

}

/*
================
SVC_Log

Responds with all the logged frags for ranking programs.
If a sequence number is passed as a parameter and it is
the same as the current sequence, an A2A_NACK will be returned
instead of the data.
================
*/
static void SVC_Log (void)
{
	char data[MAX_DATAGRAM+64];
	int seq;


	if (Cmd_Argc() == 2)
		seq = Q_atoi(Cmd_Argv(1));
	else
		seq = -1;

	if (seq == svs.logsequence-1 || !logs[FRAG_LOG].sv_logfile)
	{	// they already have this data, or we aren't logging frags
		data[0] = A2A_NACK;
		NET_SendPacket (1, data, net_from);
		return;
	}

	Con_DPrintf ("sending log %i to %s\n", svs.logsequence-1, NET_AdrToString(net_from));

	snprintf (data, MAX_DATAGRAM + 64, "stdlog %i\n", svs.logsequence-1);
	strlcat (data, (char *)svs.log_buf[((svs.logsequence-1)&1)], MAX_DATAGRAM + 64);

	NET_SendPacket (strlen(data)+1, data, net_from);
}

/*
================
SVC_Uptime

Responds with the server's uptime in total minutes
================
*/
void SVC_Uptime (void)
{
	char	data[32];
	time_t	now = time(NULL);

	if (!svs.online_since)	// could this happen?
		return;

	now = now - svs.online_since;

	Q_snprintf (data, sizeof(data), "%d\n", (int)(now/60));

	NET_SendPacket (strlen(data), data, net_from);
}

/*
================
SVC_Ping

Just responds with an acknowledgement
================
*/
static void SVC_Ping (void)
{
	char data = A2A_ACK;

	NET_SendPacket (1, &data, net_from);
}

/*
=================
SVC_GetChallenge

Returns a challenge number that can be used
in a subsequent client_connect command.
We do this to prevent denial of service attacks that
flood the server with invalid connection IPs.  With a
challenge, they must give a valid IP address.
=================
*/
static void SVC_GetChallenge (void)
{
	int oldestTime, oldest, i;
	char buf[256], *over;


	oldest = 0;
	oldestTime = 0x7fffffff;

	// see if we already have a challenge for this ip
	for (i = 0 ; i < MAX_CHALLENGES ; i++)
	{
		if (NET_CompareBaseAdr (net_from, svs.challenges[i].adr))
			break;
		if (svs.challenges[i].time < oldestTime)
		{
			oldestTime = svs.challenges[i].time;
			oldest = i;
		}
	}

	if (i == MAX_CHALLENGES)
	{
		// overwrite the oldest
		svs.challenges[oldest].challenge = (rand() << 16) ^ rand();
		svs.challenges[oldest].adr = net_from;
		svs.challenges[oldest].time = realtime;
		i = oldest;
	}

	// send it back
	snprintf(buf, sizeof(buf), "%c%i", S2C_CHALLENGE, svs.challenges[i].challenge);
	over = buf + strlen(buf) + 1;

#ifdef PROTOCOL_VERSION_FTE
	//tell the client what fte extensions we support
	if (svs.fteprotocolextensions)
	{
		int lng;

		lng = LittleLong(PROTOCOL_VERSION_FTE);
		memcpy(over, &lng, sizeof(int)); // FIXME sizeof(int) or sizeof(long)???
		over += 4;

		lng = LittleLong(svs.fteprotocolextensions);
		memcpy(over, &lng, sizeof(int));
		over += 4;
	}
#endif
	// don't let them in if they're banned
	if (IF_FilterPacket(net_from, IF_BAN))
	{
		SV_SendBan ();	// tell them we aren't listening...
		return;
	}

	Netchan_OutOfBand(net_from, over-buf, buf);
}

static qbool ValidateUserInfo (char *userinfo)
{
	while (*userinfo)
	{
		if (*userinfo == '\\')
			userinfo++;

		if (*userinfo++ == '\\')
			return false;
		while (*userinfo && *userinfo != '\\')
			userinfo++;
	}
	return true;
}

/*
==================
SVC_DirectConnect

A connection request that did not come from the master
==================
*/
int SV_VIPbyIP(netadr_t adr);
int SV_VIPbyPass (char *pass);
void Cmd_TokenizeString_FTE (char *text, qbool expandmacros, qbool qctokenize);
extern void MVD_PlayerReset(int player);

#ifdef USE_PR2
extern char clientnames[MAX_CLIENTS][CLIENT_NAME_LEN];
#endif
extern char *shortinfotbl[];
static void SVC_DirectConnect (void)
{
	int clients, spectators, vips, qport, version1, challenge, i, edictnum;
	qbool spass = false, vip, spectator;
	client_t *cl, *newcl;
	char userinfo[1024];
	char *s, *key;
	netadr_t adr;
	edict_t *ent;
#ifdef PROTOCOL_VERSION_FTE
	unsigned int protextsupported = 0;
#endif


	version1 = Q_atoi(Cmd_Argv(1));
	if (version1 != PROTOCOL_VERSION)
	{
//		Netchan_OutOfBandPrint (net_from, "%c\nServer is version %4.2f.\n", A2C_PRINT, QW_VERSION);
		Netchan_OutOfBandPrint (net_from, "%c\nServer is version " QW_VERSION ".\n", A2C_PRINT);
		Con_Printf ("* rejected connect from version %i\n", version1);
		return;
	}

	qport = Q_atoi(Cmd_Argv(2));

	challenge = Q_atoi(Cmd_Argv(3));

	// note an extra byte is needed to replace spectator key
	strlcpy (userinfo, Cmd_Argv(4), sizeof(userinfo));
	if (!ValidateUserInfo(userinfo))
	{
		Netchan_OutOfBandPrint (net_from, "%c\nInvalid userinfo. Restart your qwcl\n", A2C_PRINT);
		return;
	}

#ifdef PROTOCOL_VERSION_FTE

//
// WARNING: WARNING: WARNING: using Cmd_TokenizeString() so do all Cmd_Argv() above.
//
#ifdef xavior_method
	while(!msg_badread)
	{
                char *s;
                s = MSG_ReadStringLine();
		Cmd_TokenizeString(s);
                Con_Printf("%s tokenized to: \"%s\" \"%s\"\n", s, Cmd_Argv(0), Cmd_Argv(1));
                Con_Printf("vals: %i %i\n", Q_atoi(Cmd_Argv(0)), Q_atoi(Cmd_Argv(1)));
		switch(Q_atoi(Cmd_Argv(0)))
		{
		case PROTOCOL_VERSION_FTE:
			protextsupported = Q_atoi(Cmd_Argv(1));
			Con_Printf("Client supports 0x%x fte extensions\n", protextsupported);
			break;
                default:
                        Con_Printf("Client supports unrecognised extensions\n");
                        break;
		}
	}

	msg_badread = false;
#else
	while(!msg_badread)
	{
		Cmd_TokenizeString(MSG_ReadStringLine());
		switch(Q_atoi(Cmd_Argv(0)))
		{
		case PROTOCOL_VERSION_FTE:
			protextsupported = Q_atoi(Cmd_Argv(1));
			Con_Printf("Client supports 0x%x fte extensions\n", protextsupported);//Con_DPrintf
			break;
		}
	}

	msg_badread = false;
#endif
#endif

	// see if the challenge is valid
	for (i = 0; i < MAX_CHALLENGES; i++)
	{
		if (NET_CompareBaseAdr (net_from, svs.challenges[i].adr))
		{
			if (challenge == svs.challenges[i].challenge)
				break;		// good
			Netchan_OutOfBandPrint (net_from, "%c\nBad challenge.\n", A2C_PRINT);
			return;
		}
	}
	if (i == MAX_CHALLENGES)
	{
		Netchan_OutOfBandPrint (net_from, "%c\nNo challenge for address.\n", A2C_PRINT);
		return;
	}

	// check for password or spectator_password
	s = Info_ValueForKey (userinfo, "spectator");

	vip = false;
	if (s[0] && strcmp(s, "0"))
	{
		spass = true;

		if ((vip = SV_VIPbyPass(s)) == 0 &&
			(vip = SV_VIPbyPass(Info_ValueForKey (userinfo, "password"))) == 0) // first the pass, then ip
			vip = SV_VIPbyIP(net_from);

		if (spectator_password.string[0] &&
		        strcasecmp(spectator_password.string, "none") &&
		        strcmp(spectator_password.string, s) )
		{	// failed
			spass = false;
		}

		if (!vip && !spass)
		{
			Con_Printf ("%s:spectator password failed\n", NET_AdrToString (net_from));
			Netchan_OutOfBandPrint (net_from, "%c\nrequires a spectator password\n\n", A2C_PRINT);
			return;
		}

		Info_RemoveKey (userinfo, "spectator"); // remove passwd
		Info_SetValueForStarKey (userinfo, "*spectator", "1", MAX_INFO_STRING);
		if ((spectator = Q_atoi(s)) == 0)
			spectator = true;
	}
	else
	{
		s = Info_ValueForKey (userinfo, "password");
		if ((vip = SV_VIPbyPass(s)) == 0) // first the pass, then ip
			vip = SV_VIPbyIP(net_from);

		if (!vip && password.string[0] &&
		        strcasecmp(password.string, "none") &&
		        strcmp(password.string, s) )
		{
			Con_Printf ("%s:password failed\n", NET_AdrToString (net_from));
			Netchan_OutOfBandPrint (net_from, "%c\nserver requires a password\n\n", A2C_PRINT);
			return;
		}
		spectator = false;
	}

	Info_RemoveKey (userinfo, "password"); // remove passwd

	adr = net_from;

	// if there is already a slot for this ip, reuse (changed from drop) it
	for (i = 0, cl = svs.clients; i < MAX_CLIENTS; i++, cl++)
	{
		if (cl->state == cs_free)
			continue;
		if (NET_CompareBaseAdr (adr, cl->netchan.remote_address) &&
			(cl->netchan.qport == qport || adr.port == cl->netchan.remote_address.port))
		{
			//bliP: reconnect limit
			if ((realtime - cl->lastconnect) < sv_reconnectlimit.value * 1000)
			{
				Con_Printf ("%s:reconnect rejected: too soon\n", NET_AdrToString (adr));
				return;
			}
			//<-

			if (cl->state == cs_connected || cl->state == cs_preconnected)
			{
				Con_Printf("%s:dup connect\n", NET_AdrToString (adr));
				// if client core dumped, then allow to reuse slot (EXPERIMENTAL)
				SV_DropClient (cl);
				SV_ClearReliable (cl);	// don't send the disconnect
				//return;
			}

			Con_Printf ("%s:reconnect\n", NET_AdrToString (adr));
			if (cl->state == cs_spawned)
			{
				SV_DropClient (cl);
				SV_ClearReliable (cl);	// don't send the disconnect
			}
			cl->state = cs_free;
			break;
		}
	}

	// count up the clients and spectators
	clients = spectators = vips = 0;
	newcl = NULL;
	for (i = 0, cl = svs.clients; i < MAX_CLIENTS; i++, cl++)
	{
		if (cl->state == cs_free)
		{
			if (!newcl)
				memset ((newcl = cl), 0, sizeof(*newcl)); // grab first available slot
			continue;
		}

		if (cl->vip)
			vips++;
		if (cl->spectator)
		{
			if (!cl->vip)
				spectators++;
		}
		else
			clients++;
	}

	// if at server limits, refuse connection
	if ((int)maxclients.value > MAX_CLIENTS)
		Cvar_SetValue (&maxclients, MAX_CLIENTS);
	if ((int)maxspectators.value > MAX_CLIENTS)
		Cvar_SetValue (&maxspectators, MAX_CLIENTS);
	if ((int)maxvip_spectators.value > MAX_CLIENTS)
		Cvar_SetValue (&maxvip_spectators, MAX_CLIENTS);

	if ((int)maxspectators.value + maxclients.value > MAX_CLIENTS)
		Cvar_SetValue (&maxspectators, MAX_CLIENTS - (int)maxclients.value);
	if ((int)maxspectators.value + maxclients.value + maxvip_spectators.value > MAX_CLIENTS)
		Cvar_SetValue (&maxvip_spectators, MAX_CLIENTS - (int)maxclients.value - (int)maxspectators.value);

	if ( (vip && spectator && vips >= (int)maxvip_spectators.value &&
	        (spectators >= (int)maxspectators.value || !spass))
	        || (!vip && spectator && (spectators >= (int)maxspectators.value || !spass))
	        || (!spectator && clients >= (int)maxclients.value)
                || !newcl)
	{
		Sys_Printf ("%s:full connect\n", NET_AdrToString (adr));
		if (spectator == 2 && (int)maxvip_spectators.value > vips && !vip)
		{
			newcl->rip_vip = 1; // yet can be connected if realip is on vip list
			newcl->vip = 1; // :)
		}
		else
		{
			if (!spectator && spectators < (int)maxspectators.value &&
				( (Q_atoi(Info_ValueForKey (userinfo, "svf")) & SVF_SPEC_ONFULL &&
				   (int)sv_forcespec_onfull.value == 2) || (int)sv_forcespec_onfull.value == 1))
			{
				Netchan_OutOfBandPrint (adr, "%c\nserver is full: connecting as spectator\n", A2C_PRINT);
				Info_SetValueForStarKey (userinfo, "*spectator", "1", MAX_INFO_STRING);
				spectator = true;
			}
			else
			{
				Netchan_OutOfBandPrint (adr, "%c\nserver is full\n\n", A2C_PRINT);
				return;
			}
		}
	}

	// build a new connection
	// accept the new client
	// this is the only place a client_t is ever initialized
	//memset (newcl, 0, sizeof(*newcl));
	//we first set newcl->rip_vip and then clean newcl - nice! :-[=]
	newcl->userid = SV_GenerateUserID();

#ifdef PROTOCOL_VERSION_FTE
	newcl->fteprotocolextensions = protextsupported;
#endif

	strlcpy (newcl->userinfo, userinfo, sizeof(newcl->userinfo));

	for (i = 0; i < UPDATE_BACKUP; i++)
		newcl->frames[i].entities.entities = cl_entities[newcl-svs.clients][i];

	Netchan_OutOfBandPrint (adr, "%c", S2C_CONNECTION );

	Netchan_Setup (&newcl->netchan, adr, qport);

	newcl->state = cs_preconnected;

	newcl->datagram.allowoverflow = true;
	newcl->datagram.data = newcl->datagram_buf;
	newcl->datagram.maxsize = sizeof(newcl->datagram_buf);

	// spectator mode can ONLY be set at join time
	newcl->spectator = spectator;
	newcl->vip = vip;

	// extract extensions mask
	newcl->extensions = Q_atoi(Info_ValueForKey(newcl->userinfo, "*z_ext"));
	Info_RemoveKey (newcl->userinfo, "*z_ext");

#ifdef VWEP_TEST
	newcl->extensions |= atoi(Info_ValueForKey(newcl->userinfo, "*vwtest")) ? Z_EXT_VWEP : 0;
	Info_RemoveKey (newcl->userinfo, "*vwtest");
#endif

	edictnum = (newcl-svs.clients)+1;
	ent = EDICT_NUM(edictnum);
	ent->free = false;
	newcl->edict = ent;
#ifdef USE_PR2
	//restore pointer to client name
	//for -progtype 0 (VM_NONE) names stored in clientnames array
	//for -progtype 1 (VM_NATIVE) and -progtype 2 (VM_BYTECODE)  stored in mod memory
	if(sv_vm)
		newcl->name = PR2_GetString(ent->v.netname);
	else
		newcl->name = clientnames[edictnum - 1];
	memset(newcl->name, 0, CLIENT_NAME_LEN);
#endif

	if (vip) s = va("%d", vip);
	else s = "";

	Info_SetValueForStarKey (newcl->userinfo, "*VIP", s, MAX_INFO_STRING);
	// copy the most important userinfo into userinfoshort

	// parse some info from the info strings
	SV_ExtractFromUserinfo (newcl, true);

	for (i = 0; shortinfotbl[i] != NULL; i++)
	{
		s = Info_ValueForKey(newcl->userinfo, shortinfotbl[i]);
		Info_SetValueForStarKey (newcl->userinfoshort, shortinfotbl[i], s, MAX_INFO_STRING);
	}

	// move star keys to infoshort
	for (i= 1; (key = Info_KeyNameForKeyNum(newcl->userinfo, i)) != NULL; i++)
	{
		if (key[0] != '*')
			continue;

		s = Info_ValueForKey(newcl->userinfo, key);
		Info_SetValueForStarKey (newcl->userinfoshort, key, s, MAX_INFO_STRING);
	}

	// JACK: Init the floodprot stuff.
	for (i=0; i<10; i++)
		newcl->whensaid[i] = 0.0;
	newcl->whensaidhead = 0;
	newcl->lockedtill = 0;
	newcl->disable_updates_stop = -1.0; // Vladis

	newcl->realip_num = rand();

	//bliP: init
	newcl->spec_print = (int)sv_specprint.value;
	newcl->logincount = 0;
	//<-

	// call the progs to get default spawn parms for the new client
#ifdef USE_PR2
	if ( sv_vm )
		PR2_GameSetNewParms();
	else
#endif
		PR_ExecuteProgram (pr_global_struct->SetNewParms);
	for (i=0 ; i<NUM_SPAWN_PARMS ; i++)
		newcl->spawn_parms[i] = (&pr_global_struct->parm1)[i];

	// mvd/qtv related stuff
	// Well, here is a chance what player connect after demo recording started,
	// so demo.info[edictnum - 1].model == player_model so SV_MVDWritePackets() will not wrote player model index,
	// so client during playback this demo will got invisible model, because model index will be 0.
	// Fixing that.
	// Btw, struct demo contain different client specific structs, may be they need clearing too, not sure.
	// Also, we have Cmd_Join_f()/Cmd_Observe_f() which have close behaviour to SVC_DirectConnect(),
	// so I put same demo fix in mentioned functions too.
	MVD_PlayerReset(NUM_FOR_EDICT(newcl->edict) - 1);

	/*
	if (newcl->vip && newcl->spectator)
		Con_Printf ("VIP spectator %s connected\n", newcl->name);
	else if (newcl->spectator)
		Con_Printf ("Spectator %s connected\n", newcl->name);
	else
		Con_DPrintf ("Client %s connected\n", newcl->name);
	*/
	newcl->sendinfo = true;
}

static int char2int (int c)
{
	if (c <= '9' && c >= '0')
		return c - '0';
	else if (c <= 'f' && c >= 'a')
		return c - 'a' + 10;
	else if (c <= 'F' && c >= 'A')
		return c - 'A' + 10;
	return 0;
}
/*
 * rcon_bandlim() - check for rcon requests bandwidth limit
 *
 *      From kernel of the FreeBSD 4.10 release:
 *      sys/netinet/ip_icmp.c(846): int badport_bandlim(int which);
 *
 *	Return false if it is ok to check rcon_password, true if we have
 *	hit our bandwidth limit and it is not ok.
 *
 *	If sv_rconlim.value is <= 0, the feature is disabled and false is returned.
 *
 *	Note that the printing of the error message is delayed so we can
 *	properly print the rcon limit error rate that the system was trying to do
 *	(i.e. 22000/100 rcon pps, etc...).  This can cause long delays in printing
 *	the 'final' error, but it doesn't make sense to solve the printing
 *	delay with more complex code.
 */
static qbool rcon_bandlim (void)
{
	static double lticks = 0;
	static int lpackets = 0;

	/*
	 * Return ok status if feature disabled or argument out of
	 * ranage.
	 */

	if ((int)sv_rconlim.value <= 0)
		return false;

	/*
	 * reset stats when cumulative dt exceeds one second.
	 */

	if (realtime - lticks > 1.0)
	{
		if (lpackets > (int)sv_rconlim.value)
			Sys_Printf("WARNING: Limiting rcon response from %d to %d rcon pequests per second from %s\n",
			           lpackets, (int)sv_rconlim.value, NET_AdrToString(net_from));
		lticks = realtime;
		lpackets = 0;
	}

	/*
	 * bump packet count
	 */

	if (++lpackets > (int)sv_rconlim.value)
		return true;

	return false;
}
//bliP: master rcon/logging ->
int Rcon_Validate (char *client_string, char *password1)
{
	time_t server_time, client_time = 0;
	double difftime_server_client;
	unsigned int i;


	if (rcon_bandlim())
		return 0;

	if (!strlen (password1))
		return 0;

	if ((int)sv_crypt_rcon.value)
	{
		time(&server_time);
		for (i = 0; i < sizeof(client_time) * 2; i += 2)
		{
			//			Sys_Printf("1) %c%c, %d\n", (Cmd_Argv(1) + DIGEST_SIZE * 2)[i], (Cmd_Argv(1) + DIGEST_SIZE * 2)[i + 1], client_time);

			client_time +=  (char2int((unsigned char)(Cmd_Argv(1) + DIGEST_SIZE * 2)[i]) << (4 + i * 4)) +
			                (char2int((unsigned char)(Cmd_Argv(1) + DIGEST_SIZE * 2)[i + 1]) << (i * 4));
			//			Sys_Printf("2) %d, %d, %d\n", c1 << (4 + i * 4), c2 << (i * 4), client_time);
		}
		difftime_server_client = difftime(server_time, client_time);
		//		Sys_Printf("3) %f, %d, %d\n", difftime_server_client, client_time, server_time);

		if (!(int)sv_timestamplen.value)
			if (difftime_server_client > (double) sv_timestamplen.value ||
			        difftime_server_client < - (double) sv_timestamplen.value)
				return 0;
		SHA1_Init();
		SHA1_Update(Cmd_Argv(0));
		SHA1_Update(" ");
		SHA1_Update(password1);
		SHA1_Update(Cmd_Argv(1) + DIGEST_SIZE * 2);
		SHA1_Update(" ");
		//		SHA1_Update(va("%s %s%s ", Cmd_Argv(0), password1, Cmd_Argv(1) + DIGEST_SIZE * 2));
		for (i = 2; (int) i < Cmd_Argc(); i++)
		{
			//			SHA1_Update(va("%s ", Cmd_Argv(i)));
			SHA1_Update(Cmd_Argv(i));
			SHA1_Update(" ");
		}
		//		sha1 = SHA1_Final();
		//Con_Printf("client_string = %s\nserver_string = %s\nsha1 = %s\n", client_string, server_string, sha1);
		//Con_Printf("server_string_len = %d, strlen(server_string) = %d\n", server_string_len, strlen(server_string));
		if (strncmp (Cmd_Argv(1), SHA1_Final(), DIGEST_SIZE * 2))
			return 0;
	}
	else
		if (strcmp (Cmd_Argv(1), password1))
			return 0;
	return 1;
}

int Master_Rcon_Validate (void)
{
	int i, client_string_len = Cmd_Argc() + 1;
	char *client_string;


	for (i = 0; i < Cmd_Argc(); ++i)
		client_string_len += strlen(Cmd_Argv(i));
	client_string = (char *) Q_malloc (client_string_len);
	*client_string = 0;
	for (i = 0; i < Cmd_Argc(); ++i)
	{
		strlcat(client_string, Cmd_Argv(i), client_string_len);
		strlcat(client_string, " ", client_string_len);
	}
	//	Sys_Printf("client_string = %s\nclient_string_len = %d, strlen(client_string) = %d\n",
	//		client_string, client_string_len, strlen(client_string));
	i = Rcon_Validate (client_string, master_rcon_password);
	Q_free(client_string);
	return i;
}

// QW262 -->
void SV_Admin_f (void)
{
	client_t *cl;
	int i = 0;
	
	if (Cmd_Argc () == 2 && !strcmp (Cmd_Argv (1), "off") && WatcherId &&
			NET_CompareAdr (WatcherId->netchan.remote_address, net_from))
	{
		Con_Printf ("Rcon Watch stopped\n");
		WatcherId = NULL;
		return;
	}

	if (WatcherId)
		Con_Printf ("Rcon Watch is already being made by %s\n", WatcherId->name);
	else
	{
		for (cl = svs.clients; i < MAX_CLIENTS; i++, cl++)
		{
			if (cl->state != cs_spawned)
				continue;

			if (NET_CompareAdr (cl->netchan.remote_address, net_from))
				break;
		}

		if (i == MAX_CLIENTS)
		{
			Con_Printf ("You are not connected to server!\n");
			return;
		}

		WatcherId = cl;
		Con_Printf ("Rcon Watch started for %s\n", cl->name);
	}
}
// <-- QW262

/*
===============
SVC_RemoteCommand

A client issued an rcon command.
Shift down the remaining args
Redirect all printfs
===============
*/
static void SVC_RemoteCommand (char *remote_command)
{
#ifdef MVDSV_RCON
	int			i;
	char		str[1024];
	char		plain[32];
	char		*p;
	unsigned char *hide;
	client_t	*cl;
	qbool		admin_cmd = false;
	qbool		do_cmd = false;
	qbool		bad_cmd = false;
	qbool		banned = false;


	if (Rcon_Validate (remote_command, master_rcon_password))
	{
		if (SV_FilterPacket()) //banned players can't use rcon, but we log it
			banned = true;
		else
			do_cmd = true;
	}
	else if (Rcon_Validate (remote_command, rcon_password.string))
	{
		admin_cmd = true;
		if (SV_FilterPacket()) //banned players can't use rcon, but we log it
		{
			bad_cmd = true;
			banned = true;
		}
		else
		{
			//
			// the following line prevents exploits like:
			//   coop rm
			//   $coop . *
			// which expands to:
			//   rm . *

			Cmd_ExpandString (remote_command, str); // check *expanded* command

			//
			// since the execution parser is not case sensitive, we
			// must check not only for chmod, but also CHMOD, ChmoD, etc.
			// so we lowercase the whole temporary line before checking

			// VVD: strcmp => strcasecmp and we don't need to do this (yes?)
			//for(i = 0; str[i]; i++)
			//	str[i] = (char)tolower(str[i]);

			Cmd_TokenizeString (str);		// must check *all* tokens, because
											// a command/var may not be the first
											// token -- example: "" ls .

			//
			// normal rcon can't use these commands
			//
			// NOTE: this would still be vulnerable to semicolons if
			// they were still allowed, so keep that in mind before
			// re-enabling them

			for (i = 2; i < Cmd_Argc(); i++)
			{
				const char *tstr = Cmd_Argv(i);

				if(!tstr[0]) // skip leading empty tokens
					continue;

				if (!strcasecmp(tstr, "rm") ||
					!strcasecmp(tstr, "rmdir") ||
					!strcasecmp(tstr, "ls") ||
					!strcasecmp(tstr, "chmod") ||
					!strcasecmp(tstr, "sv_admininfo") ||
					!strcasecmp(tstr, "if") ||
					!strcasecmp(tstr, "localcommand") ||
					!strcasecmp(tstr, "sv_crypt_rcon") ||
					!strcasecmp(tstr, "sv_timestamplen") ||
					!strncasecmp(tstr, "log", 3) ||
					!strcasecmp(tstr, "sys_command_line")
					)
				{
					bad_cmd = true;
				}
				break; // stop after first non-empty token
			}

			Cmd_TokenizeString (remote_command); // restore original tokens
		}
		do_cmd = !bad_cmd;
	}

	//find player name if rcon came from someone on server
	plain[0] = '\0';
	for (i = 0, cl = svs.clients; i < MAX_CLIENTS; i++, cl++)
	{
		if (cl->state == cs_free)
			continue;
//#ifdef USE_PR2
//		if (cl->isBot)
//			continue;
//#endif
		if (!NET_CompareBaseAdr(net_from, cl->netchan.remote_address))
			continue;
		if (cl->netchan.remote_address.port != net_from.port)
			continue;
		strlcpy(plain, cl->name, sizeof(plain));
		Q_normalizetext((unsigned char*)plain);
	}

	if (do_cmd)
	{
		if (!(int)sv_crypt_rcon.value)
		{
			hide = net_message.data + 9;
			p = admin_cmd ? rcon_password.string : master_rcon_password;
			while (*p)
			{
				p++;
				*hide++ = '*';
			}
		}

		if (plain[0])
			SV_Write_Log(RCON_LOG, 1, va("Rcon from %s (%s): %s\n", NET_AdrToString(net_from), plain, net_message.data + 4));
		else
			SV_Write_Log(RCON_LOG, 1, va("Rcon from %s: %s\n", NET_AdrToString(net_from), net_message.data + 4));

		Con_Printf("Rcon from %s:\n%s\n", NET_AdrToString(net_from), net_message.data + 4);

		SV_BeginRedirect(RD_PACKET);

		str[0] = '\0';
		for (i = 2; i < Cmd_Argc(); i++)
		{
			strlcat(str, Cmd_Argv(i), sizeof(str));
			strlcat(str, " ", sizeof(str));
		}

		Cmd_ExecuteString(str);
	}
	else
	{
		if (admin_cmd && !(int)sv_crypt_rcon.value)
		{
			hide = net_message.data + 9;
			p = admin_cmd ? rcon_password.string : master_rcon_password;
			while (*p)
			{
				p++;
				*hide++ = '*';
			}
		}

		Con_Printf ("Bad rcon from %s: %s\n", NET_AdrToString(net_from), net_message.data + 4);

		if (!banned)
		{
			if (plain[0])
				SV_Write_Log(RCON_LOG, 1, va("Bad rcon from %s (%s):\n%s\n", NET_AdrToString(net_from), plain, net_message.data + 4));
			else
				SV_Write_Log(RCON_LOG, 1, va("Bad rcon from %s:\n%s\n",	NET_AdrToString (net_from), net_message.data + 4));
		}
		else
		{
			SV_Write_Log(RCON_LOG, 1, va("Rcon from banned IP: %s: %s\n", NET_AdrToString(net_from), net_message.data + 4));
			SV_SendBan();
			return;
		}

		SV_BeginRedirect (RD_PACKET);
		if (admin_cmd)
			Con_Printf ("Command not valid.\n");
		else
			Con_Printf ("Bad rcon_password.\n");
	}
	SV_EndRedirect ();
#else
	cvar_t			*var;
	int					i, r, len = 0;
	char			*p;
	char			remaining[GENERIC_BUFFER];
	unsigned char	*hide;

	r = eRcon_Validate (Cmd_Argv(1));

	//we dont want banned people using rcon with passive filtering.
	if (IF_FilterPacket (net_from, IF_BAN))
	{
		SV_SendBan ();	// tell them we aren't listening...
		return;
	}

	if (r == 0)
	{
		Com_Log (RCONLOG, LO_PRINT|LO_FORMAT|LO_TIMESTAMP, 
			"bad rcon from %s:\n%s\n", 
			NET_AdrToString (net_from), net_message.data+4);

		SV_BeginRedirect(RD_PACKET);
		Con_Printf ("Bad rcon_password.\n");
		SV_EndRedirect ();
		return;
	}

	if (!Cmd_Argv(2)[0]) 
		return;

	if (r != MAIN_RCON) 
	{
       // mask the rcon password accessability security
		hide = net_message.data + 9;
		p = pRconCurPos->password;
		while (*p) 
		{
			p++;
			*hide++ = '*';
		}
		if (Cmd_Exists (Cmd_Argv(2))) 
		{
			if (!(Rcon_CmdValidate(Cmd_Argv(2),r))) 
			{

				SV_BeginRedirect (RD_PACKET);
				Con_Printf ("No access.\n");
				SV_EndRedirect ();
				Com_Log (RCONLOG, LO_PRINT|LO_FORMAT|LO_TIMESTAMP, "level %i restricted command from %s (%s):\n%s\n",
					r, NET_AdrToString (net_from), pRconCurPos->name, net_message.data+4);
				pRconCurPos = NULL;
				return;
			}
		}
		else if (Rcon_CvarValidate(Cmd_Argv(2),r) == 2) 
		{
			SV_BeginRedirect (RD_PACKET);
			Con_Printf ("no access.\n");
			SV_EndRedirect ();
			Com_Log (RCONLOG, LO_PRINT|LO_FORMAT|LO_TIMESTAMP, "level %i restricted variable from %s (%s):\n%s\n",
				r, NET_AdrToString (net_from), pRconCurPos->name, net_message.data+4);
			pRconCurPos = NULL;
			return;
		}
		else if (Rcon_CvarValidate(Cmd_Argv(2),r) > 1)
		{
			SV_BeginRedirect (RD_PACKET);
			Con_Printf ("Unknown command.\n");
			SV_EndRedirect ();
			Com_Log (RCONLOG, LO_PRINT|LO_FORMAT|LO_TIMESTAMP, "level %i invalid command from %s (%s):\n%s\n",
				r, NET_AdrToString (net_from), pRconCurPos->name, net_message.data+4);
			return;	
		}
	Com_Log (RCONLOG, LO_PRINT|LO_FORMAT|LO_TIMESTAMP, "level %i rcon from %s (%s):\n%s\n",
		r, NET_AdrToString (net_from), pRconCurPos->name, net_message.data+4);
	}
	else // MAIN_RCON
	{
		// mask the rcon password for extra safety
		hide = net_message.data + 9;
		p = rcon_password.string;
		while (*p)
		{
			p++;
			*hide++ = '*';
		}
		Com_Log (RCONLOG, LO_PRINT|LO_FORMAT|LO_TIMESTAMP, "main rcon from %s:\n%s\n",
			NET_AdrToString (net_from), net_message.data+4);
	}

	remaining[0] = 0;

	var = Cvar_Find (Cmd_Argv(2), false);

	strncat (remaining, Cmd_Argv(2), sizeof(remaining));
	strncat (remaining, " ", sizeof (remaining - 1));
	if (var && (Cmd_Argc() > 3))
		strncat (remaining, "\"", sizeof (remaining - 2));


	for (i = 3; i<Cmd_Argc(); i++)
	{
		if (i != 3)
				strncat (remaining, " ", sizeof (remaining) - len - 2);
			strncat (remaining, Cmd_Argv (i), sizeof (remaining) - len - 1);
			len += strlen (Cmd_Argv (i)) + 1;	// +1 for " "
	}

	if (var && (Cmd_Argc() > 3))
		strcat (remaining,"\"");

	SV_BeginRedirect (RD_PACKET);

	Cmd_ExecuteString (remaining);

	SV_EndRedirect ();

#endif
}
//<-

static void SVC_IP(void)
{
	int num;
	client_t *client;

	if (Cmd_Argc() < 3)
		return;

	num = Q_atoi(Cmd_Argv(1));

	if (num < 0 || num >= MAX_CLIENTS)
		return;

	client = &svs.clients[num];
	if (client->state != cs_preconnected)
		return;

	// prevent cheating
	if (client->realip_num != Q_atoi(Cmd_Argv(2)))
		return;

	// don't override previously set ip
	if (client->realip.ip.ip[0])
		return;

	client->realip = net_from;

	// if banned drop
	if (SV_FilterPacket()/* && !client->vip*/)
		SV_DropClient(client);

	// EQDS ban check (FIXME: remove SV_FilterPacket()?)
	 //	we dont want banned people bypassing a ban
	if (IF_FilterPacket (net_from, IF_BAN)) 
	{
		Com_Log (CLIENTLOG, LO_PRINT|LO_FORMAT|LO_TIMESTAMP,
			"client %s (%s*) tried to bypass ban\n", 
			client->name, NET_BaseAdrToString(client->realip));
		SV_SendBan ();	// tell them we aren't listening...
		SV_DropClient(client); // get rid of the #$%
		return;
	}
	return;
}


/*
=================
SV_ConnectionlessPacket

A connectionless packet has four leading 0xff
characters to distinguish it from a game channel.
Clients that are in the game can still send
connectionless packets.
=================
*/

static void SV_ConnectionlessPacket (void)
{
	char	*s;
	char	*c;

	MSG_BeginReading ();
	MSG_ReadLong ();		// skip the -1 marker

	s = MSG_ReadStringLine ();

	Cmd_TokenizeString (s);

	c = Cmd_Argv(0);

	if (!strcmp(c, "ping") || ( c[0] == A2A_PING && (c[1] == 0 || c[1] == '\n')) )
		SVC_Ping ();
	else if (c[0] == A2A_ACK && (c[1] == 0 || c[1] == '\n') )
		Con_Printf ("A2A_ACK from %s\n", NET_AdrToString (net_from));
	else if (!strcmp(c,"status"))
		SVC_Status ();
	else if (!strcmp(c,"log"))
		SVC_Log ();
	else if (!strcmp(c, "rcon"))
		SVC_RemoteCommand (s);
	else if (!strcmp(c, "ip"))
		SVC_IP();
 //	plexi: connectionless uptime
	else if (!strcmp(c, "uptime")) 
	{
		SVC_Uptime ();
		return;
	}
	else if (!strcmp(c,"connect"))
		SVC_DirectConnect ();
	else if (!strcmp(c,"getchallenge"))
		SVC_GetChallenge ();
	else if (!strcmp(c,"lastscores"))
		SVC_LastScores ();
	else if (!strcmp(c,"dlist"))
		SVC_DemoList ();
	else if (!strcmp(c,"dlistr"))
		SVC_DemoListRegex ();
	else if (!strcmp(c,"dlistregex"))
		SVC_DemoListRegex ();
	else if (!strcmp(c,"demolist"))
		SVC_DemoList ();
	else if (!strcmp(c,"demolistr"))
		SVC_DemoListRegex ();
	else if (!strcmp(c,"demolistregex"))
		SVC_DemoListRegex ();
	else
		Con_Printf ("bad connectionless packet from %s:\n%s\n"
		            , NET_AdrToString (net_from), s);

	// dont let banned newbs try to crap on us
	if (IF_FilterPacket (net_from, IF_BAN)) 
	{
		SV_SendBan ();	// tell them we aren't listening...
		return; 
	}
}

/*
==============================================================================

PACKET FILTERING


You can add or remove addresses from the filter list with:

addip <ip>
removeip <ip>

The ip address is specified in dot format, and any unspecified digits will match any value, so you can specify an entire class C network with "addip 192.246.40".

Removeip will only remove an address specified exactly the same way.  You cannot addip a subnet, then removeip a single host.

listip
Prints the current list of filters.

writeip
Dumps "addip <ip>" commands to listip.cfg so it can be execed at a later date.  The filter lists are not saved and restored by default, because I beleive it would cause too much confusion.

filterban <0 or 1>

If 1 (the default), then ip addresses matching the current list will be prohibited from entering the game.  This is the default setting.

If 0, then only addresses matching the list will be allowed.  This lets you easily set up a private game, or a game that only allows players from your local network.


==============================================================================
*/


/*typedef struct
{
	unsigned	mask;
	unsigned	compare;
	int			level;
} ipfilter_t;
*/

#define	MAX_IPFILTERS	1024

ipfilter_t	ipfilters[MAX_IPFILTERS];
int		numipfilters;

ipfilter_t	ipvip[MAX_IPFILTERS];
int		numipvips;

//bliP: cuff, mute ->
penfilter_t	penfilters[MAX_PENFILTERS];
int		numpenfilters;
//<-

cvar_t	filterban = {"filterban", "1"};

/*
=================
StringToFilter
=================
*/
qbool StringToFilter (char *s, ipfilter_t *f)
{
	char	num[128];
	int		i, j;
	byte	b[4];
	byte	m[4];

	for (i=0 ; i<4 ; i++)
	{
		b[i] = 0;
		m[i] = 0;
	}

	for (i=0 ; i<4 ; i++)
	{
		if (*s < '0' || *s > '9')
		{
			//Con_Printf ("Bad filter address: %s\n", s);
			return false;
		}

		j = 0;
		while (*s >= '0' && *s <= '9')
		{
			num[j++] = *s++;
		}
		num[j] = 0;
		b[i] = Q_atoi(num);
		if (b[i] != 0)
			m[i] = 255;

		if (!*s)
			break;
		s++;
	}

	f->mask = *(unsigned *)m;
	f->compare = *(unsigned *)b;

	return true;
}

/*
=================
SV_AddIPVIP_f
=================
*/
static void SV_AddIPVIP_f (void)
{
	int		i, l;
	ipfilter_t f;

	if (!StringToFilter (Cmd_Argv(1), &f))
	{
		Con_Printf ("Bad filter address: %s\n", Cmd_Argv(1));
		return;
	}

	l = Q_atoi(Cmd_Argv(2));

	if (l < 1) l = 1;

	for (i=0 ; i<numipvips ; i++)
		if (ipvip[i].compare == 0xffffffff || (ipvip[i].mask == f.mask
		                                       && ipvip[i].compare == f.compare))
			break;		// free spot
	if (i == numipvips)
	{
		if (numipvips == MAX_IPFILTERS)
		{
			Con_Printf ("VIP spectator IP list is full\n");
			return;
		}
		numipvips++;
	}

	ipvip[i] = f;
	ipvip[i].level = l;
}

/*
=================
SV_RemoveIPVIP_f
=================
*/
static void SV_RemoveIPVIP_f (void)
{
	ipfilter_t	f;
	int		i, j;

	if (!StringToFilter (Cmd_Argv(1), &f))
	{
		Con_Printf ("Bad filter address: %s\n", Cmd_Argv(1));
		return;
	}
	for (i=0 ; i<numipvips ; i++)
		if (ipvip[i].mask == f.mask
		        && ipvip[i].compare == f.compare)
		{
			for (j=i+1 ; j<numipvips ; j++)
				ipvip[j-1] = ipvip[j];
			numipvips--;
			Con_Printf ("Removed.\n");
			return;
		}
	Con_Printf ("Didn't find %s.\n", Cmd_Argv(1));
}

/*
=================
SV_ListIP_f
=================
*/
static void SV_ListIPVIP_f (void)
{
	int		i;
	byte	b[4];

	Con_Printf ("VIP list:\n");
	for (i=0 ; i<numipvips ; i++)
	{
		*(unsigned *)b = ipvip[i].compare;
		Con_Printf ("%3i.%3i.%3i.%3i   level %d\n", b[0], b[1], b[2], b[3], ipvip[i].level);
	}
}

/*
=================
SV_WriteIPVIP_f
=================
*/
static void SV_WriteIPVIP_f (void)
{
	FILE	*f;
	char	name[MAX_OSPATH];
	byte	b[4];
	int		i;

	snprintf (name, MAX_OSPATH, "%s/vip_ip.cfg", fs_gamedir);

	Con_Printf ("Writing %s.\n", name);

	f = fopen (name, "wb");
	if (!f)
	{
		Con_Printf ("Couldn't open %s\n", name);
		return;
	}

	for (i=0 ; i<numipvips ; i++)
	{
		*(unsigned *)b = ipvip[i].compare;
		fprintf (f, "vip_addip %i.%i.%i.%i %d\n", b[0], b[1], b[2], b[3], ipvip[i].level);
	}

	fclose (f);
}


/*
=================
SV_AddIP_f
=================
*/
static void SV_AddIP_f (void)
{
	int		i;
	double	t = 0;
	char	*s;
	time_t	long_time = time(NULL);
	ipfilter_t f;
	ipfiltertype_t ipft = ipft_ban; // default is ban

	if (!StringToFilter (Cmd_Argv(1), &f) || f.compare == 0)
	{
		Con_Printf ("Bad filter address: %s\n", Cmd_Argv(1));
		return;
	}

	s = Cmd_Argv(2);
	if ( !s[0] || !strcmp(s, "ban"))
		ipft = ipft_ban;
	else if (!strcmp(s, "safe"))
		ipft = ipft_safe;
	else {
		Con_Printf ("Wrong filter type %s, use ban or safe\n", Cmd_Argv(2));
		return;
	}

	s = Cmd_Argv(3);
	if (long_time > 0) {
		if (*s == '+')     // "addip 127.0.0.1 ban +10" will ban for 10 seconds from current time
			s++;
		else
			long_time = 0; // "addip 127.0.0.1 ban 1234567" will ban for some seconds since 00:00:00 GMT, January 1, 1970

		t = (sscanf(s, "%lf", &t) == 1) ? t + long_time : 0;
	}

	f.time = t;
	f.type = ipft;

	for (i=0 ; i<numipfilters ; i++)
		if (ipfilters[i].compare == 0xffffffff || (ipfilters[i].mask == f.mask
		        && ipfilters[i].compare == f.compare))
			break;		// free spot
	if (i == numipfilters)
	{
		if (numipfilters == MAX_IPFILTERS)
		{
			Con_Printf ("IP filter list is full\n");
			return;
		}
		numipfilters++;
	}

	ipfilters[i] = f;
}

/*
=================
SV_RemoveIP_f
=================
*/
static void SV_RemoveIP_f (void)
{
	ipfilter_t	f;
	int			i, j;

	if (!StringToFilter (Cmd_Argv(1), &f))
	{
		Con_Printf ("Bad filter address: %s\n", Cmd_Argv(1));
		return;
	}

	for (i=0 ; i<numipfilters ; i++)
		if (ipfilters[i].mask == f.mask
		        && ipfilters[i].compare == f.compare)
		{
			for (j=i+1 ; j<numipfilters ; j++)
				ipfilters[j-1] = ipfilters[j];
			numipfilters--;
			Con_Printf ("Removed.\n");
			return;
		}
	Con_Printf ("Didn't find %s.\n", Cmd_Argv(1));
}

/*
=================
SV_ListIP_f
=================
*/
static void SV_ListIP_f (void)
{
	time_t	long_time = time(NULL);
	int		i;
	byte	b[4];

	Con_Printf ("Filter list:\n");
	for (i=0 ; i<numipfilters ; i++)
	{
		*(unsigned *)b = ipfilters[i].compare;
		Con_Printf ("%3i.%3i.%3i.%3i | ", b[0], b[1], b[2], b[3]);
		switch((int)ipfilters[i].type){
			case ipft_ban:  Con_Printf (" ban"); break;
			case ipft_safe: Con_Printf ("safe"); break;
			default: Con_Printf ("unkn"); break;
		}
		if (ipfilters[i].time)
			Con_Printf (" | %i s", (int)(ipfilters[i].time-long_time));
		Con_Printf ("\n");
	}
}

/*
=================
SV_WriteIP_f
=================
*/
static void SV_WriteIP_f (void)
{
	FILE	*f;
	char	name[MAX_OSPATH], *s;
	byte	b[4];
	int		i;

	snprintf (name, MAX_OSPATH, "%s/listip.cfg", fs_gamedir);

	Con_Printf ("Writing %s.\n", name);

	f = fopen (name, "wb");
	if (!f)
	{
		Con_Printf ("Couldn't open %s\n", name);
		return;
	}

	// write safe filters first
	for (i=0 ; i<numipfilters ; i++)
	{
		if(ipfilters[i].type != ipft_safe)
			continue;

		*(unsigned *)b = ipfilters[i].compare;
		fprintf (f, "addip %i.%i.%i.%i safe %.0f\n", b[0], b[1], b[2], b[3], ipfilters[i].time);
	}

	for (i=0 ; i<numipfilters ; i++)
	{
		if(ipfilters[i].type == ipft_safe)
			continue; // ignore safe, we already save it

		switch((int)ipfilters[i].type){
			case ipft_ban:  s = " ban"; break;
			case ipft_safe: s = "safe"; break;
			default: s = "unkn"; break;
		}
		*(unsigned *)b = ipfilters[i].compare;
		fprintf (f, "addip %i.%i.%i.%i %s %.0f\n", b[0], b[1], b[2], b[3], s, ipfilters[i].time);
	}

	fclose (f);
}

/*
=================
SV_SendBan
=================
*/
void SV_SendBan (void)
{
	char		data[128];

	data[0] = data[1] = data[2] = data[3] = 0xff;
	data[4] = A2C_PRINT;
	data[5] = 0;
	strlcat (data, "\nbanned.\n", sizeof(data));

	NET_SendPacket (strlen(data), data, net_from);
}

/*
=================
SV_FilterPacket
=================
*/
qbool SV_FilterPacket (void)
{
	int		i;
	unsigned	in;

	in = *(unsigned *)net_from.ip.ip;

	for (i=0 ; i<numipfilters ; i++)
		if ( ipfilters[i].type == ipft_ban && (in & ipfilters[i].mask) == ipfilters[i].compare )
			return (int)filterban.value;

	return !(int)filterban.value;
}

// { server internal BAN support

#define AF_REAL_ADMIN  (1<<1) // pass/vip granted admin (real admin in terms of ktpro)

void Do_BanList(ipfiltertype_t ipft)
{
	time_t	long_time = time(NULL);
	int		i;
	byte	b[4];

	for (i=0 ; i<numipfilters ; i++)
	{
		if (ipfilters[i].type != ipft)
			continue;

		*(unsigned *)b = ipfilters[i].compare;
		Con_Printf ("%3i|%3i.%3i.%3i.%3i", i, b[0], b[1], b[2], b[3]);
		switch((int)ipfilters[i].type){
			case ipft_ban:  Con_Printf ("| ban"); break;
			case ipft_safe: Con_Printf ("|safe"); break;
			default: Con_Printf ("|unkn"); break;
		}

		if (ipfilters[i].time) {
			long df = ipfilters[i].time-long_time;
			long d, h, m, s;
			d = df / (60*60*24);
			df -= d * 60*60*24;
			h = df / (60*60);
			df -= h * 60*60;
			m = df /  60;
			df -= m * 60;
			s = df;

			if (d)
				Con_Printf ("|%4ldd:%2ldh", d, h);
			else if (h)
				Con_Printf ("|%4ldh:%2ldm", h, m);
			else
				Con_Printf ("|%4ldm:%2lds", m, s);
		}
		else
			Con_Printf ("|permanent");
		Con_Printf ("\n");
	}
}

void SV_BanList (void)
{
	unsigned char blist[64] = "Ban list:", id[64] = "id", ipmask[64] = "ip mask", type[64] = "type", expire[64] = "expire";

	if (numipfilters < 1) {
		Con_Printf ("Ban list: empty\n");
		return;
	}

	Con_Printf ("%s\n"
				"\235\236\236\236\236\236\236\236\236\236\236\236\236\236\236\236"
				"\236\236\236\236\236\236\236\236\236\236\236\236\236\236\236\236\236\237\n"
				"%3.3s|%15.15s|%4.4s|%9.9s\n", 
				Q_redtext(blist), Q_redtext(id), Q_redtext(ipmask), Q_redtext(type), Q_redtext(expire));

	Do_BanList(ipft_safe);
	Do_BanList(ipft_ban);
}

qbool SV_CanAddBan (ipfilter_t *f)
{
	int i;

	if (f->compare == 0)
		return false;
	
	for (i=0 ; i<numipfilters ; i++)
		if (ipfilters[i].mask == f->mask && ipfilters[i].compare == f->compare && ipfilters[i].type == ipft_safe)
			return false; // can't add filter f because present "safe" filter

	return true;
}

void SV_RemoveBansIPFilter (int i)
{
	for (; i + 1 < numipfilters; i++)
		ipfilters[i] = ipfilters[i + 1];

	numipfilters--;
}

void SV_CleanBansIPList (void)
{
	time_t	long_time = time(NULL);
	int     i;

	for (i = 0; i < numipfilters;)
	{
		if (ipfilters[i].time && ipfilters[i].time <= long_time)
		{
			SV_RemoveBansIPFilter (i);
		}
		else
			i++;
	}
}

void SV_Cmd_Ban_f(void)
{
	edict_t	*ent;
	eval_t *val;
	double		d;
	int			i, j, t;
	client_t	*cl;
	ipfilter_t  f;
	int			uid;
	int			c;
	char		reason[80] = "", arg2[32], arg2c[sizeof(arg2)], *s;

	// set up the edict
	ent = sv_client->edict;

// ============
// get ADMIN rights from MOD via "mod_admin" field, mod MUST export such field if wanna server ban support
// ============

	val =
#ifdef USE_PR2
	    PR2_GetEdictFieldValue(ent, "mod_admin");
#else
	    GetEdictFieldValue(ent, "mod_admin");
#endif
	if (!val || !(val->_int & AF_REAL_ADMIN) ) {
		Con_Printf("You are not an admin\n");
		return;
	}

	c = Cmd_Argc ();
	if (c < 3)
	{
		Con_Printf("usage: cmd ban <id/nick> <time<s m h d>> [reason]\n");
		return;
	}

	uid = Q_atoi(Cmd_Argv(1));

	strlcpy(arg2, Cmd_Argv(2), sizeof(arg2));

	// sscanf safe here since sizeof(arg2) == sizeof(arg2c), right?
	if (sscanf(arg2, "%d%s", &t, arg2c) != 2 || strlen(arg2c) != 1) {
		Con_Printf("ban: wrong time arg\n");
		return;
	}

	d = t = bound(0, t, 999);
	switch(arg2c[0]) {
		case 's': break; // seconds is seconds
		case 'm': d *= 60; break; // 60 seconds per minute
		case 'h': d *= 60*60; break; // 3600 seconds per hour
		case 'd': d *= 60*60*24; break; // 86400 seconds per day
		default:
		Con_Printf("ban: wrong time arg\n");
		return;
	}

	for (i = 0, cl = svs.clients; i < MAX_CLIENTS; i++, cl++)
	{
		if (!cl->state)
			continue;
		if (cl->userid == uid || !strcmp(Cmd_Argv(1), cl->name))
		{
			if (c > 3) // serve reason arguments
			{
				strlcpy (reason, " (", sizeof(reason));
				for (j=3 ; j<c; j++)
				{
					strlcat (reason, Cmd_Argv(j), sizeof(reason)-4);
					if (j < c-1)
						strlcat (reason, " ", sizeof(reason)-4);
				}
				if (strlen(reason) < 3)
					reason[0] = '\0';
				else
					strlcat (reason, ")", sizeof(reason));
			}

			s = NET_BaseAdrToString(cl->netchan.remote_address);
			if (!StringToFilter (s, &f))
			{
				Con_Printf ("ban: bad ip address: %s\n", s);
				return;
			}

			if (!SV_CanAddBan(&f))
			{
				Con_Printf ("ban: can't ban such ip: %s\n", s);
				return;
			}

			SV_BroadcastPrintf (PRINT_HIGH, "%s was banned for %d%s%s\n", cl->name, t, arg2c, reason);

			Cbuf_AddText(va("addip %s ban %s%.0lf\n", s, d ? "+" : "", d));
			Cbuf_AddText("writeip\n");
			return;
		}
	}

	Con_Printf ("Couldn't find user %s\n", Cmd_Argv(1));
}

void SV_Cmd_Banip_f(void)
{
	edict_t	*ent;
	eval_t *val;
	byte	b[4];
	double		d;
	int			c, t;
	ipfilter_t  f;
	char		arg2[32], arg2c[sizeof(arg2)];

	// set up the edict
	ent = sv_client->edict;

// ============
// get ADMIN rights from MOD via "mod_admin" field, mod MUST export such field if wanna server ban support
// ============

	val =
#ifdef USE_PR2
	    PR2_GetEdictFieldValue(ent, "mod_admin");
#else
	    GetEdictFieldValue(ent, "mod_admin");
#endif
	if (!val || !(val->_int & AF_REAL_ADMIN) ) {
		Con_Printf("You are not an admin\n");
		return;
	}

	c = Cmd_Argc ();
	if (c < 3)
	{
		Con_Printf("usage: cmd banip <ip> <time<s m h d>>\n");
		return;
	}

	if (!StringToFilter (Cmd_Argv(1), &f))
	{
		Con_Printf ("ban: bad ip address: %s\n", Cmd_Argv(1));
		return;
	}

	if (!SV_CanAddBan(&f))
	{
		Con_Printf ("ban: can't ban such ip: %s\n", Cmd_Argv(1));
		return;
	}

	strlcpy(arg2, Cmd_Argv(2), sizeof(arg2));

	// sscanf safe here since sizeof(arg2) == sizeof(arg2c), right?
	if (sscanf(arg2, "%d%s", &t, arg2c) != 2 || strlen(arg2c) != 1) {
		Con_Printf("ban: wrong time arg\n");
		return;
	}

	d = t = bound(0, t, 999);
	switch(arg2c[0]) {
		case 's': break; // seconds is seconds
		case 'm': d *= 60; break; // 60 seconds per minute
		case 'h': d *= 60*60; break; // 3600 seconds per hour
		case 'd': d *= 60*60*24; break; // 86400 seconds per day
		default:
		Con_Printf("ban: wrong time arg\n");
		return;
	}

	*(unsigned *)b = f.compare;
	SV_BroadcastPrintf (PRINT_HIGH, "%3i.%3i.%3i.%3i was banned for %d%s\n", b[0], b[1], b[2], b[3], t, arg2c);

	Cbuf_AddText(va("addip %i.%i.%i.%i ban %s%.0lf\n", b[0], b[1], b[2], b[3], d ? "+" : "", d));
	Cbuf_AddText("writeip\n");
}

void SV_Cmd_Banremove_f(void)
{
	edict_t	*ent;
	eval_t *val;
	byte	b[4];
	int		id;

	// set up the edict
	ent = sv_client->edict;

// ============
// get ADMIN rights from MOD via "mod_admin" field, mod MUST export such field if wanna server ban support
// ============

	val =
#ifdef USE_PR2
	    PR2_GetEdictFieldValue(ent, "mod_admin");
#else
	    GetEdictFieldValue(ent, "mod_admin");
#endif
	if (!val || !(val->_int & AF_REAL_ADMIN) ) {
		Con_Printf("You are not an admin\n");
		return;
	}

	if (Cmd_Argc () < 2)
	{
		Con_Printf("usage: cmd banrem [banid]\n");
		SV_BanList();
		return;
	}

	id = Q_atoi(Cmd_Argv(1));

	if (id < 0 || id >= numipfilters) {
		Con_Printf ("Wrong ban id: %d\n", id);
		return;
	}

	if (ipfilters[id].type == ipft_safe) {
		Con_Printf ("Can't remove such ban with id: %d\n", id);
		return;
	}

	*(unsigned *)b = ipfilters[id].compare;
	SV_BroadcastPrintf (PRINT_HIGH, "%3i.%3i.%3i.%3i was unbanned\n", b[0], b[1], b[2], b[3]);

	SV_RemoveBansIPFilter (id);
	Cbuf_AddText("writeip\n");
}

// } server internal BAN support

/*
=================
SV_VIPbyIP
=================
*/
int SV_VIPbyIP (netadr_t adr)
{
	int		i;
	unsigned	in;

	in = *(unsigned *)adr.ip.ip;

	for (i=0 ; i<numipvips ; i++)
		if ( (in & ipvip[i].mask) == ipvip[i].compare)
			return ipvip[i].level;

	return 0;
}

/*
=================
SV_VIPbyPass
=================
*/
int SV_VIPbyPass (char *pass)
{
	qbool use_value = false;
	int vip_value[MAX_ARGS];
	int i;

	if (!vip_password.string[0] || !strcasecmp(vip_password.string, "none"))
		return 0;

	if (vip_values.string[0]) {
		use_value = true;
		// 2VVD: vip_password count may be not equal vip_values count, what we must do in this case?
		memset((void*)vip_value, 0, sizeof(vip_value));
		Cmd_TokenizeString(vip_values.string);
		for (i = 0; i < Cmd_Argc(); i++)
			vip_value[i] = atoi(Cmd_Argv(i));
	}

	Cmd_TokenizeString(vip_password.string);

	for (i = 0; i < Cmd_Argc(); i++)
		if (!strcmp(Cmd_Argv(i), pass) && strcasecmp(Cmd_Argv(i), "none"))
			return (use_value ? vip_value[i] : i+1);

	return 0;
}

static char *DecodeArgs(char *args)
{
	static char string[1024];
	char *p, key[32], *s, *value, ch;
	extern char chartbl2[256];// defined in pr_cmds.c

	string[0] = 0;
	p = string;

	while (*args)
	{
		// skip whitespaces
		while (*args && *args <= 32)
			*p++ = *args++;

		if (*args == '\"')
		{
			do *p++ = *args++; while (*args && *args != '\"');
			*p++ = '\"';
			if (*args)
				args++;
		}
		else if (*args == '@' || *args == '$')
		{
			// get the key and read value from localinfo
			ch = *args;
			s = key;
			args++;
			while (*args > 32)
				*s++ = *args++;
			*s = 0;

			if ((value = Info_ValueForKey (svs.info, key)) == NULL || !*value)
				value = Info_ValueForKey(localinfo, key);

			*p++ = '\"';
			if (ch == '$')
			{
				if (value) while (*value)
						*p++ = chartbl2[(byte)*value++];
			}
			else
			{
				if (value) while (*value)
						*p++ = *value++;
			}
			*p++ = '\"';
		}
		else while (*args > 32)
				*p++ = *args++;
	}

	*p = 0;

	return string;
}

void SV_Script_f (void)
{
	char *path, *p;
	extern redirect_t sv_redirected;

	if (Cmd_Argc() < 2)
	{
		Con_Printf("usage: script <path> [<args>]\n");
		return;
	}

	path = Cmd_Argv(1);

	//bliP: 24/9 need subdirs here ->
	if (!strncmp(path, "../", 3) || !strncmp(path, "..\\", 3))
		path += 3;

	if (strstr(path, ".."))
	{
		Con_Printf("Invalid path.\n");
		return;
	}
	//<-

	path = Cmd_Argv(1);

	p = Cmd_Args();
	while (*p > 32)
		p++;
	while (*p && *p <= 32)
		p++;

	p = DecodeArgs(p);

	if (sv_redirected != RD_MOD)
		Sys_Printf("Running %s.qws\n", path);

	Sys_Script(path, va("%d %s", sv_redirected, p));

}

//============================================================================

//bliP: cuff, mute ->
void SV_RemoveIPFilter (int i)
{
	for (; i + 1 < numpenfilters; i++)
		penfilters[i] = penfilters[i + 1];

	numpenfilters--;
}

static void SV_CleanIPList (void)
{
	int     i;

	for (i = 0; i < numpenfilters;)
	{
		if (penfilters[i].time && (penfilters[i].time <= realtime))
		{
			SV_RemoveIPFilter (i);
		}
		else
			i++;
	}
}

static qbool SV_IPCompare (byte *a, byte *b)
{
	int i;

	for (i = 0; i < 1; i++)
		if (((unsigned int *)a)[i] != ((unsigned int *)b)[i])
			return false;

	return true;
}

static void SV_IPCopy (byte *dest, byte *src)
{
	int i;

	for (i = 0; i < 1; i++)
		((unsigned int *)dest)[i] = ((unsigned int *)src)[i];
}

void SV_SavePenaltyFilter (client_t *cl, filtertype_t type, double pentime)
{
	int i;

	if (pentime < realtime)   // no point
		return;

	for (i = 0; i < numpenfilters; i++)
		if (SV_IPCompare (penfilters[i].ip, cl->realip.ip.ip)	&& penfilters[i].type == type)
		{
			return;
		}

	if (numpenfilters == MAX_IPFILTERS)
	{
		return;
	}

	SV_IPCopy (penfilters[numpenfilters].ip, cl->realip.ip.ip);
	penfilters[numpenfilters].time = pentime;
	penfilters[numpenfilters].type = type;
	numpenfilters++;
}

double SV_RestorePenaltyFilter (client_t *cl, filtertype_t type)
{
	int i;
	double time1 = 0.0;

	// search for existing penalty filter of same type
	for (i = 0; i < numpenfilters; i++)
	{
		if (type == penfilters[i].type && SV_IPCompare (cl->realip.ip.ip, penfilters[i].ip))
		{
			time1 = penfilters[i].time;
			SV_RemoveIPFilter (i);
			return time1;
		}
	}
	return time1;
}

cvar_t con_cleanout = {"con_cleanout","1"};
cvar_t con_cleanin = {"con_cleanin","1"};
cvar_t con_color = {"con_color","1"};
cvar_t con_prompt = {"con_prompt","1"};
cvar_t con_talk = {"con_talk","0"};
cvar_t con_cleanlog = {"con_cleanlog","1"};
//<-

//============================================================================

/*
=================
SV_ReadPackets
=================
*/
static void SV_ReadPackets (void)
{
	client_t *cl;
	int qport;
	int i;


	// first deal with delayed packets from connected clients
	for (i = 0, cl=svs.clients; i < MAX_CLIENTS; i++, cl++)
	{
		if (cl->state == cs_free)
			continue;

		net_from = cl->netchan.remote_address;

		while (cl->packets && (realtime - cl->packets->time >= cl->delay || sv.paused))
		{
			SZ_Clear(&net_message);
			SZ_Write(&net_message, cl->packets->msg.data, cl->packets->msg.cursize);
			SV_ExecuteClientMessage(cl);
			SV_FreeHeadDelayedPacket(cl);
		}
	}

	// now deal with new packets
	while (NET_GetPacket())
	{
		if (SV_FilterPacket ())
		{
			SV_SendBan ();	// tell them we aren't listening...
			continue;
		}

		// check for connectionless packet (0xffffffff) first
		if (*(int *)net_message.data == -1)
		{
			SV_ConnectionlessPacket ();
			continue;
		}

		// read the qport out of the message so we can fix up
		// stupid address translating routers
		MSG_BeginReading ();
		MSG_ReadLong (); // sequence number
		MSG_ReadLong (); // sequence number
		qport = MSG_ReadShort () & 0xffff;

		// check which client sent this packet
		for (i=0, cl=svs.clients ; i<MAX_CLIENTS ; i++,cl++)
		{
			if (cl->state == cs_free)
				continue;
			if (!NET_CompareBaseAdr (net_from, cl->netchan.remote_address))
				continue;
			if (cl->netchan.qport != qport)
				continue;
			if (cl->netchan.remote_address.port != net_from.port)
			{
				Con_DPrintf ("SV_ReadPackets: fixing up a translated port\n");
				cl->netchan.remote_address.port = net_from.port;
			}

			break;
		}

		if (i == MAX_CLIENTS)
			continue;

		// ok, we know who sent this packet, but do we need to delay executing it?
		if (cl->delay > 0)
		{
			if (!svs.free_packets) // packet has to be dropped..
				break;

			// insert at end of list
			if (!cl->packets) {
				cl->last_packet = cl->packets = svs.free_packets;
			} else {
				// this works because '=' associates from right to left
				cl->last_packet = cl->last_packet->next = svs.free_packets;
			}

			svs.free_packets = svs.free_packets->next;
			cl->last_packet->next = NULL;

			cl->last_packet->time = realtime;
			SZ_Clear(&cl->last_packet->msg);
			SZ_Write(&cl->last_packet->msg, net_message.data, net_message.cursize);
		}
		else
		{
			SV_ExecuteClientMessage (cl);
		}
	}
}


/*
==================
SV_CheckTimeouts

If a packet has not been received from a client in timeout.value
seconds, drop the conneciton.

When a client is normally dropped, the client_t goes into a zombie state
for a few seconds to make sure any final reliable message gets resent
if necessary
==================
*/
static void SV_CheckTimeouts (void)
{
	int i, nclients;
	float droptime;
	client_t *cl;


	droptime = realtime - timeout.value;
	nclients = 0;

	for (i=0,cl=svs.clients ; i<MAX_CLIENTS ; i++,cl++)
	{
#ifdef USE_PR2
		if( cl->isBot )
			continue;
#endif
		if (cl->state >= cs_preconnected /*|| cl->state == cs_spawned*/)
		{
			if (!cl->spectator)
				nclients++;
			if (cl->netchan.last_received < droptime)
			{
				SV_BroadcastPrintf (PRINT_HIGH, "%s timed out\n", cl->name);
				SV_DropClient (cl);
				cl->state = cs_free;	// don't bother with zombie state
			}
			if (!cl->logged)
				SV_LoginCheckTimeOut(cl);
		}
		if (cl->state == cs_zombie &&
		        realtime - cl->connection_started > zombietime.value)
		{
			cl->state = cs_free;	// can now be reused
		}
	}
	if (sv.paused && !nclients)
	{
		// nobody left, unpause the server
		if (GE_ShouldPause) {
			pr_global_struct->time = sv.time;
			pr_global_struct->self = EDICT_TO_PROG(sv.edicts);
			G_FLOAT(OFS_PARM0) = 0 /* newstate = false */;
			PR_ExecuteProgram (GE_ShouldPause);
			if (!G_FLOAT(OFS_RETURN))
				return;		// progs said don't unpause
		}
		SV_TogglePause("Pause released since no players are left.\n");
	}
}

/*
===================
SV_GetConsoleCommands

Add them exactly as if they had been typed at the console
===================
*/
static void SV_GetConsoleCommands (void)
{
	char	*cmd;

	while (1)
	{
		cmd = Sys_ConsoleInput ();
		if (!cmd)
			break;
		Cbuf_AddText (cmd);
		Cbuf_AddText ("\n");
	}
}


/*
===================
SV_BoundRate
===================
*/
int SV_BoundRate (qbool dl, int rate)
{
	if (!rate)
		rate = 2500;
	if (dl)
	{
		if (!(int)sv_maxdownloadrate.value && (int)sv_maxrate.value && rate > (int)sv_maxrate.value)
			rate = (int)sv_maxrate.value;

		if (sv_maxdownloadrate.value && rate > sv_maxdownloadrate.value)
			rate = (int)sv_maxdownloadrate.value;
	}
	else
		if ((int)sv_maxrate.value && rate > (int) sv_maxrate.value)
			rate = (int)sv_maxrate.value;

	if (rate < 500)
		rate = 500;
	if (rate > 100000)
		rate = 100000;

	return rate;
}


/*
===================
SV_CheckVars

===================
*/

static void SV_CheckVars (void)
{
	static char pw[MAX_INFO_STRING]="", spw[MAX_INFO_STRING]="", vspw[MAX_INFO_STRING]="";
	static float old_maxrate = 0, old_maxdlrate = 0;
	int v;

	// check password and spectator_password
	if (strcmp(password.string, pw) ||
		strcmp(spectator_password.string, spw) || strcmp(vip_password.string, vspw))
	{
		strlcpy (pw, password.string, MAX_INFO_STRING);
		strlcpy (spw, spectator_password.string, MAX_INFO_STRING);
		strlcpy (vspw, vip_password.string, MAX_INFO_STRING);
		Cvar_Set (&password, pw);
		Cvar_Set (&spectator_password, spw);
		Cvar_Set (&vip_password, vspw);

		v = 0;
		if (pw && pw[0] && strcmp(pw, "none"))
			v |= 1;
		if (spw && spw[0] && strcmp(spw, "none"))
			v |= 2;
		if (vspw && vspw[0] && strcmp(vspw, "none"))
			v |= 4;

		Con_DPrintf ("Updated needpass.\n");
		if (!v)
			Info_SetValueForKey (svs.info, "needpass", "", MAX_SERVERINFO_STRING);
		else
			Info_SetValueForKey (svs.info, "needpass", va("%i",v), MAX_SERVERINFO_STRING);
	}

	// check sv_maxrate
	if ((int)sv_maxrate.value != old_maxrate || (int)sv_maxdownloadrate.value != old_maxdlrate )
	{
		client_t	*cl;
		int			i;
		char		*val;

		old_maxrate = (int)sv_maxrate.value;
		old_maxdlrate = (int)sv_maxdownloadrate.value;

		for (i=0, cl = svs.clients ; i<MAX_CLIENTS ; i++, cl++)
		{
			if (cl->state < cs_preconnected)
				continue;

			if (cl->download)
			{
				val = Info_ValueForKey (cl->userinfo, "drate");
				if (!*val)
					val = Info_ValueForKey (cl->userinfo, "rate");
			}
			else
				val = Info_ValueForKey (cl->userinfo, "rate");

			cl->netchan.rate = 1.0 / SV_BoundRate (cl->download != NULL, Q_atoi(val));
		}
	}
}

static void PausedTic (void)
{
	if (GE_PausedTic) {
		G_FLOAT(OFS_PARM0) = Sys_DoubleTime() - sv.pausedsince;
		PR_ExecuteProgram (GE_PausedTic);
	}
}

static void KtproAirstepFix(void)
{
// ktpro is old school, do not allow pm_airstep
	extern cvar_t	pm_airstep;	

	if (is_ktpro && pm_airstep.value) {
		Con_Printf("Forcing pm_airstep to 0 in ktpro\n");
		Cvar_SetValue (&pm_airstep, 0);
	}
}

/*
==================
SV_Frame

==================
*/
void SV_Map (qbool now);
void SV_Frame (double time1)
{
	static double start, end;
	double demo_start, demo_end;


	start = Sys_DoubleTime ();
	svs.stats.idle += start - end;

	// keep the random time dependent
	rand ();

	// do not allow pm_airstep it ktpro
	KtproAirstepFix();

	// decide the simulation time
	if (!sv.paused)
	{
		realtime += time1;
		sv.time += time1;
	}

	// check timeouts
	SV_CheckTimeouts ();

	//bliP: cuff, mute ->
	// clean out expired cuffs/mutes
	SV_CleanIPList ();
	//<-

	// clean out bans
	SV_CleanBansIPList ();

 // execute timers or delete ones that are ready to die		// EQDS
	SV_CheckTimers ();

	// toggle the log buffer if full
	SV_CheckLog ();

	SV_MVDStream_Poll();

	// check for commands typed to the host
	SV_GetConsoleCommands ();

	// process console commands

	Cbuf_Execute ();
	// check for map change;
	SV_Map(true);

	SV_CheckVars ();

	// get packets
	SV_ReadPackets ();

	// move autonomous things around if enough time has passed
	if (!sv.paused)
		SV_Physics ();
	else
		PausedTic ();

	// send messages back to the clients that had packets read this frame
	SV_SendClientMessages ();

	demo_start = Sys_DoubleTime ();
	SV_SendDemoMessage();
	demo_end = Sys_DoubleTime ();
	svs.stats.demo += demo_end - demo_start;

	// send a heartbeat to the master if needed
	Master_Heartbeat ();

	// collect timing statistics
	end = Sys_DoubleTime ();
	svs.stats.active += end-start;
	if (++svs.stats.count == STATFRAMES)
	{
		svs.stats.latched_active = svs.stats.active;
		svs.stats.latched_idle = svs.stats.idle;
		svs.stats.latched_packets = svs.stats.packets;
		svs.stats.latched_demo = svs.stats.demo;
		svs.stats.active = 0;
		svs.stats.idle = 0;
		svs.stats.packets = 0;
		svs.stats.count = 0;
		svs.stats.demo = 0;
	}
}

/*
===============
SV_InitLocal
===============
*/
void Cmd_AddLvl (char *cmd_name, xcommand_t function, int level);
void SV_InitLocal (void)
{
	int		i, len;
	extern	cvar_t	sv_maxvelocity;
	extern	cvar_t	sv_gravity;
	extern	cvar_t	sv_stopspeed;
	extern	cvar_t	sv_spectatormaxspeed;
	extern	cvar_t	sv_accelerate;
	extern	cvar_t	sv_airaccelerate;
	extern	cvar_t	sv_wateraccelerate;
	extern	cvar_t	sv_friction;
	extern	cvar_t	sv_waterfriction;
	extern	cvar_t	sv_nailhack;

	extern	cvar_t	pm_airstep;
	//extern	cvar_t	pm_pground;
	//extern	cvar_t	pm_slidefix;
	extern	cvar_t	pm_ktjump;
	//extern	cvar_t	pm_bunnyspeedcap;
	packet_t *packet_freeblock; // initialise delayed packet free block


	Cvar_Init ();

	SV_InitOperatorCommands	();
	SV_UserInit ();

	Cvar_Register (&sv_getrealip);
	Cvar_Register (&sv_maxdownloadrate);
	Cvar_Register (&sv_serverip);
	Cvar_Register (&sv_forcespec_onfull);
	Cvar_Register (&sv_cpserver);
	Cvar_Register (&rcon_password);
	Cvar_Register (&password);
	Cvar_Register (&sv_hashpasswords);
	//Added by VVD {
	Cvar_Register (&sv_crypt_rcon);
	Cvar_Register (&sv_timestamplen);
	Cvar_Register (&sv_rconlim);

	Cvar_Register (&telnet_password);
	Cvar_Register (&telnet_log_level);
	Cvar_Register (&not_auth_timeout);
	Cvar_Register (&auth_timeout);

	Cvar_Register (&frag_log_type);
	Cvar_Register (&qconsole_log_say);
	Cvar_Register (&sv_use_dns);

	for (i = 0, len = 1; i < com_argc; i++)
		len += strlen(com_argv[i]) + 1;
	sys_command_line.string = (char *) Q_malloc (len);
	sys_command_line.string[0] = 0;
	for (i = 0; i < com_argc; i++)
	{
		strlcat(sys_command_line.string, com_argv[i], len);
		strlcat(sys_command_line.string, " ", len);
	}
	Cvar_Register (&sys_command_line);

	snprintf(full_version, SIZEOF_FULL_VERSION, FULL_VERSION "\n" BUILD_DATE "\n", build_number());
	Cvar_Register (&version);
	//Added by VVD }
	Cvar_Register (&spectator_password);
	Cvar_Register (&vip_password);
	Cvar_Register (&vip_values);

	Cvar_Register (&sv_nailhack);

	Cvar_Register (&maxfps);

	Cvar_Register (&sv_mintic);
	Cvar_Register (&sv_maxtic);
	Cvar_Register (&sys_select_timeout);
	Cvar_Register (&sys_restart_on_error);

	Cvar_Register (&skill);
	Cvar_Register (&coop);

	Cvar_Register (&fraglimit);
	Cvar_Register (&timelimit);
	Cvar_Register (&teamplay);
	Cvar_Register (&samelevel);
	Cvar_Register (&maxclients);
	Cvar_Register (&maxspectators);
	Cvar_Register (&maxvip_spectators);
	Cvar_Register (&hostname);
	Cvar_Register (&deathmatch);
	Cvar_Register (&spawn);
	Cvar_Register (&watervis);
	Cvar_Register (&serverdemo);
	Cvar_Register (&sv_paused);

	Cvar_Register (&developer);

	Cvar_Register (&timeout);
	Cvar_Register (&zombietime);

	Cvar_Register (&sv_maxvelocity);
	Cvar_Register (&sv_gravity);
	Cvar_Register (&sv_stopspeed);
	Cvar_Register (&sv_maxspeed);
	Cvar_Register (&sv_spectatormaxspeed);
	Cvar_Register (&sv_accelerate);
	Cvar_Register (&sv_airaccelerate);
	Cvar_Register (&sv_wateraccelerate);
	Cvar_Register (&sv_friction);
	Cvar_Register (&sv_waterfriction);

	//Cvar_Register (&pm_bunnyspeedcap);
	Cvar_Register (&pm_ktjump);
	//Cvar_Register (&pm_slidefix);
	Cvar_Register (&pm_airstep);
	//Cvar_Register (&pm_pground);

	Cvar_Register (&filterban);

	Cvar_Register (&allow_download);
	Cvar_Register (&allow_download_skins);
	Cvar_Register (&allow_download_models);
	Cvar_Register (&allow_download_sounds);
	Cvar_Register (&allow_download_maps);
	Cvar_Register (&allow_download_pakmaps);
	Cvar_Register (&allow_download_demos);
	Cvar_Register (&allow_download_other);
	//bliP: init ->
	Cvar_Register (&download_map_url);

	Cvar_Register (&sv_specprint);
	Cvar_Register (&sv_admininfo);
	Cvar_Register (&sv_reconnectlimit);
	Cvar_Register (&sv_maxlogsize);
	//bliP: 24/9 ->
	Cvar_Register (&sv_logdir);
	Cvar_Register (&sv_speedcheck);
	Cvar_Register (&sv_unfake); // kickfake to unfake
	//<-
	Cvar_Register (&sv_kicktop);
	//<-
	Cvar_Register (&sv_allowlastscores);
//	Cvar_Register (&sv_highchars);
	Cvar_Register (&sv_phs);
	Cvar_Register (&pausable);
	Cvar_Register (&sv_maxrate);
	Cvar_Register (&sv_loadentfiles);
	Cvar_Register (&sv_default_name);
	Cvar_Register (&sv_mod_msg_file);
	Cvar_Register (&sv_forcenick);
	Cvar_Register (&sv_registrationinfo);
	Cvar_Register (&sv_maxuserid);
	Cvar_Register (&registered);
	Cvar_Register (&sv_ktpro_mode);

// QW262 -->
	Cmd_AddCommand ("admin", SV_Admin_f);
// <-- QW262

	// EQDS commands
	Cmd_AddCommand ("stuff", SV_Stuff_f);
	Cmd_AddCommand ("stuffall", SV_StuffAll_f);
	Cmd_AddCommand ("reload", Cmd_Reload_f);		//reload map 
	// EQDS dynamic timers
	Cmd_AddCommand ("addtimer", SV_TimerAdd_f);
	Cmd_AddCommand ("removetimer", SV_TimerDel_f);
	Cmd_AddCommand ("removealltimers", SV_TimerDelAll_f);
	Cmd_AddCommand ("timerlist", SV_TimerList_f);


	// ban control (wish I could rename these to conventionalize..)
/*	Cmd_AddLvl ("addip", SV_AddBanFilter_f, 6); 
	Cmd_AddLvl ("removeip", SV_RemoveBanFilter_f, 6); 
	Cmd_AddLvl ("clearip", SV_RemoveAllBanFilters_f, 6);*/
	Cmd_AddLvl ("addip", SV_AddBanFilter_f, 6); 
	Cmd_AddLvl ("removeip", SV_RemoveBanFilter_f, 6); 
	//Cmd_AddLvl ("clearip", SV_RemoveAllBanFilters_f, 6);
	//Cmd_AddCommand ("addip", SV_AddIP_f);
	//Cmd_AddCommand ("removeip", SV_RemoveIP_f);
	Cmd_AddCommand ("listip", SV_ListIP_f);
	Cmd_AddCommand ("writeip", SV_WriteIP_f);
	Cmd_AddCommand ("vip_addip", SV_AddIPVIP_f);
	Cmd_AddCommand ("vip_removeip", SV_RemoveIPVIP_f);
	Cmd_AddCommand ("vip_listip", SV_ListIPVIP_f);
	Cmd_AddCommand ("vip_writeip", SV_WriteIPVIP_f);

	Cvar_Register (&con_cleanout); // OfN
	Cvar_Register (&con_cleanin); // OfN
	Cvar_Register (&con_color); // OfN
	Cvar_Register (&con_prompt); // OfN
	Cvar_Register (&con_talk); // OfN
	Cvar_Register (&con_cleanlog); // OfN

	//eqds
	Cvar_Register (&lock_cvarLevels);
	Cvar_Register (&lock_cmdLevels);
	Cvar_Register (&sv_MegaTFHacks);


	for (i=0 ; i<MAX_MODELS ; i++)
		snprintf (localmodels[i], MODEL_NAME_LEN, "*%i", i);

#ifdef PEXT_CHUNKEDDOWNLOADS
	svs.fteprotocolextensions |= FTE_PEXT_CHUNKEDDOWNLOADS;

	svs.fteprotocolextensions |= PEXT_CHUNKEDDOWNLOADS;
	svs.fteprotocolextensions |= PEXT_256PACKETENTITIES;
	svs.fteprotocolextensions |= PEXT_ENTITYDBL;
	svs.fteprotocolextensions |= PEXT_ENTITYDBL2;
	svs.fteprotocolextensions |= PEXT_MODELDBL;
	svs.fteprotocolextensions |= PEXT_SPAWNSTATIC2;
#endif

//	Info_SetValueForStarKey (svs.info, "*qwe_version", QWE_VERSION, MAX_SERVERINFO_STRING);
//	Info_SetValueForStarKey (svs.info, "*version", QW_VERSION, MAX_SERVERINFO_STRING);
	Info_SetValueForStarKey (svs.info, "*version", SERVER_NAME " " QWE_VERSION, MAX_SERVERINFO_STRING);
	Info_SetValueForStarKey (svs.info, "*z_ext", va("%i", SERVER_EXTENSIONS), MAX_SERVERINFO_STRING);
#ifdef VWEP_TEST
	Info_SetValueForStarKey (svs.info, "*vwtest", "1", MAX_SERVERINFO_STRING);
#endif
 // init uptime 
	svs.online_since = time(NULL);

	// init fraglog stuff
	svs.logsequence = 1;
	svs.logtime = realtime;
	svs.log[0].data = svs.log_buf[0];
	svs.log[0].maxsize = sizeof(svs.log_buf[0]);
	svs.log[0].cursize = 0;
	svs.log[0].allowoverflow = true;
	svs.log[1].data = svs.log_buf[1];
	svs.log[1].maxsize = sizeof(svs.log_buf[1]);
	svs.log[1].cursize = 0;
	svs.log[1].allowoverflow = true;

	packet_freeblock = Hunk_AllocName (MAX_DELAYED_PACKETS * sizeof(packet_t), "delayed_packets");

	for (i = 0; i < MAX_DELAYED_PACKETS; i++) {
		SZ_Init (&packet_freeblock[i].msg, packet_freeblock[i].buf, sizeof(packet_freeblock[i].buf));
		packet_freeblock[i].next = &packet_freeblock[i + 1];
	}
	packet_freeblock[MAX_DELAYED_PACKETS - 1].next = NULL;
	svs.free_packets = &packet_freeblock[0];
}


//============================================================================

/*
=================
SV_ExtractFromUserinfo

Pull specific info from a newly changed userinfo string
into a more C freindly form.
=================
*/
// Added by VVD {
// ktpro crash if absolute value of userinfo keys "ls" or/and "lw" is to large
static void SV_SetUserInfoKeyLimit (char *key, int limit, client_t *cl, qbool warning_msg)
{
	if (warning_msg)
		SV_ClientPrintf (cl, PRINT_HIGH, "WARNING: You can't set setinfo %s %s %i.\n",
		                 key, limit > 0 ? ">" : "<", limit);

	Info_SetValueForKey (cl->userinfo, key, va("%i", limit), MAX_INFO_STRING);

	MSG_WriteByte (&cl->netchan.message, svc_stufftext);
	MSG_WriteString (&cl->netchan.message, va("setinfo \"%s\" \"%i\"\n", key, limit));
}

static void SV_CheckUserInfoKeyLimit (char *key, int limit, client_t *cl)
{
	char *value_c = Info_ValueForKey (cl->userinfo, key);
	int value = Q_atoi(value_c);

	if (value > limit)
		SV_SetUserInfoKeyLimit (key, limit, cl, true);
	else if (value < -limit)
		SV_SetUserInfoKeyLimit (key, -limit, cl, true);
	else if (strcmp(value_c, va("%i", value)) && *value_c)
		SV_SetUserInfoKeyLimit (key, value, cl, false);
}
// } Added by VVD

extern func_t UserInfo_Changed;

void SV_ExtractFromUserinfo (client_t *cl, qbool namechanged)
{
	char	*val, *p;
	int		i, limit;
	client_t	*client;
	int		dupc = 1;
	char	newname[80];

	if (namechanged)
	{
		// name for C code
		val = Info_ValueForKey (cl->userinfo, "name");

		// trim user name
		strlcpy (newname, val, sizeof(newname));

		for (p = val; *p; p++)
			if ((*p & 127) == '\\' || *p == '\r' || *p == '\n' || *p == '$' || *p == '"' || *p == ';')
			{ // illegal characters in name, set some default
				strlcpy(newname, sv_default_name.string, sizeof(newname));
				break;
			}

		for (p = newname; *p && (*p & 127) == ' '; p++)
			; // empty operator

		if (p != newname) // skip prefixed spaces, if any, even whole string of spaces
			strlcpy(newname, p, sizeof(newname));

		for (p = newname + strlen(newname) - 1; p >= newname; p--)
			if (*p && (*p & 127) != ' ') // skip spaces in suffix, if any
			{
				p[1] = 0;
				break;
			}

		if (strcmp(val, newname))
		{
			Info_SetValueForKey (cl->userinfo, "name", newname, MAX_INFO_STRING);
			val = Info_ValueForKey (cl->userinfo, "name");
		}

		if (!val[0] || !strcasecmp(val, "console"))
		{
			Info_SetValueForKey (cl->userinfo, "name", sv_default_name.string, MAX_INFO_STRING);
			val = Info_ValueForKey (cl->userinfo, "name");
		}

		// check to see if another user by the same name exists
		while (1)
		{
			for (i=0, client = svs.clients ; i<MAX_CLIENTS ; i++, client++)
			{
				if (client->state != cs_spawned || client == cl)
					continue;
				if (!strcasecmp(client->name, val))
					break;
			}
			if (i != MAX_CLIENTS)
			{ // dup name
				if (strlen(val) > CLIENT_NAME_LEN - 1)
					val[CLIENT_NAME_LEN - 4] = 0;
				p = val;

				if (val[0] == '(')
				{
					if (val[2] == ')')
						p = val + 3;
					else if (val[3] == ')')
						p = val + 4;
				}

				snprintf(newname, sizeof(newname), "(%d)%-.40s", dupc++, p);
				Info_SetValueForKey (cl->userinfo, "name", newname, MAX_INFO_STRING);
				val = Info_ValueForKey (cl->userinfo, "name");
			}
			else
				break;
		}

		if (strncmp(val, cl->name, strlen(cl->name) + 1))
		{
			if (!sv.paused)
			{
				if (!cl->lastnametime || realtime - cl->lastnametime > 5)
				{
					cl->lastnamecount = 0;
					cl->lastnametime = realtime;
				}
				else if (cl->lastnamecount++ > 4)
				{
					SV_BroadcastPrintf (PRINT_HIGH, "%s was kicked for name spamming\n", cl->name);
					SV_ClientPrintf (cl, PRINT_HIGH, "You were kicked from the game for name spamming\n");
					SV_LogPlayer(cl, "name spam", 1); //bliP: player logging
					SV_DropClient (cl);
					return;
				}
			}

			if (cl->state >= cs_spawned && !cl->spectator)
				SV_BroadcastPrintf (PRINT_HIGH, "%s changed name to %s\n", cl->name, val);
		}

		strlcpy (cl->name, val, CLIENT_NAME_LEN);

		if (cl->state >= cs_spawned) //bliP: player logging
			SV_LogPlayer(cl, "name change", 1);
	}

	// team
	strlcpy (cl->team, Info_ValueForKey (cl->userinfo, "team"), sizeof(cl->team));

	// rate
	if (cl->download)
	{
		val = Info_ValueForKey (cl->userinfo, "drate");
		if (!Q_atoi(val))
			val = Info_ValueForKey (cl->userinfo, "rate");
	}
	else
		val = Info_ValueForKey (cl->userinfo, "rate");
	cl->netchan.rate = 1.0 / SV_BoundRate (cl->download != NULL, Q_atoi(val));

	// message level
	val = Info_ValueForKey (cl->userinfo, "msg");
	if (strlen(val))
		cl->messagelevel = Q_atoi(val);

	//bliP: spectator print ->
	val = Info_ValueForKey(cl->userinfo, "sp");
	if (strlen(val))
		cl->spec_print = Q_atoi(val);
	//<-
	// Added by VVD {
// ktpro version before 1.67 crash if absolute value of userinfo keys "ls" or/and "lw" is to large
	//limit = 63;		// xav: original, works fine but crashes when dp clients connect
	limit = 363;
	SV_CheckUserInfoKeyLimit("lw", limit, cl);
	SV_CheckUserInfoKeyLimit("ls", limit, cl);
	// } Added by VVD
}


//============================================================================

qbool OnChange_sysselecttimeout_var (cvar_t *var, char *value)
{
	int t = Q_atoi(value);
	if (t <= 1000000 && t >= 10)
	{
		select_timeout.tv_sec  =  t / 1000000;
#if (defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__NetBSD__) || defined(__DragonFly__)) && defined(KQUEUE)
		select_timeout.tv_nsec = (t - select_timeout.tv_sec) * 1000;
#else
		select_timeout.tv_usec =  t - select_timeout.tv_sec;
#endif
		return false;
	}
	Con_Printf("WARNING: sys_select_timeout can't be less then 10 (10 microseconds) and more then 1 000 000 (1 second).\n");
	return true;
}
//bliP: 24/9 logdir ->
qbool OnChange_logdir_var (cvar_t *var, char *value)
{
	if (strstr(value, ".."))
		return true;
	if (value[0])
		Sys_mkdir (value);
	return false;
}
//<-

//bliP: admininfo ->
qbool OnChange_admininfo_var (cvar_t *var, char *value)
{
	if (value[0])
		Info_SetValueForStarKey (svs.info, "*admin", value, MAX_SERVERINFO_STRING);
	else
		Info_RemoveKey (svs.info, "*admin");
	return false;
}
//<-

//bliP: telnet log level ->
qbool OnChange_telnetloglevel_var (cvar_t *var, char *value)
{
	logs[TELNET_LOG].log_level = Q_atoi(value);
	return false;
}
//<-
qbool OnChange_qconsolelogsay_var (cvar_t *var, char *value)
{
	logs[CONSOLE_LOG].log_level = Q_atoi(value);
	return false;
}

/*
====================
SV_InitNet
====================
*/
void SetWindowText_(char*);
static void SV_InitNet (void)
{
	int	p;

	sv_port = PORT_SERVER;
	telnetport = 0;

	p = COM_CheckParm ("-port");
	if (p && p + 1 < com_argc)
	{
		sv_port = Q_atoi(com_argv[p + 1]);
		Con_Printf ("Port: %i\n", sv_port);
	}

	p = COM_CheckParm ("-telnetport");
	if (p && p + 1 < com_argc)
	{
		telnetport = Q_atoi(com_argv[p + 1]);
		Con_Printf ("Telnet port: %i\n", telnetport);
	}
	else
		telnetport =
#ifdef ENABLE_TELNET_BY_DEFAULT
			sv_port;
#else
			0;
#endif
	NET_Init (&sv_port, &telnetport);

	Netchan_Init ();
	// heartbeats will always be sent to the id master
	svs.last_heartbeat = -99999;		// send immediately
	//	NET_StringToAdr ("192.246.40.70:27000", &idmaster_adr);

#if defined (_WIN32) && !defined(_CONSOLE)
	SetWindowText_(va(SERVER_NAME ":%d - QuakeWorld server", sv_port));
#endif

}


/*
====================
SV_Init
====================
*/
void SV_Init (quakeparms_t *parms)
{
	COM_InitArgv (parms->argc, parms->argv);

	if (COM_CheckParm ("-minmemory"))
		parms->memsize = MINIMUM_MEMORY;

	host_parms = *parms;

	if (parms->memsize < MINIMUM_MEMORY)
		SV_Error ("Only %4.1f megs of memory reported, can't execute game",
					parms->memsize / (float)0x100000);

	Memory_Init (parms->membase, parms->memsize);

	// equake logging
	Log_Init ();

	Cbuf_Init ();

	Cmd_Init ();

	FS_Init();

#ifdef USE_PR2
	PR2_Init();
#else
	PR_Init ();
#endif

	SV_InitNet ();

	SV_InitLocal ();

	// equake rcon thing
	Rcon_Init ();

	Sys_Init ();
	CM_Init ();

	SV_MVDInit ();
	Login_Init ();

	Hunk_AllocName (0, "-HOST_HUNKLEVEL-");
	host_hunklevel = Hunk_LowMark ();

	Cbuf_InsertText ("exec rcon.cfg\n");		// EQDS
	Cbuf_InsertText ("exec server.cfg\n");
	Cbuf_InsertText ("loadip\n"); // load filter list from listip.cfg

	host_initialized = true;

	Con_Printf ("%4.1f megabyte heap\n", parms->memsize / (float)0x100000);

	Version_f();

	Con_Printf ("======== QuakeWorld Initialized ========\n");

	// process command line arguments
	Cmd_StuffCmds_f ();
	Cbuf_Execute ();

	if (telnetport)
	{
		SV_Write_Log(TELNET_LOG, 1, "============================================\n");
		SV_Write_Log(TELNET_LOG, 1, SERVER_NAME " " QWE_VERSION " started\n");
	}

	SV_Map(true);

	server_cfg_done  = true;

	// if a map wasn't specified on the command line, spawn start map
	if (sv.state == ss_dead)
	{
		Cmd_ExecuteString ("map start");
		SV_Map(true);
	}

	if (sv.state == ss_dead)
		SV_Error ("Couldn't spawn a server");
}

/*
============
SV_TimeOfDay
============
*/
void SV_TimeOfDay(date_t *date)
{
	struct tm *newtime;
	time_t long_time;

	time(&long_time);
	newtime = localtime(&long_time);

	//bliP: date check ->
	if (!newtime)
	{
		date->day = 0;
		date->mon = 0;
		date->year = 0;
		date->hour = 0;
		date->min = 0;
		date->sec = 0;
		strlcpy(date->str, "#bad date#", sizeof(date->str));
		return;
	}
	//<-

	date->day = newtime->tm_mday;
	date->mon = newtime->tm_mon;
	date->year = newtime->tm_year + 1900;
	date->hour = newtime->tm_hour;
	date->min = newtime->tm_min;
	date->sec = newtime->tm_sec;
	strftime(date->str, sizeof(date->str)-1, "%a %b %d, %H:%M:%S %Y", newtime);
}

//bliP: player logging ->
/*
============
SV_LogPlayer
============
*/
void SV_LogPlayer(client_t *cl, char *msg, int level)
{
	SV_Write_Log(PLAYER_LOG, level,
	             va("%s\\%s\\%i\\%s\\%s\\%i%s\n",
	                msg,
	                cl->name,
	                cl->userid,
	                NET_BaseAdrToString(cl->netchan.remote_address),
	                NET_BaseAdrToString(cl->realip),
	                cl->netchan.remote_address.port,
	                cl->userinfo
	               )
	            );
}

/*
============
SV_Write_Log
============
*/
void SV_Write_Log(int sv_log, int level, char *msg)
{
	static date_t date;
	char *log_msg, *error_msg;

	if (!(logs[sv_log].sv_logfile && *msg))
		return;

	//bliP: moved telnet bit to on cvar change ->
	//if (sv_log == TELNET_LOG)
	//	logs[sv_log].log_level = Cvar_Value("telnet_log_level");
	//<-

	if (logs[sv_log].log_level < level)
		return;

	SV_TimeOfDay(&date);

	switch (sv_log)
	{
	case FRAG_LOG:
	case MOD_FRAG_LOG:
		log_msg = msg; // these logs aren't in fs_gamedir
		error_msg = va("Can't write in %s log file: "/*%s/ */"%sN.log.\n",
		               /*fs_gamedir,*/ logs[sv_log].message_on,
		               logs[sv_log].file_name);
		break;
	default:
		log_msg = va("[%s].[%d] %s", date.str, level, msg);
		error_msg = va("Can't write in %s log file: "/*%s/ */"%s%i.log.\n",
		               /*fs_gamedir,*/ logs[sv_log].message_on,
		               logs[sv_log].file_name, sv_port);
	}

	if (fprintf(logs[sv_log].sv_logfile, "%s", log_msg) < 0)
	{
		//bliP: Sys_Error to Con_DPrintf ->
		//VVD: Con_DPrintf to Sys_Printf ->
		Sys_Printf("%s", error_msg);
		//<-
		SV_Logfile(sv_log, false);
	}
	else
	{
		fflush(logs[sv_log].sv_logfile);
		if ((int)sv_maxlogsize.value &&
		        (FS_FileLength(logs[sv_log].sv_logfile) > (int)sv_maxlogsize.value))
		{
			SV_Logfile(sv_log, true);
		}
	}
}

/*
============
Sys_compare_by functions for sort files in list
============
*/
int Sys_compare_by_date(const void *a, const void *b)
{
	return (int)(((file_t *)a)->time - ((file_t *)b)->time);
}

int Sys_compare_by_name(const void *a, const void *b)
{
	return strncmp(((file_t *)a)->name, ((file_t *)b)->name, MAX_DEMO_NAME);
}

//bliP: plain player names ->
/*char qfont_table[256] = {
	'\0', '#', '#', '#', '#', '.', '#', '#',
	'#', 9, 10, '#', ' ', 13, '.', '.',
	'[', ']', '0', '1', '2', '3', '4', '5',
	'6', '7', '8', '9', '.', '<', '=', '>',
	' ', '!', '"', '#', '$', '%', '&', '\'',
	'(', ')', '*', '+', ',', '-', '.', '/',
	'0', '1', '2', '3', '4', '5', '6', '7',
	'8', '9', ':', ';', '<', '=', '>', '?',
	'@', 'A', 'B', 'C', 'D', 'E', 'F', 'G',
	'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
	'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
	'X', 'Y', 'Z', '[', '\\', ']', '^', '_',
	'`', 'a', 'b', 'c', 'd', 'e', 'f', 'g',
	'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
	'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
	'x', 'y', 'z', '{', '|', '}', '~', '<',

	'<', '=', '>', '#', '#', '.', '#', '#',
	'#', '#', ' ', '#', ' ', '>', '.', '.',
	'[', ']', '0', '1', '2', '3', '4', '5',
	'6', '7', '8', '9', '.', '<', '=', '>',
	' ', '!', '"', '#', '$', '%', '&', '\'',
	'(', ')', '*', '+', ',', '-', '.', '/',
	'0', '1', '2', '3', '4', '5', '6', '7',
	'8', '9', ':', ';', '<', '=', '>', '?',
	'@', 'A', 'B', 'C', 'D', 'E', 'F', 'G',
	'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
	'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
	'X', 'Y', 'Z', '[', '\\', ']', '^', '_',
	'`', 'a', 'b', 'c', 'd', 'e', 'f', 'g',
	'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
	'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
	'x', 'y', 'z', '{', '|', '}', '~', '<'
};*/

/*
==================
Q_normalizetext
returns readable extended quake names
==================
*/
unsigned char *Q_normalizetext(unsigned char *str)
{
	extern char chartbl2[];
	unsigned char	*i;

	for (i = str; *i; i++)
		*i = chartbl2[*i];
	return str;
}

/*
==================
Q_redtext
returns extended quake names
==================
*/
unsigned char *Q_redtext (unsigned char *str)
{
	unsigned char *i;
	for (i = str; *i; i++)
		if (*i > 32 && *i < 128)
			*i |= 128;
	return str;
}
//<-

/*
==================
Q_yelltext
returns extended quake names (yellow numbers)
==================
*/
unsigned char *Q_yelltext (unsigned char *str)
{
	unsigned char *i;
	for (i = str; *i; i++)
	{
		if (*i >= '0' && *i <= '9')
			*i += 18 - '0';
		else if (*i > 32 && *i < 128)
			*i |= 128;
		else if (*i == 13)
			*i = ' ';
	}
	return str;
}

//========================================================
// Procedures called from other sources in the program
//========================================================

/*
=============
IF_FilterPacket

Returns true if the packet's address is in the filter list
=============
*/
cvar_t	if_filterban;
cvar_t	if_filtermute;
//qfilter_t	ipfilters2[MAX_IPFILTERS];
qfilter_t	*ipfilters2;
qbool IF_FilterPacket (netadr_t addr, int type)
{
	unsigned	in;
	qfilter_t	*filter;


	if ((type & IF_BAN) && !if_filterban.value)
		return false;
	if ((type & IF_MUTE) && !if_filtermute.value)
		return false;

	in = *(unsigned *)addr.ip.ip;

	for (filter=ipfilters2 ; filter ; filter=filter->next)
		if (((in & filter->mask) == filter->compare) && (filter->flags & type))
			return true;

	return false;
}

// equake
qbool OnChange_timestamp_var (cvar_t *var, char *string)
{
	if (strlen(string) > 16) 
	{
		Com_Printf ("ERROR: sv_timeformat.string must be 16 bytes or less\n");
		return true;
	}

	return !var;

}
cvar_t	sv_timeformat = {"sv_timeformat", "[%I:%M]", 0, OnChange_timestamp_var}; // timestamp format


/*
===============
Sys_TimeOfDay

Fills date with current local time and date
===============
*/
void Sys_TimeOfDay (qdate_t *date)
{
	struct tm *newtime;
	time_t long_time;

	time (&long_time);
	newtime = localtime (&long_time);

	Q_bzero (date, sizeof(date));

	if (!newtime) 
	{
		strcpy(date->str, "#bad date#");
		strcpy(date->datestr, "#bad date#");
		strcpy(date->timestr, "#bad date#");
		return;
	}

	date->day = newtime->tm_mday;
	date->mon = newtime->tm_mon;
	date->year = newtime->tm_year + 1900;
	date->hour = newtime->tm_hour;
	date->min = newtime->tm_min;
	date->sec = newtime->tm_sec;
	strftime (date->str, 128, "%a %b %d, %H:%M %Y", newtime);
	strftime (date->datestr, 32, "%d-%m-%Y", newtime);
	strftime (date->timestr, 32, "%H:%M:%S", newtime);
	if (sv_timeformat.string[0])
		strftime (date->cTimeStr, 32, sv_timeformat.string, newtime);
}

/*
===============
Sys_TimeOfDayExt

Allows for custom string formatting
===============
*/
void Sys_TimeOfDayExt (qdate_t *date, char *format)
{
	struct tm *newtime;
	time_t long_time;

	time (&long_time);
	newtime = localtime (&long_time);

	Q_bzero (date, sizeof(date));

	if (!format)
		return;

	if (!newtime) 
	{
		strcpy (date->cTimeStr, "#bad date#");
		return;
	}

	date->localtime = long_time;
	date->day = newtime->tm_mday;
	date->mon = newtime->tm_mon;
	date->year = newtime->tm_year + 1900;
	date->hour = newtime->tm_hour;
	date->min = newtime->tm_min;
	date->sec = newtime->tm_sec;
	strftime (date->str, 128, "%a %b %d, %H:%M %Y", newtime);
	strftime (date->datestr, 32, "%d-%m-%Y", newtime);
	strftime (date->timestr, 32, "%H:%M:%S", newtime);
	strftime (date->cTimeStr, 128, format, newtime);
}

void Sys_TimeFormatLocaltime (qdate_t *date, char *format, long newlocaltime)
{
	struct	tm *newtime;
	time_t	long_time;

	if (!newlocaltime)
		newlocaltime = time(&long_time);

	//newtime = localtime (&newlocaltime);	// xavior: (fixme?):this was the eqds original
	newtime = localtime ((time_t*)&newlocaltime);

	Q_bzero (date, sizeof(date));

	if (!format)
		return;

	if (!newtime) 
	{
		strcpy (date->cTimeStr, "#bad date#");
		return;
	}

	date->localtime = newlocaltime;
	date->day = newtime->tm_mday;
	date->mon = newtime->tm_mon;
	date->year = newtime->tm_year + 1900;
	date->hour = newtime->tm_hour;
	date->min = newtime->tm_min;
	date->sec = newtime->tm_sec;
	strftime (date->str, 128, "%a %b %d, %H:%M %Y", newtime);
	strftime (date->datestr, 32, "%d/%m/%Y", newtime);
	strftime (date->timestr, 32, "%H:%M:%S", newtime);
	strftime (date->cTimeStr, 128, format, newtime);
}
//
// IP filter/list loading ala eqds
//

// automatically saves "listip.cfg" after new filters are added/removed
cvar_t	if_autosave = {"if_autosave", "1"};

/*
=============
IF_StringToFilter

Dedicates an ipfilter_t structure to the address and mask of an address
string.
=============
*/
static qbool IF_StringToFilter (char *s, ipfilter_t *f)
{
	char	num[128];
	int		i, j;
	byte	b[4], m[4];

	for (i=0 ; i<4 ; i++) { b[i] = 0; m[i] = 0; }
	
	for (i=0 ; i<4 ; i++)
	{
		if (*s < '0' || *s > '9') 
		{
			Com_Printf ("IPFilter: bad filter address: %s.\n", s);
			return false;
		}

		j = 0;
		while (*s >= '0' && *s <= '9')
			num[j++] = *s++;

		num[j] = 0;
		b[i] = atoi(num);
		if (b[i] != 0)
			m[i] = 255;

		if (!*s)
			break;
		s++;
	}

	if (b[0] == 0)
	{ 
		Com_Printf ("IPFilter: bad filter address: %i.%i.%i.%i.\n",
			b[0], b[1], b[2], b[3]);
		return false;
	}

	f->mask = *(unsigned *)m;
	f->compare = *(unsigned *)b;
	
	return true;
}

/*
=============
IF_RemoveFilter

Removes a filter of a certain type
=============
*/
static qbool IF_RemoveFilter (ipfilter_t *address, int flag)
{
	qfilter_t		*filter;
	qfilter_t		*prev = NULL;
	byte			b[4];


	for (filter = ipfilters2 ; filter ; filter=filter->next)
	{
		if (filter->compare == address->compare && filter->flags == flag)
		{
			// unlink from list
			if (prev)
				prev->next = filter->next;
			else
				ipfilters2 = filter->next;

			// free
			*(unsigned *)b = address->compare;
			Com_Printf ("IPFilter: freeing address %i.%i.%i.%i.\n", b[0], b[1], b[2], b[3]);
			
			if (filter->reason != NULL)
				Z_Free (filter->reason);
			
			Z_Free (filter);

			filtercount--;
			IF_SaveFilters ();

			return true;
		}
		prev = filter;
	}
	return false;
}

/*
=============
IF_FilterList

Lists all filters in filter list of any given type
=============
*/
void IF_FilterList (int type)
{
	qfilter_t		*filter;
	byte			b[4];
	int				i;
	qdate_t			date;

	if (!filtercount)
	{
		Con_Printf ("IPList  : no active filters.\n");
		return;
	}

	Con_Printf ("address         expires          ext. info\n");
	Con_Printf ("--------------- ---------------- ---------\n");

	for (filter=ipfilters2, i=0 ; filter ; filter=filter->next, i++)
	{
		if (!(filter->flags & type))
			continue; 

		*(unsigned *)b = filter->compare;
		Sys_TimeFormatLocaltime(&date, "%m/%d/%y %H:%I%p", filter->expireTime);
		Con_Printf ("%3i.%3i.%3i.%3i %-16s %s\n", b[0], b[1], b[2], b[3],
			(filter->expireTime > 0 ? date.cTimeStr : "n/a"),
			(filter->reason ? va ("<%s>", filter->reason) : ""));
	}
}
/*
=============
IF_CheckIfFilterExists

Checks to see if the address is already in the list for that type.
=============
*/
static qbool IF_CheckIfFilterExists (ipfilter_t *newfilter, int flag)
{
	qfilter_t	*filter;

	for (filter=ipfilters2 ; filter ; filter=filter->next)
		if (((newfilter->compare & filter->mask) == filter->compare) &&
			(filter->flags & flag))
			return true;

	return false;
}

/*
=============
IF_WriteFilters

Writes the filters in the filter list to disk
=============
*/
static void IF_WriteFilters (qbool verbose)
{
	qfilter_t		*filter;
	FILE			*f;
	byte			b[4];
	char			name[MAX_OSPATH];
	int				i, bc=0, mc=0, size=0;


	Sys_mkdir (va("%s/%s", fs_gamedir, if_cfgdir.string));

	if (if_cfgdir.string[0])
		Q_snprintf (name, sizeof(name), "%s/%s/listip.cfg", fs_gamedir, if_cfgdir.string);
	else
		Q_snprintf (name, sizeof(name), "%s/listip.cfg", fs_gamedir);

	if (verbose)
		Com_Printf ("IPFilter: writing to %s...\n", name);

	f = fopen (name, "wt");
	if (!f)
	{
		if (verbose)
			Com_Printf ("IPFilter: error: couldn't open %s\n", name);
		return;
	}

	for (filter=ipfilters2, i=0 ; filter ; filter=filter->next, i++)
	{
		*(unsigned *)b = filter->compare;

		if (filter->reason)
			size += strlen (filter->reason);

		if (filter->flags & IF_BAN)
		{
			if (filter->reason)
				fprintf (f, "addip %i.%i.%i.%i %s\n",
					b[0], b[1], b[2], b[3],
					filter->reason);
			else
				fprintf (f, "addip %i.%i.%i.%i\n",
					b[0], b[1], b[2], b[3]);

			bc++; // increment ban count
		}
		else if (filter->flags & IF_MUTE)
		{
			if (filter->reason)
				fprintf (f, "mute %i.%i.%i.%i %s\n",
					b[0], b[1], b[2], b[3],
					filter->reason);
			else
				fprintf (f, "mute %i.%i.%i.%i\n",
					b[0], b[1], b[2], b[3]);

			mc++; // increment mute count
		}
		else
			if (verbose)
				Com_Printf ("IPFilter: warning: unknown filter with type \"%d\"\n",
				filter->flags);
	}

	fclose (f);

	if (verbose)
	Com_Printf ("IPFilter: wrote %d bans and %d mutes (%d total; %db extended info).\n",
		bc, mc, (bc+mc), (size));
}

/*
=============
IF_SaveFilters

Called from functions which add/remove filters. It will
save filters to disk if autosave is enabled.
=============
*/
void IF_SaveFilters (void)
{
	if (!if_autosave.value)
		return;

	IF_WriteFilters (false);
}

/*
=============
IF_RemovedMaskedFilters

Removes any unnecessary filters for a new network address filter
being added.
=============
*/
static int IF_RemovedMaskedFilters (ipfilter_t *newfilter, int flag)
{
	qfilter_t		*filter;
	qfilter_t		*prev = NULL;
	int				remcount = 0;

	for (filter = ipfilters2 ; filter ; filter=filter->next)
	{
		if ((filter->flags & flag) &&
			((filter->compare & newfilter->mask) == newfilter->compare))
		{
			if (prev)
				prev->next = filter->next;
			else
				ipfilters2 = filter->next;

			if (filter->reason != NULL)
				Z_Free (filter->reason);

			Z_Free (filter);
			filtercount--;
			remcount++;
		}
		else
			prev = filter;
	}

	IF_SaveFilters ();
	return remcount;
}

/*
=============
IF_AddFilter

Adds a filter of a certain type, can pass a userid or ip address.
FIXME: pass client_t struct?.
=============
*/
qfilter_t *IF_AddFilter (int type, int uid, char *ip, char *reason)
{
	qfilter_t		*newfilter = NULL;
	ipfilter_t		filter;
	client_t		*cl;
	char			*address = NULL;
	char			newreason[IF_MAXREASONLEN];
	int				removed, i;
	qbool		fromfile = false;


	// clear to trim all reasons to suitable length
	Q_bzero (newreason, sizeof(newreason));

	if (type & IF_BAN)
	{
		if (!IF_StringToFilter (ip, &filter))
			return NULL; // error message supplied by function
	}
	else if (type & IF_MUTE)
	{
		if (uid && !ip)
		{
			for (i = 0, cl = svs.clients; i < MAX_CLIENTS; i++, cl++)
				if (cl->userid == uid)
					break;

			if (i == MAX_CLIENTS)
			{
				Con_Printf ("IPFilter: user does not exist.\n");
				return NULL;
			}
			if (cl->isrelay)
				address = NET_BaseAdrToString (cl->realip);
			else
				address = NET_BaseAdrToString (cl->netchan.remote_address);
		}
		else
			address = ip;

		if (!IF_StringToFilter (address, &filter))
		{
			Con_Printf ("IPFilter: couldn't translate address \"%s\".\n", address);
			return NULL;
		}
	}

	if (IF_CheckIfFilterExists (&filter, type))
	{
		Con_Printf ("IPFilter: error: address masked or already defined in filter list.\n");
		return NULL;
	}

	if (filtercount == MAX_IP_FILTERS)
	{
		Con_Printf ("IPFilter: error: too many filters.\n");
		return NULL;
	}

	// Removes any addresses that are masked by our new address
	removed = IF_RemovedMaskedFilters (&filter, type);
	if (removed)
		Con_Printf ("IPFilter: removed %d previous addresses masked by new filter.\n",
		removed);

	if (reason)
	{
		if (reason[strlen(reason)-1] == '\r' ||
			reason[strlen(reason)-1] == '\n')
		{
			// newline from file
			fromfile = true;
			strncpy (newreason, reason, strlen(reason)-1);
		}
		else
			strncpy (newreason, reason, sizeof(newreason)-1);
	}

	newfilter = (qfilter_t *)Z_Malloc (sizeof(qfilter_t));
	newfilter->next = ipfilters2;
	ipfilters2 = newfilter;
	newfilter->compare = filter.compare;
	newfilter->mask = filter.mask;
	newfilter->flags = type;
	newfilter->expireTime = 0; // will have to be added with expireban cmd
	if (reason != NULL)
		newfilter->reason = Z_CopyString (newreason);
	else
		newfilter->reason = NULL;

	filtercount++;

	if (!fromfile) // don't trigger autosave if it is read from file.
		IF_SaveFilters ();

	return newfilter;
}

/*
=============
SV_AddBanFilter_f

Adds an ip to the filter list as type ban.
=============
*/
static void SV_AddBanFilter_f (void)
{
	int			l, i;
	char		*ip, *reason = NULL;
	byte		b[4];
	qfilter_t	*filter;


	if (Cmd_Argc () < 2)
	{
		Com_Printf ("usage: addip <address> [reason]\n");
		return;
	}

	ip = Cmd_Argv(1);
	if (!ip)	return;

	if (Cmd_Argc () > 2) // append reason
	{
		reason = Cmd_Args ();
		l = strlen(Cmd_Argv(1)) + 1; // address & space

		// move pointer to location in memory where reason begins
		for (i = 1 ; *reason, i<=l ; reason++, i++) 
			;
	}

	if ((filter = IF_AddFilter (IF_BAN, 0, ip, reason)))
	{
		*(unsigned *)b = filter->compare;
		Com_Printf ("IPFilter: added ban %i.%i.%i.%i to filter list\n",
		b[0], b[1], b[2], b[3]);
	}
}


/*
=============
SV_RemoveBanFilter_f

removes a ban based on the ip
=============
*/
static void SV_RemoveBanFilter_f (void)
{
	ipfilter_t		filter;


	if (Cmd_Argc () < 2)
	{
		Com_Printf ("usage: removeip <address>\n");
		return;
	}

	if(!IF_StringToFilter (Cmd_Argv(1), &filter))
	{
		Com_Printf ("IPFilter: %s: bad address to remove.\n");
		return;
	}

	if (!(IF_RemoveFilter (&filter, IF_BAN)))
		Com_Printf ("IPFilter: couldn't find address %s.\n", Cmd_Argv(1));
}

// Tomaz Quake
#define	MAX_HANDLES		10
FILE	*sys_handles[MAX_HANDLES];

int		findhandle (void)
{
	int		i;
	
	for (i=1 ; i<MAX_HANDLES ; i++)
		if (!sys_handles[i])
			return i;
	Sys_Error ("out of handles");
	return -1;
}
/*
================
filelength
================
*/
int filelength (FILE *f)
{
	int		pos;
	int		end;

	pos = ftell (f);
	fseek (f, 0, SEEK_END);
	end = ftell (f);
	fseek (f, pos, SEEK_SET);

	return end;
}
int Sys_FileOpenRead (char *path, int *hndl)
{
	FILE	*f;
	int		i, retval;

	i = findhandle ();

	f = fopen(path, "rb");

	if (!f)
	{
		*hndl = -1;
		retval = -1;
	}
	else
	{
		sys_handles[i] = f;
		*hndl = i;
		retval = filelength(f);
	}

	return retval;
}

int Sys_FileOpenWrite (char *path)
{
	FILE	*f;
	int		i;
	
	i = findhandle ();

	f = fopen(path, "wb");
	if (!f)
		Sys_Error ("Error opening %s: %s", path,strerror(errno));
	sys_handles[i] = f;
	
	return i;
}

void Sys_FileClose (int handle)
{
	fclose (sys_handles[handle]);
	sys_handles[handle] = NULL;
}

void Sys_FileSeek (int handle, int position)
{
	fseek (sys_handles[handle], position, SEEK_SET);
}

int Sys_FileRead (int handle, void *dest, int count)
{
	int		x;

	x = fread (dest, 1, count, sys_handles[handle]);
	return x;
}

int Sys_FileWrite (int handle, void *data, int count)
{
	int		x;

	x = fwrite (data, 1, count, sys_handles[handle]);
	return x;
}