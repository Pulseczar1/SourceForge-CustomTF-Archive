/*
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

	$Id: server.h,v 1.46 2007/04/06 21:15:13 qqshka Exp $
*/

// server.h
#ifndef __SERVER_H__
#define __SERVER_H__

#define CHAT_ICON_EXPERIMENTAL 1

#define	MAX_MASTERS 8 // max recipients for heartbeat packets

#define	MAX_SIGNON_BUFFERS 16

#define MAX_STATIC_ENTITIES 256

// sv_specprint stuff
#define SPECPRINT_CENTERPRINT	0x1
#define SPECPRINT_SPRINT	0x2
#define SPECPRINT_STUFFCMD	0x4

typedef enum {
	ss_dead,	// no map loaded
	ss_loading,	// spawning level edicts
	ss_active	// actively running
} server_state_t;
// some qc commands are only valid before the server has finished
// initializing (precache commands, static sounds / objects, etc)

typedef struct packet_s
{
	double		time;
	sizebuf_t	msg;
	byte		buf[MSG_BUF_SIZE]; // ?MAX_MSGLEN?
	struct packet_s *next;
} packet_t;

#define MAX_DELAYED_PACKETS 1024 // maxclients 32 * 77fps * max minping 0.3 = 739.2
#define MAP_NAME_LEN 64
typedef struct
{
	server_state_t	state;				// precache commands are only valid during load

	double		time;
	double		old_time;			// bumped by SV_Physics

	int		lastcheck;			// used by PF_checkclient
	double		lastchecktime;			// for monster ai

	qbool		paused;				// are we paused?
	double		pausedsince;		// Sys_DoubleTime() when pause started

	//check player/eyes models for hacks
	unsigned	model_player_checksum;
	unsigned	eyes_player_checksum;
	
	char		mapname[MAP_NAME_LEN];		// map name
	char		modelname[MAX_QPATH];		// maps/<name>.bsp, for model_precache[0]
	unsigned	map_checksum;
	unsigned	map_checksum2;
	cmodel_t	*worldmodel;
	char		*model_precache[MAX_MODELS];	// NULL terminated
#ifdef VWEP_TEST
	// TODO: rename to precache to match mvdsv naming?
	char		*vw_model_name[MAX_VWEP_MODELS];	// NULL terminated
#endif
	char		*sound_precache[MAX_SOUNDS];	// NULL terminated
	char		*lightstyles[MAX_LIGHTSTYLES];
	cmodel_t	*models[MAX_MODELS];

	int		num_edicts;			// increases towards MAX_EDICTS
	edict_t		*edicts;			// can NOT be array indexed, because
							// edict_t is variable sized, but can
							// be used to reference the world ent

	byte		*pvs, *phs;			// fully expanded and decompressed

	// added to every client's unreliable buffer each frame, then cleared
	sizebuf_t	datagram;
	byte		datagram_buf[MAX_DATAGRAM];

	// added to every client's reliable buffer each frame, then cleared
	sizebuf_t	reliable_datagram;
	byte		reliable_datagram_buf[MAX_MSGLEN];

	// the multicast buffer is used to send a message to a set of clients
	sizebuf_t	multicast;
	byte		multicast_buf[MAX_MSGLEN];

	// the signon buffer will be sent to each client as they connect
	// includes the entity baselines, the static entities, etc
	// large levels will have >MAX_DATAGRAM sized signons, so 
	// multiple signon messages are kept
	sizebuf_t	signon;
	unsigned int	num_signon_buffers;
	int		signon_buffer_size[MAX_SIGNON_BUFFERS];
	byte		signon_buffers[MAX_SIGNON_BUFFERS][MAX_DATAGRAM];

	qbool		mvdrecording;

	entity_state_t extendedstatics[MAX_STATIC_ENTITIES];
	int numextrastatics;
} server_t;

#define	NUM_SPAWN_PARMS 16

typedef enum
{
	cs_free,		// can be reused for a new connection
	cs_zombie,		// client has been disconnected, but don't reuse
				// connection for a couple seconds
	cs_preconnected,	// has been assigned, but login/realip not settled yet
	cs_connected,		// has been assigned to a client_t, but not in game yet
	cs_spawned		// client is fully in game
} sv_client_state_t;		// FIXME

typedef struct
{
	// received from client

	// reply
	double			senttime;
	float			ping_time;
	packet_entities_t	entities;
} client_frame_t;

#define MAX_BACK_BUFFERS	/*128*/256
#define MAX_STUFFTEXT		256
#define	CLIENT_LOGIN_LEN	16
#define	CLIENT_NAME_LEN		32
typedef struct client_s
{
	sv_client_state_t	state;

	int				extensions;			// what ZQuake extensions the client supports
	int				spectator;			// non-interactive
	int				vip;

	qbool			sendinfo;			// at end of frame, send info to all
							// this prevents malicious multiple broadcasts
	float			lastnametime;			// time of last name change
	int				lastnamecount;			// time of last name change
	unsigned		checksum;			// checksum for calcs
	qbool			drop;				// lose this guy next opportunity
	int				lossage;			// loss percentage

	int				userid;				// identifying number
	char			userinfo[MAX_INFO_STRING];	// infostring
	char			userinfoshort[MAX_INFO_STRING];	// infostring

	usercmd_t		lastcmd;			// for filling in big drops and partial predictions
	double			localtime;			// of last message
	qbool			jump_held;

	float			maxspeed;			// localized maxspeed
	float			entgravity;			// localized ent gravity

	edict_t			*edict;				// EDICT_NUM(clientnum+1)
#ifdef USE_PR2
	int		isBot;
	usercmd_t		botcmd;				// bot movment
	char			*name;				// in PR2 points to ent->v.netname
#else
	char			name[CLIENT_NAME_LEN];		// for printing to other people
#endif
	char			team[CLIENT_NAME_LEN];
							// extracted from userinfo
	int				messagelevel;			// for filtering printed messages

	// the datagram is written to after every frame, but only cleared
	// when it is sent out to the client.  overflow is tolerated.
	sizebuf_t		datagram;
	byte			datagram_buf[MAX_DATAGRAM];

	// back buffers for client reliable data
	sizebuf_t		backbuf;
	int				num_backbuf;
	int				backbuf_size[MAX_BACK_BUFFERS];
	byte			backbuf_data[MAX_BACK_BUFFERS][MAX_MSGLEN];

	char			stufftext_buf[MAX_STUFFTEXT];

	double			connection_started;		// or time of disconnect for zombies
	qbool			send_message;			// set on frames a datagram arived on

// spawn parms are carried from level to level
	float			spawn_parms[NUM_SPAWN_PARMS];

// client known data for deltas	
	int				old_frags;
	
	int				stats[MAX_CL_STATS];

	double			lastservertimeupdate;		// last realtime we sent STAT_TIME to the client

	client_frame_t	frames[UPDATE_BACKUP];		// updates can be deltad from here

	FILE			*download;			// file being downloaded
#ifdef PROTOCOL_VERSION_FTE
	int				download_position; // chunked download used fseek(), since this is may be pak file, we need offset in pak file
#ifdef FTE_PEXT_CHUNKEDDOWNLOADS
	int				download_chunks_perframe;
#endif
#endif
	int				downloadsize;			// total bytes
	int				downloadcount;			// bytes sent
// demo download list for internal cmd dl function
//Added by VVD {
	int				demonum[MAX_ARGS];
	qbool			demolist;
// } Added by VVD

	int				spec_track;			// entnum of player tracking

	double			whensaid[10];			// JACK: For floodprots
 	int				whensaidhead;			// Head value for floodprots
 	double			lockedtill;

	FILE			*upload;
	char			uploadfn[MAX_QPATH];
	netadr_t		snap_from;
	qbool			remote_snap;

	char			login[CLIENT_LOGIN_LEN];
	int				logged;

	int				spawncount;			// for tracking map changes during downloading

//bliP: additional ->
	int				file_percent;
	qbool			special;
	int				logincount;
	float			lasttoptime;			// time of last topcolor change
	int				lasttopcount;			// count of last topcolor change
	int				lastconnect;
	int				spec_print;
	double			cuff_time;
//bliP: 24/9 anti speed ->
	int				msecs;
	double			last_check;
//<-
//<-
	float			lastuserinfotime;		// time of last userinfo change
	int				lastuserinfocount;		// count of last userinfo change

#ifdef PROTOCOL_VERSION_FTE
	unsigned int	fteprotocolextensions;
#endif
 
//===== NETWORK ============
	int				chokecount;
	int				delta_sequence;			// -1 = no compression
	netchan_t		netchan;
	netadr_t		realip;				// client's ip, not latest proxy's
	int				realip_num;			// random value
	int				realip_count;
	int				rip_vip;
	double			delay;
	double			disable_updates_stop;		//Vladis
	packet_t		*packets, *last_packet;

	// Bot stuff
	edict_t	*botent;
	char	pskin[32];
	char	bname[CLIENT_NAME_LEN];		// bot's name
	int		buserid;					// bot's fake userid
	int		bfullupdate;				// this is a full-update bot (take away nasty clientside hax)
	int		bpc_num;					// bot's player class #
	int		bteam;
	// xav misc
	double		next_say_cmd;			// next time player can call pm, say, etc.

	//eqds
	qbool			isrelay;			// this is set to true if they are using a proxy
} client_t;

/*******************************************************
 General MegaTF Hacks
*******************************************************/

extern cvar_t	sv_MegaTFHacks;

typedef struct mtf_s
{
	qbool	changing;		// found changing command
	qbool	nocycle;		// found out that the map cycle cfgs are missing
	int			intermission_thinks;	// count of intermission thinks (shouldn't be more than 1)
} mtf_t;

mtf_t mtf;
extern mtf_t	mtf;

// a client can leave the server in one of four ways:
// dropping properly by quiting or disconnecting
// timing out if no valid messages are received for timeout.value seconds
// getting kicked off by the server operator
// a program error, like an overflowed reliable buffer

typedef struct
{
	vec3_t			origin;
	vec3_t			angles;
	int				weaponframe;
	int				skinnum;
	int				model;
	int				effects;
} demoinfo_t;

typedef struct
{
	demoinfo_t		info;
	float			sec;
	int				parsecount;
	qbool			fixangle;
	vec3_t			angle;
	float			cmdtime;
	int				flags;
	int				frame;
} demo_client_t;

typedef struct {
	byte			type;
	byte			full;
	int				to;
	int				size;
	byte			data[1]; //gcc doesn't allow [] (?)
} header_t;

typedef struct
{
	qbool			allowoverflow; // if false, do a Sys_Error
	qbool			overflowed; // set to true if the buffer size failed
	byte			*data;
	int				maxsize;
	int				cursize;
	int				bufsize;
	header_t 		*h;
} demobuf_t;

typedef struct
{
	demo_client_t	clients[MAX_CLIENTS];
	double			time;
	demobuf_t		buf;

} demo_frame_t;

typedef struct {
	byte			*data;
	int				start, end, last;
	int				maxsize;
} dbuffer_t;

#define DEMO_FRAMES 64
#define DEMO_FRAMES_MASK (DEMO_FRAMES - 1)

typedef struct
{
	demobuf_t		*dbuf;
	dbuffer_t		dbuffer;
	sizebuf_t		datagram;
	byte			datagram_data[MSG_BUF_SIZE];
	int				lastto;
	int				lasttype;
	double			time, pingtime;
	int				stats[MAX_CLIENTS][MAX_CL_STATS]; // ouch!
	client_t		recorder;
	qbool			fixangle[MAX_CLIENTS];
	float			fixangletime[MAX_CLIENTS];
	vec3_t			angles[MAX_CLIENTS];
// unused, now we must use same in demo.dest list
//	char			name[MAX_OSPATH], path[MAX_OSPATH];
	int				parsecount;
	int				lastwritten;
	demo_frame_t	frames[DEMO_FRAMES];
	demoinfo_t		info[MAX_CLIENTS];
	byte			buffer[20*MAX_MSGLEN];
	int				bufsize;
	int				forceFrame;

	struct mvddest_s *dest;
	struct mvdpendingdest_s *pendingdest;
} demo_t;


//=============================================================================


#define	STATFRAMES	100
typedef struct
{
	double			active;
	double			idle;
	double			demo;
	int				count;
	int				packets;

	double			latched_active;
	double			latched_idle;
	double			latched_demo;
	int				latched_packets;
} svstats_t;

// MAX_CHALLENGES is made large to prevent a denial
// of service attack that could cycle all of them
// out before legitimate users connected
#define	MAX_CHALLENGES	1024

typedef struct
{
	netadr_t		adr;
	int				challenge;
	int				time;
} challenge_t;

typedef struct
{
	double			realtime;
	time_t			online_since;
	int				spawncount;		// number of servers spawned since start,
						// used to check late spawns
	int				lastuserid;		// userid of last spawned client
	client_t		clients[MAX_CLIENTS];
	int				serverflags;		// episode completion information
	
	double			last_heartbeat;
	int				heartbeat_sequence;
	svstats_t		stats;

	char				info[MAX_SERVERINFO_STRING];

#ifdef PROTOCOL_VERSION_FTE
	unsigned int fteprotocolextensions;
#endif

	// log messages are used so that fraglog processes can get stats
	int				logsequence;		// the message currently being filled
	double			logtime;		// time of last swap
	sizebuf_t		log[2];
	byte			log_buf[2][MAX_DATAGRAM];

	challenge_t		challenges[MAX_CHALLENGES];	// to prevent invalid IPs from connecting

	packet_t		*free_packets;
} server_static_t;

#define MAX_BOTS	32
typedef struct
{
	client_t	bots[MAX_BOTS];
} server_bot_info;

//=============================================================================

// edict->movetype values
#define	MOVETYPE_NONE			0		// never moves
#define	MOVETYPE_ANGLENOCLIP		1
#define	MOVETYPE_ANGLECLIP		2
#define	MOVETYPE_WALK			3		// gravity
#define	MOVETYPE_STEP			4		// gravity, special edge handling
#define	MOVETYPE_FLY			5
#define	MOVETYPE_TOSS			6		// gravity
#define	MOVETYPE_PUSH			7		// no clip to world, push and crush
#define	MOVETYPE_NOCLIP			8
#define	MOVETYPE_FLYMISSILE		9		// extra size to monsters
#define	MOVETYPE_BOUNCE			10

// edict->solid values
#define	SOLID_NOT			0		// no interaction with other objects
#define	SOLID_TRIGGER			1		// touch on edge, but not blocking
#define	SOLID_BBOX			2		// touch on edge, block
#define	SOLID_SLIDEBOX			3		// touch on edge, but not an onground
#define	SOLID_BSP			4		// bsp clip, touch on edge, block

// edict->deadflag values
#define	DAMAGE_NO			0
#define	DAMAGE_YES			1
#define	DAMAGE_AIM			2

// edict->flags
#define	FL_FLY				1
#define	FL_SWIM				2
#define	FL_GLIMPSE			4
#define	FL_CLIENT			8
#define	FL_INWATER			16
#define	FL_MONSTER			32
#define	FL_GODMODE			64
#define	FL_NOTARGET			128
#define	FL_ITEM				256
#define	FL_ONGROUND			512
#define	FL_PARTIALGROUND		1024	// not all corners are valid
#define	FL_WATERJUMP			2048	// player jumping out of water

#define FL_FINDABLE_NONSOLID	16384 // OfN - Any entity with this can be "found" with findradius(), even if SOLID_NOT

#define	SPAWNFLAG_NOT_EASY		256
#define	SPAWNFLAG_NOT_MEDIUM		512
#define	SPAWNFLAG_NOT_HARD		1024
#define	SPAWNFLAG_NOT_DEATHMATCH	2048

#define	MULTICAST_ALL			0
#define	MULTICAST_PHS			1
#define	MULTICAST_PVS			2

#define	MULTICAST_ALL_R			3
#define	MULTICAST_PHS_R			4
#define	MULTICAST_PVS_R			5

// maps in localinfo supported only by ktpro & ktx mods {
#define LOCALINFO_MAPS_LIST_START		1000
#define LOCALINFO_MAPS_LIST_END			1999

#define LOCALINFO_MAPS_KTPRO_VERSION	1.63
#define LOCALINFO_MAPS_KTPRO_VERSION_S	"1.63"
#define LOCALINFO_MAPS_KTPRO_BUILD		42795
#define SERVERINFO_KTPRO_VERSION		"kmod"
#define SERVERINFO_KTPRO_BUILD			"build"

// all versions of ktx with such serverinfo's keys support maps in localinfo
#define SERVERINFO_KTX_VERSION			"xmod"
#define SERVERINFO_KTX_BUILD			"xbuild"
// }

#define MAX_REDIRECTMESSAGES	128
#define OUTPUTBUF_SIZE			8000

// { server flags

// force player enter server as spectator if all players's slots are busy and
// if there are empty slots for spectators and sv_forcespec_onfull == 2
#define SVF_SPEC_ONFULL			(1<<0)	

// } server flags

//============================================================================

extern	cvar_t	sv_mintic, sv_maxtic, sv_ticrate;
extern	cvar_t	sv_maxspeed;

extern	int current_skill;

extern	cvar_t	spawn;
extern	cvar_t	teamplay;
extern	cvar_t	serverdemo;
extern	cvar_t	deathmatch;
extern	cvar_t	fraglimit;
extern	cvar_t	timelimit;
extern	cvar_t	skill;
extern	cvar_t	coop;

extern	cvar_t	sv_specprint;	//bliP: spectator print

extern	server_static_t	svs;	// persistant server info
extern	server_bot_info sbi;
extern	server_t	sv;	// local server
extern	demo_t		demo;	// server demo struct
extern	entity_state_t	cl_entities[MAX_CLIENTS][UPDATE_BACKUP+1][MAX_PACKET_ENTITIES]; // client entities

extern	client_t	*sv_client;
extern	edict_t		*sv_player;

#define	MODEL_NAME_LEN	5
extern	char		localmodels[MAX_MODELS][MODEL_NAME_LEN]; // inline model names for precache
extern	char		localinfo[MAX_LOCALINFO_STRING+1];

extern	int		host_hunklevel;

extern	qbool		sv_error;

extern qbool		server_cfg_done;
extern char		master_rcon_password[128];

extern qbool is_ktpro;

//===========================================================

//
// sv_main.c
//

typedef enum {
	ipft_ban,
	ipft_safe
} ipfiltertype_t;

typedef struct
{
	unsigned	mask;
	unsigned	compare;
	int			level;
	double		time; // for ban expiration
	ipfiltertype_t type;
} ipfilter_t;

//bliP: penalty filters ->
typedef enum {
	ft_mute,
	ft_cuff
} filtertype_t;

typedef struct
{
	byte		ip[4];
	double		time;
	filtertype_t	type;
} penfilter_t;
//<-

void SV_Shutdown (void);
void SV_Frame (double time);
void SV_FinalMessage (char *message);
void SV_DropClient (client_t *drop);

int SV_CalcPing (client_t *cl);
void SV_FullClientUpdate (client_t *client, sizebuf_t *buf);
void SV_FullClientUpdateToClient (client_t *client, client_t *cl);

qbool SV_CheckBottom (edict_t *ent);
qbool SV_movestep (edict_t *ent, vec3_t move, qbool relink);

void SV_WriteClientdataToMessage (client_t *client, sizebuf_t *msg);

void SV_MoveToGoal (void);

void SV_InitOperatorCommands (void);

void SV_SendServerinfo (client_t *client);
void SV_ExtractFromUserinfo (client_t *cl, qbool namechanged);
int SV_BoundRate (qbool dl, int rate);

//bliP: init ->
void SV_ListFiles_f (void);
void SV_RemoveFile_f (void);
void SV_RemoveDirectory_f (void);

#define	MAX_PENFILTERS 512
void SV_RemoveIPFilter (int i);
//static qbool SV_IPCompare (byte *a, byte *b);
//static void SV_IPCopy (byte *dest, byte *src);
void SV_SavePenaltyFilter (client_t *cl, filtertype_t type, double pentime);
double SV_RestorePenaltyFilter (client_t *cl, filtertype_t type);

qbool SV_FilterPacket (void);
void SV_SendBan (void);
qbool GameStarted(void);
//<-
void SV_Script_f (void);
int SV_GenerateUserID (void);

//
// sv_init.c
//
int SV_ModelIndex (char *name);
void SV_FlushSignon (void);
void SV_SpawnServer (char *server, qbool devmap);


//
// sv_phys.c
//
void SV_ProgStartFrame (void);
void SV_Physics (void);
void SV_CheckVelocity (edict_t *ent);
void SV_AddGravity (edict_t *ent, float scale);
qbool SV_RunThink (edict_t *ent);
void SV_Physics_Toss (edict_t *ent);
void SV_RunNewmis (void);
void SV_Impact (edict_t *e1, edict_t *e2);
void SV_SetMoveVars(void);

//
// sv_send.c
//
typedef enum {RD_NONE, RD_CLIENT, RD_PACKET, RD_MOD} redirect_t;
void SV_BeginRedirect (redirect_t rd);
void SV_EndRedirect (void);

void SV_Multicast (vec3_t origin, int to, int with, int without);
void SV_StartSound (edict_t *entity, int channel, char *sample, int volume,
    float attenuation);
void SV_ClientPrintf (client_t *cl, int level, char *fmt, ...);
void SV_ClientPrintf2 (client_t *cl, int level, char *fmt, ...);
void SV_BroadcastPrintf (int level, char *fmt, ...);
void SV_BroadcastCommand (char *fmt, ...);
void SV_SendClientMessages (void);
void SV_SendDemoMessage(void);
void SV_SendMessagesToAll (void);
void SV_FindModelNumbers (void);


//
// sv_user.c
//
void SV_ExecuteClientMessage (client_t *cl);
void SV_UserInit (void);
void SV_TogglePause (const char *msg);


//
// sv_ccmds.c
//
void SV_Status_f (void);
void SV_SendServerInfoChange (char *key, char *value);

//
// sv_ents.c
//
void SV_WriteEntitiesToClient (client_t *client, sizebuf_t *msg, qbool recorder);

//
// sv_nchan.c
//
void ClientReliableCheckBlock(client_t *cl, int maxsize);
void ClientReliable_FinishWrite(client_t *cl);
void ClientReliableWrite_Begin(client_t *cl, int c, int maxsize);
void ClientReliableWrite_Angle(client_t *cl, float f);
void ClientReliableWrite_Angle16(client_t *cl, float f);
void ClientReliableWrite_Byte(client_t *cl, int c);
void ClientReliableWrite_Char(client_t *cl, int c);
void ClientReliableWrite_Float(client_t *cl, float f);
void ClientReliableWrite_Coord(client_t *cl, float f);
void ClientReliableWrite_Long(client_t *cl, int c);
void ClientReliableWrite_Short(client_t *cl, int c);
void ClientReliableWrite_String(client_t *cl, char *s);
void ClientReliableWrite_SZ(client_t *cl, void *data, int len);
void SV_ClearReliable (client_t *cl); // clear cl->netchan.message and backbuf

//
// sv_demo.c
//
void SV_MVDPings (void);
void SV_MVDWriteToDisk(int type, int to, float time);
void MVDWrite_Begin(byte type, int to, int size);
void MVDSetMsgBuf(demobuf_t *prev,demobuf_t *cur);
void SV_MVDStop (int reason, qbool mvdonly);
void SV_MVDStop_f (void);
void SV_MVDWritePackets (int num);
void SV_MVDStream_Poll(void);

extern demo_t	demo; // server demo struct

extern cvar_t	sv_demofps;
extern cvar_t	sv_demoPings;
extern cvar_t	sv_demoNoVis;
extern cvar_t	sv_demoUseCache;
extern cvar_t	sv_demoMaxSize;
extern cvar_t	sv_demoMaxDirSize;

void SV_MVDInit (void);
char *SV_MVDNum(int num);

//
// sv_login.c
//

void SV_LoadAccounts(void);
void SV_CreateAccount_f(void);
void SV_RemoveAccount_f(void);
void SV_ListAccount_f (void);
void Login_Init (void);
qbool SV_Login(client_t *cl);
void SV_Logout(client_t *cl);
void SV_ParseLogin(client_t *cl);
void SV_LoginCheckTimeOut(client_t *cl);

// sv_master.c
void SV_SetMaster_f (void);
void SV_Heartbeat_f (void);
void Master_Shutdown (void);
void Master_Heartbeat (void);

#endif /* !__SERVER_H__ */
