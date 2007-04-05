export CenterPrint
code
proc CenterPrint 16008 16
file "..\src\status.c"
line 27
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
;21: *  $Id: status.c,v 1.14 2005/06/03 04:27:54 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:
;26:void CenterPrint( gedict_t * pl, const char *fmt, ... )
;27:{
line 31
;28:	va_list argptr;
;29:	char text[16000];
;30:
;31:	va_start( argptr, fmt );
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 32
;32:	_vsnprintf( text, sizeof(text), fmt, argptr );
ADDRLP4 4
ARGP4
CNSTI4 16000
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 _vsnprintf
CALLI4
pop
line 33
;33:	va_end( argptr );
ADDRLP4 0
CNSTP4 0
ASGNP4
line 35
;34:
;35:	trap_CenterPrint( NUM_FOR_EDICT( pl ), text );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16004
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 16004
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_CenterPrint
CALLV
pop
line 37
;36:
;37:	pl->StatusRefreshTime = g_globalvars.time + 1.5;
ADDRFP4 0
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1069547520
ADDF4
ASGNF4
line 38
;38:}
LABELV $11
endproc CenterPrint 16008 16
data
export teamnames
align 4
LABELV teamnames
address $14
address $14
address $15
address $16
address $17
export default_status
align 4
LABELV default_status
address $18
export RefreshStatusBar
code
proc RefreshStatusBar 1100 36
line 75
;39:
;40:/*void StatusPrint( gedict_t * pl, float fTime, const char *fmt, ... )
;41:{
;42:	va_list argptr;
;43:	char text[16000];
;44:
;45:	va_start( argptr, fmt );
;46:	_vsnprintf( text, sizeof(text), fmt, argptr );
;47:	va_end( argptr );
;48:
;49:	trap_CenterPrint( NUM_FOR_EDICT( pl ), text );
;50:
;51:	pl->StatusRefreshTime = g_globalvars.time + fTime;
;52:}*/
;53:
;54:const char   *teamnames[5] = {
;55:	"  Blue:",
;56:	"  Blue:",
;57:	"  Red :",
;58:	"  Yell:",
;59:	"  Gren:"
;60:};
;61:
;62://#define MAX_SBAR_STR 16000
;63://static char    sbar_str[MAX_SBAR_STR];
;64://static char   *end_of_sbar_str = sbar_str + MAX_SBAR_STR;
;65:
;66:const char   *GetStatusSize( gedict_t * pl );
;67:const char   *GetEngSbar( gedict_t * pl );
;68:const char   *GetSpySbar( gedict_t * pl );
;69:
;70://const char   *ClipSizeToString( gedict_t * pl );
;71:int GetClipSize( gedict_t * pl );
;72:
;73:const char* default_status = "";
;74:void RefreshStatusBar( gedict_t * pl )
;75:{
line 83
;76:	int     win;
;77:	int     sec;
;78:	gedict_t *te;
;79:	const char *status_size,*status;
;80:	char   stmp[1024];
;81:	int    clip;
;82:
;83:	if ( !pl->StatusBarSize )
ADDRFP4 0
INDIRP4
CNSTI4 1488
ADDP4
INDIRI4
CNSTI4 0
NEI4 $20
line 84
;84:	{
line 85
;85:		pl->StatusRefreshTime = g_globalvars.time + 60;
ADDRFP4 0
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 86
;86:		return;
ADDRGP4 $19
JUMPV
LABELV $20
line 88
;87:	}
;88:	pl->StatusRefreshTime = g_globalvars.time + 1.5;
ADDRFP4 0
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1069547520
ADDF4
ASGNF4
line 89
;89:	if ( !pl->playerclass )
ADDRFP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $24
line 90
;90:		return;
ADDRGP4 $19
JUMPV
LABELV $24
line 92
;91:
;92:	status_size = GetStatusSize( pl );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1048
ADDRGP4 GetStatusSize
CALLP4
ASGNP4
ADDRLP4 1044
ADDRLP4 1048
INDIRP4
ASGNP4
line 93
;93:	status = default_status;
ADDRLP4 1028
ADDRGP4 default_status
INDIRP4
ASGNP4
line 95
;94:
;95:	if ( pl->playerclass == 9 || ( (pl->playerclass == 2 ||
ADDRLP4 1052
ADDRFP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 9
EQI4 $29
ADDRLP4 1052
INDIRI4
CNSTI4 2
EQI4 $34
ADDRLP4 1052
INDIRI4
CNSTI4 3
EQI4 $34
ADDRLP4 1052
INDIRI4
CNSTI4 5
EQI4 $34
ADDRLP4 1052
INDIRI4
CNSTI4 6
EQI4 $34
ADDRLP4 1052
INDIRI4
CNSTI4 7
EQI4 $34
ADDRGP4 tg_data+64
INDIRI4
CNSTI4 0
EQI4 $26
LABELV $34
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $26
LABELV $29
line 98
;96:	     pl->playerclass == 3 || pl->playerclass == 5 || 
;97:	     pl->playerclass == 6 || pl->playerclass == 7 || tg_data.tg_sbar) && tg_data.tg_enabled) )
;98:	{			/// eng sbar
line 99
;99:	        status = GetEngSbar( pl );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1056
ADDRGP4 GetEngSbar
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1056
INDIRP4
ASGNP4
line 100
;100:	} else
ADDRGP4 $27
JUMPV
LABELV $26
line 101
;101:	{
line 102
;102:		if ( pl->playerclass == 8 )
ADDRFP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $35
line 103
;103:		        status = GetSpySbar( pl );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1056
ADDRGP4 GetSpySbar
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1056
INDIRP4
ASGNP4
LABELV $35
line 105
;104:
;105:		if ( pl->playerclass == 4 )
ADDRFP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 4
NEI4 $37
line 106
;106:		{
line 107
;107:			if ( pl->is_detpacking )
ADDRFP4 0
INDIRP4
CNSTI4 876
ADDP4
INDIRI4
CNSTI4 0
EQI4 $39
line 108
;108:			{
line 109
;109:				status = "  setting detpack                      ";
ADDRLP4 1028
ADDRGP4 $41
ASGNP4
line 110
;110:			} else
ADDRGP4 $40
JUMPV
LABELV $39
line 111
;111:			{
line 112
;112:				for ( te = world; (te = trap_find( te, FOFS( s.v.classname ), "detpack" ));)
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $45
JUMPV
LABELV $42
line 113
;113:				{
line 114
;114:					if ( te->s.v.owner != EDICT_TO_PROG( self ) )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
EQI4 $47
line 115
;115:						continue;
ADDRGP4 $43
JUMPV
LABELV $47
line 116
;116:					_snprintf( stmp, sizeof(stmp) , "Detpack: %d                 ",
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
SUBF4
CVFI4 4
ARGI4
ADDRGP4 _snprintf
CALLI4
pop
line 118
;117:						 ( int ) ( te->s.v.nextthink - g_globalvars.time ) );
;118:					status = stmp;
ADDRLP4 1028
ADDRLP4 4
ASGNP4
line 119
;119:					break;
ADDRGP4 $44
JUMPV
LABELV $43
line 112
LABELV $45
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $46
ARGP4
ADDRLP4 1060
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1060
INDIRP4
ASGNP4
ADDRLP4 1060
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $42
LABELV $44
line 121
;120:				}
;121:			}
LABELV $40
line 122
;122:		}
LABELV $37
line 123
;123:		if ( pl->playerclass == 1 )
ADDRFP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 1
NEI4 $51
line 124
;124:		{
line 125
;125:			_snprintf( stmp, sizeof(stmp), "Scan %3d %s%s %3s                       ",
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $53
ARGP4
ADDRLP4 1072
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1072
INDIRP4
CNSTI4 1500
ADDP4
INDIRI4
ARGI4
ADDRLP4 1072
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $62
ADDRLP4 1060
ADDRGP4 $54
ASGNP4
ADDRGP4 $63
JUMPV
LABELV $62
ADDRLP4 1060
ADDRGP4 $55
ASGNP4
LABELV $63
ADDRLP4 1060
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $64
ADDRLP4 1064
ADDRGP4 $57
ASGNP4
ADDRGP4 $65
JUMPV
LABELV $64
ADDRLP4 1064
ADDRGP4 $55
ASGNP4
LABELV $65
ADDRLP4 1064
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1496
ADDP4
INDIRI4
CNSTI4 0
EQI4 $66
ADDRLP4 1068
ADDRGP4 $59
ASGNP4
ADDRGP4 $67
JUMPV
LABELV $66
ADDRLP4 1068
ADDRGP4 $60
ASGNP4
LABELV $67
ADDRLP4 1068
INDIRP4
ARGP4
ADDRGP4 _snprintf
CALLI4
pop
line 128
;126:				 pl->ScanRange, ( pl->tf_items_flags & 1 ) ? "En" : "  ",
;127:				 ( pl->tf_items_flags & 2 ) ? "Fr" : "  ", ( pl->ScannerOn ) ? "On " : "Off" );
;128:			status = stmp;
ADDRLP4 1028
ADDRLP4 4
ASGNP4
line 129
;129:		}
LABELV $51
line 130
;130:	}
LABELV $27
line 132
;131:
;132:	win = TeamFortress_TeamGetWinner(  );
ADDRLP4 1056
ADDRGP4 TeamFortress_TeamGetWinner
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1056
INDIRI4
ASGNI4
line 133
;133:	sec = TeamFortress_TeamGetSecond(  );
ADDRLP4 1060
ADDRGP4 TeamFortress_TeamGetSecond
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 1060
INDIRI4
ASGNI4
line 134
;134:	clip = GetClipSize( pl );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1064
ADDRGP4 GetClipSize
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1064
INDIRI4
ASGNI4
line 135
;135:	if( clip >= 0)
ADDRLP4 1040
INDIRI4
CNSTI4 0
LTI4 $68
line 136
;136:	        G_centerprint( pl, "%s%s\n%s%3d %s%3d  ÃÌÉÐ:%2d\n", status_size, status, 
ADDRLP4 1032
INDIRI4
ARGI4
ADDRLP4 1068
ADDRGP4 TeamFortress_TeamGetScore
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1072
ADDRGP4 TeamFortress_TeamGetScore
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $70
ARGP4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 1076
CNSTI4 2
ASGNI4
ADDRLP4 1080
ADDRGP4 teamnames
ASGNP4
ADDRLP4 1032
INDIRI4
ADDRLP4 1076
INDIRI4
LSHI4
ADDRLP4 1080
INDIRP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1068
INDIRI4
ARGI4
ADDRLP4 1036
INDIRI4
ADDRLP4 1076
INDIRI4
LSHI4
ADDRLP4 1080
INDIRP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 G_centerprint
CALLV
pop
ADDRGP4 $69
JUMPV
LABELV $68
line 140
;137:	        teamnames[win], TeamFortress_TeamGetScore( win ), teamnames[sec], TeamFortress_TeamGetScore( sec ),
;138:	        clip);
;139:	else
;140:	        G_centerprint( pl, "%s%s\n%s%3d %s%3d         \n", status_size, status, 
ADDRLP4 1032
INDIRI4
ARGI4
ADDRLP4 1084
ADDRGP4 TeamFortress_TeamGetScore
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1088
ADDRGP4 TeamFortress_TeamGetScore
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $71
ARGP4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 1092
CNSTI4 2
ASGNI4
ADDRLP4 1096
ADDRGP4 teamnames
ASGNP4
ADDRLP4 1032
INDIRI4
ADDRLP4 1092
INDIRI4
LSHI4
ADDRLP4 1096
INDIRP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1084
INDIRI4
ARGI4
ADDRLP4 1036
INDIRI4
ADDRLP4 1092
INDIRI4
LSHI4
ADDRLP4 1096
INDIRP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1088
INDIRI4
ARGI4
ADDRGP4 G_centerprint
CALLV
pop
LABELV $69
line 142
;141:	        teamnames[win], TeamFortress_TeamGetScore( win ), teamnames[sec], TeamFortress_TeamGetScore( sec ));
;142:}
LABELV $19
endproc RefreshStatusBar 1100 36
lit
align 4
LABELV SbarReSizes
byte 4 14
byte 4 19
byte 4 26
byte 4 32
byte 4 37
byte 4 39
byte 4 49
byte 4 64
byte 4 84
byte 4 11
byte 4 16
byte 4 23
byte 4 29
byte 4 34
byte 4 36
byte 4 46
byte 4 61
byte 4 81
bss
align 1
LABELV $73
skip 100
export GetStatusSize
code
proc GetStatusSize 16 0
line 148
;143:
;144:static const int     SbarReSizes[2][9] = {{ 14 ,19, 26, 32, 37, 39, 49, 64, 84 },
;145:			     { 11 ,16, 23, 29, 34, 36, 46, 61, 81 }};
;146:
;147:const char   *GetStatusSize( gedict_t * pl )
;148:{
line 150
;149:	static char ssize[100];
;150:	char* strp = ssize;
ADDRLP4 0
ADDRGP4 $73
ASGNP4
line 153
;151:    int num;
;152:
;153:	if( pl->StatusBarSize == 1)
ADDRFP4 0
INDIRP4
CNSTI4 1488
ADDP4
INDIRI4
CNSTI4 1
NEI4 $74
line 154
;154:		num = SbarReSizes[1][pl->StatusBarRes];
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 1492
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 SbarReSizes+36
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $78
JUMPV
LABELV $74
line 156
;155:	else
;156:		num = SbarReSizes[0][pl->StatusBarRes];
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 1492
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 SbarReSizes
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $78
JUMPV
LABELV $77
line 159
;157:		
;158:	while( num-- )
;159:	        *strp++ = '\n';
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI1 10
ASGNI1
LABELV $78
line 158
ADDRLP4 12
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $77
line 160
;160:	*strp = 0;
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 161
;161:	return ssize;
ADDRGP4 $73
RETP4
LABELV $72
endproc GetStatusSize 16 0
export GetClipSize
proc GetClipSize 0 0
line 165
;162:}
;163:
;164:int   GetClipSize( gedict_t * pl )
;165:{
line 166
;166:	if ( pl->current_weapon == 128 )
ADDRFP4 0
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 128
NEI4 $81
line 167
;167:	{
line 168
;168:		return (8 - pl->reload_shotgun);
CNSTI4 8
ADDRFP4 0
INDIRP4
CNSTI4 1060
ADDP4
INDIRI4
SUBI4
RETI4
ADDRGP4 $80
JUMPV
LABELV $81
line 170
;169:	} else
;170:	{
line 171
;171:		if ( pl->current_weapon == 256 )
ADDRFP4 0
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 256
NEI4 $83
line 172
;172:		{
line 173
;173:			return (16 - pl->reload_super_shotgun);
CNSTI4 16
ADDRFP4 0
INDIRP4
CNSTI4 1064
ADDP4
INDIRI4
SUBI4
RETI4
ADDRGP4 $80
JUMPV
LABELV $83
line 175
;174:		} else
;175:		{
line 176
;176:			if ( pl->current_weapon == 2048 )
ADDRFP4 0
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 2048
NEI4 $85
line 177
;177:			{
line 178
;178:				return  (6 - pl->reload_grenade_launcher);
CNSTI4 6
ADDRFP4 0
INDIRP4
CNSTI4 1068
ADDP4
INDIRI4
SUBI4
RETI4
ADDRGP4 $80
JUMPV
LABELV $85
line 180
;179:			} else
;180:			{
line 181
;181:				if ( pl->current_weapon == 8192 )
ADDRFP4 0
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 8192
NEI4 $87
line 182
;182:				{
line 183
;183:					return (4 - pl->reload_rocket_launcher);
CNSTI4 4
ADDRFP4 0
INDIRP4
CNSTI4 1072
ADDP4
INDIRI4
SUBI4
RETI4
ADDRGP4 $80
JUMPV
LABELV $87
line 185
;184:				} else
;185:					return -1;
CNSTI4 -1
RETI4
LABELV $80
endproc GetClipSize 0 0
data
export spy_teams
align 4
LABELV spy_teams
address $55
address $89
address $90
address $91
address $92
export spy_skins
align 4
LABELV spy_skins
address $55
address $93
address $94
address $95
address $96
address $97
address $98
address $99
address $100
address $101
bss
align 1
LABELV $103
skip 1024
export GetSpySbar
code
proc GetSpySbar 16 20
line 210
;186:			}
;187:		}
;188:	}
;189:}
;190:const char   *spy_teams[] = {
;191:	"  ",
;192:	"Blue",
;193:	"Red",
;194:	"Yellow",
;195:	"Green"
;196:};
;197:const char   *spy_skins[] = {
;198:	"  ",
;199:	"Scout",
;200:	"Sniper",
;201:	"Soldier",
;202:	"Demoman",
;203:	"Medic",
;204:	"Hvy Wpns",
;205:	"Pyro",
;206:	"Spy",
;207:	"Engineer"
;208:};
;209:const char* GetSpySbar( gedict_t * pl )
;210:{
line 213
;211:        static char spy_status[1024];
;212:
;213:        if( !pl->is_undercover )
ADDRFP4 0
INDIRP4
CNSTI4 868
ADDP4
INDIRI4
CNSTI4 0
NEI4 $104
line 214
;214:        {
line 215
;215:                if ( pl->is_feigning )
ADDRFP4 0
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
EQI4 $106
line 216
;216:                        return "feigned                                        ";
ADDRGP4 $108
RETP4
ADDRGP4 $102
JUMPV
LABELV $106
line 218
;217:                else
;218:                        return "                                               ";
ADDRGP4 $109
RETP4
ADDRGP4 $102
JUMPV
LABELV $104
line 220
;219:        }                
;220:        if ( pl->is_undercover == 2 )
ADDRFP4 0
INDIRP4
CNSTI4 868
ADDP4
INDIRI4
CNSTI4 2
NEI4 $110
line 221
;221:        {
line 222
;222:                if ( pl->is_feigning )
ADDRFP4 0
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
EQI4 $112
line 223
;223:                        return "feigned going undercover                       ";
ADDRGP4 $114
RETP4
ADDRGP4 $102
JUMPV
LABELV $112
line 225
;224:                else
;225:                        return "        going undercover                       ";
ADDRGP4 $115
RETP4
ADDRGP4 $102
JUMPV
LABELV $110
line 227
;226:        }
;227:        if ( tf_data.invis_only )
ADDRGP4 tf_data+60
INDIRI4
CNSTI4 0
EQI4 $116
line 228
;228:        {
line 229
;229:                if ( pl->is_feigning )
ADDRFP4 0
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
EQI4 $119
line 230
;230:                        return "feigned undercover                             ";
ADDRGP4 $121
RETP4
ADDRGP4 $102
JUMPV
LABELV $119
line 232
;231:                else
;232:                        return "        undercover                             ";
ADDRGP4 $122
RETP4
ADDRGP4 $102
JUMPV
LABELV $116
line 234
;233:        }
;234:        if( pl->is_feigning )
ADDRFP4 0
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
EQI4 $123
line 235
;235:	       _snprintf( spy_status, sizeof( spy_status ),"feigned %s %s                             ",
ADDRGP4 $103
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $125
ARGP4
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
LSHI4
ADDRGP4 spy_teams
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
LSHI4
ADDRGP4 spy_skins
ADDP4
INDIRP4
ARGP4
ADDRGP4 _snprintf
CALLI4
pop
ADDRGP4 $124
JUMPV
LABELV $123
line 238
;236:		 spy_teams[pl->undercover_team], spy_skins[pl->undercover_skin] );
;237:        else
;238:	       _snprintf( spy_status, sizeof( spy_status ),"        %s %s                             ",
ADDRGP4 $103
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $126
ARGP4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
CNSTI4 2
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
LSHI4
ADDRGP4 spy_teams
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
LSHI4
ADDRGP4 spy_skins
ADDP4
INDIRP4
ARGP4
ADDRGP4 _snprintf
CALLI4
pop
LABELV $124
line 240
;239:		 spy_teams[pl->undercover_team], spy_skins[pl->undercover_skin] );
;240:	return spy_status;
ADDRGP4 $103
RETP4
LABELV $102
endproc GetSpySbar 16 20
bss
align 1
LABELV $128
skip 1024
export GetEngSbar
code
proc GetEngSbar 32 16
line 245
;241:}
;242:
;243:
;244:const char* GetEngSbar( gedict_t * pl )
;245:{
line 251
;246:        const char  *build;
;247:        char        *strp;
;248:        gedict_t    *te;
;249:        static char sg_status[1024];
;250:
;251:        if( pl->is_building )
ADDRFP4 0
INDIRP4
CNSTI4 872
ADDP4
INDIRI4
CNSTI4 0
EQI4 $129
line 252
;252:                build = "  building                             ";
ADDRLP4 8
ADDRGP4 $131
ASGNP4
ADDRGP4 $130
JUMPV
LABELV $129
line 254
;253:        else
;254:                build = "                                       ";
ADDRLP4 8
ADDRGP4 $132
ASGNP4
LABELV $130
line 256
;255:
;256:        if( !pl->has_dispenser && !pl->has_sentry )
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 996
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $133
ADDRLP4 12
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $133
line 257
;257:                return build;
ADDRLP4 8
INDIRP4
RETP4
ADDRGP4 $127
JUMPV
LABELV $133
line 259
;258:                        
;259:        strp = sg_status;
ADDRLP4 4
ADDRGP4 $128
ASGNP4
line 261
;260:
;261:      	if ( pl->has_dispenser )
ADDRFP4 0
INDIRP4
CNSTI4 996
ADDP4
INDIRI4
CNSTI4 0
EQI4 $135
line 262
;262:      	{
line 264
;263:
;264:        	for ( te = world; (te = trap_find( te, FOFS( s.v.classname ), "building_dispenser" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $140
JUMPV
LABELV $137
line 265
;265:        	{
line 266
;266:        		if ( te->real_owner != pl )
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $142
line 267
;267:        			continue;
ADDRGP4 $138
JUMPV
LABELV $142
line 268
;268:        		_snprintf( strp, 30, "DISP: %3d ", ( int ) te->s.v.health );
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 30
ARGI4
ADDRGP4 $144
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 _snprintf
CALLI4
pop
line 269
;269:        		strp += 10;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 10
ADDP4
ASGNP4
line 270
;270:        		break;
ADDRGP4 $139
JUMPV
LABELV $138
line 264
LABELV $140
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $141
ARGP4
ADDRLP4 20
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $137
LABELV $139
line 272
;271:        	}
;272:      		if ( pl->has_sentry )
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
CNSTI4 0
EQI4 $145
line 273
;273:      			*strp++ = '|';
ADDRLP4 24
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI1 124
ASGNI1
LABELV $145
line 274
;274:      	}
LABELV $135
line 275
;275:      	*strp = 0;
ADDRLP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 276
;276:      	if ( pl->has_sentry )
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
CNSTI4 0
EQI4 $147
line 277
;277:      	{
line 278
;278:        	for ( te = world; (te = trap_find( te, FOFS( s.v.classname ), "building_sentrygun" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $152
JUMPV
LABELV $149
line 279
;279:        	{
line 280
;280:        		if ( te->real_owner != pl )
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $154
line 281
;281:        			continue;
ADDRGP4 $150
JUMPV
LABELV $154
line 282
;282:        		if ( (te->has_sentry && te->s.v.health <= 0 ) && tg_data.tg_enabled )
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $156
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $156
ADDRGP4 tg_data
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $156
line 283
;283:        		{
line 284
;284:        			strcat( strp, "SENTRY:dead " );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $158
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 285
;285:        			break;
ADDRGP4 $151
JUMPV
LABELV $156
line 287
;286:        		}
;287:        		if ( te->s.v.health > 0 )
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $159
line 288
;288:        		{
line 289
;289:        			_snprintf( strp, 30, " SENTRY: %3d ", ( int ) te->s.v.health );
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 30
ARGI4
ADDRGP4 $161
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 _snprintf
CALLI4
pop
line 290
;290:        			strp += 13;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 13
ADDP4
ASGNP4
line 291
;291:        		}
LABELV $159
line 293
;292:
;293:        		if ( !te->s.v.ammo_shells )
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 0
NEF4 $162
line 294
;294:        		{
line 295
;295:        			if ( !te->s.v.ammo_rockets && te->s.v.weapon == 3 )
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 0
NEF4 $164
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $164
line 296
;296:        				strcat( strp, "no ammo   " );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $166
ARGP4
ADDRGP4 strcat
CALLP4
pop
ADDRGP4 $163
JUMPV
LABELV $164
line 298
;297:        			else
;298:        				strcat( strp, "no shells " );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $167
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 299
;299:        		} else
ADDRGP4 $163
JUMPV
LABELV $162
line 300
;300:        		{
line 301
;301:        			if ( !te->s.v.ammo_rockets && te->s.v.weapon == 3 )
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 0
NEF4 $168
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $168
line 302
;302:        				strcat( strp, "no rockets ");
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $170
ARGP4
ADDRGP4 strcat
CALLP4
pop
ADDRGP4 $169
JUMPV
LABELV $168
line 304
;303:        			else
;304:        				strcat( strp, "           ");
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $171
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $169
line 305
;305:        		}
LABELV $163
line 306
;306:        		strp += 11;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 11
ADDP4
ASGNP4
line 307
;307:        		break;
ADDRGP4 $151
JUMPV
LABELV $150
line 278
LABELV $152
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $153
ARGP4
ADDRLP4 20
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $149
LABELV $151
line 310
;308:        	}
;309:        	
;310:      	}
LABELV $147
line 311
;311:      	strcat( strp, build );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 312
;312:      	return sg_status;
ADDRGP4 $128
RETP4
LABELV $127
endproc GetEngSbar 32 16
data
align 4
LABELV sbar_msg
address $172
address $173
address $174
address $175
address $176
address $177
address $178
address $179
address $180
export StatusRes
code
proc StatusRes 4 12
line 329
;313:}
;314:
;315:
;316:
;317:static const char   *sbar_msg[] = {
;318:	"Status Bar Res set to 320x200.\n",
;319:	"Status Bar Res set to 320x240.\n",
;320:	"Status Bar Res set to 400x300.\n",
;321:	"Status Bar Res set to 320x350.\n",
;322:	"Status Bar Res set to 512x384.\n",
;323:	"Status Bar Res set to 640x400.\n",
;324:	"Status Bar Res set to 640x480.\n",
;325:	"Status Bar Res set to 800x600.\n",
;326:	"Status Bar Res set to 1024x768.\n"
;327:};
;328:void StatusRes( int res )
;329:{
line 330
;330:	if ( res > 8 )
ADDRFP4 0
INDIRI4
CNSTI4 8
LEI4 $182
line 331
;331:		res = 8;
ADDRFP4 0
CNSTI4 8
ASGNI4
LABELV $182
line 333
;332:
;333:	self->StatusBarRes = res;
ADDRGP4 self
INDIRP4
CNSTI4 1492
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 334
;334:	G_sprint( self, 2, sbar_msg[res] );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 0
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ADDRLP4 0
INDIRI4
LSHI4
ADDRGP4 sbar_msg
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 335
;335:}
LABELV $181
endproc StatusRes 4 12
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
import Throw_Grapple
import Service_Grapple
import Reset_Grapple
import crossproduct
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
LABELV $180
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 32
byte 1 66
byte 1 97
byte 1 114
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 49
byte 1 48
byte 1 50
byte 1 52
byte 1 120
byte 1 55
byte 1 54
byte 1 56
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $179
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 32
byte 1 66
byte 1 97
byte 1 114
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 56
byte 1 48
byte 1 48
byte 1 120
byte 1 54
byte 1 48
byte 1 48
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $178
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 32
byte 1 66
byte 1 97
byte 1 114
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 54
byte 1 52
byte 1 48
byte 1 120
byte 1 52
byte 1 56
byte 1 48
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $177
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 32
byte 1 66
byte 1 97
byte 1 114
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 54
byte 1 52
byte 1 48
byte 1 120
byte 1 52
byte 1 48
byte 1 48
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $176
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 32
byte 1 66
byte 1 97
byte 1 114
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 53
byte 1 49
byte 1 50
byte 1 120
byte 1 51
byte 1 56
byte 1 52
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $175
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 32
byte 1 66
byte 1 97
byte 1 114
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 51
byte 1 50
byte 1 48
byte 1 120
byte 1 51
byte 1 53
byte 1 48
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $174
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 32
byte 1 66
byte 1 97
byte 1 114
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 52
byte 1 48
byte 1 48
byte 1 120
byte 1 51
byte 1 48
byte 1 48
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $173
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 32
byte 1 66
byte 1 97
byte 1 114
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 51
byte 1 50
byte 1 48
byte 1 120
byte 1 50
byte 1 52
byte 1 48
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $172
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 32
byte 1 66
byte 1 97
byte 1 114
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 51
byte 1 50
byte 1 48
byte 1 120
byte 1 50
byte 1 48
byte 1 48
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $171
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $170
byte 1 110
byte 1 111
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 0
align 1
LABELV $167
byte 1 110
byte 1 111
byte 1 32
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 0
align 1
LABELV $166
byte 1 110
byte 1 111
byte 1 32
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $161
byte 1 32
byte 1 83
byte 1 69
byte 1 78
byte 1 84
byte 1 82
byte 1 89
byte 1 58
byte 1 32
byte 1 37
byte 1 51
byte 1 100
byte 1 32
byte 1 0
align 1
LABELV $158
byte 1 83
byte 1 69
byte 1 78
byte 1 84
byte 1 82
byte 1 89
byte 1 58
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 0
align 1
LABELV $153
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 95
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $144
byte 1 68
byte 1 73
byte 1 83
byte 1 80
byte 1 58
byte 1 32
byte 1 37
byte 1 51
byte 1 100
byte 1 32
byte 1 0
align 1
LABELV $141
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 95
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $132
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $131
byte 1 32
byte 1 32
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $126
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $125
byte 1 102
byte 1 101
byte 1 105
byte 1 103
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $122
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 117
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 99
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $121
byte 1 102
byte 1 101
byte 1 105
byte 1 103
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 117
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 99
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 103
byte 1 111
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 117
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 99
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $114
byte 1 102
byte 1 101
byte 1 105
byte 1 103
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 103
byte 1 111
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 117
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 99
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $109
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $108
byte 1 102
byte 1 101
byte 1 105
byte 1 103
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $101
byte 1 69
byte 1 110
byte 1 103
byte 1 105
byte 1 110
byte 1 101
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $100
byte 1 83
byte 1 112
byte 1 121
byte 1 0
align 1
LABELV $99
byte 1 80
byte 1 121
byte 1 114
byte 1 111
byte 1 0
align 1
LABELV $98
byte 1 72
byte 1 118
byte 1 121
byte 1 32
byte 1 87
byte 1 112
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $97
byte 1 77
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 0
align 1
LABELV $96
byte 1 68
byte 1 101
byte 1 109
byte 1 111
byte 1 109
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $95
byte 1 83
byte 1 111
byte 1 108
byte 1 100
byte 1 105
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $94
byte 1 83
byte 1 110
byte 1 105
byte 1 112
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $93
byte 1 83
byte 1 99
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $92
byte 1 71
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $91
byte 1 89
byte 1 101
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $90
byte 1 82
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $89
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $71
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 10
byte 1 37
byte 1 115
byte 1 37
byte 1 51
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 51
byte 1 100
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $70
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 10
byte 1 37
byte 1 115
byte 1 37
byte 1 51
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 51
byte 1 100
byte 1 32
byte 1 32
byte 1 195
byte 1 204
byte 1 201
byte 1 208
byte 1 58
byte 1 37
byte 1 50
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $60
byte 1 79
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $59
byte 1 79
byte 1 110
byte 1 32
byte 1 0
align 1
LABELV $57
byte 1 70
byte 1 114
byte 1 0
align 1
LABELV $55
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $54
byte 1 69
byte 1 110
byte 1 0
align 1
LABELV $53
byte 1 83
byte 1 99
byte 1 97
byte 1 110
byte 1 32
byte 1 37
byte 1 51
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 51
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $49
byte 1 68
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $46
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $41
byte 1 32
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $18
byte 1 0
align 1
LABELV $17
byte 1 32
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 58
byte 1 0
align 1
LABELV $16
byte 1 32
byte 1 32
byte 1 89
byte 1 101
byte 1 108
byte 1 108
byte 1 58
byte 1 0
align 1
LABELV $15
byte 1 32
byte 1 32
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 58
byte 1 0
align 1
LABELV $14
byte 1 32
byte 1 32
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 58
byte 1 0
