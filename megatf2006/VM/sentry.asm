export ai_face
code
proc ai_face 24 4
file "..\src\sentry.c"
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
;21: *  $Id: sentry.c,v 1.27 2006/02/28 12:50:07 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:#include "sentry.h"
;25:
;26:void    FireSentryLighting( gedict_t * targ )  ;
;27:void    FireBullets( float shotcount, vec3_t dir, float spread_x, float spread_y, float spread_z );
;28:
;29:
;30:void ai_face(  )
;31:{
line 34
;32:	vec3_t  vtemp;
;33:
;34:	VectorSubtract( PROG_TO_EDICT( self->s.v.enemy )->s.v.origin, self->s.v.origin, vtemp );
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+44
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 16
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+44+4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 20
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+44+8
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
SUBF4
ASGNF4
line 35
;35:	self->s.v.ideal_yaw = vectoyaw( vtemp );
ADDRLP4 0
ARGP4
ADDRLP4 12
ADDRGP4 vectoyaw
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 440
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
line 36
;36:	self->s.v.ideal_yaw = anglemod( self->s.v.ideal_yaw );
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 440
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRF4
ASGNF4
line 37
;37:	changeyaw( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 changeyaw
CALLV
pop
line 38
;38:}
LABELV $11
endproc ai_face 24 4
export lvl1_sentry_stand
proc lvl1_sentry_stand 0 0
line 43
;39:
;40://===========================
;41:// Level 1 Sentry Gun Frames
;42:void lvl1_sentry_stand(  )
;43:{
line 44
;44:	self->s.v.frame = 0;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 0
ASGNF4
line 45
;45:	self->s.v.think = ( func_t ) lvl1_sentry_stand;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl1_sentry_stand
CVPU4 4
CVUI4 4
ASGNI4
line 46
;46:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 48
;47:
;48:	Sentry_Rotate(  );
ADDRGP4 Sentry_Rotate
CALLV
pop
line 49
;49:}
LABELV $22
endproc lvl1_sentry_stand 0 0
export lvl1_sentry_atk1
proc lvl1_sentry_atk1 16 4
line 52
;50:
;51:void lvl1_sentry_atk1(  )
;52:{
line 53
;53:	gedict_t *enemy = PROG_TO_EDICT( self->s.v.enemy );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 55
;54:
;55:	self->s.v.frame = 1;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1065353216
ASGNF4
line 56
;56:	self->s.v.think = ( func_t ) lvl1_sentry_atk3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl1_sentry_atk3
CVPU4 4
CVUI4 4
ASGNI4
line 57
;57:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 59
;58:
;59:	ai_face(  );
ADDRGP4 ai_face
CALLV
pop
line 60
;60:	if ( enemy == world || enemy->is_feigning || enemy->s.v.health <= 0 || !visible( enemy )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $31
ADDRLP4 0
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
NEI4 $31
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $31
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 visible
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $31
ADDRLP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 1
NEI4 $26
LABELV $31
line 62
;61:	     || enemy->has_disconnected == 1 )
;62:		lvl1_sentry_stand(  );
ADDRGP4 lvl1_sentry_stand
CALLV
pop
ADDRGP4 $27
JUMPV
LABELV $26
line 64
;63:	else
;64:	{
line 65
;65:		if ( self->s.v.ammo_shells <= 0 && !tg_data.sg_unlimit_ammo )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 0
GTF4 $32
ADDRGP4 tg_data+60
INDIRI4
CNSTI4 0
NEI4 $32
line 66
;66:			lvl1_sentry_stand(  );
ADDRGP4 lvl1_sentry_stand
CALLV
pop
ADDRGP4 $33
JUMPV
LABELV $32
line 68
;67:		else
;68:		{
line 69
;69:			if ( !Sentry_Fire(  ) )
ADDRLP4 12
ADDRGP4 Sentry_Fire
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $35
line 70
;70:				lvl1_sentry_atk3(  );
ADDRGP4 lvl1_sentry_atk3
CALLV
pop
LABELV $35
line 71
;71:		}
LABELV $33
line 72
;72:	}
LABELV $27
line 73
;73:}
LABELV $24
endproc lvl1_sentry_atk1 16 4
export lvl1_sentry_atk2
proc lvl1_sentry_atk2 0 0
line 76
;74:
;75:void lvl1_sentry_atk2(  )
;76:{
line 77
;77:	self->s.v.frame = 2;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1073741824
ASGNF4
line 78
;78:	self->s.v.think = ( func_t ) lvl1_sentry_atk3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl1_sentry_atk3
CVPU4 4
CVUI4 4
ASGNI4
line 79
;79:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 81
;80:
;81:	ai_face(  );
ADDRGP4 ai_face
CALLV
pop
line 82
;82:	Sentry_Fire(  );
ADDRGP4 Sentry_Fire
CALLI4
pop
line 83
;83:}
LABELV $37
endproc lvl1_sentry_atk2 0 0
export lvl1_sentry_atk3
proc lvl1_sentry_atk3 0 0
line 86
;84:
;85:void lvl1_sentry_atk3(  )
;86:{
line 87
;87:	self->s.v.frame = 0;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 0
ASGNF4
line 88
;88:	self->s.v.think = ( func_t ) lvl1_sentry_atk1;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl1_sentry_atk1
CVPU4 4
CVUI4 4
ASGNI4
line 89
;89:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 91
;90:
;91:	ai_face(  );
ADDRGP4 ai_face
CALLV
pop
line 92
;92:}
LABELV $39
endproc lvl1_sentry_atk3 0 0
export lvl2_sentry_stand
proc lvl2_sentry_stand 0 0
line 98
;93:
;94:
;95://===========================
;96:// Level 2 Sentry Gun Frames
;97:void lvl2_sentry_stand(  )
;98:{
line 99
;99:	self->s.v.frame = 3;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1077936128
ASGNF4
line 100
;100:	self->s.v.think = ( func_t ) lvl2_sentry_stand;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl2_sentry_stand
CVPU4 4
CVUI4 4
ASGNI4
line 101
;101:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 103
;102:
;103:	Sentry_Rotate(  );
ADDRGP4 Sentry_Rotate
CALLV
pop
line 104
;104:}
LABELV $41
endproc lvl2_sentry_stand 0 0
export lvl2_sentry_atk1
proc lvl2_sentry_atk1 16 4
line 107
;105:
;106:void lvl2_sentry_atk1(  )
;107:{
line 108
;108:	gedict_t *enemy = PROG_TO_EDICT( self->s.v.enemy );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 110
;109:
;110:	self->s.v.frame = 4;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1082130432
ASGNF4
line 111
;111:	self->s.v.think = ( func_t ) lvl2_sentry_atk2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl2_sentry_atk2
CVPU4 4
CVUI4 4
ASGNI4
line 112
;112:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 114
;113:
;114:	ai_face(  );
ADDRGP4 ai_face
CALLV
pop
line 115
;115:	if ( enemy == world || enemy->is_feigning || enemy->s.v.health <= 0 || !visible( enemy )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $50
ADDRLP4 0
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
NEI4 $50
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $50
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 visible
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $50
ADDRLP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 1
NEI4 $45
LABELV $50
line 117
;116:	     || enemy->has_disconnected == 1 )
;117:		lvl2_sentry_stand(  );
ADDRGP4 lvl2_sentry_stand
CALLV
pop
ADDRGP4 $46
JUMPV
LABELV $45
line 119
;118:	else
;119:	{
line 120
;120:		if ( self->s.v.ammo_shells <= 0 && !tg_data.sg_unlimit_ammo )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 0
GTF4 $51
ADDRGP4 tg_data+60
INDIRI4
CNSTI4 0
NEI4 $51
line 121
;121:			lvl2_sentry_stand(  );
ADDRGP4 lvl2_sentry_stand
CALLV
pop
ADDRGP4 $52
JUMPV
LABELV $51
line 123
;122:		else
;123:		{
line 124
;124:			if ( !Sentry_Fire(  ) )
ADDRLP4 12
ADDRGP4 Sentry_Fire
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $54
line 125
;125:				lvl2_sentry_atk3(  );
ADDRGP4 lvl2_sentry_atk3
CALLV
pop
LABELV $54
line 126
;126:		}
LABELV $52
line 127
;127:	}
LABELV $46
line 128
;128:}
LABELV $43
endproc lvl2_sentry_atk1 16 4
export lvl2_sentry_atk2
proc lvl2_sentry_atk2 0 0
line 131
;129:
;130:void lvl2_sentry_atk2(  )
;131:{
line 132
;132:	self->s.v.frame = 5;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1084227584
ASGNF4
line 133
;133:	self->s.v.think = ( func_t ) lvl2_sentry_atk3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl2_sentry_atk3
CVPU4 4
CVUI4 4
ASGNI4
line 134
;134:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 136
;135:
;136:	ai_face(  );
ADDRGP4 ai_face
CALLV
pop
line 137
;137:	Sentry_Fire(  );
ADDRGP4 Sentry_Fire
CALLI4
pop
line 138
;138:}
LABELV $56
endproc lvl2_sentry_atk2 0 0
export lvl2_sentry_atk3
proc lvl2_sentry_atk3 0 0
line 141
;139:
;140:void lvl2_sentry_atk3(  )
;141:{
line 142
;142:	self->s.v.frame = 3;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1077936128
ASGNF4
line 143
;143:	self->s.v.think = ( func_t ) lvl2_sentry_atk1;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl2_sentry_atk1
CVPU4 4
CVUI4 4
ASGNI4
line 144
;144:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 146
;145:
;146:	ai_face(  );
ADDRGP4 ai_face
CALLV
pop
line 147
;147:	Sentry_Fire(  );
ADDRGP4 Sentry_Fire
CALLI4
pop
line 148
;148:}
LABELV $58
endproc lvl2_sentry_atk3 0 0
export lvl3_sentry_stand
proc lvl3_sentry_stand 0 0
line 154
;149:
;150:
;151://===========================
;152:// Level 3 Sentry Gun Frames
;153:void lvl3_sentry_stand(  )
;154:{
line 155
;155:	self->s.v.frame = 6;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1086324736
ASGNF4
line 156
;156:	self->s.v.think = ( func_t ) lvl3_sentry_stand;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl3_sentry_stand
CVPU4 4
CVUI4 4
ASGNI4
line 157
;157:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 159
;158:
;159:	Sentry_Rotate(  );
ADDRGP4 Sentry_Rotate
CALLV
pop
line 160
;160:}
LABELV $60
endproc lvl3_sentry_stand 0 0
export lvl3_sentry_atk1
proc lvl3_sentry_atk1 24 4
line 163
;161:
;162:void lvl3_sentry_atk1(  )
;163:{
line 164
;164:	gedict_t *enemy = PROG_TO_EDICT( self->s.v.enemy );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 166
;165:
;166:	self->s.v.frame = 7;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1088421888
ASGNF4
line 167
;167:	self->s.v.think = ( func_t ) lvl3_sentry_atk2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl3_sentry_atk2
CVPU4 4
CVUI4 4
ASGNI4
line 168
;168:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 170
;169:
;170:	ai_face(  );
ADDRGP4 ai_face
CALLV
pop
line 171
;171:	if ( enemy == world || enemy->is_feigning || enemy->s.v.health <= 0 || !visible( enemy )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $69
ADDRLP4 0
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
NEI4 $69
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $69
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 visible
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $69
ADDRLP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 1
NEI4 $64
LABELV $69
line 173
;172:	     || enemy->has_disconnected == 1 )
;173:		lvl3_sentry_stand(  );
ADDRGP4 lvl3_sentry_stand
CALLV
pop
ADDRGP4 $65
JUMPV
LABELV $64
line 175
;174:	else
;175:	{
line 176
;176:		if ( self->s.v.ammo_shells <= 0 && self->s.v.ammo_rockets <= 0 && !tg_data.sg_unlimit_ammo )
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
GTF4 $70
ADDRLP4 12
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
GTF4 $70
ADDRGP4 tg_data+60
INDIRI4
CNSTI4 0
NEI4 $70
line 177
;177:			lvl3_sentry_stand(  );
ADDRGP4 lvl3_sentry_stand
CALLV
pop
ADDRGP4 $71
JUMPV
LABELV $70
line 179
;178:		else
;179:		{
line 180
;180:			if ( !Sentry_Fire(  ) )
ADDRLP4 20
ADDRGP4 Sentry_Fire
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $73
line 181
;181:				lvl3_sentry_atk3(  );
ADDRGP4 lvl3_sentry_atk3
CALLV
pop
LABELV $73
line 182
;182:		}
LABELV $71
line 183
;183:	}
LABELV $65
line 184
;184:}
LABELV $62
endproc lvl3_sentry_atk1 24 4
export lvl3_sentry_atk2
proc lvl3_sentry_atk2 0 0
line 186
;185:void lvl3_sentry_atk2(  )
;186:{
line 187
;187:	self->s.v.frame = 8;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1090519040
ASGNF4
line 188
;188:	self->s.v.think = ( func_t ) lvl3_sentry_atk3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl3_sentry_atk3
CVPU4 4
CVUI4 4
ASGNI4
line 189
;189:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 191
;190:
;191:	ai_face(  );
ADDRGP4 ai_face
CALLV
pop
line 192
;192:	Sentry_Fire(  );
ADDRGP4 Sentry_Fire
CALLI4
pop
line 193
;193:}
LABELV $75
endproc lvl3_sentry_atk2 0 0
export lvl3_sentry_atk3
proc lvl3_sentry_atk3 0 0
line 196
;194:
;195:void lvl3_sentry_atk3(  )
;196:{
line 197
;197:	self->s.v.frame = 6;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1086324736
ASGNF4
line 198
;198:	self->s.v.think = ( func_t ) lvl3_sentry_atk1;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl3_sentry_atk1
CVPU4 4
CVUI4 4
ASGNI4
line 199
;199:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 201
;200:
;201:	ai_face(  );
ADDRGP4 ai_face
CALLV
pop
line 202
;202:	Sentry_Fire(  );
ADDRGP4 Sentry_Fire
CALLI4
pop
line 203
;203:}
LABELV $77
endproc lvl3_sentry_atk3 0 0
export Sentry_Rotate
proc Sentry_Rotate 28 20
line 207
;204:
;205://=============
;206:void Sentry_Rotate(  )
;207:{
line 210
;208:	float   ay;
;209:
;210:	self->s.v.effects = ( int ) self->s.v.effects - ( ( int ) self->s.v.effects & EF_DIMLIGHT );
ADDRLP4 4
ADDRGP4 self
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
line 211
;211:	CheckSentry( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 CheckSentry
CALLV
pop
line 212
;212:	if ( tf_data.sg_newfind)
ADDRGP4 tf_data+108
INDIRI4
CNSTI4 0
EQI4 $80
line 213
;213:	{
line 214
;214:		if ( Sentry_FindTarget_Angel(  ) )
ADDRLP4 12
ADDRGP4 Sentry_FindTarget_Angel
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $81
line 215
;215:			return;
ADDRGP4 $79
JUMPV
line 216
;216:	} else
LABELV $80
line 217
;217:	{
line 218
;218:		if ( Sentry_FindTarget(  ) )
ADDRLP4 12
ADDRGP4 Sentry_FindTarget
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $85
line 219
;219:			return;
ADDRGP4 $79
JUMPV
LABELV $85
line 220
;220:	}
LABELV $81
line 221
;221:	if ( !self->heat )
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
CNSTF4 0
NEF4 $87
line 222
;222:	{
line 223
;223:		self->s.v.ideal_yaw = self->waitmin;
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 440
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 1092
ADDP4
INDIRF4
ASGNF4
line 224
;224:		changeyaw( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 changeyaw
CALLV
pop
line 225
;225:		ay = ( int ) anglemod( self->s.v.angles[1] );
ADDRGP4 self
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 226
;226:		if ( ay == ( int ) self->waitmin )
ADDRLP4 0
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 1092
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
NEF4 $88
line 227
;227:		{
line 228
;228:			CheckBelowBuilding( self->trigger_field );
ADDRGP4 self
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
ARGP4
ADDRGP4 CheckBelowBuilding
CALLV
pop
line 229
;229:			self->heat = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
CNSTF4 1065353216
ASGNF4
line 230
;230:			if ( g_random(  ) < 0.1 )
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 20
INDIRF4
CNSTF4 1036831949
GEF4 $88
line 231
;231:				sound( self, 3, "weapons/gunidle1.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $93
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
line 233
;232:				//sound( self, 3, "weapons/turridle.wav", 1, 1 );
;233:		}
line 234
;234:	} else
ADDRGP4 $88
JUMPV
LABELV $87
line 235
;235:	{
line 236
;236:		self->s.v.ideal_yaw = self->waitmax;
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 440
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 1096
ADDP4
INDIRF4
ASGNF4
line 237
;237:		changeyaw( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 changeyaw
CALLV
pop
line 238
;238:		ay = ( int ) anglemod( self->s.v.angles[1] );
ADDRGP4 self
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 239
;239:		if ( ay == ( int ) self->waitmax )
ADDRLP4 0
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 1096
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
NEF4 $94
line 240
;240:		{
line 241
;241:			CheckBelowBuilding( self->trigger_field );
ADDRGP4 self
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
ARGP4
ADDRGP4 CheckBelowBuilding
CALLV
pop
line 242
;242:			self->heat = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
CNSTF4 0
ASGNF4
line 243
;243:		}
LABELV $94
line 244
;244:	}
LABELV $88
line 245
;245:}
LABELV $79
endproc Sentry_Rotate 28 20
export CheckTarget
proc CheckTarget 32 8
line 249
;246:
;247://////////////////////////////////////////////////////////////////////
;248:int CheckTarget( gedict_t * Target )
;249:{
line 252
;250:	int     r;
;251:
;252:	if ( tg_data.sg_allow_find == TG_SG_FIND_IGNORE_ALL )
ADDRGP4 tg_data+40
INDIRI4
CNSTI4 3
NEI4 $97
line 253
;253:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $97
line 254
;254:	if ( !Target )
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $100
line 255
;255:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $100
line 256
;256:	if ( Target == self )
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 self
INDIRP4
CVPU4 4
NEU4 $102
line 257
;257:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $102
line 258
;258:	if ( Target->has_disconnected == 1 )
ADDRFP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 1
NEI4 $104
line 259
;259:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $104
line 260
;260:	if ( !Target->s.v.takedamage )
ADDRFP4 0
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
NEF4 $106
line 261
;261:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $106
line 262
;262:	if ( Target->is_feigning )
ADDRFP4 0
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
EQI4 $108
line 263
;263:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $108
line 264
;264:	if ( ( int ) Target->s.v.flags & FL_NOTARGET )
ADDRFP4 0
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $110
line 265
;265:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $110
line 266
;266:	if ( ( int ) Target->s.v.items & IT_INVISIBILITY )
ADDRFP4 0
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CVFI4 4
CNSTI4 524288
BANDI4
CNSTI4 0
EQI4 $112
line 267
;267:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $112
line 268
;268:	if ( !visible( Target ) )
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 visible
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $114
line 269
;269:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $114
line 270
;270:	r = range( Target );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 range
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 271
;271:	if ( r == 3 )
ADDRLP4 0
INDIRI4
CNSTI4 3
NEI4 $116
line 272
;272:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $116
line 274
;273:	else
;274:	{
line 275
;275:		if ( r == 2 && !infront( Target ) )
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $118
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 infront
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $118
line 276
;276:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $118
line 277
;277:	}
line 279
;278:
;279:	if ( tg_data.sg_allow_find == TG_SG_FIND_IGNORE_OFF )
ADDRGP4 tg_data+40
INDIRI4
CNSTI4 2
NEI4 $120
line 280
;280:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $96
JUMPV
LABELV $120
line 282
;281:
;282:	if ( teamplay )
ADDRGP4 teamplay
INDIRI4
CNSTI4 0
EQI4 $123
line 283
;283:	{
line 284
;284:		if (  self->team_no && TeamFortress_isTeamsAllied (Target->team_no , self->team_no) )
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
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $125
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 TeamFortress_isTeamsAllied
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $125
line 285
;285:		{
line 286
;286:			if ( tg_data.sg_allow_find == TG_SG_FIND_IGNORE_TEAM )
ADDRGP4 tg_data+40
INDIRI4
CNSTI4 0
NEI4 $127
line 287
;287:				return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $127
line 288
;288:		}
LABELV $125
line 289
;289:		if ( self->team_no && TeamFortress_isTeamsAllied(Target->undercover_team , self->team_no))
ADDRLP4 24
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $130
ADDRFP4 0
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 TeamFortress_isTeamsAllied
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $130
line 290
;290:		{
line 291
;291:			if ( tg_data.sg_allow_find == TG_SG_FIND_IGNORE_TEAM )
ADDRGP4 tg_data+40
INDIRI4
CNSTI4 0
NEI4 $132
line 292
;292:				return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $132
line 293
;293:		}
LABELV $130
line 294
;294:	}
LABELV $123
line 295
;295:	if ( Target == self->real_owner )
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CVPU4 4
NEU4 $135
line 296
;296:	{
line 297
;297:		if ( tg_data.sg_allow_find == TG_SG_FIND_IGNORE_OWNER )
ADDRGP4 tg_data+40
INDIRI4
CNSTI4 1
NEI4 $137
line 298
;298:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $96
JUMPV
LABELV $137
line 299
;299:	}
LABELV $135
line 302
;300:
;301:
;302:	return 1;
CNSTI4 1
RETI4
LABELV $96
endproc CheckTarget 32 8
export Sentry_FindTarget_Angel
proc Sentry_FindTarget_Angel 16 12
line 307
;303:}
;304:
;305://////////////////////////////////////////////////////////////////////
;306:int Sentry_FindTarget_Angel(  )
;307:{
line 309
;308:	gedict_t *client;
;309:	gedict_t *enemy = PROG_TO_EDICT( self->s.v.enemy );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 311
;310:
;311:	if ( enemy != world )
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $141
line 312
;312:	{
line 313
;313:		if ( CheckTarget( enemy ) )
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 CheckTarget
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $143
line 314
;314:		{
line 315
;315:			if ( g_globalvars.time > self->height )
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
INDIRF4
LEF4 $145
line 316
;316:			{
line 317
;317:				Sentry_FoundTarget(  );
ADDRGP4 Sentry_FoundTarget
CALLV
pop
line 318
;318:				return 1;
CNSTI4 1
RETI4
ADDRGP4 $140
JUMPV
LABELV $145
line 320
;319:			} else
;320:				return 0;
CNSTI4 0
RETI4
ADDRGP4 $140
JUMPV
LABELV $143
line 322
;321:		}
;322:	}
LABELV $141
line 323
;323:	for ( client = world; (client = trap_find( client, FOFS( s.v.classname ), "player" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $151
JUMPV
LABELV $148
line 324
;324:	{
line 325
;325:		if ( CheckTarget( client ) )
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 CheckTarget
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $153
line 326
;326:		{
line 327
;327:			self->s.v.enemy = EDICT_TO_PROG( client );
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
line 328
;328:			self->height = g_globalvars.time + 0.1 * ( int ) ( g_random(  ) * tf_data.sgppl );
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDRLP4 12
INDIRF4
ADDRGP4 tf_data+120
INDIRI4
CVIF4 4
MULF4
CVFI4 4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 330
;329://     self.height = g_globalvars.time + 0.1 * rint(sgppl);
;330:			if ( self->height == g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
NEF4 $157
line 331
;331:			{
line 332
;332:				Sentry_FoundTarget(  );
ADDRGP4 Sentry_FoundTarget
CALLV
pop
line 333
;333:				return 1;
CNSTI4 1
RETI4
ADDRGP4 $140
JUMPV
LABELV $157
line 335
;334:			}
;335:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $140
JUMPV
LABELV $153
line 337
;336:		}
;337:	}
LABELV $149
line 323
LABELV $151
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $152
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $148
line 338
;338:	self->s.v.enemy = EDICT_TO_PROG( world );
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
ADDRGP4 world
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 339
;339:	return 0;
CNSTI4 0
RETI4
LABELV $140
endproc Sentry_FindTarget_Angel 16 12
export Sentry_FindTarget
proc Sentry_FindTarget 28 8
line 344
;340:}
;341:
;342://////////////////////////////////////////////////////////////////////
;343:int Sentry_FindTarget(  )
;344:{
line 350
;345:	gedict_t *client;
;346:	float   r;
;347:	float   gotone;
;348:	float   loopc;
;349:
;350:	r = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 351
;351:	loopc = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 352
;352:	gotone = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRGP4 $162
JUMPV
LABELV $161
line 354
;353:	while ( loopc < 6 && !gotone )
;354:	{
line 355
;355:		client = checkclient(  );
ADDRLP4 16
ADDRGP4 checkclient
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 356
;356:		gotone = CheckTarget( client );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 CheckTarget
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
CVIF4 4
ASGNF4
line 357
;357:		loopc = loopc + 1;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 358
;358:	}
LABELV $162
line 353
ADDRLP4 0
INDIRF4
CNSTF4 1086324736
GEF4 $164
ADDRLP4 4
INDIRF4
CNSTF4 0
EQF4 $161
LABELV $164
line 359
;359:	if ( !gotone )
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $165
line 360
;360:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $160
JUMPV
LABELV $165
line 361
;361:	self->s.v.enemy = EDICT_TO_PROG( client );
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 362
;362:	if ( strneq( PROG_TO_EDICT( self->s.v.enemy )->s.v.classname, "player" ) )
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+104
ADDP4
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 16
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $167
line 363
;363:	{
line 364
;364:		self->s.v.enemy = PROG_TO_EDICT( self->s.v.enemy )->s.v.enemy;
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
ADDRGP4 g_edicts+112+288
ADDP4
INDIRI4
ASGNI4
line 365
;365:		if ( strneq( PROG_TO_EDICT( self->s.v.enemy )->s.v.classname, "player" ) )
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+104
ADDP4
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 24
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $173
line 366
;366:		{
line 367
;367:			self->s.v.enemy = EDICT_TO_PROG( world );
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
ADDRGP4 world
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 368
;368:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $160
JUMPV
LABELV $173
line 370
;369:		}
;370:	}
LABELV $167
line 371
;371:	Sentry_FoundTarget(  );
ADDRGP4 Sentry_FoundTarget
CALLV
pop
line 372
;372:	return 1;
CNSTI4 1
RETI4
LABELV $160
endproc Sentry_FindTarget 28 8
export Sentry_FoundTarget
proc Sentry_FoundTarget 12 20
line 376
;373:}
;374:
;375:void Sentry_FoundTarget(  )
;376:{
line 377
;377:	if ( self->s.v.ammo_shells > 0 || ( self->s.v.ammo_rockets > 0 && self->s.v.weapon == 3 ) || tg_data.sg_unlimit_ammo )
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
GTF4 $182
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
LEF4 $183
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1077936128
EQF4 $182
LABELV $183
ADDRGP4 tg_data+60
INDIRI4
CNSTI4 0
EQI4 $178
LABELV $182
line 378
;378:	{
line 379
;379:		sound( self, 2, "weapons/pain.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $184
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
line 381
;380:		//sound( self, 2, "weapons/turrspot.wav", 1, 1 );
;381:		self->last_saveme_sound = g_globalvars.time + 5;
ADDRGP4 self
INDIRP4
CNSTI4 1084
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 382
;382:	}
LABELV $178
line 383
;383:	Sentry_HuntTarget(  );
ADDRGP4 Sentry_HuntTarget
CALLV
pop
line 384
;384:	if ( self->super_damage_finished < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 740
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $186
line 385
;385:		self->super_damage_finished = g_globalvars.time + 0.5;
ADDRGP4 self
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
LABELV $186
line 386
;386:}
LABELV $177
endproc Sentry_FoundTarget 12 20
export Sentry_HuntTarget
proc Sentry_HuntTarget 28 4
line 389
;387:
;388:void Sentry_HuntTarget(  )
;389:{
line 392
;390:	vec3_t  vtemp;
;391:
;392:	self->s.v.goalentity = self->s.v.enemy;
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 452
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ASGNI4
line 393
;393:	if ( self->s.v.weapon == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $191
line 394
;394:		self->s.v.think = ( func_t ) lvl1_sentry_atk1;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl1_sentry_atk1
CVPU4 4
CVUI4 4
ASGNI4
ADDRGP4 $192
JUMPV
LABELV $191
line 396
;395:	else
;396:	{
line 397
;397:		if ( self->s.v.weapon == 2 )
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $193
line 398
;398:			self->s.v.think = ( func_t ) lvl2_sentry_atk1;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl2_sentry_atk1
CVPU4 4
CVUI4 4
ASGNI4
ADDRGP4 $194
JUMPV
LABELV $193
line 400
;399:		else
;400:			self->s.v.think = ( func_t ) lvl3_sentry_atk1;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl3_sentry_atk1
CVPU4 4
CVUI4 4
ASGNI4
LABELV $194
line 401
;401:	}
LABELV $192
line 403
;402:
;403:	VectorSubtract( PROG_TO_EDICT( self->s.v.enemy )->s.v.origin, self->s.v.origin, vtemp );
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+44
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 20
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+44+4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 24
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+44+8
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
SUBF4
ASGNF4
line 404
;404:	self->s.v.ideal_yaw = vectoyaw( vtemp );
ADDRLP4 0
ARGP4
ADDRLP4 16
ADDRGP4 vectoyaw
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 440
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
line 405
;405:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 406
;406:	SUB_AttackFinished( 1 ); // wait a while before first attack
CNSTF4 1065353216
ARGF4
ADDRGP4 SUB_AttackFinished
CALLV
pop
line 407
;407:}
LABELV $190
endproc Sentry_HuntTarget 28 4
export Sentry_Pain
proc Sentry_Pain 0 0
line 410
;408:
;409:void Sentry_Pain( struct gedict_s *attacker, float take )
;410:{
line 412
;411:        // Update the owner's status bar
;412:	self->real_owner->StatusRefreshTime = g_globalvars.time + 0.2;
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 413
;413:}
LABELV $206
endproc Sentry_Pain 0 0
export Sentry_Explode
proc Sentry_Explode 8 16
line 416
;414:
;415:void Sentry_Explode(  )
;416:{
line 417
;417:	ThrowGib( "progs/tgib1.mdl", -70 );
ADDRGP4 $209
ARGP4
CNSTF4 3263954944
ARGF4
ADDRGP4 ThrowGib
CALLV
pop
line 418
;418:	ThrowGib( "progs/tgib2.mdl", -70 );
ADDRGP4 $210
ARGP4
CNSTF4 3263954944
ARGF4
ADDRGP4 ThrowGib
CALLV
pop
line 419
;419:	ThrowGib( "progs/tgib3.mdl", -70 );
ADDRGP4 $211
ARGP4
CNSTF4 3263954944
ARGF4
ADDRGP4 ThrowGib
CALLV
pop
line 420
;420:	if ( self->real_owner->has_disconnected != 1 )
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 1
EQI4 $212
line 421
;421:	{
line 422
;422:		tf_data.deathmsg = DMSG_SG_EXPLODION;
ADDRGP4 tf_data+88
CNSTI4 38
ASGNI4
line 423
;423:		T_RadiusDamage( self, self->real_owner, 75 + self->s.v.ammo_rockets * 8, self );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
CNSTF4 1090519040
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
MULF4
CNSTF4 1117126656
ADDF4
ARGF4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 T_RadiusDamage
CALLV
pop
line 424
;424:	}
LABELV $212
line 425
;425:	if ( streq( self->s.v.classname, "building_sentrygun_base" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $217
ARGP4
ADDRLP4 0
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $215
line 426
;426:	{
line 427
;427:		if ( self->oldenemy )
ADDRGP4 self
INDIRP4
CNSTI4 980
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $216
line 428
;428:			dremove( self->oldenemy );
ADDRGP4 self
INDIRP4
CNSTI4 980
ADDP4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 429
;429:	} else
ADDRGP4 $216
JUMPV
LABELV $215
line 430
;430:		dremove( self->trigger_field );
ADDRGP4 self
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
LABELV $216
line 431
;431:	trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 432
;432:	trap_WriteByte( MSG_MULTICAST, TE_EXPLOSION );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 433
;433:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
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
line 434
;434:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
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
line 435
;435:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] );
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
line 436
;436:	trap_multicast( PASSVEC3( self->s.v.origin ), 1 );
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
line 437
;437:	BecomeExplosion(  );
ADDRGP4 BecomeExplosion
CALLV
pop
line 438
;438:}
LABELV $208
endproc Sentry_Explode 8 16
export SG_Static
proc SG_Static 0 8
line 441
;439:
;440:void SG_Static(  )
;441:{
line 442
;442:	if ( self->s.v.health == 0 )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
NEF4 $221
line 443
;443:	{
line 444
;444:		setmodel( self, "progs/turrgun.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $223
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 445
;445:		self->s.v.health = -1;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 3212836864
ASGNF4
line 446
;446:	} else
ADDRGP4 $222
JUMPV
LABELV $221
line 447
;447:	{
line 448
;448:		setmodel( self, "" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $224
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 449
;449:		self->s.v.health = 0;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 0
ASGNF4
line 450
;450:	}
LABELV $222
line 451
;451:	self->s.v.nextthink = g_globalvars.time + 0.5;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 452
;452:}
LABELV $220
endproc SG_Static 0 8
export Sentry_Die
proc Sentry_Die 20 16
line 455
;453:
;454:void Sentry_Die(  )
;455:{
line 456
;456:	G_sprint( self->real_owner, 2, "Your sentry gun was destroyed.\n" );
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $227
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 457
;457:	if ( self->has_sentry && tg_data.tg_enabled )
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $228
ADDRGP4 tg_data
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $228
line 458
;458:	{
line 459
;459:		self->s.v.health = 0;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 0
ASGNF4
line 460
;460:		setmodel( self, "" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $224
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 461
;461:		setmodel( self->trigger_field, "" );
ADDRGP4 self
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
ARGP4
ADDRGP4 $224
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 462
;462:		self->s.v.think = ( func_t ) SG_Static;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SG_Static
CVPU4 4
CVUI4 4
ASGNI4
line 463
;463:		self->s.v.nextthink = g_globalvars.time + 0.5;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 464
;464:		self->s.v.effects = self->s.v.effects - ( (int)self->s.v.effects & 8 );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 232
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
CNSTI4 8
BANDI4
CVIF4 4
SUBF4
ASGNF4
line 465
;465:		self->s.v.movetype = MOVETYPE_NONE;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 466
;466:		self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 467
;467:		self->trigger_field->s.v.movetype = MOVETYPE_NONE;
ADDRGP4 self
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 468
;468:		self->trigger_field->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 469
;469:		ThrowGib( "progs/tgib1.mdl", -70 );
ADDRGP4 $209
ARGP4
CNSTF4 3263954944
ARGF4
ADDRGP4 ThrowGib
CALLV
pop
line 470
;470:		ThrowGib( "progs/tgib2.mdl", -70 );
ADDRGP4 $210
ARGP4
CNSTF4 3263954944
ARGF4
ADDRGP4 ThrowGib
CALLV
pop
line 471
;471:		ThrowGib( "progs/tgib3.mdl", -70 );
ADDRGP4 $211
ARGP4
CNSTF4 3263954944
ARGF4
ADDRGP4 ThrowGib
CALLV
pop
line 472
;472:		tf_data.deathmsg = DMSG_SG_EXPLODION;
ADDRGP4 tf_data+88
CNSTI4 38
ASGNI4
line 473
;473:		T_RadiusDamage( self, self->real_owner, 75 + self->s.v.ammo_rockets * 8, self );
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
CNSTF4 1090519040
ADDRLP4 12
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
MULF4
CNSTF4 1117126656
ADDF4
ARGF4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 T_RadiusDamage
CALLV
pop
line 474
;474:		trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 475
;475:		trap_WriteByte( MSG_MULTICAST, TE_EXPLOSION );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 476
;476:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
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
line 477
;477:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
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
line 478
;478:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] );
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
line 479
;479:		trap_multicast( PASSVEC3( self->s.v.origin ), 1 );
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
CNSTI4 1
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 480
;480:	} else
ADDRGP4 $229
JUMPV
LABELV $228
line 481
;481:	{
line 482
;482:		self->real_owner->has_sentry -= 1;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 1000
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 484
;483:#ifdef HAS_SENTRY_CHECK
;484:		if(!tg_data.tg_enabled && self->real_owner->has_sentry)
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 tg_data
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $232
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $232
line 485
;485:		{
line 486
;486:			G_dprintf("Error SentryDie owner->has_sentry !=0 %d\n",self->real_owner->has_sentry);
ADDRGP4 $234
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_dprintf
CALLV
pop
line 487
;487:			G_sprint(self->real_owner,2,"Error SentryDie owner->has_sentry !=0 %d\n",self->real_owner->has_sentry);
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $234
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 488
;488:			self->real_owner->has_sentry = 0;
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 1000
ADDP4
CNSTI4 0
ASGNI4
line 489
;489:		}
LABELV $232
line 491
;490:#endif
;491:		self->s.v.think = ( func_t ) Sentry_Explode;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 Sentry_Explode
CVPU4 4
CVUI4 4
ASGNI4
line 492
;492:		self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 493
;493:	}
LABELV $229
line 494
;494:}
LABELV $226
endproc Sentry_Die 20 16
export FireSentryBulletsNEW
proc FireSentryBulletsNEW 72 32
line 497
;495:
;496:void FireSentryBulletsNEW( int shotcount, gedict_t * targ, float spread_x, float spread_y, float spread_z )
;497:{
line 502
;498:	vec3_t  src;
;499:	vec3_t  dst;
;500:	vec3_t  dir,  tmp, norm_dir;
;501:
;502:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 504
;503:
;504:	VectorAdd( self->s.v.origin, self->s.v.view_ofs, src );
ADDRLP4 60
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 60
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 352
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 64
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 64
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 356
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 68
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 68
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 68
INDIRP4
CNSTI4 360
ADDP4
INDIRF4
ADDF4
ASGNF4
line 505
;505:	VectorAdd( targ->s.v.origin, targ->s.v.view_ofs, dst );
ADDRLP4 60
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 60
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 352
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 64
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12+4
ADDRLP4 64
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 356
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 68
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12+8
ADDRLP4 68
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 68
INDIRP4
CNSTI4 360
ADDP4
INDIRF4
ADDF4
ASGNF4
line 506
;506:	VectorSubtract( dst, src, dir );
ADDRLP4 36
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 508
;507:
;508:	normalize(dir,norm_dir);
ADDRLP4 36
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 normalize
CALLV
pop
line 511
;509:	
;510:	//чтобы не попадать в подставку
;511:	traceline( PASSVEC3( src ), PASSVEC3( dst ), 0, self );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 513
;512:	
;513:	if( (PROG_TO_EDICT(g_globalvars.trace_ent) == self->trigger_field) && vlen(dir) > 100 )
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
ADDRGP4 self
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
CVPU4 4
NEU4 $251
ADDRLP4 36
ARGP4
ADDRLP4 60
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 60
INDIRF4
CNSTF4 1120403456
LEF4 $251
line 514
;514:	{
line 515
;515:		 VectorScale(norm_dir, 60, tmp);
ADDRLP4 24
ARGP4
CNSTF4 1114636288
ARGF4
ADDRLP4 48
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 516
;516:		 VectorAdd(src,tmp,src);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 48
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 48+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 48+8
INDIRF4
ADDF4
ASGNF4
line 517
;517:	}
LABELV $251
line 519
;518:
;519:	ClearMultiDamage(  );
ADDRGP4 ClearMultiDamage
CALLV
pop
line 520
;520:	traceline( PASSVEC3( src ), PASSVEC3( dst ), 0, self );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 522
;521:
;522:	VectorScale( norm_dir, 4, puff_org );
ADDRLP4 24
ARGP4
CNSTF4 1082130432
ARGF4
ADDRGP4 puff_org
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 523
;523:	VectorSubtract( g_globalvars.trace_endpos, puff_org, puff_org );
ADDRLP4 64
ADDRGP4 puff_org
ASGNP4
ADDRLP4 64
INDIRP4
ADDRGP4 g_globalvars+276
INDIRF4
ADDRLP4 64
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRGP4 puff_org+4
ADDRGP4 g_globalvars+276+4
INDIRF4
ADDRGP4 puff_org+4
INDIRF4
SUBF4
ASGNF4
ADDRGP4 puff_org+8
ADDRGP4 g_globalvars+276+8
INDIRF4
ADDRGP4 puff_org+8
INDIRF4
SUBF4
ASGNF4
line 525
;524:
;525:	for (  ; shotcount > 0  ; shotcount-- )
ADDRGP4 $276
JUMPV
LABELV $273
line 526
;526:	{
line 529
;527:	        // для каждого выстрела определяем trace_ent trace_endpos
;528:	        // т.к.выстрелы могут убрать препятствия
;529:	        traceline( PASSVEC3( src ), PASSVEC3( dst ), 0, self );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 532
;530:
;531:	        // TraceAttack требует нормализованый вектор для корректного определения blood_org
;532:	        if(g_globalvars.trace_fraction != 1)
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $281
line 533
;533:	        	TraceAttack( 4, norm_dir ); 
CNSTF4 1082130432
ARGF4
ADDRLP4 24
ARGP4
ADDRGP4 TraceAttack
CALLV
pop
LABELV $281
line 534
;534:	}
LABELV $274
line 525
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $276
ADDRFP4 0
INDIRI4
CNSTI4 0
GTI4 $273
line 535
;535:	ApplyMultiDamage(  );
ADDRGP4 ApplyMultiDamage
CALLV
pop
line 536
;536:	Multi_Finish(  );
ADDRGP4 Multi_Finish
CALLV
pop
line 537
;537:}
LABELV $236
endproc FireSentryBulletsNEW 72 32
export FireSentryBulletsMTFL2
proc FireSentryBulletsMTFL2 84 32
line 544
;538:/*
;539:====================================
;540:FireSentryBulletsMTFL2
;541:====================================
;542:*/
;543:void FireSentryBulletsMTFL2( int shotcount, gedict_t * targ, float spread_x, float spread_y, float spread_z )
;544:{
line 550
;545:	vec3_t  direction;
;546:	vec3_t  src;
;547:	vec3_t  dst;
;548:	vec3_t  dir, end, tmp;
;549:
;550:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 552
;551:
;552:	VectorAdd( self->s.v.origin, self->s.v.view_ofs, src );
ADDRLP4 72
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 72
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 352
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24+4
ADDRLP4 76
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 356
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 80
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24+8
ADDRLP4 80
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 360
ADDP4
INDIRF4
ADDF4
ASGNF4
line 553
;553:	VectorAdd( targ->s.v.origin, targ->s.v.view_ofs, dst );
ADDRLP4 72
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 60
ADDRLP4 72
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 352
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 60+4
ADDRLP4 76
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 356
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 80
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 60+8
ADDRLP4 80
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 360
ADDP4
INDIRF4
ADDF4
ASGNF4
line 554
;554:	VectorSubtract( dst, src, dir );
ADDRLP4 48
ADDRLP4 60
INDIRF4
ADDRLP4 24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48+4
ADDRLP4 60+4
INDIRF4
ADDRLP4 24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48+8
ADDRLP4 60+8
INDIRF4
ADDRLP4 24+8
INDIRF4
SUBF4
ASGNF4
line 556
;555:
;556:	ClearMultiDamage(  );
ADDRGP4 ClearMultiDamage
CALLV
pop
line 557
;557:	VectorScale( dir, 2048, end );
ADDRLP4 48
ARGP4
CNSTF4 1157627904
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 558
;558:	VectorAdd( end, src, end );
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDF4
ASGNF4
line 559
;559:	traceline( PASSVEC3( src ), PASSVEC3( end ), 0, self );
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24+4
INDIRF4
ARGF4
ADDRLP4 24+8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 561
;560:
;561:	VectorScale( dir, 4, puff_org );
ADDRLP4 48
ARGP4
CNSTF4 1082130432
ARGF4
ADDRGP4 puff_org
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 562
;562:	VectorSubtract( g_globalvars.trace_endpos, puff_org, puff_org );
ADDRLP4 72
ADDRGP4 puff_org
ASGNP4
ADDRLP4 72
INDIRP4
ADDRGP4 g_globalvars+276
INDIRF4
ADDRLP4 72
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRGP4 puff_org+4
ADDRGP4 g_globalvars+276+4
INDIRF4
ADDRGP4 puff_org+4
INDIRF4
SUBF4
ASGNF4
ADDRGP4 puff_org+8
ADDRGP4 g_globalvars+276+8
INDIRF4
ADDRGP4 puff_org+8
INDIRF4
SUBF4
ASGNF4
ADDRGP4 $315
JUMPV
LABELV $314
line 564
;563:	while ( shotcount > 0 )
;564:	{
line 565
;565:		VectorScale( g_globalvars.v_right, crandom(  ) * spread_x, tmp );
ADDRLP4 72
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRGP4 g_globalvars+252
ARGP4
ADDRLP4 72
INDIRF4
ADDRFP4 8
INDIRF4
MULF4
ARGF4
ADDRLP4 36
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 566
;566:		VectorScale( g_globalvars.v_up, crandom(  ) * spread_y, direction );
ADDRLP4 76
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRGP4 g_globalvars+240
ARGP4
ADDRLP4 76
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 567
;567:		VectorAdd( direction, tmp, direction );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 568
;568:		VectorAdd( direction, dir, direction );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 48
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 48+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 48+8
INDIRF4
ADDF4
ASGNF4
line 569
;569:		VectorNormalize( direction );
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 571
;570:
;571:		VectorScale( direction, 2048, end );
ADDRLP4 0
ARGP4
CNSTF4 1157627904
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 572
;572:		VectorAdd( end, src, end );
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDF4
ASGNF4
line 573
;573:		traceline( PASSVEC3( src ), PASSVEC3( end ), 0, self );
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24+4
INDIRF4
ARGF4
ADDRLP4 24+8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 576
;574:
;575:
;576:		if ( g_globalvars.trace_fraction != 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $341
line 577
;577:		{
line 578
;578:			TraceAttack( 4, direction );
CNSTF4 1082130432
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 TraceAttack
CALLV
pop
line 579
;579:		}
LABELV $341
line 580
;580:		shotcount = shotcount - 1;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 581
;581:	}
LABELV $315
line 563
ADDRFP4 0
INDIRI4
CNSTI4 0
GTI4 $314
line 582
;582:	ApplyMultiDamage(  );
ADDRGP4 ApplyMultiDamage
CALLV
pop
line 583
;583:	Multi_Finish(  );
ADDRGP4 Multi_Finish
CALLV
pop
line 584
;584:}
LABELV $284
endproc FireSentryBulletsMTFL2 84 32
export FireSentryLighting
proc FireSentryLighting 140 32
line 588
;585:
;586://////////////////////////////////////////////////////////////////////////////
;587:void    FireSentryLighting( gedict_t * targ )  
;588:{
line 594
;589:	vec3_t  src;
;590:	vec3_t  dst;
;591:	vec3_t  dir, end,direction, tmp,norm_dir;
;592:	gedict_t*trace_ent;
;593:
;594:	switch( tf_data.sg_sfire )
ADDRLP4 88
ADDRGP4 tf_data+112
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
LTI4 $344
ADDRLP4 88
INDIRI4
CNSTI4 3
GTI4 $344
ADDRLP4 88
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $410
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $410
address $349
address $395
address $394
address $377
code
line 595
;595:	{
LABELV $349
line 597
;596:		case SG_SFIRE_NEW:
;597:			VectorCopy( self->s.v.angles, self->s.v.v_angle );
ADDRLP4 96
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 384
ADDP4
ADDRLP4 96
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
ASGNF4
ADDRLP4 100
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 388
ADDP4
ADDRLP4 100
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ASGNF4
ADDRLP4 104
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
CNSTI4 392
ADDP4
ADDRLP4 104
INDIRP4
CNSTI4 200
ADDP4
INDIRF4
ASGNF4
line 598
;598:			makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 600
;599:
;600:                	VectorAdd( self->s.v.origin, self->s.v.view_ofs, src );
ADDRLP4 96
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 96
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 96
INDIRP4
CNSTI4 352
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 100
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 100
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 100
INDIRP4
CNSTI4 356
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 104
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 104
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 104
INDIRP4
CNSTI4 360
ADDP4
INDIRF4
ADDF4
ASGNF4
line 601
;601:                	VectorAdd( targ->s.v.origin, targ->s.v.view_ofs, dst );
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 96
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 96
INDIRP4
CNSTI4 352
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24+4
ADDRLP4 100
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 100
INDIRP4
CNSTI4 356
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24+8
ADDRLP4 104
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 104
INDIRP4
CNSTI4 360
ADDP4
INDIRF4
ADDF4
ASGNF4
line 602
;602:                	VectorSubtract( dst, src, dir );
ADDRLP4 36
ADDRLP4 24
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36+8
ADDRLP4 24+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 604
;603:
;604:                	normalize(dir,norm_dir);
ADDRLP4 36
ARGP4
ADDRLP4 64
ARGP4
ADDRGP4 normalize
CALLV
pop
line 605
;605:                	traceline( PASSVEC3( src ), PASSVEC3( dst ), 0, self );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24+4
INDIRF4
ARGF4
ADDRLP4 24+8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 607
;606:
;607:               		if( (PROG_TO_EDICT(g_globalvars.trace_ent) == self->trigger_field) && vlen(dir) > 100 )
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
ADDRGP4 self
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
CVPU4 4
NEU4 $364
ADDRLP4 36
ARGP4
ADDRLP4 96
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 96
INDIRF4
CNSTF4 1120403456
LEF4 $364
line 608
;608:                	{
line 609
;609:                		 VectorScale(norm_dir, 60, tmp);
ADDRLP4 64
ARGP4
CNSTF4 1114636288
ARGF4
ADDRLP4 52
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 610
;610:                		 VectorAdd(src,tmp,src);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 52
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 52+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 52+8
INDIRF4
ADDF4
ASGNF4
line 611
;611:                	}
LABELV $364
line 612
;612:                	VectorCopy(dst,end);
ADDRLP4 12
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 24+4
INDIRF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 24+8
INDIRF4
ASGNF4
line 613
;613:			break;
ADDRGP4 $346
JUMPV
LABELV $377
line 615
;614:		case SG_SFIRE_MTFL2:
;615:        		VectorCopy( self->s.v.angles, self->s.v.v_angle );
ADDRLP4 100
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 384
ADDP4
ADDRLP4 100
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
ASGNF4
ADDRLP4 104
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
CNSTI4 388
ADDP4
ADDRLP4 104
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ASGNF4
ADDRLP4 108
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI4 392
ADDP4
ADDRLP4 108
INDIRP4
CNSTI4 200
ADDP4
INDIRF4
ASGNF4
line 616
;616:        		makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 617
;617:        		VectorAdd( self->s.v.origin, self->s.v.view_ofs, src );
ADDRLP4 100
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 100
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 100
INDIRP4
CNSTI4 352
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 104
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 104
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 104
INDIRP4
CNSTI4 356
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 108
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 108
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 108
INDIRP4
CNSTI4 360
ADDP4
INDIRF4
ADDF4
ASGNF4
line 618
;618:        		VectorAdd( targ->s.v.origin, targ->s.v.view_ofs, dst );
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 100
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 100
INDIRP4
CNSTI4 352
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24+4
ADDRLP4 104
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 104
INDIRP4
CNSTI4 356
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24+8
ADDRLP4 108
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 108
INDIRP4
CNSTI4 360
ADDP4
INDIRF4
ADDF4
ASGNF4
line 620
;619:
;620:        		VectorSubtract( dst, src, dir );
ADDRLP4 36
ADDRLP4 24
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36+8
ADDRLP4 24+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 621
;621:        		VectorNormalize( direction );
ADDRLP4 76
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 622
;622:        		VectorScale( dir, 2048, end );
ADDRLP4 36
ARGP4
CNSTF4 1157627904
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 623
;623:        		VectorAdd( end, src, end );
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 624
;624:        		break;
ADDRGP4 $346
JUMPV
LABELV $394
line 627
;625:
;626:		case SG_SFIRE_MTFL1:
;627:			VectorCopy( self->s.v.angles, self->s.v.v_angle );
ADDRLP4 100
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 384
ADDP4
ADDRLP4 100
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
ASGNF4
ADDRLP4 104
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
CNSTI4 388
ADDP4
ADDRLP4 104
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ASGNF4
ADDRLP4 108
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI4 392
ADDP4
ADDRLP4 108
INDIRP4
CNSTI4 200
ADDP4
INDIRF4
ASGNF4
LABELV $395
line 629
;628:		case SG_SFIRE_281:
;629:        		makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 630
;630:        		VectorScale( g_globalvars.v_forward, 10, src );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1092616192
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 631
;631:        		VectorAdd( self->s.v.origin, src, src );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 632
;632:        		src[2] = self->s.v.absmin[2] + self->s.v.size[2] * 0.7;
ADDRLP4 100
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 100
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CNSTF4 1060320051
ADDRLP4 100
INDIRP4
CNSTI4 268
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 633
;633:        		VectorSubtract( targ->s.v.origin, self->s.v.origin, dir );
ADDRLP4 104
CNSTI4 156
ASGNI4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ADDRLP4 104
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 104
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 108
CNSTI4 160
ASGNI4
ADDRLP4 36+4
ADDRFP4 0
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 112
CNSTI4 164
ASGNI4
ADDRLP4 36+8
ADDRFP4 0
INDIRP4
ADDRLP4 112
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 112
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 634
;634:        		VectorScale( dir, 2048, end );
ADDRLP4 36
ARGP4
CNSTF4 1157627904
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 635
;635:        		VectorAdd( end, src, end );
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 636
;636:        		break;
line 638
;637:		default:
;638:			return;
LABELV $346
line 640
;639:	}
;640:	g_globalvars.trace_ent = 0;
ADDRGP4 g_globalvars+304
CNSTI4 0
ASGNI4
line 642
;641:
;642:	traceline( PASSVEC3( src ), PASSVEC3( end ), 0, self );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 645
;643:	
;644:
;645:	trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 646
;646:	trap_WriteByte( MSG_MULTICAST, TE_LIGHTNING2 );
CNSTI4 4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 647
;647:	WriteEntity( MSG_MULTICAST, self );
CNSTI4 4
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 WriteEntity
CALLV
pop
line 648
;648:	trap_WriteCoord( MSG_MULTICAST, src[0] );
CNSTI4 4
ARGI4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 649
;649:	trap_WriteCoord( MSG_MULTICAST, src[1] );
CNSTI4 4
ARGI4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 650
;650:	trap_WriteCoord( MSG_MULTICAST, src[2] );
CNSTI4 4
ARGI4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 651
;651:	trap_WriteCoord( MSG_MULTICAST, g_globalvars.trace_endpos[0] );
CNSTI4 4
ARGI4
ADDRGP4 g_globalvars+276
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 652
;652:	trap_WriteCoord( MSG_MULTICAST, g_globalvars.trace_endpos[1] );
CNSTI4 4
ARGI4
ADDRGP4 g_globalvars+276+4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 653
;653:	trap_WriteCoord( MSG_MULTICAST, g_globalvars.trace_endpos[2] );
CNSTI4 4
ARGI4
ADDRGP4 g_globalvars+276+8
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 654
;654:	trap_multicast( PASSVEC3( src ), 1 );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 655
;655:	if ( g_globalvars.trace_ent )
ADDRGP4 g_globalvars+304
INDIRI4
CNSTI4 0
EQI4 $425
line 656
;656:	{
line 657
;657:		trace_ent = PROG_TO_EDICT(g_globalvars.trace_ent);
ADDRLP4 48
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 658
;658:		if ( streq( trace_ent->s.v.classname, "player" ) )
ADDRLP4 48
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 96
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $429
line 659
;659:		{
line 660
;660:            switch((int)( g_random(  ) * 30) )  
ADDRLP4 104
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 100
CNSTF4 1106247680
ADDRLP4 104
INDIRF4
MULF4
CVFI4 4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
LTI4 $432
ADDRLP4 100
INDIRI4
CNSTI4 6
GTI4 $432
ADDRLP4 100
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $447
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $447
address $434
address $436
address $437
address $439
address $441
address $443
address $445
code
line 661
;661:			{
LABELV $434
line 663
;662:				case 0:
;663:					sound( trace_ent, 2, "player/pain1.wav" , 1, 1 );
ADDRLP4 48
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $435
ARGP4
ADDRLP4 112
CNSTF4 1065353216
ASGNF4
ADDRLP4 112
INDIRF4
ARGF4
ADDRLP4 112
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 664
;664:					break;
ADDRGP4 $432
JUMPV
LABELV $436
line 666
;665:				case 1:
;666:					sound( trace_ent, 2, "player/pain1.wav" , 1, 1 );
ADDRLP4 48
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $435
ARGP4
ADDRLP4 116
CNSTF4 1065353216
ASGNF4
ADDRLP4 116
INDIRF4
ARGF4
ADDRLP4 116
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 667
;667:					break;
ADDRGP4 $432
JUMPV
LABELV $437
line 669
;668:				case 2:
;669:					sound( trace_ent, 2, "player/pain2.wav" , 1, 1 );
ADDRLP4 48
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $438
ARGP4
ADDRLP4 120
CNSTF4 1065353216
ASGNF4
ADDRLP4 120
INDIRF4
ARGF4
ADDRLP4 120
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 670
;670:					break;
ADDRGP4 $432
JUMPV
LABELV $439
line 672
;671:				case 3:
;672:					sound( trace_ent, 2, "player/pain3.wav" , 1, 1 );
ADDRLP4 48
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $440
ARGP4
ADDRLP4 124
CNSTF4 1065353216
ASGNF4
ADDRLP4 124
INDIRF4
ARGF4
ADDRLP4 124
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 673
;673:					break;
ADDRGP4 $432
JUMPV
LABELV $441
line 675
;674:				case 4:
;675:					sound( trace_ent, 2, "player/pain4.wav" , 1, 1 );
ADDRLP4 48
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $442
ARGP4
ADDRLP4 128
CNSTF4 1065353216
ASGNF4
ADDRLP4 128
INDIRF4
ARGF4
ADDRLP4 128
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 676
;676:					break;
ADDRGP4 $432
JUMPV
LABELV $443
line 678
;677:				case 5:
;678:					sound( trace_ent, 2, "player/pain5.wav" , 1, 1 );
ADDRLP4 48
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $444
ARGP4
ADDRLP4 132
CNSTF4 1065353216
ASGNF4
ADDRLP4 132
INDIRF4
ARGF4
ADDRLP4 132
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 679
;679:					break;
ADDRGP4 $432
JUMPV
LABELV $445
line 681
;680:				case 6:
;681:					sound( trace_ent, 2, "player/pain6.wav" , 1, 1 );
ADDRLP4 48
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $446
ARGP4
ADDRLP4 136
CNSTF4 1065353216
ASGNF4
ADDRLP4 136
INDIRF4
ARGF4
ADDRLP4 136
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 682
;682:					break;
line 683
;683:				default:break;
LABELV $432
line 685
;684:			}
;685:		}
LABELV $429
line 686
;686:	}
LABELV $425
line 687
;687:}
LABELV $344
endproc FireSentryLighting 140 32
export LaunchSGRocketOLD
proc LaunchSGRocketOLD 32 28
line 690
;688://////////////////////////////////////////////////////////////////////////////
;689:void LaunchSGRocketOLD(gedict_t*targ)
;690:{
line 693
;691:		vec3_t   vtemp;
;692:
;693:       	newmis = spawn(  );
ADDRLP4 12
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 12
INDIRP4
ASGNP4
line 694
;694:       	g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 695
;695:       	newmis->s.v.owner = EDICT_TO_PROG( self );
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
line 696
;696:       	newmis->s.v.movetype = MOVETYPE_FLYMISSILE;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1091567616
ASGNF4
line 697
;697:       	newmis->s.v.solid = SOLID_BBOX;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 700
;698:
;699:
;700:       	newmis->s.v.weapon = DMSG_SENTRYGUN_ROCKET;
ADDRGP4 newmis
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1107820544
ASGNF4
line 701
;701:       	newmis->s.v.touch = ( func_t ) T_MissileTouch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 T_MissileTouch
CVPU4 4
CVUI4 4
ASGNI4
line 702
;702:       	newmis->s.v.nextthink = g_globalvars.time + 5;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 703
;703:       	newmis->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 705
;704:       	
;705:       	setmodel( newmis, "progs/missile.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $451
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 706
;706:       	setsize( newmis, 0, 0, 0, 0, 0, 0 );
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
line 708
;707:
;708:       	VectorSubtract( targ->s.v.origin, self->s.v.origin, newmis->s.v.velocity );
ADDRLP4 20
CNSTI4 156
ASGNI4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24
CNSTI4 160
ASGNI4
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28
CNSTI4 164
ASGNI4
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 709
;709:       	VectorNormalize( newmis->s.v.velocity );
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 710
;710:       	VectorScale( newmis->s.v.velocity, 800, newmis->s.v.velocity );
ADDRLP4 20
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 1145569280
ARGF4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 712
;711:       	
;712:       	vectoangles( newmis->s.v.velocity, newmis->s.v.angles );
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
line 714
;713:
;714:       	makevectors( self->s.v.angles);
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 715
;715:       	VectorScale( g_globalvars.v_forward, 8, vtemp );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1090519040
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 716
;716:       	VectorAdd( vtemp, self->s.v.origin, vtemp );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDF4
ASGNF4
line 717
;717:       	vtemp[2] += 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 718
;718:       	setorigin( newmis, PASSVEC3( vtemp ) );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 721
;719:
;720:
;721:}
LABELV $448
endproc LaunchSGRocketOLD 32 28
export CheckAim
proc CheckAim 28 12
line 724
;722://////////////////////////////////////////////////////////////////////////////
;723:int CheckAim(vec3_t src, gedict_t*targ, float vel, float time,vec3_t vTarget)
;724:{
line 729
;725:	vec3_t  vtemp;
;726:	float dist;
;727:
;728:	
;729:        VectorScale(targ->s.v.velocity,time ,vTarget);
ADDRFP4 4
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 730
;730:        VectorAdd(vTarget, targ->s.v.origin, vTarget);
ADDRLP4 16
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 20
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 24
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDF4
ASGNF4
line 735
;731:
;732://        VectorScale(self->accel,time*time*0.5,vtemp);
;733://        VectorAdd(vTarget, vtemp, vTarget);
;734:
;735:	if(!((int)targ->s.v.flags & FL_ONGROUND ))
ADDRFP4 4
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $461
line 736
;736:	{
line 738
;737:		
;738:		vTarget[2] -= 0.5*time*time*sv_gravity;
ADDRLP4 16
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 20
ADDRFP4 12
INDIRF4
ASGNF4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 20
INDIRF4
MULF4
ADDRLP4 20
INDIRF4
MULF4
ADDRGP4 sv_gravity
INDIRF4
MULF4
SUBF4
ASGNF4
line 739
;739:	}
LABELV $461
line 741
;740:
;741:	VectorSubtract(vTarget, src, vtemp);
ADDRLP4 0
ADDRFP4 16
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 16
CNSTI4 4
ASGNI4
ADDRLP4 0+4
ADDRFP4 16
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20
CNSTI4 8
ASGNI4
ADDRLP4 0+8
ADDRFP4 16
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 742
;742:	dist = vlen(vtemp);
ADDRLP4 0
ARGP4
ADDRLP4 16
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 16
INDIRF4
ASGNF4
line 743
;743:	if( fabs(vel*(time+0.05) - dist) < 40)
ADDRFP4 8
INDIRF4
ADDRFP4 12
INDIRF4
CNSTF4 1028443341
ADDF4
MULF4
ADDRLP4 12
INDIRF4
SUBF4
ARGF4
ADDRLP4 20
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 20
INDIRF4
CNSTF4 1109393408
GEF4 $465
line 744
;744:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $460
JUMPV
LABELV $465
line 746
;745:	else 
;746:		return 0;
CNSTI4 0
RETI4
LABELV $460
endproc CheckAim 28 12
export LaunchSGRocketNEW
proc LaunchSGRocketNEW 84 32
line 750
;747:
;748:}
;749:void LaunchSGRocketNEW(gedict_t*targ)
;750:{
line 756
;751:	vec3_t   vtemp,dir,norm_dir;
;752:	vec3_t  src;
;753:	vec3_t  dst;
;754:	float time;
;755:
;756:       	newmis = spawn(  );
ADDRLP4 64
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 64
INDIRP4
ASGNP4
line 757
;757:       	g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 758
;758:       	newmis->s.v.owner = EDICT_TO_PROG( self );
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
line 759
;759:       	newmis->s.v.movetype = MOVETYPE_FLYMISSILE;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1091567616
ASGNF4
line 760
;760:       	newmis->s.v.solid = SOLID_BBOX;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 763
;761:
;762:
;763:       	newmis->s.v.weapon = DMSG_SENTRYGUN_ROCKET;
ADDRGP4 newmis
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1107820544
ASGNF4
line 764
;764:       	newmis->s.v.touch = ( func_t ) T_MissileTouch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 T_MissileTouch
CVPU4 4
CVUI4 4
ASGNI4
line 765
;765:       	newmis->s.v.nextthink = g_globalvars.time + 5;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 766
;766:       	newmis->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 768
;767:       	
;768:       	setmodel( newmis, "progs/missile.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $451
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 769
;769:       	setsize( newmis, 0, 0, 0, 0, 0, 0 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 68
CNSTF4 0
ASGNF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 773
;770:
;771://try fire to targ origin
;772:
;773:       	makevectors( self->s.v.angles);
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 774
;774:       	VectorScale( g_globalvars.v_forward, 8, vtemp );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1090519040
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 775
;775:       	VectorAdd( vtemp, self->s.v.origin, src );
ADDRLP4 12
ADDRLP4 0
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDF4
ASGNF4
line 776
;776:       	src[2] += 16;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 779
;777:
;778:	
;779:	VectorCopy( targ->s.v.origin, dst );
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24+4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24+8
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 780
;780:	VectorSubtract( dst, src, dir );
ADDRLP4 40
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40+8
ADDRLP4 24+8
INDIRF4
ADDRLP4 12+8
INDIRF4
SUBF4
ASGNF4
line 782
;781:
;782:	normalize(dir,norm_dir);
ADDRLP4 40
ARGP4
ADDRLP4 52
ARGP4
ADDRGP4 normalize
CALLV
pop
line 785
;783:
;784:	//чтобы не попадать в подставку
;785:	traceline( PASSVEC3( src ), PASSVEC3( dst ), 0, self );
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24+4
INDIRF4
ARGF4
ADDRLP4 24+8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 787
;786:	
;787:	if( (PROG_TO_EDICT(g_globalvars.trace_ent) == self->trigger_field) && vlen(dir) > 100 )
ADDRGP4 g_globalvars+304
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
ADDRGP4 self
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
CVPU4 4
NEU4 $488
ADDRLP4 40
ARGP4
ADDRLP4 72
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 72
INDIRF4
CNSTF4 1120403456
LEF4 $488
line 788
;788:	{
line 789
;789:		 VectorScale(norm_dir, 60, vtemp);
ADDRLP4 52
ARGP4
CNSTF4 1114636288
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 790
;790:		 VectorAdd(src,vtemp,src);
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 791
;791:	}
LABELV $488
line 793
;792:
;793:	traceline( PASSVEC3( src ), PASSVEC3( dst ), 1, self );
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24+4
INDIRF4
ARGF4
ADDRLP4 24+8
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 795
;794:
;795:	if( g_globalvars.trace_fraction != 1 && vlen(dir) > 100 ) //FIX ME can shot trown wall??
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $501
ADDRLP4 40
ARGP4
ADDRLP4 76
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 76
INDIRF4
CNSTF4 1120403456
LEF4 $501
line 796
;796:	{
line 797
;797:		 VectorScale(norm_dir, 60, vtemp);
ADDRLP4 52
ARGP4
CNSTF4 1114636288
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 798
;798:		 VectorAdd(src,vtemp,src);
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 799
;799:	}
LABELV $501
line 802
;800:
;801:
;802:       	setorigin( newmis, PASSVEC3( src ) );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 804
;803://prediction
;804:        for ( time = 0 ; time < 3 ; time+=0.05 )
ADDRLP4 36
CNSTF4 0
ASGNF4
ADDRGP4 $515
JUMPV
LABELV $512
line 805
;805:        {
line 806
;806:        	if(CheckAim(src,targ,800,time,vtemp))
ADDRLP4 12
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1145569280
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 0
ARGP4
ADDRLP4 80
ADDRGP4 CheckAim
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $516
line 807
;807:        	{
line 808
;808:        	        traceline( PASSVEC3( src ), PASSVEC3( vtemp ), 1, self );
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 809
;809:        	        if( g_globalvars.trace_fraction != 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $522
line 810
;810:        	        	continue;
ADDRGP4 $513
JUMPV
LABELV $522
line 811
;811:        	        VectorCopy(vtemp,dst);
ADDRLP4 24
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 0+4
INDIRF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 0+8
INDIRF4
ASGNF4
line 812
;812:        		break;
ADDRGP4 $514
JUMPV
LABELV $516
line 814
;813:        	}
;814:        }
LABELV $513
line 804
ADDRLP4 36
ADDRLP4 36
INDIRF4
CNSTF4 1028443341
ADDF4
ASGNF4
LABELV $515
ADDRLP4 36
INDIRF4
CNSTF4 1077936128
LTF4 $512
LABELV $514
line 815
;815:        if((int)targ->s.v.flags & FL_ONGROUND )
ADDRFP4 0
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $529
line 816
;816:        {
line 817
;817: 	        VectorAdd(dst,targ->s.v.mins,vtemp);
ADDRLP4 0
ADDRLP4 24
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24+4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ADDF4
ASGNF4
line 819
;818:
;819: 	        traceline( PASSVEC3( src ), PASSVEC3( vtemp ), 1, self );
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 820
;820: 	        if(g_globalvars.trace_fraction == 1)
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
NEF4 $530
line 821
;821: 	        	VectorCopy(vtemp,dst);
ADDRLP4 24
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 0+4
INDIRF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 0+8
INDIRF4
ASGNF4
line 822
;822:        }else
ADDRGP4 $530
JUMPV
LABELV $529
line 823
;823:        {
line 825
;824:#define MAX_BOTTOM_DISTANCE  100
;825:                VectorCopy(dst,vtemp);
ADDRLP4 0
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24+4
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 24+8
INDIRF4
ASGNF4
line 826
;826:                vtemp[2] -= MAX_BOTTOM_DISTANCE;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 827
;827:                traceline( PASSVEC3( dst ), PASSVEC3( vtemp ), 1, self );
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24+4
INDIRF4
ARGF4
ADDRLP4 24+8
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 828
;828:                if(g_globalvars.trace_fraction != 1)
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $555
line 829
;829:                {
line 830
;830:                	vtemp[2] = dst[2] - MAX_BOTTOM_DISTANCE*g_globalvars.trace_fraction;
ADDRLP4 0+8
ADDRLP4 24+8
INDIRF4
CNSTF4 1120403456
ADDRGP4 g_globalvars+272
INDIRF4
MULF4
SUBF4
ASGNF4
line 831
;831:                	traceline( PASSVEC3( dst ), PASSVEC3( vtemp ), 1, self );
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24+4
INDIRF4
ARGF4
ADDRLP4 24+8
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 832
;832: 	        	if(g_globalvars.trace_fraction == 1)
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
NEF4 $565
line 833
;833: 	        		VectorCopy(vtemp,dst);
ADDRLP4 24
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 0+4
INDIRF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 0+8
INDIRF4
ASGNF4
LABELV $565
line 834
;834:                }
LABELV $555
line 835
;835:        }
LABELV $530
line 846
;836:
;837:#ifdef DEBUG_SG
;838:	trap_WriteByte(MULTICAST_PHS_R, SVC_TEMPENTITY);
;839:	trap_WriteByte(MULTICAST_PHS_R, TE_TAREXPLOSION);
;840:	trap_WriteCoord(MULTICAST_PHS_R, dst[0]);
;841:	trap_WriteCoord(MULTICAST_PHS_R, dst[1]);
;842:	trap_WriteCoord(MULTICAST_PHS_R, dst[2]);
;843:	trap_multicast(PASSVEC3(dst), 1);
;844:#endif
;845:
;846:       	VectorSubtract( dst, src, dir );
ADDRLP4 40
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40+8
ADDRLP4 24+8
INDIRF4
ADDRLP4 12+8
INDIRF4
SUBF4
ASGNF4
line 847
;847:       	normalize(dir,norm_dir);
ADDRLP4 40
ARGP4
ADDRLP4 52
ARGP4
ADDRGP4 normalize
CALLV
pop
line 848
;848:       	VectorScale( norm_dir, 800, newmis->s.v.velocity );
ADDRLP4 52
ARGP4
CNSTF4 1145569280
ARGF4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 850
;849:
;850:       	vectoangles( newmis->s.v.velocity, newmis->s.v.angles );
ADDRLP4 80
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 80
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 851
;851:}
LABELV $467
endproc LaunchSGRocketNEW 84 32
export Sentry_Fire
proc Sentry_Fire 80 20
line 855
;852:
;853://////////////////////////////////////////////////////////////////////////////
;854:int Sentry_Fire(  )
;855:{
line 858
;856:	vec3_t  dir;
;857:
;858:	gedict_t *enemy = PROG_TO_EDICT( self->s.v.enemy );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 860
;859:
;860:	self->s.v.effects = ( int ) self->s.v.effects - ( ( int ) self->s.v.effects & EF_DIMLIGHT );
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRI4
ADDRLP4 20
INDIRI4
CNSTI4 8
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 862
;861:
;862:	if ( tg_data.sg_disable_fire )
ADDRGP4 tg_data+44
INDIRI4
CNSTI4 0
EQI4 $579
line 863
;863:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $578
JUMPV
LABELV $579
line 865
;864:
;865:	VectorSubtract( enemy->s.v.origin, self->s.v.origin, dir );
ADDRLP4 24
CNSTI4 156
ASGNI4
ADDRLP4 4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28
CNSTI4 160
ASGNI4
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32
CNSTI4 164
ASGNI4
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 866
;866:	if ( self->s.v.ideal_yaw - anglemod( self->s.v.angles[1] ) < -10
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRLP4 24
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
SUBF4
CNSTF4 3240099840
LTF4 $586
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRLP4 32
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDRLP4 36
INDIRF4
SUBF4
CNSTF4 1092616192
LEF4 $584
LABELV $586
line 868
;867:	     || self->s.v.ideal_yaw - anglemod( self->s.v.angles[1] ) > 10 )
;868:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $578
JUMPV
LABELV $584
line 869
;869:	if ( enemy->is_feigning == 1 )
ADDRLP4 0
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 1
NEI4 $587
line 870
;870:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $578
JUMPV
LABELV $587
line 872
;871:
;872:	sound( self, 1, "weapons/plaser.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $589
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
line 874
;873:	// Level 3 Turrets fire rockets every 3 seconds
;874:	if (  tg_data.sg_fire_rockets && self->s.v.weapon == 3 && 
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRGP4 tg_data+52
INDIRI4
ADDRLP4 44
INDIRI4
EQI4 $590
ADDRLP4 48
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $590
ADDRLP4 48
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 0
GTF4 $595
ADDRGP4 tg_data+60
INDIRI4
ADDRLP4 44
INDIRI4
EQI4 $590
LABELV $595
ADDRGP4 self
INDIRP4
CNSTI4 740
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $590
line 877
;875:	       ( (self->s.v.ammo_rockets > 0 ) || ( tg_data.sg_unlimit_ammo) )
;876:		&& self->super_damage_finished < g_globalvars.time )
;877:	{
line 878
;878:		Sentry_MuzzleFlash(  );
ADDRGP4 Sentry_MuzzleFlash
CALLV
pop
line 881
;879://		sound( self, 1, "weapons/rocket1i.wav", 1, 1 );
;880:
;881:	        if( tf_data.sg_rfire )
ADDRGP4 tf_data+116
INDIRI4
CNSTI4 0
EQI4 $596
line 882
;882:	        	LaunchSGRocketNEW(enemy);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 LaunchSGRocketNEW
CALLV
pop
ADDRGP4 $597
JUMPV
LABELV $596
line 884
;883:	        else
;884:	        	LaunchSGRocketOLD(enemy); 
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 LaunchSGRocketOLD
CALLV
pop
LABELV $597
line 886
;885:
;886:		self->super_damage_finished = g_globalvars.time + 3;
ADDRGP4 self
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1077936128
ADDF4
ASGNF4
line 887
;887:                if( !tg_data.sg_unlimit_ammo ) 
ADDRGP4 tg_data+60
INDIRI4
CNSTI4 0
NEI4 $600
line 888
;888:		      self->s.v.ammo_rockets = self->s.v.ammo_rockets - 1;
ADDRLP4 52
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
LABELV $600
line 890
;889:
;890:		if ( self->s.v.ammo_rockets == 10 )
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1092616192
NEF4 $603
line 891
;891:			G_sprint( self->real_owner, 2, "Sentry Gun is low on rockets.\n" );
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $605
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $603
line 892
;892:	}
LABELV $590
line 893
;893:	if ( tg_data.sg_fire_lighting )
ADDRGP4 tg_data+56
INDIRI4
CNSTI4 0
EQI4 $606
line 894
;894:	{
line 895
;895:		FireSentryLighting( PROG_TO_EDICT(self->s.v.enemy) );
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRGP4 FireSentryLighting
CALLV
pop
line 897
;896:		//return 1;
;897:	}
LABELV $606
line 898
;898:	if ( tg_data.sg_fire_bullets )
ADDRGP4 tg_data+48
INDIRI4
CNSTI4 0
EQI4 $609
line 899
;899:	{
line 900
;900:        	tf_data.deathmsg = DMSG_SENTRYGUN_BULLET;
ADDRGP4 tf_data+88
CNSTI4 27
ASGNI4
line 902
;901:
;902:        	if( !tg_data.sg_unlimit_ammo ) 
ADDRGP4 tg_data+60
INDIRI4
CNSTI4 0
NEI4 $613
line 903
;903:        	{
line 904
;904:        	       self->s.v.ammo_shells = self->s.v.ammo_shells - 1;
ADDRLP4 52
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 905
;905:        	       if ( self->s.v.ammo_shells < 0 )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 0
GEF4 $616
line 906
;906:                       {
line 907
;907:                		self->s.v.ammo_shells = 0;
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
CNSTF4 0
ASGNF4
line 908
;908:                		return 0;
CNSTI4 0
RETI4
ADDRGP4 $578
JUMPV
LABELV $616
line 910
;909:                       }
;910:        	}
LABELV $613
line 911
;911:        	Sentry_MuzzleFlash(  );
ADDRGP4 Sentry_MuzzleFlash
CALLV
pop
line 914
;912://        	sound( self, 1, "weapons/sniper.wav", 1, 1 );
;913:
;914:                switch(tf_data.sg_sfire)
ADDRLP4 52
ADDRGP4 tf_data+112
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
LTI4 $618
ADDRLP4 52
INDIRI4
CNSTI4 3
GTI4 $618
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $628
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $628
address $625
address $623
address $622
address $624
code
line 915
;915:                {
LABELV $622
line 918
;916:                	
;917:                	case SG_SFIRE_MTFL1:
;918:        			VectorCopy( self->s.v.angles, self->s.v.v_angle );
ADDRLP4 60
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 384
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
ASGNF4
ADDRLP4 64
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 388
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ASGNF4
ADDRLP4 68
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 392
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 200
ADDP4
INDIRF4
ASGNF4
LABELV $623
line 920
;919:        		case SG_SFIRE_281:
;920:        			FireBullets( 4, dir, 0.1, 0.1, 0 );
CNSTF4 1082130432
ARGF4
ADDRLP4 4
ARGP4
ADDRLP4 60
CNSTF4 1036831949
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 FireBullets
CALLV
pop
line 921
;921:                		break;
ADDRGP4 $619
JUMPV
LABELV $624
line 923
;922:                	case SG_SFIRE_MTFL2:
;923:        			VectorCopy( self->s.v.angles, self->s.v.v_angle );
ADDRLP4 64
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 384
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
ASGNF4
ADDRLP4 68
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 388
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ASGNF4
ADDRLP4 72
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 392
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 200
ADDP4
INDIRF4
ASGNF4
line 924
;924:        			FireSentryBulletsMTFL2( 4, enemy, 0.1, 0.1, 0 );
CNSTI4 4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 64
CNSTF4 1036831949
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 FireSentryBulletsMTFL2
CALLV
pop
line 925
;925:        			break;
ADDRGP4 $619
JUMPV
LABELV $625
line 927
;926:                	case SG_SFIRE_NEW:
;927:        			VectorCopy( self->s.v.angles, self->s.v.v_angle );
ADDRLP4 68
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 384
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
ASGNF4
ADDRLP4 72
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 388
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ASGNF4
ADDRLP4 76
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 392
ADDP4
ADDRLP4 76
INDIRP4
CNSTI4 200
ADDP4
INDIRF4
ASGNF4
line 928
;928:        			FireSentryBulletsNEW( 4, enemy, 0.1, 0.1, 0 );
CNSTI4 4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 68
CNSTF4 1036831949
ASGNF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 FireSentryBulletsNEW
CALLV
pop
line 929
;929:        			break;
ADDRGP4 $619
JUMPV
LABELV $618
line 931
;930:                	default:
;931:                		G_Error("Unknown SG TYPE %d\n",tf_data.sg_sfire);
ADDRGP4 $626
ARGP4
ADDRGP4 tf_data+112
INDIRI4
ARGI4
ADDRGP4 G_Error
CALLV
pop
line 933
;932:                
;933:                }
LABELV $619
line 934
;934:	}
LABELV $609
line 936
;935:        // Warn owner that it's low on ammo
;936:        if( !tg_data.sg_unlimit_ammo && tg_data.sg_fire_bullets )
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRGP4 tg_data+60
INDIRI4
ADDRLP4 52
INDIRI4
NEI4 $629
ADDRGP4 tg_data+48
INDIRI4
ADDRLP4 52
INDIRI4
EQI4 $629
line 937
;937:        {
line 938
;938:              	if ( self->s.v.ammo_shells <=0 && g_random(  ) < 0.1 )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 0
GTF4 $633
ADDRLP4 56
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 56
INDIRF4
CNSTF4 1036831949
GEF4 $633
line 939
;939:              		G_sprint( self->real_owner, 2, "Sentry Gun is out of shells.\n" );
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $635
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $634
JUMPV
LABELV $633
line 941
;940:              	else
;941:              	{
line 942
;942:              		if ( self->s.v.ammo_shells == 20 )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1101004800
NEF4 $636
line 943
;943:              			G_sprint( self->real_owner, 2, "Sentry Gun is low on shells.\n" );
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $638
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $636
line 944
;944:              	}
LABELV $634
line 945
;945:        }
LABELV $629
line 946
;946:        if( !tg_data.sg_unlimit_ammo && tg_data.sg_fire_rockets )
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRGP4 tg_data+60
INDIRI4
ADDRLP4 56
INDIRI4
NEI4 $639
ADDRGP4 tg_data+52
INDIRI4
ADDRLP4 56
INDIRI4
EQI4 $639
line 947
;947:	       if ( self->s.v.ammo_rockets <= 0 && self->s.v.weapon == 3 && g_random(  ) < 0.1 )
ADDRLP4 60
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 0
GTF4 $643
ADDRLP4 60
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $643
ADDRLP4 64
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 64
INDIRF4
CNSTF4 1036831949
GEF4 $643
line 948
;948:        		G_sprint( self->real_owner, 2, "Sentry Gun is out of rockets.\n" );
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $645
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $643
LABELV $639
line 949
;949:	return 1;
CNSTI4 1
RETI4
LABELV $578
endproc Sentry_Fire 80 20
export Sentry_MuzzleFlash
proc Sentry_MuzzleFlash 4 0
line 953
;950:}
;951:
;952:void Sentry_MuzzleFlash(  )
;953:{
line 954
;954:	self->s.v.effects = ( int ) self->s.v.effects | 8;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 8
BORI4
CVIF4 4
ASGNF4
line 955
;955:}
LABELV $646
endproc Sentry_MuzzleFlash 4 0
export Eng_StaticSG_Activate
proc Eng_StaticSG_Activate 40 16
line 958
;956:
;957:void Eng_StaticSG_Activate(  )
;958:{
line 963
;959:	gedict_t *ent;
;960:	gedict_t *pl;
;961:	float   failed;
;962:
;963:	for ( ent = world; (ent = trap_find( ent, FOFS( s.v.classname ), "building_sentrygun" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $651
JUMPV
LABELV $648
line 964
;964:	{
line 965
;965:		failed = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 966
;966:		if ( ent->has_sentry && !ent->s.v.takedamage )
ADDRLP4 0
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
CNSTI4 0
EQI4 $653
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
NEF4 $653
line 967
;967:		{
line 968
;968:			for ( pl = world; (pl = findradius( pl, ent->s.v.origin, 64 )); )
ADDRLP4 4
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $658
JUMPV
LABELV $655
line 969
;969:			{
line 970
;970:				if ( streq( pl->s.v.classname, "player" ) )
ADDRLP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $152
ARGP4
ADDRLP4 16
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $659
line 971
;971:				{
line 972
;972:					G_bprint( 2, "Static sentry too close to player\n" );
CNSTI4 2
ARGI4
ADDRGP4 $661
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 973
;973:					failed = 1;
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
line 974
;974:				}
LABELV $659
line 975
;975:			}
LABELV $656
line 968
LABELV $658
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
ARGP4
CNSTF4 1115684864
ARGF4
ADDRLP4 16
ADDRGP4 findradius
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $655
line 976
;976:			if ( trap_pointcontents( PASSVEC3(ent->s.v.origin) ) == -6 )
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
ADDRLP4 24
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 -6
NEI4 $662
line 977
;977:			{
line 978
;978:				G_bprint( 2, "ERROR: Sentry gun felt off the level\n" );
CNSTI4 2
ARGI4
ADDRGP4 $664
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 979
;979:				failed = 1;
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
line 980
;980:				ent->real_owner->has_sentry = ent->real_owner->has_sentry - 1;
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 1000
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 981
;981:				dremove( ent->trigger_field );
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 982
;982:				dremove( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 983
;983:			}
LABELV $662
line 984
;984:			if ( !failed )
ADDRLP4 8
INDIRF4
CNSTF4 0
NEF4 $665
line 985
;985:			{
line 986
;986:				setmodel( ent, "progs/turrgun.mdl" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $223
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 987
;987:				setmodel( ent->trigger_field, "progs/turrbase.mdl" );
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
ARGP4
ADDRGP4 $667
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 988
;988:				if ( ent->s.v.weapon == 1 )
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $668
line 989
;989:					ent->s.v.think = ( func_t ) lvl1_sentry_stand;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl1_sentry_stand
CVPU4 4
CVUI4 4
ASGNI4
ADDRGP4 $669
JUMPV
LABELV $668
line 991
;990:				else
;991:				{
line 992
;992:					if ( ent->s.v.weapon == 2 )
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $670
line 993
;993:						ent->s.v.think = ( func_t ) lvl2_sentry_stand;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl2_sentry_stand
CVPU4 4
CVUI4 4
ASGNI4
ADDRGP4 $671
JUMPV
LABELV $670
line 995
;994:					else
;995:						ent->s.v.think = ( func_t ) lvl3_sentry_stand;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl3_sentry_stand
CVPU4 4
CVUI4 4
ASGNI4
LABELV $671
line 996
;996:				}
LABELV $669
line 997
;997:				ent->s.v.nextthink = g_globalvars.time + 0.1;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 998
;998:				ent->s.v.movetype = MOVETYPE_STEP;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1082130432
ASGNF4
line 999
;999:				ent->s.v.solid = SOLID_BBOX;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 1000
;1000:				ent->trigger_field->s.v.movetype = MOVETYPE_TOSS;
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 1001
;1001:				ent->trigger_field->s.v.solid = SOLID_BBOX;
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 1002
;1002:				ent->s.v.takedamage = 2;
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 1073741824
ASGNF4
line 1003
;1003:				ent->s.v.health = ent->s.v.max_health;
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
line 1007
;1004:
;1005:				//ent->trigger_field->s.v.origin[2] += 1;
;1006:				//ent->s.v.origin[2] += 1;
;1007:				setorigin( ent->trigger_field, PASSVEC3(ent->trigger_field->s.v.origin));
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 1008
;1008:				setorigin( ent, PASSVEC3(ent->s.v.origin));
ADDRLP4 0
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
line 1011
;1009:				//SetVector( ent->trigger_field->s.v.velocity, 0, 0, -8 );
;1010:
;1011:				G_sprint( ent->real_owner, 2, "Your Static Sentry Gun rebuilded.\n" );
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $673
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1012
;1012:			}
LABELV $665
line 1013
;1013:		}
LABELV $653
line 1014
;1014:	}
LABELV $649
line 963
LABELV $651
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $652
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $648
line 1015
;1015:}
LABELV $647
endproc Eng_StaticSG_Activate 40 16
import FireBullets
import CheckSentry
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
LABELV $673
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 105
byte 1 99
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 32
byte 1 114
byte 1 101
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $667
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 116
byte 1 117
byte 1 114
byte 1 114
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $664
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 102
byte 1 101
byte 1 108
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 102
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $661
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 105
byte 1 99
byte 1 32
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $652
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
LABELV $645
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $638
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 108
byte 1 111
byte 1 119
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $635
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $626
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 83
byte 1 71
byte 1 32
byte 1 84
byte 1 89
byte 1 80
byte 1 69
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $605
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 108
byte 1 111
byte 1 119
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $589
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 101
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $451
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 108
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $446
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
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
LABELV $444
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 53
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $442
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 52
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $440
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $438
byte 1 112
byte 1 108
byte 1 97
byte 1 121
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
LABELV $435
byte 1 112
byte 1 108
byte 1 97
byte 1 121
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
LABELV $234
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 83
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 68
byte 1 105
byte 1 101
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 101
byte 1 114
byte 1 45
byte 1 62
byte 1 104
byte 1 97
byte 1 115
byte 1 95
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 33
byte 1 61
byte 1 48
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $227
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 114
byte 1 111
byte 1 121
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $224
byte 1 0
align 1
LABELV $223
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 116
byte 1 117
byte 1 114
byte 1 114
byte 1 103
byte 1 117
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $217
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
LABELV $211
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
byte 1 51
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $210
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
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $209
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
LABELV $184
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $152
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $93
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 103
byte 1 117
byte 1 110
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
