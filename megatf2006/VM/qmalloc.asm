data
align 4
LABELV _arena_metadata
byte 4 0
align 4
LABELV _arena_data
byte 4 0
align 4
LABELV _arena_pages
byte 4 0
align 4
LABELV _arena_freestart
byte 4 1
code
proc malloc_init 4 20
file "..\src\qmalloc.c"
line 37
;1:/*
;2:  Semi-braindamaged Malloc for Quake 3 Virtual Machine.
;3:  Copyright 2002  PhaethonH <phaethon@linux.ucla.edu>
;4:
;5:  Permission granted to copy, modify, distribute, and use, provided this
;6:  copyright notice remains intact.  Source is provided on an as-is basis,
;7:  with no warranties.
;8:  $Id: qmalloc.c,v 1.4 2005/05/28 22:35:46 AngelD Exp $
;9:*/
;10:
;11:typedef int size_t;
;12:
;13:#include "qmalloc.h"
;14:
;15:
;16:static unsigned char arena[MALLOC_ARENA];
;17:
;18:static int *_arena_metadata = 0;
;19:static unsigned char *_arena_data = 0;
;20:static int _arena_pages = 0;
;21:static int _arena_freestart = 1;
;22:
;23:enum {
;24:	MALLOC_MAGIC = 0x6B8E6EB9,
;25:	PAGESIZE = 256,
;26:};
;27:
;28:/*
;29:Every PAGESIZE-bytes chunk of heap is attached to one integer metadata.
;30:Metadata holds a key, the value of the starting address of the memory block.
;31:The result is _arena_pages number of chunks, with a corresponding _arena_pages
;32:number of metadata integers.
;33:*/
;34:
;35:
;36:static void malloc_init(  )
;37:{
line 38
;38:	if ( ( ( int * ) arena )[0] == MALLOC_MAGIC )
ADDRGP4 arena
INDIRI4
CNSTI4 1804496569
NEI4 $4
line 39
;39:		return;		/* Already initialized. */
ADDRGP4 $3
JUMPV
LABELV $4
line 41
;40:
;41:	{
line 43
;42:		int     divider;
;43:		memset( arena, 0, sizeof(arena) );
ADDRGP4 arena
ARGP4
CNSTI4 0
ARGI4
CNSTU4 8388608
ARGU4
ADDRGP4 memset
CALLI4
pop
line 44
;44:		divider = PAGESIZE + sizeof( *_arena_metadata );
ADDRLP4 0
CNSTI4 260
ASGNI4
line 45
;45:		_arena_pages = MALLOC_ARENA / divider;
ADDRGP4 _arena_pages
CNSTI4 8388608
ADDRLP4 0
INDIRI4
DIVI4
ASGNI4
line 46
;46:		_arena_metadata = ( int * ) arena;
ADDRGP4 _arena_metadata
ADDRGP4 arena
ASGNP4
line 47
;47:		_arena_data = ( unsigned char * ) ( _arena_metadata + _arena_pages );
ADDRGP4 _arena_data
ADDRGP4 _arena_pages
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 _arena_metadata
INDIRP4
ADDP4
ASGNP4
line 48
;48:		( ( int * ) arena )[0] = MALLOC_MAGIC;
ADDRGP4 arena
CNSTI4 1804496569
ASGNI4
line 49
;49:	}
line 50
;50:	G_dprintf( "malloc_init: %d pages of %d bytes.  Metadata @ %08X, heap @ %08X\n",
ADDRGP4 $6
ARGP4
ADDRGP4 _arena_pages
INDIRI4
ARGI4
CNSTI4 256
ARGI4
ADDRGP4 _arena_metadata
INDIRP4
ARGP4
ADDRGP4 _arena_data
INDIRP4
ARGP4
ADDRGP4 G_dprintf
CALLI4
pop
line 52
;51:		   _arena_pages, PAGESIZE, _arena_metadata, _arena_data );
;52:}
LABELV $3
endproc malloc_init 4 20
proc findspot 12 4
line 56
;53:
;54:
;55:static int findspot( int pages )
;56:{
line 59
;57:	int     i, j;
;58:
;59:	malloc_init(  );
ADDRGP4 malloc_init
CALLV
pop
line 62
;60://printf("findspot: for %d pages\n", pages);
;61://  for (i = 1; i < (_arena_pages - pages); i++)
;62:	if ( _arena_freestart >= ( _arena_pages - pages ) )
ADDRGP4 _arena_freestart
INDIRI4
ADDRGP4 _arena_pages
INDIRI4
ADDRFP4 0
INDIRI4
SUBI4
LTI4 $8
line 63
;63:		_arena_freestart = 1;
ADDRGP4 _arena_freestart
CNSTI4 1
ASGNI4
LABELV $8
line 65
;64://printf("findspot: for %d pages starting @ %d\n", pages, _arena_freestart);
;65:	for ( i = _arena_freestart; i < ( _arena_pages - pages ); i++ )
ADDRLP4 4
ADDRGP4 _arena_freestart
INDIRI4
ASGNI4
ADDRGP4 $13
JUMPV
LABELV $10
line 66
;66:	{
line 67
;67:		if ( _arena_metadata[i] == 0 )
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 _arena_metadata
INDIRP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $14
line 68
;68:		{
line 69
;69:			for ( j = 0; j < pages; j++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $19
JUMPV
LABELV $16
line 70
;70:			{
line 71
;71:				if ( _arena_metadata[i + j] != 0 )
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
CNSTI4 2
LSHI4
ADDRGP4 _arena_metadata
INDIRP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $20
line 72
;72:					break;
ADDRGP4 $18
JUMPV
LABELV $20
line 73
;73:			}
LABELV $17
line 69
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $19
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
LTI4 $16
LABELV $18
line 74
;74:			if ( j < pages )	/* loop ended because of insufficient free pages. */
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
GEI4 $22
line 75
;75:			{
line 76
;76:				i += j;	/* Skip the blocks we know we can't use. */
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 77
;77:				continue;	/* with  for i = ... */
ADDRGP4 $11
JUMPV
LABELV $22
line 79
;78:			}
;79:			for ( j = 0; j < pages; j++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $27
JUMPV
LABELV $24
line 80
;80:			{
line 81
;81:				_arena_metadata[i + j] =
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
CNSTI4 2
LSHI4
ADDRGP4 _arena_metadata
INDIRP4
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 8
LSHI4
ADDRGP4 _arena_data
INDIRP4
ADDP4
CVPU4 4
CVUI4 4
ASGNI4
line 83
;82:				    ( int ) ( _arena_data + ( i * PAGESIZE ) );
;83:			}
LABELV $25
line 79
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $27
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
LTI4 $24
line 85
;84://printf("findspot: returning page %d (x %d) @ %08X\n", i, pages, (_arena_data + (i * PAGESIZE)));
;85:			_arena_freestart = i;
ADDRGP4 _arena_freestart
ADDRLP4 4
INDIRI4
ASGNI4
line 86
;86:			return i;
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $7
JUMPV
LABELV $14
line 88
;87:		}
;88:	}
LABELV $11
line 65
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $13
ADDRLP4 4
INDIRI4
ADDRGP4 _arena_pages
INDIRI4
ADDRFP4 0
INDIRI4
SUBI4
LTI4 $10
line 89
;89:	G_dprintf( "FATAL: findspot: Heap exhausted\n" );
ADDRGP4 $28
ARGP4
ADDRGP4 G_dprintf
CALLI4
pop
line 90
;90:	return 0;
CNSTI4 0
RETI4
LABELV $7
endproc findspot 12 4
proc usedblocks 8 0
line 95
;91:}
;92:
;93:
;94:static int usedblocks( void *ptr )
;95:{
line 99
;96:	int     i;
;97:	int     retval;
;98:
;99:	malloc_init(  );
ADDRGP4 malloc_init
CALLV
pop
line 100
;100:	retval = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 101
;101:	for ( i = 0; i < _arena_pages; i++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $33
JUMPV
LABELV $30
line 102
;102:	{
line 103
;103:		if ( _arena_metadata[i] == ( int ) ptr )
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 _arena_metadata
INDIRP4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CVPU4 4
CVUI4 4
NEI4 $34
line 104
;104:			retval++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $34
line 105
;105:	}
LABELV $31
line 101
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $33
ADDRLP4 0
INDIRI4
ADDRGP4 _arena_pages
INDIRI4
LTI4 $30
line 106
;106:	return retval;
ADDRLP4 4
INDIRI4
RETI4
LABELV $29
endproc usedblocks 8 0
export malloc
proc malloc 20 4
line 111
;107:}
;108:
;109:
;110:void   *malloc( size_t size )
;111:{
line 116
;112:	int     pages;
;113:	int     n;
;114:	void   *retval;
;115:
;116:	pages = 1 + ( ( size - 1 ) / PAGESIZE );
ADDRLP4 12
CNSTI4 1
ASGNI4
ADDRLP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
CNSTI4 256
DIVI4
ADDRLP4 12
INDIRI4
ADDI4
ASGNI4
line 117
;117:	n = findspot( pages );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 findspot
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 118
;118:	retval = ( void * ) ( _arena_data + ( n * PAGESIZE ) );
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 8
LSHI4
ADDRGP4 _arena_data
INDIRP4
ADDP4
ASGNP4
line 120
;119://printf("malloc: for %d bytes -> %08X\n", size, retval);
;120:	return retval;
ADDRLP4 8
INDIRP4
RETP4
LABELV $36
endproc malloc 20 4
export calloc
proc calloc 16 12
line 125
;121:}
;122:
;123:
;124:void   *calloc( size_t nmemb, size_t size )
;125:{
line 129
;126:	char   *retval, *p;
;127:	int     i;
;128:
;129:	retval = ( char * ) ( malloc( nmemb * size ) );
ADDRFP4 0
INDIRI4
ADDRFP4 4
INDIRI4
MULI4
ARGI4
ADDRLP4 12
ADDRGP4 malloc
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 131
;130:
;131:	memset( retval, 0, ( nmemb * size ) );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRFP4 0
INDIRI4
ADDRFP4 4
INDIRI4
MULI4
ARGI4
ADDRGP4 memset
CALLI4
pop
line 133
;132:
;133:	return ( void * ) retval;
ADDRLP4 0
INDIRP4
RETP4
LABELV $37
endproc calloc 16 12
export free
proc free 8 4
line 138
;134:}
;135:
;136:
;137:void free( void *ptr )
;138:{
line 141
;139:	int     n;
;140:
;141:	malloc_init(  );
ADDRGP4 malloc_init
CALLV
pop
line 143
;142://  n = 0;
;143:	n = ( ( unsigned char * ) ptr - _arena_data ) / PAGESIZE;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 _arena_data
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 256
DIVI4
ASGNI4
line 144
;144:	if ( ( n < 0 ) || ( n > _arena_pages ) )
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $41
ADDRLP4 0
INDIRI4
ADDRGP4 _arena_pages
INDIRI4
LEI4 $39
LABELV $41
line 145
;145:	{
line 147
;146:		/* Outside heap.  Bad. */
;147:		G_dprintf("free: ptr Outside heap.\n");
ADDRGP4 $42
ARGP4
ADDRGP4 G_dprintf
CALLI4
pop
line 148
;148:		return;
ADDRGP4 $38
JUMPV
LABELV $39
line 150
;149:	}
;150:	_arena_freestart = n;	/* Next allocation tries here, to see if it fits. */
ADDRGP4 _arena_freestart
ADDRLP4 0
INDIRI4
ASGNI4
ADDRGP4 $44
JUMPV
LABELV $43
line 152
;151:	while ( _arena_metadata[n] == ( int ) ptr )
;152:	{
line 153
;153:		_arena_metadata[n] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 _arena_metadata
INDIRP4
ADDP4
CNSTI4 0
ASGNI4
line 154
;154:		n++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 155
;155:	}
LABELV $44
line 151
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 _arena_metadata
INDIRP4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CVPU4 4
CVUI4 4
EQI4 $43
line 156
;156:	return;
LABELV $38
endproc free 8 4
export realloc
proc realloc 24 12
line 161
;157:}
;158:
;159:
;160:void   *realloc( void *ptr, size_t size )
;161:{
line 166
;162:	void   *m;
;163:	int     n, movesize;
;164:	int     pages;
;165:
;166:	if ( size == 0 )
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $47
line 167
;167:	{
line 168
;168:		free( ptr );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 free
CALLV
pop
line 169
;169:		return 0;
CNSTP4 0
RETP4
ADDRGP4 $46
JUMPV
LABELV $47
line 171
;170:	}
;171:	m = malloc( size );
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 malloc
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 172
;172:	movesize = usedblocks( ptr ) * PAGESIZE;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 usedblocks
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
CNSTI4 8
LSHI4
ASGNI4
line 174
;173://printf("realloc: from %08X to %08X, old size %d, new size %d\n", ptr, m, movesize, size);
;174:	if ( size < movesize )
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
GEI4 $49
line 175
;175:		movesize = size;
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
LABELV $49
line 178
;176://printf("realloc: moving %d bytes\n", movesize);
;177://  memmove(m, ptr, movesize);
;178:	memcpy( m, ptr, movesize );
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLI4
pop
line 179
;179:	free( ptr );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 free
CALLV
pop
line 180
;180:	return m;
ADDRLP4 4
INDIRP4
RETP4
LABELV $46
endproc realloc 24 12
data
align 4
LABELV $52
byte 4 0
skip 1020
align 4
LABELV $53
byte 4 0
export alloca
code
proc alloca 12 4
line 187
;181:}
;182:
;183:
;184:#define _ALLOCA_RINGSIZE 256
;185:
;186:void   *alloca( size_t size )
;187:{
line 192
;188:	static void *alloca_strips[_ALLOCA_RINGSIZE] = { 0, };
;189:	static int snum = 0;
;190:	void   *p;
;191:
;192:	if ( size < 0 )
ADDRFP4 0
INDIRI4
CNSTI4 0
GEI4 $54
line 193
;193:	{
line 196
;194:		/* Hack: reset alloca allocations */
;195://printf("alloca: reset hack\n");
;196:		for ( snum = 0; snum < _ALLOCA_RINGSIZE; snum++ )
ADDRGP4 $53
CNSTI4 0
ASGNI4
LABELV $56
line 197
;197:		{
line 198
;198:			free( alloca_strips[snum] );
ADDRGP4 $53
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $52
ADDP4
INDIRP4
ARGP4
ADDRGP4 free
CALLV
pop
line 199
;199:			alloca_strips[snum] = 0;
ADDRGP4 $53
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $52
ADDP4
CNSTP4 0
ASGNP4
line 200
;200:		}
LABELV $57
line 196
ADDRLP4 4
ADDRGP4 $53
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $53
INDIRI4
CNSTI4 256
LTI4 $56
line 201
;201:		snum = 0;
ADDRGP4 $53
CNSTI4 0
ASGNI4
line 202
;202:		return 0;
CNSTP4 0
RETP4
ADDRGP4 $51
JUMPV
LABELV $54
line 205
;203:	}
;204:
;205:	if ( alloca_strips[snum] )
ADDRGP4 $53
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $52
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $60
line 206
;206:	{
line 207
;207:		free( alloca_strips[snum] );
ADDRGP4 $53
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $52
ADDP4
INDIRP4
ARGP4
ADDRGP4 free
CALLV
pop
line 208
;208:		alloca_strips[snum] = 0;
ADDRGP4 $53
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $52
ADDP4
CNSTP4 0
ASGNP4
line 209
;209:	}
LABELV $60
line 210
;210:	p = malloc( size );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 malloc
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 211
;211:	if ( p == 0 )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $62
line 212
;212:	{
line 213
;213:		G_dprintf( "FATAL: malloc out of memory\n" );
ADDRGP4 $64
ARGP4
ADDRGP4 G_dprintf
CALLI4
pop
line 214
;214:	}
LABELV $62
line 215
;215:	alloca_strips[snum] = p;
ADDRGP4 $53
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $52
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 216
;216:	snum = ( snum + 1 ) % _ALLOCA_RINGSIZE;
ADDRLP4 8
ADDRGP4 $53
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 256
MODI4
ASGNI4
line 217
;217:	return p;
ADDRLP4 0
INDIRP4
RETP4
LABELV $51
endproc alloca 12 4
export alloca_reset
proc alloca_reset 0 4
line 222
;218:}
;219:
;220:
;221:void alloca_reset(  )
;222:{
line 223
;223:	alloca( -1 );
CNSTI4 -1
ARGI4
ADDRGP4 alloca
CALLP4
pop
line 224
;224:}
LABELV $65
endproc alloca_reset 0 4
import memcpy
import G_dprintf
import memset
bss
align 1
LABELV arena
skip 8388608
lit
align 1
LABELV $64
byte 1 70
byte 1 65
byte 1 84
byte 1 65
byte 1 76
byte 1 58
byte 1 32
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 99
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 10
byte 1 0
align 1
LABELV $42
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 58
byte 1 32
byte 1 112
byte 1 116
byte 1 114
byte 1 32
byte 1 79
byte 1 117
byte 1 116
byte 1 115
byte 1 105
byte 1 100
byte 1 101
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 112
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $28
byte 1 70
byte 1 65
byte 1 84
byte 1 65
byte 1 76
byte 1 58
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 115
byte 1 112
byte 1 111
byte 1 116
byte 1 58
byte 1 32
byte 1 72
byte 1 101
byte 1 97
byte 1 112
byte 1 32
byte 1 101
byte 1 120
byte 1 104
byte 1 97
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $6
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 99
byte 1 95
byte 1 105
byte 1 110
byte 1 105
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 112
byte 1 97
byte 1 103
byte 1 101
byte 1 115
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 116
byte 1 101
byte 1 115
byte 1 46
byte 1 32
byte 1 32
byte 1 77
byte 1 101
byte 1 116
byte 1 97
byte 1 100
byte 1 97
byte 1 116
byte 1 97
byte 1 32
byte 1 64
byte 1 32
byte 1 37
byte 1 48
byte 1 56
byte 1 88
byte 1 44
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 112
byte 1 32
byte 1 64
byte 1 32
byte 1 37
byte 1 48
byte 1 56
byte 1 88
byte 1 10
byte 1 0
