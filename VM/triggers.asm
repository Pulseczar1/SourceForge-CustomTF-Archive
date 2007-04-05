export trigger_reactivate
code
proc trigger_reactivate 0 0
file "..\src\triggers.c"
line 29
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
;21: *  $Id: triggers.c,v 1.9 2006/03/04 13:09:25 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:gedict_t *stemp, *otemp, *s, *old;
;25:
;26:
;27:
;28:void trigger_reactivate(  )
;29:{
line 30
;30:	self->s.v.solid = SOLID_TRIGGER;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 31
;31:}
LABELV $11
endproc trigger_reactivate 0 0
export multi_wait
proc multi_wait 4 0
line 40
;32:
;33://=============================================================================
;34:#define SPAWNFLAG_NOMESSAGE  1
;35:#define SPAWNFLAG_NOTOUCH  1
;36:
;37:// the wait time has passed, so set back up for another activation
;38:
;39:void multi_wait(  )
;40:{
line 41
;41:	if ( self->s.v.max_health )
ADDRGP4 self
INDIRP4
CNSTI4 416
ADDP4
INDIRF4
CNSTF4 0
EQF4 $13
line 42
;42:	{
line 43
;43:		self->s.v.health = self->s.v.max_health;
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
line 44
;44:		self->s.v.takedamage = DAMAGE_YES;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 1065353216
ASGNF4
line 45
;45:		self->s.v.solid = SOLID_BBOX;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 46
;46:	}
LABELV $13
line 47
;47:}
LABELV $12
endproc multi_wait 4 0
export multi_trigger
proc multi_trigger 16 20
line 54
;48:
;49:// the trigger was just touched/killed/used
;50:// enemy should be set to the activator so it can be held through a delay
;51:// so wait for the delay g_globalvars.time before firing
;52:
;53:void multi_trigger(  )
;54:{
line 55
;55:	if ( self->s.v.nextthink > g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $16
line 56
;56:	{
line 57
;57:		return;		// allready been triggered
ADDRGP4 $15
JUMPV
LABELV $16
line 60
;58:	}
;59:
;60:	if ( streq( self->s.v.classname, "trigger_secret" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $21
ARGP4
ADDRLP4 0
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $19
line 61
;61:	{
line 62
;62:		if ( strneq( PROG_TO_EDICT( self->s.v.enemy )->s.v.classname, "player" ) )
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+104
ADDP4
INDIRP4
ARGP4
ADDRGP4 $26
ARGP4
ADDRLP4 4
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $22
line 63
;63:			return;
ADDRGP4 $15
JUMPV
LABELV $22
line 64
;64:		g_globalvars.found_secrets = g_globalvars.found_secrets + 1;
ADDRGP4 g_globalvars+156
ADDRGP4 g_globalvars+156
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 65
;65:		trap_WriteByte( MSG_ALL, SVC_FOUNDSECRET );
CNSTI4 2
ARGI4
CNSTI4 28
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 66
;66:	}
LABELV $19
line 68
;67:
;68:	if ( self->s.v.noise )
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $29
line 69
;69:		sound( self, CHAN_VOICE, self->s.v.noise, 1, ATTN_NORM );
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
LABELV $29
line 72
;70:
;71:// don't trigger again until reset
;72:	self->s.v.takedamage = DAMAGE_NO;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 0
ASGNF4
line 74
;73:
;74:	activator = PROG_TO_EDICT( self->s.v.enemy );
ADDRGP4 activator
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 76
;75:
;76:	SUB_UseTargets(  );
ADDRGP4 SUB_UseTargets
CALLV
pop
line 78
;77:
;78:	if ( self->wait > 0 )
ADDRGP4 self
INDIRP4
CNSTI4 660
ADDP4
INDIRF4
CNSTF4 0
LEF4 $31
line 79
;79:	{
line 80
;80:		self->s.v.think = ( func_t ) multi_wait;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 multi_wait
CVPU4 4
CVUI4 4
ASGNI4
line 81
;81:		self->s.v.nextthink = g_globalvars.time + self->wait;
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 660
ADDP4
INDIRF4
ADDF4
ASGNF4
line 82
;82:	} else
ADDRGP4 $32
JUMPV
LABELV $31
line 83
;83:	{			// we can't just ent_remove(self) here, because this is a touch function
line 85
;84:		// called wheil C code is looping through area links...
;85:		self->s.v.touch = ( func_t ) SUB_Null;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 SUB_Null
CVPU4 4
CVUI4 4
ASGNI4
line 86
;86:		self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 87
;87:		self->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 88
;88:	}
LABELV $32
line 89
;89:}
LABELV $15
endproc multi_trigger 16 20
export multi_killed
proc multi_killed 0 0
line 92
;90:
;91:void multi_killed(  )
;92:{
line 93
;93:	self->s.v.enemy = EDICT_TO_PROG( damage_attacker );
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
line 94
;94:	multi_trigger(  );
ADDRGP4 multi_trigger
CALLV
pop
line 95
;95:}
LABELV $35
endproc multi_killed 0 0
export multi_use
proc multi_use 0 0
line 98
;96:
;97:void multi_use(  )
;98:{
line 99
;99:	self->s.v.enemy = EDICT_TO_PROG( activator );
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
line 100
;100:	multi_trigger(  );
ADDRGP4 multi_trigger
CALLV
pop
line 101
;101:}
LABELV $36
endproc multi_use 0 0
export multi_touch
proc multi_touch 24 16
line 104
;102:
;103:void multi_touch(  )
;104:{
line 107
;105:	gedict_t *te;
;106:
;107:	if ( !other->s.v.classname )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $38
line 108
;108:		return;
ADDRGP4 $37
JUMPV
LABELV $38
line 109
;109:	if ( strneq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $26
ARGP4
ADDRLP4 4
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $40
line 110
;110:		return;
ADDRGP4 $37
JUMPV
LABELV $40
line 112
;111:
;112:	if ( !Activated( self, other ) )
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
NEI4 $42
line 113
;113:	{
line 114
;114:		if ( self->else_goal )
ADDRGP4 self
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $37
line 115
;115:		{
line 116
;116:			te = Findgoal( self->else_goal );
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
line 117
;117:			if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $37
line 118
;118:				AttemptToActivate( te, other, self );
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
line 119
;119:		}
line 120
;120:		return;
ADDRGP4 $37
JUMPV
LABELV $42
line 123
;121:	}
;122:
;123:	if ( !VectorCompareF( self->s.v.movedir, 0, 0, 0 ) )
ADDRGP4 self
INDIRP4
CNSTI4 484
ADDP4
ARGP4
ADDRLP4 12
CNSTF4 0
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
ADDRGP4 VectorCompareF
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $48
line 124
;124:	{
line 125
;125:		makevectors( other->s.v.angles );
ADDRGP4 other
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 126
;126:		if ( DotProduct( g_globalvars.v_forward, self->s.v.movedir ) < 0 )
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRGP4 g_globalvars+228
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
MULF4
ADDRGP4 g_globalvars+228+4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
MULF4
ADDF4
ADDRGP4 g_globalvars+228+8
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
MULF4
ADDF4
CNSTF4 0
GEF4 $50
line 127
;127:			return;	// not facing the right way
ADDRGP4 $37
JUMPV
LABELV $50
line 128
;128:	}
LABELV $48
line 130
;129:
;130:	self->s.v.enemy = EDICT_TO_PROG( other );
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
line 131
;131:	multi_trigger(  );
ADDRGP4 multi_trigger
CALLV
pop
line 132
;132:}
LABELV $37
endproc multi_touch 24 16
export SP_trigger_multiple
proc SP_trigger_multiple 12 16
line 148
;133:
;134:/*QUAKED trigger_multiple (.5 .5 .5) ? notouch
;135:Variable sized repeatable trigger.  Must be targeted at one or more entities.  If "health" is set, the trigger must be killed to activate each time.
;136:If "delay" is set, the trigger waits some time after activating before firing.
;137:"wait" : Seconds between triggerings. (.2 default)
;138:If notouch is set, the trigger is only fired by other entities, not by touching.
;139:NOTOUCH has been obsoleted by trigger_relay!
;140:sounds
;141:1) secret
;142:2) beep beep
;143:3) large switch
;144:4)
;145:set "message" to text string
;146:*/
;147:void SP_trigger_multiple(  )
;148:{
line 149
;149:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $58
line 150
;150:	{
line 151
;151:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 152
;152:		return;
ADDRGP4 $57
JUMPV
LABELV $58
line 154
;153:	}
;154:	if ( self->s.v.sounds == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $60
line 155
;155:	{
line 156
;156:		trap_precache_sound( "misc/secret.wav" );
ADDRGP4 $62
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 157
;157:		self->s.v.noise = "misc/secret.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $62
ASGNP4
line 158
;158:	} else if ( self->s.v.sounds == 2 )
ADDRGP4 $61
JUMPV
LABELV $60
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $63
line 159
;159:	{
line 160
;160:		trap_precache_sound( "misc/talk.wav" );
ADDRGP4 $65
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 161
;161:		self->s.v.noise = "misc/talk.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $65
ASGNP4
line 162
;162:	} else if ( self->s.v.sounds == 3 )
ADDRGP4 $64
JUMPV
LABELV $63
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $66
line 163
;163:	{
line 164
;164:		trap_precache_sound( "misc/trigger1.wav" );
ADDRGP4 $68
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 165
;165:		self->s.v.noise = "misc/trigger1.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $68
ASGNP4
line 166
;166:	}
LABELV $66
LABELV $64
LABELV $61
line 168
;167:
;168:	if ( !self->wait )
ADDRGP4 self
INDIRP4
CNSTI4 660
ADDP4
INDIRF4
CNSTF4 0
NEF4 $69
line 169
;169:		self->wait = 0.2;
ADDRGP4 self
INDIRP4
CNSTI4 660
ADDP4
CNSTF4 1045220557
ASGNF4
LABELV $69
line 170
;170:	self->s.v.use = ( func_t ) multi_use;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 multi_use
CVPU4 4
CVUI4 4
ASGNI4
line 172
;171:
;172:	InitTrigger(  );
ADDRGP4 InitTrigger
CALLV
pop
line 174
;173:
;174:	if ( self->s.v.health )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
EQF4 $71
line 175
;175:	{
line 176
;176:		if ( ( int ) ( self->s.v.spawnflags ) & SPAWNFLAG_NOTOUCH )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $73
line 177
;177:			G_Error( "health and notouch don't make sense\n" );
ADDRGP4 $75
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $73
line 178
;178:		self->s.v.max_health = self->s.v.health;
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ASGNF4
line 179
;179:		self->th_die = multi_killed;
ADDRGP4 self
INDIRP4
CNSTI4 812
ADDP4
ADDRGP4 multi_killed
ASGNP4
line 180
;180:		self->s.v.takedamage = DAMAGE_YES;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 1065353216
ASGNF4
line 181
;181:		self->s.v.solid = SOLID_BBOX;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 182
;182:		setorigin( self, PASSVEC3( self->s.v.origin ) );	// make sure it links into the world
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
line 183
;183:	} else
ADDRGP4 $72
JUMPV
LABELV $71
line 184
;184:	{
line 185
;185:		if ( !( ( int ) ( self->s.v.spawnflags ) & SPAWNFLAG_NOTOUCH ) )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $76
line 186
;186:		{
line 187
;187:			self->s.v.touch = ( func_t ) multi_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 multi_touch
CVPU4 4
CVUI4 4
ASGNI4
line 188
;188:		}
LABELV $76
line 189
;189:	}
LABELV $72
line 190
;190:}
LABELV $57
endproc SP_trigger_multiple 12 16
export SP_trigger_once
proc SP_trigger_once 4 4
line 206
;191:
;192:/*QUAKED trigger_once (.5 .5 .5) ? notouch
;193:Variable sized trigger. Triggers once, then removes itself.  You must set the key "target" to the name of another object in the level that has a matching
;194:"targetname".  If "health" is set, the trigger must be killed to activate.
;195:If notouch is set, the trigger is only fired by other entities, not by touching.
;196:if "killtarget" is set, any objects that have a matching "target" will be removed when the trigger is fired.
;197:if "angle" is set, the trigger will only fire when someone is facing the direction of the angle.  Use "360" for an angle of 0.
;198:sounds
;199:1) secret
;200:2) beep beep
;201:3) large switch
;202:4)
;203:set "message" to text string
;204:*/
;205:void SP_trigger_once(  )
;206:{
line 207
;207:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $79
line 208
;208:	{
line 209
;209:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 210
;210:		return;
ADDRGP4 $78
JUMPV
LABELV $79
line 212
;211:	}
;212:	self->wait = -1;
ADDRGP4 self
INDIRP4
CNSTI4 660
ADDP4
CNSTF4 3212836864
ASGNF4
line 213
;213:	SP_trigger_multiple(  );
ADDRGP4 SP_trigger_multiple
CALLV
pop
line 214
;214:}
LABELV $78
endproc SP_trigger_once 4 4
export SP_trigger_relay
proc SP_trigger_relay 4 4
line 222
;215:
;216://=============================================================================
;217:
;218:/*QUAKED trigger_relay (.5 .5 .5) (-8 -8 -8) (8 8 8)
;219:This fixed size trigger cannot be touched, it can only be fired by other events.  It can contain killtargets, targets, delays, and messages.
;220:*/
;221:void SP_trigger_relay(  )
;222:{
line 223
;223:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $82
line 224
;224:	{
line 225
;225:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 226
;226:		return;
ADDRGP4 $81
JUMPV
LABELV $82
line 228
;227:	}
;228:	self->s.v.use = ( func_t ) SUB_UseTargets;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 SUB_UseTargets
CVPU4 4
CVUI4 4
ASGNI4
line 229
;229:}
LABELV $81
endproc SP_trigger_relay 4 4
export SP_trigger_secret
proc SP_trigger_secret 4 4
line 243
;230:
;231://=============================================================================
;232:
;233:/*QUAKED trigger_secret (.5 .5 .5) ?
;234:secret counter trigger
;235:sounds
;236:1) secret
;237:2) beep beep
;238:3)
;239:4)
;240:set "message" to text string
;241:*/
;242:void SP_trigger_secret(  )
;243:{
line 244
;244:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $85
line 245
;245:	{
line 246
;246:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 247
;247:		return;
ADDRGP4 $84
JUMPV
LABELV $85
line 249
;248:	}
;249:	g_globalvars.total_secrets = g_globalvars.total_secrets + 1;
ADDRGP4 g_globalvars+148
ADDRGP4 g_globalvars+148
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 250
;250:	self->wait = -1;
ADDRGP4 self
INDIRP4
CNSTI4 660
ADDP4
CNSTF4 3212836864
ASGNF4
line 251
;251:	if ( !self->s.v.message )
ADDRGP4 self
INDIRP4
CNSTI4 496
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $89
line 252
;252:		self->s.v.message = "You found a secret area!";
ADDRGP4 self
INDIRP4
CNSTI4 496
ADDP4
ADDRGP4 $91
ASGNP4
LABELV $89
line 253
;253:	if ( !self->s.v.sounds )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 0
NEF4 $92
line 254
;254:		self->s.v.sounds = 1;
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $92
line 256
;255:
;256:	if ( self->s.v.sounds == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $94
line 257
;257:	{
line 258
;258:		trap_precache_sound( "misc/secret.wav" );
ADDRGP4 $62
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 259
;259:		self->s.v.noise = "misc/secret.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $62
ASGNP4
line 260
;260:	} else if ( self->s.v.sounds == 2 )
ADDRGP4 $95
JUMPV
LABELV $94
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $96
line 261
;261:	{
line 262
;262:		trap_precache_sound( "misc/talk.wav" );
ADDRGP4 $65
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 263
;263:		self->s.v.noise = "misc/talk.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $65
ASGNP4
line 264
;264:	}
LABELV $96
LABELV $95
line 266
;265:
;266:	SP_trigger_multiple(  );
ADDRGP4 SP_trigger_multiple
CALLV
pop
line 267
;267:}
LABELV $84
endproc SP_trigger_secret 4 4
export counter_use
proc counter_use 12 8
line 272
;268:
;269://=============================================================================
;270:
;271:void counter_use(  )
;272:{
line 273
;273:	self->count = self->count - 1;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 684
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 274
;274:	if ( self->count < 0 )
ADDRGP4 self
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
CNSTF4 0
GEF4 $99
line 275
;275:		return;
ADDRGP4 $98
JUMPV
LABELV $99
line 277
;276:
;277:	if ( self->count != 0 )
ADDRGP4 self
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
CNSTF4 0
EQF4 $101
line 278
;278:	{
line 279
;279:		if ( streq( activator->s.v.classname, "player" )
ADDRGP4 activator
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $26
ARGP4
ADDRLP4 4
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $98
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
ADDRLP4 8
INDIRI4
NEI4 $98
line 281
;280:		     && ( ( int ) ( self->s.v.spawnflags ) & SPAWNFLAG_NOMESSAGE ) == 0 )
;281:		{
line 282
;282:			if ( self->count >= 4 )
ADDRGP4 self
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
CNSTF4 1082130432
LTF4 $105
line 283
;283:				G_centerprint( activator, "There are more to go..." );
ADDRGP4 activator
INDIRP4
ARGP4
ADDRGP4 $107
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
ADDRGP4 $98
JUMPV
LABELV $105
line 284
;284:			else if ( self->count == 3 )
ADDRGP4 self
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $108
line 285
;285:				G_centerprint( activator, "Only 3 more to go..." );
ADDRGP4 activator
INDIRP4
ARGP4
ADDRGP4 $110
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
ADDRGP4 $98
JUMPV
LABELV $108
line 286
;286:			else if ( self->count == 2 )
ADDRGP4 self
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $111
line 287
;287:				G_centerprint( activator, "Only 2 more to go..." );
ADDRGP4 activator
INDIRP4
ARGP4
ADDRGP4 $113
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
ADDRGP4 $98
JUMPV
LABELV $111
line 289
;288:			else
;289:				G_centerprint( activator, "Only 1 more to go..." );
ADDRGP4 activator
INDIRP4
ARGP4
ADDRGP4 $114
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 290
;290:		}
line 291
;291:		return;
ADDRGP4 $98
JUMPV
LABELV $101
line 294
;292:	}
;293:
;294:	if ( streq( activator->s.v.classname, "player" )
ADDRGP4 activator
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $26
ARGP4
ADDRLP4 4
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $115
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
ADDRLP4 8
INDIRI4
NEI4 $115
line 296
;295:	     && ( ( int ) ( self->s.v.spawnflags ) & SPAWNFLAG_NOMESSAGE ) == 0 )
;296:		G_centerprint( activator, "Sequence completed!" );
ADDRGP4 activator
INDIRP4
ARGP4
ADDRGP4 $117
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
LABELV $115
line 297
;297:	self->s.v.enemy = EDICT_TO_PROG( activator );
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
line 298
;298:	multi_trigger(  );
ADDRGP4 multi_trigger
CALLV
pop
line 299
;299:}
LABELV $98
endproc counter_use 12 8
export SP_trigger_counter
proc SP_trigger_counter 4 4
line 309
;300:
;301:/*QUAKED trigger_counter (.5 .5 .5) ? nomessage
;302:Acts as an intermediary for an action that takes multiple inputs.
;303:
;304:If nomessage is not set, t will print "1 more.. " etc when triggered and "sequence complete" when finished.
;305:
;306:After the counter has been triggered "count" g_globalvars.times (default 2), it will fire all of it's targets and remove itself.
;307:*/
;308:void SP_trigger_counter(  )
;309:{
line 310
;310:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $119
line 311
;311:	{
line 312
;312:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 313
;313:		return;
ADDRGP4 $118
JUMPV
LABELV $119
line 315
;314:	}
;315:	self->wait = -1;
ADDRGP4 self
INDIRP4
CNSTI4 660
ADDP4
CNSTF4 3212836864
ASGNF4
line 316
;316:	if ( !self->count )
ADDRGP4 self
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
CNSTF4 0
NEF4 $121
line 317
;317:		self->count = 2;
ADDRGP4 self
INDIRP4
CNSTI4 684
ADDP4
CNSTF4 1073741824
ASGNF4
LABELV $121
line 319
;318:
;319:	self->s.v.use = ( func_t ) counter_use;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 counter_use
CVPU4 4
CVUI4 4
ASGNI4
line 320
;320:}
LABELV $118
endproc SP_trigger_counter 4 4
export play_teleport
proc play_teleport 16 20
line 334
;321:
;322:/*
;323:==============================================================================
;324:
;325:TELEPORT TRIGGERS
;326:
;327:==============================================================================
;328:*/
;329:
;330:#define PLAYER_ONLY  1
;331:#define SILENT  2
;332:
;333:void play_teleport(  )
;334:{
line 338
;335:	float   v;
;336:	char   *tmpstr;
;337:
;338:	v = g_random(  ) * 5;
ADDRLP4 8
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
CNSTF4 1084227584
ADDRLP4 8
INDIRF4
MULF4
ASGNF4
line 339
;339:	if ( v < 1 )
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
GEF4 $124
line 340
;340:		tmpstr = "misc/r_tele1.wav";
ADDRLP4 4
ADDRGP4 $126
ASGNP4
ADDRGP4 $125
JUMPV
LABELV $124
line 341
;341:	else if ( v < 2 )
ADDRLP4 0
INDIRF4
CNSTF4 1073741824
GEF4 $127
line 342
;342:		tmpstr = "misc/r_tele2.wav";
ADDRLP4 4
ADDRGP4 $129
ASGNP4
ADDRGP4 $128
JUMPV
LABELV $127
line 343
;343:	else if ( v < 3 )
ADDRLP4 0
INDIRF4
CNSTF4 1077936128
GEF4 $130
line 344
;344:		tmpstr = "misc/r_tele3.wav";
ADDRLP4 4
ADDRGP4 $132
ASGNP4
ADDRGP4 $131
JUMPV
LABELV $130
line 345
;345:	else if ( v < 4 )
ADDRLP4 0
INDIRF4
CNSTF4 1082130432
GEF4 $133
line 346
;346:		tmpstr = "misc/r_tele4.wav";
ADDRLP4 4
ADDRGP4 $135
ASGNP4
ADDRGP4 $134
JUMPV
LABELV $133
line 348
;347:	else
;348:		tmpstr = "misc/r_tele5.wav";
ADDRLP4 4
ADDRGP4 $136
ASGNP4
LABELV $134
LABELV $131
LABELV $128
LABELV $125
line 350
;349:
;350:	sound( self, CHAN_VOICE, tmpstr, 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 4
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
line 351
;351:	ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 352
;352:}
LABELV $123
endproc play_teleport 16 20
export spawn_tfog
proc spawn_tfog 12 16
line 355
;353:
;354:void spawn_tfog( vec3_t org )
;355:{
line 356
;356:	s = spawn(  );
ADDRLP4 0
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 s
ADDRLP4 0
INDIRP4
ASGNP4
line 357
;357:	VectorCopy( org, s->s.v.origin );
ADDRGP4 s
INDIRP4
CNSTI4 156
ADDP4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
ADDRGP4 s
INDIRP4
CNSTI4 160
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
ADDRGP4 s
INDIRP4
CNSTI4 164
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 359
;358:// s->s.v.origin = org;
;359:	s->s.v.nextthink = g_globalvars.time + 0.2;
ADDRGP4 s
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 360
;360:	s->s.v.think = ( func_t ) play_teleport;
ADDRGP4 s
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 play_teleport
CVPU4 4
CVUI4 4
ASGNI4
line 362
;361:
;362:	trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 363
;363:	trap_WriteByte( MSG_MULTICAST, TE_TELEPORT );
CNSTI4 4
ARGI4
CNSTI4 11
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 364
;364:	trap_WriteCoord( MSG_MULTICAST, org[0] );
CNSTI4 4
ARGI4
ADDRFP4 0
INDIRP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 365
;365:	trap_WriteCoord( MSG_MULTICAST, org[1] );
ADDRLP4 4
CNSTI4 4
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 366
;366:	trap_WriteCoord( MSG_MULTICAST, org[2] );
CNSTI4 4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 367
;367:	trap_multicast( PASSVEC3( org ), MULTICAST_PHS );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 368
;368:}
LABELV $137
endproc spawn_tfog 12 16
export tdeath_touch
proc tdeath_touch 12 16
line 372
;369:
;370:
;371:void tdeath_touch(  )
;372:{
line 375
;373://      gedict_t *spot;
;374:
;375:	if ( other == PROG_TO_EDICT( self->s.v.owner ) )
ADDRGP4 other
INDIRP4
CVPU4 4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
NEU4 $140
line 376
;376:		return;
ADDRGP4 $139
JUMPV
LABELV $140
line 378
;377:
;378:	if ( streq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $26
ARGP4
ADDRLP4 0
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $142
line 379
;379:	{
line 380
;380:		if ( other->invincible_finished > g_globalvars.time )
ADDRGP4 other
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $144
line 381
;381:		{
line 382
;382:			self->s.v.classname = "teledeath2";
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $147
ASGNP4
line 383
;383:		}
LABELV $144
line 384
;384:		if ( strneq( PROG_TO_EDICT( self->s.v.owner )->s.v.classname, "player" ) )
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+104
ADDP4
INDIRP4
ARGP4
ADDRGP4 $26
ARGP4
ADDRLP4 4
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $148
line 385
;385:		{
line 386
;386:			T_Damage( PROG_TO_EDICT( self->s.v.owner ), self, self, 5000 );
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
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 1167867904
ARGF4
ADDRGP4 T_Damage
CALLV
pop
line 387
;387:			return;
ADDRGP4 $139
JUMPV
LABELV $148
line 389
;388:		}
;389:	}
LABELV $142
line 390
;390:	if ( other->s.v.health )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
EQF4 $152
line 391
;391:	{
line 392
;392:		T_Damage( other, self, self, 5000 );
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1167867904
ARGF4
ADDRGP4 T_Damage
CALLV
pop
line 393
;393:	}
LABELV $152
line 395
;394:
;395:	if ( other->s.v.think == ( func_t ) TeamFortress_DetpackExplode )
ADDRGP4 other
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ADDRGP4 TeamFortress_DetpackExplode
CVPU4 4
CVUI4 4
NEI4 $154
line 396
;396:	{
line 397
;397:		other->s.v.solid = SOLID_NOT;
ADDRGP4 other
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 398
;398:		other->s.v.nextthink = g_globalvars.time + 1 + g_random(  ) * 2;
ADDRLP4 4
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 other
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
CNSTF4 1073741824
ADDRLP4 4
INDIRF4
MULF4
ADDF4
ASGNF4
line 399
;399:		dremove( other->oldenemy );
ADDRGP4 other
INDIRP4
CNSTI4 980
ADDP4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 400
;400:		G_bprint( 1, "%s's detpack was telefragged by %s\n",
CNSTI4 1
ARGI4
ADDRGP4 $157
ARGP4
ADDRGP4 other
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+284
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 402
;401:			  other->real_owner->s.v.netname, PROG_TO_EDICT( self->s.v.owner )->s.v.netname );
;402:	}
LABELV $154
line 403
;403:}
LABELV $139
endproc tdeath_touch 12 16
export spawn_tdeath
proc spawn_tdeath 20 28
line 406
;404:
;405:void spawn_tdeath( vec3_t org, gedict_t * death_owner )
;406:{
line 409
;407:	gedict_t *death;
;408:
;409:	death = spawn(  );
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 410
;410:	death->s.v.classname = "teledeath";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $161
ASGNP4
line 411
;411:	death->s.v.movetype = MOVETYPE_NONE;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 412
;412:	death->s.v.solid = SOLID_TRIGGER;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 413
;413:	SetVector( death->s.v.angles, 0, 0, 0 );
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
line 414
;414:	setsize( death, death_owner->s.v.mins[0] - 4, death_owner->s.v.mins[1] - 4,
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 1082130432
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 418
;415:		 death_owner->s.v.mins[2] - 4, death_owner->s.v.maxs[0] + 4,
;416:		 death_owner->s.v.maxs[1] + 4, death_owner->s.v.maxs[2] + 4 );
;417:
;418:	setorigin( death, PASSVEC3( org ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 420
;419:
;420:	death->s.v.touch = ( func_t ) tdeath_touch;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 tdeath_touch
CVPU4 4
CVUI4 4
ASGNI4
line 421
;421:	death->s.v.nextthink = g_globalvars.time + 0.2;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 422
;422:	death->s.v.think = ( func_t ) SUB_Remove;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 423
;423:	death->s.v.owner = EDICT_TO_PROG( death_owner );
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 425
;424:
;425:	g_globalvars.force_retouch = 2;	// make sure even still objects get hit
ADDRGP4 g_globalvars+136
CNSTF4 1073741824
ASGNF4
line 426
;426:}
LABELV $160
endproc spawn_tdeath 20 28
export teleport_touch
proc teleport_touch 52 20
line 429
;427:
;428:void teleport_touch(  )
;429:{
line 433
;430:	gedict_t *t, *te;
;431:	vec3_t  org;
;432:
;433:	if ( self->s.v.targetname )
ADDRGP4 self
INDIRP4
CNSTI4 464
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $165
line 434
;434:	{
line 435
;435:		if ( self->s.v.nextthink < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $167
line 436
;436:		{
line 437
;437:			return;	// not fired yet
ADDRGP4 $164
JUMPV
LABELV $167
line 439
;438:		}
;439:	}
LABELV $165
line 440
;440:	if ( ( int ) ( self->s.v.spawnflags ) & PLAYER_ONLY )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $170
line 441
;441:	{
line 442
;442:		if ( strneq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $26
ARGP4
ADDRLP4 20
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $172
line 443
;443:			return;
ADDRGP4 $164
JUMPV
LABELV $172
line 444
;444:	}
LABELV $170
line 445
;445:	if ( !Activated( self, other ) )
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Activated
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $174
line 446
;446:	{
line 447
;447:		if ( self->else_goal )
ADDRGP4 self
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $164
line 448
;448:		{
line 449
;449:			te = Findgoal( self->else_goal );
ADDRGP4 self
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 Findgoal
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 24
INDIRP4
ASGNP4
line 450
;450:			if ( te )
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $164
line 451
;451:				AttemptToActivate( te, other, self );
ADDRLP4 16
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
line 452
;452:		}
line 453
;453:		return;
ADDRGP4 $164
JUMPV
LABELV $174
line 456
;454:	}
;455:// only teleport living creatures
;456:	if ( other->s.v.health <= 0 || other->s.v.solid != SOLID_SLIDEBOX )
ADDRLP4 24
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $182
ADDRLP4 24
INDIRP4
CNSTI4 152
ADDP4
INDIRF4
CNSTF4 1077936128
EQF4 $180
LABELV $182
line 457
;457:		return;
ADDRGP4 $164
JUMPV
LABELV $180
line 460
;458:
;459://        activator = other;
;460:	SUB_UseTargets(  );
ADDRGP4 SUB_UseTargets
CALLV
pop
line 463
;461:
;462:	//put a tfog where the player was
;463:	spawn_tfog( other->s.v.origin );
ADDRGP4 other
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRGP4 spawn_tfog
CALLV
pop
line 465
;464:
;465:	t = trap_find( world, FOFS( s.v.targetname ), self->s.v.target );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 464
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 460
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 466
;466:	if ( !t )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $183
line 467
;467:		G_Error( "couldn't find target" );
ADDRGP4 $185
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $183
line 470
;468:
;469:// spawn a tfog flash in front of the destination
;470:	makevectors( t->mangle );
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 471
;471:	org[0] = t->s.v.origin[0] + 32 * g_globalvars.v_forward[0];
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
CNSTF4 1107296256
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
ADDF4
ASGNF4
line 472
;472:	org[1] = t->s.v.origin[1] + 32 * g_globalvars.v_forward[1];
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
CNSTF4 1107296256
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 473
;473:	org[2] = t->s.v.origin[2] + 32 * g_globalvars.v_forward[2];
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1107296256
ADDRGP4 g_globalvars+228+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 475
;474:
;475:	spawn_tfog( org );
ADDRLP4 4
ARGP4
ADDRGP4 spawn_tfog
CALLV
pop
line 476
;476:	spawn_tdeath( t->s.v.origin, other );
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 spawn_tdeath
CALLV
pop
line 479
;477:
;478:// move the player and lock him down for a little while
;479:	if ( !other->s.v.health )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
NEF4 $193
line 480
;480:	{
line 481
;481:		VectorCopy( t->s.v.origin, other->s.v.origin );
ADDRLP4 32
CNSTI4 156
ASGNI4
ADDRGP4 other
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
CNSTI4 160
ASGNI4
ADDRGP4 other
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
ADDRLP4 40
CNSTI4 164
ASGNI4
ADDRGP4 other
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 482
;482:		other->s.v.velocity[0] =
ADDRLP4 32
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRGP4 g_globalvars+228
INDIRF4
ADDRLP4 36
INDIRP4
INDIRF4
MULF4
ADDRGP4 g_globalvars+228
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 485
;483:		    ( g_globalvars.v_forward[0] * other->s.v.velocity[0] ) +
;484:		    ( g_globalvars.v_forward[0] * other->s.v.velocity[1] );
;485:		other->s.v.velocity[1] =
ADDRLP4 40
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 44
ADDRLP4 40
INDIRP4
CNSTI4 184
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRGP4 g_globalvars+228+4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
MULF4
ADDRGP4 g_globalvars+228+4
INDIRF4
ADDRLP4 44
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 488
;486:		    ( g_globalvars.v_forward[1] * other->s.v.velocity[0] ) +
;487:		    ( g_globalvars.v_forward[1] * other->s.v.velocity[1] );
;488:		other->s.v.velocity[2] =
ADDRLP4 48
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 188
ADDP4
ADDRGP4 g_globalvars+228+8
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
MULF4
ADDRGP4 g_globalvars+228+8
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 493
;489:		    ( g_globalvars.v_forward[2] * other->s.v.velocity[0] ) +
;490:		    ( g_globalvars.v_forward[2] * other->s.v.velocity[1] );
;491:
;492:		//other->s.v.velocity = (v_forward * other->s.v.velocity[0]) + (v_forward * other->s.v.velocity[1]);
;493:		return;
ADDRGP4 $164
JUMPV
LABELV $193
line 495
;494:	}
;495:	setorigin( other, PASSVEC3( t->s.v.origin ) );
ADDRGP4 other
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
line 496
;496:	VectorCopy( t->mangle, other->s.v.angles );
ADDRGP4 other
INDIRP4
CNSTI4 192
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRF4
ASGNF4
ADDRGP4 other
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRF4
ASGNF4
ADDRGP4 other
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 644
ADDP4
INDIRF4
ASGNF4
line 498
;497:// other.angles = t.mangle;
;498:	if ( streq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $26
ARGP4
ADDRLP4 36
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $205
line 499
;499:	{
line 500
;500:		if ( other->s.v.weapon == 1 && other->hook_out )
ADDRLP4 40
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $207
ADDRLP4 40
INDIRP4
CNSTI4 1436
ADDP4
INDIRI4
CNSTI4 0
EQI4 $207
line 501
;501:		{
line 502
;502:			sound( other, 1, "weapons/bounce2.wav", 1, 1 );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $209
ARGP4
ADDRLP4 44
CNSTF4 1065353216
ASGNF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 503
;503:			other->on_hook = 0;
ADDRGP4 other
INDIRP4
CNSTI4 1444
ADDP4
CNSTI4 0
ASGNI4
line 504
;504:			other->hook_out = 0;
ADDRGP4 other
INDIRP4
CNSTI4 1436
ADDP4
CNSTI4 0
ASGNI4
line 505
;505:			other->fire_held_down = 0;
ADDRGP4 other
INDIRP4
CNSTI4 1448
ADDP4
CNSTI4 0
ASGNI4
line 506
;506:			other->s.v.weaponframe = 0;
ADDRGP4 other
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 507
;507:			other->attack_finished = g_globalvars.time + 0.75;
ADDRGP4 other
INDIRP4
CNSTI4 724
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1061158912
ADDF4
ASGNF4
line 508
;508:		}
LABELV $207
line 509
;509:		other->s.v.fixangle = 1;	// turn this way immediately
ADDRGP4 other
INDIRP4
CNSTI4 380
ADDP4
CNSTF4 1065353216
ASGNF4
line 510
;510:		other->s.v.teleport_time = g_globalvars.time + 0.7;
ADDRGP4 other
INDIRP4
CNSTI4 420
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1060320051
ADDF4
ASGNF4
line 511
;511:		if ( ( int ) other->s.v.flags & FL_ONGROUND )
ADDRGP4 other
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $212
line 512
;512:			other->s.v.flags = other->s.v.flags - FL_ONGROUND;
ADDRLP4 44
ADDRGP4 other
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
CNSTF4 1140850688
SUBF4
ASGNF4
LABELV $212
line 513
;513:		VectorScale( g_globalvars.v_forward, 300, other->s.v.velocity );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1133903872
ARGF4
ADDRGP4 other
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 515
;514://  other->s.v.velocity = v_forward * 300;
;515:	}
LABELV $205
line 516
;516:	other->s.v.flags -= ( int ) other->s.v.flags & FL_ONGROUND;
ADDRLP4 40
ADDRGP4 other
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 44
ADDRLP4 40
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 40
INDIRP4
ADDRLP4 44
INDIRF4
ADDRLP4 44
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
CVIF4 4
SUBF4
ASGNF4
line 517
;517:}
LABELV $164
endproc teleport_touch 52 20
export SP_info_teleport_destination
proc SP_info_teleport_destination 16 4
line 523
;518:
;519:/*QUAKED info_teleport_destination (.5 .5 .5) (-8 -8 -8) (8 8 32)
;520:This is the destination marker for a teleporter.  It should have a "targetname" field with the same value as a teleporter's "target" field.
;521:*/
;522:void SP_info_teleport_destination(  )
;523:{
line 524
;524:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $216
line 525
;525:	{
line 526
;526:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 527
;527:		return;
ADDRGP4 $215
JUMPV
LABELV $216
line 530
;528:	}
;529:// this does nothing, just serves as a target spot
;530:	VectorCopy( self->s.v.angles, self->mangle );
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
line 532
;531:// self.mangle = self.angles;
;532:	SetVector( self->s.v.angles, 0, 0, 0 );
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
line 533
;533:	self->s.v.model = "";
ADDRGP4 self
INDIRP4
CNSTI4 220
ADDP4
ADDRGP4 $218
ASGNP4
line 534
;534:	self->s.v.origin[2] += 27;
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
CNSTF4 1104674816
ADDF4
ASGNF4
line 535
;535:	if ( !self->s.v.targetname )
ADDRGP4 self
INDIRP4
CNSTI4 464
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $219
line 536
;536:		G_Error( "no targetname" );
ADDRGP4 $221
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $219
line 537
;537:}
LABELV $215
endproc SP_info_teleport_destination 16 4
export teleport_use
proc teleport_use 0 0
line 540
;538:
;539:void teleport_use(  )
;540:{
line 541
;541:	self->s.v.nextthink = g_globalvars.time + 0.2;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 542
;542:	g_globalvars.force_retouch = 2;	// make sure even still objects get hit
ADDRGP4 g_globalvars+136
CNSTF4 1073741824
ASGNF4
line 543
;543:	self->s.v.think = ( func_t ) SUB_Null;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Null
CVPU4 4
CVUI4 4
ASGNI4
line 544
;544:}
LABELV $222
endproc teleport_use 0 0
export SP_trigger_teleport
proc SP_trigger_teleport 28 24
line 552
;545:
;546:/*QUAKED trigger_teleport (.5 .5 .5) ? PLAYER_ONLY SILENT
;547:Any object touching this will be transported to the corresponding info_teleport_destination entity. You must set the "target" field, and create an object with a "targetname" field that matches.
;548:
;549:If the trigger_teleport has a targetname, it will only teleport entities when it has been fired.
;550:*/
;551:void SP_trigger_teleport(  )
;552:{
line 555
;553:	vec3_t  o;
;554:
;555:	if ( !CheckExistence(  ) )
ADDRLP4 12
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $226
line 556
;556:	{
line 557
;557:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 558
;558:		return;
ADDRGP4 $225
JUMPV
LABELV $226
line 560
;559:	}
;560:	InitTrigger(  );
ADDRGP4 InitTrigger
CALLV
pop
line 561
;561:	self->s.v.touch = ( func_t ) teleport_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 teleport_touch
CVPU4 4
CVUI4 4
ASGNI4
line 563
;562:	// find the destination 
;563:	if ( !self->s.v.target )
ADDRGP4 self
INDIRP4
CNSTI4 460
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $228
line 564
;564:		G_Error( "no target" );
ADDRGP4 $230
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $228
line 565
;565:	self->s.v.use = ( func_t ) teleport_use;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 teleport_use
CVPU4 4
CVUI4 4
ASGNI4
line 567
;566:
;567:	if ( !( ( int ) ( self->s.v.spawnflags ) & SILENT ) )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $231
line 568
;568:	{
line 569
;569:		trap_precache_sound( "ambience/hum1.wav" );
ADDRGP4 $233
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 570
;570:		VectorAdd( self->s.v.mins, self->s.v.maxs, o );
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 20
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 24
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
ADDF4
ASGNF4
line 571
;571:		VectorScale( o, 0.5, o );
ADDRLP4 0
ARGP4
CNSTF4 1056964608
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 573
;572:		//o = (self.mins + self.maxs)*0.5;
;573:		trap_ambientsound( PASSVEC3( o ), "ambience/hum1.wav", 0.5, ATTN_STATIC );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRGP4 $233
ARGP4
CNSTF4 1056964608
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 574
;574:	}
LABELV $231
line 575
;575:}
LABELV $225
endproc SP_trigger_teleport 28 24
export SP_trigger_setskill
proc SP_trigger_setskill 0 4
line 590
;576:
;577:/*
;578:==============================================================================
;579:
;580:trigger_setskill
;581:
;582:==============================================================================
;583:*/
;584:
;585:/*QUAKED trigger_setskill (.5 .5 .5) ?
;586:sets skill level to the value of "message".
;587:Only used on start map.
;588:*/
;589:void SP_trigger_setskill(  )
;590:{
line 591
;591:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 592
;592:	return;
LABELV $238
endproc SP_trigger_setskill 0 4
export trigger_onlyregistered_touch
proc trigger_onlyregistered_touch 28 20
line 604
;593:}
;594:
;595:/*
;596:==============================================================================
;597:
;598:ONLY REGISTERED TRIGGERS
;599:
;600:==============================================================================
;601:*/
;602:
;603:void trigger_onlyregistered_touch(  )
;604:{
line 607
;605:	gedict_t *te;
;606:
;607:	if ( strneq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $26
ARGP4
ADDRLP4 4
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $240
line 608
;608:		return;
ADDRGP4 $239
JUMPV
LABELV $240
line 609
;609:	if ( !Activated( self, other ) )
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
NEI4 $242
line 610
;610:	{
line 611
;611:		if ( self->else_goal )
ADDRGP4 self
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $239
line 612
;612:		{
line 613
;613:			te = Findgoal( self->else_goal );
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
line 614
;614:			if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $239
line 615
;615:				AttemptToActivate( te, other, self );
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
line 616
;616:		}
line 617
;617:		return;
ADDRGP4 $239
JUMPV
LABELV $242
line 619
;618:	}
;619:	if ( self->attack_finished > g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $248
line 620
;620:		return;
ADDRGP4 $239
JUMPV
LABELV $248
line 622
;621:
;622:	self->attack_finished = g_globalvars.time + 2;
ADDRGP4 self
INDIRP4
CNSTI4 724
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 623
;623:	if ( trap_cvar( "registered" ) )
ADDRGP4 $254
ARGP4
ADDRLP4 12
ADDRGP4 trap_cvar
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
CNSTF4 0
EQF4 $252
line 624
;624:	{
line 625
;625:		self->s.v.message = "";
ADDRGP4 self
INDIRP4
CNSTI4 496
ADDP4
ADDRGP4 $218
ASGNP4
line 626
;626:		activator = other;
ADDRGP4 activator
ADDRGP4 other
INDIRP4
ASGNP4
line 627
;627:		SUB_UseTargets(  );
ADDRGP4 SUB_UseTargets
CALLV
pop
line 628
;628:		ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 629
;629:	} else
ADDRGP4 $253
JUMPV
LABELV $252
line 630
;630:	{
line 631
;631:		if ( self->s.v.message && strneq( self->s.v.message, "" ) )
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 496
ADDP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $255
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 $218
ARGP4
ADDRLP4 20
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $255
line 632
;632:		{
line 633
;633:			G_centerprint( other, self->s.v.message );
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
line 634
;634:			sound( other, CHAN_BODY, "misc/talk.wav", 1, ATTN_NORM );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $65
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
line 635
;635:		}
LABELV $255
line 636
;636:	}
LABELV $253
line 637
;637:}
LABELV $239
endproc trigger_onlyregistered_touch 28 20
export SP_trigger_onlyregistered
proc SP_trigger_onlyregistered 4 4
line 644
;638:
;639:
;640:/*QUAKED trigger_onlyregistered (.5 .5 .5) ?
;641:Only fires if playing the registered version, otherwise prints the message
;642:*/
;643:void SP_trigger_onlyregistered(  )
;644:{
line 645
;645:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $258
line 646
;646:	{
line 647
;647:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 648
;648:		return;
ADDRGP4 $257
JUMPV
LABELV $258
line 650
;649:	}
;650:	trap_precache_sound( "misc/talk.wav" );
ADDRGP4 $65
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 651
;651:	InitTrigger(  );
ADDRGP4 InitTrigger
CALLV
pop
line 652
;652:	self->s.v.touch = ( func_t ) trigger_onlyregistered_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 trigger_onlyregistered_touch
CVPU4 4
CVUI4 4
ASGNI4
line 653
;653:}
LABELV $257
endproc SP_trigger_onlyregistered 4 4
export hurt_on
proc hurt_on 0 0
line 657
;654:
;655://============================================================================
;656:void hurt_on(  )
;657:{
line 658
;658:	self->s.v.solid = SOLID_TRIGGER;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 659
;659:	self->s.v.nextthink = -1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
CNSTF4 3212836864
ASGNF4
line 660
;660:}
LABELV $260
endproc hurt_on 0 0
export hurt_touch
proc hurt_touch 12 24
line 663
;661:
;662:void hurt_touch(  )
;663:{
line 666
;664:	gedict_t *te;
;665:
;666:	if ( other->s.v.takedamage )
ADDRGP4 other
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
EQF4 $262
line 667
;667:	{
line 668
;668:		if ( !Activated( self, other ) )
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
NEI4 $264
line 669
;669:		{
line 670
;670:			if ( self->else_goal )
ADDRGP4 self
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $261
line 671
;671:			{
line 672
;672:				te = Findgoal( self->else_goal );
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
line 673
;673:				if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $261
line 674
;674:					AttemptToActivate( te, other, self );
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
line 675
;675:			}
line 676
;676:			return;
ADDRGP4 $261
JUMPV
LABELV $264
line 678
;677:		}
;678:		self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 679
;679:		tf_data.deathmsg = DMSG_TRIGGER;
ADDRGP4 tf_data+88
CNSTI4 36
ASGNI4
line 680
;680:		TF_T_Damage( other, self, self, self->dmg, 1, 0 );
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 681
;681:		self->s.v.think = ( func_t ) hurt_on;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 hurt_on
CVPU4 4
CVUI4 4
ASGNI4
line 682
;682:		self->s.v.nextthink = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 683
;683:	}
LABELV $262
line 684
;684:}
LABELV $261
endproc hurt_touch 12 24
export SP_trigger_hurt
proc SP_trigger_hurt 4 4
line 692
;685:
;686:/*QUAKED trigger_hurt (.5 .5 .5) ?
;687:Any object touching this will be hurt
;688:set dmg to damage amount
;689:defalt dmg = 5
;690:*/
;691:void SP_trigger_hurt(  )
;692:{
line 693
;693:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $273
line 694
;694:	{
line 695
;695:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 696
;696:		return;
ADDRGP4 $272
JUMPV
LABELV $273
line 698
;697:	}
;698:	InitTrigger(  );
ADDRGP4 InitTrigger
CALLV
pop
line 699
;699:	self->s.v.touch = ( func_t ) hurt_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 hurt_touch
CVPU4 4
CVUI4 4
ASGNI4
line 700
;700:	if ( !self->dmg )
ADDRGP4 self
INDIRP4
CNSTI4 716
ADDP4
INDIRF4
CNSTF4 0
NEF4 $275
line 701
;701:		self->dmg = 5;
ADDRGP4 self
INDIRP4
CNSTI4 716
ADDP4
CNSTF4 1084227584
ASGNF4
LABELV $275
line 702
;702:}
LABELV $272
endproc SP_trigger_hurt 4 4
export trigger_push_touch
proc trigger_push_touch 32 20
line 709
;703:
;704://============================================================================
;705:
;706:#define PUSH_ONCE  1
;707:
;708:void trigger_push_touch(  )
;709:{
line 712
;710:	gedict_t *te;
;711:
;712:	if ( !Activated( self, other ) )
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
NEI4 $278
line 713
;713:	{
line 714
;714:		if ( self->else_goal )
ADDRGP4 self
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $277
line 715
;715:		{
line 716
;716:			te = Findgoal( self->else_goal );
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
line 717
;717:			if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $277
line 718
;718:				AttemptToActivate( te, other, self );
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
line 719
;719:		}
line 720
;720:		return;
ADDRGP4 $277
JUMPV
LABELV $278
line 722
;721:	}
;722:	if ( streq( other->s.v.classname, "grenade" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $286
ARGP4
ADDRLP4 8
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $284
line 723
;723:	{
line 724
;724:		other->s.v.velocity[0] = self->speed * self->s.v.movedir[0] * 10;
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRGP4 other
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1092616192
ADDRLP4 12
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
MULF4
MULF4
ASGNF4
line 725
;725:		other->s.v.velocity[1] = self->speed * self->s.v.movedir[1] * 10;
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRGP4 other
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1092616192
ADDRLP4 16
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
MULF4
MULF4
ASGNF4
line 726
;726:		other->s.v.velocity[2] = self->speed * self->s.v.movedir[2] * 10;
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRGP4 other
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1092616192
ADDRLP4 20
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
MULF4
MULF4
ASGNF4
line 727
;727:	} else if ( other->s.v.health > 0 )
ADDRGP4 $285
JUMPV
LABELV $284
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $287
line 728
;728:	{
line 730
;729://  other->s.v.velocity = self->speed  * self->s.v.movedir * 10;
;730:		other->s.v.velocity[0] = self->speed * self->s.v.movedir[0] * 10;
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRGP4 other
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1092616192
ADDRLP4 12
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
MULF4
MULF4
ASGNF4
line 731
;731:		other->s.v.velocity[1] = self->speed * self->s.v.movedir[1] * 10;
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRGP4 other
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1092616192
ADDRLP4 16
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
MULF4
MULF4
ASGNF4
line 732
;732:		other->s.v.velocity[2] = self->speed * self->s.v.movedir[2] * 10;
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRGP4 other
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1092616192
ADDRLP4 20
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
MULF4
MULF4
ASGNF4
line 734
;733:
;734:		if ( streq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $26
ARGP4
ADDRLP4 24
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $289
line 735
;735:		{
line 736
;736:			if ( other->fly_sound < g_globalvars.time )
ADDRGP4 other
INDIRP4
CNSTI4 776
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $291
line 737
;737:			{
line 738
;738:				other->fly_sound = g_globalvars.time + 1.5;
ADDRGP4 other
INDIRP4
CNSTI4 776
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1069547520
ADDF4
ASGNF4
line 739
;739:				sound( other, CHAN_AUTO, "ambience/windfly.wav", 1, ATTN_NORM );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $295
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
line 740
;740:			}
LABELV $291
line 741
;741:		}
LABELV $289
line 742
;742:	}
LABELV $287
LABELV $285
line 743
;743:	if ( ( int ) ( self->s.v.spawnflags ) & PUSH_ONCE )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $296
line 744
;744:		ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
LABELV $296
line 745
;745:}
LABELV $277
endproc trigger_push_touch 32 20
export SP_trigger_push
proc SP_trigger_push 4 4
line 751
;746:
;747:/*QUAKED trigger_push (.5 .5 .5) ? PUSH_ONCE
;748:Pushes the player
;749:*/
;750:void SP_trigger_push(  )
;751:{
line 752
;752:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $299
line 753
;753:	{
line 754
;754:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 755
;755:		return;
ADDRGP4 $298
JUMPV
LABELV $299
line 757
;756:	}
;757:	InitTrigger(  );
ADDRGP4 InitTrigger
CALLV
pop
line 758
;758:	trap_precache_sound( "ambience/windfly.wav" );
ADDRGP4 $295
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 759
;759:	self->s.v.touch = ( func_t ) trigger_push_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 trigger_push_touch
CVPU4 4
CVUI4 4
ASGNI4
line 760
;760:	if ( !self->speed )
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
CNSTF4 0
NEF4 $301
line 761
;761:		self->speed = 1000;
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
CNSTF4 1148846080
ASGNF4
LABELV $301
line 762
;762:}
LABELV $298
endproc SP_trigger_push 4 4
export trigger_monsterjump_touch
proc trigger_monsterjump_touch 12 0
line 767
;763:
;764://============================================================================
;765:
;766:void trigger_monsterjump_touch(  )
;767:{
line 768
;768:	if ( ( ( int ) other->s.v.flags & ( FL_MONSTER | FL_FLY | FL_SWIM ) ) != FL_MONSTER )
ADDRGP4 other
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 35
BANDI4
CNSTI4 32
EQI4 $304
line 769
;769:		return;
ADDRGP4 $303
JUMPV
LABELV $304
line 772
;770:
;771:// set XY even if not on ground, so the jump will clear lips
;772:	other->s.v.velocity[0] = self->s.v.movedir[0] * self->speed;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRGP4 other
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
MULF4
ASGNF4
line 773
;773:	other->s.v.velocity[1] = self->s.v.movedir[1] * self->speed;
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRGP4 other
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
MULF4
ASGNF4
line 775
;774:
;775:	if ( !( ( int ) other->s.v.flags & FL_ONGROUND ) )
ADDRGP4 other
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $306
line 776
;776:		return;
ADDRGP4 $303
JUMPV
LABELV $306
line 778
;777:
;778:	other->s.v.flags = other->s.v.flags - FL_ONGROUND;
ADDRLP4 8
ADDRGP4 other
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1140850688
SUBF4
ASGNF4
line 780
;779:
;780:	other->s.v.velocity[2] = self->height;
ADDRGP4 other
INDIRP4
CNSTI4 188
ADDP4
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
INDIRF4
ASGNF4
line 781
;781:}
LABELV $303
endproc trigger_monsterjump_touch 12 0
export SP_trigger_monsterjump
proc SP_trigger_monsterjump 12 16
line 789
;782:
;783:/*QUAKED trigger_monsterjump (.5 .5 .5) ?
;784:Walking monsters that touch this will jump in the direction of the trigger's angle
;785:"speed" default to 200, the speed thrown forward
;786:"height" default to 200, the speed thrown upwards
;787:*/
;788:void SP_trigger_monsterjump(  )
;789:{
line 790
;790:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $309
line 791
;791:	{
line 792
;792:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 793
;793:		return;
ADDRGP4 $308
JUMPV
LABELV $309
line 795
;794:	}
;795:	if ( !self->speed )
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
CNSTF4 0
NEF4 $311
line 796
;796:		self->speed = 200;
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
CNSTF4 1128792064
ASGNF4
LABELV $311
line 798
;797:
;798:	if ( !self->height )
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
INDIRF4
CNSTF4 0
NEF4 $313
line 799
;799:		self->height = 200;
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
CNSTF4 1128792064
ASGNF4
LABELV $313
line 801
;800:
;801:	if ( VectorCompareF( self->s.v.angles, 0, 0, 0 ) )
ADDRGP4 self
INDIRP4
CNSTI4 192
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
EQI4 $315
line 802
;802:		SetVector( self->s.v.angles, 0, 360, 0 );
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
CNSTF4 1135869952
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 0
ASGNF4
LABELV $315
line 803
;803:	InitTrigger(  );
ADDRGP4 InitTrigger
CALLV
pop
line 804
;804:	self->s.v.touch = ( func_t ) trigger_monsterjump_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 trigger_monsterjump_touch
CVPU4 4
CVUI4 4
ASGNI4
line 805
;805:}
LABELV $308
endproc SP_trigger_monsterjump 12 16
bss
export old
align 4
LABELV old
skip 4
export s
align 4
LABELV s
skip 4
export otemp
align 4
LABELV otemp
skip 4
export stemp
align 4
LABELV stemp
skip 4
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
LABELV $295
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 119
byte 1 105
byte 1 110
byte 1 100
byte 1 102
byte 1 108
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $286
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $254
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $233
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 104
byte 1 117
byte 1 109
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $230
byte 1 110
byte 1 111
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $221
byte 1 110
byte 1 111
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $218
byte 1 0
align 1
LABELV $209
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
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $185
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $161
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $157
byte 1 37
byte 1 115
byte 1 39
byte 1 115
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
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $147
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 50
byte 1 0
align 1
LABELV $136
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 53
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $135
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 52
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $132
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $129
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $126
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $117
byte 1 83
byte 1 101
byte 1 113
byte 1 117
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 100
byte 1 33
byte 1 0
align 1
LABELV $114
byte 1 79
byte 1 110
byte 1 108
byte 1 121
byte 1 32
byte 1 49
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 103
byte 1 111
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $113
byte 1 79
byte 1 110
byte 1 108
byte 1 121
byte 1 32
byte 1 50
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 103
byte 1 111
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $110
byte 1 79
byte 1 110
byte 1 108
byte 1 121
byte 1 32
byte 1 51
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 103
byte 1 111
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $107
byte 1 84
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 103
byte 1 111
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $91
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
byte 1 115
byte 1 101
byte 1 99
byte 1 114
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 33
byte 1 0
align 1
LABELV $75
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 111
byte 1 117
byte 1 99
byte 1 104
byte 1 32
byte 1 100
byte 1 111
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 109
byte 1 97
byte 1 107
byte 1 101
byte 1 32
byte 1 115
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $68
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $65
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
LABELV $62
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 115
byte 1 101
byte 1 99
byte 1 114
byte 1 101
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $26
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $21
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 115
byte 1 101
byte 1 99
byte 1 114
byte 1 101
byte 1 116
byte 1 0
