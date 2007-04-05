export LaserBolt_Think
code
proc LaserBolt_Think 12 8
file "..\src\engineer.c"
line 49
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
;21: *  $Id: engineer.c,v 1.29 2006/03/09 20:54:16 AngelD Exp $
;22: */
;23:/*========================================================
;24:Weapons and functions for the ENGINEER class and associated weaponry
;25:=======================================================*/
;26:
;27:#include "g_local.h"
;28:#include "sentry.h"
;29:
;30:// Weapon Functions
;31:void LaserBolt_Touch(  );
;32:
;33:// EMP Grenade Functions
;34:void EMPExplode(  );
;35:void EMPGrenadeTouch(  );
;36:void EMPGrenadeExplode(  );
;37:
;38:// Building Functions
;39:void CheckDistance(  );
;40:void TeamFortress_FinishedBuilding(  );
;41:void T_Dispenser(  );
;42:void Dispenser_Die(  );
;43:
;44:void teamsprint( int tno, gedict_t * ignore, char *st );
;45:
;46://=========================================================================
;47:// Laserbolt think function
;48:void LaserBolt_Think(  )
;49:{
line 50
;50:    self->s.v.solid = SOLID_TRIGGER;
ADDRGP4 self
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 51
;51:    self->s.v.movetype = MOVETYPE_FLYMISSILE;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1091567616
ASGNF4
line 52
;52:    VectorCopy( self->s.v.oldorigin, self->s.v.velocity );
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 172
ADDP4
INDIRF4
ASGNF4
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 188
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 176
ADDP4
INDIRF4
ASGNF4
line 53
;53:    self->s.v.touch = ( func_t ) LaserBolt_Touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 LaserBolt_Touch
CVPU4 4
CVUI4 4
ASGNI4
line 54
;54:	SetVector( self->s.v.avelocity, 0, 0, 500 );
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
CNSTF4 1140457472
ASGNF4
line 55
;55:    setmodel( self, "progs/beam.mdl" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $12
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 56
;56:	self->s.v.effects = 8;
ADDRGP4 self
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1090519040
ASGNF4
line 57
;57:	self->s.v.skin = PROG_TO_EDICT( self->s.v.owner)->team_no - 1;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
CNSTI4 1
SUBI4
CVIF4 4
ASGNF4
line 58
;58:    self->s.v.nextthink = g_globalvars.time + 1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 59
;59:    self->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 60
;60:}
LABELV $11
endproc LaserBolt_Think 12 8
export LaserBolt_Touch
proc LaserBolt_Touch 40 24
line 66
;61:
;62://=========================================================================
;63:// Laserbolt touch function. Just moves through the player and comes out
;64:// the other side.
;65:void LaserBolt_Touch(  )
;66:{
line 69
;67:    vec3_t org;
;68:
;69:    if ( other == PROG_TO_EDICT( self->s.v.owner ) )
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
NEU4 $16
line 70
;70:	return;
ADDRGP4 $15
JUMPV
LABELV $16
line 72
;71:    // don't explode on same person twice	
;72:    if ( other == PROG_TO_EDICT( self->s.v.enemy ) && self->s.v.enemy )
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ASGNI4
ADDRGP4 other
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRI4
ADDRGP4 g_edicts
ADDP4
CVPU4 4
NEU4 $18
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $18
line 73
;73:	return;
ADDRGP4 $15
JUMPV
LABELV $18
line 75
;74:
;75:    if ( trap_pointcontents( PASSVEC3( self->s.v.origin ) ) == CONTENT_SKY )
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
CNSTI4 -6
NEI4 $20
line 76
;76:    {
line 77
;77:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 78
;78:	return;
ADDRGP4 $15
JUMPV
LABELV $20
line 80
;79:    }
;80:    normalize( self->s.v.velocity, org );
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
line 81
;81:    VectorScale( org, 8, org );
ADDRLP4 0
ARGP4
CNSTF4 1090519040
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 82
;82:    VectorSubtract( self->s.v.origin, org, org );
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
line 83
;83:    if ( other->s.v.health )
ADDRGP4 other
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
CNSTF4 0
EQF4 $26
line 84
;84:    {
line 85
;85:	SpawnBlood( org, 15 );
ADDRLP4 0
ARGP4
CNSTF4 1097859072
ARGF4
ADDRGP4 SpawnBlood
CALLV
pop
line 86
;86:	tf_data.deathmsg = DMSG_LASERBOLT;
ADDRGP4 tf_data+88
CNSTI4 26
ASGNI4
line 87
;87:	TF_T_Damage( other, self, PROG_TO_EDICT( self->s.v.enemy ), 30, 2, TF_TD_ELECTRICITY );
ADDRGP4 other
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTF4 1106247680
ARGF4
CNSTI4 2
ARGI4
CNSTI4 8
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 88
;88:	VectorCopy( self->s.v.oldorigin, self->s.v.velocity );
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 168
ADDP4
INDIRF4
ASGNF4
ADDRLP4 32
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 172
ADDP4
INDIRF4
ASGNF4
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 188
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 176
ADDP4
INDIRF4
ASGNF4
line 89
;89:	self->s.v.owner = EDICT_TO_PROG( other );
ADDRGP4 self
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
line 90
;90:	setmodel( self, "" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $29
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 91
;91:	self->s.v.touch = ( func_t ) SUB_Null;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 SUB_Null
CVPU4 4
CVUI4 4
ASGNI4
line 92
;92:	self->s.v.nextthink = g_globalvars.time + 0.1;
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
;93:	self->s.v.think = ( func_t ) LaserBolt_Think;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 LaserBolt_Think
CVPU4 4
CVUI4 4
ASGNI4
line 94
;94:	return;
ADDRGP4 $15
JUMPV
LABELV $26
line 96
;95:    } else
;96:    {
line 97
;97:	sound( self, 1, "enforcer/enfstop.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $31
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
line 98
;98:	trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 99
;99:	trap_WriteByte( MSG_MULTICAST, 11/*TE_SPIKE*/ );
CNSTI4 4
ARGI4
CNSTI4 11
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 100
;100:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
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
line 101
;101:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
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
line 102
;102:	trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] );
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
line 103
;103:	trap_multicast( PASSVEC3( self->s.v.origin ), 1 );
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
CNSTI4 1
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 104
;104:    }
line 105
;105:    dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 106
;106:}
LABELV $15
endproc LaserBolt_Touch 40 24
export W_FireLaser
proc W_FireLaser 64 28
line 111
;107:
;108://=========================================================================
;109:// Fire a laserbolt		 -- mtf style
;110:void W_FireLaser(  )
;111:{
line 115
;112:    vec3_t vec;
;113:    vec3_t org;
;114:
;115:    self->s.v.currentammo = --( self->s.v.ammo_nails );
ADDRLP4 24
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 324
ADDP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 24
INDIRP4
CNSTI4 316
ADDP4
ADDRLP4 32
INDIRF4
ASGNF4
line 117
;116:
;117:    makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 118
;118:    VectorScale( g_globalvars.v_forward, 8, org );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1090519040
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 119
;119:    VectorAdd( self->s.v.origin, org, org );
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
line 120
;120:    aim( vec );
ADDRLP4 12
ARGP4
ADDRGP4 aim
CALLV
pop
line 121
;121:    VectorNormalize( vec );
ADDRLP4 12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 123
;122:
;123:    newmis = spawn(  );
ADDRLP4 36
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 36
INDIRP4
ASGNP4
line 124
;124:    newmis->s.v.owner = EDICT_TO_PROG( self );
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
line 125
;125:    newmis->s.v.enemy = EDICT_TO_PROG( self ); // The real owner
ADDRGP4 newmis
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
line 126
;126:    newmis->s.v.movetype = MOVETYPE_FLYMISSILE;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1091567616
ASGNF4
line 127
;127:    newmis->s.v.solid = SOLID_TRIGGER;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 130
;128:
;129:	// set model, skin, and effects
;130:    setmodel( newmis, "progs/beam.mdl" );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 $12
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 131
;131:	if ( tf_data.coloredlights == TRUE ) {
ADDRGP4 tf_data+192
INDIRI4
CNSTI4 1
NEI4 $38
line 132
;132:		if ( self->team_no == 1 )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 1
NEI4 $41
line 133
;133:			newmis->s.v.effects = 64;
ADDRGP4 newmis
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1115684864
ASGNF4
ADDRGP4 $39
JUMPV
LABELV $41
line 134
;134:		else {
line 135
;135:			if ( self->team_no == 2 )
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 2
NEI4 $43
line 136
;136:				newmis->s.v.effects = 128;
ADDRGP4 newmis
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1124073472
ASGNF4
ADDRGP4 $39
JUMPV
LABELV $43
line 138
;137:			else
;138:				newmis->s.v.effects = 2;
ADDRGP4 newmis
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1073741824
ASGNF4
line 139
;139:		}
line 140
;140:	}
ADDRGP4 $39
JUMPV
LABELV $38
line 142
;141:	else
;142:		newmis->s.v.effects = 2;
ADDRGP4 newmis
INDIRP4
CNSTI4 232
ADDP4
CNSTF4 1073741824
ASGNF4
LABELV $39
line 143
;143:	newmis->s.v.skin = self->team_no - 1;
ADDRGP4 newmis
INDIRP4
CNSTI4 228
ADDP4
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
CNSTI4 1
SUBI4
CVIF4 4
ASGNF4
line 145
;144:
;145:	SetVector( newmis->s.v.avelocity, 0, 0, 500 );
ADDRGP4 newmis
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 208
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 1140457472
ASGNF4
line 146
;146:    setsize( newmis, 0, 0, 0, 0, 0, 0 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 40
CNSTF4 0
ASGNF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 147
;147:    setorigin( newmis, org[0], org[1], org[2] + 16 );
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
CNSTF4 1098907648
ADDF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 148
;148:    VectorScale( vec, 1500, newmis->s.v.velocity );
ADDRLP4 12
ARGP4
CNSTF4 1153138688
ARGF4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 149
;149:    vectoangles( newmis->s.v.velocity, newmis->s.v.angles );
ADDRLP4 44
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 150
;150:	newmis->s.v.angles[1] += 0.1;
ADDRLP4 48
ADDRGP4 newmis
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 151
;151:    VectorCopy( newmis->s.v.velocity, newmis->s.v.oldorigin );
ADDRLP4 52
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 168
ADDP4
ADDRLP4 52
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ASGNF4
ADDRLP4 56
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 172
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ASGNF4
ADDRLP4 60
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ASGNF4
line 152
;152:    newmis->s.v.nextthink = g_globalvars.time + 5;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 153
;153:    newmis->s.v.think = ( func_t ) SUB_Remove;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 154
;154:    newmis->s.v.touch = ( func_t ) LaserBolt_Touch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 LaserBolt_Touch
CVPU4 4
CVUI4 4
ASGNI4
line 155
;155:}
LABELV $32
endproc W_FireLaser 64 28
export EMPExplode
proc EMPExplode 24 16
line 165
;156:
;157:
;158:void weapon_touch(  );
;159:void ammo_touch(  );
;160:void BackpackTouch(  );
;161:
;162://=========================================================================
;163:// Ammo/Weapon exploded by the EMP grenade
;164:void EMPExplode(  )
;165:{
line 168
;166:    float expsize;
;167:
;168:    expsize = 10;
ADDRLP4 0
CNSTF4 1092616192
ASGNF4
line 169
;169:    if ( self->s.v.touch == ( func_t ) weapon_touch )
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
ADDRGP4 weapon_touch
CVPU4 4
CVUI4 4
NEI4 $49
line 170
;170:	expsize = 60;
ADDRLP4 0
CNSTF4 1114636288
ASGNF4
ADDRGP4 $50
JUMPV
LABELV $49
line 172
;171:    else
;172:    {
line 173
;173:	if ( streq( self->s.v.classname, "item_shells" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $53
ARGP4
ADDRLP4 4
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $51
line 174
;174:	    expsize = 50 + self->aflag;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
CNSTI4 50
ADDI4
CVIF4 4
ASGNF4
ADDRGP4 $52
JUMPV
LABELV $51
line 176
;175:	else
;176:	{
line 177
;177:	    if ( streq( self->s.v.classname, "item_spikes" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 8
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $54
line 178
;178:		expsize = 40;
ADDRLP4 0
CNSTF4 1109393408
ASGNF4
ADDRGP4 $55
JUMPV
LABELV $54
line 180
;179:	    else
;180:	    {
line 181
;181:		if ( streq( self->s.v.classname, "item_rockets" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $59
ARGP4
ADDRLP4 12
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $57
line 182
;182:		    expsize = 100 + self->aflag * 4;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 100
ADDI4
CVIF4 4
ASGNF4
ADDRGP4 $58
JUMPV
LABELV $57
line 184
;183:		else
;184:		{
line 185
;185:		    if ( streq( self->s.v.classname, "item_cells" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $62
ARGP4
ADDRLP4 16
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $60
line 186
;186:			expsize = 100 + self->aflag * 3;
ADDRLP4 0
CNSTI4 3
ADDRGP4 self
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
MULI4
CNSTI4 100
ADDI4
CVIF4 4
ASGNF4
ADDRGP4 $61
JUMPV
LABELV $60
line 188
;187:		    else
;188:		    {
line 189
;189:			if ( streq( self->s.v.classname, "item_weapon" ) )
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $65
ARGP4
ADDRLP4 20
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $63
line 190
;190:			    expsize = 60;
ADDRLP4 0
CNSTF4 1114636288
ASGNF4
ADDRGP4 $64
JUMPV
LABELV $63
line 192
;191:			else
;192:			{
line 193
;193:			    G_dprintf( "EMPExplode: Attempting to explode a %s\n", self->s.v.classname );
ADDRGP4 $66
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_dprintf
CALLV
pop
line 194
;194:			    return;
ADDRGP4 $48
JUMPV
LABELV $64
line 196
;195:			}
;196:		    }
LABELV $61
line 197
;197:		}
LABELV $58
line 198
;198:	    }
LABELV $55
line 199
;199:	}
LABELV $52
line 200
;200:    }
LABELV $50
line 201
;201:    tf_data.deathmsg = DMSG_GREN_EMP_AMMO;
ADDRGP4 tf_data+88
CNSTI4 31
ASGNI4
line 202
;202:    T_RadiusDamage( self, PROG_TO_EDICT( self->s.v.enemy ), expsize, world );
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 world
INDIRP4
ARGP4
ADDRGP4 T_RadiusDamage
CALLV
pop
line 203
;203:    trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 204
;204:    trap_WriteByte( MSG_MULTICAST, TE_EXPLOSION );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 205
;205:    trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
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
line 206
;206:    trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
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
line 207
;207:    trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] );
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
line 208
;208:    trap_multicast( PASSVEC3( self->s.v.origin ), 1 );
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
CNSTI4 1
ARGI4
ADDRGP4 trap_multicast
CALLI4
pop
line 211
;209:
;210:    // Respawn
;211:    Respawn_Item( self, PROG_TO_EDICT( self->s.v.enemy ) );
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRGP4 Respawn_Item
CALLV
pop
line 212
;212:}
LABELV $48
endproc EMPExplode 24 16
export EMPGrenadeTouch
proc EMPGrenadeTouch 12 20
line 217
;213:
;214://=========================================================================
;215:// Touch Function for EMP Grenade
;216:void EMPGrenadeTouch(  )
;217:{
line 219
;218:    // If the EMP Grenade hits a player, it just bounces off
;219:    sound( self, 1, "weapons/bounce.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $69
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
line 220
;220:    if ( VectorCompareF( self->s.v.velocity, 0, 0, 0 ) )
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
EQI4 $70
line 221
;221:	SetVector( self->s.v.avelocity, 0, 0, 0 );
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
LABELV $70
line 222
;222:}
LABELV $68
endproc EMPGrenadeTouch 12 20
export EMPGrenadeExplode
proc EMPGrenadeExplode 72 24
line 227
;223:
;224://=========================================================================
;225:// EMP Grenade explode function, for when the PRIMETIME runs out
;226:void EMPGrenadeExplode(  )
;227:{
line 232
;228:    float expsize;
;229:    gedict_t *te;
;230:    gedict_t *oldself;
;231:
;232:    trap_WriteByte( MSG_BROADCAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 233
;233:    trap_WriteByte( MSG_BROADCAST, TE_TAREXPLOSION );
ADDRLP4 12
CNSTI4 4
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
line 234
;234:    trap_WriteCoord( MSG_BROADCAST, self->s.v.origin[0] );
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
line 235
;235:    trap_WriteCoord( MSG_BROADCAST, self->s.v.origin[1] );
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
line 236
;236:    trap_WriteCoord( MSG_BROADCAST, self->s.v.origin[2] );
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
line 237
;237:    trap_multicast( PASSVEC3( self->s.v.origin ), 1 );
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
line 238
;238:    for ( te = world; (te = findradius( te, self->s.v.origin, 240 )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $76
JUMPV
LABELV $73
line 239
;239:    {
line 240
;240:	if ( te->s.v.touch == ( func_t ) ammo_touch || te->s.v.touch == ( func_t ) weapon_touch )
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 ammo_touch
CVPU4 4
CVUI4 4
EQI4 $79
ADDRLP4 20
INDIRI4
ADDRGP4 weapon_touch
CVPU4 4
CVUI4 4
NEI4 $77
LABELV $79
line 241
;241:	{
line 242
;242:	    if ( strneq( te->s.v.classname, "item_spikes" ) )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 24
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $74
line 243
;243:	    {
line 244
;244:		te->s.v.solid = SOLID_NOT;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 245
;245:		te->s.v.enemy = self->s.v.owner;
ADDRLP4 0
INDIRP4
CNSTI4 400
ADDP4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ASGNI4
line 246
;246:		te->s.v.nextthink = g_globalvars.time + 1 + g_random(  ) * 2;
ADDRLP4 28
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
CNSTF4 1073741824
ADDRLP4 28
INDIRF4
MULF4
ADDF4
ASGNF4
line 247
;247:		te->s.v.think = ( func_t ) EMPExplode;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 EMPExplode
CVPU4 4
CVUI4 4
ASGNI4
line 248
;248:	    }
line 249
;249:	    continue;
ADDRGP4 $74
JUMPV
LABELV $77
line 252
;250:	}
;251:
;252:	if ( te->s.v.think == ( func_t ) TeamFortress_DetpackExplode )
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
ADDRGP4 TeamFortress_DetpackExplode
CVPU4 4
CVUI4 4
NEI4 $83
line 253
;253:	{
line 254
;254:	    te->s.v.solid = SOLID_NOT;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 255
;255:	    te->s.v.nextthink = g_globalvars.time + 1 + g_random(  ) * 2;
ADDRLP4 24
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1065353216
ADDF4
CNSTF4 1073741824
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
line 256
;256:	    dremove( te->oldenemy );
ADDRLP4 0
INDIRP4
CNSTI4 980
ADDP4
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 257
;257:	    continue;
ADDRGP4 $74
JUMPV
LABELV $83
line 259
;258:	}
;259:	if ( streq( te->s.v.classname, "pipebomb" ) )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $88
ARGP4
ADDRLP4 24
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $86
line 260
;260:	{
line 261
;261:	    te->s.v.nextthink = g_globalvars.time + 0.1;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 262
;262:	    continue;
ADDRGP4 $74
JUMPV
LABELV $86
line 267
;263:	}
;264:	// No sentrygun damage in mtf vanilla :(
;265:	// Clan Edition should have tho..
;266:	//				- XavioR
;267:	if ( streq( te->s.v.classname, "building_dispenser" ) /*|| streq( te->s.v.classname, "building_sentrygun" )*/ )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $92
ARGP4
ADDRLP4 28
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $90
line 268
;268:	{
line 269
;269:	    if ( !
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 teamplay
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 32
INDIRI4
EQI4 $97
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
ADDRLP4 32
INDIRI4
LEI4 $97
ADDRLP4 36
INDIRI4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts+960
ADDP4
INDIRI4
EQI4 $74
LABELV $97
line 272
;270:		 ( ( teamplay & TEAMPLAY_NOEXPLOSIVE ) && te->team_no > 0
;271:		   && te->team_no == PROG_TO_EDICT( self->s.v.owner )->team_no ) )
;272:		TF_T_Damage( te, self, PROG_TO_EDICT( self->s.v.owner ), 200, 0, 4 );
ADDRLP4 0
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
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
CNSTF4 1128792064
ARGF4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 273
;273:	    continue;
ADDRGP4 $74
JUMPV
LABELV $90
line 275
;274:	}
;275:	if ( streq( te->s.v.classname, "ammobox" ) )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $100
ARGP4
ADDRLP4 32
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $98
line 276
;276:	{
line 277
;277:	    expsize = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 278
;278:	    expsize = expsize + te->s.v.ammo_shells * 0.75;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1061158912
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 279
;279:	    expsize = expsize + te->s.v.ammo_rockets * 0.75 * 2;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1073741824
CNSTF4 1061158912
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 280
;280:	    expsize = expsize + te->s.v.ammo_cells * 0.75 * 2;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1073741824
CNSTF4 1061158912
ADDRLP4 0
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 281
;281:	    if ( expsize > 0 )
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $74
line 282
;282:	    {
line 283
;283:		te->s.v.solid = SOLID_NOT;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 0
ASGNF4
line 284
;284:		tf_data.deathmsg = DMSG_GREN_EMP;
ADDRGP4 tf_data+88
CNSTI4 30
ASGNI4
line 285
;285:		T_RadiusDamage( te, PROG_TO_EDICT( self->s.v.owner ), expsize, te );
ADDRLP4 0
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
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 T_RadiusDamage
CALLV
pop
line 286
;286:		te->s.v.think = ( func_t ) TeamFortress_AmmoboxRemove;//SUB_Remove;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 TeamFortress_AmmoboxRemove
CVPU4 4
CVUI4 4
ASGNI4
line 287
;287:		te->s.v.nextthink = g_globalvars.time + 0.1;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 288
;288:		trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 289
;289:		trap_WriteByte( MSG_MULTICAST, TE_EXPLOSION );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 290
;290:		trap_WriteCoord( MSG_MULTICAST, te->s.v.origin[0] );
CNSTI4 4
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
line 291
;291:		trap_WriteCoord( MSG_MULTICAST, te->s.v.origin[1] );
CNSTI4 4
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
line 292
;292:		trap_WriteCoord( MSG_MULTICAST, te->s.v.origin[2] );
CNSTI4 4
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
line 293
;293:		trap_multicast( PASSVEC3( te->s.v.origin ), 1 );
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
line 294
;294:	    }
line 295
;295:	    continue;
ADDRGP4 $74
JUMPV
LABELV $98
line 297
;296:	}
;297:	if ( streq( te->s.v.classname, "player" ) || te->s.v.touch == ( func_t ) BackpackTouch )
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $107
ARGP4
ADDRLP4 36
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $108
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
ADDRGP4 BackpackTouch
CVPU4 4
CVUI4 4
NEI4 $105
LABELV $108
line 298
;298:	{
line 302
;299://	    if ( !( ( teamplay & 16 ) && te->team_no > 0 && te->team_no == PROG_TO_EDICT( self->s.v.owner )->team_no ) )
;300://	    {
;301:		// ^ yeah it's also kinda dumb that in mtf you can emp teammates but wtva..
;302:		expsize = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 303
;303:		expsize = expsize + te->s.v.ammo_shells * 0.75;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1061158912
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 304
;304:		expsize = expsize + te->s.v.ammo_rockets * 0.75 * 2;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1073741824
CNSTF4 1061158912
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 305
;305:		if ( te->playerclass != PC_ENGINEER )
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 9
EQI4 $109
line 306
;306:		    expsize = expsize + te->s.v.ammo_cells * 0.75;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1061158912
ADDRLP4 0
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $109
line 307
;307:		if ( expsize > 0 )
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $74
line 308
;308:		{
line 309
;309:		    tf_data.deathmsg = DMSG_GREN_EMP;
ADDRGP4 tf_data+88
CNSTI4 30
ASGNI4
line 310
;310:		    T_RadiusDamage( te, PROG_TO_EDICT( self->s.v.owner ), expsize, te );
ADDRLP4 0
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
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 T_RadiusDamage
CALLV
pop
line 311
;311:		    if ( te->s.v.touch != ( func_t ) BackpackTouch )
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRI4
ADDRGP4 BackpackTouch
CVPU4 4
CVUI4 4
EQI4 $114
line 312
;312:		    {
line 313
;313:			TF_T_Damage( te, self, PROG_TO_EDICT( self->s.v.owner ), expsize, 2, 4 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
CNSTI4 2
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 314
;314:			te->s.v.ammo_shells = ceil( te->s.v.ammo_shells * 0.25 );
ADDRLP4 48
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
ASGNP4
CNSTF4 1048576000
ADDRLP4 48
INDIRP4
INDIRF4
MULF4
ARGF4
ADDRLP4 52
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 48
INDIRP4
ADDRLP4 52
INDIRF4
ASGNF4
line 315
;315:			te->s.v.ammo_rockets = ceil( te->s.v.ammo_rockets * 0.25 );
ADDRLP4 56
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
ASGNP4
CNSTF4 1048576000
ADDRLP4 56
INDIRP4
INDIRF4
MULF4
ARGF4
ADDRLP4 60
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 56
INDIRP4
ADDRLP4 60
INDIRF4
ASGNF4
line 316
;316:			if ( te->playerclass != 9 )
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 9
EQI4 $116
line 317
;317:			    te->s.v.ammo_cells = ceil( te->s.v.ammo_cells * 0.25 );
ADDRLP4 64
ADDRLP4 0
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
CNSTF4 1048576000
ADDRLP4 64
INDIRP4
INDIRF4
MULF4
ARGF4
ADDRLP4 68
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 64
INDIRP4
ADDRLP4 68
INDIRF4
ASGNF4
LABELV $116
line 318
;318:			oldself = self;
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
line 319
;319:			self = te;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 320
;320:			W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 321
;321:			self = oldself;
ADDRGP4 self
ADDRLP4 8
INDIRP4
ASGNP4
line 322
;322:		    } else
ADDRGP4 $115
JUMPV
LABELV $114
line 323
;323:		    {
line 324
;324:			te->s.v.think = ( func_t ) SUB_Remove;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Remove
CVPU4 4
CVUI4 4
ASGNI4
line 325
;325:			te->s.v.nextthink = g_globalvars.time + 0.1;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 326
;326:		    }
LABELV $115
line 327
;327:		    trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 328
;328:		    trap_WriteByte( MSG_MULTICAST, TE_EXPLOSION );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 329
;329:		    trap_WriteCoord( MSG_MULTICAST, te->s.v.origin[0] );
CNSTI4 4
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
line 330
;330:		    trap_WriteCoord( MSG_MULTICAST, te->s.v.origin[1] );
CNSTI4 4
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
line 331
;331:		    trap_WriteCoord( MSG_MULTICAST, te->s.v.origin[2] );
CNSTI4 4
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
line 332
;332:		    trap_multicast( PASSVEC3( te->s.v.origin ), 1 );
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
line 333
;333:		}
line 335
;334://	    }
;335:	    continue;
LABELV $105
line 337
;336:	}
;337:    }
LABELV $74
line 238
LABELV $76
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ARGP4
CNSTF4 1131413504
ARGF4
ADDRLP4 20
ADDRGP4 findradius
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $73
line 338
;338:    dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 339
;339:}
LABELV $72
endproc EMPGrenadeExplode 72 24
export TeamFortress_EngineerBuild
proc TeamFortress_EngineerBuild 20 12
line 344
;340:
;341://=========================================================================
;342:// Function handling the Engineer's build impulse
;343:void TeamFortress_EngineerBuild(  )
;344:{
line 353
;345:    gedict_t *te;
;346:
;347:/*    if ( !( ( int ) self->s.v.flags & FL_ONGROUND ) )
;348:    {
;349:	CenterPrint( self, "You can't build in the air!\n\n" );
;350:	return;
;351:    }*/
;352:    // Pop up the menu
;353:    if ( !self->is_building )
ADDRGP4 self
INDIRP4
CNSTI4 872
ADDP4
INDIRI4
CNSTI4 0
NEI4 $120
line 354
;354:    {
line 355
;355:        if(!tg_data.tg_enabled)
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
NEI4 $122
line 356
;356:        {
line 357
;357:        	if ( self->s.v.ammo_cells < 100 && !self->has_dispenser && !self->has_sentry )
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1120403456
GEF4 $124
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 996
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $124
ADDRLP4 4
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $124
line 358
;358:        	{
line 359
;359:        	    CenterPrint( self, "You don't have enough metal to \nbuild anything.\n\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $126
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 360
;360:        	    return;
ADDRGP4 $119
JUMPV
LABELV $124
line 362
;361:        	}
;362:        }
LABELV $122
line 363
;363:	self->current_menu = MENU_ENGINEER;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 15
ASGNI4
line 364
;364:	self->menu_count = MENU_REFRESH_RATE;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 25
ASGNI4
line 365
;365:    } else
ADDRGP4 $121
JUMPV
LABELV $120
line 366
;366:    {
line 369
;367://	if ( self->is_building == 1 )
;368://	{
;369:	    G_sprint( self, 2, "You stop building.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $127
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 370
;370:	    self->tfstate = self->tfstate - ( self->tfstate & TFSTATE_CANT_MOVE );
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
CNSTI4 65536
BANDI4
SUBI4
ASGNI4
line 371
;371:	    TeamFortress_SetSpeed( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 373
;372:	    // Remove the timer
;373:	    for ( te = world; (te = trap_find( te, FOFS( s.v.netname ), "build_timer" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $131
JUMPV
LABELV $128
line 374
;374:	    {
line 375
;375:		if ( te->s.v.owner == EDICT_TO_PROG( self ) )
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
NEI4 $133
line 376
;376:		{
line 377
;377:		    dremove( te );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 378
;378:		    break;
ADDRGP4 $130
JUMPV
LABELV $133
line 380
;379:		}
;380:	    }
LABELV $129
line 373
LABELV $131
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 396
ARGI4
ADDRGP4 $132
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
NEU4 $128
LABELV $130
line 381
;381:	    self->is_building = 0;
ADDRGP4 self
INDIRP4
CNSTI4 872
ADDP4
CNSTI4 0
ASGNI4
line 382
;382:	    self->current_weapon = self->s.v.weapon;
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 1032
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 383
;383:	    W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 385
;384://	}
;385:    }
LABELV $121
line 386
;386:}
LABELV $119
endproc TeamFortress_EngineerBuild 20 12
export CheckAreaNew
proc CheckAreaNew 44 56
line 389
;387:
;388:int CheckAreaNew( gedict_t * obj, gedict_t * builder )
;389:{
line 393
;390:    gedict_t *te;
;391:    vec3_t end;
;392:
;393:    TraceCapsule( PASSVEC3( obj->s.v.origin ), PASSVEC3( obj->s.v.origin ), 0, obj, PASSVEC3( obj->s.v.mins), PASSVEC3( obj->s.v.maxs) );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 24
ADDRLP4 16
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 28
ADDRLP4 16
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
ARGF4
ADDRGP4 TraceCapsule
CALLV
pop
line 394
;394:    if ( g_globalvars.trace_startsolid == 1 )
ADDRGP4 g_globalvars+268
INDIRF4
CNSTF4 1065353216
NEF4 $136
line 395
;395:    {
line 396
;396:	VectorCopy( obj->s.v.origin, end );
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 397
;397:	end[2] -= 48;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1111490560
SUBF4
ASGNF4
line 398
;398:	TraceCapsule( PASSVEC3( obj->s.v.origin ), PASSVEC3( end ), 0, obj, PASSVEC3( obj->s.v.mins), obj->s.v.maxs[0], obj->s.v.maxs[1], 4);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
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
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ARGF4
CNSTF4 1082130432
ARGF4
ADDRGP4 TraceCapsule
CALLV
pop
line 399
;399:	VectorCopy( g_globalvars.trace_endpos, end );
ADDRLP4 0
ADDRGP4 g_globalvars+276
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 g_globalvars+276+4
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 g_globalvars+276+8
INDIRF4
ASGNF4
line 400
;400:	end[2]++;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 401
;401:	TraceCapsule( PASSVEC3( end ), PASSVEC3( end ), 0, obj, PASSVEC3( obj->s.v.mins), PASSVEC3( obj->s.v.maxs) );
ADDRLP4 36
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 252
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 256
ADDP4
INDIRF4
ARGF4
ADDRGP4 TraceCapsule
CALLV
pop
line 402
;402:	if ( g_globalvars.trace_startsolid == 1 )
ADDRGP4 g_globalvars+268
INDIRF4
CNSTF4 1065353216
NEF4 $156
line 403
;403:	    return 0;
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $156
line 404
;404:    }
LABELV $136
line 406
;405:
;406:    te = findradius( world, obj->s.v.origin, 64 );
ADDRGP4 world
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
ARGP4
CNSTF4 1115684864
ARGF4
ADDRLP4 32
ADDRGP4 findradius
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 32
INDIRP4
ASGNP4
line 407
;407:    if ( te )
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $159
line 408
;408:	return 0;
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $159
line 410
;409:    
;410:    return 1;
CNSTI4 1
RETI4
LABELV $135
endproc CheckAreaNew 44 56
export CheckArea
proc CheckArea 104 32
line 414
;411:}
;412:
;413:int CheckArea( gedict_t * obj, gedict_t * builder )
;414:{
line 420
;415:    vec3_t src;
;416:    vec3_t end;
;417:    int pos;
;418:    gedict_t *te;
;419:
;420:    pos = CheckAreaNew( obj, builder );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 CheckAreaNew
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 32
INDIRI4
ASGNI4
line 421
;421:    if ( pos == 0 )
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $162
line 422
;422:	return 0;
CNSTI4 0
RETI4
ADDRGP4 $161
JUMPV
LABELV $162
line 424
;423:
;424:    pos = trap_pointcontents( PASSVEC3( obj->s.v.origin ) );
ADDRLP4 36
ADDRFP4 0
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
ADDRLP4 40
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 40
INDIRI4
ASGNI4
line 425
;425:    if ( pos == CONTENT_SOLID || pos == CONTENT_SKY )
ADDRLP4 24
INDIRI4
CNSTI4 -2
EQI4 $166
ADDRLP4 24
INDIRI4
CNSTI4 -6
NEI4 $164
LABELV $166
line 426
;426:	return 0;
CNSTI4 0
RETI4
ADDRGP4 $161
JUMPV
LABELV $164
line 427
;427:    src[0] = obj->s.v.origin[0]  + 24;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 428
;428:    src[1] = obj->s.v.origin[1]  + 24;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 429
;429:    src[2] = obj->s.v.origin[2]  + 16;
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 430
;430:    pos = trap_pointcontents( PASSVEC3( src ) );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 48
INDIRI4
ASGNI4
line 431
;431:    if ( pos == CONTENT_SOLID || pos == CONTENT_SKY )
ADDRLP4 24
INDIRI4
CNSTI4 -2
EQI4 $173
ADDRLP4 24
INDIRI4
CNSTI4 -6
NEI4 $171
LABELV $173
line 432
;432:	return 0;
CNSTI4 0
RETI4
ADDRGP4 $161
JUMPV
LABELV $171
line 433
;433:    end[0] = obj->s.v.origin[0]  - 16;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 434
;434:    end[1] = obj->s.v.origin[1]  - 16;
ADDRLP4 12+4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 435
;435:    end[2] = obj->s.v.origin[2]  - 16;
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 436
;436:    traceline( PASSVEC3( src ), PASSVEC3( end ), 1, obj );
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
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 437
;437:    if ( g_globalvars.trace_fraction != 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $180
line 438
;438:	return 0;
CNSTI4 0
RETI4
ADDRGP4 $161
JUMPV
LABELV $180
line 439
;439:    pos = trap_pointcontents( PASSVEC3( end ) );
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 56
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 56
INDIRI4
ASGNI4
line 440
;440:    if ( pos == CONTENT_SOLID || pos == CONTENT_SKY )
ADDRLP4 24
INDIRI4
CNSTI4 -2
EQI4 $187
ADDRLP4 24
INDIRI4
CNSTI4 -6
NEI4 $185
LABELV $187
line 441
;441:	return 0;
CNSTI4 0
RETI4
ADDRGP4 $161
JUMPV
LABELV $185
line 442
;442:    src[0] = obj->s.v.origin[0] - 16;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 443
;443:    src[1] = obj->s.v.origin[1] + 16;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 444
;444:    src[2] = obj->s.v.origin[2] + 16;
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 445
;445:    pos = trap_pointcontents( PASSVEC3( src ) );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 64
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 64
INDIRI4
ASGNI4
line 446
;446:    if ( pos == CONTENT_SOLID || pos == CONTENT_SKY )
ADDRLP4 24
INDIRI4
CNSTI4 -2
EQI4 $194
ADDRLP4 24
INDIRI4
CNSTI4 -6
NEI4 $192
LABELV $194
line 447
;447:	return 0;
CNSTI4 0
RETI4
ADDRGP4 $161
JUMPV
LABELV $192
line 448
;448:    end[0] = obj->s.v.origin[0] + 16;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 449
;449:    end[1] = obj->s.v.origin[1] - 16;
ADDRLP4 12+4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 450
;450:    end[2] = obj->s.v.origin[2] - 16;
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 451
;451:    traceline( PASSVEC3( src ), PASSVEC3( end ), 1, obj );
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
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 453
;452:
;453:    if ( g_globalvars.trace_fraction != 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $201
line 454
;454:	return 0;
CNSTI4 0
RETI4
ADDRGP4 $161
JUMPV
LABELV $201
line 455
;455:    pos = trap_pointcontents( PASSVEC3( end ) );
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 72
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 72
INDIRI4
ASGNI4
line 456
;456:    if ( pos == CONTENT_SOLID || pos == CONTENT_SKY )
ADDRLP4 24
INDIRI4
CNSTI4 -2
EQI4 $208
ADDRLP4 24
INDIRI4
CNSTI4 -6
NEI4 $206
LABELV $208
line 457
;457:	return 0;
CNSTI4 0
RETI4
ADDRGP4 $161
JUMPV
LABELV $206
line 458
;458:    traceline( PASSVEC3( builder->s.v.origin ), PASSVEC3( obj->s.v.origin ), 1, builder );
ADDRLP4 80
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 84
CNSTI4 156
ASGNI4
ADDRLP4 80
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 88
CNSTI4 160
ASGNI4
ADDRLP4 80
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 92
CNSTI4 164
ASGNI4
ADDRLP4 80
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 96
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRF4
ARGF4
ADDRLP4 96
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 80
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 459
;459:    if ( g_globalvars.trace_fraction != 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $209
line 460
;460:	return 0;
CNSTI4 0
RETI4
ADDRGP4 $161
JUMPV
LABELV $209
line 461
;461:    te = findradius( world, obj->s.v.origin, 64 );
ADDRGP4 world
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
ARGP4
CNSTF4 1115684864
ARGF4
ADDRLP4 100
ADDRGP4 findradius
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 100
INDIRP4
ASGNP4
line 462
;462:    if ( te )
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $212
line 463
;463:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $161
JUMPV
LABELV $212
line 464
;464:    return 1;
CNSTI4 1
RETI4
LABELV $161
endproc CheckArea 104 32
export TeamFortress_Build
proc TeamFortress_Build 72 28
line 468
;465:}
;466:
;467:void TeamFortress_Build( int objtobuild )
;468:{
line 475
;469:    float btime;
;470:
;471://      gedict_t *te;
;472:    vec3_t tmp1;
;473:    vec3_t tmp2;
;474:
;475:    newmis = spawn(  );
ADDRLP4 28
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 28
INDIRP4
ASGNP4
line 476
;476:    g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 479
;477:
;478:    // get an origin
;479:    makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 480
;480:    g_globalvars.v_forward[2] = 0;
ADDRGP4 g_globalvars+228+8
CNSTF4 0
ASGNF4
line 481
;481:    VectorNormalize( g_globalvars.v_forward );
ADDRGP4 g_globalvars+228
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 482
;482:    VectorScale( g_globalvars.v_forward, 64, g_globalvars.v_forward );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1115684864
ARGF4
ADDRGP4 g_globalvars+228
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 483
;483:    VectorAdd( self->s.v.origin, g_globalvars.v_forward, newmis->s.v.origin );
ADDRLP4 32
CNSTI4 156
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRGP4 g_globalvars+228
INDIRF4
ADDF4
ASGNF4
ADDRLP4 36
CNSTI4 160
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRGP4 g_globalvars+228+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 40
CNSTI4 164
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
ADDRGP4 g_globalvars+228+8
INDIRF4
ADDF4
ASGNF4
line 485
;484:
;485:    if ( objtobuild == BUILD_DISPENSER )
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $226
line 486
;486:    {
line 487
;487:        if( self->has_dispenser && !tg_data.tg_enabled)
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 996
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $228
ADDRGP4 tg_data
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $228
line 488
;488:	{
line 489
;489:	    G_sprint( self, 2, "You can only have one dispenser.\nTry dismantling your old one.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $230
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 490
;490:	    return;
ADDRGP4 $214
JUMPV
LABELV $228
line 492
;491:	}
;492:	SetVector( tmp1, -8, -8, 0 );
ADDRLP4 36
CNSTF4 3238002688
ASGNF4
ADDRLP4 0
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 493
;493:	SetVector( tmp2, 8, 8, 24 );
ADDRLP4 40
CNSTF4 1090519040
ASGNF4
ADDRLP4 12
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 12+8
CNSTF4 1103101952
ASGNF4
line 495
;494://	newmis->mdl = "progs/disp.mdl";
;495:	newmis->mdl = "progs/dispencr.mdl";		// megatf disp!
ADDRGP4 newmis
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $235
ASGNP4
line 496
;496:	newmis->s.v.netname = "dispenser";
ADDRGP4 newmis
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $236
ASGNP4
line 497
;497:	btime = g_globalvars.time + BUILD_TIME_DISPENSER;
ADDRLP4 24
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1073741824
ADDF4
ASGNF4
line 498
;498:	if( tg_data.tg_enabled )
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $227
line 499
;499:		btime = g_globalvars.time;
ADDRLP4 24
ADDRGP4 g_globalvars+124
INDIRF4
ASGNF4
line 500
;500:    } else
ADDRGP4 $227
JUMPV
LABELV $226
line 501
;501:    {
line 502
;502:	if ( objtobuild == BUILD_SENTRYGUN )
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $241
line 503
;503:	{
line 504
;504:           if( self->has_sentry && !tg_data.tg_enabled)
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 self
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $243
ADDRGP4 tg_data
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $243
line 505
;505:	    {
line 506
;506:		G_sprint( self, 2, "You can only have one sentry gun.\nTry dismantling your old one.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $245
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 507
;507:		return;
ADDRGP4 $214
JUMPV
LABELV $243
line 509
;508:	    }
;509:	    SetVector( tmp1, -16, -16, 0 );
ADDRLP4 36
CNSTF4 3246391296
ASGNF4
ADDRLP4 0
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 510
;510:	    SetVector( tmp2, 16, 16, 48 );
ADDRLP4 40
CNSTF4 1098907648
ASGNF4
ADDRLP4 12
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 12+8
CNSTF4 1111490560
ASGNF4
line 511
;511:	    newmis->mdl = "progs/turrbase.mdl";
ADDRGP4 newmis
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $250
ASGNP4
line 512
;512:	    newmis->s.v.netname = "sentrygun";
ADDRGP4 newmis
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $251
ASGNP4
line 513
;513:	    btime = g_globalvars.time + BUILD_TIME_SENTRYGUN;
ADDRLP4 24
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 514
;514:	    if( tg_data.tg_enabled )
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $242
line 515
;515:	    	btime = g_globalvars.time;
ADDRLP4 24
ADDRGP4 g_globalvars+124
INDIRF4
ASGNF4
line 516
;516:	}else
ADDRGP4 $242
JUMPV
LABELV $241
line 517
;517:	{
line 518
;518:		G_Error("Unknown objtobuild in TeamFortress_Build\n");
ADDRGP4 $256
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 519
;519:		return;
ADDRGP4 $214
JUMPV
LABELV $242
line 522
;520:	}
;521:
;522:    }
LABELV $227
line 523
;523:    VectorCopy(tmp1,newmis->s.v.mins);
ADDRGP4 newmis
INDIRP4
CNSTI4 236
ADDP4
ADDRLP4 0
INDIRF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 240
ADDP4
ADDRLP4 0+4
INDIRF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 244
ADDP4
ADDRLP4 0+8
INDIRF4
ASGNF4
line 524
;524:    VectorCopy(tmp2,newmis->s.v.maxs);
ADDRGP4 newmis
INDIRP4
CNSTI4 248
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 252
ADDP4
ADDRLP4 12+4
INDIRF4
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 256
ADDP4
ADDRLP4 12+8
INDIRF4
ASGNF4
line 527
;525:    // before we start building it, check it out
;526:    // check for validity of point
;527:    if ( !CheckArea( newmis, self ) )
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 CheckArea
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $261
line 528
;528:    {
line 529
;529:	G_sprint( self, 2, "Not enough room to build here\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $263
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 530
;530:	dremove( newmis );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 531
;531:	return;
ADDRGP4 $214
JUMPV
LABELV $261
line 534
;532:    }
;533:
;534:    if ( !( ( int ) self->s.v.flags & FL_ONGROUND ) )
ADDRGP4 self
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
CVFI4 4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $264
line 535
;535:    {
line 536
;536:	CenterPrint( self, "You can't build in the air!\n\n" );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 $266
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 537
;537:	return;
ADDRGP4 $214
JUMPV
LABELV $264
line 539
;538:    }
;539:    self->is_building = 1;
ADDRGP4 self
INDIRP4
CNSTI4 872
ADDP4
CNSTI4 1
ASGNI4
line 540
;540:    self->tfstate = self->tfstate | TFSTATE_CANT_MOVE;
ADDRLP4 36
ADDRGP4 self
INDIRP4
CNSTI4 892
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 65536
BORI4
ASGNI4
line 542
;541:    // Save the current weapon and remove it
;542:    self->s.v.weapon = self->current_weapon;
ADDRLP4 40
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 304
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 1032
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 543
;543:    self->current_weapon = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1032
ADDP4
CNSTI4 0
ASGNI4
line 544
;544:    self->s.v.weaponmodel = "";
ADDRGP4 self
INDIRP4
CNSTI4 308
ADDP4
ADDRGP4 $29
ASGNP4
line 545
;545:    self->s.v.weaponframe = 0;
ADDRGP4 self
INDIRP4
CNSTI4 312
ADDP4
CNSTF4 0
ASGNF4
line 547
;546:
;547:    TeamFortress_SetSpeed( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 548
;548:    newmis->s.v.owner = EDICT_TO_PROG( self );
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
line 549
;549:    newmis->s.v.classname = "timer";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $267
ASGNP4
line 550
;550:    newmis->s.v.netname = "build_timer";
ADDRGP4 newmis
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $132
ASGNP4
line 551
;551:    newmis->s.v.nextthink = btime;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRLP4 24
INDIRF4
ASGNF4
line 552
;552:    newmis->s.v.think = ( func_t ) TeamFortress_FinishedBuilding;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 TeamFortress_FinishedBuilding
CVPU4 4
CVUI4 4
ASGNI4
line 553
;553:    newmis->s.v.colormap = self->s.v.colormap;
ADDRLP4 44
CNSTI4 408
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
line 554
;554:    newmis->s.v.weapon = objtobuild;
ADDRGP4 newmis
INDIRP4
CNSTI4 304
ADDP4
ADDRFP4 0
INDIRI4
CVIF4 4
ASGNF4
line 555
;555:    newmis->s.v.angles[1] = anglemod( self->s.v.angles[1] + 180 );
ADDRLP4 48
CNSTI4 196
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
CNSTF4 1127481344
ADDF4
ARGF4
ADDRLP4 52
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRGP4 newmis
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
ADDRLP4 52
INDIRF4
ASGNF4
line 556
;556:    SetVector( newmis->s.v.velocity, 0, 0, 8 );
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
CNSTF4 1090519040
ASGNF4
line 557
;557:    newmis->s.v.movetype = MOVETYPE_TOSS;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 558
;558:    newmis->s.v.solid = SOLID_BBOX;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 559
;559:    setmodel( newmis, newmis->mdl );
ADDRLP4 56
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 560
;560:    setsize( newmis, PASSVEC3( tmp1 ), PASSVEC3( tmp2 ) );
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
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRGP4 setsize
CALLV
pop
line 561
;561:    setorigin( newmis, PASSVEC3( newmis->s.v.origin ) );
ADDRLP4 60
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 562
;562:    newmis->s.v.flags = ( int ) newmis->s.v.flags - ( ( int ) newmis->s.v.flags & FL_ONGROUND );
ADDRLP4 64
ADDRGP4 newmis
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 68
ADDRLP4 64
INDIRP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 64
INDIRP4
ADDRLP4 68
INDIRI4
ADDRLP4 68
INDIRI4
CNSTI4 512
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 563
;563:}
LABELV $214
endproc TeamFortress_Build 72 28
export CheckBelowBuilding
proc CheckBelowBuilding 28 32
line 566
;564:
;565:void CheckBelowBuilding( gedict_t * bld )
;566:{
line 569
;567:    vec3_t below;
;568:
;569:    VectorCopy( bld->s.v.origin, below );
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 570
;570:    if ( streq( bld->s.v.classname, "detpack" ) )
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $277
ARGP4
ADDRLP4 12
ADDRGP4 streq
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $275
line 571
;571:	below[2] = below[2] - 8;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1090519040
SUBF4
ASGNF4
ADDRGP4 $276
JUMPV
LABELV $275
line 573
;572:    else
;573:	below[2] = below[2] - 24;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
LABELV $276
line 574
;574:    traceline( PASSVEC3( bld->s.v.origin ), PASSVEC3( below ), 1, bld );
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
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 575
;575:    if ( g_globalvars.trace_fraction == 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
NEF4 $284
line 576
;576:    {
line 577
;577:	bld->s.v.movetype = MOVETYPE_TOSS;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 578
;578:	bld->s.v.flags = ( int ) bld->s.v.flags - ( ( int ) bld->s.v.flags & FL_ONGROUND );
ADDRLP4 20
ADDRFP4 0
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
line 579
;579:    }
LABELV $284
line 581
;580:
;581:}
LABELV $272
endproc CheckBelowBuilding 28 32
export DispenserThink
proc DispenserThink 20 4
line 584
;582:
;583:void DispenserThink(  )
;584:{
line 585
;585:    CheckBelowBuilding( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 CheckBelowBuilding
CALLV
pop
line 586
;586:    if ( self->hook_out > 3 ) 
ADDRGP4 self
INDIRP4
CNSTI4 1436
ADDP4
INDIRI4
CNSTI4 3
LEI4 $288
line 587
;587:    {
line 589
;588:        // dispenser refilling itself 5%
;589:	self->s.v.ammo_shells = self->s.v.ammo_shells + ( int ) ( BUILD_DISPENSER_MAX_SHELLS / 20 );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
CNSTF4 1101004800
ADDF4
ASGNF4
line 590
;590:	self->s.v.ammo_cells = self->s.v.ammo_cells + ( int ) ( BUILD_DISPENSER_MAX_CELLS / 20 );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1101004800
ADDF4
ASGNF4
line 591
;591:	self->s.v.ammo_nails = self->s.v.ammo_nails + ( int ) ( BUILD_DISPENSER_MAX_NAILS / 20 );
ADDRLP4 8
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 592
;592:	self->s.v.ammo_rockets = self->s.v.ammo_rockets + ( int ) ( BUILD_DISPENSER_MAX_ROCKETS / 20 );
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 593
;593:	self->s.v.armorvalue = self->s.v.armorvalue + ( int ) ( BUILD_DISPENSER_MAX_ARMOR / 20 );
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 428
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1103626240
ADDF4
ASGNF4
line 594
;594:	if ( self->s.v.ammo_shells > BUILD_DISPENSER_MAX_SHELLS )
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1137180672
LEF4 $290
line 595
;595:	    self->s.v.ammo_shells = BUILD_DISPENSER_MAX_SHELLS;
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
CNSTF4 1137180672
ASGNF4
LABELV $290
line 596
;596:	if ( self->s.v.ammo_nails > BUILD_DISPENSER_MAX_NAILS )
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
CNSTF4 1142292480
LEF4 $292
line 597
;597:	    self->s.v.ammo_nails = BUILD_DISPENSER_MAX_NAILS;
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
CNSTF4 1142292480
ASGNF4
LABELV $292
line 598
;598:	if ( self->s.v.ammo_rockets > BUILD_DISPENSER_MAX_ROCKETS )
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1133903872
LEF4 $294
line 599
;599:	    self->s.v.ammo_rockets = BUILD_DISPENSER_MAX_ROCKETS;
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
CNSTF4 1133903872
ASGNF4
LABELV $294
line 600
;600:	if ( self->s.v.ammo_cells > BUILD_DISPENSER_MAX_CELLS )
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1137180672
LEF4 $296
line 601
;601:	    self->s.v.ammo_cells = BUILD_DISPENSER_MAX_CELLS;
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
CNSTF4 1137180672
ASGNF4
LABELV $296
line 602
;602:	if ( self->s.v.armorvalue > BUILD_DISPENSER_MAX_ARMOR )
ADDRGP4 self
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
CNSTF4 1140457472
LEF4 $298
line 603
;603:	    self->s.v.armorvalue = BUILD_DISPENSER_MAX_ARMOR;
ADDRGP4 self
INDIRP4
CNSTI4 428
ADDP4
CNSTF4 1140457472
ASGNF4
LABELV $298
line 604
;604:	self->hook_out = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1436
ADDP4
CNSTI4 0
ASGNI4
line 605
;605:    }
LABELV $288
line 606
;606:    self->hook_out = self->hook_out + 1;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 1436
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 607
;607:    self->s.v.nextthink = g_globalvars.time + 3;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1077936128
ADDF4
ASGNF4
line 608
;608:}
LABELV $287
endproc DispenserThink 20 4
export TeamFortress_FinishedBuilding
proc TeamFortress_FinishedBuilding 168 56
line 611
;609:
;610:void TeamFortress_FinishedBuilding(  )
;611:{
line 617
;612:    gedict_t *oldself;
;613:    gedict_t *owner;
;614:    vec3_t  end;
;615:
;616:
;617:    owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 618
;618:    if ( owner->is_building != 1 )
ADDRLP4 16
INDIRP4
CNSTI4 872
ADDP4
INDIRI4
CNSTI4 1
EQI4 $302
line 619
;619:	return;
ADDRGP4 $301
JUMPV
LABELV $302
line 621
;620:
;621:    if ( self->s.v.weapon == BUILD_SENTRYGUN && tg_data.tg_enabled )
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $304
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $304
line 622
;622:    {
line 624
;623:    	
;624:	VectorCopy( self->s.v.origin, end );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 4+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
line 625
;625:	end[2] -= 2048;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
CNSTF4 1157627904
SUBF4
ASGNF4
line 626
;626:	TraceCapsule( PASSVEC3( self->s.v.origin ), PASSVEC3( end ), 0, self, -16, -16, 0, 16, 16, 4 );
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
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
CNSTF4 3246391296
ASGNF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 28
CNSTF4 1098907648
ASGNF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
CNSTF4 1082130432
ARGF4
ADDRGP4 TraceCapsule
CALLV
pop
line 627
;627:	VectorCopy( g_globalvars.trace_endpos, end );
ADDRLP4 4
ADDRGP4 g_globalvars+276
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRGP4 g_globalvars+276+4
INDIRF4
ASGNF4
ADDRLP4 4+8
ADDRGP4 g_globalvars+276+8
INDIRF4
ASGNF4
line 628
;628:	end[2]++;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 629
;629:	setorigin( self, PASSVEC3( end ) );
ADDRGP4 self
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
line 630
;630:    }
LABELV $304
line 631
;631:    oldself = self;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
line 632
;632:    self = owner;
ADDRGP4 self
ADDRLP4 16
INDIRP4
ASGNP4
line 633
;633:    oldself->s.v.owner = 0;
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
CNSTI4 0
ASGNI4
line 634
;634:    oldself->real_owner = self;
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
ADDRGP4 self
INDIRP4
ASGNP4
line 635
;635:    self->is_building = 0;
ADDRGP4 self
INDIRP4
CNSTI4 872
ADDP4
CNSTI4 0
ASGNI4
line 636
;636:    self->tfstate = self->tfstate - ( self->tfstate & TFSTATE_CANT_MOVE );
ADDRLP4 20
ADDRGP4 self
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
CNSTI4 65536
BANDI4
SUBI4
ASGNI4
line 637
;637:    self->current_weapon = self->s.v.weapon;
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
line 638
;638:    self->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 639
;639:    TeamFortress_SetSpeed( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 TeamFortress_SetSpeed
CALLV
pop
line 640
;640:    if ( oldself->s.v.weapon == BUILD_DISPENSER )
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $322
line 641
;641:    {
line 642
;642:	self->has_dispenser = self->has_dispenser + 1;
ADDRLP4 32
ADDRGP4 self
INDIRP4
CNSTI4 996
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
line 643
;643:	G_sprint( self, 2, "You finish building the dispenser.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $324
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 644
;644:	teamsprint( self->team_no, self, self->s.v.netname );
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 teamsprint
CALLV
pop
line 645
;645:	teamsprint( self->team_no, self, " has built a Dispenser.\n" );
ADDRLP4 40
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 $325
ARGP4
ADDRGP4 teamsprint
CALLV
pop
line 647
;646:
;647:        if( !tg_data.tg_enabled )
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
NEI4 $326
line 648
;648:		self->s.v.ammo_cells = self->s.v.ammo_cells - 100;
ADDRLP4 44
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
LABELV $326
line 651
;649:
;650:	// Create the dispenser
;651:	oldself->s.v.classname = "building_dispenser";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $92
ASGNP4
line 652
;652:	oldself->s.v.netname = "dispenser";
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $236
ASGNP4
line 653
;653:	oldself->s.v.blocked = ( func_t ) T_Dispenser;
ADDRLP4 0
INDIRP4
CNSTI4 284
ADDP4
ADDRGP4 T_Dispenser
CVPU4 4
CVUI4 4
ASGNI4
line 654
;654:	oldself->s.v.touch = ( func_t ) T_Dispenser;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 T_Dispenser
CVPU4 4
CVUI4 4
ASGNI4
line 655
;655:	oldself->s.v.max_health = BUILD_HEALTH_DISPENSER;
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
CNSTF4 1125515264
ASGNF4
line 656
;656:	oldself->s.v.health = BUILD_HEALTH_DISPENSER;
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1125515264
ASGNF4
line 657
;657:	oldself->hook_out = 1;
ADDRLP4 0
INDIRP4
CNSTI4 1436
ADDP4
CNSTI4 1
ASGNI4
line 658
;658:	oldself->s.v.think = ( func_t ) DispenserThink;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 DispenserThink
CVPU4 4
CVUI4 4
ASGNI4
line 659
;659:	oldself->s.v.nextthink = g_globalvars.time + 3;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1077936128
ADDF4
ASGNF4
line 660
;660:	oldself->th_die = Dispenser_Die;
ADDRLP4 0
INDIRP4
CNSTI4 812
ADDP4
ADDRGP4 Dispenser_Die
ASGNP4
line 662
;661:	//oldself->mdl = "progs/disp.mdl";
;662:	oldself->mdl = "progs/dispencr.mdl";
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $235
ASGNP4
line 663
;663:	oldself->team_no = self->team_no;
ADDRLP4 48
CNSTI4 960
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
line 665
;664:
;665:	oldself->real_owner = self;                    // The Engineer owns this item
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
ADDRGP4 self
INDIRP4
ASGNP4
line 666
;666:	oldself->s.v.colormap = self->s.v.colormap;    // Set the Color
ADDRLP4 52
CNSTI4 408
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
INDIRF4
ASGNF4
line 667
;667:	oldself->s.v.takedamage = 2;
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 1073741824
ASGNF4
line 668
;668:	oldself->s.v.owner = EDICT_TO_PROG( world );
ADDRLP4 0
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
line 669
;669:	oldself->s.v.movetype = MOVETYPE_TOSS;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 670
;670:	SetVector( oldself->s.v.velocity, 0, 0, 8 );
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
CNSTF4 1090519040
ASGNF4
line 671
;671:	oldself->s.v.flags = ( int ) oldself->s.v.flags - ( ( int ) oldself->s.v.flags & FL_ONGROUND );
ADDRLP4 56
ADDRLP4 0
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 60
ADDRLP4 56
INDIRP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 56
INDIRP4
ADDRLP4 60
INDIRI4
ADDRLP4 60
INDIRI4
CNSTI4 512
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 674
;672:
;673:	// Put some ammo in the Dispenser
;674:	oldself->s.v.ammo_shells = ceil( self->s.v.ammo_shells * 0.25 );
ADDRLP4 64
CNSTI4 320
ASGNI4
CNSTF4 1048576000
ADDRGP4 self
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
MULF4
ARGF4
ADDRLP4 68
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
ADDRLP4 68
INDIRF4
ASGNF4
line 675
;675:	oldself->s.v.ammo_nails = ceil( self->s.v.ammo_nails * 0.25 );
ADDRLP4 72
CNSTI4 324
ASGNI4
CNSTF4 1048576000
ADDRGP4 self
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
MULF4
ARGF4
ADDRLP4 76
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
ADDRLP4 76
INDIRF4
ASGNF4
line 676
;676:	oldself->s.v.ammo_rockets = ceil( self->s.v.ammo_rockets * 0.25 );
ADDRLP4 80
CNSTI4 328
ASGNI4
CNSTF4 1048576000
ADDRGP4 self
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRF4
MULF4
ARGF4
ADDRLP4 84
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
ADDRLP4 84
INDIRF4
ASGNF4
line 677
;677:	oldself->s.v.ammo_cells = ceil( self->s.v.ammo_cells * 0.25 );
ADDRLP4 88
CNSTI4 332
ASGNI4
CNSTF4 1048576000
ADDRGP4 self
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRF4
MULF4
ARGF4
ADDRLP4 92
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
ADDRLP4 92
INDIRF4
ASGNF4
line 678
;678:	oldself->s.v.armorvalue = ceil( self->s.v.armorvalue * 0.25 );
ADDRLP4 96
CNSTI4 428
ASGNI4
CNSTF4 1048576000
ADDRGP4 self
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRF4
MULF4
ARGF4
ADDRLP4 100
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
ADDRLP4 100
INDIRF4
ASGNF4
line 681
;679:
;680:	// Remove ours
;681:	self->s.v.ammo_shells = ceil( self->s.v.ammo_shells * 0.75 );
ADDRLP4 104
ADDRGP4 self
INDIRP4
CNSTI4 320
ADDP4
ASGNP4
CNSTF4 1061158912
ADDRLP4 104
INDIRP4
INDIRF4
MULF4
ARGF4
ADDRLP4 108
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 104
INDIRP4
ADDRLP4 108
INDIRF4
ASGNF4
line 682
;682:	self->s.v.ammo_nails = ceil( self->s.v.ammo_nails * 0.75 );
ADDRLP4 112
ADDRGP4 self
INDIRP4
CNSTI4 324
ADDP4
ASGNP4
CNSTF4 1061158912
ADDRLP4 112
INDIRP4
INDIRF4
MULF4
ARGF4
ADDRLP4 116
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 112
INDIRP4
ADDRLP4 116
INDIRF4
ASGNF4
line 683
;683:	self->s.v.ammo_rockets = ceil( self->s.v.ammo_rockets * 0.75 );
ADDRLP4 120
ADDRGP4 self
INDIRP4
CNSTI4 328
ADDP4
ASGNP4
CNSTF4 1061158912
ADDRLP4 120
INDIRP4
INDIRF4
MULF4
ARGF4
ADDRLP4 124
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 120
INDIRP4
ADDRLP4 124
INDIRF4
ASGNF4
line 684
;684:	self->s.v.ammo_cells = ceil( self->s.v.ammo_cells * 0.75 );
ADDRLP4 128
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
CNSTF4 1061158912
ADDRLP4 128
INDIRP4
INDIRF4
MULF4
ARGF4
ADDRLP4 132
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 128
INDIRP4
ADDRLP4 132
INDIRF4
ASGNF4
line 685
;685:	self->s.v.armorvalue = ceil( self->s.v.armorvalue * 0.75 );
ADDRLP4 136
ADDRGP4 self
INDIRP4
CNSTI4 428
ADDP4
ASGNP4
CNSTF4 1061158912
ADDRLP4 136
INDIRP4
INDIRF4
MULF4
ARGF4
ADDRLP4 140
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 136
INDIRP4
ADDRLP4 140
INDIRF4
ASGNF4
line 687
;686:
;687:	oldself->s.v.solid = SOLID_BBOX;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 688
;688:	setmodel( oldself, oldself->mdl );
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
line 689
;689:	setsize( oldself, -8, -8, 0, 8, 8, 24 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 148
CNSTF4 3238002688
ASGNF4
ADDRLP4 148
INDIRF4
ARGF4
ADDRLP4 148
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 152
CNSTF4 1090519040
ASGNF4
ADDRLP4 152
INDIRF4
ARGF4
ADDRLP4 152
INDIRF4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 setsize
CALLV
pop
line 690
;690:	oldself->s.v.origin[2] += 8;
ADDRLP4 156
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
ASGNP4
ADDRLP4 156
INDIRP4
ADDRLP4 156
INDIRP4
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 691
;691:	setorigin( oldself, PASSVEC3( oldself->s.v.origin ) );
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
line 693
;692:
;693:    } else
ADDRGP4 $323
JUMPV
LABELV $322
line 694
;694:    {
line 695
;695:	if ( oldself->s.v.weapon == BUILD_SENTRYGUN )
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $329
line 696
;696:	{
line 697
;697:	    self->has_sentry = self->has_sentry + 1;
ADDRLP4 32
ADDRGP4 self
INDIRP4
CNSTI4 1000
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
line 699
;698:
;699:	    G_sprint( self, 2, "You finish building the sentry gun.\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $331
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 700
;700:	    teamsprint( self->team_no, self, self->s.v.netname );
ADDRLP4 36
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 teamsprint
CALLV
pop
line 701
;701:	    teamsprint( self->team_no, self, " has built a Sentry Gun.\n" );
ADDRLP4 40
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 $332
ARGP4
ADDRGP4 teamsprint
CALLV
pop
line 703
;702:
;703:	    oldself->s.v.classname = "building_sentrygun_base";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $333
ASGNP4
line 704
;704:	    oldself->s.v.netname = "sentry gun";
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 $334
ASGNP4
line 705
;705:	    oldself->s.v.takedamage = 0;
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 0
ASGNF4
line 706
;706:	    oldself->th_die = Sentry_Die;
ADDRLP4 0
INDIRP4
CNSTI4 812
ADDP4
ADDRGP4 Sentry_Die
ASGNP4
line 707
;707:	    oldself->team_no = self->team_no;
ADDRLP4 44
CNSTI4 960
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
line 708
;708:            if( !tg_data.tg_enabled )
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
NEI4 $335
line 709
;709:		    self->s.v.ammo_cells = self->s.v.ammo_cells - 130;
ADDRLP4 48
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
CNSTF4 1124204544
SUBF4
ASGNF4
LABELV $335
line 711
;710:
;711:	    setsize( oldself, -16, -16, 0, 16, 16, 4 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 52
CNSTF4 3246391296
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 52
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 56
CNSTF4 1098907648
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
CNSTF4 1082130432
ARGF4
ADDRGP4 setsize
CALLV
pop
line 712
;712:	    newmis = spawn(  );
ADDRLP4 60
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 60
INDIRP4
ASGNP4
line 713
;713:	    g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 714
;714:	    newmis->s.v.classname = "building_sentrygun";
ADDRGP4 newmis
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $338
ASGNP4
line 715
;715:	    newmis->s.v.health = BUILD_HEALTH_SENTRYGUN;
ADDRGP4 newmis
INDIRP4
CNSTI4 296
ADDP4
CNSTF4 1125515264
ASGNF4
line 716
;716:	    newmis->s.v.max_health = newmis->s.v.health;
ADDRLP4 64
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 416
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ASGNF4
line 717
;717:	    newmis->s.v.weapon = 1;
ADDRGP4 newmis
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1065353216
ASGNF4
line 718
;718:	    newmis->th_die = Sentry_Die;
ADDRGP4 newmis
INDIRP4
CNSTI4 812
ADDP4
ADDRGP4 Sentry_Die
ASGNP4
line 719
;719:	    newmis->th_pain = Sentry_Pain;
ADDRGP4 newmis
INDIRP4
CNSTI4 816
ADDP4
ADDRGP4 Sentry_Pain
ASGNP4
line 720
;720:	    newmis->mdl = "progs/turrgun.mdl";
ADDRGP4 newmis
INDIRP4
CNSTI4 528
ADDP4
ADDRGP4 $339
ASGNP4
line 721
;721:	    sound( oldself, 3, "weapons/turrset.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $340
ARGP4
ADDRLP4 68
CNSTF4 1065353216
ASGNF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRGP4 sound
CALLV
pop
line 722
;722:	    newmis->s.v.solid = SOLID_BBOX;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1073741824
ASGNF4
line 723
;723:	    setmodel( newmis, newmis->mdl );
ADDRLP4 72
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 528
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 724
;724:	    setsize( newmis, -16, -16, 0, 16, 16, 48 );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRLP4 76
CNSTF4 3246391296
ASGNF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 76
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 80
CNSTF4 1098907648
ASGNF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
CNSTF4 1111490560
ARGF4
ADDRGP4 setsize
CALLV
pop
line 725
;725:	    VectorCopy( oldself->s.v.origin, newmis->s.v.origin );
ADDRLP4 84
CNSTI4 156
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 88
CNSTI4 160
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 92
CNSTI4 164
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 726
;726:	    newmis->s.v.origin[2] += 8;
ADDRLP4 84
ADDRGP4 newmis
INDIRP4
CNSTI4 164
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 727
;727:	    setorigin( newmis, PASSVEC3( newmis->s.v.origin ) );
ADDRLP4 88
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 88
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 88
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 728
;728:	    SetVector( newmis->s.v.view_ofs, 0, 0, 22 );
ADDRGP4 newmis
INDIRP4
CNSTI4 352
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 356
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 newmis
INDIRP4
CNSTI4 360
ADDP4
CNSTF4 1102053376
ASGNF4
line 729
;729:	    newmis->real_owner = oldself->real_owner;
ADDRLP4 92
CNSTI4 976
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRP4
ASGNP4
line 730
;730:	    newmis->trigger_field = oldself;
ADDRGP4 newmis
INDIRP4
CNSTI4 668
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 731
;731:	    oldself->oldenemy = newmis;
ADDRLP4 0
INDIRP4
CNSTI4 980
ADDP4
ADDRGP4 newmis
INDIRP4
ASGNP4
line 732
;732:	    newmis->s.v.movetype = MOVETYPE_STEP;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1082130432
ASGNF4
line 733
;733:	    oldself->s.v.colormap = self->s.v.colormap;               // Set the Base Color
ADDRLP4 96
CNSTI4 408
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 734
;734:	    newmis->s.v.colormap = self->s.v.colormap;                // Set the Color
ADDRLP4 100
CNSTI4 408
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 100
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 100
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 735
;735:	    newmis->s.v.takedamage = DAMAGE_AIM;
ADDRGP4 newmis
INDIRP4
CNSTI4 340
ADDP4
CNSTF4 1073741824
ASGNF4
line 736
;736:	    SetVector( newmis->s.v.velocity, 0, 0, -8 );
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
CNSTF4 3238002688
ASGNF4
line 737
;737:	    newmis->s.v.flags = ( int ) newmis->s.v.flags - ( ( int ) newmis->s.v.flags & FL_ONGROUND );
ADDRLP4 104
ADDRGP4 newmis
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 108
ADDRLP4 104
INDIRP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 104
INDIRP4
ADDRLP4 108
INDIRI4
ADDRLP4 108
INDIRI4
CNSTI4 512
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 738
;738:	    oldself->s.v.flags = ( int ) oldself->s.v.flags - ( ( int ) oldself->s.v.flags & FL_ONGROUND );
ADDRLP4 112
ADDRLP4 0
INDIRP4
CNSTI4 404
ADDP4
ASGNP4
ADDRLP4 116
ADDRLP4 112
INDIRP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 112
INDIRP4
ADDRLP4 116
INDIRI4
ADDRLP4 116
INDIRI4
CNSTI4 512
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 739
;739:	    newmis->team_no = self->team_no;
ADDRLP4 120
CNSTI4 960
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 120
INDIRI4
ADDP4
ADDRGP4 self
INDIRP4
ADDRLP4 120
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 740
;740:	    newmis->s.v.think = ( func_t ) lvl1_sentry_stand;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl1_sentry_stand
CVPU4 4
CVUI4 4
ASGNI4
line 741
;741:	    newmis->s.v.nextthink = g_globalvars.time + 0.5;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 743
;742:	    // Rotate Details
;743:	    newmis->s.v.yaw_speed = 10;
ADDRGP4 newmis
INDIRP4
CNSTI4 444
ADDP4
CNSTF4 1092616192
ASGNF4
line 744
;744:	    newmis->heat = 0;          // Turn Right
ADDRGP4 newmis
INDIRP4
CNSTI4 1076
ADDP4
CNSTF4 0
ASGNF4
line 745
;745:	    newmis->s.v.angles[0] = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 0
ASGNF4
line 746
;746:	    newmis->s.v.angles[1] = ( int ) ( oldself->s.v.angles[1] );
ADDRLP4 124
CNSTI4 196
ASGNI4
ADDRGP4 newmis
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 747
;747:	    newmis->s.v.angles[2] = 0;
ADDRGP4 newmis
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 0
ASGNF4
line 748
;748:	    newmis->waitmin = ( int ) ( newmis->s.v.angles[1] - 50 );
ADDRLP4 128
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 128
INDIRP4
CNSTI4 1092
ADDP4
ADDRLP4 128
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
CNSTF4 1112014848
SUBF4
CVFI4 4
CVIF4 4
ASGNF4
line 749
;749:	    newmis->waitmin = anglemod( newmis->waitmin );
ADDRLP4 132
ADDRGP4 newmis
INDIRP4
CNSTI4 1092
ADDP4
ASGNP4
ADDRLP4 132
INDIRP4
INDIRF4
ARGF4
ADDRLP4 136
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRLP4 132
INDIRP4
ADDRLP4 136
INDIRF4
ASGNF4
line 750
;750:	    newmis->waitmax = ( int ) ( newmis->s.v.angles[1] + 50 );
ADDRLP4 140
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
CNSTI4 1096
ADDP4
ADDRLP4 140
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
CNSTF4 1112014848
ADDF4
CVFI4 4
CVIF4 4
ASGNF4
line 751
;751:	    newmis->waitmax = anglemod( newmis->waitmax );
ADDRLP4 144
ADDRGP4 newmis
INDIRP4
CNSTI4 1096
ADDP4
ASGNP4
ADDRLP4 144
INDIRP4
INDIRF4
ARGF4
ADDRLP4 148
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRLP4 144
INDIRP4
ADDRLP4 148
INDIRF4
ASGNF4
line 752
;752:	    if ( newmis->waitmin > newmis->waitmax )
ADDRLP4 152
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 152
INDIRP4
CNSTI4 1092
ADDP4
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 1096
ADDP4
INDIRF4
LEF4 $342
line 753
;753:	    {
line 754
;754:		newmis->waitmin = newmis->waitmax;
ADDRLP4 156
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 1092
ADDP4
ADDRLP4 156
INDIRP4
CNSTI4 1096
ADDP4
INDIRF4
ASGNF4
line 755
;755:		newmis->waitmax = anglemod( newmis->s.v.angles[1] - 50 );
ADDRLP4 160
ADDRGP4 newmis
INDIRP4
ASGNP4
ADDRLP4 160
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
CNSTF4 1112014848
SUBF4
ARGF4
ADDRLP4 164
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRLP4 160
INDIRP4
CNSTI4 1096
ADDP4
ADDRLP4 164
INDIRF4
ASGNF4
line 756
;756:	    }
LABELV $342
line 758
;757:	    // Give the Gun some ammo
;758:	    newmis->s.v.ammo_shells = 25;
ADDRGP4 newmis
INDIRP4
CNSTI4 320
ADDP4
CNSTF4 1103626240
ASGNF4
line 759
;759:	    newmis->maxammo_shells = 100;
ADDRGP4 newmis
INDIRP4
CNSTI4 904
ADDP4
CNSTI4 100
ASGNI4
line 760
;760:	    newmis->maxammo_rockets = 20;
ADDRGP4 newmis
INDIRP4
CNSTI4 916
ADDP4
CNSTI4 20
ASGNI4
line 761
;761:	}
LABELV $329
line 762
;762:    }
LABELV $323
line 763
;763:    W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 764
;764:    self = oldself;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 765
;765:}
LABELV $301
endproc TeamFortress_FinishedBuilding 168 56
export T_Dispenser
proc T_Dispenser 28 8
line 770
;766:
;767://=========================================================================
;768:// Dispenser Touch function. Allows players to get stuff from the Dispenser.
;769:void T_Dispenser(  )
;770:{
line 773
;771:    gedict_t *dist_checker;
;772:
;773:    if ( strneq( other->s.v.classname, "player" ) )
ADDRGP4 other
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 $107
ARGP4
ADDRLP4 4
ADDRGP4 strneq
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $345
line 774
;774:	return;
ADDRGP4 $344
JUMPV
LABELV $345
line 776
;775:
;776:    if ( other->team_no && !TeamFortress_isTeamsAllied (other->team_no , self->team_no) )
ADDRLP4 8
CNSTI4 960
ASGNI4
ADDRLP4 12
ADDRGP4 other
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $347
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 self
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 TeamFortress_isTeamsAllied
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $347
line 777
;777:	CenterPrint( self->real_owner, "Enemies are using your dispenser!\n" );
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
ADDRGP4 $349
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
LABELV $347
line 780
;778:
;779:    // Ignore any engineer working on this dispenser	
;780:    if ( ( !other->building || other->building == world ) && other->building_wait < g_globalvars.time )
ADDRLP4 20
ADDRGP4 other
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 20
INDIRU4
CNSTU4 0
EQU4 $353
ADDRLP4 20
INDIRU4
ADDRGP4 world
INDIRP4
CVPU4 4
NEU4 $350
LABELV $353
ADDRGP4 other
INDIRP4
CNSTI4 984
ADDP4
INDIRF4
ADDRGP4 g_globalvars+124
INDIRF4
GEF4 $350
line 781
;781:    {
line 783
;782:        // Pop up the menu
;783:	other->current_menu = MENU_DISPENSER;
ADDRGP4 other
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 19
ASGNI4
line 784
;784:	other->menu_count = MENU_REFRESH_RATE;
ADDRGP4 other
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 25
ASGNI4
line 786
;785:
;786:	other->building = self;
ADDRGP4 other
INDIRP4
CNSTI4 972
ADDP4
ADDRGP4 self
INDIRP4
ASGNP4
line 790
;787:
;788:        // Start a Distance checker, which removes the menu if the player
;789:	// gets too far away from the Dispenser.
;790:	dist_checker = spawn(  );
ADDRLP4 24
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 791
;791:	dist_checker->s.v.classname = "timer";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $267
ASGNP4
line 792
;792:	dist_checker->s.v.owner = EDICT_TO_PROG( other );
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
line 793
;793:	dist_checker->s.v.enemy = EDICT_TO_PROG( self );
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
line 794
;794:	dist_checker->s.v.think = ( func_t ) CheckDistance;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 CheckDistance
CVPU4 4
CVUI4 4
ASGNI4
line 795
;795:	dist_checker->s.v.nextthink = g_globalvars.time + 0.3;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1050253722
ADDF4
ASGNF4
line 796
;796:    }
LABELV $350
line 797
;797:}
LABELV $344
endproc T_Dispenser 28 8
export Dispenser_Explode
proc Dispenser_Explode 12 16
line 800
;798:
;799:void Dispenser_Explode(  )
;800:{
line 803
;801:    float sdmg;
;802:
;803:    if ( self->real_owner->has_disconnected != 1 )
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 1
EQI4 $356
line 804
;804:    {
line 805
;805:	tf_data.deathmsg = DMSG_DISP_EXPLODION;
ADDRGP4 tf_data+88
CNSTI4 39
ASGNI4
line 806
;806:	sdmg = 25 + self->s.v.ammo_rockets * 1.5 + self->s.v.ammo_cells;
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 0
CNSTF4 1069547520
ADDRLP4 4
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
MULF4
CNSTF4 1103626240
ADDF4
ADDRLP4 4
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ADDF4
ASGNF4
line 807
;807:	if ( sdmg > 250 )
ADDRLP4 0
INDIRF4
CNSTF4 1132068864
LEF4 $359
line 808
;808:	    sdmg = 250;
ADDRLP4 0
CNSTF4 1132068864
ASGNF4
LABELV $359
line 809
;809:	T_RadiusDamage( self, self->real_owner, sdmg, self );
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 T_RadiusDamage
CALLV
pop
line 810
;810:    }
LABELV $356
line 811
;811:    ThrowGib( "progs/dgib1.mdl", -30 );
ADDRGP4 $361
ARGP4
CNSTF4 3253731328
ARGF4
ADDRGP4 ThrowGib
CALLV
pop
line 812
;812:    ThrowGib( "progs/dgib2.mdl", -50 );
ADDRGP4 $362
ARGP4
CNSTF4 3259498496
ARGF4
ADDRGP4 ThrowGib
CALLV
pop
line 813
;813:    ThrowGib( "progs/dgib3.mdl", -50 );
ADDRGP4 $363
ARGP4
CNSTF4 3259498496
ARGF4
ADDRGP4 ThrowGib
CALLV
pop
line 814
;814:    trap_WriteByte( MSG_MULTICAST, SVC_TEMPENTITY );
CNSTI4 4
ARGI4
CNSTI4 23
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 815
;815:    trap_WriteByte( MSG_MULTICAST, TE_EXPLOSION );
CNSTI4 4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 trap_WriteByte
CALLV
pop
line 816
;816:    trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[0] );
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
line 817
;817:    trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[1] );
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
line 818
;818:    trap_WriteCoord( MSG_MULTICAST, self->s.v.origin[2] );
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
line 819
;819:    trap_multicast( PASSVEC3( self->s.v.origin ), 1 );
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
line 820
;820:    BecomeExplosion(  );
ADDRGP4 BecomeExplosion
CALLV
pop
line 821
;821:}
LABELV $355
endproc Dispenser_Explode 12 16
export Dispenser_Die
proc Dispenser_Die 4 12
line 824
;822:
;823:void Dispenser_Die(  )
;824:{
line 825
;825:    G_sprint( self->real_owner, 2, "Your dispenser was destroyed.\n" );
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $365
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 827
;826:
;827:    self->real_owner->has_dispenser -= 1;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 996
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 829
;828:
;829:    self->s.v.think = ( func_t ) Dispenser_Explode;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 Dispenser_Explode
CVPU4 4
CVUI4 4
ASGNI4
line 830
;830:    self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 831
;831:}
LABELV $364
endproc Dispenser_Die 4 12
export Engineer_UseDispenser
proc Engineer_UseDispenser 12 36
line 836
;832:
;833://=========================================================================
;834:// Engineer has used a Spanner on the Dispenser
;835:void Engineer_UseDispenser( gedict_t * disp )
;836:{
line 839
;837:    gedict_t *dist_checker;
;838:
;839:    G_sprint( self, 2,
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $368
ARGP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 324
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 844
;840:	      "Dispenser has %.0f health\n%.0f shells, %.0f nails,%.0f rockets\n%.0f cells, and %.0f armor\n",
;841:	      disp->s.v.health, disp->s.v.ammo_shells, disp->s.v.ammo_nails, disp->s.v.ammo_rockets,
;842:	      disp->s.v.ammo_cells, disp->s.v.armorvalue );
;843:    // Pop up the menu
;844:    self->current_menu = MENU_ENGINEER_FIX_DISPENSER;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 16
ASGNI4
line 845
;845:    self->menu_count = MENU_REFRESH_RATE;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 25
ASGNI4
line 846
;846:    self->building = disp;
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 850
;847:
;848:    // Start a Distance checker, which removes the menu if the player
;849:    // gets too far away from the Dispenser.
;850:    dist_checker = spawn(  );
ADDRLP4 8
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 851
;851:    dist_checker->s.v.classname = "timer";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $267
ASGNP4
line 852
;852:    dist_checker->s.v.owner = EDICT_TO_PROG( self );
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
line 853
;853:    dist_checker->s.v.enemy = EDICT_TO_PROG( disp );
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
line 854
;854:    dist_checker->s.v.think = ( func_t ) CheckDistance;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 CheckDistance
CVPU4 4
CVUI4 4
ASGNI4
line 855
;855:    dist_checker->s.v.nextthink = g_globalvars.time + 0.3;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1050253722
ADDF4
ASGNF4
line 856
;856:}
LABELV $367
endproc Engineer_UseDispenser 12 36
export Engineer_UseSentryGun
proc Engineer_UseSentryGun 16 24
line 861
;857:
;858://=========================================================================
;859:// Engineer has used a Spanner on the SentryGun
;860:void Engineer_UseSentryGun( gedict_t * gun )
;861:{
line 864
;862:    gedict_t *dist_checker;
;863:
;864:    G_sprint( self, 2, "Level %.0f Sentry Gun has %.0f health, %.0f shells",
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $371
ARGP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 866
;865:	      gun->s.v.weapon, gun->s.v.health, gun->s.v.ammo_shells );
;866:    if ( gun->s.v.weapon == 3 )
ADDRFP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $372
line 867
;867:    {
line 868
;868:	G_sprint( self, 2, ", %.0f rockets", gun->s.v.ammo_rockets );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $374
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ARGF4
ADDRGP4 G_sprint
CALLV
pop
line 869
;869:    }
LABELV $372
line 871
;870:
;871:    if ( gun->has_sentry &&  tg_data.tg_enabled )
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $375
ADDRGP4 tg_data
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $375
line 872
;872:	G_sprint( self, 2, ", static" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $377
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $375
line 874
;873:
;874:    G_sprint( self, 2, "\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $378
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 875
;875:    self->current_menu = MENU_ENGINEER_FIX_SENTRYGUN;
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 17
ASGNI4
line 876
;876:    self->menu_count = MENU_REFRESH_RATE;
ADDRGP4 self
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 25
ASGNI4
line 877
;877:    self->building = gun;
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 878
;878:    dist_checker = spawn(  );
ADDRLP4 12
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 879
;879:    dist_checker->s.v.classname = "timer";
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 $267
ASGNP4
line 880
;880:    dist_checker->s.v.owner = EDICT_TO_PROG( self );
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
line 881
;881:    dist_checker->s.v.enemy = EDICT_TO_PROG( gun );
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
line 882
;882:    dist_checker->s.v.think = ( func_t ) CheckDistance;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 CheckDistance
CVPU4 4
CVUI4 4
ASGNI4
line 883
;883:    dist_checker->s.v.nextthink = g_globalvars.time + 0.3;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1050253722
ADDF4
ASGNF4
line 884
;884:}
LABELV $370
endproc Engineer_UseSentryGun 16 24
export Engineer_RotateSG
proc Engineer_RotateSG 1056 12
line 887
;885:
;886:void 	Engineer_RotateSG(  )
;887:{
line 891
;888:        int angle;
;889:        char    value[1024];
;890:
;891:	if( !tg_data.tg_enabled  && (self->playerclass != PC_ENGINEER ))
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
NEI4 $381
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 9
EQI4 $381
line 892
;892:		return;
ADDRGP4 $380
JUMPV
LABELV $381
line 894
;893:
;894:	if( self->current_menu != MENU_ENGINEER_FIX_SENTRYGUN )
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
CNSTI4 17
EQI4 $383
line 895
;895:		return;
ADDRGP4 $380
JUMPV
LABELV $383
line 897
;896:
;897:        if( trap_CmdArgc() != 2)
ADDRLP4 1028
ADDRGP4 trap_CmdArgc
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 2
EQI4 $385
line 898
;898:        	return;
ADDRGP4 $380
JUMPV
LABELV $385
line 900
;899:
;900:        trap_CmdArgv( 1, value, sizeof( value ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_CmdArgv
CALLV
pop
line 901
;901:        if( !strcmp( value,"point") )
ADDRLP4 0
ARGP4
ADDRGP4 $389
ARGP4
ADDRLP4 1032
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $387
line 902
;902:        {
line 903
;903:                self->building->waitmin = anglemod( ( int ) ( self->s.v.angles[1] - 50 ) );
ADDRLP4 1036
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
CNSTF4 1112014848
SUBF4
CVFI4 4
CVIF4 4
ARGF4
ADDRLP4 1040
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRLP4 1036
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 1092
ADDP4
ADDRLP4 1040
INDIRF4
ASGNF4
line 904
;904:                self->building->waitmax = anglemod( ( int ) ( self->s.v.angles[1] + 50 ) );
ADDRLP4 1044
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 1044
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
CNSTF4 1112014848
ADDF4
CVFI4 4
CVIF4 4
ARGF4
ADDRLP4 1048
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRLP4 1044
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 1096
ADDP4
ADDRLP4 1048
INDIRF4
ASGNF4
line 905
;905:                return;
ADDRGP4 $380
JUMPV
LABELV $387
line 907
;906:        }
;907:        angle = atoi(value);
ADDRLP4 0
ARGP4
ADDRLP4 1036
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1024
ADDRLP4 1036
INDIRI4
ASGNI4
line 908
;908:	self->building->waitmin = anglemod( self->building->waitmin + angle );
ADDRLP4 1040
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 1092
ADDP4
ASGNP4
ADDRLP4 1040
INDIRP4
INDIRF4
ADDRLP4 1024
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 1044
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRLP4 1040
INDIRP4
ADDRLP4 1044
INDIRF4
ASGNF4
line 909
;909:	self->building->waitmax = anglemod( self->building->waitmax + angle );
ADDRLP4 1048
ADDRGP4 self
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CNSTI4 1096
ADDP4
ASGNP4
ADDRLP4 1048
INDIRP4
INDIRF4
ADDRLP4 1024
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 1052
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRLP4 1048
INDIRP4
ADDRLP4 1052
INDIRF4
ASGNF4
line 910
;910:}
LABELV $380
endproc Engineer_RotateSG 1056 12
export CheckSentry
proc CheckSentry 28 12
line 913
;911:
;912:void CheckSentry( gedict_t * gunhead )
;913:{
line 917
;914:    vec3_t dist;
;915:    gedict_t *gunbase;
;916:
;917:    gunbase = gunhead->trigger_field;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
ASGNP4
line 918
;918:    VectorSubtract( gunbase->s.v.origin, gunhead->s.v.origin, dist );
ADDRLP4 16
CNSTI4 156
ASGNI4
ADDRLP4 0
ADDRLP4 12
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
CNSTI4 160
ASGNI4
ADDRLP4 0+4
ADDRLP4 12
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
ADDRLP4 24
CNSTI4 164
ASGNI4
ADDRLP4 0+8
ADDRLP4 12
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 919
;919:    if ( vlen( dist ) > 15 )
ADDRLP4 0
ARGP4
ADDRLP4 16
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 16
INDIRF4
CNSTF4 1097859072
LEF4 $393
line 920
;920:    {
line 921
;921:	G_bprint( 1, "%s's sentry gun malfunctioned\n", self->real_owner->s.v.netname );
CNSTI4 1
ARGI4
ADDRGP4 $395
ARGP4
ADDRGP4 self
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
line 922
;922:	Sentry_Die(  );
ADDRGP4 Sentry_Die
CALLV
pop
line 923
;923:    }
LABELV $393
line 924
;924:}
LABELV $390
endproc CheckSentry 28 12
export CheckDistance
proc CheckDistance 32 8
line 930
;925:
;926://=========================================================================
;927:// Think function for the timer which checks the distance between the 
;928:// Engineer and the building he's using
;929:void CheckDistance(  )
;930:{
line 934
;931:    vec3_t dist;
;932:    gedict_t *owner, *enemy;
;933:
;934:    owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 935
;935:    enemy = PROG_TO_EDICT( self->s.v.enemy );
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 938
;936:    // Check to see if the Engineer's spanner'ed a different building 
;937:    // without leaving the area of this one.
;938:    if ( owner->building != enemy )
ADDRLP4 0
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
EQU4 $397
line 939
;939:    {
line 940
;940:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 941
;941:	return;
ADDRGP4 $396
JUMPV
LABELV $397
line 944
;942:    }
;943:
;944:    VectorSubtract( enemy->s.v.origin, owner->s.v.origin, dist );
ADDRLP4 20
CNSTI4 156
ASGNI4
ADDRLP4 8
ADDRLP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
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
ADDRLP4 8+4
ADDRLP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
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
ADDRLP4 8+8
ADDRLP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 945
;945:    if ( vlen( dist ) > 64 )
ADDRLP4 8
ARGP4
ADDRLP4 20
ADDRGP4 vlen
CALLF4
ASGNF4
ADDRLP4 20
INDIRF4
CNSTF4 1115684864
LEF4 $401
line 946
;946:    {
line 947
;947:	CenterPrint( owner, "\n" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $378
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
line 948
;948:	owner->menu_count = MENU_REFRESH_RATE;
ADDRLP4 0
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 25
ASGNI4
line 949
;949:	owner->current_menu = MENU_DEFAULT;
ADDRLP4 0
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 1
ASGNI4
line 950
;950:	owner->building = world;
ADDRLP4 0
INDIRP4
CNSTI4 972
ADDP4
ADDRGP4 world
INDIRP4
ASGNP4
line 951
;951:	dremove( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 dremove
CALLV
pop
line 952
;952:	return;
ADDRGP4 $396
JUMPV
LABELV $401
line 954
;953:    }
;954:    self->s.v.nextthink = g_globalvars.time + 0.3;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1050253722
ADDF4
ASGNF4
line 955
;955:}
LABELV $396
endproc CheckDistance 32 8
export DestroyBuilding
proc DestroyBuilding 36 24
line 958
;956:
;957:void DestroyBuilding( gedict_t * eng, char *bld )
;958:{
line 963
;959:    gedict_t *te;
;960:    gedict_t *oldself;
;961:    float pos;
;962:
;963:    for ( te = world; (te = trap_find( te, FOFS( s.v.classname ), bld )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $408
JUMPV
LABELV $405
line 964
;964:    {
line 965
;965:	if ( te->real_owner == eng )
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $409
line 966
;966:	{
line 967
;967:	    pos = trap_pointcontents( PASSVEC3( te->s.v.origin ) );
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
ADDRLP4 16
ADDRGP4 trap_pointcontents
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 968
;968:	    if ( pos == CONTENT_SOLID || pos == CONTENT_SKY )
ADDRLP4 4
INDIRF4
CNSTF4 3221225472
EQF4 $413
ADDRLP4 4
INDIRF4
CNSTF4 3233808384
NEF4 $411
LABELV $413
line 969
;969:	    {
line 970
;970:		oldself = self;
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
line 971
;971:		self = eng;
ADDRGP4 self
ADDRFP4 0
INDIRP4
ASGNP4
line 972
;972:		self->s.v.ammo_cells = self->s.v.ammo_cells + 100;
ADDRLP4 24
ADDRGP4 self
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CNSTF4 1120403456
ADDF4
ASGNF4
line 973
;973:		bound_other_ammo( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 bound_other_ammo
CALLV
pop
line 974
;974:		W_SetCurrentAmmo(  );
ADDRGP4 W_SetCurrentAmmo
CALLV
pop
line 975
;975:		self = oldself;
ADDRGP4 self
ADDRLP4 8
INDIRP4
ASGNP4
line 976
;976:	    }
LABELV $411
line 977
;977:	    if ( te->real_owner->building == te )
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 972
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
NEU4 $414
line 978
;978:	    {
line 979
;979:		if ( !te->real_owner->StatusBarSize )
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 1488
ADDP4
INDIRI4
CNSTI4 0
NEI4 $416
line 980
;980:		    CenterPrint( te->real_owner, "\n" );
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
ARGP4
ADDRGP4 $378
ARGP4
ADDRGP4 CenterPrint
CALLV
pop
ADDRGP4 $417
JUMPV
LABELV $416
line 982
;981:		else
;982:		    te->real_owner->StatusRefreshTime = g_globalvars.time + 0.1;
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 1484
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
LABELV $417
line 983
;983:		te->real_owner->menu_count = MENU_REFRESH_RATE;
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 25
ASGNI4
line 984
;984:		te->real_owner->current_menu = MENU_DEFAULT;
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 948
ADDP4
CNSTI4 1
ASGNI4
line 985
;985:		te->real_owner->building = world;
ADDRLP4 0
INDIRP4
CNSTI4 976
ADDP4
INDIRP4
CNSTI4 972
ADDP4
ADDRGP4 world
INDIRP4
ASGNP4
line 986
;986:	    }
LABELV $414
line 987
;987:          if( tg_data.tg_enabled )
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
EQI4 $419
line 988
;988:	    	te->has_sentry = 0;
ADDRLP4 0
INDIRP4
CNSTI4 1000
ADDP4
CNSTI4 0
ASGNI4
LABELV $419
line 989
;989:	    TF_T_Damage( te, world, world, 500, 0, 0 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 world
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTF4 1140457472
ARGF4
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 TF_T_Damage
CALLV
pop
line 990
;990:	}
LABELV $409
line 991
;991:    }
LABELV $406
line 963
LABELV $408
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRFP4 4
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
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $405
line 992
;992:}
LABELV $404
endproc DestroyBuilding 36 24
export Engineer_RemoveBuildings
proc Engineer_RemoveBuildings 0 8
line 995
;993:
;994:void Engineer_RemoveBuildings( gedict_t * eng )
;995:{
line 996
;996:    DestroyBuilding( eng, "building_dispenser" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $92
ARGP4
ADDRGP4 DestroyBuilding
CALLV
pop
line 997
;997:    DestroyBuilding( eng, "building_sentrygun" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $338
ARGP4
ADDRGP4 DestroyBuilding
CALLV
pop
line 999
;998:#ifdef HAS_SENTRY_CHECK
;999:    if( eng->has_sentry)
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
CNSTI4 0
EQI4 $422
line 1000
;1000:    {
line 1001
;1001:    	G_dprintf("Warning Engineer_RemoveBuildings: eng->has_sentry == %d\n",eng->has_sentry);
ADDRGP4 $424
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_dprintf
CALLV
pop
line 1002
;1002:    	eng->has_sentry = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
CNSTI4 0
ASGNI4
line 1003
;1003:    }
LABELV $422
line 1005
;1004:#endif
;1005:}
LABELV $421
endproc Engineer_RemoveBuildings 0 8
export Eng_SGUp
proc Eng_SGUp 16 20
line 1009
;1006://=======================================
;1007:// TG Stuff
;1008:void Eng_SGUp(  )
;1009:{
line 1013
;1010:    gedict_t *sg;
;1011://    int numupg = 0;
;1012:
;1013:    for ( sg = world; (sg = trap_find( sg, FOFS( s.v.classname ), "building_sentrygun" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $429
JUMPV
LABELV $426
line 1014
;1014:    {
line 1015
;1015:	if ( sg->s.v.weapon == 3 && sg->s.v.ammo_shells == 144 && sg->s.v.ammo_rockets == 20
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $430
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
CNSTF4 1125122048
NEF4 $430
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1101004800
NEF4 $430
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRF4
NEF4 $430
line 1017
;1016:	     && sg->s.v.health == sg->s.v.max_health )
;1017:	    continue;
ADDRGP4 $427
JUMPV
LABELV $430
line 1019
;1018:
;1019:	sg->s.v.weapon = 3;
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1077936128
ASGNF4
line 1020
;1020:	sg->s.v.max_health = 216;
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
CNSTF4 1129840640
ASGNF4
line 1021
;1021:	sg->maxammo_shells = 144;
ADDRLP4 0
INDIRP4
CNSTI4 904
ADDP4
CNSTI4 144
ASGNI4
line 1022
;1022:	sg->s.v.health = sg->s.v.max_health;
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
line 1023
;1023:	sound( sg, 3, "weapons/turrset.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $340
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
line 1024
;1024:	sg->s.v.think = ( func_t ) lvl3_sentry_stand;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 lvl3_sentry_stand
CVPU4 4
CVUI4 4
ASGNI4
line 1025
;1025:	sg->s.v.skin = 2;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTF4 1073741824
ASGNF4
line 1026
;1026:	G_sprint( self, 2, "You have upgraded/fixed/reloaded sentrygun\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $432
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1027
;1027:	sg->s.v.ammo_shells = 144;
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
CNSTF4 1125122048
ASGNF4
line 1028
;1028:	sg->s.v.ammo_rockets = 20;
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
CNSTF4 1101004800
ASGNF4
line 1029
;1029:	return;
ADDRGP4 $425
JUMPV
LABELV $427
line 1013
LABELV $429
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $338
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
NEU4 $426
line 1031
;1030:    }
;1031:    G_sprint( self, 2, "no sg to upgrade\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $433
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1032
;1032:}
LABELV $425
endproc Eng_SGUp 16 20
export Eng_DispLoad
proc Eng_DispLoad 24 12
line 1035
;1033:
;1034:void Eng_DispLoad(  )
;1035:{
line 1039
;1036:    gedict_t *disp;
;1037:    float power;
;1038:
;1039:    for ( disp = world; (disp = trap_find( disp, FOFS( s.v.classname ), "building_dispenser" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $438
JUMPV
LABELV $435
line 1040
;1040:    {
line 1041
;1041:	disp->s.v.ammo_cells = disp->s.v.ammo_cells + 20;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1101004800
ADDF4
ASGNF4
line 1042
;1042:	disp->s.v.ammo_rockets = disp->s.v.ammo_rockets + 15;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1043
;1043:	if ( disp->s.v.ammo_rockets > 300 )
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 1133903872
LEF4 $439
line 1044
;1044:	    disp->s.v.ammo_rockets = 300;
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
CNSTF4 1133903872
ASGNF4
LABELV $439
line 1045
;1045:	if ( disp->s.v.ammo_cells > 400 )
ADDRLP4 0
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 1137180672
LEF4 $441
line 1046
;1046:	    disp->s.v.ammo_cells = 400;
ADDRLP4 0
INDIRP4
CNSTI4 332
ADDP4
CNSTF4 1137180672
ASGNF4
LABELV $441
line 1047
;1047:	self->hook_out = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1436
ADDP4
CNSTI4 0
ASGNI4
line 1048
;1048:	power = ceil( 25 + disp->s.v.ammo_rockets * 1.5 + disp->s.v.ammo_cells );
CNSTF4 1069547520
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
MULF4
CNSTF4 1103626240
ADDF4
ADDRLP4 0
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRLP4 20
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 20
INDIRF4
ASGNF4
line 1049
;1049:	if ( power > 250 )
ADDRLP4 4
INDIRF4
CNSTF4 1132068864
LEF4 $443
line 1050
;1050:	    power = 250;
ADDRLP4 4
CNSTF4 1132068864
ASGNF4
LABELV $443
line 1051
;1051:	G_bprint( 2, "maximum detdispenser damage - %.0f\n", power );
CNSTI4 2
ARGI4
ADDRGP4 $445
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 G_bprint
CALLV
pop
line 1052
;1052:	return;
ADDRGP4 $434
JUMPV
LABELV $436
line 1039
LABELV $438
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $92
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
NEU4 $435
line 1054
;1053:    }
;1054:    G_sprint( self, 2, "no disp\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $446
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1055
;1055:}
LABELV $434
endproc Eng_DispLoad 24 12
export Eng_DispUnload
proc Eng_DispUnload 24 12
line 1058
;1056:
;1057:void Eng_DispUnload(  )
;1058:{
line 1062
;1059:    gedict_t *disp;
;1060:    float power;
;1061:
;1062:    for ( disp = world; (disp = trap_find( disp, FOFS( s.v.classname ), "building_dispenser" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $451
JUMPV
LABELV $448
line 1063
;1063:    {
line 1064
;1064:	disp->s.v.ammo_cells = disp->s.v.ammo_cells - 20;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 332
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
line 1065
;1065:	disp->s.v.ammo_rockets = disp->s.v.ammo_rockets - 15;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CNSTF4 1097859072
SUBF4
ASGNF4
line 1066
;1066:	if ( disp->s.v.ammo_rockets < 0 )
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
CNSTF4 0
GEF4 $452
line 1067
;1067:	    disp->s.v.ammo_rockets = 0;
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
CNSTF4 0
ASGNF4
LABELV $452
line 1068
;1068:	if ( disp->s.v.ammo_cells < 0 )
ADDRLP4 0
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
CNSTF4 0
GEF4 $454
line 1069
;1069:	    disp->s.v.ammo_cells = 0;
ADDRLP4 0
INDIRP4
CNSTI4 332
ADDP4
CNSTF4 0
ASGNF4
LABELV $454
line 1070
;1070:	self->hook_out = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1436
ADDP4
CNSTI4 0
ASGNI4
line 1071
;1071:	power = ceil( 25 + disp->s.v.ammo_rockets * 1.5 + disp->s.v.ammo_cells );
CNSTF4 1069547520
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
MULF4
CNSTF4 1103626240
ADDF4
ADDRLP4 0
INDIRP4
CNSTI4 332
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRLP4 20
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 20
INDIRF4
ASGNF4
line 1072
;1072:	if ( power > 250 )
ADDRLP4 4
INDIRF4
CNSTF4 1132068864
LEF4 $456
line 1073
;1073:	    power = 250;
ADDRLP4 4
CNSTF4 1132068864
ASGNF4
LABELV $456
line 1074
;1074:	G_bprint( 2, "maximum detdispenser damage - %.0f\n", power );
CNSTI4 2
ARGI4
ADDRGP4 $445
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 G_bprint
CALLV
pop
line 1075
;1075:	return;
ADDRGP4 $447
JUMPV
LABELV $449
line 1062
LABELV $451
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $92
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
NEU4 $448
line 1077
;1076:    }
;1077:    G_sprint( self, 2, "no disp\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $446
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1078
;1078:}
LABELV $447
endproc Eng_DispUnload 24 12
export Eng_SGReload
proc Eng_SGReload 24 20
line 1081
;1079:
;1080:void Eng_SGReload(  )
;1081:{
line 1084
;1082:    gedict_t *sg;
;1083:
;1084:    for ( sg = world; (sg = trap_find( sg, FOFS( s.v.classname ), "building_sentrygun" )); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $462
JUMPV
LABELV $459
line 1085
;1085:    {
line 1086
;1086:	if ( sg->s.v.ammo_shells == sg->maxammo_shells && sg->s.v.ammo_rockets == sg->maxammo_rockets
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 904
ADDP4
INDIRI4
CVIF4 4
NEF4 $463
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 916
ADDP4
INDIRI4
CVIF4 4
NEF4 $463
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRF4
NEF4 $463
line 1088
;1087:	     && sg->s.v.health == sg->s.v.max_health )
;1088:	    continue;
ADDRGP4 $460
JUMPV
LABELV $463
line 1089
;1089:	sg->s.v.health = sg->s.v.max_health;
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
line 1090
;1090:	sg->s.v.ammo_shells = sg->maxammo_shells;
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 904
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1091
;1091:	sg->s.v.ammo_rockets = sg->maxammo_rockets;
ADDRLP4 0
INDIRP4
CNSTI4 328
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 916
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1092
;1092:	sound( sg, 3, "weapons/turrset.wav", 1, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 $340
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
line 1093
;1093:	G_sprint( self, 2, "You have fixed/reloaded ONE sentrygun\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $465
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1094
;1094:	return;
ADDRGP4 $458
JUMPV
LABELV $460
line 1084
LABELV $462
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $338
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
NEU4 $459
line 1096
;1095:    }
;1096:    G_sprint( self, 2, "no sg to reload\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $466
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 1098
;1097:
;1098:}
LABELV $458
endproc Eng_SGReload 24 20
import BackpackTouch
import ammo_touch
import weapon_touch
import Sentry_MuzzleFlash
import Sentry_Fire
import Sentry_Die
import Sentry_Pain
import Sentry_HuntTarget
import Sentry_FoundTarget
import Sentry_FindTarget_Angel
import Sentry_FindTarget
import Sentry_Rotate
import lvl3_sentry_atk3
import lvl3_sentry_atk2
import lvl3_sentry_atk1
import lvl3_sentry_stand
import lvl2_sentry_atk3
import lvl2_sentry_atk2
import lvl2_sentry_atk1
import lvl2_sentry_stand
import lvl1_sentry_atk3
import lvl1_sentry_atk2
import lvl1_sentry_atk1
import lvl1_sentry_stand
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
import TF_zoom
import ScannerSwitch
import BioInfection_MonsterDecay
import BioInfection_Decay
import Engineer_UseMortar
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
LABELV $466
byte 1 110
byte 1 111
byte 1 32
byte 1 115
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $465
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 47
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 79
byte 1 78
byte 1 69
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
LABELV $446
byte 1 110
byte 1 111
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $445
byte 1 109
byte 1 97
byte 1 120
byte 1 105
byte 1 109
byte 1 117
byte 1 109
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 100
byte 1 105
byte 1 115
byte 1 112
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 114
byte 1 32
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 32
byte 1 45
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $433
byte 1 110
byte 1 111
byte 1 32
byte 1 115
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 112
byte 1 103
byte 1 114
byte 1 97
byte 1 100
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $432
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 117
byte 1 112
byte 1 103
byte 1 114
byte 1 97
byte 1 100
byte 1 101
byte 1 100
byte 1 47
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 47
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 101
byte 1 100
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
LABELV $424
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 69
byte 1 110
byte 1 103
byte 1 105
byte 1 110
byte 1 101
byte 1 101
byte 1 114
byte 1 95
byte 1 82
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 66
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 115
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 103
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
byte 1 61
byte 1 61
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $395
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
byte 1 32
byte 1 109
byte 1 97
byte 1 108
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $389
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $378
byte 1 10
byte 1 0
align 1
LABELV $377
byte 1 44
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 105
byte 1 99
byte 1 0
align 1
LABELV $374
byte 1 44
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $371
byte 1 76
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
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
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 44
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $368
byte 1 68
byte 1 105
byte 1 115
byte 1 112
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 114
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 10
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 44
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 10
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 44
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $365
byte 1 89
byte 1 111
byte 1 117
byte 1 114
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
LABELV $363
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
LABELV $362
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
LABELV $361
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
byte 1 49
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $349
byte 1 69
byte 1 110
byte 1 101
byte 1 109
byte 1 105
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 117
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
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
byte 1 33
byte 1 10
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
byte 1 0
align 1
LABELV $339
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
LABELV $338
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
LABELV $334
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
byte 1 0
align 1
LABELV $333
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
LABELV $332
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 116
byte 1 32
byte 1 97
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
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $331
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 105
byte 1 115
byte 1 104
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
byte 1 116
byte 1 104
byte 1 101
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
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $325
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 68
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
LABELV $324
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 105
byte 1 115
byte 1 104
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
byte 1 116
byte 1 104
byte 1 101
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
LABELV $277
byte 1 100
byte 1 101
byte 1 116
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $267
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
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
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 97
byte 1 105
byte 1 114
byte 1 33
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $263
byte 1 78
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
byte 1 114
byte 1 111
byte 1 111
byte 1 109
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $256
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 111
byte 1 98
byte 1 106
byte 1 116
byte 1 111
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 32
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
byte 1 95
byte 1 66
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $251
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
LABELV $250
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
LABELV $245
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 32
byte 1 111
byte 1 110
byte 1 108
byte 1 121
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 111
byte 1 110
byte 1 101
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
byte 1 46
byte 1 10
byte 1 84
byte 1 114
byte 1 121
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 109
byte 1 97
byte 1 110
byte 1 116
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 111
byte 1 108
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $236
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
LABELV $235
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
LABELV $230
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 32
byte 1 111
byte 1 110
byte 1 108
byte 1 121
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 111
byte 1 110
byte 1 101
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
byte 1 84
byte 1 114
byte 1 121
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 109
byte 1 97
byte 1 110
byte 1 116
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 111
byte 1 108
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $132
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $127
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 32
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $126
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 100
byte 1 111
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 111
byte 1 117
byte 1 103
byte 1 104
byte 1 32
byte 1 109
byte 1 101
byte 1 116
byte 1 97
byte 1 108
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 10
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 121
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 10
byte 1 10
byte 1 0
align 1
LABELV $107
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $100
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 98
byte 1 111
byte 1 120
byte 1 0
align 1
LABELV $92
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
LABELV $88
byte 1 112
byte 1 105
byte 1 112
byte 1 101
byte 1 98
byte 1 111
byte 1 109
byte 1 98
byte 1 0
align 1
LABELV $69
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
LABELV $66
byte 1 69
byte 1 77
byte 1 80
byte 1 69
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 100
byte 1 101
byte 1 58
byte 1 32
byte 1 65
byte 1 116
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $65
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $62
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $59
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $56
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 115
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $53
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $31
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
LABELV $29
byte 1 0
align 1
LABELV $12
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
