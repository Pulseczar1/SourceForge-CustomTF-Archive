lit
align 4
LABELV mod_cmds
address $11
address WP_command
address $12
address Red_Def_command
byte 4 0
byte 4 0
export ModCommand
code
proc ModCommand 1040 12
file "..\src\g_mod_command.c"
line 40
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
;20: *  $Id: g_mod_command.c,v 1.8 2006/03/04 15:10:06 AngelD Exp $
;21: */
;22:
;23:#include "g_local.h"
;24:typedef struct mod_s{
;25:	char   *command;
;26:	void    ( *Action ) ( int );
;27:} mod_t;
;28:void WP_command( int argc );
;29:void Red_Def_command( int argc );
;30:
;31:const static mod_t   mod_cmds[] = {
;32:	{"wp", WP_command},
;33:	{"red_def", Red_Def_command},
;34:	{NULL, NULL}
;35:};
;36:
;37:
;38:
;39:void ModCommand()
;40:{
line 45
;41:        char    cmd_command[1024];
;42:        int argc;
;43:        const mod_t  *ucmd;
;44:
;45:        argc = trap_CmdArgc();
ADDRLP4 1032
ADDRGP4 trap_CmdArgc
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 1032
INDIRI4
ASGNI4
line 46
;46:        if( argc < 2 )
ADDRLP4 1028
INDIRI4
CNSTI4 2
GEI4 $14
line 47
;47:                return;
ADDRGP4 $13
JUMPV
LABELV $14
line 50
;48:
;49:
;50:        trap_CmdArgv( 1, cmd_command, sizeof( cmd_command ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 52
;51:
;52:	for ( ucmd = mod_cmds; ucmd->command; ucmd++ )
ADDRLP4 0
ADDRGP4 mod_cmds
ASGNP4
ADDRGP4 $19
JUMPV
LABELV $16
line 53
;53:	{
line 54
;54:		if ( strcmp( cmd_command, ucmd->command ) )
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
EQI4 $20
line 55
;55:			continue;
ADDRGP4 $17
JUMPV
LABELV $20
line 56
;56:		ucmd->Action( argc );
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
line 57
;57:		return;
ADDRGP4 $13
JUMPV
LABELV $17
line 52
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
LABELV $19
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $16
line 59
;58:	}
;59:	return;
LABELV $13
endproc ModCommand 1040 12
export WP_command
proc WP_command 1164 12
line 67
;60:
;61:}
;62:extern vec3_t end_pos;
;63:
;64:void DrawWPS();
;65:void ClearWaypoints(  );
;66:void WP_command( int argc )
;67:{
line 69
;68:        char    cmd_command[1024];
;69:        if( argc < 3)
ADDRFP4 0
INDIRI4
CNSTI4 3
GEI4 $23
line 70
;70:                return;
ADDRGP4 $22
JUMPV
LABELV $23
line 72
;71:        
;72:        trap_CmdArgv( 2, cmd_command, sizeof( cmd_command ) );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 74
;73:
;74:        if(!strcmp(cmd_command, "add"))
ADDRLP4 0
ARGP4
ADDRGP4 $27
ARGP4
ADDRLP4 1024
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
NEI4 $25
line 75
;75:        {
line 78
;76:                waypoint_t wp;
;77:
;78:                if( argc < 7 )
ADDRFP4 0
INDIRI4
CNSTI4 7
GEI4 $28
line 79
;79:                        return;
ADDRGP4 $22
JUMPV
LABELV $28
line 81
;80:
;81:                memset(&wp, 0 ,sizeof(wp));
ADDRLP4 1028
ARGP4
CNSTI4 0
ARGI4
CNSTI4 116
ARGI4
ADDRGP4 memset
CALLP4
pop
line 82
;82:                trap_CmdArgv( 3, cmd_command, sizeof( cmd_command ) );
CNSTI4 3
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 83
;83:                wp.index = atoi( cmd_command );
ADDRLP4 0
ARGP4
ADDRLP4 1144
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028+16
ADDRLP4 1144
INDIRI4
ASGNI4
line 84
;84:                trap_CmdArgv( 4, cmd_command, sizeof( cmd_command ) );
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 85
;85:                wp.origin[0] = atof( cmd_command );
ADDRLP4 0
ARGP4
ADDRLP4 1148
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1028
ADDRLP4 1148
INDIRF4
ASGNF4
line 86
;86:                trap_CmdArgv( 5, cmd_command, sizeof( cmd_command ) );
CNSTI4 5
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 87
;87:                wp.origin[1] = atof( cmd_command );
ADDRLP4 0
ARGP4
ADDRLP4 1152
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1028+4
ADDRLP4 1152
INDIRF4
ASGNF4
line 88
;88:                trap_CmdArgv( 6, cmd_command, sizeof( cmd_command ) );
CNSTI4 6
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 89
;89:                wp.origin[2] = atof( cmd_command );
ADDRLP4 0
ARGP4
ADDRLP4 1156
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1028+8
ADDRLP4 1156
INDIRF4
ASGNF4
line 90
;90:                wp.teams = 15 ;// (1<<0)+(1<<1)+(1<<2)+(1<<3);
ADDRLP4 1028+24
CNSTI4 15
ASGNI4
line 91
;91:                if( argc > 7 )
ADDRFP4 0
INDIRI4
CNSTI4 7
LEI4 $34
line 92
;92:                {
line 93
;93:                        trap_CmdArgv( 7, cmd_command, sizeof( cmd_command ) );
CNSTI4 7
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 94
;94:                        wp.flags = atoi( cmd_command );
ADDRLP4 0
ARGP4
ADDRLP4 1160
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028+20
ADDRLP4 1160
INDIRI4
ASGNI4
line 96
;95:                        
;96:                }
LABELV $34
line 97
;97:                if( argc > 8 )
ADDRFP4 0
INDIRI4
CNSTI4 8
LEI4 $37
line 98
;98:                {
line 99
;99:                        trap_CmdArgv( 8, cmd_command, sizeof( cmd_command ) );
CNSTI4 8
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 100
;100:                        wp.teams = atoi( cmd_command );
ADDRLP4 0
ARGP4
ADDRLP4 1160
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028+24
ADDRLP4 1160
INDIRI4
ASGNI4
line 101
;101:                }
LABELV $37
line 103
;102:
;103:                if( argc > 9 )
ADDRFP4 0
INDIRI4
CNSTI4 9
LEI4 $40
line 104
;104:                {
line 105
;105:                        trap_CmdArgv( 9, cmd_command, sizeof( cmd_command ) );
CNSTI4 9
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 106
;106:                        wp.radius = atof( cmd_command );
ADDRLP4 0
ARGP4
ADDRLP4 1160
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1028+12
ADDRLP4 1160
INDIRF4
ASGNF4
line 108
;107:                        
;108:                }
LABELV $40
line 109
;109:                AddWaypoint(&wp);
ADDRLP4 1028
ARGP4
ADDRGP4 AddWaypoint
CALLP4
pop
line 110
;110:                return;
ADDRGP4 $22
JUMPV
LABELV $25
line 113
;111:        }
;112:
;113:        if(!strcmp(cmd_command, "link"))
ADDRLP4 0
ARGP4
ADDRGP4 $45
ARGP4
ADDRLP4 1028
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
NEI4 $43
line 114
;114:        {
line 117
;115:                wp_link_t link;
;116:                int i1,i2;
;117:                if( argc < 5 )
ADDRFP4 0
INDIRI4
CNSTI4 5
GEI4 $46
line 118
;118:                        return;
ADDRGP4 $22
JUMPV
LABELV $46
line 120
;119:
;120:                memset(&link, 0 ,sizeof(link));
ADDRLP4 1032
ARGP4
CNSTI4 0
ARGI4
CNSTI4 48
ARGI4
ADDRGP4 memset
CALLP4
pop
line 121
;121:                trap_CmdArgv( 3, cmd_command, sizeof( cmd_command ) );
CNSTI4 3
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 122
;122:                i1 = atoi( cmd_command );
ADDRLP4 0
ARGP4
ADDRLP4 1088
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1080
ADDRLP4 1088
INDIRI4
ASGNI4
line 123
;123:                trap_CmdArgv( 4, cmd_command, sizeof( cmd_command ) );
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 124
;124:                i2 = atoi( cmd_command );
ADDRLP4 0
ARGP4
ADDRLP4 1092
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1084
ADDRLP4 1092
INDIRI4
ASGNI4
line 125
;125:                link.teams = 15;
ADDRLP4 1032+12
CNSTI4 15
ASGNI4
line 126
;126:                if( argc > 5 )
ADDRFP4 0
INDIRI4
CNSTI4 5
LEI4 $49
line 127
;127:                {
line 128
;128:                        trap_CmdArgv( 5, cmd_command, sizeof( cmd_command ) );
CNSTI4 5
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 129
;129:                        link.flags = atoi( cmd_command );
ADDRLP4 0
ARGP4
ADDRLP4 1096
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032+8
ADDRLP4 1096
INDIRI4
ASGNI4
line 130
;130:                }
LABELV $49
line 131
;131:                if( argc > 6 )
ADDRFP4 0
INDIRI4
CNSTI4 6
LEI4 $52
line 132
;132:                {
line 133
;133:                        trap_CmdArgv( 6, cmd_command, sizeof( cmd_command ) );
CNSTI4 6
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 134
;134:                        link.teams = atoi( cmd_command );
ADDRLP4 0
ARGP4
ADDRLP4 1096
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032+12
ADDRLP4 1096
INDIRI4
ASGNI4
line 135
;135:                }
LABELV $52
line 137
;136:
;137:                if( argc > 7 )
ADDRFP4 0
INDIRI4
CNSTI4 7
LEI4 $55
line 138
;138:                {
line 139
;139:                        trap_CmdArgv( 7, cmd_command, sizeof( cmd_command ) );
CNSTI4 7
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 140
;140:                        link.req_velocity = atof( cmd_command );
ADDRLP4 0
ARGP4
ADDRLP4 1096
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1032+44
ADDRLP4 1096
INDIRF4
ASGNF4
line 142
;141:                        
;142:                }
LABELV $55
line 143
;143:                AddLink( i1, i2, &link);
ADDRLP4 1080
INDIRI4
ARGI4
ADDRLP4 1084
INDIRI4
ARGI4
ADDRLP4 1032
ARGP4
ADDRGP4 AddLink
CALLI4
pop
line 144
;144:                return;
ADDRGP4 $22
JUMPV
LABELV $43
line 147
;145:        }
;146:
;147:        if(!strcmp(cmd_command, "dlink"))
ADDRLP4 0
ARGP4
ADDRGP4 $60
ARGP4
ADDRLP4 1032
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $58
line 148
;148:        {
line 151
;149:                wp_link_t link;
;150:                int i1,i2;
;151:                if( argc < 5 )
ADDRFP4 0
INDIRI4
CNSTI4 5
GEI4 $61
line 152
;152:                        return;
ADDRGP4 $22
JUMPV
LABELV $61
line 154
;153:
;154:                memset(&link, 0 ,sizeof(link));
ADDRLP4 1036
ARGP4
CNSTI4 0
ARGI4
CNSTI4 48
ARGI4
ADDRGP4 memset
CALLP4
pop
line 155
;155:                trap_CmdArgv( 3, cmd_command, sizeof( cmd_command ) );
CNSTI4 3
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 156
;156:                i1 = atoi( cmd_command );
ADDRLP4 0
ARGP4
ADDRLP4 1092
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1084
ADDRLP4 1092
INDIRI4
ASGNI4
line 157
;157:                trap_CmdArgv( 4, cmd_command, sizeof( cmd_command ) );
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 158
;158:                i2 = atoi( cmd_command );
ADDRLP4 0
ARGP4
ADDRLP4 1096
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1088
ADDRLP4 1096
INDIRI4
ASGNI4
line 159
;159:                link.teams = 15;
ADDRLP4 1036+12
CNSTI4 15
ASGNI4
line 160
;160:                if( argc > 5 )
ADDRFP4 0
INDIRI4
CNSTI4 5
LEI4 $64
line 161
;161:                {
line 162
;162:                        trap_CmdArgv( 5, cmd_command, sizeof( cmd_command ) );
CNSTI4 5
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 163
;163:                        link.flags = atoi( cmd_command );
ADDRLP4 0
ARGP4
ADDRLP4 1100
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1036+8
ADDRLP4 1100
INDIRI4
ASGNI4
line 164
;164:                }
LABELV $64
line 165
;165:                if( argc > 6 )
ADDRFP4 0
INDIRI4
CNSTI4 6
LEI4 $67
line 166
;166:                {
line 167
;167:                        trap_CmdArgv( 6, cmd_command, sizeof( cmd_command ) );
CNSTI4 6
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 168
;168:                        link.teams = atoi( cmd_command );
ADDRLP4 0
ARGP4
ADDRLP4 1100
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1036+12
ADDRLP4 1100
INDIRI4
ASGNI4
line 169
;169:                }
LABELV $67
line 171
;170:
;171:                if( argc > 7 )
ADDRFP4 0
INDIRI4
CNSTI4 7
LEI4 $70
line 172
;172:                {
line 173
;173:                        trap_CmdArgv( 7, cmd_command, sizeof( cmd_command ) );
CNSTI4 7
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 174
;174:                        link.req_velocity = atof( cmd_command );
ADDRLP4 0
ARGP4
ADDRLP4 1100
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1036+44
ADDRLP4 1100
INDIRF4
ASGNF4
line 176
;175:                        
;176:                }
LABELV $70
line 177
;177:                AddLink( i1, i2, &link);
ADDRLP4 1084
INDIRI4
ARGI4
ADDRLP4 1088
INDIRI4
ARGI4
ADDRLP4 1036
ARGP4
ADDRGP4 AddLink
CALLI4
pop
line 178
;178:                AddLink( i2, i1, &link);
ADDRLP4 1088
INDIRI4
ARGI4
ADDRLP4 1084
INDIRI4
ARGI4
ADDRLP4 1036
ARGP4
ADDRGP4 AddLink
CALLI4
pop
line 179
;179:                return;
ADDRGP4 $22
JUMPV
LABELV $58
line 182
;180:        }
;181:
;182:        if(!strcmp(cmd_command, "target"))
ADDRLP4 0
ARGP4
ADDRGP4 $75
ARGP4
ADDRLP4 1036
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $73
line 183
;183:        {
line 184
;184:                if( argc < 6 )
ADDRFP4 0
INDIRI4
CNSTI4 6
GEI4 $76
line 185
;185:                        return;
ADDRGP4 $22
JUMPV
LABELV $76
line 187
;186:
;187:                trap_CmdArgv( 3, cmd_command, sizeof( cmd_command ) );
CNSTI4 3
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 188
;188:                end_pos[0] = atof( cmd_command );
ADDRLP4 0
ARGP4
ADDRLP4 1040
ADDRGP4 atof
CALLF4
ASGNF4
ADDRGP4 end_pos
ADDRLP4 1040
INDIRF4
ASGNF4
line 189
;189:                trap_CmdArgv( 4, cmd_command, sizeof( cmd_command ) );
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 190
;190:                end_pos[1] = atof( cmd_command );
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 atof
CALLF4
ASGNF4
ADDRGP4 end_pos+4
ADDRLP4 1044
INDIRF4
ASGNF4
line 191
;191:                trap_CmdArgv( 5, cmd_command, sizeof( cmd_command ) );
CNSTI4 5
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 192
;192:                end_pos[2] = atof( cmd_command );
ADDRLP4 0
ARGP4
ADDRLP4 1048
ADDRGP4 atof
CALLF4
ASGNF4
ADDRGP4 end_pos+8
ADDRLP4 1048
INDIRF4
ASGNF4
line 193
;193:                return;
ADDRGP4 $22
JUMPV
LABELV $73
line 195
;194:        }
;195:        if(!strcmp(cmd_command, "draw"))
ADDRLP4 0
ARGP4
ADDRGP4 $82
ARGP4
ADDRLP4 1040
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $80
line 196
;196:        {
line 197
;197:                DrawWPS();
ADDRGP4 DrawWPS
CALLV
pop
line 198
;198:                return;
ADDRGP4 $22
JUMPV
LABELV $80
line 200
;199:        }
;200:        if(!strcmp(cmd_command, "clear"))
ADDRLP4 0
ARGP4
ADDRGP4 $85
ARGP4
ADDRLP4 1044
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $83
line 201
;201:        {
line 202
;202:                ClearWaypoints();
ADDRGP4 ClearWaypoints
CALLV
pop
line 203
;203:                return;
LABELV $83
line 205
;204:        }
;205:}
LABELV $22
endproc WP_command 1164 12
data
align 4
LABELV $87
byte 4 0
export Red_Def_command
code
proc Red_Def_command 1056 12
line 207
;206:void Red_Def_command( int argc )
;207:{
line 213
;208:        char    cmd_command[1024];
;209:        static  qboolean red_def_mode =  false;
;210:	gedict_t *Goal,*saveself;
;211:	gedict_t *te,*owner;
;212:
;213:	if( tf_data.mtfl )
ADDRGP4 tf_data+172
INDIRI4
CNSTI4 0
EQI4 $88
line 214
;214:	{
line 215
;215:       	        if( self != world )
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $86
line 216
;216:      		         G_sprint(self,2,"Not allowed for mtfl.\n" );
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
line 217
;217:      		return;
ADDRGP4 $86
JUMPV
LABELV $88
line 219
;218:	}
;219:        if( argc < 3)
ADDRFP4 0
INDIRI4
CNSTI4 3
GEI4 $94
line 220
;220:        {
line 221
;221:                if( self == world )
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
NEU4 $96
line 222
;222:                        return;
ADDRGP4 $86
JUMPV
LABELV $96
line 223
;223:                if( red_def_mode )
ADDRGP4 $87
INDIRI4
CNSTI4 0
EQI4 $98
line 224
;224:                        G_sprint(self, 2, "Red-Def mode is ON\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $100
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $86
JUMPV
LABELV $98
line 226
;225:                else
;226:                        G_sprint(self, 2, "Red-Def mode is OFF\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $101
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 227
;227:                return;
ADDRGP4 $86
JUMPV
LABELV $94
line 229
;228:        }
;229:        saveself = self;
ADDRLP4 1036
ADDRGP4 self
INDIRP4
ASGNP4
line 230
;230:        trap_CmdArgv( 2, cmd_command, sizeof( cmd_command ) );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 231
;231:        if( !strcmp(cmd_command,"on") )
ADDRLP4 0
ARGP4
ADDRGP4 $104
ARGP4
ADDRLP4 1040
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $102
line 232
;232:        {
line 233
;233:                if( red_def_mode )
ADDRGP4 $87
INDIRI4
CNSTI4 0
EQI4 $105
line 234
;234:                {
line 235
;235:        	        if( self != world )
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $86
line 236
;236:                                G_sprint(self, 2, "Red-Def mode already activated\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $109
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 237
;237:                        return;
ADDRGP4 $86
JUMPV
LABELV $105
line 240
;238:                }
;239:
;240:	        Goal = trap_find( world, FOFS( s.v.classname ), "info_tfdetect" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $110
ARGP4
ADDRLP4 1044
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 1024
ADDRLP4 1044
INDIRP4
ASGNP4
line 242
;241:
;242:                if ( !Goal )
ADDRLP4 1024
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $111
line 243
;243:	       	       return;
ADDRGP4 $86
JUMPV
LABELV $111
line 244
;244:	        if ( !Goal->display_item_status1 )
ADDRLP4 1024
INDIRP4
CNSTI4 1268
ADDP4
INDIRI4
CNSTI4 0
NEI4 $113
line 245
;245:	                return;
ADDRGP4 $86
JUMPV
LABELV $113
line 246
;246:       	        te = Finditem( Goal->display_item_status1 );
ADDRLP4 1024
INDIRP4
CNSTI4 1268
ADDP4
INDIRI4
ARGI4
ADDRLP4 1048
ADDRGP4 Finditem
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1048
INDIRP4
ASGNP4
line 247
;247:                if ( te == world )
ADDRLP4 1028
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
NEU4 $115
line 248
;248:        	{
line 249
;249:        	        if( self != world )
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $86
line 250
;250:             		         G_sprint(self,2,"Item is missing.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $119
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 251
;251:        		return;
ADDRGP4 $86
JUMPV
LABELV $115
line 253
;252:        	}
;253:        	owner = PROG_TO_EDICT(te->s.v.owner);
ADDRLP4 1032
ADDRLP4 1028
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 254
;254:        	if( owner != world )
ADDRLP4 1032
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $120
line 255
;255:        	{
line 256
;256:        	        tfgoalitem_RemoveFromPlayer( te, owner, 1 );
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 1032
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 tfgoalitem_RemoveFromPlayer
CALLV
pop
line 257
;257:        	}
LABELV $120
line 258
;258:        	te->take_sshot = 1;
ADDRLP4 1028
INDIRP4
CNSTI4 1532
ADDP4
CNSTI4 1
ASGNI4
line 259
;259:                red_def_mode = true;
ADDRGP4 $87
CNSTI4 1
ASGNI4
line 260
;260:                G_bprint(2,"“Â‰-ƒ≈Ê ÌÔ‰Â ·„ÙÈˆ·ÙÂ‰\n");
CNSTI4 2
ARGI4
ADDRGP4 $122
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 261
;261:                return;
ADDRGP4 $86
JUMPV
LABELV $102
line 263
;262:        }
;263:        if( !strcmp(cmd_command,"off") )
ADDRLP4 0
ARGP4
ADDRGP4 $125
ARGP4
ADDRLP4 1044
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $123
line 264
;264:        {
line 265
;265:                if( !red_def_mode )
ADDRGP4 $87
INDIRI4
CNSTI4 0
NEI4 $126
line 266
;266:                {
line 267
;267:        	        if( self != world )
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $86
line 268
;268:                                G_sprint(self,2,"Red-Def mode not active\n");
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $130
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 269
;269:                        return;
ADDRGP4 $86
JUMPV
LABELV $126
line 271
;270:                }
;271:	        Goal = trap_find( world, FOFS( s.v.classname ), "info_tfdetect" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $110
ARGP4
ADDRLP4 1048
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 1024
ADDRLP4 1048
INDIRP4
ASGNP4
line 273
;272:
;273:                if ( !Goal )
ADDRLP4 1024
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $131
line 274
;274:	       	       return;
ADDRGP4 $86
JUMPV
LABELV $131
line 275
;275:	        if ( !Goal->display_item_status1 )
ADDRLP4 1024
INDIRP4
CNSTI4 1268
ADDP4
INDIRI4
CNSTI4 0
NEI4 $133
line 276
;276:	                return;
ADDRGP4 $86
JUMPV
LABELV $133
line 277
;277:       	        te = Finditem( Goal->display_item_status1 );
ADDRLP4 1024
INDIRP4
CNSTI4 1268
ADDP4
INDIRI4
ARGI4
ADDRLP4 1052
ADDRGP4 Finditem
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1052
INDIRP4
ASGNP4
line 278
;278:                if ( te == world )
ADDRLP4 1028
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
NEU4 $135
line 279
;279:        	{
line 280
;280:        	        if( self != world )
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $86
line 281
;281:        		      G_sprint(self,2, "Item is missing.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $119
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 282
;282:        		return;
ADDRGP4 $86
JUMPV
LABELV $135
line 284
;283:        	}
;284:        	te->take_sshot = 0;
ADDRLP4 1028
INDIRP4
CNSTI4 1532
ADDP4
CNSTI4 0
ASGNI4
line 285
;285:                red_def_mode = false;
ADDRGP4 $87
CNSTI4 0
ASGNI4
line 286
;286:                G_bprint(2,"“Â‰-ƒ≈Ê ÌÔ‰Â ‰Â·„ÙÈˆ·ÙÂ‰\n");
CNSTI4 2
ARGI4
ADDRGP4 $139
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 287
;287:                return;
LABELV $123
line 290
;288:        }
;289:
;290:}
LABELV $86
endproc Red_Def_command 1056 12
import ClearWaypoints
import DrawWPS
import end_pos
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
LABELV $139
byte 1 210
byte 1 229
byte 1 228
byte 1 45
byte 1 196
byte 1 197
byte 1 230
byte 1 32
byte 1 237
byte 1 239
byte 1 228
byte 1 229
byte 1 32
byte 1 228
byte 1 229
byte 1 225
byte 1 227
byte 1 244
byte 1 233
byte 1 246
byte 1 225
byte 1 244
byte 1 229
byte 1 228
byte 1 10
byte 1 0
align 1
LABELV $130
byte 1 82
byte 1 101
byte 1 100
byte 1 45
byte 1 68
byte 1 101
byte 1 102
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $125
byte 1 111
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $122
byte 1 210
byte 1 229
byte 1 228
byte 1 45
byte 1 196
byte 1 197
byte 1 230
byte 1 32
byte 1 237
byte 1 239
byte 1 228
byte 1 229
byte 1 32
byte 1 225
byte 1 227
byte 1 244
byte 1 233
byte 1 246
byte 1 225
byte 1 244
byte 1 229
byte 1 228
byte 1 10
byte 1 0
align 1
LABELV $119
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $110
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 116
byte 1 102
byte 1 100
byte 1 101
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $109
byte 1 82
byte 1 101
byte 1 100
byte 1 45
byte 1 68
byte 1 101
byte 1 102
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $104
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $101
byte 1 82
byte 1 101
byte 1 100
byte 1 45
byte 1 68
byte 1 101
byte 1 102
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 10
byte 1 0
align 1
LABELV $100
byte 1 82
byte 1 101
byte 1 100
byte 1 45
byte 1 68
byte 1 101
byte 1 102
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $93
byte 1 78
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
byte 1 109
byte 1 116
byte 1 102
byte 1 108
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $85
byte 1 99
byte 1 108
byte 1 101
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $82
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 0
align 1
LABELV $75
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $60
byte 1 100
byte 1 108
byte 1 105
byte 1 110
byte 1 107
byte 1 0
align 1
LABELV $45
byte 1 108
byte 1 105
byte 1 110
byte 1 107
byte 1 0
align 1
LABELV $27
byte 1 97
byte 1 100
byte 1 100
byte 1 0
align 1
LABELV $12
byte 1 114
byte 1 101
byte 1 100
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 0
align 1
LABELV $11
byte 1 119
byte 1 112
byte 1 0
