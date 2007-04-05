export CL_KeyState
code
proc CL_KeyState 4 0
file "..\src\bot\qw.c"
line 26
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
;21: *  $Id: qw.c,v 1.8 2005/06/05 05:10:41 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:int CL_KeyState( int key )
;26:{
line 27
;27:	return ( self->keys & key ) != 0;
ADDRGP4 self
INDIRP4
CNSTI4 1656
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
BANDI4
CNSTI4 0
EQI4 $13
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $14
JUMPV
LABELV $13
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $14
ADDRLP4 0
INDIRI4
RETI4
LABELV $11
endproc CL_KeyState 4 0
export Bot_CL_KeyMove
proc Bot_CL_KeyMove 64 40
line 31
;28:}
;29:
;30:void Bot_CL_KeyMove(  )
;31:{
line 32
;32:	int     forwardmove = 0, sidemove = 0, upmove = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
line 33
;33:	int     buttons = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 35
;34:
;35:	buttons = ( ( self->s.v.button0 ) ? 1 : 0 ) + ( ( self->s.v.button2 ) ? 2 : 0 );
ADDRGP4 self
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
CNSTF4 0
EQF4 $18
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $19
JUMPV
LABELV $18
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $19
ADDRGP4 self
INDIRP4
CNSTI4 372
ADDP4
INDIRF4
CNSTF4 0
EQF4 $20
ADDRLP4 20
CNSTI4 2
ASGNI4
ADDRGP4 $21
JUMPV
LABELV $20
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $21
ADDRLP4 12
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
ADDI4
ASGNI4
line 37
;36:
;37:	sidemove += self->maxstrafespeed * CL_KeyState( KEY_MOVERIGHT );
CNSTI4 8
ARGI4
ADDRLP4 24
ADDRGP4 CL_KeyState
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRGP4 self
INDIRP4
CNSTI4 936
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
MULI4
ADDI4
ASGNI4
line 38
;38:	sidemove -= self->maxstrafespeed * CL_KeyState( KEY_MOVELEFT );
CNSTI4 4
ARGI4
ADDRLP4 28
ADDRGP4 CL_KeyState
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRGP4 self
INDIRP4
CNSTI4 936
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
MULI4
SUBI4
ASGNI4
line 40
;39:
;40:	upmove += 200 * CL_KeyState( KEY_MOVEUP );
CNSTI4 1
ARGI4
ADDRLP4 32
ADDRGP4 CL_KeyState
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 200
ADDRLP4 32
INDIRI4
MULI4
ADDI4
ASGNI4
line 41
;41:	upmove -= 200 * CL_KeyState( KEY_MOVEDOWN );
CNSTI4 2
ARGI4
ADDRLP4 36
ADDRGP4 CL_KeyState
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 200
ADDRLP4 36
INDIRI4
MULI4
SUBI4
ASGNI4
line 43
;42:
;43:	forwardmove += self->maxfbspeed * CL_KeyState( KEY_MOVEFORWARD );
CNSTI4 16
ARGI4
ADDRLP4 40
ADDRGP4 CL_KeyState
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRGP4 self
INDIRP4
CNSTI4 932
ADDP4
INDIRI4
ADDRLP4 40
INDIRI4
MULI4
ADDI4
ASGNI4
line 44
;44:	forwardmove -= self->maxfbspeed * CL_KeyState( KEY_MOVEBACK );
CNSTI4 32
ARGI4
ADDRLP4 44
ADDRGP4 CL_KeyState
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRGP4 self
INDIRP4
CNSTI4 932
ADDP4
INDIRI4
ADDRLP4 44
INDIRI4
MULI4
SUBI4
ASGNI4
line 46
;45:
;46:	if ( self->s.v.v_angle[0] > 80 )
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
INDIRF4
CNSTF4 1117782016
LEF4 $22
line 47
;47:		self->s.v.v_angle[0] = 80;
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
CNSTF4 1117782016
ASGNF4
ADDRGP4 $23
JUMPV
LABELV $22
line 49
;48:	else
;49:	{
line 50
;50:		if ( self->s.v.v_angle[0] < -70 )
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
INDIRF4
CNSTF4 3263954944
GEF4 $24
line 51
;51:			self->s.v.v_angle[0] = -70;
ADDRGP4 self
INDIRP4
CNSTI4 384
ADDP4
CNSTF4 3263954944
ASGNF4
LABELV $24
line 52
;52:	}
LABELV $23
line 55
;53:
;54:	//self->s.v.v_angle[2] = 0;
;55:	self->s.v.v_angle[1] = anglemod( self->s.v.v_angle[1] );
ADDRLP4 48
ADDRGP4 self
INDIRP4
CNSTI4 388
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 anglemod
CALLF4
ASGNF4
ADDRLP4 48
INDIRP4
ADDRLP4 52
INDIRF4
ASGNF4
line 57
;56:
;57:	trap_SetBotCMD( NUM_FOR_EDICT( self ), bot_frametime * 1000,
ADDRGP4 self
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
ARGI4
CNSTF4 1148846080
ADDRGP4 bot_frametime
INDIRF4
MULF4
CVFI4 4
ARGI4
ADDRLP4 60
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 384
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 388
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 392
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 trap_SetBotCMD
CALLI4
pop
line 60
;58:			PASSVEC3(self->s.v.v_angle),
;59:			forwardmove, sidemove, upmove, buttons, self->s.v.impulse );
;60:}
LABELV $15
endproc Bot_CL_KeyMove 64 40
export BotFrame
proc BotFrame 24 12
line 62
;61:void BotFrame( void )
;62:{
line 65
;63:	gedict_t *te, *oself;
;64:
;65:	oself = self;
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
line 66
;66:	for ( te = world; ( te = trap_find( te, FOFS( s.v.classname ), "player" ) ); )
ADDRLP4 0
ADDRGP4 world
INDIRP4
ASGNP4
ADDRGP4 $30
JUMPV
LABELV $27
line 67
;67:	{
line 68
;68:		if ( te->has_disconnected )
ADDRLP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
EQI4 $32
line 69
;69:			continue;
ADDRGP4 $28
JUMPV
LABELV $32
line 71
;70:
;71:		if ( !te->isBot )
ADDRLP4 0
INDIRP4
CNSTI4 1652
ADDP4
INDIRI4
CNSTI4 0
NEI4 $34
line 72
;72:			continue;
ADDRGP4 $28
JUMPV
LABELV $34
line 74
;73:
;74:		self = te;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 75
;75:		if( !tf_data.enable_bot )
ADDRGP4 tf_data+180
INDIRI4
CNSTI4 0
NEI4 $36
line 76
;76:		{
line 77
;77:		        botDisconnect( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 botDisconnect
CALLV
pop
line 78
;78:		        continue;
ADDRGP4 $28
JUMPV
LABELV $36
line 80
;79:		}
;80:		self->old_button0 = self->s.v.button0;
ADDRLP4 8
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 1636
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 81
;81:		self->old_button2 = self->s.v.button2;
ADDRLP4 12
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 1644
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 372
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 82
;82:		self->old_keys = self->keys;
ADDRLP4 16
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 1648
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 1656
ADDP4
INDIRI4
ASGNI4
line 84
;83:
;84:               	self->s.v.button0 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 364
ADDP4
CNSTF4 0
ASGNF4
line 85
;85:       		self->s.v.button2 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 372
ADDP4
CNSTF4 0
ASGNF4
line 86
;86:       		self->s.v.impulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
CNSTF4 0
ASGNF4
line 87
;87:       		self->keys = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1656
ADDP4
CNSTI4 0
ASGNI4
line 88
;88:       		if( self->team_no && self->team_no != 1)
ADDRLP4 20
ADDRGP4 self
INDIRP4
CNSTI4 960
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $39
ADDRLP4 20
INDIRI4
CNSTI4 1
EQI4 $39
line 89
;89:       		{
line 90
;90:       		        G_bprint(3,"%s: i'm dont know how to play for team 2\n",self->s.v.netname);
CNSTI4 3
ARGI4
ADDRGP4 $41
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
line 91
;91:       		        botDisconnect(self);
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 botDisconnect
CALLV
pop
line 92
;92:       		        continue;
ADDRGP4 $28
JUMPV
LABELV $39
line 94
;93:       		}
;94:       		Bot_AI(  );
ADDRGP4 Bot_AI
CALLV
pop
line 95
;95:		Bot_CL_KeyMove(  );
ADDRGP4 Bot_CL_KeyMove
CALLV
pop
line 96
;96:	}
LABELV $28
line 66
LABELV $30
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 216
ARGI4
ADDRGP4 $31
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
NEU4 $27
line 97
;97:	self = oself;
ADDRGP4 self
ADDRLP4 4
INDIRP4
ASGNP4
line 99
;98:
;99:}
LABELV $26
endproc BotFrame 24 12
export botConnect
proc botConnect 20 16
line 102
;100:
;101:void botConnect( int whichteam, int whichClass, char* name )
;102:{
line 106
;103:	gedict_t *oself;
;104:	int     ednum;
;105:
;106:	gedict_t *ent = &g_edicts[ednum = trap_AddBot( name, 0, 0, "base" )];
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 $43
ARGP4
ADDRLP4 16
ADDRGP4 trap_AddBot
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 0
CNSTI4 1824
ADDRLP4 16
INDIRI4
MULI4
ADDRGP4 g_edicts
ADDP4
ASGNP4
line 108
;107:
;108:	if ( ent == world )
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 world
INDIRP4
CVPU4 4
NEU4 $44
line 109
;109:	{
line 110
;110:		G_sprint( self, 2, "cannot add bot\n" );
ADDRGP4 self
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 $46
ARGP4
ADDRGP4 G_sprint
CALLV
pop
line 111
;111:		return;
ADDRGP4 $42
JUMPV
LABELV $44
line 114
;112:	}
;113:
;114:	oself = self;
ADDRLP4 4
ADDRGP4 self
INDIRP4
ASGNP4
line 115
;115:	self = ent;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 116
;116:	self->bot_skin = whichClass;
ADDRGP4 self
INDIRP4
CNSTI4 1676
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 117
;117:	self->bot_team = whichteam;
ADDRGP4 self
INDIRP4
CNSTI4 1672
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 119
;118:	
;119:	ClearAllWaypoints(  );
ADDRGP4 ClearAllWaypoints
CALLV
pop
line 120
;120:	ClearAllTargets(  );
ADDRGP4 ClearAllTargets
CALLV
pop
line 121
;121:	self->action = BOT_RESUPPLYING;
ADDRGP4 self
INDIRP4
CNSTI4 1664
ADDP4
CNSTI4 16
ASGNI4
line 122
;122:	self->obs_time = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1736
ADDP4
CNSTF4 0
ASGNF4
line 123
;123:	self->oldAction = BOT_IDLE;
ADDRGP4 self
INDIRP4
CNSTI4 1668
ADDP4
CNSTI4 1
ASGNI4
line 125
;124:
;125:	self = oself;
ADDRGP4 self
ADDRLP4 4
INDIRP4
ASGNP4
line 127
;126:
;127:}
LABELV $42
endproc botConnect 20 16
export botDisconnect
proc botDisconnect 8 8
line 130
;128:
;129:void botDisconnect( gedict_t * te )
;130:{
line 133
;131:	gedict_t *oself;
;132:
;133:	if ( !te->isBot )
ADDRFP4 0
INDIRP4
CNSTI4 1652
ADDP4
INDIRI4
CNSTI4 0
NEI4 $48
line 134
;134:	{
line 135
;135:		G_bprint( 2, "WARNING!!! Trying to disconnect non bot client\n" );
CNSTI4 2
ARGI4
ADDRGP4 $50
ARGP4
ADDRGP4 G_bprint
CALLV
pop
line 136
;136:		return;
ADDRGP4 $47
JUMPV
LABELV $48
line 138
;137:	}
;138:	oself = self;
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
line 139
;139:	self = te;
ADDRGP4 self
ADDRFP4 0
INDIRP4
ASGNP4
line 140
;140:	trap_RemoveBot( NUM_FOR_EDICT( te ) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 NUM_FOR_EDICT
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_RemoveBot
CALLI4
pop
line 141
;141:	self = oself;
ADDRGP4 self
ADDRLP4 0
INDIRP4
ASGNP4
line 142
;142:}
LABELV $47
endproc botDisconnect 8 8
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
LABELV $50
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 33
byte 1 33
byte 1 33
byte 1 32
byte 1 84
byte 1 114
byte 1 121
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 110
byte 1 111
byte 1 110
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $46
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 100
byte 1 100
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $43
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $41
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 105
byte 1 39
byte 1 109
byte 1 32
byte 1 100
byte 1 111
byte 1 110
byte 1 116
byte 1 32
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 32
byte 1 104
byte 1 111
byte 1 119
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 50
byte 1 10
byte 1 0
align 1
LABELV $31
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
