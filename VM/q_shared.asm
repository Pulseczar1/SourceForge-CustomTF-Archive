export ShortSwap
code
proc ShortSwap 2 0
ADDRFP4 0
ADDRFP4 0
INDIRI4
CVII2 4
ASGNI2
file "..\src\q_shared.c"
line 59
;1:/*
;2: *  QWProgs-DM
;3: *  Copyright (C) 2004  [sd] angel
;4: *
;5: *  This code is based on QuakeWorld DM mod code by Id Software, Inc.
;6: *
;7: *
;8: *  This program is free software; you can redistribute it and/or modify
;9: *  it under the terms of the GNU General Public License as published by
;10: *  the Free Software Foundation; either version 2 of the License, or
;11: *  (at your option) any later version.
;12: *
;13: *  This program is distributed in the hope that it will be useful,
;14: *  but WITHOUT ANY WARRANTY; without even the implied warranty of
;15: *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;16: *  GNU General Public License for more details.
;17: *
;18: *  You should have received a copy of the GNU General Public License
;19: *  along with this program; if not, write to the Free Software
;20: *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
;21: *
;22: *
;23: *  $Id: q_shared.c,v 1.4 2006/03/04 15:10:06 AngelD Exp $
;24: */
;25:
;26:// q_shared.c -- stateless support routines that are included in each code dll
;27:#include "q_shared.h"
;28:void            G_Error( const char *fmt, ... );
;29:/*
;30:============================================================================
;31:
;32:					BYTE ORDER FUNCTIONS
;33:
;34:============================================================================
;35:*/
;36:/*
;37:// can't just use function pointers, or dll linkage can
;38:// mess up when qcommon is included in multiple places
;39:static short	(*_BigShort) (short l);
;40:static short	(*_LittleShort) (short l);
;41:static int		(*_BigLong) (int l);
;42:static int		(*_LittleLong) (int l);
;43:static qint64	(*_BigLong64) (qint64 l);
;44:static qint64	(*_LittleLong64) (qint64 l);
;45:static float	(*_BigFloat) (const float *l);
;46:static float	(*_LittleFloat) (const float *l);
;47:
;48:short	BigShort(short l){return _BigShort(l);}
;49:short	LittleShort(short l) {return _LittleShort(l);}
;50:int		BigLong (int l) {return _BigLong(l);}
;51:int		LittleLong (int l) {return _LittleLong(l);}
;52:qint64 	BigLong64 (qint64 l) {return _BigLong64(l);}
;53:qint64 	LittleLong64 (qint64 l) {return _LittleLong64(l);}
;54:float	BigFloat (const float *l) {return _BigFloat(l);}
;55:float	LittleFloat (const float *l) {return _LittleFloat(l);}
;56:*/
;57:
;58:short   ShortSwap (short l)
;59:{
line 62
;60:	byte    b1,b2;
;61:
;62:	b1 = l&255;
ADDRLP4 0
ADDRFP4 0
INDIRI2
CVII4 2
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 63
;63:	b2 = (l>>8)&255;
ADDRLP4 1
ADDRFP4 0
INDIRI2
CVII4 2
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 65
;64:
;65:	return (b1<<8) + b2;
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 8
LSHI4
ADDRLP4 1
INDIRU1
CVUI4 1
ADDI4
CVII2 4
CVII4 2
RETI4
LABELV $2
endproc ShortSwap 2 0
export ShortNoSwap
proc ShortNoSwap 0 0
ADDRFP4 0
ADDRFP4 0
INDIRI4
CVII2 4
ASGNI2
line 69
;66:}
;67:
;68:short	ShortNoSwap (short l)
;69:{
line 70
;70:	return l;
ADDRFP4 0
INDIRI2
CVII4 2
RETI4
LABELV $3
endproc ShortNoSwap 0 0
export LongSwap
proc LongSwap 4 0
line 74
;71:}
;72:
;73:int    LongSwap (int l)
;74:{
line 77
;75:	byte    b1,b2,b3,b4;
;76:
;77:	b1 = l&255;
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 78
;78:	b2 = (l>>8)&255;
ADDRLP4 1
ADDRFP4 0
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 79
;79:	b3 = (l>>16)&255;
ADDRLP4 2
ADDRFP4 0
INDIRI4
CNSTI4 16
RSHI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 80
;80:	b4 = (l>>24)&255;
ADDRLP4 3
ADDRFP4 0
INDIRI4
CNSTI4 24
RSHI4
CNSTI4 255
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 82
;81:
;82:	return ((int)b1<<24) + ((int)b2<<16) + ((int)b3<<8) + b4;
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 24
LSHI4
ADDRLP4 1
INDIRU1
CVUI4 1
CNSTI4 16
LSHI4
ADDI4
ADDRLP4 2
INDIRU1
CVUI4 1
CNSTI4 8
LSHI4
ADDI4
ADDRLP4 3
INDIRU1
CVUI4 1
ADDI4
RETI4
LABELV $4
endproc LongSwap 4 0
export LongNoSwap
proc LongNoSwap 0 0
line 86
;83:}
;84:
;85:int	LongNoSwap (int l)
;86:{
line 87
;87:	return l;
ADDRFP4 0
INDIRI4
RETI4
LABELV $5
endproc LongNoSwap 0 0
export Long64Swap
proc Long64Swap 8 0
line 91
;88:}
;89:
;90:qint64 Long64Swap (qint64 ll)
;91:{
line 94
;92:	qint64	result;
;93:
;94:	result.b0 = ll.b7;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 7
ADDP4
INDIRU1
ASGNU1
line 95
;95:	result.b1 = ll.b6;
ADDRLP4 0+1
ADDRFP4 4
INDIRP4
CNSTI4 6
ADDP4
INDIRU1
ASGNU1
line 96
;96:	result.b2 = ll.b5;
ADDRLP4 0+2
ADDRFP4 4
INDIRP4
CNSTI4 5
ADDP4
INDIRU1
ASGNU1
line 97
;97:	result.b3 = ll.b4;
ADDRLP4 0+3
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRU1
ASGNU1
line 98
;98:	result.b4 = ll.b3;
ADDRLP4 0+4
ADDRFP4 4
INDIRP4
CNSTI4 3
ADDP4
INDIRU1
ASGNU1
line 99
;99:	result.b5 = ll.b2;
ADDRLP4 0+5
ADDRFP4 4
INDIRP4
CNSTI4 2
ADDP4
INDIRU1
ASGNU1
line 100
;100:	result.b6 = ll.b1;
ADDRLP4 0+6
ADDRFP4 4
INDIRP4
CNSTI4 1
ADDP4
INDIRU1
ASGNU1
line 101
;101:	result.b7 = ll.b0;
ADDRLP4 0+7
ADDRFP4 4
INDIRP4
INDIRU1
ASGNU1
line 103
;102:
;103:	return result;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRB
ASGNB 8
LABELV $6
endproc Long64Swap 8 0
export Long64NoSwap
proc Long64NoSwap 0 0
line 107
;104:}
;105:
;106:qint64 Long64NoSwap (qint64 ll)
;107:{
line 108
;108:	return ll;
ADDRFP4 0
INDIRP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 8
LABELV $15
endproc Long64NoSwap 0 0
export FloatSwap
proc FloatSwap 12 4
line 116
;109:}
;110:
;111:typedef union _FloatByteUnion_u{
;112:    float	f;
;113:    unsigned int i;
;114:} _FloatByteUnion;
;115:
;116:float FloatSwap (const float *f) {
line 120
;117:	const _FloatByteUnion *in;
;118:	_FloatByteUnion out;
;119:
;120:	in = (_FloatByteUnion *)f;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 121
;121:	out.i = LongSwap(in->i);
ADDRLP4 0
INDIRP4
INDIRU4
CVUI4 4
ARGI4
ADDRLP4 8
ADDRGP4 LongSwap
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
CVIU4 4
ASGNU4
line 123
;122:
;123:	return out.f;
ADDRLP4 4
INDIRF4
RETF4
LABELV $17
endproc FloatSwap 12 4
export FloatNoSwap
proc FloatNoSwap 0 0
line 127
;124:}
;125:
;126:float FloatNoSwap (const float *f)
;127:{
line 128
;128:	return *f;
ADDRFP4 0
INDIRP4
INDIRF4
RETF4
LABELV $18
endproc FloatNoSwap 0 0
export Q_isprint
proc Q_isprint 4 0
line 177
;129:}
;130:
;131:/*
;132:================
;133:Swap_Init
;134:================
;135:*/
;136:/*
;137:void Swap_Init (void)
;138:{
;139:	byte	swaptest[2] = {1,0};
;140:
;141:// set the byte swapping variables in a portable manner	
;142:	if ( *(short *)swaptest == 1)
;143:	{
;144:		_BigShort = ShortSwap;
;145:		_LittleShort = ShortNoSwap;
;146:		_BigLong = LongSwap;
;147:		_LittleLong = LongNoSwap;
;148:		_BigLong64 = Long64Swap;
;149:		_LittleLong64 = Long64NoSwap;
;150:		_BigFloat = FloatSwap;
;151:		_LittleFloat = FloatNoSwap;
;152:	}
;153:	else
;154:	{
;155:		_BigShort = ShortNoSwap;
;156:		_LittleShort = ShortSwap;
;157:		_BigLong = LongNoSwap;
;158:		_LittleLong = LongSwap;
;159:		_BigLong64 = Long64NoSwap;
;160:		_LittleLong64 = Long64Swap;
;161:		_BigFloat = FloatNoSwap;
;162:		_LittleFloat = FloatSwap;
;163:	}
;164:
;165:}
;166:*/
;167:
;168:/*
;169:============================================================================
;170:
;171:					LIBRARY REPLACEMENT FUNCTIONS
;172:
;173:============================================================================
;174:*/
;175:
;176:int Q_isprint( int c )
;177:{
line 178
;178:	if ( c >= 0x20 && c <= 0x7E )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $20
ADDRLP4 0
INDIRI4
CNSTI4 126
GTI4 $20
line 179
;179:		return ( 1 );
CNSTI4 1
RETI4
ADDRGP4 $19
JUMPV
LABELV $20
line 180
;180:	return ( 0 );
CNSTI4 0
RETI4
LABELV $19
endproc Q_isprint 4 0
export Q_islower
proc Q_islower 4 0
line 184
;181:}
;182:
;183:int Q_islower( int c )
;184:{
line 185
;185:	if (c >= 'a' && c <= 'z')
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 97
LTI4 $23
ADDRLP4 0
INDIRI4
CNSTI4 122
GTI4 $23
line 186
;186:		return ( 1 );
CNSTI4 1
RETI4
ADDRGP4 $22
JUMPV
LABELV $23
line 187
;187:	return ( 0 );
CNSTI4 0
RETI4
LABELV $22
endproc Q_islower 4 0
export Q_isupper
proc Q_isupper 4 0
line 191
;188:}
;189:
;190:int Q_isupper( int c )
;191:{
line 192
;192:	if (c >= 'A' && c <= 'Z')
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 65
LTI4 $26
ADDRLP4 0
INDIRI4
CNSTI4 90
GTI4 $26
line 193
;193:		return ( 1 );
CNSTI4 1
RETI4
ADDRGP4 $25
JUMPV
LABELV $26
line 194
;194:	return ( 0 );
CNSTI4 0
RETI4
LABELV $25
endproc Q_isupper 4 0
export Q_isalpha
proc Q_isalpha 8 0
line 198
;195:}
;196:
;197:int Q_isalpha( int c )
;198:{
line 199
;199:	if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'))
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 97
LTI4 $32
ADDRLP4 0
INDIRI4
CNSTI4 122
LEI4 $31
LABELV $32
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 65
LTI4 $29
ADDRLP4 4
INDIRI4
CNSTI4 90
GTI4 $29
LABELV $31
line 200
;200:		return ( 1 );
CNSTI4 1
RETI4
ADDRGP4 $28
JUMPV
LABELV $29
line 201
;201:	return ( 0 );
CNSTI4 0
RETI4
LABELV $28
endproc Q_isalpha 8 0
export Q_strrchr
proc Q_strrchr 12 0
line 205
;202:}
;203:
;204:char* Q_strrchr( const char* string, int c )
;205:{
line 206
;206:	char cc = c;
ADDRLP4 4
ADDRFP4 4
INDIRI4
CVII1 4
ASGNI1
line 208
;207:	char *s;
;208:	char *sp=(char *)0;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 210
;209:
;210:	s = (char*)string;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $35
JUMPV
LABELV $34
line 213
;211:
;212:	while (*s)
;213:	{
line 214
;214:		if (*s == cc)
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI1
CVII4 1
NEI4 $37
line 215
;215:			sp = s;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $37
line 216
;216:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 217
;217:	}
LABELV $35
line 212
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $34
line 218
;218:	if (cc == 0)
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $39
line 219
;219:		sp = s;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $39
line 221
;220:
;221:	return sp;
ADDRLP4 8
INDIRP4
RETP4
LABELV $33
endproc Q_strrchr 12 0
export Q_strncpyz
proc Q_strncpyz 0 12
line 231
;222:}
;223:
;224:/*
;225:=============
;226:Q_strncpyz
;227: 
;228:Safe strncpy that ensures a trailing zero
;229:=============
;230:*/
;231:void Q_strncpyz( char *dest, const char *src, int destsize ) {
line 233
;232:  // bk001129 - also NULL dest
;233:  if ( !dest ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $42
line 234
;234:    G_Error(  "Q_strncpyz: NULL dest" );
ADDRGP4 $44
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 235
;235:  }
LABELV $42
line 236
;236:	if ( !src ) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $45
line 237
;237:		G_Error(  "Q_strncpyz: NULL src" );
ADDRGP4 $47
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 238
;238:	}
LABELV $45
line 239
;239:	if ( destsize < 1 ) {
ADDRFP4 8
INDIRI4
CNSTI4 1
GEI4 $48
line 240
;240:		G_Error("Q_strncpyz: destsize < 1" ); 
ADDRGP4 $50
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 241
;241:	}
LABELV $48
line 243
;242:
;243:	strncpy( dest, src, destsize-1 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 244
;244:  dest[destsize-1] = 0;
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ADDRFP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 245
;245:}
LABELV $41
endproc Q_strncpyz 0 12
export Q_stricmpn
proc Q_stricmpn 32 0
line 247
;246:                 
;247:int Q_stricmpn (const char *s1, const char *s2, int n) {
line 251
;248:	int		c1, c2;
;249:
;250:	// bk001129 - moved in 1.17 fix not in id codebase
;251:        if ( s1 == NULL ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $52
line 252
;252:           if ( s2 == NULL )
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $54
line 253
;253:             return 0;
CNSTI4 0
RETI4
ADDRGP4 $51
JUMPV
LABELV $54
line 255
;254:           else
;255:             return -1;
CNSTI4 -1
RETI4
ADDRGP4 $51
JUMPV
LABELV $52
line 257
;256:        }
;257:        else if ( s2==NULL )
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $56
line 258
;258:          return 1;
CNSTI4 1
RETI4
ADDRGP4 $51
JUMPV
LABELV $56
LABELV $58
line 262
;259:
;260:
;261:	
;262:	do {
line 263
;263:		c1 = *s1++;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 264
;264:		c2 = *s2++;
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 4
ADDRLP4 12
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 266
;265:
;266:		if (!n--) {
ADDRLP4 16
ADDRFP4 8
INDIRI4
ASGNI4
ADDRFP4 8
ADDRLP4 16
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $61
line 267
;267:			return 0;		// strings are equal until end point
CNSTI4 0
RETI4
ADDRGP4 $51
JUMPV
LABELV $61
line 270
;268:		}
;269:		
;270:		if (c1 != c2) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $63
line 271
;271:			if (c1 >= 'a' && c1 <= 'z') {
ADDRLP4 0
INDIRI4
CNSTI4 97
LTI4 $65
ADDRLP4 0
INDIRI4
CNSTI4 122
GTI4 $65
line 272
;272:				c1 -= ('a' - 'A');
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 32
SUBI4
ASGNI4
line 273
;273:			}
LABELV $65
line 274
;274:			if (c2 >= 'a' && c2 <= 'z') {
ADDRLP4 4
INDIRI4
CNSTI4 97
LTI4 $67
ADDRLP4 4
INDIRI4
CNSTI4 122
GTI4 $67
line 275
;275:				c2 -= ('a' - 'A');
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 32
SUBI4
ASGNI4
line 276
;276:			}
LABELV $67
line 277
;277:			if (c1 != c2) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $69
line 278
;278:				return c1 < c2 ? -1 : 1;
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $72
ADDRLP4 28
CNSTI4 -1
ASGNI4
ADDRGP4 $73
JUMPV
LABELV $72
ADDRLP4 28
CNSTI4 1
ASGNI4
LABELV $73
ADDRLP4 28
INDIRI4
RETI4
ADDRGP4 $51
JUMPV
LABELV $69
line 280
;279:			}
;280:		}
LABELV $63
line 281
;281:	} while (c1);
LABELV $59
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $58
line 283
;282:	
;283:	return 0;		// strings are equal
CNSTI4 0
RETI4
LABELV $51
endproc Q_stricmpn 32 0
export Q_strncmp
proc Q_strncmp 24 0
line 286
;284:}
;285:
;286:int Q_strncmp (const char *s1, const char *s2, int n) {
LABELV $75
line 289
;287:	int		c1, c2;
;288:	
;289:	do {
line 290
;290:		c1 = *s1++;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 291
;291:		c2 = *s2++;
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 4
ADDRLP4 12
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 293
;292:
;293:		if (!n--) {
ADDRLP4 16
ADDRFP4 8
INDIRI4
ASGNI4
ADDRFP4 8
ADDRLP4 16
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $78
line 294
;294:			return 0;		// strings are equal until end point
CNSTI4 0
RETI4
ADDRGP4 $74
JUMPV
LABELV $78
line 297
;295:		}
;296:		
;297:		if (c1 != c2) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $80
line 298
;298:			return c1 < c2 ? -1 : 1;
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $83
ADDRLP4 20
CNSTI4 -1
ASGNI4
ADDRGP4 $84
JUMPV
LABELV $83
ADDRLP4 20
CNSTI4 1
ASGNI4
LABELV $84
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $74
JUMPV
LABELV $80
line 300
;299:		}
;300:	} while (c1);
LABELV $76
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $75
line 302
;301:	
;302:	return 0;		// strings are equal
CNSTI4 0
RETI4
LABELV $74
endproc Q_strncmp 24 0
export Q_stricmp
proc Q_stricmp 12 12
line 305
;303:}
;304:
;305:int Q_stricmp (const char *s1, const char *s2) {
line 306
;306:	return (s1 && s2) ? Q_stricmpn (s1, s2, 99999) : -1;
ADDRLP4 4
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
EQU4 $87
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
EQU4 $87
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 99999
ARGI4
ADDRLP4 8
ADDRGP4 Q_stricmpn
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
ADDRGP4 $88
JUMPV
LABELV $87
ADDRLP4 0
CNSTI4 -1
ASGNI4
LABELV $88
ADDRLP4 0
INDIRI4
RETI4
LABELV $85
endproc Q_stricmp 12 12
export Q_strlwr
proc Q_strlwr 12 4
line 310
;307:}
;308:
;309:
;310:char *Q_strlwr( char *s1 ) {
line 313
;311:    char	*s;
;312:
;313:    s = s1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $91
JUMPV
LABELV $90
line 314
;314:	while ( *s ) {
line 315
;315:		*s = tolower(*s);
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 tolower
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CVII1 4
ASGNI1
line 316
;316:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 317
;317:	}
LABELV $91
line 314
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $90
line 318
;318:    return s1;
ADDRFP4 0
INDIRP4
RETP4
LABELV $89
endproc Q_strlwr 12 4
export Q_strupr
proc Q_strupr 12 4
line 321
;319:}
;320:
;321:char *Q_strupr( char *s1 ) {
line 324
;322:    char	*s;
;323:
;324:    s = s1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $95
JUMPV
LABELV $94
line 325
;325:	while ( *s ) {
line 326
;326:		*s = toupper(*s);
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CVII1 4
ASGNI1
line 327
;327:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 328
;328:	}
LABELV $95
line 325
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $94
line 329
;329:    return s1;
ADDRFP4 0
INDIRP4
RETP4
LABELV $93
endproc Q_strupr 12 4
export Q_strcat
proc Q_strcat 12 12
line 334
;330:}
;331:
;332:
;333:// never goes past bounds or leaves without a terminating 0
;334:void Q_strcat( char *dest, int size, const char *src ) {
line 337
;335:	int		l1;
;336:
;337:	l1 = strlen( dest );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 338
;338:	if ( l1 >= size ) {
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $98
line 339
;339:		G_Error( "Q_strcat: already overflowed" );
ADDRGP4 $100
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 340
;340:	}
LABELV $98
line 341
;341:	Q_strncpyz( dest + l1, src, size - l1 );
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 342
;342:}
LABELV $97
endproc Q_strcat 12 12
import G_Error
import Q_CleanStr
import Q_PrintStrlen
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
LABELV $100
byte 1 81
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 99
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $50
byte 1 81
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 110
byte 1 99
byte 1 112
byte 1 121
byte 1 122
byte 1 58
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 60
byte 1 32
byte 1 49
byte 1 0
align 1
LABELV $47
byte 1 81
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 110
byte 1 99
byte 1 112
byte 1 121
byte 1 122
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 115
byte 1 114
byte 1 99
byte 1 0
align 1
LABELV $44
byte 1 81
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 110
byte 1 99
byte 1 112
byte 1 121
byte 1 122
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 0
