export Prox_Disarm
code
proc Prox_Disarm 20 20
file "..\src\megatf\mtf_soldier.c"
line 31
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
;21: *  $Id: mtf_soldier.c,v 1.00 2006/09/15 XavioR Exp $
;22: */
;23:#include "g_local.h"
;24:void make_explosion ( );
;25:void MushroomFlame ( );
;26:
;27:// MegaTF soldier functions
;28:
;29:// Proximity Mine
;30:void Prox_Disarm ( )
;31:{
line 32
;32:	if ( !streq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $14
ARGP4
ADDRLP4 0
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $12
line 33
;33:		return;
ADDRGP4 $11
JUMPV
LABELV $12
line 35
;34:
;35:	if ( ( other->playerclass == PC_SCOUT ) && ( other->team_no != self->team_no ) )
ADDRLP4 4
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 1
NEI4 $11
ADDRLP4 8
CNSTI4 960
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
ADDRGP4 self
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
EQI4 $11
line 36
;36:	{
line 37
;37:		sound( other, 2, "items/flare1.wav", 1, 1 );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $17
ARGP4
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 38
;38:		other->real_frags = other->real_frags + 1;
ADDRLP4 16
ADDRGP4 other
INDIRP4
CNSTI4 1024
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 39
;39:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 40
;40:	}
line 41
;41:	return;
LABELV $11
endproc Prox_Disarm 20 20
export ProxiDie
proc ProxiDie 4 16
line 45
;42:}
;43:
;44:void ProxiDie ( )
;45:{
line 46
;46:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 48
;47:
;48:	self->s.v.effects = 4;
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1082130432
ASGNF4
line 49
;49:	make_explosion(  );
ADDRGP4 make_explosion
CALLV
pop
line 50
;50:	self->s.v.takedamage = 0;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 0
ASGNF4
line 51
;51:	mtf_deathmsg( 45 );
CNSTF4 1110704128
ARGF4
ADDRGP4 mtf_deathmsg
CALLV
pop
line 52
;52:	T_RadiusDamage ( self, owner, 200, world );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1128792064
ARGF4
ADDRGP4 world
INDIRP4
ARGP4
ADDRGP4 T_RadiusDamage
CALLV
pop
line 53
;53:	G_sprint ( owner, 2, "Your Proxi Mine is gone...\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $19
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 54
;54:	dremove ( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 55
;55:}
LABELV $18
endproc ProxiDie 4 16
export FoundBastard
proc FoundBastard 36 20
line 58
;56:
;57:void FoundBastard ( )
;58:{
line 61
;59:	float leng;
;60:	vec3_t  vtemp;
;61:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 63
;62:
;63:	self->s.v.touch = ( func_t ) Prox_Disarm;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 Prox_Disarm
CVPU4 4
CVUI4 4
ASGNI4
line 64
;64:	sound ( self, 3, "effects/beep.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $21
ARGP4
ADDRLP4 20
CNSTF4 1065353216
ASGNF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 65
;65:	self->s.v.skin = owner->team_no + 3;
ADDRGP4 self
INDIRP4
CNSTI4 228
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 3
ADDI4
CVIF4 4
ASGNF4
line 66
;66:	VectorSubtract( PROG_TO_EDICT( self->s.v.enemy )->s.v.origin, self->s.v.origin, vtemp );
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+44
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+44+4
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 32
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+44+8
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
SUBF4
ASGNF4
line 67
;67:	leng = vlen( vtemp );
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 24
INDIRF4
ASGNF4
line 69
;68:
;69:	if ( leng <= ( float ) self->height ) {
ADDRLP4 12
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
INDIRF4
GTF4 $32
line 70
;70:		self->height = leng;
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
line 71
;71:		self->s.v.nextthink = g_globalvars.time + ( ( leng / 1000 ) * 1.5 );
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1069547520
ADDRLP4 12
INDIRF4
CNSTF4 1148846080
DIVF4
MULF4
ADDF4
ASGNF4
line 72
;72:		self->s.v.think = ( func_t ) FoundBastard;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 FoundBastard
CVPU4 4
CVUI4 4
ASGNI4
line 73
;73:	}
ADDRGP4 $33
JUMPV
LABELV $32
line 74
;74:	else {
line 75
;75:		self->s.v.effects = 4;
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1082130432
ASGNF4
line 76
;76:		make_explosion (  );
ADDRGP4 make_explosion
CALLV
pop
line 77
;77:		MushroomFlame (  );
ADDRGP4 MushroomFlame
CALLV
pop
line 78
;78:		trap_WriteByte ( MSG_MULTICAST, 23 );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 79
;79:		trap_WriteByte ( MSG_MULTICAST, 3 );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 80
;80:		trap_WriteCoord ( MSG_MULTICAST, self->s.v.origin[0] );
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
line 81
;81:		trap_WriteCoord ( MSG_MULTICAST, self->s.v.origin[1] );
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
line 82
;82:		trap_WriteCoord ( MSG_MULTICAST, self->s.v.origin[2] );
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
line 83
;83:		trap_multicast( PASSVEC3( self->s.v.origin ), 1 );
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
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
line 84
;84:		mtf_deathmsg( 45 );
CNSTF4 1110704128
ARGF4
ADDRGP4 mtf_deathmsg
CALLV
pop
line 85
;85:		self->s.v.takedamage = 0;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 0
ASGNF4
line 86
;86:		T_RadiusDamage ( self, PROG_TO_EDICT( self->s.v.owner ), 200, world );
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTF4 1128792064
ARGF4
ADDRGP4 world
INDIRP4
ARGP4
ADDRGP4 T_RadiusDamage
CALLV
pop
line 87
;87:		dremove ( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 88
;88:	}
LABELV $33
line 89
;89:}
LABELV $20
endproc FoundBastard 36 20
export ProxArmed
proc ProxArmed 52 20
line 92
;90:
;91:void ProxArmed ( )
;92:{
line 95
;93:	gedict_t *te;
;94:	vec3_t vec_a;
;95:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 97
;96:
;97:	self->s.v.velocity[0] = 0;self->s.v.velocity[1] = 0;self->s.v.velocity[2] = 0;
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 0
ASGNF4
line 98
;98:	self->s.v.nextthink = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 99
;99:	self->s.v.think = ( func_t ) ProxArmed;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 ProxArmed
CVPU4 4
CVUI4 4
ASGNI4
line 100
;100:	sound ( self, 3, "effects/beep.wav", 0.3, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $21
ARGP4
CNSTF4 1050253722
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 101
;101:	self->playerclass = self->playerclass + 1;
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 103
;102:
;103:	if ( self->s.v.skin == owner->team_no )
ADDRGP4 self
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CVIF4 4
NEF4 $37
line 104
;104:		self->s.v.skin = 0;
ADDRGP4 self
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $38
JUMPV
LABELV $37
line 106
;105:	else
;106:		self->s.v.skin = owner->team_no;
ADDRGP4 self
INDIRP4
CNSTI4 228
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CVIF4 4
ASGNF4
LABELV $38
line 108
;107:
;108:	te = trap_find( world, FOFS( s.v.classname ), "player" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $14
ARGP4
ADDRLP4 24
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
ADDRGP4 $40
JUMPV
LABELV $39
line 110
;109:	while ( te )
;110:	{
line 111
;111:		if ( owner != te )
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
EQU4 $42
line 112
;112:		{
line 113
;113:			if ( ( te->team_no != 0 ) && ( te->team_no != self->team_no ) )
ADDRLP4 28
CNSTI4 960
ASGNI4
ADDRLP4 32
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $44
ADDRLP4 32
INDIRI4
ADDRGP4 self
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
EQI4 $44
line 114
;114:			{
line 115
;115:				if ( te->s.v.health > 1 )
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1065353216
LEF4 $46
line 116
;116:				{
line 117
;117:					if ( visible( te ) )
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 visible
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $48
line 118
;118:					{
line 119
;119:						if ( te->undercover_team != self->team_no )
ADDRLP4 0
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
EQI4 $50
line 120
;120:						{
line 121
;121:							VectorSubtract( te->s.v.origin, self->s.v.origin, vec_a )
ADDRLP4 40
CNSTI4 156
ASGNI4
ADDRLP4 8
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 44
CNSTI4 160
ASGNI4
ADDRLP4 8+4
ADDRLP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48
CNSTI4 164
ASGNI4
ADDRLP4 8+8
ADDRLP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 123
;122:							//vec_a = te->s.v.origin - self->s.v.origin;
;123:							if ( vlen( vec_a ) < 200 )
ADDRLP4 8
ARGP4
ADDRLP4 40
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 40
INDIRF4
CNSTF4 1128792064
GEF4 $54
line 124
;124:							{
line 125
;125:								self->height = vlen ( vec_a );
ADDRLP4 8
ARGP4
ADDRLP4 44
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
ADDRLP4 44
INDIRF4
ASGNF4
line 126
;126:								self->s.v.enemy = EDICT_TO_PROG( te );
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 127
;127:								self->s.v.nextthink = 0.2;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
CNSTF4 1045220557
ASGNF4
line 128
;128:								self->s.v.think = ( func_t ) FoundBastard;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 FoundBastard
CVPU4 4
CVUI4 4
ASGNI4
line 129
;129:							}
LABELV $54
line 130
;130:						}
LABELV $50
line 131
;131:					}
LABELV $48
line 132
;132:				}
LABELV $46
line 133
;133:			}
LABELV $44
line 134
;134:		}
LABELV $42
line 135
;135:		te = trap_find( te, FOFS( s.v.classname ), "player" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $14
ARGP4
ADDRLP4 28
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 136
;136:	}
LABELV $40
line 109
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $39
line 138
;137:
;138:	if ( self->playerclass > 300 || owner->playerclass != PC_SOLDIER )
ADDRLP4 28
CNSTI4 820
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
CNSTI4 300
GTI4 $58
ADDRLP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
CNSTI4 3
EQI4 $56
LABELV $58
line 139
;139:		dremove ( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
LABELV $56
line 140
;140:}
LABELV $35
endproc ProxArmed 52 20
export ProxAttach
proc ProxAttach 4 20
line 143
;141:
;142:void ProxAttach ( )
;143:{
line 144
;144:	self->s.v.touch = ( func_t ) SUB_Null;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 SUB_Null
CVPU4 4
CVUI4 4
ASGNI4
line 145
;145:	self->s.v.think = ( func_t ) ProxArmed;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 ProxArmed
CVPU4 4
CVUI4 4
ASGNI4
line 146
;146:	self->s.v.nextthink = ( g_globalvars.time + 0.5 );
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 147
;147:	sound ( newmis, 0, "buttons/switch02.wav", 1, 1 );
ADDRGP4 newmis
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $61
ARGP4
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 148
;148:}
LABELV $59
endproc ProxAttach 4 20
export OneProx
proc OneProx 12 12
line 151
;149:
;150:void OneProx ( )
;151:{
line 152
;152:		G_sprint ( self, 2, "1 proximity grenade at a time!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $63
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 153
;153:		if ( streq( self->s.v.weaponmodel, "progs/proxgren.mdl" ) ) {
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
INDIRP4
ARGP4
ADDRGP4 $66
ARGP4
ADDRLP4 0
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $64
line 154
;154:			self->current_weapon = W_BestWeapon(  );
ADDRLP4 4
ADDRGP4 W_BestWeapon
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 155
;155:			self->s.v.weaponmodel = "progs/v_rock2.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $67
ASGNP4
line 156
;156:			self->s.v.currentammo = self->s.v.ammo_rockets;
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ASGNF4
line 157
;157:			Attack_Finished ( 0.7 );
CNSTF4 1060320051
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 158
;158:			self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 159
;159:			self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 160
;160:		}
LABELV $64
line 161
;161:}
LABELV $62
endproc OneProx 12 12
export Prox
proc Prox 108 32
line 164
;162:
;163:void Prox ( )
;164:{
line 168
;165:	vec3_t vec_a, vec_b, vec_c, source, dest;
;166:	gedict_t *te;
;167:
;168:	vec_c[0] = 0;vec_c[1] = 0;vec_c[2] = 16;
ADDRLP4 52
CNSTF4 0
ASGNF4
ADDRLP4 52+4
CNSTF4 0
ASGNF4
ADDRLP4 52+8
CNSTF4 1098907648
ASGNF4
line 170
;169:
;170:	te = trap_find( world, FOFS( s.v.classname ), "bot" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $72
ARGP4
ADDRLP4 64
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 64
INDIRP4
ASGNP4
ADDRGP4 $74
JUMPV
LABELV $73
line 172
;171:	while ( te )
;172:	{
line 173
;173:		if ( PROG_TO_EDICT( te->s.v.owner ) == self )
ADDRLP4 24
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
ADDRGP4 self
INDIRP4
CVPU4 4
NEU4 $76
line 174
;174:		{
line 179
;175:/*			makevectors( self->s.v.v_angle );
;176:			VectorAdd( vec_c, self->s.v.origin, source );
;177:			//source = ( self->s.v.origin + '0 0 16' );
;178:			traceline ( source, ( source + ( v_forward * 64 ) ), 0, world );*/
;179:			makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 180
;180:			VectorCopy( self->s.v.origin, source );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 181
;181:			source[2] += 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 182
;182:			VectorScale( g_globalvars.v_forward, 64, dest );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1115684864
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 183
;183:			VectorAdd( dest, source, dest ) ;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 184
;184:			traceline( PASSVEC3( source ), PASSVEC3( dest ), false, world );
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
CNSTI4 0
ARGI4
ADDRGP4 world
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 187
;185:
;186://			if ( g_globalvars.trace_fraction == 1.0 ) {
;187:			OneProx(  );
ADDRGP4 OneProx
CALLV
pop
line 188
;188:			return;
ADDRGP4 $69
JUMPV
LABELV $76
line 207
;189://			}
;190:
;191:/*			// disarm self-proxy - this is a megatf United feature
;192:			if ( trace_ent.classname == "bot" && trace_ent.owner == self )
;193:			{
;194:				G_sprint( self, 2, "You disarm your proxy grenade\n" );
;195:				self->no_grenades_2 = self->no_grenades_2 + 2;
;196:				if ( self->no_grenades_2 > 4 )
;197:					self->no_grenades_2 = 4;
;198:				dremove( trace_ent );
;199:				return;
;200:			}
;201:			else
;202:			{
;203:				OneProx(  );
;204:				return;
;205:			}*/
;206:		}
;207:		te = trap_find( world, FOFS( s.v.classname ), "bot" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $72
ARGP4
ADDRLP4 68
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 68
INDIRP4
ASGNP4
line 208
;208:	}
LABELV $74
line 171
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $73
line 209
;209:	if ( self->no_grenades_2 < 2 )
ADDRGP4 self
INDIRP4
CNSTI4 844
ADDP4
INDIRI4
CNSTI4 2
GEI4 $92
line 210
;210:	{
line 211
;211:		G_sprint ( self, 2, "Not enough type 2 grenades... get more\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $94
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 212
;212:		if ( streq( self->s.v.weaponmodel, "progs/proxgren.mdl" ) ) {
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
INDIRP4
ARGP4
ADDRGP4 $66
ARGP4
ADDRLP4 68
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $69
line 213
;213:			self->s.v.weaponmodel = "progs/v_rock2.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $67
ASGNP4
line 214
;214:			self->s.v.currentammo = self->s.v.ammo_rockets;
ADDRLP4 72
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ASGNF4
line 215
;215:			Attack_Finished ( 0.7 );
CNSTF4 1060320051
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 216
;216:			self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 217
;217:			self->StatusRefreshTime = ( g_globalvars.time + 0.1 );
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 219
;218://			self->tfstate = ( self->tfstate - ( self->tfstate & 2 ) );
;219:			self->tfstate = self->tfstate - TFSTATE_RELOADING;
ADDRLP4 76
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 220
;220:		}
line 221
;221:		return;
ADDRGP4 $69
JUMPV
LABELV $92
line 223
;222:	}
;223:	if ( !streq( self->s.v.weaponmodel, "progs/proxgren.mdl" ) ) {
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
INDIRP4
ARGP4
ADDRGP4 $66
ARGP4
ADDRLP4 68
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $98
line 224
;224:		self->tfstate = self->tfstate | TFSTATE_RELOADING;
ADDRLP4 72
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 225
;225:		self->oldweaponmodel = self->s.v.weaponmodel;
ADDRLP4 76
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 1008
ADDP4
ADDRLP4 76
INDIRP4
CNSTI4 308
ADDP4
INDIRP4
ASGNP4
line 226
;226:		self->oldcurrentammo = self->s.v.currentammo;
ADDRLP4 80
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 1012
ADDP4
ADDRLP4 80
INDIRP4
CNSTI4 316
ADDP4
INDIRF4
ASGNF4
line 227
;227:		self->s.v.currentammo = 1;
ADDRGP4 self
INDIRP4
CNSTI4 316
ADDP4
CNSTF4 1065353216
ASGNF4
line 228
;228:		self->s.v.weaponmodel = "progs/proxgren.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $66
ASGNP4
line 229
;229:		self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 230
;230:		return;
ADDRGP4 $69
JUMPV
LABELV $98
line 232
;231:	}
;232:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 233
;233:	VectorScale( g_globalvars.v_forward, 10, vec_a );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1092616192
ARGF4
ADDRLP4 40
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 234
;234:	VectorAdd( vec_a, self->s.v.origin, vec_a );		// parm 1 vec_a?
ADDRLP4 40
ADDRLP4 40
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 40+4
ADDRLP4 40+4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 40+8
ADDRLP4 40+8
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDF4
ASGNF4
line 235
;235:	vec_a[2] = self->s.v.absmin[2] + self->s.v.size[2] * 0.7;
ADDRLP4 72
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 40+8
ADDRLP4 72
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CNSTF4 1060320051
ADDRLP4 72
INDIRP4
CNSTI4 268
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 236
;236:	VectorScale( g_globalvars.v_forward, 70, vec_b );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1116471296
ARGF4
ADDRLP4 28
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 237
;237:	VectorAdd( vec_b, vec_a, vec_b );
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 40
INDIRF4
ADDF4
ASGNF4
ADDRLP4 28+4
ADDRLP4 28+4
INDIRF4
ADDRLP4 40+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 28+8
ADDRLP4 28+8
INDIRF4
ADDRLP4 40+8
INDIRF4
ADDF4
ASGNF4
line 238
;238:	traceline( PASSVEC3( vec_a ), PASSVEC3( vec_b ), 0, self );
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40+4
INDIRF4
ARGF4
ADDRLP4 40+8
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28+4
INDIRF4
ARGF4
ADDRLP4 28+8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 240
;239:	//trace_ent = PROG_TO_EDICT( g_globalvars.trace_ent );
;240:	VectorScale( g_globalvars.v_forward, 8, vec_c );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1090519040
ARGF4
ADDRLP4 52
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 241
;241:	VectorSubtract( g_globalvars.trace_endpos, vec_c, vec_b );
ADDRLP4 28
ADDRGP4 g_globalvars+276
INDIRF4
ADDRLP4 52
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28+4
ADDRGP4 g_globalvars+276+4
INDIRF4
ADDRLP4 52+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28+8
ADDRGP4 g_globalvars+276+8
INDIRF4
ADDRLP4 52+8
INDIRF4
SUBF4
ASGNF4
line 243
;242://	vec_b = trace_endpos - ( v_forward * 8 );
;243:	if ( g_globalvars.trace_fraction != 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $127
line 244
;244:	{
line 245
;245:		sound ( self, 3, "buttons/switch02.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $61
ARGP4
ADDRLP4 76
CNSTF4 1065353216
ASGNF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 246
;246:		G_sprint ( self, 2, "Proximity mine set!\n" );
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
line 247
;247:		self->no_grenades_2 = self->no_grenades_2 - 2;
ADDRLP4 80
ADDRGP4 self
INDIRP4
CNSTI4 844
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 248
;248:		newmis = spawn (  );
ADDRLP4 84
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 84
INDIRP4
ASGNP4
line 249
;249:		newmis->s.v.owner = EDICT_TO_PROG( self );
ADDRGP4 newmis
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
line 250
;250:		newmis->s.v.weapon = 41;
ADDRGP4 newmis
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1109655552
ASGNF4
line 251
;251:		newmis->s.v.movetype = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 252
;252:		newmis->s.v.solid = 2;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 253
;253:		newmis->s.v.classname = "bot";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $72
ASGNP4
line 254
;254:		newmis->s.v.netname = "proxi";
ADDRGP4 newmis
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $131
ASGNP4
line 255
;255:		newmis->team_no = self->team_no;
ADDRLP4 88
CNSTI4 960
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 256
;256:		newmis->s.v.health = 3;
ADDRGP4 newmis
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1077936128
ASGNF4
line 257
;257:		newmis->s.v.takedamage = 2;
ADDRGP4 newmis
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 1073741824
ASGNF4
line 258
;258:		newmis->th_die = ProxiDie;
ADDRGP4 newmis
INDIRP4
CNSTI4 812
ADDP4
ADDRGP4 ProxiDie
ASGNP4
line 259
;259:		setsize ( newmis, -3, -3, -3, 3, 3, 3 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 92
CNSTF4 3225419776
ASGNF4
ADDRLP4 92
INDIRF4
ARGF4
ADDRLP4 92
INDIRF4
ARGF4
ADDRLP4 92
INDIRF4
ARGF4
ADDRLP4 96
CNSTF4 1077936128
ASGNF4
ADDRLP4 96
INDIRF4
ARGF4
ADDRLP4 96
INDIRF4
ARGF4
ADDRLP4 96
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 260
;260:		newmis->s.v.angles[0] = 0;newmis->s.v.angles[1] = 0;newmis->s.v.angles[2] = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 0
ASGNF4
line 261
;261:		newmis->s.v.nextthink = g_globalvars.time + 1;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 262
;262:		newmis->playerclass = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 820
ADDP4
CNSTI4 0
ASGNI4
line 263
;263:		newmis->s.v.think = ( func_t ) ProxAttach;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 ProxAttach
CVPU4 4
CVUI4 4
ASGNI4
line 264
;264:		newmis->s.v.skin = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 0
ASGNF4
line 265
;265:		newmis->s.v.frame = 1;
ADDRGP4 newmis
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1065353216
ASGNF4
line 266
;266:		setmodel ( newmis, "progs/proxgren.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $66
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 267
;267:		setorigin ( newmis, PASSVEC3( vec_b ) );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28+4
INDIRF4
ARGF4
ADDRLP4 28+8
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 268
;268:		if ( self->oldweaponmodel != "" )
ADDRGP4 self
INDIRP4
CNSTI4 1008
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 $137
CVPU4 4
EQU4 $135
line 269
;269:		{
line 270
;270:			self->tfstate = ( self->tfstate - ( self->tfstate & TFSTATE_RELOADING ) );
ADDRLP4 100
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 104
ADDRLP4 100
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 100
INDIRP4
ADDRLP4 104
INDIRI4
ADDRLP4 104
INDIRI4
CNSTI4 2
BANDI4
SUBI4
ASGNI4
line 271
;271:		}
LABELV $135
line 272
;272:		self->s.v.weaponmodel = self->oldweaponmodel;
ADDRLP4 100
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 308
ADDP4
ADDRLP4 100
INDIRP4
CNSTI4 1008
ADDP4
INDIRP4
ASGNP4
line 273
;273:		self->s.v.currentammo = self->oldcurrentammo;
ADDRLP4 104
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 104
INDIRP4
CNSTI4 1012
ADDP4
INDIRF4
ASGNF4
line 274
;274:		Attack_Finished ( 0.7 );
CNSTF4 1060320051
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 275
;275:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 276
;276:		self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 277
;277:	}
LABELV $127
line 278
;278:}อออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ
LABELV $69
endproc Prox 108 32
import MushroomFlame
import make_explosion
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
LABELV $137
byte 1 0
align 1
LABELV $131
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 105
byte 1 0
align 1
LABELV $130
byte 1 80
byte 1 114
byte 1 111
byte 1 120
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $94
byte 1 78
byte 1 111
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 111
byte 1 117
byte 1 103
byte 1 104
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 32
byte 1 50
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $72
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $67
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 118
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $66
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $63
byte 1 49
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $61
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 48
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $21
byte 1 101
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 47
byte 1 98
byte 1 101
byte 1 101
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $19
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 80
byte 1 114
byte 1 111
byte 1 120
byte 1 105
byte 1 32
byte 1 77
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 103
byte 1 111
byte 1 110
byte 1 101
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $17
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $14
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
