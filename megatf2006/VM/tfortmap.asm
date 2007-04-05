data
export team_menu_string
align 4
LABELV team_menu_string
byte 4 0
export UpdateAbbreviations
code
proc UpdateAbbreviations 28 20
file "..\src\tfortmap.c"
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
;21: *  $Id: tfortmap.c,v 1.24 2006/03/04 15:10:06 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:static int     item_list_bit;
;26:char   *team_menu_string = NULL;
;27:int     CTF_Map;
;28:void UpdateAbbreviations( gedict_t * Goal )
;29:{
line 31
;30:
;31:	if ( !Goal->has_abbreviated )
ADDRFP4 0
INDIRP4
CNSTI4 1100
ADDP4
INDIRI4
CNSTI4 0
NEI4 $12
line 32
;32:	{
line 35
;33:		char    st[10];
;34:
;35:		if ( !tf_data.flagem_checked )
ADDRGP4 tf_data+68
INDIRI4
CNSTI4 0
NEI4 $14
line 36
;36:		{
line 38
;37:
;38:			GetSVInfokeyString( "fe", "flag_emu", st, sizeof( st ), "off" );
ADDRGP4 $17
ARGP4
ADDRGP4 $18
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $19
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 39
;39:			if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $22
ARGP4
ADDRLP4 12
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $20
line 40
;40:				tf_data.toggleflags |= TFLAG_FLAG_EMULATION;
ADDRLP4 16
ADDRGP4 tf_data
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
LABELV $20
line 41
;41:			GetSVInfokeyString( "ws", "use_standard", st, sizeof( st ), "off" );
ADDRGP4 $23
ARGP4
ADDRGP4 $24
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $19
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 43
;42:
;43:			if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $22
ARGP4
ADDRLP4 20
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $25
line 44
;44:				tf_data.toggleflags |= TFLAG_USE_WAR_STD;
ADDRLP4 24
ADDRGP4 tf_data
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
LABELV $25
line 45
;45:			tf_data.flagem_checked = 1;
ADDRGP4 tf_data+68
CNSTI4 1
ASGNI4
line 46
;46:		}
LABELV $14
line 85
;47:/*		if ( ( tf_data.toggleflags & TFLAG_FLAG_EMULATION ) && !( tf_data.toggleflags & TFLAG_USE_WAR_STD ) )
;48:		{
;49:			if ( streq( Goal->mdl, "progs/b_s_key.mdl" ) || streq( Goal->mdl, "progs/m_s_key.mdl" )
;50:			     || streq( Goal->mdl, "progs/w_s_key.mdl" ) )
;51:			{
;52:				Goal->mdl = "progs/tf_flag.mdl";
;53:				Goal->s.v.skin = 1;
;54:			} else
;55:			{
;56:				if ( streq( Goal->mdl, "progs/b_g_key.mdl" ) || streq( Goal->mdl, "progs/m_g_key.mdl" )
;57:				     || streq( Goal->mdl, "progs/w_g_key.mdl" ) )
;58:				{
;59:					Goal->mdl = "progs/tf_flag.mdl";
;60:					Goal->s.v.skin = 2;
;61:				}
;62:			}
;63:		}
;64:		if ( tf_data.toggleflags & TFLAG_USE_WAR_STD )
;65:		{
;66:			if ( streq( Goal->mdl, "progs/b_s_key.mdl" ) || streq( Goal->mdl, "progs/m_s_key.mdl" )
;67:			     || streq( Goal->mdl, "progs/w_s_key.mdl" ) )
;68:			{
;69:				Goal->mdl = "progs/tf_stan.mdl";
;70:				Goal->s.v.skin = 1;
;71:			} else
;72:			{
;73:				if ( streq( Goal->mdl, "progs/b_g_key.mdl" ) || streq( Goal->mdl, "progs/m_g_key.mdl" )
;74:				     || streq( Goal->mdl, "progs/w_g_key.mdl" ) )
;75:				{
;76:					Goal->mdl = "progs/tf_stan.mdl";
;77:					Goal->s.v.skin = 2;
;78:				} else
;79:				{
;80:					if ( streq( Goal->mdl, "progs/tf_flag.mdl" ) )
;81:						Goal->mdl = "progs/tf_stan.mdl";
;82:				}
;83:			}
;84:		}*/
;85:		Goal->has_abbreviated = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1100
ADDP4
CNSTI4 1
ASGNI4
line 86
;86:	}
LABELV $12
line 87
;87:}
LABELV $11
endproc UpdateAbbreviations 28 20
export TF_PlaceItem
proc TF_PlaceItem 16 16
line 91
;88:
;89:
;90:void TF_PlaceItem(  )
;91:{
line 94
;92:	float   oldz;
;93:
;94:	self->s.v.flags = FL_ITEM;
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
CNSTF4 1132462080
ASGNF4
line 95
;95:	SetVector( self->s.v.velocity, 0, 0, 0 );
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
line 96
;96:	if ( self->goal_activation & TFGI_DROP_TO_FLOOR )
ADDRGP4 self
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $29
line 97
;97:	{
line 98
;98:		self->s.v.movetype = MOVETYPE_TOSS;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 99
;99:		self->s.v.origin[2] = self->s.v.origin[2] + 6;
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
CNSTF4 1086324736
ADDF4
ASGNF4
line 100
;100:		oldz = self->s.v.origin[2];
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 101
;101:		if ( !droptofloor( self ) )
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 droptofloor
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $31
line 102
;102:		{
line 103
;103:			G_dprintf( "GoalItem fell out of level at '%f %f %f'\n",
ADDRGP4 $33
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
ADDRGP4 G_dprintf
CALLV
pop
line 105
;104:				  self->s.v.origin[0], self->s.v.origin[1], self->s.v.origin[2] );
;105:			dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 106
;106:			return;
ADDRGP4 $28
JUMPV
LABELV $31
line 108
;107:		}
;108:	}
LABELV $29
line 109
;109:	self->s.v.movetype = MOVETYPE_NONE;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 110
;110:	VectorCopy( self->s.v.origin, self->s.v.oldorigin );
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 111
;111:	if ( self->goal_activation & TFGI_ITEMGLOWS )
ADDRGP4 self
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $34
line 112
;112:		self->s.v.effects = ( int ) self->s.v.effects | EF_DIMLIGHT;
ADDRLP4 4
ADDRGP4 self
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
CNSTI4 8
BORI4
CVIF4 4
ASGNF4
LABELV $34
line 113
;113:	if ( !item_list_bit )
ADDRGP4 item_list_bit
INDIRI4
CNSTI4 0
NEI4 $36
line 114
;114:		item_list_bit = 1;
ADDRGP4 item_list_bit
CNSTI4 1
ASGNI4
LABELV $36
line 115
;115:	self->item_list = item_list_bit;
ADDRGP4 self
INDIRP4
CNSTI4 1384
ADDP4
ADDRGP4 item_list_bit
INDIRI4
ASGNI4
line 116
;116:	item_list_bit *= 2;
ADDRLP4 8
ADDRGP4 item_list_bit
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 117
;117:}
LABELV $28
endproc TF_PlaceItem 16 16
export TF_StartItem
proc TF_StartItem 0 4
line 120
;118:
;119:void TF_StartItem(  )
;120:{
line 121
;121:	UpdateAbbreviations( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 UpdateAbbreviations
CALLV
pop
line 122
;122:	self->s.v.nextthink = g_globalvars.time + 0.2;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 123
;123:	self->s.v.think = ( func_t ) TF_PlaceItem;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 TF_PlaceItem
CVPU4 4
CVUI4 4
ASGNI4
line 124
;124:	if ( self->goal_state == TFGS_REMOVED )
ADDRGP4 self
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 3
NEI4 $40
line 125
;125:		RemoveGoal( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 RemoveGoal
CALLV
pop
LABELV $40
line 126
;126:}
LABELV $38
endproc TF_StartItem 0 4
export TF_PlaceGoal
proc TF_PlaceGoal 20 16
line 129
;127:
;128:void TF_PlaceGoal(  )
;129:{
line 132
;130:	float   oldz;
;131:
;132:	if ( strneq( self->s.v.classname, "info_tfgoal_timer" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $45
ARGP4
ADDRLP4 4
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $43
line 133
;133:	{
line 134
;134:		if ( self->goal_activation & TFGA_TOUCH )
ADDRGP4 self
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $44
line 135
;135:			self->s.v.touch = ( func_t ) tfgoal_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 tfgoal_touch
CVPU4 4
CVUI4 4
ASGNI4
line 136
;136:	} else
ADDRGP4 $44
JUMPV
LABELV $43
line 137
;137:	{
line 138
;138:		self->s.v.think = ( func_t ) tfgoal_timer_tick;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 tfgoal_timer_tick
CVPU4 4
CVUI4 4
ASGNI4
line 139
;139:		self->s.v.nextthink = g_globalvars.time + self->search_time;
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 1108
ADDP4
INDIRF4
ADDF4
ASGNF4
line 140
;140:		self->s.v.classname = "info_tfgoal";
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $49
ASGNP4
line 141
;141:	}
LABELV $44
line 142
;142:	if ( self->goal_activation & TFGI_DROP_TO_FLOOR )
ADDRGP4 self
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $50
line 143
;143:	{
line 144
;144:		self->s.v.movetype = MOVETYPE_TOSS;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 145
;145:		self->s.v.origin[2] = self->s.v.origin[2] + 6;
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1086324736
ADDF4
ASGNF4
line 146
;146:		oldz = self->s.v.origin[2];
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 147
;147:		if ( !droptofloor( self ) )
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 droptofloor
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $52
line 148
;148:		{
line 149
;149:			G_dprintf( "Goal fell out of level at '%f %f %f'\n",
ADDRGP4 $54
ARGP4
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
ADDRGP4 G_dprintf
CALLV
pop
line 152
;150:				  self->s.v.origin[0], self->s.v.origin[1], self->s.v.origin[2] );
;151:
;152:			dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 153
;153:			return;
ADDRGP4 $42
JUMPV
LABELV $52
line 155
;154:		}
;155:	}
LABELV $50
line 156
;156:	self->s.v.flags = FL_ITEM;
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
CNSTF4 1132462080
ASGNF4
line 157
;157:	self->s.v.movetype = MOVETYPE_NONE;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 158
;158:	SetVector( self->s.v.velocity, 0, 0, 0 );
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
line 159
;159:	VectorCopy( self->s.v.origin, self->s.v.oldorigin );
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 172
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 160
;160:}
LABELV $42
endproc TF_PlaceGoal 20 16
export TF_StartGoal
proc TF_StartGoal 0 4
line 163
;161:
;162:void TF_StartGoal(  )
;163:{
line 164
;164:	UpdateAbbreviations( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 UpdateAbbreviations
CALLV
pop
line 165
;165:	self->s.v.nextthink = g_globalvars.time + 0.2;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 166
;166:	self->s.v.think = ( func_t ) TF_PlaceGoal;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 TF_PlaceGoal
CVPU4 4
CVUI4 4
ASGNI4
line 167
;167:	self->s.v.use = ( func_t ) info_tfgoal_use;
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
ADDRGP4 info_tfgoal_use
CVPU4 4
CVUI4 4
ASGNI4
line 168
;168:	if ( self->goal_state == TFGS_REMOVED )
ADDRGP4 self
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 3
NEI4 $57
line 169
;169:		RemoveGoal( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 RemoveGoal
CALLV
pop
LABELV $57
line 170
;170:}
LABELV $55
endproc TF_StartGoal 0 4
export CheckExistence
proc CheckExistence 12 4
line 173
;171:
;172:int CheckExistence(  )
;173:{
line 174
;174:	UpdateAbbreviations( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 UpdateAbbreviations
CALLV
pop
line 175
;175:	skill = trap_cvar( "skill" );
ADDRGP4 $60
ARGP4
ADDRLP4 0
ADDRGP4 trap_cvar
CALLF4
ASGNF4
ADDRGP4 skill
ADDRLP4 0
INDIRF4
CVFI4 4
ASGNI4
line 176
;176:	if ( self->ex_skill_min == -1 && skill < 0 )
ADDRGP4 self
INDIRP4
CNSTI4 1308
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $61
ADDRGP4 skill
INDIRI4
CNSTI4 0
GEI4 $61
line 177
;177:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $59
JUMPV
LABELV $61
line 179
;178:	else
;179:	{
line 180
;180:		if ( self->ex_skill_max == -1 && skill > 0 )
ADDRGP4 self
INDIRP4
CNSTI4 1312
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $63
ADDRGP4 skill
INDIRI4
CNSTI4 0
LEI4 $63
line 181
;181:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $59
JUMPV
LABELV $63
line 182
;182:	}
line 183
;183:	if ( self->ex_skill_min && self->ex_skill_min != -1 && skill < self->ex_skill_min )
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 1308
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $65
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $65
ADDRGP4 skill
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $65
line 184
;184:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $59
JUMPV
LABELV $65
line 186
;185:	else
;186:	{
line 187
;187:		if ( self->ex_skill_max && self->ex_skill_max != -1 && skill > self->ex_skill_max )
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 1312
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $67
ADDRLP4 8
INDIRI4
CNSTI4 -1
EQI4 $67
ADDRGP4 skill
INDIRI4
ADDRLP4 8
INDIRI4
LEI4 $67
line 188
;188:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $59
JUMPV
LABELV $67
line 189
;189:	}
line 190
;190:	return 1;
CNSTI4 1
RETI4
LABELV $59
endproc CheckExistence 12 4
export SP_info_tfdetect
proc SP_info_tfdetect 0 4
line 194
;191:}
;192:
;193:void SP_info_tfdetect(  )
;194:{
line 195
;195:	UpdateAbbreviations( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 UpdateAbbreviations
CALLV
pop
line 196
;196:}
LABELV $69
endproc SP_info_tfdetect 0 4
export SP_info_player_teamspawn
proc SP_info_player_teamspawn 12 4
line 200
;197:
;198:extern const char *team_spawn_str[5];
;199:void SP_info_player_teamspawn(  )
;200:{
line 202
;201:
;202:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $71
line 203
;203:	{
line 204
;204:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 205
;205:		return;
ADDRGP4 $70
JUMPV
LABELV $71
line 207
;206:	}
;207:	if ( self->team_no <= 0 || self->team_no >= 5 )
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LEI4 $75
ADDRLP4 4
INDIRI4
CNSTI4 5
LTI4 $73
LABELV $75
line 208
;208:	{
line 209
;209:		G_Error( "error: bad team_no associated with info_player_teamspawn\n" );
ADDRGP4 $76
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 210
;210:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 211
;211:		return;
ADDRGP4 $70
JUMPV
LABELV $73
line 213
;212:	}
;213:	if ( number_of_teams < self->team_no )
ADDRGP4 number_of_teams
INDIRI4
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
GEI4 $77
line 214
;214:		number_of_teams = self->team_no;
ADDRGP4 number_of_teams
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
LABELV $77
line 215
;215:	self->team_str_home = (char*)team_spawn_str[self->team_no];
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 1284
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 team_spawn_str
ADDP4
INDIRP4
ASGNP4
line 216
;216:}
LABELV $70
endproc SP_info_player_teamspawn 12 4
export SP_i_p_t
proc SP_i_p_t 0 0
line 219
;217:
;218:void SP_i_p_t(  )
;219:{
line 220
;220:	self->s.v.classname = "info_player_teamspawn";
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $80
ASGNP4
line 221
;221:	SP_info_player_teamspawn(  );
ADDRGP4 SP_info_player_teamspawn
CALLV
pop
line 222
;222:}
LABELV $79
endproc SP_i_p_t 0 0
export SP_info_tfgoal
proc SP_info_tfgoal 24 28
line 225
;223:
;224:void SP_info_tfgoal(  )
;225:{
line 226
;226:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $82
line 227
;227:	{
line 228
;228:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 229
;229:		return;
ADDRGP4 $81
JUMPV
LABELV $82
line 231
;230:	}
;231:	if ( self->mdl )
ADDRGP4 self
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $84
line 232
;232:	{
line 233
;233:		trap_precache_model( self->mdl );
ADDRGP4 self
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 234
;234:		setmodel( self, self->mdl );
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 235
;235:	}
LABELV $84
line 236
;236:	if ( self->s.v.noise )
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $86
line 237
;237:	{
line 238
;238:		trap_precache_sound( self->s.v.noise );
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 239
;239:	}
LABELV $86
line 240
;240:	trap_precache_sound( "items/protect.wav" );
ADDRGP4 $88
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 241
;241:	trap_precache_sound( "items/protect2.wav" );
ADDRGP4 $89
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 242
;242:	trap_precache_sound( "items/protect3.wav" );
ADDRGP4 $90
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 243
;243:	trap_precache_sound( "items/suit.wav" );
ADDRGP4 $91
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 244
;244:	trap_precache_sound( "items/suit2.wav" );
ADDRGP4 $92
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 245
;245:	trap_precache_sound( "items/inv1.wav" );
ADDRGP4 $93
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 246
;246:	trap_precache_sound( "items/inv2.wav" );
ADDRGP4 $94
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 247
;247:	trap_precache_sound( "items/inv3.wav" );
ADDRGP4 $95
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 248
;248:	trap_precache_sound( "items/damage.wav" );
ADDRGP4 $96
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 249
;249:	trap_precache_sound( "items/damage2.wav" );
ADDRGP4 $97
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 250
;250:	trap_precache_sound( "items/damage3.wav" );
ADDRGP4 $98
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 251
;251:	self->s.v.solid = SOLID_TRIGGER;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 252
;252:	if ( !self->goal_state )
ADDRGP4 self
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 0
NEI4 $99
line 253
;253:		self->goal_state = TFGS_INACTIVE;
ADDRGP4 self
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
LABELV $99
line 254
;254:	if ( VectorCompareF( self->goal_min, 0, 0, 0 ) )
ADDRGP4 self
INDIRP4
CNSTI4 1204
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
EQI4 $101
line 255
;255:		SetVector( self->goal_min, -16, -16, -24 );
ADDRGP4 self
INDIRP4
CNSTI4 1204
ADDP4
CNSTF4 3246391296
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1208
ADDP4
CNSTF4 3246391296
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1212
ADDP4
CNSTF4 3250585600
ASGNF4
LABELV $101
line 256
;256:	if ( VectorCompareF( self->goal_max, 0, 0, 0 ) )
ADDRGP4 self
INDIRP4
CNSTI4 1216
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
EQI4 $103
line 257
;257:		SetVector( self->goal_max, 16, 16, 32 );
ADDRGP4 self
INDIRP4
CNSTI4 1216
ADDP4
CNSTF4 1098907648
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1220
ADDP4
CNSTF4 1098907648
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1224
ADDP4
CNSTF4 1107296256
ASGNF4
LABELV $103
line 258
;258:	setsize( self, PASSVEC3( self->goal_min ), PASSVEC3( self->goal_max ) );
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 1204
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 1208
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 1212
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 1216
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 1220
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 1224
ADDP4
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 259
;259:	TF_StartGoal(  );
ADDRGP4 TF_StartGoal
CALLV
pop
line 260
;260:}
LABELV $81
endproc SP_info_tfgoal 24 28
export SP_i_t_g
proc SP_i_t_g 0 0
line 263
;261:
;262:void SP_i_t_g(  )
;263:{
line 264
;264:	self->s.v.classname = "info_tfgoal";
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $49
ASGNP4
line 265
;265:	SP_info_tfgoal(  );
ADDRGP4 SP_info_tfgoal
CALLV
pop
line 266
;266:}
LABELV $105
endproc SP_i_t_g 0 0
export SP_info_tfgoal_timer
proc SP_info_tfgoal_timer 24 28
line 269
;267:
;268:void SP_info_tfgoal_timer(  )
;269:{
line 270
;270:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $107
line 271
;271:	{
line 272
;272:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 273
;273:		return;
ADDRGP4 $106
JUMPV
LABELV $107
line 275
;274:	}
;275:	if ( self->mdl )
ADDRGP4 self
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $109
line 276
;276:	{
line 277
;277:		trap_precache_model( self->mdl );
ADDRGP4 self
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 278
;278:		setmodel( self, self->mdl );
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 279
;279:	}
LABELV $109
line 280
;280:	if ( self->s.v.noise )
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $111
line 281
;281:	{
line 282
;282:		trap_precache_sound( self->s.v.noise );
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 283
;283:	}
LABELV $111
line 284
;284:	if ( self->search_time <= 0 )
ADDRGP4 self
INDIRP4
CNSTI4 1108
ADDP4
INDIRF4
CNSTF4 0
GTF4 $113
line 285
;285:	{
line 286
;286:		G_dprintf( "Timer Goal created with no specified time.\n" );
ADDRGP4 $115
ARGP4
ADDRGP4 G_dprintf
CALLV
pop
line 287
;287:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 288
;288:	}
LABELV $113
line 289
;289:	self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 290
;290:	if ( !self->goal_state )
ADDRGP4 self
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 0
NEI4 $116
line 291
;291:		self->goal_state = TFGS_INACTIVE;
ADDRGP4 self
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
LABELV $116
line 292
;292:	if ( VectorCompareF( self->goal_min, 0, 0, 0 ) )
ADDRGP4 self
INDIRP4
CNSTI4 1204
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
EQI4 $118
line 293
;293:		SetVector( self->goal_min, -16, -16, -24 );
ADDRGP4 self
INDIRP4
CNSTI4 1204
ADDP4
CNSTF4 3246391296
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1208
ADDP4
CNSTF4 3246391296
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1212
ADDP4
CNSTF4 3250585600
ASGNF4
LABELV $118
line 294
;294:	if ( VectorCompareF( self->goal_max, 0, 0, 0 ) )
ADDRGP4 self
INDIRP4
CNSTI4 1216
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
EQI4 $120
line 295
;295:		SetVector( self->goal_max, 16, 16, 32 );
ADDRGP4 self
INDIRP4
CNSTI4 1216
ADDP4
CNSTF4 1098907648
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1220
ADDP4
CNSTF4 1098907648
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1224
ADDP4
CNSTF4 1107296256
ASGNF4
LABELV $120
line 296
;296:	setsize( self, PASSVEC3( self->goal_min ), PASSVEC3( self->goal_max ) );
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 1204
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 1208
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 1212
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 1216
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 1220
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 1224
ADDP4
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 297
;297:	TF_StartGoal(  );
ADDRGP4 TF_StartGoal
CALLV
pop
line 298
;298:}
LABELV $106
endproc SP_info_tfgoal_timer 24 28
export SP_i_t_t
proc SP_i_t_t 0 0
line 301
;299:
;300:void SP_i_t_t(  )
;301:{
line 302
;302:	self->s.v.classname = "info_tfgoal_timer";
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $45
ASGNP4
line 303
;303:	SP_info_tfgoal_timer(  );
ADDRGP4 SP_info_tfgoal_timer
CALLV
pop
line 304
;304:}
LABELV $122
endproc SP_i_t_t 0 0
export SP_item_tfgoal
proc SP_item_tfgoal 40 28
line 307
;305:
;306:void SP_item_tfgoal(  )
;307:{
line 308
;308:	if ( !CheckExistence(  ) )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $124
line 309
;309:	{
line 310
;310:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 311
;311:		return;
ADDRGP4 $123
JUMPV
LABELV $124
line 313
;312:	}
;313:	if ( self->mdl )
ADDRGP4 self
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $126
line 314
;314:	{
line 315
;315:		trap_precache_model( self->mdl );
ADDRGP4 self
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_precache_model
CALLV
pop
line 316
;316:		setmodel( self, self->mdl );
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 317
;317:	} else
ADDRGP4 $127
JUMPV
LABELV $126
line 318
;318:	{
line 319
;319:		self->mdl = "";
ADDRGP4 self
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $128
ASGNP4
line 320
;320:		setmodel( self, "" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $128
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 321
;321:	}
LABELV $127
line 322
;322:	trap_precache_sound( "items/itembk2.wav" );
ADDRGP4 $129
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 323
;323:	if ( self->s.v.noise )
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $130
line 324
;324:	{
line 325
;325:		trap_precache_sound( self->s.v.noise );
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 326
;326:	}
LABELV $130
line 327
;327:	self->s.v.touch = ( func_t ) item_tfgoal_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 item_tfgoal_touch
CVPU4 4
CVUI4 4
ASGNI4
line 328
;328:	if ( !self->goal_state )
ADDRGP4 self
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 0
NEI4 $132
line 329
;329:		self->goal_state = TFGS_INACTIVE;
ADDRGP4 self
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
LABELV $132
line 330
;330:	if ( self->goal_activation & TFGI_SOLID )
ADDRGP4 self
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $134
line 331
;331:		self->s.v.solid = SOLID_BBOX;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
ADDRGP4 $135
JUMPV
LABELV $134
line 333
;332:	else
;333:		self->s.v.solid = SOLID_TRIGGER;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $135
line 334
;334:	setorigin( self, PASSVEC3( self->s.v.origin ) );
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
line 335
;335:	if ( !self->s.v.netname )
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $136
line 336
;336:		self->s.v.netname = "goalitem";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $138
ASGNP4
LABELV $136
line 337
;337:	if ( self->pausetime <= 0 )
ADDRGP4 self
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
CNSTF4 0
GTF4 $139
line 338
;338:		self->pausetime = 60;
ADDRGP4 self
INDIRP4
CNSTI4 676
ADDP4
CNSTF4 1114636288
ASGNF4
LABELV $139
line 339
;339:	if ( self->delay && !self->pausetime )
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 664
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
EQF4 $141
ADDRLP4 8
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
NEF4 $141
line 340
;340:		self->pausetime = self->delay;
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 676
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 664
ADDP4
INDIRF4
ASGNF4
LABELV $141
line 341
;341:	if ( VectorCompareF( self->goal_min, 0, 0, 0 ) )
ADDRGP4 self
INDIRP4
CNSTI4 1204
ADDP4
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
ADDRLP4 24
ADDRGP4 VectorCompareF
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $143
line 342
;342:		SetVector( self->goal_min, -16, -16, -24 );
ADDRGP4 self
INDIRP4
CNSTI4 1204
ADDP4
CNSTF4 3246391296
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1208
ADDP4
CNSTF4 3246391296
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1212
ADDP4
CNSTF4 3250585600
ASGNF4
LABELV $143
line 343
;343:	if ( VectorCompareF( self->goal_max, 0, 0, 0 ) )
ADDRGP4 self
INDIRP4
CNSTI4 1216
ADDP4
ARGP4
ADDRLP4 28
CNSTF4 0
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
ADDRGP4 VectorCompareF
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $145
line 344
;344:		SetVector( self->goal_max, 16, 16, 32 );
ADDRGP4 self
INDIRP4
CNSTI4 1216
ADDP4
CNSTF4 1098907648
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1220
ADDP4
CNSTF4 1098907648
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1224
ADDP4
CNSTF4 1107296256
ASGNF4
LABELV $145
line 345
;345:	setsize( self, PASSVEC3( self->goal_min ), PASSVEC3( self->goal_max ) );
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 1204
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 1208
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 1212
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 1216
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 1220
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 1224
ADDP4
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 346
;346:	TF_StartItem(  );
ADDRGP4 TF_StartItem
CALLV
pop
line 347
;347:}
LABELV $123
endproc SP_item_tfgoal 40 28
export ParseTFDetect
proc ParseTFDetect 4 8
line 350
;348:
;349:void ParseTFDetect( gedict_t * AD )
;350:{
line 351
;351:	if ( AD->team_broadcast )
ADDRFP4 0
INDIRP4
CNSTI4 1336
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $148
line 352
;352:		team_menu_string = AD->team_broadcast;
ADDRGP4 team_menu_string
ADDRFP4 0
INDIRP4
CNSTI4 1336
ADDP4
INDIRP4
ASGNP4
LABELV $148
line 353
;353:	if ( AD->s.v.message )
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $150
line 354
;354:		localcmd( AD->s.v.message );
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRP4
ARGP4
ADDRGP4 localcmd
CALLV
pop
LABELV $150
line 355
;355:	trap_cvar_set( "sv_maxspeed", "500" );
ADDRGP4 $152
ARGP4
ADDRGP4 $153
ARGP4
ADDRGP4 trap_cvar_set
CALLV
pop
line 358
;356:
;357:	// megatf serverinfo setter
;358:	localcmd("serverinfo ");
ADDRGP4 $154
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 359
;359:	localcmd(MEGATF_VERSION);
ADDRGP4 $155
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 361
;360:
;361:	teamlives[1] = AD->s.v.ammo_shells;
ADDRGP4 teamlives+4
ADDRFP4 0
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 362
;362:	teamlives[2] = AD->s.v.ammo_nails;
ADDRGP4 teamlives+8
ADDRFP4 0
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 363
;363:	teamlives[3] = AD->s.v.ammo_rockets;
ADDRGP4 teamlives+12
ADDRFP4 0
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 364
;364:	teamlives[4] = AD->s.v.ammo_cells;
ADDRGP4 teamlives+16
ADDRFP4 0
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 366
;365:
;366:	if ( !teamlives[1] )
ADDRGP4 teamlives+4
INDIRI4
CNSTI4 0
NEI4 $160
line 367
;367:		teamlives[1] = -1;
ADDRGP4 teamlives+4
CNSTI4 -1
ASGNI4
LABELV $160
line 368
;368:	if ( !teamlives[2] )
ADDRGP4 teamlives+8
INDIRI4
CNSTI4 0
NEI4 $164
line 369
;369:		teamlives[2] = -1;
ADDRGP4 teamlives+8
CNSTI4 -1
ASGNI4
LABELV $164
line 370
;370:	if ( !teamlives[3] )
ADDRGP4 teamlives+12
INDIRI4
CNSTI4 0
NEI4 $168
line 371
;371:		teamlives[3] = -1;
ADDRGP4 teamlives+12
CNSTI4 -1
ASGNI4
LABELV $168
line 372
;372:	if ( !teamlives[4] )
ADDRGP4 teamlives+16
INDIRI4
CNSTI4 0
NEI4 $172
line 373
;373:		teamlives[4] = -1;
ADDRGP4 teamlives+16
CNSTI4 -1
ASGNI4
LABELV $172
line 374
;374:	if ( AD->hook_out == 1 )
ADDRFP4 0
INDIRP4
CNSTI4 1436
ADDP4
INDIRI4
CNSTI4 1
NEI4 $176
line 375
;375:		tf_data.allow_hook = 0;
ADDRGP4 tf_data+64
CNSTI4 0
ASGNI4
LABELV $176
line 376
;376:	teammaxplayers[1] = AD->ammo_medikit;
ADDRGP4 teammaxplayers+4
ADDRFP4 0
INDIRP4
CNSTI4 1044
ADDP4
INDIRI4
ASGNI4
line 377
;377:	teammaxplayers[2] = AD->ammo_detpack;
ADDRGP4 teammaxplayers+8
ADDRFP4 0
INDIRP4
CNSTI4 1052
ADDP4
INDIRI4
ASGNI4
line 378
;378:	teammaxplayers[3] = AD->maxammo_medikit;
ADDRGP4 teammaxplayers+12
ADDRFP4 0
INDIRP4
CNSTI4 1048
ADDP4
INDIRI4
ASGNI4
line 379
;379:	teammaxplayers[4] = AD->maxammo_detpack;
ADDRGP4 teammaxplayers+16
ADDRFP4 0
INDIRP4
CNSTI4 1056
ADDP4
INDIRI4
ASGNI4
line 380
;380:	if ( !teammaxplayers[1] )
ADDRGP4 teammaxplayers+4
INDIRI4
CNSTI4 0
NEI4 $183
line 381
;381:		teammaxplayers[1] = 100;
ADDRGP4 teammaxplayers+4
CNSTI4 100
ASGNI4
LABELV $183
line 382
;382:	if ( !teammaxplayers[2] )
ADDRGP4 teammaxplayers+8
INDIRI4
CNSTI4 0
NEI4 $187
line 383
;383:		teammaxplayers[2] = 100;
ADDRGP4 teammaxplayers+8
CNSTI4 100
ASGNI4
LABELV $187
line 384
;384:	if ( !teammaxplayers[3] )
ADDRGP4 teammaxplayers+12
INDIRI4
CNSTI4 0
NEI4 $191
line 385
;385:		teammaxplayers[3] = 100;
ADDRGP4 teammaxplayers+12
CNSTI4 100
ASGNI4
LABELV $191
line 386
;386:	if ( !teammaxplayers[4] )
ADDRGP4 teammaxplayers+16
INDIRI4
CNSTI4 0
NEI4 $195
line 387
;387:		teammaxplayers[4] = 100;
ADDRGP4 teammaxplayers+16
CNSTI4 100
ASGNI4
LABELV $195
line 389
;388:
;389:	illegalclasses[0] = AD->playerclass;
ADDRGP4 illegalclasses
ADDRFP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
line 390
;390:	illegalclasses[1] = AD->maxammo_shells;
ADDRGP4 illegalclasses+4
ADDRFP4 0
INDIRP4
CNSTI4 904
ADDP4
INDIRI4
ASGNI4
line 391
;391:	illegalclasses[2] = AD->maxammo_nails;
ADDRGP4 illegalclasses+8
ADDRFP4 0
INDIRP4
CNSTI4 908
ADDP4
INDIRI4
ASGNI4
line 392
;392:	illegalclasses[3] = AD->maxammo_rockets;
ADDRGP4 illegalclasses+12
ADDRFP4 0
INDIRP4
CNSTI4 916
ADDP4
INDIRI4
ASGNI4
line 393
;393:	illegalclasses[4] = AD->maxammo_cells;
ADDRGP4 illegalclasses+16
ADDRFP4 0
INDIRP4
CNSTI4 912
ADDP4
INDIRI4
ASGNI4
line 394
;394:	civilianteams = 0;
ADDRGP4 civilianteams
CNSTI4 0
ASGNI4
line 395
;395:	if ( illegalclasses[1] == -1 )
ADDRGP4 illegalclasses+4
INDIRI4
CNSTI4 -1
NEI4 $203
line 396
;396:	{
line 397
;397:		illegalclasses[1] = 0;
ADDRGP4 illegalclasses+4
CNSTI4 0
ASGNI4
line 398
;398:		civilianteams = civilianteams | 1;
ADDRLP4 0
ADDRGP4 civilianteams
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 399
;399:	}
LABELV $203
line 400
;400:	if ( illegalclasses[2] == -1 )
ADDRGP4 illegalclasses+8
INDIRI4
CNSTI4 -1
NEI4 $207
line 401
;401:	{
line 402
;402:		illegalclasses[2] = 0;
ADDRGP4 illegalclasses+8
CNSTI4 0
ASGNI4
line 403
;403:		civilianteams = civilianteams | 2;
ADDRLP4 0
ADDRGP4 civilianteams
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 404
;404:	}
LABELV $207
line 405
;405:	if ( illegalclasses[3] == -1 )
ADDRGP4 illegalclasses+12
INDIRI4
CNSTI4 -1
NEI4 $211
line 406
;406:	{
line 407
;407:		illegalclasses[3] = 0;
ADDRGP4 illegalclasses+12
CNSTI4 0
ASGNI4
line 408
;408:		civilianteams = civilianteams | 4;
ADDRLP4 0
ADDRGP4 civilianteams
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 409
;409:	}
LABELV $211
line 410
;410:	if ( illegalclasses[4] == -1 )
ADDRGP4 illegalclasses+16
INDIRI4
CNSTI4 -1
NEI4 $215
line 411
;411:	{
line 412
;412:		illegalclasses[4] = 0;
ADDRGP4 illegalclasses+16
CNSTI4 0
ASGNI4
line 413
;413:		civilianteams = civilianteams | 8;
ADDRLP4 0
ADDRGP4 civilianteams
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 414
;414:	}
LABELV $215
line 416
;415:
;416:	teams_allied = AD->team_no;
ADDRGP4 teams_allied
ADDRFP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
line 417
;417:}
LABELV $147
endproc ParseTFDetect 4 8
export Finditem
proc Finditem 12 12
line 420
;418:
;419:gedict_t *Finditem( int ino )
;420:{
line 423
;421:	gedict_t *tg;
;422:
;423:	tg = trap_find( world, FOFS( s.v.classname ), "item_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 4
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRGP4 $222
JUMPV
LABELV $221
line 425
;424:	while ( tg )
;425:	{
line 426
;426:		if ( tg->goal_no == ino )
ADDRLP4 0
INDIRP4
CNSTI4 1112
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $224
line 427
;427:			return tg;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $219
JUMPV
LABELV $224
line 428
;428:		tg = trap_find( tg, FOFS( s.v.classname ), "item_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 429
;429:	}
LABELV $222
line 424
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $221
line 430
;430:	G_dprintf( "Could not find an item with a goal_no of %d.\n", ino );
ADDRGP4 $226
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_dprintf
CALLV
pop
line 431
;431:	return world;
ADDRGP4 world
INDIRP4
RETP4
LABELV $219
endproc Finditem 12 12
export Findgoal
proc Findgoal 12 12
line 435
;432:}
;433:
;434:gedict_t *Findgoal( int gno )
;435:{
line 438
;436:	gedict_t *tg;
;437:
;438:	tg = trap_find( world, FOFS( s.v.classname ), "info_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 4
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRGP4 $229
JUMPV
LABELV $228
line 440
;439:	while ( tg )
;440:	{
line 441
;441:		if ( tg->goal_no == gno )
ADDRLP4 0
INDIRP4
CNSTI4 1112
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $231
line 442
;442:			return tg;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $227
JUMPV
LABELV $231
line 443
;443:		tg = trap_find( tg, FOFS( s.v.classname ), "info_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 444
;444:	}
LABELV $229
line 439
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $228
line 445
;445:	G_dprintf( "Could not find a goal with a goal_no of %d.\n", gno );
ADDRGP4 $233
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_dprintf
CALLV
pop
line 446
;446:	return NULL;
CNSTP4 0
RETP4
LABELV $227
endproc Findgoal 12 12
export Findteamspawn
proc Findteamspawn 12 12
line 450
;447:}
;448:
;449:gedict_t *Findteamspawn( int gno )
;450:{
line 453
;451:	gedict_t *tg;
;452:
;453:	tg = trap_find( world, FOFS( s.v.classname ), "info_player_teamspawn" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $80
ARGP4
ADDRLP4 4
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRGP4 $236
JUMPV
LABELV $235
line 455
;454:	while ( tg )
;455:	{
line 456
;456:		if ( tg->goal_no == gno )
ADDRLP4 0
INDIRP4
CNSTI4 1112
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $238
line 457
;457:			return tg;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $234
JUMPV
LABELV $238
line 458
;458:		tg = trap_find( tg, FOFS( s.v.classname ), "info_player_teamspawn" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $80
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 459
;459:	}
LABELV $236
line 454
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $235
line 460
;460:	G_dprintf( "Could not find a Teamspawn with a goal_no of %d.\n", gno );
ADDRGP4 $240
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_dprintf
CALLV
pop
line 461
;461:	return NULL;
CNSTP4 0
RETP4
LABELV $234
endproc Findteamspawn 12 12
export InactivateGoal
proc InactivateGoal 8 8
line 465
;462:}
;463:
;464:void InactivateGoal( gedict_t * Goal )
;465:{
line 466
;466:	if ( Goal->goal_state == TFGS_ACTIVE )
ADDRFP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 1
NEI4 $242
line 467
;467:	{
line 468
;468:		if ( !Goal->search_time )
ADDRFP4 0
INDIRP4
CNSTI4 1108
ADDP4
INDIRF4
CNSTF4 0
NEF4 $244
line 469
;469:		{
line 470
;470:			if ( ( Goal->goal_activation & TFGI_SOLID ) && streq( Goal->s.v.classname, "item_tfgoal" ) )
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $246
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $220
ARGP4
ADDRLP4 4
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $246
line 471
;471:				Goal->s.v.solid = SOLID_BBOX;
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
ADDRGP4 $247
JUMPV
LABELV $246
line 473
;472:			else
;473:				Goal->s.v.solid = SOLID_TRIGGER;
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $247
line 474
;474:		}
LABELV $244
line 475
;475:		Goal->goal_state = TFGS_INACTIVE;
ADDRFP4 0
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
line 476
;476:		if ( Goal->mdl )
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $248
line 477
;477:			setmodel( Goal, Goal->mdl );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
LABELV $248
line 478
;478:	}
LABELV $242
line 479
;479:}
LABELV $241
endproc InactivateGoal 8 8
export RestoreGoal
proc RestoreGoal 8 8
line 482
;480:
;481:void RestoreGoal( gedict_t * Goal )
;482:{
line 483
;483:	if ( Goal->goal_state == TFGS_REMOVED )
ADDRFP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 3
NEI4 $251
line 484
;484:	{
line 485
;485:		if ( !Goal->search_time )
ADDRFP4 0
INDIRP4
CNSTI4 1108
ADDP4
INDIRF4
CNSTF4 0
NEF4 $253
line 486
;486:		{
line 487
;487:			if ( ( Goal->goal_activation & TFGI_SOLID ) && streq( Goal->s.v.classname, "item_tfgoal" ) )
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $255
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $220
ARGP4
ADDRLP4 4
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $255
line 488
;488:				Goal->s.v.solid = SOLID_BBOX;
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
ADDRGP4 $254
JUMPV
LABELV $255
line 490
;489:			else
;490:				Goal->s.v.solid = SOLID_TRIGGER;
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 491
;491:		} else
ADDRGP4 $254
JUMPV
LABELV $253
line 492
;492:			Goal->s.v.nextthink = g_globalvars.time + Goal->search_time;
ADDRLP4 0
ADDRFP4 0
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
CNSTI4 1108
ADDP4
INDIRF4
ADDF4
ASGNF4
LABELV $254
line 493
;493:		Goal->goal_state = TFGS_INACTIVE;
ADDRFP4 0
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
line 494
;494:		if ( Goal->mdl )
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $258
line 495
;495:			setmodel( Goal, Goal->mdl );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
LABELV $258
line 496
;496:	}
LABELV $251
line 497
;497:}
LABELV $250
endproc RestoreGoal 8 8
export RemoveGoal
proc RemoveGoal 0 8
line 500
;498:
;499:void RemoveGoal( gedict_t * Goal )
;500:{
line 501
;501:	Goal->s.v.solid = SOLID_NOT;
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 502
;502:	Goal->goal_state = TFGS_REMOVED;
ADDRFP4 0
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 3
ASGNI4
line 503
;503:	if ( Goal->mdl )
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $261
line 504
;504:		setmodel( Goal, "" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $128
ARGP4
ADDRGP4 setmodel
CALLV
pop
LABELV $261
line 505
;505:}
LABELV $260
endproc RemoveGoal 0 8
export IsAffectedBy
proc IsAffectedBy 40 32
line 508
;506:
;507:int IsAffectedBy( gedict_t * Goal, gedict_t * Player, gedict_t * AP )
;508:{
line 512
;509:	float   genv;
;510:	vec3_t  tmp;
;511:
;512:	if ( !Player->playerclass )
ADDRFP4 4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $264
line 513
;513:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $263
JUMPV
LABELV $264
line 514
;514:	if ( Goal->goal_effects & TFGE_SAME_ENVIRONMENT )
ADDRFP4 0
INDIRP4
CNSTI4 1132
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $266
line 515
;515:	{
line 516
;516:		genv = trap_pointcontents( PASSVEC3( Goal->s.v.origin ) );
ADDRLP4 16
ADDRFP4 0
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
ADDRLP4 12
ADDRLP4 20
INDIRI4
CVIF4 4
ASGNF4
line 517
;517:		if ( trap_pointcontents( PASSVEC3( Player->s.v.origin ) ) != genv )
ADDRLP4 24
ADDRFP4 4
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
ADDRLP4 28
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
EQF4 $268
line 518
;518:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $263
JUMPV
LABELV $268
line 519
;519:	}
LABELV $266
line 520
;520:	if ( Goal->t_length )
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRF4
CNSTF4 0
EQF4 $270
line 521
;521:	{
line 522
;522:		VectorSubtract( Goal->s.v.origin, Player->s.v.origin, tmp );
ADDRLP4 16
CNSTI4 156
ASGNI4
ADDRLP4 0
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20
CNSTI4 160
ASGNI4
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24
CNSTI4 164
ASGNI4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 523
;523:		if ( vlen( tmp ) <= Goal->t_length )
ADDRLP4 0
ARGP4
ADDRLP4 16
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 16
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRF4
GTF4 $274
line 524
;524:		{
line 525
;525:			if ( Goal->goal_effects & TFGE_WALL )
ADDRFP4 0
INDIRP4
CNSTI4 1132
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $276
line 526
;526:			{
line 527
;527:				traceline( PASSVEC3( Goal->s.v.origin ), PASSVEC3( Player->s.v.origin ), 1, Goal );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
CNSTI4 156
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
CNSTI4 160
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
CNSTI4 164
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 528
;528:				if ( g_globalvars.trace_fraction == 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
NEF4 $277
line 529
;529:					return 1;
CNSTI4 1
RETI4
ADDRGP4 $263
JUMPV
line 530
;530:			} else
LABELV $276
line 531
;531:				return 1;
CNSTI4 1
RETI4
ADDRGP4 $263
JUMPV
LABELV $277
line 532
;532:		}
LABELV $274
line 533
;533:	}
LABELV $270
line 534
;534:	if ( strneq( Goal->s.v.classname, "info_tfgoal_timer" ) )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $45
ARGP4
ADDRLP4 16
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $281
line 535
;535:	{
line 536
;536:		if ( ( Goal->goal_effects & TFGE_AP ) && Player == AP )
ADDRFP4 0
INDIRP4
CNSTI4 1132
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $283
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
NEU4 $283
line 537
;537:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $263
JUMPV
LABELV $283
line 538
;538:		if ( ( Goal->goal_effects & TFGE_AP_TEAM ) && AP->team_no == Player->team_no )
ADDRFP4 0
INDIRP4
CNSTI4 1132
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $285
ADDRLP4 20
CNSTI4 960
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
NEI4 $285
line 539
;539:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $263
JUMPV
LABELV $285
line 540
;540:		if ( ( Goal->goal_effects & TFGE_NOT_AP_TEAM ) && AP->team_no != Player->team_no )
ADDRFP4 0
INDIRP4
CNSTI4 1132
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $287
ADDRLP4 24
CNSTI4 960
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
EQI4 $287
line 541
;541:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $263
JUMPV
LABELV $287
line 542
;542:		if ( ( Goal->goal_effects & TFGE_NOT_AP ) && Player != AP )
ADDRFP4 0
INDIRP4
CNSTI4 1132
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $289
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
EQU4 $289
line 543
;543:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $263
JUMPV
LABELV $289
line 544
;544:	}
LABELV $281
line 545
;545:	if ( Goal->maxammo_shells && Player->team_no == Goal->maxammo_shells )
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 904
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $291
ADDRFP4 4
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
NEI4 $291
line 546
;546:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $263
JUMPV
LABELV $291
line 547
;547:	if ( Goal->maxammo_nails && Player->team_no != Goal->maxammo_shells )
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 908
ADDP4
INDIRI4
CNSTI4 0
EQI4 $293
ADDRFP4 4
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 904
ADDP4
INDIRI4
EQI4 $293
line 548
;548:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $263
JUMPV
LABELV $293
line 549
;549:	return 0;
CNSTI4 0
RETI4
LABELV $263
endproc IsAffectedBy 40 32
export Apply_Results
proc Apply_Results 124 24
line 553
;550:}
;551:
;552:void Apply_Results( gedict_t * Goal, gedict_t * Player, gedict_t * AP, float addb )
;553:{
line 559
;554:	gedict_t *oldself;
;555:	gedict_t *te;
;556:	gedict_t *oldte;
;557:
;558://      float   tc;
;559:	stuffcmd( Player, "bf\n" );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $296
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 560
;560:	if ( streq( Goal->s.v.classname, "item_tfgoal" ) )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $220
ARGP4
ADDRLP4 12
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $297
line 561
;561:		Player->item_list = Player->item_list | Goal->item_list;
ADDRLP4 16
CNSTI4 1384
ASGNI4
ADDRLP4 20
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
BORI4
ASGNI4
LABELV $297
line 562
;562:	if ( Player == AP )
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
NEU4 $299
line 563
;563:	{
line 564
;564:		if ( Goal->count > 0 )
ADDRFP4 0
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
CNSTF4 0
LEF4 $301
line 565
;565:		{
line 566
;566:			if ( Player->team_no > 0 )
ADDRFP4 4
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 0
LEI4 $303
line 567
;567:			{
line 568
;568:				TeamFortress_TeamIncreaseScore( Player->team_no, Goal->count );
ADDRFP4 4
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 TeamFortress_TeamIncreaseScore
CALLV
pop
line 569
;569:				TeamFortress_TeamShowScores( 2 );
CNSTI4 2
ARGI4
ADDRGP4 TeamFortress_TeamShowScores
CALLV
pop
line 570
;570:			}
LABELV $303
line 571
;571:		}
LABELV $301
line 572
;572:	}
LABELV $299
line 573
;573:	if ( addb )
ADDRFP4 12
INDIRF4
CNSTF4 0
EQF4 $305
line 574
;574:	{
line 575
;575:		if ( Player->s.v.health > 0 )
ADDRFP4 4
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $307
line 576
;576:		{
line 577
;577:			if ( Goal->s.v.health > 0 )
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $309
line 578
;578:				T_Heal( Player, Goal->s.v.health, 0 );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 T_Heal
CALLI4
pop
LABELV $309
line 579
;579:			if ( Goal->s.v.health < 0 )
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GEF4 $311
line 580
;580:			{
line 581
;581:				if ( 0 - Player->s.v.health > Goal->s.v.health )
ADDRLP4 24
CNSTI4 296
ASGNI4
CNSTF4 0
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
SUBF4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
LEF4 $313
line 582
;582:					TF_T_Damage( Player, Goal, Goal, Player->s.v.health + 1, 1, 0 );
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
ADDRGP4 $314
JUMPV
LABELV $313
line 584
;583:				else
;584:					TF_T_Damage( Player, Goal, Goal, 0 - Goal->s.v.health, 1, 0 );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
CNSTF4 0
ADDRLP4 36
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
SUBF4
ARGF4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
LABELV $314
line 585
;585:			}
LABELV $311
line 586
;586:		}
LABELV $307
line 587
;587:		if ( Player->s.v.health > 0 )
ADDRFP4 4
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $315
line 588
;588:		{
line 589
;589:			if ( Goal->s.v.armortype > 0 )
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRF4
CNSTF4 0
LEF4 $317
line 590
;590:				Player->s.v.armortype = Goal->s.v.armortype;
ADDRLP4 24
CNSTI4 424
ASGNI4
ADDRFP4 4
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
ASGNF4
ADDRGP4 $318
JUMPV
LABELV $317
line 592
;591:			else
;592:			{
line 593
;593:				if ( Goal->s.v.armorvalue > 0 )
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
CNSTF4 0
LEF4 $319
line 594
;594:					Player->s.v.armortype = Player->armor_allowed;
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 424
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 924
ADDP4
INDIRF4
ASGNF4
LABELV $319
line 595
;595:			}
LABELV $318
line 597
;596:
;597:			Player->s.v.armorvalue = Player->s.v.armorvalue + Goal->s.v.armorvalue;
ADDRLP4 28
CNSTI4 428
ASGNI4
ADDRLP4 32
ADDRFP4 4
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
ADDRFP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 598
;598:			if ( Goal->armorclass > 0 )
ADDRFP4 0
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
CNSTI4 0
LEI4 $321
line 599
;599:				Player->armorclass = Goal->armorclass;
ADDRLP4 36
CNSTI4 828
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
ASGNI4
LABELV $321
line 600
;600:			Player->s.v.ammo_shells = Player->s.v.ammo_shells + Goal->s.v.ammo_shells;
ADDRLP4 40
CNSTI4 320
ASGNI4
ADDRLP4 44
ADDRFP4 4
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 601
;601:			Player->s.v.ammo_nails = Player->s.v.ammo_nails + Goal->s.v.ammo_nails;
ADDRLP4 48
CNSTI4 324
ASGNI4
ADDRLP4 52
ADDRFP4 4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 602
;602:			Player->s.v.ammo_rockets = Player->s.v.ammo_rockets + Goal->s.v.ammo_rockets;
ADDRLP4 56
CNSTI4 328
ASGNI4
ADDRLP4 60
ADDRFP4 4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 603
;603:			Player->s.v.ammo_cells = Player->s.v.ammo_cells + Goal->s.v.ammo_cells;
ADDRLP4 64
CNSTI4 332
ASGNI4
ADDRLP4 68
ADDRFP4 4
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 604
;604:			Player->ammo_medikit = Player->ammo_medikit + Goal->ammo_medikit;
ADDRLP4 72
CNSTI4 1044
ASGNI4
ADDRLP4 76
ADDRFP4 4
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRI4
ADDI4
ASGNI4
line 605
;605:			Player->ammo_detpack = Player->ammo_detpack + Goal->ammo_detpack;
ADDRLP4 80
CNSTI4 1052
ASGNI4
ADDRLP4 84
ADDRFP4 4
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRI4
ADDI4
ASGNI4
line 606
;606:			Player->no_grenades_1 = Player->no_grenades_1 + Goal->no_grenades_1;
ADDRLP4 88
CNSTI4 840
ASGNI4
ADDRLP4 92
ADDRFP4 4
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRI4
ADDI4
ASGNI4
line 607
;607:			Player->no_grenades_2 = Player->no_grenades_2 + Goal->no_grenades_2;
ADDRLP4 96
CNSTI4 844
ASGNI4
ADDRLP4 100
ADDRFP4 4
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRI4
ADDI4
ASGNI4
line 608
;608:			bound_other_ammo( Player );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 bound_other_ammo
CALLV
pop
line 609
;609:			if ( Player->tfstate & TFSTATE_GRENPRIMED )
ADDRFP4 4
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $323
line 610
;610:			{
line 611
;611:				te = trap_find( world, FOFS( s.v.classname ), "primer" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $325
ARGP4
ADDRLP4 104
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 104
INDIRP4
ASGNP4
ADDRGP4 $327
JUMPV
LABELV $326
line 613
;612:				while ( te )
;613:				{
line 614
;614:					if ( te->s.v.owner == EDICT_TO_PROG( Player ) )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
NEI4 $329
line 615
;615:					{
line 616
;616:						if ( te->s.v.impulse == 151 && Goal->no_grenades_2 < 0 )
ADDRLP4 0
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1125580800
NEF4 $331
ADDRFP4 0
INDIRP4
CNSTI4 844
ADDP4
INDIRI4
CNSTI4 0
GEI4 $331
line 617
;617:						{
line 618
;618:							Player->tfstate =
ADDRLP4 108
ADDRFP4 4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 112
ADDRLP4 108
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 108
INDIRP4
ADDRLP4 112
INDIRI4
ADDRLP4 112
INDIRI4
CNSTI4 1
BANDI4
SUBI4
ASGNI4
line 620
;619:							    Player->tfstate - ( Player->tfstate & TFSTATE_GRENPRIMED );
;620:							Player->tfstate =
ADDRLP4 116
ADDRFP4 4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 120
ADDRLP4 116
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 116
INDIRP4
ADDRLP4 120
INDIRI4
ADDRLP4 120
INDIRI4
CNSTI4 1024
BANDI4
SUBI4
ASGNI4
line 623
;621:							    Player->tfstate -
;622:							    ( Player->tfstate & TFSTATE_GRENTHROWING );
;623:							dremove( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 624
;624:						} else
ADDRGP4 $332
JUMPV
LABELV $331
line 625
;625:						{
line 626
;626:							if ( te->s.v.impulse == 150 && Goal->no_grenades_1 < 0 )
ADDRLP4 0
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1125515264
NEF4 $333
ADDRFP4 0
INDIRP4
CNSTI4 840
ADDP4
INDIRI4
CNSTI4 0
GEI4 $333
line 627
;627:							{
line 628
;628:								Player->tfstate =
ADDRLP4 108
ADDRFP4 4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 112
ADDRLP4 108
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 108
INDIRP4
ADDRLP4 112
INDIRI4
ADDRLP4 112
INDIRI4
CNSTI4 1
BANDI4
SUBI4
ASGNI4
line 631
;629:								    Player->tfstate -
;630:								    ( Player->tfstate & TFSTATE_GRENPRIMED );
;631:								Player->tfstate =
ADDRLP4 116
ADDRFP4 4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 120
ADDRLP4 116
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 116
INDIRP4
ADDRLP4 120
INDIRI4
ADDRLP4 120
INDIRI4
CNSTI4 1024
BANDI4
SUBI4
ASGNI4
line 634
;632:								    Player->tfstate -
;633:								    ( Player->tfstate & TFSTATE_GRENTHROWING );
;634:								dremove( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 635
;635:							}
LABELV $333
line 636
;636:						}
LABELV $332
line 637
;637:						te = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 638
;638:					} else
ADDRGP4 $330
JUMPV
LABELV $329
line 639
;639:						te = trap_find( te, FOFS( s.v.classname ), "primer" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $325
ARGP4
ADDRLP4 108
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 108
INDIRP4
ASGNP4
LABELV $330
line 640
;640:				}
LABELV $327
line 612
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $326
line 641
;641:			}
LABELV $323
line 642
;642:			if ( !tf_data.disable_powerups && ( Goal->invincible_finished > 0 ) )
ADDRGP4 tf_data+160
INDIRI4
CNSTI4 0
NEI4 $335
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
CNSTF4 0
LEF4 $335
line 643
;643:			{
line 644
;644:				Player->s.v.items = ( int ) Player->s.v.items | IT_INVULNERABILITY;
ADDRLP4 104
ADDRFP4 4
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 1048576
BORI4
CVIF4 4
ASGNF4
line 645
;645:				Player->invincible_time = 1;
ADDRFP4 4
INDIRP4
CNSTI4 748
ADDP4
CNSTF4 1065353216
ASGNF4
line 646
;646:				Player->invincible_finished = g_globalvars.time + Goal->invincible_finished;
ADDRLP4 108
CNSTI4 732
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 647
;647:				if ( streq( Goal->s.v.classname, "item_tfgoal" ) )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $220
ARGP4
ADDRLP4 112
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
EQI4 $339
line 648
;648:				{
line 649
;649:					Player->tfstate = Player->tfstate | TFSTATE_INVINCIBLE;
ADDRLP4 116
ADDRFP4 4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 650
;650:					Player->invincible_finished = g_globalvars.time + 666;
ADDRFP4 4
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1143373824
ADDF4
ASGNF4
line 651
;651:				}
LABELV $339
line 652
;652:			}
LABELV $335
line 653
;653:			if ( !tf_data.disable_powerups && ( Goal->invisible_finished > 0 ) )
ADDRGP4 tf_data+160
INDIRI4
CNSTI4 0
NEI4 $342
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRF4
CNSTF4 0
LEF4 $342
line 654
;654:			{
line 655
;655:				Player->s.v.items = ( int ) Player->s.v.items | IT_INVISIBILITY;
ADDRLP4 104
ADDRFP4 4
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 524288
BORI4
CVIF4 4
ASGNF4
line 656
;656:				Player->invisible_time = 1;
ADDRFP4 4
INDIRP4
CNSTI4 756
ADDP4
CNSTF4 1065353216
ASGNF4
line 657
;657:				Player->invisible_finished = g_globalvars.time + Goal->invisible_finished;
ADDRLP4 108
CNSTI4 736
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 658
;658:				if ( streq( Goal->s.v.classname, "item_tfgoal" ) )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $220
ARGP4
ADDRLP4 112
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
EQI4 $346
line 659
;659:				{
line 660
;660:					Player->tfstate = Player->tfstate | TFSTATE_INVISIBLE;
ADDRLP4 116
ADDRFP4 4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 661
;661:					Player->invisible_finished = g_globalvars.time + 666;
ADDRFP4 4
INDIRP4
CNSTI4 736
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1143373824
ADDF4
ASGNF4
line 662
;662:				}
LABELV $346
line 663
;663:			}
LABELV $342
line 664
;664:			if ( !tf_data.disable_powerups && ( Goal->super_damage_finished > 0 ) )
ADDRGP4 tf_data+160
INDIRI4
CNSTI4 0
NEI4 $349
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRF4
CNSTF4 0
LEF4 $349
line 665
;665:			{
line 666
;666:				Player->s.v.items = ( int ) Player->s.v.items | IT_QUAD;
ADDRLP4 104
ADDRFP4 4
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 4194304
BORI4
CVIF4 4
ASGNF4
line 667
;667:				Player->super_time = 1;
ADDRFP4 4
INDIRP4
CNSTI4 764
ADDP4
CNSTF4 1065353216
ASGNF4
line 668
;668:				Player->super_damage_finished = g_globalvars.time + Goal->super_damage_finished;
ADDRLP4 108
CNSTI4 740
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 669
;669:				if ( streq( Goal->s.v.classname, "item_tfgoal" ) )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $220
ARGP4
ADDRLP4 112
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
EQI4 $353
line 670
;670:				{
line 671
;671:					Player->tfstate = Player->tfstate | TFSTATE_QUAD;
ADDRLP4 116
ADDRFP4 4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 672
;672:					Player->super_damage_finished = g_globalvars.time + 666;
ADDRFP4 4
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1143373824
ADDF4
ASGNF4
line 673
;673:				}
LABELV $353
line 674
;674:			}
LABELV $349
line 675
;675:			if ( !tf_data.disable_powerups && ( Goal->radsuit_finished > 0 ) )
ADDRGP4 tf_data+160
INDIRI4
CNSTI4 0
NEI4 $356
ADDRFP4 0
INDIRP4
CNSTI4 744
ADDP4
INDIRF4
CNSTF4 0
LEF4 $356
line 676
;676:			{
line 677
;677:				Player->s.v.items = ( int ) Player->s.v.items | IT_SUIT;
ADDRLP4 104
ADDRFP4 4
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 2097152
BORI4
CVIF4 4
ASGNF4
line 678
;678:				Player->rad_time = 1;
ADDRFP4 4
INDIRP4
CNSTI4 772
ADDP4
CNSTF4 1065353216
ASGNF4
line 679
;679:				Player->radsuit_finished = g_globalvars.time + Goal->radsuit_finished;
ADDRLP4 108
CNSTI4 744
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 680
;680:				if ( streq( Goal->s.v.classname, "item_tfgoal" ) )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $220
ARGP4
ADDRLP4 112
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
EQI4 $360
line 681
;681:				{
line 682
;682:					Player->tfstate = Player->tfstate | TFSTATE_RADSUIT;
ADDRLP4 116
ADDRFP4 4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 683
;683:					Player->radsuit_finished = g_globalvars.time + 666;
ADDRFP4 4
INDIRP4
CNSTI4 744
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1143373824
ADDF4
ASGNF4
line 684
;684:				}
LABELV $360
line 685
;685:			}
LABELV $356
line 686
;686:		}
LABELV $315
line 687
;687:		Player->lives = Player->lives + Goal->lives;
ADDRLP4 24
CNSTI4 964
ASGNI4
ADDRLP4 28
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDI4
ASGNI4
line 688
;688:		if ( Goal->s.v.frags )
ADDRFP4 0
INDIRP4
CNSTI4 300
ADDP4
INDIRF4
CNSTF4 0
EQF4 $363
line 689
;689:		{
line 690
;690:			if ( Goal->goal_effects == TFGE_AP || !( tf_data.toggleflags & TFLAG_FULLTEAMSCORE ) )
ADDRFP4 0
INDIRP4
CNSTI4 1132
ADDP4
INDIRI4
CNSTI4 1
EQI4 $367
ADDRGP4 tf_data
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
NEI4 $365
LABELV $367
line 691
;691:				TF_AddFrags( Player, Goal->s.v.frags );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 300
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
LABELV $365
line 692
;692:		}
LABELV $363
line 693
;693:		oldself = self;
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
line 694
;694:		self = Player;
ADDRGP4 self
ADDRFP4 4
INDIRP4
ASGNP4
line 695
;695:		TeamFortress_CheckClassStats(  );
ADDRGP4 TeamFortress_CheckClassStats
CALLV
pop
line 696
;696:		W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 697
;697:		self = oldself;
ADDRGP4 self
ADDRLP4 8
INDIRP4
ASGNP4
line 698
;698:	}
LABELV $305
line 699
;699:	if ( Player->playerclass == PC_SPY && ( Goal->goal_result & TFGR_REMOVE_DISGUISE ) )
ADDRFP4 4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $368
ADDRFP4 0
INDIRP4
CNSTI4 1136
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $368
line 700
;700:	{
line 701
;701:		self->immune_to_check = g_globalvars.time + tf_data.cheat_pause;	//10;
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
line 702
;702:		Spy_RemoveDisguise( Player );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Spy_RemoveDisguise
CALLV
pop
line 703
;703:	}
LABELV $368
line 704
;704:	if ( Goal->s.v.items && strneq( Goal->s.v.classname, "item_tfgoal" ) )
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CNSTF4 0
EQF4 $372
ADDRLP4 24
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $220
ARGP4
ADDRLP4 28
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $372
line 705
;705:	{
line 706
;706:		te = Finditem( Goal->s.v.items );
ADDRFP4 0
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 32
ADDRGP4 Finditem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 707
;707:		if ( te != world && te != Goal )
ADDRLP4 36
ADDRLP4 0
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 36
INDIRU4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $374
ADDRLP4 36
INDIRU4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $374
line 708
;708:			tfgoalitem_GiveToPlayer( te, Player, Goal );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 tfgoalitem_GiveToPlayer
CALLV
pop
LABELV $374
line 709
;709:	}
LABELV $372
line 710
;710:	if ( Goal->axhitme )
ADDRFP4 0
INDIRP4
CNSTI4 780
ADDP4
INDIRF4
CNSTF4 0
EQF4 $376
line 711
;711:	{
line 712
;712:		te = Finditem( Goal->axhitme );
ADDRFP4 0
INDIRP4
CNSTI4 780
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 32
ADDRGP4 Finditem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 713
;713:		if ( te->s.v.owner == EDICT_TO_PROG( Player ) )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
NEI4 $378
line 714
;714:			tfgoalitem_RemoveFromPlayer( te, Player, 1 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 tfgoalitem_RemoveFromPlayer
CALLV
pop
LABELV $378
line 715
;715:	}
LABELV $376
line 716
;716:	if ( Goal->remove_item_group )
ADDRFP4 0
INDIRP4
CNSTI4 1236
ADDP4
INDIRI4
CNSTI4 0
EQI4 $380
line 717
;717:	{
line 718
;718:		te = trap_find( world, FOFS( s.v.classname ), "item_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 32
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
ADDRGP4 $383
JUMPV
LABELV $382
line 720
;719:		while ( te )
;720:		{
line 721
;721:			if ( te->group_no == Goal->remove_item_group && te->s.v.owner == EDICT_TO_PROG( AP ) )
ADDRLP4 0
INDIRP4
CNSTI4 1116
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1236
ADDP4
INDIRI4
NEI4 $385
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
NEI4 $385
line 722
;722:			{
line 723
;723:				oldte = te;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 724
;724:				te = trap_find( te, FOFS( s.v.classname ), "item_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 40
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
ASGNP4
line 725
;725:				tfgoalitem_RemoveFromPlayer( oldte, Player, 1 );
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 tfgoalitem_RemoveFromPlayer
CALLV
pop
line 726
;726:			} else
ADDRGP4 $386
JUMPV
LABELV $385
line 727
;727:				te = trap_find( te, FOFS( s.v.classname ), "item_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 40
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
ASGNP4
LABELV $386
line 728
;728:		}
LABELV $383
line 719
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $382
line 729
;729:	}
LABELV $380
line 730
;730:	if ( Goal->display_item_status1 )
ADDRFP4 0
INDIRP4
CNSTI4 1268
ADDP4
INDIRI4
CNSTI4 0
EQI4 $387
line 731
;731:	{
line 732
;732:		te = Finditem( Goal->display_item_status1 );
ADDRFP4 0
INDIRP4
CNSTI4 1268
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 Finditem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 733
;733:		if ( te != world )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $389
line 734
;734:			DisplayItemStatus( Goal, Player, te );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 DisplayItemStatus
CALLV
pop
ADDRGP4 $390
JUMPV
LABELV $389
line 736
;735:		else
;736:			G_sprint( Player, 2, "Item is missing.\n" );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $391
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $390
line 737
;737:	}
LABELV $387
line 738
;738:	if ( Goal->display_item_status2 )
ADDRFP4 0
INDIRP4
CNSTI4 1272
ADDP4
INDIRI4
CNSTI4 0
EQI4 $392
line 739
;739:	{
line 740
;740:		te = Finditem( Goal->display_item_status2 );
ADDRFP4 0
INDIRP4
CNSTI4 1272
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 Finditem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 741
;741:		if ( te != world )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $394
line 742
;742:			DisplayItemStatus( Goal, Player, te );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 DisplayItemStatus
CALLV
pop
ADDRGP4 $395
JUMPV
LABELV $394
line 744
;743:		else
;744:			G_sprint( Player, 2, "Item is missing.\n" );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $391
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $395
line 745
;745:	}
LABELV $392
line 746
;746:	if ( Goal->display_item_status3 )
ADDRFP4 0
INDIRP4
CNSTI4 1276
ADDP4
INDIRI4
CNSTI4 0
EQI4 $396
line 747
;747:	{
line 748
;748:		te = Finditem( Goal->display_item_status3 );
ADDRFP4 0
INDIRP4
CNSTI4 1276
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 Finditem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 749
;749:		if ( te != world )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $398
line 750
;750:			DisplayItemStatus( Goal, Player, te );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 DisplayItemStatus
CALLV
pop
ADDRGP4 $399
JUMPV
LABELV $398
line 752
;751:		else
;752:			G_sprint( Player, 2, "Item is missing.\n" );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $391
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $399
line 753
;753:	}
LABELV $396
line 754
;754:	if ( Goal->display_item_status4 )
ADDRFP4 0
INDIRP4
CNSTI4 1280
ADDP4
INDIRI4
CNSTI4 0
EQI4 $400
line 755
;755:	{
line 756
;756:		te = Finditem( Goal->display_item_status4 );
ADDRFP4 0
INDIRP4
CNSTI4 1280
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 Finditem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 757
;757:		if ( te != world )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $402
line 758
;758:			DisplayItemStatus( Goal, Player, te );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 DisplayItemStatus
CALLV
pop
ADDRGP4 $403
JUMPV
LABELV $402
line 760
;759:		else
;760:			G_sprint( Player, 2, "Item is missing.\n" );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $391
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $403
line 761
;761:	}
LABELV $400
line 762
;762:	if ( Goal->goal_result & TFGR_FORCE_RESPAWN )
ADDRFP4 0
INDIRP4
CNSTI4 1136
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $404
line 763
;763:		ForceRespawn( Player );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 ForceRespawn
CALLV
pop
LABELV $404
line 764
;764:}
LABELV $295
endproc Apply_Results 124 24
export RemoveResults
proc RemoveResults 172 24
line 767
;765:
;766:void RemoveResults( gedict_t * Goal, gedict_t * Player )
;767:{
line 775
;768:	gedict_t *oldself;
;769:	gedict_t *te;
;770:	float   puinvin;
;771:	float   puinvis;
;772:	float   puquad;
;773:	float   purad;
;774:
;775:	if ( streq( Goal->s.v.classname, "item_tfgoal" ) )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $220
ARGP4
ADDRLP4 24
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $407
line 776
;776:	{
line 777
;777:		if ( !( Player->item_list & Goal->item_list ) )
ADDRLP4 28
CNSTI4 1384
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
BANDI4
CNSTI4 0
NEI4 $409
line 778
;778:			return;
ADDRGP4 $406
JUMPV
LABELV $409
line 779
;779:		if ( Goal->goal_activation & TFGI_DONTREMOVERES )
ADDRFP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $411
line 780
;780:			return;
ADDRGP4 $406
JUMPV
LABELV $411
line 781
;781:		Player->item_list = Player->item_list - ( Player->item_list & Goal->item_list );
ADDRLP4 32
CNSTI4 1384
ASGNI4
ADDRLP4 36
ADDRFP4 4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ASGNP4
ADDRLP4 40
ADDRLP4 36
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRP4
ADDRLP4 40
INDIRI4
ADDRLP4 40
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
BANDI4
SUBI4
ASGNI4
line 782
;782:	}
LABELV $407
line 783
;783:	if ( Goal->s.v.health > 0 )
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $413
line 784
;784:		TF_T_Damage( Player, Goal, Goal, Goal->s.v.health, 1, 0 );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 296
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
LABELV $413
line 785
;785:	if ( Goal->s.v.health < 0 )
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GEF4 $415
line 786
;786:		T_Heal( Player, 0 - Goal->s.v.health, 0 );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 32
CNSTF4 0
ASGNF4
ADDRLP4 32
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 T_Heal
CALLI4
pop
LABELV $415
line 787
;787:	Player->lives = Player->lives - Goal->lives;
ADDRLP4 36
CNSTI4 964
ASGNI4
ADDRLP4 40
ADDRFP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 788
;788:	Player->s.v.armortype = Player->s.v.armortype - Goal->s.v.armortype;
ADDRLP4 44
CNSTI4 424
ASGNI4
ADDRLP4 48
ADDRFP4 4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 789
;789:	Player->s.v.armorvalue = Player->s.v.armorvalue - Goal->s.v.armorvalue;
ADDRLP4 52
CNSTI4 428
ASGNI4
ADDRLP4 56
ADDRFP4 4
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 790
;790:	Player->armorclass = Player->armorclass - ( Player->armorclass & Goal->armorclass );
ADDRLP4 60
CNSTI4 828
ASGNI4
ADDRLP4 64
ADDRFP4 4
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
ASGNP4
ADDRLP4 68
ADDRLP4 64
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 64
INDIRP4
ADDRLP4 68
INDIRI4
ADDRLP4 68
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRI4
BANDI4
SUBI4
ASGNI4
line 791
;791:	if ( Goal->s.v.frags )
ADDRFP4 0
INDIRP4
CNSTI4 300
ADDP4
INDIRF4
CNSTF4 0
EQF4 $417
line 792
;792:	{
line 793
;793:		if ( Goal->goal_effects == TFGE_AP || !( tf_data.toggleflags & TFLAG_FULLTEAMSCORE ) )
ADDRFP4 0
INDIRP4
CNSTI4 1132
ADDP4
INDIRI4
CNSTI4 1
EQI4 $421
ADDRGP4 tf_data
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
NEI4 $419
LABELV $421
line 794
;794:			TF_AddFrags( Player, Goal->s.v.frags );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 300
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
LABELV $419
line 795
;795:	}
LABELV $417
line 796
;796:	Player->s.v.ammo_shells = Player->s.v.ammo_shells - Goal->s.v.ammo_shells;
ADDRLP4 72
CNSTI4 320
ASGNI4
ADDRLP4 76
ADDRFP4 4
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 797
;797:	Player->s.v.ammo_nails = Player->s.v.ammo_nails - Goal->s.v.ammo_nails;
ADDRLP4 80
CNSTI4 324
ASGNI4
ADDRLP4 84
ADDRFP4 4
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 798
;798:	Player->s.v.ammo_rockets = Player->s.v.ammo_rockets - Goal->s.v.ammo_rockets;
ADDRLP4 88
CNSTI4 328
ASGNI4
ADDRLP4 92
ADDRFP4 4
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 799
;799:	Player->s.v.ammo_cells = Player->s.v.ammo_cells - Goal->s.v.ammo_cells;
ADDRLP4 96
CNSTI4 332
ASGNI4
ADDRLP4 100
ADDRFP4 4
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 800
;800:	Player->ammo_medikit = Player->ammo_medikit - Goal->ammo_medikit;
ADDRLP4 104
CNSTI4 1044
ASGNI4
ADDRLP4 108
ADDRFP4 4
INDIRP4
ADDRLP4 104
INDIRI4
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 104
INDIRI4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 801
;801:	Player->ammo_detpack = Player->ammo_detpack - Goal->ammo_detpack;
ADDRLP4 112
CNSTI4 1052
ASGNI4
ADDRLP4 116
ADDRFP4 4
INDIRP4
ADDRLP4 112
INDIRI4
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 112
INDIRI4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 802
;802:	Player->no_grenades_1 = Player->no_grenades_1 - Goal->no_grenades_1;
ADDRLP4 120
CNSTI4 840
ASGNI4
ADDRLP4 124
ADDRFP4 4
INDIRP4
ADDRLP4 120
INDIRI4
ADDP4
ASGNP4
ADDRLP4 124
INDIRP4
ADDRLP4 124
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 120
INDIRI4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 803
;803:	Player->no_grenades_2 = Player->no_grenades_2 - Goal->no_grenades_2;
ADDRLP4 128
CNSTI4 844
ASGNI4
ADDRLP4 132
ADDRFP4 4
INDIRP4
ADDRLP4 128
INDIRI4
ADDP4
ASGNP4
ADDRLP4 132
INDIRP4
ADDRLP4 132
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 128
INDIRI4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 804
;804:	bound_other_ammo( Player );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 bound_other_ammo
CALLV
pop
line 805
;805:	if ( Player->tfstate & TFSTATE_GRENPRIMED )
ADDRFP4 4
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $422
line 806
;806:	{
line 807
;807:		te = trap_find( world, FOFS( s.v.classname ), "primer" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $325
ARGP4
ADDRLP4 136
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 136
INDIRP4
ASGNP4
ADDRGP4 $425
JUMPV
LABELV $424
line 809
;808:		while ( te )
;809:		{
line 810
;810:			if ( te->s.v.owner == EDICT_TO_PROG( Player ) )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
NEI4 $427
line 811
;811:			{
line 812
;812:				if ( te->s.v.impulse == 151 && Goal->no_grenades_2 < 0 )
ADDRLP4 0
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1125580800
NEF4 $429
ADDRFP4 0
INDIRP4
CNSTI4 844
ADDP4
INDIRI4
CNSTI4 0
GEI4 $429
line 813
;813:				{
line 814
;814:					Player->tfstate = Player->tfstate - ( Player->tfstate & TFSTATE_GRENPRIMED );
ADDRLP4 140
ADDRFP4 4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 144
ADDRLP4 140
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 140
INDIRP4
ADDRLP4 144
INDIRI4
ADDRLP4 144
INDIRI4
CNSTI4 1
BANDI4
SUBI4
ASGNI4
line 815
;815:					Player->tfstate = Player->tfstate - ( Player->tfstate & TFSTATE_GRENTHROWING );
ADDRLP4 148
ADDRFP4 4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 152
ADDRLP4 148
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 148
INDIRP4
ADDRLP4 152
INDIRI4
ADDRLP4 152
INDIRI4
CNSTI4 1024
BANDI4
SUBI4
ASGNI4
line 816
;816:					dremove( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 817
;817:				} else
ADDRGP4 $430
JUMPV
LABELV $429
line 818
;818:				{
line 819
;819:					if ( te->s.v.impulse == 150 && Goal->no_grenades_1 < 0 )
ADDRLP4 0
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 1125515264
NEF4 $431
ADDRFP4 0
INDIRP4
CNSTI4 840
ADDP4
INDIRI4
CNSTI4 0
GEI4 $431
line 820
;820:					{
line 821
;821:						Player->tfstate =
ADDRLP4 140
ADDRFP4 4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 144
ADDRLP4 140
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 140
INDIRP4
ADDRLP4 144
INDIRI4
ADDRLP4 144
INDIRI4
CNSTI4 1
BANDI4
SUBI4
ASGNI4
line 823
;822:						    Player->tfstate - ( Player->tfstate & TFSTATE_GRENPRIMED );
;823:						Player->tfstate =
ADDRLP4 148
ADDRFP4 4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 152
ADDRLP4 148
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 148
INDIRP4
ADDRLP4 152
INDIRI4
ADDRLP4 152
INDIRI4
CNSTI4 1024
BANDI4
SUBI4
ASGNI4
line 825
;824:						    Player->tfstate - ( Player->tfstate & TFSTATE_GRENTHROWING );
;825:						dremove( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 826
;826:					}
LABELV $431
line 827
;827:				}
LABELV $430
line 828
;828:				te = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 829
;829:			} else
ADDRGP4 $428
JUMPV
LABELV $427
line 830
;830:				te = trap_find( te, FOFS( s.v.classname ), "primer" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $325
ARGP4
ADDRLP4 140
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 140
INDIRP4
ASGNP4
LABELV $428
line 831
;831:		}
LABELV $425
line 808
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $424
line 832
;832:	}
LABELV $422
line 833
;833:	puinvin = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 834
;834:	puinvis = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 835
;835:	puquad = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 836
;836:	purad = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
line 837
;837:	te = trap_find( world, FOFS( s.v.classname ), "item_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 136
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 136
INDIRP4
ASGNP4
ADDRGP4 $434
JUMPV
LABELV $433
line 839
;838:	while ( te )
;839:	{
line 840
;840:		if ( te->s.v.owner == EDICT_TO_PROG( Player ) && te != Goal )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
NEI4 $436
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $436
line 841
;841:		{
line 842
;842:			if ( te->invincible_finished > 0 )
ADDRLP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
CNSTF4 0
LEF4 $438
line 843
;843:				puinvin = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
LABELV $438
line 844
;844:			if ( te->invisible_finished > 0 )
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRF4
CNSTF4 0
LEF4 $440
line 845
;845:				puinvis = 1;
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
LABELV $440
line 846
;846:			if ( te->super_damage_finished > 0 )
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRF4
CNSTF4 0
LEF4 $442
line 847
;847:				puquad = 1;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
LABELV $442
line 848
;848:			if ( te->radsuit_finished > 0 )
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
INDIRF4
CNSTF4 0
LEF4 $444
line 849
;849:				purad = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
LABELV $444
line 850
;850:		}
LABELV $436
line 851
;851:		te = trap_find( te, FOFS( s.v.classname ), "item_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 144
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 144
INDIRP4
ASGNP4
line 852
;852:	}
LABELV $434
line 838
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $433
line 853
;853:	if ( !tf_data.disable_powerups && Goal->invincible_finished > 0 && !puinvin )
ADDRGP4 tf_data+160
INDIRI4
CNSTI4 0
NEI4 $446
ADDRLP4 140
CNSTF4 0
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
ADDRLP4 140
INDIRF4
LEF4 $446
ADDRLP4 4
INDIRF4
ADDRLP4 140
INDIRF4
NEF4 $446
line 854
;854:	{
line 855
;855:		Player->tfstate = Player->tfstate - ( Player->tfstate & TFSTATE_INVINCIBLE );
ADDRLP4 144
ADDRFP4 4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 148
ADDRLP4 144
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 144
INDIRP4
ADDRLP4 148
INDIRI4
ADDRLP4 148
INDIRI4
CNSTI4 32
BANDI4
SUBI4
ASGNI4
line 856
;856:		Player->s.v.items = ( int ) Player->s.v.items | IT_INVULNERABILITY;
ADDRLP4 152
ADDRFP4 4
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 152
INDIRP4
ADDRLP4 152
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 1048576
BORI4
CVIF4 4
ASGNF4
line 857
;857:		Player->invincible_time = 1;
ADDRFP4 4
INDIRP4
CNSTI4 748
ADDP4
CNSTF4 1065353216
ASGNF4
line 858
;858:		Player->invincible_finished = g_globalvars.time + Goal->invincible_finished;
ADDRLP4 156
CNSTI4 732
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 156
INDIRI4
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 156
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 859
;859:	}
LABELV $446
line 860
;860:	if ( !tf_data.disable_powerups && Goal->invisible_finished > 0 && !puinvis )
ADDRGP4 tf_data+160
INDIRI4
CNSTI4 0
NEI4 $450
ADDRLP4 144
CNSTF4 0
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRF4
ADDRLP4 144
INDIRF4
LEF4 $450
ADDRLP4 8
INDIRF4
ADDRLP4 144
INDIRF4
NEF4 $450
line 861
;861:	{
line 862
;862:		Player->tfstate = Player->tfstate - ( Player->tfstate & TFSTATE_INVISIBLE );
ADDRLP4 148
ADDRFP4 4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 152
ADDRLP4 148
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 148
INDIRP4
ADDRLP4 152
INDIRI4
ADDRLP4 152
INDIRI4
CNSTI4 64
BANDI4
SUBI4
ASGNI4
line 863
;863:		Player->s.v.items = ( int ) Player->s.v.items | IT_INVISIBILITY;
ADDRLP4 156
ADDRFP4 4
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 156
INDIRP4
ADDRLP4 156
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 524288
BORI4
CVIF4 4
ASGNF4
line 864
;864:		Player->invisible_time = 1;
ADDRFP4 4
INDIRP4
CNSTI4 756
ADDP4
CNSTF4 1065353216
ASGNF4
line 865
;865:		Player->invisible_finished = g_globalvars.time + Goal->invisible_finished;
ADDRLP4 160
CNSTI4 736
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 160
INDIRI4
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 160
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 866
;866:	}
LABELV $450
line 867
;867:	if ( !tf_data.disable_powerups && Goal->super_damage_finished > 0 && !puquad )
ADDRGP4 tf_data+160
INDIRI4
CNSTI4 0
NEI4 $454
ADDRLP4 148
CNSTF4 0
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRF4
ADDRLP4 148
INDIRF4
LEF4 $454
ADDRLP4 12
INDIRF4
ADDRLP4 148
INDIRF4
NEF4 $454
line 868
;868:	{
line 869
;869:		Player->tfstate = Player->tfstate - ( Player->tfstate & TFSTATE_QUAD );
ADDRLP4 152
ADDRFP4 4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 156
ADDRLP4 152
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 152
INDIRP4
ADDRLP4 156
INDIRI4
ADDRLP4 156
INDIRI4
CNSTI4 128
BANDI4
SUBI4
ASGNI4
line 870
;870:		Player->s.v.items = ( int ) Player->s.v.items | IT_QUAD;
ADDRLP4 160
ADDRFP4 4
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 4194304
BORI4
CVIF4 4
ASGNF4
line 871
;871:		Player->super_time = 1;
ADDRFP4 4
INDIRP4
CNSTI4 764
ADDP4
CNSTF4 1065353216
ASGNF4
line 872
;872:		Player->super_damage_finished = g_globalvars.time + Goal->super_damage_finished;
ADDRLP4 164
CNSTI4 740
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 164
INDIRI4
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 164
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 873
;873:	}
LABELV $454
line 874
;874:	if ( !tf_data.disable_powerups && Goal->radsuit_finished > 0 && !purad )
ADDRGP4 tf_data+160
INDIRI4
CNSTI4 0
NEI4 $458
ADDRLP4 152
CNSTF4 0
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 744
ADDP4
INDIRF4
ADDRLP4 152
INDIRF4
LEF4 $458
ADDRLP4 16
INDIRF4
ADDRLP4 152
INDIRF4
NEF4 $458
line 875
;875:	{
line 876
;876:		Player->tfstate = Player->tfstate - ( Player->tfstate & TFSTATE_RADSUIT );
ADDRLP4 156
ADDRFP4 4
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 160
ADDRLP4 156
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 156
INDIRP4
ADDRLP4 160
INDIRI4
ADDRLP4 160
INDIRI4
CNSTI4 256
BANDI4
SUBI4
ASGNI4
line 877
;877:		Player->s.v.items = ( int ) Player->s.v.items | IT_SUIT;
ADDRLP4 164
ADDRFP4 4
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 164
INDIRP4
ADDRLP4 164
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 2097152
BORI4
CVIF4 4
ASGNF4
line 878
;878:		Player->rad_time = 1;
ADDRFP4 4
INDIRP4
CNSTI4 772
ADDP4
CNSTF4 1065353216
ASGNF4
line 879
;879:		Player->radsuit_finished = g_globalvars.time + Goal->radsuit_finished;
ADDRLP4 168
CNSTI4 744
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 168
INDIRI4
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 168
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 880
;880:	}
LABELV $458
line 881
;881:	oldself = self;
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
line 882
;882:	self = Player;
ADDRGP4 self
ADDRFP4 4
INDIRP4
ASGNP4
line 883
;883:	TeamFortress_CheckClassStats(  );
ADDRGP4 TeamFortress_CheckClassStats
CALLV
pop
line 884
;884:	W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 885
;885:	self = oldself;
ADDRGP4 self
ADDRLP4 20
INDIRP4
ASGNP4
line 886
;886:}
LABELV $406
endproc RemoveResults 172 24
export APMeetsCriteria
proc APMeetsCriteria 28 12
line 889
;887:
;888:int APMeetsCriteria( gedict_t * Goal, gedict_t * AP )
;889:{
line 893
;890:	float   gotone;
;891:	gedict_t *te;
;892:
;893:	if ( AP && AP != world )
ADDRLP4 8
ADDRFP4 4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 8
INDIRU4
CNSTU4 0
EQU4 $463
ADDRLP4 8
INDIRU4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $463
line 894
;894:	{
line 895
;895:		if ( Goal->team_no )
ADDRFP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 0
EQI4 $465
line 896
;896:		{
line 897
;897:			if ( Goal->team_no != AP->team_no )
ADDRLP4 12
CNSTI4 960
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
EQI4 $467
line 898
;898:				return 0;
CNSTI4 0
RETI4
ADDRGP4 $462
JUMPV
LABELV $467
line 899
;899:		}
LABELV $465
line 900
;900:		if ( Goal->playerclass )
ADDRFP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
EQI4 $469
line 901
;901:		{
line 902
;902:			if ( Goal->playerclass != AP->playerclass )
ADDRLP4 12
CNSTI4 820
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
EQI4 $471
line 903
;903:				return 0;
CNSTI4 0
RETI4
ADDRGP4 $462
JUMPV
LABELV $471
line 904
;904:		}
LABELV $469
line 905
;905:		if ( Goal->items_allowed )
ADDRFP4 0
INDIRP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 0
EQI4 $473
line 906
;906:		{
line 907
;907:			te = Finditem( Goal->items_allowed );
ADDRFP4 0
INDIRP4
CNSTI4 920
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 Finditem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 908
;908:			if ( te->s.v.owner != EDICT_TO_PROG( AP ) )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
EQI4 $475
line 909
;909:				return 0;
CNSTI4 0
RETI4
ADDRGP4 $462
JUMPV
LABELV $475
line 910
;910:		}
LABELV $473
line 911
;911:	}
LABELV $463
line 912
;912:	if ( Goal->if_goal_is_active )
ADDRFP4 0
INDIRP4
CNSTI4 1148
ADDP4
INDIRI4
CNSTI4 0
EQI4 $477
line 913
;913:	{
line 914
;914:		te = Findgoal( Goal->if_goal_is_active );
ADDRFP4 0
INDIRP4
CNSTI4 1148
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
line 915
;915:		if ( te && te->goal_state != TFGS_ACTIVE )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $479
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 1
EQI4 $479
line 916
;916:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $462
JUMPV
LABELV $479
line 917
;917:	}
LABELV $477
line 918
;918:	if ( Goal->if_goal_is_inactive )
ADDRFP4 0
INDIRP4
CNSTI4 1152
ADDP4
INDIRI4
CNSTI4 0
EQI4 $481
line 919
;919:	{
line 920
;920:		te = Findgoal( Goal->if_goal_is_inactive );
ADDRFP4 0
INDIRP4
CNSTI4 1152
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
line 921
;921:		if ( te && te->goal_state != TFGS_INACTIVE )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $483
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 2
EQI4 $483
line 922
;922:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $462
JUMPV
LABELV $483
line 923
;923:	}
LABELV $481
line 924
;924:	if ( Goal->if_goal_is_removed )
ADDRFP4 0
INDIRP4
CNSTI4 1156
ADDP4
INDIRI4
CNSTI4 0
EQI4 $485
line 925
;925:	{
line 926
;926:		te = Findgoal( Goal->if_goal_is_removed );
ADDRFP4 0
INDIRP4
CNSTI4 1156
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
line 927
;927:		if ( te && te->goal_state != TFGS_REMOVED )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $487
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 3
EQI4 $487
line 928
;928:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $462
JUMPV
LABELV $487
line 929
;929:	}
LABELV $485
line 930
;930:	if ( Goal->if_group_is_active )
ADDRFP4 0
INDIRP4
CNSTI4 1160
ADDP4
INDIRI4
CNSTI4 0
EQI4 $489
line 931
;931:	{
line 932
;932:		te = trap_find( world, FOFS( s.v.classname ), "info_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
ADDRGP4 $492
JUMPV
LABELV $491
line 934
;933:		while ( te )
;934:		{
line 935
;935:			if ( te->group_no == Goal->if_group_is_active )
ADDRLP4 0
INDIRP4
CNSTI4 1116
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1160
ADDP4
INDIRI4
NEI4 $494
line 936
;936:			{
line 937
;937:				if ( te->goal_state != TFGS_ACTIVE )
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 1
EQI4 $496
line 938
;938:					return 0;
CNSTI4 0
RETI4
ADDRGP4 $462
JUMPV
LABELV $496
line 939
;939:			}
LABELV $494
line 940
;940:			te = trap_find( te, FOFS( s.v.classname ), "info_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 941
;941:		}
LABELV $492
line 933
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $491
line 942
;942:	}
LABELV $489
line 943
;943:	if ( Goal->if_group_is_inactive )
ADDRFP4 0
INDIRP4
CNSTI4 1164
ADDP4
INDIRI4
CNSTI4 0
EQI4 $498
line 944
;944:	{
line 945
;945:		te = trap_find( world, FOFS( s.v.classname ), "info_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
ADDRGP4 $501
JUMPV
LABELV $500
line 947
;946:		while ( te )
;947:		{
line 948
;948:			if ( te->group_no == Goal->if_group_is_inactive )
ADDRLP4 0
INDIRP4
CNSTI4 1116
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1164
ADDP4
INDIRI4
NEI4 $503
line 949
;949:			{
line 950
;950:				if ( te->goal_state != TFGS_INACTIVE )
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 2
EQI4 $505
line 951
;951:					return 0;
CNSTI4 0
RETI4
ADDRGP4 $462
JUMPV
LABELV $505
line 952
;952:			}
LABELV $503
line 953
;953:			te = trap_find( te, FOFS( s.v.classname ), "info_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 954
;954:		}
LABELV $501
line 946
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $500
line 955
;955:	}
LABELV $498
line 956
;956:	if ( Goal->if_group_is_removed )
ADDRFP4 0
INDIRP4
CNSTI4 1168
ADDP4
INDIRI4
CNSTI4 0
EQI4 $507
line 957
;957:	{
line 958
;958:		te = trap_find( world, FOFS( s.v.classname ), "info_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
ADDRGP4 $510
JUMPV
LABELV $509
line 960
;959:		while ( te )
;960:		{
line 961
;961:			if ( te->group_no == Goal->if_group_is_removed )
ADDRLP4 0
INDIRP4
CNSTI4 1116
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1168
ADDP4
INDIRI4
NEI4 $512
line 962
;962:			{
line 963
;963:				if ( te->goal_state != TFGS_REMOVED )
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 3
EQI4 $514
line 964
;964:					return 0;
CNSTI4 0
RETI4
ADDRGP4 $462
JUMPV
LABELV $514
line 965
;965:			}
LABELV $512
line 966
;966:			te = trap_find( te, FOFS( s.v.classname ), "info_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 967
;967:		}
LABELV $510
line 959
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $509
line 968
;968:	}
LABELV $507
line 969
;969:	if ( Goal->if_item_has_moved )
ADDRFP4 0
INDIRP4
CNSTI4 1244
ADDP4
INDIRI4
CNSTI4 0
EQI4 $516
line 970
;970:	{
line 971
;971:		te = Finditem( Goal->if_item_has_moved );
ADDRFP4 0
INDIRP4
CNSTI4 1244
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 Finditem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 972
;972:		if ( te != world )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $518
line 973
;973:		{
line 974
;974:			if ( te->goal_state != TFGS_ACTIVE && VectorCompare( te->s.v.origin, te->s.v.oldorigin ) )
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 1
EQI4 $520
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $520
line 975
;975:				return 0;
CNSTI4 0
RETI4
ADDRGP4 $462
JUMPV
LABELV $520
line 976
;976:		}
LABELV $518
line 977
;977:	}
LABELV $516
line 978
;978:	if ( Goal->if_item_hasnt_moved )
ADDRFP4 0
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
CNSTI4 0
EQI4 $522
line 979
;979:	{
line 980
;980:		te = Finditem( Goal->if_item_hasnt_moved );
ADDRFP4 0
INDIRP4
CNSTI4 1248
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 Finditem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 981
;981:		if ( te != world )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $524
line 982
;982:		{
line 983
;983:			if ( te->goal_state == TFGS_ACTIVE || !VectorCompare( te->s.v.origin, te->s.v.oldorigin ) )
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 1
EQI4 $528
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $526
LABELV $528
line 984
;984:				return 0;
CNSTI4 0
RETI4
ADDRGP4 $462
JUMPV
LABELV $526
line 985
;985:		}
LABELV $524
line 986
;986:	}
LABELV $522
line 987
;987:	if ( AP && AP != world )
ADDRLP4 12
ADDRFP4 4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 12
INDIRU4
CNSTU4 0
EQU4 $529
ADDRLP4 12
INDIRU4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $529
line 988
;988:	{
line 989
;989:		gotone = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 990
;990:		if ( Goal->has_item_from_group )
ADDRFP4 0
INDIRP4
CNSTI4 1228
ADDP4
INDIRI4
CNSTI4 0
EQI4 $531
line 991
;991:		{
line 992
;992:			te = trap_find( world, FOFS( s.v.classname ), "item_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
ADDRGP4 $534
JUMPV
LABELV $533
line 994
;993:			while ( te && !gotone )
;994:			{
line 995
;995:				if ( te->group_no == Goal->has_item_from_group && te->s.v.owner == EDICT_TO_PROG( AP ) )
ADDRLP4 0
INDIRP4
CNSTI4 1116
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1228
ADDP4
INDIRI4
NEI4 $536
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
NEI4 $536
line 996
;996:					gotone = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
LABELV $536
line 997
;997:				te = trap_find( te, FOFS( s.v.classname ), "item_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 24
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 998
;998:			}
LABELV $534
line 993
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $538
ADDRLP4 4
INDIRF4
CNSTF4 0
EQF4 $533
LABELV $538
line 999
;999:			if ( !gotone )
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $539
line 1000
;1000:				return 0;
CNSTI4 0
RETI4
ADDRGP4 $462
JUMPV
LABELV $539
line 1001
;1001:		}
LABELV $531
line 1002
;1002:		if ( Goal->hasnt_item_from_group )
ADDRFP4 0
INDIRP4
CNSTI4 1232
ADDP4
INDIRI4
CNSTI4 0
EQI4 $541
line 1003
;1003:		{
line 1004
;1004:			te = trap_find( world, FOFS( s.v.classname ), "item_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
ADDRGP4 $544
JUMPV
LABELV $543
line 1006
;1005:			while ( te && !gotone )
;1006:			{
line 1007
;1007:				if ( te->group_no == Goal->hasnt_item_from_group
ADDRLP4 0
INDIRP4
CNSTI4 1116
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1232
ADDP4
INDIRI4
NEI4 $546
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
NEI4 $546
line 1009
;1008:				     && te->s.v.owner == EDICT_TO_PROG( AP ) )
;1009:					return 0;
CNSTI4 0
RETI4
ADDRGP4 $462
JUMPV
LABELV $546
line 1010
;1010:				te = trap_find( te, FOFS( s.v.classname ), "item_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 24
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 1011
;1011:			}
LABELV $544
line 1005
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $548
ADDRLP4 4
INDIRF4
CNSTF4 0
EQF4 $543
LABELV $548
line 1012
;1012:		}
LABELV $541
line 1013
;1013:	}
LABELV $529
line 1014
;1014:	return 1;
CNSTI4 1
RETI4
LABELV $462
endproc APMeetsCriteria 28 12
export SetupRespawn
proc SetupRespawn 4 4
line 1018
;1015:}
;1016:
;1017:void SetupRespawn( gedict_t * Goal )
;1018:{
line 1019
;1019:	if ( Goal->search_time )
ADDRFP4 0
INDIRP4
CNSTI4 1108
ADDP4
INDIRF4
CNSTF4 0
EQF4 $550
line 1020
;1020:	{
line 1021
;1021:		InactivateGoal( Goal );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 InactivateGoal
CALLV
pop
line 1022
;1022:		Goal->s.v.think = ( func_t ) tfgoal_timer_tick;
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 tfgoal_timer_tick
CVPU4 4
CVUI4 4
ASGNI4
line 1023
;1023:		Goal->s.v.nextthink = g_globalvars.time + Goal->search_time;
ADDRLP4 0
ADDRFP4 0
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
CNSTI4 1108
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1024
;1024:		return;
ADDRGP4 $549
JUMPV
LABELV $550
line 1026
;1025:	}
;1026:	if ( Goal->goal_result & TFGR_SINGLE )
ADDRFP4 0
INDIRP4
CNSTI4 1136
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $553
line 1027
;1027:	{
line 1028
;1028:		RemoveGoal( Goal );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 RemoveGoal
CALLV
pop
line 1029
;1029:		return;
ADDRGP4 $549
JUMPV
LABELV $553
line 1031
;1030:	}
;1031:	if ( Goal->wait > 0 )
ADDRFP4 0
INDIRP4
CNSTI4 660
ADDP4
INDIRF4
CNSTF4 0
LEF4 $555
line 1032
;1032:	{
line 1033
;1033:		Goal->s.v.nextthink = g_globalvars.time + Goal->wait;
ADDRLP4 0
ADDRFP4 0
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
line 1034
;1034:		Goal->s.v.think = ( func_t ) DoRespawn;
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 DoRespawn
CVPU4 4
CVUI4 4
ASGNI4
line 1035
;1035:		return;
ADDRGP4 $549
JUMPV
LABELV $555
line 1037
;1036:	} else
;1037:	{
line 1038
;1038:		if ( Goal->wait == -1 )
ADDRFP4 0
INDIRP4
CNSTI4 660
ADDP4
INDIRF4
CNSTF4 3212836864
NEF4 $558
line 1039
;1039:			return;
ADDRGP4 $549
JUMPV
LABELV $558
line 1040
;1040:	}
line 1041
;1041:	InactivateGoal( Goal );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 InactivateGoal
CALLV
pop
line 1042
;1042:}
LABELV $549
endproc SetupRespawn 4 4
export DoRespawn
proc DoRespawn 0 4
line 1045
;1043:
;1044:void DoRespawn(  )
;1045:{
line 1046
;1046:	RestoreGoal( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 RestoreGoal
CALLV
pop
line 1047
;1047:	InactivateGoal( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 InactivateGoal
CALLV
pop
line 1048
;1048:}
LABELV $560
endproc DoRespawn 0 4
export Activated
proc Activated 20 8
line 1051
;1049:
;1050:int Activated( gedict_t * Goal, gedict_t * AP )
;1051:{
line 1056
;1052:	float   APMet;
;1053:	float   RevAct;
;1054:	float   Act;
;1055:
;1056:	if ( Goal->goal_state == TFGS_ACTIVE )
ADDRFP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 1
NEI4 $562
line 1057
;1057:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $561
JUMPV
LABELV $562
line 1058
;1058:	if ( Goal->goal_state == TFGS_REMOVED )
ADDRFP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 3
NEI4 $564
line 1059
;1059:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $561
JUMPV
LABELV $564
line 1060
;1060:	if ( Goal->goal_state == TFGS_DELAYED )
ADDRFP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 4
NEI4 $566
line 1061
;1061:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $561
JUMPV
LABELV $566
line 1062
;1062:	APMet = APMeetsCriteria( Goal, AP );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 APMeetsCriteria
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CVIF4 4
ASGNF4
line 1063
;1063:	if ( streq( Goal->s.v.classname, "item_tfgoal" ) )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $220
ARGP4
ADDRLP4 16
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $568
line 1064
;1064:		RevAct = Goal->goal_activation & TFGI_REVERSE_AP;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CVIF4 4
ASGNF4
ADDRGP4 $569
JUMPV
LABELV $568
line 1066
;1065:	else
;1066:		RevAct = Goal->goal_activation & TFGA_REVERSE_AP;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CVIF4 4
ASGNF4
LABELV $569
line 1067
;1067:	Act = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1068
;1068:	if ( APMet )
ADDRLP4 4
INDIRF4
CNSTF4 0
EQF4 $570
line 1069
;1069:	{
line 1070
;1070:		if ( !RevAct )
ADDRLP4 8
INDIRF4
CNSTF4 0
NEF4 $571
line 1071
;1071:			Act = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 1072
;1072:	} else
ADDRGP4 $571
JUMPV
LABELV $570
line 1073
;1073:	{
line 1074
;1074:		if ( RevAct )
ADDRLP4 8
INDIRF4
CNSTF4 0
EQF4 $574
line 1075
;1075:			Act = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
LABELV $574
line 1076
;1076:	}
LABELV $571
line 1077
;1077:	return Act;
ADDRLP4 0
INDIRF4
CVFI4 4
RETI4
LABELV $561
endproc Activated 20 8
export AttemptToActivate
proc AttemptToActivate 12 12
line 1081
;1078:}
;1079:
;1080:void AttemptToActivate( gedict_t * Goal, gedict_t * AP, gedict_t * ActivatingGoal )
;1081:{
line 1084
;1082:	gedict_t *te;
;1083:
;1084:	if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $577
line 1085
;1085:		return;
ADDRGP4 $576
JUMPV
LABELV $577
line 1086
;1086:	if ( Activated( Goal, AP ) )
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Activated
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $581
line 1087
;1087:	{
line 1088
;1088:		if ( ActivatingGoal == Goal )
ADDRFP4 8
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $583
line 1089
;1089:			DoResults( Goal, AP, 1 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 DoResults
CALLV
pop
ADDRGP4 $582
JUMPV
LABELV $583
line 1091
;1090:		else
;1091:		{
line 1092
;1092:			if ( ActivatingGoal != world )
ADDRFP4 8
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $585
line 1093
;1093:				DoResults( Goal, AP, ActivatingGoal->goal_result & TFGR_ADD_BONUSES );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
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
ADDRGP4 $582
JUMPV
LABELV $585
line 1095
;1094:			else
;1095:				DoResults( Goal, AP, 0 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 DoResults
CALLV
pop
line 1096
;1096:		}
line 1097
;1097:	} else
ADDRGP4 $582
JUMPV
LABELV $581
line 1098
;1098:	{
line 1099
;1099:		if ( Goal->else_goal )
ADDRFP4 0
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $587
line 1100
;1100:		{
line 1101
;1101:			te = Findgoal( Goal->else_goal );
ADDRFP4 0
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
line 1102
;1102:			if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $589
line 1103
;1103:				AttemptToActivate( te, AP, Goal );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 AttemptToActivate
CALLV
pop
LABELV $589
line 1104
;1104:		}
LABELV $587
line 1105
;1105:	}
LABELV $582
line 1106
;1106:}
LABELV $576
endproc AttemptToActivate 12 12
export DoGoalWork
proc DoGoalWork 20 12
line 1109
;1107:
;1108:void DoGoalWork( gedict_t * Goal, gedict_t * AP )
;1109:{
line 1113
;1110:	gedict_t *te;
;1111:	gedict_t *RI;
;1112:
;1113:	if ( Goal->activate_goal_no )
ADDRFP4 0
INDIRP4
CNSTI4 1172
ADDP4
INDIRI4
CNSTI4 0
EQI4 $592
line 1114
;1114:	{
line 1115
;1115:		te = Findgoal( Goal->activate_goal_no );
ADDRFP4 0
INDIRP4
CNSTI4 1172
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
line 1116
;1116:		if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $594
line 1117
;1117:			AttemptToActivate( te, AP, Goal );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 AttemptToActivate
CALLV
pop
LABELV $594
line 1118
;1118:	}
LABELV $592
line 1119
;1119:	if ( Goal->inactivate_goal_no )
ADDRFP4 0
INDIRP4
CNSTI4 1176
ADDP4
INDIRI4
CNSTI4 0
EQI4 $596
line 1120
;1120:	{
line 1121
;1121:		te = Findgoal( Goal->inactivate_goal_no );
ADDRFP4 0
INDIRP4
CNSTI4 1176
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
line 1122
;1122:		if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $598
line 1123
;1123:			InactivateGoal( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 InactivateGoal
CALLV
pop
LABELV $598
line 1124
;1124:	}
LABELV $596
line 1125
;1125:	if ( Goal->restore_goal_no )
ADDRFP4 0
INDIRP4
CNSTI4 1184
ADDP4
INDIRI4
CNSTI4 0
EQI4 $600
line 1126
;1126:	{
line 1127
;1127:		te = Findgoal( Goal->restore_goal_no );
ADDRFP4 0
INDIRP4
CNSTI4 1184
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
line 1128
;1128:		if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $602
line 1129
;1129:			RestoreGoal( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RestoreGoal
CALLV
pop
LABELV $602
line 1130
;1130:	}
LABELV $600
line 1131
;1131:	if ( Goal->remove_goal_no )
ADDRFP4 0
INDIRP4
CNSTI4 1180
ADDP4
INDIRI4
CNSTI4 0
EQI4 $604
line 1132
;1132:	{
line 1133
;1133:		te = Findgoal( Goal->remove_goal_no );
ADDRFP4 0
INDIRP4
CNSTI4 1180
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
line 1134
;1134:		if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $606
line 1135
;1135:			RemoveGoal( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RemoveGoal
CALLV
pop
LABELV $606
line 1136
;1136:	}
LABELV $604
line 1137
;1137:	if ( Goal->return_item_no )
ADDRFP4 0
INDIRP4
CNSTI4 1240
ADDP4
INDIRI4
CNSTI4 0
EQI4 $608
line 1138
;1138:	{
line 1139
;1139:		te = Finditem( Goal->return_item_no );
ADDRFP4 0
INDIRP4
CNSTI4 1240
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 Finditem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1140
;1140:		if ( te != world )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $610
line 1141
;1141:		{
line 1142
;1142:			if ( te->goal_state == TFGS_ACTIVE )
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 1
NEI4 $612
line 1143
;1143:				tfgoalitem_RemoveFromPlayer( te, PROG_TO_EDICT( te->s.v.owner ), 1 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 tfgoalitem_RemoveFromPlayer
CALLV
pop
LABELV $612
line 1144
;1144:			RI = spawn(  );
ADDRLP4 16
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 1145
;1145:			RI->s.v.enemy = EDICT_TO_PROG( te );
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
line 1146
;1146:			RI->s.v.weapon = 2;
ADDRLP4 4
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1073741824
ASGNF4
line 1147
;1147:			RI->s.v.think = ( func_t ) ReturnItem;
ADDRLP4 4
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 ReturnItem
CVPU4 4
CVUI4 4
ASGNI4
line 1148
;1148:			RI->s.v.nextthink = g_globalvars.time + 0.1;
ADDRLP4 4
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1149
;1149:			te->s.v.solid = SOLID_NOT;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 1150
;1150:		}
LABELV $610
line 1151
;1151:	}
LABELV $608
line 1152
;1152:	if ( Goal->remove_spawnpoint )
ADDRFP4 0
INDIRP4
CNSTI4 1252
ADDP4
INDIRI4
CNSTI4 0
EQI4 $615
line 1153
;1153:	{
line 1154
;1154:		te = Findteamspawn( Goal->remove_spawnpoint );
ADDRFP4 0
INDIRP4
CNSTI4 1252
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 Findteamspawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1155
;1155:		if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $617
line 1156
;1156:		{
line 1157
;1157:			te->goal_state = TFGS_REMOVED;
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 3
ASGNI4
line 1158
;1158:			te->team_str_home = "";
ADDRLP4 0
INDIRP4
CNSTI4 1284
ADDP4
ADDRGP4 $128
ASGNP4
line 1159
;1159:		}
LABELV $617
line 1160
;1160:	}
LABELV $615
line 1161
;1161:	if ( Goal->restore_spawnpoint )
ADDRFP4 0
INDIRP4
CNSTI4 1256
ADDP4
INDIRI4
CNSTI4 0
EQI4 $619
line 1162
;1162:	{
line 1163
;1163:		te = Findteamspawn( Goal->restore_spawnpoint );
ADDRFP4 0
INDIRP4
CNSTI4 1256
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 Findteamspawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1164
;1164:		if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $621
line 1165
;1165:		{
line 1166
;1166:			if ( te->goal_state == TFGS_REMOVED )
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 3
NEI4 $623
line 1167
;1167:			{
line 1168
;1168:				te->goal_state = TFGS_INACTIVE;
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
line 1169
;1169:				te->team_str_home = (char*)team_spawn_str[te->team_no];
ADDRLP4 0
INDIRP4
CNSTI4 1284
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 team_spawn_str
ADDP4
INDIRP4
ASGNP4
line 1170
;1170:			}
LABELV $623
line 1171
;1171:		}
LABELV $621
line 1172
;1172:	}
LABELV $619
line 1173
;1173:}
LABELV $591
endproc DoGoalWork 20 12
export DoGroupWork
proc DoGroupWork 16 12
line 1176
;1174:
;1175:void DoGroupWork( gedict_t * Goal, gedict_t * AP )
;1176:{
line 1180
;1177:	gedict_t *tg;
;1178:	float   allset;
;1179:
;1180:	if ( Goal->all_active )
ADDRFP4 0
INDIRP4
CNSTI4 1380
ADDP4
INDIRI4
CNSTI4 0
EQI4 $626
line 1181
;1181:	{
line 1182
;1182:		if ( !Goal->last_impulse )
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
INDIRI4
CNSTI4 0
NEI4 $628
line 1183
;1183:		{
line 1184
;1184:			G_dprintf( "Goal %d has a .all_active specified, but no .last_impulse\n", Goal->goal_no );
ADDRGP4 $630
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1112
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_dprintf
CALLV
pop
line 1185
;1185:		} else
ADDRGP4 $629
JUMPV
LABELV $628
line 1186
;1186:		{
line 1187
;1187:			allset = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1188
;1188:			tg = trap_find( world, FOFS( s.v.classname ), "info_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $632
JUMPV
LABELV $631
line 1190
;1189:			while ( tg )
;1190:			{
line 1191
;1191:				if ( tg->group_no == Goal->all_active )
ADDRLP4 0
INDIRP4
CNSTI4 1116
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1380
ADDP4
INDIRI4
NEI4 $634
line 1192
;1192:				{
line 1193
;1193:					if ( tg->goal_state != TFGS_ACTIVE )
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 1
EQI4 $636
line 1194
;1194:						allset = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
LABELV $636
line 1195
;1195:				}
LABELV $634
line 1196
;1196:				tg = trap_find( tg, FOFS( s.v.classname ), "info_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1197
;1197:			}
LABELV $632
line 1189
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $631
line 1198
;1198:			if ( allset )
ADDRLP4 4
INDIRF4
CNSTF4 0
EQF4 $638
line 1199
;1199:			{
line 1200
;1200:				tg = Findgoal( Goal->last_impulse );
ADDRFP4 0
INDIRP4
CNSTI4 688
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
line 1201
;1201:				if ( tg )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $640
line 1202
;1202:					DoResults( tg, AP, Goal->goal_result & TFGR_ADD_BONUSES );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
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
LABELV $640
line 1203
;1203:			}
LABELV $638
line 1204
;1204:		}
LABELV $629
line 1205
;1205:	}
LABELV $626
line 1206
;1206:	if ( Goal->activate_group_no )
ADDRFP4 0
INDIRP4
CNSTI4 1188
ADDP4
INDIRI4
CNSTI4 0
EQI4 $642
line 1207
;1207:	{
line 1208
;1208:		tg = trap_find( world, FOFS( s.v.classname ), "info_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $645
JUMPV
LABELV $644
line 1210
;1209:		while ( tg )
;1210:		{
line 1211
;1211:			if ( tg->group_no == Goal->activate_group_no )
ADDRLP4 0
INDIRP4
CNSTI4 1116
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1188
ADDP4
INDIRI4
NEI4 $647
line 1212
;1212:				DoResults( tg, AP, 0 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 DoResults
CALLV
pop
LABELV $647
line 1213
;1213:			tg = trap_find( tg, FOFS( s.v.classname ), "info_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1214
;1214:		}
LABELV $645
line 1209
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $644
line 1215
;1215:	}
LABELV $642
line 1216
;1216:	if ( Goal->inactivate_group_no )
ADDRFP4 0
INDIRP4
CNSTI4 1192
ADDP4
INDIRI4
CNSTI4 0
EQI4 $649
line 1217
;1217:	{
line 1218
;1218:		tg = trap_find( world, FOFS( s.v.classname ), "info_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $652
JUMPV
LABELV $651
line 1220
;1219:		while ( tg )
;1220:		{
line 1221
;1221:			if ( tg->group_no == Goal->inactivate_group_no )
ADDRLP4 0
INDIRP4
CNSTI4 1116
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1192
ADDP4
INDIRI4
NEI4 $654
line 1222
;1222:				InactivateGoal( tg );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 InactivateGoal
CALLV
pop
LABELV $654
line 1223
;1223:			tg = trap_find( tg, FOFS( s.v.classname ), "info_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1224
;1224:		}
LABELV $652
line 1219
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $651
line 1225
;1225:	}
LABELV $649
line 1226
;1226:	if ( Goal->remove_group_no )
ADDRFP4 0
INDIRP4
CNSTI4 1196
ADDP4
INDIRI4
CNSTI4 0
EQI4 $656
line 1227
;1227:	{
line 1228
;1228:		tg = trap_find( world, FOFS( s.v.classname ), "info_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $659
JUMPV
LABELV $658
line 1230
;1229:		while ( tg )
;1230:		{
line 1231
;1231:			if ( tg->group_no == Goal->remove_group_no )
ADDRLP4 0
INDIRP4
CNSTI4 1116
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1196
ADDP4
INDIRI4
NEI4 $661
line 1232
;1232:				RemoveGoal( tg );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RemoveGoal
CALLV
pop
LABELV $661
line 1233
;1233:			tg = trap_find( tg, FOFS( s.v.classname ), "info_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1234
;1234:		}
LABELV $659
line 1229
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $658
line 1235
;1235:	}
LABELV $656
line 1236
;1236:	if ( Goal->restore_group_no )
ADDRFP4 0
INDIRP4
CNSTI4 1200
ADDP4
INDIRI4
CNSTI4 0
EQI4 $663
line 1237
;1237:	{
line 1238
;1238:		tg = trap_find( world, FOFS( s.v.classname ), "info_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $666
JUMPV
LABELV $665
line 1240
;1239:		while ( tg )
;1240:		{
line 1241
;1241:			if ( tg->group_no == Goal->restore_group_no )
ADDRLP4 0
INDIRP4
CNSTI4 1116
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1200
ADDP4
INDIRI4
NEI4 $668
line 1242
;1242:				RestoreGoal( tg );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RestoreGoal
CALLV
pop
LABELV $668
line 1243
;1243:			tg = trap_find( tg, FOFS( s.v.classname ), "info_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1244
;1244:		}
LABELV $666
line 1239
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $665
line 1245
;1245:	}
LABELV $663
line 1246
;1246:	if ( Goal->remove_spawngroup )
ADDRFP4 0
INDIRP4
CNSTI4 1260
ADDP4
INDIRI4
CNSTI4 0
EQI4 $670
line 1247
;1247:	{
line 1248
;1248:		tg = trap_find( world, FOFS( s.v.classname ), "info_player_teamspawn" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $80
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $673
JUMPV
LABELV $672
line 1250
;1249:		while ( tg )
;1250:		{
line 1251
;1251:			if ( tg->group_no == Goal->remove_spawngroup )
ADDRLP4 0
INDIRP4
CNSTI4 1116
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1260
ADDP4
INDIRI4
NEI4 $675
line 1252
;1252:			{
line 1253
;1253:				tg->goal_state = 3;
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 3
ASGNI4
line 1254
;1254:				tg->team_str_home = "";
ADDRLP4 0
INDIRP4
CNSTI4 1284
ADDP4
ADDRGP4 $128
ASGNP4
line 1255
;1255:			}
LABELV $675
line 1256
;1256:			tg = trap_find( tg, FOFS( s.v.classname ), "info_player_teamspawn" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $80
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1257
;1257:		}
LABELV $673
line 1249
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $672
line 1258
;1258:	}
LABELV $670
line 1259
;1259:	if ( Goal->restore_spawngroup )
ADDRFP4 0
INDIRP4
CNSTI4 1264
ADDP4
INDIRI4
CNSTI4 0
EQI4 $677
line 1260
;1260:	{
line 1261
;1261:		tg = trap_find( world, FOFS( s.v.classname ), "info_player_teamspawn" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $80
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $680
JUMPV
LABELV $679
line 1263
;1262:		while ( tg )
;1263:		{
line 1264
;1264:			if ( tg->group_no == Goal->restore_spawngroup )
ADDRLP4 0
INDIRP4
CNSTI4 1116
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1264
ADDP4
INDIRI4
NEI4 $682
line 1265
;1265:			{
line 1266
;1266:				tg->goal_state = 2;
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
line 1267
;1267:				tg->team_str_home = (char*)team_spawn_str[tg->team_no];
ADDRLP4 0
INDIRP4
CNSTI4 1284
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 team_spawn_str
ADDP4
INDIRP4
ASGNP4
line 1268
;1268:			}
LABELV $682
line 1269
;1269:			tg = trap_find( tg, FOFS( s.v.classname ), "info_player_teamspawn" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $80
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1270
;1270:		}
LABELV $680
line 1262
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $679
line 1271
;1271:	}
LABELV $677
line 1272
;1272:}
LABELV $625
endproc DoGroupWork 16 12
export DoItemGroupWork
proc DoItemGroupWork 20 12
line 1275
;1273:
;1274:void DoItemGroupWork( gedict_t * Item, gedict_t * AP )
;1275:{
line 1280
;1276:	gedict_t *tg;
;1277:	gedict_t *carrier;
;1278:	float   allcarried;
;1279:
;1280:	allcarried = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1281
;1281:	if ( Item->distance )
ADDRFP4 0
INDIRP4
CNSTI4 1104
ADDP4
INDIRI4
CNSTI4 0
EQI4 $685
line 1282
;1282:	{
line 1283
;1283:		if ( !Item->pain_finished )
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRF4
CNSTF4 0
NEF4 $687
line 1284
;1284:		{
line 1285
;1285:			G_dprintf( "GoalItem %d has a .distance specified, but no .pain_finished\n", Item->goal_no );
ADDRGP4 $689
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1112
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_dprintf
CALLV
pop
line 1286
;1286:		}
LABELV $687
line 1287
;1287:		tg = trap_find( world, FOFS( s.v.classname ), "item_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
ADDRGP4 $691
JUMPV
LABELV $690
line 1289
;1288:		while ( tg )
;1289:		{
line 1290
;1290:			if ( tg->group_no == Item->distance )
ADDRLP4 0
INDIRP4
CNSTI4 1116
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1104
ADDP4
INDIRI4
NEI4 $693
line 1291
;1291:			{
line 1292
;1292:				if ( tg->goal_state != TFGS_ACTIVE )
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 1
EQI4 $695
line 1293
;1293:					allcarried = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
LABELV $695
line 1294
;1294:			}
LABELV $693
line 1295
;1295:			tg = trap_find( tg, FOFS( s.v.classname ), "item_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 1296
;1296:		}
LABELV $691
line 1288
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $690
line 1297
;1297:		if ( allcarried == 1 )
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
NEF4 $697
line 1298
;1298:		{
line 1299
;1299:			tg = Findgoal( Item->pain_finished );
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 16
ADDRGP4 Findgoal
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 1300
;1300:			if ( tg )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $699
line 1301
;1301:				DoResults( tg, AP, Item->goal_result & TFGR_ADD_BONUSES );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
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
LABELV $699
line 1302
;1302:		}
LABELV $697
line 1303
;1303:	}
LABELV $685
line 1304
;1304:	allcarried = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1305
;1305:	if ( Item->speed )
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
CNSTF4 0
EQF4 $701
line 1306
;1306:	{
line 1307
;1307:		if ( !Item->attack_finished )
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
CNSTF4 0
NEF4 $703
line 1308
;1308:		{
line 1309
;1309:			G_dprintf( "GoalItem %d has a ->speed  specified, but no .attack_finished\n", Item->goal_no );
ADDRGP4 $705
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1112
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_dprintf
CALLV
pop
line 1310
;1310:		}
LABELV $703
line 1311
;1311:		carrier = world;
ADDRLP4 8
ADDRGP4 world
INDIRP4
ASGNP4
line 1312
;1312:		tg = trap_find( world, FOFS( s.v.classname ), "item_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
ADDRGP4 $707
JUMPV
LABELV $706
line 1314
;1313:		while ( tg )
;1314:		{
line 1315
;1315:			if ( tg->group_no == Item->speed )
ADDRLP4 0
INDIRP4
CNSTI4 1116
ADDP4
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRF4
NEF4 $709
line 1316
;1316:			{
line 1317
;1317:				if ( tg->goal_state != TFGS_ACTIVE )
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 1
EQI4 $711
line 1318
;1318:					allcarried = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRGP4 $712
JUMPV
LABELV $711
line 1320
;1319:				else
;1320:				{
line 1321
;1321:					if ( carrier == world )
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
NEU4 $713
line 1322
;1322:						carrier = PROG_TO_EDICT( tg->s.v.owner );
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
ADDRGP4 $714
JUMPV
LABELV $713
line 1324
;1323:					else
;1324:					{
line 1325
;1325:						if ( carrier != PROG_TO_EDICT( tg->s.v.owner ) )
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
EQU4 $715
line 1326
;1326:							allcarried = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
LABELV $715
line 1327
;1327:					}
LABELV $714
line 1328
;1328:				}
LABELV $712
line 1329
;1329:			}
LABELV $709
line 1330
;1330:			tg = trap_find( tg, FOFS( s.v.classname ), "item_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 1331
;1331:		}
LABELV $707
line 1313
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $706
line 1332
;1332:		if ( allcarried == 1 )
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
NEF4 $717
line 1333
;1333:		{
line 1334
;1334:			tg = Findgoal( Item->attack_finished );
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 16
ADDRGP4 Findgoal
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 1335
;1335:			if ( tg )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $719
line 1336
;1336:				DoResults( tg, AP, Item->goal_result & TFGR_ADD_BONUSES );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
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
LABELV $719
line 1337
;1337:		}
LABELV $717
line 1338
;1338:	}
LABELV $701
line 1339
;1339:}
LABELV $684
endproc DoItemGroupWork 20 12
export DoTriggerWork
proc DoTriggerWork 16 12
line 1342
;1340:
;1341:void DoTriggerWork( gedict_t * Goal, gedict_t * AP )
;1342:{
line 1345
;1343:	gedict_t *t, *stemp, *otemp;
;1344:
;1345:	if ( Goal->killtarget )
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $722
line 1346
;1346:	{
line 1347
;1347:		t = world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
LABELV $724
line 1349
;1348:		do
;1349:		{
line 1350
;1350:			t = trap_find( t, FOFS( s.v.targetname ), Goal->killtarget );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 464
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1351
;1351:			if ( t )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $727
line 1352
;1352:				ent_remove( t );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ent_remove
CALLV
pop
LABELV $727
line 1353
;1353:		}
LABELV $725
line 1354
;1354:		while ( t );
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $724
line 1355
;1355:	}
LABELV $722
line 1356
;1356:	if ( Goal->s.v.target )
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $729
line 1357
;1357:	{
line 1358
;1358:		t = world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
line 1359
;1359:		activator = AP;
ADDRGP4 activator
ADDRFP4 4
INDIRP4
ASGNP4
LABELV $731
line 1361
;1360:		do
;1361:		{
line 1362
;1362:			t = trap_find( t, FOFS( s.v.targetname ), Goal->s.v.target );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 464
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1363
;1363:			if ( !t )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $734
line 1364
;1364:				return;
ADDRGP4 $721
JUMPV
LABELV $734
line 1365
;1365:			stemp = self;
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
line 1366
;1366:			otemp = other;
ADDRLP4 8
ADDRGP4 other
INDIRP4
ASGNP4
line 1367
;1367:			self = t;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 1368
;1368:			other = stemp;
ADDRGP4 other
ADDRLP4 4
INDIRP4
ASGNP4
line 1369
;1369:			if ( self->s.v.use )
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 0
EQI4 $736
line 1370
;1370:				( ( void ( * )(  ) ) ( self->s.v.use ) ) (  );
ADDRGP4 self
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CVIU4 4
CVUP4 4
CALLV
pop
LABELV $736
line 1371
;1371:			self = stemp;
ADDRGP4 self
ADDRLP4 4
INDIRP4
ASGNP4
line 1372
;1372:			other = otemp;
ADDRGP4 other
ADDRLP4 8
INDIRP4
ASGNP4
line 1373
;1373:			activator = AP;
ADDRGP4 activator
ADDRFP4 4
INDIRP4
ASGNP4
line 1374
;1374:		}
LABELV $732
line 1375
;1375:		while ( t );
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $731
line 1376
;1376:	}
LABELV $729
line 1377
;1377:}
LABELV $721
endproc DoTriggerWork 16 12
export DelayedResult
proc DelayedResult 8 12
line 1380
;1378:
;1379:void DelayedResult(  )
;1380:{
line 1381
;1381:	if ( PROG_TO_EDICT( self->s.v.enemy )->goal_state == TFGS_DELAYED )
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts+1120
ADDP4
INDIRI4
CNSTI4 4
NEI4 $739
line 1382
;1382:		DoResults( PROG_TO_EDICT( self->s.v.enemy ), PROG_TO_EDICT( self->s.v.owner ), self->s.v.weapon );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
ADDRGP4 g_edicts
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
ARGF4
ADDRGP4 DoResults
CALLV
pop
LABELV $739
line 1383
;1383:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1384
;1384:}
LABELV $738
endproc DelayedResult 8 12
data
align 4
LABELV $743
address $744
align 4
LABELV $745
address $746
align 4
LABELV $747
address $748
address $749
address $750
address $750
address $750
address $750
address $750
address $751
address $752
address $752
address $753
lit
align 4
LABELV $754
byte 4 11
export DoResults
code
proc DoResults 72 20
line 1387
;1385:
;1386:void DoResults( gedict_t * Goal, gedict_t * AP, float addb )
;1387:{
line 1410
;1388:	gedict_t *te;
;1389:	float   winners;
;1390://	float   gotone;
;1391:        static const char *ctf_msg_your_team_gotflag = "\n\n\nYour team гот the енемы flag!!";
;1392:        static const char *ctf_msg_your_flag_taken   = "\n\n\nYour flag has been такен!!";
;1393:        static const char *ctf_msgs_you_take_flag[] = {
;1394:                 "\n\n\nYou got the enemy flag!\n\nFlee!" ,
;1395:                 "\n\n\nYou got the enemy flag!\n\nHead for home!" ,
;1396:                 "\n\n\nYou got the enemy flag!\n\nReturn to base!" ,
;1397:                 "\n\n\nYou got the enemy flag!\n\nReturn to base!" ,
;1398:                 "\n\n\nYou got the enemy flag!\n\nReturn to base!" ,
;1399:                 "\n\n\nYou got the enemy flag!\n\nReturn to base!" ,
;1400:                 "\n\n\nYou got the enemy flag!\n\nReturn to base!" ,
;1401:                 "\n\n\nYou got the enemy flag!\n\n<Insert witty comment here>" ,
;1402:                 "\n\n\nYou got the enemy flag!\n\n" ,
;1403:                 "\n\n\nYou got the enemy flag!\n\n" ,
;1404:                 "\n\n\nIs that a flag in your pocket\nor a you just happy to see me?" 
;1405:        };
;1406:        
;1407:        static const int num_ctf_msgs = sizeof(ctf_msgs_you_take_flag)/sizeof(ctf_msgs_you_take_flag[0]);
;1408:
;1409:
;1410:	if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $755
line 1411
;1411:		return;
ADDRGP4 $742
JUMPV
LABELV $755
line 1412
;1412:	if ( Goal->goal_state == TFGS_ACTIVE )
ADDRFP4 0
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 1
NEI4 $759
line 1413
;1413:		return;
ADDRGP4 $742
JUMPV
LABELV $759
line 1414
;1414:	if ( Goal->delay_time > 0 && Goal->goal_state != TFGS_DELAYED )
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 1388
ADDP4
INDIRF4
CNSTF4 0
LEF4 $761
ADDRLP4 8
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 4
EQI4 $761
line 1415
;1415:	{
line 1416
;1416:		Goal->goal_state = 4;
ADDRFP4 0
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 4
ASGNI4
line 1417
;1417:		te = spawn(  );
ADDRLP4 12
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1418
;1418:		te->s.v.think = ( func_t ) DelayedResult;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 DelayedResult
CVPU4 4
CVUI4 4
ASGNI4
line 1419
;1419:		te->s.v.nextthink = g_globalvars.time + Goal->delay_time;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1388
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1420
;1420:		te->s.v.owner = EDICT_TO_PROG( AP );
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
line 1421
;1421:		te->s.v.enemy = EDICT_TO_PROG( Goal );
ADDRLP4 0
INDIRP4
CNSTI4 400
ADDP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 1422
;1422:		te->s.v.weapon = addb;
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
ADDRFP4 8
INDIRF4
ASGNF4
line 1423
;1423:		return;
ADDRGP4 $742
JUMPV
LABELV $761
line 1425
;1424:	}
;1425:	UpdateAbbreviations( Goal );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 UpdateAbbreviations
CALLV
pop
line 1426
;1426:	Goal->goal_state = 2;
ADDRFP4 0
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
line 1427
;1427:	if ( streq( Goal->s.v.classname, "info_tfgoal" ) && Goal->mdl )
ADDRFP4 0
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
EQI4 $764
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $764
line 1428
;1428:		setmodel( Goal, "" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $128
ARGP4
ADDRGP4 setmodel
CALLV
pop
LABELV $764
line 1429
;1429:	if ( Goal->s.v.noise )
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $766
line 1430
;1430:		sound( other, 3, Goal->s.v.noise, 1, 1 );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 504
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
LABELV $766
line 1431
;1431:	winners = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 1432
;1432:	if ( Goal->increase_team1 )
ADDRFP4 0
INDIRP4
CNSTI4 1316
ADDP4
INDIRI4
CNSTI4 0
EQI4 $768
line 1433
;1433:	{
line 1434
;1434:		TeamFortress_TeamIncreaseScore( 1, Goal->increase_team1 );
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 1316
ADDP4
INDIRI4
ARGI4
ADDRGP4 TeamFortress_TeamIncreaseScore
CALLV
pop
line 1435
;1435:		winners = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1436
;1436:	}
LABELV $768
line 1437
;1437:	if ( Goal->increase_team2 )
ADDRFP4 0
INDIRP4
CNSTI4 1320
ADDP4
INDIRI4
CNSTI4 0
EQI4 $770
line 1438
;1438:	{
line 1439
;1439:		TeamFortress_TeamIncreaseScore( 2, Goal->increase_team2 );
CNSTI4 2
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 1320
ADDP4
INDIRI4
ARGI4
ADDRGP4 TeamFortress_TeamIncreaseScore
CALLV
pop
line 1440
;1440:		winners = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1441
;1441:	}
LABELV $770
line 1442
;1442:	if ( Goal->increase_team3 )
ADDRFP4 0
INDIRP4
CNSTI4 1324
ADDP4
INDIRI4
CNSTI4 0
EQI4 $772
line 1443
;1443:	{
line 1444
;1444:		TeamFortress_TeamIncreaseScore( 3, Goal->increase_team3 );
CNSTI4 3
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 1324
ADDP4
INDIRI4
ARGI4
ADDRGP4 TeamFortress_TeamIncreaseScore
CALLV
pop
line 1445
;1445:		winners = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1446
;1446:	}
LABELV $772
line 1447
;1447:	if ( Goal->increase_team4 )
ADDRFP4 0
INDIRP4
CNSTI4 1328
ADDP4
INDIRI4
CNSTI4 0
EQI4 $774
line 1448
;1448:	{
line 1449
;1449:		TeamFortress_TeamIncreaseScore( 4, Goal->increase_team4 );
CNSTI4 4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 1328
ADDP4
INDIRI4
ARGI4
ADDRGP4 TeamFortress_TeamIncreaseScore
CALLV
pop
line 1450
;1450:		winners = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1451
;1451:	}
LABELV $774
line 1452
;1452:	if ( winners == 1 )
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
NEF4 $776
line 1453
;1453:		TeamFortress_TeamShowScores( 2 );
CNSTI4 2
ARGI4
ADDRGP4 TeamFortress_TeamShowScores
CALLV
pop
LABELV $776
line 1454
;1454:	if ( CTF_Map == 1 && AP && AP != world )
ADDRGP4 CTF_Map
INDIRI4
CNSTI4 1
NEI4 $778
ADDRLP4 20
ADDRFP4 4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 20
INDIRU4
CNSTU4 0
EQU4 $778
ADDRLP4 20
INDIRU4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $778
line 1455
;1455:	{
line 1456
;1456:                switch( Goal->goal_no ) 
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 1112
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 1
LTI4 $780
ADDRLP4 24
INDIRI4
CNSTI4 4
GTI4 $780
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $827-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $827
address $783
address $794
address $804
address $817
code
line 1457
;1457:                {
LABELV $783
line 1459
;1458:                      case 1:
;1459:  			for( te = world; (te = trap_find( te, FOFS( s.v.classname ), "player" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $787
JUMPV
LABELV $784
line 1460
;1460:  			{
line 1461
;1461:  				if ( te->team_no == 2 )
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 2
NEI4 $789
line 1462
;1462:  				{
line 1463
;1463:  					if ( te == AP )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $791
line 1464
;1464:  					{
line 1465
;1465:  					        CenterPrint( te, ctf_msgs_you_take_flag[(int)g_random()*num_ctf_msgs]);
ADDRLP4 32
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 32
INDIRF4
CVFI4 4
ADDRGP4 $754
INDIRI4
MULI4
CNSTI4 2
LSHI4
ADDRGP4 $747
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 1466
;1466:  					} else
ADDRGP4 $790
JUMPV
LABELV $791
line 1467
;1467:  						CenterPrint( te, ctf_msg_your_team_gotflag );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $743
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 1468
;1468:  				} else
ADDRGP4 $790
JUMPV
LABELV $789
line 1469
;1469:  					CenterPrint( te, ctf_msg_your_flag_taken );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $745
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
LABELV $790
line 1470
;1470:  			}
LABELV $785
line 1459
LABELV $787
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $788
ARGP4
ADDRLP4 32
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $784
line 1471
;1471:  			G_bprint( 2, "%s гот the блуе flag!\n", AP->s.v.netname );
CNSTI4 2
ARGI4
ADDRGP4 $793
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 1472
;1472:  			AP->s.v.items = ( int ) AP->s.v.items | IT_KEY1;
ADDRLP4 36
ADDRFP4 4
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 131072
BORI4
CVIF4 4
ASGNF4
line 1473
;1473:                        break;
ADDRGP4 $781
JUMPV
LABELV $794
line 1475
;1474:                      case 2:
;1475:  			for( te = world; (te = trap_find( te, FOFS( s.v.classname ), "player" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $798
JUMPV
LABELV $795
line 1476
;1476:  			{
line 1477
;1477:  				if ( te->team_no == 1 )
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 1
NEI4 $799
line 1478
;1478:  				{
line 1479
;1479:  					if ( te == AP )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $801
line 1480
;1480:  					{
line 1481
;1481:  					        CenterPrint( te, ctf_msgs_you_take_flag[(int)g_random()*num_ctf_msgs]);
ADDRLP4 40
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 40
INDIRF4
CVFI4 4
ADDRGP4 $754
INDIRI4
MULI4
CNSTI4 2
LSHI4
ADDRGP4 $747
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 1482
;1482:  					} else
ADDRGP4 $800
JUMPV
LABELV $801
line 1483
;1483:  						CenterPrint( te, ctf_msg_your_team_gotflag );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $743
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 1484
;1484:  				} else
ADDRGP4 $800
JUMPV
LABELV $799
line 1485
;1485:  					CenterPrint( te, ctf_msg_your_flag_taken );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $745
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
LABELV $800
line 1486
;1486:  			}
LABELV $796
line 1475
LABELV $798
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $788
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
NEU4 $795
line 1487
;1487:  			G_bprint( 2, "%s гот the ред flag!\n", AP->s.v.netname );
CNSTI4 2
ARGI4
ADDRGP4 $803
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 1488
;1488:  			AP->s.v.items = ( int ) AP->s.v.items | IT_KEY2;
ADDRLP4 44
ADDRFP4 4
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 262144
BORI4
CVIF4 4
ASGNF4
line 1489
;1489:                        break;
ADDRGP4 $781
JUMPV
LABELV $804
line 1491
;1490:                      case 3:
;1491:  			for( te = world; (te = trap_find( te, FOFS( s.v.classname ), "player" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $808
JUMPV
LABELV $805
line 1492
;1492:  			{
line 1493
;1493:       				if ( te->team_no == 2 )
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 2
NEI4 $809
line 1494
;1494:       				{
line 1495
;1495:       					if ( te == AP )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $811
line 1496
;1496:       						CenterPrint( te,"\n\n\nYou цаптуред the flag!!" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $813
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
ADDRGP4 $810
JUMPV
LABELV $811
line 1498
;1497:       					else
;1498:       						CenterPrint( te,"\n\n\nYour flag was цаптуред!!" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $814
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 1499
;1499:       				} else
ADDRGP4 $810
JUMPV
LABELV $809
line 1500
;1500:       					CenterPrint( te, "\n\n\nYour team цаптуред the flag!!" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $815
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
LABELV $810
line 1501
;1501:       			}
LABELV $806
line 1491
LABELV $808
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $788
ARGP4
ADDRLP4 48
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 48
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $805
line 1502
;1502:       			G_bprint( 2, "%s цаптуред the ред flag!\n", AP->s.v.netname );
CNSTI4 2
ARGI4
ADDRGP4 $816
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 1503
;1503:       			AP->s.v.items = AP->s.v.items - ( ( int ) AP->s.v.items & IT_KEY2 );
ADDRLP4 52
ADDRFP4 4
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 56
ADDRLP4 52
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 52
INDIRP4
ADDRLP4 56
INDIRF4
ADDRLP4 56
INDIRF4
CVFI4 4
CNSTI4 262144
BANDI4
CVIF4 4
SUBF4
ASGNF4
line 1504
;1504:                        break;
ADDRGP4 $781
JUMPV
LABELV $817
line 1506
;1505:                      case 4:
;1506:  			for( te = world; (te = trap_find( te, FOFS( s.v.classname ), "player" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $821
JUMPV
LABELV $818
line 1507
;1507:  			{
line 1508
;1508:       				if ( te->team_no == 1 )
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 1
NEI4 $822
line 1509
;1509:       				{
line 1510
;1510:       					if ( te == AP )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $824
line 1511
;1511:       						CenterPrint( te,"\n\n\nYou цаптуред the flag!!" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $813
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
ADDRGP4 $823
JUMPV
LABELV $824
line 1513
;1512:       					else
;1513:       						CenterPrint( te,"\n\n\nYour flag was цаптуред!!" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $814
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 1514
;1514:       				} else
ADDRGP4 $823
JUMPV
LABELV $822
line 1515
;1515:       					CenterPrint( te, "\n\n\nYour team цаптуред the flag!!" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $815
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
LABELV $823
line 1516
;1516:       			}
LABELV $819
line 1506
LABELV $821
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $788
ARGP4
ADDRLP4 60
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 60
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $818
line 1517
;1517:       			G_bprint( 2, "%s цаптуред the блуе flag!\n", AP->s.v.netname );
CNSTI4 2
ARGI4
ADDRGP4 $826
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 1518
;1518:       			AP->s.v.items = AP->s.v.items - ( ( int ) AP->s.v.items & IT_KEY1 );
ADDRLP4 64
ADDRFP4 4
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 68
ADDRLP4 64
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 64
INDIRP4
ADDRLP4 68
INDIRF4
ADDRLP4 68
INDIRF4
CVFI4 4
CNSTI4 131072
BANDI4
CVIF4 4
SUBF4
ASGNF4
line 1519
;1519:                        break;
LABELV $780
LABELV $781
line 1521
;1520:                }
;1521:	}
LABELV $778
line 1523
;1522://	gotone = 0;
;1523:	for( te = world; (te = trap_find( te, FOFS( s.v.classname ), "player" )); )        
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $832
JUMPV
LABELV $829
line 1524
;1524:	{
line 1525
;1525:		if ( Goal->broadcast && !CTF_Map )
ADDRFP4 0
INDIRP4
CNSTI4 1332
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $833
ADDRGP4 CTF_Map
INDIRI4
CNSTI4 0
NEI4 $833
line 1526
;1526:			CenterPrint( te, "\n\n\n%s", Goal->broadcast );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $835
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1332
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
LABELV $833
line 1527
;1527:		if ( Goal->netname_broadcast && !CTF_Map )
ADDRFP4 0
INDIRP4
CNSTI4 1348
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $836
ADDRGP4 CTF_Map
INDIRI4
CNSTI4 0
NEI4 $836
line 1528
;1528:		{
line 1529
;1529:			G_sprint( te, 2, AP->s.v.netname );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1530
;1530:			G_sprint( te, 2, Goal->netname_broadcast );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 1348
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1531
;1531:		}
LABELV $836
line 1532
;1532:		if ( AP == te )
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
NEU4 $838
line 1533
;1533:		{
line 1534
;1534:			if ( Goal->s.v.message )
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $839
line 1535
;1535:				CenterPrint( te, "\n\n\n%s", Goal->s.v.message );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $835
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 1536
;1536:		} else
ADDRGP4 $839
JUMPV
LABELV $838
line 1537
;1537:		{
line 1538
;1538:			if ( AP->team_no == te->team_no )
ADDRLP4 24
CNSTI4 960
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
NEI4 $842
line 1539
;1539:			{
line 1540
;1540:				if ( Goal->owners_team_broadcast && te->team_no == Goal->owned_by )
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 1344
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $844
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 1124
ADDP4
INDIRI4
NEI4 $844
line 1541
;1541:					CenterPrint( te, "\n\n\n%s", Goal->owners_team_broadcast );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $835
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1344
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
ADDRGP4 $845
JUMPV
LABELV $844
line 1543
;1542:				else
;1543:				{
line 1544
;1544:					if ( Goal->team_broadcast )
ADDRFP4 0
INDIRP4
CNSTI4 1336
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $846
line 1545
;1545:						CenterPrint( te, "\n\n\n%s", Goal->team_broadcast );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $835
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1336
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
LABELV $846
line 1546
;1546:				}
LABELV $845
line 1547
;1547:				if ( Goal->netname_owners_team_broadcast && te->team_no == Goal->owned_by )
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 1360
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $848
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 1124
ADDP4
INDIRI4
NEI4 $848
line 1548
;1548:				{
line 1549
;1549:					G_sprint( te, 2, "%s%s", AP->s.v.netname, Goal->netname_owners_team_broadcast );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $850
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1360
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1550
;1550:				} else
ADDRGP4 $843
JUMPV
LABELV $848
line 1551
;1551:				{
line 1552
;1552:					if ( Goal->netname_team_broadcast )
ADDRFP4 0
INDIRP4
CNSTI4 1352
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $843
line 1553
;1553:					{
line 1554
;1554:						G_sprint( te, 2, "%s%s", AP->s.v.netname,
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $850
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1352
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1556
;1555:							  Goal->netname_team_broadcast );
;1556:					}
line 1557
;1557:				}
line 1558
;1558:			} else
ADDRGP4 $843
JUMPV
LABELV $842
line 1559
;1559:			{
line 1560
;1560:				if ( Goal->owners_team_broadcast && te->team_no == Goal->owned_by )
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 1344
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $853
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 1124
ADDP4
INDIRI4
NEI4 $853
line 1561
;1561:					CenterPrint( te, "\n\n\n%s", Goal->owners_team_broadcast );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $835
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1344
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
ADDRGP4 $854
JUMPV
LABELV $853
line 1563
;1562:				else
;1563:				{
line 1564
;1564:					if ( Goal->non_team_broadcast )
ADDRFP4 0
INDIRP4
CNSTI4 1340
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $855
line 1565
;1565:						CenterPrint( te, "\n\n\n%s", Goal->non_team_broadcast );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $835
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1340
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
LABELV $855
line 1566
;1566:				}
LABELV $854
line 1567
;1567:				if ( Goal->netname_owners_team_broadcast && te->team_no == Goal->owned_by )
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 1360
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $857
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 1124
ADDP4
INDIRI4
NEI4 $857
line 1568
;1568:				{
line 1569
;1569:					G_sprint( te, 2, "%s%s", AP->s.v.netname, Goal->netname_owners_team_broadcast );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $850
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1360
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1570
;1570:				} else
ADDRGP4 $858
JUMPV
LABELV $857
line 1571
;1571:				{
line 1572
;1572:					if ( Goal->netname_non_team_broadcast )
ADDRFP4 0
INDIRP4
CNSTI4 1356
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $859
line 1573
;1573:					{
line 1574
;1574:						G_sprint( te, 2, "%s%s", AP->s.v.netname,
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $850
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1356
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1576
;1575:							  Goal->netname_non_team_broadcast );
;1576:					}
LABELV $859
line 1577
;1577:				}
LABELV $858
line 1578
;1578:			}
LABELV $843
line 1579
;1579:		}
LABELV $839
line 1580
;1580:		if ( IsAffectedBy( Goal, te, AP ) )
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 IsAffectedBy
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $861
line 1581
;1581:		{
line 1582
;1582:			if ( Goal->search_time && ( Goal->goal_effects & TFGE_TIMER_CHECK_AP ) )
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 1108
ADDP4
INDIRF4
CNSTF4 0
EQF4 $863
ADDRLP4 28
INDIRP4
CNSTI4 1132
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $863
line 1583
;1583:			{
line 1584
;1584:				if ( APMeetsCriteria( Goal, te ) )
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 APMeetsCriteria
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $864
line 1585
;1585:				{
line 1586
;1586:					Apply_Results( Goal, te, AP, addb );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRF4
ARGF4
ADDRGP4 Apply_Results
CALLV
pop
line 1588
;1587://					gotone = 1;
;1588:				}
line 1589
;1589:			} else
ADDRGP4 $864
JUMPV
LABELV $863
line 1590
;1590:			{
line 1591
;1591:				Apply_Results( Goal, te, AP, addb );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRF4
ARGF4
ADDRGP4 Apply_Results
CALLV
pop
line 1593
;1592://				gotone = 1;
;1593:			}
LABELV $864
line 1594
;1594:		}
LABELV $861
line 1595
;1595:	}
LABELV $830
line 1523
LABELV $832
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $788
ARGP4
ADDRLP4 24
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $829
line 1596
;1596:	if ( strneq( Goal->s.v.classname, "item_tfgoal" ) )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $220
ARGP4
ADDRLP4 28
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $867
line 1597
;1597:		Goal->goal_state = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 1
ASGNI4
LABELV $867
line 1598
;1598:	if ( Goal->goal_result & TFGR_ENDGAME )
ADDRFP4 0
INDIRP4
CNSTI4 1136
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $869
line 1599
;1599:	{
line 1600
;1600:		TeamFortress_TeamShowScores( 1 );
CNSTI4 1
ARGI4
ADDRGP4 TeamFortress_TeamShowScores
CALLV
pop
line 1601
;1601:		winners = TeamFortress_TeamGetWinner(  );
ADDRLP4 32
ADDRGP4 TeamFortress_TeamGetWinner
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 32
INDIRI4
CVIF4 4
ASGNF4
line 1602
;1602:		te = trap_find( world, FOFS( s.v.classname ), "player" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $788
ARGP4
ADDRLP4 36
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
ADDRGP4 $872
JUMPV
LABELV $871
line 1604
;1603:		while ( te )
;1604:		{
line 1605
;1605:			te->s.v.takedamage = 0;
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 0
ASGNF4
line 1606
;1606:			te->s.v.movetype = MOVETYPE_NONE;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 1607
;1607:			SetVector( te->s.v.velocity, 0, 0, 0 );
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
CNSTF4 0
ASGNF4
line 1608
;1608:			SetVector( te->s.v.avelocity, 0, 0, 0 );
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 0
ASGNF4
line 1609
;1609:			te = trap_find( te, FOFS( s.v.classname ), "player" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $788
ARGP4
ADDRLP4 40
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
ASGNP4
line 1610
;1610:		}
LABELV $872
line 1603
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $871
line 1611
;1611:		te = spawn(  );
ADDRLP4 40
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
ASGNP4
line 1612
;1612:		te->s.v.nextthink = g_globalvars.time + 5;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 1613
;1613:		te->s.v.think = ( func_t ) execute_changelevel;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 execute_changelevel
CVPU4 4
CVUI4 4
ASGNI4
line 1614
;1614:		dremove( Goal );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1615
;1615:		return;
ADDRGP4 $742
JUMPV
LABELV $869
line 1617
;1616:	}
;1617:	DoGroupWork( Goal, AP );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 DoGroupWork
CALLV
pop
line 1618
;1618:	DoGoalWork( Goal, AP );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 DoGoalWork
CALLV
pop
line 1619
;1619:	DoTriggerWork( Goal, AP );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 DoTriggerWork
CALLV
pop
line 1620
;1620:	if ( streq( Goal->s.v.classname, "info_tfgoal" ) )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $49
ARGP4
ADDRLP4 32
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $875
line 1621
;1621:		SetupRespawn( Goal );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 SetupRespawn
CALLV
pop
LABELV $875
line 1622
;1622:}
LABELV $742
endproc DoResults 72 20
export tfgoal_touch
proc tfgoal_touch 20 12
line 1625
;1623:
;1624:void tfgoal_touch(  )
;1625:{
line 1628
;1626:	gedict_t *te;
;1627:
;1628:	if( tf_data.arena_mode )
ADDRGP4 tf_data+188
INDIRI4
CNSTI4 0
EQI4 $878
line 1629
;1629:	        return;
ADDRGP4 $877
JUMPV
LABELV $878
line 1631
;1630:
;1631:	if ( !( self->goal_activation & TFGA_TOUCH ) )
ADDRGP4 self
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $881
line 1632
;1632:		return;
ADDRGP4 $877
JUMPV
LABELV $881
line 1633
;1633:	if ( strneq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $788
ARGP4
ADDRLP4 4
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $883
line 1634
;1634:		return;
ADDRGP4 $877
JUMPV
LABELV $883
line 1635
;1635:	if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $885
line 1636
;1636:		return;
ADDRGP4 $877
JUMPV
LABELV $885
line 1637
;1637:	if ( self->goal_state == TFGS_ACTIVE )
ADDRGP4 self
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 1
NEI4 $889
line 1638
;1638:		return;
ADDRGP4 $877
JUMPV
LABELV $889
line 1639
;1639:	if ( CTF_Map == 1 )
ADDRGP4 CTF_Map
INDIRI4
CNSTI4 1
NEI4 $891
line 1640
;1640:	{
line 1641
;1641:		if ( self->goal_no == 3 && other->team_no == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 1112
ADDP4
INDIRI4
CNSTI4 3
NEI4 $893
ADDRGP4 other
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 1
NEI4 $893
line 1642
;1642:		{
line 1643
;1643:			te = Finditem( 1 );
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 Finditem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1644
;1644:			if ( te->goal_state == TFGS_ACTIVE || !VectorCompare( te->s.v.origin, te->s.v.oldorigin ) )
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 1
EQI4 $897
ADDRLP4 12
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 168
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $895
LABELV $897
line 1645
;1645:				return;
ADDRGP4 $877
JUMPV
LABELV $895
line 1646
;1646:		}
LABELV $893
line 1647
;1647:		if ( self->goal_no == 4 && other->team_no == 2 )
ADDRGP4 self
INDIRP4
CNSTI4 1112
ADDP4
INDIRI4
CNSTI4 4
NEI4 $898
ADDRGP4 other
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 2
NEI4 $898
line 1648
;1648:		{
line 1649
;1649:			te = Finditem( 2 );
CNSTI4 2
ARGI4
ADDRLP4 8
ADDRGP4 Finditem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1650
;1650:			if ( te->goal_state == TFGS_ACTIVE || !VectorCompare( te->s.v.origin, te->s.v.oldorigin ) )
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 1
EQI4 $902
ADDRLP4 12
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 168
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $900
LABELV $902
line 1651
;1651:				return;
ADDRGP4 $877
JUMPV
LABELV $900
line 1652
;1652:		}
LABELV $898
line 1653
;1653:	}
LABELV $891
line 1654
;1654:	AttemptToActivate( self, other, self );
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 AttemptToActivate
CALLV
pop
line 1655
;1655:}
LABELV $877
endproc tfgoal_touch 20 12
export info_tfgoal_use
proc info_tfgoal_use 4 12
line 1658
;1656:
;1657:void info_tfgoal_use(  )
;1658:{
line 1659
;1659:	AttemptToActivate( self, activator, self );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 activator
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 AttemptToActivate
CALLV
pop
line 1660
;1660:}
LABELV $903
endproc info_tfgoal_use 4 12
export tfgoal_timer_tick
proc tfgoal_timer_tick 8 12
line 1663
;1661:
;1662:void tfgoal_timer_tick(  )
;1663:{
line 1664
;1664:	if ( self->goal_state != TFGS_REMOVED )
ADDRGP4 self
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 3
EQI4 $905
line 1665
;1665:	{
line 1666
;1666:		if ( APMeetsCriteria( self, world ) )
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 world
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 APMeetsCriteria
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $907
line 1667
;1667:			DoResults( self, world, 1 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 world
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 DoResults
CALLV
pop
ADDRGP4 $908
JUMPV
LABELV $907
line 1669
;1668:		else
;1669:		{
line 1670
;1670:			InactivateGoal( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 InactivateGoal
CALLV
pop
line 1671
;1671:			self->s.v.think = ( func_t ) tfgoal_timer_tick;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 tfgoal_timer_tick
CVPU4 4
CVUI4 4
ASGNI4
line 1672
;1672:			self->s.v.nextthink = g_globalvars.time + self->search_time;
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 1108
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1673
;1673:		}
LABELV $908
line 1674
;1674:	}
LABELV $905
line 1675
;1675:}
LABELV $904
endproc tfgoal_timer_tick 8 12
export item_tfgoal_touch
proc item_tfgoal_touch 32 20
line 1678
;1676:
;1677:void item_tfgoal_touch(  )
;1678:{
line 1681
;1679:	gedict_t *te;
;1680:
;1681:	if( tf_data.arena_mode )
ADDRGP4 tf_data+188
INDIRI4
CNSTI4 0
EQI4 $911
line 1682
;1682:	        return;
ADDRGP4 $910
JUMPV
LABELV $911
line 1684
;1683:
;1684:	if ( strneq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $788
ARGP4
ADDRLP4 4
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $914
line 1685
;1685:		return;
ADDRGP4 $910
JUMPV
LABELV $914
line 1686
;1686:	if ( other->s.v.health <= 0 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $916
line 1687
;1687:		return;
ADDRGP4 $910
JUMPV
LABELV $916
line 1688
;1688:	if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $918
line 1689
;1689:		return;
ADDRGP4 $910
JUMPV
LABELV $918
line 1690
;1690:	if ( other == PROG_TO_EDICT( self->s.v.owner ) )
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
NEU4 $922
line 1691
;1691:		return;
ADDRGP4 $910
JUMPV
LABELV $922
line 1692
;1692:	if ( other->is_feigning )
ADDRGP4 other
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
EQI4 $924
line 1693
;1693:		return;
ADDRGP4 $910
JUMPV
LABELV $924
line 1695
;1694:
;1695:	if ( self->take_sshot )
ADDRGP4 self
INDIRP4
CNSTI4 1532
ADDP4
INDIRI4
CNSTI4 0
EQI4 $926
line 1696
;1696:	{
line 1697
;1697:	        return;
ADDRGP4 $910
JUMPV
LABELV $926
line 1700
;1698:	}
;1699:
;1700:	if ( CTF_Map == 1 )
ADDRGP4 CTF_Map
INDIRI4
CNSTI4 1
NEI4 $928
line 1701
;1701:	{
line 1702
;1702:		if ( self->goal_no == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 1112
ADDP4
INDIRI4
CNSTI4 1
NEI4 $930
line 1703
;1703:		{
line 1704
;1704:			if ( !VectorCompare( self->s.v.origin, self->s.v.oldorigin ) )
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $932
line 1705
;1705:			{
line 1706
;1706:				if ( other->team_no == 1 )
ADDRGP4 other
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 1
NEI4 $931
line 1707
;1707:				{
line 1708
;1708:					G_bprint( 2, "%s ретурнед the блуе flag!\n", other->s.v.netname );
CNSTI4 2
ARGI4
ADDRGP4 $936
ARGP4
ADDRGP4 other
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 1709
;1709:					te = trap_find( world, FOFS( s.v.classname ), "player" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $788
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
ADDRGP4 $938
JUMPV
LABELV $937
line 1711
;1710:					while ( te )
;1711:					{
line 1712
;1712:						if ( te->team_no == 1 )
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 1
NEI4 $940
line 1713
;1713:							CenterPrint( te, "\n\n\nYour flag was ретурнед!!" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $942
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
ADDRGP4 $941
JUMPV
LABELV $940
line 1715
;1714:						else
;1715:							CenterPrint( te, "\n\n\nThe енемы flag was ретурнед!!" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $943
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
LABELV $941
line 1716
;1716:						te = trap_find( te, FOFS( s.v.classname ), "player" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $788
ARGP4
ADDRLP4 20
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 1717
;1717:					}
LABELV $938
line 1710
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $937
line 1718
;1718:					self->goal_state = 2;
ADDRGP4 self
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
line 1719
;1719:					self->s.v.solid = SOLID_TRIGGER;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 1720
;1720:					self->s.v.touch = ( func_t ) item_tfgoal_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 item_tfgoal_touch
CVPU4 4
CVUI4 4
ASGNI4
line 1721
;1721:					VectorCopy( self->s.v.oldorigin, self->s.v.origin );
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 168
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 172
ADDP4
INDIRF4
ASGNF4
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 164
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 176
ADDP4
INDIRF4
ASGNF4
line 1722
;1722:					setmodel( self, self->mdl );
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1723
;1723:					setorigin( self, PASSVEC3( self->s.v.origin ) );
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
line 1724
;1724:					sound( self, 2, "items/itembk2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $129
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
line 1725
;1725:					return;
ADDRGP4 $910
JUMPV
line 1727
;1726:				}
;1727:			} else
LABELV $932
line 1728
;1728:			{
line 1729
;1729:				if ( other->team_no == 1 )
ADDRGP4 other
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 1
NEI4 $931
line 1730
;1730:					return;
ADDRGP4 $910
JUMPV
line 1731
;1731:			}
line 1732
;1732:		} else
LABELV $930
line 1733
;1733:		{
line 1734
;1734:			if ( self->goal_no == 2 )
ADDRGP4 self
INDIRP4
CNSTI4 1112
ADDP4
INDIRI4
CNSTI4 2
NEI4 $946
line 1735
;1735:			{
line 1736
;1736:				if ( !VectorCompare( self->s.v.origin, self->s.v.oldorigin ) )
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $948
line 1737
;1737:				{
line 1738
;1738:					if ( other->team_no == 2 )
ADDRGP4 other
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 2
NEI4 $949
line 1739
;1739:					{
line 1740
;1740:						G_bprint( 2, "%s ретурнед the ред flag!\n", other->s.v.netname );
CNSTI4 2
ARGI4
ADDRGP4 $952
ARGP4
ADDRGP4 other
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 1741
;1741:						te = trap_find( world, FOFS( s.v.classname ), "player" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $788
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
ADDRGP4 $954
JUMPV
LABELV $953
line 1743
;1742:						while ( te )
;1743:						{
line 1744
;1744:							if ( te->team_no == 2 )
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 2
NEI4 $956
line 1745
;1745:								CenterPrint( te, "\n\n\n Your flag was ретурнед!!" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $958
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
ADDRGP4 $957
JUMPV
LABELV $956
line 1747
;1746:							else
;1747:								CenterPrint( te,
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $959
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
LABELV $957
line 1749
;1748:									     "\n\n\n The енемы flag was ретурнед!!" );
;1749:							te = trap_find( te, FOFS( s.v.classname ), "player" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $788
ARGP4
ADDRLP4 20
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 1750
;1750:						}
LABELV $954
line 1742
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $953
line 1751
;1751:						self->goal_state = 2;
ADDRGP4 self
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
line 1752
;1752:						self->s.v.solid = SOLID_TRIGGER;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 1753
;1753:						self->s.v.touch = ( func_t ) item_tfgoal_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 item_tfgoal_touch
CVPU4 4
CVUI4 4
ASGNI4
line 1754
;1754:						VectorCopy( self->s.v.oldorigin, self->s.v.origin );
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 168
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 172
ADDP4
INDIRF4
ASGNF4
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 164
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 176
ADDP4
INDIRF4
ASGNF4
line 1755
;1755:						setmodel( self, self->mdl );
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1756
;1756:						setorigin( self, PASSVEC3( self->s.v.origin ) );
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
line 1757
;1757:						sound( self, 2, "items/itembk2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $129
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
line 1758
;1758:						return;
ADDRGP4 $910
JUMPV
line 1760
;1759:					}
;1760:				} else
LABELV $948
line 1761
;1761:				{
line 1762
;1762:					if ( other->team_no == 2 )
ADDRGP4 other
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 2
NEI4 $960
line 1763
;1763:						return;
ADDRGP4 $910
JUMPV
LABELV $960
line 1764
;1764:				}
LABELV $949
line 1765
;1765:			}
LABELV $946
line 1766
;1766:		}
LABELV $931
line 1767
;1767:	}
LABELV $928
line 1768
;1768:	if ( Activated( self, other ) )
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
EQI4 $962
line 1769
;1769:	{
line 1770
;1770:		tfgoalitem_GiveToPlayer( self, other, self );
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 tfgoalitem_GiveToPlayer
CALLV
pop
line 1771
;1771:		if ( other->s.v.health > 0 )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $963
line 1772
;1772:			self->goal_state = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 1
ASGNI4
line 1773
;1773:	} else
ADDRGP4 $963
JUMPV
LABELV $962
line 1774
;1774:	{
line 1775
;1775:		if ( self->else_goal )
ADDRGP4 self
INDIRP4
CNSTI4 1144
ADDP4
INDIRI4
CNSTI4 0
EQI4 $966
line 1776
;1776:		{
line 1777
;1777:			te = Findgoal( self->else_goal );
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
line 1778
;1778:			if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $968
line 1779
;1779:				AttemptToActivate( te, other, self );
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
LABELV $968
line 1780
;1780:		}
LABELV $966
line 1781
;1781:	}
LABELV $963
line 1782
;1782:}
LABELV $910
endproc item_tfgoal_touch 32 20
export MoveFlag
proc MoveFlag 40 16
line 1786
;1783:
;1784:// megatf flag follow function
;1785:void MoveFlag() 
;1786:{
line 1789
;1787:	vec3_t	vtemp;
;1788:
;1789:	if ( tf_data.cb_prematch_time > g_globalvars.time )// && (self->s.v.owner->s.v.items & 131072) )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $971
line 1790
;1790:	{
line 1791
;1791:		T_Damage (PROG_TO_EDICT(self->s.v.owner), PROG_TO_EDICT(self->s.v.owner), PROG_TO_EDICT(self->s.v.owner), 500);
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTF4 1140457472
ARGF4
ADDRGP4 T_Damage
CALLV
pop
line 1792
;1792:	}
LABELV $971
line 1793
;1793:	makevectors(PROG_TO_EDICT(self->s.v.owner)->s.v.v_angle);
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+272
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 1794
;1794:	vtemp[0] =
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+44
ADDP4
INDIRF4
CNSTF4 1103626240
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
SUBF4
CNSTF4 0
ADDF4
ASGNF4
line 1796
;1795:		PROG_TO_EDICT(self->s.v.owner)->s.v.origin[0] - g_globalvars.v_forward[0] * 25 + 0;
;1796:	vtemp[1] =
ADDRLP4 0+4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+44+4
ADDP4
INDIRF4
CNSTF4 1103626240
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
SUBF4
CNSTF4 0
ADDF4
ASGNF4
line 1798
;1797:		PROG_TO_EDICT(self->s.v.owner)->s.v.origin[1] - g_globalvars.v_forward[1] * 25 + 0;
;1798:	vtemp[2] =
ADDRLP4 0+8
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+44+8
ADDP4
INDIRF4
CNSTF4 1103626240
ADDRGP4 g_globalvars+228+8
INDIRF4
MULF4
SUBF4
CNSTF4 1101004800
ADDF4
ASGNF4
line 1800
;1799:		PROG_TO_EDICT(self->s.v.owner)->s.v.origin[2] - g_globalvars.v_forward[2] * 25 + 20;
;1800:	setorigin(self, PASSVEC3(vtemp));
ADDRGP4 self
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
line 1801
;1801:	self->s.v.angles[0] = PROG_TO_EDICT(self->s.v.owner)->s.v.angles[2];
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 192
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+80+8
ADDP4
INDIRF4
ASGNF4
line 1802
;1802:	self->s.v.angles[1] = PROG_TO_EDICT(self->s.v.owner)->s.v.angles[1] + 90;
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+80+4
ADDP4
INDIRF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 1803
;1803:	self->s.v.angles[2] = 0 - PROG_TO_EDICT(self->s.v.owner)->s.v.angles[0];
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 0
ADDRLP4 20
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+80
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1804
;1804:	self->s.v.nextthink = g_globalvars.time + 0.010000;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1008981770
ADDF4
ASGNF4
line 1805
;1805:	self->s.v.think = (func_t) MoveFlag;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 MoveFlag
CVPU4 4
CVUI4 4
ASGNI4
line 1806
;1806:	if (PROG_TO_EDICT(self->s.v.owner)->s.v.deadflag)
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+236
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1003
line 1807
;1807:	{
line 1812
;1808:		// pablo
;1809:		//self->s.v.movetype = MOVETYPE_BOUNCE;
;1810:		//SetVector(self->s.v.velocity, 0, 0, 100);
;1811:		//
;1812:		PROG_TO_EDICT(self->s.v.owner)->s.v.effects = PROG_TO_EDICT(self->s.v.owner)->s.v.effects - ((int)PROG_TO_EDICT(self->s.v.owner)->s.v.effects & 128);
ADDRLP4 24
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
ADDRGP4 g_edicts+112+120
ADDP4
ADDRLP4 24
INDIRI4
ADDRGP4 g_edicts+112+120
ADDP4
INDIRF4
ADDRLP4 24
INDIRI4
ADDRGP4 g_edicts+112+120
ADDP4
INDIRF4
CVFI4 4
CNSTI4 128
BANDI4
CVIF4 4
SUBF4
ASGNF4
line 1813
;1813:		PROG_TO_EDICT(self->s.v.owner)->s.v.effects = PROG_TO_EDICT(self->s.v.owner)->s.v.effects - ((int)PROG_TO_EDICT(self->s.v.owner)->s.v.effects & 64);
ADDRLP4 28
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
ADDRGP4 g_edicts+112+120
ADDP4
ADDRLP4 28
INDIRI4
ADDRGP4 g_edicts+112+120
ADDP4
INDIRF4
ADDRLP4 28
INDIRI4
ADDRGP4 g_edicts+112+120
ADDP4
INDIRF4
CVFI4 4
CNSTI4 64
BANDI4
CVIF4 4
SUBF4
ASGNF4
line 1814
;1814:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1815
;1815:	}
LABELV $1003
line 1816
;1816:	if (!((int)PROG_TO_EDICT(self->s.v.owner)->s.v.items & 131072) && !((int)PROG_TO_EDICT(self->s.v.owner)->s.v.items & 262144))
ADDRLP4 24
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRI4
ADDRGP4 g_edicts+112+224
ADDP4
INDIRF4
CVFI4 4
CNSTI4 131072
BANDI4
ADDRLP4 28
INDIRI4
NEI4 $1019
ADDRLP4 24
INDIRI4
ADDRGP4 g_edicts+112+224
ADDP4
INDIRF4
CVFI4 4
CNSTI4 262144
BANDI4
ADDRLP4 28
INDIRI4
NEI4 $1019
line 1817
;1817:	{
line 1818
;1818:		PROG_TO_EDICT(self->s.v.owner)->s.v.effects = PROG_TO_EDICT(self->s.v.owner)->s.v.effects - ((int)PROG_TO_EDICT(self->s.v.owner)->s.v.effects & 128);
ADDRLP4 32
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 g_edicts+112+120
ADDP4
ADDRLP4 32
INDIRI4
ADDRGP4 g_edicts+112+120
ADDP4
INDIRF4
ADDRLP4 32
INDIRI4
ADDRGP4 g_edicts+112+120
ADDP4
INDIRF4
CVFI4 4
CNSTI4 128
BANDI4
CVIF4 4
SUBF4
ASGNF4
line 1819
;1819:		PROG_TO_EDICT(self->s.v.owner)->s.v.effects = PROG_TO_EDICT(self->s.v.owner)->s.v.effects - ((int)PROG_TO_EDICT(self->s.v.owner)->s.v.effects & 64);
ADDRLP4 36
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
ADDRGP4 g_edicts+112+120
ADDP4
ADDRLP4 36
INDIRI4
ADDRGP4 g_edicts+112+120
ADDP4
INDIRF4
ADDRLP4 36
INDIRI4
ADDRGP4 g_edicts+112+120
ADDP4
INDIRF4
CVFI4 4
CNSTI4 64
BANDI4
CVIF4 4
SUBF4
ASGNF4
line 1820
;1820:		dremove(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1821
;1821:	}
LABELV $1019
line 1822
;1822:};
LABELV $970
endproc MoveFlag 40 16
export tfgoalitem_GiveToPlayer
proc tfgoalitem_GiveToPlayer 48 28
line 1825
;1823:
;1824:void tfgoalitem_GiveToPlayer( gedict_t * Item, gedict_t * AP, gedict_t * Goal )
;1825:{
line 1827
;1826:
;1827:	Item->s.v.owner = EDICT_TO_PROG( AP );
ADDRFP4 0
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
line 1828
;1828:	if ( Item->mdl )
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1038
line 1829
;1829:		setmodel( Item, "" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $128
ARGP4
ADDRGP4 setmodel
CALLV
pop
LABELV $1038
line 1830
;1830:	Item->s.v.solid = SOLID_NOT;
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 1831
;1831:	if ( Item->goal_activation & TFGI_GLOW )
ADDRFP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1040
line 1832
;1832:		AP->s.v.effects = ( int ) AP->s.v.effects | 8;
ADDRLP4 0
ADDRFP4 4
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
LABELV $1040
line 1833
;1833:	if ( Item->goal_activation & TFGI_SLOW )
ADDRFP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1042
line 1834
;1834:		TeamFortress_SetSpeed( AP );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
LABELV $1042
line 1835
;1835:	if ( Item->goal_activation & TFGI_ITEMGLOWS )
ADDRFP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1044
line 1836
;1836:		Item->s.v.effects = Item->s.v.effects - ( ( int ) Item->s.v.effects | 8 );
ADDRLP4 4
ADDRFP4 0
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
BORI4
CVIF4 4
SUBF4
ASGNF4
LABELV $1044
line 1837
;1837:	if ( ( int ) Item->s.v.items & IT_KEY1 )
ADDRFP4 0
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CVFI4 4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $1046
line 1838
;1838:		AP->s.v.items = ( int ) AP->s.v.items | IT_KEY1;
ADDRLP4 12
ADDRFP4 4
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 131072
BORI4
CVIF4 4
ASGNF4
LABELV $1046
line 1839
;1839:	if ( ( int ) Item->s.v.items & IT_KEY2 )
ADDRFP4 0
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CVFI4 4
CNSTI4 262144
BANDI4
CNSTI4 0
EQI4 $1048
line 1840
;1840:		AP->s.v.items = ( int ) AP->s.v.items | IT_KEY2;
ADDRLP4 16
ADDRFP4 4
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 262144
BORI4
CVIF4 4
ASGNF4
LABELV $1048
line 1842
;1841:	// mtf flag follow
;1842:	if ((int)Item->s.v.items & 131072)
ADDRFP4 0
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CVFI4 4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $1050
line 1843
;1843:	{
line 1844
;1844:		AP->s.v.items = (int)AP->s.v.items | 131072;
ADDRLP4 20
ADDRFP4 4
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 131072
BORI4
CVIF4 4
ASGNF4
line 1845
;1845:		AP->s.v.effects = (int)AP->s.v.effects | 64;
ADDRLP4 24
ADDRFP4 4
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 64
BORI4
CVIF4 4
ASGNF4
line 1846
;1846:		newmis = spawn();
ADDRLP4 28
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 28
INDIRP4
ASGNP4
line 1847
;1847:		newmis->s.v.owner = EDICT_TO_PROG(AP);
ADDRGP4 newmis
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
line 1848
;1848:		newmis->s.v.movetype = MOVETYPE_STEP;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1082130432
ASGNF4
line 1849
;1849:		newmis->s.v.solid  = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 1850
;1850:		setsize(newmis ,0, 0, 0 ,0, 0, 0);
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 32
CNSTF4 0
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
line 1851
;1851:		VectorCopy(AP->s.v.angles,newmis->s.v.angles);
ADDRLP4 36
CNSTI4 192
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 40
CNSTI4 196
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 44
CNSTI4 200
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 1852
;1852:		newmis->s.v.nextthink = g_globalvars.time + 0.5;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 1853
;1853:		newmis->s.v.think = (func_t) MoveFlag;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 MoveFlag
CVPU4 4
CVUI4 4
ASGNI4
line 1854
;1854:		newmis->s.v.skin = 1;
ADDRGP4 newmis
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 1065353216
ASGNF4
line 1855
;1855:		setmodel(newmis, "progs/tf_flag.mdl");
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $1053
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1856
;1856:		setorigin(newmis, PASSVEC3(AP->s.v.origin));
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 1857
;1857:	}
LABELV $1050
line 1858
;1858:	if ((int)Item->s.v.items & 262144)
ADDRFP4 0
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CVFI4 4
CNSTI4 262144
BANDI4
CNSTI4 0
EQI4 $1054
line 1859
;1859:	{
line 1860
;1860:		AP->s.v.items = (int)AP->s.v.items | 262144;
ADDRLP4 20
ADDRFP4 4
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 262144
BORI4
CVIF4 4
ASGNF4
line 1861
;1861:		AP->s.v.effects = (int)AP->s.v.effects | 128;
ADDRLP4 24
ADDRFP4 4
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 128
BORI4
CVIF4 4
ASGNF4
line 1862
;1862:		newmis = spawn();
ADDRLP4 28
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 28
INDIRP4
ASGNP4
line 1863
;1863:		newmis->s.v.owner = EDICT_TO_PROG(AP);
ADDRGP4 newmis
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
line 1864
;1864:		newmis->s.v.movetype = MOVETYPE_STEP;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1082130432
ASGNF4
line 1865
;1865:		newmis->s.v.solid  = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 1866
;1866:		setsize(newmis ,0, 0, 0 ,0, 0, 0);
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 32
CNSTF4 0
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
line 1867
;1867:		VectorCopy(AP->s.v.angles,newmis->s.v.angles);
ADDRLP4 36
CNSTI4 192
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 40
CNSTI4 196
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 44
CNSTI4 200
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 1868
;1868:		newmis->s.v.nextthink = g_globalvars.time + 0.5;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 1869
;1869:		newmis->s.v.think = (func_t) MoveFlag;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 MoveFlag
CVPU4 4
CVUI4 4
ASGNI4
line 1870
;1870:		newmis->s.v.skin = 2;
ADDRGP4 newmis
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 1073741824
ASGNF4
line 1871
;1871:		setmodel(newmis, "progs/tf_flag.mdl");
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $1053
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1872
;1872:		setorigin(newmis, PASSVEC3(AP->s.v.origin));
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 1873
;1873:	}
LABELV $1054
line 1875
;1874:
;1875:	if ( Goal != Item )
ADDRFP4 8
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $1057
line 1876
;1876:	{
line 1877
;1877:		if ( Goal->goal_result & TFGR_NO_ITEM_RESULTS )
ADDRFP4 8
INDIRP4
CNSTI4 1136
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1059
line 1878
;1878:		{
line 1879
;1879:			Item->goal_state = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 1
ASGNI4
line 1880
;1880:			return;
ADDRGP4 $1037
JUMPV
LABELV $1059
line 1882
;1881:		}
;1882:	}
LABELV $1057
line 1883
;1883:	if ( AP->playerclass == PC_SPY && ( Item->goal_result & TFGR_REMOVE_DISGUISE ) )
ADDRFP4 4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1061
ADDRFP4 0
INDIRP4
CNSTI4 1136
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1061
line 1884
;1884:		AP->is_unabletospy = 1;
ADDRFP4 4
INDIRP4
CNSTI4 884
ADDP4
CNSTI4 1
ASGNI4
LABELV $1061
line 1885
;1885:	DoResults( Item, AP, 1 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 DoResults
CALLV
pop
line 1886
;1886:	DoItemGroupWork( Item, AP );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 DoItemGroupWork
CALLV
pop
line 1887
;1887:}
LABELV $1037
endproc tfgoalitem_GiveToPlayer 48 28
export ReturnItem
proc ReturnItem 44 20
line 1890
;1888:
;1889:void ReturnItem(  )
;1890:{
line 1892
;1891:	gedict_t *te;
;1892:	gedict_t *enemy = PROG_TO_EDICT( self->s.v.enemy );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 1894
;1893:
;1894:	enemy->goal_state = TFGS_INACTIVE;
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
line 1895
;1895:	if ( ( enemy->goal_activation & TFGI_SOLID ) && streq( enemy->s.v.classname, "item_tfgoal" ) )
ADDRLP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1064
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $220
ARGP4
ADDRLP4 12
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $1064
line 1896
;1896:		enemy->s.v.solid = SOLID_BBOX;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
ADDRGP4 $1065
JUMPV
LABELV $1064
line 1898
;1897:	else
;1898:		enemy->s.v.solid = SOLID_TRIGGER;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $1065
line 1899
;1899:	enemy->s.v.movetype = MOVETYPE_NONE;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 1900
;1900:	enemy->s.v.touch = ( func_t ) item_tfgoal_touch;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 item_tfgoal_touch
CVPU4 4
CVUI4 4
ASGNI4
line 1901
;1901:	VectorCopy( enemy->s.v.oldorigin, enemy->s.v.origin );
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 172
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRF4
ASGNF4
line 1902
;1902:	if ( enemy->mdl )
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1066
line 1903
;1903:		setmodel( enemy, enemy->mdl );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
LABELV $1066
line 1904
;1904:	setorigin( enemy, PASSVEC3( enemy->s.v.origin ) );
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
line 1905
;1905:	sound( enemy, 2, "items/itembk2.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $129
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
line 1906
;1906:	tfgoalitem_checkgoalreturn( enemy );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 tfgoalitem_checkgoalreturn
CALLV
pop
line 1907
;1907:	if ( self->s.v.weapon != 2 )
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1073741824
EQF4 $1068
line 1908
;1908:	{
line 1909
;1909:		if ( enemy->s.v.noise3 || enemy->noise4 )
ADDRLP4 32
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
NEU4 $1072
ADDRLP4 0
INDIRP4
CNSTI4 680
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
EQU4 $1070
LABELV $1072
line 1910
;1910:		{
line 1911
;1911:			te = trap_find( world, FOFS( s.v.classname ), "player" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $788
ARGP4
ADDRLP4 36
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 36
INDIRP4
ASGNP4
ADDRGP4 $1074
JUMPV
LABELV $1073
line 1913
;1912:			while ( te )
;1913:			{
line 1914
;1914:				if ( te->team_no == enemy->owned_by )
ADDRLP4 4
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 1124
ADDP4
INDIRI4
NEI4 $1076
line 1915
;1915:				{
line 1916
;1916:				    if ( enemy->s.v.noise3 )
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1077
line 1917
;1917:					CenterPrint( te, "\n\n\n%s", enemy->s.v.noise3 );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $835
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 1918
;1918:				}
ADDRGP4 $1077
JUMPV
LABELV $1076
line 1920
;1919:				else
;1920:				{
line 1921
;1921:				   if ( enemy->noise4 )
ADDRLP4 0
INDIRP4
CNSTI4 680
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1080
line 1922
;1922:					CenterPrint( te, "\n\n\n%s", enemy->noise4 );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $835
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 680
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
LABELV $1080
line 1923
;1923:				}
LABELV $1077
line 1924
;1924:				te = trap_find( te, FOFS( s.v.classname ), "player" );
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $788
ARGP4
ADDRLP4 40
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 40
INDIRP4
ASGNP4
line 1925
;1925:			}
LABELV $1074
line 1912
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1073
line 1926
;1926:		}
LABELV $1070
line 1927
;1927:	}
LABELV $1068
line 1928
;1928:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1929
;1929:}
LABELV $1063
endproc ReturnItem 44 20
export tfgoalitem_RemoveFromPlayer
proc tfgoalitem_RemoveFromPlayer 80 28
line 1932
;1930:
;1931:void tfgoalitem_RemoveFromPlayer( gedict_t * Item, gedict_t * AP, int method )
;1932:{
line 1941
;1933:	gedict_t *te;
;1934:	float   lighton;
;1935:	float   slowon;
;1936:	float   key1on;
;1937:	float   key2on;
;1938:	float   spyoff;
;1939:	gedict_t *DelayReturn;
;1940:
;1941:	if ( !Item || Item == world )
ADDRLP4 28
ADDRFP4 0
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 28
INDIRU4
CNSTU4 0
EQU4 $1085
ADDRLP4 28
INDIRU4
ADDRGP4 world
INDIRP4
CVPU4 4
NEU4 $1083
LABELV $1085
line 1942
;1942:	{
line 1943
;1943:		G_Error( "error: tfgoalitem_RemoveFromPlayer(): Item == world" );
ADDRGP4 $1086
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1944
;1944:		return;
ADDRGP4 $1082
JUMPV
LABELV $1083
line 1946
;1945:	}
;1946:	lighton = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 1947
;1947:	slowon = 0;
ADDRLP4 20
CNSTF4 0
ASGNF4
line 1948
;1948:	key1on = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 1949
;1949:	key2on = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 1950
;1950:	spyoff = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
line 1951
;1951:	te = trap_find( world, FOFS( s.v.classname ), "item_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 32
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
ADDRGP4 $1088
JUMPV
LABELV $1087
line 1953
;1952:	while ( te )
;1953:	{
line 1954
;1954:		if ( te->s.v.owner == EDICT_TO_PROG( AP ) && te != Item )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
NEI4 $1090
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $1090
line 1955
;1955:		{
line 1956
;1956:			if ( te->goal_activation & TFGI_GLOW )
ADDRLP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1092
line 1957
;1957:				lighton = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
LABELV $1092
line 1958
;1958:			if ( te->goal_activation & TFGI_SLOW )
ADDRLP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1094
line 1959
;1959:				slowon = 1;
ADDRLP4 20
CNSTF4 1065353216
ASGNF4
LABELV $1094
line 1960
;1960:			if ( ( int ) te->s.v.items & IT_KEY1 )
ADDRLP4 0
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CVFI4 4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $1096
line 1961
;1961:				key1on = 1;
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
LABELV $1096
line 1962
;1962:			if ( ( int ) te->s.v.items & IT_KEY2 )
ADDRLP4 0
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CVFI4 4
CNSTI4 262144
BANDI4
CNSTI4 0
EQI4 $1098
line 1963
;1963:				key2on = 1;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
LABELV $1098
line 1964
;1964:			if ( te->goal_result & TFGR_REMOVE_DISGUISE )
ADDRLP4 0
INDIRP4
CNSTI4 1136
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1100
line 1965
;1965:				spyoff = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
LABELV $1100
line 1966
;1966:		}
LABELV $1090
line 1967
;1967:		te = trap_find( te, FOFS( s.v.classname ), "item_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 40
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
ASGNP4
line 1968
;1968:	}
LABELV $1088
line 1952
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1087
line 1969
;1969:	if ( !lighton )
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $1102
line 1970
;1970:	{
line 1971
;1971:		if ( AP->invincible_finished > g_globalvars.time + 3 )
ADDRFP4 4
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1077936128
ADDF4
LEF4 $1104
line 1972
;1972:			lighton = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRGP4 $1105
JUMPV
LABELV $1104
line 1974
;1973:		else
;1974:		{
line 1975
;1975:			if ( AP->super_damage_finished > g_globalvars.time + 3 )
ADDRFP4 4
INDIRP4
CNSTI4 740
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1077936128
ADDF4
LEF4 $1107
line 1976
;1976:				lighton = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
LABELV $1107
line 1977
;1977:		}
LABELV $1105
line 1978
;1978:	}
LABELV $1102
line 1979
;1979:	if ( !lighton )
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $1110
line 1980
;1980:	{
line 1981
;1981:		AP->s.v.effects = AP->s.v.effects - ( ( int ) AP->s.v.effects & 8 );
ADDRLP4 36
ADDRFP4 4
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 40
ADDRLP4 36
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 36
INDIRP4
ADDRLP4 40
INDIRF4
ADDRLP4 40
INDIRF4
CVFI4 4
CNSTI4 8
BANDI4
CVIF4 4
SUBF4
ASGNF4
line 1982
;1982:		AP->s.v.effects = AP->s.v.effects - ( ( int ) AP->s.v.effects & 64 );
ADDRLP4 44
ADDRFP4 4
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 48
ADDRLP4 44
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 44
INDIRP4
ADDRLP4 48
INDIRF4
ADDRLP4 48
INDIRF4
CVFI4 4
CNSTI4 64
BANDI4
CVIF4 4
SUBF4
ASGNF4
line 1983
;1983:		AP->s.v.effects = AP->s.v.effects - ( ( int ) AP->s.v.effects & 128 );
ADDRLP4 52
ADDRFP4 4
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 56
ADDRLP4 52
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 52
INDIRP4
ADDRLP4 56
INDIRF4
ADDRLP4 56
INDIRF4
CVFI4 4
CNSTI4 128
BANDI4
CVIF4 4
SUBF4
ASGNF4
line 1984
;1984:	}
LABELV $1110
line 1985
;1985:	if ( Item->goal_activation & TFGI_ITEMGLOWS )
ADDRFP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1112
line 1986
;1986:		Item->s.v.effects = ( int ) Item->s.v.effects | 8;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 8
BORI4
CVIF4 4
ASGNF4
LABELV $1112
line 1987
;1987:	if ( !spyoff )
ADDRLP4 16
INDIRF4
CNSTF4 0
NEF4 $1114
line 1988
;1988:		AP->is_unabletospy = 0;
ADDRFP4 4
INDIRP4
CNSTI4 884
ADDP4
CNSTI4 0
ASGNI4
LABELV $1114
line 1989
;1989:	if ( !key1on )
ADDRLP4 8
INDIRF4
CNSTF4 0
NEF4 $1116
line 1990
;1990:		AP->s.v.items = AP->s.v.items - ( ( int ) AP->s.v.items & IT_KEY1 );
ADDRLP4 40
ADDRFP4 4
INDIRP4
CNSTI4 336
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
CNSTI4 131072
BANDI4
CVIF4 4
SUBF4
ASGNF4
LABELV $1116
line 1991
;1991:	if ( !key2on )
ADDRLP4 12
INDIRF4
CNSTF4 0
NEF4 $1118
line 1992
;1992:		AP->s.v.items = AP->s.v.items - ( ( int ) AP->s.v.items & IT_KEY2 );
ADDRLP4 48
ADDRFP4 4
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 52
ADDRLP4 48
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 48
INDIRP4
ADDRLP4 52
INDIRF4
ADDRLP4 52
INDIRF4
CVFI4 4
CNSTI4 262144
BANDI4
CVIF4 4
SUBF4
ASGNF4
LABELV $1118
line 1993
;1993:	te = trap_find( world, FOFS( s.v.classname ), "player" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $788
ARGP4
ADDRLP4 56
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
ASGNP4
ADDRGP4 $1121
JUMPV
LABELV $1120
line 1995
;1994:	while ( te )
;1995:	{
line 1996
;1996:		if ( IsAffectedBy( Item, te, AP ) )
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 IsAffectedBy
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $1123
line 1997
;1997:			RemoveResults( Item, te );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RemoveResults
CALLV
pop
LABELV $1123
line 1998
;1998:		te = trap_find( te, FOFS( s.v.classname ), "player" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $788
ARGP4
ADDRLP4 64
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 64
INDIRP4
ASGNP4
line 1999
;1999:	}
LABELV $1121
line 1994
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1120
line 2000
;2000:	if ( !method || method == 2 )
ADDRLP4 60
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $1127
ADDRLP4 60
INDIRI4
CNSTI4 2
NEI4 $1125
LABELV $1127
line 2001
;2001:	{
line 2002
;2002:		te = trap_find( world, FOFS( s.v.classname ), "player" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $788
ARGP4
ADDRLP4 64
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 64
INDIRP4
ASGNP4
ADDRGP4 $1129
JUMPV
LABELV $1128
line 2004
;2003:		while ( te )
;2004:		{
line 2005
;2005:			if ( te->team_no == Item->owned_by )
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1124
ADDP4
INDIRI4
NEI4 $1131
line 2006
;2006:			{
line 2007
;2007:				if ( Item->team_drop )
ADDRFP4 0
INDIRP4
CNSTI4 1364
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1133
line 2008
;2008:					CenterPrint( te, "\n\n\n%s", Item->team_drop );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $835
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1364
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
LABELV $1133
line 2009
;2009:				if ( Item->netname_team_drop )
ADDRFP4 0
INDIRP4
CNSTI4 1372
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1132
line 2010
;2010:				{
line 2011
;2011:					G_sprint( te, 2, "%s%s", AP->s.v.netname, Item->netname_team_drop );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $850
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1372
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2012
;2012:				}
line 2013
;2013:			} else
ADDRGP4 $1132
JUMPV
LABELV $1131
line 2014
;2014:			{
line 2015
;2015:				if ( Item->non_team_drop )
ADDRFP4 0
INDIRP4
CNSTI4 1368
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1137
line 2016
;2016:					CenterPrint( te, "\n\n\n%s", Item->non_team_drop );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $835
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1368
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
LABELV $1137
line 2017
;2017:				if ( Item->netname_non_team_drop )
ADDRFP4 0
INDIRP4
CNSTI4 1376
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1139
line 2018
;2018:				{
line 2019
;2019:					G_sprint( te, 2, "%s%s", AP->s.v.netname, Item->netname_non_team_drop );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $850
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1376
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2020
;2020:				}
LABELV $1139
line 2021
;2021:			}
LABELV $1132
line 2022
;2022:			te = trap_find( te, FOFS( s.v.classname ), "player" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $788
ARGP4
ADDRLP4 68
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 68
INDIRP4
ASGNP4
line 2023
;2023:		}
LABELV $1129
line 2003
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1128
line 2024
;2024:		if ( Item->goal_activation & TFGI_RETURN_DROP )
ADDRFP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1141
line 2025
;2025:		{
line 2026
;2026:			DelayReturn = spawn(  );
ADDRLP4 68
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 68
INDIRP4
ASGNP4
line 2027
;2027:			DelayReturn->s.v.enemy = EDICT_TO_PROG( Item );
ADDRLP4 24
INDIRP4
CNSTI4 400
ADDP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 2028
;2028:			if ( !method )
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $1143
line 2029
;2029:				DelayReturn->s.v.weapon = 0;
ADDRLP4 24
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $1144
JUMPV
LABELV $1143
line 2031
;2030:			else
;2031:				DelayReturn->s.v.weapon = 1;
ADDRLP4 24
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $1144
line 2032
;2032:			DelayReturn->s.v.think = ( func_t ) ReturnItem;
ADDRLP4 24
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 ReturnItem
CVPU4 4
CVUI4 4
ASGNI4
line 2033
;2033:			DelayReturn->s.v.nextthink = g_globalvars.time + 0.5;
ADDRLP4 24
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 2034
;2034:		} else
ADDRGP4 $1142
JUMPV
LABELV $1141
line 2035
;2035:		{
line 2036
;2036:			if ( Item->goal_activation & TFGI_DROP )
ADDRFP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1146
line 2037
;2037:			{
line 2038
;2038:				if ( method == 2 && ( ( Item->goal_activation & TFGI_ALLOW_DROP ) || tf_data.allow_drop_goal ) )
ADDRFP4 8
INDIRI4
CNSTI4 2
NEI4 $1148
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ADDRLP4 68
INDIRI4
NEI4 $1151
ADDRGP4 tf_data+76
INDIRI4
ADDRLP4 68
INDIRI4
EQI4 $1148
LABELV $1151
line 2039
;2039:					tfgoalitem_drop( Item, 1, AP );
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 tfgoalitem_drop
CALLV
pop
ADDRGP4 $1147
JUMPV
LABELV $1148
line 2041
;2040:				else
;2041:					tfgoalitem_drop( Item, 0, AP );
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 tfgoalitem_drop
CALLV
pop
line 2042
;2042:			} else
ADDRGP4 $1147
JUMPV
LABELV $1146
line 2043
;2043:			{
line 2044
;2044:				Item->s.v.owner = EDICT_TO_PROG( world );
ADDRFP4 0
INDIRP4
CNSTI4 480
ADDP4
ADDRGP4 world
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 2045
;2045:				dremove( Item );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 2046
;2046:				TeamFortress_SetSpeed( AP );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 2047
;2047:				return;
ADDRGP4 $1082
JUMPV
LABELV $1147
line 2049
;2048:			}
;2049:		}
LABELV $1142
line 2050
;2050:		Item->s.v.owner = EDICT_TO_PROG( world );
ADDRFP4 0
INDIRP4
CNSTI4 480
ADDP4
ADDRGP4 world
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 2051
;2051:		Item->s.v.flags = ( int ) Item->s.v.flags - ( ( int ) Item->s.v.flags & 512 );
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 68
INDIRP4
ADDRLP4 72
INDIRI4
ADDRLP4 72
INDIRI4
CNSTI4 512
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 2052
;2052:		setsize( Item, PASSVEC3( Item->goal_min ), PASSVEC3( Item->goal_max ) );
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 1204
ADDP4
INDIRF4
ARGF4
ADDRLP4 76
INDIRP4
CNSTI4 1208
ADDP4
INDIRF4
ARGF4
ADDRLP4 76
INDIRP4
CNSTI4 1212
ADDP4
INDIRF4
ARGF4
ADDRLP4 76
INDIRP4
CNSTI4 1216
ADDP4
INDIRF4
ARGF4
ADDRLP4 76
INDIRP4
CNSTI4 1220
ADDP4
INDIRF4
ARGF4
ADDRLP4 76
INDIRP4
CNSTI4 1224
ADDP4
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 2053
;2053:		TeamFortress_SetSpeed( AP );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 2054
;2054:		return;
ADDRGP4 $1082
JUMPV
LABELV $1125
line 2056
;2055:	} else
;2056:	{
line 2057
;2057:		if ( method == 1 )
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $1152
line 2058
;2058:		{
line 2059
;2059:			if ( Item->goal_activation & TFGI_RETURN_GOAL )
ADDRFP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1154
line 2060
;2060:			{
line 2061
;2061:				DelayReturn = spawn(  );
ADDRLP4 64
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 64
INDIRP4
ASGNP4
line 2062
;2062:				DelayReturn->s.v.enemy = EDICT_TO_PROG( Item );
ADDRLP4 24
INDIRP4
CNSTI4 400
ADDP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 2063
;2063:				DelayReturn->s.v.weapon = 2;
ADDRLP4 24
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1073741824
ASGNF4
line 2064
;2064:				DelayReturn->s.v.think = ( func_t ) ReturnItem;
ADDRLP4 24
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 ReturnItem
CVPU4 4
CVUI4 4
ASGNI4
line 2065
;2065:				DelayReturn->s.v.nextthink = g_globalvars.time + 0.5;
ADDRLP4 24
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 2066
;2066:				Item->s.v.owner = EDICT_TO_PROG( world );
ADDRFP4 0
INDIRP4
CNSTI4 480
ADDP4
ADDRGP4 world
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 2067
;2067:				TeamFortress_SetSpeed( AP );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 2068
;2068:				return;
ADDRGP4 $1082
JUMPV
LABELV $1154
line 2070
;2069:			}
;2070:			Item->s.v.solid = SOLID_NOT;
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 2071
;2071:			Item->s.v.owner = EDICT_TO_PROG( world );
ADDRFP4 0
INDIRP4
CNSTI4 480
ADDP4
ADDRGP4 world
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 2072
;2072:			TeamFortress_SetSpeed( AP );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 2073
;2073:			return;
ADDRGP4 $1082
JUMPV
LABELV $1152
line 2075
;2074:		}
;2075:	}
line 2076
;2076:	G_Error( "Invalid method passed into tfgoalitem_RemoveFromPlayer\n" );
ADDRGP4 $1157
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 2077
;2077:}
LABELV $1082
endproc tfgoalitem_RemoveFromPlayer 80 28
export tfgoalitem_dropthink
proc tfgoalitem_dropthink 44 28
line 2080
;2078:
;2079:void tfgoalitem_dropthink(  )
;2080:{
line 2083
;2081:	float   pos;
;2082:
;2083:	self->s.v.movetype = MOVETYPE_TOSS;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 2084
;2084:	if ( self->pausetime )
ADDRGP4 self
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1159
line 2085
;2085:	{
line 2086
;2086:		pos = trap_pointcontents( PASSVEC3( self->s.v.origin ) );
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
ADDRLP4 0
ADDRLP4 8
INDIRI4
CVIF4 4
ASGNF4
line 2087
;2087:		if ( pos == -4 )
ADDRLP4 0
INDIRF4
CNSTF4 3229614080
NEF4 $1161
line 2088
;2088:			self->s.v.nextthink = g_globalvars.time + self->pausetime / 4;
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
CNSTI4 676
ADDP4
INDIRF4
CNSTF4 1082130432
DIVF4
ADDF4
ASGNF4
ADDRGP4 $1162
JUMPV
LABELV $1161
line 2090
;2089:		else
;2090:		{
line 2091
;2091:			if ( pos == -5 )
ADDRLP4 0
INDIRF4
CNSTF4 3231711232
NEF4 $1164
line 2092
;2092:				self->s.v.nextthink = g_globalvars.time + 5;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
ADDRGP4 $1165
JUMPV
LABELV $1164
line 2094
;2093:			else
;2094:			{
line 2095
;2095:				if ( pos == -2 || pos == -6 )
ADDRLP4 16
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 16
INDIRF4
CNSTF4 3221225472
EQF4 $1169
ADDRLP4 16
INDIRF4
CNSTF4 3233808384
NEF4 $1167
LABELV $1169
line 2096
;2096:				{
line 2097
;2097:					if ( self->camdist < 3 )
ADDRGP4 self
INDIRP4
CNSTI4 1416
ADDP4
INDIRF4
CNSTF4 1077936128
GEF4 $1170
line 2098
;2098:					{
line 2099
;2099:						VectorCopy( self->camangle, self->s.v.origin );
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 1420
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 160
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 1424
ADDP4
INDIRF4
ASGNF4
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 164
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 1428
ADDP4
INDIRF4
ASGNF4
line 2100
;2100:						setorigin( self, PASSVEC3( self->s.v.origin ) );
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
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
line 2101
;2101:						self->s.v.velocity[2] = 400;
ADDRGP4 self
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1137180672
ASGNF4
line 2102
;2102:						self->s.v.velocity[0] = -50 + g_random(  ) * 100;
ADDRLP4 24
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1120403456
ADDRLP4 24
INDIRF4
MULF4
CNSTF4 3259498496
ADDF4
ASGNF4
line 2103
;2103:						self->s.v.velocity[1] = -50 + g_random(  ) * 100;
ADDRLP4 28
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1120403456
ADDRLP4 28
INDIRF4
MULF4
CNSTF4 3259498496
ADDF4
ASGNF4
line 2104
;2104:						self->goal_state = 2;
ADDRGP4 self
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
line 2105
;2105:						self->s.v.movetype = MOVETYPE_TOSS;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 2106
;2106:						if ( self->goal_activation & TFGI_SOLID )
ADDRGP4 self
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1172
line 2107
;2107:							self->s.v.solid = SOLID_BBOX;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
ADDRGP4 $1173
JUMPV
LABELV $1172
line 2109
;2108:						else
;2109:							self->s.v.solid = SOLID_TRIGGER;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $1173
line 2110
;2110:						if ( self->mdl )
ADDRGP4 self
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1174
line 2111
;2111:							setmodel( self, self->mdl );
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
LABELV $1174
line 2112
;2112:						setsize( self, PASSVEC3( self->goal_min ), PASSVEC3( self->goal_max ) );
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 1204
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 1208
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 1212
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 1216
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 1220
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 1224
ADDP4
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 2113
;2113:						self->camdist = self->camdist + 1;
ADDRLP4 40
ADDRGP4 self
INDIRP4
CNSTI4 1416
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2114
;2114:						self->s.v.nextthink = g_globalvars.time + 5;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 2115
;2115:						self->s.v.think = ( func_t ) tfgoalitem_dropthink;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 tfgoalitem_dropthink
CVPU4 4
CVUI4 4
ASGNI4
line 2116
;2116:						return;
ADDRGP4 $1158
JUMPV
LABELV $1170
line 2118
;2117:					} else
;2118:						self->s.v.nextthink = g_globalvars.time + 2;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 2119
;2119:				} else
ADDRGP4 $1168
JUMPV
LABELV $1167
line 2120
;2120:					self->s.v.nextthink = g_globalvars.time + self->pausetime;
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
ADDF4
ASGNF4
LABELV $1168
line 2121
;2121:			}
LABELV $1165
line 2122
;2122:		}
LABELV $1162
line 2123
;2123:		self->s.v.think = ( func_t ) tfgoalitem_remove;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 tfgoalitem_remove
CVPU4 4
CVUI4 4
ASGNI4
line 2124
;2124:	}
LABELV $1159
line 2125
;2125:}
LABELV $1158
endproc tfgoalitem_dropthink 44 28
export tfgoalitem_droptouch
proc tfgoalitem_droptouch 0 0
line 2128
;2126:
;2127:void tfgoalitem_droptouch(  )
;2128:{
line 2129
;2129:	self->s.v.touch = ( func_t ) item_tfgoal_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 item_tfgoal_touch
CVPU4 4
CVUI4 4
ASGNI4
line 2130
;2130:	self->s.v.nextthink = g_globalvars.time + 4.25;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1082654720
ADDF4
ASGNF4
line 2131
;2131:	self->s.v.think = ( func_t ) tfgoalitem_dropthink;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 tfgoalitem_dropthink
CVPU4 4
CVUI4 4
ASGNI4
line 2132
;2132:}
LABELV $1179
endproc tfgoalitem_droptouch 0 0
export tfgoalitem_drop
proc tfgoalitem_drop 28 28
line 2135
;2133:
;2134:void tfgoalitem_drop( gedict_t * Item, float PAlive, gedict_t * P )
;2135:{
line 2136
;2136:	VectorCopy( PROG_TO_EDICT( Item->s.v.owner )->s.v.origin, Item->s.v.origin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+44
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+44+4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 164
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+44+8
ADDP4
INDIRF4
ASGNF4
line 2137
;2137:	setorigin( Item, PASSVEC3( Item->s.v.origin ) );
ADDRLP4 0
ADDRFP4 0
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
line 2138
;2138:	VectorCopy( PROG_TO_EDICT( Item->s.v.owner )->s.v.origin, Item->camangle );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 1420
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+44
ADDP4
INDIRF4
ASGNF4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 1424
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+44+4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 1428
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+44+8
ADDP4
INDIRF4
ASGNF4
line 2140
;2139:
;2140:	Item->camangle[2] -= 8;	//Item->s.v.owner->s.v.origin - '0 0 8';
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 1428
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1090519040
SUBF4
ASGNF4
line 2141
;2141:	Item->camdist = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1416
ADDP4
CNSTF4 0
ASGNF4
line 2142
;2142:	Item->s.v.velocity[2] = 400;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1137180672
ASGNF4
line 2143
;2143:	Item->s.v.velocity[0] = -50 + g_random(  ) * 100;
ADDRLP4 8
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1120403456
ADDRLP4 8
INDIRF4
MULF4
CNSTF4 3259498496
ADDF4
ASGNF4
line 2144
;2144:	Item->s.v.velocity[1] = -50 + g_random(  ) * 100;
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1120403456
ADDRLP4 12
INDIRF4
MULF4
CNSTF4 3259498496
ADDF4
ASGNF4
line 2145
;2145:	Item->goal_state = TFGS_INACTIVE;
ADDRFP4 0
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
line 2146
;2146:	Item->s.v.movetype = MOVETYPE_TOSS;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 2147
;2147:	if ( Item->goal_activation & TFGI_SOLID )
ADDRFP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1198
line 2148
;2148:		Item->s.v.solid = SOLID_BBOX;
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
ADDRGP4 $1199
JUMPV
LABELV $1198
line 2150
;2149:	else
;2150:		Item->s.v.solid = SOLID_TRIGGER;
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $1199
line 2151
;2151:	if ( Item->mdl )
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1200
line 2152
;2152:		setmodel( Item, Item->mdl );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
LABELV $1200
line 2153
;2153:	setsize( Item, PASSVEC3( Item->goal_min ), PASSVEC3( Item->goal_max ) );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 1204
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 1208
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 1212
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 1216
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 1220
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 1224
ADDP4
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 2154
;2154:	Item->s.v.owner = EDICT_TO_PROG( P );
ADDRFP4 0
INDIRP4
CNSTI4 480
ADDP4
ADDRFP4 8
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 2155
;2155:	if ( PAlive == 1 )
ADDRFP4 4
INDIRF4
CNSTF4 1065353216
NEF4 $1202
line 2156
;2156:	{
line 2157
;2157:		makevectors( P->s.v.v_angle );
ADDRFP4 8
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 2158
;2158:		if ( P->s.v.v_angle[0] )
ADDRFP4 8
INDIRP4
CNSTI4 384
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1204
line 2159
;2159:		{
line 2160
;2160:			Item->s.v.velocity[0] = g_globalvars.v_forward[0] * 400 + g_globalvars.v_up[0] * 200;
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1137180672
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
CNSTF4 1128792064
ADDRGP4 g_globalvars+240
INDIRF4
MULF4
ADDF4
ASGNF4
line 2161
;2161:			Item->s.v.velocity[1] = g_globalvars.v_forward[1] * 400 + g_globalvars.v_up[1] * 200;
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1137180672
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
CNSTF4 1128792064
ADDRGP4 g_globalvars+240+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 2162
;2162:			Item->s.v.velocity[2] = g_globalvars.v_forward[2] * 400 + g_globalvars.v_up[2] * 200;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1137180672
ADDRGP4 g_globalvars+228+8
INDIRF4
MULF4
CNSTF4 1128792064
ADDRGP4 g_globalvars+240+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2163
;2163:		} else
ADDRGP4 $1205
JUMPV
LABELV $1204
line 2164
;2164:		{
line 2165
;2165:			aim( Item->s.v.velocity );
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 aim
CALLV
pop
line 2166
;2166:			VectorScale( Item->s.v.velocity, 400, Item->s.v.velocity );
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 2167
;2167:			Item->s.v.velocity[2] = 200;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1128792064
ASGNF4
line 2168
;2168:		}
LABELV $1205
line 2169
;2169:		Item->s.v.touch = ( func_t ) SUB_Null;
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 SUB_Null
CVPU4 4
CVUI4 4
ASGNI4
line 2170
;2170:		Item->s.v.nextthink = g_globalvars.time + 0.75;
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1061158912
ADDF4
ASGNF4
line 2171
;2171:		Item->s.v.think = ( func_t ) tfgoalitem_droptouch;
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 tfgoalitem_droptouch
CVPU4 4
CVUI4 4
ASGNI4
line 2172
;2172:	} else
ADDRGP4 $1203
JUMPV
LABELV $1202
line 2173
;2173:	{
line 2174
;2174:		Item->s.v.touch = ( func_t ) item_tfgoal_touch;
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 item_tfgoal_touch
CVPU4 4
CVUI4 4
ASGNI4
line 2175
;2175:		Item->s.v.nextthink = g_globalvars.time + 5;
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 2176
;2176:		Item->s.v.think = ( func_t ) tfgoalitem_dropthink;
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 tfgoalitem_dropthink
CVPU4 4
CVUI4 4
ASGNI4
line 2177
;2177:	}
LABELV $1203
line 2178
;2178:}
LABELV $1181
endproc tfgoalitem_drop 28 28
export tfgoalitem_remove
proc tfgoalitem_remove 12 4
line 2181
;2179:
;2180:void tfgoalitem_remove(  )
;2181:{
line 2185
;2182:	gedict_t *te;
;2183:	gedict_t *oldself;
;2184:
;2185:	if ( self->goal_state == TFGS_ACTIVE )
ADDRGP4 self
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1219
line 2186
;2186:		return;
ADDRGP4 $1218
JUMPV
LABELV $1219
line 2187
;2187:	if ( self->goal_activation & TFGI_RETURN_REMOVE )
ADDRGP4 self
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1221
line 2188
;2188:	{
line 2189
;2189:		te = spawn(  );
ADDRLP4 8
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 2190
;2190:		te->s.v.enemy = EDICT_TO_PROG( self );
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
line 2191
;2191:		te->s.v.weapon = 3;
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1077936128
ASGNF4
line 2192
;2192:		oldself = self;
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
line 2193
;2193:		self = te;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 2194
;2194:		ReturnItem(  );
ADDRGP4 ReturnItem
CALLV
pop
line 2195
;2195:		self = oldself;
ADDRGP4 self
ADDRLP4 4
INDIRP4
ASGNP4
line 2196
;2196:		return;
ADDRGP4 $1218
JUMPV
LABELV $1221
line 2198
;2197:	}
;2198:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 2199
;2199:}
LABELV $1218
endproc tfgoalitem_remove 12 4
export tfgoalitem_checkgoalreturn
proc tfgoalitem_checkgoalreturn 12 12
line 2202
;2200:
;2201:void tfgoalitem_checkgoalreturn( gedict_t * Item )
;2202:{
line 2205
;2203:	gedict_t *te;
;2204:
;2205:	if ( Item->s.v.impulse )
ADDRFP4 0
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1224
line 2206
;2206:	{
line 2207
;2207:		te = Findgoal( Item->s.v.impulse );
ADDRFP4 0
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
ADDRGP4 Findgoal
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 2208
;2208:		if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1226
line 2209
;2209:		{
line 2210
;2210:			te = Findgoal( Item->s.v.impulse );
ADDRFP4 0
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
ADDRGP4 Findgoal
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 2211
;2211:			if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1228
line 2212
;2212:				AttemptToActivate( te, world, Item );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 world
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 AttemptToActivate
CALLV
pop
LABELV $1228
line 2213
;2213:		}
LABELV $1226
line 2214
;2214:	}
LABELV $1224
line 2215
;2215:}
LABELV $1223
endproc tfgoalitem_checkgoalreturn 12 12
export DisplayItemStatus
proc DisplayItemStatus 24 16
line 2218
;2216:
;2217:void DisplayItemStatus( gedict_t * Goal, gedict_t * Player, gedict_t * Item )
;2218:{
line 2219
;2219:	int     flag_time = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2221
;2220:
;2221:	if ( Item->goal_state == TFGS_ACTIVE )
ADDRFP4 8
INDIRP4
CNSTI4 1120
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1231
line 2222
;2222:	{
line 2223
;2223:		if ( Goal->team_str_carried || Goal->non_team_str_carried )
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRP4
CNSTI4 1292
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
NEU4 $1235
ADDRLP4 4
INDIRP4
CNSTI4 1304
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $1232
LABELV $1235
line 2224
;2224:		{
line 2225
;2225:			if ( Player->team_no == Item->owned_by )
ADDRFP4 4
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 1124
ADDP4
INDIRI4
NEI4 $1236
line 2226
;2226:				G_sprint( Player, 2, "%s ", Goal->team_str_carried );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1238
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1292
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $1237
JUMPV
LABELV $1236
line 2228
;2227:			else
;2228:				G_sprint( Player, 2, "%s ", Goal->non_team_str_carried );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1238
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1304
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $1237
line 2230
;2229:
;2230:	        	if( !(Item->s.v.owner) ) //FIXME !!!!!
ADDRFP4 8
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1239
line 2231
;2231:	        	{
line 2232
;2232:	        	        G_sprint( Player, 2, ".\n");
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1241
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2233
;2233:	        		return;
ADDRGP4 $1230
JUMPV
LABELV $1239
line 2236
;2234:	        	}
;2235:
;2236:			if ( Player == PROG_TO_EDICT( Item->s.v.owner ) )
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
NEU4 $1242
line 2237
;2237:				G_sprint( Player, 2, "You.\n" );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1244
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $1232
JUMPV
LABELV $1242
line 2239
;2238:			else
;2239:				G_sprint( Player, 2, "%s.\n", PROG_TO_EDICT( Item->s.v.owner )->s.v.netname );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1245
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+284
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2240
;2240:		}
line 2241
;2241:	} else
ADDRGP4 $1232
JUMPV
LABELV $1231
line 2242
;2242:	{
line 2243
;2243:		if ( !VectorCompare( Item->s.v.origin, Item->s.v.oldorigin ) )
ADDRLP4 4
ADDRFP4 8
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
NEI4 $1248
line 2244
;2244:		{
line 2245
;2245:			if ( Goal->team_str_moved || Goal->non_team_str_moved )
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
CNSTU4 0
ASGNU4
ADDRLP4 12
INDIRP4
CNSTI4 1288
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
NEU4 $1252
ADDRLP4 12
INDIRP4
CNSTI4 1300
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $1249
LABELV $1252
line 2246
;2246:			{
line 2248
;2247:
;2248:				if ( Player->team_no == Item->owned_by )
ADDRFP4 4
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 1124
ADDP4
INDIRI4
NEI4 $1253
line 2249
;2249:					G_sprint( Player, 2, Goal->team_str_moved );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 1288
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $1254
JUMPV
LABELV $1253
line 2251
;2250:				else
;2251:					G_sprint( Player, 2, Goal->non_team_str_moved );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 1300
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $1254
line 2253
;2252:
;2253:				if ( tf_data.flag_timer )
ADDRGP4 tf_data+164
INDIRI4
CNSTI4 0
EQI4 $1249
line 2254
;2254:				{
line 2255
;2255:					if ( Item->s.v.think == ( func_t ) tfgoalitem_remove )
ADDRFP4 8
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ADDRGP4 tfgoalitem_remove
CVPU4 4
CVUI4 4
NEI4 $1258
line 2256
;2256:					{
line 2257
;2257:						flag_time = floor( Item->s.v.nextthink - g_globalvars.time );
ADDRFP4 8
INDIRP4
CNSTI4 288
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
SUBF4
ARGF4
ADDRLP4 20
ADDRGP4 floor
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
CVFI4 4
ASGNI4
line 2258
;2258:					}
LABELV $1258
line 2260
;2259:
;2260:					if ( Item->s.v.think == ( func_t ) tfgoalitem_dropthink )
ADDRFP4 8
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ADDRGP4 tfgoalitem_dropthink
CVPU4 4
CVUI4 4
NEI4 $1261
line 2261
;2261:					{
line 2262
;2262:						flag_time =
ADDRLP4 20
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
CNSTI4 288
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
SUBF4
ADDRLP4 20
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 2264
;2263:						    ( Item->s.v.nextthink - g_globalvars.time + Item->pausetime );
;2264:					}
LABELV $1261
line 2265
;2265:					G_sprint( Player, 2, " :%3d\n", flag_time );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1264
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 2267
;2266:
;2267:				}
line 2268
;2268:			}
line 2269
;2269:		} else
ADDRGP4 $1249
JUMPV
LABELV $1248
line 2270
;2270:		{
line 2271
;2271:			if ( Goal->team_str_home || Goal->non_team_str_home )
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
CNSTU4 0
ASGNU4
ADDRLP4 12
INDIRP4
CNSTI4 1284
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
NEU4 $1267
ADDRLP4 12
INDIRP4
CNSTI4 1296
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $1265
LABELV $1267
line 2272
;2272:			{
line 2273
;2273:				if ( Player->team_no == Item->owned_by )
ADDRFP4 4
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 1124
ADDP4
INDIRI4
NEI4 $1268
line 2274
;2274:					G_sprint( Player, 2, "%s\n", Goal->team_str_home );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1270
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1284
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $1269
JUMPV
LABELV $1268
line 2276
;2275:				else
;2276:					G_sprint( Player, 2, "%s\n", Goal->non_team_str_home );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1270
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1296
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $1269
line 2277
;2277:			}
LABELV $1265
line 2278
;2278:		}
LABELV $1249
line 2279
;2279:	}
LABELV $1232
line 2280
;2280:}
LABELV $1230
endproc DisplayItemStatus 24 16
export SP_info_player_team1
proc SP_info_player_team1 0 0
line 2282
;2281:void SP_info_player_team1(  )
;2282:{
line 2283
;2283:	CTF_Map = 1;
ADDRGP4 CTF_Map
CNSTI4 1
ASGNI4
line 2284
;2284:	self->s.v.classname = "info_player_teamspawn";
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $80
ASGNP4
line 2285
;2285:	self->team_no = 2;
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
CNSTI4 2
ASGNI4
line 2286
;2286:	self->goal_effects = TFGE_AP;
ADDRGP4 self
INDIRP4
CNSTI4 1132
ADDP4
CNSTI4 1
ASGNI4
line 2287
;2287:	self->team_str_home = "ts2";
ADDRGP4 self
INDIRP4
CNSTI4 1284
ADDP4
ADDRGP4 $1272
ASGNP4
line 2288
;2288:}
LABELV $1271
endproc SP_info_player_team1 0 0
export SP_info_player_team2
proc SP_info_player_team2 0 0
line 2291
;2289:
;2290:void SP_info_player_team2(  )
;2291:{
line 2292
;2292:	CTF_Map = 1;
ADDRGP4 CTF_Map
CNSTI4 1
ASGNI4
line 2293
;2293:	self->s.v.classname = "info_player_teamspawn";
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $80
ASGNP4
line 2294
;2294:	self->team_no = 1;
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
CNSTI4 1
ASGNI4
line 2295
;2295:	self->goal_effects = TFGE_AP;
ADDRGP4 self
INDIRP4
CNSTI4 1132
ADDP4
CNSTI4 1
ASGNI4
line 2296
;2296:	self->team_str_home = "ts1";
ADDRGP4 self
INDIRP4
CNSTI4 1284
ADDP4
ADDRGP4 $1274
ASGNP4
line 2297
;2297:}
LABELV $1273
endproc SP_info_player_team2 0 0
export SP_item_flag_team2
proc SP_item_flag_team2 40 28
line 2300
;2298:
;2299:void SP_item_flag_team2(  )
;2300:{
line 2303
;2301:	gedict_t *dp;
;2302:
;2303:	CTF_Map = 1;
ADDRGP4 CTF_Map
CNSTI4 1
ASGNI4
line 2304
;2304:	UpdateAbbreviations( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 UpdateAbbreviations
CALLV
pop
line 2305
;2305:	trap_precache_sound( "ogre/ogwake.wav" );
ADDRGP4 $1276
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 2306
;2306:	trap_precache_sound( "boss2/pop2.wav" );
ADDRGP4 $1277
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 2307
;2307:	self->s.v.classname = "item_tfgoal";
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $220
ASGNP4
line 2308
;2308:	self->s.v.netname = "Team 1 Flag";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $1278
ASGNP4
line 2309
;2309:	self->broadcast = " гот the enemy team's flag!\n";
ADDRGP4 self
INDIRP4
CNSTI4 1332
ADDP4
ADDRGP4 $1279
ASGNP4
line 2310
;2310:	self->deathtype = "You've got the enemy flag!\n";
ADDRGP4 self
INDIRP4
CNSTI4 804
ADDP4
ADDRGP4 $1280
ASGNP4
line 2311
;2311:	self->s.v.noise = "ogre/ogwake.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $1276
ASGNP4
line 2315
;2312:	//if ( tf_data.toggleflags & TFLAG_USE_WAR_STD )
;2313:	//	self->mdl = "progs/tf_stan.mdl";
;2314:	//else
;2315:		self->mdl = "progs/tf_flag.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $1053
ASGNP4
line 2316
;2316:	self->s.v.skin = 0;
ADDRGP4 self
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 0
ASGNF4
line 2317
;2317:	setmodel( self, self->mdl );
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 2318
;2318:	self->goal_no = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1112
ADDP4
CNSTI4 1
ASGNI4
line 2319
;2319:	self->goal_activation = TFGI_GLOW | TFGI_DROP | TFGI_REMOVE | TFGI_RETURN_REMOVE | TFGI_RETURN_GOAL | TFGI_ITEMGLOWS;
ADDRGP4 self
INDIRP4
CNSTI4 1128
ADDP4
CNSTI4 693
ASGNI4
line 2320
;2320:	self->goal_effects = TFGE_AP;
ADDRGP4 self
INDIRP4
CNSTI4 1132
ADDP4
CNSTI4 1
ASGNI4
line 2321
;2321:	self->pausetime = 128;
ADDRGP4 self
INDIRP4
CNSTI4 676
ADDP4
CNSTF4 1124073472
ASGNF4
line 2322
;2322:	SetVector( self->goal_min, -16, -16, -24 );
ADDRGP4 self
INDIRP4
CNSTI4 1204
ADDP4
CNSTF4 3246391296
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1208
ADDP4
CNSTF4 3246391296
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1212
ADDP4
CNSTF4 3250585600
ASGNF4
line 2323
;2323:	SetVector( self->goal_max, 16, 16, 32 );
ADDRGP4 self
INDIRP4
CNSTI4 1216
ADDP4
CNSTF4 1098907648
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1220
ADDP4
CNSTF4 1098907648
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1224
ADDP4
CNSTF4 1107296256
ASGNF4
line 2324
;2324:	setsize( self, PASSVEC3( self->goal_min ), PASSVEC3( self->goal_max ) );
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1204
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 1208
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 1212
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 1216
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 1220
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 1224
ADDP4
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 2325
;2325:	self->s.v.touch = ( func_t ) item_tfgoal_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 item_tfgoal_touch
CVPU4 4
CVUI4 4
ASGNI4
line 2326
;2326:	self->goal_state = 2;
ADDRGP4 self
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
line 2327
;2327:	self->s.v.solid = SOLID_TRIGGER;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 2328
;2328:	setorigin( self, PASSVEC3( self->s.v.origin ) );
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
line 2329
;2329:	self->s.v.nextthink = g_globalvars.time + 0.2;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 2330
;2330:	self->s.v.think = ( func_t ) TF_PlaceItem;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 TF_PlaceItem
CVPU4 4
CVUI4 4
ASGNI4
line 2331
;2331:	dp = spawn(  );
ADDRLP4 16
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 2332
;2332:	VectorCopy( self->s.v.origin, dp->s.v.origin );
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
line 2333
;2333:	dp->s.v.classname = "info_tfgoal";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $49
ASGNP4
line 2334
;2334:	dp->goal_activation = TFGA_TOUCH;
ADDRLP4 0
INDIRP4
CNSTI4 1128
ADDP4
CNSTI4 1
ASGNI4
line 2335
;2335:	dp->team_no = 1;
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
CNSTI4 1
ASGNI4
line 2336
;2336:	dp->items_allowed = 2;
ADDRLP4 0
INDIRP4
CNSTI4 920
ADDP4
CNSTI4 2
ASGNI4
line 2337
;2337:	dp->goal_no = 3;
ADDRLP4 0
INDIRP4
CNSTI4 1112
ADDP4
CNSTI4 3
ASGNI4
line 2338
;2338:	dp->goal_effects = TFGE_AP | TFGE_AP_TEAM;
ADDRLP4 0
INDIRP4
CNSTI4 1132
ADDP4
CNSTI4 3
ASGNI4
line 2339
;2339:	dp->broadcast = " цаптуред the enemy flag!\n";
ADDRLP4 0
INDIRP4
CNSTI4 1332
ADDP4
ADDRGP4 $1282
ASGNP4
line 2340
;2340:	dp->s.v.message = "You цаптуред the enemy flag!\n";
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
ADDRGP4 $1283
ASGNP4
line 2341
;2341:	dp->s.v.noise = "boss2/pop2.wav";
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $1277
ASGNP4
line 2342
;2342:	dp->goal_result = TFGR_ADD_BONUSES;
ADDRLP4 0
INDIRP4
CNSTI4 1136
ADDP4
CNSTI4 2
ASGNI4
line 2343
;2343:	dp->activate_goal_no = 5;
ADDRLP4 0
INDIRP4
CNSTI4 1172
ADDP4
CNSTI4 5
ASGNI4
line 2344
;2344:	dp->axhitme = 2;
ADDRLP4 0
INDIRP4
CNSTI4 780
ADDP4
CNSTF4 1073741824
ASGNF4
line 2345
;2345:	dp->count = 10;
ADDRLP4 0
INDIRP4
CNSTI4 684
ADDP4
CNSTF4 1092616192
ASGNF4
line 2346
;2346:	dp->s.v.frags = 10;
ADDRLP4 0
INDIRP4
CNSTI4 300
ADDP4
CNSTF4 1092616192
ASGNF4
line 2347
;2347:	dp->s.v.solid = SOLID_TRIGGER;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 2348
;2348:	dp->goal_state = 2;
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
line 2349
;2349:	SetVector( dp->goal_min, -16, -16, -24 );
ADDRLP4 0
INDIRP4
CNSTI4 1204
ADDP4
CNSTF4 3246391296
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 1208
ADDP4
CNSTF4 3246391296
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 1212
ADDP4
CNSTF4 3250585600
ASGNF4
line 2350
;2350:	SetVector( dp->goal_max, 16, 16, 32 );
ADDRLP4 0
INDIRP4
CNSTI4 1216
ADDP4
CNSTF4 1098907648
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 1220
ADDP4
CNSTF4 1098907648
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 1224
ADDP4
CNSTF4 1107296256
ASGNF4
line 2351
;2351:	setsize( dp, PASSVEC3( dp->goal_min ), PASSVEC3( dp->goal_max ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1204
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1208
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1212
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1216
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1220
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1224
ADDP4
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 2352
;2352:	dp->s.v.nextthink = g_globalvars.time + 0.2;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 2353
;2353:	dp->s.v.think = ( func_t ) TF_PlaceGoal;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 TF_PlaceGoal
CVPU4 4
CVUI4 4
ASGNI4
line 2354
;2354:	dp = spawn(  );
ADDRLP4 24
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 2355
;2355:	VectorCopy( dp->s.v.origin, dp->s.v.origin );
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
ASGNF4
line 2356
;2356:	dp->s.v.classname = "info_tfgoal";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $49
ASGNP4
line 2357
;2357:	dp->goal_effects = TFGE_AP;
ADDRLP4 0
INDIRP4
CNSTI4 1132
ADDP4
CNSTI4 1
ASGNI4
line 2358
;2358:	dp->s.v.frags = 5;
ADDRLP4 0
INDIRP4
CNSTI4 300
ADDP4
CNSTF4 1084227584
ASGNF4
line 2359
;2359:	dp->goal_activation = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1128
ADDP4
CNSTI4 0
ASGNI4
line 2360
;2360:	dp->goal_no = 5;
ADDRLP4 0
INDIRP4
CNSTI4 1112
ADDP4
CNSTI4 5
ASGNI4
line 2361
;2361:	dp->s.v.solid = SOLID_NOT;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 2362
;2362:	dp->goal_state = 2;
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
line 2363
;2363:	SetVector( dp->goal_min, -16, -16, -24 );
ADDRLP4 0
INDIRP4
CNSTI4 1204
ADDP4
CNSTF4 3246391296
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 1208
ADDP4
CNSTF4 3246391296
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 1212
ADDP4
CNSTF4 3250585600
ASGNF4
line 2364
;2364:	SetVector( dp->goal_max, 16, 16, 32 );
ADDRLP4 0
INDIRP4
CNSTI4 1216
ADDP4
CNSTF4 1098907648
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 1220
ADDP4
CNSTF4 1098907648
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 1224
ADDP4
CNSTF4 1107296256
ASGNF4
line 2365
;2365:	setsize( dp, PASSVEC3( dp->goal_min ), PASSVEC3( dp->goal_max ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1204
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1208
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1212
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1216
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1220
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1224
ADDP4
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 2366
;2366:	dp->s.v.nextthink = g_globalvars.time + 0.2;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 2367
;2367:	dp->s.v.think = ( func_t ) TF_PlaceGoal;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 TF_PlaceGoal
CVPU4 4
CVUI4 4
ASGNI4
line 2368
;2368:}
LABELV $1275
endproc SP_item_flag_team2 40 28
export SP_item_flag_team1
proc SP_item_flag_team1 40 28
line 2371
;2369:
;2370:void SP_item_flag_team1(  )
;2371:{
line 2374
;2372:	gedict_t *dp;
;2373:
;2374:	CTF_Map = 1;
ADDRGP4 CTF_Map
CNSTI4 1
ASGNI4
line 2375
;2375:	UpdateAbbreviations( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 UpdateAbbreviations
CALLV
pop
line 2376
;2376:	trap_precache_sound( "ogre/ogwake.wav" );
ADDRGP4 $1276
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 2377
;2377:	trap_precache_sound( "boss2/pop2.wav" );
ADDRGP4 $1277
ARGP4
ADDRGP4 trap_precache_sound
CALLV
pop
line 2378
;2378:	self->s.v.classname = "item_tfgoal";
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $220
ASGNP4
line 2379
;2379:	self->s.v.netname = "Team 2 Flag";
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $1287
ASGNP4
line 2380
;2380:	self->broadcast = " гот the enemy team's flag!\n";
ADDRGP4 self
INDIRP4
CNSTI4 1332
ADDP4
ADDRGP4 $1279
ASGNP4
line 2381
;2381:	self->deathtype = "You've got the enemy flag!\n";
ADDRGP4 self
INDIRP4
CNSTI4 804
ADDP4
ADDRGP4 $1280
ASGNP4
line 2382
;2382:	self->s.v.noise = "ogre/ogwake.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $1276
ASGNP4
line 2386
;2383://	if ( tf_data.toggleflags & TFLAG_USE_WAR_STD )
;2384://		self->mdl = "progs/tf_stan.mdl";
;2385://	else
;2386:		self->mdl = "progs/tf_flag.mdl";
ADDRGP4 self
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $1053
ASGNP4
line 2387
;2387:	setmodel( self, self->mdl );
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 2388
;2388:	self->s.v.skin = 1;
ADDRGP4 self
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 1065353216
ASGNF4
line 2389
;2389:	self->goal_no = 2;
ADDRGP4 self
INDIRP4
CNSTI4 1112
ADDP4
CNSTI4 2
ASGNI4
line 2390
;2390:	self->goal_activation = TFGI_GLOW | TFGI_DROP | TFGI_REMOVE | TFGI_RETURN_REMOVE | TFGI_RETURN_GOAL | TFGI_ITEMGLOWS;
ADDRGP4 self
INDIRP4
CNSTI4 1128
ADDP4
CNSTI4 693
ASGNI4
line 2391
;2391:	self->goal_effects = TFGE_AP;
ADDRGP4 self
INDIRP4
CNSTI4 1132
ADDP4
CNSTI4 1
ASGNI4
line 2392
;2392:	self->pausetime = 128;
ADDRGP4 self
INDIRP4
CNSTI4 676
ADDP4
CNSTF4 1124073472
ASGNF4
line 2393
;2393:	SetVector( self->goal_min, -16, -16, -24 );
ADDRGP4 self
INDIRP4
CNSTI4 1204
ADDP4
CNSTF4 3246391296
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1208
ADDP4
CNSTF4 3246391296
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1212
ADDP4
CNSTF4 3250585600
ASGNF4
line 2394
;2394:	SetVector( self->goal_max, 16, 16, 32 );
ADDRGP4 self
INDIRP4
CNSTI4 1216
ADDP4
CNSTF4 1098907648
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1220
ADDP4
CNSTF4 1098907648
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1224
ADDP4
CNSTF4 1107296256
ASGNF4
line 2395
;2395:	setsize( self, PASSVEC3( self->goal_min ), PASSVEC3( self->goal_max ) );
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1204
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 1208
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 1212
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 1216
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 1220
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 1224
ADDP4
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 2396
;2396:	self->s.v.touch = ( func_t ) item_tfgoal_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 item_tfgoal_touch
CVPU4 4
CVUI4 4
ASGNI4
line 2397
;2397:	self->goal_state = 2;
ADDRGP4 self
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
line 2398
;2398:	self->s.v.solid = SOLID_TRIGGER;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 2399
;2399:	setorigin( self, PASSVEC3( self->s.v.origin ) );
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
line 2400
;2400:	self->s.v.nextthink = g_globalvars.time + 0.2;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 2401
;2401:	self->s.v.think = ( func_t ) TF_PlaceItem;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 TF_PlaceItem
CVPU4 4
CVUI4 4
ASGNI4
line 2402
;2402:	dp = spawn(  );
ADDRLP4 16
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 2403
;2403:	VectorCopy( self->s.v.origin, dp->s.v.origin );
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
line 2404
;2404:	dp->s.v.classname = "info_tfgoal";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $49
ASGNP4
line 2405
;2405:	dp->goal_activation = TFGA_TOUCH;
ADDRLP4 0
INDIRP4
CNSTI4 1128
ADDP4
CNSTI4 1
ASGNI4
line 2406
;2406:	dp->team_no = 2;
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
CNSTI4 2
ASGNI4
line 2407
;2407:	dp->items_allowed = 1;
ADDRLP4 0
INDIRP4
CNSTI4 920
ADDP4
CNSTI4 1
ASGNI4
line 2408
;2408:	dp->goal_no = 4;
ADDRLP4 0
INDIRP4
CNSTI4 1112
ADDP4
CNSTI4 4
ASGNI4
line 2409
;2409:	dp->goal_effects = TFGE_AP | TFGE_AP_TEAM;
ADDRLP4 0
INDIRP4
CNSTI4 1132
ADDP4
CNSTI4 3
ASGNI4
line 2410
;2410:	dp->broadcast = " цаптуред the enemy flag!\n";
ADDRLP4 0
INDIRP4
CNSTI4 1332
ADDP4
ADDRGP4 $1282
ASGNP4
line 2411
;2411:	dp->s.v.message = "You цаптуред the enemy flag!\n";
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
ADDRGP4 $1283
ASGNP4
line 2412
;2412:	dp->s.v.noise = "boss2/pop2.wav";
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $1277
ASGNP4
line 2413
;2413:	dp->goal_result = TFGR_ADD_BONUSES;
ADDRLP4 0
INDIRP4
CNSTI4 1136
ADDP4
CNSTI4 2
ASGNI4
line 2414
;2414:	dp->activate_goal_no = 6;
ADDRLP4 0
INDIRP4
CNSTI4 1172
ADDP4
CNSTI4 6
ASGNI4
line 2415
;2415:	dp->axhitme = 1;
ADDRLP4 0
INDIRP4
CNSTI4 780
ADDP4
CNSTF4 1065353216
ASGNF4
line 2416
;2416:	dp->count = 10;
ADDRLP4 0
INDIRP4
CNSTI4 684
ADDP4
CNSTF4 1092616192
ASGNF4
line 2417
;2417:	dp->s.v.frags = 10;
ADDRLP4 0
INDIRP4
CNSTI4 300
ADDP4
CNSTF4 1092616192
ASGNF4
line 2418
;2418:	dp->s.v.solid = SOLID_TRIGGER;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 2419
;2419:	dp->goal_state = 2;
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
line 2420
;2420:	SetVector( dp->goal_min, -16, -16, -24 );
ADDRLP4 0
INDIRP4
CNSTI4 1204
ADDP4
CNSTF4 3246391296
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 1208
ADDP4
CNSTF4 3246391296
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 1212
ADDP4
CNSTF4 3250585600
ASGNF4
line 2421
;2421:	SetVector( dp->goal_max, 16, 16, 32 );
ADDRLP4 0
INDIRP4
CNSTI4 1216
ADDP4
CNSTF4 1098907648
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 1220
ADDP4
CNSTF4 1098907648
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 1224
ADDP4
CNSTF4 1107296256
ASGNF4
line 2422
;2422:	setsize( dp, PASSVEC3( dp->goal_min ), PASSVEC3( dp->goal_max ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1204
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1208
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1212
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1216
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1220
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1224
ADDP4
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 2423
;2423:	dp->s.v.nextthink = g_globalvars.time + 0.2;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 2424
;2424:	dp->s.v.think = ( func_t ) TF_PlaceGoal;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 TF_PlaceGoal
CVPU4 4
CVUI4 4
ASGNI4
line 2425
;2425:	dp = spawn(  );
ADDRLP4 24
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 2426
;2426:	VectorCopy( dp->s.v.origin, dp->s.v.origin );
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
ASGNF4
line 2427
;2427:	dp->s.v.classname = "info_tfgoal";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $49
ASGNP4
line 2428
;2428:	dp->goal_effects = TFGE_AP;
ADDRLP4 0
INDIRP4
CNSTI4 1132
ADDP4
CNSTI4 1
ASGNI4
line 2429
;2429:	dp->s.v.frags = 5;
ADDRLP4 0
INDIRP4
CNSTI4 300
ADDP4
CNSTF4 1084227584
ASGNF4
line 2430
;2430:	dp->goal_activation = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1128
ADDP4
CNSTI4 0
ASGNI4
line 2431
;2431:	dp->goal_no = 6;
ADDRLP4 0
INDIRP4
CNSTI4 1112
ADDP4
CNSTI4 6
ASGNI4
line 2432
;2432:	dp->s.v.solid = SOLID_NOT;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 2433
;2433:	dp->goal_state = 2;
ADDRLP4 0
INDIRP4
CNSTI4 1120
ADDP4
CNSTI4 2
ASGNI4
line 2434
;2434:	SetVector( dp->goal_min, -16, -16, -24 );
ADDRLP4 0
INDIRP4
CNSTI4 1204
ADDP4
CNSTF4 3246391296
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 1208
ADDP4
CNSTF4 3246391296
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 1212
ADDP4
CNSTF4 3250585600
ASGNF4
line 2435
;2435:	SetVector( dp->goal_max, 16, 16, 32 );
ADDRLP4 0
INDIRP4
CNSTI4 1216
ADDP4
CNSTF4 1098907648
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 1220
ADDP4
CNSTF4 1098907648
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 1224
ADDP4
CNSTF4 1107296256
ASGNF4
line 2436
;2436:	setsize( dp, PASSVEC3( dp->goal_min ), PASSVEC3( dp->goal_max ) );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1204
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1208
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1212
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1216
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1220
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 1224
ADDP4
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 2437
;2437:	dp->s.v.nextthink = g_globalvars.time + 0.2;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 2438
;2438:	dp->s.v.think = ( func_t ) TF_PlaceGoal;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 TF_PlaceGoal
CVPU4 4
CVUI4 4
ASGNI4
line 2439
;2439:}
LABELV $1286
endproc SP_item_flag_team1 40 28
export CTF_FlagCheck
proc CTF_FlagCheck 28 12
line 2442
;2440:
;2441:void CTF_FlagCheck(  )
;2442:{
line 2447
;2443:	gedict_t *te;
;2444:	float   flagcount;
;2445:	float   pos;
;2446:
;2447:	flagcount = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 2448
;2448:	te = trap_find( world, FOFS( s.v.classname ), "item_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
ADDRGP4 $1293
JUMPV
LABELV $1292
line 2450
;2449:	while ( te )
;2450:	{
line 2451
;2451:		if ( te->goal_no == 1 )
ADDRLP4 0
INDIRP4
CNSTI4 1112
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1295
line 2452
;2452:		{
line 2453
;2453:			pos = trap_pointcontents( PASSVEC3( te->s.v.origin ) );
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
ADDRLP4 20
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
CVIF4 4
ASGNF4
line 2454
;2454:			if ( pos == -2 || pos == -6 )
ADDRLP4 4
INDIRF4
CNSTF4 3221225472
EQF4 $1299
ADDRLP4 4
INDIRF4
CNSTF4 3233808384
NEF4 $1297
LABELV $1299
line 2455
;2455:			{
line 2456
;2456:				G_conprintf( "*****BUG*****\nFlag(s) outside world.\nPlease report this.\n" );
ADDRGP4 $1300
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
line 2457
;2457:				te->s.v.nextthink = g_globalvars.time + 0.2;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 2458
;2458:				te->s.v.think = ( func_t ) tfgoalitem_remove;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 tfgoalitem_remove
CVPU4 4
CVUI4 4
ASGNI4
line 2459
;2459:			}
LABELV $1297
line 2460
;2460:			flagcount = flagcount + 1;
ADDRLP4 8
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2461
;2461:		} else
ADDRGP4 $1296
JUMPV
LABELV $1295
line 2462
;2462:		{
line 2463
;2463:			if ( te->goal_no == 2 )
ADDRLP4 0
INDIRP4
CNSTI4 1112
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1302
line 2464
;2464:			{
line 2465
;2465:				pos = trap_pointcontents( PASSVEC3( te->s.v.origin ) );
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
ADDRLP4 20
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
CVIF4 4
ASGNF4
line 2466
;2466:				if ( pos == -2 || pos == -6 )
ADDRLP4 4
INDIRF4
CNSTF4 3221225472
EQF4 $1306
ADDRLP4 4
INDIRF4
CNSTF4 3233808384
NEF4 $1304
LABELV $1306
line 2467
;2467:				{
line 2468
;2468:					G_conprintf( "*****BUG*****\nFlag(s) outside world.\nPlease report this.\n" );
ADDRGP4 $1300
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
line 2469
;2469:					te->s.v.nextthink = g_globalvars.time + 0.2;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 2470
;2470:					te->s.v.think = ( func_t ) tfgoalitem_remove;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 tfgoalitem_remove
CVPU4 4
CVUI4 4
ASGNI4
line 2471
;2471:				}
LABELV $1304
line 2472
;2472:				flagcount = flagcount + 1;
ADDRLP4 8
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2473
;2473:			}
LABELV $1302
line 2474
;2474:		}
LABELV $1296
line 2475
;2475:		te = trap_find( te, FOFS( s.v.classname ), "item_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 2476
;2476:	}
LABELV $1293
line 2449
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1292
line 2477
;2477:	if ( flagcount != 2 )
ADDRLP4 8
INDIRF4
CNSTF4 1073741824
EQF4 $1308
line 2478
;2478:		G_conprintf( "*****BUG*****\nFlag(s) missing.\nPlease report this.\n" );
ADDRGP4 $1310
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
LABELV $1308
line 2479
;2479:	self->s.v.nextthink = g_globalvars.time + 30;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 2480
;2480:}
LABELV $1291
endproc CTF_FlagCheck 28 12
export ForceRespawn
proc ForceRespawn 44 12
line 2483
;2481:
;2482:void ForceRespawn( gedict_t * P )
;2483:{
line 2489
;2484:	gedict_t *spot;
;2485:	gedict_t *te;
;2486:	gedict_t *oldself;
;2487:	vec3_t  tmp;
;2488:
;2489:	oldself = self;
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
line 2490
;2490:	self = P;
ADDRGP4 self
ADDRFP4 0
INDIRP4
ASGNP4
line 2491
;2491:	spot = SelectSpawnPoint(  );
ADDRLP4 24
ADDRGP4 SelectSpawnPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 2492
;2492:	if ( self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1313
line 2493
;2493:		spawn_tdeath( spot->s.v.origin, self );
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 spawn_tdeath
CALLV
pop
LABELV $1313
line 2494
;2494:	self->observer_list = spot;
ADDRGP4 self
INDIRP4
CNSTI4 900
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 2495
;2495:	VectorCopy( spot->s.v.origin, self->s.v.origin );
ADDRLP4 28
CNSTI4 156
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 32
CNSTI4 160
ASGNI4
ADDRGP4 self
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
CNSTI4 164
ASGNI4
ADDRGP4 self
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
line 2496
;2496:	self->s.v.origin[2] += 1;
ADDRLP4 28
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2497
;2497:	VectorCopy( spot->s.v.angles, self->s.v.angles );
ADDRLP4 32
CNSTI4 192
ASGNI4
ADDRGP4 self
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
CNSTI4 196
ASGNI4
ADDRGP4 self
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
CNSTI4 200
ASGNI4
ADDRGP4 self
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
line 2498
;2498:	self->s.v.fixangle = 1;
ADDRGP4 self
INDIRP4
CNSTI4 380
ADDP4
CNSTF4 1065353216
ASGNF4
line 2499
;2499:	if ( streq( spot->s.v.classname, "info_player_teamspawn" ) && tf_data.cb_prematch_time < g_globalvars.time )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $80
ARGP4
ADDRLP4 32
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $1315
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $1315
line 2500
;2500:	{
line 2501
;2501:		if ( spot->s.v.items )
ADDRLP4 0
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1319
line 2502
;2502:		{
line 2503
;2503:			te = Finditem( spot->s.v.items );
ADDRLP4 0
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 36
ADDRGP4 Finditem
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 36
INDIRP4
ASGNP4
line 2504
;2504:			if ( te != world )
ADDRLP4 20
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $1321
line 2505
;2505:				tfgoalitem_GiveToPlayer( te, self, self );
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 tfgoalitem_GiveToPlayer
CALLV
pop
LABELV $1321
line 2506
;2506:			if ( !( spot->goal_activation & TFSP_MULTIPLEITEMS ) )
ADDRLP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1323
line 2507
;2507:				spot->s.v.items = 0;
ADDRLP4 0
INDIRP4
CNSTI4 336
ADDP4
CNSTF4 0
ASGNF4
LABELV $1323
line 2508
;2508:		}
LABELV $1319
line 2509
;2509:		if ( spot->s.v.message )
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1325
line 2510
;2510:		{
line 2511
;2511:			CenterPrint( self, spot->s.v.message );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 2512
;2512:			if ( !( spot->goal_activation & TFSP_MULTIPLEMSGS ) )
ADDRLP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $1327
line 2513
;2513:				spot->s.v.message = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
CNSTP4 0
ASGNP4
LABELV $1327
line 2514
;2514:		}
LABELV $1325
line 2515
;2515:		if ( spot->activate_goal_no )
ADDRLP4 0
INDIRP4
CNSTI4 1172
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1329
line 2516
;2516:		{
line 2517
;2517:			te = Findgoal( spot->activate_goal_no );
ADDRLP4 0
INDIRP4
CNSTI4 1172
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 Findgoal
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 36
INDIRP4
ASGNP4
line 2518
;2518:			if ( te )
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1331
line 2519
;2519:				AttemptToActivate( te, self, spot );
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 AttemptToActivate
CALLV
pop
LABELV $1331
line 2520
;2520:		}
LABELV $1329
line 2521
;2521:		if ( spot->goal_effects == TFGE_AP )
ADDRLP4 0
INDIRP4
CNSTI4 1132
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1333
line 2522
;2522:		{
line 2523
;2523:			spot->s.v.classname = "deadpoint";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $1335
ASGNP4
line 2524
;2524:			spot->team_str_home = "";
ADDRLP4 0
INDIRP4
CNSTI4 1284
ADDP4
ADDRGP4 $128
ASGNP4
line 2525
;2525:			spot->s.v.nextthink = g_globalvars.time + 1;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2526
;2526:			spot->s.v.think = ( func_t ) SUB_Remove;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 2527
;2527:		}
LABELV $1333
line 2528
;2528:	}
LABELV $1315
line 2529
;2529:	if ( deathmatch || coop )
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRGP4 deathmatch
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $1339
ADDRGP4 coop
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $1337
LABELV $1339
line 2530
;2530:	{
line 2531
;2531:		makevectors( self->s.v.angles );
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 2532
;2532:		if ( self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1340
line 2533
;2533:		{
line 2534
;2534:			VectorScale( g_globalvars.v_forward, 20, tmp );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1101004800
ARGF4
ADDRLP4 8
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 2535
;2535:			VectorAdd( tmp, self->s.v.origin, tmp );
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 8+4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2536
;2536:			spawn_tfog( tmp );
ADDRLP4 8
ARGP4
ADDRGP4 spawn_tfog
CALLV
pop
line 2537
;2537:		}
LABELV $1340
line 2538
;2538:	}
LABELV $1337
line 2539
;2539:	self = oldself;
ADDRGP4 self
ADDRLP4 4
INDIRP4
ASGNP4
line 2540
;2540:}
LABELV $1312
endproc ForceRespawn 44 12
export DropGoalItems
proc DropGoalItems 20 12
line 2543
;2541:
;2542:void DropGoalItems(  )
;2543:{
line 2546
;2544:	gedict_t *te;
;2545:
;2546:	newmis = spawn(); 
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 4
INDIRP4
ASGNP4
line 2547
;2547:	g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 2548
;2548:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 2549
;2549:	VectorNormalize( g_globalvars.v_forward );
ADDRGP4 g_globalvars+228
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2550
;2550:	VectorScale( g_globalvars.v_forward, 64, g_globalvars.v_forward );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1115684864
ARGF4
ADDRGP4 g_globalvars+228
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 2552
;2551:
;2552:	VectorAdd( g_globalvars.v_forward, self->s.v.origin, newmis->s.v.origin );
ADDRLP4 8
CNSTI4 156
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDRGP4 g_globalvars+228
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12
CNSTI4 160
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
ADDRGP4 g_globalvars+228+4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16
CNSTI4 164
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ADDRGP4 g_globalvars+228+8
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2553
;2553:	te = trap_find( world, FOFS( s.v.classname ), "item_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $1358
JUMPV
LABELV $1357
line 2555
;2554:	while ( te )
;2555:	{
line 2556
;2556:		if ( te->s.v.owner == EDICT_TO_PROG( self ) )
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
NEI4 $1360
line 2557
;2557:		{
line 2558
;2558:			if ( ( te->goal_activation & TFGI_ALLOW_DROP ) || tf_data.allow_drop_goal )
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ADDRLP4 12
INDIRI4
NEI4 $1365
ADDRGP4 tf_data+76
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $1362
LABELV $1365
line 2559
;2559:				tfgoalitem_RemoveFromPlayer( te, self, 2 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 tfgoalitem_RemoveFromPlayer
CALLV
pop
LABELV $1362
line 2560
;2560:		}
LABELV $1360
line 2561
;2561:		te = trap_find( te, FOFS( s.v.classname ), "item_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $220
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 2562
;2562:	}
LABELV $1358
line 2554
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1357
line 2563
;2563:	dremove( newmis );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 2564
;2564:}
LABELV $1347
endproc DropGoalItems 20 12
import team_spawn_str
bss
align 4
LABELV item_list_bit
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
import TeamFortress_TeamIncreaseScore
import TeamFortress_DisplayDetectionItems
import SetupTeamEqualiser
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
import rj
export CTF_Map
align 4
LABELV CTF_Map
skip 4
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
LABELV $1335
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $1310
byte 1 42
byte 1 42
byte 1 42
byte 1 42
byte 1 42
byte 1 66
byte 1 85
byte 1 71
byte 1 42
byte 1 42
byte 1 42
byte 1 42
byte 1 42
byte 1 10
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 40
byte 1 115
byte 1 41
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 10
byte 1 80
byte 1 108
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1300
byte 1 42
byte 1 42
byte 1 42
byte 1 42
byte 1 42
byte 1 66
byte 1 85
byte 1 71
byte 1 42
byte 1 42
byte 1 42
byte 1 42
byte 1 42
byte 1 10
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 40
byte 1 115
byte 1 41
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 115
byte 1 105
byte 1 100
byte 1 101
byte 1 32
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 46
byte 1 10
byte 1 80
byte 1 108
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1287
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 50
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $1283
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 195
byte 1 193
byte 1 208
byte 1 212
byte 1 213
byte 1 210
byte 1 197
byte 1 196
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1282
byte 1 32
byte 1 195
byte 1 193
byte 1 208
byte 1 212
byte 1 213
byte 1 210
byte 1 197
byte 1 196
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1280
byte 1 89
byte 1 111
byte 1 117
byte 1 39
byte 1 118
byte 1 101
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1279
byte 1 32
byte 1 199
byte 1 207
byte 1 212
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1278
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 49
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $1277
byte 1 98
byte 1 111
byte 1 115
byte 1 115
byte 1 50
byte 1 47
byte 1 112
byte 1 111
byte 1 112
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1276
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 47
byte 1 111
byte 1 103
byte 1 119
byte 1 97
byte 1 107
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1274
byte 1 116
byte 1 115
byte 1 49
byte 1 0
align 1
LABELV $1272
byte 1 116
byte 1 115
byte 1 50
byte 1 0
align 1
LABELV $1270
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1264
byte 1 32
byte 1 58
byte 1 37
byte 1 51
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1245
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1244
byte 1 89
byte 1 111
byte 1 117
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1241
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1238
byte 1 37
byte 1 115
byte 1 32
byte 1 0
align 1
LABELV $1157
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 109
byte 1 101
byte 1 116
byte 1 104
byte 1 111
byte 1 100
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 102
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 82
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 70
byte 1 114
byte 1 111
byte 1 109
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $1086
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 116
byte 1 102
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 82
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 70
byte 1 114
byte 1 111
byte 1 109
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 40
byte 1 41
byte 1 58
byte 1 32
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 0
align 1
LABELV $1053
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 116
byte 1 102
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $959
byte 1 10
byte 1 10
byte 1 10
byte 1 32
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 197
byte 1 206
byte 1 197
byte 1 205
byte 1 217
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 210
byte 1 197
byte 1 212
byte 1 213
byte 1 210
byte 1 206
byte 1 197
byte 1 196
byte 1 33
byte 1 33
byte 1 0
align 1
LABELV $958
byte 1 10
byte 1 10
byte 1 10
byte 1 32
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 210
byte 1 197
byte 1 212
byte 1 213
byte 1 210
byte 1 206
byte 1 197
byte 1 196
byte 1 33
byte 1 33
byte 1 0
align 1
LABELV $952
byte 1 37
byte 1 115
byte 1 32
byte 1 210
byte 1 197
byte 1 212
byte 1 213
byte 1 210
byte 1 206
byte 1 197
byte 1 196
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
LABELV $943
byte 1 10
byte 1 10
byte 1 10
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 197
byte 1 206
byte 1 197
byte 1 205
byte 1 217
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 210
byte 1 197
byte 1 212
byte 1 213
byte 1 210
byte 1 206
byte 1 197
byte 1 196
byte 1 33
byte 1 33
byte 1 0
align 1
LABELV $942
byte 1 10
byte 1 10
byte 1 10
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 210
byte 1 197
byte 1 212
byte 1 213
byte 1 210
byte 1 206
byte 1 197
byte 1 196
byte 1 33
byte 1 33
byte 1 0
align 1
LABELV $936
byte 1 37
byte 1 115
byte 1 32
byte 1 210
byte 1 197
byte 1 212
byte 1 213
byte 1 210
byte 1 206
byte 1 197
byte 1 196
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
LABELV $850
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $835
byte 1 10
byte 1 10
byte 1 10
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $826
byte 1 37
byte 1 115
byte 1 32
byte 1 195
byte 1 193
byte 1 208
byte 1 212
byte 1 213
byte 1 210
byte 1 197
byte 1 196
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
LABELV $816
byte 1 37
byte 1 115
byte 1 32
byte 1 195
byte 1 193
byte 1 208
byte 1 212
byte 1 213
byte 1 210
byte 1 197
byte 1 196
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
LABELV $815
byte 1 10
byte 1 10
byte 1 10
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 195
byte 1 193
byte 1 208
byte 1 212
byte 1 213
byte 1 210
byte 1 197
byte 1 196
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 33
byte 1 0
align 1
LABELV $814
byte 1 10
byte 1 10
byte 1 10
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 195
byte 1 193
byte 1 208
byte 1 212
byte 1 213
byte 1 210
byte 1 197
byte 1 196
byte 1 33
byte 1 33
byte 1 0
align 1
LABELV $813
byte 1 10
byte 1 10
byte 1 10
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 195
byte 1 193
byte 1 208
byte 1 212
byte 1 213
byte 1 210
byte 1 197
byte 1 196
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 33
byte 1 0
align 1
LABELV $803
byte 1 37
byte 1 115
byte 1 32
byte 1 199
byte 1 207
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
LABELV $793
byte 1 37
byte 1 115
byte 1 32
byte 1 199
byte 1 207
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
LABELV $788
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $753
byte 1 10
byte 1 10
byte 1 10
byte 1 73
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 112
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 10
byte 1 111
byte 1 114
byte 1 32
byte 1 97
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 106
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 104
byte 1 97
byte 1 112
byte 1 112
byte 1 121
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 101
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 63
byte 1 0
align 1
LABELV $752
byte 1 10
byte 1 10
byte 1 10
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $751
byte 1 10
byte 1 10
byte 1 10
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 10
byte 1 60
byte 1 73
byte 1 110
byte 1 115
byte 1 101
byte 1 114
byte 1 116
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 116
byte 1 121
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 62
byte 1 0
align 1
LABELV $750
byte 1 10
byte 1 10
byte 1 10
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 10
byte 1 82
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 33
byte 1 0
align 1
LABELV $749
byte 1 10
byte 1 10
byte 1 10
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 10
byte 1 72
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 104
byte 1 111
byte 1 109
byte 1 101
byte 1 33
byte 1 0
align 1
LABELV $748
byte 1 10
byte 1 10
byte 1 10
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 10
byte 1 70
byte 1 108
byte 1 101
byte 1 101
byte 1 33
byte 1 0
align 1
LABELV $746
byte 1 10
byte 1 10
byte 1 10
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 212
byte 1 193
byte 1 203
byte 1 197
byte 1 206
byte 1 33
byte 1 33
byte 1 0
align 1
LABELV $744
byte 1 10
byte 1 10
byte 1 10
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 199
byte 1 207
byte 1 212
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 197
byte 1 206
byte 1 197
byte 1 205
byte 1 217
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 33
byte 1 0
align 1
LABELV $705
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 45
byte 1 62
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 32
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 102
byte 1 105
byte 1 101
byte 1 100
byte 1 44
byte 1 32
byte 1 98
byte 1 117
byte 1 116
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 46
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 95
byte 1 102
byte 1 105
byte 1 110
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $689
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 46
byte 1 100
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 102
byte 1 105
byte 1 101
byte 1 100
byte 1 44
byte 1 32
byte 1 98
byte 1 117
byte 1 116
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 46
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 95
byte 1 102
byte 1 105
byte 1 110
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $630
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 46
byte 1 97
byte 1 108
byte 1 108
byte 1 95
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 102
byte 1 105
byte 1 101
byte 1 100
byte 1 44
byte 1 32
byte 1 98
byte 1 117
byte 1 116
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 46
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 95
byte 1 105
byte 1 109
byte 1 112
byte 1 117
byte 1 108
byte 1 115
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $391
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $325
byte 1 112
byte 1 114
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $296
byte 1 98
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $240
byte 1 67
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 32
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 95
byte 1 110
byte 1 111
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $233
byte 1 67
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 32
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 95
byte 1 110
byte 1 111
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $226
byte 1 67
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 32
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 95
byte 1 110
byte 1 111
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $220
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
LABELV $155
byte 1 77
byte 1 101
byte 1 103
byte 1 97
byte 1 84
byte 1 70
byte 1 50
byte 1 48
byte 1 48
byte 1 54
byte 1 32
byte 1 49
byte 1 49
byte 1 46
byte 1 48
byte 1 50
byte 1 46
byte 1 48
byte 1 54
byte 1 97
byte 1 10
byte 1 0
align 1
LABELV $154
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 0
align 1
LABELV $153
byte 1 53
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $152
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $138
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 0
align 1
LABELV $129
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 98
byte 1 107
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $128
byte 1 0
align 1
LABELV $115
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 32
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 32
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 102
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $98
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $97
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $96
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $95
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 118
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $94
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 118
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $93
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 118
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $92
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 115
byte 1 117
byte 1 105
byte 1 116
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $91
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 115
byte 1 117
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $90
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
LABELV $89
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
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $88
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
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $80
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $76
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 110
byte 1 111
byte 1 32
byte 1 97
byte 1 115
byte 1 115
byte 1 111
byte 1 99
byte 1 105
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $60
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $54
byte 1 71
byte 1 111
byte 1 97
byte 1 108
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
LABELV $49
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 116
byte 1 102
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $45
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 116
byte 1 102
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $33
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 73
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
LABELV $24
byte 1 117
byte 1 115
byte 1 101
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 100
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $23
byte 1 119
byte 1 115
byte 1 0
align 1
LABELV $22
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $19
byte 1 111
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $18
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 95
byte 1 101
byte 1 109
byte 1 117
byte 1 0
align 1
LABELV $17
byte 1 102
byte 1 101
byte 1 0
