export SUB_regen
code
proc SUB_regen 12 20
file "..\src\items.c"
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
;21: *  $Id: items.c,v 1.13 2005/11/14 15:36:21 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:void SUB_regen(  )
;26:{
line 27
;27:	self->s.v.model = self->mdl;	// restore original model
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ASGNP4
line 28
;28:	self->s.v.solid = SOLID_TRIGGER;	// allow it to be touched again
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 29
;29:	sound( self, CHAN_VOICE, "items/itembk2.wav", 1, ATTN_NORM );	// play respawn sound
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $12
ARGP4
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 30
;30:	setorigin( self, PASSVEC3( self->s.v.origin ) );
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
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
ADDRGP4 setorigin
CALLV
pop
line 31
;31:}
LABELV $11
endproc SUB_regen 12 20
export SP_noclass
proc SP_noclass 4 16
line 34
;32:
;33:void SP_noclass(  )
;34:{
line 35
;35:	G_dprintf( "noclass spawned at %f %f %f\n", self->s.v.origin[0], self->s.v.origin[1], self->s.v.origin[2] );
ADDRGP4 $14
ARGP4
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
ADDRGP4 G_dprintf
CALLV
pop
line 36
;36:	ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 37
;37:}
LABELV $13
endproc SP_noclass 4 16
export q_touch
proc q_touch 20 20
line 40
;38:
;39:void q_touch(  )
;40:{
line 42
;41:
;42:	if ( strneq( other->s.v.classname, "player" ) )
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
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $16
line 43
;43:		return;
ADDRGP4 $15
JUMPV
LABELV $16
line 44
;44:	if ( other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $19
line 45
;45:		return;
ADDRGP4 $15
JUMPV
LABELV $19
line 47
;46:
;47:	self->mdl = self->s.v.model;
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 528
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ASGNP4
line 49
;48:
;49:	sound( other, CHAN_VOICE, self->s.v.noise, 1, ATTN_NORM );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
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
line 50
;50:	stuffcmd( other, "bf\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $21
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 52
;51:
;52:	self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 53
;53:	other->s.v.items = ( ( int ) other->s.v.items ) | IT_QUAD;
ADDRLP4 12
ADDRGP4 other
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 4194304
BORI4
CVIF4 4
ASGNF4
line 54
;54:	self->s.v.model = "";
ADDRGP4 self
INDIRP4
CNSTI4 220
ADDP4
ADDRGP4 $22
ASGNP4
line 57
;55:
;56:// do the apropriate action
;57:	other->super_time = 1;
ADDRGP4 other
INDIRP4
CNSTI4 764
ADDP4
CNSTF4 1065353216
ASGNF4
line 58
;58:	other->super_damage_finished = self->cnt;
ADDRGP4 other
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 self
INDIRP4
CNSTI4 692
ADDP4
INDIRF4
ASGNF4
line 60
;59:
;60:	G_bprint( PRINT_LOW, "%s recovered a Quad with %d seconds remaining!\n",
CNSTI4 0
ARGI4
ADDRGP4 $23
ARGP4
ADDRLP4 16
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 740
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
SUBF4
CVFI4 4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
line 64
;61:		  other->s.v.netname, ( int ) ( other->super_damage_finished - g_globalvars.time ) );
;62:
;63:
;64:	activator = other;
ADDRGP4 activator
ADDRGP4 other
INDIRP4
ASGNP4
line 65
;65:	SUB_UseTargets(  );	// fire all targets / killtargets
ADDRGP4 SUB_UseTargets
CALLV
pop
line 66
;66:}
LABELV $15
endproc q_touch 20 20
export DropQuad
proc DropQuad 28 28
line 69
;67:
;68:void DropQuad( float timeleft )
;69:{
line 72
;70:	gedict_t *item;
;71:
;72:	item = spawn(  );
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 73
;73:	VectorCopy( self->s.v.origin, item->s.v.origin );
ADDRLP4 8
CNSTI4 156
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12
CNSTI4 160
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
INDIRF4
ASGNF4
ADDRLP4 16
CNSTI4 164
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 74
;74:	item->s.v.origin[2] -= 24;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 76
;75:
;76:	item->s.v.velocity[2] = 300;
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1133903872
ASGNF4
line 77
;77:	item->s.v.velocity[0] = -100 + ( g_random(  ) * 200 );
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1128792064
ADDRLP4 12
INDIRF4
MULF4
CNSTF4 3267887104
ADDF4
ASGNF4
line 78
;78:	item->s.v.velocity[1] = -100 + ( g_random(  ) * 200 );
ADDRLP4 16
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1128792064
ADDRLP4 16
INDIRF4
MULF4
CNSTF4 3267887104
ADDF4
ASGNF4
line 80
;79:
;80:	item->s.v.flags = FL_ITEM;
ADDRLP4 0
INDIRP4
CNSTI4 404
ADDP4
CNSTF4 1132462080
ASGNF4
line 81
;81:	item->s.v.solid = SOLID_TRIGGER;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 82
;82:	item->s.v.movetype = MOVETYPE_TOSS;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 83
;83:	item->s.v.noise = "items/damage.wav";
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $26
ASGNP4
line 85
;84:
;85:	setmodel( item, "progs/quaddama.mdl" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $27
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 86
;86:	setsize( item, -16, -16, -24, 16, 16, 32 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20
CNSTF4 3246391296
ASGNF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
CNSTF4 3250585600
ARGF4
ADDRLP4 24
CNSTF4 1098907648
ASGNF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 setsize
CALLV
pop
line 88
;87:
;88:	item->cnt = g_globalvars.time + timeleft;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRFP4 0
INDIRF4
ADDF4
ASGNF4
line 89
;89:	item->s.v.touch = ( func_t ) q_touch;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 q_touch
CVPU4 4
CVUI4 4
ASGNI4
line 90
;90:	item->s.v.nextthink = g_globalvars.time + timeleft;	// remove it with the time left on it
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRFP4 0
INDIRF4
ADDF4
ASGNF4
line 91
;91:	item->s.v.think = ( func_t ) SUB_Remove;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 92
;92:}
LABELV $25
endproc DropQuad 28 28
export r_touch
proc r_touch 20 20
line 95
;93:
;94:void r_touch(  )
;95:{
line 97
;96:
;97:	if ( strneq( other->s.v.classname, "player" ) )
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
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $31
line 98
;98:		return;
ADDRGP4 $30
JUMPV
LABELV $31
line 99
;99:	if ( other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $33
line 100
;100:		return;
ADDRGP4 $30
JUMPV
LABELV $33
line 102
;101:
;102:	self->mdl = self->s.v.model;
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 528
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ASGNP4
line 104
;103:
;104:	sound( other, CHAN_VOICE, self->s.v.noise, 1, ATTN_NORM );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
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
line 105
;105:	stuffcmd( other, "bf\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $21
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 107
;106:
;107:	self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 108
;108:	other->s.v.items = ( ( int ) other->s.v.items ) | IT_INVISIBILITY;
ADDRLP4 12
ADDRGP4 other
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 524288
BORI4
CVIF4 4
ASGNF4
line 109
;109:	self->s.v.model = "";
ADDRGP4 self
INDIRP4
CNSTI4 220
ADDP4
ADDRGP4 $22
ASGNP4
line 112
;110:
;111:// do the apropriate action
;112:	other->invisible_time = 1;
ADDRGP4 other
INDIRP4
CNSTI4 756
ADDP4
CNSTF4 1065353216
ASGNF4
line 113
;113:	other->invisible_finished = self->cnt;
ADDRGP4 other
INDIRP4
CNSTI4 736
ADDP4
ADDRGP4 self
INDIRP4
CNSTI4 692
ADDP4
INDIRF4
ASGNF4
line 115
;114:
;115:	G_bprint( PRINT_LOW, "%s recovered a Ring with %d seconds remaining!\n",
CNSTI4 0
ARGI4
ADDRGP4 $35
ARGP4
ADDRLP4 16
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 736
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
SUBF4
CVFI4 4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
line 118
;116:		  other->s.v.netname, ( int ) ( other->invisible_finished - g_globalvars.time ) );
;117:
;118:	activator = other;
ADDRGP4 activator
ADDRGP4 other
INDIRP4
ASGNP4
line 119
;119:	SUB_UseTargets(  );	// fire all targets / killtargets
ADDRGP4 SUB_UseTargets
CALLV
pop
line 120
;120:}
LABELV $30
endproc r_touch 20 20
export DropRing
proc DropRing 28 28
line 123
;121:
;122:void DropRing( float timeleft )
;123:{
line 126
;124:	gedict_t *item;
;125:
;126:	item = spawn(  );
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 127
;127:	VectorCopy( self->s.v.origin, item->s.v.origin );
ADDRLP4 8
CNSTI4 156
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12
CNSTI4 160
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
INDIRF4
ASGNF4
ADDRLP4 16
CNSTI4 164
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 128
;128:	item->s.v.origin[2] -= 24;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 130
;129:
;130:	item->s.v.velocity[2] = 300;
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1133903872
ASGNF4
line 131
;131:	item->s.v.velocity[0] = -100 + ( g_random(  ) * 200 );
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1128792064
ADDRLP4 12
INDIRF4
MULF4
CNSTF4 3267887104
ADDF4
ASGNF4
line 132
;132:	item->s.v.velocity[1] = -100 + ( g_random(  ) * 200 );
ADDRLP4 16
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1128792064
ADDRLP4 16
INDIRF4
MULF4
CNSTF4 3267887104
ADDF4
ASGNF4
line 134
;133:
;134:	item->s.v.flags = FL_ITEM;
ADDRLP4 0
INDIRP4
CNSTI4 404
ADDP4
CNSTF4 1132462080
ASGNF4
line 135
;135:	item->s.v.solid = SOLID_TRIGGER;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 136
;136:	item->s.v.movetype = MOVETYPE_TOSS;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 137
;137:	item->s.v.noise = "items/inv1.wav";
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $38
ASGNP4
line 139
;138:
;139:	setmodel( item, "progs/invisibl.mdl" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $39
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 140
;140:	setsize( item, -16, -16, -24, 16, 16, 32 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20
CNSTF4 3246391296
ASGNF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
CNSTF4 3250585600
ARGF4
ADDRLP4 24
CNSTF4 1098907648
ASGNF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 setsize
CALLV
pop
line 142
;141:
;142:	item->cnt = g_globalvars.time + timeleft;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRFP4 0
INDIRF4
ADDF4
ASGNF4
line 143
;143:	item->s.v.touch = ( func_t ) r_touch;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 r_touch
CVPU4 4
CVUI4 4
ASGNI4
line 144
;144:	item->s.v.nextthink = g_globalvars.time + timeleft;	// remove after 30 seconds
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRFP4 0
INDIRF4
ADDF4
ASGNF4
line 145
;145:	item->s.v.think = ( func_t ) SUB_Remove;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 146
;146:}
LABELV $37
endproc DropRing 28 28
export PlaceItem
proc PlaceItem 16 16
line 149
;147:
;148:void PlaceItem(  )
;149:{
line 150
;150:	self->s.v.solid = SOLID_TRIGGER;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 151
;151:	self->s.v.movetype = MOVETYPE_TOSS;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 152
;152:	self->s.v.flags = FL_ITEM;
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
CNSTF4 1132462080
ASGNF4
line 153
;153:	self->mdl = self->s.v.model;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ASGNP4
line 155
;154:
;155:	SetVector( self->s.v.velocity, 0, 0, 0 );
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
line 156
;156:	self->s.v.origin[2] += 6;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1086324736
ADDF4
ASGNF4
line 158
;157:
;158:	if ( !droptofloor( self ) )
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 droptofloor
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $43
line 159
;159:	{
line 160
;160:		G_dprintf( "Bonus item fell out of level at  '%f %f %f'\n",
ADDRGP4 $45
ARGP4
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
ADDRGP4 G_dprintf
CALLV
pop
line 162
;161:			  self->s.v.origin[0], self->s.v.origin[1], self->s.v.origin[2] );
;162:		ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 163
;163:	}
LABELV $43
line 164
;164:}
LABELV $42
endproc PlaceItem 16 16
export StartItem
proc StartItem 0 0
line 175
;165:
;166:/*
;167:============
;168:StartItem
;169:
;170:Sets the clipping size and plants the object on the floor
;171:============
;172:*/
;173:
;174:void StartItem(  )
;175:{
line 176
;176:	self->s.v.nextthink = g_globalvars.time + 0.2;	// items start after other solids
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 177
;177:	self->s.v.think = ( func_t ) PlaceItem;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 PlaceItem
CVPU4 4
CVUI4 4
ASGNI4
line 178
;178:}
LABELV $46
endproc StartItem 0 0
export T_Heal
proc T_Heal 32 4
line 192
;179:
;180:/*
;181:=========================================================================
;182:
;183:HEALTH BOX
;184:
;185:=========================================================================
;186:*/
;187://
;188:// T_Heal: add health to an entity, limiting health to max_health
;189:// "ignore" will ignore max_health limit
;190://
;191:int T_Heal( gedict_t * e, float healamount, float ignore )
;192:{
line 193
;193:	if ( e->s.v.health <= 0 )
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $49
line 194
;194:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $48
JUMPV
LABELV $49
line 196
;195:
;196:	if ( ( !ignore ) && ( e->s.v.health >= e->s.v.max_health ) )
ADDRFP4 8
INDIRF4
CNSTF4 0
NEF4 $51
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRF4
LTF4 $51
line 197
;197:	{
line 198
;198:		if ( e->leg_damage )
ADDRFP4 0
INDIRP4
CNSTI4 1464
ADDP4
INDIRI4
CNSTI4 0
EQI4 $53
line 199
;199:		{
line 200
;200:			e->leg_damage -= ceil( e->s.v.health / 20 );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1101004800
DIVF4
ARGF4
ADDRLP4 8
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 1464
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRLP4 8
INDIRF4
SUBF4
CVFI4 4
ASGNI4
line 201
;201:			if ( e->leg_damage < 1 )
ADDRFP4 0
INDIRP4
CNSTI4 1464
ADDP4
INDIRI4
CNSTI4 1
GEI4 $55
line 202
;202:				e->leg_damage = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1464
ADDP4
CNSTI4 0
ASGNI4
LABELV $55
line 203
;203:			TeamFortress_SetSpeed( e );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 204
;204:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $48
JUMPV
LABELV $53
line 206
;205:		} else
;206:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $48
JUMPV
LABELV $51
line 209
;207:	}
;208:
;209:	healamount = ceil( healamount );
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRFP4 4
ADDRLP4 4
INDIRF4
ASGNF4
line 211
;210:
;211:	e->s.v.health = e->s.v.health + healamount;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRFP4 4
INDIRF4
ADDF4
ASGNF4
line 212
;212:	if ( ( !ignore ) && ( e->s.v.health >= e->s.v.max_health ) )
ADDRFP4 8
INDIRF4
CNSTF4 0
NEF4 $57
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 416
ADDP4
INDIRF4
LTF4 $57
line 213
;213:		e->s.v.health = e->s.v.max_health;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 296
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 416
ADDP4
INDIRF4
ASGNF4
LABELV $57
line 215
;214:
;215:	if ( e->s.v.health > 250 )
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1132068864
LEF4 $59
line 216
;216:		e->s.v.health = 250;
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1132068864
ASGNF4
LABELV $59
line 217
;217:	if ( e->leg_damage )
ADDRFP4 0
INDIRP4
CNSTI4 1464
ADDP4
INDIRI4
CNSTI4 0
EQI4 $61
line 218
;218:	{
line 219
;219:		if ( e->s.v.health > 95 )
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1119748096
LEF4 $63
line 220
;220:			e->leg_damage = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1464
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $64
JUMPV
LABELV $63
line 222
;221:		else
;222:			e->leg_damage -= ceil( e->s.v.health / 20 );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1101004800
DIVF4
ARGF4
ADDRLP4 24
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 20
INDIRP4
CNSTI4 1464
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CVIF4 4
ADDRLP4 24
INDIRF4
SUBF4
CVFI4 4
ASGNI4
LABELV $64
line 223
;223:		if ( e->leg_damage < 1 )
ADDRFP4 0
INDIRP4
CNSTI4 1464
ADDP4
INDIRI4
CNSTI4 1
GEI4 $65
line 224
;224:			e->leg_damage = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1464
ADDP4
CNSTI4 0
ASGNI4
LABELV $65
line 225
;225:		TeamFortress_SetSpeed( e );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 226
;226:	}
LABELV $61
line 227
;227:	return 1;
CNSTI4 1
RETI4
LABELV $48
endproc T_Heal 32 4
export SP_item_health
proc SP_item_health 12 28
line 245
;228:}
;229:
;230:
;231:#define   H_ROTTEN  1
;232:#define   H_MEGA 2
;233:void    health_touch(  );
;234:void    item_megahealth_rot(  );
;235:
;236:/*QUAKED item_health (.3 .3 1) (0 0 0) (32 32 32) rotten megahealth
;237:Health box. Normally gives 25 points.
;238:Rotten box heals 5-10 points,
;239:megahealth will add 100 health, then 
;240:rot you down to your maximum health limit, 
;241:one point per second.
;242:*/
;243:
;244:void SP_item_health(  )
;245:{
line 246
;246:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $68
line 247
;247:	{
line 248
;248:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 249
;249:		return;
ADDRGP4 $67
JUMPV
LABELV $68
line 251
;250:	}
;251:	self->s.v.touch = ( func_t ) health_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 health_touch
CVPU4 4
CVUI4 4
ASGNI4
line 252
;252:	if ( ( int ) self->s.v.spawnflags & H_ROTTEN )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $70
line 253
;253:	{
line 254
;254:		trap_precache_model( "maps/b_bh10.bsp" );
ADDRGP4 $72
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 255
;255:		trap_precache_sound( "items/r_item1.wav" );
ADDRGP4 $73
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 256
;256:		setmodel( self, "maps/b_bh10.bsp" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $72
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 257
;257:		self->s.v.noise = "items/r_item1.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $73
ASGNP4
line 258
;258:		self->healamount = 15;
ADDRGP4 self
INDIRP4
CNSTI4 564
ADDP4
CNSTF4 1097859072
ASGNF4
line 259
;259:		self->healtype = 0;
ADDRGP4 self
INDIRP4
CNSTI4 568
ADDP4
CNSTF4 0
ASGNF4
line 260
;260:	} else
ADDRGP4 $71
JUMPV
LABELV $70
line 261
;261:	{
line 262
;262:		if ( ( int ) self->s.v.spawnflags & H_MEGA )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $74
line 263
;263:		{
line 264
;264:			trap_precache_model( "maps/b_bh100.bsp" );
ADDRGP4 $76
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 265
;265:			trap_precache_sound( "items/r_item2.wav" );
ADDRGP4 $77
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 266
;266:			setmodel( self, "maps/b_bh100.bsp" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $76
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 267
;267:			self->s.v.noise = "items/r_item2.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $77
ASGNP4
line 268
;268:			self->healamount = 100;
ADDRGP4 self
INDIRP4
CNSTI4 564
ADDP4
CNSTF4 1120403456
ASGNF4
line 269
;269:			self->healtype = 2;
ADDRGP4 self
INDIRP4
CNSTI4 568
ADDP4
CNSTF4 1073741824
ASGNF4
line 270
;270:		} else
ADDRGP4 $75
JUMPV
LABELV $74
line 271
;271:		{
line 272
;272:			trap_precache_model( "maps/b_bh25.bsp" );
ADDRGP4 $78
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 273
;273:			trap_precache_sound( "items/health1.wav" );
ADDRGP4 $79
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 274
;274:			setmodel( self, "maps/b_bh25.bsp" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $78
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 275
;275:			self->s.v.noise = "items/health1.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $79
ASGNP4
line 276
;276:			self->healamount = 25;
ADDRGP4 self
INDIRP4
CNSTI4 564
ADDP4
CNSTF4 1103626240
ASGNF4
line 277
;277:			self->healtype = 1;
ADDRGP4 self
INDIRP4
CNSTI4 568
ADDP4
CNSTF4 1065353216
ASGNF4
line 278
;278:		}
LABELV $75
line 279
;279:	}
LABELV $71
line 281
;280:
;281:	setsize( self, 0, 0, 0, 32, 32, 56 );
ADDRGP4 self
INDIRP4
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
CNSTF4 1107296256
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1113587712
ARGF4
ADDRGP4 setsize
CALLV
pop
line 282
;282:	StartItem( );
ADDRGP4 StartItem
CALLV
pop
line 283
;283:}
LABELV $67
endproc SP_item_health 12 28
export health_touch
proc health_touch 40 20
line 286
;284:
;285:void health_touch(  )
;286:{
line 290
;287://      float   amount;
;288:	float   medi;
;289:
;290:	if ( strneq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $18
ARGP4
ADDRLP4 4
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $81
line 291
;291:		return;
ADDRGP4 $80
JUMPV
LABELV $81
line 294
;292:
;293:
;294:	if ( other->is_feigning )
ADDRGP4 other
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
EQI4 $83
line 295
;295:		return;
ADDRGP4 $80
JUMPV
LABELV $83
line 296
;296:	if ( ( other->tfstate & TFSTATE_CANT_MOVE ) || ( other->tfstate & TFSTATE_AIMING ) )
ADDRLP4 8
ADDRGP4 other
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 65536
BANDI4
ADDRLP4 12
INDIRI4
NEI4 $87
ADDRLP4 8
INDIRI4
CNSTI4 2048
BANDI4
ADDRLP4 12
INDIRI4
EQI4 $85
LABELV $87
line 297
;297:		return;
ADDRGP4 $80
JUMPV
LABELV $85
line 298
;298:	if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $88
line 299
;299:		return;
ADDRGP4 $80
JUMPV
LABELV $88
line 300
;300:	medi = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 301
;301:	if ( self->healtype == 2 )	// Megahealth?  Ignore max_health...
ADDRGP4 self
INDIRP4
CNSTI4 568
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $92
line 302
;302:	{
line 304
;303:
;304:		if ( !( other->tfstate & TFSTATE_INFECTED ) )
ADDRGP4 other
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $93
line 305
;305:		{
line 306
;306:			if ( other->s.v.health >= 250 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1132068864
LTF4 $96
line 307
;307:				return;
ADDRGP4 $80
JUMPV
LABELV $96
line 308
;308:			if ( !T_Heal( other, self->healamount, 1 ) )
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 564
ADDP4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 16
ADDRGP4 T_Heal
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $93
line 309
;309:				return;
ADDRGP4 $80
JUMPV
line 310
;310:		}
line 311
;311:	} else
LABELV $92
line 312
;312:	{
line 313
;313:		if ( !T_Heal( other, self->healamount, 0 ) )
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 564
ADDP4
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 16
ADDRGP4 T_Heal
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $100
line 314
;314:		{
line 315
;315:			if ( other->weapons_carried & WEAP_MEDIKIT )
ADDRGP4 other
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $80
line 316
;316:			{
line 317
;317:				if ( other->ammo_medikit < other->maxammo_medikit )
ADDRLP4 20
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 1044
ADDP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 1048
ADDP4
INDIRI4
GEI4 $80
line 318
;318:				{
line 319
;319:					other->ammo_medikit += self->healamount;
ADDRLP4 24
ADDRGP4 other
INDIRP4
CNSTI4 1044
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 564
ADDP4
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 320
;320:					if ( other->ammo_medikit > other->maxammo_medikit )
ADDRLP4 28
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 1044
ADDP4
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 1048
ADDP4
INDIRI4
LEI4 $106
line 321
;321:						other->ammo_medikit = other->maxammo_medikit;
ADDRLP4 32
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 1044
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 1048
ADDP4
INDIRI4
ASGNI4
LABELV $106
line 322
;322:					G_sprint( other, 0, "You gather %.0f medikit ammo\n", self->healamount );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $108
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 564
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 324
;323:// health touch sound
;324:					sound( other, CHAN_ITEM, self->s.v.noise, 1, ATTN_NORM );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
CNSTF4 1065353216
ASGNF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 326
;325:
;326:					stuffcmd( other, "bf\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $21
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 328
;327:
;328:					self->s.v.model = "";
ADDRGP4 self
INDIRP4
CNSTI4 220
ADDP4
ADDRGP4 $22
ASGNP4
line 329
;329:					self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 331
;330:
;331:					if ( deathmatch != 2 )
ADDRGP4 deathmatch
INDIRI4
CNSTI4 2
EQI4 $109
line 332
;332:					{
line 333
;333:						if ( deathmatch )
ADDRGP4 deathmatch
INDIRI4
CNSTI4 0
EQI4 $111
line 334
;334:							self->s.v.nextthink = g_globalvars.time + 20;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1101004800
ADDF4
ASGNF4
LABELV $111
line 335
;335:						self->s.v.think = ( func_t ) SUB_regen;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_regen
CVPU4 4
CVUI4 4
ASGNI4
line 336
;336:					}
LABELV $109
line 337
;337:					activator = other;
ADDRGP4 activator
ADDRGP4 other
INDIRP4
ASGNP4
line 338
;338:					SUB_UseTargets(  );
ADDRGP4 SUB_UseTargets
CALLV
pop
line 339
;339:				}
line 340
;340:			}
line 341
;341:			return;
ADDRGP4 $80
JUMPV
LABELV $100
line 343
;342:		}
;343:	}
LABELV $93
line 344
;344:	if ( ( other->tfstate & TFSTATE_INFECTED ) && self->healamount > 80 )
ADDRGP4 other
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $114
ADDRGP4 self
INDIRP4
CNSTI4 564
ADDP4
INDIRF4
CNSTF4 1117782016
LEF4 $114
line 345
;345:	{
line 346
;346:		G_sprint( other, 1, "You have been healed of your infection!" );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $116
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 347
;347:		other->tfstate -= ( other->tfstate & TFSTATE_INFECTED );
ADDRLP4 16
ADDRGP4 other
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRI4
ADDRLP4 20
INDIRI4
CNSTI4 16
BANDI4
SUBI4
ASGNI4
line 348
;348:	} else
ADDRGP4 $115
JUMPV
LABELV $114
line 349
;349:	{
line 350
;350:		G_sprint( other, PRINT_LOW, "You receive %.0f health\n", self->healamount );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $117
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 564
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 351
;351:	}
LABELV $115
line 353
;352:// health touch sound
;353:	sound( other, CHAN_ITEM, self->s.v.noise, 1, ATTN_NORM );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 355
;354:
;355:	stuffcmd( other, "bf\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $21
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 357
;356:
;357:	self->s.v.model = "";
ADDRGP4 self
INDIRP4
CNSTI4 220
ADDP4
ADDRGP4 $22
ASGNP4
line 358
;358:	self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 361
;359:
;360:	// Megahealth = rot down the player's super health
;361:	if ( self->healtype == 2 )
ADDRGP4 self
INDIRP4
CNSTI4 568
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $118
line 362
;362:	{
line 363
;363:		other->s.v.items = ( int ) other->s.v.items | IT_SUPERHEALTH;
ADDRLP4 20
ADDRGP4 other
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 65536
BORI4
CVIF4 4
ASGNF4
line 364
;364:		self->s.v.nextthink = g_globalvars.time + 5;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 365
;365:		self->s.v.think = ( func_t ) item_megahealth_rot;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 item_megahealth_rot
CVPU4 4
CVUI4 4
ASGNI4
line 366
;366:		self->s.v.owner = EDICT_TO_PROG( other );
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
ADDRGP4 other
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 367
;367:	} else
ADDRGP4 $119
JUMPV
LABELV $118
line 368
;368:	{
line 369
;369:		if ( deathmatch != 2 )	// deathmatch 2 is the silly old rules
ADDRGP4 deathmatch
INDIRI4
CNSTI4 2
EQI4 $121
line 370
;370:		{
line 371
;371:			if ( deathmatch )
ADDRGP4 deathmatch
INDIRI4
CNSTI4 0
EQI4 $123
line 372
;372:				self->s.v.nextthink = g_globalvars.time + 20;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1101004800
ADDF4
ASGNF4
LABELV $123
line 373
;373:			self->s.v.think = ( func_t ) SUB_regen;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_regen
CVPU4 4
CVUI4 4
ASGNI4
line 374
;374:		}
LABELV $121
line 375
;375:	}
LABELV $119
line 376
;376:	activator = other;
ADDRGP4 activator
ADDRGP4 other
INDIRP4
ASGNP4
line 377
;377:	SUB_UseTargets(  );	// fire all targets / killtargets
ADDRGP4 SUB_UseTargets
CALLV
pop
line 378
;378:}
LABELV $80
endproc health_touch 40 20
export item_megahealth_rot
proc item_megahealth_rot 16 8
line 381
;379:
;380:void item_megahealth_rot(  )
;381:{
line 382
;382:	other = PROG_TO_EDICT( self->s.v.owner );
ADDRGP4 other
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 383
;383:	if ( other->s.v.health > other->s.v.max_health )
ADDRLP4 0
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRF4
LEF4 $127
line 384
;384:	{
line 385
;385:		other->s.v.health -= 1;
ADDRLP4 4
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 386
;386:		self->s.v.nextthink = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 387
;387:		return;
ADDRGP4 $126
JUMPV
LABELV $127
line 391
;388:	}
;389:// it is possible for a player to die and respawn between rots, so don't
;390:// just blindly subtract the flag off
;391:	other->s.v.items -= ( int ) other->s.v.items & IT_SUPERHEALTH;
ADDRLP4 4
ADDRGP4 other
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRF4
ADDRLP4 8
INDIRF4
CVFI4 4
CNSTI4 65536
BANDI4
CVIF4 4
SUBF4
ASGNF4
line 392
;392:	if ( streq( self->s.v.classname, "medikit_rot" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $132
ARGP4
ADDRLP4 12
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $130
line 393
;393:	{
line 394
;394:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 395
;395:		return;
ADDRGP4 $126
JUMPV
LABELV $130
line 397
;396:	}
;397:	if ( deathmatch != 2 )	// deathmatch 2 is silly old rules
ADDRGP4 deathmatch
INDIRI4
CNSTI4 2
EQI4 $133
line 398
;398:	{
line 399
;399:		self->s.v.nextthink = g_globalvars.time + 20;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1101004800
ADDF4
ASGNF4
line 400
;400:		self->s.v.think = ( func_t ) SUB_regen;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_regen
CVPU4 4
CVUI4 4
ASGNI4
line 401
;401:	}
LABELV $133
line 402
;402:}
LABELV $126
endproc item_megahealth_rot 16 8
export armor_touch
proc armor_touch 72 20
line 412
;403:
;404:/*
;405:===============================================================================
;406:
;407:ARMOR
;408:
;409:===============================================================================
;410:*/
;411:void armor_touch(  )
;412:{
line 413
;413:	float   type = 0, value = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRLP4 4
CNSTF4 0
ASGNF4
line 414
;414:	int     bit = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 417
;415:	gedict_t *oldself;
;416:
;417:	if ( other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $137
line 418
;418:		return;
ADDRGP4 $136
JUMPV
LABELV $137
line 419
;419:	if ( strneq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $18
ARGP4
ADDRLP4 16
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $139
line 420
;420:		return;
ADDRGP4 $136
JUMPV
LABELV $139
line 421
;421:	if ( other->is_feigning )
ADDRGP4 other
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
EQI4 $141
line 422
;422:		return;
ADDRGP4 $136
JUMPV
LABELV $141
line 423
;423:	if ( ( other->tfstate & TFSTATE_CANT_MOVE ) || ( other->tfstate & TFSTATE_AIMING ) )
ADDRLP4 20
ADDRGP4 other
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 65536
BANDI4
ADDRLP4 24
INDIRI4
NEI4 $145
ADDRLP4 20
INDIRI4
CNSTI4 2048
BANDI4
ADDRLP4 24
INDIRI4
EQI4 $143
LABELV $145
line 424
;424:		return;
ADDRGP4 $136
JUMPV
LABELV $143
line 425
;425:	if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $146
line 426
;426:		return;
ADDRGP4 $136
JUMPV
LABELV $146
line 427
;427:	if ( !strcmp( self->s.v.classname, "item_armor1" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 28
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $150
line 428
;428:	{
line 429
;429:		type = 0.3;
ADDRLP4 0
CNSTF4 1050253722
ASGNF4
line 430
;430:		value = 100;
ADDRLP4 4
CNSTF4 1120403456
ASGNF4
line 431
;431:		bit = IT_ARMOR1;
ADDRLP4 8
CNSTI4 8192
ASGNI4
line 432
;432:	}
LABELV $150
line 433
;433:	if ( !strcmp( self->s.v.classname, "item_armor2" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $155
ARGP4
ADDRLP4 32
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $153
line 434
;434:	{
line 435
;435:		type = 0.6;
ADDRLP4 0
CNSTF4 1058642330
ASGNF4
line 436
;436:		value = 150;
ADDRLP4 4
CNSTF4 1125515264
ASGNF4
line 437
;437:		bit = IT_ARMOR2;
ADDRLP4 8
CNSTI4 16384
ASGNI4
line 438
;438:	}
LABELV $153
line 439
;439:	if ( !strcmp( self->s.v.classname, "item_armorInv" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $158
ARGP4
ADDRLP4 36
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $156
line 440
;440:	{
line 441
;441:		type = 0.8;
ADDRLP4 0
CNSTF4 1061997773
ASGNF4
line 442
;442:		value = 300;
ADDRLP4 4
CNSTF4 1133903872
ASGNF4
line 443
;443:		bit = IT_ARMOR3;
ADDRLP4 8
CNSTI4 32768
ASGNI4
line 444
;444:	}
LABELV $156
line 445
;445:	if ( other->s.v.armortype * other->s.v.armorvalue >= type * value )
ADDRLP4 40
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 424
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
MULF4
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
LTF4 $159
line 446
;446:	{
line 447
;447:		if ( other->playerclass == PC_ENGINEER )
ADDRGP4 other
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 9
NEI4 $136
line 448
;448:		{
line 449
;449:			if ( other->s.v.ammo_cells >= other->maxammo_cells )
ADDRLP4 44
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 912
ADDP4
INDIRI4
CVIF4 4
LTF4 $162
line 450
;450:				return;
ADDRGP4 $136
JUMPV
line 451
;451:		} else
line 452
;452:			return;
LABELV $162
line 453
;453:	}
LABELV $159
line 454
;454:	if ( other->armor_allowed * other->maxarmor <= type * value )
ADDRLP4 44
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 924
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 928
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
GTF4 $165
line 455
;455:	{
line 456
;456:		if ( other->armor_allowed == other->s.v.armortype )
ADDRLP4 48
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 924
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 424
ADDP4
INDIRF4
NEF4 $167
line 457
;457:		{
line 458
;458:			if ( other->maxarmor == other->s.v.armorvalue )
ADDRLP4 52
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 928
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 52
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
NEF4 $169
line 459
;459:			{
line 460
;460:				if ( other->playerclass == PC_ENGINEER )
ADDRGP4 other
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 9
NEI4 $136
line 461
;461:				{
line 462
;462:					if ( other->s.v.ammo_cells >= other->maxammo_cells )
ADDRLP4 56
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 912
ADDP4
INDIRI4
CVIF4 4
LTF4 $172
line 463
;463:						return;
ADDRGP4 $136
JUMPV
line 464
;464:				} else
line 465
;465:					return;
LABELV $172
line 466
;466:			}
LABELV $169
line 467
;467:		}
LABELV $167
line 468
;468:	}
LABELV $165
line 469
;469:	if ( type > other->armor_allowed )
ADDRLP4 0
INDIRF4
ADDRGP4 other
INDIRP4
CNSTI4 924
ADDP4
INDIRF4
LEF4 $175
line 470
;470:	{
line 471
;471:		type = other->armor_allowed;
ADDRLP4 0
ADDRGP4 other
INDIRP4
CNSTI4 924
ADDP4
INDIRF4
ASGNF4
line 472
;472:		if ( type == (float)0.8 )
ADDRLP4 0
INDIRF4
CNSTF4 1061997773
NEF4 $177
line 473
;473:			bit = IT_ARMOR3;
ADDRLP4 8
CNSTI4 32768
ASGNI4
ADDRGP4 $178
JUMPV
LABELV $177
line 475
;474:		else
;475:		{
line 476
;476:			if ( type == (float)0.6 )
ADDRLP4 0
INDIRF4
CNSTF4 1058642330
NEF4 $179
line 477
;477:				bit = IT_ARMOR2;
ADDRLP4 8
CNSTI4 16384
ASGNI4
ADDRGP4 $180
JUMPV
LABELV $179
line 479
;478:			else
;479:			{
line 480
;480:				if ( type == (float)0.3 )
ADDRLP4 0
INDIRF4
CNSTF4 1050253722
NEF4 $181
line 481
;481:					bit = IT_ARMOR1;
ADDRLP4 8
CNSTI4 8192
ASGNI4
LABELV $181
line 482
;482:			}
LABELV $180
line 483
;483:		}
LABELV $178
line 484
;484:	}
LABELV $175
line 485
;485:	G_sprint( other, PRINT_LOW, "You got armor\n" );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $183
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 486
;486:	if ( value > other->maxarmor )
ADDRLP4 4
INDIRF4
ADDRGP4 other
INDIRP4
CNSTI4 928
ADDP4
INDIRI4
CVIF4 4
LEF4 $184
line 487
;487:	{
line 488
;488:		if ( other->playerclass == PC_ENGINEER && other->s.v.ammo_cells < other->maxammo_cells )
ADDRLP4 48
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 9
NEI4 $186
ADDRLP4 48
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 912
ADDP4
INDIRI4
CVIF4 4
GEF4 $186
line 489
;489:		{
line 490
;490:			G_sprint( other, 0, "%.0f metal\n", value - other->maxarmor );
ADDRLP4 52
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $188
ARGP4
ADDRLP4 4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 928
ADDP4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 491
;491:			other->s.v.ammo_cells += value - other->maxarmor;
ADDRLP4 56
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 60
ADDRLP4 56
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 928
ADDP4
INDIRI4
CVIF4 4
SUBF4
ADDF4
ASGNF4
line 492
;492:			if ( other->s.v.ammo_cells > other->maxammo_cells )
ADDRLP4 64
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 912
ADDP4
INDIRI4
CVIF4 4
LEF4 $189
line 493
;493:				other->s.v.ammo_cells = other->maxammo_cells;
ADDRLP4 68
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 332
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 912
ADDP4
INDIRI4
CVIF4 4
ASGNF4
LABELV $189
line 494
;494:			oldself = self;
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
line 495
;495:			self = other;
ADDRGP4 self
ADDRGP4 other
INDIRP4
ASGNP4
line 496
;496:			W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 497
;497:			self = oldself;
ADDRGP4 self
ADDRLP4 12
INDIRP4
ASGNP4
line 498
;498:		}
LABELV $186
line 499
;499:		value = other->maxarmor;
ADDRLP4 4
ADDRGP4 other
INDIRP4
CNSTI4 928
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 500
;500:	}
LABELV $184
line 502
;501:
;502:	if ( other->s.v.armortype * other->s.v.armorvalue < type * value )
ADDRLP4 48
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 424
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
MULF4
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
GEF4 $191
line 503
;503:	{
line 504
;504:		other->s.v.armortype = type;
ADDRGP4 other
INDIRP4
CNSTI4 424
ADDP4
ADDRLP4 0
INDIRF4
ASGNF4
line 505
;505:		other->s.v.armorvalue = value;
ADDRGP4 other
INDIRP4
CNSTI4 428
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 506
;506:		other->s.v.items = (int) other->s.v.items - ( ( int ) other->s.v.items & ( IT_ARMOR1 | IT_ARMOR2 | IT_ARMOR3 ) ) + bit;
ADDRLP4 52
ADDRGP4 other
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 56
ADDRLP4 52
INDIRP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 52
INDIRP4
ADDRLP4 56
INDIRI4
ADDRLP4 56
INDIRI4
CNSTI4 57344
BANDI4
SUBI4
ADDRLP4 8
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 507
;507:	}
LABELV $191
line 508
;508:	if ( self->armorclass > 0 )
ADDRGP4 self
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
CNSTI4 0
LEI4 $193
line 509
;509:		other->armorclass = self->armorclass;
ADDRLP4 52
CNSTI4 828
ASGNI4
ADDRGP4 other
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
ASGNI4
LABELV $193
line 510
;510:	self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 511
;511:	self->s.v.model = "";
ADDRGP4 self
INDIRP4
CNSTI4 220
ADDP4
ADDRGP4 $22
ASGNP4
line 512
;512:	if ( deathmatch != 2 )
ADDRGP4 deathmatch
INDIRI4
CNSTI4 2
EQI4 $195
line 513
;513:		self->s.v.nextthink = g_globalvars.time + 20;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1101004800
ADDF4
ASGNF4
LABELV $195
line 514
;514:	if ( coop )
ADDRGP4 coop
INDIRI4
CNSTI4 0
EQI4 $198
line 515
;515:		self->s.v.nextthink = g_globalvars.time + 40;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1109393408
ADDF4
ASGNF4
LABELV $198
line 516
;516:	self->s.v.think = ( func_t ) SUB_regen;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_regen
CVPU4 4
CVUI4 4
ASGNI4
line 517
;517:	sound( other, 3, "items/armor1.wav", 1, 1 );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $201
ARGP4
ADDRLP4 56
CNSTF4 1065353216
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 518
;518:	stuffcmd( other, "bf\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $21
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 519
;519:	activator = other;
ADDRGP4 activator
ADDRGP4 other
INDIRP4
ASGNP4
line 520
;520:	SUB_UseTargets(  );
ADDRGP4 SUB_UseTargets
CALLV
pop
line 522
;521:
;522:}
LABELV $136
endproc armor_touch 72 20
export SP_item_armor1
proc SP_item_armor1 12 28
line 528
;523:
;524:/*QUAKED item_armor1 (0 .5 .8) (-16 -16 0) (16 16 32)
;525:*/
;526:
;527:void SP_item_armor1(  )
;528:{
line 529
;529:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $203
line 530
;530:	{
line 531
;531:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 532
;532:		return;
ADDRGP4 $202
JUMPV
LABELV $203
line 534
;533:	}
;534:	self->s.v.touch = ( func_t ) armor_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 armor_touch
CVPU4 4
CVUI4 4
ASGNI4
line 535
;535:	trap_precache_model( "progs/armor.mdl" );
ADDRGP4 $205
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 536
;536:	setmodel( self, "progs/armor.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $205
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 537
;537:	self->s.v.skin = 0;
ADDRGP4 self
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 0
ASGNF4
line 538
;538:	setsize( self, -16, -16, 0, 16, 16, 56 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 4
CNSTF4 3246391296
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 8
CNSTF4 1098907648
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1113587712
ARGF4
ADDRGP4 setsize
CALLV
pop
line 539
;539:	StartItem( );
ADDRGP4 StartItem
CALLV
pop
line 540
;540:}
LABELV $202
endproc SP_item_armor1 12 28
export SP_item_armor2
proc SP_item_armor2 12 28
line 547
;541:
;542:
;543:/*QUAKED item_armor2 (0 .5 .8) (-16 -16 0) (16 16 32)
;544:*/
;545:
;546:void SP_item_armor2(  )
;547:{
line 548
;548:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $207
line 549
;549:	{
line 550
;550:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 551
;551:		return;
ADDRGP4 $206
JUMPV
LABELV $207
line 553
;552:	}
;553:	self->s.v.touch = ( func_t ) armor_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 armor_touch
CVPU4 4
CVUI4 4
ASGNI4
line 554
;554:	trap_precache_model( "progs/armor.mdl" );
ADDRGP4 $205
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 555
;555:	setmodel( self, "progs/armor.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $205
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 556
;556:	self->s.v.skin = 1;
ADDRGP4 self
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 1065353216
ASGNF4
line 557
;557:	setsize( self, -16, -16, 0, 16, 16, 56 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 4
CNSTF4 3246391296
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 8
CNSTF4 1098907648
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1113587712
ARGF4
ADDRGP4 setsize
CALLV
pop
line 558
;558:	StartItem( );
ADDRGP4 StartItem
CALLV
pop
line 559
;559:}
LABELV $206
endproc SP_item_armor2 12 28
export SP_item_armorInv
proc SP_item_armorInv 12 28
line 565
;560:
;561:/*QUAKED item_armorInv (0 .5 .8) (-16 -16 0) (16 16 32)
;562:*/
;563:
;564:void SP_item_armorInv(  )
;565:{
line 566
;566:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $210
line 567
;567:	{
line 568
;568:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 569
;569:		return;
ADDRGP4 $209
JUMPV
LABELV $210
line 571
;570:	}
;571:	self->s.v.touch = ( func_t ) armor_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 armor_touch
CVPU4 4
CVUI4 4
ASGNI4
line 572
;572:	trap_precache_model( "progs/armor.mdl" );
ADDRGP4 $205
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 573
;573:	setmodel( self, "progs/armor.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $205
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 574
;574:	self->s.v.skin = 2;
ADDRGP4 self
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 1073741824
ASGNF4
line 575
;575:	setsize( self, -16, -16, 0, 16, 16, 56 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 4
CNSTF4 3246391296
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 8
CNSTF4 1098907648
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1113587712
ARGF4
ADDRGP4 setsize
CALLV
pop
line 576
;576:	StartItem( );
ADDRGP4 StartItem
CALLV
pop
line 577
;577:}
LABELV $209
endproc SP_item_armorInv 12 28
export bound_other_ammo
proc bound_other_ammo 112 8
line 588
;578:
;579:/*
;580:===============================================================================
;581:
;582:WEAPONS
;583:
;584:===============================================================================
;585:*/
;586:
;587:void bound_other_ammo( gedict_t * p )
;588:{
line 589
;589:	if ( p->s.v.ammo_shells > TeamFortress_GetMaxAmmo( p, IT_SHELLS ) )
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 4
ADDRGP4 TeamFortress_GetMaxAmmo
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
LEF4 $213
line 590
;590:		p->s.v.ammo_shells = TeamFortress_GetMaxAmmo( p, IT_SHELLS );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 12
ADDRGP4 TeamFortress_GetMaxAmmo
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 320
ADDP4
ADDRLP4 12
INDIRI4
CVIF4 4
ASGNF4
LABELV $213
line 591
;591:	if ( p->s.v.ammo_nails > TeamFortress_GetMaxAmmo( p, IT_NAILS ) )
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 512
ARGI4
ADDRLP4 20
ADDRGP4 TeamFortress_GetMaxAmmo
CALLI4
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
ADDRLP4 20
INDIRI4
CVIF4 4
LEF4 $215
line 592
;592:		p->s.v.ammo_nails = TeamFortress_GetMaxAmmo( p, IT_NAILS );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 512
ARGI4
ADDRLP4 28
ADDRGP4 TeamFortress_GetMaxAmmo
CALLI4
ASGNI4
ADDRLP4 24
INDIRP4
CNSTI4 324
ADDP4
ADDRLP4 28
INDIRI4
CVIF4 4
ASGNF4
LABELV $215
line 593
;593:	if ( p->s.v.ammo_rockets > TeamFortress_GetMaxAmmo( p, IT_ROCKETS ) )
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 36
ADDRGP4 TeamFortress_GetMaxAmmo
CALLI4
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ADDRLP4 36
INDIRI4
CVIF4 4
LEF4 $217
line 594
;594:		p->s.v.ammo_rockets = TeamFortress_GetMaxAmmo( p, IT_ROCKETS );
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 44
ADDRGP4 TeamFortress_GetMaxAmmo
CALLI4
ASGNI4
ADDRLP4 40
INDIRP4
CNSTI4 328
ADDP4
ADDRLP4 44
INDIRI4
CVIF4 4
ASGNF4
LABELV $217
line 595
;595:	if ( p->s.v.ammo_cells > TeamFortress_GetMaxAmmo( p, IT_CELLS ) )
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 52
ADDRGP4 TeamFortress_GetMaxAmmo
CALLI4
ASGNI4
ADDRLP4 48
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ADDRLP4 52
INDIRI4
CVIF4 4
LEF4 $219
line 596
;596:		p->s.v.ammo_cells = TeamFortress_GetMaxAmmo( p, IT_CELLS );
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 60
ADDRGP4 TeamFortress_GetMaxAmmo
CALLI4
ASGNI4
ADDRLP4 56
INDIRP4
CNSTI4 332
ADDP4
ADDRLP4 60
INDIRI4
CVIF4 4
ASGNF4
LABELV $219
line 597
;597:	if ( p->ammo_medikit > p->maxammo_medikit )
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 1044
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 1048
ADDP4
INDIRI4
LEI4 $221
line 598
;598:		p->ammo_medikit = p->maxammo_medikit;
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 1044
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 1048
ADDP4
INDIRI4
ASGNI4
LABELV $221
line 599
;599:	if ( p->s.v.armorvalue > p->maxarmor )
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 928
ADDP4
INDIRI4
CVIF4 4
LEF4 $223
line 600
;600:		p->s.v.armorvalue = p->maxarmor;
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 428
ADDP4
ADDRLP4 76
INDIRP4
CNSTI4 928
ADDP4
INDIRI4
CVIF4 4
ASGNF4
LABELV $223
line 601
;601:	if ( p->ammo_detpack > p->maxammo_detpack )
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 1052
ADDP4
INDIRI4
ADDRLP4 80
INDIRP4
CNSTI4 1056
ADDP4
INDIRI4
LEI4 $225
line 602
;602:		p->ammo_detpack = p->maxammo_detpack;
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 1052
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 1056
ADDP4
INDIRI4
ASGNI4
LABELV $225
line 604
;603:
;604:	if ( p->no_grenades_1 > 4 )
ADDRFP4 0
INDIRP4
CNSTI4 840
ADDP4
INDIRI4
CNSTI4 4
LEI4 $227
line 605
;605:		p->no_grenades_1 = 4;
ADDRFP4 0
INDIRP4
CNSTI4 840
ADDP4
CNSTI4 4
ASGNI4
LABELV $227
line 606
;606:	if ( p->no_grenades_2 > 4 )
ADDRFP4 0
INDIRP4
CNSTI4 844
ADDP4
INDIRI4
CNSTI4 4
LEI4 $229
line 607
;607:		p->no_grenades_2 = 4;
ADDRFP4 0
INDIRP4
CNSTI4 844
ADDP4
CNSTI4 4
ASGNI4
LABELV $229
line 608
;608:	if ( p->tp_grenades_1 == GR_TYPE_NAIL && p->no_grenades_1 > 2 )
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 3
NEI4 $231
ADDRLP4 88
INDIRP4
CNSTI4 840
ADDP4
INDIRI4
CNSTI4 2
LEI4 $231
line 609
;609:		p->no_grenades_1 = 2;
ADDRFP4 0
INDIRP4
CNSTI4 840
ADDP4
CNSTI4 2
ASGNI4
LABELV $231
line 610
;610:	if ( p->tp_grenades_2 == GR_TYPE_NAIL && p->no_grenades_2 > 2 )
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 852
ADDP4
INDIRI4
CNSTI4 3
NEI4 $233
ADDRLP4 92
INDIRP4
CNSTI4 844
ADDP4
INDIRI4
CNSTI4 2
LEI4 $233
line 611
;611:		p->no_grenades_2 = 2;
ADDRFP4 0
INDIRP4
CNSTI4 844
ADDP4
CNSTI4 2
ASGNI4
LABELV $233
line 612
;612:	if ( p->tp_grenades_1 == GR_TYPE_CONCUSSION && p->no_grenades_1 > 3 )
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 2
NEI4 $235
ADDRLP4 96
INDIRP4
CNSTI4 840
ADDP4
INDIRI4
CNSTI4 3
LEI4 $235
line 613
;613:		p->no_grenades_1 = 3;
ADDRFP4 0
INDIRP4
CNSTI4 840
ADDP4
CNSTI4 3
ASGNI4
LABELV $235
line 614
;614:	if ( p->tp_grenades_2 == GR_TYPE_CONCUSSION && p->no_grenades_2 > 3 )
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 852
ADDP4
INDIRI4
CNSTI4 2
NEI4 $237
ADDRLP4 100
INDIRP4
CNSTI4 844
ADDP4
INDIRI4
CNSTI4 3
LEI4 $237
line 615
;615:		p->no_grenades_2 = 3;
ADDRFP4 0
INDIRP4
CNSTI4 844
ADDP4
CNSTI4 3
ASGNI4
LABELV $237
line 616
;616:	if ( p->tp_grenades_1 == GR_TYPE_CALTROPS && p->no_grenades_1 > 3 )
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 10
NEI4 $239
ADDRLP4 104
INDIRP4
CNSTI4 840
ADDP4
INDIRI4
CNSTI4 3
LEI4 $239
line 617
;617:		p->no_grenades_1 = 3;
ADDRFP4 0
INDIRP4
CNSTI4 840
ADDP4
CNSTI4 3
ASGNI4
LABELV $239
line 618
;618:	if ( p->tp_grenades_2 == GR_TYPE_CALTROPS && p->no_grenades_2 > 3 )
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI4 852
ADDP4
INDIRI4
CNSTI4 10
NEI4 $241
ADDRLP4 108
INDIRP4
CNSTI4 844
ADDP4
INDIRI4
CNSTI4 3
LEI4 $241
line 619
;619:		p->no_grenades_2 = 3;
ADDRFP4 0
INDIRP4
CNSTI4 844
ADDP4
CNSTI4 3
ASGNI4
LABELV $241
line 620
;620:}
LABELV $212
endproc bound_other_ammo 112 8
export RankForWeapon
proc RankForWeapon 4 0
line 623
;621:
;622:float RankForWeapon( float w )
;623:{
line 624
;624:	if ( w == WEAP_LIGHTNING )
ADDRFP4 0
INDIRF4
CNSTF4 1199570944
NEF4 $244
line 625
;625:		return 1;
CNSTF4 1065353216
RETF4
ADDRGP4 $243
JUMPV
LABELV $244
line 626
;626:	if ( w == WEAP_ROCKET_LAUNCHER )
ADDRFP4 0
INDIRF4
CNSTF4 1174405120
NEF4 $246
line 627
;627:		return 2;
CNSTF4 1073741824
RETF4
ADDRGP4 $243
JUMPV
LABELV $246
line 628
;628:	if ( w == WEAP_SUPER_NAILGUN )
ADDRFP4 0
INDIRF4
CNSTF4 1149239296
NEF4 $248
line 629
;629:		return 3;
CNSTF4 1077936128
RETF4
ADDRGP4 $243
JUMPV
LABELV $248
line 630
;630:	if ( w == WEAP_GRENADE_LAUNCHER )
ADDRFP4 0
INDIRF4
CNSTF4 1157627904
NEF4 $250
line 631
;631:		return 4;
CNSTF4 1082130432
RETF4
ADDRGP4 $243
JUMPV
LABELV $250
line 632
;632:	if ( w == WEAP_SUPER_SHOTGUN )
ADDRFP4 0
INDIRF4
CNSTF4 1132462080
NEF4 $252
line 633
;633:		return 5;
CNSTF4 1084227584
RETF4
ADDRGP4 $243
JUMPV
LABELV $252
line 634
;634:	if ( w == WEAP_NAILGUN || w == WEAP_MAC10 )
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1140850688
EQF4 $256
ADDRLP4 0
INDIRF4
CNSTF4 1233125376
NEF4 $254
LABELV $256
line 635
;635:		return 6;
CNSTF4 1086324736
RETF4
ADDRGP4 $243
JUMPV
LABELV $254
line 636
;636:	return 7;
CNSTF4 1088421888
RETF4
LABELV $243
endproc RankForWeapon 4 0
export Deathmatch_Weapon
proc Deathmatch_Weapon 0 0
line 640
;637:}
;638:
;639:void Deathmatch_Weapon( float old, float new )
;640:{
line 641
;641:}
LABELV $257
endproc Deathmatch_Weapon 0 0
export Respawn_Item
proc Respawn_Item 4 0
line 647
;642:
;643:
;644:void    ammo_touch(  );
;645:
;646:void Respawn_Item( gedict_t * ritem, gedict_t * act )
;647:{
line 650
;648:	gedict_t *oldself;
;649:
;650:	oldself = self;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
line 651
;651:	self = ritem;
ADDRGP4 self
ADDRFP4 0
INDIRP4
ASGNP4
line 652
;652:	self->s.v.model = "";
ADDRGP4 self
INDIRP4
CNSTI4 220
ADDP4
ADDRGP4 $22
ASGNP4
line 653
;653:	self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 654
;654:	if ( deathmatch != 2 )
ADDRGP4 deathmatch
INDIRI4
CNSTI4 2
EQI4 $259
line 655
;655:		self->s.v.nextthink = g_globalvars.time + 30;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
ADDRGP4 $260
JUMPV
LABELV $259
line 657
;656:	else
;657:	{
line 658
;658:		if ( coop && ritem->s.v.touch == ( func_t ) ammo_touch )
ADDRGP4 coop
INDIRI4
CNSTI4 0
EQI4 $262
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
ADDRGP4 ammo_touch
CVPU4 4
CVUI4 4
NEI4 $262
line 659
;659:			self->s.v.nextthink = g_globalvars.time + 45;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1110704128
ADDF4
ASGNF4
LABELV $262
line 660
;660:	}
LABELV $260
line 661
;661:	self->s.v.think = ( func_t ) SUB_regen;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_regen
CVPU4 4
CVUI4 4
ASGNI4
line 662
;662:	activator = act;
ADDRGP4 activator
ADDRFP4 4
INDIRP4
ASGNP4
line 663
;663:	SUB_UseTargets(  );
ADDRGP4 SUB_UseTargets
CALLV
pop
line 664
;664:	self = oldself;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 665
;665:}
LABELV $258
endproc Respawn_Item 4 0
export weapon_touch
proc weapon_touch 72 20
line 675
;666:
;667:
;668:/*
;669:=============
;670:weapon_touch
;671:=============
;672:*/
;673:
;674:void weapon_touch(  )
;675:{
line 676
;676:	int     hadammo, best, new = 0, old;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 683
;677:	gedict_t *stemp;
;678:	int     leave;
;679:
;680://      char    s[20];
;681:
;682:
;683:	if ( !( ( int ) other->s.v.flags & FL_CLIENT ) )
ADDRGP4 other
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $266
line 684
;684:		return;
ADDRGP4 $265
JUMPV
LABELV $266
line 685
;685:	if ( other->is_feigning )
ADDRGP4 other
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
EQI4 $268
line 686
;686:		return;
ADDRGP4 $265
JUMPV
LABELV $268
line 687
;687:	if ( ( other->tfstate & TFSTATE_CANT_MOVE ) || ( other->tfstate & TFSTATE_AIMING ) )
ADDRLP4 24
ADDRGP4 other
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 65536
BANDI4
ADDRLP4 28
INDIRI4
NEI4 $272
ADDRLP4 24
INDIRI4
CNSTI4 2048
BANDI4
ADDRLP4 28
INDIRI4
EQI4 $270
LABELV $272
line 688
;688:		return;
ADDRGP4 $265
JUMPV
LABELV $270
line 689
;689:	if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $273
line 690
;690:		return;
ADDRGP4 $265
JUMPV
LABELV $273
line 691
;691:	stemp = self;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
line 692
;692:	self = other;
ADDRGP4 self
ADDRGP4 other
INDIRP4
ASGNP4
line 693
;693:	best = W_BestWeapon(  );
ADDRLP4 32
ADDRGP4 W_BestWeapon
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 32
INDIRI4
ASGNI4
line 694
;694:	self = stemp;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 695
;695:	if ( deathmatch == 2 || coop )
ADDRGP4 deathmatch
INDIRI4
CNSTI4 2
EQI4 $279
ADDRGP4 coop
INDIRI4
CNSTI4 0
EQI4 $277
LABELV $279
line 696
;696:		leave = 1;
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $278
JUMPV
LABELV $277
line 698
;697:	else
;698:		leave = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $278
line 699
;699:	if ( !strcmp( self->s.v.classname, "weapon_nailgun" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $282
ARGP4
ADDRLP4 36
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $280
line 700
;700:	{
line 701
;701:		if ( leave && ( other->weapons_carried & WEAP_NAILGUN ) )
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $283
ADDRGP4 other
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 512
BANDI4
ADDRLP4 40
INDIRI4
EQI4 $283
line 702
;702:			return;
ADDRGP4 $265
JUMPV
LABELV $283
line 703
;703:		if ( !TeamFortress_CanGetWeapon( other, WEAP_NAILGUN ) )
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 512
ARGI4
ADDRLP4 44
ADDRGP4 TeamFortress_CanGetWeapon
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $285
line 704
;704:			return;
ADDRGP4 $265
JUMPV
LABELV $285
line 705
;705:		hadammo = other->s.v.ammo_nails;
ADDRLP4 20
ADDRGP4 other
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 706
;706:		new = WEAP_NAILGUN;
ADDRLP4 4
CNSTI4 512
ASGNI4
line 707
;707:		other->s.v.ammo_nails = other->s.v.ammo_nails + 30;
ADDRLP4 48
ADDRGP4 other
INDIRP4
CNSTI4 324
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 708
;708:	} else
ADDRGP4 $281
JUMPV
LABELV $280
line 709
;709:	{
line 710
;710:		if ( streq( self->s.v.classname, "weapon_supernailgun" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $289
ARGP4
ADDRLP4 40
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $287
line 711
;711:		{
line 712
;712:			if ( leave && ( other->weapons_carried & WEAP_SUPER_NAILGUN ) )
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 44
INDIRI4
EQI4 $290
ADDRGP4 other
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
ADDRLP4 44
INDIRI4
EQI4 $290
line 713
;713:				return;
ADDRGP4 $265
JUMPV
LABELV $290
line 714
;714:			if ( !TeamFortress_CanGetWeapon( other, WEAP_SUPER_NAILGUN ) )
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 48
ADDRGP4 TeamFortress_CanGetWeapon
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $292
line 715
;715:				return;
ADDRGP4 $265
JUMPV
LABELV $292
line 716
;716:			hadammo = other->s.v.ammo_rockets;
ADDRLP4 20
ADDRGP4 other
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 717
;717:			new = WEAP_SUPER_NAILGUN;
ADDRLP4 4
CNSTI4 1024
ASGNI4
line 718
;718:			other->s.v.ammo_nails = other->s.v.ammo_nails + 30;
ADDRLP4 52
ADDRGP4 other
INDIRP4
CNSTI4 324
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 719
;719:		} else
ADDRGP4 $288
JUMPV
LABELV $287
line 720
;720:		{
line 721
;721:			if ( streq( self->s.v.classname, "weapon_supershotgun" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $296
ARGP4
ADDRLP4 44
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $294
line 722
;722:			{
line 723
;723:				if ( leave && ( other->weapons_carried & WEAP_SUPER_SHOTGUN ) )
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 48
INDIRI4
EQI4 $297
ADDRGP4 other
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 256
BANDI4
ADDRLP4 48
INDIRI4
EQI4 $297
line 724
;724:					return;
ADDRGP4 $265
JUMPV
LABELV $297
line 725
;725:				if ( !TeamFortress_CanGetWeapon( other, WEAP_SUPER_SHOTGUN ) )
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 52
ADDRGP4 TeamFortress_CanGetWeapon
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $299
line 726
;726:					return;
ADDRGP4 $265
JUMPV
LABELV $299
line 727
;727:				hadammo = other->s.v.ammo_rockets;
ADDRLP4 20
ADDRGP4 other
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 728
;728:				new = WEAP_SUPER_SHOTGUN;
ADDRLP4 4
CNSTI4 256
ASGNI4
line 729
;729:				other->s.v.ammo_shells = other->s.v.ammo_shells + 5;
ADDRLP4 56
ADDRGP4 other
INDIRP4
CNSTI4 320
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 730
;730:			} else
ADDRGP4 $295
JUMPV
LABELV $294
line 731
;731:			{
line 732
;732:				if ( streq( self->s.v.classname, "weapon_rocketlauncher" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $303
ARGP4
ADDRLP4 48
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $301
line 733
;733:				{
line 734
;734:					if ( leave && ( other->weapons_carried & WEAP_ROCKET_LAUNCHER ) )
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 52
INDIRI4
EQI4 $304
ADDRGP4 other
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
ADDRLP4 52
INDIRI4
EQI4 $304
line 735
;735:						return;
ADDRGP4 $265
JUMPV
LABELV $304
line 736
;736:					if ( !TeamFortress_CanGetWeapon( other, WEAP_ROCKET_LAUNCHER ) )
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 8192
ARGI4
ADDRLP4 56
ADDRGP4 TeamFortress_CanGetWeapon
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $306
line 737
;737:						return;
ADDRGP4 $265
JUMPV
LABELV $306
line 738
;738:					hadammo = other->s.v.ammo_rockets;
ADDRLP4 20
ADDRGP4 other
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 739
;739:					new = WEAP_ROCKET_LAUNCHER;
ADDRLP4 4
CNSTI4 8192
ASGNI4
line 740
;740:					other->s.v.ammo_rockets = other->s.v.ammo_rockets + 5;
ADDRLP4 60
ADDRGP4 other
INDIRP4
CNSTI4 328
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 741
;741:				} else
ADDRGP4 $302
JUMPV
LABELV $301
line 742
;742:				{
line 743
;743:					if ( streq( self->s.v.classname, "weapon_grenadelauncher" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $310
ARGP4
ADDRLP4 52
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $308
line 744
;744:					{
line 745
;745:						if ( leave && ( other->weapons_carried & WEAP_GRENADE_LAUNCHER ) )
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 56
INDIRI4
EQI4 $311
ADDRGP4 other
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
ADDRLP4 56
INDIRI4
EQI4 $311
line 746
;746:							return;
ADDRGP4 $265
JUMPV
LABELV $311
line 747
;747:						if ( !TeamFortress_CanGetWeapon( other, WEAP_GRENADE_LAUNCHER ) )
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 60
ADDRGP4 TeamFortress_CanGetWeapon
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $313
line 748
;748:							return;
ADDRGP4 $265
JUMPV
LABELV $313
line 749
;749:						hadammo = other->s.v.ammo_rockets;
ADDRLP4 20
ADDRGP4 other
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 750
;750:						new = WEAP_GRENADE_LAUNCHER;
ADDRLP4 4
CNSTI4 2048
ASGNI4
line 751
;751:						other->s.v.ammo_rockets = other->s.v.ammo_rockets + 5;
ADDRLP4 64
ADDRGP4 other
INDIRP4
CNSTI4 328
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 752
;752:					} else
ADDRGP4 $309
JUMPV
LABELV $308
line 753
;753:					{
line 754
;754:						if ( streq( self->s.v.classname, "weapon_lightning" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $317
ARGP4
ADDRLP4 56
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $315
line 755
;755:						{
line 756
;756:							if ( leave && ( other->weapons_carried & WEAP_LIGHTNING ) )
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $318
ADDRGP4 other
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
CNSTI4 65536
BANDI4
ADDRLP4 60
INDIRI4
EQI4 $318
line 757
;757:								return;
ADDRGP4 $265
JUMPV
LABELV $318
line 758
;758:							if ( !TeamFortress_CanGetWeapon( other, WEAP_LIGHTNING ) )
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 65536
ARGI4
ADDRLP4 64
ADDRGP4 TeamFortress_CanGetWeapon
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $320
line 759
;759:								return;
ADDRGP4 $265
JUMPV
LABELV $320
line 760
;760:							hadammo = other->s.v.ammo_rockets;
ADDRLP4 20
ADDRGP4 other
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 761
;761:							new = WEAP_LIGHTNING;
ADDRLP4 4
CNSTI4 65536
ASGNI4
line 762
;762:							other->s.v.ammo_cells = other->s.v.ammo_cells + 15;
ADDRLP4 68
ADDRGP4 other
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 763
;763:						} else
ADDRGP4 $316
JUMPV
LABELV $315
line 764
;764:							G_Error( "weapon_touch: unknown classname" );
ADDRGP4 $322
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $316
line 765
;765:					}
LABELV $309
line 766
;766:				}
LABELV $302
line 767
;767:			}
LABELV $295
line 768
;768:		}
LABELV $288
line 769
;769:	}
LABELV $281
line 770
;770:	G_sprint( other, PRINT_LOW, "You got the %s\n", self->s.v.netname );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $323
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 772
;771:// weapon touch sound
;772:	sound( other, CHAN_ITEM, "weapons/pkup.wav", 1, ATTN_NORM );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $324
ARGP4
ADDRLP4 40
CNSTF4 1065353216
ASGNF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 773
;773:	stuffcmd( other, "bf\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $21
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 775
;774:
;775:	bound_other_ammo( other );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 bound_other_ammo
CALLV
pop
line 778
;776:
;777:// change to the weapon
;778:	old = other->weapons_carried;
ADDRLP4 12
ADDRGP4 other
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
ASGNI4
line 780
;779:
;780:	other->weapons_carried = other->weapons_carried | new;
ADDRLP4 44
ADDRGP4 other
INDIRP4
CNSTI4 1028
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
BORI4
ASGNI4
line 781
;781:	stemp = self;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
line 782
;782:	self = other;
ADDRGP4 self
ADDRGP4 other
INDIRP4
ASGNP4
line 783
;783:	Deathmatch_Weapon( old, new );
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Deathmatch_Weapon
CALLV
pop
line 784
;784:	W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 785
;785:	self = stemp;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 786
;786:	if ( leave )
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $325
line 787
;787:		return;
ADDRGP4 $265
JUMPV
LABELV $325
line 788
;788:	Respawn_Item( self, other );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 Respawn_Item
CALLV
pop
line 789
;789:}
LABELV $265
endproc weapon_touch 72 20
export SP_weapon_supershotgun
proc SP_weapon_supershotgun 12 28
line 795
;790:
;791:/*QUAKED weapon_supershotgun (0 .5 .8) (-16 -16 0) (16 16 32)
;792:*/
;793:
;794:void SP_weapon_supershotgun(  )
;795:{
line 796
;796:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $328
line 797
;797:	{
line 798
;798:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 799
;799:		return;
ADDRGP4 $327
JUMPV
LABELV $328
line 801
;800:	}
;801:	trap_precache_model( "progs/g_shot.mdl" );
ADDRGP4 $330
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 802
;802:	setmodel( self, "progs/g_shot.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $330
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 804
;803:
;804:	self->s.v.weapon = IT_SUPER_SHOTGUN;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1073741824
ASGNF4
line 805
;805:	self->s.v.netname = "Double-barrelled Shotgun";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $331
ASGNP4
line 806
;806:	self->s.v.touch = ( func_t ) weapon_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 weapon_touch
CVPU4 4
CVUI4 4
ASGNI4
line 808
;807:
;808:	setsize( self, -16, -16, 0, 16, 16, 56 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 4
CNSTF4 3246391296
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 8
CNSTF4 1098907648
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1113587712
ARGF4
ADDRGP4 setsize
CALLV
pop
line 810
;809:
;810:	StartItem(  );
ADDRGP4 StartItem
CALLV
pop
line 811
;811:}
LABELV $327
endproc SP_weapon_supershotgun 12 28
export SP_weapon_nailgun
proc SP_weapon_nailgun 12 28
line 818
;812:
;813:
;814:/*QUAKED weapon_nailgun (0 .5 .8) (-16 -16 0) (16 16 32)
;815:*/
;816:
;817:void SP_weapon_nailgun(  )
;818:{
line 819
;819:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $333
line 820
;820:	{
line 821
;821:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 822
;822:		return;
ADDRGP4 $332
JUMPV
LABELV $333
line 824
;823:	}
;824:	trap_precache_model( "progs/g_nail.mdl" );
ADDRGP4 $335
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 825
;825:	setmodel( self, "progs/g_nail.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $335
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 826
;826:	self->s.v.weapon = IT_NAILGUN;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1082130432
ASGNF4
line 827
;827:	self->s.v.netname = "nailgun";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $336
ASGNP4
line 828
;828:	self->s.v.touch = ( func_t ) weapon_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 weapon_touch
CVPU4 4
CVUI4 4
ASGNI4
line 829
;829:	setsize( self, -16, -16, 0, 16, 16, 56 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 4
CNSTF4 3246391296
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 8
CNSTF4 1098907648
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1113587712
ARGF4
ADDRGP4 setsize
CALLV
pop
line 830
;830:	StartItem(  );
ADDRGP4 StartItem
CALLV
pop
line 831
;831:}
LABELV $332
endproc SP_weapon_nailgun 12 28
export SP_weapon_supernailgun
proc SP_weapon_supernailgun 12 28
line 837
;832:
;833:/*QUAKED weapon_supernailgun (0 .5 .8) (-16 -16 0) (16 16 32)
;834:*/
;835:
;836:void SP_weapon_supernailgun(  )
;837:{
line 838
;838:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $338
line 839
;839:	{
line 840
;840:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 841
;841:		return;
ADDRGP4 $337
JUMPV
LABELV $338
line 843
;842:	}
;843:	trap_precache_model( "progs/g_nail2.mdl" );
ADDRGP4 $340
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 844
;844:	setmodel( self, "progs/g_nail2.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $340
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 845
;845:	self->s.v.weapon = IT_SUPER_NAILGUN;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1090519040
ASGNF4
line 846
;846:	self->s.v.netname = "Super Nailgun";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $341
ASGNP4
line 847
;847:	self->s.v.touch = ( func_t ) weapon_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 weapon_touch
CVPU4 4
CVUI4 4
ASGNI4
line 848
;848:	setsize( self, -16, -16, 0, 16, 16, 56 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 4
CNSTF4 3246391296
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 8
CNSTF4 1098907648
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1113587712
ARGF4
ADDRGP4 setsize
CALLV
pop
line 849
;849:	StartItem(  );
ADDRGP4 StartItem
CALLV
pop
line 850
;850:}
LABELV $337
endproc SP_weapon_supernailgun 12 28
export SP_weapon_grenadelauncher
proc SP_weapon_grenadelauncher 12 28
line 856
;851:
;852:/*QUAKED weapon_grenadelauncher (0 .5 .8) (-16 -16 0) (16 16 32)
;853:*/
;854:
;855:void SP_weapon_grenadelauncher(  )
;856:{
line 857
;857:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $343
line 858
;858:	{
line 859
;859:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 860
;860:		return;
ADDRGP4 $342
JUMPV
LABELV $343
line 862
;861:	}
;862:	trap_precache_model( "progs/g_rock.mdl" );
ADDRGP4 $345
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 863
;863:	setmodel( self, "progs/g_rock.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $345
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 864
;864:	self->s.v.weapon = 3;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1077936128
ASGNF4
line 865
;865:	self->s.v.netname = "Grenade Launcher";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $346
ASGNP4
line 866
;866:	self->s.v.touch = ( func_t ) weapon_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 weapon_touch
CVPU4 4
CVUI4 4
ASGNI4
line 867
;867:	setsize( self, -16, -16, 0, 16, 16, 56 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 4
CNSTF4 3246391296
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 8
CNSTF4 1098907648
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1113587712
ARGF4
ADDRGP4 setsize
CALLV
pop
line 868
;868:	StartItem(  );
ADDRGP4 StartItem
CALLV
pop
line 869
;869:}
LABELV $342
endproc SP_weapon_grenadelauncher 12 28
export SP_weapon_rocketlauncher
proc SP_weapon_rocketlauncher 12 28
line 876
;870:
;871:
;872:/*QUAKED weapon_rocketlauncher (0 .5 .8) (-16 -16 0) (16 16 32)
;873:*/
;874:
;875:void SP_weapon_rocketlauncher(  )
;876:{
line 877
;877:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $348
line 878
;878:	{
line 879
;879:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 880
;880:		return;
ADDRGP4 $347
JUMPV
LABELV $348
line 882
;881:	}
;882:	trap_precache_model( "progs/g_rock2.mdl" );
ADDRGP4 $350
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 883
;883:	setmodel( self, "progs/g_rock2.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $350
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 884
;884:	self->s.v.weapon = 3;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1077936128
ASGNF4
line 885
;885:	self->s.v.netname = "Rocket Launcher";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $351
ASGNP4
line 886
;886:	self->s.v.touch = ( func_t ) weapon_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 weapon_touch
CVPU4 4
CVUI4 4
ASGNI4
line 887
;887:	setsize( self, -16, -16, 0, 16, 16, 56 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 4
CNSTF4 3246391296
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 8
CNSTF4 1098907648
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1113587712
ARGF4
ADDRGP4 setsize
CALLV
pop
line 888
;888:	StartItem(  );
ADDRGP4 StartItem
CALLV
pop
line 889
;889:}
LABELV $347
endproc SP_weapon_rocketlauncher 12 28
export SP_weapon_lightning
proc SP_weapon_lightning 12 28
line 895
;890:
;891:/*QUAKED weapon_lightning (0 .5 .8) (-16 -16 0) (16 16 32)
;892:*/
;893:
;894:void SP_weapon_lightning(  )
;895:{
line 896
;896:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $353
line 897
;897:	{
line 898
;898:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 899
;899:		return;
ADDRGP4 $352
JUMPV
LABELV $353
line 901
;900:	}
;901:	trap_precache_model( "progs/g_light.mdl" );
ADDRGP4 $355
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 902
;902:	setmodel( self, "progs/g_light.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $355
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 903
;903:	self->s.v.weapon = 3;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1077936128
ASGNF4
line 904
;904:	self->s.v.netname = "Thunderbolt";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $356
ASGNP4
line 905
;905:	self->s.v.touch = ( func_t ) weapon_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 weapon_touch
CVPU4 4
CVUI4 4
ASGNI4
line 906
;906:	setsize( self, -16, -16, 0, 16, 16, 56 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 4
CNSTF4 3246391296
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 8
CNSTF4 1098907648
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1113587712
ARGF4
ADDRGP4 setsize
CALLV
pop
line 907
;907:	StartItem(  );
ADDRGP4 StartItem
CALLV
pop
line 908
;908:}
LABELV $352
endproc SP_weapon_lightning 12 28
export GetGrenadePossibility
proc GetGrenadePossibility 28 16
line 912
;909:extern char *GrenadeNames[];
;910:
;911:int GetGrenadePossibility(  )
;912:{
line 915
;913:	float   maxg;
;914:
;915:	if ( g_random(  ) < 0.5 )
ADDRLP4 4
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
GEF4 $358
line 916
;916:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $357
JUMPV
LABELV $358
line 917
;917:	maxg = 4;
ADDRLP4 0
CNSTF4 1082130432
ASGNF4
line 918
;918:	if ( g_random(  ) < 0.5 )
ADDRLP4 8
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 8
INDIRF4
CNSTF4 1056964608
GEF4 $360
line 919
;919:	{
line 920
;920:		if ( other->tp_grenades_1 == GR_TYPE_NAIL )
ADDRGP4 other
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 3
NEI4 $362
line 921
;921:			maxg = 2;
ADDRLP4 0
CNSTF4 1073741824
ASGNF4
LABELV $362
line 922
;922:		if ( other->tp_grenades_1 == GR_TYPE_CALTROPS )
ADDRGP4 other
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 10
NEI4 $364
line 923
;923:			maxg = 3;
ADDRLP4 0
CNSTF4 1077936128
ASGNF4
LABELV $364
line 924
;924:		if ( other->tp_grenades_1 && other->no_grenades_1 < maxg )
ADDRLP4 12
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 0
EQI4 $361
ADDRLP4 12
INDIRP4
CNSTI4 840
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRF4
GEF4 $361
line 925
;925:		{
line 926
;926:			other->no_grenades_1 += 1;
ADDRLP4 16
ADDRGP4 other
INDIRP4
CNSTI4 840
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
line 927
;927:			G_sprint( other, 2, "You found a %s", GrenadeNames[other->tp_grenades_1] );
ADDRLP4 20
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
CNSTI4 2
ASGNI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 $368
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
LSHI4
ADDRGP4 GrenadeNames
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 928
;928:			if ( other->tp_grenades_1 == GR_TYPE_CALTROPS )
ADDRGP4 other
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 10
NEI4 $369
line 929
;929:				G_sprint( other, 2, " canister\n" );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $371
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $370
JUMPV
LABELV $369
line 931
;930:			else
;931:				G_sprint( other, 2, " grenade\n" );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $372
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $370
line 932
;932:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $357
JUMPV
line 934
;933:		}
;934:	} else
LABELV $360
line 935
;935:	{
line 936
;936:		if ( other->tp_grenades_2 == GR_TYPE_NAIL )
ADDRGP4 other
INDIRP4
CNSTI4 852
ADDP4
INDIRI4
CNSTI4 3
NEI4 $373
line 937
;937:			maxg = 2;
ADDRLP4 0
CNSTF4 1073741824
ASGNF4
LABELV $373
line 938
;938:		if ( other->tp_grenades_2 == GR_TYPE_CONCUSSION )
ADDRGP4 other
INDIRP4
CNSTI4 852
ADDP4
INDIRI4
CNSTI4 2
NEI4 $375
line 939
;939:			maxg = 3;
ADDRLP4 0
CNSTF4 1077936128
ASGNF4
LABELV $375
line 940
;940:		if ( other->tp_grenades_2 && other->no_grenades_2 < maxg )
ADDRLP4 12
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 852
ADDP4
INDIRI4
CNSTI4 0
EQI4 $377
ADDRLP4 12
INDIRP4
CNSTI4 844
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRF4
GEF4 $377
line 941
;941:		{
line 942
;942:			other->no_grenades_2 += 1;
ADDRLP4 16
ADDRGP4 other
INDIRP4
CNSTI4 844
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
line 943
;943:			G_sprint( other, 2, "You found a %s grenade\n", GrenadeNames[other->tp_grenades_2] );
ADDRLP4 20
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
CNSTI4 2
ASGNI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 $379
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 852
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
LSHI4
ADDRGP4 GrenadeNames
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 944
;944:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $357
JUMPV
LABELV $377
line 946
;945:		}
;946:	}
LABELV $361
line 947
;947:	return 0;
CNSTI4 0
RETI4
LABELV $357
endproc GetGrenadePossibility 28 16
export ammo_touch
proc ammo_touch 48 20
line 959
;948:}
;949:
;950:/*
;951:===============================================================================
;952:
;953:AMMO
;954:
;955:===============================================================================
;956:*/
;957:
;958:void ammo_touch(  )
;959:{
line 966
;960:	gedict_t *stemp;
;961:	float   best;
;962:	int     gotgren;
;963:	int     gotbox;
;964:
;965:
;966:	if ( strneq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $18
ARGP4
ADDRLP4 16
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $381
line 967
;967:		return;
ADDRGP4 $380
JUMPV
LABELV $381
line 969
;968:
;969:	if ( other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $383
line 970
;970:		return;
ADDRGP4 $380
JUMPV
LABELV $383
line 972
;971:
;972:	if ( ( other->tfstate & TFSTATE_CANT_MOVE ) || ( other->tfstate & TFSTATE_AIMING ) )
ADDRLP4 20
ADDRGP4 other
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 65536
BANDI4
ADDRLP4 24
INDIRI4
NEI4 $387
ADDRLP4 20
INDIRI4
CNSTI4 2048
BANDI4
ADDRLP4 24
INDIRI4
EQI4 $385
LABELV $387
line 973
;973:		return;
ADDRGP4 $380
JUMPV
LABELV $385
line 974
;974:	if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $388
line 975
;975:		return;
ADDRGP4 $380
JUMPV
LABELV $388
line 976
;976:	gotgren = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 977
;977:	gotbox = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 978
;978:	stemp = self;
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
line 979
;979:	self = other;
ADDRGP4 self
ADDRGP4 other
INDIRP4
ASGNP4
line 980
;980:	best = W_BestWeapon(  );
ADDRLP4 28
ADDRGP4 W_BestWeapon
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 28
INDIRI4
CVIF4 4
ASGNF4
line 981
;981:	self = stemp;
ADDRGP4 self
ADDRLP4 4
INDIRP4
ASGNP4
line 982
;982:	if ( self->s.v.weapon == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $392
line 983
;983:	{
line 984
;984:		if ( other->s.v.ammo_shells >= TeamFortress_GetMaxAmmo( other, IT_SHELLS ) )
ADDRLP4 32
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 36
ADDRGP4 TeamFortress_GetMaxAmmo
CALLI4
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ADDRLP4 36
INDIRI4
CVIF4 4
LTF4 $394
line 985
;985:			return;
ADDRGP4 $380
JUMPV
LABELV $394
line 986
;986:		other->s.v.ammo_shells += self->aflag;
ADDRLP4 40
ADDRGP4 other
INDIRP4
CNSTI4 320
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 987
;987:		gotbox = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 988
;988:	}
LABELV $392
line 989
;989:	if ( self->s.v.weapon == 2 )
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $396
line 990
;990:	{
line 991
;991:		if ( other->s.v.ammo_nails >= TeamFortress_GetMaxAmmo( other, IT_NAILS ) )
ADDRLP4 32
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
CNSTI4 512
ARGI4
ADDRLP4 36
ADDRGP4 TeamFortress_GetMaxAmmo
CALLI4
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
ADDRLP4 36
INDIRI4
CVIF4 4
LTF4 $398
line 992
;992:			return;
ADDRGP4 $380
JUMPV
LABELV $398
line 993
;993:		other->s.v.ammo_nails += self->aflag;
ADDRLP4 40
ADDRGP4 other
INDIRP4
CNSTI4 324
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 994
;994:		gotbox = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 995
;995:	} else
ADDRGP4 $397
JUMPV
LABELV $396
line 996
;996:	{
line 997
;997:		if ( self->s.v.weapon == 3 )
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $400
line 998
;998:		{
line 999
;999:			gotgren = GetGrenadePossibility(  );
ADDRLP4 32
ADDRGP4 GetGrenadePossibility
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 32
INDIRI4
ASGNI4
line 1000
;1000:			if ( other->s.v.ammo_rockets >= TeamFortress_GetMaxAmmo( other, IT_ROCKETS ) )
ADDRLP4 36
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 40
ADDRGP4 TeamFortress_GetMaxAmmo
CALLI4
ASGNI4
ADDRLP4 36
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ADDRLP4 40
INDIRI4
CVIF4 4
LTF4 $402
line 1001
;1001:				gotbox = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $401
JUMPV
LABELV $402
line 1003
;1002:			else
;1003:			{
line 1004
;1004:				gotbox = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1005
;1005:				other->s.v.ammo_rockets += self->aflag;
ADDRLP4 44
ADDRGP4 other
INDIRP4
CNSTI4 328
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1006
;1006:			}
line 1007
;1007:		} else
ADDRGP4 $401
JUMPV
LABELV $400
line 1008
;1008:		{
line 1009
;1009:			if ( self->s.v.weapon == 4 )
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1082130432
NEF4 $404
line 1010
;1010:			{
line 1011
;1011:				if ( other->s.v.ammo_cells >= TeamFortress_GetMaxAmmo( other, IT_CELLS ) )
ADDRLP4 32
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 36
ADDRGP4 TeamFortress_GetMaxAmmo
CALLI4
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ADDRLP4 36
INDIRI4
CVIF4 4
LTF4 $406
line 1012
;1012:					return;
ADDRGP4 $380
JUMPV
LABELV $406
line 1013
;1013:				other->s.v.ammo_cells += self->aflag;
ADDRLP4 40
ADDRGP4 other
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1014
;1014:				gotbox = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1015
;1015:			}
LABELV $404
line 1016
;1016:		}
LABELV $401
line 1017
;1017:	}
LABELV $397
line 1018
;1018:	if ( !gotbox && !gotgren )
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $408
ADDRLP4 8
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $408
line 1019
;1019:		return;
ADDRGP4 $380
JUMPV
LABELV $408
line 1021
;1020:// ammo touch sound
;1021:	sound( other, CHAN_ITEM, "weapons/lock4.wav", 1, ATTN_NORM );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $410
ARGP4
ADDRLP4 36
CNSTF4 1065353216
ASGNF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 1022
;1022:	stuffcmd( other, "bf\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $21
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1023
;1023:	if ( gotbox )
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $411
line 1024
;1024:	{
line 1025
;1025:		bound_other_ammo( other );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 bound_other_ammo
CALLV
pop
line 1027
;1026:
;1027:		G_sprint( other, PRINT_LOW, "You got the %s\n", self->s.v.netname );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $323
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1028
;1028:		stemp = self;
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
line 1029
;1029:		self = other;
ADDRGP4 self
ADDRGP4 other
INDIRP4
ASGNP4
line 1030
;1030:		W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 1031
;1031:		self = stemp;
ADDRGP4 self
ADDRLP4 4
INDIRP4
ASGNP4
line 1032
;1032:	}
LABELV $411
line 1033
;1033:	Respawn_Item( self, other );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 Respawn_Item
CALLV
pop
line 1034
;1034:}
LABELV $380
endproc ammo_touch 48 20
export SP_item_shells
proc SP_item_shells 12 28
line 1042
;1035:
;1036:#define  WEAPON_BIG2  1
;1037:
;1038:/*QUAKED item_shells (0 .5 .8) (0 0 0) (32 32 32) big
;1039:*/
;1040:
;1041:void SP_item_shells(  )
;1042:{
line 1043
;1043:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $414
line 1044
;1044:	{
line 1045
;1045:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1046
;1046:		return;
ADDRGP4 $413
JUMPV
LABELV $414
line 1048
;1047:	}
;1048:	self->s.v.touch = ( func_t ) ammo_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 ammo_touch
CVPU4 4
CVUI4 4
ASGNI4
line 1050
;1049:
;1050:	if ( ( int ) ( self->s.v.spawnflags ) & WEAPON_BIG2 )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $416
line 1051
;1051:	{
line 1052
;1052:		trap_precache_model( "maps/b_shell1.bsp" );
ADDRGP4 $418
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1053
;1053:		setmodel( self, "maps/b_shell1.bsp" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $418
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1054
;1054:		self->aflag = 40;
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 40
ASGNI4
line 1055
;1055:	} else
ADDRGP4 $417
JUMPV
LABELV $416
line 1056
;1056:	{
line 1057
;1057:		trap_precache_model( "maps/b_shell0.bsp" );
ADDRGP4 $419
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1058
;1058:		setmodel( self, "maps/b_shell0.bsp" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $419
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1059
;1059:		self->aflag = 20;
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 20
ASGNI4
line 1060
;1060:	}
LABELV $417
line 1062
;1061:
;1062:	self->s.v.weapon = 1;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1065353216
ASGNF4
line 1063
;1063:	self->s.v.netname = "shells";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $420
ASGNP4
line 1065
;1064:
;1065:	setsize( self, 0, 0, 0, 32, 32, 56 );
ADDRGP4 self
INDIRP4
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
CNSTF4 1107296256
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1113587712
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1066
;1066:	StartItem(  );
ADDRGP4 StartItem
CALLV
pop
line 1067
;1067:}
LABELV $413
endproc SP_item_shells 12 28
export SP_item_spikes
proc SP_item_spikes 12 28
line 1073
;1068:
;1069:/*QUAKED item_spikes (0 .5 .8) (0 0 0) (32 32 32) big
;1070:*/
;1071:
;1072:void SP_item_spikes(  )
;1073:{
line 1074
;1074:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $422
line 1075
;1075:	{
line 1076
;1076:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1077
;1077:		return;
ADDRGP4 $421
JUMPV
LABELV $422
line 1079
;1078:	}
;1079:	self->s.v.touch = ( func_t ) ammo_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 ammo_touch
CVPU4 4
CVUI4 4
ASGNI4
line 1081
;1080:
;1081:	if ( ( int ) ( self->s.v.spawnflags ) & WEAPON_BIG2 )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $424
line 1082
;1082:	{
line 1083
;1083:		trap_precache_model( "maps/b_nail1.bsp" );
ADDRGP4 $426
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1084
;1084:		setmodel( self, "maps/b_nail1.bsp" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $426
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1085
;1085:		self->aflag = 50;
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 50
ASGNI4
line 1086
;1086:	} else
ADDRGP4 $425
JUMPV
LABELV $424
line 1087
;1087:	{
line 1088
;1088:		trap_precache_model( "maps/b_nail0.bsp" );
ADDRGP4 $427
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1089
;1089:		setmodel( self, "maps/b_nail0.bsp" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $427
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1090
;1090:		self->aflag = 25;
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 25
ASGNI4
line 1091
;1091:	}
LABELV $425
line 1092
;1092:	self->s.v.weapon = 2;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1073741824
ASGNF4
line 1093
;1093:	self->s.v.netname = "nails";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $428
ASGNP4
line 1095
;1094:
;1095:	setsize( self, 0, 0, 0, 32, 32, 56 );
ADDRGP4 self
INDIRP4
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
CNSTF4 1107296256
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1113587712
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1097
;1096:
;1097:	StartItem(  );
ADDRGP4 StartItem
CALLV
pop
line 1099
;1098:
;1099:}
LABELV $421
endproc SP_item_spikes 12 28
export SP_item_rockets
proc SP_item_rockets 12 28
line 1105
;1100:
;1101:/*QUAKED item_rockets (0 .5 .8) (0 0 0) (32 32 32) big
;1102:*/
;1103:
;1104:void SP_item_rockets(  )
;1105:{
line 1106
;1106:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $430
line 1107
;1107:	{
line 1108
;1108:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1109
;1109:		return;
ADDRGP4 $429
JUMPV
LABELV $430
line 1111
;1110:	}
;1111:	self->s.v.touch = ( func_t ) ammo_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 ammo_touch
CVPU4 4
CVUI4 4
ASGNI4
line 1113
;1112:
;1113:	if ( ( int ) ( self->s.v.spawnflags ) & WEAPON_BIG2 )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $432
line 1114
;1114:	{
line 1115
;1115:		trap_precache_model( "maps/b_rock1.bsp" );
ADDRGP4 $434
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1116
;1116:		setmodel( self, "maps/b_rock1.bsp" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $434
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1117
;1117:		self->aflag = 10;
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 10
ASGNI4
line 1118
;1118:	} else
ADDRGP4 $433
JUMPV
LABELV $432
line 1119
;1119:	{
line 1120
;1120:		trap_precache_model( "maps/b_rock0.bsp" );
ADDRGP4 $435
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1121
;1121:		setmodel( self, "maps/b_rock0.bsp" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $435
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1122
;1122:		self->aflag = 5;
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 5
ASGNI4
line 1123
;1123:	}
LABELV $433
line 1124
;1124:	self->s.v.weapon = 3;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1077936128
ASGNF4
line 1125
;1125:	self->s.v.netname = "rockets";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $436
ASGNP4
line 1127
;1126:
;1127:	setsize( self, 0, 0, 0, 32, 32, 56 );
ADDRGP4 self
INDIRP4
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
CNSTF4 1107296256
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1113587712
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1129
;1128:
;1129:	StartItem(  );
ADDRGP4 StartItem
CALLV
pop
line 1131
;1130:
;1131:}
LABELV $429
endproc SP_item_rockets 12 28
export SP_item_cells
proc SP_item_cells 12 28
line 1137
;1132:
;1133:/*QUAKED item_cells (0 .5 .8) (0 0 0) (32 32 32) big
;1134:*/
;1135:
;1136:void SP_item_cells(  )
;1137:{
line 1138
;1138:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $438
line 1139
;1139:	{
line 1140
;1140:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1141
;1141:		return;
ADDRGP4 $437
JUMPV
LABELV $438
line 1143
;1142:	}
;1143:	self->s.v.touch = ( func_t ) ammo_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 ammo_touch
CVPU4 4
CVUI4 4
ASGNI4
line 1145
;1144:
;1145:	if ( ( int ) ( self->s.v.spawnflags ) & WEAPON_BIG2 )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $440
line 1146
;1146:	{
line 1147
;1147:		trap_precache_model( "maps/b_batt1.bsp" );
ADDRGP4 $442
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1148
;1148:		setmodel( self, "maps/b_batt1.bsp" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $442
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1149
;1149:		self->aflag = 12;
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 12
ASGNI4
line 1150
;1150:	} else
ADDRGP4 $441
JUMPV
LABELV $440
line 1151
;1151:	{
line 1152
;1152:		trap_precache_model( "maps/b_batt0.bsp" );
ADDRGP4 $443
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1153
;1153:		setmodel( self, "maps/b_batt0.bsp" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $443
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1154
;1154:		self->aflag = 6;
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 6
ASGNI4
line 1155
;1155:	}
LABELV $441
line 1157
;1156:
;1157:	self->s.v.weapon = 4;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1082130432
ASGNF4
line 1158
;1158:	self->s.v.netname = "cells";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $444
ASGNP4
line 1160
;1159:
;1160:	setsize( self, 0, 0, 0, 32, 32, 56 );
ADDRGP4 self
INDIRP4
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
CNSTF4 1107296256
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1113587712
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1162
;1161:
;1162:	StartItem(  );
ADDRGP4 StartItem
CALLV
pop
line 1164
;1163:
;1164:}
LABELV $437
endproc SP_item_cells 12 28
export SP_item_weapon
proc SP_item_weapon 12 28
line 1175
;1165:
;1166:/*QUAKED item_weapon (0 .5 .8) (0 0 0) (32 32 32) shotgun rocket spikes big
;1167:DO NOT USE THIS!!!! IT WILL BE REMOVED!
;1168:*/
;1169:
;1170:#define WEAPON_SHOTGUN  1
;1171:#define WEAPON_ROCKET  2
;1172:#define WEAPON_SPIKES  4
;1173:#define WEAPON_BIG  8
;1174:void SP_item_weapon(  )
;1175:{
line 1176
;1176:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $446
line 1177
;1177:	{
line 1178
;1178:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1179
;1179:		return;
ADDRGP4 $445
JUMPV
LABELV $446
line 1181
;1180:	}
;1181:	self->s.v.touch = ( func_t ) ammo_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 ammo_touch
CVPU4 4
CVUI4 4
ASGNI4
line 1183
;1182:
;1183:	if ( ( int ) ( self->s.v.spawnflags ) & WEAPON_SHOTGUN )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $448
line 1184
;1184:	{
line 1185
;1185:		if ( ( int ) ( self->s.v.spawnflags ) & WEAPON_BIG )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $450
line 1186
;1186:		{
line 1187
;1187:			trap_precache_model( "maps/b_shell1.bsp" );
ADDRGP4 $418
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1188
;1188:			setmodel( self, "maps/b_shell1.bsp" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $418
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1189
;1189:			self->aflag = 40;
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 40
ASGNI4
line 1190
;1190:		} else
ADDRGP4 $451
JUMPV
LABELV $450
line 1191
;1191:		{
line 1192
;1192:			trap_precache_model( "maps/b_shell0.bsp" );
ADDRGP4 $419
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1193
;1193:			setmodel( self, "maps/b_shell0.bsp" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $419
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1194
;1194:			self->aflag = 20;
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 20
ASGNI4
line 1195
;1195:		}
LABELV $451
line 1196
;1196:		self->s.v.weapon = 1;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1065353216
ASGNF4
line 1197
;1197:		self->s.v.netname = "shells";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $420
ASGNP4
line 1198
;1198:	}
LABELV $448
line 1200
;1199:
;1200:	if ( ( int ) ( self->s.v.spawnflags ) & WEAPON_SPIKES )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $452
line 1201
;1201:	{
line 1202
;1202:		if ( ( int ) ( self->s.v.spawnflags ) & WEAPON_BIG )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $454
line 1203
;1203:		{
line 1204
;1204:			trap_precache_model( "maps/b_nail1.bsp" );
ADDRGP4 $426
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1205
;1205:			setmodel( self, "maps/b_nail1.bsp" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $426
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1206
;1206:			self->aflag = 40;
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 40
ASGNI4
line 1207
;1207:		} else
ADDRGP4 $455
JUMPV
LABELV $454
line 1208
;1208:		{
line 1209
;1209:			trap_precache_model( "maps/b_nail0.bsp" );
ADDRGP4 $427
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1210
;1210:			setmodel( self, "maps/b_nail0.bsp" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $427
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1211
;1211:			self->aflag = 20;
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 20
ASGNI4
line 1212
;1212:		}
LABELV $455
line 1213
;1213:		self->s.v.weapon = 2;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1073741824
ASGNF4
line 1214
;1214:		self->s.v.netname = "spikes";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $456
ASGNP4
line 1215
;1215:	}
LABELV $452
line 1217
;1216:
;1217:	if ( ( int ) ( self->s.v.spawnflags ) & WEAPON_ROCKET )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $457
line 1218
;1218:	{
line 1219
;1219:		if ( ( int ) ( self->s.v.spawnflags ) & WEAPON_BIG )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $459
line 1220
;1220:		{
line 1221
;1221:			trap_precache_model( "maps/b_rock1.bsp" );
ADDRGP4 $434
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1222
;1222:			setmodel( self, "maps/b_rock1.bsp" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $434
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1223
;1223:			self->aflag = 10;
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 10
ASGNI4
line 1224
;1224:		} else
ADDRGP4 $460
JUMPV
LABELV $459
line 1225
;1225:		{
line 1226
;1226:			trap_precache_model( "maps/b_rock0.bsp" );
ADDRGP4 $435
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1227
;1227:			setmodel( self, "maps/b_rock0.bsp" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $435
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1228
;1228:			self->aflag = 5;
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 5
ASGNI4
line 1229
;1229:		}
LABELV $460
line 1230
;1230:		self->s.v.weapon = 3;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1077936128
ASGNF4
line 1231
;1231:		self->s.v.netname = "rockets";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $436
ASGNP4
line 1232
;1232:	}
LABELV $457
line 1234
;1233:
;1234:	setsize( self, 0, 0, 0, 32, 32, 56 );
ADDRGP4 self
INDIRP4
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
CNSTF4 1107296256
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1113587712
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1236
;1235:
;1236:	StartItem(  );
ADDRGP4 StartItem
CALLV
pop
line 1237
;1237:}
LABELV $445
endproc SP_item_weapon 12 28
export key_touch
proc key_touch 28 20
line 1247
;1238:
;1239:/*
;1240:===============================================================================
;1241:
;1242:KEYS
;1243:
;1244:===============================================================================
;1245:*/
;1246:void key_touch(  )
;1247:{
line 1249
;1248:
;1249:	if ( strneq( other->s.v.classname, "player" ) )
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
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $462
line 1250
;1250:		return;
ADDRGP4 $461
JUMPV
LABELV $462
line 1252
;1251:
;1252:	if ( other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $464
line 1253
;1253:		return;
ADDRGP4 $461
JUMPV
LABELV $464
line 1255
;1254:
;1255:	if ( ( int ) other->s.v.items & ( int ) self->s.v.items )
ADDRLP4 4
CNSTI4 336
ASGNI4
ADDRGP4 other
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
CVFI4 4
ADDRGP4 self
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
CVFI4 4
BANDI4
CNSTI4 0
EQI4 $466
line 1256
;1256:		return;
ADDRGP4 $461
JUMPV
LABELV $466
line 1257
;1257:	if ( other->is_feigning )
ADDRGP4 other
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
EQI4 $468
line 1258
;1258:		return;
ADDRGP4 $461
JUMPV
LABELV $468
line 1259
;1259:	if ( ( other->tfstate & TFSTATE_CANT_MOVE ) || ( other->tfstate & TFSTATE_AIMING ) )
ADDRLP4 8
ADDRGP4 other
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 65536
BANDI4
ADDRLP4 12
INDIRI4
NEI4 $472
ADDRLP4 8
INDIRI4
CNSTI4 2048
BANDI4
ADDRLP4 12
INDIRI4
EQI4 $470
LABELV $472
line 1260
;1260:		return;
ADDRGP4 $461
JUMPV
LABELV $470
line 1261
;1261:	if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $473
line 1262
;1262:		return;
ADDRGP4 $461
JUMPV
LABELV $473
line 1264
;1263:
;1264:	G_sprint( other, PRINT_LOW, "You got the %s\n", self->s.v.netname );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $323
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1266
;1265:
;1266:	sound( other, CHAN_ITEM, self->s.v.noise, 1, ATTN_NORM );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 1267
;1267:	stuffcmd( other, "bf\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $21
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1268
;1268:	other->s.v.items = ( int ) other->s.v.items | ( int ) self->s.v.items;
ADDRLP4 20
CNSTI4 336
ASGNI4
ADDRLP4 24
ADDRGP4 other
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CVFI4 4
ADDRGP4 self
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
CVFI4 4
BORI4
CVIF4 4
ASGNF4
line 1269
;1269:	if ( !coop )
ADDRGP4 coop
INDIRI4
CNSTI4 0
NEI4 $477
line 1270
;1270:	{
line 1271
;1271:		self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 1272
;1272:		self->s.v.model = "";
ADDRGP4 self
INDIRP4
CNSTI4 220
ADDP4
ADDRGP4 $22
ASGNP4
line 1273
;1273:	} else
ADDRGP4 $478
JUMPV
LABELV $477
line 1274
;1274:	{
line 1275
;1275:		if ( coop && self->s.v.deadflag )
ADDRGP4 coop
INDIRI4
CNSTI4 0
EQI4 $479
ADDRGP4 self
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
CNSTF4 0
EQF4 $479
line 1276
;1276:		{
line 1277
;1277:			dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1278
;1278:			return;
ADDRGP4 $461
JUMPV
LABELV $479
line 1280
;1279:		}
;1280:	}
LABELV $478
line 1281
;1281:	activator = other;
ADDRGP4 activator
ADDRGP4 other
INDIRP4
ASGNP4
line 1282
;1282:	SUB_UseTargets(  );	// fire all targets / killtargets
ADDRGP4 SUB_UseTargets
CALLV
pop
line 1283
;1283:}
LABELV $461
endproc key_touch 28 20
export key_setsounds
proc key_setsounds 0 4
line 1295
;1284:
;1285:extern char *key_models1[3];
;1286:extern char *key_names1[3];
;1287:extern char *key_sound1[3];
;1288:
;1289:extern char *key_models2[3];
;1290:extern char *key_names2[3];
;1291:extern char *key_sound2[3];
;1292:
;1293:
;1294:void key_setsounds(  )
;1295:{
line 1296
;1296:	if ( world->worldtype > 2 )
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2
LEI4 $482
line 1297
;1297:		return;
ADDRGP4 $481
JUMPV
LABELV $482
line 1298
;1298:	self->s.v.noise = key_sound1[world->worldtype];
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 key_sound1
ADDP4
INDIRP4
ASGNP4
line 1299
;1299:	trap_precache_sound( key_sound1[world->worldtype] );
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 key_sound1
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 1300
;1300:}
LABELV $481
endproc key_setsounds 0 4
export SP_item_key1
proc SP_item_key1 12 28
line 1315
;1301:
;1302:
;1303:/*QUAKED item_key1 (0 .5 .8) (-16 -16 -24) (16 16 32)
;1304:SILVER key
;1305:In order for keys to work
;1306:you MUST set your maps
;1307:worldtype to one of the
;1308:following:
;1309:0: medieval
;1310:1: metal
;1311:2: base
;1312:*/
;1313:
;1314:void SP_item_key1(  )
;1315:{
line 1316
;1316:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $485
line 1317
;1317:	{
line 1318
;1318:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1319
;1319:		return;
ADDRGP4 $484
JUMPV
LABELV $485
line 1321
;1320:	}
;1321:	setmodel( self, key_models1[world->worldtype] );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 key_models1
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1322
;1322:	self->s.v.netname = key_names1[world->worldtype];
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 key_names1
ADDP4
INDIRP4
ASGNP4
line 1323
;1323:	self->s.v.noise = key_sound1[world->worldtype];
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 key_sound1
ADDP4
INDIRP4
ASGNP4
line 1326
;1324:
;1325:
;1326:	key_setsounds(  );
ADDRGP4 key_setsounds
CALLV
pop
line 1327
;1327:	self->s.v.touch = ( func_t ) key_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 key_touch
CVPU4 4
CVUI4 4
ASGNI4
line 1328
;1328:	self->s.v.items = IT_KEY1;
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
CNSTF4 1207959552
ASGNF4
line 1329
;1329:	setsize( self, -16, -16, -24, 16, 16, 32 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 4
CNSTF4 3246391296
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 3250585600
ARGF4
ADDRLP4 8
CNSTF4 1098907648
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1330
;1330:	StartItem(  );
ADDRGP4 StartItem
CALLV
pop
line 1331
;1331:}
LABELV $484
endproc SP_item_key1 12 28
export SP_item_key2
proc SP_item_key2 12 28
line 1345
;1332:
;1333:/*QUAKED item_key2 (0 .5 .8) (-16 -16 -24) (16 16 32)
;1334:GOLD key
;1335:In order for keys to work
;1336:you MUST set your maps
;1337:worldtype to one of the
;1338:following:
;1339:0: medieval
;1340:1: metal
;1341:2: base
;1342:*/
;1343:
;1344:void SP_item_key2(  )
;1345:{
line 1346
;1346:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $488
line 1347
;1347:	{
line 1348
;1348:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1349
;1349:		return;
ADDRGP4 $487
JUMPV
LABELV $488
line 1351
;1350:	}
;1351:	setmodel( self, key_models2[world->worldtype] );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 key_models2
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1352
;1352:	self->s.v.netname = key_names2[world->worldtype];
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 key_names2
ADDP4
INDIRP4
ASGNP4
line 1353
;1353:	self->s.v.noise = key_sound2[world->worldtype];
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 key_sound2
ADDP4
INDIRP4
ASGNP4
line 1355
;1354:
;1355:	key_setsounds(  );
ADDRGP4 key_setsounds
CALLV
pop
line 1356
;1356:	self->s.v.touch = ( func_t ) key_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 key_touch
CVPU4 4
CVUI4 4
ASGNI4
line 1357
;1357:	self->s.v.items = IT_KEY2;
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
CNSTF4 1216348160
ASGNF4
line 1358
;1358:	setsize( self, -16, -16, -24, 16, 16, 32 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 4
CNSTF4 3246391296
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 3250585600
ARGF4
ADDRLP4 8
CNSTF4 1098907648
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1359
;1359:	StartItem(  );
ADDRGP4 StartItem
CALLV
pop
line 1360
;1360:}
LABELV $487
endproc SP_item_key2 12 28
export sigil_touch
proc sigil_touch 16 20
line 1371
;1361:
;1362:/*
;1363:===============================================================================
;1364:
;1365:END OF LEVEL RUNES
;1366:
;1367:===============================================================================
;1368:*/
;1369:
;1370:void sigil_touch(  )
;1371:{
line 1375
;1372://      gedict_t *stemp;
;1373://      float   best;
;1374:
;1375:	if ( strneq( other->s.v.classname, "player" ) )
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
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $491
line 1376
;1376:		return;
ADDRGP4 $490
JUMPV
LABELV $491
line 1377
;1377:	if ( other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $493
line 1378
;1378:		return;
ADDRGP4 $490
JUMPV
LABELV $493
line 1380
;1379:
;1380:	if ( other->is_feigning )
ADDRGP4 other
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
EQI4 $495
line 1381
;1381:		return;
ADDRGP4 $490
JUMPV
LABELV $495
line 1382
;1382:	if ( ( other->tfstate & TFSTATE_CANT_MOVE ) || ( other->tfstate & TFSTATE_AIMING ) )
ADDRLP4 4
ADDRGP4 other
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 65536
BANDI4
ADDRLP4 8
INDIRI4
NEI4 $499
ADDRLP4 4
INDIRI4
CNSTI4 2048
BANDI4
ADDRLP4 8
INDIRI4
EQI4 $497
LABELV $499
line 1383
;1383:		return;
ADDRGP4 $490
JUMPV
LABELV $497
line 1384
;1384:	if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $500
line 1385
;1385:		return;
ADDRGP4 $490
JUMPV
LABELV $500
line 1387
;1386:
;1387:        if( tf_data.lan_mode )
ADDRGP4 tf_data+176
INDIRI4
CNSTI4 0
EQI4 $504
line 1388
;1388:		G_centerprint( other, "You got the rune!" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $507
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
LABELV $504
line 1390
;1389:
;1390:	sound( other, CHAN_ITEM, self->s.v.noise, 1, ATTN_NORM );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
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
line 1391
;1391:	stuffcmd( other, "bf\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $21
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1392
;1392:	self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 1393
;1393:	self->s.v.model = "";
ADDRGP4 self
INDIRP4
CNSTI4 220
ADDP4
ADDRGP4 $22
ASGNP4
line 1394
;1394:	g_globalvars.serverflags = ( int ) ( g_globalvars.serverflags ) | ( ( int ) ( self->s.v.spawnflags ) & 15 );
ADDRGP4 g_globalvars+144
ADDRGP4 g_globalvars+144
INDIRF4
CVFI4 4
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 15
BANDI4
BORI4
CVIF4 4
ASGNF4
line 1395
;1395:	self->s.v.classname = "";	// so rune doors won't find it
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $22
ASGNP4
line 1397
;1396:
;1397:	activator = other;
ADDRGP4 activator
ADDRGP4 other
INDIRP4
ASGNP4
line 1398
;1398:	SUB_UseTargets(  );	// fire all targets / killtargets
ADDRGP4 SUB_UseTargets
CALLV
pop
line 1399
;1399:}
LABELV $490
endproc sigil_touch 16 20
export SP_item_sigil
proc SP_item_sigil 12 28
line 1406
;1400:
;1401:/*QUAKED item_sigil (0 .5 .8) (-16 -16 -24) (16 16 32) E1 E2 E3 E4
;1402:End of level sigil, pick up to end episode and return to jrstart.
;1403:*/
;1404:
;1405:void SP_item_sigil(  )
;1406:{
line 1408
;1407:
;1408:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $511
line 1409
;1409:	{
line 1410
;1410:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1411
;1411:		return;
ADDRGP4 $510
JUMPV
LABELV $511
line 1413
;1412:	}
;1413:	if ( !( int ) ( self->s.v.spawnflags ) )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 0
NEI4 $513
line 1414
;1414:		G_Error( "item_sigil no spawnflags" );
ADDRGP4 $515
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $513
line 1416
;1415:
;1416:	trap_precache_sound( "misc/runekey.wav" );
ADDRGP4 $516
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 1417
;1417:	self->s.v.noise = "misc/runekey.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $516
ASGNP4
line 1419
;1418:
;1419:	if ( ( int ) ( self->s.v.spawnflags ) & 1 )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $517
line 1420
;1420:	{
line 1421
;1421:		trap_precache_model( "progs/end1.mdl" );
ADDRGP4 $519
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1422
;1422:		setmodel( self, "progs/end1.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $519
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1423
;1423:	}
LABELV $517
line 1424
;1424:	if ( ( int ) ( self->s.v.spawnflags ) & 2 )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $520
line 1425
;1425:	{
line 1426
;1426:		trap_precache_model( "progs/end2.mdl" );
ADDRGP4 $522
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1427
;1427:		setmodel( self, "progs/end2.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $522
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1428
;1428:	}
LABELV $520
line 1429
;1429:	if ( ( int ) ( self->s.v.spawnflags ) & 4 )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $523
line 1430
;1430:	{
line 1431
;1431:		trap_precache_model( "progs/end3.mdl" );
ADDRGP4 $525
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1432
;1432:		setmodel( self, "progs/end3.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $525
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1433
;1433:	}
LABELV $523
line 1434
;1434:	if ( ( int ) ( self->s.v.spawnflags ) & 8 )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $526
line 1435
;1435:	{
line 1436
;1436:		trap_precache_model( "progs/end4.mdl" );
ADDRGP4 $528
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1437
;1437:		setmodel( self, "progs/end4.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $528
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1438
;1438:	}
LABELV $526
line 1440
;1439:
;1440:	self->s.v.touch = ( func_t ) sigil_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 sigil_touch
CVPU4 4
CVUI4 4
ASGNI4
line 1441
;1441:	setsize( self, -16, -16, -24, 16, 16, 32 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 4
CNSTF4 3246391296
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 3250585600
ARGF4
ADDRLP4 8
CNSTF4 1098907648
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1442
;1442:	StartItem(  );
ADDRGP4 StartItem
CALLV
pop
line 1443
;1443:}
LABELV $510
endproc SP_item_sigil 12 28
export powerup_touch
proc powerup_touch 40 20
line 1454
;1444:
;1445:/*
;1446:===============================================================================
;1447:
;1448:POWERUPS
;1449:
;1450:===============================================================================
;1451:*/
;1452:
;1453:void powerup_touch(  )
;1454:{
line 1456
;1455:
;1456:	if ( strneq( other->s.v.classname, "player" ) )
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
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $530
line 1457
;1457:		return;
ADDRGP4 $529
JUMPV
LABELV $530
line 1458
;1458:	if ( other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $532
line 1459
;1459:		return;
ADDRGP4 $529
JUMPV
LABELV $532
line 1460
;1460:	if ( other->is_feigning )
ADDRGP4 other
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
EQI4 $534
line 1461
;1461:		return;
ADDRGP4 $529
JUMPV
LABELV $534
line 1462
;1462:	if ( ( other->tfstate & TFSTATE_CANT_MOVE ) || ( other->tfstate & TFSTATE_AIMING ) )
ADDRLP4 4
ADDRGP4 other
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 65536
BANDI4
ADDRLP4 8
INDIRI4
NEI4 $538
ADDRLP4 4
INDIRI4
CNSTI4 2048
BANDI4
ADDRLP4 8
INDIRI4
EQI4 $536
LABELV $538
line 1463
;1463:		return;
ADDRGP4 $529
JUMPV
LABELV $536
line 1464
;1464:	if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $539
line 1465
;1465:		return;
ADDRGP4 $529
JUMPV
LABELV $539
line 1466
;1466:	if ( tf_data.disable_powerups )
ADDRGP4 tf_data+160
INDIRI4
CNSTI4 0
EQI4 $543
line 1467
;1467:		return;
ADDRGP4 $529
JUMPV
LABELV $543
line 1468
;1468:	G_sprint( other, PRINT_LOW, "You got the %s\n", self->s.v.netname );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $323
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1470
;1469:
;1470:	if ( deathmatch )
ADDRGP4 deathmatch
INDIRI4
CNSTI4 0
EQI4 $546
line 1471
;1471:	{
line 1472
;1472:		self->mdl = self->s.v.model;
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 528
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ASGNP4
line 1473
;1473:		if ( !strcmp( self->s.v.classname, "item_artifact_invulnerability" ) ||
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $550
ARGP4
ADDRLP4 16
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $552
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $551
ARGP4
ADDRLP4 20
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $548
LABELV $552
line 1475
;1474:		     !strcmp( self->s.v.classname, "item_artifact_invisibility" ) )
;1475:			self->s.v.nextthink = g_globalvars.time + 60 * 5;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1133903872
ADDF4
ASGNF4
ADDRGP4 $549
JUMPV
LABELV $548
line 1477
;1476:		else
;1477:			self->s.v.nextthink = g_globalvars.time + 60;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
LABELV $549
line 1478
;1478:		self->s.v.think = ( func_t ) SUB_regen;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_regen
CVPU4 4
CVUI4 4
ASGNI4
line 1479
;1479:	} else
ADDRGP4 $547
JUMPV
LABELV $546
line 1480
;1480:	{
line 1481
;1481:		if ( coop )
ADDRGP4 coop
INDIRI4
CNSTI4 0
EQI4 $555
line 1482
;1482:		{
line 1483
;1483:			self->mdl = self->s.v.model;
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 528
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ASGNP4
line 1484
;1484:			if ( !strcmp
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $550
ARGP4
ADDRLP4 16
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $559
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $551
ARGP4
ADDRLP4 20
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $557
LABELV $559
line 1487
;1485:			     ( self->s.v.classname, "item_artifact_invulnerability" )
;1486:			     || !strcmp( self->s.v.classname, "item_artifact_invisibility" ) )
;1487:				self->s.v.nextthink = g_globalvars.time + 120 * 5;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
ADDRGP4 $558
JUMPV
LABELV $557
line 1489
;1488:			else
;1489:				self->s.v.nextthink = g_globalvars.time + 120;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
LABELV $558
line 1490
;1490:			self->s.v.think = ( func_t ) SUB_regen;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_regen
CVPU4 4
CVUI4 4
ASGNI4
line 1491
;1491:		}
LABELV $555
line 1492
;1492:	}
LABELV $547
line 1493
;1493:	sound( other, CHAN_VOICE, self->s.v.noise, 1, ATTN_NORM );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
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
line 1494
;1494:	stuffcmd( other, "bf\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $21
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1495
;1495:	self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 1496
;1496:	other->s.v.items = ( ( int ) other->s.v.items ) | ( ( int ) self->s.v.items );
ADDRLP4 16
CNSTI4 336
ASGNI4
ADDRLP4 20
ADDRGP4 other
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CVFI4 4
ADDRGP4 self
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
CVFI4 4
BORI4
CVIF4 4
ASGNF4
line 1497
;1497:	self->s.v.model = "";
ADDRGP4 self
INDIRP4
CNSTI4 220
ADDP4
ADDRGP4 $22
ASGNP4
line 1500
;1498:
;1499:// do the apropriate action
;1500:	if ( !strcmp( self->s.v.classname, "item_artifact_envirosuit" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $564
ARGP4
ADDRLP4 24
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $562
line 1501
;1501:	{
line 1502
;1502:		other->rad_time = 1;
ADDRGP4 other
INDIRP4
CNSTI4 772
ADDP4
CNSTF4 1065353216
ASGNF4
line 1503
;1503:		other->radsuit_finished = g_globalvars.time + 30;
ADDRGP4 other
INDIRP4
CNSTI4 744
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 1504
;1504:	}
LABELV $562
line 1506
;1505:
;1506:	if ( !strcmp( self->s.v.classname, "item_artifact_invulnerability" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $550
ARGP4
ADDRLP4 28
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $566
line 1507
;1507:	{
line 1508
;1508:		other->invincible_time = 1;
ADDRGP4 other
INDIRP4
CNSTI4 748
ADDP4
CNSTF4 1065353216
ASGNF4
line 1509
;1509:		other->invincible_finished = g_globalvars.time + 30;
ADDRGP4 other
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 1510
;1510:	}
LABELV $566
line 1512
;1511:
;1512:	if ( streq( self->s.v.classname, "item_artifact_invisibility" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $551
ARGP4
ADDRLP4 32
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $569
line 1513
;1513:	{
line 1514
;1514:		other->invisible_time = 1;
ADDRGP4 other
INDIRP4
CNSTI4 756
ADDP4
CNSTF4 1065353216
ASGNF4
line 1515
;1515:		other->invisible_finished = g_globalvars.time + 30;
ADDRGP4 other
INDIRP4
CNSTI4 736
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 1516
;1516:	}
LABELV $569
line 1518
;1517:
;1518:	if ( streq( self->s.v.classname, "item_artifact_super_damage" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $574
ARGP4
ADDRLP4 36
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $572
line 1519
;1519:	{
line 1520
;1520:		other->super_time = 1;
ADDRGP4 other
INDIRP4
CNSTI4 764
ADDP4
CNSTF4 1065353216
ASGNF4
line 1521
;1521:		other->super_damage_finished = g_globalvars.time + 30;
ADDRGP4 other
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 1522
;1522:	}
LABELV $572
line 1523
;1523:	activator = other;
ADDRGP4 activator
ADDRGP4 other
INDIRP4
ASGNP4
line 1524
;1524:	SUB_UseTargets(  );	// fire all targets / killtargets
ADDRGP4 SUB_UseTargets
CALLV
pop
line 1525
;1525:}
LABELV $529
endproc powerup_touch 40 20
export SP_item_artifact_invulnerability
proc SP_item_artifact_invulnerability 16 28
line 1531
;1526:
;1527:/*QUAKED item_artifact_invulnerability (0 .5 .8) (-16 -16 -24) (16 16 32)
;1528:Player is invulnerable for 30 seconds
;1529:*/
;1530:void SP_item_artifact_invulnerability(  )
;1531:{
line 1532
;1532:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $577
line 1533
;1533:	{
line 1534
;1534:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1535
;1535:		return;
ADDRGP4 $576
JUMPV
LABELV $577
line 1537
;1536:	}
;1537:	self->s.v.touch = ( func_t ) powerup_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 powerup_touch
CVPU4 4
CVUI4 4
ASGNI4
line 1539
;1538:
;1539:	trap_precache_model( "progs/invulner.mdl" );
ADDRGP4 $579
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1540
;1540:	trap_precache_sound( "items/protect.wav" );
ADDRGP4 $580
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 1541
;1541:	trap_precache_sound( "items/protect2.wav" );
ADDRGP4 $581
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 1542
;1542:	trap_precache_sound( "items/protect3.wav" );
ADDRGP4 $582
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 1543
;1543:	self->s.v.noise = "items/protect.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $580
ASGNP4
line 1544
;1544:	setmodel( self, "progs/invulner.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $579
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1545
;1545:	self->s.v.netname = "Pentagram of Protection";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $583
ASGNP4
line 1546
;1546:	self->s.v.effects = ( int ) self->s.v.effects | EF_RED;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 128
BORI4
CVIF4 4
ASGNF4
line 1547
;1547:	self->s.v.items = IT_INVULNERABILITY;
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
CNSTF4 1233125376
ASGNF4
line 1548
;1548:	setsize( self, -16, -16, -24, 16, 16, 32 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 8
CNSTF4 3246391296
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 3250585600
ARGF4
ADDRLP4 12
CNSTF4 1098907648
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1549
;1549:	StartItem(  );
ADDRGP4 StartItem
CALLV
pop
line 1550
;1550:}
LABELV $576
endproc SP_item_artifact_invulnerability 16 28
export SP_item_artifact_envirosuit
proc SP_item_artifact_envirosuit 12 28
line 1556
;1551:
;1552:/*QUAKED item_artifact_envirosuit (0 .5 .8) (-16 -16 -24) (16 16 32)
;1553:Player takes no damage from water or slime for 30 seconds
;1554:*/
;1555:void SP_item_artifact_envirosuit(  )
;1556:{
line 1557
;1557:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $585
line 1558
;1558:	{
line 1559
;1559:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1560
;1560:		return;
ADDRGP4 $584
JUMPV
LABELV $585
line 1562
;1561:	}
;1562:	self->s.v.touch = ( func_t ) powerup_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 powerup_touch
CVPU4 4
CVUI4 4
ASGNI4
line 1564
;1563:
;1564:	trap_precache_model( "progs/suit.mdl" );
ADDRGP4 $587
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1565
;1565:	trap_precache_sound( "items/suit.wav" );
ADDRGP4 $588
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 1566
;1566:	trap_precache_sound( "items/suit2.wav" );
ADDRGP4 $589
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 1567
;1567:	self->s.v.noise = "items/suit.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $588
ASGNP4
line 1568
;1568:	setmodel( self, "progs/suit.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $587
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1569
;1569:	self->s.v.netname = "Biosuit";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $590
ASGNP4
line 1570
;1570:	self->s.v.items = IT_SUIT;
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
CNSTF4 1241513984
ASGNF4
line 1571
;1571:	setsize( self, -16, -16, -24, 16, 16, 32 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 4
CNSTF4 3246391296
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 3250585600
ARGF4
ADDRLP4 8
CNSTF4 1098907648
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1572
;1572:	StartItem(  );
ADDRGP4 StartItem
CALLV
pop
line 1573
;1573:}
LABELV $584
endproc SP_item_artifact_envirosuit 12 28
export SP_item_artifact_invisibility
proc SP_item_artifact_invisibility 12 28
line 1579
;1574:
;1575:/*QUAKED item_artifact_invisibility (0 .5 .8) (-16 -16 -24) (16 16 32)
;1576:Player is invisible for 30 seconds
;1577:*/
;1578:void SP_item_artifact_invisibility(  )
;1579:{
line 1580
;1580:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $592
line 1581
;1581:	{
line 1582
;1582:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1583
;1583:		return;
ADDRGP4 $591
JUMPV
LABELV $592
line 1585
;1584:	}
;1585:	self->s.v.touch = ( func_t ) powerup_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 powerup_touch
CVPU4 4
CVUI4 4
ASGNI4
line 1587
;1586:
;1587:	trap_precache_model( "progs/invisibl.mdl" );
ADDRGP4 $39
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1588
;1588:	trap_precache_sound( "items/inv1.wav" );
ADDRGP4 $38
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 1589
;1589:	trap_precache_sound( "items/inv2.wav" );
ADDRGP4 $594
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 1590
;1590:	trap_precache_sound( "items/inv3.wav" );
ADDRGP4 $595
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 1591
;1591:	self->s.v.noise = "items/inv1.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $38
ASGNP4
line 1592
;1592:	setmodel( self, "progs/invisibl.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $39
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1593
;1593:	self->s.v.netname = "Ring of Shadows";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $596
ASGNP4
line 1594
;1594:	self->s.v.items = IT_INVISIBILITY;
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
CNSTF4 1224736768
ASGNF4
line 1595
;1595:	setsize( self, -16, -16, -24, 16, 16, 32 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 4
CNSTF4 3246391296
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 3250585600
ARGF4
ADDRLP4 8
CNSTF4 1098907648
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1596
;1596:	StartItem(  );
ADDRGP4 StartItem
CALLV
pop
line 1597
;1597:}
LABELV $591
endproc SP_item_artifact_invisibility 12 28
export SP_item_artifact_super_damage
proc SP_item_artifact_super_damage 16 28
line 1603
;1598:
;1599:/*QUAKED item_artifact_super_damage (0 .5 .8) (-16 -16 -24) (16 16 32)
;1600:The next attack from the player will do 4x damage
;1601:*/
;1602:void SP_item_artifact_super_damage(  )
;1603:{
line 1604
;1604:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $598
line 1605
;1605:	{
line 1606
;1606:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1607
;1607:		return;
ADDRGP4 $597
JUMPV
LABELV $598
line 1609
;1608:	}
;1609:	self->s.v.touch = ( func_t ) powerup_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 powerup_touch
CVPU4 4
CVUI4 4
ASGNI4
line 1611
;1610:
;1611:	trap_precache_model( "progs/quaddama.mdl" );
ADDRGP4 $27
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 1612
;1612:	trap_precache_sound( "items/damage.wav" );
ADDRGP4 $26
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 1613
;1613:	trap_precache_sound( "items/damage2.wav" );
ADDRGP4 $600
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 1614
;1614:	trap_precache_sound( "items/damage3.wav" );
ADDRGP4 $601
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 1615
;1615:	self->s.v.noise = "items/damage.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $26
ASGNP4
line 1616
;1616:	setmodel( self, "progs/quaddama.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $27
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1617
;1617:	if ( deathmatch == 4 )
ADDRGP4 deathmatch
INDIRI4
CNSTI4 4
NEI4 $602
line 1618
;1618:		self->s.v.netname = "OctaPower";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $604
ASGNP4
ADDRGP4 $603
JUMPV
LABELV $602
line 1620
;1619:	else
;1620:		self->s.v.netname = "Quad Damage";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $605
ASGNP4
LABELV $603
line 1621
;1621:	self->s.v.items = IT_QUAD;
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
CNSTF4 1249902592
ASGNF4
line 1622
;1622:	self->s.v.effects = ( int ) self->s.v.effects | EF_BLUE;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 64
BORI4
CVIF4 4
ASGNF4
line 1623
;1623:	setsize( self, -16, -16, -24, 16, 16, 32 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 8
CNSTF4 3246391296
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 3250585600
ARGF4
ADDRLP4 12
CNSTF4 1098907648
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1624
;1624:	StartItem(  );
ADDRGP4 StartItem
CALLV
pop
line 1625
;1625:}
LABELV $597
endproc SP_item_artifact_super_damage 16 28
export BackpackTouch
proc BackpackTouch 84 20
line 1636
;1626:
;1627:/*
;1628:===============================================================================
;1629:
;1630:PLAYER BACKPACKS
;1631:
;1632:===============================================================================
;1633:*/
;1634:extern char *GrenadePrimeName[];
;1635:void BackpackTouch(  )
;1636:{
line 1638
;1637:	float   best;
;1638:	int		gotgren1 = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1639
;1639:	int		gotgren2 = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1641
;1640:
;1641:	if ( strneq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $18
ARGP4
ADDRLP4 12
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $607
line 1642
;1642:		return;
ADDRGP4 $606
JUMPV
LABELV $607
line 1643
;1643:	if ( other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $609
line 1644
;1644:		return;
ADDRGP4 $606
JUMPV
LABELV $609
line 1646
;1645:
;1646:	if ( other->s.v.button0 )
ADDRGP4 other
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
CNSTF4 0
EQF4 $611
line 1647
;1647:		return;
ADDRGP4 $606
JUMPV
LABELV $611
line 1648
;1648:	other->s.v.ammo_shells = other->s.v.ammo_shells + self->s.v.ammo_shells;
ADDRLP4 16
CNSTI4 320
ASGNI4
ADDRLP4 20
ADDRGP4 other
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1649
;1649:	other->s.v.ammo_nails = other->s.v.ammo_nails + self->s.v.ammo_nails;
ADDRLP4 24
CNSTI4 324
ASGNI4
ADDRLP4 28
ADDRGP4 other
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1650
;1650:	other->s.v.ammo_rockets = other->s.v.ammo_rockets + self->s.v.ammo_rockets;
ADDRLP4 32
CNSTI4 328
ASGNI4
ADDRLP4 36
ADDRGP4 other
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1651
;1651:	other->s.v.ammo_cells = other->s.v.ammo_cells + self->s.v.ammo_cells;
ADDRLP4 40
CNSTI4 332
ASGNI4
ADDRLP4 44
ADDRGP4 other
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1652
;1652:	if ( tf_data.gren2box & BP_TYPE_HEALTH )
ADDRGP4 tf_data+152
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $613
line 1653
;1653:		if ( self->ammo_medikit > 0 )
ADDRGP4 self
INDIRP4
CNSTI4 1044
ADDP4
INDIRI4
CNSTI4 0
LEI4 $616
line 1654
;1654:		{
line 1656
;1655:
;1656:			best = other->s.v.max_health - other->s.v.health;
ADDRLP4 48
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 48
INDIRP4
CNSTI4 416
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1657
;1657:			if ( best > 0 )
ADDRLP4 8
INDIRF4
CNSTF4 0
LEF4 $618
line 1658
;1658:			{
line 1659
;1659:				if ( best >= self->ammo_medikit )
ADDRLP4 8
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 1044
ADDP4
INDIRI4
CVIF4 4
LTF4 $620
line 1660
;1660:				{
line 1661
;1661:					T_Heal( other, self->ammo_medikit, 0 );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 1044
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 T_Heal
CALLI4
pop
line 1662
;1662:					self->ammo_medikit = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1044
ADDP4
CNSTI4 0
ASGNI4
line 1663
;1663:				} else
ADDRGP4 $621
JUMPV
LABELV $620
line 1664
;1664:				{
line 1665
;1665:					T_Heal( other, best, 0 );
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 T_Heal
CALLI4
pop
line 1666
;1666:					self->ammo_medikit = self->ammo_medikit - best;
ADDRLP4 52
ADDRGP4 self
INDIRP4
CNSTI4 1044
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CVIF4 4
ADDRLP4 8
INDIRF4
SUBF4
CVFI4 4
ASGNI4
line 1667
;1667:				}
LABELV $621
line 1669
;1668:
;1669:			}
LABELV $618
line 1670
;1670:			if ( self->ammo_medikit > 0 && other->playerclass == PC_MEDIC )
ADDRGP4 self
INDIRP4
CNSTI4 1044
ADDP4
INDIRI4
CNSTI4 0
LEI4 $622
ADDRGP4 other
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 5
NEI4 $622
line 1671
;1671:				other->ammo_medikit = other->ammo_medikit + self->ammo_medikit;
ADDRLP4 52
CNSTI4 1044
ASGNI4
ADDRLP4 56
ADDRGP4 other
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
ADDRGP4 self
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
ADDI4
ASGNI4
LABELV $622
line 1672
;1672:		}
LABELV $616
LABELV $613
line 1673
;1673:	if ( tf_data.gren2box & BP_TYPE_ARMOR )
ADDRGP4 tf_data+152
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $624
line 1674
;1674:		if ( other->s.v.armorvalue * other->s.v.armortype < self->s.v.armorvalue * self->s.v.armortype )
ADDRLP4 48
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 52
CNSTI4 428
ASGNI4
ADDRLP4 56
CNSTI4 424
ASGNI4
ADDRLP4 60
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
MULF4
ADDRLP4 60
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
MULF4
GEF4 $627
line 1675
;1675:		{
line 1676
;1676:			other->s.v.armorvalue = self->s.v.armorvalue;
ADDRLP4 64
CNSTI4 428
ASGNI4
ADDRGP4 other
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 1677
;1677:			other->s.v.armortype = self->s.v.armortype;
ADDRLP4 68
CNSTI4 424
ASGNI4
ADDRGP4 other
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 1678
;1678:		}
LABELV $627
LABELV $624
line 1679
;1679:	if ( tf_data.gren2box & BP_GREN_BYTYPE )
ADDRGP4 tf_data+152
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $629
line 1680
;1680:	{
line 1681
;1681:		if ( self->tp_grenades_1 == other->tp_grenades_1 )
ADDRLP4 64
CNSTI4 848
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRI4
ADDRGP4 other
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRI4
NEI4 $632
line 1682
;1682:		{
line 1683
;1683:			other->no_grenades_1 = other->no_grenades_1 + self->no_grenades_1;
ADDRLP4 68
CNSTI4 840
ASGNI4
ADDRLP4 72
ADDRGP4 other
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
ADDRGP4 self
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1684
;1684:			gotgren1 = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1685
;1685:		}
LABELV $632
line 1686
;1686:		if ( self->tp_grenades_2 == other->tp_grenades_2 )
ADDRLP4 68
CNSTI4 852
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRI4
ADDRGP4 other
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRI4
NEI4 $630
line 1687
;1687:		{
line 1688
;1688:			other->no_grenades_2 = other->no_grenades_2 + self->no_grenades_2;
ADDRLP4 72
CNSTI4 844
ASGNI4
ADDRLP4 76
ADDRGP4 other
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
ADDRGP4 self
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1689
;1689:			gotgren2 = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1690
;1690:		}
line 1691
;1691:	} else if ( tf_data.gren2box & BP_GREN )
ADDRGP4 $630
JUMPV
LABELV $629
ADDRGP4 tf_data+152
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $636
line 1692
;1692:	{
line 1693
;1693:		other->no_grenades_1 = other->no_grenades_1 + self->no_grenades_1;
ADDRLP4 64
CNSTI4 840
ASGNI4
ADDRLP4 68
ADDRGP4 other
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
ADDRGP4 self
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1694
;1694:		other->no_grenades_2 = other->no_grenades_2 + self->no_grenades_2;
ADDRLP4 72
CNSTI4 844
ASGNI4
ADDRLP4 76
ADDRGP4 other
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
ADDRGP4 self
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1695
;1695:		gotgren1 = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1696
;1696:		gotgren2 = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1697
;1697:	}
LABELV $636
LABELV $630
line 1698
;1698:	if ( tf_data.gren2box & BP_TYPE_DETPACK )
ADDRGP4 tf_data+152
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $639
line 1699
;1699:	{
line 1700
;1700:		if ( self->ammo_detpack > 0 && other->playerclass == PC_DEMOMAN )
ADDRGP4 self
INDIRP4
CNSTI4 1052
ADDP4
INDIRI4
CNSTI4 0
LEI4 $642
ADDRGP4 other
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 4
NEI4 $642
line 1701
;1701:			other->ammo_detpack += self->ammo_detpack;
ADDRLP4 64
CNSTI4 1052
ASGNI4
ADDRLP4 68
ADDRGP4 other
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
ADDRGP4 self
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRI4
ADDI4
ASGNI4
LABELV $642
line 1702
;1702:	}
LABELV $639
line 1705
;1703:
;1704:
;1705:	bound_other_ammo( other );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 bound_other_ammo
CALLV
pop
line 1706
;1706:	G_sprint( other, 0, "You get " );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $644
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1707
;1707:	if ( self->s.v.ammo_shells )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 0
EQF4 $645
line 1708
;1708:	{
line 1709
;1709:		G_sprint( other, 0, "%.0f shells ", self->s.v.ammo_shells );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $647
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 1710
;1710:	}
LABELV $645
line 1711
;1711:	if ( self->s.v.ammo_nails )
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 0
EQF4 $648
line 1712
;1712:	{
line 1713
;1713:		G_sprint( other, 0, "%.0f nails ", self->s.v.ammo_nails );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $650
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 1714
;1714:	}
LABELV $648
line 1715
;1715:	if ( self->s.v.ammo_rockets )
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 0
EQF4 $651
line 1716
;1716:	{
line 1717
;1717:		G_sprint( other, 0, "%.0f rockets ", self->s.v.ammo_rockets );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $653
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 1718
;1718:	}
LABELV $651
line 1719
;1719:	if ( self->s.v.ammo_cells )
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 0
EQF4 $654
line 1720
;1720:	{
line 1721
;1721:		G_sprint( other, 0, "%.0f cells ", self->s.v.ammo_cells );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $656
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 1722
;1722:	}
LABELV $654
line 1723
;1723:	if ( self->s.v.armorvalue && other->playerclass == PC_ENGINEER && other->s.v.ammo_cells < other->maxammo_cells )
ADDRGP4 self
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
CNSTF4 0
EQF4 $657
ADDRLP4 64
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 9
NEI4 $657
ADDRLP4 64
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 912
ADDP4
INDIRI4
CVIF4 4
GEF4 $657
line 1724
;1724:	{
line 1725
;1725:		G_sprint( other, 0, "%.0f metal ", self->s.v.armorvalue );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $659
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 1726
;1726:		other->s.v.ammo_cells += self->s.v.armorvalue;
ADDRLP4 68
ADDRGP4 other
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1727
;1727:		if ( other->s.v.ammo_cells > other->maxammo_cells )
ADDRLP4 72
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 912
ADDP4
INDIRI4
CVIF4 4
LEF4 $660
line 1728
;1728:			other->s.v.ammo_cells = other->maxammo_cells;
ADDRLP4 76
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 332
ADDP4
ADDRLP4 76
INDIRP4
CNSTI4 912
ADDP4
INDIRI4
CVIF4 4
ASGNF4
LABELV $660
line 1729
;1729:	}
LABELV $657
line 1732
;1730:
;1731:
;1732:	if ( self->no_grenades_1 && gotgren1 )
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 840
ADDP4
INDIRI4
ADDRLP4 68
INDIRI4
EQI4 $662
ADDRLP4 0
INDIRI4
ADDRLP4 68
INDIRI4
EQI4 $662
line 1733
;1733:	{
line 1734
;1734:		G_sprint( other, 0, "%d %s", self->no_grenades_1,
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $664
ARGP4
ADDRLP4 76
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 840
ADDP4
INDIRI4
ARGI4
ADDRLP4 76
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 11
LEI4 $666
ADDRLP4 72
CNSTI4 0
ASGNI4
ADDRGP4 $667
JUMPV
LABELV $666
ADDRLP4 72
ADDRGP4 self
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
ASGNI4
LABELV $667
ADDRLP4 72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 GrenadePrimeName
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1736
;1735:			  GrenadePrimeName[( self->tp_grenades_1 > 11 ) ? 0 : self->tp_grenades_1] );
;1736:		if ( self->no_grenades_1 != 1 )
ADDRGP4 self
INDIRP4
CNSTI4 840
ADDP4
INDIRI4
CNSTI4 1
EQI4 $668
line 1737
;1737:			G_sprint( other, 0, "s" );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $670
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $668
line 1738
;1738:		G_sprint( other, 0, "  " );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $671
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1739
;1739:	}
LABELV $662
line 1740
;1740:	if ( self->no_grenades_2 && gotgren2 )
ADDRLP4 72
CNSTI4 0
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 844
ADDP4
INDIRI4
ADDRLP4 72
INDIRI4
EQI4 $672
ADDRLP4 4
INDIRI4
ADDRLP4 72
INDIRI4
EQI4 $672
line 1741
;1741:	{
line 1742
;1742:		G_sprint( other, 0, "%d %s", self->no_grenades_2,
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $664
ARGP4
ADDRLP4 80
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 844
ADDP4
INDIRI4
ARGI4
ADDRLP4 80
INDIRP4
CNSTI4 852
ADDP4
INDIRI4
CNSTI4 11
LEI4 $675
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRGP4 $676
JUMPV
LABELV $675
ADDRLP4 76
ADDRGP4 self
INDIRP4
CNSTI4 852
ADDP4
INDIRI4
ASGNI4
LABELV $676
ADDRLP4 76
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 GrenadePrimeName
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1745
;1743:			  GrenadePrimeName[( self->tp_grenades_2 > 11 ) ? 0 : self->tp_grenades_2] );
;1744:
;1745:		if ( self->no_grenades_2 != 1 )
ADDRGP4 self
INDIRP4
CNSTI4 844
ADDP4
INDIRI4
CNSTI4 1
EQI4 $677
line 1746
;1746:			G_sprint( other, 0, "s" );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $670
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $677
line 1747
;1747:		G_sprint( other, 0, "  " );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $671
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1748
;1748:	}
LABELV $672
line 1749
;1749:	G_sprint( other, PRINT_LOW, "\n" );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $679
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1751
;1750:// backpack touch sound
;1751:	sound( other, CHAN_ITEM, "weapons/lock4.wav", 1, ATTN_NORM );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $410
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
line 1752
;1752:	stuffcmd( other, "bf\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $21
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1754
;1753:
;1754:	ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 1755
;1755:	self = other;
ADDRGP4 self
ADDRGP4 other
INDIRP4
ASGNP4
line 1756
;1756:	W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 1757
;1757:}
LABELV $606
endproc BackpackTouch 84 20
export DropBackpack
proc DropBackpack 76 28
line 1760
;1758:
;1759:void DropBackpack(  )
;1760:{
line 1761
;1761:	if ( tf_data.cb_prematch_time + 3 > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
CNSTF4 1077936128
ADDF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $681
line 1762
;1762:		return;
ADDRGP4 $680
JUMPV
LABELV $681
line 1763
;1763:	if ( !( self->s.v.ammo_shells + self->s.v.ammo_nails + self->s.v.ammo_rockets + self->s.v.ammo_cells ) )
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
ADDF4
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ADDF4
ADDRLP4 0
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ADDF4
CNSTF4 0
NEF4 $685
line 1764
;1764:		return;
ADDRGP4 $680
JUMPV
LABELV $685
line 1765
;1765:	newmis = spawn(  );
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 4
INDIRP4
ASGNP4
line 1766
;1766:	g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 1767
;1767:	VectorCopy( self->s.v.origin, newmis->s.v.origin );
ADDRLP4 8
CNSTI4 156
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12
CNSTI4 160
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 16
CNSTI4 164
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
INDIRF4
ASGNF4
line 1768
;1768:	newmis->s.v.origin[2] -= 24;
ADDRLP4 8
ADDRGP4 newmis
INDIRP4
CNSTI4 164
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 1770
;1769:
;1770:	newmis->s.v.classname = "item_backpack";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $688
ASGNP4
line 1771
;1771:	newmis->s.v.ammo_shells = self->s.v.ammo_shells;
ADDRLP4 12
CNSTI4 320
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 1772
;1772:	newmis->s.v.ammo_nails = self->s.v.ammo_nails;
ADDRLP4 16
CNSTI4 324
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
INDIRF4
ASGNF4
line 1773
;1773:	newmis->s.v.ammo_rockets = self->s.v.ammo_rockets;
ADDRLP4 20
CNSTI4 328
ASGNI4
ADDRGP4 newmis
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
line 1774
;1774:	newmis->s.v.ammo_cells = self->s.v.ammo_cells;
ADDRLP4 24
CNSTI4 332
ASGNI4
ADDRGP4 newmis
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
line 1775
;1775:	newmis->s.v.armorvalue = self->s.v.armorvalue;
ADDRLP4 28
CNSTI4 428
ASGNI4
ADDRGP4 newmis
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
line 1777
;1776:
;1777:	newmis->s.v.armortype = self->s.v.armortype;
ADDRLP4 32
CNSTI4 424
ASGNI4
ADDRGP4 newmis
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
line 1778
;1778:	newmis->ammo_detpack = self->ammo_detpack;
ADDRLP4 36
CNSTI4 1052
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 1779
;1779:	newmis->ammo_medikit = self->ammo_medikit;
ADDRLP4 40
CNSTI4 1044
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 1780
;1780:	newmis->no_grenades_1 = self->no_grenades_1;
ADDRLP4 44
CNSTI4 840
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 1781
;1781:	newmis->no_grenades_2 = self->no_grenades_2;
ADDRLP4 48
CNSTI4 844
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 1782
;1782:	newmis->tp_grenades_1 = self->tp_grenades_1;
ADDRLP4 52
CNSTI4 848
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 1783
;1783:	newmis->tp_grenades_2 = self->tp_grenades_2;
ADDRLP4 56
CNSTI4 852
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 1785
;1784:
;1785:	newmis->s.v.velocity[2] = 300;
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1133903872
ASGNF4
line 1786
;1786:	newmis->s.v.velocity[0] = -100 + ( g_random(  ) * 200 );
ADDRLP4 60
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1128792064
ADDRLP4 60
INDIRF4
MULF4
CNSTF4 3267887104
ADDF4
ASGNF4
line 1787
;1787:	newmis->s.v.velocity[1] = -100 + ( g_random(  ) * 200 );
ADDRLP4 64
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1128792064
ADDRLP4 64
INDIRF4
MULF4
CNSTF4 3267887104
ADDF4
ASGNF4
line 1788
;1788:	newmis->s.v.flags = FL_ITEM;
ADDRGP4 newmis
INDIRP4
CNSTI4 404
ADDP4
CNSTF4 1132462080
ASGNF4
line 1789
;1789:	newmis->s.v.solid = SOLID_TRIGGER;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 1790
;1790:	newmis->s.v.movetype = MOVETYPE_TOSS;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 1791
;1791:	setmodel( newmis, "progs/backpack.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $689
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1792
;1792:	setsize( newmis, -16, -16, 0, 16, 16, 56 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 68
CNSTF4 3246391296
ASGNF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 72
CNSTF4 1098907648
ASGNF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
CNSTF4 1113587712
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1793
;1793:	newmis->s.v.touch = ( func_t ) BackpackTouch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 BackpackTouch
CVPU4 4
CVUI4 4
ASGNI4
line 1795
;1794:
;1795:	newmis->s.v.nextthink = g_globalvars.time + 120;	// remove after 2 minutes
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 1796
;1796:	newmis->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 1797
;1797:}
LABELV $680
endproc DropBackpack 76 28
import GrenadePrimeName
import key_sound2
import key_names2
import key_models2
import key_sound1
import key_names1
import key_models1
import GrenadeNames
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
LABELV $689
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $688
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $679
byte 1 10
byte 1 0
align 1
LABELV $671
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $670
byte 1 115
byte 1 0
align 1
LABELV $664
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $659
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 109
byte 1 101
byte 1 116
byte 1 97
byte 1 108
byte 1 32
byte 1 0
align 1
LABELV $656
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 0
align 1
LABELV $653
byte 1 37
byte 1 46
byte 1 48
byte 1 102
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
LABELV $650
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 32
byte 1 0
align 1
LABELV $647
byte 1 37
byte 1 46
byte 1 48
byte 1 102
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
LABELV $644
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 0
align 1
LABELV $605
byte 1 81
byte 1 117
byte 1 97
byte 1 100
byte 1 32
byte 1 68
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $604
byte 1 79
byte 1 99
byte 1 116
byte 1 97
byte 1 80
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $601
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $600
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $596
byte 1 82
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 83
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 115
byte 1 0
align 1
LABELV $595
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 118
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $594
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 118
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $590
byte 1 66
byte 1 105
byte 1 111
byte 1 115
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $589
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 115
byte 1 117
byte 1 105
byte 1 116
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $588
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 115
byte 1 117
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $587
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 115
byte 1 117
byte 1 105
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $583
byte 1 80
byte 1 101
byte 1 110
byte 1 116
byte 1 97
byte 1 103
byte 1 114
byte 1 97
byte 1 109
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 80
byte 1 114
byte 1 111
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $582
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $581
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $580
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $579
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 118
byte 1 117
byte 1 108
byte 1 110
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $574
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 95
byte 1 115
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $564
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 95
byte 1 101
byte 1 110
byte 1 118
byte 1 105
byte 1 114
byte 1 111
byte 1 115
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $551
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $550
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 118
byte 1 117
byte 1 108
byte 1 110
byte 1 101
byte 1 114
byte 1 97
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $528
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 101
byte 1 110
byte 1 100
byte 1 52
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $525
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 101
byte 1 110
byte 1 100
byte 1 51
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $522
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 101
byte 1 110
byte 1 100
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $519
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 101
byte 1 110
byte 1 100
byte 1 49
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $516
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 114
byte 1 117
byte 1 110
byte 1 101
byte 1 107
byte 1 101
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $515
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 115
byte 1 105
byte 1 103
byte 1 105
byte 1 108
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $507
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 114
byte 1 117
byte 1 110
byte 1 101
byte 1 33
byte 1 0
align 1
LABELV $456
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $444
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $443
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 48
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $442
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 49
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $436
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $435
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 48
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $434
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 49
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $428
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $427
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 48
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $426
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 49
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $420
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $419
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 48
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $418
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 49
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $410
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 52
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $379
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $372
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $371
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $368
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $356
byte 1 84
byte 1 104
byte 1 117
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 98
byte 1 111
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $355
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 103
byte 1 95
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $351
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 32
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $350
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 103
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
LABELV $346
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $345
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 103
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $341
byte 1 83
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 78
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $340
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 103
byte 1 95
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $336
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $335
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 103
byte 1 95
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $331
byte 1 68
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 45
byte 1 98
byte 1 97
byte 1 114
byte 1 114
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $330
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 103
byte 1 95
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $324
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 107
byte 1 117
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $323
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $322
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 99
byte 1 104
byte 1 58
byte 1 32
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $317
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 95
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $310
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 95
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $303
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 108
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $296
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 95
byte 1 115
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $289
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 95
byte 1 115
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $282
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 95
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $205
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $201
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $188
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 109
byte 1 101
byte 1 116
byte 1 97
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $183
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $158
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 73
byte 1 110
byte 1 118
byte 1 0
align 1
LABELV $155
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $152
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $132
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 107
byte 1 105
byte 1 116
byte 1 95
byte 1 114
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $117
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 114
byte 1 101
byte 1 99
byte 1 101
byte 1 105
byte 1 118
byte 1 101
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 10
byte 1 0
align 1
LABELV $116
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 33
byte 1 0
align 1
LABELV $108
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 103
byte 1 97
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 107
byte 1 105
byte 1 116
byte 1 32
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 10
byte 1 0
align 1
LABELV $79
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $78
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 98
byte 1 104
byte 1 50
byte 1 53
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $77
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 114
byte 1 95
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $76
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 98
byte 1 104
byte 1 49
byte 1 48
byte 1 48
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $73
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 114
byte 1 95
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $72
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 98
byte 1 104
byte 1 49
byte 1 48
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $45
byte 1 66
byte 1 111
byte 1 110
byte 1 117
byte 1 115
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 102
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 32
byte 1 39
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $39
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $38
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 118
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $35
byte 1 37
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 82
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 97
byte 1 105
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $27
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 113
byte 1 117
byte 1 97
byte 1 100
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $26
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $23
byte 1 37
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 81
byte 1 117
byte 1 97
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 97
byte 1 105
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $22
byte 1 0
align 1
LABELV $21
byte 1 98
byte 1 102
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
LABELV $14
byte 1 110
byte 1 111
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $12
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 98
byte 1 107
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
