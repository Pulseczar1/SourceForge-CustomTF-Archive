export button_wait
code
proc button_wait 4 0
file "..\src\buttons.c"
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
;21: *  $Id: buttons.c,v 1.4 2005/05/17 03:56:00 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:void    button_return(  );
;26:
;27:void button_wait(  )
;28:{
line 29
;29:	self->state = STATE_TOP;
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 0
ASGNI4
line 30
;30:	self->s.v.nextthink = self->s.v.ltime + self->wait;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 660
ADDP4
INDIRF4
ADDF4
ASGNF4
line 31
;31:	self->s.v.think = ( func_t ) button_return;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 button_return
CVPU4 4
CVUI4 4
ASGNI4
line 32
;32:	activator = PROG_TO_EDICT( self->s.v.enemy );
ADDRGP4 activator
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 34
;33:
;34:	SUB_UseTargets(  );
ADDRGP4 SUB_UseTargets
CALLV
pop
line 36
;35:
;36:	self->s.v.frame = 1;	// use alternate textures
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1065353216
ASGNF4
line 37
;37:}
LABELV $11
endproc button_wait 4 0
export button_done
proc button_done 0 0
line 40
;38:
;39:void button_done(  )
;40:{
line 41
;41:	self->state = STATE_BOTTOM;
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 42
;42:}
LABELV $12
endproc button_done 0 0
export button_return
proc button_return 4 12
line 45
;43:
;44:void button_return(  )
;45:{
line 46
;46:	self->goal_state = 2;
ADDRGP4 self
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
line 48
;47:
;48:	self->state = STATE_DOWN;
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 3
ASGNI4
line 50
;49:
;50:	SUB_CalcMove( self->pos1, self->speed, button_done );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 612
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
ARGF4
ADDRGP4 button_done
ARGP4
ADDRGP4 SUB_CalcMove
CALLV
pop
line 52
;51:
;52:	self->s.v.frame = 0;	// use normal textures
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 0
ASGNF4
line 54
;53:
;54:	if ( self->s.v.health )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
EQF4 $14
line 55
;55:		self->s.v.takedamage = DAMAGE_YES;	// can be shot again
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $14
line 56
;56:}
LABELV $13
endproc button_return 4 12
export button_blocked
proc button_blocked 0 0
line 59
;57:
;58:void button_blocked(  )
;59:{				// do nothing, just don't ome all the way back out
line 60
;60:}
LABELV $16
endproc button_blocked 0 0
export button_fire
proc button_fire 16 20
line 63
;61:
;62:void button_fire(  )
;63:{
line 64
;64:	if ( self->state == STATE_UP || self->state == STATE_TOP )
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $20
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $18
LABELV $20
line 65
;65:		return;
ADDRGP4 $17
JUMPV
LABELV $18
line 67
;66:
;67:	sound( self, CHAN_VOICE, self->s.v.noise, 1, ATTN_NORM );
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 4
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
line 69
;68:
;69:	self->state = STATE_UP;
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 2
ASGNI4
line 71
;70:
;71:	SUB_CalcMove( self->pos2, self->speed, button_wait );
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 624
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
ARGF4
ADDRGP4 button_wait
ARGP4
ADDRGP4 SUB_CalcMove
CALLV
pop
line 73
;72:
;73:}
LABELV $17
endproc button_fire 16 20
export button_use
proc button_use 0 0
line 76
;74:
;75:void button_use(  )
;76:{
line 77
;77:	self->s.v.enemy = EDICT_TO_PROG( activator );
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
ADDRGP4 activator
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 78
;78:	button_fire(  );
ADDRGP4 button_fire
CALLV
pop
line 79
;79:}
LABELV $21
endproc button_use 0 0
export button_touch
proc button_touch 16 12
line 83
;80:
;81:
;82:void button_touch(  )
;83:{
line 86
;84:	gedict_t *te;
;85:
;86:	if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $23
line 87
;87:		return;
ADDRGP4 $22
JUMPV
LABELV $23
line 89
;88:
;89:	if ( other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $27
line 90
;90:		return;
ADDRGP4 $22
JUMPV
LABELV $27
line 92
;91:
;92:	if ( strneq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $31
ARGP4
ADDRLP4 4
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $29
line 93
;93:		return;
ADDRGP4 $22
JUMPV
LABELV $29
line 95
;94:
;95:	if ( self->goal_activation & TFGA_SPANNER )
ADDRGP4 self
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $32
line 96
;96:		return;
ADDRGP4 $22
JUMPV
LABELV $32
line 97
;97:	if ( !other->playerclass )
ADDRGP4 other
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $34
line 98
;98:		return;
ADDRGP4 $22
JUMPV
LABELV $34
line 100
;99:
;100:	if ( !Activated( self, other ) )
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Activated
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $36
line 101
;101:	{
line 102
;102:		if ( self->else_goal )
ADDRGP4 self
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $22
line 103
;103:		{
line 104
;104:			te = Findgoal( self->else_goal );
ADDRGP4 self
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 Findgoal
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 105
;105:			if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $22
line 106
;106:				AttemptToActivate( te, other, self );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 AttemptToActivate
CALLV
pop
line 107
;107:		}
line 108
;108:		return;
ADDRGP4 $22
JUMPV
LABELV $36
line 110
;109:	}
;110:	self->s.v.enemy = EDICT_TO_PROG( other );
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
ADDRGP4 other
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 111
;111:	button_fire(  );
ADDRGP4 button_fire
CALLV
pop
line 112
;112:}
LABELV $22
endproc button_touch 16 12
export button_killed
proc button_killed 4 0
line 115
;113:
;114:void button_killed(  )
;115:{
line 116
;116:	if ( self->goal_activation & TFGA_SPANNER )
ADDRGP4 self
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $43
line 117
;117:		return;
ADDRGP4 $42
JUMPV
LABELV $43
line 118
;118:	self->s.v.enemy = EDICT_TO_PROG( damage_attacker );
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
ADDRGP4 damage_attacker
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 119
;119:	self->s.v.health = self->s.v.max_health;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRF4
ASGNF4
line 120
;120:	self->s.v.takedamage = DAMAGE_NO;	// wil be reset upon return
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 0
ASGNF4
line 122
;121:
;122:	button_fire(  );
ADDRGP4 button_fire
CALLV
pop
line 123
;123:}
LABELV $42
endproc button_killed 4 0
export SP_func_button
proc SP_func_button 32 8
line 142
;124:
;125:/*QUAKED func_button (0 .5 .8) ?
;126:When a button is touched, it moves some distance in the direction of it's angle, triggers all of it's targets, waits some time, then returns to it's original position where it can be triggered again.
;127:
;128:"angle"  determines the opening direction
;129:"target" all entities with a matching targetname will be used
;130:"speed"  override the default 40 speed
;131:"wait"  override the default 1 second wait (-1 = never return)
;132:"lip"  override the default 4 pixel lip remaining at end of move
;133:"health" if set, the button must be killed instead of touched
;134:"sounds"
;135:0) steam metal
;136:1) wooden clunk
;137:2) metallic click
;138:3) in-out
;139:*/
;140:
;141:void SP_func_button(  )
;142:{
line 145
;143:	float   ftemp;
;144:
;145:	if ( !CheckExistence(  ) )
ADDRLP4 4
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $46
line 146
;146:	{
line 147
;147:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 148
;148:		return;
ADDRGP4 $45
JUMPV
LABELV $46
line 150
;149:	}
;150:	if ( self->s.v.sounds == 0 )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 0
NEF4 $48
line 151
;151:	{
line 152
;152:		trap_precache_sound( "buttons/airbut1.wav" );
ADDRGP4 $50
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 153
;153:		self->s.v.noise = "buttons/airbut1.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $50
ASGNP4
line 154
;154:	}
LABELV $48
line 155
;155:	if ( self->s.v.sounds == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $51
line 156
;156:	{
line 157
;157:		trap_precache_sound( "buttons/switch21.wav" );
ADDRGP4 $53
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 158
;158:		self->s.v.noise = "buttons/switch21.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $53
ASGNP4
line 159
;159:	}
LABELV $51
line 160
;160:	if ( self->s.v.sounds == 2 )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $54
line 161
;161:	{
line 162
;162:		trap_precache_sound( "buttons/switch02.wav" );
ADDRGP4 $56
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 163
;163:		self->s.v.noise = "buttons/switch02.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $56
ASGNP4
line 164
;164:	}
LABELV $54
line 165
;165:	if ( self->s.v.sounds == 3 )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $57
line 166
;166:	{
line 167
;167:		trap_precache_sound( "buttons/switch04.wav" );
ADDRGP4 $59
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 168
;168:		self->s.v.noise = "buttons/switch04.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $59
ASGNP4
line 169
;169:	}
LABELV $57
line 171
;170:
;171:	SetMovedir(  );
ADDRGP4 SetMovedir
CALLV
pop
line 173
;172:
;173:	self->s.v.movetype = MOVETYPE_PUSH;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1088421888
ASGNF4
line 174
;174:	self->s.v.solid = SOLID_BSP;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1082130432
ASGNF4
line 175
;175:	setmodel( self, self->s.v.model );
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 177
;176:
;177:	self->s.v.blocked = ( func_t ) button_blocked;
ADDRGP4 self
INDIRP4
CNSTI4 284
ADDP4
ADDRGP4 button_blocked
CVPU4 4
CVUI4 4
ASGNI4
line 178
;178:	self->s.v.use = ( func_t ) button_use;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 button_use
CVPU4 4
CVUI4 4
ASGNI4
line 180
;179:
;180:	if ( self->s.v.health )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
EQF4 $60
line 181
;181:	{
line 182
;182:		self->s.v.max_health = self->s.v.health;
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 416
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ASGNF4
line 183
;183:		self->th_die = button_killed;
ADDRGP4 self
INDIRP4
CNSTI4 812
ADDP4
ADDRGP4 button_killed
ASGNP4
line 184
;184:		self->s.v.takedamage = DAMAGE_YES;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 1065353216
ASGNF4
line 185
;185:	} else
ADDRGP4 $61
JUMPV
LABELV $60
line 186
;186:		self->s.v.touch = ( func_t ) button_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 button_touch
CVPU4 4
CVUI4 4
ASGNI4
LABELV $61
line 188
;187:
;188:	if ( !self->speed )
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
CNSTF4 0
NEF4 $62
line 189
;189:		self->speed = 40;
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
CNSTF4 1109393408
ASGNF4
LABELV $62
line 191
;190:
;191:	if ( !self->wait )
ADDRGP4 self
INDIRP4
CNSTI4 660
ADDP4
INDIRF4
CNSTF4 0
NEF4 $64
line 192
;192:		self->wait = 1;
ADDRGP4 self
INDIRP4
CNSTI4 660
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $64
line 194
;193:
;194:	if ( !self->lip )
ADDRGP4 self
INDIRP4
CNSTI4 720
ADDP4
INDIRF4
CNSTF4 0
NEF4 $66
line 195
;195:		self->lip = 4;
ADDRGP4 self
INDIRP4
CNSTI4 720
ADDP4
CNSTF4 1082130432
ASGNF4
LABELV $66
line 197
;196:
;197:	self->state = STATE_BOTTOM;
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 199
;198:
;199:	VectorCopy( self->s.v.origin, self->pos1 );
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 612
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
CNSTI4 616
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
CNSTI4 620
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 200
;200:	ftemp = ( fabs( DotProduct( self->s.v.movedir, self->s.v.size ) ) - self->lip );
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 260
ADDP4
INDIRF4
MULF4
ADDRLP4 12
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 264
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 12
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 268
ADDP4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 16
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 720
ADDP4
INDIRF4
SUBF4
ASGNF4
line 202
;201:
;202:	self->pos2[0] = self->pos1[0] + self->s.v.movedir[0] * ftemp;
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 624
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 612
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 203
;203:	self->pos2[1] = self->pos1[1] + self->s.v.movedir[1] * ftemp;
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 628
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 616
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 204
;204:	self->pos2[2] = self->pos1[2] + self->s.v.movedir[2] * ftemp;
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 632
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 620
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 206
;205:
;206:	if ( ( int ) ( self->s.v.spawnflags ) & 32 )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $68
line 207
;207:		button_fire(  );
ADDRGP4 button_fire
CALLV
pop
LABELV $68
line 208
;208:}
LABELV $45
endproc SP_func_button 32 8
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
LABELV $59
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
byte 1 52
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $56
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
LABELV $53
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
byte 1 50
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $50
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 97
byte 1 105
byte 1 114
byte 1 98
byte 1 117
byte 1 116
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $31
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
