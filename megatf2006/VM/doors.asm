export door_blocked
code
proc door_blocked 12 16
file "..\src\doors.c"
line 59
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
;21: *  $Id: doors.c,v 1.6 2005/05/23 18:54:02 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:#define DOOR_START_OPEN   1
;26:#define DOOR_DONT_LINK    4
;27:#define DOOR_GOLD_KEY     8
;28:#define DOOR_SILVER_KEY  16
;29:#define DOOR_TOGGLE      32
;30:
;31:/*
;32:
;33:Doors are similar to buttons, but can spawn a fat trigger field around them
;34:to open without a touch, and they link together to form simultanious
;35:double/quad doors.
;36: 
;37:Door.owner is the master door.  If there is only one door, it points to itself.
;38:If multiple doors, all will point to a single one.
;39:
;40:Door.enemy chains from the master door through all doors linked in the chain.
;41:
;42:*/
;43:/*
;44:=============================================================================
;45:
;46:THINK FUNCTIONS
;47:
;48:=============================================================================
;49:*/
;50:
;51:void    door_blocked(  );
;52:void    door_hit_top(  );
;53:void    door_hit_bottom(  );
;54:void    door_go_down(  );
;55:void    door_go_up(  );
;56:void    door_fire(  );
;57:
;58:void door_blocked(  )
;59:{
line 60
;60:	if ( streq( other->s.v.classname, "detpack" ) )
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
EQI4 $12
line 61
;61:	{
line 62
;62:		G_sprint( PROG_TO_EDICT( other->s.v.owner ), 2, "Your detpack was squashed.\n" );
ADDRGP4 other
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $15
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 63
;63:		if ( other->weaponmode == 1 )
ADDRGP4 other
INDIRP4
CNSTI4 940
ADDP4
INDIRI4
CNSTI4 1
NEI4 $16
line 64
;64:		{
line 65
;65:			TeamFortress_SetSpeed( PROG_TO_EDICT( other->s.v.enemy ) );
ADDRGP4 other
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 66
;66:			dremove( other->observer_list );
ADDRGP4 other
INDIRP4
CNSTI4 900
ADDP4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 67
;67:		}
LABELV $16
line 68
;68:		dremove( other->oldenemy );
ADDRGP4 other
INDIRP4
CNSTI4 980
ADDP4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 69
;69:		dremove( other );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 70
;70:		return;
ADDRGP4 $11
JUMPV
LABELV $12
line 72
;71:	}
;72:	if ( streq( other->s.v.classname, "player" ) && other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $20
ARGP4
ADDRLP4 4
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $18
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $18
line 73
;73:		return;
ADDRGP4 $11
JUMPV
LABELV $18
line 75
;74:
;75:	T_Damage( other, self, self, self->dmg );
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 716
ADDP4
INDIRF4
ARGF4
ADDRGP4 T_Damage
CALLV
pop
line 80
;76:
;77:// if a door has a negative wait, it would never come back if blocked,
;78:// so let it just squash the object to death real fast
;79:
;80:	if ( self->wait >= 0 )
ADDRGP4 self
INDIRP4
CNSTI4 660
ADDP4
INDIRF4
CNSTF4 0
LTF4 $21
line 81
;81:	{
line 82
;82:		if ( self->state == STATE_DOWN )
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 3
NEI4 $23
line 83
;83:			door_go_up(  );
ADDRGP4 door_go_up
CALLV
pop
ADDRGP4 $24
JUMPV
LABELV $23
line 85
;84:		else
;85:			door_go_down(  );
ADDRGP4 door_go_down
CALLV
pop
LABELV $24
line 86
;86:	}
LABELV $21
line 87
;87:}
LABELV $11
endproc door_blocked 12 16
export door_hit_top
proc door_hit_top 12 20
line 90
;88:
;89:void door_hit_top(  )
;90:{
line 91
;91:	sound( self, CHAN_VOICE, self->s.v.noise1, 1, ATTN_NORM );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
INDIRP4
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
line 92
;92:	self->state = STATE_TOP;
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 0
ASGNI4
line 94
;93:
;94:	if ( ( int ) ( self->s.v.spawnflags ) & DOOR_TOGGLE )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $26
line 95
;95:		return;		// don't come down automatically
ADDRGP4 $25
JUMPV
LABELV $26
line 97
;96:
;97:	self->s.v.think = ( func_t ) door_go_down;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 door_go_down
CVPU4 4
CVUI4 4
ASGNI4
line 98
;98:	self->s.v.nextthink = self->s.v.ltime + self->wait;
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 288
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 140
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 660
ADDP4
INDIRF4
ADDF4
ASGNF4
line 99
;99:}
LABELV $25
endproc door_hit_top 12 20
export door_hit_bottom
proc door_hit_bottom 8 20
line 102
;100:
;101:void door_hit_bottom(  )
;102:{
line 103
;103:	self->goal_state = TFGS_INACTIVE;
ADDRGP4 self
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
line 104
;104:	sound( self, CHAN_VOICE, self->s.v.noise1, 1, ATTN_NORM );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
INDIRP4
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
line 105
;105:	self->state = STATE_BOTTOM;
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 106
;106:}
LABELV $28
endproc door_hit_bottom 8 20
export door_go_down
proc door_go_down 12 20
line 109
;107:
;108:void door_go_down(  )
;109:{
line 110
;110:	sound( self, CHAN_VOICE, self->s.v.noise2, 1, ATTN_NORM );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRP4
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
line 111
;111:	if ( self->s.v.max_health )
ADDRGP4 self
INDIRP4
CNSTI4 416
ADDP4
INDIRF4
CNSTF4 0
EQF4 $30
line 112
;112:	{
line 113
;113:		self->s.v.takedamage = DAMAGE_YES;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 1065353216
ASGNF4
line 114
;114:		self->s.v.health = self->s.v.max_health;
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 296
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 416
ADDP4
INDIRF4
ASGNF4
line 115
;115:	}
LABELV $30
line 117
;116:
;117:	self->state = STATE_DOWN;
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 3
ASGNI4
line 118
;118:	SUB_CalcMove( self->pos1, self->speed, door_hit_bottom );
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 612
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
ARGF4
ADDRGP4 door_hit_bottom
ARGP4
ADDRGP4 SUB_CalcMove
CALLV
pop
line 119
;119:}
LABELV $29
endproc door_go_down 12 20
export door_go_up
proc door_go_up 12 20
line 122
;120:
;121:void door_go_up(  )
;122:{
line 124
;123:
;124:	if ( self->state == STATE_UP )
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 2
NEI4 $33
line 125
;125:		return;		// allready going up
ADDRGP4 $32
JUMPV
LABELV $33
line 127
;126:
;127:	if ( self->state == STATE_TOP )
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
NEI4 $35
line 128
;128:	{			// reset top wait time
line 130
;129:
;130:		self->s.v.nextthink = self->s.v.ltime + self->wait;
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
line 131
;131:		return;
ADDRGP4 $32
JUMPV
LABELV $35
line 134
;132:	}
;133:
;134:	sound( self, CHAN_VOICE, self->s.v.noise2, 1, ATTN_NORM );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRP4
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
line 135
;135:	self->state = STATE_UP;
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 2
ASGNI4
line 137
;136:
;137:	SUB_CalcMove( self->pos2, self->speed, door_hit_top );
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 624
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
ARGF4
ADDRGP4 door_hit_top
ARGP4
ADDRGP4 SUB_CalcMove
CALLV
pop
line 138
;138:	SUB_UseTargets(  );
ADDRGP4 SUB_UseTargets
CALLV
pop
line 139
;139:}
LABELV $32
endproc door_go_up 12 20
export door_fire
proc door_fire 28 20
line 151
;140:
;141:/*
;142:=============================================================================
;143:
;144:ACTIVATION FUNCTIONS
;145:
;146:=============================================================================
;147:*/
;148:
;149:
;150:void door_fire(  )
;151:{
line 154
;152:	gedict_t *oself, *starte;
;153:
;154:	if ( PROG_TO_EDICT( self->s.v.owner ) != self )
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
EQU4 $38
line 155
;155:		G_Error( "door_fire: self.owner != self" );
ADDRGP4 $40
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $38
line 159
;156:
;157:// play use key sound
;158:
;159:	if ( self->s.v.items )
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CNSTF4 0
EQF4 $41
line 160
;160:		sound( self, CHAN_VOICE, self->noise4, 1, ATTN_NORM );
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 680
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
LABELV $41
line 162
;161:
;162:	self->s.v.message = 0;	// no more message
ADDRGP4 self
INDIRP4
CNSTI4 496
ADDP4
CNSTP4 0
ASGNP4
line 163
;163:	oself = self;
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
line 165
;164:
;165:	if ( ( int ) ( self->s.v.spawnflags ) & DOOR_TOGGLE )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $43
line 166
;166:	{
line 167
;167:		if ( self->state == STATE_UP || self->state == STATE_TOP )
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 2
EQI4 $47
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $45
LABELV $47
line 168
;168:		{
line 169
;169:			starte = self;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
LABELV $48
line 171
;170:			do
;171:			{
line 172
;172:				door_go_down(  );
ADDRGP4 door_go_down
CALLV
pop
line 174
;173:
;174:				self = PROG_TO_EDICT( self->s.v.enemy );
ADDRLP4 24
ADDRGP4 self
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 175
;175:			}
LABELV $49
line 176
;176:			while ( ( self != starte ) && ( self != world ) );
ADDRLP4 24
ADDRGP4 self
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 24
INDIRU4
ADDRLP4 0
INDIRP4
CVPU4 4
EQU4 $51
ADDRLP4 24
INDIRU4
ADDRGP4 world
INDIRP4
CVPU4 4
NEU4 $48
LABELV $51
line 177
;177:			self = oself;
ADDRGP4 self
ADDRLP4 4
INDIRP4
ASGNP4
line 178
;178:			return;
ADDRGP4 $37
JUMPV
LABELV $45
line 180
;179:		}
;180:	}
LABELV $43
line 182
;181:// trigger all paired doors
;182:	starte = self;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
LABELV $52
line 184
;183:	do
;184:	{
line 185
;185:		door_go_up(  );
ADDRGP4 door_go_up
CALLV
pop
line 186
;186:		self = PROG_TO_EDICT( self->s.v.enemy );
ADDRLP4 20
ADDRGP4 self
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 187
;187:	}
LABELV $53
line 188
;188:	while ( ( self != starte ) && ( self != world ) );
ADDRLP4 20
ADDRGP4 self
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 20
INDIRU4
ADDRLP4 0
INDIRP4
CVPU4 4
EQU4 $55
ADDRLP4 20
INDIRU4
ADDRGP4 world
INDIRP4
CVPU4 4
NEU4 $52
LABELV $55
line 189
;189:	self = oself;
ADDRGP4 self
ADDRLP4 4
INDIRP4
ASGNP4
line 190
;190:}
LABELV $37
endproc door_fire 28 20
export door_use
proc door_use 8 0
line 193
;191:
;192:void door_use(  )
;193:{
line 196
;194:	gedict_t *oself;
;195:
;196:	self->s.v.message = "";	// door message are for touch only
ADDRGP4 self
INDIRP4
CNSTI4 496
ADDP4
ADDRGP4 $57
ASGNP4
line 197
;197:	PROG_TO_EDICT( self->s.v.owner )->s.v.message = "";
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+384
ADDP4
ADDRGP4 $57
ASGNP4
line 198
;198:	PROG_TO_EDICT( self->s.v.enemy )->s.v.message = "";
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+384
ADDP4
ADDRGP4 $57
ASGNP4
line 200
;199:
;200:	oself = self;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
line 201
;201:	self = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 4
ADDRGP4 self
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 202
;202:	door_fire(  );
ADDRGP4 door_fire
CALLV
pop
line 203
;203:	self = oself;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 204
;204:}
LABELV $56
endproc door_use 8 0
export door_trigger_touch
proc door_trigger_touch 12 12
line 207
;205:
;206:void door_trigger_touch(  )
;207:{
line 210
;208:	gedict_t *te;
;209:
;210:	if ( other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $63
line 211
;211:		return;
ADDRGP4 $62
JUMPV
LABELV $63
line 213
;212:
;213:	if ( !other->playerclass )
ADDRGP4 other
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $65
line 214
;214:		return;
ADDRGP4 $62
JUMPV
LABELV $65
line 215
;215:	if ( !Activated( self, other ) )
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Activated
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $67
line 216
;216:	{
line 217
;217:		if ( self->else_goal )
ADDRGP4 self
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $62
line 218
;218:		{
line 219
;219:			te = Findgoal( self->else_goal );
ADDRGP4 self
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 Findgoal
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 220
;220:			if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $62
line 221
;221:				AttemptToActivate( te, other, self );
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
line 222
;222:		}
line 223
;223:		return;
ADDRGP4 $62
JUMPV
LABELV $67
line 225
;224:	}
;225:	if ( g_globalvars.time < self->attack_finished )
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
GEF4 $73
line 226
;226:		return;
ADDRGP4 $62
JUMPV
LABELV $73
line 227
;227:	self->attack_finished = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 724
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 229
;228:
;229:	activator = other;
ADDRGP4 activator
ADDRGP4 other
INDIRP4
ASGNP4
line 231
;230:
;231:	self = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 8
ADDRGP4 self
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 232
;232:	door_use(  );
ADDRGP4 door_use
CALLV
pop
line 233
;233:}
LABELV $62
endproc door_trigger_touch 12 12
export door_killed
proc door_killed 12 0
line 236
;234:
;235:void door_killed(  )
;236:{
line 239
;237:	gedict_t *oself;
;238:
;239:	oself = self;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
line 240
;240:	self = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 4
ADDRGP4 self
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 241
;241:	self->s.v.health = self->s.v.max_health;
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 296
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 416
ADDP4
INDIRF4
ASGNF4
line 242
;242:	self->s.v.takedamage = DAMAGE_NO;	// wil be reset upon return
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 0
ASGNF4
line 244
;243:
;244:	door_use(  );
ADDRGP4 door_use
CALLV
pop
line 245
;245:	self = oself;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 246
;246:}
LABELV $77
endproc door_killed 12 0
export door_touch
proc door_touch 44 20
line 259
;247:
;248:/*
;249:================
;250:door_touch
;251:
;252:Prints messages and opens key doors
;253:================
;254:*/
;255:
;256:int     DoorShouldOpen(  );
;257:
;258:void door_touch(  )
;259:{
line 263
;260:	gedict_t *te;
;261:	char   *msg;
;262:
;263:	if ( strneq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $20
ARGP4
ADDRLP4 8
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $79
line 264
;264:		return;
ADDRGP4 $78
JUMPV
LABELV $79
line 266
;265:
;266:	if ( PROG_TO_EDICT( self->s.v.owner )->attack_finished > g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+724
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $81
line 267
;267:		return;
ADDRGP4 $78
JUMPV
LABELV $81
line 270
;268:
;269:
;270:	if ( !Activated( self, other ) )
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Activated
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $85
line 271
;271:	{
line 272
;272:		if ( self->else_goal )
ADDRGP4 self
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $78
line 273
;273:		{
line 274
;274:			te = Findgoal( self->else_goal );
ADDRGP4 self
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 Findgoal
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 275
;275:			if ( te )
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $78
line 276
;276:				AttemptToActivate( te, other, self );
ADDRLP4 4
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
line 277
;277:		}
line 278
;278:		return;
ADDRGP4 $78
JUMPV
LABELV $85
line 280
;279:	}
;280:	PROG_TO_EDICT( self->s.v.owner )->attack_finished = g_globalvars.time + 2;
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+724
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 281
;281:	msg = PROG_TO_EDICT( self->s.v.owner )->s.v.message;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+384
ADDP4
INDIRP4
ASGNP4
line 283
;282:
;283:	if ( msg && msg[0] )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $95
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $95
line 284
;284:	{
line 285
;285:		G_centerprint( other, PROG_TO_EDICT( self->s.v.owner )->s.v.message );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+384
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 286
;286:		sound( other, CHAN_VOICE, "misc/talk.wav", 1, ATTN_NORM );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $99
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
line 287
;287:	}
LABELV $95
line 289
;288:// key door stuff
;289:	if ( self->s.v.items == 0 )
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CNSTF4 0
NEF4 $100
line 290
;290:		return;
ADDRGP4 $78
JUMPV
LABELV $100
line 293
;291:
;292:// FIXME: blink key on player's status bar
;293:	if ( ( ( int ) self->s.v.items & ( int ) other->s.v.items ) != self->s.v.items )
ADDRLP4 20
CNSTI4 336
ASGNI4
ADDRLP4 24
ADDRGP4 self
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24
INDIRF4
CVFI4 4
ADDRGP4 other
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
CVFI4 4
BANDI4
CVIF4 4
ADDRLP4 24
INDIRF4
EQF4 $102
line 294
;294:	{
line 295
;295:		if ( PROG_TO_EDICT( self->s.v.owner )->s.v.items == IT_KEY1 )
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+224
ADDP4
INDIRF4
CNSTF4 1207959552
NEF4 $104
line 296
;296:		{
line 297
;297:			if ( world->worldtype == 2 )
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2
NEI4 $108
line 298
;298:			{
line 299
;299:				G_centerprint( other, "You need the silver keycard" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $110
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 300
;300:				sound( self, CHAN_VOICE, self->s.v.noise3, 1, ATTN_NORM );
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 301
;301:			} else if ( world->worldtype == 1 )
ADDRGP4 $78
JUMPV
LABELV $108
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 1
NEI4 $111
line 302
;302:			{
line 303
;303:				G_centerprint( other, "You need the silver runekey" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $113
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 304
;304:				sound( self, CHAN_VOICE, self->s.v.noise3, 1, ATTN_NORM );
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 305
;305:			} else if ( world->worldtype == 0 )
ADDRGP4 $78
JUMPV
LABELV $111
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 0
NEI4 $78
line 306
;306:			{
line 307
;307:				G_centerprint( other, "You need the silver key" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $116
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 308
;308:				sound( self, CHAN_VOICE, self->s.v.noise3, 1, ATTN_NORM );
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 309
;309:			}
line 310
;310:		} else
ADDRGP4 $78
JUMPV
LABELV $104
line 311
;311:		{
line 312
;312:			if ( world->worldtype == 2 )
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2
NEI4 $117
line 313
;313:			{
line 314
;314:				G_centerprint( other, "You need the gold keycard" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $119
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 315
;315:				sound( self, CHAN_VOICE, self->s.v.noise3, 1, ATTN_NORM );
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 316
;316:			} else if ( world->worldtype == 1 )
ADDRGP4 $78
JUMPV
LABELV $117
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 1
NEI4 $120
line 317
;317:			{
line 318
;318:				G_centerprint( other, "You need the gold runekey" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $122
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 319
;319:				sound( self, CHAN_VOICE, self->s.v.noise3, 1, ATTN_NORM );
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 320
;320:			} else if ( world->worldtype == 0 )
ADDRGP4 $78
JUMPV
LABELV $120
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 0
NEI4 $78
line 321
;321:			{
line 322
;322:				G_centerprint( other, "You need the gold key" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $125
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 323
;323:				sound( self, CHAN_VOICE, self->s.v.noise3, 1, ATTN_NORM );
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 324
;324:			}
line 325
;325:		}
line 326
;326:		return;
ADDRGP4 $78
JUMPV
LABELV $102
line 329
;327:	}
;328:
;329:	other->s.v.items -= self->s.v.items;
ADDRLP4 28
CNSTI4 336
ASGNI4
ADDRLP4 32
ADDRGP4 other
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 331
;330:
;331:	other->tf_items = other->tf_items | ( int ) self->s.v.items;
ADDRLP4 36
ADDRGP4 other
INDIRP4
CNSTI4 832
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CVFI4 4
BORI4
ASGNI4
line 333
;332:
;333:	if ( DoorShouldOpen(  ) )
ADDRLP4 40
ADDRGP4 DoorShouldOpen
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $126
line 334
;334:	{
line 335
;335:		self->s.v.touch = ( func_t ) SUB_Null;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 SUB_Null
CVPU4 4
CVUI4 4
ASGNI4
line 336
;336:		if ( self->s.v.enemy )
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
CNSTI4 0
EQI4 $128
line 337
;337:			PROG_TO_EDICT( self->s.v.enemy )->s.v.touch = ( func_t ) SUB_Null;	// get paired door
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+160
ADDP4
ADDRGP4 SUB_Null
CVPU4 4
CVUI4 4
ASGNI4
LABELV $128
line 339
;338:
;339:		door_use(  );
ADDRGP4 door_use
CALLV
pop
line 340
;340:	}
LABELV $126
line 341
;341:}
LABELV $78
endproc door_touch 44 20
export spawn_field
proc spawn_field 104 28
line 354
;342:
;343:/*
;344:=============================================================================
;345:
;346:SPAWNING FUNCTIONS
;347:
;348:=============================================================================
;349:*/
;350:
;351:
;352:
;353:gedict_t *spawn_field( vec3_t fmins, vec3_t fmaxs )
;354:{
line 357
;355:	gedict_t *trigger;
;356:
;357:	trigger = spawn(  );
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 358
;358:	trigger->s.v.movetype = MOVETYPE_NONE;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 359
;359:	trigger->s.v.solid = SOLID_TRIGGER;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 360
;360:	trigger->s.v.owner = EDICT_TO_PROG( self );
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
line 361
;361:	trigger->s.v.touch = ( func_t ) door_trigger_touch;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 door_trigger_touch
CVPU4 4
CVUI4 4
ASGNI4
line 363
;362:
;363:	trigger->team_no = self->team_no;
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
line 364
;364:	trigger->playerclass = self->playerclass;
ADDRLP4 12
CNSTI4 820
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
line 365
;365:	trigger->items_allowed = self->items_allowed;
ADDRLP4 16
CNSTI4 920
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
INDIRI4
ASGNI4
line 366
;366:	trigger->activate_goal_no = self->activate_goal_no;
ADDRLP4 20
CNSTI4 1172
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
INDIRI4
ASGNI4
line 367
;367:	trigger->inactivate_goal_no = self->inactivate_goal_no;
ADDRLP4 24
CNSTI4 1176
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
INDIRI4
ASGNI4
line 368
;368:	trigger->remove_goal_no = self->remove_goal_no;
ADDRLP4 28
CNSTI4 1180
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
INDIRI4
ASGNI4
line 369
;369:	trigger->restore_goal_no = self->restore_goal_no;
ADDRLP4 32
CNSTI4 1184
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
INDIRI4
ASGNI4
line 370
;370:	trigger->activate_group_no = self->activate_group_no;
ADDRLP4 36
CNSTI4 1188
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
INDIRI4
ASGNI4
line 371
;371:	trigger->inactivate_group_no = self->inactivate_group_no;
ADDRLP4 40
CNSTI4 1192
ASGNI4
ADDRLP4 0
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
line 372
;372:	trigger->remove_group_no = self->remove_group_no;
ADDRLP4 44
CNSTI4 1196
ASGNI4
ADDRLP4 0
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
line 373
;373:	trigger->restore_group_no = self->restore_group_no;
ADDRLP4 48
CNSTI4 1200
ASGNI4
ADDRLP4 0
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
line 374
;374:	trigger->goal_activation = self->goal_activation;
ADDRLP4 52
CNSTI4 1128
ASGNI4
ADDRLP4 0
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
line 375
;375:	trigger->goal_effects = self->goal_effects;
ADDRLP4 56
CNSTI4 1132
ASGNI4
ADDRLP4 0
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
line 376
;376:	trigger->goal_result = self->goal_result;
ADDRLP4 60
CNSTI4 1136
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 377
;377:	trigger->goal_group = self->goal_group;
ADDRLP4 64
CNSTI4 1140
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 378
;378:	trigger->all_active = self->all_active;
ADDRLP4 68
CNSTI4 1380
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 379
;379:	trigger->last_impulse = self->last_impulse;
ADDRLP4 72
CNSTI4 688
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 380
;380:	trigger->else_goal = self->else_goal;
ADDRLP4 76
CNSTI4 1144
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 382
;381:
;382:	setsize( trigger, fmins[0] - 60, fmins[1] - 60, fmins[2] - 8, fmaxs[0] + 60, fmaxs[1] + 60, fmaxs[2] + 8 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
CNSTF4 1114636288
ASGNF4
ADDRLP4 80
INDIRP4
INDIRF4
ADDRLP4 84
INDIRF4
SUBF4
ARGF4
ADDRLP4 88
CNSTI4 4
ASGNI4
ADDRLP4 80
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRF4
ADDRLP4 84
INDIRF4
SUBF4
ARGF4
ADDRLP4 92
CNSTI4 8
ASGNI4
ADDRLP4 96
CNSTF4 1090519040
ASGNF4
ADDRLP4 80
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRF4
ADDRLP4 96
INDIRF4
SUBF4
ARGF4
ADDRLP4 100
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ARGF4
ADDRLP4 100
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ARGF4
ADDRLP4 100
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRF4
ADDRLP4 96
INDIRF4
ADDF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 383
;383:	return ( trigger );
ADDRLP4 0
INDIRP4
RETP4
LABELV $132
endproc spawn_field 104 28
export EntitiesTouching
proc EntitiesTouching 0 0
line 388
;384:
;385:}
;386:
;387:qboolean EntitiesTouching( gedict_t * e1, gedict_t * e2 )
;388:{
line 389
;389:	if ( e1->s.v.mins[0] > e2->s.v.maxs[0] )
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
LEF4 $134
line 390
;390:		return false;
CNSTI4 0
RETI4
ADDRGP4 $133
JUMPV
LABELV $134
line 392
;391:
;392:	if ( e1->s.v.mins[1] > e2->s.v.maxs[1] )
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
LEF4 $136
line 393
;393:		return false;
CNSTI4 0
RETI4
ADDRGP4 $133
JUMPV
LABELV $136
line 395
;394:
;395:	if ( e1->s.v.mins[2] > e2->s.v.maxs[2] )
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
LEF4 $138
line 396
;396:		return false;
CNSTI4 0
RETI4
ADDRGP4 $133
JUMPV
LABELV $138
line 398
;397:
;398:	if ( e1->s.v.maxs[0] < e2->s.v.mins[0] )
ADDRFP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
GEF4 $140
line 399
;399:		return false;
CNSTI4 0
RETI4
ADDRGP4 $133
JUMPV
LABELV $140
line 401
;400:
;401:	if ( e1->s.v.maxs[1] < e2->s.v.mins[1] )
ADDRFP4 0
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
GEF4 $142
line 402
;402:		return false;
CNSTI4 0
RETI4
ADDRGP4 $133
JUMPV
LABELV $142
line 404
;403:
;404:	if ( e1->s.v.maxs[2] < e2->s.v.mins[2] )
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
GEF4 $144
line 405
;405:		return false;
CNSTI4 0
RETI4
ADDRGP4 $133
JUMPV
LABELV $144
line 407
;406:
;407:	return true;
CNSTI4 1
RETI4
LABELV $133
endproc EntitiesTouching 0 0
export LinkDoors
proc LinkDoors 64 12
line 419
;408:}
;409:
;410:/*
;411:=============
;412:LinkDoors
;413:
;414:
;415:=============
;416:*/
;417:
;418:void LinkDoors(  )
;419:{
line 423
;420:	gedict_t *t, *starte;
;421:	vec3_t  cmins, cmaxs;
;422:
;423:	if ( self->s.v.enemy )
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
CNSTI4 0
EQI4 $147
line 424
;424:		return;		// already linked by another door
ADDRGP4 $146
JUMPV
LABELV $147
line 426
;425:
;426:	if ( ( int ) ( self->s.v.spawnflags ) & 4 )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $149
line 427
;427:	{
line 428
;428:		self->s.v.owner = self->s.v.enemy = EDICT_TO_PROG( self );
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 400
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 480
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 429
;429:		return;		// don't want to link this door
ADDRGP4 $146
JUMPV
LABELV $149
line 432
;430:	}
;431:
;432:	VectorCopy( self->s.v.mins, cmins );
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ASGNF4
ADDRLP4 8+4
ADDRGP4 self
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ASGNF4
ADDRLP4 8+8
ADDRGP4 self
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ASGNF4
line 433
;433:	VectorCopy( self->s.v.maxs, cmaxs );
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20+4
ADDRGP4 self
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20+8
ADDRGP4 self
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
ASGNF4
line 437
;434:	//cmins = self->s.v.mins;
;435:	//cmaxs = self->s.v.maxs;
;436:
;437:	starte = self;
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
line 438
;438:	t = self;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
LABELV $155
line 441
;439:
;440:	do
;441:	{
line 442
;442:		self->s.v.owner = EDICT_TO_PROG( starte );	// master door
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 444
;443:
;444:		if ( self->s.v.health )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
EQF4 $158
line 445
;445:			starte->s.v.health = self->s.v.health;
ADDRLP4 32
CNSTI4 296
ASGNI4
ADDRLP4 4
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
LABELV $158
line 447
;446:
;447:		if ( self->s.v.targetname )
ADDRGP4 self
INDIRP4
CNSTI4 464
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $160
line 448
;448:			starte->s.v.targetname = self->s.v.targetname;
ADDRLP4 36
CNSTI4 464
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRP4
ASGNP4
LABELV $160
line 450
;449:
;450:		if ( strneq( self->s.v.message, "" ) )
ADDRGP4 self
INDIRP4
CNSTI4 496
ADDP4
INDIRP4
ARGP4
ADDRGP4 $57
ARGP4
ADDRLP4 40
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $162
line 451
;451:			starte->s.v.message = self->s.v.message;
ADDRLP4 44
CNSTI4 496
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRP4
ASGNP4
LABELV $162
line 453
;452:
;453:		t = trap_find( t, FOFS( s.v.classname ), self->s.v.classname );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 48
CNSTI4 216
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 self
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 52
INDIRP4
ASGNP4
line 455
;454:
;455:		if ( !t )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $164
line 456
;456:		{
line 457
;457:			self->s.v.enemy = EDICT_TO_PROG( starte );	// make the chain a loop
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 462
;458:
;459:			// shootable, fired, or key doors just needed the owner/enemy links,
;460:			// they don't spawn a field
;461:
;462:			self = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 56
ADDRGP4 self
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 464
;463:
;464:			if ( self->s.v.health )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
EQF4 $166
line 465
;465:				return;
ADDRGP4 $146
JUMPV
LABELV $166
line 466
;466:			if ( self->s.v.targetname )
ADDRGP4 self
INDIRP4
CNSTI4 464
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $168
line 467
;467:				return;
ADDRGP4 $146
JUMPV
LABELV $168
line 468
;468:			if ( self->s.v.items )
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CNSTF4 0
EQF4 $170
line 469
;469:				return;
ADDRGP4 $146
JUMPV
LABELV $170
line 470
;470:			PROG_TO_EDICT( self->s.v.owner )->trigger_field = spawn_field( cmins, cmaxs );
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 60
ADDRGP4 spawn_field
CALLP4
ASGNP4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+668
ADDP4
ADDRLP4 60
INDIRP4
ASGNP4
line 472
;471:
;472:			return;
ADDRGP4 $146
JUMPV
LABELV $164
line 474
;473:		}
;474:		if ( EntitiesTouching( self, t ) )
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 EntitiesTouching
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $173
line 475
;475:		{
line 476
;476:			if ( t->s.v.enemy )
ADDRLP4 0
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
CNSTI4 0
EQI4 $175
line 477
;477:				G_Error( "cross connected doors" );
ADDRGP4 $177
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $175
line 479
;478:
;479:			self->s.v.enemy = EDICT_TO_PROG( t );
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
line 480
;480:			self = t;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 482
;481:
;482:			if ( t->s.v.mins[0] < cmins[0] )
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $178
line 483
;483:				cmins[0] = t->s.v.mins[0];
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ASGNF4
LABELV $178
line 485
;484:
;485:			if ( t->s.v.mins[1] < cmins[1] )
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ADDRLP4 8+4
INDIRF4
GEF4 $180
line 486
;486:				cmins[1] = t->s.v.mins[1];
ADDRLP4 8+4
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ASGNF4
LABELV $180
line 488
;487:
;488:			if ( t->s.v.mins[2] < cmins[2] )
ADDRLP4 0
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ADDRLP4 8+8
INDIRF4
GEF4 $184
line 489
;489:				cmins[2] = t->s.v.mins[2];
ADDRLP4 8+8
ADDRLP4 0
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ASGNF4
LABELV $184
line 491
;490:
;491:			if ( t->s.v.maxs[0] > cmaxs[0] )
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
LEF4 $188
line 492
;492:				cmaxs[0] = t->s.v.maxs[0];
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ASGNF4
LABELV $188
line 494
;493:
;494:			if ( t->s.v.maxs[1] > cmaxs[1] )
ADDRLP4 0
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ADDRLP4 20+4
INDIRF4
LEF4 $190
line 495
;495:				cmaxs[1] = t->s.v.maxs[1];
ADDRLP4 20+4
ADDRLP4 0
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ASGNF4
LABELV $190
line 497
;496:
;497:			if ( t->s.v.maxs[2] > cmaxs[2] )
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
ADDRLP4 20+8
INDIRF4
LEF4 $194
line 498
;498:				cmaxs[2] = t->s.v.maxs[2];
ADDRLP4 20+8
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
ASGNF4
LABELV $194
line 499
;499:		}
LABELV $173
line 500
;500:	}
LABELV $156
line 501
;501:	while ( 1 );
ADDRGP4 $155
JUMPV
line 503
;502:
;503:}
LABELV $146
endproc LinkDoors 64 12
export SP_func_door
proc SP_func_door 56 16
line 531
;504:
;505:/*QUAKED func_door (0 .5 .8) ? START_OPEN x DOOR_DONT_LINK GOLD_KEY SILVER_KEY TOGGLE
;506:if two doors touch, they are assumed to be connected and operate as a unit.
;507:
;508:TOGGLE causes the door to wait in both the start and end states for a trigger event.
;509:
;510:START_OPEN causes the door to move to its destination when spawned, and operate in reverse.  It is used to temporarily or permanently close off an area when triggered (not usefull for touch or takedamage doors).
;511:
;512:Key doors are allways wait -1.
;513:
;514:"message"       is printed when the door is touched if it is a trigger door and it hasn't been fired yet
;515:"angle"         determines the opening direction
;516:"targetname" if set, no touch field will be spawned and a remote button or trigger field activates the door.
;517:"health"        if set, door must be shot open
;518:"speed"         movement speed (100 default)
;519:"wait"          wait before returning (3 default, -1 = never return)
;520:"lip"           lip remaining at end of move (8 default)
;521:"dmg"           damage to inflict when blocked (2 default)
;522:"sounds"
;523:0)      no sound
;524:1)      stone
;525:2)      base
;526:3)      stone chain
;527:4)      screechy metal
;528:*/
;529:
;530:void SP_func_door(  )
;531:{
line 534
;532:	float   tmp;
;533:
;534:	if ( !CheckExistence(  ) )
ADDRLP4 4
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $199
line 535
;535:	{
line 536
;536:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 537
;537:		return;
ADDRGP4 $198
JUMPV
LABELV $199
line 540
;538:	}
;539:
;540:	if ( world->worldtype == 0 )
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 0
NEI4 $201
line 541
;541:	{
line 542
;542:		trap_precache_sound( "doors/medtry.wav" );
ADDRGP4 $203
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 543
;543:		trap_precache_sound( "doors/meduse.wav" );
ADDRGP4 $204
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 544
;544:		self->s.v.noise3 = "doors/medtry.wav";
ADDRGP4 self
INDIRP4
CNSTI4 516
ADDP4
ADDRGP4 $203
ASGNP4
line 545
;545:		self->noise4 = "doors/meduse.wav";
ADDRGP4 self
INDIRP4
CNSTI4 680
ADDP4
ADDRGP4 $204
ASGNP4
line 546
;546:	} else if ( world->worldtype == 1 )
ADDRGP4 $202
JUMPV
LABELV $201
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 1
NEI4 $205
line 547
;547:	{
line 548
;548:		trap_precache_sound( "doors/runetry.wav" );
ADDRGP4 $207
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 549
;549:		trap_precache_sound( "doors/runeuse.wav" );
ADDRGP4 $208
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 550
;550:		self->s.v.noise3 = "doors/runetry.wav";
ADDRGP4 self
INDIRP4
CNSTI4 516
ADDP4
ADDRGP4 $207
ASGNP4
line 551
;551:		self->noise4 = "doors/runeuse.wav";
ADDRGP4 self
INDIRP4
CNSTI4 680
ADDP4
ADDRGP4 $208
ASGNP4
line 552
;552:	} else if ( world->worldtype == 2 )
ADDRGP4 $206
JUMPV
LABELV $205
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2
NEI4 $209
line 553
;553:	{
line 554
;554:		trap_precache_sound( "doors/basetry.wav" );
ADDRGP4 $211
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 555
;555:		trap_precache_sound( "doors/baseuse.wav" );
ADDRGP4 $212
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 556
;556:		self->s.v.noise3 = "doors/basetry.wav";
ADDRGP4 self
INDIRP4
CNSTI4 516
ADDP4
ADDRGP4 $211
ASGNP4
line 557
;557:		self->noise4 = "doors/baseuse.wav";
ADDRGP4 self
INDIRP4
CNSTI4 680
ADDP4
ADDRGP4 $212
ASGNP4
line 558
;558:	} else
ADDRGP4 $210
JUMPV
LABELV $209
line 559
;559:	{
line 560
;560:		G_dprintf( "no worldtype set!\n" );
ADDRGP4 $213
ARGP4
ADDRGP4 G_dprintf
CALLV
pop
line 561
;561:	}
LABELV $210
LABELV $206
LABELV $202
line 562
;562:	if ( self->s.v.sounds == 0 )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 0
NEF4 $214
line 563
;563:	{
line 564
;564:		trap_precache_sound( "misc/null.wav" );
ADDRGP4 $216
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 565
;565:		trap_precache_sound( "misc/null.wav" );
ADDRGP4 $216
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 566
;566:		self->s.v.noise1 = "misc/null.wav";
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
ADDRGP4 $216
ASGNP4
line 567
;567:		self->s.v.noise2 = "misc/null.wav";
ADDRGP4 self
INDIRP4
CNSTI4 512
ADDP4
ADDRGP4 $216
ASGNP4
line 568
;568:	}
LABELV $214
line 569
;569:	if ( self->s.v.sounds == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $217
line 570
;570:	{
line 571
;571:		trap_precache_sound( "doors/drclos4.wav" );
ADDRGP4 $219
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 572
;572:		trap_precache_sound( "doors/doormv1.wav" );
ADDRGP4 $220
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 573
;573:		self->s.v.noise1 = "doors/drclos4.wav";
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
ADDRGP4 $219
ASGNP4
line 574
;574:		self->s.v.noise2 = "doors/doormv1.wav";
ADDRGP4 self
INDIRP4
CNSTI4 512
ADDP4
ADDRGP4 $220
ASGNP4
line 575
;575:	}
LABELV $217
line 576
;576:	if ( self->s.v.sounds == 2 )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $221
line 577
;577:	{
line 578
;578:		trap_precache_sound( "doors/hydro1.wav" );
ADDRGP4 $223
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 579
;579:		trap_precache_sound( "doors/hydro2.wav" );
ADDRGP4 $224
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 580
;580:		self->s.v.noise2 = "doors/hydro1.wav";
ADDRGP4 self
INDIRP4
CNSTI4 512
ADDP4
ADDRGP4 $223
ASGNP4
line 581
;581:		self->s.v.noise1 = "doors/hydro2.wav";
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
ADDRGP4 $224
ASGNP4
line 582
;582:	}
LABELV $221
line 583
;583:	if ( self->s.v.sounds == 3 )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $225
line 584
;584:	{
line 585
;585:		trap_precache_sound( "doors/stndr1.wav" );
ADDRGP4 $227
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 586
;586:		trap_precache_sound( "doors/stndr2.wav" );
ADDRGP4 $228
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 587
;587:		self->s.v.noise2 = "doors/stndr1.wav";
ADDRGP4 self
INDIRP4
CNSTI4 512
ADDP4
ADDRGP4 $227
ASGNP4
line 588
;588:		self->s.v.noise1 = "doors/stndr2.wav";
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
ADDRGP4 $228
ASGNP4
line 589
;589:	}
LABELV $225
line 590
;590:	if ( self->s.v.sounds == 4 )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 1082130432
NEF4 $229
line 591
;591:	{
line 592
;592:		trap_precache_sound( "doors/ddoor1.wav" );
ADDRGP4 $231
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 594
;593:		//trap_precache_sound( "doors/ddoor2.wav" );
;594:		self->s.v.noise1 = "doors/ddoor2.wav";
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
ADDRGP4 $232
ASGNP4
line 595
;595:		self->s.v.noise2 = "doors/ddoor1.wav";
ADDRGP4 self
INDIRP4
CNSTI4 512
ADDP4
ADDRGP4 $231
ASGNP4
line 596
;596:	}
LABELV $229
line 597
;597:	if ( self->armorclass == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
CNSTI4 1
NEI4 $233
line 598
;598:	{
line 599
;599:		trap_precache_sound( "doors/creekdr1.wav" );
ADDRGP4 $235
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 600
;600:		trap_precache_sound( "doors/creekdr2.wav" );
ADDRGP4 $236
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 601
;601:		self->s.v.noise1 = "doors/creekdr1.wav";
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
ADDRGP4 $235
ASGNP4
line 602
;602:		self->s.v.noise2 = "doors/creekdr2.wav";
ADDRGP4 self
INDIRP4
CNSTI4 512
ADDP4
ADDRGP4 $236
ASGNP4
line 603
;603:	}
LABELV $233
line 604
;604:	if ( self->armorclass == 2 )
ADDRGP4 self
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
CNSTI4 2
NEI4 $237
line 605
;605:	{
line 606
;606:		trap_precache_sound( "doors/metaldr1.wav" );
ADDRGP4 $239
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 607
;607:		trap_precache_sound( "doors/metaldr2.wav" );
ADDRGP4 $240
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 608
;608:		self->s.v.noise1 = "doors/metaldr1.wav";
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
ADDRGP4 $239
ASGNP4
line 609
;609:		self->s.v.noise2 = "doors/metaldr2.wav";
ADDRGP4 self
INDIRP4
CNSTI4 512
ADDP4
ADDRGP4 $240
ASGNP4
line 610
;610:	}
LABELV $237
line 611
;611:	if ( self->armorclass == 3 )
ADDRGP4 self
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
CNSTI4 3
NEI4 $241
line 612
;612:	{
line 613
;613:		trap_precache_sound( "doors/electdr1.wav" );
ADDRGP4 $243
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 614
;614:		trap_precache_sound( "doors/electdr2.wav" );
ADDRGP4 $244
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 615
;615:		self->s.v.noise1 = "doors/electdr1.wav";
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
ADDRGP4 $243
ASGNP4
line 616
;616:		self->s.v.noise2 = "doors/electdr2.wav";
ADDRGP4 self
INDIRP4
CNSTI4 512
ADDP4
ADDRGP4 $244
ASGNP4
line 617
;617:	}
LABELV $241
line 618
;618:	if ( self->armorclass == 4 )
ADDRGP4 self
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
CNSTI4 4
NEI4 $245
line 619
;619:	{
line 620
;620:		trap_precache_sound( "doors/track_st.wav" );
ADDRGP4 $247
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 621
;621:		trap_precache_sound( "doors/track_e.wav" );
ADDRGP4 $248
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 622
;622:		self->s.v.noise1 = "doors/track_st.wav";
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
ADDRGP4 $247
ASGNP4
line 623
;623:		self->s.v.noise2 = "doors/track_e.wav";
ADDRGP4 self
INDIRP4
CNSTI4 512
ADDP4
ADDRGP4 $248
ASGNP4
line 624
;624:	}
LABELV $245
line 626
;625:
;626:	SetMovedir(  );
ADDRGP4 SetMovedir
CALLV
pop
line 628
;627:
;628:	self->s.v.max_health = self->s.v.health;
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 416
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ASGNF4
line 629
;629:	self->s.v.solid = SOLID_BSP;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1082130432
ASGNF4
line 630
;630:	self->s.v.movetype = MOVETYPE_PUSH;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1088421888
ASGNF4
line 632
;631:
;632:	setorigin( self, PASSVEC3( self->s.v.origin ) );
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
line 633
;633:	setmodel( self, self->s.v.model );
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 635
;634:
;635:	self->s.v.classname = "door";
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $249
ASGNP4
line 637
;636:
;637:	self->s.v.blocked = ( func_t ) door_blocked;
ADDRGP4 self
INDIRP4
CNSTI4 284
ADDP4
ADDRGP4 door_blocked
CVPU4 4
CVUI4 4
ASGNI4
line 638
;638:	self->s.v.use = ( func_t ) door_use;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 door_use
CVPU4 4
CVUI4 4
ASGNI4
line 640
;639:
;640:	if ( ( int ) ( self->s.v.spawnflags ) & DOOR_SILVER_KEY )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $250
line 641
;641:		self->s.v.items = IT_KEY1;
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
CNSTF4 1207959552
ASGNF4
LABELV $250
line 643
;642:
;643:	if ( ( int ) ( self->s.v.spawnflags ) & DOOR_GOLD_KEY )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $252
line 644
;644:		self->s.v.items = IT_KEY2;
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
CNSTF4 1216348160
ASGNF4
LABELV $252
line 646
;645:
;646:	if ( !self->speed )
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
CNSTF4 0
NEF4 $254
line 647
;647:		self->speed = 100;
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
CNSTF4 1120403456
ASGNF4
LABELV $254
line 649
;648:
;649:	if ( !self->wait )
ADDRGP4 self
INDIRP4
CNSTI4 660
ADDP4
INDIRF4
CNSTF4 0
NEF4 $256
line 650
;650:		self->wait = 3;
ADDRGP4 self
INDIRP4
CNSTI4 660
ADDP4
CNSTF4 1077936128
ASGNF4
LABELV $256
line 652
;651:
;652:	if ( !self->lip )
ADDRGP4 self
INDIRP4
CNSTI4 720
ADDP4
INDIRF4
CNSTF4 0
NEF4 $258
line 653
;653:		self->lip = 8;
ADDRGP4 self
INDIRP4
CNSTI4 720
ADDP4
CNSTF4 1090519040
ASGNF4
LABELV $258
line 655
;654:
;655:	if ( !self->dmg )
ADDRGP4 self
INDIRP4
CNSTI4 716
ADDP4
INDIRF4
CNSTF4 0
NEF4 $260
line 656
;656:		self->dmg = 2;
ADDRGP4 self
INDIRP4
CNSTI4 716
ADDP4
CNSTF4 1073741824
ASGNF4
LABELV $260
line 658
;657:
;658:	VectorCopy( self->s.v.origin, self->pos1 );
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 612
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 616
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 620
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 661
;659:
;660:	//
;661:	tmp = fabs( DotProduct( self->s.v.movedir, self->s.v.size ) ) - self->lip;
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 260
ADDP4
INDIRF4
MULF4
ADDRLP4 20
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 264
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 20
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 268
ADDP4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 24
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 720
ADDP4
INDIRF4
SUBF4
ASGNF4
line 663
;662:
;663:	self->pos2[0] = self->pos1[0] + self->s.v.movedir[0] * tmp;
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 624
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 612
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 664
;664:	self->pos2[1] = self->pos1[1] + self->s.v.movedir[1] * tmp;
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 628
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 616
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 665
;665:	self->pos2[2] = self->pos1[2] + self->s.v.movedir[2] * tmp;
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 632
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 620
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 669
;666:
;667:// DOOR_START_OPEN is to allow an entity to be lighted in the closed position
;668:// but spawn in the open position
;669:	if ( ( int ) ( self->s.v.spawnflags ) & DOOR_START_OPEN )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $262
line 670
;670:	{
line 671
;671:		setorigin( self, PASSVEC3( self->pos2 ) );
ADDRLP4 40
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 624
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 628
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 632
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 672
;672:		VectorCopy( self->pos1, self->pos2 );
ADDRLP4 44
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 624
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 612
ADDP4
INDIRF4
ASGNF4
ADDRLP4 48
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 628
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 616
ADDP4
INDIRF4
ASGNF4
ADDRLP4 52
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 632
ADDP4
ADDRLP4 52
INDIRP4
CNSTI4 620
ADDP4
INDIRF4
ASGNF4
line 673
;673:		VectorCopy( self->s.v.origin, self->pos1 );
ADDRLP4 44
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 612
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 48
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 616
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 52
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 620
ADDP4
ADDRLP4 52
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 674
;674:	}
LABELV $262
line 676
;675:
;676:	self->state = STATE_BOTTOM;
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 678
;677:
;678:	if ( self->s.v.health )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
EQF4 $264
line 679
;679:	{
line 680
;680:		self->s.v.takedamage = DAMAGE_YES;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 1065353216
ASGNF4
line 681
;681:		self->th_die = door_killed;
ADDRGP4 self
INDIRP4
CNSTI4 812
ADDP4
ADDRGP4 door_killed
ASGNP4
line 682
;682:	}
LABELV $264
line 684
;683:
;684:	if ( self->s.v.items )
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CNSTF4 0
EQF4 $266
line 685
;685:		self->wait = -1;
ADDRGP4 self
INDIRP4
CNSTI4 660
ADDP4
CNSTF4 3212836864
ASGNF4
LABELV $266
line 687
;686:
;687:	self->s.v.touch = ( func_t ) door_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 door_touch
CVPU4 4
CVUI4 4
ASGNI4
line 691
;688:
;689:// LinkDoors can't be done until all of the doors have been spawned, so
;690:// the sizes can be detected properly.
;691:	self->s.v.think = ( func_t ) LinkDoors;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 LinkDoors
CVPU4 4
CVUI4 4
ASGNI4
line 692
;692:	self->s.v.nextthink = self->s.v.ltime + 0.1;
ADDRLP4 40
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 288
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 140
ADDP4
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 693
;693:}
LABELV $198
endproc SP_func_door 56 16
export fd_secret_use
proc fd_secret_use 64 20
line 719
;694:
;695:/*
;696:=============================================================================
;697:
;698:SECRET DOORS
;699:
;700:=============================================================================
;701:*/
;702:
;703:void    fd_secret_move1(  );
;704:void    fd_secret_move2(  );
;705:void    fd_secret_move3(  );
;706:void    fd_secret_move4(  );
;707:void    fd_secret_move5(  );
;708:void    fd_secret_move6(  );
;709:void    fd_secret_done(  );
;710:
;711:#define SECRET_OPEN_ONCE 1	// stays open
;712:#define SECRET_1ST_LEFT 2	// 1st move is left of arrow
;713:#define SECRET_1ST_DOWN 4	// 1st move is down from arrow
;714:#define SECRET_NO_SHOOT 8	// only opened by trigger
;715:#define SECRET_YES_SHOOT 16	// shootable even if targeted
;716:
;717:
;718:void fd_secret_use( gedict_t * attacker, float take )
;719:{
line 722
;720:	float   temp;
;721:
;722:	self->s.v.health = 10000;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1176256512
ASGNF4
line 725
;723:
;724:	// exit if still moving around...
;725:	if ( !VectorCompare( self->s.v.origin, self->s.v.oldorigin ) )
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $269
line 726
;726:		return;
ADDRGP4 $268
JUMPV
LABELV $269
line 729
;727:
;728:	// TF Disable doors with spawnflags of DOOR_TOGGLE
;729:	if ( ( int ) ( self->s.v.spawnflags ) & DOOR_TOGGLE )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $271
line 730
;730:		return;
ADDRGP4 $268
JUMPV
LABELV $271
line 732
;731:
;732:	self->s.v.message = 0;	// no more message
ADDRGP4 self
INDIRP4
CNSTI4 496
ADDP4
CNSTP4 0
ASGNP4
line 734
;733:	//activator=attacker;
;734:	SUB_UseTargets(  );	// fire all targets / killtargets
ADDRGP4 SUB_UseTargets
CALLV
pop
line 736
;735:
;736:	if ( !( ( int ) ( self->s.v.spawnflags ) & SECRET_NO_SHOOT ) )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $273
line 737
;737:	{
line 738
;738:		self->th_pain = ( th_pain_func_t ) ( 0 );	//SUB_Null;
ADDRGP4 self
INDIRP4
CNSTI4 816
ADDP4
CNSTP4 0
ASGNP4
line 739
;739:		self->s.v.takedamage = DAMAGE_NO;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 0
ASGNF4
line 740
;740:	}
LABELV $273
line 742
;741:
;742:	VectorClear( self->s.v.velocity );
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 188
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
line 746
;743:
;744:	// Make a sound, wait a little...
;745:
;746:	sound( self, CHAN_VOICE, self->s.v.noise1, 1, ATTN_NORM );
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 20
INDIRP4
CNSTI4 508
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 747
;747:	self->s.v.nextthink = self->s.v.ltime + 0.1;
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 288
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 140
ADDP4
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 749
;748:
;749:	temp = 1 - ( ( int ) ( self->s.v.spawnflags ) & SECRET_1ST_LEFT );	// 1 or -1
ADDRLP4 0
CNSTI4 1
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 2
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 750
;750:	makevectors( self->mangle );
ADDRGP4 self
INDIRP4
CNSTI4 636
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 752
;751:
;752:	if ( self->t_width == 0 )
ADDRGP4 self
INDIRP4
CNSTI4 652
ADDP4
INDIRF4
CNSTF4 0
NEF4 $275
line 753
;753:	{
line 754
;754:		if ( ( int ) ( self->s.v.spawnflags ) & SECRET_1ST_DOWN )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $277
line 755
;755:			self->t_width = fabs( DotProduct( g_globalvars.v_up, self->s.v.size ) );
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRGP4 g_globalvars+240
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 260
ADDP4
INDIRF4
MULF4
ADDRGP4 g_globalvars+240+4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 264
ADDP4
INDIRF4
MULF4
ADDF4
ADDRGP4 g_globalvars+240+8
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 268
ADDP4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 36
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 32
INDIRP4
CNSTI4 652
ADDP4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRGP4 $278
JUMPV
LABELV $277
line 757
;756:		else
;757:			self->t_width = fabs( DotProduct( g_globalvars.v_right, self->s.v.size ) );
ADDRLP4 40
ADDRGP4 self
INDIRP4
ASGNP4
ADDRGP4 g_globalvars+252
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 260
ADDP4
INDIRF4
MULF4
ADDRGP4 g_globalvars+252+4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 264
ADDP4
INDIRF4
MULF4
ADDF4
ADDRGP4 g_globalvars+252+8
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 268
ADDP4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 44
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 40
INDIRP4
CNSTI4 652
ADDP4
ADDRLP4 44
INDIRF4
ASGNF4
LABELV $278
line 758
;758:	}
LABELV $275
line 760
;759:
;760:	if ( self->t_length == 0 )
ADDRGP4 self
INDIRP4
CNSTI4 648
ADDP4
INDIRF4
CNSTF4 0
NEF4 $289
line 761
;761:		self->t_length = fabs( DotProduct( g_globalvars.v_forward, self->s.v.size ) );
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRGP4 g_globalvars+228
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 260
ADDP4
INDIRF4
MULF4
ADDRGP4 g_globalvars+228+4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 264
ADDP4
INDIRF4
MULF4
ADDF4
ADDRGP4 g_globalvars+228+8
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 268
ADDP4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 36
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 32
INDIRP4
CNSTI4 648
ADDP4
ADDRLP4 36
INDIRF4
ASGNF4
LABELV $289
line 763
;762:
;763:	if ( ( int ) ( self->s.v.spawnflags ) & SECRET_1ST_DOWN )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $296
line 764
;764:	{
line 765
;765:		self->dest1[0] = self->s.v.origin[0] - g_globalvars.v_up[0] * self->t_width;
ADDRLP4 40
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 588
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRGP4 g_globalvars+240
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 652
ADDP4
INDIRF4
MULF4
SUBF4
ASGNF4
line 766
;766:		self->dest1[1] = self->s.v.origin[1] - g_globalvars.v_up[1] * self->t_width;
ADDRLP4 44
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 592
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRGP4 g_globalvars+240+4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 652
ADDP4
INDIRF4
MULF4
SUBF4
ASGNF4
line 767
;767:		self->dest1[2] = self->s.v.origin[2] - g_globalvars.v_up[2] * self->t_width;
ADDRLP4 48
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 596
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRGP4 g_globalvars+240+8
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 652
ADDP4
INDIRF4
MULF4
SUBF4
ASGNF4
line 768
;768:	} else
ADDRGP4 $297
JUMPV
LABELV $296
line 769
;769:	{
line 770
;770:		self->dest1[0] = self->s.v.origin[0] + g_globalvars.v_right[0] * ( self->t_width * temp );
ADDRLP4 40
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 588
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRGP4 g_globalvars+252
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 652
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 771
;771:		self->dest1[1] = self->s.v.origin[1] + g_globalvars.v_right[1] * ( self->t_width * temp );
ADDRLP4 44
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 592
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRGP4 g_globalvars+252+4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 652
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 772
;772:		self->dest1[2] = self->s.v.origin[2] + g_globalvars.v_right[2] * ( self->t_width * temp );
ADDRLP4 48
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 596
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRGP4 g_globalvars+252+8
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 652
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 773
;773:	}
LABELV $297
line 775
;774:
;775:	self->dest2[0] = self->dest1[0] + g_globalvars.v_forward[0] * self->t_length;
ADDRLP4 40
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 600
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 588
ADDP4
INDIRF4
ADDRGP4 g_globalvars+228
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 648
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 776
;776:	self->dest2[1] = self->dest1[1] + g_globalvars.v_forward[1] * self->t_length;
ADDRLP4 44
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 604
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 592
ADDP4
INDIRF4
ADDRGP4 g_globalvars+228+4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 648
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 777
;777:	self->dest2[2] = self->dest1[2] + g_globalvars.v_forward[2] * self->t_length;
ADDRLP4 48
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 608
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 596
ADDP4
INDIRF4
ADDRGP4 g_globalvars+228+8
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 648
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 779
;778:
;779:	SUB_CalcMove( self->dest1, self->speed, fd_secret_move1 );
ADDRLP4 52
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 588
ADDP4
ARGP4
ADDRLP4 52
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
ARGF4
ADDRGP4 fd_secret_move1
ARGP4
ADDRGP4 SUB_CalcMove
CALLV
pop
line 780
;780:	sound( self, CHAN_VOICE, self->s.v.noise2, 1, ATTN_NORM );
ADDRLP4 56
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 512
ADDP4
INDIRP4
ARGP4
ADDRLP4 60
CNSTF4 1065353216
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 781
;781:}
LABELV $268
endproc fd_secret_use 64 20
export fd_secret_move1
proc fd_secret_move1 12 20
line 785
;782:
;783:// Wait after first movement...
;784:void fd_secret_move1(  )
;785:{
line 786
;786:	self->s.v.nextthink = self->s.v.ltime + 1.0;
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
CNSTF4 1065353216
ADDF4
ASGNF4
line 787
;787:	self->s.v.think = ( func_t ) fd_secret_move2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 fd_secret_move2
CVPU4 4
CVUI4 4
ASGNI4
line 788
;788:	sound( self, CHAN_VOICE, self->s.v.noise3, 1, ATTN_NORM );
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
CNSTI4 516
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
line 789
;789:}
LABELV $313
endproc fd_secret_move1 12 20
export fd_secret_move2
proc fd_secret_move2 12 20
line 793
;790:
;791:// Start moving sideways w/sound...
;792:void fd_secret_move2(  )
;793:{
line 794
;794:	sound( self, CHAN_VOICE, self->s.v.noise2, 1, ATTN_NORM );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRP4
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
line 795
;795:	SUB_CalcMove( self->dest2, self->speed, fd_secret_move3 );
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 600
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
ARGF4
ADDRGP4 fd_secret_move3
ARGP4
ADDRGP4 SUB_CalcMove
CALLV
pop
line 796
;796:}
LABELV $314
endproc fd_secret_move2 12 20
export fd_secret_move3
proc fd_secret_move3 12 20
line 800
;797:
;798:// Wait here until time to go back...
;799:void fd_secret_move3(  )
;800:{
line 801
;801:	sound( self, CHAN_VOICE, self->s.v.noise3, 1, ATTN_NORM );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
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
line 802
;802:	if ( !( ( int ) ( self->s.v.spawnflags ) & SECRET_OPEN_ONCE ) )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $316
line 803
;803:	{
line 804
;804:		self->s.v.nextthink = self->s.v.ltime + self->wait;
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 288
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 140
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 660
ADDP4
INDIRF4
ADDF4
ASGNF4
line 805
;805:		self->s.v.think = ( func_t ) fd_secret_move4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 fd_secret_move4
CVPU4 4
CVUI4 4
ASGNI4
line 806
;806:	}
LABELV $316
line 807
;807:}
LABELV $315
endproc fd_secret_move3 12 20
export fd_secret_move4
proc fd_secret_move4 12 20
line 811
;808:
;809:// Move backward...
;810:void fd_secret_move4(  )
;811:{
line 812
;812:	sound( self, CHAN_VOICE, self->s.v.noise2, 1, ATTN_NORM );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRP4
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
line 813
;813:	SUB_CalcMove( self->dest1, self->speed, fd_secret_move5 );
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 588
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
ARGF4
ADDRGP4 fd_secret_move5
ARGP4
ADDRGP4 SUB_CalcMove
CALLV
pop
line 814
;814:}
LABELV $318
endproc fd_secret_move4 12 20
export fd_secret_move5
proc fd_secret_move5 12 20
line 818
;815:
;816:// Wait 1 second...
;817:void fd_secret_move5(  )
;818:{
line 819
;819:	self->s.v.nextthink = self->s.v.ltime + 1.0;
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
CNSTF4 1065353216
ADDF4
ASGNF4
line 820
;820:	self->s.v.think = ( func_t ) fd_secret_move6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 fd_secret_move6
CVPU4 4
CVUI4 4
ASGNI4
line 821
;821:	sound( self, CHAN_VOICE, self->s.v.noise3, 1, ATTN_NORM );
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
CNSTI4 516
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
line 822
;822:}
LABELV $319
endproc fd_secret_move5 12 20
export fd_secret_move6
proc fd_secret_move6 12 20
line 825
;823:
;824:void fd_secret_move6(  )
;825:{
line 826
;826:	sound( self, CHAN_VOICE, self->s.v.noise2, 1, ATTN_NORM );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRP4
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
line 827
;827:	SUB_CalcMove( self->s.v.oldorigin, self->speed, fd_secret_done );
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
ARGF4
ADDRGP4 fd_secret_done
ARGP4
ADDRGP4 SUB_CalcMove
CALLV
pop
line 828
;828:}
LABELV $320
endproc fd_secret_move6 12 20
export fd_secret_done
proc fd_secret_done 12 20
line 832
;829:
;830:
;831:void fd_secret_done(  )
;832:{
line 833
;833:	if ( !self->s.v.targetname || ( int ) ( self->s.v.spawnflags ) & SECRET_YES_SHOOT )
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 464
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $324
ADDRLP4 0
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $322
LABELV $324
line 834
;834:	{
line 835
;835:		self->s.v.health = 10000;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1176256512
ASGNF4
line 836
;836:		self->s.v.takedamage = DAMAGE_YES;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 1065353216
ASGNF4
line 837
;837:		self->th_pain = fd_secret_use;
ADDRGP4 self
INDIRP4
CNSTI4 816
ADDP4
ADDRGP4 fd_secret_use
ASGNP4
line 838
;838:		self->th_die = ( void ( * )(  ) ) fd_secret_use;
ADDRGP4 self
INDIRP4
CNSTI4 812
ADDP4
ADDRGP4 fd_secret_use
ASGNP4
line 839
;839:	}
LABELV $322
line 840
;840:	sound( self, CHAN_VOICE, self->s.v.noise3, 1, ATTN_NORM );
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
CNSTI4 516
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
line 841
;841:}
LABELV $321
endproc fd_secret_done 12 20
export secret_blocked
proc secret_blocked 4 16
line 844
;842:
;843:void secret_blocked(  )
;844:{
line 845
;845:	if ( g_globalvars.time < self->attack_finished )
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
GEF4 $326
line 846
;846:		return;
ADDRGP4 $325
JUMPV
LABELV $326
line 847
;847:	self->attack_finished = g_globalvars.time + 0.5;
ADDRGP4 self
INDIRP4
CNSTI4 724
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 849
;848://      other->deathtype = "squish";
;849:	T_Damage( other, self, self, self->dmg );
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRF4
ARGF4
ADDRGP4 T_Damage
CALLV
pop
line 850
;850:}
LABELV $325
endproc secret_blocked 4 16
export secret_touch
proc secret_touch 8 20
line 861
;851:
;852:/*
;853:================
;854:secret_touch
;855:
;856:Prints messages
;857:================
;858:*/
;859:
;860:void secret_touch(  )
;861:{
line 862
;862:	if ( strneq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $20
ARGP4
ADDRLP4 0
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $331
line 863
;863:		return;
ADDRGP4 $330
JUMPV
LABELV $331
line 865
;864:
;865:	if ( self->attack_finished > g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $333
line 866
;866:		return;
ADDRGP4 $330
JUMPV
LABELV $333
line 869
;867:
;868:	// TF Disable doors with spawnflags of DOOR_TOGGLE
;869:	if ( ( int ) ( self->s.v.spawnflags ) & DOOR_TOGGLE )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $336
line 870
;870:		return;
ADDRGP4 $330
JUMPV
LABELV $336
line 872
;871:
;872:	self->attack_finished = g_globalvars.time + 2;
ADDRGP4 self
INDIRP4
CNSTI4 724
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 874
;873:
;874:	if ( self->s.v.message )
ADDRGP4 self
INDIRP4
CNSTI4 496
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $339
line 875
;875:	{
line 876
;876:		G_centerprint( other, self->s.v.message );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 496
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 877
;877:		sound( other, CHAN_BODY, "misc/talk.wav", 1, ATTN_NORM );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $99
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
line 878
;878:	}
LABELV $339
line 879
;879:}
LABELV $330
endproc secret_touch 8 20
export SP_func_door_secret
proc SP_func_door_secret 28 16
line 899
;880:
;881:/*QUAKED func_door_secret (0 .5 .8) ? open_once 1st_left 1st_down no_shoot always_shoot
;882:Basic secret door. Slides back, then to the side. Angle determines direction.
;883:wait  = # of seconds before coming back
;884:1st_left = 1st move is left of arrow
;885:1st_down = 1st move is down from arrow
;886:always_shoot = even if targeted, keep shootable
;887:t_width = override WIDTH to move back (or height if going down)
;888:t_length = override LENGTH to move sideways
;889:"dmg"           damage to inflict when blocked (2 default)
;890:
;891:If a secret door has a targetname, it will only be opened by it's botton or trigger, not by damage.
;892:"sounds"
;893:1) medieval
;894:2) metal
;895:3) base
;896:*/
;897:
;898:void SP_func_door_secret(  )
;899:{
line 900
;900:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $342
line 901
;901:	{
line 902
;902:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 903
;903:		return;
ADDRGP4 $341
JUMPV
LABELV $342
line 906
;904:	}
;905:
;906:	if ( self->s.v.sounds == 0 )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 0
NEF4 $344
line 907
;907:		self->s.v.sounds = 3;
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
CNSTF4 1077936128
ASGNF4
LABELV $344
line 909
;908:
;909:	if ( self->s.v.sounds == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $346
line 910
;910:	{
line 911
;911:		trap_precache_sound( "doors/latch2.wav" );
ADDRGP4 $348
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 912
;912:		trap_precache_sound( "doors/winch2.wav" );
ADDRGP4 $349
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 913
;913:		trap_precache_sound( "doors/drclos4.wav" );
ADDRGP4 $219
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 914
;914:		self->s.v.noise1 = "doors/latch2.wav";
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
ADDRGP4 $348
ASGNP4
line 915
;915:		self->s.v.noise2 = "doors/winch2.wav";
ADDRGP4 self
INDIRP4
CNSTI4 512
ADDP4
ADDRGP4 $349
ASGNP4
line 916
;916:		self->s.v.noise3 = "doors/drclos4.wav";
ADDRGP4 self
INDIRP4
CNSTI4 516
ADDP4
ADDRGP4 $219
ASGNP4
line 917
;917:	}
LABELV $346
line 918
;918:	if ( self->s.v.sounds == 2 )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $350
line 919
;919:	{
line 920
;920:		trap_precache_sound( "doors/airdoor1.wav" );
ADDRGP4 $352
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 921
;921:		trap_precache_sound( "doors/airdoor2.wav" );
ADDRGP4 $353
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 922
;922:		self->s.v.noise2 = "doors/airdoor1.wav";
ADDRGP4 self
INDIRP4
CNSTI4 512
ADDP4
ADDRGP4 $352
ASGNP4
line 923
;923:		self->s.v.noise1 = "doors/airdoor2.wav";
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
ADDRGP4 $353
ASGNP4
line 924
;924:		self->s.v.noise3 = "doors/airdoor2.wav";
ADDRGP4 self
INDIRP4
CNSTI4 516
ADDP4
ADDRGP4 $353
ASGNP4
line 925
;925:	}
LABELV $350
line 926
;926:	if ( self->s.v.sounds == 3 )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $354
line 927
;927:	{
line 928
;928:		trap_precache_sound( "doors/basesec1.wav" );
ADDRGP4 $356
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 929
;929:		trap_precache_sound( "doors/basesec2.wav" );
ADDRGP4 $357
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 930
;930:		self->s.v.noise2 = "doors/basesec1.wav";
ADDRGP4 self
INDIRP4
CNSTI4 512
ADDP4
ADDRGP4 $356
ASGNP4
line 931
;931:		self->s.v.noise1 = "doors/basesec2.wav";
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
ADDRGP4 $357
ASGNP4
line 932
;932:		self->s.v.noise3 = "doors/basesec2.wav";
ADDRGP4 self
INDIRP4
CNSTI4 516
ADDP4
ADDRGP4 $357
ASGNP4
line 933
;933:	}
LABELV $354
line 935
;934:
;935:	if ( self->dmg == 0 )
ADDRGP4 self
INDIRP4
CNSTI4 716
ADDP4
INDIRF4
CNSTF4 0
NEF4 $358
line 936
;936:		self->dmg = 2;
ADDRGP4 self
INDIRP4
CNSTI4 716
ADDP4
CNSTF4 1073741824
ASGNF4
LABELV $358
line 939
;937:
;938:	// Magic formula...
;939:	VectorCopy( self->s.v.angles, self->mangle );
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 636
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
ASGNF4
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 640
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 644
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 200
ADDP4
INDIRF4
ASGNF4
line 940
;940:	SetVector( self->s.v.angles, 0, 0, 0 );
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 0
ASGNF4
line 941
;941:	self->s.v.solid = SOLID_BSP;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1082130432
ASGNF4
line 942
;942:	self->s.v.movetype = MOVETYPE_PUSH;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1088421888
ASGNF4
line 943
;943:	self->s.v.classname = "door";
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $249
ASGNP4
line 944
;944:	setmodel( self, self->s.v.model );
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 945
;945:	setorigin( self, PASSVEC3( self->s.v.origin ) );
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
line 947
;946:
;947:	self->s.v.touch = ( func_t ) secret_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 secret_touch
CVPU4 4
CVUI4 4
ASGNI4
line 948
;948:	self->s.v.blocked = ( func_t ) secret_blocked;
ADDRGP4 self
INDIRP4
CNSTI4 284
ADDP4
ADDRGP4 secret_blocked
CVPU4 4
CVUI4 4
ASGNI4
line 949
;949:	self->speed = 50;
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
CNSTF4 1112014848
ASGNF4
line 950
;950:	self->s.v.use = ( func_t ) fd_secret_use;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 fd_secret_use
CVPU4 4
CVUI4 4
ASGNI4
line 951
;951:	if ( !self->s.v.targetname || ( int ) ( self->s.v.spawnflags ) & SECRET_YES_SHOOT )
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 464
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $362
ADDRLP4 12
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $360
LABELV $362
line 952
;952:	{
line 953
;953:		self->s.v.health = 10000;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1176256512
ASGNF4
line 954
;954:		self->s.v.takedamage = DAMAGE_YES;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 1065353216
ASGNF4
line 955
;955:		self->th_pain = fd_secret_use;
ADDRGP4 self
INDIRP4
CNSTI4 816
ADDP4
ADDRGP4 fd_secret_use
ASGNP4
line 956
;956:	}
LABELV $360
line 957
;957:	VectorCopy( self->s.v.origin, self->s.v.oldorigin );
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 168
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 172
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 959
;958:
;959:	if ( self->wait == 0 )
ADDRGP4 self
INDIRP4
CNSTI4 660
ADDP4
INDIRF4
CNSTF4 0
NEF4 $363
line 960
;960:		self->wait = 5;	// 5 seconds before closing
ADDRGP4 self
INDIRP4
CNSTI4 660
ADDP4
CNSTF4 1084227584
ASGNF4
LABELV $363
line 961
;961:}
LABELV $341
endproc SP_func_door_secret 28 16
import DoorShouldOpen
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
LABELV $357
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 115
byte 1 101
byte 1 99
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $356
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 115
byte 1 101
byte 1 99
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $353
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 97
byte 1 105
byte 1 114
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $352
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 97
byte 1 105
byte 1 114
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $349
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 119
byte 1 105
byte 1 110
byte 1 99
byte 1 104
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $348
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 108
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $249
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $248
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 107
byte 1 95
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $247
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 107
byte 1 95
byte 1 115
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $244
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 100
byte 1 114
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $243
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 100
byte 1 114
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $240
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 116
byte 1 97
byte 1 108
byte 1 100
byte 1 114
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $239
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 116
byte 1 97
byte 1 108
byte 1 100
byte 1 114
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $236
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 107
byte 1 100
byte 1 114
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $235
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 107
byte 1 100
byte 1 114
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $232
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 100
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $231
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 100
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $228
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 110
byte 1 100
byte 1 114
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $227
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 110
byte 1 100
byte 1 114
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $224
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 104
byte 1 121
byte 1 100
byte 1 114
byte 1 111
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $223
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 104
byte 1 121
byte 1 100
byte 1 114
byte 1 111
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $220
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 109
byte 1 118
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $219
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 100
byte 1 114
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 52
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $216
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 110
byte 1 117
byte 1 108
byte 1 108
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $213
byte 1 110
byte 1 111
byte 1 32
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $212
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 117
byte 1 115
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $211
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 116
byte 1 114
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $208
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 114
byte 1 117
byte 1 110
byte 1 101
byte 1 117
byte 1 115
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $207
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 114
byte 1 117
byte 1 110
byte 1 101
byte 1 116
byte 1 114
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $204
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
LABELV $203
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 100
byte 1 116
byte 1 114
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $177
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $125
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 111
byte 1 108
byte 1 100
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $122
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 111
byte 1 108
byte 1 100
byte 1 32
byte 1 114
byte 1 117
byte 1 110
byte 1 101
byte 1 107
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $119
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 111
byte 1 108
byte 1 100
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 99
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $116
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 105
byte 1 108
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $113
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 105
byte 1 108
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 114
byte 1 117
byte 1 110
byte 1 101
byte 1 107
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $110
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 105
byte 1 108
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 99
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $99
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 116
byte 1 97
byte 1 108
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $57
byte 1 0
align 1
LABELV $40
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 95
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 46
byte 1 111
byte 1 119
byte 1 110
byte 1 101
byte 1 114
byte 1 32
byte 1 33
byte 1 61
byte 1 32
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $20
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $15
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 113
byte 1 117
byte 1 97
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $14
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 0
