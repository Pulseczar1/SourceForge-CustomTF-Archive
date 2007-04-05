export MagTimer
code
proc MagTimer 20 20
file "..\src\megatf\drop1.c"
line 33
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
;21: *  $Id: drop1.c,v 1.00 2006/09/15 20:12:21 XavioR Exp $
;22: */
;23:#include "g_local.h"
;24:void FlashGrenadeExplode2 ( );
;25:
;26:// Only droppables are handled here. 
;27:// Other drop1 functions are handled in the class files
;28:
;29:/*****
;30:		Misc Functions
;31:						*****/
;32:void MagTimer ( )
;33:{
line 37
;34:	gedict_t *te;
;35:	//char t_left;
;36:
;37:	te = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 38
;38:	te->option5 = te->option5 - 0.5;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 1788
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CVIF4 4
CNSTF4 1056964608
SUBF4
CVFI4 4
ASGNI4
line 41
;39:	//t_left = ( char ) te->option5;
;40:
;41:	sound ( te, 0, "ambient/100hzhum.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $12
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
line 42
;42:	setorigin( te, self->s.v.origin[0], self->s.v.origin[1], self->s.v.origin[2] );
ADDRLP4 0
INDIRP4
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
ADDRGP4 setorigin
CALLV
pop
line 43
;43:	G_centerprint( te, "You are stuck on a mag mine!\n%d\n", te->option5 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $13
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1788
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_centerprint
CALLV
pop
line 45
;44:	//G_centerprint( te, "You are stuck on a mag mine!\n", t_left, "\n" );
;45:	if ( te->option5 < 2 ) {
ADDRLP4 0
INDIRP4
CNSTI4 1788
ADDP4
INDIRI4
CNSTI4 2
GEI4 $14
line 46
;46:		te->option5 = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1788
ADDP4
CNSTI4 0
ASGNI4
line 47
;47:		G_sprint ( PROG_TO_EDICT(te->s.v.enemy), 2, "Your Mag Mine died...\n" );
ADDRLP4 0
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $16
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 48
;48:		PROG_TO_EDICT(te->s.v.enemy)->has_syringe = 1;
ADDRLP4 0
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts+1764
ADDP4
CNSTI4 1
ASGNI4
line 49
;49:		dremove ( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 50
;50:		return;
ADDRGP4 $11
JUMPV
LABELV $14
line 52
;51:	}
;52:	self->s.v.nextthink = ( g_globalvars.time + 0.5 );
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 53
;53:}
LABELV $11
endproc MagTimer 20 20
export MagMineActivate
proc MagMineActivate 8 16
line 56
;54:
;55:void MagMineActivate ( )
;56:{
line 59
;57://	gedict_t *owner = self->s.v.owner;
;58:
;59:	if ( other->option == 0 )
ADDRGP4 other
INDIRP4
CNSTI4 1780
ADDP4
INDIRI4
CNSTI4 0
NEI4 $20
line 60
;60:	{
line 61
;61:		PROG_TO_EDICT( self->s.v.owner )->has_syringe = 1;
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+1764
ADDP4
CNSTI4 1
ASGNI4
line 62
;62:		newmis = spawn ( );
ADDRLP4 0
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 0
INDIRP4
ASGNP4
line 63
;63:		newmis->s.v.classname = "timer";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $23
ASGNP4
line 64
;64:		newmis->s.v.netname = " FlashTimer";
ADDRGP4 newmis
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $24
ASGNP4
line 65
;65:		newmis->team_no = PROG_TO_EDICT( self->s.v.owner )->team_no;
ADDRGP4 newmis
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
line 66
;66:		newmis->s.v.owner = EDICT_TO_PROG( other );
ADDRGP4 newmis
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
line 67
;67:		other->s.v.enemy = self->s.v.owner;
ADDRGP4 other
INDIRP4
CNSTI4 400
ADDP4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
line 68
;68:		newmis->s.v.think = ( func_t ) MagTimer;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 MagTimer
CVPU4 4
CVUI4 4
ASGNI4
line 69
;69:		newmis->s.v.nextthink = g_globalvars.time + 1;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 70
;70:		setorigin ( newmis, other->s.v.origin[0], other->s.v.origin[1], other->s.v.origin[2] );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 other
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
line 72
;71:		//newmis->s.v.origin = other->s.v.origin;
;72:		other->is_squating = 0;
ADDRGP4 other
INDIRP4
CNSTI4 1776
ADDP4
CNSTI4 0
ASGNI4
line 73
;73:	}
LABELV $20
line 74
;74:	other->option5 = floor ( other->s.v.armorvalue * 0.25 ) + 3;
ADDRLP4 0
ADDRGP4 other
INDIRP4
ASGNP4
CNSTF4 1048576000
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
MULF4
ARGF4
ADDRLP4 4
ADDRGP4 floor
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 1788
ADDP4
ADDRLP4 4
INDIRF4
CNSTF4 1077936128
ADDF4
CVFI4 4
ASGNI4
line 76
;75:
;76:	if ( other->option5 > 15 )
ADDRGP4 other
INDIRP4
CNSTI4 1788
ADDP4
INDIRI4
CNSTI4 15
LEI4 $27
line 77
;77:		other->option5 = 15;
ADDRGP4 other
INDIRP4
CNSTI4 1788
ADDP4
CNSTI4 15
ASGNI4
LABELV $27
line 78
;78:}
LABELV $19
endproc MagMineActivate 8 16
export RemoveAlarmMine
proc RemoveAlarmMine 4 12
line 84
;79:
;80:/*****
;81:	Remove Mine Functions
;82:						*****/
;83:void RemoveAlarmMine ( )
;84:{
line 85
;85:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 87
;86:
;87:	G_sprint( owner, 1, "Your batteries died in an alarm.. :(\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $30
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 88
;88:	dremove ( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 89
;89:	return;
LABELV $29
endproc RemoveAlarmMine 4 12
export RemoveAIDSMine
proc RemoveAIDSMine 4 12
line 93
;90:}
;91:
;92:void RemoveAIDSMine ( )
;93:{
line 94
;94:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 96
;95:
;96:	G_sprint( owner, 1, "Your syringe is sterile...\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $32
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 97
;97:	PROG_TO_EDICT( self->s.v.owner )->has_syringe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+1764
ADDP4
CNSTI4 0
ASGNI4
line 98
;98:	dremove ( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 99
;99:	return;
LABELV $31
endproc RemoveAIDSMine 4 12
export RemoveFlashMine
proc RemoveFlashMine 4 12
line 103
;100:}
;101:
;102:void RemoveFlashMine ( )
;103:{
line 104
;104:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 106
;105:
;106:	G_sprint( owner, 1, "Your Flash mine fizzled...\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $35
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 107
;107:	PROG_TO_EDICT( self->s.v.owner )->has_syringe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+1764
ADDP4
CNSTI4 0
ASGNI4
line 108
;108:	dremove ( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 109
;109:	return;
LABELV $34
endproc RemoveFlashMine 4 12
export RemoveSpikeTrap
proc RemoveSpikeTrap 4 12
line 113
;110:}
;111:
;112:void RemoveSpikeTrap ()
;113:{
line 114
;114:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 116
;115:
;116:	G_sprint( owner, 1, "Your Spike Trap is gone...\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $38
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 117
;117:	PROG_TO_EDICT( self->s.v.owner )->has_syringe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+1764
ADDP4
CNSTI4 0
ASGNI4
line 118
;118:	dremove ( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 119
;119:	return;
LABELV $37
endproc RemoveSpikeTrap 4 12
export RemoveMagnetMine
proc RemoveMagnetMine 4 12
line 123
;120:}
;121:
;122:void RemoveMagnetMine ( )
;123:{
line 124
;124:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 126
;125:
;126:	G_sprint( owner, 1, "Your Mag Mine is gone...\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $41
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 127
;127:	PROG_TO_EDICT( self->s.v.owner )->has_syringe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+1764
ADDP4
CNSTI4 0
ASGNI4
line 128
;128:	dremove ( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 129
;129:	return;
LABELV $40
endproc RemoveMagnetMine 4 12
export AlarmMineTouch
proc AlarmMineTouch 12 20
line 136
;130:}
;131:
;132:/*****
;133:	Mine Touch Functions
;134:						*****/
;135:void AlarmMineTouch ( )
;136:{
line 137
;137:	if ( self->pausetime > g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $44
line 138
;138:		return;
ADDRGP4 $43
JUMPV
LABELV $44
line 139
;139:	if ( !streq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $49
ARGP4
ADDRLP4 0
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $47
line 140
;140:		return;
ADDRGP4 $43
JUMPV
LABELV $47
line 141
;141:	if ( other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $50
line 142
;142:		return;
ADDRGP4 $43
JUMPV
LABELV $50
line 144
;143:
;144:	if ( other->team_no == PROG_TO_EDICT( self->s.v.owner )->team_no )
ADDRGP4 other
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
NEI4 $52
line 145
;145:	{
line 147
;146://		if ((((other.velocity_x < 5) && (other.velocity_y < 5)) && (other.is_squating == 1)))
;147:		if ( ((other->s.v.velocity[0] > 5) && (other->s.v.velocity[1] < 5)) && (other->is_squating == 1) ) {
ADDRLP4 4
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 8
CNSTF4 1084227584
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $43
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $43
ADDRLP4 4
INDIRP4
CNSTI4 1776
ADDP4
INDIRI4
CNSTI4 1
NEI4 $43
line 148
;148:			self->s.v.think = ( func_t ) RemoveAlarmMine;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 RemoveAlarmMine
CVPU4 4
CVUI4 4
ASGNI4
line 149
;149:			self->s.v.nextthink = g_globalvars.time + .2;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 150
;150:		}
line 152
;151:		else
;152:			return;
line 153
;153:	}
ADDRGP4 $53
JUMPV
LABELV $52
line 154
;154:	else {
line 155
;155:		other->s.v.effects = ( int ) other->s.v.effects | EF_BRIGHTLIGHT;
ADDRLP4 4
ADDRGP4 other
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
CNSTI4 4
BORI4
CVIF4 4
ASGNF4
line 156
;156:		sound( self, CHAN_ITEM, "misc/enemy.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $58
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
line 157
;157:		G_sprint( other, 1, "You have tripped an ALARM!\n" );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $59
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 159
;158://		G_sprint( other, 1, "Your ALARM was tripped!\n" );	// not sure why mtf prints this 2x
;159:		G_sprint( PROG_TO_EDICT( self->s.v.owner ), 1, "        Your ALARM was tripped!\n" );
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $60
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 160
;160:		self->pausetime = ( g_globalvars.time + 5 );
ADDRGP4 self
INDIRP4
CNSTI4 676
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 161
;161:	}
LABELV $53
line 162
;162:	self->s.v.nextthink = g_globalvars.time + 10;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 164
;163:
;164:	if ( ( int ) self->s.v.effects & 4 )
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CVFI4 4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $63
line 165
;165:		other->s.v.effects = ( int ) other->s.v.effects - ( ( int ) other->s.v.effects & 8 );
ADDRLP4 4
ADDRGP4 other
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 8
BANDI4
SUBI4
CVIF4 4
ASGNF4
LABELV $63
line 166
;166:}
LABELV $43
endproc AlarmMineTouch 12 20
export AIDSMineTouch
proc AIDSMineTouch 24 20
line 169
;167:
;168:void AIDSMineTouch ( )
;169:{
line 171
;170:	gedict_t *BioInfection;
;171:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 173
;172:
;173:	if ( self->pausetime > g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $66
line 174
;174:		return;
ADDRGP4 $65
JUMPV
LABELV $66
line 175
;175:	if ( !streq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $49
ARGP4
ADDRLP4 8
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $69
line 176
;176:		return;
ADDRGP4 $65
JUMPV
LABELV $69
line 177
;177:	if ( other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $71
line 178
;178:		return;
ADDRGP4 $65
JUMPV
LABELV $71
line 179
;179:	if ( other->team_no == PROG_TO_EDICT( self->s.v.owner )->team_no )
ADDRGP4 other
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
NEI4 $73
line 180
;180:		return;
ADDRGP4 $65
JUMPV
LABELV $73
line 182
;181:
;182:	if ( other->playerclass == PC_MEDIC ) {
ADDRGP4 other
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 5
NEI4 $76
line 183
;183:		RemoveAIDSMine( );
ADDRGP4 RemoveAIDSMine
CALLV
pop
line 184
;184:		G_sprint (other, 2, "You removed an enemy syringe! :)\n");
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $78
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 185
;185:		G_sprint (owner, 2, " Syringe removed by enemy medic!\n");
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $79
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 186
;186:		return;
ADDRGP4 $65
JUMPV
LABELV $76
line 189
;187:	}
;188:
;189:	if ( streq( other->s.v.classname, "player" ) ) {
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $49
ARGP4
ADDRLP4 12
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $80
line 191
;190:		//deathmsg = 14;
;191:		if ( other->playerclass == PC_MEDIC )
ADDRGP4 other
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 5
NEI4 $82
line 192
;192:			return;
ADDRGP4 $65
JUMPV
LABELV $82
line 193
;193:		other->tfstate = other->tfstate | TFSTATE_INFECTED;
ADDRLP4 16
ADDRGP4 other
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 194
;194:		BioInfection = spawn(  );
ADDRLP4 20
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 195
;195:		BioInfection->s.v.classname = "timer";
ADDRLP4 4
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $23
ASGNP4
line 196
;196:		BioInfection->s.v.owner = EDICT_TO_PROG( other );
ADDRLP4 4
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
line 197
;197:		BioInfection->s.v.nextthink = g_globalvars.time + 2;
ADDRLP4 4
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 198
;198:		BioInfection->s.v.think = ( func_t ) BioInfection_Decay;
ADDRLP4 4
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 BioInfection_Decay
CVPU4 4
CVUI4 4
ASGNI4
line 199
;199:		BioInfection->s.v.enemy = EDICT_TO_PROG( owner );
ADDRLP4 4
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
line 200
;200:		other->infection_team_no = self->team_no;
ADDRGP4 other
INDIRP4
CNSTI4 968
ADDP4
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
line 201
;201:	}
LABELV $80
line 202
;202:	sound (self, 3, "player/mpain6.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $85
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
line 203
;203:	G_sprint ( other, 2, "You're infected by a syringe! :(\n" );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $86
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 204
;204:	G_sprint ( owner, 2, "Your syringe has Infected an enemy!\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $87
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 205
;205:	G_bprint ( 1, other->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 other
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 206
;206:	G_bprint ( 1, " was infected by " );
CNSTI4 1
ARGI4
ADDRGP4 $88
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 207
;207:	G_bprint ( 1, owner->s.v.netname );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 208
;208:	G_bprint ( 1, "'s syringe\n" );
CNSTI4 1
ARGI4
ADDRGP4 $89
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 209
;209:	self->pausetime = ( g_globalvars.time + 5 );
ADDRGP4 self
INDIRP4
CNSTI4 676
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 210
;210:	self->s.v.nextthink = ( g_globalvars.time + 10 );
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 211
;211:	RemoveAIDSMine (  );
ADDRGP4 RemoveAIDSMine
CALLV
pop
line 212
;212:}
LABELV $65
endproc AIDSMineTouch 24 20
export FlashMineTouch
proc FlashMineTouch 8 12
line 215
;213:
;214:void FlashMineTouch ( )
;215:{
line 216
;216:	if ( self->pausetime > g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $93
line 217
;217:		return;
ADDRGP4 $92
JUMPV
LABELV $93
line 218
;218:	if ( !streq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $49
ARGP4
ADDRLP4 0
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $96
line 219
;219:		return;
ADDRGP4 $92
JUMPV
LABELV $96
line 220
;220:	if ( other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $98
line 221
;221:		return;
ADDRGP4 $92
JUMPV
LABELV $98
line 222
;222:	if ( other->team_no == PROG_TO_EDICT( self->s.v.owner )->team_no )
ADDRGP4 other
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
NEI4 $100
line 223
;223:		return;
ADDRGP4 $92
JUMPV
LABELV $100
line 224
;224:	if ( streq( other->s.v.classname, "player" ) ) {
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $49
ARGP4
ADDRLP4 4
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $103
line 225
;225:		FlashGrenadeExplode2 ( );
ADDRGP4 FlashGrenadeExplode2
CALLV
pop
line 226
;226:		G_sprint( PROG_TO_EDICT(self->s.v.owner), 1, "Your Flash mine was tripped!\n" );
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $105
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 228
;227:		//self.pausetime = (time + 5);
;228:	}
LABELV $103
line 230
;229:	//self.nextthink = (time+ 1);
;230:	self->s.v.nextthink = g_globalvars.time + .1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 231
;231:	dremove (self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 232
;232:}
LABELV $92
endproc FlashMineTouch 8 12
export SpikeTrapTouch
proc SpikeTrapTouch 20 24
line 235
;233:
;234:void SpikeTrapTouch ( )
;235:{
line 236
;236:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 238
;237:
;238:	if ( self->pausetime > g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $108
line 239
;239:		return;
ADDRGP4 $107
JUMPV
LABELV $108
line 240
;240:	if ( !streq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $49
ARGP4
ADDRLP4 4
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $111
line 241
;241:		return;
ADDRGP4 $107
JUMPV
LABELV $111
line 242
;242:	if ( other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $113
line 243
;243:		return;
ADDRGP4 $107
JUMPV
LABELV $113
line 244
;244:	if ( other->invincible_finished >= g_globalvars.time ) {
ADDRGP4 other
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LTF4 $115
line 245
;245:		if ( other->invincible_sound < g_globalvars.time ) {
ADDRGP4 other
INDIRP4
CNSTI4 752
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $107
line 246
;246:			sound ( other, 3, "items/protect3.wav", 1, 1 );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $121
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
line 247
;247:			other->invincible_sound = ( g_globalvars.time + 2 );
ADDRGP4 other
INDIRP4
CNSTI4 752
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 248
;248:		}
line 249
;249:		return;
ADDRGP4 $107
JUMPV
LABELV $115
line 251
;250:	}
;251:	if ( other->team_no == PROG_TO_EDICT( self->s.v.owner )->team_no )
ADDRGP4 other
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
NEI4 $123
line 252
;252:		return;
ADDRGP4 $107
JUMPV
LABELV $123
line 253
;253:	if ( other->playerclass == PC_HVYWEAP ) {
ADDRGP4 other
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 6
NEI4 $126
line 254
;254:		RemoveSpikeTrap ( );
ADDRGP4 RemoveSpikeTrap
CALLV
pop
line 255
;255:		G_sprint ( other, 2, "You removed an enemy trap!\n" );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $128
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 256
;256:		G_sprint ( owner, 2, "Spike Trap removed by enemy!\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $129
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 257
;257:		sound ( self, 3, "weapons/tink2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $130
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
line 258
;258:		return;
ADDRGP4 $107
JUMPV
LABELV $126
line 260
;259:	}
;260:	sound ( self, 3, "shambler/smack.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $131
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
line 261
;261:	G_sprint ( other, 2, "You stepped on a Spike Trap!\n" );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $132
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 262
;262:	G_sprint ( owner, 2, "Your Trap worked!\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $133
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 263
;263:	self->pausetime = ( g_globalvars.time + 5 );
ADDRGP4 self
INDIRP4
CNSTI4 676
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 264
;264:	self->s.v.nextthink = ( g_globalvars.time + 5 );
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 266
;265:	//deathmsg = 200;
;266:	TF_T_Damage ( other, owner, owner, 1, 2, 0 );
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 267
;267:	if ( other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $136
line 268
;268:		return;
ADDRGP4 $107
JUMPV
LABELV $136
line 269
;269:	other->leg_damage = other->leg_damage + 1;
ADDRLP4 16
ADDRGP4 other
INDIRP4
CNSTI4 1464
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
line 270
;270:	TeamFortress_SetSpeed ( other );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 271
;271:}
LABELV $107
endproc SpikeTrapTouch 20 24
export MagnetMineTouch
proc MagnetMineTouch 12 12
line 274
;272:
;273:void MagnetMineTouch ( )
;274:{
line 275
;275:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 277
;276:
;277:	if ( self->pausetime > g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $139
line 278
;278:		return;
ADDRGP4 $138
JUMPV
LABELV $139
line 279
;279:	if ( !streq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $49
ARGP4
ADDRLP4 4
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $142
line 280
;280:		return;
ADDRGP4 $138
JUMPV
LABELV $142
line 281
;281:	if ( other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $144
line 282
;282:		return;
ADDRGP4 $138
JUMPV
LABELV $144
line 283
;283:	if ( other->is_undercover == TRUE )
ADDRGP4 other
INDIRP4
CNSTI4 868
ADDP4
INDIRI4
CNSTI4 1
NEI4 $146
line 284
;284:		return;
ADDRGP4 $138
JUMPV
LABELV $146
line 285
;285:	if ( other->team_no == PROG_TO_EDICT( self->s.v.owner )->team_no )
ADDRGP4 other
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
NEI4 $148
line 286
;286:		return;
ADDRGP4 $138
JUMPV
LABELV $148
line 288
;287:
;288:	if ( streq( other->s.v.classname, "player" ) ) {
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $49
ARGP4
ADDRLP4 8
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $151
line 289
;289:		MagMineActivate ( );
ADDRGP4 MagMineActivate
CALLV
pop
line 290
;290:		G_sprint ( other, 2, "You stepped on a Magnetic Mine! :(\n" );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $153
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 291
;291:		G_sprint ( owner, 2, "Your Magnet Mine worked!\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $154
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 292
;292:		self->pausetime = ( g_globalvars.time + 5 );
ADDRGP4 self
INDIRP4
CNSTI4 676
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 293
;293:	}
LABELV $151
line 294
;294:	self->s.v.nextthink = g_globalvars.time + 5;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 295
;295:	dremove ( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 296
;296:}
LABELV $138
endproc MagnetMineTouch 12 12
export ThrowMine
proc ThrowMine 24 28
line 302
;297:
;298:/*****
;299:	Mine Drop Function
;300:						*****/
;301:void ThrowMine( float type )
;302:{
line 305
;303:	gedict_t *item;		// the mine/spike trap/wtva
;304:
;305:	item = spawn(  );
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 306
;306:	item->s.v.owner = EDICT_TO_PROG( self );
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
line 307
;307:	item->s.v.classname = "drop1";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $158
ASGNP4
line 308
;308:	item->team_no = self->team_no;
ADDRLP4 8
CNSTI4 960
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
INDIRI4
ASGNI4
line 309
;309:	setorigin( item, self->s.v.origin[0], self->s.v.origin[1], (self->s.v.origin[2] - 10));
ADDRLP4 0
INDIRP4
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
CNSTF4 1092616192
SUBF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 311
;310:
;311:	if (type == 1)
ADDRFP4 0
INDIRF4
CNSTF4 1065353216
NEF4 $159
line 312
;312:		item->s.v.angles[0] = 270;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 1132920832
ASGNF4
LABELV $159
line 313
;313:	if (type == 2) {
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
NEF4 $161
line 314
;314:		item->s.v.angles[0] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 0
ASGNF4
line 315
;315:		item->s.v.health = 5;
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1084227584
ASGNF4
line 316
;316:		item->th_die = RemoveAIDSMine;
ADDRLP4 0
INDIRP4
CNSTI4 812
ADDP4
ADDRGP4 RemoveAIDSMine
ASGNP4
line 317
;317:	}
LABELV $161
line 318
;318:	if (type == 4) {
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $163
line 319
;319:		item->s.v.angles[0] = 90;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 1119092736
ASGNF4
line 320
;320:		item->s.v.health = 5;
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1084227584
ASGNF4
line 321
;321:		item->th_die = RemoveSpikeTrap;
ADDRLP4 0
INDIRP4
CNSTI4 812
ADDP4
ADDRGP4 RemoveSpikeTrap
ASGNP4
line 322
;322:	}
LABELV $163
line 323
;323:	item->s.v.angles[1] = 45;
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1110704128
ASGNF4
line 324
;324:	item->s.v.flags = 256;
ADDRLP4 0
INDIRP4
CNSTI4 404
ADDP4
CNSTF4 1132462080
ASGNF4
line 325
;325:	item->s.v.solid = 2;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 326
;326:	item->s.v.movetype = 6;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 327
;327:	item->s.v.velocity[0] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 0
ASGNF4
line 328
;328:	item->s.v.velocity[1] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 0
ASGNF4
line 329
;329:	item->s.v.velocity[2] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 0
ASGNF4
line 330
;330:	setsize( item, -1, -1, 0, 1, 1, 6 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
CNSTF4 3212836864
ASGNF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 20
CNSTF4 1065353216
ASGNF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
CNSTF4 1086324736
ARGF4
ADDRGP4 setsize
CALLV
pop
line 332
;331:
;332:	if ( type == 4 ) {
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $165
line 333
;333:		setmodel ( item, "progs/spikebal.mdl" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $167
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 334
;334:	}
ADDRGP4 $166
JUMPV
LABELV $165
line 335
;335:	else {
line 336
;336:		if ( type == 5 ) {
ADDRFP4 0
INDIRF4
CNSTF4 1084227584
NEF4 $168
line 337
;337:			setmodel ( item, "progs/tgib1.mdl" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $170
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 338
;338:			item->s.v.skin = 1;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 1065353216
ASGNF4
line 339
;339:		}
ADDRGP4 $169
JUMPV
LABELV $168
line 340
;340:		else {
line 341
;341:			setmodel ( item, "progs/syringe.mdl" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $171
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 342
;342:		}
LABELV $169
line 343
;343:	}
LABELV $166
line 345
;344:
;345:	if ( type == 1 )
ADDRFP4 0
INDIRF4
CNSTF4 1065353216
NEF4 $172
line 346
;346:		item->s.v.touch = ( func_t ) AlarmMineTouch;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 AlarmMineTouch
CVPU4 4
CVUI4 4
ASGNI4
LABELV $172
line 348
;347:
;348:	if ( type == 2 )
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
NEF4 $174
line 349
;349:		item->s.v.touch = ( func_t ) AIDSMineTouch;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 AIDSMineTouch
CVPU4 4
CVUI4 4
ASGNI4
LABELV $174
line 351
;350:
;351:	if ( type == 3 ) {
ADDRFP4 0
INDIRF4
CNSTF4 1077936128
NEF4 $176
line 352
;352:		item->s.v.health = 1;
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1065353216
ASGNF4
line 353
;353:		item->th_die = RemoveFlashMine;
ADDRLP4 0
INDIRP4
CNSTI4 812
ADDP4
ADDRGP4 RemoveFlashMine
ASGNP4
line 354
;354:		item->s.v.touch = ( func_t ) FlashMineTouch;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 FlashMineTouch
CVPU4 4
CVUI4 4
ASGNI4
line 355
;355:		setmodel ( item, "progs/s_bubble.spr" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $178
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 356
;356:	}
LABELV $176
line 358
;357:
;358:	if ( type == 4 )
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $179
line 359
;359:		item->s.v.touch = ( func_t ) SpikeTrapTouch;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 SpikeTrapTouch
CVPU4 4
CVUI4 4
ASGNI4
LABELV $179
line 361
;360:
;361:	if ( type == 5 ) {
ADDRFP4 0
INDIRF4
CNSTF4 1084227584
NEF4 $181
line 362
;362:		item->s.v.touch = ( func_t ) MagnetMineTouch;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 MagnetMineTouch
CVPU4 4
CVUI4 4
ASGNI4
line 363
;363:		setmodel ( item, "progs/tgib1.mdl" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $170
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 364
;364:	}
LABELV $181
line 366
;365:
;366:	item->s.v.nextthink = g_globalvars.time + 180;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 367
;367:	if (type == 1)
ADDRFP4 0
INDIRF4
CNSTF4 1065353216
NEF4 $184
line 368
;368:		item->s.v.think = ( func_t ) RemoveAlarmMine;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 RemoveAlarmMine
CVPU4 4
CVUI4 4
ASGNI4
LABELV $184
line 369
;369:	if (type == 2)
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
NEF4 $186
line 370
;370:		item->s.v.think = ( func_t ) RemoveAIDSMine;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 RemoveAIDSMine
CVPU4 4
CVUI4 4
ASGNI4
LABELV $186
line 371
;371:	if (type == 3)
ADDRFP4 0
INDIRF4
CNSTF4 1077936128
NEF4 $188
line 372
;372:		item->s.v.think = ( func_t ) RemoveFlashMine;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 RemoveFlashMine
CVPU4 4
CVUI4 4
ASGNI4
LABELV $188
line 373
;373:	if (type == 4)
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $190
line 374
;374:		item->s.v.think = ( func_t ) RemoveSpikeTrap;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 RemoveSpikeTrap
CVPU4 4
CVUI4 4
ASGNI4
LABELV $190
line 375
;375:	if (type == 5)
ADDRFP4 0
INDIRF4
CNSTF4 1084227584
NEF4 $192
line 376
;376:		item->s.v.think = ( func_t ) RemoveMagnetMine;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 RemoveMagnetMine
CVPU4 4
CVUI4 4
ASGNI4
LABELV $192
line 377
;377:}
LABELV $157
endproc ThrowMine 24 28
export A_Mine
proc A_Mine 4 20
line 383
;378:
;379:/*****
;380:	Mine Pre-Drop Functions
;381:						*****/
;382:void A_Mine ( )
;383:{
line 384
;384:	if (self->s.v.ammo_cells < 50) {
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1112014848
GEF4 $195
line 385
;385:		G_sprint( self, 1, "Not enough cells...\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $197
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 386
;386:		return;
ADDRGP4 $194
JUMPV
LABELV $195
line 388
;387:	}
;388:	self->s.v.ammo_cells = 0;
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
CNSTF4 0
ASGNF4
line 389
;389:	ThrowMine (1);
CNSTF4 1065353216
ARGF4
ADDRGP4 ThrowMine
CALLV
pop
line 390
;390:	G_sprint( self, 1, "You set an alarm!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $198
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 391
;391:	sound( self, CHAN_VOICE, "effects/beep.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $199
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
line 392
;392:}
LABELV $194
endproc A_Mine 4 20
export B_Mine
proc B_Mine 12 20
line 395
;393:
;394:void B_Mine ( )
;395:{
line 397
;396:	gedict_t *te;
;397:	te=world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
line 398
;398:	if (self->has_syringe != 1) {
ADDRGP4 self
INDIRP4
CNSTI4 1764
ADDP4
INDIRI4
CNSTI4 1
EQI4 $201
line 399
;399:		G_sprint( self, 1, "1 syringe at a time!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $203
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 400
;400:		return;
ADDRGP4 $200
JUMPV
LABELV $201
line 403
;401:	}
;402:
;403:	te = trap_find( te, FOFS( s.v.classname ), "drop1" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $158
ARGP4
ADDRLP4 4
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRGP4 $205
JUMPV
LABELV $204
line 405
;404:	while ( te )
;405:	{
line 406
;406:		if ( te->s.v.owner == EDICT_TO_PROG( self ) ) {
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
NEI4 $207
line 407
;407:			G_sprint( self, 1, "1 syringe at a time!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $203
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 408
;408:			return;
ADDRGP4 $200
JUMPV
LABELV $207
line 410
;409:		}
;410:		te = trap_find( te, FOFS( s.v.classname ), "drop1" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $158
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 411
;411:	}
LABELV $205
line 404
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $204
line 413
;412:
;413:	ThrowMine ( 2 );
CNSTF4 1073741824
ARGF4
ADDRGP4 ThrowMine
CALLV
pop
line 414
;414:	G_sprint( self, 1, "You dropped a syringe!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $209
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 415
;415:	sound( self, CHAN_VOICE, "weapons/tink1.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $210
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
line 416
;416:}
LABELV $200
endproc B_Mine 12 20
export C_Mine
proc C_Mine 12 20
line 419
;417:
;418:void C_Mine ( )
;419:{
line 421
;420:	gedict_t *te;
;421:	te=world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
line 422
;422:	if (self->has_syringe != 1) {
ADDRGP4 self
INDIRP4
CNSTI4 1764
ADDP4
INDIRI4
CNSTI4 1
EQI4 $212
line 423
;423:		G_sprint( self, 1, "1 flash mine at a time!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $214
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 424
;424:		return;
ADDRGP4 $211
JUMPV
LABELV $212
line 427
;425:	}
;426:
;427:	if (self->last_used >= g_globalvars.time) {
ADDRGP4 self
INDIRP4
CNSTI4 1772
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 g_globalvars+124
INDIRF4
LTF4 $215
line 428
;428:		G_sprint( self, 1, "not ready yet...\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $218
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 429
;429:		return;
ADDRGP4 $211
JUMPV
LABELV $215
line 431
;430:	}
;431:	te = trap_find( te, FOFS( s.v.classname ), "drop1" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $158
ARGP4
ADDRLP4 4
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRGP4 $220
JUMPV
LABELV $219
line 433
;432:	while ( te )
;433:	{
line 434
;434:		if ( te->s.v.owner == EDICT_TO_PROG( self ) ) {
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
NEI4 $222
line 435
;435:			G_sprint( self, 1, "1 flash mine at a time!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $214
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 436
;436:			return;
ADDRGP4 $211
JUMPV
LABELV $222
line 438
;437:		}
;438:		te = trap_find( te, FOFS( s.v.classname ), "drop1" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $158
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 439
;439:	}
LABELV $220
line 432
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $219
line 440
;440:	ThrowMine ( 3 );
CNSTF4 1077936128
ARGF4
ADDRGP4 ThrowMine
CALLV
pop
line 441
;441:	G_sprint( self, 1, "You set a Flash mine!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $224
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 442
;442:	sound( self, CHAN_VOICE, "weapons/bounce.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $225
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
line 443
;443:}
LABELV $211
endproc C_Mine 12 20
export S_Mine
proc S_Mine 16 20
line 447
;444:
;445:// spike trap
;446:void S_Mine ( )
;447:{
line 451
;448:	gedict_t *te;
;449:	float spikecount;
;450:
;451:	spikecount=0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 452
;452:	te=world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
line 453
;453:	te = trap_find( te, FOFS( s.v.classname ), "drop1" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $158
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $228
JUMPV
LABELV $227
line 455
;454:	while ( te )
;455:	{
line 456
;456:		if ( te->s.v.owner == EDICT_TO_PROG( self ) ) {
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
NEI4 $230
line 457
;457:			spikecount = spikecount + 1;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 458
;458:		}
LABELV $230
line 459
;459:		te = trap_find( te, FOFS( s.v.classname ), "drop1" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $158
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 460
;460:	}
LABELV $228
line 454
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $227
line 461
;461:	if (spikecount >= 2) {
ADDRLP4 4
INDIRF4
CNSTF4 1073741824
LTF4 $232
line 462
;462:		G_sprint( self, 1, "2 spike traps at a time!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $234
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 463
;463:		return;
ADDRGP4 $226
JUMPV
LABELV $232
line 465
;464:	}
;465:	ThrowMine ( 4 );
CNSTF4 1082130432
ARGF4
ADDRGP4 ThrowMine
CALLV
pop
line 466
;466:	G_sprint( self, 1, "You set a Spike Trap!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $235
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 467
;467:	sound( self, CHAN_VOICE, "doors/meduse.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $236
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
line 468
;468:}
LABELV $226
endproc S_Mine 16 20
export M_Mine
proc M_Mine 12 20
line 471
;469:
;470:void M_Mine ( )
;471:{
line 473
;472:	gedict_t *te;
;473:	te=world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
line 475
;474:
;475:	if (self->has_syringe != 1) {
ADDRGP4 self
INDIRP4
CNSTI4 1764
ADDP4
INDIRI4
CNSTI4 1
EQI4 $238
line 476
;476:		G_sprint( self, 1, "You get 1 Mag Mine at a time!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $240
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 477
;477:		return;
ADDRGP4 $237
JUMPV
LABELV $238
line 480
;478:	}
;479:
;480:	te = trap_find( te, FOFS( s.v.classname ), "drop1" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $158
ARGP4
ADDRLP4 4
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRGP4 $242
JUMPV
LABELV $241
line 482
;481:	while ( te )
;482:	{
line 483
;483:		if ( te->s.v.owner == EDICT_TO_PROG( self ) ) {
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
NEI4 $244
line 484
;484:			G_sprint( self, 1, "You get 1 Mag Mine at a time!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $240
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 485
;485:			return;
ADDRGP4 $237
JUMPV
LABELV $244
line 487
;486:		}
;487:		te = trap_find( te, FOFS( s.v.classname ), "drop1" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $158
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 488
;488:	}
LABELV $242
line 481
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $241
line 490
;489:
;490:	ThrowMine ( 5 );
CNSTF4 1084227584
ARGF4
ADDRGP4 ThrowMine
CALLV
pop
line 491
;491:	G_sprint( self, 1, "You set a Mag Mine!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $246
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 492
;492:	sound( self, CHAN_VOICE, "weapons/bounce.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $225
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
line 493
;493:}
LABELV $237
endproc M_Mine 12 20
import FlashGrenadeExplode2
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
LABELV $246
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 77
byte 1 97
byte 1 103
byte 1 32
byte 1 77
byte 1 105
byte 1 110
byte 1 101
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $240
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 49
byte 1 32
byte 1 77
byte 1 97
byte 1 103
byte 1 32
byte 1 77
byte 1 105
byte 1 110
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
LABELV $236
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 100
byte 1 117
byte 1 115
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $235
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 83
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 84
byte 1 114
byte 1 97
byte 1 112
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $234
byte 1 50
byte 1 32
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 116
byte 1 114
byte 1 97
byte 1 112
byte 1 115
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
LABELV $225
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
LABELV $224
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $218
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 121
byte 1 101
byte 1 116
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $214
byte 1 49
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 32
byte 1 109
byte 1 105
byte 1 110
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
LABELV $210
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
LABELV $209
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 121
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 101
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $203
byte 1 49
byte 1 32
byte 1 115
byte 1 121
byte 1 114
byte 1 105
byte 1 110
byte 1 103
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
LABELV $199
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
LABELV $198
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 97
byte 1 108
byte 1 97
byte 1 114
byte 1 109
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $197
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
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $178
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
LABELV $171
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 115
byte 1 121
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $170
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 116
byte 1 103
byte 1 105
byte 1 98
byte 1 49
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $167
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 98
byte 1 97
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $158
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 49
byte 1 0
align 1
LABELV $154
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 77
byte 1 97
byte 1 103
byte 1 110
byte 1 101
byte 1 116
byte 1 32
byte 1 77
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 119
byte 1 111
byte 1 114
byte 1 107
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $153
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 97
byte 1 32
byte 1 77
byte 1 97
byte 1 103
byte 1 110
byte 1 101
byte 1 116
byte 1 105
byte 1 99
byte 1 32
byte 1 77
byte 1 105
byte 1 110
byte 1 101
byte 1 33
byte 1 32
byte 1 58
byte 1 40
byte 1 10
byte 1 0
align 1
LABELV $133
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 84
byte 1 114
byte 1 97
byte 1 112
byte 1 32
byte 1 119
byte 1 111
byte 1 114
byte 1 107
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $132
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 97
byte 1 32
byte 1 83
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 84
byte 1 114
byte 1 97
byte 1 112
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $131
byte 1 115
byte 1 104
byte 1 97
byte 1 109
byte 1 98
byte 1 108
byte 1 101
byte 1 114
byte 1 47
byte 1 115
byte 1 109
byte 1 97
byte 1 99
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $130
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
LABELV $129
byte 1 83
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 84
byte 1 114
byte 1 97
byte 1 112
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $128
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 116
byte 1 114
byte 1 97
byte 1 112
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $121
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
LABELV $105
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $89
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 121
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $88
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 0
align 1
LABELV $87
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 115
byte 1 121
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 73
byte 1 110
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $86
byte 1 89
byte 1 111
byte 1 117
byte 1 39
byte 1 114
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 121
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 101
byte 1 33
byte 1 32
byte 1 58
byte 1 40
byte 1 10
byte 1 0
align 1
LABELV $85
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 109
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 54
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $79
byte 1 32
byte 1 83
byte 1 121
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $78
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 115
byte 1 121
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 101
byte 1 33
byte 1 32
byte 1 58
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $60
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 65
byte 1 76
byte 1 65
byte 1 82
byte 1 77
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $59
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 65
byte 1 76
byte 1 65
byte 1 82
byte 1 77
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $58
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $49
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $41
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 77
byte 1 97
byte 1 103
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
LABELV $38
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 83
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 84
byte 1 114
byte 1 97
byte 1 112
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
LABELV $35
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 122
byte 1 122
byte 1 108
byte 1 101
byte 1 100
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $32
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 115
byte 1 121
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 105
byte 1 108
byte 1 101
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $30
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 101
byte 1 114
byte 1 105
byte 1 101
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 97
byte 1 108
byte 1 97
byte 1 114
byte 1 109
byte 1 46
byte 1 46
byte 1 32
byte 1 58
byte 1 40
byte 1 10
byte 1 0
align 1
LABELV $24
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $23
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $16
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 77
byte 1 97
byte 1 103
byte 1 32
byte 1 77
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 100
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $13
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 115
byte 1 116
byte 1 117
byte 1 99
byte 1 107
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 97
byte 1 32
byte 1 109
byte 1 97
byte 1 103
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 33
byte 1 10
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $12
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
