export plat_spawn_inside_trigger
code
proc plat_spawn_inside_trigger 100 28
file "..\src\plats.c"
line 35
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
;21: *  $Id: plats.c,v 1.3 2004/12/23 03:16:15 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:void    plat_center_touch(  );
;26:void    plat_outside_touch(  );
;27:void    plat_trigger_use(  );
;28:void    plat_go_up(  );
;29:void    plat_go_down(  );
;30:void    plat_crush(  );
;31:
;32:#define PLAT_LOW_TRIGGER 1
;33:
;34:void plat_spawn_inside_trigger(  )
;35:{
line 42
;36:	gedict_t *trigger;
;37:	vec3_t  tmin, tmax;
;38:
;39://
;40:// middle trigger
;41:// 
;42:	trigger = spawn(  );
ADDRLP4 28
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 43
;43:	trigger->s.v.touch = ( func_t ) plat_center_touch;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 plat_center_touch
CVPU4 4
CVUI4 4
ASGNI4
line 44
;44:	trigger->s.v.movetype = MOVETYPE_NONE;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 45
;45:	trigger->s.v.solid = SOLID_TRIGGER;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 46
;46:	trigger->s.v.enemy = EDICT_TO_PROG( self );
ADDRLP4 0
INDIRP4
CNSTI4 400
ADDP4
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 48
;47:
;48:	trigger->team_no = self->team_no;
ADDRLP4 32
CNSTI4 960
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
line 49
;49:	trigger->playerclass = self->playerclass;
ADDRLP4 36
CNSTI4 820
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
line 50
;50:	trigger->items_allowed = self->items_allowed;
ADDRLP4 40
CNSTI4 920
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
line 51
;51:	trigger->activate_goal_no = self->activate_goal_no;
ADDRLP4 44
CNSTI4 1172
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
line 52
;52:	trigger->inactivate_goal_no = self->inactivate_goal_no;
ADDRLP4 48
CNSTI4 1176
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
line 53
;53:	trigger->remove_goal_no = self->remove_goal_no;
ADDRLP4 52
CNSTI4 1180
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
line 54
;54:	trigger->restore_goal_no = self->restore_goal_no;
ADDRLP4 56
CNSTI4 1184
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
line 55
;55:	trigger->activate_group_no = self->activate_group_no;
ADDRLP4 60
CNSTI4 1188
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
line 56
;56:	trigger->inactivate_group_no = self->inactivate_group_no;
ADDRLP4 64
CNSTI4 1192
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
line 57
;57:	trigger->remove_group_no = self->remove_group_no;
ADDRLP4 68
CNSTI4 1196
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
line 58
;58:	trigger->restore_group_no = self->restore_group_no;
ADDRLP4 72
CNSTI4 1200
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
line 59
;59:	trigger->goal_activation = self->goal_activation;
ADDRLP4 76
CNSTI4 1128
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
line 60
;60:	trigger->goal_effects = self->goal_effects;
ADDRLP4 80
CNSTI4 1132
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 61
;61:	trigger->goal_result = self->goal_result;
ADDRLP4 84
CNSTI4 1136
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 62
;62:	trigger->goal_group = self->goal_group;
ADDRLP4 88
CNSTI4 1140
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 64
;63:
;64:	tmin[0] = self->s.v.mins[0] + 25;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1103626240
ADDF4
ASGNF4
line 65
;65:	tmin[1] = self->s.v.mins[1] + 25;
ADDRLP4 4+4
ADDRGP4 self
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1103626240
ADDF4
ASGNF4
line 66
;66:	tmin[2] = self->s.v.mins[2] + 0;
ADDRLP4 4+8
ADDRGP4 self
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
CNSTF4 0
ADDF4
ASGNF4
line 68
;67:
;68:	tmax[0] = self->s.v.maxs[0] - 25;
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
CNSTF4 1103626240
SUBF4
ASGNF4
line 69
;69:	tmax[1] = self->s.v.maxs[1] - 25;
ADDRLP4 16+4
ADDRGP4 self
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
CNSTF4 1103626240
SUBF4
ASGNF4
line 70
;70:	tmax[2] = self->s.v.maxs[2] + 8;
ADDRLP4 16+8
ADDRGP4 self
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 72
;71:
;72:	tmin[2] = tmax[2] - ( self->pos1[2] - self->pos2[2] + 8 );
ADDRLP4 92
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 620
ADDP4
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 632
ADDP4
INDIRF4
SUBF4
CNSTF4 1090519040
ADDF4
SUBF4
ASGNF4
line 74
;73:
;74:	if ( ( int ) ( self->s.v.spawnflags ) & PLAT_LOW_TRIGGER )
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $18
line 75
;75:		tmax[2] = tmin[2] + 8;
ADDRLP4 16+8
ADDRLP4 4+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
LABELV $18
line 77
;76:
;77:	if ( self->s.v.size[0] <= 50 )
ADDRGP4 self
INDIRP4
CNSTI4 260
ADDP4
INDIRF4
CNSTF4 1112014848
GTF4 $22
line 78
;78:	{
line 79
;79:		tmin[0] = ( self->s.v.mins[0] + self->s.v.maxs[0] ) / 2;
ADDRLP4 96
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 96
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ADDRLP4 96
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 80
;80:		tmax[0] = tmin[0] + 1;
ADDRLP4 16
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 81
;81:	}
LABELV $22
line 83
;82:
;83:	if ( self->s.v.size[1] <= 50 )
ADDRGP4 self
INDIRP4
CNSTI4 264
ADDP4
INDIRF4
CNSTF4 1112014848
GTF4 $24
line 84
;84:	{
line 85
;85:		tmin[1] = ( self->s.v.mins[1] + self->s.v.maxs[1] ) / 2;
ADDRLP4 96
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4+4
ADDRLP4 96
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ADDRLP4 96
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 86
;86:		tmax[1] = tmin[1] + 1;
ADDRLP4 16+4
ADDRLP4 4+4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 87
;87:	}
LABELV $24
line 89
;88:
;89:	setsize( trigger, PASSVEC3( tmin ), PASSVEC3( tmax ) );
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
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16+4
INDIRF4
ARGF4
ADDRLP4 16+8
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 90
;90:}
LABELV $11
endproc plat_spawn_inside_trigger 100 28
export plat_hit_top
proc plat_hit_top 12 20
line 94
;91:
;92:
;93:void plat_hit_top(  )
;94:{
line 95
;95:	sound( self, CHAN_VOICE, self->s.v.noise1, 1, ATTN_NORM );
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
line 96
;96:	self->state = STATE_TOP;
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 0
ASGNI4
line 97
;97:	self->s.v.think = ( func_t ) plat_go_down;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 plat_go_down
CVPU4 4
CVUI4 4
ASGNI4
line 98
;98:	self->s.v.nextthink = self->s.v.ltime + 3;
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
CNSTF4 1077936128
ADDF4
ASGNF4
line 99
;99:}
LABELV $33
endproc plat_hit_top 12 20
export plat_hit_bottom
proc plat_hit_bottom 8 20
line 102
;100:
;101:void plat_hit_bottom(  )
;102:{
line 103
;103:	sound( self, CHAN_VOICE, self->s.v.noise1, 1, ATTN_NORM );
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
line 104
;104:	self->state = STATE_BOTTOM;
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 105
;105:}
LABELV $34
endproc plat_hit_bottom 8 20
export plat_go_down
proc plat_go_down 12 20
line 108
;106:
;107:void plat_go_down(  )
;108:{
line 109
;109:	sound( self, CHAN_VOICE, self->s.v.noise, 1, ATTN_NORM );
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
CNSTI4 504
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
line 110
;110:	self->state = STATE_DOWN;
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 3
ASGNI4
line 111
;111:	SUB_CalcMove( self->pos2, self->speed, plat_hit_bottom );
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
ADDRGP4 plat_hit_bottom
ARGP4
ADDRGP4 SUB_CalcMove
CALLV
pop
line 112
;112:}
LABELV $35
endproc plat_go_down 12 20
export plat_go_up
proc plat_go_up 12 20
line 115
;113:
;114:void plat_go_up(  )
;115:{
line 116
;116:	sound( self, CHAN_VOICE, self->s.v.noise, 1, ATTN_NORM );
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
CNSTI4 504
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
line 117
;117:	self->state = STATE_UP;
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 2
ASGNI4
line 118
;118:	SUB_CalcMove( self->pos1, self->speed, plat_hit_top );
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
ADDRGP4 plat_hit_top
ARGP4
ADDRGP4 SUB_CalcMove
CALLV
pop
line 119
;119:}
LABELV $36
endproc plat_go_up 12 20
export plat_center_touch
proc plat_center_touch 20 12
line 122
;120:
;121:void plat_center_touch(  )
;122:{
line 125
;123:	gedict_t *te;
;124:
;125:	if ( strneq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $40
ARGP4
ADDRLP4 4
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $38
line 126
;126:		return;
ADDRGP4 $37
JUMPV
LABELV $38
line 127
;127:	if ( !other->playerclass )
ADDRGP4 other
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $41
line 128
;128:		return;
ADDRGP4 $37
JUMPV
LABELV $41
line 129
;129:	if ( !Activated( self, other ) )
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
NEI4 $43
line 130
;130:	{
line 131
;131:		if ( self->else_goal )
ADDRGP4 self
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $37
line 132
;132:		{
line 133
;133:			te = Findgoal( self->else_goal );
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
line 134
;134:			if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $37
line 135
;135:				AttemptToActivate( te, other, self );
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
line 136
;136:		}
line 137
;137:		return;
ADDRGP4 $37
JUMPV
LABELV $43
line 139
;138:	}
;139:	if ( other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $49
line 140
;140:		return;
ADDRGP4 $37
JUMPV
LABELV $49
line 142
;141:
;142:	self = PROG_TO_EDICT( self->s.v.enemy );
ADDRLP4 12
ADDRGP4 self
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 143
;143:	if ( self->state == STATE_BOTTOM )
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 1
NEI4 $51
line 144
;144:		plat_go_up(  );
ADDRGP4 plat_go_up
CALLV
pop
ADDRGP4 $52
JUMPV
LABELV $51
line 146
;145:
;146:	else if ( self->state == STATE_TOP )
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
NEI4 $53
line 147
;147:		self->s.v.nextthink = self->s.v.ltime + 1;	// delay going down
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 288
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 140
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $53
LABELV $52
line 148
;148:}
LABELV $37
endproc plat_center_touch 20 12
export plat_outside_touch
proc plat_outside_touch 16 12
line 151
;149:
;150:void plat_outside_touch(  )
;151:{
line 154
;152:	gedict_t *te;
;153:
;154:	if ( strneq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $40
ARGP4
ADDRLP4 4
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $56
line 155
;155:		return;
ADDRGP4 $55
JUMPV
LABELV $56
line 157
;156:
;157:	if ( !Activated( self, other ) )
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
NEI4 $58
line 158
;158:	{
line 159
;159:		if ( self->else_goal )
ADDRGP4 self
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $55
line 160
;160:		{
line 161
;161:			te = Findgoal( self->else_goal );
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
line 162
;162:			if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $55
line 163
;163:				AttemptToActivate( te, other, self );
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
line 164
;164:		}
line 165
;165:		return;
ADDRGP4 $55
JUMPV
LABELV $58
line 167
;166:	}
;167:	if ( other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $64
line 168
;168:		return;
ADDRGP4 $55
JUMPV
LABELV $64
line 171
;169:
;170://dprint ("plat_outside_touch\n");
;171:	self = PROG_TO_EDICT( self->s.v.enemy );
ADDRLP4 12
ADDRGP4 self
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 172
;172:	if ( self->state == STATE_TOP )
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
NEI4 $66
line 173
;173:		plat_go_down(  );
ADDRGP4 plat_go_down
CALLV
pop
LABELV $66
line 174
;174:}
LABELV $55
endproc plat_outside_touch 16 12
export plat_trigger_use
proc plat_trigger_use 0 0
line 177
;175:
;176:void plat_trigger_use(  )
;177:{
line 178
;178:	if ( self->s.v.think )
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
CNSTI4 0
EQI4 $69
line 179
;179:		return;		// allready activated
ADDRGP4 $68
JUMPV
LABELV $69
line 180
;180:	plat_go_down(  );
ADDRGP4 plat_go_down
CALLV
pop
line 181
;181:}
LABELV $68
endproc plat_trigger_use 0 0
export plat_crush
proc plat_crush 12 16
line 184
;182:
;183:void plat_crush(  )
;184:{
line 185
;185:	if ( streq( other->s.v.classname, "detpack" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $74
ARGP4
ADDRLP4 0
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $72
line 186
;186:	{
line 187
;187:		G_sprint( PROG_TO_EDICT( other->s.v.owner ), 2, "Your detpack was squashed.\n" );
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
ADDRGP4 $75
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 188
;188:		if ( other->weaponmode == 1 )
ADDRGP4 other
INDIRP4
CNSTI4 940
ADDP4
INDIRI4
CNSTI4 1
NEI4 $76
line 189
;189:		{
line 190
;190:			TeamFortress_SetSpeed( PROG_TO_EDICT( other->s.v.enemy ) );
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
line 191
;191:			dremove( other->observer_list );
ADDRGP4 other
INDIRP4
CNSTI4 900
ADDP4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 192
;192:		}
LABELV $76
line 193
;193:		dremove( other->oldenemy );
ADDRGP4 other
INDIRP4
CNSTI4 980
ADDP4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 194
;194:		dremove( other );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 195
;195:		return;
ADDRGP4 $71
JUMPV
LABELV $72
line 197
;196:	}
;197:	if ( streq( other->s.v.classname, "player" ) && other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $40
ARGP4
ADDRLP4 4
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $78
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $78
line 198
;198:		return;
ADDRGP4 $71
JUMPV
LABELV $78
line 200
;199:
;200:	T_Damage( other, self, self, 1 );
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
CNSTF4 1065353216
ARGF4
ADDRGP4 T_Damage
CALLV
pop
line 201
;201:	if ( self->state == STATE_UP )
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 2
NEI4 $80
line 202
;202:		plat_go_down(  );
ADDRGP4 plat_go_down
CALLV
pop
ADDRGP4 $81
JUMPV
LABELV $80
line 203
;203:	else if ( self->state == STATE_DOWN )
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 3
NEI4 $82
line 204
;204:		plat_go_up(  );
ADDRGP4 plat_go_up
CALLV
pop
ADDRGP4 $83
JUMPV
LABELV $82
line 206
;205:	else
;206:		G_Error( "plat_crush: bad self.state\n" );
ADDRGP4 $84
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $83
LABELV $81
line 207
;207:}
LABELV $71
endproc plat_crush 12 16
export plat_use
proc plat_use 0 4
line 210
;208:
;209:void plat_use(  )
;210:{
line 211
;211:	self->s.v.use = ( func_t ) SUB_Null;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 SUB_Null
CVPU4 4
CVUI4 4
ASGNI4
line 212
;212:	if ( self->state != STATE_UP )
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 2
EQI4 $86
line 213
;213:		G_Error( "plat_use: not in up state" );
ADDRGP4 $88
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $86
line 215
;214:
;215:	plat_go_down(  );
ADDRGP4 plat_go_down
CALLV
pop
line 216
;216:}
LABELV $85
endproc plat_use 0 4
export SP_func_plat
proc SP_func_plat 28 28
line 233
;217:
;218:/*QUAKED func_plat (0 .5 .8) ? PLAT_LOW_TRIGGER
;219:speed default 150
;220:
;221:Plats are always drawn in the extended position, so they will light correctly.
;222:
;223:If the plat is the target of another trigger or button, it will start out disabled in the extended position until it is trigger, when it will lower and become a normal plat.
;224:
;225:If the "height" key is set, that will determine the amount the plat moves, instead of being implicitly determined by the model's height.
;226:Set "sounds" to one of the following:
;227:1) base fast
;228:2) chain slow
;229:*/
;230:
;231:
;232:void SP_func_plat(  )
;233:{
line 236
;234://      gedict_t *t;
;235:
;236:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $90
line 237
;237:	{
line 238
;238:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 239
;239:		return;
ADDRGP4 $89
JUMPV
LABELV $90
line 241
;240:	}
;241:	if ( !self->t_length )
ADDRGP4 self
INDIRP4
CNSTI4 648
ADDP4
INDIRF4
CNSTF4 0
NEF4 $92
line 242
;242:		self->t_length = 80;
ADDRGP4 self
INDIRP4
CNSTI4 648
ADDP4
CNSTF4 1117782016
ASGNF4
LABELV $92
line 244
;243:
;244:	if ( !self->t_width )
ADDRGP4 self
INDIRP4
CNSTI4 652
ADDP4
INDIRF4
CNSTF4 0
NEF4 $94
line 245
;245:		self->t_width = 10;
ADDRGP4 self
INDIRP4
CNSTI4 652
ADDP4
CNSTF4 1092616192
ASGNF4
LABELV $94
line 247
;246:
;247:	if ( self->s.v.sounds == 0 )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 0
NEF4 $96
line 248
;248:		self->s.v.sounds = 2;
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
CNSTF4 1073741824
ASGNF4
LABELV $96
line 251
;249:// FIX THIS TO LOAD A GENERIC PLAT SOUND
;250:
;251:	if ( self->s.v.sounds == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $98
line 252
;252:	{
line 253
;253:		trap_precache_sound( "plats/plat1.wav" );
ADDRGP4 $100
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 254
;254:		trap_precache_sound( "plats/plat2.wav" );
ADDRGP4 $101
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 255
;255:		self->s.v.noise = "plats/plat1.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $100
ASGNP4
line 256
;256:		self->s.v.noise1 = "plats/plat2.wav";
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
ADDRGP4 $101
ASGNP4
line 257
;257:	}
LABELV $98
line 259
;258:
;259:	if ( self->s.v.sounds == 2 )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $102
line 260
;260:	{
line 261
;261:		trap_precache_sound( "plats/medplat1.wav" );
ADDRGP4 $104
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 262
;262:		trap_precache_sound( "plats/medplat2.wav" );
ADDRGP4 $105
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 263
;263:		self->s.v.noise = "plats/medplat1.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $104
ASGNP4
line 264
;264:		self->s.v.noise1 = "plats/medplat2.wav";
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
ADDRGP4 $105
ASGNP4
line 265
;265:	}
LABELV $102
line 267
;266:
;267:	VectorCopy( self->s.v.angles, self->mangle );
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
line 269
;268:	//self->mangle = self->s.v.angles;
;269:	SetVector( self->s.v.angles, 0, 0, 0 );
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
line 271
;270:
;271:	self->s.v.classname = "plat";
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $106
ASGNP4
line 272
;272:	self->s.v.solid = SOLID_BSP;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1082130432
ASGNF4
line 273
;273:	self->s.v.movetype = MOVETYPE_PUSH;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1088421888
ASGNF4
line 274
;274:	setorigin( self, PASSVEC3( self->s.v.origin ) );
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
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
line 275
;275:	setmodel( self, self->s.v.model );
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
line 276
;276:	setsize( self, PASSVEC3( self->s.v.mins ), PASSVEC3( self->s.v.maxs ) );
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 278
;277:
;278:	self->s.v.blocked = ( func_t ) plat_crush;
ADDRGP4 self
INDIRP4
CNSTI4 284
ADDP4
ADDRGP4 plat_crush
CVPU4 4
CVUI4 4
ASGNI4
line 279
;279:	if ( !self->speed )
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
CNSTF4 0
NEF4 $107
line 280
;280:		self->speed = 150;
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
CNSTF4 1125515264
ASGNF4
LABELV $107
line 283
;281:
;282:// pos1 is the top position, pos2 is the bottom
;283:	VectorCopy( self->s.v.origin, self->pos1 );
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 612
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
CNSTI4 616
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
CNSTI4 620
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 284
;284:	VectorCopy( self->s.v.origin, self->pos2 );
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 624
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
CNSTI4 628
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
CNSTI4 632
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 287
;285:	//self->pos1 = self->s.v.origin;
;286:	//self->pos2 = self->s.v.origin;
;287:	if ( self->height )
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
INDIRF4
CNSTF4 0
EQF4 $109
line 288
;288:		self->pos2[2] = self->s.v.origin[2] - self->height;
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 632
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 656
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRGP4 $110
JUMPV
LABELV $109
line 290
;289:	else
;290:		self->pos2[2] = self->s.v.origin[2] - self->s.v.size[2] + 8;
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 632
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 268
ADDP4
INDIRF4
SUBF4
CNSTF4 1090519040
ADDF4
ASGNF4
LABELV $110
line 292
;291:
;292:	self->s.v.use = ( func_t ) plat_trigger_use;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 plat_trigger_use
CVPU4 4
CVUI4 4
ASGNI4
line 294
;293:
;294:	plat_spawn_inside_trigger(  );	// the "start moving" trigger 
ADDRGP4 plat_spawn_inside_trigger
CALLV
pop
line 296
;295:
;296:	if ( self->s.v.targetname )
ADDRGP4 self
INDIRP4
CNSTI4 464
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $111
line 297
;297:	{
line 298
;298:		self->state = STATE_UP;
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 2
ASGNI4
line 299
;299:		self->s.v.use = ( func_t ) plat_use;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 plat_use
CVPU4 4
CVUI4 4
ASGNI4
line 300
;300:	} else
ADDRGP4 $112
JUMPV
LABELV $111
line 301
;301:	{
line 302
;302:		setorigin( self, PASSVEC3( self->pos2 ) );
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 624
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 628
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 632
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 303
;303:		self->state = STATE_BOTTOM;
ADDRGP4 self
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 304
;304:	}
LABELV $112
line 305
;305:}
LABELV $89
endproc SP_func_plat 28 28
export train_blocked
proc train_blocked 4 16
line 313
;306:
;307://============================================================================
;308:
;309:void    train_next(  );
;310:void    func_train_find(  );
;311:
;312:void train_blocked(  )
;313:{
line 314
;314:	if ( g_globalvars.time < self->attack_finished )
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
GEF4 $114
line 315
;315:		return;
ADDRGP4 $113
JUMPV
LABELV $114
line 317
;316:
;317:	self->attack_finished = g_globalvars.time + 0.5;
ADDRGP4 self
INDIRP4
CNSTI4 724
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 319
;318:
;319:	T_Damage( other, self, self, self->dmg );
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
line 320
;320:}
LABELV $113
endproc train_blocked 4 16
export train_use
proc train_use 0 0
line 323
;321:
;322:void train_use(  )
;323:{
line 324
;324:	if ( self->s.v.think != ( func_t ) func_train_find )
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ADDRGP4 func_train_find
CVPU4 4
CVUI4 4
EQI4 $119
line 325
;325:		return;		// already activated
ADDRGP4 $118
JUMPV
LABELV $119
line 327
;326:
;327:	train_next(  );
ADDRGP4 train_next
CALLV
pop
line 328
;328:}
LABELV $118
endproc train_use 0 0
export train_wait
proc train_wait 12 20
line 331
;329:
;330:void train_wait(  )
;331:{
line 332
;332:	if ( self->wait )
ADDRGP4 self
INDIRP4
CNSTI4 660
ADDP4
INDIRF4
CNSTF4 0
EQF4 $122
line 333
;333:	{
line 334
;334:		self->s.v.nextthink = self->s.v.ltime + self->wait;
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
line 335
;335:		sound( self, CHAN_VOICE, self->s.v.noise, 1, ATTN_NORM );
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
line 336
;336:	} else
ADDRGP4 $123
JUMPV
LABELV $122
line 337
;337:		self->s.v.nextthink = self->s.v.ltime + 0.1;
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
CNSTF4 1036831949
ADDF4
ASGNF4
LABELV $123
line 339
;338:
;339:	self->s.v.think = ( func_t ) train_next;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 train_next
CVPU4 4
CVUI4 4
ASGNI4
line 340
;340:}
LABELV $121
endproc train_wait 12 20
export train_next
proc train_next 36 20
line 343
;341:
;342:void train_next(  )
;343:{
line 347
;344:	gedict_t *targ;
;345:	vec3_t  tmpv;
;346:
;347:	targ = trap_find( world, FOFS( s.v.targetname ), self->s.v.target );
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
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 348
;348:	if ( !targ )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $125
line 349
;349:		G_Error( "train_next: no next target" );
ADDRGP4 $127
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $125
line 351
;350:
;351:	self->s.v.target = targ->s.v.target;
ADDRLP4 20
CNSTI4 460
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRP4
ASGNP4
line 352
;352:	if ( !self->s.v.target )
ADDRGP4 self
INDIRP4
CNSTI4 460
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $128
line 353
;353:		G_Error( "train_next: no next target" );
ADDRGP4 $127
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $128
line 355
;354:
;355:	if ( targ->wait )
ADDRLP4 0
INDIRP4
CNSTI4 660
ADDP4
INDIRF4
CNSTF4 0
EQF4 $130
line 356
;356:		self->wait = targ->wait;
ADDRLP4 24
CNSTI4 660
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $131
JUMPV
LABELV $130
line 358
;357:	else
;358:		self->wait = 0;
ADDRGP4 self
INDIRP4
CNSTI4 660
ADDP4
CNSTF4 0
ASGNF4
LABELV $131
line 360
;359:
;360:	sound( self, CHAN_VOICE, self->s.v.noise1, 1, ATTN_NORM );
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
line 361
;361:	VectorSubtract( targ->s.v.origin, self->s.v.mins, tmpv );
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
SUBF4
ASGNF4
line 362
;362:	SUB_CalcMove( tmpv, self->speed, train_wait );
ADDRLP4 4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
ARGF4
ADDRGP4 train_wait
ARGP4
ADDRGP4 SUB_CalcMove
CALLV
pop
line 363
;363:}
LABELV $124
endproc train_next 36 20
export func_train_find
proc func_train_find 24 16
line 367
;364:
;365:
;366:void func_train_find(  )
;367:{
line 370
;368:	gedict_t *targ;
;369:
;370:	targ = trap_find( world, FOFS( s.v.targetname ), self->s.v.target );
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
ADDRLP4 4
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 371
;371:	if ( !targ )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $135
line 372
;372:		G_Error( "func_train_find: no next target" );
ADDRGP4 $137
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $135
line 374
;373:
;374:	self->s.v.target = targ->s.v.target;
ADDRLP4 8
CNSTI4 460
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRP4
ASGNP4
line 375
;375:	setorigin( self, targ->s.v.origin[0] - self->s.v.mins[0],
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 377
;376:		   targ->s.v.origin[1] - self->s.v.mins[1], targ->s.v.origin[2] - self->s.v.mins[2] );
;377:	if ( !self->s.v.targetname )
ADDRGP4 self
INDIRP4
CNSTI4 464
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $138
line 378
;378:	{			// not triggered, so start immediately
line 379
;379:		self->s.v.nextthink = self->s.v.ltime + 0.1;
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 288
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 140
ADDP4
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 380
;380:		self->s.v.think = ( func_t ) train_next;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 train_next
CVPU4 4
CVUI4 4
ASGNI4
line 381
;381:	}
LABELV $138
line 382
;382:}
LABELV $134
endproc func_train_find 24 16
export SP_func_train
proc SP_func_train 20 28
line 397
;383:
;384:
;385:/*QUAKED func_train (0 .5 .8) ?
;386:Trains are moving platforms that players can ride.
;387:The targets origin specifies the min point of the train at each corner.
;388:The train spawns at the first target it is pointing at.
;389:If the train is the target of a button or trigger, it will not begin moving until activated.
;390:speed default 100
;391:dmg  default 2
;392:sounds
;393:1) ratchet metal
;394:
;395:*/
;396:void SP_func_train(  )
;397:{
line 398
;398:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $141
line 399
;399:	{
line 400
;400:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 401
;401:		return;
ADDRGP4 $140
JUMPV
LABELV $141
line 403
;402:	}
;403:	if ( !self->speed )
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
CNSTF4 0
NEF4 $143
line 404
;404:		self->speed = 100;
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
CNSTF4 1120403456
ASGNF4
LABELV $143
line 405
;405:	if ( !self->s.v.target )
ADDRGP4 self
INDIRP4
CNSTI4 460
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $145
line 406
;406:		G_Error( "func_train without a target" );
ADDRGP4 $147
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $145
line 407
;407:	if ( !self->dmg )
ADDRGP4 self
INDIRP4
CNSTI4 716
ADDP4
INDIRF4
CNSTF4 0
NEF4 $148
line 408
;408:		self->dmg = 2;
ADDRGP4 self
INDIRP4
CNSTI4 716
ADDP4
CNSTF4 1073741824
ASGNF4
LABELV $148
line 410
;409:
;410:	if ( self->s.v.sounds == 0 )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 0
NEF4 $150
line 411
;411:	{
line 412
;412:		self->s.v.noise = ( "misc/null.wav" );
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $152
ASGNP4
line 413
;413:		trap_precache_sound( "misc/null.wav" );
ADDRGP4 $152
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 414
;414:		self->s.v.noise1 = ( "misc/null.wav" );
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
ADDRGP4 $152
ASGNP4
line 415
;415:		trap_precache_sound( "misc/null.wav" );
ADDRGP4 $152
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 416
;416:	}
LABELV $150
line 418
;417:
;418:	if ( self->s.v.sounds == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $153
line 419
;419:	{
line 420
;420:		self->s.v.noise = ( "plats/train2.wav" );
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $155
ASGNP4
line 421
;421:		trap_precache_sound( "plats/train2.wav" );
ADDRGP4 $155
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 422
;422:		self->s.v.noise1 = ( "plats/train1.wav" );
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
ADDRGP4 $156
ASGNP4
line 423
;423:		trap_precache_sound( "plats/train1.wav" );
ADDRGP4 $156
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 424
;424:	}
LABELV $153
line 426
;425:
;426:	self->cnt = 1;
ADDRGP4 self
INDIRP4
CNSTI4 692
ADDP4
CNSTF4 1065353216
ASGNF4
line 427
;427:	self->s.v.solid = SOLID_BSP;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1082130432
ASGNF4
line 428
;428:	self->s.v.movetype = MOVETYPE_PUSH;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1088421888
ASGNF4
line 429
;429:	self->s.v.blocked = ( func_t ) train_blocked;
ADDRGP4 self
INDIRP4
CNSTI4 284
ADDP4
ADDRGP4 train_blocked
CVPU4 4
CVUI4 4
ASGNI4
line 430
;430:	self->s.v.use = ( func_t ) train_use;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 train_use
CVPU4 4
CVUI4 4
ASGNI4
line 431
;431:	self->s.v.classname = "train";
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $157
ASGNP4
line 433
;432:
;433:	setmodel( self, self->s.v.model );
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
line 434
;434:	setsize( self, PASSVEC3( self->s.v.mins ), PASSVEC3( self->s.v.maxs ) );
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 435
;435:	setorigin( self, PASSVEC3( self->s.v.origin ) );
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
line 439
;436:
;437:// start trains on the second frame, to make sure their targets have had
;438:// a chance to spawn
;439:	self->s.v.nextthink = self->s.v.ltime + 0.1;
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 288
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 140
ADDP4
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 440
;440:	self->s.v.think = ( func_t ) func_train_find;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 func_train_find
CVPU4 4
CVUI4 4
ASGNI4
line 441
;441:}
LABELV $140
endproc SP_func_train 20 28
export SP_misc_teleporttrain
proc SP_misc_teleporttrain 16 28
line 447
;442:
;443:/*QUAKED misc_teleporttrain (0 .5 .8) (-8 -8 -8) (8 8 8)
;444:This is used for the final bos
;445:*/
;446:void SP_misc_teleporttrain(  )
;447:{
line 448
;448:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $159
line 449
;449:	{
line 450
;450:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 451
;451:		return;
ADDRGP4 $158
JUMPV
LABELV $159
line 453
;452:	}
;453:	if ( !self->speed )
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
CNSTF4 0
NEF4 $161
line 454
;454:		self->speed = 100;
ADDRGP4 self
INDIRP4
CNSTI4 552
ADDP4
CNSTF4 1120403456
ASGNF4
LABELV $161
line 455
;455:	if ( !self->s.v.target )
ADDRGP4 self
INDIRP4
CNSTI4 460
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $163
line 456
;456:		G_Error( "func_train without a target" );
ADDRGP4 $147
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $163
line 458
;457:
;458:	self->cnt = 1;
ADDRGP4 self
INDIRP4
CNSTI4 692
ADDP4
CNSTF4 1065353216
ASGNF4
line 459
;459:	self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 460
;460:	self->s.v.movetype = MOVETYPE_PUSH;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1088421888
ASGNF4
line 461
;461:	self->s.v.blocked = ( func_t ) train_blocked;
ADDRGP4 self
INDIRP4
CNSTI4 284
ADDP4
ADDRGP4 train_blocked
CVPU4 4
CVUI4 4
ASGNI4
line 462
;462:	self->s.v.use = ( func_t ) train_use;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 train_use
CVPU4 4
CVUI4 4
ASGNI4
line 463
;463:	SetVector( self->s.v.avelocity, 100, 200, 300 );
ADDRGP4 self
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 1120403456
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 1128792064
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 1133903872
ASGNF4
line 466
;464:	//self->s.v.avelocity = '100 200 300';
;465:
;466:	self->s.v.noise = ( "misc/null.wav" );
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $152
ASGNP4
line 467
;467:	trap_precache_sound( "misc/null.wav" );
ADDRGP4 $152
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 468
;468:	self->s.v.noise1 = ( "misc/null.wav" );
ADDRGP4 self
INDIRP4
CNSTI4 508
ADDP4
ADDRGP4 $152
ASGNP4
line 469
;469:	trap_precache_sound( "misc/null.wav" );
ADDRGP4 $152
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 471
;470:
;471:	trap_precache_model( "progs/teleport.mdl" );
ADDRGP4 $165
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 472
;472:	setmodel( self, "progs/teleport.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $165
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 473
;473:	setsize( self, PASSVEC3( self->s.v.mins ), PASSVEC3( self->s.v.maxs ) );
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 474
;474:	setorigin( self, PASSVEC3( self->s.v.origin ) );
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
line 478
;475:
;476:// start trains on the second frame, to make sure their targets have had
;477:// a chance to spawn
;478:	self->s.v.nextthink = self->s.v.ltime + 0.1;
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 288
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 140
ADDP4
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 479
;479:	self->s.v.think = ( func_t ) func_train_find;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 func_train_find
CVPU4 4
CVUI4 4
ASGNI4
line 480
;480:}
LABELV $158
endproc SP_misc_teleporttrain 16 28
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
LABELV $165
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $157
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $156
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
LABELV $155
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
LABELV $152
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
LABELV $147
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $137
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 95
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $127
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 95
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $106
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $105
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 100
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $104
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 100
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $101
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $100
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $88
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 95
byte 1 117
byte 1 115
byte 1 101
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 117
byte 1 112
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $84
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 95
byte 1 99
byte 1 114
byte 1 117
byte 1 115
byte 1 104
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 46
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $75
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
LABELV $74
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $40
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
