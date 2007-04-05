export TeamFortress_NightVision
code
proc TeamFortress_NightVision 40 20
file "..\src\megatf\common.c"
line 32
;1:/*
;2: *  QWProgs-MegaTF_C
;3: *  Copyright (C) 2006  XavioR
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
;21: *  $Id: common.c,v 1.00 2006/09/15 XavioR Exp $
;22: */
;23:
;24:/*	=========
;25:	Common MTF Functions
;26:				========  */
;27:#include "g_local.h"
;28:
;29:///////////////////////////////////////
;30:///	Night Vision
;31:void TeamFortress_NightVision (  )
;32:{
line 34
;33:	gedict_t *te, *tl;
;34:	te=world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
line 36
;35:
;36:	sound( self, 0, "items/nightvis.wav", 0.5, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $12
ARGP4
CNSTF4 1056964608
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 38
;37:	// find enemies and put lightning effects around them
;38:	te = trap_find( te, FOFS( s.v.classname ), "player" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $13
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $15
JUMPV
LABELV $14
line 40
;39:	while( te )
;40:	{
line 41
;41:		if ( self != te )
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
EQU4 $17
line 42
;42:		{
line 43
;43:			if ( te->team_no != 0 )
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 0
EQI4 $19
line 44
;44:			{
line 45
;45:				if ( te->s.v.health > 1 )
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1065353216
LEF4 $21
line 46
;46:				{
line 47
;47:					if ( visible( te ) )
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 visible
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $23
line 48
;48:					{
line 49
;49:						g_globalvars.msg_entity = EDICT_TO_PROG( self );
ADDRGP4 g_globalvars+316
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 50
;50:						tl = spawn(  );
ADDRLP4 16
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 51
;51:						tl->s.v.owner = EDICT_TO_PROG( self );
ADDRLP4 4
INDIRP4
CNSTI4 480
ADDP4
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 52
;52:						VectorCopy( te->s.v.origin, tl->s.v.origin );
ADDRLP4 20
CNSTI4 156
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24
CNSTI4 160
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 28
CNSTI4 164
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 53
;53:						tl->s.v.origin[2] = tl->s.v.origin[2] + 32;
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 54
;54:						trap_WriteByte( MSG_ONE, 23 );
CNSTI4 1
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 55
;55:						trap_WriteByte( MSG_ONE, 9 );
CNSTI4 1
ARGI4
CNSTI4 9
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 56
;56:						WriteEntity( MSG_ONE, tl );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 WriteEntity
CALLV
pop
line 57
;57:						trap_WriteCoord( MSG_ONE, tl->s.v.origin[0] );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 58
;58:						trap_WriteCoord( MSG_ONE, tl->s.v.origin[1] );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 59
;59:						trap_WriteCoord( MSG_ONE, tl->s.v.origin[2] );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 60
;60:						trap_WriteCoord( MSG_ONE, te->s.v.origin[0] );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 61
;61:						trap_WriteCoord( MSG_ONE, te->s.v.origin[1] );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 62
;62:						trap_WriteCoord( MSG_ONE, te->s.v.origin[2] + 5 );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1084227584
ADDF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 63
;63:						dremove( tl );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 64
;64:					}
LABELV $23
line 65
;65:				}
LABELV $21
line 66
;66:			}
LABELV $19
line 67
;67:		}
LABELV $17
line 68
;68:		te = trap_find( te, FOFS( s.v.classname ), "player" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $13
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 69
;69:	}
LABELV $15
line 39
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $14
line 70
;70:	te=world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
line 71
;71:	te = trap_find( te, FOFS( s.v.classname ), "building_sentrygun" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $26
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
ADDRGP4 $28
JUMPV
LABELV $27
line 73
;72:	while ( te )
;73:	{
line 74
;74:		if ( self != te )
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
EQU4 $30
line 75
;75:		{
line 76
;76:			if ( te->team_no != 0 )
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 0
EQI4 $32
line 77
;77:			{
line 78
;78:				if ( te->s.v.health > 1 )
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1065353216
LEF4 $34
line 79
;79:				{
line 80
;80:					if ( visible( te ) )
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 visible
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $36
line 81
;81:					{
line 82
;82:						g_globalvars.msg_entity = EDICT_TO_PROG( self );
ADDRGP4 g_globalvars+316
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 83
;83:						tl = spawn(  );
ADDRLP4 20
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 84
;84:						tl->s.v.owner = EDICT_TO_PROG( self );
ADDRLP4 4
INDIRP4
CNSTI4 480
ADDP4
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 85
;85:						VectorCopy( te->s.v.origin, tl->s.v.origin );
ADDRLP4 24
CNSTI4 156
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 28
CNSTI4 160
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 32
CNSTI4 164
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 86
;86:						tl->s.v.origin[2] = tl->s.v.origin[2] + 32;
ADDRLP4 24
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 87
;87:						trap_WriteByte( MSG_ONE, 23 );
CNSTI4 1
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 88
;88:						trap_WriteByte( MSG_ONE, 9 );
CNSTI4 1
ARGI4
CNSTI4 9
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 89
;89:						WriteEntity( MSG_ONE, tl );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 WriteEntity
CALLV
pop
line 90
;90:						trap_WriteCoord( MSG_ONE, tl->s.v.origin[0] );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 91
;91:						trap_WriteCoord( MSG_ONE, tl->s.v.origin[1] );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 92
;92:						trap_WriteCoord( MSG_ONE, tl->s.v.origin[2] );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 93
;93:						trap_WriteCoord( MSG_ONE, te->s.v.origin[0] );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 94
;94:						trap_WriteCoord( MSG_ONE, te->s.v.origin[1] );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 95
;95:						trap_WriteCoord( MSG_ONE, te->s.v.origin[2] + 5 );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1084227584
ADDF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 96
;96:						dremove( tl );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 97
;97:					}
LABELV $36
line 98
;98:				}
LABELV $34
line 99
;99:			}
LABELV $32
line 100
;100:		}
LABELV $30
line 101
;101:		te = trap_find( te, FOFS( s.v.classname ), "building_sentrygun" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $26
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 102
;102:	}
LABELV $28
line 72
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $27
line 103
;103:	te=world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
line 104
;104:	te = trap_find( te, FOFS( s.v.classname ), "bot" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $39
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
ADDRGP4 $41
JUMPV
LABELV $40
line 106
;105:	while ( te )
;106:	{
line 107
;107:		if ( self != te )
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
EQU4 $43
line 108
;108:		{
line 109
;109:			if ( te->team_no != 0 )
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 0
EQI4 $45
line 110
;110:			{
line 111
;111:				if ( te->s.v.health > 1 )
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1065353216
LEF4 $47
line 112
;112:				{
line 113
;113:					if ( visible( te ) )
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 visible
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $49
line 114
;114:					{
line 115
;115:						g_globalvars.msg_entity = EDICT_TO_PROG( self );
ADDRGP4 g_globalvars+316
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 116
;116:						tl = spawn(  );
ADDRLP4 24
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 117
;117:						tl->s.v.owner = EDICT_TO_PROG( self );
ADDRLP4 4
INDIRP4
CNSTI4 480
ADDP4
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 118
;118:						VectorCopy( te->s.v.origin, tl->s.v.origin );
ADDRLP4 28
CNSTI4 156
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 32
CNSTI4 160
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 36
CNSTI4 164
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 119
;119:						tl->s.v.origin[2] = tl->s.v.origin[2] + 32;
ADDRLP4 28
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 120
;120:						trap_WriteByte( MSG_ONE, 23 );
CNSTI4 1
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 121
;121:						trap_WriteByte( MSG_ONE, 9 );
CNSTI4 1
ARGI4
CNSTI4 9
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 122
;122:						WriteEntity( MSG_ONE, tl );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 WriteEntity
CALLV
pop
line 123
;123:						trap_WriteCoord( MSG_ONE, tl->s.v.origin[0] );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 124
;124:						trap_WriteCoord( MSG_ONE, tl->s.v.origin[1] );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 125
;125:						trap_WriteCoord( MSG_ONE, tl->s.v.origin[2] );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 126
;126:						trap_WriteCoord( MSG_ONE, te->s.v.origin[0] );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 127
;127:						trap_WriteCoord( MSG_ONE, te->s.v.origin[1] );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 128
;128:						trap_WriteCoord( MSG_ONE, te->s.v.origin[2] + 5 );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1084227584
ADDF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 129
;129:						dremove( tl );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 130
;130:					}
LABELV $49
line 131
;131:				}
LABELV $47
line 132
;132:			}
LABELV $45
line 133
;133:		}
LABELV $43
line 134
;134:		te = trap_find( te, FOFS( s.v.classname ), "bot" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $39
ARGP4
ADDRLP4 20
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 135
;135:	}
LABELV $41
line 105
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $40
line 136
;136:}
LABELV $11
endproc TeamFortress_NightVision 40 20
export lay
proc lay 8 28
line 141
;137:
;138:///////////////////////////////////////
;139:/// lay mode sizes
;140:void lay ( )
;141:{
line 142
;142:	setsize( self, -16, -16, -24, 16, 16, 8 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 0
CNSTF4 3246391296
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 3250585600
ARGF4
ADDRLP4 4
CNSTF4 1098907648
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 1090519040
ARGF4
ADDRGP4 setsize
CALLV
pop
line 143
;143:}
LABELV $52
endproc lay 8 28
export unlay
proc unlay 8 28
line 146
;144:
;145:void unlay ( )
;146:{
line 147
;147:	setsize( self, -16, -16, -24, 16, 16, 32 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 0
CNSTF4 3246391296
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 3250585600
ARGF4
ADDRLP4 4
CNSTF4 1098907648
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 setsize
CALLV
pop
line 148
;148:}
LABELV $53
endproc unlay 8 28
export HoloHumm
proc HoloHumm 16 20
line 153
;149:
;150:////////////////////////////////////////
;151:///		 Hologram
;152:void HoloHumm ( )
;153:{
line 154
;154:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 156
;155:
;156:	self->playerclass = self->playerclass + 1;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 157
;157:	self->s.v.nextthink = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 158
;158:	sound( self, 0, "ambient/100hzhum.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $56
ARGP4
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 159
;159:	if ( self->playerclass > 4 ) {
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 4
LEI4 $57
line 160
;160:		trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 161
;161:		trap_WriteByte( MSG_MULTICAST, 11 );
CNSTI4 4
ARGI4
CNSTI4 11
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 162
;162:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
CNSTI4 4
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 163
;163:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
CNSTI4 4
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 164
;164:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] );
CNSTI4 4
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 165
;165:		trap_multicast( PASSVEC3( self->s.v.origin ), 1 );
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 166
;166:		if ( self->playerclass > 4 ) {
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 4
LEI4 $59
line 167
;167:			owner->has_holo = 1;
ADDRLP4 0
INDIRP4
CNSTI4 1768
ADDP4
CNSTI4 1
ASGNI4
line 168
;168:			self->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 169
;169:		}
LABELV $59
line 170
;170:	}
LABELV $57
line 171
;171:}
LABELV $54
endproc HoloHumm 16 20
export HoloDood
proc HoloDood 52 28
line 175
;172:
;173:// spawn the actual holo
;174:void HoloDood ( )
;175:{
line 179
;176:	gedict_t *holo;
;177:	vec3_t vtemp;
;178:
;179:	sound( self, 1, "weapons/railgr1a.wav", 0.6, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $62
ARGP4
CNSTF4 1058642330
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 180
;180:	holo = spawn(  );
ADDRLP4 16
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 181
;181:	holo->s.v.owner = EDICT_TO_PROG( self );
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 182
;182:	vtemp[0] =
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
line 184
;183:		self->s.v.origin[0];
;184:	vtemp[1] =
ADDRLP4 4+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
line 186
;185:		self->s.v.origin[1];
;186:	vtemp[2] =
ADDRLP4 4+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 188
;187:		self->s.v.origin[2] + 24;
;188:	setorigin( holo, PASSVEC3( vtemp ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4+4
INDIRF4
ARGF4
ADDRLP4 4+8
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 189
;189:	holo->s.v.angles[1] = self->s.v.angles[1];
ADDRLP4 20
CNSTI4 196
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 190
;190:	holo->s.v.angles[0] = self->s.v.angles[0];
ADDRLP4 24
CNSTI4 192
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 191
;191:	holo->s.v.skin = self->s.v.skin;
ADDRLP4 28
CNSTI4 228
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 192
;192:	holo->s.v.frame = self->s.v.frame;
ADDRLP4 32
CNSTI4 224
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 193
;193:	holo->s.v.colormap = self->s.v.colormap;
ADDRLP4 36
CNSTI4 408
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 194
;194:	holo->s.v.flags = 256;
ADDRLP4 0
INDIRP4
CNSTI4 404
ADDP4
CNSTF4 1132462080
ASGNF4
line 195
;195:	holo->s.v.solid = SOLID_TRIGGER;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 196
;196:	holo->s.v.effects = EF_DIMLIGHT;
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1090519040
ASGNF4
line 197
;197:	holo->s.v.movetype = MOVETYPE_TOSS;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 198
;198:	setmodel( holo, "progs/player.mdl" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $67
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 199
;199:	setsize( holo, -16, -16, -24, 16, 16, 32 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 40
CNSTF4 3246391296
ASGNF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
CNSTF4 3250585600
ARGF4
ADDRLP4 44
CNSTF4 1098907648
ASGNF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 setsize
CALLV
pop
line 200
;200:	holo->s.v.classname = "holo";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $68
ASGNP4
line 201
;201:	holo->playerclass = 0;
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
CNSTI4 0
ASGNI4
line 202
;202:	holo->s.v.nextthink = g_globalvars.time + 1;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 203
;203:	holo->s.v.think = ( func_t ) HoloHumm;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 HoloHumm
CVPU4 4
CVUI4 4
ASGNI4
line 204
;204:	trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 205
;205:	trap_WriteByte( MSG_MULTICAST, 11 );
CNSTI4 4
ARGI4
CNSTI4 11
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 206
;206:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
CNSTI4 4
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 207
;207:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
CNSTI4 4
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 208
;208:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] );
CNSTI4 4
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 209
;209:	trap_multicast( PASSVEC3( self->s.v.origin ), 1 );
ADDRLP4 48
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 48
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 48
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 210
;210:}
LABELV $61
endproc HoloDood 52 28
export MakeHolo
proc MakeHolo 0 12
line 214
;211:
;212:// pre-holo spawn
;213:void MakeHolo ( )
;214:{
line 215
;215:	if ( self->playerclass == 0 )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $71
line 216
;216:		return;
ADDRGP4 $70
JUMPV
LABELV $71
line 217
;217:	if ( self->has_holo != 1 )
ADDRGP4 self
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
CNSTI4 1
EQI4 $73
line 218
;218:	{
line 219
;219:		G_sprint( self, 2, "holograph already running!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $75
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 220
;220:		return;
ADDRGP4 $70
JUMPV
LABELV $73
line 222
;221:	}
;222:	self->has_holo = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1768
ADDP4
CNSTI4 0
ASGNI4
line 223
;223:	HoloDood ();
ADDRGP4 HoloDood
CALLV
pop
line 224
;224:	G_sprint (self, 2, "Holographic replica active!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $76
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 225
;225:}
LABELV $70
endproc MakeHolo 0 12
export ShellHit
proc ShellHit 4 20
line 229
;226:
;227:// Shell Eject
;228:void ShellHit ( )
;229:{
line 230
;230:	if ( self->s.v.skin == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $78
line 231
;231:		sound( self, 3, "weapons/shell2.wav", 0.5, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $80
ARGP4
CNSTF4 1056964608
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
ADDRGP4 $77
JUMPV
LABELV $78
line 232
;232:	else {
line 233
;233:		if ( g_random(  ) < 0.5 )
ADDRLP4 0
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
GEF4 $81
line 234
;234:			sound( self, 3, "weapons/tink1.wav", 0.5, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $83
ARGP4
CNSTF4 1056964608
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
ADDRGP4 $77
JUMPV
LABELV $81
line 236
;235:		else
;236:			sound( self, 3, "weapons/tink2.wav", 0.6, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $84
ARGP4
CNSTF4 1058642330
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 237
;237:	}
line 238
;238:	return;
LABELV $77
endproc ShellHit 4 20
export EjectShell
proc EjectShell 32 28
line 242
;239:}
;240:
;241:void EjectShell ( )
;242:{
line 245
;243:	vec3_t	s_org;
;244:
;245:	newmis = spawn (  );
ADDRLP4 12
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 12
INDIRP4
ASGNP4
line 246
;246:	newmis->s.v.movetype = MOVETYPE_BOUNCE;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1092616192
ASGNF4
line 247
;247:	newmis->s.v.solid = SOLID_TRIGGER;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 248
;248:	newmis->team_no = self->team_no;
ADDRLP4 16
CNSTI4 960
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 249
;249:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 251
;250:
;251:	if ( self->s.v.v_angle[0] )	{
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
INDIRF4
CNSTF4 0
EQF4 $86
line 252
;252:		if ( self->current_weapon == WEAP_SNIPER_RIFLE )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 32
NEI4 $88
line 253
;253:		{
line 254
;254:			newmis->s.v.velocity[0] = g_globalvars.v_forward[0] * 70 + g_globalvars.v_up[0] * 90 + ( ( g_random( ) * g_globalvars.v_right[0] ) * -150 );
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1116471296
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
CNSTF4 1119092736
ADDRGP4 g_globalvars+240
INDIRF4
MULF4
ADDF4
CNSTF4 3272998912
ADDRLP4 20
INDIRF4
ADDRGP4 g_globalvars+252
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 255
;255:			newmis->s.v.velocity[1] = g_globalvars.v_forward[1] * 70 + g_globalvars.v_up[1] * 90 + ( ( g_random( ) * g_globalvars.v_right[1] ) * -150 );
ADDRLP4 24
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1116471296
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
CNSTF4 1119092736
ADDRGP4 g_globalvars+240+4
INDIRF4
MULF4
ADDF4
CNSTF4 3272998912
ADDRLP4 24
INDIRF4
ADDRGP4 g_globalvars+252+4
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 256
;256:			newmis->s.v.velocity[2] = g_globalvars.v_forward[2] * 70 + g_globalvars.v_up[2] * 90 + ( ( g_random( ) * g_globalvars.v_right[2] ) * -150 );
ADDRLP4 28
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1116471296
ADDRGP4 g_globalvars+228+8
INDIRF4
MULF4
CNSTF4 1119092736
ADDRGP4 g_globalvars+240+8
INDIRF4
MULF4
ADDF4
CNSTF4 3272998912
ADDRLP4 28
INDIRF4
ADDRGP4 g_globalvars+252+8
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 257
;257:		}
ADDRGP4 $87
JUMPV
LABELV $88
line 259
;258:		else
;259:		{
line 260
;260:			newmis->s.v.velocity[0] = g_globalvars.v_forward[0] * 70 + g_globalvars.v_up[0] * 90 + ( ( g_random( ) * g_globalvars.v_right[0] ) * 150 );
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1116471296
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
CNSTF4 1119092736
ADDRGP4 g_globalvars+240
INDIRF4
MULF4
ADDF4
CNSTF4 1125515264
ADDRLP4 20
INDIRF4
ADDRGP4 g_globalvars+252
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 261
;261:			newmis->s.v.velocity[1] = g_globalvars.v_forward[1] * 70 + g_globalvars.v_up[1] * 90 + ( ( g_random( ) * g_globalvars.v_right[1] ) * 150 );
ADDRLP4 24
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1116471296
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
CNSTF4 1119092736
ADDRGP4 g_globalvars+240+4
INDIRF4
MULF4
ADDF4
CNSTF4 1125515264
ADDRLP4 24
INDIRF4
ADDRGP4 g_globalvars+252+4
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 262
;262:			newmis->s.v.velocity[2] = g_globalvars.v_forward[2] * 70 + g_globalvars.v_up[2] * 90 + ( ( g_random( ) * g_globalvars.v_right[2] ) * 150 );
ADDRLP4 28
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1116471296
ADDRGP4 g_globalvars+228+8
INDIRF4
MULF4
CNSTF4 1119092736
ADDRGP4 g_globalvars+240+8
INDIRF4
MULF4
ADDF4
CNSTF4 1125515264
ADDRLP4 28
INDIRF4
ADDRGP4 g_globalvars+252+8
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 263
;263:		}
line 264
;264:	}
ADDRGP4 $87
JUMPV
LABELV $86
line 265
;265:	else {
line 266
;266:		aim( newmis->s.v.velocity );
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 aim
CALLV
pop
line 267
;267:		if ( self->current_weapon == WEAP_SNIPER_RIFLE )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 32
NEI4 $120
line 268
;268:		{
line 269
;269:			newmis->s.v.velocity[0] = g_globalvars.v_forward[0] * 70 + g_globalvars.v_up[0] * 90 + ( ( g_random( ) * g_globalvars.v_right[0] ) * -150 );
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1116471296
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
CNSTF4 1119092736
ADDRGP4 g_globalvars+240
INDIRF4
MULF4
ADDF4
CNSTF4 3272998912
ADDRLP4 20
INDIRF4
ADDRGP4 g_globalvars+252
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 270
;270:			newmis->s.v.velocity[1] = g_globalvars.v_forward[1] * 70 + g_globalvars.v_up[1] * 90 + ( ( g_random( ) * g_globalvars.v_right[1] ) * -150 );
ADDRLP4 24
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1116471296
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
CNSTF4 1119092736
ADDRGP4 g_globalvars+240+4
INDIRF4
MULF4
ADDF4
CNSTF4 3272998912
ADDRLP4 24
INDIRF4
ADDRGP4 g_globalvars+252+4
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 271
;271:			newmis->s.v.velocity[2] = g_globalvars.v_forward[2] * 70 + g_globalvars.v_up[2] * 90 + ( ( g_random( ) * g_globalvars.v_right[2] ) * -150 );
ADDRLP4 28
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1116471296
ADDRGP4 g_globalvars+228+8
INDIRF4
MULF4
CNSTF4 1119092736
ADDRGP4 g_globalvars+240+8
INDIRF4
MULF4
ADDF4
CNSTF4 3272998912
ADDRLP4 28
INDIRF4
ADDRGP4 g_globalvars+252+8
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 272
;272:		}
ADDRGP4 $121
JUMPV
LABELV $120
line 274
;273:		else
;274:		{
line 275
;275:			newmis->s.v.velocity[0] = g_globalvars.v_forward[0] * 70 + g_globalvars.v_up[0] * 90 + ( ( g_random( ) * g_globalvars.v_right[0] ) * 150 );
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1116471296
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
CNSTF4 1119092736
ADDRGP4 g_globalvars+240
INDIRF4
MULF4
ADDF4
CNSTF4 1125515264
ADDRLP4 20
INDIRF4
ADDRGP4 g_globalvars+252
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 276
;276:			newmis->s.v.velocity[1] = g_globalvars.v_forward[1] * 70 + g_globalvars.v_up[1] * 90 + ( ( g_random( ) * g_globalvars.v_right[1] ) * 150 );
ADDRLP4 24
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1116471296
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
CNSTF4 1119092736
ADDRGP4 g_globalvars+240+4
INDIRF4
MULF4
ADDF4
CNSTF4 1125515264
ADDRLP4 24
INDIRF4
ADDRGP4 g_globalvars+252+4
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 277
;277:			newmis->s.v.velocity[2] = g_globalvars.v_forward[2] * 70 + g_globalvars.v_up[2] * 90 + ( ( g_random( ) * g_globalvars.v_right[2] ) * 150 );
ADDRLP4 28
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1116471296
ADDRGP4 g_globalvars+228+8
INDIRF4
MULF4
CNSTF4 1119092736
ADDRGP4 g_globalvars+240+8
INDIRF4
MULF4
ADDF4
CNSTF4 1125515264
ADDRLP4 28
INDIRF4
ADDRGP4 g_globalvars+252+8
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 278
;278:		}
LABELV $121
line 279
;279:		newmis->s.v.velocity[2] = g_random(  ) * 90;
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1119092736
ADDRLP4 20
INDIRF4
MULF4
ASGNF4
line 280
;280:	}
LABELV $87
line 281
;281:	if ( g_random(  ) < 0.3 )
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 20
INDIRF4
CNSTF4 1050253722
GEF4 $152
line 282
;282:		SetVector( newmis->s.v.avelocity, 2000, 3000, 4000 );
ADDRGP4 newmis
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 1157234688
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 1161527296
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 1165623296
ASGNF4
ADDRGP4 $153
JUMPV
LABELV $152
line 284
;283:	else
;284:	{
line 285
;285:		if ( g_random(  ) < 0.6 )
ADDRLP4 24
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 24
INDIRF4
CNSTF4 1058642330
GEF4 $154
line 286
;286:			SetVector( newmis->s.v.avelocity, 4000, 2000, 3000 );
ADDRGP4 newmis
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 1165623296
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 1157234688
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 1161527296
ASGNF4
ADDRGP4 $155
JUMPV
LABELV $154
line 288
;287:		else
;288:			SetVector( newmis->s.v.avelocity, 7000, 5000, 1000 );
ADDRGP4 newmis
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 1171963904
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 1167867904
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 1148846080
ASGNF4
LABELV $155
line 289
;289:	}
LABELV $153
line 291
;290:
;291:	s_org[0] = self->s.v.origin[0] + ( g_globalvars.v_forward[0] * 10 ) + 0;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
CNSTF4 1092616192
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
ADDF4
CNSTF4 0
ADDF4
ASGNF4
line 292
;292:	s_org[1] = self->s.v.origin[1] + ( g_globalvars.v_forward[1] * 10 ) + 0;
ADDRLP4 0+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
CNSTF4 1092616192
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
ADDF4
CNSTF4 0
ADDF4
ASGNF4
line 293
;293:	s_org[2] = self->s.v.origin[2] + ( g_globalvars.v_forward[2] * 10 ) + 20;
ADDRLP4 0+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1092616192
ADDRGP4 g_globalvars+228+8
INDIRF4
MULF4
ADDF4
CNSTF4 1101004800
ADDF4
ASGNF4
line 294
;294:	setsize( newmis, 0, 0, 0, 0, 0, 0 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 296
;295:	//setorigin( newmis, ( ( self->s.v.origin + ( v_forward * 10 ) ) + '0 0 20' ) );
;296:	setorigin( newmis, PASSVEC3( s_org ) );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 298
;297:
;298:	if ( self->playerclass == PC_HVYWEAP ) {
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 6
NEI4 $165
line 299
;299:		newmis->s.v.nextthink = g_globalvars.time + 1.5;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1069547520
ADDF4
ASGNF4
line 300
;300:		setmodel( newmis, "progs/20mmcase.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $168
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 301
;301:	}
ADDRGP4 $166
JUMPV
LABELV $165
line 302
;302:	else {
line 303
;303:		newmis->s.v.nextthink = g_globalvars.time + 3;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1077936128
ADDF4
ASGNF4
line 304
;304:		setmodel( newmis, "progs/shell2.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $170
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 305
;305:	}
LABELV $166
line 307
;306:
;307:	newmis->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 308
;308:	newmis->s.v.touch = ( func_t ) ShellHit;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 ShellHit
CVPU4 4
CVUI4 4
ASGNI4
line 309
;309:	if ( self->current_weapon == WEAP_SHOTGUN || self->current_weapon == WEAP_SUPER_SHOTGUN )
ADDRLP4 28
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 128
EQI4 $173
ADDRLP4 28
INDIRI4
CNSTI4 256
NEI4 $171
LABELV $173
line 310
;310:		newmis->s.v.skin = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $172
JUMPV
LABELV $171
line 312
;311:	else
;312:		newmis->s.v.skin = 1;
ADDRGP4 newmis
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $172
line 313
;313:}
LABELV $85
endproc EjectShell 32 28
export mtf_deathmsg
proc mtf_deathmsg 0 0
line 317
;314:
;315:// Death message wrapper
;316:void mtf_deathmsg ( float dmsg )
;317:{
line 318
;318:	tf_data.megatf_dmg = (int) dmsg;	// tells obituary to display a megatf death message
ADDRGP4 tf_data+208
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 319
;319:	tf_data.deathmsg = (int) dmsg;
ADDRGP4 tf_data+88
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 320
;320:}
LABELV $174
endproc mtf_deathmsg 0 0
export s2_explode1
proc s2_explode1 0 0
line 334
;321:
;322:// explosion stuff
;323:// explosion sequence (used by proxi explosion funct)
;324:void    s2_explode1(  );
;325:void    s2_explode2(  );
;326:void    s2_explode3(  );
;327:void    s2_explode4(  );
;328:void    s2_explode5(  );
;329:void    s2_explode6(  );
;330:void    s2_explode7(  );
;331:void    s2_explode8(  );
;332:void	check_water(  );
;333:void s2_explode1(  )
;334:{
line 335
;335:	self->s.v.frame = 0;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 0
ASGNF4
line 336
;336:	self->s.v.think = ( func_t ) s2_explode2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 s2_explode2
CVPU4 4
CVUI4 4
ASGNI4
line 337
;337:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 338
;338:	check_water();
ADDRGP4 check_water
CALLV
pop
line 339
;339:}
LABELV $177
endproc s2_explode1 0 0
export s2_explode2
proc s2_explode2 0 0
line 342
;340:
;341:void s2_explode2(  )
;342:{
line 343
;343:	self->s.v.frame = 1;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1065353216
ASGNF4
line 344
;344:	self->s.v.think = ( func_t ) s2_explode3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 s2_explode3
CVPU4 4
CVUI4 4
ASGNI4
line 345
;345:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 346
;346:	check_water();
ADDRGP4 check_water
CALLV
pop
line 347
;347:}
LABELV $179
endproc s2_explode2 0 0
export s2_explode3
proc s2_explode3 0 0
line 350
;348:
;349:void s2_explode3(  )
;350:{
line 351
;351:	self->s.v.frame = 2;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1073741824
ASGNF4
line 352
;352:	self->s.v.think = ( func_t ) s2_explode4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 s2_explode4
CVPU4 4
CVUI4 4
ASGNI4
line 353
;353:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 354
;354:	check_water();
ADDRGP4 check_water
CALLV
pop
line 355
;355:}
LABELV $181
endproc s2_explode3 0 0
export s2_explode4
proc s2_explode4 0 0
line 358
;356:
;357:void s2_explode4(  )
;358:{
line 359
;359:	self->s.v.frame = 3;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1077936128
ASGNF4
line 360
;360:	self->s.v.think = ( func_t ) s2_explode5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 s2_explode5
CVPU4 4
CVUI4 4
ASGNI4
line 361
;361:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 362
;362:	check_water();
ADDRGP4 check_water
CALLV
pop
line 363
;363:}
LABELV $183
endproc s2_explode4 0 0
export s2_explode5
proc s2_explode5 0 0
line 366
;364:
;365:void s2_explode5(  )
;366:{
line 367
;367:	self->s.v.frame = 4;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1082130432
ASGNF4
line 368
;368:	self->s.v.think = ( func_t ) s2_explode6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 s2_explode6
CVPU4 4
CVUI4 4
ASGNI4
line 369
;369:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 370
;370:	check_water();
ADDRGP4 check_water
CALLV
pop
line 371
;371:}
LABELV $185
endproc s2_explode5 0 0
export s2_explode6
proc s2_explode6 0 0
line 374
;372:
;373:void s2_explode6(  )
;374:{
line 375
;375:	self->s.v.frame = 5;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1084227584
ASGNF4
line 376
;376:	self->s.v.think = ( func_t ) s2_explode7;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 s2_explode7
CVPU4 4
CVUI4 4
ASGNI4
line 377
;377:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 378
;378:	check_water();
ADDRGP4 check_water
CALLV
pop
line 379
;379:}
LABELV $187
endproc s2_explode6 0 0
export s2_explode7
proc s2_explode7 0 0
line 382
;380:
;381:void s2_explode7(  )
;382:{
line 383
;383:	self->s.v.frame = 5;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1084227584
ASGNF4
line 384
;384:	self->s.v.think = ( func_t ) s2_explode8;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 s2_explode8
CVPU4 4
CVUI4 4
ASGNI4
line 385
;385:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 386
;386:	check_water();
ADDRGP4 check_water
CALLV
pop
line 387
;387:}
LABELV $189
endproc s2_explode7 0 0
export s2_explode8
proc s2_explode8 0 0
line 390
;388:
;389:void s2_explode8(  )
;390:{
line 391
;391:	self->s.v.frame = 5;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1084227584
ASGNF4
line 392
;392:	self->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 393
;393:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 394
;394:	check_water();
ADDRGP4 check_water
CALLV
pop
line 395
;395:}
LABELV $191
endproc s2_explode8 0 0
export make_explosion
proc make_explosion 16 20
line 398
;396:
;397:void make_explosion ( )
;398:{
line 400
;399:
;400:	newmis = spawn ( );
ADDRLP4 0
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 0
INDIRP4
ASGNP4
line 401
;401:	setmodel( newmis, "progs/s_expl.spr" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $194
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 402
;402:	setorigin( newmis, PASSVEC3( self->s.v.origin ) );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 403
;403:	newmis->s.v.movetype = 8;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1090519040
ASGNF4
line 404
;404:	newmis->s.v.solid = SOLID_NOT;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 405
;405:	sound ( newmis, 0, "weapons/flmfire2.wav", 1, 1 );
ADDRGP4 newmis
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $195
ARGP4
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 406
;406:	newmis->s.v.effects = 8;
ADDRGP4 newmis
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1090519040
ASGNF4
line 407
;407:	newmis->s.v.velocity[2] = ( g_random () * 250.000000 );
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1132068864
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
line 408
;408:	newmis->s.v.nextthink = g_globalvars.time + 0.05;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1028443341
ADDF4
ASGNF4
line 409
;409:	newmis->s.v.think = ( func_t ) s2_explode1;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 s2_explode1
CVPU4 4
CVUI4 4
ASGNI4
line 410
;410:	newmis->s.v.nextthink = g_globalvars.time + 0.05;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1028443341
ADDF4
ASGNF4
line 411
;411:}
LABELV $193
endproc make_explosion 16 20
import check_water
import ambient_sound
import sandball_goal
import ballstart
import ball
import func_glass
import trigger_jumper
import FlashTimer
import BalloonMIRV
import player_mtf_nail1
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
LABELV $195
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 109
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $194
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 115
byte 1 95
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 46
byte 1 115
byte 1 112
byte 1 114
byte 1 0
align 1
LABELV $170
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $168
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 50
byte 1 48
byte 1 109
byte 1 109
byte 1 99
byte 1 97
byte 1 115
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $84
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 116
byte 1 105
byte 1 110
byte 1 107
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $83
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 116
byte 1 105
byte 1 110
byte 1 107
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $80
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $76
byte 1 72
byte 1 111
byte 1 108
byte 1 111
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 99
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 105
byte 1 99
byte 1 97
byte 1 32
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $75
byte 1 104
byte 1 111
byte 1 108
byte 1 111
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 104
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 114
byte 1 117
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $68
byte 1 104
byte 1 111
byte 1 108
byte 1 111
byte 1 0
align 1
LABELV $67
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $62
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 114
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $56
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 47
byte 1 49
byte 1 48
byte 1 48
byte 1 104
byte 1 122
byte 1 104
byte 1 117
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $39
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $26
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
LABELV $13
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $12
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 110
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 118
byte 1 105
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
