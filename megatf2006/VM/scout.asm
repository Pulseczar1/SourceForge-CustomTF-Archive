export CanisterTouch
code
proc CanisterTouch 12 20
file "..\src\scout.c"
line 28
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
;21: *  $Id: scout.c,v 1.25 2006/03/04 13:01:15 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:void    T_RadiusBounce( gedict_t * inflictor, gedict_t * attacker, float bounce, gedict_t * ignore );
;26:
;27:void CanisterTouch(  )
;28:{
line 29
;29:	sound( self, 1, "weapons/tink1.wav", 1, 1 );
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
line 30
;30:	if ( VectorCompareF( self->s.v.velocity, 0, 0, 0 ) )
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 VectorCompareF
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $13
line 31
;31:		SetVector( self->s.v.avelocity, 0, 0, 0 );
ADDRGP4 self
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 0
ASGNF4
LABELV $13
line 32
;32:}
LABELV $11
endproc CanisterTouch 12 20
export CaltropTouch
proc CaltropTouch 32 16
line 35
;33:
;34:void CaltropTouch(  )
;35:{
line 36
;36:	if ( strneq( other->s.v.classname, "player" )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $18
ARGP4
ADDRLP4 0
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $20
ADDRLP4 8
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
ADDRLP4 4
INDIRI4
EQI4 $20
ADDRLP4 8
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
CNSTF4 0
EQF4 $16
LABELV $20
line 38
;37:	     || !( ( int ) other->s.v.flags & FL_ONGROUND ) || other->s.v.deadflag )
;38:		return;
ADDRGP4 $15
JUMPV
LABELV $16
line 39
;39:	if ( ( teamplay & 16 ) && other != PROG_TO_EDICT( self->s.v.owner )
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 teamplay
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 12
INDIRI4
EQI4 $21
ADDRLP4 16
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRP4
CVPU4 4
ADDRLP4 20
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
EQU4 $21
ADDRLP4 16
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
NEI4 $21
ADDRLP4 20
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $21
line 42
;40:	     && other->team_no == PROG_TO_EDICT( self->s.v.owner )->team_no
;41:	     && PROG_TO_EDICT( self->s.v.owner )->team_no )
;42:		return;
ADDRGP4 $15
JUMPV
LABELV $21
line 43
;43:	G_sprint( other, 2, "Ow, Ow, Ow! Caltrops!\n" );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $25
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 44
;44:	other->leg_damage = other->leg_damage + 2;
ADDRLP4 24
ADDRGP4 other
INDIRP4
CNSTI4 1464
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 45
;45:	TeamFortress_SetSpeed( other );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 46
;46:	tf_data.deathmsg = DMSG_CALTROP;
ADDRGP4 tf_data+88
CNSTI4 41
ASGNI4
line 47
;47:	T_Damage( other, self, PROG_TO_EDICT( self->s.v.owner ), 10 );
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTF4 1092616192
ARGF4
ADDRGP4 T_Damage
CALLV
pop
line 48
;48:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 49
;49:}
LABELV $15
endproc CaltropTouch 32 16
export CaltropScatterThink
proc CaltropScatterThink 24 32
line 52
;50:
;51:void CaltropScatterThink(  )
;52:{
line 53
;53:	self->s.v.nextthink = g_globalvars.time + 0.2;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 54
;54:	if ( VectorCompareF( self->s.v.velocity, 0, 0, 0 ) )
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 VectorCompareF
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $29
line 55
;55:	{
line 56
;56:		if ( ( int ) self->s.v.flags & FL_ONGROUND )
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $31
line 57
;57:		{
line 58
;58:			self->s.v.nextthink = g_globalvars.time + 10 + g_random(  ) * 5;
ADDRLP4 8
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1092616192
ADDF4
CNSTF4 1084227584
ADDRLP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
line 59
;59:			self->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 60
;60:			self->s.v.solid = SOLID_TRIGGER;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 61
;61:			self->s.v.movetype = MOVETYPE_TOSS;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 62
;62:			self->s.v.touch = ( func_t ) CaltropTouch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 CaltropTouch
CVPU4 4
CVUI4 4
ASGNI4
line 63
;63:			SetVector( self->s.v.angles, 90, 90, 90 );
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 1119092736
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1119092736
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 1119092736
ASGNF4
line 64
;64:			sound( self, 0, "weapons/tink1.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 0
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
line 65
;65:			setorigin( self, PASSVEC3( self->s.v.origin ) );
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 66
;66:			return;
ADDRGP4 $27
JUMPV
LABELV $31
line 68
;67:		} else
;68:		{
line 69
;69:			self->s.v.nextthink = g_globalvars.time + 10 + g_random(  ) * 5;
ADDRLP4 8
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1092616192
ADDF4
CNSTF4 1084227584
ADDRLP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
line 70
;70:			self->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 71
;71:			self->s.v.solid = SOLID_TRIGGER;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 72
;72:			self->s.v.movetype = MOVETYPE_TOSS;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 73
;73:			self->s.v.touch = ( func_t ) CanisterTouch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 CanisterTouch
CVPU4 4
CVUI4 4
ASGNI4
line 74
;74:			setorigin( self, PASSVEC3( self->s.v.origin ) );
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
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
ADDRGP4 setorigin
CALLV
pop
line 75
;75:			return;
ADDRGP4 $27
JUMPV
LABELV $29
line 78
;76:		}
;77:	}
;78:	traceline( PASSVEC3( self->s.v.movedir ), PASSVEC3( self->s.v.origin ), 1, self );
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 79
;79:	if ( g_globalvars.trace_fraction == 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
NEF4 $35
line 80
;80:	{
line 81
;81:		VectorCopy( self->s.v.origin, self->s.v.movedir );
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 484
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 492
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 82
;82:		return;
ADDRGP4 $27
JUMPV
LABELV $35
line 84
;83:	}
;84:	VectorScale( self->s.v.velocity, -1, self->s.v.velocity );
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTF4 3212836864
ARGF4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 85
;85:	self->heat = self->heat + 1;
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 86
;86:	if ( self->heat > 10 )
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
CNSTF4 1092616192
LEF4 $38
line 87
;87:	{
line 88
;88:		ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 89
;89:		return;
LABELV $38
line 91
;90:	}
;91:}
LABELV $27
endproc CaltropScatterThink 24 32
export ScatterCaltrops
proc ScatterCaltrops 60 16
line 94
;92:
;93:void ScatterCaltrops(  )
;94:{
line 98
;95:	float   num;
;96:	gedict_t *e;
;97:
;98:	for ( num = 6; num > 0; num-- )
ADDRLP4 4
CNSTF4 1086324736
ASGNF4
ADDRGP4 $44
JUMPV
LABELV $41
line 99
;99:	{
line 100
;100:		e = spawn(  );
ADDRLP4 8
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 101
;101:		e->s.v.classname = "grenade";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $45
ASGNP4
line 102
;102:		e->s.v.weapon = 10;
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1092616192
ASGNF4
line 103
;103:		e->s.v.owner = self->s.v.owner;
ADDRLP4 12
CNSTI4 480
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 104
;104:		e->team_no = PROG_TO_EDICT( self->s.v.owner )->team_no;
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
ASGNI4
line 105
;105:		setmodel( e, "progs/caltrop.mdl" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $47
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 106
;106:		SetVector( e->s.v.mins, -4, -4, -8 );
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
CNSTF4 3229614080
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
CNSTF4 3229614080
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 244
ADDP4
CNSTF4 3238002688
ASGNF4
line 107
;107:		SetVector( e->s.v.maxs, 4, 4, 4 );
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
CNSTF4 1082130432
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 252
ADDP4
CNSTF4 1082130432
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
CNSTF4 1082130432
ASGNF4
line 108
;108:		SetVector( e->s.v.angles, 0, 0, 0 );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 0
ASGNF4
line 109
;109:		e->s.v.angles[0] = g_random(  ) * 360;
ADDRLP4 16
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 1135869952
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 110
;110:		e->s.v.velocity[0] = crandom(  ) * 100;
ADDRLP4 20
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1120403456
ADDRLP4 20
INDIRF4
MULF4
ASGNF4
line 111
;111:		e->s.v.velocity[1] = crandom(  ) * 100;
ADDRLP4 24
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1120403456
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
line 112
;112:		e->s.v.velocity[2] = 200 + g_random(  ) * 100;
ADDRLP4 28
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1120403456
ADDRLP4 28
INDIRF4
MULF4
CNSTF4 1128792064
ADDF4
ASGNF4
line 113
;113:		e->s.v.avelocity[0] = crandom(  ) * 400;
ADDRLP4 32
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 1137180672
ADDRLP4 32
INDIRF4
MULF4
ASGNF4
line 114
;114:		e->s.v.avelocity[1] = crandom(  ) * 400;
ADDRLP4 36
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 1137180672
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
line 115
;115:		e->s.v.avelocity[2] = crandom(  ) * 400;
ADDRLP4 40
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 1137180672
ADDRLP4 40
INDIRF4
MULF4
ASGNF4
line 116
;116:		setorigin( e, PASSVEC3( PROG_TO_EDICT( self->s.v.owner )->s.v.origin ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
ADDRGP4 g_edicts+112+44
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRI4
ADDRGP4 g_edicts+112+44+4
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRI4
ADDRGP4 g_edicts+112+44+8
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 117
;117:		VectorCopy( e->s.v.origin, e->s.v.movedir );
ADDRLP4 0
INDIRP4
CNSTI4 484
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 118
;118:		e->heat = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1076
ADDP4
CNSTF4 0
ASGNF4
line 119
;119:		e->s.v.movetype = MOVETYPE_BOUNCE;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1092616192
ASGNF4
line 120
;120:		e->s.v.solid = SOLID_NOT;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 121
;121:		e->s.v.nextthink = g_globalvars.time + 0.2;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 122
;122:		e->s.v.think = ( func_t ) CaltropScatterThink;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 CaltropScatterThink
CVPU4 4
CVUI4 4
ASGNI4
line 123
;123:	}
LABELV $42
line 98
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
LABELV $44
ADDRLP4 4
INDIRF4
CNSTF4 0
GTF4 $41
line 124
;124:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 125
;125:}
LABELV $40
endproc ScatterCaltrops 60 16
export FlashGrenadeTouch
proc FlashGrenadeTouch 12 20
line 128
;126:
;127:void FlashGrenadeTouch(  )
;128:{
line 129
;129:	sound( self, 1, "weapons/bounce.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $58
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
line 130
;130:	if ( VectorCompareF( self->s.v.velocity, 0, 0, 0 ) )
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 VectorCompareF
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $59
line 131
;131:		SetVector( self->s.v.avelocity, 0, 0, 0 );
ADDRGP4 self
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 0
ASGNF4
LABELV $59
line 132
;132:}
LABELV $57
endproc FlashGrenadeTouch 12 20
export FlashTimer
proc FlashTimer 16 24
line 136
;133:
;134:// flash nade timer (it's not really different from mine flash, but for code consistency..)
;135:void FlashTimer(  )
;136:{
line 139
;137:	gedict_t *te;
;138:
;139:	te = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 140
;140:	te->FlashTime = te->FlashTime - 0.1;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 1472
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1036831949
SUBF4
ASGNF4
line 142
;141:
;142:	if ( te->FlashTime < 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 1472
ADDP4
INDIRF4
CNSTF4 0
GEF4 $62
line 143
;143:		te->FlashTime = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1472
ADDP4
CNSTF4 0
ASGNF4
line 144
;144:		stuffcmd( te, "v_cshift; wait; bf\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $64
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 145
;145:		ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 146
;146:		return;
ADDRGP4 $61
JUMPV
LABELV $62
line 149
;147:	}
;148:
;149:	if ( te->FlashTime < 1.7 ) {
ADDRLP4 0
INDIRP4
CNSTI4 1472
ADDP4
INDIRF4
CNSTF4 1071225242
GEF4 $65
line 150
;150:		stuffcmd( te, "v_cshift %.0f %.0f %.0f %.0f\n", te->FlashTime * 150,
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $67
ARGP4
ADDRLP4 12
CNSTF4 1125515264
ADDRLP4 0
INDIRP4
CNSTI4 1472
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 stuffcmd
CALLV
pop
line 152
;151:		  te->FlashTime * 150, te->FlashTime * 150, te->FlashTime * 150 );
;152:	}
LABELV $65
line 153
;153:	if ( te->FlashTime > 1.7 )
ADDRLP4 0
INDIRP4
CNSTI4 1472
ADDP4
INDIRF4
CNSTF4 1071225242
LEF4 $68
line 154
;154:		stuffcmd ( te, "v_cshift 255 255 255 255\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $70
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
LABELV $68
line 156
;155:
;156:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 157
;157:}
LABELV $61
endproc FlashTimer 16 24
export FlashTimerNew
proc FlashTimerNew 16 24
line 160
;158:
;159:void FlashTimerNew(  )
;160:{
line 163
;161:	gedict_t *te;
;162:
;163:	te = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 164
;164:	te->FlashTime = te->FlashTime - 0.1;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 1472
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1036831949
SUBF4
ASGNF4
line 166
;165:
;166:	if ( te->FlashTime < 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 1472
ADDP4
INDIRF4
CNSTF4 0
GEF4 $73
line 167
;167:		te->FlashTime = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1472
ADDP4
CNSTF4 0
ASGNF4
line 168
;168:		stuffcmd( te, "v_cshift; wait; bf\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $64
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 169
;169:		ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 170
;170:		return;
ADDRGP4 $72
JUMPV
LABELV $73
line 173
;171:	}
;172:
;173:	if ( te->FlashTime < 1.7 ) {
ADDRLP4 0
INDIRP4
CNSTI4 1472
ADDP4
INDIRF4
CNSTF4 1071225242
GEF4 $75
line 174
;174:		stuffcmd( te, "v_cshift %.0f %.0f %.0f %.0f\n", te->FlashTime * 150,
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $67
ARGP4
ADDRLP4 12
CNSTF4 1125515264
ADDRLP4 0
INDIRP4
CNSTI4 1472
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 stuffcmd
CALLV
pop
line 176
;175:		  te->FlashTime * 150, te->FlashTime * 150, te->FlashTime * 150 );
;176:	}
LABELV $75
line 177
;177:	if ( te->FlashTime > 1.7 )
ADDRLP4 0
INDIRP4
CNSTI4 1472
ADDP4
INDIRF4
CNSTF4 1071225242
LEF4 $77
line 178
;178:		stuffcmd ( te, "v_cshift 255 255 255 255\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $70
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
LABELV $77
line 180
;179:
;180:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 198
;181:	/*
;182:	gedict_t *te;
;183:
;184:	te = PROG_TO_EDICT( self->s.v.owner );
;185:	te->FlashTime = te->FlashTime - 0.6;
;186:	if ( te->FlashTime < 5 || ( self->gren_eff_time <= g_globalvars.time && tg_data.gren_time ) )
;187:	{
;188:		te->FlashTime = 0;
;189:		stuffcmd( te, "v_cshift; wait; bf\n" );
;190:		ent_remove( self );
;191:		return;
;192:	}
;193:	stuffcmd( te, "v_cshift %.0f %.0f %.0f %.0f\n", te->FlashTime * 10,
;194:		  te->FlashTime * 10, te->FlashTime * 10, te->FlashTime * 10 );
;195:
;196:	self->s.v.nextthink = g_globalvars.time + 0.6;
;197:	*/
;198:}
LABELV $72
endproc FlashTimerNew 16 24
export FlashPlayer
proc FlashPlayer 8 12
line 201
;199:
;200:void FlashPlayer( gedict_t*p, gedict_t*attacker )
;201:{
line 204
;202:        gedict_t* te;
;203:        
;204:        if ( !p->FlashTime )
ADDRFP4 0
INDIRP4
CNSTI4 1472
ADDP4
INDIRF4
CNSTF4 0
NEF4 $81
line 205
;205:        {
line 206
;206:       		te = spawn(  );
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 207
;207:       		te->s.v.classname = "timer";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $83
ASGNP4
line 208
;208:       		te->s.v.netname = "flashtimer";
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $84
ASGNP4
line 209
;209:       		te->s.v.owner = EDICT_TO_PROG( p );
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 210
;210:        }else
ADDRGP4 $82
JUMPV
LABELV $81
line 211
;211:        {
line 212
;212:       		for ( te = world; ( te = trap_find( te, FOFS( s.v.netname ), "flashtimer" ) ); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $88
JUMPV
LABELV $85
line 213
;213:       		{
line 214
;214:       			if ( te->s.v.owner != EDICT_TO_PROG( p ) )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
EQI4 $87
line 215
;215:       				continue;
line 217
;216:
;217:       			break;
LABELV $86
line 212
LABELV $88
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 396
ARGI4
ADDRGP4 $84
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
NEU4 $85
LABELV $87
line 219
;218:       		}
;219:       		if ( !te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $91
line 220
;220:       		{
line 221
;221:       			G_conprintf( "Warning: Error in Flash Timer logic.\n" );
ADDRGP4 $93
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
line 222
;222:       			return;
ADDRGP4 $80
JUMPV
LABELV $91
line 224
;223:       		}
;224:        }
LABELV $82
line 225
;225:        G_sprint( p, 2, "You are flashed\n" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $94
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 227
;226:       	
;227:       	te->team_no = (attacker)?attacker->team_no:p->team_no;
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $96
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $97
JUMPV
LABELV $96
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
LABELV $97
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 228
;228:       	if ( attacker && tg_data.gren_time )
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $98
ADDRGP4 tg_data+36
INDIRI4
CNSTI4 0
EQI4 $98
line 229
;229:       		te->gren_eff_time = g_globalvars.time + tg_data.gren_time;
ADDRLP4 0
INDIRP4
CNSTI4 1596
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 tg_data+36
INDIRI4
CVIF4 4
ADDF4
ASGNF4
LABELV $98
line 232
;230:
;231:       	
;232:       	if ( tf_data.new_flash )
ADDRGP4 tf_data+48
INDIRI4
CNSTI4 0
EQI4 $103
line 233
;233:       	{
line 234
;234:       	        te->s.v.think = ( func_t ) FlashTimerNew;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 FlashTimerNew
CVPU4 4
CVUI4 4
ASGNI4
line 235
;235:       	        te->s.v.nextthink = g_globalvars.time + /*NEW_FLASH_START_TIME*/ 1;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 236
;236:       	        if( p == attacker )
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $107
line 237
;237:       	        {
line 238
;238:       	                p->FlashTime = 2.5;
ADDRFP4 0
INDIRP4
CNSTI4 1472
ADDP4
CNSTF4 1075838976
ASGNF4
line 241
;239://       	                stuffcmd( p, "v_cshift 160 160 160 160\n" );
;240://       	                disableupdates( p, -1 );	/* server-side flash */
;241:						stuffcmd( p, "v_cshift 255 255 255 255\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $70
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 242
;242:						disableupdates( p, NEW_FLASH_START_TIME );	/* server-side flash */
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1070386381
ARGF4
ADDRGP4 disableupdates
CALLV
pop
line 243
;243:       	        }else
ADDRGP4 $104
JUMPV
LABELV $107
line 244
;244:       	        {
line 245
;245:       	                p->FlashTime = 2.5;
ADDRFP4 0
INDIRP4
CNSTI4 1472
ADDP4
CNSTF4 1075838976
ASGNF4
line 246
;246:						stuffcmd( p, "v_cshift 255 255 255 255\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $70
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 247
;247:						disableupdates( p, NEW_FLASH_START_TIME );	/* server-side flash */
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1070386381
ARGF4
ADDRGP4 disableupdates
CALLV
pop
line 248
;248:       	        }
line 249
;249:       	}else
ADDRGP4 $104
JUMPV
LABELV $103
line 250
;250:       	{
line 251
;251:       	        te->s.v.think = ( func_t ) FlashTimer;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 FlashTimer
CVPU4 4
CVUI4 4
ASGNI4
line 252
;252:       	        te->s.v.nextthink = g_globalvars.time + 1;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 253
;253:       	        if( p == attacker )
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $110
line 254
;254:       	        {
line 255
;255:       	                p->FlashTime = 2.5;
ADDRFP4 0
INDIRP4
CNSTI4 1472
ADDP4
CNSTF4 1075838976
ASGNF4
line 256
;256:       	                stuffcmd( p, "v_cshift 160 160 160 160\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $112
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 257
;257:       	        }else
ADDRGP4 $111
JUMPV
LABELV $110
line 258
;258:       	        {
line 259
;259:       	                p->FlashTime = 2.5;
ADDRFP4 0
INDIRP4
CNSTI4 1472
ADDP4
CNSTF4 1075838976
ASGNF4
line 260
;260:       	                stuffcmd( p, "v_cshift 240 240 240 240\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $113
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 261
;261:       	        }
LABELV $111
line 262
;262:       	}
LABELV $104
line 263
;263:}
LABELV $80
endproc FlashPlayer 8 12
export FlashGrenadeExplode
proc FlashGrenadeExplode 68 32
line 266
;264:
;265:void FlashGrenadeExplode(  )
;266:{
line 271
;267:	gedict_t *te;
;268:	gedict_t *owner;
;269:	vec3_t  tmp;
;270:
;271:	owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 272
;272:	self->s.v.effects = ( int ) self->s.v.effects | 4;
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 4
BORI4
CVIF4 4
ASGNF4
line 273
;273:	trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 274
;274:	trap_WriteByte( MSG_MULTICAST, TE_TAREXPLOSION );
ADDRLP4 24
CNSTI4 4
ASGNI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 275
;275:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
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
line 276
;276:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
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
line 277
;277:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] );
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
line 278
;278:	trap_multicast( PASSVEC3( self->s.v.origin ), 1 );
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
line 279
;279:	for ( te = world; ( te = findradius( te, self->s.v.origin, 300 ) ); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $118
JUMPV
LABELV $115
line 280
;280:	{
line 281
;281:		if ( strneq( te->s.v.classname, "player" ) )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $18
ARGP4
ADDRLP4 32
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $119
line 282
;282:			continue;
ADDRGP4 $116
JUMPV
LABELV $119
line 285
;283:
;284:
;285:		traceline( PASSVEC3( self->s.v.origin ), PASSVEC3( te->s.v.origin ), 1, self );
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 40
CNSTI4 156
ASGNI4
ADDRLP4 36
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
CNSTI4 160
ASGNI4
ADDRLP4 36
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 48
CNSTI4 164
ASGNI4
ADDRLP4 36
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 286
;286:		if ( g_globalvars.trace_fraction != 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $121
line 287
;287:			continue;
ADDRGP4 $116
JUMPV
LABELV $121
line 289
;288:
;289:		VectorSubtract( self->s.v.origin, te->s.v.origin, tmp );
ADDRLP4 56
CNSTI4 156
ASGNI4
ADDRLP4 4
ADDRGP4 self
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 60
CNSTI4 160
ASGNI4
ADDRLP4 4+4
ADDRGP4 self
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64
CNSTI4 164
ASGNI4
ADDRLP4 4+8
ADDRGP4 self
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 290
;290:		if ( vlen( tmp ) <= 200 )
ADDRLP4 4
ARGP4
ADDRLP4 56
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 56
INDIRF4
CNSTF4 1128792064
GTF4 $126
line 291
;291:		{
line 292
;292:			tf_data.deathmsg = DMSG_GREN_FLASH;
ADDRGP4 tf_data+88
CNSTI4 35
ASGNI4
line 293
;293:			if ( !( te == owner && tf_data.self_flash == TRUE ) )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRP4
CVPU4 4
NEU4 $132
ADDRGP4 tf_data+52
INDIRI4
CNSTI4 1
EQI4 $129
LABELV $132
line 294
;294:			TF_T_Damage( te, self, owner, 60, 2, 16 | 4 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTF4 1114636288
ARGF4
CNSTI4 2
ARGI4
CNSTI4 20
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
LABELV $129
line 295
;295:		}
LABELV $126
line 296
;296:		if ( te->s.v.health <= 0 )
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $133
line 297
;297:			continue;
ADDRGP4 $116
JUMPV
LABELV $133
line 299
;298:
;299:		if ( tg_data.gren_effect == TG_GREN_EFFECT_OFF )
ADDRGP4 tg_data+32
INDIRI4
CNSTI4 1
NEI4 $135
line 300
;300:			continue;
ADDRGP4 $116
JUMPV
LABELV $135
line 302
;301:
;302:		if ( te == owner && tg_data.gren_effect == TG_GREN_EFFECT_OFF_FORSELF )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRP4
CVPU4 4
NEU4 $138
ADDRGP4 tg_data+32
INDIRI4
CNSTI4 2
NEI4 $138
line 303
;303:			continue;
ADDRGP4 $116
JUMPV
LABELV $138
line 305
;304:
;305:		if ( te == owner && tf_data.self_flash == TRUE )	// can flash self?
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRP4
CVPU4 4
NEU4 $141
ADDRGP4 tf_data+52
INDIRI4
CNSTI4 1
NEI4 $141
line 306
;306:			continue;
ADDRGP4 $116
JUMPV
LABELV $141
line 308
;307:
;308:		FlashPlayer( te, owner );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 FlashPlayer
CALLV
pop
line 310
;309:
;310:	}
LABELV $116
line 279
LABELV $118
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ARGP4
CNSTF4 1133903872
ARGF4
ADDRLP4 32
ADDRGP4 findradius
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $115
line 311
;311:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 312
;312:}
LABELV $114
endproc FlashGrenadeExplode 68 32
export ConcussionGrenadeTouch
proc ConcussionGrenadeTouch 12 20
line 315
;313:
;314:void ConcussionGrenadeTouch(  )
;315:{
line 316
;316:	sound( self, 1, "weapons/bounce.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $58
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
line 317
;317:	if ( VectorCompareF( self->s.v.velocity, 0, 0, 0 ) )
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 VectorCompareF
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $145
line 318
;318:		SetVector( self->s.v.avelocity, 0, 0, 0 );
ADDRGP4 self
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 0
ASGNF4
LABELV $145
line 319
;319:}
LABELV $144
endproc ConcussionGrenadeTouch 12 20
export ConcussionGrenadeExplode
proc ConcussionGrenadeExplode 8 16
line 322
;320:
;321:void ConcussionGrenadeExplode(  )
;322:{
line 323
;323:	T_RadiusBounce( self, PROG_TO_EDICT( self->s.v.owner ), 240, world );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTF4 1131413504
ARGF4
ADDRGP4 world
INDIRP4
ARGP4
ADDRGP4 T_RadiusBounce
CALLV
pop
line 324
;324:	trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 325
;325:	trap_WriteByte( MSG_MULTICAST, TE_EXPLOSION );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 326
;326:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
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
line 327
;327:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
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
line 328
;328:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] );
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
line 329
;329:	trap_multicast( PASSVEC3( self->s.v.origin ), 1 );
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
CNSTI4 1
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 330
;330:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 331
;331:}
LABELV $147
endproc ConcussionGrenadeExplode 8 16
export OldConcussionGrenadeTimer
proc OldConcussionGrenadeTimer 28 28
line 334
;332:
;333:void OldConcussionGrenadeTimer(  )
;334:{
line 335
;335:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 337
;336:
;337:	if ( owner->invincible_finished > g_globalvars.time )
ADDRLP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $149
line 338
;338:	{
line 341
;339:
;340://		stuffcmd( owner, "v_idlescale 0; wait; fov 90\n" );
;341:		stuffcmd( owner, "v_idlescale 0\n" );	// fov shouldnt be touched
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 342
;342:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 343
;343:		return;
ADDRGP4 $148
JUMPV
LABELV $149
line 345
;344:	}
;345:	if ( tg_data.gren_time && self->gren_eff_time <= g_globalvars.time )
ADDRGP4 tg_data+36
INDIRI4
CNSTI4 0
EQI4 $153
ADDRGP4 self
INDIRP4
CNSTI4 1596
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GTF4 $153
line 346
;346:		self->s.v.health = 0;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 0
ASGNF4
LABELV $153
line 348
;347:
;348:	newmis = spawn(  );
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 4
INDIRP4
ASGNP4
line 349
;349:	g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 350
;350:	setmodel( newmis, "progs/s_bubble.spr" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $158
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 351
;351:	setorigin( newmis, PASSVEC3( owner->s.v.origin ) );
ADDRGP4 newmis
INDIRP4
ARGP4
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
ADDRGP4 setorigin
CALLV
pop
line 352
;352:	newmis->s.v.movetype = MOVETYPE_NOCLIP;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1090519040
ASGNF4
line 353
;353:	newmis->s.v.solid = SOLID_NOT;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 354
;354:	SetVector( newmis->s.v.velocity, 0, 0, 15 );
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1097859072
ASGNF4
line 355
;355:	newmis->s.v.nextthink = g_globalvars.time + 0.5;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 356
;356:	newmis->s.v.think = ( func_t ) bubble_bob;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 bubble_bob
CVPU4 4
CVUI4 4
ASGNI4
line 357
;357:	newmis->s.v.touch = ( func_t ) bubble_remove;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 bubble_remove
CVPU4 4
CVUI4 4
ASGNI4
line 358
;358:	newmis->s.v.classname = "bubble";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $160
ASGNP4
line 359
;359:	newmis->s.v.frame = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 0
ASGNF4
line 360
;360:	newmis->cnt = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 692
ADDP4
CNSTF4 0
ASGNF4
line 361
;361:	setsize( newmis, -8, -8, -8, 8, 8, 8 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 12
CNSTF4 3238002688
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 16
CNSTF4 1090519040
ASGNF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 362
;362:	self->s.v.health = self->s.v.health - 20;
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
line 363
;363:	if ( owner->playerclass == PC_MEDIC )
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 5
NEI4 $161
line 364
;364:		self->s.v.health = self->s.v.health - 20;
ADDRLP4 24
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
LABELV $161
line 365
;365:	if ( self->s.v.health < 0 )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GEF4 $163
line 366
;366:		self->s.v.health = 0;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 0
ASGNF4
LABELV $163
line 367
;367:	self->s.v.nextthink = g_globalvars.time + 5;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 368
;368:	stuffcmd( owner, "v_iroll_cycle 0.5\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $166
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 369
;369:	stuffcmd( owner, "v_ipitch_cycle 1\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $167
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 370
;370:	stuffcmd( owner, "v_iyaw_cycle 2\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $168
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 371
;371:	stuffcmd( owner, "v_ipitch_level 0.3\n" );		// mtf'd
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $169
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 372
;372:	stuffcmd( owner, "v_iyaw_level 0.3\n" );		// mtf'd
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $170
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 373
;373:	stuffcmd( owner, "v_idlescale %.0f\n", self->s.v.health );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $171
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ARGF4
ADDRGP4 stuffcmd
CALLV
pop
line 375
;374://	stuffcmd( owner, "fov %.0f\n", 90 + self->s.v.health / 2 );		//ow, my browser!
;375:	if ( !self->s.v.health )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
NEF4 $172
line 376
;376:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
LABELV $172
line 377
;377:}
LABELV $148
endproc OldConcussionGrenadeTimer 28 28
export ConcussionGrenadeTimer
proc ConcussionGrenadeTimer 116 28
line 380
;378:
;379:void ConcussionGrenadeTimer(  )
;380:{
line 384
;381:	vec3_t  stumble;
;382:	vec3_t  src;
;383:	float   pos;
;384:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 386
;385:
;386:	if ( owner->invincible_finished > g_globalvars.time )
ADDRLP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $175
line 387
;387:	{
line 388
;388:		G_sprint( owner, 2, "Your head feels better now.\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $178
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 389
;389:		owner->s.v.fixangle = 0;
ADDRLP4 0
INDIRP4
CNSTI4 380
ADDP4
CNSTF4 0
ASGNF4
line 390
;390:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 391
;391:		return;
ADDRGP4 $174
JUMPV
LABELV $175
line 393
;392:	}
;393:	if ( tg_data.gren_time && self->gren_eff_time <= g_globalvars.time )
ADDRGP4 tg_data+36
INDIRI4
CNSTI4 0
EQI4 $179
ADDRGP4 self
INDIRP4
CNSTI4 1596
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GTF4 $179
line 394
;394:		self->s.v.health = 0;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 0
ASGNF4
LABELV $179
line 395
;395:	if ( self->s.v.health == 200 || self->s.v.health == 400 || self->s.v.health == 600
ADDRLP4 32
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 1128792064
EQF4 $188
ADDRLP4 32
INDIRF4
CNSTF4 1137180672
EQF4 $188
ADDRLP4 32
INDIRF4
CNSTF4 1142292480
EQF4 $188
ADDRLP4 32
INDIRF4
CNSTF4 1145569280
EQF4 $188
ADDRLP4 32
INDIRF4
CNSTF4 1148846080
NEF4 $183
LABELV $188
line 397
;396:	     || self->s.v.health == 800 || self->s.v.health == 1000 )
;397:	{
line 398
;398:		newmis = spawn(  );
ADDRLP4 36
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 36
INDIRP4
ASGNP4
line 399
;399:		g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 400
;400:		setmodel( newmis, "progs/s_bubble.spr" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $158
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 401
;401:		setorigin( newmis, PASSVEC3( owner->s.v.origin ) );
ADDRGP4 newmis
INDIRP4
ARGP4
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
ADDRGP4 setorigin
CALLV
pop
line 402
;402:		newmis->s.v.movetype = MOVETYPE_NOCLIP;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1090519040
ASGNF4
line 403
;403:		newmis->s.v.solid = SOLID_NOT;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 404
;404:		SetVector( newmis->s.v.velocity, 0, 0, 15 );
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1097859072
ASGNF4
line 405
;405:		newmis->s.v.nextthink = g_globalvars.time + 0.5;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 406
;406:		newmis->s.v.think = ( func_t ) bubble_bob;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 bubble_bob
CVPU4 4
CVUI4 4
ASGNI4
line 407
;407:		newmis->s.v.touch = ( func_t ) bubble_remove;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 bubble_remove
CVPU4 4
CVUI4 4
ASGNI4
line 408
;408:		newmis->s.v.classname = "bubble";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $160
ASGNP4
line 409
;409:		newmis->s.v.frame = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 0
ASGNF4
line 410
;410:		newmis->cnt = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 692
ADDP4
CNSTF4 0
ASGNF4
line 411
;411:		setsize( newmis, -8, -8, -8, 8, 8, 8 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 44
CNSTF4 3238002688
ASGNF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 48
CNSTF4 1090519040
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 412
;412:	}
LABELV $183
line 413
;413:	self->s.v.health = self->s.v.health - 10;
ADDRLP4 36
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
CNSTF4 1092616192
SUBF4
ASGNF4
line 414
;414:	if ( owner->playerclass == PC_MEDIC )
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 5
NEI4 $191
line 415
;415:		self->s.v.health = self->s.v.health - 10;
ADDRLP4 40
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
CNSTF4 1092616192
SUBF4
ASGNF4
LABELV $191
line 416
;416:	if ( self->s.v.health < 0 )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GEF4 $193
line 417
;417:		self->s.v.health = 0;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 0
ASGNF4
LABELV $193
line 418
;418:	self->s.v.nextthink = g_globalvars.time + 0.25;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1048576000
ADDF4
ASGNF4
line 419
;419:	pos = trap_pointcontents( PASSVEC3( owner->s.v.origin ) );
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
ADDRLP4 48
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 48
INDIRI4
CVIF4 4
ASGNF4
line 420
;420:	src[0] = owner->s.v.origin[0] + owner->s.v.maxs[0] + 2;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 421
;421:	src[1] = owner->s.v.origin[1] + owner->s.v.maxs[1] + 2;
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 422
;422:	src[2] = owner->s.v.origin[2];
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 423
;423:	pos = trap_pointcontents( PASSVEC3( src ) );
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4+4
INDIRF4
ARGF4
ADDRLP4 4+8
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 60
INDIRI4
CVIF4 4
ASGNF4
line 424
;424:	if ( ( ( int ) owner->s.v.flags & FL_ONGROUND ) || ( ( int ) owner->s.v.flags & 16 ) )
ADDRLP4 64
ADDRLP4 0
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 512
BANDI4
ADDRLP4 68
INDIRI4
NEI4 $202
ADDRLP4 64
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 68
INDIRI4
EQI4 $200
LABELV $202
line 425
;425:	{
line 426
;426:		if ( !owner->is_feigning )
ADDRLP4 0
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
NEI4 $203
line 427
;427:		{
line 428
;428:			makevectors( owner->s.v.v_angle );
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 429
;429:			stumble[0] =
ADDRLP4 72
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 76
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 72
INDIRF4
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
MULF4
ADDRLP4 76
INDIRF4
ADDRGP4 g_globalvars+252
INDIRF4
MULF4
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 432
;430:			    crandom(  ) * g_globalvars.v_forward[0] * self->s.v.health +
;431:			    crandom(  ) * g_globalvars.v_right[0] * self->s.v.health;
;432:			stumble[1] =
ADDRLP4 80
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 84
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 20+4
ADDRLP4 80
INDIRF4
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
MULF4
ADDRLP4 84
INDIRF4
ADDRGP4 g_globalvars+252+4
INDIRF4
MULF4
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 435
;433:			    crandom(  ) * g_globalvars.v_forward[1] * self->s.v.health +
;434:			    crandom(  ) * g_globalvars.v_right[1] * self->s.v.health;
;435:			stumble[2] =
ADDRLP4 88
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 92
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 20+8
ADDRLP4 88
INDIRF4
ADDRGP4 g_globalvars+228+8
INDIRF4
MULF4
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
MULF4
ADDRLP4 92
INDIRF4
ADDRGP4 g_globalvars+252+8
INDIRF4
MULF4
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 438
;436:			    crandom(  ) * g_globalvars.v_forward[2] * self->s.v.health +
;437:			    crandom(  ) * g_globalvars.v_right[2] * self->s.v.health;
;438:			if ( !( pos == -2 && VectorCompareF( owner->s.v.velocity, 0, 0, 0 ) ) )
ADDRLP4 16
INDIRF4
CNSTF4 3221225472
NEF4 $219
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 96
CNSTF4 0
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
ADDRLP4 100
ADDRGP4 VectorCompareF
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $217
LABELV $219
line 439
;439:			{
line 440
;440:				VectorAdd( owner->s.v.velocity, stumble, owner->s.v.velocity );
ADDRLP4 104
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRF4
ADDRLP4 20
INDIRF4
ADDF4
ASGNF4
ADDRLP4 108
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRF4
ADDRLP4 20+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 112
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRF4
ADDRLP4 20+8
INDIRF4
ADDF4
ASGNF4
line 441
;441:				owner->s.v.fixangle = 1;
ADDRLP4 0
INDIRP4
CNSTI4 380
ADDP4
CNSTF4 1065353216
ASGNF4
line 442
;442:			}
LABELV $217
line 443
;443:		}
LABELV $203
line 444
;444:	}
LABELV $200
line 445
;445:	if ( !self->s.v.health )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
NEF4 $222
line 446
;446:	{
line 447
;447:		G_sprint( owner, 2, "Your head feels better now.\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $178
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 448
;448:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 449
;449:	}
LABELV $222
line 450
;450:}
LABELV $174
endproc ConcussionGrenadeTimer 116 28
export TeamFortress_AutoScan
proc TeamFortress_AutoScan 4 8
line 453
;451:
;452:void TeamFortress_AutoScan(  )
;453:{
line 456
;454:	gedict_t *oldself;
;455:
;456:	oldself = self;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
line 457
;457:	self = PROG_TO_EDICT( oldself->s.v.owner );
ADDRGP4 self
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 458
;458:	TeamFortress_Scan_Angel( self->ScanRange, 1 );
ADDRGP4 self
INDIRP4
CNSTI4 1500
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 TeamFortress_Scan_Angel
CALLV
pop
line 459
;459:	self = oldself;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 460
;460:	self->s.v.nextthink = g_globalvars.time + TF_AUTOSCAN_TIME;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 461
;461:}
LABELV $224
endproc TeamFortress_AutoScan 4 8
export ScannerSwitch
proc ScannerSwitch 8 12
line 464
;462:
;463:void ScannerSwitch(  )
;464:{
line 467
;465:	gedict_t *te;
;466:
;467:	if ( self->ScannerOn != 1 )
ADDRGP4 self
INDIRP4
CNSTI4 1496
ADDP4
INDIRI4
CNSTI4 1
EQI4 $227
line 468
;468:	{
line 469
;469:		te = spawn(  );
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 470
;470:		te->s.v.nextthink = g_globalvars.time + TF_AUTOSCAN_TIME;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 471
;471:		te->s.v.think = ( func_t ) TeamFortress_AutoScan;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 TeamFortress_AutoScan
CVPU4 4
CVUI4 4
ASGNI4
line 472
;472:		te->s.v.owner = EDICT_TO_PROG( self );
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
line 473
;473:		te->s.v.classname = "timer";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $83
ASGNP4
line 474
;474:		te->s.v.netname = "scanner";
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $230
ASGNP4
line 475
;475:		G_sprint( self, PRINT_HIGH, "Scanner On.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $231
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 476
;476:		self->ScannerOn = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1496
ADDP4
CNSTI4 1
ASGNI4
line 477
;477:	} else
ADDRGP4 $228
JUMPV
LABELV $227
line 478
;478:	{
line 479
;479:		for ( te = world; ( te = trap_find( te, FOFS( s.v.netname ), "scanner" ) ); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $235
JUMPV
LABELV $232
line 480
;480:		{
line 481
;481:			if ( te->s.v.owner == EDICT_TO_PROG( self ) )
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
NEI4 $236
line 482
;482:			{
line 483
;483:				dremove( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 484
;484:				break;
ADDRGP4 $234
JUMPV
LABELV $236
line 486
;485:			}
;486:		}
LABELV $233
line 479
LABELV $235
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 396
ARGI4
ADDRGP4 $230
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
NEU4 $232
LABELV $234
line 487
;487:		G_sprint( self, PRINT_HIGH, "Scanner Off.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $238
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 488
;488:		self->ScannerOn = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1496
ADDP4
CNSTI4 0
ASGNI4
line 489
;489:	}
LABELV $228
line 490
;490:	self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 491
;491:}
LABELV $226
endproc ScannerSwitch 8 12
export ConcPlayer
proc ConcPlayer 16 12
line 494
;492:
;493:void ConcPlayer( gedict_t*p, gedict_t*attacker )
;494:{
line 500
;495:        gedict_t* te;
;496:       	// Concuss 'em!!
;497:       	// If they are already concussed, set the concussion back up
;498:       	// Try to find a concusstimer entity for this player
;499:
;500:       	G_sprint( p, 2, "You are conced\n" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $241
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 501
;501:       	for ( te = world; ( te = trap_find( te, FOFS( s.v.classname ), "timer" ) ); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $245
JUMPV
LABELV $242
line 502
;502:       	{
line 503
;503:       		if ( te->s.v.owner != EDICT_TO_PROG( p ) )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
EQI4 $246
line 504
;504:       			continue;
ADDRGP4 $243
JUMPV
LABELV $246
line 505
;505:       		if ( te->s.v.think == ( func_t ) ConcussionGrenadeTimer )
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ADDRGP4 ConcussionGrenadeTimer
CVPU4 4
CVUI4 4
NEI4 $248
line 506
;506:       			break;
ADDRGP4 $244
JUMPV
LABELV $248
line 507
;507:       		if ( te->s.v.think == ( func_t ) OldConcussionGrenadeTimer )
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ADDRGP4 OldConcussionGrenadeTimer
CVPU4 4
CVUI4 4
NEI4 $250
line 508
;508:       			break;
ADDRGP4 $244
JUMPV
LABELV $250
line 509
;509:       	}
LABELV $243
line 501
LABELV $245
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $83
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
NEU4 $242
LABELV $244
line 510
;510:       	if( !te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $252
line 511
;511:       	{
line 512
;512:       	        te = spawn(  );
ADDRLP4 8
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 513
;513:       	        te->s.v.classname = "timer";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $83
ASGNP4
line 514
;514:       	        te->s.v.owner = EDICT_TO_PROG( p );
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 515
;515:       	        te->team_no = (attacker)?attacker->team_no:p->team_no;
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $255
ADDRLP4 12
ADDRFP4 4
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $256
JUMPV
LABELV $255
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
LABELV $256
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 516
;516:       	        if ( tf_data.old_grens == 1 )
ADDRGP4 tf_data+44
INDIRI4
CNSTI4 1
NEI4 $257
line 517
;517:               	        stuffcmd( p, "bf\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $260
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
LABELV $257
line 518
;518:       	}
LABELV $252
line 519
;519:       	if ( tf_data.old_grens == 1 )
ADDRGP4 tf_data+44
INDIRI4
CNSTI4 1
NEI4 $261
line 520
;520:       	{
line 521
;521:     		stuffcmd( p, "v_idlescale 100\n" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $264
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 523
;522:     		//stuffcmd( p, "fov 130\n" );	// cuz i dont like it :x -xav
;523:     		te->s.v.think = ( func_t ) OldConcussionGrenadeTimer;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 OldConcussionGrenadeTimer
CVPU4 4
CVUI4 4
ASGNI4
line 524
;524:     		te->s.v.health = 100;
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1120403456
ASGNF4
line 525
;525:     		te->s.v.nextthink = g_globalvars.time + 5;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 526
;526:     	} else
ADDRGP4 $262
JUMPV
LABELV $261
line 527
;527:     	{
line 528
;528:     	        te->s.v.think = ( func_t ) ConcussionGrenadeTimer;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 ConcussionGrenadeTimer
CVPU4 4
CVUI4 4
ASGNI4
line 529
;529:     		te->s.v.health = 800;
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1145569280
ASGNF4
line 530
;530:     		te->s.v.nextthink = g_globalvars.time + 0.25;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1048576000
ADDF4
ASGNF4
line 531
;531:       	}
LABELV $262
line 533
;532:
;533:       	if ( tg_data.gren_time )
ADDRGP4 tg_data+36
INDIRI4
CNSTI4 0
EQI4 $267
line 534
;534:       		te->gren_eff_time = g_globalvars.time + tg_data.gren_time;
ADDRLP4 0
INDIRP4
CNSTI4 1596
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 tg_data+36
INDIRI4
CVIF4 4
ADDF4
ASGNF4
LABELV $267
line 535
;535:}
LABELV $240
endproc ConcPlayer 16 12
export T_RadiusBounce
proc T_RadiusBounce 56 12
line 540
;536://=========================================================================
;537:// Acts just like T_RadiusDamage, but doesn't damage things, just pushes them away
;538:// from the explosion at a speed relative to the distance from the explosion's origin.
;539:void T_RadiusBounce( gedict_t * inflictor, gedict_t * attacker, float bounce, gedict_t * ignore )
;540:{
line 545
;541:	float   points;
;542:	gedict_t *head;
;543:	vec3_t  org, dist;
;544:
;545:	for ( head = world; ( head = findradius( head, inflictor->s.v.origin, bounce + 40 ) ); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $276
JUMPV
LABELV $273
line 546
;546:	{
line 547
;547:		if ( head == ignore )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 12
INDIRP4
CVPU4 4
NEU4 $277
line 548
;548:			continue;
ADDRGP4 $274
JUMPV
LABELV $277
line 549
;549:		if ( head->s.v.takedamage == 0 )
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
NEF4 $279
line 550
;550:			continue;
ADDRGP4 $274
JUMPV
LABELV $279
line 551
;551:		VectorAdd( head->s.v.mins, head->s.v.maxs, org );
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
ADDF4
ASGNF4
line 552
;552:		VectorScale( org, 0.5, org );
ADDRLP4 4
ARGP4
CNSTF4 1056964608
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 553
;553:		VectorAdd( head->s.v.origin, org, org );
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDF4
ASGNF4
line 554
;554:		VectorSubtract( org, inflictor->s.v.origin, dist );
ADDRLP4 20
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20+4
ADDRLP4 4+4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20+8
ADDRLP4 4+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
SUBF4
ASGNF4
line 555
;555:		points = 0.5 * vlen( dist );
ADDRLP4 20
ARGP4
ADDRLP4 32
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 16
CNSTF4 1056964608
ADDRLP4 32
INDIRF4
MULF4
ASGNF4
line 557
;556:
;557:		if ( points < 0 )
ADDRLP4 16
INDIRF4
CNSTF4 0
GEF4 $291
line 558
;558:			points = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
LABELV $291
line 559
;559:		points = bounce - points;
ADDRLP4 16
ADDRFP4 8
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
line 560
;560:		if ( points <= 0 )
ADDRLP4 16
INDIRF4
CNSTF4 0
GTF4 $293
line 561
;561:			continue;
ADDRGP4 $274
JUMPV
LABELV $293
line 562
;562:		if ( streq( head->s.v.classname, "building_dispenser" ) )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $297
ARGP4
ADDRLP4 36
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $295
line 563
;563:			continue;
ADDRGP4 $274
JUMPV
LABELV $295
line 564
;564:		if ( streq( head->s.v.classname, "building_sentrygun" ) )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $300
ARGP4
ADDRLP4 40
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $298
line 565
;565:			continue;
ADDRGP4 $274
JUMPV
LABELV $298
line 566
;566:		if ( streq( head->s.v.classname, "building_sentrygun_base" ) )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $303
ARGP4
ADDRLP4 44
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $301
line 567
;567:			continue;
ADDRGP4 $274
JUMPV
LABELV $301
line 570
;568:
;569:		// Bounce!!
;570:		VectorScale( dist, ( points / 20.0 ), head->s.v.velocity );
ADDRLP4 20
ARGP4
ADDRLP4 16
INDIRF4
CNSTF4 1101004800
DIVF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 571
;571:		if ( strneq( head->s.v.classname, "player" ) )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $18
ARGP4
ADDRLP4 48
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $304
line 572
;572:		{
line 573
;573:			if ( ( int ) head->s.v.flags & FL_ONGROUND )
ADDRLP4 0
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $305
line 574
;574:				head->s.v.flags = ( int ) head->s.v.flags - FL_ONGROUND;
ADDRLP4 52
ADDRLP4 0
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 512
SUBI4
CVIF4 4
ASGNF4
line 575
;575:		} else
ADDRGP4 $305
JUMPV
LABELV $304
line 576
;576:		{
line 577
;577:			if ( tg_data.gren_effect == TG_GREN_EFFECT_OFF )
ADDRGP4 tg_data+32
INDIRI4
CNSTI4 1
NEI4 $308
line 578
;578:				continue;
ADDRGP4 $274
JUMPV
LABELV $308
line 580
;579:
;580:			if ( head == PROG_TO_EDICT( inflictor->s.v.owner )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
NEU4 $311
ADDRGP4 tg_data+32
INDIRI4
CNSTI4 2
NEI4 $311
line 582
;581:			     && tg_data.gren_effect == TG_GREN_EFFECT_OFF_FORSELF )
;582:				continue;
ADDRGP4 $274
JUMPV
LABELV $311
line 585
;583:
;584:			// Concuss 'em!!
;585:			ConcPlayer( head, attacker );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 ConcPlayer
CALLV
pop
line 586
;586:		}
LABELV $305
line 587
;587:	}
LABELV $274
line 545
LABELV $276
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRFP4 8
INDIRF4
CNSTF4 1109393408
ADDF4
ARGF4
ADDRLP4 32
ADDRGP4 findradius
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $273
line 588
;588:}
LABELV $272
endproc T_RadiusBounce 56 12
export TeamFortress_Scan_Angel
proc TeamFortress_Scan_Angel 108 12
line 594
;589:
;590:
;591://////////////////////////////////////////
;592:
;593:void TeamFortress_Scan_Angel( int scanrange, int typescan )
;594:{
line 596
;595:	gedict_t *list;
;596:	gedict_t *saveent = NULL;
ADDRLP4 40
CNSTP4 0
ASGNP4
line 612
;597:	float   minlen;
;598:	float   len;
;599:	float   scen;
;600:	float   scfr;
;601:	vec3_t  lightningvec;
;602:	float   enemy_detected;
;603:	float   friend_detected;
;604:	float   any_detected;
;605:	float   any_detected2;
;606:	vec3_t  tmp;
;607:	float   multiscan;
;608://	char    st[10];
;609://	int     opt;
;610:
;611:	// prevent scan impulse from triggering anything else
;612:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 613
;613:	self->last_impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 615
;614:
;615:	if ( strneq( self->s.v.classname, "player" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $18
ARGP4
ADDRLP4 68
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $315
line 616
;616:		return;
ADDRGP4 $314
JUMPV
LABELV $315
line 618
;617:
;618:	if ( !( self->tf_items & NIT_SCANNER ) )
ADDRGP4 self
INDIRP4
CNSTI4 832
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $317
line 619
;619:		return;
ADDRGP4 $314
JUMPV
LABELV $317
line 621
;620:	// If Impulse is TF_SCAN_ENEMY, toggle Scanning for Enemies
;621:	if ( scanrange == TF_SCAN_ENEMY )
ADDRFP4 0
INDIRI4
CNSTI4 160
NEI4 $319
line 622
;622:	{
line 623
;623:		if ( self->tf_items_flags & NIT_SCANNER_ENEMY )
ADDRGP4 self
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $321
line 624
;624:		{
line 625
;625:			G_sprint( self, 2, "Enemy Scanning disabled.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $323
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 626
;626:			self->tf_items_flags -= NIT_SCANNER_ENEMY;
ADDRLP4 72
ADDRGP4 self
INDIRP4
CNSTI4 836
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 627
;627:			self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 628
;628:			return;
ADDRGP4 $314
JUMPV
LABELV $321
line 630
;629:		}
;630:		G_sprint( self, PRINT_HIGH, "Enemy Scanning enabled.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $325
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 631
;631:		self->tf_items_flags |= NIT_SCANNER_ENEMY;
ADDRLP4 72
ADDRGP4 self
INDIRP4
CNSTI4 836
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 632
;632:		self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 633
;633:		return;
ADDRGP4 $314
JUMPV
LABELV $319
line 637
;634:	}
;635:	
;636:	// If Impulse is TF_SCAN_FRIENDLY, toggle Scanning for Friendlies
;637:	if ( scanrange == TF_SCAN_FRIENDLY )
ADDRFP4 0
INDIRI4
CNSTI4 161
NEI4 $327
line 638
;638:	{
line 639
;639:		if ( self->tf_items_flags & NIT_SCANNER_FRIENDLY )
ADDRGP4 self
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $329
line 640
;640:		{
line 641
;641:			G_sprint( self, PRINT_HIGH, "Friendly Scanning disabled.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $331
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 642
;642:			self->tf_items_flags -= NIT_SCANNER_FRIENDLY;
ADDRLP4 72
ADDRGP4 self
INDIRP4
CNSTI4 836
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 643
;643:			self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 644
;644:			return;
ADDRGP4 $314
JUMPV
LABELV $329
line 646
;645:		}
;646:		G_sprint( self, PRINT_HIGH, "Friendly Scanning enabled.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $333
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 647
;647:		self->tf_items_flags |= NIT_SCANNER_FRIENDLY;
ADDRLP4 72
ADDRGP4 self
INDIRP4
CNSTI4 836
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
line 648
;648:		self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 649
;649:		return;
ADDRGP4 $314
JUMPV
LABELV $327
line 651
;650:	}
;651:	if ( scanrange == TF_POST_SCANF_OFF )
ADDRFP4 0
INDIRI4
CNSTI4 162
NEI4 $335
line 652
;652:	{
line 653
;653:		G_sprint( self, PRINT_HIGH, "Friendly Scanning disabled.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $331
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 654
;654:		if ( self->tf_items_flags & NIT_SCANNER_FRIENDLY )
ADDRGP4 self
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $337
line 655
;655:			self->tf_items_flags -= NIT_SCANNER_FRIENDLY;
ADDRLP4 72
ADDRGP4 self
INDIRP4
CNSTI4 836
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
LABELV $337
line 656
;656:		self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 657
;657:		return;
ADDRGP4 $314
JUMPV
LABELV $335
line 660
;658:	}
;659:
;660:	if ( scanrange == TF_POST_SCANF_ON )
ADDRFP4 0
INDIRI4
CNSTI4 163
NEI4 $340
line 661
;661:	{
line 662
;662:		G_sprint( self, PRINT_HIGH, "Friendly Scanning enabled.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $333
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 663
;663:		self->tf_items_flags |= NIT_SCANNER_FRIENDLY;
ADDRLP4 72
ADDRGP4 self
INDIRP4
CNSTI4 836
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
line 664
;664:		self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 665
;665:		return;
ADDRGP4 $314
JUMPV
LABELV $340
line 668
;666:	}
;667:
;668:	if ( scanrange == TF_POST_SCANE_OFF )
ADDRFP4 0
INDIRI4
CNSTI4 164
NEI4 $343
line 669
;669:	{
line 670
;670:		G_sprint( self, PRINT_HIGH, "Enemy Scanning disabled.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $323
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 671
;671:		if ( self->tf_items_flags & NIT_SCANNER_ENEMY )
ADDRGP4 self
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $345
line 672
;672:			self->tf_items_flags -= NIT_SCANNER_ENEMY;
ADDRLP4 72
ADDRGP4 self
INDIRP4
CNSTI4 836
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $345
line 673
;673:		self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 674
;674:		return;
ADDRGP4 $314
JUMPV
LABELV $343
line 676
;675:	}
;676:	if ( scanrange == TF_POST_SCANE_ON )
ADDRFP4 0
INDIRI4
CNSTI4 165
NEI4 $348
line 677
;677:	{
line 678
;678:		G_sprint( self, PRINT_HIGH, "Enemy Scanning enabled.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $325
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 679
;679:		self->tf_items_flags |= NIT_SCANNER_ENEMY;
ADDRLP4 72
ADDRGP4 self
INDIRP4
CNSTI4 836
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 680
;680:		self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 681
;681:		return;
ADDRGP4 $314
JUMPV
LABELV $348
line 683
;682:	}
;683:	if ( scanrange == TF_POST_AUTOSCAN_ON )
ADDRFP4 0
INDIRI4
CNSTI4 167
NEI4 $351
line 684
;684:	{
line 685
;685:		if ( self->ScannerOn != 1 )
ADDRGP4 self
INDIRP4
CNSTI4 1496
ADDP4
INDIRI4
CNSTI4 1
EQI4 $353
line 686
;686:		{
line 687
;687:			ScannerSwitch(  );
ADDRGP4 ScannerSwitch
CALLV
pop
line 688
;688:		} else
ADDRGP4 $354
JUMPV
LABELV $353
line 689
;689:		{
line 690
;690:			G_sprint( self, PRINT_HIGH, "Scanner On.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $231
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 691
;691:		}
LABELV $354
line 692
;692:	}
LABELV $351
line 694
;693:
;694:	if ( scanrange == TF_POST_AUTOSCAN_OFF )
ADDRFP4 0
INDIRI4
CNSTI4 166
NEI4 $355
line 695
;695:	{
line 696
;696:		if ( self->ScannerOn == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 1496
ADDP4
INDIRI4
CNSTI4 1
NEI4 $357
line 697
;697:		{
line 698
;698:			ScannerSwitch(  );
ADDRGP4 ScannerSwitch
CALLV
pop
line 699
;699:		} else
ADDRGP4 $358
JUMPV
LABELV $357
line 700
;700:		{
line 701
;701:			G_sprint( self, PRINT_HIGH, "Scanner Off.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $238
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 702
;702:		}
LABELV $358
line 703
;703:	}
LABELV $355
line 705
;704:
;705:	if ( scanrange > 50 )
ADDRFP4 0
INDIRI4
CNSTI4 50
LEI4 $359
line 706
;706:		scanrange = 50;
ADDRFP4 0
CNSTI4 50
ASGNI4
LABELV $359
line 708
;707:
;708:	if ( self->ScanRange != scanrange )
ADDRGP4 self
INDIRP4
CNSTI4 1500
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $361
line 709
;709:	{
line 710
;710:		self->ScanRange = scanrange;
ADDRGP4 self
INDIRP4
CNSTI4 1500
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 711
;711:		self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 712
;712:	}
LABELV $361
line 713
;713:	scen = 0;
ADDRLP4 44
CNSTF4 0
ASGNF4
line 714
;714:	scfr = 0;
ADDRLP4 48
CNSTF4 0
ASGNF4
line 716
;715:	// Set the Scanner flags
;716:	if ( self->tf_items_flags & NIT_SCANNER_ENEMY )
ADDRGP4 self
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $364
line 717
;717:		scen = 1;
ADDRLP4 44
CNSTF4 1065353216
ASGNF4
LABELV $364
line 718
;718:	if ( self->tf_items_flags & NIT_SCANNER_FRIENDLY )
ADDRGP4 self
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $366
line 719
;719:		scfr = 1;
ADDRLP4 48
CNSTF4 1065353216
ASGNF4
LABELV $366
line 722
;720:
;721:	// If no entity type is enabled, don't scan
;722:	if ( !scen && !scfr )
ADDRLP4 72
CNSTF4 0
ASGNF4
ADDRLP4 44
INDIRF4
ADDRLP4 72
INDIRF4
NEF4 $368
ADDRLP4 48
INDIRF4
ADDRLP4 72
INDIRF4
NEF4 $368
line 723
;723:	{
line 724
;724:		G_sprint( self, PRINT_HIGH, "All scanner functions are disabled.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $370
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 725
;725:		return;
ADDRGP4 $314
JUMPV
LABELV $368
line 727
;726:	}
;727:	multiscan = ( self->settings_bits & TF_MULTISCAN_MASK) ? 0: 1;
ADDRGP4 self
INDIRP4
CNSTI4 1524
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $372
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRGP4 $373
JUMPV
LABELV $372
ADDRLP4 76
CNSTI4 1
ASGNI4
LABELV $373
ADDRLP4 56
ADDRLP4 76
INDIRI4
CVIF4 4
ASGNF4
line 729
;728:
;729:	if ( typescan == 0 )
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $374
line 730
;730:		G_sprint( self, PRINT_HIGH, "Scanning...\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $376
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $374
line 731
;731:	any_detected2 = 0;
ADDRLP4 52
CNSTF4 0
ASGNF4
line 732
;732:	scanrange = scanrange * 25;
ADDRFP4 0
CNSTI4 25
ADDRFP4 0
INDIRI4
MULI4
ASGNI4
line 733
;733:	minlen = scanrange + 100;
ADDRLP4 64
ADDRFP4 0
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
ASGNF4
line 734
;734:	for ( list = world; ( list = findradius( list, self->s.v.origin, scanrange + 40 ) ); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $380
JUMPV
LABELV $377
line 735
;735:	{
line 736
;736:		enemy_detected = 0;
ADDRLP4 32
CNSTF4 0
ASGNF4
line 737
;737:		friend_detected = 0;
ADDRLP4 36
CNSTF4 0
ASGNF4
line 738
;738:		any_detected = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
line 739
;739:		if ( list == self )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 self
INDIRP4
CVPU4 4
NEU4 $381
line 740
;740:			continue;
ADDRGP4 $378
JUMPV
LABELV $381
line 741
;741:		if ( strneq( list->s.v.classname, "player" ) )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $18
ARGP4
ADDRLP4 80
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $383
line 742
;742:			continue;
ADDRGP4 $378
JUMPV
LABELV $383
line 743
;743:		if ( !list->s.v.takedamage )
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
NEF4 $385
line 744
;744:			continue;
ADDRGP4 $378
JUMPV
LABELV $385
line 745
;745:		if ( list->s.v.health <= 0 )
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $387
line 746
;746:			continue;
ADDRGP4 $378
JUMPV
LABELV $387
line 747
;747:		if ( teamplay )
ADDRGP4 teamplay
INDIRI4
CNSTI4 0
EQI4 $389
line 748
;748:		{
line 749
;749:			if ( scfr && list->team_no > 0 && list->team_no == self->team_no )
ADDRLP4 48
INDIRF4
CNSTF4 0
EQF4 $391
ADDRLP4 84
CNSTI4 960
ASGNI4
ADDRLP4 88
ADDRLP4 0
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
LEI4 $391
ADDRLP4 88
INDIRI4
ADDRGP4 self
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRI4
NEI4 $391
line 750
;750:			{
line 751
;751:				friend_detected = 1;
ADDRLP4 36
CNSTF4 1065353216
ASGNF4
line 752
;752:				any_detected = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
line 753
;753:			}
LABELV $391
line 754
;754:			if ( scen && ( self->team_no > 0 ) && ( list->team_no > 0 )
ADDRLP4 44
INDIRF4
CNSTF4 0
EQF4 $390
ADDRLP4 92
CNSTI4 960
ASGNI4
ADDRLP4 96
ADDRGP4 self
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 100
CNSTI4 0
ASGNI4
ADDRLP4 96
INDIRI4
ADDRLP4 100
INDIRI4
LEI4 $390
ADDRLP4 104
ADDRLP4 0
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 104
INDIRI4
ADDRLP4 100
INDIRI4
LEI4 $390
ADDRLP4 104
INDIRI4
ADDRLP4 96
INDIRI4
EQI4 $390
line 756
;755:			     && ( list->team_no != self->team_no ) )
;756:			{
line 757
;757:				enemy_detected = 1;
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
line 758
;758:				any_detected = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
line 759
;759:			}
line 760
;760:		} else
ADDRGP4 $390
JUMPV
LABELV $389
line 761
;761:		{
line 762
;762:			any_detected = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
line 763
;763:			if ( ( self->tf_items_flags & 4 ) && ( vlen( list->s.v.velocity ) <= 50 ) )
ADDRGP4 self
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $395
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 84
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 84
INDIRF4
CNSTF4 1112014848
GTF4 $395
line 764
;764:				any_detected = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
LABELV $395
line 765
;765:		}
LABELV $390
line 766
;766:		if ( any_detected )
ADDRLP4 16
INDIRF4
CNSTF4 0
EQF4 $397
line 767
;767:		{
line 768
;768:			any_detected2 = 1;
ADDRLP4 52
CNSTF4 1065353216
ASGNF4
line 769
;769:			VectorSubtract( list->s.v.origin, self->s.v.origin, tmp );
ADDRLP4 84
CNSTI4 156
ASGNI4
ADDRLP4 20
ADDRLP4 0
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 88
CNSTI4 160
ASGNI4
ADDRLP4 20+4
ADDRLP4 0
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 92
CNSTI4 164
ASGNI4
ADDRLP4 20+8
ADDRLP4 0
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 770
;770:			if ( multiscan == 0 )
ADDRLP4 56
INDIRF4
CNSTF4 0
NEF4 $401
line 771
;771:			{
line 773
;772:
;773:				len = vlen( tmp );
ADDRLP4 20
ARGP4
ADDRLP4 84
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 60
ADDRLP4 84
INDIRF4
ASGNF4
line 774
;774:				if ( !saveent || ( len < minlen ) )
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $405
ADDRLP4 60
INDIRF4
ADDRLP4 64
INDIRF4
GEF4 $402
LABELV $405
line 775
;775:				{
line 776
;776:					saveent = list;
ADDRLP4 40
ADDRLP4 0
INDIRP4
ASGNP4
line 777
;777:					minlen = len;
ADDRLP4 64
ADDRLP4 60
INDIRF4
ASGNF4
line 778
;778:				}
line 779
;779:			} else
ADDRGP4 $402
JUMPV
LABELV $401
line 780
;780:			{
line 781
;781:				normalize( tmp, lightningvec );
ADDRLP4 20
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 normalize
CALLV
pop
line 782
;782:				VectorScale( lightningvec, vlen( tmp ) / 5, lightningvec );
ADDRLP4 20
ARGP4
ADDRLP4 84
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 4
ARGP4
ADDRLP4 84
INDIRF4
CNSTF4 1084227584
DIVF4
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 783
;783:				VectorAdd( lightningvec, self->s.v.origin, lightningvec );
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDF4
ASGNF4
line 784
;784:				g_globalvars.msg_entity = EDICT_TO_PROG( self );
ADDRGP4 g_globalvars+316
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 785
;785:				trap_WriteByte( MSG_ONE, SVC_TEMPENTITY );
CNSTI4 1
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 786
;786:				trap_WriteByte( MSG_ONE, TE_LIGHTNING1 );
CNSTI4 1
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 787
;787:				WriteEntity( MSG_ONE, list );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 WriteEntity
CALLV
pop
line 788
;788:				trap_WriteCoord( MSG_ONE, self->s.v.origin[0] );
CNSTI4 1
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
line 789
;789:				trap_WriteCoord( MSG_ONE, self->s.v.origin[1] );
CNSTI4 1
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
line 790
;790:				trap_WriteCoord( MSG_ONE, self->s.v.origin[2] + 8 );
CNSTI4 1
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 791
;791:				trap_WriteCoord( MSG_ONE, lightningvec[0] );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 792
;792:				trap_WriteCoord( MSG_ONE, lightningvec[1] );
CNSTI4 1
ARGI4
ADDRLP4 4+4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 793
;793:				trap_WriteCoord( MSG_ONE, lightningvec[2] + 8 );
CNSTI4 1
ARGI4
ADDRLP4 4+8
INDIRF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 794
;794:			}
LABELV $402
line 795
;795:		}
LABELV $397
line 796
;796:	}
LABELV $378
line 734
LABELV $380
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRFP4 0
INDIRI4
CNSTI4 40
ADDI4
CVIF4 4
ARGF4
ADDRLP4 80
ADDRGP4 findradius
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 80
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $377
line 798
;797:
;798:	if ( ( multiscan == 0 ) && saveent )
ADDRLP4 56
INDIRF4
CNSTF4 0
NEF4 $413
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $413
line 799
;799:	{
line 800
;800:      		VectorSubtract( saveent->s.v.origin, self->s.v.origin, tmp );
ADDRLP4 84
CNSTI4 156
ASGNI4
ADDRLP4 20
ADDRLP4 40
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 88
CNSTI4 160
ASGNI4
ADDRLP4 20+4
ADDRLP4 40
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 92
CNSTI4 164
ASGNI4
ADDRLP4 20+8
ADDRLP4 40
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 801
;801:      		normalize( tmp, lightningvec );
ADDRLP4 20
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 normalize
CALLV
pop
line 802
;802:      		VectorScale( lightningvec, vlen( tmp ) / 5, lightningvec );
ADDRLP4 20
ARGP4
ADDRLP4 84
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 4
ARGP4
ADDRLP4 84
INDIRF4
CNSTF4 1084227584
DIVF4
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 803
;803:      		VectorAdd( lightningvec, self->s.v.origin, lightningvec );
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDF4
ASGNF4
line 804
;804:      		g_globalvars.msg_entity = EDICT_TO_PROG( self );
ADDRGP4 g_globalvars+316
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 805
;805:      		trap_WriteByte( MSG_ONE, SVC_TEMPENTITY );
CNSTI4 1
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 806
;806:      		trap_WriteByte( MSG_ONE, TE_LIGHTNING1 );
CNSTI4 1
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 807
;807:      		WriteEntity( MSG_ONE, saveent );
CNSTI4 1
ARGI4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 WriteEntity
CALLV
pop
line 808
;808:      		trap_WriteCoord( MSG_ONE, self->s.v.origin[0] );
CNSTI4 1
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
line 809
;809:      		trap_WriteCoord( MSG_ONE, self->s.v.origin[1] );
CNSTI4 1
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
line 810
;810:      		trap_WriteCoord( MSG_ONE, self->s.v.origin[2] + 8 );
CNSTI4 1
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 811
;811:      		trap_WriteCoord( MSG_ONE, lightningvec[0] );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 812
;812:      		trap_WriteCoord( MSG_ONE, lightningvec[1] );
CNSTI4 1
ARGI4
ADDRLP4 4+4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 813
;813:      		trap_WriteCoord( MSG_ONE, lightningvec[2] + 8 );
CNSTI4 1
ARGI4
ADDRLP4 4+8
INDIRF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 814
;814:	}
LABELV $413
line 816
;815:
;816:	if ( typescan == 0 && any_detected2 == 0 )
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $424
ADDRLP4 52
INDIRF4
CNSTF4 0
NEF4 $424
line 817
;817:		G_sprint( self, PRINT_HIGH, "No blips.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $426
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $424
line 819
;818:
;819:	W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 820
;820:	return;
LABELV $314
endproc TeamFortress_Scan_Angel 108 12
import ambient_sound
import sandball_goal
import ballstart
import ball
import func_glass
import trigger_jumper
import TeamFortress_NightVision
import s2_explode1
import EjectShell
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
import BioInfection_MonsterDecay
import BioInfection_Decay
import Engineer_UseMortar
import Engineer_UseSentryGun
import Engineer_UseDispenser
import TeamFortress_SetDetpack
import TeamFortress_Scan
import RemoveOldFlare
import RemoveFlare
import UseSpecialSkill
import DropKey
import SniperSight_Create
import TeamFortress_DetpackStop
import PipebombTouch
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
LABELV $426
byte 1 78
byte 1 111
byte 1 32
byte 1 98
byte 1 108
byte 1 105
byte 1 112
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $376
byte 1 83
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $370
byte 1 65
byte 1 108
byte 1 108
byte 1 32
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 114
byte 1 32
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $333
byte 1 70
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 32
byte 1 83
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $331
byte 1 70
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 32
byte 1 83
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $325
byte 1 69
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 83
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $323
byte 1 69
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 83
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $303
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
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $300
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
LABELV $297
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
LABELV $264
byte 1 118
byte 1 95
byte 1 105
byte 1 100
byte 1 108
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 32
byte 1 49
byte 1 48
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $260
byte 1 98
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $241
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 99
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $238
byte 1 83
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 114
byte 1 32
byte 1 79
byte 1 102
byte 1 102
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $231
byte 1 83
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 114
byte 1 32
byte 1 79
byte 1 110
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $230
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $178
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 101
byte 1 101
byte 1 108
byte 1 115
byte 1 32
byte 1 98
byte 1 101
byte 1 116
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 110
byte 1 111
byte 1 119
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $171
byte 1 118
byte 1 95
byte 1 105
byte 1 100
byte 1 108
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $170
byte 1 118
byte 1 95
byte 1 105
byte 1 121
byte 1 97
byte 1 119
byte 1 95
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 48
byte 1 46
byte 1 51
byte 1 10
byte 1 0
align 1
LABELV $169
byte 1 118
byte 1 95
byte 1 105
byte 1 112
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 95
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 48
byte 1 46
byte 1 51
byte 1 10
byte 1 0
align 1
LABELV $168
byte 1 118
byte 1 95
byte 1 105
byte 1 121
byte 1 97
byte 1 119
byte 1 95
byte 1 99
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 32
byte 1 50
byte 1 10
byte 1 0
align 1
LABELV $167
byte 1 118
byte 1 95
byte 1 105
byte 1 112
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 95
byte 1 99
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 32
byte 1 49
byte 1 10
byte 1 0
align 1
LABELV $166
byte 1 118
byte 1 95
byte 1 105
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 95
byte 1 99
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 32
byte 1 48
byte 1 46
byte 1 53
byte 1 10
byte 1 0
align 1
LABELV $160
byte 1 98
byte 1 117
byte 1 98
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $158
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 115
byte 1 95
byte 1 98
byte 1 117
byte 1 98
byte 1 98
byte 1 108
byte 1 101
byte 1 46
byte 1 115
byte 1 112
byte 1 114
byte 1 0
align 1
LABELV $152
byte 1 118
byte 1 95
byte 1 105
byte 1 100
byte 1 108
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 32
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $113
byte 1 118
byte 1 95
byte 1 99
byte 1 115
byte 1 104
byte 1 105
byte 1 102
byte 1 116
byte 1 32
byte 1 50
byte 1 52
byte 1 48
byte 1 32
byte 1 50
byte 1 52
byte 1 48
byte 1 32
byte 1 50
byte 1 52
byte 1 48
byte 1 32
byte 1 50
byte 1 52
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $112
byte 1 118
byte 1 95
byte 1 99
byte 1 115
byte 1 104
byte 1 105
byte 1 102
byte 1 116
byte 1 32
byte 1 49
byte 1 54
byte 1 48
byte 1 32
byte 1 49
byte 1 54
byte 1 48
byte 1 32
byte 1 49
byte 1 54
byte 1 48
byte 1 32
byte 1 49
byte 1 54
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $94
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $93
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 32
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 32
byte 1 108
byte 1 111
byte 1 103
byte 1 105
byte 1 99
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $84
byte 1 102
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $83
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $70
byte 1 118
byte 1 95
byte 1 99
byte 1 115
byte 1 104
byte 1 105
byte 1 102
byte 1 116
byte 1 32
byte 1 50
byte 1 53
byte 1 53
byte 1 32
byte 1 50
byte 1 53
byte 1 53
byte 1 32
byte 1 50
byte 1 53
byte 1 53
byte 1 32
byte 1 50
byte 1 53
byte 1 53
byte 1 10
byte 1 0
align 1
LABELV $67
byte 1 118
byte 1 95
byte 1 99
byte 1 115
byte 1 104
byte 1 105
byte 1 102
byte 1 116
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
byte 1 10
byte 1 0
align 1
LABELV $64
byte 1 118
byte 1 95
byte 1 99
byte 1 115
byte 1 104
byte 1 105
byte 1 102
byte 1 116
byte 1 59
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 59
byte 1 32
byte 1 98
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $58
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
align 1
LABELV $47
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 99
byte 1 97
byte 1 108
byte 1 116
byte 1 114
byte 1 111
byte 1 112
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $45
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $25
byte 1 79
byte 1 119
byte 1 44
byte 1 32
byte 1 79
byte 1 119
byte 1 44
byte 1 32
byte 1 79
byte 1 119
byte 1 33
byte 1 32
byte 1 67
byte 1 97
byte 1 108
byte 1 116
byte 1 114
byte 1 111
byte 1 112
byte 1 115
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $18
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
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
