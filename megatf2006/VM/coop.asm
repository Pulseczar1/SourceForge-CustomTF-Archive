export DroppedKeyThink
code
proc DroppedKeyThink 0 0
file "..\src\coop.c"
line 27
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
;21: *  $Id: coop.c,v 1.7 2004/12/23 03:16:15 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:void    key_touch(  );
;25:
;26:void DroppedKeyThink(  )
;27:{
line 28
;28:	self->s.v.think = ( func_t ) SUB_Null;
ADDRGP4 self
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 SUB_Null
CVPU4 4
CVUI4 4
ASGNI4
line 29
;29:	self->s.v.touch = ( func_t ) key_touch;
ADDRGP4 self
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 key_touch
CVPU4 4
CVUI4 4
ASGNI4
line 30
;30:	self->s.v.owner = EDICT_TO_PROG( world );
ADDRGP4 self
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
line 31
;31:}
LABELV $11
endproc DroppedKeyThink 0 0
data
export key_models1
align 4
LABELV key_models1
address $12
address $13
address $14
export key_names1
align 4
LABELV key_names1
address $15
address $16
address $17
export key_sound1
align 4
LABELV key_sound1
address $18
address $19
address $20
export key_models2
align 4
LABELV key_models2
address $21
address $22
address $23
export key_names2
align 4
LABELV key_names2
address $24
address $25
address $26
export key_sound2
align 4
LABELV key_sound2
address $18
address $19
address $20
export DropKey
code
proc DropKey 28 28
line 42
;32:
;33:char   *key_models1[3] = { "progs/w_s_key.mdl", "progs/m_s_key.mdl", "progs/b_s_key.mdl" };
;34:char   *key_names1[3] = { "silver key", "silver runekey", "silver keycard" };
;35:char   *key_sound1[3] = { "misc/medkey.wav", "misc/runekey.wav", "misc/basekey.wav" };
;36:
;37:char   *key_models2[3] = { "progs/w_g_key.mdl", "progs/m_g_key.mdl", "progs/b_g_key.mdl" };
;38:char   *key_names2[3] = { "gold key", "gold runekey", "gold keycard" };
;39:char   *key_sound2[3] = { "misc/medkey.wav", "misc/runekey.wav", "misc/basekey.wav" };
;40:
;41:void DropKey(  )
;42:{
line 44
;43:
;44:	if ( ( ( int ) self->s.v.items & IT_KEY1 ) || ( ( int ) self->s.v.items & IT_KEY2 ) )
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 131072
BANDI4
ADDRLP4 4
INDIRI4
NEI4 $30
ADDRLP4 0
INDIRI4
CNSTI4 262144
BANDI4
ADDRLP4 4
INDIRI4
EQI4 $28
LABELV $30
line 45
;45:	{
line 46
;46:		newmis = spawn(  );
ADDRLP4 8
ADDRGP4 spawn
CALLP4
ASGNP4
ADDRGP4 newmis
ADDRLP4 8
INDIRP4
ASGNP4
line 47
;47:		g_globalvars.newmis = EDICT_TO_PROG( newmis );
ADDRGP4 g_globalvars+132
ADDRGP4 newmis
INDIRP4
CVPU4 4
ADDRGP4 g_edicts
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 48
;48:		if ( ( int ) self->s.v.items & IT_KEY1 )
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CVFI4 4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $32
line 49
;49:		{
line 50
;50:			self->s.v.items = ( int ) self->s.v.items - ( ( int ) self->s.v.items & IT_KEY1 );
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
CNSTI4 131072
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 51
;51:			newmis->s.v.items = IT_KEY1;
ADDRGP4 newmis
INDIRP4
CNSTI4 336
ADDP4
CNSTF4 1207959552
ASGNF4
line 53
;52:
;53:			setmodel( newmis, key_models1[world->worldtype] );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 key_models1
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 54
;54:			newmis->s.v.netname = key_names1[world->worldtype];
ADDRGP4 newmis
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 key_names1
ADDP4
INDIRP4
ASGNP4
line 55
;55:			newmis->s.v.noise = key_sound1[world->worldtype];
ADDRGP4 newmis
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 key_sound1
ADDP4
INDIRP4
ASGNP4
line 57
;56:
;57:		} else
ADDRGP4 $33
JUMPV
LABELV $32
line 58
;58:		{
line 59
;59:			if ( ( int ) self->s.v.items & IT_KEY2 )
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CVFI4 4
CNSTI4 262144
BANDI4
CNSTI4 0
EQI4 $34
line 60
;60:			{
line 61
;61:				self->s.v.items = ( int ) self->s.v.items - ( ( int ) self->s.v.items & IT_KEY2 );
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
CNSTI4 262144
BANDI4
SUBI4
CVIF4 4
ASGNF4
line 62
;62:				newmis->s.v.items = IT_KEY2;
ADDRGP4 newmis
INDIRP4
CNSTI4 336
ADDP4
CNSTF4 1216348160
ASGNF4
line 63
;63:				setmodel( newmis, key_models2[world->worldtype] );
ADDRGP4 newmis
INDIRP4
ARGP4
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 key_models2
ADDP4
INDIRP4
ARGP4
ADDRGP4 setmodel
CALLV
pop
line 64
;64:				newmis->s.v.netname = key_names2[world->worldtype];
ADDRGP4 newmis
INDIRP4
CNSTI4 396
ADDP4
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 key_names2
ADDP4
INDIRP4
ASGNP4
line 65
;65:				newmis->s.v.noise = key_sound2[world->worldtype];
ADDRGP4 newmis
INDIRP4
CNSTI4 504
ADDP4
ADDRGP4 world
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 key_sound2
ADDP4
INDIRP4
ASGNP4
line 66
;66:			}
LABELV $34
line 67
;67:		}
LABELV $33
line 68
;68:		newmis->s.v.owner = EDICT_TO_PROG( self );
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
line 69
;69:		newmis->s.v.touch = ( func_t ) SUB_Null;
ADDRGP4 newmis
INDIRP4
CNSTI4 272
ADDP4
ADDRGP4 SUB_Null
CVPU4 4
CVUI4 4
ASGNI4
line 70
;70:		setorigin( newmis, self->s.v.origin[0], self->s.v.origin[1], self->s.v.origin[2] + 16 );
ADDRGP4 newmis
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
CNSTF4 1098907648
ADDF4
ARGF4
ADDRGP4 setorigin
CALLV
pop
line 71
;71:		makevectors( self->s.v.v_angle );
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
ARGP4
ADDRGP4 makevectors
CALLV
pop
line 73
;72:
;73:		VectorNormalize( g_globalvars.v_forward );
ADDRGP4 g_globalvars+228
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 74
;74:		VectorScale( g_globalvars.v_forward, 300, newmis->s.v.velocity );
ADDRGP4 g_globalvars+228
ARGP4
CNSTF4 1133903872
ARGF4
ADDRGP4 newmis
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 VectorScale
CALLV
pop
line 75
;75:		newmis->s.v.velocity[2] += 200;
ADDRLP4 16
ADDRGP4 newmis
INDIRP4
CNSTI4 188
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1128792064
ADDF4
ASGNF4
line 78
;76:		//newmis->s.v.velocity = normalize(v_forward) * 300 + '0 0 200';
;77:
;78:		newmis->s.v.movetype = MOVETYPE_TOSS;
ADDRGP4 newmis
INDIRP4
CNSTI4 148
ADDP4
CNSTF4 1086324736
ASGNF4
line 79
;79:		newmis->s.v.solid = SOLID_TRIGGER;
ADDRGP4 newmis
INDIRP4
CNSTI4 152
ADDP4
CNSTF4 1065353216
ASGNF4
line 80
;80:		newmis->s.v.deadflag = DEAD_DYING;
ADDRGP4 newmis
INDIRP4
CNSTI4 348
ADDP4
CNSTF4 1065353216
ASGNF4
line 81
;81:		setsize( newmis, -16, -16, -24, 16, 16, 32 );
ADDRGP4 newmis
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
line 82
;82:		newmis->s.v.think = ( func_t ) DroppedKeyThink;
ADDRGP4 newmis
INDIRP4
CNSTI4 280
ADDP4
ADDRGP4 DroppedKeyThink
CVPU4 4
CVUI4 4
ASGNI4
line 83
;83:		newmis->s.v.nextthink = g_globalvars.time + 1.5;
ADDRGP4 newmis
INDIRP4
CNSTI4 288
ADDP4
ADDRGP4 g_globalvars+124
INDIRF4
CNSTF4 1069547520
ADDF4
ASGNF4
line 84
;84:	} else
ADDRGP4 $29
JUMPV
LABELV $28
line 85
;85:		G_sprint( self, 2, "You don't have a key\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $39
ARGP4
ADDRGP4 G_sprint
CALLV
pop
LABELV $29
line 86
;86:}
LABELV $27
endproc DropKey 28 28
export DoorShouldOpen
proc DoorShouldOpen 32 16
line 89
;87:
;88:int DoorShouldOpen(  )
;89:{
line 92
;90:	gedict_t *ptr;
;91:	int     plyrcount;
;92:	gedict_t *plyr1 = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 93
;93:	gedict_t *plyr2 = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
line 95
;94:
;95:	if ( coop != 2 )
ADDRGP4 coop
INDIRI4
CNSTI4 2
EQI4 $41
line 96
;96:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $40
JUMPV
LABELV $41
line 97
;97:	plyrcount = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 98
;98:	ptr = trap_find( world, FOFS( s.v.classname ), "player" );
ADDRGP4 world
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $43
ARGP4
ADDRLP4 16
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
ADDRGP4 $45
JUMPV
LABELV $44
line 100
;99:	while ( ptr != world )
;100:	{
line 101
;101:		if ( !( ptr->tf_items & ( int ) self->s.v.items ) && ptr->playerclass
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 832
ADDP4
INDIRI4
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CVFI4 4
BANDI4
ADDRLP4 24
INDIRI4
NEI4 $47
ADDRLP4 0
INDIRP4
CNSTI4 820
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $47
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRF4
CNSTF4 0
EQF4 $47
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $47
line 103
;102:		     && ptr->s.v.solid && ptr->s.v.model )
;103:		{
line 104
;104:			plyrcount++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 105
;105:			if ( plyrcount == 1 )
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $49
line 106
;106:				plyr1 = ptr;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $50
JUMPV
LABELV $49
line 108
;107:			else
;108:			{
line 109
;109:				if ( plyrcount == 2 )
ADDRLP4 4
INDIRI4
CNSTI4 2
NEI4 $51
line 110
;110:					plyr2 = ptr;
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $51
line 111
;111:			}
LABELV $50
line 112
;112:		}
LABELV $47
line 113
;113:		ptr = trap_find( ptr, FOFS( s.v.classname ), "player" );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $43
ARGP4
ADDRLP4 28
ADDRGP4 trap_find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 114
;114:	}
LABELV $45
line 99
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
NEU4 $44
line 115
;115:	if ( plyrcount )
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $53
line 116
;116:	{
line 117
;117:		if ( plyrcount == 1 )
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $55
line 118
;118:		{
line 119
;119:			G_bprint( 2, "%s needs", plyr1->s.v.netname );
CNSTI4 2
ARGI4
ADDRGP4 $57
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 120
;120:		} else
ADDRGP4 $56
JUMPV
LABELV $55
line 121
;121:		{
line 122
;122:			if ( plyrcount == 2 )
ADDRLP4 4
INDIRI4
CNSTI4 2
NEI4 $58
line 123
;123:			{
line 124
;124:				G_bprint( 2, "%s and %s", plyr1->s.v.netname, plyr2->s.v.netname );
CNSTI4 2
ARGI4
ADDRGP4 $60
ARGP4
ADDRLP4 20
CNSTI4 396
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 125
;125:			} else
ADDRGP4 $59
JUMPV
LABELV $58
line 126
;126:				G_bprint( 2, "More players need" );
CNSTI4 2
ARGI4
ADDRGP4 $61
ARGP4
ADDRGP4 G_bprint
CALLV
pop
LABELV $59
line 127
;127:		}
LABELV $56
line 128
;128:		G_bprint( 2, " to unlock the " );
CNSTI4 2
ARGI4
ADDRGP4 $62
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 129
;129:		if ( ( int ) self->s.v.items & IT_KEY1 )
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CVFI4 4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $63
line 130
;130:			G_bprint( 2, "silver" );
CNSTI4 2
ARGI4
ADDRGP4 $65
ARGP4
ADDRGP4 G_bprint
CALLV
pop
ADDRGP4 $64
JUMPV
LABELV $63
line 132
;131:		else
;132:			G_bprint( 2, "gold" );
CNSTI4 2
ARGI4
ADDRGP4 $66
ARGP4
ADDRGP4 G_bprint
CALLV
pop
LABELV $64
line 133
;133:		G_bprint( 2, " door\n" );
CNSTI4 2
ARGI4
ADDRGP4 $67
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 134
;134:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $40
JUMPV
LABELV $53
line 136
;135:	}
;136:	G_bprint( 2, "The " );
CNSTI4 2
ARGI4
ADDRGP4 $68
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 137
;137:	if ( ( int ) self->s.v.items & IT_KEY1 )
ADDRGP4 self
INDIRP4
CNSTI4 336
ADDP4
INDIRF4
CVFI4 4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $69
line 138
;138:		G_bprint( 2, "silver" );
CNSTI4 2
ARGI4
ADDRGP4 $65
ARGP4
ADDRGP4 G_bprint
CALLV
pop
ADDRGP4 $70
JUMPV
LABELV $69
line 140
;139:	else
;140:		G_bprint( 2, "gold" );
CNSTI4 2
ARGI4
ADDRGP4 $66
ARGP4
ADDRGP4 G_bprint
CALLV
pop
LABELV $70
line 141
;141:	G_bprint( 2, " door has been unlocked\n" );
CNSTI4 2
ARGI4
ADDRGP4 $71
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 142
;142:	return 1;
CNSTI4 1
RETI4
LABELV $40
endproc DoorShouldOpen 32 16
import key_touch
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
LABELV $71
byte 1 32
byte 1 100
byte 1 111
byte 1 111
byte 1 114
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
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $68
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 0
align 1
LABELV $67
byte 1 32
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $66
byte 1 103
byte 1 111
byte 1 108
byte 1 100
byte 1 0
align 1
LABELV $65
byte 1 115
byte 1 105
byte 1 108
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $62
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 0
align 1
LABELV $61
byte 1 77
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $60
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $57
byte 1 37
byte 1 115
byte 1 32
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $43
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $39
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
byte 1 97
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 10
byte 1 0
align 1
LABELV $26
byte 1 103
byte 1 111
byte 1 108
byte 1 100
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 99
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $25
byte 1 103
byte 1 111
byte 1 108
byte 1 100
byte 1 32
byte 1 114
byte 1 117
byte 1 110
byte 1 101
byte 1 107
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $24
byte 1 103
byte 1 111
byte 1 108
byte 1 100
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $23
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 103
byte 1 95
byte 1 107
byte 1 101
byte 1 121
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $22
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 109
byte 1 95
byte 1 103
byte 1 95
byte 1 107
byte 1 101
byte 1 121
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $21
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 119
byte 1 95
byte 1 103
byte 1 95
byte 1 107
byte 1 101
byte 1 121
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $20
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 107
byte 1 101
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $19
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 114
byte 1 117
byte 1 110
byte 1 101
byte 1 107
byte 1 101
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $18
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 109
byte 1 101
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $17
byte 1 115
byte 1 105
byte 1 108
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 99
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $16
byte 1 115
byte 1 105
byte 1 108
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 114
byte 1 117
byte 1 110
byte 1 101
byte 1 107
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $15
byte 1 115
byte 1 105
byte 1 108
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $14
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 115
byte 1 95
byte 1 107
byte 1 101
byte 1 121
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $13
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 109
byte 1 95
byte 1 115
byte 1 95
byte 1 107
byte 1 101
byte 1 121
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
align 1
LABELV $12
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 115
byte 1 47
byte 1 119
byte 1 95
byte 1 115
byte 1 95
byte 1 107
byte 1 101
byte 1 121
byte 1 46
byte 1 109
byte 1 100
byte 1 108
byte 1 0
