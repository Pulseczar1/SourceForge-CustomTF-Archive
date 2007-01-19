
// bdube: note that this file is no longer merged with Doom3 updates
//
// MERGE_DATE 09/30/2004

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "Game_local.h"

#include "Weapon.h"
#include "Projectile.h"
#include "client/ClientModel.h"
#include "Healing_Station.h"

idCVar net_predictionErrorDecay( "net_predictionErrorDecay", "112", CVAR_FLOAT | CVAR_GAME | CVAR_NOCHEAT, "time in milliseconds it takes to fade away prediction errors", 0.0f, 200.0f );
idCVar net_showPredictionError( "net_showPredictionError", "-1", CVAR_INTEGER | CVAR_GAME | CVAR_NOCHEAT, "show prediction errors for the given client", -1, MAX_CLIENTS );

/*
===============================================================================

	Player control.
	This object handles all player movement and world interaction.

===============================================================================
*/

// <q4f>

// how much to increment the conc effect speed every frame
#define CONC_INCREMENT		 0.0015f;

// minimum amount of conc until it's stopped
#define CONC_MINIMUM		 0.5f

// time between when a player primes a grenade and when he can throw it
const int GREN_THROW_DELAY_MS = 800;

// time after a grenade is thrown that it should explode
const int GREN_FUSE_TIME_MS = 4000;

// </q4f>

// distance between ladder rungs (actually is half that distance, but this sounds better)
const int LADDER_RUNG_DISTANCE = 32;

// amount of health per dose from the health station
const int HEALTH_PER_DOSE = 10;

// time before a weapon dropped to the floor disappears
const int WEAPON_DROP_TIME = 20 * 1000;

// time before a next or prev weapon switch happens
const int	WEAPON_SWITCH_DELAY		= 150;

const float	PLAYER_ITEM_DROP_SPEED	= 100.0f;

// how many units to raise spectator above default view height so it's in the head of someone
const int SPECTATE_RAISE = 25;

const int	HEALTH_PULSE		= 1000;			// Regen rate and heal leak rate (for health > 100)
const int	ARMOR_PULSE			= 1000;			// armor ticking down due to being higher than maxarmor
const int	AMMO_REGEN_PULSE	= 1000;			// ammo regen in Arena CTF
const int	POWERUP_BLINKS		= 5;			// Number of times the powerup wear off sound plays
const int	POWERUP_BLINK_TIME	= 1000;			// Time between powerup wear off sounds
const float MIN_BOB_SPEED		= 5.0f;			// minimum speed to bob and play run/walk animations at
const int	MAX_RESPAWN_TIME	= 10000;
const int	RAGDOLL_DEATH_TIME	= 3000;
const int	STEPUP_TIME			= 200;
const int	MAX_INVENTORY_ITEMS = 20;

const idEventDef EV_Player_GetButtons( "getButtons", NULL, 'd' );
const idEventDef EV_Player_GetMove( "getMove", NULL, 'v' );
const idEventDef EV_Player_GetViewAngles( "getViewAngles", NULL, 'v' );
const idEventDef EV_Player_SetViewAngles( "setViewAngles", "v" );
const idEventDef EV_Player_EnableWeapon( "enableWeapon" );
const idEventDef EV_Player_DisableWeapon( "disableWeapon" );
const idEventDef EV_Player_GetCurrentWeapon( "getCurrentWeapon", NULL, 's' );
const idEventDef EV_Player_GetPreviousWeapon( "getPreviousWeapon", NULL, 's' );
const idEventDef EV_Player_SelectWeapon( "selectWeapon", "s" );
const idEventDef EV_Player_GetWeaponEntity( "getWeaponEntity", NULL, 'e' );
const idEventDef EV_Player_ExitTeleporter( "exitTeleporter" );
const idEventDef EV_Player_HideTip( "hideTip" );
const idEventDef EV_Player_LevelTrigger( "levelTrigger" );
const idEventDef EV_SpectatorTouch( "spectatorTouch", "et" );
const idEventDef EV_Player_GetViewPos("getViewPos", NULL, 'v');
const idEventDef EV_Player_FinishHearingLoss ( "<finishHearingLoss>", "f" );
const idEventDef EV_Player_GetAmmoData( "getAmmoData", "s", 'v');
const idEventDef EV_Player_SetExtraProjPassEntity( "setExtraProjPassEntity", "E" );
const idEventDef EV_Player_SetArmor( "setArmor", "f" );
const idEventDef EV_Player_DamageEffect( "damageEffect", "sE" );

// <q4f> 
const idEventDef EV_Player_LimitSpeed( "limitSpeed", "ff", NULL );
const idEventDef EV_Player_GetCurrentKiller( "getCurrentKiller", NULL, 'E' );

const idEventDef EV_Player_GetStat( "getStat", "s", 'd' );

const idEventDef EV_Player_GetPlayerName( "getPlayerName", NULL, 's' );



// </q4f>

CLASS_DECLARATION( idActor, idPlayer )
	EVENT( EV_Player_GetButtons,			idPlayer::Event_GetButtons )
	EVENT( EV_Player_GetMove,				idPlayer::Event_GetMove )
	EVENT( EV_Player_GetViewAngles,			idPlayer::Event_GetViewAngles )
	EVENT( EV_Player_SetViewAngles,			idPlayer::Event_SetViewAngles )
	EVENT( EV_Player_EnableWeapon,			idPlayer::Event_EnableWeapon )
	EVENT( EV_Player_DisableWeapon,			idPlayer::Event_DisableWeapon )
	EVENT( EV_Player_GetCurrentWeapon,		idPlayer::Event_GetCurrentWeapon )
	EVENT( EV_Player_GetPreviousWeapon,		idPlayer::Event_GetPreviousWeapon )
	EVENT( EV_Player_SelectWeapon,			idPlayer::Event_SelectWeapon )
	EVENT( EV_Player_GetWeaponEntity,		idPlayer::Event_GetWeaponEntity )
	EVENT( EV_Player_ExitTeleporter,		idPlayer::Event_ExitTeleporter )
	EVENT( EV_Player_HideTip,				idPlayer::Event_HideTip )
	EVENT( EV_Player_LevelTrigger,			idPlayer::Event_LevelTrigger )
	EVENT( EV_Player_GetViewPos,			idPlayer::Event_GetViewPos )
	EVENT( EV_Player_FinishHearingLoss,		idPlayer::Event_FinishHearingLoss )
	EVENT( EV_Player_GetAmmoData,			idPlayer::Event_GetAmmoData )

	EVENT( EV_ApplyImpulse,					idPlayer::Event_ApplyImpulse )
//MCG: setArmor
	EVENT( EV_Player_SetArmor,				idPlayer::Event_SetArmor )

	EVENT( EV_Player_SetExtraProjPassEntity,idPlayer::Event_SetExtraProjPassEntity )
//MCG: direct damage
	EVENT( EV_Player_DamageEffect,			idPlayer::Event_DamageEffect )

	EVENT( EV_Player_LimitSpeed,			idPlayer::Event_LimitSpeed )
	EVENT( EV_Player_GetCurrentKiller,		idPlayer::Event_GetCurrentKiller )
	EVENT( EV_Touch,						idPlayer::Event_Touch )
	EVENT( EV_Player_GetStat,				idPlayer::Event_GetStat )
	EVENT( EV_Player_GetPlayerName,			idPlayer::Event_GetPlayerName )
END_CLASS

/*
==============
idInventory::Clear
==============
*/
void idInventory::Clear( void ) {
	maxHealth		= 0;
	armor			= 0;
	maxarmor		= 0;

	memset( ammo, 0, sizeof( ammo ) );

	// set to -1 so that the gun knows to have a full clip the first time we get it and at the start of the level
	memset( clip, -1, sizeof( clip ) );
	memset( clipSizes, 0, sizeof( clipSizes ) );

 	ammoPredictTime = 0;

	tfitems.Clear();
}

/*
==============
idInventory::GetPersistantData
==============
*/
void idInventory::GetPersistantData( idDict &dict ) {

	const char* name;

	// armor
	dict.SetInt( "armor", armor );

	// ammo
	for( int i = 0; i < MAX_AMMOTYPES; i++ ) {
		name = rvWeapon::GetAmmoNameForIndex( i );
		if ( name ) {
			dict.SetInt( name, ammo[ i ] );
		}
	}
}

/*
==============
idInventory::RestoreInventory
==============
*/
void idInventory::RestoreInventory( idPlayer *owner, const idDict &dict ) {
	int			i;
	const char	*name;

	//Clear();

	// ammo
	for( i = 0; i < MAX_AMMOTYPES; i++ ) {
		name = rvWeapon::GetAmmoNameForIndex ( i );
		if ( name ) {
			ammo[ i ] = dict.GetInt( name );
		}
	}

// mekberg: removed nightmare weapon check.
	Give( owner, dict, "weapon", dict.GetString( "weapon" ), NULL, false );
}

/*
==============
idInventory::Save
==============
*/
void idInventory::Save( idSaveGame *savefile ) const {
}

/*
==============
idInventory::Restore
==============
*/
void idInventory::Restore( idRestoreGame *savefile ) {
}

/*
==============
idInventory::AmmoIndexForAmmoClass
==============
*/
int idInventory::AmmoIndexForAmmoClass( const char *ammo_classname ) const {
	return rvWeapon::GetAmmoIndexForName( ammo_classname );
}

const char* idInventory::AmmoClassForAmmoIndex( int index ) const {
	return rvWeapon::GetAmmoNameForIndex( index );
}

/*
==============
idInventory::MaxAmmoForAmmoClass
==============
*/
int idInventory::MaxAmmoForAmmoClass( idPlayer *owner, const char *ammo_classname ) const {
	return owner->spawnArgs.GetInt( va( "max_%s", ammo_classname ), "0" );
}

/*
==============
idInventory::AmmoIndexForWeaponClass
==============
*/
int idInventory::AmmoIndexForWeaponClass( const char *weapon_classname, int *ammoRequired ) {
	const idDeclEntityDef *decl = gameLocal.FindEntityDef( weapon_classname, false );
	if ( !decl ) {
		gameLocal.Error( "Unknown weapon in decl '%s'", weapon_classname );
	}
	if ( ammoRequired ) {
		*ammoRequired = decl->dict.GetInt( "ammoRequired" );
	}
	return AmmoIndexForAmmoClass( decl->dict.GetString( "ammoType" ) );
}

/*
==============
idInventory::AmmoClassForWeaponClass
==============
*/
const char * idInventory::AmmoClassForWeaponClass( const char *weapon_classname ) {
	const idDeclEntityDef *decl = gameLocal.FindEntityDef( weapon_classname, false );
	if ( !decl ) {
		gameLocal.Error( "Unknown weapon in decl '%s'", weapon_classname );
	}

	return decl->dict.GetString( "ammoType" );
}

/*
==============
idInventory::Give
==============
*/
bool idInventory::Give( idPlayer *owner, const idDict &spawnArgs, const char *statname, const char *value, int *idealWeapon, bool updateHud, bool dropped, bool checkOnly ) {
	int						i;
	const char				*pos;
	const char				*end;
	int						len;
	idStr					weaponString;
	int						max;
	int						amount;

	if ( !idStr::Icmpn( statname, "ammo_", 5 ) ) {
		i = AmmoIndexForAmmoClass( statname );
		max = MaxAmmoForAmmoClass( owner, statname );
		amount = atoi( value );


// mekberg: check max ammo vs clipsize when picking up ammo
		if ( ammo[ i ] >= max ) {
			return false;
		}

		if ( amount && !checkOnly ) {		
			ammo[ i ] += amount;
			if ( ( max > 0 ) && ( ammo[ i ] > max ) ) {
				ammo[ i ] = max;
			}
		}

	} else if ( !idStr::Icmpn( statname, "start_ammo_", 11 ) ) {
		// starting ammo gives only if current ammo is below it
		idStr ammoname( statname );
		ammoname.StripLeading( "start_" );
		i = AmmoIndexForAmmoClass( ammoname.c_str() );
		max = MaxAmmoForAmmoClass( owner, ammoname.c_str() );
		amount = atoi( value );


// mekberg: check max ammo vs clipsize when picking up ammo
		if ( amount && !checkOnly ) {	
			if ( ammo[ i ] >= amount ) {
				amount = 1;
			} else {
				amount = amount - ammo[ i ];
			}
		}

		if ( amount && !checkOnly ) {			
			ammo[ i ] += amount;
			if ( ( max > 0 ) && ( ammo[ i ] > max ) ) {
				ammo[ i ] = max;
			}
		}

	} else if ( !idStr::Icmp( statname, "armor" ) ) {
		if ( armor >= maxarmor * 2 ) {
			return false;
		}
	} else 	if ( !idStr::Icmp( statname, "health" ) ) {
		if ( owner->health >= maxHealth ) {
			return false;
		}
	} else if ( idStr::FindText( statname, "inclip_" ) == 0 ) {
		i = owner->SlotForWeapon ( statname + 7 );
		if ( i != -1 && !checkOnly ) {
			// set, don't add. not going over the clip size limit.
			clip[ i ] = atoi( value );
		}
	} else if ( !idStr::Icmp( statname, "weapon" ) ) {
		bool tookWeapon = false;
 		for( pos = value; pos != NULL; pos = end ) {
			end = strchr( pos, ',' );
			if ( end ) {
				len = end - pos;
				end++;
			} else {
				len = strlen( pos );
			}

			idStr weaponName( pos, 0, len );

			// find the number of the matching weapon names
			i = owner->SlotForWeapon ( weaponName );

// mekberg: check for not found weapons
			if ( i == -1 ) {
				gameLocal.Warning( "Unknown weapon '%s'", weaponName.c_str() );
				return false;
			}
		}
		return tookWeapon;
	} else if ( !idStr::Icmp( statname, "item" ) || !idStr::Icmp( statname, "icon" ) || !idStr::Icmp( statname, "name" ) ) {
		// ignore these as they're handled elsewhere
		return false;
	} else {
		// unknown item
		gameLocal.Warning( "Unknown stat '%s' added to player's inventory", statname );
		return false;
	}

	return true;
}

/*
===============
idInventory::HasAmmo
===============
*/
int idInventory::HasAmmo( int index, int amount ) {
	if ( ( index == 0 ) || amount <= 0 ) {
		// always allow weapons that don't use ammo to fire
		return -1;
	}

	assert( index >= 0 && index < MAX_AMMO );

	// check if we have infinite ammo
	if ( ammo[ index ] < 0 ) {
		return -1;
	}

	// return how many shots we can fire
	return ammo[ index ] / amount;
}

/*
===============
idInventory::HasAmmo
===============
*/
int idInventory::HasAmmo( const char *weapon_classname ) {
	int ammoRequired = 0;
	int index = AmmoIndexForWeaponClass( weapon_classname, &ammoRequired );
	return HasAmmo( index, ammoRequired );
}


/*
===============
idInventory::UseAmmo
===============
*/
bool idInventory::UseAmmo( int index, int amount ) {
	if ( !HasAmmo( index, amount ) ) {
		return false;
	}

	// take an ammo away if not infinite
	if ( ammo[ index ] >= 0 ) {
		ammo[ index ] -= amount;
 		ammoPredictTime = gameLocal.time; // mp client: we predict this. mark time so we're not confused by snapshots
	}

	return true;
}

// <q4f> 

bool idInventory::GiveTFItem( TFCarryItem* item ) {
	if ( !item ) {
		gameLocal.Error( "idInventory::GiveTFItem - item is null." );
	};

	if ( tfitems.Num() >= MAX_TFITEMS ) {
		gameLocal.Warning( "GiveTFItem: player already at max # of items (%d).", MAX_TFITEMS );
		return false;
	}

	int index = tfitems.AddUnique( item );
	if ( index < 0 ) {
		//gameLocal.Error( "Attempting to give item %s to player twice.", item->GetName() );
		gameLocal.Warning( "Attempting to give item %s to player twice.", item->GetName() );
		return false;
	}

	return true;
}

void idInventory::RemoveTFItem( TFCarryItem* item ) {
	tfitems.Remove( item );
}

// </q4f>

/*
==============
idPlayer::idPlayer
==============
*/
idPlayer::idPlayer() {
	memset( &usercmd, 0, sizeof( usercmd ) );

	weaponViewModel = NULL;
	weaponWorldModel = NULL;

	doInitWeapon			= false;
	noclip					= false;
	godmode					= false;

	spawnAnglesSet			= false;
	spawnAngles				= ang_zero;
	viewAngles				= ang_zero;
	deltaViewAngles			= ang_zero;
	cmdAngles				= ang_zero;

	demoViewAngleTime		= 0;
	demoViewAngles			= ang_zero;

	oldButtons				= 0;
	buttonMask				= 0;
	oldFlags				= 0;

	lastHitTime				= 0;

	weapon					= NULL;

	hud						= NULL;
	mphud						= NULL;

	lastDmgTime				= 0;
	deathClearContentsTime	= 0;
	nextHealthPulse			= 0;

	scoreBoardOpen			= false;
	forceScoreBoard			= false;
	forceScoreBoardTime		= 0;
	forceRespawn			= false;
	spectating				= false;
	spectator				= 0;
	wantSpectate			= true;

	lastHitToggle			= false;
	lastArmorHit			= false;

	minRespawnTime			= 0;
	maxRespawnTime			= 0;

	firstPersonViewOrigin	= vec3_zero;
	firstPersonViewAxis		= mat3_identity;

	// <q4f> 

	weaponViewAxis			= mat3_identity;
	
	// </q4f>

	hipJoint					= INVALID_JOINT;
	chestJoint				= INVALID_JOINT;
 	headJoint				= INVALID_JOINT;

	bobFoot					= 0;
	bobFrac					= 0.0f;
	bobfracsin				= 0.0f;
	bobCycle				= 0;
	xyspeed					= 0.0f;
	stepUpTime				= 0;
	stepUpDelta				= 0.0f;
	idealLegsYaw			= 0.0f;
	legsYaw					= 0.0f;
 	legsForward				= true;
	oldViewYaw				= 0.0f;
	viewBobAngles			= ang_zero;
	viewBob					= vec3_zero;
	landChange				= 0;
	landTime				= 0;

	currentWeapon			= -1;
	idealWeapon				= -1;
	previousWeapon			= -1;
	weaponSwitchTime		=  0;
	weaponEnabled			= true;
 	showWeaponViewModel		= 1;


	skin					= NULL;
	weaponViewSkin		= NULL;
	headSkin				= NULL;

	gibDeath				= false;
	gibsLaunched			= false;
	gibDir					= vec3_zero;

	centerView.Init( 0, 0, 0, 0 );

	privateCameraView		= NULL;

	memset( loggedViewAngles, 0, sizeof( loggedViewAngles ) );
	memset( loggedAccel, 0, sizeof( loggedAccel ) );
	memset( loggedPositions, 0, sizeof( loggedPositions ) );
	currentLoggedPosition = 0;
	currentLoggedAccel	= 0;

	focusEnt				= NULL;

	cursor					= NULL;
	
	oldMouseX				= 0;
	oldMouseY				= 0;

	lastDamageDef			= 0;
	lastDamageDir			= vec3_zero;
	lastDamageLocation		= 0;

	predictedFrame			= 0;
	predictedOrigin			= vec3_zero;
	predictedAngles			= ang_zero;
	predictedUpdated		= false;
	predictionOriginError	= vec3_zero;
	predictionAnglesError	= ang_zero;
	predictionErrorTime		= 0;

	fl.networkSync			= true;

 	doingDeathSkin			= false;
 	weaponGone				= false;
	lastSpectateTeleport	= 0;
	hiddenWeapon			= false;
 	teleportEntity			= NULL;
	teleportKiller			= -1;
	lastKiller				= NULL;

 	respawning				= false;
 	lastSpectateChange		= 0;
 	lastTeleFX				= -9999;

 	weaponCatchup			= false;
 	lastSnapshotSequence	= 0;
 
 	spawnedTime				= 0;
 
 	isTelefragged			= false;
	isLagged				= false;
 	isChatting				= false;

	zoomFov.Init ( 0, 0, DefaultFov(), DefaultFov() );
	zoomed					= false;
	
	memset ( cachedWeaponDefs, 0, sizeof(cachedWeaponDefs) );

	lastImpulsePlayer = NULL;
	lastImpulseTime = gameLocal.time;

	reloadModel = false;
	modelDict = NULL;

	disableHud = false;

	mutedPlayers = 0;
	friendPlayers = 0;
	connectTime = 0;

	spectator = 0;
	
	vsMsgState = false;

	deathSkinTime = 0;

	jumpDuringHitch = false;

	for( int i = 0; i < MAX_CONCURRENT_VOICES; i++ ) {
		voiceDest[i] = -1;
		voiceDestTimes[i] = 0;
	}

	// <q4f> 

	team = TEAM_SPEC;

	currentPC = INVALID_CLASS;
	nextPC = INVALID_CLASS;
	restrictedClass = INVALID_CLASS;
	disguiseClass = INVALID_CLASS;
	disguiseTeam = INVALID_TEAM;
	ClearDisguise();

	nextTeamChange = 0;

	AttackerInfo att;
	att.Create( gameLocal.world );
	dmgNoAir.Create( att, "q4f_damage_noair", 1.0f );

	currentLocation = NULL;
	deathLocation = NULL;

	radarTime = 0;
	memset( &radarPositions, 0, sizeof( radarPositions ) );

	ClearHeldGrenade();

	grenadeDef_1 = NULL;
	grenadeDef_2 = NULL;

	sentryGun = NULL;
	detpack = NULL;
	dispenser = NULL;
	dispFillAmount = 0.0f;
	dispFillStartAmount = 0.0f;
	nextTeamChange = 0;

	fxAfflConc = NULL;
	fxAfflDisease = NULL;
	fxAfflFire = NULL;
	fxAfflFlash = NULL;

	CommonClear();

	// </q4f>
}
/*
==============
idPlayer::SetShowHud
==============
*/
void idPlayer::SetShowHud( bool showHud )	{
	disableHud = !showHud;
}

/*
==============
idPlayer::SetShowHud
==============
*/
bool idPlayer::GetShowHud( void )	{
	return !disableHud;
}

/*
==============
idPlayer::SetWeapon
==============
*/
void idPlayer::SetWeapon( int weaponIndex ) {
	if ( weapon && weaponIndex == currentWeapon ) {
		return;
	}
	
	// Clear the weapon entity
	if ( weaponRunning ) {
		gameLocal.Error( "idPlayer::SetWeapon -attempting to delete weapon while it's running" );
	}
	delete weapon;
	weapon = NULL;

	previousWeapon	= currentWeapon;
	currentWeapon	= weaponIndex;
	weaponGone		= false;		

	if ( weaponIndex < 0 || weaponIndex >= MAX_WEAPONS ) {
		weaponGone = true;
		return;
	}

	idTypeInfo*	typeInfo;
	weaponDef = GetWeaponDef( currentWeapon );

	weaponDef->dict.GetString( "animPrefix", "" );	
	
	if ( !weaponDef ) {
		gameLocal.Error( "Weapon definition not found for weapon %d", currentWeapon ) ;
	}
	typeInfo = idClass::GetClass( weaponDef->dict.GetString( "weaponclass", "rvWeapon" ) );
	if ( !typeInfo || !typeInfo->IsType( rvWeapon::GetClassType() ) ) {
		gameLocal.Error( "Invalid weapon class '%s' specified for weapon '%s'", animPrefix.c_str(), weaponDef->dict.GetString ( "weaponclass", "rvWeapon" ) );
	}
	weapon = static_cast<rvWeapon*>( typeInfo->CreateInstance() );
	weapon->Init( this, weaponDef, currentWeapon );
	weapon->CallSpawn( );		

	UpdateHudWeapon();

	// Remove the "weapon_" from the anim prefect for the player world anims
	animPrefix = weapon->GetAnimPrefix();
	animPrefix.Strip( "weapon_" );
	
	// Make sure weapon is hidden
	if ( !weaponEnabled ) {
		Event_DisableWeapon( );
	}
}
 
/*
==============
idPlayer::SetupWeaponEntity
==============
*/
void idPlayer::SetupWeaponEntity( void ) {
	int w;
	const char* weap;
	ENTDEF decl;
	idEntity* spawn;
	idDict args;
	
	
	// don't setup weapons for spectators
	if ( gameLocal.isClient || (weaponViewModel && weaponWorldModel) || spectating ) {
		return;
	}
	
	if ( !weaponViewModel ) {
		decl = static_cast< const idDeclEntityDef * >( declManager->FindType( DECL_ENTITYDEF, "player_viewweapon", false, false ) );
		if ( !decl ) {
			gameLocal.Error( "entityDef not found: player_viewweapon" );
		}
		args.Set( "name", va( "%s_weapon", name.c_str() ) );
		args.Set( "classname", decl->GetName() );
		spawn = NULL;
		gameLocal.SpawnEntityDef( args, &spawn );
		if ( !spawn ) {
			gameLocal.Error( "idPlayer::SetupWeaponEntity: failed to spawn weaponViewModel" );
		}
		weaponViewModel = static_cast<rvViewWeapon*>(spawn);
		weaponViewModel->SetName( va("%s_weapon", name.c_str() ) );
	}
	
			
	if ( !weaponWorldModel ) {
		// setup the world model
		decl = static_cast< const idDeclEntityDef * >( declManager->FindType( DECL_ENTITYDEF, "player_animatedentity", false, false ) );
		if ( !decl ) {
			gameLocal.Error( "entityDef not found: player_animatedentity" );
		}
		args.Set( "name", va( "%s_weapon_world", name.c_str() ) );
		args.Set( "classname", decl->GetName() );
		spawn = NULL;
		gameLocal.SpawnEntityDef( args, &spawn );
		if ( !spawn ) {
			gameLocal.Error( "idPlayer::SetupWeaponEntity: failed to spawn weaponWorldModel" );
		}
		weaponWorldModel = static_cast<idAnimatedEntity*>(spawn);
		weaponWorldModel->fl.networkSync = true;
		weaponWorldModel->SetName ( va("%s_weapon_world", name.c_str() ) );
	}
	
			
	if ( !weaponWorldModel ) {
		// setup the world model
		weaponWorldModel = static_cast<idAnimatedEntity*>( gameLocal.SpawnEntityType( idAnimatedEntity::GetClassType(), NULL ) );

		weaponWorldModel->fl.networkSync = true;
		weaponWorldModel->SetName ( va("%s_weapon_world", name.c_str() ) );
	}
	
	currentWeapon = -1;

 	for( w = 0; w < MAX_WEAPONS; w++ ) {
 		weap = spawnArgs.GetString( va( "def_weapon%d", w ) );
 		if ( weap && *weap ) {
 			rvWeapon::CacheWeapon( weap );
 		}
 	}
}

#define HEAL_SELF_DELAY 3000
#define HEAL_SELF_AMOUNT 4

/*
==============
idPlayer::Init
==============
*/
void idPlayer::Init( void ) {
	const char			*value;

	noclip					= false;
	godmode					= false;
	godmodeDamage			= 0;
	
	aimClientNum			= -1;

	oldButtons				= 0;
	oldFlags				= 0;

	currentWeapon			= -1;
	idealWeapon				= -1;
	previousWeapon			= -1;
	weaponSwitchTime		= 0;
	weaponEnabled			= true;
 	showWeaponViewModel		= GetUserInfo()->GetInt( "ui_showGun" );

	lastDmgTime				= 0;

	inventory.minigunAttackEnd			= 0;
	
	bobCycle				= 0;
	bobFrac					= 0.0f;
	landChange				= 0;
	landTime				= 0;
	zoomFov.Init( 0, 0, DefaultFov(), DefaultFov() );
	centerView.Init( 0, 0, 0, 0 );

	currentLoggedAccel		= 0;

	lightningEffects		= 0;
	lightningNextTime		= 0;

	modelName				= idStr();

	// Remove any hearing loss that may be set up from the last map
	soundSystem->FadeSoundClasses( SOUNDWORLD_MAX, 0, 0.0f, 0 );
	
	// remove any damage effects
	playerView.ClearEffects();

	// damage values
	fl.takedamage			= true;
	ClearPain();

	// restore persistent data
	RestorePersistantInfo();

	bobCycle	= 0;

	SetupWeaponEntity( );
	currentWeapon = -1;
	previousWeapon = -1;
	
	flashlightOn	  = false;

	idealLegsYaw = 0.0f;
	legsYaw = 0.0f;
	legsForward = true;
	oldViewYaw = 0.0f;

// mekberg: moved into function.
	SetPMCVars( );	

	gibDeath = false;
	gibsLaunched = false;
	gibDir.Zero();


// abahr: changed to GetCurrentGravity
	// set the gravity
	physicsObj.SetGravity( gameLocal.GetCurrentGravity(this) );


	// start out standing
	SetEyeHeight( pm_normalviewheight.GetFloat() );

	stepUpTime = 0;
	stepUpDelta = 0.0f;
	viewBobAngles.Zero();
	viewBob.Zero();

	UpdateModelSetup( true );

	if ( cursor ) {
 		cursor->SetStateInt( "talkcursor", 0 );
		cursor->HandleNamedEvent( "showCrossCombat" );
	}

	SetSkin( skin );
	if( clientHead ) {
		clientHead->SetSkin( headSkin );
		if( clientHead->GetModelDefHandle() > 0 ) {
			gameRenderWorld->RemoveDecals( clientHead->GetModelDefHandle() );
		}
	}

	if( weaponViewModel ) {
		weaponViewModel->SetSkin( weaponViewSkin );
	}

 	value = spawnArgs.GetString( "joint_hips", "" );
 	hipJoint = animator.GetJointHandle( value );
 	if ( hipJoint == INVALID_JOINT ) {
 		gameLocal.Error( "Joint '%s' not found for 'joint_hips' on '%s'", value, name.c_str() );
 	}
 
 	value = spawnArgs.GetString( "joint_chest", "" );
 	chestJoint = animator.GetJointHandle( value );
 	if ( chestJoint == INVALID_JOINT ) {
 		gameLocal.Error( "Joint '%s' not found for 'joint_chest' on '%s'", value, name.c_str() );
 	}
 
 	value = spawnArgs.GetString( "joint_head", "" );
 	headJoint = animator.GetJointHandle( value );
 	if ( headJoint == INVALID_JOINT ) {
 		gameLocal.Error( "Joint '%s' not found for 'joint_head' on '%s'", value, name.c_str() );
 	}

	// initialize the script variables
	memset ( &pfl, 0, sizeof( pfl ) );
	pfl.onGround = true;
	pfl.noFallingDamage = false;

	// Start in idle
	SetAnimState( ANIMCHANNEL_TORSO, "Torso_Idle", 0 );
	SetAnimState( ANIMCHANNEL_LEGS, "Legs_Idle", 0 );
	
	forceScoreBoard		= false;
	forceScoreBoardTime = 0;

	privateCameraView	= NULL;

	lastSpectateChange	= 0;
 	lastTeleFX			= -9999;

	hiddenWeapon		= false;
 	teleportEntity		= NULL;
	lastKiller			= NULL;
	teleportKiller		= -1;

 	SetPrivateCameraView( NULL );
 
 	lastSnapshotSequence	= 0;
 
	if( mphud ) {
		mphud->HandleNamedEvent( "aim_fade" );
	}

 	isChatting = false;

	SetInitialHud();

	emote = PE_NONE;

	if( /*gameLocal.isMultiplayer && */entityNumber == gameLocal.localClientNum ) {
		if( (gameLocal.mpGame.GetGameState()->GetMPGameState() != WARMUP) && gameLocal.mpGame.GetGameState()->GetMPGameState() != SUDDENDEATH ){
			// don't clear notices while in warmup modes or sudden death
			GUIMainNotice( "" );
			GUIFragNotice( "" );
		}

		if ( (gameLocal.mpGame.GetGameState()->GetMPGameState() == WARMUP) && vsMsgState ) {
			GUIMainNotice( "" );
			GUIFragNotice( "" );
		}
	}
	
	deathSkinTime		= 0;
	deathStateHitch		= false;
	jumpDuringHitch		= false;

	// <q4f>

	lastCrashLandTime = 0;

	weaponRunning = false;

	pipes.Clear();
	memset( dropAmmos, 0, sizeof( dropAmmos ) );

	speedMultiplier = 1.0f;

	disguiseClass = INVALID_CLASS;
	disguiseTeam = INVALID_TEAM;

	ClearDisguise();

	CancelEvents( &EV_Player_LimitSpeed );

	messageQueue.Clear();
	nextMsgChange = 0;

	isDispensing = false;
	isBuilding = false;
	isFacingDispenser = false;
	StopPreview();

	menuNum = 1;
	CloseMenu();

	ClearAfflictions();

	grenSoundCycle = 0;

	UpdateVisibleColor();

	damageKilledWith.Clear();

	nextPipeAttack = 0;

	weaponZoomed = 0;

	waterTics = 0;

	focusEnt = NULL;
	focusDist = 311311.0f;
	dispFillAmount = 0.0f;

	nextHealTime = gameLocal.time + HEAL_SELF_DELAY;

	allowNextFireTime = gameLocal.time + 1000;

	InitClassInformation();

	commMenuIndex = -1;

	CommonClear();

	// </q4f>

	// GTR bandit: Unlagged Code
	if ( gameLocal.isServer && g_unlagged.GetBool() )
		ResetHistory( );
}

/*
===============
idPlayer::ProjectHeadOverlay
===============
*/
void idPlayer::ProjectHeadOverlay( const idVec3 &point, const idVec3 &dir, float size, const char *decal ) {
	if( clientHead ) {
		clientHead.GetEntity()->ProjectOverlay( point, dir, size, decal );
	}
}

/*
===============
idPlayer::GetCursorGUI
===============
*/
idUserInterface* idPlayer::GetCursorGUI( void ) {
	idStr temp;

	assert( gameLocal.localClientNum == entityNumber );

	if ( cursor ) {
		return cursor;
	}
	if ( spawnArgs.GetString( "cursor", "", temp ) ) {
		cursor = uiManager->FindGui( temp, true, true, true );
	}
	return cursor;
}

/*
==============
idPlayer::Spawn

Prepare any resources used by the player.
==============
*/
void idPlayer::Spawn( void ) {
	idStr		temp;
	idBounds	bounds;

	if ( entityNumber >= MAX_CLIENTS ) {
		gameLocal.Error( "entityNum > MAX_CLIENTS for player.  Player may only be spawned with a client." );
	}

	// allow thinking during cinematics
	cinematic = true;

	//if ( gameLocal.isMultiplayer ) {
		// always start in spectating state waiting to be spawned in
		// do this before SetClipModel to get the right bounding box
		spectating = true;

		// <q4f> 

		wantSpectate = true;

		// </q4f>
	//}

	// set our collision model
	physicsObj.SetSelf( this );
	SetClipModel( );
	physicsObj.SetMass( spawnArgs.GetFloat( "mass", "100" ) );
	physicsObj.SetContents( CONTENTS_BODY | (use_combat_bbox?CONTENTS_SOLID:0) );
	physicsObj.SetClipMask( MASK_PLAYERSOLID );
	SetPhysics( &physicsObj );

//	InitAASLocation();
	
	skin = renderEntity.customSkin;

	// only the local player needs guis
 	if ( entityNumber == gameLocal.localClientNum ) {
		
		// load HUD
		hud = NULL;
		mphud = NULL;
 		
		if ( spawnArgs.GetString( "hud", "", temp ) ) {
			hud = uiManager->FindGui( temp, true, false, true );
		} else {
			gameLocal.Warning( "idPlayer::Spawn() - No hud for player." );
		}

		if ( spawnArgs.GetString( "mphud", "", temp ) ) {
  			mphud = uiManager->FindGui( temp, true, false, true );
		} else {
			gameLocal.Warning( "idPlayer::Spawn() - No MP hud overlay while in MP.");
		}

		if ( hud ) {
			hud->Activate( true, gameLocal.time );
		}

		if ( mphud ) {
			mphud->Activate( true, gameLocal.time );
		}

		// load cursor
		GetCursorGUI();

		if ( cursor ) {
			cursor->Activate( true, gameLocal.time );
		}

		// clear votes
		// if we want to display current votes that were started before a player was connected
		// but are still being voted on, this should check the current vote and update the gui appropriately
		gameLocal.mpGame.voteSystem.ClearClientVote( entityNumber );

		// show the menu
		ShowMenu( 1 );
	}

	SetLastHitTime( 0, false );

	// load the armor sound feedback
	declManager->FindSound( "player_sounds_hitArmor" );

	animator.RemoveOriginOffset( true );

	// initialize user info related settings
	// on server, we wait for the userinfo broadcast, as this controls when the player is initially spawned in game
	// ocassionally, a race condition may mark a client in-game before he is spawned, if this is the case, parse the userinfo here
	if ( (gameLocal.isClient || entityNumber == gameLocal.localClientNum) || (gameLocal.isServer && gameLocal.mpGame.IsInGame( entityNumber ) ) ) {
		UserInfoChanged();
	}

	// create combat collision hull for exact collision detection
	SetCombatModel();

	// init the damage effects
	playerView.SetPlayerEntity( this );

	// supress model in non-player views, but allow it in mirrors and remote views
	renderEntity.suppressSurfaceInViewID = entityNumber+1;

	// don't project shadow on self or weapon
	renderEntity.noSelfShadow = true;

	if( clientHead ) {
		clientHead->GetRenderEntity()->suppressSurfaceInViewID = entityNumber + 1;
		clientHead->GetRenderEntity()->noSelfShadow = true;
	}

	//if ( gameLocal.isMultiplayer ) {
		Init();

 		Hide();	// properly hidden if starting as a spectator

		// Normally idPlayer::Move() gets called to set the contents to 0, but we don't call
		// move on players not in our snap, so we need to set it manually here.

		if ( !gameLocal.isClient ) {
			// set yourself ready to spawn. idMultiplayerGame will decide when/if appropriate and call SpawnFromSpawnSpot
			SetupWeaponEntity( );
			SpawnFromSpawnSpot( );
			spectator = entityNumber;
			forceRespawn = true;
			assert( spectating );
		}
	/*} else {
 		SetupWeaponEntity( );
		SpawnFromSpawnSpot( );
	}*/

	// trigger playtesting item gives, if we didn't get here from a previous level
	// the devmap key will be set on the first devmap, but cleared on any level
	// transitions
	/*if ( !gameLocal.isMultiplayer && gameLocal.serverInfo.FindKey( "devmap" ) ) {
		// fire a trigger with the name "devmap"
		idEntity *ent = gameLocal.FindEntity( "devmap" );
		if ( ent ) {
			ent->ActivateTargets( this );
		}
	}*/
	
	hiddenWeapon = false;
	
	if ( hud ) {
		UpdateHudWeapon( );
		hud->StateChanged( gameLocal.time );
	}

	// ddynerman: defaults for these values are the single player fall deltas
	fatalFallDelta = spawnArgs.GetFloat("fatal_fall_delta", "65");
	hardFallDelta = spawnArgs.GetFloat("hard_fall_delta", "45");
	softFallDelta = spawnArgs.GetFloat("soft_fall_delta", "30");
	noFallDelta = spawnArgs.GetFloat("no_fall_delta", "7");

	gibSkin = declManager->FindSkin( spawnArgs.GetString( "skin_gibskin" ) );

	predictionOriginError	= vec3_zero;
	predictionAnglesError	= ang_zero;

	// zero out view angles when we spawn ourselves in MP - the server will send down
	// the correct ones (only zero if our input is still zero'd)
	if( gameLocal.isClient && gameLocal.localClientNum == entityNumber && usercmd.angles[ 0 ] == 0 && usercmd.angles[ 1 ] == 0 && usercmd.angles[ 2 ] == 0 ) {
		deltaViewAngles = ang_zero;
	}

	// <q4f> 

	team = TEAM_SPEC;

	currentPC = INVALID_CLASS;
	nextPC = INVALID_CLASS;
	restrictedClass = INVALID_CLASS;
	disguiseClass = INVALID_CLASS;
	disguiseTeam = INVALID_TEAM;
	ClearDisguise();

	nextTeamChange = 0;

	AttackerInfo att;
	att.Create( gameLocal.world );
	dmgNoAir.Create( att, "q4f_damage_noair", 1.0f );

	currentLocation = NULL;
	deathLocation = NULL;

	radarTime = 0;
	memset( &radarPositions, 0, sizeof( radarPositions ) );

	ClearHeldGrenade();

	grenadeDef_1 = NULL;
	grenadeDef_2 = NULL;

	sentryGun = NULL;
	detpack = NULL;
	dispenser = NULL;
	dispFillAmount = 0.0f;
	dispFillStartAmount = 0.0f;
	nextTeamChange = 0;

	fxAfflConc = NULL;
	fxAfflDisease = NULL;
	fxAfflFire = NULL;
	fxAfflFlash = NULL;

	flash_fade_start = SEC2MS( spawnArgs.GetFloat( "flash_fade_start", "0" ) );
	flash_fade_time = SEC2MS( spawnArgs.GetFloat( "flash_fade_time", "10" ) );
	conc_time = SEC2MS( spawnArgs.GetFloat( "conc_time", "10" ) );
	conc_yaw = spawnArgs.GetFloat( "conc_yaw", "40" );
	conc_pitch = spawnArgs.GetFloat( "conc_pitch", "50" );
	infection_delay = SEC2MS( spawnArgs.GetFloat( "infection_delay", "1" ) );
	fire_delay = SEC2MS( spawnArgs.GetFloat( "fire_delay", ".75" ) );
	hallucinate_time = SEC2MS( spawnArgs.GetInt( "hallucinate_time", "10" ) );
	tranq_time = SEC2MS( spawnArgs.GetInt( "tranq_time", "10" ) );

	tranq_speed_start = spawnArgs.GetFloat( "tranq_speed_start", ".35" );
	tranq_speed_end = spawnArgs.GetFloat( "tranq_speed_end", ".65" );

	noair_delay = SEC2MS( spawnArgs.GetFloat( "noair_delay", "1" ) );

	// </q4f>
}

/*
==============
idPlayer::~idPlayer()

Release any resources used by the player.
==============
*/
idPlayer::~idPlayer() {
	if( gameLocal.mpGame.GetGameState() ) {
		gameLocal.mpGame.GetGameState()->ClientDisconnect( this );
	}

	team = INVALID_TEAM;
	currentPC = INVALID_CLASS;
	nextPC = INVALID_CLASS;

	ClearAfflictions();

	if ( weaponViewModel )
		delete weaponViewModel;

	if ( weaponWorldModel )
		delete weaponWorldModel;
	
	if ( weapon )
		delete weapon;
	
	SetPhysics( NULL );
}

/*
===========
idPlayer::Save
===========
*/
void idPlayer::Save( idSaveGame *savefile ) const {
}

/*
===========
idPlayer::Restore
===========
*/
void idPlayer::Restore( idRestoreGame *savefile ) {
	
}

/*
===============
idPlayer::PrepareForRestart
================
*/
void idPlayer::PrepareForRestart( void ) {
	//ClearPowerUps();
	Spectate( true );
	forceRespawn = true;
	
	// we will be restarting program, clear the client entities from program-related things first
	ShutdownThreads();

	// the sound world is going to be cleared, don't keep references to emitters
	FreeSoundEmitter( false );
}

/*
===============
idPlayer::Restart
================
*/
void idPlayer::Restart( void ) {
	idActor::Restart();

	// client needs to setup the animation script object again
	if ( entityNumber == gameLocal.localClientNum && IS_VALID_CLASS_NUM( currentPC ) && q4f_execClassConfigs.GetInteger() == 2 ) {
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, "exec config/classes/base.cfg" );
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "exec %s", tfGame.GetClassConfig( currentPC ) ) );
	}

	if ( gameLocal.isClient ) {
		// clear the existing model to force a reload
		Init();
	} else {
		// choose a random spot and prepare the point of view in case player is left spectating
		assert( spectating );
		SpawnFromSpawnSpot();
	}

	lastKiller = NULL;
}

/*
===============
idPlayer::ServerSpectate
================
*/
void idPlayer::ServerSpectate( bool spectate ) {
	assert( !gameLocal.isClient );

	idVec3 origin;
	idAngles angles;

	if ( !spectate ) {
		if ( !SelectSpawnPoint( origin, angles ) ) {
			forceRespawn = true;
			return;
		}
	}

	if ( spectating != spectate ) {
		// if we select spectating on the client 
		// mekberg: drop and clear powerups from the player.
		DropItems( true, TFSTATE_ACTIVE );
		//DropPowerups ( );	
		//ClearPowerUps ( );
 		Spectate( spectate );
		gameLocal.mpGame.GetGameState()->Spectate( this );
   	if ( spectate ) {
  			SetSpectateOrigin( );
 		} 
	}

	if ( !spectate ) {
		SpawnToPoint( origin, angles );
	}
}

/*
===========
idPlayer::SelectSpawnPoint

Find a spawn point marked, otherwise use normal spawn selection.
============
*/
bool idPlayer::SelectSpawnPoint( idVec3 &origin, idAngles &angles ) {
	idEntity *spot;
	idStr skin;

	spot = gameLocal.SelectSpawnPoint( this );

	// no spot, try again next frame
	if( !spot ) {
		forceRespawn = true;
		return false;
	}

	// activate the spawn locations targets
	spot->PostEventMS( &EV_ActivateTargets, 0, this );

	origin = spot->GetPhysics()->GetOrigin();
	origin[2] += 4.0f + CM_BOX_EPSILON;		// move up to make sure the player is at least an epsilon above the floor
	angles = spot->GetPhysics()->GetAxis().ToAngles();

	return true;
}

/*
===========
idPlayer::SpawnFromSpawnSpot

Chooses a spawn location and spawns the player
============
*/
bool idPlayer::SpawnFromSpawnSpot( void ) {
	idVec3		spawn_origin;
	idAngles	spawn_angles;
	
	if( !SelectSpawnPoint( spawn_origin, spawn_angles ) ) {
		forceRespawn = true;
		return false;
	}
	SpawnToPoint( spawn_origin, spawn_angles );
	return true;
}

/*
===========
idPlayer::SpawnToPoint

Called every time a client is placed fresh in the world:
after the first ClientBegin, and after each respawn
Initializes all non-persistant parts of playerState

when called here with spectating set to true, just place yourself and init
============
*/
void idPlayer::SpawnToPoint( const idVec3 &spawn_origin, const idAngles &spawn_angles ) {
	idVec3 spec_origin;

	assert( !gameLocal.isClient );

	respawning = true;

	Init();

	// Force players to use bounding boxes when in multiplayer
	//if ( gameLocal.isMultiplayer ) {
		use_combat_bbox = true;

		// Make sure the combat model is unlinked
		if ( combatModel ) {
			combatModel->Unlink ( );
		}
	//}

	// Any health over max health will tick down
	if ( health > inventory.maxHealth ) {
		nextHealthPulse = gameLocal.time + HEALTH_PULSE;
	}
	
	if ( inventory.armor > inventory.maxarmor ) {
		nextArmorPulse = gameLocal.time + ARMOR_PULSE;
	}		

	fl.noknockback = false;
	// stop any ragdolls being used
	StopRagdoll();
	// set back the player physics
	SetPhysics( &physicsObj );
	physicsObj.SetClipModelAxis();
	physicsObj.EnableClip();
	if ( !spectating ) {
		SetCombatContents( true );
	}

	physicsObj.SetLinearVelocity( vec3_origin );

	// setup our initial view
	if ( !spectating ) {
		SetOrigin( spawn_origin );

// abahr: taking into account gravity
		SetAxis( spawn_angles.ToMat3() );

	} else {
		spec_origin = spawn_origin;
		spec_origin[ 2 ] += pm_normalheight.GetFloat();
		spec_origin[ 2 ] += SPECTATE_RAISE;
		SetOrigin( spec_origin );
	}

	// if this is the first spawn of the map, we don't have a usercmd yet,
	// so the delta angles won't be correct.  This will be fixed on the first think.
	viewAngles = ang_zero;
	SetDeltaViewAngles( ang_zero );
	SetViewAngles( spawn_angles );
	spawnAngles = spawn_angles;
	spawnAnglesSet = false;

 	legsForward = true;
	legsYaw = 0.0f;
	idealLegsYaw = 0.0f;
	oldViewYaw = viewAngles.yaw;

	if ( spectating ) {
		Hide();
	} else {
		Show();
	}

	//if ( gameLocal.isMultiplayer ) {
		if ( !spectating ) {
 			// we may be called twice in a row in some situations. avoid a double fx and 'fly to the roof'
 			if ( lastTeleFX < gameLocal.time - 1000 ) {

				gameLocal.forceUnreliableClient = entityNumber;
				gameLocal.PlayEffect ( spawnArgs, "fx_spawn", spawn_origin, idVec3(0,0,1).ToMat3(), false, vec3_origin, true );
				gameLocal.forceUnreliableClient = -1;

				lastTeleFX = gameLocal.time;
 			}
		}
		if ( mphud ) {
			mphud->SetStateInt( "respawnNotice", 0 );
		}
		pfl.teleport = true;
	/*} else {
		pfl.teleport = false;
	}*/

	// kill anything at the new position
	if ( !spectating ) {
		physicsObj.SetClipMask( MASK_PLAYERSOLID ); // the clip mask is usually maintained in Move(), but KillBox requires it

// abahr: this is killing the tram car when spawning in.  Ooooops!
		//if( gameLocal.isMultiplayer ) {
			gameLocal.KillBox( this );
		//}

	}

	// don't allow full run speed for a bit
	physicsObj.SetKnockBack( 100 );

	// set our respawn time and buttons so that if we're killed we don't respawn immediately
	minRespawnTime = gameLocal.time;
	maxRespawnTime = gameLocal.time;
	if ( !spectating ) {
		forceRespawn = false;
	}

	privateCameraView = NULL;

	BecomeActive( TH_THINK );

	// run a client frame to drop exactly to the floor,
	// initialize animations and other things
	Think();

 	respawning			= false;
 	isTelefragged		= false;
 	isLagged			= false;
 	isChatting			= false;

	lastImpulsePlayer = NULL;
	lastImpulseTime = 0;

	spawnOrigin = spawn_origin;

	// GTR bandit: Unlagged Code
	if ( gameLocal.isServer && g_unlagged.GetBool() )
		ResetHistory( );
}

/*
===============
idPlayer::SavePersistantInfo

Saves any inventory and player stats when changing levels.
===============
*/
void idPlayer::SavePersistantInfo( void ) {
	idDict &playerInfo = gameLocal.persistentPlayerInfo[entityNumber];

	playerInfo.Clear();
	inventory.GetPersistantData( playerInfo );
	playerInfo.SetInt( "health", health );
	playerInfo.SetInt( "current_weapon", currentWeapon );
}

/*
===============
idPlayer::RestorePersistantInfo

Restores any inventory and player stats when changing levels.
===============
*/
void idPlayer::RestorePersistantInfo( void ) {
 	//if ( gameLocal.isMultiplayer ) {
 		gameLocal.persistentPlayerInfo[entityNumber].Clear();
 	//}
 
	spawnArgs.Copy( gameLocal.persistentPlayerInfo[entityNumber] );

	inventory.RestoreInventory( this, spawnArgs );
 	health = spawnArgs.GetInt( "health", "100" );
 	if ( !gameLocal.isClient ) {
 		idealWeapon = spawnArgs.GetInt( "current_weapon", "0" );
 	}
}

/*
================
idPlayer::GetUserInfo
================
*/
idDict *idPlayer::GetUserInfo( void ) {
	return &gameLocal.userInfo[ entityNumber ];
}

/*
==============
idPlayer::UpdateModelSetup
Updates the player's model setup.  Model setups are read from the player def, and contain
information about the player's model, the player's head model, a skin, and a team for the
composite model.
==============
*/
void idPlayer::UpdateModelSetup( bool forceReload ) {
	const char* newModelName = NULL;

	if( spectating ) {
		return;
	}

	if ( disguiseClass != INVALID_CLASS ) {
		newModelName = tfGame.GetClassEntDef( disguiseClass )->dict.GetString( "def_model" );
	}
	else {
		newModelName = spawnArgs.GetString( "def_model" );
	}

	if ( !newModelName || !newModelName[0] ) {
		//gameLocal.Error( "UpdateModelSetup: model string is empty" );
		gameLocal.Warning( "UpdateModelSetup: model string is empty" );
		newModelName = "model_pc_scout";
	}

	// model hasn't changed
	if( !modelName.Icmp( newModelName ) && !forceReload ) {
		return;
	}

	modelDict = gameLocal.FindEntityDefDict( newModelName, false );
	if ( !modelDict ) {
		gameLocal.Error( "cannot find model entity def for model %s\n", newModelName );
	}
	
	modelName = newModelName;

	SetAnimState( ANIMCHANNEL_TORSO, "Torso_Idle", 0 );
	SetAnimState( ANIMCHANNEL_LEGS, "Legs_Idle", 0 );
	UpdateState();

	reloadModel = true;
}

/*
==============
idPlayer::BalanceTeam
==============
*/

// shouchard:  BalanceTDM->BalanceTeam (now used for CTF as well as TDM)
bool idPlayer::BalanceTeam( void ) {
	// 3j_todo:
	/*if ( !IS_VALID_TEAM(team) ) {
		return false;
	}

	int minCount = MAX_CLIENTS;
	int minCountTeam = -1;

	for( int i = 0; i < TEAM_COUNT; i++ ) {
		// don't consider this team if it isn't enabled
		if ( tfGame.activeTeams & ( 1 << i ) ) {
			if( tfGame.teams[i].playerCount < minCount ) {
				minCount = tfGame.teams[i].playerCount;
				minCountTeam = i;
			}
		}
	}

	if ( !IS_VALID_TEAM(minCountTeam) || team == minCountTeam || tfGame.teams[team].playerCount <= ( tfGame.teams[minCountTeam].playerCount + 1 ) ) {
		return false;
	}

	common->DPrintf( "team balance: forcing player %d to %s team\n", entityNumber, tfGame.GetTeamName( minCountTeam ) );
	GetUserInfo()->Set( "ui_team", tfGame.GetTeamName( minCountTeam ) );
	cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "updateUI %d\n", entityNumber ) );
	return true;*/
	return false;
}

/*void HSVtoRGB( float &r, float &g, float &b, float h, float s, float v ) {
	int i;
	float f, p, q, t;

	h = idMath::ClampFloat( 0.0f, 360.0f, h );
	s = idMath::ClampFloat( 0.0f, 1.0f, s );
	v = idMath::ClampFloat( 0.75f, 1.0f, v );

	if( s == 0 ) {
		// achromatic (grey)
		r = g = b = v;
		return;
	}

	h /= 60;			// sector 0 to 5
	i = floor( h );
	f = h - i;			// factorial part of h
	p = v * ( 1 - s );
	q = v * ( 1 - s * f );
	t = v * ( 1 - s * ( 1 - f ) );

	switch( i ) {
		case 0:
			r = v;
			g = t;
			b = p;
			break;

		case 1:
			r = q;
			g = v;
			b = p;
			break;

		case 2:
			r = p;
			g = v;
			b = t;
			break;
			
		case 3:
			r = p;
			g = q;
			b = v;
			break;

		case 4:
			r = t;
			g = p;
			b = v;
			break;

		default:		// case 5:
			r = v;
			g = p;
			b = q;
			break;
	}
}*/

/*
==============
idPlayer::UserInfoChanged
==============
*/
bool idPlayer::UserInfoChanged( void ) {
 	idDict	*userInfo;
 	bool	modifiedInfo;
// 	bool	newready;
 
 	userInfo = GetUserInfo();

 	showWeaponViewModel = userInfo->GetInt( "ui_showGun" );

	physicsObj.SetPogoStick( userInfo->GetBool( "ui_pogostick" ) );

	uiAutoReload	= userInfo->GetBool( "ui_autoReload" );
	uiName			= userInfo->GetString( "ui_name", "unnamed" );
	uiClan			= userInfo->GetString( "ui_clan", "" );

	/*if ( !gameLocal.isMultiplayer ) {
		return false;
	}*/

	if ( !gameLocal.isClient ) {
		TFPlayerStats* stats = tfStatManager->GetPlayerStatsPlayer( this );
		if ( stats ) {
			stats->lastKnownName = uiName;
			stats->lastKnownClan = uiClan;
		}
	}

 	modifiedInfo = false;

	/*
	spec = ( idStr::Icmp( userInfo->GetString( "ui_spectate" ), "Spectate" ) == 0 );
	if ( gameLocal.serverInfo.GetBool( "si_spectators" ) ) {
 		// never let spectators go back to game while sudden death is on
 		if ( gameLocal.mpGame.GetGameState()->GetMPGameState() == SUDDENDEATH && !spec && wantSpectate == true ) {
 			userInfo->Set( "ui_spectate", "Spectate" );
 			modifiedInfo |= true;
 		} else {
 			if ( spec != wantSpectate && !spec ) {
 				// returning from spectate, set forceRespawn so we don't get stuck in spectate forever
 				forceRespawn = true;
 			}
 			wantSpectate = spec;
   		}
	} else {
 		if ( spec ) {
 			userInfo->Set( "ui_spectate", "Play" );
 			modifiedInfo |= true;
 		} else if ( spectating ) {  
 			// allow player to leaving spectator mode if they were in it when it was disallowed
 			forceRespawn = true;
 		}
		wantSpectate = false;
	}
	*/

	/*if ( gameLocal.serverInfo.GetBool( "si_useReady" ) ) {
		newready = ( idStr::Icmp( userInfo->GetString( "ui_ready" ), "Ready" ) == 0 );
		if ( ready != newready && gameLocal.mpGame.GetGameState()->GetMPGameState() == WARMUP && !wantSpectate ) {
 			gameLocal.mpGame.AddChatLine( common->GetLocalizedString( "#str_107180" ), userInfo->GetString( "ui_name" ), newready ? common->GetLocalizedString( "#str_104300" ) : common->GetLocalizedString( "#str_104301" ) );
		}
		ready = newready;
	}*/

	/*
	team = tfGame.GetTeamNum( userInfo->GetString( "ui_team" ) );

	if ( !gameLocal.isClient && gameLocal.serverInfo.GetBool( "si_autoBalance" ) && BalanceTeam() ) {
 		modifiedInfo |= true;
		team = tfGame.GetTeamNum( userInfo->GetString( "ui_team" ) );
	}

	if ( team != latchedTeam ) {
		if ( hud ) {
			if ( IS_VALID_TEAM( team ) ) {
				if ( hud ) {
					hud->SetStateFloat( "teamColorX", tfGame.teams[team].color.x );
					hud->SetStateFloat( "teamColorY", tfGame.teams[team].color.y );
					hud->SetStateFloat( "teamColorZ", tfGame.teams[team].color.z );
				}
			}
			else {
				hud->SetStateFloat( "teamColorX", 0.33f );
				hud->SetStateFloat( "teamColorY", 0.33f );
				hud->SetStateFloat( "teamColorZ", 0.33f );
			}
		}

		if( gameLocal.isServer ) {	
			gameLocal.mpGame.SwitchToTeam( entityNumber, latchedTeam, team );
		}

		SetInitialHud();
		if( mphud ) {
			mphud->SetStateInt( "playerteam", team );
			mphud->HandleNamedEvent( "TeamChange" );
		}
	}
	latchedTeam = team;
	*/
	
	//UpdateModelSetup();
	
	if( (gameLocal.isServer && gameLocal.mpGame.IsInGame( entityNumber )) || (gameLocal.isClient && gameLocal.localClientNum == entityNumber) ) {
 		isChatting = userInfo->GetBool( "ui_chat", "0" );
 		if ( isChatting && pfl.dead ) {
 			// if dead, always force chat icon off.
 			isChatting = false;
 			userInfo->SetBool( "ui_chat", false );
 			modifiedInfo |= true;
		}
	}

	return modifiedInfo;
}
   

/*
===============
idPlayer::UpdateHudAmmo
===============
*/
void idPlayer::UpdateHudAmmo( idUserInterface *_hud ) {
	int inclip;
	int clipSize;
	int ammoamount;
	float pct;
	int weaponCount;
	int maxAmmo;

	if ( !_hud )
		return;

	_hud->SetStateInt( "player_ammo_nails", inventory.ammo[ AMMO_NAILS_INDEX ] );
	_hud->SetStateInt( "player_ammo_shells", inventory.ammo[ AMMO_SHELLS_INDEX ] );
	_hud->SetStateInt( "player_ammo_rockets", inventory.ammo[ AMMO_ROCKETS_INDEX ] );
	_hud->SetStateInt( "player_ammo_cells", inventory.ammo[ AMMO_CELLS_INDEX ]);

	if ( grenadeDef_1 ) {
		_hud->SetStateInt( "player_ammo_gren1", inventory.ammo[ AMMO_GREN1_INDEX ]);
		_hud->SetStateString( "gren1_icon", grenadeDef_1->dict.GetString( "inv_icon", "" ) );
	}
	else {
		_hud->SetStateInt( "player_ammo_gren1", -1 );
		_hud->SetStateString( "gren1_icon", "" );
	}

	if ( grenadeDef_2 ) {
		_hud->SetStateInt( "player_ammo_gren2", inventory.ammo[ AMMO_GREN2_INDEX ]);
		_hud->SetStateString( "gren2_icon", grenadeDef_2->dict.GetString( "inv_icon", "" ) );
	}
	else {
		_hud->SetStateInt( "player_ammo_gren2", -1 );
		_hud->SetStateString( "gren2_icon", "" );
	}

	ENTDEF weaponDef;

	weaponCount = 0;
	for ( int i = 0; i < MAX_WEAPONS; i++ ) {
		weaponDef = GetWeaponDef( i );
		if ( !weaponDef )
			break;
		else {
			inclip		= inventory.clip[i];
			ammoamount	= inventory.ammo[ inventory.ammoIndices[i] ];
			clipSize	= inventory.clipSizes[i];
			//clipSize = 0;

			// make sure we don't have more in our clip than our total ammo
			if ( clipSize > 0 && ammoamount >= 0 && inclip > ammoamount ) {
				inventory.clip[i] = ammoamount;
				inclip = ammoamount;
			}

			_hud->SetStateInt( va( "weapon_ammo_amount_%d", weaponCount ),	ammoamount );
			_hud->SetStateInt( va( "weapon_clip_size_%d", weaponCount ),	clipSize );
			_hud->SetStateInt( va( "weapon_in_clip_%d", weaponCount ),		inclip );
			_hud->SetStateString( va( "weapon_icon_%d", weaponCount ),		weaponDef->dict.GetString ( "inv_icon" ) );
			_hud->SetStateString( va( "weapon_name_%d", weaponCount ),		weaponDef->dict.GetString( "inv_name" ) );

			pct = 1.0f;
			if ( ammoamount >= 0 ) {
				if ( clipSize > 1 ) {
					pct = (float)inclip / (float)clipSize;
				}
				else {
					maxAmmo = spawnArgs.GetInt( va( "max_%s", inventory.AmmoClassForAmmoIndex( inventory.ammoIndices[i] ) ), "0" );		// 3j_todo: store these
					if ( maxAmmo <= 0 ) {
						pct = 1.0f;
					}
					else {
						pct = (float)ammoamount / (float)maxAmmo;
					}
				}
			}

			_hud->SetStateFloat( va( "weapon_pct_%d", weaponCount ), pct );

			weaponCount++;
		}	
	}

	_hud->SetStateInt( "weapon_count", weaponCount );
}

void idPlayer::UpdateHudBuildables( idUserInterface *_hud ) {
	assert( _hud );

	if ( sentryGun ) {
		sentryGun->UpdateHud( _hud );
	}
	else {
		_hud->SetStateInt( "sentry_health", 0 );
	}

	if ( dispenser ) {
		dispenser->UpdateHud( _hud );
	}
	else {
		_hud->SetStateInt( "disp_health", 0 );
	}

	if ( detpack ) {
		detpack->UpdateHud( _hud );
	}
	else {
		_hud->SetStateInt( "detpack_time", 0 );
	}

	_hud->StateChanged( gameLocal.time );
}

/*
===============
idPlayer::UpdateHudStats
===============
*/
void idPlayer::UpdateHudStats( idUserInterface *_hud ) {
	int temp, diff;
	
	assert ( _hud );

	temp = _hud->State().GetInt ( "player_health", "-1" );
	if ( temp != health ) {	
		_hud->SetStateInt( "player_healthDelta", temp - health );
		if ( temp < health ) {
			diff = health - temp;
			temp += diff >= 4 ? 4 : diff;
		}
		else {
			temp = health;
		}

		_hud->SetStateInt	( "player_health", temp );
		_hud->SetStateFloat	( "player_health_pct", idMath::ClampFloat ( 0.0f, 1.0f, (float)temp / (float)inventory.maxHealth ) );

		_hud->HandleNamedEvent ( "updateHealth" );
	}
	else {
		_hud->SetStateInt	( "player_health", health );
		_hud->SetStateFloat	( "player_health_pct", idMath::ClampFloat ( 0.0f, 1.0f, (float)health / (float)inventory.maxHealth ) );
	}
		
	temp = _hud->State().GetInt ( "player_armor", "-1" );
	if ( temp != inventory.armor ) {
		if ( temp < inventory.armor ) {
			diff = inventory.armor - temp;
			temp += diff >= 4 ? 4 : diff;
			
		}
		else {
			temp = inventory.armor;
		}

		_hud->SetStateInt ( "player_armor", temp );
		_hud->SetStateFloat	( "player_armor_pct", idMath::ClampFloat ( 0.0f, 1.0f, (float)temp / (float)inventory.maxarmor ) );

		_hud->HandleNamedEvent ( "updateArmor" );
	}
	else {
		_hud->SetStateInt ( "player_armor", inventory.armor );
		_hud->SetStateFloat	( "player_armor_pct", idMath::ClampFloat ( 0.0f, 1.0f, (float)(inventory.armor) / (float)inventory.maxarmor ) );
	}

	// Update the hit direction
	idVec3 localDir;
	viewAxis.ProjectVector( lastDamageDir, localDir );
	_hud->SetStateFloat( "hitdir", localDir.ToAngles()[YAW] + 180.0f );

	//_hud->HandleNamedEvent( "updateArmorHealthAir" );

	UpdateHudAmmo( _hud );
	
	_hud->StateChanged( gameLocal.time );
}

/*
===============
idPlayer::UpdateHudWeapon
===============
*/
void idPlayer::UpdateHudWeapon( int displayWeapon ) {
	
	if ( (displayWeapon < -1) || (displayWeapon >= MAX_WEAPONS) ) {
		common->DPrintf( "displayweapon was out of range" );
		return;
	}
	
	idUserInterface * hud = idPlayer::hud;
	idUserInterface * mphud = idPlayer::mphud;
	idUserInterface * cursor = idPlayer::cursor;
 
 	if ( !gameLocal.GetLocalPlayer() ) {
		// server netdemo
		if ( gameLocal.GetDemoState() == DEMO_PLAYING && gameLocal.IsServerDemo() && gameLocal.GetDemoFollowClient() == entityNumber ) {
			hud = gameLocal.GetDemoHud();
			mphud = gameLocal.GetDemoMphud();
			cursor = gameLocal.GetDemoCursor();
		}
	} else {
		// if updating the hud of a followed client
		idPlayer *p = gameLocal.GetLocalPlayer();

		if ( p->spectating && p->spectator == entityNumber ) {
			assert( p->hud && p->mphud );
			hud = p->hud;
			mphud = p->mphud;
			cursor = p->GetCursorGUI();
		}
	}

	if ( !hud || !weapon ) {
		return;
	}

	UpdateHudAmmo( hud );
 			
 	if ( cursor ) {
 		weapon->UpdateCrosshairGUI( cursor );

		// mekberg: force a redraw so ON_INIT gets called and doesn't stomp all over
		//			the color values we set in weaponChange.
		cursor->Redraw( gameLocal.time );
		cursor->HandleNamedEvent( "weaponChange" );
	}

	hud->SetStateInt( "current_weapon", currentWeapon );
	hud->SetStateInt( "ideal_weapon", idealWeapon );

	hud->HandleNamedEvent( "weaponChange" );
	hud->StateChanged( gameLocal.time ); 			
}

/*
===============
idPlayer::StartRadioChatter
===============
*/
void idPlayer::StartRadioChatter ( void ) {
	if ( hud ) {
		hud->HandleNamedEvent( "radioChatterUp" );
	}
}

/*
===============
idPlayer::StopRadioChatter
===============
*/
void idPlayer::StopRadioChatter ( void ) {
	if ( hud ) {
		hud->HandleNamedEvent( "radioChatterDown" );
	}
}

/*
===============
idPlayer::DrawShadow
===============
*/
void idPlayer::DrawShadow( renderEntity_t *headRenderEnt ) {
	if ( /*gameLocal.isMultiplayer && */g_skipPlayerShadowsMP.GetBool() ) {
		// Disable all player shadows for the local client
		renderEntity.suppressShadowInViewID	= gameLocal.localClientNum+1;
 		if ( headRenderEnt ) {
 			headRenderEnt->suppressShadowInViewID = gameLocal.localClientNum+1;
   		}
	} else if ( /*gameLocal.isMultiplayer*/ true || g_showPlayerShadow.GetBool() || pm_thirdPerson.GetBool() ) {
		// Show all player shadows
		renderEntity.suppressShadowInViewID	= 0;
 		if ( headRenderEnt ) {
			headRenderEnt->suppressShadowInViewID = 0;
		}
	} else {
		// Only show player shadows for other clients
		renderEntity.suppressShadowInViewID	= entityNumber+1;
 		if ( headRenderEnt ) {
 			headRenderEnt->suppressShadowInViewID = entityNumber+1;
   		}
	}
}

/*
===============
idPlayer::DrawHUD
===============
*/
void idPlayer::DrawHUD( idUserInterface *_hud ) {
	idUserInterface * cursor = idPlayer::cursor;

 	if ( !gameLocal.GetLocalPlayer() ) {
		// server netdemo
		if ( gameLocal.GetDemoState() == DEMO_PLAYING && gameLocal.IsServerDemo() && gameLocal.GetDemoFollowClient() == entityNumber ) {
			cursor = gameLocal.GetDemoCursor();
			if ( cursor ) {
				cursor->HandleNamedEvent( "showCrossCombat" );
			}
		}		
	} else {

		// if updating the hud of a followed client
		idPlayer *p = gameLocal.GetLocalPlayer();

		if ( p->spectating && p->spectator == entityNumber ) {
			cursor = p->GetCursorGUI();
			if ( cursor ) {
				cursor->HandleNamedEvent( "showCrossCombat" );
			}
		}		
	}

	if ( disableHud || privateCameraView || !_hud || !g_showHud.GetBool() ) {
		return;
	}
	
	// FIXME: this is temp to allow the sound meter to show up in the hud
	// it should be commented out before shipping but the code can remain
	// for mod developers to enable for the same functionality
	_hud->SetStateInt( "s_debug", cvarSystem->GetCVarInteger( "s_showLevelMeter" ) );

	// don't draw main hud in spectator (only mphud)
	if ( !spectating && !gameDebug.IsHudActive( DBGHUD_ANY ) ) {
		// weapon targeting crosshair
		if ( !GuiActive() ) {

// mekberg: removed check for weapon->ShowCrosshair.
//			we want to show the crosshair regardless for NPC tags
			if ( cursor && health > 0 ) {		
				// Pass the current weapon to the cursor gui for custom crosshairs
// mekberg: adjustable crosshair size.
				int crossSize = cvarSystem->GetCVarInteger( "g_crosshairSize" );
				crossSize = crossSize - crossSize % 8;
				cvarSystem->SetCVarInteger( "g_crosshairSize", crossSize );
				cursor->SetStateInt( "g_crosshairSize", crossSize );

				cursor->Redraw( gameLocal.time );
			}
		}	

		UpdateHudStats( _hud );

		/*if ( focusBrackets ) {
			// If 2d_calc is still true then the gui didnt render so we can abandon it
			if ( focusBrackets->State().GetBool( "2d_calc" ) ) {
				focusBrackets->SetStateBool( "2d_calc", false );
				focusBrackets = NULL;
				focusBracketsTime = 0;
				_hud->HandleNamedEvent( "hideBrackets" );
			} else {
				_hud->SetStateString( "bracket_left", focusBrackets->State().GetString( "2d_min_x" ) );
				_hud->SetStateString( "bracket_top", focusBrackets->State().GetString( "2d_min_y" ) );
				_hud->SetStateFloat( "bracket_width", focusBrackets->State().GetFloat( "2d_max_x" ) - focusBrackets->State().GetFloat( "2d_min_x" ) );
				_hud->SetStateFloat( "bracket_height", focusBrackets->State().GetFloat( "2d_max_y" ) - focusBrackets->State().GetFloat( "2d_min_y" ) );
				// TODO: Find a way to get bracket text from gui to hud
			}
		}*/		

		UpdateHudBuildables( _hud );

		_hud->SetStateBool( "draw_disguise", currentPC == CLASS_SPY );

		_hud->SetStateFloat( "disp_fill_amount", dispFillAmount );

		if ( isDispensing ) {
			_hud->SetStateBool( "using_dispenser", true );
			_hud->SetStateBool( "facing_dispenser", false );
		}
		else if ( isFacingDispenser ) {
			_hud->SetStateBool( "using_dispenser", false );
			_hud->SetStateBool( "facing_dispenser", true );
		}
		else {
			_hud->SetStateBool( "using_dispenser", false );
			_hud->SetStateBool( "facing_dispenser", false );
		}

	 	_hud->Redraw( gameLocal.realClientTime );
	}

	//if ( gameLocal.isMultiplayer ) {
		idUserInterface* _mphud = mphud;
		// server netdemos don't have a local player, grab the right mphud
		if ( !gameLocal.GetLocalPlayer() ) {
			assert( gameLocal.GetDemoState() == DEMO_PLAYING && gameLocal.IsServerDemo() );
			assert( gameLocal.GetDemoFollowClient() >= 0 );
			assert( gameLocal.entities[ gameLocal.GetDemoFollowClient() ] && gameLocal.entities[ gameLocal.GetDemoFollowClient() ]->IsType( idPlayer::GetClassType() ) );
			_mphud = gameLocal.GetDemoMphud();
		} else if ( gameLocal.GetLocalPlayer() != this ) {
			// if we're spectating someone else, use our local hud

			_mphud = gameLocal.GetLocalPlayer()->mphud;
		}
		if ( _mphud ) {
			gameLocal.mpGame.UpdateHud( _mphud );
			DrawRadar( _mphud );
			_mphud->Redraw( gameLocal.time );
		}
	//}
	
	//DrawRadar( _hud );
	//DrawPlayerNames( _hud );
	// </q4f>
}

/*
===============
idPlayer::EnterCinematic
===============
*/
void idPlayer::EnterCinematic( void ) {
	Hide();


// jnewquist: Cinematics are letterboxed, this auto-fixes on widescreens
	g_fixedHorizFOV.SetBool(true);


   	if ( hud ) {
   		hud->HandleNamedEvent( "radioChatterDown" );
   	}
   	
   	physicsObj.SetLinearVelocity( vec3_origin );
   	
 	if ( weaponEnabled && weapon ) {
		//this preSave kills all effects and sounds that we don't need lingering around.
   		weapon->PreSave();
//		weapon->EnterCinematic();
   	}

	// Reset state flags   
	memset ( &pfl, 0, sizeof(pfl) );
	pfl.onGround = true;
	pfl.dead	 = (health <= 0);
}
   
/*
===============
idPlayer::ExitCinematic
===============
*/
void idPlayer::ExitCinematic( void ) {
  	Show();
   

// jnewquist: Cinematics are letterboxed, this auto-fixes on widescreens
	g_fixedHorizFOV.SetBool(false);


 	if ( weaponEnabled && weapon ) {
		//and this will restore them!
		weapon->PostSave();
//   		weapon->ExitCinematic();
   	}
   
   	SetAnimState( ANIMCHANNEL_TORSO, "Torso_Idle", 0 );
	SetAnimState( ANIMCHANNEL_LEGS, "Legs_Idle", 0 );

   	UpdateState();
}

/*
===============
idPlayer::SkipCinematic
===============
*/
bool idPlayer::SkipCinematic( void ) {
	StartSound( "snd_skipcinematic", SND_CHANNEL_ANY, 0, false, NULL );
	return gameLocal.SkipCinematic();
}
   
/*
=====================
idPlayer::UpdateConditions
=====================
*/
void idPlayer::UpdateConditions( void ) {
	idVec3	velocity;
	float	fallspeed;
	float	forwardspeed;
	float	sidespeed;

	// minus the push velocity to avoid playing the walking animation and sounds when riding a mover
	velocity = physicsObj.GetLinearVelocity() - physicsObj.GetPushedLinearVelocity();
	fallspeed = velocity * physicsObj.GetGravityNormal();

	pfl.onGround |= pfl.inWater;

 	if ( gameLocal.time - lastDmgTime < 500 ) {
		forwardspeed	= velocity * viewAxis[ 0 ];
		sidespeed		= velocity * viewAxis[ 1 ];
		pfl.forward		= ( pfl.onGround ) && ( forwardspeed > 20.01f );
		pfl.backward	= ( pfl.onGround ) && ( forwardspeed < -20.01f );
		pfl.strafeLeft	= ( pfl.onGround ) && ( sidespeed > 20.01f );
		pfl.strafeRight	= ( pfl.onGround ) && ( sidespeed < -20.01f );
 	} else if ( xyspeed > MIN_BOB_SPEED ) {
		pfl.forward		= ( pfl.onGround ) && ( usercmd.forwardmove > 0 );
		pfl.backward	= ( pfl.onGround ) && ( usercmd.forwardmove < 0 );
		pfl.strafeLeft	= ( pfl.onGround ) && ( usercmd.rightmove < 0 );
		pfl.strafeRight	= ( pfl.onGround ) && ( usercmd.rightmove > 0 );
 	} else {
 		pfl.forward		= false;
 		pfl.backward	= false;
 		pfl.strafeLeft	= false;
 		pfl.strafeRight	= false;
   	}

	if ( pfl.inWater ) {
		if ( !pfl.forward && !pfl.backward && !pfl.strafeLeft && !pfl.strafeLeft ) {
			if ( usercmd.upmove ) {
				pfl.forward = true;
			}
		}
	}

	pfl.run		= 1;
 	pfl.dead	= ( health <= 0 );
}

/*
==================
idPlayer::WeaponFireFeedback

Called when a weapon fires, generates head twitches, etc
==================
*/
void idPlayer::WeaponFireFeedback( const idDict *weaponDef ) {
	// force a blink
	blink_time = 0;

	// play the fire animation
	pfl.weaponFired = true;

	// Bias the intent direction more heavily due to firing

	// update view feedback
	playerView.WeaponFireFeedback( weaponDef );
}

/*
===============
idPlayer::StopFiring
===============
*/
void idPlayer::StopFiring( void ) {
	pfl.attackHeld	= false;
	pfl.weaponFired = false;
	pfl.reload		= false;
	if ( weapon ) {
		weapon->EndAttack();
	}
}

/*
===============
idPlayer::FireWeapon
===============
*/
void idPlayer::FireWeapon( void ) {
	idMat3 axis;
	idVec3 muzzle;

	if ( privateCameraView ) {
		return;
	}

	if ( g_editEntityMode.GetInteger() ) {
		GetViewPos( muzzle, axis );
		gameLocal.editEntities->SelectEntity( muzzle, axis[0], this );	
		return;
	}

	if ( gameLocal.time > allowNextFireTime && !isBuilding && !isFacingDispenser && !hiddenWeapon && weapon->IsReady() ) {
		if ( weapon->AmmoInClip() || weapon->AmmoAvailable() ) {
			pfl.attackHeld = true;
			weapon->BeginAttack();
		} else {
			pfl.attackHeld = false;
			pfl.weaponFired = false;
			StopFiring();
			NextBestWeapon();
		}
	}

	// If reloading when fire is hit cancel the reload
	else if ( weapon->IsReloading() ) {
		weapon->CancelReload();
	}

	if ( isPreviewing ) {
		StopPreview();
	}

	ClearDisguise();
}

/*
===============
idPlayer::CacheWeapons
===============
*/
void idPlayer::CacheWeapons( void ) {
	idStr	weap;
	int		w;
	
	for( w = 0; w < MAX_WEAPONS; w++ ) {
		if ( GetWeaponDef ( w ) ) {
			rvWeapon::CacheWeapon( spawnArgs.GetString( va( "def_weapon%d", w ) ) );	
		}
	}
}

/*
===============
idPlayer::Give
===============
*/
bool idPlayer::Give( const char *statname, const char *value, bool dropped ) {
	int amount;

	if ( pfl.dead ) {
		return false;
	}

	int boundaryHealth = inventory.maxHealth;
	int boundaryArmor = inventory.maxarmor;
	//if ( gameLocal.isMultiplayer ) {
		//In MP, you can get twice your max from pickups
		boundaryArmor *= 2;
	//}

	if ( !idStr::Icmp( statname, "health" ) ) {
		if ( health >= boundaryHealth ) {
			return false;
		}
 		amount = atoi( value );
 		if ( amount ) {
 			health += amount;
 			if ( health > boundaryHealth ) {
 				health = boundaryHealth;
 			}
		}
	} else if ( !idStr::Icmp( statname, "bonushealth" ) ) {
		// allow health over max health
		if ( health >= boundaryHealth * 2 ) {
			return false;
		}
		amount = atoi( value );
 		if ( amount ) {
 			health += amount;
 			if ( health > boundaryHealth * 2 ) {
 				health = boundaryHealth * 2;
 			}
		}
		nextHealthPulse = gameLocal.time + HEALTH_PULSE;
	} else if ( !idStr::Icmp( statname, "armor" ) ) {
		if ( inventory.armor >= boundaryArmor ) {
			return false;
		}
		amount = atoi( value );

		inventory.armor += amount;
		if ( inventory.armor > boundaryArmor ) {
			 inventory.armor = boundaryArmor;
		}
		nextArmorPulse = gameLocal.time + ARMOR_PULSE;
	} else {
 		return inventory.Give( this, spawnArgs, statname, value, &idealWeapon, true, dropped );
	}
	return true;
}

/*
==================
idPlayer::SlotForWeapon
==================
*/
int idPlayer::SlotForWeapon( const char *weaponName ) {
	int i;

	for( i = 0; i < MAX_WEAPONS; i++ ) {
		const char *weap = spawnArgs.GetString( va( "def_weapon%d", i ) );
		if ( !idStr::Cmp( weap, weaponName ) ) {
			return i;
		}
	}

	// not found
	return -1;
}

/*
===============
idPlayer::Reload
===============
*/
void idPlayer::Reload( void ) {
 	if ( gameLocal.isClient || spectating || gameLocal.inCinematic || !weapon ) {
 		return;
 	}

	weapon->Reload();
}

/*
===============
idPlayer::ShowCrosshair
===============
*/
void idPlayer::ShowCrosshair( void ) {
	if ( !weaponEnabled ) {
		return;
	}

	if ( cursor ) {
		cursor->HandleNamedEvent( "showCrossCombat" );
	}
	UpdateHudWeapon();
}

/*
===============
idPlayer::HideCrosshair
===============
*/
void idPlayer::HideCrosshair( void ) {
	if ( cursor ) {
		cursor->HandleNamedEvent( "crossHide" );
	}
}

/*
===============
idPlayer::LastWeapon
===============
*/
void idPlayer::LastWeapon( void ) {
	// Dont bother if previousWeapon is invalid or the player is spectating
	if ( spectating || previousWeapon < 0 )	{
		return;
	}

	idealWeapon = previousWeapon;
}

/*
===============
idPlayer::NextBestWeapon
===============
*/
void idPlayer::NextBestWeapon( void ) {
	const char *weap;
	int w = MAX_WEAPONS;

 	if ( gameLocal.isClient || !weaponEnabled ) {
 		return;
 	}
 
 	while ( w > 0 ) {
		w--;
		weap = spawnArgs.GetString( va( "def_weapon%d", w ) );
 		if ( !weap[ 0 ] || !GetWeaponDef(w) || ( !inventory.HasAmmo( weap ) ) ) {
			continue;
		}
		if ( !spawnArgs.GetBool( va( "weapon%d_best", w ) ) ) {
			continue;
		}
		break;
	}
	idealWeapon = w;
	weaponSwitchTime = gameLocal.time + WEAPON_SWITCH_DELAY;
	UpdateHudWeapon();
}

/*
===============
idPlayer::NextWeapon
===============
*/
void idPlayer::NextWeapon( void ) {
	const char *weap;
	int w;

 	if ( !weaponEnabled || spectating || hiddenWeapon || gameLocal.inCinematic || health <= 0 ) {
 		return;
 	}
 

// nrausch: support for turning the weapon change ui on and off

 	if ( gameLocal.isClient ) {
		return;
	}
	
	w = idealWeapon;
	while( true ) {
		w++;
		if ( w >= MAX_WEAPONS ) {
			w = 0;
		} 

		if ( w == idealWeapon )
			break;

 		weap = spawnArgs.GetString( va( "def_weapon%d", w ) );
		/*if ( !spawnArgs.GetBool( va( "weapon%d_cycle", w ) ) ) {
			continue;
		}*/
		if ( !weap[ 0 ] ) {
			continue;
		}
		if ( !GetWeaponDef(w) ) {
			continue;
		}
		if ( inventory.HasAmmo( weap ) ) {
			break;
		}
		
	}

	if ( ( w != currentWeapon ) && ( w != idealWeapon ) ) {
		idealWeapon = w;
		weaponSwitchTime = gameLocal.time + WEAPON_SWITCH_DELAY;
		UpdateHudWeapon();
	}
}

/*
===============
idPlayer::PrevWeapon
===============
*/
void idPlayer::PrevWeapon( void ) {
	const char *weap;
	int w;

 	if ( !weaponEnabled || spectating || hiddenWeapon || gameLocal.inCinematic || health <= 0 ) {
 		return;
 	}
 

// nrausch: support for turning the weapon change ui on and off

 	if ( gameLocal.isClient ) {
		return;
	}

	w = idealWeapon;
	while( true ) {
		w--;
		if ( w < 0 ) {
			w = MAX_WEAPONS - 1;
		}

		if ( w == idealWeapon )
			break;
		
 		weap = spawnArgs.GetString( va( "def_weapon%d", w ) );
		/*if ( !spawnArgs.GetBool( va( "weapon%d_cycle", w ) ) ) {
			continue;
		}*/
		if ( !weap[ 0 ] ) {
			continue;
		}
		if ( !GetWeaponDef(w) ) {
			continue;
		}
		if ( inventory.HasAmmo( weap ) ) {
			break;
		}
	}

	if ( ( w != currentWeapon ) && ( w != idealWeapon ) ) {
		idealWeapon = w;
		weaponSwitchTime = gameLocal.time + WEAPON_SWITCH_DELAY;
		UpdateHudWeapon();
	}
}

/*
===============
idPlayer::SelectWeapon
===============
*/
void idPlayer::SelectWeapon( const char *weapon_name ) {
	Event_SelectWeapon( weapon_name );
}

/*
===============
idPlayer::SelectWeapon
===============
*/
void idPlayer::SelectWeapon( int num, bool force ) {
	const char *weap;

 	if ( !weaponEnabled || spectating || gameLocal.inCinematic || health <= 0 ) {
		return;
	}

	if ( ( num < 0 ) || ( num >= MAX_WEAPONS ) ) {
		return;
	}

 	if ( gameLocal.isClient ) {
 		return;
 	}

 	weap = spawnArgs.GetString( va( "def_weapon%d", num ) );
	if ( !weap[ 0 ] ) {
		//gameLocal.Warning( "Invalid weapon def_weapon%d\n", num );
		return;
	}

	// cycle in-between weapons
	// if a weapon_def has a "def_weapon_swap" keyvalue pointing to another 
	// weapon, hitting that impulse twice will cycle to the target swap. 
	if( num == currentWeapon ) {
		const idDict* weapDict = gameLocal.FindEntityDefDict( weap, false );

		if( weapDict == NULL ) {
			gameLocal.Warning( "Invalid weapon entity %s\n", weap );
			return;
		}

		const char* destWeapon = weapDict->GetString( "def_weapon_swap", NULL );

		if( destWeapon != NULL ) {
			int swapNum = SlotForWeapon( destWeapon );
			if( swapNum == -1 ) {
				gameLocal.Warning( "Swap weapon for %s (%s) is invalid", weap, destWeapon );
			} else {
				num = swapNum;
			}
		} 
	} 

	if ( force || GetWeaponDef(num) ) {
 		if ( !inventory.HasAmmo( weap ) && !spawnArgs.GetBool( va( "weapon%d_allowempty", num ) ) ) {
 			return;
 		}
		/*if ( ( previousWeapon >= 0 ) && ( idealWeapon == num ) && ( spawnArgs.GetBool( va( "weapon%d_toggle", num ) ) ) ) {
 			weap = spawnArgs.GetString( va( "def_weapon%d", previousWeapon ) );
 			if ( !inventory.HasAmmo( weap ) && !spawnArgs.GetBool( va( "weapon%d_allowempty", previousWeapon ) ) ) {
 				return;
 			}
			idealWeapon = previousWeapon;
		} else */{
			idealWeapon = num;
		}
		UpdateHudWeapon();
	}
}


/*
===============
idPlayer::ActiveGui
===============
*/
idUserInterface *idPlayer::ActiveGui( void ) {
	//return focusUI;
	return NULL;
}

/*
===============
idPlayer::Weapon_Combat
===============
*/
void idPlayer::Weapon_Combat( void ) {
	
 	if ( !weaponEnabled || gameLocal.inCinematic || privateCameraView || isBuilding || isDispensing || isFacingDispenser ) {
		return;
	}

	if ( weapon ) {
		weapon->RaiseWeapon();

 		if ( weapon->IsReloading() ) {
 			if ( !pfl.reload ) {
 				pfl.reload = true;
 				SetAnimState ( ANIMCHANNEL_TORSO, "Torso_Reload", 4 );
 				UpdateState();
			}
 		} else {
 			pfl.reload = false;
 		}
	}

	if ( idealWeapon != currentWeapon ) {
 		if ( !weapon || weaponCatchup ) {
 			assert( gameLocal.isClient );

   			weaponGone = false;
   			SetWeapon ( idealWeapon );

			weapon->NetCatchup();
			
			SetAnimState ( ANIMCHANNEL_TORSO, "Torso_Idle", 0 );
			SetAnimState ( ANIMCHANNEL_LEGS, "Legs_Idle", 0 );
			UpdateState();
		} else {
 			if ( weapon->IsReady() || weapon->IsReloading() ) {
 				weapon->PutAway();
 			}
 
 			if ( weapon->IsHolstered() && weaponViewModel ) {
				assert( idealWeapon >= 0 );
				assert( idealWeapon < MAX_WEAPONS );

				SetWeapon ( idealWeapon );

				weapon->Raise();
			}
		}
	} else {
		weaponGone = false;
 		if ( weapon->IsHolstered() ) {
 			if ( !weapon->AmmoAvailable() ) {
 				// weapons can switch automatically if they have no more ammo
 				NextBestWeapon();
 			} else {
 				weapon->Raise();

				SetAnimState ( ANIMCHANNEL_TORSO, "Torso_RaiseWeapon", 3 );
   			}
   		}
	} 

	weaponCatchup = false;

	// check for attack
	pfl.weaponFired = false;
 	if ( ( usercmd.buttons & BUTTON_ATTACK ) && !weaponGone ) {
 		FireWeapon();
 	} else if ( oldButtons & BUTTON_ATTACK ) {
 		pfl.attackHeld = false;
 		weapon->EndAttack();
 	}

	if ( /*gameLocal.isMultiplayer && */spectating ) {
		UpdateHudWeapon();
	}

	// update our ammo clip in our inventory
	if ( gameLocal.GetLocalPlayer() == this && ( currentWeapon >= 0 ) && ( currentWeapon < MAX_WEAPONS ) ) {
		inventory.clip[ currentWeapon ] = weapon->AmmoInClip();
 		if ( hud && ( currentWeapon == idealWeapon ) ) {
 			UpdateHudAmmo( hud );
		}
	}
}

/*
===============
idPlayer::Weapon_Usable
===============
*/
void idPlayer::Weapon_Usable( void ) {
	StopFiring();
	weapon->LowerWeapon();

	if ( ( usercmd.buttons & BUTTON_ATTACK ) && !( oldButtons & BUTTON_ATTACK ) ) {
		//focusEnt->ProcessEvent ( &EV_Activate, this  );

		ClearFocus ( );
	}
}

/*
===============
idPlayer::LowerWeapon
===============
*/
void idPlayer::LowerWeapon( void ) {
	if ( weapon && !weapon->IsHidden() ) {
		weapon->LowerWeapon();
	}
}

/*
===============
idPlayer::RaiseWeapon
===============
*/
void idPlayer::RaiseWeapon( void ) {
	if ( weapon && weapon->IsHidden() ) {
		weapon->RaiseWeapon();
	}
}

/*
===============
idPlayer::WeaponLoweringCallback
===============
*/
void idPlayer::WeaponLoweringCallback( void ) {
	SetAnimState ( ANIMCHANNEL_TORSO, "Torso_LowerWeapon", 3 );
	UpdateState();
}

/*
===============
idPlayer::WeaponRisingCallback
===============
*/
void idPlayer::WeaponRisingCallback( void ) {
	SetAnimState ( ANIMCHANNEL_TORSO, "Torso_RaiseWeapon", 2 );
	UpdateState();
}

/*
===============
idPlayer::Weapon_GUI
===============
*/
void idPlayer::Weapon_GUI( void ) {

	/*if ( !objectiveSystemOpen ) {
		if ( idealWeapon != currentWeapon ) {
			Weapon_Combat();
		}
		StopFiring();
		weapon->LowerWeapon();
	}

	// disable click prediction for the GUIs. handy to check the state sync does the right thing
	if ( gameLocal.isClient && !net_clientPredictGUI.GetBool() ) {
		return;
	}

	if ( ( oldButtons ^ usercmd.buttons ) & BUTTON_ATTACK ) {
		sysEvent_t ev;
 		const char *command = NULL;
		bool updateVisuals = false;

		idUserInterface *ui = ActiveGui();
		if ( ui ) {

 			ev = sys->GenerateMouseButtonEvent( 1, ( usercmd.buttons & BUTTON_ATTACK ) != 0 );
 
			command = ui->HandleEvent( &ev, gameLocal.time, &updateVisuals );
			if ( updateVisuals && focusEnt && ui == focusUI ) {
				focusEnt->UpdateVisuals();
			}
		}
		if ( gameLocal.isClient ) {
			// we predict enough, but don't want to execute commands
			return;
		}
		if ( focusEnt ) {
			HandleGuiCommands( focusEnt, command );
		} else {
			HandleGuiCommands( this, command );
		}
	}
	*/
}

/*
===============
idPlayer::UpdateWeapon
===============
*/
void idPlayer::UpdateWeapon( void ) {
	if ( health <= 0 ) {
		return;
	}

	assert( !spectating );

	// clients need to wait till the weapon and it's world model entity
	// are present and synchronized ( weapon.worldModel idEntityPtr to idAnimatedEntity )
	if ( gameLocal.isClient && (!weaponViewModel || !weaponWorldModel) ) {
		return;
	}

	// always make sure the weapon is correctly setup before accessing it
	if ( !weapon ) {
		if ( idealWeapon != -1 ) {
			SetWeapon( idealWeapon );
			weaponCatchup = false;
			assert( weapon );
		} else {
			return;
		}
	}

	// Make sure the weapon is in a settled state before preventing thinking due
	// to drag entity.  This way things like hitting reload, zoom, etc, wont crash
	if ( g_dragEntity.GetInteger() ) {
		StopFiring();
		if ( weapon ) {
 			weapon->LowerWeapon();
 		}
 		dragEntity.Update( this );
		return;
	/*} else if ( focusType == FOCUS_USABLE ) {
		Weapon_Usable();
	} else if ( ActiveGui() ) {
		Weapon_GUI();*/
	} else if ( !hiddenWeapon ) { /* no pda yet || ( ( weapon_pda >= 0 ) && ( idealWeapon == weapon_pda ) ) ) { */
		Weapon_Combat();
	}	

	// Range finder for debugging
	if ( g_showRange.GetBool ( ) ) {
		idVec3	start;
		idVec3	end;
		trace_t	tr;
		
		start = GetEyePosition();
		end = start + viewAngles.ToForward() * 50000.0f;
		gameLocal.clip.TracePoint( tr, start, end, MASK_SHOT_BOUNDINGBOX, this );

		idVec3 forward;
		idVec3 right;
		idVec3 up;		
		viewAngles.ToVectors ( &forward, &right, &up );
		gameRenderWorld->DrawText( va( "%d qu", ( int )( tr.endpos - start ).Length() ), start + forward * 100.0f + right * 25.0f, .2f, colorCyan, viewAxis );
		gameRenderWorld->DrawText( va( "%d m", ( int )( tr.endpos - start ).Length() ), start + forward * 100.0f + right * 25.0f - up * 6.0f, .2f, colorCyan, viewAxis );
		gameRenderWorld->DrawText( va( "%d 2d", ( int )DistanceTo2d( tr.endpos ) ), start + forward * 100.0f + right * 25.0f - up * 12.0f, .2f, colorCyan, viewAxis );
	}

 	if ( hiddenWeapon ) {
 		weapon->LowerWeapon();
 	}

	// update weapon state, particles, dlights, etc
	weaponRunning = true;
	weaponViewModel->PresentWeapon( showWeaponViewModel );
	weaponRunning = false;
}

/*
===============
idPlayer::SpectateFreeFly
===============
*/
void idPlayer::SpectateFreeFly( bool force ) {
	idPlayer	*player;
	idVec3		newOrig;
	idVec3		spawn_origin;
	idAngles	spawn_angles;

	player = gameLocal.GetClientByNum( spectator );
	if ( force || gameLocal.time > lastSpectateChange ) {
		spectator = entityNumber;
		if ( player && player != this && !player->spectating && !player->IsInTeleport() ) {
			newOrig = player->GetPhysics()->GetOrigin();
			if ( player->physicsObj.IsCrouching() ) {
				newOrig[ 2 ] += pm_crouchviewheight.GetFloat();
			} else {
				newOrig[ 2 ] += pm_normalviewheight.GetFloat();
			}
			newOrig[ 2 ] += SPECTATE_RAISE;
			idBounds b = idBounds( vec3_origin ).Expand( pm_spectatebbox.GetFloat() * 0.5f );
			idVec3 start = player->GetPhysics()->GetOrigin();
			start[2] += pm_spectatebbox.GetFloat() * 0.5f;
			trace_t t;
			// assuming spectate bbox is inside stand or crouch box


			gameLocal.clip.TraceBounds( t, start, newOrig, b, MASK_PLAYERSOLID, player );

			newOrig.Lerp( start, newOrig, t.fraction );
			SetOrigin( newOrig );
			idAngles angle = player->viewAngles;
			angle[ 2 ] = 0;
			SetViewAngles( angle );
		} else {	
			if( !SelectSpawnPoint( spawn_origin, spawn_angles ) ) {
				return;
			}
			spawn_origin[ 2 ] += pm_normalviewheight.GetFloat();
			spawn_origin[ 2 ] += SPECTATE_RAISE;
			SetOrigin( spawn_origin );
			SetViewAngles( spawn_angles );
		}
		lastSpectateChange = gameLocal.time + 500;
	}
}

/*
===============
idPlayer::SpectateCycle
===============
*/
void idPlayer::SpectateCycle( void ) {
	idPlayer *player;

	if ( gameLocal.time > lastSpectateChange ) {
		int latchedSpectator = spectator;
		spectator = gameLocal.GetNextClientNum( spectator );
		player = gameLocal.GetClientByNum( spectator );
		assert( player ); // never call here when the current spectator is wrong
		// ignore other spectators
		while ( latchedSpectator != spectator && player->spectating ) {
			spectator = gameLocal.GetNextClientNum( spectator );
			player = gameLocal.GetClientByNum( spectator );
		}
		lastSpectateChange = gameLocal.time + 500;

		if ( player ) {
			UpdateHudWeapon( player->currentWeapon );
		}
	}
}

/*
===============
idPlayer::UpdateSpectating
===============
*/
void idPlayer::UpdateSpectating( void ) {
	assert( spectating );
	assert( !gameLocal.isClient );
	assert( IsHidden() );
	idPlayer *player;
	/*if ( !gameLocal.isMultiplayer ) {
		return;
	}*/
	player = gameLocal.GetClientByNum( spectator );
	if ( !player || ( player->spectating && player != this ) || ( team != TEAM_SPEC && player->team != team ) ) {
		SpectateFreeFly( true );		
	} else if ( usercmd.upmove > 0 && player && player != this ) {
		// following someone and hit jump? release.
		SpectateFreeFly( false );
	} else if ( usercmd.buttons & BUTTON_ATTACK ) {
		// tourney mode uses seperate cycling
		SpectateCycle();
	}
}

/*
===============
idPlayer::HandleSingleGuiCommand
===============
*/
bool idPlayer::HandleSingleGuiCommand( idEntity *entityGui, idLexer *src ) {
	idToken token;

	if ( !src->ReadToken( &token ) ) {
		return false;
	}

	if ( token == ";" ) {
		return false;
	}

	if ( token.Icmp( "addhealth" ) == 0 ) {
		if ( entityGui && health < 100 ) {
			int _health = entityGui->spawnArgs.GetInt( "gui_parm1" );
			int amt = ( _health >= HEALTH_PER_DOSE ) ? HEALTH_PER_DOSE : _health;
			_health -= amt;
			entityGui->spawnArgs.SetInt( "gui_parm1", _health );
			if ( entityGui->GetRenderEntity() && entityGui->GetRenderEntity()->gui[ 0 ] ) {
				entityGui->GetRenderEntity()->gui[ 0 ]->SetStateInt( "gui_parm1", _health );
			}
			health += amt;
			if ( health > 100 ) {
				health = 100;
			}
		}
		return true;
	}

	if ( token.Icmp( "ready" ) == 0 ) {
		PerformImpulse( IMPULSE_17 );
		return true;
	}

	if ( token.Icmp( "heal" ) == 0 && 
		entityGui->IsType( rvHealingStation::GetClassType() ) &&
		src->ReadToken( &token ) )
	{
		rvHealingStation * station = static_cast< rvHealingStation * >( entityGui );

		if ( token.Icmp( "begin" ) == 0 ) {
			station->BeginHealing( this );
		} else if ( token.Icmp( "end" ) == 0 ) {
			station->EndHealing( );
		} else {
			return false;
		}
		return true;
	}

	src->UnreadToken( &token );
	return false;
}

/*
==============
idPlayer::Collide
==============
*/
bool idPlayer::Collide( const trace_t &collision, const idVec3 &velocity ) {
	idEntity *other;
	other = gameLocal.entities[ collision.c.entityNum ];

	// allow client-side prediction of item collisions for simple client effects
	if ( gameLocal.isClient && !other->IsType( TFItem::GetClassType() ) ) {
		return false;
	}

	if ( other ) {
		other->Signal( SIG_TOUCH );
		if ( !spectating ) {
			if ( other->RespondsTo( EV_Touch ) ) {
				other->ProcessEvent( &EV_Touch, this, &collision );
			}
		} else {
			if ( other->RespondsTo( EV_SpectatorTouch ) ) {
				other->ProcessEvent( &EV_SpectatorTouch, this, &collision );
			}
		}
	}
	return false;
}

/*
================
idPlayer::UpdateLocation

Searches nearby locations 
================
*/
 void idPlayer::UpdateLocation( void ) {
	 if ( !gameLocal.isServer && entityNumber != gameLocal.localClientNum )
		 return;

	 currentLocation = gameLocal.LocationForPointQ4F( GetEyePosition() );

	 if ( hud ) {
		if ( currentLocation ) {
 			hud->SetStateString( "location", currentLocation->GetString() );
 		} else {
 			hud->SetStateString( "location", "unknown" );
 		}
	 }
}

 const char* fakeBuildingNames[] = {
		"Level 5 Lap Puppy",
		"Llamatic Camel Hump",
		"Slippery Fish",
		"Teenage Mutant Ninja Turtle",
		"Late Night Sex Toy",
		"Level 2 Little Friend",
		"Extension of Manhood",
		"Pokemon Character",
		"Significant Other",
		"Freaky Contraption",		
 };

 const int numFakeBuildingNames = 10;

/*
================
idPlayer::UpdateFocus
================
*/
void idPlayer::UpdateFocus( void ) {
	
	// These only need to be updated at the last tic
	if ( !gameLocal.isLastPredictFrame ) {
		return;
	}
	
	// No focus during cinimatics
	if ( gameLocal.inCinematic ) {
		return;
	}

	//cvarSystem->SetCVarInteger( "pm_isZoomed", zoomed ? pm_zoomedSlow.GetInteger() : 0 );
	cvarSystem->SetCVarInteger( "pm_isZoomed", zoomed ? (int)(g_zoomfov.GetFloat()/g_fov.GetFloat()*100) : 0 );

	trace_t trace;

	focusDist = 768.0f;

	idVec3 start = GetEyePosition();
	idVec3 end = start + viewAngles.ToForward() * 768.0f;

	gameLocal.clip.TracePoint( trace, start, end, MASK_SHOT_BOUNDINGBOX | CONTENTS_WRENCH, this );

	bool setText = false;
	bool sameAsLast = false;

	// no aim text if player is invisible
 	if ( trace.fraction < 1.0f ) {
		idEntity* ent = gameLocal.GetTraceEntity( trace );

		focusDist = trace.fraction * 768.0f;
		
		if ( ent && ent->health > 0 ) {

			int spawnId = gameLocal.GetSpawnId( ent );

			sameAsLast = spawnId == focusEnt.GetSpawnId();

			if ( gameLocal.time < nextFocusUpdateTime && sameAsLast )
				return;

			nextFocusUpdateTime = gameLocal.time + 200;

			focusEnt = ent;

			//if ( mphud ) {

				bool friendly = false;

				if ( ent->IsType( idPlayer::GetClassType() ) ) {

					aimClientNum = ent->entityNumber;

					setText = true;

					if ( mphud ) {

						idPlayer* p = NULL;

						if ( afflictions & AFFL_HALLUCINATE ) {
							int startClient = gameLocal.random.RandomInt( gameLocal.numClients - 1 );

							while ( true ) {
								if ( gameLocal.mpGame.IsInGame( startClient ) ) {
									p = GET_PLAYER( startClient );
									break;
								}

								startClient--;
								if ( startClient < 0 )
									startClient = gameLocal.numClients - 1;
							}
						}
						else if ( static_cast<idPlayer*>(ent)->disguiseName >= 0 ) {
							p = GET_PLAYER( static_cast<idPlayer*>(ent)->disguiseName );
						}

						if ( !p )
							p = static_cast<idPlayer*>(ent);

						idStr uname = p->uiName;
						idStr cname = p->uiClan;

						uname.RemoveEscapes();
						cname.RemoveEscapes();

						friendly = p->team == team || p->disguiseTeam == team;

						const char* color;

						if ( p->team != team && p->disguiseTeam != INVALID_TEAM ) {
							color = tfGame.GetTeamEscapeColor( p->disguiseTeam );
						}
						else {
							color = tfGame.GetTeamEscapeColor( p->team );
						}

						if ( friendly && currentPC == CLASS_ENGINEER ) {
							mphud->SetStateString( "aim_text", va( "%s%s\n%s\n^0%d armor", color, uname.c_str(), cname.c_str(), p->inventory.armor ) );
						}
						else if ( friendly && currentPC == CLASS_MEDIC ) {
							mphud->SetStateString( "aim_text", va( "%s%s\n%s\n^0%d health", color, uname.c_str(), cname.c_str(), ent->health ) );
						}
						else {
							mphud->SetStateString( "aim_text", va( "%s%s\n%s", color, uname.c_str(), cname.c_str() ) );
						}
					}
				}
				else if ( ent->IsType( SentryGun::GetClassType() ) ) {

					setText = true;

					if ( mphud ) {

						SentryGun* sent = static_cast<SentryGun*>(ent);

						idPlayer* owner = sent->GetOwner();

						if ( !owner ) {
							mphud->SetStateString( "aim_text", "???" );
							friendly = false;
						}
						else {

							idStr uname = owner->uiName;

							uname.RemoveEscapes();

							const char* color = tfGame.GetTeamEscapeColor( owner->team );

							if ( afflictions & AFFL_HALLUCINATE ) {
								friendly = gameLocal.random.RandomInt() & 1;

								const char* bName = fakeBuildingNames[ gameLocal.random.RandomInt( numFakeBuildingNames - 1 ) ];
								mphud->SetStateString( "aim_text", va( "%s%s^0's %s", color, uname.c_str(), bName ) );
							}
							else {

								friendly = sent->team == team;

								int level = sent->GetLevel();

								if ( currentPC == CLASS_ENGINEER && friendly) {
									if ( level == 1 || level == 2 )
										mphud->SetStateString( "aim_text", va( "%s%s^0's Level %d Sentry Gun\n%d health, %d shells", color, uname.c_str(), level, sent->health, sent->shells ) );
									else 
										mphud->SetStateString( "aim_text", va( "%s%s^0's Level 3 Sentry Gun\n%d health, %d shells, %d rockets", color, uname.c_str(), sent->health, sent->shells, sent->rockets ) );
								}
								else {
									mphud->SetStateString( "aim_text", va( "%s%s^0's Level %d Sentry Gun", color, uname.c_str(), level ) );
								}
							}
						}
					}
				}

				else if ( ent->IsType( Dispenser::GetClassType() ) ) {

					setText = true;

					if ( mphud ) {

						Dispenser* disp = static_cast<Dispenser*>(ent);

						idPlayer* owner = disp->GetOwner();

						if ( !owner ) {
							mphud->SetStateString( "aim_text", "???" );
							friendly = false;
						}
						else {

							const char* color = tfGame.GetTeamEscapeColor( owner->team );

							idStr uname = owner ? owner->uiName : "";

							uname.RemoveEscapes();

							if ( afflictions & AFFL_HALLUCINATE ) {
								friendly = gameLocal.random.RandomInt() & 1;

								const char* bName = fakeBuildingNames[ gameLocal.random.RandomInt( numFakeBuildingNames - 1 ) ];
								mphud->SetStateString( "aim_text", va( "%s%s^0's %s", color, uname.c_str(), bName ) );
							}
							else {

								friendly = disp->team == team;

								if ( currentPC == CLASS_ENGINEER && friendly ) {
									mphud->SetStateString( "aim_text", va( "%s%s^0's Ammo/Armor Dispenser\n%d health", color, uname.c_str(), disp->health ) );
								}
								else {
									mphud->SetStateString( "aim_text", va( "%s%s^0's Ammo/Armor Dispenser", color, uname.c_str() ) );
								}
							}
						}
					}
				}

				if ( cursor ) {
					// when looking at a friendly, color the crosshair
					if( friendly ) {
						cursor->HandleNamedEvent( "targetFriendly" );
					} else {
						cursor->HandleNamedEvent( "clearTarget" );
					}
				}
			//}
		}
	}

	if ( setText ) {
		if ( !sameAsLast && mphud ) {
			mphud->HandleNamedEvent( "aim_text" );
		}
	}
	else {
		
		if ( focusEnt.GetSpawnId() > 0 ) {
			if ( mphud ) {
				mphud->HandleNamedEvent( "aim_fade" );
			}
			if( cursor ) {
				cursor->HandleNamedEvent( "clearTarget" );
			}
		}
		focusEnt = NULL;
	}
}

/*
================
idPlayer::ClearFocus
================
*/
void idPlayer::ClearFocus ( void ) {
	//SetFocus ( FOCUS_NONE, 0, NULL, NULL );
}

/*
================
idPlayer::SetFocus
================
*/
/*void idPlayer::SetFocus ( playerFocus_t newType, int _focusTime, idEntity* newEnt, idUserInterface* newUI ) {
	const char* command;

	// Handle transitions from one user interface to another or to none
	if ( newUI != focusUI ) {
		if ( focusUI ) {		
			command = focusUI->Activate( false, gameLocal.time );
			HandleGuiCommands( focusEnt, command );
			StartSound( "snd_guiexit", SND_CHANNEL_ANY, 0, false, NULL );
		}			
		if ( newUI ) {
			command = newUI->Activate( true, gameLocal.time );
			HandleGuiCommands( newEnt, command );
			StartSound( "snd_guienter", SND_CHANNEL_ANY, 0, false, NULL );

			// Hide the weapon when a gui is being used
		}
	}

	// Show the appropriate cursor for the current focus type
	if ( cursor && ( focusType != newType ) ) {
		switch ( newType ) {
			case FOCUS_USABLE:
				cursor->HandleNamedEvent ( "showCrossUsable" );
				break;
			case FOCUS_GUI:
				cursor->HandleNamedEvent ( "showCrossGui" );
				break;
			case FOCUS_CHARACTER:

				cursor->HandleNamedEvent ( "showCrossTalk" );
				break;
			default:
				// Make sure the weapon is shown in the default state

// abahr: don't do this if weapons are disabled
				cursor->HandleNamedEvent ( WeaponIsEnabled() ? "showCrossCombat" : "crossHide" );

				break;
		}
	}


	focusType = newType;
	focusEnt  = newEnt;
	focusUI	  = newUI;
	
	if ( focusType == FOCUS_NONE ) {
		focusTime = 0;
	} else {
		focusTime = gameLocal.time + _focusTime;
	}
}*/

/*
=================
idPlayer::CrashLand

Check for hard landings that generate sound events
=================
*/
void idPlayer::CrashLand( const idVec3 &oldOrigin, const idVec3 &oldVelocity ) {
	idVec3		origin, velocity;
	idVec3		gravityVector, gravityNormal;
	float		delta;
	float		dist;
	float		vel, acc;
	float		t;
	float		a, b, c, den;
 	bool		noDamage;

	pfl.softLanding = false;
	pfl.hardLanding = false;

	// if the player is not on the ground
	if ( !physicsObj.HasGroundContacts() ) {
		return;
	}

	// 3j: last fall damage time to fix double fall damage
	if ( gameLocal.time - lastCrashLandTime < 50 )
		return;

	gravityNormal = physicsObj.GetGravityNormal();

	// if the player wasn't going down
	if ( ( oldVelocity * -gravityNormal ) >= 0.0f ) {
		return;
	}

	float waterLevel = physicsObj.GetWaterLevel();

	// never take falling damage if completely underwater
	// 3j: seems unrealistic
	/*if ( waterLevel >= WATERLEVEL_HEAD ) {
		return;
	}*/

	// no falling damage if touching a nodamage surface
 	noDamage = false;
	for ( int i = 0; i < physicsObj.GetNumContacts(); i++ ) {
		const contactInfo_t &contact = physicsObj.GetContact( i );
		if ( contact.material->GetSurfaceFlags() & SURF_NODAMAGE ) {
 			noDamage = true;
 			break;
		}
	}

	//jshepard: no falling damage if falling damage is disabled
	if( pfl.noFallingDamage )	{
		return;
	}

	origin = GetPhysics()->GetOrigin();
	gravityVector = physicsObj.GetGravity();

	// calculate the exact velocity on landing
	dist = ( origin - oldOrigin ) * -gravityNormal;
	vel = oldVelocity * -gravityNormal;
	acc = -gravityVector.Length();

	a = acc / 2.0f;
	b = vel;
	c = -dist;

	den = b * b - 4.0f * a * c;
	if ( den < 0 ) {
		return;
	}
	t = ( -b - idMath::Sqrt( den ) ) / ( 2.0f * a );

	delta = vel + t * acc;
	delta = delta * delta * 0.0001;

	// reduce falling damage if there is standing water
	// 3j: updated for float
	/*if ( waterLevel == WATERLEVEL_WAIST ) {
		delta *= 0.25f;
	}
	if ( waterLevel == WATERLEVEL_FEET ) {
		delta *= 0.5f;
	}*/
	delta *= ( 1.0f - waterLevel );

	if ( delta < 1.0f ) {
		return;
	}

	AttackerInfo info;
	if ( lastImpulsePlayer )
		info.Create( lastImpulsePlayer );
	else
		info.Create( gameLocal.world );

	TFDamage dmg;
	dmg.SetDir( GetPhysics()->GetGravityNormal() );

	// ddynerman: moved height delta selection to player def
	if ( delta > fatalFallDelta && fatalFallDelta > 0.0f ) {
		pfl.hardLanding = true;
		landChange = -32;
		landTime = gameLocal.time;
 		if ( !noDamage ) {
 			pain_debounce_time = gameLocal.time + pain_delay + 1;  // ignore pain since we'll play our landing anim
			dmg.Create( info, "damage_fatalfall", 1.0f );
			Damage_TF( dmg, 1.0f );
			lastCrashLandTime = gameLocal.time;
 		}
	} else if ( delta > hardFallDelta && hardFallDelta > 0.0f ) {
		pfl.hardLanding = true;
		landChange	= -24;
		landTime	= gameLocal.time;
 		if ( !noDamage ) {
 			pain_debounce_time = gameLocal.time + pain_delay + 1;  // ignore pain since we'll play our landing anim
			dmg.Create( info, "damage_hardfall", 1.0f );
			Damage_TF( dmg, 1.0f );
			lastCrashLandTime = gameLocal.time;
 		}
	} else if ( delta > softFallDelta && softFallDelta > 0.0f ) {
		pfl.softLanding = true;
 		landChange	= -16;
 		landTime	= gameLocal.time;
 		if ( !noDamage ) {
 			pain_debounce_time = gameLocal.time + pain_delay + 1;  // ignore pain since we'll play our landing anim
			dmg.Create( info, "damage_softfall", 1.0f );
			Damage_TF( dmg, 1.0f );
			lastCrashLandTime = gameLocal.time;
		}
	} else if ( delta > noFallDelta && noFallDelta > 0.0f ) {
		pfl.softLanding = true;
		landChange	= -8;
		landTime	= gameLocal.time;
	}

	// ddynerman: sometimes the actual landing animation is pre-empted by another animation (i.e. sliding, moving forward)
	// so we play the landing sound here instead of relying on the anim
	if( pfl.hardLanding ) {
		StartSound ( "snd_land_hard", SND_CHANNEL_ANY, 0, false, NULL );		
		StartSound ( "snd_land_hard_pain", SND_CHANNEL_ANY, 0, false, NULL );	
	} else if ( pfl.softLanding ) {
		// todo - 2 different landing sounds for variety?
		StartSound ( "snd_land_soft", SND_CHANNEL_ANY, 0, false, NULL );				 
	}
}

/*
===============
idPlayer::BobCycle
===============
*/
void idPlayer::BobCycle( const idVec3 &pushVelocity ) {
	float		bobmove;
	int			old, deltaTime;
	idVec3		vel, gravityDir, velocity;
	idMat3		viewaxis;
	float		bob;
	float		delta;
	float		speed;
	float		f;


	//
	// calculate speed and cycle to be used for
	// all cyclic walking effects
	//
	velocity = physicsObj.GetLinearVelocity() - pushVelocity;

	if ( noclip ) {
		velocity.Zero ( );
	}
   
	gravityDir = physicsObj.GetGravityNormal();
	vel = velocity - ( velocity * gravityDir ) * gravityDir;
	xyspeed = vel.LengthFast();
	
	if ( !physicsObj.HasGroundContacts() || ( /*gameLocal.isMultiplayer && */spectating ) ) {
		// airborne
		bobCycle = 0;
		bobFoot = 0;
		bobfracsin = 0;
 	} else if ( ( !usercmd.forwardmove && !usercmd.rightmove ) || ( xyspeed <= MIN_BOB_SPEED ) ) {
 		// start at beginning of cycle again
 		bobCycle = 0;
 		bobFoot = 0;
 		bobfracsin = 0;
	} else {
		if ( physicsObj.IsCrouching() ) {
			//bobmove = pm_crouchbob.GetFloat();
			bobmove = 0.5f;
			// ducked characters never play footsteps
		} else {
			// vary the bobbing based on the speed of the player
			//bobmove = pm_walkbob.GetFloat() * ( 1.0f - bobFrac ) + pm_runbob.GetFloat() * bobFrac;
			bobmove = .3f * ( 1.0f - bobFrac ) + 0.4f * bobFrac;
		}

		// check for footstep / splash sounds
		old = bobCycle;
		bobCycle = (int)( old + bobmove * gameLocal.GetMSec() ) & 255;
		bobFoot = ( bobCycle & 128 ) >> 7;
		bobfracsin = idMath::Fabs( idMath::Sin( ( bobCycle & 127 ) / 127.0 * idMath::PI ) );
	}

	// calculate angles for view bobbing
	viewBobAngles.Zero();

	// no view bob at all in MP while zoomed in
	if( /*gameLocal.isMultiplayer && */IsZoomed() ) {
		bobCycle = 0;
		bobFoot = 0;
		bobfracsin = 0;	
		return;
	}

	viewaxis = viewAngles.ToMat3() * physicsObj.GetGravityAxis();

	// add angles based on velocity
	//delta = velocity * viewaxis[0];
	//viewBobAngles.pitch += delta * pm_runpitch.GetFloat();
	
	//delta = velocity * viewaxis[1];
	//viewBobAngles.roll -= delta * pm_runroll.GetFloat();

	// add angles based on bob
	// make sure the bob is visible even at low speeds
	speed = xyspeed > 200 ? xyspeed : 200;

	delta = bobfracsin * pm_bobpitch.GetFloat() * speed;
	if ( physicsObj.IsCrouching() ) {
		delta *= 3;		// crouching
	}
	viewBobAngles.pitch += delta;
	delta = bobfracsin * pm_bobroll.GetFloat() * speed;
	if ( physicsObj.IsCrouching() ) {
		delta *= 3;		// crouching accentuates roll
	}
	if ( bobFoot & 1 ) {
		delta = -delta;
	}
	viewBobAngles.roll += delta;

	// calculate position for view bobbing
	viewBob.Zero();

	if ( physicsObj.HasSteppedUp() ) {

		// check for stepping up before a previous step is completed
		deltaTime = gameLocal.time - stepUpTime;
		if ( deltaTime < STEPUP_TIME ) {
			stepUpDelta = stepUpDelta * ( STEPUP_TIME - deltaTime ) / STEPUP_TIME + physicsObj.GetStepUp();
		} else {
			stepUpDelta = physicsObj.GetStepUp();
		}
		if ( stepUpDelta > 2.0f * pm_stepsize.GetFloat() ) {
			stepUpDelta = 2.0f * pm_stepsize.GetFloat();
		}
		stepUpTime = gameLocal.time;
	}

	idVec3 gravity = physicsObj.GetGravityNormal();

	// if the player stepped up recently
	deltaTime = gameLocal.time - stepUpTime;
	if ( deltaTime < STEPUP_TIME ) {
		viewBob += gravity * ( stepUpDelta * ( STEPUP_TIME - deltaTime ) / STEPUP_TIME );
	}

	// add bob height after any movement smoothing
	/*bob = bobfracsin * xyspeed * pm_bobup.GetFloat();
	if ( bob > 6 ) {
		bob = 6;
	}*/
	bob = 0;

// abahr: added gravity
	viewBob += bob * -gravityDir;


	// add fall height
	delta = gameLocal.time - landTime;
	if ( delta < LAND_DEFLECT_TIME ) {
		f = delta / LAND_DEFLECT_TIME;
		viewBob -= gravity * ( landChange * f );
	} else if ( delta < LAND_DEFLECT_TIME + LAND_RETURN_TIME ) {
		delta -= LAND_DEFLECT_TIME;
		f = 1.0 - ( delta / LAND_RETURN_TIME );
		viewBob -= gravity * ( landChange * f );
	}	
}

/*
================
idPlayer::UpdateDeltaViewAngles
================
*/
void idPlayer::UpdateDeltaViewAngles( const idAngles &angles ) {
	// set the delta angle
	idAngles delta;
	for( int i = 0; i < 3; i++ ) {
		delta[ i ] = angles[ i ] - SHORT2ANGLE( usercmd.angles[ i ] );
	}
	SetDeltaViewAngles( delta );
}

/*
================
idPlayer::SetViewAngles
================
*/
void idPlayer::SetViewAngles( const idAngles &angles ) {
	UpdateDeltaViewAngles(angles);
	viewAngles = angles;
}

/*
================
idPlayer::UpdateViewAngles
================
*/
void idPlayer::UpdateViewAngles( void ) {
	int i;
	idAngles delta;

	if ( !noclip && ( gameLocal.inCinematic || privateCameraView || gameLocal.GetCamera() ) ) {
		// no view changes at all, but we still want to update the deltas or else when
		// we get out of this mode, our view will snap to a kind of random angle
		UpdateDeltaViewAngles( viewAngles );
		return;
	}

	// if dead
	if ( !spectating && health <= 0 ) {
		if ( pm_thirdPersonDeath.GetBool() ) {
			viewAngles.roll = 0.0f;
			viewAngles.pitch = 30.0f;
		} else {
			viewAngles.roll = 40.0f;
			viewAngles.pitch = -15.0f;
		}
		return;
	}

	// circularly clamp the angles with deltas
	// circularly clamp the angles with deltas
//	if( gameLocal.localClientNum == entityNumber ) {
//		gameLocal.Printf( "BEFORE VIEWANGLES: %s\n", viewAngles.ToString() );
//		gameLocal.Printf( "\tUSERCMD: <%d, %d, %d>\n", usercmd.angles[ 0 ], usercmd.angles[ 1 ], usercmd.angles[ 2 ] );
//		gameLocal.Printf( "\tDELTAVIEW: %s\n", deltaViewAngles.ToString() );
//	}
	for ( i = 0; i < 3; i++ ) {
		cmdAngles[i] = SHORT2ANGLE( usercmd.angles[i] );
		viewAngles[i] = idMath::AngleNormalize180( SHORT2ANGLE( usercmd.angles[i] ) + deltaViewAngles[i] );
	}
	if ( !centerView.IsDone( gameLocal.time ) ) {
		viewAngles.pitch = centerView.GetCurrentValue( gameLocal.time );
	}
//	if( gameLocal.localClientNum == entityNumber ) {
//		gameLocal.Printf( "AFTER VIEWANGLES: %s\n", viewAngles.ToString() );
//	}

	// clamp the pitch
	if ( noclip ) {
		if ( viewAngles.pitch > 89.0f ) {
			// don't let the player look down more than 89 degrees while noclipping
			viewAngles.pitch = 89.0f;
		} else if ( viewAngles.pitch < -89.0f ) {
			// don't let the player look up more than 89 degrees while noclipping
			viewAngles.pitch = -89.0f;
		}
	} else {
		if ( viewAngles.pitch > pm_maxviewpitch.GetFloat() ) {
			// don't let the player look down enough to see the shadow of his (non-existant) feet
			viewAngles.pitch = pm_maxviewpitch.GetFloat();
		} else if ( viewAngles.pitch < pm_minviewpitch.GetFloat() ) {
			// don't let the player look up more than 89 degrees
			viewAngles.pitch = pm_minviewpitch.GetFloat();
		}
	}

	UpdateDeltaViewAngles( viewAngles );

	// orient the model towards the direction we're looking
	SetAngles( idAngles( 0, viewAngles.yaw, 0 ) );

	// save in the log for analyzing weapon angle offsets
	loggedViewAngles[ gameLocal.framenum & (NUM_LOGGED_VIEW_ANGLES-1) ] = viewAngles;
}

// abahr
/*
==============
idPlayer::UpdateGravity
==============
*/
void idPlayer::UpdateGravity( void ) {
	GetPhysics()->SetGravity( gameLocal.GetCurrentGravity(this) );
}

/*
==============
idPlayer::ToggleScoreboard
==============
*/
void idPlayer::ToggleScoreboard( void ) {
	scoreBoardOpen ^= 1;
}

/*
==============
idPlayer::Spectate
==============
*/
void idPlayer::Spectate( bool spectate, bool force ) {
 	idBitMsg	msg;
 	byte		msgBuf[MAX_EVENT_PARAM_SIZE];
 
 	// track invisible player bug
 	// all hiding and showing should be performed through Spectate calls
 	// except for the private camera view, which is used for teleports
	assert( force || ( teleportEntity.GetEntity() != NULL ) || ( IsHidden() == spectating ) );

	if ( spectating == spectate && !force ) {
		return;
	}

	spectating = spectate;

	// don't do any smoothing with this snapshot
	predictedFrame = gameLocal.framenum;
 
 	if ( gameLocal.isServer ) {
 		msg.Init( msgBuf, sizeof( msgBuf ) );
 		msg.WriteBits( spectating, 1 );
		msg.WriteBits( currentPC, ASYNC_CLASS_BITS );
 		ServerSendEvent( EVENT_SPECTATE, &msg, false, -1 );
 	}
 
	if ( spectating ) {
		// join the spectators
		delete clientHead;
		clientHead = NULL;
		spectator = this->entityNumber;
		Init();
		StopRagdoll();
		SetPhysics( &physicsObj );
		common->DPrintf( "idPlayer::Spectate() - Disabling clip for %d '%s' - spectate: %d force: %d\n", entityNumber, uiName, spectate, force );
		physicsObj.DisableClip();
		Hide();
		Event_DisableWeapon();

		// remove the weapon
		if ( weaponRunning ) {
			gameLocal.Error( "idPlayer::Spectate -attempting to delete weapon while it's running" );
		}
		delete weapon;
		weapon = NULL;
		if ( !gameLocal.isClient ) {
			delete weaponViewModel;
			weaponViewModel = NULL;
			delete weaponWorldModel;
			weaponWorldModel = NULL;
		}
	} else {
		// put everything back together again
		UpdateModelSetup( true );
		currentWeapon = -1;	// to make sure the def will be loaded if necessary
		Show();
		Event_EnableWeapon();
	}

	SetClipModel( false );
}

/*
==============
idPlayer::SetClipModel
==============
*/
void idPlayer::SetClipModel( bool forceSpectatorBBox ) {
	idBounds bounds;

	common->DPrintf( "idPlayer::SetClipModel() - Called on %d '%s' forceSpectatorBBox = %d spectate = %d\n", entityNumber, uiName, forceSpectatorBBox, spectating );
	if ( spectating || forceSpectatorBBox ) {
 		bounds = idBounds( vec3_origin ).Expand( pm_spectatebbox.GetFloat() * 0.5f );
	} else {
		bounds[0].Set( -pm_bboxwidth.GetFloat() * 0.5f, -pm_bboxwidth.GetFloat() * 0.5f, 0 );
		bounds[1].Set( pm_bboxwidth.GetFloat() * 0.5f, pm_bboxwidth.GetFloat() * 0.5f, pm_normalheight.GetFloat() );
	}
	// the origin of the clip model needs to be set before calling SetClipModel
	// otherwise our physics object's current origin value gets reset to 0
	idClipModel *newClip;

// mwhitlock: Dynamic memory consolidation
	RV_PUSH_HEAP_MEM_AUTO(p0,this);


	if ( pm_usecylinder.GetBool() ) {
		newClip = new idClipModel( idTraceModel( bounds, 8 ), declManager->FindMaterial( "textures/flesh_boundingbox" ) );
		newClip->Translate( physicsObj.PlayerGetOrigin() );
		physicsObj.SetClipModel( newClip, 1.0f );
	} else {
		newClip = new idClipModel( idTraceModel( bounds ), declManager->FindMaterial( "textures/flesh_boundingbox" ) );
		newClip->Translate( physicsObj.PlayerGetOrigin() );
		physicsObj.SetClipModel( newClip, 1.0f );
	}
}

/*
==============
idPlayer::PerformImpulse
==============
*/
void idPlayer::PerformImpulse( int impulse ) {

	if ( menuNum > 0 && impulse < 10 ) {
		MenuSlotSelected( impulse );
		return;
	}

	switch( impulse ) {
		case IMPULSE_0:
			SelectWeapon( impulse, false );
			break;
		case IMPULSE_1:
			SelectWeapon( impulse, false );
			break;
		case IMPULSE_2:
			SelectWeapon( impulse, false );
			break;
		case IMPULSE_3:
			SelectWeapon( impulse, false );
			break;


		case IMPULSE_13: {
			Reload();
			break;
		}
		case IMPULSE_14: {
			if ( isPreviewing ) {
				buildPreview.Rotate( 15.0f );

				// 3j: so client doesn't switch weapons
				return;
			}
			else {
				NextWeapon();
			}

			break;
		}
		case IMPULSE_15: {
			if ( isPreviewing ) {
				buildPreview.Rotate( -15.0f );

				// 3j: so client doesn't switch weapons
				return;
			}
			else {
				PrevWeapon();
			}

			break;
		}

		case IMPULSE_18: {
			centerView.Init(gameLocal.time, 200, viewAngles.pitch, 0);
			break;
		}
		case IMPULSE_19: {
/*		
			// when we're not in single player, IMPULSE_19 is used for showScores
			// otherwise it does IMPULSE_12 (PDA)
			if ( !gameLocal.isMultiplayer ) {
				if ( !objectiveSystemOpen ) {
					if ( weapon ) {
						weapon->Hide ();
					}
				}
				ToggleMap();
			}
*/
			break;
		}
		/*case IMPULSE_20: {
 			if ( gameLocal.isClient || entityNumber == gameLocal.localClientNum ) {
 				gameLocal.mpGame.ToggleTeam( );
			}
			break;
		}*/
		case IMPULSE_21: {
			break;
		}
		/*case IMPULSE_22: {
 			if ( gameLocal.isClient || entityNumber == gameLocal.localClientNum ) {
 				gameLocal.mpGame.ToggleSpectate( );
   			}
   			break;
   		}*/
				
		case IMPULSE_28: {
 			/*if ( gameLocal.isClient || entityNumber == gameLocal.localClientNum ) {
 				gameLocal.mpGame.CastVote( gameLocal.localClientNum, true );
   			}*/
   			break;
   		}
   		case IMPULSE_29: {
 			/*if ( gameLocal.isClient || entityNumber == gameLocal.localClientNum ) {
				gameLocal.mpGame.CastVote( gameLocal.localClientNum, false );
   			}*/
   			break;
   		}
		case IMPULSE_DESTROY_SENT: {					// destroy sentry
			if ( !gameLocal.isClient ) {
				if ( sentryGun ) {
					sentryGun->Explode();
				}
			}
			break;
		}
	    case IMPULSE_DESTROY_DISP: {					// destroy disp
			if ( !gameLocal.isClient ) {
				if ( dispenser ) {
					dispenser->Explode();
				}
			}
			break;
		}
		case IMPULSE_DISCARD: {
			if ( !gameLocal.isClient )
				DropBackPack( false );
			break;
		}
		case IMPULSE_DETPIPE: {
			if ( !gameLocal.isClient )
				DetPipe( true, false );
			break;
		}
		case IMPULSE_40: {
			//idFuncRadioChatter::RepeatLast();
			break;
		}

 		case IMPULSE_51: {
 			LastWeapon();
 			break;
 		}
	} 

	if ( gameLocal.isClient ) {
		idBitMsg	msg;
		byte		msgBuf[MAX_EVENT_PARAM_SIZE];

 		assert( entityNumber == gameLocal.localClientNum );
		msg.Init( msgBuf, sizeof( msgBuf ) );
		msg.BeginWriting();
		msg.WriteBits( impulse, IMPULSE_NUMBER_OF_BITS );
		ClientSendEvent( EVENT_IMPULSE, &msg );
	} 
}
   
/*
==============
idPlayer::HandleESC
==============
*/
bool idPlayer::HandleESC( void ) {
	if ( gameLocal.inCinematic ) {
		return SkipCinematic();
	}
	if ( isPreviewing ) {
		StopPreview();
	}
	return false;
}

/*
==============
idPlayer::EvaluateControls
==============
*/
void idPlayer::EvaluateControls( void ) {
	// check for respawning
	if ( pfl.dead || pfl.objectiveFailed ) {
		if ( ( gameLocal.time > minRespawnTime ) && ( usercmd.buttons & BUTTON_ATTACK ) ) {
			forceRespawn = true;
		} else if ( gameLocal.time > maxRespawnTime ) {
			forceRespawn = true;
		}
	}

	if ( ( usercmd.flags & UCF_IMPULSE_SEQUENCE ) != ( oldFlags & UCF_IMPULSE_SEQUENCE ) )  {
		PerformImpulse( usercmd.impulse );
	}

	if( forceScoreBoard && forceScoreBoardTime && gameLocal.time > forceScoreBoardTime ) {
		forceScoreBoardTime = 0;
		forceScoreBoard = false;
	}
	scoreBoardOpen		= ( ( usercmd.buttons & BUTTON_SCORES ) != 0 || forceScoreBoard );

	oldFlags = usercmd.flags;

	AdjustSpeed();

	// update the viewangles
	UpdateViewAngles();
}

/*
==============
idPlayer::AdjustSpeed
==============
*/
void idPlayer::AdjustSpeed( void ) {
	float speed;

	if ( spectating ) {
		speed = pm_spectatespeed.GetFloat();
		bobFrac = 0.0f;
	} else if ( noclip ) {
		speed = pm_noclipspeed.GetFloat();
		bobFrac = 0.0f;
 	} else if ( !physicsObj.OnLadder() && ( usercmd.buttons & BUTTON_RUN ) && ( usercmd.forwardmove || usercmd.rightmove ) && ( usercmd.upmove >= 0 ) ) {
		bobFrac = 1.0f;
		speed = runSpeed;
	} else {
		speed = walkSpeed;
		bobFrac = 0.0f;
	}

	speed *= speedMultiplier;

	speed *= tranqSpeed;

	float speedhack = 1.15f;

	if ( weapon ) {
		int maxSpeed = weapon->GetSpeedLimit();

		if ( speed > maxSpeed )
		{
			speed = maxSpeed;
			speedhack = 1.0f;
		}
		if ( crouchSpeed > maxSpeed )
		{
			crouchSpeed = maxSpeed;
			speedhack = 1.0f;
		}
	}

	physicsObj.SetSpeed( speed * speedhack, crouchSpeed * speedhack );
}

/*
==============
idPlayer::AdjustBodyAngles
==============
*/
void idPlayer::AdjustBodyAngles( void ) {
	idMat3		lookAxis;
	idMat3		legsAxis;
	bool		blend;
	float		diff;
	float		frac;
	float		upBlend;
	float		forwardBlend;
	float		downBlend;

	if ( health < 0 ) {
		return;
	}

	blend = true;

	if ( !physicsObj.HasGroundContacts() ) {
		idealLegsYaw = 0.0f;
		legsForward = true;
	} else if ( usercmd.forwardmove < 0 ) {
		idealLegsYaw = idMath::AngleNormalize180( idVec3( -usercmd.forwardmove, usercmd.rightmove, 0.0f ).ToYaw() );
		legsForward = false;
	} else if ( usercmd.forwardmove > 0 ) {
		idealLegsYaw = idMath::AngleNormalize180( idVec3( usercmd.forwardmove, -usercmd.rightmove, 0.0f ).ToYaw() );
		legsForward = true;
	} else if ( ( usercmd.rightmove != 0 ) && physicsObj.IsCrouching() ) {
		if ( !legsForward ) {
			idealLegsYaw = idMath::AngleNormalize180( idVec3( idMath::Abs( usercmd.rightmove ), usercmd.rightmove, 0.0f ).ToYaw() );
		} else {
			idealLegsYaw = idMath::AngleNormalize180( idVec3( idMath::Abs( usercmd.rightmove ), -usercmd.rightmove, 0.0f ).ToYaw() );
		}
	} else if ( usercmd.rightmove != 0 ) {
		idealLegsYaw = 0.0f;
		legsForward = true;
	} else {
		legsForward = true;
		diff = idMath::Fabs( idealLegsYaw - legsYaw );
		idealLegsYaw = idealLegsYaw - idMath::AngleNormalize180( viewAngles.yaw - oldViewYaw );
		if ( diff < 0.1f ) {
			legsYaw = idealLegsYaw;
			blend = false;
		}
	}

	if ( !physicsObj.IsCrouching() ) {
		legsForward = true;
	}

	oldViewYaw = viewAngles.yaw;

	pfl.turnLeft = false;
	pfl.turnRight = false;
	if ( idealLegsYaw < -45.0f ) {
		idealLegsYaw = 0;
		pfl.turnRight = true;
		blend = true;
	} else if ( idealLegsYaw > 45.0f ) {
		idealLegsYaw = 0;
		pfl.turnLeft = true;
		blend = true;
	}

	if ( blend ) {
		legsYaw = legsYaw * 0.9f + idealLegsYaw * 0.1f;
	}
	legsAxis = idAngles( 0.0f, legsYaw, 0.0f ).ToMat3();
	animator.SetJointAxis( hipJoint, JOINTMOD_WORLD, legsAxis );

	// calculate the blending between down, straight, and up
	frac = viewAngles.pitch / 90.0f;
	if ( frac > 0.0f ) {
		downBlend		= frac;
		forwardBlend	= 1.0f - frac;
		upBlend			= 0.0f;
	} else {
		downBlend		= 0.0f;
		forwardBlend	= 1.0f + frac;
		upBlend			= -frac;
	}

    animator.CurrentAnim( ANIMCHANNEL_TORSO )->SetSyncedAnimWeight( 0, downBlend );
	animator.CurrentAnim( ANIMCHANNEL_TORSO )->SetSyncedAnimWeight( 1, forwardBlend );
	animator.CurrentAnim( ANIMCHANNEL_TORSO )->SetSyncedAnimWeight( 2, upBlend );

	animator.CurrentAnim( ANIMCHANNEL_LEGS )->SetSyncedAnimWeight( 0, downBlend );
	animator.CurrentAnim( ANIMCHANNEL_LEGS )->SetSyncedAnimWeight( 1, forwardBlend );
	animator.CurrentAnim( ANIMCHANNEL_LEGS )->SetSyncedAnimWeight( 2, upBlend );
}

/*
==============
idPlayer::Move
==============
*/
void idPlayer::Move( void ) {
	float newEyeOffset;
	idVec3 oldOrigin;
	idVec3 oldVelocity;
	idVec3 pushVelocity;


	// save old origin and velocity for crashlanding
	oldOrigin = physicsObj.GetOrigin();
	oldVelocity = physicsObj.GetLinearVelocity();
	pushVelocity = physicsObj.GetPushedLinearVelocity();

	// set physics variables
	physicsObj.SetMaxStepHeight( pm_stepsize.GetFloat() );
	physicsObj.SetMaxJumpHeight( pm_jumpheight.GetFloat() );


	if ( noclip ) {
		physicsObj.SetContents( 0 );
		physicsObj.SetMovementType( PM_NOCLIP );
	} else if ( spectating ) {
		physicsObj.SetContents( 0 );
		physicsObj.SetMovementType( PM_SPECTATOR );
	} else if ( health <= 0 ) {
		physicsObj.SetContents( CONTENTS_CORPSE | CONTENTS_MONSTERCLIP );
		physicsObj.SetMovementType( PM_DEAD );
 	} else if ( gameLocal.inCinematic || pfl.objectiveFailed || gameLocal.GetCamera() || privateCameraView ) {
		physicsObj.SetContents( CONTENTS_BODY | (use_combat_bbox?CONTENTS_SOLID:0) );
		physicsObj.SetMovementType( PM_FREEZE );
	} else {
		physicsObj.SetContents( CONTENTS_BODY | (use_combat_bbox?CONTENTS_SOLID:0) );
		physicsObj.SetMovementType( PM_NORMAL );
	}

	if ( spectating ) {
		physicsObj.SetClipMask( MASK_DEADSOLID );
	} else if ( health <= 0 ) {
		physicsObj.SetClipMask( MASK_DEADSOLID );
	} else {
		physicsObj.SetClipMask( MASK_PLAYERSOLID );
	}

	physicsObj.SetDebugLevel( g_debugMove.GetBool() );
	physicsObj.SetPlayerInput( usercmd, viewAngles );

	// FIXME: physics gets disabled somehow
	BecomeActive( TH_PHYSICS );
	
	// If the player is dead then only run physics on new
	// frames since articulated figures are not synchronized over the network
	if ( health <= 0 ) {
		if ( gameLocal.isNewFrame ) {
			DeathPush();
			RunPhysics();
		}
	} else { 
		RunPhysics();
	}

	// hitscan prediction
	currentLoggedPosition++;
	if ( currentLoggedPosition >= NUM_LOGGED_POSITIONS )
		currentLoggedPosition = 0;

	loggedPositions[ currentLoggedPosition ].org = oldOrigin;
	loggedPositions[ currentLoggedPosition ].axis = physicsObj.GetAxis();
	loggedPositions[ currentLoggedPosition ].time = gameLocal.time;

	if ( spectating ) {
		newEyeOffset = 0.0f;
	} else if ( health <= 0 ) {
		newEyeOffset = pm_deadviewheight.GetFloat();
	} else if ( physicsObj.IsCrouching() ) {
		newEyeOffset = pm_crouchviewheight.GetFloat();
	} else {
		newEyeOffset = pm_normalviewheight.GetFloat();
	}

	if ( EyeHeight() != newEyeOffset ) {
		if ( spectating ) {
			SetEyeHeight( newEyeOffset );
		} else {
			// smooth out duck height changes
			SetEyeHeight( EyeHeight() * pm_crouchrate.GetFloat() + newEyeOffset * ( 1.0f - pm_crouchrate.GetFloat() ) );
		}
	}

	if ( noclip || gameLocal.inCinematic ) {
		pfl.crouch		= false;
 		pfl.onGround	= false;
		pfl.onLadder	= false;
		pfl.jump		= false;
	} else {
		pfl.crouch	=	physicsObj.IsCrouching();
		pfl.onGround	= physicsObj.HasGroundContacts();
		pfl.onLadder	= physicsObj.OnLadder();
		pfl.jump		= physicsObj.HasJumped() /*|| ( pfl.inWater && usercmd.upmove != 0 )*/;
	}

	if ( pfl.jump ) {
		loggedAccel_t	*acc = &loggedAccel[currentLoggedAccel&(NUM_LOGGED_ACCELS-1)];
		currentLoggedAccel++;
		acc->time = gameLocal.time;
		acc->dir[2] = 200;
		acc->dir[0] = acc->dir[1] = 0;
	}

	if ( pfl.onLadder ) {
		int old_rung = oldOrigin.z / LADDER_RUNG_DISTANCE;
 		int new_rung = physicsObj.GetOrigin().z / LADDER_RUNG_DISTANCE;

		if ( old_rung != new_rung ) {
 			StartSound( "snd_stepladder", SND_CHANNEL_ANY, 0, false, NULL );
		}
	}

	//UpdateIntentDir( );

	BobCycle( pushVelocity );


// abahr: don't crashland while no clipping.
	if( !noclip ) {
		CrashLand( oldOrigin, oldVelocity );
	}
}

/*
==============
idPlayer::UpdateHud
==============
*/
void idPlayer::UpdateHud( void ) {
	if ( !hud ) {
		return;
	}

	if ( entityNumber != gameLocal.localClientNum ) {
		return;
	}

 	if ( isLagged && gameLocal.isMultiplayer && gameLocal.localClientNum == entityNumber ) {
 		hud->SetStateString( "hudLag", "1" );
 	} else {
 		hud->SetStateString( "hudLag", "0" );
 	}
}

/*
==============
idPlayer::UpdateDeathSkin
==============
*/
void idPlayer::UpdateDeathSkin( bool state_hitch ) {
	/*if ( !( gameLocal.isMultiplayer || g_testDeath.GetBool() ) ) {
		return;
	}*/
 	if ( health <= 0 ) {
 		if ( !doingDeathSkin && !deathSkinTime ) {
			deathSkinTime = gameLocal.time + 1000;
			deathStateHitch = state_hitch;
		}

		// wait a bit before switching off the content
		if ( deathClearContentsTime && gameLocal.time > deathClearContentsTime ) {
			SetCombatContents( false );
			deathClearContentsTime = 0;
		}
	} else {
		renderEntity.noShadow = false;
		renderEntity.shaderParms[ SHADERPARM_TIME_OF_DEATH ] = 0.0f;
		if( clientHead ) {
			clientHead->GetRenderEntity()->shaderParms[ SHADERPARM_TIME_OF_DEATH ] = 0.0f;
		}
		UpdateVisuals();
 		doingDeathSkin = false;
		deathClearContentsTime = 0;
	}
}

/*
===============
idPlayer::LoadDeferredModel
===============
*/
void idPlayer::LoadDeferredModel( void ) {
	if( !modelDict ) {
		gameLocal.Warning( "idPlayer::ClientPredictionThink() - reloadModel without vaid modelDict\n" );
		return;
	} 

	SetAnimState( ANIMCHANNEL_TORSO, "Torso_Idle", 0 );
	SetAnimState( ANIMCHANNEL_LEGS, "Legs_Idle", 0 );
	UpdateState();

	if( weapon ) {
		weapon->NetCatchup();
	}

	if( !idStr::Icmp( modelDict->GetString( "skin" ), "" ) ) {
		skin = NULL;
	} else {
		skin = declManager->FindSkin( modelDict->GetString( "skin" ), false );
	}

	SetModel( modelDict->GetString( "model" ) );

	if( !idStr::Icmp( modelDict->GetString( "def_head" ), "" ) ) {
		if ( clientHead.GetEntity() ) {
			clientHead->UnlinkCombat();
			delete clientHead.GetEntity();
			clientHead = NULL;
		}
	} else {
		SetupHead( modelDict->GetString( "def_head" ), modelDict->GetVector( "head_offset" ) );
	}

	if( clientHead && health <= 0 ) {
		// update death shader for new head
		clientHead.GetEntity()->GetRenderEntity()->shaderParms[ SHADERPARM_TIME_OF_DEATH ] = renderEntity.shaderParms[ SHADERPARM_TIME_OF_DEATH ];
		clientHead.GetEntity()->GetRenderEntity()->noShadow = renderEntity.noShadow;
	}

	/*if( powerUpSkin != NULL ) {
		SetSkin( powerUpSkin );
		if( clientHead ) {
			clientHead->SetSkin( powerUpSkin );
		}
	} else {*/
		SetSkin( skin );
		if( clientHead ) {
			clientHead->SetSkin( headSkin );
		}
	//}

	AdjustAnimRates( runSpeed / 320.0f, walkSpeed / 160.0f, crouchSpeed / 160.0f );
}

/*
==============
idPlayer::Think

Called every tic for each player
==============
*/
void idPlayer::Think( void ) {
	renderEntity_t *headRenderEnt;

	if ( !gameLocal.usercmds ) {
		return;
	}

 	// Dont do any thinking if we are in modview
	if ( gameLocal.editors & EDITOR_MODVIEW || gameEdit->PlayPlayback() ) {
		// calculate the exact bobbed view position, which is used to
		// position the view weapon, among other things
		CalculateFirstPersonView();

		// this may use firstPersonView, or a thirdPerson / camera view
		CalculateRenderView();

		FreeModelDef();
		
		if ( weapon ) {
			weapon->GetWorldModel()->FreeModelDef();
		}

		if ( clientHead ) {
			clientHead->FreeEntityDef();
		}

		return;
	}

	if( reloadModel ) {
		LoadDeferredModel(); 
		reloadModel = false;
	}

	gameEdit->RecordPlayback( usercmd, this );

	// latch button actions
	oldButtons = usercmd.buttons;

	// grab out usercmd
	usercmd_t oldCmd = usercmd;
	usercmd = gameLocal.usercmds[ entityNumber ];
	buttonMask &= usercmd.buttons;
	usercmd.buttons &= ~buttonMask;

	UpdateBuildStatus();

 	// clear the ik before we do anything else so the skeleton doesn't get updated twice
 	walkIK.ClearJointMods();

	// if this is the very first frame of the map, set the delta view angles
	// based on the usercmd angles
	if ( !spawnAnglesSet && ( gameLocal.GameState() != GAMESTATE_STARTUP ) ) {
		spawnAnglesSet = true;
		SetViewAngles( spawnAngles );
		oldFlags = usercmd.flags;
	}

	if ( gameLocal.inCinematic ) {
		usercmd.forwardmove = 0;
		usercmd.rightmove = 0;
		usercmd.upmove = 0;
	}

	// log movement changes for weapon bobbing effects
	if ( usercmd.forwardmove != oldCmd.forwardmove ) {
		loggedAccel_t	*acc = &loggedAccel[currentLoggedAccel&(NUM_LOGGED_ACCELS-1)];
		currentLoggedAccel++;
		acc->time = gameLocal.time;
		acc->dir[0] = usercmd.forwardmove - oldCmd.forwardmove;
		acc->dir[1] = acc->dir[2] = 0;
	}

	if ( usercmd.rightmove != oldCmd.rightmove ) {
		loggedAccel_t	*acc = &loggedAccel[currentLoggedAccel&(NUM_LOGGED_ACCELS-1)];
		currentLoggedAccel++;
		acc->time = gameLocal.time;
		acc->dir[1] = usercmd.rightmove - oldCmd.rightmove;
		acc->dir[0] = acc->dir[2] = 0;
	}

	// freelook centering
	if ( ( usercmd.buttons ^ oldCmd.buttons ) & BUTTON_MLOOK ) {
		centerView.Init( gameLocal.time, 200, viewAngles.pitch, 0 );
	}

	// if we have an active gui, we will unrotate the view angles as
	// we turn the mouse movements into gui events
	/*idUserInterface *gui = ActiveGui();
	if ( gui && gui != focusUI ) {
		RouteGuiMouse( gui );
	}*/

	// set the push velocity on the weapon before running the physics
	if ( weapon ) {
		weapon->SetPushVelocity( physicsObj.GetPushedLinearVelocity() );
	}

	EvaluateControls();

// abahr
	if( !noclip && !spectating ) {
		UpdateGravity();
	}

	Move();

	if ( !g_stopTime.GetBool() ) {
 		if ( !noclip && !spectating && ( health > 0 ) && !IsHidden() ) {
 			TouchTriggers();
 		}

 		// update GUIs, Items, and character interactions
		UpdateFocus();
 		
 		UpdateLocation();

	 	// update player script
 		UpdateState(); 

		// service animations
		if ( !spectating && !af.IsActive() ) {
    		UpdateConditions();
			UpdateAnimState();
		}

		// clear out our pain flag so we can tell if we recieve any damage between now and the next time we think
		pfl.pain = false;
	}

	if ( !af.IsActive() ) {
		AdjustBodyAngles();
	}

	// calculate the exact bobbed view position, which is used to
	// position the view weapon, among other things
	CalculateFirstPersonView();

	// this may use firstPersonView, or a thirdPeroson / camera view
	CalculateRenderView();

	if ( spectating ) {
		UpdateSpectating();
	} else if ( health > 0 && !gameLocal.inCinematic ) {
		UpdateWeapon();
	}
	
	UpdateHud();

	UpdateDeathSkin( false );

	UpdateDeathShader( deathStateHitch );

	if( clientHead.GetEntity() ) {
		headRenderEnt = clientHead.GetEntity()->GetRenderEntity();
	} else {
		headRenderEnt = NULL;
	}
 
 	if ( headRenderEnt ) {
		headRenderEnt->customSkin = headSkin;
 		headRenderEnt->suppressSurfaceInViewID = entityNumber + 1;
 	}

	// always show your own shadow
	if( entityNumber == gameLocal.localClientNum ) {
		renderEntity.suppressLOD = 1;
		if( headRenderEnt ) {
			headRenderEnt->suppressLOD = 1;
		}
	} else {
		renderEntity.suppressLOD = 0;
		if( headRenderEnt ) {
			headRenderEnt->suppressLOD = 0;
		}
	}

	DrawShadow( headRenderEnt );

	// never cast shadows from our first-person muzzle flashes
	// FIXME: get first person flashlight into this 
	renderEntity.suppressShadowInLightID = rvWeapon::WPLIGHT_MUZZLEFLASH * 100 + entityNumber;
 	if ( headRenderEnt ) {
 		headRenderEnt->suppressShadowInLightID = rvWeapon::WPLIGHT_MUZZLEFLASH * 100 + entityNumber;
   	}

 	if ( !g_stopTime.GetBool() ) {
		UpdateAnimation();

		// 3j_opt:
		//Present();
		idEntity::Present();

		LinkCombat();
	}

 	if ( !( thinkFlags & TH_THINK ) ) {
		common->DPrintf( "player %d not thinking?\n", entityNumber );
	}

	/*if ( g_showEnemies.GetBool() ) {
		idActor *ent;
		int num = 0;
		for( ent = enemyList.Next(); ent != NULL; ent = ent->enemyNode.Next() ) {
			common->DPrintf( "enemy (%d)'%s'\n", ent->entityNumber, ent->name.c_str() );
			gameRenderWorld->DebugBounds( colorRed, ent->GetPhysics()->GetBounds().Expand( 2 ), ent->GetPhysics()->GetOrigin() );
			num++;
		}
		common->DPrintf( "%d: enemies\n", num );
	}*/

	// <q4f>

	// check grenade status
	CommonUpdates();
	CheckHeldGrenade();
	//CalcRadarPositions();

	if ( physicsObj.HasGroundContacts() ) {
		lastImpulsePlayer = NULL;
	}

	if ( !spectating && health > 0 ) {

		if ( currentPC == CLASS_MEDIC && gameLocal.time >= nextHealTime ) {

			if ( health < inventory.maxHealth ) {
				health = idMath::ClampInt( health, inventory.maxHealth, health + HEAL_SELF_AMOUNT );
			}

			nextHealTime = gameLocal.time + HEAL_SELF_DELAY;
		}

		if ( health > inventory.maxHealth && gameLocal.time >= nextHealthPulse ) {
			health = idMath::ClampInt( inventory.maxHealth, health, health - 1 );
			nextHealthPulse = gameLocal.time + HEALTH_PULSE;
			lastDamageDef = 0;
		}

		if ( inventory.armor > inventory.maxarmor && gameLocal.time >= nextArmorPulse ) {
			inventory.armor = idMath::ClampInt( inventory.maxarmor, inventory.armor, inventory.armor - 1 );
			nextArmorPulse = gameLocal.time + ARMOR_PULSE;
		}
	}

	// </q4f>

	// GTR bandit: Unlagged Code
	// store the client's position for backward reconciliation later
	if ( gameLocal.isServer && g_unlagged.GetBool() )
		StoreHistory( );
}

#define SWIM_SOUND_DELAY 500

#define BREATH_TICS 1250

void idPlayer::CheckWater() {
	if ( spectating || health <= 0 ) {
		waterTics = 0;
		return;
	}

	// check waterlevel
	float waterLevel = GetPhysics()->GetWaterLevel();

	if ( waterLevel > WATERLEVEL_FEET && ( usercmd.forwardmove || usercmd.rightmove || usercmd.upmove ) && lastSwimSoundTime + SWIM_SOUND_DELAY < gameLocal.time ) {
		lastSwimSoundTime = gameLocal.time;
		if ( waterLevel < WATERLEVEL_WAIST ) {
			StartSound( "snd_water_wade", SND_CHANNEL_BODY2, 0, false, NULL );
		}
		else {
			StartSound( "snd_water_swim", SND_CHANNEL_BODY2, 0, false, NULL );
		}
	}
	
	if ( waterLevel >= WATERLEVEL_HEAD ) {

		if ( !gameLocal.isClient && waterTics > BREATH_TICS ) {
			afflictions |= AFFL_NOAIR;
		}
		afflictions &= ~AFFL_FIRE;
		waterTics++;
	}
	else {

		if ( !gameLocal.isClient ) {
			afflictions &= ~AFFL_NOAIR;
		}

		if ( waterTics > BREATH_TICS / 2 ) {
			StartSound( "snd_water_exit_drowning", SND_CHANNEL_BODY, 0, false, NULL );
		}
		else if ( waterTics > BREATH_TICS / 4 ) {
			StartSound( "snd_water_exit_gasp", SND_CHANNEL_BODY, 0, false, NULL );
		}

		waterTics = 0;
	}

	
}

/*
=================
idPlayer::RouteGuiMouse
=================
*/
void idPlayer::RouteGuiMouse( idUserInterface *gui ) {
 	sysEvent_t ev;
 	const char *command;

	if ( usercmd.mx != oldMouseX || usercmd.my != oldMouseY ) {
 		ev = sys->GenerateMouseMoveEvent( usercmd.mx - oldMouseX, usercmd.my - oldMouseY );
 		command = gui->HandleEvent( &ev, gameLocal.time );
		oldMouseX = usercmd.mx;
		oldMouseY = usercmd.my;
	}
}

/*
==================
idPlayer::LookAtKiller
==================
*/
void idPlayer::LookAtKiller( const idVec3 &dir ) {
	
	idAngles ang = viewAngles;
	ang.yaw = dir.ToYaw();
	SetViewAngles( ang );
}

/*
==============
idPlayer::Kill
==============
*/
void idPlayer::Kill( bool delayRespawn, bool nodamage ) {

	if ( spectating ) {
		SpectateFreeFly( false );
	} else if ( health > 0 ) {
		godmode = false;
		if ( nodamage ) {
			ServerSpectate( true );
			forceRespawn = true;
		} else {
			TFDamage dmg;
			AttackerInfo att( this );
			dmg.Create( att, "damage_suicide", 1.0f );
			Damage_TF( dmg, 1.0f );
			if ( delayRespawn ) {
				forceRespawn = false;
				int delay = spawnArgs.GetFloat( "respawn_delay" );
				minRespawnTime = gameLocal.time + SEC2MS( delay );
				maxRespawnTime = minRespawnTime + MAX_RESPAWN_TIME;
 			}
 		}
	}
}

/*
=====================
idPlayer::AddDamageEffect
=====================
*/
void idPlayer::AddDamageEffect( const trace_t &collision, const idVec3 &velocity, const char *damageDefName, idEntity* inflictor ) {
	/*if( gameLocal.isMultiplayer ) {
		if( ! cvarSystem->GetCVarBool("si_teamDamage") && inflictor && inflictor->IsType( idPlayer::GetClassType() ) && gameLocal.IsTeamGame() && ((idPlayer*)inflictor)->team == team ) {
			return;
		}
	}*/
	
	idActor::AddDamageEffect ( collision, velocity, damageDefName, inflictor );
}

/*
===========
idPlayer::Teleport
============
*/
void idPlayer::Teleport( const idVec3 &origin, const idAngles &angles, idEntity *destination ) {
 	idVec3 org;
 
 	if ( weapon ) {
 		weapon->LowerWeapon();
 	}
 
	SetOrigin( origin + idVec3( 0, 0, CM_CLIP_EPSILON ) );

 	// clear the ik heights so model doesn't appear in the wrong place
 	walkIK.EnableAll();

	GetPhysics()->SetLinearVelocity( vec3_origin );
	SetViewAngles( angles );

	legsYaw = 0.0f;
	idealLegsYaw = 0.0f;
	oldViewYaw = viewAngles.yaw;

 	//if ( gameLocal.isMultiplayer ) {
 		playerView.Flash( colorWhite, 140 );
 	//}

	// don't do any smoothing with this snapshot
	predictedFrame = gameLocal.framenum;

	UpdateVisuals();

 	teleportEntity = destination;

	if ( !gameLocal.isClient && !noclip ) {
 		//if ( gameLocal.isMultiplayer ) {
 			// kill anything at the new position or mark for kill depending on immediate or delayed teleport
 			gameLocal.KillBox( this, destination != NULL );
 		/*} else {
 			// kill anything at the new position
 			gameLocal.KillBox( this, true );
 		}*/
	}

	// GTR bandit: Unlagged Code
	if ( gameLocal.isServer && g_unlagged.GetBool() )
		ResetHistory( );
}

/*
====================
idPlayer::SetPrivateCameraView
====================
*/
void idPlayer::SetPrivateCameraView( idCamera *camView ) {
	privateCameraView = camView;
	if ( camView ) {
		StopFiring();
		Hide();
	} else {
		if ( !spectating ) {
			Show();
		}
	}
}

/*
====================
idPlayer::DefaultFov

Returns the base FOV
====================
*/
float idPlayer::DefaultFov( void ) const {
	return idMath::ClampFloat( 10.0f, 175.0f, g_fov.GetFloat() );
}

/*
====================
idPlayer::CalcFov

Fixed fov at intermissions, otherwise account for fov variable and zooms.
====================
*/
float idPlayer::CalcFov() {
	float fov;

	if ( zoomFov.IsDone( gameLocal.time ) ) {
		//if ( showCalcFov ) {
			//gameLocal.Printf( "Running first player FOV calculation since g_fov has been modified.\n" );
			//gameLocal.Printf( "zoomFov says its done, its end value is '%g'\n", zoomFov.GetEndValue() );
		//}
 		fov = zoomFov.GetEndValue();
	} else {
		//if ( showCalcFov ) {
			//gameLocal.Printf( "Running first player FOV calculation since g_fov has been modified.\n" );
			//gameLocal.Printf( "zoomFov is not done, its current value is '%g'\n", zoomFov.GetCurrentValue( gameLocal.time ) );
		//}
		fov = zoomFov.GetCurrentValue( gameLocal.time );
	}
	//showCalcFov = false;

	return idMath::ClampFloat( 1.0f, 179.0f, fov );;
}

/*
==============
idPlayer::GunTurningOffset

generate a rotational offset for the gun based on the view angle
history in loggedViewAngles
==============
*/
idAngles idPlayer::GunTurningOffset( int avgCount, float offSetScale, float offsetMax ) {
	idAngles	a;

	a.Zero();

	if ( gameLocal.framenum < NUM_LOGGED_VIEW_ANGLES || avgCount <= 0 ) {
		return a;
	}

	idAngles current = loggedViewAngles[ gameLocal.framenum & (NUM_LOGGED_VIEW_ANGLES-1) ];

	idAngles	av, base;

	//weapon->GetAngleOffsets( &weaponAngleOffsetAverages, &weaponAngleOffsetScale, &weaponAngleOffsetMax );

	av = current;

	// calcualte this so the wrap arounds work properly
	for ( int j = 1 ; j < avgCount ; j++ ) {
		idAngles a2 = loggedViewAngles[ ( gameLocal.framenum - j ) & (NUM_LOGGED_VIEW_ANGLES-1) ];

		idAngles delta = a2 - current;

		if ( delta[1] > 180 ) {
			delta[1] -= 360;
		} else if ( delta[1] < -180 ) {
			delta[1] += 360;
		}

		av += delta * ( 1.0f / avgCount );
	}

	a = ( av - current ) * offSetScale;

	for ( int i = 0 ; i < 3 ; i++ ) {
		if ( a[i] < -offsetMax ) {
			a[i] = -offsetMax;
		} else if ( a[i] > offsetMax ) {
			a[i] = offsetMax;
		}
	}

	return a;
}

/*
==============
idPlayer::GunAcceleratingOffset

generate a positional offset for the gun based on the movement
history in loggedAccelerations
==============
*/
idVec3	idPlayer::GunAcceleratingOffset( void ) {
	idVec3	ofs;
	float	weaponOffsetTime;
	float	weaponOffsetScale;

	ofs.Zero();

	weapon->GetTimeOffsets( &weaponOffsetTime, &weaponOffsetScale );

	int stop = currentLoggedAccel - NUM_LOGGED_ACCELS;
	if ( stop < 0 ) {
		stop = 0;
	}
	for ( int i = currentLoggedAccel-1 ; i > stop ; i-- ) {
		loggedAccel_t	*acc = &loggedAccel[i&(NUM_LOGGED_ACCELS-1)];

		float	f;
		float	t = gameLocal.time - acc->time;
		if ( t >= weaponOffsetTime ) {
			break;	// remainder are too old to care about
		}

		f = t / weaponOffsetTime;
		f = ( idMath::Cos( f * 2.0f * idMath::PI ) - 1.0f ) * 0.5f;
		ofs += f * weaponOffsetScale * acc->dir;
	}

	return ofs;
}

/*
==============
idPlayer::CalculateViewWeaponPos

Calculate the bobbing position of the view weapon
==============
*/
void idPlayer::CalculateViewWeaponPos( idVec3 &origin, idMat3 &axis ) {
	float		scale;
	float		fracsin;
	idAngles	angles;
	int			delta;

	assert( weapon );

	// CalculateRenderView must have been called first
	const idVec3 &viewOrigin = firstPersonViewOrigin;
	const idMat3 &viewAxis = firstPersonViewAxis;

	// these cvars are just for hand tweaking before moving a value to the weapon def
	idVec3	gunpos( g_gun_x.GetFloat(), g_gun_y.GetFloat(), g_gun_z.GetFloat() );
	idVec3 viewOffset;
	weapon->GetViewModelOffset ( CalcFov(), viewOffset );
	gunpos += viewOffset;

	// as the player changes direction, the gun will take a small lag
	idVec3	gunOfs = GunAcceleratingOffset();
	origin = viewOrigin + ( gunpos + gunOfs ) * viewAxis;

	// on odd legs, invert some angles
	if ( noclip || 1 ) {
		scale = 0;
	} else if ( bobCycle & 128 ) {
		scale = -xyspeed;
	} else {
		scale = xyspeed;
	}

	// gun angles from bobbing
	angles.roll		= scale * bobfracsin * 0.005f + g_gun_roll.GetFloat();
	angles.yaw		= scale * bobfracsin * 0.01f + g_gun_yaw.GetFloat();
	angles.pitch	= xyspeed * bobfracsin * 0.005f + g_gun_pitch.GetFloat();
	
	angles += weapon->GetViewModelAngles();

	// gun angles from turning
 	//if ( gameLocal.isMultiplayer ) {
		int weaponAngleOffsetAverages;
		float weaponAngleOffsetScale, weaponAngleOffsetMax;
		weapon->GetAngleOffsets( &weaponAngleOffsetAverages, &weaponAngleOffsetScale, &weaponAngleOffsetMax );
 		idAngles offset = GunTurningOffset( weaponAngleOffsetAverages, weaponAngleOffsetScale, weaponAngleOffsetMax );
 		offset *= g_mpWeaponAngleScale.GetFloat();
 		angles += offset;
 	/*} else {
 		angles += GunTurningOffset();
 	} */

	idVec3 gravity = physicsObj.GetGravityNormal();


// abahr: when looking down, really large deflections cause back of weapons to show
	float landChangeFrac = idMath::Lerp( 0.25f, 0.05f, viewAngles.ToForward() * gravity);
// RAVEN ABAHR

	// drop the weapon when landing after a jump / fall
	delta = gameLocal.time - landTime;
	if ( delta < LAND_DEFLECT_TIME ) {

// abahr: changed to use landChangeFrac
		origin -= gravity * ( landChange*landChangeFrac * delta / LAND_DEFLECT_TIME );
	} else if ( delta < LAND_DEFLECT_TIME + LAND_RETURN_TIME ) {
		origin -= gravity * ( landChange*landChangeFrac * (LAND_DEFLECT_TIME + LAND_RETURN_TIME - delta) / LAND_RETURN_TIME );

	}

	// speed sensitive idle drift
	if ( !noclip ) {
		scale = xyspeed * 0.5f + 40.0f;
		fracsin = scale * idMath::Sin( MS2SEC( gameLocal.time ) ) * 0.01f;
		angles.roll		+= fracsin;
		angles.yaw		+= fracsin;
		angles.pitch	+= fracsin;
	}

	axis = angles.ToMat3() * viewAxis;
}

/*
===============
idPlayer::OffsetThirdPersonView
===============
*/
void idPlayer::OffsetThirdPersonView( float angle, float range, float height, bool clip ) {
	idVec3			view;
	idVec3			focusAngles;
	trace_t			trace;
	idVec3			focusPoint;
	float			focusDist;
	float			forwardScale, sideScale;
	idVec3			origin;
	idAngles		angles;
	idMat3			axis;
	idBounds		bounds;

	angles = viewAngles;
	GetViewPos( origin, axis );

	if ( angle ) {
		angles.pitch = 0.0f;
	}

	if ( angles.pitch > 45.0f ) {
		angles.pitch = 45.0f;		// don't go too far overhead
	}

	focusPoint = origin + angles.ToForward() * THIRD_PERSON_FOCUS_DISTANCE;
	focusPoint.z += height;
	view = origin;

// abahr: taking into account gravity
	view += physicsObj.GetGravityAxis()[2] * (8.0f + height);


	angles.pitch *= 0.5f;
	renderView->viewaxis = angles.ToMat3() * physicsObj.GetGravityAxis();

	idMath::SinCos( DEG2RAD( angle ), sideScale, forwardScale );
	view -= range * forwardScale * renderView->viewaxis[ 0 ];
	view += range * sideScale * renderView->viewaxis[ 1 ];

 	if ( clip ) {
 		// trace a ray from the origin to the viewpoint to make sure the view isn't
 		// in a solid block.  Use an 8 by 8 block to prevent the view from near clipping anything
 		bounds = idBounds( idVec3( -4, -4, -4 ), idVec3( 4, 4, 4 ) );


		gameLocal.clip.TraceBounds( trace, origin, view, bounds, MASK_SOLID, this );

 		if ( trace.fraction != 1.0f ) {
 			view = trace.endpos;

// abahr: taking into account gravity
 			view += physicsObj.GetGravityAxis()[2] * ( 1.0f - trace.fraction ) * 32.0f;

   
 			// try another trace to this position, because a tunnel may have the ceiling
 			// close enough that this is poking out


			gameLocal.clip.TraceBounds( trace, origin, view, bounds, MASK_SOLID, this );

 			view = trace.endpos;
 		}
   	}
   

	// select pitch to look at focus point from vieword
	focusPoint -= view;
	focusDist = idMath::Sqrt( focusPoint[0] * focusPoint[0] + focusPoint[1] * focusPoint[1] );
	if ( focusDist < 1.0f ) {
		focusDist = 1.0f;	// should never happen
	}

	angles.pitch = - RAD2DEG( idMath::ATan( focusPoint.z, focusDist ) );
	angles.yaw -= angle;

	renderView->vieworg = view;
	renderView->viewaxis = angles.ToMat3() * physicsObj.GetGravityAxis();
	renderView->viewID = 0;
}

/*
===============
idPlayer::GetEyePosition
===============
*/
idVec3 idPlayer::GetEyePosition( void ) const {
	idVec3 org;
 
	if ( WantSmoothing() ) {
		org = predictedOrigin;
	} else {
		org = GetPhysics()->GetOrigin();
	}

	return org + ( GetPhysics()->GetGravityNormal() * -eyeOffset.z );
}

/*
===============
idPlayer::GetViewPos
===============
*/
void idPlayer::GetViewPos( idVec3 &origin, idMat3 &viewAxis ) const {
	idAngles angles;

	// if dead, fix the angle and don't add any kick
	if ( health <= 0 && !spectating ) {
		angles.yaw = viewAngles.yaw;
		angles.roll = 40;
		angles.pitch = -15;
		viewAxis = angles.ToMat3();
		origin = GetEyePosition();
	} else {
  		idVec3		shakeOffset;
  		idAngles	shakeAngleOffset;
	   	idBounds	relBounds(idVec3(0, 0, 0), idVec3(0, 0, 0));

  		playerView.ShakeOffsets( shakeOffset, shakeAngleOffset, relBounds );
  		origin = GetEyePosition() + viewBob + shakeOffset;  		
		angles = viewAngles + viewBobAngles + shakeAngleOffset + playerView.AngleOffset();

		// <q4f> 

		idAngles concAngles = drunkAngles + angles;

		float minView = pm_minviewpitch.GetFloat();
		float maxView = pm_maxviewpitch.GetFloat();
		if ( concAngles.pitch < minView )
			concAngles.pitch = minView;
		else if ( concAngles.pitch > maxView )
			concAngles.pitch = maxView;

		viewAxis = concAngles.ToMat3() * physicsObj.GetGravityAxis();

		/*if ( q4f_conc.GetInteger() == 1 ) {
			weaponAxis = angles.ToMat3() * physicsObj.GetGravityAxis();
		}
		else {*/
			//weaponAxis = viewAxis;
		//}

		// </q4f>

		// adjust the origin based on the camera nodal distance (eye distance from neck)
		origin += physicsObj.GetGravityNormal() * g_viewNodalZ.GetFloat();
		origin += viewAxis[0] * g_viewNodalX.GetFloat() + viewAxis[2] * g_viewNodalZ.GetFloat();
	}
}

/*
===============
idPlayer::CalculateFirstPersonView
===============
*/
void idPlayer::CalculateFirstPersonView( void ) {
	/*if ( ( pm_modelView.GetInteger() == 1 ) || ( ( pm_modelView.GetInteger() == 2 ) && ( health <= 0 ) ) ) {
		//	Displays the view from the point of view of the "camera" joint in the player model

		idMat3 axis;
		idVec3 origin;
		idAngles ang;

		ang = viewBobAngles + playerView.AngleOffset();
		ang.yaw += viewAxis[ 0 ].ToYaw();
		
		jointHandle_t joint = animator.GetJointHandle( "camera" );
		animator.GetJointTransform( joint, gameLocal.time, origin, axis );
		firstPersonViewOrigin = ( origin + modelOffset ) * ( viewAxis * physicsObj.GetGravityAxis() ) + physicsObj.GetOrigin() + viewBob;
		firstPersonViewAxis = axis * ang.ToMat3() * physicsObj.GetGravityAxis();
	} else {*/
		// offset for local bobbing and kicks
		GetViewPos( firstPersonViewOrigin, firstPersonViewAxis );
	//}
}

/*
==================
idPlayer::GetRenderView

Returns the renderView that was calculated for this tic
==================
*/
renderView_t *idPlayer::GetRenderView( void ) {
	return renderView;
}

/*
==================
idPlayer::SmoothenRenderView

various situations where the view angles need smoothing:

demo replay:
  On a slow client with low fps multiple game frames are run in quick succession
  inbetween rendered frames. As a result the usercmds are not recorded at fixed
  time intervals but in small bursts. This routine interpolates the view angles
  based on the real time at which the usercmds were recorded to make a demo
  recorded on a slow client play back smoothly on a fast client.

spectate follow?
==================
*/
void idPlayer::SmoothenRenderView( bool firstPerson ) {
	int d1, d2;
	idAngles angles, anglesDelta, newAngles;

	if ( gameLocal.GetDemoState() == DEMO_PLAYING ) {

		d1 = usercmd.gameTime - demoViewAngleTime;
		if ( d1 < 0 ) {
			return;
		}
		d2 = usercmd.realTime - demoViewAngleTime;
		if ( d2 <= 0 ) {
			return;
		}
		if ( d1 >= d2 ) {
			return;
		}

		angles = renderView->viewaxis.ToAngles();

		anglesDelta = angles - demoViewAngles;
		anglesDelta.Normalize180();
		newAngles = demoViewAngles + ( (float) d1 / d2 ) * anglesDelta;
		renderView->viewaxis = newAngles.ToMat3();

		if ( usercmd.gameTime + gameLocal.msec > usercmd.realTime ) {
			demoViewAngleTime = usercmd.realTime;
			demoViewAngles = angles;
		}

		if ( firstPerson ) {
			// make sure the view weapon moves smoothly
			firstPersonViewAxis = renderView->viewaxis;
		}
	}
}

/*
==================
idPlayer::CalculateRenderView

create the renderView for the current tic
==================
*/
void idPlayer::CalculateRenderView( void ) {

	float range;

	if ( !renderView ) {

// mwhitlock: Dynamic memory consolidation
		RV_PUSH_HEAP_MEM_AUTO(p0,this);

		renderView = new renderView_t;
	}
	memset( renderView, 0, sizeof( *renderView ) );

	// copy global shader parms
	for( int i = 0; i < MAX_GLOBAL_SHADER_PARMS; i++ ) {
		renderView->shaderParms[ i ] = gameLocal.globalShaderParms[ i ];
	}
	renderView->globalMaterial = gameLocal.GetGlobalMaterial();
	renderView->time = gameLocal.time;

	// calculate size of 3D view
	renderView->x = 0;
	renderView->y = 0;
	renderView->width = SCREEN_WIDTH;
	renderView->height = SCREEN_HEIGHT;
	renderView->viewID = 0;

	// check if we should be drawing from a camera's POV
	if ( !noclip && (gameLocal.GetCamera() || privateCameraView) ) {
		// get origin, axis, and fov
		if ( privateCameraView ) {
			privateCameraView->GetViewParms( renderView );
		} else {
			gameLocal.GetCamera()->GetViewParms( renderView );
		}
	} else {

		// First try out any camera views that can possibly fail.
		if ( g_stopTime.GetBool() ) {
	 		renderView->vieworg = firstPersonViewOrigin;
	 		renderView->viewaxis = firstPersonViewAxis;
			SmoothenRenderView( true );

	 		if ( !pm_thirdPerson.GetBool() ) {
	 			// set the viewID to the clientNum + 1, so we can suppress the right player bodies and
	 			// allow the right player view weapons
	 			renderView->viewID = entityNumber + 1;
	 		}
		} else if ( pm_thirdPerson.GetBool() ) {
			OffsetThirdPersonView( pm_thirdPersonAngle.GetFloat(), pm_thirdPersonRange.GetFloat(), pm_thirdPersonHeight.GetFloat(), pm_thirdPersonClip.GetBool() );
			SmoothenRenderView( false );
		} else if ( pm_thirdPersonDeath.GetBool() ) {
			range = gameLocal.time < minRespawnTime ? ( gameLocal.time + RAGDOLL_DEATH_TIME - minRespawnTime ) * ( 120.0f / RAGDOLL_DEATH_TIME ) : 120.0f;
	 		OffsetThirdPersonView( 0.0f, 20.0f + range, 0.0f, false );
			SmoothenRenderView( false );
		} else {
			renderView->vieworg = firstPersonViewOrigin;
			renderView->viewaxis = firstPersonViewAxis;
			SmoothenRenderView( true );
			// set the viewID to the clientNum + 1, so we can suppress the right player bodies and
			// allow the right player view weapons
			renderView->viewID = entityNumber + 1;
			}
		
		// field of view
 		gameLocal.CalcFov( CalcFov(), renderView->fov_x, renderView->fov_y );

		if ( physicsObj.GetWaterLevel() >= WATERLEVEL_HEAD ) {
			float xpush = ( 1.0f + idMath::Sin( ( gameLocal.time + 500 ) * 0.0020f ) ) * 12.0f;
			float ypush = ( 1.0f + idMath::Sin( gameLocal.time * 0.0025f  ) ) * 10.0f;
			renderView->height += ypush;
			renderView->width += xpush;
			renderView->x -= ( xpush / 2.0f );
			renderView->y -= ( ypush / 2.0f );
		}

	}

	if ( renderView->fov_y == 0 ) {
		common->Error( "renderView->fov_y == 0" );
	}

	if ( g_showviewpos.GetBool() ) {
		gameLocal.Printf( "%s : %s\n", renderView->vieworg.ToString(), renderView->viewaxis.ToAngles().ToString() );
	}
}

/*
==================
idPlayer::Event_EnableTarget
==================
*/
void idPlayer::Event_EnableTarget ( void ) {
	fl.notarget = false;
}

/*
==================
idPlayer::Event_DisableTarget
==================
*/
void idPlayer::Event_DisableTarget ( void ) {
	fl.notarget = true;
}

/*
==================
idPlayer::Event_GetViewPos
==================
*/
void idPlayer::Event_GetViewPos( void ) {
	idVec3		viewOrigin;
	idMat3		viewAxis;

	GetViewPos(viewOrigin, viewAxis);
	idThread::ReturnVector( viewOrigin );
}

/*
==================
idPlayer::Event_FinishHearingLoss
==================
*/
void idPlayer::Event_FinishHearingLoss ( float fadeTime ) {
	if ( fadeTime <= 0.0f ) {
		StopSound ( SND_CHANNEL_DEMONIC, false );
		pfl.hearingLoss = false;
	} else {
		soundSystem->FadeSoundClasses( SOUNDWORLD_MAX, 0, 0.0f, fadeTime );
		PostEventSec ( &EV_Player_FinishHearingLoss, fadeTime, 0.0f );
	}
}


// twhitaker: added the event
/*
=============
idPlayer::Event_ApplyImpulse
=============
*/
void idPlayer::Event_ApplyImpulse ( idEntity* ent, idVec3 &point, idVec3 &impulse ) {
	GetPhysics()->ApplyImpulse( 0, point, impulse );
}

// mekberg: added sethealth
/*
=============
idPlayer::Event_SetHealth
=============
*/
void idPlayer::Event_SetHealth( float newHealth ) {
	health = idMath::ClampInt( 1 , inventory.maxHealth, newHealth );
}
/*
=============
idPlayer::Event_SetArmor
=============
*/
void idPlayer::Event_SetArmor( float newArmor ) {
	inventory.armor = idMath::ClampInt( 0 , inventory.maxarmor, newArmor );
}

/*
=============
idPlayer::Event_SetExtraProjPassEntity
=============
*/
void idPlayer::Event_SetExtraProjPassEntity( idEntity* _extraProjPassEntity ) {
	extraProjPassEntity = _extraProjPassEntity;			// 3j_todo: wtf is this for
}


/*
=============
idPlayer::SetLastHitTime
=============
*/
void idPlayer::SetLastHitTime( int time, bool armorHit ) {
 	if ( !time ) {
 		// level start and inits
 		return;
 	}

	// if updating the hud of a followed client
	idUserInterface *cursor		= idPlayer::cursor;
	bool			spectated	= false;

	if ( gameLocal.GetLocalPlayer() ) {
		idPlayer *p = gameLocal.GetLocalPlayer();
		if ( p->spectating && p->spectator == entityNumber ) {
			cursor = p->GetCursorGUI();
			spectated = true;
		}
	} else if ( gameLocal.IsServerDemo() ) {
		// server netdemo
		assert( gameLocal.GetDemoState() == DEMO_PLAYING );
		if ( gameLocal.GetDemoFollowClient() == entityNumber ) {
			cursor = gameLocal.GetDemoCursor();
			spectated = true;
		}
	}

	if ( lastHitTime != time ) {
		if ( cursor ) {
			cursor->HandleNamedEvent( "weaponHit" );
		}
		//if ( gameLocal.isMultiplayer ) {			
			// spectated so we get sounds for a client we're following
			// localClientNum check so listen server plays only for local player
			if ( spectated || gameLocal.localClientNum == entityNumber ) {
				const char* sound;

				if ( armorHit ) {
					if ( spawnArgs.GetString ( "snd_armorHit", "", &sound ) ) {
						soundSystem->PlayShaderDirectly( SOUNDWORLD_GAME, sound );
					}
				} else {
					if ( spawnArgs.GetString ( "snd_weaponHit", "", &sound ) ) {
						soundSystem->PlayShaderDirectly( SOUNDWORLD_GAME, sound );
					}
				}
			}
		
			if ( /*aimClientNum >= 0 &&*/ mphud ) {
				mphud->HandleNamedEvent( "aim_hit" );
			}

		//}
		lastHitTime = time;
		lastArmorHit = armorHit;
		lastHitToggle ^= 1;
	}
}

/*
================
idPlayer::OnLadder
================
*/
bool idPlayer::OnLadder( void ) const {
	return physicsObj.OnLadder();
}

/*
==================
idPlayer::Event_GetButtons
==================
*/
void idPlayer::Event_GetButtons( void ) {
	idThread::ReturnInt( usercmd.buttons );
}

/*
==================
idPlayer::Event_GetMove
==================
*/
void idPlayer::Event_GetMove( void ) {
	idVec3 move( usercmd.forwardmove, usercmd.rightmove, usercmd.upmove );
	idThread::ReturnVector( move );
}

/*
================
idPlayer::Event_GetViewAngles
================
*/
void idPlayer::Event_GetViewAngles( void ) {
	idThread::ReturnVector( idVec3( viewAngles[0], viewAngles[1], viewAngles[2] ) );
}

/*
================
idPlayer::Event_SetViewAngles
================
*/
void idPlayer::Event_SetViewAngles( const idVec3 & vec ) {
	idAngles ang;
	ang.Set( vec.z, vec.y, vec.x );
	SetViewAngles( ang );
}

/*
==================
idPlayer::Event_EnableWeapon 
==================
*/
void idPlayer::Event_EnableWeapon( void ) {
	Give( "weapon", spawnArgs.GetString( va( "def_weapon%d", 0 ) ) );
 	hiddenWeapon = false;
	weaponEnabled = true;
	if ( weapon ) {
// 		weapon->ExitCinematic();
	}
	ShowCrosshair();
}

/*
==================
idPlayer::Event_DisableWeapon
==================
*/
void idPlayer::Event_DisableWeapon( void ) {
 	hiddenWeapon = true;
	weaponEnabled = false;
   	if ( weapon ) {
//		weapon->EnterCinematic();
   	}
	HideCrosshair();
}

/*
==================
idPlayer::Event_GetCurrentWeapon
==================
*/
void idPlayer::Event_GetCurrentWeapon( void ) {
	if ( currentWeapon >= 0 ) {
		idThread::ReturnString( spawnArgs.GetString( va( "def_weapon%d", currentWeapon ) ) );
	} else {
		idThread::ReturnString( "" );
	}
}

/*
==================
idPlayer::Event_GetPreviousWeapon
==================
*/
void idPlayer::Event_GetPreviousWeapon( void ) {
	if ( previousWeapon >= 0 ) {
		idThread::ReturnString( spawnArgs.GetString( va( "def_weapon%d", previousWeapon) ) );
	} else {
		idThread::ReturnString( "def_weapon0" );
	}
}

/*
==================
idPlayer::Event_SelectWeapon
==================
*/
void idPlayer::Event_SelectWeapon( const char *weaponName ) {
	int i;
	int weaponNum;

	if ( gameLocal.isClient ) {
 		gameLocal.Warning( "Cannot switch weapons from script in multiplayer" );
 		return;
 	}

	weaponNum = -1;
	for( i = 0; i < MAX_WEAPONS; i++ ) {
		if ( GetWeaponDef(i) ) {
			const char *weap = spawnArgs.GetString( va( "def_weapon%d", i ) );
			if ( !idStr::Cmp( weap, weaponName ) ) {

				if ( !inventory.HasAmmo( weap ) ) {
					return;
				}
				weaponNum = i;
				break;
			}
		}
	}

	if ( weaponNum < 0 ) {
		gameLocal.Warning( "%s is not carrying weapon '%s'", name.c_str(), weaponName );
		return;
	}

	hiddenWeapon = false;
	idealWeapon = weaponNum;

 	UpdateHudWeapon();
}
/*
==================
idPlayer::Event_GetAmmoData
==================
*/
void idPlayer::Event_GetAmmoData( const char *ammoClass ) {

	idVec3	weaponAmmo;

	//ammo vector is this: current ammo count, max ammo count, and %
	weaponAmmo.x = inventory.ammo[ inventory.AmmoIndexForAmmoClass( ammoClass) ];
	weaponAmmo.y = inventory.MaxAmmoForAmmoClass( this, ammoClass );

	if( weaponAmmo.y == 0)
		weaponAmmo.z = 0;
	else
		weaponAmmo.z = (float)(weaponAmmo.x / weaponAmmo.y);

	idThread::ReturnVector( weaponAmmo);
}

/*
==================
idPlayer::Event_GetWeaponEntity
==================
*/
void idPlayer::Event_GetWeaponEntity( void ) {
	idThread::ReturnEntity( weaponViewModel );
}

#define ZOOM_TIME 150

void idPlayer::ZoomIn ( void ) {
	
	if ( zoomed ) {
		return;
	}

	float pZoomFov = g_zoomfov.GetFloat();

	float currentFov = CalcFov ();
	float t = currentFov - pZoomFov;
	t /= ( DefaultFov() - pZoomFov );
	t *= ZOOM_TIME;

	zoomFov.Init( gameLocal.time, (int)t, currentFov, pZoomFov );
			
	zoomed = true;
}

void idPlayer::ZoomOut ( void ) {
	if ( !zoomed ) {
		return;
	}

	float pZoomFov = g_zoomfov.GetFloat();

	float currentFov = CalcFov ();
	float t  = currentFov - pZoomFov;
	t /= ( DefaultFov() - pZoomFov );
	t  = ( 1.0f - t ) * ZOOM_TIME;

	zoomFov.Init( gameLocal.time, (int)t, currentFov, DefaultFov() );
	zoomed = false;
}

/*
==================
idPlayer::TeleportDeath
==================
*/
void idPlayer::TeleportDeath( int killer ) {
	teleportKiller = killer;
}

/*
==================
idPlayer::Event_ExitTeleporter
==================
*/
void idPlayer::Event_ExitTeleporter( void ) {
	idEntity	*exitEnt;
	float		pushVel;

	// verify and setup
 	exitEnt = teleportEntity;
 	if ( !exitEnt ) {
		common->DPrintf( "Event_ExitTeleporter player %d while not being teleported\n", entityNumber );
		return;
	}

	pushVel = exitEnt->spawnArgs.GetFloat( "push", "300" );

 	if ( gameLocal.isServer ) {
 		ServerSendEvent( EVENT_EXIT_TELEPORTER, NULL, false, -1 );
   	}

	SetPrivateCameraView( NULL );
	// setup origin and push according to the exit target
	SetOrigin( exitEnt->GetPhysics()->GetOrigin() + idVec3( 0, 0, CM_CLIP_EPSILON ) );
	SetViewAngles( exitEnt->GetPhysics()->GetAxis().ToAngles() );
	physicsObj.SetLinearVelocity( exitEnt->GetPhysics()->GetAxis()[ 0 ] * pushVel );
	physicsObj.ClearPushedVelocity( );
	// teleport fx
	playerView.Flash( colorWhite, 120 );

 	// clear the ik heights so model doesn't appear in the wrong place
 	walkIK.EnableAll();

	UpdateVisuals();

	gameLocal.PlayEffect ( spawnArgs, "fx_teleport", GetPhysics()->GetOrigin(), idVec3(0,0,1).ToMat3(), false, vec3_origin );

	StartSound( "snd_teleport_exit", SND_CHANNEL_ANY, 0, false, NULL );

	if ( teleportKiller != -1 ) {
		// we got killed while being teleported
		TFDamage dmg;
		AttackerInfo att( gameLocal.entities[ teleportKiller ] );
		dmg.Create( att, "damage_telefrag", 1.0f );
		Damage_TF( dmg, 1.0f );
		teleportKiller = -1;
	} else {
		// kill anything that would have waited at teleport exit
		gameLocal.KillBox( this );
	}
 	teleportEntity = NULL;
}

/*
===============
idPlayer::Event_DamageOverTimeEffect
===============
*/
void idPlayer::Event_DamageOverTimeEffect( int endTime, int interval, const char *damageDefName ) {
	const idDeclEntityDef *damageDef = gameLocal.FindEntityDef( damageDefName, false );
	if ( damageDef ) {
		rvClientCrawlEffect* effect;

		// mwhitlock: Dynamic memory consolidation
		RV_PUSH_SYS_HEAP_ID(RV_HEAP_ID_MULTIPLE_FRAME);
		effect = new rvClientCrawlEffect( gameLocal.GetEffect ( damageDef->dict, "fx_dot" ), GetWeaponViewModel(), interval );
		RV_POP_HEAP();

		effect->Play ( gameLocal.time, false );
		if ( endTime == -1 || gameLocal.GetTime() + interval <= endTime ) {
			//post it again
			PostEventMS( &EV_DamageOverTimeEffect, interval, endTime, interval, damageDefName );
		}
	}
}

/*
===============
idPlayer::LocalClientPredictionThink
===============
*/
void idPlayer::LocalClientPredictionThink( void ) {
	renderEntity_t *headRenderEnt;

	oldFlags = usercmd.flags;
	oldButtons = usercmd.buttons;

	usercmd = gameLocal.usercmds[ entityNumber ];

	buttonMask &= usercmd.buttons;
	usercmd.buttons &= ~buttonMask;

	if ( idealWeapon != currentWeapon ) {
		usercmd.buttons &= ~BUTTON_ATTACK;		
	}

	UpdateBuildStatus();

 	// clear the ik before we do anything else so the skeleton doesn't get updated twice
 	walkIK.ClearJointMods();

	if ( gameLocal.isNewFrame ) {
		if ( ( usercmd.flags & UCF_IMPULSE_SEQUENCE ) != ( oldFlags & UCF_IMPULSE_SEQUENCE ) ) {
			PerformImpulse( usercmd.impulse );
		}
	}

	if( forceScoreBoard && forceScoreBoardTime && gameLocal.time > forceScoreBoardTime ) {
		forceScoreBoardTime = 0;
		forceScoreBoard = false;
	}
	scoreBoardOpen = ( ( usercmd.buttons & BUTTON_SCORES ) != 0 || forceScoreBoard );

	AdjustSpeed();

	UpdateViewAngles();

/*

// abahr
	if( !noclip && !spectating ) {
		UpdateGravity();
	}

*/

 	if ( !isLagged ) {
 		// don't allow client to move when lagged
		predictedUpdated = false;
 		Move();

		// predict collisions with items
		if ( !noclip && !spectating && ( health > 0 ) && !IsHidden() ) {
			TouchTriggers( &TFItem::GetClassType() );
		}
 	}

	// update GUIs, Items, and character interactions
	UpdateFocus();

	// service animations
 	if ( !spectating && !af.IsActive() ) {
    	UpdateConditions();
		UpdateAnimState();
	}

	// clear out our pain flag so we can tell if we recieve any damage between now and the next time we think
	pfl.pain = false;

	if ( !af.IsActive() ) {
		AdjustBodyAngles();
	}

	// calculate the exact bobbed view position, which is used to
	// position the view weapon, among other things
	CalculateFirstPersonView();

	// this may use firstPersonView, or a thirdPerson / camera view
	CalculateRenderView();

 	if ( !gameLocal.inCinematic && weaponViewModel && ( health > 0 ) && !( /*gameLocal.isMultiplayer && */spectating ) ) {
		UpdateWeapon();
	}

	UpdateHud();

 	UpdateDeathSkin( false );

	UpdateDeathShader( deathStateHitch );
 
 	if ( clientHead.GetEntity() ) {
		headRenderEnt = clientHead.GetEntity()->GetRenderEntity();
	} else {
		headRenderEnt = NULL;
	}

 	if ( headRenderEnt ) {
		// in MP, powerup skin overrides influence 	
		headRenderEnt->customSkin = headSkin;
		headRenderEnt->suppressSurfaceInViewID = entityNumber + 1;
 	}

	// always show your own shadow
	renderEntity.suppressLOD = 1;
	if ( headRenderEnt ) {
		headRenderEnt->suppressLOD = 1;
	}

	DrawShadow( headRenderEnt );

	// never cast shadows from our first-person muzzle flashes
	// FIXME: flashlight too
	renderEntity.suppressShadowInLightID = rvWeapon::WPLIGHT_MUZZLEFLASH * 100 + entityNumber;
 	if ( headRenderEnt ) {
 		headRenderEnt->suppressShadowInLightID = renderEntity.suppressShadowInLightID;
   	}

 	if ( !gameLocal.inCinematic ) {
 		UpdateAnimation();
 	}

	// 3j_opt
	//Present();
	idEntity::Present();

 	LinkCombat();
}

/*
===============
idPlayer::NonLocalClientPredictionThink
===============
*/
#define LIMITED_PREDICTION		1

void idPlayer::NonLocalClientPredictionThink( void ) {
	renderEntity_t *headRenderEnt;

	oldFlags = usercmd.flags;
	oldButtons = usercmd.buttons;

	usercmd = gameLocal.usercmds[ entityNumber ];

	buttonMask &= usercmd.buttons;
	usercmd.buttons &= ~buttonMask;

	UpdateBuildStatus();

	//jshepard: added this to make sure clients can see other clients and the host switching weapons
	if ( idealWeapon != currentWeapon )	{
		usercmd.buttons &= ~BUTTON_ATTACK;		
	}

 	// clear the ik before we do anything else so the skeleton doesn't get updated twice
 	walkIK.ClearJointMods();

	if ( gameLocal.isNewFrame ) {
		if ( ( usercmd.flags & UCF_IMPULSE_SEQUENCE ) != ( oldFlags & UCF_IMPULSE_SEQUENCE ) ) {
			PerformImpulse( usercmd.impulse );
		}
	}

	if ( forceScoreBoard && forceScoreBoardTime && gameLocal.time > forceScoreBoardTime ) {
		forceScoreBoardTime = 0;
		forceScoreBoard = false;
	}
	scoreBoardOpen = ( ( usercmd.buttons & BUTTON_SCORES ) != 0 || forceScoreBoard );

	AdjustSpeed();

	UpdateViewAngles();

	if ( gameLocal.isLastPredictFrame && jumpDuringHitch ) {
		// only play sound if still alive
		if ( health > 0 ) {
			StartSound( "snd_jump", (s_channelType)FC_SOUND, 0, false, NULL );
		}
		jumpDuringHitch = false;
	}

	if ( !isLagged ) {
 		// don't allow client to move when lagged
		predictedUpdated = false;
		// NOTE: only running on new frames causes prediction errors even when the input does not change!
		if ( gameLocal.isNewFrame ) {
 			Move();
		} else {
			PredictionErrorDecay();
		}
 	}

#if !LIMITED_PREDICTION
	// update GUIs, Items, and character interactions
	//UpdateFocus();
#endif

	// service animations
 	if ( !spectating && !af.IsActive() ) {
    	UpdateConditions();
		UpdateAnimState();
	}

	// clear out our pain flag so we can tell if we recieve any damage between now and the next time we think
	pfl.pain = false;

	if ( !af.IsActive() ) {
		AdjustBodyAngles();
	}

	// calculate the exact bobbed view position, which is used to
	// position the view weapon, among other things
	CalculateFirstPersonView();

 	if ( !gameLocal.inCinematic && weaponViewModel && ( health > 0 ) && !( /*gameLocal.isMultiplayer && */spectating ) ) {
		UpdateWeapon();
	}

	if ( gameLocal.isLastPredictFrame ) {
		// this may use firstPersonView, or a thirdPerson / camera view
		CalculateRenderView();

		UpdateHud();
 	}

//#if !LIMITED_PREDICTION
 	UpdateDeathSkin( false );

	UpdateDeathShader( deathStateHitch );
//#endif

 	if ( clientHead.GetEntity() ) {
		headRenderEnt = clientHead.GetEntity()->GetRenderEntity();
	} else {
		headRenderEnt = NULL;
	}

	if ( headRenderEnt ) {
		// in MP, powerup skin overrides influence 	
		headRenderEnt->customSkin = headSkin;
 	}

	// always show your own shadow
	renderEntity.suppressLOD = 1;
	if ( headRenderEnt ) {
		headRenderEnt->suppressLOD = 1;
	}

	DrawShadow( headRenderEnt );

	// never cast shadows from our first-person muzzle flashes
	// FIXME: flashlight too
	renderEntity.suppressShadowInLightID = rvWeapon::WPLIGHT_MUZZLEFLASH * 100 + entityNumber;
 	if ( headRenderEnt ) {
 		headRenderEnt->suppressShadowInLightID = renderEntity.suppressShadowInLightID;
   	}

 	if ( !gameLocal.inCinematic ) {
 		UpdateAnimation();
 	}

	// 3j_opt
	//Present();
	idEntity::Present();

 	LinkCombat();
}

/*
================
idPlayer::ClientPredictionThink
================
*/
void idPlayer::ClientPredictionThink( void ) {

	if ( doInitWeapon ) {
		InitWeapon();
	}
	
	// common code for both the local & non local clients
	if( reloadModel ) {
		LoadDeferredModel(); 
		reloadModel = false;
	}
	CommonUpdates();

	if ( entityNumber == gameLocal.GetDemoFollowClient() ) {
		LocalClientPredictionThink();
		return;
	}

	if ( entityNumber == gameLocal.localClientNum ) {
		LocalClientPredictionThink();
		return;
	}

	assert( gameLocal.localClientNum >= 0 );
	idPlayer *p = gameLocal.GetClientByNum( gameLocal.localClientNum );
	if ( p && p->spectating && p->spectator == entityNumber ) {
		LocalClientPredictionThink();
		return;
	}

	NonLocalClientPredictionThink();
}

void idPlayer::CommonUpdates() {
	RunAfflictions();
	UpdateDisguise();
	CheckWater();
	CheckDispensers();
	CheckZoom();

	if ( entityNumber == gameLocal.localClientNum ) {
		gameLocal.alias.UpdateAliases( oldButtons, usercmd.buttons );
	}

	if ( g_fov.IsModified() ) {
		//gameLocal.Printf( "Detected g_fov has been modified. Clearing the modified flag.\n" );
		g_fov.ClearModified();
		//gameLocal.Printf( "g_fov modified flag cleared. G_fov current value is '%g'\n", g_fov.GetFloat() );
		zoomFov.Init( gameLocal.time, gameLocal.time, g_fov.GetFloat(), g_fov.GetFloat() );
		//gameLocal.Printf( "The zoom interpolater has been set to g_fov's value. Retrieving its current value yields '%g'\n", zoomFov.GetCurrentValue( gameLocal.time ) );
	}
}

/*
================
idPlayer::GetMasterPosition
================
*/
bool idPlayer::GetMasterPosition( idVec3 &masterOrigin, idMat3 &masterAxis ) const {
	return idActor::GetMasterPosition( masterOrigin, masterAxis );	
}

/*
===============
idPlayer::PredictionErrorDecay
===============
*/
void idPlayer::PredictionErrorDecay( void ) {
	if ( predictedUpdated ) {
		return;
	}

	if ( net_predictionErrorDecay.GetFloat() <= 0.0f ) {
		idMat3 renderAxis = viewAxis * GetPhysics()->GetAxis();
		idVec3 renderOrigin = GetPhysics()->GetOrigin() + modelOffset * renderAxis;
		predictedOrigin = renderOrigin;
		return;
	}

	if ( gameLocal.framenum >= predictedFrame ) {
		idMat3 renderAxis = viewAxis * GetPhysics()->GetAxis();
		idVec3 renderOrigin = GetPhysics()->GetOrigin() + modelOffset * renderAxis;

		if ( gameLocal.framenum == predictedFrame ) {

			predictionOriginError = predictedOrigin - renderOrigin;
			predictionAnglesError = predictedAngles - viewAngles;
			predictionAnglesError.Normalize180();
			predictionErrorTime = gameLocal.time;

			if ( net_showPredictionError.GetInteger() == entityNumber ) {
				renderSystem->DebugGraph( predictionOriginError.Length(), 0.0f, 100.0f, colorGreen );
				renderSystem->DebugGraph( predictionAnglesError.Length(), 0.0f, 180.0f, colorBlue );
			}
		}

		int t = gameLocal.time - predictionErrorTime;
		float f = ( net_predictionErrorDecay.GetFloat() - t ) / net_predictionErrorDecay.GetFloat();
		if ( f > 0.0f && f < 1.0f ) {
			predictedOrigin = renderOrigin + f * predictionOriginError;
			predictedAngles = viewAngles + f * predictionAnglesError;
			predictedAngles.Normalize180();
		} else {
			predictedOrigin = renderOrigin;
			predictedAngles = viewAngles;
		}

		predictedFrame = gameLocal.framenum;

	}

	viewAngles = predictedAngles;
	// adjust them now so they are right for the bound objects ( head and weapon )
	AdjustBodyAngles();

	predictedUpdated = true;
}

/*
===============
idPlayer::WantSmoothing
===============
*/
bool idPlayer::WantSmoothing( void ) const {
	if ( !gameLocal.isClient ) {
		return false;
	}
	if ( net_predictionErrorDecay.GetFloat() <= 0.0f || health <= 0 ) {
		return false;
	}
	// always on for self
/*
	if ( entityNumber == gameLocal.localClientNum ) {
		return false;
	}
*/
	return true;
}

/*
================
idPlayer::GetPhysicsToVisualTransform
================
*/
bool idPlayer::GetPhysicsToVisualTransform( idVec3 &origin, idMat3 &axis ) {
	if ( af.IsActive() ) {
		af.GetPhysicsToVisualTransform( origin, axis );
		return true;
	}

	PredictionErrorDecay();

	// smoothen the rendered origin and angles of other clients
	if ( gameLocal.framenum >= predictedFrame && WantSmoothing() ) {

		axis = idAngles( 0.0f, predictedAngles.yaw, 0.0f ).ToMat3();
		origin = ( predictedOrigin - GetPhysics()->GetOrigin() ) * axis.Transpose();

	} else {

		axis = viewAxis;
		origin = modelOffset;

	}

	return true;
}

/*
================
idPlayer::GetPhysicsToSoundTransform
================
*/
bool idPlayer::GetPhysicsToSoundTransform( idVec3 &origin, idMat3 &axis ) {
	idCamera *camera;

	if ( privateCameraView ) {
		camera = privateCameraView;
	} else {
		camera = gameLocal.GetCamera();
	}

	if ( camera ) {
		renderView_t view;

		memset( &view, 0, sizeof( view ) );
		camera->GetViewParms( &view );
		origin = view.vieworg;
		axis = view.viewaxis;
		return true;
	} else {
		return idActor::GetPhysicsToSoundTransform( origin, axis );
	}
}

/*
================
idPlayer::WriteToSnapshot
================
*/
void idPlayer::WriteToSnapshot( idBitMsgDelta &msg ) const {
	physicsObj.WriteToSnapshot( msg );
	WriteBindToSnapshot( msg );
	msg.WriteDeltaFloat( 0.0f, deltaViewAngles[0] );
	msg.WriteDeltaFloat( 0.0f, deltaViewAngles[1] );
	msg.WriteDeltaFloat( 0.0f, deltaViewAngles[2] );
	msg.WriteBits( health, ASYNC_PLAYER_INV_HEALTH_BITS );
 	msg.WriteBits( lastDamageDef, gameLocal.entityDefBits );
	msg.WriteDir( lastDamageDir, 9 );
	msg.WriteShort( lastDamageLocation );
	msg.WriteBits( idealWeapon, ASYNC_PLAYER_INV_WEAPON_BITS );
	msg.WriteBits( weaponViewModel.GetSpawnId(), 32 );
	msg.WriteBits( weaponWorldModel.GetSpawnId(), 32 );
	//msg.WriteBits( head.GetSpawnId(), 32 );
	msg.WriteBits( spectator, ASYNC_MAX_CLIENT_BITS );
	msg.WriteBits( lastHitToggle, 1 );
	msg.WriteBits( lastArmorHit, 1 );
 	msg.WriteBits( weaponGone, 1 );
 	msg.WriteBits( isLagged, 1 );
 	msg.WriteBits( isChatting, 1 );
	msg.WriteLong( connectTime );
	msg.WriteByte( inventory.armor );

	if ( lastKiller ) {
		msg.WriteBits( 1, 1 );
		msg.WriteBits( lastKiller->entityNumber, ASYNC_MAX_CLIENT_BITS );
	}
	else {
		msg.WriteBits( 0, 1 );
	}
 	
 	if ( weapon ) {
 		msg.WriteBits( 1, 1 );
 		weapon->WriteToSnapshot( msg );
 	} else {
 		msg.WriteBits( 0, 1 );
 	}

	// <q4f> 

	// disguising
	msg.WriteDeltaLong( 0, disguiseStart );
	msg.WriteBits( disguiseTeam, ASYNC_TEAM_BITS );
	msg.WriteBits( disguiseClass, ASYNC_CLASS_BITS );

	msg.WriteBits( isBuilding ? 1 : 0, 1 );
	msg.WriteBits( isFacingDispenser ? 1 : 0, 1 );
	msg.WriteBits( isDispensing ? 1 : 0, 1 );

	// write afflictions
	msg.WriteBits( afflictions, ASYNC_AFFL_BITS );

	msg.WriteDeltaLong( 0, tranqStartTime );
	msg.WriteDeltaFloat( 0.0f, tranqScale );

	// </q4f>

}
	

/*
================
idPlayer::ReadFromSnapshot
================
*/
void idPlayer::ReadFromSnapshot( const idBitMsgDelta &msg ) {
	int		i, oldHealth, newIdealWeapon, weaponSpawnId, weaponWorldSpawnId;
 	bool	newHitToggle, stateHitch, newHitArmor;
	int		newDisguiseStart, newDisguiseClass, newDisguiseTeam;

 	if ( snapshotSequence - lastSnapshotSequence > 1 ) {
 		stateHitch = true;
 	} else {
 		stateHitch = false;
 	}
 	lastSnapshotSequence = snapshotSequence;

	oldHealth = health;

	physicsObj.ReadFromSnapshot( msg );
	ReadBindFromSnapshot( msg );

	deltaViewAngles[0] = msg.ReadDeltaFloat( 0.0f );
	deltaViewAngles[1] = msg.ReadDeltaFloat( 0.0f );
	deltaViewAngles[2] = msg.ReadDeltaFloat( 0.0f );

	health = msg.ReadBits( ASYNC_PLAYER_INV_HEALTH_BITS );
 	lastDamageDef = msg.ReadBits( gameLocal.entityDefBits );
	lastDamageDir = msg.ReadDir( 9 );
	lastDamageLocation = msg.ReadShort();
	newIdealWeapon = msg.ReadBits( ASYNC_PLAYER_INV_WEAPON_BITS );
 	weaponSpawnId = msg.ReadBits( 32 );
 	weaponWorldSpawnId = msg.ReadBits( 32 );
	//headSpawnId = msg.ReadBits( 32 );
	int latchedSpectator = spectator;
	spectator = msg.ReadBits( ASYNC_MAX_CLIENT_BITS );
	if ( spectating && latchedSpectator != spectator && this == gameLocal.GetLocalPlayer() ) {
		// don't do any smoothing with this snapshot
		predictedFrame = gameLocal.framenum;
		// this is where the client updates their spectated player

		if ( gameLocal.entities[ spectator ] ) {
			idPlayer *p = static_cast< idPlayer * >( gameLocal.entities[ spectator ] );
			p->UpdateHudWeapon( p->currentWeapon );
		}
	}
 	newHitToggle = msg.ReadBits( 1 ) != 0;
	newHitArmor = msg.ReadBits( 1 ) != 0;
 	weaponGone = msg.ReadBits( 1 ) != 0;
 	isLagged = msg.ReadBits( 1 ) != 0;
 	isChatting = msg.ReadBits( 1 ) != 0;
	connectTime = msg.ReadLong();
	inventory.armor = msg.ReadByte();

	if ( msg.ReadBits( 1 ) ) {
		lastKiller = static_cast<idPlayer*>(gameLocal.entities[ msg.ReadBits( ASYNC_MAX_CLIENT_BITS ) ]);
	}
	else {
		lastKiller = NULL;
	}
	
	if ( idealWeapon != newIdealWeapon ) {
		if ( stateHitch ) {
			weaponCatchup = true;
		}
		idealWeapon = newIdealWeapon;
		StopFiring();
		UpdateHudWeapon();
		usercmd.buttons &= (~BUTTON_ATTACK);		
	}

	// Attach the world and view entities  
	weaponWorldModel.SetSpawnId( weaponWorldSpawnId );
	if ( weaponWorldModel.IsValid() && weaponViewModel.SetSpawnId( weaponSpawnId ) ) {
		currentWeapon = -1;
		SetWeapon( idealWeapon );
	}

	// If we have a weapon then update it from the snapshot, otherwise
	// we just skip whatever it would have read if it were there
	if ( msg.ReadBits( 1 ) ) {
		if ( weapon ) {
			weapon->ReadFromSnapshot( msg );
		} else {
			rvWeapon::SkipFromSnapshot( msg );
		}
	}

	// <q4f> 

	// disguising
	newDisguiseStart = msg.ReadDeltaLong( 0 );
	newDisguiseTeam = msg.ReadBits( ASYNC_TEAM_BITS );
	newDisguiseClass = msg.ReadBits( ASYNC_CLASS_BITS );

	// building
	isBuilding = msg.ReadBits( 1 ) == 1;
	isFacingDispenser = msg.ReadBits( 1 ) == 1;
	isDispensing = msg.ReadBits( 1 ) == 1;

	// write afflictions
	afflictions = msg.ReadBits( ASYNC_AFFL_BITS );

	tranqStartTime = msg.ReadDeltaLong( 0 );
	tranqScale = msg.ReadDeltaFloat( 0.0f );

	// </q4f>

	

 	// no msg reading below this
	
	// if not a local client assume the client has all ammo types
	if ( entityNumber != gameLocal.localClientNum ) {
		for( i = 0; i < MAX_AMMO; i++ ) {
			inventory.ammo[ i ] = 999;
		}
	}

	if ( oldHealth > 0 && health <= 0 ) {
 		if ( stateHitch ) {
 			// so we just hide and don't show a death skin
 			UpdateDeathSkin( true );
 		}

		buildPreview.Stop();
		isPreviewing = false;

		CloseMenu();

		// die
		pfl.dead = true;
		SetAnimState( ANIMCHANNEL_LEGS, "Legs_Dead", 4 );
		SetAnimState( ANIMCHANNEL_TORSO, "Torso_Dead", 4 );
		animator.ClearAllJoints();
		StartRagdoll();
		physicsObj.SetMovementType( PM_DEAD );
 		/*if ( !stateHitch ) {
 			StartSound( "snd_death", SND_CHANNEL_VOICE, 0, false, NULL );
 		}*/
		
		if ( lastDamageDef > 0 ) {
			const idDeclEntityDef* def = static_cast<const idDeclEntityDef*>(declManager->DeclByIndex ( DECL_ENTITYDEF, lastDamageDef ));
			if ( def ) {		
				// TODO: get attackers push scale?
				InitDeathPush ( lastDamageDir, lastDamageLocation, &def->dict, 1.0f );
				ClientDamageEffects ( def->dict, lastDamageDir, ( oldHealth - health ) * 4 );
			}
		}

		//gib them here
		if ( health < -20  )	{	
			ClientGib( lastDamageDir );
		}	
		else if ( !stateHitch ) {
 			StartSound( "snd_death", SND_CHANNEL_VOICE, 0, false, NULL );
 		}

		if ( weapon ) {
			weapon->OwnerDied();
			weaponZoomed = false;

			// Get rid of the weapon now
			if ( weaponRunning ) {
				gameLocal.Error( "idPlayer::ReadFromSnapShot -attempting to delete weapon while it's running" );
			}
			delete weapon;
			weapon = NULL;
			currentWeapon = -1;			
		}

		LookAtKiller( -( lastDamageDir ) );


	} else if ( oldHealth <= 0 && health > 0 ) {
 		// respawn
		common->DPrintf( "idPlayer::ReadFromSnapshot() - Player respawn detected for %d '%s' - re-enabling clip\n", entityNumber, uiName );

		// this is the first time we've seen the player since we heard he died - he may have picked up
		// some powerups since he actually spawned in, so restore those
		Init();
		StopRagdoll();
		SetPhysics( &physicsObj );
		physicsObj.EnableClip();
		SetCombatContents( true );
	} else if ( oldHealth - health > 1 && health > 0 ) {
 		if ( stateHitch ) {
			lastDmgTime = gameLocal.time;
   		} else {
 			// damage feedback
			if ( lastDamageDef > 0 ) {
 				const idDeclEntityDef *def = static_cast<const idDeclEntityDef *>( declManager->DeclByIndex( DECL_ENTITYDEF, lastDamageDef, false ) );
 				if ( def ) {
 					ClientDamageEffects ( def->dict, lastDamageDir, oldHealth - health );
 					pfl.pain = Pain( NULL, NULL, oldHealth - health, lastDamageDir, lastDamageLocation );
 					lastDmgTime = gameLocal.time;
 				} else {
 					common->Warning( "NET: no damage def for damage feedback '%d'\n", lastDamageDef );
 				}
			}
		}
	}

 	if ( lastHitToggle != newHitToggle ) {
		SetLastHitTime( gameLocal.realClientTime, newHitArmor );
	}
	
	

	if ( newDisguiseStart != disguiseStart ) {
		if ( newDisguiseStart <= 0 ) {
			ClearDisguise();
		}
		disguiseStart = newDisguiseStart;
	}

	if ( newDisguiseTeam != disguiseTeam || newDisguiseClass != disguiseClass ) {
		DisguiseChanged( disguiseTeam, disguiseClass, newDisguiseTeam, newDisguiseClass );
	}

	if ( msg.HasChanged() ) {
		UpdateVisuals();
	}
}

/*
================
idPlayer::WritePlayerStateToSnapshot
================
*/

//--------------------------------------------------------------------------
// this information is only sent to the client that owns this player
//--------------------------------------------------------------------------
void idPlayer::WritePlayerStateToSnapshot( idBitMsgDelta &msg ) const {
	int i;

	msg.WriteDeltaByte( 0, bobCycle );				// 3j_todo: do we need these?
	msg.WriteDeltaLong( 0, stepUpTime );
	msg.WriteDeltaFloat( 0.0f, stepUpDelta );

	msg.WriteDeltaLong( 0, flashStartTime );
	msg.WriteDeltaFloat( 0.0f, flashScale );

	msg.WriteDeltaLong( 0, concStartTime );
	msg.WriteDeltaFloat( 0.0f, concScale );

	msg.WriteDeltaLong( 0, hallucinateStartTime );
	msg.WriteDeltaFloat( 0.0f, hallucinateScale );

	if ( !isDispensing || !isFacingDispenser || dispFillAmount <= 0.0f )
		msg.WriteDeltaByte( 0, 0 );
	else
		msg.WriteDeltaByte( 0, idMath::ClampByte( dispFillAmount * 255 ) );

	if ( sentryGun ) {
		msg.WriteBits( 1, 1 );
		msg.WriteLong( sentryGun.GetSpawnId() );
		msg.WriteByte( sentryGun->health );
		msg.WriteByte( sentryGun->shells );
		msg.WriteBits( sentryGun->rockets, 5 );
	}
	else {
		msg.WriteBits( 0, 1 );
	}

	if ( dispenser ) {
		msg.WriteBits( 1, 1 );
		msg.WriteLong( dispenser.GetSpawnId() );
		msg.WriteByte( dispenser->health );
	}
	else {
		msg.WriteBits( 0, 1 );
	}

	if ( detpack ) {
		msg.WriteBits( 1, 1 );
		msg.WriteLong( detpack->splodeTime );
	}
	else {
		msg.WriteBits( 0, 1 );
	}

	/*if ( !gameLocal.userInfo[ entityNumber ].GetBool( "ui_showradar" ) ) {
		msg.WriteBits( 0, 1 );
	}
	else {
		msg.WriteBits( 1, 1 );

		// 3j: me no thinks we'll ever go above 32 players...
		int visibles = 0;

		for ( i = 0; i < MAX_CLIENTS; i++ ) {
			if ( radarPositions[i].visible ) {
				visibles |= ( 1 << i );
			}
		}
		msg.WriteLong( visibles );

		for ( i = 0; i < MAX_CLIENTS; i++ ) {
			if ( radarPositions[i].visible ) {
				msg.WriteByte( idMath::ClampByte( ( radarPositions[i].xRel * 127 ) + 128 ) );
				msg.WriteByte( idMath::ClampByte( ( radarPositions[i].yRel * 127 ) + 128 ) );
				msg.WriteByte( idMath::ClampByte( ( radarPositions[i].yaw / 360.0f ) * 255 ) );
			}
		}
	}*/

	// save which grenade is primed
	msg.WriteBits( heldGrenade.grenadeNum, 2 );

	for( i = 0; i < MAX_AMMO; i++ ) {
		msg.WriteBits( inventory.ammo[i], ASYNC_PLAYER_INV_AMMO_BITS );			// 3j_todo: move ammo to ALL clients?
	}

	for ( i = 0; i < MAX_WEAPONS; i++ ) {
		msg.WriteBits( inventory.clip[i], ASYNC_PLAYER_INV_CLIP_BITS );
	}
}

/*
================
idPlayer::ReadPlayerStateFromSnapshot
================
*/
void idPlayer::ReadPlayerStateFromSnapshot( const idBitMsgDelta &msg ) {
	int i, ammo;

	bobCycle = msg.ReadDeltaByte( 0 );
	stepUpTime = msg.ReadDeltaLong( 0 );
	stepUpDelta = msg.ReadDeltaFloat( 0.0f );

	flashStartTime = msg.ReadDeltaLong( 0 );
	flashScale = msg.ReadDeltaFloat( 0.0f );

	concStartTime = msg.ReadDeltaLong( 0 );
	concScale = msg.ReadDeltaFloat( 0 );

	hallucinateStartTime = msg.ReadDeltaLong( 0 );
	hallucinateScale = msg.ReadDeltaFloat( 0.0f );

	int byteAmount = msg.ReadDeltaByte( 0 );
	if ( byteAmount <= 0 ) {
		dispFillAmount = 0.0f;
	}
	else {
		dispFillAmount = (float)byteAmount / 255.0f;
	}

	if ( msg.ReadBits( 1 ) ) {
		sentryGun.SetSpawnId( msg.ReadLong() );
		sentryGun->health = msg.ReadByte();
		sentryGun->shells = msg.ReadByte();
		sentryGun->rockets = msg.ReadBits( 5 );
	}
	else {
		sentryGun = NULL;
	}

	if ( msg.ReadBits( 1 ) ) {
		dispenser.SetSpawnId( msg.ReadLong() );
		dispenser->health = msg.ReadByte();
	}
	else {
		dispenser = NULL;
	}

	if ( msg.ReadBits( 1 ) ) {
		detpack->splodeTime = msg.ReadLong();
	}

	// check if we are even receiving radar...
	/*if ( msg.ReadBits( 1 ) ) {

		// 3j: me no thinks we'll ever go above 32 players...
		int visibles = msg.ReadLong();

		for ( i = 0; i < MAX_CLIENTS; i++ ) {

			radarPositions[i].visible = false;

			if ( visibles & ( 1 << i ) ) {
				radarPositions[i].visible = true;

				radarPositions[i].xRel = (float)( msg.ReadByte() - 128 ) / 127.0f;
				radarPositions[i].yRel = (float)( msg.ReadByte() - 128 ) / 127.0f;
				radarPositions[i].yaw = (float)( msg.ReadByte() / 255.0f ) * 360.0f;
			}
		}
	}*/

	// which grenade is primed
	int newGrenade = msg.ReadBits( 2 );
	if ( newGrenade != 0 && newGrenade != heldGrenade.grenadeNum ) {
		PrimeGrenade( newGrenade );
	}
	heldGrenade.grenadeNum = newGrenade;

	for( i = 0; i < MAX_AMMO; i++ ) {
 		ammo = msg.ReadBits( ASYNC_PLAYER_INV_AMMO_BITS );
 		if ( gameLocal.time >= inventory.ammoPredictTime ) {
 			inventory.ammo[ i ] = ammo;
 		}
	}

	for ( i = 0; i < MAX_WEAPONS; i++ ) {
		ammo = msg.ReadBits( ASYNC_PLAYER_INV_CLIP_BITS );
		if ( gameLocal.time >= inventory.ammoPredictTime ) {
 			inventory.clip[ i ] = ammo;
 		}
	}
}

/*
================
idPlayer::ServerReceiveEvent
================
*/
bool idPlayer::ServerReceiveEvent( int event, int time, const idBitMsg &msg ) {

	if ( idEntity::ServerReceiveEvent( event, time, msg ) ) {
		return true;
	}

	// client->server events
	switch( event ) {
		case EVENT_IMPULSE: {
			PerformImpulse( msg.ReadBits( IMPULSE_NUMBER_OF_BITS ) );
			return true;
		}
		case EVENT_EMOTE: {
			// forward the emote on to all clients except the one that sent it to us
			ServerSendEvent( EVENT_EMOTE, &msg, false, entityNumber );

			// Set the emote locally
			SetEmote( (playerEmote_t)msg.ReadByte() );
			
			return true;
		}
		default: {
			return false;
		}
	}
}

/*
================
idPlayer::ClientReceiveEvent
================
*/
bool idPlayer::ClientReceiveEvent( int event, int time, const idBitMsg &msg ) {
	switch ( event ) {
		case EVENT_EXIT_TELEPORTER:
			Event_ExitTeleporter();
			return true;
 		case EVENT_ABORT_TELEPORTER:
 			SetPrivateCameraView( NULL );
 			return true;
 		case EVENT_SPECTATE: {
 			bool spectate = ( msg.ReadBits( 1 ) != 0 );
			int classNum = msg.ReadBits( ASYNC_CLASS_BITS );
			ChangeClass( classNum );
			gameLocal.Printf( "ClientReceiveEvent - spectate = %s\n", spectate ? "true" : "false" );
 			Spectate( spectate );

			// spectate might re-link clip for stale players, so re-call ClientStale if we're stale
			if( fl.networkStale ) {
				ClientStale();	
			}
   			return true;
 		}
 		case EVENT_ADD_DAMAGE_EFFECT: {
 			if ( spectating ) {
 				// if we're spectating, ignore
 				// happens if the event and the spectate change are written on the server during the same frame (fraglimit)
 				return true;
 			}
 			return idActor::ClientReceiveEvent( event, time, msg );
 		}
		case EVENT_EMOTE: {
			// Set the emote locally
			SetEmote( (playerEmote_t)msg.ReadByte() );

			return true;
		}
 		default: {
			return idActor::ClientReceiveEvent( event, time, msg );
		}
	}
//unreachable
//	return false;
}

/*
================
idPlayer::Hide
================
*/
void idPlayer::Hide( void ) {
	idActor::Hide();
	
	if ( weapon ) {
		weapon->HideWorldModel( );
	}
}

/*
================
idPlayer::Show
================
*/
void idPlayer::Show( void ) {
	idActor::Show();

	if ( weapon ) {
		weapon->ShowWorldModel( );
	}
}

/*
===============
idPlayer::Event_HideTip
===============
*/
void idPlayer::Event_HideTip( void ) {

}

/*
===============
idPlayer::SetSpectateOrigin
===============
*/
void idPlayer::SetSpectateOrigin( void ) {
	idVec3 neworig;

	neworig = GetPhysics()->GetOrigin();
	neworig[ 2 ] += EyeHeight();
	neworig[ 2 ] += 25;
	SetOrigin( neworig );
}

/*
===============
idPlayer::CanShowWeaponViewmodel
===============
*/
bool idPlayer::CanShowWeaponViewmodel( void ) const {
 	return showWeaponViewModel > 0;
}


/*
===============
idPlayer::Event_LevelTrigger
===============
*/
void idPlayer::Event_LevelTrigger( void ) {

}

/*
==============
idPlayer::GetWeaponDef
==============
*/
const idDeclEntityDef* idPlayer::GetWeaponDef ( int weaponIndex ) {
	//assert( weaponIndex >= 0 && weaponIndex < MAX_WEAPONS );
	if ( weaponIndex < 0 || weaponIndex >= MAX_WEAPONS )
		return NULL;

	if ( cachedWeaponDefs[weaponIndex] ) {
		return cachedWeaponDefs[weaponIndex];
	}

	idStr weapon;
	weapon = spawnArgs.GetString ( va("def_weapon%d", weaponIndex ) );
	if ( !weapon.Length() ) {
		return NULL;
	}
		
	cachedWeaponDefs[weaponIndex] = gameLocal.FindEntityDef ( weapon, false );
	if ( !cachedWeaponDefs[weaponIndex] ) {
		gameLocal.Error( "Could not find weapon definition '%s'", weapon.c_str() );
	}	
	
	return cachedWeaponDefs[weaponIndex];
}

/*
=====================
idPlayer::SetInitialHud
=====================
*/
void idPlayer::SetInitialHud ( void ) {
	if ( gameLocal.GetLocalPlayer() != this ) {
		return;
	}

	assert( hud );

	hud->SetStateInt( "ideal_weapon", 311 );
	hud->SetStateInt( "current_weapon", 311 );

	hud->SetStateInt	( "player_health", health );
	hud->SetStateFloat	( "player_health_pct", idMath::ClampFloat ( 0.0f, 1.0f, (float)health / (float)inventory.maxHealth ) );
	hud->SetStateInt	( "player_armor", inventory.armor );
	hud->SetStateFloat	( "player_armor_pct", idMath::ClampFloat ( 0.0f, 1.0f, (float)inventory.armor / (float)inventory.maxarmor ) );

	hud->SetStateInt( "team_count", tfGame.GetTeamCount() );

	if ( mphud ) {
		const char *mapImage = gameLocal.mapInfo.GetGameTypeRadarBG( gameLocal.gameType );
		if ( mapImage && mapImage[0] ) {
			mphud->SetStateString( "map_bg", mapImage );
		}
		else { 
			mphud->SetStateString( "map_bg", "" );
		}
	}

	idVec3 tColor = tfGame.GetTeamColor( team );
	hud->SetStateFloat( "disguise_color_x", tColor.x );
	hud->SetStateFloat( "disguise_color_y", tColor.y );
	hud->SetStateFloat( "disguise_color_z", tColor.z );
	hud->SetStateString( "disguise_class_name", "Spy" );

	hud->HandleNamedEvent( "InitHud" );

	// calls state changed for us
	UpdateHudTeamColor();
}

void idPlayer::UpdateHudTeamColor() {
	idVec3 teamColor = GetTeamColor();

	if ( hud ) {
		hud->SetStateFloat( "team_color_x", teamColor.x );
		hud->SetStateFloat( "team_color_y", teamColor.y );
		hud->SetStateFloat( "team_color_z", teamColor.z );

		hud->StateChanged( gameLocal.time );
	}

	if ( mphud ) {
		mphud->SetStateFloat( "team_color_x", teamColor.x );
		mphud->SetStateFloat( "team_color_y", teamColor.y );
		mphud->SetStateFloat( "team_color_z", teamColor.z );

		mphud->StateChanged( gameLocal.time );
	}

	idUserInterface* mpMenu = gameLocal.mpGame.GetMainGui();

	if ( mpMenu ) {
		mpMenu->SetStateFloat( "team_color_x", teamColor.x );
		mpMenu->SetStateFloat( "team_color_y", teamColor.y );
		mpMenu->SetStateFloat( "team_color_z", teamColor.z );

		mpMenu->StateChanged( gameLocal.time );
	}

	idUserInterface* maphud = gameLocal.mpGame.maphud;

	if ( maphud ) {
		maphud->SetStateFloat( "team_color_x", teamColor.x );
		maphud->SetStateFloat( "team_color_y", teamColor.y );
		maphud->SetStateFloat( "team_color_z", teamColor.z );

		maphud->StateChanged( gameLocal.time );
	}

	TFTeam* tfteam = tfGame.GetTeam( 0 );
	while ( tfteam ) {

		teamColor = tfGame.GetTeamColor( tfteam->GetTeamNum() );

		if ( maphud ) {
			maphud->SetStateFloat( va( "team_%d_color_x", tfteam->GetTeamNum() + 1 ), teamColor.x );
			maphud->SetStateFloat( va( "team_%d_color_y", tfteam->GetTeamNum() + 1 ), teamColor.y );
			maphud->SetStateFloat( va( "team_%d_color_z", tfteam->GetTeamNum() + 1 ), teamColor.z );
		}

		if ( hud ) {
			hud->SetStateFloat( va( "team_%d_color_x", tfteam->GetTeamNum() + 1 ), teamColor.x );
			hud->SetStateFloat( va( "team_%d_color_y", tfteam->GetTeamNum() + 1 ), teamColor.y );
			hud->SetStateFloat( va( "team_%d_color_z", tfteam->GetTeamNum() + 1 ), teamColor.z );
		}

		tfteam = tfGame.GetTeam( tfteam->GetTeamNum() + 1 );
	}
}

void idPlayer::RemoveClientModel ( const char *entityDefName ) {
	rvClientEntity* cent;
	rvClientEntity*	next;
	
	for( cent = clientEntities.Next(); cent != NULL; cent = next ) {
		next = cent->bindNode.Next();


// jnewquist: Use accessor for static class type 
		if ( cent->IsType ( rvClientModel::GetClassType() ) ) {

			if ( !idStr::Icmp ( ( static_cast<rvClientModel*> ( cent ) )->GetClassname(), entityDefName ) ) {
				cent->Unbind ( );
				delete cent;
			}
		}
	}		
}

rvClientEntityPtr<rvClientModel> idPlayer::AddClientModel ( const char* entityDefName, const char* shaderName ) {
	rvClientEntityPtr<rvClientModel> ptr;
	ptr = NULL;
	
	if ( entityDefName == NULL ) {
		return ptr;
	}
	
	const idDict* entityDef = gameLocal.FindEntityDefDict ( entityDefName, false );
	
	if ( entityDef == NULL ) {
		return ptr;
	}

	rvClientModel *newModel = NULL;

	gameLocal.SpawnClientEntityDef( *entityDef, (rvClientEntity**)(&newModel), false, "rvClientModel" );

	if( newModel == NULL ) {
		return ptr;
	}

	idMat3 rotation;
	rotation = entityDef->GetAngles( "angles" ).ToMat3();
	newModel->SetAxis( rotation );
	newModel->SetOrigin( entityDef->GetVector( "origin" ) * rotation );
	newModel->Bind ( this, animator.GetJointHandle( entityDef->GetString ( "joint" ) ) );

	newModel->SetCustomShader ( shaderName );
	newModel->GetRenderEntity()->suppressSurfaceInViewID = entityNumber + 1;
	newModel->GetRenderEntity()->noSelfShadow = true;
	newModel->GetRenderEntity()->noShadow = true;

	ptr = newModel;

	return ptr;
}

void idPlayer::RemoveClientModels ( void ) {
	rvClientEntity* cent;
	rvClientEntity*	next;
	
	for( cent = clientEntities.Next(); cent != NULL; cent = next ) {
		next = cent->bindNode.Next();


// jnewquist: Use accessor for static class type 
		if ( cent->IsType ( rvClientModel::GetClassType() ) ) {

			cent->Unbind ( );
			delete cent;
		}
	}	
}

/*
=====================
idPlayer::ClientGib()
ddynerman: Spawns client side gibs around this player
=====================
*/
void idPlayer::ClientGib( const idVec3& dir ) {

	if ( !q4f_showGibs.GetBool() ) {
		return;
	}

	// hide the player
	SetSkin( gibSkin );

	//and the head
	if( clientHead ) {
		clientHead->UnlinkCombat();
		delete clientHead;
	}

	// blow out the gibs in the given direction away from the center of the entity
	gameLocal.PlayEffect ( spawnArgs, "fx_gib", GetPhysics()->GetOrigin(), GetPhysics()->GetAxis() );

	// gibs are PVS agnostic.  If we gib a player outside of our PVS, set the oldHealth
	// to below 0 so when this player re-appears in our snap we respawn him
	if( gameLocal.isClient && gameLocal.GetLocalPlayer() && health > 0 ) { 
		health = -100;
	}
}

/*
=====================
idPlayer::CanDamage
=====================
*/
bool idPlayer::CanDamage( const idVec3 &origin, idVec3 &damagePoint, idEntity *ignoreEnt ) {
	if(/* gameLocal.isMultiplayer && */health <= 0 ) {
		return false;
	}

	return idActor::CanDamage( origin, damagePoint, ignoreEnt );
}

/*
=====================
idPlayer::ClientDamageEffects

=====================
*/
void idPlayer::ClientDamageEffects ( const idDict& damageDef, const idVec3& dir, int damage ) {
	idVec3 from;
	idVec3 localDir;
	float  fadeDB;

	// Only necessary on clients
	if ( gameLocal.isMultiplayer && !gameLocal.isClient && !gameLocal.isListenServer ) {
		return;
	}
	
	from = dir;
	from.Normalize();
	viewAxis.ProjectVector( from, localDir );
	
	// Visual effects
 	if ( damage ) {


// jnewquist: Controller rumble
		idPlayer *p = gameLocal.GetLocalPlayer();

		if ( p && ( p == this || ( p->spectating && p->spectator == entityNumber ) ) ) {
			playerView.DamageImpulse( localDir, &damageDef, damage );
		}

	}

	// Visual effects
	if ( health > 0 && damage && q4f_showDamageBlip.GetBool() ) {	
		// Let the hud know about the hit
		if ( hud ) {
			hud->SetStateFloat ( "hitdir", localDir.ToAngles()[YAW] + 180.0f );
			hud->HandleNamedEvent ( "playerHit" );
		}
 	}

	// Sound effects	
	if ( damageDef.GetFloat ( "hl_volumeDB", "-40", fadeDB ) ) {
		float fadeTime;
		
		fadeTime = 0.0f;
		if ( !pfl.hearingLoss ) {
			const char* fade;

			fadeTime = damageDef.GetFloat ( "hl_fadeOutTime", ".25" );
			soundSystem->FadeSoundClasses( SOUNDWORLD_GAME, 0, fadeDB, fadeTime );
		
			pfl.hearingLoss = true;

			// sound overlayed?		
			if ( damageDef.GetString ( "snd_hl", "", &fade ) && *fade ) {			
				StartSoundShader ( declManager->FindSound ( fade ), SND_CHANNEL_DEMONIC, 0, false, NULL );
			}
		}
		
		fadeTime += damageDef.GetFloat ( "hl_time", "1" );

		CancelEvents ( &EV_Player_FinishHearingLoss );
		PostEventSec ( &EV_Player_FinishHearingLoss, fadeTime, damageDef.GetFloat ( "hl_fadeInTime", ".25" ) );
	}

	if ( damageDef.GetBool( "burn" ) ) {
		StartSound( "snd_burn", SND_CHANNEL_BODY3, 0, false, NULL );
	}
}

/*
=====================
idPlayer::GetDebugInfo
=====================
*/
void idPlayer::GetDebugInfo ( debugInfoProc_t proc, void* userData ) {
	idActor::GetDebugInfo ( proc, userData );
	proc ( "idPlayer", "inventory.armor",		va("%d", inventory.armor ), userData );
}





/*
=====================
idPlayer::ApplyImpulse
=====================
*/
void idPlayer::ApplyImpulse( idEntity *ent, int id, const idVec3 &point, const idVec3 &impulse, bool splash ) {
	if( !ent)	{
		gameLocal.Warning( "idPlayer::ApplyImpulse called with null entity as instigator.");
		return;
	}

	lastImpulsePlayer = NULL;
	lastImpulseTime = gameLocal.time + 1000;

	if( ent->IsType( idPlayer::Type ) && ent != this ) {
		lastImpulsePlayer = static_cast<idPlayer*>(ent);

// jnewquist: Use accessor for static class type 
	} else if( ent->IsType( idProjectile::GetClassType() ) ) {

		idEntity* owner = static_cast<idProjectile*>(ent)->GetOwner();
		if( owner && owner->IsType( idPlayer::Type ) && owner != this ) {
			lastImpulsePlayer = static_cast<idPlayer*>(owner);
		}
	}

	idAFEntity_Base::ApplyImpulse( ent, id, point, impulse, splash );
}

/*
=====================
idPlayer::SetupHead
=====================
*/
void idPlayer::SetupHead( const char* headModel, idVec3 headOffset ) {

	// player's don't use idActor's real head entities - uses clientEntities instead
	if( clientHead.GetEntity() ) {
		delete clientHead.GetEntity();
		clientHead = NULL;
	}


	if( spectating ) {
		return;
	}

	const idDict* headDict = gameLocal.FindEntityDefDict( headModel, false );
	if ( !headDict ) {
		return;
	}

	rvClientAFAttachment* headEnt = clientHead.GetEntity();
	gameLocal.SpawnClientEntityDef( *headDict, (rvClientEntity**)&headEnt, false );
	if( headEnt ) {
		idStr jointName = spawnArgs.GetString( "joint_head" );
		jointHandle_t joint = animator.GetJointHandle( jointName );
		if ( joint == INVALID_JOINT ) {
			return;
		}

		headEnt->SetBody ( this, headDict->GetString ( "model" ), joint );

		headEnt->SetOrigin( vec3_origin );		
		headEnt->SetAxis( mat3_identity );		
		headEnt->Bind( this, joint, true );
		headEnt->InitCopyJoints();

		// Spawn might have parsed a skin from the spawnargs, save it for future use here
		headSkin = headEnt->GetRenderEntity()->customSkin;
		clientHead = headEnt;
	}
}

/*
=====================
idPlayer::GUIMainNotice
=====================
*/
void idPlayer::GUIMainNotice( const char* message, bool persist ) {
	if( /*!gameLocal.isMultiplayer || */!mphud ) {
		return;
	}
	
	mphud->SetStateString( "main_notice_text", message );
	mphud->SetStateBool( "main_notice_persist", persist );
	mphud->StateChanged( gameLocal.time );
	mphud->HandleNamedEvent( "main_notice" );
}

/*
=====================
idPlayer::GUIFragNotice
=====================
*/
void idPlayer::GUIFragNotice( const char* message, bool persist ) {
	if( /*!gameLocal.isMultiplayer || */!mphud ) {
		return;
	}

	mphud->SetStateString( "frag_notice_text", message );
	mphud->SetStateBool( "frag_notice_persist", persist );
	mphud->StateChanged( gameLocal.time );
	mphud->HandleNamedEvent( "frag_notice" );
}

// mekberg: wrap saveMessages
/*
=====================
idPlayer::SaveMessage
=====================
*/
void idPlayer::SaveMessage( void ) {
	if ( GetHud( ) ) {
		GetHud()->HandleNamedEvent( "saveMessage" );
	}
}

// mekberg: set pm_ cvars
/*
=====================
idPlayer::SetPMCVars
=====================
*/
void idPlayer::SetPMCVars( void ) {
	const idKeyValue	*kv;

 	if ( !gameLocal.isClient ) {
 		kv = spawnArgs.MatchPrefix( "pm_", NULL );
 		while( kv ) {
 			cvarSystem->SetCVarString( kv->GetKey(), kv->GetValue() );
 			kv = spawnArgs.MatchPrefix( "pm_", kv );
 		}
	}
}


/*
=====================
idPlayer::GetSpawnClassname
=====================
*/
const char* idPlayer::GetSpawnClassname ( void ) {
	return "q4f_pc_base";
}

/*
===============
idPlayer::SetEmote
===============
*/
void idPlayer::SetEmote( playerEmote_t newEmote ) {
	emote = newEmote;

	// if we're the ones generating the emote, pass it along
	if( gameLocal.localClientNum == entityNumber ) {
		idBitMsg	msg;
		byte		msgBuf[MAX_EVENT_PARAM_SIZE];

		assert( entityNumber == gameLocal.localClientNum );
		msg.Init( msgBuf, sizeof( msgBuf ) );
		msg.BeginWriting();
		msg.WriteByte( emote );
		if( gameLocal.isServer ) {
			ServerSendEvent( EVENT_EMOTE, &msg, false, -1 );
		} else {
			ClientSendEvent( EVENT_EMOTE, &msg );
		}
	}
}

/*
===============
idPlayer::GetGroundElevator
===============
*/
idEntity* idPlayer::GetGroundElevator( idEntity* testElevator ) const {
	idEntity* groundEnt = GetGroundEntity();
	if ( !groundEnt ) {
		return NULL;
	}
	while ( groundEnt->GetBindMaster() ) {
		groundEnt = groundEnt->GetBindMaster();
	}

	if ( !groundEnt->IsType( idElevator::GetClassType() ) ) {
		return NULL;
	}
	//NOTE: for player, don't care if all the way on, or not
	return groundEnt;
}

/*
===================
idPlayer::IsCrouching
===================
*/
bool idPlayer::IsCrouching( void ) const {
	return physicsObj.IsCrouching();
}

/*
===============
idPlayer::Event_DamageEffect
===============
*/
void idPlayer::Event_DamageEffect( const char *damageDefName, idEntity* _damageFromEnt )
{ 
	const idDeclEntityDef *damageDef = gameLocal.FindEntityDef( damageDefName, false );
	if ( damageDef )
	{
		idVec3 dir = (_damageFromEnt!=NULL)?(GetEyePosition()-_damageFromEnt->GetEyePosition()):viewAxis[2];
		dir.Normalize();
		int		damage = 1;
		ClientDamageEffects( damageDef->dict, dir, damage );
		if ( !g_testDeath.GetBool() ) {
			lastDmgTime = gameLocal.time;
		}
		lastDamageDir = dir;
  		lastDamageDir.Normalize();
		lastDamageDef = damageDef->Index();
		lastDamageLocation = 0;
	}
}

/*
===============
idPlayer::UpdateDeathShader
===============
*/
void idPlayer::UpdateDeathShader ( bool state_hitch ) {
	if ( !doingDeathSkin && gameLocal.time > deathSkinTime && deathSkinTime ) {
		deathSkinTime = 0;

		deathClearContentsTime = spawnArgs.GetInt( "deathSkinTime" );
		doingDeathSkin = true;
		if ( state_hitch ) {
			renderEntity.shaderParms[ SHADERPARM_TIME_OF_DEATH ] = gameLocal.time * 0.001f - 2.0f;

			if( clientHead ) {
				clientHead.GetEntity()->GetRenderEntity()->shaderParms[ SHADERPARM_TIME_OF_DEATH ] = gameLocal.time * 0.001f - 2.0f;
				clientHead.GetEntity()->GetRenderEntity()->noShadow = true;
			}
		} else {
			renderEntity.shaderParms[ SHADERPARM_TIME_OF_DEATH ] = gameLocal.time * 0.001f;
			if( clientHead ) {
				clientHead.GetEntity()->GetRenderEntity()->shaderParms[ SHADERPARM_TIME_OF_DEATH ] = gameLocal.time * 0.001f;
				clientHead.GetEntity()->GetRenderEntity()->noShadow = true;
			}
		}
		renderEntity.noShadow = true;
		UpdateVisuals();
	}
}

/*
===============
idPlayer::Event_InitWeapon
===============
*/
void idPlayer::InitWeapon( void ) {
	doInitWeapon = false;
	currentWeapon = -1;
	SetWeapon( idealWeapon );
}

/*
===============
idPlayer::IsReady
===============
*/
/*bool idPlayer::IsReady( void ) {
	return !gameLocal.serverInfo.GetBool( "si_useReady" ) || ready || forcedReady;
}*/

/*
===============
idPlayer::ForceScoreboard
===============
*/
void idPlayer::ForceScoreboard( bool force, int time ) {
	forceScoreBoard = force;
	forceScoreBoardTime = time;
}

/*
===============
idPlayer::ClientStale
===============
*/
bool idPlayer::ClientStale( void ) {
	idEntity::ClientStale();
	
	if( clientHead ) {
		delete clientHead;
		clientHead = NULL;
	}

	// never delete client
	return false;
}

/*
===============
idPlayer::ClientUnstale
===============
*/
void idPlayer::ClientUnstale( void ) {
	idEntity::ClientUnstale();
	
	// force render ent to position
	renderEntity.axis = physicsObj.GetAxis();
	renderEntity.origin = physicsObj.GetOrigin();

	// don't do any smoothing with this snapshot
	predictedFrame = gameLocal.framenum;
	// the powerup effects ( rvClientEntity ) will do some bindings, which in turn will call GetPosition
	// which uses the predictedOrigin .. which won't be updated till we Think() so just don't leave the predictedOrigin to the old position
	predictedOrigin = renderEntity.origin;

	UpdateModelSetup( true );

	/*if ( weapon ) {
		weapon->ClientUnstale();
	}*/
}

/*
===============
idPlayer::AllowedVoiceDest
===============
*/
bool idPlayer::AllowedVoiceDest( int from ) {

	int		i, free;

	free = -1;
	for( i = 0; i < MAX_CONCURRENT_VOICES; i++ ) {

		if ( voiceDest[i] == from ) {
			voiceDestTimes[i] = gameLocal.time;
			return true;
		}

		if ( voiceDestTimes[i] + 200 < gameLocal.time ) {
			free = i;
		}
	}

	if ( free > -1 ) {
		voiceDest[free] = from;
		voiceDestTimes[i] = gameLocal.time;
		return true;
	}

	return false;
}


// <q4f>

//==========================================================================
// Reloads def file, sets entityDefNumber, fixes teams
//==========================================================================
void idPlayer::ChangeClass( int classNum, bool broadcast ) {

	if ( currentPC == classNum )
		return;

	tfStatManager->PlayerChangeClass( this, currentPC, classNum );

	currentPC = classNum;
	nextPC = classNum;

	restrictedClass = INVALID_CLASS;

	ENTDEF entDef = NULL;

	entDef = tfGame.GetClassEntDef( classNum );
	if ( entDef == NULL ) {
		gameLocal.Error( "ChangeClassTo: Unable to find a class def for class num: %d\n", classNum );
	}

	spawnArgs.Copy( entDef->dict );

	// init our class information
	InitClassInformation();

	UpdateModelSetup( true );

	if ( entityNumber == gameLocal.localClientNum && IS_VALID_CLASS_NUM( currentPC ) && q4f_execClassConfigs.GetInteger() > 0 ) {
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, "exec config/classes/base.cfg" );
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "exec %s", tfGame.GetClassConfig( currentPC ) ) );
	}

	/*if ( !gameLocal.isClient ) {
		// remove buidables
		for ( int i = 0; i < gameLocal.builtEntities.Num(); i++ ) {
			if ( gameLocal.builtEntities[i]->GetOwner() == this ) {
				gameLocal.builtEntities[i]->PostEventMS( &EV_Remove, 0 );
			}
		}
	}*/


	// inform the clients
}

//==========================================================================
// Performs necessary stuff to change a player's team
//==========================================================================
void idPlayer::ChangeTeam( int newTeam ) {
	if ( team == newTeam )
		return;

	// drop items now to make sure scripts are checking correct team
	if ( !gameLocal.isClient ) {
		DropItems( true, TFSTATE_ACTIVE );
	}

	tfStatManager->PlayerChangeTeam( this, team, newTeam );

	team = newTeam;

	tfGame.UpdateTeamColors( false );

	iconManager->UpdateTeamIcons();

	if ( this == gameLocal.GetLocalPlayer() ) {
		
		//UpdateHudTeamColor();
		if ( !wantSpectate ) {
			// our class should be invalid when we switch teams
			ShowMenu( 2 );
		}
	}
}

//--------------------------------------------------------------------------
// Prime the specified grenade, if we can
//--------------------------------------------------------------------------
void idPlayer::PrimeGrenade( int grenadeNum ) {

	if ( health <= 0 || spectating )
		return;

	if ( gameLocal.time <= allowNextFireTime )
		return;

	if ( grenadeNum < 1 || grenadeNum > 2 ) {
		gameLocal.Warning( "PrimeGrenade: invalid grenade # %d\n", grenadeNum );
		return;
	}

	if ( grenadeNum == 1 && !grenadeDef_1 )
		return;

	if ( grenadeNum == 2 && !grenadeDef_2 )
		return;

	int ammoIndex = AMMO_GREN1_INDEX + ( grenadeNum - 1 );

	if ( !gameLocal.isClient ) {
		if ( heldGrenade.grenadeNum != 0 ) {
			if ( grenadeNum != heldGrenade.grenadeNum )
				gameLocal.mpGame.PrintMessageEvent( entityNumber, MSG_ALREADYPRIMING );
			return;
		}

		if ( inventory.ammo[ ammoIndex ] <= 0 ) {
			gameLocal.mpGame.PrintMessageEvent( entityNumber, MSG_NOGRENADES, grenadeNum );
			return;
		}
	}

	// server allows it

	// do local effects
	if ( entityNumber == gameLocal.localClientNum ) {
		// play grenade prime sound & print line   grenSoundCycle

		if ( ( grenadeNum == 1 && q4f_primeSoundPrimary.GetInteger() > 0 ) || ( grenadeNum == 2 && q4f_primeSoundSecondary.GetInteger() > 0 ) ) {
			const char* primeSound = va( "snd_grentimer%02d", grenadeNum == 1 ? q4f_primeSoundPrimary.GetInteger() - 1 : q4f_primeSoundSecondary.GetInteger() - 1 );

			if ( grenSoundCycle == 0 ) {
				StartSound( primeSound, SND_CHANNEL_DEMONIC, 0, false, NULL );
				grenSoundCycle = 1;
			}
			else if ( grenSoundCycle == 1 ) {
				StartSound( primeSound, SND_CHANNEL_HEART, 0, false, NULL );
				grenSoundCycle = 2;
			}
			else if ( grenSoundCycle == 2 ) {
				StartSound( primeSound, SND_CHANNEL_POWERUP, 0, false, NULL );
				grenSoundCycle = 0;
			}
		}

		if ( !disableHud && cursor && q4f_grenadeTimer.GetInteger() > 0 ) {
			cursor->HandleNamedEvent( "grenPrimed" );
		}

		gameLocal.mpGame.AddChatLine( "%s grenade primed for 4 seconds...", GetGrenadeName( grenadeNum ) );
	}


	if ( !gameLocal.isClient ) {
		// everything seems good to go, set up our grenade
		heldGrenade.grenadeNum = grenadeNum;

		inventory.ammo[ ammoIndex ] -= 1;

		heldGrenade.primeTime = gameLocal.time;
		heldGrenade.playerWantsThrow = false;
	}
}


//--------------------------------------------------------------------------
// Throw the currently held grenade
//--------------------------------------------------------------------------
void idPlayer::ThrowGrenade( bool heldpin, bool dropped ) {

	if ( heldGrenade.grenadeNum == 0 )
		return;

	if ( !gameLocal.isClient ) {

		// spawn the grenade
		idEntity* ent = NULL;
		ENTDEF attackDef = heldGrenade.grenadeNum == 1 ? grenadeDef_1 : grenadeDef_2;

		assert( attackDef );

		if ( !gameLocal.SpawnEntityDef( attackDef->dict, &ent ) || !ent ) {
			gameLocal.Error( "Could not spawn grenade def %d\n", heldGrenade.grenadeNum == 1 ? grenadeDef_1->GetName() : grenadeDef_2->GetName() );
		}

		// make sure it's a compatible class
		if ( !ent->IsType( HandGrenade::GetClassType() ) ) {
			gameLocal.Error( "Spawned the grenade as a '%s'. Grenade spawnclass must be a subclass of HandGrenade.", ent->GetClassname() );
		}

		HandGrenade* grenade = static_cast<HandGrenade*>(ent);

		// throw the grenade
		idVec3 org = GetCenter();

		idVec3 dir( 0.0f, 0.0f, 0.0f );
		
		if ( !dropped ) {
			dir = viewAngles.ToForward() * 500.0f;
			dir.z += 250.0f;
			dir.Normalize();
		}

		// create the grenade
		AttackerInfo att( this );

		float timeSinceFire = 0.0f;

		if ( heldpin ) {
			gameLocal.mpGame.PrintMessageEvent( -1, MSG_HOLDPIN, entityNumber );
			timeSinceFire = MS2SEC( GREN_FUSE_TIME_MS - 100 );
		}
		else {
			timeSinceFire = MS2SEC( gameLocal.time - heldGrenade.primeTime );
		}

		grenade->spawnArgs.SetFloat( "fuse", MS2SEC( GREN_FUSE_TIME_MS ) );

		grenade->Create( att, org, dir, this, this );
		grenade->Launch( org, dir, vec3_zero, timeSinceFire, 1.0f ); 

		ClearHeldGrenade();

		tfStatManager->ShotFired( att, attackDef );
	}
}


//--------------------------------------------------------------------------
// Makes it so the player isn't holding a grenade
//--------------------------------------------------------------------------
void idPlayer::ClearHeldGrenade() {
	heldGrenade.playerWantsThrow = false;
	heldGrenade.grenadeNum = 0;
	heldGrenade.primeTime = -1;
}


//--------------------------------------------------------------------------
// Check the status of this player's held grenade
//--------------------------------------------------------------------------
void idPlayer::CheckHeldGrenade() {
	assert( !gameLocal.isClient );

	if ( heldGrenade.grenadeNum > 0 ) {
		if ( gameLocal.time >= ( heldGrenade.primeTime + GREN_FUSE_TIME_MS ) ) {
			// woops, the player held the grenade too long
			ThrowGrenade( true, true );
		}
		else if ( heldGrenade.playerWantsThrow && gameLocal.time >= ( heldGrenade.primeTime + GREN_THROW_DELAY_MS ) ) {
			ThrowGrenade( false, false );
		}
	}
}


//--------------------------------------------------------------------------
// Loads the held grenade's def file
// Returns true if it could be loaded
//--------------------------------------------------------------------------
void idPlayer::LoadGrenades() {

	grenadeDef_1 = NULL;
	grenadeDef_2 = NULL;

	const char* grenDefStr = spawnArgs.GetString( "def_gren0", "" );

	if ( !grenDefStr || !grenDefStr[0] ) {
		grenadeDef_1 = NULL;
		//gameLocal.Error( "idPlayer::LoadGrenadeDefs: no def specified for grenade #1\n" );
	}
	else {
		grenadeDef_1 = gameLocal.FindEntityDef( grenDefStr, false );

		if ( grenadeDef_1 == NULL ) {
			gameLocal.Error( "Could not load grenade def %s\n", grenDefStr );
		}
	}

	grenDefStr = spawnArgs.GetString( "def_gren1", "" );

	if ( !grenDefStr || !grenDefStr[0] ) {
		grenadeDef_2 = NULL;
		//gameLocal.Error( "idPlayer::LoadGrenadeDefs: no def specified for grenade #2\n" );
	}
	else {
		grenadeDef_2 = gameLocal.FindEntityDef( grenDefStr, false );

		if ( grenadeDef_2 == NULL ) {
			gameLocal.Error( "Could not load grenade def %s\n", grenDefStr );
		}
	}
}

const float LOSS_TIME = 5.0f;
const float LOSS_FADE_BACK_TIME = 1.0f;

//--------------------------------------------------------------------------
// Called when the player gets some kind of ailment ( conc, disease, flash, etc... )
//--------------------------------------------------------------------------
void idPlayer::AddAffliction( const TFDamage &dmg ) {

	assert( !gameLocal.isClient );

	if ( health <= 0 )
		return;

	afflType_t type = dmg.GetAffliction();
	if ( type == AFFL_NONE )
		return;

	if ( type == AFFL_FIRE && ( currentPC == CLASS_PYRO || GetPhysics()->GetWaterLevel() >= WATERLEVEL_WAIST ) )
		return;

	if ( type == AFFL_INFECTION && ( dmg.GetAttacker().GetTeam() == team || currentPC == CLASS_MEDIC ) )
		return;

	float afflScale = dmg.GetDamageScale();

	if ( afflScale > 1.0f )
		afflScale = 1.0f;

	float teamScale = tfGame.ScaleTeamAffliction( this, dmg.GetAttacker().GetEntity() );

	if ( teamScale < 0.0f ) {
		if ( dmg.GetAttacker().GetPlayer() ) {
			TFDamage myDmg = dmg;
			myDmg.SetDamageScale( afflScale * -teamScale );
			dmg.GetAttacker().GetPlayer()->AddAffliction( dmg );
		}
		return;
	}

	afflScale *= teamScale * dmg.GetDamageDict()->GetFloat( "affliction_scale", "1" );

	// set up a new affl
	afflictions |= type;

	switch( type ) {
		case AFFL_FLASH:
			flashStartTime = gameLocal.time;
			flashScale = afflScale;
			flashBurned = false;
			break;

		case AFFL_CONC:
			concStartTime = gameLocal.time;
			concScale = afflScale;
			break;

		case AFFL_INFECTION:
			dmgInfection.Create( dmg.GetAttacker(), dmg.GetDamageDict()->GetString( "def_affl_damage", "" ), afflScale );
			dmgInfection.countForAccuracy = false;
			lastDmgInfection = 0;
			break;

		case AFFL_FIRE:
			dmgFire.Create( dmg.GetAttacker(), dmg.GetDamageDict()->GetString( "def_affl_damage", "" ), afflScale );
			dmgFire.countForAccuracy = false;
			lastDmgFire = 0;
			dmgFireCount = spawnArgs.GetInt( "fire_count", "6" );
			break;

		case AFFL_HALLUCINATE:
			hallucinateStartTime = gameLocal.time;
			hallucinateScale = afflScale;
			break;

		case AFFL_TRANQ:
			tranqStartTime = gameLocal.time;
			tranqScale = afflScale;
			break;

		default:
			gameLocal.Error( "dPlayer::AddAffliction unknown AFFL type %d", type );
	}
}

//--------------------------------------------------------------------------
// Clear Afflications
//--------------------------------------------------------------------------

#define ClearAfflFlash() flashStartTime = 0; flashScale = 0.0f; flashBurned = false; hearingLossEnd = 0; afflictions &= ~AFFL_FLASH
#define ClearAfflConc() concStartTime = 0; concScale = 0.0f; drunkAngles.Zero(); afflictions &= ~AFFL_CONC
#define ClearAfflTranq() tranqStartTime = 0; tranqScale = 0.0f; tranqSpeed = 1.0f; afflictions &= ~AFFL_TRANQ
#define ClearAfflGas() focusEnt = NULL; hallucinateStartTime = 0; hallucinateScale = 0.0f; afflictions &= ~AFFL_HALLUCINATE; playerView.ClearHallucinate(); if ( halluColors ) tfGame.UpdateTeamColors( true, true ); halluColors = false;

void idPlayer::ClearAfflictions( void ) {
	oldAfflictions = 0;
	afflictions = 0;

	if ( fxAfflConc != NULL ) {
		fxAfflConc->Stop( true );
		fxAfflConc = NULL;
	}
	if ( fxAfflDisease != NULL ) {
		fxAfflDisease->Stop( true );
		fxAfflDisease = NULL;
	}
	if ( fxAfflFire ) {
		fxAfflFire->Stop( true );
		fxAfflFire = NULL;
	}
	if ( fxAfflFlash ) {
		fxAfflFlash->Stop( true );
		fxAfflFlash = NULL;
	}

	ClearAfflFlash();
	ClearAfflConc();
	ClearAfflGas();
	ClearAfflTranq();
}

//--------------------------------------------------------------------------
// Handles doing the affects of our afflictions
//--------------------------------------------------------------------------
void idPlayer::RunAfflictions() {

	drunkAngles.Zero();

	playerView.ClearFlash();
	//playerView.ClearHallucinate();

	if ( oldAfflictions == 0 && afflictions == 0 )
		return;

	idPlayer* local = gameLocal.GetLocalPlayer();

	bool doGlobalEffects = ( this == local ) || ( local && local->spectating && entityNumber == local->spectator );

	// check for sound return
	if ( doGlobalEffects && hearingLossEnd > 0 && gameLocal.time > hearingLossEnd ) {
		soundSystem->FadeSoundClasses( SOUNDWORLD_GAME, 0, 0.0f, LOSS_FADE_BACK_TIME );
		hearingLossEnd = 0;
	}

	// check for view flash
	if ( afflictions & AFFL_FLASH ) {

		// do fx here
		if ( fxAfflFlash == NULL ) {
			fxAfflFlash = PlayEffect( "fx_affl_flash", headJoint, vec3_zero, mat3_identity, true );
		}

		if ( doGlobalEffects || !gameLocal.isClient ) {
			int fadeStart = flash_fade_start;
			int fadeTime = flash_fade_time;
			int flashTime = fadeStart + fadeTime;
			int offset = ( 1.0f - flashScale ) * flashTime;

			if ( gameLocal.time >= flashTime + flashStartTime - offset ) {
				ClearAfflFlash();
			}
			else if ( doGlobalEffects ) {

				int realFadeStart = fadeStart + flashStartTime - offset;

				// check for retinal burn
				if ( !( oldAfflictions & AFFL_FLASH ) ) {

					hearingLossEnd = 0;
					flashBurned = false;

					if ( gameLocal.time < realFadeStart ) {

						flashBurned = true;

						//if ( !pfl.hearingLoss ) {
							soundSystem->FadeSoundClasses( SOUNDWORLD_GAME, 0, -40.0f, 0.25f );		//SOUNDWORLD_ANY

							hearingLossEnd = gameLocal.time + SEC2MS( LOSS_TIME * flashScale );

							pfl.hearingLoss = true;

							// sound overlayed?
							const char* sound;
							if ( spawnArgs.GetString ( "snd_hl", "", &sound ) && *sound ) {			
								StartSoundShader ( declManager->FindSound ( sound, false ), SND_CHANNEL_DEMONIC, 0, false, NULL, true );
							}
						//}

						// do the retinal burn
						playerView.Retinalburn( hud );
					}
				}

				// update screen color
				idVec4 color( 1.0f, 1.0f, 1.0f, 1.0f );

				if ( gameLocal.time > realFadeStart ) {
					float p = (float)(gameLocal.time - ( realFadeStart )) / (float)fadeTime;
					p = 1.0f - p;
					p *= p;
					color[3] = p;
				}

				playerView.UpdateFlash( color );			
			}
		}
	}
	else if ( fxAfflFlash != NULL ) {
		fxAfflFlash->Stop( true );
		fxAfflFlash = NULL;
	}

	// conc
	if ( afflictions & AFFL_CONC ) {

		// do fx here
		if ( fxAfflConc == NULL ) {
			fxAfflConc = PlayEffect( "fx_affl_conc", headJoint, vec3_zero, mat3_identity, true );
		}

		if ( !gameLocal.isClient || doGlobalEffects  ) {

			int maxConcTime = conc_time;
			int concTime = concScale * maxConcTime;
			int endTime = concStartTime + concTime;

			if ( gameLocal.time >= endTime ) {
				ClearAfflConc();
			}
			else /*if (  doGlobalEffects )*/ {
				float amount = (float)( endTime - gameLocal.time ) / (float)maxConcTime;
				drunkAngles.yaw = conc_yaw * amount * idMath::Sin( gameLocal.time * spawnArgs.GetFloat( "conc_rate_yaw", ".002" ) );
				drunkAngles.pitch = conc_pitch * amount * idMath::Sin( gameLocal.time * spawnArgs.GetFloat( "conc_rate_pitch", ".001" ) );
			}
		}
	}
	else if ( fxAfflConc != NULL ) {
		fxAfflConc->Stop( true );
		fxAfflConc = NULL;
	}

	// infection
	if ( afflictions & AFFL_INFECTION ) {

		// do fx here
		if ( fxAfflDisease == NULL ) {
			fxAfflDisease = PlayEffect( "fx_affl_infection", hipJoint, vec3_zero, mat3_identity, true );
		}

		// only server does damage
		if ( !gameLocal.isClient ) {

			if ( gameLocal.time > ( lastDmgInfection + infection_delay ) ) {
				lastDmgInfection = gameLocal.time;
				Damage_TF( dmgInfection, 1.0f );
			}
		}
	}
	else if ( fxAfflDisease != NULL ) {
		fxAfflDisease->Stop( true );
		fxAfflDisease = NULL;
	}

	// fire
	if ( afflictions & AFFL_FIRE ) {

		// do fx here
		if ( fxAfflFire == NULL ) {
			fxAfflFire = PlayEffect( "fx_affl_fire", hipJoint, vec3_zero, mat3_identity, true );
		}

		if ( !gameLocal.isClient ) {
			if ( dmgFireCount <= 0 ) {
				afflictions &= ~AFFL_FIRE;
			}
			else {
				if ( gameLocal.time > ( lastDmgFire + fire_delay ) ) {
					lastDmgFire = gameLocal.time;
					Damage_TF( dmgFire, 1.0f );
					dmgFireCount--;
				}
			}
		}
	}
	else if ( fxAfflFire != NULL ) {
		fxAfflFire->Stop( true );
		fxAfflFire = NULL;
	}

	// hallucination
	if ( afflictions & AFFL_HALLUCINATE ) {

		// do fx here

		if ( !gameLocal.isClient && gameLocal.time >= hallucinateStartTime + ( hallucinate_time * hallucinateScale ) ) {
			ClearAfflGas();
		}
		else if ( doGlobalEffects ) {
			playerView.SetHallucinateScale( 1.0f - ( (float)(gameLocal.time - hallucinateStartTime) / (float)hallucinate_time ) );

			// if afflicatiion is new, randomize team colors
			if ( !( oldAfflictions & AFFL_HALLUCINATE ) ) {

				halluColors = true;

				for ( int i = 0; i < gameLocal.numClients; i++ ) {
					idPlayer* p = GET_PLAYER( i );
					if ( p ) {
						p->UpdateVisibleColor( gameLocal.random.RandomInt( tfGame.GetTeamCount() - 1 ) );
					}
				}
			}
		}
	}
	else if ( oldAfflictions & AFFL_HALLUCINATE ) {
		ClearAfflGas();
	}

	// tranquilize
	if ( afflictions & AFFL_TRANQ ) {
		int endTime = tranqStartTime + ( tranq_time * tranqScale );

		if ( gameLocal.time >= endTime ) {
			ClearAfflTranq();
		}
		else {
			float t = (float)( endTime - gameLocal.time ) / (float)tranq_time;
			tranqSpeed = ( t * tranq_speed_start ) + ( (1.0f-t) * tranq_speed_end );
		}
	}

	// no air
	if ( afflictions & AFFL_NOAIR ) {

		// only server does damage
		if ( !gameLocal.isClient ) {
			if ( gameLocal.time > ( lastDmgAir + noair_delay ) ) {
				lastDmgAir = gameLocal.time;
				Damage_TF( dmgNoAir, 1.0f );
			}
		}
	}

	oldAfflictions = afflictions;
}

int idPlayer::DamageHealsArmor( const idDict* dmgDict ) {
	if ( dmgDict ) {
		return dmgDict->GetInt( "heal_armor", "0" );
	}
	return 0;
}

int idPlayer::DamageHealsHealth( const idDict* dmgDict ) {
	if ( dmgDict ) {
		return dmgDict->GetInt( "heal_health", "0" );
	}
	return 0;
}


//--------------------------------------------------------------------------
// 
//--------------------------------------------------------------------------
void idPlayer::Damage_TF( const TFDamage &_tfDamage, float _damageScale ) {

	int			healthLoss;
 	int			armorLoss;

	// damage is only processed on server
	if ( gameLocal.isClient ) {
		return;
	}
	
 	if ( !fl.takedamage || noclip || spectating || gameLocal.inCinematic || health <= 0 ) {
		return;
	}

	const idDict* damageDef = _tfDamage.GetDamageDict();
	idEntity* attacker = _tfDamage.GetAttacker().GetEntity();

	// check if the damage actually heals instead...
	if ( attacker != this && _tfDamage.GetAttacker().GetTeam() == team ) {
		int armorHeal = DamageHealsArmor( damageDef );
		int healthHeal = DamageHealsHealth( damageDef );

		if ( armorHeal > 0 && inventory.armor < inventory.maxarmor ) {
			inventory.armor = idMath::ClampInt( -999, inventory.maxarmor, inventory.armor + armorHeal );
			StartSound( "snd_heal_armor", SND_CHANNEL_BODY3, 0, true, NULL );
		}

		if ( healthHeal > 0 ) {
			ClearAfflictions();
			if ( health < 200 ) {
				health = idMath::ClampInt( -999, 200, health + healthHeal );
				StartSound( "snd_heal_health", SND_CHANNEL_BODY3, 0, true, NULL );
			}

			nextHealthPulse = gameLocal.time + HEALTH_PULSE;
		}

		if ( armorHeal > 0 || healthHeal > 0 )
			return;
	}

	TFDamage tfDamage = _tfDamage;
	tfDamage.SetDamageScale( tfDamage.GetDamageScale() * _damageScale );

	// apply affliction if we have it
	if ( tfDamage.HasAffliction() ) {
		AddAffliction( tfDamage );
	}

	// don't do anything if there is no damage
	if ( tfDamage.GetDamage() <= 0 ) {
		tfStatManager->EntityDamaged( this, tfDamage, false );
		return;
	}

	// 3j_todo: check if railgun here to not do armor
	CalcDamagePoints_TF( tfDamage, &healthLoss, &armorLoss );

	float pushScale = tfDamage.GetDamageScale() * damageDef->GetFloat( "push", "0.0f" );

	if ( currentPC == CLASS_HWGUY )
		pushScale *= 0.25f;

	//if ( attacker == this ) {
		// Rocket Jump modifiers
		pushScale *= q4f_rj.GetFloat();
	//}

	// push!
	GetPhysics()->SetLinearVelocity( GetPhysics()->GetLinearVelocity() + ( tfDamage.GetDir() * pushScale ) );

	lastImpulsePlayer = NULL;
	lastImpulseTime = 0;

	idPlayer* attackerPlayer = tfDamage.GetAttacker().GetPlayer();

	if( attackerPlayer && attackerPlayer != this ) {
		lastImpulsePlayer = attackerPlayer;
		lastImpulseTime = gameLocal.time + 1000;
	}	

	/*if ( damageDef->GetBool( "burn" ) ) {
		StartSound( "snd_burn", SND_CHANNEL_BODY3, 0, false, NULL );
	}*/

	// give feedback on the player view and audibly when armor is helping
	// 3j_todo: mirror damage
	inventory.armor -= armorLoss;

	if ( g_debugDamage.GetInteger() ) {
		gameLocal.Printf( "client:%i health:%i damage:%i armor:%i\n", 
			entityNumber, health, healthLoss, armorLoss );
	}

	// move the world direction vector to local coordinates
	if ( damageDef != NULL ) {
		ClientDamageEffects( *damageDef, tfDamage.GetDir(), healthLoss );
	}

 	// inform the attacker that they hit someone
	if ( attacker != NULL ) {
		attacker->DamageFeedback_TF( this, tfDamage );
	}

	if ( healthLoss > 0 ) {

		nextHealthPulse = gameLocal.time + HEALTH_PULSE;

		if ( healthLoss < 1 ) {
			healthLoss = 1;
		}

		int oldHealth = health;

		health -= healthLoss;

		if ( health <= 0 ) {

			if ( health < -999 ) {
				health = -999;
			}

			if ( damageDef != NULL ) {
 				isTelefragged = damageDef->GetBool( "telefrag" );
			}
			else {
				isTelefragged = false;
			}
 
 			lastDmgTime = gameLocal.time;

			Killed_TF( tfDamage, healthLoss );

			if ( oldHealth > 0 ) {	
				InitDeathPush( tfDamage.GetDir(), tfDamage.GetLocation(), damageDef, 1.0f );
			}

		} else {
			// force a blink
			blink_time = 0;

			// let the anim script know we took damage
 			pfl.pain = Pain( NULL, attacker, healthLoss, tfDamage.GetDir( ), tfDamage.GetLocation() );
			if ( !g_testDeath.GetBool() ) {
				lastDmgTime = gameLocal.time;
			}
		}
	} else {
 		// don't accumulate impulses
		if ( af.IsLoaded() ) {
			// clear impacts
			af.Rest();

			// physics is turned off by calling af.Rest()
			BecomeActive( TH_PHYSICS );
		}
	}

	// stat manager will check if we're already dead
	tfStatManager->EntityDamaged( this, tfDamage, false );

	// 3j_todo: sort this stuff out

	lastDamageDir = tfDamage.GetDir().ToNormal();
	lastDamageDef = tfDamage.GetDamageDef()->Index();
	lastDamageLocation = tfDamage.GetLocation();
}

//--------------------------------------------------------------------------
// Calculates how much health and armor to take away for the given damage
//--------------------------------------------------------------------------
void idPlayer::CalcDamagePoints_TF( const TFDamage &tfDamage, int* healthLoss, int* armorLoss ) {
	int myArmorLoss = 0;

	int damage = GetDamageForLocation( tfDamage.GetDamage(), tfDamage.GetLocation() );

	if ( tfDamage.GetAttacker().GetEntity() == this )
		damage *= 0.75f;

	const idDict* def = tfDamage.GetDamageDict();
	
	// check for completely getting out of the damage
	if ( !def->GetBool( "noGod" ) ) {
		// check for godmode
		if ( godmode ) {
			damage = 0;
		}
	}

	// save some from armor
	if ( !def->GetBool( "ignoreArmor", "0" ) ) {
		float armor_protection;

 		armor_protection = g_armorProtectionMP.GetFloat();
		myArmorLoss = ceil( damage * armor_protection );
		if ( myArmorLoss >= inventory.armor ) {
			myArmorLoss = inventory.armor;
		}

 		if ( damage <= 0 ) {
 			myArmorLoss = 0;
 		} else if ( myArmorLoss >= damage ) {
 			myArmorLoss = damage - 1;
 			damage = 1;
 		} else {
 			damage -= myArmorLoss;
 		}
	}

	idEntity* player = tfDamage.GetAttacker().GetEntity();

	if ( player && player->IsType( idPlayer::GetClassType() ) ) {
 		tfGame.ScaleTeamDamage( this, (idPlayer*)player, &damage, &myArmorLoss );
	}

	*healthLoss = damage;
	*armorLoss = myArmorLoss;
}


//--------------------------------------------------------------------------
// Called when we damage someone
//--------------------------------------------------------------------------
void idPlayer::DamageFeedback_TF( idEntity* victim, const TFDamage &tfDamage ) {

	if( !victim || victim->health <= 0 || victim->team == team || victim == this ) {
		return;
	}

	bool armorHit = false;

	if( victim->IsType( idPlayer::GetClassType() ) ) {
		if( static_cast<idPlayer*>(victim)->inventory.armor > 0 ) {
			armorHit = true;
		}
	} 

	// 3j_todo: armor hits on dispensers
	else if ( victim->IsType( SentryGun::GetClassType() ) || victim->IsType( Dispenser::GetClassType() ) ) {
		armorHit = true;
	}

	SetLastHitTime( gameLocal.time, armorHit );
}


//--------------------------------------------------------------------------
// Called when we are killed
//--------------------------------------------------------------------------
void idPlayer::Killed_TF( const TFDamage &tfDamage, int healthLoss ) {

	float delay;

	assert( !gameLocal.isClient );

	// stop taking knockback once dead
	fl.noknockback = true;
	if ( health < -MAX_HEALTH ) {
		health = -MAX_HEALTH;
	}

	buildPreview.Stop();
	isPreviewing = false;

// rjohnson: keep this off for better performance
#if 0
	// Turn off bounding boxes when the player dies
	if ( gameLocal.isMultiplayer ) {
		use_combat_bbox = false;
	}
#endif

	if ( pfl.dead ) {
		pfl.pain = true;
		return;
	}

	deathLocation = currentLocation;

	idEntity* attacker = tfDamage.GetAttacker().GetEntity();

	pfl.dead = true;
	SetAnimState( ANIMCHANNEL_LEGS, "Legs_Dead", 4 );
	SetAnimState( ANIMCHANNEL_TORSO, "Torso_Dead", 4 );

	animator.ClearAllJoints();

	if ( StartRagdoll() ) {
		pm_modelView.SetInteger( 0 );
		minRespawnTime = gameLocal.time + RAGDOLL_DEATH_TIME;
		maxRespawnTime = minRespawnTime + MAX_RESPAWN_TIME;
	} else {
		// don't allow respawn until the death anim is done
		// g_forcerespawn may force spawning at some later time
		delay = spawnArgs.GetFloat( "respawn_delay" );
		minRespawnTime = gameLocal.time + SEC2MS( delay );
		maxRespawnTime = minRespawnTime + MAX_RESPAWN_TIME;
	}

	physicsObj.SetMovementType( PM_DEAD );

 	StopSound( SND_CHANNEL_BODY2, false );

	fl.takedamage = true;		// can still be gibbed

	// det our pipes
	DetPipe( true, true );

	// throw the grenade
	if ( heldGrenade.grenadeNum > 0 ) {
		ThrowGrenade( false, true );
	}

	if (weapon) {
		weapon->OwnerDied();		// get rid of weapon
		weaponZoomed = false;

		if ( weaponRunning ) {
			gameLocal.Error( "idPlayer::Killed_TF -attempting to delete weapon while it's running" );
		}
		delete weapon;
	}

	weapon = NULL;
	currentWeapon = -1;

	idPlayer* currentKiller = NULL;

	if ( attacker->IsType( idPlayer::Type ) ) {
		currentKiller = static_cast<idPlayer*>(attacker);

		idVec3 dir = tfDamage.GetDir();

		if ( health < -20 && tfDamage.GetDamageDict()->GetBool( "gib" ) ) {
			gibDeath = true;

			if( gameLocal.isListenServer && gameLocal.GetLocalPlayer() ) {
				ClientGib( dir );
			}
		}

// jnewquist: Use accessor for static class type 
	} else if ( attacker->IsType( idWorldspawn::GetClassType() ) ) {

		if( lastImpulseTime > gameLocal.time && lastImpulsePlayer ) {			// 3j_todo: impulses control knocking frags
			currentKiller = lastImpulsePlayer;
		}
	}

	if ( !gibDeath ) {
 		StartSound( "snd_death", SND_CHANNEL_VOICE, 0, false, NULL );
	}

	AttackerInfo att( currentKiller );
	TFDamage myDmg = tfDamage;
	myDmg.SetAttacker( att );
	damageKilledWith = myDmg;

	// 3j_todo: nodrop areas
	bool noDrop = false;
	DropItems( true, noDrop ? TFSTATE_IDLE : TFSTATE_ACTIVE );

	tfStatManager->EntityDamaged( this, myDmg, true );

	ClearDisguise();

	UpdateVisuals();
	
	ClearAfflictions();

	DropBackPack( true );

	CloseMenu();

	isChatting = false;

	LookAtKiller( - ( tfDamage.GetDir() ) );

	// GTR bandit: Unlagged Code
	if ( gameLocal.isServer && g_unlagged.GetBool() )
		ResetHistory( );
}

/*
=====================
idPlayer::CanPlayImpactEffect 
=====================
*/
bool idPlayer::CanPlayImpactEffect( idEntity* attacker, idEntity* target ) {
	return idAFEntity_Base::CanPlayImpactEffect( attacker, target );
}

/*#define ENEMY_MAX_DIST 400.0f
#define FRIENDLY_MAX_DIST 800.0f

void idPlayer::DrawPlayerNames( idUserInterface *_hud ) {

	idVec3 viewForward = viewAngles.ToForward();
	idVec3 myPos = GetEyePosition();

	idVec3 otherColor;

	idPlayer* other;
	idVec3 targetPos;
	idVec3 dir;
	idVec3 screen;
	float dist;
	float maxDist;

	modelTrace_t tr;

	int nameCount = 0;

	// 3j: you only need to loop thru clients, not all entities
	for( int i = 0; i < gameLocal.players.Num(); i++ ) {
		other = gameLocal.players[i];

		if( !other || other->health <= 0 || other->spectating || ( other->entityNumber == gameLocal.localClientNum && !pm_thirdPerson.GetBool() ) )
			continue;

		targetPos = other->GetEyePosition();

		dir = targetPos - myPos;
		
		// don't draw this player if they're behind us
		if ( dir * viewForward < 0.0f ) {
			continue;
		}
		dist = dir.Normalize();

		if( other->team != team ) {
			if( gameRenderWorld->FastWorldTrace( tr, myPos, targetPos ) ) //don't show enemy names through walls
				continue;

			maxDist = ENEMY_MAX_DIST;			
		}
		else {
			maxDist = FRIENDLY_MAX_DIST;
		}

		if ( dist > maxDist ) {
			continue;
		}

		otherColor = other->GetTeamColor( true );

		screen = gameRenderWorld->WorldToScreen( GetRenderView(), targetPos );

		idStr name;
		
		if ( IS_VALID_TEAM( other->disguiseTeam ) && other->disguiseName >= 0 ) {
			name = gameLocal.GetUserInfo( disguiseName )->GetString( "ui_name" );
		}
		else {
			name = other->GetUserInfo()->GetString( "ui_name" );
		}

		//switch( q4f_clanAppend.GetInteger() )			// 3j_todo: get rid of clan append, or fix for local?
		//{
		//	case 1:
		//		name.Insert( other->GetUserInfo()->GetString( "ui_clan" ), 0 );
		//		break;
		//	case 2:
		//		name.Append( other->GetUserInfo()->GetString( "ui_clan" ) );
		//		break;
		//}

		_hud->SetStateString( va( "name_%d_name", nameCount ), name.c_str() );
		_hud->SetStateFloat( va( "name_%d_x", nameCount ), screen.x );
		_hud->SetStateFloat( va( "name_%d_y", nameCount ), screen.y );
		_hud->SetStateFloat( va( "name_%d_z", nameCount ), screen.z );

		nameCount++;
	}

	_hud->SetStateInt( "name_count", nameCount );

	_hud->StateChanged( gameLocal.time );
}*/

void idPlayer::SetSpeedPercent( float percent )
{
	percent /= 100;
	runSpeed = spawnArgs.GetFloat( "runspeed", "240" ) * percent;
	walkSpeed = spawnArgs.GetFloat( "walkspeed", "120" ) * percent;
	crouchSpeed = spawnArgs.GetFloat( "crouchspeed", "120" ) * percent;
}


//--------------------------------------------------------------------------
// add a pipe to the player's pipe list. Checks to make sure he can have another pipe
// returns the index of the new pipe
//--------------------------------------------------------------------------

#define DETPIPE_DELAY 150

void idPlayer::AddPipe( Pipebomb* pipe ) {
	assert( !gameLocal.isClient );
	assert( currentPC == CLASS_DEMOMAN );
	assert( pipes.FindIndex( pipe ) < 0 );

	nextPipeAttack = gameLocal.time + DETPIPE_DELAY;

	// if we're full on pipes, remove our oldest pipe
	if ( pipes.Num() >= MAX_PIPES_PER_PLAYER ) {
		DetPipe( false );
	}
	else {
		// generate the max # of pipes a player can have based on the # of unique pipers
		idPlayer* player;
		idPlayer* oldestPiper = NULL;
		int oldestPipe = gameLocal.time + 1000;
		int numUniquePipers = 1;		// immidiately count ourselves
		int numTeamPipes = pipes.Num() + 1;			// immidiately count this pipe
		for ( int i = 0; i < gameLocal.numClients; i++ ) {
			player = GET_PLAYER( i );

			// skip ourselves
			if ( !player || player == this )
				continue;

			assert( player );

			if ( player->currentPC == CLASS_DEMOMAN && player->team == team && player->GetNumPipes() > 0 ) {
				numUniquePipers++;
				numTeamPipes += player->GetNumPipes();
				if ( player->GetOldestPipeTime() < oldestPipe ) {
					oldestPiper = player;
					oldestPipe = player->GetOldestPipeTime();
				}
			}
		}

		// simple case, if there are no pipers yet, allow the pipe
		if ( numUniquePipers > 1 ) {
			// another simple case, if # of team pipes < max, allow the pipe
			if ( numTeamPipes > MAX_PIPES_PER_TEAM ) {
				// get the # of pipes a player is allowed based on the # of pipers
				int maxPipes = MAX_PIPES_PER_TEAM / numUniquePipers;
				
				// always allow atleast one pipe
				if ( maxPipes < 1 ) {
					maxPipes = 1;
				}

				// det one of our own pipes if we're over maxPipes
				if ( pipes.Num() >= maxPipes ) {
					DetPipe( false );
				}
				else {
					// det the oldest pipe on the team
					assert( oldestPiper != NULL );		// should never happen if we've reached this point
					oldestPiper->DetPipe( false );
				}
			}
		}

	}

	assert( pipes.Num() < MAX_PIPES_PER_PLAYER );

	pipes.Append( pipe );
}


//--------------------------------------------------------------------------
// If detAll == true, dets all pipes belonging to this player. Otherwise dets the oldest one.
//--------------------------------------------------------------------------

void idPlayer::DetPipe( bool detAll, bool force ) {
	if ( gameLocal.isClient )
		return;
	
	if ( currentPC != CLASS_DEMOMAN ) {
		return;
	}

	if ( pipes.Num() <= 0 ) {
		return;
	}

	if ( detAll ) {
		if ( !force && gameLocal.time < nextPipeAttack ) {
			return;
		}

		while( pipes.Num() > 0 ) {
			assert( pipes[0] );
			pipes[0]->PostEventMS( &EV_Explode, 0 );
			pipes[0]->RemoveFromPlayer();					// instantly remove this pipe
		}

		pipes.Clear();
	}
	else {
		assert( pipes[0] );
		pipes[0]->PostEventMS( &EV_Explode, 0 );
		pipes[0]->RemoveFromPlayer();				// instantly remove this pipe
	}
}


//--------------------------------------------------------------------------
// Removes a pipe from our pipe list and reorders the list
//--------------------------------------------------------------------------
void idPlayer::RemovePipe( Pipebomb* pipe ) {
	pipes.Remove( pipe );
}



//--------------------------------------------------------------------------
// called when we get hit with an emp
//--------------------------------------------------------------------------
void idPlayer::EmpTouch( const AttackerInfo &attacker, idVec3 &dir, float damageScale ) {

	int damage = 0;

	// calculate damage
	int shells = inventory.HasAmmo( AMMO_SHELLS_INDEX, 1 ) * 0.75f;
	int rockets = inventory.HasAmmo( AMMO_ROCKETS_INDEX, 1 ) * 0.75f;
	int cells = inventory.HasAmmo( AMMO_CELLS_INDEX, 1 ) * 0.75f;

	damage = shells + rockets + rockets + cells;
	damage *= damageScale;

	if ( damage <= 0 ) return;

	TFDamage dmg;
	dmg.Create( attacker, spawnArgs.GetString( "def_empdamage", "q4f_damage_emp_playerExplode" ), damageScale );
	dmg.SetDamage( damage );

	// do radius damage to those surrounding us
	gameLocal.RadiusDamage_TF( GetCenter(), dmg, NULL );

	// reduce our ammo
	inventory.UseAmmo( AMMO_SHELLS_INDEX, shells );
	inventory.UseAmmo( AMMO_ROCKETS_INDEX, rockets );
	inventory.UseAmmo( AMMO_CELLS_INDEX, cells );
}

void idPlayer::DropAmmo( const char* ammoName, int drop, int save ) {

	if ( drop == 0 || spectating ) {
		return;
	}

	int ammoIndex = inventory.AmmoIndexForAmmoClass( ammoName );

	if ( ammoIndex <= 0 || ammoIndex > 4  ) {
		gameLocal.Printf( "DropAmmo - Unkown ammo type %s\n", ammoName );
		return;
	}

	if ( drop > MAX_AMOUNT_PER_AMMO )
		drop = MAX_AMOUNT_PER_AMMO;

	if ( save > MAX_AMOUNT_PER_AMMO )
		save = MAX_AMOUNT_PER_AMMO;

	if ( save < 0 )
		save = 0;

	if ( gameLocal.isClient ) {
		// send request to server and return

		idBitMsg        outMsg;
		byte                msgBuf[ MAX_GAME_MESSAGE_SIZE ];
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_DROPAMMO );
		outMsg.WriteBits( ammoIndex, ASYNC_PLAYER_INV_AMMOTYPE_BITS );
		if ( drop > 0 ) {
			outMsg.WriteBits( 1, 1 );
			outMsg.WriteBits( drop, ASYNC_PLAYER_INV_AMMO_BITS );

			if ( save > 0 ) {
				outMsg.WriteBits( 1, 1 );
				outMsg.WriteBits( save, ASYNC_PLAYER_INV_AMMO_BITS );
			}
			else {
				outMsg.WriteBits( 0, 1 );
			}
		}
		else {
			outMsg.WriteBits( 0, 1 );
		}
		networkSystem->ClientSendReliableMessage( outMsg );

		return;
	}



	// get the type of ammo(s) this entityDef contains
	// for each of the ammo types in the def, reduce our inventory ( if we can )


	int ammoInInv;
	int dropAmount;

	// get how much ammo we have in this index
	ammoInInv = inventory.HasAmmo( ammoIndex, 1 );
	if ( ammoInInv <= 0 ) {
		return;
	}

	if ( drop > 0 ) {
		dropAmount = drop > ammoInInv ? ammoInInv : drop;
		if ( save > 0 ) {                // don't drop all of our ammo
			dropAmount -= save;
			if ( dropAmount <= 0 ) {
				return;
			}

		}
	}
	else {
		dropAmount = ammoInInv;
	}

	// remove this from our inventory
	inventory.UseAmmo( ammoIndex, dropAmount );

	idDict dropAmmoDict;

	// set it to dropped, does sync physics automatically
	dropAmmoDict.SetBool( "dropped", true );
	dropAmmoDict.Set( "gravity", "1" );

	// add this dropped amount to the dropammo dict
	dropAmmoDict.Set( va( "give_%s", ammoName ), va( "%d", dropAmount ) );

	// spawn and throw it
	DropItem( ammoName, &dropAmmoDict, 20.0f, 250.0f, 100.0f );
}

//--------------------------------------------------------------------------
// Drop a backpack of all our ammo
//--------------------------------------------------------------------------
void idPlayer::DropBackPack( bool dropAllAmmo ) {

    int shells = inventory.ammo[ AMMO_SHELLS_INDEX ];
    int nails = inventory.ammo[ AMMO_NAILS_INDEX ];
    int rockets = inventory.ammo[ AMMO_ROCKETS_INDEX ];
    int cells = inventory.ammo[ AMMO_CELLS_INDEX ];

	if ( !dropAllAmmo ) {
		switch( currentPC ) {
			case CLASS_SCOUT:
				shells = nails = 0;
				break;

			case CLASS_SNIPER:
				shells = nails = 0;
				break;

			case CLASS_SOLDIER:
				shells = rockets = 0;
				break;

			case CLASS_DEMOMAN:
				shells = rockets = 0;
				break;

			case CLASS_MEDIC:
				shells = nails = 0;
				break;

			case CLASS_HWGUY:
				shells = 0;
				break;

			case CLASS_PYRO:
				shells = cells = rockets = 0;
				break;

			case CLASS_SPY:
				shells = nails = 0;
				break;

			case CLASS_ENGINEER:
				shells = nails = cells = rockets = 0;
				break;
		}
	}

	if ( shells == 0 && nails == 0 && rockets == 0 && cells == 0 )
		return;

    inventory.UseAmmo( AMMO_SHELLS_INDEX, shells );
    inventory.UseAmmo( AMMO_NAILS_INDEX, nails );
    inventory.UseAmmo( AMMO_ROCKETS_INDEX, rockets );
    inventory.UseAmmo( AMMO_CELLS_INDEX, cells );

    idDict dropAmmoDict;

    dropAmmoDict.Set( va( "give_%s", "ammo_shells" ), va( "%d", shells ) );
    dropAmmoDict.Set( va( "give_%s", "ammo_nails" ), va( "%d", nails ) );
    dropAmmoDict.Set( va( "give_%s", "ammo_rockets" ), va( "%d", rockets ) );
    dropAmmoDict.Set( va( "give_%s", "ammo_cells" ), va( "%d", cells ) );
	dropAmmoDict.Set( "dropped", "1" );
	dropAmmoDict.Set( "gravity", "1" );

    DropItem( "ammo_backpack", &dropAmmoDict, 20.0f, 250.0f, 100.0f );
}

//--------------------------------------------------------------------------
// Toss an item
//--------------------------------------------------------------------------
void idPlayer::DropItem( const char* defName, idDict* additionalArgs, float removeTimeSec, float forwardSpeed, float upSpeed ) {
    assert( !gameLocal.isClient );
	
	idEntity* newEnt = gameLocal.SpawnEntityDef( defName, additionalArgs );
    if ( !newEnt || !newEnt->IsType( TFItem::GetClassType() ) ) {
        gameLocal.Warning( "idPlayer::DropItem - could not spawn item '%s'\n", defName );
        return;
    }

    // find a free item and get the oldest item
    int freeIndex = -1;
    int oldestIndex = -1;
    int oldestTime = gameLocal.time + 1000;
	int currTime;

	for ( int i = 0; i < MAX_DROPAMMOS; i++ ) {
		if ( dropAmmos[i].GetEntity() == NULL ) {
			freeIndex = i;
			break;
		}
		else {
			currTime = dropAmmos[i].GetEntity()->GetSpawnTime();
			if ( currTime < oldestTime ) {
				oldestTime = currTime;
				oldestIndex = i;
			}
		}
	}

	// if no free index, remove the oldest item
	if ( freeIndex < 0 ) {
		assert( oldestIndex >= 0 && dropAmmos[oldestIndex].GetEntity() );

		dropAmmos[oldestIndex].GetEntity()->PostEventMS( &EV_Remove, 0 );
		freeIndex = oldestIndex;
	}

	TFItem* item = static_cast<TFItem*>(newEnt);

    item->SetState( TFSTATE_DISABLED, true, false );
    item->SetState( TFSTATE_IDLE, true, false, NULL, 0.5f );

    item->PostEventSec( &EV_Remove, removeTimeSec );

	item->ignorePlayer = this;
	item->ignoreTime = gameLocal.time + 1000;

    dropAmmos[freeIndex] = item;

	// spawn outside player
    idVec3 org = GetCenter();
	org += viewAngles.ToForward() * 24.0f;

    idVec3 vel = ( viewAngles.ToForward() * forwardSpeed ) - ( GetPhysics()->GetGravityNormal() * upSpeed );

    item->GetPhysics()->SetOrigin( org );
    item->GetPhysics()->SetLinearVelocity( vel );
}


//--------------------------------------------------------------------------
// Give, called by scripts or item pickup
//--------------------------------------------------------------------------
bool idPlayer::Give_TF( const char* type, int amount, bool allowLower, bool exceedMax, bool setAbsolute, int* invAmount, int* invMaxAmount ) {
	assert( !gameLocal.isClient );

	if ( health <= 0 )
		return false;

	if ( invAmount ) {
		*invAmount = 0;
	}
	if ( invMaxAmount ) {
		*invMaxAmount = 0;
	}

	int index = inventory.AmmoIndexForAmmoClass( type );
	if ( index > 0 ) {					// ammo_none is 0
		int maxAmmo = spawnArgs.GetInt( va( "max_%s", type ), "999" );

		return AdjustIntStat( inventory.ammo[ index ], amount, 0, maxAmmo, MAX_AMOUNT_PER_AMMO, exceedMax, allowLower, setAbsolute, invAmount, invMaxAmount ); 

	}
	else if ( !idStr::Icmp( type, "armor" ) ) {
		int maxArmor = inventory.maxarmor;

		if ( inventory.armor >= maxArmor && currentPC == CLASS_ENGINEER ) {
			int maxAmmo = spawnArgs.GetInt( "max_ammo_cells", "999" );
			
			bool ret = AdjustIntStat( inventory.ammo[ AMMO_CELLS_INDEX ], amount, 0, maxAmmo, MAX_AMOUNT_PER_AMMO, exceedMax, allowLower, setAbsolute, NULL, NULL );

			if ( invAmount )
				*invAmount = inventory.armor;
			if ( invMaxAmount )
				*invMaxAmount = maxArmor;

			return ret;
		}
		else if ( AdjustIntStat( inventory.armor, amount, 0, maxArmor, MAX_ARMOR, exceedMax, allowLower, setAbsolute, invAmount, invMaxAmount ) ) {
			nextArmorPulse = gameLocal.time + ARMOR_PULSE;
			return true;
		}

		return false;
	}

	else if ( !idStr::Icmp( type, "health" ) ) {
		if ( idEntity::Give_TF( type, amount, allowLower, exceedMax, setAbsolute, invAmount, invMaxAmount ) ) {
			nextHealthPulse = gameLocal.time + HEALTH_PULSE;
			return true;
		}
		return false;
	}

	else if ( !idStr::Icmp( type, "playerscore" ) ) {

		int playerScore = tfStatManager->GetPlayerScore( entityNumber );
		int oldScore = playerScore;

		AdjustIntStat( playerScore, amount, 0, 9999, 9999, exceedMax, allowLower, setAbsolute, invAmount, invMaxAmount );

		tfStatManager->AddPlayerScore( entityNumber, playerScore - oldScore );
		
		return oldScore != tfStatManager->GetPlayerScore( entityNumber );
	}

	return idEntity::Give_TF( type, amount, allowLower, exceedMax, setAbsolute, invAmount, invMaxAmount );
}


//--------------------------------------------------------------------------
// Called when an item is picked up and can be carrier
//--------------------------------------------------------------------------
bool idPlayer::GiveTFItem( TFCarryItem* item ) {
	return inventory.GiveTFItem( item );
}


//--------------------------------------------------------------------------
// Removes the item from our inventory
//--------------------------------------------------------------------------
void idPlayer::RemoveTFItem( TFCarryItem* item ) {
	inventory.RemoveTFItem( item );
}


//--------------------------------------------------------------------------
// Drops all carried items that have the "dropflag" var to true.
// if dropall, drops all items regardless of the "dropflag" command
//--------------------------------------------------------------------------
void idPlayer::DropItems( bool force, tfstate_t newState ) {
	assert( !gameLocal.isClient );

	TFCarryItem* item;
	int i;

	for ( i = 0; i < inventory.tfitems.Num(); i++ ) {
		item = inventory.tfitems[i];
		assert( item );
		if ( force || item->spawnArgs.GetBool( "allowdrop" ) ) {
			item->SetState( newState, true, true, this );
			item->ignorePlayer = this;
			item->ignoreTime = gameLocal.time + 1000;
		}
	}
}


//--------------------------------------------------------------------------
// Initializes new class information
//--------------------------------------------------------------------------
void idPlayer::InitClassInformation() {

	if ( !IS_VALID_CLASS_NUM( currentPC ) )
		return;

	// can no longer use pm_variables for speed
	runSpeed	= spawnArgs.GetFloat( "runspeed", "240" );
	walkSpeed	= spawnArgs.GetFloat( "walkspeed", "120" );
	crouchSpeed = spawnArgs.GetFloat( "crouchspeed", "120" );

	// clear held grenade
	ClearHeldGrenade();

	LoadGrenades();

	memset ( cachedWeaponDefs, 0, sizeof(cachedWeaponDefs) );

	int clipsize;

	// load weapon information, also caches the weapons
	const idDeclEntityDef* weapDef = NULL;

	for ( int i = 0; i < MAX_WEAPONS; i++ ) {
		weapDef = GetWeaponDef(i);
		if ( weapDef ) {
			clipsize = weapDef->dict.GetInt( "clipSize", "0" );
			if ( clipsize < 0 )
				clipsize = 0;

			inventory.clipSizes[i] = clipsize;
			inventory.clip[i] = clipsize;
			inventory.ammoIndices[i] = inventory.AmmoIndexForAmmoClass( weapDef->dict.GetString( "ammoType", "ammo_none" ) );
		}
	}

	// health/armor
	inventory.maxHealth		= spawnArgs.GetInt( "maxhealth", "100" );
	inventory.maxarmor		= spawnArgs.GetInt( "maxarmor", "100" );
	inventory.armor			= spawnArgs.GetInt( "armor", "0" );
}


//--------------------------------------------------------------------------
// Check if this player is ready to start playing
//--------------------------------------------------------------------------
bool idPlayer::ReadyToPlay() {
	return !wantSpectate && IS_VALID_TEAM( team ) && IS_VALID_CLASS_NUM( nextPC );
}


//--------------------------------------------------------------------------
// Show a main menu tab
//--------------------------------------------------------------------------
void idPlayer::ShowMenu( int tabNum ) {

	//if ( gameLocal.mpGame.GetCurrentMenu() == 0 ) {
		gameLocal.mpGame.ShowQ4FMenu( tabNum );
	//}
}


//--------------------------------------------------------------------------
// Limit or increase player speed
//--------------------------------------------------------------------------
void idPlayer::Event_LimitSpeed( float multiplier, float time ) {
	speedMultiplier *= multiplier;

	if ( time > 0.0f ) {
		PostEventSec( &EV_Player_LimitSpeed, time, 1.0f / multiplier );
	}
}

void idPlayer::Event_GetCurrentKiller() {
	TFDamage* dmg = GetKillerDamage();

	if ( dmg ) {
		idThread::ReturnEntity( dmg->GetAttacker().GetEntity() );
	}
	else {
		idThread::ReturnEntity( NULL );
	}
}

#define MESSAGE_LIFE_TIME 1200
bool idPlayer::AddToMessageQueue( const char* msgString ) {
	// go thru queue and remove old messages while checking to see if the message exists
	/*int i = 0;
	while ( i < messageQueue.Num() ) {
		if ( messageQueue[i].Second() <= gameLocal.time ) {
			messageQueue.RemoveIndex( i );
		}
		else {
			// check if message exists
			if ( !messageQueue[i].First().Icmp( msgString ) ) {
				// message exists in queue, don't add or print
				return false;
			}

			i++;
		}
	}

	if ( messageQueue.Num() == MAX_MESSAGES ) {
		// pop off oldest message. add this one
		messageQueue.RemoveIndex( 0 );
	}

	assert( messageQueue.Num() < MAX_MESSAGES );

	messageQueue.Append( rvPair< idStr, int >( msgString, gameLocal.time + MESSAGE_LIFE_TIME ) );
	return true;*/


	// don't flood repeat messages
	if ( gameLocal.time >= nextMsgChange || messageQueue.Cmp( msgString ) ) {
		messageQueue = msgString;
		nextMsgChange = gameLocal.time + MESSAGE_LIFE_TIME;
		return true;
	}

	return false;
}

void idPlayer::StartPreview( const idDeclEntityDef* entDef ) {
	assert( entDef );
	assert( !isPreviewing );

	isPreviewing = true;
	buildPreview.Start( this, entDef );	
	OpenMenu( 6 );
}

void idPlayer::StopPreview() {
	buildPreview.Stop();
	isPreviewing = false;
}

void idPlayer::WaterLevelChange( float oldLevel, float newLevel ) {
	if ( oldLevel < WATERLEVEL_WAIST && newLevel >= WATERLEVEL_WAIST ) {
		idVec3 grav = ( GetPhysics()->GetLinearVelocity() * GetPhysics()->GetGravityNormal() ) * GetPhysics()->GetGravityNormal();
		float gravSpeed = grav.Length();
		if ( gravSpeed > 200.0f ) {
			StartSound( "snd_water_enter", SND_CHANNEL_BODY3, 0, false, NULL );
		}
		pfl.inWater = true;
	}
	else if ( oldLevel >= WATERLEVEL_WAIST && newLevel < WATERLEVEL_WAIST ) {
		StartSound( "snd_water_exit", SND_CHANNEL_BODY3, 0, false, NULL );
		pfl.inWater = false;
	}
}

#define DISGUISE_TIME 3000

void idPlayer::StartDisguise( disguiseType_t type, int num ) {
	assert( !gameLocal.isClient );
	assert( currentPC == CLASS_SPY );

	// don't allow disguise if already disguising
	if ( disguiseStart + DISGUISE_TIME >= gameLocal.time )
		return;
	
	if ( type == DISGUISE_TEAM ) {
		assert( IS_VALID_TEAM( num ) );

		disguiseClassTo = INVALID_CLASS;
		disguiseTeamTo = num;
		disguiseStart = gameLocal.time;
	}
	else if ( type == DISGUISE_CLASS ) {
		assert( IS_VALID_CLASS_NUM( num ) );

		disguiseTeamTo = INVALID_TEAM;
		disguiseClassTo = num;
		disguiseStart = gameLocal.time;
	}
}

void idPlayer::DisguiseChanged( int oldTeam, int oldClass, int newTeam, int newClass ) {
	disguiseClass = newClass;
	disguiseTeam = newTeam;

	disguiseName = -1;

	if ( oldTeam != newTeam ) {
		UpdateVisibleColor();
	}

	if ( hud ) {
		idVec3 tColor;

		if ( newTeam != INVALID_TEAM ) {
			tColor = tfGame.GetTeamColor( newTeam );
		}
		else {
			tColor = tfGame.GetTeamColor( team );
		}
		hud->SetStateFloat( "disguise_color_x", tColor.x );
		hud->SetStateFloat( "disguise_color_y", tColor.y );
		hud->SetStateFloat( "disguise_color_z", tColor.z );

		if ( IS_VALID_CLASS_NUM( newClass ) ) {
			hud->SetStateString( "disguise_class_name", tfGame.GetClassName( newClass, true ) );
		}
		else {
			hud->SetStateString( "disguise_class_name", "Spy" );
		}
	}

	runSpeed	= spawnArgs.GetFloat( "runspeed", "240" );
	walkSpeed	= spawnArgs.GetFloat( "walkspeed", "120" );
	crouchSpeed = spawnArgs.GetFloat( "crouchspeed", "120" );

	if ( newClass != INVALID_CLASS && GetUserInfo()->GetBool( "ui_adjustSpeed", "1" ) ) {
		ENTDEF speedDef = tfGame.GetClassEntDef( newClass );

		runSpeed	= idMath::ClampFloat( 0.0f, runSpeed, speedDef->dict.GetFloat( "runspeed", "240" ) );
		walkSpeed	= idMath::ClampFloat( 0.0f, walkSpeed, speedDef->dict.GetFloat( "walkspeed", "120" ) );
		crouchSpeed = idMath::ClampFloat( 0.0f, crouchSpeed, speedDef->dict.GetFloat( "crouchspeed", "120" ) );
	}

	// pick a random player name to mimic
	if ( newTeam != team && newTeam != INVALID_TEAM && newClass != INVALID_CLASS ) {
		int potentialClient = -1;
		idPlayer* p;
		bool potentialWasClass = false;
		for ( int i = 0; i < gameLocal.numClients; i++ ) {
			if ( i == entityNumber || i == gameLocal.localClientNum )
				continue;

			p = GET_PLAYER( i );
			if ( p->team == newTeam && !p->spectating ) {
				if ( p->currentPC == newClass ) {
					if ( potentialWasClass ) {
						if ( gameLocal.random.RandomFloat() > 0.5f )
							potentialClient = i;
					}
					else {
						potentialWasClass = true;
						potentialClient = i;
					}
				}
				else if ( !potentialWasClass ) {
					potentialClient = i;
				}
			}
		}
		disguiseName = potentialClient;
	}

	if ( oldClass != newClass ) {
		UpdateModelSetup( false );
		if ( weapon )
			weapon->InitWorldModel();
		UpdateAnimPrefix();
	}

	disguiseClassTo = INVALID_CLASS;
	disguiseTeamTo = INVALID_TEAM;
}

void idPlayer::UpdateDisguise() {
	if ( disguiseStart <= 0 )
		return;

	float percentage = (float)(gameLocal.time - disguiseStart) / (float)DISGUISE_TIME;

	if ( !gameLocal.isClient ) {
		if ( percentage >= 0.5f && !DisguiseFinished() ) {
			int oldClass = disguiseClass;
			int oldTeam = disguiseTeam;

			if ( disguiseClassTo != INVALID_CLASS ) {
				disguiseClass = disguiseClassTo;
			}

			if ( disguiseTeamTo != INVALID_TEAM ) {
				disguiseTeam = disguiseTeamTo;
			}

			DisguiseChanged( oldTeam, oldClass, disguiseTeam, disguiseClass );
		}
	}

	if ( percentage >= 1.0f ) {
		if ( !gameLocal.isClient )
			disguiseStart = 0;

		percentage = 0.0f;
	}

	if ( hud )
		hud->SetStateFloat( "disguise_percent", percentage );

	percentage *= 2.0f;

	if ( percentage >= 1.0f ) {
		percentage = 2.0f - percentage;
	}

	UpdateDisguiseShader( percentage );
	UpdateVisuals();
}

void idPlayer::ClearDisguise( void ) {
	disguiseClassTo = INVALID_CLASS;
	disguiseTeamTo = INVALID_TEAM;
	disguiseStart = 0;
	disguiseName = -1;

	if ( hud )
		hud->SetStateFloat( "disguise_percent", 0.0f );

	UpdateDisguiseShader( 0.0f );

	if ( disguiseClass != INVALID_CLASS || disguiseTeam != INVALID_TEAM ) {
		DisguiseChanged( disguiseTeam, disguiseClass, INVALID_TEAM, INVALID_CLASS );
	}
}

void idPlayer::Event_Touch( idEntity *other, trace_t *trace ) {
	assert( !gameLocal.isClient );

	if ( other && other->IsType( idPlayer::GetClassType() ) ) {
		idPlayer* otherPlayer = static_cast<idPlayer*>(other);

		if ( otherPlayer->team != team ) {
			if ( otherPlayer->currentPC == CLASS_SCOUT && currentPC == CLASS_SPY ) {
				ClearDisguise();
			}
		}
		else {
			if ( afflictions & AFFL_INFECTION && ( otherPlayer->currentPC != CLASS_MEDIC ) ) {
				TFDamage dmg;
				dmg.Create( dmgInfection.GetAttacker(), "q4f_damage_vaccine", dmgInfection.GetDamageScale() );
				otherPlayer->AddAffliction( dmg );
			}
		}
	}
}

#define RADAR_UPDATE_TIME 500

void idPlayer::CalcRadarPositions() {
	assert( !gameLocal.isClient );

	if ( gameLocal.time < radarTime )
		return;

	radarTime = gameLocal.time + RADAR_UPDATE_TIME;

	idPlayer* other;

	for ( int i = 0; i < MAX_CLIENTS; i++ ) {

		// consolidate calculations
		if ( radarPositions[i].lastCalcTime >= gameLocal.time )
			continue;

		other = GET_PLAYER( i );
		if ( !other ) {
			radarPositions[i].visible = false;
			continue;
		}

		bool visible = GetPlayerRadarPosition( radarPositions[i], other );
		
		// consolidate calculations

		other->radarPositions[entityNumber].lastCalcTime = gameLocal.time;

		if ( !visible ) {
			other->radarPositions[entityNumber].visible = false;
		}
		else {
			other->radarPositions[entityNumber].visible = true;
			other->radarPositions[entityNumber].xRel = -( radarPositions[i].xRel );
			other->radarPositions[entityNumber].yRel = -( radarPositions[i].yRel ); 
			other->radarPositions[entityNumber].yaw = idMath::ClampFloat( 0.0f, 360.0f, viewAngles.yaw );
		}
	}
}

bool idPlayer::GetPlayerRadarPosition( playerRadarPos_t &pos, const idPlayer* player ) {

	assert( !gameLocal.isClient || entityNumber == gameLocal.localClientNum );
	pos.visible = false;


	if ( !player || player == this || player->spectating || player->health <= 0 ) {
		return false;
	}

	if( IS_VALID_TEAM( team ) ) {
		if ( health <= 0 ) {
			return false;
		}

		if ( player->team != team ) {
			if ( currentPC != CLASS_SPY && player->disguiseTeam != team ) {
				return false;
			}
		}
	}

	idVec3 diff = player->GetCenter() - GetCenter();

	if ( idMath::Fabs( diff.x ) > RADAR_RANGE || idMath::Fabs( diff.y ) > RADAR_RANGE ) {

		return false;
	}

	diff /= RADAR_RANGE;		// normalize x,y,z from 0 to 1
	
    pos.xRel = diff.x;
	pos.yRel = diff.y;
	pos.yaw = idMath::ClampFloat( 0.0f, 360.0f, player->viewAngles.yaw );
	pos.visible = true;
	return true;
}

void idPlayer::DrawRadar( idUserInterface *_hud ) {

	if ( !GetUserInfo()->GetBool( "ui_showradar" ) ) {
		_hud->SetStateBool( "showRadar", false );
		return;
	}
	_hud->SetStateBool( "showRadar", true );

	// draw player blips
	int blipCount = 0;

	idVec3 tColor;

	idPlayer* other;

	for ( int i = 0; i < MAX_CLIENTS; i++ ) {

		other = GET_PLAYER( i );
		if ( !other )
			continue;

		// always draw ourselves
		if ( i == gameLocal.localClientNum ) {
			radarPositions[i].visible = true;
		}

		if ( !radarPositions[i].visible )
			continue;

		_hud->SetStateFloat( va( "blip_%d_x", i ), radarPositions[i].xRel );
		_hud->SetStateFloat( va( "blip_%d_y", i ), radarPositions[i].yRel );

		// 3j_todo: blip rotation
		
		tColor = other->GetTeamColor( other->team != team );

		_hud->SetStateFloat( va( "blip_%d_c_r", i ), tColor.x );
		_hud->SetStateFloat( va( "blip_%d_c_g", i ), tColor.y );
		_hud->SetStateFloat( va( "blip_%d_c_b", i ), tColor.z );

		blipCount++;
	}

	_hud->SetStateInt( "blip_count", blipCount );

	float yaw = viewAngles.yaw;
	float rot = gameLocal.mapInfo.GetGameTypeRadarRotation( gameLocal.gameType );
	float turn = yaw + rot;

	mphud->SetStateFloat( "radar_rotate", -turn + 90.0f  );

	float overallScale = 1.0f;
	float bgScale = gameLocal.radarWorldScale * overallScale;

	// scroll the bg
	idVec3 myPos = GetPhysics()->GetOrigin();
	myPos.x -= gameLocal.worldLowerBounds.x;
	myPos.y -= gameLocal.worldLowerBounds.y;
	float xScrll = ( ( myPos.x / gameLocal.worldBoundsSize.x ) - 0.5f ) * 2.0f;
	float yScrll = ( ( 1.0f - ( myPos.y / gameLocal.worldBoundsSize.y ) ) - 0.5f ) * 2.0f;

	float scaleOffset = ( ( 480.0f * bgScale ) - 480.0f ) * -0.5f;
	float rectx = scaleOffset - ( xScrll * ( 240.0f * bgScale ) );
	float recty = scaleOffset - ( yScrll * ( 240.0f * bgScale ) );
	float rects = 480 * bgScale;

	mphud->SetStateFloat( "radar_rect_x", rectx );
	mphud->SetStateFloat( "radar_rect_y", recty );
	mphud->SetStateFloat( "radar_rect_s", rects );
	mphud->SetStateFloat( "radar_scale", overallScale );

	//gameRenderWorld->DebugBounds( colorPurple, worldMaxBounds, vec3_origin, 10 );

	_hud->StateChanged( gameLocal.time );
}

/*
void idPlayer::AddFXCache( fxCache_t &newCache ) {
	int maxSize = fxCount > SCRIPT_CACHE_SIZE ? SCRIPT_CACHE_SIZE : fxCount;
	int cacheIndex = -1;

	fxCache_t* curr;

	for ( int i = 0; i < maxSize; i++ ) {
		curr = &(fxCache[i]);

		if ( curr->effect->Index() == newCache.effect->Index() ) {
			if ( curr->loop == newCache.loop ) {
				if ( curr->align == newCache.align ) {
					if ( curr->dir.Compare( newCache.dir, 0.1f ) ) {
						if ( curr->origin.Compare( newCache.origin ) ) {
							if ( curr->endOrigin.Compare( newCache.origin ) ) {
								cacheIndex = i;
								break;
							}
						}
					}
				}
			}
		}
	}

	if ( cacheIndex < 0 ) {
		curr = &(fxCache[ fxCount % SCRIPT_CACHE_SIZE ]);
		*curr = newCache;
		fxCount++;
	}
}
*/

#define MAX_PRED_TIME 200

void idPlayer::ResetToTime( int time ) {
	int current = currentLoggedPosition;
	int lastIndex = current;


	int maxTime = gameLocal.time;

	while ( true ) {

		if ( maxTime - loggedPositions[ current ].time > MAX_PRED_TIME ) {
			//gameRenderWorld->DebugBounds( colorRed, physicsObj.GetBounds(), loggedPositions[ current ].org + idVec3( 0, 0, 10 ), 30000 );
			break;
		}
		if ( loggedPositions[ current ].time <= time ) {
			//gameRenderWorld->DebugBounds( colorBlue, physicsObj.GetBounds(), loggedPositions[ current ].org + idVec3( 0, 0, 10 ), 30000 );
			break;
		}

		//gameRenderWorld->DebugBounds( colorCyan, physicsObj.GetBounds(), loggedPositions[ current ].org + idVec3( 0, 0, 10 ), 30000 );

		lastIndex = current;

		current--;
		if ( current < 0 )
			current = NUM_LOGGED_POSITIONS - 1;

		if ( current == currentLoggedPosition )
			break;
	}

	restorePosition.axis = physicsObj.GetAxis();
	restorePosition.org = physicsObj.GetOrigin();

	idVec3 lerpPos;

	int timeDiff = loggedPositions[ lastIndex ].time - loggedPositions[ current ].time;
	if ( timeDiff > 0 ) {
		float t = ( (float)( loggedPositions[ lastIndex ].time - time ) ) / ((float)(timeDiff));
		lerpPos.Lerp( loggedPositions[ lastIndex ].org, loggedPositions[ current ].org, t );
	}
	else {
		lerpPos = loggedPositions[ current ].org;
	}

	physicsObj.SetAxis( loggedPositions[ current ].axis );
	physicsObj.SetOrigin( lerpPos );

	//gameRenderWorld->DebugBounds( colorYellow, physicsObj.GetBounds(), loggedPositions[ current ].org, 30000 );
}

void idPlayer::RestoreFromReset() {
	physicsObj.SetAxis( restorePosition.axis );
	physicsObj.SetOrigin( restorePosition.org );
}

void idPlayer::Event_GetPlayerName( void ) {
	idThread::ReturnString( uiName );
}

void idPlayer::Event_GetStat( const char* statStr ) {
	idThread::ReturnInt( GetStat( statStr ) );
}

#define MATCH( _str_ ) !idStr::Icmp( stat, _str_ )

#define GET_STAT( _func_ ) \
	if ( stat_group )\
			return pStats->_func_( stat_group );\
		else if ( dmgStat )\
			return pStats->_func_( dmgStat );\
		else\
			return pStats->_func_();\

int idPlayer::GetStat( const char* statStr ) {
	if ( gameLocal.isClient )
		return 0;

	TFPlayerStats* pStats = tfStatManager->GetPlayerStatsPlayer( this );
	if ( !pStats ) {
		gameLocal.Warning( "idPlayer::GetStat - could not get this player's stats." );
		return 0;
	}

	idCmdArgs args;
	args.TokenizeString( statStr, false );

	if ( args.Argc() <= 0 ) {
		gameLocal.Warning( "idPlayer::GetStat - atleast one parameter must be specified." );
		return 0;
	}

	const char* stat = args.Argv( 0 );

	// special cases
	if ( MATCH( "frags" ) ) {
		return pStats->frags;
	}
	else if ( MATCH( "suicides" ) ) {
		return pStats->suicides;
	}
	else if ( MATCH( "sentries_built" ) ) {
		return pStats->sentryBuildCount;
	}
	else if ( MATCH( "sentries_killed" ) ) {
		return pStats->sentryKillCount;
	}
	else if ( MATCH( "dispensers_built" ) ) {
		return pStats->dispenserBuildCount;
	}
	else if ( MATCH( "dispensers_killed" ) ) {
		return pStats->dispenserKillCount;
	}
	else if ( MATCH( "flag_steals" ) ) {
		return pStats->flagGrabs;
	}
	else if ( MATCH( "flag_drops" ) ) {
		return pStats->flagDrops;
	}
	else if ( MATCH( "flag_captures" ) ) {
		return pStats->flagCaptures;
	}
	else if ( MATCH( "flag_saves" ) ) {
		return pStats->flagSaves;
	}

	// <stat> <enemy,team,self> <damage/weapon/empty>

	const char* attStr = args.Argc() > 1 ? args.Argv( 1 ) : NULL;

	dmgStat_t* dmgStat = NULL;
	const char* stat_group = NULL;

	if ( attStr && attStr[0] ) {
		if ( !idStr::Icmpn( attStr, "weapon", 6 ) ) {					// use attack stats
			ENTDEF weapDef = gameLocal.FindEntityDef( attStr, false );
			if ( !weapDef ) {
				gameLocal.Warning( "idPlayer::GetStat - could not find weapon definition '%s'", attStr );
				return 0;
			}

			const char* attDefStr = NULL;
			if ( !weapDef->dict.GetString( "def_projectile", "", &attDefStr ) || !attDefStr || !attDefStr[0] ) {
				if ( !weapDef->dict.GetString( "def_hitscan", "", &attDefStr ) || !attDefStr || !attDefStr[0] ) {
					weapDef->dict.GetString( "def_melee", "", &attDefStr );
				}
			}

			if ( !attDefStr || !attDefStr[0] ) {
				gameLocal.Warning( "idPlayer::GetStat - the weapon definition '%s' does not contain def_projectile, def_hitscan, or def_melee", attStr );
				return 0;
			}

			ENTDEF attDef = gameLocal.FindEntityDef( attDefStr, false );
			if ( !attDef ) {
				gameLocal.Warning( "idPlayer::GetStat - could not find the entity def '%s' specified in weapon def '%s'", attDefStr, attStr );
				return 0;
			}

			stat_group = attDef->dict.GetString( "stat_group", "" );

			if ( !stat_group || !stat_group[0] ) {
				gameLocal.Warning( "idPlayer::GetStat - the entity def '%s' specified in weapon def '%s' has a null or empty stat_group specified", attDefStr, attStr );
				return 0;
			}
		}
		else {														// use damage stats
			ENTDEF dmgDef = gameLocal.FindEntityDef( attStr, false );
			if ( !dmgDef ) {
				gameLocal.Warning( "idPlayer::GetStat - could not find the damage entity def '%s'", attStr );
				return 0;
			}

			dmgStat = pStats->GetDmgStat( dmgDef );
			if ( !dmgStat )
				return 0;
		}
	}

	if ( MATCH( "kills_enemy" ) ) {
		GET_STAT( StatKillsEnemy )
	}
	else if ( MATCH( "kills_team" ) ) {
		GET_STAT( StatKillsTeam )
	}
	else if ( MATCH( "kills_self" ) ) {
		GET_STAT( StatKillsSelf)
	}
	else if ( MATCH( "deaths_enemy" ) ) {
		GET_STAT( StatDeathsEnemy )
	}
	else if ( MATCH( "deaths_team" ) ) {
		GET_STAT( StatDeathsTeam )
	}
	else if ( MATCH( "deaths_self" ) ) {
		GET_STAT( StatKillsSelf )
	}
	else if ( MATCH( "hits_to_enemy" ) ) {
		GET_STAT( StatHitsToEnemy )
	}
	else if ( MATCH( "hits_to_team" ) ) {
		GET_STAT( StatHitsToTeam )
	}
	else if ( MATCH( "hits_to_self" ) ) {
		GET_STAT( StatHitsFromSelf )
	}
	else if ( MATCH( "hits_from_enemy" ) ) {
		GET_STAT( StatHitsFromEnemy )
	}
	else if ( MATCH( "hits_from_team" ) ) {
		GET_STAT( StatHitsFromTeam )
	}
	else if ( MATCH( "hits_from_self" ) ) {
		GET_STAT( StatHitsFromSelf )
	}
	else if ( MATCH( "damage_to_enemy" ) ) {
		GET_STAT( StatDamageToEnemy )
	}
	else if ( MATCH( "damage_to_team" ) ) {
		GET_STAT( StatDamageToTeam )
	}
	else if ( MATCH( "damage_to_self" ) ) {
		GET_STAT( StatDamageFromSelf )
	}
	else if ( MATCH( "damage_from_enemy" ) ) {
		GET_STAT( StatDamageFromEnemy )
	}
	else if ( MATCH( "damage_from_team" ) ) {
		GET_STAT( StatDamageFromTeam )
	}
	else if ( MATCH( "damage_from_self" ) ) {
		GET_STAT( StatDamageFromSelf )
	}
	else {
		gameLocal.Warning( "unrecognized stat type on call '%s'", statStr );
		gameLocal.Warning( "unable to determine stat from the call '%s'", statStr );
		return 0;
	}
}

#undef MATCH
#undef GET_STAT

void idPlayer::OpenMenu( int num ) {
	CloseMenu();
	if ( hud ) {
		hud->SetStateString( "slot_key_0", common->KeysFromBinding( "_impulse9" ) );
		hud->SetStateString( "slot_key_1", common->KeysFromBinding( "_impulse0" ) );
		hud->SetStateString( "slot_key_2", common->KeysFromBinding( "_impulse1" ) );
		hud->SetStateString( "slot_key_3", common->KeysFromBinding( "_impulse2" ) );
		hud->SetStateString( "slot_key_4", common->KeysFromBinding( "_impulse3" ) );
		hud->SetStateString( "slot_key_5", common->KeysFromBinding( "_impulse4" ) );
		hud->SetStateString( "slot_key_6", common->KeysFromBinding( "_impulse5" ) );
		hud->SetStateString( "slot_key_7", common->KeysFromBinding( "_impulse6" ) );
		hud->SetStateString( "slot_key_8", common->KeysFromBinding( "_impulse7" ) );
		hud->SetStateString( "slot_key_9", common->KeysFromBinding( "_impulse8" ) );

		if ( num == 5 ) { // comm menu

			MessageList* list = gameLocal.msgListCollection.GetList( commMenuIndex );

			if ( list ) {
				for ( int i = 0; i < 10; i++ ) {
					MessageItem* item = list->GetItem( i );
					if ( item ) {
						hud->SetStateString( va( "slot_val_%d", i ), item->GetLabel() );
						hud->SetStateBool( va( "slot_val_%d_visible", i ), true );
					}
					else {
						hud->SetStateBool( va( "slot_val_%d_visible", i ), false );
					}
				}
			}
			else {
				int num = 0;
				list = gameLocal.msgListCollection.GetList( 0 );
				while ( list ) {
					hud->SetStateString( va( "slot_val_%d", num ), list->GetName() );
					hud->SetStateBool( va( "slot_val_%d_visible", num ), true );
					num++;
					list = gameLocal.msgListCollection.GetList(num );
				}

				while( num < 10 ) {
					hud->SetStateString( va( "slot_val_%d", num ), "" );
					hud->SetStateBool( va( "slot_val_%d_visible", num ), false );
					num++;
				}
			}
		}

		hud->SetStateInt( "menu_num", num );
		hud->HandleNamedEvent( "menu_open" );
	}
	menuNum = num;
}

void idPlayer::CloseMenu() {
	if ( menuNum > 0 && hud ) {
		hud->HandleNamedEvent( "menu_close" );
		hud->SetStateInt( "menu_num", 0 );
	}
	menuNum = 0;
}

void idPlayer::MenuSlotSelected( int num ) {
	if ( menuNum > 0 && hud ) {
		hud->SetStateInt( "selectedSlotNum", num );
		hud->HandleNamedEvent( "slot_selected" );
	}

	if ( menuNum == 1 ) {
		switch( num ) {
			case 0:			// 1 key, build sentry
				CloseMenu();
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "build sentry" );
				return;

			case 1:			// 2 key, build dispenser
				CloseMenu();
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "build disp" );
				return;

			case 2:			// 3 key, rotate sentry counter-clockwise
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "rotateSentry -17" );
				return;

			case 3:			// 4 key, rotate sentry clockwise
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "rotateSentry 17" );
				return;

			case 6:			// 7 key, destroy sentry
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "destroy sentry" );
				CloseMenu();
				return;

			case 7:			// 8 key, destroy dispenser
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "destroy dispenser" );
				CloseMenu();
				return;
		}
	}
	else if ( menuNum == 2 ) {
		switch( num ) {
			case 0:			// 1 key, disguise blue
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "disguise team blue" );
				CloseMenu();
				return;

			case 1:			// 2 key, disguise red
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "disguise team red" );
				CloseMenu();
				return;

			case 2:			// 3 key, disguise green
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "disguise team green" );
				CloseMenu();
				return;

			case 3:			// 4 key, disguise orange
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "disguise team orange" );
				CloseMenu();
				return;

			case 4:			// 5 key, open class menu
				CloseMenu();
				OpenMenu( 3 );
				return;
		}
	}
	else if ( menuNum == 3 ) {
		switch( num ) {
			case 0:			// 1 key, disguise scout
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "disguise class scout" );
				CloseMenu();
				return;

			case 1:			// 2 key, disguise sniper
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "disguise class sniper" );
				CloseMenu();
				return;

			case 2:			// 3 key, disguise soldier
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "disguise class soldier" );
				CloseMenu();
				return;

			case 3:			// 4 key, disguise demoman
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "disguise class demoman" );
				CloseMenu();
				return;

			case 4:			// 5 key, disguise medic
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "disguise class medic" );
				CloseMenu();
				return;

			case 5:			// 6 key, disguise hwguy
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "disguise class hwguy" );
				CloseMenu();
				return;

			case 6:			// 7 key, disguise pyro
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "disguise class pyro" );
				CloseMenu();
				return;

			case 7:			// 8 key, disguise spy
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "disguise class spy" );
				CloseMenu();
				return;

			case 8:			// 9 key, disguise engy
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "disguise class engineer" );
				CloseMenu();
				return;

			case 9:			// 0 key, open team menu
				CloseMenu();
				OpenMenu( 2 );
				return;
		}
	}
	else if ( menuNum == 4 ) {
		switch( num ) {
			case 0:			// 1 key, detpack 5
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "detpack 5" );
				CloseMenu();
				return;

			case 1:			
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "detpack 10" );
				CloseMenu();
				return;

			case 2:			
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "detpack 20" );
				CloseMenu();
				return;

			case 3:			
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "detpack 50" );
				CloseMenu();
				return;

		}
	}
	else if ( menuNum == 5 ) {

		if ( commMenuIndex >= 0 ) {
			MessageList* list = gameLocal.msgListCollection.GetList( commMenuIndex );
			if ( list ) {
				MessageItem* item = list->GetItem( num );

				if ( item ) {
					item->Execute();
					CloseMenu();
				}
			}
		}
		else {
			commMenuIndex = num;
			OpenMenu( 5 );
		}
	}
	else if ( menuNum == 6 ) {

		switch( num ) {
			case 0:			// 1 key, start building
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "build" );
				CloseMenu();
				return;

			case 1:			
				PerformImpulse( IMPULSE_14 );
				return;

			case 2:			
				PerformImpulse( IMPULSE_15 );
				return;
		}
	}
}

#define DISPENSE_DIST 65.0f

void idPlayer::CheckDispensers() {

	if ( !gameLocal.isClient ) {

		bool wasDispensing = isDispensing;
		//bool wasFacing = isFacingDispenser;
		dispFillAmount = 0.0f;

		isDispensing = false;
		isFacingDispenser = false;

		if ( focusEnt && focusEnt->IsType( Dispenser::GetClassType() ) && focusDist < DISPENSE_DIST ) {

			if ( currentPC != CLASS_ENGINEER || currentWeapon > 0 ) {

				isFacingDispenser = true;

				if ( usercmd.buttons & BUTTON_ATTACK ) {
					isDispensing = true;

					Dispenser* disp =  static_cast<Dispenser*>(focusEnt.GetEntity());

					dispFillAmount = disp->RefillPlayer( this );

					if ( dispFillAmount >= 1.0f ) {
						isDispensing = false;
					}
					else {

						disp->lastHealTime = gameLocal.time;

						if ( !wasDispensing ) {
							dispFillStartAmount = dispFillAmount;
						}

						dispFillAmount = ( dispFillAmount - dispFillStartAmount ) / ( 1.0f - dispFillStartAmount );
					}
				}
			}
		}
	}

	if ( isFacingDispenser )
		LowerWeapon();
}

void idPlayer::AdjustAnimRates( float runMult, float walkMult, float crouchMult ) {
	AdjustAnimRate( "mp_crouch_walk", crouchMult );
	AdjustAnimRate( "mp_crouch_walk_backward", crouchMult );

	AdjustAnimRate( "run_forward", runMult );
	AdjustAnimRate( "run_backwards", runMult );
	AdjustAnimRate( "run_strafe_left", runMult );
	AdjustAnimRate( "run_strafe_right", runMult );

	AdjustAnimRate( "walk_forward", walkMult );
	AdjustAnimRate( "walk_backwards", walkMult );
	AdjustAnimRate( "walk_right", walkMult );
	AdjustAnimRate( "walk_left", walkMult );
}

void idPlayer::AdjustAnimRate( const char* animName, float multiplier ) {

	int		animNum;
	animNum = GetAnimator()->GetAnim( animName );
	if ( animNum ) {
		idAnim* anim = (idAnim*)( GetAnimator()->GetAnim( animNum ) );

		if ( anim ) {
			anim->SetPlaybackRate ( multiplier );
		}
	}
}

void idPlayer::CommonClear() {
	nextFocusUpdateTime = 0;
}

// </q4f>

//++ GTR bandit: Unlagged Code

/*
============
idPlayer::ResetHistory

Reset the clients history on kill, spawn and teleport.
============
*/
void idPlayer::ResetHistory( void )
{
	// Fill up the history with data (assume the current position)
	clientHistory.head = NUM_CLIENT_HISTORY - 1;

	for ( int i = clientHistory.head; i >= 0; i-- )
		GetClipModel(clientHistory.data[i]);

	clientHistory.isSaved = false;
	clientHistory.lastFrame = -1;
}


/*
============
idPlayer::StoreHistory

Keep track of where the client has been
============
*/
void idPlayer::StoreHistory( void )
{
	// just make sure there is no double frames for this client.
	if (gameLocal.framenum <= clientHistory.lastFrame)
	{
		//common->Printf("idPlayer::StoreHistory: skipped frame for client %d!\n", entityNumber);
		return;
	}
	if (clientHistory.lastFrame != -1 && clientHistory.lastFrame < (gameLocal.framenum-1))
		common->Printf("idPlayer::StoreHistory: lost frame from client %d!\n", entityNumber);

	clientHistory.lastFrame = gameLocal.framenum;

	// jump to the end of the list (oldest savepoint)
	clientHistory.head++;
	if ( clientHistory.head >= NUM_CLIENT_HISTORY )
		clientHistory.head = 0;

	// store the current position and clipmodel in the history
	GetClipModel( clientHistory.data[clientHistory.head] );
}

/*
=================
idPlayer::GetClipModel
=================
*/
void idPlayer::GetClipModel ( historyData_t &historyData )
{
	historyData.origin = physicsObj.PlayerGetOrigin();
	historyData.traceModel = *physicsObj.GetClipModel()->GetTraceModel();
}

/*
=================
idPlayer::SetClipModel
=================
*/
void idPlayer::SetClipModel ( const historyData_t &historyData )
{
	idClipModel *clipModel = physicsObj.GetClipModel();

	if (clipModel)
	{
		clipModel->LoadModel( historyData.traceModel, NULL );
		clipModel->Link( this, 0, historyData.origin, clipModel->GetAxis() );
	}
}

/*
==================
idPlayer::Delag

Move ALL clients back to where they where at the specified clients machine.
==================
*/
void idPlayer::Delag ( int frameOffset/* = -1 */ )
{
	// alive and playing ?
	if ( health <= 0 || spectating )
		return;

	if ( frameOffset != -1 )
	{
		// calculate the correct history position.
		int head = clientHistory.head - frameOffset;
		if ( head < 0 )
			head += NUM_CLIENT_HISTORY;

		// backup the current frame
		if ( clientHistory.isSaved ) // should never happen.. just making sure.
			common->Warning( "idPlayer::Delag: found unexpected backup on client %d!\n", entityNumber );
		else
		{
			GetClipModel( clientHistory.savedData );
			clientHistory.isSaved = true;
		}

		// move the clipmodel of the player back to the stored history position
		SetClipModel( clientHistory.data[head] );
	}
	// bots have ping 0, so we don't need to delag them
	else // if ( !isBot )
	{
		idPlayer *player = NULL;
		int ping;
		pvsHandle_t pvs;

		// Does the client want to delag this weapon ?
		//if ( delag != -1 && !(delag & currentweapon) )
		//	return;

		// get the clients ping and check for maxping
		ping = Min(g_unlaggedMaxPing.GetInteger(), networkSystem->ServerGetClientPing( entityNumber ));

		// get the number of frames to roll back
		frameOffset = ping/16; // ( 16ms = time between server frames)

		if (frameOffset <= 0)
			return;

		if (frameOffset >= NUM_CLIENT_HISTORY)
			frameOffset = NUM_CLIENT_HISTORY-1;

		// Setup the pvs
		pvs = gameLocal.pvs.SetupCurrentPVS( GetPVSAreas(), GetNumPVSAreas() );

		// Loop through all players.
		for ( int i = 0; i < gameLocal.numClients; i++ )
		{
			// don't delag this player
			if ( i == entityNumber )
				continue;

			//player = gameLocal.GetClientByNum(i);
			player = GET_PLAYER( i );

			// player is alive and playing in our instance ?
			if (!player || !gameLocal.mpGame.CanPlay(player) )
				continue;

			// Is the client in the current pvs?
			if ( gameLocal.pvs.InCurrentPVS( pvs, player->GetPVSAreas(), player->GetNumPVSAreas() ) )
				player->Delag( frameOffset );
		}

		// Free the pvs
		gameLocal.pvs.FreeCurrentPVS( pvs );
	}
}

/*
==================
idPlayer::UndoDelag

we don't need to go through all the instance & pvs checks here,
because clientHistory.isSaved can tell us if the client has been delaged.
==================
*/
void idPlayer::UndoDelag ( bool justSelf /* = false */ )
{
	if ( justSelf )
	{
		if ( clientHistory.isSaved )
		{
			clientHistory.isSaved = false;

			// restore original clipModel and position
			if ( health > 0 && !spectating && gameLocal.mpGame.CanPlay(this) )
				SetClipModel( clientHistory.savedData );
		}
	}
	// bots have ping 0, so we don't need to delag them
	else // if ( !isBot )
	{
		idPlayer *player = NULL;

		// Loop through all players that have been delaged.
		for ( int i = 0; i < gameLocal.numClients; i++ )
		{
			if ( i == entityNumber )
				continue;

			//player = gameLocal.GetClientByNum(i);
			player = GET_PLAYER( i );

			// restore original clipModel and position
			if ( player )
				player->UndoDelag( true );
		}
	}
}
//-- GTR bandit: Unlagged Code
