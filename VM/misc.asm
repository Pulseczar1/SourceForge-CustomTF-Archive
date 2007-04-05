export light_use
code
proc light_use 4 8
file "..\src\misc.c"
line 30
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
;21: *  $Id: misc.c,v 1.5 2005/05/23 18:54:02 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25://============================================================================
;26:
;27:#define START_OFF 1
;28:
;29:void light_use(  )
;30:{
line 31
;31:	if ( ( int ) ( self->s.v.spawnflags ) & START_OFF )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $12
line 32
;32:	{
line 33
;33:		trap_lightstyle( self->style, "m" );
ADDRGP4 self
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ARGI4
ADDRGP4 $14
ARGP4
ADDRGP4 trap_lightstyle
CALLV
pop
line 34
;34:		self->s.v.spawnflags -= START_OFF;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 456
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
line 35
;35:	} else
ADDRGP4 $13
JUMPV
LABELV $12
line 36
;36:	{
line 37
;37:		trap_lightstyle( self->style, "a" );
ADDRGP4 self
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ARGI4
ADDRGP4 $15
ARGP4
ADDRGP4 trap_lightstyle
CALLV
pop
line 38
;38:		self->s.v.spawnflags += START_OFF;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 39
;39:	}
LABELV $13
line 40
;40:}
LABELV $11
endproc light_use 4 8
export SP_light
proc SP_light 4 8
line 49
;41:
;42:/*QUAKED light (0 1 0) (-8 -8 -8) (8 8 8) START_OFF
;43:Non-displayed light.
;44:Default light value is 300
;45:Default style is 0
;46:If targeted, it will toggle between on or off.
;47:*/
;48:void SP_light(  )
;49:{
line 50
;50:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $17
line 51
;51:	{
line 52
;52:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 53
;53:		return;
ADDRGP4 $16
JUMPV
LABELV $17
line 55
;54:	}
;55:	if ( !self->s.v.targetname )
ADDRGP4 self
INDIRP4
CNSTI4 464
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $19
line 56
;56:	{			// inert light
line 57
;57:		ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 58
;58:		return;
ADDRGP4 $16
JUMPV
LABELV $19
line 60
;59:	}
;60:	if ( self->style >= 32 )
ADDRGP4 self
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 32
LTI4 $21
line 61
;61:	{
line 62
;62:		self->s.v.use = ( func_t ) light_use;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 light_use
CVPU4 4
CVUI4 4
ASGNI4
line 63
;63:		if ( ( int ) self->s.v.spawnflags & START_OFF )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $23
line 64
;64:			trap_lightstyle( self->style, "a" );
ADDRGP4 self
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ARGI4
ADDRGP4 $15
ARGP4
ADDRGP4 trap_lightstyle
CALLV
pop
ADDRGP4 $24
JUMPV
LABELV $23
line 66
;65:		else
;66:			trap_lightstyle( self->style, "m" );
ADDRGP4 self
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ARGI4
ADDRGP4 $14
ARGP4
ADDRGP4 trap_lightstyle
CALLV
pop
LABELV $24
line 67
;67:	}
LABELV $21
line 68
;68:}
LABELV $16
endproc SP_light 4 8
export SP_light_fluoro
proc SP_light_fluoro 8 24
line 78
;69:
;70:/*QUAKED light_fluoro (0 1 0) (-8 -8 -8) (8 8 8) START_OFF
;71:Non-displayed light.
;72:Default light value is 300
;73:Default style is 0
;74:If targeted, it will toggle between on or off.
;75:Makes steady fluorescent humming sound
;76:*/
;77:void SP_light_fluoro(  )
;78:{
line 79
;79:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $26
line 80
;80:	{
line 81
;81:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 82
;82:		return;
ADDRGP4 $25
JUMPV
LABELV $26
line 84
;83:	}
;84:	if ( self->style >= 32 )
ADDRGP4 self
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 32
LTI4 $28
line 85
;85:	{
line 86
;86:		self->s.v.use = ( func_t ) light_use;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 light_use
CVPU4 4
CVUI4 4
ASGNI4
line 87
;87:		if ( ( int ) self->s.v.spawnflags & START_OFF )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $30
line 88
;88:			trap_lightstyle( self->style, "a" );
ADDRGP4 self
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ARGI4
ADDRGP4 $15
ARGP4
ADDRGP4 trap_lightstyle
CALLV
pop
ADDRGP4 $31
JUMPV
LABELV $30
line 90
;89:		else
;90:			trap_lightstyle( self->style, "m" );
ADDRGP4 self
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ARGI4
ADDRGP4 $14
ARGP4
ADDRGP4 trap_lightstyle
CALLV
pop
LABELV $31
line 91
;91:	}
LABELV $28
line 93
;92:
;93:	trap_precache_sound( "ambience/fl_hum1.wav" );
ADDRGP4 $32
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 94
;94:	trap_ambientsound( PASSVEC3( self->s.v.origin ), "ambience/fl_hum1.wav", 0.5, ATTN_STATIC );
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
ADDRGP4 $32
ARGP4
CNSTF4 1056964608
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 95
;95:}
LABELV $25
endproc SP_light_fluoro 8 24
export SP_light_fluorospark
proc SP_light_fluorospark 8 24
line 105
;96:
;97:
;98:/*QUAKED light_fluorospark (0 1 0) (-8 -8 -8) (8 8 8)
;99:Non-displayed light.
;100:Default light value is 300
;101:Default style is 10
;102:Makes sparking, broken fluorescent sound
;103:*/
;104:void SP_light_fluorospark(  )
;105:{
line 106
;106:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $34
line 107
;107:	{
line 108
;108:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 109
;109:		return;
ADDRGP4 $33
JUMPV
LABELV $34
line 111
;110:	}
;111:	if ( !self->style )
ADDRGP4 self
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 0
NEI4 $36
line 112
;112:		self->style = 10;
ADDRGP4 self
INDIRP4
CNSTI4 548
ADDP4
CNSTI4 10
ASGNI4
LABELV $36
line 114
;113:
;114:	trap_precache_sound( "ambience/buzz1.wav" );
ADDRGP4 $38
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 115
;115:	trap_ambientsound( PASSVEC3( self->s.v.origin ), "ambience/buzz1.wav", 0.5, ATTN_STATIC );
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
ADDRGP4 $38
ARGP4
CNSTF4 1056964608
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 116
;116:}
LABELV $33
endproc SP_light_fluorospark 8 24
export SP_light_globe
proc SP_light_globe 4 8
line 124
;117:
;118:/*QUAKED light_globe (0 1 0) (-8 -8 -8) (8 8 8)
;119:Sphere globe light.
;120:Default light value is 300
;121:Default style is 0
;122:*/
;123:void SP_light_globe(  )
;124:{
line 125
;125:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $40
line 126
;126:	{
line 127
;127:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 128
;128:		return;
ADDRGP4 $39
JUMPV
LABELV $40
line 130
;129:	}
;130:	trap_precache_model( "progs/s_light.spr" );
ADDRGP4 $42
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 131
;131:	setmodel( self, "progs/s_light.spr" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $42
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 132
;132:	makestatic( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 makestatic
CALLV
pop
line 133
;133:}
LABELV $39
endproc SP_light_globe 4 8
export FireAmbient
proc FireAmbient 4 24
line 136
;134:
;135:void FireAmbient(  )
;136:{
line 137
;137:	trap_precache_sound( "ambience/fire1.wav" );
ADDRGP4 $44
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 139
;138:// attenuate fast
;139:	trap_ambientsound( PASSVEC3( self->s.v.origin ), "ambience/fire1.wav", 0.5, ATTN_STATIC );
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
ADDRGP4 $44
ARGP4
CNSTF4 1056964608
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 140
;140:}
LABELV $43
endproc FireAmbient 4 24
export SP_light_torch_small_walltorch
proc SP_light_torch_small_walltorch 4 8
line 148
;141:
;142:/*QUAKED light_torch_small_walltorch (0 .5 0) (-10 -10 -20) (10 10 20)
;143:Short wall torch
;144:Default light value is 200
;145:Default style is 0
;146:*/
;147:void SP_light_torch_small_walltorch(  )
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
NEI4 $46
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
ADDRGP4 $45
JUMPV
LABELV $46
line 154
;153:	}
;154:	trap_precache_model( "progs/flame.mdl" );
ADDRGP4 $48
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 155
;155:	setmodel( self, "progs/flame.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $48
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 156
;156:	FireAmbient( );
ADDRGP4 FireAmbient
CALLV
pop
line 157
;157:	makestatic( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 makestatic
CALLV
pop
line 158
;158:}
LABELV $45
endproc SP_light_torch_small_walltorch 4 8
export SP_light_flame_large_yellow
proc SP_light_flame_large_yellow 4 8
line 165
;159:
;160:
;161:/*QUAKED light_flame_large_yellow (0 1 0) (-10 -10 -12) (12 12 18)
;162:Large yellow flame ball
;163:*/
;164:void SP_light_flame_large_yellow(  )
;165:{
line 166
;166:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $50
line 167
;167:	{
line 168
;168:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 169
;169:		return;
ADDRGP4 $49
JUMPV
LABELV $50
line 171
;170:	}
;171:	trap_precache_model( "progs/flame2.mdl" );
ADDRGP4 $52
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 172
;172:	setmodel( self, "progs/flame2.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $52
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 173
;173:	self->s.v.frame = 1;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1065353216
ASGNF4
line 174
;174:	FireAmbient( );
ADDRGP4 FireAmbient
CALLV
pop
line 175
;175:	makestatic( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 makestatic
CALLV
pop
line 176
;176:}
LABELV $49
endproc SP_light_flame_large_yellow 4 8
export SP_light_flame_small_yellow
proc SP_light_flame_small_yellow 4 8
line 182
;177:
;178:/*QUAKED light_flame_small_yellow (0 1 0) (-8 -8 -8) (8 8 8) START_OFF
;179:Small yellow flame ball
;180:*/
;181:void SP_light_flame_small_yellow(  )
;182:{
line 183
;183:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $54
line 184
;184:	{
line 185
;185:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 186
;186:		return;
ADDRGP4 $53
JUMPV
LABELV $54
line 188
;187:	}
;188:	trap_precache_model( "progs/flame2.mdl" );
ADDRGP4 $52
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 189
;189:	setmodel( self, "progs/flame2.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $52
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 190
;190:	FireAmbient( );
ADDRGP4 FireAmbient
CALLV
pop
line 191
;191:	makestatic( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 makestatic
CALLV
pop
line 192
;192:}
LABELV $53
endproc SP_light_flame_small_yellow 4 8
export SP_light_flame_small_white
proc SP_light_flame_small_white 4 8
line 198
;193:
;194:/*QUAKED light_flame_small_white (0 1 0) (-10 -10 -40) (10 10 40) START_OFF
;195:Small white flame ball
;196:*/
;197:void SP_light_flame_small_white(  )
;198:{
line 199
;199:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $57
line 200
;200:	{
line 201
;201:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 202
;202:		return;
ADDRGP4 $56
JUMPV
LABELV $57
line 204
;203:	}
;204:	trap_precache_model( "progs/flame2.mdl" );
ADDRGP4 $52
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 205
;205:	setmodel( self, "progs/flame2.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $52
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 206
;206:	FireAmbient( );
ADDRGP4 FireAmbient
CALLV
pop
line 207
;207:	makestatic( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 makestatic
CALLV
pop
line 208
;208:}
LABELV $56
endproc SP_light_flame_small_white 4 8
export SP_misc_fireball
proc SP_misc_fireball 8 4
line 222
;209:
;210://============================================================================
;211:
;212:
;213:/*QUAKED misc_fireball (0 .5 .8) (-8 -8 -8) (8 8 8)
;214:Lava Balls
;215:*/
;216:
;217:void    fire_fly(  );
;218:void    fire_touch(  );
;219:
;220:
;221:void SP_misc_fireball(  )
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
NEI4 $60
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
ADDRGP4 $59
JUMPV
LABELV $60
line 228
;227:	}
;228:	trap_precache_model( "progs/lavaball.mdl" );
ADDRGP4 $62
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 229
;229:	self->s.v.classname = "fireball";
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $63
ASGNP4
line 230
;230:	self->s.v.nextthink = g_globalvars.time + ( g_random(  ) * 5 );
ADDRLP4 4
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDRLP4 4
INDIRF4
MULF4
ADDF4
ASGNF4
line 231
;231:	self->s.v.think = ( func_t ) fire_fly;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 fire_fly
CVPU4 4
CVUI4 4
ASGNI4
line 233
;232:
;233:	if ( !self->speed )
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
CNSTF4 0
NEF4 $65
line 234
;234:		self->speed = 1000;
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
CNSTF4 1148846080
ASGNF4
LABELV $65
line 235
;235:}
LABELV $59
endproc SP_misc_fireball 8 4
export fire_fly
proc fire_fly 32 28
line 238
;236:
;237:void fire_fly(  )
;238:{
line 241
;239:	gedict_t *fireball;
;240:
;241:	fireball = spawn(  );
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 242
;242:	newmis = fireball;
ADDRGP4 newmis
ADDRLP4 0
INDIRP4
ASGNP4
line 243
;243:	g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 244
;244:	fireball->s.v.solid = SOLID_TRIGGER;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 245
;245:	fireball->s.v.movetype = MOVETYPE_TOSS;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 246
;246:	SetVector( fireball->s.v.velocity,
ADDRLP4 8
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1120403456
ADDRLP4 8
INDIRF4
MULF4
CNSTF4 1112014848
SUBF4
ASGNF4
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1120403456
ADDRLP4 12
INDIRF4
MULF4
CNSTF4 1112014848
SUBF4
ASGNF4
ADDRLP4 16
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
CNSTF4 1128792064
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
line 249
;247:		   ( g_random(  ) * 100 ) - 50, ( g_random(  ) * 100 ) - 50, self->speed + ( g_random(  ) * 200 ) );
;248:
;249:	fireball->s.v.classname = "fireball";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $63
ASGNP4
line 251
;250:
;251:	setmodel( fireball, "progs/lavaball.mdl" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $62
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 252
;252:	setsize( fireball, 0, 0, 0, 0, 0, 0 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20
CNSTF4 0
ASGNF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 253
;253:	setorigin( fireball, PASSVEC3( self->s.v.origin ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 255
;254:
;255:	fireball->s.v.nextthink = g_globalvars.time + 5;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 256
;256:	fireball->s.v.think = ( func_t ) SUB_Remove;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 257
;257:	fireball->s.v.touch = ( func_t ) fire_touch;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 fire_touch
CVPU4 4
CVUI4 4
ASGNI4
line 259
;258:
;259:	self->s.v.nextthink = g_globalvars.time + ( g_random(  ) * 5 ) + 3;
ADDRLP4 28
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDRLP4 28
INDIRF4
MULF4
ADDF4
CNSTF4 1077936128
ADDF4
ASGNF4
line 260
;260:	self->s.v.think = ( func_t ) fire_fly;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 fire_fly
CVPU4 4
CVUI4 4
ASGNI4
line 261
;261:}
LABELV $67
endproc fire_fly 32 28
export fire_touch
proc fire_touch 4 24
line 264
;262:
;263:void fire_touch(  )
;264:{
line 265
;265:	if ( other->s.v.takedamage )
ADDRGP4 other
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
EQF4 $72
line 266
;266:		TF_T_Damage( other, self, self, 20, 0, 16 );
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
CNSTF4 1101004800
ARGF4
CNSTI4 0
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
LABELV $72
line 267
;267:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 268
;268:}
LABELV $71
endproc fire_touch 4 24
export barrel_explode
proc barrel_explode 8 16
line 275
;269:
;270://============================================================================
;271:
;272:
;273:
;274:void barrel_explode(  )
;275:{
line 276
;276:	self->s.v.takedamage = DAMAGE_NO;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 0
ASGNF4
line 277
;277:	self->s.v.classname = "explo_box";
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $75
ASGNP4
line 279
;278:	// did say self.owner
;279:	T_RadiusDamage( self, self, 160, world );
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
CNSTF4 1126170624
ARGF4
ADDRGP4 world
INDIRP4
ARGP4
ADDRGP4 T_RadiusDamage
CALLV
pop
line 281
;280:
;281:	trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 282
;282:	trap_WriteByte( MSG_MULTICAST, TE_EXPLOSION );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 283
;283:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
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
line 284
;284:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
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
line 285
;285:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] + 32 );
CNSTI4 4
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1107296256
ADDF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 287
;286:
;287:	trap_multicast( PASSVEC3( self->s.v.origin ), MULTICAST_PHS );
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
line 289
;288:
;289:	ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 290
;290:}
LABELV $74
endproc barrel_explode 8 16
export SP_misc_explobox
proc SP_misc_explobox 24 28
line 297
;291:
;292:/*QUAKED misc_explobox (0 .5 .8) (0 0 0) (32 32 64)
;293:TESTING THING
;294:*/
;295:
;296:void SP_misc_explobox(  )
;297:{
line 300
;298:	float   oldz;
;299:
;300:	if ( !CheckExistence(  ) )
ADDRLP4 4
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $77
line 301
;301:	{
line 302
;302:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 303
;303:		return;
ADDRGP4 $76
JUMPV
LABELV $77
line 305
;304:	}
;305:	self->s.v.solid = SOLID_BBOX;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 306
;306:	self->s.v.movetype = MOVETYPE_NONE;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 308
;307:
;308:	trap_precache_model( "maps/b_explob.bsp" );
ADDRGP4 $79
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 309
;309:	setmodel( self, "maps/b_explob.bsp" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $79
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 310
;310:	setsize( self, 0, 0, 0, 32, 32, 64 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
CNSTF4 1107296256
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1115684864
ARGF4
ADDRGP4 setsize
CALLV
pop
line 311
;311:	trap_precache_sound( "weapons/r_exp3.wav" );
ADDRGP4 $80
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 313
;312:
;313:	self->s.v.health = 20;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1101004800
ASGNF4
line 314
;314:	self->th_die = barrel_explode;
ADDRGP4 self
INDIRP4
CNSTI4 812
ADDP4
ADDRGP4 barrel_explode
ASGNP4
line 315
;315:	self->s.v.takedamage = DAMAGE_AIM;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 1073741824
ASGNF4
line 317
;316:
;317:	self->s.v.origin[2] += 2;
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 318
;318:	oldz = self->s.v.origin[2];
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 319
;319:	droptofloor( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 droptofloor
CALLI4
pop
line 320
;320:	if ( oldz - self->s.v.origin[2] > 250 )
ADDRLP4 0
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
SUBF4
CNSTF4 1132068864
LEF4 $81
line 321
;321:	{
line 322
;322:		G_dprintf( "item fell out of level at '%f %f %f'\n", PASSVEC3( self->s.v.origin ) );
ADDRGP4 $83
ARGP4
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_dprintf
CALLV
pop
line 323
;323:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 324
;324:	}
LABELV $81
line 325
;325:}
LABELV $76
endproc SP_misc_explobox 24 28
export SP_misc_explobox2
proc SP_misc_explobox2 24 28
line 332
;326:
;327:/*QUAKED misc_explobox2 (0 .5 .8) (0 0 0) (32 32 64)
;328:Smaller exploding box, REGISTERED ONLY
;329:*/
;330:
;331:void SP_misc_explobox2(  )
;332:{
line 335
;333:	float   oldz;
;334:
;335:	if ( !CheckExistence(  ) )
ADDRLP4 4
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $85
line 336
;336:	{
line 337
;337:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 338
;338:		return;
ADDRGP4 $84
JUMPV
LABELV $85
line 341
;339:	}
;340:
;341:	self->s.v.solid = SOLID_BBOX;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 342
;342:	self->s.v.movetype = MOVETYPE_NONE;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 344
;343:
;344:	trap_precache_model( "maps/b_exbox2.bsp" );
ADDRGP4 $87
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 345
;345:	setmodel( self, "maps/b_exbox2.bsp" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $87
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 346
;346:	setsize( self, 0, 0, 0, 32, 32, 32 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
CNSTF4 1107296256
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
ADDRGP4 setsize
CALLV
pop
line 347
;347:	trap_precache_sound( "weapons/r_exp3.wav" );
ADDRGP4 $80
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 349
;348:
;349:	self->s.v.health = 20;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1101004800
ASGNF4
line 350
;350:	self->th_die = barrel_explode;
ADDRGP4 self
INDIRP4
CNSTI4 812
ADDP4
ADDRGP4 barrel_explode
ASGNP4
line 351
;351:	self->s.v.takedamage = DAMAGE_AIM;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 1073741824
ASGNF4
line 353
;352:
;353:	self->s.v.origin[2] += 2;
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 354
;354:	oldz = self->s.v.origin[2];
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 356
;355:
;356:	droptofloor( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 droptofloor
CALLI4
pop
line 358
;357:
;358:	if ( oldz - self->s.v.origin[2] > 250 )
ADDRLP4 0
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
SUBF4
CNSTF4 1132068864
LEF4 $88
line 359
;359:	{
line 360
;360:		G_dprintf( "item fell out of level at '%f %f %f'\n", PASSVEC3( self->s.v.origin ) );
ADDRGP4 $83
ARGP4
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_dprintf
CALLV
pop
line 361
;361:		ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 362
;362:	}
LABELV $88
line 363
;363:}
LABELV $84
endproc SP_misc_explobox2 24 28
export Laser_Touch
proc Laser_Touch 24 24
line 373
;364:
;365://============================================================================
;366:
;367:#define SPAWNFLAG_SUPERSPIKE      1
;368:#define SPAWNFLAG_LASER  2
;369:
;370:void    LaunchLaser( vec3_t org, vec3_t vec );
;371:
;372:void Laser_Touch(  )
;373:{
line 376
;374:	vec3_t  org;
;375:
;376:	if ( other == PROG_TO_EDICT( self->s.v.owner ) )
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
NEU4 $91
line 377
;377:		return;		// don't explode on owner
ADDRGP4 $90
JUMPV
LABELV $91
line 379
;378:
;379:	if ( trap_pointcontents( PASSVEC3( self->s.v.origin ) ) == CONTENT_SKY )
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
ADDRLP4 16
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 -6
NEI4 $93
line 380
;380:	{
line 381
;381:		ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 382
;382:		return;
ADDRGP4 $90
JUMPV
LABELV $93
line 385
;383:	}
;384:
;385:	sound( self, CHAN_WEAPON, "enforcer/enfstop.wav", 1, ATTN_STATIC );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $95
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 sound
CALLV
pop
line 387
;386:
;387:	normalize( self->s.v.velocity, org );
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 normalize
CALLV
pop
line 388
;388:	VectorScale( org, 8, org );
ADDRLP4 0
ARGP4
CNSTF4 1090519040
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 389
;389:	VectorSubtract( self->s.v.origin, org, org );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 392
;390:	//org = self->s.v.origin - 8*normalize(self->s.v.velocity);
;391:
;392:	if ( other->s.v.health )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
EQF4 $100
line 393
;393:	{
line 394
;394:		SpawnBlood( org, 15 );
ADDRLP4 0
ARGP4
CNSTF4 1097859072
ARGF4
ADDRGP4 SpawnBlood
CALLV
pop
line 395
;395:		TF_T_Damage( other, self, PROG_TO_EDICT( self->s.v.owner ), 15, 0, 8 );
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTF4 1097859072
ARGF4
CNSTI4 0
ARGI4
CNSTI4 8
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 396
;396:	} else
ADDRGP4 $101
JUMPV
LABELV $100
line 397
;397:	{
line 398
;398:		trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 399
;399:		trap_WriteByte( MSG_MULTICAST, TE_GUNSHOT );
CNSTI4 4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 400
;400:		trap_WriteByte( MSG_MULTICAST, 5 );
CNSTI4 4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 401
;401:		trap_WriteCoord( MSG_MULTICAST, org[0] );
CNSTI4 4
ARGI4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 402
;402:		trap_WriteCoord( MSG_MULTICAST, org[1] );
CNSTI4 4
ARGI4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 403
;403:		trap_WriteCoord( MSG_MULTICAST, org[2] );
CNSTI4 4
ARGI4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 405
;404:
;405:		trap_multicast( PASSVEC3( org ), MULTICAST_PVS );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 406
;406:	}
LABELV $101
line 408
;407:
;408:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 409
;409:}
LABELV $90
endproc Laser_Touch 24 24
export LaunchLaser
proc LaunchLaser 28 28
line 414
;410:
;411:gedict_t *newmis;
;412:
;413:void LaunchLaser( vec3_t org, vec3_t vec )
;414:{
line 416
;415:
;416:	if ( !strcmp( self->s.v.classname, "monster_enforcer" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $109
ARGP4
ADDRLP4 0
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $107
line 417
;417:		sound( self, CHAN_WEAPON, "enforcer/enfire.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $110
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
LABELV $107
line 419
;418:
;419:	normalize( vec, vec );
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 normalize
CALLV
pop
line 421
;420:
;421:	newmis = spawn(  );
ADDRLP4 12
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 12
INDIRP4
ASGNP4
line 422
;422:	g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 423
;423:	newmis->s.v.owner = EDICT_TO_PROG( self );
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
line 424
;424:	newmis->s.v.movetype = MOVETYPE_FLY;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1084227584
ASGNF4
line 425
;425:	newmis->s.v.solid = SOLID_BBOX;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 426
;426:	newmis->s.v.effects = EF_DIMLIGHT;
ADDRGP4 newmis
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1090519040
ASGNF4
line 428
;427:
;428:	setmodel( newmis, "progs/laser.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $112
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 429
;429:	setsize( newmis, 0, 0, 0, 0, 0, 0 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 16
CNSTF4 0
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
line 431
;430:
;431:	setorigin( newmis, PASSVEC3( org ) );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 434
;432:
;433:	//newmis->s.v.velocity = vec * 600;
;434:	VectorScale( vec, 600, newmis->s.v.velocity );
ADDRFP4 4
INDIRP4
ARGP4
CNSTF4 1142292480
ARGF4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 436
;435:
;436:	vectoangles( newmis->s.v.velocity, newmis->s.v.angles );
ADDRLP4 24
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 438
;437:
;438:	newmis->s.v.nextthink = g_globalvars.time + 5;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 439
;439:	newmis->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 440
;440:	newmis->s.v.touch = ( func_t ) Laser_Touch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 Laser_Touch
CVPU4 4
CVUI4 4
ASGNI4
line 441
;441:}
LABELV $106
endproc LaunchLaser 28 28
export spikeshooter_use
proc spikeshooter_use 8 20
line 457
;442:
;443:/*
;444:===============
;445:launch_spike
;446:
;447:Used for both the player and the ogre
;448:===============
;449:*/
;450:void    spike_touch(  );
;451:
;452:void    launch_spike( vec3_t org, vec3_t dir );
;453:void    superspike_touch(  );
;454:
;455:
;456:void spikeshooter_use(  )
;457:{
line 458
;458:	if ( ( int ) ( self->s.v.spawnflags ) & SPAWNFLAG_LASER )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $115
line 459
;459:	{
line 460
;460:		sound( self, CHAN_VOICE, "enforcer/enfire.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $110
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
line 461
;461:		LaunchLaser( self->s.v.origin, self->s.v.movedir );
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
CNSTI4 484
ADDP4
ARGP4
ADDRGP4 LaunchLaser
CALLV
pop
line 462
;462:	} else
ADDRGP4 $116
JUMPV
LABELV $115
line 463
;463:	{
line 464
;464:		sound( self, CHAN_VOICE, "weapons/spike2.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $117
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
line 465
;465:		launch_spike( self->s.v.origin, self->s.v.movedir );
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
CNSTI4 484
ADDP4
ARGP4
ADDRGP4 launch_spike
CALLV
pop
line 466
;466:		VectorScale( self->s.v.movedir, 500, PROG_TO_EDICT( g_globalvars.newmis )->s.v.velocity );
ADDRGP4 self
INDIRP4
CNSTI4 484
ADDP4
ARGP4
CNSTF4 1140457472
ARGF4
ADDRGP4 g_globalvars+132
INDIRI4
ADDRGP4 g_edicts+112+68
ADDP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 468
;467://  newmis->s.v.velocity = self->s.v.movedir * 500;
;468:		if ( ( int ) ( self->s.v.spawnflags ) & SPAWNFLAG_SUPERSPIKE )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $121
line 469
;469:			PROG_TO_EDICT( g_globalvars.newmis )->s.v.touch = ( func_t ) superspike_touch;
ADDRGP4 g_globalvars+132
INDIRI4
ADDRGP4 g_edicts+112+160
ADDP4
ADDRGP4 superspike_touch
CVPU4 4
CVUI4 4
ASGNI4
LABELV $121
line 470
;470:	}
LABELV $116
line 471
;471:}
LABELV $114
endproc spikeshooter_use 8 20
export shooter_think
proc shooter_think 4 12
line 474
;472:
;473:void shooter_think(  )
;474:{
line 475
;475:	spikeshooter_use(  );
ADDRGP4 spikeshooter_use
CALLV
pop
line 476
;476:	self->s.v.nextthink = g_globalvars.time + self->wait;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 660
ADDP4
INDIRF4
ADDF4
ASGNF4
line 477
;477:	VectorScale( self->s.v.movedir, 500, PROG_TO_EDICT( g_globalvars.newmis )->s.v.velocity );
ADDRGP4 self
INDIRP4
CNSTI4 484
ADDP4
ARGP4
CNSTF4 1140457472
ARGF4
ADDRGP4 g_globalvars+132
INDIRI4
ADDRGP4 g_edicts+112+68
ADDP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 479
;478:// newmis->s.v.velocity = self->s.v.movedir * 500;
;479:}
LABELV $126
endproc shooter_think 4 12
export SP_trap_spikeshooter
proc SP_trap_spikeshooter 4 4
line 487
;480:
;481:/*QUAKED trap_spikeshooter (0 .5 .8) (-8 -8 -8) (8 8 8) superspike laser
;482:When triggered, fires a spike in the direction set in QuakeEd.
;483:Laser is only for REGISTERED.
;484:*/
;485:
;486:void SP_trap_spikeshooter(  )
;487:{
line 488
;488:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $132
line 489
;489:	{
line 490
;490:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 491
;491:		return;
ADDRGP4 $131
JUMPV
LABELV $132
line 493
;492:	}
;493:	SetMovedir(  );
ADDRGP4 SetMovedir
CALLV
pop
line 494
;494:	self->s.v.use = ( func_t ) spikeshooter_use;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 spikeshooter_use
CVPU4 4
CVUI4 4
ASGNI4
line 495
;495:	if ( ( int ) ( self->s.v.spawnflags ) & SPAWNFLAG_LASER )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $134
line 496
;496:	{
line 497
;497:		trap_precache_model( "progs/laser.mdl" );
ADDRGP4 $112
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 499
;498:
;499:		trap_precache_sound( "enforcer/enfire.wav" );
ADDRGP4 $110
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 500
;500:		trap_precache_sound( "enforcer/enfstop.wav" );
ADDRGP4 $95
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 501
;501:	} else
ADDRGP4 $135
JUMPV
LABELV $134
line 502
;502:		trap_precache_sound( "weapons/spike2.wav" );
ADDRGP4 $117
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
LABELV $135
line 503
;503:}
LABELV $131
endproc SP_trap_spikeshooter 4 4
export SP_trap_shooter
proc SP_trap_shooter 12 4
line 511
;504:
;505:/*QUAKED trap_shooter (0 .5 .8) (-8 -8 -8) (8 8 8) superspike laser
;506:Continuously fires spikes.
;507:"wait" g_globalvars.time between spike (1.0 default)
;508:"nextthink" delay before firing first spike, so multiple shooters can be stagered.
;509:*/
;510:void SP_trap_shooter(  )
;511:{
line 512
;512:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $137
line 513
;513:	{
line 514
;514:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 515
;515:		return;
ADDRGP4 $136
JUMPV
LABELV $137
line 517
;516:	}
;517:	SP_trap_spikeshooter(  );
ADDRGP4 SP_trap_spikeshooter
CALLV
pop
line 519
;518:
;519:	if ( self->wait == 0 )
ADDRGP4 self
INDIRP4
CNSTI4 660
ADDP4
INDIRF4
CNSTF4 0
NEF4 $139
line 520
;520:		self->wait = 1;
ADDRGP4 self
INDIRP4
CNSTI4 660
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $139
line 521
;521:	self->s.v.nextthink = self->s.v.nextthink + self->wait + self->s.v.ltime;
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 288
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 660
ADDP4
INDIRF4
ADDF4
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRF4
ADDF4
ASGNF4
line 522
;522:	self->s.v.think = ( func_t ) shooter_think;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 shooter_think
CVPU4 4
CVUI4 4
ASGNI4
line 523
;523:}
LABELV $136
endproc SP_trap_shooter 12 4
export SP_air_bubbles
proc SP_air_bubbles 4 4
line 543
;524:
;525:
;526:/*
;527:===============================================================================
;528:
;529:
;530:===============================================================================
;531:*/
;532:
;533:
;534:void    make_bubbles(  );
;535:void    bubble_remove(  );
;536:void    bubble_bob(  );
;537:
;538:/*QUAKED air_bubbles (0 .5 .8) (-8 -8 -8) (8 8 8)
;539:
;540:testing air bubbles
;541:*/
;542:void SP_air_bubbles(  )
;543:{
line 544
;544:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $142
line 545
;545:	{
line 546
;546:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 547
;547:		return;
ADDRGP4 $141
JUMPV
LABELV $142
line 549
;548:	}
;549:	ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 550
;550:}
LABELV $141
endproc SP_air_bubbles 4 4
export make_bubbles
proc make_bubbles 24 28
line 553
;551:
;552:void make_bubbles(  )
;553:{
line 556
;554:	gedict_t *bubble;
;555:
;556:	bubble = spawn(  );
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 557
;557:	setmodel( bubble, "progs/s_bubble.spr" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $145
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 558
;558:	setorigin( bubble, PASSVEC3( self->s.v.origin ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
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
line 559
;559:	bubble->s.v.movetype = MOVETYPE_NOCLIP;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1090519040
ASGNF4
line 560
;560:	bubble->s.v.solid = SOLID_NOT;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 562
;561:
;562:	SetVector( bubble->s.v.velocity, 0, 0, 15 );
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1097859072
ASGNF4
line 563
;563:	bubble->s.v.nextthink = g_globalvars.time + 0.5;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 564
;564:	bubble->s.v.think = ( func_t ) bubble_bob;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 bubble_bob
CVPU4 4
CVUI4 4
ASGNI4
line 565
;565:	bubble->s.v.touch = ( func_t ) bubble_remove;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 bubble_remove
CVPU4 4
CVUI4 4
ASGNI4
line 566
;566:	bubble->s.v.classname = "bubble";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $147
ASGNP4
line 567
;567:	bubble->s.v.frame = 0;
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 0
ASGNF4
line 568
;568:	bubble->cnt = 0;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
CNSTF4 0
ASGNF4
line 570
;569:
;570:	setsize( bubble, -8, -8, -8, 8, 8, 8 );
ADDRLP4 0
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
line 572
;571:
;572:	self->s.v.nextthink = g_globalvars.time + g_random(  ) + 0.5;
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRLP4 20
INDIRF4
ADDF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 573
;573:	self->s.v.think = ( func_t ) make_bubbles;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 make_bubbles
CVPU4 4
CVUI4 4
ASGNI4
line 574
;574:}
LABELV $144
endproc make_bubbles 24 28
export bubble_split
proc bubble_split 24 28
line 578
;575:
;576:
;577:void bubble_split(  )
;578:{
line 581
;579:	gedict_t *bubble;
;580:
;581:	bubble = spawn(  );
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 582
;582:	setmodel( bubble, "progs/s_bubble.spr" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $145
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 583
;583:	setorigin( bubble, PASSVEC3( self->s.v.origin ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
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
line 585
;584:
;585:	bubble->s.v.movetype = MOVETYPE_NOCLIP;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1090519040
ASGNF4
line 586
;586:	bubble->s.v.solid = SOLID_NOT;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 588
;587:
;588:	VectorCopy( self->s.v.velocity, bubble->s.v.velocity );
ADDRLP4 12
CNSTI4 180
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
CNSTI4 184
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
ADDRLP4 20
CNSTI4 188
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
line 590
;589:
;590:	bubble->s.v.nextthink = g_globalvars.time + 0.5;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 591
;591:	bubble->s.v.think = ( func_t ) bubble_bob;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 bubble_bob
CVPU4 4
CVUI4 4
ASGNI4
line 592
;592:	bubble->s.v.touch = ( func_t ) bubble_remove;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 bubble_remove
CVPU4 4
CVUI4 4
ASGNI4
line 593
;593:	bubble->s.v.classname = "bubble";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $147
ASGNP4
line 594
;594:	bubble->s.v.frame = 1;
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1065353216
ASGNF4
line 595
;595:	bubble->cnt = 10;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
CNSTF4 1092616192
ASGNF4
line 597
;596:
;597:	setsize( bubble, -8, -8, -8, 8, 8, 8 );
ADDRLP4 0
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
line 599
;598:
;599:	self->s.v.frame = 1;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1065353216
ASGNF4
line 600
;600:	self->cnt = 10;
ADDRGP4 self
INDIRP4
CNSTI4 692
ADDP4
CNSTF4 1092616192
ASGNF4
line 602
;601:
;602:	if ( self->s.v.waterlevel != 3 )
ADDRGP4 self
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 1077936128
EQF4 $151
line 603
;603:		ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
LABELV $151
line 604
;604:}
LABELV $149
endproc bubble_split 24 28
export bubble_remove
proc bubble_remove 8 8
line 607
;605:
;606:void bubble_remove(  )
;607:{
line 608
;608:	if ( streq( other->s.v.classname, self->s.v.classname ) )
ADDRLP4 0
CNSTI4 216
ASGNI4
ADDRGP4 other
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $154
line 609
;609:	{
line 611
;610://              dprint ("bump");
;611:		return;
ADDRGP4 $153
JUMPV
LABELV $154
line 613
;612:	}
;613:	ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 614
;614:}
LABELV $153
endproc bubble_remove 8 8
export bubble_bob
proc bubble_bob 32 4
line 617
;615:
;616:void bubble_bob(  )
;617:{
line 622
;618:	float   rnd1, rnd2, rnd3;
;619:
;620://vec3_t    vtmp1, modi;
;621:
;622:	self->cnt = self->cnt + 1;
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 692
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 623
;623:	if ( self->cnt == 4 )
ADDRGP4 self
INDIRP4
CNSTI4 692
ADDP4
INDIRF4
CNSTF4 1082130432
NEF4 $157
line 624
;624:		bubble_split(  );
ADDRGP4 bubble_split
CALLV
pop
LABELV $157
line 625
;625:	if ( self->cnt == 20 )
ADDRGP4 self
INDIRP4
CNSTI4 692
ADDP4
INDIRF4
CNSTF4 1101004800
NEF4 $159
line 626
;626:		ent_remove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
LABELV $159
line 628
;627:
;628:	rnd1 = self->s.v.velocity[0] + ( -10 + ( g_random(  ) * 20 ) );
ADDRLP4 16
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
CNSTF4 1101004800
ADDRLP4 16
INDIRF4
MULF4
CNSTF4 3240099840
ADDF4
ADDF4
ASGNF4
line 629
;629:	rnd2 = self->s.v.velocity[1] + ( -10 + ( g_random(  ) * 20 ) );
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
CNSTF4 1101004800
ADDRLP4 20
INDIRF4
MULF4
CNSTF4 3240099840
ADDF4
ADDF4
ASGNF4
line 630
;630:	rnd3 = self->s.v.velocity[2] + 10 + g_random(  ) * 10;
ADDRLP4 24
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 28
CNSTF4 1092616192
ASGNF4
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
ADDF4
ADDRLP4 28
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
line 632
;631:
;632:	if ( rnd1 > 10 )
ADDRLP4 0
INDIRF4
CNSTF4 1092616192
LEF4 $161
line 633
;633:		rnd1 = 5;
ADDRLP4 0
CNSTF4 1084227584
ASGNF4
LABELV $161
line 634
;634:	if ( rnd1 < -10 )
ADDRLP4 0
INDIRF4
CNSTF4 3240099840
GEF4 $163
line 635
;635:		rnd1 = -5;
ADDRLP4 0
CNSTF4 3231711232
ASGNF4
LABELV $163
line 637
;636:
;637:	if ( rnd2 > 10 )
ADDRLP4 4
INDIRF4
CNSTF4 1092616192
LEF4 $165
line 638
;638:		rnd2 = 5;
ADDRLP4 4
CNSTF4 1084227584
ASGNF4
LABELV $165
line 639
;639:	if ( rnd2 < -10 )
ADDRLP4 4
INDIRF4
CNSTF4 3240099840
GEF4 $167
line 640
;640:		rnd2 = -5;
ADDRLP4 4
CNSTF4 3231711232
ASGNF4
LABELV $167
line 642
;641:
;642:	if ( rnd3 < 10 )
ADDRLP4 8
INDIRF4
CNSTF4 1092616192
GEF4 $169
line 643
;643:		rnd3 = 15;
ADDRLP4 8
CNSTF4 1097859072
ASGNF4
LABELV $169
line 644
;644:	if ( rnd3 > 30 )
ADDRLP4 8
INDIRF4
CNSTF4 1106247680
LEF4 $171
line 645
;645:		rnd3 = 25;
ADDRLP4 8
CNSTF4 1103626240
ASGNF4
LABELV $171
line 647
;646:
;647:	self->s.v.velocity[0] = rnd1;
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 0
INDIRF4
ASGNF4
line 648
;648:	self->s.v.velocity[1] = rnd2;
ADDRGP4 self
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 649
;649:	self->s.v.velocity[2] = rnd3;
ADDRGP4 self
INDIRP4
CNSTI4 188
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 651
;650:
;651:	self->s.v.nextthink = g_globalvars.time + 0.5;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 652
;652:	self->s.v.think = ( func_t ) bubble_bob;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 bubble_bob
CVPU4 4
CVUI4 4
ASGNI4
line 653
;653:}
LABELV $156
endproc bubble_bob 32 4
export viewthing
proc viewthing 4 8
line 664
;654:
;655:/*~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>
;656:~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~<~>~*/
;657:
;658:/*QUAKED viewthing (0 .5 .8) (-8 -8 -8) (8 8 8)
;659:
;660:Just for the debugging level.  Don't use
;661:*/
;662:
;663:void viewthing(  )
;664:{
line 665
;665:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $175
line 666
;666:	{
line 667
;667:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 668
;668:		return;
ADDRGP4 $174
JUMPV
LABELV $175
line 670
;669:	}
;670:	self->s.v.movetype = MOVETYPE_NONE;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 671
;671:	self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 672
;672:	trap_precache_model( "progs/player.mdl" );
ADDRGP4 $177
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 673
;673:	setmodel( self, "progs/player.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $177
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 674
;674:}
LABELV $174
endproc viewthing 4 8
export func_wall_use
proc func_wall_use 4 0
line 687
;675:
;676:/*
;677:==============================================================================
;678:
;679:SIMPLE BMODELS
;680:
;681:==============================================================================
;682:*/
;683:
;684:
;685:
;686:void func_wall_use(  )
;687:{				// change to alternate textures
line 688
;688:	self->s.v.frame = 1 - self->s.v.frame;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTF4 1065353216
ADDRLP4 0
INDIRP4
INDIRF4
SUBF4
ASGNF4
line 689
;689:}
LABELV $178
endproc func_wall_use 4 0
export SP_func_wall
proc SP_func_wall 8 8
line 696
;690:
;691:
;692:/*QUAKED func_wall (0 .5 .8) ?
;693:This is just a solid wall if not inhibitted
;694:*/
;695:void SP_func_wall(  )
;696:{
line 697
;697:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $180
line 698
;698:	{
line 699
;699:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 700
;700:		return;
ADDRGP4 $179
JUMPV
LABELV $180
line 702
;701:	}
;702:	SetVector( self->s.v.angles, 0, 0, 0 );
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
line 703
;703:	self->s.v.movetype = MOVETYPE_PUSH;	// so it doesn't get pushed by anything
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1088421888
ASGNF4
line 704
;704:	self->s.v.solid = SOLID_BSP;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1082130432
ASGNF4
line 705
;705:	self->s.v.use = ( func_t ) func_wall_use;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 func_wall_use
CVPU4 4
CVUI4 4
ASGNI4
line 706
;706:	setmodel( self, self->s.v.model );
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
line 707
;707:}
LABELV $179
endproc SP_func_wall 8 8
export SP_func_illusionary
proc SP_func_illusionary 8 8
line 714
;708:
;709:
;710:/*QUAKED func_illusionary (0 .5 .8) ?
;711:A simple entity that looks solid but lets you walk through it.
;712:*/
;713:void SP_func_illusionary(  )
;714:{
line 715
;715:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $183
line 716
;716:	{
line 717
;717:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 718
;718:		return;
ADDRGP4 $182
JUMPV
LABELV $183
line 720
;719:	}
;720:	SetVector( self->s.v.angles, 0, 0, 0 );
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
line 721
;721:	self->s.v.movetype = MOVETYPE_NONE;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 722
;722:	self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 723
;723:	setmodel( self, self->s.v.model );
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
line 724
;724:	makestatic( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 makestatic
CALLV
pop
line 725
;725:}
LABELV $182
endproc SP_func_illusionary 8 8
export SP_func_episodegate
proc SP_func_episodegate 8 8
line 731
;726:
;727:/*QUAKED func_episodegate (0 .5 .8) ? E1 E2 E3 E4
;728:This bmodel will appear if the episode has allready been completed, so players can't reenter it.
;729:*/
;730:void SP_func_episodegate(  )
;731:{
line 732
;732:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $186
line 733
;733:	{
line 734
;734:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 735
;735:		return;
ADDRGP4 $185
JUMPV
LABELV $186
line 737
;736:	}
;737:	if ( !( ( int ) ( g_globalvars.serverflags ) & ( int ) ( self->s.v.spawnflags ) ) )
ADDRGP4 g_globalvars+144
INDIRF4
CVFI4 4
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
BANDI4
CNSTI4 0
NEI4 $188
line 738
;738:		return;		// can still enter episode
ADDRGP4 $185
JUMPV
LABELV $188
line 740
;739:
;740:	SetVector( self->s.v.angles, 0, 0, 0 );
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
line 741
;741:	self->s.v.movetype = MOVETYPE_PUSH;	// so it doesn't get pushed by anything
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1088421888
ASGNF4
line 742
;742:	self->s.v.solid = SOLID_BSP;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1082130432
ASGNF4
line 743
;743:	self->s.v.use = ( func_t ) func_wall_use;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 func_wall_use
CVPU4 4
CVUI4 4
ASGNI4
line 744
;744:	setmodel( self, self->s.v.model );
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
line 745
;745:}
LABELV $185
endproc SP_func_episodegate 8 8
export SP_func_bossgate
proc SP_func_bossgate 16 8
line 751
;746:
;747:/*QUAKED func_bossgate (0 .5 .8) ?
;748:This bmodel appears unless players have all of the episode sigils.
;749:*/
;750:void SP_func_bossgate(  )
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
NEI4 $192
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
ADDRGP4 $191
JUMPV
LABELV $192
line 757
;756:	}
;757:	if ( ( ( int ) ( g_globalvars.serverflags ) & 15 ) == 15 )
ADDRLP4 4
CNSTI4 15
ASGNI4
ADDRGP4 g_globalvars+144
INDIRF4
CVFI4 4
ADDRLP4 4
INDIRI4
BANDI4
ADDRLP4 4
INDIRI4
NEI4 $194
line 758
;758:		return;
ADDRGP4 $191
JUMPV
LABELV $194
line 759
;759:	if ( ( ( int ) ( g_globalvars.serverflags ) & 15 ) == 15 )
ADDRLP4 8
CNSTI4 15
ASGNI4
ADDRGP4 g_globalvars+144
INDIRF4
CVFI4 4
ADDRLP4 8
INDIRI4
BANDI4
ADDRLP4 8
INDIRI4
NEI4 $197
line 760
;760:		return;		// all episodes completed
ADDRGP4 $191
JUMPV
LABELV $197
line 761
;761:	SetVector( self->s.v.angles, 0, 0, 0 );
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
line 762
;762:	self->s.v.movetype = MOVETYPE_PUSH;	// so it doesn't get pushed by anything
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1088421888
ASGNF4
line 763
;763:	self->s.v.solid = SOLID_BSP;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1082130432
ASGNF4
line 764
;764:	self->s.v.use = ( func_t ) func_wall_use;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 func_wall_use
CVPU4 4
CVUI4 4
ASGNI4
line 765
;765:	setmodel( self, self->s.v.model );
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 766
;766:}
LABELV $191
endproc SP_func_bossgate 16 8
export SP_ambient_suck_wind
proc SP_ambient_suck_wind 8 24
line 772
;767:
;768://============================================================================
;769:/*QUAKED ambient_suck_wind (0.3 0.1 0.6) (-10 -10 -8) (10 10 8)
;770:*/
;771:void SP_ambient_suck_wind(  )
;772:{
line 773
;773:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $201
line 774
;774:	{
line 775
;775:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 776
;776:		return;
ADDRGP4 $200
JUMPV
LABELV $201
line 778
;777:	}
;778:	trap_precache_sound( "ambience/suck1.wav" );
ADDRGP4 $203
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 779
;779:	trap_ambientsound( PASSVEC3( self->s.v.origin ), "ambience/suck1.wav", 1, ATTN_STATIC );
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
ADDRGP4 $203
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 780
;780:}
LABELV $200
endproc SP_ambient_suck_wind 8 24
export SP_ambient_drone
proc SP_ambient_drone 8 24
line 785
;781:
;782:/*QUAKED ambient_drone (0.3 0.1 0.6) (-10 -10 -8) (10 10 8)
;783:*/
;784:void SP_ambient_drone(  )
;785:{
line 786
;786:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $205
line 787
;787:	{
line 788
;788:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 789
;789:		return;
ADDRGP4 $204
JUMPV
LABELV $205
line 791
;790:	}
;791:	trap_precache_sound( "ambience/drone6.wav" );
ADDRGP4 $207
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 792
;792:	trap_ambientsound( PASSVEC3( self->s.v.origin ), "ambience/drone6.wav", 0.5, ATTN_STATIC );
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
ADDRGP4 $207
ARGP4
CNSTF4 1056964608
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 793
;793:}
LABELV $204
endproc SP_ambient_drone 8 24
export SP_ambient_flouro_buzz
proc SP_ambient_flouro_buzz 8 24
line 798
;794:
;795:/*QUAKED ambient_flouro_buzz (0.3 0.1 0.6) (-10 -10 -8) (10 10 8)
;796:*/
;797:void SP_ambient_flouro_buzz(  )
;798:{
line 799
;799:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $209
line 800
;800:	{
line 801
;801:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 802
;802:		return;
ADDRGP4 $208
JUMPV
LABELV $209
line 804
;803:	}
;804:	trap_precache_sound( "ambience/buzz1.wav" );
ADDRGP4 $38
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 805
;805:	trap_ambientsound( PASSVEC3( self->s.v.origin ), "ambience/buzz1.wav", 1, ATTN_STATIC );
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
ADDRGP4 $38
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 806
;806:}
LABELV $208
endproc SP_ambient_flouro_buzz 8 24
export SP_ambient_drip
proc SP_ambient_drip 8 24
line 811
;807:
;808:/*QUAKED ambient_drip (0.3 0.1 0.6) (-10 -10 -8) (10 10 8)
;809:*/
;810:void SP_ambient_drip(  )
;811:{
line 812
;812:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $212
line 813
;813:	{
line 814
;814:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 815
;815:		return;
ADDRGP4 $211
JUMPV
LABELV $212
line 817
;816:	}
;817:	trap_precache_sound( "ambience/drip1.wav" );
ADDRGP4 $214
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 818
;818:	trap_ambientsound( PASSVEC3( self->s.v.origin ), "ambience/drip1.wav", 0.5, ATTN_STATIC );
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
ADDRGP4 $214
ARGP4
CNSTF4 1056964608
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 819
;819:}
LABELV $211
endproc SP_ambient_drip 8 24
export SP_ambient_comp_hum
proc SP_ambient_comp_hum 8 24
line 824
;820:
;821:/*QUAKED ambient_comp_hum (0.3 0.1 0.6) (-10 -10 -8) (10 10 8)
;822:*/
;823:void SP_ambient_comp_hum(  )
;824:{
line 825
;825:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $216
line 826
;826:	{
line 827
;827:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 828
;828:		return;
ADDRGP4 $215
JUMPV
LABELV $216
line 830
;829:	}
;830:	trap_precache_sound( "ambience/comp1.wav" );
ADDRGP4 $218
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 831
;831:	trap_ambientsound( PASSVEC3( self->s.v.origin ), "ambience/comp1.wav", 1, ATTN_STATIC );
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
ADDRGP4 $218
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 832
;832:}
LABELV $215
endproc SP_ambient_comp_hum 8 24
export SP_ambient_thunder
proc SP_ambient_thunder 8 24
line 837
;833:
;834:/*QUAKED ambient_thunder (0.3 0.1 0.6) (-10 -10 -8) (10 10 8)
;835:*/
;836:void SP_ambient_thunder(  )
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
NEI4 $220
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
ADDRGP4 $219
JUMPV
LABELV $220
line 843
;842:	}
;843:	trap_precache_sound( "ambience/thunder1.wav" );
ADDRGP4 $222
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 844
;844:	trap_ambientsound( PASSVEC3( self->s.v.origin ), "ambience/thunder1.wav", 0.5, ATTN_STATIC );
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
ADDRGP4 $222
ARGP4
CNSTF4 1056964608
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 845
;845:}
LABELV $219
endproc SP_ambient_thunder 8 24
export SP_ambient_light_buzz
proc SP_ambient_light_buzz 8 24
line 850
;846:
;847:/*QUAKED ambient_light_buzz (0.3 0.1 0.6) (-10 -10 -8) (10 10 8)
;848:*/
;849:void SP_ambient_light_buzz(  )
;850:{
line 851
;851:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $224
line 852
;852:	{
line 853
;853:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 854
;854:		return;
ADDRGP4 $223
JUMPV
LABELV $224
line 856
;855:	}
;856:	trap_precache_sound( "ambience/fl_hum1.wav" );
ADDRGP4 $32
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 857
;857:	trap_ambientsound( PASSVEC3( self->s.v.origin ), "ambience/fl_hum1.wav", 0.5, ATTN_STATIC );
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
ADDRGP4 $32
ARGP4
CNSTF4 1056964608
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 858
;858:}
LABELV $223
endproc SP_ambient_light_buzz 8 24
export SP_ambient_swamp1
proc SP_ambient_swamp1 8 24
line 863
;859:
;860:/*QUAKED ambient_swamp1 (0.3 0.1 0.6) (-10 -10 -8) (10 10 8)
;861:*/
;862:void SP_ambient_swamp1(  )
;863:{
line 864
;864:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $227
line 865
;865:	{
line 866
;866:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 867
;867:		return;
ADDRGP4 $226
JUMPV
LABELV $227
line 869
;868:	}
;869:	trap_precache_sound( "ambience/swamp1.wav" );
ADDRGP4 $229
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 870
;870:	trap_ambientsound( PASSVEC3( self->s.v.origin ), "ambience/swamp1.wav", 0.5, ATTN_STATIC );
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
ADDRGP4 $229
ARGP4
CNSTF4 1056964608
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 871
;871:}
LABELV $226
endproc SP_ambient_swamp1 8 24
export SP_ambient_swamp2
proc SP_ambient_swamp2 8 24
line 876
;872:
;873:/*QUAKED ambient_swamp2 (0.3 0.1 0.6) (-10 -10 -8) (10 10 8)
;874:*/
;875:void SP_ambient_swamp2(  )
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
NEI4 $231
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
ADDRGP4 $230
JUMPV
LABELV $231
line 882
;881:	}
;882:	trap_precache_sound( "ambience/swamp2.wav" );
ADDRGP4 $233
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 883
;883:	trap_ambientsound( PASSVEC3( self->s.v.origin ), "ambience/swamp2.wav", 0.5, ATTN_STATIC );
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
ADDRGP4 $233
ARGP4
CNSTF4 1056964608
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 884
;884:}
LABELV $230
endproc SP_ambient_swamp2 8 24
export noise_think
proc noise_think 28 20
line 889
;885:
;886://============================================================================
;887:
;888:void noise_think(  )
;889:{
line 890
;890:	self->s.v.nextthink = g_globalvars.time + 0.5;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 891
;891:	sound( self, 1, "enforcer/enfire.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $110
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
line 892
;892:	sound( self, 2, "enforcer/enfstop.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $95
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
line 893
;893:	sound( self, 3, "enforcer/sight1.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $236
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
line 894
;894:	sound( self, 4, "enforcer/sight2.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $237
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
line 895
;895:	sound( self, 5, "enforcer/sight3.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 $238
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
line 896
;896:	sound( self, 6, "enforcer/sight4.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 6
ARGI4
ADDRGP4 $239
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
line 897
;897:	sound( self, 7, "enforcer/pain1.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 7
ARGI4
ADDRGP4 $240
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
line 898
;898:}
LABELV $234
endproc noise_think 28 20
export SP_misc_noisemaker
proc SP_misc_noisemaker 8 4
line 907
;899:
;900:
;901:/*QUAKED misc_noisemaker (1 0.5 0) (-10 -10 -10) (10 10 10)
;902:
;903:For optimzation testing, starts a lot of sounds.
;904:*/
;905:
;906:void SP_misc_noisemaker(  )
;907:{
line 908
;908:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $242
line 909
;909:	{
line 910
;910:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 911
;911:		return;
ADDRGP4 $241
JUMPV
LABELV $242
line 913
;912:	}
;913:	trap_precache_sound( "enforcer/enfire.wav" );
ADDRGP4 $110
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 914
;914:	trap_precache_sound( "enforcer/enfstop.wav" );
ADDRGP4 $95
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 915
;915:	trap_precache_sound( "enforcer/sight1.wav" );
ADDRGP4 $236
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 916
;916:	trap_precache_sound( "enforcer/sight2.wav" );
ADDRGP4 $237
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 917
;917:	trap_precache_sound( "enforcer/sight3.wav" );
ADDRGP4 $238
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 918
;918:	trap_precache_sound( "enforcer/sight4.wav" );
ADDRGP4 $239
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 919
;919:	trap_precache_sound( "enforcer/pain1.wav" );
ADDRGP4 $240
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 920
;920:	trap_precache_sound( "enforcer/pain2.wav" );
ADDRGP4 $244
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 921
;921:	trap_precache_sound( "enforcer/death1.wav" );
ADDRGP4 $245
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 922
;922:	trap_precache_sound( "enforcer/idle1.wav" );
ADDRGP4 $246
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 924
;923:
;924:	self->s.v.nextthink = g_globalvars.time + 0.1 + g_random(  );
ADDRLP4 4
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 925
;925:	self->s.v.think = ( func_t ) noise_think;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 noise_think
CVPU4 4
CVUI4 4
ASGNI4
line 926
;926:}
LABELV $241
endproc SP_misc_noisemaker 8 4
import superspike_touch
import spike_touch
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
bss
export newmis
align 4
LABELV newmis
skip 4
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
byte 1 101
byte 1 110
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 47
byte 1 105
byte 1 100
byte 1 108
byte 1 101
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $245
byte 1 101
byte 1 110
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 47
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $244
byte 1 101
byte 1 110
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 47
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $240
byte 1 101
byte 1 110
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 47
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $239
byte 1 101
byte 1 110
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 47
byte 1 115
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 52
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $238
byte 1 101
byte 1 110
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 47
byte 1 115
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $237
byte 1 101
byte 1 110
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 47
byte 1 115
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $236
byte 1 101
byte 1 110
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 47
byte 1 115
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
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
byte 1 115
byte 1 119
byte 1 97
byte 1 109
byte 1 112
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $229
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 115
byte 1 119
byte 1 97
byte 1 109
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $222
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 116
byte 1 104
byte 1 117
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $218
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $214
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 100
byte 1 114
byte 1 105
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $207
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 100
byte 1 114
byte 1 111
byte 1 110
byte 1 101
byte 1 54
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $203
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 115
byte 1 117
byte 1 99
byte 1 107
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $177
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
LABELV $147
byte 1 98
byte 1 117
byte 1 98
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $145
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
LABELV $117
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $112
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 108
byte 1 97
byte 1 115
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $110
byte 1 101
byte 1 110
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 47
byte 1 101
byte 1 110
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $109
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 101
byte 1 110
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $95
byte 1 101
byte 1 110
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 47
byte 1 101
byte 1 110
byte 1 102
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $87
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 101
byte 1 120
byte 1 98
byte 1 111
byte 1 120
byte 1 50
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $83
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
LABELV $80
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 95
byte 1 101
byte 1 120
byte 1 112
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $79
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 98
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $75
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 95
byte 1 98
byte 1 111
byte 1 120
byte 1 0
align 1
LABELV $63
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $62
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $52
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $48
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $44
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $42
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 115
byte 1 95
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 115
byte 1 112
byte 1 114
byte 1 0
align 1
LABELV $38
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 98
byte 1 117
byte 1 122
byte 1 122
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $32
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 102
byte 1 108
byte 1 95
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
LABELV $15
byte 1 97
byte 1 0
align 1
LABELV $14
byte 1 109
byte 1 0
