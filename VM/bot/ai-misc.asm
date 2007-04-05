export CheckForResupply
code
proc CheckForResupply 4 0
file "..\src\bot\ai-misc.c"
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
;21: *  $Id: ai-misc.c,v 1.3 2005/06/05 05:10:41 AngelD Exp $
;22: */
;23:#include "g_local.h"
;24:
;25:qboolean CheckForResupply()
;26:{
line 27
;27:	if ( self->action & ( BOT_FIGHTING + BOT_AVOIDING_HAZARD ) )
ADDRGP4 self
INDIRP4
CNSTI4 1664
ADDP4
INDIRI4
CNSTI4 34
BANDI4
CNSTI4 0
EQI4 $12
line 28
;28:		return false;
CNSTI4 0
RETI4
ADDRGP4 $11
JUMPV
LABELV $12
line 29
;29:	if ( self->s.v.health < self->s.v.max_health
ADDRLP4 0
ADDRGP4 self
INDIRP4
ASGNP4
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
LTF4 $16
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 928
ADDP4
INDIRI4
CVIF4 4
GEF4 $14
LABELV $16
line 31
;30:	     || self->s.v.armorvalue < self->maxarmor )
;31:		return true;
CNSTI4 1
RETI4
ADDRGP4 $11
JUMPV
LABELV $14
line 32
;32:	return false;
CNSTI4 0
RETI4
LABELV $11
endproc CheckForResupply 4 0
export GoForResupply
proc GoForResupply 0 0
line 36
;33:}
;34:
;35:void GoForResupply()
;36:{
line 37
;37:	if ( self->action == BOT_FIGHTING )
ADDRGP4 self
INDIRP4
CNSTI4 1664
ADDP4
INDIRI4
CNSTI4 2
NEI4 $18
line 38
;38:		return;
ADDRGP4 $17
JUMPV
LABELV $18
line 39
;39:	self->action = BOT_RESUPPLYING;
ADDRGP4 self
INDIRP4
CNSTI4 1664
ADDP4
CNSTI4 16
ASGNI4
line 40
;40:	ClearAllTargets();
ADDRGP4 ClearAllTargets
CALLV
pop
line 41
;41:	ClearAllWaypoints();
ADDRGP4 ClearAllWaypoints
CALLV
pop
line 42
;42:	self->s.v.button1 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 368
ADDP4
CNSTF4 0
ASGNF4
line 43
;43:	self->s.v.button2 = 0;
ADDRGP4 self
INDIRP4
CNSTI4 372
ADDP4
CNSTF4 0
ASGNF4
line 44
;44:}
LABELV $17
endproc GoForResupply 0 0
export PickAName
proc PickAName 0 0
line 47
;45:
;46:char   *PickAName()
;47:{
line 48
;48:	return "Padla-Bot";
ADDRGP4 $21
RETP4
LABELV $20
endproc PickAName 0 0
export BotImpulseMenu
proc BotImpulseMenu 32 16
line 52
;49:}
;50:
;51:int BotImpulseMenu()
;52:{
line 53
;53:	int     subItem = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 55
;54:
;55:	subItem = self->nextimpulse;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 1660
ADDP4
INDIRI4
ASGNI4
line 56
;56:	self->nextimpulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1660
ADDP4
CNSTI4 0
ASGNI4
line 57
;57:	switch ( self->current_menu )
ADDRLP4 4
ADDRGP4 self
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
CNSTI4 2
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $26
ADDRLP4 4
INDIRI4
CNSTI4 3
EQI4 $32
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $23
LABELV $50
ADDRLP4 4
INDIRI4
CNSTI4 12
LTI4 $23
ADDRLP4 4
INDIRI4
CNSTI4 19
GTI4 $23
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $51-48
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $51
address $38
address $39
address $40
address $41
address $23
address $45
address $23
address $49
code
line 58
;58:	{
LABELV $26
line 60
;59:	case MENU_TEAM:
;60:	        if( self->bot_lastmenu == MENU_TEAM )
ADDRGP4 self
INDIRP4
CNSTI4 1684
ADDP4
INDIRI4
CNSTI4 2
NEI4 $27
line 61
;61:	        {
line 62
;62:	                if( self->bot_lastmenucount++ > 5) 
ADDRLP4 24
ADDRGP4 self
INDIRP4
CNSTI4 1688
ADDP4
ASGNP4
ADDRLP4 20
ADDRLP4 24
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRP4
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 5
LEI4 $28
line 63
;63:	                {
line 64
;64:	                        G_bprint(2,"%s :cannot join team %d\n",self->s.v.netname, self->bot_team);
CNSTI4 2
ARGI4
ADDRGP4 $31
ARGP4
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 1672
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
line 65
;65:	                        botDisconnect( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 botDisconnect
CALLV
pop
line 66
;66:	                        return 0;
CNSTI4 0
RETI4
ADDRGP4 $22
JUMPV
line 68
;67:	                }
;68:	        }else
LABELV $27
line 69
;69:	        {
line 70
;70:	                self->bot_lastmenu = MENU_TEAM;
ADDRGP4 self
INDIRP4
CNSTI4 1684
ADDP4
CNSTI4 2
ASGNI4
line 71
;71:	                self->bot_lastmenucount = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1688
ADDP4
CNSTI4 1
ASGNI4
line 72
;72:	        }
LABELV $28
line 73
;73:		return self->bot_team;
ADDRGP4 self
INDIRP4
CNSTI4 1672
ADDP4
INDIRI4
RETI4
ADDRGP4 $22
JUMPV
LABELV $32
line 75
;74:	case MENU_CLASS:
;75:	        if( self->bot_lastmenu == MENU_CLASS )
ADDRGP4 self
INDIRP4
CNSTI4 1684
ADDP4
INDIRI4
CNSTI4 3
NEI4 $33
line 76
;76:	        {
line 77
;77:	                if( self->bot_lastmenucount++ > 5) 
ADDRLP4 24
ADDRGP4 self
INDIRP4
CNSTI4 1688
ADDP4
ASGNP4
ADDRLP4 20
ADDRLP4 24
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRP4
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 5
LEI4 $34
line 78
;78:	                {
line 79
;79:	                        G_bprint(2,"%s :cannot select class %d\n",self->s.v.netname, self->bot_skin);
CNSTI4 2
ARGI4
ADDRGP4 $37
ARGP4
ADDRLP4 28
ADDRGP4 self
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 396
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 1676
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_bprint
CALLV
pop
line 80
;80:	                        botDisconnect( self );
ADDRGP4 self
INDIRP4
ARGP4
ADDRGP4 botDisconnect
CALLV
pop
line 81
;81:	                        return 0;
CNSTI4 0
RETI4
ADDRGP4 $22
JUMPV
line 83
;82:	                }
;83:	        }else
LABELV $33
line 84
;84:	        {
line 85
;85:	                self->bot_lastmenu = MENU_CLASS;
ADDRGP4 self
INDIRP4
CNSTI4 1684
ADDP4
CNSTI4 3
ASGNI4
line 86
;86:	                self->bot_lastmenucount = 1;
ADDRGP4 self
INDIRP4
CNSTI4 1688
ADDP4
CNSTI4 1
ASGNI4
line 87
;87:	        }
LABELV $34
line 88
;88:		return self->bot_skin;
ADDRGP4 self
INDIRP4
CNSTI4 1676
ADDP4
INDIRI4
RETI4
ADDRGP4 $22
JUMPV
LABELV $38
line 90
;89:	case MENU_SPY:
;90:		return 4;
CNSTI4 4
RETI4
ADDRGP4 $22
JUMPV
LABELV $39
line 92
;91:	case MENU_SPY_SKIN:
;92:		return 8;
CNSTI4 8
RETI4
ADDRGP4 $22
JUMPV
LABELV $40
line 94
;93:	case MENU_SPY_COLOR:
;94:		return self->bot_team;
ADDRGP4 self
INDIRP4
CNSTI4 1672
ADDP4
INDIRI4
RETI4
ADDRGP4 $22
JUMPV
LABELV $41
line 96
;95:	case MENU_ENGINEER:
;96:		return ( subItem ) ? subItem : 4;
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $43
ADDRLP4 20
ADDRLP4 0
INDIRI4
ASGNI4
ADDRGP4 $44
JUMPV
LABELV $43
ADDRLP4 20
CNSTI4 4
ASGNI4
LABELV $44
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $22
JUMPV
LABELV $45
line 98
;97:	case MENU_ENGINEER_FIX_SENTRYGUN:
;98:		return ( subItem ) ? ( self->s.v.button0 = 0, subItem ) : 5;
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $47
ADDRGP4 self
INDIRP4
CNSTI4 364
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 24
ADDRLP4 0
INDIRI4
ASGNI4
ADDRGP4 $48
JUMPV
LABELV $47
ADDRLP4 24
CNSTI4 5
ASGNI4
LABELV $48
ADDRLP4 24
INDIRI4
RETI4
ADDRGP4 $22
JUMPV
LABELV $49
line 100
;99:	case MENU_DISPENSER:
;100:		return 3;
CNSTI4 3
RETI4
ADDRGP4 $22
JUMPV
LABELV $23
line 102
;101:	default:
;102:		return self->s.v.impulse;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
RETI4
LABELV $22
endproc BotImpulseMenu 32 16
export BotImpulse
proc BotImpulse 4 0
line 107
;103:	}
;104:}
;105:
;106:int BotImpulse()
;107:{
line 110
;108:	int     Temp;
;109:
;110:	if ( self->nextimpulse )
ADDRGP4 self
INDIRP4
CNSTI4 1660
ADDP4
INDIRI4
CNSTI4 0
EQI4 $54
line 111
;111:	{
line 112
;112:		Temp = self->nextimpulse;
ADDRLP4 0
ADDRGP4 self
INDIRP4
CNSTI4 1660
ADDP4
INDIRI4
ASGNI4
line 113
;113:		self->nextimpulse = 0;
ADDRGP4 self
INDIRP4
CNSTI4 1660
ADDP4
CNSTI4 0
ASGNI4
line 114
;114:		return Temp;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $53
JUMPV
LABELV $54
line 117
;115:
;116:	}
;117:        return self->s.v.impulse;
ADDRGP4 self
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
CVFI4 4
RETI4
LABELV $53
endproc BotImpulse 4 0
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
LABELV $37
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $31
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $21
byte 1 80
byte 1 97
byte 1 100
byte 1 108
byte 1 97
byte 1 45
byte 1 66
byte 1 111
byte 1 116
byte 1 0
