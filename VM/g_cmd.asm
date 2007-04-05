lit
align 4
LABELV cmds
address $11
address ClientKill
skip 4
address $12
address Test
skip 4
address $13
address Bot
byte 4 32
address $14
address TG_Cmd
byte 4 32
address $15
address Vote_Cmd
byte 4 1
address $16
address Client_Set_Cmd
skip 4
address $17
address Admin_Cmd
byte 4 32
address $18
address TeamFortress_Cmd_Discard
byte 4 91
address $19
address Engineer_RotateSG
byte 4 91
address $20
address TeamFortress_Cmd_Detpack
byte 4 27
byte 4 0
byte 4 0
byte 4 0
export ClientCommand
code
proc ClientCommand 1056 16
file "..\src\g_cmd.c"
line 70
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
;20: *  $Id: g_cmd.c,v 1.25 2006/03/04 15:10:06 AngelD Exp $
;21: */
;22:
;23:#include "g_local.h"
;24:
;25:
;26:#define CMD_NOT_PREMATCH 	1
;27:#define CMD_NOT_DEAD		2
;28:#define CMD_NOT_ATTACK		4
;29:#define CMD_NOT_TEAM		8
;30:#define CMD_NOT_CLASS		16
;31:#define CMD_SPECTATOR_ALLOWED	32
;32:#define CMD_NOT_BUILD	        64
;33:
;34:
;35:typedef struct cmd_s{
;36:	char   *command;
;37:	void    ( *Action ) (  );
;38:	int     allowed;
;39:} cmd_t;
;40:
;41:void    ClientKill(  );
;42:void    Test(  );
;43:void    Bot();
;44:void    RemoveBot(  );
;45:void    TG_Cmd(  );
;46:void    Vote_Cmd(  );
;47:void    TeamFortress_Cmd_Discard(  );
;48:void    Engineer_RotateSG(  );
;49:void    TeamFortress_Cmd_Detpack(  );
;50:void    Admin_Cmd(  );
;51:void    Client_Set_Cmd(  );
;52:
;53:const static cmd_t   cmds[] = {
;54:	{"kill", ClientKill},
;55:	{"test", Test},
;56:	{"bot", Bot, CMD_SPECTATOR_ALLOWED},
;57:	{"tg", TG_Cmd, CMD_SPECTATOR_ALLOWED},
;58:	{"vote", Vote_Cmd, CMD_NOT_PREMATCH},
;59:        {"set", Client_Set_Cmd},
;60:	{"admin", Admin_Cmd, CMD_SPECTATOR_ALLOWED},
;61:	{"discard", TeamFortress_Cmd_Discard, CMD_NOT_PREMATCH | CMD_NOT_DEAD | CMD_NOT_TEAM | CMD_NOT_CLASS | CMD_NOT_BUILD},
;62:	{"sg_rotate", Engineer_RotateSG, CMD_NOT_PREMATCH | CMD_NOT_DEAD | CMD_NOT_TEAM | CMD_NOT_CLASS | CMD_NOT_BUILD},
;63:	{"detpack", TeamFortress_Cmd_Detpack, CMD_NOT_PREMATCH | CMD_NOT_DEAD | CMD_NOT_TEAM | CMD_NOT_CLASS },
;64:	{NULL, NULL, 0}
;65:};
;66:extern void trap_CmdArgv( int arg, char *valbuff, int sizebuff );
;67:
;68:
;69:qboolean ClientCommand(  )
;70:{
line 74
;71:	char    cmd_command[1024];
;72:	const cmd_t  *ucmd;
;73:
;74:	self = PROG_TO_EDICT( g_globalvars.self );
ADDRGP4 self
ADDRGP4 g_globalvars+112
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 76
;75:
;76:	trap_CmdArgv( 0, cmd_command, sizeof( cmd_command ) );
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 77
;77:	for ( ucmd = cmds; ucmd->command; ucmd++ )
ADDRLP4 0
ADDRGP4 cmds
ASGNP4
ADDRGP4 $26
JUMPV
LABELV $23
line 78
;78:	{
line 79
;79:		if ( strcmp( cmd_command, ucmd->command ) )
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRLP4 1028
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
EQI4 $27
line 80
;80:			continue;
ADDRGP4 $24
JUMPV
LABELV $27
line 81
;81:		if ( (!( ucmd->allowed & CMD_SPECTATOR_ALLOWED )) && self->isSpectator)
ADDRLP4 1032
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 32
BANDI4
ADDRLP4 1032
INDIRI4
NEI4 $29
ADDRGP4 self
INDIRP4
CNSTI4 1480
ADDP4
INDIRI4
ADDRLP4 1032
INDIRI4
EQI4 $29
line 82
;82:		{     
line 83
;83:			G_sprint( self, 2, "cmd '%s' not allowed for spectators\n", cmd_command );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $31
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 84
;84:			return true;
CNSTI4 1
RETI4
ADDRGP4 $21
JUMPV
LABELV $29
line 86
;85: 	        }
;86:		if ( ( ucmd->allowed & CMD_NOT_PREMATCH )
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $32
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $32
line 88
;87:		     && ( tf_data.cb_prematch_time > g_globalvars.time ) )
;88:		{
line 89
;89:			G_sprint( self, 2, "cmd '%s' not allowed in prematch\n", cmd_command );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $36
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 90
;90:			return true;
CNSTI4 1
RETI4
ADDRGP4 $21
JUMPV
LABELV $32
line 93
;91:		}
;92:
;93:		if ( ( ucmd->allowed & CMD_NOT_DEAD ) && ( self->s.v.deadflag ) )
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $37
ADDRGP4 self
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
CNSTF4 0
EQF4 $37
line 94
;94:			return true;
CNSTI4 1
RETI4
ADDRGP4 $21
JUMPV
LABELV $37
line 96
;95:
;96:		if ( ( ucmd->allowed & CMD_NOT_ATTACK ) && ( g_globalvars.time < self->attack_finished ) )
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $39
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
GEF4 $39
line 97
;97:			return true;
CNSTI4 1
RETI4
ADDRGP4 $21
JUMPV
LABELV $39
line 99
;98:
;99:		if ( ( ucmd->allowed & CMD_NOT_TEAM ) && ( !self->team_no ) )
ADDRLP4 1036
CNSTI4 8
ASGNI4
ADDRLP4 1040
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 1036
INDIRI4
ADDP4
INDIRI4
ADDRLP4 1036
INDIRI4
BANDI4
ADDRLP4 1040
INDIRI4
EQI4 $42
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 1040
INDIRI4
NEI4 $42
line 100
;100:			return true;
CNSTI4 1
RETI4
ADDRGP4 $21
JUMPV
LABELV $42
line 102
;101:
;102:		if ( ( ucmd->allowed & CMD_NOT_CLASS ) && ( !self->playerclass ) )
ADDRLP4 1044
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 1044
INDIRI4
EQI4 $44
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ADDRLP4 1044
INDIRI4
NEI4 $44
line 103
;103:			return true;
CNSTI4 1
RETI4
ADDRGP4 $21
JUMPV
LABELV $44
line 104
;104:		if ( ( ucmd->allowed & CMD_NOT_BUILD ) && ( self->is_building || self->is_detpacking || self->is_feigning ) )
ADDRLP4 1048
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 64
BANDI4
ADDRLP4 1048
INDIRI4
EQI4 $46
ADDRLP4 1052
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
CNSTI4 872
ADDP4
INDIRI4
ADDRLP4 1048
INDIRI4
NEI4 $49
ADDRLP4 1052
INDIRP4
CNSTI4 876
ADDP4
INDIRI4
ADDRLP4 1048
INDIRI4
NEI4 $49
ADDRLP4 1052
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
ADDRLP4 1048
INDIRI4
EQI4 $46
LABELV $49
line 105
;105:			return true;
CNSTI4 1
RETI4
ADDRGP4 $21
JUMPV
LABELV $46
line 108
;106:
;107:
;108:		ucmd->Action(  );
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 109
;109:		return true;
CNSTI4 1
RETI4
ADDRGP4 $21
JUMPV
LABELV $24
line 77
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
LABELV $26
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $23
line 111
;110:	}
;111:	return false;
CNSTI4 0
RETI4
LABELV $21
endproc ClientCommand 1056 16
export ClientUserInfoChanged
proc ClientUserInfoChanged 2088 12
line 118
;112:}
;113:
;114:
;115:qboolean SetClientSetting( gedict_t*p , const char*key, const char* value );
;116:
;117:qboolean ClientUserInfoChanged(  )
;118:{
line 124
;119:	char    key[1024];
;120:	char    value[1024];
;121:	const   char   *sk;
;122:	int     color;
;123:
;124:	self = PROG_TO_EDICT( g_globalvars.self );
ADDRGP4 self
ADDRGP4 g_globalvars+112
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 126
;125:
;126:	trap_CmdArgv( 1, key, sizeof( key ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 127
;127:	trap_CmdArgv( 2, value, sizeof( value ) );
CNSTI4 2
ARGI4
ADDRLP4 1024
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 129
;128:
;129:	if ( !strcmp( key, "team" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $54
ARGP4
ADDRLP4 2056
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2056
INDIRI4
CNSTI4 0
NEI4 $52
line 130
;130:	{
line 131
;131:		if ( !self->team_no )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 0
NEI4 $55
line 132
;132:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $50
JUMPV
LABELV $55
line 133
;133:		sk = GetTeamName( self->team_no );
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 2060
ADDRGP4 GetTeamName
CALLP4
ASGNP4
ADDRLP4 2048
ADDRLP4 2060
INDIRP4
ASGNP4
line 134
;134:		if ( strneq( value, sk ) )
ADDRLP4 1024
ARGP4
ADDRLP4 2048
INDIRP4
ARGP4
ADDRLP4 2064
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 2064
INDIRI4
CNSTI4 0
EQI4 $57
line 135
;135:		{
line 136
;136:			SetTeamName( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 SetTeamName
CALLV
pop
line 137
;137:			G_sprint( self, 2, "you cannot change your team setinfo\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $59
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 138
;138:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $50
JUMPV
LABELV $57
line 140
;139:		}
;140:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $50
JUMPV
LABELV $52
line 142
;141:	}
;142:	if ( !strcmp( key, "skin" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $62
ARGP4
ADDRLP4 2060
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2060
INDIRI4
CNSTI4 0
NEI4 $60
line 143
;143:	{
line 144
;144:		if ( !self->playerclass || !self->team_no )
ADDRLP4 2064
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 2068
CNSTI4 0
ASGNI4
ADDRLP4 2064
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ADDRLP4 2068
INDIRI4
EQI4 $65
ADDRLP4 2064
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 2068
INDIRI4
NEI4 $63
LABELV $65
line 145
;145:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $50
JUMPV
LABELV $63
line 146
;146:		sk = TeamFortress_GetSkin( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 2072
ADDRGP4 TeamFortress_GetSkin
CALLP4
ASGNP4
ADDRLP4 2048
ADDRLP4 2072
INDIRP4
ASGNP4
line 147
;147:		if ( strneq( value, sk ) )
ADDRLP4 1024
ARGP4
ADDRLP4 2048
INDIRP4
ARGP4
ADDRLP4 2076
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 2076
INDIRI4
CNSTI4 0
EQI4 $66
line 148
;148:		{
line 149
;149:			G_sprint( self, 2, "you cannot change your skin setinfo\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $68
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 150
;150:			TeamFortress_SetSkin( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSkin
CALLV
pop
line 151
;151:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $50
JUMPV
LABELV $66
line 153
;152:		}
;153:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $50
JUMPV
LABELV $60
line 155
;154:	}
;155:	if ( ( !strcmp( key, "topcolor" ) ) && tf_data.topcolor_check )
ADDRLP4 0
ARGP4
ADDRGP4 $71
ARGP4
ADDRLP4 2064
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2068
CNSTI4 0
ASGNI4
ADDRLP4 2064
INDIRI4
ADDRLP4 2068
INDIRI4
NEI4 $69
ADDRGP4 tf_data+104
INDIRI4
ADDRLP4 2068
INDIRI4
EQI4 $69
line 156
;156:	{
line 157
;157:		if ( !self->team_no )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 0
NEI4 $73
line 158
;158:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $50
JUMPV
LABELV $73
line 159
;159:		color = atoi( value );
ADDRLP4 1024
ARGP4
ADDRLP4 2072
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 2052
ADDRLP4 2072
INDIRI4
ASGNI4
line 160
;160:		if ( self->playerclass == PC_SPY && self->undercover_team )
ADDRLP4 2076
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 2076
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $75
ADDRLP4 2076
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
CNSTI4 0
EQI4 $75
line 161
;161:		{
line 162
;162:			if ( TeamFortress_TeamGetTopColor( self->undercover_team ) != color )
ADDRGP4 self
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ARGI4
ADDRLP4 2080
ADDRGP4 TeamFortress_TeamGetTopColor
CALLI4
ASGNI4
ADDRLP4 2080
INDIRI4
ADDRLP4 2052
INDIRI4
EQI4 $76
line 163
;163:			{
line 164
;164:				G_sprint( self, 2, "you cannot change your topcolor setinfo\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $79
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 165
;165:				return 1;
CNSTI4 1
RETI4
ADDRGP4 $50
JUMPV
line 167
;166:			}
;167:		} else
LABELV $75
line 168
;168:		{
line 169
;169:			if ( TeamFortress_TeamGetTopColor( self->team_no ) != color )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 2080
ADDRGP4 TeamFortress_TeamGetTopColor
CALLI4
ASGNI4
ADDRLP4 2080
INDIRI4
ADDRLP4 2052
INDIRI4
EQI4 $80
line 170
;170:			{
line 171
;171:				G_sprint( self, 2, "you cannot change your topcolor setinfo\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $79
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 172
;172:				return 1;
CNSTI4 1
RETI4
ADDRGP4 $50
JUMPV
LABELV $80
line 174
;173:			}
;174:		}
LABELV $76
line 175
;175:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $50
JUMPV
LABELV $69
line 178
;176:	}
;177:
;178:	if ( ( !strcmp( key, "bottomcolor" ) ) )
ADDRLP4 0
ARGP4
ADDRGP4 $84
ARGP4
ADDRLP4 2072
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2072
INDIRI4
CNSTI4 0
NEI4 $82
line 179
;179:	{
line 180
;180:		if ( !self->team_no )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 0
NEI4 $85
line 181
;181:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $50
JUMPV
LABELV $85
line 182
;182:		color = atoi( value );
ADDRLP4 1024
ARGP4
ADDRLP4 2076
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 2052
ADDRLP4 2076
INDIRI4
ASGNI4
line 183
;183:		if ( self->playerclass == PC_SPY && self->undercover_team )
ADDRLP4 2080
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 2080
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $87
ADDRLP4 2080
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
CNSTI4 0
EQI4 $87
line 184
;184:		{
line 185
;185:			if ( TeamFortress_TeamGetColor( self->undercover_team ) - 1 != color )
ADDRGP4 self
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ARGI4
ADDRLP4 2084
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRLP4 2084
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 2052
INDIRI4
EQI4 $88
line 186
;186:			{
line 187
;187:				G_sprint( self, 2, "you cannot change your bottomcolor setinfo\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $91
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 188
;188:				return 1;
CNSTI4 1
RETI4
ADDRGP4 $50
JUMPV
line 190
;189:			}
;190:		} else
LABELV $87
line 191
;191:		{
line 192
;192:			if ( TeamFortress_TeamGetColor( self->team_no ) - 1 != color )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 2084
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRLP4 2084
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 2052
INDIRI4
EQI4 $92
line 193
;193:			{
line 194
;194:				G_sprint( self, 2, "you cannot change your bottomcolor setinfo\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $91
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 195
;195:				return 1;
CNSTI4 1
RETI4
ADDRGP4 $50
JUMPV
LABELV $92
line 197
;196:			}
;197:		}
LABELV $88
line 198
;198:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $50
JUMPV
LABELV $82
line 201
;199:	}
;200:
;201:	SetClientSetting( self, Q_strlwr( key ), value);
ADDRLP4 0
ARGP4
ADDRLP4 2076
ADDRGP4 Q_strlwr
CALLP4
ASGNP4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 2076
INDIRP4
ARGP4
ADDRLP4 1024
ARGP4
ADDRGP4 SetClientSetting
CALLI4
pop
line 202
;202:	return 0;
CNSTI4 0
RETI4
LABELV $50
endproc ClientUserInfoChanged 2088 12
export Test
proc Test 8 20
line 207
;203:
;204:}
;205:
;206:void Test(  )
;207:{
line 208
;208:        G_sprint( self, 2, "fire_held_down %d button0 %.0f\n", self->fire_held_down,self->s.v.button0 );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $95
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1448
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 209
;209:        G_sprint( self, 2, "movetype  %.0f solid %.0f\n", self->s.v.movetype,self->s.v.solid );
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $96
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 148
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 152
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 210
;210:        G_sprint( self, 2, "toggleflags %d\n", tf_data.toggleflags );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $97
ARGP4
ADDRGP4 tf_data
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 211
;211:}
LABELV $94
endproc Test 8 20
import SetClientSetting
import Client_Set_Cmd
import Admin_Cmd
import TeamFortress_Cmd_Detpack
import Engineer_RotateSG
import TeamFortress_Cmd_Discard
import Vote_Cmd
import TG_Cmd
import RemoveBot
import Bot
import ClientKill
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
LABELV $97
byte 1 116
byte 1 111
byte 1 103
byte 1 103
byte 1 108
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $96
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 32
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 115
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $95
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 95
byte 1 104
byte 1 101
byte 1 108
byte 1 100
byte 1 95
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 48
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $91
byte 1 121
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
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 116
byte 1 111
byte 1 109
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 10
byte 1 0
align 1
LABELV $84
byte 1 98
byte 1 111
byte 1 116
byte 1 116
byte 1 111
byte 1 109
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $79
byte 1 121
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
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 116
byte 1 111
byte 1 112
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 10
byte 1 0
align 1
LABELV $71
byte 1 116
byte 1 111
byte 1 112
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $68
byte 1 121
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
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 10
byte 1 0
align 1
LABELV $62
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $59
byte 1 121
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
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 10
byte 1 0
align 1
LABELV $54
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $36
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 10
byte 1 0
align 1
LABELV $31
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $20
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $19
byte 1 115
byte 1 103
byte 1 95
byte 1 114
byte 1 111
byte 1 116
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $18
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $17
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $16
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $15
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $14
byte 1 116
byte 1 103
byte 1 0
align 1
LABELV $13
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $12
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $11
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
