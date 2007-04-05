export NailGrenadeTouch
code
proc NailGrenadeTouch 12 20
file "..\src\tsoldier.c"
line 32
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
;21: *  $Id: tsoldier.c,v 1.5 2004/12/23 03:16:15 AngelD Exp $
;22: */
;23:
;24:#include "g_local.h"
;25:void    NailGrenadeExplode(  );
;26:void    NailGrenadeNailEm(  );
;27:void    NailGrenadeLaunchNail(  );
;28:void    GrenadeExplode(  );
;29:void    superspike_touch(  );
;30:
;31:void NailGrenadeTouch(  )
;32:{
line 33
;33:	if ( EDICT_TO_PROG( other ) == self->s.v.owner )
ADDRGP4 other
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
NEI4 $12
line 34
;34:		return;
ADDRGP4 $11
JUMPV
LABELV $12
line 35
;35:	sound( self, 1, "weapons/bounce.wav", 1, 1 );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 $14
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
line 36
;36:	if ( VectorCompareF( self->s.v.velocity, 0, 0, 0 ) )
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
EQI4 $15
line 37
;37:		SetVector( self->s.v.avelocity, 0, 0, 0 );
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
LABELV $15
line 38
;38:}
LABELV $11
endproc NailGrenadeTouch 12 20
export NailGrenadeExplode
proc NailGrenadeExplode 44 32
line 41
;39:
;40:void NailGrenadeExplode(  )
;41:{
line 45
;42:	gedict_t *te, *owner;
;43:	vec3_t  neworigin;
;44:
;45:	owner = PROG_TO_EDICT( self->s.v.owner );
ADDRLP4 16
ADDRGP4 self
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 46
;46:	owner->no_active_nail_grens += 1;
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 1088
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
line 47
;47:	if ( owner->no_active_nail_grens > 2 )
ADDRLP4 16
INDIRP4
CNSTI4 1088
ADDP4
INDIRI4
CNSTI4 2
LEI4 $18
line 48
;48:	{
line 50
;49:
;50:		te = trap_find( world, FOFS( s.v.classname ), "grenade" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $20
ARGP4
ADDRLP4 24
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
ADDRGP4 $22
JUMPV
LABELV $21
line 52
;51:		while ( te )
;52:		{
line 53
;53:			if ( te->s.v.owner == self->s.v.owner && te->no_active_nail_grens == 1 )
ADDRLP4 32
CNSTI4 480
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
ADDRGP4 self
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
NEI4 $24
ADDRLP4 0
INDIRP4
CNSTI4 1088
ADDP4
INDIRI4
CNSTI4 1
NEI4 $24
line 54
;54:			{
line 55
;55:				te->s.v.weapon = 9;
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1091567616
ASGNF4
line 56
;56:				te->s.v.think = ( func_t ) GrenadeExplode;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 GrenadeExplode
CVPU4 4
CVUI4 4
ASGNI4
line 57
;57:				te->s.v.nextthink = g_globalvars.time + 0.1;
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 58
;58:			}
LABELV $24
line 59
;59:			te = trap_find( te, FOFS( s.v.classname ), "grenade" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $20
ARGP4
ADDRLP4 36
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
line 60
;60:		}
LABELV $22
line 51
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $21
line 61
;61:	}
LABELV $18
line 62
;62:	self->no_active_nail_grens = owner->no_active_nail_grens;
ADDRLP4 24
CNSTI4 1088
ASGNI4
ADDRGP4 self
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ADDRLP4 16
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 63
;63:	self->s.v.movetype = MOVETYPE_FLY;
ADDRGP4 self
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1084227584
ASGNF4
line 64
;64:	neworigin[0] = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 65
;65:	neworigin[1] = 0;
ADDRLP4 4+4
CNSTF4 0
ASGNF4
line 66
;66:	neworigin[2] = 32;
ADDRLP4 4+8
CNSTF4 1107296256
ASGNF4
line 68
;67:
;68:	if(!tg_data.tg_enabled)
ADDRGP4 tg_data
INDIRI4
CNSTI4 0
NEI4 $29
line 69
;69:	{
line 70
;70:        	traceline( PASSVEC3( self->s.v.origin ), self->s.v.origin[0] + neworigin[0],
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ASGNF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 36
ADDRLP4 28
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ASGNF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 40
ADDRLP4 28
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ASGNF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ARGF4
ADDRLP4 36
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDF4
ARGF4
ADDRLP4 40
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 traceline
CALLV
pop
line 73
;71:        		   self->s.v.origin[1] + neworigin[1], self->s.v.origin[2] + neworigin[2], 1, self );
;72:
;73:        	if ( g_globalvars.trace_fraction != 1 )
ADDRGP4 g_globalvars+272
INDIRF4
CNSTF4 1065353216
EQF4 $33
line 74
;74:        	{
line 75
;75:        		neworigin[2] = neworigin[2] * g_globalvars.trace_fraction - 1;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRGP4 g_globalvars+272
INDIRF4
MULF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 76
;76:        	}
LABELV $33
line 77
;77:	}
LABELV $29
line 78
;78:        VectorAdd( self->s.v.origin , neworigin, neworigin);
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRGP4 self
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRGP4 self
INDIRP4
CNSTI4 164
ADDP4
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDF4
ASGNF4
line 79
;79:	setorigin( self, PASSVEC3(neworigin) );
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
line 81
;80:
;81:	SetVector( self->s.v.avelocity, 0, 500, 0 );
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
CNSTF4 1140457472
ASGNF4
ADDRGP4 self
INDIRP4
CNSTI4 212
ADDP4
CNSTF4 0
ASGNF4
line 82
;82:	self->s.v.nextthink = g_globalvars.time + 0.7;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1060320051
ADDF4
ASGNF4
line 83
;83:	self->s.v.think = ( func_t ) NailGrenadeNailEm;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 NailGrenadeNailEm
CVPU4 4
CVUI4 4
ASGNI4
line 84
;84:}
LABELV $17
endproc NailGrenadeExplode 44 32
export NailGrenadeNailEm
proc NailGrenadeNailEm 0 0
line 87
;85:
;86:void NailGrenadeNailEm(  )
;87:{
line 88
;88:	SetVector( self->s.v.velocity, 0, 0, 0 );
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
line 90
;90:	self->s.v.think = ( func_t ) NailGrenadeLaunchNail;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 NailGrenadeLaunchNail
CVPU4 4
CVUI4 4
ASGNI4
line 91
;91:	self->playerclass = 0;
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
CNSTI4 0
ASGNI4
line 92
;92:}
LABELV $46
endproc NailGrenadeNailEm 0 0
export NailGrenadeLaunchNail
proc NailGrenadeLaunchNail 20 8
line 95
;93:
;94:void NailGrenadeLaunchNail(  )
;95:{
line 100
;96:	float   i;
;97:	float   j;
;98:	float   current_yaw;
;99:
;100:	i = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 101
;101:	if (tf_data.old_nail == TRUE)
ADDRGP4 tf_data+228
INDIRI4
CNSTI4 1
NEI4 $61
line 102
;102:	{
ADDRGP4 $53
JUMPV
LABELV $52
line 104
;103:		while ( i < 3 )
;104:		{
line 105
;105:			j = ( g_random(  ) + 2 ) * 5;
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 4
CNSTF4 1084227584
ADDRLP4 12
INDIRF4
CNSTF4 1073741824
ADDF4
MULF4
ASGNF4
line 106
;106:			current_yaw = anglemod( self->s.v.angles[1] + j );
ADDRGP4 self
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ARGF4
ADDRLP4 16
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 16
INDIRF4
ASGNF4
line 107
;107:			self->s.v.angles[1] = current_yaw;
ADDRGP4 self
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 108
;108:			self->s.v.angles[0] = 0;
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 0
ASGNF4
line 109
;109:			self->s.v.angles[2] = 0;
ADDRGP4 self
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 0
ASGNF4
line 110
;110:			makevectors( self->s.v.angles );
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 111
;111:			tf_data.deathmsg = DMSG_GREN_NAIL;
ADDRGP4 tf_data+88
CNSTI4 9
ASGNI4
line 112
;112:			launch_spike( self->s.v.origin, g_globalvars.v_forward );
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRGP4 g_globalvars+228
ARGP4
ADDRGP4 launch_spike
CALLV
pop
line 113
;113:			newmis->s.v.touch = ( func_t ) superspike_touch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 superspike_touch
CVPU4 4
CVUI4 4
ASGNI4
line 114
;114:			newmis->s.v.weapon = 9;
ADDRGP4 newmis
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1091567616
ASGNF4
line 115
;115:			i = i + 1;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 116
;116:		}
LABELV $53
line 103
ADDRLP4 0
INDIRF4
CNSTF4 1077936128
LTF4 $52
line 117
;117:		self->playerclass += 1;
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 118
;118:		self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 119
;119:		if ( self->playerclass > 50 )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 50
LEI4 $50
line 120
;120:		{
line 121
;121:			self->s.v.weapon = 9;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1091567616
ASGNF4
line 122
;122:			self->s.v.think = ( func_t ) GrenadeExplode;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 GrenadeExplode
CVPU4 4
CVUI4 4
ASGNI4
line 123
;123:		}
line 124
;124:	}
ADDRGP4 $50
JUMPV
line 126
;125:	else
;126:	{
LABELV $60
line 128
;127:		while ( i < 1 )
;128:		{
line 129
;129:			j = ( g_random(  ) + 2 ) * 5;
ADDRLP4 12
ADDRGP4 g_random
CALLF4
ASGNF4
ADDRLP4 4
CNSTF4 1084227584
ADDRLP4 12
INDIRF4
CNSTF4 1073741824
ADDF4
MULF4
ASGNF4
line 130
;130:			current_yaw = anglemod( self->s.v.angles[1] + j );
ADDRGP4 self
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ARGF4
ADDRLP4 16
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 16
INDIRF4
ASGNF4
line 131
;131:			self->s.v.angles[1] = current_yaw;
ADDRGP4 self
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 132
;132:			self->s.v.angles[0] = 0;
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 0
ASGNF4
line 133
;133:			self->s.v.angles[2] = 0;
ADDRGP4 self
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 0
ASGNF4
line 134
;134:			makevectors( self->s.v.angles );
ADDRGP4 self
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 135
;135:			tf_data.deathmsg = DMSG_GREN_NAIL;
ADDRGP4 tf_data+88
CNSTI4 9
ASGNI4
line 136
;136:			launch_spike( self->s.v.origin, g_globalvars.v_forward );
ADDRGP4 self
INDIRP4
CNSTI4 156
ADDP4
ARGP4
ADDRGP4 g_globalvars+228
ARGP4
ADDRGP4 launch_spike
CALLV
pop
line 137
;137:			newmis->s.v.touch = ( func_t ) superspike_touch;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 superspike_touch
CVPU4 4
CVUI4 4
ASGNI4
line 138
;138:			newmis->s.v.weapon = 9;
ADDRGP4 newmis
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1091567616
ASGNF4
line 139
;139:			i = i + 1;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 140
;140:		}
LABELV $61
line 127
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
LTF4 $60
line 141
;141:		self->playerclass += 1;
ADDRLP4 12
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 142
;142:		self->s.v.nextthink = g_globalvars.time + 0.1;
ADDRGP4 self
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1036831949
ADDF4
ASGNF4
line 143
;143:		if ( self->playerclass > 40 )
ADDRGP4 self
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
CNSTI4 40
LEI4 $66
line 144
;144:		{
line 145
;145:			self->s.v.weapon = 9;
ADDRGP4 self
INDIRP4
CNSTI4 304
ADDP4
CNSTF4 1091567616
ASGNF4
line 146
;146:			self->s.v.think = ( func_t ) GrenadeExplode;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 GrenadeExplode
CVPU4 4
CVUI4 4
ASGNI4
line 147
;147:		}
LABELV $66
line 148
;148:	}
LABELV $50
line 149
;149:}
LABELV $48
endproc NailGrenadeLaunchNail 20 8
import superspike_touch
import GrenadeExplode
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
LABELV $20
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $14
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
