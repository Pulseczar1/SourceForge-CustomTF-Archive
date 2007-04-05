export GetInfokeyString
code
proc GetInfokeyString 0 16
file "..\src\g_tf_utils.c"
line 26
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
;21: *  $Id: g_tf_utils.c,v 1.7 2005/05/28 19:03:46 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:qboolean GetInfokeyString( gedict_t * pl, const char *key, const char *key2, char *value, int size, const char *defaultval )
;26:{
line 27
;27:	infokey( pl, key, value, size );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 infokey
CALLV
pop
line 28
;28:	if ( value[0] )
ADDRFP4 12
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $12
line 29
;29:		return true;
CNSTI4 1
RETI4
ADDRGP4 $11
JUMPV
LABELV $12
line 30
;30:	if ( key2 )
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $14
line 31
;31:	{
line 32
;32:		infokey( pl, key2, value, size );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 infokey
CALLV
pop
line 33
;33:		if ( value[0] )
ADDRFP4 12
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $16
line 34
;34:			return true;
CNSTI4 1
RETI4
ADDRGP4 $11
JUMPV
LABELV $16
line 35
;35:	}
LABELV $14
line 36
;36:	if ( defaultval )
ADDRFP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $18
line 37
;37:		Q_strncpyz( value, defaultval, size );
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
LABELV $18
line 39
;38:
;39:	return false;
CNSTI4 0
RETI4
LABELV $11
endproc GetInfokeyString 0 16
export GetInfokeyInt
proc GetInfokeyInt 40 16
line 43
;40:}
;41:
;42:int GetInfokeyInt( gedict_t * pl, const char *key, const char *key2, int defaultval )
;43:{
line 46
;44:	char    buff[32];
;45:
;46:	infokey( pl, key, buff, sizeof( buff ) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 infokey
CALLV
pop
line 47
;47:	if ( buff[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $21
line 48
;48:		return atoi( buff );
ADDRLP4 0
ARGP4
ADDRLP4 32
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
RETI4
ADDRGP4 $20
JUMPV
LABELV $21
line 50
;49:
;50:	if ( key2 )
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $23
line 51
;51:	{
line 52
;52:		infokey( pl, key2, buff, sizeof( buff ) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 infokey
CALLV
pop
line 53
;53:		if ( buff[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $25
line 54
;54:			return atoi( buff );
ADDRLP4 0
ARGP4
ADDRLP4 36
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
RETI4
ADDRGP4 $20
JUMPV
LABELV $25
line 55
;55:	}
LABELV $23
line 57
;56:
;57:	return defaultval;
ADDRFP4 12
INDIRI4
RETI4
LABELV $20
endproc GetInfokeyInt 40 16
export GetSVInfokeyString
proc GetSVInfokeyString 0 16
line 61
;58:}
;59:
;60:qboolean GetSVInfokeyString( const char *key, const char *key2, char *value, int size, const  char *defaultval )
;61:{
line 62
;62:	infokey( world, key, value, size );
ADDRGP4 world
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 infokey
CALLV
pop
line 63
;63:	if ( value[0] )
ADDRFP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $28
line 64
;64:		return true;
CNSTI4 1
RETI4
ADDRGP4 $27
JUMPV
LABELV $28
line 65
;65:	if ( key2 )
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $30
line 66
;66:	{
line 67
;67:		infokey( world, key2, value, size );
ADDRGP4 world
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 infokey
CALLV
pop
line 68
;68:		if ( value[0] )
ADDRFP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $32
line 69
;69:			return true;
CNSTI4 1
RETI4
ADDRGP4 $27
JUMPV
LABELV $32
line 70
;70:	}
LABELV $30
line 71
;71:	if ( defaultval )
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $34
line 72
;72:		Q_strncpyz( value, defaultval, size );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
LABELV $34
line 74
;73:
;74:	return false;
CNSTI4 0
RETI4
LABELV $27
endproc GetSVInfokeyString 0 16
export GetSVInfokeyInt
proc GetSVInfokeyInt 40 16
line 78
;75:}
;76:
;77:int GetSVInfokeyInt( const char *key, const char *key2, int defaultval )
;78:{
line 81
;79:	char    buff[32];
;80:
;81:	infokey( world, key, buff, sizeof( buff ) );
ADDRGP4 world
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 infokey
CALLV
pop
line 82
;82:	if ( buff[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $37
line 83
;83:		return atoi( buff );
ADDRLP4 0
ARGP4
ADDRLP4 32
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
RETI4
ADDRGP4 $36
JUMPV
LABELV $37
line 85
;84:
;85:	if ( key2 )
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $39
line 86
;86:	{
line 87
;87:		infokey( world, key2, buff, sizeof( buff ) );
ADDRGP4 world
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 infokey
CALLV
pop
line 88
;88:		if ( buff[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $41
line 89
;89:			return atoi( buff );
ADDRLP4 0
ARGP4
ADDRLP4 36
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
RETI4
ADDRGP4 $36
JUMPV
LABELV $41
line 90
;90:	}
LABELV $39
line 92
;91:
;92:	return defaultval;
ADDRFP4 8
INDIRI4
RETI4
LABELV $36
endproc GetSVInfokeyInt 40 16
export GetSVInfokeyFloat
proc GetSVInfokeyFloat 40 16
line 96
;93:}
;94:
;95:float GetSVInfokeyFloat( const char *key, const char *key2, float defaultval )
;96:{
line 99
;97:	char    buff[32];
;98:
;99:	infokey( world, key, buff, sizeof( buff ) );
ADDRGP4 world
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 infokey
CALLV
pop
line 100
;100:	if ( buff[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $44
line 101
;101:		return atof( buff );
ADDRLP4 0
ARGP4
ADDRLP4 32
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
RETF4
ADDRGP4 $43
JUMPV
LABELV $44
line 103
;102:
;103:	if ( key2 )
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $46
line 104
;104:	{
line 105
;105:		infokey( world, key2, buff, sizeof( buff ) );
ADDRGP4 world
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 infokey
CALLV
pop
line 106
;106:		if ( buff[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $48
line 107
;107:			return atof( buff );
ADDRLP4 0
ARGP4
ADDRLP4 36
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 36
INDIRF4
RETF4
ADDRGP4 $43
JUMPV
LABELV $48
line 108
;108:	}
LABELV $46
line 110
;109:
;110:	return defaultval;
ADDRFP4 8
INDIRF4
RETF4
LABELV $43
endproc GetSVInfokeyFloat 40 16
export KickPlayer
proc KickPlayer 0 8
line 115
;111:}
;112:
;113:
;114:void KickPlayer( int psize, gedict_t * p )
;115:{
line 116
;116:	g_globalvars.msg_entity = EDICT_TO_PROG( p );
ADDRGP4 g_globalvars+316
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 117
;117:	if ( psize > -3 )
ADDRFP4 0
INDIRI4
CNSTI4 -3
LEI4 $52
line 118
;118:		trap_WriteByte( MSG_ONE, SVC_SMALLKICK );
CNSTI4 1
ARGI4
CNSTI4 34
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
ADDRGP4 $53
JUMPV
LABELV $52
line 120
;119:	else
;120:		trap_WriteByte( MSG_ONE, SVC_BIGKICK );
CNSTI4 1
ARGI4
CNSTI4 35
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
LABELV $53
line 121
;121:}
LABELV $50
endproc KickPlayer 0 8
export muzzleflash
proc muzzleflash 4 16
line 124
;122:
;123:void muzzleflash(  )
;124:{
line 125
;125:	trap_WriteByte( MSG_MULTICAST, SVC_MUZZLEFLASH );
CNSTI4 4
ARGI4
CNSTI4 39
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 126
;126:	WriteEntity( MSG_MULTICAST, self );
CNSTI4 4
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 WriteEntity
CALLV
pop
line 127
;127:	trap_multicast( PASSVEC3( self->s.v.origin ), MULTICAST_PVS );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
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
CNSTI4 2
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 128
;128:}
LABELV $54
endproc muzzleflash 4 16
export visible
proc visible 36 32
line 136
;129:
;130://///////////////////////
;131://
;132:// Visibility
;133://
;134://///////////////////////
;135:int visible( gedict_t * targ )
;136:{
line 140
;137:	vec3_t  spot1;
;138:	vec3_t  spot2;
;139:
;140:	VectorAdd( self->s.v.origin, self->s.v.view_ofs, spot1 );
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 352
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 356
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 32
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 360
ADDP4
INDIRF4
ADDF4
ASGNF4
line 141
;141:	VectorAdd( targ->s.v.origin, targ->s.v.view_ofs, spot2 );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 352
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12+4
ADDRLP4 28
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 356
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12+8
ADDRLP4 32
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 360
ADDP4
INDIRF4
ADDF4
ASGNF4
line 143
;142:
;143:	traceline( PASSVEC3( spot1 ), PASSVEC3( spot2 ), 1, self );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 144
;144:    	if( GetSVInfokeyInt( "watervis", NULL, 0) == 0)
ADDRGP4 $66
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 24
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $64
line 145
;145:	{
line 146
;146:	 if ( g_globalvars.trace_inopen && g_globalvars.trace_inwater )
ADDRLP4 28
CNSTF4 0
ASGNF4
ADDRGP4 g_globalvars+308
INDIRF4
ADDRLP4 28
INDIRF4
EQF4 $67
ADDRGP4 g_globalvars+312
INDIRF4
ADDRLP4 28
INDIRF4
EQF4 $67
line 147
;147:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $55
JUMPV
LABELV $67
line 148
;148:	}
LABELV $64
line 150
;149:
;150:	if ( g_globalvars.trace_fraction == 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
NEF4 $71
line 151
;151:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $55
JUMPV
LABELV $71
line 153
;152:
;153:	return 0;
CNSTI4 0
RETI4
LABELV $55
endproc visible 36 32
export range
proc range 40 4
line 157
;154:}
;155:
;156:int range( gedict_t * targ )
;157:{
line 162
;158:	vec3_t  spot1;
;159:	vec3_t  spot2;
;160:	float   r;
;161:
;162:	VectorAdd( self->s.v.origin, self->s.v.view_ofs, spot1 );
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 28
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 352
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12+4
ADDRLP4 32
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 356
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12+8
ADDRLP4 36
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 360
ADDP4
INDIRF4
ADDF4
ASGNF4
line 163
;163:	VectorAdd( targ->s.v.origin, targ->s.v.view_ofs, spot2 );
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 352
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 32
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 356
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 36
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 360
ADDP4
INDIRF4
ADDF4
ASGNF4
line 164
;164:	VectorSubtract( spot1, spot2, spot2 );
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 165
;165:	r = vlen( spot2 );
ADDRLP4 0
ARGP4
ADDRLP4 28
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 28
INDIRF4
ASGNF4
line 166
;166:	if ( r < 120 )
ADDRLP4 24
INDIRF4
CNSTF4 1123024896
GEF4 $85
line 167
;167:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $74
JUMPV
LABELV $85
line 168
;168:	if ( r < 500 )
ADDRLP4 24
INDIRF4
CNSTF4 1140457472
GEF4 $87
line 169
;169:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $74
JUMPV
LABELV $87
line 170
;170:	if ( r < 1000 )
ADDRLP4 24
INDIRF4
CNSTF4 1148846080
GEF4 $89
line 171
;171:		return 2;
CNSTI4 2
RETI4
ADDRGP4 $74
JUMPV
LABELV $89
line 172
;172:	return 3;
CNSTI4 3
RETI4
LABELV $74
endproc range 40 4
export infront
proc infront 28 4
line 176
;173:}
;174:
;175:int infront( gedict_t * targ )
;176:{
line 180
;177:	vec3_t  vec;
;178:	float   dot;
;179:
;180:	makevectors( self->s.v.angles );
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 181
;181:	VectorSubtract( targ->s.v.origin, self->s.v.origin, vec );
ADDRLP4 16
CNSTI4 156
ASGNI4
ADDRLP4 0
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20
CNSTI4 160
ASGNI4
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24
CNSTI4 164
ASGNI4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 182
;182:	VectorNormalize( vec );
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 184
;183:
;184:	dot = DotProduct( vec, g_globalvars.v_forward );
ADDRLP4 12
ADDRLP4 0
INDIRF4
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRGP4 g_globalvars+228+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 185
;185:	if ( dot > 0.3 )
ADDRLP4 12
INDIRF4
CNSTF4 1050253722
LEF4 $101
line 186
;186:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $91
JUMPV
LABELV $101
line 187
;187:	return 0;
CNSTI4 0
RETI4
LABELV $91
endproc infront 28 4
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
LABELV $66
byte 1 119
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 118
byte 1 105
byte 1 115
byte 1 0
