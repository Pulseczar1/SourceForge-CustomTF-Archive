data
align 4
LABELV num_team_flares
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
export FlareGrenadeTouch
code
proc FlareGrenadeTouch 40 20
file "..\src\flare.c"
line 31
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
;21: *  $Id: flare.c,v 1.7 2005/05/28 18:33:52 AngelD Exp $
;22: */
;23:/*==================================
;24:This file handles all the functions
;25:to deal with the flare 'grenade'.
;26:==================================*/
;27:#include "g_local.h"
;28:static int     num_team_flares[5] = { 0, 0, 0, 0, 0 };
;29:
;30:void FlareGrenadeTouch(  )
;31:{
line 32
;32:	sound( self, 1, "weapons/bounce.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $12
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
line 33
;33:	if ( trap_pointcontents( PASSVEC3( self->s.v.origin ) ) == CONTENT_SKY )
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
ADDRLP4 8
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 -6
NEI4 $13
line 34
;34:	{
line 35
;35:		newmis = spawn ( );
ADDRLP4 12
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 12
INDIRP4
ASGNP4
line 36
;36:		setmodel ( newmis, "progs/flare.spr" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $15
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 37
;37:		setorigin ( newmis, ( self->s.v.origin[0] - 0 ), ( self->s.v.origin[1] - 0 ), ( self->s.v.origin[2] - 30 ) );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
CNSTF4 0
ASGNF4
ADDRLP4 16
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1106247680
SUBF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 38
;38:		newmis->s.v.movetype = 8;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1090519040
ASGNF4
line 39
;39:		newmis->s.v.solid = 1;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 40
;40:		newmis->s.v.effects = 4;
ADDRGP4 newmis
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1082130432
ASGNF4
line 41
;41:		newmis->s.v.effects = ( int ) newmis->s.v.effects + 1;
ADDRLP4 24
ADDRGP4 newmis
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 1
ADDI4
CVIF4 4
ASGNF4
line 42
;42:		sound (newmis, 3, "items/flare1.wav", 1, 1);
ADDRGP4 newmis
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $16
ARGP4
ADDRLP4 28
CNSTF4 1065353216
ASGNF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 43
;43:		newmis->s.v.velocity[2] = -30;
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 3253731328
ASGNF4
line 44
;44:		newmis->s.v.velocity[0] = ( g_random(  ) * 10 );
ADDRLP4 32
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1092616192
ADDRLP4 32
INDIRF4
MULF4
ASGNF4
line 45
;45:		newmis->s.v.velocity[1] = ( g_random(  ) * 10 );
ADDRLP4 36
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1092616192
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
line 46
;46:		newmis->s.v.nextthink = g_globalvars.time + 30;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 47
;47:		newmis->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 48
;48:		newmis->s.v.touch = ( func_t ) SUB_Remove;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 49
;49:		newmis->s.v.classname = "flare";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $18
ASGNP4
line 50
;50:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 52
;51:		//return;
;52:	}
LABELV $13
line 53
;53:	if ( other == world )
ADDRGP4 other
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
NEU4 $19
line 54
;54:	{
line 57
;55:		//self->s.v.movetype = MOVETYPE_NONE;
;56:		//SetVector( self->s.v.velocity, 0, 0, 0 );
;57:		self->s.v.movetype = 6;			// 6 in megatf
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 58
;58:		sound(self, 1, "weapons/bounce.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $12
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
line 59
;59:	}
LABELV $19
line 65
;60:/*	if ( VectorCompareF( self->s.v.velocity, 0, 0, 0 ) )
;61:	{
;62:		SetVector( self->s.v.avelocity, 0, 0, 0 );
;63:		self->s.v.touch = ( func_t ) SUB_Null;
;64:	}*/
;65:}
LABELV $11
endproc FlareGrenadeTouch 40 20
export FlareGrenadeThink
proc FlareGrenadeThink 16 0
line 68
;66:
;67:void FlareGrenadeThink(  )
;68:{
line 72
;69:	float   rnum;
;70:	float   time_left;
;71:
;72:	time_left = self->s.v.health - g_globalvars.time;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
SUBF4
ASGNF4
line 73
;73:	if ( time_left > 33 )
ADDRLP4 0
INDIRF4
CNSTF4 1107558400
LEF4 $23
line 74
;74:	{
line 75
;75:		rnum = g_random(  );
ADDRLP4 8
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 76
;76:		if ( rnum < 0.5 )
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
GEF4 $25
line 77
;77:			self->s.v.effects = 8;
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRGP4 $26
JUMPV
LABELV $25
line 79
;78:		else
;79:			self->s.v.effects = 0;
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 0
ASGNF4
LABELV $26
line 80
;80:		self->s.v.nextthink = g_globalvars.time + 0.05 + g_random(  ) * 0.1;
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1028443341
ADDF4
CNSTF4 1036831949
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 81
;81:	} else
ADDRGP4 $24
JUMPV
LABELV $23
line 82
;82:	{
line 83
;83:		if ( time_left > 31 )
ADDRLP4 0
INDIRF4
CNSTF4 1106771968
LEF4 $28
line 84
;84:		{
line 85
;85:			rnum = g_random(  );
ADDRLP4 8
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 86
;86:			if ( rnum < 0.5 )
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
GEF4 $30
line 87
;87:				self->s.v.effects = 4;
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1082130432
ASGNF4
ADDRGP4 $31
JUMPV
LABELV $30
line 89
;88:			else
;89:				self->s.v.effects = 8;
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1090519040
ASGNF4
LABELV $31
line 90
;90:			self->s.v.nextthink = g_globalvars.time + 0.05 + g_random(  ) * 0.1;
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1028443341
ADDF4
CNSTF4 1036831949
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 91
;91:		} else
ADDRGP4 $29
JUMPV
LABELV $28
line 92
;92:		{
line 93
;93:			if ( time_left > 15 )
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
LEF4 $33
line 94
;94:			{
line 95
;95:				self->s.v.effects = 4;
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1082130432
ASGNF4
line 96
;96:				self->s.v.nextthink = g_globalvars.time + 10;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 97
;97:			} else
ADDRGP4 $34
JUMPV
LABELV $33
line 98
;98:			{
line 99
;99:				if ( time_left < 1 )
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
GEF4 $36
line 100
;100:					RemoveFlare(  );
ADDRGP4 RemoveFlare
CALLV
pop
ADDRGP4 $37
JUMPV
LABELV $36
line 102
;101:				else
;102:				{
line 103
;103:					self->s.v.effects = 8;
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1090519040
ASGNF4
line 104
;104:					self->s.v.nextthink = g_globalvars.time + time_left;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 105
;105:				}
LABELV $37
line 106
;106:			}
LABELV $34
line 107
;107:		}
LABELV $29
line 108
;108:	}
LABELV $24
line 109
;109:}
LABELV $21
endproc FlareGrenadeThink 16 0
export FlareGrenadeExplode
proc FlareGrenadeExplode 4 4
line 120
;110:
;111:
;112:/*============================
;113:void() FlareGrenadeExplode
;114:
;115:It is not really a grenade, nor does it
;116:'explode'. But it fits in well with the
;117:rest of the grenade code.
;118:=============================*/
;119:void FlareGrenadeExplode(  )
;120:{
line 123
;121:
;122:
;123:	if ( self->s.v.weapon )
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 0
EQF4 $40
line 124
;124:	{
line 125
;125:		num_team_flares[( int ) self->s.v.weapon]++;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CVFI4 4
CNSTI4 2
LSHI4
ADDRGP4 num_team_flares
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 126
;126:		if ( num_team_flares[( int ) self->s.v.weapon] > 9 / number_of_teams )
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CVFI4 4
CNSTI4 2
LSHI4
ADDRGP4 num_team_flares
ADDP4
INDIRI4
CNSTI4 9
ADDRGP4 number_of_teams
INDIRI4
DIVI4
LEI4 $41
line 127
;127:			RemoveOldFlare( self->s.v.weapon );
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 RemoveOldFlare
CALLV
pop
line 128
;128:	} else
ADDRGP4 $41
JUMPV
LABELV $40
line 129
;129:	{
line 130
;130:		num_team_flares[0]++;
ADDRLP4 0
ADDRGP4 num_team_flares
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 131
;131:		if ( num_team_flares[0] > 9 )
ADDRGP4 num_team_flares
INDIRI4
CNSTI4 9
LEI4 $44
line 132
;132:			RemoveOldFlare( 0 );
CNSTI4 0
ARGI4
ADDRGP4 RemoveOldFlare
CALLV
pop
LABELV $44
line 133
;133:	}
LABELV $41
line 134
;134:	self->s.v.skin = 1;
ADDRGP4 self
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 1065353216
ASGNF4
line 135
;135:	self->s.v.health = g_globalvars.time + 40;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1109393408
ADDF4
ASGNF4
line 136
;136:	self->s.v.nextthink = g_globalvars.time + 0.05 + g_random(  ) * 0.1;
ADDRLP4 0
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1028443341
ADDF4
CNSTF4 1036831949
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 137
;137:	self->s.v.think = ( func_t ) FlareGrenadeThink;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 FlareGrenadeThink
CVPU4 4
CVUI4 4
ASGNI4
line 138
;138:}
LABELV $39
endproc FlareGrenadeExplode 4 4
export RemoveFlare
proc RemoveFlare 12 4
line 141
;139:
;140:void RemoveFlare(  )
;141:{
line 142
;142:	self->s.v.effects = ( int ) self->s.v.effects - ( ( int ) self->s.v.effects & 4 );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 4
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 143
;143:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 144
;144:	if ( num_team_flares[( int ) self->s.v.weapon] )
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CVFI4 4
CNSTI4 2
LSHI4
ADDRGP4 num_team_flares
ADDP4
INDIRI4
CNSTI4 0
EQI4 $49
line 145
;145:		num_team_flares[( int ) self->s.v.weapon]--;
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CVFI4 4
CNSTI4 2
LSHI4
ADDRGP4 num_team_flares
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $49
line 146
;146:}
LABELV $48
endproc RemoveFlare 12 4
export RemoveOldFlare
proc RemoveOldFlare 20 12
line 150
;147:
;148:
;149:void RemoveOldFlare( int tno )
;150:{
line 154
;151:	gedict_t *old;
;152:	int     index;
;153:
;154:	index = num_team_flares[tno];
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 num_team_flares
ADDP4
INDIRI4
ASGNI4
line 155
;155:	index = index - 9 / number_of_teams;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 9
ADDRGP4 number_of_teams
INDIRI4
DIVI4
SUBI4
ASGNI4
line 157
;156:
;157:	old = trap_find( world, FOFS( mdl ), "flare" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 528
ARGI4
ADDRGP4 $18
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $53
JUMPV
LABELV $52
line 159
;158:	while ( index > 0 )
;159:	{
line 160
;160:		if ( !old )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $55
line 161
;161:		{
line 162
;162:			num_team_flares[0] = 0;
ADDRGP4 num_team_flares
CNSTI4 0
ASGNI4
line 163
;163:			num_team_flares[1] = 0;
ADDRGP4 num_team_flares+4
CNSTI4 0
ASGNI4
line 164
;164:			num_team_flares[2] = 0;
ADDRGP4 num_team_flares+8
CNSTI4 0
ASGNI4
line 165
;165:			num_team_flares[3] = 0;
ADDRGP4 num_team_flares+12
CNSTI4 0
ASGNI4
line 166
;166:			num_team_flares[4] = 0;
ADDRGP4 num_team_flares+16
CNSTI4 0
ASGNI4
line 167
;167:			return;
ADDRGP4 $51
JUMPV
LABELV $55
line 169
;168:		}
;169:		if ( old->s.v.weapon == tno || !tno )
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
ADDRLP4 12
INDIRI4
CVIF4 4
EQF4 $63
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $61
LABELV $63
line 170
;170:		{
line 171
;171:			old->s.v.think = ( func_t ) RemoveFlare;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 RemoveFlare
CVPU4 4
CVUI4 4
ASGNI4
line 172
;172:			old->s.v.nextthink = g_globalvars.time + 0.1;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 173
;173:			index -= 1;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 174
;174:		}
LABELV $61
line 175
;175:		old = trap_find( old, FOFS( mdl ), "flare" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 528
ARGI4
ADDRGP4 $18
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 176
;176:	}
LABELV $53
line 158
ADDRLP4 4
INDIRI4
CNSTI4 0
GTI4 $52
line 177
;177:}
LABELV $51
endproc RemoveOldFlare 20 12
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
LABELV $18
byte 1 102
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $16
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
LABELV $15
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 114
byte 1 101
byte 1 46
byte 1 115
byte 1 112
byte 1 114
byte 1 0
align 1
LABELV $12
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 117
byte 1 110
byte 1 99
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
