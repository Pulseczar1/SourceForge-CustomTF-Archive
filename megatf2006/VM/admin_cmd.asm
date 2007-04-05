lit
align 4
LABELV max_adminlevel
byte 4 100
align 4
LABELV admin_cmds
address $11
address Admin_Auth
byte 4 0
address $12
address Admin_Kick
byte 4 1
address $13
address Admin_Map
byte 4 2
address $14
address Admin_Status
byte 4 3
address $15
address Admin_Ban
byte 4 3
address $16
address Admin_BanList
byte 4 3
address $17
address Admin_UnBan
byte 4 3
address $18
address Admin_Console
byte 4 999
address $19
address Red_Def_command
byte 4 1
byte 4 0
byte 4 0
byte 4 0
code
proc CheckString 24 0
file "..\src\admin_cmd.c"
line 59
;1:/*
;2: *  QWProgs-TF2003
;3: *  Copyright (C) 2004  [sd] angel
;4: *
;5: *
;6: *  This program is free software; you can redistribute it and/or modify
;7: *  it under the terms of the GNU General Public License as published by
;8: *  the Free Software Foundation; either version 2 of the License, or
;9: *  (at your option) any later version.
;10: *
;11: *  This program is distributed in the hope that it will be useful,
;12: *  but WITHOUT ANY WARRANTY; without even the implied warranty of
;13: *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;14: *  GNU General Public License for more details.
;15: *
;16: *  You should have received a copy of the GNU General Public License
;17: *  along with this program; if not, write to the Free Software
;18: *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
;19: *
;20: *
;21: *  $Id: admin_cmd.c,v 1.13 2006/03/09 20:54:16 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:typedef struct admin_cmd_s{
;26:	char		*command;
;27:	void		(*Action) (int);
;28:	int		level;
;29:}admin_cmd_t;
;30:
;31:static void Admin_Auth(int argc);
;32://void Admin_ListPlayers(int argc);
;33:static void Admin_Status(int argc);
;34:static void Admin_Kick(int argc);
;35:static void Admin_Ban(int argc);
;36:static void Admin_UnBan(int argc);
;37:static void Admin_BanList(int argc);
;38:static void Admin_Console(int argc);
;39:static void Admin_Map(int argc);
;40:void Red_Def_command( int argc );
;41:
;42:static const int max_adminlevel = 100;
;43:static const admin_cmd_t admin_cmds[] = 
;44:{
;45:	{"auth", Admin_Auth,0},
;46://	{"listplayers", Admin_ListPlayers, 1},
;47:	{"kick", Admin_Kick, 1},
;48:	{"map", Admin_Map, 2},
;49:	{"status", Admin_Status, 3},
;50:	{"ban", Admin_Ban, 3},
;51:	{"banlist", Admin_BanList, 3},
;52:	{"unban", Admin_UnBan, 3},
;53:	{"console", Admin_Console, 999},
;54:	{"red_def", Red_Def_command, 1},
;55:	{NULL,NULL,0}
;56:};
;57:
;58:static int CheckString(char *str)
;59:{
line 60
;60:	char *strp =str,ch;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $22
JUMPV
LABELV $21
line 62
;61:	while(ch = *strp++)
;62:	{
line 63
;63:		switch(ch)
ADDRLP4 8
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 16
CNSTI4 34
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $27
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
GTI4 $29
LABELV $28
ADDRLP4 8
INDIRI4
CNSTI4 8
EQI4 $27
ADDRLP4 8
INDIRI4
CNSTI4 10
EQI4 $27
ADDRLP4 8
INDIRI4
CNSTI4 13
EQI4 $27
ADDRGP4 $24
JUMPV
LABELV $29
ADDRLP4 8
INDIRI4
CNSTI4 59
EQI4 $27
ADDRGP4 $24
JUMPV
line 64
;64:		{
LABELV $27
line 70
;65:			case ';':
;66:			case 0x0d:
;67:			case 0x0a:
;68:			case '\b':
;69:			case '"':
;70:				return 0;
CNSTI4 0
RETI4
ADDRGP4 $20
JUMPV
LABELV $24
line 72
;71:		}
;72:	}
LABELV $22
line 61
ADDRLP4 8
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
INDIRI1
ASGNI1
ADDRLP4 0
ADDRLP4 12
INDIRI1
ASGNI1
ADDRLP4 12
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $21
line 73
;73:	return 1;
CNSTI4 1
RETI4
LABELV $20
endproc CheckString 24 0
export Admin_Cmd
proc Admin_Cmd 1040 16
line 77
;74:}
;75:
;76:void Admin_Cmd()
;77:{
line 82
;78:	int argc;
;79:	char    cmd_command[1024];
;80:	const admin_cmd_t* ucmd;
;81:
;82:	argc = trap_CmdArgc();
ADDRLP4 1032
ADDRGP4 trap_CmdArgc
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 1032
INDIRI4
ASGNI4
line 84
;83:
;84:	if( argc == 1 )
ADDRLP4 1028
INDIRI4
CNSTI4 1
NEI4 $31
line 85
;85:	{
line 86
;86:	        G_sprint( self, 2, "Allowed admin commands:\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $33
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 87
;87:		for ( ucmd = admin_cmds ; ucmd->command  ; ucmd++ )
ADDRLP4 0
ADDRGP4 admin_cmds
ASGNP4
ADDRGP4 $37
JUMPV
LABELV $34
line 88
;88:		{
line 89
;89:			if( self->is_admin >= ucmd->level )
ADDRGP4 self
INDIRP4
CNSTI4 1564
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
LTI4 $38
line 90
;90:			{
line 91
;91:				G_sprint( self, 2, "%s\n",ucmd->command);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $40
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 92
;92:			}
LABELV $38
line 93
;93:		}
LABELV $35
line 87
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
LABELV $37
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $34
line 94
;94:		return;
ADDRGP4 $30
JUMPV
LABELV $31
line 96
;95:	}
;96:	trap_CmdArgv( 1, cmd_command, sizeof( cmd_command ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 97
;97:	for ( ucmd = admin_cmds ; ucmd->command  ; ucmd++ )
ADDRLP4 0
ADDRGP4 admin_cmds
ASGNP4
ADDRGP4 $44
JUMPV
LABELV $41
line 98
;98:	{
line 99
;99:		if( !strcmp(cmd_command,ucmd->command) )
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $45
line 100
;100:		{
line 101
;101:			if( self->is_admin >= ucmd->level )
ADDRGP4 self
INDIRP4
CNSTI4 1564
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
LTI4 $47
line 102
;102:			{
line 103
;103:				ucmd->Action(argc);
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 104
;104:			        return;
ADDRGP4 $30
JUMPV
LABELV $47
line 106
;105:			}else
;106:			{
line 107
;107:				G_sprint( self, 2, "You have limited Access, You cannot use this command.\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $49
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 108
;108:			        return;
ADDRGP4 $30
JUMPV
LABELV $45
line 111
;109:			}
;110:		}
;111:	}
LABELV $42
line 97
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
LABELV $44
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $41
line 112
;112:	G_sprint( self, 2, "Unknown admin command.\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $50
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 113
;113:}
LABELV $30
endproc Admin_Cmd 1040 16
proc Admin_FindPlayerById 12 16
line 116
;114:
;115:static gedict_t* Admin_FindPlayerById(int id)
;116:{
line 122
;117:	
;118:    	int i;
;119:    	int plid;
;120:    	
;121:
;122:	for ( i = 0 ; i < MAX_CLIENTS ; i++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $52
line 123
;123:	{
line 125
;124:
;125:		if( g_edicts[i + 1].s.v.netname[0]  == 0)
CNSTI4 1824
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_edicts+1824+112+284
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $56
line 126
;126:			continue;
ADDRGP4 $53
JUMPV
LABELV $56
line 127
;127:		plid = GetInfokeyInt( &g_edicts[i + 1], "*userid", NULL, -1 );
CNSTI4 1824
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_edicts+1824
ADDP4
ARGP4
ADDRGP4 $62
ARGP4
CNSTP4 0
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 8
ADDRGP4 GetInfokeyInt
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 128
;128:		if( id == plid)
ADDRFP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $63
line 129
;129:			return &g_edicts[i + 1];
CNSTI4 1824
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_edicts+1824
ADDP4
RETP4
ADDRGP4 $51
JUMPV
LABELV $63
line 130
;130:	}
LABELV $53
line 122
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $52
line 131
;131:	return NULL;
CNSTP4 0
RETP4
LABELV $51
endproc Admin_FindPlayerById 12 16
proc Admin_Auth 216 20
line 136
;132:}
;133:
;134:
;135:static void Admin_Auth(int argc)
;136:{
line 140
;137:        char    sv_admin_pwd[100];
;138:        char    admin_pwd[100];
;139:
;140:	if( argc != 3)
ADDRFP4 0
INDIRI4
CNSTI4 3
EQI4 $67
line 141
;141:	{
line 142
;142:	        G_sprint( self, 2, "Usage: cmd admin auth <password>\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $69
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 143
;143:		return;
ADDRGP4 $66
JUMPV
LABELV $67
line 145
;144:	}
;145:	if( self->auth_time > g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 1584
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $70
line 146
;146:	        return;
ADDRGP4 $66
JUMPV
LABELV $70
line 148
;147:
;148:	self->auth_time = g_globalvars.time + 10;
ADDRGP4 self
INDIRP4
CNSTI4 1584
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 150
;149:
;150:	trap_CmdArgv( 2, admin_pwd, sizeof( admin_pwd ) );
CNSTI4 2
ARGI4
ADDRLP4 100
ARGP4
CNSTI4 100
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 152
;151:
;152:	if(!GetSVInfokeyString( "apw", "adminpwn", sv_admin_pwd, sizeof( sv_admin_pwd ), "" ))
ADDRGP4 $76
ARGP4
ADDRGP4 $77
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 100
ARGI4
ADDRGP4 $78
ARGP4
ADDRLP4 200
ADDRGP4 GetSVInfokeyString
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
NEI4 $74
line 153
;153:	{
line 154
;154:		return;
ADDRGP4 $66
JUMPV
LABELV $74
line 158
;155:	}
;156:
;157:	
;158:	if( !strcmp(admin_pwd,sv_admin_pwd) )
ADDRLP4 100
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 204
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
NEI4 $79
line 159
;159:	{
line 160
;160:		self->is_admin = GetSVInfokeyInt("adminlevel",NULL,1);
ADDRGP4 $81
ARGP4
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 208
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 1564
ADDP4
ADDRLP4 208
INDIRI4
ASGNI4
line 161
;161:		if( self->is_admin )
ADDRGP4 self
INDIRP4
CNSTI4 1564
ADDP4
INDIRI4
CNSTI4 0
EQI4 $82
line 162
;162:		{
line 163
;163:	        	G_sprint( self, 2, "You gain admin level %d\n",self->is_admin);
ADDRLP4 212
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 212
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $84
ARGP4
ADDRLP4 212
INDIRP4
CNSTI4 1564
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 164
;164:	        	if( self->is_admin > max_adminlevel )
ADDRGP4 self
INDIRP4
CNSTI4 1564
ADDP4
INDIRI4
ADDRGP4 max_adminlevel
INDIRI4
LEI4 $66
line 165
;165:	        	        self->is_admin = max_adminlevel;
ADDRGP4 self
INDIRP4
CNSTI4 1564
ADDP4
ADDRGP4 max_adminlevel
INDIRI4
ASGNI4
line 166
;166:	        	return;
LABELV $82
line 168
;167:		}
;168:	}
LABELV $79
line 170
;169:        
;170:}
LABELV $66
endproc Admin_Auth 216 20
proc Admin_Kick 120 16
line 188
;171:
;172:/*void Admin_ListPlayers(int argc)
;173:{
;174:    	int i;
;175:    	G_sprint( self, 2, "Players:\n");
;176:
;177:	for ( i = 0 ; i < MAX_CLIENTS ; i++ )
;178:	{
;179:
;180:		if( g_edicts[i + 1].s.v.netname[0] )
;181:		{
;182:			G_sprint( self, 2, "%2d %c %s\n", i, g_edicts[i + 1].is_admin?'A':' ',g_edicts[i + 1].s.v.netname);
;183:		}
;184:	}
;185:}*/
;186:
;187:static void Admin_Kick(int argc)
;188:{
line 193
;189:	char    value[100];
;190:	gedict_t*p;
;191:	int id;
;192:
;193:	if( argc != 3)
ADDRFP4 0
INDIRI4
CNSTI4 3
EQI4 $88
line 194
;194:	{
line 195
;195:	        G_sprint( self, 2, "Usage: cmd admin kick <userid>\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $90
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 196
;196:		return;
ADDRGP4 $87
JUMPV
LABELV $88
line 199
;197:	}
;198:
;199:	trap_CmdArgv( 2, value, sizeof( value ) );
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 100
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 200
;200:	id = atoi(value);
ADDRLP4 4
ARGP4
ADDRLP4 108
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 104
ADDRLP4 108
INDIRI4
ASGNI4
line 201
;201:	p = Admin_FindPlayerById(id);
ADDRLP4 104
INDIRI4
ARGI4
ADDRLP4 112
ADDRGP4 Admin_FindPlayerById
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 112
INDIRP4
ASGNP4
line 202
;202:	if(!p)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $91
line 203
;203:	{
line 204
;204:		G_sprint( self, 2,"Invalid player id\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $93
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 205
;205:		return;
ADDRGP4 $87
JUMPV
LABELV $91
line 208
;206:	}
;207:
;208:        G_bprint(  2, "%s was kicked by %s\n",p->s.v.netname, self->s.v.netname);
CNSTI4 2
ARGI4
ADDRGP4 $94
ARGP4
ADDRLP4 116
CNSTI4 396
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 116
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ADDRLP4 116
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 210
;209://	localcmd("kick %d",id);
;210:	KickCheater( p );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 KickCheater
CALLV
pop
line 211
;211:}
LABELV $87
endproc Admin_Kick 120 16
proc Admin_Ban 116 24
line 214
;212:
;213:static void Admin_Ban(int argc)
;214:{
line 219
;215:	char    value[100];
;216:	int id;
;217:	gedict_t*p;
;218:
;219:	if( argc != 3)
ADDRFP4 0
INDIRI4
CNSTI4 3
EQI4 $96
line 220
;220:	{
line 221
;221:	        G_sprint( self, 2, "Usage: cmd admin ban <userid>\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $98
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 222
;222:		return;
ADDRGP4 $95
JUMPV
LABELV $96
line 225
;223:	}
;224:
;225:	trap_CmdArgv( 2, value, sizeof( value ) );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 100
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 226
;226:	id = atoi(value);
ADDRLP4 0
ARGP4
ADDRLP4 108
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 104
ADDRLP4 108
INDIRI4
ASGNI4
line 227
;227:	p = Admin_FindPlayerById(id);
ADDRLP4 104
INDIRI4
ARGI4
ADDRLP4 112
ADDRGP4 Admin_FindPlayerById
CALLP4
ASGNP4
ADDRLP4 100
ADDRLP4 112
INDIRP4
ASGNP4
line 228
;228:	if(!p)
ADDRLP4 100
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $99
line 229
;229:	{
line 230
;230:		G_sprint( self, 2,"Invalid player id\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $93
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 231
;231:		return;
ADDRGP4 $95
JUMPV
LABELV $99
line 234
;232:	}
;233:	
;234:	GetInfokeyString( p , "ip", NULL, value, sizeof( value ), "" );
ADDRLP4 100
INDIRP4
ARGP4
ADDRGP4 $101
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 100
ARGI4
ADDRGP4 $78
ARGP4
ADDRGP4 GetInfokeyString
CALLI4
pop
line 235
;235:	G_sprint( self, 2,"banning ip %s\n", value);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $102
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 236
;236:	localcmd("addip %s\n",value);
ADDRGP4 $103
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 237
;237:	trap_executecmd();
ADDRGP4 trap_executecmd
CALLV
pop
line 238
;238:}
LABELV $95
endproc Admin_Ban 116 24
proc Admin_UnBan 104 12
line 241
;239:
;240:static void Admin_UnBan(int argc)
;241:{
line 244
;242:	char    value[100];
;243:
;244:	if( argc != 3)
ADDRFP4 0
INDIRI4
CNSTI4 3
EQI4 $105
line 245
;245:	{
line 246
;246:	        G_sprint( self, 2, "Usage: cmd admin unban <ipmask>\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $107
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 247
;247:		return;
ADDRGP4 $104
JUMPV
LABELV $105
line 250
;248:	}
;249:
;250:	trap_CmdArgv( 2, value, sizeof( value ) );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 100
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 252
;251:
;252:	if(!CheckString(value))
ADDRLP4 0
ARGP4
ADDRLP4 100
ADDRGP4 CheckString
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $108
line 253
;253:		return;
ADDRGP4 $104
JUMPV
LABELV $108
line 255
;254:
;255:	localcmd("removeip \"%s\"\n",value);
ADDRGP4 $110
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 256
;256:	trap_executecmd();
ADDRGP4 trap_executecmd
CALLV
pop
line 257
;257:}
LABELV $104
endproc Admin_UnBan 104 12
proc Admin_BanList 0 4
line 260
;258:
;259:static void Admin_BanList(int argc)
;260:{
line 261
;261:	localcmd("listip\n");
ADDRGP4 $112
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 262
;262:	trap_executecmd();
ADDRGP4 trap_executecmd
CALLV
pop
line 263
;263:}
LABELV $111
endproc Admin_BanList 0 4
proc Admin_Status 0 4
line 266
;264:
;265:static void Admin_Status(int argc)
;266:{
line 267
;267:	localcmd("status\n");
ADDRGP4 $114
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 268
;268:	trap_executecmd();
ADDRGP4 trap_executecmd
CALLV
pop
line 269
;269:}
LABELV $113
endproc Admin_Status 0 4
proc Admin_Map 104 12
line 272
;270:
;271:static void Admin_Map(int argc)
;272:{
line 275
;273:	char    value[100];
;274:
;275:	if( argc != 3)
ADDRFP4 0
INDIRI4
CNSTI4 3
EQI4 $116
line 276
;276:	{
line 277
;277:	        G_sprint( self, 2, "Usage: cmd admin map <mapname>\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $118
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 278
;278:		return;
ADDRGP4 $115
JUMPV
LABELV $116
line 281
;279:	}
;280:
;281:	trap_CmdArgv( 2, value, sizeof( value ) );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 100
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 282
;282:	if(!CheckString(value))
ADDRLP4 0
ARGP4
ADDRLP4 100
ADDRGP4 CheckString
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $119
line 283
;283:		return;
ADDRGP4 $115
JUMPV
LABELV $119
line 284
;284:	localcmd("map \"%s\"\n",value);
ADDRGP4 $121
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 286
;285://	trap_executecmd();
;286:}
LABELV $115
endproc Admin_Map 104 12
proc Admin_Console 1024 12
line 289
;287:
;288:static void Admin_Console(int argc)
;289:{
line 291
;290:        char    value[1024];
;291:	if( argc != 3)
ADDRFP4 0
INDIRI4
CNSTI4 3
EQI4 $123
line 292
;292:	{
line 293
;293:		return;
ADDRGP4 $122
JUMPV
LABELV $123
line 296
;294:	}
;295:
;296:        trap_CmdArgv( 2, value, sizeof( value ) );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 298
;297:
;298:        localcmd("%s\n",value);
ADDRGP4 $40
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 299
;299:        trap_executecmd();
ADDRGP4 trap_executecmd
CALLV
pop
line 300
;300:}
LABELV $122
endproc Admin_Console 1024 12
import Red_Def_command
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
import api_ver
import coop
import framecount
import deathmatch
import teamplay
import fraglimit
import timelimit
import newmis
import other
import self
import world
import g_globalvars
import g_edicts
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
import sv_gravity
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
LABELV $121
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $118
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 60
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 62
byte 1 10
byte 1 0
align 1
LABELV $114
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $112
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 105
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $110
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 105
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $107
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 117
byte 1 110
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 60
byte 1 105
byte 1 112
byte 1 109
byte 1 97
byte 1 115
byte 1 107
byte 1 62
byte 1 10
byte 1 0
align 1
LABELV $103
byte 1 97
byte 1 100
byte 1 100
byte 1 105
byte 1 112
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $102
byte 1 98
byte 1 97
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 112
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $101
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $98
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 60
byte 1 117
byte 1 115
byte 1 101
byte 1 114
byte 1 105
byte 1 100
byte 1 62
byte 1 10
byte 1 0
align 1
LABELV $94
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $93
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 105
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $90
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 60
byte 1 117
byte 1 115
byte 1 101
byte 1 114
byte 1 105
byte 1 100
byte 1 62
byte 1 10
byte 1 0
align 1
LABELV $84
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 103
byte 1 97
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $81
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $78
byte 1 0
align 1
LABELV $77
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 112
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $76
byte 1 97
byte 1 112
byte 1 119
byte 1 0
align 1
LABELV $69
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 117
byte 1 116
byte 1 104
byte 1 32
byte 1 60
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 62
byte 1 10
byte 1 0
align 1
LABELV $62
byte 1 42
byte 1 117
byte 1 115
byte 1 101
byte 1 114
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $50
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $49
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 65
byte 1 99
byte 1 99
byte 1 101
byte 1 115
byte 1 115
byte 1 44
byte 1 32
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $40
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $33
byte 1 65
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $19
byte 1 114
byte 1 101
byte 1 100
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 0
align 1
LABELV $18
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 111
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $17
byte 1 117
byte 1 110
byte 1 98
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $16
byte 1 98
byte 1 97
byte 1 110
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $15
byte 1 98
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $14
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $13
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $12
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $11
byte 1 97
byte 1 117
byte 1 116
byte 1 104
byte 1 0
