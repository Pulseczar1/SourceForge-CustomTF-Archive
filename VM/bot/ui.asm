data
export bot_cmds
align 4
LABELV bot_cmds
address $11
address AddBot
address $12
address RemoveBot
address $13
address ResupplySetBot
address $14
address BotReport
address $15
address BotSet
byte 4 0
skip 4
export BotReport
code
proc BotReport 20 40
file "..\src\bot\ui.c"
line 48
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
;21: *  $Id: ui.c,v 1.8 2006/03/04 15:10:06 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:typedef struct bot_cmd_s{
;26:	char		*command;
;27:	void		(*func) ();
;28:}bot_cmd_t;
;29:
;30:void AddBot(  );
;31:void RemoveBot(  );
;32:void ResupplySetBot();
;33:void BotReport();
;34:void BotSet();
;35:void BotTest();
;36:bot_cmd_t bot_cmds[]=
;37:{
;38:	{"add", AddBot},
;39:	{"remove", RemoveBot},
;40:	{"resupply", ResupplySetBot},
;41:	{"report", BotReport},
;42:	{"set", BotSet},
;43://	{"test", BotTest},
;44:	{NULL}
;45:};
;46:
;47:void BotReport(  )
;48:{
line 52
;49:	gedict_t *te;
;50:
;51:
;52:	for ( te = world; ( te = trap_find( te, FOFS( s.v.classname ), "player" ) ); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $20
JUMPV
LABELV $17
line 53
;53:	{
line 54
;54:		if ( te->has_disconnected )
ADDRLP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
EQI4 $22
line 55
;55:			continue;
ADDRGP4 $18
JUMPV
LABELV $22
line 56
;56:		if ( te->isBot )
ADDRLP4 0
INDIRP4
CNSTI4 1652
ADDP4
INDIRI4
CNSTI4 0
EQI4 $24
line 57
;57:		{
line 58
;58:                   G_bprint(3,"Bot: %s, state %d, menu %d flags %d velocity %3.0f\norigin [%.0f %.0f %.0f]\n",
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 vlen
CALLF4
ASGNF4
CNSTI4 3
ARGI4
ADDRGP4 $26
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1664
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_bprint
CALLV
pop
line 65
;59:                           te->s.v.netname,te->action,te->current_menu,
;60:                           (int)(te->s.v.flags),
;61:                           vlen(te->s.v.velocity),
;62:                           PASSVEC3(te->s.v.origin)
;63:                   );
;64:
;65:                   if( te->wp )
ADDRLP4 0
INDIRP4
CNSTI4 1748
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $27
line 66
;66:                       G_bprint(3, "wp     [%.0f %.0f %.0f]\n", PASSVEC3(te->wp->origin));
CNSTI4 3
ARGI4
ADDRGP4 $29
ARGP4
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 1748
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_bprint
CALLV
pop
ADDRGP4 $28
JUMPV
LABELV $27
line 68
;67:                   else
;68:                       G_bprint(3, "nowp\n");
CNSTI4 3
ARGI4
ADDRGP4 $30
ARGP4
ADDRGP4 G_bprint
CALLV
pop
LABELV $28
line 70
;69:
;70:                   if( te->end_wp )
ADDRLP4 0
INDIRP4
CNSTI4 1752
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $31
line 71
;71:                       G_bprint(3, "endwp  [%.0f %.0f %.0f]\n", PASSVEC3(te->end_wp->origin));
CNSTI4 3
ARGI4
ADDRGP4 $33
ARGP4
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 1752
ADDP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_bprint
CALLV
pop
LABELV $31
line 73
;72:
;73:		}
LABELV $24
line 74
;74:	}
LABELV $18
line 52
LABELV $20
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $21
ARGP4
ADDRLP4 4
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $17
line 75
;75:}
LABELV $16
endproc BotReport 20 40
export AddBot
proc AddBot 1056 12
line 78
;76:
;77:void AddBot(  )
;78:{
line 83
;79:	char    value[1024];
;80:	int     team, class, argc;
;81:	char*  name;
;82:
;83:	argc = trap_CmdArgc(  );
ADDRLP4 1040
ADDRGP4 trap_CmdArgc
CALLI4
ASGNI4
ADDRLP4 1024
ADDRLP4 1040
INDIRI4
ASGNI4
line 85
;84:
;85:	if ( argc < 4 )
ADDRLP4 1024
INDIRI4
CNSTI4 4
GEI4 $35
line 86
;86:	{
line 87
;87:		G_sprint( self, 2, "usage: cmd bot add <team> <class> [<name>]\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $37
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 88
;88:		return;
ADDRGP4 $34
JUMPV
LABELV $35
line 91
;89:	}
;90:
;91:	trap_CmdArgv( 2, value, sizeof( value ) );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 92
;92:	team = atoi( value );
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 1044
INDIRI4
ASGNI4
line 93
;93:	trap_CmdArgv( 3, value, sizeof( value ) );
CNSTI4 3
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 94
;94:	class = atoi( value );
ADDRLP4 0
ARGP4
ADDRLP4 1048
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1048
INDIRI4
ASGNI4
line 95
;95:	if( argc >= 5 )
ADDRLP4 1024
INDIRI4
CNSTI4 5
LTI4 $38
line 96
;96:	{
line 97
;97:	        trap_CmdArgv( 4, value, sizeof( value ) );
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 98
;98:	        name = value;
ADDRLP4 1036
ADDRLP4 0
ASGNP4
line 99
;99:	}else
ADDRGP4 $39
JUMPV
LABELV $38
line 100
;100:	       name = PickAName(  );
ADDRLP4 1052
ADDRGP4 PickAName
CALLP4
ASGNP4
ADDRLP4 1036
ADDRLP4 1052
INDIRP4
ASGNP4
LABELV $39
line 102
;101:
;102:	botConnect( team, class, name );
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 1032
INDIRI4
ARGI4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRGP4 botConnect
CALLV
pop
line 103
;103:}
LABELV $34
endproc AddBot 1056 12
export RemoveBot
proc RemoveBot 8 12
line 107
;104:
;105:
;106:void RemoveBot(  )
;107:{
line 111
;108:	gedict_t *te;
;109:
;110:
;111:	for ( te = world; ( te = trap_find( te, FOFS( s.v.classname ), "player" ) ); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $44
JUMPV
LABELV $41
line 112
;112:	{
line 113
;113:		if ( te->has_disconnected )
ADDRLP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
EQI4 $45
line 114
;114:			continue;
ADDRGP4 $42
JUMPV
LABELV $45
line 115
;115:		if ( te->isBot )
ADDRLP4 0
INDIRP4
CNSTI4 1652
ADDP4
INDIRI4
CNSTI4 0
EQI4 $47
line 116
;116:			break;
ADDRGP4 $43
JUMPV
LABELV $47
line 117
;117:	}
LABELV $42
line 111
LABELV $44
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $21
ARGP4
ADDRLP4 4
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $41
LABELV $43
line 119
;118:
;119:	if ( !te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $49
line 120
;120:		return;
ADDRGP4 $40
JUMPV
LABELV $49
line 121
;121:	botDisconnect( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 botDisconnect
CALLV
pop
line 122
;122:}
LABELV $40
endproc RemoveBot 8 12
export ResupplySetBot
proc ResupplySetBot 1036 12
line 125
;123:
;124:void ResupplySetBot()
;125:{
line 129
;126:        int argc;
;127:        char    value[1024];
;128:
;129:        argc = trap_CmdArgc();
ADDRLP4 1028
ADDRGP4 trap_CmdArgc
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1028
INDIRI4
ASGNI4
line 130
;130:        if( argc != 3 )
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $52
line 131
;131:        {
line 132
;132:                if( tf_data.botResupplyBetweenKills)
ADDRGP4 tf_data+184
INDIRI4
CNSTI4 0
EQI4 $54
line 133
;133:                        G_sprint( self, 2, "Bot Resupply Between Kills: On\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $57
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $51
JUMPV
LABELV $54
line 135
;134:                else
;135:                        G_sprint( self, 2, "Bot Resupply Between Kills: Off\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $58
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 136
;136:		return;
ADDRGP4 $51
JUMPV
LABELV $52
line 139
;137:        }
;138:
;139:        if( tf_data.arena_mode )
ADDRGP4 tf_data+188
INDIRI4
CNSTI4 0
EQI4 $59
line 140
;140:        {
line 141
;141:                tf_data.botResupplyBetweenKills = 0;
ADDRGP4 tf_data+184
CNSTI4 0
ASGNI4
line 142
;142:        }else
ADDRGP4 $60
JUMPV
LABELV $59
line 143
;143:        {
line 144
;144:              trap_CmdArgv( 2, value, sizeof( value ) );
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 145
;145:              if( !strcmp(value,"on") )
ADDRLP4 4
ARGP4
ADDRGP4 $65
ARGP4
ADDRLP4 1032
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $63
line 146
;146:                      tf_data.botResupplyBetweenKills = 1;
ADDRGP4 tf_data+184
CNSTI4 1
ASGNI4
ADDRGP4 $64
JUMPV
LABELV $63
line 148
;147:              else
;148:                      tf_data.botResupplyBetweenKills = 0;
ADDRGP4 tf_data+184
CNSTI4 0
ASGNI4
LABELV $64
line 149
;149:        }
LABELV $60
line 150
;150:        if( tf_data.botResupplyBetweenKills)
ADDRGP4 tf_data+184
INDIRI4
CNSTI4 0
EQI4 $68
line 151
;151:                G_sprint( self, 2, "Bot Resupply Between Kills: On\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $57
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $69
JUMPV
LABELV $68
line 153
;152:        else
;153:                G_sprint( self, 2, "Bot Resupply Between Kills: Off\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $58
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $69
line 155
;154:
;155:}
LABELV $51
endproc ResupplySetBot 1036 12
export Bot
proc Bot 72 16
line 158
;156:
;157:void Bot()
;158:{
line 164
;159:        
;160:        char    cmd_command[50];
;161:        int argc,i;
;162:        bot_cmd_t*ucmd;
;163:
;164:        if( api_ver < 7 )
ADDRGP4 api_ver
INDIRI4
CNSTI4 7
GEI4 $72
line 165
;165:        {
line 166
;166:                G_sprint( self, 2, "Bots disabled (API version %d)\n",api_ver );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $74
ARGP4
ADDRGP4 api_ver
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 167
;167:                return;
ADDRGP4 $71
JUMPV
LABELV $72
line 170
;168:        }
;169:
;170:	if ( !tf_data.enable_bot )
ADDRGP4 tf_data+180
INDIRI4
CNSTI4 0
NEI4 $75
line 171
;171:	{
line 172
;172:		G_sprint( self, 2, "Bots disabled\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $78
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 174
;173://FIXME!!!!
;174:                return;
ADDRGP4 $71
JUMPV
LABELV $75
line 177
;175:	}
;176:
;177:	argc = trap_CmdArgc();
ADDRLP4 64
ADDRGP4 trap_CmdArgc
CALLI4
ASGNI4
ADDRLP4 60
ADDRLP4 64
INDIRI4
ASGNI4
line 179
;178:	
;179:	if( argc == 1 )
ADDRLP4 60
INDIRI4
CNSTI4 1
NEI4 $79
line 180
;180:	{
line 181
;181:	        G_sprint( self, 2, "Avaliable commands\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $81
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 182
;182:		for ( ucmd = bot_cmds ; ucmd->command  ; ucmd++ )
ADDRLP4 0
ADDRGP4 bot_cmds
ASGNP4
ADDRGP4 $85
JUMPV
LABELV $82
line 183
;183:		{
line 184
;184:			G_sprint( self, 2, "%s\n",ucmd->command);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $86
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 185
;185:		}
LABELV $83
line 182
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
LABELV $85
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $82
line 186
;186:		return;
ADDRGP4 $71
JUMPV
LABELV $79
line 189
;187:	}
;188:
;189:	trap_CmdArgv( 1, cmd_command, sizeof( cmd_command ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 50
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 190
;190:	for ( ucmd = bot_cmds,i=0 ; ucmd->command  ; ucmd++,i++ )
ADDRLP4 0
ADDRGP4 bot_cmds
ASGNP4
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRGP4 $90
JUMPV
LABELV $87
line 191
;191:	{
line 192
;192:		if( !strcmp(cmd_command,ucmd->command) )
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $91
line 193
;193:		{
line 194
;194:			ucmd->func();
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 195
;195:			return;
ADDRGP4 $71
JUMPV
LABELV $91
line 197
;196:		}
;197:	}
LABELV $88
line 190
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 56
ADDRLP4 56
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $90
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $87
line 198
;198:}
LABELV $71
endproc Bot 72 16
export BotSet
proc BotSet 68 16
line 202
;199:
;200:extern float max_yaw_per_sek;
;201:void BotSet()
;202:{
line 206
;203:        char    cmd_command[50];
;204:        int argc;
;205:
;206:        argc = trap_CmdArgc();
ADDRLP4 56
ADDRGP4 trap_CmdArgc
CALLI4
ASGNI4
ADDRLP4 52
ADDRLP4 56
INDIRI4
ASGNI4
line 208
;207:
;208:        if( argc < 3 )
ADDRLP4 52
INDIRI4
CNSTI4 3
GEI4 $94
line 209
;209:        {
line 210
;210:                return;
ADDRGP4 $93
JUMPV
LABELV $94
line 212
;211:        }
;212:        trap_CmdArgv( 2, cmd_command, sizeof( cmd_command ) );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 50
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 214
;213:
;214:        if( !strncmp(cmd_command,"max_yaw_speed",sizeof(cmd_command)))
ADDRLP4 0
ARGP4
ADDRGP4 $98
ARGP4
CNSTU4 50
ARGU4
ADDRLP4 60
ADDRGP4 strncmp
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $96
line 215
;215:        {
line 216
;216:                if( argc == 3 )
ADDRLP4 52
INDIRI4
CNSTI4 3
NEI4 $99
line 217
;217:                        G_sprint(self,2,"max_yaw_speed = %3.0f\n",max_yaw_per_sek);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $101
ARGP4
ADDRGP4 max_yaw_per_sek
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $100
JUMPV
LABELV $99
line 219
;218:                else
;219:                {
line 220
;220:                        trap_CmdArgv( 3, cmd_command, sizeof( cmd_command ) );
CNSTI4 3
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 50
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 221
;221:                        max_yaw_per_sek = atof(cmd_command);
ADDRLP4 0
ARGP4
ADDRLP4 64
ADDRGP4 atof
CALLF4
ASGNF4
ADDRGP4 max_yaw_per_sek
ADDRLP4 64
INDIRF4
ASGNF4
line 222
;222:                        if( max_yaw_per_sek < 10 )
ADDRGP4 max_yaw_per_sek
INDIRF4
CNSTF4 1092616192
GEF4 $102
line 223
;223:                                max_yaw_per_sek = 10;
ADDRGP4 max_yaw_per_sek
CNSTF4 1092616192
ASGNF4
LABELV $102
line 225
;224:
;225:                        G_sprint(self,2,"max_yaw_speed set to %3.0f\n",max_yaw_per_sek);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $104
ARGP4
ADDRGP4 max_yaw_per_sek
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 226
;226:                }
LABELV $100
line 228
;227:        
;228:        }
LABELV $96
line 231
;229:        
;230:
;231:}
LABELV $93
endproc BotSet 68 16
export BotTest
proc BotTest 0 0
line 234
;232:
;233:void BotTest()
;234:{
line 263
;235:/* 	gedict_t *te;
;236:        char    cmd_command[50];
;237:        int argc;
;238:        float origin,speed;
;239:
;240:	argc = trap_CmdArgc();
;241:        if( argc < 4 )
;242:        {
;243:                return;
;244:        }
;245:        trap_CmdArgv( 2, cmd_command, sizeof( cmd_command ) );
;246:        origin = atof(cmd_command);
;247:
;248:        trap_CmdArgv( 3, cmd_command, sizeof( cmd_command ) );
;249:        speed = atof(cmd_command);
;250:
;251:	for ( te = world; ( te = trap_find( te, FOFS( s.v.classname ), "player" ) ); )
;252:	{
;253:		if ( te->has_disconnected )
;254:			continue;
;255:		if ( te->isBot )
;256:		{
;257:		   te->s.v.origin[2] = origin;
;258:		   te->s.v.velocity[2] = speed;
;259:                   return;
;260:		}
;261:	}
;262:*/
;263:}
LABELV $105
endproc BotTest 0 0
import strncmp
import max_yaw_per_sek
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
LABELV $104
byte 1 109
byte 1 97
byte 1 120
byte 1 95
byte 1 121
byte 1 97
byte 1 119
byte 1 95
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 51
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $101
byte 1 109
byte 1 97
byte 1 120
byte 1 95
byte 1 121
byte 1 97
byte 1 119
byte 1 95
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 32
byte 1 61
byte 1 32
byte 1 37
byte 1 51
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $98
byte 1 109
byte 1 97
byte 1 120
byte 1 95
byte 1 121
byte 1 97
byte 1 119
byte 1 95
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $86
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $81
byte 1 65
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $78
byte 1 66
byte 1 111
byte 1 116
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $74
byte 1 66
byte 1 111
byte 1 116
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 40
byte 1 65
byte 1 80
byte 1 73
byte 1 32
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $65
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $58
byte 1 66
byte 1 111
byte 1 116
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 117
byte 1 112
byte 1 112
byte 1 108
byte 1 121
byte 1 32
byte 1 66
byte 1 101
byte 1 116
byte 1 119
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 75
byte 1 105
byte 1 108
byte 1 108
byte 1 115
byte 1 58
byte 1 32
byte 1 79
byte 1 102
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $57
byte 1 66
byte 1 111
byte 1 116
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 117
byte 1 112
byte 1 112
byte 1 108
byte 1 121
byte 1 32
byte 1 66
byte 1 101
byte 1 116
byte 1 119
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 75
byte 1 105
byte 1 108
byte 1 108
byte 1 115
byte 1 58
byte 1 32
byte 1 79
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $37
byte 1 117
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
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 100
byte 1 100
byte 1 32
byte 1 60
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 62
byte 1 32
byte 1 60
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 62
byte 1 32
byte 1 91
byte 1 60
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 62
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $33
byte 1 101
byte 1 110
byte 1 100
byte 1 119
byte 1 112
byte 1 32
byte 1 32
byte 1 91
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $30
byte 1 110
byte 1 111
byte 1 119
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $29
byte 1 119
byte 1 112
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 91
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $26
byte 1 66
byte 1 111
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 118
byte 1 101
byte 1 108
byte 1 111
byte 1 99
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 37
byte 1 51
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 32
byte 1 91
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $21
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $15
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $14
byte 1 114
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $13
byte 1 114
byte 1 101
byte 1 115
byte 1 117
byte 1 112
byte 1 112
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $12
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $11
byte 1 97
byte 1 100
byte 1 100
byte 1 0
