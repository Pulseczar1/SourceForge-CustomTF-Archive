export player_touch
code
proc player_touch 60 16
file "..\src\player.c"
line 89
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
;21: *  $Id: player.c,v 1.16 2005/11/28 18:30:57 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:void player_diea1();
;26:void player_diea2();
;27:void player_diea3();
;28:void player_diea4();
;29:void player_diea5();
;30:void player_diea6();
;31:void player_diea7();
;32:void player_diea8();
;33:void player_diea9();
;34:void player_diea10();
;35:void player_diea11();
;36:void player_dieb1();
;37:void player_dieb2();
;38:void player_dieb3();
;39:void player_dieb4();
;40:void player_dieb5();
;41:void player_dieb6();
;42:void player_dieb7();
;43:void player_dieb8();
;44:void player_dieb9();
;45:void player_diec1();
;46:void player_diec2();
;47:void player_diec3();
;48:void player_diec4();
;49:void player_diec5();
;50:void player_diec6();
;51:void player_diec7();
;52:void player_diec8();
;53:void player_diec9();
;54:void player_diec10();
;55:void player_diec11();
;56:void player_diec12();
;57:void player_diec13();
;58:void player_diec14();
;59:void player_diec15();
;60:void player_died1();
;61:void player_died2();
;62:void player_died3();
;63:void player_died4();
;64:void player_died5();
;65:void player_died6();
;66:void player_died7();
;67:void player_died8();
;68:void player_died9();
;69:void player_diee1();
;70:void player_diee2();
;71:void player_diee3();
;72:void player_diee4();
;73:void player_diee5();
;74:void player_diee6();
;75:void player_diee7();
;76:void player_diee8();
;77:void player_diee9();
;78:void player_die_ax1();
;79:void player_die_ax2();
;80:void player_die_ax3();
;81:void player_die_ax4();
;82:void player_die_ax5();
;83:void player_die_ax6();
;84:void player_die_ax7();
;85:void player_die_ax8();
;86:void player_die_ax9();
;87:
;88:void player_touch(  )
;89:{
line 95
;90:	gedict_t *Bio;
;91:	gedict_t *te;
;92:
;93:	float   found;
;94:
;95:	if ( !tf_data.invis_only && ( self->playerclass == PC_SPY || other->playerclass == PC_SPY ) )
ADDRGP4 tf_data+60
INDIRI4
CNSTI4 0
NEI4 $12
ADDRLP4 12
CNSTI4 820
ASGNI4
ADDRLP4 16
CNSTI4 8
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $15
ADDRGP4 other
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $12
LABELV $15
line 96
;96:	{
line 97
;97:		if ( streq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $18
ARGP4
ADDRLP4 20
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $16
line 98
;98:		{
line 99
;99:			if ( self->undercover_team || self->undercover_skin )
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
NEI4 $21
ADDRLP4 24
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $19
LABELV $21
line 100
;100:			{
line 101
;101:				if ( ( other->playerclass == PC_SPY || other->playerclass == PC_SCOUT )
ADDRLP4 32
ADDRGP4 other
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 8
EQI4 $24
ADDRLP4 32
INDIRI4
CNSTI4 1
NEI4 $22
LABELV $24
ADDRLP4 36
CNSTI4 960
ASGNI4
ADDRGP4 other
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRGP4 self
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 TeamFortress_isTeamsAllied
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $22
line 103
;102:				     && !TeamFortress_isTeamsAllied (other->team_no , self->team_no) )
;103:				{
line 104
;104:					TF_AddFrags( other, 1 );
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
line 105
;105:					G_bprint( 1, "%s uncovered an enemy spy!\n", other->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $25
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
line 106
;106:					Spy_RemoveDisguise( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 Spy_RemoveDisguise
CALLV
pop
line 107
;107:				}
LABELV $22
line 108
;108:			}
LABELV $19
line 109
;109:			if ( other->undercover_team || other->undercover_skin )
ADDRLP4 32
ADDRGP4 other
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $28
ADDRLP4 32
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $26
LABELV $28
line 110
;110:			{
line 111
;111:				if ( ( self->playerclass == PC_SPY || self->playerclass == PC_SCOUT )
ADDRLP4 40
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 8
EQI4 $31
ADDRLP4 40
INDIRI4
CNSTI4 1
NEI4 $29
LABELV $31
ADDRLP4 44
CNSTI4 960
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRGP4 other
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 TeamFortress_isTeamsAllied
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $29
line 113
;112:				     && !TeamFortress_isTeamsAllied (self->team_no , other->team_no) )
;113:				{
line 114
;114:					TF_AddFrags( self, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
line 115
;115:					G_bprint( 1, "%s uncovered an enemy spy!\n", self->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $25
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
line 116
;116:					Spy_RemoveDisguise( other );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 Spy_RemoveDisguise
CALLV
pop
line 117
;117:				}
LABELV $29
line 118
;118:			}
LABELV $26
line 119
;119:		}
LABELV $16
line 120
;120:	}
LABELV $12
line 121
;121:	if ( ( self->tfstate & TFSTATE_INFECTED ) && tf_data.cb_prematch_time < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $32
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $32
line 122
;122:	{
line 123
;123:		if ( streq( other->s.v.classname, "player" ) && other->playerclass )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $18
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
EQI4 $36
ADDRGP4 other
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $36
line 124
;124:		{
line 125
;125:			if ( !( other->tfstate & TFSTATE_INFECTED ) )
ADDRGP4 other
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $38
line 126
;126:			{
line 127
;127:				if ( other->playerclass != PC_MEDIC )
ADDRGP4 other
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 5
EQI4 $40
line 128
;128:				{
line 129
;129:					if ( !
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRGP4 teamplay
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 28
INDIRI4
EQI4 $48
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
NEI4 $48
ADDRLP4 36
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
NEI4 $42
LABELV $48
line 134
;130:					     ( ( teamplay & 16 )
;131:					       && PROG_TO_EDICT( self->s.v.owner )->team_no ==
;132:					       PROG_TO_EDICT( self->s.v.enemy )->team_no
;133:					       && PROG_TO_EDICT( self->s.v.owner )->team_no ) )
;134:					{
line 135
;135:						found = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 136
;136:						te = trap_find( world, FOFS( s.v.classname ), "timer" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 40
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
ASGNP4
ADDRGP4 $51
JUMPV
LABELV $50
line 138
;137:						while ( te && !found )
;138:						{
line 139
;139:							if ( PROG_TO_EDICT( te->s.v.owner ) == self
ADDRLP4 44
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
ADDRGP4 self
INDIRP4
CVPU4 4
NEU4 $53
ADDRLP4 44
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ADDRGP4 BioInfection_Decay
CVPU4 4
CVUI4 4
NEI4 $53
line 141
;140:							     && te->s.v.think == ( func_t ) BioInfection_Decay )
;141:							     {
line 142
;142:								found = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 143
;143:								break;
ADDRGP4 $52
JUMPV
LABELV $53
line 146
;144:							     }
;145:							else
;146:								te = trap_find( te, FOFS( s.v.classname ), "timer" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 48
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 48
INDIRP4
ASGNP4
line 147
;147:						}
LABELV $51
line 137
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $55
ADDRLP4 4
INDIRF4
CNSTF4 0
EQF4 $50
LABELV $55
LABELV $52
line 148
;148:						if(!te)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $56
line 149
;149:						{
line 150
;150:							G_dprintf( "***BUG TFSTATE_INFECTED without BioInfection_Decay timer ***\n" );
ADDRGP4 $58
ARGP4
ADDRGP4 G_dprintf
CALLV
pop
line 151
;151:							return;
ADDRGP4 $11
JUMPV
LABELV $56
line 153
;152:						}
;153:						Bio = spawn(  );
ADDRLP4 44
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 44
INDIRP4
ASGNP4
line 154
;154:						Bio->s.v.nextthink = 2;
ADDRLP4 8
INDIRP4
CNSTI4 288
ADDP4
CNSTF4 1073741824
ASGNF4
line 155
;155:						Bio->s.v.think = ( func_t ) BioInfection_Decay;
ADDRLP4 8
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 BioInfection_Decay
CVPU4 4
CVUI4 4
ASGNI4
line 156
;156:						Bio->s.v.owner = EDICT_TO_PROG( other );
ADDRLP4 8
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
line 157
;157:						Bio->s.v.classname = "timer";
ADDRLP4 8
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $49
ASGNP4
line 158
;158:						Bio->s.v.enemy = te->s.v.enemy;
ADDRLP4 48
CNSTI4 400
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 159
;159:						other->tfstate = other->tfstate | TFSTATE_INFECTED;
ADDRLP4 52
ADDRGP4 other
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 160
;160:						other->infection_team_no = self->infection_team_no;
ADDRLP4 56
CNSTI4 968
ASGNI4
ADDRGP4 other
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
line 161
;161:						G_sprint( other, 1, "You have been infected by %s!\n",
ADDRGP4 other
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $59
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 163
;162:							  self->s.v.netname );
;163:						G_sprint( self, 1, "You have infected %s!\n", other->s.v.netname );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $60
ARGP4
ADDRGP4 other
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 164
;164:					}
LABELV $42
line 165
;165:				}
LABELV $40
line 166
;166:			}
LABELV $38
line 167
;167:		}
LABELV $36
line 168
;168:	}
LABELV $32
line 169
;169:}
LABELV $11
endproc player_touch 60 16
export player_stand1
proc player_stand1 20 8
line 171
;170:void player_stand1(  )
;171:{
line 172
;172:	self->s.v.frame = 17;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1099431936
ASGNF4
line 173
;173:	self->s.v.think = ( func_t ) player_stand1;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_stand1
CVPU4 4
CVUI4 4
ASGNI4
line 174
;174:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 176
;175:
;176:	self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 177
;177:	if ( self->s.v.velocity[0] || self->s.v.velocity[1] )
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
NEF4 $65
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
EQF4 $63
LABELV $65
line 178
;178:	{
line 179
;179:		self->walkframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 544
ADDP4
CNSTI4 0
ASGNI4
line 180
;180:		player_run();
ADDRGP4 player_run
CALLV
pop
line 181
;181:		return;
ADDRGP4 $61
JUMPV
LABELV $63
line 183
;182:	}
;183:	if ( self->is_squating == TRUE )
ADDRGP4 self
INDIRP4
CNSTI4 1776
ADDP4
INDIRI4
CNSTI4 1
NEI4 $66
line 184
;184:	{
line 185
;185:		lay ();
ADDRGP4 lay
CALLV
pop
line 186
;186:	}
LABELV $66
line 187
;187:	if ( self->current_weapon <= 16 )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 16
GTI4 $68
line 188
;188:	{
line 189
;189:		if ( self->walkframe >= 12 )
ADDRGP4 self
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 12
LTI4 $70
line 190
;190:			self->walkframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 544
ADDP4
CNSTI4 0
ASGNI4
LABELV $70
line 191
;191:		if ( self->is_squating == TRUE )
ADDRGP4 self
INDIRP4
CNSTI4 1776
ADDP4
INDIRI4
CNSTI4 1
NEI4 $72
line 192
;192:			self->s.v.frame = 57;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1113849856
ASGNF4
LABELV $72
line 193
;193:		self->s.v.frame = 17 + self->walkframe;
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 224
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 17
ADDI4
CVIF4 4
ASGNF4
line 194
;194:	} else
ADDRGP4 $69
JUMPV
LABELV $68
line 195
;195:	{
line 196
;196:		if ( self->walkframe >= 5 )
ADDRGP4 self
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 5
LTI4 $74
line 197
;197:			self->walkframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 544
ADDP4
CNSTI4 0
ASGNI4
LABELV $74
line 198
;198:		if ( self->is_squating == TRUE )
ADDRGP4 self
INDIRP4
CNSTI4 1776
ADDP4
INDIRI4
CNSTI4 1
NEI4 $76
line 199
;199:		{
line 200
;200:			self->s.v.frame = 57;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1113849856
ASGNF4
line 202
;201:			//G_centerprint ( self, "                  לבשימח\n" );
;202:			if ( self->current_menu == MENU_DEFAULT/* && ( self->s.v.classname != "player_prop" ) */)
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
CNSTI4 1
NEI4 $77
line 203
;203:			{
line 205
;204:				//G_centerprint ( self, "                  לבשימח\n" );
;205:				if ( !self->StatusBarSize )
ADDRGP4 self
INDIRP4
CNSTI4 1488
ADDP4
INDIRI4
CNSTI4 0
NEI4 $77
line 206
;206:				{
line 207
;207:					G_centerprint ( self, "                  לבשימח\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $82
ARGP4
ADDRGP4 G_centerprint
CALLV
pop
line 208
;208:				}
line 209
;209:			}
line 210
;210:		}
ADDRGP4 $77
JUMPV
LABELV $76
line 212
;211:		else
;212:			self->s.v.frame = 12 + self->walkframe;
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 224
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 12
ADDI4
CVIF4 4
ASGNF4
LABELV $77
line 213
;213:	}
LABELV $69
line 214
;214:	if ( self->walkframe == 1 && self->vision == 1 )
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
CNSTI4 1
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $83
ADDRLP4 8
INDIRP4
CNSTI4 1792
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $83
line 215
;215:		TeamFortress_NightVision ( );
ADDRGP4 TeamFortress_NightVision
CALLV
pop
LABELV $83
line 216
;216:	self->walkframe = self->walkframe + 1;
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 544
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 217
;217:}
LABELV $61
endproc player_stand1 20 8
export player_run
proc player_run 48 20
line 220
;218:
;219:void player_run(  )
;220:{
line 222
;221:	float fstep;		// determinee footstep sound
;222:	fstep = g_random( );
ADDRLP4 4
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 224
;223:
;224:	self->s.v.frame = 6;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1086324736
ASGNF4
line 225
;225:	self->s.v.think = ( func_t ) player_run;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_run
CVPU4 4
CVUI4 4
ASGNI4
line 226
;226:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 228
;227:
;228:	self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 229
;229:	if ( !self->s.v.velocity[0] && !self->s.v.velocity[1] )
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
NEF4 $87
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
NEF4 $87
line 230
;230:	{
line 231
;231:		self->walkframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 544
ADDP4
CNSTI4 0
ASGNI4
line 232
;232:		player_stand1(  );
ADDRGP4 player_stand1
CALLV
pop
line 233
;233:		return;
ADDRGP4 $85
JUMPV
LABELV $87
line 235
;234:	}
;235:	if ( self->is_squating == TRUE )
ADDRGP4 self
INDIRP4
CNSTI4 1776
ADDP4
INDIRI4
CNSTI4 1
NEI4 $89
line 236
;236:	{
line 237
;237:		unlay ( );
ADDRGP4 unlay
CALLV
pop
line 238
;238:	}
LABELV $89
line 239
;239:	if ( self->current_weapon <= 16 )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 16
GTI4 $91
line 240
;240:	{
line 241
;241:		if ( self->walkframe >= 6 )
ADDRGP4 self
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 6
LTI4 $93
line 242
;242:			self->walkframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 544
ADDP4
CNSTI4 0
ASGNI4
LABELV $93
line 243
;243:		self->s.v.frame = 0 + self->walkframe;
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 224
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 244
;244:	} else
ADDRGP4 $92
JUMPV
LABELV $91
line 245
;245:	{
line 246
;246:		if ( self->walkframe >= 6 )
ADDRGP4 self
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 6
LTI4 $95
line 247
;247:			self->walkframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 544
ADDP4
CNSTI4 0
ASGNI4
LABELV $95
line 248
;248:		self->s.v.frame = self->s.v.frame + self->walkframe;
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 224
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 249
;249:	}
LABELV $92
line 251
;250:	// footstep sounds
;251:	if ( tf_data.footsteps == 1 && checkbottom( self ) == 1 && self->playerclass != 0 ) {
ADDRGP4 tf_data+200
INDIRI4
CNSTI4 1
NEI4 $97
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 checkbottom
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
NEI4 $97
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
EQI4 $97
line 252
;252:		if ( self->s.v.velocity[0] > 200 || self->s.v.velocity[1] > 200 || self->s.v.velocity[0] < -200 || self->s.v.velocity[1] < -200 ) {
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ASGNF4
ADDRLP4 28
CNSTF4 1128792064
ASGNF4
ADDRLP4 24
INDIRF4
ADDRLP4 28
INDIRF4
GTF4 $104
ADDRLP4 32
ADDRLP4 20
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ASGNF4
ADDRLP4 32
INDIRF4
ADDRLP4 28
INDIRF4
GTF4 $104
ADDRLP4 36
CNSTF4 3276275712
ASGNF4
ADDRLP4 24
INDIRF4
ADDRLP4 36
INDIRF4
LTF4 $104
ADDRLP4 32
INDIRF4
ADDRLP4 36
INDIRF4
GEF4 $100
LABELV $104
line 253
;253:			if ( self->playerclass == 8 && self->undercover_skin == 0 ) {
ADDRLP4 40
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $105
ADDRLP4 40
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
CNSTI4 0
NEI4 $105
line 254
;254:				self->walkframe = self->walkframe + 1;
ADDRLP4 44
ADDRGP4 self
INDIRP4
CNSTI4 544
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 255
;255:				return;
ADDRGP4 $85
JUMPV
LABELV $105
line 257
;256:			}
;257:			if ( self->walkframe == 1 ) {
ADDRGP4 self
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 1
NEI4 $107
line 258
;258:				if ( self->vision == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 1792
ADDP4
INDIRI4
CNSTI4 1
NEI4 $109
line 259
;259:					TeamFortress_NightVision (  );
ADDRGP4 TeamFortress_NightVision
CALLV
pop
LABELV $109
line 260
;260:				if ( self->s.v.waterlevel == 0 ) {
ADDRGP4 self
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 0
NEF4 $111
line 261
;261:					if ( fstep < 0.6 )
ADDRLP4 0
INDIRF4
CNSTF4 1058642330
GEF4 $113
line 262
;262:						sound( self, 4, "player/step1l.wav", 0.8, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $115
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
ADDRGP4 $114
JUMPV
LABELV $113
line 264
;263:					else
;264:						sound( self, 2, "player/step2l.wav", 0.8, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $116
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
LABELV $114
line 265
;265:				}
LABELV $111
line 266
;266:				if ( self->s.v.waterlevel == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $117
line 267
;267:					sound( self, 2, "player/h2ojump.wav", 0.8, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $119
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
LABELV $117
line 268
;268:				if ( self->s.v.waterlevel == 2 )
ADDRGP4 self
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $120
line 269
;269:					sound( self, 2, "player/inh2o.wav", 0.8, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $122
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
LABELV $120
line 270
;270:			}
LABELV $107
line 271
;271:			if ( self->walkframe == 4 ) {
ADDRGP4 self
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 4
NEI4 $123
line 272
;272:				if ( self->s.v.waterlevel == 0 ) {
ADDRGP4 self
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 0
NEF4 $125
line 273
;273:					if ( fstep < 0.5 )
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
GEF4 $127
line 274
;274:						sound( self, 2, "player/step1r.wav", 0.8, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $129
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
ADDRGP4 $128
JUMPV
LABELV $127
line 276
;275:					else
;276:						sound( self, 2, "player/step2r.wav", 0.8, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $130
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
LABELV $128
line 277
;277:				}
LABELV $125
line 278
;278:				if ( self->s.v.waterlevel == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $131
line 279
;279:					sound ( self, 2, "player/h2ojump.wav", 0.8, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $119
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
LABELV $131
line 280
;280:				if ( self->s.v.waterlevel == 2 )
ADDRGP4 self
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $133
line 281
;281:					sound ( self, 2, "player/inh2o.wav", 0.8, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $122
ARGP4
CNSTF4 1061997773
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
LABELV $133
line 282
;282:			}
LABELV $123
line 283
;283:		}
LABELV $100
line 284
;284:	}
LABELV $97
line 285
;285:	self->walkframe = self->walkframe + 1;
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 544
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 286
;286:}
LABELV $85
endproc player_run 48 20
export player_shot1
proc player_shot1 0 0
line 289
;287:
;288:void player_shot1(  )
;289:{
line 290
;290:	self->s.v.frame = 113;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1122107392
ASGNF4
line 291
;291:	self->s.v.think = ( func_t ) player_shot2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_shot2
CVPU4 4
CVUI4 4
ASGNI4
line 292
;292:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 294
;293:
;294:	self->s.v.weaponframe = 1;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1065353216
ASGNF4
line 295
;295:	muzzleflash(  );
ADDRGP4 muzzleflash
CALLV
pop
line 296
;296:}
LABELV $135
endproc player_shot1 0 0
export player_shot2
proc player_shot2 0 0
line 299
;297:
;298:void player_shot2(  )
;299:{
line 300
;300:	self->s.v.frame = 114;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1122238464
ASGNF4
line 301
;301:	self->s.v.think = ( func_t ) player_shot3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_shot3
CVPU4 4
CVUI4 4
ASGNI4
line 302
;302:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 304
;303:
;304:	self->s.v.weaponframe = 2;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1073741824
ASGNF4
line 305
;305:}
LABELV $137
endproc player_shot2 0 0
export player_shot3
proc player_shot3 0 0
line 308
;306:
;307:void player_shot3(  )
;308:{
line 309
;309:	self->s.v.frame = 115;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1122369536
ASGNF4
line 310
;310:	self->s.v.think = ( func_t ) player_shot4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_shot4
CVPU4 4
CVUI4 4
ASGNI4
line 311
;311:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 313
;312:
;313:	self->s.v.weaponframe = 3;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1077936128
ASGNF4
line 314
;314:}
LABELV $139
endproc player_shot3 0 0
export player_shot4
proc player_shot4 0 0
line 317
;315:
;316:void player_shot4(  )
;317:{
line 318
;318:	self->s.v.frame = 116;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1122500608
ASGNF4
line 319
;319:	self->s.v.think = ( func_t ) player_shot5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_shot5
CVPU4 4
CVUI4 4
ASGNI4
line 320
;320:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 322
;321:
;322:	self->s.v.weaponframe = 4;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1082130432
ASGNF4
line 323
;323:}
LABELV $141
endproc player_shot4 0 0
export player_shot5
proc player_shot5 0 0
line 326
;324:
;325:void player_shot5(  )
;326:{
line 327
;327:	self->s.v.frame = 117;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1122631680
ASGNF4
line 328
;328:	self->s.v.think = ( func_t ) player_shot6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_shot6
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
;331:	self->s.v.weaponframe = 5;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1084227584
ASGNF4
line 332
;332:}
LABELV $143
endproc player_shot5 0 0
export player_shot6
proc player_shot6 0 0
line 335
;333:
;334:void player_shot6(  )
;335:{
line 336
;336:	self->s.v.frame = 118;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1122762752
ASGNF4
line 337
;337:	self->s.v.think = ( func_t ) player_run;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_run
CVPU4 4
CVUI4 4
ASGNI4
line 338
;338:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 340
;339:
;340:	self->s.v.weaponframe = 6;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1086324736
ASGNF4
line 341
;341:}
LABELV $145
endproc player_shot6 0 0
export player_autorifle1
proc player_autorifle1 0 0
line 344
;342:
;343:void player_autorifle1(  )
;344:{
line 345
;345:	self->s.v.frame = 113;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1122107392
ASGNF4
line 346
;346:	self->s.v.think = ( func_t ) player_autorifle2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_autorifle2
CVPU4 4
CVUI4 4
ASGNI4
line 347
;347:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 349
;348:
;349:	self->s.v.weaponframe = 1;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1065353216
ASGNF4
line 350
;350:	muzzleflash(  );
ADDRGP4 muzzleflash
CALLV
pop
line 351
;351:}
LABELV $147
endproc player_autorifle1 0 0
export player_autorifle2
proc player_autorifle2 0 0
line 354
;352:
;353:void player_autorifle2(  )
;354:{
line 355
;355:	self->s.v.frame = 114;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1122238464
ASGNF4
line 356
;356:	self->s.v.think = ( func_t ) player_autorifle3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_autorifle3
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
;359:	self->s.v.weaponframe = 2;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1073741824
ASGNF4
line 360
;360:}
LABELV $149
endproc player_autorifle2 0 0
export player_autorifle3
proc player_autorifle3 0 0
line 363
;361:
;362:void player_autorifle3(  )
;363:{
line 364
;364:	self->s.v.frame = 118;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1122762752
ASGNF4
line 365
;365:	self->s.v.think = ( func_t ) player_run;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_run
CVPU4 4
CVUI4 4
ASGNI4
line 366
;366:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 368
;367:
;368:	self->s.v.weaponframe = 6;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1086324736
ASGNF4
line 369
;369:}
LABELV $151
endproc player_autorifle3 0 0
export player_axe1
proc player_axe1 0 0
line 372
;370:
;371:void player_axe1(  )
;372:{
line 373
;373:	self->s.v.frame = 119;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1122893824
ASGNF4
line 374
;374:	self->s.v.think = ( func_t ) player_axe2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_axe2
CVPU4 4
CVUI4 4
ASGNI4
line 375
;375:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 377
;376:
;377:	self->s.v.weaponframe = 1;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1065353216
ASGNF4
line 378
;378:}
LABELV $153
endproc player_axe1 0 0
export player_axe2
proc player_axe2 0 0
line 381
;379:
;380:void player_axe2(  )
;381:{
line 382
;382:	self->s.v.frame = 120;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1123024896
ASGNF4
line 383
;383:	self->s.v.think = ( func_t ) player_axe3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_axe3
CVPU4 4
CVUI4 4
ASGNI4
line 384
;384:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 386
;385:
;386:	self->s.v.weaponframe = 2;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1073741824
ASGNF4
line 387
;387:}
LABELV $155
endproc player_axe2 0 0
export player_axe3
proc player_axe3 0 0
line 390
;388:
;389:void player_axe3(  )
;390:{
line 391
;391:	self->s.v.frame = 121;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1123155968
ASGNF4
line 392
;392:	self->s.v.think = ( func_t ) player_axe4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_axe4
CVPU4 4
CVUI4 4
ASGNI4
line 393
;393:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 395
;394:
;395:	self->s.v.weaponframe = 3;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1077936128
ASGNF4
line 396
;396:	if ( self->current_weapon == WEAP_AXE )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 16
NEI4 $159
line 397
;397:		W_FireAxe(  );
ADDRGP4 W_FireAxe
CALLV
pop
ADDRGP4 $160
JUMPV
LABELV $159
line 399
;398:	else
;399:		W_FireSpanner(  );
ADDRGP4 W_FireSpanner
CALLV
pop
LABELV $160
line 400
;400:}
LABELV $157
endproc player_axe3 0 0
export player_axe4
proc player_axe4 0 0
line 403
;401:
;402:void player_axe4(  )
;403:{
line 404
;404:	self->s.v.frame = 122;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1123287040
ASGNF4
line 405
;405:	self->s.v.think = ( func_t ) player_run;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_run
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
;408:	self->s.v.weaponframe = 4;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1082130432
ASGNF4
line 409
;409:}
LABELV $161
endproc player_axe4 0 0
export player_axeb1
proc player_axeb1 0 0
line 412
;410:
;411:void player_axeb1(  )
;412:{
line 413
;413:	self->s.v.frame = 125;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1123680256
ASGNF4
line 414
;414:	self->s.v.think = ( func_t ) player_axeb2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_axeb2
CVPU4 4
CVUI4 4
ASGNI4
line 415
;415:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 417
;416:
;417:	self->s.v.weaponframe = 5;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1084227584
ASGNF4
line 418
;418:}
LABELV $163
endproc player_axeb1 0 0
export player_axeb2
proc player_axeb2 0 0
line 421
;419:
;420:void player_axeb2(  )
;421:{
line 422
;422:	self->s.v.frame = 126;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1123811328
ASGNF4
line 423
;423:	self->s.v.think = ( func_t ) player_axeb3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_axeb3
CVPU4 4
CVUI4 4
ASGNI4
line 424
;424:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 426
;425:
;426:	self->s.v.weaponframe = 6;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1086324736
ASGNF4
line 427
;427:}
LABELV $165
endproc player_axeb2 0 0
export player_axeb3
proc player_axeb3 0 0
line 430
;428:
;429:void player_axeb3(  )
;430:{
line 431
;431:	self->s.v.frame = 127;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1123942400
ASGNF4
line 432
;432:	self->s.v.think = ( func_t ) player_axeb4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_axeb4
CVPU4 4
CVUI4 4
ASGNI4
line 433
;433:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 435
;434:
;435:	self->s.v.weaponframe = 7;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1088421888
ASGNF4
line 436
;436:	if ( self->current_weapon == WEAP_AXE )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 16
NEI4 $169
line 437
;437:		W_FireAxe(  );
ADDRGP4 W_FireAxe
CALLV
pop
ADDRGP4 $170
JUMPV
LABELV $169
line 439
;438:	else
;439:		W_FireSpanner(  );
ADDRGP4 W_FireSpanner
CALLV
pop
LABELV $170
line 440
;440:}
LABELV $167
endproc player_axeb3 0 0
export player_axeb4
proc player_axeb4 0 0
line 443
;441:
;442:void player_axeb4(  )
;443:{
line 444
;444:	self->s.v.frame = 128;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124073472
ASGNF4
line 445
;445:	self->s.v.think = ( func_t ) player_run;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_run
CVPU4 4
CVUI4 4
ASGNI4
line 446
;446:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 448
;447:
;448:	self->s.v.weaponframe = 8;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1090519040
ASGNF4
line 449
;449:}
LABELV $171
endproc player_axeb4 0 0
export player_axec1
proc player_axec1 0 0
line 452
;450:
;451:void player_axec1(  )
;452:{
line 453
;453:	self->s.v.frame = 131;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124270080
ASGNF4
line 454
;454:	self->s.v.think = ( func_t ) player_axec2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_axec2
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
;457:	self->s.v.weaponframe = 1;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1065353216
ASGNF4
line 458
;458:}
LABELV $173
endproc player_axec1 0 0
export player_axec2
proc player_axec2 0 0
line 461
;459:
;460:void player_axec2(  )
;461:{
line 462
;462:	self->s.v.frame = 132;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124335616
ASGNF4
line 463
;463:	self->s.v.think = ( func_t ) player_axec3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_axec3
CVPU4 4
CVUI4 4
ASGNI4
line 464
;464:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 466
;465:
;466:	self->s.v.weaponframe = 2;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1073741824
ASGNF4
line 467
;467:}
LABELV $175
endproc player_axec2 0 0
export player_axec3
proc player_axec3 0 0
line 470
;468:
;469:void player_axec3(  )
;470:{
line 471
;471:	self->s.v.frame = 133;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124401152
ASGNF4
line 472
;472:	self->s.v.think = ( func_t ) player_axec4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_axec4
CVPU4 4
CVUI4 4
ASGNI4
line 473
;473:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 475
;474:
;475:	self->s.v.weaponframe = 3;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1077936128
ASGNF4
line 476
;476:	if ( self->current_weapon == WEAP_AXE )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 16
NEI4 $179
line 477
;477:		W_FireAxe(  );
ADDRGP4 W_FireAxe
CALLV
pop
ADDRGP4 $180
JUMPV
LABELV $179
line 479
;478:	else
;479:		W_FireSpanner(  );
ADDRGP4 W_FireSpanner
CALLV
pop
LABELV $180
line 480
;480:}
LABELV $177
endproc player_axec3 0 0
export player_axec4
proc player_axec4 0 0
line 483
;481:
;482:void player_axec4(  )
;483:{
line 484
;484:	self->s.v.frame = 134;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124466688
ASGNF4
line 485
;485:	self->s.v.think = ( func_t ) player_run;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_run
CVPU4 4
CVUI4 4
ASGNI4
line 486
;486:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 488
;487:
;488:	self->s.v.weaponframe = 4;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1082130432
ASGNF4
line 489
;489:}
LABELV $181
endproc player_axec4 0 0
export player_axed1
proc player_axed1 0 0
line 492
;490:
;491:void player_axed1(  )
;492:{
line 493
;493:	self->s.v.frame = 137;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124663296
ASGNF4
line 494
;494:	self->s.v.think = ( func_t ) player_axed2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_axed2
CVPU4 4
CVUI4 4
ASGNI4
line 495
;495:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 497
;496:
;497:	self->s.v.weaponframe = 5;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1084227584
ASGNF4
line 498
;498:}
LABELV $183
endproc player_axed1 0 0
export player_axed2
proc player_axed2 0 0
line 501
;499:
;500:void player_axed2(  )
;501:{
line 502
;502:	self->s.v.frame = 138;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124728832
ASGNF4
line 503
;503:	self->s.v.think = ( func_t ) player_axed3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_axed3
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
;506:	self->s.v.weaponframe = 6;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1086324736
ASGNF4
line 507
;507:}
LABELV $185
endproc player_axed2 0 0
export player_axed3
proc player_axed3 0 0
line 510
;508:
;509:void player_axed3(  )
;510:{
line 511
;511:	self->s.v.frame = 139;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124794368
ASGNF4
line 512
;512:	self->s.v.think = ( func_t ) player_axed4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_axed4
CVPU4 4
CVUI4 4
ASGNI4
line 513
;513:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 515
;514:
;515:	self->s.v.weaponframe = 7;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1088421888
ASGNF4
line 516
;516:	if ( self->current_weapon == WEAP_AXE )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 16
NEI4 $189
line 517
;517:		W_FireAxe(  );
ADDRGP4 W_FireAxe
CALLV
pop
ADDRGP4 $190
JUMPV
LABELV $189
line 519
;518:	else
;519:		W_FireSpanner(  );
ADDRGP4 W_FireSpanner
CALLV
pop
LABELV $190
line 520
;520:}
LABELV $187
endproc player_axed3 0 0
export player_axed4
proc player_axed4 0 0
line 523
;521:
;522:void player_axed4(  )
;523:{
line 524
;524:	self->s.v.frame = 140;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124859904
ASGNF4
line 525
;525:	self->s.v.think = ( func_t ) player_run;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_run
CVPU4 4
CVUI4 4
ASGNI4
line 526
;526:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 528
;527:
;528:	self->s.v.weaponframe = 8;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1090519040
ASGNF4
line 529
;529:}
LABELV $191
endproc player_axed4 0 0
export player_chain1
proc player_chain1 0 0
line 532
;530:
;531:void player_chain1(  )
;532:{
line 533
;533:	self->s.v.frame = 137;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124663296
ASGNF4
line 534
;534:	self->s.v.think = ( func_t ) player_chain1a;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_chain1a
CVPU4 4
CVUI4 4
ASGNI4
line 535
;535:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 537
;536:
;537:	self->s.v.weaponframe = 1;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1065353216
ASGNF4
line 538
;538:	Throw_Grapple(  );
ADDRGP4 Throw_Grapple
CALLV
pop
line 539
;539:}
LABELV $193
endproc player_chain1 0 0
export player_chain1a
proc player_chain1a 0 0
line 542
;540:
;541:void player_chain1a(  )
;542:{
line 543
;543:	self->s.v.frame = 137;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124663296
ASGNF4
line 544
;544:	self->s.v.think = ( func_t ) player_chain2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_chain2
CVPU4 4
CVUI4 4
ASGNI4
line 545
;545:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 547
;546:
;547:	self->s.v.weaponframe = 2;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1073741824
ASGNF4
line 548
;548:}
LABELV $195
endproc player_chain1a 0 0
export player_chain2
proc player_chain2 0 0
line 551
;549:
;550:void player_chain2(  )
;551:{
line 552
;552:	self->s.v.frame = 138;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124728832
ASGNF4
line 553
;553:	self->s.v.think = ( func_t ) player_chain2a;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_chain2a
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
;556:	self->s.v.weaponframe = 3;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1077936128
ASGNF4
line 557
;557:}
LABELV $197
endproc player_chain2 0 0
export player_chain2a
proc player_chain2a 0 0
line 560
;558:
;559:void player_chain2a(  )
;560:{
line 561
;561:	self->s.v.frame = 138;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124728832
ASGNF4
line 562
;562:	self->s.v.think = ( func_t ) player_chain3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_chain3
CVPU4 4
CVUI4 4
ASGNI4
line 563
;563:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 565
;564:
;565:	self->s.v.weaponframe = 4;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1082130432
ASGNF4
line 566
;566:}
LABELV $199
endproc player_chain2a 0 0
export player_chain3
proc player_chain3 4 4
line 569
;567:
;568:void player_chain3(  )
;569:{
line 570
;570:	self->s.v.frame = 139;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124794368
ASGNF4
line 571
;571:	self->s.v.think = ( func_t ) player_chain3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_chain3
CVPU4 4
CVUI4 4
ASGNI4
line 572
;572:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 574
;573:
;574:	self->s.v.weaponframe = 6;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1086324736
ASGNF4
line 575
;575:	if ( !self->hook_out )
ADDRGP4 self
INDIRP4
CNSTI4 1436
ADDP4
INDIRI4
CNSTI4 0
NEI4 $203
line 576
;576:	{
line 577
;577:		player_chain5(  );
ADDRGP4 player_chain5
CALLV
pop
line 578
;578:		return;
ADDRGP4 $201
JUMPV
LABELV $203
line 580
;579:	}
;580:	if ( vlen( self->s.v.velocity ) >= 750 )
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1144750080
LTF4 $205
line 581
;581:	{
line 582
;582:		player_chain4(  );
ADDRGP4 player_chain4
CALLV
pop
line 583
;583:		return;
LABELV $205
line 585
;584:	}
;585:}
LABELV $201
endproc player_chain3 4 4
export player_chain4
proc player_chain4 4 4
line 587
;586:void player_chain4(  )
;587:{
line 588
;588:	self->s.v.frame = 73;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116864512
ASGNF4
line 589
;589:	self->s.v.think = ( func_t ) player_chain4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_chain4
CVPU4 4
CVUI4 4
ASGNI4
line 590
;590:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 592
;591:
;592:	self->s.v.weaponframe = 6;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1086324736
ASGNF4
line 593
;593:	if ( !self->hook_out )
ADDRGP4 self
INDIRP4
CNSTI4 1436
ADDP4
INDIRI4
CNSTI4 0
NEI4 $209
line 594
;594:	{
line 595
;595:		player_chain5(  );
ADDRGP4 player_chain5
CALLV
pop
line 596
;596:		return;
ADDRGP4 $207
JUMPV
LABELV $209
line 598
;597:	}
;598:	if ( vlen( self->s.v.velocity ) < 750 )
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1144750080
GEF4 $211
line 599
;599:	{
line 600
;600:		player_chain3(  );
ADDRGP4 player_chain3
CALLV
pop
line 601
;601:		return;
LABELV $211
line 603
;602:	}
;603:}
LABELV $207
endproc player_chain4 4 4
export player_chain5
proc player_chain5 0 0
line 605
;604:void player_chain5(  )
;605:{
line 606
;606:	self->s.v.frame = 140;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124859904
ASGNF4
line 607
;607:	self->s.v.think = ( func_t ) player_run;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_run
CVPU4 4
CVUI4 4
ASGNI4
line 608
;608:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 610
;609:
;610:	self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 611
;611:}
LABELV $213
endproc player_chain5 0 0
export player_medikit1
proc player_medikit1 0 0
line 614
;612:
;613:void player_medikit1(  )
;614:{
line 615
;615:	self->s.v.frame = 119;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1122893824
ASGNF4
line 616
;616:	self->s.v.think = ( func_t ) player_medikit2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_medikit2
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
;619:	self->s.v.weaponframe = 1;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1065353216
ASGNF4
line 620
;620:}
LABELV $215
endproc player_medikit1 0 0
export player_medikit2
proc player_medikit2 0 0
line 623
;621:
;622:void player_medikit2(  )
;623:{
line 624
;624:	self->s.v.frame = 120;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1123024896
ASGNF4
line 625
;625:	self->s.v.think = ( func_t ) player_medikit3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_medikit3
CVPU4 4
CVUI4 4
ASGNI4
line 626
;626:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 628
;627:
;628:	self->s.v.weaponframe = 2;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1073741824
ASGNF4
line 629
;629:}
LABELV $217
endproc player_medikit2 0 0
export player_medikit3
proc player_medikit3 0 0
line 632
;630:
;631:void player_medikit3(  )
;632:{
line 633
;633:	self->s.v.frame = 121;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1123155968
ASGNF4
line 634
;634:	self->s.v.think = ( func_t ) player_medikit4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_medikit4
CVPU4 4
CVUI4 4
ASGNI4
line 635
;635:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 637
;636:
;637:	self->s.v.weaponframe = 3;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1077936128
ASGNF4
line 638
;638:	W_FireMedikit(  );
ADDRGP4 W_FireMedikit
CALLV
pop
line 639
;639:}
LABELV $219
endproc player_medikit3 0 0
export player_medikit4
proc player_medikit4 0 0
line 642
;640:
;641:void player_medikit4(  )
;642:{
line 643
;643:	self->s.v.frame = 122;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1123287040
ASGNF4
line 644
;644:	self->s.v.think = ( func_t ) player_run;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_run
CVPU4 4
CVUI4 4
ASGNI4
line 645
;645:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 647
;646:
;647:	self->s.v.weaponframe = 4;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1082130432
ASGNF4
line 648
;648:}
LABELV $221
endproc player_medikit4 0 0
export player_medikitb1
proc player_medikitb1 0 0
line 651
;649:
;650:void player_medikitb1(  )
;651:{
line 652
;652:	self->s.v.frame = 125;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1123680256
ASGNF4
line 653
;653:	self->s.v.think = ( func_t ) player_medikitb2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_medikitb2
CVPU4 4
CVUI4 4
ASGNI4
line 654
;654:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 656
;655:
;656:	self->s.v.weaponframe = 5;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1084227584
ASGNF4
line 657
;657:}
LABELV $223
endproc player_medikitb1 0 0
export player_medikitb2
proc player_medikitb2 0 0
line 660
;658:
;659:void player_medikitb2(  )
;660:{
line 661
;661:	self->s.v.frame = 126;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1123811328
ASGNF4
line 662
;662:	self->s.v.think = ( func_t ) player_medikitb3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_medikitb3
CVPU4 4
CVUI4 4
ASGNI4
line 663
;663:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 665
;664:
;665:	self->s.v.weaponframe = 6;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1086324736
ASGNF4
line 666
;666:}
LABELV $225
endproc player_medikitb2 0 0
export player_medikitb3
proc player_medikitb3 0 0
line 669
;667:
;668:void player_medikitb3(  )
;669:{
line 670
;670:	self->s.v.frame = 127;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1123942400
ASGNF4
line 671
;671:	self->s.v.think = ( func_t ) player_medikitb4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_medikitb4
CVPU4 4
CVUI4 4
ASGNI4
line 672
;672:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 674
;673:
;674:	self->s.v.weaponframe = 7;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1088421888
ASGNF4
line 675
;675:	W_FireMedikit(  );
ADDRGP4 W_FireMedikit
CALLV
pop
line 676
;676:}
LABELV $227
endproc player_medikitb3 0 0
export player_medikitb4
proc player_medikitb4 0 0
line 679
;677:
;678:void player_medikitb4(  )
;679:{
line 680
;680:	self->s.v.frame = 128;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124073472
ASGNF4
line 681
;681:	self->s.v.think = ( func_t ) player_run;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_run
CVPU4 4
CVUI4 4
ASGNI4
line 682
;682:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 684
;683:
;684:	self->s.v.weaponframe = 8;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1090519040
ASGNF4
line 685
;685:}
LABELV $229
endproc player_medikitb4 0 0
export player_medikitc1
proc player_medikitc1 0 0
line 688
;686:
;687:void player_medikitc1(  )
;688:{
line 689
;689:	self->s.v.frame = 131;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124270080
ASGNF4
line 690
;690:	self->s.v.think = ( func_t ) player_medikitc2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_medikitc2
CVPU4 4
CVUI4 4
ASGNI4
line 691
;691:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 693
;692:
;693:	self->s.v.weaponframe = 1;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1065353216
ASGNF4
line 694
;694:}
LABELV $231
endproc player_medikitc1 0 0
export player_medikitc2
proc player_medikitc2 0 0
line 697
;695:
;696:void player_medikitc2(  )
;697:{
line 698
;698:	self->s.v.frame = 132;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124335616
ASGNF4
line 699
;699:	self->s.v.think = ( func_t ) player_medikitc3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_medikitc3
CVPU4 4
CVUI4 4
ASGNI4
line 700
;700:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 702
;701:
;702:	self->s.v.weaponframe = 2;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1073741824
ASGNF4
line 703
;703:}
LABELV $233
endproc player_medikitc2 0 0
export player_medikitc3
proc player_medikitc3 0 0
line 706
;704:
;705:void player_medikitc3(  )
;706:{
line 707
;707:	self->s.v.frame = 133;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124401152
ASGNF4
line 708
;708:	self->s.v.think = ( func_t ) player_medikitc4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_medikitc4
CVPU4 4
CVUI4 4
ASGNI4
line 709
;709:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 711
;710:
;711:	self->s.v.weaponframe = 3;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1077936128
ASGNF4
line 712
;712:	W_FireMedikit(  );
ADDRGP4 W_FireMedikit
CALLV
pop
line 713
;713:}
LABELV $235
endproc player_medikitc3 0 0
export player_medikitc4
proc player_medikitc4 0 0
line 716
;714:
;715:void player_medikitc4(  )
;716:{
line 717
;717:	self->s.v.frame = 134;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124466688
ASGNF4
line 718
;718:	self->s.v.think = ( func_t ) player_run;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_run
CVPU4 4
CVUI4 4
ASGNI4
line 719
;719:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 721
;720:
;721:	self->s.v.weaponframe = 4;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1082130432
ASGNF4
line 722
;722:}
LABELV $237
endproc player_medikitc4 0 0
export player_medikitd1
proc player_medikitd1 0 0
line 725
;723:
;724:void player_medikitd1(  )
;725:{
line 726
;726:	self->s.v.frame = 137;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124663296
ASGNF4
line 727
;727:	self->s.v.think = ( func_t ) player_medikitd2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_medikitd2
CVPU4 4
CVUI4 4
ASGNI4
line 728
;728:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 730
;729:
;730:	self->s.v.weaponframe = 5;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1084227584
ASGNF4
line 731
;731:}
LABELV $239
endproc player_medikitd1 0 0
export player_medikitd2
proc player_medikitd2 0 0
line 734
;732:
;733:void player_medikitd2(  )
;734:{
line 735
;735:	self->s.v.frame = 138;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124728832
ASGNF4
line 736
;736:	self->s.v.think = ( func_t ) player_medikitd3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_medikitd3
CVPU4 4
CVUI4 4
ASGNI4
line 737
;737:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 739
;738:
;739:	self->s.v.weaponframe = 6;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1086324736
ASGNF4
line 740
;740:}
LABELV $241
endproc player_medikitd2 0 0
export player_medikitd3
proc player_medikitd3 0 0
line 743
;741:
;742:void player_medikitd3(  )
;743:{
line 744
;744:	self->s.v.frame = 139;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124794368
ASGNF4
line 745
;745:	self->s.v.think = ( func_t ) player_medikitd4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_medikitd4
CVPU4 4
CVUI4 4
ASGNI4
line 746
;746:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 748
;747:
;748:	self->s.v.weaponframe = 7;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1088421888
ASGNF4
line 749
;749:	W_FireMedikit(  );
ADDRGP4 W_FireMedikit
CALLV
pop
line 750
;750:}
LABELV $243
endproc player_medikitd3 0 0
export player_medikitd4
proc player_medikitd4 0 0
line 753
;751:
;752:void player_medikitd4(  )
;753:{
line 754
;754:	self->s.v.frame = 140;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124859904
ASGNF4
line 755
;755:	self->s.v.think = ( func_t ) player_run;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_run
CVPU4 4
CVUI4 4
ASGNI4
line 756
;756:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 758
;757:
;758:	self->s.v.weaponframe = 8;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1090519040
ASGNF4
line 759
;759:}
LABELV $245
endproc player_medikitd4 0 0
export player_bioweapon1
proc player_bioweapon1 0 0
line 762
;760:
;761:void player_bioweapon1(  )
;762:{
line 763
;763:	self->s.v.frame = 119;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1122893824
ASGNF4
line 764
;764:	self->s.v.think = ( func_t ) player_bioweapon2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_bioweapon2
CVPU4 4
CVUI4 4
ASGNI4
line 765
;765:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 767
;766:
;767:	self->s.v.weaponframe = 1;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1065353216
ASGNF4
line 768
;768:}
LABELV $247
endproc player_bioweapon1 0 0
export player_bioweapon2
proc player_bioweapon2 0 0
line 771
;769:
;770:void player_bioweapon2(  )
;771:{
line 772
;772:	self->s.v.frame = 120;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1123024896
ASGNF4
line 773
;773:	self->s.v.think = ( func_t ) player_bioweapon3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_bioweapon3
CVPU4 4
CVUI4 4
ASGNI4
line 774
;774:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 776
;775:
;776:	self->s.v.weaponframe = 2;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1073741824
ASGNF4
line 777
;777:}
LABELV $249
endproc player_bioweapon2 0 0
export player_bioweapon3
proc player_bioweapon3 0 0
line 780
;778:
;779:void player_bioweapon3(  )
;780:{
line 781
;781:	self->s.v.frame = 121;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1123155968
ASGNF4
line 782
;782:	self->s.v.think = ( func_t ) player_bioweapon4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_bioweapon4
CVPU4 4
CVUI4 4
ASGNI4
line 783
;783:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 785
;784:
;785:	self->s.v.weaponframe = 3;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1077936128
ASGNF4
line 786
;786:	W_FireBioweapon(  );
ADDRGP4 W_FireBioweapon
CALLV
pop
line 787
;787:}
LABELV $251
endproc player_bioweapon3 0 0
export player_bioweapon4
proc player_bioweapon4 0 0
line 790
;788:
;789:void player_bioweapon4(  )
;790:{
line 791
;791:	self->s.v.frame = 122;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1123287040
ASGNF4
line 792
;792:	self->s.v.think = ( func_t ) player_run;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_run
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
;795:	self->s.v.weaponframe = 4;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1082130432
ASGNF4
line 796
;796:}
LABELV $253
endproc player_bioweapon4 0 0
export player_bioweaponb1
proc player_bioweaponb1 0 0
line 799
;797:
;798:void player_bioweaponb1(  )
;799:{
line 800
;800:	self->s.v.frame = 125;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1123680256
ASGNF4
line 801
;801:	self->s.v.think = ( func_t ) player_bioweaponb2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_bioweaponb2
CVPU4 4
CVUI4 4
ASGNI4
line 802
;802:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 804
;803:
;804:	self->s.v.weaponframe = 5;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1084227584
ASGNF4
line 805
;805:}
LABELV $255
endproc player_bioweaponb1 0 0
export player_bioweaponb2
proc player_bioweaponb2 0 0
line 808
;806:
;807:void player_bioweaponb2(  )
;808:{
line 809
;809:	self->s.v.frame = 126;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1123811328
ASGNF4
line 810
;810:	self->s.v.think = ( func_t ) player_bioweaponb3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_bioweaponb3
CVPU4 4
CVUI4 4
ASGNI4
line 811
;811:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 813
;812:
;813:	self->s.v.weaponframe = 6;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1086324736
ASGNF4
line 814
;814:}
LABELV $257
endproc player_bioweaponb2 0 0
export player_bioweaponb3
proc player_bioweaponb3 0 0
line 817
;815:
;816:void player_bioweaponb3(  )
;817:{
line 818
;818:	self->s.v.frame = 127;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1123942400
ASGNF4
line 819
;819:	self->s.v.think = ( func_t ) player_bioweaponb4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_bioweaponb4
CVPU4 4
CVUI4 4
ASGNI4
line 820
;820:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 822
;821:
;822:	self->s.v.weaponframe = 7;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1088421888
ASGNF4
line 823
;823:	W_FireBioweapon(  );
ADDRGP4 W_FireBioweapon
CALLV
pop
line 824
;824:}
LABELV $259
endproc player_bioweaponb3 0 0
export player_bioweaponb4
proc player_bioweaponb4 0 0
line 827
;825:
;826:void player_bioweaponb4(  )
;827:{
line 828
;828:	self->s.v.frame = 128;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124073472
ASGNF4
line 829
;829:	self->s.v.think = ( func_t ) player_run;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_run
CVPU4 4
CVUI4 4
ASGNI4
line 830
;830:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 832
;831:
;832:	self->s.v.weaponframe = 8;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1090519040
ASGNF4
line 833
;833:}
LABELV $261
endproc player_bioweaponb4 0 0
export player_bioweaponc1
proc player_bioweaponc1 0 0
line 836
;834:
;835:void player_bioweaponc1(  )
;836:{
line 837
;837:	self->s.v.frame = 131;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124270080
ASGNF4
line 838
;838:	self->s.v.think = ( func_t ) player_bioweaponc2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_bioweaponc2
CVPU4 4
CVUI4 4
ASGNI4
line 839
;839:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 841
;840:
;841:	self->s.v.weaponframe = 1;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1065353216
ASGNF4
line 842
;842:}
LABELV $263
endproc player_bioweaponc1 0 0
export player_bioweaponc2
proc player_bioweaponc2 0 0
line 845
;843:
;844:void player_bioweaponc2(  )
;845:{
line 846
;846:	self->s.v.frame = 132;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124335616
ASGNF4
line 847
;847:	self->s.v.think = ( func_t ) player_bioweaponc3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_bioweaponc3
CVPU4 4
CVUI4 4
ASGNI4
line 848
;848:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 850
;849:
;850:	self->s.v.weaponframe = 2;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1073741824
ASGNF4
line 851
;851:}
LABELV $265
endproc player_bioweaponc2 0 0
export player_bioweaponc3
proc player_bioweaponc3 0 0
line 854
;852:
;853:void player_bioweaponc3(  )
;854:{
line 855
;855:	self->s.v.frame = 133;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124401152
ASGNF4
line 856
;856:	self->s.v.think = ( func_t ) player_bioweaponc4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_bioweaponc4
CVPU4 4
CVUI4 4
ASGNI4
line 857
;857:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 859
;858:
;859:	self->s.v.weaponframe = 3;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1077936128
ASGNF4
line 860
;860:	W_FireBioweapon(  );
ADDRGP4 W_FireBioweapon
CALLV
pop
line 861
;861:}
LABELV $267
endproc player_bioweaponc3 0 0
export player_bioweaponc4
proc player_bioweaponc4 0 0
line 864
;862:
;863:void player_bioweaponc4(  )
;864:{
line 865
;865:	self->s.v.frame = 134;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124466688
ASGNF4
line 866
;866:	self->s.v.think = ( func_t ) player_run;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_run
CVPU4 4
CVUI4 4
ASGNI4
line 867
;867:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 869
;868:
;869:	self->s.v.weaponframe = 4;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1082130432
ASGNF4
line 870
;870:}
LABELV $269
endproc player_bioweaponc4 0 0
export player_bioweapond1
proc player_bioweapond1 0 0
line 873
;871:
;872:void player_bioweapond1(  )
;873:{
line 874
;874:	self->s.v.frame = 137;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124663296
ASGNF4
line 875
;875:	self->s.v.think = ( func_t ) player_bioweapond2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_bioweapond2
CVPU4 4
CVUI4 4
ASGNI4
line 876
;876:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 878
;877:
;878:	self->s.v.weaponframe = 5;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1084227584
ASGNF4
line 879
;879:}
LABELV $271
endproc player_bioweapond1 0 0
export player_bioweapond2
proc player_bioweapond2 0 0
line 882
;880:
;881:void player_bioweapond2(  )
;882:{
line 883
;883:	self->s.v.frame = 138;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124728832
ASGNF4
line 884
;884:	self->s.v.think = ( func_t ) player_bioweapond3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_bioweapond3
CVPU4 4
CVUI4 4
ASGNI4
line 885
;885:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 887
;886:
;887:	self->s.v.weaponframe = 6;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1086324736
ASGNF4
line 888
;888:}
LABELV $273
endproc player_bioweapond2 0 0
export player_bioweapond3
proc player_bioweapond3 0 0
line 891
;889:
;890:void player_bioweapond3(  )
;891:{
line 892
;892:	self->s.v.frame = 139;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124794368
ASGNF4
line 893
;893:	self->s.v.think = ( func_t ) player_bioweapond4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_bioweapond4
CVPU4 4
CVUI4 4
ASGNI4
line 894
;894:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 896
;895:
;896:	self->s.v.weaponframe = 7;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1088421888
ASGNF4
line 897
;897:	W_FireBioweapon(  );
ADDRGP4 W_FireBioweapon
CALLV
pop
line 898
;898:}
LABELV $275
endproc player_bioweapond3 0 0
export player_bioweapond4
proc player_bioweapond4 0 0
line 901
;899:
;900:void player_bioweapond4(  )
;901:{
line 902
;902:	self->s.v.frame = 140;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1124859904
ASGNF4
line 903
;903:	self->s.v.think = ( func_t ) player_run;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_run
CVPU4 4
CVUI4 4
ASGNI4
line 904
;904:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 906
;905:
;906:	self->s.v.weaponframe = 8;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1090519040
ASGNF4
line 907
;907:}
LABELV $277
endproc player_bioweapond4 0 0
export player_mtf_nail1
proc player_mtf_nail1 8 0
line 912
;908:
;909:void W_FireMTFSpikes();
;910:void player_mtf_nail2();
;911:void player_mtf_nail1(  )
;912:{
line 913
;913:	self->s.v.frame = 103;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120796672
ASGNF4
line 914
;914:	self->s.v.think = ( func_t ) player_mtf_nail2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_mtf_nail2
CVPU4 4
CVUI4 4
ASGNI4
line 915
;915:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 917
;916:
;917:	muzzleflash(  );
ADDRGP4 muzzleflash
CALLV
pop
line 918
;918:	if ( !self->s.v.button0 || intermission_running )
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
EQF4 $283
ADDRGP4 intermission_running
INDIRF4
ADDRLP4 0
INDIRF4
EQF4 $281
LABELV $283
line 919
;919:	{
line 920
;920:		player_run( );
ADDRGP4 player_run
CALLV
pop
line 921
;921:		return;
ADDRGP4 $279
JUMPV
LABELV $281
line 923
;922:	}
;923:	self->s.v.weaponframe = self->s.v.weaponframe + 1;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 924
;924:	if ( self->s.v.weaponframe == 9 )
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
INDIRF4
CNSTF4 1091567616
NEF4 $284
line 925
;925:		self->s.v.weaponframe = 1;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $284
line 926
;926:	SuperDamageSound(  );
ADDRGP4 SuperDamageSound
CALLV
pop
line 927
;927:	W_FireMTFSpikes(  );
ADDRGP4 W_FireMTFSpikes
CALLV
pop
line 929
;928://	Attack_Finished( 0.2 );
;929:}
LABELV $279
endproc player_mtf_nail1 8 0
export player_mtf_nail2
proc player_mtf_nail2 8 0
line 931
;930:void player_mtf_nail2(  )
;931:{
line 932
;932:	self->s.v.frame = 104;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120927744
ASGNF4
line 933
;933:	self->s.v.think = ( func_t ) player_mtf_nail1;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_mtf_nail1
CVPU4 4
CVUI4 4
ASGNI4
line 934
;934:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 936
;935:
;936:	if ( !self->s.v.button0 || intermission_running )
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
EQF4 $290
ADDRGP4 intermission_running
INDIRF4
ADDRLP4 0
INDIRF4
EQF4 $288
LABELV $290
line 937
;937:	{
line 938
;938:		player_run(  );
ADDRGP4 player_run
CALLV
pop
line 939
;939:		return;
ADDRGP4 $286
JUMPV
LABELV $288
line 941
;940:	}
;941:	self->s.v.weaponframe = self->s.v.weaponframe + 1;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 942
;942:	if ( self->s.v.weaponframe == 9 )
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
INDIRF4
CNSTF4 1091567616
NEF4 $291
line 943
;943:		self->s.v.weaponframe = 1;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $291
line 945
;944://	Attack_Finished( 0.2 );
;945:}
LABELV $286
endproc player_mtf_nail2 8 0
export player_nail1
proc player_nail1 8 4
line 948
;946:
;947:void player_nail1(  )
;948:{
line 949
;949:	self->s.v.frame = 103;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120796672
ASGNF4
line 950
;950:	self->s.v.think = ( func_t ) player_nail2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_nail2
CVPU4 4
CVUI4 4
ASGNI4
line 951
;951:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 953
;952:
;953:	muzzleflash(  );
ADDRGP4 muzzleflash
CALLV
pop
line 954
;954:	if ( !self->s.v.button0 || intermission_running )
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
EQF4 $297
ADDRGP4 intermission_running
INDIRF4
ADDRLP4 0
INDIRF4
EQF4 $295
LABELV $297
line 955
;955:	{
line 956
;956:		player_run( );
ADDRGP4 player_run
CALLV
pop
line 957
;957:		return;
ADDRGP4 $293
JUMPV
LABELV $295
line 959
;958:	}
;959:	self->s.v.weaponframe = self->s.v.weaponframe + 1;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 960
;960:	if ( self->s.v.weaponframe == 9 )
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
INDIRF4
CNSTF4 1091567616
NEF4 $298
line 961
;961:		self->s.v.weaponframe = 1;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $298
line 962
;962:	SuperDamageSound(  );
ADDRGP4 SuperDamageSound
CALLV
pop
line 963
;963:	if ( !self->nailpos )
ADDRGP4 self
INDIRP4
CNSTI4 1476
ADDP4
INDIRI4
CNSTI4 0
NEI4 $300
line 964
;964:	{
line 965
;965:		W_FireSpikes( 4 );
CNSTF4 1082130432
ARGF4
ADDRGP4 W_FireSpikes
CALLV
pop
line 966
;966:		self->nailpos = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1476
ADDP4
CNSTI4 1
ASGNI4
line 967
;967:	} else
ADDRGP4 $301
JUMPV
LABELV $300
line 968
;968:	{
line 969
;969:		W_FireSpikes( -4 );
CNSTF4 3229614080
ARGF4
ADDRGP4 W_FireSpikes
CALLV
pop
line 970
;970:		self->nailpos = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1476
ADDP4
CNSTI4 0
ASGNI4
line 971
;971:	}
LABELV $301
line 972
;972:	Attack_Finished( 0.2 );
CNSTF4 1045220557
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 973
;973:}
LABELV $293
endproc player_nail1 8 4
export player_nail2
proc player_nail2 8 4
line 976
;974:
;975:void player_nail2(  )
;976:{
line 977
;977:	self->s.v.frame = 104;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120927744
ASGNF4
line 978
;978:	self->s.v.think = ( func_t ) player_nail1;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_nail1
CVPU4 4
CVUI4 4
ASGNI4
line 979
;979:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 981
;980:
;981:	if ( !self->s.v.button0 || intermission_running )
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
EQF4 $306
ADDRGP4 intermission_running
INDIRF4
ADDRLP4 0
INDIRF4
EQF4 $304
LABELV $306
line 982
;982:	{
line 983
;983:		player_run(  );
ADDRGP4 player_run
CALLV
pop
line 984
;984:		return;
ADDRGP4 $302
JUMPV
LABELV $304
line 986
;985:	}
;986:	self->s.v.weaponframe = self->s.v.weaponframe + 1;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 987
;987:	if ( self->s.v.weaponframe == 9 )
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
INDIRF4
CNSTF4 1091567616
NEF4 $307
line 988
;988:		self->s.v.weaponframe = 1;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $307
line 989
;989:	Attack_Finished( 0.2 );
CNSTF4 1045220557
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 990
;990:}
LABELV $302
endproc player_nail2 8 4
export player_assaultcannonup1
proc player_assaultcannonup1 20 20
line 993
;991:
;992:void player_assaultcannonup1(  )
;993:{
line 994
;994:	self->s.v.frame = 103;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120796672
ASGNF4
line 995
;995:	self->s.v.think = ( func_t ) player_assaultcannonup2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_assaultcannonup2
CVPU4 4
CVUI4 4
ASGNI4
line 996
;996:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 999
;997:
;998:
;999:	if ( !self->s.v.button0 || self->s.v.ammo_shells < 1/*self->assault_min_shells*/ || intermission_running )
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
EQF4 $314
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1065353216
LTF4 $314
ADDRGP4 intermission_running
INDIRF4
ADDRLP4 4
INDIRF4
EQF4 $311
LABELV $314
line 1000
;1000:	{
line 1001
;1001:		self->tfstate = self->tfstate - ( self->tfstate & TFSTATE_AIMING );
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ADDRLP4 12
INDIRI4
CNSTI4 2048
BANDI4
SUBI4
ASGNI4
line 1002
;1002:		TeamFortress_SetSpeed( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 1003
;1003:		self->count = 1;
ADDRGP4 self
INDIRP4
CNSTI4 684
ADDP4
CNSTF4 1065353216
ASGNF4
line 1004
;1004:		self->heat = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
CNSTF4 0
ASGNF4
line 1005
;1005:		player_assaultcannondown1(  );
ADDRGP4 player_assaultcannondown1
CALLV
pop
line 1006
;1006:		return;
ADDRGP4 $309
JUMPV
LABELV $311
line 1008
;1007:	}
;1008:	self->fire_held_down = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1448
ADDP4
CNSTI4 1
ASGNI4
line 1009
;1009:	if ( self->heat == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $315
line 1010
;1010:		sound( self, 1, "weapons/chngnu1a.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $317
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
LABELV $315
line 1012
;1011:		//sound( self, 1, "weapons/asscan1.wav", 1, 1 );
;1012:	SuperDamageSound(  );
ADDRGP4 SuperDamageSound
CALLV
pop
line 1013
;1013:	Attack_Finished( 0.1 );
CNSTF4 1036831949
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 1014
;1014:	if ( self->heat != 2 && self->heat != 4 )
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12
INDIRF4
CNSTF4 1073741824
EQF4 $318
ADDRLP4 12
INDIRF4
CNSTF4 1082130432
EQF4 $318
line 1015
;1015:	{
line 1016
;1016:		if ( self->s.v.weaponframe >= 3 )
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
INDIRF4
CNSTF4 1077936128
LTF4 $320
line 1017
;1017:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $321
JUMPV
LABELV $320
line 1019
;1018:		else
;1019:			self->s.v.weaponframe = self->s.v.weaponframe + 1;
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 312
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
LABELV $321
line 1020
;1020:	}
LABELV $318
line 1021
;1021:	self->heat = self->heat + 1;
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 1076
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
line 1022
;1022:	if ( self->heat >= 7 )
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
CNSTF4 1088421888
LTF4 $322
line 1023
;1023:	{
line 1024
;1024:		self->heat = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
CNSTF4 0
ASGNF4
line 1025
;1025:		self->ScanRange = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1500
ADDP4
CNSTI4 0
ASGNI4
line 1026
;1026:		player_assaultcannon1(  );
ADDRGP4 player_assaultcannon1
CALLV
pop
line 1027
;1027:	}
LABELV $322
line 1028
;1028:}
LABELV $309
endproc player_assaultcannonup1 20 20
export player_assaultcannonup2
proc player_assaultcannonup2 20 4
line 1030
;1029:void player_assaultcannonup2(  )
;1030:{
line 1031
;1031:	self->s.v.frame = 103;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120796672
ASGNF4
line 1032
;1032:	self->s.v.think = ( func_t ) player_assaultcannonup1;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_assaultcannonup1
CVPU4 4
CVUI4 4
ASGNI4
line 1033
;1033:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1035
;1034:
;1035:	if ( !self->s.v.button0 || self->s.v.ammo_shells < 1/*self->assault_min_shells*/ || intermission_running )
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
EQF4 $329
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1065353216
LTF4 $329
ADDRGP4 intermission_running
INDIRF4
ADDRLP4 4
INDIRF4
EQF4 $326
LABELV $329
line 1036
;1036:	{
line 1037
;1037:		self->tfstate = self->tfstate - ( self->tfstate & TFSTATE_AIMING );
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ADDRLP4 12
INDIRI4
CNSTI4 2048
BANDI4
SUBI4
ASGNI4
line 1038
;1038:		TeamFortress_SetSpeed( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 1039
;1039:		self->count = 1;
ADDRGP4 self
INDIRP4
CNSTI4 684
ADDP4
CNSTF4 1065353216
ASGNF4
line 1040
;1040:		self->heat = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
CNSTF4 0
ASGNF4
line 1041
;1041:		player_assaultcannondown1(  );
ADDRGP4 player_assaultcannondown1
CALLV
pop
line 1042
;1042:		return;
ADDRGP4 $324
JUMPV
LABELV $326
line 1044
;1043:	}
;1044:	SuperDamageSound(  );
ADDRGP4 SuperDamageSound
CALLV
pop
line 1045
;1045:	Attack_Finished( 0.1 );
CNSTF4 1036831949
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 1046
;1046:	if ( self->heat != 2 && self->heat != 4 && self->heat != 7 )
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
ASGNF4
ADDRLP4 8
INDIRF4
CNSTF4 1073741824
EQF4 $330
ADDRLP4 8
INDIRF4
CNSTF4 1082130432
EQF4 $330
ADDRLP4 8
INDIRF4
CNSTF4 1088421888
EQF4 $330
line 1047
;1047:	{
line 1048
;1048:		if ( self->s.v.weaponframe == 2 && self->heat >= 9 )
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 312
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $332
ADDRLP4 12
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
CNSTF4 1091567616
LTF4 $332
line 1049
;1049:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $333
JUMPV
LABELV $332
line 1051
;1050:		else
;1051:		{
line 1052
;1052:			if ( self->s.v.weaponframe >= 3 )
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
INDIRF4
CNSTF4 1077936128
LTF4 $334
line 1053
;1053:				self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $335
JUMPV
LABELV $334
line 1055
;1054:			else
;1055:				self->s.v.weaponframe = self->s.v.weaponframe + 1;
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 312
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
LABELV $335
line 1056
;1056:		}
LABELV $333
line 1057
;1057:	}
LABELV $330
line 1058
;1058:	self->heat = self->heat + 1;
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
line 1059
;1059:	if ( self->heat >= 13 )
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
INDIRF4
CNSTF4 1095761920
LTF4 $336
line 1060
;1060:	{
line 1061
;1061:		self->heat = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
CNSTF4 0
ASGNF4
line 1062
;1062:		self->ScanRange = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1500
ADDP4
CNSTI4 0
ASGNI4
line 1063
;1063:		player_assaultcannon1(  );
ADDRGP4 player_assaultcannon1
CALLV
pop
line 1064
;1064:	}
LABELV $336
line 1065
;1065:}
LABELV $324
endproc player_assaultcannonup2 20 4
export player_assaultcannon1
proc player_assaultcannon1 20 20
line 1067
;1066:void player_assaultcannon1(  )
;1067:{
line 1068
;1068:	self->s.v.frame = 103;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120796672
ASGNF4
line 1069
;1069:	self->s.v.think = ( func_t ) player_assaultcannon2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_assaultcannon2
CVPU4 4
CVUI4 4
ASGNI4
line 1070
;1070:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1072
;1071:
;1072:	muzzleflash( );
ADDRGP4 muzzleflash
CALLV
pop
line 1073
;1073:	sound( self, 1, "weapons/asscan2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $340
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
line 1074
;1074:	if ( !self->s.v.button0 || self->s.v.ammo_shells < 1 || intermission_running )
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
EQF4 $344
ADDRLP4 4
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1065353216
LTF4 $344
ADDRGP4 intermission_running
INDIRF4
ADDRLP4 8
INDIRF4
EQF4 $341
LABELV $344
line 1075
;1075:	{
line 1076
;1076:		if ( self->tfstate & TFSTATE_AIMING )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $345
line 1077
;1077:			self->tfstate = self->tfstate - ( self->tfstate & TFSTATE_AIMING );
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 16
INDIRI4
ADDRLP4 16
INDIRI4
CNSTI4 2048
BANDI4
SUBI4
ASGNI4
LABELV $345
line 1078
;1078:		TeamFortress_SetSpeed (self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 1079
;1079:		self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 1080
;1080:		self->count = 1;
ADDRGP4 self
INDIRP4
CNSTI4 684
ADDP4
CNSTF4 1065353216
ASGNF4
line 1081
;1081:		player_assaultcannondown1 ( );
ADDRGP4 player_assaultcannondown1
CALLV
pop
line 1082
;1082:		return;
ADDRGP4 $338
JUMPV
LABELV $341
line 1084
;1083:	}
;1084:	if ( self->s.v.weaponframe == 2 )
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $347
line 1085
;1085:		self->s.v.weaponframe = 4/*0*/;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1082130432
ASGNF4
ADDRGP4 $348
JUMPV
LABELV $347
line 1087
;1086:	else
;1087:		self->s.v.weaponframe = 2;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1073741824
ASGNF4
LABELV $348
line 1088
;1088:	SuperDamageSound(  );
ADDRGP4 SuperDamageSound
CALLV
pop
line 1089
;1089:	W_FireAssaultCannon(  );
ADDRGP4 W_FireAssaultCannon
CALLV
pop
line 1090
;1090:	Attack_Finished( 0.1 );
CNSTF4 1036831949
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 1146
;1091:
;1092:/*	vec3_t  v;
;1093:#ifndef NEWHWGUY
;1094:	int     st;
;1095:#endif
;1096:
;1097:	self->s.v.frame = 103;
;1098:	self->s.v.think = ( func_t ) player_assaultcannon2;
;1099:	self->s.v.nextthink = g_globalvars.time + 0.1;
;1100:
;1101:	VectorCopy( self->s.v.velocity, v );
;1102:	v[2] = 0;
;1103:// if (vlen(self->s.v.velocity) < 50 && (self.flags & #FL_ONGROUND)) {
;1104:	if ( vlen( v ) < 20 && ( ( int ) self->s.v.flags & FL_ONGROUND ) )
;1105:	{
;1106:		muzzleflash(  );
;1107:		sound( self, 1, "weapons/asscan2.wav", 1, 1 );
;1108:		if ( self->s.v.weaponframe == 2 )
;1109:			self->s.v.weaponframe = 4;
;1110:		else
;1111:			self->s.v.weaponframe = 2;
;1112:		SuperDamageSound(  );
;1113:		W_FireAssaultCannon(  );
;1114:#ifndef NEWHWGUY
;1115:		stuffcmd( self, "v_idlescale " );
;1116:		if ( self->heat < 5 )
;1117:			st = ( self->heat * 4 );
;1118:		else
;1119:			st = 20;
;1120:		stuffcmd( self, "%d\n", st );
;1121:#endif
;1122:	} else
;1123:	{
;1124:		sound( self, 1, "weapons/asscan4.wav", 1, 1 );
;1125:		if ( self->s.v.weaponframe == 2 )
;1126:			self->s.v.weaponframe = 0;
;1127:		else
;1128:			self->s.v.weaponframe = 2;
;1129:#ifndef NEWHWGUY
;1130:		stuffcmd( self, "v_idlescale 5\n" );
;1131:#endif
;1132:	}
;1133:	if ( !self->s.v.button0 || self->s.v.ammo_shells <= self->assault_min_shells || intermission_running )
;1134:	{
;1135:#ifndef  NEWHWGUY
;1136:		stuffcmd( self, "v_idlescale 0\n" );
;1137:#endif
;1138:		self->tfstate = self->tfstate - ( self->tfstate & TFSTATE_AIMING );
;1139:		TeamFortress_SetSpeed( self );
;1140:		self->s.v.weaponframe = 0;
;1141:		self->count = 1;
;1142:		player_assaultcannondown1(  );
;1143:		return;
;1144:	}
;1145:	Attack_Finished( 0.1 );*/
;1146:}
LABELV $338
endproc player_assaultcannon1 20 20
export player_assaultcannon2
proc player_assaultcannon2 20 20
line 1149
;1147:
;1148:void player_assaultcannon2(  )
;1149:{
line 1152
;1150:	//vec3_t  v;
;1151:
;1152:	self->s.v.frame = 104;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120927744
ASGNF4
line 1153
;1153:	self->s.v.think = ( func_t ) player_assaultcannon1;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_assaultcannon1
CVPU4 4
CVUI4 4
ASGNI4
line 1154
;1154:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1156
;1155:
;1156:	muzzleflash( );
ADDRGP4 muzzleflash
CALLV
pop
line 1157
;1157:	sound( self, 1, "weapons/asscan2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $340
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
line 1158
;1158:	if ( !self->s.v.button0 || self->s.v.ammo_shells < 1 || intermission_running )
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
EQF4 $354
ADDRLP4 4
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1065353216
LTF4 $354
ADDRGP4 intermission_running
INDIRF4
ADDRLP4 8
INDIRF4
EQF4 $351
LABELV $354
line 1159
;1159:	{
line 1160
;1160:		if ( self->tfstate & TFSTATE_AIMING )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $355
line 1161
;1161:			self->tfstate = self->tfstate - ( self->tfstate & TFSTATE_AIMING );
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 16
INDIRI4
ADDRLP4 16
INDIRI4
CNSTI4 2048
BANDI4
SUBI4
ASGNI4
LABELV $355
line 1162
;1162:		TeamFortress_SetSpeed (self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 1163
;1163:		self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 1164
;1164:		self->count = 1;
ADDRGP4 self
INDIRP4
CNSTI4 684
ADDP4
CNSTF4 1065353216
ASGNF4
line 1165
;1165:		player_assaultcannondown1 ( );
ADDRGP4 player_assaultcannondown1
CALLV
pop
line 1166
;1166:		return;
ADDRGP4 $349
JUMPV
LABELV $351
line 1168
;1167:	}
;1168:	if ( self->s.v.weaponframe == 2 )
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $357
line 1169
;1169:		self->s.v.weaponframe = 4/*0*/;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1082130432
ASGNF4
ADDRGP4 $358
JUMPV
LABELV $357
line 1171
;1170:	else
;1171:		self->s.v.weaponframe = 2;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1073741824
ASGNF4
LABELV $358
line 1172
;1172:	SuperDamageSound(  );
ADDRGP4 SuperDamageSound
CALLV
pop
line 1173
;1173:	W_FireAssaultCannon(  );
ADDRGP4 W_FireAssaultCannon
CALLV
pop
line 1174
;1174:	Attack_Finished( 0.1 );
CNSTF4 1036831949
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 1213
;1175:/*
;1176:	VectorCopy( self->s.v.velocity, v );
;1177:	v[2] = 0;
;1178:#ifndef NEWHWGUY
;1179:	stuffcmd( self, "v_idlescale 0\n" );
;1180:#endif
;1181:// if (vlen(self->s.v.velocity) < 50 && (self.flags & #FL_ONGROUND)) {
;1182:	if ( vlen( v ) < 20 && ( ( int ) self->s.v.flags & FL_ONGROUND ) )
;1183:	{
;1184:		if ( self->s.v.weaponframe == 2 )
;1185:			self->s.v.weaponframe = 4;
;1186:		else
;1187:			self->s.v.weaponframe = 2;
;1188:		SuperDamageSound(  );
;1189:		W_FireAssaultCannon(  );
;1190:		self->heat = self->heat + 0.1;
;1191:		stuffcmd( self, "bf\n" );
;1192:	} else
;1193:	{
;1194:		if ( self->s.v.weaponframe == 2 )
;1195:			self->s.v.weaponframe = 0;
;1196:		else
;1197:			self->s.v.weaponframe = 2;
;1198:	}
;1199:	if ( !self->s.v.button0 || self->s.v.ammo_shells <= self->assault_min_shells || intermission_running )
;1200:	{
;1201:#ifndef NEWHWGUY
;1202:		stuffcmd( self, "v_idlescale 0\n" );
;1203:#endif
;1204:		self->tfstate = self->tfstate - ( self->tfstate & TFSTATE_AIMING );
;1205:		TeamFortress_SetSpeed( self );
;1206:		self->s.v.weaponframe = 0;
;1207:		self->count = 1;
;1208:		player_assaultcannondown1(  );
;1209:		return;
;1210:	}
;1211:	Attack_Finished( 0.1 );
;1212:	*/
;1213:}
LABELV $349
endproc player_assaultcannon2 20 20
export player_assaultcannondown1
proc player_assaultcannondown1 28 20
line 1216
;1214:
;1215:void player_assaultcannondown1(  )
;1216:{
line 1219
;1217://      gedict_t *tcool;
;1218:
;1219:	self->s.v.frame = 103;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120796672
ASGNF4
line 1220
;1220:	self->s.v.think = ( func_t ) player_assaultcannondown1;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_assaultcannondown1
CVPU4 4
CVUI4 4
ASGNI4
line 1221
;1221:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1224
;1222:
;1223:
;1224:	if ( self->count == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $361
line 1225
;1225:		sound( self, 1, "weapons/chngnd1a.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $363
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
LABELV $361
line 1227
;1226:		//sound( self, 1, "weapons/asscan3.wav", 1, 1 );
;1227:	if ( self->count >= 15 )
ADDRGP4 self
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
CNSTF4 1097859072
LTF4 $364
line 1228
;1228:	{
line 1229
;1229:		self->heat = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1076
ADDP4
CNSTF4 0
ASGNF4
line 1230
;1230:		self->fire_held_down = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1448
ADDP4
CNSTI4 0
ASGNI4
line 1231
;1231:		self->tfstate = self->tfstate - ( self->tfstate & TFSTATE_AIMING );
ADDRLP4 4
ADDRGP4 self
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
CNSTI4 2048
BANDI4
SUBI4
ASGNI4
line 1232
;1232:		TeamFortress_SetSpeed( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 1233
;1233:		if ( self->s.v.ammo_shells <= 1/*self->assault_min_shells*/ || self->s.v.ammo_cells < 4 )
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1065353216
LEF4 $368
ADDRLP4 12
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1082130432
GEF4 $366
LABELV $368
line 1234
;1234:		{
line 1235
;1235:			self->last_weapon = self->current_weapon;
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 1036
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
ASGNI4
line 1236
;1236:			self->last_weaponmode = self->weaponmode;
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 1040
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 940
ADDP4
INDIRI4
ASGNI4
line 1237
;1237:			self->current_weapon = W_BestWeapon(  );
ADDRLP4 24
ADDRGP4 W_BestWeapon
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 1238
;1238:			W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 1239
;1239:			W_PrintWeaponMessage(  );
ADDRGP4 W_PrintWeaponMessage
CALLV
pop
line 1240
;1240:			return;
ADDRGP4 $359
JUMPV
LABELV $366
line 1242
;1241:		}
;1242:		player_run(  );
ADDRGP4 player_run
CALLV
pop
line 1243
;1243:		return;
ADDRGP4 $359
JUMPV
LABELV $364
line 1245
;1244:	}
;1245:	if ( self->count != 8 && self->count != 10 && self->count != 12 && self->count != 14 )
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 1090519040
EQF4 $369
ADDRLP4 4
INDIRF4
CNSTF4 1092616192
EQF4 $369
ADDRLP4 4
INDIRF4
CNSTF4 1094713344
EQF4 $369
ADDRLP4 4
INDIRF4
CNSTF4 1096810496
EQF4 $369
line 1246
;1246:	{
line 1247
;1247:		if ( self->s.v.weaponframe == 3 )
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $371
line 1248
;1248:			self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $372
JUMPV
LABELV $371
line 1250
;1249:		else
;1250:			self->s.v.weaponframe = self->s.v.weaponframe + 1;
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $372
line 1251
;1251:	}
LABELV $369
line 1252
;1252:	self->count = self->count + 1;
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 684
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1253
;1253:	Attack_Finished( 0.1 );
CNSTF4 1036831949
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 1254
;1254:}
LABELV $359
endproc player_assaultcannondown1 28 20
export player_light1
proc player_light1 8 4
line 1257
;1255:
;1256:void player_light1(  )
;1257:{
line 1258
;1258:	self->s.v.frame = 105;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1121058816
ASGNF4
line 1259
;1259:	self->s.v.think = ( func_t ) player_light2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_light2
CVPU4 4
CVUI4 4
ASGNI4
line 1260
;1260:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1262
;1261:
;1262:	muzzleflash(  );
ADDRGP4 muzzleflash
CALLV
pop
line 1263
;1263:	if ( !self->s.v.button0 || intermission_running )
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
EQF4 $377
ADDRGP4 intermission_running
INDIRF4
ADDRLP4 0
INDIRF4
EQF4 $375
LABELV $377
line 1264
;1264:	{
line 1265
;1265:		player_run(  );
ADDRGP4 player_run
CALLV
pop
line 1266
;1266:		return;
ADDRGP4 $373
JUMPV
LABELV $375
line 1268
;1267:	}
;1268:	self->s.v.weaponframe = self->s.v.weaponframe + 1;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1269
;1269:	if ( self->s.v.weaponframe == 5 )
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
INDIRF4
CNSTF4 1084227584
NEF4 $378
line 1270
;1270:		self->s.v.weaponframe = 1;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $378
line 1271
;1271:	SuperDamageSound(  );
ADDRGP4 SuperDamageSound
CALLV
pop
line 1272
;1272:	W_FireLightning(  );
ADDRGP4 W_FireLightning
CALLV
pop
line 1273
;1273:	Attack_Finished( 0.2 );
CNSTF4 1045220557
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 1274
;1274:}
LABELV $373
endproc player_light1 8 4
export player_light2
proc player_light2 8 4
line 1277
;1275:
;1276:void player_light2(  )
;1277:{
line 1278
;1278:	self->s.v.frame = 106;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1121189888
ASGNF4
line 1279
;1279:	self->s.v.think = ( func_t ) player_light1;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_light1
CVPU4 4
CVUI4 4
ASGNI4
line 1280
;1280:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1282
;1281:
;1282:	if ( !self->s.v.button0 || intermission_running )
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
EQF4 $384
ADDRGP4 intermission_running
INDIRF4
ADDRLP4 0
INDIRF4
EQF4 $382
LABELV $384
line 1283
;1283:	{
line 1284
;1284:		player_run(  );
ADDRGP4 player_run
CALLV
pop
line 1285
;1285:		return;
ADDRGP4 $380
JUMPV
LABELV $382
line 1287
;1286:	}
;1287:	self->s.v.weaponframe = self->s.v.weaponframe + 1;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1288
;1288:	if ( self->s.v.weaponframe == 5 )
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
INDIRF4
CNSTF4 1084227584
NEF4 $385
line 1289
;1289:		self->s.v.weaponframe = 1;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $385
line 1290
;1290:	SuperDamageSound(  );
ADDRGP4 SuperDamageSound
CALLV
pop
line 1291
;1291:	W_FireLightning(  );
ADDRGP4 W_FireLightning
CALLV
pop
line 1292
;1292:	Attack_Finished( 0.2 );
CNSTF4 1045220557
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 1293
;1293:}
LABELV $380
endproc player_light2 8 4
export player_rocket1
proc player_rocket1 0 0
line 1296
;1294:
;1295:void player_rocket1(  )
;1296:{
line 1297
;1297:	self->s.v.frame = 107;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1121320960
ASGNF4
line 1298
;1298:	self->s.v.think = ( func_t ) player_rocket2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_rocket2
CVPU4 4
CVUI4 4
ASGNI4
line 1299
;1299:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1301
;1300:
;1301:	self->s.v.weaponframe = 1;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1065353216
ASGNF4
line 1302
;1302:	muzzleflash(  );
ADDRGP4 muzzleflash
CALLV
pop
line 1303
;1303:}
LABELV $387
endproc player_rocket1 0 0
export player_rocket2
proc player_rocket2 0 0
line 1306
;1304:
;1305:void player_rocket2(  )
;1306:{
line 1307
;1307:	self->s.v.frame = 108;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1121452032
ASGNF4
line 1308
;1308:	self->s.v.think = ( func_t ) player_rocket3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_rocket3
CVPU4 4
CVUI4 4
ASGNI4
line 1309
;1309:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1311
;1310:
;1311:	self->s.v.weaponframe = 2;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1073741824
ASGNF4
line 1312
;1312:}
LABELV $389
endproc player_rocket2 0 0
export player_rocket3
proc player_rocket3 0 0
line 1315
;1313:
;1314:void player_rocket3(  )
;1315:{
line 1316
;1316:	self->s.v.frame = 109;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1121583104
ASGNF4
line 1317
;1317:	self->s.v.think = ( func_t ) player_rocket4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_rocket4
CVPU4 4
CVUI4 4
ASGNI4
line 1318
;1318:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1320
;1319:
;1320:	self->s.v.weaponframe = 3;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1077936128
ASGNF4
line 1321
;1321:}
LABELV $391
endproc player_rocket3 0 0
export player_rocket4
proc player_rocket4 0 0
line 1324
;1322:
;1323:void player_rocket4(  )
;1324:{
line 1325
;1325:	self->s.v.frame = 110;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1121714176
ASGNF4
line 1326
;1326:	self->s.v.think = ( func_t ) player_rocket5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_rocket5
CVPU4 4
CVUI4 4
ASGNI4
line 1327
;1327:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1329
;1328:
;1329:	self->s.v.weaponframe = 4;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1082130432
ASGNF4
line 1330
;1330:}
LABELV $393
endproc player_rocket4 0 0
export player_rocket5
proc player_rocket5 0 0
line 1333
;1331:
;1332:void player_rocket5(  )
;1333:{
line 1334
;1334:	self->s.v.frame = 111;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1121845248
ASGNF4
line 1335
;1335:	self->s.v.think = ( func_t ) player_rocket6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_rocket6
CVPU4 4
CVUI4 4
ASGNI4
line 1336
;1336:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1338
;1337:
;1338:	self->s.v.weaponframe = 5;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1084227584
ASGNF4
line 1339
;1339:}
LABELV $395
endproc player_rocket5 0 0
export player_rocket6
proc player_rocket6 0 0
line 1342
;1340:
;1341:void player_rocket6(  )
;1342:{
line 1343
;1343:	self->s.v.frame = 112;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1121976320
ASGNF4
line 1344
;1344:	self->s.v.think = ( func_t ) player_run;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_run
CVPU4 4
CVUI4 4
ASGNI4
line 1345
;1345:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1347
;1346:
;1347:	self->s.v.weaponframe = 6;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 1086324736
ASGNF4
line 1348
;1348:}
LABELV $397
endproc player_rocket6 0 0
export PainSound
proc PainSound 24 20
line 1354
;1349:
;1350:
;1351:void    DeathBubbles( int num_bubbles );
;1352:
;1353:void PainSound(  )
;1354:{
line 1357
;1355:	float   rs;
;1356:
;1357:	if ( self->s.v.health < 0 )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GEF4 $400
line 1358
;1358:		return;
ADDRGP4 $399
JUMPV
LABELV $400
line 1359
;1359:	if ( streq( damage_attacker->s.v.classname, "teledeath" ) )
ADDRGP4 damage_attacker
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $404
ARGP4
ADDRLP4 4
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $402
line 1360
;1360:	{
line 1361
;1361:		sound( self, 2, "player/gib2.wav", 1, 0 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $405
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 sound
CALLV
pop
line 1362
;1362:		return;
ADDRGP4 $399
JUMPV
LABELV $402
line 1364
;1363:	}
;1364:	if ( self->s.v.watertype == -3 && self->s.v.waterlevel == 3 )
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
CNSTF4 3225419776
NEF4 $406
ADDRLP4 8
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $406
line 1365
;1365:	{
line 1366
;1366:		DeathBubbles( 1 );
CNSTI4 1
ARGI4
ADDRGP4 DeathBubbles
CALLV
pop
line 1367
;1367:		if ( g_random(  ) > 0.5 )
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
CNSTF4 1056964608
LEF4 $408
line 1368
;1368:			sound( self, 2, "player/drown1.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $410
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
ADDRGP4 $399
JUMPV
LABELV $408
line 1370
;1369:		else
;1370:			sound( self, 2, "player/drown2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $411
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
line 1371
;1371:		return;
ADDRGP4 $399
JUMPV
LABELV $406
line 1373
;1372:	}
;1373:	if ( self->s.v.watertype == -4 )
ADDRGP4 self
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
CNSTF4 3229614080
NEF4 $412
line 1374
;1374:	{
line 1375
;1375:		if ( g_random(  ) > 0.5 )
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
CNSTF4 1056964608
LEF4 $414
line 1376
;1376:			sound( self, 2, "player/lburn1.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $416
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
ADDRGP4 $399
JUMPV
LABELV $414
line 1378
;1377:		else
;1378:			sound( self, 2, "player/lburn2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $417
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
line 1379
;1379:		return;
ADDRGP4 $399
JUMPV
LABELV $412
line 1381
;1380:	}
;1381:	if ( self->s.v.watertype == -5 )
ADDRGP4 self
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
CNSTF4 3231711232
NEF4 $418
line 1382
;1382:	{
line 1383
;1383:		if ( g_random(  ) > 0.5 )
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
CNSTF4 1056964608
LEF4 $420
line 1384
;1384:			sound( self, 2, "player/lburn1.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $416
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
ADDRGP4 $399
JUMPV
LABELV $420
line 1386
;1385:		else
;1386:			sound( self, 2, "player/lburn2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $417
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
line 1387
;1387:		return;
ADDRGP4 $399
JUMPV
LABELV $418
line 1389
;1388:	}
;1389:	if ( self->pain_finished > g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 728
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $422
line 1390
;1390:	{
line 1391
;1391:		self->axhitme = 0;
ADDRGP4 self
INDIRP4
CNSTI4 780
ADDP4
CNSTF4 0
ASGNF4
line 1392
;1392:		return;
ADDRGP4 $399
JUMPV
LABELV $422
line 1394
;1393:	}
;1394:	self->pain_finished = g_globalvars.time + 0.5;
ADDRGP4 self
INDIRP4
CNSTI4 728
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 1395
;1395:	if ( self->axhitme == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 780
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $426
line 1396
;1396:	{
line 1397
;1397:		self->axhitme = 0;
ADDRGP4 self
INDIRP4
CNSTI4 780
ADDP4
CNSTF4 0
ASGNF4
line 1398
;1398:		sound( self, 2, "player/axhit1.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $428
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
line 1399
;1399:		return;
ADDRGP4 $399
JUMPV
LABELV $426
line 1401
;1400:	}
;1401:	rs = ( int ) ( g_random(  ) * 5 + 1 );
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
CNSTF4 1084227584
ADDRLP4 12
INDIRF4
MULF4
CNSTF4 1065353216
ADDF4
CVFI4 4
CVIF4 4
ASGNF4
line 1402
;1402:	self->s.v.noise = "";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $429
ASGNP4
line 1403
;1403:	if ( rs == 1 )
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
NEF4 $430
line 1404
;1404:		self->s.v.noise = "player/pain1.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $432
ASGNP4
ADDRGP4 $431
JUMPV
LABELV $430
line 1406
;1405:	else
;1406:	{
line 1407
;1407:		if ( rs == 2 )
ADDRLP4 0
INDIRF4
CNSTF4 1073741824
NEF4 $433
line 1408
;1408:			self->s.v.noise = "player/pain2.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $435
ASGNP4
ADDRGP4 $434
JUMPV
LABELV $433
line 1410
;1409:		else
;1410:		{
line 1411
;1411:			if ( rs == 3 )
ADDRLP4 0
INDIRF4
CNSTF4 1077936128
NEF4 $436
line 1412
;1412:				self->s.v.noise = "player/pain3.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $438
ASGNP4
ADDRGP4 $437
JUMPV
LABELV $436
line 1414
;1413:			else
;1414:			{
line 1415
;1415:				if ( rs == 4 )
ADDRLP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $439
line 1416
;1416:					self->s.v.noise = "player/pain4.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $441
ASGNP4
ADDRGP4 $440
JUMPV
LABELV $439
line 1418
;1417:				else
;1418:				{
line 1419
;1419:					if ( rs == 5 )
ADDRLP4 0
INDIRF4
CNSTF4 1084227584
NEF4 $442
line 1420
;1420:						self->s.v.noise = "player/pain5.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $444
ASGNP4
ADDRGP4 $443
JUMPV
LABELV $442
line 1422
;1421:					else
;1422:						self->s.v.noise = "player/mpain6.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $445
ASGNP4
LABELV $443
line 1423
;1423:				}
LABELV $440
line 1424
;1424:			}
LABELV $437
line 1425
;1425:		}
LABELV $434
line 1426
;1426:	}
LABELV $431
line 1427
;1427:	sound( self, 2, self->s.v.noise, 1, 1 );
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
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
line 1428
;1428:	return;
LABELV $399
endproc PainSound 24 20
export player_pain1
proc player_pain1 0 0
line 1432
;1429:}
;1430:
;1431:void player_pain1(  )
;1432:{
line 1433
;1433:	self->s.v.frame = 35;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1108082688
ASGNF4
line 1434
;1434:	self->s.v.think = ( func_t ) player_pain2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_pain2
CVPU4 4
CVUI4 4
ASGNI4
line 1435
;1435:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1437
;1436:
;1437:	PainSound(  );
ADDRGP4 PainSound
CALLV
pop
line 1438
;1438:	self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 1439
;1439:}
LABELV $446
endproc player_pain1 0 0
export player_pain2
proc player_pain2 0 0
line 1442
;1440:
;1441:void player_pain2(  )
;1442:{
line 1443
;1443:	self->s.v.frame = 36;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1108344832
ASGNF4
line 1444
;1444:	self->s.v.think = ( func_t ) player_pain3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_pain3
CVPU4 4
CVUI4 4
ASGNI4
line 1445
;1445:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1447
;1446:
;1447:}
LABELV $448
endproc player_pain2 0 0
export player_pain3
proc player_pain3 0 0
line 1450
;1448:
;1449:void player_pain3(  )
;1450:{
line 1451
;1451:	self->s.v.frame = 37;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1108606976
ASGNF4
line 1452
;1452:	self->s.v.think = ( func_t ) player_pain4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_pain4
CVPU4 4
CVUI4 4
ASGNI4
line 1453
;1453:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1455
;1454:
;1455:}
LABELV $450
endproc player_pain3 0 0
export player_pain4
proc player_pain4 0 0
line 1458
;1456:
;1457:void player_pain4(  )
;1458:{
line 1459
;1459:	self->s.v.frame = 38;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1108869120
ASGNF4
line 1460
;1460:	self->s.v.think = ( func_t ) player_pain5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_pain5
CVPU4 4
CVUI4 4
ASGNI4
line 1461
;1461:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1463
;1462:
;1463:}
LABELV $452
endproc player_pain4 0 0
export player_pain5
proc player_pain5 0 0
line 1466
;1464:
;1465:void player_pain5(  )
;1466:{
line 1467
;1467:	self->s.v.frame = 39;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1109131264
ASGNF4
line 1468
;1468:	self->s.v.think = ( func_t ) player_pain6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_pain6
CVPU4 4
CVUI4 4
ASGNI4
line 1469
;1469:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1471
;1470:
;1471:}
LABELV $454
endproc player_pain5 0 0
export player_pain6
proc player_pain6 0 0
line 1474
;1472:
;1473:void player_pain6(  )
;1474:{
line 1475
;1475:	self->s.v.frame = 40;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1109393408
ASGNF4
line 1476
;1476:	self->s.v.think = ( func_t ) player_run;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_run
CVPU4 4
CVUI4 4
ASGNI4
line 1477
;1477:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1479
;1478:
;1479:}
LABELV $456
endproc player_pain6 0 0
export player_axpain1
proc player_axpain1 0 0
line 1482
;1480:
;1481:void player_axpain1(  )
;1482:{
line 1483
;1483:	self->s.v.frame = 29;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1105723392
ASGNF4
line 1484
;1484:	self->s.v.think = ( func_t ) player_axpain2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_axpain2
CVPU4 4
CVUI4 4
ASGNI4
line 1485
;1485:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1487
;1486:
;1487:	PainSound(  );
ADDRGP4 PainSound
CALLV
pop
line 1488
;1488:	self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 1489
;1489:}
LABELV $458
endproc player_axpain1 0 0
export player_axpain2
proc player_axpain2 0 0
line 1492
;1490:
;1491:void player_axpain2(  )
;1492:{
line 1493
;1493:	self->s.v.frame = 30;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1106247680
ASGNF4
line 1494
;1494:	self->s.v.think = ( func_t ) player_axpain3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_axpain3
CVPU4 4
CVUI4 4
ASGNI4
line 1495
;1495:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1497
;1496:
;1497:}
LABELV $460
endproc player_axpain2 0 0
export player_axpain3
proc player_axpain3 0 0
line 1500
;1498:
;1499:void player_axpain3(  )
;1500:{
line 1501
;1501:	self->s.v.frame = 31;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1106771968
ASGNF4
line 1502
;1502:	self->s.v.think = ( func_t ) player_axpain4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_axpain4
CVPU4 4
CVUI4 4
ASGNI4
line 1503
;1503:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1505
;1504:
;1505:}
LABELV $462
endproc player_axpain3 0 0
export player_axpain4
proc player_axpain4 0 0
line 1508
;1506:
;1507:void player_axpain4(  )
;1508:{
line 1509
;1509:	self->s.v.frame = 32;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1107296256
ASGNF4
line 1510
;1510:	self->s.v.think = ( func_t ) player_axpain5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_axpain5
CVPU4 4
CVUI4 4
ASGNI4
line 1511
;1511:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1513
;1512:
;1513:}
LABELV $464
endproc player_axpain4 0 0
export player_axpain5
proc player_axpain5 0 0
line 1516
;1514:
;1515:void player_axpain5(  )
;1516:{
line 1517
;1517:	self->s.v.frame = 33;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1107558400
ASGNF4
line 1518
;1518:	self->s.v.think = ( func_t ) player_axpain6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_axpain6
CVPU4 4
CVUI4 4
ASGNI4
line 1519
;1519:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1521
;1520:
;1521:}
LABELV $466
endproc player_axpain5 0 0
export player_axpain6
proc player_axpain6 0 0
line 1524
;1522:
;1523:void player_axpain6(  )
;1524:{
line 1525
;1525:	self->s.v.frame = 34;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1107820544
ASGNF4
line 1526
;1526:	self->s.v.think = ( func_t ) player_run;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_run
CVPU4 4
CVUI4 4
ASGNI4
line 1527
;1527:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1529
;1528:
;1529:}
LABELV $468
endproc player_axpain6 0 0
export player_pain
proc player_pain 4 0
line 1532
;1530:
;1531:void player_pain( gedict_t * attacker, float take  )
;1532:{
line 1533
;1533:	if ( self->s.v.weaponframe )
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
INDIRF4
CNSTF4 0
EQF4 $471
line 1534
;1534:	{
line 1535
;1535:		if ( tf_data.deathmsg == DMSG_TEAMKILL )
ADDRGP4 tf_data+88
INDIRI4
CNSTI4 37
NEI4 $470
line 1536
;1536:			PainSound(  );
ADDRGP4 PainSound
CALLV
pop
line 1537
;1537:		return;
ADDRGP4 $470
JUMPV
LABELV $471
line 1539
;1538:	}
;1539:	if ( self->invisible_finished > g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 736
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $476
line 1540
;1540:		return;
ADDRGP4 $470
JUMPV
LABELV $476
line 1541
;1541:	if ( self->is_feigning )
ADDRGP4 self
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
EQI4 $479
line 1542
;1542:	{
line 1543
;1543:		PainSound(  );
ADDRGP4 PainSound
CALLV
pop
line 1544
;1544:		return;
ADDRGP4 $470
JUMPV
LABELV $479
line 1546
;1545:	}
;1546:	if ( self->s.v.button0 && self->current_weapon == WEAP_ASSAULT_CANNON )
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
CNSTF4 0
EQF4 $481
ADDRLP4 0
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 32768
NEI4 $481
line 1547
;1547:		return;
ADDRGP4 $470
JUMPV
LABELV $481
line 1548
;1548:	if ( self->current_weapon <= 16 )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 16
GTI4 $483
line 1549
;1549:		player_axpain1(  );
ADDRGP4 player_axpain1
CALLV
pop
ADDRGP4 $484
JUMPV
LABELV $483
line 1551
;1550:	else
;1551:		player_pain1(  );
ADDRGP4 player_pain1
CALLV
pop
LABELV $484
line 1552
;1552:}
LABELV $470
endproc player_pain 4 0
export DeathBubblesSpawn
proc DeathBubblesSpawn 24 28
line 1556
;1553:
;1554:
;1555:void DeathBubblesSpawn(  )
;1556:{
line 1557
;1557:	if ( PROG_TO_EDICT( self->s.v.owner )->s.v.waterlevel != 3 )
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+320
ADDP4
INDIRF4
CNSTF4 1077936128
EQF4 $486
line 1558
;1558:		return;
ADDRGP4 $485
JUMPV
LABELV $486
line 1559
;1559:	newmis = spawn(  );
ADDRLP4 0
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 0
INDIRP4
ASGNP4
line 1560
;1560:	setmodel( newmis, "progs/s_bubble.spr" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $490
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1561
;1561:	setorigin( newmis, PROG_TO_EDICT( self->s.v.owner )->s.v.origin[0],
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRGP4 g_edicts+112+44
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRI4
ADDRGP4 g_edicts+112+44+4
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRI4
ADDRGP4 g_edicts+112+44+8
ADDP4
INDIRF4
CNSTF4 1103101952
ADDF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 1565
;1562:		   PROG_TO_EDICT( self->s.v.owner )->s.v.origin[1],
;1563:		   PROG_TO_EDICT( self->s.v.owner )->s.v.origin[2] + 24 );
;1564:
;1565:	newmis->s.v.movetype = MOVETYPE_NOCLIP;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1090519040
ASGNF4
line 1566
;1566:	newmis->s.v.solid = SOLID_NOT;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 1567
;1567:	SetVector( newmis->s.v.velocity, 0, 0, 15 );
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
line 1568
;1568:	newmis->s.v.nextthink = g_globalvars.time + 0.5;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 1569
;1569:	newmis->s.v.think = ( func_t ) bubble_bob;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 bubble_bob
CVPU4 4
CVUI4 4
ASGNI4
line 1570
;1570:	newmis->s.v.classname = "bubble";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $500
ASGNP4
line 1571
;1571:	newmis->s.v.frame = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 0
ASGNF4
line 1572
;1572:	newmis->cnt = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 692
ADDP4
CNSTF4 0
ASGNF4
line 1573
;1573:	setsize( newmis, -8, -8, -8, 8, 8, 8 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 8
CNSTF4 3238002688
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
CNSTF4 1090519040
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
line 1574
;1574:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1575
;1575:	self->s.v.think = ( func_t ) DeathBubblesSpawn;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 DeathBubblesSpawn
CVPU4 4
CVUI4 4
ASGNI4
line 1576
;1576:	self->air_finished = self->air_finished + 1;
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 796
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
line 1577
;1577:	if ( self->air_finished >= self->bubble_count )
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 796
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
LTF4 $502
line 1578
;1578:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
LABELV $502
line 1579
;1579:}
LABELV $485
endproc DeathBubblesSpawn 24 28
export DeathBubbles
proc DeathBubbles 12 16
line 1582
;1580:
;1581:void DeathBubbles( int num_bubbles )
;1582:{
line 1585
;1583:	gedict_t *bubble_spawner;
;1584:
;1585:	bubble_spawner = spawn(  );
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1586
;1586:	setorigin( bubble_spawner, PASSVEC3( self->s.v.origin ) );
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
line 1587
;1587:	bubble_spawner->s.v.movetype = MOVETYPE_NONE;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 1588
;1588:	bubble_spawner->s.v.solid = SOLID_NOT;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 1589
;1589:	bubble_spawner->s.v.nextthink = g_globalvars.time + 0.1;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1590
;1590:	bubble_spawner->s.v.think = ( func_t ) DeathBubblesSpawn;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 DeathBubblesSpawn
CVPU4 4
CVUI4 4
ASGNI4
line 1591
;1591:	bubble_spawner->air_finished = 0;
ADDRLP4 0
INDIRP4
CNSTI4 796
ADDP4
CNSTF4 0
ASGNF4
line 1592
;1592:	bubble_spawner->s.v.owner = EDICT_TO_PROG( self );
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
line 1593
;1593:	bubble_spawner->bubble_count = num_bubbles;
ADDRLP4 0
INDIRP4
CNSTI4 800
ADDP4
ADDRFP4 0
INDIRI4
CVIF4 4
ASGNF4
line 1594
;1594:	return;
LABELV $504
endproc DeathBubbles 12 16
export DeathSound
proc DeathSound 12 20
line 1598
;1595:}
;1596:
;1597:void DeathSound(  )
;1598:{
line 1601
;1599:	float   rs;
;1600:
;1601:	if ( self->s.v.waterlevel == 3 )
ADDRGP4 self
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $507
line 1602
;1602:	{
line 1603
;1603:		if ( self->is_feigning )
ADDRGP4 self
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
EQI4 $509
line 1604
;1604:			DeathBubbles( 2 );
CNSTI4 2
ARGI4
ADDRGP4 DeathBubbles
CALLV
pop
ADDRGP4 $510
JUMPV
LABELV $509
line 1606
;1605:		else
;1606:			DeathBubbles( 10 );
CNSTI4 10
ARGI4
ADDRGP4 DeathBubbles
CALLV
pop
LABELV $510
line 1607
;1607:		sound( self, 2, "player/h2odeath.wav", 1, 0 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $511
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 sound
CALLV
pop
line 1608
;1608:		return;
ADDRGP4 $506
JUMPV
LABELV $507
line 1610
;1609:	}
;1610:	rs = ( int ) ( g_random(  ) * 5 + 1 );
ADDRLP4 4
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
CNSTF4 1084227584
ADDRLP4 4
INDIRF4
MULF4
CNSTF4 1065353216
ADDF4
CVFI4 4
CVIF4 4
ASGNF4
line 1611
;1611:	if ( rs == 1 )
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
NEF4 $512
line 1612
;1612:		self->s.v.noise = "player/death1.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $514
ASGNP4
LABELV $512
line 1613
;1613:	if ( rs == 2 )
ADDRLP4 0
INDIRF4
CNSTF4 1073741824
NEF4 $515
line 1614
;1614:		self->s.v.noise = "player/death2.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $517
ASGNP4
LABELV $515
line 1615
;1615:	if ( rs == 3 )
ADDRLP4 0
INDIRF4
CNSTF4 1077936128
NEF4 $518
line 1616
;1616:		self->s.v.noise = "player/death3.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $520
ASGNP4
LABELV $518
line 1617
;1617:	if ( rs == 4 )
ADDRLP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $521
line 1618
;1618:		self->s.v.noise = "player/death4.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $523
ASGNP4
LABELV $521
line 1619
;1619:	if ( rs == 5 )
ADDRLP4 0
INDIRF4
CNSTF4 1084227584
NEF4 $524
line 1620
;1620:		self->s.v.noise = "player/mdeath5.wav";
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 $526
ASGNP4
LABELV $524
line 1621
;1621:	sound( self, 2, self->s.v.noise, 1, 0 );
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
CNSTI4 504
ADDP4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 sound
CALLV
pop
line 1622
;1622:	return;
LABELV $506
endproc DeathSound 12 20
export PlayerDead
proc PlayerDead 0 0
line 1626
;1623:}
;1624:
;1625:void PlayerDead(  )
;1626:{
line 1627
;1627:	self->s.v.nextthink = -1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
CNSTF4 3212836864
ASGNF4
line 1628
;1628:	self->s.v.deadflag = DEAD_DEAD;
ADDRGP4 self
INDIRP4
CNSTI4 348
ADDP4
CNSTF4 1073741824
ASGNF4
line 1629
;1629:}
LABELV $527
endproc PlayerDead 0 0
export VelocityForDamage
proc VelocityForDamage 24 12
line 1632
;1630:
;1631:void VelocityForDamage( float dm, vec3_t v )
;1632:{
line 1634
;1633:
;1634:	v[0] = 100 * crandom(  );
ADDRLP4 0
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTF4 1120403456
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 1635
;1635:	v[1] = 100 * crandom(  );
ADDRLP4 4
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1120403456
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 1636
;1636:	v[2] = 200 + 100 * g_random(  );
ADDRLP4 8
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1120403456
ADDRLP4 8
INDIRF4
MULF4
CNSTF4 1128792064
ADDF4
ASGNF4
line 1637
;1637:	if ( dm > -50 )
ADDRFP4 0
INDIRF4
CNSTF4 3259498496
LEF4 $529
line 1638
;1638:		VectorScale( v, 0.7, v );
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTF4 1060320051
ARGF4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
ADDRGP4 $528
JUMPV
LABELV $529
line 1640
;1639:	else
;1640:	{
line 1641
;1641:		if ( dm > -200 )
ADDRFP4 0
INDIRF4
CNSTF4 3276275712
LEF4 $531
line 1642
;1642:			VectorScale( v, 2, v );
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTF4 1073741824
ARGF4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
ADDRGP4 $528
JUMPV
LABELV $531
line 1644
;1643:		else
;1644:			VectorScale( v, 10, v );
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 1092616192
ARGF4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 1645
;1645:	}
line 1646
;1646:	return;
LABELV $528
endproc VelocityForDamage 24 12
export ThrowGib
proc ThrowGib 32 28
line 1650
;1647:}
;1648:
;1649:void ThrowGib( char *gibname, float dm )
;1650:{
line 1651
;1651:	newmis = spawn(  );
ADDRLP4 0
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 0
INDIRP4
ASGNP4
line 1652
;1652:	VectorCopy( self->s.v.origin, newmis->s.v.origin );
ADDRLP4 4
CNSTI4 156
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 8
CNSTI4 160
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12
CNSTI4 164
ASGNI4
ADDRGP4 newmis
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
line 1653
;1653:	if ( tf_data.birthday == 1 && g_random(  ) < 0.3 )
ADDRGP4 tf_data+92
INDIRI4
CNSTI4 1
NEI4 $534
ADDRLP4 4
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 1050253722
GEF4 $534
line 1654
;1654:	{
line 1655
;1655:		setmodel( newmis, "progs/grenade3.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $537
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1656
;1656:		newmis->s.v.skin = g_random(  ) * 4;
ADDRLP4 8
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 1082130432
ADDRLP4 8
INDIRF4
MULF4
ASGNF4
line 1657
;1657:		newmis->s.v.skin = floor( newmis->s.v.skin );
ADDRLP4 12
ADDRGP4 newmis
INDIRP4
CNSTI4 228
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 floor
CALLF4
ASGNF4
ADDRLP4 12
INDIRP4
ADDRLP4 16
INDIRF4
ASGNF4
line 1658
;1658:	} else
ADDRGP4 $535
JUMPV
LABELV $534
line 1659
;1659:		setmodel( newmis, gibname );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
LABELV $535
line 1660
;1660:	setsize( newmis, 0, 0, 0, 0, 0, 0 );
ADDRGP4 newmis
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
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1661
;1661:	VelocityForDamage( dm, newmis->s.v.velocity );
ADDRFP4 4
INDIRF4
ARGF4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 VelocityForDamage
CALLV
pop
line 1662
;1662:	newmis->s.v.movetype = MOVETYPE_BOUNCE;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1092616192
ASGNF4
line 1663
;1663:	newmis->s.v.solid = SOLID_NOT;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 1664
;1664:	newmis->s.v.avelocity[0] = g_random(  ) * 600;
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 1142292480
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
line 1665
;1665:	newmis->s.v.avelocity[1] = g_random(  ) * 600;
ADDRLP4 16
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 1142292480
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 1666
;1666:	newmis->s.v.avelocity[2] = g_random(  ) * 600;
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 1142292480
ADDRLP4 20
INDIRF4
MULF4
ASGNF4
line 1667
;1667:	newmis->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 1668
;1668:	newmis->s.v.ltime = g_globalvars.time;
ADDRGP4 newmis
INDIRP4
CNSTI4 140
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ASGNF4
line 1669
;1669:	newmis->s.v.nextthink = g_globalvars.time + 10 + g_random(  ) * 10;
ADDRLP4 24
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 28
CNSTF4 1092616192
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
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
line 1670
;1670:	newmis->s.v.frame = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 0
ASGNF4
line 1671
;1671:	newmis->s.v.flags = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 404
ADDP4
CNSTF4 0
ASGNF4
line 1672
;1672:}
LABELV $533
endproc ThrowGib 32 28
export ThrowHead
proc ThrowHead 24 28
line 1675
;1673:
;1674:void ThrowHead( char *gibname, float dm )
;1675:{
line 1676
;1676:	setmodel( self, gibname );
ADDRGP4 self
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1677
;1677:	self->s.v.skin = 0;
ADDRGP4 self
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 0
ASGNF4
line 1678
;1678:	self->s.v.frame = 0;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 0
ASGNF4
line 1679
;1679:	self->s.v.nextthink = -1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
CNSTF4 3212836864
ASGNF4
line 1680
;1680:	self->s.v.movetype = MOVETYPE_BOUNCE;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1092616192
ASGNF4
line 1681
;1681:	self->s.v.takedamage = 0;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 0
ASGNF4
line 1682
;1682:	self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 1683
;1683:	SetVector( self->s.v.view_ofs, 0, 0, 8 );
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
CNSTF4 1090519040
ASGNF4
line 1684
;1684:	setsize( self, -16, -16, 0, 16, 16, 56 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 0
CNSTF4 3246391296
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 4
CNSTF4 1098907648
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 1113587712
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1685
;1685:	VelocityForDamage( dm, self->s.v.velocity );
ADDRFP4 4
INDIRF4
ARGF4
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 VelocityForDamage
CALLV
pop
line 1686
;1686:	self->s.v.origin[2] = self->s.v.origin[2] - 24;
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
CNSTF4 1103101952
SUBF4
ASGNF4
line 1687
;1687:	self->s.v.flags = ( int ) self->s.v.flags - ( ( int ) self->s.v.flags & 512 );
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 16
INDIRI4
ADDRLP4 16
INDIRI4
CNSTI4 512
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 1688
;1688:	SetVector( self->s.v.avelocity, 0, crandom(  ) * 600, 0 );
ADDRGP4 self
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 20
ADDRGP4 crandom
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 1142292480
ADDRLP4 20
INDIRF4
MULF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 0
ASGNF4
line 1689
;1689:}
LABELV $540
endproc ThrowHead 24 28
export HeadShotThrowHead
proc HeadShotThrowHead 28 28
line 1692
;1690:
;1691:void HeadShotThrowHead( char *gibname )
;1692:{
line 1693
;1693:	setmodel( self, gibname );
ADDRGP4 self
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1694
;1694:	self->s.v.frame = 0;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 0
ASGNF4
line 1695
;1695:	self->s.v.nextthink = -1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
CNSTF4 3212836864
ASGNF4
line 1696
;1696:	self->s.v.movetype = MOVETYPE_BOUNCE;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1092616192
ASGNF4
line 1697
;1697:	self->s.v.takedamage = 0;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 0
ASGNF4
line 1698
;1698:	self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 1699
;1699:	SetVector( self->s.v.view_ofs, 0, 0, 8 );
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
CNSTF4 1090519040
ASGNF4
line 1700
;1700:	setsize( self, -16, -16, 0, 16, 16, 56 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 0
CNSTF4 3246391296
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 4
CNSTF4 1098907648
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTF4 1113587712
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1701
;1701:	normalize( self->head_shot_vector, self->s.v.velocity );
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 1452
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 normalize
CALLV
pop
line 1702
;1702:	VectorScale( self->s.v.velocity, 600, self->s.v.velocity );
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTF4 1142292480
ARGF4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 1704
;1703:	//self->s.v.velocity = normalize(self->head_shot_vector) * 600;
;1704:	self->s.v.origin[2] = self->s.v.origin[2] + 24;
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
CNSTF4 1103101952
ADDF4
ASGNF4
line 1705
;1705:	self->s.v.flags = ( int ) self->s.v.flags - ( ( int ) self->s.v.flags & 512 );
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRI4
ADDRLP4 24
INDIRI4
CNSTI4 512
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 1706
;1706:	SetVector( self->s.v.avelocity, 0, 0, 0 );
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
line 1707
;1707:}
LABELV $541
endproc HeadShotThrowHead 28 28
export KillPlayer
proc KillPlayer 0 4
line 1710
;1708:
;1709:void KillPlayer(  )
;1710:{
line 1711
;1711:	PROG_TO_EDICT( self->s.v.owner )->s.v.deadflag = DEAD_DEAD;
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+112+236
ADDP4
CNSTF4 1073741824
ASGNF4
line 1712
;1712:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1713
;1713:}
LABELV $542
endproc KillPlayer 0 4
export GibPlayer
proc GibPlayer 24 28
line 1717
;1714:
;1715:#define HEADLESS_GIB
;1716:void GibPlayer(  )
;1717:{
line 1719
;1718:#ifdef HEADLESS_GIB
;1719:	if (tf_data.deathmsg == DMSG_SNIPERHEADSHOT || tf_data.deathmsg == DMSG_BACKSTAB)
ADDRGP4 tf_data+88
INDIRI4
CNSTI4 29
EQI4 $550
ADDRGP4 tf_data+88
INDIRI4
CNSTI4 22
NEI4 $546
LABELV $550
line 1720
;1720:	{
line 1721
;1721:		if (tf_data.deathmsg == DMSG_SNIPERHEADSHOT)
ADDRGP4 tf_data+88
INDIRI4
CNSTI4 29
NEI4 $551
line 1722
;1722:			HeadShotThrowHead("progs/h_player.mdl");
ADDRGP4 $554
ARGP4
ADDRGP4 HeadShotThrowHead
CALLV
pop
ADDRGP4 $552
JUMPV
LABELV $551
line 1724
;1723:		else
;1724:			ThrowHead("progs/h_player.mdl", -60);
ADDRGP4 $554
ARGP4
CNSTF4 3262119936
ARGF4
ADDRGP4 ThrowHead
CALLV
pop
LABELV $552
line 1726
;1725:
;1726:		newmis = spawn();
ADDRLP4 0
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 0
INDIRP4
ASGNP4
line 1727
;1727:		g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 1728
;1728:		newmis->s.v.solid = SOLID_NOT;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 1729
;1729:		setmodel(newmis, "progs/headless.mdl");
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $556
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1730
;1730:		setsize(newmis, 0,0,0, 0,0,0);
ADDRGP4 newmis
INDIRP4
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
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1731
;1731:		setorigin(newmis, PASSVEC3(self->s.v.origin)-47);
ADDRGP4 newmis
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
CNSTF4 1111228416
SUBF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 1732
;1732:		newmis->s.v.movetype = MOVETYPE_STEP;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1082130432
ASGNF4
line 1733
;1733:		VectorCopy(self->s.v.angles,newmis->s.v.angles);
ADDRLP4 12
CNSTI4 192
ASGNI4
ADDRGP4 newmis
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
CNSTI4 196
ASGNI4
ADDRGP4 newmis
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
CNSTI4 200
ASGNI4
ADDRGP4 newmis
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
line 1735
;1734:		//VectorCopy(self->s.v.velocity,newmis->s.v.velocity);
;1735:		newmis->s.v.colormap = self->s.v.colormap ;
ADDRLP4 12
CNSTI4 408
ASGNI4
ADDRGP4 newmis
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
line 1737
;1736:		//newmis->s.v.colormap = TeamFortress_TeamGetColor(self->team_no);
;1737:		newmis->s.v.skin = self->s.v.skin;
ADDRLP4 16
CNSTI4 228
ASGNI4
ADDRGP4 newmis
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
line 1738
;1738:		newmis->s.v.think = ( func_t )Headless_Think;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 Headless_Think
CVPU4 4
CVUI4 4
ASGNI4
line 1739
;1739:		newmis->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1740
;1740:		if (self->current_weapon <= WEAP_AXE)
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 16
GTI4 $558
line 1741
;1741:			newmis->s.v.frame = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $547
JUMPV
LABELV $558
line 1743
;1742:		else
;1743:			newmis->s.v.frame = 8; 
ADDRGP4 newmis
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1090519040
ASGNF4
line 1745
;1744:
;1745:	}
ADDRGP4 $547
JUMPV
LABELV $546
line 1747
;1746:	else
;1747:	{
line 1749
;1748:#endif
;1749:        	ThrowHead( "progs/h_player.mdl", self->s.v.health );
ADDRGP4 $554
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ARGF4
ADDRGP4 ThrowHead
CALLV
pop
line 1750
;1750:        	ThrowGib( "progs/gib1.mdl", self->s.v.health );
ADDRGP4 $560
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ARGF4
ADDRGP4 ThrowGib
CALLV
pop
line 1751
;1751:        	ThrowGib( "progs/gib2.mdl", self->s.v.health );
ADDRGP4 $561
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ARGF4
ADDRGP4 ThrowGib
CALLV
pop
line 1752
;1752:        	ThrowGib( "progs/gib3.mdl", self->s.v.health );
ADDRGP4 $562
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ARGF4
ADDRGP4 ThrowGib
CALLV
pop
line 1754
;1753:#ifdef HEADLESS_GIB
;1754:	}
LABELV $547
line 1756
;1755:#endif
;1756:	if ( tf_data.deathmsg == DMSG_TRIGGER )
ADDRGP4 tf_data+88
INDIRI4
CNSTI4 36
NEI4 $563
line 1757
;1757:	{
line 1758
;1758:		newmis = spawn(  );
ADDRLP4 0
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 0
INDIRP4
ASGNP4
line 1759
;1759:		newmis->s.v.owner = EDICT_TO_PROG( self );
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
line 1760
;1760:		newmis->s.v.think = ( func_t ) KillPlayer;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 KillPlayer
CVPU4 4
CVUI4 4
ASGNI4
line 1761
;1761:		newmis->s.v.nextthink = g_globalvars.time + 1;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1762
;1762:	} else
ADDRGP4 $564
JUMPV
LABELV $563
line 1763
;1763:		self->s.v.deadflag = DEAD_DEAD;
ADDRGP4 self
INDIRP4
CNSTI4 348
ADDP4
CNSTF4 1073741824
ASGNF4
LABELV $564
line 1765
;1764:
;1765:	TeamFortress_SetupRespawn( 0 );
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_SetupRespawn
CALLV
pop
line 1766
;1766:	if ( streq( damage_attacker->s.v.classname, "teledeath" ) )
ADDRGP4 damage_attacker
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $404
ARGP4
ADDRLP4 0
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $567
line 1767
;1767:	{
line 1769
;1768:		//sound( self, 2, "player/teledth1.wav", 1, 0 );
;1769:		sound( self, 2, "player/gib2.wav", 1, 0 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $405
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 sound
CALLV
pop
line 1770
;1770:		self->respawn_time = self->respawn_time + 2 + g_random(  ) * 2;
ADDRLP4 4
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 988
ADDP4
ASGNP4
ADDRLP4 12
CNSTF4 1073741824
ASGNF4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 12
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1771
;1771:		return;
ADDRGP4 $545
JUMPV
LABELV $567
line 1773
;1772:	}
;1773:	if ( streq( damage_attacker->s.v.classname, "teledeath2" ) )
ADDRGP4 damage_attacker
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $571
ARGP4
ADDRLP4 4
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $569
line 1774
;1774:	{
line 1776
;1775:		//sound( self, 2, "player/teledth1.wav", 1, 0 );
;1776:		sound( self, 2, "player/gib2.wav", 1, 0 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $405
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 sound
CALLV
pop
line 1777
;1777:		self->respawn_time = self->respawn_time + 2 + g_random(  ) * 2;
ADDRLP4 8
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 988
ADDP4
ASGNP4
ADDRLP4 16
CNSTF4 1073741824
ASGNF4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 16
INDIRF4
ADDF4
ADDRLP4 16
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1778
;1778:		return;
ADDRGP4 $545
JUMPV
LABELV $569
line 1780
;1779:	}
;1780:	if ( g_random(  ) < 0.2 )
ADDRLP4 8
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 8
INDIRF4
CNSTF4 1045220557
GEF4 $572
line 1781
;1781:		sound( self, 2, "player/gib3.wav", 1, 0 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $574
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 sound
CALLV
pop
ADDRGP4 $573
JUMPV
LABELV $572
line 1783
;1782:	else
;1783:		sound( self, 2, "player/gib2.wav", 1, 0 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $405
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 sound
CALLV
pop
LABELV $573
line 1784
;1784:}
LABELV $545
endproc GibPlayer 24 28
export PlayerDie
proc PlayerDie 56 12
line 1787
;1785:
;1786:void PlayerDie(  )
;1787:{
line 1792
;1788://	float   i;
;1789:	gedict_t *te;
;1790:	gedict_t *saveself;
;1791:
;1792:	if ( self->hook_out )
ADDRGP4 self
INDIRP4
CNSTI4 1436
ADDP4
INDIRI4
CNSTI4 0
EQI4 $576
line 1793
;1793:	{
line 1794
;1794:		Reset_Grapple( self->hook );
ADDRGP4 self
INDIRP4
CNSTI4 1440
ADDP4
INDIRP4
ARGP4
ADDRGP4 Reset_Grapple
CALLV
pop
line 1795
;1795:		Attack_Finished( 0.75 );
CNSTF4 1061158912
ARGF4
ADDRGP4 Attack_Finished
CALLV
pop
line 1796
;1796:		self->hook_out = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1436
ADDP4
CNSTI4 1
ASGNI4
line 1797
;1797:	}
LABELV $576
line 1798
;1798:	self->tf_impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1544
ADDP4
CNSTI4 0
ASGNI4
line 1799
;1799:	self->imp1 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1548
ADDP4
CNSTI4 0
ASGNI4
line 1800
;1800:	self->imp2 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1552
ADDP4
CNSTI4 0
ASGNI4
line 1801
;1801:	self->imp3 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1556
ADDP4
CNSTI4 0
ASGNI4
line 1802
;1802:	self->imp4 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1560
ADDP4
CNSTI4 0
ASGNI4
line 1804
;1803:
;1804:       	self->s.v.button0 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 364
ADDP4
CNSTF4 0
ASGNF4
line 1805
;1805:       	self->s.v.button1 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 368
ADDP4
CNSTF4 0
ASGNF4
line 1806
;1806:       	self->s.v.button2 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 372
ADDP4
CNSTF4 0
ASGNF4
line 1808
;1807:
;1808:	for(te = world; (te = trap_find( te, FOFS( s.v.classname ), "primer" ));)
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $581
JUMPV
LABELV $578
line 1809
;1809:	{
line 1810
;1810:		if(te->s.v.owner == EDICT_TO_PROG( self ))
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
NEI4 $583
line 1811
;1811:			break;
ADDRGP4 $580
JUMPV
LABELV $583
line 1813
;1812:	
;1813:	}
LABELV $579
line 1808
LABELV $581
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $582
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
NEU4 $578
LABELV $580
line 1814
;1814:	if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $585
line 1816
;1815://  te->s.v.nextthink = g_globalvars.time;
;1816:	{
line 1817
;1817:		self->s.v.deadflag = DEAD_DYING;
ADDRGP4 self
INDIRP4
CNSTI4 348
ADDP4
CNSTF4 1065353216
ASGNF4
line 1818
;1818:		saveself = self;
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
line 1819
;1819:		self = te;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 1820
;1820:		( ( void ( * )(  ) ) ( self->s.v.think ) ) (  );
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
CVIU4 4
CVUP4 4
CALLV
pop
line 1821
;1821:		self = saveself;
ADDRGP4 self
ADDRLP4 4
INDIRP4
ASGNP4
line 1822
;1822:		self->s.v.deadflag = DEAD_NO;
ADDRGP4 self
INDIRP4
CNSTI4 348
ADDP4
CNSTF4 0
ASGNF4
line 1823
;1823:	}
LABELV $585
line 1824
;1824:	self->s.v.items = ( int ) self->s.v.items - ( ( int ) self->s.v.items & 524288 );
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 16
INDIRI4
ADDRLP4 16
INDIRI4
CNSTI4 524288
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 1825
;1825:	self->invisible_finished = 0;
ADDRGP4 self
INDIRP4
CNSTI4 736
ADDP4
CNSTF4 0
ASGNF4
line 1826
;1826:	self->invincible_finished = 0;
ADDRGP4 self
INDIRP4
CNSTI4 732
ADDP4
CNSTF4 0
ASGNF4
line 1827
;1827:	self->super_damage_finished = 0;
ADDRGP4 self
INDIRP4
CNSTI4 740
ADDP4
CNSTF4 0
ASGNF4
line 1828
;1828:	self->radsuit_finished = 0;
ADDRGP4 self
INDIRP4
CNSTI4 744
ADDP4
CNSTF4 0
ASGNF4
line 1829
;1829:	self->s.v.modelindex = modelindex_player;
ADDRGP4 self
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 modelindex_player
INDIRI4
CVIF4 4
ASGNF4
line 1830
;1830:	if ( ( self->tfstate & TFSTATE_INFECTED ) && self == PROG_TO_EDICT( self->s.v.enemy ) )
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $587
ADDRLP4 20
INDIRP4
CVPU4 4
ADDRLP4 20
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
NEU4 $587
line 1831
;1831:	{
line 1832
;1832:		te = trap_find( world, FOFS( s.v.classname ), "timer" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 24
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
ADDRGP4 $590
JUMPV
LABELV $589
line 1834
;1833:		while ( te )
;1834:		{
line 1835
;1835:			if ( PROG_TO_EDICT( te->s.v.owner ) == self && te->s.v.think == ( func_t ) BioInfection_Decay )
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
ADDRGP4 self
INDIRP4
CVPU4 4
NEU4 $592
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ADDRGP4 BioInfection_Decay
CVPU4 4
CVUI4 4
NEI4 $592
line 1836
;1836:			{
line 1837
;1837:				logfrag( PROG_TO_EDICT( te->s.v.enemy ), self );
ADDRLP4 0
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 logfrag
CALLV
pop
line 1838
;1838:				TF_AddFrags( PROG_TO_EDICT( te->s.v.enemy ), 1 );
ADDRLP4 0
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
line 1839
;1839:			}
LABELV $592
line 1840
;1840:			te = trap_find( te, FOFS( s.v.classname ), "timer" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $49
ARGP4
ADDRLP4 32
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 1841
;1841:		}
LABELV $590
line 1833
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $589
line 1842
;1842:	}
LABELV $587
line 1843
;1843:	TeamFortress_RemoveTimers(  );
ADDRGP4 TeamFortress_RemoveTimers
CALLV
pop
line 1844
;1844:	if ( deathmatch || coop )
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 deathmatch
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $596
ADDRGP4 coop
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $594
LABELV $596
line 1845
;1845:		DropBackpack(  );
ADDRGP4 DropBackpack
CALLV
pop
LABELV $594
line 1846
;1846:	self->s.v.weaponmodel = "";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $429
ASGNP4
line 1847
;1847:	SetVector( self->s.v.view_ofs, 0, 0, -8 );
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
CNSTF4 3238002688
ASGNF4
line 1848
;1848:	self->s.v.deadflag = DEAD_DYING;
ADDRGP4 self
INDIRP4
CNSTI4 348
ADDP4
CNSTF4 1065353216
ASGNF4
line 1849
;1849:	self->s.v.solid = SOLID_NOT;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 1850
;1850:	self->s.v.flags = ( int ) self->s.v.flags - ( ( int ) self->s.v.flags & 512 );
ADDRLP4 28
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRI4
ADDRLP4 32
INDIRI4
CNSTI4 512
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 1851
;1851:	self->s.v.movetype = MOVETYPE_TOSS;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 1852
;1852:	if ( self->s.v.velocity[2] < 10 )
ADDRGP4 self
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
CNSTF4 1092616192
GEF4 $597
line 1853
;1853:		self->s.v.velocity[2] = self->s.v.velocity[2] + g_random(  ) * 300;
ADDRLP4 36
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 40
ADDRGP4 self
INDIRP4
CNSTI4 188
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
CNSTF4 1133903872
ADDRLP4 36
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $597
line 1854
;1854:	if ( self->s.v.health < -40 )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 3256877056
GEF4 $599
line 1855
;1855:	{
line 1856
;1856:		GibPlayer(  );
ADDRGP4 GibPlayer
CALLV
pop
line 1857
;1857:		return;
ADDRGP4 $575
JUMPV
LABELV $599
line 1859
;1858:	}
;1859:	DeathSound(  );
ADDRGP4 DeathSound
CALLV
pop
line 1860
;1860:	self->s.v.angles[0] = 0;
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 0
ASGNF4
line 1861
;1861:	self->s.v.angles[2] = 0;
ADDRGP4 self
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 0
ASGNF4
line 1862
;1862:	if ( self->current_weapon <= 16 )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 16
GTI4 $601
line 1863
;1863:	{
line 1864
;1864:		player_die_ax1(  );
ADDRGP4 player_die_ax1
CALLV
pop
line 1865
;1865:		TeamFortress_SetupRespawn( 0 );
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_SetupRespawn
CALLV
pop
line 1866
;1866:		return;
ADDRGP4 $575
JUMPV
LABELV $601
line 1869
;1867:	}
;1868:	//i = 1 + (int)( g_random(  ) * 6 );
;1869:	switch((int)( g_random(  ) * 5 ))
ADDRLP4 48
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 44
CNSTF4 1084227584
ADDRLP4 48
INDIRF4
MULF4
CVFI4 4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
LTI4 $603
ADDRLP4 44
INDIRI4
CNSTI4 3
GTI4 $603
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $610
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $610
address $606
address $607
address $608
address $609
code
line 1870
;1870:	{
LABELV $606
line 1872
;1871:		case 0:
;1872:			player_diea1(  );
ADDRGP4 player_diea1
CALLV
pop
line 1873
;1873:			break;
ADDRGP4 $604
JUMPV
LABELV $607
line 1875
;1874:		case 1:
;1875:			player_dieb1(  );
ADDRGP4 player_dieb1
CALLV
pop
line 1876
;1876:			break;
ADDRGP4 $604
JUMPV
LABELV $608
line 1878
;1877:		case 2:
;1878:			player_diec1(  );
ADDRGP4 player_diec1
CALLV
pop
line 1879
;1879:			break;
ADDRGP4 $604
JUMPV
LABELV $609
line 1881
;1880:		case 3:
;1881:			player_died1(  );
ADDRGP4 player_died1
CALLV
pop
line 1882
;1882:			break;
ADDRGP4 $604
JUMPV
LABELV $603
line 1884
;1883:		default:
;1884:			player_diee1(  );
ADDRGP4 player_diee1
CALLV
pop
line 1885
;1885:			break;
LABELV $604
line 1889
;1886:	
;1887:	}
;1888:
;1889:	TeamFortress_SetupRespawn( 0 );
CNSTI4 0
ARGI4
ADDRGP4 TeamFortress_SetupRespawn
CALLV
pop
line 1890
;1890:}
LABELV $575
endproc PlayerDie 56 12
export set_suicide_frame
proc set_suicide_frame 12 28
line 1893
;1891:
;1892:void set_suicide_frame(  )
;1893:{
line 1894
;1894:	if ( strneq( self->s.v.model, "progs/player.mdl" ) )
ADDRGP4 self
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ARGP4
ADDRGP4 $614
ARGP4
ADDRLP4 0
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $612
line 1895
;1895:		return;
ADDRGP4 $611
JUMPV
LABELV $612
line 1896
;1896:	setmodel( self, "" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $429
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1897
;1897:	setsize( self, -16, -16, -24, 16, 16, 32 );
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
CNSTF4 3250585600
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
CNSTF4 1107296256
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1898
;1898:}
LABELV $611
endproc set_suicide_frame 12 28
export player_diea1
proc player_diea1 0 0
line 1901
;1899:
;1900:void player_diea1(  )
;1901:{
line 1902
;1902:	self->s.v.frame = 50;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1112014848
ASGNF4
line 1903
;1903:	self->s.v.think = ( func_t ) player_diea2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diea2
CVPU4 4
CVUI4 4
ASGNI4
line 1904
;1904:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1906
;1905:
;1906:}
LABELV $615
endproc player_diea1 0 0
export player_diea2
proc player_diea2 0 0
line 1909
;1907:
;1908:void player_diea2(  )
;1909:{
line 1910
;1910:	self->s.v.frame = 51;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1112276992
ASGNF4
line 1911
;1911:	self->s.v.think = ( func_t ) player_diea3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diea3
CVPU4 4
CVUI4 4
ASGNI4
line 1912
;1912:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1914
;1913:
;1914:}
LABELV $617
endproc player_diea2 0 0
export player_diea3
proc player_diea3 0 0
line 1917
;1915:
;1916:void player_diea3(  )
;1917:{
line 1918
;1918:	self->s.v.frame = 52;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1112539136
ASGNF4
line 1919
;1919:	self->s.v.think = ( func_t ) player_diea4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diea4
CVPU4 4
CVUI4 4
ASGNI4
line 1920
;1920:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1922
;1921:
;1922:}
LABELV $619
endproc player_diea3 0 0
export player_diea4
proc player_diea4 0 0
line 1925
;1923:
;1924:void player_diea4(  )
;1925:{
line 1926
;1926:	self->s.v.frame = 53;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1112801280
ASGNF4
line 1927
;1927:	self->s.v.think = ( func_t ) player_diea5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diea5
CVPU4 4
CVUI4 4
ASGNI4
line 1928
;1928:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1930
;1929:
;1930:}
LABELV $621
endproc player_diea4 0 0
export player_diea5
proc player_diea5 0 0
line 1933
;1931:
;1932:void player_diea5(  )
;1933:{
line 1934
;1934:	self->s.v.frame = 54;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1113063424
ASGNF4
line 1935
;1935:	self->s.v.think = ( func_t ) player_diea6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diea6
CVPU4 4
CVUI4 4
ASGNI4
line 1936
;1936:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1938
;1937:
;1938:}
LABELV $623
endproc player_diea5 0 0
export player_diea6
proc player_diea6 0 0
line 1941
;1939:
;1940:void player_diea6(  )
;1941:{
line 1942
;1942:	self->s.v.frame = 55;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1113325568
ASGNF4
line 1943
;1943:	self->s.v.think = ( func_t ) player_diea7;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diea7
CVPU4 4
CVUI4 4
ASGNI4
line 1944
;1944:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1946
;1945:
;1946:}
LABELV $625
endproc player_diea6 0 0
export player_diea7
proc player_diea7 0 0
line 1949
;1947:
;1948:void player_diea7(  )
;1949:{
line 1950
;1950:	self->s.v.frame = 56;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1113587712
ASGNF4
line 1951
;1951:	self->s.v.think = ( func_t ) player_diea8;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diea8
CVPU4 4
CVUI4 4
ASGNI4
line 1952
;1952:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1954
;1953:
;1954:}
LABELV $627
endproc player_diea7 0 0
export player_diea8
proc player_diea8 0 0
line 1957
;1955:
;1956:void player_diea8(  )
;1957:{
line 1958
;1958:	self->s.v.frame = 57;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1113849856
ASGNF4
line 1959
;1959:	self->s.v.think = ( func_t ) player_diea9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diea9
CVPU4 4
CVUI4 4
ASGNI4
line 1960
;1960:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1962
;1961:
;1962:}
LABELV $629
endproc player_diea8 0 0
export player_diea9
proc player_diea9 0 0
line 1965
;1963:
;1964:void player_diea9(  )
;1965:{
line 1966
;1966:	self->s.v.frame = 58;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1114112000
ASGNF4
line 1967
;1967:	self->s.v.think = ( func_t ) player_diea10;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diea10
CVPU4 4
CVUI4 4
ASGNI4
line 1968
;1968:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1970
;1969:
;1970:}
LABELV $631
endproc player_diea9 0 0
export player_diea10
proc player_diea10 0 0
line 1973
;1971:
;1972:void player_diea10(  )
;1973:{
line 1974
;1974:	self->s.v.frame = 59;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1114374144
ASGNF4
line 1975
;1975:	self->s.v.think = ( func_t ) player_diea11;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diea11
CVPU4 4
CVUI4 4
ASGNI4
line 1976
;1976:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1978
;1977:
;1978:}
LABELV $633
endproc player_diea10 0 0
export player_diea11
proc player_diea11 0 0
line 1981
;1979:
;1980:void player_diea11(  )
;1981:{
line 1982
;1982:	self->s.v.frame = 60;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1114636288
ASGNF4
line 1983
;1983:	self->s.v.think = ( func_t ) player_diea11;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diea11
CVPU4 4
CVUI4 4
ASGNI4
line 1984
;1984:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1986
;1985:
;1986:	PlayerDead(  );
ADDRGP4 PlayerDead
CALLV
pop
line 1987
;1987:}
LABELV $635
endproc player_diea11 0 0
export player_dieb1
proc player_dieb1 0 0
line 1990
;1988:
;1989:void player_dieb1(  )
;1990:{
line 1991
;1991:	self->s.v.frame = 61;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1114898432
ASGNF4
line 1992
;1992:	self->s.v.think = ( func_t ) player_dieb2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_dieb2
CVPU4 4
CVUI4 4
ASGNI4
line 1993
;1993:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1995
;1994:
;1995:}
LABELV $637
endproc player_dieb1 0 0
export player_dieb2
proc player_dieb2 0 0
line 1998
;1996:
;1997:void player_dieb2(  )
;1998:{
line 1999
;1999:	self->s.v.frame = 62;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1115160576
ASGNF4
line 2000
;2000:	self->s.v.think = ( func_t ) player_dieb3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_dieb3
CVPU4 4
CVUI4 4
ASGNI4
line 2001
;2001:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2003
;2002:
;2003:}
LABELV $639
endproc player_dieb2 0 0
export player_dieb3
proc player_dieb3 0 0
line 2006
;2004:
;2005:void player_dieb3(  )
;2006:{
line 2007
;2007:	self->s.v.frame = 63;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1115422720
ASGNF4
line 2008
;2008:	self->s.v.think = ( func_t ) player_dieb4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_dieb4
CVPU4 4
CVUI4 4
ASGNI4
line 2009
;2009:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2011
;2010:
;2011:}
LABELV $641
endproc player_dieb3 0 0
export player_dieb4
proc player_dieb4 0 0
line 2014
;2012:
;2013:void player_dieb4(  )
;2014:{
line 2015
;2015:	self->s.v.frame = 64;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1115684864
ASGNF4
line 2016
;2016:	self->s.v.think = ( func_t ) player_dieb5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_dieb5
CVPU4 4
CVUI4 4
ASGNI4
line 2017
;2017:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2019
;2018:
;2019:}
LABELV $643
endproc player_dieb4 0 0
export player_dieb5
proc player_dieb5 0 0
line 2022
;2020:
;2021:void player_dieb5(  )
;2022:{
line 2023
;2023:	self->s.v.frame = 65;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1115815936
ASGNF4
line 2024
;2024:	self->s.v.think = ( func_t ) player_dieb6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_dieb6
CVPU4 4
CVUI4 4
ASGNI4
line 2025
;2025:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2027
;2026:
;2027:}
LABELV $645
endproc player_dieb5 0 0
export player_dieb6
proc player_dieb6 0 0
line 2030
;2028:
;2029:void player_dieb6(  )
;2030:{
line 2031
;2031:	self->s.v.frame = 66;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1115947008
ASGNF4
line 2032
;2032:	self->s.v.think = ( func_t ) player_dieb7;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_dieb7
CVPU4 4
CVUI4 4
ASGNI4
line 2033
;2033:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2035
;2034:
;2035:}
LABELV $647
endproc player_dieb6 0 0
export player_dieb7
proc player_dieb7 0 0
line 2038
;2036:
;2037:void player_dieb7(  )
;2038:{
line 2039
;2039:	self->s.v.frame = 67;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116078080
ASGNF4
line 2040
;2040:	self->s.v.think = ( func_t ) player_dieb8;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_dieb8
CVPU4 4
CVUI4 4
ASGNI4
line 2041
;2041:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2043
;2042:
;2043:}
LABELV $649
endproc player_dieb7 0 0
export player_dieb8
proc player_dieb8 0 0
line 2046
;2044:
;2045:void player_dieb8(  )
;2046:{
line 2047
;2047:	self->s.v.frame = 68;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116209152
ASGNF4
line 2048
;2048:	self->s.v.think = ( func_t ) player_dieb9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_dieb9
CVPU4 4
CVUI4 4
ASGNI4
line 2049
;2049:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2051
;2050:
;2051:}
LABELV $651
endproc player_dieb8 0 0
export player_dieb9
proc player_dieb9 0 0
line 2054
;2052:
;2053:void player_dieb9(  )
;2054:{
line 2055
;2055:	self->s.v.frame = 69;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116340224
ASGNF4
line 2056
;2056:	self->s.v.think = ( func_t ) player_dieb9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_dieb9
CVPU4 4
CVUI4 4
ASGNI4
line 2057
;2057:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2059
;2058:
;2059:	PlayerDead(  );
ADDRGP4 PlayerDead
CALLV
pop
line 2060
;2060:}
LABELV $653
endproc player_dieb9 0 0
export player_diec1
proc player_diec1 0 0
line 2063
;2061:
;2062:void player_diec1(  )
;2063:{
line 2064
;2064:	self->s.v.frame = 70;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116471296
ASGNF4
line 2065
;2065:	self->s.v.think = ( func_t ) player_diec2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diec2
CVPU4 4
CVUI4 4
ASGNI4
line 2066
;2066:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2068
;2067:
;2068:}
LABELV $655
endproc player_diec1 0 0
export player_diec2
proc player_diec2 0 0
line 2071
;2069:
;2070:void player_diec2(  )
;2071:{
line 2072
;2072:	self->s.v.frame = 71;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116602368
ASGNF4
line 2073
;2073:	self->s.v.think = ( func_t ) player_diec3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diec3
CVPU4 4
CVUI4 4
ASGNI4
line 2074
;2074:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2076
;2075:
;2076:}
LABELV $657
endproc player_diec2 0 0
export player_diec3
proc player_diec3 0 0
line 2079
;2077:
;2078:void player_diec3(  )
;2079:{
line 2080
;2080:	self->s.v.frame = 72;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116733440
ASGNF4
line 2081
;2081:	self->s.v.think = ( func_t ) player_diec4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diec4
CVPU4 4
CVUI4 4
ASGNI4
line 2082
;2082:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2084
;2083:
;2084:}
LABELV $659
endproc player_diec3 0 0
export player_diec4
proc player_diec4 0 0
line 2087
;2085:
;2086:void player_diec4(  )
;2087:{
line 2088
;2088:	self->s.v.frame = 73;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116864512
ASGNF4
line 2089
;2089:	self->s.v.think = ( func_t ) player_diec5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diec5
CVPU4 4
CVUI4 4
ASGNI4
line 2090
;2090:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2092
;2091:
;2092:}
LABELV $661
endproc player_diec4 0 0
export player_diec5
proc player_diec5 0 0
line 2095
;2093:
;2094:void player_diec5(  )
;2095:{
line 2096
;2096:	self->s.v.frame = 74;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1116995584
ASGNF4
line 2097
;2097:	self->s.v.think = ( func_t ) player_diec6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diec6
CVPU4 4
CVUI4 4
ASGNI4
line 2098
;2098:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2100
;2099:
;2100:}
LABELV $663
endproc player_diec5 0 0
export player_diec6
proc player_diec6 0 0
line 2103
;2101:
;2102:void player_diec6(  )
;2103:{
line 2104
;2104:	self->s.v.frame = 75;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117126656
ASGNF4
line 2105
;2105:	self->s.v.think = ( func_t ) player_diec7;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diec7
CVPU4 4
CVUI4 4
ASGNI4
line 2106
;2106:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2108
;2107:
;2108:}
LABELV $665
endproc player_diec6 0 0
export player_diec7
proc player_diec7 0 0
line 2111
;2109:
;2110:void player_diec7(  )
;2111:{
line 2112
;2112:	self->s.v.frame = 76;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117257728
ASGNF4
line 2113
;2113:	self->s.v.think = ( func_t ) player_diec8;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diec8
CVPU4 4
CVUI4 4
ASGNI4
line 2114
;2114:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2116
;2115:
;2116:}
LABELV $667
endproc player_diec7 0 0
export player_diec8
proc player_diec8 0 0
line 2119
;2117:
;2118:void player_diec8(  )
;2119:{
line 2120
;2120:	self->s.v.frame = 77;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117388800
ASGNF4
line 2121
;2121:	self->s.v.think = ( func_t ) player_diec9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diec9
CVPU4 4
CVUI4 4
ASGNI4
line 2122
;2122:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2124
;2123:
;2124:}
LABELV $669
endproc player_diec8 0 0
export player_diec9
proc player_diec9 0 0
line 2127
;2125:
;2126:void player_diec9(  )
;2127:{
line 2128
;2128:	self->s.v.frame = 78;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117519872
ASGNF4
line 2129
;2129:	self->s.v.think = ( func_t ) player_diec10;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diec10
CVPU4 4
CVUI4 4
ASGNI4
line 2130
;2130:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2132
;2131:
;2132:}
LABELV $671
endproc player_diec9 0 0
export player_diec10
proc player_diec10 0 0
line 2135
;2133:
;2134:void player_diec10(  )
;2135:{
line 2136
;2136:	self->s.v.frame = 79;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117650944
ASGNF4
line 2137
;2137:	self->s.v.think = ( func_t ) player_diec11;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diec11
CVPU4 4
CVUI4 4
ASGNI4
line 2138
;2138:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2140
;2139:
;2140:}
LABELV $673
endproc player_diec10 0 0
export player_diec11
proc player_diec11 0 0
line 2143
;2141:
;2142:void player_diec11(  )
;2143:{
line 2144
;2144:	self->s.v.frame = 80;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117782016
ASGNF4
line 2145
;2145:	self->s.v.think = ( func_t ) player_diec12;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diec12
CVPU4 4
CVUI4 4
ASGNI4
line 2146
;2146:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2148
;2147:
;2148:}
LABELV $675
endproc player_diec11 0 0
export player_diec12
proc player_diec12 0 0
line 2151
;2149:
;2150:void player_diec12(  )
;2151:{
line 2152
;2152:	self->s.v.frame = 81;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1117913088
ASGNF4
line 2153
;2153:	self->s.v.think = ( func_t ) player_diec13;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diec13
CVPU4 4
CVUI4 4
ASGNI4
line 2154
;2154:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2156
;2155:
;2156:}
LABELV $677
endproc player_diec12 0 0
export player_diec13
proc player_diec13 0 0
line 2159
;2157:
;2158:void player_diec13(  )
;2159:{
line 2160
;2160:	self->s.v.frame = 82;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118044160
ASGNF4
line 2161
;2161:	self->s.v.think = ( func_t ) player_diec14;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diec14
CVPU4 4
CVUI4 4
ASGNI4
line 2162
;2162:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2164
;2163:
;2164:}
LABELV $679
endproc player_diec13 0 0
export player_diec14
proc player_diec14 0 0
line 2167
;2165:
;2166:void player_diec14(  )
;2167:{
line 2168
;2168:	self->s.v.frame = 83;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118175232
ASGNF4
line 2169
;2169:	self->s.v.think = ( func_t ) player_diec15;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diec15
CVPU4 4
CVUI4 4
ASGNI4
line 2170
;2170:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2172
;2171:
;2172:}
LABELV $681
endproc player_diec14 0 0
export player_diec15
proc player_diec15 0 0
line 2175
;2173:
;2174:void player_diec15(  )
;2175:{
line 2176
;2176:	self->s.v.frame = 84;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118306304
ASGNF4
line 2177
;2177:	self->s.v.think = ( func_t ) player_diec15;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diec15
CVPU4 4
CVUI4 4
ASGNI4
line 2178
;2178:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2180
;2179:
;2180:	PlayerDead(  );
ADDRGP4 PlayerDead
CALLV
pop
line 2181
;2181:}
LABELV $683
endproc player_diec15 0 0
export player_died1
proc player_died1 0 0
line 2184
;2182:
;2183:void player_died1(  )
;2184:{
line 2185
;2185:	self->s.v.frame = 85;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118437376
ASGNF4
line 2186
;2186:	self->s.v.think = ( func_t ) player_died2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_died2
CVPU4 4
CVUI4 4
ASGNI4
line 2187
;2187:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2189
;2188:
;2189:}
LABELV $685
endproc player_died1 0 0
export player_died2
proc player_died2 0 0
line 2192
;2190:
;2191:void player_died2(  )
;2192:{
line 2193
;2193:	self->s.v.frame = 86;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118568448
ASGNF4
line 2194
;2194:	self->s.v.think = ( func_t ) player_died3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_died3
CVPU4 4
CVUI4 4
ASGNI4
line 2195
;2195:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2197
;2196:
;2197:}
LABELV $687
endproc player_died2 0 0
export player_died3
proc player_died3 0 0
line 2200
;2198:
;2199:void player_died3(  )
;2200:{
line 2201
;2201:	self->s.v.frame = 87;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118699520
ASGNF4
line 2202
;2202:	self->s.v.think = ( func_t ) player_died4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_died4
CVPU4 4
CVUI4 4
ASGNI4
line 2203
;2203:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2205
;2204:
;2205:}
LABELV $689
endproc player_died3 0 0
export player_died4
proc player_died4 0 0
line 2208
;2206:
;2207:void player_died4(  )
;2208:{
line 2209
;2209:	self->s.v.frame = 88;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118830592
ASGNF4
line 2210
;2210:	self->s.v.think = ( func_t ) player_died5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_died5
CVPU4 4
CVUI4 4
ASGNI4
line 2211
;2211:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2213
;2212:
;2213:}
LABELV $691
endproc player_died4 0 0
export player_died5
proc player_died5 0 0
line 2216
;2214:
;2215:void player_died5(  )
;2216:{
line 2217
;2217:	self->s.v.frame = 89;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1118961664
ASGNF4
line 2218
;2218:	self->s.v.think = ( func_t ) player_died6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_died6
CVPU4 4
CVUI4 4
ASGNI4
line 2219
;2219:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2221
;2220:
;2221:}
LABELV $693
endproc player_died5 0 0
export player_died6
proc player_died6 0 0
line 2224
;2222:
;2223:void player_died6(  )
;2224:{
line 2225
;2225:	self->s.v.frame = 90;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119092736
ASGNF4
line 2226
;2226:	self->s.v.think = ( func_t ) player_died7;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_died7
CVPU4 4
CVUI4 4
ASGNI4
line 2227
;2227:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2229
;2228:
;2229:}
LABELV $695
endproc player_died6 0 0
export player_died7
proc player_died7 0 0
line 2232
;2230:
;2231:void player_died7(  )
;2232:{
line 2233
;2233:	self->s.v.frame = 91;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119223808
ASGNF4
line 2234
;2234:	self->s.v.think = ( func_t ) player_died8;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_died8
CVPU4 4
CVUI4 4
ASGNI4
line 2235
;2235:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2237
;2236:
;2237:}
LABELV $697
endproc player_died7 0 0
export player_died8
proc player_died8 0 0
line 2240
;2238:
;2239:void player_died8(  )
;2240:{
line 2241
;2241:	self->s.v.frame = 92;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119354880
ASGNF4
line 2242
;2242:	self->s.v.think = ( func_t ) player_died9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_died9
CVPU4 4
CVUI4 4
ASGNI4
line 2243
;2243:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2245
;2244:
;2245:}
LABELV $699
endproc player_died8 0 0
export player_died9
proc player_died9 0 0
line 2248
;2246:
;2247:void player_died9(  )
;2248:{
line 2249
;2249:	self->s.v.frame = 93;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119485952
ASGNF4
line 2250
;2250:	self->s.v.think = ( func_t ) player_died9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_died9
CVPU4 4
CVUI4 4
ASGNI4
line 2251
;2251:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2253
;2252:
;2253:	PlayerDead(  );
ADDRGP4 PlayerDead
CALLV
pop
line 2254
;2254:}
LABELV $701
endproc player_died9 0 0
export player_diee1
proc player_diee1 0 0
line 2257
;2255:
;2256:void player_diee1(  )
;2257:{
line 2258
;2258:	self->s.v.frame = 94;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119617024
ASGNF4
line 2259
;2259:	self->s.v.think = ( func_t ) player_diee2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diee2
CVPU4 4
CVUI4 4
ASGNI4
line 2260
;2260:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2262
;2261:
;2262:}
LABELV $703
endproc player_diee1 0 0
export player_diee2
proc player_diee2 0 0
line 2265
;2263:
;2264:void player_diee2(  )
;2265:{
line 2266
;2266:	self->s.v.frame = 95;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119748096
ASGNF4
line 2267
;2267:	self->s.v.think = ( func_t ) player_diee3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diee3
CVPU4 4
CVUI4 4
ASGNI4
line 2268
;2268:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2270
;2269:
;2270:}
LABELV $705
endproc player_diee2 0 0
export player_diee3
proc player_diee3 0 0
line 2273
;2271:
;2272:void player_diee3(  )
;2273:{
line 2274
;2274:	self->s.v.frame = 96;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1119879168
ASGNF4
line 2275
;2275:	self->s.v.think = ( func_t ) player_diee4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diee4
CVPU4 4
CVUI4 4
ASGNI4
line 2276
;2276:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2278
;2277:
;2278:}
LABELV $707
endproc player_diee3 0 0
export player_diee4
proc player_diee4 0 0
line 2281
;2279:
;2280:void player_diee4(  )
;2281:{
line 2282
;2282:	self->s.v.frame = 97;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120010240
ASGNF4
line 2283
;2283:	self->s.v.think = ( func_t ) player_diee5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diee5
CVPU4 4
CVUI4 4
ASGNI4
line 2284
;2284:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2286
;2285:
;2286:}
LABELV $709
endproc player_diee4 0 0
export player_diee5
proc player_diee5 0 0
line 2289
;2287:
;2288:void player_diee5(  )
;2289:{
line 2290
;2290:	self->s.v.frame = 98;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120141312
ASGNF4
line 2291
;2291:	self->s.v.think = ( func_t ) player_diee6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diee6
CVPU4 4
CVUI4 4
ASGNI4
line 2292
;2292:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2294
;2293:
;2294:}
LABELV $711
endproc player_diee5 0 0
export player_diee6
proc player_diee6 0 0
line 2297
;2295:
;2296:void player_diee6(  )
;2297:{
line 2298
;2298:	self->s.v.frame = 99;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120272384
ASGNF4
line 2299
;2299:	self->s.v.think = ( func_t ) player_diee7;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diee7
CVPU4 4
CVUI4 4
ASGNI4
line 2300
;2300:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2302
;2301:
;2302:}
LABELV $713
endproc player_diee6 0 0
export player_diee7
proc player_diee7 0 0
line 2305
;2303:
;2304:void player_diee7(  )
;2305:{
line 2306
;2306:	self->s.v.frame = 100;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120403456
ASGNF4
line 2307
;2307:	self->s.v.think = ( func_t ) player_diee8;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diee8
CVPU4 4
CVUI4 4
ASGNI4
line 2308
;2308:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2310
;2309:
;2310:}
LABELV $715
endproc player_diee7 0 0
export player_diee8
proc player_diee8 0 0
line 2313
;2311:
;2312:void player_diee8(  )
;2313:{
line 2314
;2314:	self->s.v.frame = 101;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120534528
ASGNF4
line 2315
;2315:	self->s.v.think = ( func_t ) player_diee9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diee9
CVPU4 4
CVUI4 4
ASGNI4
line 2316
;2316:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2318
;2317:
;2318:}
LABELV $717
endproc player_diee8 0 0
export player_diee9
proc player_diee9 0 0
line 2321
;2319:
;2320:void player_diee9(  )
;2321:{
line 2322
;2322:	self->s.v.frame = 102;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1120665600
ASGNF4
line 2323
;2323:	self->s.v.think = ( func_t ) player_diee9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_diee9
CVPU4 4
CVUI4 4
ASGNI4
line 2324
;2324:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2326
;2325:
;2326:	PlayerDead(  );
ADDRGP4 PlayerDead
CALLV
pop
line 2327
;2327:}
LABELV $719
endproc player_diee9 0 0
export player_die_ax1
proc player_die_ax1 0 0
line 2330
;2328:
;2329:void player_die_ax1(  )
;2330:{
line 2331
;2331:	self->s.v.frame = 41;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1109655552
ASGNF4
line 2332
;2332:	self->s.v.think = ( func_t ) player_die_ax2;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_die_ax2
CVPU4 4
CVUI4 4
ASGNI4
line 2333
;2333:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2335
;2334:
;2335:}
LABELV $721
endproc player_die_ax1 0 0
export player_die_ax2
proc player_die_ax2 0 0
line 2338
;2336:
;2337:void player_die_ax2(  )
;2338:{
line 2339
;2339:	self->s.v.frame = 42;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1109917696
ASGNF4
line 2340
;2340:	self->s.v.think = ( func_t ) player_die_ax3;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_die_ax3
CVPU4 4
CVUI4 4
ASGNI4
line 2341
;2341:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2343
;2342:
;2343:}
LABELV $723
endproc player_die_ax2 0 0
export player_die_ax3
proc player_die_ax3 0 0
line 2346
;2344:
;2345:void player_die_ax3(  )
;2346:{
line 2347
;2347:	self->s.v.frame = 43;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1110179840
ASGNF4
line 2348
;2348:	self->s.v.think = ( func_t ) player_die_ax4;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_die_ax4
CVPU4 4
CVUI4 4
ASGNI4
line 2349
;2349:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2351
;2350:
;2351:}
LABELV $725
endproc player_die_ax3 0 0
export player_die_ax4
proc player_die_ax4 0 0
line 2354
;2352:
;2353:void player_die_ax4(  )
;2354:{
line 2355
;2355:	self->s.v.frame = 44;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1110441984
ASGNF4
line 2356
;2356:	self->s.v.think = ( func_t ) player_die_ax5;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_die_ax5
CVPU4 4
CVUI4 4
ASGNI4
line 2357
;2357:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2359
;2358:
;2359:}
LABELV $727
endproc player_die_ax4 0 0
export player_die_ax5
proc player_die_ax5 0 0
line 2362
;2360:
;2361:void player_die_ax5(  )
;2362:{
line 2363
;2363:	self->s.v.frame = 45;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1110704128
ASGNF4
line 2364
;2364:	self->s.v.think = ( func_t ) player_die_ax6;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_die_ax6
CVPU4 4
CVUI4 4
ASGNI4
line 2365
;2365:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2367
;2366:
;2367:}
LABELV $729
endproc player_die_ax5 0 0
export player_die_ax6
proc player_die_ax6 0 0
line 2370
;2368:
;2369:void player_die_ax6(  )
;2370:{
line 2371
;2371:	self->s.v.frame = 46;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1110966272
ASGNF4
line 2372
;2372:	self->s.v.think = ( func_t ) player_die_ax7;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_die_ax7
CVPU4 4
CVUI4 4
ASGNI4
line 2373
;2373:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2375
;2374:
;2375:}
LABELV $731
endproc player_die_ax6 0 0
export player_die_ax7
proc player_die_ax7 0 0
line 2378
;2376:
;2377:void player_die_ax7(  )
;2378:{
line 2379
;2379:	self->s.v.frame = 47;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1111228416
ASGNF4
line 2380
;2380:	self->s.v.think = ( func_t ) player_die_ax8;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_die_ax8
CVPU4 4
CVUI4 4
ASGNI4
line 2381
;2381:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2383
;2382:
;2383:}
LABELV $733
endproc player_die_ax7 0 0
export player_die_ax8
proc player_die_ax8 0 0
line 2386
;2384:
;2385:void player_die_ax8(  )
;2386:{
line 2387
;2387:	self->s.v.frame = 48;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1111490560
ASGNF4
line 2388
;2388:	self->s.v.think = ( func_t ) player_die_ax9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_die_ax9
CVPU4 4
CVUI4 4
ASGNI4
line 2389
;2389:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2391
;2390:
;2391:}
LABELV $735
endproc player_die_ax8 0 0
export player_die_ax9
proc player_die_ax9 0 0
line 2394
;2392:
;2393:void player_die_ax9(  )
;2394:{
line 2395
;2395:	self->s.v.frame = 49;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1111752704
ASGNF4
line 2396
;2396:	self->s.v.think = ( func_t ) player_die_ax9;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 player_die_ax9
CVPU4 4
CVUI4 4
ASGNI4
line 2397
;2397:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2399
;2398:
;2399:	PlayerDead(  );
ADDRGP4 PlayerDead
CALLV
pop
line 2400
;2400:}
LABELV $737
endproc player_die_ax9 0 0
export Headless_Think
proc Headless_Think 16 0
line 2403
;2401:
;2402:void Headless_Think(  )
;2403:{
line 2404
;2404:	self->s.v.frame = self->s.v.frame + 1;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 224
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
line 2405
;2405:	if ( self->s.v.frame == 7 || self->s.v.frame == 18 )
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 1088421888
EQF4 $742
ADDRLP4 4
INDIRF4
CNSTF4 1099956224
NEF4 $740
LABELV $742
line 2406
;2406:	{
line 2407
;2407:		self->s.v.nextthink = g_globalvars.time + 10 + g_random(  ) * 10;
ADDRLP4 8
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 12
CNSTF4 1092616192
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2408
;2408:		self->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 2409
;2409:		return;
ADDRGP4 $739
JUMPV
LABELV $740
line 2411
;2410:	}
;2411:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 2412
;2412:}
LABELV $739
endproc Headless_Think 16 0
import W_FireMTFSpikes
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
LABELV $614
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
LABELV $582
byte 1 112
byte 1 114
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $574
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $571
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
LABELV $562
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
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
LABELV $561
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
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
LABELV $560
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
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
LABELV $556
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 108
byte 1 101
byte 1 115
byte 1 115
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $554
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 104
byte 1 95
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
LABELV $537
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 51
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $526
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 109
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 53
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $523
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 52
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $520
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $517
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $514
byte 1 112
byte 1 108
byte 1 97
byte 1 121
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
LABELV $511
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 104
byte 1 50
byte 1 111
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $500
byte 1 98
byte 1 117
byte 1 98
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $490
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
LABELV $445
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 109
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
LABELV $441
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
byte 1 51
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
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $432
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
LABELV $429
byte 1 0
align 1
LABELV $428
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 97
byte 1 120
byte 1 104
byte 1 105
byte 1 116
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $417
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 108
byte 1 98
byte 1 117
byte 1 114
byte 1 110
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $416
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 108
byte 1 98
byte 1 117
byte 1 114
byte 1 110
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $411
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 100
byte 1 114
byte 1 111
byte 1 119
byte 1 110
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $410
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 100
byte 1 114
byte 1 111
byte 1 119
byte 1 110
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $405
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $404
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
LABELV $363
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 110
byte 1 103
byte 1 110
byte 1 100
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $340
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
byte 1 0
align 1
LABELV $317
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 110
byte 1 103
byte 1 110
byte 1 117
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $130
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 50
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $129
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 49
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $122
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 105
byte 1 110
byte 1 104
byte 1 50
byte 1 111
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $119
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 104
byte 1 50
byte 1 111
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $116
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 50
byte 1 108
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $115
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 49
byte 1 108
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $82
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 236
byte 1 225
byte 1 249
byte 1 233
byte 1 238
byte 1 231
byte 1 10
byte 1 0
align 1
LABELV $60
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $59
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $58
byte 1 42
byte 1 42
byte 1 42
byte 1 66
byte 1 85
byte 1 71
byte 1 32
byte 1 84
byte 1 70
byte 1 83
byte 1 84
byte 1 65
byte 1 84
byte 1 69
byte 1 95
byte 1 73
byte 1 78
byte 1 70
byte 1 69
byte 1 67
byte 1 84
byte 1 69
byte 1 68
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 66
byte 1 105
byte 1 111
byte 1 73
byte 1 110
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 95
byte 1 68
byte 1 101
byte 1 99
byte 1 97
byte 1 121
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 32
byte 1 42
byte 1 42
byte 1 42
byte 1 10
byte 1 0
align 1
LABELV $49
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $25
byte 1 37
byte 1 115
byte 1 32
byte 1 117
byte 1 110
byte 1 99
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 115
byte 1 112
byte 1 121
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $18
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
