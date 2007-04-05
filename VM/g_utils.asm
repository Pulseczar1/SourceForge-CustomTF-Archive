export NUM_FOR_EDICT
code
proc NUM_FOR_EDICT 8 4
file "..\src\g_utils.c"
line 27
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
;20: *  $Id: g_utils.c,v 1.14 2005/11/28 18:30:57 AngelD Exp $
;21: */
;22:
;23:#include "g_local.h"
;24:
;25:
;26:int NUM_FOR_EDICT( gedict_t * e )
;27:{
line 30
;28:	int     b;
;29:
;30:	b = ( byte * ) e - ( byte * ) g_edicts;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 31
;31:	b = b / sizeof( gedict_t );
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 1824
DIVU4
CVUI4 4
ASGNI4
line 33
;32:
;33:	if ( b < 0 || b >= MAX_EDICTS )
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $14
ADDRLP4 0
INDIRI4
CNSTI4 768
LTI4 $12
LABELV $14
line 34
;34:		G_Error( "NUM_FOR_EDICT: bad pointer" );
ADDRGP4 $15
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $12
line 35
;35:	return b;
ADDRLP4 0
INDIRI4
RETI4
LABELV $11
endproc NUM_FOR_EDICT 8 4
export g_random
proc g_random 4 0
line 40
;36:}
;37:
;38:
;39:float g_random(  )
;40:{
line 41
;41:	return ( rand(  ) & 0x7fff ) / ( ( float ) 0x8000 );
ADDRLP4 0
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191182336
DIVF4
RETF4
LABELV $16
endproc g_random 4 0
export crandom
proc crandom 4 0
line 45
;42:}
;43:
;44:float crandom(  )
;45:{
line 46
;46:	return 2 * ( g_random(  ) - 0.5 );
ADDRLP4 0
ADDRGP4 g_random
CALLF4
ASGNF4
CNSTF4 1073741824
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
SUBF4
MULF4
RETF4
LABELV $17
endproc crandom 4 0
export spawn
proc spawn 12 4
line 50
;47:}
;48:
;49:gedict_t *spawn(  )
;50:{
line 51
;51:	gedict_t *t = &g_edicts[trap_spawn(  )];
ADDRLP4 4
ADDRGP4 trap_spawn
CALLI4
ASGNI4
ADDRLP4 0
CNSTI4 1824
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 53
;52:
;53:	if ( !t || t == world )
ADDRLP4 8
ADDRLP4 0
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 8
INDIRU4
CNSTU4 0
EQU4 $21
ADDRLP4 8
INDIRU4
ADDRGP4 world
INDIRP4
CVPU4 4
NEU4 $19
LABELV $21
line 54
;54:		DebugTrap( "spawn return world\n" );
ADDRGP4 $22
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $19
line 55
;55:	return t;
ADDRLP4 0
INDIRP4
RETP4
LABELV $18
endproc spawn 12 4
export rint
proc rint 0 0
line 59
;56:}
;57:
;58:int rint(float f)
;59:{
line 60
;60:	if(f > 0)
ADDRFP4 0
INDIRF4
CNSTF4 0
LEF4 $24
line 61
;61:		return (int)( f + 0.5);
ADDRFP4 0
INDIRF4
CNSTF4 1056964608
ADDF4
CVFI4 4
RETI4
ADDRGP4 $23
JUMPV
LABELV $24
line 63
;62:	else
;63:		return (int)( f - 0.5);
ADDRFP4 0
INDIRF4
CNSTF4 1056964608
SUBF4
CVFI4 4
RETI4
LABELV $23
endproc rint 0 0
export ent_remove
proc ent_remove 8 4
line 67
;64:
;65:}
;66:void ent_remove( gedict_t * t )
;67:{
line 68
;68:	if ( !t || t == world )
ADDRLP4 0
ADDRFP4 0
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 0
INDIRU4
CNSTU4 0
EQU4 $29
ADDRLP4 0
INDIRU4
ADDRGP4 world
INDIRP4
CVPU4 4
NEU4 $27
LABELV $29
line 69
;69:		DebugTrap( "BUG BUG BUG remove world\n" );
ADDRGP4 $30
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $27
line 70
;70:	trap_remove( NUM_FOR_EDICT( t ) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_remove
CALLV
pop
line 71
;71:}
LABELV $26
endproc ent_remove 8 4
export nextent
proc nextent 12 4
line 76
;72:
;73:
;74:
;75:gedict_t *nextent( gedict_t * ent )
;76:{
line 79
;77:	int     entn;
;78:
;79:	if ( !ent )
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $32
line 80
;80:		G_Error( "nextent: NULL start\n" );
ADDRGP4 $34
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $32
line 81
;81:	entn = trap_nextent( NUM_FOR_EDICT( ent ) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 trap_nextent
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 82
;82:	if ( entn )
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $35
line 83
;83:		return &g_edicts[entn];
CNSTI4 1824
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_edicts
ADDP4
RETP4
ADDRGP4 $31
JUMPV
LABELV $35
line 85
;84:	else
;85:		return NULL;
CNSTP4 0
RETP4
LABELV $31
endproc nextent 12 4
export normalize
proc normalize 40 4
line 89
;86:}
;87:
;88:void normalize( vec3_t value, vec3_t newvalue )
;89:{
line 93
;90:	float   new;
;91:
;92:
;93:	new = value[0] * value[0] + value[1] * value[1] + value[2] * value[2];
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ADDRLP4 12
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ADDRLP4 16
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
line 94
;94:	new = sqrt( new );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 96
;95:
;96:	if ( new == 0 )
ADDRLP4 0
INDIRF4
CNSTF4 0
NEF4 $38
line 97
;97:		value[0] = value[1] = value[2] = 0;
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
CNSTF4 0
ASGNF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRGP4 $39
JUMPV
LABELV $38
line 99
;98:	else
;99:	{
line 100
;100:		new = 1 / new;
ADDRLP4 0
CNSTF4 1065353216
ADDRLP4 0
INDIRF4
DIVF4
ASGNF4
line 101
;101:		newvalue[0] = value[0] * new;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 102
;102:		newvalue[1] = value[1] * new;
ADDRLP4 32
CNSTI4 4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 103
;103:		newvalue[2] = value[2] * new;
ADDRLP4 36
CNSTI4 8
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 104
;104:	}
LABELV $39
line 106
;105:
;106:}
LABELV $37
endproc normalize 40 4
export aim
proc aim 0 0
line 108
;107:void aim( vec3_t ret )
;108:{
line 109
;109:	VectorCopy( g_globalvars.v_forward, ret );
ADDRFP4 0
INDIRP4
ADDRGP4 g_globalvars+228
INDIRF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 g_globalvars+228+4
INDIRF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 g_globalvars+228+8
INDIRF4
ASGNF4
line 110
;110:}
LABELV $40
endproc aim 0 0
export aim2
proc aim2 0 0
line 112
;111:void aim2( vec3_t ret )
;112:{
line 113
;113:	VectorCopy( g_globalvars.v_forward, ret );
ADDRFP4 0
INDIRP4
ADDRGP4 g_globalvars+228
INDIRF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 g_globalvars+228+4
INDIRF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 g_globalvars+228+8
INDIRF4
ASGNF4
line 114
;114:}
LABELV $46
endproc aim2 0 0
data
export null_str
align 1
LABELV null_str
byte 1 0
export streq
code
proc streq 8 8
line 119
;115:
;116:char    null_str[] = "";
;117:
;118:int streq( const char *s1, const  char *s2 )
;119:{
line 120
;120:	if ( !s1 )
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $53
line 121
;121:		s1 = null_str;
ADDRFP4 0
ADDRGP4 null_str
ASGNP4
LABELV $53
line 122
;122:	if ( !s2 )
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $55
line 123
;123:		s2 = null_str;
ADDRFP4 4
ADDRGP4 null_str
ASGNP4
LABELV $55
line 124
;124:	return ( !strcmp( s1, s2 ) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $58
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $59
JUMPV
LABELV $58
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $59
ADDRLP4 0
INDIRI4
RETI4
LABELV $52
endproc streq 8 8
export strneq
proc strneq 4 8
line 128
;125:}
;126:
;127:int strneq( const char *s1, const char *s2 )
;128:{
line 129
;129:	if ( !s1 )
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $61
line 130
;130:		s1 = null_str;
ADDRFP4 0
ADDRGP4 null_str
ASGNP4
LABELV $61
line 131
;131:	if ( !s2 )
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $63
line 132
;132:		s2 = null_str;
ADDRFP4 4
ADDRGP4 null_str
ASGNP4
LABELV $63
line 134
;133:
;134:	return ( strcmp( s1, s2 ) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $60
endproc strneq 4 8
export vlen
proc vlen 24 4
line 145
;135:}
;136:
;137:/*
;138:=================
;139:vlen
;140:
;141:scalar vlen(vector)
;142:=================
;143:*/
;144:float vlen( vec3_t value1 )
;145:{
line 149
;146:	float   new;
;147:
;148:
;149:	new = value1[0] * value1[0] + value1[1] * value1[1] + value1[2] * value1[2];
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ADDRLP4 12
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ADDRLP4 16
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
line 150
;150:	new = sqrt( new );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 152
;151:
;152:	return new;
ADDRLP4 0
INDIRF4
RETF4
LABELV $65
endproc vlen 24 4
export vectoyaw
proc vectoyaw 20 8
line 156
;153:}
;154:
;155:float vectoyaw( vec3_t value1 )
;156:{
line 160
;157:	float   yaw;
;158:
;159:
;160:	if ( value1[1] == 0 && value1[0] == 0 )
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
NEF4 $67
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
NEF4 $67
line 161
;161:		yaw = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRGP4 $68
JUMPV
LABELV $67
line 163
;162:	else
;163:	{
line 164
;164:		yaw = ( int ) ( atan2( value1[1], value1[0] ) * 180 / M_PI );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRLP4 0
CNSTF4 1127481344
ADDRLP4 16
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
CVFI4 4
CVIF4 4
ASGNF4
line 165
;165:		if ( yaw < 0 )
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $69
line 166
;166:			yaw += 360;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $69
line 167
;167:	}
LABELV $68
line 169
;168:
;169:	return yaw;
ADDRLP4 0
INDIRF4
RETF4
LABELV $66
endproc vectoyaw 20 8
export vectoangles
proc vectoangles 48 8
line 174
;170:}
;171:
;172:
;173:void vectoangles( vec3_t value1, vec3_t ret )
;174:{
line 179
;175:	float   forward;
;176:	float   yaw, pitch;
;177:
;178:
;179:	if ( value1[1] == 0 && value1[0] == 0 )
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
NEF4 $72
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 16
INDIRF4
NEF4 $72
line 180
;180:	{
line 181
;181:		yaw = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 182
;182:		if ( value1[2] > 0 )
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 0
LEF4 $74
line 183
;183:			pitch = 90;
ADDRLP4 4
CNSTF4 1119092736
ASGNF4
ADDRGP4 $73
JUMPV
LABELV $74
line 185
;184:		else
;185:			pitch = 270;
ADDRLP4 4
CNSTF4 1132920832
ASGNF4
line 186
;186:	} else
ADDRGP4 $73
JUMPV
LABELV $72
line 187
;187:	{
line 188
;188:		yaw = ( int ) ( atan2( value1[1], value1[0] ) * 180 / M_PI );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRLP4 0
CNSTF4 1127481344
ADDRLP4 24
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
CVFI4 4
CVIF4 4
ASGNF4
line 189
;189:		if ( yaw < 0 )
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $76
line 190
;190:			yaw += 360;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $76
line 192
;191:
;192:		forward = sqrt( value1[0] * value1[0] + value1[1] * value1[1] );
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 36
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 32
INDIRF4
ADDRLP4 32
INDIRF4
MULF4
ADDRLP4 36
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 40
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 40
INDIRF4
ASGNF4
line 193
;193:		pitch = ( int ) ( atan2( value1[2], forward ) * 180 / M_PI );
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 44
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRLP4 4
CNSTF4 1127481344
ADDRLP4 44
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
CVFI4 4
CVIF4 4
ASGNF4
line 194
;194:		if ( pitch < 0 )
ADDRLP4 4
INDIRF4
CNSTF4 0
GEF4 $78
line 195
;195:			pitch += 360;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $78
line 196
;196:	}
LABELV $73
line 199
;197:
;198:
;199:	ret[0] = pitch;
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRF4
ASGNF4
line 200
;200:	ret[1] = yaw;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRF4
ASGNF4
line 201
;201:	ret[2] = 0;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 202
;202:}
LABELV $71
endproc vectoangles 48 8
export findradius
proc findradius 36 4
line 215
;203:
;204:
;205:/*
;206:=================
;207:PF_findradius
;208:
;209:Returns a chain of entities that have origins within a spherical area
;210:
;211:findradius (origin, radius)
;212:=================
;213:*/
;214:gedict_t *findradius( gedict_t * start, vec3_t org, float rad )
;215:{
line 220
;216:	gedict_t *ent;
;217:	vec3_t  eorg;
;218:	int     j;
;219:
;220:	for ( ent = nextent( start ); ent; ent = nextent( ent ) )
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 nextent
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
ADDRGP4 $84
JUMPV
LABELV $81
line 221
;221:	{
line 222
;222:		if ( ent->s.v.solid == SOLID_NOT )
ADDRLP4 4
INDIRP4
CNSTI4 152
ADDP4
INDIRF4
CNSTF4 0
NEF4 $85
line 223
;223:			continue;
ADDRGP4 $82
JUMPV
LABELV $85
line 224
;224:		for ( j = 0; j < 3; j++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $87
line 225
;225:			eorg[j] = org[j] - ( ent->s.v.origin[j] + ( ent->s.v.mins[j] + ent->s.v.maxs[j] ) * 0.5 );
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 24
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 24
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 24
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 156
ADDP4
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 24
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 236
ADDP4
ADDP4
INDIRF4
ADDRLP4 24
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 248
ADDP4
ADDP4
INDIRF4
ADDF4
MULF4
ADDF4
SUBF4
ASGNF4
LABELV $88
line 224
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $87
line 226
;226:		if ( VectorLength( eorg ) > rad )
ADDRLP4 8
ARGP4
ADDRLP4 32
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
ADDRFP4 8
INDIRF4
LEF4 $91
line 227
;227:			continue;
ADDRGP4 $82
JUMPV
LABELV $91
line 228
;228:		return ent;
ADDRLP4 4
INDIRP4
RETP4
ADDRGP4 $80
JUMPV
LABELV $82
line 220
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 nextent
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
LABELV $84
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $81
line 231
;229:
;230:	}
;231:	return NULL;
CNSTP4 0
RETP4
LABELV $80
endproc findradius 36 4
export changeyaw
proc changeyaw 24 4
line 244
;232:
;233:}
;234:
;235:
;236:/*
;237:==============
;238:changeyaw
;239:
;240:This was a major timewaster in progs, so it was converted to C
;241:==============
;242:*/
;243:void changeyaw( gedict_t * ent )
;244:{
line 247
;245:	float   ideal, current, move, speed;
;246:
;247:	current = anglemod( ent->s.v.angles[1] );
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 16
INDIRF4
ASGNF4
line 248
;248:	ideal = ent->s.v.ideal_yaw;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ASGNF4
line 249
;249:	speed = ent->s.v.yaw_speed;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ASGNF4
line 251
;250:
;251:	if ( current == ideal )
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
NEF4 $94
line 252
;252:		return;
ADDRGP4 $93
JUMPV
LABELV $94
line 253
;253:	move = ideal - current;
ADDRLP4 0
ADDRLP4 8
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 254
;254:	if ( ideal > current )
ADDRLP4 8
INDIRF4
ADDRLP4 4
INDIRF4
LEF4 $96
line 255
;255:	{
line 256
;256:		if ( move >= 180 )
ADDRLP4 0
INDIRF4
CNSTF4 1127481344
LTF4 $97
line 257
;257:			move = move - 360;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 258
;258:	} else
ADDRGP4 $97
JUMPV
LABELV $96
line 259
;259:	{
line 260
;260:		if ( move <= -180 )
ADDRLP4 0
INDIRF4
CNSTF4 3274964992
GTF4 $100
line 261
;261:			move = move + 360;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $100
line 262
;262:	}
LABELV $97
line 263
;263:	if ( move > 0 )
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $102
line 264
;264:	{
line 265
;265:		if ( move > speed )
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
LEF4 $103
line 266
;266:			move = speed;
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 267
;267:	} else
ADDRGP4 $103
JUMPV
LABELV $102
line 268
;268:	{
line 269
;269:		if ( move < -speed )
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
NEGF4
GEF4 $106
line 270
;270:			move = -speed;
ADDRLP4 0
ADDRLP4 12
INDIRF4
NEGF4
ASGNF4
LABELV $106
line 271
;271:	}
LABELV $103
line 273
;272:
;273:	ent->s.v.angles[1] = anglemod( current + move );
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ARGF4
ADDRLP4 20
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
line 274
;274:}
LABELV $93
endproc changeyaw 24 4
export makevectors
proc makevectors 0 16
line 286
;275:
;276:/*
;277:==============
;278:PF_makevectors
;279:
;280:Writes new values for v_forward, v_up, and v_right based on angles
;281:makevectors(vector)
;282:==============
;283:*/
;284:
;285:void makevectors( vec3_t vector )
;286:{
line 287
;287:	AngleVectors( vector, g_globalvars.v_forward, g_globalvars.v_right, g_globalvars.v_up );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 g_globalvars+228
ARGP4
ADDRGP4 g_globalvars+252
ARGP4
ADDRGP4 g_globalvars+240
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 288
;288:}
LABELV $108
endproc makevectors 0 16
export G_dprintf
proc G_dprintf 1028 16
line 298
;289:
;290:
;291:/*
;292:==============
;293:print functions
;294:==============
;295:*/
;296://===================================================================
;297:void G_dprintf( const char *fmt, ... )
;298:{
line 302
;299:	va_list         argptr;
;300:	char text[1024];
;301:
;302:	va_start( argptr, fmt );
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 303
;303:	_vsnprintf( text, sizeof(text), fmt, argptr );
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 _vsnprintf
CALLI4
pop
line 304
;304:	va_end( argptr );
ADDRLP4 0
CNSTP4 0
ASGNP4
line 306
;305:
;306:	trap_DPrintf( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_DPrintf
CALLV
pop
line 307
;307:}
LABELV $112
endproc G_dprintf 1028 16
export G_conprintf
proc G_conprintf 1028 16
line 310
;308:
;309:void G_conprintf( const char *fmt, ... )
;310:{
line 314
;311:	va_list         argptr;
;312:	char text[1024];
;313:
;314:	va_start( argptr, fmt );
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 315
;315:	_vsnprintf( text, sizeof(text), fmt, argptr );
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 _vsnprintf
CALLI4
pop
line 316
;316:	va_end( argptr );
ADDRLP4 0
CNSTP4 0
ASGNP4
line 318
;317:
;318:	trap_conprint( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_conprint
CALLV
pop
line 319
;319:}
LABELV $114
endproc G_conprintf 1028 16
export G_Error
proc G_Error 1028 16
line 322
;320:
;321:void G_Error( const char *fmt, ... )
;322:{
line 326
;323:	va_list         argptr;
;324:	char text[1024];
;325:
;326:	va_start( argptr, fmt );
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 327
;327:	_vsnprintf( text, sizeof(text), fmt, argptr );
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 _vsnprintf
CALLI4
pop
line 328
;328:	va_end( argptr );
ADDRLP4 0
CNSTP4 0
ASGNP4
line 330
;329:
;330:	trap_Error( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 331
;331:}
LABELV $116
endproc G_Error 1028 16
export G_sprint
proc G_sprint 1032 16
line 334
;332:
;333:void G_sprint( gedict_t * ed, int level, const char *fmt, ... )
;334:{
line 338
;335:	va_list argptr;
;336:	char text[1024];
;337:
;338:	va_start( argptr, fmt );
ADDRLP4 0
ADDRFP4 8+4
ASGNP4
line 339
;339:	_vsnprintf( text, sizeof(text), fmt, argptr );
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 _vsnprintf
CALLI4
pop
line 340
;340:	va_end( argptr );
ADDRLP4 0
CNSTP4 0
ASGNP4
line 342
;341:
;342:	trap_SPrint( NUM_FOR_EDICT( ed ), level, text );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1028
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_SPrint
CALLV
pop
line 343
;343:}
LABELV $118
endproc G_sprint 1032 16
export G_bprint
proc G_bprint 1028 16
line 346
;344:
;345:void G_bprint( int level, const char *fmt, ... )
;346:{
line 350
;347:	va_list argptr;
;348:	char text[1024];
;349:
;350:	va_start( argptr, fmt );
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 351
;351:	_vsnprintf( text, sizeof(text), fmt, argptr );
ADDRLP4 4
ARGP4
CNSTI4 1024
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
line 352
;352:	va_end( argptr );
ADDRLP4 0
CNSTP4 0
ASGNP4
line 354
;353:
;354:	trap_BPrint( level, text );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_BPrint
CALLV
pop
line 355
;355:}
LABELV $120
endproc G_bprint 1028 16
export G_centerprint
proc G_centerprint 1032 16
line 358
;356:
;357:void G_centerprint( gedict_t * ed, const char *fmt, ... )
;358:{
line 362
;359:	va_list argptr;
;360:	char text[1024];
;361:
;362:	va_start( argptr, fmt );
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 363
;363:	_vsnprintf( text, sizeof(text), fmt, argptr );
ADDRLP4 4
ARGP4
CNSTI4 1024
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
line 364
;364:	va_end( argptr );
ADDRLP4 0
CNSTP4 0
ASGNP4
line 366
;365:
;366:	trap_CenterPrint( NUM_FOR_EDICT( ed ), text );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1028
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_CenterPrint
CALLV
pop
line 367
;367:}
LABELV $122
endproc G_centerprint 1032 16
export localcmd
proc localcmd 1028 16
line 370
;368:
;369:void localcmd( const char *fmt, ... )
;370:{
line 374
;371:	va_list argptr;
;372:	char    text[1024];
;373:
;374:	va_start( argptr, fmt );
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 375
;375:	_vsnprintf( text, sizeof(text), fmt, argptr );
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 _vsnprintf
CALLI4
pop
line 376
;376:	va_end( argptr );
ADDRLP4 0
CNSTP4 0
ASGNP4
line 378
;377:
;378:	trap_localcmd( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_localcmd
CALLV
pop
line 379
;379:}
LABELV $124
endproc localcmd 1028 16
export stuffcmd
proc stuffcmd 1032 16
line 382
;380:
;381:void stuffcmd( gedict_t * ed, const char *fmt, ... )
;382:{
line 386
;383:	va_list argptr;
;384:	char    text[1024];
;385:
;386:	va_start( argptr, fmt );
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 387
;387:	_vsnprintf( text, sizeof(text), fmt, argptr );
ADDRLP4 4
ARGP4
CNSTI4 1024
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
line 388
;388:	va_end( argptr );
ADDRLP4 0
CNSTP4 0
ASGNP4
line 390
;389:
;390:	trap_stuffcmd( NUM_FOR_EDICT( ed ), text );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1028
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_stuffcmd
CALLV
pop
line 391
;391:}
LABELV $126
endproc stuffcmd 1032 16
export setorigin
proc setorigin 4 16
line 395
;392:
;393:
;394:void setorigin( gedict_t * ed, float origin_x, float origin_y, float origin_z )
;395:{
line 396
;396:	trap_setorigin( NUM_FOR_EDICT( ed ), origin_x, origin_y, origin_z );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 trap_setorigin
CALLV
pop
line 397
;397:}
LABELV $128
endproc setorigin 4 16
export setsize
proc setsize 4 28
line 400
;398:
;399:void setsize( gedict_t * ed, float min_x, float min_y, float min_z, float max_x, float max_y, float max_z )
;400:{
line 401
;401:	trap_setsize( NUM_FOR_EDICT( ed ), min_x, min_y, min_z, max_x, max_y, max_z );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 20
INDIRF4
ARGF4
ADDRFP4 24
INDIRF4
ARGF4
ADDRGP4 trap_setsize
CALLV
pop
line 402
;402:}
LABELV $129
endproc setsize 4 28
export setmodel
proc setmodel 4 8
line 405
;403:
;404:void setmodel( gedict_t * ed, char *model )
;405:{
line 406
;406:	trap_setmodel( NUM_FOR_EDICT( ed ), model );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_setmodel
CALLV
pop
line 407
;407:}
LABELV $130
endproc setmodel 4 8
export sound
proc sound 4 20
line 410
;408:
;409:void sound( gedict_t * ed, int channel, char *samp, float vol, float att )
;410:{
line 411
;411:	trap_sound( NUM_FOR_EDICT( ed ), channel, samp, vol, att );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRGP4 trap_sound
CALLV
pop
line 412
;412:}
LABELV $131
endproc sound 4 20
export checkclient
proc checkclient 4 0
line 415
;413:
;414:gedict_t *checkclient(  )
;415:{
line 416
;416:	return &g_edicts[trap_checkclient(  )];
ADDRLP4 0
ADDRGP4 trap_checkclient
CALLI4
ASGNI4
CNSTI4 1824
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_edicts
ADDP4
RETP4
LABELV $132
endproc checkclient 4 0
export traceline
proc traceline 4 32
line 419
;417:}
;418:void traceline( float v1_x, float v1_y, float v1_z, float v2_x, float v2_y, float v2_z, int nomonst, gedict_t * ed )
;419:{
line 420
;420:	trap_traceline( v1_x, v1_y, v1_z, v2_x, v2_y, v2_z, nomonst, NUM_FOR_EDICT( ed ) );
ADDRFP4 28
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 20
INDIRF4
ARGF4
ADDRFP4 24
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 trap_traceline
CALLV
pop
line 421
;421:}
LABELV $133
endproc traceline 4 32
export TraceCapsule
proc TraceCapsule 4 56
line 426
;422:
;423:void TraceCapsule( float v1_x, float v1_y, float v1_z, float v2_x, float v2_y, float v2_z, int nomonst, gedict_t * ed ,
;424:			float min_x, float min_y, float min_z, 
;425:			float max_x, float max_y, float max_z)
;426:{
line 427
;427:	trap_TraceCapsule( v1_x, v1_y, v1_z, v2_x, v2_y, v2_z, nomonst, NUM_FOR_EDICT( ed ) ,
ADDRFP4 28
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 20
INDIRF4
ARGF4
ADDRFP4 24
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 32
INDIRF4
ARGF4
ADDRFP4 36
INDIRF4
ARGF4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRF4
ARGF4
ADDRFP4 52
INDIRF4
ARGF4
ADDRGP4 trap_TraceCapsule
CALLV
pop
line 429
;428:	min_x, min_y, min_z, max_x, max_y, max_z);
;429:}
LABELV $134
endproc TraceCapsule 4 56
export droptofloor
proc droptofloor 8 4
line 432
;430:
;431:int droptofloor( gedict_t * ed )
;432:{
line 433
;433:	return trap_droptofloor( NUM_FOR_EDICT( ed ) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_droptofloor
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
LABELV $135
endproc droptofloor 8 4
export checkbottom
proc checkbottom 8 4
line 437
;434:}
;435:
;436:int checkbottom( gedict_t * ed )
;437:{
line 438
;438:	return trap_checkbottom( NUM_FOR_EDICT( ed ) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_checkbottom
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
LABELV $136
endproc checkbottom 8 4
export makestatic
proc makestatic 4 4
line 442
;439:}
;440:
;441:void makestatic( gedict_t * ed )
;442:{
line 443
;443:	trap_makestatic( NUM_FOR_EDICT( ed ) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 trap_makestatic
CALLV
pop
line 444
;444:}
LABELV $137
endproc makestatic 4 4
export setspawnparam
proc setspawnparam 4 4
line 447
;445:
;446:void setspawnparam( gedict_t * ed )
;447:{
line 448
;448:	trap_setspawnparam( NUM_FOR_EDICT( ed ) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 trap_setspawnparam
CALLV
pop
line 449
;449:}
LABELV $138
endproc setspawnparam 4 4
export logfrag
proc logfrag 8 8
line 452
;450:
;451:void logfrag( gedict_t * killer, gedict_t * killee )
;452:{
line 453
;453:	trap_logfrag( NUM_FOR_EDICT( killer ), NUM_FOR_EDICT( killee ) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_logfrag
CALLV
pop
line 454
;454:}
LABELV $139
endproc logfrag 8 8
export infokey
proc infokey 4 16
line 457
;455:
;456:void infokey( gedict_t * ed, const char *key, char *valbuff, int sizebuff )
;457:{
line 458
;458:	trap_infokey( NUM_FOR_EDICT( ed ), key, valbuff, sizebuff );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 trap_infokey
CALLV
pop
line 459
;459:}
LABELV $140
endproc infokey 4 16
export WriteEntity
proc WriteEntity 4 8
line 462
;460:
;461:void WriteEntity( int to, gedict_t * ed )
;462:{
line 463
;463:	trap_WriteEntity( to, NUM_FOR_EDICT( ed ) );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 trap_WriteEntity
CALLV
pop
line 464
;464:}
LABELV $141
endproc WriteEntity 4 8
export disableupdates
proc disableupdates 4 8
line 467
;465:
;466:void disableupdates( gedict_t * ed, float time )
;467:{
line 468
;468:	trap_disableupdates( NUM_FOR_EDICT( ed ), time );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRF4
ARGF4
ADDRGP4 trap_disableupdates
CALLV
pop
line 469
;469:}
LABELV $142
endproc disableupdates 4 8
export walkmove
proc walkmove 24 12
line 472
;470:
;471:int walkmove( gedict_t * ed, float yaw, float dist )
;472:{
line 476
;473:	gedict_t*saveself,*saveother,*saveactivator;
;474:	int retv;
;475:
;476:	saveself	= self ;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
line 477
;477:	saveother	= other;
ADDRLP4 4
ADDRGP4 other
INDIRP4
ASGNP4
line 478
;478:	saveactivator = activator;
ADDRLP4 8
ADDRGP4 activator
INDIRP4
ASGNP4
line 480
;479:
;480:	retv = trap_walkmove( NUM_FOR_EDICT( ed ), yaw,  dist );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 trap_walkmove
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 20
INDIRI4
ASGNI4
line 482
;481:
;482:	self 	= saveself;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 483
;483:	other	= saveother;
ADDRGP4 other
ADDRLP4 4
INDIRP4
ASGNP4
line 484
;484:	activator= saveactivator;
ADDRGP4 activator
ADDRLP4 8
INDIRP4
ASGNP4
line 485
;485:	return retv;
ADDRLP4 12
INDIRI4
RETI4
LABELV $143
endproc walkmove 24 12
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
import crc32
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
LABELV $34
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $30
byte 1 66
byte 1 85
byte 1 71
byte 1 32
byte 1 66
byte 1 85
byte 1 71
byte 1 32
byte 1 66
byte 1 85
byte 1 71
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 32
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $22
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 32
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $15
byte 1 78
byte 1 85
byte 1 77
byte 1 95
byte 1 70
byte 1 79
byte 1 82
byte 1 95
byte 1 69
byte 1 68
byte 1 73
byte 1 67
byte 1 84
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 0
