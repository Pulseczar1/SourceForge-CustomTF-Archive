data
export world
align 4
LABELV world
address g_edicts
align 4
LABELV expfields
address $11
byte 4 520
byte 4 1
address $12
byte 4 524
byte 4 1
address $13
byte 4 1652
byte 4 0
byte 4 0
skip 8
align 1
LABELV worldmodel
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
skip 53
align 4
LABELV gamedata
address g_edicts
byte 4 1824
address g_globalvars
address expfields
byte 4 9
export vmMain
code
proc vmMain 20 12
file "..\src\g_main.c"
line 68
;1:/*
;2: *  QWProgs-TF2003
;3: *  Copyright (C) 2004  [sd] angel
;4: *
;5: *  This program is free software; you can redistribute it and/or modify
;6: *  it under the terms of the GNU General Public License as published by
;7: *  the Free Software Foundation; either version 2 of the License, or
;8: *  (at your option) any later version.
;9: *
;10: *  This program is distributed in the hope that it will be useful,
;11: *  but WITHOUT ANY WARRANTY; without even the implied warranty of
;12: *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;13: *  GNU General Public License for more details.
;14: *
;15: *  You should have received a copy of the GNU General Public License
;16: *  along with this program; if not, write to the Free Software
;17: *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
;18: *
;19: *
;20: *  $Id: g_main.c,v 1.25 2006/02/28 21:29:52 AngelD Exp $
;21: */
;22:
;23:#include "g_local.h"
;24:
;25:gedict_t        g_edicts[MAX_EDICTS];	//768
;26:gedict_t       *world = g_edicts;
;27:gedict_t       *self, *other;
;28:
;29:globalvars_t    g_globalvars;
;30:static field_t         expfields[] = {
;31:	{"maxspeed", FOFS( maxspeed ), F_FLOAT}	,
;32:	{"gravity", FOFS( gravity ), F_FLOAT},
;33:	{"isBot", FOFS( isBot ), F_INT},
;34:	{NULL}
;35:};
;36:
;37:static char     mapname[64];
;38:static char     worldmodel[64] = "worldmodel";
;39:static char     netnames[MAX_CLIENTS][32];
;40:int             api_ver;
;41:
;42://#define MIN_API_VERSION 6
;43:#define MIN_API_VERSION GAME_API_VERSION
;44:
;45:static gameData_t      gamedata =
;46:    { ( edict_t * ) g_edicts, sizeof( gedict_t ), &g_globalvars, expfields , MIN_API_VERSION};
;47:float           starttime;
;48:void            G_InitGame( int levelTime, int randomSeed );
;49:void            StartFrame( int time );
;50:qboolean        ClientCommand();
;51:qboolean        ClientUserInfoChanged();
;52:void            G_EdictTouch();
;53:void            G_EdictThink();
;54:void            G_EdictBlocked();
;55:void            ClearGlobals();
;56:
;57:/*
;58:================
;59:vmMain
;60:
;61:This is the only way control passes into the module.
;62:This must be the very first function compiled into the .q3vm file
;63:================
;64:*/
;65:
;66:int vmMain( int command, int arg0, int arg1, int arg2, int arg3, int arg4, int arg5,
;67:	    int arg6, int arg7, int arg8, int arg9, int arg10, int arg11 )
;68:{
line 69
;69:	ClearGlobals();
ADDRGP4 ClearGlobals
CALLV
pop
line 70
;70:	switch ( command )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $15
ADDRLP4 0
INDIRI4
CNSTI4 17
GTI4 $15
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $60
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $60
address $17
address $21
address $57
address $23
address $31
address $55
address $35
address $53
address $40
address $15
address $44
address $22
address $51
address $39
address $58
address $48
address $49
address $50
code
line 71
;71:	{
LABELV $17
line 73
;72:	case GAME_INIT:
;73:	        api_ver = trap_GetApiVersion();
ADDRLP4 4
ADDRGP4 trap_GetApiVersion
CALLI4
ASGNI4
ADDRGP4 api_ver
ADDRLP4 4
INDIRI4
ASGNI4
line 74
;74:		if ( api_ver < MIN_API_VERSION ) 
ADDRGP4 api_ver
INDIRI4
CNSTI4 9
GEI4 $18
line 75
;75:		{
line 76
;76:			G_conprintf("Mod requried API_VERSION %d or higher, server have %d\n", MIN_API_VERSION, api_ver);
ADDRGP4 $20
ARGP4
CNSTI4 9
ARGI4
ADDRGP4 api_ver
INDIRI4
ARGI4
ADDRGP4 G_conprintf
CALLV
pop
line 77
;77:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $14
JUMPV
LABELV $18
line 80
;78:		}
;79:
;80:		G_InitGame( arg0, arg1 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 G_InitGame
CALLV
pop
line 81
;81:		return ( int ) ( &gamedata );
ADDRGP4 gamedata
CVPU4 4
CVUI4 4
RETI4
ADDRGP4 $14
JUMPV
LABELV $21
line 84
;82:
;83:	case GAME_LOADENTS:
;84:		G_SpawnEntitiesFromString();
ADDRGP4 G_SpawnEntitiesFromString
CALLV
pop
line 85
;85:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $14
JUMPV
LABELV $22
line 88
;86:
;87:	case GAME_START_FRAME:
;88:		StartFrame( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 StartFrame
CALLV
pop
line 89
;89:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $14
JUMPV
LABELV $23
line 92
;90:
;91:	case GAME_CLIENT_CONNECT:
;92:		self = PROG_TO_EDICT( g_globalvars.self );
ADDRGP4 self
ADDRGP4 g_globalvars+112
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 93
;93:		self->auth_time = g_globalvars.time + 10.0;
ADDRGP4 self
INDIRP4
CNSTI4 1584
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 94
;94:		self->isSpectator = arg0?1:0;
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $27
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $28
JUMPV
LABELV $27
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $28
ADDRGP4 self
INDIRP4
CNSTI4 1480
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 95
;95:		if ( arg0 )
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $29
line 96
;96:			SpectatorConnect();
ADDRGP4 SpectatorConnect
CALLV
pop
ADDRGP4 $30
JUMPV
LABELV $29
line 98
;97:		else
;98:			ClientConnect();
ADDRGP4 ClientConnect
CALLV
pop
LABELV $30
line 99
;99:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $14
JUMPV
LABELV $31
line 102
;100:
;101:	case GAME_PUT_CLIENT_IN_SERVER:
;102:		self = PROG_TO_EDICT( g_globalvars.self );
ADDRGP4 self
ADDRGP4 g_globalvars+112
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 103
;103:		if ( !arg0 )
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $33
line 104
;104:			PutClientInServer();
ADDRGP4 PutClientInServer
CALLV
pop
LABELV $33
line 105
;105:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $14
JUMPV
LABELV $35
line 108
;106:
;107:	case GAME_CLIENT_DISCONNECT:
;108:		self = PROG_TO_EDICT( g_globalvars.self );
ADDRGP4 self
ADDRGP4 g_globalvars+112
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 109
;109:		if ( arg0 )
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $37
line 110
;110:			SpectatorDisconnect();
ADDRGP4 SpectatorDisconnect
CALLV
pop
ADDRGP4 $38
JUMPV
LABELV $37
line 112
;111:		else
;112:			ClientDisconnect();
ADDRGP4 ClientDisconnect
CALLV
pop
LABELV $38
line 113
;113:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $14
JUMPV
LABELV $39
line 116
;114:
;115:	case GAME_SETNEWPARMS:
;116:		SetNewParms();
ADDRGP4 SetNewParms
CALLV
pop
line 117
;117:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $14
JUMPV
LABELV $40
line 120
;118:
;119:	case GAME_CLIENT_PRETHINK:
;120:		self = PROG_TO_EDICT( g_globalvars.self );
ADDRGP4 self
ADDRGP4 g_globalvars+112
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 121
;121:		if ( !arg0 )
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $42
line 122
;122:			PlayerPreThink();
ADDRGP4 PlayerPreThink
CALLV
pop
LABELV $42
line 123
;123:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $14
JUMPV
LABELV $44
line 126
;124:
;125:	case GAME_CLIENT_POSTTHINK:
;126:		self = PROG_TO_EDICT( g_globalvars.self );
ADDRGP4 self
ADDRGP4 g_globalvars+112
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 127
;127:		if ( !arg0 )
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $46
line 128
;128:			PlayerPostThink();
ADDRGP4 PlayerPostThink
CALLV
pop
ADDRGP4 $47
JUMPV
LABELV $46
line 130
;129:		else
;130:			SpectatorThink();
ADDRGP4 SpectatorThink
CALLV
pop
LABELV $47
line 131
;131:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $14
JUMPV
LABELV $48
line 134
;132:
;133:	case GAME_EDICT_TOUCH:
;134:		G_EdictTouch();
ADDRGP4 G_EdictTouch
CALLV
pop
line 135
;135:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $14
JUMPV
LABELV $49
line 138
;136:
;137:	case GAME_EDICT_THINK:
;138:		G_EdictThink();
ADDRGP4 G_EdictThink
CALLV
pop
line 139
;139:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $14
JUMPV
LABELV $50
line 142
;140:
;141:	case GAME_EDICT_BLOCKED:
;142:		G_EdictBlocked();
ADDRGP4 G_EdictBlocked
CALLV
pop
line 143
;143:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $14
JUMPV
LABELV $51
line 146
;144:
;145:	case GAME_SETCHANGEPARMS: //called before spawn new server for save client params
;146:		self = PROG_TO_EDICT( g_globalvars.self );
ADDRGP4 self
ADDRGP4 g_globalvars+112
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 147
;147:		SetChangeParms();
ADDRGP4 SetChangeParms
CALLV
pop
line 148
;148:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $14
JUMPV
LABELV $53
line 151
;149:
;150:	case GAME_CLIENT_COMMAND:
;151:	        self = PROG_TO_EDICT( g_globalvars.self );
ADDRGP4 self
ADDRGP4 g_globalvars+112
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 152
;152:		return ClientCommand();
ADDRLP4 12
ADDRGP4 ClientCommand
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $14
JUMPV
LABELV $55
line 159
;153:
;154:	case GAME_CLIENT_USERINFO_CHANGED:
;155:		// called on user /cmd setinfo	if value changed
;156:		// return not zero dont allow change
;157:		// params like GAME_CLIENT_COMMAND, but argv(0) always "setinfo" and argc always 3
;158:
;159:		self = PROG_TO_EDICT( g_globalvars.self );
ADDRGP4 self
ADDRGP4 g_globalvars+112
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 160
;160:		return ClientUserInfoChanged();
ADDRLP4 16
ADDRGP4 ClientUserInfoChanged
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
ADDRGP4 $14
JUMPV
LABELV $57
line 163
;161:
;162:	case GAME_SHUTDOWN:
;163:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $14
JUMPV
LABELV $58
line 175
;164:
;165:	case GAME_CONSOLE_COMMAND:
;166:	        
;167:		// called on server console command "mod"
;168:		// params like GAME_CLIENT_COMMAND, but argv(0) always "mod"
;169:		// self - rconner if can detect else world
;170:		// other 
;171:		//SV_CMD_CONSOLE		0          
;172:		//SV_CMD_RCON			1  
;173:		//SV_CMD_MASTER		2          
;174:		//SV_CMD_BOT			3  
;175:		self = PROG_TO_EDICT( g_globalvars.self );
ADDRGP4 self
ADDRGP4 g_globalvars+112
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 176
;176:		ModCommand();
ADDRGP4 ModCommand
CALLV
pop
line 177
;177:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $14
JUMPV
LABELV $15
line 180
;178:	}
;179:	
;180:	return 0;
CNSTI4 0
RETI4
LABELV $14
endproc vmMain 20 12
export G_InitGame
proc G_InitGame 8 12
line 187
;181:}
;182:
;183:
;184://===================================================================
;185:
;186:void G_InitGame( int levelTime, int randomSeed )
;187:{
line 194
;188:	int             i;
;189:/*	int num;
;190:	char		dirlist[1024];
;191:	char*		dirptr;
;192:	int dirlen;*/
;193://Common Initialization
;194:	srand( randomSeed );
ADDRFP4 4
INDIRI4
CVIU4 4
ARGU4
ADDRGP4 srand
CALLV
pop
line 195
;195:	framecount = 0;
ADDRGP4 framecount
CNSTI4 0
ASGNI4
line 196
;196:	starttime = levelTime * 0.001;
ADDRGP4 starttime
CNSTF4 981668463
ADDRFP4 0
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 197
;197:	G_dprintf( "Init Game\n" );
ADDRGP4 $62
ARGP4
ADDRGP4 G_dprintf
CALLV
pop
line 199
;198:	//G_InitMemory();
;199:	memset( g_edicts, 0, sizeof( gedict_t ) * MAX_EDICTS );
ADDRGP4 g_edicts
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1400832
ARGI4
ADDRGP4 memset
CALLP4
pop
line 202
;200:	
;201:
;202:	world->s.v.model = worldmodel;
ADDRGP4 world
INDIRP4
CNSTI4 220
ADDP4
ADDRGP4 worldmodel
ASGNP4
line 203
;203:	g_globalvars.mapname = mapname;
ADDRGP4 g_globalvars+140
ADDRGP4 mapname
ASGNP4
line 204
;204:	for ( i = 0; i < MAX_CLIENTS; i++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $64
line 205
;205:	{
line 206
;206:		g_edicts[i + 1].s.v.netname = netnames[i]; //Init client names
CNSTI4 1824
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_edicts+1824+112+284
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 netnames
ADDP4
ASGNP4
line 207
;207:	}
LABELV $65
line 204
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $64
line 209
;208://TF Intialization
;209:	memset( &tf_data, 0, sizeof(tf_data));
ADDRGP4 tf_data
ARGP4
CNSTI4 0
ARGI4
CNSTI4 232
ARGI4
ADDRGP4 memset
CALLP4
pop
line 210
;210:	memset( &tg_data, 0, sizeof(tg_data));
ADDRGP4 tg_data
ARGP4
CNSTI4 0
ARGI4
CNSTI4 68
ARGI4
ADDRGP4 memset
CALLP4
pop
line 211
;211:	localcmd("serverinfo status Standby\n");
ADDRGP4 $71
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 219
;212://test
;213:/*        num = trap_FS_GetFileList( "SKINS" , ".pcx" , dirlist, sizeof(dirlist));
;214:        dirptr=dirlist;
;215:	for (i = 0; i < num; i++, dirptr += dirlen+1) {
;216:		dirlen = strlen(dirptr);
;217:		G_Printf("%s\n",dirptr);
;218:	}*/
;219:}
LABELV $61
endproc G_InitGame 8 12
export G_EdictTouch
proc G_EdictTouch 0 4
line 235
;220:
;221:
;222:
;223:
;224://===========================================================================
;225:// Physics
;226:// 
;227://===========================================================================
;228:////////////////
;229:// GlobalParams:
;230:// time
;231:// self
;232:// other
;233:///////////////
;234:void G_EdictTouch()
;235:{
line 236
;236:	self = PROG_TO_EDICT( g_globalvars.self );
ADDRGP4 self
ADDRGP4 g_globalvars+112
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 237
;237:	other = PROG_TO_EDICT( g_globalvars.other );
ADDRGP4 other
ADDRGP4 g_globalvars+116
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 238
;238:	if ( self->s.v.touch )
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
CNSTI4 0
EQI4 $75
line 239
;239:	{
line 245
;240:/*#ifdef DEBUG
;241:	        if(self->s.v.classname && other->s.v.classname)
;242:	        	if(!strcmp(self->s.v.classname,"player")||!strcmp(other->s.v.classname,"player"))
;243:	         G_dprintf( "touch %s <-> %s\n", self->s.v.classname,other->s.v.classname);
;244:#endif*/
;245:		( ( void ( * )() ) ( self->s.v.touch ) ) ();
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
CVIU4 4
CVUP4 4
CALLV
pop
line 246
;246:	} else
ADDRGP4 $76
JUMPV
LABELV $75
line 247
;247:	{
line 248
;248:		G_dprintf( "Null touch func" );
ADDRGP4 $77
ARGP4
ADDRGP4 G_dprintf
CALLV
pop
line 249
;249:	}
LABELV $76
line 250
;250:}
LABELV $72
endproc G_EdictTouch 0 4
export G_EdictThink
proc G_EdictThink 0 4
line 259
;251:
;252:////////////////
;253:// GlobalParams:
;254:// time
;255:// self
;256:// other=world
;257:///////////////
;258:void G_EdictThink()
;259:{
line 260
;260:	self = PROG_TO_EDICT( g_globalvars.self );
ADDRGP4 self
ADDRGP4 g_globalvars+112
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 261
;261:	other = PROG_TO_EDICT( g_globalvars.other );
ADDRGP4 other
ADDRGP4 g_globalvars+116
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 262
;262:	if ( self->s.v.think )
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
CNSTI4 0
EQI4 $81
line 263
;263:	{
line 264
;264:		( ( void ( * )() ) ( self->s.v.think ) ) ();
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
CVIU4 4
CVUP4 4
CALLV
pop
line 265
;265:	} else
ADDRGP4 $82
JUMPV
LABELV $81
line 266
;266:	{
line 267
;267:		G_dprintf( "Null think func" );
ADDRGP4 $83
ARGP4
ADDRGP4 G_dprintf
CALLV
pop
line 268
;268:	}
LABELV $82
line 270
;269:
;270:}
LABELV $78
endproc G_EdictThink 0 4
export G_EdictBlocked
proc G_EdictBlocked 0 0
line 281
;271:
;272:////////////////
;273:// GlobalParams:
;274:// time
;275:// self=pusher
;276:// other=check
;277:// if the pusher has a "blocked" function, call it
;278:// otherwise, just stay in place until the obstacle is gone
;279:///////////////
;280:void G_EdictBlocked()
;281:{
line 282
;282:	self = PROG_TO_EDICT( g_globalvars.self );
ADDRGP4 self
ADDRGP4 g_globalvars+112
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 283
;283:	other = PROG_TO_EDICT( g_globalvars.other );
ADDRGP4 other
ADDRGP4 g_globalvars+116
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 285
;284:
;285:	if ( self->s.v.blocked )
ADDRGP4 self
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
CNSTI4 0
EQI4 $87
line 286
;286:	{
line 287
;287:		( ( void ( * )() ) ( self->s.v.blocked ) ) ();
ADDRGP4 self
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
CVIU4 4
CVUP4 4
CALLV
pop
line 288
;288:	} else
LABELV $87
line 289
;289:	{
line 293
;290:#ifdef PARANOID
;291:		G_dprintf("Null blocked func");
;292:#endif
;293:	}
LABELV $88
line 295
;294:
;295:}
LABELV $84
endproc G_EdictBlocked 0 0
export ClearGlobals
proc ClearGlobals 8 4
line 299
;296:
;297:float sv_gravity;
;298:void ClearGlobals()
;299:{
line 300
;300:	damage_attacker = damage_inflictor = activator = self = other = newmis = world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 other
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 activator
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 damage_inflictor
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 damage_attacker
ADDRLP4 0
INDIRP4
ASGNP4
line 301
;301:	sv_gravity = trap_cvar("sv_gravity");
ADDRGP4 $90
ARGP4
ADDRLP4 4
ADDRGP4 trap_cvar
CALLF4
ASGNF4
ADDRGP4 sv_gravity
ADDRLP4 4
INDIRF4
ASGNF4
line 302
;302:}
LABELV $89
endproc ClearGlobals 8 4
import ClientUserInfoChanged
import ClientCommand
import StartFrame
bss
export starttime
align 4
LABELV starttime
skip 4
align 1
LABELV netnames
skip 1024
align 1
LABELV mapname
skip 64
import ambient_sound
import sandball_goal
import ballstart
import ball
import func_glass
import trigger_jumper
import TeamFortress_NightVision
import s2_explode1
import EjectShell
import FlashTimer
import BalloonMIRV
import player_mtf_nail1
import unlay
import lay
import mtf_deathmsg
import ModCommand
import CheckAutoKick
import Menu_Class_Input
import Menu_Team_Input
import Menu_Input
import Player_Menu
import StatusRes
import RefreshStatusBar
import Throw_Grapple
import Service_Grapple
import Reset_Grapple
import crossproduct
import CenterPrint
import bubble_bob
import bubble_remove
import make_bubbles
import infront
import range
import visible
import muzzleflash
import KickPlayer
import GetInfokeyInt
import GetInfokeyString
import GetSVInfokeyFloat
import GetSVInfokeyInt
import GetSVInfokeyString
import build_number
import ANGEL_VERSION
import display_location
import dremove
import spawn_tdeath
import spawn_tfog
import Respawn_Item
import bound_other_ammo
import DropBackpack
import DropRing
import DropQuad
import T_Heal
import CanDamage
import TF_T_Damage
import T_BeamDamage
import T_RadiusDamage
import T_Damage
import damage_inflictor
import damage_attacker
import launch_spike
import T_MissileTouch
import W_PrintWeaponMessage
import Attack_Finished
import Multi_Finish
import AddMultiDamage
import ApplyMultiDamage
import TraceAttack
import ClearMultiDamage
import BecomeExplosion
import W_FireLaser
import W_FireTranq
import W_FireIncendiaryCannon
import W_FireFlame
import W_FireSpikes
import W_FireSuperSpikes
import W_FireGrenade
import W_FireLightning
import W_FireRocket
import W_FireAssaultCannon
import W_FireAutoRifle
import W_FireSniperRifle
import W_FireSuperShotgun
import W_FireShotgun
import W_FireBioweapon
import W_FireMedikit
import W_FireSpanner
import W_FireAxe
import W_WeaponFrame
import DeadImpulses
import PreMatchImpulses
import SpawnBlood
import W_SetCurrentAmmo
import W_Precache
import W_BestWeapon
import puff_org
import SpectatorThink
import SpectatorDisconnect
import SpectatorConnect
import SuperDamageSound
import PlayerPostThink
import PlayerPreThink
import ClientDisconnect
import PutClientInServer
import ClientConnect
import SetNewParms
import SetChangeParms
import modelindex_null
import modelindex_player
import modelindex_eyes
import intermission_exittime
import intermission_running
import CopyToBodyQue
import SUB_Null
import SUB_Remove
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
import G_SpawnEntitiesFromString
import G_Alloc
import activator
import SUB_AttackFinished
import InitTrigger
import SetMovedir
import SUB_UseTargets
import SUB_CalcMoveEnt
import SUB_CalcMove
import disableupdates
import WriteEntity
import infokey
import logfrag
import setspawnparam
import makestatic
import checkbottom
import walkmove
import droptofloor
import TraceCapsule
import traceline
import checkclient
import sound
import setmodel
import setsize
import setorigin
import aim
import strneq
import streq
import stuffcmd
import localcmd
import G_centerprint
import G_bprint
import G_sprint
import makevectors
import changeyaw
import vectoangles
import vectoyaw
import vlen
import normalize
import findradius
import nextent
import ent_remove
import spawn
import rint
import crandom
import g_random
import crc32
import G_conprintf
import G_Error
import G_dprintf
export api_ver
align 4
LABELV api_ver
skip 4
import coop
import framecount
import deathmatch
import teamplay
import fraglimit
import timelimit
import newmis
export other
align 4
LABELV other
skip 4
export self
align 4
LABELV self
skip 4
export g_globalvars
align 4
LABELV g_globalvars
skip 360
export g_edicts
align 4
LABELV g_edicts
skip 1400832
import tf_data
import NUM_FOR_EDICT
import Eng_DispUnload
import Eng_DispLoad
import Eng_SGReload
import Eng_SGUp
import Eng_StaticSG_Activate
import TG_LoadSettings
import TG_Eff_Remove
import TG_Eff_Flash
import TG_Eff_Conc
import tg_data
import current_vote
import votes
import bot_frametime
import BotImpulseMenu
import BotImpulse
import GoForResupply
import CheckForResupply
import AttackTargets
import AttackVisible
import UseGren
import DitchGrens
import HandleGrens
import DodgeEnemyGrenades
import DodgeEnemy
import LeadAim
import InstantAim
import AimHere
import FindTargets
import PickBestWeapon
import ClearAllTargets
import ClearTarget
import AddTarget
import AllTargetsFull
import ReloadWeapons
import DoMovement
import MoveToLocation
import GotoLocation
import GetKeysByLoc
import GetKeysByDir
import StrafeRight
import StrafeLeft
import PickAName
import ClearAllWaypoints
import Bot_AI
import botDisconnect
import botConnect
import BotFrame
import WaypointFindPath
import FreePath
import AddLink
import AddWaypoint
import WaypointFindNearest
import WaypointFindNearestVisible
import WaypointFindByType
import WaypointFindVisible
import WaypointFindInRadius
import default_link
import TeamFortress_PrepareForArenaRespawn
import TeamFortress_isTeamsAllied
import TeamFortress_CanGetWeapon
import TeamFortress_GetMaxAmmo
import DoGroupWork
import DoGoalWork
import TeamFortress_AutoID
import decrement_team_ammoboxes
import increment_team_ammoboxes
import TeamFortress_TeamGetIllegalClasses
import CanisterTouch
import ScatterCaltrops
import CaltropTouch
import FlashGrenadeExplode
import FlashGrenadeTouch
import EMPGrenadeExplode
import EMPGrenadeTouch
import GasGrenadeExplode
import GasGrenadeTouch
import NapalmGrenadeExplode
import NapalmGrenadeTouch
import MirvGrenadeExplode
import MirvGrenadeTouch
import NailGrenadeExplode
import NailGrenadeTouch
import ConcussionGrenadeExplode
import ConcussionGrenadeTouch
import NormalGrenadeExplode
import NormalGrenadeTouch
import FlareGrenadeTouch
import FlareGrenadeExplode
import TeamFortress_AmmoboxTouch
import TeamFortress_ExplodePerson
import TeamFortress_RegenerateCells
import TeamFortress_Regenerate
import SelectSpawnPoint
import execute_changelevel
import ForceRespawn
import ReturnItem
import tfgoalitem_checkgoalreturn
import tfgoalitem_drop
import RemoveResults
import DoTriggerWork
import DoItemGroupWork
import SetupRespawn
import APMeetsCriteria
import Apply_Results
import IsAffectedBy
import RestoreGoal
import InactivateGoal
import Findteamspawn
import TF_StartGoal
import TF_PlaceGoal
import TF_StartItem
import TF_PlaceItem
import TeamFortress_TeamIncreaseScore
import DoRespawn
import info_tfgoal_use
import tfgoalitem_remove
import tfgoal_timer_tick
import item_tfgoal_touch
import tfgoal_touch
import RemoveGoal
import TeamFortress_DisplayDetectionItems
import DoResults
import tfgoalitem_RemoveFromPlayer
import tfgoalitem_GiveToPlayer
import SetupTeamEqualiser
import ParseTFDetect
import CheckExistence
import AttemptToActivate
import Activated
import Findgoal
import Finditem
import DisplayItemStatus
import teamsprint
import TeamFortress_TeamShowScores
import TeamFortress_TeamSet
import SetTeamName
import ClassIsRestricted
import TeamFortress_TeamIsCivilian
import TeamFortress_GetNoPlayers
import TeamFortress_TeamGetTopColor
import TeamFortress_TeamGetColor
import TeamFortress_DetpackExplode
import TeamFortress_CheckTeamCheats
import TeamFortress_TeamGetSecond
import TeamFortress_TeamGetScore
import TeamFortress_TeamGetWinner
import GetTeamName
import TeamEqualiseDamage
import Admin_CeaseFire
import Admin_DoKick
import Admin_CycleKick
import Admin_CountPlayers
import PreMatch_Think
import CeaseFire_think
import BirthdayTimer
import CTF_FlagCheck
import CheckBelowBuilding
import TF_zoom
import TeamFortress_Build
import DestroyBuilding
import Engineer_RemoveBuildings
import ScannerSwitch
import BioInfection_MonsterDecay
import BioInfection_Decay
import Engineer_UseMortar
import Engineer_UseSentryGun
import Engineer_UseDispenser
import TeamFortress_SetDetpack
import TeamFortress_Scan_Angel
import TeamFortress_Scan
import RemoveOldFlare
import RemoveFlare
import UseSpecialSkill
import DropKey
import SniperSight_Create
import TeamFortress_DetpackStop
import PipebombTouch
import OldConcussionGrenadeTimer
import ConcussionGrenadeTimer
import DropGoalItems
import DumpClanScores
import TF_MovePlayer
import TeamFortress_HelpMap
import TeamFortress_MOTD
import TeamFortress_CTF_FlagInfo
import TeamFortress_TeamShowMemberClasses_New
import TeamFortress_EngineerBuild
import TeamFortress_SpyGoUndercover
import TeamFortress_StatusQuery
import TeamFortress_AutoZoomToggle
import TeamFortress_ReloadCurrentWeapon
import TeamFortress_DetonatePipebombs
import TeamFortress_Discard
import TeamFortress_ThrowGrenade
import TeamFortress_PrimeGrenade
import TeamFortress_FlameThrower
import TeamFortress_IncendiaryCannon
import TeamFortress_AssaultWeapon
import TeamFortress_SniperWeapon
import TeamFortress_ShowTF
import TeamFortress_ShowIDs
import TeamFortress_ID
import TeamFortress_SaveMe
import TeamFortress_Inventory
import TeamFortress_DisplayLegalClasses
import TeamFortress_TeamGetLives
import TeamFortress_TeamGetMaxPlayers
import TeamFortress_TeamGetNoPlayers
import TeamFortress_TeamShowMemberClasses
import TeamFortress_AmmoboxRemove
import TeamFortress_GetSkinByTeamClass
import TeamFortress_GetSkin
import TeamFortress_TeamGetColorString
import TeamFortress_Alias
import KickCheater
import TeamFortress_TeamPutPlayerInTeam
import TeamFortress_ExecMapScript
import TeamFortress_ExecClassScript
import TeamFortress_SetColor
import TeamFortress_SetSkin
import TeamFortress_SetSpeed
import TeamFortress_SetHealth
import TeamFortress_SetEquipment
import TeamFortress_PrintClassName
import TeamFortress_DescribeArmor
import IsLegalClass
import TeamFortress_CheckClassStats
import TeamFortress_ChangeClass
import TeamFortress_SetupRespawn
import TeamFortress_RemoveTimers
import TF_AddFrags
import TeamFortress_GetClassName
import set_suicide_frame
import PlayerDie
import GibPlayer
import KillPlayer
import PlayerDead
import DeathSound
import DeathBubblesSpawn
import player_die_ax1
import player_diee1
import player_died1
import player_diec1
import player_dieb1
import player_diea1
import player_pain
import player_axpain6
import player_axpain5
import player_axpain4
import player_axpain3
import player_axpain2
import player_axpain1
import player_pain6
import player_pain5
import player_pain4
import player_pain3
import player_pain2
import player_pain1
import PainSound
import player_rocket6
import player_rocket5
import player_rocket4
import player_rocket3
import player_rocket2
import player_rocket1
import player_light2
import player_light1
import player_assaultcannondown1
import player_assaultcannon2
import player_assaultcannon1
import player_assaultcannonup2
import player_assaultcannonup1
import player_nail2
import player_nail1
import player_bioweapond4
import player_bioweapond3
import player_bioweapond2
import player_bioweapond1
import player_bioweaponc4
import player_bioweaponc3
import player_bioweaponc2
import player_bioweaponc1
import player_bioweaponb4
import player_bioweaponb3
import player_bioweaponb2
import player_bioweaponb1
import player_bioweapon4
import player_bioweapon3
import player_bioweapon2
import player_bioweapon1
import player_medikitd4
import player_medikitd3
import player_medikitd2
import player_medikitd1
import player_medikitc4
import player_medikitc3
import player_medikitc2
import player_medikitc1
import player_medikitb4
import player_medikitb3
import player_medikitb2
import player_medikitb1
import player_medikit4
import player_medikit3
import player_medikit2
import player_medikit1
import player_chain5
import player_chain4
import player_chain3
import player_chain2a
import player_chain2
import player_chain1a
import player_chain1
import player_axed4
import player_axed3
import player_axed2
import player_axed1
import player_axec4
import player_axec3
import player_axec2
import player_axec1
import player_axeb4
import player_axeb3
import player_axeb2
import player_axeb1
import player_axe4
import player_axe3
import player_axe2
import player_axe1
import player_autorifle3
import player_autorifle2
import player_autorifle1
import player_shot6
import player_shot5
import player_shot4
import player_shot3
import player_shot2
import player_shot1
import player_touch
import player_run
import player_stand1
import Headless_Think
import ThrowGib
import spy_upaxe9
import spy_upaxe8
import spy_upaxe7
import spy_upaxe6
import spy_upaxe5
import spy_upaxe4
import spy_upaxe3
import spy_upaxe2
import spy_upaxe1
import spy_upe9
import spy_upe8
import spy_upe7
import spy_upe6
import spy_upe5
import spy_upe4
import spy_upe3
import spy_upe2
import spy_upe1
import spy_upd9
import spy_upd8
import spy_upd7
import spy_upd6
import spy_upd5
import spy_upd4
import spy_upd3
import spy_upd2
import spy_upd1
import spy_upc15
import spy_upc14
import spy_upc13
import spy_upc12
import spy_upc11
import spy_upc10
import spy_upc9
import spy_upc8
import spy_upc7
import spy_upc6
import spy_upc5
import spy_upc4
import spy_upc3
import spy_upc2
import spy_upc1
import spy_upb9
import spy_upb8
import spy_upb7
import spy_upb6
import spy_upb5
import spy_upb4
import spy_upb3
import spy_upb2
import spy_upb1
import spy_die_ax9
import spy_die_ax8
import spy_die_ax7
import spy_die_ax6
import spy_die_ax5
import spy_die_ax4
import spy_die_ax3
import spy_die_ax2
import spy_die_ax1
import spy_diee9
import spy_diee8
import spy_diee7
import spy_diee6
import spy_diee5
import spy_diee4
import spy_diee3
import spy_diee2
import spy_diee1
import spy_died9
import spy_died8
import spy_died7
import spy_died6
import spy_died5
import spy_died4
import spy_died3
import spy_died2
import spy_died1
import spy_diec15
import spy_diec14
import spy_diec13
import spy_diec12
import spy_diec11
import spy_diec10
import spy_diec9
import spy_diec8
import spy_diec7
import spy_diec6
import spy_diec5
import spy_diec4
import spy_diec3
import spy_diec2
import spy_diec1
import spy_dieb9
import spy_dieb8
import spy_dieb7
import spy_dieb6
import spy_dieb5
import spy_dieb4
import spy_dieb3
import spy_dieb2
import spy_dieb1
import spy_diea11
import spy_diea10
import spy_diea9
import spy_diea8
import spy_diea7
import spy_diea6
import spy_diea5
import spy_diea4
import spy_diea3
import spy_diea2
import spy_diea1
import TeamFortress_SpyFeignDeath
import TeamFortress_SpyChangeColor
import TeamFortress_SpyChangeSkin
import Spy_RemoveDisguise
import ResetGasSkins
import SetGasSkins
import TranquiliserTimer
import HallucinationTimer
import trap_SetBotCMD
import trap_SetBotUserInfo
import trap_RemoveBot
import trap_AddBot
import trap_Map_Extension
import trap_FS_GetFileList
import trap_FS_TellFile
import trap_FS_SeekFile
import trap_FS_WriteFile
import trap_FS_ReadFile
import trap_FS_CloseFile
import trap_FS_OpenFile
import trap_TraceCapsule
import trap_CmdArgv
import trap_CmdArgc
import trap_disableupdates
import trap_FlushSignon
import trap_WriteEntity
import trap_WriteString
import trap_WriteCoord
import trap_WriteAngle
import trap_WriteLong
import trap_WriteShort
import trap_WriteChar
import trap_WriteByte
import trap_infokey
import trap_logfrag
import trap_multicast
import trap_changelevel
import trap_setspawnparam
import trap_makestatic
import trap_find
import trap_nextent
import trap_pointcontents
import trap_checkbottom
import trap_lightstyle
import trap_walkmove
import trap_droptofloor
import trap_cvar_set_float
import trap_cvar_set
import trap_cvar_string
import trap_cvar
import trap_redirectcmd
import trap_readcmd
import trap_executecmd
import trap_localcmd
import trap_stuffcmd
import trap_traceline
import trap_checkclient
import trap_sound
import trap_ambientsound
import trap_setmodel
import trap_setsize
import trap_setorigin
import trap_precache_model
import trap_precache_sound
import trap_remove
import trap_spawn
import trap_Error
import trap_CenterPrint
import trap_SPrint
import trap_BPrint
import trap_conprint
import trap_DPrintf
import trap_GetEntityToken
import trap_GetApiVersion
import GR_TYPE_NAPALM_NO
import GR_TYPE_MIRV_NO
import MAX_WORLD_AMMOBOXES
import MAX_WORLD_PIPEBOMBS
import FLAME_MAXWORLDNUM
import team_menu_string
import rj
import CTF_Map
import teams_allied
import teammaxplayers
import teamlives
import teamfrags
import teamscores
import civilianteams
import illegalclasses
import number_of_teams
import skill
export sv_gravity
align 4
LABELV sv_gravity
skip 4
import MD5Transform
import MD5Final
import MD5Update
import MD5Init
import RotatePointAroundVector
import anglemod
import BoxOnPlaneSide
import AngleVectors
import GreatestCommonDivisor
import Mul16_30
import Invert24To16
import FloorDivMod
import R_ConcatTransforms
import R_ConcatRotations
import Q_log2
import VectorScale
import VectorInverse
import VectorNormalize
import CrossProduct
import VectorLength
import VectorCompareF
import VectorCompare
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import VectorMA
import nanmask
import vec3_origin
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_strrchr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import FloatSwap
import LongSwap
import ShortSwap
import alloca_reset
import alloca
import realloc
import free
import malloc
import calloc
import memcmp
import asin
import abs
import acos
import fabs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import sscanf
import _snprintf
import _vsnprintf
import vsprintf
import _atoi
import atoi
import _atof
import atof
import toupper
import tolower
import strncpy
import strstr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $90
byte 1 115
byte 1 118
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $83
byte 1 78
byte 1 117
byte 1 108
byte 1 108
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 107
byte 1 32
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 0
align 1
LABELV $77
byte 1 78
byte 1 117
byte 1 108
byte 1 108
byte 1 32
byte 1 116
byte 1 111
byte 1 117
byte 1 99
byte 1 104
byte 1 32
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 0
align 1
LABELV $71
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 32
byte 1 83
byte 1 116
byte 1 97
byte 1 110
byte 1 100
byte 1 98
byte 1 121
byte 1 10
byte 1 0
align 1
LABELV $62
byte 1 73
byte 1 110
byte 1 105
byte 1 116
byte 1 32
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $20
byte 1 77
byte 1 111
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 113
byte 1 117
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 65
byte 1 80
byte 1 73
byte 1 95
byte 1 86
byte 1 69
byte 1 82
byte 1 83
byte 1 73
byte 1 79
byte 1 78
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 104
byte 1 105
byte 1 103
byte 1 104
byte 1 101
byte 1 114
byte 1 44
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $13
byte 1 105
byte 1 115
byte 1 66
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $12
byte 1 103
byte 1 114
byte 1 97
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $11
byte 1 109
byte 1 97
byte 1 120
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
