export TeamFortress_SniperWeapon
code
proc TeamFortress_SniperWeapon 8 12
file "..\src\sniper.c"
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
;21: *  $Id: sniper.c,v 1.4 2005/05/16 06:31:38 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:void	AirStrike_Target ( vec3_t org );
;26:void    SniperSight_Update(  );
;27:
;28://=========================================================================
;29:// Sniper/Auto Rifle selection function
;30:void TeamFortress_SniperWeapon(  )
;31:{
line 33
;32:
;33:	self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 34
;34:	if ( self->tfstate & TFSTATE_RELOADING )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $12
line 35
;35:		return;
ADDRGP4 $11
JUMPV
LABELV $12
line 36
;36:	if ( !( ( self->weapons_carried & WEAP_SNIPER_RIFLE ) && ( self->weapons_carried & WEAP_AUTO_RIFLE ) ) )
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 1028
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
BANDI4
ADDRLP4 4
INDIRI4
EQI4 $16
ADDRLP4 0
INDIRI4
CNSTI4 64
BANDI4
ADDRLP4 4
INDIRI4
NEI4 $14
LABELV $16
line 37
;37:		return;
ADDRGP4 $11
JUMPV
LABELV $14
line 38
;38:	if ( self->s.v.ammo_shells < 1 )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1065353216
GEF4 $17
line 39
;39:	{
line 40
;40:		G_sprint( self, 2, "not enough ammo.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $19
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 41
;41:		return;
ADDRGP4 $11
JUMPV
LABELV $17
line 43
;42:	}
;43:	if ( self->current_weapon == WEAP_SNIPER_RIFLE )
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 32
NEI4 $20
line 44
;44:		self->current_weapon = WEAP_AUTO_RIFLE;
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 64
ASGNI4
ADDRGP4 $21
JUMPV
LABELV $20
line 46
;45:	else
;46:		self->current_weapon = WEAP_SNIPER_RIFLE;
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 32
ASGNI4
LABELV $21
line 47
;47:	W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 48
;48:}
LABELV $11
endproc TeamFortress_SniperWeapon 8 12
export TF_zoom
proc TF_zoom 0 12
line 53
;49:
;50://=========================================================================
;51:// Do the autozoom of the sniper rifle
;52:void TF_zoom( int zoom_level )
;53:{
line 55
;54:
;55:	if ( self->tfstate & TFSTATE_ZOOMOFF )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $23
line 56
;56:		return;
ADDRGP4 $22
JUMPV
LABELV $23
line 57
;57:	stuffcmd( self, "fov %d\n", zoom_level );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $25
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 stuffcmd
CALLV
pop
line 58
;58:}
LABELV $22
endproc TF_zoom 0 12
export SniperSight_Update
proc SniperSight_Update 68 32
line 63
;59:
;60://=========================================================================
;61:// Move the sight to the point the rifle's aiming at
;62:void SniperSight_Update(  )
;63:{
line 65
;64:	vec3_t  org, end, t_one, t_two;
;65:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 67
;66:
;67:	if ( !( owner->tfstate & TFSTATE_AIMING ) || owner->current_weapon != 32 )
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $29
ADDRLP4 0
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CNSTI4 32
EQI4 $27
LABELV $29
line 68
;68:	{
line 69
;69:		owner->tfstate -= ( owner->tfstate & TFSTATE_AIMING );
ADDRLP4 56
ADDRLP4 0
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 60
ADDRLP4 56
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 56
INDIRP4
ADDRLP4 60
INDIRI4
ADDRLP4 60
INDIRI4
CNSTI4 2048
BANDI4
SUBI4
ASGNI4
line 70
;70:		TeamFortress_SetSpeed( owner );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 71
;71:		owner->heat = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1076
ADDP4
CNSTF4 0
ASGNF4
line 72
;72:		dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 73
;73:		return;
ADDRGP4 $26
JUMPV
LABELV $27
line 75
;74:	}
;75:	makevectors( owner->s.v.v_angle );
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 76
;76:	org[0] = owner->s.v.origin[0] + g_globalvars.v_forward[0] * 10;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
CNSTF4 1092616192
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
ADDF4
ASGNF4
line 77
;77:	org[1] = owner->s.v.origin[1] + g_globalvars.v_forward[1] * 10;
ADDRLP4 16+4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
CNSTF4 1092616192
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 78
;78:	org[2] = owner->s.v.absmin[2] + owner->s.v.size[2] * 0.7;
ADDRLP4 16+8
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CNSTF4 1060320051
ADDRLP4 0
INDIRP4
CNSTI4 268
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 80
;79:
;80:	VectorScale( g_globalvars.v_forward, 9192, end );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1175429120
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 81
;81:	VectorAdd( end, org, end );
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 16
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 16+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 16+8
INDIRF4
ADDF4
ASGNF4
line 82
;82:	traceline( PASSVEC3( org ), PASSVEC3( end ), 0, self );
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16+4
INDIRF4
ARGF4
ADDRLP4 16+8
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4+4
INDIRF4
ARGF4
ADDRLP4 4+8
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
line 83
;83:	if ( g_globalvars.trace_fraction == 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
NEF4 $46
line 84
;84:	{
line 85
;85:		setorigin( self, PASSVEC3( owner->s.v.origin ) );
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
line 86
;86:		return;
ADDRGP4 $26
JUMPV
LABELV $46
line 88
;87:	}
;88:	vectoangles( g_globalvars.v_forward, self->s.v.angles );
ADDRGP4 g_globalvars+228
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 89
;89:	setorigin( self, PASSVEC3( g_globalvars.trace_endpos ) );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 g_globalvars+276
INDIRF4
ARGF4
ADDRGP4 g_globalvars+276+4
INDIRF4
ARGF4
ADDRGP4 g_globalvars+276+8
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 91
;90:	// airstrike!
;91:	if ( owner->option == 9 ) {
ADDRLP4 0
INDIRP4
CNSTI4 1780
ADDP4
INDIRI4
CNSTI4 9
NEI4 $55
line 92
;92:		t_one[0] = self->s.v.origin[0];t_one[1] = self->s.v.origin[1];t_one[2] = self->s.v.origin[2] + 5;
ADDRLP4 28
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 28+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 28+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 93
;93:		t_two[0] = self->s.v.origin[0];t_two[1] = self->s.v.origin[1];t_two[2] = self->s.v.origin[2] + 2048;
ADDRLP4 40
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 40+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 40+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1157627904
ADDF4
ASGNF4
line 94
;94:		traceline( PASSVEC3( t_one ), PASSVEC3( t_two ), 0, self);
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28+4
INDIRF4
ARGF4
ADDRLP4 28+8
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40+4
INDIRF4
ARGF4
ADDRLP4 40+8
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
line 95
;95:		if ( trap_pointcontents( PASSVEC3( g_globalvars.trace_endpos ) ) == CONTENT_SKY ) {
ADDRGP4 g_globalvars+276
INDIRF4
ARGF4
ADDRGP4 g_globalvars+276+4
INDIRF4
ARGF4
ADDRGP4 g_globalvars+276+8
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 -6
NEI4 $65
line 96
;96:			if ( owner->last_used > g_globalvars.time ) {
ADDRLP4 0
INDIRP4
CNSTI4 1772
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $72
line 97
;97:				G_sprint( owner, 2, "Reinforcements not in attack position yet... wait 2 minutes\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $75
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 98
;98:				owner->option = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1780
ADDP4
CNSTI4 0
ASGNI4
line 99
;99:			}
ADDRGP4 $66
JUMPV
LABELV $72
line 100
;100:			else {
line 101
;101:				sound( owner, 0, "weapons/radioair.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $76
ARGP4
ADDRLP4 64
CNSTF4 1065353216
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 102
;102:				owner->last_used = ( g_globalvars.time + 120 );
ADDRLP4 0
INDIRP4
CNSTI4 1772
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1123024896
ADDF4
CVFI4 4
ASGNI4
line 103
;103:				owner->option = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1780
ADDP4
CNSTI4 0
ASGNI4
line 104
;104:				AirStrike_Target( t_one );
ADDRLP4 28
ARGP4
ADDRGP4 AirStrike_Target
CALLV
pop
line 105
;105:			}
line 106
;106:		}
ADDRGP4 $66
JUMPV
LABELV $65
line 107
;107:		else {
line 108
;108:			G_sprint( owner, 2, "Target NOT visible from air!\n" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $78
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 109
;109:			if ( owner->last_saveme_sound < g_globalvars.time ) {
ADDRLP4 0
INDIRP4
CNSTI4 1084
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $79
line 110
;110:				sound( owner, 0, "weapons/notarget.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $82
ARGP4
ADDRLP4 64
CNSTF4 1065353216
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 111
;111:				owner->last_saveme_sound = ( g_globalvars.time + 3 );
ADDRLP4 0
INDIRP4
CNSTI4 1084
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1077936128
ADDF4
ASGNF4
line 112
;112:			}
LABELV $79
line 113
;113:			owner->option = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1780
ADDP4
CNSTI4 0
ASGNI4
line 114
;114:		}
LABELV $66
line 115
;115:	}
LABELV $55
line 116
;116:	self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 117
;117:}
LABELV $26
endproc SniperSight_Update 68 32
export SniperSight_Create
proc SniperSight_Create 16 16
line 122
;118:
;119://=========================================================================
;120:// Create the sight
;121:void SniperSight_Create(  )
;122:{
line 125
;123:	gedict_t *sight;
;124:
;125:	if ( self->has_disconnected == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 1
NEI4 $86
line 126
;126:		return;
ADDRGP4 $85
JUMPV
LABELV $86
line 127
;127:	self->tfstate |= TFSTATE_AIMING;
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 128
;128:	sight = spawn(  );
ADDRLP4 8
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 129
;129:	sight->s.v.owner = EDICT_TO_PROG( self );
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
line 130
;130:	sight->s.v.movetype = MOVETYPE_NOCLIP;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1090519040
ASGNF4
line 131
;131:	sight->s.v.solid = SOLID_NOT;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 133
;132://	setmodel( sight, "progs/sight.spr" );
;133:	if ( self->option4 != 1 )
ADDRGP4 self
INDIRP4
CNSTI4 1784
ADDP4
INDIRI4
CNSTI4 1
EQI4 $88
line 134
;134:	{
line 135
;135:		if ( self->team_no == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 1
NEI4 $90
line 136
;136:		{
line 137
;137:			setmodel ( sight, "progs/dot1.spr" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $92
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 138
;138:		}
ADDRGP4 $91
JUMPV
LABELV $90
line 140
;139:		else
;140:		{
line 141
;141:			if ( self->team_no == 3 )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 3
NEI4 $93
line 142
;142:			{
line 143
;143:				setmodel ( sight, "progs/dot3.spr" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $95
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 144
;144:			}
ADDRGP4 $94
JUMPV
LABELV $93
line 146
;145:			else
;146:			{
line 147
;147:				if ( self->team_no == 4 )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 4
NEI4 $96
line 148
;148:				{
line 149
;149:					setmodel ( sight, "progs/dot4.spr" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $98
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 150
;150:				}
ADDRGP4 $97
JUMPV
LABELV $96
line 152
;151:				else
;152:				{
line 153
;153:					setmodel ( sight, "progs/dot2.spr" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $99
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 154
;154:				}
LABELV $97
line 155
;155:			}
LABELV $94
line 156
;156:		}
LABELV $91
line 157
;157:	}
LABELV $88
line 158
;158:	sight->s.v.classname = "timer";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $100
ASGNP4
line 159
;159:	setorigin( sight, PASSVEC3( self->s.v.origin ) );
ADDRLP4 0
INDIRP4
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
ADDRGP4 setorigin
CALLV
pop
line 160
;160:	sight->s.v.think = ( func_t ) SniperSight_Update;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SniperSight_Update
CVPU4 4
CVUI4 4
ASGNI4
line 161
;161:	sight->s.v.nextthink = g_globalvars.time + 0.05;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1028443341
ADDF4
ASGNF4
line 162
;162:}
LABELV $85
endproc SniperSight_Create 16 16
export TeamFortress_AutoZoomToggle
proc TeamFortress_AutoZoomToggle 4 12
line 166
;163:
;164:// this toggles the snipers autozoom on/off
;165:void TeamFortress_AutoZoomToggle(  )
;166:{
line 167
;167:	if ( self->tfstate & TFSTATE_ZOOMOFF )
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $103
line 168
;168:	{
line 169
;169:		self->tfstate = self->tfstate - TFSTATE_ZOOMOFF;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 4096
SUBI4
ASGNI4
line 170
;170:		G_sprint( self, 2, "autozoom ON\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $105
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 171
;171:	} else
ADDRGP4 $104
JUMPV
LABELV $103
line 172
;172:	{
line 173
;173:		self->tfstate = self->tfstate | TFSTATE_ZOOMOFF;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 174
;174:		G_sprint( self, 2, "autozoom OFF\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $106
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 175
;175:	}
LABELV $104
line 176
;176:}
LABELV $102
endproc TeamFortress_AutoZoomToggle 4 12
import AirStrike_Target
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
import TeamFortress_ReloadCurrentWeapon
import TeamFortress_DetonatePipebombs
import TeamFortress_Discard
import TeamFortress_ThrowGrenade
import TeamFortress_PrimeGrenade
import TeamFortress_FlameThrower
import TeamFortress_IncendiaryCannon
import TeamFortress_AssaultWeapon
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
LABELV $106
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 10
byte 1 0
align 1
LABELV $105
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 32
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $100
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $99
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 100
byte 1 111
byte 1 116
byte 1 50
byte 1 46
byte 1 115
byte 1 112
byte 1 114
byte 1 0
align 1
LABELV $98
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 100
byte 1 111
byte 1 116
byte 1 52
byte 1 46
byte 1 115
byte 1 112
byte 1 114
byte 1 0
align 1
LABELV $95
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 100
byte 1 111
byte 1 116
byte 1 51
byte 1 46
byte 1 115
byte 1 112
byte 1 114
byte 1 0
align 1
LABELV $92
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 100
byte 1 111
byte 1 116
byte 1 49
byte 1 46
byte 1 115
byte 1 112
byte 1 114
byte 1 0
align 1
LABELV $82
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 111
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $78
byte 1 84
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 78
byte 1 79
byte 1 84
byte 1 32
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 97
byte 1 105
byte 1 114
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $76
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
byte 1 100
byte 1 105
byte 1 111
byte 1 97
byte 1 105
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $75
byte 1 82
byte 1 101
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 112
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 121
byte 1 101
byte 1 116
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 32
byte 1 50
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $25
byte 1 102
byte 1 111
byte 1 118
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $19
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 111
byte 1 117
byte 1 103
byte 1 104
byte 1 32
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 46
byte 1 10
byte 1 0
