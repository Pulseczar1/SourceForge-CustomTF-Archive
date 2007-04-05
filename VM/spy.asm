export spy_diea1
code
proc spy_diea1 0 0
file "..\src\spy.c"
line 39
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
;21: *  $Id: spy.c,v 1.17 2005/11/29 14:22:43 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:/*
;26:========================================================
;27:Functions for the SPY class and associated weaponry                          
;28:========================================================
;29:*/
;30:
;31:void    TeamFortress_SpyCalcName( gedict_t * spy );
;32:void    TeamFortress_SpyUndercoverThink(  );
;33:void    GasGrenadeMakeGas(  );
;34:void    T_TranqDartTouch(  );
;35:void    spawn_touchblood( float damage );
;36:
;37:// Spy Feign Death Frames
;38:void spy_diea1(  )
;39:{
line 40
;40:	self->s.v.frame = 50;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1112014848
ASGNF4
line 41
;41:	self->s.v.think = ( func_t ) spy_diea2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diea2
CVPU4 4
CVUI4 4
ASGNI4
line 42
;42:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 44
;43:
;44:}
LABELV $11
endproc spy_diea1 0 0
export spy_diea2
proc spy_diea2 0 0
line 46
;45:void spy_diea2(  )
;46:{
line 47
;47:	self->s.v.frame = 51;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1112276992
ASGNF4
line 48
;48:	self->s.v.think = ( func_t ) spy_diea3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diea3
CVPU4 4
CVUI4 4
ASGNI4
line 49
;49:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 51
;50:
;51:}
LABELV $13
endproc spy_diea2 0 0
export spy_diea3
proc spy_diea3 0 0
line 53
;52:void spy_diea3(  )
;53:{
line 54
;54:	self->s.v.frame = 52;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1112539136
ASGNF4
line 55
;55:	self->s.v.think = ( func_t ) spy_diea4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diea4
CVPU4 4
CVUI4 4
ASGNI4
line 56
;56:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 58
;57:
;58:}
LABELV $15
endproc spy_diea3 0 0
export spy_diea4
proc spy_diea4 0 0
line 60
;59:void spy_diea4(  )
;60:{
line 61
;61:	self->s.v.frame = 53;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1112801280
ASGNF4
line 62
;62:	self->s.v.think = ( func_t ) spy_diea5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diea5
CVPU4 4
CVUI4 4
ASGNI4
line 63
;63:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 65
;64:
;65:}
LABELV $17
endproc spy_diea4 0 0
export spy_diea5
proc spy_diea5 0 0
line 67
;66:void spy_diea5(  )
;67:{
line 68
;68:	self->s.v.frame = 54;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1113063424
ASGNF4
line 69
;69:	self->s.v.think = ( func_t ) spy_diea6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diea6
CVPU4 4
CVUI4 4
ASGNI4
line 70
;70:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 72
;71:
;72:}
LABELV $19
endproc spy_diea5 0 0
export spy_diea6
proc spy_diea6 0 0
line 74
;73:void spy_diea6(  )
;74:{
line 75
;75:	self->s.v.frame = 55;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1113325568
ASGNF4
line 76
;76:	self->s.v.think = ( func_t ) spy_diea7;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diea7
CVPU4 4
CVUI4 4
ASGNI4
line 77
;77:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 79
;78:
;79:}
LABELV $21
endproc spy_diea6 0 0
export spy_diea7
proc spy_diea7 0 0
line 81
;80:void spy_diea7(  )
;81:{
line 82
;82:	self->s.v.frame = 56;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1113587712
ASGNF4
line 83
;83:	self->s.v.think = ( func_t ) spy_diea8;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diea8
CVPU4 4
CVUI4 4
ASGNI4
line 84
;84:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 86
;85:
;86:}
LABELV $23
endproc spy_diea7 0 0
export spy_diea8
proc spy_diea8 0 0
line 88
;87:void spy_diea8(  )
;88:{
line 89
;89:	self->s.v.frame = 57;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1113849856
ASGNF4
line 90
;90:	self->s.v.think = ( func_t ) spy_diea9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diea9
CVPU4 4
CVUI4 4
ASGNI4
line 91
;91:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 93
;92:
;93:}
LABELV $25
endproc spy_diea8 0 0
export spy_diea9
proc spy_diea9 0 0
line 95
;94:void spy_diea9(  )
;95:{
line 96
;96:	self->s.v.frame = 58;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1114112000
ASGNF4
line 97
;97:	self->s.v.think = ( func_t ) spy_diea10;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diea10
CVPU4 4
CVUI4 4
ASGNI4
line 98
;98:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 100
;99:
;100:}
LABELV $27
endproc spy_diea9 0 0
export spy_diea10
proc spy_diea10 0 0
line 102
;101:void spy_diea10(  )
;102:{
line 103
;103:	self->s.v.frame = 59;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1114374144
ASGNF4
line 104
;104:	self->s.v.think = ( func_t ) spy_diea11;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diea11
CVPU4 4
CVUI4 4
ASGNI4
line 105
;105:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 107
;106:
;107:}
LABELV $29
endproc spy_diea10 0 0
export spy_diea11
proc spy_diea11 0 0
line 109
;108:void spy_diea11(  )
;109:{
line 110
;110:	self->s.v.frame = 60;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1114636288
ASGNF4
line 111
;111:	self->s.v.think = ( func_t ) spy_diea11;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diea11
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
;114:}
LABELV $31
endproc spy_diea11 0 0
export spy_dieb1
proc spy_dieb1 0 0
line 116
;115:void spy_dieb1(  )
;116:{
line 117
;117:	self->s.v.frame = 61;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1114898432
ASGNF4
line 118
;118:	self->s.v.think = ( func_t ) spy_dieb2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_dieb2
CVPU4 4
CVUI4 4
ASGNI4
line 119
;119:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 121
;120:
;121:}
LABELV $33
endproc spy_dieb1 0 0
export spy_dieb2
proc spy_dieb2 0 0
line 123
;122:void spy_dieb2(  )
;123:{
line 124
;124:	self->s.v.frame = 62;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1115160576
ASGNF4
line 125
;125:	self->s.v.think = ( func_t ) spy_dieb3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_dieb3
CVPU4 4
CVUI4 4
ASGNI4
line 126
;126:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 128
;127:
;128:}
LABELV $35
endproc spy_dieb2 0 0
export spy_dieb3
proc spy_dieb3 0 0
line 130
;129:void spy_dieb3(  )
;130:{
line 131
;131:	self->s.v.frame = 63;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1115422720
ASGNF4
line 132
;132:	self->s.v.think = ( func_t ) spy_dieb4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_dieb4
CVPU4 4
CVUI4 4
ASGNI4
line 133
;133:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 135
;134:
;135:}
LABELV $37
endproc spy_dieb3 0 0
export spy_dieb4
proc spy_dieb4 0 0
line 137
;136:void spy_dieb4(  )
;137:{
line 138
;138:	self->s.v.frame = 64;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1115684864
ASGNF4
line 139
;139:	self->s.v.think = ( func_t ) spy_dieb5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_dieb5
CVPU4 4
CVUI4 4
ASGNI4
line 140
;140:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 142
;141:
;142:}
LABELV $39
endproc spy_dieb4 0 0
export spy_dieb5
proc spy_dieb5 0 0
line 144
;143:void spy_dieb5(  )
;144:{
line 145
;145:	self->s.v.frame = 65;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1115815936
ASGNF4
line 146
;146:	self->s.v.think = ( func_t ) spy_dieb6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_dieb6
CVPU4 4
CVUI4 4
ASGNI4
line 147
;147:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 149
;148:
;149:}
LABELV $41
endproc spy_dieb5 0 0
export spy_dieb6
proc spy_dieb6 0 0
line 151
;150:void spy_dieb6(  )
;151:{
line 152
;152:	self->s.v.frame = 66;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1115947008
ASGNF4
line 153
;153:	self->s.v.think = ( func_t ) spy_dieb7;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_dieb7
CVPU4 4
CVUI4 4
ASGNI4
line 154
;154:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 156
;155:
;156:}
LABELV $43
endproc spy_dieb6 0 0
export spy_dieb7
proc spy_dieb7 0 0
line 158
;157:void spy_dieb7(  )
;158:{
line 159
;159:	self->s.v.frame = 67;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116078080
ASGNF4
line 160
;160:	self->s.v.think = ( func_t ) spy_dieb8;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_dieb8
CVPU4 4
CVUI4 4
ASGNI4
line 161
;161:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 163
;162:
;163:}
LABELV $45
endproc spy_dieb7 0 0
export spy_dieb8
proc spy_dieb8 0 0
line 165
;164:void spy_dieb8(  )
;165:{
line 166
;166:	self->s.v.frame = 68;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116209152
ASGNF4
line 167
;167:	self->s.v.think = ( func_t ) spy_dieb9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_dieb9
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
;170:}
LABELV $47
endproc spy_dieb8 0 0
export spy_dieb9
proc spy_dieb9 0 0
line 172
;171:void spy_dieb9(  )
;172:{
line 173
;173:	self->s.v.frame = 69;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116340224
ASGNF4
line 174
;174:	self->s.v.think = ( func_t ) spy_dieb9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_dieb9
CVPU4 4
CVUI4 4
ASGNI4
line 175
;175:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 177
;176:
;177:}
LABELV $49
endproc spy_dieb9 0 0
export spy_diec1
proc spy_diec1 0 0
line 179
;178:void spy_diec1(  )
;179:{
line 180
;180:	self->s.v.frame = 70;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116471296
ASGNF4
line 181
;181:	self->s.v.think = ( func_t ) spy_diec2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diec2
CVPU4 4
CVUI4 4
ASGNI4
line 182
;182:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 184
;183:
;184:}
LABELV $51
endproc spy_diec1 0 0
export spy_diec2
proc spy_diec2 0 0
line 186
;185:void spy_diec2(  )
;186:{
line 187
;187:	self->s.v.frame = 71;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116602368
ASGNF4
line 188
;188:	self->s.v.think = ( func_t ) spy_diec3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diec3
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
;191:}
LABELV $53
endproc spy_diec2 0 0
export spy_diec3
proc spy_diec3 0 0
line 193
;192:void spy_diec3(  )
;193:{
line 194
;194:	self->s.v.frame = 72;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116733440
ASGNF4
line 195
;195:	self->s.v.think = ( func_t ) spy_diec4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diec4
CVPU4 4
CVUI4 4
ASGNI4
line 196
;196:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 198
;197:
;198:}
LABELV $55
endproc spy_diec3 0 0
export spy_diec4
proc spy_diec4 0 0
line 200
;199:void spy_diec4(  )
;200:{
line 201
;201:	self->s.v.frame = 73;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116864512
ASGNF4
line 202
;202:	self->s.v.think = ( func_t ) spy_diec5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diec5
CVPU4 4
CVUI4 4
ASGNI4
line 203
;203:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 205
;204:
;205:}
LABELV $57
endproc spy_diec4 0 0
export spy_diec5
proc spy_diec5 0 0
line 207
;206:void spy_diec5(  )
;207:{
line 208
;208:	self->s.v.frame = 74;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116995584
ASGNF4
line 209
;209:	self->s.v.think = ( func_t ) spy_diec6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diec6
CVPU4 4
CVUI4 4
ASGNI4
line 210
;210:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 212
;211:
;212:}
LABELV $59
endproc spy_diec5 0 0
export spy_diec6
proc spy_diec6 0 0
line 214
;213:void spy_diec6(  )
;214:{
line 215
;215:	self->s.v.frame = 75;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117126656
ASGNF4
line 216
;216:	self->s.v.think = ( func_t ) spy_diec7;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diec7
CVPU4 4
CVUI4 4
ASGNI4
line 217
;217:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 219
;218:
;219:}
LABELV $61
endproc spy_diec6 0 0
export spy_diec7
proc spy_diec7 0 0
line 221
;220:void spy_diec7(  )
;221:{
line 222
;222:	self->s.v.frame = 76;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117257728
ASGNF4
line 223
;223:	self->s.v.think = ( func_t ) spy_diec8;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diec8
CVPU4 4
CVUI4 4
ASGNI4
line 224
;224:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 226
;225:
;226:}
LABELV $63
endproc spy_diec7 0 0
export spy_diec8
proc spy_diec8 0 0
line 228
;227:void spy_diec8(  )
;228:{
line 229
;229:	self->s.v.frame = 77;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117388800
ASGNF4
line 230
;230:	self->s.v.think = ( func_t ) spy_diec9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diec9
CVPU4 4
CVUI4 4
ASGNI4
line 231
;231:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 233
;232:
;233:}
LABELV $65
endproc spy_diec8 0 0
export spy_diec9
proc spy_diec9 0 0
line 235
;234:void spy_diec9(  )
;235:{
line 236
;236:	self->s.v.frame = 78;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117519872
ASGNF4
line 237
;237:	self->s.v.think = ( func_t ) spy_diec10;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diec10
CVPU4 4
CVUI4 4
ASGNI4
line 238
;238:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 240
;239:
;240:}
LABELV $67
endproc spy_diec9 0 0
export spy_diec10
proc spy_diec10 0 0
line 242
;241:void spy_diec10(  )
;242:{
line 243
;243:	self->s.v.frame = 79;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117650944
ASGNF4
line 244
;244:	self->s.v.think = ( func_t ) spy_diec11;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diec11
CVPU4 4
CVUI4 4
ASGNI4
line 245
;245:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 247
;246:
;247:}
LABELV $69
endproc spy_diec10 0 0
export spy_diec11
proc spy_diec11 0 0
line 249
;248:void spy_diec11(  )
;249:{
line 250
;250:	self->s.v.frame = 80;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117782016
ASGNF4
line 251
;251:	self->s.v.think = ( func_t ) spy_diec12;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diec12
CVPU4 4
CVUI4 4
ASGNI4
line 252
;252:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 254
;253:
;254:}
LABELV $71
endproc spy_diec11 0 0
export spy_diec12
proc spy_diec12 0 0
line 256
;255:void spy_diec12(  )
;256:{
line 257
;257:	self->s.v.frame = 81;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117913088
ASGNF4
line 258
;258:	self->s.v.think = ( func_t ) spy_diec13;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diec13
CVPU4 4
CVUI4 4
ASGNI4
line 259
;259:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 261
;260:
;261:}
LABELV $73
endproc spy_diec12 0 0
export spy_diec13
proc spy_diec13 0 0
line 263
;262:void spy_diec13(  )
;263:{
line 264
;264:	self->s.v.frame = 82;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118044160
ASGNF4
line 265
;265:	self->s.v.think = ( func_t ) spy_diec14;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diec14
CVPU4 4
CVUI4 4
ASGNI4
line 266
;266:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 268
;267:
;268:}
LABELV $75
endproc spy_diec13 0 0
export spy_diec14
proc spy_diec14 0 0
line 270
;269:void spy_diec14(  )
;270:{
line 271
;271:	self->s.v.frame = 83;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118175232
ASGNF4
line 272
;272:	self->s.v.think = ( func_t ) spy_diec15;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diec15
CVPU4 4
CVUI4 4
ASGNI4
line 273
;273:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 275
;274:
;275:}
LABELV $77
endproc spy_diec14 0 0
export spy_diec15
proc spy_diec15 0 0
line 277
;276:void spy_diec15(  )
;277:{
line 278
;278:	self->s.v.frame = 84;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118306304
ASGNF4
line 279
;279:	self->s.v.think = ( func_t ) spy_diec15;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diec15
CVPU4 4
CVUI4 4
ASGNI4
line 280
;280:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 282
;281:
;282:}
LABELV $79
endproc spy_diec15 0 0
export spy_died1
proc spy_died1 0 0
line 284
;283:void spy_died1(  )
;284:{
line 285
;285:	self->s.v.frame = 85;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118437376
ASGNF4
line 286
;286:	self->s.v.think = ( func_t ) spy_died2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_died2
CVPU4 4
CVUI4 4
ASGNI4
line 287
;287:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 289
;288:
;289:}
LABELV $81
endproc spy_died1 0 0
export spy_died2
proc spy_died2 0 0
line 291
;290:void spy_died2(  )
;291:{
line 292
;292:	self->s.v.frame = 86;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118568448
ASGNF4
line 293
;293:	self->s.v.think = ( func_t ) spy_died3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_died3
CVPU4 4
CVUI4 4
ASGNI4
line 294
;294:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 296
;295:
;296:}
LABELV $83
endproc spy_died2 0 0
export spy_died3
proc spy_died3 0 0
line 298
;297:void spy_died3(  )
;298:{
line 299
;299:	self->s.v.frame = 87;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118699520
ASGNF4
line 300
;300:	self->s.v.think = ( func_t ) spy_died4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_died4
CVPU4 4
CVUI4 4
ASGNI4
line 301
;301:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 303
;302:
;303:}
LABELV $85
endproc spy_died3 0 0
export spy_died4
proc spy_died4 0 0
line 305
;304:void spy_died4(  )
;305:{
line 306
;306:	self->s.v.frame = 88;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118830592
ASGNF4
line 307
;307:	self->s.v.think = ( func_t ) spy_died5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_died5
CVPU4 4
CVUI4 4
ASGNI4
line 308
;308:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 310
;309:
;310:}
LABELV $87
endproc spy_died4 0 0
export spy_died5
proc spy_died5 0 0
line 312
;311:void spy_died5(  )
;312:{
line 313
;313:	self->s.v.frame = 89;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118961664
ASGNF4
line 314
;314:	self->s.v.think = ( func_t ) spy_died6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_died6
CVPU4 4
CVUI4 4
ASGNI4
line 315
;315:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 317
;316:
;317:}
LABELV $89
endproc spy_died5 0 0
export spy_died6
proc spy_died6 0 0
line 319
;318:void spy_died6(  )
;319:{
line 320
;320:	self->s.v.frame = 90;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119092736
ASGNF4
line 321
;321:	self->s.v.think = ( func_t ) spy_died7;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_died7
CVPU4 4
CVUI4 4
ASGNI4
line 322
;322:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 324
;323:
;324:}
LABELV $91
endproc spy_died6 0 0
export spy_died7
proc spy_died7 0 0
line 326
;325:void spy_died7(  )
;326:{
line 327
;327:	self->s.v.frame = 91;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119223808
ASGNF4
line 328
;328:	self->s.v.think = ( func_t ) spy_died8;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_died8
CVPU4 4
CVUI4 4
ASGNI4
line 329
;329:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 331
;330:
;331:}
LABELV $93
endproc spy_died7 0 0
export spy_died8
proc spy_died8 0 0
line 333
;332:void spy_died8(  )
;333:{
line 334
;334:	self->s.v.frame = 92;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119354880
ASGNF4
line 335
;335:	self->s.v.think = ( func_t ) spy_died9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_died9
CVPU4 4
CVUI4 4
ASGNI4
line 336
;336:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 338
;337:
;338:}
LABELV $95
endproc spy_died8 0 0
export spy_died9
proc spy_died9 0 0
line 340
;339:void spy_died9(  )
;340:{
line 341
;341:	self->s.v.frame = 93;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119485952
ASGNF4
line 342
;342:	self->s.v.think = ( func_t ) spy_died9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_died9
CVPU4 4
CVUI4 4
ASGNI4
line 343
;343:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 345
;344:
;345:}
LABELV $97
endproc spy_died9 0 0
export spy_diee1
proc spy_diee1 0 0
line 347
;346:void spy_diee1(  )
;347:{
line 348
;348:	self->s.v.frame = 94;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119617024
ASGNF4
line 349
;349:	self->s.v.think = ( func_t ) spy_diee2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diee2
CVPU4 4
CVUI4 4
ASGNI4
line 350
;350:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 352
;351:
;352:}
LABELV $99
endproc spy_diee1 0 0
export spy_diee2
proc spy_diee2 0 0
line 354
;353:void spy_diee2(  )
;354:{
line 355
;355:	self->s.v.frame = 95;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119748096
ASGNF4
line 356
;356:	self->s.v.think = ( func_t ) spy_diee3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diee3
CVPU4 4
CVUI4 4
ASGNI4
line 357
;357:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 359
;358:
;359:}
LABELV $101
endproc spy_diee2 0 0
export spy_diee3
proc spy_diee3 0 0
line 361
;360:void spy_diee3(  )
;361:{
line 362
;362:	self->s.v.frame = 96;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119879168
ASGNF4
line 363
;363:	self->s.v.think = ( func_t ) spy_diee4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diee4
CVPU4 4
CVUI4 4
ASGNI4
line 364
;364:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 366
;365:
;366:}
LABELV $103
endproc spy_diee3 0 0
export spy_diee4
proc spy_diee4 0 0
line 368
;367:void spy_diee4(  )
;368:{
line 369
;369:	self->s.v.frame = 97;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120010240
ASGNF4
line 370
;370:	self->s.v.think = ( func_t ) spy_diee5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diee5
CVPU4 4
CVUI4 4
ASGNI4
line 371
;371:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 373
;372:
;373:}
LABELV $105
endproc spy_diee4 0 0
export spy_diee5
proc spy_diee5 0 0
line 375
;374:void spy_diee5(  )
;375:{
line 376
;376:	self->s.v.frame = 98;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120141312
ASGNF4
line 377
;377:	self->s.v.think = ( func_t ) spy_diee6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diee6
CVPU4 4
CVUI4 4
ASGNI4
line 378
;378:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 380
;379:
;380:}
LABELV $107
endproc spy_diee5 0 0
export spy_diee6
proc spy_diee6 0 0
line 382
;381:void spy_diee6(  )
;382:{
line 383
;383:	self->s.v.frame = 99;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120272384
ASGNF4
line 384
;384:	self->s.v.think = ( func_t ) spy_diee7;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diee7
CVPU4 4
CVUI4 4
ASGNI4
line 385
;385:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 387
;386:
;387:}
LABELV $109
endproc spy_diee6 0 0
export spy_diee7
proc spy_diee7 0 0
line 389
;388:void spy_diee7(  )
;389:{
line 390
;390:	self->s.v.frame = 100;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120403456
ASGNF4
line 391
;391:	self->s.v.think = ( func_t ) spy_diee8;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diee8
CVPU4 4
CVUI4 4
ASGNI4
line 392
;392:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 394
;393:
;394:}
LABELV $111
endproc spy_diee7 0 0
export spy_diee8
proc spy_diee8 0 0
line 396
;395:void spy_diee8(  )
;396:{
line 397
;397:	self->s.v.frame = 101;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120534528
ASGNF4
line 398
;398:	self->s.v.think = ( func_t ) spy_diee9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diee9
CVPU4 4
CVUI4 4
ASGNI4
line 399
;399:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 401
;400:
;401:}
LABELV $113
endproc spy_diee8 0 0
export spy_diee9
proc spy_diee9 0 0
line 403
;402:void spy_diee9(  )
;403:{
line 404
;404:	self->s.v.frame = 102;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120665600
ASGNF4
line 405
;405:	self->s.v.think = ( func_t ) spy_diee9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_diee9
CVPU4 4
CVUI4 4
ASGNI4
line 406
;406:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 408
;407:
;408:}
LABELV $115
endproc spy_diee9 0 0
export spy_die_ax1
proc spy_die_ax1 0 0
line 410
;409:void spy_die_ax1(  )
;410:{
line 411
;411:	self->s.v.frame = 41;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1109655552
ASGNF4
line 412
;412:	self->s.v.think = ( func_t ) spy_die_ax2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_die_ax2
CVPU4 4
CVUI4 4
ASGNI4
line 413
;413:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 415
;414:
;415:}
LABELV $117
endproc spy_die_ax1 0 0
export spy_die_ax2
proc spy_die_ax2 0 0
line 417
;416:void spy_die_ax2(  )
;417:{
line 418
;418:	self->s.v.frame = 42;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1109917696
ASGNF4
line 419
;419:	self->s.v.think = ( func_t ) spy_die_ax3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_die_ax3
CVPU4 4
CVUI4 4
ASGNI4
line 420
;420:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 422
;421:
;422:}
LABELV $119
endproc spy_die_ax2 0 0
export spy_die_ax3
proc spy_die_ax3 0 0
line 424
;423:void spy_die_ax3(  )
;424:{
line 425
;425:	self->s.v.frame = 43;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1110179840
ASGNF4
line 426
;426:	self->s.v.think = ( func_t ) spy_die_ax4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_die_ax4
CVPU4 4
CVUI4 4
ASGNI4
line 427
;427:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 429
;428:
;429:}
LABELV $121
endproc spy_die_ax3 0 0
export spy_die_ax4
proc spy_die_ax4 0 0
line 431
;430:void spy_die_ax4(  )
;431:{
line 432
;432:	self->s.v.frame = 44;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1110441984
ASGNF4
line 433
;433:	self->s.v.think = ( func_t ) spy_die_ax5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_die_ax5
CVPU4 4
CVUI4 4
ASGNI4
line 434
;434:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 436
;435:
;436:}
LABELV $123
endproc spy_die_ax4 0 0
export spy_die_ax5
proc spy_die_ax5 0 0
line 438
;437:void spy_die_ax5(  )
;438:{
line 439
;439:	self->s.v.frame = 45;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1110704128
ASGNF4
line 440
;440:	self->s.v.think = ( func_t ) spy_die_ax6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_die_ax6
CVPU4 4
CVUI4 4
ASGNI4
line 441
;441:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 443
;442:
;443:}
LABELV $125
endproc spy_die_ax5 0 0
export spy_die_ax6
proc spy_die_ax6 0 0
line 445
;444:void spy_die_ax6(  )
;445:{
line 446
;446:	self->s.v.frame = 46;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1110966272
ASGNF4
line 447
;447:	self->s.v.think = ( func_t ) spy_die_ax7;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_die_ax7
CVPU4 4
CVUI4 4
ASGNI4
line 448
;448:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 450
;449:
;450:}
LABELV $127
endproc spy_die_ax6 0 0
export spy_die_ax7
proc spy_die_ax7 0 0
line 452
;451:void spy_die_ax7(  )
;452:{
line 453
;453:	self->s.v.frame = 47;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1111228416
ASGNF4
line 454
;454:	self->s.v.think = ( func_t ) spy_die_ax8;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_die_ax8
CVPU4 4
CVUI4 4
ASGNI4
line 455
;455:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 457
;456:
;457:}
LABELV $129
endproc spy_die_ax7 0 0
export spy_die_ax8
proc spy_die_ax8 0 0
line 459
;458:void spy_die_ax8(  )
;459:{
line 460
;460:	self->s.v.frame = 48;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1111490560
ASGNF4
line 461
;461:	self->s.v.think = ( func_t ) spy_die_ax9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_die_ax9
CVPU4 4
CVUI4 4
ASGNI4
line 462
;462:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 464
;463:
;464:}
LABELV $131
endproc spy_die_ax8 0 0
export spy_die_ax9
proc spy_die_ax9 0 0
line 466
;465:void spy_die_ax9(  )
;466:{
line 467
;467:	self->s.v.frame = 49;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1111752704
ASGNF4
line 468
;468:	self->s.v.think = ( func_t ) spy_die_ax9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_die_ax9
CVPU4 4
CVUI4 4
ASGNI4
line 469
;469:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 471
;470:
;471:}
LABELV $133
endproc spy_die_ax9 0 0
export spy_upb1
proc spy_upb1 0 0
line 473
;472:void spy_upb1(  )
;473:{
line 474
;474:	self->s.v.frame = 69;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116340224
ASGNF4
line 475
;475:	self->s.v.think = ( func_t ) spy_upb2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upb2
CVPU4 4
CVUI4 4
ASGNI4
line 476
;476:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 478
;477:
;478:}
LABELV $135
endproc spy_upb1 0 0
export spy_upb2
proc spy_upb2 0 0
line 480
;479:void spy_upb2(  )
;480:{
line 481
;481:	self->s.v.frame = 68;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116209152
ASGNF4
line 482
;482:	self->s.v.think = ( func_t ) spy_upb3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upb3
CVPU4 4
CVUI4 4
ASGNI4
line 483
;483:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 485
;484:
;485:}
LABELV $137
endproc spy_upb2 0 0
export spy_upb3
proc spy_upb3 0 0
line 487
;486:void spy_upb3(  )
;487:{
line 488
;488:	self->s.v.frame = 67;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116078080
ASGNF4
line 489
;489:	self->s.v.think = ( func_t ) spy_upb4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upb4
CVPU4 4
CVUI4 4
ASGNI4
line 490
;490:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 492
;491:
;492:}
LABELV $139
endproc spy_upb3 0 0
export spy_upb4
proc spy_upb4 0 0
line 494
;493:void spy_upb4(  )
;494:{
line 495
;495:	self->s.v.frame = 66;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1115947008
ASGNF4
line 496
;496:	self->s.v.think = ( func_t ) spy_upb5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upb5
CVPU4 4
CVUI4 4
ASGNI4
line 497
;497:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 499
;498:
;499:}
LABELV $141
endproc spy_upb4 0 0
export spy_upb5
proc spy_upb5 0 0
line 501
;500:void spy_upb5(  )
;501:{
line 502
;502:	self->s.v.frame = 65;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1115815936
ASGNF4
line 503
;503:	self->s.v.think = ( func_t ) spy_upb6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upb6
CVPU4 4
CVUI4 4
ASGNI4
line 504
;504:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 506
;505:
;506:}
LABELV $143
endproc spy_upb5 0 0
export spy_upb6
proc spy_upb6 0 0
line 508
;507:void spy_upb6(  )
;508:{
line 509
;509:	self->s.v.frame = 64;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1115684864
ASGNF4
line 510
;510:	self->s.v.think = ( func_t ) spy_upb7;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upb7
CVPU4 4
CVUI4 4
ASGNI4
line 511
;511:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 513
;512:
;513:}
LABELV $145
endproc spy_upb6 0 0
export spy_upb7
proc spy_upb7 0 0
line 515
;514:void spy_upb7(  )
;515:{
line 516
;516:	self->s.v.frame = 63;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1115422720
ASGNF4
line 517
;517:	self->s.v.think = ( func_t ) spy_upb8;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upb8
CVPU4 4
CVUI4 4
ASGNI4
line 518
;518:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 520
;519:
;520:}
LABELV $147
endproc spy_upb7 0 0
export spy_upb8
proc spy_upb8 0 0
line 522
;521:void spy_upb8(  )
;522:{
line 523
;523:	self->s.v.frame = 62;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1115160576
ASGNF4
line 524
;524:	self->s.v.think = ( func_t ) spy_upb9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upb9
CVPU4 4
CVUI4 4
ASGNI4
line 525
;525:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 527
;526:
;527:}
LABELV $149
endproc spy_upb8 0 0
export spy_upb9
proc spy_upb9 0 0
line 529
;528:void spy_upb9(  )
;529:{
line 530
;530:	self->s.v.frame = 61;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1114898432
ASGNF4
line 531
;531:	self->s.v.think = ( func_t ) spy_upb9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upb9
CVPU4 4
CVUI4 4
ASGNI4
line 532
;532:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 534
;533:
;534:	player_stand1(  );
ADDRGP4 player_stand1
CALLV
pop
line 535
;535:}
LABELV $151
endproc spy_upb9 0 0
export spy_upc1
proc spy_upc1 0 0
line 537
;536:void spy_upc1(  )
;537:{
line 538
;538:	self->s.v.frame = 84;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118306304
ASGNF4
line 539
;539:	self->s.v.think = ( func_t ) spy_upc2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upc2
CVPU4 4
CVUI4 4
ASGNI4
line 540
;540:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 542
;541:
;542:}
LABELV $153
endproc spy_upc1 0 0
export spy_upc2
proc spy_upc2 0 0
line 544
;543:void spy_upc2(  )
;544:{
line 545
;545:	self->s.v.frame = 83;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118175232
ASGNF4
line 546
;546:	self->s.v.think = ( func_t ) spy_upc3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upc3
CVPU4 4
CVUI4 4
ASGNI4
line 547
;547:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 549
;548:
;549:}
LABELV $155
endproc spy_upc2 0 0
export spy_upc3
proc spy_upc3 0 0
line 551
;550:void spy_upc3(  )
;551:{
line 552
;552:	self->s.v.frame = 82;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118044160
ASGNF4
line 553
;553:	self->s.v.think = ( func_t ) spy_upc4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upc4
CVPU4 4
CVUI4 4
ASGNI4
line 554
;554:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 556
;555:
;556:}
LABELV $157
endproc spy_upc3 0 0
export spy_upc4
proc spy_upc4 0 0
line 558
;557:void spy_upc4(  )
;558:{
line 559
;559:	self->s.v.frame = 81;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117913088
ASGNF4
line 560
;560:	self->s.v.think = ( func_t ) spy_upc5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upc5
CVPU4 4
CVUI4 4
ASGNI4
line 561
;561:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 563
;562:
;563:}
LABELV $159
endproc spy_upc4 0 0
export spy_upc5
proc spy_upc5 0 0
line 565
;564:void spy_upc5(  )
;565:{
line 566
;566:	self->s.v.frame = 80;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117782016
ASGNF4
line 567
;567:	self->s.v.think = ( func_t ) spy_upc6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upc6
CVPU4 4
CVUI4 4
ASGNI4
line 568
;568:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 570
;569:
;570:}
LABELV $161
endproc spy_upc5 0 0
export spy_upc6
proc spy_upc6 0 0
line 572
;571:void spy_upc6(  )
;572:{
line 573
;573:	self->s.v.frame = 79;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117650944
ASGNF4
line 574
;574:	self->s.v.think = ( func_t ) spy_upc7;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upc7
CVPU4 4
CVUI4 4
ASGNI4
line 575
;575:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 577
;576:
;577:}
LABELV $163
endproc spy_upc6 0 0
export spy_upc7
proc spy_upc7 0 0
line 579
;578:void spy_upc7(  )
;579:{
line 580
;580:	self->s.v.frame = 78;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117519872
ASGNF4
line 581
;581:	self->s.v.think = ( func_t ) spy_upc8;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upc8
CVPU4 4
CVUI4 4
ASGNI4
line 582
;582:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 584
;583:
;584:}
LABELV $165
endproc spy_upc7 0 0
export spy_upc8
proc spy_upc8 0 0
line 586
;585:void spy_upc8(  )
;586:{
line 587
;587:	self->s.v.frame = 77;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117388800
ASGNF4
line 588
;588:	self->s.v.think = ( func_t ) spy_upc9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upc9
CVPU4 4
CVUI4 4
ASGNI4
line 589
;589:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 591
;590:
;591:}
LABELV $167
endproc spy_upc8 0 0
export spy_upc9
proc spy_upc9 0 0
line 593
;592:void spy_upc9(  )
;593:{
line 594
;594:	self->s.v.frame = 76;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117257728
ASGNF4
line 595
;595:	self->s.v.think = ( func_t ) spy_upc10;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upc10
CVPU4 4
CVUI4 4
ASGNI4
line 596
;596:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 598
;597:
;598:}
LABELV $169
endproc spy_upc9 0 0
export spy_upc10
proc spy_upc10 0 0
line 600
;599:void spy_upc10(  )
;600:{
line 601
;601:	self->s.v.frame = 75;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117126656
ASGNF4
line 602
;602:	self->s.v.think = ( func_t ) spy_upc11;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upc11
CVPU4 4
CVUI4 4
ASGNI4
line 603
;603:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 605
;604:
;605:}
LABELV $171
endproc spy_upc10 0 0
export spy_upc11
proc spy_upc11 0 0
line 607
;606:void spy_upc11(  )
;607:{
line 608
;608:	self->s.v.frame = 74;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116995584
ASGNF4
line 609
;609:	self->s.v.think = ( func_t ) spy_upc12;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upc12
CVPU4 4
CVUI4 4
ASGNI4
line 610
;610:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 612
;611:
;612:}
LABELV $173
endproc spy_upc11 0 0
export spy_upc12
proc spy_upc12 0 0
line 614
;613:void spy_upc12(  )
;614:{
line 615
;615:	self->s.v.frame = 73;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116864512
ASGNF4
line 616
;616:	self->s.v.think = ( func_t ) spy_upc13;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upc13
CVPU4 4
CVUI4 4
ASGNI4
line 617
;617:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 619
;618:
;619:}
LABELV $175
endproc spy_upc12 0 0
export spy_upc13
proc spy_upc13 0 0
line 621
;620:void spy_upc13(  )
;621:{
line 622
;622:	self->s.v.frame = 72;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116733440
ASGNF4
line 623
;623:	self->s.v.think = ( func_t ) spy_upc14;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upc14
CVPU4 4
CVUI4 4
ASGNI4
line 624
;624:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 626
;625:
;626:}
LABELV $177
endproc spy_upc13 0 0
export spy_upc14
proc spy_upc14 0 0
line 628
;627:void spy_upc14(  )
;628:{
line 629
;629:	self->s.v.frame = 71;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116602368
ASGNF4
line 630
;630:	self->s.v.think = ( func_t ) spy_upc15;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upc15
CVPU4 4
CVUI4 4
ASGNI4
line 631
;631:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 633
;632:
;633:}
LABELV $179
endproc spy_upc14 0 0
export spy_upc15
proc spy_upc15 0 0
line 635
;634:void spy_upc15(  )
;635:{
line 636
;636:	self->s.v.frame = 70;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116471296
ASGNF4
line 637
;637:	self->s.v.think = ( func_t ) spy_upc15;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upc15
CVPU4 4
CVUI4 4
ASGNI4
line 638
;638:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 640
;639:
;640:	player_stand1(  );
ADDRGP4 player_stand1
CALLV
pop
line 641
;641:}
LABELV $181
endproc spy_upc15 0 0
export spy_upd1
proc spy_upd1 0 0
line 643
;642:void spy_upd1(  )
;643:{
line 644
;644:	self->s.v.frame = 93;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119485952
ASGNF4
line 645
;645:	self->s.v.think = ( func_t ) spy_upd2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upd2
CVPU4 4
CVUI4 4
ASGNI4
line 646
;646:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 648
;647:
;648:}
LABELV $183
endproc spy_upd1 0 0
export spy_upd2
proc spy_upd2 0 0
line 650
;649:void spy_upd2(  )
;650:{
line 651
;651:	self->s.v.frame = 92;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119354880
ASGNF4
line 652
;652:	self->s.v.think = ( func_t ) spy_upd3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upd3
CVPU4 4
CVUI4 4
ASGNI4
line 653
;653:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 655
;654:
;655:}
LABELV $185
endproc spy_upd2 0 0
export spy_upd3
proc spy_upd3 0 0
line 657
;656:void spy_upd3(  )
;657:{
line 658
;658:	self->s.v.frame = 91;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119223808
ASGNF4
line 659
;659:	self->s.v.think = ( func_t ) spy_upd4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upd4
CVPU4 4
CVUI4 4
ASGNI4
line 660
;660:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 662
;661:
;662:}
LABELV $187
endproc spy_upd3 0 0
export spy_upd4
proc spy_upd4 0 0
line 664
;663:void spy_upd4(  )
;664:{
line 665
;665:	self->s.v.frame = 90;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119092736
ASGNF4
line 666
;666:	self->s.v.think = ( func_t ) spy_upd5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upd5
CVPU4 4
CVUI4 4
ASGNI4
line 667
;667:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 669
;668:
;669:}
LABELV $189
endproc spy_upd4 0 0
export spy_upd5
proc spy_upd5 0 0
line 671
;670:void spy_upd5(  )
;671:{
line 672
;672:	self->s.v.frame = 89;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118961664
ASGNF4
line 673
;673:	self->s.v.think = ( func_t ) spy_upd6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upd6
CVPU4 4
CVUI4 4
ASGNI4
line 674
;674:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 676
;675:
;676:}
LABELV $191
endproc spy_upd5 0 0
export spy_upd6
proc spy_upd6 0 0
line 678
;677:void spy_upd6(  )
;678:{
line 679
;679:	self->s.v.frame = 88;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118830592
ASGNF4
line 680
;680:	self->s.v.think = ( func_t ) spy_upd7;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upd7
CVPU4 4
CVUI4 4
ASGNI4
line 681
;681:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 683
;682:
;683:}
LABELV $193
endproc spy_upd6 0 0
export spy_upd7
proc spy_upd7 0 0
line 685
;684:void spy_upd7(  )
;685:{
line 686
;686:	self->s.v.frame = 87;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118699520
ASGNF4
line 687
;687:	self->s.v.think = ( func_t ) spy_upd8;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upd8
CVPU4 4
CVUI4 4
ASGNI4
line 688
;688:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 690
;689:
;690:}
LABELV $195
endproc spy_upd7 0 0
export spy_upd8
proc spy_upd8 0 0
line 692
;691:void spy_upd8(  )
;692:{
line 693
;693:	self->s.v.frame = 86;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118568448
ASGNF4
line 694
;694:	self->s.v.think = ( func_t ) spy_upd9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upd9
CVPU4 4
CVUI4 4
ASGNI4
line 695
;695:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 697
;696:
;697:}
LABELV $197
endproc spy_upd8 0 0
export spy_upd9
proc spy_upd9 0 0
line 699
;698:void spy_upd9(  )
;699:{
line 700
;700:	self->s.v.frame = 85;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118437376
ASGNF4
line 701
;701:	self->s.v.think = ( func_t ) spy_upd9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upd9
CVPU4 4
CVUI4 4
ASGNI4
line 702
;702:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 704
;703:
;704:	player_stand1(  );
ADDRGP4 player_stand1
CALLV
pop
line 705
;705:}
LABELV $199
endproc spy_upd9 0 0
export spy_upe1
proc spy_upe1 0 0
line 707
;706:void spy_upe1(  )
;707:{
line 708
;708:	self->s.v.frame = 94;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119617024
ASGNF4
line 709
;709:	self->s.v.think = ( func_t ) spy_upe9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upe9
CVPU4 4
CVUI4 4
ASGNI4
line 710
;710:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 712
;711:
;712:}
LABELV $201
endproc spy_upe1 0 0
export spy_upe2
proc spy_upe2 0 0
line 717
;713:
;714:
;715:void    spy_upe9(  );
;716:void spy_upe2(  )
;717:{
line 718
;718:	self->s.v.frame = 95;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119748096
ASGNF4
line 719
;719:	self->s.v.think = ( func_t ) spy_upe8;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upe8
CVPU4 4
CVUI4 4
ASGNI4
line 720
;720:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 722
;721:
;722:}
LABELV $203
endproc spy_upe2 0 0
export spy_upe3
proc spy_upe3 0 0
line 727
;723:
;724:
;725:void    spy_upe8(  );
;726:void spy_upe3(  )
;727:{
line 728
;728:	self->s.v.frame = 96;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119879168
ASGNF4
line 729
;729:	self->s.v.think = ( func_t ) spy_upe7;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upe7
CVPU4 4
CVUI4 4
ASGNI4
line 730
;730:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 732
;731:
;732:}
LABELV $205
endproc spy_upe3 0 0
export spy_upe4
proc spy_upe4 0 0
line 737
;733:
;734:
;735:void    spy_upe7(  );
;736:void spy_upe4(  )
;737:{
line 738
;738:	self->s.v.frame = 97;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120010240
ASGNF4
line 739
;739:	self->s.v.think = ( func_t ) spy_upe6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upe6
CVPU4 4
CVUI4 4
ASGNI4
line 740
;740:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 742
;741:
;742:}
LABELV $207
endproc spy_upe4 0 0
export spy_upe5
proc spy_upe5 0 0
line 747
;743:
;744:
;745:void    spy_upe6(  );
;746:void spy_upe5(  )
;747:{
line 748
;748:	self->s.v.frame = 98;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120141312
ASGNF4
line 749
;749:	self->s.v.think = ( func_t ) spy_upe5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upe5
CVPU4 4
CVUI4 4
ASGNI4
line 750
;750:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 752
;751:
;752:}
LABELV $209
endproc spy_upe5 0 0
export spy_upe6
proc spy_upe6 0 0
line 754
;753:void spy_upe6(  )
;754:{
line 755
;755:	self->s.v.frame = 99;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120272384
ASGNF4
line 756
;756:	self->s.v.think = ( func_t ) spy_upe4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upe4
CVPU4 4
CVUI4 4
ASGNI4
line 757
;757:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 759
;758:
;759:}
LABELV $211
endproc spy_upe6 0 0
export spy_upe7
proc spy_upe7 0 0
line 761
;760:void spy_upe7(  )
;761:{
line 762
;762:	self->s.v.frame = 100;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120403456
ASGNF4
line 763
;763:	self->s.v.think = ( func_t ) spy_upe3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upe3
CVPU4 4
CVUI4 4
ASGNI4
line 764
;764:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 766
;765:
;766:}
LABELV $213
endproc spy_upe7 0 0
export spy_upe8
proc spy_upe8 0 0
line 768
;767:void spy_upe8(  )
;768:{
line 769
;769:	self->s.v.frame = 101;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120534528
ASGNF4
line 770
;770:	self->s.v.think = ( func_t ) spy_upe2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upe2
CVPU4 4
CVUI4 4
ASGNI4
line 771
;771:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 773
;772:
;773:}
LABELV $215
endproc spy_upe8 0 0
export spy_upe9
proc spy_upe9 0 0
line 775
;774:void spy_upe9(  )
;775:{
line 776
;776:	self->s.v.frame = 102;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120665600
ASGNF4
line 777
;777:	self->s.v.think = ( func_t ) spy_upe1;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upe1
CVPU4 4
CVUI4 4
ASGNI4
line 778
;778:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 780
;779:
;780:	player_stand1(  );
ADDRGP4 player_stand1
CALLV
pop
line 781
;781:}
LABELV $217
endproc spy_upe9 0 0
export spy_upaxe1
proc spy_upaxe1 0 0
line 783
;782:void spy_upaxe1(  )
;783:{
line 784
;784:	self->s.v.frame = 49;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1111752704
ASGNF4
line 785
;785:	self->s.v.think = ( func_t ) spy_upaxe2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upaxe2
CVPU4 4
CVUI4 4
ASGNI4
line 786
;786:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 788
;787:
;788:}
LABELV $219
endproc spy_upaxe1 0 0
export spy_upaxe2
proc spy_upaxe2 0 0
line 790
;789:void spy_upaxe2(  )
;790:{
line 791
;791:	self->s.v.frame = 48;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1111490560
ASGNF4
line 792
;792:	self->s.v.think = ( func_t ) spy_upaxe3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upaxe3
CVPU4 4
CVUI4 4
ASGNI4
line 793
;793:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 795
;794:
;795:}
LABELV $221
endproc spy_upaxe2 0 0
export spy_upaxe3
proc spy_upaxe3 0 0
line 797
;796:void spy_upaxe3(  )
;797:{
line 798
;798:	self->s.v.frame = 47;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1111228416
ASGNF4
line 799
;799:	self->s.v.think = ( func_t ) spy_upaxe4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upaxe4
CVPU4 4
CVUI4 4
ASGNI4
line 800
;800:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 802
;801:
;802:}
LABELV $223
endproc spy_upaxe3 0 0
export spy_upaxe4
proc spy_upaxe4 0 0
line 804
;803:void spy_upaxe4(  )
;804:{
line 805
;805:	self->s.v.frame = 46;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1110966272
ASGNF4
line 806
;806:	self->s.v.think = ( func_t ) spy_upaxe5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upaxe5
CVPU4 4
CVUI4 4
ASGNI4
line 807
;807:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 809
;808:
;809:}
LABELV $225
endproc spy_upaxe4 0 0
export spy_upaxe5
proc spy_upaxe5 0 0
line 811
;810:void spy_upaxe5(  )
;811:{
line 812
;812:	self->s.v.frame = 45;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1110704128
ASGNF4
line 813
;813:	self->s.v.think = ( func_t ) spy_upaxe6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upaxe6
CVPU4 4
CVUI4 4
ASGNI4
line 814
;814:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 816
;815:
;816:}
LABELV $227
endproc spy_upaxe5 0 0
export spy_upaxe6
proc spy_upaxe6 0 0
line 818
;817:void spy_upaxe6(  )
;818:{
line 819
;819:	self->s.v.frame = 44;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1110441984
ASGNF4
line 820
;820:	self->s.v.think = ( func_t ) spy_upaxe7;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upaxe7
CVPU4 4
CVUI4 4
ASGNI4
line 821
;821:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 823
;822:
;823:}
LABELV $229
endproc spy_upaxe6 0 0
export spy_upaxe7
proc spy_upaxe7 0 0
line 825
;824:void spy_upaxe7(  )
;825:{
line 826
;826:	self->s.v.frame = 43;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1110179840
ASGNF4
line 827
;827:	self->s.v.think = ( func_t ) spy_upaxe8;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upaxe8
CVPU4 4
CVUI4 4
ASGNI4
line 828
;828:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 830
;829:
;830:}
LABELV $231
endproc spy_upaxe7 0 0
export spy_upaxe8
proc spy_upaxe8 0 0
line 832
;831:void spy_upaxe8(  )
;832:{
line 833
;833:	self->s.v.frame = 42;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1109917696
ASGNF4
line 834
;834:	self->s.v.think = ( func_t ) spy_upaxe9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upaxe9
CVPU4 4
CVUI4 4
ASGNI4
line 835
;835:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 837
;836:
;837:}
LABELV $233
endproc spy_upaxe8 0 0
export spy_upaxe9
proc spy_upaxe9 0 0
line 839
;838:void spy_upaxe9(  )
;839:{
line 840
;840:	self->s.v.frame = 41;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1109655552
ASGNF4
line 841
;841:	self->s.v.think = ( func_t ) spy_upaxe9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 spy_upaxe9
CVPU4 4
CVUI4 4
ASGNI4
line 842
;842:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 844
;843:
;844:	player_stand1(  );
ADDRGP4 player_stand1
CALLV
pop
line 845
;845:}
LABELV $235
endproc spy_upaxe9 0 0
export TeamFortress_SpyFeignDeath
proc TeamFortress_SpyFeignDeath 56 28
line 850
;846:
;847://=========================================================================
;848:// Function handling the Spy's feign death ability
;849:void TeamFortress_SpyFeignDeath( int issilent )
;850:{
line 855
;851:	int     i, j;
;852:	gedict_t *at_spot;
;853:	gedict_t *te;
;854:
;855:	self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 856
;856:	if ( self->is_feigning )
ADDRGP4 self
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
EQI4 $239
line 857
;857:	{
line 859
;858:	        // Check to make sure there isn't anyone on top of us
;859:		at_spot = findradius( world, self->s.v.origin, 64 );
ADDRGP4 world
INDIRP4
ARGP4
ADDRGP4 self
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
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 860
;860:		i = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 861
;861:		j = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $242
JUMPV
LABELV $241
line 863
;862:		while ( at_spot )
;863:		{
line 864
;864:			if ( streq( at_spot->mdl, "progs/detpack.mdl" ) )
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 $246
ARGP4
ADDRLP4 20
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $244
line 865
;865:				j = 1;
ADDRLP4 8
CNSTI4 1
ASGNI4
LABELV $244
line 866
;866:			if ( streq( at_spot->mdl, "progs/detpack2.mdl" ) && tf_data.birthday == 1 )
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 $249
ARGP4
ADDRLP4 24
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $247
ADDRGP4 tf_data+92
INDIRI4
CNSTI4 1
NEI4 $247
line 867
;867:				j = 1;
ADDRLP4 8
CNSTI4 1
ASGNI4
LABELV $247
line 868
;868:			if ( streq( at_spot->mdl, "progs/turrbase.mdl" ) )
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 $253
ARGP4
ADDRLP4 28
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $251
line 869
;869:				j = 1;
ADDRLP4 8
CNSTI4 1
ASGNI4
LABELV $251
line 870
;870:			if ( streq( at_spot->mdl, "progs/turrgun.mdl" ) )
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 $256
ARGP4
ADDRLP4 32
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $254
line 871
;871:				j = 1;
ADDRLP4 8
CNSTI4 1
ASGNI4
LABELV $254
line 874
;872:		//	if ( streq( at_spot->mdl, "progs/disp.mdl" ) )
;873:		//		j = 1;
;874:			if ( streq( at_spot->mdl, "progs/dispencr.mdl" ) )
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 $259
ARGP4
ADDRLP4 36
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $257
line 875
;875:				j = 1;
ADDRLP4 8
CNSTI4 1
ASGNI4
LABELV $257
line 876
;876:			if ( streq( at_spot->s.v.classname, "player" ) && !at_spot->s.v.deadflag && self != at_spot )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $262
ARGP4
ADDRLP4 40
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $260
ADDRLP4 0
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
CNSTF4 0
NEF4 $260
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
EQU4 $260
line 877
;877:				j = 2;
ADDRLP4 8
CNSTI4 2
ASGNI4
LABELV $260
line 878
;878:			switch ( j )
ADDRLP4 8
INDIRI4
CNSTI4 1
EQI4 $265
ADDRLP4 8
INDIRI4
CNSTI4 2
EQI4 $267
ADDRGP4 $263
JUMPV
line 879
;879:			{
LABELV $265
line 881
;880:			case 1:
;881:				G_sprint( self, 2, "You can't get up with something\non top of you.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $266
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 882
;882:				return;
ADDRGP4 $237
JUMPV
LABELV $267
line 884
;883:			case 2:
;884:				G_sprint( self, 2, "You can't get up while someone\nis standing on you.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $268
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 885
;885:				return;
ADDRGP4 $237
JUMPV
LABELV $263
line 887
;886:			}
;887:			at_spot = findradius( at_spot, self->s.v.origin, 64 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ARGP4
CNSTF4 1115684864
ARGF4
ADDRLP4 52
ADDRGP4 findradius
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 52
INDIRP4
ASGNP4
line 888
;888:		}
LABELV $242
line 862
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $241
line 889
;889:		if ( self->is_squating == TRUE )
ADDRGP4 self
INDIRP4
CNSTI4 1776
ADDP4
INDIRI4
CNSTI4 1
NEI4 $269
line 890
;890:			unlay ( );
ADDRGP4 unlay
CALLV
pop
LABELV $269
line 891
;891:		SetVector( self->s.v.velocity, 0, 0, 0 );
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
line 892
;892:		setsize( self, -16, -16, -24, 16, 16, 32 );
ADDRGP4 self
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
line 893
;893:		SetVector( self->s.v.view_ofs, 0, 0, 22 );
ADDRGP4 self
INDIRP4
CNSTI4 352
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 356
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 360
ADDP4
CNSTF4 1102053376
ASGNF4
line 894
;894:		self->s.v.movetype = MOVETYPE_WALK;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1077936128
ASGNF4
line 895
;895:		self->is_feigning = 0;
ADDRGP4 self
INDIRP4
CNSTI4 880
ADDP4
CNSTI4 0
ASGNI4
line 896
;896:		self->current_weapon = self->s.v.weapon;
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 1032
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 897
;897:		W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 898
;898:		self->tfstate = self->tfstate - ( self->tfstate & TFSTATE_CANT_MOVE );
ADDRLP4 32
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRI4
ADDRLP4 36
INDIRI4
CNSTI4 65536
BANDI4
SUBI4
ASGNI4
line 899
;899:		TeamFortress_SetSpeed( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 901
;900:		// Check .weapon, because .current_weapon has been reset
;901:		if ( self->s.v.weapon <= 16 )
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1098907648
GTF4 $271
line 902
;902:		{
line 903
;903:			spy_upaxe1(  );
ADDRGP4 spy_upaxe1
CALLV
pop
line 904
;904:			return;
ADDRGP4 $237
JUMPV
LABELV $271
line 906
;905:		}
;906:		switch ( ( int ) ( g_random(  ) * 4 ) )
ADDRLP4 44
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 40
CNSTF4 1082130432
ADDRLP4 44
INDIRF4
MULF4
CVFI4 4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $276
ADDRLP4 40
INDIRI4
CNSTI4 1
EQI4 $277
ADDRLP4 40
INDIRI4
CNSTI4 2
EQI4 $278
ADDRGP4 $273
JUMPV
line 907
;907:		{
LABELV $276
line 909
;908:		case 0:
;909:			spy_upb1(  );
ADDRGP4 spy_upb1
CALLV
pop
line 910
;910:			break;
ADDRGP4 $237
JUMPV
LABELV $277
line 912
;911:		case 1:
;912:			spy_upc1(  );
ADDRGP4 spy_upc1
CALLV
pop
line 913
;913:			break;
ADDRGP4 $237
JUMPV
LABELV $278
line 915
;914:		case 2:
;915:			spy_upd1(  );
ADDRGP4 spy_upd1
CALLV
pop
line 916
;916:			break;
ADDRGP4 $237
JUMPV
LABELV $273
line 918
;917:		default:
;918:			spy_upe1(  );
ADDRGP4 spy_upe1
CALLV
pop
line 919
;919:			break;
line 921
;920:		}
;921:		return;
ADDRGP4 $237
JUMPV
LABELV $239
line 923
;922:	} else  // !self->is_feigning
;923:	{
line 925
;924:		
;925:		if ( self->hook_out )
ADDRGP4 self
INDIRP4
CNSTI4 1436
ADDP4
INDIRI4
CNSTI4 0
EQI4 $279
line 926
;926:		{
line 927
;927:			G_sprint( self, 2, "You can't feign with the hook out.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $281
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 928
;928:			return;
ADDRGP4 $237
JUMPV
LABELV $279
line 941
;929:		}
;930://REMOVE!!!		
;931:/*          if (self.is_unabletospy == 1) {
;932:           G_sprint(self, 2, "You can't go undercover right now.\n");
;933:           return;
;934:          }*/
;935:
;936:/*  if (!(self.flags & 512) && !self->s.v.waterlevel) {
;937:   G_sprint(self, 2, "You can't feign in the air.\n");
;938:   return;
;939:  }*/
;940:		
;941:		for ( at_spot = world; ( at_spot = findradius( at_spot, self->s.v.origin, 64 ) ) ; )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $285
JUMPV
LABELV $282
line 942
;942:		{
line 943
;943:			if ( streq( at_spot->s.v.classname, "player" ) && self != at_spot && at_spot->is_feigning == 1 )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $262
ARGP4
ADDRLP4 16
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $286
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
EQU4 $286
ADDRLP4 0
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 1
NEI4 $286
line 944
;944:			{
line 945
;945:				G_sprint( self, 2, "You can't feign on top of another spy!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $288
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 946
;946:				return;
ADDRGP4 $237
JUMPV
LABELV $286
line 948
;947:			}
;948:		}
LABELV $283
line 941
LABELV $285
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
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
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $282
line 949
;949:		self->tfstate = self->tfstate | TFSTATE_CANT_MOVE;
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 65536
BORI4
ASGNI4
line 950
;950:		TeamFortress_SetSpeed( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 951
;951:		self->is_feigning = 1;
ADDRGP4 self
INDIRP4
CNSTI4 880
ADDP4
CNSTI4 1
ASGNI4
line 952
;952:		Attack_Finished( 0.8 );
CNSTF4 1061997773
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 953
;953:		self->invisible_finished = 0;
ADDRGP4 self
INDIRP4
CNSTI4 736
ADDP4
CNSTF4 0
ASGNF4
line 954
;954:		self->s.v.modelindex = modelindex_player;
ADDRGP4 self
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 modelindex_player
INDIRI4
CVIF4 4
ASGNF4
line 955
;955:		self->s.v.weapon = self->current_weapon;
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 304
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 956
;956:		self->current_weapon = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 0
ASGNI4
line 957
;957:		self->s.v.weaponmodel = "";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $289
ASGNP4
line 958
;958:		self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 959
;959:		setsize( self, -16, -16, -24, 16, 16, -16 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 28
CNSTF4 3246391296
ASGNF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
CNSTF4 3250585600
ARGF4
ADDRLP4 32
CNSTF4 1098907648
ASGNF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 960
;960:		SetVector( self->s.v.view_ofs, 0, 0, 4 );
ADDRGP4 self
INDIRP4
CNSTI4 352
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 356
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 360
ADDP4
CNSTF4 1082130432
ASGNF4
line 961
;961:		self->s.v.movetype = MOVETYPE_TOSS;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 962
;962:		if ( !issilent )
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $290
line 963
;963:			DeathSound(  );
ADDRGP4 DeathSound
CALLV
pop
LABELV $290
line 964
;964:		self->s.v.angles[0] = 0;
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 0
ASGNF4
line 965
;965:		self->s.v.angles[2] = 0;
ADDRGP4 self
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 0
ASGNF4
line 966
;966:		if ( self->s.v.weapon <= 16 )
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1098907648
GTF4 $292
line 967
;967:		{
line 968
;968:			spy_die_ax1(  );
ADDRGP4 spy_die_ax1
CALLV
pop
line 969
;969:			return;
ADDRGP4 $237
JUMPV
LABELV $292
line 971
;970:		}
;971:		te = world;
ADDRLP4 4
ADDRGP4 world
INDIRP4
ASGNP4
line 972
;972:		for( te = world; ( te = trap_find( te, FOFS( s.v.classname ), "item_tfgoal" ) ) ;)
ADDRLP4 4
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $297
JUMPV
LABELV $294
line 973
;973:		{
line 974
;974:			if ( te->s.v.owner != EDICT_TO_PROG( self ) )
ADDRLP4 4
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
EQI4 $299
line 975
;975:				continue;
ADDRGP4 $295
JUMPV
LABELV $299
line 977
;976:
;977:			if ( !( te->goal_activation & TFGI_KEEP ) || self->has_disconnected == 1 )
ADDRLP4 4
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $303
ADDRGP4 self
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 1
NEI4 $301
LABELV $303
line 978
;978:				tfgoalitem_RemoveFromPlayer( te, self, 0 );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 tfgoalitem_RemoveFromPlayer
CALLV
pop
LABELV $301
line 979
;979:			if ( CTF_Map == 1 )
ADDRGP4 CTF_Map
INDIRI4
CNSTI4 1
NEI4 $304
line 980
;980:			{
line 981
;981:				if ( te->goal_no == 1 )
ADDRLP4 4
INDIRP4
CNSTI4 1112
ADDP4
INDIRI4
CNSTI4 1
NEI4 $306
line 982
;982:					G_bprint( 2, "%s лост the блуе flag!\n", self->s.v.netname );
CNSTI4 2
ARGI4
ADDRGP4 $308
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
ADDRGP4 $307
JUMPV
LABELV $306
line 984
;983:				else
;984:					G_bprint( 2, "%s лост the ред flag!\n", self->s.v.netname );
CNSTI4 2
ARGI4
ADDRGP4 $309
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
LABELV $307
line 985
;985:			}
LABELV $304
line 986
;986:		}
LABELV $295
line 972
LABELV $297
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $298
ARGP4
ADDRLP4 36
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 36
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $294
line 987
;987:		switch ( ( int ) ( g_random(  ) * 5 ) )
ADDRLP4 44
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 40
CNSTF4 1084227584
ADDRLP4 44
INDIRF4
MULF4
CVFI4 4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
LTI4 $310
ADDRLP4 40
INDIRI4
CNSTI4 3
GTI4 $310
ADDRLP4 40
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $317
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $317
address $313
address $314
address $315
address $316
code
line 988
;988:		{
LABELV $313
line 990
;989:		case 0:
;990:			spy_diea1(  );
ADDRGP4 spy_diea1
CALLV
pop
line 991
;991:			break;
ADDRGP4 $311
JUMPV
LABELV $314
line 993
;992:		case 1:
;993:			spy_dieb1(  );
ADDRGP4 spy_dieb1
CALLV
pop
line 994
;994:			break;
ADDRGP4 $311
JUMPV
LABELV $315
line 996
;995:		case 2:
;996:			spy_diec1(  );
ADDRGP4 spy_diec1
CALLV
pop
line 997
;997:			break;
ADDRGP4 $311
JUMPV
LABELV $316
line 999
;998:		case 3:
;999:			spy_died1(  );
ADDRGP4 spy_died1
CALLV
pop
line 1000
;1000:			break;
ADDRGP4 $311
JUMPV
LABELV $310
line 1002
;1001:		default:
;1002:			spy_diee1(  );
ADDRGP4 spy_diee1
CALLV
pop
line 1003
;1003:			break;
LABELV $311
line 1005
;1004:		}
;1005:	}
line 1006
;1006:}
LABELV $237
endproc TeamFortress_SpyFeignDeath 56 28
export TeamFortress_SpyGoUndercover
proc TeamFortress_SpyGoUndercover 12 12
line 1012
;1007:
;1008://=========================================================================
;1009:// If its a net game, the SPY goes invisible.
;1010:// If its a LAN game, the class/skin changing menu pops up.
;1011:void TeamFortress_SpyGoUndercover(  )
;1012:{
line 1016
;1013:	gedict_t *te;
;1014:
;1015:
;1016:	if ( tf_data.invis_only == 1 )
ADDRGP4 tf_data+60
INDIRI4
CNSTI4 1
NEI4 $319
line 1017
;1017:	{
line 1019
;1018:	        // If the spy is already invisible, become visible
;1019:		if ( ( int ) self->s.v.effects & ( EF_DIMLIGHT | EF_BRIGHTLIGHT ) )
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CVFI4 4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $322
line 1020
;1020:		{
line 1021
;1021:			G_sprint( self, 1, "You cannot disguise while glowing.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $324
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1022
;1022:			return;
ADDRGP4 $318
JUMPV
LABELV $322
line 1024
;1023:		}
;1024:		if ( self->is_unabletospy == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 884
ADDP4
INDIRI4
CNSTI4 1
NEI4 $325
line 1025
;1025:		{
line 1026
;1026:			G_sprint( self, 2, "You can't go undercover right now.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $327
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1027
;1027:			return;
ADDRGP4 $318
JUMPV
LABELV $325
line 1029
;1028:		}
;1029:		if ( self->is_undercover == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 868
ADDP4
INDIRI4
CNSTI4 1
NEI4 $328
line 1030
;1030:		{
line 1031
;1031:			self->is_undercover = 0;
ADDRGP4 self
INDIRP4
CNSTI4 868
ADDP4
CNSTI4 0
ASGNI4
line 1032
;1032:			self->s.v.modelindex = modelindex_player; // return to normal
ADDRGP4 self
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 modelindex_player
INDIRI4
CVIF4 4
ASGNF4
line 1033
;1033:			self->s.v.items = ( int ) self->s.v.items - ( ( int ) self->s.v.items & IT_INVISIBILITY );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 336
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
CNSTI4 524288
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 1034
;1034:		} else
ADDRGP4 $329
JUMPV
LABELV $328
line 1035
;1035:		{
line 1036
;1036:			if ( self->is_undercover == 2 )
ADDRGP4 self
INDIRP4
CNSTI4 868
ADDP4
INDIRI4
CNSTI4 2
NEI4 $330
line 1037
;1037:			{
line 1038
;1038:				G_sprint( self, 2, "You stop going undercover.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $332
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1039
;1039:				self->is_undercover = 0;
ADDRGP4 self
INDIRP4
CNSTI4 868
ADDP4
CNSTI4 0
ASGNI4
line 1040
;1040:			} else
ADDRGP4 $331
JUMPV
LABELV $330
line 1041
;1041:			{
line 1042
;1042:				if ( self->s.v.ammo_cells > 1 )
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1065353216
LEF4 $333
line 1043
;1043:				{
line 1044
;1044:					G_sprint( self, 2, "Going undercover...\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $335
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1045
;1045:					self->is_undercover = 2;
ADDRGP4 self
INDIRP4
CNSTI4 868
ADDP4
CNSTI4 2
ASGNI4
line 1046
;1046:					te = spawn(  );
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1047
;1047:					te->s.v.classname = "timer";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $336
ASGNP4
line 1048
;1048:					te->s.v.owner = EDICT_TO_PROG( self );
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
line 1049
;1049:					te->s.v.think = ( func_t ) TeamFortress_SpyUndercoverThink;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 TeamFortress_SpyUndercoverThink
CVPU4 4
CVUI4 4
ASGNI4
line 1050
;1050:					te->s.v.nextthink = g_globalvars.time + .01;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1008981770
ADDF4
ASGNF4
line 1051
;1051:				}
LABELV $333
line 1052
;1052:			}
LABELV $331
line 1053
;1053:		}
LABELV $329
line 1054
;1054:		self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1055
;1055:	} else
ADDRGP4 $320
JUMPV
LABELV $319
line 1056
;1056:	{
line 1057
;1057:		if ( self->is_undercover != 2 )
ADDRGP4 self
INDIRP4
CNSTI4 868
ADDP4
INDIRI4
CNSTI4 2
EQI4 $339
line 1058
;1058:		{
line 1059
;1059:			self->current_menu = MENU_SPY;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 12
ASGNI4
line 1060
;1060:			self->menu_count = MENU_REFRESH_RATE;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 25
ASGNI4
line 1061
;1061:		} else
ADDRGP4 $340
JUMPV
LABELV $339
line 1062
;1062:		{
line 1063
;1063:			G_sprint( self, 2, "You stop going undercover.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $332
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1064
;1064:			self->is_undercover = 0;
ADDRGP4 self
INDIRP4
CNSTI4 868
ADDP4
CNSTI4 0
ASGNI4
line 1065
;1065:		}
LABELV $340
line 1066
;1066:	}
LABELV $320
line 1067
;1067:}
LABELV $318
endproc TeamFortress_SpyGoUndercover 12 12
export TeamFortress_SpyCalcName
proc TeamFortress_SpyCalcName 12 12
line 1073
;1068:
;1069://=========================================================================
;1070:// Try and find the player's name who's skin and team closest fit the 
;1071:// current disguise of the spy
;1072:void TeamFortress_SpyCalcName( gedict_t * spy )
;1073:{
line 1076
;1074:	gedict_t *te;
;1075:
;1076:	spy->undercover_name = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1412
ADDP4
CNSTP4 0
ASGNP4
line 1078
;1077:	// Find a player on the team the spy is disguised as to pretend to be
;1078:	if ( spy->undercover_team )
ADDRFP4 0
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
CNSTI4 0
EQI4 $342
line 1079
;1079:	{
line 1080
;1080:		for ( te = world; (te = trap_find( te, FOFS( s.v.classname ), "player" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $347
JUMPV
LABELV $344
line 1081
;1081:		{
line 1083
;1082:		        // First, try to find a player with same color and skins
;1083:			if ( te->team_no == spy->undercover_team && te->s.v.skin == spy->undercover_skin )
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
NEI4 $348
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
CVIF4 4
NEF4 $348
line 1084
;1084:			{
line 1085
;1085:				spy->undercover_name = te->s.v.netname;
ADDRFP4 0
INDIRP4
CNSTI4 1412
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ASGNP4
line 1086
;1086:				break;
ADDRGP4 $346
JUMPV
LABELV $348
line 1088
;1087:			}
;1088:		}
LABELV $345
line 1080
LABELV $347
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $262
ARGP4
ADDRLP4 4
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $344
LABELV $346
line 1090
;1089:		// If we couldn't, just find one of that team
;1090:		if ( !spy->undercover_name )
ADDRFP4 0
INDIRP4
CNSTI4 1412
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $350
line 1091
;1091:		{
line 1093
;1092:
;1093:			for ( te = world; (te = trap_find( te, FOFS( s.v.classname ), "player" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $355
JUMPV
LABELV $352
line 1094
;1094:			{
line 1095
;1095:				if ( te->team_no == spy->undercover_team )
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
NEI4 $356
line 1096
;1096:				{
line 1097
;1097:					spy->undercover_name = te->s.v.netname;
ADDRFP4 0
INDIRP4
CNSTI4 1412
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ASGNP4
line 1098
;1098:					break;
ADDRGP4 $354
JUMPV
LABELV $356
line 1100
;1099:				}
;1100:			}
LABELV $353
line 1093
LABELV $355
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $262
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
NEU4 $352
LABELV $354
line 1101
;1101:		}
LABELV $350
line 1102
;1102:	}
LABELV $342
line 1103
;1103:}
LABELV $341
endproc TeamFortress_SpyCalcName 12 12
export TeamFortress_SpyUndercoverThink
proc TeamFortress_SpyUndercoverThink 12 16
line 1108
;1104:
;1105://=========================================================================
;1106:// Make the spy who owns this timer undercover, and then remove itself
;1107:void TeamFortress_SpyUndercoverThink(  )
;1108:{
line 1109
;1109:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 1111
;1110:
;1111:	if ( owner->playerclass != PC_SPY )
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
EQI4 $359
line 1112
;1112:		return;
ADDRGP4 $358
JUMPV
LABELV $359
line 1113
;1113:	if ( owner->is_undercover == 2 )
ADDRLP4 0
INDIRP4
CNSTI4 868
ADDP4
INDIRI4
CNSTI4 2
NEI4 $361
line 1114
;1114:	{
line 1115
;1115:		if ( tf_data.invis_only == 1 )
ADDRGP4 tf_data+60
INDIRI4
CNSTI4 1
NEI4 $363
line 1116
;1116:		{
line 1117
;1117:			owner->s.v.items = ( int ) owner->s.v.items | IT_INVISIBILITY;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 524288
BORI4
CVIF4 4
ASGNF4
line 1118
;1118:			owner->s.v.frame = 0;
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 0
ASGNF4
line 1119
;1119:			owner->s.v.modelindex = modelindex_eyes;
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 modelindex_eyes
INDIRI4
CVIF4 4
ASGNF4
line 1120
;1120:			owner->is_undercover = 1;
ADDRLP4 0
INDIRP4
CNSTI4 868
ADDP4
CNSTI4 1
ASGNI4
line 1121
;1121:		} else
ADDRGP4 $364
JUMPV
LABELV $363
line 1122
;1122:		{
line 1123
;1123:			owner->immune_to_check = g_globalvars.time + tf_data.cheat_pause;	//10;
ADDRLP4 0
INDIRP4
CNSTI4 1080
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 tf_data+96
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1124
;1124:			if ( self->s.v.skin )
ADDRGP4 self
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CNSTF4 0
EQF4 $368
line 1125
;1125:			{
line 1126
;1126:				owner->undercover_skin = self->s.v.skin;
ADDRLP4 0
INDIRP4
CNSTI4 1408
ADDP4
ADDRGP4 self
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 1127
;1127:				TeamFortress_SetSkin( owner );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSkin
CALLV
pop
line 1128
;1128:				G_sprint( owner, 2, "Skin set to " );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $370
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1129
;1129:				TeamFortress_PrintClassName( owner, self->s.v.skin, 0 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CVFI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_PrintClassName
CALLV
pop
line 1130
;1130:			}
LABELV $368
line 1131
;1131:			if ( self->s.v.team )
ADDRGP4 self
INDIRP4
CNSTI4 412
ADDP4
INDIRF4
CNSTF4 0
EQF4 $371
line 1132
;1132:			{
line 1133
;1133:				owner->undercover_team = self->s.v.team;
ADDRLP4 0
INDIRP4
CNSTI4 1404
ADDP4
ADDRGP4 self
INDIRP4
CNSTI4 412
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 1134
;1134:				TeamFortress_SetColor( owner, TeamFortress_TeamGetTopColor( self->s.v.team ),
ADDRGP4 self
INDIRP4
CNSTI4 412
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
ADDRGP4 TeamFortress_TeamGetTopColor
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 412
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 TeamFortress_SetColor
CALLV
pop
line 1137
;1135:					  TeamFortress_TeamGetColor( self->s.v.team ) - 1 );
;1136:
;1137:				TeamFortress_SetSkin( owner );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSkin
CALLV
pop
line 1138
;1138:				G_sprint( owner, 2, "Colors set to Team %.0f\n", self->s.v.team );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $373
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 412
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 1139
;1139:			}
LABELV $371
line 1140
;1140:			TeamFortress_SpyCalcName( owner );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SpyCalcName
CALLV
pop
line 1141
;1141:			if ( !owner->StatusBarSize )
ADDRLP4 0
INDIRP4
CNSTI4 1488
ADDP4
INDIRI4
CNSTI4 0
NEI4 $374
line 1142
;1142:				G_centerprint( owner, "You are now disguised.\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $376
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
LABELV $374
line 1143
;1143:			owner->is_undercover = 1;
ADDRLP4 0
INDIRP4
CNSTI4 868
ADDP4
CNSTI4 1
ASGNI4
line 1144
;1144:		}
LABELV $364
line 1145
;1145:	}
LABELV $361
line 1146
;1146:	owner->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRLP4 0
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1147
;1147:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1148
;1148:}
LABELV $358
endproc TeamFortress_SpyUndercoverThink 12 16
export TeamFortress_SpyChangeSkin
proc TeamFortress_SpyChangeSkin 8 12
line 1153
;1149:
;1150://=========================================================================
;1151:// Change the Spy's skin to the class they chose
;1152:void TeamFortress_SpyChangeSkin( int class )
;1153:{
line 1157
;1154:	gedict_t *te;
;1155:
;1156:	// If they're returning their skin to their Spy, just reset it
;1157:	if ( class == PC_SPY )
ADDRFP4 0
INDIRI4
CNSTI4 8
NEI4 $379
line 1158
;1158:	{
line 1160
;1159:
;1160:		if ( self->undercover_skin == 0 )
ADDRGP4 self
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
CNSTI4 0
NEI4 $381
line 1161
;1161:		{
line 1162
;1162:			G_sprint( self, 2, "Skin reset.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $383
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1163
;1163:			return;
ADDRGP4 $378
JUMPV
LABELV $381
line 1165
;1164:		}
;1165:		G_sprint( self, 2, "Skin reset.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $383
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1166
;1166:		self->undercover_skin = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1408
ADDP4
CNSTI4 0
ASGNI4
line 1167
;1167:		TeamFortress_SetSkin( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSkin
CALLV
pop
line 1168
;1168:		if ( !self->undercover_team )
ADDRGP4 self
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
CNSTI4 0
NEI4 $378
line 1169
;1169:			self->is_undercover = 0;
ADDRGP4 self
INDIRP4
CNSTI4 868
ADDP4
CNSTI4 0
ASGNI4
line 1170
;1170:		return;
ADDRGP4 $378
JUMPV
LABELV $379
line 1172
;1171:	}
;1172:	G_sprint( self, 2, "Going undercover...\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $335
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1173
;1173:	self->is_undercover = 2;
ADDRGP4 self
INDIRP4
CNSTI4 868
ADDP4
CNSTI4 2
ASGNI4
line 1176
;1174:	
;1175:	// Start a timer, which changes the spy's skin to the chosen one
;1176:	te = spawn(  );
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1177
;1177:	te->s.v.classname = "timer";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $336
ASGNP4
line 1178
;1178:	te->s.v.owner = EDICT_TO_PROG( self );
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
line 1179
;1179:	te->s.v.think = ( func_t ) TeamFortress_SpyUndercoverThink;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 TeamFortress_SpyUndercoverThink
CVPU4 4
CVUI4 4
ASGNI4
line 1180
;1180:	te->s.v.nextthink = g_globalvars.time + 0.01;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1008981770
ADDF4
ASGNF4
line 1181
;1181:	te->s.v.skin = class;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
ADDRFP4 0
INDIRI4
CVIF4 4
ASGNF4
line 1182
;1182:	TeamFortress_SetSkin( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSkin
CALLV
pop
line 1183
;1183:}
LABELV $378
endproc TeamFortress_SpyChangeSkin 8 12
export TeamFortress_SpyChangeColor
proc TeamFortress_SpyChangeColor 12 12
line 1188
;1184:
;1185://=========================================================================
;1186:// Change the Spy's color to that of the Team they chose
;1187:void TeamFortress_SpyChangeColor( int teamno )
;1188:{
line 1192
;1189:	gedict_t *te;
;1190:
;1191:	// If they're returning their color to their own team, just reset it
;1192:	if ( teamno == self->team_no )
ADDRFP4 0
INDIRI4
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
NEI4 $388
line 1193
;1193:	{
line 1195
;1194:
;1195:		if ( self->undercover_team == 0 )
ADDRGP4 self
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
CNSTI4 0
NEI4 $390
line 1196
;1196:		{
line 1197
;1197:			G_sprint( self, 2, "Colors reset.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $392
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1198
;1198:			return;
ADDRGP4 $387
JUMPV
LABELV $390
line 1200
;1199:		}
;1200:		G_sprint( self, 2, "Colors reset.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $392
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1201
;1201:		self->immune_to_check = g_globalvars.time + tf_data.cheat_pause;	//10;
ADDRGP4 self
INDIRP4
CNSTI4 1080
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 tf_data+96
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1202
;1202:		self->undercover_team = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1404
ADDP4
CNSTI4 0
ASGNI4
line 1203
;1203:		TeamFortress_SetColor( self, TeamFortress_TeamGetTopColor( self->team_no ),
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 TeamFortress_TeamGetTopColor
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 TeamFortress_SetColor
CALLV
pop
line 1206
;1204:			  TeamFortress_TeamGetColor( self->team_no ) - 1 );
;1205:
;1206:		if ( !self->undercover_skin )
ADDRGP4 self
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
CNSTI4 0
NEI4 $395
line 1207
;1207:			self->is_undercover = 0;
ADDRGP4 self
INDIRP4
CNSTI4 868
ADDP4
CNSTI4 0
ASGNI4
LABELV $395
line 1208
;1208:		TeamFortress_SetSkin( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSkin
CALLV
pop
line 1209
;1209:		return;
ADDRGP4 $387
JUMPV
LABELV $388
line 1211
;1210:	}
;1211:	G_sprint( self, 2, "Going undercover...\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $335
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1213
;1212:
;1213:	self->is_undercover = 2;
ADDRGP4 self
INDIRP4
CNSTI4 868
ADDP4
CNSTI4 2
ASGNI4
line 1216
;1214:
;1215:	// Start a timer, which changes the spy's skin to the chosen one
;1216:	te = spawn(  );
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1217
;1217:	te->s.v.classname = "timer";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $336
ASGNP4
line 1218
;1218:	te->s.v.owner = EDICT_TO_PROG( self );
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
line 1219
;1219:	te->s.v.think = ( func_t ) TeamFortress_SpyUndercoverThink;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 TeamFortress_SpyUndercoverThink
CVPU4 4
CVUI4 4
ASGNI4
line 1220
;1220:	te->s.v.nextthink = g_globalvars.time + 0.01;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1008981770
ADDF4
ASGNF4
line 1221
;1221:	te->s.v.team = teamno;
ADDRLP4 0
INDIRP4
CNSTI4 412
ADDP4
ADDRFP4 0
INDIRI4
CVIF4 4
ASGNF4
line 1222
;1222:}
LABELV $387
endproc TeamFortress_SpyChangeColor 12 12
export GasGrenadeTouch
proc GasGrenadeTouch 12 20
line 1227
;1223:
;1224://=========================================================================
;1225:// Gas Grenade touch function.
;1226:void GasGrenadeTouch(  )
;1227:{
line 1228
;1228:	sound( self, 1, "weapons/bounce.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $399
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
line 1229
;1229:	if ( VectorCompareF( self->s.v.velocity, 0, 0, 0 ) )
ADDRGP4 self
INDIRP4
CNSTI4 180
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
EQI4 $400
line 1230
;1230:		SetVector( self->s.v.avelocity, 0, 0, 0 );
ADDRGP4 self
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 0
ASGNF4
LABELV $400
line 1231
;1231:}
LABELV $398
endproc GasGrenadeTouch 12 20
export GasGrenadeExplode
proc GasGrenadeExplode 36 28
line 1236
;1232:
;1233://=========================================================================
;1234:// Gas grenade explosion. Throws up the particle cloud.
;1235:void GasGrenadeExplode(  )
;1236:{
line 1241
;1237:	gedict_t *te;
;1238:	float   pos;
;1239:
;1240:	// Check the pointcontents to prevent detpack outside the world
;1241:	pos = trap_pointcontents( PASSVEC3( self->s.v.origin ) );
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
ADDRLP4 12
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
CVIF4 4
ASGNF4
line 1242
;1242:	if ( pos == CONTENT_EMPTY )
ADDRLP4 0
INDIRF4
CNSTF4 3212836864
NEF4 $403
line 1243
;1243:	{
line 1244
;1244:		te = spawn(  );
ADDRLP4 16
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 1245
;1245:		te->s.v.think = ( func_t ) GasGrenadeMakeGas;
ADDRLP4 4
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 GasGrenadeMakeGas
CVPU4 4
CVUI4 4
ASGNI4
line 1246
;1246:		te->s.v.nextthink = g_globalvars.time + 0.1;
ADDRLP4 4
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1247
;1247:		te->heat = 0;
ADDRLP4 4
INDIRP4
CNSTI4 1076
ADDP4
CNSTF4 0
ASGNF4
line 1248
;1248:		VectorCopy( self->s.v.origin, te->s.v.origin );
ADDRLP4 20
CNSTI4 156
ASGNI4
ADDRLP4 4
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
ADDRLP4 4
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
ADDRLP4 4
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
line 1249
;1249:		te->s.v.owner = self->s.v.owner;
ADDRLP4 20
CNSTI4 480
ASGNI4
ADDRLP4 4
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
line 1250
;1250:		te->team_no = PROG_TO_EDICT( self->s.v.owner )->team_no;
ADDRLP4 4
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
line 1251
;1251:		te->s.v.weapon = 0;
ADDRLP4 4
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 0
ASGNF4
line 1252
;1252:	} else
ADDRGP4 $404
JUMPV
LABELV $403
line 1253
;1253:	{
line 1255
;1254:	        // Make some bubbles :)
;1255:		for ( pos = 0; pos < 10; pos++ )
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRGP4 $410
JUMPV
LABELV $407
line 1256
;1256:		{
line 1257
;1257:			newmis = spawn(  );
ADDRLP4 16
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 16
INDIRP4
ASGNP4
line 1258
;1258:			setmodel( newmis, "progs/s_bubble.spr" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $411
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1259
;1259:			setorigin( newmis, PASSVEC3( self->s.v.origin ) );
ADDRGP4 newmis
INDIRP4
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
ADDRGP4 setorigin
CALLV
pop
line 1260
;1260:			newmis->s.v.movetype = MOVETYPE_NOCLIP;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1090519040
ASGNF4
line 1261
;1261:			newmis->s.v.solid = SOLID_NOT;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 1262
;1262:			SetVector( newmis->s.v.velocity, 0, 0, 15 );
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1097859072
ASGNF4
line 1263
;1263:			newmis->s.v.velocity[2] = 10 + g_random(  ) * 20;
ADDRLP4 24
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1101004800
ADDRLP4 24
INDIRF4
MULF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 1264
;1264:			newmis->s.v.nextthink = g_globalvars.time + 0.5;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 1265
;1265:			newmis->s.v.think = ( func_t ) bubble_bob;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 bubble_bob
CVPU4 4
CVUI4 4
ASGNI4
line 1266
;1266:			newmis->s.v.classname = "bubble";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $413
ASGNP4
line 1267
;1267:			newmis->s.v.frame = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 0
ASGNF4
line 1268
;1268:			newmis->cnt = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 692
ADDP4
CNSTF4 0
ASGNF4
line 1269
;1269:			setsize( newmis, -8, -8, -8, 8, 8, 8 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 28
CNSTF4 3238002688
ASGNF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 32
CNSTF4 1090519040
ASGNF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1270
;1270:		}
LABELV $408
line 1255
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $410
ADDRLP4 0
INDIRF4
CNSTF4 1092616192
LTF4 $407
line 1271
;1271:	}
LABELV $404
line 1272
;1272:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1273
;1273:}
LABELV $402
endproc GasGrenadeExplode 36 28
export GasGrenadeMakeGas
proc GasGrenadeMakeGas 32 24
line 1278
;1274:
;1275://=========================================================================
;1276:// Gas Grenade Gas function
;1277:void GasGrenadeMakeGas(  )
;1278:{
line 1282
;1279:	gedict_t *te;
;1280:	gedict_t *timer;
;1281:
;1282:	self->s.v.nextthink = g_globalvars.time + 0.75;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1061158912
ADDF4
ASGNF4
line 1283
;1283:	for ( te = world; (te = findradius( te, self->s.v.origin, 200 )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $419
JUMPV
LABELV $416
line 1284
;1284:	{
line 1285
;1285:		if ( (te->team_no == PROG_TO_EDICT( self->s.v.owner )->team_no) && (te->last_used < g_globalvars.time) && (te->s.v.classname == "player") )
ADDRLP4 0
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
NEI4 $420
ADDRLP4 0
INDIRP4
CNSTI4 1772
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $420
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 $262
CVPU4 4
NEU4 $420
line 1286
;1286:		{
line 1287
;1287:			sound( te, 4, "player/gas_mask.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $424
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
line 1288
;1288:			te->last_used = g_globalvars.time + 2;
ADDRLP4 0
INDIRP4
CNSTI4 1772
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ASGNI4
line 1289
;1289:		}
LABELV $420
line 1290
;1290:		if ( streq( te->s.v.classname, "player" ) && !te->s.v.deadflag && te->has_disconnected != 1 && !( te->team_no == PROG_TO_EDICT( self->s.v.owner )->team_no ) )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $262
ARGP4
ADDRLP4 12
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $426
ADDRLP4 0
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
CNSTF4 0
NEF4 $426
ADDRLP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 1
EQI4 $426
ADDRLP4 0
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
EQI4 $426
line 1291
;1291:		{
line 1292
;1292:			tf_data.deathmsg = DMSG_GREN_GAS;
ADDRGP4 tf_data+88
CNSTI4 24
ASGNI4
line 1293
;1293:			TF_T_Damage( te, world, PROG_TO_EDICT( self->s.v.owner ), 10, 1 | 2, 0 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 world
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTF4 1092616192
ARGF4
CNSTI4 3
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 1294
;1294:			if ( te->tfstate & TFSTATE_HALLUCINATING )
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $430
line 1295
;1295:			{
line 1296
;1296:				for ( timer = world; (timer = trap_find( timer, FOFS( s.v.classname ), "timer" )); )
ADDRLP4 4
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $435
JUMPV
LABELV $432
line 1297
;1297:				{
line 1298
;1298:					if ( PROG_TO_EDICT( timer->s.v.owner ) != te )
ADDRLP4 4
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
EQU4 $436
line 1299
;1299:						continue;
ADDRGP4 $433
JUMPV
LABELV $436
line 1300
;1300:					if ( timer->s.v.think != ( func_t ) HallucinationTimer )
ADDRLP4 4
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ADDRGP4 HallucinationTimer
CVPU4 4
CVUI4 4
EQI4 $438
line 1301
;1301:						continue;
LABELV $438
line 1302
;1302:				}
LABELV $433
line 1296
LABELV $435
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $336
ARGP4
ADDRLP4 20
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $432
line 1303
;1303:				if ( timer )
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $431
line 1304
;1304:				{
line 1305
;1305:					timer->s.v.health = timer->s.v.health + 25;
ADDRLP4 24
ADDRLP4 4
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CNSTF4 1103626240
ADDF4
ASGNF4
line 1308
;1306:					//if(!( tf_data.new_gas & GAS_MASK_NEWGREN_TIMES))
;1307:					//{
;1308:						if ( timer->s.v.health < 100 )
ADDRLP4 4
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1120403456
GEF4 $442
line 1309
;1309:							timer->s.v.health = 100;
ADDRLP4 4
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1120403456
ASGNF4
LABELV $442
line 1310
;1310:						timer->s.v.nextthink = g_globalvars.time + 0.5;
ADDRLP4 4
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 1320
;1311:					//} else
;1312:					//{
;1313:					//	if ( timer->s.v.health < 150 )
;1314:					//		timer->s.v.health = 150;
;1315:					//	timer->s.v.nextthink = g_globalvars.time + 0.3;
;1316:					//}
;1317:					    
;1318:					//if( !( tf_data.new_gas & GAS_MASK_ALLSPYS ) && (g_random() < SETGAS_IN_GAS_TIME))
;1319:					//	SetGasSkins(te);
;1320:				}
line 1321
;1321:			} else
ADDRGP4 $431
JUMPV
LABELV $430
line 1322
;1322:			{
line 1325
;1323:				/*if ( tf_data.new_gas & GAS_MASK_PALETTE)
;1324:				{*/
;1325:					stuffcmd( te, "v_cshift 50 25 50 -50\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $445
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1326
;1326:					G_sprint( te, 2, "Far out man!\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $446
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1327
;1327:					stuffcmd ( te, "v_idlescale 10\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $447
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1330
;1328:				/*} else
;1329:					G_sprint( te, 2, "Run for cover! They're everywhere!\n" );*/
;1330:				te->tfstate = te->tfstate | TFSTATE_HALLUCINATING;
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 1331
;1331:				timer = spawn(  );
ADDRLP4 24
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 1333
;1332:				//if( !(tf_data.new_gas & GAS_MASK_NEWGREN_TIMES))
;1333:					timer->s.v.nextthink = g_globalvars.time + 0.5;
ADDRLP4 4
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 1336
;1334:				//else
;1335:				//	timer->s.v.nextthink = g_globalvars.time + 0.3;
;1336:				timer->s.v.think = ( func_t ) HallucinationTimer;
ADDRLP4 4
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 HallucinationTimer
CVPU4 4
CVUI4 4
ASGNI4
line 1338
;1337:
;1338:				SetGasSkins(te);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 SetGasSkins
CALLV
pop
line 1340
;1339:
;1340:				timer->s.v.classname = "timer";
ADDRLP4 4
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $336
ASGNP4
line 1341
;1341:				timer->s.v.owner = EDICT_TO_PROG( te );
ADDRLP4 4
INDIRP4
CNSTI4 480
ADDP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 1343
;1342:				//if( !(tf_data.new_gas & GAS_MASK_NEWGREN_TIMES))
;1343:					timer->s.v.health = 100;
ADDRLP4 4
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1120403456
ASGNF4
line 1346
;1344:				//else
;1345:				//	timer->s.v.health = 150;
;1346:				timer->team_no = self->team_no;
ADDRLP4 28
CNSTI4 960
ASGNI4
ADDRLP4 4
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
line 1347
;1347:			}
LABELV $431
line 1348
;1348:		}
LABELV $426
line 1349
;1349:	}
LABELV $417
line 1283
LABELV $419
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ARGP4
CNSTF4 1128792064
ARGF4
ADDRLP4 8
ADDRGP4 findradius
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
NEU4 $416
line 1350
;1350:	self->heat = self->heat + 1;
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 1076
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
line 1351
;1351:	if ( self->heat == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $449
line 1352
;1352:	{
line 1353
;1353:		trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1354
;1354:		trap_WriteByte( MSG_MULTICAST, TE_TAREXPLOSION );
ADDRLP4 16
CNSTI4 4
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1355
;1355:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
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
line 1356
;1356:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
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
line 1357
;1357:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] );
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
line 1358
;1358:		trap_multicast( PASSVEC3( self->s.v.origin ), 2 );
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
CNSTI4 2
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 1359
;1359:		return;
ADDRGP4 $414
JUMPV
LABELV $449
line 1361
;1360:	}
;1361:	if ( self->heat <= 20 )
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
CNSTF4 1101004800
GTF4 $451
line 1362
;1362:	{
line 1363
;1363:		self->s.v.weapon = self->s.v.weapon + 1;
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1364
;1364:		if ( self->s.v.weapon == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $453
line 1365
;1365:		{
line 1366
;1366:			trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1367
;1367:			trap_WriteByte( MSG_MULTICAST, TE_LAVASPLASH );
CNSTI4 4
ARGI4
CNSTI4 10
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1368
;1368:			trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
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
line 1369
;1369:			trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
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
line 1370
;1370:			trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] - 24 );
CNSTI4 4
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1103101952
SUBF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1371
;1371:			trap_multicast( PASSVEC3( self->s.v.origin ), 2 );
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
CNSTI4 2
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 1372
;1372:		} else
ADDRGP4 $414
JUMPV
LABELV $453
line 1373
;1373:		{
line 1374
;1374:			if ( self->s.v.weapon == 2 )
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $414
line 1375
;1375:				self->s.v.weapon = 0;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 0
ASGNF4
line 1376
;1376:		}
line 1377
;1377:		return;
ADDRGP4 $414
JUMPV
LABELV $451
line 1379
;1378:	}
;1379:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1380
;1380:}
LABELV $414
endproc GasGrenadeMakeGas 32 24
export GasEffect1
proc GasEffect1 24 16
line 1383
;1381:
;1382:void GasEffect1( gedict_t * owner )	//Random Temp Entites
;1383:{
line 1384
;1384:	g_globalvars.msg_entity = EDICT_TO_PROG( owner );
ADDRGP4 g_globalvars+316
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 1385
;1385:	trap_WriteByte( MSG_ONE, SVC_TEMPENTITY );
CNSTI4 1
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1387
;1386:
;1387:	switch ( ( int ) ( g_random(  ) * 3 ) )
ADDRLP4 4
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
CNSTF4 1077936128
ADDRLP4 4
INDIRF4
MULF4
CVFI4 4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $462
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $463
ADDRGP4 $459
JUMPV
line 1388
;1388:	{
LABELV $462
line 1390
;1389:	case 0:
;1390:		trap_WriteByte( MSG_ONE, TE_EXPLOSION );
CNSTI4 1
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1391
;1391:		break;
ADDRGP4 $460
JUMPV
LABELV $463
line 1393
;1392:	case 1:
;1393:		trap_WriteByte( MSG_ONE, TE_TAREXPLOSION );
CNSTI4 1
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1394
;1394:		break;
ADDRGP4 $460
JUMPV
LABELV $459
line 1396
;1395:	default:
;1396:		trap_WriteByte( MSG_ONE, TE_LAVASPLASH );
CNSTI4 1
ARGI4
CNSTI4 10
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1397
;1397:		break;
LABELV $460
line 1399
;1398:	}
;1399:	trap_WriteCoord( MSG_ONE, owner->s.v.origin[0] + g_random(  ) * 800 - 400 );
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
CNSTF4 1145569280
ADDRLP4 12
INDIRF4
MULF4
ADDF4
CNSTF4 1137180672
SUBF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1400
;1400:	trap_WriteCoord( MSG_ONE, owner->s.v.origin[1] + g_random(  ) * 800 - 400 );
ADDRLP4 16
ADDRGP4 g_random
CALLF4
ASGNF4
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
CNSTF4 1145569280
ADDRLP4 16
INDIRF4
MULF4
ADDF4
CNSTF4 1137180672
SUBF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1401
;1401:	trap_WriteCoord( MSG_ONE, owner->s.v.origin[2] );
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1402
;1402:	if( tf_data.new_gas & GAS_MASK_NEWGREN_DMG)
ADDRGP4 tf_data+144
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $464
line 1403
;1403:		T_Damage( owner, owner, owner, 0 );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 T_Damage
CALLV
pop
LABELV $464
line 1404
;1404:}
LABELV $457
endproc GasEffect1 24 16
data
align 4
LABELV gas_sounds
address $467
address $468
address $469
address $470
address $471
address $472
address $473
address $474
address $475
address $476
address $477
address $478
address $479
address $480
address $481
address $482
address $483
address $484
export GasEffect2
code
proc GasEffect2 16 8
line 1428
;1405:
;1406:static const char   *gas_sounds[] = {
;1407:	"play weapons/r_exp3.wav\n",
;1408:	"play weapons/rocket1i.wav\n",
;1409:	"play weapons/sgun1.wav\n",
;1410:	"play weapons/guncock.wav\n",
;1411:	"play weapons/ric1.wav\n",
;1412:	"play weapons/ric2.wav\n",
;1413:	"play weapons/ric3.wav\n",
;1414:	"play weapons/spike2.wav\n",
;1415:	"play weapons/tink1.wav\n",
;1416:	"play weapons/grenade.wav\n",
;1417:	"play weapons/bounce.wav\n",
;1418:	"play weapons/shotgn2.wav\n",
;1419:	"play wizard/wattack.wav\n",
;1420:	"play items/r_item1.wav\n",
;1421:	"play items/r_item2.wav\n",
;1422:	"play weapons/lhit.wav\n",
;1423:	"play misc/r_tele1.wav\n",
;1424:	"play weapons/railgun.wav\n"
;1425:};
;1426:
;1427:void GasEffect2( gedict_t * owner )	//sounds
;1428:{
line 1431
;1429:	int     i;
;1430:
;1431:	g_globalvars.msg_entity = EDICT_TO_PROG( owner );
ADDRGP4 g_globalvars+316
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 1432
;1432:	trap_WriteByte( MSG_ONE, SVC_TEMPENTITY );
CNSTI4 1
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1433
;1433:	trap_WriteByte( MSG_ONE, TE_TELEPORT );
CNSTI4 1
ARGI4
CNSTI4 11
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1434
;1434:	trap_WriteCoord( MSG_ONE, owner->s.v.origin[0] + g_random(  ) * 800 - 400 );
ADDRLP4 4
ADDRGP4 g_random
CALLF4
ASGNF4
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
CNSTF4 1145569280
ADDRLP4 4
INDIRF4
MULF4
ADDF4
CNSTF4 1137180672
SUBF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1435
;1435:	trap_WriteCoord( MSG_ONE, owner->s.v.origin[1] + g_random(  ) * 800 - 400 );
ADDRLP4 8
ADDRGP4 g_random
CALLF4
ASGNF4
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
CNSTF4 1145569280
ADDRLP4 8
INDIRF4
MULF4
ADDF4
CNSTF4 1137180672
SUBF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1436
;1436:	trap_WriteCoord( MSG_ONE, owner->s.v.origin[2] );
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1438
;1437:
;1438:	if ( !(tf_data.new_gas & GAS_MASK_NEWGREN_EFFECTS))
ADDRGP4 tf_data+144
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $487
line 1439
;1439:		return;
ADDRGP4 $485
JUMPV
LABELV $487
line 1440
;1440:	i = g_random(  ) * ( sizeof( gas_sounds ) / sizeof( gas_sounds[0] )  );
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
CNSTF4 1099956224
ADDRLP4 12
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1441
;1441:	stuffcmd( owner, gas_sounds[i] );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gas_sounds
ADDP4
INDIRP4
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1442
;1442:}
LABELV $485
endproc GasEffect2 16 8
data
align 4
LABELV gas_sounds2
address $490
address $491
address $492
address $493
address $494
address $495
address $496
address $497
address $498
address $499
export GasEffect3
code
proc GasEffect3 44 8
line 1457
;1443:
;1444:static const char   *gas_sounds2[] = {
;1445:	"play weapons/detpack.wav\n",
;1446:	"play weapons/turrset.wav\n",
;1447:	"play weapons/turrspot.wav\n",
;1448:	"play weapons/turridle.wav\n",
;1449:	"play weapons/sniper.wav\n",
;1450:	"play weapons/flmfire2.wav\n",
;1451:	"play weapons/flmgrexp.wav\n",
;1452:	"play misc/vapeur2.wav\n",
;1453:	"play weapons/asscan1.wav\n",
;1454:	"play weapons/asscan2.wav\n"
;1455:};
;1456:void GasEffect3( gedict_t * owner )
;1457:{
line 1461
;1458:	gedict_t *te;
;1459:	int     i;
;1460:
;1461:	g_globalvars.msg_entity = EDICT_TO_PROG( owner );
ADDRGP4 g_globalvars+316
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 1463
;1462:
;1463:	te = spawn(  );
ADDRLP4 8
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1464
;1464:	te->s.v.origin[0] = owner->s.v.origin[0] + g_random(  ) * 800 - 400;
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 16
CNSTI4 156
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
CNSTF4 1145569280
ADDRLP4 12
INDIRF4
MULF4
ADDF4
CNSTF4 1137180672
SUBF4
ASGNF4
line 1465
;1465:	te->s.v.origin[1] = owner->s.v.origin[1] + g_random(  ) * 800 - 400;
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 24
CNSTI4 160
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
CNSTF4 1145569280
ADDRLP4 20
INDIRF4
MULF4
ADDF4
CNSTF4 1137180672
SUBF4
ASGNF4
line 1466
;1466:	te->s.v.origin[2] = owner->s.v.origin[2];
ADDRLP4 28
CNSTI4 164
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 1467
;1467:	trap_WriteByte( MSG_ONE, SVC_TEMPENTITY );
CNSTI4 1
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1468
;1468:	trap_WriteByte( MSG_ONE, TE_LIGHTNING2 );
CNSTI4 1
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1469
;1469:	WriteEntity( MSG_ONE, te );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 WriteEntity
CALLV
pop
line 1470
;1470:	trap_WriteCoord( MSG_ONE, te->s.v.origin[0] );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1471
;1471:	trap_WriteCoord( MSG_ONE, te->s.v.origin[1] );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1472
;1472:	trap_WriteCoord( MSG_ONE, te->s.v.origin[2] );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1473
;1473:	trap_WriteCoord( MSG_ONE, owner->s.v.origin[0] + g_random(  ) * 800 - 400 );
ADDRLP4 32
ADDRGP4 g_random
CALLF4
ASGNF4
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
CNSTF4 1145569280
ADDRLP4 32
INDIRF4
MULF4
ADDF4
CNSTF4 1137180672
SUBF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1474
;1474:	trap_WriteCoord( MSG_ONE, owner->s.v.origin[1] + g_random(  ) * 800 - 400 );
ADDRLP4 36
ADDRGP4 g_random
CALLF4
ASGNF4
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
CNSTF4 1145569280
ADDRLP4 36
INDIRF4
MULF4
ADDF4
CNSTF4 1137180672
SUBF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1475
;1475:	trap_WriteCoord( MSG_ONE, owner->s.v.origin[2] );
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteCoord
CALLV
pop
line 1476
;1476:	dremove( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1478
;1477:
;1478:	if ( !(tf_data.new_gas & GAS_MASK_NEWGREN_EFFECTS))
ADDRGP4 tf_data+144
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $502
line 1479
;1479:		return;
ADDRGP4 $500
JUMPV
LABELV $502
line 1480
;1480:	i = g_random(  ) * ( sizeof( gas_sounds ) / sizeof( gas_sounds[0] ) );
ADDRLP4 40
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 4
CNSTF4 1099956224
ADDRLP4 40
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1481
;1481:	stuffcmd( owner, gas_sounds[i] );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gas_sounds
ADDP4
INDIRP4
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1482
;1482:}
LABELV $500
endproc GasEffect3 44 8
export HallucinationTimer
proc HallucinationTimer 60 20
line 1485
;1483:
;1484:void HallucinationTimer(  )
;1485:{
line 1486
;1486:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 1488
;1487:
;1488:	self->s.v.health = self->s.v.health - 2.5;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1075838976
SUBF4
ASGNF4
line 1489
;1489:	if ( owner->playerclass == PC_MEDIC )
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 5
NEI4 $506
line 1490
;1490:		self->s.v.health = self->s.v.health - 2.5;
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1075838976
SUBF4
ASGNF4
LABELV $506
line 1491
;1491:	if ( self->s.v.health <= 0 || owner->s.v.deadflag || owner->has_disconnected == 1 )
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
LEF4 $511
ADDRLP4 0
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
NEF4 $511
ADDRLP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 1
NEI4 $508
LABELV $511
line 1492
;1492:		owner->tfstate = owner->tfstate - ( owner->tfstate & TFSTATE_HALLUCINATING );
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRI4
ADDRLP4 24
INDIRI4
CNSTI4 16384
BANDI4
SUBI4
ASGNI4
LABELV $508
line 1493
;1493:	if ( owner->s.v.deadflag || owner->has_disconnected == 1 )
ADDRLP4 0
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
CNSTF4 0
NEF4 $514
ADDRLP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 1
NEI4 $512
LABELV $514
line 1494
;1494:	{
line 1495
;1495:	        ResetGasSkins( owner );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ResetGasSkins
CALLV
pop
line 1496
;1496:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1497
;1497:		return;
ADDRGP4 $505
JUMPV
LABELV $512
line 1499
;1498:	}
;1499:	if ( !( owner->tfstate & TFSTATE_HALLUCINATING ) )
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
NEI4 $515
line 1500
;1500:	{
line 1501
;1501:	        ResetGasSkins( owner );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ResetGasSkins
CALLV
pop
line 1504
;1502:
;1503:		//if ( tf_data.new_gas & GAS_MASK_PALETTE) 
;1504:		stuffcmd( owner, "v_cshift; wait; bf\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $517
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1505
;1505:		G_sprint( owner, 2, "You're sobering up now.\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $518
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1506
;1506:		stuffcmd( owner, "v_idlescale 0\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $519
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1507
;1507:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1508
;1508:		return;
ADDRGP4 $505
JUMPV
LABELV $515
line 1511
;1509:	}
;1510://	if( !(tf_data.new_gas & GAS_MASK_NEWGREN_TIMES))
;1511:		self->s.v.nextthink = g_globalvars.time + 0.5;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 1520
;1512://	else
;1513://		self->s.v.nextthink = g_globalvars.time + 0.3;
;1514:
;1515:	//if(!( tf_data.new_gas & GAS_MASK_ALLSPYS ) && g_random()< SETGAS_TIMER_THINK)
;1516:		//SetGasSkins(owner);
;1517://?????
;1518://        	self->s.v.nextthink = g_globalvars.time + 0.5;
;1519:
;1520:	if ( g_random(  ) < 0.5 )
ADDRLP4 32
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 1056964608
GEF4 $521
line 1521
;1521:		KickPlayer( -10, owner );
CNSTI4 -10
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 KickPlayer
CALLV
pop
LABELV $521
line 1524
;1522://	if ( tf_data.new_gas & GAS_MASK_PALETTE)
;1523://	{
;1524:		stuffcmd( owner, "v_cshift %d %d %d -75\n", ( int ) ( g_random(  ) * 100 ),
ADDRLP4 36
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 40
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 44
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $523
ARGP4
CNSTF4 1120403456
ADDRLP4 36
INDIRF4
MULF4
CVFI4 4
ARGI4
CNSTF4 1120403456
ADDRLP4 40
INDIRF4
MULF4
CVFI4 4
ARGI4
CNSTF4 1120403456
ADDRLP4 44
INDIRF4
MULF4
CVFI4 4
ARGI4
ADDRGP4 stuffcmd
CALLV
pop
line 1526
;1525:			  ( int ) ( g_random(  ) * 100 ), ( int ) ( g_random(  ) * 100 ) );
;1526:		stuffcmd( owner, "v_idlescale 10\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $447
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1529
;1527:		
;1528://	}
;1529:	g_globalvars.msg_entity = EDICT_TO_PROG( owner );
ADDRGP4 g_globalvars+316
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 1530
;1530:	switch ( ( int ) ( g_random(  ) * 3 ) )
ADDRLP4 52
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 48
CNSTF4 1077936128
ADDRLP4 52
INDIRF4
MULF4
CVFI4 4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $528
ADDRLP4 48
INDIRI4
CNSTI4 1
EQI4 $529
ADDRGP4 $525
JUMPV
line 1531
;1531:	{
LABELV $528
line 1533
;1532:	case 0:
;1533:		GasEffect1( owner );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 GasEffect1
CALLV
pop
line 1534
;1534:		break;
ADDRGP4 $526
JUMPV
LABELV $529
line 1536
;1535:	case 1:
;1536:		GasEffect2( owner );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 GasEffect2
CALLV
pop
line 1537
;1537:		break;
ADDRGP4 $526
JUMPV
LABELV $525
line 1539
;1538:	default:
;1539:		GasEffect3( owner );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 GasEffect3
CALLV
pop
line 1540
;1540:		break;
LABELV $526
line 1542
;1541:	}
;1542:}
LABELV $505
endproc HallucinationTimer 60 20
export W_FireTranq
proc W_FireTranq 32 28
line 1547
;1543:
;1544://=========================================================================
;1545:// Firing Function for the Tranquiliser Gun
;1546:void W_FireTranq(  )
;1547:{
line 1549
;1548:
;1549:	self->s.v.currentammo = --( self->s.v.ammo_shells );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 1551
;1550:
;1551:	KickPlayer( -2, self );
CNSTI4 -2
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickPlayer
CALLV
pop
line 1552
;1552:	newmis = spawn(  );
ADDRLP4 12
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 12
INDIRP4
ASGNP4
line 1553
;1553:	newmis->s.v.owner = EDICT_TO_PROG( self );
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
line 1554
;1554:	newmis->s.v.movetype = MOVETYPE_FLYMISSILE;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1091567616
ASGNF4
line 1555
;1555:	newmis->s.v.solid = SOLID_BBOX;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 1556
;1556:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 1557
;1557:	VectorCopy( g_globalvars.v_forward, newmis->s.v.velocity );
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ADDRGP4 g_globalvars+228
INDIRF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
ADDRGP4 g_globalvars+228+4
INDIRF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
ADDRGP4 g_globalvars+228+8
INDIRF4
ASGNF4
line 1559
;1558://	VectorScale( g_globalvars.v_forward, 1500, newmis->s.v.velocity ); // Faster than a normal nail
;1559:	VectorScale( g_globalvars.v_forward, 2000, newmis->s.v.velocity );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1157234688
ARGF4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 1560
;1560:	vectoangles( newmis->s.v.velocity, newmis->s.v.angles );
ADDRLP4 16
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1561
;1561:	newmis->s.v.touch = ( func_t ) T_TranqDartTouch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 T_TranqDartTouch
CVPU4 4
CVUI4 4
ASGNI4
line 1562
;1562:	newmis->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 1563
;1563:	newmis->s.v.nextthink = g_globalvars.time + 6;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1086324736
ADDF4
ASGNF4
line 1564
;1564:	setmodel( newmis, "progs/spike.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $538
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1566
;1565:	//setmodel( newmis, "progs/syringe.mdl" );		// new mtf model - sux 
;1566:	setsize( newmis, 0, 0, 0, 0, 0, 0 );
ADDRGP4 newmis
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
line 1567
;1567:	setorigin( newmis,
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
CNSTF4 0
ASGNF4
ADDRLP4 24
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
ADDF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
ADDF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 1571
;1568:		   self->s.v.origin[0] + 0,
;1569:		   self->s.v.origin[1] + 0,
;1570:		   self->s.v.origin[2] + 16 );
;1571:}
LABELV $530
endproc W_FireTranq 32 28
export T_TranqDartTouch
proc T_TranqDartTouch 36 24
line 1576
;1572:
;1573://=========================================================================
;1574:// Touch Function for the Tranquiliser Darts
;1575:void T_TranqDartTouch(  )
;1576:{
line 1579
;1577:	gedict_t *timer;
;1578:
;1579:	if ( other->s.v.solid == SOLID_TRIGGER )
ADDRGP4 other
INDIRP4
CNSTI4 152
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $540
line 1580
;1580:		return;
ADDRGP4 $539
JUMPV
LABELV $540
line 1581
;1581:	if ( trap_pointcontents( PASSVEC3( self->s.v.origin ) ) == -6 )
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
ADDRLP4 8
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 -6
NEI4 $542
line 1582
;1582:	{
line 1583
;1583:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1584
;1584:		return;
ADDRGP4 $539
JUMPV
LABELV $542
line 1586
;1585:	}
;1586:	if ( other->s.v.takedamage )
ADDRGP4 other
INDIRP4
CNSTI4 340
ADDP4
INDIRF4
CNSTF4 0
EQF4 $544
line 1587
;1587:	{
line 1588
;1588:		spawn_touchblood( 9 );
CNSTF4 1091567616
ARGF4
ADDRGP4 spawn_touchblood
CALLV
pop
line 1589
;1589:		tf_data.deathmsg = DMSG_TRANQ;
ADDRGP4 tf_data+88
CNSTI4 25
ASGNI4
line 1590
;1590:		TF_T_Damage( other, self, PROG_TO_EDICT( self->s.v.owner ), 20, 2, 2 );
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTF4 1101004800
ARGF4
ADDRLP4 16
CNSTI4 2
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 1591
;1591:		if ( streq( other->s.v.classname, "player" ) &&
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $262
ARGP4
ADDRLP4 20
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $545
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
NEI4 $550
ADDRGP4 teamplay
INDIRI4
CNSTI4 6
BANDI4
ADDRLP4 24
INDIRI4
NEI4 $545
LABELV $550
line 1593
;1592:		     !( other->team_no == PROG_TO_EDICT( self->s.v.owner )->team_no && ( teamplay & ( 2 | 4 ) ) ) )
;1593:		{
line 1594
;1594:			if ( other->tfstate & TFSTATE_TRANQUILISED )
ADDRGP4 other
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $551
line 1595
;1595:			{
line 1597
;1596:
;1597:				for ( timer = world; (timer = trap_find( timer, FOFS( s.v.classname ), "timer" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $556
JUMPV
LABELV $553
line 1598
;1598:				{
line 1599
;1599:					if ( PROG_TO_EDICT( timer->s.v.owner ) != other )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
ADDRGP4 other
INDIRP4
CVPU4 4
EQU4 $557
line 1600
;1600:						continue;
ADDRGP4 $554
JUMPV
LABELV $557
line 1601
;1601:					if ( timer->s.v.think != ( func_t ) TranquiliserTimer )
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ADDRGP4 TranquiliserTimer
CVPU4 4
CVUI4 4
EQI4 $559
line 1602
;1602:						continue;
LABELV $559
line 1603
;1603:				}
LABELV $554
line 1597
LABELV $556
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $336
ARGP4
ADDRLP4 28
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $553
line 1604
;1604:				if ( timer )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $545
line 1605
;1605:					timer->s.v.nextthink = g_globalvars.time + 15;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1606
;1606:			} else
ADDRGP4 $545
JUMPV
LABELV $551
line 1607
;1607:			{
line 1608
;1608:				G_sprint( other, 2, "You're getting sleepy...\n" );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $564
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1609
;1609:				other->tfstate = other->tfstate | TFSTATE_TRANQUILISED;
ADDRLP4 28
ADDRGP4 other
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 32768
BORI4
ASGNI4
line 1610
;1610:				stuffcmd( other, "v_cshift 125 0 255 100\n" );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 $565
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1611
;1611:				timer = spawn(  );
ADDRLP4 32
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 1612
;1612:				timer->s.v.nextthink = g_globalvars.time + TRANQ_TIME;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1613
;1613:				timer->s.v.think = ( func_t ) TranquiliserTimer;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 TranquiliserTimer
CVPU4 4
CVUI4 4
ASGNI4
line 1614
;1614:				timer->s.v.classname = "timer";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $336
ASGNP4
line 1615
;1615:				timer->s.v.owner = EDICT_TO_PROG( other );
ADDRLP4 0
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
line 1616
;1616:				timer->team_no = PROG_TO_EDICT( self->s.v.owner )->team_no;
ADDRLP4 0
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
line 1617
;1617:				TeamFortress_SetSpeed( other );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 1618
;1618:			}
line 1619
;1619:		}
line 1620
;1620:	} else
ADDRGP4 $545
JUMPV
LABELV $544
line 1621
;1621:	{
line 1622
;1622:		trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1623
;1623:		if ( streq( self->s.v.classname, "wizspike" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $570
ARGP4
ADDRLP4 12
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $568
line 1624
;1624:			trap_WriteByte( MSG_MULTICAST, TE_WIZSPIKE );
CNSTI4 4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
ADDRGP4 $569
JUMPV
LABELV $568
line 1626
;1625:		else
;1626:		{
line 1627
;1627:			if ( streq( self->s.v.classname, "knightspike" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $573
ARGP4
ADDRLP4 16
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $571
line 1628
;1628:				trap_WriteByte( MSG_MULTICAST, TE_KNIGHTSPIKE );
CNSTI4 4
ARGI4
CNSTI4 8
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
ADDRGP4 $572
JUMPV
LABELV $571
line 1630
;1629:			else
;1630:				trap_WriteByte( MSG_MULTICAST, TE_SPIKE );
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
LABELV $572
line 1631
;1631:		}
LABELV $569
line 1632
;1632:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
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
line 1633
;1633:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
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
line 1634
;1634:		trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] );
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
line 1635
;1635:		trap_multicast( PASSVEC3( self->s.v.origin ), 2 );
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
CNSTI4 2
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 1636
;1636:	}
LABELV $545
line 1637
;1637:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1638
;1638:}
LABELV $539
endproc T_TranqDartTouch 36 24
export TranquiliserTimer
proc TranquiliserTimer 12 12
line 1644
;1639:
;1640://=========================================================================
;1641:// Think function for Tranquilisation.
;1642:// Just remove the player's tranquilisation.
;1643:void TranquiliserTimer(  )
;1644:{
line 1645
;1645:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 1647
;1646:
;1647:	owner->tfstate -= owner->tfstate & TFSTATE_TRANQUILISED;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 32768
BANDI4
SUBI4
ASGNI4
line 1648
;1648:	TeamFortress_SetSpeed( owner );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 1649
;1649:	stuffcmd( owner, "v_cshift 0 0 0 0\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $575
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1650
;1650:	G_sprint( owner, 2, "You feel more alert now\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $576
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1651
;1651:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1652
;1652:}
LABELV $574
endproc TranquiliserTimer 12 12
export Spy_RemoveDisguise
proc Spy_RemoveDisguise 8 12
line 1656
;1653:
;1654:// Reset spy skin and color or remove invisibility
;1655:void Spy_RemoveDisguise( gedict_t * spy )
;1656:{
line 1658
;1657:
;1658:	if ( tf_data.invis_only != 1 )
ADDRGP4 tf_data+60
INDIRI4
CNSTI4 1
EQI4 $578
line 1659
;1659:	{
line 1660
;1660:		if ( spy->playerclass == PC_SPY )
ADDRFP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $579
line 1661
;1661:		{
line 1662
;1662:			if ( spy->undercover_team )
ADDRFP4 0
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
CNSTI4 0
EQI4 $583
line 1663
;1663:			{
line 1664
;1664:				spy->immune_to_check = g_globalvars.time + tf_data.cheat_pause;	//10;
ADDRFP4 0
INDIRP4
CNSTI4 1080
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 tf_data+96
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1665
;1665:				spy->undercover_team = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1404
ADDP4
CNSTI4 0
ASGNI4
line 1666
;1666:				TeamFortress_SetColor( spy, TeamFortress_TeamGetTopColor( spy->team_no ),
ADDRFP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 TeamFortress_TeamGetTopColor
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 TeamFortress_SetColor
CALLV
pop
line 1669
;1667:					  TeamFortress_TeamGetColor( spy->team_no ) - 1 );
;1668:
;1669:			}
LABELV $583
line 1670
;1670:			if ( spy->undercover_skin )
ADDRFP4 0
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
CNSTI4 0
EQI4 $587
line 1671
;1671:			{
line 1672
;1672:				spy->immune_to_check = g_globalvars.time + tf_data.cheat_pause;	//10;
ADDRFP4 0
INDIRP4
CNSTI4 1080
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 tf_data+96
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1673
;1673:				spy->undercover_skin = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1408
ADDP4
CNSTI4 0
ASGNI4
line 1674
;1674:				spy->s.v.skin = 0;
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 0
ASGNF4
line 1675
;1675:			}
LABELV $587
line 1676
;1676:			spy->is_undercover = 0;
ADDRFP4 0
INDIRP4
CNSTI4 868
ADDP4
CNSTI4 0
ASGNI4
line 1677
;1677:			self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1678
;1678:			TeamFortress_SetSkin( spy );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSkin
CALLV
pop
line 1679
;1679:			TeamFortress_SpyCalcName( spy );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SpyCalcName
CALLV
pop
line 1680
;1680:		}
line 1681
;1681:	} else
ADDRGP4 $579
JUMPV
LABELV $578
line 1682
;1682:	{
line 1683
;1683:		if ( spy->is_undercover )
ADDRFP4 0
INDIRP4
CNSTI4 868
ADDP4
INDIRI4
CNSTI4 0
EQI4 $592
line 1684
;1684:		{
line 1685
;1685:			spy->is_undercover = 0;
ADDRFP4 0
INDIRP4
CNSTI4 868
ADDP4
CNSTI4 0
ASGNI4
line 1686
;1686:			spy->s.v.modelindex = modelindex_player;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 modelindex_player
INDIRI4
CVIF4 4
ASGNF4
line 1687
;1687:			if ( ( int ) spy->s.v.items & 524288 )
ADDRFP4 0
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CVFI4 4
CNSTI4 524288
BANDI4
CNSTI4 0
EQI4 $594
line 1688
;1688:			{
line 1689
;1689:				spy->invisible_finished = 0;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTF4 0
ASGNF4
line 1690
;1690:				spy->invisible_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 756
ADDP4
CNSTF4 0
ASGNF4
line 1691
;1691:				spy->s.v.items = ( int ) spy->s.v.items - 524288;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 524288
SUBI4
CVIF4 4
ASGNF4
line 1692
;1692:			}
LABELV $594
line 1693
;1693:			self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1694
;1694:		}
LABELV $592
line 1695
;1695:	}
LABELV $579
line 1696
;1696:}
LABELV $577
endproc Spy_RemoveDisguise 8 12
export ResetGasSkins
proc ResetGasSkins 32 24
line 1700
;1697:
;1698:///Fake Color Skin Setinfo
;1699:void ResetGasSkins( gedict_t*pl)
;1700:{
line 1705
;1701:	gedict_t*te;
;1702:	int		entnum;
;1703:	char	st[20];
;1704:
;1705:	if( !(tf_data.new_gas & (GAS_MASK_COLOR | GAS_MASK_SKIN | GAS_MASK_ALLSPYS)) )
ADDRGP4 tf_data+144
INDIRI4
CNSTI4 67
BANDI4
CNSTI4 0
NEI4 $598
line 1706
;1706:		return;
ADDRGP4 $597
JUMPV
LABELV $598
line 1708
;1707:
;1708:	if( pl->has_disconnected )
ADDRFP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
EQI4 $601
line 1709
;1709:		return;
ADDRGP4 $597
JUMPV
LABELV $601
line 1711
;1710:
;1711:	if( !pl->has_fake_gas_setinfo )
ADDRFP4 0
INDIRP4
CNSTI4 1592
ADDP4
INDIRI4
CNSTI4 0
NEI4 $603
line 1712
;1712:		return;
ADDRGP4 $597
JUMPV
LABELV $603
line 1714
;1713:
;1714:	for( te = world; (te = trap_find( te, FOFS( s.v.classname), "player" ));)
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $608
JUMPV
LABELV $605
line 1715
;1715:	{
line 1716
;1716:		if( te->has_disconnected )
ADDRLP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
EQI4 $609
line 1717
;1717:			continue;
ADDRGP4 $606
JUMPV
LABELV $609
line 1719
;1718:
;1719:		entnum = NUM_FOR_EDICT(te) - 1;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 28
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1721
;1720:		
;1721:		if( entnum > MAX_CLIENTS )
ADDRLP4 24
INDIRI4
CNSTI4 32
LEI4 $611
line 1722
;1722:		{
line 1723
;1723:			G_conprintf("ResetGasSkins: entnum > MAX_CLIENTS\n");
ADDRGP4 $613
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
line 1724
;1724:			continue;
ADDRGP4 $606
JUMPV
LABELV $611
line 1727
;1725:		}
;1726:
;1727:		g_globalvars.msg_entity = EDICT_TO_PROG( pl );
ADDRGP4 g_globalvars+316
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 1729
;1728:
;1729:		if( tf_data.new_gas & (GAS_MASK_COLOR|GAS_MASK_ALLSPYS) )
ADDRGP4 tf_data+144
INDIRI4
CNSTI4 65
BANDI4
CNSTI4 0
EQI4 $615
line 1730
;1730:		{
line 1731
;1731:			GetInfokeyString( te, "topcolor", NULL, st, sizeof(st), "");
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $618
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 $289
ARGP4
ADDRGP4 GetInfokeyString
CALLI4
pop
line 1733
;1732:
;1733:			trap_WriteByte(MSG_ONE,SVC_SETINFO );
CNSTI4 1
ARGI4
CNSTI4 51
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1734
;1734:			trap_WriteByte(MSG_ONE, entnum );
CNSTI4 1
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1735
;1735:			trap_WriteString(MSG_ONE,"topcolor" );
CNSTI4 1
ARGI4
ADDRGP4 $618
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 1736
;1736:			trap_WriteString(MSG_ONE, st);
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 1738
;1737:
;1738:			GetInfokeyString( te, "bottomcolor", NULL, st, sizeof(st), "");
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $619
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 $289
ARGP4
ADDRGP4 GetInfokeyString
CALLI4
pop
line 1740
;1739:
;1740:			trap_WriteByte(MSG_ONE, SVC_SETINFO );
CNSTI4 1
ARGI4
CNSTI4 51
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1741
;1741:			trap_WriteByte(MSG_ONE, entnum );
CNSTI4 1
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1742
;1742:			trap_WriteString(MSG_ONE,"bottomcolor" );
CNSTI4 1
ARGI4
ADDRGP4 $619
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 1743
;1743:			trap_WriteString(MSG_ONE, st);
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 1744
;1744:		}
LABELV $615
line 1746
;1745:
;1746:		if( tf_data.new_gas & (GAS_MASK_SKIN|GAS_MASK_ALLSPYS) )
ADDRGP4 tf_data+144
INDIRI4
CNSTI4 66
BANDI4
CNSTI4 0
EQI4 $620
line 1747
;1747:		{
line 1748
;1748:			GetInfokeyString( te, "skin", NULL, st, sizeof(st), "");
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $623
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 $289
ARGP4
ADDRGP4 GetInfokeyString
CALLI4
pop
line 1750
;1749:
;1750:			trap_WriteByte(MSG_ONE, SVC_SETINFO );
CNSTI4 1
ARGI4
CNSTI4 51
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1751
;1751:			trap_WriteByte(MSG_ONE, entnum );
CNSTI4 1
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1752
;1752:			trap_WriteString(MSG_ONE,"skin" );
CNSTI4 1
ARGI4
ADDRGP4 $623
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 1753
;1753:			trap_WriteString(MSG_ONE, st);
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 1754
;1754:		}
LABELV $620
line 1755
;1755:	}
LABELV $606
line 1714
LABELV $608
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $262
ARGP4
ADDRLP4 28
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $605
line 1756
;1756:}
LABELV $597
endproc ResetGasSkins 32 24
export SetGasSkins
proc SetGasSkins 64 16
line 1760
;1757:
;1758:
;1759:void SetGasSkins( gedict_t*pl)
;1760:{
line 1766
;1761:	gedict_t*te;
;1762:	int		entnum;
;1763:	int		rskin,rteam,rcol;
;1764:	char	st[20];
;1765:
;1766:	if( !(tf_data.new_gas & (GAS_MASK_COLOR | GAS_MASK_SKIN | GAS_MASK_ALLSPYS)) )
ADDRGP4 tf_data+144
INDIRI4
CNSTI4 67
BANDI4
CNSTI4 0
NEI4 $625
line 1767
;1767:		return;
ADDRGP4 $624
JUMPV
LABELV $625
line 1769
;1768:
;1769:	if( pl->has_disconnected )
ADDRFP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
EQI4 $628
line 1770
;1770:		return;
ADDRGP4 $624
JUMPV
LABELV $628
line 1772
;1771:
;1772:	pl->has_fake_gas_setinfo = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1592
ADDP4
CNSTI4 1
ASGNI4
line 1773
;1773:	for( te = world; (te = trap_find( te, FOFS( s.v.classname), "player" ));)
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $633
JUMPV
LABELV $630
line 1774
;1774:	{
line 1776
;1775:
;1776:		entnum = NUM_FOR_EDICT(te) - 1;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 40
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1778
;1777:		
;1778:		if( te->has_disconnected || te == pl)
ADDRLP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
NEI4 $636
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $634
LABELV $636
line 1779
;1779:			continue;
ADDRGP4 $631
JUMPV
LABELV $634
line 1781
;1780:		
;1781:		if( entnum > MAX_CLIENTS )
ADDRLP4 4
INDIRI4
CNSTI4 32
LEI4 $637
line 1782
;1782:		{
line 1783
;1783:			G_conprintf("SetGasSkins: entnum > MAX_CLIENTS\n");
ADDRGP4 $639
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
line 1784
;1784:			continue;
ADDRGP4 $631
JUMPV
LABELV $637
line 1787
;1785:		}
;1786:
;1787:		g_globalvars.msg_entity = EDICT_TO_PROG( pl );
ADDRGP4 g_globalvars+316
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 1788
;1788:		if( tf_data.new_gas & GAS_MASK_ALLSPYS)
ADDRGP4 tf_data+144
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $641
line 1789
;1789:		{
line 1790
;1790:			rteam = pl->team_no%2 + 1;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 2
MODI4
CNSTI4 1
ADDI4
ASGNI4
line 1792
;1791:
;1792:			rcol = TeamFortress_TeamGetTopColor(rteam);
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 TeamFortress_TeamGetTopColor
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 48
INDIRI4
ASGNI4
line 1793
;1793:			_snprintf(st, sizeof(st), "%d",rcol);
ADDRLP4 8
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 $644
ARGP4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 _snprintf
CALLI4
pop
line 1794
;1794:			trap_WriteByte(MSG_ONE,SVC_SETINFO );
CNSTI4 1
ARGI4
CNSTI4 51
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1795
;1795:			trap_WriteByte(MSG_ONE, entnum );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1796
;1796:			trap_WriteString(MSG_ONE,"topcolor" );
CNSTI4 1
ARGI4
ADDRGP4 $618
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 1797
;1797:			trap_WriteString(MSG_ONE, st);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 1799
;1798:
;1799:			rcol = TeamFortress_TeamGetColor(rteam) - 1;
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 52
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1800
;1800:			_snprintf(st, sizeof(st), "%d",rcol);
ADDRLP4 8
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 $644
ARGP4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 _snprintf
CALLI4
pop
line 1802
;1801:
;1802:			trap_WriteByte(MSG_ONE, SVC_SETINFO );
CNSTI4 1
ARGI4
CNSTI4 51
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1803
;1803:			trap_WriteByte(MSG_ONE, entnum );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1804
;1804:			trap_WriteString(MSG_ONE,"bottomcolor" );
CNSTI4 1
ARGI4
ADDRGP4 $619
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 1805
;1805:			trap_WriteString(MSG_ONE, st);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 1808
;1806:
;1807:
;1808:			trap_WriteByte(MSG_ONE, SVC_SETINFO );
CNSTI4 1
ARGI4
CNSTI4 51
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1809
;1809:			trap_WriteByte(MSG_ONE, entnum );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1810
;1810:			trap_WriteString(MSG_ONE,"skin" );
CNSTI4 1
ARGI4
ADDRGP4 $623
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 1811
;1811:			trap_WriteString(MSG_ONE, TeamFortress_GetSkinByTeamClass(rteam, 8));
ADDRLP4 28
INDIRI4
ARGI4
CNSTI4 8
ARGI4
ADDRLP4 56
ADDRGP4 TeamFortress_GetSkinByTeamClass
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 56
INDIRP4
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 1812
;1812:		}else
ADDRGP4 $642
JUMPV
LABELV $641
line 1813
;1813:		{
line 1814
;1814:			rteam = pl->team_no;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
line 1816
;1815:
;1816:			if( ( tf_data.new_gas & GAS_MASK_COLOR ) && g_random()< SETGAS_SETCOLOR)
ADDRGP4 tf_data+144
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $645
ADDRLP4 48
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 48
INDIRF4
CNSTF4 1053609165
GEF4 $645
line 1817
;1817:			{
line 1818
;1818:				if( tf_data.new_gas & GAS_MASK_ALLCOLORS)
ADDRGP4 tf_data+144
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $648
line 1819
;1819:				{
line 1820
;1820:					rcol = g_random() * 16;
ADDRLP4 52
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 32
CNSTF4 1098907648
ADDRLP4 52
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1821
;1821:				}else
ADDRGP4 $649
JUMPV
LABELV $648
line 1822
;1822:				{
line 1823
;1823:					if( tf_data.new_gas & GAS_MASK_4COLORS)
ADDRGP4 tf_data+144
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $651
line 1824
;1824:						rteam = g_random() * 4;
ADDRLP4 52
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 28
CNSTF4 1082130432
ADDRLP4 52
INDIRF4
MULF4
CVFI4 4
ASGNI4
ADDRGP4 $652
JUMPV
LABELV $651
line 1826
;1825:					else
;1826:						rteam = g_random() * number_of_teams;
ADDRLP4 56
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 56
INDIRF4
ADDRGP4 number_of_teams
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
LABELV $652
line 1827
;1827:					rteam++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1828
;1828:					rcol = TeamFortress_TeamGetTopColor( rteam  );
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 TeamFortress_TeamGetTopColor
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 60
INDIRI4
ASGNI4
line 1829
;1829:				}
LABELV $649
line 1831
;1830:
;1831:				_snprintf(st, sizeof(st), "%d",rcol);
ADDRLP4 8
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 $644
ARGP4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 _snprintf
CALLI4
pop
line 1832
;1832:				trap_WriteByte(MSG_ONE,SVC_SETINFO );
CNSTI4 1
ARGI4
CNSTI4 51
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1833
;1833:				trap_WriteByte(MSG_ONE, entnum );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1834
;1834:				trap_WriteString(MSG_ONE,"topcolor" );
CNSTI4 1
ARGI4
ADDRGP4 $618
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 1835
;1835:				trap_WriteString(MSG_ONE, st);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 1837
;1836:
;1837:				if( !(tf_data.new_gas & GAS_MASK_ALLCOLORS))
ADDRGP4 tf_data+144
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $654
line 1838
;1838:				{
line 1839
;1839:					rcol = TeamFortress_TeamGetColor(rteam) - 1;
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 52
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1840
;1840:					_snprintf(st, sizeof(st), "%d",rcol);
ADDRLP4 8
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 $644
ARGP4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 _snprintf
CALLI4
pop
line 1841
;1841:				}
LABELV $654
line 1842
;1842:				trap_WriteByte(MSG_ONE,SVC_SETINFO );
CNSTI4 1
ARGI4
CNSTI4 51
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1843
;1843:				trap_WriteByte(MSG_ONE, entnum );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1844
;1844:				trap_WriteString(MSG_ONE,"bottomcolor" );
CNSTI4 1
ARGI4
ADDRGP4 $619
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 1845
;1845:				trap_WriteString(MSG_ONE, st);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 1846
;1846:			}
LABELV $645
line 1848
;1847:
;1848:			if( (tf_data.new_gas & GAS_MASK_SKIN ) && g_random()<SETGAS_SETSKIN)
ADDRGP4 tf_data+144
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $657
ADDRLP4 52
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 52
INDIRF4
CNSTF4 1045220557
GEF4 $657
line 1849
;1849:			{
line 1850
;1850:				rskin = g_random() *9 +1;
ADDRLP4 56
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 36
CNSTF4 1091567616
ADDRLP4 56
INDIRF4
MULF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1853
;1851:
;1852:				
;1853:				trap_WriteByte(MSG_ONE, SVC_SETINFO );
CNSTI4 1
ARGI4
CNSTI4 51
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1854
;1854:				trap_WriteByte(MSG_ONE, entnum );
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1855
;1855:				trap_WriteString(MSG_ONE,"skin" );
CNSTI4 1
ARGI4
ADDRGP4 $623
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 1856
;1856:				trap_WriteString(MSG_ONE, TeamFortress_GetSkinByTeamClass(rteam, rskin) );
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 TeamFortress_GetSkinByTeamClass
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 60
INDIRP4
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 1857
;1857:			}
LABELV $657
line 1859
;1858:	
;1859:		}
LABELV $642
line 1861
;1860:
;1861:	}
LABELV $631
line 1773
LABELV $633
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $262
ARGP4
ADDRLP4 40
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $630
line 1862
;1862:}
LABELV $624
endproc SetGasSkins 64 16
import spawn_touchblood
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
LABELV $644
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $639
byte 1 83
byte 1 101
byte 1 116
byte 1 71
byte 1 97
byte 1 115
byte 1 83
byte 1 107
byte 1 105
byte 1 110
byte 1 115
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 110
byte 1 117
byte 1 109
byte 1 32
byte 1 62
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 67
byte 1 76
byte 1 73
byte 1 69
byte 1 78
byte 1 84
byte 1 83
byte 1 10
byte 1 0
align 1
LABELV $623
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $619
byte 1 98
byte 1 111
byte 1 116
byte 1 116
byte 1 111
byte 1 109
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $618
byte 1 116
byte 1 111
byte 1 112
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $613
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 71
byte 1 97
byte 1 115
byte 1 83
byte 1 107
byte 1 105
byte 1 110
byte 1 115
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 110
byte 1 117
byte 1 109
byte 1 32
byte 1 62
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 67
byte 1 76
byte 1 73
byte 1 69
byte 1 78
byte 1 84
byte 1 83
byte 1 10
byte 1 0
align 1
LABELV $576
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 101
byte 1 101
byte 1 108
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 101
byte 1 114
byte 1 116
byte 1 32
byte 1 110
byte 1 111
byte 1 119
byte 1 10
byte 1 0
align 1
LABELV $575
byte 1 118
byte 1 95
byte 1 99
byte 1 115
byte 1 104
byte 1 105
byte 1 102
byte 1 116
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $573
byte 1 107
byte 1 110
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 0
align 1
LABELV $570
byte 1 119
byte 1 105
byte 1 122
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 0
align 1
LABELV $565
byte 1 118
byte 1 95
byte 1 99
byte 1 115
byte 1 104
byte 1 105
byte 1 102
byte 1 116
byte 1 32
byte 1 49
byte 1 50
byte 1 53
byte 1 32
byte 1 48
byte 1 32
byte 1 50
byte 1 53
byte 1 53
byte 1 32
byte 1 49
byte 1 48
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $564
byte 1 89
byte 1 111
byte 1 117
byte 1 39
byte 1 114
byte 1 101
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 115
byte 1 108
byte 1 101
byte 1 101
byte 1 112
byte 1 121
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $538
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
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $523
byte 1 118
byte 1 95
byte 1 99
byte 1 115
byte 1 104
byte 1 105
byte 1 102
byte 1 116
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 45
byte 1 55
byte 1 53
byte 1 10
byte 1 0
align 1
LABELV $519
byte 1 118
byte 1 95
byte 1 105
byte 1 100
byte 1 108
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 32
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $518
byte 1 89
byte 1 111
byte 1 117
byte 1 39
byte 1 114
byte 1 101
byte 1 32
byte 1 115
byte 1 111
byte 1 98
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 117
byte 1 112
byte 1 32
byte 1 110
byte 1 111
byte 1 119
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $517
byte 1 118
byte 1 95
byte 1 99
byte 1 115
byte 1 104
byte 1 105
byte 1 102
byte 1 116
byte 1 59
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 59
byte 1 32
byte 1 98
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $499
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $498
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $497
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 118
byte 1 97
byte 1 112
byte 1 101
byte 1 117
byte 1 114
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $496
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 109
byte 1 103
byte 1 114
byte 1 101
byte 1 120
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $495
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 109
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $494
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 110
byte 1 105
byte 1 112
byte 1 101
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $493
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 116
byte 1 117
byte 1 114
byte 1 114
byte 1 105
byte 1 100
byte 1 108
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $492
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 116
byte 1 117
byte 1 114
byte 1 114
byte 1 115
byte 1 112
byte 1 111
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $491
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 116
byte 1 117
byte 1 114
byte 1 114
byte 1 115
byte 1 101
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $490
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $484
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $483
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
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
byte 1 10
byte 1 0
align 1
LABELV $482
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 108
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $481
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
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
byte 1 10
byte 1 0
align 1
LABELV $480
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
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
byte 1 10
byte 1 0
align 1
LABELV $479
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 122
byte 1 97
byte 1 114
byte 1 100
byte 1 47
byte 1 119
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $478
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 110
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $477
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
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
byte 1 10
byte 1 0
align 1
LABELV $476
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $475
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
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
byte 1 10
byte 1 0
align 1
LABELV $474
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
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
byte 1 10
byte 1 0
align 1
LABELV $473
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $472
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $471
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $470
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
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
byte 1 99
byte 1 111
byte 1 99
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $469
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 103
byte 1 117
byte 1 110
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $468
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 49
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $467
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
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
byte 1 10
byte 1 0
align 1
LABELV $447
byte 1 118
byte 1 95
byte 1 105
byte 1 100
byte 1 108
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 32
byte 1 49
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $446
byte 1 70
byte 1 97
byte 1 114
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $445
byte 1 118
byte 1 95
byte 1 99
byte 1 115
byte 1 104
byte 1 105
byte 1 102
byte 1 116
byte 1 32
byte 1 53
byte 1 48
byte 1 32
byte 1 50
byte 1 53
byte 1 32
byte 1 53
byte 1 48
byte 1 32
byte 1 45
byte 1 53
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $424
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 97
byte 1 115
byte 1 95
byte 1 109
byte 1 97
byte 1 115
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $413
byte 1 98
byte 1 117
byte 1 98
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $411
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
LABELV $399
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
LABELV $392
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $383
byte 1 83
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 114
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $376
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 110
byte 1 111
byte 1 119
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 103
byte 1 117
byte 1 105
byte 1 115
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $373
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $370
byte 1 83
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 0
align 1
LABELV $336
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $335
byte 1 71
byte 1 111
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 117
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 99
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $332
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 32
byte 1 103
byte 1 111
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 117
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 99
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $327
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 111
byte 1 32
byte 1 117
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 99
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 114
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 110
byte 1 111
byte 1 119
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $324
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 103
byte 1 117
byte 1 105
byte 1 115
byte 1 101
byte 1 32
byte 1 119
byte 1 104
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 103
byte 1 108
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $309
byte 1 37
byte 1 115
byte 1 32
byte 1 204
byte 1 207
byte 1 211
byte 1 212
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 210
byte 1 197
byte 1 196
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $308
byte 1 37
byte 1 115
byte 1 32
byte 1 204
byte 1 207
byte 1 211
byte 1 212
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 194
byte 1 204
byte 1 213
byte 1 197
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $298
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 116
byte 1 102
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $289
byte 1 0
align 1
LABELV $288
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 102
byte 1 101
byte 1 105
byte 1 103
byte 1 110
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 112
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 97
byte 1 110
byte 1 111
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 115
byte 1 112
byte 1 121
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $281
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 102
byte 1 101
byte 1 105
byte 1 103
byte 1 110
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 104
byte 1 111
byte 1 111
byte 1 107
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $268
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 117
byte 1 112
byte 1 32
byte 1 119
byte 1 104
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 115
byte 1 111
byte 1 109
byte 1 101
byte 1 111
byte 1 110
byte 1 101
byte 1 10
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $266
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 117
byte 1 112
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 115
byte 1 111
byte 1 109
byte 1 101
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 112
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $262
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $259
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 101
byte 1 110
byte 1 99
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $256
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
LABELV $253
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
LABELV $249
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $246
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
