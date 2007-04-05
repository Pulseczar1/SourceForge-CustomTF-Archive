export SetMovedir
code
proc SetMovedir 16 16
file "..\src\subs.c"
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
;21: *  $Id: subs.c,v 1.7 2005/05/16 06:31:38 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:
;26:/*
;27:QuakeEd only writes a single float for angles (bad idea), so up and down are
;28:just constant angles.
;29:*/
;30:void SetMovedir(  )
;31:{
line 32
;32:	if ( VectorCompareF( self->s.v.angles, 0, -1, 0 ) )
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 3212836864
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
EQI4 $12
line 33
;33:		SetVector( self->s.v.movedir, 0, 0, 1 );
ADDRGP4 self
INDIRP4
CNSTI4 484
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 488
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 492
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRGP4 $13
JUMPV
LABELV $12
line 34
;34:	else if ( VectorCompareF( self->s.v.angles, 0, -2, 0 ) )
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 3221225472
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 VectorCompareF
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $14
line 35
;35:		SetVector( self->s.v.movedir, 0, 0, -1 );
ADDRGP4 self
INDIRP4
CNSTI4 484
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 488
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 492
ADDP4
CNSTF4 3212836864
ASGNF4
ADDRGP4 $15
JUMPV
LABELV $14
line 37
;36:	else
;37:	{
line 38
;38:		makevectors( self->s.v.angles );
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 39
;39:		VectorCopy( g_globalvars.v_forward, self->s.v.movedir );
ADDRGP4 self
INDIRP4
CNSTI4 484
ADDP4
ADDRGP4 g_globalvars+228
INDIRF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 488
ADDP4
ADDRGP4 g_globalvars+228+4
INDIRF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 492
ADDP4
ADDRGP4 g_globalvars+228+8
INDIRF4
ASGNF4
line 40
;40:	}
LABELV $15
LABELV $13
line 41
;41:	SetVector( self->s.v.angles, 0, 0, 0 );
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
line 42
;42:}
LABELV $11
endproc SetMovedir 16 16
export InitTrigger
proc InitTrigger 12 16
line 51
;43:
;44:/*
;45:================
;46:InitTrigger
;47:================
;48:*/
;49:
;50:void InitTrigger(  )
;51:{
line 54
;52:// trigger angles are used for one-way touches.  An angle of 0 is assumed
;53:// to mean no restrictions, so use a yaw of 360 instead.
;54:	if ( !VectorCompareF( self->s.v.angles, 0, 0, 0 ) )
ADDRGP4 self
INDIRP4
CNSTI4 192
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
NEI4 $22
line 55
;55:		SetMovedir( );
ADDRGP4 SetMovedir
CALLV
pop
LABELV $22
line 56
;56:	self->s.v.solid = SOLID_TRIGGER;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 57
;57:	setmodel( self, self->s.v.model );	// set size and link into world
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
line 58
;58:	self->s.v.movetype = MOVETYPE_NONE;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 59
;59:	self->s.v.modelindex = 0;
ADDRGP4 self
INDIRP4
CNSTI4 112
ADDP4
CNSTF4 0
ASGNF4
line 60
;60:	self->s.v.model = "";
ADDRGP4 self
INDIRP4
CNSTI4 220
ADDP4
ADDRGP4 $24
ASGNP4
line 61
;61:}
LABELV $21
endproc InitTrigger 12 16
export SUB_CalcMoveEnt
proc SUB_CalcMoveEnt 4 12
line 75
;62:
;63:/*
;64:=============
;65:SUB_CalcMove
;66:
;67:calculate self.velocity and self.nextthink to reach dest from
;68:self.origin traveling at speed
;69:===============
;70:*/
;71:void    SUB_CalcMoveDone(  );
;72:void    SUB_CalcMove( vec3_t tdest, float tspeed, void ( *func ) (  ) );
;73:
;74:void SUB_CalcMoveEnt( gedict_t * ent, vec3_t tdest, float tspeed, void ( *func ) (  ) )
;75:{
line 78
;76:	gedict_t *stemp;
;77:
;78:	stemp = self;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
line 79
;79:	self = ent;
ADDRGP4 self
ADDRFP4 0
INDIRP4
ASGNP4
line 81
;80:
;81:	SUB_CalcMove( tdest, tspeed, func );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 SUB_CalcMove
CALLV
pop
line 82
;82:	self = stemp;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 83
;83:}
LABELV $25
endproc SUB_CalcMoveEnt 4 12
export SUB_CalcMove
proc SUB_CalcMove 32 12
line 86
;84:
;85:void SUB_CalcMove( vec3_t tdest, float tspeed, void ( *func ) (  ) )
;86:{
line 90
;87:	vec3_t  vdestdelta;
;88:	float   len, traveltime;
;89:
;90:	if ( !tspeed )
ADDRFP4 4
INDIRF4
CNSTF4 0
NEF4 $27
line 91
;91:		G_Error( "No speed is defined!" );
ADDRGP4 $29
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $27
line 93
;92:
;93:	self->think1 = func;
ADDRGP4 self
INDIRP4
CNSTI4 696
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 94
;94:	VectorCopy( tdest, self->finaldest );
ADDRGP4 self
INDIRP4
CNSTI4 700
ADDP4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 704
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 708
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 95
;95:	self->s.v.think = ( func_t ) SUB_CalcMoveDone;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_CalcMoveDone
CVPU4 4
CVUI4 4
ASGNI4
line 97
;96:
;97:	if ( VectorCompare( tdest, self->s.v.origin ) )
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $30
line 98
;98:	{
line 99
;99:		SetVector( self->s.v.velocity, 0, 0, 0 );
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
line 100
;100:		self->s.v.nextthink = self->s.v.ltime + 0.1;
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 288
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 140
ADDP4
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 101
;101:		return;
ADDRGP4 $26
JUMPV
LABELV $30
line 104
;102:	}
;103:// set destdelta to the vector needed to move
;104:	VectorSubtract( tdest, self->s.v.origin, vdestdelta )
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
SUBF4
ASGNF4
line 106
;105:// calculate length of vector
;106:	    len = vlen( vdestdelta );
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 24
INDIRF4
ASGNF4
line 109
;107:
;108:// divide by speed to get time to reach dest
;109:	traveltime = len / tspeed;
ADDRLP4 12
ADDRLP4 16
INDIRF4
ADDRFP4 4
INDIRF4
DIVF4
ASGNF4
line 111
;110:
;111:	if ( traveltime < 0.03 )
ADDRLP4 12
INDIRF4
CNSTF4 1022739087
GEF4 $34
line 112
;112:		traveltime = 0.03;
ADDRLP4 12
CNSTF4 1022739087
ASGNF4
LABELV $34
line 115
;113:
;114:// set nextthink to trigger a think when dest is reached
;115:	self->s.v.nextthink = self->s.v.ltime + traveltime;
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
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
line 118
;116:
;117:// scale the destdelta vector by the time spent traveling to get velocity
;118:	VectorScale( vdestdelta, ( 1 / traveltime ), self->s.v.velocity );
ADDRLP4 0
ARGP4
CNSTF4 1065353216
ADDRLP4 12
INDIRF4
DIVF4
ARGF4
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 120
;119:	//self.velocity = vdestdelta * (1/traveltime); // qcc won't take vec/float 
;120:}
LABELV $26
endproc SUB_CalcMove 32 12
export SUB_CalcMoveDone
proc SUB_CalcMoveDone 4 16
line 128
;121:
;122:/*
;123:============
;124:After moving, set origin to exact final destination
;125:============
;126:*/
;127:void SUB_CalcMoveDone(  )
;128:{
line 129
;129:	setorigin( self, PASSVEC3( self->finaldest ) );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 700
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 708
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 131
;130:
;131:	SetVector( self->s.v.velocity, 0, 0, 0 );
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
line 133
;132:	//self->s.v.nextthink = -1;
;133:	if ( self->think1 )
ADDRGP4 self
INDIRP4
CNSTI4 696
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $37
line 134
;134:		self->think1(  );
ADDRGP4 self
INDIRP4
CNSTI4 696
ADDP4
INDIRP4
CALLV
pop
LABELV $37
line 135
;135:}
LABELV $36
endproc SUB_CalcMoveDone 4 16
export DelayThink
proc DelayThink 0 4
line 192
;136:
;137:/*
;138:=============
;139:SUB_CalcAngleMove
;140:
;141:calculate self.avelocity and self.nextthink to reach destangle from
;142:self.angles rotating 
;143:
;144:The calling function should make sure self.think is valid
;145:===============
;146:*/
;147://REMOVE!!!
;148:/*void  SUB_CalcAngleMove(vec3_t destangle, float tspeed, void();
;149:
;150:void  SUB_CalcAngleMoveEnt(gedict_t* ent, vec3_t destangle, float tspeed, void()
;151:{
;152: gedict_t* stemp;
;153:
;154: stemp = self;
;155: self = ent;
;156: SUB_CalcAngleMove(destangle, tspeed, func);
;157: self = stemp;
;158:}
;159:
;160:void func) SUB_CalcAngleMove(vec3_t destangle, float tspeed, void()
;161:{
;162: vec3_t destdelta;
;163: float len;
;164: float traveltime;
;165:
;166: if (!tspeed) 
;167:  objerror("No speed is defined!");
;168: destdelta = destangle - self.angles;
;169: len = vlen(destdelta);
;170: traveltime = len / tspeed;
;171: self->s.v.nextthink = self->s.v.ltime + traveltime;
;172: self->s.v.avelocity = destdelta * (1 / traveltime);
;173: self.think1 = func;
;174: self.finalangle = destangle;
;175: self->s.v.think = (func_t) SUB_CalcAngleMoveDone;
;176:}
;177:
;178:void SUB_CalcAngleMoveDone()
;179:{
;180: self.angles = self.finalangle;
;181: SetVector(self->s.v.avelocity, 0, 0, 0);
;182: self->s.v.nextthink = -1;
;183: if (self.think1) 
;184:  self.think1();
;185:};*/
;186:
;187://=============================================================================
;188:void    SUB_UseTargets(  );
;189:gedict_t *activator;
;190:
;191:void DelayThink(  )
;192:{
line 194
;193:
;194:	activator = PROG_TO_EDICT( self->s.v.enemy );
ADDRGP4 activator
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 196
;195:
;196:	SUB_UseTargets(  );
ADDRGP4 SUB_UseTargets
CALLV
pop
line 197
;197:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 198
;198:}
LABELV $39
endproc DelayThink 0 4
export SUB_UseTargets
proc SUB_UseTargets 32 20
line 221
;199:
;200:/*
;201:==============================
;202:SUB_UseTargets
;203:
;204:the global "activator" should be set to the entity that initiated the firing.
;205:
;206:If self.delay is set, a DelayedUse entity will be created that will actually
;207:do the SUB_UseTargets after that many seconds have passed.
;208:
;209:Centerprints any self.message to the activator.
;210:
;211:Removes all entities with a targetname that match self.killtarget,
;212:and removes them, so some events can remove other triggers.
;213:
;214:Search for (string)targetname in all entities that
;215:match (string)self.target and call their .use function
;216:
;217:==============================
;218:*/
;219:
;220:void SUB_UseTargets(  )
;221:{
line 224
;222:	gedict_t *t, *stemp, *otemp, *act;
;223:
;224:	if ( self->dont_do_triggerwork )
ADDRGP4 self
INDIRP4
CNSTI4 1392
ADDP4
INDIRI4
CNSTI4 0
EQI4 $41
line 225
;225:	{
line 226
;226:		self->dont_do_triggerwork = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1392
ADDP4
CNSTI4 0
ASGNI4
line 227
;227:		return;
ADDRGP4 $40
JUMPV
LABELV $41
line 232
;228:	}
;229://
;230:// check for a delay
;231://
;232:	if ( self->delay )
ADDRGP4 self
INDIRP4
CNSTI4 664
ADDP4
INDIRF4
CNSTF4 0
EQF4 $43
line 233
;233:	{
line 235
;234:		// create a temp object to fire at a later time
;235:		t = spawn(  );
ADDRLP4 16
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 236
;236:		t->s.v.classname = "DelayedUse";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $45
ASGNP4
line 237
;237:		t->s.v.nextthink = g_globalvars.time + self->delay;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 664
ADDP4
INDIRF4
ADDF4
ASGNF4
line 238
;238:		t->s.v.think = ( func_t ) DelayThink;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 DelayThink
CVPU4 4
CVUI4 4
ASGNI4
line 239
;239:		t->s.v.enemy = EDICT_TO_PROG( activator );
ADDRLP4 0
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
line 240
;240:		t->s.v.message = self->s.v.message;
ADDRLP4 20
CNSTI4 496
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
INDIRP4
ASGNP4
line 241
;241:		t->killtarget = self->killtarget;
ADDRLP4 24
CNSTI4 532
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
INDIRP4
ASGNP4
line 242
;242:		t->s.v.target = self->s.v.target;
ADDRLP4 28
CNSTI4 460
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
INDIRP4
ASGNP4
line 243
;243:		return;
ADDRGP4 $40
JUMPV
LABELV $43
line 248
;244:	}
;245://
;246:// print the message
;247://activator->s.v.classname && 
;248:	if ( streq( activator->s.v.classname, "player" ) && self->s.v.message )
ADDRGP4 activator
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $49
ARGP4
ADDRLP4 16
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $47
ADDRGP4 self
INDIRP4
CNSTI4 496
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $47
line 249
;249:		if ( strneq( self->s.v.message, "" ) )
ADDRGP4 self
INDIRP4
CNSTI4 496
ADDP4
INDIRP4
ARGP4
ADDRGP4 $24
ARGP4
ADDRLP4 20
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $50
line 250
;250:		{
line 251
;251:			G_centerprint( activator, self->s.v.message );
ADDRGP4 activator
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
line 252
;252:			if ( !self->s.v.noise )
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $52
line 253
;253:				sound( activator, CHAN_VOICE, "misc/talk.wav", 1, ATTN_NORM );
ADDRGP4 activator
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $54
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
LABELV $52
line 254
;254:		}
LABELV $50
LABELV $47
line 255
;255:	if ( streq( activator->s.v.classname, "player" ) )
ADDRGP4 activator
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $49
ARGP4
ADDRLP4 24
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $55
line 256
;256:	{
line 257
;257:		DoGroupWork( self, activator );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 activator
INDIRP4
ARGP4
ADDRGP4 DoGroupWork
CALLV
pop
line 258
;258:		DoGoalWork( self, activator );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 activator
INDIRP4
ARGP4
ADDRGP4 DoGoalWork
CALLV
pop
line 259
;259:	}
LABELV $55
line 263
;260://
;261:// kill the killtagets
;262://
;263:	if ( self->killtarget )
ADDRGP4 self
INDIRP4
CNSTI4 532
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $57
line 264
;264:	{
line 265
;265:		t = world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
LABELV $59
line 267
;266:		do
;267:		{
line 268
;268:			t = trap_find( t, FOFS( s.v.targetname ), self->killtarget );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 464
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 532
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
line 269
;269:			if ( !t )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $62
line 270
;270:				return;
ADDRGP4 $40
JUMPV
LABELV $62
line 271
;271:			ent_remove( t );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 272
;272:		}
LABELV $60
line 273
;273:		while ( 1 );
ADDRGP4 $59
JUMPV
line 274
;274:	}
LABELV $57
line 278
;275://
;276:// fire targets
;277://
;278:	if ( self->s.v.target )
ADDRGP4 self
INDIRP4
CNSTI4 460
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $64
line 279
;279:	{
line 280
;280:		act = activator;
ADDRLP4 12
ADDRGP4 activator
INDIRP4
ASGNP4
line 281
;281:		t = world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
LABELV $66
line 283
;282:		do
;283:		{
line 285
;284:
;285:			t = trap_find( t, FOFS( s.v.targetname ), self->s.v.target );
ADDRLP4 0
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
line 286
;286:			if ( !t )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $69
line 287
;287:			{
line 288
;288:				return;
ADDRGP4 $40
JUMPV
LABELV $69
line 290
;289:			}
;290:			stemp = self;
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
line 291
;291:			otemp = other;
ADDRLP4 8
ADDRGP4 other
INDIRP4
ASGNP4
line 292
;292:			self = t;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 293
;293:			other = stemp;
ADDRGP4 other
ADDRLP4 4
INDIRP4
ASGNP4
line 295
;294:			//if (self.use != SUB_Null) //FIX??
;295:			{
line 296
;296:				if ( self->s.v.use )
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 0
EQI4 $71
line 297
;297:					( ( void ( * )(  ) ) ( self->s.v.use ) ) (  );
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CVIU4 4
CVUP4 4
CALLV
pop
LABELV $71
line 298
;298:			}
line 299
;299:			self = stemp;
ADDRGP4 self
ADDRLP4 4
INDIRP4
ASGNP4
line 300
;300:			other = otemp;
ADDRGP4 other
ADDRLP4 8
INDIRP4
ASGNP4
line 301
;301:			activator = act;
ADDRGP4 activator
ADDRLP4 12
INDIRP4
ASGNP4
line 302
;302:		}
LABELV $67
line 303
;303:		while ( 1 );
ADDRGP4 $66
JUMPV
line 304
;304:	}
LABELV $64
line 307
;305:
;306:
;307:}
LABELV $40
endproc SUB_UseTargets 32 20
export SUB_AttackFinished
proc SUB_AttackFinished 0 0
line 310
;308:int     skill;
;309:void SUB_AttackFinished( float normal )
;310:{
line 311
;311:	self->cnt = 0;
ADDRGP4 self
INDIRP4
CNSTI4 692
ADDP4
CNSTF4 0
ASGNF4
line 312
;312:	if ( skill < 3 )
ADDRGP4 skill
INDIRI4
CNSTI4 3
GEI4 $74
line 313
;313:		self->attack_finished = g_globalvars.time + normal;
ADDRGP4 self
INDIRP4
CNSTI4 724
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRFP4 0
INDIRF4
ADDF4
ASGNF4
LABELV $74
line 314
;314:}
LABELV $73
endproc SUB_AttackFinished 0 0
export SUB_CheckRefire
proc SUB_CheckRefire 4 4
line 320
;315:
;316:
;317:
;318:
;319:void SUB_CheckRefire( void ( *thinkst ) (  ) )
;320:{
line 321
;321:	if ( skill < 3 )
ADDRGP4 skill
INDIRI4
CNSTI4 3
GEI4 $78
line 322
;322:		return;
ADDRGP4 $77
JUMPV
LABELV $78
line 323
;323:	if ( self->cnt == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 692
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $80
line 324
;324:		return;
ADDRGP4 $77
JUMPV
LABELV $80
line 325
;325:	if ( !visible( PROG_TO_EDICT( self->s.v.enemy ) ) )
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 visible
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $82
line 326
;326:		return;
ADDRGP4 $77
JUMPV
LABELV $82
line 327
;327:	self->cnt = 1;
ADDRGP4 self
INDIRP4
CNSTI4 692
ADDP4
CNSTF4 1065353216
ASGNF4
line 328
;328:	self->s.v.think = ( func_t ) thinkst;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRFP4 0
INDIRP4
CVPU4 4
CVUI4 4
ASGNI4
line 329
;329:}
LABELV $77
endproc SUB_CheckRefire 4 4
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
bss
export activator
align 4
LABELV activator
skip 4
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
export skill
align 4
LABELV skill
skip 4
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
LABELV $54
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
LABELV $49
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $45
byte 1 68
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 100
byte 1 85
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $29
byte 1 78
byte 1 111
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 33
byte 1 0
align 1
LABELV $24
byte 1 0
