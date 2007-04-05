export Drone
code
proc Drone 56 28
file "..\src\megatf\mtf_engineer.c"
line 31
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
;21: *  $Id: mtf_engineer.c,v 1.00 2006/09/15 XavioR Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:// MegaTF engineer functions
;26:void	DroneDie();
;27:void	DroneJet();
;28:void	BalloonMIRVtouch();
;29:// Laser Drone (drop3)
;30:void Drone ( )
;31:{
line 34
;32:	vec3_t set_org;
;33:
;34:	if ( self->no_grenades_1 < 1 || self->s.v.ammo_cells < 100 ) {
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 840
ADDP4
INDIRI4
CNSTI4 1
LTI4 $14
ADDRLP4 12
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1120403456
GEF4 $12
LABELV $14
line 35
;35:		G_sprint( self, 2, "You need 1 Normal Grenade & 100 Armor\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $15
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 36
;36:		return;
ADDRGP4 $11
JUMPV
LABELV $12
line 38
;37:	}
;38:	if ( self->last_used > g_globalvars.time ) {
ADDRGP4 self
INDIRP4
CNSTI4 1772
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 g_globalvars+124
INDIRF4
LEF4 $16
line 39
;39:		G_sprint( self, 2, "Not finished building new drone yet... takes 3 minutes\n" );
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
line 40
;40:		return;
ADDRGP4 $11
JUMPV
LABELV $16
line 43
;41:	}
;42:
;43:	G_sprint ( self, 2, "Laser Drone away!\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $20
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 44
;44:	self->last_used = g_globalvars.time + 180;
ADDRGP4 self
INDIRP4
CNSTI4 1772
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1127481344
ADDF4
CVFI4 4
ASGNI4
line 45
;45:	self->no_grenades_1 -= 1;
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 840
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 46
;46:	self->s.v.ammo_cells -= 100;
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 47
;47:	newmis = spawn (  );
ADDRLP4 24
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 24
INDIRP4
ASGNP4
line 48
;48:	newmis->s.v.owner = EDICT_TO_PROG( self );
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
line 49
;49:	newmis->s.v.weapon = 41;
ADDRGP4 newmis
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1109655552
ASGNF4
line 50
;50:	newmis->s.v.movetype = MOVETYPE_FLYMISSILE;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1091567616
ASGNF4
line 51
;51:	newmis->s.v.solid = SOLID_BBOX;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 52
;52:	newmis->s.v.classname = "bot";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $22
ASGNP4
line 53
;53:	newmis->team_no = self->team_no;
ADDRLP4 28
CNSTI4 960
ASGNI4
ADDRGP4 newmis
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
line 55
;54:
;55:	makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 56
;56:	if ( self->s.v.v_angle[0] ) {
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
INDIRF4
CNSTF4 0
EQF4 $23
line 57
;57:		newmis->s.v.velocity[0] =
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1128792064
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
ASGNF4
line 59
;58:			g_globalvars.v_forward[0] * 200;
;59:		newmis->s.v.velocity[1] =
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1128792064
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
ASGNF4
line 61
;60:			g_globalvars.v_forward[1] * 200;
;61:		newmis->s.v.velocity[2] =
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1128792064
ADDRGP4 g_globalvars+228+8
INDIRF4
MULF4
ASGNF4
line 63
;62:			g_globalvars.v_forward[2] * 200;
;63:	}
ADDRGP4 $24
JUMPV
LABELV $23
line 64
;64:	else {
line 65
;65:		aim( newmis->s.v.velocity );
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 aim
CALLV
pop
line 67
;66:
;67:		newmis->s.v.velocity[0] =
ADDRLP4 32
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTF4 1128792064
ADDRLP4 32
INDIRP4
INDIRF4
MULF4
ASGNF4
line 69
;68:			newmis->s.v.velocity[0] * 200;
;69:		newmis->s.v.velocity[1] =
ADDRLP4 36
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTF4 1128792064
ADDRLP4 36
INDIRP4
INDIRF4
MULF4
ASGNF4
line 71
;70:			newmis->s.v.velocity[1] * 200;
;71:		newmis->s.v.velocity[2] =
ADDRLP4 40
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTF4 1128792064
ADDRLP4 40
INDIRP4
INDIRF4
MULF4
ASGNF4
line 73
;72:			newmis->s.v.velocity[2] * 200;
;73:	}
LABELV $24
line 75
;74:
;75:	newmis->option= 1;
ADDRGP4 newmis
INDIRP4
CNSTI4 1780
ADDP4
CNSTI4 1
ASGNI4
line 76
;76:	newmis->s.v.health = 30;
ADDRGP4 newmis
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1106247680
ASGNF4
line 77
;77:	newmis->s.v.takedamage = 2;
ADDRGP4 newmis
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 1073741824
ASGNF4
line 78
;78:	newmis->th_die = DroneDie;
ADDRGP4 newmis
INDIRP4
CNSTI4 812
ADDP4
ADDRGP4 DroneDie
ASGNP4
line 79
;79:	setsize( newmis, -8, -8, -8, 12, 12, 12 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 32
CNSTF4 3238002688
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
ADDRLP4 36
CNSTF4 1094713344
ASGNF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 82
;80:
;81:	// do origin work
;82:	set_org[0] =
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
CNSTF4 1090519040
ADDRGP4 g_globalvars+228
INDIRF4
MULF4
ADDF4
CNSTF4 0
ADDF4
ASGNF4
line 84
;83:		( self->s.v.origin[0] + ( g_globalvars.v_forward[0] * 8 ) ) + 0;
;84:	set_org[1] =
ADDRLP4 0+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
CNSTF4 1090519040
ADDRGP4 g_globalvars+228+4
INDIRF4
MULF4
ADDF4
CNSTF4 0
ADDF4
ASGNF4
line 86
;85:		( self->s.v.origin[1] + ( g_globalvars.v_forward[1] * 8 ) ) + 0;
;86:	set_org[2] =
ADDRLP4 0+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1090519040
ADDRGP4 g_globalvars+228+8
INDIRF4
MULF4
ADDF4
CNSTF4 1101004800
ADDF4
ASGNF4
line 89
;87:		( self->s.v.origin[2] + ( g_globalvars.v_forward[2] * 8 ) ) + 20;
;88://	setorigin( newmis, ( ( self->s.v.origin + ( v_forward * 8 ) ) + '0 0 20' ) );
;89:	setorigin( newmis, PASSVEC3( set_org ) );
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
line 91
;90:
;91:	newmis->s.v.angles[0] = self->s.v.angles[0];
ADDRLP4 40
CNSTI4 192
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 92
;92:	newmis->s.v.angles[1] = self->s.v.angles[1];
ADDRLP4 44
CNSTI4 196
ASGNI4
ADDRGP4 newmis
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
line 93
;93:	newmis->s.v.angles[2] = self->s.v.angles[2];
ADDRLP4 48
CNSTI4 200
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 94
;94:	sound ( newmis, 0, "weapons/chngnu1a.wav", 1, 1 );
ADDRGP4 newmis
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $39
ARGP4
ADDRLP4 52
CNSTF4 1065353216
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 95
;95:	newmis->s.v.nextthink = g_globalvars.time + 0.8;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1061997773
ADDF4
ASGNF4
line 96
;96:	newmis->playerclass = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 820
ADDP4
CNSTI4 0
ASGNI4
line 97
;97:	newmis->s.v.think = ( func_t ) DroneJet;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 DroneJet
CVPU4 4
CVUI4 4
ASGNI4
line 98
;98:	newmis->s.v.touch = ( func_t ) BalloonMIRVtouch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 BalloonMIRVtouch
CVPU4 4
CVUI4 4
ASGNI4
line 99
;99:	newmis->s.v.skin = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 0
ASGNF4
line 100
;100:	setmodel( newmis, "progs/lsrdrone.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $41
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 101
;101:}
LABELV $11
endproc Drone 56 28
export Drone_Laser_Touch
proc Drone_Laser_Touch 36 20
line 104
;102:
;103:void Drone_Laser_Touch ( )
;104:{
line 107
;105:	//float deflect;
;106:	vec3_t org, vtemp;
;107:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 24
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 109
;108:
;109:	if ( other == owner )
ADDRGP4 other
INDIRP4
CVPU4 4
ADDRLP4 24
INDIRP4
CVPU4 4
NEU4 $43
line 110
;110:		return;
ADDRGP4 $42
JUMPV
LABELV $43
line 111
;111:	if ( trap_pointcontents( PASSVEC3( self->s.v.origin ) ) == CONTENT_SKY ) {
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 -6
NEI4 $45
line 112
;112:		dremove ( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 113
;113:		return;
ADDRGP4 $42
JUMPV
LABELV $45
line 123
;114:	}
;115://	if ( ( other->s.v.playerclass == 7 ) )
;116://	{
;117://		deflect = hwguy_deflect ( other );
;118://		if ( deflect )
;119://		{
;120://			return;
;121://		}
;122://	}
;123:	sound( self, 1, "enforcer/enfstop.wav", 1, 3 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $47
ARGP4
CNSTF4 1065353216
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 sound
CALLV
pop
line 124
;124:	normalize( self->s.v.velocity, vtemp );
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
line 125
;125:	org[0] =
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
CNSTF4 1090519040
ADDRLP4 0
INDIRF4
MULF4
SUBF4
ASGNF4
line 127
;126:		self->s.v.origin[0] - ( 8 * vtemp[0] );
;127:	org[1] =
ADDRLP4 12+4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
CNSTF4 1090519040
ADDRLP4 0+4
INDIRF4
MULF4
SUBF4
ASGNF4
line 129
;128:		self->s.v.origin[0] - ( 8 * vtemp[1] );
;129:	org[2] =
ADDRLP4 12+8
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
CNSTF4 1090519040
ADDRLP4 0+8
INDIRF4
MULF4
SUBF4
ASGNF4
line 132
;130:		self->s.v.origin[0] - ( 8 * vtemp[2] );
;131:	//org = ( self->s.v.origin - ( 8 * normalize ( self->s.v.velocity ) ) );
;132:	if ( other->s.v.health ) {
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
EQF4 $52
line 133
;133:		SpawnBlood ( org, 15 );
ADDRLP4 12
ARGP4
CNSTF4 1097859072
ARGF4
ADDRGP4 SpawnBlood
CALLV
pop
line 134
;134:		mtf_deathmsg( 41 );
CNSTF4 1109655552
ARGF4
ADDRGP4 mtf_deathmsg
CALLV
pop
line 135
;135:		self->s.v.weapon = 41;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1109655552
ASGNF4
line 136
;136:		if ( other->s.v.classname == "building_sentrygun" )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 $56
CVPU4 4
NEU4 $54
line 137
;137:			T_RadiusDamage ( self, PROG_TO_EDICT( owner->s.v.owner ), 90, world );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTF4 1119092736
ARGF4
ADDRGP4 world
INDIRP4
ARGP4
ADDRGP4 T_RadiusDamage
CALLV
pop
ADDRGP4 $55
JUMPV
LABELV $54
line 139
;138:		else
;139:			T_Damage ( other, self, PROG_TO_EDICT( owner->s.v.owner ), 25 );
ADDRGP4 other
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTF4 1103626240
ARGF4
ADDRGP4 T_Damage
CALLV
pop
LABELV $55
line 140
;140:	}
LABELV $52
line 141
;141:	dremove ( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 142
;142:}
LABELV $42
endproc Drone_Laser_Touch 36 20
export DroneLaunchLaser
proc DroneLaunchLaser 32 28
line 145
;143:
;144:void DroneLaunchLaser ( vec3_t org, vec3_t vec )
;145:{
line 146
;146:	gedict_t *owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 148
;147:
;148:	sound( self, 1, "enforcer/enfire.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $58
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
line 149
;149:	normalize ( vec, vec );
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
line 150
;150:	newmis = spawn (  );
ADDRLP4 12
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 12
INDIRP4
ASGNP4
line 151
;151:	newmis->s.v.owner = EDICT_TO_PROG( self );
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
line 152
;152:	newmis->team_no = self->team_no;
ADDRLP4 16
CNSTI4 960
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
INDIRI4
ASGNI4
line 153
;153:	newmis->s.v.movetype = MOVETYPE_FLY;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1084227584
ASGNF4
line 154
;154:	newmis->s.v.solid = SOLID_BBOX;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 155
;155:	newmis->s.v.effects = EF_DIMLIGHT;
ADDRGP4 newmis
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1090519040
ASGNF4
line 156
;156:	newmis->s.v.weapon = 41;
ADDRGP4 newmis
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1109655552
ASGNF4
line 157
;157:	newmis->s.v.classname = "drone_laser";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $59
ASGNP4
line 158
;158:	newmis->s.v.skin = ( owner->team_no - 1 );
ADDRGP4 newmis
INDIRP4
CNSTI4 228
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 1
SUBI4
CVIF4 4
ASGNF4
line 159
;159:	setmodel( newmis, "progs/beam.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $60
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 160
;160:	setsize( newmis, 0, 0, 0, 0, 0, 0 );
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
line 161
;161:	setorigin ( newmis, PASSVEC3( org ) );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 163
;162:
;163:	newmis->s.v.velocity[0] =
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 1157234688
ADDRFP4 4
INDIRP4
INDIRF4
MULF4
ASGNF4
line 165
;164:		vec[0] * 2000;
;165:	newmis->s.v.velocity[1] =
ADDRGP4 newmis
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 1157234688
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ASGNF4
line 167
;166:		vec[1] * 2000;
;167:	newmis->s.v.velocity[2] =
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1157234688
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ASGNF4
line 170
;168:		vec[2] * 2000;
;169:	//newmis->s.v.velocity = ( vec * 2000 );
;170:	vectoangles( newmis->s.v.velocity, newmis->s.v.angles );
ADDRLP4 28
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 171
;171:	newmis->s.v.nextthink = g_globalvars.time + 4;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1082130432
ADDF4
ASGNF4
line 172
;172:	newmis->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 173
;173:	newmis->s.v.touch = ( func_t ) Drone_Laser_Touch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 Drone_Laser_Touch
CVPU4 4
CVUI4 4
ASGNI4
line 174
;174:}
LABELV $57
endproc DroneLaunchLaser 32 28
export DroneDoneTouch
proc DroneDoneTouch 4 20
line 177
;175:
;176:void DroneDoneTouch ( )
;177:{
line 178
;178:	if ( self->s.v.velocity[2] )
ADDRGP4 self
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
CNSTF4 0
EQF4 $63
line 179
;179:		sound ( self, 1, "weapons/bounce.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $65
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
LABELV $63
line 180
;180:}
LABELV $62
endproc DroneDoneTouch 4 20
export DroneDie
proc DroneDie 4 16
line 183
;181:
;182:void DroneDie ( )
;183:{
line 184
;184:	ThrowGib( "progs/tgib2.mdl", -70 );
ADDRGP4 $67
ARGP4
CNSTF4 3263954944
ARGF4
ADDRGP4 ThrowGib
CALLV
pop
line 185
;185:	ThrowGib( "progs/dgib2.mdl", -70 );
ADDRGP4 $68
ARGP4
CNSTF4 3263954944
ARGF4
ADDRGP4 ThrowGib
CALLV
pop
line 186
;186:	ThrowGib( "progs/dgib3.mdl", -70 );
ADDRGP4 $69
ARGP4
CNSTF4 3263954944
ARGF4
ADDRGP4 ThrowGib
CALLV
pop
line 187
;187:	trap_WriteByte( MSG_MULTICAST, 23 );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 188
;188:	trap_WriteByte( MSG_MULTICAST, 3 );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 189
;189:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
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
line 190
;190:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
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
line 191
;191:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] );
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
line 192
;192:	trap_multicast( PASSVEC3( self->s.v.origin ), MULTICAST_PHS );
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
CNSTI4 1
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 193
;193:	BecomeExplosion (  );
ADDRGP4 BecomeExplosion
CALLV
pop
line 194
;194:}
LABELV $66
endproc DroneDie 4 16
export DroneFall
proc DroneFall 12 28
line 197
;195:
;196:void DroneFall ( )
;197:{
line 198
;198:	sound( self, 0, "weapons/chngnu1a.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $39
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
line 199
;199:	self->s.v.movetype = MOVETYPE_BOUNCE;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1092616192
ASGNF4
line 200
;200:	SetVector( self->s.v.avelocity, 200, 0, 300 );
ADDRGP4 self
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 1128792064
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
CNSTF4 1133903872
ASGNF4
line 202
;201:	//self->s.v.avelocity = '200 0 300';
;202:	setsize ( self, -8, -8, -8, 8, 8, 8 );
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 4
CNSTF4 3238002688
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
CNSTF4 1090519040
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
ADDRGP4 setsize
CALLV
pop
line 203
;203:	self->s.v.takedamage = 2;
ADDRGP4 self
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 1073741824
ASGNF4
line 204
;204:	self->s.v.skin = 1;
ADDRGP4 self
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 1065353216
ASGNF4
line 205
;205:	self->th_die = DroneDie;
ADDRGP4 self
INDIRP4
CNSTI4 812
ADDP4
ADDRGP4 DroneDie
ASGNP4
line 206
;206:	self->s.v.touch = ( func_t ) DroneDoneTouch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 DroneDoneTouch
CVPU4 4
CVUI4 4
ASGNI4
line 207
;207:	self->s.v.think = ( func_t )  DroneDie;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 DroneDie
CVPU4 4
CVUI4 4
ASGNI4
line 208
;208:	self->s.v.nextthink = g_globalvars.time + 20;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1101004800
ADDF4
ASGNF4
line 209
;209:}
LABELV $70
endproc DroneFall 12 28
export DroneJet
proc DroneJet 60 20
line 212
;210:
;211:void DroneJet ( )
;212:{
line 216
;213:	gedict_t	*te;
;214:	vec3_t		vtemp;
;215:
;216:	self->playerclass = self->playerclass + 1;
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 820
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
;217:	self->s.v.nextthink = g_globalvars.time + 0.9;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1063675494
ADDF4
ASGNF4
line 218
;218:	sound( self, 0, "weapons/drone.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 $74
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
line 219
;219:	te=world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
line 220
;220:	te = trap_find( te, FOFS( s.v.classname ), "player" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $75
ARGP4
ADDRLP4 24
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
ADDRGP4 $77
JUMPV
LABELV $76
line 222
;221:	while( te )
;222:	{
line 223
;223:		if ( self != te )
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
EQU4 $79
line 224
;224:		{
line 225
;225:			if ( te->team_no != 0 && te->team_no != self->team_no )
ADDRLP4 28
CNSTI4 960
ASGNI4
ADDRLP4 32
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $81
ADDRLP4 32
INDIRI4
ADDRGP4 self
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
EQI4 $81
line 226
;226:			{
line 227
;227:				if ( te->s.v.health )
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
EQF4 $83
line 228
;228:				{
line 229
;229:					if ( visible( te ) )
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 visible
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $85
line 230
;230:					{
line 231
;231:						if ( te->is_undercover != 1 )
ADDRLP4 0
INDIRP4
CNSTI4 868
ADDP4
INDIRI4
CNSTI4 1
EQI4 $87
line 232
;232:						{
line 233
;233:							vtemp[0] =
ADDRLP4 40
CNSTI4 156
ASGNI4
ADDRLP4 4
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 235
;234:								te->s.v.origin[0] - self->s.v.origin[0];
;235:							vtemp[1] =
ADDRLP4 44
CNSTI4 160
ASGNI4
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 237
;236:								te->s.v.origin[1] - self->s.v.origin[1];
;237:							vtemp[2] =
ADDRLP4 48
CNSTI4 164
ASGNI4
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 239
;238:								te->s.v.origin[2] - self->s.v.origin[2];
;239:							DroneLaunchLaser ( self->s.v.origin, vtemp );
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 DroneLaunchLaser
CALLV
pop
line 240
;240:						}
LABELV $87
line 241
;241:					}
LABELV $85
line 242
;242:				}
LABELV $83
line 243
;243:			}
LABELV $81
line 244
;244:		}
LABELV $79
line 245
;245:		te = trap_find( te, FOFS( s.v.classname ), "player" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $75
ARGP4
ADDRLP4 28
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 246
;246:	}
LABELV $77
line 221
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $76
line 247
;247:	te=world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
line 248
;248:	te = trap_find( te, FOFS( s.v.classname ), "building_sentrygun" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $56
ARGP4
ADDRLP4 28
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
ADDRGP4 $92
JUMPV
LABELV $91
line 250
;249:	while ( te )
;250:	{
line 251
;251:		if ( te->team_no != 0 && te->team_no != self->team_no )
ADDRLP4 32
CNSTI4 960
ASGNI4
ADDRLP4 36
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $94
ADDRLP4 36
INDIRI4
ADDRGP4 self
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
EQI4 $94
line 252
;252:		{
line 253
;253:			if ( te->s.v.health )
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
EQF4 $96
line 254
;254:			{
line 255
;255:				if ( visible( te ) )
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 visible
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $98
line 256
;256:				{
line 257
;257:					vtemp[0] =
ADDRLP4 44
CNSTI4 156
ASGNI4
ADDRLP4 4
ADDRLP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
CNSTF4 0
ADDF4
ADDRGP4 self
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 259
;258:						( te->s.v.origin[0] + 0 ) - self->s.v.origin[0];
;259:					vtemp[1] =
ADDRLP4 48
CNSTI4 160
ASGNI4
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
CNSTF4 0
ADDF4
ADDRGP4 self
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 261
;260:						( te->s.v.origin[1] + 0 ) - self->s.v.origin[1];
;261:					vtemp[2] =
ADDRLP4 52
CNSTI4 164
ASGNI4
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
CNSTF4 1103101952
ADDF4
ADDRGP4 self
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 263
;262:						( te->s.v.origin[2] + 24 ) - self->s.v.origin[2];
;263:					DroneLaunchLaser ( self->s.v.origin, vtemp );
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 DroneLaunchLaser
CALLV
pop
line 264
;264:				}
LABELV $98
line 265
;265:			}
LABELV $96
line 266
;266:		}
LABELV $94
line 267
;267:		te = trap_find( te, FOFS( s.v.classname ), "building_sentrygun" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $56
ARGP4
ADDRLP4 40
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
ASGNP4
line 268
;268:	}
LABELV $92
line 249
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $91
line 269
;269:	te=world;
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
line 270
;270:	te = trap_find( te, FOFS( s.v.classname ), "bot" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $22
ARGP4
ADDRLP4 32
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
ADDRGP4 $103
JUMPV
LABELV $102
line 272
;271:	while ( te )
;272:	{
line 273
;273:		if ( self != te )
ADDRGP4 self
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
EQU4 $105
line 274
;274:		{
line 275
;275:			if ( te->team_no != 0 && te->team_no != self->team_no )
ADDRLP4 36
CNSTI4 960
ASGNI4
ADDRLP4 40
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $107
ADDRLP4 40
INDIRI4
ADDRGP4 self
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
EQI4 $107
line 276
;276:			{
line 277
;277:				if ( te->s.v.health )
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
EQF4 $109
line 278
;278:				{
line 279
;279:					if ( visible ( te ) )
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 visible
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $111
line 280
;280:					{
line 281
;281:						vtemp[0] =
ADDRLP4 48
CNSTI4 156
ASGNI4
ADDRLP4 4
ADDRLP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 283
;282:							te->s.v.origin[0] - self->s.v.origin[0];
;283:						vtemp[1] =
ADDRLP4 52
CNSTI4 160
ASGNI4
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 285
;284:							te->s.v.origin[1] - self->s.v.origin[1];
;285:						vtemp[2] =
ADDRLP4 56
CNSTI4 164
ASGNI4
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
ADDRGP4 self
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 287
;286:							te->s.v.origin[2] - self->s.v.origin[2];
;287:						DroneLaunchLaser ( self->s.v.origin, vtemp );
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 DroneLaunchLaser
CALLV
pop
line 288
;288:					}
LABELV $111
line 289
;289:				}
LABELV $109
line 290
;290:			}
LABELV $107
line 291
;291:		}
LABELV $105
line 292
;292:		te = trap_find( te, FOFS( s.v.classname ), "bot" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $22
ARGP4
ADDRLP4 36
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
line 293
;293:	}
LABELV $103
line 271
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $102
line 294
;294:	if ( self->playerclass > 10 )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 10
LEI4 $115
line 295
;295:		self->s.v.think = ( func_t ) DroneFall;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 DroneFall
CVPU4 4
CVUI4 4
ASGNI4
LABELV $115
line 296
;296:}
LABELV $72
endproc DroneJet 60 20
import BalloonMIRVtouch
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
LABELV $75
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $74
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 100
byte 1 114
byte 1 111
byte 1 110
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $69
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 100
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
LABELV $68
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 100
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
LABELV $67
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
LABELV $65
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
LABELV $60
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 98
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $59
byte 1 100
byte 1 114
byte 1 111
byte 1 110
byte 1 101
byte 1 95
byte 1 108
byte 1 97
byte 1 115
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $58
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
LABELV $56
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
LABELV $47
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
LABELV $41
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 108
byte 1 115
byte 1 114
byte 1 100
byte 1 114
byte 1 111
byte 1 110
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $39
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
LABELV $22
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $20
byte 1 76
byte 1 97
byte 1 115
byte 1 101
byte 1 114
byte 1 32
byte 1 68
byte 1 114
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 97
byte 1 119
byte 1 97
byte 1 121
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $19
byte 1 78
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 110
byte 1 101
byte 1 119
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 121
byte 1 101
byte 1 116
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 115
byte 1 32
byte 1 51
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
LABELV $15
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 32
byte 1 49
byte 1 32
byte 1 78
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 108
byte 1 32
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 38
byte 1 32
byte 1 49
byte 1 48
byte 1 48
byte 1 32
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 10
byte 1 0
