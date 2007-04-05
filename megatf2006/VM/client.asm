data
export VEC_ORIGIN
align 4
LABELV VEC_ORIGIN
byte 4 0
byte 4 0
byte 4 0
export VEC_HULL_MIN
align 4
LABELV VEC_HULL_MIN
byte 4 3246391296
byte 4 3246391296
byte 4 3250585600
export VEC_HULL_MAX
align 4
LABELV VEC_HULL_MAX
byte 4 1098907648
byte 4 1098907648
byte 4 1107296256
export VEC_HULL2_MIN
align 4
LABELV VEC_HULL2_MIN
byte 4 3254779904
byte 4 3254779904
byte 4 3250585600
export VEC_HULL2_MAX
align 4
LABELV VEC_HULL2_MAX
byte 4 1107296256
byte 4 1107296256
byte 4 1115684864
export intermission_running
align 4
LABELV intermission_running
byte 4 0
export intermission_exittime
align 4
LABELV intermission_exittime
byte 4 0
export nextmap
align 1
LABELV nextmap
byte 1 0
skip 63
export SP_info_intermission
code
proc SP_info_intermission 16 4
file "..\src\client.c"
line 56
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
;21: *  $Id: client.c,v 1.57 2006/03/04 15:10:06 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25://===========================================================================
;26:// Client
;27:// 
;28://===========================================================================
;29:
;30:const vec3_t  VEC_ORIGIN = { 0, 0, 0 };
;31:const vec3_t  VEC_HULL_MIN = { -16, -16, -24 };
;32:const vec3_t  VEC_HULL_MAX = { 16, 16, 32 };
;33:
;34:const vec3_t  VEC_HULL2_MIN = { -32, -32, -24 };
;35:const vec3_t  VEC_HULL2_MAX = { 32, 32, 64 };
;36:int     modelindex_eyes, modelindex_player, modelindex_null;
;37:int     last_id;
;38:float   rj;
;39:
;40:/*
;41:=============================================================================
;42:
;43:    LEVEL CHANGING / INTERMISSION
;44:
;45:=============================================================================
;46:*/
;47:float   intermission_running = 0;
;48:float   intermission_exittime = 0;
;49:char    nextmap[64] = "";
;50:
;51:/*QUAKED info_intermission (1 0.5 0.5) (-16 -16 -16) (16 16 16)
;52:This is the camera point for the intermission.
;53:Use mangle instead of angle, so you can set pitch or roll as well as yaw.  'pitch roll yaw'
;54:*/
;55:void SP_info_intermission()
;56:{
line 57
;57:	if ( !CheckExistence() )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $12
line 58
;58:	{
line 59
;59:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 60
;60:		return;
ADDRGP4 $11
JUMPV
LABELV $12
line 63
;61:	}
;62:// so C can get at it
;63:	VectorCopy( self->mangle, self->s.v.angles );	//self.angles = self.mangle;      
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 636
ADDP4
INDIRF4
ASGNF4
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 640
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 644
ADDP4
INDIRF4
ASGNF4
line 64
;64:}
LABELV $11
endproc SP_info_intermission 16 4
export SetNewParms
proc SetNewParms 0 0
line 67
;65://-----------------------------------------------------------------------------------------------------
;66:void SetNewParms( void )
;67:{
line 68
;68:	g_globalvars.parm1 = 0;
ADDRGP4 g_globalvars+164
CNSTF4 0
ASGNF4
line 69
;69:	g_globalvars.parm2 = 100;
ADDRGP4 g_globalvars+168
CNSTF4 1120403456
ASGNF4
line 70
;70:	g_globalvars.parm3 = 0;
ADDRGP4 g_globalvars+172
CNSTF4 0
ASGNF4
line 71
;71:	g_globalvars.parm4 = 25;
ADDRGP4 g_globalvars+176
CNSTF4 1103626240
ASGNF4
line 72
;72:	g_globalvars.parm5 = 0;
ADDRGP4 g_globalvars+180
CNSTF4 0
ASGNF4
line 73
;73:	g_globalvars.parm6 = 0;
ADDRGP4 g_globalvars+184
CNSTF4 0
ASGNF4
line 74
;74:	g_globalvars.parm6 = 0;
ADDRGP4 g_globalvars+184
CNSTF4 0
ASGNF4
line 75
;75:	g_globalvars.parm8 = 1;
ADDRGP4 g_globalvars+192
CNSTF4 1065353216
ASGNF4
line 76
;76:	g_globalvars.parm9 = 0;
ADDRGP4 g_globalvars+196
CNSTF4 0
ASGNF4
line 77
;77:	g_globalvars.parm10 = 0;
ADDRGP4 g_globalvars+200
CNSTF4 0
ASGNF4
line 78
;78:	g_globalvars.parm11 = 0;
ADDRGP4 g_globalvars+204
CNSTF4 0
ASGNF4
line 79
;79:	g_globalvars.parm12 = 0;
ADDRGP4 g_globalvars+208
CNSTF4 0
ASGNF4
line 80
;80:	g_globalvars.parm13 = 0;
ADDRGP4 g_globalvars+212
CNSTF4 0
ASGNF4
line 81
;81:	g_globalvars.parm14 = 0;
ADDRGP4 g_globalvars+216
CNSTF4 0
ASGNF4
line 82
;82:	g_globalvars.parm15 = 0;
ADDRGP4 g_globalvars+220
CNSTF4 0
ASGNF4
line 83
;83:}
LABELV $14
endproc SetNewParms 0 0
export SetChangeParms
proc SetChangeParms 8 0
line 86
;84://-----------------------------------------------------------------------------------------------------
;85:void SetChangeParms()
;86:{
line 88
;87:
;88:	if ( self->s.v.health <= 0 )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $31
line 89
;89:	{
line 90
;90:		SetNewParms();
ADDRGP4 SetNewParms
CALLV
pop
line 91
;91:		return;
ADDRGP4 $30
JUMPV
LABELV $31
line 94
;92:	}
;93:// remove items
;94:	self->s.v.items -= ( ( int ) self->s.v.items &
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRF4
ADDRLP4 4
INDIRF4
CVFI4 4
CNSTI4 8257536
BANDI4
CVIF4 4
SUBF4
ASGNF4
line 99
;95:			     ( IT_KEY1 | IT_KEY2 | IT_INVISIBILITY | IT_INVULNERABILITY | IT_SUIT | IT_QUAD ) );
;96:
;97:
;98:// cap super health
;99:	if ( self->s.v.health > 100 )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1120403456
LEF4 $33
line 100
;100:		self->s.v.health = 100;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1120403456
ASGNF4
LABELV $33
line 102
;101:
;102:	if ( self->s.v.health < 50 )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 1112014848
GEF4 $35
line 103
;103:		self->s.v.health = 50;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1112014848
ASGNF4
LABELV $35
line 105
;104:
;105:	g_globalvars.parm1 = self->s.v.items;
ADDRGP4 g_globalvars+164
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
ASGNF4
line 106
;106:	g_globalvars.parm2 = self->s.v.health;
ADDRGP4 g_globalvars+168
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ASGNF4
line 107
;107:	g_globalvars.parm3 = self->s.v.armorvalue;
ADDRGP4 g_globalvars+172
ADDRGP4 self
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
ASGNF4
line 109
;108:
;109:	if ( self->s.v.ammo_shells < 25 )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1103626240
GEF4 $40
line 110
;110:		g_globalvars.parm4 = 25;
ADDRGP4 g_globalvars+176
CNSTF4 1103626240
ASGNF4
ADDRGP4 $41
JUMPV
LABELV $40
line 112
;111:	else
;112:		g_globalvars.parm4 = self->s.v.ammo_shells;
ADDRGP4 g_globalvars+176
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ASGNF4
LABELV $41
line 114
;113:
;114:	g_globalvars.parm5 = self->s.v.ammo_nails;
ADDRGP4 g_globalvars+180
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
ASGNF4
line 115
;115:	g_globalvars.parm6 = self->s.v.ammo_rockets;
ADDRGP4 g_globalvars+184
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ASGNF4
line 116
;116:	g_globalvars.parm7 = self->s.v.ammo_cells;
ADDRGP4 g_globalvars+188
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ASGNF4
line 117
;117:	g_globalvars.parm8 = self->current_weapon;
ADDRGP4 g_globalvars+192
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 118
;118:	g_globalvars.parm9 = self->s.v.armortype * 100;
ADDRGP4 g_globalvars+196
CNSTF4 1120403456
ADDRGP4 self
INDIRP4
CNSTI4 424
ADDP4
INDIRF4
MULF4
ASGNF4
line 120
;119:
;120:	g_globalvars.parm10 = 0;
ADDRGP4 g_globalvars+200
CNSTF4 0
ASGNF4
line 121
;121:	g_globalvars.parm11 = 0;
ADDRGP4 g_globalvars+204
CNSTF4 0
ASGNF4
line 122
;122:	g_globalvars.parm12 = 0;
ADDRGP4 g_globalvars+208
CNSTF4 0
ASGNF4
line 123
;123:	g_globalvars.parm13 = self->StatusBarRes;
ADDRGP4 g_globalvars+212
ADDRGP4 self
INDIRP4
CNSTI4 1492
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 124
;124:	g_globalvars.parm14 = self->StatusBarSize;
ADDRGP4 g_globalvars+216
ADDRGP4 self
INDIRP4
CNSTI4 1488
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 125
;125:	g_globalvars.parm15 = self->is_admin;
ADDRGP4 g_globalvars+220
ADDRGP4 self
INDIRP4
CNSTI4 1564
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 126
;126:}
LABELV $30
endproc SetChangeParms 8 0
export autoteam_think
proc autoteam_think 4 4
line 130
;127://-----------------------------------------------------------------------------------------------------
;128:
;129:void autoteam_think()
;130:{
line 131
;131:	tf_data.toggleflags |= TFLAG_AUTOTEAM;
ADDRLP4 0
ADDRGP4 tf_data
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 132
;132:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 133
;133:}
LABELV $55
endproc autoteam_think 4 4
export autokick_think
proc autokick_think 0 4
line 135
;134:void autokick_think()
;135:{
line 136
;136:	PROG_TO_EDICT( self->s.v.owner )->teamkills = 0;
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+1540
ADDP4
CNSTI4 0
ASGNI4
line 137
;137:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 138
;138:}
LABELV $56
endproc autokick_think 0 4
data
align 4
LABELV $59
byte 4 1
export DecodeLevelParms
code
proc DecodeLevelParms 360 20
line 143
;139://-----------------------------------------------------------------------------------------------------
;140:extern int     team_top_colors[5];
;141:void UpdateServerinfoScores();
;142:void DecodeLevelParms()
;143:{
line 156
;144:	char    st[10];
;145:	gedict_t *ent;
;146:	gedict_t *te;
;147:	float fvar;
;148:	static int first_decode = 1;
;149:
;150:	// local "21?TeamFortress"
;151:	// local "info_player_team1"
;152:	// local "Mapname: "
;153:	// local "temp1"
;154:	float   autoteam_time;
;155:
;156:	if ( g_globalvars.serverflags )
ADDRGP4 g_globalvars+144
INDIRF4
CNSTF4 0
EQF4 $60
line 157
;157:	{
line 158
;158:		if ( streq( world->s.v.model, "maps/start.bsp" ) )
ADDRGP4 world
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ARGP4
ADDRGP4 $65
ARGP4
ADDRLP4 28
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $63
line 159
;159:			SetNewParms();	// take away all stuff on starting new episode
ADDRGP4 SetNewParms
CALLV
pop
LABELV $63
line 160
;160:	}
LABELV $60
line 161
;161:	self->s.v.items = g_globalvars.parm1;
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
ADDRGP4 g_globalvars+164
INDIRF4
ASGNF4
line 162
;162:	self->s.v.health = g_globalvars.parm2;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
ADDRGP4 g_globalvars+168
INDIRF4
ASGNF4
line 163
;163:	self->s.v.armorvalue = g_globalvars.parm3;
ADDRGP4 self
INDIRP4
CNSTI4 428
ADDP4
ADDRGP4 g_globalvars+172
INDIRF4
ASGNF4
line 164
;164:	self->s.v.ammo_shells = g_globalvars.parm4;
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
ADDRGP4 g_globalvars+176
INDIRF4
ASGNF4
line 165
;165:	self->s.v.ammo_nails = g_globalvars.parm5;
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
ADDRGP4 g_globalvars+180
INDIRF4
ASGNF4
line 166
;166:	self->s.v.ammo_rockets = g_globalvars.parm6;
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
ADDRGP4 g_globalvars+184
INDIRF4
ASGNF4
line 167
;167:	self->s.v.ammo_cells = g_globalvars.parm7;
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
ADDRGP4 g_globalvars+188
INDIRF4
ASGNF4
line 168
;168:	self->current_weapon = g_globalvars.parm8;
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
ADDRGP4 g_globalvars+192
INDIRF4
CVFI4 4
ASGNI4
line 169
;169:	self->s.v.armortype = g_globalvars.parm9 * 0.01;
ADDRGP4 self
INDIRP4
CNSTI4 424
ADDP4
CNSTF4 1008981770
ADDRGP4 g_globalvars+196
INDIRF4
MULF4
ASGNF4
line 171
;170:
;171:	if ( g_globalvars.parm11 )
ADDRGP4 g_globalvars+204
INDIRF4
CNSTF4 0
EQF4 $75
line 172
;172:		self->tfstate = g_globalvars.parm11;
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ADDRGP4 g_globalvars+204
INDIRF4
CVFI4 4
ASGNI4
LABELV $75
line 173
;173:	if ( !self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $79
line 174
;174:		self->playerclass = g_globalvars.parm12;
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
ADDRGP4 g_globalvars+208
INDIRF4
CVFI4 4
ASGNI4
LABELV $79
line 184
;175:/* if (parm13) 
;176:  self.StatusBarRes = parm13;
;177: if (parm14) 
;178:  self.StatusBarSize = parm14;*/
;179:/*	if ( g_globalvars.parm15 )
;180:	{
;181:		self->is_admin = g_globalvars.parm15;
;182:	}*/
;183:
;184:	if ( !( tf_data.toggleflags & TFLAG_FIRSTENTRY ) )
ADDRGP4 tf_data
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
NEI4 $82
line 185
;185:	{
line 187
;186:
;187:	        if( !first_decode )
ADDRGP4 $59
INDIRI4
CNSTI4 0
NEI4 $84
line 188
;188:	        {
line 189
;189:	                G_bprint(2,"!!!BUG BUG BUG!!!\nfirst_decode != 0 %d %s\n!!!BUG BUG BUG!!!\n", tf_data.toggleflags, self->s.v.netname);
CNSTI4 2
ARGI4
ADDRGP4 $86
ARGP4
ADDRGP4 tf_data
INDIRI4
ARGI4
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 190
;190:	                tf_data.toggleflags |= TFLAG_FIRSTENTRY;
ADDRLP4 28
ADDRGP4 tf_data
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 191
;191:	                G_bprint(2,"toggleflags %d\n", tf_data.toggleflags );
CNSTI4 2
ARGI4
ADDRGP4 $87
ARGP4
ADDRGP4 tf_data
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
line 192
;192:	                return;
ADDRGP4 $58
JUMPV
LABELV $84
line 194
;193:	        }
;194:	        first_decode = 0;
ADDRGP4 $59
CNSTI4 0
ASGNI4
line 195
;195:		tf_data.toggleflags = g_globalvars.parm10;
ADDRGP4 tf_data
ADDRGP4 g_globalvars+200
INDIRF4
CVFI4 4
ASGNI4
line 196
;196:		tf_data.flagem_checked = 0;
ADDRGP4 tf_data+68
CNSTI4 0
ASGNI4
line 197
;197:		tf_data.allow_hook = 0;
ADDRGP4 tf_data+64
CNSTI4 0
ASGNI4
line 198
;198:		tf_data.invis_only = 0;
ADDRGP4 tf_data+60
CNSTI4 0
ASGNI4
line 199
;199:		if ( coop || !deathmatch )
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRGP4 coop
INDIRI4
ADDRLP4 28
INDIRI4
NEI4 $94
ADDRGP4 deathmatch
INDIRI4
ADDRLP4 28
INDIRI4
NEI4 $92
LABELV $94
line 200
;200:			tf_data.toggleflags |= TFLAG_CLASS_PERSIST;
ADDRLP4 32
ADDRGP4 tf_data
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
LABELV $92
line 201
;201:		strncpy( nextmap, g_globalvars.mapname, sizeof(nextmap) );
ADDRGP4 nextmap
ARGP4
ADDRGP4 g_globalvars+140
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 202
;202:		tf_data.allow_hook = 1;
ADDRGP4 tf_data+64
CNSTI4 1
ASGNI4
line 204
;203:
;204:		ent = trap_find( world, FOFS( s.v.classname ), "info_tfdetect" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $97
ARGP4
ADDRLP4 36
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 36
INDIRP4
ASGNP4
line 205
;205:		if ( ent )
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $98
line 206
;206:		{
line 207
;207:			if ( !teamplay )
ADDRGP4 teamplay
INDIRI4
CNSTI4 0
NEI4 $100
line 208
;208:				trap_cvar_set( "teamplay", "21?TeamFortress" );
ADDRGP4 $102
ARGP4
ADDRGP4 $103
ARGP4
ADDRGP4 trap_cvar_set
CALLV
pop
LABELV $100
line 210
;209:
;210:			ParseTFDetect( ent );
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 ParseTFDetect
CALLV
pop
line 212
;211:
;212:			if ( number_of_teams <= 0 || number_of_teams >= 5 )
ADDRLP4 40
ADDRGP4 number_of_teams
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
LEI4 $106
ADDRLP4 40
INDIRI4
CNSTI4 5
LTI4 $99
LABELV $106
line 213
;213:				number_of_teams = 4;
ADDRGP4 number_of_teams
CNSTI4 4
ASGNI4
line 214
;214:		} else
ADDRGP4 $99
JUMPV
LABELV $98
line 215
;215:		{
line 216
;216:			ent = trap_find( world, FOFS( s.v.classname ), "info_player_team1" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $107
ARGP4
ADDRLP4 40
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 40
INDIRP4
ASGNP4
line 217
;217:			if ( ent || CTF_Map == 1 )
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $110
ADDRGP4 CTF_Map
INDIRI4
CNSTI4 1
NEI4 $108
LABELV $110
line 218
;218:			{
line 219
;219:				CTF_Map = 1;
ADDRGP4 CTF_Map
CNSTI4 1
ASGNI4
line 220
;220:				if ( !teamplay )
ADDRGP4 teamplay
INDIRI4
CNSTI4 0
NEI4 $111
line 221
;221:					trap_cvar_set( "teamplay", "21?TeamFortress" );
ADDRGP4 $102
ARGP4
ADDRGP4 $103
ARGP4
ADDRGP4 trap_cvar_set
CALLV
pop
LABELV $111
line 222
;222:				ent = spawn();
ADDRLP4 44
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 44
INDIRP4
ASGNP4
line 223
;223:				ent->s.v.nextthink = g_globalvars.time + 30;
ADDRLP4 16
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 224
;224:				ent->s.v.think = ( func_t ) CTF_FlagCheck;
ADDRLP4 16
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 CTF_FlagCheck
CVPU4 4
CVUI4 4
ASGNI4
line 225
;225:				number_of_teams = 2;
ADDRGP4 number_of_teams
CNSTI4 2
ASGNI4
line 226
;226:			} else
ADDRGP4 $109
JUMPV
LABELV $108
line 227
;227:				number_of_teams = 4;
ADDRGP4 number_of_teams
CNSTI4 4
ASGNI4
LABELV $109
line 229
;228:
;229:			teamlives[0] = -1;
ADDRGP4 teamlives
CNSTI4 -1
ASGNI4
line 230
;230:			teamlives[1] = -1;
ADDRGP4 teamlives+4
CNSTI4 -1
ASGNI4
line 231
;231:			teamlives[2] = -1;
ADDRGP4 teamlives+8
CNSTI4 -1
ASGNI4
line 232
;232:			teamlives[3] = -1;
ADDRGP4 teamlives+12
CNSTI4 -1
ASGNI4
line 233
;233:			teamlives[4] = -1;
ADDRGP4 teamlives+16
CNSTI4 -1
ASGNI4
line 234
;234:			illegalclasses[0] = 0;
ADDRGP4 illegalclasses
CNSTI4 0
ASGNI4
line 235
;235:			illegalclasses[1] = 0;
ADDRGP4 illegalclasses+4
CNSTI4 0
ASGNI4
line 236
;236:			illegalclasses[2] = 0;
ADDRGP4 illegalclasses+8
CNSTI4 0
ASGNI4
line 237
;237:			illegalclasses[3] = 0;
ADDRGP4 illegalclasses+12
CNSTI4 0
ASGNI4
line 238
;238:			illegalclasses[4] = 0;
ADDRGP4 illegalclasses+16
CNSTI4 0
ASGNI4
line 239
;239:			teammaxplayers[0] = 100;
ADDRGP4 teammaxplayers
CNSTI4 100
ASGNI4
line 240
;240:			teammaxplayers[1] = 100;
ADDRGP4 teammaxplayers+4
CNSTI4 100
ASGNI4
line 241
;241:			teammaxplayers[2] = 100;
ADDRGP4 teammaxplayers+8
CNSTI4 100
ASGNI4
line 242
;242:			teammaxplayers[3] = 100;
ADDRGP4 teammaxplayers+12
CNSTI4 100
ASGNI4
line 243
;243:			teammaxplayers[4] = 100;
ADDRGP4 teammaxplayers+16
CNSTI4 100
ASGNI4
line 245
;244:
;245:			civilianteams = 0;
ADDRGP4 civilianteams
CNSTI4 0
ASGNI4
line 246
;246:		}
LABELV $99
line 247
;247:		G_bprint( 2, "Mapname: %s\n", g_globalvars.mapname );
CNSTI4 2
ARGI4
ADDRGP4 $126
ARGP4
ADDRGP4 g_globalvars+140
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 248
;248:		SetupTeamEqualiser();
ADDRGP4 SetupTeamEqualiser
CALLV
pop
line 249
;249:		teamfrags[0] = 0;
ADDRGP4 teamfrags
CNSTI4 0
ASGNI4
line 250
;250:		teamfrags[1] = 0;
ADDRGP4 teamfrags+4
CNSTI4 0
ASGNI4
line 251
;251:		teamfrags[2] = 0;
ADDRGP4 teamfrags+8
CNSTI4 0
ASGNI4
line 252
;252:		teamfrags[3] = 0;
ADDRGP4 teamfrags+12
CNSTI4 0
ASGNI4
line 253
;253:		teamfrags[4] = 0;
ADDRGP4 teamfrags+16
CNSTI4 0
ASGNI4
line 254
;254:		teamscores[0] = 0;
ADDRGP4 teamscores
CNSTI4 0
ASGNI4
line 255
;255:		teamscores[1] = 0;
ADDRGP4 teamscores+4
CNSTI4 0
ASGNI4
line 256
;256:		teamscores[2] = 0;
ADDRGP4 teamscores+8
CNSTI4 0
ASGNI4
line 257
;257:		teamscores[3] = 0;
ADDRGP4 teamscores+12
CNSTI4 0
ASGNI4
line 258
;258:		teamscores[4] = 0;
ADDRGP4 teamscores+16
CNSTI4 0
ASGNI4
line 259
;259:		UpdateServerinfoScores();
ADDRGP4 UpdateServerinfoScores
CALLV
pop
line 260
;260:		tf_data.autokick_kills = 0;
ADDRGP4 tf_data+84
CNSTI4 0
ASGNI4
line 261
;261:		tf_data.autokick_time = 0;
ADDRGP4 tf_data+80
CNSTF4 0
ASGNF4
line 262
;262:		tf_data.cease_fire = 0;
ADDRGP4 tf_data+72
CNSTI4 0
ASGNI4
line 264
;263:
;264:		tf_data.toggleflags -= ( tf_data.toggleflags & TFLAG_TEAMFRAGS );
ADDRLP4 40
ADDRGP4 tf_data
ASGNP4
ADDRLP4 44
ADDRLP4 40
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRP4
ADDRLP4 44
INDIRI4
ADDRLP4 44
INDIRI4
CNSTI4 128
BANDI4
SUBI4
ASGNI4
line 266
;265:
;266:		tf_data.toggleflags -= ( tf_data.toggleflags & TFLAG_CHEATCHECK );
ADDRLP4 48
ADDRGP4 tf_data
ASGNP4
ADDRLP4 52
ADDRLP4 48
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 48
INDIRP4
ADDRLP4 52
INDIRI4
ADDRLP4 52
INDIRI4
CNSTI4 2
BANDI4
SUBI4
ASGNI4
line 268
;267:
;268:		tf_data.toggleflags |= GetSVInfokeyInt( "temp1", NULL, 0 );
ADDRGP4 $139
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 56
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRLP4 60
ADDRGP4 tf_data
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
ADDRLP4 56
INDIRI4
BORI4
ASGNI4
line 269
;269:		tf_data.toggleflags |= TFLAG_FIRSTENTRY;
ADDRLP4 64
ADDRGP4 tf_data
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 271
;270:
;271:		autoteam_time = 30;
ADDRLP4 24
CNSTF4 1106247680
ASGNF4
line 273
;272:
;273:		GetSVInfokeyString( "bd", "birthday", st, sizeof( st ), "off" );
ADDRGP4 $140
ARGP4
ADDRGP4 $141
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $142
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 274
;274:		if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 68
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $143
line 275
;275:		{
line 276
;276:			tf_data.birthday = 1;
ADDRGP4 tf_data+92
CNSTI4 1
ASGNI4
line 277
;277:			te = spawn();
ADDRLP4 72
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 72
INDIRP4
ASGNP4
line 278
;278:			te->s.v.weapon = 10;
ADDRLP4 12
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1092616192
ASGNF4
line 279
;279:			te->s.v.nextthink = g_globalvars.time + 60;
ADDRLP4 12
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 280
;280:			te->s.v.think = ( func_t ) BirthdayTimer;
ADDRLP4 12
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 BirthdayTimer
CVPU4 4
CVUI4 4
ASGNI4
line 281
;281:		} else
ADDRGP4 $144
JUMPV
LABELV $143
line 282
;282:		{
line 283
;283:			tf_data.birthday = 0;
ADDRGP4 tf_data+92
CNSTI4 0
ASGNI4
line 284
;284:		}
LABELV $144
line 285
;285:		GetSVInfokeyString( "c", "clan", st, sizeof( st ), "off" );
ADDRGP4 $149
ARGP4
ADDRGP4 $150
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $142
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 286
;286:		if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 72
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $151
line 287
;287:		{
line 288
;288:			tf_data.clanbattle = 1;
ADDRGP4 tf_data+16
CNSTI4 1
ASGNI4
line 289
;289:			tf_data.clan_scores_dumped = 0;
ADDRGP4 tf_data+20
CNSTF4 0
ASGNF4
line 290
;290:			tf_data.game_locked = 0;
ADDRGP4 tf_data+32
CNSTI4 0
ASGNI4
line 292
;291:
;292:			GetSVInfokeyString( "lg", "locked_game", st, sizeof( st ), "off" );
ADDRGP4 $156
ARGP4
ADDRGP4 $157
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $142
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 293
;293:			if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 76
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $152
line 294
;294:				tf_data.game_locked = 1;
ADDRGP4 tf_data+32
CNSTI4 1
ASGNI4
line 295
;295:		} else
ADDRGP4 $152
JUMPV
LABELV $151
line 296
;296:			tf_data.clanbattle = 0;
ADDRGP4 tf_data+16
CNSTI4 0
ASGNI4
LABELV $152
line 298
;297:
;298:       		fvar = GetSVInfokeyFloat( "pm", "prematch", 0 );
ADDRGP4 $162
ARGP4
ADDRGP4 $163
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 76
ADDRGP4 GetSVInfokeyFloat
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 76
INDIRF4
ASGNF4
line 299
;299:       		if( fvar < 0 )
ADDRLP4 20
INDIRF4
CNSTF4 0
GEF4 $164
line 300
;300:       			fvar = 0;
ADDRLP4 20
CNSTF4 0
ASGNF4
LABELV $164
line 301
;301:       		tf_data.cb_prematch_time = g_globalvars.time + fvar * 60;
ADDRGP4 tf_data+24
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1114636288
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 302
;302:       		if( fvar )
ADDRLP4 20
INDIRF4
CNSTF4 0
EQF4 $168
line 303
;303:       		{
line 304
;304:       			tf_data.cb_prematch_time += 5;
ADDRLP4 80
ADDRGP4 tf_data+24
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 305
;305:       			ent = spawn();
ADDRLP4 84
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 84
INDIRP4
ASGNP4
line 306
;306:       			ent->s.v.think = ( func_t ) PreMatch_Think;
ADDRLP4 16
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 PreMatch_Think
CVPU4 4
CVUI4 4
ASGNI4
line 307
;307:       			ent->s.v.nextthink = g_globalvars.time + 5;
ADDRLP4 16
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 309
;308:
;309:       			tf_data.cb_ceasefire_time = GetSVInfokeyFloat( "cft", "ceasefire_time", 0 );
ADDRGP4 $173
ARGP4
ADDRGP4 $174
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 88
ADDRGP4 GetSVInfokeyFloat
CALLF4
ASGNF4
ADDRGP4 tf_data+28
ADDRLP4 88
INDIRF4
ASGNF4
line 311
;310:
;311:       			if ( tf_data.cb_ceasefire_time > 0 )
ADDRGP4 tf_data+28
INDIRF4
CNSTF4 0
LEF4 $175
line 312
;312:       			{
line 313
;313:       				tf_data.cb_ceasefire_time = g_globalvars.time + tf_data.cb_ceasefire_time * 60;
ADDRGP4 tf_data+28
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1114636288
ADDRGP4 tf_data+28
INDIRF4
MULF4
ADDF4
ASGNF4
line 315
;314:
;315:       				if( tf_data.cb_prematch_time <= tf_data.cb_ceasefire_time + 7  )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 tf_data+28
INDIRF4
CNSTF4 1088421888
ADDF4
GTF4 $181
line 316
;316:       				{
line 317
;317:       					tf_data.cb_ceasefire_time = tf_data.cb_prematch_time;
ADDRGP4 tf_data+28
ADDRGP4 tf_data+24
INDIRF4
ASGNF4
line 318
;318:       					tf_data.cb_prematch_time += 7;
ADDRLP4 92
ADDRGP4 tf_data+24
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRF4
CNSTF4 1088421888
ADDF4
ASGNF4
line 319
;319:       				}
LABELV $181
line 321
;320:       				
;321:                  			tf_data.cease_fire = 1;
ADDRGP4 tf_data+72
CNSTI4 1
ASGNI4
line 322
;322:                  			G_bprint( 2, "CEASE FIRE\n" );
CNSTI4 2
ARGI4
ADDRGP4 $189
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 323
;323:                  			te = trap_find( world, FOFS( s.v.classname ), "player" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $190
ARGP4
ADDRLP4 92
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 92
INDIRP4
ASGNP4
ADDRGP4 $192
JUMPV
LABELV $191
line 325
;324:                  			while ( te )
;325:                  			{
line 326
;326:                  				CenterPrint( te, "CEASE FIRE\n" );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $189
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 327
;327:                  				te->tfstate = te->tfstate | TFSTATE_CANT_MOVE;
ADDRLP4 96
ADDRLP4 12
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CNSTI4 65536
BORI4
ASGNI4
line 328
;328:                  				TeamFortress_SetSpeed( te );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 329
;329:                  				te = trap_find( te, FOFS( s.v.classname ), "player" );
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $190
ARGP4
ADDRLP4 100
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 100
INDIRP4
ASGNP4
line 330
;330:                  			}
LABELV $192
line 324
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $191
line 331
;331:                  			te = spawn();
ADDRLP4 96
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 96
INDIRP4
ASGNP4
line 332
;332:                  			te->s.v.classname = "ceasefire";
ADDRLP4 12
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $194
ASGNP4
line 333
;333:                  			te->s.v.think = ( func_t ) CeaseFire_think;
ADDRLP4 12
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 CeaseFire_think
CVPU4 4
CVUI4 4
ASGNI4
line 334
;334:                  			te->s.v.nextthink = g_globalvars.time + 5;
ADDRLP4 12
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 335
;335:                  			te->s.v.weapon = 1;
ADDRLP4 12
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1065353216
ASGNF4
line 336
;336:       			}else
ADDRGP4 $176
JUMPV
LABELV $175
line 337
;337:       				tf_data.cb_ceasefire_time = 0;
ADDRGP4 tf_data+28
CNSTF4 0
ASGNF4
LABELV $176
line 338
;338:       		}
LABELV $168
line 339
;339:       		if ( timelimit && ( ( timelimit ) < tf_data.cb_prematch_time ) )
ADDRLP4 80
ADDRGP4 timelimit
INDIRI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $197
ADDRLP4 80
INDIRI4
CVIF4 4
ADDRGP4 tf_data+24
INDIRF4
GEF4 $197
line 340
;340:       		{
line 341
;341:       			timelimit += tf_data.cb_prematch_time;
ADDRLP4 84
ADDRGP4 timelimit
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 tf_data+24
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 342
;342:       			_snprintf( st, sizeof(st), "%d", (int)( timelimit / 60 ) );
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $201
ARGP4
ADDRGP4 timelimit
INDIRI4
CNSTI4 60
DIVI4
ARGI4
ADDRGP4 _snprintf
CALLI4
pop
line 343
;343:       			trap_cvar_set( "timelimit", st );
ADDRGP4 $202
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_cvar_set
CALLV
pop
line 344
;344:       		}
LABELV $197
line 346
;345:
;346:		GetSVInfokeyString( "a", "autoteam", st, sizeof( st ), "" );
ADDRGP4 $203
ARGP4
ADDRGP4 $204
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $205
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 347
;347:		if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 84
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
NEI4 $206
line 348
;348:			tf_data.toggleflags |= TFLAG_AUTOTEAM;
ADDRLP4 88
ADDRGP4 tf_data
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
ADDRGP4 $207
JUMPV
LABELV $206
line 350
;349:		else
;350:		{
line 351
;351:			if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $142
ARGP4
ADDRLP4 92
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $208
line 352
;352:				tf_data.toggleflags -= ( tf_data.toggleflags & TFLAG_AUTOTEAM );
ADDRLP4 96
ADDRGP4 tf_data
ASGNP4
ADDRLP4 100
ADDRLP4 96
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 96
INDIRP4
ADDRLP4 100
INDIRI4
ADDRLP4 100
INDIRI4
CNSTI4 64
BANDI4
SUBI4
ASGNI4
ADDRGP4 $209
JUMPV
LABELV $208
line 354
;353:			else
;354:			{
line 355
;355:				if ( atoi( st ) )
ADDRLP4 0
ARGP4
ADDRLP4 104
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
EQI4 $210
line 356
;356:				{
line 357
;357:					tf_data.toggleflags |= TFLAG_AUTOTEAM;
ADDRLP4 108
ADDRGP4 tf_data
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 358
;358:					autoteam_time = atoi( st );
ADDRLP4 0
ARGP4
ADDRLP4 112
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 112
INDIRI4
CVIF4 4
ASGNF4
line 359
;359:				}
LABELV $210
line 360
;360:			}
LABELV $209
line 361
;361:		}
LABELV $207
line 362
;362:		tf_data.autokick_time = GetSVInfokeyInt( "akt", "autokick_time", 0 );
ADDRGP4 $213
ARGP4
ADDRGP4 $214
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 92
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRGP4 tf_data+80
ADDRLP4 92
INDIRI4
CVIF4 4
ASGNF4
line 363
;363:		if ( tf_data.autokick_time )
ADDRGP4 tf_data+80
INDIRF4
CNSTF4 0
EQF4 $215
line 364
;364:		{
line 365
;365:			tf_data.autokick_kills = GetSVInfokeyInt( "akk", "autokick_kills", 0 );
ADDRGP4 $219
ARGP4
ADDRGP4 $220
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 96
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRGP4 tf_data+84
ADDRLP4 96
INDIRI4
ASGNI4
line 366
;366:		}
LABELV $215
line 367
;367:		GetSVInfokeyString( "t", "teamfrags", st, sizeof( st ), "" );
ADDRGP4 $221
ARGP4
ADDRGP4 $222
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $205
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 368
;368:		if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 96
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
NEI4 $223
line 369
;369:			tf_data.toggleflags |= TFLAG_TEAMFRAGS;
ADDRLP4 100
ADDRGP4 tf_data
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
ADDRGP4 $224
JUMPV
LABELV $223
line 371
;370:		else
;371:		{
line 372
;372:			if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $142
ARGP4
ADDRLP4 104
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
NEI4 $225
line 373
;373:				tf_data.toggleflags -= ( tf_data.toggleflags & TFLAG_TEAMFRAGS );
ADDRLP4 108
ADDRGP4 tf_data
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
CNSTI4 128
BANDI4
SUBI4
ASGNI4
LABELV $225
line 374
;374:		}
LABELV $224
line 380
;375:		// add this feature in later - xavior
;376://		GetSVInfokeyString( "fts", "fullteamscore", st, sizeof( st ), "off" );
;377://		if ( !strcmp( st, "on" ) )
;378://			tf_data.toggleflags |= TFLAG_FULLTEAMSCORE;
;379:
;380:		GetSVInfokeyString( "g", "grapple", st, sizeof( st ), "off" );
ADDRGP4 $227
ARGP4
ADDRGP4 $228
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $142
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 381
;381:		if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $142
ARGP4
ADDRLP4 104
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
NEI4 $229
line 382
;382:			tf_data.allow_hook = 0;
ADDRGP4 tf_data+64
CNSTI4 0
ASGNI4
LABELV $229
line 384
;383:
;384:		if ( !( tf_data.toggleflags & TFLAG_GRAPPLE ) && strcmp( st, "on" ) )
ADDRGP4 tf_data
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
NEI4 $232
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 108
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
EQI4 $232
line 385
;385:			tf_data.allow_hook = 0;
ADDRGP4 tf_data+64
CNSTI4 0
ASGNI4
LABELV $232
line 387
;386:
;387:		if ( !GetSVInfokeyString( "og", "old_grenades", st, sizeof( st ), "on" ) )
ADDRGP4 $237
ARGP4
ADDRGP4 $238
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $145
ARGP4
ADDRLP4 112
ADDRGP4 GetSVInfokeyString
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
NEI4 $235
line 388
;388:			GetSVInfokeyString( "old_grens", NULL, st, sizeof( st ), "on" );
ADDRGP4 $239
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $145
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
LABELV $235
line 390
;389:
;390:		if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 116
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
NEI4 $240
line 391
;391:			tf_data.old_grens = 1;
ADDRGP4 tf_data+44
CNSTI4 1
ASGNI4
LABELV $240
line 393
;392:
;393:		GetSVInfokeyString( "spy", NULL, st, sizeof( st ), "on" );
ADDRGP4 $243
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $145
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 394
;394:		if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $142
ARGP4
ADDRLP4 120
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
NEI4 $244
line 395
;395:			tf_data.spy_off = 1;
ADDRGP4 tf_data+40
CNSTI4 1
ASGNI4
LABELV $244
line 397
;396:
;397:		GetSVInfokeyString( "s", "spyinvis", st, sizeof( st ), "off" );
ADDRGP4 $247
ARGP4
ADDRGP4 $248
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $142
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 399
;398:
;399:		if ( !strcmp( st, "on" ) || ( tf_data.toggleflags & TFLAG_SPYINVIS ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 124
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 128
CNSTI4 0
ASGNI4
ADDRLP4 124
INDIRI4
ADDRLP4 128
INDIRI4
EQI4 $251
ADDRGP4 tf_data
INDIRI4
CNSTI4 512
BANDI4
ADDRLP4 128
INDIRI4
EQI4 $249
LABELV $251
line 400
;400:			tf_data.invis_only = 1;
ADDRGP4 tf_data+60
CNSTI4 1
ASGNI4
ADDRGP4 $250
JUMPV
LABELV $249
line 402
;401:		else
;402:		{
line 403
;403:			if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $142
ARGP4
ADDRLP4 132
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
NEI4 $253
line 404
;404:				tf_data.invis_only = 0;
ADDRGP4 tf_data+60
CNSTI4 0
ASGNI4
LABELV $253
line 405
;405:		}
LABELV $250
line 408
;406:
;407:
;408:		tf_data.cheat_pause = GetSVInfokeyInt( "cp", NULL, 1 );
ADDRGP4 $257
ARGP4
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 132
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRGP4 tf_data+96
ADDRLP4 132
INDIRI4
ASGNI4
line 409
;409:		if ( tf_data.cheat_pause <= 0 )
ADDRGP4 tf_data+96
INDIRI4
CNSTI4 0
GTI4 $258
line 410
;410:			tf_data.cheat_pause = 1;
ADDRGP4 tf_data+96
CNSTI4 1
ASGNI4
LABELV $258
line 413
;411:
;412:////top colors
;413:		tf_data.topcolor_check = 0;
ADDRGP4 tf_data+104
CNSTI4 0
ASGNI4
line 415
;414:
;415:		team_top_colors[1] = GetSVInfokeyInt( "tc1", NULL, -1 );
ADDRGP4 $264
ARGP4
CNSTP4 0
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 136
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRGP4 team_top_colors+4
ADDRLP4 136
INDIRI4
ASGNI4
line 416
;416:		if ( team_top_colors[1] >= 0 && team_top_colors[1] <= 15 )
ADDRGP4 team_top_colors+4
INDIRI4
CNSTI4 0
LTI4 $265
ADDRGP4 team_top_colors+4
INDIRI4
CNSTI4 15
GTI4 $265
line 417
;417:			tf_data.topcolor_check = 1;
ADDRGP4 tf_data+104
CNSTI4 1
ASGNI4
ADDRGP4 $266
JUMPV
LABELV $265
line 419
;418:		else
;419:			team_top_colors[1] = TeamFortress_TeamGetColor( 1 ) - 1;
CNSTI4 1
ARGI4
ADDRLP4 140
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRGP4 team_top_colors+4
ADDRLP4 140
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $266
line 421
;420:
;421:		team_top_colors[2] = GetSVInfokeyInt( "tc2", NULL, -1 );
ADDRGP4 $272
ARGP4
CNSTP4 0
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 144
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRGP4 team_top_colors+8
ADDRLP4 144
INDIRI4
ASGNI4
line 422
;422:		if ( team_top_colors[2] >= 0 && team_top_colors[2] <= 15 )
ADDRGP4 team_top_colors+8
INDIRI4
CNSTI4 0
LTI4 $273
ADDRGP4 team_top_colors+8
INDIRI4
CNSTI4 15
GTI4 $273
line 423
;423:			tf_data.topcolor_check = 1;
ADDRGP4 tf_data+104
CNSTI4 1
ASGNI4
ADDRGP4 $274
JUMPV
LABELV $273
line 425
;424:		else
;425:			team_top_colors[2] = TeamFortress_TeamGetColor( 2 ) - 1;
CNSTI4 2
ARGI4
ADDRLP4 148
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRGP4 team_top_colors+8
ADDRLP4 148
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $274
line 428
;426:
;427:
;428:		team_top_colors[3] = GetSVInfokeyInt( "tc3", NULL, -1 );
ADDRGP4 $280
ARGP4
CNSTP4 0
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 152
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRGP4 team_top_colors+12
ADDRLP4 152
INDIRI4
ASGNI4
line 429
;429:		if ( team_top_colors[3] >= 0 && team_top_colors[3] <= 15 )
ADDRGP4 team_top_colors+12
INDIRI4
CNSTI4 0
LTI4 $281
ADDRGP4 team_top_colors+12
INDIRI4
CNSTI4 15
GTI4 $281
line 430
;430:			tf_data.topcolor_check = 1;
ADDRGP4 tf_data+104
CNSTI4 1
ASGNI4
ADDRGP4 $282
JUMPV
LABELV $281
line 432
;431:		else
;432:			team_top_colors[3] = TeamFortress_TeamGetColor( 3 ) - 1;
CNSTI4 3
ARGI4
ADDRLP4 156
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRGP4 team_top_colors+12
ADDRLP4 156
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $282
line 434
;433:
;434:		team_top_colors[4] = GetSVInfokeyInt( "tc4", NULL, -1 );
ADDRGP4 $288
ARGP4
CNSTP4 0
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 160
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRGP4 team_top_colors+16
ADDRLP4 160
INDIRI4
ASGNI4
line 435
;435:		if ( team_top_colors[4] >= 0 && team_top_colors[4] <= 15 )
ADDRGP4 team_top_colors+16
INDIRI4
CNSTI4 0
LTI4 $289
ADDRGP4 team_top_colors+16
INDIRI4
CNSTI4 15
GTI4 $289
line 436
;436:			tf_data.topcolor_check = 1;
ADDRGP4 tf_data+104
CNSTI4 1
ASGNI4
ADDRGP4 $290
JUMPV
LABELV $289
line 438
;437:		else
;438:			team_top_colors[4] = TeamFortress_TeamGetColor( 4 ) - 1;
CNSTI4 4
ARGI4
ADDRLP4 164
ADDRGP4 TeamFortress_TeamGetColor
CALLI4
ASGNI4
ADDRGP4 team_top_colors+16
ADDRLP4 164
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $290
line 441
;439:
;440:
;441:		GetSVInfokeyString( "adg", "allow_drop_goal", st, sizeof( st ), "off" );
ADDRGP4 $295
ARGP4
ADDRGP4 $296
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $142
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 442
;442:		if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 168
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
NEI4 $297
line 443
;443:			tf_data.allow_drop_goal = 1;
ADDRGP4 tf_data+76
CNSTI4 1
ASGNI4
ADDRGP4 $298
JUMPV
LABELV $297
line 445
;444:		else
;445:			tf_data.allow_drop_goal = 0;
ADDRGP4 tf_data+76
CNSTI4 0
ASGNI4
LABELV $298
line 447
;446:
;447:		GetSVInfokeyString( "add_pipe", NULL, st, sizeof( st ), "on" );
ADDRGP4 $301
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $145
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 448
;448:		if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 172
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
NEI4 $302
line 449
;449:			tf_data.add_pipe = 1;
ADDRGP4 tf_data+140
CNSTI4 1
ASGNI4
ADDRGP4 $303
JUMPV
LABELV $302
line 451
;450:		else
;451:			tf_data.add_pipe = 0;
ADDRGP4 tf_data+140
CNSTI4 0
ASGNI4
LABELV $303
line 453
;452:
;453:		GetSVInfokeyString( "nf", "new_flash", st, sizeof( st ), "on" );
ADDRGP4 $306
ARGP4
ADDRGP4 $307
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $145
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 454
;454:		if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 176
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
NEI4 $308
line 455
;455:			tf_data.new_flash = 1;
ADDRGP4 tf_data+48
CNSTI4 1
ASGNI4
ADDRGP4 $309
JUMPV
LABELV $308
line 457
;456:		else
;457:			tf_data.new_flash = 0;
ADDRGP4 tf_data+48
CNSTI4 0
ASGNI4
LABELV $309
line 459
;458:
;459:		GetSVInfokeyString( "self_flash", NULL, st, sizeof( st ), "on" );
ADDRGP4 $312
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $145
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 460
;460:		if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 180
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
NEI4 $313
line 461
;461:			tf_data.self_flash = 1;
ADDRGP4 tf_data+52
CNSTI4 1
ASGNI4
ADDRGP4 $314
JUMPV
LABELV $313
line 463
;462:		else
;463:			tf_data.self_flash = 0;
ADDRGP4 tf_data+52
CNSTI4 0
ASGNI4
LABELV $314
line 465
;464:
;465:		GetSVInfokeyString( "exec_class", NULL, st, sizeof( st ), "on" );
ADDRGP4 $317
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $145
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 466
;466:		if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $142
ARGP4
ADDRLP4 184
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
NEI4 $318
line 467
;467:			tf_data.exec_class = 0;
ADDRGP4 tf_data+56
CNSTI4 0
ASGNI4
ADDRGP4 $319
JUMPV
LABELV $318
line 469
;468:		else
;469:			tf_data.exec_class = 1;
ADDRGP4 tf_data+56
CNSTI4 1
ASGNI4
LABELV $319
line 471
;470:
;471:		tf_data.new_gas = GetSVInfokeyInt( "new_gas", NULL, GAS_DEFAULT );
ADDRGP4 $323
ARGP4
CNSTP4 0
ARGP4
CNSTI4 131
ARGI4
ADDRLP4 188
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRGP4 tf_data+144
ADDRLP4 188
INDIRI4
ASGNI4
line 475
;472:
;473:
;474:		
;475:		tf_data.sg_newfind = true;
ADDRGP4 tf_data+108
CNSTI4 1
ASGNI4
line 476
;476:		tf_data.sg_sfire   = SG_SFIRE_NEW;
ADDRGP4 tf_data+112
CNSTI4 0
ASGNI4
line 478
;477:
;478:		GetSVInfokeyString( "sg", NULL, st, sizeof( st ), "new" );
ADDRGP4 $326
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $327
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 479
;479:		if ( !strcmp( st, "old" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $330
ARGP4
ADDRLP4 192
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
NEI4 $328
line 480
;480:		{
line 481
;481:			tf_data.sg_newfind = false;
ADDRGP4 tf_data+108
CNSTI4 0
ASGNI4
line 482
;482:			tf_data.sg_sfire   = SG_SFIRE_281;
ADDRGP4 tf_data+112
CNSTI4 1
ASGNI4
line 483
;483:		}
LABELV $328
line 484
;484:		if ( !strcmp( st, "fix" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $335
ARGP4
ADDRLP4 196
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
NEI4 $333
line 485
;485:		{
line 486
;486:			tf_data.sg_newfind = false;
ADDRGP4 tf_data+108
CNSTI4 0
ASGNI4
line 487
;487:			tf_data.sg_sfire   = SG_SFIRE_MTFL2;
ADDRGP4 tf_data+112
CNSTI4 3
ASGNI4
line 488
;488:		}
LABELV $333
line 490
;489:
;490:		if ( !strcmp( st, "oldmtfl" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $340
ARGP4
ADDRLP4 200
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
NEI4 $338
line 491
;491:		{
line 492
;492:			tf_data.sg_newfind = false;
ADDRGP4 tf_data+108
CNSTI4 0
ASGNI4
line 493
;493:			tf_data.sg_sfire   = SG_SFIRE_MTFL1;
ADDRGP4 tf_data+112
CNSTI4 2
ASGNI4
line 494
;494:		}
LABELV $338
line 495
;495:		if ( !strcmp( st, "mtflf" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $345
ARGP4
ADDRLP4 204
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
NEI4 $343
line 496
;496:		{
line 497
;497:			tf_data.sg_newfind = true;
ADDRGP4 tf_data+108
CNSTI4 1
ASGNI4
line 498
;498:			tf_data.sg_sfire   = SG_SFIRE_MTFL1;
ADDRGP4 tf_data+112
CNSTI4 2
ASGNI4
line 499
;499:		}
LABELV $343
line 501
;500:
;501:		if ( !strcmp( st, "oldf" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $350
ARGP4
ADDRLP4 208
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 208
INDIRI4
CNSTI4 0
NEI4 $348
line 502
;502:		{
line 503
;503:			tf_data.sg_newfind = true;
ADDRGP4 tf_data+108
CNSTI4 1
ASGNI4
line 504
;504:			tf_data.sg_sfire   = SG_SFIRE_281;
ADDRGP4 tf_data+112
CNSTI4 1
ASGNI4
line 505
;505:		}
LABELV $348
line 507
;506:
;507:		GetSVInfokeyString( "sg_newfind", NULL, st, sizeof( st ), "on" );
ADDRGP4 $353
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $145
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 508
;508:		if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $142
ARGP4
ADDRLP4 212
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 0
NEI4 $354
line 509
;509:			tf_data.sg_newfind = false;
ADDRGP4 tf_data+108
CNSTI4 0
ASGNI4
ADDRGP4 $355
JUMPV
LABELV $354
line 511
;510:		else
;511:			tf_data.sg_newfind = true;
ADDRGP4 tf_data+108
CNSTI4 1
ASGNI4
LABELV $355
line 514
;512:
;513:
;514:		GetSVInfokeyString( "sg_sfire", NULL, st, sizeof( st ), "new" );
ADDRGP4 $358
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $327
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 516
;515:
;516:		if( !strcmp(st, "old"))
ADDRLP4 0
ARGP4
ADDRGP4 $330
ARGP4
ADDRLP4 216
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 216
INDIRI4
CNSTI4 0
NEI4 $359
line 517
;517:			tf_data.sg_sfire = SG_SFIRE_281;
ADDRGP4 tf_data+112
CNSTI4 1
ASGNI4
LABELV $359
line 519
;518:
;519:		if( !strcmp(st, "mtfl1"))
ADDRLP4 0
ARGP4
ADDRGP4 $364
ARGP4
ADDRLP4 220
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 220
INDIRI4
CNSTI4 0
NEI4 $362
line 520
;520:			tf_data.sg_sfire = SG_SFIRE_MTFL1;
ADDRGP4 tf_data+112
CNSTI4 2
ASGNI4
LABELV $362
line 522
;521:
;522:		if( !strcmp(st, "mtfl2"))
ADDRLP4 0
ARGP4
ADDRGP4 $368
ARGP4
ADDRLP4 224
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 224
INDIRI4
CNSTI4 0
NEI4 $366
line 523
;523:			tf_data.sg_sfire = SG_SFIRE_MTFL2;
ADDRGP4 tf_data+112
CNSTI4 3
ASGNI4
LABELV $366
line 526
;524:			
;525:
;526:		GetSVInfokeyString( "sg_rfire", NULL, st, sizeof( st ), "old" );
ADDRGP4 $370
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $330
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 528
;527:
;528:		if( !strcmp(st, "new"))
ADDRLP4 0
ARGP4
ADDRGP4 $327
ARGP4
ADDRLP4 228
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 228
INDIRI4
CNSTI4 0
NEI4 $371
line 529
;529:			tf_data.sg_rfire = true;
ADDRGP4 tf_data+116
CNSTI4 1
ASGNI4
ADDRGP4 $372
JUMPV
LABELV $371
line 531
;530:		else
;531:			tf_data.sg_rfire = false;
ADDRGP4 tf_data+116
CNSTI4 0
ASGNI4
LABELV $372
line 533
;532:
;533:		tf_data.sgppl = GetSVInfokeyInt( "sgppl", NULL, 12 );
ADDRGP4 $376
ARGP4
CNSTP4 0
ARGP4
CNSTI4 12
ARGI4
ADDRLP4 232
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRGP4 tf_data+120
ADDRLP4 232
INDIRI4
ASGNI4
line 534
;534:		if ( tf_data.sgppl < 0 )
ADDRGP4 tf_data+120
INDIRI4
CNSTI4 0
GEI4 $377
line 535
;535:			tf_data.sgppl = 0;
ADDRGP4 tf_data+120
CNSTI4 0
ASGNI4
LABELV $377
line 537
;536:
;537:		tf_data.disable_grens = GetSVInfokeyInt( "dg", "disable_grens", 0 );
ADDRGP4 $382
ARGP4
ADDRGP4 $383
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 236
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRGP4 tf_data+100
ADDRLP4 236
INDIRI4
ASGNI4
line 539
;538:
;539:		GetSVInfokeyString( "dtpb", NULL, st, sizeof( st ), "on" );
ADDRGP4 $384
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $145
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 540
;540:		if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $142
ARGP4
ADDRLP4 240
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 240
INDIRI4
CNSTI4 0
NEI4 $385
line 541
;541:			tf_data.detpack_block = 0;
ADDRGP4 tf_data+168
CNSTI4 0
ASGNI4
ADDRGP4 $386
JUMPV
LABELV $385
line 543
;542:		else
;543:			tf_data.detpack_block = 1;
ADDRGP4 tf_data+168
CNSTI4 1
ASGNI4
LABELV $386
line 545
;544:
;545:		GetSVInfokeyString( "dp", "disable_powerups", st, sizeof( st ), "off" );
ADDRGP4 $389
ARGP4
ADDRGP4 $390
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $142
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 546
;546:		if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 244
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 244
INDIRI4
CNSTI4 0
NEI4 $391
line 547
;547:			tf_data.disable_powerups = 1;
ADDRGP4 tf_data+160
CNSTI4 1
ASGNI4
LABELV $391
line 549
;548:
;549:		GetSVInfokeyString( "ft", "flag_timer", st, sizeof( st ), "on" );
ADDRGP4 $394
ARGP4
ADDRGP4 $395
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $145
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 550
;550:		if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 248
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 248
INDIRI4
CNSTI4 0
NEI4 $396
line 551
;551:			tf_data.flag_timer = 1;
ADDRGP4 tf_data+164
CNSTI4 1
ASGNI4
LABELV $396
line 554
;552:
;553:
;554:		tf_data.snip_fps = GetSVInfokeyInt( "sf", "snip_fps", 72 );
ADDRGP4 $400
ARGP4
ADDRGP4 $401
ARGP4
CNSTI4 72
ARGI4
ADDRLP4 252
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRGP4 tf_data+128
ADDRLP4 252
INDIRI4
ASGNI4
line 555
;555:		if ( tf_data.snip_fps < 0 )
ADDRGP4 tf_data+128
INDIRI4
CNSTI4 0
GEI4 $402
line 556
;556:			tf_data.snip_fps = 72;
ADDRGP4 tf_data+128
CNSTI4 72
ASGNI4
LABELV $402
line 558
;557:
;558:		GetSVInfokeyString( "srf", "snip_range_fix", st, sizeof( st ), "off" );
ADDRGP4 $406
ARGP4
ADDRGP4 $407
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $142
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 559
;559:		if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 256
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 256
INDIRI4
CNSTI4 0
NEI4 $408
line 560
;560:			tf_data.snip_range_fix = 1;
ADDRGP4 tf_data+124
CNSTI4 1
ASGNI4
LABELV $408
line 562
;561:
;562:		tf_data.snip_ammo = GetSVInfokeyInt( "snip_ammo", NULL, 1 );
ADDRGP4 $412
ARGP4
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 260
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRGP4 tf_data+132
ADDRLP4 260
INDIRI4
ASGNI4
line 563
;563:		if ( tf_data.snip_ammo < 0 )
ADDRGP4 tf_data+132
INDIRI4
CNSTI4 0
GEI4 $413
line 564
;564:			tf_data.snip_ammo = 1;
ADDRGP4 tf_data+132
CNSTI4 1
ASGNI4
LABELV $413
line 566
;565:
;566:		tf_data.snip_time = GetSVInfokeyFloat( "snip_time", NULL, 1.5 );
ADDRGP4 $418
ARGP4
CNSTP4 0
ARGP4
CNSTF4 1069547520
ARGF4
ADDRLP4 264
ADDRGP4 GetSVInfokeyFloat
CALLF4
ASGNF4
ADDRGP4 tf_data+136
ADDRLP4 264
INDIRF4
ASGNF4
line 567
;567:		if ( tf_data.snip_time < 0 )
ADDRGP4 tf_data+136
INDIRF4
CNSTF4 0
GEF4 $419
line 568
;568:			tf_data.snip_time = 1.5;
ADDRGP4 tf_data+136
CNSTF4 1069547520
ASGNF4
LABELV $419
line 571
;569:
;570:
;571:		tf_data.gren2box = GetSVInfokeyInt( "g2b", NULL, 0 );
ADDRGP4 $424
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 268
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRGP4 tf_data+152
ADDRLP4 268
INDIRI4
ASGNI4
line 572
;572:		if ( tf_data.gren2box < 0 )
ADDRGP4 tf_data+152
INDIRI4
CNSTI4 0
GEI4 $425
line 573
;573:			tf_data.gren2box = 0;
ADDRGP4 tf_data+152
CNSTI4 0
ASGNI4
LABELV $425
line 576
;574:
;575:
;576:		GetSVInfokeyString( "rts", "random_team_spawn", st, sizeof( st ), "on" );
ADDRGP4 $429
ARGP4
ADDRGP4 $430
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $145
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 577
;577:		if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 272
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
NEI4 $431
line 578
;578:			tf_data.random_tf_spawn = 1;
ADDRGP4 tf_data+156
CNSTI4 1
ASGNI4
LABELV $431
line 580
;579:
;580:		GetSVInfokeyString( "lan", NULL, st, sizeof( st ), "off" );
ADDRGP4 $434
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $142
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 581
;581:		if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 276
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 0
NEI4 $435
line 582
;582:			tf_data.lan_mode = 1;
ADDRGP4 tf_data+176
CNSTI4 1
ASGNI4
LABELV $435
line 585
;583:
;584:
;585:		memset( &tg_data, 0, sizeof(tg_data));
ADDRGP4 tg_data
ARGP4
CNSTI4 0
ARGI4
CNSTI4 68
ARGI4
ADDRGP4 memset
CALLP4
pop
line 586
;586:		GetSVInfokeyString( "tg", "training_ground", st, sizeof( st ), "off" );
ADDRGP4 $438
ARGP4
ADDRGP4 $439
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $142
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 587
;587:		if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 280
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
NEI4 $440
line 588
;588:			tg_data.tg_enabled = 1;
ADDRGP4 tg_data
CNSTI4 1
ASGNI4
LABELV $440
line 590
;589:
;590:		GetSVInfokeyString( "enable_bot",NULL, st, sizeof( st ), "off" );
ADDRGP4 $442
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $142
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 591
;591:		if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 284
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 0
NEI4 $443
line 592
;592:			tf_data.enable_bot = 1;
ADDRGP4 tf_data+180
CNSTI4 1
ASGNI4
LABELV $443
line 595
;593:
;594:		// mtf server vars
;595:		GetSVInfokeyString( "coloredlights", "clights", st, sizeof( st ), "on" );
ADDRGP4 $446
ARGP4
ADDRGP4 $447
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $145
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 596
;596:		if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $142
ARGP4
ADDRLP4 288
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
NEI4 $448
line 597
;597:			tf_data.coloredlights = 0;
ADDRGP4 tf_data+192
CNSTI4 0
ASGNI4
ADDRGP4 $449
JUMPV
LABELV $448
line 599
;598:		else
;599:			tf_data.coloredlights = TRUE;
ADDRGP4 tf_data+192
CNSTI4 1
ASGNI4
LABELV $449
line 601
;600:		// join music server toggle
;601:		GetSVInfokeyString( "tf_music", "mu", st, sizeof( st ), "on" );
ADDRGP4 $452
ARGP4
ADDRGP4 $453
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $145
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 602
;602:		if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $142
ARGP4
ADDRLP4 292
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
NEI4 $454
line 603
;603:			tf_data.tf_music = 0;
ADDRGP4 tf_data+196
CNSTI4 0
ASGNI4
ADDRGP4 $455
JUMPV
LABELV $454
line 605
;604:		else
;605:			tf_data.tf_music = TRUE;
ADDRGP4 tf_data+196
CNSTI4 1
ASGNI4
LABELV $455
line 608
;606:
;607:		//footsteps
;608:		GetSVInfokeyString( "footsteps", "fteps", st, sizeof( st ), "on" );
ADDRGP4 $458
ARGP4
ADDRGP4 $459
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $145
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 609
;609:		if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $142
ARGP4
ADDRLP4 296
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 296
INDIRI4
CNSTI4 0
NEI4 $460
line 610
;610:			tf_data.footsteps = 0;
ADDRGP4 tf_data+200
CNSTI4 0
ASGNI4
ADDRGP4 $461
JUMPV
LABELV $460
line 612
;611:		else
;612:			tf_data.footsteps = TRUE;
ADDRGP4 tf_data+200
CNSTI4 1
ASGNI4
LABELV $461
line 619
;613:		//use old (tf2.9) obituary?
;614:		/*GetSVInfokeyString( "old_death", "odeath", st, sizeof( st ), "on" );
;615:		if ( !strcmp( st, "off" ) )
;616:			tf_data.old_dmsg = 0;
;617:		else
;618:			tf_data.old_dmsg = TRUE;*/
;619:		GetSVInfokeyString( "old_death", "odeath", st, sizeof( st ), "off" );
ADDRGP4 $464
ARGP4
ADDRGP4 $465
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $142
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 620
;620:		if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 300
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 300
INDIRI4
CNSTI4 0
NEI4 $466
line 621
;621:			tf_data.old_dmsg = TRUE;
ADDRGP4 tf_data+204
CNSTI4 1
ASGNI4
LABELV $466
line 623
;622:		// enable/disable drops
;623:		GetSVInfokeyString( "drop1", NULL, st, sizeof( st ), "on" );
ADDRGP4 $469
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $145
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 624
;624:		if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $142
ARGP4
ADDRLP4 304
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 304
INDIRI4
CNSTI4 0
NEI4 $470
line 625
;625:			tf_data.drop1 = 0;
ADDRGP4 tf_data+212
CNSTI4 0
ASGNI4
ADDRGP4 $471
JUMPV
LABELV $470
line 627
;626:		else
;627:			tf_data.drop1 = TRUE;
ADDRGP4 tf_data+212
CNSTI4 1
ASGNI4
LABELV $471
line 628
;628:		GetSVInfokeyString( "drop2", NULL, st, sizeof( st ), "on" );
ADDRGP4 $474
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $145
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 629
;629:		if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $142
ARGP4
ADDRLP4 308
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 308
INDIRI4
CNSTI4 0
NEI4 $475
line 630
;630:			tf_data.drop2 = 0;
ADDRGP4 tf_data+216
CNSTI4 0
ASGNI4
ADDRGP4 $476
JUMPV
LABELV $475
line 632
;631:		else
;632:			tf_data.drop2 = TRUE;
ADDRGP4 tf_data+216
CNSTI4 1
ASGNI4
LABELV $476
line 633
;633:		GetSVInfokeyString( "drop3", NULL, st, sizeof( st ), "on" );
ADDRGP4 $479
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $145
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 634
;634:		if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $142
ARGP4
ADDRLP4 312
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 0
NEI4 $480
line 635
;635:			tf_data.drop3 = 0;
ADDRGP4 tf_data+220
CNSTI4 0
ASGNI4
ADDRGP4 $481
JUMPV
LABELV $480
line 637
;636:		else
;637:			tf_data.drop3 = TRUE;
ADDRGP4 tf_data+220
CNSTI4 1
ASGNI4
LABELV $481
line 639
;638:		// airscout/jetpack
;639:		GetSVInfokeyString( "airscout", NULL, st, sizeof( st ), "on" );
ADDRGP4 $484
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $145
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 640
;640:		if ( !strcmp( st, "off" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $142
ARGP4
ADDRLP4 316
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 316
INDIRI4
CNSTI4 0
NEI4 $485
line 641
;641:			tf_data.airscout = 0;
ADDRGP4 tf_data+224
CNSTI4 0
ASGNI4
ADDRGP4 $486
JUMPV
LABELV $485
line 643
;642:		else
;643:			tf_data.airscout = TRUE;
ADDRGP4 tf_data+224
CNSTI4 1
ASGNI4
LABELV $486
line 645
;644:		// old nail gren
;645:		GetSVInfokeyString( "old_nail", "onail", st, sizeof( st ), "off" );
ADDRGP4 $489
ARGP4
ADDRGP4 $490
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $142
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 646
;646:		if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 320
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 320
INDIRI4
CNSTI4 0
NEI4 $491
line 647
;647:			tf_data.old_nail = TRUE;
ADDRGP4 tf_data+228
CNSTI4 1
ASGNI4
LABELV $491
line 649
;648:
;649:		GetSVInfokeyString( "arena",NULL, st, sizeof( st ), "off" );
ADDRGP4 $494
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $142
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 651
;650:
;651:		tf_data.arena_mode = ARENA_MODE_NONE;
ADDRGP4 tf_data+188
CNSTI4 0
ASGNI4
line 652
;652:		if ( !strcmp( st, "ffa" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $498
ARGP4
ADDRLP4 324
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 324
INDIRI4
CNSTI4 0
NEI4 $496
line 653
;653:			tf_data.arena_mode = ARENA_MODE_FFA;
ADDRGP4 tf_data+188
CNSTI4 1
ASGNI4
LABELV $496
line 656
;654://		if ( !strcmp( st, "duel" ) )
;655://			tf_data.arena_mode = ARENA_MODE_DUEL;
;656:                tf_data.botResupplyBetweenKills = (tf_data.arena_mode)?0:1;
ADDRGP4 tf_data+188
INDIRI4
CNSTI4 0
EQI4 $503
ADDRLP4 328
CNSTI4 0
ASGNI4
ADDRGP4 $504
JUMPV
LABELV $503
ADDRLP4 328
CNSTI4 1
ASGNI4
LABELV $504
ADDRGP4 tf_data+184
ADDRLP4 328
INDIRI4
ASGNI4
line 658
;657://////////////
;658:		tf_data.respawn_delay_time = GetSVInfokeyFloat( "rd", "respawn_delay", 0 );
ADDRGP4 $506
ARGP4
ADDRGP4 $507
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 332
ADDRGP4 GetSVInfokeyFloat
CALLF4
ASGNF4
ADDRGP4 tf_data+4
ADDRLP4 332
INDIRF4
ASGNF4
line 660
;659:		
;660:		if ( tf_data.respawn_delay_time )
ADDRGP4 tf_data+4
INDIRF4
CNSTF4 0
EQF4 $508
line 661
;661:			tf_data.toggleflags |= TFLAG_RESPAWNDELAY;
ADDRLP4 336
ADDRGP4 tf_data
ASGNP4
ADDRLP4 336
INDIRP4
ADDRLP4 336
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
LABELV $508
line 663
;662:
;663:		if ( ( tf_data.toggleflags & TFLAG_RESPAWNDELAY ) && !tf_data.respawn_delay_time )
ADDRGP4 tf_data
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $511
ADDRGP4 tf_data+4
INDIRF4
CNSTF4 0
NEF4 $511
line 664
;664:			tf_data.respawn_delay_time = 5;
ADDRGP4 tf_data+4
CNSTF4 1084227584
ASGNF4
LABELV $511
line 666
;665:
;666:		tf_data.pyrotype = GetSVInfokeyInt( "pyrotype", NULL, 0 )?1:0;
ADDRGP4 $516
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 344
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 0
EQI4 $518
ADDRLP4 340
CNSTI4 1
ASGNI4
ADDRGP4 $519
JUMPV
LABELV $518
ADDRLP4 340
CNSTI4 0
ASGNI4
LABELV $519
ADDRGP4 tf_data+148
ADDRLP4 340
INDIRI4
ASGNI4
line 668
;667:
;668:		if ( tf_data.toggleflags & TFLAG_AUTOTEAM )
ADDRGP4 tf_data
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $520
line 669
;669:		{
line 670
;670:			tf_data.toggleflags -= ( tf_data.toggleflags & TFLAG_AUTOTEAM );
ADDRLP4 348
ADDRGP4 tf_data
ASGNP4
ADDRLP4 352
ADDRLP4 348
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 348
INDIRP4
ADDRLP4 352
INDIRI4
ADDRLP4 352
INDIRI4
CNSTI4 64
BANDI4
SUBI4
ASGNI4
line 671
;671:			ent = spawn();
ADDRLP4 356
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 356
INDIRP4
ASGNP4
line 672
;672:			ent->s.v.nextthink = g_globalvars.time + autoteam_time;
ADDRLP4 16
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
line 673
;673:			ent->s.v.think = ( func_t ) autoteam_think;
ADDRLP4 16
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 autoteam_think
CVPU4 4
CVUI4 4
ASGNI4
line 674
;674:		}
LABELV $520
line 676
;675:		
;676:		GetSVInfokeyString( "mtfl", NULL, st, sizeof( st ), "off" );
ADDRGP4 $523
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $142
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 677
;677:		if ( !strcmp( st, "on" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 348
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 348
INDIRI4
CNSTI4 0
NEI4 $524
line 678
;678:		{
line 679
;679:			tf_data.mtfl = 1;
ADDRGP4 tf_data+172
CNSTI4 1
ASGNI4
line 680
;680:			tf_data.allow_hook = 0;
ADDRGP4 tf_data+64
CNSTI4 0
ASGNI4
line 681
;681:			tf_data.old_grens = 1;
ADDRGP4 tf_data+44
CNSTI4 1
ASGNI4
line 682
;682:			tf_data.invis_only = 0;
ADDRGP4 tf_data+60
CNSTI4 0
ASGNI4
line 683
;683:			tf_data.cheat_pause = 1;
ADDRGP4 tf_data+96
CNSTI4 1
ASGNI4
line 684
;684:			tf_data.topcolor_check = 1;
ADDRGP4 tf_data+104
CNSTI4 1
ASGNI4
line 687
;685://                      team_top_colors[1] = 13;
;686://                      team_top_colors[2] = 4;
;687:			tf_data.allow_drop_goal = 0;
ADDRGP4 tf_data+76
CNSTI4 0
ASGNI4
line 688
;688:			tf_data.add_pipe = 1;
ADDRGP4 tf_data+140
CNSTI4 1
ASGNI4
line 689
;689:			tf_data.new_flash = 1;
ADDRGP4 tf_data+48
CNSTI4 1
ASGNI4
line 690
;690:			tf_data.new_gas = GAS_DEFAULT;
ADDRGP4 tf_data+144
CNSTI4 131
ASGNI4
line 692
;691:
;692:			tf_data.sg_newfind = true;
ADDRGP4 tf_data+108
CNSTI4 1
ASGNI4
line 693
;693:			tf_data.sg_sfire = SG_SFIRE_NEW; //FIX ME
ADDRGP4 tf_data+112
CNSTI4 0
ASGNI4
line 694
;694:			tf_data.sg_rfire = 0; //FIX ME
ADDRGP4 tf_data+116
CNSTI4 0
ASGNI4
line 695
;695:			tf_data.sgppl = 12;
ADDRGP4 tf_data+120
CNSTI4 12
ASGNI4
line 696
;696:			tf_data.disable_grens = 0;
ADDRGP4 tf_data+100
CNSTI4 0
ASGNI4
line 698
;697:
;698:			tf_data.detpack_block = 1;
ADDRGP4 tf_data+168
CNSTI4 1
ASGNI4
line 699
;699:			tf_data.disable_powerups = 0;
ADDRGP4 tf_data+160
CNSTI4 0
ASGNI4
line 700
;700:			tf_data.flag_timer = 1;
ADDRGP4 tf_data+164
CNSTI4 1
ASGNI4
line 701
;701:			tf_data.snip_fps = 72;
ADDRGP4 tf_data+128
CNSTI4 72
ASGNI4
line 702
;702:			tf_data.snip_range_fix = 0;
ADDRGP4 tf_data+124
CNSTI4 0
ASGNI4
line 703
;703:			tf_data.snip_ammo = 1;
ADDRGP4 tf_data+132
CNSTI4 1
ASGNI4
line 704
;704:			tf_data.snip_time = 1.5;
ADDRGP4 tf_data+136
CNSTF4 1069547520
ASGNF4
line 705
;705:			tf_data.gren2box = 0;
ADDRGP4 tf_data+152
CNSTI4 0
ASGNI4
line 706
;706:			tf_data.random_tf_spawn = 1;
ADDRGP4 tf_data+156
CNSTI4 1
ASGNI4
line 707
;707:			tf_data.lan_mode = 0;
ADDRGP4 tf_data+176
CNSTI4 0
ASGNI4
line 708
;708:			tf_data.pyrotype = 0;
ADDRGP4 tf_data+148
CNSTI4 0
ASGNI4
line 709
;709:			tg_data.tg_enabled = 0;
ADDRGP4 tg_data
CNSTI4 0
ASGNI4
line 710
;710:			tf_data.enable_bot = 0;
ADDRGP4 tf_data+180
CNSTI4 0
ASGNI4
line 711
;711:			tf_data.arena_mode = ARENA_MODE_NONE;
ADDRGP4 tf_data+188
CNSTI4 0
ASGNI4
line 712
;712:		} else
ADDRGP4 $525
JUMPV
LABELV $524
line 713
;713:			tf_data.mtfl = 0;
ADDRGP4 tf_data+172
CNSTI4 0
ASGNI4
LABELV $525
line 716
;714:
;715://SETUP LAN CONSTANTS
;716:		if( !tf_data.lan_mode ) 
ADDRGP4 tf_data+176
INDIRI4
CNSTI4 0
NEI4 $555
line 717
;717:		{
line 718
;718:			FLAME_MAXWORLDNUM	=20;	 	// maximum number of flames in the world. DO NOT PUT BELOW 20.
ADDRGP4 FLAME_MAXWORLDNUM
CNSTI4 20
ASGNI4
line 719
;719:			MAX_WORLD_PIPEBOMBS	=15;	 	// This is divided between teams - this is the most you should have on a net server
ADDRGP4 MAX_WORLD_PIPEBOMBS
CNSTI4 15
ASGNI4
line 720
;720:			MAX_WORLD_AMMOBOXES	=20;		// This is divided between teams - this is the most you should have on a net server
ADDRGP4 MAX_WORLD_AMMOBOXES
CNSTI4 20
ASGNI4
line 721
;721:			GR_TYPE_MIRV_NO		=4;	 	// Number of Mirvs a Mirv Grenade breaks into
ADDRGP4 GR_TYPE_MIRV_NO
CNSTI4 4
ASGNI4
line 722
;722:			GR_TYPE_NAPALM_NO	=8; 	 	// Number of flames napalm grenade breaks into (unused if net server)
ADDRGP4 GR_TYPE_NAPALM_NO
CNSTI4 8
ASGNI4
line 723
;723:		}else
ADDRGP4 $556
JUMPV
LABELV $555
line 724
;724:		{
line 725
;725:			FLAME_MAXWORLDNUM	=60;	 	// maximum number of flames in the world. DO NOT PUT BELOW 20.
ADDRGP4 FLAME_MAXWORLDNUM
CNSTI4 60
ASGNI4
line 726
;726:			MAX_WORLD_PIPEBOMBS	=30;	 	// This is divided between teams - this is the most you should have on a net server
ADDRGP4 MAX_WORLD_PIPEBOMBS
CNSTI4 30
ASGNI4
line 727
;727:			MAX_WORLD_AMMOBOXES	=20;		// This is divided between teams - this is the most you should have on a net server
ADDRGP4 MAX_WORLD_AMMOBOXES
CNSTI4 20
ASGNI4
line 728
;728:			GR_TYPE_MIRV_NO		=12;	 	// Number of Mirvs a Mirv Grenade breaks into
ADDRGP4 GR_TYPE_MIRV_NO
CNSTI4 12
ASGNI4
line 729
;729:			GR_TYPE_NAPALM_NO	=12; 	 	// Number of flames napalm grenade breaks into (unused if net server)
ADDRGP4 GR_TYPE_NAPALM_NO
CNSTI4 12
ASGNI4
line 730
;730:		}
LABELV $556
line 731
;731:                if( tg_data.tg_enabled )
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $558
line 732
;732:			TG_LoadSettings();
ADDRGP4 TG_LoadSettings
CALLV
pop
ADDRGP4 $559
JUMPV
LABELV $558
line 734
;733:                else
;734:                {
line 735
;735:                        tg_data.godmode = 0;
ADDRGP4 tg_data+4
CNSTI4 0
ASGNI4
line 736
;736:                        tg_data.unlimit_ammo = 0;
ADDRGP4 tg_data+8
CNSTI4 0
ASGNI4
line 737
;737:                        tg_data.unlimit_grens = 0;
ADDRGP4 tg_data+12
CNSTI4 0
ASGNI4
line 738
;738:                        tg_data.disable_reload = 0;
ADDRGP4 tg_data+16
CNSTI4 0
ASGNI4
line 739
;739:                        tg_data.detpack_clip = TG_DETPACK_CLIP_OWNER;
ADDRGP4 tg_data+20
CNSTI4 0
ASGNI4
line 740
;740:                        tg_data.detpack_drop = 0;   // 1 can drop, 0 - cannot
ADDRGP4 tg_data+24
CNSTI4 0
ASGNI4
line 741
;741:                        tg_data.disable_disarm = 0; // 0 normal, 1 - disable
ADDRGP4 tg_data+28
CNSTI4 0
ASGNI4
line 742
;742:                        tg_data.gren_effect = 0;    //0 -default, 1 - off for all, 2 off for self
ADDRGP4 tg_data+32
CNSTI4 0
ASGNI4
line 743
;743:                        tg_data.gren_time = 0;      //0 -full time , 10 ,5 in sek
ADDRGP4 tg_data+36
CNSTI4 0
ASGNI4
line 745
;744:
;745:                        tg_data.sg_allow_find = TG_SG_FIND_IGNORE_TEAM;
ADDRGP4 tg_data+40
CNSTI4 0
ASGNI4
line 746
;746:                        tg_data.sg_disable_fire = 0;
ADDRGP4 tg_data+44
CNSTI4 0
ASGNI4
line 747
;747:                        tg_data.sg_fire_bullets = true;
ADDRGP4 tg_data+48
CNSTI4 1
ASGNI4
line 748
;748:                        tg_data.sg_fire_rockets = true;
ADDRGP4 tg_data+52
CNSTI4 1
ASGNI4
line 749
;749:                        tg_data.sg_fire_lighting = false;
ADDRGP4 tg_data+56
CNSTI4 0
ASGNI4
line 750
;750:                        tg_data.sg_unlimit_ammo = false;
ADDRGP4 tg_data+60
CNSTI4 0
ASGNI4
line 751
;751:                        tg_data.tg_sbar = 0;
ADDRGP4 tg_data+64
CNSTI4 0
ASGNI4
line 752
;752:                }
LABELV $559
line 753
;753:		if( tf_data.enable_bot )
ADDRGP4 tf_data+180
INDIRI4
CNSTI4 0
EQI4 $576
line 754
;754:		        localcmd( "exec maps/%s.wps\n", g_globalvars.mapname );
ADDRGP4 $579
ARGP4
ADDRGP4 g_globalvars+140
INDIRP4
ARGP4
ADDRGP4 localcmd
CALLV
pop
LABELV $576
line 755
;755:	}
LABELV $82
line 756
;756:}
LABELV $58
endproc DecodeLevelParms 360 20
export FindIntermission
proc FindIntermission 32 12
line 766
;757:
;758:/*
;759:============
;760:FindIntermission
;761:
;762:Returns the entity to view from
;763:============
;764:*/
;765:gedict_t *FindIntermission()
;766:{
line 771
;767:	gedict_t *spot;
;768:	int     cyc;
;769:
;770:// look for info_intermission first
;771:	spot = trap_find( world, FOFS( s.v.classname ), "info_intermission" );
ADDRGP4 world
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
line 772
;772:	if ( spot )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $583
line 773
;773:	{			// pick a random one
line 774
;774:		cyc = g_random() * 1;
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 4
CNSTF4 1065353216
ADDRLP4 12
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 782
;775:/*		while ( cyc > 1 )
;776:		{
;777:			spot = trap_find( spot, FOFS( s.v.classname ), "info_intermission" );
;778:			if ( !spot )
;779:				spot = trap_find( world, FOFS( s.v.classname ), "info_intermission" );
;780:			cyc = cyc - 1;
;781:		}*/
;782:		return spot;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $581
JUMPV
LABELV $583
line 785
;783:	}
;784:// then look for the start position
;785:	spot = trap_find( world, FOFS( s.v.classname ), "info_player_start" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $585
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 786
;786:	if ( spot )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $586
line 787
;787:		return spot;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $581
JUMPV
LABELV $586
line 789
;788:// look for deathmatch
;789:	spot = trap_find( world, FOFS( s.v.classname ), "info_player_deathmatch" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $588
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 790
;790:	if ( spot )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $589
line 791
;791:	{			// pick a random one
line 792
;792:		cyc = g_random() * 7;
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 4
CNSTF4 1088421888
ADDRLP4 20
INDIRF4
MULF4
CVFI4 4
ASGNI4
ADDRGP4 $592
JUMPV
LABELV $591
line 794
;793:		while ( cyc > 1 )
;794:		{
line 795
;795:			spot = trap_find( spot, FOFS( s.v.classname ), "info_player_deathmatch" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $588
ARGP4
ADDRLP4 24
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 796
;796:			if ( !spot )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $594
line 797
;797:				spot = trap_find( world, FOFS( s.v.classname ), "info_player_deathmatch" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $588
ARGP4
ADDRLP4 28
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
LABELV $594
line 798
;798:			cyc = cyc - 1;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 799
;799:		}
LABELV $592
line 793
ADDRLP4 4
INDIRI4
CNSTI4 1
GTI4 $591
line 800
;800:		return spot;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $581
JUMPV
LABELV $589
line 803
;801:	}
;802:
;803:	G_Error( "FindIntermission: no spot" );
ADDRGP4 $596
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 804
;804:	return NULL;
CNSTP4 0
RETP4
LABELV $581
endproc FindIntermission 32 12
export FindNextIntermission
proc FindNextIntermission 28 12
line 809
;805:}
;806:
;807:
;808:gedict_t *FindNextIntermission( gedict_t * start_point )
;809:{
line 814
;810:	gedict_t *spot;
;811:
;812://      float   cyc;
;813:
;814:	if ( deathmatch )
ADDRGP4 deathmatch
INDIRI4
CNSTI4 0
EQI4 $598
line 815
;815:	{
line 816
;816:		if ( streq( start_point->s.v.classname, "info_intermission" ) || start_point == world || !start_point )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $582
ARGP4
ADDRLP4 4
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $603
ADDRLP4 8
ADDRFP4 0
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 8
INDIRU4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $603
ADDRLP4 8
INDIRU4
CNSTU4 0
NEU4 $600
LABELV $603
line 817
;817:		{
line 818
;818:			spot = trap_find( start_point, FOFS( s.v.classname ), "info_intermission" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $582
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 819
;819:			if ( spot )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $604
line 820
;820:				return spot;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $597
JUMPV
LABELV $604
line 822
;821:			else
;822:				start_point = world;
ADDRFP4 0
ADDRGP4 world
INDIRP4
ASGNP4
line 823
;823:		}
LABELV $600
line 824
;824:		if ( streq( start_point->s.v.classname, "info_player_deathmatch" )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $588
ARGP4
ADDRLP4 12
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $609
ADDRLP4 16
ADDRFP4 0
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 16
INDIRU4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $609
ADDRLP4 16
INDIRU4
CNSTU4 0
NEU4 $606
LABELV $609
line 826
;825:		     || start_point == world || !start_point )
;826:		{
line 827
;827:			spot = trap_find( start_point, FOFS( s.v.classname ), "info_player_deathmatch" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $588
ARGP4
ADDRLP4 20
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 828
;828:			if ( spot )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $610
line 829
;829:				return spot;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $597
JUMPV
LABELV $610
line 830
;830:		}
LABELV $606
line 831
;831:		spot = trap_find( world, FOFS( s.v.classname ), "info_intermission" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $582
ARGP4
ADDRLP4 20
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 832
;832:		if ( spot )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $612
line 833
;833:			return spot;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $597
JUMPV
LABELV $612
line 834
;834:		spot = trap_find( world, FOFS( s.v.classname ), "info_player_deathmatch" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $588
ARGP4
ADDRLP4 24
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 835
;835:		if ( spot )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $599
line 836
;836:			return spot;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $597
JUMPV
line 837
;837:	} else
LABELV $598
line 838
;838:	{
line 839
;839:		spot = trap_find( world, FOFS( s.v.classname ), "info_player_start" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $585
ARGP4
ADDRLP4 4
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 840
;840:		if ( spot )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $616
line 841
;841:			return spot;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $597
JUMPV
LABELV $616
line 842
;842:	}
LABELV $599
line 843
;843:	return FindIntermission();
ADDRLP4 4
ADDRGP4 FindIntermission
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
RETP4
LABELV $597
endproc FindNextIntermission 28 12
export TF_MovePlayer
proc TF_MovePlayer 24 16
line 847
;844:}
;845:
;846:void TF_MovePlayer()
;847:{
line 850
;848:	gedict_t *place;
;849:
;850:	place = FindNextIntermission( self->observer_list );
ADDRGP4 self
INDIRP4
CNSTI4 900
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 FindNextIntermission
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 851
;851:	self->observer_list = place;
ADDRGP4 self
INDIRP4
CNSTI4 900
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 852
;852:	setorigin( self, place->s.v.origin[0], place->s.v.origin[1], place->s.v.origin[2] + 1 );
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
CNSTF4 1065353216
ADDF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 853
;853:	VectorCopy( place->s.v.angles, self->s.v.angles );
ADDRLP4 12
CNSTI4 192
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 16
CNSTI4 196
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20
CNSTI4 200
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
INDIRF4
ASGNF4
line 854
;854:	self->s.v.fixangle = 1;
ADDRGP4 self
INDIRP4
CNSTI4 380
ADDP4
CNSTF4 1065353216
ASGNF4
line 855
;855:}
LABELV $618
endproc TF_MovePlayer 24 16
data
align 4
LABELV $620
byte 4 0
export GotoNextMap
code
proc GotoNextMap 80 20
line 858
;856:
;857:void GotoNextMap()
;858:{
line 865
;859:	int     nextlevel;
;860:	char    str[64];
;861:	static  int map_try_change = 0;
;862:
;863://      gedict_t *te;
;864:
;865:	if ( Q_strncmp( nextmap, g_globalvars.mapname, sizeof(nextmap) ) )
ADDRGP4 nextmap
ARGP4
ADDRGP4 g_globalvars+140
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 68
ADDRGP4 Q_strncmp
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $621
line 866
;866:	{
line 867
;867:		trap_changelevel( nextmap );
ADDRGP4 nextmap
ARGP4
ADDRGP4 trap_changelevel
CALLV
pop
line 868
;868:		tf_data.already_chosen_map = 1;
ADDRGP4 tf_data+12
CNSTI4 1
ASGNI4
line 869
;869:	}
LABELV $621
line 870
;870:	if ( GetSVInfokeyString( g_globalvars.mapname, NULL, str, sizeof( str ), "" ) )
ADDRGP4 g_globalvars+140
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $205
ARGP4
ADDRLP4 72
ADDRGP4 GetSVInfokeyString
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $625
line 871
;871:	{
line 872
;872:		strncpy( nextmap, str, sizeof(nextmap) );
ADDRGP4 nextmap
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 873
;873:		tf_data.already_chosen_map = 1;
ADDRGP4 tf_data+12
CNSTI4 1
ASGNI4
line 874
;874:		return;
ADDRGP4 $619
JUMPV
LABELV $625
line 877
;875:	}
;876:
;877:	if ( !tf_data.already_chosen_map )
ADDRGP4 tf_data+12
INDIRI4
CNSTI4 0
NEI4 $629
line 878
;878:	{
line 879
;879:		nextlevel = GetSVInfokeyInt( "n", NULL, 0 );
ADDRGP4 $632
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 76
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRLP4 64
ADDRLP4 76
INDIRI4
ASGNI4
line 880
;880:		nextlevel++;
ADDRLP4 64
ADDRLP4 64
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 882
;881:
;882:		localcmd( "serverinfo n %d\n", nextlevel );
ADDRGP4 $633
ARGP4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 localcmd
CALLV
pop
line 883
;883:		GetSVInfokeyString( "cd", "cycledir", str, sizeof( str ), "qwmcycle" );
ADDRGP4 $634
ARGP4
ADDRGP4 $635
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $636
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 884
;884:		localcmd( "exec %s/map%d.cfg", str, nextlevel );
ADDRGP4 $637
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 localcmd
CALLV
pop
line 885
;885:		tf_data.already_chosen_map = 1;
ADDRGP4 tf_data+12
CNSTI4 1
ASGNI4
line 886
;886:	}
LABELV $629
line 887
;887:	if ( GetSVInfokeyInt( "n", NULL, 0 ) == 0 )
ADDRGP4 $632
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 76
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $639
line 888
;888:		tf_data.already_chosen_map = 0;
ADDRGP4 tf_data+12
CNSTI4 0
ASGNI4
LABELV $639
line 889
;889:}
LABELV $619
endproc GotoNextMap 80 20
export ExitIntermission
proc ExitIntermission 24 8
line 892
;890:
;891:void ExitIntermission()
;892:{
line 893
;893:	G_conprintf( "Exiting intermission...\n" );
ADDRGP4 $643
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
line 894
;894:	if ( deathmatch )
ADDRGP4 deathmatch
INDIRI4
CNSTI4 0
EQI4 $644
line 895
;895:	{
line 896
;896:		G_conprintf( "Exit Intermission in Deathmatch.\n" );
ADDRGP4 $646
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
line 897
;897:		GotoNextMap();
ADDRGP4 GotoNextMap
CALLV
pop
line 898
;898:		return;
ADDRGP4 $642
JUMPV
LABELV $644
line 900
;899:	}
;900:	intermission_exittime = g_globalvars.time + 1;
ADDRGP4 intermission_exittime
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 901
;901:	intermission_running += 1;
ADDRLP4 0
ADDRGP4 intermission_running
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 902
;902:	if ( intermission_running == 2 )
ADDRGP4 intermission_running
INDIRF4
CNSTF4 1073741824
NEF4 $648
line 903
;903:	{
line 904
;904:		if ( !strcmp( world->s.v.model, "maps/e1m7.bsp" ) )
ADDRGP4 world
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ARGP4
ADDRGP4 $652
ARGP4
ADDRLP4 4
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $650
line 905
;905:		{
line 906
;906:			trap_WriteByte( MSG_ALL, SVC_CDTRACK );
CNSTI4 2
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 907
;907:			trap_WriteByte( MSG_ALL, 2 );
ADDRLP4 8
CNSTI4 2
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 908
;908:			trap_WriteByte( MSG_ALL, 3 );
CNSTI4 2
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 909
;909:			if ( !trap_cvar( "registered" ) )
ADDRGP4 $655
ARGP4
ADDRLP4 12
ADDRGP4 trap_cvar
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
CNSTF4 0
NEF4 $653
line 910
;910:			{
line 911
;911:				trap_WriteByte( MSG_ALL, SVC_FINALE );
CNSTI4 2
ARGI4
CNSTI4 31
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 912
;912:				trap_WriteString( MSG_ALL,
CNSTI4 2
ARGI4
ADDRGP4 $656
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 914
;913:						  "As the corpse of the monstrous entity\nChthon sinks back into the lava whence\nit rose, you grip the Rune of Earth\nMagic tightly. Now that you have\nconquered the Dimension of the Doomed,\nrealm of Earth Magic, you are ready to\ncomplete your task in the other three\nhaunted lands of Quake. Or are you? If\nyou don't register Quake, you'll never\nknow what awaits you in the Realm of\nBlack Magic, the Netherworld, and the\nElder World!" );
;914:			} else
ADDRGP4 $642
JUMPV
LABELV $653
line 915
;915:			{
line 916
;916:				trap_WriteByte( MSG_ALL, SVC_FINALE );
CNSTI4 2
ARGI4
CNSTI4 31
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 917
;917:				trap_WriteString( MSG_ALL,
CNSTI4 2
ARGI4
ADDRGP4 $657
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 919
;918:						  "As the corpse of the monstrous entity\nChthon sinks back into the lava whence\nit rose, you grip the Rune of Earth\nMagic tightly. Now that you have\nconquered the Dimension of the Doomed,\nrealm of Earth Magic, you are ready to\ncomplete your task. A Rune of magic\npower lies at the end of each haunted\nland of Quake. Go forth, seek the\ntotality of the four Runes!" );
;919:			}
line 920
;920:			return;
ADDRGP4 $642
JUMPV
LABELV $650
line 922
;921:		} else
;922:		{
line 923
;923:			if ( !strcmp( world->s.v.model, "maps/e2m6.bsp" ) )
ADDRGP4 world
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ARGP4
ADDRGP4 $660
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $658
line 924
;924:			{
line 925
;925:				trap_WriteByte( MSG_ALL, SVC_CDTRACK );
CNSTI4 2
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 926
;926:				trap_WriteByte( MSG_ALL, 2 );
ADDRLP4 12
CNSTI4 2
ASGNI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 927
;927:				trap_WriteByte( MSG_ALL, 3 );
CNSTI4 2
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 928
;928:				trap_WriteByte( MSG_ALL, SVC_FINALE );
CNSTI4 2
ARGI4
CNSTI4 31
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 929
;929:				trap_WriteString( MSG_ALL,
CNSTI4 2
ARGI4
ADDRGP4 $661
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 931
;930:						  "The Rune of Black Magic throbs evilly in\nyour hand and whispers dark thoughts\ninto your brain. You learn the inmost\nlore of the Hell-Mother; Shub-Niggurath!\nYou now know that she is behind all the\nterrible plotting which has led to so\nmuch death and horror. But she is not\ninviolate! Armed with this Rune, you\nrealize that once all four Runes are\ncombined, the gate to Shub-Niggurath's\nPit will open, and you can face the\nWitch-Goddess herself in her frightful\notherworld cathedral." );
;931:				return;
ADDRGP4 $642
JUMPV
LABELV $658
line 933
;932:			} else
;933:			{
line 934
;934:				if ( !strcmp( world->s.v.model, "maps/e3m6.bsp" ) )
ADDRGP4 world
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ARGP4
ADDRGP4 $664
ARGP4
ADDRLP4 12
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $662
line 935
;935:				{
line 936
;936:					trap_WriteByte( MSG_ALL, SVC_CDTRACK );
CNSTI4 2
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 937
;937:					trap_WriteByte( MSG_ALL, 2 );
ADDRLP4 16
CNSTI4 2
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
line 938
;938:					trap_WriteByte( MSG_ALL, 3 );
CNSTI4 2
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 939
;939:					trap_WriteByte( MSG_ALL, SVC_FINALE );
CNSTI4 2
ARGI4
CNSTI4 31
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 940
;940:					trap_WriteString( MSG_ALL,
CNSTI4 2
ARGI4
ADDRGP4 $665
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 942
;941:							  "The charred viscera of diabolic horrors\nbubble viscously as you seize the Rune\nof Hell Magic. Its heat scorches your\nhand, and its terrible secrets blight\nyour mind. Gathering the shreds of your\ncourage, you shake the devil's shackles\nfrom your soul, and become ever more\nhard and determined to destroy the\nhideous creatures whose mere existence\nthreatens the souls and psyches of all\nthe population of Earth." );
;942:					return;
ADDRGP4 $642
JUMPV
LABELV $662
line 944
;943:				} else
;944:				{
line 945
;945:					if ( !strcmp( world->s.v.model, "maps/e4m7.bsp" ) )
ADDRGP4 world
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ARGP4
ADDRGP4 $668
ARGP4
ADDRLP4 16
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $666
line 946
;946:					{
line 947
;947:						trap_WriteByte( MSG_ALL, SVC_CDTRACK );
CNSTI4 2
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 948
;948:						trap_WriteByte( MSG_ALL, 2 );
ADDRLP4 20
CNSTI4 2
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 949
;949:						trap_WriteByte( MSG_ALL, 3 );
CNSTI4 2
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 950
;950:						trap_WriteByte( MSG_ALL, SVC_FINALE );
CNSTI4 2
ARGI4
CNSTI4 31
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 951
;951:						trap_WriteString( MSG_ALL,
CNSTI4 2
ARGI4
ADDRGP4 $669
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 953
;952:								  "Despite the awful might of the Elder\nWorld, you have achieved the Rune of\nElder Magic, capstone of all types of\narcane wisdom. Beyond good and evil,\nbeyond life and death, the Rune\npulsates, heavy with import. Patient and\npotent, the Elder Being Shub-Niggurath\nweaves her dire plans to clear off all\nlife from the Earth, and bring her own\nfoul offspring to our world! For all the\ndwellers in these nightmare dimensions\nare her descendants! Once all Runes of\nmagic power are united, the energy\nbehind them will blast open the Gateway\nto Shub-Niggurath, and you can travel\nthere to foil the Hell-Mother's plots\nin person." );
;953:						return;
ADDRGP4 $642
JUMPV
LABELV $666
line 955
;954:					}
;955:				}
line 956
;956:			}
line 957
;957:		}
line 958
;958:		GotoNextMap();
ADDRGP4 GotoNextMap
CALLV
pop
line 959
;959:	}
LABELV $648
line 960
;960:	if ( intermission_running == 3 )
ADDRGP4 intermission_running
INDIRF4
CNSTF4 1077936128
NEF4 $670
line 961
;961:	{
line 962
;962:		if ( !trap_cvar( "registered" ) )
ADDRGP4 $655
ARGP4
ADDRLP4 4
ADDRGP4 trap_cvar
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $672
line 963
;963:		{
line 964
;964:			trap_WriteByte( MSG_ALL, SVC_SELLSCREEN );
CNSTI4 2
ARGI4
CNSTI4 33
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 965
;965:			return;
ADDRGP4 $642
JUMPV
LABELV $672
line 967
;966:		}
;967:		if ( ( ( int ) ( g_globalvars.serverflags ) & 15 ) == 15 )
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
NEI4 $674
line 968
;968:		{
line 969
;969:			trap_WriteByte( MSG_ALL, SVC_FINALE );
CNSTI4 2
ARGI4
CNSTI4 31
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 970
;970:			trap_WriteString( MSG_ALL,
CNSTI4 2
ARGI4
ADDRGP4 $677
ARGP4
ADDRGP4 trap_WriteString
CALLV
pop
line 972
;971:					  "Now, you have all four Runes. You sense\ntremendous invisible forces moving to\nunseal ancient barriers. Shub-Niggurath\nhad hoped to use the Runes Herself to\nclear off the Earth, but now instead,\nyou will use them to enter her home and\nconfront her as an avatar of avenging\nEarth-life. If you defeat her, you will\nbe remembered forever as the savior of\nthe planet. If she conquers, it will be\nas if you had never been born." );
;972:			return;
ADDRGP4 $642
JUMPV
LABELV $674
line 974
;973:		}
;974:	}
LABELV $670
line 975
;975:	G_conprintf( "Exit Intermission.\n" );
ADDRGP4 $678
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
line 976
;976:	GotoNextMap();
ADDRGP4 GotoNextMap
CALLV
pop
line 977
;977:}
LABELV $642
endproc ExitIntermission 24 8
export IntermissionThink
proc IntermissionThink 168 20
line 980
;978:
;979:void IntermissionThink()
;980:{
line 986
;981:	int     minp;
;982:	int     maxp;
;983:	int     currp;
;984:	char    sl[64], str[64];
;985:
;986:	if ( g_globalvars.time < intermission_exittime )
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 intermission_exittime
INDIRF4
GEF4 $680
line 987
;987:		return;
ADDRGP4 $679
JUMPV
LABELV $680
line 989
;988:
;989:	if ( !self->s.v.button0 && !self->s.v.button1 && !self->s.v.button2 )
ADDRLP4 140
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 144
CNSTF4 0
ASGNF4
ADDRLP4 140
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
ADDRLP4 144
INDIRF4
NEF4 $683
ADDRLP4 140
INDIRP4
CNSTI4 368
ADDP4
INDIRF4
ADDRLP4 144
INDIRF4
NEF4 $683
ADDRLP4 140
INDIRP4
CNSTI4 372
ADDP4
INDIRF4
ADDRLP4 144
INDIRF4
NEF4 $683
line 990
;990:		return;
ADDRGP4 $679
JUMPV
LABELV $683
line 993
;991:
;992:
;993:	G_conprintf( "Intermission think.\n" );
ADDRGP4 $685
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
line 994
;994:	GotoNextMap();
ADDRGP4 GotoNextMap
CALLV
pop
line 996
;995:
;996:	if ( GetSVInfokeyString( "nmap", NULL, sl, sizeof( sl ), "" ) )
ADDRGP4 $688
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $205
ARGP4
ADDRLP4 148
ADDRGP4 GetSVInfokeyString
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $686
line 997
;997:	{
line 998
;998:		minp = GetSVInfokeyInt( "minp", NULL, 0 );
ADDRGP4 $689
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 152
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRLP4 68
ADDRLP4 152
INDIRI4
ASGNI4
line 999
;999:		maxp = GetSVInfokeyInt( "maxp", NULL, 0 );
ADDRGP4 $690
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 156
ADDRGP4 GetSVInfokeyInt
CALLI4
ASGNI4
ADDRLP4 72
ADDRLP4 156
INDIRI4
ASGNI4
line 1000
;1000:		currp = TeamFortress_GetNoPlayers();
ADDRLP4 160
ADDRGP4 TeamFortress_GetNoPlayers
CALLI4
ASGNI4
ADDRLP4 64
ADDRLP4 160
INDIRI4
ASGNI4
line 1001
;1001:		G_dprintf( "MAP CYCLING: Player Counting... " );
ADDRGP4 $691
ARGP4
ADDRGP4 G_dprintf
CALLV
pop
line 1002
;1002:		if ( currp >= minp && currp <= maxp )
ADDRLP4 164
ADDRLP4 64
INDIRI4
ASGNI4
ADDRLP4 164
INDIRI4
ADDRLP4 68
INDIRI4
LTI4 $692
ADDRLP4 164
INDIRI4
ADDRLP4 72
INDIRI4
GTI4 $692
line 1003
;1003:		{
line 1004
;1004:			G_dprintf( "within range. Changing maps...\n" );
ADDRGP4 $694
ARGP4
ADDRGP4 G_dprintf
CALLV
pop
line 1006
;1005:
;1006:			GetSVInfokeyString( "cd", "cycledir", str, sizeof( str ), "qwmcycle" );
ADDRGP4 $634
ARGP4
ADDRGP4 $635
ARGP4
ADDRLP4 76
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $636
ARGP4
ADDRGP4 GetSVInfokeyString
CALLI4
pop
line 1007
;1007:			localcmd( "exec %s/%s.cfg", str, sl );
ADDRGP4 $695
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 1008
;1008:		} else
ADDRGP4 $693
JUMPV
LABELV $692
line 1009
;1009:		{
line 1010
;1010:			G_dprintf( "outside range. Next map.\n" );
ADDRGP4 $696
ARGP4
ADDRGP4 G_dprintf
CALLV
pop
line 1011
;1011:			tf_data.already_chosen_map = 0;
ADDRGP4 tf_data+12
CNSTI4 0
ASGNI4
line 1012
;1012:		}
LABELV $693
line 1013
;1013:		localcmd( "localinfo minp \"\"\n" );
ADDRGP4 $698
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 1014
;1014:		localcmd( "localinfo maxp \"\"\n" );
ADDRGP4 $699
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 1015
;1015:		localcmd( "localinfo nmap \"\"\n" );
ADDRGP4 $700
ARGP4
ADDRGP4 localcmd
CALLV
pop
line 1016
;1016:	}
LABELV $686
line 1017
;1017:}
LABELV $679
endproc IntermissionThink 168 20
export execute_changelevel
proc execute_changelevel 20 12
line 1020
;1018:
;1019:void execute_changelevel()
;1020:{
line 1023
;1021:	gedict_t *pos;
;1022:
;1023:	G_conprintf( "execute_changelevel()\n" );
ADDRGP4 $702
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
line 1025
;1024:
;1025:	intermission_running = 1;
ADDRGP4 intermission_running
CNSTF4 1065353216
ASGNF4
line 1028
;1026:
;1027:// enforce a wait time before allowing changelevel
;1028:	intermission_exittime = g_globalvars.time + 5;
ADDRGP4 intermission_exittime
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 1030
;1029:
;1030:	pos = FindIntermission();
ADDRLP4 4
ADDRGP4 FindIntermission
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1033
;1031:
;1032:// play intermission music
;1033:	trap_WriteByte( MSG_ALL, SVC_CDTRACK );
CNSTI4 2
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1034
;1034:	trap_WriteByte( MSG_ALL, 3 );
CNSTI4 2
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1036
;1035:
;1036:	trap_WriteByte( MSG_ALL, SVC_INTERMISSION );
CNSTI4 2
ARGI4
CNSTI4 30
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 1037
;1037:	trap_WriteCoord( MSG_ALL, pos->s.v.origin[0] );
CNSTI4 2
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
line 1038
;1038:	trap_WriteCoord( MSG_ALL, pos->s.v.origin[1] );
CNSTI4 2
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
line 1039
;1039:	trap_WriteCoord( MSG_ALL, pos->s.v.origin[2] );
CNSTI4 2
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
line 1040
;1040:	trap_WriteAngle( MSG_ALL, pos->mangle[0] );
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteAngle
CALLV
pop
line 1041
;1041:	trap_WriteAngle( MSG_ALL, pos->mangle[1] );
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteAngle
CALLV
pop
line 1042
;1042:	trap_WriteAngle( MSG_ALL, pos->mangle[2] );
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 644
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_WriteAngle
CALLV
pop
line 1043
;1043:	other = trap_find( world, FOFS( s.v.classname ), "player" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $190
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRGP4 other
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $705
JUMPV
LABELV $704
line 1045
;1044:	while ( other )
;1045:	{
line 1046
;1046:		other->s.v.takedamage = DAMAGE_NO;
ADDRGP4 other
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 0
ASGNF4
line 1047
;1047:		other->s.v.solid = SOLID_NOT;
ADDRGP4 other
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 1048
;1048:		other->s.v.movetype = MOVETYPE_NONE;
ADDRGP4 other
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 1049
;1049:		other->s.v.modelindex = 0;
ADDRGP4 other
INDIRP4
CNSTI4 112
ADDP4
CNSTF4 0
ASGNF4
line 1050
;1050:		other = trap_find( other, FOFS( s.v.classname ), "player" );
ADDRLP4 12
ADDRGP4 other
ASGNP4
ADDRLP4 12
INDIRP4
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $190
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 16
INDIRP4
ASGNP4
line 1051
;1051:	}
LABELV $705
line 1044
ADDRGP4 other
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $704
line 1053
;1052:
;1053:	if ( !tf_data.clan_scores_dumped )
ADDRGP4 tf_data+20
INDIRF4
CNSTF4 0
NEF4 $707
line 1054
;1054:	{
line 1055
;1055:		DumpClanScores();
ADDRGP4 DumpClanScores
CALLV
pop
line 1056
;1056:		tf_data.clan_scores_dumped = 1;
ADDRGP4 tf_data+20
CNSTF4 1065353216
ASGNF4
line 1057
;1057:	}
LABELV $707
line 1058
;1058:}
LABELV $701
endproc execute_changelevel 20 12
export changelevel_touch
proc changelevel_touch 20 12
line 1061
;1059:
;1060:void changelevel_touch()
;1061:{
line 1062
;1062:	if ( strneq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $190
ARGP4
ADDRLP4 0
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $712
line 1063
;1063:		return;
ADDRGP4 $711
JUMPV
LABELV $712
line 1065
;1064:
;1065:	if ( ( trap_cvar( "samelevel" ) == 2 )
ADDRGP4 $716
ARGP4
ADDRLP4 4
ADDRGP4 trap_cvar
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 1073741824
EQF4 $719
ADDRGP4 $716
ARGP4
ADDRLP4 8
ADDRGP4 trap_cvar
CALLF4
ASGNF4
ADDRLP4 8
INDIRF4
CNSTF4 1077936128
NEF4 $714
ADDRGP4 g_globalvars+140
INDIRP4
ARGP4
ADDRGP4 $718
ARGP4
ADDRLP4 12
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $714
LABELV $719
line 1067
;1066:	     || ( ( trap_cvar( "samelevel" ) == 3 ) && ( strneq( g_globalvars.mapname, "start" ) ) ) )
;1067:	{
line 1068
;1068:		return;
ADDRGP4 $711
JUMPV
LABELV $714
line 1071
;1069:	}
;1070:
;1071:	G_bprint( PRINT_HIGH, "%s exited the level\n", other->s.v.netname );
CNSTI4 2
ARGI4
ADDRGP4 $720
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
line 1072
;1072:	Q_strncpyz( nextmap, self->map, sizeof(nextmap) );
ADDRGP4 nextmap
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 540
ADDP4
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1074
;1073:
;1074:	SUB_UseTargets();
ADDRGP4 SUB_UseTargets
CALLV
pop
line 1076
;1075:
;1076:	if ( ( ( int ) ( self->s.v.spawnflags ) & 1 ) && !deathmatch )
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
BANDI4
ADDRLP4 16
INDIRI4
EQI4 $721
ADDRGP4 deathmatch
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $721
line 1077
;1077:	{
line 1078
;1078:		GotoNextMap();
ADDRGP4 GotoNextMap
CALLV
pop
line 1079
;1079:		return;
ADDRGP4 $711
JUMPV
LABELV $721
line 1081
;1080:	}
;1081:	self->s.v.touch = ( func_t ) SUB_Null;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 SUB_Null
CVPU4 4
CVUI4 4
ASGNI4
line 1085
;1082:
;1083:// we can't move people right now, because touch functions are called
;1084:// in the middle of C movement code, so set a think g_globalvars.time to do it
;1085:	self->s.v.think = ( func_t ) execute_changelevel;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 execute_changelevel
CVPU4 4
CVUI4 4
ASGNI4
line 1086
;1086:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1087
;1087:}
LABELV $711
endproc changelevel_touch 20 12
export SP_trigger_changelevel
proc SP_trigger_changelevel 4 4
line 1094
;1088:
;1089:/*QUAKED trigger_changelevel (0.5 0.5 0.5) ? NO_INTERMISSION
;1090:When the player touches this, he gets sent to the map listed in the "map" variable.  Unless the NO_INTERMISSION flag is set, the view will go to the info_intermission spot and display stats.
;1091:*/
;1092:
;1093:void SP_trigger_changelevel()
;1094:{
line 1095
;1095:	if ( !CheckExistence() )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $725
line 1096
;1096:	{
line 1097
;1097:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1098
;1098:		return;
ADDRGP4 $724
JUMPV
LABELV $725
line 1100
;1099:	}
;1100:	if ( !self->map )
ADDRGP4 self
INDIRP4
CNSTI4 540
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $727
line 1101
;1101:		G_Error( "changelevel trigger doesn't have map" );
ADDRGP4 $729
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $727
line 1103
;1102:
;1103:	InitTrigger();
ADDRGP4 InitTrigger
CALLV
pop
line 1104
;1104:	self->s.v.touch = ( func_t ) changelevel_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 changelevel_touch
CVPU4 4
CVUI4 4
ASGNI4
line 1105
;1105:}
LABELV $724
endproc SP_trigger_changelevel 4 4
export respawn
proc respawn 0 4
line 1118
;1106:
;1107:/*
;1108:=============================================================================
;1109:
;1110:    PLAYER GAME EDGE FUNCTIONS
;1111:
;1112:=============================================================================
;1113:*/
;1114:
;1115:void    set_suicide_frame();
;1116:
;1117:void respawn()
;1118:{
line 1119
;1119:	if ( self->has_disconnected == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 1
NEI4 $731
line 1120
;1120:		return;
ADDRGP4 $730
JUMPV
LABELV $731
line 1121
;1121:	if ( tf_data.cease_fire )
ADDRGP4 tf_data+72
INDIRI4
CNSTI4 0
EQI4 $733
line 1122
;1122:		return;
ADDRGP4 $730
JUMPV
LABELV $733
line 1123
;1123:	if ( coop )
ADDRGP4 coop
INDIRI4
CNSTI4 0
EQI4 $736
line 1124
;1124:	{
line 1126
;1125:		// make a copy of the dead body for appearances sake
;1126:		CopyToBodyQue( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 CopyToBodyQue
CALLV
pop
line 1128
;1127:		// set default spawn parms
;1128:		SetNewParms();//!!!FIXME for setspawnparam???
ADDRGP4 SetNewParms
CALLV
pop
line 1130
;1129:		// respawn              
;1130:		PutClientInServer();
ADDRGP4 PutClientInServer
CALLV
pop
line 1131
;1131:	} else
ADDRGP4 $737
JUMPV
LABELV $736
line 1132
;1132:	{
line 1133
;1133:		if ( deathmatch )
ADDRGP4 deathmatch
INDIRI4
CNSTI4 0
EQI4 $738
line 1134
;1134:		{
line 1136
;1135:			// make a copy of the dead body for appearances sake
;1136:			CopyToBodyQue( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 CopyToBodyQue
CALLV
pop
line 1138
;1137:			// set default spawn parms
;1138:			SetNewParms();
ADDRGP4 SetNewParms
CALLV
pop
line 1140
;1139:			// respawn              
;1140:			PutClientInServer();
ADDRGP4 PutClientInServer
CALLV
pop
line 1141
;1141:		} else
ADDRGP4 $739
JUMPV
LABELV $738
line 1142
;1142:			localcmd( "restart\n" );
ADDRGP4 $740
ARGP4
ADDRGP4 localcmd
CALLV
pop
LABELV $739
line 1143
;1143:	}
LABELV $737
line 1144
;1144:}
LABELV $730
endproc respawn 0 4
export ClientKill
proc ClientKill 24 12
line 1155
;1145:
;1146:/*
;1147:============
;1148:ClientKill
;1149:
;1150:Player entered the suicide command
;1151:============
;1152:*/
;1153:
;1154:void ClientKill()
;1155:{
line 1158
;1156:	gedict_t *te;
;1157:
;1158:	if ( self->has_disconnected == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 1
NEI4 $742
line 1159
;1159:		return;
ADDRGP4 $741
JUMPV
LABELV $742
line 1160
;1160:	if ( self->suicide_time > g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 992
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $744
line 1161
;1161:		return;
ADDRGP4 $741
JUMPV
LABELV $744
line 1162
;1162:	if ( self->s.v.deadflag )
ADDRGP4 self
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
CNSTF4 0
EQF4 $747
line 1163
;1163:		return;
ADDRGP4 $741
JUMPV
LABELV $747
line 1164
;1164:	if ( !self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $749
line 1165
;1165:		return;
ADDRGP4 $741
JUMPV
LABELV $749
line 1166
;1166:	self->suicide_time = g_globalvars.time + 5 + g_random() * 5;
ADDRLP4 4
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 8
CNSTF4 1084227584
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 992
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ADDRLP4 8
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1167
;1167:	G_bprint( PRINT_MEDIUM, "%s suicides\n", self->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $752
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
line 1169
;1168:
;1169:	set_suicide_frame();
ADDRGP4 set_suicide_frame
CALLV
pop
line 1170
;1170:	self->s.v.modelindex = modelindex_player;
ADDRGP4 self
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 modelindex_player
INDIRI4
CVIF4 4
ASGNF4
line 1172
;1171:
;1172:	if ( self->tfstate & TFSTATE_INFECTED )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $753
line 1173
;1173:	{
line 1174
;1174:		te = trap_find( world, FOFS( s.v.classname ), "timer" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $755
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
ADDRGP4 $757
JUMPV
LABELV $756
line 1176
;1175:		while ( te )
;1176:		{
line 1177
;1177:			if ( te->s.v.owner == EDICT_TO_PROG( self ) && te->s.v.think == ( func_t ) BioInfection_Decay )
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
NEI4 $759
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ADDRGP4 BioInfection_Decay
CVPU4 4
CVUI4 4
NEI4 $759
line 1178
;1178:			{
line 1179
;1179:				logfrag( te, self );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 logfrag
CALLV
pop
line 1180
;1180:				TF_AddFrags( PROG_TO_EDICT( te->s.v.enemy ), 1 );
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
line 1181
;1181:			}
LABELV $759
line 1182
;1182:			te = trap_find( te, FOFS( s.v.classname ), "timer" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $755
ARGP4
ADDRLP4 20
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 1183
;1183:		}
LABELV $757
line 1175
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $756
line 1184
;1184:	} else
ADDRGP4 $754
JUMPV
LABELV $753
line 1185
;1185:		logfrag( self, self );
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 logfrag
CALLV
pop
LABELV $754
line 1186
;1186:	TF_AddFrags( self, -1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
line 1187
;1187:	self->s.v.weaponmodel = "";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $205
ASGNP4
line 1189
;1188:
;1189:	SetVector( self->s.v.view_ofs, 0, 0, -8 );
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
line 1190
;1190:	self->s.v.movetype = MOVETYPE_NONE;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 0
ASGNF4
line 1191
;1191:	TeamFortress_RemoveTimers();
ADDRGP4 TeamFortress_RemoveTimers
CALLV
pop
line 1192
;1192:	TeamFortress_SetupRespawn( 1 );
CNSTI4 1
ARGI4
ADDRGP4 TeamFortress_SetupRespawn
CALLV
pop
line 1193
;1193:	self->s.v.health = -1;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 3212836864
ASGNF4
line 1194
;1194:	self->th_die();
ADDRGP4 self
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CALLV
pop
line 1195
;1195:	self->s.v.deadflag = DEAD_RESPAWNABLE;
ADDRGP4 self
INDIRP4
CNSTI4 348
ADDP4
CNSTF4 1077936128
ASGNF4
line 1196
;1196:	self->tfstate |= TFSTATE_RESPAWN_READY;
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
line 1197
;1197:	self->s.v.takedamage = 0;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 0
ASGNF4
line 1198
;1198:}
LABELV $741
endproc ClientKill 24 12
data
export lastspawn_team
align 4
LABELV lastspawn_team
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
export team_spawn_str
align 4
LABELV team_spawn_str
address $205
address $761
address $762
address $763
address $764
export CheckTelefragSpotOld
code
proc CheckTelefragSpotOld 24 12
line 1204
;1199:
;1200:gedict_t *lastspawn_team[5] = { NULL, NULL, NULL, NULL, NULL };
;1201:const char   *team_spawn_str[5] = { "", "ts1", "ts2", "ts3", "ts4" };
;1202:
;1203:int CheckTelefragSpotOld( vec3_t v )
;1204:{
line 1207
;1205:	gedict_t *at_spot;
;1206:
;1207:	for ( at_spot = findradius( world, v, 40 ); at_spot; at_spot = findradius( at_spot, v, 40 ) )
ADDRGP4 world
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1109393408
ARGF4
ADDRLP4 4
ADDRGP4 findradius
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRGP4 $769
JUMPV
LABELV $766
line 1208
;1208:	{
line 1209
;1209:		if ( streq( at_spot->s.v.classname, "player" ) && !at_spot->s.v.deadflag
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $190
ARGP4
ADDRLP4 8
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $770
ADDRLP4 0
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
CNSTF4 0
NEF4 $770
ADDRLP4 16
CNSTI4 960
ASGNI4
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ADDRLP4 20
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
NEI4 $770
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 20
INDIRP4
CVPU4 4
EQU4 $770
line 1211
;1210:		     && at_spot->team_no == self->team_no && at_spot != self )
;1211:		{
line 1212
;1212:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $765
JUMPV
LABELV $770
line 1214
;1213:		}
;1214:	}
LABELV $767
line 1207
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1109393408
ARGF4
ADDRLP4 8
ADDRGP4 findradius
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
LABELV $769
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $766
line 1215
;1215:	return 1;
CNSTI4 1
RETI4
LABELV $765
endproc CheckTelefragSpotOld 24 12
export CheckTelefragSpot
proc CheckTelefragSpot 32 12
line 1219
;1216:}
;1217:
;1218:int CheckTelefragSpot( vec3_t v )
;1219:{
line 1232
;1220:	gedict_t *te;
;1221:	vec3_t spot_mins,spot_maxs;
;1222:
;1223:	//make tdeath bbox for spot origin
;1224:/*	spot_mins[0] = self->s.v.mins[0] + v[0] - 5;
;1225:	spot_mins[1] = self->s.v.mins[1] + v[1] - 5;
;1226:	spot_mins[2] = self->s.v.mins[2] + v[2] - 5;
;1227:
;1228:	spot_maxs[0] = self->s.v.maxs[0] + v[0] + 5;	
;1229:	spot_maxs[1] = self->s.v.maxs[1] + v[1] + 5;	
;1230:	spot_maxs[2] = self->s.v.maxs[2] + v[2] + 5;	*/
;1231:
;1232:	spot_mins[0] = VEC_HULL_MIN[0] + v[0] - 5;
ADDRLP4 4
ADDRGP4 VEC_HULL_MIN
INDIRF4
ADDRFP4 0
INDIRP4
INDIRF4
ADDF4
CNSTF4 1084227584
SUBF4
ASGNF4
line 1233
;1233:	spot_mins[1] = VEC_HULL_MIN[1] + v[1] - 5;
ADDRLP4 4+4
ADDRGP4 VEC_HULL_MIN+4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
CNSTF4 1084227584
SUBF4
ASGNF4
line 1234
;1234:	spot_mins[2] = VEC_HULL_MIN[2] + v[2] - 5;
ADDRLP4 4+8
ADDRGP4 VEC_HULL_MIN+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1084227584
SUBF4
ASGNF4
line 1236
;1235:
;1236:	spot_maxs[0] = VEC_HULL_MAX[0] + v[0] + 5;	
ADDRLP4 16
ADDRGP4 VEC_HULL_MAX
INDIRF4
ADDRFP4 0
INDIRP4
INDIRF4
ADDF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 1237
;1237:	spot_maxs[1] = VEC_HULL_MAX[1] + v[1] + 5;	
ADDRLP4 16+4
ADDRGP4 VEC_HULL_MAX+4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 1238
;1238:	spot_maxs[2] = VEC_HULL_MAX[2] + v[2] + 5;	
ADDRLP4 16+8
ADDRGP4 VEC_HULL_MAX+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 1240
;1239:
;1240:	for (   te = world ; (te = trap_find( te , FOFS(s.v.classname), "player"));)
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $784
JUMPV
LABELV $781
line 1241
;1241:	{
line 1242
;1242:		if( te->team_no != self->team_no )
ADDRLP4 28
CNSTI4 960
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ADDRGP4 self
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
EQI4 $785
line 1243
;1243:			continue;
ADDRGP4 $782
JUMPV
LABELV $785
line 1244
;1244:		if( te == self )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 self
INDIRP4
CVPU4 4
NEU4 $787
line 1245
;1245:			continue;
ADDRGP4 $782
JUMPV
LABELV $787
line 1246
;1246:        	if( te->s.v.deadflag )
ADDRLP4 0
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
CNSTF4 0
EQF4 $789
line 1247
;1247:        		continue;
ADDRGP4 $782
JUMPV
LABELV $789
line 1249
;1248:        	
;1249:        	if( te->s.v.solid == SOLID_NOT )	
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRF4
CNSTF4 0
NEF4 $791
line 1250
;1250:        		continue;
ADDRGP4 $782
JUMPV
LABELV $791
line 1252
;1251:
;1252:	        if( te->s.v.absmin[0] > spot_maxs[0] )
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $793
line 1253
;1253:	        	continue;
ADDRGP4 $782
JUMPV
LABELV $793
line 1254
;1254:	        if( te->s.v.absmin[1] > spot_maxs[1] )
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
ADDRLP4 16+4
INDIRF4
LEF4 $795
line 1255
;1255:	        	continue;
ADDRGP4 $782
JUMPV
LABELV $795
line 1256
;1256:	        if( te->s.v.absmin[2] > spot_maxs[2] )
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
ADDRLP4 16+8
INDIRF4
LEF4 $798
line 1257
;1257:	        	continue;
ADDRGP4 $782
JUMPV
LABELV $798
line 1259
;1258:	
;1259:	        if( te->s.v.absmax[0] < spot_mins[0] )
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
GEF4 $801
line 1260
;1260:	        	continue;
ADDRGP4 $782
JUMPV
LABELV $801
line 1261
;1261:	        if( te->s.v.absmax[1] < spot_mins[1] )
ADDRLP4 0
INDIRP4
CNSTI4 132
ADDP4
INDIRF4
ADDRLP4 4+4
INDIRF4
GEF4 $803
line 1262
;1262:	        	continue;
ADDRGP4 $782
JUMPV
LABELV $803
line 1263
;1263:	        if( te->s.v.absmax[2] < spot_mins[2] )
ADDRLP4 0
INDIRP4
CNSTI4 136
ADDP4
INDIRF4
ADDRLP4 4+8
INDIRF4
GEF4 $806
line 1264
;1264:	        	continue;
ADDRGP4 $782
JUMPV
LABELV $806
line 1266
;1265:	        
;1266:	        return 0;
CNSTI4 0
RETI4
ADDRGP4 $772
JUMPV
LABELV $782
line 1240
LABELV $784
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $190
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
NEU4 $781
line 1268
;1267:	}
;1268:	return 1;
CNSTI4 1
RETI4
LABELV $772
endproc CheckTelefragSpot 32 12
export FindTeamSpawnPoint
proc FindTeamSpawnPoint 28 12
line 1274
;1269:}
;1270:
;1271:
;1272:
;1273:gedict_t *FindTeamSpawnPoint( int team_num )
;1274:{
line 1281
;1275:	gedict_t *spot;
;1276:
;1277:// gedict_t* at_spot;
;1278:	int     spot_found;
;1279:	int     attempts;
;1280:
;1281:	spot = lastspawn_team[team_num];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lastspawn_team
ADDP4
INDIRP4
ASGNP4
line 1282
;1282:	if ( !spot )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $810
line 1283
;1283:		spot = world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
LABELV $810
line 1284
;1284:	for ( attempts = 0;; attempts++ )
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $812
line 1285
;1285:	{
line 1286
;1286:		spot = trap_find( spot, FOFS( team_str_home ), team_spawn_str[team_num] );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1284
ARGI4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 team_spawn_str
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
line 1287
;1287:		if ( !spot )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $816
line 1288
;1288:			spot = trap_find( world, FOFS( team_str_home ), team_spawn_str[team_num] );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 1284
ARGI4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 team_spawn_str
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
LABELV $816
line 1289
;1289:		if ( !spot )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $818
line 1290
;1290:			return world;
ADDRGP4 world
INDIRP4
RETP4
ADDRGP4 $809
JUMPV
LABELV $818
line 1291
;1291:		spot_found = CheckTelefragSpot( spot->s.v.origin );
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 CheckTelefragSpot
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
ASGNI4
line 1293
;1292:
;1293:		if ( !Activated( spot, self ) )
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Activated
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $820
line 1294
;1294:			spot_found = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $820
line 1295
;1295:		if ( spot_found || attempts >= 30 )
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $824
ADDRLP4 8
INDIRI4
CNSTI4 30
LTI4 $822
LABELV $824
line 1296
;1296:		{
line 1297
;1297:			lastspawn_team[team_num] = spot;
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lastspawn_team
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1298
;1298:			return spot;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $809
JUMPV
LABELV $822
line 1300
;1299:		}
;1300:	}
LABELV $813
line 1284
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $812
JUMPV
LABELV $809
endproc FindTeamSpawnPoint 28 12
export FindRandomTeamSpawnPoint
proc FindRandomTeamSpawnPoint 32 12
line 1305
;1301://	return world;
;1302:}
;1303:
;1304:gedict_t *FindRandomTeamSpawnPoint( int team_num )
;1305:{
line 1308
;1306:	gedict_t *spot;
;1307:
;1308:	int     numspots = 0, numallspots = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1311
;1309:	int     rndspot;
;1310:
;1311:	for ( spot = world; (spot = trap_find( spot, FOFS( team_str_home ), team_spawn_str[team_num] )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $829
JUMPV
LABELV $826
line 1312
;1312:	{
line 1313
;1313:		if ( !Activated( spot, self ) )
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Activated
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $830
line 1314
;1314:			continue;
ADDRGP4 $827
JUMPV
LABELV $830
line 1315
;1315:		numallspots++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1316
;1316:		if ( CheckTelefragSpot( spot->s.v.origin ) )
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 CheckTelefragSpot
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $832
line 1317
;1317:			numspots++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $832
line 1318
;1318:	}
LABELV $827
line 1311
LABELV $829
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1284
ARGI4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 team_spawn_str
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
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $826
line 1319
;1319:	if ( !numallspots )
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $834
line 1320
;1320:		return world;
ADDRGP4 world
INDIRP4
RETP4
ADDRGP4 $825
JUMPV
LABELV $834
line 1321
;1321:	if ( numspots )
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $836
line 1322
;1322:	{
line 1323
;1323:		rndspot = g_random() * (numspots);
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 20
INDIRF4
ADDRLP4 12
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 1324
;1324:		for ( spot = world; (spot = trap_find( spot, FOFS( team_str_home ), team_spawn_str[team_num] )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $841
JUMPV
LABELV $838
line 1325
;1325:		{
line 1327
;1326:
;1327:			if ( !Activated( spot, self ) )
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Activated
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $842
line 1328
;1328:				continue;
ADDRGP4 $839
JUMPV
LABELV $842
line 1329
;1329:			if ( !CheckTelefragSpot( spot->s.v.origin ) )
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 CheckTelefragSpot
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $844
line 1330
;1330:				continue;
ADDRGP4 $839
JUMPV
LABELV $844
line 1331
;1331:			if ( !rndspot )
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $846
line 1332
;1332:				break;
ADDRGP4 $837
JUMPV
LABELV $846
line 1333
;1333:			rndspot--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1334
;1334:		}
LABELV $839
line 1324
LABELV $841
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1284
ARGI4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 team_spawn_str
ADDP4
INDIRP4
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
NEU4 $838
line 1335
;1335:	} else			// not found no telefrag spot
ADDRGP4 $837
JUMPV
LABELV $836
line 1336
;1336:	{
line 1337
;1337:		rndspot = g_random() * (numallspots);
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 20
INDIRF4
ADDRLP4 8
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 1338
;1338:		for ( spot = world; (spot = trap_find( spot, FOFS( team_str_home ), team_spawn_str[team_num] )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $851
JUMPV
LABELV $848
line 1339
;1339:		{
line 1341
;1340:
;1341:			if ( !Activated( spot, self ) )
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Activated
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $852
line 1342
;1342:				continue;
ADDRGP4 $849
JUMPV
LABELV $852
line 1343
;1343:			if ( !rndspot )
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $854
line 1344
;1344:				break;
ADDRGP4 $850
JUMPV
LABELV $854
line 1345
;1345:			rndspot--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1346
;1346:		}
LABELV $849
line 1338
LABELV $851
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1284
ARGI4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 team_spawn_str
ADDP4
INDIRP4
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
NEU4 $848
LABELV $850
line 1347
;1347:	}
LABELV $837
line 1348
;1348:	if ( spot )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $856
line 1349
;1349:		return spot;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $825
JUMPV
LABELV $856
line 1351
;1350:
;1351:	G_conprintf( "FindRandomTeamSpawnPoint: error\n" );
ADDRGP4 $858
ARGP4
ADDRGP4 G_conprintf
CALLV
pop
line 1353
;1352:
;1353:	return world;
ADDRGP4 world
INDIRP4
RETP4
LABELV $825
endproc FindRandomTeamSpawnPoint 32 12
export FindDeathmatchSpawnPoint
proc FindDeathmatchSpawnPoint 24 12
line 1359
;1354:}
;1355:
;1356:gedict_t *lastspawn;
;1357:
;1358:gedict_t *FindDeathmatchSpawnPoint()
;1359:{
line 1365
;1360:	gedict_t *spot;
;1361:
;1362:	int     spot_found;
;1363:	int     attempts;
;1364:
;1365:	spot = lastspawn;
ADDRLP4 0
ADDRGP4 lastspawn
INDIRP4
ASGNP4
line 1366
;1366:	if ( !spot )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $860
line 1367
;1367:		spot = world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
LABELV $860
line 1368
;1368:	for ( attempts = 0;; attempts++ )
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $862
line 1369
;1369:	{
line 1370
;1370:		spot = trap_find( spot, FOFS( s.v.classname ), "info_player_deathmatch" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $588
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1371
;1371:		if ( !spot )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $866
line 1372
;1372:			spot = trap_find( world, FOFS( s.v.classname ), "info_player_deathmatch" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $588
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
LABELV $866
line 1373
;1373:		if ( !spot )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $868
line 1374
;1374:			return world;
ADDRGP4 world
INDIRP4
RETP4
ADDRGP4 $859
JUMPV
LABELV $868
line 1376
;1375:
;1376:		spot_found = CheckTelefragSpot( spot->s.v.origin );
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 CheckTelefragSpot
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
line 1378
;1377:
;1378:		if ( spot_found || attempts >= 10 )
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $872
ADDRLP4 4
INDIRI4
CNSTI4 10
LTI4 $870
LABELV $872
line 1379
;1379:		{
line 1380
;1380:			lastspawn = spot;
ADDRGP4 lastspawn
ADDRLP4 0
INDIRP4
ASGNP4
line 1381
;1381:			return spot;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $859
JUMPV
LABELV $870
line 1383
;1382:		}
;1383:	}
LABELV $863
line 1368
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $862
JUMPV
LABELV $859
endproc FindDeathmatchSpawnPoint 24 12
export SelectSpawnPoint
proc SelectSpawnPoint 16 12
line 1395
;1384://	return world;
;1385:}
;1386:
;1387:
;1388:/*void ValidateUser( gedict_t * e )
;1389:{
;1390:
;1391:}
;1392:*/
;1393:
;1394:gedict_t *SelectSpawnPoint()
;1395:{
line 1398
;1396:	gedict_t *spot;
;1397:
;1398:	if ( self->team_no )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 0
EQI4 $874
line 1399
;1399:	{
line 1400
;1400:		if ( tf_data.random_tf_spawn )
ADDRGP4 tf_data+156
INDIRI4
CNSTI4 0
EQI4 $876
line 1401
;1401:			spot = FindRandomTeamSpawnPoint( self->team_no );
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 FindRandomTeamSpawnPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRGP4 $877
JUMPV
LABELV $876
line 1403
;1402:		else
;1403:			spot = FindTeamSpawnPoint( self->team_no );
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 FindTeamSpawnPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
LABELV $877
line 1404
;1404:		if ( spot != world )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $879
line 1405
;1405:			return spot;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $873
JUMPV
LABELV $879
line 1406
;1406:	}
LABELV $874
line 1407
;1407:	if ( coop )
ADDRGP4 coop
INDIRI4
CNSTI4 0
EQI4 $881
line 1408
;1408:	{
line 1409
;1409:		lastspawn = trap_find( lastspawn, FOFS( s.v.classname ), "info_player_coop" );
ADDRLP4 4
ADDRGP4 lastspawn
ASGNP4
ADDRLP4 4
INDIRP4
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $883
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRP4
ASGNP4
line 1410
;1410:		if ( !lastspawn )
ADDRGP4 lastspawn
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $884
line 1411
;1411:			lastspawn = trap_find( world, FOFS( s.v.classname ), "info_player_coop" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $883
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRGP4 lastspawn
ADDRLP4 12
INDIRP4
ASGNP4
LABELV $884
line 1412
;1412:		if ( lastspawn )
ADDRGP4 lastspawn
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $882
line 1413
;1413:			return lastspawn;
ADDRGP4 lastspawn
INDIRP4
RETP4
ADDRGP4 $873
JUMPV
line 1414
;1414:	} else
LABELV $881
line 1415
;1415:	{
line 1416
;1416:		if ( deathmatch )
ADDRGP4 deathmatch
INDIRI4
CNSTI4 0
EQI4 $888
line 1417
;1417:		{
line 1418
;1418:			spot = FindDeathmatchSpawnPoint();
ADDRLP4 4
ADDRGP4 FindDeathmatchSpawnPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1419
;1419:			if ( spot != world )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $890
line 1420
;1420:				return spot;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $873
JUMPV
LABELV $890
line 1421
;1421:		}
LABELV $888
line 1422
;1422:	}
LABELV $882
line 1423
;1423:	if ( ( int ) ( g_globalvars.serverflags ) )
ADDRGP4 g_globalvars+144
INDIRF4
CVFI4 4
CNSTI4 0
EQI4 $892
line 1424
;1424:	{
line 1425
;1425:		spot = trap_find( world, FOFS( s.v.classname ), "info_player_start2" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $895
ARGP4
ADDRLP4 4
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1426
;1426:		if ( spot )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $896
line 1427
;1427:			return spot;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $873
JUMPV
LABELV $896
line 1428
;1428:	}
LABELV $892
line 1429
;1429:	spot = trap_find( world, FOFS( s.v.classname ), "info_player_start" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $585
ARGP4
ADDRLP4 4
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1430
;1430:	if ( !spot )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $898
line 1431
;1431:		G_Error( "PutClientInServer: no info_player_start on level\n" );
ADDRGP4 $900
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $898
line 1432
;1432:	return spot;
ADDRLP4 0
INDIRP4
RETP4
LABELV $873
endproc SelectSpawnPoint 16 12
export PutClientInServer
proc PutClientInServer 228 28
line 1445
;1433:}
;1434:
;1435:
;1436:
;1437:////////////////
;1438:// GlobalParams:
;1439:// time
;1440:// self
;1441:// called after ClientConnect
;1442:///////////////
;1443:
;1444:void PutClientInServer()
;1445:{
line 1455
;1446:	int     iszoom;
;1447:	gedict_t *spot;
;1448:	gedict_t *te;
;1449:	vec3_t  v;
;1450:	char    s[10];
;1451:	// version stuff
;1452:	char cl[128]; // client name
;1453:	int ctype; // mqw client type ID
;1454:
;1455:	if( self->isBot )
ADDRGP4 self
INDIRP4
CNSTI4 1652
ADDP4
INDIRI4
CNSTI4 0
EQI4 $902
line 1456
;1456:	{
line 1457
;1457:      		ClearAllWaypoints(  );
ADDRGP4 ClearAllWaypoints
CALLV
pop
line 1458
;1458:      		ClearAllTargets(  );
ADDRGP4 ClearAllTargets
CALLV
pop
line 1459
;1459:      		self->obs_time = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1736
ADDP4
CNSTF4 0
ASGNF4
line 1460
;1460:      		self->action = BOT_IDLE;
ADDRGP4 self
INDIRP4
CNSTI4 1664
ADDP4
CNSTI4 1
ASGNI4
line 1461
;1461:      		self->s.v.button0 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 364
ADDP4
CNSTF4 0
ASGNF4
line 1462
;1462:      		self->s.v.button1 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 368
ADDP4
CNSTF4 0
ASGNF4
line 1463
;1463:      		self->s.v.button2 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 372
ADDP4
CNSTF4 0
ASGNF4
line 1464
;1464:      		self->keys = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1656
ADDP4
CNSTI4 0
ASGNI4
line 1465
;1465:      		self->fBotMessageTime = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1692
ADDP4
CNSTF4 0
ASGNF4
line 1466
;1466:	}
LABELV $902
line 1467
;1467:	self->s.v.touch = ( func_t ) player_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 player_touch
CVPU4 4
CVUI4 4
ASGNI4
line 1468
;1468:	self->s.v.classname = "player";
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $190
ASGNP4
line 1469
;1469:	self->s.v.health = 100;
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1120403456
ASGNF4
line 1470
;1470:	self->s.v.solid = SOLID_SLIDEBOX;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1077936128
ASGNF4
line 1471
;1471:	self->s.v.movetype = MOVETYPE_WALK;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1077936128
ASGNF4
line 1472
;1472:	self->show_hostile = 0;
ADDRGP4 self
INDIRP4
CNSTI4 784
ADDP4
CNSTF4 0
ASGNF4
line 1473
;1473:	self->FlashTime = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1472
ADDP4
CNSTF4 0
ASGNF4
line 1474
;1474:	self->s.v.max_health = 100;
ADDRGP4 self
INDIRP4
CNSTI4 416
ADDP4
CNSTF4 1120403456
ASGNF4
line 1475
;1475:	self->s.v.flags = FL_CLIENT;
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
CNSTF4 1090519040
ASGNF4
line 1476
;1476:	self->air_finished = g_globalvars.time + 12;
ADDRGP4 self
INDIRP4
CNSTI4 796
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1094713344
ADDF4
ASGNF4
line 1477
;1477:	self->dmg = 2;
ADDRGP4 self
INDIRP4
CNSTI4 716
ADDP4
CNSTF4 1073741824
ASGNF4
line 1478
;1478:	self->super_damage_finished = 0;
ADDRGP4 self
INDIRP4
CNSTI4 740
ADDP4
CNSTF4 0
ASGNF4
line 1479
;1479:	self->radsuit_finished = 0;
ADDRGP4 self
INDIRP4
CNSTI4 744
ADDP4
CNSTF4 0
ASGNF4
line 1480
;1480:	self->invisible_finished = 0;
ADDRGP4 self
INDIRP4
CNSTI4 736
ADDP4
CNSTF4 0
ASGNF4
line 1481
;1481:	self->invincible_finished = 0;
ADDRGP4 self
INDIRP4
CNSTI4 732
ADDP4
CNSTF4 0
ASGNF4
line 1482
;1482:	self->s.v.effects = 0;
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 0
ASGNF4
line 1483
;1483:	self->invincible_time = 0;
ADDRGP4 self
INDIRP4
CNSTI4 748
ADDP4
CNSTF4 0
ASGNF4
line 1484
;1484:	self->reload_shotgun = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1060
ADDP4
CNSTI4 0
ASGNI4
line 1485
;1485:	self->reload_super_shotgun = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1064
ADDP4
CNSTI4 0
ASGNI4
line 1486
;1486:	self->reload_grenade_launcher = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1068
ADDP4
CNSTI4 0
ASGNI4
line 1487
;1487:	self->reload_rocket_launcher = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1072
ADDP4
CNSTI4 0
ASGNI4
line 1488
;1488:	self->immune_to_check = g_globalvars.time + tf_data.cheat_pause;
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
line 1489
;1489:	self->on_hook = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1444
ADDP4
CNSTI4 0
ASGNI4
line 1490
;1490:	self->hook_out = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1436
ADDP4
CNSTI4 0
ASGNI4
line 1491
;1491:	self->fire_held_down = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1448
ADDP4
CNSTI4 0
ASGNI4
line 1492
;1492:	DecodeLevelParms();
ADDRGP4 DecodeLevelParms
CALLV
pop
line 1493
;1493:	if ( !self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $907
line 1494
;1494:	{
line 1495
;1495:		if ( TeamFortress_TeamIsCivilian( self->team_no ) )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 168
ADDRGP4 TeamFortress_TeamIsCivilian
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
EQI4 $908
line 1496
;1496:		{
line 1497
;1497:			self->s.v.impulse = 1;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 1065353216
ASGNF4
line 1498
;1498:			TeamFortress_ChangeClass();
ADDRGP4 TeamFortress_ChangeClass
CALLV
pop
line 1499
;1499:		}
line 1500
;1500:	}else
ADDRGP4 $908
JUMPV
LABELV $907
line 1501
;1501:	{
line 1504
;1502:	        int   savepc, savenextpc;
;1503:
;1504:             	savepc     = self->playerclass;
ADDRLP4 168
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
line 1505
;1505:             	savenextpc = self->nextpc;
ADDRLP4 172
ADDRGP4 self
INDIRP4
CNSTI4 824
ADDP4
INDIRI4
ASGNI4
line 1506
;1506:             	self->playerclass = 0;
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
CNSTI4 0
ASGNI4
line 1507
;1507:             	self->nextpc      = 0;
ADDRGP4 self
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 0
ASGNI4
line 1509
;1508:
;1509:             	if( !ClassIsRestricted( self->team_no, savepc ))
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 168
INDIRI4
ARGI4
ADDRLP4 176
ADDRGP4 ClassIsRestricted
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
NEI4 $911
line 1510
;1510:             	        self->playerclass = savepc;
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
ADDRLP4 168
INDIRI4
ASGNI4
LABELV $911
line 1511
;1511:             	self->nextpc = savenextpc;
ADDRGP4 self
INDIRP4
CNSTI4 824
ADDP4
ADDRLP4 172
INDIRI4
ASGNI4
line 1512
;1512:	}
LABELV $908
line 1514
;1513:
;1514:	if ( deathmatch == 3 && self->nextpc )
ADDRGP4 deathmatch
INDIRI4
CNSTI4 3
NEI4 $913
ADDRGP4 self
INDIRP4
CNSTI4 824
ADDP4
INDIRI4
CNSTI4 0
EQI4 $913
line 1515
;1515:	{
line 1518
;1516:	        int   savepc, savenextpc;
;1517:
;1518:             	savepc     = self->playerclass;
ADDRLP4 172
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
line 1519
;1519:             	savenextpc = self->nextpc;
ADDRLP4 168
ADDRGP4 self
INDIRP4
CNSTI4 824
ADDP4
INDIRI4
ASGNI4
line 1520
;1520:             	self->playerclass = 0;
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
CNSTI4 0
ASGNI4
line 1521
;1521:             	self->nextpc      = 0;
ADDRGP4 self
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 0
ASGNI4
line 1523
;1522:
;1523:             	if( !ClassIsRestricted( self->team_no, savenextpc ))
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 168
INDIRI4
ARGI4
ADDRLP4 176
ADDRGP4 ClassIsRestricted
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
NEI4 $915
line 1524
;1524:       		       self->playerclass = savenextpc;
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
ADDRLP4 168
INDIRI4
ASGNI4
ADDRGP4 $916
JUMPV
LABELV $915
line 1526
;1525:             	else
;1526:             	       self->playerclass = savepc;
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
ADDRLP4 172
INDIRI4
ASGNI4
LABELV $916
line 1528
;1527:             	        
;1528:		self->nextpc = 0;
ADDRGP4 self
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 0
ASGNI4
line 1529
;1529:		if( self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
EQI4 $917
line 1530
;1530:		{
line 1531
;1531:              		if ( self->playerclass == PC_RANDOM )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 10
NEI4 $919
line 1532
;1532:              			self->tfstate |= TFSTATE_RANDOMPC;
ADDRLP4 180
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 180
INDIRP4
ADDRLP4 180
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
ADDRGP4 $920
JUMPV
LABELV $919
line 1534
;1533:              		else
;1534:              		{
line 1535
;1535:              			self->tfstate -= ( self->tfstate & TFSTATE_RANDOMPC );
ADDRLP4 184
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 188
ADDRLP4 184
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 184
INDIRP4
ADDRLP4 188
INDIRI4
ADDRLP4 188
INDIRI4
CNSTI4 8
BANDI4
SUBI4
ASGNI4
line 1536
;1536:              			TeamFortress_ExecClassScript( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_ExecClassScript
CALLV
pop
line 1537
;1537:              		}
LABELV $920
line 1538
;1538:		}
LABELV $917
line 1539
;1539:	}
LABELV $913
line 1540
;1540:	if ( !self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $921
line 1541
;1541:	{
line 1542
;1542:		if ( TeamFortress_TeamIsCivilian( self->team_no ) )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 168
ADDRGP4 TeamFortress_TeamIsCivilian
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
EQI4 $923
line 1543
;1543:		{
line 1544
;1544:			self->s.v.impulse = 1;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 1065353216
ASGNF4
line 1545
;1545:			TeamFortress_ChangeClass();
ADDRGP4 TeamFortress_ChangeClass
CALLV
pop
line 1546
;1546:		}
LABELV $923
line 1547
;1547:	}
LABELV $921
line 1549
;1548:
;1549:	iszoom = 0;
ADDRLP4 148
CNSTI4 0
ASGNI4
line 1550
;1550:	if ( self->tfstate & TFSTATE_ZOOMOFF )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $925
line 1551
;1551:		iszoom = 1;
ADDRLP4 148
CNSTI4 1
ASGNI4
LABELV $925
line 1552
;1552:	if ( self->tfstate & TFSTATE_RANDOMPC )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $927
line 1553
;1553:	{
line 1554
;1554:	        int  oldclass = self->playerclass;
ADDRLP4 168
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
line 1555
;1555:		self->playerclass = 1 + ( int ) ( g_random() * ( 9 ) );
ADDRLP4 172
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
CNSTF4 1091567616
ADDRLP4 172
INDIRF4
MULF4
CVFI4 4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $930
JUMPV
LABELV $929
line 1558
;1556:		while ( !IsLegalClass( self->playerclass )
;1557:			|| self->playerclass == oldclass || ClassIsRestricted( self->team_no, self->playerclass ) )
;1558:			self->playerclass = 1 + ( int ) ( g_random() * ( 9 ) );
ADDRLP4 176
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
CNSTF4 1091567616
ADDRLP4 176
INDIRF4
MULF4
CVFI4 4
CNSTI4 1
ADDI4
ASGNI4
LABELV $930
line 1556
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ARGI4
ADDRLP4 180
ADDRGP4 IsLegalClass
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
EQI4 $929
ADDRLP4 184
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 188
ADDRLP4 184
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
ADDRLP4 188
INDIRI4
ADDRLP4 168
INDIRI4
EQI4 $929
ADDRLP4 184
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 188
INDIRI4
ARGI4
ADDRLP4 192
ADDRGP4 ClassIsRestricted
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
NEI4 $929
line 1559
;1559:		self->tfstate = TFSTATE_RANDOMPC;
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
CNSTI4 8
ASGNI4
line 1560
;1560:		TeamFortress_ExecClassScript( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_ExecClassScript
CALLV
pop
line 1561
;1561:	} else
ADDRGP4 $928
JUMPV
LABELV $927
line 1562
;1562:		self->tfstate = 0;
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
CNSTI4 0
ASGNI4
LABELV $928
line 1564
;1563:
;1564:	if ( iszoom == 1 )
ADDRLP4 148
INDIRI4
CNSTI4 1
NEI4 $932
line 1565
;1565:		self->tfstate |= TFSTATE_ZOOMOFF;
ADDRLP4 168
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
LABELV $932
line 1566
;1566:	if ( self->playerclass != PC_ENGINEER && !tg_data.tg_enabled )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 9
EQI4 $934
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
NEI4 $934
line 1567
;1567:		Engineer_RemoveBuildings( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 Engineer_RemoveBuildings
CALLV
pop
LABELV $934
line 1569
;1568:
;1569:	self->s.v.takedamage = 2;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 1073741824
ASGNF4
line 1570
;1570:	TeamFortress_PrintClassName( self, self->playerclass, self->tfstate & TFSTATE_RANDOMPC );
ADDRLP4 172
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRLP4 172
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ARGI4
ADDRLP4 172
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 8
BANDI4
ARGI4
ADDRGP4 TeamFortress_PrintClassName
CALLV
pop
line 1571
;1571:	TeamFortress_SetEquipment();
ADDRGP4 TeamFortress_SetEquipment
CALLV
pop
line 1572
;1572:	TeamFortress_SetHealth();
ADDRGP4 TeamFortress_SetHealth
CALLV
pop
line 1573
;1573:	TeamFortress_PrepareForArenaRespawn();
ADDRGP4 TeamFortress_PrepareForArenaRespawn
CALLV
pop
line 1574
;1574:	TeamFortress_SetSpeed( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 1575
;1575:	TeamFortress_SetSkin( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSkin
CALLV
pop
line 1577
;1576://	stuffcmd( self, "v_idlescale 0\nfov 90\n" );	// enough with the FOV changing!!
;1577:	stuffcmd( self, "v_idlescale 0\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $936
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1578
;1578:	stuffcmd( self, "v_cshift; wait; bf\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $937
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 1579
;1579:	SetTeamName( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 SetTeamName
CALLV
pop
line 1580
;1580:	W_SetCurrentAmmo();
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 1581
;1581:	self->attack_finished = g_globalvars.time + 0.3;
ADDRGP4 self
INDIRP4
CNSTI4 724
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1050253722
ADDF4
ASGNF4
line 1582
;1582:	self->th_pain = player_pain;
ADDRGP4 self
INDIRP4
CNSTI4 816
ADDP4
ADDRGP4 player_pain
ASGNP4
line 1583
;1583:	self->th_die = PlayerDie;
ADDRGP4 self
INDIRP4
CNSTI4 812
ADDP4
ADDRGP4 PlayerDie
ASGNP4
line 1584
;1584:	if ( self->height )
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
INDIRF4
CNSTF4 0
EQF4 $939
line 1585
;1585:	{
line 1586
;1586:		self->height = 0;
ADDRGP4 self
INDIRP4
CNSTI4 656
ADDP4
CNSTF4 0
ASGNF4
line 1587
;1587:		TF_zoom( 90 );
CNSTI4 90
ARGI4
ADDRGP4 TF_zoom
CALLV
pop
line 1588
;1588:	}
LABELV $939
line 1589
;1589:	self->s.v.deadflag = DEAD_NO;
ADDRGP4 self
INDIRP4
CNSTI4 348
ADDP4
CNSTF4 0
ASGNF4
line 1590
;1590:	self->pausetime = 0;
ADDRGP4 self
INDIRP4
CNSTI4 676
ADDP4
CNSTF4 0
ASGNF4
line 1591
;1591:	spot = SelectSpawnPoint();
ADDRLP4 176
ADDRGP4 SelectSpawnPoint
CALLP4
ASGNP4
ADDRLP4 128
ADDRLP4 176
INDIRP4
ASGNP4
line 1593
;1592:
;1593:	self->observer_list = spot;
ADDRGP4 self
INDIRP4
CNSTI4 900
ADDP4
ADDRLP4 128
INDIRP4
ASGNP4
line 1594
;1594:	VectorCopy( spot->s.v.origin, self->s.v.origin );
ADDRLP4 180
CNSTI4 156
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 180
INDIRI4
ADDP4
ADDRLP4 128
INDIRP4
ADDRLP4 180
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 184
CNSTI4 160
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 184
INDIRI4
ADDP4
ADDRLP4 128
INDIRP4
ADDRLP4 184
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 188
CNSTI4 164
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 188
INDIRI4
ADDP4
ADDRLP4 128
INDIRP4
ADDRLP4 188
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 1595
;1595:	self->s.v.origin[2]++;
ADDRLP4 180
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
ASGNP4
ADDRLP4 180
INDIRP4
ADDRLP4 180
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1597
;1596:
;1597:	VectorCopy( spot->s.v.angles, self->s.v.angles );
ADDRLP4 184
CNSTI4 192
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 184
INDIRI4
ADDP4
ADDRLP4 128
INDIRP4
ADDRLP4 184
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 188
CNSTI4 196
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 188
INDIRI4
ADDP4
ADDRLP4 128
INDIRP4
ADDRLP4 188
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 192
CNSTI4 200
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 192
INDIRI4
ADDP4
ADDRLP4 128
INDIRP4
ADDRLP4 192
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 1599
;1598:
;1599:	self->s.v.fixangle = 1;
ADDRGP4 self
INDIRP4
CNSTI4 380
ADDP4
CNSTF4 1065353216
ASGNF4
line 1600
;1600:	if ( streq( spot->s.v.classname, "info_player_teamspawn" ) && tf_data.cb_prematch_time < g_globalvars.time )
ADDRLP4 128
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $943
ARGP4
ADDRLP4 184
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
EQI4 $941
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $941
line 1601
;1601:	{
line 1602
;1602:		if ( spot->s.v.items )
ADDRLP4 128
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CNSTF4 0
EQF4 $946
line 1603
;1603:		{
line 1604
;1604:			te = Finditem( spot->s.v.items );
ADDRLP4 128
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 188
ADDRGP4 Finditem
CALLP4
ASGNP4
ADDRLP4 164
ADDRLP4 188
INDIRP4
ASGNP4
line 1605
;1605:			if ( te != world )
ADDRLP4 164
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $948
line 1606
;1606:				tfgoalitem_GiveToPlayer( te, self, self );
ADDRLP4 164
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
ARGP4
ADDRLP4 192
INDIRP4
ARGP4
ADDRGP4 tfgoalitem_GiveToPlayer
CALLV
pop
LABELV $948
line 1607
;1607:			if ( !( spot->goal_activation & TFSP_MULTIPLEITEMS ) )
ADDRLP4 128
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $950
line 1608
;1608:				spot->s.v.items = 0;
ADDRLP4 128
INDIRP4
CNSTI4 336
ADDP4
CNSTF4 0
ASGNF4
LABELV $950
line 1609
;1609:		}
LABELV $946
line 1610
;1610:		if ( spot->s.v.message )
ADDRLP4 128
INDIRP4
CNSTI4 496
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $952
line 1611
;1611:		{
line 1612
;1612:			CenterPrint( self, spot->s.v.message );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
CNSTI4 496
ADDP4
INDIRP4
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 1613
;1613:			if ( !( spot->goal_activation & TFSP_MULTIPLEMSGS ) )
ADDRLP4 128
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $954
line 1614
;1614:				spot->s.v.message = NULL;
ADDRLP4 128
INDIRP4
CNSTI4 496
ADDP4
CNSTP4 0
ASGNP4
LABELV $954
line 1615
;1615:		}
LABELV $952
line 1616
;1616:		if ( spot->activate_goal_no )
ADDRLP4 128
INDIRP4
CNSTI4 1172
ADDP4
INDIRI4
CNSTI4 0
EQI4 $956
line 1617
;1617:		{
line 1618
;1618:			te = Findgoal( spot->activate_goal_no );
ADDRLP4 128
INDIRP4
CNSTI4 1172
ADDP4
INDIRI4
ARGI4
ADDRLP4 188
ADDRGP4 Findgoal
CALLP4
ASGNP4
ADDRLP4 164
ADDRLP4 188
INDIRP4
ASGNP4
line 1619
;1619:			if ( te )
ADDRLP4 164
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $958
line 1620
;1620:				AttemptToActivate( te, self, spot );
ADDRLP4 164
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRGP4 AttemptToActivate
CALLV
pop
LABELV $958
line 1621
;1621:		}
LABELV $956
line 1622
;1622:		if ( spot->goal_effects == TFSP_REMOVESELF )
ADDRLP4 128
INDIRP4
CNSTI4 1132
ADDP4
INDIRI4
CNSTI4 1
NEI4 $960
line 1623
;1623:		{
line 1624
;1624:			spot->s.v.classname = "deadpoint";
ADDRLP4 128
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $962
ASGNP4
line 1625
;1625:			spot->team_str_home = "";
ADDRLP4 128
INDIRP4
CNSTI4 1284
ADDP4
ADDRGP4 $205
ASGNP4
line 1626
;1626:			spot->s.v.nextthink = g_globalvars.time + 1;
ADDRLP4 128
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1627
;1627:			spot->s.v.think = ( func_t ) SUB_Remove;
ADDRLP4 128
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 1628
;1628:		}
LABELV $960
line 1629
;1629:	}
LABELV $941
line 1630
;1630:	setmodel( self, "" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $205
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1631
;1631:	modelindex_null = self->s.v.modelindex;
ADDRGP4 modelindex_null
ADDRGP4 self
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 1633
;1632:// oh, this is a hack!
;1633:	setmodel( self, "progs/eyes.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $964
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1634
;1634:	modelindex_eyes = self->s.v.modelindex;
ADDRGP4 modelindex_eyes
ADDRGP4 self
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 1636
;1635:
;1636:	setmodel( self, "progs/player.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $965
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 1637
;1637:	modelindex_player = self->s.v.modelindex;
ADDRGP4 modelindex_player
ADDRGP4 self
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 1641
;1638:
;1639:	// client version recognition code
;1640:	//  Should this maybe be put in ClientConnect? - xav
;1641:	self->client = "unknown";
ADDRGP4 self
INDIRP4
CNSTI4 1812
ADDP4
ADDRGP4 $966
ASGNP4
line 1642
;1642:	ctype = 0;
ADDRLP4 132
CNSTI4 0
ASGNI4
line 1643
;1643:	infokey( self, "*client", cl, sizeof( cl ) );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $967
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 infokey
CALLV
pop
line 1644
;1644:	if ( !strcmp( cl, "mqwcl 0.96" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $970
ARGP4
ADDRLP4 188
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
NEI4 $968
line 1645
;1645:		ctype = 1;
ADDRLP4 132
CNSTI4 1
ASGNI4
LABELV $968
line 1646
;1646:	if ( !strcmp( cl, "mqwcl 0.95" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $973
ARGP4
ADDRLP4 192
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
NEI4 $971
line 1647
;1647:		ctype = 2;
ADDRLP4 132
CNSTI4 2
ASGNI4
LABELV $971
line 1648
;1648:	if ( !strcmp( cl, "mqwcl 0.93" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $976
ARGP4
ADDRLP4 196
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
NEI4 $974
line 1649
;1649:		ctype = 3;
ADDRLP4 132
CNSTI4 3
ASGNI4
LABELV $974
line 1650
;1650:	if ( ctype > 0 )
ADDRLP4 132
INDIRI4
CNSTI4 0
LEI4 $977
line 1651
;1651:	{
line 1652
;1652:		self->client = "mqwcl";
ADDRGP4 self
INDIRP4
CNSTI4 1812
ADDP4
ADDRGP4 $979
ASGNP4
line 1653
;1653:		if ( ctype == 1 )
ADDRLP4 132
INDIRI4
CNSTI4 1
NEI4 $980
line 1654
;1654:			self->clientv = "0.96";
ADDRGP4 self
INDIRP4
CNSTI4 1816
ADDP4
ADDRGP4 $982
ASGNP4
ADDRGP4 $981
JUMPV
LABELV $980
line 1655
;1655:		else if ( ctype == 2 )
ADDRLP4 132
INDIRI4
CNSTI4 2
NEI4 $983
line 1656
;1656:			self->clientv = "0.95";
ADDRGP4 self
INDIRP4
CNSTI4 1816
ADDP4
ADDRGP4 $985
ASGNP4
ADDRGP4 $984
JUMPV
LABELV $983
line 1657
;1657:		else if ( ctype == 3 )
ADDRLP4 132
INDIRI4
CNSTI4 3
NEI4 $986
line 1658
;1658:			self->clientv = "0.93";
ADDRGP4 self
INDIRP4
CNSTI4 1816
ADDP4
ADDRGP4 $988
ASGNP4
LABELV $986
LABELV $984
LABELV $981
line 1659
;1659:	}
LABELV $977
line 1660
;1660:	infokey( self, "*z_ver", cl, sizeof( cl ) );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $989
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 infokey
CALLV
pop
line 1661
;1661:	if ( strcmp( cl, "" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $205
ARGP4
ADDRLP4 200
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
EQI4 $990
line 1662
;1662:	{
line 1663
;1663:		ctype = 4;
ADDRLP4 132
CNSTI4 4
ASGNI4
line 1664
;1664:		self->client = "zquake";
ADDRGP4 self
INDIRP4
CNSTI4 1812
ADDP4
ADDRGP4 $992
ASGNP4
line 1665
;1665:		self->clientv = ( string_t ) cl;
ADDRGP4 self
INDIRP4
CNSTI4 1816
ADDP4
ADDRLP4 0
ASGNP4
line 1666
;1666:	}
LABELV $990
line 1667
;1667:	infokey( self, "*FuhQuake", cl, sizeof( cl ) );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $993
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 infokey
CALLV
pop
line 1668
;1668:	if ( strcmp( cl, "" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $205
ARGP4
ADDRLP4 204
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
EQI4 $994
line 1669
;1669:	{
line 1670
;1670:		ctype = 4;
ADDRLP4 132
CNSTI4 4
ASGNI4
line 1671
;1671:		self->client = "fuhquake";
ADDRGP4 self
INDIRP4
CNSTI4 1812
ADDP4
ADDRGP4 $996
ASGNP4
line 1672
;1672:		self->clientv = ( string_t ) cl;
ADDRGP4 self
INDIRP4
CNSTI4 1816
ADDP4
ADDRLP4 0
ASGNP4
line 1673
;1673:	}
LABELV $994
line 1674
;1674:	if ( !strcmp( self->client, "unknown" ) ) // unknown client, so lets just read the raw version info
ADDRGP4 self
INDIRP4
CNSTI4 1812
ADDP4
INDIRP4
ARGP4
ADDRGP4 $966
ARGP4
ADDRLP4 208
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 208
INDIRI4
CNSTI4 0
NEI4 $997
line 1675
;1675:	{
line 1676
;1676:		infokey( self, "*ver", cl, sizeof( cl ) );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $999
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 infokey
CALLV
pop
line 1677
;1677:		if ( strcmp( cl, "" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $205
ARGP4
ADDRLP4 212
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 0
EQI4 $1000
line 1678
;1678:			self->client = cl;
ADDRGP4 self
INDIRP4
CNSTI4 1812
ADDP4
ADDRLP4 0
ASGNP4
LABELV $1000
line 1679
;1679:		infokey( self, "*client", cl, sizeof( cl ) );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $967
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 infokey
CALLV
pop
line 1680
;1680:		if ( strcmp( cl, "" ) )
ADDRLP4 0
ARGP4
ADDRGP4 $205
ARGP4
ADDRLP4 216
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 216
INDIRI4
CNSTI4 0
EQI4 $1002
line 1681
;1681:			self->client = cl;
ADDRGP4 self
INDIRP4
CNSTI4 1812
ADDP4
ADDRLP4 0
ASGNP4
LABELV $1002
line 1682
;1682:	}
LABELV $997
line 1684
;1683:
;1684:	if ( !self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1004
line 1685
;1685:	{
line 1687
;1686:		// print client version here
;1687:		if ( ctype > 0 )
ADDRLP4 132
INDIRI4
CNSTI4 0
LEI4 $1006
line 1688
;1688:			G_bprint( 2, "%s is using %s %s\n", self->s.v.netname, self->client, self->clientv );
CNSTI4 2
ARGI4
ADDRGP4 $1008
ARGP4
ADDRLP4 212
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 212
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRLP4 212
INDIRP4
CNSTI4 1812
ADDP4
INDIRP4
ARGP4
ADDRLP4 212
INDIRP4
CNSTI4 1816
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
ADDRGP4 $1007
JUMPV
LABELV $1006
line 1690
;1689:		else
;1690:			G_bprint( 2, "%s is using %s\n", self->s.v.netname, self->client );
CNSTI4 2
ARGI4
ADDRGP4 $1009
ARGP4
ADDRLP4 216
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 216
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRLP4 216
INDIRP4
CNSTI4 1812
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
LABELV $1007
line 1691
;1691:		self->s.v.modelindex = modelindex_null;
ADDRGP4 self
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 modelindex_null
INDIRI4
CVIF4 4
ASGNF4
line 1692
;1692:		self->current_menu = MENU_DEFAULT;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 1
ASGNI4
line 1693
;1693:	}
LABELV $1004
line 1694
;1694:	setsize( self, PASSVEC3( VEC_HULL_MIN ), PASSVEC3( VEC_HULL_MAX ) );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 VEC_HULL_MIN
INDIRF4
ARGF4
ADDRGP4 VEC_HULL_MIN+4
INDIRF4
ARGF4
ADDRGP4 VEC_HULL_MIN+8
INDIRF4
ARGF4
ADDRGP4 VEC_HULL_MAX
INDIRF4
ARGF4
ADDRGP4 VEC_HULL_MAX+4
INDIRF4
ARGF4
ADDRGP4 VEC_HULL_MAX+8
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 1695
;1695:	SetVector( self->s.v.view_ofs, 0, 0, 22 );
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
line 1696
;1696:	SetVector( self->s.v.velocity, 0, 0, 0 );
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
line 1699
;1697://фикс застревания игроков друг в друге на респавн
;1698://spawn_tdeath после установки размеров игрока
;1699:	if ( self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1014
line 1700
;1700:		spawn_tdeath( spot->s.v.origin, self );
ADDRLP4 128
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
LABELV $1014
line 1702
;1701:
;1702:	player_stand1();
ADDRGP4 player_stand1
CALLV
pop
line 1703
;1703:	if ( deathmatch || coop )
ADDRLP4 212
CNSTI4 0
ASGNI4
ADDRGP4 deathmatch
INDIRI4
ADDRLP4 212
INDIRI4
NEI4 $1018
ADDRGP4 coop
INDIRI4
ADDRLP4 212
INDIRI4
EQI4 $1016
LABELV $1018
line 1704
;1704:	{
line 1705
;1705:		makevectors( self->s.v.angles );
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 1706
;1706:		if ( self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1019
line 1707
;1707:		{
line 1708
;1708:			VectorScale( g_globalvars.v_forward, 20, v );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1101004800
ARGF4
ADDRLP4 152
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 1709
;1709:			VectorAdd( v, self->s.v.origin, v );
ADDRLP4 152
ADDRLP4 152
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 152+4
ADDRLP4 152+4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 152+8
ADDRLP4 152+8
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1710
;1710:			spawn_tfog( v );
ADDRLP4 152
ARGP4
ADDRGP4 spawn_tfog
CALLV
pop
line 1711
;1711:		}
LABELV $1019
line 1712
;1712:	}
LABELV $1016
line 1713
;1713:	infokey( world, "rj", s, sizeof( s ) );
ADDRGP4 world
INDIRP4
ARGP4
ADDRGP4 $1026
ARGP4
ADDRLP4 136
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 infokey
CALLV
pop
line 1714
;1714:	if ( atof( s ) != 0 )
ADDRLP4 136
ARGP4
ADDRLP4 216
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 216
INDIRF4
CNSTF4 0
EQF4 $1027
line 1715
;1715:	{
line 1716
;1716:		rj = atof( s );
ADDRLP4 136
ARGP4
ADDRLP4 220
ADDRGP4 atof
CALLF4
ASGNF4
ADDRGP4 rj
ADDRLP4 220
INDIRF4
ASGNF4
line 1717
;1717:	} else
ADDRGP4 $1028
JUMPV
LABELV $1027
line 1718
;1718:		rj = 2;
ADDRGP4 rj
CNSTF4 1073741824
ASGNF4
LABELV $1028
line 1720
;1719:
;1720:	if ( tf_data.cease_fire )
ADDRGP4 tf_data+72
INDIRI4
CNSTI4 0
EQI4 $1029
line 1721
;1721:	{
line 1722
;1722:		G_sprint( self, 2, "\n\nCEASE FIRE MODE\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1032
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1723
;1723:		self->tfstate |= TFSTATE_CANT_MOVE;
ADDRLP4 220
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 220
INDIRP4
ADDRLP4 220
INDIRP4
INDIRI4
CNSTI4 65536
BORI4
ASGNI4
line 1724
;1724:		TeamFortress_SetSpeed( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 1725
;1725:	}
LABELV $1029
line 1726
;1726:	if ( !strneq( self->s.v.noise, "player/mdeath5.wav" ) )
ADDRGP4 self
INDIRP4
CNSTI4 504
ADDP4
INDIRP4
ARGP4
ADDRGP4 $1035
ARGP4
ADDRLP4 220
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 220
INDIRI4
CNSTI4 0
NEI4 $1033
line 1727
;1727:	{
line 1728
;1728:		sound( self, 2, "player/malive5.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1036
ARGP4
ADDRLP4 224
CNSTF4 1065353216
ASGNF4
ADDRLP4 224
INDIRF4
ARGF4
ADDRLP4 224
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 1729
;1729:	}
LABELV $1033
line 1730
;1730:}
LABELV $901
endproc PutClientInServer 228 28
export SP_Null_tf_spawn
proc SP_Null_tf_spawn 4 4
line 1734
;1731:
;1732:
;1733:void SP_Null_tf_spawn()
;1734:{
line 1735
;1735:	if ( !CheckExistence() )
ADDRLP4 0
ADDRGP4 CheckExistence
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1038
line 1736
;1736:	{
line 1737
;1737:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 1738
;1738:		return;
LABELV $1038
line 1740
;1739:	}
;1740:}
LABELV $1037
endproc SP_Null_tf_spawn 4 4
export PrintClientScore
proc PrintClientScore 4 16
line 1744
;1741:
;1742:
;1743:void PrintClientScore( gedict_t * c )
;1744:{
line 1745
;1745:	G_bprint( 1, "%3d %s\n", c->s.v.frags, c->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $1041
ARGP4
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 300
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 1746
;1746:}
LABELV $1040
endproc PrintClientScore 4 16
data
align 4
LABELV already_cycled
byte 4 0
export NextLevel
code
proc NextLevel 8 0
line 1763
;1747:
;1748:
;1749:/*
;1750:===============================================================================
;1751:
;1752:RULES
;1753:
;1754:===============================================================================
;1755:*/
;1756:static int     already_cycled = 0;
;1757:
;1758:/*
;1759:go to the next level 
;1760:*/
;1761:
;1762:void NextLevel()
;1763:{
line 1766
;1764:	gedict_t *o;
;1765:
;1766:	if ( already_cycled )
ADDRGP4 already_cycled
INDIRI4
CNSTI4 0
EQI4 $1043
line 1767
;1767:		return;
ADDRGP4 $1042
JUMPV
LABELV $1043
line 1768
;1768:	already_cycled = 1;
ADDRGP4 already_cycled
CNSTI4 1
ASGNI4
line 1769
;1769:	o = spawn();
ADDRLP4 4
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1770
;1770:	o->map = nextmap;
ADDRLP4 0
INDIRP4
CNSTI4 540
ADDP4
ADDRGP4 nextmap
ASGNP4
line 1772
;1771:
;1772:	o->s.v.think = ( func_t ) execute_changelevel;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 execute_changelevel
CVPU4 4
CVUI4 4
ASGNI4
line 1773
;1773:	o->s.v.nextthink = g_globalvars.time + 0.1;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 1774
;1774:}
LABELV $1042
endproc NextLevel 8 0
export CheckRules
proc CheckRules 8 0
line 1785
;1775:
;1776:/*
;1777:============
;1778:CheckRules
;1779:
;1780:Exit games upon conditions
;1781:============
;1782:*/
;1783:
;1784:void CheckRules()
;1785:{
line 1786
;1786:	if ( timelimit && g_globalvars.time >= timelimit )
ADDRLP4 0
ADDRGP4 timelimit
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1047
ADDRGP4 g_globalvars+124
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
LTF4 $1047
line 1787
;1787:		NextLevel();
ADDRGP4 NextLevel
CALLV
pop
LABELV $1047
line 1789
;1788:
;1789:	if ( fraglimit && self->s.v.frags >= fraglimit )
ADDRLP4 4
ADDRGP4 fraglimit
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1050
ADDRGP4 self
INDIRP4
CNSTI4 300
ADDP4
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
LTF4 $1050
line 1790
;1790:		NextLevel();
ADDRGP4 NextLevel
CALLV
pop
LABELV $1050
line 1791
;1791:}
LABELV $1046
endproc CheckRules 8 0
export PlayerDeathThink
proc PlayerDeathThink 20 12
line 1796
;1792:
;1793://============================================================================
;1794:
;1795:void PlayerDeathThink()
;1796:{
line 1800
;1797:	//gedict_t* old_self;
;1798:	float   forward;
;1799:
;1800:	if ( ( ( int ) ( self->s.v.flags ) ) & FL_ONGROUND )
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1053
line 1801
;1801:	{
line 1802
;1802:		forward = vlen( self->s.v.velocity );
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1803
;1803:		forward = forward - 20;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
line 1804
;1804:		if ( forward <= 0 )
ADDRLP4 0
INDIRF4
CNSTF4 0
GTF4 $1055
line 1805
;1805:			SetVector( self->s.v.velocity, 0, 0, 0 );
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
ADDRGP4 $1056
JUMPV
LABELV $1055
line 1807
;1806:		else
;1807:		{
line 1808
;1808:			VectorNormalize( self->s.v.velocity );
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1809
;1809:			VectorScale( self->s.v.velocity, forward, self->s.v.velocity );
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 1810
;1810:		}
LABELV $1056
line 1811
;1811:	}
LABELV $1053
line 1813
;1812:// wait for all buttons released
;1813:	if ( self->s.v.deadflag == DEAD_DEAD )
ADDRGP4 self
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $1057
line 1814
;1814:	{
line 1815
;1815:		if ( self->s.v.button2 || self->s.v.button1 || self->s.v.button0 )
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 372
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
NEF4 $1062
ADDRLP4 4
INDIRP4
CNSTI4 368
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
NEF4 $1062
ADDRLP4 4
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
EQF4 $1059
LABELV $1062
line 1816
;1816:			return;
ADDRGP4 $1052
JUMPV
LABELV $1059
line 1817
;1817:		self->s.v.deadflag = DEAD_RESPAWNABLE;
ADDRGP4 self
INDIRP4
CNSTI4 348
ADDP4
CNSTF4 1077936128
ASGNF4
line 1818
;1818:		self->tfstate -= ( self->tfstate & TFSTATE_RESPAWN_READY );
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
CNSTI4 8192
BANDI4
SUBI4
ASGNI4
line 1819
;1819:		return;
ADDRGP4 $1052
JUMPV
LABELV $1057
line 1822
;1820:	}
;1821:// wait for any button down
;1822:	if ( !self->s.v.button2 && !self->s.v.button1 && !self->s.v.button0 )
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 372
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
NEF4 $1063
ADDRLP4 4
INDIRP4
CNSTI4 368
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
NEF4 $1063
ADDRLP4 4
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
NEF4 $1063
line 1823
;1823:	{
line 1824
;1824:		if ( self->tfstate & TFSTATE_RESPAWN_READY )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1052
line 1825
;1825:		{
line 1826
;1826:			if ( self->respawn_time <= g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 988
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GTF4 $1052
line 1827
;1827:			{
line 1828
;1828:				self->s.v.button0 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 364
ADDP4
CNSTF4 0
ASGNF4
line 1829
;1829:				self->s.v.button1 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 368
ADDP4
CNSTF4 0
ASGNF4
line 1830
;1830:				self->s.v.button2 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 372
ADDP4
CNSTF4 0
ASGNF4
line 1831
;1831:				respawn();
ADDRGP4 respawn
CALLV
pop
line 1832
;1832:			}
line 1833
;1833:		}
line 1834
;1834:		return;
ADDRGP4 $1052
JUMPV
LABELV $1063
line 1836
;1835:	} else
;1836:	{
line 1837
;1837:		self->tfstate |= TFSTATE_RESPAWN_READY;
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
line 1838
;1838:		if ( self->respawn_time <= g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 988
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GTF4 $1052
line 1839
;1839:		{
line 1840
;1840:			self->s.v.button0 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 364
ADDP4
CNSTF4 0
ASGNF4
line 1841
;1841:			self->s.v.button1 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 368
ADDP4
CNSTF4 0
ASGNF4
line 1842
;1842:			self->s.v.button2 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 372
ADDP4
CNSTF4 0
ASGNF4
line 1843
;1843:			respawn();
ADDRGP4 respawn
CALLV
pop
line 1844
;1844:		}
line 1845
;1845:		return;
LABELV $1052
endproc PlayerDeathThink 20 12
export PlayerJump
proc PlayerJump 12 20
line 1850
;1846:	}
;1847:}
;1848:
;1849:void PlayerJump()
;1850:{
line 1854
;1851://      vec3_t  start;
;1852://      vec3_t  end;
;1853:
;1854:	if ( self->has_disconnected == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1074
line 1855
;1855:		return;
ADDRGP4 $1073
JUMPV
LABELV $1074
line 1856
;1856:	if ( ( ( int ) ( self->s.v.flags ) ) & FL_WATERJUMP )
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1076
line 1857
;1857:		return;
ADDRGP4 $1073
JUMPV
LABELV $1076
line 1860
;1858:
;1859:	// heguy post-20mm anti-speedbug
;1860:	if ( self->nojumptime > g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 1016
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $1078
line 1861
;1861:	{
line 1862
;1862:		if ( self->s.v.velocity[0] > 70 )
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
CNSTF4 1116471296
LEF4 $1081
line 1863
;1863:			self->s.v.velocity[0] = 70;
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1116471296
ASGNF4
ADDRGP4 $1082
JUMPV
LABELV $1081
line 1865
;1864:		else
;1865:		{
line 1866
;1866:			if ( self->s.v.velocity[0] < -70 )
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
CNSTF4 3263954944
GEF4 $1083
line 1867
;1867:				self->s.v.velocity[0] = -70;
ADDRGP4 self
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 3263954944
ASGNF4
LABELV $1083
line 1868
;1868:		}
LABELV $1082
line 1869
;1869:		if ( self->s.v.velocity[1] > 70 )
ADDRGP4 self
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
CNSTF4 1116471296
LEF4 $1085
line 1870
;1870:			self->s.v.velocity[1] = 70;
ADDRGP4 self
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1116471296
ASGNF4
ADDRGP4 $1086
JUMPV
LABELV $1085
line 1872
;1871:		else
;1872:		{
line 1873
;1873:			if ( self->s.v.velocity[1] < -70 )
ADDRGP4 self
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
CNSTF4 3263954944
GEF4 $1087
line 1874
;1874:				self->s.v.velocity[1] = -70;
ADDRGP4 self
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 3263954944
ASGNF4
LABELV $1087
line 1875
;1875:		}
LABELV $1086
line 1876
;1876:	}
LABELV $1078
line 1878
;1877:
;1878:	if ( self->s.v.waterlevel >= 2 )
ADDRGP4 self
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 1073741824
LTF4 $1089
line 1879
;1879:	{
line 1880
;1880:		if ( self->s.v.watertype == -3 )
ADDRGP4 self
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
CNSTF4 3225419776
NEF4 $1091
line 1881
;1881:			self->s.v.velocity[2] = 100;
ADDRGP4 self
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1120403456
ASGNF4
ADDRGP4 $1092
JUMPV
LABELV $1091
line 1883
;1882:		else
;1883:		{
line 1884
;1884:			if ( self->s.v.watertype == -4 )
ADDRGP4 self
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
CNSTF4 3229614080
NEF4 $1093
line 1885
;1885:				self->s.v.velocity[2] = 80;
ADDRGP4 self
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1117782016
ASGNF4
ADDRGP4 $1094
JUMPV
LABELV $1093
line 1887
;1886:			else
;1887:				self->s.v.velocity[2] = 50;
ADDRGP4 self
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1112014848
ASGNF4
LABELV $1094
line 1888
;1888:		}
LABELV $1092
line 1889
;1889:		if ( self->swim_flag < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 792
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $1073
line 1890
;1890:		{
line 1891
;1891:			self->swim_flag = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 792
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1892
;1892:			if ( g_random() < 0.5 )
ADDRLP4 0
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
GEF4 $1099
line 1893
;1893:				sound( self, 4, "misc/water1.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1101
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
ADDRGP4 $1073
JUMPV
LABELV $1099
line 1895
;1894:			else
;1895:				sound( self, 4, "misc/water2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1102
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
line 1896
;1896:		}
line 1908
;1897:/*//REMOVE!!! 
;1898:if (self.fire_held_down && self.current_weapon == 32768) {
;1899:   stuffcmd(self, "v_idlescale 0\n");
;1900:   self->tfstate = self->tfstate - (self->tfstate & 2048);
;1901:   TeamFortress_SetSpeed(self);
;1902:   self->s.v.weaponframe = 0;
;1903:   self.heat = 0;
;1904:   self.count = 1;
;1905:   player_assaultcannondown1();
;1906:  }*/
;1907:
;1908:		return;
ADDRGP4 $1073
JUMPV
LABELV $1089
line 1910
;1909:	}
;1910:	if ( !( ( int ) self->s.v.flags & FL_ONGROUND ) )
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $1103
line 1911
;1911:		return;
ADDRGP4 $1073
JUMPV
LABELV $1103
line 1912
;1912:	if ( !( ( int ) self->s.v.flags & FL_JUMPRELEASED ) )
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $1105
line 1913
;1913:		return;
ADDRGP4 $1073
JUMPV
LABELV $1105
line 1916
;1914://	if ( self->playerclass == PC_SPY )
;1915://		self->s.v.velocity[2] += 130;
;1916:	self->s.v.flags = ( int ) self->s.v.flags - ( ( int ) self->s.v.flags & FL_JUMPRELEASED );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 4096
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 1917
;1917:	self->s.v.button2 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 372
ADDP4
CNSTF4 0
ASGNF4
line 1918
;1918:	if (self->playerclass == PC_SPY) {
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1107
line 1919
;1919:		self->do_spyjump = g_globalvars.time + 1.25;		// seems to be the lesser of the 2 evil ways to do mtf spy jump physics :x
ADDRGP4 self
INDIRP4
CNSTI4 1004
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1067450368
ADDF4
CVFI4 4
ASGNI4
line 1920
;1920:		sound( self, 4, "hknight/slash1.wav", 0.7, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1110
ARGP4
CNSTF4 1060320051
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 sound
CALLV
pop
line 1921
;1921:	}
ADDRGP4 $1108
JUMPV
LABELV $1107
line 1923
;1922:	else
;1923:		sound( self, 4, "player/plyrjmp8.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1111
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
LABELV $1108
line 1935
;1924:/* if (self.fire_held_down && self.current_weapon == 32768) {
;1925:  stuffcmd(self, "v_idlescale 0\n");
;1926:  sprint(self, 1, "You cannot fire the assault cannon without your feet on the ground...\n");
;1927:  self->tfstate = self->tfstate - (self->tfstate & 2048);
;1928:  TeamFortress_SetSpeed(self);
;1929:  self->s.v.weaponframe = 0;
;1930:  self.count = 1;
;1931:  self.heat = 0;
;1932:  player_assaultcannondown1();
;1933: }*/
;1934:
;1935:}
LABELV $1073
endproc PlayerJump 12 20
export WaterMove
proc WaterMove 16 24
line 1940
;1936:
;1937:
;1938:
;1939:void WaterMove()
;1940:{
line 1941
;1941:	if ( self->s.v.movetype == MOVETYPE_NOCLIP )
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
INDIRF4
CNSTF4 1090519040
NEF4 $1113
line 1942
;1942:		return;
ADDRGP4 $1112
JUMPV
LABELV $1113
line 1944
;1943:
;1944:	if ( self->s.v.health < 0 )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1115
line 1945
;1945:		return;
ADDRGP4 $1112
JUMPV
LABELV $1115
line 1946
;1946:	if ( self->s.v.waterlevel != 3 )
ADDRGP4 self
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 1077936128
EQF4 $1117
line 1947
;1947:	{
line 1948
;1948:		if ( self->air_finished < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 796
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $1119
line 1949
;1949:			sound( self, CHAN_VOICE, "player/gasp2.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1122
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
ADDRGP4 $1120
JUMPV
LABELV $1119
line 1950
;1950:		else if ( self->air_finished < g_globalvars.time + 9 )
ADDRGP4 self
INDIRP4
CNSTI4 796
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1091567616
ADDF4
GEF4 $1123
line 1951
;1951:			sound( self, CHAN_VOICE, "player/gasp1.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1126
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
LABELV $1123
LABELV $1120
line 1953
;1952:
;1953:		self->air_finished = g_globalvars.time + 12;
ADDRGP4 self
INDIRP4
CNSTI4 796
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1094713344
ADDF4
ASGNF4
line 1954
;1954:		self->dmg = 2;
ADDRGP4 self
INDIRP4
CNSTI4 716
ADDP4
CNSTF4 1073741824
ASGNF4
line 1956
;1955:
;1956:	} else if ( self->air_finished < g_globalvars.time )
ADDRGP4 $1118
JUMPV
LABELV $1117
ADDRGP4 self
INDIRP4
CNSTI4 796
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $1128
line 1957
;1957:	{			// drown!
line 1958
;1958:		if ( self->pain_finished < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 728
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $1131
line 1959
;1959:		{
line 1960
;1960:			self->dmg = self->dmg + 2;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 716
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 1961
;1961:			if ( self->dmg > 15 )
ADDRGP4 self
INDIRP4
CNSTI4 716
ADDP4
INDIRF4
CNSTF4 1097859072
LEF4 $1134
line 1962
;1962:				self->dmg = 10;
ADDRGP4 self
INDIRP4
CNSTI4 716
ADDP4
CNSTF4 1092616192
ASGNF4
LABELV $1134
line 1964
;1963:
;1964:			TF_T_Damage( self, world, world, self->dmg, 1, 0 );
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 world
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 4
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
line 1965
;1965:			self->pain_finished = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 728
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1966
;1966:		}
LABELV $1131
line 1967
;1967:	}
LABELV $1128
LABELV $1118
line 1968
;1968:	if ( !self->s.v.waterlevel )
ADDRGP4 self
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 0
NEF4 $1137
line 1969
;1969:	{
line 1970
;1970:		if ( ( ( int ) ( self->s.v.flags ) ) & FL_INWATER )
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1112
line 1971
;1971:		{
line 1973
;1972:			// play leave water sound
;1973:			sound( self, CHAN_BODY, "misc/outwater.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1141
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
line 1974
;1974:			self->s.v.flags -= FL_INWATER;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1975
;1975:		}
line 1976
;1976:		return;
ADDRGP4 $1112
JUMPV
LABELV $1137
line 1979
;1977:	}
;1978:
;1979:	if ( self->s.v.watertype == CONTENT_LAVA )
ADDRGP4 self
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
CNSTF4 3231711232
NEF4 $1142
line 1980
;1980:	{			// do damage
line 1981
;1981:		if ( self->dmgtime < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 808
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $1143
line 1982
;1982:		{
line 1983
;1983:			if ( self->radsuit_finished > g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 744
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $1147
line 1984
;1984:				self->dmgtime = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 808
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
ADDRGP4 $1148
JUMPV
LABELV $1147
line 1986
;1985:			else
;1986:				self->dmgtime = g_globalvars.time + 0.2;
ADDRGP4 self
INDIRP4
CNSTI4 808
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
LABELV $1148
line 1988
;1987:
;1988:			TF_T_Damage( self, world, world, 10 * self->s.v.waterlevel, 0, 16 );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 world
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1092616192
ADDRLP4 0
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
MULF4
ARGF4
CNSTI4 0
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 1989
;1989:		}
line 1991
;1990:
;1991:	} else
ADDRGP4 $1143
JUMPV
LABELV $1142
line 1992
;1992:	{
line 1993
;1993:		if ( self->s.v.watertype == CONTENT_SLIME )
ADDRGP4 self
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
CNSTF4 3229614080
NEF4 $1152
line 1994
;1994:		{		// do damage
line 1995
;1995:			if ( self->dmgtime < g_globalvars.time && self->radsuit_finished < g_globalvars.time )
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $1154
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $1154
line 1996
;1996:			{
line 1997
;1997:				self->dmgtime = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 808
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1998
;1998:				T_Damage( self, world, world, 4 * self->s.v.waterlevel ); //!!! fix me for TF_T_Damage ???
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 world
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 1082130432
ADDRLP4 4
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
MULF4
ARGF4
ADDRGP4 T_Damage
CALLV
pop
line 1999
;1999:			}
LABELV $1154
line 2000
;2000:		}
LABELV $1152
line 2001
;2001:	}
LABELV $1143
line 2002
;2002:	if ( !( ( ( int ) ( self->s.v.flags ) ) & FL_INWATER ) )
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $1159
line 2003
;2003:	{
line 2007
;2004:
;2005:// player enter water sound
;2006:
;2007:		if ( self->s.v.watertype == CONTENT_LAVA )
ADDRGP4 self
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
CNSTF4 3231711232
NEF4 $1161
line 2008
;2008:			sound( self, CHAN_BODY, "player/inlava.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1163
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
LABELV $1161
line 2009
;2009:		if ( self->s.v.watertype == CONTENT_WATER )
ADDRGP4 self
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
CNSTF4 3225419776
NEF4 $1164
line 2010
;2010:			sound( self, CHAN_BODY, "player/inh2o.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1166
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
LABELV $1164
line 2011
;2011:		if ( self->s.v.watertype == CONTENT_SLIME )
ADDRGP4 self
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
CNSTF4 3229614080
NEF4 $1167
line 2012
;2012:			sound( self, CHAN_BODY, "player/slimbrn2.wav", 1, ATTN_NORM );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1169
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
LABELV $1167
line 2014
;2013:
;2014:		self->s.v.flags += FL_INWATER;
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 2015
;2015:		self->dmgtime = 0;
ADDRGP4 self
INDIRP4
CNSTI4 808
ADDP4
CNSTF4 0
ASGNF4
line 2016
;2016:	}
LABELV $1159
line 2017
;2017:}
LABELV $1112
endproc WaterMove 16 24
export CheckWaterJump
proc CheckWaterJump 36 32
line 2020
;2018:
;2019:void CheckWaterJump()
;2020:{
line 2025
;2021:	vec3_t  start;
;2022:	vec3_t  end;
;2023:
;2024:// check for a jump-out-of-water
;2025:	makevectors( self->s.v.angles );
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 2027
;2026:
;2027:	VectorCopy( self->s.v.origin, start );	//start = self->s.v.origin;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 2028
;2028:	start[2] = start[2] + 8;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 2029
;2029:	g_globalvars.v_forward[2] = 0;
ADDRGP4 g_globalvars+228+8
CNSTF4 0
ASGNF4
line 2031
;2030:
;2031:	VectorNormalize( g_globalvars.v_forward );
ADDRGP4 g_globalvars+228
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2032
;2032:	VectorScale( g_globalvars.v_forward, 24, end );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1103101952
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 2033
;2033:	VectorAdd( start, end, end );	//end = start + v_forward*24;
ADDRLP4 12
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDF4
ASGNF4
line 2035
;2034:
;2035:	traceline( PASSVEC3( start ), PASSVEC3( end ), true, self );
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
CNSTI4 1
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 2037
;2036:
;2037:	if ( g_globalvars.trace_fraction < 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
GEF4 $1189
line 2038
;2038:	{			// solid at waist
line 2039
;2039:		start[2] = start[2] + self->s.v.maxs[2] - 8;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
SUBF4
ASGNF4
line 2040
;2040:		VectorScale( g_globalvars.v_forward, 24, end );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1103101952
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 2041
;2041:		VectorAdd( start, end, end );	//end = start + v_forward*24;
ADDRLP4 12
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDF4
ASGNF4
line 2042
;2042:		VectorScale( g_globalvars.trace_plane_normal, -50, self->s.v.movedir );	//self->s.v.movedir = trace_plane_normal * -50;
ADDRGP4 g_globalvars+288
ARGP4
CNSTF4 3259498496
ARGF4
ADDRGP4 self
INDIRP4
CNSTI4 484
ADDP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 2044
;2043:
;2044:		traceline( PASSVEC3( start ), PASSVEC3( end ), true, self );
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
CNSTI4 1
ARGI4
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 2046
;2045:
;2046:		if ( g_globalvars.trace_fraction == 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
NEF4 $1206
line 2047
;2047:		{		// open at eye level
line 2048
;2048:			self->s.v.flags = ( ( int ) ( self->s.v.flags ) ) | FL_WATERJUMP;
ADDRLP4 24
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 2048
BORI4
CVIF4 4
ASGNF4
line 2049
;2049:			self->s.v.velocity[2] = 225;
ADDRGP4 self
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1130430464
ASGNF4
line 2050
;2050:			self->s.v.flags -= ( ( ( int ) ( self->s.v.flags ) ) & FL_JUMPRELEASED );
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
ASGNF4
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRF4
ADDRLP4 32
INDIRF4
CVFI4 4
CNSTI4 4096
BANDI4
CVIF4 4
SUBF4
ASGNF4
line 2051
;2051:			self->s.v.teleport_time = g_globalvars.time + 2;	// safety net
ADDRGP4 self
INDIRP4
CNSTI4 420
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 2052
;2052:			return;
LABELV $1206
line 2054
;2053:		}
;2054:	}
LABELV $1189
line 2055
;2055:}
LABELV $1170
endproc CheckWaterJump 36 32
export PlayerPreThink
proc PlayerPreThink 36 12
line 2071
;2056:
;2057:////////////////
;2058:// GlobalParams:
;2059:// time
;2060:// frametime
;2061:// self
;2062:///////////////
;2063:/*
;2064:================
;2065:PlayerPreThink
;2066:
;2067:Called every frame before physics are run
;2068:================
;2069:*/
;2070:void PlayerPreThink()
;2071:{
line 2079
;2072://      float   mspeed;
;2073://      float   aspeed;
;2074://      float   r;
;2075://      vec3_t  src;
;2076:	float o_g;		// on ground
;2077:
;2078:
;2079:	if ( self->is_feigning && self->s.v.waterlevel == 1 )
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1211
ADDRLP4 4
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $1211
line 2080
;2080:	{
line 2081
;2081:		self->s.v.watertype = -3;
ADDRGP4 self
INDIRP4
CNSTI4 436
ADDP4
CNSTF4 3225419776
ASGNF4
line 2082
;2082:		self->s.v.waterlevel = 3;
ADDRGP4 self
INDIRP4
CNSTI4 432
ADDP4
CNSTF4 1077936128
ASGNF4
line 2083
;2083:	}
LABELV $1211
line 2084
;2084:	if ( self->cheat_level > 0 )
ADDRGP4 self
INDIRP4
CNSTI4 1468
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1213
line 2085
;2085:		self->cheat_level -= 1;
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 1468
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1213
line 2087
;2086:
;2087:	if ( intermission_running )
ADDRGP4 intermission_running
INDIRF4
CNSTF4 0
EQF4 $1215
line 2088
;2088:	{
line 2089
;2089:		if ( intermission_running && self->last_used != 999 )
ADDRGP4 intermission_running
INDIRF4
CNSTF4 0
EQF4 $1217
ADDRGP4 self
INDIRP4
CNSTI4 1772
ADDP4
INDIRI4
CNSTI4 999
EQI4 $1217
line 2090
;2090:		{
line 2091
;2091:			if ( g_random() < 0.5 )
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
CNSTF4 1056964608
GEF4 $1219
line 2092
;2092:			{
line 2093
;2093:				stuffcmd( self, "play music/megamnu1.wav\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1221
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 2094
;2094:			}
ADDRGP4 $1220
JUMPV
LABELV $1219
line 2096
;2095:			else
;2096:			{
line 2097
;2097:				stuffcmd( self, "play music/megamnu2.wav\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1222
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 2098
;2098:			}
LABELV $1220
line 2099
;2099:			self->last_used = 999;
ADDRGP4 self
INDIRP4
CNSTI4 1772
ADDP4
CNSTI4 999
ASGNI4
line 2100
;2100:		}
LABELV $1217
line 2101
;2101:		IntermissionThink();	// otherwise a button could be missed between
ADDRGP4 IntermissionThink
CALLV
pop
line 2102
;2102:		return;		// the think tics
ADDRGP4 $1210
JUMPV
LABELV $1215
line 2105
;2103:	}
;2104:
;2105:	makevectors( self->s.v.v_angle );	// is this still used
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 2107
;2106:
;2107:	if ( !self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1223
line 2108
;2108:	{
line 2109
;2109:		if ( self->s.v.button2 && ( self->current_menu == MENU_TEAM ) && !self->team_no )
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 372
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1225
ADDRLP4 12
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1225
ADDRLP4 12
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1225
line 2110
;2110:		{
line 2111
;2111:			if ( TeamFortress_TeamPutPlayerInTeam() )
ADDRLP4 16
ADDRGP4 TeamFortress_TeamPutPlayerInTeam
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $1227
line 2112
;2112:			{
line 2113
;2113:				self->current_menu = MENU_CLASS;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 3
ASGNI4
line 2114
;2114:				self->menu_count = MENU_REFRESH_RATE;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 25
ASGNI4
line 2115
;2115:			}
LABELV $1227
line 2116
;2116:		}
LABELV $1225
line 2117
;2117:	}
LABELV $1223
line 2118
;2118:	if ( self->s.v.view_ofs[0] == 0 && self->s.v.view_ofs[1] == 0 && self->s.v.view_ofs[2] == 0 )
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 352
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
NEF4 $1229
ADDRLP4 12
INDIRP4
CNSTI4 356
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
NEF4 $1229
ADDRLP4 12
INDIRP4
CNSTI4 360
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
NEF4 $1229
line 2119
;2119:		return;		// intermission or finale
ADDRGP4 $1210
JUMPV
LABELV $1229
line 2121
;2120:
;2121:	CheckRules();
ADDRGP4 CheckRules
CALLV
pop
line 2122
;2122:	if ( self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1231
line 2123
;2123:		WaterMove();
ADDRGP4 WaterMove
CALLV
pop
LABELV $1231
line 2124
;2124:	if ( self->s.v.deadflag >= DEAD_DEAD )
ADDRGP4 self
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
CNSTF4 1073741824
LTF4 $1233
line 2125
;2125:	{
line 2126
;2126:		PlayerDeathThink();
ADDRGP4 PlayerDeathThink
CALLV
pop
line 2127
;2127:		return;
ADDRGP4 $1210
JUMPV
LABELV $1233
line 2130
;2128:	}
;2129:
;2130:	if ( self->undercover_team || self->undercover_skin || self->is_undercover )
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $1238
ADDRLP4 20
INDIRP4
CNSTI4 1408
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $1238
ADDRLP4 20
INDIRP4
CNSTI4 868
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $1235
LABELV $1238
line 2131
;2131:	{
line 2132
;2132:		if ( ( int ) self->s.v.effects & ( 8 | 4 ) )
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CVFI4 4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $1239
line 2133
;2133:		{
line 2134
;2134:			G_sprint( self, 1, "The glowing removes your disguise.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $1241
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2135
;2135:			Spy_RemoveDisguise( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 Spy_RemoveDisguise
CALLV
pop
line 2136
;2136:		}
LABELV $1239
line 2137
;2137:	}
LABELV $1235
line 2138
;2138:	if ( self->s.v.deadflag == DEAD_DYING )
ADDRGP4 self
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $1242
line 2139
;2139:		return;
ADDRGP4 $1210
JUMPV
LABELV $1242
line 2140
;2140:	if ( !self->is_feigning )
ADDRGP4 self
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1244
line 2141
;2141:	{
line 2142
;2142:		if ( self->do_spyjump != 0 && self->do_spyjump > g_globalvars.time ) {
ADDRLP4 28
ADDRGP4 self
INDIRP4
CNSTI4 1004
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $1246
ADDRLP4 28
INDIRI4
CVIF4 4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $1246
line 2143
;2143:			self->s.v.velocity[2] += 130;
ADDRLP4 32
ADDRGP4 self
INDIRP4
CNSTI4 188
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
CNSTF4 1124204544
ADDF4
ASGNF4
line 2144
;2144:			self->do_spyjump = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1004
ADDP4
CNSTI4 0
ASGNI4
line 2145
;2145:		}
LABELV $1246
line 2146
;2146:		if ( self->s.v.button2 ) {
ADDRGP4 self
INDIRP4
CNSTI4 372
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1249
line 2147
;2147:			if ( ( ( int ) self->s.v.flags & FL_ONGROUND ) )
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1251
line 2148
;2148:				o_g = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
LABELV $1251
line 2149
;2149:			PlayerJump();
ADDRGP4 PlayerJump
CALLV
pop
line 2152
;2150:			//if ( !self->s.v.waterlevel && self->playerclass == PC_SPY && o_g == 1 )
;2151:			//	self->do_spyjump = TRUE;
;2152:		}
ADDRGP4 $1245
JUMPV
LABELV $1249
line 2154
;2153:		else
;2154:			self->s.v.flags = ( int ) self->s.v.flags | FL_JUMPRELEASED;
ADDRLP4 32
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 4096
BORI4
CVIF4 4
ASGNF4
line 2155
;2155:	} else
ADDRGP4 $1245
JUMPV
LABELV $1244
line 2156
;2156:	{
line 2157
;2157:		if ( self->s.v.waterlevel )
ADDRGP4 self
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1253
line 2158
;2158:			self->s.v.velocity[2] = -100;
ADDRGP4 self
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 3267887104
ASGNF4
LABELV $1253
line 2159
;2159:	}
LABELV $1245
line 2160
;2160:	if ( g_globalvars.time < self->pausetime || tf_data.cease_fire == 1 )
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
LTF4 $1259
ADDRGP4 tf_data+72
INDIRI4
CNSTI4 1
NEI4 $1255
LABELV $1259
line 2161
;2161:		SetVector( self->s.v.velocity, 0, 0, 0 );
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
LABELV $1255
line 2162
;2162:	if ( g_globalvars.time > self->attack_finished && !self->s.v.currentammo && self->s.v.weapon > 16 )
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRGP4 g_globalvars+124
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
LEF4 $1260
ADDRLP4 28
INDIRP4
CNSTI4 316
ADDP4
INDIRF4
CNSTF4 0
NEF4 $1260
ADDRLP4 28
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1098907648
LEF4 $1260
line 2163
;2163:	{
line 2164
;2164:		self->s.v.weapon = W_BestWeapon();
ADDRLP4 32
ADDRGP4 W_BestWeapon
CALLI4
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
ADDRLP4 32
INDIRI4
CVIF4 4
ASGNF4
line 2165
;2165:		W_SetCurrentAmmo();
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 2166
;2166:	}
LABELV $1260
line 2167
;2167:	if ( self->on_hook )
ADDRGP4 self
INDIRP4
CNSTI4 1444
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1263
line 2168
;2168:		Service_Grapple();
ADDRGP4 Service_Grapple
CALLV
pop
LABELV $1263
line 2169
;2169:}
LABELV $1210
endproc PlayerPreThink 36 12
export CheckPowerups
proc CheckPowerups 28 20
line 2180
;2170:
;2171://///////////////////////////////////////////////////////////////
;2172:/*
;2173:================
;2174:CheckPowerups
;2175:
;2176:Check for turning off powerups
;2177:================
;2178:*/
;2179:void CheckPowerups()
;2180:{
line 2184
;2181:	float   lighton;
;2182:	gedict_t *te;
;2183:
;2184:	if ( self->s.v.health <= 0 )
ADDRGP4 self
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
GTF4 $1266
line 2185
;2185:		return;
ADDRGP4 $1265
JUMPV
LABELV $1266
line 2187
;2186:
;2187:	if ( !self->playerclass )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1268
line 2188
;2188:		self->s.v.modelindex = modelindex_null;
ADDRGP4 self
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 modelindex_null
INDIRI4
CVIF4 4
ASGNF4
ADDRGP4 $1269
JUMPV
LABELV $1268
line 2190
;2189:	else
;2190:	{
line 2191
;2191:		if ( self->is_undercover == 1 && tf_data.invis_only == 1 )
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 868
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $1270
ADDRGP4 tf_data+60
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $1270
line 2192
;2192:		{
line 2193
;2193:			self->s.v.frame = 0;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 0
ASGNF4
line 2194
;2194:			self->s.v.modelindex = modelindex_eyes;
ADDRGP4 self
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 modelindex_eyes
INDIRI4
CVIF4 4
ASGNF4
line 2195
;2195:		} else
ADDRGP4 $1271
JUMPV
LABELV $1270
line 2196
;2196:		{
line 2197
;2197:			if ( self->invisible_finished )
ADDRGP4 self
INDIRP4
CNSTI4 736
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1273
line 2198
;2198:			{
line 2199
;2199:				if ( self->tfstate & 64 )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1275
line 2200
;2200:				{
line 2201
;2201:					if ( self->invisible_finished < g_globalvars.time + 10 )
ADDRGP4 self
INDIRP4
CNSTI4 736
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1092616192
ADDF4
GEF4 $1277
line 2202
;2202:						self->invisible_finished = g_globalvars.time + 666;
ADDRGP4 self
INDIRP4
CNSTI4 736
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1143373824
ADDF4
ASGNF4
LABELV $1277
line 2203
;2203:				}
LABELV $1275
line 2204
;2204:				if ( self->invisible_sound < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 760
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $1281
line 2205
;2205:				{
line 2206
;2206:					sound( self, 0, "items/inv3.wav", 0.5, 2 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $1284
ARGP4
CNSTF4 1056964608
ARGF4
CNSTF4 1073741824
ARGF4
ADDRGP4 sound
CALLV
pop
line 2207
;2207:					self->invisible_sound = g_globalvars.time + g_random() * 3 + 1;
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 760
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1077936128
ADDRLP4 12
INDIRF4
MULF4
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2208
;2208:				}
LABELV $1281
line 2209
;2209:				if ( self->invisible_finished < g_globalvars.time + 3 )
ADDRGP4 self
INDIRP4
CNSTI4 736
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1077936128
ADDF4
GEF4 $1286
line 2210
;2210:				{
line 2211
;2211:					if ( self->invisible_time == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 756
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $1289
line 2212
;2212:					{
line 2213
;2213:						G_sprint( self, 2, "Ring of Shadows magic is fading\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1291
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2214
;2214:						stuffcmd( self, "bf\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1292
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 2215
;2215:						sound( self, 0, "items/inv2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $1293
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
line 2216
;2216:						self->invisible_time = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 756
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2217
;2217:					}
LABELV $1289
line 2218
;2218:					if ( self->invisible_time < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 756
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $1295
line 2219
;2219:					{
line 2220
;2220:						self->invisible_time = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 756
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2221
;2221:						stuffcmd( self, "bf\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1292
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 2222
;2222:					}
LABELV $1295
line 2223
;2223:				}
LABELV $1286
line 2224
;2224:				if ( self->invisible_finished < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 736
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $1299
line 2225
;2225:				{
line 2226
;2226:					self->s.v.items = self->s.v.items - 524288;
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CNSTF4 1224736768
SUBF4
ASGNF4
line 2227
;2227:					self->invisible_finished = 0;
ADDRGP4 self
INDIRP4
CNSTI4 736
ADDP4
CNSTF4 0
ASGNF4
line 2228
;2228:					self->invisible_time = 0;
ADDRGP4 self
INDIRP4
CNSTI4 756
ADDP4
CNSTF4 0
ASGNF4
line 2229
;2229:				}
LABELV $1299
line 2230
;2230:				self->s.v.frame = 0;
ADDRGP4 self
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 0
ASGNF4
line 2231
;2231:				self->s.v.modelindex = modelindex_eyes;
ADDRGP4 self
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 modelindex_eyes
INDIRI4
CVIF4 4
ASGNF4
line 2232
;2232:			} else
ADDRGP4 $1274
JUMPV
LABELV $1273
line 2233
;2233:				self->s.v.modelindex = modelindex_player;
ADDRGP4 self
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 modelindex_player
INDIRI4
CVIF4 4
ASGNF4
LABELV $1274
line 2234
;2234:		}
LABELV $1271
line 2235
;2235:	}
LABELV $1269
line 2236
;2236:	if ( self->invincible_finished )
ADDRGP4 self
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1302
line 2237
;2237:	{
line 2238
;2238:		if ( self->tfstate & TFSTATE_INVINCIBLE )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1304
line 2239
;2239:		{
line 2240
;2240:			if ( self->invincible_finished < g_globalvars.time + 10 )
ADDRGP4 self
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1092616192
ADDF4
GEF4 $1306
line 2241
;2241:				self->invincible_finished = g_globalvars.time + 666;
ADDRGP4 self
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1143373824
ADDF4
ASGNF4
LABELV $1306
line 2242
;2242:		}
LABELV $1304
line 2243
;2243:		if ( self->invincible_finished < g_globalvars.time + 3 )
ADDRGP4 self
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1077936128
ADDF4
GEF4 $1310
line 2244
;2244:		{
line 2245
;2245:			if ( self->invincible_time == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 748
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $1313
line 2246
;2246:			{
line 2247
;2247:				G_sprint( self, 2, "Protection is almost burned out\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1315
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2248
;2248:				stuffcmd( self, "bf\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1292
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 2249
;2249:				sound( self, 0, "items/protect2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $1316
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
line 2250
;2250:				self->invincible_time = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 748
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2251
;2251:			}
LABELV $1313
line 2252
;2252:			if ( self->invincible_time < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 748
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $1318
line 2253
;2253:			{
line 2254
;2254:				self->invincible_time = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 748
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2255
;2255:				stuffcmd( self, "bf\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1292
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 2256
;2256:			}
LABELV $1318
line 2257
;2257:		}
LABELV $1310
line 2258
;2258:		if ( self->invincible_finished < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $1322
line 2259
;2259:		{
line 2260
;2260:			self->s.v.items = ( int ) self->s.v.items - IT_INVULNERABILITY;
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 1048576
SUBI4
CVIF4 4
ASGNF4
line 2261
;2261:			self->invincible_time = 0;
ADDRGP4 self
INDIRP4
CNSTI4 748
ADDP4
CNSTF4 0
ASGNF4
line 2262
;2262:			self->invincible_finished = 0;
ADDRGP4 self
INDIRP4
CNSTI4 732
ADDP4
CNSTF4 0
ASGNF4
line 2263
;2263:		}
LABELV $1322
line 2264
;2264:		if ( self->invincible_finished > g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 732
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $1325
line 2265
;2265:		{
line 2266
;2266:			self->s.v.effects = ( int ) self->s.v.effects | 8;
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 8
BORI4
CVIF4 4
ASGNF4
line 2267
;2267:			self->s.v.effects = ( int ) self->s.v.effects | 128;
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 128
BORI4
CVIF4 4
ASGNF4
line 2268
;2268:		} else
ADDRGP4 $1326
JUMPV
LABELV $1325
line 2269
;2269:		{
line 2270
;2270:			lighton = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 2271
;2271:			te = trap_find( world, FOFS( s.v.classname ), "item_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $1328
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $1330
JUMPV
LABELV $1329
line 2273
;2272:			while ( te )
;2273:			{
line 2274
;2274:				if ( te->s.v.owner == EDICT_TO_PROG( self ) )
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
NEI4 $1332
line 2275
;2275:				{
line 2276
;2276:					if ( te->goal_activation & TFGI_GLOW )
ADDRLP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1334
line 2277
;2277:						lighton = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
LABELV $1334
line 2278
;2278:				}
LABELV $1332
line 2279
;2279:				te = trap_find( te, FOFS( s.v.classname ), "item_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $1328
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 2280
;2280:			}
LABELV $1330
line 2272
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1329
line 2281
;2281:			if ( !lighton )
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $1336
line 2282
;2282:			{
line 2283
;2283:				self->s.v.effects = ( int ) self->s.v.effects - ( ( int ) self->s.v.effects & 8 );
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 232
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
CNSTI4 8
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 2284
;2284:				self->s.v.effects = ( int ) self->s.v.effects - ( ( int ) self->s.v.effects & 128 );
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 232
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
CNSTI4 128
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 2285
;2285:			}
LABELV $1336
line 2286
;2286:		}
LABELV $1326
line 2287
;2287:	}
LABELV $1302
line 2288
;2288:	if ( self->super_damage_finished )
ADDRGP4 self
INDIRP4
CNSTI4 740
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1338
line 2289
;2289:	{
line 2290
;2290:		if ( self->tfstate & TFSTATE_QUAD )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $1340
line 2291
;2291:		{
line 2292
;2292:			if ( self->super_damage_finished == g_globalvars.time + 10 )
ADDRGP4 self
INDIRP4
CNSTI4 740
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1092616192
ADDF4
NEF4 $1342
line 2293
;2293:				self->super_damage_finished = g_globalvars.time + 666;
ADDRGP4 self
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1143373824
ADDF4
ASGNF4
LABELV $1342
line 2294
;2294:		}
LABELV $1340
line 2295
;2295:		if ( self->super_damage_finished < g_globalvars.time + 3 )
ADDRGP4 self
INDIRP4
CNSTI4 740
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1077936128
ADDF4
GEF4 $1346
line 2296
;2296:		{
line 2297
;2297:			if ( self->super_time == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 764
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $1349
line 2298
;2298:			{
line 2299
;2299:				G_sprint( self, 2, "Quad Damage is wearing off\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1351
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2300
;2300:				stuffcmd( self, "bf\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1292
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 2301
;2301:				sound( self, 0, "items/damage2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $1352
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
line 2302
;2302:				self->super_time = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 764
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2303
;2303:			}
LABELV $1349
line 2304
;2304:			if ( self->super_time < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 764
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $1354
line 2305
;2305:			{
line 2306
;2306:				self->super_time = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 764
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2307
;2307:				stuffcmd( self, "bf\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1292
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 2308
;2308:			}
LABELV $1354
line 2309
;2309:		}
LABELV $1346
line 2310
;2310:		if ( self->super_damage_finished < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 740
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $1358
line 2311
;2311:		{
line 2312
;2312:			self->s.v.items = ( int ) self->s.v.items - IT_QUAD;
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 4194304
SUBI4
CVIF4 4
ASGNF4
line 2313
;2313:			self->super_damage_finished = 0;
ADDRGP4 self
INDIRP4
CNSTI4 740
ADDP4
CNSTF4 0
ASGNF4
line 2314
;2314:			self->super_time = 0;
ADDRGP4 self
INDIRP4
CNSTI4 764
ADDP4
CNSTF4 0
ASGNF4
line 2315
;2315:		}
LABELV $1358
line 2316
;2316:		if ( self->super_damage_finished > g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 740
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $1361
line 2317
;2317:		{
line 2318
;2318:			self->s.v.effects = ( int ) self->s.v.effects | 8;
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 8
BORI4
CVIF4 4
ASGNF4
line 2319
;2319:			self->s.v.effects = ( int ) self->s.v.effects | 64;
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 64
BORI4
CVIF4 4
ASGNF4
line 2320
;2320:		} else
ADDRGP4 $1362
JUMPV
LABELV $1361
line 2321
;2321:		{
line 2322
;2322:			lighton = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 2323
;2323:			te = trap_find( world, FOFS( s.v.classname ), "item_tfgoal" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $1328
ARGP4
ADDRLP4 8
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $1365
JUMPV
LABELV $1364
line 2325
;2324:			while ( te )
;2325:			{
line 2326
;2326:				if ( te->s.v.owner == EDICT_TO_PROG( self ) )
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
NEI4 $1367
line 2327
;2327:				{
line 2328
;2328:					if ( te->goal_activation & TFGI_GLOW )
ADDRLP4 0
INDIRP4
CNSTI4 1128
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1369
line 2329
;2329:						lighton = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
LABELV $1369
line 2330
;2330:				}
LABELV $1367
line 2331
;2331:				te = trap_find( te, FOFS( s.v.classname ), "item_tfgoal" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $1328
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 2332
;2332:			}
LABELV $1365
line 2324
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1364
line 2333
;2333:			if ( !lighton )
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $1371
line 2334
;2334:			{
line 2335
;2335:				self->s.v.effects = ( int ) self->s.v.effects - ( ( int ) self->s.v.effects & 8 );
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 232
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
CNSTI4 8
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 2336
;2336:				self->s.v.effects = ( int ) self->s.v.effects - ( ( int ) self->s.v.effects & 64 );
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 232
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
CNSTI4 64
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 2337
;2337:			}
LABELV $1371
line 2338
;2338:		}
LABELV $1362
line 2339
;2339:	}
LABELV $1338
line 2340
;2340:	if ( self->radsuit_finished )
ADDRGP4 self
INDIRP4
CNSTI4 744
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1373
line 2341
;2341:	{
line 2342
;2342:		self->air_finished = g_globalvars.time + 12;
ADDRGP4 self
INDIRP4
CNSTI4 796
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1094713344
ADDF4
ASGNF4
line 2343
;2343:		if ( self->tfstate & 256 )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1376
line 2344
;2344:		{
line 2345
;2345:			if ( self->radsuit_finished == g_globalvars.time + 10 )
ADDRGP4 self
INDIRP4
CNSTI4 744
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1092616192
ADDF4
NEF4 $1378
line 2346
;2346:				self->radsuit_finished = g_globalvars.time + 666;
ADDRGP4 self
INDIRP4
CNSTI4 744
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1143373824
ADDF4
ASGNF4
LABELV $1378
line 2347
;2347:		}
LABELV $1376
line 2348
;2348:		if ( self->radsuit_finished < g_globalvars.time + 3 )
ADDRGP4 self
INDIRP4
CNSTI4 744
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1077936128
ADDF4
GEF4 $1382
line 2349
;2349:		{
line 2350
;2350:			if ( self->rad_time == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 772
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $1385
line 2351
;2351:			{
line 2352
;2352:				G_sprint( self, 2, "Air supply in Biosuit expiring\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1387
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2353
;2353:				stuffcmd( self, "bf\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1292
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 2354
;2354:				sound( self, 0, "items/suit2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $1388
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
line 2355
;2355:				self->rad_time = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 772
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2356
;2356:			}
LABELV $1385
line 2357
;2357:			if ( self->rad_time < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 772
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $1390
line 2358
;2358:			{
line 2359
;2359:				self->rad_time = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 772
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2360
;2360:				stuffcmd( self, "bf\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1292
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 2361
;2361:			}
LABELV $1390
line 2362
;2362:		}
LABELV $1382
line 2363
;2363:		if ( self->radsuit_finished < g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 744
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $1394
line 2364
;2364:		{
line 2365
;2365:			self->s.v.items = ( int ) self->s.v.items - IT_SUIT;
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CVFI4 4
CNSTI4 2097152
SUBI4
CVIF4 4
ASGNF4
line 2366
;2366:			self->rad_time = 0;
ADDRGP4 self
INDIRP4
CNSTI4 772
ADDP4
CNSTF4 0
ASGNF4
line 2367
;2367:			self->radsuit_finished = 0;
ADDRGP4 self
INDIRP4
CNSTI4 744
ADDP4
CNSTF4 0
ASGNF4
line 2368
;2368:		}
LABELV $1394
line 2369
;2369:	}
LABELV $1373
line 2370
;2370:}
LABELV $1265
endproc CheckPowerups 28 20
export PlayerPostThink
proc PlayerPostThink 40 24
line 2378
;2371:
;2372:////////////////
;2373:// GlobalParams:
;2374:// time
;2375:// self
;2376:///////////////
;2377:void PlayerPostThink()
;2378:{
line 2386
;2379://      float   mspeed;
;2380://      float   aspeed;
;2381://      float   r;
;2382:	float   fdmg;
;2383:	float   dtime;
;2384:
;2385:
;2386:	dtime = g_globalvars.time - self->lasttime;
ADDRLP4 0
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 1624
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2388
;2387:
;2388: 	VectorSubtract(self->s.v.velocity,self->lastvel,self->accel);
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 1612
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 1600
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 1616
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 1604
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 1620
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 1608
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2389
;2389:	VectorScale(self->accel, 1/dtime , self->accel);
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 1612
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 1065353216
ADDRLP4 0
INDIRF4
DIVF4
ARGF4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 2390
;2390:	VectorCopy(self->s.v.velocity, self->lastvel);
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 1600
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ASGNF4
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 1604
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 1608
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ASGNF4
line 2391
;2391:	self->lasttime = g_globalvars.time;
ADDRGP4 self
INDIRP4
CNSTI4 1624
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
ASGNF4
line 2394
;2392:	
;2393:
;2394:	if ( self->s.v.view_ofs[0] == 0 && self->s.v.view_ofs[1] == 0 && self->s.v.view_ofs[2] == 0 )
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 352
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
NEF4 $1400
ADDRLP4 12
INDIRP4
CNSTI4 356
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
NEF4 $1400
ADDRLP4 12
INDIRP4
CNSTI4 360
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
NEF4 $1400
line 2395
;2395:		return;		// intermission or finale
ADDRGP4 $1397
JUMPV
LABELV $1400
line 2396
;2396:	if ( self->s.v.deadflag )
ADDRGP4 self
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1402
line 2397
;2397:	{
line 2398
;2398:		DeadImpulses();
ADDRGP4 DeadImpulses
CALLV
pop
line 2399
;2399:		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 2400
;2400:		return;
ADDRGP4 $1397
JUMPV
LABELV $1402
line 2402
;2401:	}
;2402:	if ( self->jump_flag < -300 && ( ( int ) self->s.v.flags & FL_ONGROUND ) && self->s.v.health > 0 )
ADDRLP4 20
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 788
ADDP4
INDIRF4
CNSTF4 3281387520
GEF4 $1404
ADDRLP4 20
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1404
ADDRLP4 20
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
LEF4 $1404
line 2403
;2403:	{
line 2404
;2404:		if ( self->s.v.watertype == CONTENT_WATER )
ADDRGP4 self
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
CNSTF4 3225419776
NEF4 $1406
line 2405
;2405:			sound( self, 4, "player/h2ojump.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1408
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
ADDRGP4 $1407
JUMPV
LABELV $1406
line 2407
;2406:		else
;2407:		{
line 2408
;2408:			if ( self->jump_flag < -650 )
ADDRGP4 self
INDIRP4
CNSTI4 788
ADDP4
INDIRF4
CNSTF4 3290595328
GEF4 $1409
line 2409
;2409:			{
line 2410
;2410:				fdmg = 5;
ADDRLP4 4
CNSTF4 1084227584
ASGNF4
line 2411
;2411:				fdmg = fdmg * self->jump_flag / 300 * -1;
ADDRLP4 4
CNSTF4 3212836864
ADDRLP4 4
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 788
ADDP4
INDIRF4
MULF4
CNSTF4 1133903872
DIVF4
MULF4
ASGNF4
line 2412
;2412:				if ( self->playerclass == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1411
line 2413
;2413:					fdmg = fdmg / 2;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
ADDRGP4 $1412
JUMPV
LABELV $1411
line 2415
;2414:				else
;2415:				{
line 2416
;2416:					if ( self->playerclass == 6 )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 6
NEI4 $1413
line 2417
;2417:						fdmg = fdmg * 1.5;
ADDRLP4 4
CNSTF4 1069547520
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
LABELV $1413
line 2418
;2418:				}
LABELV $1412
line 2419
;2419:				fdmg = rint( fdmg );
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 rint
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 28
INDIRI4
CVIF4 4
ASGNF4
line 2420
;2420:				self->deathtype = "falling";
ADDRGP4 self
INDIRP4
CNSTI4 804
ADDP4
ADDRGP4 $1415
ASGNP4
line 2421
;2421:				TF_T_Damage( self, world, world, fdmg, 1, 0 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 world
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 2422
;2422:				sound( self, 2, "player/land2.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1416
ARGP4
ADDRLP4 36
CNSTF4 1065353216
ASGNF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 2423
;2423:			} else {
ADDRGP4 $1410
JUMPV
LABELV $1409
line 2424
;2424:				if ( self->playerclass == PC_SPY )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1417
line 2425
;2425:					sound( self, 2, "hknight/hit.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1419
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
ADDRGP4 $1418
JUMPV
LABELV $1417
line 2427
;2426:				else
;2427:					sound( self, 2, "player/land.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1420
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
LABELV $1418
line 2428
;2428:			}
LABELV $1410
line 2429
;2429:		}
LABELV $1407
line 2430
;2430:	}
LABELV $1404
line 2431
;2431:	self->jump_flag = self->s.v.velocity[2];
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 788
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ASGNF4
line 2432
;2432:	CheckPowerups();
ADDRGP4 CheckPowerups
CALLV
pop
line 2433
;2433:	W_WeaponFrame();
ADDRGP4 W_WeaponFrame
CALLV
pop
line 2434
;2434:	if ( self->motd <= 95 )
ADDRGP4 self
INDIRP4
CNSTI4 944
ADDP4
INDIRI4
CNSTI4 95
GTI4 $1421
line 2435
;2435:		TeamFortress_MOTD();
ADDRGP4 TeamFortress_MOTD
CALLV
pop
ADDRGP4 $1422
JUMPV
LABELV $1421
line 2437
;2436:	else
;2437:	{
line 2438
;2438:		if ( !self->cheat_check )
ADDRGP4 self
INDIRP4
CNSTI4 860
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1423
line 2439
;2439:			self->cheat_check = g_globalvars.time + 5;
ADDRGP4 self
INDIRP4
CNSTI4 860
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
ADDRGP4 $1424
JUMPV
LABELV $1423
line 2441
;2440:		else
;2441:		{
line 2442
;2442:			if ( g_globalvars.time > self->StatusRefreshTime )
ADDRGP4 g_globalvars+124
INDIRF4
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
INDIRF4
LEF4 $1426
line 2443
;2443:			{
line 2444
;2444:				if ( self->StatusBarSize )
ADDRGP4 self
INDIRP4
CNSTI4 1488
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1429
line 2445
;2445:					RefreshStatusBar( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 RefreshStatusBar
CALLV
pop
LABELV $1429
line 2446
;2446:			}
LABELV $1426
line 2447
;2447:		}
LABELV $1424
line 2448
;2448:	}
LABELV $1422
line 2449
;2449:	if ( self->cheat_check <= g_globalvars.time )
ADDRGP4 self
INDIRP4
CNSTI4 860
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 g_globalvars+124
INDIRF4
GTF4 $1431
line 2450
;2450:	{
line 2451
;2451:		TeamFortress_CheckTeamCheats();
ADDRGP4 TeamFortress_CheckTeamCheats
CALLV
pop
line 2452
;2452:		self->cheat_check = g_globalvars.time + 3;
ADDRGP4 self
INDIRP4
CNSTI4 860
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1077936128
ADDF4
CVFI4 4
ASGNI4
line 2453
;2453:	}
LABELV $1431
line 2455
;2454:
;2455:}
LABELV $1397
endproc PlayerPostThink 40 24
export SetClientSetting
proc SetClientSetting 236 12
line 2458
;2456://=======================
;2457:qboolean SetClientSetting( gedict_t * p, const char *key, const char *value )
;2458:{
line 2461
;2459:	unsigned int crc;
;2460:
;2461:	crc = crc32( 0L, ( unsigned char * ) key, strlen( key ) );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
CNSTU4 0
ARGU4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 crc32
CALLU4
ASGNU4
ADDRLP4 0
ADDRLP4 8
INDIRU4
ASGNU4
line 2462
;2462:	switch ( crc )
ADDRLP4 12
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 16
CNSTI4 48627041
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $1487
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
GTI4 $1503
LABELV $1502
ADDRLP4 20
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 24
CNSTI4 -891916218
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $1496
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
GTI4 $1505
LABELV $1504
ADDRLP4 28
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 32
CNSTI4 -1914126849
ASGNI4
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $1490
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRI4
GTI4 $1507
LABELV $1506
ADDRLP4 36
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 40
CNSTI4 -2082672713
ASGNI4
ADDRLP4 36
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $1471
ADDRLP4 36
INDIRI4
ADDRLP4 40
INDIRI4
LTI4 $1436
LABELV $1508
ADDRLP4 0
INDIRU4
CVUI4 4
CNSTI4 -1944894851
EQI4 $1480
ADDRGP4 $1436
JUMPV
LABELV $1507
ADDRLP4 44
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 48
CNSTI4 -1851502055
ASGNI4
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRI4
EQI4 $1471
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $1436
LABELV $1509
ADDRLP4 0
INDIRU4
CVUI4 4
CNSTI4 -1174076273
EQI4 $1462
ADDRGP4 $1436
JUMPV
LABELV $1505
ADDRLP4 52
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 56
CNSTI4 -425500017
ASGNI4
ADDRLP4 52
INDIRI4
ADDRLP4 56
INDIRI4
EQI4 $1477
ADDRLP4 52
INDIRI4
ADDRLP4 56
INDIRI4
GTI4 $1511
LABELV $1510
ADDRLP4 60
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 64
CNSTI4 -442345505
ASGNI4
ADDRLP4 60
INDIRI4
ADDRLP4 64
INDIRI4
EQI4 $1499
ADDRLP4 60
INDIRI4
ADDRLP4 64
INDIRI4
LTI4 $1436
LABELV $1512
ADDRLP4 0
INDIRU4
CVUI4 4
CNSTI4 -428394306
EQI4 $1438
ADDRGP4 $1436
JUMPV
LABELV $1511
ADDRLP4 68
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 72
CNSTI4 -224248128
ASGNI4
ADDRLP4 68
INDIRI4
ADDRLP4 72
INDIRI4
EQI4 $1474
ADDRLP4 68
INDIRI4
ADDRLP4 72
INDIRI4
LTI4 $1436
LABELV $1513
ADDRLP4 0
INDIRU4
CVUI4 4
CNSTI4 -206169288
EQI4 $1480
ADDRGP4 $1436
JUMPV
LABELV $1503
ADDRLP4 76
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 80
CNSTI4 1077286446
ASGNI4
ADDRLP4 76
INDIRI4
ADDRLP4 80
INDIRI4
EQI4 $1441
ADDRLP4 76
INDIRI4
ADDRLP4 80
INDIRI4
GTI4 $1515
LABELV $1514
ADDRLP4 84
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 88
CNSTI4 453955339
ASGNI4
ADDRLP4 84
INDIRI4
ADDRLP4 88
INDIRI4
EQI4 $1483
ADDRLP4 84
INDIRI4
ADDRLP4 88
INDIRI4
GTI4 $1517
LABELV $1516
ADDRLP4 92
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 96
CNSTI4 250832680
ASGNI4
ADDRLP4 92
INDIRI4
ADDRLP4 96
INDIRI4
EQI4 $1441
ADDRLP4 92
INDIRI4
ADDRLP4 96
INDIRI4
LTI4 $1436
LABELV $1518
ADDRLP4 0
INDIRU4
CVUI4 4
CNSTI4 450215437
EQI4 $1474
ADDRGP4 $1436
JUMPV
LABELV $1517
ADDRLP4 100
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 104
CNSTI4 862272938
ASGNI4
ADDRLP4 100
INDIRI4
ADDRLP4 104
INDIRI4
EQI4 $1484
ADDRLP4 100
INDIRI4
ADDRLP4 104
INDIRI4
LTI4 $1436
LABELV $1519
ADDRLP4 0
INDIRU4
CVUI4 4
CNSTI4 925968056
EQI4 $1462
ADDRGP4 $1436
JUMPV
LABELV $1515
ADDRLP4 108
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 112
CNSTI4 1535578323
ASGNI4
ADDRLP4 108
INDIRI4
ADDRLP4 112
INDIRI4
EQI4 $1493
ADDRLP4 108
INDIRI4
ADDRLP4 112
INDIRI4
GTI4 $1521
LABELV $1520
ADDRLP4 116
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 120
CNSTI4 1281410033
ASGNI4
ADDRLP4 116
INDIRI4
ADDRLP4 120
INDIRI4
EQI4 $1484
ADDRLP4 116
INDIRI4
ADDRLP4 120
INDIRI4
LTI4 $1436
LABELV $1522
ADDRLP4 0
INDIRU4
CVUI4 4
CNSTI4 1485186963
EQI4 $1487
ADDRGP4 $1436
JUMPV
LABELV $1521
ADDRLP4 124
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 128
CNSTI4 1809541768
ASGNI4
ADDRLP4 124
INDIRI4
ADDRLP4 128
INDIRI4
EQI4 $1490
ADDRLP4 124
INDIRI4
ADDRLP4 128
INDIRI4
GTI4 $1524
LABELV $1523
ADDRLP4 0
INDIRU4
CVUI4 4
CNSTI4 1783664888
EQI4 $1493
ADDRGP4 $1436
JUMPV
LABELV $1524
ADDRLP4 0
INDIRU4
CVUI4 4
CNSTI4 1842515611
EQI4 $1477
ADDRGP4 $1436
JUMPV
line 2463
;2463:	{
LABELV $1438
line 2465
;2464:	case 0xE67738BE:	//sb
;2465:		p->assault_min_shells = atoi( value );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 132
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1504
ADDP4
ADDRLP4 132
INDIRI4
ASGNI4
line 2466
;2466:		if ( p->assault_min_shells < 0 )
ADDRFP4 0
INDIRP4
CNSTI4 1504
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1437
line 2467
;2467:			p->assault_min_shells = DEFAULT_ASSAULT_MIN_SHELLS;
ADDRFP4 0
INDIRP4
CNSTI4 1504
ADDP4
CNSTI4 20
ASGNI4
line 2468
;2468:		break;
ADDRGP4 $1437
JUMPV
LABELV $1441
line 2471
;2469:	case 0x4036162E:	//sbr
;2470:	case 0x0EF36728:	//sbar_res
;2471:		{
line 2472
;2472:			int     sbres = atoi( value );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 136
ADDRLP4 140
INDIRI4
ASGNI4
line 2474
;2473:			
;2474:			switch ( sbres )
ADDRLP4 144
ADDRLP4 136
INDIRI4
ASGNI4
ADDRLP4 148
CNSTI4 384
ASGNI4
ADDRLP4 144
INDIRI4
ADDRLP4 148
INDIRI4
EQI4 $1448
ADDRLP4 144
INDIRI4
ADDRLP4 148
INDIRI4
GTI4 $1454
LABELV $1453
ADDRLP4 152
ADDRLP4 136
INDIRI4
ASGNI4
ADDRLP4 156
CNSTI4 240
ASGNI4
ADDRLP4 152
INDIRI4
ADDRLP4 156
INDIRI4
EQI4 $1451
ADDRLP4 152
INDIRI4
ADDRLP4 156
INDIRI4
GTI4 $1456
LABELV $1455
ADDRLP4 136
INDIRI4
CNSTI4 200
EQI4 $1452
ADDRGP4 $1442
JUMPV
LABELV $1456
ADDRLP4 160
ADDRLP4 136
INDIRI4
ASGNI4
ADDRLP4 164
CNSTI4 300
ASGNI4
ADDRLP4 160
INDIRI4
ADDRLP4 164
INDIRI4
EQI4 $1450
ADDRLP4 160
INDIRI4
ADDRLP4 164
INDIRI4
LTI4 $1442
LABELV $1457
ADDRLP4 136
INDIRI4
CNSTI4 350
EQI4 $1449
ADDRGP4 $1442
JUMPV
LABELV $1454
ADDRLP4 168
ADDRLP4 136
INDIRI4
ASGNI4
ADDRLP4 172
CNSTI4 480
ASGNI4
ADDRLP4 168
INDIRI4
ADDRLP4 172
INDIRI4
EQI4 $1446
ADDRLP4 168
INDIRI4
ADDRLP4 172
INDIRI4
GTI4 $1459
LABELV $1458
ADDRLP4 136
INDIRI4
CNSTI4 400
EQI4 $1447
ADDRGP4 $1442
JUMPV
LABELV $1459
ADDRLP4 176
ADDRLP4 136
INDIRI4
ASGNI4
ADDRLP4 180
CNSTI4 600
ASGNI4
ADDRLP4 176
INDIRI4
ADDRLP4 180
INDIRI4
EQI4 $1445
ADDRLP4 176
INDIRI4
ADDRLP4 180
INDIRI4
LTI4 $1442
LABELV $1460
ADDRLP4 136
INDIRI4
CNSTI4 768
EQI4 $1444
ADDRGP4 $1442
JUMPV
line 2475
;2475:			{
LABELV $1444
line 2477
;2476:			case 768:
;2477:				p->StatusBarRes = 8;
ADDRFP4 0
INDIRP4
CNSTI4 1492
ADDP4
CNSTI4 8
ASGNI4
line 2478
;2478:				break;
ADDRGP4 $1443
JUMPV
LABELV $1445
line 2480
;2479:			case 600:
;2480:				p->StatusBarRes = 7;
ADDRFP4 0
INDIRP4
CNSTI4 1492
ADDP4
CNSTI4 7
ASGNI4
line 2481
;2481:				break;
ADDRGP4 $1443
JUMPV
LABELV $1446
line 2483
;2482:			case 480:
;2483:				p->StatusBarRes = 6;
ADDRFP4 0
INDIRP4
CNSTI4 1492
ADDP4
CNSTI4 6
ASGNI4
line 2484
;2484:				break;
ADDRGP4 $1443
JUMPV
LABELV $1447
line 2486
;2485:			case 400:
;2486:				p->StatusBarRes = 5;
ADDRFP4 0
INDIRP4
CNSTI4 1492
ADDP4
CNSTI4 5
ASGNI4
line 2487
;2487:				break;
ADDRGP4 $1443
JUMPV
LABELV $1448
line 2489
;2488:			case 384:
;2489:				p->StatusBarRes = 4;
ADDRFP4 0
INDIRP4
CNSTI4 1492
ADDP4
CNSTI4 4
ASGNI4
line 2490
;2490:				break;
ADDRGP4 $1443
JUMPV
LABELV $1449
line 2492
;2491:			case 350:
;2492:				p->StatusBarRes = 3;
ADDRFP4 0
INDIRP4
CNSTI4 1492
ADDP4
CNSTI4 3
ASGNI4
line 2493
;2493:				break;
ADDRGP4 $1443
JUMPV
LABELV $1450
line 2495
;2494:			case 300:
;2495:				p->StatusBarRes = 2;
ADDRFP4 0
INDIRP4
CNSTI4 1492
ADDP4
CNSTI4 2
ASGNI4
line 2496
;2496:				break;
ADDRGP4 $1443
JUMPV
LABELV $1451
line 2498
;2497:			case 240:
;2498:				p->StatusBarRes = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1492
ADDP4
CNSTI4 1
ASGNI4
line 2499
;2499:				break;
ADDRGP4 $1443
JUMPV
LABELV $1452
line 2501
;2500:			case 200:
;2501:				p->StatusBarRes = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1492
ADDP4
CNSTI4 0
ASGNI4
line 2502
;2502:				break;
ADDRGP4 $1443
JUMPV
LABELV $1442
line 2504
;2503:			default:
;2504:				p->StatusBarRes = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1492
ADDP4
CNSTI4 0
ASGNI4
line 2505
;2505:				break;
LABELV $1443
line 2507
;2506:			}
;2507:			p->StatusRefreshTime = g_globalvars.time + 0.2;
ADDRFP4 0
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 2508
;2508:		}
line 2509
;2509:		break;
ADDRGP4 $1437
JUMPV
LABELV $1462
line 2512
;2510:	case 0x373126B8:	//sbs
;2511:	case 0xBA05048F:	//sbar_size
;2512:		{
line 2513
;2513:		        p->StatusRefreshTime = g_globalvars.time + 0.2;
ADDRFP4 0
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 2514
;2514:			p->StatusBarSize = atoi( value );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1488
ADDP4
ADDRLP4 136
INDIRI4
ASGNI4
line 2515
;2515:			if ( p->StatusBarSize > 2 || p->StatusBarSize < 0 )
ADDRLP4 140
ADDRFP4 0
INDIRP4
CNSTI4 1488
ADDP4
INDIRI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 2
GTI4 $1466
ADDRLP4 140
INDIRI4
CNSTI4 0
GEI4 $1464
LABELV $1466
line 2516
;2516:				p->StatusBarSize = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1488
ADDP4
CNSTI4 0
ASGNI4
LABELV $1464
line 2517
;2517:			if( p->StatusBarSize )
ADDRFP4 0
INDIRP4
CNSTI4 1488
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1467
line 2518
;2518:			        p->StatusRefreshTime = g_globalvars.time + 0.2;
ADDRFP4 0
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
ADDRGP4 $1437
JUMPV
LABELV $1467
line 2520
;2519:			else
;2520:			        p->StatusRefreshTime = g_globalvars.time + 60;
ADDRFP4 0
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 2521
;2521:		}
line 2522
;2522:		break;
ADDRGP4 $1437
JUMPV
LABELV $1471
line 2525
;2523:	case 0x91A45219:	//mxs
;2524:	case 0x83DCEFB7:	//1
;2525:		if ( value[0] )
ADDRFP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1472
line 2526
;2526:			p->discard_shells = atoi( value );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1508
ADDP4
ADDRLP4 136
INDIRI4
ASGNI4
ADDRGP4 $1437
JUMPV
LABELV $1472
line 2528
;2527:		else
;2528:			p->discard_shells = -1;
ADDRFP4 0
INDIRP4
CNSTI4 1508
ADDP4
CNSTI4 -1
ASGNI4
line 2530
;2529:
;2530:		break;
ADDRGP4 $1437
JUMPV
LABELV $1474
line 2533
;2531:	case 0xF2A23EC0:	//mxn
;2532:	case 0x1AD5BE0D:	//2
;2533:		if ( value[0] )
ADDRFP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1475
line 2534
;2534:			p->discard_nails = atoi( value );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1512
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
ADDRGP4 $1437
JUMPV
LABELV $1475
line 2536
;2535:		else
;2536:			p->discard_nails = -1;
ADDRFP4 0
INDIRP4
CNSTI4 1512
ADDP4
CNSTI4 -1
ASGNI4
line 2537
;2537:		break;
ADDRGP4 $1437
JUMPV
LABELV $1477
line 2540
;2538:	case 0xE6A3628F:	//mxr
;2539:	case 0x6DD28E9B:	//3
;2540:		if ( value[0] )
ADDRFP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1478
line 2541
;2541:			p->discard_rockets = atoi( value );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1516
ADDP4
ADDRLP4 144
INDIRI4
ASGNI4
ADDRGP4 $1437
JUMPV
LABELV $1478
line 2543
;2542:		else
;2543:			p->discard_rockets = -1;
ADDRFP4 0
INDIRP4
CNSTI4 1516
ADDP4
CNSTI4 -1
ASGNI4
line 2544
;2544:		break;
ADDRGP4 $1437
JUMPV
LABELV $1480
line 2547
;2545:	case 0x8C13427D:	//mxc
;2546:	case 0xF3B61B38:	//4
;2547:		if ( value[0] )
ADDRFP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1481
line 2548
;2548:			p->discard_cells = atoi( value );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1520
ADDP4
ADDRLP4 148
INDIRI4
ASGNI4
ADDRGP4 $1437
JUMPV
LABELV $1481
line 2550
;2549:		else
;2550:			p->discard_cells = -1;
ADDRFP4 0
INDIRP4
CNSTI4 1520
ADDP4
CNSTI4 -1
ASGNI4
line 2551
;2551:		break;
ADDRGP4 $1437
JUMPV
LABELV $1483
line 2553
;2552:	case 0x1B0ECF0B:	//s
;2553:		p->settings_bits = atoi( value );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 152
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1524
ADDP4
ADDRLP4 152
INDIRI4
ASGNI4
line 2554
;2554:		break;
ADDRGP4 $1437
JUMPV
LABELV $1484
line 2557
;2555:	case 0x4C60C3F1:	//ch
;2556:	case 0x33653DAA:	//classhelp
;2557:		if ( strcmp( value, "off" ) )
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 $142
ARGP4
ADDRLP4 156
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $1485
line 2558
;2558:			p->settings_bits |= TF_CLASS_HELP_MASK;
ADDRLP4 160
ADDRFP4 0
INDIRP4
CNSTI4 1524
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
ADDRGP4 $1437
JUMPV
LABELV $1485
line 2560
;2559:		else
;2560:			p->settings_bits -= p->settings_bits & TF_CLASS_HELP_MASK;
ADDRLP4 164
ADDRFP4 0
INDIRP4
CNSTI4 1524
ADDP4
ASGNP4
ADDRLP4 168
ADDRLP4 164
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 164
INDIRP4
ADDRLP4 168
INDIRI4
ADDRLP4 168
INDIRI4
CNSTI4 4
BANDI4
SUBI4
ASGNI4
line 2561
;2561:		break;
ADDRGP4 $1437
JUMPV
LABELV $1487
line 2565
;2562:
;2563:	case 0x58862793:	//ms
;2564:	case 0x02E5FD61:	//multiscan
;2565:		if ( !strcmp( value, "off" ) )
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 $142
ARGP4
ADDRLP4 172
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
NEI4 $1488
line 2566
;2566:			p->settings_bits |= TF_MULTISCAN_MASK;
ADDRLP4 176
ADDRFP4 0
INDIRP4
CNSTI4 1524
ADDP4
ASGNP4
ADDRLP4 176
INDIRP4
ADDRLP4 176
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
ADDRGP4 $1437
JUMPV
LABELV $1488
line 2568
;2567:		else
;2568:			p->settings_bits -= p->settings_bits & TF_MULTISCAN_MASK;
ADDRLP4 180
ADDRFP4 0
INDIRP4
CNSTI4 1524
ADDP4
ASGNP4
ADDRLP4 184
ADDRLP4 180
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 180
INDIRP4
ADDRLP4 184
INDIRI4
ADDRLP4 184
INDIRI4
CNSTI4 16
BANDI4
SUBI4
ASGNI4
line 2569
;2569:		break;
ADDRGP4 $1437
JUMPV
LABELV $1490
line 2572
;2570:	case 0x8DE8BDFF:	//ec
;2571:	case 0x6BDB6A88:	//exec_class
;2572:		if ( !strcmp( value, "on" ) )
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 188
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
NEI4 $1491
line 2573
;2573:			p->settings_bits |= TF_EXEC_CLASS_MASK;
ADDRLP4 192
ADDRFP4 0
INDIRP4
CNSTI4 1524
ADDP4
ASGNP4
ADDRLP4 192
INDIRP4
ADDRLP4 192
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
ADDRGP4 $1437
JUMPV
LABELV $1491
line 2575
;2574:		else
;2575:			p->settings_bits -= p->settings_bits & TF_EXEC_CLASS_MASK;
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 1524
ADDP4
ASGNP4
ADDRLP4 200
ADDRLP4 196
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 196
INDIRP4
ADDRLP4 200
INDIRI4
ADDRLP4 200
INDIRI4
CNSTI4 2
BANDI4
SUBI4
ASGNI4
line 2576
;2576:		break;
ADDRGP4 $1437
JUMPV
LABELV $1493
line 2579
;2577:	case 0x6A5090F8:	//em
;2578:	case 0x5B8710D3:	//exec_map
;2579:		if ( !strcmp( value, "on" ) )
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 204
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
NEI4 $1494
line 2580
;2580:			p->settings_bits |= TF_EXEC_MAP_MASK;
ADDRLP4 208
ADDRFP4 0
INDIRP4
CNSTI4 1524
ADDP4
ASGNP4
ADDRLP4 208
INDIRP4
ADDRLP4 208
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
ADDRGP4 $1437
JUMPV
LABELV $1494
line 2582
;2581:		else
;2582:			p->settings_bits -= p->settings_bits & TF_EXEC_MAP_MASK;
ADDRLP4 212
ADDRFP4 0
INDIRP4
CNSTI4 1524
ADDP4
ASGNP4
ADDRLP4 216
ADDRLP4 212
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 212
INDIRP4
ADDRLP4 216
INDIRI4
ADDRLP4 216
INDIRI4
CNSTI4 1
BANDI4
SUBI4
ASGNI4
line 2583
;2583:		break;
ADDRGP4 $1437
JUMPV
LABELV $1496
line 2585
;2584:	case 0xCAD67046:	//take_sshot
;2585:		if ( !value[0] )
ADDRFP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1497
line 2586
;2586:			p->take_sshot = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1532
ADDP4
CNSTI4 1
ASGNI4
ADDRGP4 $1437
JUMPV
LABELV $1497
line 2588
;2587:		else
;2588:			p->take_sshot = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1532
ADDP4
CNSTI4 0
ASGNI4
line 2589
;2589:		break;
ADDRGP4 $1437
JUMPV
LABELV $1499
line 2591
;2590:	case 0xE5A257DF:	//grensound
;2591:	        if ( !strcmp( value, "on" ) )
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 220
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 220
INDIRI4
CNSTI4 0
NEI4 $1500
line 2592
;2592:	                p->internal_settings_bits |= TF_INTERNAL_GRENSOUND;
ADDRLP4 224
ADDRFP4 0
INDIRP4
CNSTI4 1528
ADDP4
ASGNP4
ADDRLP4 224
INDIRP4
ADDRLP4 224
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
ADDRGP4 $1437
JUMPV
LABELV $1500
line 2594
;2593:	        else
;2594:	                p->internal_settings_bits -= p->settings_bits & TF_INTERNAL_GRENSOUND;
ADDRLP4 228
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 232
ADDRLP4 228
INDIRP4
CNSTI4 1528
ADDP4
ASGNP4
ADDRLP4 232
INDIRP4
ADDRLP4 232
INDIRP4
INDIRI4
ADDRLP4 228
INDIRP4
CNSTI4 1524
ADDP4
INDIRI4
CNSTI4 1
BANDI4
SUBI4
ASGNI4
line 2595
;2595:		break;
ADDRGP4 $1437
JUMPV
LABELV $1436
line 2597
;2596:	default:
;2597:		return false;
CNSTI4 0
RETI4
ADDRGP4 $1435
JUMPV
LABELV $1437
line 2599
;2598:	}
;2599:	return true;
CNSTI4 1
RETI4
LABELV $1435
endproc SetClientSetting 236 12
lit
align 4
LABELV $1531
byte 4 200
byte 4 240
byte 4 300
byte 4 350
byte 4 384
byte 4 400
byte 4 480
byte 4 600
byte 4 768
export PrintClientSetting
code
proc PrintClientSetting 156 20
line 2603
;2600:}
;2601:
;2602:qboolean PrintClientSetting( gedict_t * p, const char *key )
;2603:{
line 2606
;2604:	unsigned int crc;
;2605:
;2606:	crc = crc32( 0L, ( unsigned char * ) key, strlen( key ) );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
CNSTU4 0
ARGU4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 crc32
CALLU4
ASGNU4
ADDRLP4 0
ADDRLP4 8
INDIRU4
ASGNU4
line 2607
;2607:	switch ( crc )
ADDRLP4 12
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 16
CNSTI4 48627041
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $1551
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
GTI4 $1577
LABELV $1576
ADDRLP4 20
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 24
CNSTI4 -891916218
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $1566
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
GTI4 $1579
LABELV $1578
ADDRLP4 28
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 32
CNSTI4 -1914126849
ASGNI4
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $1556
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRI4
GTI4 $1581
LABELV $1580
ADDRLP4 36
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 40
CNSTI4 -2082672713
ASGNI4
ADDRLP4 36
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $1536
ADDRLP4 36
INDIRI4
ADDRLP4 40
INDIRI4
LTI4 $1526
LABELV $1582
ADDRLP4 0
INDIRU4
CVUI4 4
CNSTI4 -1944894851
EQI4 $1542
ADDRGP4 $1526
JUMPV
LABELV $1581
ADDRLP4 44
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 48
CNSTI4 -1851502055
ASGNI4
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRI4
EQI4 $1536
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $1526
LABELV $1583
ADDRLP4 0
INDIRU4
CVUI4 4
CNSTI4 -1174076273
EQI4 $1535
ADDRGP4 $1526
JUMPV
LABELV $1579
ADDRLP4 52
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 56
CNSTI4 -425500017
ASGNI4
ADDRLP4 52
INDIRI4
ADDRLP4 56
INDIRI4
EQI4 $1540
ADDRLP4 52
INDIRI4
ADDRLP4 56
INDIRI4
GTI4 $1585
LABELV $1584
ADDRLP4 60
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 64
CNSTI4 -442345505
ASGNI4
ADDRLP4 60
INDIRI4
ADDRLP4 64
INDIRI4
EQI4 $1571
ADDRLP4 60
INDIRI4
ADDRLP4 64
INDIRI4
LTI4 $1526
LABELV $1586
ADDRLP4 0
INDIRU4
CVUI4 4
CNSTI4 -428394306
EQI4 $1528
ADDRGP4 $1526
JUMPV
LABELV $1585
ADDRLP4 68
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 72
CNSTI4 -224248128
ASGNI4
ADDRLP4 68
INDIRI4
ADDRLP4 72
INDIRI4
EQI4 $1538
ADDRLP4 68
INDIRI4
ADDRLP4 72
INDIRI4
LTI4 $1526
LABELV $1587
ADDRLP4 0
INDIRU4
CVUI4 4
CNSTI4 -206169288
EQI4 $1542
ADDRGP4 $1526
JUMPV
LABELV $1577
ADDRLP4 76
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 80
CNSTI4 1077286446
ASGNI4
ADDRLP4 76
INDIRI4
ADDRLP4 80
INDIRI4
EQI4 $1530
ADDRLP4 76
INDIRI4
ADDRLP4 80
INDIRI4
GTI4 $1589
LABELV $1588
ADDRLP4 84
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 88
CNSTI4 453955339
ASGNI4
ADDRLP4 84
INDIRI4
ADDRLP4 88
INDIRI4
EQI4 $1544
ADDRLP4 84
INDIRI4
ADDRLP4 88
INDIRI4
GTI4 $1591
LABELV $1590
ADDRLP4 92
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 96
CNSTI4 250832680
ASGNI4
ADDRLP4 92
INDIRI4
ADDRLP4 96
INDIRI4
EQI4 $1530
ADDRLP4 92
INDIRI4
ADDRLP4 96
INDIRI4
LTI4 $1526
LABELV $1592
ADDRLP4 0
INDIRU4
CVUI4 4
CNSTI4 450215437
EQI4 $1538
ADDRGP4 $1526
JUMPV
LABELV $1591
ADDRLP4 100
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 104
CNSTI4 862272938
ASGNI4
ADDRLP4 100
INDIRI4
ADDRLP4 104
INDIRI4
EQI4 $1546
ADDRLP4 100
INDIRI4
ADDRLP4 104
INDIRI4
LTI4 $1526
LABELV $1593
ADDRLP4 0
INDIRU4
CVUI4 4
CNSTI4 925968056
EQI4 $1535
ADDRGP4 $1526
JUMPV
LABELV $1589
ADDRLP4 108
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 112
CNSTI4 1535578323
ASGNI4
ADDRLP4 108
INDIRI4
ADDRLP4 112
INDIRI4
EQI4 $1561
ADDRLP4 108
INDIRI4
ADDRLP4 112
INDIRI4
GTI4 $1595
LABELV $1594
ADDRLP4 116
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 120
CNSTI4 1281410033
ASGNI4
ADDRLP4 116
INDIRI4
ADDRLP4 120
INDIRI4
EQI4 $1546
ADDRLP4 116
INDIRI4
ADDRLP4 120
INDIRI4
LTI4 $1526
LABELV $1596
ADDRLP4 0
INDIRU4
CVUI4 4
CNSTI4 1485186963
EQI4 $1551
ADDRGP4 $1526
JUMPV
LABELV $1595
ADDRLP4 124
ADDRLP4 0
INDIRU4
CVUI4 4
ASGNI4
ADDRLP4 128
CNSTI4 1809541768
ASGNI4
ADDRLP4 124
INDIRI4
ADDRLP4 128
INDIRI4
EQI4 $1556
ADDRLP4 124
INDIRI4
ADDRLP4 128
INDIRI4
GTI4 $1598
LABELV $1597
ADDRLP4 0
INDIRU4
CVUI4 4
CNSTI4 1783664888
EQI4 $1561
ADDRGP4 $1526
JUMPV
LABELV $1598
ADDRLP4 0
INDIRU4
CVUI4 4
CNSTI4 1842515611
EQI4 $1540
ADDRGP4 $1526
JUMPV
line 2608
;2608:	{
LABELV $1528
line 2610
;2609:	case 0xE67738BE:	//sb
;2610:		G_sprint( p, 2, "%s %3d\n", key, p->assault_min_shells );
ADDRLP4 132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 132
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1529
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
CNSTI4 1504
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 2611
;2611:		break;
ADDRGP4 $1527
JUMPV
LABELV $1530
line 2614
;2612:	case 0x4036162E:	//sbr
;2613:	case 0x0EF36728:	//sbar_res
;2614:		{
line 2616
;2615:			static const int sbres_tbl[] = { 200, 240, 300, 350, 384, 400, 480, 600, 768 };
;2616:			int     index = p->StatusBarRes;
ADDRLP4 136
ADDRFP4 0
INDIRP4
CNSTI4 1492
ADDP4
INDIRI4
ASGNI4
line 2618
;2617:
;2618:			if ( index > 8 || index < 0 )
ADDRLP4 140
ADDRLP4 136
INDIRI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 8
GTI4 $1534
ADDRLP4 140
INDIRI4
CNSTI4 0
GEI4 $1532
LABELV $1534
line 2619
;2619:				index = 0;
ADDRLP4 136
CNSTI4 0
ASGNI4
LABELV $1532
line 2620
;2620:			G_sprint( p, 2, "%s %3d\n", key, sbres_tbl[index] );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 144
CNSTI4 2
ASGNI4
ADDRLP4 144
INDIRI4
ARGI4
ADDRGP4 $1529
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 136
INDIRI4
ADDRLP4 144
INDIRI4
LSHI4
ADDRGP4 $1531
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 2621
;2621:		}
line 2622
;2622:		break;
ADDRGP4 $1527
JUMPV
LABELV $1535
line 2625
;2623:	case 0x373126B8:	//sbs
;2624:	case 0xBA05048F:	//sbar_size
;2625:		{
line 2626
;2626:			G_sprint( p, 2, "%s %3d\n", key, p->StatusBarSize );
ADDRLP4 136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 136
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1529
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 136
INDIRP4
CNSTI4 1488
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 2627
;2627:		}
line 2628
;2628:		break;
ADDRGP4 $1527
JUMPV
LABELV $1536
line 2631
;2629:	case 0x91A45219:	//mxs
;2630:	case 0x83DCEFB7:	//1
;2631:		G_sprint( p, 2, "Discard shells %3d\n", p->discard_shells );
ADDRLP4 136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 136
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1537
ARGP4
ADDRLP4 136
INDIRP4
CNSTI4 1508
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 2632
;2632:		break;
ADDRGP4 $1527
JUMPV
LABELV $1538
line 2635
;2633:	case 0xF2A23EC0:	//mxn
;2634:	case 0x1AD5BE0D:	//2
;2635:		G_sprint( p, 2, "Discard nails %3d\n", p->discard_nails );
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1539
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 1512
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 2636
;2636:		break;
ADDRGP4 $1527
JUMPV
LABELV $1540
line 2639
;2637:	case 0xE6A3628F:	//mxr
;2638:	case 0x6DD28E9B:	//3
;2639:		G_sprint( p, 2, "Discard rockets %3d\n", p->discard_rockets );
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1541
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 1516
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 2640
;2640:		break;
ADDRGP4 $1527
JUMPV
LABELV $1542
line 2643
;2641:	case 0x8C13427D:	//mxc
;2642:	case 0xF3B61B38:	//4
;2643:		G_sprint( p, 2, "Discard cells %3d\n", p->discard_cells );
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1543
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 1520
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 2644
;2644:		break;
ADDRGP4 $1527
JUMPV
LABELV $1544
line 2646
;2645:	case 0x1B0ECF0B:	//s
;2646:		G_sprint( p, 2, "TF setings bits %4d\n", p->settings_bits );
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 152
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1545
ARGP4
ADDRLP4 152
INDIRP4
CNSTI4 1524
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 2647
;2647:		break;
ADDRGP4 $1527
JUMPV
LABELV $1546
line 2650
;2648:	case 0x4C60C3F1:	//ch
;2649:	case 0x33653DAA:	//classhelp
;2650:		if ( p->settings_bits & TF_CLASS_HELP_MASK )
ADDRFP4 0
INDIRP4
CNSTI4 1524
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1547
line 2651
;2651:			G_sprint( p, 2, "Classhelp is ПО\n" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1549
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $1527
JUMPV
LABELV $1547
line 2653
;2652:		else
;2653:			G_sprint( p, 2, "Classhelp is ПЖЖ\n" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1550
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2654
;2654:		break;
ADDRGP4 $1527
JUMPV
LABELV $1551
line 2658
;2655:
;2656:	case 0x58862793:	//ms
;2657:	case 0x02E5FD61:	//multiscan
;2658:		if ( !( p->settings_bits & TF_MULTISCAN_MASK ) )
ADDRFP4 0
INDIRP4
CNSTI4 1524
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $1552
line 2659
;2659:			G_sprint( p, 2, "Multiscan is ПО\n" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1554
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $1527
JUMPV
LABELV $1552
line 2661
;2660:		else
;2661:			G_sprint( p, 2, "Multiscan is ПЖЖ\n" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1555
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2662
;2662:		break;
ADDRGP4 $1527
JUMPV
LABELV $1556
line 2665
;2663:	case 0x8DE8BDFF:	//ec
;2664:	case 0x6BDB6A88:	//exec_class
;2665:		if ( p->settings_bits & TF_EXEC_CLASS_MASK )
ADDRFP4 0
INDIRP4
CNSTI4 1524
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1557
line 2666
;2666:			G_sprint( p, 2, "Exec class is ПО\n" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1559
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $1527
JUMPV
LABELV $1557
line 2668
;2667:		else
;2668:			G_sprint( p, 2, "Exec class is ПЖЖ\n" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1560
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2669
;2669:		break;
ADDRGP4 $1527
JUMPV
LABELV $1561
line 2672
;2670:	case 0x6A5090F8:	//em
;2671:	case 0x5B8710D3:	//exec_map
;2672:		if ( p->settings_bits & TF_EXEC_MAP_MASK )
ADDRFP4 0
INDIRP4
CNSTI4 1524
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1562
line 2673
;2673:			G_sprint( p, 2, "Exec map is ПО\n" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1564
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $1527
JUMPV
LABELV $1562
line 2675
;2674:		else
;2675:			G_sprint( p, 2, "Exec map is ПЖЖ\n" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1565
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2676
;2676:		break;
ADDRGP4 $1527
JUMPV
LABELV $1566
line 2678
;2677:	case 0xCAD67046:	//take_sshot
;2678:		if ( p->settings_bits & TF_EXEC_MAP_MASK )
ADDRFP4 0
INDIRP4
CNSTI4 1524
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1567
line 2679
;2679:			G_sprint( p, 2, "Take screenshot is ПО\n" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1569
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $1527
JUMPV
LABELV $1567
line 2681
;2680:		else
;2681:			G_sprint( p, 2, "Take screenshot is ПЖЖ\n" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1570
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2682
;2682:		break;
ADDRGP4 $1527
JUMPV
LABELV $1571
line 2684
;2683:	case 0xE5A257DF:	//grensound
;2684:		if ( p->internal_settings_bits & TF_INTERNAL_GRENSOUND )
ADDRFP4 0
INDIRP4
CNSTI4 1528
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1572
line 2685
;2685:			G_sprint( p, 2, "Grenade sound is ПО\n" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1574
ARGP4
ADDRGP4 G_sprint
CALLV
pop
ADDRGP4 $1527
JUMPV
LABELV $1572
line 2687
;2686:		else
;2687:			G_sprint( p, 2, "Grenade sound is ПЖЖ\n" );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1575
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2688
;2688:		break;
ADDRGP4 $1527
JUMPV
LABELV $1526
line 2690
;2689:	default:
;2690:		return false;
CNSTI4 0
RETI4
ADDRGP4 $1525
JUMPV
LABELV $1527
line 2692
;2691:	}
;2692:	return true;
CNSTI4 1
RETI4
LABELV $1525
endproc PrintClientSetting 156 20
export Client_Set_Cmd
proc Client_Set_Cmd 52 12
line 2696
;2693:}
;2694:
;2695:void   Client_Set_Cmd(  )
;2696:{
line 2702
;2697:        char    key[20];
;2698:        char    value[20];
;2699:        int argc;
;2700:
;2701:
;2702:	argc = trap_CmdArgc();
ADDRLP4 44
ADDRGP4 trap_CmdArgc
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 44
INDIRI4
ASGNI4
line 2703
;2703:	if(argc < 2)
ADDRLP4 40
INDIRI4
CNSTI4 2
GEI4 $1600
line 2704
;2704:		return;
ADDRGP4 $1599
JUMPV
LABELV $1600
line 2705
;2705:        trap_CmdArgv( 1, key, sizeof( key ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 2706
;2706:	Q_strlwr( key );
ADDRLP4 0
ARGP4
ADDRGP4 Q_strlwr
CALLP4
pop
line 2707
;2707:	if(argc < 3)
ADDRLP4 40
INDIRI4
CNSTI4 3
GEI4 $1602
line 2708
;2708:	{
line 2709
;2709:		PrintClientSetting( self, key);
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 PrintClientSetting
CALLI4
pop
line 2710
;2710:		return;
ADDRGP4 $1599
JUMPV
LABELV $1602
line 2712
;2711:	}
;2712:        trap_CmdArgv( 2, value, sizeof( value ) );
CNSTI4 2
ARGI4
ADDRLP4 20
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 2713
;2713:	if( SetClientSetting( self, key, value) )
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 48
ADDRGP4 SetClientSetting
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $1604
line 2714
;2714:		PrintClientSetting( self, key);
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 PrintClientSetting
CALLI4
pop
LABELV $1604
line 2715
;2715:}
LABELV $1599
endproc Client_Set_Cmd 52 12
export ParseUserInfo
proc ParseUserInfo 160 24
line 2717
;2716:void ParseUserInfo()
;2717:{
line 2719
;2718:	char    value[100];
;2719:	self->assault_min_shells = DEFAULT_ASSAULT_MIN_SHELLS;
ADDRGP4 self
INDIRP4
CNSTI4 1504
ADDP4
CNSTI4 20
ASGNI4
line 2720
;2720:	self->StatusBarRes = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1492
ADDP4
CNSTI4 0
ASGNI4
line 2721
;2721:	self->StatusBarSize = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1488
ADDP4
CNSTI4 0
ASGNI4
line 2722
;2722:	self->discard_shells = -1;
ADDRGP4 self
INDIRP4
CNSTI4 1508
ADDP4
CNSTI4 -1
ASGNI4
line 2723
;2723:	self->discard_nails = -1;
ADDRGP4 self
INDIRP4
CNSTI4 1512
ADDP4
CNSTI4 -1
ASGNI4
line 2724
;2724:	self->discard_rockets = -1;
ADDRGP4 self
INDIRP4
CNSTI4 1516
ADDP4
CNSTI4 -1
ASGNI4
line 2725
;2725:	self->discard_cells = -1;
ADDRGP4 self
INDIRP4
CNSTI4 1520
ADDP4
CNSTI4 -1
ASGNI4
line 2726
;2726:	self->settings_bits = TF_CLASS_HELP_MASK;
ADDRGP4 self
INDIRP4
CNSTI4 1524
ADDP4
CNSTI4 4
ASGNI4
line 2727
;2727:	self->internal_settings_bits = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1528
ADDP4
CNSTI4 0
ASGNI4
line 2728
;2728:	self->take_sshot = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1532
ADDP4
CNSTI4 0
ASGNI4
line 2729
;2729:	if( GetInfokeyString( self, "sbr", "sbar_res" , value, sizeof( value ), NULL))
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1609
ARGP4
ADDRGP4 $1610
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 100
ARGI4
CNSTP4 0
ARGP4
ADDRLP4 100
ADDRGP4 GetInfokeyString
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
EQI4 $1607
line 2730
;2730:		SetClientSetting( self, "sbr", value);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1609
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SetClientSetting
CALLI4
pop
LABELV $1607
line 2731
;2731:	if( GetInfokeyString( self, "sbs", "sbar_size" , value, sizeof( value ), NULL))
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1613
ARGP4
ADDRGP4 $1614
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 100
ARGI4
CNSTP4 0
ARGP4
ADDRLP4 104
ADDRGP4 GetInfokeyString
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
EQI4 $1611
line 2732
;2732:		SetClientSetting( self, "sbs", value);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1613
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SetClientSetting
CALLI4
pop
LABELV $1611
line 2734
;2733:
;2734:	if( GetInfokeyString( self, "mxs", "1" , value, sizeof( value ), NULL))
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1617
ARGP4
ADDRGP4 $1618
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 100
ARGI4
CNSTP4 0
ARGP4
ADDRLP4 108
ADDRGP4 GetInfokeyString
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
EQI4 $1615
line 2735
;2735:		SetClientSetting( self, "mxs", value);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1617
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SetClientSetting
CALLI4
pop
LABELV $1615
line 2736
;2736:	if( GetInfokeyString( self, "mxn", "2" , value, sizeof( value ), NULL))
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1621
ARGP4
ADDRGP4 $1622
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 100
ARGI4
CNSTP4 0
ARGP4
ADDRLP4 112
ADDRGP4 GetInfokeyString
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
EQI4 $1619
line 2737
;2737:		SetClientSetting( self, "mxn", value);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1621
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SetClientSetting
CALLI4
pop
LABELV $1619
line 2738
;2738:	if( GetInfokeyString( self, "mxr", "3" , value, sizeof( value ), NULL))
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1625
ARGP4
ADDRGP4 $1626
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 100
ARGI4
CNSTP4 0
ARGP4
ADDRLP4 116
ADDRGP4 GetInfokeyString
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
EQI4 $1623
line 2739
;2739:		SetClientSetting( self, "mxr", value);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1625
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SetClientSetting
CALLI4
pop
LABELV $1623
line 2740
;2740:	if( GetInfokeyString( self, "mxc", "4" , value, sizeof( value ), NULL))
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1629
ARGP4
ADDRGP4 $1630
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 100
ARGI4
CNSTP4 0
ARGP4
ADDRLP4 120
ADDRGP4 GetInfokeyString
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
EQI4 $1627
line 2741
;2741:		SetClientSetting( self, "mxc", value);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1629
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SetClientSetting
CALLI4
pop
LABELV $1627
line 2743
;2742:
;2743:	if( GetInfokeyString( self, "sb", NULL , value, sizeof( value ), NULL))
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1633
ARGP4
ADDRLP4 124
CNSTP4 0
ASGNP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 100
ARGI4
ADDRLP4 124
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 GetInfokeyString
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 0
EQI4 $1631
line 2744
;2744:		SetClientSetting( self, "sb", value);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1633
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SetClientSetting
CALLI4
pop
LABELV $1631
line 2746
;2745:
;2746:	if( GetInfokeyString( self, "s", NULL , value, sizeof( value ), NULL))
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $247
ARGP4
ADDRLP4 132
CNSTP4 0
ASGNP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 100
ARGI4
ADDRLP4 132
INDIRP4
ARGP4
ADDRLP4 136
ADDRGP4 GetInfokeyString
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
EQI4 $1634
line 2747
;2747:		SetClientSetting( self, "s", value);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $247
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SetClientSetting
CALLI4
pop
LABELV $1634
line 2749
;2748:
;2749:	if( GetInfokeyString( self, "ch", "classhelp", value, sizeof( value ), NULL))
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1638
ARGP4
ADDRGP4 $1639
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 100
ARGI4
CNSTP4 0
ARGP4
ADDRLP4 140
ADDRGP4 GetInfokeyString
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1636
line 2750
;2750:		SetClientSetting( self, "ch", value);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1638
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SetClientSetting
CALLI4
pop
LABELV $1636
line 2752
;2751:
;2752:	if( GetInfokeyString( self, "ms", "multiscan", value, sizeof( value ), NULL))
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1642
ARGP4
ADDRGP4 $1643
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 100
ARGI4
CNSTP4 0
ARGP4
ADDRLP4 144
ADDRGP4 GetInfokeyString
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $1640
line 2753
;2753:		SetClientSetting( self, "ms", value);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1642
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SetClientSetting
CALLI4
pop
LABELV $1640
line 2755
;2754:
;2755:	if( GetInfokeyString( self, "ec", "exec_class", value, sizeof( value ), NULL))
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1646
ARGP4
ADDRGP4 $317
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 100
ARGI4
CNSTP4 0
ARGP4
ADDRLP4 148
ADDRGP4 GetInfokeyString
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $1644
line 2756
;2756:		SetClientSetting( self, "ec", value);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1646
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SetClientSetting
CALLI4
pop
LABELV $1644
line 2758
;2757:
;2758:	if( GetInfokeyString( self, "em", "exec_map", value, sizeof( value ), NULL))
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1649
ARGP4
ADDRGP4 $1650
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 100
ARGI4
CNSTP4 0
ARGP4
ADDRLP4 152
ADDRGP4 GetInfokeyString
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $1647
line 2759
;2759:		SetClientSetting( self, "em", value);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1649
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SetClientSetting
CALLI4
pop
LABELV $1647
line 2761
;2760:
;2761:	if( GetInfokeyString( self, "take_sshot", NULL, value, sizeof( value ), ""))
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1653
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 100
ARGI4
ADDRGP4 $205
ARGP4
ADDRLP4 156
ADDRGP4 GetInfokeyString
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $1651
line 2762
;2762:		SetClientSetting( self, "take_sshot", value);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1653
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SetClientSetting
CALLI4
pop
LABELV $1651
line 2763
;2763:}
LABELV $1606
endproc ParseUserInfo 160 24
export ClientConnect
proc ClientConnect 56 16
line 2772
;2764://-----------------------------------------------------------------------------------------------------
;2765:// GlobalParams:
;2766:// time
;2767:// self
;2768:// params
;2769:///////////////
;2770:
;2771:void ClientConnect()
;2772:{
line 2781
;2773:	gedict_t *te;
;2774://	int     sbres;
;2775:	//char    st[64];
;2776:	//char    st2[64];
;2777:
;2778:	int     got_one;
;2779:
;2780:	//G_bprint( PRINT_HIGH, "%s entered the game\n", self->s.v.netname );
;2781:	G_bprint( PRINT_HIGH, "%s joined!\n", self->s.v.netname );
CNSTI4 2
ARGI4
ADDRGP4 $1655
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
line 2783
;2782:
;2783:	self->tfstate |= TFSTATE_ZOOMOFF;
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 2784
;2784:	self->motd = 0;
ADDRGP4 self
INDIRP4
CNSTI4 944
ADDP4
CNSTI4 0
ASGNI4
line 2785
;2785:	self->got_aliases = 0;
ADDRGP4 self
INDIRP4
CNSTI4 856
ADDP4
CNSTI4 0
ASGNI4
line 2786
;2786:	if ( !self->s.v.netname[0] )
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1656
line 2787
;2787:		KickCheater( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickCheater
CALLV
pop
LABELV $1656
line 2788
;2788:	ParseUserInfo();
ADDRGP4 ParseUserInfo
CALLV
pop
line 2789
;2789:	stuffcmd( self, "tf_onconnect\n");
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1658
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
line 2790
;2790:	TeamFortress_ExecMapScript( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_ExecMapScript
CALLV
pop
line 2791
;2791:	self->has_disconnected = 0;
ADDRGP4 self
INDIRP4
CNSTI4 888
ADDP4
CNSTI4 0
ASGNI4
line 2793
;2792:
;2793:	if ( intermission_running )
ADDRGP4 intermission_running
INDIRF4
CNSTF4 0
EQF4 $1659
line 2794
;2794:		GotoNextMap();
ADDRGP4 GotoNextMap
CALLV
pop
LABELV $1659
line 2796
;2795:
;2796:	self->is_admin = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1564
ADDP4
CNSTI4 0
ASGNI4
line 2797
;2797:	if ( tf_data.clanbattle && self->has_disconnected != 1 )
ADDRGP4 tf_data+16
INDIRI4
CNSTI4 0
EQI4 $1661
ADDRGP4 self
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 1
EQI4 $1661
line 2798
;2798:	{
line 2799
;2799:		got_one = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2801
;2800:
;2801:		self->tf_id = GetInfokeyInt( self, "tf_id", NULL, 0 );
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $1664
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 16
ADDRGP4 GetInfokeyInt
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 1536
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 2802
;2802:		if ( self->tf_id )
ADDRGP4 self
INDIRP4
CNSTI4 1536
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1665
line 2803
;2803:		{
line 2804
;2804:			G_sprint( self, 2, "Welcome back!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1667
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2805
;2805:			te = trap_find( world, FOFS( s.v.classname ), "ghost" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $1668
ARGP4
ADDRLP4 20
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
ADDRGP4 $1670
JUMPV
LABELV $1669
line 2807
;2806:			while ( te )
;2807:			{
line 2808
;2808:				if ( te->tf_id == self->tf_id )
ADDRLP4 24
CNSTI4 1536
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRGP4 self
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
NEI4 $1672
line 2809
;2809:				{
line 2810
;2810:					got_one = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 2811
;2811:					TeamFortress_TeamSet( te->team_no );
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRGP4 TeamFortress_TeamSet
CALLI4
pop
line 2812
;2812:					self->s.v.frags = te->s.v.frags;
ADDRLP4 28
CNSTI4 300
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
line 2813
;2813:					self->real_frags = te->real_frags;
ADDRLP4 32
CNSTI4 1024
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
INDIRI4
ASGNI4
line 2814
;2814:					if ( !( tf_data.toggleflags & TFLAG_TEAMFRAGS ) && !( tf_data.toggleflags & TFLAG_FULLTEAMSCORE ) )
ADDRLP4 36
ADDRGP4 tf_data
INDIRI4
ASGNI4
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 128
BANDI4
ADDRLP4 40
INDIRI4
NEI4 $1674
ADDRLP4 36
INDIRI4
CNSTI4 2048
BANDI4
ADDRLP4 40
INDIRI4
NEI4 $1674
line 2815
;2815:						self->s.v.frags = self->real_frags;
ADDRLP4 44
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 300
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 1024
ADDP4
INDIRI4
CVIF4 4
ASGNF4
LABELV $1674
line 2816
;2816:					self->playerclass = te->playerclass;
ADDRLP4 48
CNSTI4 820
ASGNI4
ADDRGP4 self
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
line 2817
;2817:					self->tfstate = te->tfstate;
ADDRLP4 52
CNSTI4 892
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 2818
;2818:					dremove( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 2819
;2819:					te = world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
line 2820
;2820:				} else
ADDRGP4 $1673
JUMPV
LABELV $1672
line 2821
;2821:					te = trap_find( te, FOFS( s.v.classname ), "ghost" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $1668
ARGP4
ADDRLP4 28
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
LABELV $1673
line 2822
;2822:			}
LABELV $1670
line 2806
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1669
line 2823
;2823:		}
LABELV $1665
line 2824
;2824:		if ( !got_one )
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1676
line 2825
;2825:		{
line 2826
;2826:			if ( tf_data.game_locked && tf_data.cb_prematch_time < g_globalvars.time )
ADDRGP4 tf_data+32
INDIRI4
CNSTI4 0
EQI4 $1678
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $1678
line 2827
;2827:			{
line 2828
;2828:				G_sprint( self, 2, "Closed Server. Clan Battle in progress.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1683
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 2829
;2829:				KickCheater( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 KickCheater
CALLV
pop
line 2830
;2830:				return;
ADDRGP4 $1654
JUMPV
LABELV $1678
line 2832
;2831:			}
;2832:			last_id = last_id + 20 + g_random() * 10;
ADDRLP4 20
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 24
ADDRGP4 last_id
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 20
ADDI4
CVIF4 4
CNSTF4 1092616192
ADDRLP4 20
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 2833
;2833:			self->tf_id = floor( g_random() * 10 + last_id );
ADDRLP4 28
ADDRGP4 g_random
CALLF4
ASGNF4
CNSTF4 1092616192
ADDRLP4 28
INDIRF4
MULF4
ADDRGP4 last_id
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 32
ADDRGP4 floor
CALLF4
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 1536
ADDP4
ADDRLP4 32
INDIRF4
CVFI4 4
ASGNI4
line 2834
;2834:			stuffcmd( self, "setinfo tf_id %d\n", self->tf_id );
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 $1684
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 1536
ADDP4
INDIRI4
ARGI4
ADDRGP4 stuffcmd
CALLV
pop
line 2835
;2835:			G_sprint( self, 2, "Your Battle ID is %d\n", self->tf_id );
ADDRLP4 40
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1685
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 1536
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_sprint
CALLV
pop
line 2836
;2836:		}
LABELV $1676
line 2837
;2837:	}
LABELV $1661
line 2838
;2838:	if ( tf_data.cb_prematch_time > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $1686
line 2839
;2839:		G_sprint( self, 2, "CURRENTLY IN PREMATCH TIME\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $1690
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $1686
line 2840
;2840:        if( tg_data.tg_enabled )
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $1691
line 2841
;2841:		stuffcmd( self, "exec tg.cfg\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $1693
ARGP4
ADDRGP4 stuffcmd
CALLV
pop
LABELV $1691
line 2842
;2842:}
LABELV $1654
endproc ClientConnect 56 16
export ClientDisconnect
proc ClientDisconnect 56 28
line 2850
;2843:
;2844:////////////////
;2845:// GlobalParams:
;2846:// self
;2847:///////////////
;2848:
;2849:void ClientDisconnect()
;2850:{
line 2855
;2851:	gedict_t *te,*saveself;
;2852:
;2853://      float   fr;
;2854:
;2855:	G_bprint( PRINT_HIGH, "%s left the game with %.0f frags\n", self->s.v.netname, self->s.v.frags );
CNSTI4 2
ARGI4
ADDRGP4 $1695
ARGP4
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 300
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_bprint
CALLV
pop
line 2858
;2856:
;2857:	//sound( self, CHAN_BODY, "player/tornoff2.wav", 1, ATTN_NONE );
;2858:	sound( self, CHAN_BODY, "misc/eject.wav", 1, ATTN_NONE );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 $1696
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 sound
CALLV
pop
line 2860
;2859:
;2860:	te = trap_find( world, FOFS( s.v.classname ), "primer" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $1697
ARGP4
ADDRLP4 12
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
ADDRGP4 $1699
JUMPV
LABELV $1698
line 2862
;2861:	while ( te && te->s.v.owner != EDICT_TO_PROG( self ) )
;2862:		te = trap_find( te, FOFS( s.v.classname ), "primer" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $1697
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
LABELV $1699
line 2861
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1701
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
NEI4 $1698
LABELV $1701
line 2863
;2863:	if ( te )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1702
line 2865
;2864://  te->s.v.nextthink = g_globalvars.time;
;2865:	{
line 2866
;2866:		self->s.v.deadflag = DEAD_DYING;
ADDRGP4 self
INDIRP4
CNSTI4 348
ADDP4
CNSTF4 1065353216
ASGNF4
line 2867
;2867:		saveself = self;
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
line 2868
;2868:		self = te;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 2869
;2869:		( ( void ( * )(  ) ) ( self->s.v.think ) ) (  );
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
CVIU4 4
CVUP4 4
CALLV
pop
line 2870
;2870:		self = saveself;
ADDRGP4 self
ADDRLP4 4
INDIRP4
ASGNP4
line 2871
;2871:		self->s.v.deadflag = DEAD_NO;
ADDRGP4 self
INDIRP4
CNSTI4 348
ADDP4
CNSTF4 0
ASGNF4
line 2872
;2872:	}
LABELV $1702
line 2874
;2873:
;2874:	self->has_disconnected = 1;
ADDRGP4 self
INDIRP4
CNSTI4 888
ADDP4
CNSTI4 1
ASGNI4
line 2875
;2875:	TeamFortress_RemoveTimers();
ADDRGP4 TeamFortress_RemoveTimers
CALLV
pop
line 2878
;2876:
;2877:
;2878:	Engineer_RemoveBuildings( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 Engineer_RemoveBuildings
CALLV
pop
line 2879
;2879:	te = trap_find( world, FOFS( s.v.classname ), "detpack" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $1704
ARGP4
ADDRLP4 24
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
ADDRGP4 $1706
JUMPV
LABELV $1705
line 2881
;2880:	while ( te )
;2881:	{
line 2882
;2882:		if ( te->real_owner == self )
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 self
INDIRP4
CVPU4 4
NEU4 $1708
line 2883
;2883:		{
line 2884
;2884:			if ( te->weaponmode == 1 )
ADDRLP4 0
INDIRP4
CNSTI4 940
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1710
line 2885
;2885:			{
line 2886
;2886:				TeamFortress_SetSpeed( PROG_TO_EDICT( te->s.v.enemy ) );
ADDRLP4 0
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
line 2887
;2887:				dremove( te->oldenemy );
ADDRLP4 0
INDIRP4
CNSTI4 980
ADDP4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 2888
;2888:				dremove( te->observer_list );
ADDRLP4 0
INDIRP4
CNSTI4 900
ADDP4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 2889
;2889:			}
LABELV $1710
line 2890
;2890:			dremove( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 2891
;2891:			te = world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
line 2892
;2892:		}
LABELV $1708
line 2893
;2893:		te = trap_find( te, FOFS( s.v.classname ), "detpack" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $1704
ARGP4
ADDRLP4 28
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 2894
;2894:	}
LABELV $1706
line 2880
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1705
line 2895
;2895:	if ( tf_data.clanbattle && self->tf_id )
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRGP4 tf_data+16
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $1712
ADDRGP4 self
INDIRP4
CNSTI4 1536
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $1712
line 2896
;2896:	{
line 2897
;2897:		te = spawn();
ADDRLP4 32
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 2898
;2898:		te->s.v.classname = "ghost";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $1668
ASGNP4
line 2899
;2899:		te->tf_id = self->tf_id;
ADDRLP4 36
CNSTI4 1536
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
line 2900
;2900:		te->team_no = self->team_no;
ADDRLP4 40
CNSTI4 960
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
line 2901
;2901:		te->s.v.frags = self->s.v.frags;
ADDRLP4 44
CNSTI4 300
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
INDIRF4
ASGNF4
line 2902
;2902:		te->real_frags = self->real_frags;
ADDRLP4 48
CNSTI4 1024
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
line 2904
;2903:		//te->netname = self->netname;
;2904:		te->playerclass = self->playerclass;
ADDRLP4 52
CNSTI4 820
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
line 2905
;2905:		if ( self->tfstate & 8 )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1715
line 2906
;2906:			te->tfstate = 8;
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
CNSTI4 8
ASGNI4
LABELV $1715
line 2907
;2907:	}
LABELV $1712
line 2908
;2908:	set_suicide_frame();
ADDRGP4 set_suicide_frame
CALLV
pop
line 2909
;2909:	self->s.v.netname[0] = 0;
ADDRGP4 self
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
CNSTI1 0
ASGNI1
line 2910
;2910:	self->team_no = 0;
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
CNSTI4 0
ASGNI4
line 2911
;2911:	self->s.v.solid = 0;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 2912
;2912:	setsize( self, 0, 0, 0, 0, 0, 0 );
ADDRGP4 self
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
line 2914
;2913://vote
;2914:	if( current_vote != -1 )
ADDRGP4 current_vote
INDIRI4
CNSTI4 -1
EQI4 $1717
line 2915
;2915:		votes[current_vote].VoteNo();
CNSTI4 24
ADDRGP4 current_vote
INDIRI4
MULI4
ADDRGP4 votes+12
ADDP4
INDIRP4
CALLV
pop
LABELV $1717
line 2916
;2916:}
LABELV $1694
endproc ClientDisconnect 56 28
export ClientObituary
proc ClientObituary 120 20
line 2927
;2917:
;2918:/*
;2919:===========
;2920:ClientObituary
;2921:
;2922:called when a player dies
;2923:============
;2924:*/
;2925:void Mega_ClientObituary( gedict_t* targ, gedict_t* attacker );
;2926:void ClientObituary( gedict_t * targ, gedict_t * attacker )
;2927:{
line 2929
;2928:	float   rnum;
;2929:	char   *deathstring = "";
ADDRLP4 0
ADDRGP4 $205
ASGNP4
line 2935
;2930:	//char   *deathstring2 = "";
;2931:	//float   attackerteam;
;2932:	//float   targteam;
;2933:	//gedict_t *te;
;2934:
;2935:	if ( tf_data.old_dmsg != TRUE || tf_data.megatf_dmg == tf_data.deathmsg ) {
ADDRGP4 tf_data+204
INDIRI4
CNSTI4 1
NEI4 $1726
ADDRGP4 tf_data+208
INDIRI4
ADDRGP4 tf_data+88
INDIRI4
NEI4 $1721
LABELV $1726
line 2936
;2936:		Mega_ClientObituary( targ, attacker );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Mega_ClientObituary
CALLV
pop
line 2937
;2937:		return;
ADDRGP4 $1720
JUMPV
LABELV $1721
line 2940
;2938:	}
;2939:
;2940:	rnum = g_random();
ADDRLP4 8
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 2941
;2941:	if ( tf_data.cb_prematch_time + 3 > g_globalvars.time )
ADDRGP4 tf_data+24
INDIRF4
CNSTF4 1077936128
ADDF4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $1727
line 2942
;2942:		return;
ADDRGP4 $1720
JUMPV
LABELV $1727
line 2943
;2943:	if ( strneq( targ->s.v.classname, "player" ) )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $190
ARGP4
ADDRLP4 12
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $1731
line 2944
;2944:	{
line 2945
;2945:		if ( streq( targ->s.v.classname, "building_sentrygun" ) )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $1735
ARGP4
ADDRLP4 16
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $1733
line 2946
;2946:		{
line 2947
;2947:			if ( streq( attacker->s.v.classname, "teledeath" ) )
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $1738
ARGP4
ADDRLP4 20
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $1736
line 2948
;2948:			{
line 2949
;2949:				G_bprint( 1, "%s's sentrygun was telefragged by %s\n", targ->real_owner->s.v.netname,
CNSTI4 1
ARGI4
ADDRGP4 $1739
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
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
line 2951
;2950:					  PROG_TO_EDICT( attacker->s.v.owner )->s.v.netname );
;2951:				return;
ADDRGP4 $1720
JUMPV
LABELV $1736
line 2953
;2952:			}
;2953:			if ( streq( attacker->s.v.classname, "player" ) )
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $190
ARGP4
ADDRLP4 24
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1734
line 2954
;2954:			{
line 2955
;2955:				if ( attacker == targ->real_owner )
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CVPU4 4
NEU4 $1744
line 2956
;2956:				{
line 2957
;2957:					G_bprint( 1, "%s destroys his sentrygun\n", targ->real_owner->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $1746
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 2958
;2958:					return;
ADDRGP4 $1720
JUMPV
LABELV $1744
line 2960
;2959:				}
;2960:				G_bprint( 1, "%s's sentrygun was destroyed by %s\n", targ->real_owner->s.v.netname,
CNSTI4 1
ARGI4
ADDRGP4 $1747
ARGP4
ADDRLP4 28
CNSTI4 396
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 2962
;2961:					  attacker->s.v.netname );
;2962:				if ( attacker->team_no > 0 && attacker->team_no == targ->real_owner->team_no )
ADDRLP4 32
CNSTI4 960
ASGNI4
ADDRLP4 36
ADDRFP4 4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
LEI4 $1748
ADDRLP4 36
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
NEI4 $1748
line 2963
;2963:				{
line 2964
;2964:					TF_AddFrags( attacker, -1 );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
line 2965
;2965:					attacker->teamkills = attacker->teamkills + 1;
ADDRLP4 40
ADDRFP4 4
INDIRP4
CNSTI4 1540
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2966
;2966:					CheckAutoKick( attacker );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CheckAutoKick
CALLV
pop
line 2967
;2967:				} else
ADDRGP4 $1720
JUMPV
LABELV $1748
line 2968
;2968:					TF_AddFrags( attacker, 1 );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
line 2969
;2969:				return;
ADDRGP4 $1720
JUMPV
line 2971
;2970:			}
;2971:		} else
LABELV $1733
line 2972
;2972:		{
line 2973
;2973:			if ( streq( targ->s.v.classname, "building_dispenser" ) )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $1752
ARGP4
ADDRLP4 20
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $1750
line 2974
;2974:			{
line 2975
;2975:				if ( attacker->team_no > 0 && attacker->team_no == targ->real_owner->team_no )
ADDRLP4 24
CNSTI4 960
ASGNI4
ADDRLP4 28
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LEI4 $1753
ADDRLP4 28
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
NEI4 $1753
line 2976
;2976:				{
line 2977
;2977:					TF_AddFrags( attacker, -1 );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
line 2978
;2978:					attacker->teamkills = attacker->teamkills + 1;
ADDRLP4 32
ADDRFP4 4
INDIRP4
CNSTI4 1540
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2979
;2979:					CheckAutoKick( attacker );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CheckAutoKick
CALLV
pop
line 2980
;2980:				}
LABELV $1753
line 2981
;2981:			}
LABELV $1750
line 2982
;2982:		}
LABELV $1734
line 2983
;2983:	}
LABELV $1731
line 2984
;2984:	if ( strneq( targ->s.v.classname, "player" ) )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $190
ARGP4
ADDRLP4 16
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $1755
line 2985
;2985:		return;
ADDRGP4 $1720
JUMPV
LABELV $1755
line 2987
;2986://player deaths
;2987:	if ( streq( attacker->s.v.classname, "teledeath" ) )
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $1738
ARGP4
ADDRLP4 20
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $1757
line 2988
;2988:	{
line 2989
;2989:		G_bprint( 1, "%s was telefragged by %s\n", targ->s.v.netname,
CNSTI4 1
ARGI4
ADDRGP4 $1759
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
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
line 2991
;2990:			  PROG_TO_EDICT( attacker->s.v.owner )->s.v.netname );
;2991:		if ( PROG_TO_EDICT( attacker->s.v.owner )->team_no != targ->team_no
ADDRLP4 24
ADDRFP4 4
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
NEI4 $1766
ADDRLP4 24
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
CNSTI4 1
GEI4 $1720
LABELV $1766
line 2993
;2992:		     || PROG_TO_EDICT( attacker->s.v.owner )->team_no < 1 )
;2993:			TF_AddFrags( PROG_TO_EDICT( attacker->s.v.owner ), 1 );
ADDRFP4 4
INDIRP4
CNSTI4 480
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
line 2994
;2994:		return;
ADDRGP4 $1720
JUMPV
LABELV $1757
line 2996
;2995:	}
;2996:	if ( streq( attacker->s.v.classname, "teledeath2" ) )
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $1769
ARGP4
ADDRLP4 24
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1767
line 2997
;2997:	{
line 2998
;2998:		G_bprint( 1, "Satan's power deflects %s's telefrag\n", targ->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $1770
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 2999
;2999:		TF_AddFrags( targ, -1 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
line 3000
;3000:		logfrag( targ, targ );
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
ADDRGP4 logfrag
CALLV
pop
line 3001
;3001:		return;
ADDRGP4 $1720
JUMPV
LABELV $1767
line 3003
;3002:	}
;3003:	if ( tf_data.deathmsg == DMSG_TEAMKILL )
ADDRGP4 tf_data+88
INDIRI4
CNSTI4 37
NEI4 $1771
line 3004
;3004:	{
line 3005
;3005:		G_bprint( 1, "%s shoots his teammate one too many times.\n", targ->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $1774
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 3006
;3006:		return;
ADDRGP4 $1720
JUMPV
LABELV $1771
line 3008
;3007:	}
;3008:	if ( streq( attacker->s.v.classname, "info_tfgoal" ) || streq( attacker->s.v.classname, "item_tfgoal" ) )
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $1777
ARGP4
ADDRLP4 28
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $1778
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $1328
ARGP4
ADDRLP4 32
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $1775
LABELV $1778
line 3009
;3009:	{
line 3010
;3010:		if ( attacker->deathtype && attacker->deathtype[0] )
ADDRLP4 36
ADDRFP4 4
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1779
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1779
line 3011
;3011:		{
line 3012
;3012:			G_bprint( 1, "%s%s", targ->s.v.netname, attacker->deathtype );
CNSTI4 1
ARGI4
ADDRGP4 $1781
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 3013
;3013:		}
LABELV $1779
line 3014
;3014:		logfrag( targ, targ );
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 logfrag
CALLV
pop
line 3015
;3015:		return;
ADDRGP4 $1720
JUMPV
LABELV $1775
line 3018
;3016:	}
;3017://player vs player or bot
;3018:	if ( streq( attacker->s.v.classname, "player" ) || streq( attacker->s.v.classname, "bot" ) )
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $190
ARGP4
ADDRLP4 36
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $1785
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $1784
ARGP4
ADDRLP4 40
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $1782
LABELV $1785
line 3019
;3019:	{
line 3020
;3020:		if ( targ == attacker )
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $1786
line 3021
;3021:		{
line 3022
;3022:			TF_AddFrags( attacker, -1 );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
line 3023
;3023:			if ( tf_data.birthday == 1 && g_random() < 0.3 )
ADDRGP4 tf_data+92
INDIRI4
CNSTI4 1
NEI4 $1788
ADDRLP4 44
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 44
INDIRF4
CNSTF4 1050253722
GEF4 $1788
line 3024
;3024:			{
line 3025
;3025:				if ( g_random() < 0.1 )
ADDRLP4 48
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 48
INDIRF4
CNSTF4 1036831949
GEF4 $1791
line 3026
;3026:				{
line 3027
;3027:					G_bprint( 1, "It's %s's party and he'll cry if he wants to!\n",
CNSTI4 1
ARGI4
ADDRGP4 $1793
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 3029
;3028:						  targ->s.v.netname );
;3029:					return;
ADDRGP4 $1720
JUMPV
LABELV $1791
line 3031
;3030:				}
;3031:				if ( g_random() < 0.5 )
ADDRLP4 52
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 52
INDIRF4
CNSTF4 1056964608
GEF4 $1794
line 3032
;3032:					G_bprint( 1, "%s gets too selfish with his gifts\n", targ->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $1796
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
ADDRGP4 $1720
JUMPV
LABELV $1794
line 3034
;3033:				else
;3034:					G_bprint( 1, "%s wasn't born so beautiful after all\n", targ->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $1797
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 3035
;3035:				return;
ADDRGP4 $1720
JUMPV
LABELV $1788
line 3037
;3036:			}
;3037:			switch ( tf_data.deathmsg )
ADDRLP4 48
ADDRGP4 tf_data+88
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 5
LTI4 $1798
ADDRLP4 48
INDIRI4
CNSTI4 41
GTI4 $1798
ADDRLP4 48
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1872-20
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1872
address $1860
address $1853
address $1864
address $1801
address $1824
address $1826
address $1835
address $1849
address $1851
address $1798
address $1862
address $1798
address $1798
address $1798
address $1798
address $1798
address $1798
address $1798
address $1798
address $1839
address $1798
address $1798
address $1798
address $1798
address $1798
address $1841
address $1847
address $1798
address $1858
address $1798
address $1845
address $1798
address $1798
address $1868
address $1870
address $1837
address $1843
code
line 3038
;3038:			{
LABELV $1801
line 3040
;3039:			case 8:
;3040:				switch ( targ->playerclass )
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
ADDRLP4 60
CNSTI4 2
ASGNI4
ADDRLP4 52
INDIRI4
ADDRLP4 60
INDIRI4
LTI4 $1802
ADDRLP4 52
INDIRI4
CNSTI4 9
GTI4 $1802
ADDRLP4 52
INDIRI4
ADDRLP4 60
INDIRI4
LSHI4
ADDRGP4 $1822-8
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1822
address $1805
address $1807
address $1809
address $1811
address $1813
address $1815
address $1817
address $1819
code
line 3041
;3041:				{
LABELV $1805
line 3043
;3042:				case 2:
;3043:					deathstring = "%s got splattered by his own grenade\n";
ADDRLP4 0
ADDRGP4 $1806
ASGNP4
line 3044
;3044:					break;
ADDRGP4 $1799
JUMPV
LABELV $1807
line 3046
;3045:				case 3:
;3046:					deathstring = "%s sat on his own grenade\n";
ADDRLP4 0
ADDRGP4 $1808
ASGNP4
line 3047
;3047:					break;
ADDRGP4 $1799
JUMPV
LABELV $1809
line 3049
;3048:				case 4:
;3049:					deathstring = "%s got to know his grenade too well\n";
ADDRLP4 0
ADDRGP4 $1810
ASGNP4
line 3050
;3050:					break;
ADDRGP4 $1799
JUMPV
LABELV $1811
line 3052
;3051:				case 5:
;3052:					deathstring = "%s caught the end of his own grenade\n";
ADDRLP4 0
ADDRGP4 $1812
ASGNP4
line 3053
;3053:					break;
ADDRGP4 $1799
JUMPV
LABELV $1813
line 3055
;3054:				case 6:
;3055:					deathstring = "%s got too close to his own grenade\n";
ADDRLP4 0
ADDRGP4 $1814
ASGNP4
line 3056
;3056:					break;
ADDRGP4 $1799
JUMPV
LABELV $1815
line 3058
;3057:				case 7:
;3058:					deathstring = "%s let his own grenade get the best of him\n";
ADDRLP4 0
ADDRGP4 $1816
ASGNP4
line 3059
;3059:					break;
ADDRGP4 $1799
JUMPV
LABELV $1817
line 3061
;3060:				case 8:
;3061:					deathstring = "%s tiptoed over his own grenade\n";
ADDRLP4 0
ADDRGP4 $1818
ASGNP4
line 3062
;3062:					break;
ADDRGP4 $1799
JUMPV
LABELV $1819
line 3064
;3063:				case 9:
;3064:					deathstring = "%s stared at his grenade too long\n";
ADDRLP4 0
ADDRGP4 $1820
ASGNP4
line 3065
;3065:					break;
ADDRGP4 $1799
JUMPV
LABELV $1802
line 3067
;3066:				default:
;3067:					deathstring = "%s grenades himself\n";
ADDRLP4 0
ADDRGP4 $1821
ASGNP4
line 3068
;3068:					break;
line 3070
;3069:				}
;3070:				break;
ADDRGP4 $1799
JUMPV
LABELV $1824
line 3072
;3071:			case 9:
;3072:				deathstring = "%s hammers himself\n";
ADDRLP4 0
ADDRGP4 $1825
ASGNP4
line 3073
;3073:				break; 
ADDRGP4 $1799
JUMPV
LABELV $1826
line 3075
;3074:			case 10:
;3075:				switch ( targ->playerclass )
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 4
EQI4 $1830
ADDRLP4 64
INDIRI4
CNSTI4 6
EQI4 $1832
ADDRGP4 $1827
JUMPV
line 3076
;3076:				{
LABELV $1830
line 3078
;3077:				case 4:
;3078:					deathstring = "%s practiced his own Mirv dance\n";
ADDRLP4 0
ADDRGP4 $1831
ASGNP4
line 3079
;3079:					break;
ADDRGP4 $1799
JUMPV
LABELV $1832
line 3081
;3080:				case 6:
;3081:					deathstring = "%s allowed his Mirv to turn against him\n";
ADDRLP4 0
ADDRGP4 $1833
ASGNP4
line 3082
;3082:					break;
ADDRGP4 $1799
JUMPV
LABELV $1827
line 3084
;3083:				default:
;3084:					deathstring = "%s goes to pieces\n";
ADDRLP4 0
ADDRGP4 $1834
ASGNP4
line 3085
;3085:					break;
line 3088
;3086:
;3087:				}
;3088:				break;
ADDRGP4 $1799
JUMPV
LABELV $1835
line 3090
;3089:			case 11:
;3090:				deathstring = "%s ambushes himself with his own pipebombs\n";
ADDRLP4 0
ADDRGP4 $1836
ASGNP4
line 3091
;3091:				break;
ADDRGP4 $1799
JUMPV
LABELV $1837
line 3093
;3092:			case 40:
;3093:				deathstring = "%s tried to juggle his own pipebombs\n";
ADDRLP4 0
ADDRGP4 $1838
ASGNP4
line 3094
;3094:				break;
ADDRGP4 $1799
JUMPV
LABELV $1839
line 3096
;3095:			case 24:
;3096:				deathstring = "%s chokes on his own gas\n";
ADDRLP4 0
ADDRGP4 $1840
ASGNP4
line 3097
;3097:				break;
ADDRGP4 $1799
JUMPV
LABELV $1841
line 3099
;3098:			case 30:
;3099:				deathstring = "%s explodes his ammo and body\n";
ADDRLP4 0
ADDRGP4 $1842
ASGNP4
line 3100
;3100:				break;
ADDRGP4 $1799
JUMPV
LABELV $1843
line 3102
;3101:			case 41:
;3102:				deathstring = "%s stepped on too many of his own caltrops\n";
ADDRLP4 0
ADDRGP4 $1844
ASGNP4
line 3103
;3103:				break;
ADDRGP4 $1799
JUMPV
LABELV $1845
line 3105
;3104:			case 35:
;3105:				deathstring = "%s is charred by his own flash grenade\n";
ADDRLP4 0
ADDRGP4 $1846
ASGNP4
line 3106
;3106:				break;
ADDRGP4 $1799
JUMPV
LABELV $1847
line 3108
;3107:			case 31:
;3108:				deathstring = "%s detonates an ammo box too close to him\n";
ADDRLP4 0
ADDRGP4 $1848
ASGNP4
line 3109
;3109:				break;
ADDRGP4 $1799
JUMPV
LABELV $1849
line 3111
;3110:			case 12:
;3111:				deathstring = "%s set the detpack and forgot to run\n";
ADDRLP4 0
ADDRGP4 $1850
ASGNP4
line 3112
;3112:				break;
ADDRGP4 $1799
JUMPV
LABELV $1851
line 3114
;3113:			case 13:
;3114:				deathstring = "%s died impossibly!\n";
ADDRLP4 0
ADDRGP4 $1852
ASGNP4
line 3115
;3115:				break;
ADDRGP4 $1799
JUMPV
LABELV $1853
line 3117
;3116:			case 6:
;3117:				if ( rnum < 0.5 )
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
GEF4 $1854
line 3118
;3118:					deathstring = "%s becomes bored with life\n";
ADDRLP4 0
ADDRGP4 $1856
ASGNP4
ADDRGP4 $1799
JUMPV
LABELV $1854
line 3120
;3119:				else
;3120:					deathstring = "%s checks if his weapon is loaded\n";
ADDRLP4 0
ADDRGP4 $1857
ASGNP4
line 3121
;3121:				break;
ADDRGP4 $1799
JUMPV
LABELV $1858
line 3123
;3122:			case 33:
;3123:				deathstring = "%s chars himself with an incendiary rocket\n";
ADDRLP4 0
ADDRGP4 $1859
ASGNP4
line 3124
;3124:				break;
ADDRGP4 $1799
JUMPV
LABELV $1860
line 3126
;3125:			case 5:
;3126:				deathstring = "%s tries to put the pin back in\n";
ADDRLP4 0
ADDRGP4 $1861
ASGNP4
line 3127
;3127:				break;
ADDRGP4 $1799
JUMPV
LABELV $1862
line 3129
;3128:			case 15:
;3129:				deathstring = "%s torches himself\n";
ADDRLP4 0
ADDRGP4 $1863
ASGNP4
line 3130
;3130:				break;
ADDRGP4 $1799
JUMPV
LABELV $1864
line 3132
;3131:			case 7:
;3132:				if ( targ->s.v.waterlevel > 1 )
ADDRFP4 0
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 1065353216
LEF4 $1799
line 3133
;3133:					deathstring = "%s discharges into the water.\n";
ADDRLP4 0
ADDRGP4 $1867
ASGNP4
line 3134
;3134:				break;
ADDRGP4 $1799
JUMPV
LABELV $1868
line 3136
;3135:			case 38:
;3136:				deathstring = "%s gets too friendly with his sentrygun.\n";
ADDRLP4 0
ADDRGP4 $1869
ASGNP4
line 3137
;3137:				break;
ADDRGP4 $1799
JUMPV
LABELV $1870
line 3139
;3138:			case 39:
;3139:				deathstring = "%s dispenses with himself.\n";
ADDRLP4 0
ADDRGP4 $1871
ASGNP4
line 3140
;3140:				break;
LABELV $1798
LABELV $1799
line 3142
;3141:			}
;3142:			G_bprint( 1, deathstring, targ->s.v.netname );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 3143
;3143:			return;
ADDRGP4 $1720
JUMPV
LABELV $1786
line 3146
;3144:		}		//end of sucides
;3145:		else
;3146:		{
line 3147
;3147:			if ( teamplay && attacker->team_no == targ->team_no && attacker->team_no > 0 )
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRGP4 teamplay
INDIRI4
ADDRLP4 44
INDIRI4
EQI4 $1874
ADDRLP4 48
CNSTI4 960
ASGNI4
ADDRLP4 52
ADDRFP4 4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
NEI4 $1874
ADDRLP4 52
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $1874
line 3148
;3148:			{
line 3149
;3149:				TF_AddFrags( attacker, -1 );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
line 3150
;3150:				if ( !targ->undercover_team )
ADDRFP4 0
INDIRP4
CNSTI4 1404
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1876
line 3151
;3151:					attacker->teamkills = attacker->teamkills + 1;
ADDRLP4 56
ADDRFP4 4
INDIRP4
CNSTI4 1540
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1876
line 3152
;3152:				if ( tf_data.birthday == 1 && g_random() < 0.3 )
ADDRGP4 tf_data+92
INDIRI4
CNSTI4 1
NEI4 $1878
ADDRLP4 60
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 60
INDIRF4
CNSTF4 1050253722
GEF4 $1878
line 3153
;3153:				{
line 3154
;3154:					if ( g_random() < 0.3 )
ADDRLP4 64
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 64
INDIRF4
CNSTF4 1050253722
GEF4 $1881
line 3155
;3155:						G_bprint( 1, "%s is a party-pooper!\n", targ->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $1883
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
ADDRGP4 $1720
JUMPV
LABELV $1881
line 3157
;3156:					else
;3157:						G_bprint( 1, "%s gives gifts to his teammates!\n", targ->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $1884
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 3158
;3158:					return;
ADDRGP4 $1720
JUMPV
LABELV $1878
line 3160
;3159:				}
;3160:				switch ( ( int ) ( g_random() * 4 ) )
ADDRLP4 68
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 64
CNSTF4 1082130432
ADDRLP4 68
INDIRF4
MULF4
CVFI4 4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $1888
ADDRLP4 64
INDIRI4
CNSTI4 1
EQI4 $1890
ADDRLP4 64
INDIRI4
CNSTI4 2
EQI4 $1892
ADDRGP4 $1885
JUMPV
line 3161
;3161:				{
LABELV $1888
line 3163
;3162:				case 0:
;3163:					deathstring = "%s mows down teammate %s\n";
ADDRLP4 0
ADDRGP4 $1889
ASGNP4
line 3164
;3164:					break;
ADDRGP4 $1886
JUMPV
LABELV $1890
line 3166
;3165:				case 1:
;3166:					deathstring = "%s checks his glasses after killing %s\n";
ADDRLP4 0
ADDRGP4 $1891
ASGNP4
line 3167
;3167:					break;
ADDRGP4 $1886
JUMPV
LABELV $1892
line 3169
;3168:				case 2:
;3169:					deathstring = "%s gets a frag for the other team with %s's death\n";
ADDRLP4 0
ADDRGP4 $1893
ASGNP4
line 3170
;3170:					break;
ADDRGP4 $1886
JUMPV
LABELV $1885
line 3172
;3171:				default:
;3172:					deathstring = "%s killed his supposed friend %s\n";
ADDRLP4 0
ADDRGP4 $1894
ASGNP4
line 3173
;3173:					break;
LABELV $1886
line 3175
;3174:				}
;3175:				if ( tf_data.deathmsg == DMSG_MEDIKIT )
ADDRGP4 tf_data+88
INDIRI4
CNSTI4 23
NEI4 $1895
line 3176
;3176:				{
line 3177
;3177:					G_bprint( 1, "%s didn't survive the operation by %s\n", targ->s.v.netname,
CNSTI4 1
ARGI4
ADDRGP4 $1898
ARGP4
ADDRLP4 76
CNSTI4 396
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 3179
;3178:						  attacker->s.v.netname );
;3179:					return;
ADDRGP4 $1720
JUMPV
LABELV $1895
line 3181
;3180:				}
;3181:				G_bprint( 1, deathstring, attacker->s.v.netname, targ->s.v.netname );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 76
CNSTI4 396
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 3182
;3182:				CheckAutoKick( attacker );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CheckAutoKick
CALLV
pop
line 3183
;3183:				return;
ADDRGP4 $1720
JUMPV
LABELV $1874
line 3186
;3184:			}	//end of teamkills
;3185:			else
;3186:			{
line 3187
;3187:				TF_AddFrags( attacker, 1 );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
line 3188
;3188:				logfrag( attacker, targ );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 logfrag
CALLV
pop
line 3189
;3189:				if ( tf_data.birthday == 1 && g_random() < 0.5 )
ADDRGP4 tf_data+92
INDIRI4
CNSTI4 1
NEI4 $1899
ADDRLP4 56
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 56
INDIRF4
CNSTF4 1056964608
GEF4 $1899
line 3190
;3190:				{
line 3191
;3191:					switch ( tf_data.deathmsg )
ADDRLP4 60
ADDRGP4 tf_data+88
INDIRI4
ASGNI4
ADDRLP4 64
CNSTI4 2
ASGNI4
ADDRLP4 60
INDIRI4
ADDRLP4 64
INDIRI4
LTI4 $1902
ADDRLP4 60
INDIRI4
CNSTI4 35
GTI4 $1902
ADDRLP4 60
INDIRI4
ADDRLP4 64
INDIRI4
LSHI4
ADDRGP4 $1968-8
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1968
address $1955
address $1961
address $1902
address $1922
address $1927
address $1902
address $1902
address $1905
address $1907
address $1902
address $1915
address $1902
address $1902
address $1932
address $1920
address $1902
address $1937
address $1949
address $1951
address $1902
address $1953
address $1902
address $1902
address $1957
address $1959
address $1902
address $1947
address $1942
address $1909
address $1913
address $1902
address $1963
address $1902
address $1911
code
line 3192
;3192:					{
LABELV $1905
line 3194
;3193:					case 9:
;3194:						deathstring = "%s chews on %s's nails!\n";
ADDRLP4 0
ADDRGP4 $1906
ASGNP4
line 3195
;3195:						break;
ADDRGP4 $1903
JUMPV
LABELV $1907
line 3197
;3196:					case 10:
;3197:						deathstring = "%s gathers the darling buds of %s's Mirv grenade\n";
ADDRLP4 0
ADDRGP4 $1908
ASGNP4
line 3198
;3198:						break;
ADDRGP4 $1903
JUMPV
LABELV $1909
line 3200
;3199:					case 30:
;3200:						deathstring = "%s's presents go up in %s's EMP presence.\n";
ADDRLP4 0
ADDRGP4 $1910
ASGNP4
line 3201
;3201:						break;
ADDRGP4 $1903
JUMPV
LABELV $1911
line 3203
;3202:					case 35:
;3203:						G_bprint( 1, "%s goes POP!\n", targ->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $1912
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 3204
;3204:						return;
ADDRGP4 $1720
JUMPV
LABELV $1913
line 3206
;3205:					case 31:
;3206:						deathstring = "%s stands to near %s's birthday surprise\n";
ADDRLP4 0
ADDRGP4 $1914
ASGNP4
line 3207
;3207:						break;
ADDRGP4 $1903
JUMPV
LABELV $1915
line 3209
;3208:					case 12:
;3209:						deathstring = "%s eats %s's good cheer!\n";
ADDRLP4 0
ADDRGP4 $1916
ASGNP4
line 3210
;3210:						if ( g_random() < 0.1 )
ADDRLP4 68
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 68
INDIRF4
CNSTF4 1036831949
GEF4 $1903
line 3211
;3211:							G_bprint( 1, "Damn that jokey smurf!\n" );
CNSTI4 1
ARGI4
ADDRGP4 $1919
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 3212
;3212:						break;
ADDRGP4 $1903
JUMPV
LABELV $1920
line 3214
;3213:					case 16:
;3214:						deathstring = "%s cut the red ribbon of %s's detpack\n";
ADDRLP4 0
ADDRGP4 $1921
ASGNP4
line 3215
;3215:						break;
ADDRGP4 $1903
JUMPV
LABELV $1922
line 3217
;3216:					case 5:
;3217:						deathstring = "%s recieves a gift from %s\n";
ADDRLP4 0
ADDRGP4 $1923
ASGNP4
line 3218
;3218:						if ( targ->s.v.health < -40 )
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 3256877056
GEF4 $1903
line 3219
;3219:							deathstring = "%s plays pass-the-parcel with %s\n";
ADDRLP4 0
ADDRGP4 $1926
ASGNP4
line 3220
;3220:						break;
ADDRGP4 $1903
JUMPV
LABELV $1927
line 3222
;3221:					case 6:
;3222:						deathstring = "%s rides %s's firecracker\n";
ADDRLP4 0
ADDRGP4 $1928
ASGNP4
line 3223
;3223:						if ( targ->s.v.health < -40 )
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 3256877056
GEF4 $1903
line 3224
;3224:						{
line 3225
;3225:							G_bprint( 1,
CNSTI4 1
ARGI4
ADDRGP4 $1931
ARGP4
ADDRLP4 72
CNSTI4 396
ASGNI4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 3229
;3226:								  "%s gets turned into little %s's by %s's firecracker",
;3227:								  targ->s.v.netname, targ->s.v.netname,
;3228:								  attacker->s.v.netname );
;3229:							return;
ADDRGP4 $1720
JUMPV
line 3231
;3230:						}
;3231:						break;
LABELV $1932
line 3233
;3232:					case 15:
;3233:						if ( ( int ) ( g_random() * 2 ) )
ADDRLP4 72
ADDRGP4 g_random
CALLF4
ASGNF4
CNSTF4 1073741824
ADDRLP4 72
INDIRF4
MULF4
CVFI4 4
CNSTI4 0
EQI4 $1933
line 3234
;3234:							deathstring = "%s gets too close to %s's kitchen\n";
ADDRLP4 0
ADDRGP4 $1935
ASGNP4
ADDRGP4 $1903
JUMPV
LABELV $1933
line 3236
;3235:						else
;3236:							deathstring = "%s plays with %s's fire\n";
ADDRLP4 0
ADDRGP4 $1936
ASGNP4
line 3237
;3237:						break;
ADDRGP4 $1903
JUMPV
LABELV $1937
line 3239
;3238:					case 18:
;3239:						if ( ( int ) ( g_random() * 3 ) )
ADDRLP4 76
ADDRGP4 g_random
CALLF4
ASGNF4
CNSTF4 1077936128
ADDRLP4 76
INDIRF4
MULF4
CVFI4 4
CNSTI4 0
EQI4 $1938
line 3240
;3240:							deathstring = "%s blocks %s's birthday bullet with his chest\n";
ADDRLP4 0
ADDRGP4 $1940
ASGNP4
ADDRGP4 $1903
JUMPV
LABELV $1938
line 3242
;3241:						else
;3242:							deathstring = "%s gets party popped by %s\n";
ADDRLP4 0
ADDRGP4 $1941
ASGNP4
line 3243
;3243:						break;
ADDRGP4 $1903
JUMPV
LABELV $1942
line 3245
;3244:					case 29:
;3245:						if ( ( int ) ( g_random() * 2 ) )
ADDRLP4 80
ADDRGP4 g_random
CALLF4
ASGNF4
CNSTF4 1073741824
ADDRLP4 80
INDIRF4
MULF4
CVFI4 4
CNSTI4 0
EQI4 $1943
line 3246
;3246:							deathstring =
ADDRLP4 0
ADDRGP4 $1945
ASGNP4
ADDRGP4 $1903
JUMPV
LABELV $1943
line 3249
;3247:							    "%s ALMOST catches %s's bullet between his teeth!\n";
;3248:						else
;3249:							deathstring = "%s loves snipers like %s\n";
ADDRLP4 0
ADDRGP4 $1946
ASGNP4
line 3250
;3250:						break;
ADDRGP4 $1903
JUMPV
LABELV $1947
line 3252
;3251:					case 28:
;3252:						deathstring = "%s won't run crying to %s anymore\n";
ADDRLP4 0
ADDRGP4 $1948
ASGNP4
line 3253
;3253:						break;
ADDRGP4 $1903
JUMPV
LABELV $1949
line 3255
;3254:					case 19:
;3255:						deathstring = "%s collects %s's highspeed gifts.\n";
ADDRLP4 0
ADDRGP4 $1950
ASGNP4
line 3256
;3256:						break;
ADDRGP4 $1903
JUMPV
LABELV $1951
line 3258
;3257:					case 20:
;3258:						deathstring = "%s died. I blame %s\n";
ADDRLP4 0
ADDRGP4 $1952
ASGNP4
line 3259
;3259:						break;
ADDRGP4 $1903
JUMPV
LABELV $1953
line 3261
;3260:					case 22:
;3261:						deathstring = "%s gets a gift in the back from %s\n";
ADDRLP4 0
ADDRGP4 $1954
ASGNP4
line 3262
;3262:						break;
ADDRGP4 $1903
JUMPV
LABELV $1955
line 3264
;3263:					case 2:
;3264:						deathstring = "%s gets a double of %s's buck\n";
ADDRLP4 0
ADDRGP4 $1956
ASGNP4
line 3265
;3265:						break;
ADDRGP4 $1903
JUMPV
LABELV $1957
line 3267
;3266:					case 25:
;3267:						deathstring = "%s is all partied out by %s\n";
ADDRLP4 0
ADDRGP4 $1958
ASGNP4
line 3268
;3268:						break;
ADDRGP4 $1903
JUMPV
LABELV $1959
line 3270
;3269:					case 26:
;3270:						deathstring = "%s gets derailed by %s\n";
ADDRLP4 0
ADDRGP4 $1960
ASGNP4
line 3271
;3271:						break;
ADDRGP4 $1903
JUMPV
LABELV $1961
line 3273
;3272:					case 3:
;3273:						deathstring = "%s gets no say in it, no say in it at all! sings %s\n";
ADDRLP4 0
ADDRGP4 $1962
ASGNP4
line 3274
;3274:						break;
ADDRGP4 $1903
JUMPV
LABELV $1963
line 3276
;3275:					case 33:
;3276:						deathstring = "%s gets all fired up by %s\n";
ADDRLP4 0
ADDRGP4 $1964
ASGNP4
line 3277
;3277:						break;
ADDRGP4 $1903
JUMPV
LABELV $1902
line 3279
;3278:					default:	//death msg 8??? 
;3279:						if ( ( int ) ( g_random() * 2 ) )
ADDRLP4 84
ADDRGP4 g_random
CALLF4
ASGNF4
CNSTF4 1073741824
ADDRLP4 84
INDIRF4
MULF4
CVFI4 4
CNSTI4 0
EQI4 $1965
line 3280
;3280:							deathstring = "%s recieves a gift from %s\n";
ADDRLP4 0
ADDRGP4 $1923
ASGNP4
ADDRGP4 $1903
JUMPV
LABELV $1965
line 3282
;3281:						else
;3282:							deathstring = "%s has a happy birthday, thanks to %s\n";
ADDRLP4 0
ADDRGP4 $1967
ASGNP4
line 3283
;3283:						break;
LABELV $1903
line 3286
;3284:
;3285:					}
;3286:					G_bprint( 1, deathstring, targ->s.v.netname, attacker->s.v.netname );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 68
CNSTI4 396
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 3287
;3287:					return;
ADDRGP4 $1720
JUMPV
LABELV $1899
line 3290
;3288:				}	//end of player vs player Birthday messages
;3289://normal player vs player messages
;3290:				switch ( tf_data.deathmsg )
ADDRLP4 60
ADDRGP4 tf_data+88
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 1
LTI4 $1970
ADDRLP4 60
INDIRI4
CNSTI4 41
GTI4 $1970
ADDRLP4 60
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2159-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2159
address $2071
address $2090
address $2107
address $2119
address $2025
address $2030
address $2121
address $1973
address $1996
address $1998
address $2003
address $2017
address $2021
address $2023
address $2035
address $2019
address $2049
address $2128
address $2143
address $2145
address $2126
address $2147
address $1970
address $2007
address $2149
address $2151
address $1970
address $2138
address $2133
address $2009
address $2015
address $2069
address $2153
address $1970
address $2013
address $1970
address $1970
address $2155
address $2157
address $2005
address $2011
code
line 3291
;3291:				{
LABELV $1973
line 3293
;3292:				case 8:
;3293:					switch ( attacker->playerclass )
ADDRLP4 64
ADDRFP4 4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
ADDRLP4 72
CNSTI4 2
ASGNI4
ADDRLP4 64
INDIRI4
ADDRLP4 72
INDIRI4
LTI4 $1974
ADDRLP4 64
INDIRI4
CNSTI4 9
GTI4 $1974
ADDRLP4 64
INDIRI4
ADDRLP4 72
INDIRI4
LSHI4
ADDRGP4 $1994-8
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1994
address $1977
address $1979
address $1981
address $1983
address $1985
address $1987
address $1989
address $1991
code
line 3294
;3294:					{
LABELV $1977
line 3296
;3295:					case 2:
;3296:						deathstring = "%s got up-close and personal with %s's grenade\n";
ADDRLP4 0
ADDRGP4 $1978
ASGNP4
line 3297
;3297:						break;
ADDRGP4 $1971
JUMPV
LABELV $1979
line 3299
;3298:					case 3:
;3299:						deathstring = "%s played catch with %s's grenade\n";
ADDRLP4 0
ADDRGP4 $1980
ASGNP4
line 3300
;3300:						break;
ADDRGP4 $1971
JUMPV
LABELV $1981
line 3302
;3301:					case 4:
;3302:						deathstring = "%s received a pineapple enema from %s\n";
ADDRLP4 0
ADDRGP4 $1982
ASGNP4
line 3303
;3303:						break;
ADDRGP4 $1971
JUMPV
LABELV $1983
line 3305
;3304:					case 5:
;3305:						deathstring = "%s fetched %s's pineapple\n";
ADDRLP4 0
ADDRGP4 $1984
ASGNP4
line 3306
;3306:						break;
ADDRGP4 $1971
JUMPV
LABELV $1985
line 3308
;3307:					case 6:
;3308:						deathstring = "%s caught too much shrapnel from %s's grenade\n";
ADDRLP4 0
ADDRGP4 $1986
ASGNP4
line 3309
;3309:						break;
ADDRGP4 $1971
JUMPV
LABELV $1987
line 3311
;3310:					case 7:
;3311:						deathstring = "%s tried to pick up %s's hot potato\n";
ADDRLP4 0
ADDRGP4 $1988
ASGNP4
line 3312
;3312:						break;
ADDRGP4 $1971
JUMPV
LABELV $1989
line 3314
;3313:					case 8:
;3314:						deathstring = "%s thought %s was tossing him a spare grenade\n";
ADDRLP4 0
ADDRGP4 $1990
ASGNP4
line 3315
;3315:						break;
ADDRGP4 $1971
JUMPV
LABELV $1991
line 3317
;3316:					case 9:
;3317:						deathstring =
ADDRLP4 0
ADDRGP4 $1992
ASGNP4
line 3319
;3318:						    "%s stops to ponder the technical details of %s's grenade\n";
;3319:						break;
ADDRGP4 $1971
JUMPV
LABELV $1974
line 3321
;3320:					default:
;3321:						deathstring = "%s surfs on a grenade from %s\n";
ADDRLP4 0
ADDRGP4 $1993
ASGNP4
line 3322
;3322:						break;
line 3324
;3323:					}
;3324:					break;
ADDRGP4 $1971
JUMPV
LABELV $1996
line 3326
;3325:				case 9:
;3326:					deathstring = "%s gets flayed by %s's nail grenade\n";
ADDRLP4 0
ADDRGP4 $1997
ASGNP4
line 3327
;3327:					break;
ADDRGP4 $1971
JUMPV
LABELV $1998
line 3329
;3328:				case 10:
;3329:					if ( attacker->playerclass == 4 )
ADDRFP4 4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1999
line 3330
;3330:						deathstring = "%s does a dance on %s's Mirv grenade\n";
ADDRLP4 0
ADDRGP4 $2001
ASGNP4
ADDRGP4 $1971
JUMPV
LABELV $1999
line 3332
;3331:					else
;3332:						deathstring = "%s gets spammed by %s's Mirv grenade\n";
ADDRLP4 0
ADDRGP4 $2002
ASGNP4
line 3333
;3333:					break;
ADDRGP4 $1971
JUMPV
LABELV $2003
line 3335
;3334:				case 11:
;3335:					deathstring = "%s is caught by %s's pipebomb trap\n";
ADDRLP4 0
ADDRGP4 $2004
ASGNP4
line 3336
;3336:					break;
ADDRGP4 $1971
JUMPV
LABELV $2005
line 3338
;3337:				case 40:
;3338:					deathstring = "%s fell victim to %s's fireworks\n";
ADDRLP4 0
ADDRGP4 $2006
ASGNP4
line 3339
;3339:					break;
ADDRGP4 $1971
JUMPV
LABELV $2007
line 3341
;3340:				case 24:
;3341:					deathstring = "%s gags on %s's noxious gasses\n";
ADDRLP4 0
ADDRGP4 $2008
ASGNP4
line 3342
;3342:					break;
ADDRGP4 $1971
JUMPV
LABELV $2009
line 3344
;3343:				case 30:
;3344:					deathstring = "%s's ammo detonates him as %s's EMP fries it\n";
ADDRLP4 0
ADDRGP4 $2010
ASGNP4
line 3345
;3345:					break;
ADDRGP4 $1971
JUMPV
LABELV $2011
line 3347
;3346:				case 41:
;3347:					deathstring = "%s stepped on too many of %s's caltrops\n";
ADDRLP4 0
ADDRGP4 $2012
ASGNP4
line 3348
;3348:					break;
ADDRGP4 $1971
JUMPV
LABELV $2013
line 3350
;3349:				case 35:
;3350:					deathstring = "%s is charred by %s's flash grenade\n";
ADDRLP4 0
ADDRGP4 $2014
ASGNP4
line 3351
;3351:					break;
ADDRGP4 $1971
JUMPV
LABELV $2015
line 3353
;3352:				case 31:
;3353:					deathstring = "%s stands near some ammo as %s's EMP nukes it\n";
ADDRLP4 0
ADDRGP4 $2016
ASGNP4
line 3354
;3354:					break;
ADDRGP4 $1971
JUMPV
LABELV $2017
line 3356
;3355:				case 12:
;3356:					deathstring = "%s reaches orbit via %s's detpack\n";
ADDRLP4 0
ADDRGP4 $2018
ASGNP4
line 3357
;3357:					break;
ADDRGP4 $1971
JUMPV
LABELV $2019
line 3359
;3358:				case 16:
;3359:					deathstring = "%s cut the red wire of %s's detpack\n";
ADDRLP4 0
ADDRGP4 $2020
ASGNP4
line 3360
;3360:					break;
ADDRGP4 $1971
JUMPV
LABELV $2021
line 3362
;3361:				case 13:
;3362:					deathstring = "%s dies from %s's mysterious tropical disease\n";
ADDRLP4 0
ADDRGP4 $2022
ASGNP4
line 3363
;3363:					break;
ADDRGP4 $1971
JUMPV
LABELV $2023
line 3365
;3364:				case 14:
;3365:					deathstring = "%s escapes infection from %s by dying first\n";
ADDRLP4 0
ADDRGP4 $2024
ASGNP4
line 3366
;3366:					break;
ADDRGP4 $1971
JUMPV
LABELV $2025
line 3368
;3367:				case 5:
;3368:					deathstring = "%s eats %s's pineapple\n";
ADDRLP4 0
ADDRGP4 $2026
ASGNP4
line 3369
;3369:					if ( targ->s.v.health < -40 )
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 3256877056
GEF4 $1971
line 3370
;3370:						deathstring = "%s was gibbed by %s's grenade\n";
ADDRLP4 0
ADDRGP4 $2029
ASGNP4
line 3371
;3371:					break;
ADDRGP4 $1971
JUMPV
LABELV $2030
line 3373
;3372:				case 6:
;3373:					deathstring = "%s rides %s's rocket\n";
ADDRLP4 0
ADDRGP4 $2031
ASGNP4
line 3374
;3374:					if ( targ->s.v.health < -40 )
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 3256877056
GEF4 $1971
line 3375
;3375:						deathstring = "%s was gibbed by %s's rocket\n";
ADDRLP4 0
ADDRGP4 $2034
ASGNP4
line 3376
;3376:					break;
ADDRGP4 $1971
JUMPV
LABELV $2035
line 3378
;3377:				case 15:
;3378:					switch ( ( int ) ( rnum * 5 ) )
ADDRLP4 76
CNSTF4 1084227584
ADDRLP4 4
INDIRF4
MULF4
CVFI4 4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
LTI4 $2036
ADDRLP4 76
INDIRI4
CNSTI4 3
GTI4 $2036
ADDRLP4 76
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2048
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2048
address $2039
address $2041
address $2043
address $2045
code
line 3379
;3379:					{
LABELV $2039
line 3381
;3380:					case 0:
;3381:						deathstring = "%s is burnt up by %s's flame\n";
ADDRLP4 0
ADDRGP4 $2040
ASGNP4
line 3382
;3382:						break;
ADDRGP4 $1971
JUMPV
LABELV $2041
line 3384
;3383:					case 1:
;3384:						deathstring = "%s is fried by %s's fire\n";
ADDRLP4 0
ADDRGP4 $2042
ASGNP4
line 3385
;3385:						break;
ADDRGP4 $1971
JUMPV
LABELV $2043
line 3387
;3386:					case 2:
;3387:						deathstring = "%s feels %s's fire of wrath\n";
ADDRLP4 0
ADDRGP4 $2044
ASGNP4
line 3388
;3388:						break;
ADDRGP4 $1971
JUMPV
LABELV $2045
line 3390
;3389:					case 3:
;3390:						deathstring = "%s is reduced to ashes by %s\n";
ADDRLP4 0
ADDRGP4 $2046
ASGNP4
line 3391
;3391:						break;
ADDRGP4 $1971
JUMPV
LABELV $2036
line 3393
;3392:					default:
;3393:						deathstring = "%s is grilled by %s's flame\n";
ADDRLP4 0
ADDRGP4 $2047
ASGNP4
line 3394
;3394:						break;
line 3396
;3395:					}
;3396:					break;
ADDRGP4 $1971
JUMPV
LABELV $2049
line 3398
;3397:				case 17:
;3398:					switch ( attacker->playerclass )
ADDRLP4 84
ADDRFP4 4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 1
LTI4 $2050
ADDRLP4 84
INDIRI4
CNSTI4 8
GTI4 $2050
ADDRLP4 84
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2067-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2067
address $2055
address $2057
address $2059
address $2061
address $2050
address $2063
address $2065
address $2053
code
line 3399
;3399:					{
LABELV $2053
line 3401
;3400:					case 8:
;3401:						deathstring = "%s was knife-murdered by %s\n";
ADDRLP4 0
ADDRGP4 $2054
ASGNP4
line 3402
;3402:						break;
ADDRGP4 $1971
JUMPV
LABELV $2055
line 3404
;3403:					case 1:
;3404:						deathstring = "%s's mellon was split by %s\n";
ADDRLP4 0
ADDRGP4 $2056
ASGNP4
line 3405
;3405:						break;
ADDRGP4 $1971
JUMPV
LABELV $2057
line 3407
;3406:					case 2:
;3407:						deathstring = "%s was put on the chop block by %s\n";
ADDRLP4 0
ADDRGP4 $2058
ASGNP4
line 3408
;3408:						break;
ADDRGP4 $1971
JUMPV
LABELV $2059
line 3410
;3409:					case 3:
;3410:						deathstring = "%s was sliced and diced by %s's blade\n";
ADDRLP4 0
ADDRGP4 $2060
ASGNP4
line 3411
;3411:						break;
ADDRGP4 $1971
JUMPV
LABELV $2061
line 3413
;3412:					case 4:
;3413:						deathstring = "%s is split from crotch to sternum by %s's axe swing\n";
ADDRLP4 0
ADDRGP4 $2062
ASGNP4
line 3414
;3414:						break;
ADDRGP4 $1971
JUMPV
LABELV $2063
line 3416
;3415:					case 6:
;3416:						deathstring = "%s is split in two with a powerful axe blow from %s\n";
ADDRLP4 0
ADDRGP4 $2064
ASGNP4
line 3417
;3417:						break;
ADDRGP4 $1971
JUMPV
LABELV $2065
line 3419
;3418:					case 7:
;3419:						deathstring = "%s's death put another notch on %s's axe\n";
ADDRLP4 0
ADDRGP4 $2066
ASGNP4
line 3420
;3420:						break;
ADDRGP4 $1971
JUMPV
LABELV $2050
line 3422
;3421:					default:
;3422:						deathstring = "%s's death put another notch on %s's axe\n";
ADDRLP4 0
ADDRGP4 $2066
ASGNP4
line 3423
;3423:						break;
line 3425
;3424:					}
;3425:					break;
ADDRGP4 $1971
JUMPV
LABELV $2069
line 3428
;3426:
;3427:				case 32:
;3428:					deathstring = "%s was spanner-murdered by %s\n";
ADDRLP4 0
ADDRGP4 $2070
ASGNP4
line 3429
;3429:					break;
ADDRGP4 $1971
JUMPV
LABELV $2071
line 3431
;3430:				case 1:
;3431:					switch ( attacker->playerclass )
ADDRLP4 92
ADDRFP4 4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 1
LTI4 $2072
ADDRLP4 92
INDIRI4
CNSTI4 7
GTI4 $2072
ADDRLP4 92
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2088-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2088
address $2075
address $2072
address $2077
address $2079
address $2081
address $2083
address $2085
code
line 3432
;3432:					{
LABELV $2075
line 3434
;3433:					case 1:
;3434:						deathstring = "%s got too close to %s's muzzleflash\n";
ADDRLP4 0
ADDRGP4 $2076
ASGNP4
line 3435
;3435:						break;
ADDRGP4 $1971
JUMPV
LABELV $2077
line 3437
;3436:					case 3:
;3437:						deathstring = "%s practices being %s's clay pigeon\n";
ADDRLP4 0
ADDRGP4 $2078
ASGNP4
line 3438
;3438:						break;
ADDRGP4 $1971
JUMPV
LABELV $2079
line 3440
;3439:					case 4:
;3440:						deathstring = "%s was on the receiving end of %s's shotgun barrel\n";
ADDRLP4 0
ADDRGP4 $2080
ASGNP4
line 3441
;3441:						break;
ADDRGP4 $1971
JUMPV
LABELV $2081
line 3443
;3442:					case 5:
;3443:						deathstring = "%s was fed a lead diet by %s\n";
ADDRLP4 0
ADDRGP4 $2082
ASGNP4
line 3444
;3444:						break;
ADDRGP4 $1971
JUMPV
LABELV $2083
line 3446
;3445:					case 6:
;3446:						deathstring = "%s got blasted by %s's last resort\n";
ADDRLP4 0
ADDRGP4 $2084
ASGNP4
line 3447
;3447:						break;
ADDRGP4 $1971
JUMPV
LABELV $2085
line 3449
;3448:					case 7:
;3449:						deathstring = "%s got more than a powderburn from %s's shotgun blast\n";
ADDRLP4 0
ADDRGP4 $2086
ASGNP4
line 3450
;3450:						break;
ADDRGP4 $1971
JUMPV
LABELV $2072
line 3452
;3451:					default:
;3452:						deathstring = "%s chewed on %s's boomstick\n";
ADDRLP4 0
ADDRGP4 $2087
ASGNP4
line 3453
;3453:						break;
line 3455
;3454:					}
;3455:					break;
ADDRGP4 $1971
JUMPV
LABELV $2090
line 3457
;3456:				case 2:
;3457:					switch ( attacker->playerclass )
ADDRLP4 100
ADDRFP4 4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 3
LTI4 $2091
ADDRLP4 100
INDIRI4
CNSTI4 9
GTI4 $2091
ADDRLP4 100
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2105-12
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2105
address $2094
address $2091
address $2096
address $2098
address $2091
address $2100
address $2102
code
line 3458
;3458:					{
LABELV $2094
line 3461
;3459:
;3460:					case 3:
;3461:						deathstring = "%s was turned into swiss cheese by %s's buckshot\n";
ADDRLP4 0
ADDRGP4 $2095
ASGNP4
line 3462
;3462:						break;
ADDRGP4 $1971
JUMPV
LABELV $2096
line 3464
;3463:					case 5:
;3464:						deathstring = "%s got a double-dose of %s's buckshot\n";
ADDRLP4 0
ADDRGP4 $2097
ASGNP4
line 3465
;3465:						break;
ADDRGP4 $1971
JUMPV
LABELV $2098
line 3467
;3466:					case 6:
;3467:						deathstring = "%s unfortunately forgot %s carried a super-shotgun\n";
ADDRLP4 0
ADDRGP4 $2099
ASGNP4
line 3468
;3468:						break;
ADDRGP4 $1971
JUMPV
LABELV $2100
line 3470
;3469:					case 8:
;3470:						deathstring = "%s gets ventilated by %s's super-shotgun blast\n";
ADDRLP4 0
ADDRGP4 $2101
ASGNP4
line 3471
;3471:						break;
ADDRGP4 $1971
JUMPV
LABELV $2102
line 3473
;3472:					case 9:
;3473:						deathstring = "%s's body got chuck full of %s's lead pellets\n";
ADDRLP4 0
ADDRGP4 $2103
ASGNP4
line 3474
;3474:						break;
ADDRGP4 $1971
JUMPV
LABELV $2091
line 3476
;3475:					default:
;3476:						deathstring = "%s ate 2 loads of %s's buckshot\n";
ADDRLP4 0
ADDRGP4 $2104
ASGNP4
line 3477
;3477:						break;
line 3479
;3478:					}
;3479:					break;
ADDRGP4 $1971
JUMPV
LABELV $2107
line 3481
;3480:				case 3:
;3481:					switch ( attacker->playerclass )
ADDRLP4 108
ADDRFP4 4
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ASGNI4
ADDRLP4 116
CNSTI4 1
ASGNI4
ADDRLP4 108
INDIRI4
ADDRLP4 116
INDIRI4
EQI4 $2111
ADDRLP4 108
INDIRI4
CNSTI4 2
EQI4 $2113
ADDRLP4 108
INDIRI4
ADDRLP4 116
INDIRI4
LTI4 $2108
LABELV $2118
ADDRLP4 108
INDIRI4
CNSTI4 8
EQI4 $2115
ADDRGP4 $2108
JUMPV
line 3482
;3482:					{
LABELV $2111
line 3484
;3483:					case 1:
;3484:						deathstring = "%s caught one too many nails from %s\n";
ADDRLP4 0
ADDRGP4 $2112
ASGNP4
line 3485
;3485:						break;
ADDRGP4 $1971
JUMPV
LABELV $2113
line 3487
;3486:					case 2:
;3487:						deathstring = "%s ran into %s's nails\n";
ADDRLP4 0
ADDRGP4 $2114
ASGNP4
line 3488
;3488:						break;
ADDRGP4 $1971
JUMPV
LABELV $2115
line 3490
;3489:					case 8:
;3490:						deathstring = "%s was turned into %s's pin-cushion\n";
ADDRLP4 0
ADDRGP4 $2116
ASGNP4
line 3491
;3491:						break;
ADDRGP4 $1971
JUMPV
LABELV $2108
line 3493
;3492:					default:
;3493:						deathstring = "%s was nailed by %s\n";
ADDRLP4 0
ADDRGP4 $2117
ASGNP4
line 3494
;3494:						break;
line 3496
;3495:					}
;3496:					break;
ADDRGP4 $1971
JUMPV
LABELV $2119
line 3498
;3497:				case 4:
;3498:					deathstring = "%s was punctured by %s\n";
ADDRLP4 0
ADDRGP4 $2120
ASGNP4
line 3499
;3499:					break;
ADDRGP4 $1971
JUMPV
LABELV $2121
line 3501
;3500:				case 7:
;3501:					if ( attacker->s.v.waterlevel > 1 )
ADDRFP4 4
INDIRP4
CNSTI4 432
ADDP4
INDIRF4
CNSTF4 1065353216
LEF4 $2122
line 3502
;3502:						deathstring = "%s accepts %s's discharge\n";
ADDRLP4 0
ADDRGP4 $2124
ASGNP4
ADDRGP4 $1971
JUMPV
LABELV $2122
line 3504
;3503:					else
;3504:						deathstring = "%s accepts %s's shaft\n";
ADDRLP4 0
ADDRGP4 $2125
ASGNP4
line 3505
;3505:					break;
ADDRGP4 $1971
JUMPV
LABELV $2126
line 3507
;3506:				case 21:
;3507:					deathstring = "%s grappled with %s\n";
ADDRLP4 0
ADDRGP4 $2127
ASGNP4
line 3508
;3508:					break;
ADDRGP4 $1971
JUMPV
LABELV $2128
line 3510
;3509:				case 18:
;3510:					if ( rnum <= 0.3 )
ADDRLP4 4
INDIRF4
CNSTF4 1050253722
GTF4 $2129
line 3511
;3511:					{
line 3512
;3512:						deathstring = "%s takes a bullet in the chest from %s\n";
ADDRLP4 0
ADDRGP4 $2131
ASGNP4
line 3513
;3513:					} else
ADDRGP4 $1971
JUMPV
LABELV $2129
line 3514
;3514:					{
line 3515
;3515:						deathstring = "%s succumbs to sniperfire from %s\n";
ADDRLP4 0
ADDRGP4 $2132
ASGNP4
line 3516
;3516:					}
line 3517
;3517:					break;
ADDRGP4 $1971
JUMPV
LABELV $2133
line 3519
;3518:				case 29:
;3519:					if ( rnum <= 0.5 )
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
GTF4 $2134
line 3520
;3520:					{
line 3521
;3521:						deathstring = "%s gets a third eye from %s\n";
ADDRLP4 0
ADDRGP4 $2136
ASGNP4
line 3522
;3522:					} else
ADDRGP4 $1971
JUMPV
LABELV $2134
line 3523
;3523:					{
line 3524
;3524:						deathstring = "%s gets his head blown off by %s\n";
ADDRLP4 0
ADDRGP4 $2137
ASGNP4
line 3525
;3525:					}
line 3526
;3526:					break;
ADDRGP4 $1971
JUMPV
LABELV $2138
line 3528
;3527:				case 28:
;3528:					if ( rnum <= 0.5 )
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
GTF4 $2139
line 3529
;3529:					{
line 3530
;3530:						deathstring = "%s is made legless by %s\n";
ADDRLP4 0
ADDRGP4 $2141
ASGNP4
line 3531
;3531:					} else
ADDRGP4 $1971
JUMPV
LABELV $2139
line 3532
;3532:					{
line 3533
;3533:						deathstring = "%s gets his legs blown off by %s\n";
ADDRLP4 0
ADDRGP4 $2142
ASGNP4
line 3534
;3534:					}
line 3535
;3535:					break;
ADDRGP4 $1971
JUMPV
LABELV $2143
line 3537
;3536:				case 19:
;3537:					deathstring = "%s collects %s's bullet spray.\n";
ADDRLP4 0
ADDRGP4 $2144
ASGNP4
line 3538
;3538:					break;
ADDRGP4 $1971
JUMPV
LABELV $2145
line 3540
;3539:				case 20:
;3540:					deathstring = "%s gets sawn in half by %s\n";
ADDRLP4 0
ADDRGP4 $2146
ASGNP4
line 3541
;3541:					break;
ADDRGP4 $1971
JUMPV
LABELV $2147
line 3543
;3542:				case 22:
;3543:					deathstring = "%s gets knifed from behind by %s\n";
ADDRLP4 0
ADDRGP4 $2148
ASGNP4
line 3544
;3544:					break;
ADDRGP4 $1971
JUMPV
LABELV $2149
line 3546
;3545:				case 25:
;3546:					deathstring = "%s is put to sleep by %s\n";
ADDRLP4 0
ADDRGP4 $2150
ASGNP4
line 3547
;3547:					break;
ADDRGP4 $1971
JUMPV
LABELV $2151
line 3549
;3548:				case 26:
;3549:					deathstring = "%s gets a hole in his heart from %s's railgun\n";
ADDRLP4 0
ADDRGP4 $2152
ASGNP4
line 3550
;3550:					break;
ADDRGP4 $1971
JUMPV
LABELV $2153
line 3552
;3551:				case 33:
;3552:					deathstring = "%s gets well done by %s's incendiary rocket\n";
ADDRLP4 0
ADDRGP4 $2154
ASGNP4
line 3553
;3553:					break;
ADDRGP4 $1971
JUMPV
LABELV $2155
line 3555
;3554:				case 38:
;3555:					deathstring = "%s gets destroyed by %s's exploding sentrygun\n";
ADDRLP4 0
ADDRGP4 $2156
ASGNP4
line 3556
;3556:					break;
ADDRGP4 $1971
JUMPV
LABELV $2157
line 3558
;3557:				case 39:
;3558:					deathstring = "%s didn't insert the correct change into %s's dispenser.\n";
ADDRLP4 0
ADDRGP4 $2158
ASGNP4
line 3559
;3559:					break;
LABELV $1970
LABELV $1971
line 3562
;3560:
;3561:				}
;3562:				G_bprint( 1, deathstring, targ->s.v.netname, attacker->s.v.netname );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 64
CNSTI4 396
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 3563
;3563:			}
line 3564
;3564:		}
line 3565
;3565:		return;
ADDRGP4 $1720
JUMPV
LABELV $1782
line 3568
;3566:	}			//end of player vs player
;3567:	else
;3568:	{
line 3569
;3569:		if ( streq( attacker->s.v.classname, "building_sentrygun" ) )
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $1735
ARGP4
ADDRLP4 44
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $2161
line 3570
;3570:		{
line 3571
;3571:			if ( targ == attacker->real_owner )
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CVPU4 4
NEU4 $2163
line 3572
;3572:			{
line 3573
;3573:				if ( tf_data.deathmsg == DMSG_SENTRYGUN_ROCKET )
ADDRGP4 tf_data+88
INDIRI4
CNSTI4 34
NEI4 $2165
line 3574
;3574:					deathstring = "%s intercepts his sentry gun's rocket\n";
ADDRLP4 0
ADDRGP4 $2168
ASGNP4
ADDRGP4 $2166
JUMPV
LABELV $2165
line 3576
;3575:				else
;3576:				{
line 3577
;3577:					if ( tf_data.deathmsg == DMSG_SENTRYGUN_BULLET )
ADDRGP4 tf_data+88
INDIRI4
CNSTI4 27
NEI4 $2169
line 3578
;3578:						deathstring = "%s crossed his sentry gun's line of fire\n";
ADDRLP4 0
ADDRGP4 $2172
ASGNP4
LABELV $2169
line 3579
;3579:				}
LABELV $2166
line 3580
;3580:				G_bprint( 1, deathstring, targ->s.v.netname );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 3581
;3581:			} else
ADDRGP4 $2162
JUMPV
LABELV $2163
line 3582
;3582:			{
line 3583
;3583:				if ( teamplay && attacker->team_no == targ->team_no && attacker->team_no > 0 )
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRGP4 teamplay
INDIRI4
ADDRLP4 48
INDIRI4
EQI4 $2173
ADDRLP4 52
CNSTI4 960
ASGNI4
ADDRLP4 56
ADDRFP4 4
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 56
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
NEI4 $2173
ADDRLP4 56
INDIRI4
ADDRLP4 48
INDIRI4
LEI4 $2173
line 3584
;3584:				{
line 3585
;3585:					G_bprint( 1, "%s obstructs his team's sentry gun\n", targ->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $2175
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 3586
;3586:				} else
ADDRGP4 $2162
JUMPV
LABELV $2173
line 3587
;3587:				{
line 3588
;3588:					TF_AddFrags( attacker->real_owner, 1 );
ADDRFP4 4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
line 3589
;3589:					logfrag( attacker->real_owner, targ );
ADDRFP4 4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 logfrag
CALLV
pop
line 3590
;3590:					if ( tf_data.deathmsg == DMSG_SENTRYGUN_ROCKET )
ADDRGP4 tf_data+88
INDIRI4
CNSTI4 34
NEI4 $2176
line 3591
;3591:					{
line 3592
;3592:						deathstring = "%s hates %s's sentry gun\n";
ADDRLP4 0
ADDRGP4 $2179
ASGNP4
line 3593
;3593:					} else
ADDRGP4 $2177
JUMPV
LABELV $2176
line 3594
;3594:					{
line 3595
;3595:						if ( tf_data.deathmsg == DMSG_SENTRYGUN_BULLET )
ADDRGP4 tf_data+88
INDIRI4
CNSTI4 27
NEI4 $2180
line 3596
;3596:						{
line 3597
;3597:							deathstring = "%s is mown down by %s's sentry gun\n";
ADDRLP4 0
ADDRGP4 $2183
ASGNP4
line 3598
;3598:						}
LABELV $2180
line 3599
;3599:					}
LABELV $2177
line 3600
;3600:					G_bprint( 1, deathstring, targ->s.v.netname,
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 60
CNSTI4 396
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 3602
;3601:						  attacker->real_owner->s.v.netname );
;3602:				}
line 3603
;3603:			}
line 3604
;3604:		} else
ADDRGP4 $2162
JUMPV
LABELV $2161
line 3605
;3605:		{
line 3606
;3606:			logfrag( targ, targ );
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 logfrag
CALLV
pop
line 3607
;3607:			TF_AddFrags( targ, -1 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 TF_AddFrags
CALLV
pop
line 3608
;3608:			rnum = targ->s.v.watertype;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ASGNF4
line 3609
;3609:			switch ( ( int ) targ->s.v.watertype )
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 -5
EQI4 $2204
ADDRLP4 52
INDIRI4
CNSTI4 -4
EQI4 $2199
ADDRLP4 52
INDIRI4
CNSTI4 -3
EQI4 $2187
ADDRGP4 $2184
JUMPV
line 3610
;3610:			{
LABELV $2187
line 3612
;3611:			case -3:
;3612:				if ( tf_data.birthday == 1 )
ADDRGP4 tf_data+92
INDIRI4
CNSTI4 1
NEI4 $2188
line 3613
;3613:				{
line 3614
;3614:					if ( g_random() < 0.5 )
ADDRLP4 60
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 60
INDIRF4
CNSTF4 1056964608
GEF4 $2191
line 3615
;3615:						deathstring = "%s bobs for apples\n";
ADDRLP4 0
ADDRGP4 $2193
ASGNP4
ADDRGP4 $2185
JUMPV
LABELV $2191
line 3617
;3616:					else
;3617:						deathstring = "%s drowns in the punch\n";
ADDRLP4 0
ADDRGP4 $2194
ASGNP4
line 3618
;3618:				} else
ADDRGP4 $2185
JUMPV
LABELV $2188
line 3619
;3619:				{
line 3620
;3620:					if ( g_random() < 0.5 )
ADDRLP4 60
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 60
INDIRF4
CNSTF4 1056964608
GEF4 $2195
line 3621
;3621:						deathstring = "%s sleeps with the fishes\n";
ADDRLP4 0
ADDRGP4 $2197
ASGNP4
ADDRGP4 $2185
JUMPV
LABELV $2195
line 3623
;3622:					else
;3623:						deathstring = "%s sucks it down\n";
ADDRLP4 0
ADDRGP4 $2198
ASGNP4
line 3624
;3624:				}
line 3625
;3625:				break;
ADDRGP4 $2185
JUMPV
LABELV $2199
line 3627
;3626:			case -4:
;3627:				if ( g_random() < 0.5 )
ADDRLP4 60
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 60
INDIRF4
CNSTF4 1056964608
GEF4 $2200
line 3628
;3628:					deathstring = "%s gulped a load of slime\n";
ADDRLP4 0
ADDRGP4 $2202
ASGNP4
ADDRGP4 $2185
JUMPV
LABELV $2200
line 3630
;3629:				else
;3630:					deathstring = "%s can't exist on slime alone\n";
ADDRLP4 0
ADDRGP4 $2203
ASGNP4
line 3631
;3631:				break;
ADDRGP4 $2185
JUMPV
LABELV $2204
line 3633
;3632:			case -5:
;3633:				if ( targ->s.v.health < -15 )
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 3245342720
GEF4 $2205
line 3634
;3634:					deathstring = "%s burst into flames\n";
ADDRLP4 0
ADDRGP4 $2207
ASGNP4
ADDRGP4 $2185
JUMPV
LABELV $2205
line 3636
;3635:				else
;3636:				{
line 3637
;3637:					if ( g_random() < 0.5 )
ADDRLP4 64
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 64
INDIRF4
CNSTF4 1056964608
GEF4 $2208
line 3638
;3638:						deathstring = "%s turned into hot slag\n";
ADDRLP4 0
ADDRGP4 $2210
ASGNP4
ADDRGP4 $2185
JUMPV
LABELV $2208
line 3640
;3639:					else
;3640:						deathstring = "%s visits the Volcano God\n";
ADDRLP4 0
ADDRGP4 $2211
ASGNP4
line 3641
;3641:				}
line 3642
;3642:				break;
ADDRGP4 $2185
JUMPV
LABELV $2184
line 3644
;3643:			default:
;3644:				if ( streq( attacker->s.v.classname, "explo_box" ) )
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $2214
ARGP4
ADDRLP4 64
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $2212
line 3645
;3645:				{
line 3646
;3646:					deathstring = "%s blew up\n";
ADDRLP4 0
ADDRGP4 $2215
ASGNP4
line 3647
;3647:					break;
ADDRGP4 $2185
JUMPV
LABELV $2212
line 3649
;3648:				}
;3649:				if ( attacker->s.v.solid == 4 && attacker != world )
ADDRLP4 68
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 152
ADDP4
INDIRF4
CNSTF4 1082130432
NEF4 $2216
ADDRLP4 68
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
EQU4 $2216
line 3650
;3650:				{
line 3651
;3651:					deathstring = "%s was squished\n";
ADDRLP4 0
ADDRGP4 $2218
ASGNP4
line 3652
;3652:					break;
ADDRGP4 $2185
JUMPV
LABELV $2216
line 3654
;3653:				}
;3654:				if ( streq( targ->deathtype, "falling" ) )
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
ARGP4
ADDRGP4 $1415
ARGP4
ADDRLP4 72
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $2219
line 3655
;3655:				{
line 3656
;3656:					targ->deathtype = "";
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
ADDRGP4 $205
ASGNP4
line 3657
;3657:					deathstring = "%s fell to his death\n";
ADDRLP4 0
ADDRGP4 $2221
ASGNP4
line 3658
;3658:					break;
ADDRGP4 $2185
JUMPV
LABELV $2219
line 3660
;3659:				}
;3660:				if ( streq( attacker->s.v.classname, "trap_shooter" )
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $2224
ARGP4
ADDRLP4 76
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $2226
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $2225
ARGP4
ADDRLP4 80
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $2222
LABELV $2226
line 3662
;3661:				     || streq( attacker->s.v.classname, "trap_spikeshooter" ) )
;3662:				{
line 3663
;3663:					deathstring = "%s was spiked\n";
ADDRLP4 0
ADDRGP4 $2227
ASGNP4
line 3664
;3664:					break;
ADDRGP4 $2185
JUMPV
LABELV $2222
line 3666
;3665:				}
;3666:				if ( streq( attacker->s.v.classname, "fireball" ) )
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $2230
ARGP4
ADDRLP4 84
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $2228
line 3667
;3667:				{
line 3668
;3668:					deathstring = "%s ate a lavaball\n";
ADDRLP4 0
ADDRGP4 $2231
ASGNP4
line 3669
;3669:					break;
ADDRGP4 $2185
JUMPV
LABELV $2228
line 3671
;3670:				}
;3671:				if ( streq( attacker->s.v.classname, "trigger_changelevel" ) )
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $2234
ARGP4
ADDRLP4 88
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $2232
line 3672
;3672:					deathstring = "%s tried to leave\n";
ADDRLP4 0
ADDRGP4 $2235
ASGNP4
ADDRGP4 $2185
JUMPV
LABELV $2232
line 3674
;3673:				else
;3674:					deathstring = "%s died\n";
ADDRLP4 0
ADDRGP4 $2236
ASGNP4
line 3676
;3675:
;3676:				break;
LABELV $2185
line 3679
;3677:
;3678:			}
;3679:			G_bprint( 1, deathstring, targ->s.v.netname );
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 3680
;3680:		}
LABELV $2162
line 3681
;3681:	}
line 3682
;3682:}
LABELV $1720
endproc ClientObituary 120 20
import Mega_ClientObituary
bss
export lastspawn
align 4
LABELV lastspawn
skip 4
import UpdateServerinfoScores
import team_top_colors
export last_id
align 4
LABELV last_id
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
export modelindex_null
align 4
LABELV modelindex_null
skip 4
export modelindex_player
align 4
LABELV modelindex_player
skip 4
export modelindex_eyes
align 4
LABELV modelindex_eyes
skip 4
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
export rj
align 4
LABELV rj
skip 4
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
LABELV $2236
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $2235
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 118
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2234
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $2231
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $2230
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
LABELV $2227
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $2225
byte 1 116
byte 1 114
byte 1 97
byte 1 112
byte 1 95
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2224
byte 1 116
byte 1 114
byte 1 97
byte 1 112
byte 1 95
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2221
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 10
byte 1 0
align 1
LABELV $2218
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 113
byte 1 117
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $2215
byte 1 37
byte 1 115
byte 1 32
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 117
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $2214
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
LABELV $2211
byte 1 37
byte 1 115
byte 1 32
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 86
byte 1 111
byte 1 108
byte 1 99
byte 1 97
byte 1 110
byte 1 111
byte 1 32
byte 1 71
byte 1 111
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $2210
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 104
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $2207
byte 1 37
byte 1 115
byte 1 32
byte 1 98
byte 1 117
byte 1 114
byte 1 115
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2203
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 101
byte 1 120
byte 1 105
byte 1 115
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 115
byte 1 108
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 111
byte 1 110
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2202
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 117
byte 1 108
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 115
byte 1 108
byte 1 105
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2198
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 117
byte 1 99
byte 1 107
byte 1 115
byte 1 32
byte 1 105
byte 1 116
byte 1 32
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $2197
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 108
byte 1 101
byte 1 101
byte 1 112
byte 1 115
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
byte 1 102
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2194
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 119
byte 1 110
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 112
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 10
byte 1 0
align 1
LABELV $2193
byte 1 37
byte 1 115
byte 1 32
byte 1 98
byte 1 111
byte 1 98
byte 1 115
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2183
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 109
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
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
byte 1 10
byte 1 0
align 1
LABELV $2179
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
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
byte 1 10
byte 1 0
align 1
LABELV $2175
byte 1 37
byte 1 115
byte 1 32
byte 1 111
byte 1 98
byte 1 115
byte 1 116
byte 1 114
byte 1 117
byte 1 99
byte 1 116
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 39
byte 1 115
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
byte 1 10
byte 1 0
align 1
LABELV $2172
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 115
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
byte 1 39
byte 1 115
byte 1 32
byte 1 108
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2168
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 99
byte 1 101
byte 1 112
byte 1 116
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 115
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
byte 1 39
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2158
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 115
byte 1 101
byte 1 114
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 114
byte 1 114
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 114
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $2156
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
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
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $2154
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 119
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 100
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 99
byte 1 101
byte 1 110
byte 1 100
byte 1 105
byte 1 97
byte 1 114
byte 1 121
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2152
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 104
byte 1 111
byte 1 108
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $2150
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 112
byte 1 117
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 108
byte 1 101
byte 1 101
byte 1 112
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2148
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 107
byte 1 110
byte 1 105
byte 1 102
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 98
byte 1 101
byte 1 104
byte 1 105
byte 1 110
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
LABELV $2146
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 115
byte 1 97
byte 1 119
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 104
byte 1 97
byte 1 108
byte 1 102
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2144
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 108
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 32
byte 1 115
byte 1 112
byte 1 114
byte 1 97
byte 1 121
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $2142
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 108
byte 1 101
byte 1 103
byte 1 115
byte 1 32
byte 1 98
byte 1 108
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 111
byte 1 102
byte 1 102
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2141
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 109
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 108
byte 1 101
byte 1 103
byte 1 108
byte 1 101
byte 1 115
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
LABELV $2137
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 98
byte 1 108
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 111
byte 1 102
byte 1 102
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2136
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 32
byte 1 101
byte 1 121
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2132
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 117
byte 1 99
byte 1 99
byte 1 117
byte 1 109
byte 1 98
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 110
byte 1 105
byte 1 112
byte 1 101
byte 1 114
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2131
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 115
byte 1 116
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2127
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2125
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 99
byte 1 99
byte 1 101
byte 1 112
byte 1 116
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 97
byte 1 102
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2124
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 99
byte 1 99
byte 1 101
byte 1 112
byte 1 116
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2120
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 112
byte 1 117
byte 1 110
byte 1 99
byte 1 116
byte 1 117
byte 1 114
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
LABELV $2117
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 97
byte 1 105
byte 1 108
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
LABELV $2116
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 105
byte 1 110
byte 1 45
byte 1 99
byte 1 117
byte 1 115
byte 1 104
byte 1 105
byte 1 111
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $2114
byte 1 37
byte 1 115
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2112
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 117
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2104
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 50
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 115
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 98
byte 1 117
byte 1 99
byte 1 107
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2103
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 98
byte 1 111
byte 1 100
byte 1 121
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 99
byte 1 104
byte 1 117
byte 1 99
byte 1 107
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 112
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2101
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 45
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 98
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2099
byte 1 37
byte 1 115
byte 1 32
byte 1 117
byte 1 110
byte 1 102
byte 1 111
byte 1 114
byte 1 116
byte 1 117
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 108
byte 1 121
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 117
byte 1 112
byte 1 101
byte 1 114
byte 1 45
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $2097
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 100
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 45
byte 1 100
byte 1 111
byte 1 115
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 98
byte 1 117
byte 1 99
byte 1 107
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2095
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 119
byte 1 105
byte 1 115
byte 1 115
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 101
byte 1 115
byte 1 101
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 98
byte 1 117
byte 1 99
byte 1 107
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2087
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 98
byte 1 111
byte 1 111
byte 1 109
byte 1 115
byte 1 116
byte 1 105
byte 1 99
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $2086
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 97
byte 1 32
byte 1 112
byte 1 111
byte 1 119
byte 1 100
byte 1 101
byte 1 114
byte 1 98
byte 1 117
byte 1 114
byte 1 110
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 98
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2084
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 98
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 115
byte 1 111
byte 1 114
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2082
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 102
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 100
byte 1 105
byte 1 101
byte 1 116
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2080
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 99
byte 1 101
byte 1 105
byte 1 118
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 32
byte 1 98
byte 1 97
byte 1 114
byte 1 114
byte 1 101
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $2078
byte 1 37
byte 1 115
byte 1 32
byte 1 112
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 99
byte 1 101
byte 1 115
byte 1 32
byte 1 98
byte 1 101
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 112
byte 1 105
byte 1 103
byte 1 101
byte 1 111
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $2076
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 111
byte 1 116
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
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 109
byte 1 117
byte 1 122
byte 1 122
byte 1 108
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 10
byte 1 0
align 1
LABELV $2070
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 114
byte 1 45
byte 1 109
byte 1 117
byte 1 114
byte 1 100
byte 1 101
byte 1 114
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
LABELV $2066
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 32
byte 1 112
byte 1 117
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 111
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 99
byte 1 104
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 97
byte 1 120
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2064
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 112
byte 1 108
byte 1 105
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 119
byte 1 111
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 32
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 102
byte 1 117
byte 1 108
byte 1 32
byte 1 97
byte 1 120
byte 1 101
byte 1 32
byte 1 98
byte 1 108
byte 1 111
byte 1 119
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2062
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 112
byte 1 108
byte 1 105
byte 1 116
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 99
byte 1 114
byte 1 111
byte 1 116
byte 1 99
byte 1 104
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 110
byte 1 117
byte 1 109
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 97
byte 1 120
byte 1 101
byte 1 32
byte 1 115
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $2060
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 108
byte 1 105
byte 1 99
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 100
byte 1 105
byte 1 99
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 98
byte 1 108
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2058
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 112
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 111
byte 1 112
byte 1 32
byte 1 98
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2056
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 109
byte 1 101
byte 1 108
byte 1 108
byte 1 111
byte 1 110
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 112
byte 1 108
byte 1 105
byte 1 116
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2054
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 107
byte 1 110
byte 1 105
byte 1 102
byte 1 101
byte 1 45
byte 1 109
byte 1 117
byte 1 114
byte 1 100
byte 1 101
byte 1 114
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
LABELV $2047
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2046
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 100
byte 1 117
byte 1 99
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
byte 1 115
byte 1 104
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
LABELV $2044
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 101
byte 1 101
byte 1 108
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 119
byte 1 114
byte 1 97
byte 1 116
byte 1 104
byte 1 10
byte 1 0
align 1
LABELV $2042
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2040
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 98
byte 1 117
byte 1 114
byte 1 110
byte 1 116
byte 1 32
byte 1 117
byte 1 112
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2034
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 103
byte 1 105
byte 1 98
byte 1 98
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2031
byte 1 37
byte 1 115
byte 1 32
byte 1 114
byte 1 105
byte 1 100
byte 1 101
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2029
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 103
byte 1 105
byte 1 98
byte 1 98
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2026
byte 1 37
byte 1 115
byte 1 32
byte 1 101
byte 1 97
byte 1 116
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 105
byte 1 110
byte 1 101
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2024
byte 1 37
byte 1 115
byte 1 32
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 112
byte 1 101
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 100
byte 1 121
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2022
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 101
byte 1 115
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 109
byte 1 121
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 105
byte 1 111
byte 1 117
byte 1 115
byte 1 32
byte 1 116
byte 1 114
byte 1 111
byte 1 112
byte 1 105
byte 1 99
byte 1 97
byte 1 108
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2020
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 117
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 114
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 32
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
byte 1 10
byte 1 0
align 1
LABELV $2018
byte 1 37
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 115
byte 1 32
byte 1 111
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 32
byte 1 118
byte 1 105
byte 1 97
byte 1 32
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
byte 1 10
byte 1 0
align 1
LABELV $2016
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 110
byte 1 101
byte 1 97
byte 1 114
byte 1 32
byte 1 115
byte 1 111
byte 1 109
byte 1 101
byte 1 32
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 97
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 69
byte 1 77
byte 1 80
byte 1 32
byte 1 110
byte 1 117
byte 1 107
byte 1 101
byte 1 115
byte 1 32
byte 1 105
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2014
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2012
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 116
byte 1 114
byte 1 111
byte 1 112
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2010
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 111
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 32
byte 1 97
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 69
byte 1 77
byte 1 80
byte 1 32
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 115
byte 1 32
byte 1 105
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2008
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 97
byte 1 103
byte 1 115
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 120
byte 1 105
byte 1 111
byte 1 117
byte 1 115
byte 1 32
byte 1 103
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2006
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 118
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 109
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 119
byte 1 111
byte 1 114
byte 1 107
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2004
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 117
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 105
byte 1 112
byte 1 101
byte 1 98
byte 1 111
byte 1 109
byte 1 98
byte 1 32
byte 1 116
byte 1 114
byte 1 97
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $2002
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 109
byte 1 109
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 77
byte 1 105
byte 1 114
byte 1 118
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2001
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 111
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 100
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 77
byte 1 105
byte 1 114
byte 1 118
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1997
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1993
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 117
byte 1 114
byte 1 102
byte 1 115
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 97
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1992
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 111
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 99
byte 1 104
byte 1 110
byte 1 105
byte 1 99
byte 1 97
byte 1 108
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1990
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 115
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1988
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 117
byte 1 112
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 104
byte 1 111
byte 1 116
byte 1 32
byte 1 112
byte 1 111
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 10
byte 1 0
align 1
LABELV $1986
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 117
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 117
byte 1 99
byte 1 104
byte 1 32
byte 1 115
byte 1 104
byte 1 114
byte 1 97
byte 1 112
byte 1 110
byte 1 101
byte 1 108
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1984
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 101
byte 1 116
byte 1 99
byte 1 104
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 105
byte 1 110
byte 1 101
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1982
byte 1 37
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 99
byte 1 101
byte 1 105
byte 1 118
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 112
byte 1 105
byte 1 110
byte 1 101
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 97
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1980
byte 1 37
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 100
byte 1 32
byte 1 99
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1978
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 117
byte 1 112
byte 1 45
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1967
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 104
byte 1 97
byte 1 112
byte 1 112
byte 1 121
byte 1 32
byte 1 98
byte 1 105
byte 1 114
byte 1 116
byte 1 104
byte 1 100
byte 1 97
byte 1 121
byte 1 44
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 107
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1964
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 117
byte 1 112
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1962
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 115
byte 1 97
byte 1 121
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 105
byte 1 116
byte 1 44
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 115
byte 1 97
byte 1 121
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 105
byte 1 116
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 33
byte 1 32
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1960
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 100
byte 1 101
byte 1 114
byte 1 97
byte 1 105
byte 1 108
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
LABELV $1958
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1956
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 100
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 98
byte 1 117
byte 1 99
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $1954
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 103
byte 1 105
byte 1 102
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1952
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 32
byte 1 73
byte 1 32
byte 1 98
byte 1 108
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1950
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 108
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 103
byte 1 104
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 32
byte 1 103
byte 1 105
byte 1 102
byte 1 116
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1948
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 111
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 114
byte 1 117
byte 1 110
byte 1 32
byte 1 99
byte 1 114
byte 1 121
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 110
byte 1 121
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1946
byte 1 37
byte 1 115
byte 1 32
byte 1 108
byte 1 111
byte 1 118
byte 1 101
byte 1 115
byte 1 32
byte 1 115
byte 1 110
byte 1 105
byte 1 112
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 108
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1945
byte 1 37
byte 1 115
byte 1 32
byte 1 65
byte 1 76
byte 1 77
byte 1 79
byte 1 83
byte 1 84
byte 1 32
byte 1 99
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 101
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 116
byte 1 119
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 116
byte 1 101
byte 1 101
byte 1 116
byte 1 104
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1941
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 116
byte 1 121
byte 1 32
byte 1 112
byte 1 111
byte 1 112
byte 1 112
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
LABELV $1940
byte 1 37
byte 1 115
byte 1 32
byte 1 98
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 98
byte 1 105
byte 1 114
byte 1 116
byte 1 104
byte 1 100
byte 1 97
byte 1 121
byte 1 32
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 115
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $1936
byte 1 37
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1935
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
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
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 101
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $1931
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 105
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 99
byte 1 114
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1928
byte 1 37
byte 1 115
byte 1 32
byte 1 114
byte 1 105
byte 1 100
byte 1 101
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 99
byte 1 114
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $1926
byte 1 37
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 115
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 45
byte 1 116
byte 1 104
byte 1 101
byte 1 45
byte 1 112
byte 1 97
byte 1 114
byte 1 99
byte 1 101
byte 1 108
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1923
byte 1 37
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 99
byte 1 105
byte 1 101
byte 1 118
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 103
byte 1 105
byte 1 102
byte 1 116
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1921
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 117
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 114
byte 1 105
byte 1 98
byte 1 98
byte 1 111
byte 1 110
byte 1 32
byte 1 111
byte 1 102
byte 1 32
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
byte 1 10
byte 1 0
align 1
LABELV $1919
byte 1 68
byte 1 97
byte 1 109
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 106
byte 1 111
byte 1 107
byte 1 101
byte 1 121
byte 1 32
byte 1 115
byte 1 109
byte 1 117
byte 1 114
byte 1 102
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1916
byte 1 37
byte 1 115
byte 1 32
byte 1 101
byte 1 97
byte 1 116
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 103
byte 1 111
byte 1 111
byte 1 100
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 101
byte 1 114
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1914
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 110
byte 1 101
byte 1 97
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 98
byte 1 105
byte 1 114
byte 1 116
byte 1 104
byte 1 100
byte 1 97
byte 1 121
byte 1 32
byte 1 115
byte 1 117
byte 1 114
byte 1 112
byte 1 114
byte 1 105
byte 1 115
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1912
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 111
byte 1 101
byte 1 115
byte 1 32
byte 1 80
byte 1 79
byte 1 80
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1910
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 103
byte 1 111
byte 1 32
byte 1 117
byte 1 112
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 69
byte 1 77
byte 1 80
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1908
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 97
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 100
byte 1 97
byte 1 114
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 117
byte 1 100
byte 1 115
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 77
byte 1 105
byte 1 114
byte 1 118
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1906
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 119
byte 1 115
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1898
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 115
byte 1 117
byte 1 114
byte 1 118
byte 1 105
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 111
byte 1 112
byte 1 101
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1894
byte 1 37
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 117
byte 1 112
byte 1 112
byte 1 111
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1893
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 111
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 10
byte 1 0
align 1
LABELV $1891
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 103
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 102
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1889
byte 1 37
byte 1 115
byte 1 32
byte 1 109
byte 1 111
byte 1 119
byte 1 115
byte 1 32
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1884
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 105
byte 1 118
byte 1 101
byte 1 115
byte 1 32
byte 1 103
byte 1 105
byte 1 102
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1883
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 116
byte 1 121
byte 1 45
byte 1 112
byte 1 111
byte 1 111
byte 1 112
byte 1 101
byte 1 114
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1871
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1869
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 103
byte 1 117
byte 1 110
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1867
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 119
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1863
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 114
byte 1 99
byte 1 104
byte 1 101
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $1861
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 117
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 112
byte 1 105
byte 1 110
byte 1 32
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 105
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $1859
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 99
byte 1 101
byte 1 110
byte 1 100
byte 1 105
byte 1 97
byte 1 114
byte 1 121
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $1857
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 115
byte 1 32
byte 1 105
byte 1 102
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1856
byte 1 37
byte 1 115
byte 1 32
byte 1 98
byte 1 101
byte 1 99
byte 1 111
byte 1 109
byte 1 101
byte 1 115
byte 1 32
byte 1 98
byte 1 111
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 108
byte 1 105
byte 1 102
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1852
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 109
byte 1 112
byte 1 111
byte 1 115
byte 1 115
byte 1 105
byte 1 98
byte 1 108
byte 1 121
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1850
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 114
byte 1 117
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $1848
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 111
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 98
byte 1 111
byte 1 120
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
byte 1 104
byte 1 105
byte 1 109
byte 1 10
byte 1 0
align 1
LABELV $1846
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1844
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 116
byte 1 114
byte 1 111
byte 1 112
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1842
byte 1 37
byte 1 115
byte 1 32
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 100
byte 1 101
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 98
byte 1 111
byte 1 100
byte 1 121
byte 1 10
byte 1 0
align 1
LABELV $1840
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 104
byte 1 111
byte 1 107
byte 1 101
byte 1 115
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 97
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1838
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 106
byte 1 117
byte 1 103
byte 1 103
byte 1 108
byte 1 101
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 112
byte 1 105
byte 1 112
byte 1 101
byte 1 98
byte 1 111
byte 1 109
byte 1 98
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1836
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 109
byte 1 98
byte 1 117
byte 1 115
byte 1 104
byte 1 101
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 112
byte 1 105
byte 1 112
byte 1 101
byte 1 98
byte 1 111
byte 1 109
byte 1 98
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1834
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 111
byte 1 101
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 105
byte 1 101
byte 1 99
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1833
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 77
byte 1 105
byte 1 114
byte 1 118
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 32
byte 1 97
byte 1 103
byte 1 97
byte 1 105
byte 1 110
byte 1 115
byte 1 116
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 10
byte 1 0
align 1
LABELV $1831
byte 1 37
byte 1 115
byte 1 32
byte 1 112
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 99
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 77
byte 1 105
byte 1 114
byte 1 118
byte 1 32
byte 1 100
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1825
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 109
byte 1 109
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $1821
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $1820
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $1818
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 105
byte 1 112
byte 1 116
byte 1 111
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1816
byte 1 37
byte 1 115
byte 1 32
byte 1 108
byte 1 101
byte 1 116
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 98
byte 1 101
byte 1 115
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 10
byte 1 0
align 1
LABELV $1814
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 111
byte 1 116
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
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1812
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 117
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1810
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 119
byte 1 101
byte 1 108
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $1808
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 97
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1806
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $1797
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 115
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 98
byte 1 111
byte 1 114
byte 1 110
byte 1 32
byte 1 115
byte 1 111
byte 1 32
byte 1 98
byte 1 101
byte 1 97
byte 1 117
byte 1 116
byte 1 105
byte 1 102
byte 1 117
byte 1 108
byte 1 32
byte 1 97
byte 1 102
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $1796
byte 1 37
byte 1 115
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 105
byte 1 115
byte 1 104
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 103
byte 1 105
byte 1 102
byte 1 116
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1793
byte 1 73
byte 1 116
byte 1 39
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 116
byte 1 121
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 39
byte 1 108
byte 1 108
byte 1 32
byte 1 99
byte 1 114
byte 1 121
byte 1 32
byte 1 105
byte 1 102
byte 1 32
byte 1 104
byte 1 101
byte 1 32
byte 1 119
byte 1 97
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1784
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $1781
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1777
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
LABELV $1774
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1770
byte 1 83
byte 1 97
byte 1 116
byte 1 97
byte 1 110
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 39
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
byte 1 10
byte 1 0
align 1
LABELV $1769
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
LABELV $1759
byte 1 37
byte 1 115
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
LABELV $1752
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 95
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1747
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
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
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1746
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 114
byte 1 111
byte 1 121
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 103
byte 1 117
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $1739
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 110
byte 1 116
byte 1 114
byte 1 121
byte 1 103
byte 1 117
byte 1 110
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
LABELV $1738
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
LABELV $1735
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
LABELV $1704
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $1697
byte 1 112
byte 1 114
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1696
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 101
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1695
byte 1 37
byte 1 115
byte 1 32
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1693
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 32
byte 1 116
byte 1 103
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $1690
byte 1 67
byte 1 85
byte 1 82
byte 1 82
byte 1 69
byte 1 78
byte 1 84
byte 1 76
byte 1 89
byte 1 32
byte 1 73
byte 1 78
byte 1 32
byte 1 80
byte 1 82
byte 1 69
byte 1 77
byte 1 65
byte 1 84
byte 1 67
byte 1 72
byte 1 32
byte 1 84
byte 1 73
byte 1 77
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $1685
byte 1 89
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 66
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 73
byte 1 68
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1684
byte 1 115
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 116
byte 1 102
byte 1 95
byte 1 105
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1683
byte 1 67
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 46
byte 1 32
byte 1 67
byte 1 108
byte 1 97
byte 1 110
byte 1 32
byte 1 66
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1668
byte 1 103
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $1667
byte 1 87
byte 1 101
byte 1 108
byte 1 99
byte 1 111
byte 1 109
byte 1 101
byte 1 32
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1664
byte 1 116
byte 1 102
byte 1 95
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $1658
byte 1 116
byte 1 102
byte 1 95
byte 1 111
byte 1 110
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $1655
byte 1 37
byte 1 115
byte 1 32
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1653
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 95
byte 1 115
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $1650
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 95
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $1649
byte 1 101
byte 1 109
byte 1 0
align 1
LABELV $1646
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $1643
byte 1 109
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $1642
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $1639
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 0
align 1
LABELV $1638
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $1633
byte 1 115
byte 1 98
byte 1 0
align 1
LABELV $1630
byte 1 52
byte 1 0
align 1
LABELV $1629
byte 1 109
byte 1 120
byte 1 99
byte 1 0
align 1
LABELV $1626
byte 1 51
byte 1 0
align 1
LABELV $1625
byte 1 109
byte 1 120
byte 1 114
byte 1 0
align 1
LABELV $1622
byte 1 50
byte 1 0
align 1
LABELV $1621
byte 1 109
byte 1 120
byte 1 110
byte 1 0
align 1
LABELV $1618
byte 1 49
byte 1 0
align 1
LABELV $1617
byte 1 109
byte 1 120
byte 1 115
byte 1 0
align 1
LABELV $1614
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $1613
byte 1 115
byte 1 98
byte 1 115
byte 1 0
align 1
LABELV $1610
byte 1 115
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $1609
byte 1 115
byte 1 98
byte 1 114
byte 1 0
align 1
LABELV $1575
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 207
byte 1 198
byte 1 198
byte 1 10
byte 1 0
align 1
LABELV $1574
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 207
byte 1 206
byte 1 10
byte 1 0
align 1
LABELV $1570
byte 1 84
byte 1 97
byte 1 107
byte 1 101
byte 1 32
byte 1 115
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 207
byte 1 198
byte 1 198
byte 1 10
byte 1 0
align 1
LABELV $1569
byte 1 84
byte 1 97
byte 1 107
byte 1 101
byte 1 32
byte 1 115
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 207
byte 1 206
byte 1 10
byte 1 0
align 1
LABELV $1565
byte 1 69
byte 1 120
byte 1 101
byte 1 99
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 207
byte 1 198
byte 1 198
byte 1 10
byte 1 0
align 1
LABELV $1564
byte 1 69
byte 1 120
byte 1 101
byte 1 99
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 207
byte 1 206
byte 1 10
byte 1 0
align 1
LABELV $1560
byte 1 69
byte 1 120
byte 1 101
byte 1 99
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 207
byte 1 198
byte 1 198
byte 1 10
byte 1 0
align 1
LABELV $1559
byte 1 69
byte 1 120
byte 1 101
byte 1 99
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 207
byte 1 206
byte 1 10
byte 1 0
align 1
LABELV $1555
byte 1 77
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 207
byte 1 198
byte 1 198
byte 1 10
byte 1 0
align 1
LABELV $1554
byte 1 77
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 207
byte 1 206
byte 1 10
byte 1 0
align 1
LABELV $1550
byte 1 67
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 207
byte 1 198
byte 1 198
byte 1 10
byte 1 0
align 1
LABELV $1549
byte 1 67
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 207
byte 1 206
byte 1 10
byte 1 0
align 1
LABELV $1545
byte 1 84
byte 1 70
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 115
byte 1 32
byte 1 98
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 37
byte 1 52
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1543
byte 1 68
byte 1 105
byte 1 115
byte 1 99
byte 1 97
byte 1 114
byte 1 100
byte 1 32
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 37
byte 1 51
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1541
byte 1 68
byte 1 105
byte 1 115
byte 1 99
byte 1 97
byte 1 114
byte 1 100
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 37
byte 1 51
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1539
byte 1 68
byte 1 105
byte 1 115
byte 1 99
byte 1 97
byte 1 114
byte 1 100
byte 1 32
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 32
byte 1 37
byte 1 51
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1537
byte 1 68
byte 1 105
byte 1 115
byte 1 99
byte 1 97
byte 1 114
byte 1 100
byte 1 32
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 37
byte 1 51
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1529
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 51
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1420
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 108
byte 1 97
byte 1 110
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1419
byte 1 104
byte 1 107
byte 1 110
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 47
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1416
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 108
byte 1 97
byte 1 110
byte 1 100
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1415
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $1408
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
LABELV $1388
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
LABELV $1387
byte 1 65
byte 1 105
byte 1 114
byte 1 32
byte 1 115
byte 1 117
byte 1 112
byte 1 112
byte 1 108
byte 1 121
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 66
byte 1 105
byte 1 111
byte 1 115
byte 1 117
byte 1 105
byte 1 116
byte 1 32
byte 1 101
byte 1 120
byte 1 112
byte 1 105
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $1352
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
LABELV $1351
byte 1 81
byte 1 117
byte 1 97
byte 1 100
byte 1 32
byte 1 68
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 111
byte 1 102
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $1328
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
LABELV $1316
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
LABELV $1315
byte 1 80
byte 1 114
byte 1 111
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 97
byte 1 108
byte 1 109
byte 1 111
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $1293
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
LABELV $1292
byte 1 98
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $1291
byte 1 82
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 83
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 115
byte 1 32
byte 1 109
byte 1 97
byte 1 103
byte 1 105
byte 1 99
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $1284
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
LABELV $1241
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 108
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 115
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 103
byte 1 117
byte 1 105
byte 1 115
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $1222
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 47
byte 1 109
byte 1 101
byte 1 103
byte 1 97
byte 1 109
byte 1 110
byte 1 117
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $1221
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 47
byte 1 109
byte 1 101
byte 1 103
byte 1 97
byte 1 109
byte 1 110
byte 1 117
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $1169
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 115
byte 1 108
byte 1 105
byte 1 109
byte 1 98
byte 1 114
byte 1 110
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1166
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
LABELV $1163
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 105
byte 1 110
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1141
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 111
byte 1 117
byte 1 116
byte 1 119
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1126
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
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1122
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
byte 1 112
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1111
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 112
byte 1 108
byte 1 121
byte 1 114
byte 1 106
byte 1 109
byte 1 112
byte 1 56
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1110
byte 1 104
byte 1 107
byte 1 110
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 47
byte 1 115
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1102
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 119
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1101
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 119
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1041
byte 1 37
byte 1 51
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1036
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 109
byte 1 97
byte 1 108
byte 1 105
byte 1 118
byte 1 101
byte 1 53
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $1035
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
LABELV $1032
byte 1 10
byte 1 10
byte 1 67
byte 1 69
byte 1 65
byte 1 83
byte 1 69
byte 1 32
byte 1 70
byte 1 73
byte 1 82
byte 1 69
byte 1 32
byte 1 77
byte 1 79
byte 1 68
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $1026
byte 1 114
byte 1 106
byte 1 0
align 1
LABELV $1009
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 117
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1008
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 117
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $999
byte 1 42
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $996
byte 1 102
byte 1 117
byte 1 104
byte 1 113
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 0
align 1
LABELV $993
byte 1 42
byte 1 70
byte 1 117
byte 1 104
byte 1 81
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 0
align 1
LABELV $992
byte 1 122
byte 1 113
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 0
align 1
LABELV $989
byte 1 42
byte 1 122
byte 1 95
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $988
byte 1 48
byte 1 46
byte 1 57
byte 1 51
byte 1 0
align 1
LABELV $985
byte 1 48
byte 1 46
byte 1 57
byte 1 53
byte 1 0
align 1
LABELV $982
byte 1 48
byte 1 46
byte 1 57
byte 1 54
byte 1 0
align 1
LABELV $979
byte 1 109
byte 1 113
byte 1 119
byte 1 99
byte 1 108
byte 1 0
align 1
LABELV $976
byte 1 109
byte 1 113
byte 1 119
byte 1 99
byte 1 108
byte 1 32
byte 1 48
byte 1 46
byte 1 57
byte 1 51
byte 1 0
align 1
LABELV $973
byte 1 109
byte 1 113
byte 1 119
byte 1 99
byte 1 108
byte 1 32
byte 1 48
byte 1 46
byte 1 57
byte 1 53
byte 1 0
align 1
LABELV $970
byte 1 109
byte 1 113
byte 1 119
byte 1 99
byte 1 108
byte 1 32
byte 1 48
byte 1 46
byte 1 57
byte 1 54
byte 1 0
align 1
LABELV $967
byte 1 42
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $966
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $965
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
LABELV $964
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 101
byte 1 121
byte 1 101
byte 1 115
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $962
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
LABELV $943
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
LABELV $937
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
LABELV $936
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
LABELV $900
byte 1 80
byte 1 117
byte 1 116
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 73
byte 1 110
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 110
byte 1 111
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
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $895
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
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 50
byte 1 0
align 1
LABELV $883
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
byte 1 99
byte 1 111
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $858
byte 1 70
byte 1 105
byte 1 110
byte 1 100
byte 1 82
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $764
byte 1 116
byte 1 115
byte 1 52
byte 1 0
align 1
LABELV $763
byte 1 116
byte 1 115
byte 1 51
byte 1 0
align 1
LABELV $762
byte 1 116
byte 1 115
byte 1 50
byte 1 0
align 1
LABELV $761
byte 1 116
byte 1 115
byte 1 49
byte 1 0
align 1
LABELV $755
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $752
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $740
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $729
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 32
byte 1 100
byte 1 111
byte 1 101
byte 1 115
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $720
byte 1 37
byte 1 115
byte 1 32
byte 1 101
byte 1 120
byte 1 105
byte 1 116
byte 1 101
byte 1 100
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
LABELV $718
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $716
byte 1 115
byte 1 97
byte 1 109
byte 1 101
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $702
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 117
byte 1 116
byte 1 101
byte 1 95
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 40
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $700
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 110
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 34
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $699
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 120
byte 1 112
byte 1 32
byte 1 34
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $698
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 112
byte 1 32
byte 1 34
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $696
byte 1 111
byte 1 117
byte 1 116
byte 1 115
byte 1 105
byte 1 100
byte 1 101
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 46
byte 1 32
byte 1 78
byte 1 101
byte 1 120
byte 1 116
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $695
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 32
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $694
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 46
byte 1 32
byte 1 67
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $691
byte 1 77
byte 1 65
byte 1 80
byte 1 32
byte 1 67
byte 1 89
byte 1 67
byte 1 76
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 67
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 0
align 1
LABELV $690
byte 1 109
byte 1 97
byte 1 120
byte 1 112
byte 1 0
align 1
LABELV $689
byte 1 109
byte 1 105
byte 1 110
byte 1 112
byte 1 0
align 1
LABELV $688
byte 1 110
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $685
byte 1 73
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 107
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $678
byte 1 69
byte 1 120
byte 1 105
byte 1 116
byte 1 32
byte 1 73
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $677
byte 1 78
byte 1 111
byte 1 119
byte 1 44
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 82
byte 1 117
byte 1 110
byte 1 101
byte 1 115
byte 1 46
byte 1 32
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 115
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 10
byte 1 116
byte 1 114
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 100
byte 1 111
byte 1 117
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 115
byte 1 32
byte 1 109
byte 1 111
byte 1 118
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 10
byte 1 117
byte 1 110
byte 1 115
byte 1 101
byte 1 97
byte 1 108
byte 1 32
byte 1 97
byte 1 110
byte 1 99
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 98
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 115
byte 1 46
byte 1 32
byte 1 83
byte 1 104
byte 1 117
byte 1 98
byte 1 45
byte 1 78
byte 1 105
byte 1 103
byte 1 103
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 104
byte 1 10
byte 1 104
byte 1 97
byte 1 100
byte 1 32
byte 1 104
byte 1 111
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 82
byte 1 117
byte 1 110
byte 1 101
byte 1 115
byte 1 32
byte 1 72
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 116
byte 1 111
byte 1 10
byte 1 99
byte 1 108
byte 1 101
byte 1 97
byte 1 114
byte 1 32
byte 1 111
byte 1 102
byte 1 102
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 69
byte 1 97
byte 1 114
byte 1 116
byte 1 104
byte 1 44
byte 1 32
byte 1 98
byte 1 117
byte 1 116
byte 1 32
byte 1 110
byte 1 111
byte 1 119
byte 1 32
byte 1 105
byte 1 110
byte 1 115
byte 1 116
byte 1 101
byte 1 97
byte 1 100
byte 1 44
byte 1 10
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 119
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 109
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 104
byte 1 111
byte 1 109
byte 1 101
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 10
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 114
byte 1 111
byte 1 110
byte 1 116
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 97
byte 1 118
byte 1 97
byte 1 116
byte 1 97
byte 1 114
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 97
byte 1 118
byte 1 101
byte 1 110
byte 1 103
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 69
byte 1 97
byte 1 114
byte 1 116
byte 1 104
byte 1 45
byte 1 108
byte 1 105
byte 1 102
byte 1 101
byte 1 46
byte 1 32
byte 1 73
byte 1 102
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 97
byte 1 116
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 44
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 119
byte 1 105
byte 1 108
byte 1 108
byte 1 10
byte 1 98
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 101
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 97
byte 1 118
byte 1 105
byte 1 111
byte 1 114
byte 1 32
byte 1 111
byte 1 102
byte 1 10
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 110
byte 1 101
byte 1 116
byte 1 46
byte 1 32
byte 1 73
byte 1 102
byte 1 32
byte 1 115
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 113
byte 1 117
byte 1 101
byte 1 114
byte 1 115
byte 1 44
byte 1 32
byte 1 105
byte 1 116
byte 1 32
byte 1 119
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 98
byte 1 101
byte 1 10
byte 1 97
byte 1 115
byte 1 32
byte 1 105
byte 1 102
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 100
byte 1 32
byte 1 110
byte 1 101
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 98
byte 1 111
byte 1 114
byte 1 110
byte 1 46
byte 1 0
align 1
LABELV $669
byte 1 68
byte 1 101
byte 1 115
byte 1 112
byte 1 105
byte 1 116
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 97
byte 1 119
byte 1 102
byte 1 117
byte 1 108
byte 1 32
byte 1 109
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 69
byte 1 108
byte 1 100
byte 1 101
byte 1 114
byte 1 10
byte 1 87
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 44
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 101
byte 1 118
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 82
byte 1 117
byte 1 110
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 10
byte 1 69
byte 1 108
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 77
byte 1 97
byte 1 103
byte 1 105
byte 1 99
byte 1 44
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 115
byte 1 116
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 115
byte 1 32
byte 1 111
byte 1 102
byte 1 10
byte 1 97
byte 1 114
byte 1 99
byte 1 97
byte 1 110
byte 1 101
byte 1 32
byte 1 119
byte 1 105
byte 1 115
byte 1 100
byte 1 111
byte 1 109
byte 1 46
byte 1 32
byte 1 66
byte 1 101
byte 1 121
byte 1 111
byte 1 110
byte 1 100
byte 1 32
byte 1 103
byte 1 111
byte 1 111
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 101
byte 1 118
byte 1 105
byte 1 108
byte 1 44
byte 1 10
byte 1 98
byte 1 101
byte 1 121
byte 1 111
byte 1 110
byte 1 100
byte 1 32
byte 1 108
byte 1 105
byte 1 102
byte 1 101
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 44
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 82
byte 1 117
byte 1 110
byte 1 101
byte 1 10
byte 1 112
byte 1 117
byte 1 108
byte 1 115
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 44
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 118
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 105
byte 1 109
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 46
byte 1 32
byte 1 80
byte 1 97
byte 1 116
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 10
byte 1 112
byte 1 111
byte 1 116
byte 1 101
byte 1 110
byte 1 116
byte 1 44
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 69
byte 1 108
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 66
byte 1 101
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 83
byte 1 104
byte 1 117
byte 1 98
byte 1 45
byte 1 78
byte 1 105
byte 1 103
byte 1 103
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 104
byte 1 10
byte 1 119
byte 1 101
byte 1 97
byte 1 118
byte 1 101
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 100
byte 1 105
byte 1 114
byte 1 101
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 110
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 101
byte 1 97
byte 1 114
byte 1 32
byte 1 111
byte 1 102
byte 1 102
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 10
byte 1 108
byte 1 105
byte 1 102
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 69
byte 1 97
byte 1 114
byte 1 116
byte 1 104
byte 1 44
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 98
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 10
byte 1 102
byte 1 111
byte 1 117
byte 1 108
byte 1 32
byte 1 111
byte 1 102
byte 1 102
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 33
byte 1 32
byte 1 70
byte 1 111
byte 1 114
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 10
byte 1 100
byte 1 119
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 115
byte 1 101
byte 1 32
byte 1 110
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 109
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 100
byte 1 105
byte 1 109
byte 1 101
byte 1 110
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 115
byte 1 10
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 99
byte 1 101
byte 1 110
byte 1 100
byte 1 97
byte 1 110
byte 1 116
byte 1 115
byte 1 33
byte 1 32
byte 1 79
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 82
byte 1 117
byte 1 110
byte 1 101
byte 1 115
byte 1 32
byte 1 111
byte 1 102
byte 1 10
byte 1 109
byte 1 97
byte 1 103
byte 1 105
byte 1 99
byte 1 32
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 117
byte 1 110
byte 1 105
byte 1 116
byte 1 101
byte 1 100
byte 1 44
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 103
byte 1 121
byte 1 10
byte 1 98
byte 1 101
byte 1 104
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 109
byte 1 32
byte 1 119
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 98
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 71
byte 1 97
byte 1 116
byte 1 101
byte 1 119
byte 1 97
byte 1 121
byte 1 10
byte 1 116
byte 1 111
byte 1 32
byte 1 83
byte 1 104
byte 1 117
byte 1 98
byte 1 45
byte 1 78
byte 1 105
byte 1 103
byte 1 103
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 104
byte 1 44
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 32
byte 1 116
byte 1 114
byte 1 97
byte 1 118
byte 1 101
byte 1 108
byte 1 10
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 102
byte 1 111
byte 1 105
byte 1 108
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 72
byte 1 101
byte 1 108
byte 1 108
byte 1 45
byte 1 77
byte 1 111
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 111
byte 1 116
byte 1 115
byte 1 10
byte 1 105
byte 1 110
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 46
byte 1 0
align 1
LABELV $668
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 101
byte 1 52
byte 1 109
byte 1 55
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $665
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 118
byte 1 105
byte 1 115
byte 1 99
byte 1 101
byte 1 114
byte 1 97
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 100
byte 1 105
byte 1 97
byte 1 98
byte 1 111
byte 1 108
byte 1 105
byte 1 99
byte 1 32
byte 1 104
byte 1 111
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 115
byte 1 10
byte 1 98
byte 1 117
byte 1 98
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 118
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 117
byte 1 115
byte 1 108
byte 1 121
byte 1 32
byte 1 97
byte 1 115
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 115
byte 1 101
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 82
byte 1 117
byte 1 110
byte 1 101
byte 1 10
byte 1 111
byte 1 102
byte 1 32
byte 1 72
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 77
byte 1 97
byte 1 103
byte 1 105
byte 1 99
byte 1 46
byte 1 32
byte 1 73
byte 1 116
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 116
byte 1 32
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 99
byte 1 104
byte 1 101
byte 1 115
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 10
byte 1 104
byte 1 97
byte 1 110
byte 1 100
byte 1 44
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 101
byte 1 114
byte 1 114
byte 1 105
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 114
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 98
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 10
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 100
byte 1 46
byte 1 32
byte 1 71
byte 1 97
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 104
byte 1 114
byte 1 101
byte 1 100
byte 1 115
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 10
byte 1 99
byte 1 111
byte 1 117
byte 1 114
byte 1 97
byte 1 103
byte 1 101
byte 1 44
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 115
byte 1 104
byte 1 97
byte 1 107
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 100
byte 1 101
byte 1 118
byte 1 105
byte 1 108
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 97
byte 1 99
byte 1 107
byte 1 108
byte 1 101
byte 1 115
byte 1 10
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 115
byte 1 111
byte 1 117
byte 1 108
byte 1 44
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 98
byte 1 101
byte 1 99
byte 1 111
byte 1 109
byte 1 101
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 10
byte 1 104
byte 1 97
byte 1 114
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 114
byte 1 111
byte 1 121
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 10
byte 1 104
byte 1 105
byte 1 100
byte 1 101
byte 1 111
byte 1 117
byte 1 115
byte 1 32
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 119
byte 1 104
byte 1 111
byte 1 115
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 114
byte 1 101
byte 1 32
byte 1 101
byte 1 120
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 10
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 110
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 111
byte 1 117
byte 1 108
byte 1 115
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 112
byte 1 115
byte 1 121
byte 1 99
byte 1 104
byte 1 101
byte 1 115
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 10
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 112
byte 1 111
byte 1 112
byte 1 117
byte 1 108
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 69
byte 1 97
byte 1 114
byte 1 116
byte 1 104
byte 1 46
byte 1 0
align 1
LABELV $664
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 101
byte 1 51
byte 1 109
byte 1 54
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $661
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 82
byte 1 117
byte 1 110
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 66
byte 1 108
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 77
byte 1 97
byte 1 103
byte 1 105
byte 1 99
byte 1 32
byte 1 116
byte 1 104
byte 1 114
byte 1 111
byte 1 98
byte 1 115
byte 1 32
byte 1 101
byte 1 118
byte 1 105
byte 1 108
byte 1 108
byte 1 121
byte 1 32
byte 1 105
byte 1 110
byte 1 10
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 104
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 119
byte 1 104
byte 1 105
byte 1 115
byte 1 112
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 100
byte 1 97
byte 1 114
byte 1 107
byte 1 32
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 103
byte 1 104
byte 1 116
byte 1 115
byte 1 10
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 98
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 46
byte 1 32
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 114
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 109
byte 1 111
byte 1 115
byte 1 116
byte 1 10
byte 1 108
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 72
byte 1 101
byte 1 108
byte 1 108
byte 1 45
byte 1 77
byte 1 111
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 59
byte 1 32
byte 1 83
byte 1 104
byte 1 117
byte 1 98
byte 1 45
byte 1 78
byte 1 105
byte 1 103
byte 1 103
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 104
byte 1 33
byte 1 10
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 110
byte 1 111
byte 1 119
byte 1 32
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 115
byte 1 104
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 98
byte 1 101
byte 1 104
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 10
byte 1 116
byte 1 101
byte 1 114
byte 1 114
byte 1 105
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 112
byte 1 108
byte 1 111
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 119
byte 1 104
byte 1 105
byte 1 99
byte 1 104
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 111
byte 1 10
byte 1 109
byte 1 117
byte 1 99
byte 1 104
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 104
byte 1 111
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 46
byte 1 32
byte 1 66
byte 1 117
byte 1 116
byte 1 32
byte 1 115
byte 1 104
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 10
byte 1 105
byte 1 110
byte 1 118
byte 1 105
byte 1 111
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 33
byte 1 32
byte 1 65
byte 1 114
byte 1 109
byte 1 101
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 82
byte 1 117
byte 1 110
byte 1 101
byte 1 44
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 10
byte 1 114
byte 1 101
byte 1 97
byte 1 108
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 82
byte 1 117
byte 1 110
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 10
byte 1 99
byte 1 111
byte 1 109
byte 1 98
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 44
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 83
byte 1 104
byte 1 117
byte 1 98
byte 1 45
byte 1 78
byte 1 105
byte 1 103
byte 1 103
byte 1 117
byte 1 114
byte 1 97
byte 1 116
byte 1 104
byte 1 39
byte 1 115
byte 1 10
byte 1 80
byte 1 105
byte 1 116
byte 1 32
byte 1 119
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 44
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 32
byte 1 102
byte 1 97
byte 1 99
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 10
byte 1 87
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 45
byte 1 71
byte 1 111
byte 1 100
byte 1 100
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 102
byte 1 114
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 102
byte 1 117
byte 1 108
byte 1 10
byte 1 111
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 32
byte 1 99
byte 1 97
byte 1 116
byte 1 104
byte 1 101
byte 1 100
byte 1 114
byte 1 97
byte 1 108
byte 1 46
byte 1 0
align 1
LABELV $660
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 101
byte 1 50
byte 1 109
byte 1 54
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $657
byte 1 65
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 114
byte 1 112
byte 1 115
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 114
byte 1 111
byte 1 117
byte 1 115
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 10
byte 1 67
byte 1 104
byte 1 116
byte 1 104
byte 1 111
byte 1 110
byte 1 32
byte 1 115
byte 1 105
byte 1 110
byte 1 107
byte 1 115
byte 1 32
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 32
byte 1 119
byte 1 104
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 10
byte 1 105
byte 1 116
byte 1 32
byte 1 114
byte 1 111
byte 1 115
byte 1 101
byte 1 44
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 103
byte 1 114
byte 1 105
byte 1 112
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 82
byte 1 117
byte 1 110
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 69
byte 1 97
byte 1 114
byte 1 116
byte 1 104
byte 1 10
byte 1 77
byte 1 97
byte 1 103
byte 1 105
byte 1 99
byte 1 32
byte 1 116
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 108
byte 1 121
byte 1 46
byte 1 32
byte 1 78
byte 1 111
byte 1 119
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 10
byte 1 99
byte 1 111
byte 1 110
byte 1 113
byte 1 117
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 68
byte 1 105
byte 1 109
byte 1 101
byte 1 110
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 68
byte 1 111
byte 1 111
byte 1 109
byte 1 101
byte 1 100
byte 1 44
byte 1 10
byte 1 114
byte 1 101
byte 1 97
byte 1 108
byte 1 109
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 69
byte 1 97
byte 1 114
byte 1 116
byte 1 104
byte 1 32
byte 1 77
byte 1 97
byte 1 103
byte 1 105
byte 1 99
byte 1 44
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 116
byte 1 111
byte 1 10
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 46
byte 1 32
byte 1 65
byte 1 32
byte 1 82
byte 1 117
byte 1 110
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 109
byte 1 97
byte 1 103
byte 1 105
byte 1 99
byte 1 10
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 32
byte 1 108
byte 1 105
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 32
byte 1 104
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 108
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 81
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 46
byte 1 32
byte 1 71
byte 1 111
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 116
byte 1 104
byte 1 44
byte 1 32
byte 1 115
byte 1 101
byte 1 101
byte 1 107
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 10
byte 1 116
byte 1 111
byte 1 116
byte 1 97
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 82
byte 1 117
byte 1 110
byte 1 101
byte 1 115
byte 1 33
byte 1 0
align 1
LABELV $656
byte 1 65
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 114
byte 1 112
byte 1 115
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 109
byte 1 111
byte 1 110
byte 1 115
byte 1 116
byte 1 114
byte 1 111
byte 1 117
byte 1 115
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 10
byte 1 67
byte 1 104
byte 1 116
byte 1 104
byte 1 111
byte 1 110
byte 1 32
byte 1 115
byte 1 105
byte 1 110
byte 1 107
byte 1 115
byte 1 32
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 32
byte 1 119
byte 1 104
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 10
byte 1 105
byte 1 116
byte 1 32
byte 1 114
byte 1 111
byte 1 115
byte 1 101
byte 1 44
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 103
byte 1 114
byte 1 105
byte 1 112
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 82
byte 1 117
byte 1 110
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 69
byte 1 97
byte 1 114
byte 1 116
byte 1 104
byte 1 10
byte 1 77
byte 1 97
byte 1 103
byte 1 105
byte 1 99
byte 1 32
byte 1 116
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 108
byte 1 121
byte 1 46
byte 1 32
byte 1 78
byte 1 111
byte 1 119
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 10
byte 1 99
byte 1 111
byte 1 110
byte 1 113
byte 1 117
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 68
byte 1 105
byte 1 109
byte 1 101
byte 1 110
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 68
byte 1 111
byte 1 111
byte 1 109
byte 1 101
byte 1 100
byte 1 44
byte 1 10
byte 1 114
byte 1 101
byte 1 97
byte 1 108
byte 1 109
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 69
byte 1 97
byte 1 114
byte 1 116
byte 1 104
byte 1 32
byte 1 77
byte 1 97
byte 1 103
byte 1 105
byte 1 99
byte 1 44
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 116
byte 1 111
byte 1 10
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 111
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 101
byte 1 10
byte 1 104
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 108
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 81
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 46
byte 1 32
byte 1 79
byte 1 114
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 63
byte 1 32
byte 1 73
byte 1 102
byte 1 10
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 100
byte 1 111
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 81
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 44
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 39
byte 1 108
byte 1 108
byte 1 32
byte 1 110
byte 1 101
byte 1 118
byte 1 101
byte 1 114
byte 1 10
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 32
byte 1 119
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 97
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 82
byte 1 101
byte 1 97
byte 1 108
byte 1 109
byte 1 32
byte 1 111
byte 1 102
byte 1 10
byte 1 66
byte 1 108
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 77
byte 1 97
byte 1 103
byte 1 105
byte 1 99
byte 1 44
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 78
byte 1 101
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 44
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 10
byte 1 69
byte 1 108
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 87
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 33
byte 1 0
align 1
LABELV $655
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
LABELV $652
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 101
byte 1 49
byte 1 109
byte 1 55
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $646
byte 1 69
byte 1 120
byte 1 105
byte 1 116
byte 1 32
byte 1 73
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $643
byte 1 69
byte 1 120
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 46
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $637
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 32
byte 1 37
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 112
byte 1 37
byte 1 100
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $636
byte 1 113
byte 1 119
byte 1 109
byte 1 99
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $635
byte 1 99
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 100
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $634
byte 1 99
byte 1 100
byte 1 0
align 1
LABELV $633
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
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $632
byte 1 110
byte 1 0
align 1
LABELV $596
byte 1 70
byte 1 105
byte 1 110
byte 1 100
byte 1 73
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 115
byte 1 112
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $588
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
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $585
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
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $582
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $579
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 119
byte 1 112
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $523
byte 1 109
byte 1 116
byte 1 102
byte 1 108
byte 1 0
align 1
LABELV $516
byte 1 112
byte 1 121
byte 1 114
byte 1 111
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $507
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 95
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $506
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $498
byte 1 102
byte 1 102
byte 1 97
byte 1 0
align 1
LABELV $494
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 0
align 1
LABELV $490
byte 1 111
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $489
byte 1 111
byte 1 108
byte 1 100
byte 1 95
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $484
byte 1 97
byte 1 105
byte 1 114
byte 1 115
byte 1 99
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $479
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 51
byte 1 0
align 1
LABELV $474
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 50
byte 1 0
align 1
LABELV $469
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 49
byte 1 0
align 1
LABELV $465
byte 1 111
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $464
byte 1 111
byte 1 108
byte 1 100
byte 1 95
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $459
byte 1 102
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $458
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $453
byte 1 109
byte 1 117
byte 1 0
align 1
LABELV $452
byte 1 116
byte 1 102
byte 1 95
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 0
align 1
LABELV $447
byte 1 99
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $446
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 101
byte 1 100
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $442
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 95
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $439
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 95
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $438
byte 1 116
byte 1 103
byte 1 0
align 1
LABELV $434
byte 1 108
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $430
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $429
byte 1 114
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $424
byte 1 103
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $418
byte 1 115
byte 1 110
byte 1 105
byte 1 112
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $412
byte 1 115
byte 1 110
byte 1 105
byte 1 112
byte 1 95
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $407
byte 1 115
byte 1 110
byte 1 105
byte 1 112
byte 1 95
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 95
byte 1 102
byte 1 105
byte 1 120
byte 1 0
align 1
LABELV $406
byte 1 115
byte 1 114
byte 1 102
byte 1 0
align 1
LABELV $401
byte 1 115
byte 1 110
byte 1 105
byte 1 112
byte 1 95
byte 1 102
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $400
byte 1 115
byte 1 102
byte 1 0
align 1
LABELV $395
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $394
byte 1 102
byte 1 116
byte 1 0
align 1
LABELV $390
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 95
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $389
byte 1 100
byte 1 112
byte 1 0
align 1
LABELV $384
byte 1 100
byte 1 116
byte 1 112
byte 1 98
byte 1 0
align 1
LABELV $383
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 95
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $382
byte 1 100
byte 1 103
byte 1 0
align 1
LABELV $376
byte 1 115
byte 1 103
byte 1 112
byte 1 112
byte 1 108
byte 1 0
align 1
LABELV $370
byte 1 115
byte 1 103
byte 1 95
byte 1 114
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $368
byte 1 109
byte 1 116
byte 1 102
byte 1 108
byte 1 50
byte 1 0
align 1
LABELV $364
byte 1 109
byte 1 116
byte 1 102
byte 1 108
byte 1 49
byte 1 0
align 1
LABELV $358
byte 1 115
byte 1 103
byte 1 95
byte 1 115
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $353
byte 1 115
byte 1 103
byte 1 95
byte 1 110
byte 1 101
byte 1 119
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $350
byte 1 111
byte 1 108
byte 1 100
byte 1 102
byte 1 0
align 1
LABELV $345
byte 1 109
byte 1 116
byte 1 102
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $340
byte 1 111
byte 1 108
byte 1 100
byte 1 109
byte 1 116
byte 1 102
byte 1 108
byte 1 0
align 1
LABELV $335
byte 1 102
byte 1 105
byte 1 120
byte 1 0
align 1
LABELV $330
byte 1 111
byte 1 108
byte 1 100
byte 1 0
align 1
LABELV $327
byte 1 110
byte 1 101
byte 1 119
byte 1 0
align 1
LABELV $326
byte 1 115
byte 1 103
byte 1 0
align 1
LABELV $323
byte 1 110
byte 1 101
byte 1 119
byte 1 95
byte 1 103
byte 1 97
byte 1 115
byte 1 0
align 1
LABELV $317
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 95
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $312
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $307
byte 1 110
byte 1 101
byte 1 119
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $306
byte 1 110
byte 1 102
byte 1 0
align 1
LABELV $301
byte 1 97
byte 1 100
byte 1 100
byte 1 95
byte 1 112
byte 1 105
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $296
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 95
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 95
byte 1 103
byte 1 111
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $295
byte 1 97
byte 1 100
byte 1 103
byte 1 0
align 1
LABELV $288
byte 1 116
byte 1 99
byte 1 52
byte 1 0
align 1
LABELV $280
byte 1 116
byte 1 99
byte 1 51
byte 1 0
align 1
LABELV $272
byte 1 116
byte 1 99
byte 1 50
byte 1 0
align 1
LABELV $264
byte 1 116
byte 1 99
byte 1 49
byte 1 0
align 1
LABELV $257
byte 1 99
byte 1 112
byte 1 0
align 1
LABELV $248
byte 1 115
byte 1 112
byte 1 121
byte 1 105
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 0
align 1
LABELV $247
byte 1 115
byte 1 0
align 1
LABELV $243
byte 1 115
byte 1 112
byte 1 121
byte 1 0
align 1
LABELV $239
byte 1 111
byte 1 108
byte 1 100
byte 1 95
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $238
byte 1 111
byte 1 108
byte 1 100
byte 1 95
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $237
byte 1 111
byte 1 103
byte 1 0
align 1
LABELV $228
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $227
byte 1 103
byte 1 0
align 1
LABELV $222
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $221
byte 1 116
byte 1 0
align 1
LABELV $220
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 95
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $219
byte 1 97
byte 1 107
byte 1 107
byte 1 0
align 1
LABELV $214
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $213
byte 1 97
byte 1 107
byte 1 116
byte 1 0
align 1
LABELV $205
byte 1 0
align 1
LABELV $204
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $203
byte 1 97
byte 1 0
align 1
LABELV $202
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $201
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $194
byte 1 99
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $190
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $189
byte 1 67
byte 1 69
byte 1 65
byte 1 83
byte 1 69
byte 1 32
byte 1 70
byte 1 73
byte 1 82
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $174
byte 1 99
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $173
byte 1 99
byte 1 102
byte 1 116
byte 1 0
align 1
LABELV $163
byte 1 112
byte 1 114
byte 1 101
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $162
byte 1 112
byte 1 109
byte 1 0
align 1
LABELV $157
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $156
byte 1 108
byte 1 103
byte 1 0
align 1
LABELV $150
byte 1 99
byte 1 108
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $149
byte 1 99
byte 1 0
align 1
LABELV $145
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $142
byte 1 111
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $141
byte 1 98
byte 1 105
byte 1 114
byte 1 116
byte 1 104
byte 1 100
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $140
byte 1 98
byte 1 100
byte 1 0
align 1
LABELV $139
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 49
byte 1 0
align 1
LABELV $126
byte 1 77
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $107
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
byte 1 49
byte 1 0
align 1
LABELV $103
byte 1 50
byte 1 49
byte 1 63
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 70
byte 1 111
byte 1 114
byte 1 116
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $102
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $97
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 116
byte 1 102
byte 1 100
byte 1 101
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $87
byte 1 116
byte 1 111
byte 1 103
byte 1 103
byte 1 108
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $86
byte 1 33
byte 1 33
byte 1 33
byte 1 66
byte 1 85
byte 1 71
byte 1 32
byte 1 66
byte 1 85
byte 1 71
byte 1 32
byte 1 66
byte 1 85
byte 1 71
byte 1 33
byte 1 33
byte 1 33
byte 1 10
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 95
byte 1 100
byte 1 101
byte 1 99
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 33
byte 1 61
byte 1 32
byte 1 48
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 33
byte 1 33
byte 1 33
byte 1 66
byte 1 85
byte 1 71
byte 1 32
byte 1 66
byte 1 85
byte 1 71
byte 1 32
byte 1 66
byte 1 85
byte 1 71
byte 1 33
byte 1 33
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $65
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 46
byte 1 98
byte 1 115
byte 1 112
byte 1 0
