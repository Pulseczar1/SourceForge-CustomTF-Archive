export trigger_jumper_touch
code
proc trigger_jumper_touch 24 20
file "..\src\megatf\map_ents.c"
line 35
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
;21: *  $Id: map_ents.c,v 1.00 2006/09/15 XavioR Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:void train_blocked();
;26:void train_use();
;27:void func_train_find();
;28://void blocker_use();
;29:
;30:/*=====================
;31:		MegaTF Map Entities
;32:			===================*/
;33:// jumppad (engbatxr, etc)
;34:void trigger_jumper_touch ( )
;35:{
line 38
;36:	gedict_t *finder;
;37:
;38:	if ( !Activated( self, other ) )
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
NEI4 $12
line 39
;39:	{
line 40
;40:		if ( self->else_goal )
ADDRGP4 self
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $11
line 41
;41:		{
line 42
;42:			finder = Findgoal( self->else_goal );
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
line 43
;43:			if ( finder)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $11
line 44
;44:				DoResults ( finder, other, ( self->goal_result & 2));
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 1136
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CVIF4 4
ARGF4
ADDRGP4 DoResults
CALLV
pop
line 45
;45:		}
line 46
;46:		return;
ADDRGP4 $11
JUMPV
LABELV $12
line 49
;47:	}
;48:
;49:	if ( other->s.v.classname == "grenade" || !streq( other->s.v.classname, "player" ) )
ADDRLP4 8
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRGP4 $20
CVPU4 4
EQU4 $22
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $21
ARGP4
ADDRLP4 12
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $18
LABELV $22
line 50
;50:		return;
ADDRGP4 $11
JUMPV
LABELV $18
line 52
;51:	else
;52:	{
line 53
;53:		if ( other->s.v.health > 0 && !self->armorclass )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $23
ADDRGP4 self
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
CNSTI4 0
NEI4 $23
line 54
;54:		{
line 55
;55:			other->s.v.velocity[2] = self->speed * 7;
ADDRGP4 other
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1088421888
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
MULF4
ASGNF4
line 56
;56:			if ( streq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $21
ARGP4
ADDRLP4 16
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $25
line 57
;57:			{
line 58
;58:				if ( other->fly_sound < g_globalvars.time )
ADDRGP4 other
INDIRP4
CNSTI4 776
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $27
line 59
;59:				{
line 60
;60:					other->fly_sound = g_globalvars.time + 1.5;
ADDRGP4 other
INDIRP4
CNSTI4 776
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1069547520
ADDF4
ASGNF4
line 61
;61:					if ( !( ( int ) self->s.v.spawnflags & 2 ) )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $31
line 62
;62:						sound ( other, 0, "misc/boing.wav", 1, 1);
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $33
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
LABELV $31
line 63
;63:				}
LABELV $27
line 64
;64:			}
LABELV $25
line 65
;65:		}
LABELV $23
line 66
;66:	}
line 67
;67:	if ( (int) self->s.v.spawnflags & 1 )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $34
line 68
;68:		dremove ( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
LABELV $34
line 69
;69:}
LABELV $11
endproc trigger_jumper_touch 24 20
export trigger_jumper
proc trigger_jumper 4 4
line 72
;70:
;71:void trigger_jumper ( )
;72:{
line 73
;73:	if ( CheckExistence ( ) == 0 )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $37
line 74
;74:	{
line 75
;75:		dremove ( self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 76
;76:		return;
ADDRGP4 $36
JUMPV
LABELV $37
line 79
;77:	}
;78:
;79:	InitTrigger ( );
ADDRGP4 InitTrigger
CALLV
pop
line 80
;80:	trap_precache_sound ( "misc/boing.wav");
ADDRGP4 $33
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 81
;81:	self->s.v.touch = ( func_t ) trigger_jumper_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 trigger_jumper_touch
CVPU4 4
CVUI4 4
ASGNI4
line 82
;82:	if ( !self->speed )
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
CNSTF4 0
NEF4 $39
line 83
;83:		self->speed = 1000;
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
CNSTF4 1148846080
ASGNF4
LABELV $39
line 84
;84:}
LABELV $36
endproc trigger_jumper 4 4
export blocker_use
proc blocker_use 16 20
line 90
;85:
;86:/*
;87:		Glass
;88:					*/
;89:void blocker_use() 
;90:{
line 91
;91:	if (!(self->state ))
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
NEI4 $42
line 92
;92:	{
line 93
;93:		self->state  = 1;
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 94
;94:		setorigin(self, self->s.v.origin[0] - 8000,self->s.v.origin[1] - 8000,self->s.v.origin[2] - 8000);// '8000 8000 8000');
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
CNSTF4 1174011904
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 95
;95:		sound(self, 2, self->s.v.noise1, 1, 1);
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 508
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
line 96
;96:	}
ADDRGP4 $43
JUMPV
LABELV $42
line 98
;97:	else
;98:	{
line 99
;99:		self->state  = 0;
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 0
ASGNI4
line 100
;100:		setorigin(self, self->s.v.origin[0] + 8000,self->s.v.origin[1],self->s.v.origin[2]);//'8000 8000 8000');
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
CNSTF4 1174011904
ADDF4
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
line 101
;101:		sound(self, 2, self->s.v.noise, 1, 1);
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
line 102
;102:	}
LABELV $43
line 103
;103:}
LABELV $41
endproc blocker_use 16 20
export glass_pain
proc glass_pain 4 0
line 106
;104:
;105:void glass_pain(gedict_t* attacker, float damage) 
;106:{
line 107
;107:	if ((int)(self->s.v.spawnflags) & 8)
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $45
line 108
;108:	{
line 109
;109:		self->s.v.health = self->s.v.max_health;
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
line 110
;110:	}
LABELV $45
line 111
;111:}
LABELV $44
endproc glass_pain 4 0
export glass_die
proc glass_die 72 28
line 114
;112:
;113:void glass_die() 
;114:{
ADDRGP4 $49
JUMPV
LABELV $48
line 118
;115:	gedict_t* new;
;116:	vec3_t tmpvec;
;117:	while (self->color > 0)
;118:	{
line 119
;119:		new = spawn();
ADDRLP4 16
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 120
;120:		VectorCopy(self->s.v.origin,new->s.v.origin);
ADDRLP4 20
CNSTI4 156
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
ADDRLP4 24
CNSTI4 160
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
INDIRF4
ASGNF4
ADDRLP4 28
CNSTI4 164
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
INDIRF4
ASGNF4
line 121
;121:		if (g_random() < 0.5)
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 20
INDIRF4
CNSTF4 1056964608
GEF4 $51
line 122
;122:		{
line 123
;123:			setmodel(new, "progs/glass2.mdl");
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $53
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 124
;124:		}
ADDRGP4 $52
JUMPV
LABELV $51
line 126
;125:		else
;126:		{
line 127
;127:			setmodel(new, "progs/glass1.mdl");
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $54
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 128
;128:		}
LABELV $52
line 129
;129:		setsize(new ,0, 0, 0 ,0, 0, 0);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 130
;130:		if (self->height != 100)
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
INDIRF4
CNSTF4 1120403456
EQF4 $55
line 131
;131:		{
line 132
;132:			new->s.v.velocity[0] = 70 * crandom();
ADDRLP4 28
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1116471296
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 133
;133:			new->s.v.velocity[1] = 70 * crandom();
ADDRLP4 32
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1116471296
ADDRLP4 32
INDIRF4
MULF4
ASGNF4
line 134
;134:			new->s.v.velocity[2] = 140 + 70 * g_random();
ADDRLP4 36
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1116471296
ADDRLP4 36
INDIRF4
MULF4
CNSTF4 1124859904
ADDF4
ASGNF4
line 135
;135:		}
ADDRGP4 $56
JUMPV
LABELV $55
line 137
;136:		else
;137:		{
line 138
;138:			new->s.v.velocity[0] = 400 * crandom();
ADDRLP4 28
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1137180672
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 139
;139:			new->s.v.velocity[1] = 400 * crandom();
ADDRLP4 32
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1137180672
ADDRLP4 32
INDIRF4
MULF4
ASGNF4
line 140
;140:			new->s.v.velocity[2] = 140 + 70 * g_random();
ADDRLP4 36
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1116471296
ADDRLP4 36
INDIRF4
MULF4
CNSTF4 1124859904
ADDF4
ASGNF4
line 141
;141:		}
LABELV $56
line 142
;142:		new->s.v.movetype = MOVETYPE_BOUNCE;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1092616192
ASGNF4
line 143
;143:		new->s.v.solid = SOLID_BBOX;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 144
;144:		new->s.v.avelocity[0] = g_random() * 600;
ADDRLP4 28
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 1142292480
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 145
;145:		new->s.v.avelocity[1] = g_random() * 600;
ADDRLP4 32
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 1142292480
ADDRLP4 32
INDIRF4
MULF4
ASGNF4
line 146
;146:		new->s.v.avelocity[2] = g_random() * 600;
ADDRLP4 36
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 1142292480
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
line 147
;147:		new->s.v.nextthink = g_globalvars.time + 2 + g_random() * 3;
ADDRLP4 40
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1073741824
ADDF4
CNSTF4 1077936128
ADDRLP4 40
INDIRF4
MULF4
ADDF4
ASGNF4
line 148
;148:		new->s.v.think = (func_t) SUB_Remove;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 149
;149:		VectorAdd(self->s.v.origin, self->s.v.mins, self->s.v.absmin);
ADDRLP4 44
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 48
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 120
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 52
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 124
ADDP4
ADDRLP4 52
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ADDF4
ASGNF4
line 150
;150:		VectorAdd( self->s.v.origin, self->s.v.maxs, self->s.v.absmax );
ADDRLP4 44
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 128
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 48
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 132
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 52
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 136
ADDP4
ADDRLP4 52
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
ADDF4
ASGNF4
line 151
;151:		tmpvec[0] = self->s.v.absmin[0] + g_random() * (self->s.v.absmax[0] - self->s.v.absmin[0]);
ADDRLP4 44
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 48
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
ADDRLP4 44
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 152
;152:		tmpvec[1] = self->s.v.absmin[1] + g_random() * (self->s.v.absmax[1] - self->s.v.absmin[1]);
ADDRLP4 52
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 56
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4+4
ADDRGP4 self
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 132
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 153
;153:		tmpvec[2] = self->s.v.absmin[2] + g_random() * (self->s.v.absmax[2] - self->s.v.absmin[2]);
ADDRLP4 60
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 64
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4+8
ADDRGP4 self
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
ADDRLP4 60
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 136
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 154
;154:		setorigin(new, PASSVEC3(tmpvec));
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4+4
INDIRF4
ARGF4
ADDRLP4 4+8
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 155
;155:		self->color = self->color - 1;
ADDRLP4 68
ADDRGP4 self
INDIRP4
CNSTI4 1796
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 156
;156:	}
LABELV $49
line 117
ADDRGP4 self
INDIRP4
CNSTI4 1796
ADDP4
INDIRI4
CNSTI4 0
GTI4 $48
line 157
;157:	if (self->s.v.noise2)
ADDRGP4 self
INDIRP4
CNSTI4 512
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $62
line 158
;158:	{
line 159
;159:		if ( trap_pointcontents(PASSVEC3(self->s.v.origin)) == -3)
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
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
ADDRLP4 20
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 -3
NEI4 $64
line 160
;160:		{
line 161
;161:			sound(self, 2, "effects/rcksplsh.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $66
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
line 162
;162:		}
ADDRGP4 $65
JUMPV
LABELV $64
line 164
;163:		else
;164:		{
line 165
;165:			sound(self, 2, self->s.v.noise2, 1, 1);
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 512
ADDP4
INDIRP4
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
line 166
;166:		}
LABELV $65
line 167
;167:	}
LABELV $62
line 168
;168: ent_remove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
line 169
;169:}
LABELV $47
endproc glass_die 72 28
export func_glass
proc func_glass 40 28
line 173
;170:
;171://glass (windows)
;172:void func_glass() 
;173:{
line 175
;174:	vec3_t tmpvec;
;175:	self->s.v.movetype = MOVETYPE_PUSH;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1088421888
ASGNF4
line 176
;176:	self->s.v.solid = SOLID_BSP;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1082130432
ASGNF4
line 177
;177:	self->mdl = self->s.v.model ;
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
line 178
;178:	setmodel(self, self->s.v.model );
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
line 179
;179:	setsize(self, PASSVEC3( self->s.v.mins ), PASSVEC3( self->s.v.maxs ));
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 180
;180:	setorigin(self, PASSVEC3(self->s.v.origin));
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
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
line 181
;181:	self->s.v.model = "";
ADDRGP4 self
INDIRP4
CNSTI4 220
ADDP4
ADDRGP4 $68
ASGNP4
line 182
;182:	trap_precache_sound("misc/null.wav");
ADDRGP4 $69
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 183
;183:	if (self->s.v.health > 0)
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $70
line 184
;184:	{
line 185
;185:		if (!(self->color))
ADDRGP4 self
INDIRP4
CNSTI4 1796
ADDP4
INDIRI4
CNSTI4 0
NEI4 $72
line 186
;186:		{
line 187
;187:			VectorSubtract(self->s.v.maxs, self->s.v.mins, tmpvec);
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 32
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 36
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
SUBF4
ASGNF4
line 188
;188:			tmpvec[0]=tmpvec[0]*0.031;tmpvec[1]=tmpvec[1]*0.031;tmpvec[2]=tmpvec[2]*0.031;
ADDRLP4 0
CNSTF4 1023275958
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+4
CNSTF4 1023275958
ADDRLP4 0+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+8
CNSTF4 1023275958
ADDRLP4 0+8
INDIRF4
MULF4
ASGNF4
line 189
;189:			if (tmpvec[0] < 1)
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
GEF4 $80
line 190
;190:			{
line 191
;191:				tmpvec[0] = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 192
;192:			}
LABELV $80
line 193
;193:			if (tmpvec[1] < 1)
ADDRLP4 0+4
INDIRF4
CNSTF4 1065353216
GEF4 $82
line 194
;194:			{
line 195
;195:				tmpvec[1] = 1;
ADDRLP4 0+4
CNSTF4 1065353216
ASGNF4
line 196
;196:			}
LABELV $82
line 197
;197:			if (tmpvec[2] < 1)
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
GEF4 $86
line 198
;198:			{
line 199
;199:				tmpvec[2] = 1;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 200
;200:			}
LABELV $86
line 201
;201:			self->color = tmpvec[0] * tmpvec[1] * tmpvec[2];
ADDRGP4 self
INDIRP4
CNSTI4 1796
ADDP4
ADDRLP4 0
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ADDRLP4 0+8
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 202
;202:		}
ADDRGP4 $73
JUMPV
LABELV $72
line 204
;203:		else
;204:		{
line 205
;205:			if (self->color == -1)
ADDRGP4 self
INDIRP4
CNSTI4 1796
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $92
line 206
;206:			{
line 207
;207:				self->color = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1796
ADDP4
CNSTI4 0
ASGNI4
line 208
;208:			}
LABELV $92
line 209
;209:		}
LABELV $73
line 210
;210:		if (self->color > 16)
ADDRGP4 self
INDIRP4
CNSTI4 1796
ADDP4
INDIRI4
CNSTI4 16
LEI4 $94
line 211
;211:		{
line 212
;212:			self->color = 16;
ADDRGP4 self
INDIRP4
CNSTI4 1796
ADDP4
CNSTI4 16
ASGNI4
line 213
;213:		}
LABELV $94
line 214
;214:		self->s.v.takedamage = 1;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 1065353216
ASGNF4
line 215
;215:		self->s.v.max_health = self->s.v.health;
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 416
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ASGNF4
line 216
;216:		self->th_die = glass_die;
ADDRGP4 self
INDIRP4
CNSTI4 812
ADDP4
ADDRGP4 glass_die
ASGNP4
line 217
;217:		self->th_pain = glass_pain;
ADDRGP4 self
INDIRP4
CNSTI4 816
ADDP4
ADDRGP4 glass_pain
ASGNP4
line 218
;218:	 trap_precache_model("progs/glass1.mdl");
ADDRGP4 $54
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 219
;219:	 trap_precache_model("progs/glass2.mdl");
ADDRGP4 $53
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 220
;220:	}
LABELV $70
line 221
;221:	if (self->s.v.target)
ADDRGP4 self
INDIRP4
CNSTI4 460
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $96
line 222
;222:	{
line 223
;223:		if (!(self->speed ))
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
CNSTF4 0
NEF4 $98
line 224
;224:		{
line 225
;225:			self->speed  = 100;
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
CNSTF4 1120403456
ASGNF4
line 226
;226:		}
LABELV $98
line 227
;227:		if (!(self->dmg ))
ADDRGP4 self
INDIRP4
CNSTI4 716
ADDP4
INDIRF4
CNSTF4 0
NEF4 $100
line 228
;228:		{
line 229
;229:			self->dmg  = 2;
ADDRGP4 self
INDIRP4
CNSTI4 716
ADDP4
CNSTF4 1073741824
ASGNF4
line 230
;230:		}
LABELV $100
line 231
;231:		if (self->s.v.sounds == 1)
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $102
line 232
;232:		{
line 233
;233:			if (!(self->s.v.noise))
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $104
line 234
;234:			{
line 235
;235:				self->s.v.noise = "plats/train2.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $106
ASGNP4
line 236
;236:			}
LABELV $104
line 237
;237:			if (!(self->s.v.noise1))
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $107
line 238
;238:			{
line 239
;239:				self->s.v.noise1 = "plats/train1.wav";
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
ADDRGP4 $109
ASGNP4
line 240
;240:			}
LABELV $107
line 241
;241:		 trap_precache_sound(self->s.v.noise);
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 242
;242:		 trap_precache_sound(self->s.v.noise1);
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 243
;243:		}
LABELV $102
line 244
;244:		self->cnt = 1;
ADDRGP4 self
INDIRP4
CNSTI4 692
ADDP4
CNSTF4 1065353216
ASGNF4
line 245
;245:		self->s.v.blocked = (func_t) train_blocked;
ADDRGP4 self
INDIRP4
CNSTI4 284
ADDP4
ADDRGP4 train_blocked
CVPU4 4
CVUI4 4
ASGNI4
line 246
;246:		self->s.v.use = ( func_t ) train_use;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 train_use
CVPU4 4
CVUI4 4
ASGNI4
line 247
;247:		self->s.v.classname  = "train";
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $110
ASGNP4
line 248
;248:		self->s.v.think = (func_t) func_train_find;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 func_train_find
CVPU4 4
CVUI4 4
ASGNI4
line 249
;249:		self->s.v.nextthink = self->s.v.ltime + 0.6;
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
CNSTF4 1058642330
ADDF4
ASGNF4
line 250
;250:	}
ADDRGP4 $97
JUMPV
LABELV $96
line 252
;251:	else
;252:	{
line 253
;253:		self->s.v.use = (func_t) blocker_use;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 blocker_use
CVPU4 4
CVUI4 4
ASGNI4
line 254
;254:		if ((int)(self->s.v.spawnflags) & 4)
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $111
line 255
;255:		{
line 256
;256:			self->state  = 0;
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 0
ASGNI4
line 257
;257:			setorigin(self, self->s.v.origin[0] + 800, self->s.v.origin[1] + 800, self->s.v.origin[2] + 800);// + '8000 8000 8000');
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
CNSTF4 1145569280
ASGNF4
ADDRLP4 28
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 258
;258:		}
ADDRGP4 $112
JUMPV
LABELV $111
line 260
;259:		else
;260:		{
line 261
;261:			self->state  = 1;
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 262
;262:			if (self->s.v.noise1)
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $113
line 263
;263:			{
line 264
;264:				sound(self, 2, self->s.v.noise1, 1, 1);
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
CNSTI4 508
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
line 265
;265:			}
LABELV $113
line 266
;266:		}
LABELV $112
line 267
;267:	}
LABELV $97
line 268
;268:	if (!(self->s.v.noise))
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $115
line 269
;269:	{
line 270
;270:		self->s.v.noise = "misc/null.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $69
ASGNP4
line 271
;271:	}
LABELV $115
line 272
;272:	if (!(self->s.v.noise1))
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $117
line 273
;273:	{
line 274
;274:		self->s.v.noise1 = "misc/null.wav";
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
ADDRGP4 $69
ASGNP4
line 275
;275:	}
LABELV $117
line 276
;276:	if (!(self->s.v.noise2))
ADDRGP4 self
INDIRP4
CNSTI4 512
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $119
line 277
;277:	{
line 278
;278:		self->s.v.noise2 = "effects/shatter.wav";
ADDRGP4 self
INDIRP4
CNSTI4 512
ADDP4
ADDRGP4 $121
ASGNP4
line 279
;279:	}
LABELV $119
line 280
;280: trap_precache_sound(self->s.v.noise);
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 281
;281: trap_precache_sound(self->s.v.noise1);
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 282
;282: trap_precache_sound(self->s.v.noise2);
ADDRGP4 self
INDIRP4
CNSTI4 512
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 283
;283:}
LABELV $67
endproc func_glass 40 28
export ambient_sound
proc ambient_sound 8 24
line 289
;284:
;285:/*
;286:		Ambient Sounds
;287:							*/
;288:void ambient_sound() 
;289:{
line 290
;290:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $123
line 291
;291:	{
line 292
;292:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 293
;293:		return;
ADDRGP4 $122
JUMPV
LABELV $123
line 295
;294:	}
;295:	if (!(self->s.v.noise))
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $125
line 296
;296:	{
line 297
;297:		G_Error("ambient_sound without noise");
ADDRGP4 $127
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 298
;298:	}
LABELV $125
line 299
;299:	if (!(self->volume))
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CNSTI4 0
NEI4 $128
line 300
;300:	{
line 301
;301:		self->volume = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
CNSTI4 1
ASGNI4
line 302
;302:	}
LABELV $128
line 303
;303: trap_precache_sound(self->s.v.noise);
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 304
;304:	if ((int)(self->s.v.spawnflags) == 4)
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 4
NEI4 $130
line 305
;305:	{
line 306
;306:	 trap_ambientsound(PASSVEC3(self->s.v.origin), self->s.v.noise, self->volume, 0);
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
ADDRLP4 4
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 307
;307:	}
ADDRGP4 $131
JUMPV
LABELV $130
line 309
;308:	else
;309:	{
line 310
;310:	 trap_ambientsound(PASSVEC3(self->s.v.origin), self->s.v.noise, self->volume, 1);
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
ADDRLP4 4
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 311
;311:	}
LABELV $131
line 312
;312:}
LABELV $122
endproc ambient_sound 8 24
export ambient_brook
proc ambient_brook 8 24
line 315
;313:
;314:void ambient_brook() 
;315:{
line 316
;316:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $133
line 317
;317:	{
line 318
;318:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 319
;319:		return;
ADDRGP4 $132
JUMPV
LABELV $133
line 321
;320:	}
;321:	if (!(self->volume))
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CNSTI4 0
NEI4 $135
line 322
;322:	{
line 323
;323:		self->volume = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
CNSTI4 1
ASGNI4
line 324
;324:	}
LABELV $135
line 325
;325: trap_precache_sound("ambience/brook.wav");
ADDRGP4 $137
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 326
;326: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/brook.wav", self->volume, 1);
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
ADDRGP4 $137
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 327
;327:}
LABELV $132
endproc ambient_brook 8 24
export ambient_jungle
proc ambient_jungle 8 24
line 330
;328:
;329:void ambient_jungle() 
;330:{
line 331
;331:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $139
line 332
;332:	{
line 333
;333:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 334
;334:		return;
ADDRGP4 $138
JUMPV
LABELV $139
line 336
;335:	}
;336:	if (!(self->volume))
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CNSTI4 0
NEI4 $141
line 337
;337:	{
line 338
;338:		self->volume = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
CNSTI4 1
ASGNI4
line 339
;339:	}
LABELV $141
line 340
;340: trap_precache_sound("ambience/jungle.wav");
ADDRGP4 $143
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 341
;341: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/jungle.wav", self->volume, 1);
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
ADDRGP4 $143
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 342
;342:}
LABELV $138
endproc ambient_jungle 8 24
export ambient_nightpond
proc ambient_nightpond 8 24
line 345
;343:
;344:void ambient_nightpond() 
;345:{
line 346
;346:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $145
line 347
;347:	{
line 348
;348:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 349
;349:		return;
ADDRGP4 $144
JUMPV
LABELV $145
line 351
;350:	}
;351:	if (!(self->volume))
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CNSTI4 0
NEI4 $147
line 352
;352:	{
line 353
;353:		self->volume = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
CNSTI4 1
ASGNI4
line 354
;354:	}
LABELV $147
line 355
;355: trap_precache_sound("ambience/nitepond.wav");
ADDRGP4 $149
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 356
;356: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/nitepond.wav", self->volume, 1);
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
ADDRGP4 $149
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 357
;357:}
LABELV $144
endproc ambient_nightpond 8 24
export ambient_alert
proc ambient_alert 8 24
line 360
;358:
;359:void ambient_alert() 
;360:{
line 361
;361:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $151
line 362
;362:	{
line 363
;363:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 364
;364:		return;
ADDRGP4 $150
JUMPV
LABELV $151
line 366
;365:	}
;366:	if (!(self->volume))
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CNSTI4 0
NEI4 $153
line 367
;367:	{
line 368
;368:		self->volume = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
CNSTI4 1
ASGNI4
line 369
;369:	}
LABELV $153
line 370
;370: trap_precache_sound("ambience/redalert.wav");
ADDRGP4 $155
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 371
;371: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/redalert.wav", self->volume, 1);
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
ADDRGP4 $155
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 372
;372:}
LABELV $150
endproc ambient_alert 8 24
export ambient_onboard
proc ambient_onboard 8 24
line 375
;373:
;374:void ambient_onboard() 
;375:{
line 376
;376:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $157
line 377
;377:	{
line 378
;378:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 379
;379:		return;
ADDRGP4 $156
JUMPV
LABELV $157
line 381
;380:	}
;381:	if (!(self->volume))
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CNSTI4 0
NEI4 $159
line 382
;382:	{
line 383
;383:		self->volume = 0.6;
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
CNSTI4 0
ASGNI4
line 384
;384:	}
LABELV $159
line 385
;385: trap_precache_sound("ambience/onboard.wav");
ADDRGP4 $161
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 386
;386:	if (!(self->height))
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
INDIRF4
CNSTF4 0
NEF4 $162
line 387
;387:	{
line 388
;388:	 trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/onboard.wav", self->volume, 0);
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
ADDRGP4 $161
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 389
;389:	}
ADDRGP4 $163
JUMPV
LABELV $162
line 391
;390:	else
;391:	{
line 392
;392:	 trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/onboard.wav", self->volume, 1);
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
ADDRGP4 $161
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 393
;393:	}
LABELV $163
line 394
;394:}
LABELV $156
endproc ambient_onboard 8 24
export ambient_unholy
proc ambient_unholy 8 24
line 397
;395:
;396:void ambient_unholy() 
;397:{
line 398
;398:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $165
line 399
;399:	{
line 400
;400:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 401
;401:		return;
ADDRGP4 $164
JUMPV
LABELV $165
line 403
;402:	}
;403:	if (!(self->volume))
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CNSTI4 0
NEI4 $167
line 404
;404:	{
line 405
;405:		self->volume = 0.8;
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
CNSTI4 0
ASGNI4
line 406
;406:	}
LABELV $167
line 407
;407: trap_precache_sound("ambience/unholy.wav");
ADDRGP4 $169
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 408
;408: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/unholy.wav", self->volume, 0);
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
ADDRGP4 $169
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 409
;409:}
LABELV $164
endproc ambient_unholy 8 24
export ambient_rocket_engine
proc ambient_rocket_engine 8 24
line 412
;410:
;411:void ambient_rocket_engine() 
;412:{
line 413
;413:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $171
line 414
;414:	{
line 415
;415:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 416
;416:		return;
ADDRGP4 $170
JUMPV
LABELV $171
line 418
;417:	}
;418:	if (!(self->volume))
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CNSTI4 0
NEI4 $173
line 419
;419:	{
line 420
;420:		self->volume = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
CNSTI4 1
ASGNI4
line 421
;421:	}
LABELV $173
line 422
;422: trap_precache_sound("ambience/onboard.wav");
ADDRGP4 $161
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 423
;423: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/onboard.wav", self->volume, 1);
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
ADDRGP4 $161
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 424
;424:}
LABELV $170
endproc ambient_rocket_engine 8 24
export ambient_high_wind
proc ambient_high_wind 8 24
line 427
;425:
;426:void ambient_high_wind() 
;427:{
line 428
;428:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $176
line 429
;429:	{
line 430
;430:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 431
;431:		return;
ADDRGP4 $175
JUMPV
LABELV $176
line 433
;432:	}
;433:	if (!(self->volume))
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CNSTI4 0
NEI4 $178
line 434
;434:	{
line 435
;435:		self->volume = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
CNSTI4 1
ASGNI4
line 436
;436:	}
LABELV $178
line 437
;437: trap_precache_sound("ambience/2windy.wav");
ADDRGP4 $180
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 438
;438: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/2windy.wav", self->volume, 1);
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
ADDRGP4 $180
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 439
;439:}
LABELV $175
endproc ambient_high_wind 8 24
export ambient_peakwind
proc ambient_peakwind 8 24
line 442
;440:
;441:void ambient_peakwind() 
;442:{
line 443
;443:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $182
line 444
;444:	{
line 445
;445:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 446
;446:		return;
ADDRGP4 $181
JUMPV
LABELV $182
line 448
;447:	}
;448:	if (!(self->volume))
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CNSTI4 0
NEI4 $184
line 449
;449:	{
line 450
;450:		self->volume = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
CNSTI4 1
ASGNI4
line 451
;451:	}
LABELV $184
line 452
;452: trap_precache_sound("ambience/peakwind.wav");
ADDRGP4 $186
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 453
;453: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/peakwind.wav", self->volume, 1);
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
ADDRGP4 $186
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 454
;454:}
LABELV $181
endproc ambient_peakwind 8 24
export ambient_chant
proc ambient_chant 8 24
line 457
;455:
;456:void ambient_chant() 
;457:{
line 458
;458:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $188
line 459
;459:	{
line 460
;460:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 461
;461:		return;
ADDRGP4 $187
JUMPV
LABELV $188
line 463
;462:	}
;463:	if (!(self->volume))
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CNSTI4 0
NEI4 $190
line 464
;464:	{
line 465
;465:		self->volume = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
CNSTI4 1
ASGNI4
line 466
;466:	}
LABELV $190
line 467
;467: trap_precache_sound("ambience/chant.wav");
ADDRGP4 $192
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 468
;468: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/chant.wav", self->volume, 1);
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
ADDRGP4 $192
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 469
;469:}
LABELV $187
endproc ambient_chant 8 24
export ambient_meadow
proc ambient_meadow 8 24
line 472
;470:
;471:void ambient_meadow() 
;472:{
line 473
;473:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $194
line 474
;474:	{
line 475
;475:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 476
;476:		return;
ADDRGP4 $193
JUMPV
LABELV $194
line 478
;477:	}
;478:	if (!(self->volume))
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CNSTI4 0
NEI4 $196
line 479
;479:	{
line 480
;480:		self->volume = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
CNSTI4 1
ASGNI4
line 481
;481:	}
LABELV $196
line 482
;482: trap_precache_sound("ambience/meadow.wav");
ADDRGP4 $198
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 483
;483: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/meadow.wav", self->volume, 1);
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
ADDRGP4 $198
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 484
;484:}
LABELV $193
endproc ambient_meadow 8 24
export ambient_ocean
proc ambient_ocean 8 24
line 487
;485:
;486:void ambient_ocean() 
;487:{
line 488
;488:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $200
line 489
;489:	{
line 490
;490:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 491
;491:		return;
ADDRGP4 $199
JUMPV
LABELV $200
line 493
;492:	}
;493:	if (!(self->volume))
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CNSTI4 0
NEI4 $202
line 494
;494:	{
line 495
;495:		self->volume = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
CNSTI4 1
ASGNI4
line 496
;496:	}
LABELV $202
line 497
;497: trap_precache_sound("ambience/ocean.wav");
ADDRGP4 $204
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 498
;498: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/ocean.wav", self->volume, 1);
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
ADDRGP4 $204
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 499
;499:}
LABELV $199
endproc ambient_ocean 8 24
export ambient_ice_moving
proc ambient_ice_moving 8 24
line 502
;500:
;501:void ambient_ice_moving() 
;502:{
line 503
;503:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $206
line 504
;504:	{
line 505
;505:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 506
;506:		return;
ADDRGP4 $205
JUMPV
LABELV $206
line 508
;507:	}
;508:	if (!(self->volume))
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CNSTI4 0
NEI4 $208
line 509
;509:	{
line 510
;510:		self->volume = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
CNSTI4 1
ASGNI4
line 511
;511:	}
LABELV $208
line 512
;512: trap_precache_sound("ambience/icemove.wav");
ADDRGP4 $210
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 513
;513: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/icemove.wav", self->volume, 1);
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
ADDRGP4 $210
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 514
;514:}
LABELV $205
endproc ambient_ice_moving 8 24
export ambient_eerie
proc ambient_eerie 8 24
line 517
;515:
;516:void ambient_eerie() 
;517:{
line 518
;518:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $212
line 519
;519:	{
line 520
;520:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 521
;521:		return;
ADDRGP4 $211
JUMPV
LABELV $212
line 523
;522:	}
;523:	if (!(self->volume))
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CNSTI4 0
NEI4 $214
line 524
;524:	{
line 525
;525:		self->volume = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
CNSTI4 1
ASGNI4
line 526
;526:	}
LABELV $214
line 527
;527: trap_precache_sound("ambience/eerie.wav");
ADDRGP4 $216
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 528
;528: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/eerie.wav", self->volume, 1);
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
ADDRGP4 $216
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 529
;529:}
LABELV $211
endproc ambient_eerie 8 24
export ambient_flagflap
proc ambient_flagflap 8 24
line 532
;530:
;531:void ambient_flagflap() 
;532:{
line 533
;533:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $218
line 534
;534:	{
line 535
;535:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 536
;536:		return;
ADDRGP4 $217
JUMPV
LABELV $218
line 538
;537:	}
;538:	if (!(self->volume))
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CNSTI4 0
NEI4 $220
line 539
;539:	{
line 540
;540:		self->volume = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
CNSTI4 1
ASGNI4
line 541
;541:	}
LABELV $220
line 542
;542: trap_precache_sound("ambience/flagflap.wav");
ADDRGP4 $222
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 543
;543: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/flagflap.wav", self->volume, 1);
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
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 544
;544:}
LABELV $217
endproc ambient_flagflap 8 24
export ambient_diesel
proc ambient_diesel 8 24
line 547
;545:
;546:void ambient_diesel() 
;547:{
line 548
;548:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $224
line 549
;549:	{
line 550
;550:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 551
;551:		return;
ADDRGP4 $223
JUMPV
LABELV $224
line 553
;552:	}
;553:	if (!(self->volume))
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CNSTI4 0
NEI4 $226
line 554
;554:	{
line 555
;555:		self->volume = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
CNSTI4 1
ASGNI4
line 556
;556:	}
LABELV $226
line 557
;557: trap_precache_sound("ambience/diesel.wav");
ADDRGP4 $228
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 558
;558: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/diesel.wav", self->volume, 1);
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
ADDRGP4 $228
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 559
;559:}
LABELV $223
endproc ambient_diesel 8 24
export ambient_chopper
proc ambient_chopper 8 24
line 562
;560:
;561:void ambient_chopper() 
;562:{
line 563
;563:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $230
line 564
;564:	{
line 565
;565:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 566
;566:		return;
ADDRGP4 $229
JUMPV
LABELV $230
line 568
;567:	}
;568:	if (!(self->volume))
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CNSTI4 0
NEI4 $232
line 569
;569:	{
line 570
;570:		self->volume = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
CNSTI4 1
ASGNI4
line 571
;571:	}
LABELV $232
line 572
;572: trap_precache_sound("ambience/chopper.wav");
ADDRGP4 $234
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 573
;573: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/chopper.wav", self->volume, 1);
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
ADDRGP4 $234
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 574
;574:}
LABELV $229
endproc ambient_chopper 8 24
export ambient_suck_wind
proc ambient_suck_wind 8 24
line 577
;575:
;576:void ambient_suck_wind() 
;577:{
line 578
;578:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $236
line 579
;579:	{
line 580
;580:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 581
;581:		return;
ADDRGP4 $235
JUMPV
LABELV $236
line 583
;582:	}
;583: trap_precache_sound("ambience/suck1.wav");
ADDRGP4 $238
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 584
;584: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/suck1.wav", 1, 3);
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
ADDRGP4 $238
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 585
;585:}
LABELV $235
endproc ambient_suck_wind 8 24
export ambient_drone
proc ambient_drone 8 24
line 588
;586:
;587:void ambient_drone() 
;588:{
line 589
;589:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $240
line 590
;590:	{
line 591
;591:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 592
;592:		return;
ADDRGP4 $239
JUMPV
LABELV $240
line 594
;593:	}
;594:	if (!(self->volume))
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CNSTI4 0
NEI4 $242
line 595
;595:	{
line 596
;596:		self->volume = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
CNSTI4 1
ASGNI4
line 597
;597:	}
LABELV $242
line 598
;598: trap_precache_sound("ambience/drone6.wav");
ADDRGP4 $244
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 599
;599: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/drone6.wav", self->volume, 2);
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
ADDRGP4 $244
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1073741824
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 600
;600:}
LABELV $239
endproc ambient_drone 8 24
export ambient_flouro_buzz
proc ambient_flouro_buzz 8 24
line 603
;601:
;602:void ambient_flouro_buzz() 
;603:{
line 604
;604:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $246
line 605
;605:	{
line 606
;606:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 607
;607:		return;
ADDRGP4 $245
JUMPV
LABELV $246
line 609
;608:	}
;609: trap_precache_sound("ambience/buzz1.wav");
ADDRGP4 $248
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 610
;610: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/buzz1.wav", 1, 3);
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
ADDRGP4 $248
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 611
;611:}
LABELV $245
endproc ambient_flouro_buzz 8 24
export ambient_drip
proc ambient_drip 8 24
line 614
;612:
;613:void ambient_drip() 
;614:{
line 615
;615:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $250
line 616
;616:	{
line 617
;617:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 618
;618:		return;
ADDRGP4 $249
JUMPV
LABELV $250
line 620
;619:	}
;620:	if (!(self->volume))
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CNSTI4 0
NEI4 $252
line 621
;621:	{
line 622
;622:		self->volume = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1800
ADDP4
CNSTI4 1
ASGNI4
line 623
;623:	}
LABELV $252
line 624
;624: trap_precache_sound("ambience/drip1.wav");
ADDRGP4 $254
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 625
;625: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/drip1.wav", self->volume, 3);
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
ADDRGP4 $254
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1800
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 626
;626:}
LABELV $249
endproc ambient_drip 8 24
export ambient_comp_hum
proc ambient_comp_hum 8 24
line 629
;627:
;628:void ambient_comp_hum() 
;629:{
line 630
;630:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $256
line 631
;631:	{
line 632
;632:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 633
;633:		return;
ADDRGP4 $255
JUMPV
LABELV $256
line 635
;634:	}
;635: trap_precache_sound("ambience/comp1.wav");
ADDRGP4 $258
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 636
;636: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/comp1.wav", 1, 3);
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
ADDRGP4 $258
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 637
;637:}
LABELV $255
endproc ambient_comp_hum 8 24
export ambient_thunder
proc ambient_thunder 12 24
line 640
;638:
;639:void ambient_thunder() 
;640:{
line 641
;641:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $260
line 642
;642:	{
line 643
;643:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 644
;644:		return;
ADDRGP4 $259
JUMPV
LABELV $260
line 646
;645:	}
;646: trap_precache_sound("ambience/thunder1.wav");
ADDRGP4 $262
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 647
;647: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/thunder1.wav", 1, 1);
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
ADDRGP4 $262
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
ADDRGP4 trap_ambientsound
CALLV
pop
line 648
;648:}
LABELV $259
endproc ambient_thunder 12 24
export ambient_light_buzz
proc ambient_light_buzz 8 24
line 651
;649:
;650:void ambient_light_buzz() 
;651:{
line 652
;652:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $264
line 653
;653:	{
line 654
;654:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 655
;655:		return;
ADDRGP4 $263
JUMPV
LABELV $264
line 657
;656:	}
;657: trap_precache_sound("ambience/fl_hum1.wav");
ADDRGP4 $266
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 658
;658: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/fl_hum1.wav", 0.8, 3);
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
ADDRGP4 $266
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 659
;659:}
LABELV $263
endproc ambient_light_buzz 8 24
export ambient_swamp1
proc ambient_swamp1 8 24
line 662
;660:
;661:void ambient_swamp1() 
;662:{
line 663
;663:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $268
line 664
;664:	{
line 665
;665:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 666
;666:		return;
ADDRGP4 $267
JUMPV
LABELV $268
line 668
;667:	}
;668: trap_precache_sound("ambience/swamp1.wav");
ADDRGP4 $270
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 669
;669: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/swamp1.wav", 0.8, 3);
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
ADDRGP4 $270
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 670
;670:}
LABELV $267
endproc ambient_swamp1 8 24
export ambient_swamp2
proc ambient_swamp2 8 24
line 673
;671:
;672:void ambient_swamp2() 
;673:{
line 674
;674:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $272
line 675
;675:	{
line 676
;676:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 677
;677:		return;
ADDRGP4 $271
JUMPV
LABELV $272
line 679
;678:	}
;679: trap_precache_sound("ambience/swamp2.wav");
ADDRGP4 $274
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 680
;680: trap_ambientsound(PASSVEC3(self->s.v.origin), "ambience/swamp2.wav", 0.6, 3);
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
ADDRGP4 $274
ARGP4
CNSTF4 1058642330
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_ambientsound
CALLV
pop
line 681
;681:}
LABELV $271
endproc ambient_swamp2 8 24
export BallTouch
proc BallTouch 24 20
line 685
;682:
;683:// SandBall!
;684:void BallTouch() 
;685:{
line 688
;686:	//vec3_t vtemp;
;687:
;688:	if (streq(other->s.v.classname, "player") && self->last_used <= g_globalvars.time)
ADDRGP4 other
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
EQI4 $276
ADDRGP4 self
INDIRP4
CNSTI4 1772
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 g_globalvars+124
INDIRF4
GTF4 $276
line 689
;689:	{
line 690
;690:		sound(self, 3, "zombie/z_fall.wav", 0.8, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $279
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 691
;691:		self->last_used = g_globalvars.time + 0.3;
ADDRGP4 self
INDIRP4
CNSTI4 1772
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1050253722
ADDF4
CVFI4 4
ASGNI4
line 692
;692:	}
LABELV $276
line 693
;693:	if (strneq(other->s.v.classname, "player"))
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $21
ARGP4
ADDRLP4 4
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $281
line 694
;694:	{
line 695
;695:		sound(self, 1, "zombie/z_hit.wav", 1, 1);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $283
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
line 696
;696:	}
LABELV $281
line 697
;697:	if (streq(other->s.v.classname, "player"))
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $21
ARGP4
ADDRLP4 8
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $284
line 698
;698:	{
line 699
;699:		makevectors(other->s.v.v_angle);
ADDRGP4 other
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 700
;700:		self->s.v.velocity[0] =
ADDRLP4 12
CNSTI4 180
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
ADDRGP4 other
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
CNSTF4 1120403456
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
ADDF4
CNSTF4 1128792064
ADDRGP4 g_globalvars+240
INDIRF4
MULF4
ADDF4
ASGNF4
line 702
;701:			other->s.v.velocity[0] + g_globalvars.v_forward[0] * 100 + g_globalvars.v_up[0] * 200;
;702:		self->s.v.velocity[1] =
ADDRLP4 16
CNSTI4 184
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ADDRGP4 other
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
CNSTF4 1120403456
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
ADDF4
CNSTF4 1128792064
ADDRGP4 g_globalvars+240+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 704
;703:			other->s.v.velocity[1] + g_globalvars.v_forward[1] * 100 + g_globalvars.v_up[1] * 200;
;704:		self->s.v.velocity[2] =
ADDRLP4 20
CNSTI4 188
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ADDRGP4 other
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
CNSTF4 1120403456
ADDRGP4 g_globalvars+228+8
INDIRF4
MULF4
ADDF4
CNSTF4 1128792064
ADDRGP4 g_globalvars+240+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 706
;705:			other->s.v.velocity[2] + g_globalvars.v_forward[2] * 100 + g_globalvars.v_up[2] * 200;
;706:		self->lastplayer = other;
ADDRGP4 self
INDIRP4
CNSTI4 1820
ADDP4
ADDRGP4 other
INDIRP4
ASGNP4
line 707
;707:	}
LABELV $284
line 708
;708:}
LABELV $275
endproc BallTouch 24 20
export BallCheck
proc BallCheck 0 0
line 711
;709:
;710:void BallCheck() 
;711:{
line 712
;712:	self->s.v.movetype = MOVETYPE_BOUNCE;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1092616192
ASGNF4
line 713
;713:	self->s.v.nextthink = g_globalvars.time + 15;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 714
;714:	self->s.v.effects = 0;
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 0
ASGNF4
line 715
;715:}
LABELV $296
endproc BallCheck 0 0
export ballstart
proc ballstart 4 4
line 718
;716:
;717:void ballstart() 
;718:{
line 719
;719:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $299
line 720
;720:	{
line 721
;721:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 722
;722:		return;
LABELV $299
line 724
;723:	}
;724:}
LABELV $298
endproc ballstart 4 4
export BallStart
proc BallStart 16 20
line 727
;725:
;726:void BallStart() 
;727:{
line 729
;728:	gedict_t* te;
;729:	sound(self, 3, "sandball/whistle.wav", 1, 0);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $302
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 sound
CALLV
pop
line 730
;730:	te = trap_find( world, FOFS( s.v.classname ), "ballstart" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $303
ARGP4
ADDRLP4 4
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRGP4 $305
JUMPV
LABELV $304
line 732
;731:	while (te)
;732:	{
line 733
;733:		setorigin(self, PASSVEC3(te->s.v.origin));
ADDRGP4 self
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
line 734
;734:		te = trap_find( te, FOFS( s.v.classname ), "ballstart" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $303
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 735
;735:	}
LABELV $305
line 731
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $304
line 736
;736:	self->s.v.nextthink = g_globalvars.time + 5;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 737
;737:	self->s.v.think = (func_t) BallCheck;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 BallCheck
CVPU4 4
CVUI4 4
ASGNI4
line 738
;738:	self->s.v.movetype = MOVETYPE_BOUNCE;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1092616192
ASGNF4
line 739
;739:	self->s.v.velocity[2] = 40;
ADDRGP4 self
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1109393408
ASGNF4
line 740
;740:}
LABELV $301
endproc BallStart 16 20
export ball
proc ball 24 28
line 743
;741:
;742:void ball() 
;743:{
line 744
;744:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $309
line 745
;745:	{
line 746
;746:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 747
;747:		return;
ADDRGP4 $308
JUMPV
LABELV $309
line 749
;748:	}
;749:	trap_precache_model("progs/s_light.spr");
ADDRGP4 $311
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 750
;750:	setmodel(self, "progs/s_light.spr");
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $311
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 751
;751:	self->s.v.movetype = MOVETYPE_NONE;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 752
;752:	setsize(self ,-16, -16, -14 ,16, 16, 10);
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
CNSTF4 3244294144
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
CNSTF4 1092616192
ARGF4
ADDRGP4 setsize
CALLV
pop
line 753
;753:	self->s.v.solid = SOLID_TRIGGER;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 754
;754:	self->s.v.touch = ( func_t ) BallTouch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 BallTouch
CVPU4 4
CVUI4 4
ASGNI4
line 755
;755:	self->s.v.classname  = "ball";
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $312
ASGNP4
line 756
;756:	self->s.v.think = (func_t) BallCheck;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 BallCheck
CVPU4 4
CVUI4 4
ASGNI4
line 757
;757:	self->s.v.nextthink = g_globalvars.time + 15;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 759
;758:	//self->s.v.oldorigin = self->s.v.origin;
;759:	SetVector( self->s.v.oldorigin, self->s.v.origin[0], self->s.v.origin[1], self->s.v.origin[2] );
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 168
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
CNSTI4 172
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
CNSTI4 176
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 760
;760:}
LABELV $308
endproc ball 24 28
export GoalTouch
proc GoalTouch 36 20
line 763
;761:
;762:void GoalTouch() 
;763:{
line 765
;764:	gedict_t *te;
;765:	te=world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
line 766
;766:	if (strneq( other->s.v.classname, "ball" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $312
ARGP4
ADDRLP4 4
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $315
line 767
;767:	{
line 768
;768:		return;
ADDRGP4 $314
JUMPV
LABELV $315
line 770
;769:	}
;770:	if (self->last_used > g_globalvars.time)
ADDRGP4 self
INDIRP4
CNSTI4 1772
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $317
line 771
;771:	{
line 772
;772:		return;
ADDRGP4 $314
JUMPV
LABELV $317
line 774
;773:	}
;774:	sound(self, 3, "sandball/goal.wav", 1, 0);
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $320
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 sound
CALLV
pop
line 775
;775:	self->last_used = g_globalvars.time + 10;
ADDRGP4 self
INDIRP4
CNSTI4 1772
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1092616192
ADDF4
CVFI4 4
ASGNI4
line 776
;776:	te = trap_find( world, FOFS( s.v.classname ), "player" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $21
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $323
JUMPV
LABELV $322
line 778
;777:	while ( te )
;778:	{
line 779
;779:		if (self->team_no == 2)
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 2
NEI4 $325
line 780
;780:		{
line 781
;781:			CenterPrint(te, "Score for Reds by %s\n", other->lastplayer->s.v.netname);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $327
ARGP4
ADDRGP4 other
INDIRP4
CNSTI4 1820
ADDP4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 782
;782:		}
ADDRGP4 $326
JUMPV
LABELV $325
line 784
;783:		else
;784:		{
line 785
;785:			CenterPrint(te, "Score for Blues by %s\n", other->lastplayer->s.v.netname);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $328
ARGP4
ADDRGP4 other
INDIRP4
CNSTI4 1820
ADDP4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 786
;786:		}
LABELV $326
line 787
;787:		if (te->team_no == self->team_no && self->team_no != 0)
ADDRLP4 12
CNSTI4 960
ASGNI4
ADDRLP4 16
ADDRGP4 self
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $329
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $329
line 788
;788:		{
line 789
;789:			te->real_frags = te->real_frags + self->s.v.frags;
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 1024
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 self
INDIRP4
CNSTI4 300
ADDP4
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 790
;790:			te->s.v.frags = te->s.v.frags + self->s.v.frags;
ADDRLP4 24
CNSTI4 300
ASGNI4
ADDRLP4 28
ADDRLP4 0
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
line 791
;791:			te->s.v.health = te->s.v.max_health;
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
line 792
;792:		}
LABELV $329
line 793
;793:		te = trap_find( te, FOFS( s.v.classname ), "player" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $21
ARGP4
ADDRLP4 20
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 794
;794:	}
LABELV $323
line 777
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $322
line 795
;795:	other->s.v.nextthink = g_globalvars.time + 10;
ADDRGP4 other
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 796
;796:	other->s.v.think = (func_t) BallStart;
ADDRGP4 other
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 BallStart
CVPU4 4
CVUI4 4
ASGNI4
line 797
;797:	other->s.v.movetype = MOVETYPE_FLYMISSILE;
ADDRGP4 other
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1091567616
ASGNF4
line 798
;798:	other->s.v.velocity[2] = 40;
ADDRGP4 other
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1109393408
ASGNF4
line 799
;799:	other->s.v.effects = self->team_no * 64;
ADDRGP4 other
INDIRP4
CNSTI4 232
ADDP4
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 6
LSHI4
CVIF4 4
ASGNF4
line 800
;800:}
LABELV $314
endproc GoalTouch 36 20
export sandball_goal
proc sandball_goal 16 28
line 803
;801:
;802:void sandball_goal() 
;803:{
line 804
;804:	if (CheckExistence() == 0)
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $333
line 805
;805:	{
line 806
;806:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 807
;807:		return;
ADDRGP4 $332
JUMPV
LABELV $333
line 809
;808:	}
;809: trap_precache_model("progs/null.mdl");
ADDRGP4 $335
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 810
;810: trap_precache_sound("sandball/goal.wav");
ADDRGP4 $320
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 811
;811: trap_precache_sound("sandball/whistle.wav");
ADDRGP4 $302
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 812
;812: trap_precache_sound("zombie/z_fall.wav");
ADDRGP4 $279
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 813
;813:	setmodel(self, "progs/null.mdl");
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $335
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 814
;814:	self->s.v.movetype = MOVETYPE_NONE;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 815
;815:	self->s.v.skin = self->team_no;
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
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
line 816
;816:	self->s.v.solid = SOLID_TRIGGER;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 817
;817:	setsize(self ,-35, -35, -14 ,35, 35, 50);
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 8
CNSTF4 3255566336
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 3244294144
ARGF4
ADDRLP4 12
CNSTF4 1108082688
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1112014848
ARGF4
ADDRGP4 setsize
CALLV
pop
line 818
;818:	self->s.v.effects = 0;
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 0
ASGNF4
line 819
;819:	self->s.v.touch = (func_t) GoalTouch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 GoalTouch
CVPU4 4
CVUI4 4
ASGNI4
line 820
;820:}อออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ
LABELV $332
endproc sandball_goal 16 28
import func_train_find
import train_use
import train_blocked
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
LABELV $335
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 110
byte 1 117
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $328
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $327
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 82
byte 1 101
byte 1 100
byte 1 115
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $320
byte 1 115
byte 1 97
byte 1 110
byte 1 100
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 47
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $312
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $311
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
LABELV $303
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $302
byte 1 115
byte 1 97
byte 1 110
byte 1 100
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 47
byte 1 119
byte 1 104
byte 1 105
byte 1 115
byte 1 116
byte 1 108
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $283
byte 1 122
byte 1 111
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 47
byte 1 122
byte 1 95
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $279
byte 1 122
byte 1 111
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 47
byte 1 122
byte 1 95
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $274
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
LABELV $270
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
LABELV $266
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
LABELV $262
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
LABELV $258
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
LABELV $254
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
LABELV $248
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
LABELV $244
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
LABELV $238
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
LABELV $234
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
byte 1 104
byte 1 111
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $228
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
byte 1 105
byte 1 101
byte 1 115
byte 1 101
byte 1 108
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
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 102
byte 1 108
byte 1 97
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $216
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 101
byte 1 101
byte 1 114
byte 1 105
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $210
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 105
byte 1 99
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $204
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 111
byte 1 99
byte 1 101
byte 1 97
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $198
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 109
byte 1 101
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $192
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
byte 1 104
byte 1 97
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $186
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 112
byte 1 101
byte 1 97
byte 1 107
byte 1 119
byte 1 105
byte 1 110
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $180
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 50
byte 1 119
byte 1 105
byte 1 110
byte 1 100
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $169
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 117
byte 1 110
byte 1 104
byte 1 111
byte 1 108
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $161
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 111
byte 1 110
byte 1 98
byte 1 111
byte 1 97
byte 1 114
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $155
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 114
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 101
byte 1 114
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $149
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 110
byte 1 105
byte 1 116
byte 1 101
byte 1 112
byte 1 111
byte 1 110
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $143
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 106
byte 1 117
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $137
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
byte 1 114
byte 1 111
byte 1 111
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $127
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 95
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 110
byte 1 111
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $121
byte 1 101
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 104
byte 1 97
byte 1 116
byte 1 116
byte 1 101
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $110
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $109
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 115
byte 1 47
byte 1 116
byte 1 114
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
LABELV $106
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 115
byte 1 47
byte 1 116
byte 1 114
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
LABELV $69
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
LABELV $68
byte 1 0
align 1
LABELV $66
byte 1 101
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 47
byte 1 114
byte 1 99
byte 1 107
byte 1 115
byte 1 112
byte 1 108
byte 1 115
byte 1 104
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $54
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 103
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 49
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $53
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 103
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $33
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 98
byte 1 111
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $21
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $20
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
