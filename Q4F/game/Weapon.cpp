
// bdube: note that this file is no longer merged with Doom3 updates
//
// MERGE_DATE 09/30/2004

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "Game_local.h"

#include "Weapon.h"
#include "Projectile.h"
#include "client/ClientEffect.h"
//#include "../renderer/tr_local.h"

/***********************************************************************

  rvViewWeapon  
	
***********************************************************************/

// class def
CLASS_DECLARATION( idAnimatedEntity, rvViewWeapon )
	EVENT( EV_CallFunction,		rvViewWeapon::Event_CallFunction )
END_CLASS

/***********************************************************************

	init

***********************************************************************/

/*
================
rvViewWeapon::rvViewWeapon()
================
*/
rvViewWeapon::rvViewWeapon() {
	modelDefHandle		= -1;
	weapon				= NULL;
		
	Clear();

	fl.networkSync = true;	
}

/*
================
rvViewWeapon::~rvViewWeapon()
================
*/
rvViewWeapon::~rvViewWeapon() {
	Clear();
}

/*
================
rvViewWeapon::Spawn
================
*/
void rvViewWeapon::Spawn( void ) {
	GetPhysics()->SetContents( 0 );
	GetPhysics()->SetClipMask( 0 );
	GetPhysics()->SetClipModel( NULL, 1.0f );
}

/*
================
rvViewWeapon::Save
================
*/
void rvViewWeapon::Save( idSaveGame *savefile ) const {
}

/*
================
rvViewWeapon::Restore
================
*/
void rvViewWeapon::Restore( idRestoreGame *savefile ) {
}

/*
===============
rvViewWeapon::ClientPredictionThink
===============
*/
void rvViewWeapon::ClientPredictionThink( void ) {
	UpdateAnimation();	
}

/***********************************************************************

	Weapon definition management

***********************************************************************/

/*
================
rvViewWeapon::Clear
================
*/
void rvViewWeapon::Clear( void ) {
	DeconstructScriptObject();
	scriptObject.Free();

	StopAllEffects( );

	// TTimo - the weapon doesn't get a proper Event_DisableWeapon sometimes, so the sound sticks
	StopSound( SND_CHANNEL_ANY, false );

	memset( &renderEntity, 0, sizeof( renderEntity ) );
	renderEntity.entityNum	= entityNumber;

	renderEntity.noShadow		= true;
	renderEntity.noSelfShadow	= true;
	renderEntity.customSkin		= NULL;

	// set default shader parms
	renderEntity.shaderParms[ SHADERPARM_RED ]	= 1.0f;
	renderEntity.shaderParms[ SHADERPARM_GREEN ]= 1.0f;
	renderEntity.shaderParms[ SHADERPARM_BLUE ]	= 1.0f;
	renderEntity.shaderParms[3] = 1.0f;
	renderEntity.shaderParms[ SHADERPARM_TIMEOFFSET ] = 0.0f;
	renderEntity.shaderParms[5] = 0.0f;
	renderEntity.shaderParms[6] = 0.0f;
	renderEntity.shaderParms[7] = 0.0f;

	memset( &refSound, 0, sizeof( refSound_t ) );
	refSound.referenceSoundHandle = -1;
	
 	// setting diversity to 0 results in no random sound.  -1 indicates random.
 	refSound.diversity = -1.0f;
	
	if ( weapon && weapon->GetOwner ( ) ) {
		// don't spatialize the weapon sounds
		refSound.listenerId = weapon->GetOwner( )->GetListenerId();
	}

 	animator.ClearAllAnims( gameLocal.time, 0 );

	FreeModelDef();
}

/*
=====================
rvViewWeapon::GetDebugInfo
=====================
*/
void rvViewWeapon::GetDebugInfo( debugInfoProc_t proc, void* userData ) {
	// Base class first
	idAnimatedEntity::GetDebugInfo( proc, userData );
	weapon->GetDebugInfo( proc, userData );
}

/***********************************************************************

	GUIs

***********************************************************************/

/*
================
rvViewWeapon::PostGUIEvent
================
*/
void rvViewWeapon::PostGUIEvent( const char* event ) {
	pendingGUIEvents.Append ( event );
}

/***********************************************************************

	Model and muzzleflash

***********************************************************************/

/*
================
rvViewWeapon::SetPowerUpSkin
================
*/
void rvViewWeapon::SetPowerUpSkin( const char *name ) {
}

/*
================
rvViewWeapon::UpdateSkin
================
*/
void rvViewWeapon::UpdateSkin( void ) {
}
	
/*
================
rvViewWeapon::SetModel
================
*/
void rvViewWeapon::SetModel( const char *modelname ) {
	assert( modelname );

	if ( modelDefHandle >= 0 ) {
		gameRenderWorld->RemoveDecals( modelDefHandle );
	}

	renderEntity.hModel = animator.SetModel( modelname );
	if ( renderEntity.hModel ) {
		renderEntity.customSkin = animator.ModelDef()->GetDefaultSkin();
		animator.GetJoints( &renderEntity.numJoints, &renderEntity.joints );
	} else {
		renderEntity.customSkin = NULL;
		renderEntity.callback = NULL;
		renderEntity.numJoints = 0;
		renderEntity.joints = NULL;
	}

	// hide the model until an animation is played
	Hide();
}

/***********************************************************************

	State control/player interface

***********************************************************************/

/*
================
rvViewWeapon::Think
================
*/
void rvViewWeapon::Think( void ) {
	// do nothing because the present is called from the player through PresentWeapon
}

/*
=====================
rvViewWeapon::ConvertLocalToWorldTransform
=====================
*/
void rvViewWeapon::ConvertLocalToWorldTransform( idVec3 &offset, idMat3 &axis ) {
	if( !weapon ) {
		idAnimatedEntity::ConvertLocalToWorldTransform( offset, axis );
		return;
	}

	offset = GetPhysics()->GetOrigin() + offset * weapon->ForeshortenAxis( GetPhysics()->GetAxis() );
	axis *= GetPhysics()->GetAxis();
}

/*
================
rvViewWeapon::UpdateModelTransform
================
*/
void rvViewWeapon::UpdateModelTransform( void ) {
	idVec3 origin;
	idMat3 axis;

	if( !weapon ) {
		idAnimatedEntity::UpdateModelTransform();
		return;
	}

	if ( GetPhysicsToVisualTransform( origin, axis ) ) {
		renderEntity.axis = axis * weapon->ForeshortenAxis( GetPhysics()->GetAxis() );
		renderEntity.origin = GetPhysics()->GetOrigin() + origin * renderEntity.axis;
	} else {
		renderEntity.axis = weapon->ForeshortenAxis( GetPhysics()->GetAxis() );
		renderEntity.origin = GetPhysics()->GetOrigin();
	}
}

/*
================
rvViewWeapon::PresentWeapon
================
*/
void rvViewWeapon::PresentWeapon( int ui_showgun ) {
	// Dont do anything with the weapon while its stale
	if ( fl.networkStale ) {
		return;
	}


// rjohnson: cinematics should never be done from the player's perspective, so don't think the weapon ( and their sounds! )
	if ( gameLocal.inCinematic ) {
		return;
	}

	assert( weapon );

	// only show the surface in player view
	renderEntity.allowSurfaceInViewID = weapon->GetOwner()->entityNumber + 1;

	// crunch the depth range so it never pokes into walls this breaks the machine gun gui
	renderEntity.weaponDepthHackInViewID = weapon->GetOwner()->entityNumber + 1;

	weapon->Think();

	// present the model
	if ( ui_showgun > 0 ) {
		Present();
	} else {
		FreeModelDef();
	}

	UpdateSound();
}

/*
================
rvViewWeapon::WriteToSnapshot
================
*/
void rvViewWeapon::WriteToSnapshot( idBitMsgDelta &msg ) const {
}

/*
================
rvViewWeapon::ReadFromSnapshot
================
*/
void rvViewWeapon::ReadFromSnapshot( const idBitMsgDelta &msg ) {
}

/*
================
rvViewWeapon::ClientStale
================
*/
bool rvViewWeapon::ClientStale ( void ) {
	StopSound( SND_CHANNEL_ANY, false );
	
	if ( weapon ) {
		weapon->ClientStale( );
	}
	
	idEntity::ClientStale( );

	return false;
}

/*
================
rvViewWeapon::ClientReceiveEvent
================
*/
bool rvViewWeapon::ClientReceiveEvent( int event, int time, const idBitMsg &msg ) {
	if ( idEntity::ClientReceiveEvent( event, time, msg ) ) {
		return true;
	}
	if ( weapon ) {
		return weapon->ClientReceiveEvent ( event, time, msg );
	}
	return false;
}

/***********************************************************************

	Script events

***********************************************************************/

/*
=====================
rvViewWeapon::Event_CallFunction
=====================
*/
void rvViewWeapon::Event_CallFunction( const char *funcname ) {
	if ( weapon ) {
		stateParms_t parms = {0};
		if ( weapon->ProcessState ( funcname, parms ) == SRESULT_ERROR ) {
			gameLocal.Error ( "Unknown function '%s' on entity '%s'", funcname, GetName() );
		}
	}
}

/*
================
rvViewWeapon::SetSkin
================
*/
void rvViewWeapon::SetSkin( const char *skinname ) {
 	const idDeclSkin *skinDecl;
 
 	if ( !skinname || !skinname[ 0 ] ) {
 		skinDecl = NULL;
 	} else {
 		skinDecl = declManager->FindSkin( skinname );
 	}

	SetSkin( skinDecl );
}

void rvViewWeapon::SetSkin( const idDeclSkin* skin ) {
	renderEntity.customSkin = skin;
	UpdateVisuals();

	if( weapon && weapon->GetWorldModel() ) {
		weapon->GetWorldModel()->SetSkin( skin );
	}
}

/*
================
rvViewWeapon::GetPosition
================
*/
void rvViewWeapon::GetPosition( idVec3& origin, idMat3& axis ) const {
	origin = GetPhysics()->GetOrigin();
	axis = GetPhysics()->GetAxis();
}

void rvViewWeapon::SetOverlayShader( const idMaterial* material ) {
	renderEntity.overlayShader = material;
}

/***********************************************************************

  rvWeapon  
	
***********************************************************************/

CLASS_DECLARATION( idClass, rvWeapon )
END_CLASS

/*
================
rvWeapon::rvWeapon
================
*/
rvWeapon::rvWeapon ( void ) {
	viewModel	= NULL;
	worldModel	= NULL;
	weaponDef	= NULL;

	memset ( &animDoneTime, 0, sizeof(animDoneTime) );
	memset ( &wsfl, 0, sizeof(wsfl) );
	memset ( &wfl, 0, sizeof(wfl) );

	idleEffectWorld = NULL;
	fireEffectWorld = NULL;
	idleEffectView = NULL;
	fireEffectView = NULL;

	forceGUIReload = false;

	disguiseClass = INVALID_CLASS;
	disguiseWeapDef = NULL;
}

/*
================
rvWeapon::~rvWeapon
================
*/
rvWeapon::~rvWeapon( void ) {
	int i;
	
	// Free all current light defs
	for ( i = 0; i < WPLIGHT_MAX; i ++ ) {
		FreeLight ( i );
	}
		
	// Disassociate with the view model
	if ( viewModel ) {
		viewModel->weapon = NULL;
	}

	if ( owner && owner->GetHud() ) {
		owner->GetHud()->HandleNamedEvent( "reloadStop" );
	}
}

/*
================
rvWeapon::Init
================
*/
void rvWeapon::Init( idPlayer* _owner, const idDeclEntityDef* def, int _weaponIndex ) {
	viewModel		= _owner->GetWeaponViewModel( );
	worldModel		= _owner->GetWeaponWorldModel( );
	weaponDef		= def; 
	owner			= _owner;
	scriptObject	= &viewModel->scriptObject;
	weaponIndex 	= _weaponIndex;
	
	spawnArgs = weaponDef->dict;
   	
   	// Associate the weapon with the view model
	viewModel->weapon = this;

	disguiseClass = INVALID_CLASS;
	disguiseWeapDef = NULL;

	attackerInfo.Create( _owner );
}

/*
================
rvWeapon::FindViewModelPositionStyle
================
*/
void rvWeapon::FindViewModelPositionStyle( int ui_showGun, idVec3& viewOffset, idAngles& viewAngles ) const {

	/*if ( ui_showGun == 1 ) {
		viewOffset = spawnArgs.GetVector( "viewoffset" );
		viewAngles = spawnArgs.GetAngles( "viewangles" );
	}
	else if ( ui_showGun == 2 ) {
		viewAngles = spawnArgs.GetAngles( "viewangles_left" );
		viewOffset = spawnArgs.GetVector( "viewoffset_left" );
	}
	else if ( ui_showGun == 3 ) {
		viewAngles = spawnArgs.GetAngles( "viewangles_center" );
		viewOffset = spawnArgs.GetVector( "viewoffset_center" );
	}*/
	viewOffset = spawnArgs.GetVector( "viewoffset" );
	viewAngles = spawnArgs.GetAngles( "viewangles" );
}

/*
================
rvWeapon::Spawn
================
*/
void rvWeapon::Spawn ( void ) {
	
	memset ( &wsfl, 0, sizeof(wsfl) );
	memset ( &wfl, 0, sizeof(wfl) );

	

	// Initialize variables

	kick_endtime	= 0;
	hideStart		= 0.0f;
	hideEnd			= 0.0f;
	hideOffset		= 0.0f;
	status			= WP_HOLSTERED;
	lastAttack		= 0;

	guiPercent =	1.0f;

	oldShowWeap = -1;

	// <q4f> 

	raiselower_endtime	= 0;
	raiselower_time		= 0;
	lowerAmount			= 1.0f;

	// </q4f>

	muzzleAxis.Identity();
	muzzleOrigin.Zero();
	pushVelocity.Zero();
	playerViewAxis.Identity();
	playerViewOrigin.Zero();
	viewModelAxis.Identity();
	viewModelOrigin.Zero();

	// View
	viewModelForeshorten = spawnArgs.GetFloat ( "foreshorten", "1" );
	viewModelForeshortenCurrent = viewModelForeshorten;

	FindViewModelPositionStyle( owner ? owner->showWeaponViewModel : 1, viewModelOffset, viewModelAngles );

	lower_weapon_angles	= spawnArgs.GetAngles( "lower_weapon_angles" );
	lower_weapon_offset = spawnArgs.GetVector( "lower_weapon_offset" );

	mtr_crosshair = spawnArgs.GetString( "mtr_crosshair" );
	crossMaterial = declManager->FindMaterial( mtr_crosshair );

	// Offsets
	weaponAngleOffsetAverages	= spawnArgs.GetInt( "weaponAngleOffsetAverages", "10" );
	weaponAngleOffsetScale		= spawnArgs.GetFloat( "weaponAngleOffsetScale", "0.25" );
	weaponAngleOffsetMax		= spawnArgs.GetFloat( "weaponAngleOffsetMax", "10" );
	weaponOffsetTime			= spawnArgs.GetFloat( "weaponOffsetTime", "400" );
	weaponOffsetScale			= spawnArgs.GetFloat( "weaponOffsetScale", "0.005" );

	fireRate	= SEC2MS ( spawnArgs.GetFloat ( "fireRate" ) );

	spread = spawnArgs.GetVec2( "spread", "0 0" );
	nextAttackTime = 0;

	// Attack related values
	muzzle_kick_time	= SEC2MS( spawnArgs.GetFloat( "muzzle_kick_time" ) );
	muzzle_kick_maxtime	= SEC2MS( spawnArgs.GetFloat( "muzzle_kick_maxtime" ) );
	muzzle_kick_angles	= spawnArgs.GetAngles( "muzzle_kick_angles" );
	muzzle_kick_offset	= spawnArgs.GetVector( "muzzle_kick_offset" );

	// General weapon properties
	wfl.hasWindupAnim   = spawnArgs.GetBool( "has_windup", "0" );
	icon				= spawnArgs.GetString( "mtr_icon" );
 	hideTime			= SEC2MS( weaponDef->dict.GetFloat( "hide_time", "0.3" ) );
 	hideDistance		= weaponDef->dict.GetFloat( "hide_distance", "-15" );
 	hideStartTime		= gameLocal.time - hideTime;
 	muzzleOffset		= weaponDef->dict.GetFloat ( "muzzleOffset", "8" );

	// general cache
	spawnArgs.GetVector( "dirOffset", "0 0 0", dirOffset );

	// <q4f> 

	num_attacks			= spawnArgs.GetInt( "num_attacks", "1" );

	// </q4f>

	// Ammo

	ammoRequired		= spawnArgs.GetInt( "ammoRequired" );
	lowAmmo				= spawnArgs.GetInt( "lowAmmo" );
	ammoType			= GetAmmoIndexForName( spawnArgs.GetString( "ammoType" ) );
	maxAmmo				= owner->inventory.MaxAmmoForAmmoClass ( owner, GetAmmoNameForIndex ( ammoType ) );
	
	if ( ( ammoType < 0 ) || ( ammoType >= MAX_AMMO ) ) {
		gameLocal.Warning( "Unknown ammotype for class '%s'", this->GetClassname ( ) );
	}

	// Complex initializations Initialize 
	InitDefs( );
	InitWorldModel( );
	InitViewModel( );
	
	// Requires the view model so must be done after it
	InitLights( );

	viewModel->PostGUIEvent( "weapon_init" );
	viewModel->PostGUIEvent( "weapon_ammo" );
	if ( AmmoInClip() == 0 && AmmoAvailable() == 0 ) {
		viewModel->PostGUIEvent( "weapon_noammo" );
	}

	// <q4f> 

	nextReloadTime = 0;
	if ( ClipSize() > 0 ) {
		reloadTime = SEC2MS( spawnArgs.GetFloat( "reload_time", "0" ) / ClipSize() );
	}
	else {
		reloadTime = 0;
	}

	forceGUIReload = true;

	SetState( 0 );

	// </q4f>
}

/*
================
rvWeapon::InitViewModel
================
*/
void rvWeapon::InitViewModel( void ) {
	const char*			guiName;
	const char*			temp;
	const idKeyValue*	kv;

	// Reset view model to clean state
	viewModel->Clear ( );
	// Make sure the sound handle is initted
	viewModel->refSound.referenceSoundHandle = -1;
	
	// Intialize the weapon guis
	if ( spawnArgs.GetString ( "gui", "", &guiName ) ) {
		int g = 0;
		do {
			viewModel->GetRenderEntity()->gui[g++] = uiManager->FindGui ( guiName, true, false, true );
			guiName = spawnArgs.GetString ( va("gui%d", g + 1 ) );
		} while ( *guiName && viewModel->GetRenderEntity()->gui[g-1] );
	}

	// Set the view models spawn args
	viewModel->spawnArgs = weaponDef->dict;

	viewModel->SetModel( spawnArgs.GetString ( "model_view" ) );

	// Hide surfaces
	for ( kv = spawnArgs.MatchPrefix ( "hidesurface", NULL );
		  kv;
		  kv = spawnArgs.MatchPrefix ( "hidesurface", kv ) ) {
		viewModel->ProcessEvent ( &EV_HideSurface, kv->GetValue() );	
	}

	// find some joints in the model for locating effects
	viewAnimator		= viewModel->GetAnimator ( );
	barrelJointView		= viewAnimator->GetJointHandle( spawnArgs.GetString ( "joint_view_barrel", "barrel" ) );
	flashJointView		= viewAnimator->GetJointHandle( spawnArgs.GetString ( "joint_view_flash", "flash" ) );
	ejectJointView		= viewAnimator->GetJointHandle( spawnArgs.GetString ( "joint_view_eject", "eject" ) );
	guiLightJointView	= viewAnimator->GetJointHandle( spawnArgs.GetString ( "joint_view_guiLight", "guiLight" ) );
	flashlightJointView = viewAnimator->GetJointHandle( spawnArgs.GetString ( "joint_view_flashlight", "flashlight" ) );

	attackJoint0		= viewAnimator->GetJointHandle( spawnArgs.GetString ( "joint_attack_0", "barrel" ) );
	attackJoint1		= viewAnimator->GetJointHandle( spawnArgs.GetString ( "joint_attack_1", "barrel" ) );

	// Eject offset
	spawnArgs.GetVector ( "ejectOffset", "0 0 0", ejectOffset );

	// Setup a skin for the view model
	if ( spawnArgs.GetString ( "skin", "", &temp ) ) {
		viewModel->GetRenderEntity()->customSkin = declManager->FindSkin ( temp );
	}
	
 	// make sure we have the correct skin
 	viewModel->UpdateSkin();
}

/*
================
rvWeapon::InitLights
================
*/
void rvWeapon::InitLights ( void ) {
	const char*		shader;
	idVec4			color;
	renderLight_t*	light;
	
	memset ( lights, 0, sizeof(lights) );
	memset ( lightHandles, -1, sizeof(lightHandles) );
		
	// setup gui light
	light = &lights[WPLIGHT_GUI];
	shader = spawnArgs.GetString( "mtr_guiLightShader", "" );
	if ( shader && *shader && viewModel->GetRenderEntity()->gui[0] ) {
		light->shader = declManager->FindMaterial( shader, false );
		light->lightRadius[0] = light->lightRadius[1] = light->lightRadius[2] = spawnArgs.GetFloat("glightRadius", "3" );
		color = viewModel->GetRenderEntity()->gui[0]->GetLightColor ( );
		light->shaderParms[ SHADERPARM_RED ]	 = color[0] * color[3];
		light->shaderParms[ SHADERPARM_GREEN ] = color[1] * color[3];
		light->shaderParms[ SHADERPARM_BLUE ]	 = color[2] * color[3];
		light->shaderParms[ SHADERPARM_ALPHA ] = 1.0f;
		light->pointLight = true;

// dluetscher: added detail levels to render lights
		light->detailLevel = DEFAULT_LIGHT_DETAIL_LEVEL;
// dluetscher: changed lights to no shadow for performance reasons
		light->noShadows = true;

		light->lightId = WPLIGHT_GUI * 100 + owner->entityNumber;
		light->allowLightInViewID = owner->entityNumber+1;
		spawnArgs.GetVector ( "glightOffset", "0 0 0", guiLightOffset );
	}

	// Muzzle flash
	light = &lights[WPLIGHT_MUZZLEFLASH];
	shader = spawnArgs.GetString( "mtr_flashShader", "muzzleflash" );
	if ( shader && *shader ) {
		light->shader = declManager->FindMaterial( shader, false );
		spawnArgs.GetVec4( "flashColor", "0 0 0 0", color );
		light->shaderParms[ SHADERPARM_RED ]		= color[0];
		light->shaderParms[ SHADERPARM_GREEN ]		= color[1];
		light->shaderParms[ SHADERPARM_BLUE ]		= color[2];
		light->shaderParms[ SHADERPARM_TIMESCALE ]	= 1.0f;
		light->lightRadius[0] = light->lightRadius[1] = light->lightRadius[2] = (float)spawnArgs.GetInt( "flashRadius" );

// dluetscher: added detail levels to render lights
		light->detailLevel = DEFAULT_LIGHT_DETAIL_LEVEL;
// dluetscher: changed lights to no shadow for performance reasons
		light->noShadows = true;

		light->pointLight = spawnArgs.GetBool( "flashPointLight", "1" );
		if ( !light->pointLight ) {
			light->target = spawnArgs.GetVector ( "flashTarget" );
			light->up	  = spawnArgs.GetVector ( "flashUp" );
			light->right  = spawnArgs.GetVector ( "flashRight" );
			light->end    = light->target;
		}
		light->lightId = WPLIGHT_MUZZLEFLASH * 100 + owner->entityNumber;
		light->allowLightInViewID = owner->entityNumber+1;
		muzzleFlashTime	= SEC2MS( spawnArgs.GetFloat( "flashTime", "0.25" ) );
		muzzleFlashEnd = 0;
		spawnArgs.GetVector ( "flashViewOffset", "0 0 0", muzzleFlashViewOffset );	
	}

	// the world muzzle flash is the same, just positioned differently
	lights[WPLIGHT_MUZZLEFLASH_WORLD] = lights[WPLIGHT_MUZZLEFLASH];
	light = &lights[WPLIGHT_MUZZLEFLASH_WORLD];
	light->suppressLightInViewID = owner->entityNumber+1;
	light->allowLightInViewID = 0;
	light->lightId = WPLIGHT_MUZZLEFLASH_WORLD * 100 + owner->entityNumber;

	// flashlight	
	light = &lights[WPLIGHT_FLASHLIGHT];
	shader = spawnArgs.GetString( "mtr_flashlightShader", "lights/muzzleflash" );
	if ( shader && *shader ) {
		light->shader	  = declManager->FindMaterial( shader, false );
		spawnArgs.GetVec4( "flashlightColor", "0 0 0 0", color );
		light->shaderParms[ SHADERPARM_RED ]			= color[0];
		light->shaderParms[ SHADERPARM_GREEN ]			= color[1];
		light->shaderParms[ SHADERPARM_BLUE ]			= color[2];
		light->shaderParms[ SHADERPARM_TIMESCALE ]		= 1.0f;
		light->lightRadius[0] = light->lightRadius[1] = light->lightRadius[2] =
			(float)spawnArgs.GetInt( "flashlightRadius" );

// dluetscher: added detail levels to render lights
		light->detailLevel = DEFAULT_LIGHT_DETAIL_LEVEL;
// dluetscher: changed lights to no shadow for performance reasons
		light->noShadows = cvarSystem->GetCVarInteger("com_machineSpec") < 3;

		light->pointLight = spawnArgs.GetBool( "flashlightPointLight", "1" );
		if ( !light->pointLight ) {
			light->target	= spawnArgs.GetVector( "flashlightTarget" );
			light->up		= spawnArgs.GetVector( "flashlightUp" );
			light->right	= spawnArgs.GetVector( "flashlightRight" );
			light->end		= light->target;
		}
		
		light->allowLightInViewID = owner->entityNumber+1;
		light->lightId = WPLIGHT_FLASHLIGHT * 100 + owner->entityNumber;
		spawnArgs.GetVector ( "flashlightViewOffset", "0 0 0", flashlightViewOffset );	
	}

	// the world muzzle flashlight is the same, just positioned differently
	lights[WPLIGHT_FLASHLIGHT_WORLD] = lights[WPLIGHT_FLASHLIGHT];
	light = &lights[WPLIGHT_FLASHLIGHT_WORLD];
	light->suppressLightInViewID = owner->entityNumber+1;
	light->allowLightInViewID = 0;
	light->lightId = WPLIGHT_FLASHLIGHT_WORLD * 100 + owner->entityNumber; 	
}

/*
================
rvWeapon::InitDefs
================
*/
void rvWeapon::InitDefs( void ) {
	const char*				name;
	const char*				spawnclass;
	idTypeInfo*				cls;

	attackDef = NULL;

	// Projectile
	if ( spawnArgs.GetString( "def_projectile", "", &name ) && *name ) {
		attackDef = gameLocal.FindEntityDef( name, false );
		if ( !attackDef ) {
			gameLocal.Error( "Unknown projectile '%s' for weapon '%s'", name, weaponDef->GetName() );
		} else {
			spawnclass = attackDef->dict.GetString( "spawnclass" );
			cls		   = idClass::GetClass( spawnclass );
			if ( !cls || !cls->IsType( idProjectile::GetClassType() ) ) {
				gameLocal.Error( "Invalid spawnclass '%s' for projectile '%s' (used by weapon '%s')", spawnclass, name, weaponDef->GetName ( ) );
			}
		}
	} else if ( spawnArgs.GetString( "def_hitscan", "", &name ) && *name ) {
		attackDef = gameLocal.FindEntityDef( name, false );
		if ( !attackDef ) {
			gameLocal.Error( "Unknown hitscan '%s' for weapon '%s'", name, weaponDef->GetName ( ) );
		}
		wfl.attackHitscan = true;
	} 
	else if ( spawnArgs.GetString( "def_melee", "", &name ) && *name ) {
		attackDef = gameLocal.FindEntityDef( name, false );
		if ( !attackDef ) {
			gameLocal.Error( "Unknown melee '%s' for weapon '%s'", name, weaponDef->GetName() );
		}
	}
	
	if ( !attackDef ) {
		gameLocal.Error( "Weapon '%s' does not specify a projectile, hitscan, or melee def.", weaponDef->GetName() );
	}

	fxOriginOffset = attackDef->dict.GetVector( "fxOriginOffset" );

	// get the melee damage def
	meleeDistance = spawnArgs.GetFloat( "melee_distance" );

	// get the brass def
	const idDeclEntityDef* brassDef = NULL;
	brassDict.Clear();
	if ( spawnArgs.GetString( "def_ejectBrass", "", &name ) && *name ) {
		brassDef = gameLocal.FindEntityDef( name, false );
		if ( !brassDef ) {
			gameLocal.Warning( "Unknown brass def '%s' for weapon '%s'", name, weaponDef->GetName() );
		} else {
			brassDict = brassDef->dict;
			brassDict.Set( "spawnclass", "rvClientMoveable" );
		}
	}
}

/*
================
rvWeapon::Think
================
*/
void rvWeapon::Think ( void ) {	

	assert( owner );
	
	// Cache the player origin and axis
	playerViewOrigin = owner->firstPersonViewOrigin;
	playerViewAxis = owner->firstPersonViewAxis;

	/*if ( owner->showWeaponViewModel != oldShowWeap ) {
		FindViewModelPositionStyle( owner->showWeaponViewModel, viewModelOffset, viewModelAngles );
	}
	oldShowWeap = owner->showWeaponViewModel;*/

	// calculate weapon position based on player movement bobbing
	owner->CalculateViewWeaponPos( viewModelOrigin, viewModelAxis );

	// hide offset is for dropping the gun when approaching a GUI or NPC
	// This is simpler to manage than doing the weapon put-away animation
 	/*if ( gameLocal.time - hideStartTime < hideTime ) {		
 		float frac = ( float )( gameLocal.time - hideStartTime ) / ( float )hideTime;
 		if ( hideStart < hideEnd ) {
 			frac = 1.0f - frac;
 			frac = 1.0f - frac * frac;
 		} else {
 			frac = frac * frac;
 		}
		hideOffset = hideStart + ( hideEnd - hideStart ) * frac;
	} else {
		hideOffset = hideEnd;
	}
	viewModelOrigin += hideOffset * viewModelAxis[ 2 ];*/

	// kick up based on repeat firing
	if ( lowerAmount <= 0.0f ) {
		MuzzleRise( viewModelOrigin, viewModelAxis );
	}
	else {
		WeaponRaiseLower( viewModelOrigin, viewModelAxis );
	}

	if ( viewModel ) {
		// set the physics position and orientation
		viewModel->GetPhysics()->SetOrigin( viewModelOrigin );
		viewModel->GetPhysics()->SetAxis( viewModelAxis );
 		viewModel->UpdateVisuals();
	} else {
		common->Warning( "NULL viewmodel %s\n", __FUNCTION__ );
	}

	// Only update the state loop on new frames
 	if ( gameLocal.isNewFrame ) {
		UpdateState();
	}

	if ( viewModel ) {
		viewModel->UpdateAnimation( );
	}

	// Clear reload and flashlight flags
	//wsfl.reload		= false;
	
	// deal with the third-person visible world model 
	// don't show shadows of the world model in first person
	if ( worldModel && worldModel->GetRenderEntity() ) {
		// always show your own weapon
		if( owner->entityNumber == gameLocal.localClientNum ) {
			worldModel->GetRenderEntity()->suppressLOD = 1;
		} else {
			worldModel->GetRenderEntity()->suppressLOD = 0;
		}

		if ( gameLocal.IsMultiplayer() && g_skipPlayerShadowsMP.GetBool() ) {
			// Disable all weapon shadows for the local client
			worldModel->GetRenderEntity()->suppressShadowInViewID	= gameLocal.localClientNum+1;
			worldModel->GetRenderEntity()->suppressShadowInLightID = WPLIGHT_MUZZLEFLASH * 100 + owner->entityNumber;
		} else if ( gameLocal.isMultiplayer || g_showPlayerShadow.GetBool() || pm_thirdPerson.GetBool() ) {
			// Show all weapon shadows
			worldModel->GetRenderEntity()->suppressShadowInViewID	= 0;
		} else {
			// Only show weapon shadows for other clients
			worldModel->GetRenderEntity()->suppressShadowInViewID	= owner->entityNumber+1;
			worldModel->GetRenderEntity()->suppressShadowInLightID = WPLIGHT_MUZZLEFLASH * 100 + owner->entityNumber;
		}
	}

	UpdateGUI();

	// Update lights
	//UpdateFlashlight ( );
	UpdateMuzzleFlash ( );

	// update the gui light
	renderLight_t& light = lights[WPLIGHT_GUI];
	if ( light.lightRadius[0] && guiLightJointView != INVALID_JOINT ) {
		if ( viewModel ) {
			idVec4 color = viewModel->GetRenderEntity()->gui[0]->GetLightColor ( );
			light.shaderParms[ SHADERPARM_RED ]	  = color[0] * color[3];
			light.shaderParms[ SHADERPARM_GREEN ] = color[1] * color[3];
			light.shaderParms[ SHADERPARM_BLUE ]  = color[2] * color[3];
			GetGlobalJointTransform( true, guiLightJointView, light.origin, light.axis, guiLightOffset );		
			UpdateLight ( WPLIGHT_GUI );
		} else {
			common->Warning( "NULL viewmodel %s\n", __FUNCTION__ );
		}
	}

	// make sure our clip isn't larger than our ammo count
	int ammoAvail = AmmoAvailable();
	if ( AmmoInClip() > ammoAvail && owner ) {
		owner->inventory.clip[weaponIndex] = ammoAvail;
	}
}

/*
================
rvWeapon::InitWorldModel
================
*/
void rvWeapon::InitWorldModel() {
	idEntity *ent;

	ent = worldModel;
	if ( !ent ) {
		gameLocal.Warning ( "InitWorldModel failed due to missing entity" );
		return;
	}

	const char *model = NULL;
	const char *attach = NULL;
	disguiseWeapDef = NULL;
	disguiseClass = owner ? owner->disguiseClass : INVALID_CLASS;

	if ( disguiseClass != INVALID_CLASS ) {
		int fakeWeapon = weaponIndex;
		ENTDEF disguiseDef = tfGame.GetClassEntDef( disguiseClass );
		idStr disgWeap;

		while ( !disguiseDef->dict.GetString( va( "def_weapon%d", fakeWeapon ), "", disgWeap ) || !disgWeap[0] ) {
			fakeWeapon--;

			if ( fakeWeapon < 0 )
				gameLocal.Error( "Could not find fake weapon index for spy..." );
		}

		assert( disgWeap[0] );

		disguiseWeapDef = gameLocal.FindEntityDef( disgWeap.c_str(), false );
		
		if ( !disguiseWeapDef )
			gameLocal.Error( "Could not find the fake weapon def for spy..." );

		model = disguiseWeapDef->dict.GetString( "model_world" );
		attach = disguiseWeapDef->dict.GetString( "joint_attach" );
	}
	else {
		model = spawnArgs.GetString( "model_world" );
		attach = spawnArgs.GetString( "joint_attach" );
	}

	if ( model[0] && attach[0] ) {
		ent->Show();
		ent->SetModel( model );
		ent->GetPhysics()->SetContents( 0 );
		ent->GetPhysics()->SetClipModel( NULL, 1.0f );
		ent->BindToJoint( owner, attach, true );
		ent->GetPhysics()->SetOrigin( vec3_origin );
		ent->GetPhysics()->SetAxis( mat3_identity );

		// supress model in player views, but allow it in mirrors and remote views
		renderEntity_t *worldModelRenderEntity = ent->GetRenderEntity();
		if ( worldModelRenderEntity ) {
			worldModelRenderEntity->suppressSurfaceInViewID = owner->entityNumber+1;
			worldModelRenderEntity->suppressShadowInViewID = owner->entityNumber+1;
			worldModelRenderEntity->suppressShadowInLightID = WPLIGHT_MUZZLEFLASH * 100 + owner->entityNumber;
		}
	} else {
		ent->SetModel( "" );
		ent->Hide();
	}

	// the renderEntity is reused, so the relevant fields (except this one) appear to be correctly reinitialized
	worldModel->GetRenderEntity()->suppressSurfaceMask = 0;

	worldModel->spawnArgs = weaponDef->dict;

	// Cache the world joints
	worldAnimator			= ent->GetAnimator ( );
	flashJointWorld			= worldAnimator->GetJointHandle ( spawnArgs.GetString ( "joint_world_flash", "flash" ) );
	flashlightJointWorld	= worldAnimator->GetJointHandle ( spawnArgs.GetString ( "joint_world_flashlight", "flashlight" ) );
	ejectJointWorld			= worldAnimator->GetJointHandle ( spawnArgs.GetString ( "joint_world_eject", "eject" ) );
}

/*
================
rvWeapon::UpdateLight
================
*/
void rvWeapon::UpdateLight ( int lightID ) {
	if ( lightHandles[lightID] == -1 ) {
		lightHandles[lightID] = gameRenderWorld->AddLightDef ( &lights[lightID] );
	} else {
		gameRenderWorld->UpdateLightDef( lightHandles[lightID], &lights[lightID] );
	}
}

/*
================
rvWeapon::FreeLight
================
*/
void rvWeapon::FreeLight ( int lightID ) {
	if ( lightHandles[lightID] != -1 ) {
		gameRenderWorld->FreeLightDef( lightHandles[lightID] );
		lightHandles[lightID] = -1;
	}
}


/***********************************************************************

	Networking

***********************************************************************/

/*
================
rvWeapon::WriteToSnapshot
================
*/
void rvWeapon::WriteToSnapshot( idBitMsgDelta &msg ) const {
	msg.WriteBits( AmmoInClip(), ASYNC_PLAYER_INV_AMMO_BITS );
}

/*
================
rvWeapon::ReadFromSnapshot
================
*/
void rvWeapon::ReadFromSnapshot( const idBitMsgDelta &msg ) {
	int ammoClip = msg.ReadBits( ASYNC_PLAYER_INV_AMMO_BITS );
	if ( owner )
		owner->inventory.clip[weaponIndex] = ammoClip;
}

/*
================
rvWeapon::SkipFromSnapshot
================
*/
void rvWeapon::SkipFromSnapshot ( const idBitMsgDelta &msg ) {
	msg.ReadBits( ASYNC_PLAYER_INV_AMMO_BITS );
}

/*
================
rvWeapon::ClientStale
================
*/
void rvWeapon::ClientStale( void ) {
}

/*
================
rvWeapon::ClientReceiveEvent
================
*/
bool rvWeapon::ClientReceiveEvent( int event, int time, const idBitMsg &msg ) {
 	switch( event ) {
 		case EVENT_RELOAD: {
 			if ( gameLocal.time - time < 1000 ) {
 				wsfl.netReload	 = true;
 				wsfl.netEndReload = false;
 			}
 			return true;
 		}
 		case EVENT_ENDRELOAD: {
			wsfl.netEndReload = true;
 			return true;
 		}
 		case EVENT_CHANGESKIN: {
/*
			// FIXME: use idGameLocal::ReadDecl
 			int index = msg.ReadLong();
 			renderEntity.customSkin = ( index != -1 ) ? static_cast<const idDeclSkin *>( declManager->DeclByIndex( DECL_SKIN, index ) ) : NULL;
 			UpdateVisuals();
 			if ( worldModel.GetEntity() ) {
 				worldModel.GetEntity()->SetSkin( renderEntity.customSkin );
 			}
 */
 			return true;
 		}
 	}
 	return false;
}

/***********************************************************************

	Save / Load

***********************************************************************/

/*
================
rvWeapon::Save
================
*/
void rvWeapon::Save ( idSaveGame *savefile ) const {
}

/*
================
rvWeapon::Restore
================
*/
void rvWeapon::Restore ( idRestoreGame *savefile ) {
}

/***********************************************************************

	State control/player interface

***********************************************************************/

/*
================
rvWeapon::Hide
================
*/
void rvWeapon::Hide( void ) {
 	muzzleFlashEnd = 0;

	if ( viewModel ) {
		viewModel->Hide();
	}
	if ( worldModel ) {
		worldModel->Hide ( );
	}

	// Stop flashlight and gui lights
	FreeLight ( WPLIGHT_GUI );
	FreeLight ( WPLIGHT_FLASHLIGHT );
	FreeLight ( WPLIGHT_FLASHLIGHT_WORLD );
}

/*
================
rvWeapon::Show
================
*/
void rvWeapon::Show ( void ) {
	if ( viewModel ) {
		viewModel->Show();
	}
	if ( worldModel ) {
		worldModel->Show();
	}
}

/*
================
rvWeapon::IsHidden
================
*/
bool rvWeapon::IsHidden( void ) const {
	return !viewModel || viewModel->IsHidden();
}

/*
================
rvWeapon::HideWorldModel
================
*/
void rvWeapon::HideWorldModel ( void ) {
	if ( worldModel ) {
		worldModel->Hide();
	}
}

/*
================
rvWeapon::ShowWorldModel
================
*/
void rvWeapon::ShowWorldModel ( void ) {
	if ( worldModel ) {
		worldModel->Show();
	}
}


/*
================
rvWeapon::LowerWeapon
================
*/
void rvWeapon::LowerWeapon( void ) {
	if ( !wfl.hide ) {
		hideStart	= 0.0f;
		hideEnd		= hideDistance;
 		if ( gameLocal.time - hideStartTime < hideTime ) {
 			hideStartTime = gameLocal.time - ( hideTime - ( gameLocal.time - hideStartTime ) );
   		} else {
 			hideStartTime = gameLocal.time;
		}
		wfl.hide = true;
	}
}

/*
================
rvWeapon::RaiseWeapon
================
*/
void rvWeapon::RaiseWeapon( void ) {
	if ( !viewModel ) {
		common->Warning( "NULL viewmodel %s\n", __FUNCTION__ );
		return;
	}
	
	viewModel->Show();

	if ( forceGUIReload ) {
 		forceGUIReload = false;
 		int ammo = AmmoInClip();
 		for ( int g = 0; g < MAX_RENDERENTITY_GUI && viewModel->GetRenderEntity()->gui[g]; g ++ ) {
			idUserInterface* gui = viewModel->GetRenderEntity()->gui[g];
 			if ( gui ) {
				gui->SetStateInt ( "player_ammo", ammo );
				
				if ( ClipSize ( ) ) {
					gui->SetStateFloat ( "player_ammopct", (float)ammo / (float)ClipSize() );
					gui->SetStateInt ( "player_clip_size", ClipSize() );
				} else { 
					gui->SetStateFloat ( "player_ammopct", (float)ammo / (float)maxAmmo );
					gui->SetStateInt ( "player_clip_size", maxAmmo );
				}
				gui->SetStateInt ( "player_cachedammo", ammo );
				gui->HandleNamedEvent ( "weapon_ammo" );
 			}
 		}
	}

	if ( wfl.hide ) {
 		hideStart	= hideDistance;
		hideEnd		= 0.0f;
 		if ( gameLocal.time - hideStartTime < hideTime ) {
 			hideStartTime = gameLocal.time - ( hideTime - ( gameLocal.time - hideStartTime ) );
   		} else {
 			hideStartTime = gameLocal.time;
		}
		wfl.hide = false;
	}
}

/*
================
rvWeapon::PutAway
================
*/
void rvWeapon::PutAway( void ) {
	wfl.hasBloodSplat  = false;
	wsfl.lowerWeapon   = true;

	if ( !viewModel ) {
		common->Warning( "NULL viewmodel %s\n", __FUNCTION__ );
		return;
	}
	viewModel->PostGUIEvent ( "weapon_lower" );
}

/*
================
rvWeapon::Raise
================
*/
void rvWeapon::Raise( void ) {
	wsfl.raiseWeapon = true;

	if ( !viewModel ) {
		common->Warning( "NULL viewmodel %s\n", __FUNCTION__ );
		return;
	}
	viewModel->PostGUIEvent ( "weapon_raise" );
}

/*
================
rvWeapon::SetPushVelocity
================
*/
void rvWeapon::SetPushVelocity( const idVec3& _pushVelocity ) {
	pushVelocity = _pushVelocity;
}

/*
================
rvWeapon::Reload
NOTE: this is only for impulse-triggered reload, auto reload is scripted
================
*/
void rvWeapon::Reload( void ) {
	//gameLocal.mpGame.AddChatLine("Clip Size: %d  Ammo Available: %d  Ammo In Clip: %d\n", ClipSize(), AmmoInClip(), AmmoInClip() );
	if ( wsfl.reload == true || wsfl.reloading == true )
		return;
	if ( AmmoAvailable() == AmmoInClip() )		// don't reload if you dont have enough ammo
		return;

	if ( ClipSize() > 0 ) {
		//SetState ( WEAP_STATE_LOWER );	// xavior: fix the lack of gun lowering anim?
		if ( AmmoInClip() == ClipSize() )
			return;
		SetStage( 0 );		// 0 = STAGE_INIT
		SetState ( WEAP_STATE_RELOAD );
	//wsfl.reload = true;
	}
}

/*
================
rvWeapon::CancelReload
================
*/
void rvWeapon::CancelReload( void ) {
	wsfl.attack = true;
}

/*
================
rvWeapon::AutoReload
================
*/
bool rvWeapon::AutoReload ( void ) {

 	// on a network client, never predict reloads of other clients. wait for the server
 	if ( gameLocal.isClient ) {
 		return false;
 	}
	assert( owner );

	return owner->uiAutoReload;
}

/*
================
rvWeapon::NetReload
================
*/
void rvWeapon::NetReload ( void ) {
	if ( gameLocal.isServer ) {
		assert( owner );

		if ( !viewModel ) {
			common->Warning( "NULL viewmodel %s\n", __FUNCTION__ );
			return;
		}
		viewModel->ServerSendEvent( EVENT_RELOAD, NULL, false, -1 );
	}
}

/*
===============
rvWeapon::NetEndReload
===============
*/
void rvWeapon::NetEndReload ( void ) {
	if ( gameLocal.isServer ) {
		assert( owner );

		if ( !viewModel ) {
			common->Warning( "NULL viewmodel %s\n", __FUNCTION__ );
			return;
		}
		viewModel->ServerSendEvent( EVENT_ENDRELOAD, NULL, false, -1 );
	}
}   

/*
================
rvWeapon::SetStatus
================
*/
void rvWeapon::SetStatus ( weaponStatus_t _status ) {
	if ( status == WP_RELOAD && owner && owner->hud ) {
		owner->hud->HandleNamedEvent( "reloadStop" );
	}

	status = _status;
	switch ( status ) {
		case WP_READY:			
			wsfl.raiseWeapon = false;
			if ( !viewModel ) {
				common->Warning( "NULL viewmodel %s\n", __FUNCTION__ );
				break;
			}
			viewModel->PostGUIEvent ( "weapon_ready" );
			break;
		case WP_OUTOFAMMO:
			wsfl.raiseWeapon = false;
			break;		
		case WP_RELOAD:
			if ( !viewModel ) {
				common->Warning( "NULL viewmodel %s\n", __FUNCTION__ );
				break;
			}
			if ( owner && owner->hud )
				owner->hud->HandleNamedEvent( "reloadStart" );
			viewModel->PostGUIEvent ( "weapon_reload" );
			break;
		case WP_HOLSTERED:
		case WP_RISING:
			wsfl.lowerWeapon = false;
			assert( owner );
		 	owner->WeaponRisingCallback();
			break;
		case WP_LOWERING:
			wsfl.raiseWeapon = false;
			assert( owner );
		 	owner->WeaponLoweringCallback();
			break;
	}
}

/*
================
rvWeapon::OwnerDied
================
*/
void rvWeapon::OwnerDied( void ) {

	CleanupWeapon();

	if ( owner && owner->GetHud() ) {
		owner->GetHud()->HandleNamedEvent( "reloadStop" );
	}

	if( viewModel ) {
		viewModel->StopSound( SND_CHANNEL_BODY, false );
		viewModel->StopSound( SND_CHANNEL_AMBIENT, false );
		viewModel->StopSound( SND_CHANNEL_WEAPON, false );
		viewModel->StopSound( SCHANNEL_ANY, false );
		viewModel->StopAllEffects ( );
		viewModel->Hide();
	}
	if ( worldModel ) {
		worldModel->Hide();
	}
}

/*
================
rvWeapon::BeginAttack
================
*/
void rvWeapon::BeginAttack( void ) {
	wsfl.attack = true;

	if ( status != WP_OUTOFAMMO ) {
		lastAttack = gameLocal.time;
	}
}

/*
================
rvWeapon::EndAttack
================
*/
void rvWeapon::EndAttack( void ) {
	wsfl.attack = false;
}

/*
================
rvWeapon::isReady
================
*/
bool rvWeapon::IsReady( void ) const {
	return !wfl.hide && !(gameLocal.time - hideStartTime < hideTime) && (viewModel && !viewModel->IsHidden()) && ( ( status == WP_READY ) || ( status == WP_OUTOFAMMO ) );
}

/*
================
rvWeapon::IsReloading
================
*/
bool rvWeapon::IsReloading( void ) const {
	return ( status == WP_RELOAD );
}

/*
================
rvWeapon::IsHolstered
================
*/
bool rvWeapon::IsHolstered( void ) const {
	return ( status == WP_HOLSTERED );
}

/*
================
rvWeapon::ShowCrosshair
================
*/
bool rvWeapon::ShowCrosshair( void ) const {
	return !( status == WP_HOLSTERED );
}

/***********************************************************************

	Visual presentation

***********************************************************************/

/*
================
rvWeapon::MuzzleRise
================
*/
void rvWeapon::MuzzleRise( idVec3 &origin, idMat3 &axis ) {
	int			time;
	float		amount;
	idAngles	ang;
	idVec3		offset;

	time = kick_endtime - gameLocal.time;
	if ( time <= 0 ) {
		return;
	}

	if ( muzzle_kick_maxtime <= 0 ) {
		return;
	}

	if ( time > muzzle_kick_maxtime ) {
		time = muzzle_kick_maxtime;
	}
	
	amount = ( float )time / ( float )muzzle_kick_maxtime;
	ang		= muzzle_kick_angles * amount;
	offset	= muzzle_kick_offset * amount;

	origin = origin - axis * offset;
	axis = ang.ToMat3() * axis;
}


//--------------------------------------------------------------------------
// For weapon raising / lowering ( weapon switch & reload )
//--------------------------------------------------------------------------
void rvWeapon::WeaponRaiseLower( idVec3 &origin, idMat3 &axis ) {
	idAngles	ang;
	idVec3		offset;

	ang		= lower_weapon_angles * lowerAmount;
	offset	= lower_weapon_offset * lowerAmount;

	origin = origin - axis * offset;
	axis = ang.ToMat3() * axis;
}

/*
================
rvWeapon::UpdateFlashPosition
================
*/
void rvWeapon::UpdateMuzzleFlash ( void ) {
	// remove the muzzle flash light when it's done
	if ( gameLocal.time >= muzzleFlashEnd || !gameLocal.GetLocalPlayer() || !owner ) {
		FreeLight ( WPLIGHT_MUZZLEFLASH );
		FreeLight ( WPLIGHT_MUZZLEFLASH_WORLD );
		return;
	}

	renderLight_t& light	  = lights[WPLIGHT_MUZZLEFLASH];
	renderLight_t& lightWorld = lights[WPLIGHT_MUZZLEFLASH_WORLD];

	light.origin = playerViewOrigin + (playerViewAxis * muzzleFlashViewOffset);
	light.axis = playerViewAxis;

	// put the world muzzle flash on the end of the joint, no matter what
	GetGlobalJointTransform( false, flashJointWorld, lightWorld.origin, lightWorld.axis );

	UpdateLight ( WPLIGHT_MUZZLEFLASH );
	UpdateLight ( WPLIGHT_MUZZLEFLASH_WORLD );
}

/*
================
rvWeapon::UpdateFlashlight
================
*/
void rvWeapon::UpdateFlashlight ( void ) {
	return;

	/*
	assert( owner );

	// Turn flashlight off?
	if (! owner->IsFlashlightOn ( ) ) {
		FreeLight ( WPLIGHT_FLASHLIGHT );
		FreeLight ( WPLIGHT_FLASHLIGHT_WORLD );
		return;
	}

	renderLight_t& light	  = lights[WPLIGHT_FLASHLIGHT];
	renderLight_t& lightWorld = lights[WPLIGHT_FLASHLIGHT_WORLD];
	trace_t	tr;

	// the flash has an explicit joint for locating it
	GetGlobalJointTransform( true, flashlightJointView, light.origin, light.axis, flashlightViewOffset );

	// if the desired point is inside or very close to a wall, back it up until it is clear
	gameLocal.clip.TracePoint( tr, light.origin - playerViewAxis[0] * 8.0f, light.origin, MASK_SHOT_BOUNDINGBOX, owner );

	// be at least 8 units away from a solid
	light.origin = tr.endpos - (tr.fraction < 1.0f ? (playerViewAxis[0] * 8) : vec3_origin);

	// put the world muzzle flash on the end of the joint, no matter what
	if ( flashlightJointWorld != INVALID_JOINT ) {
		GetGlobalJointTransform( false, flashlightJointWorld, lightWorld.origin, lightWorld.axis );
	} else {
		lightWorld.origin = playerViewOrigin + playerViewAxis[0] * 20.0f;
		lightWorld.axis = playerViewAxis;
	}

	UpdateLight ( WPLIGHT_FLASHLIGHT );
	UpdateLight ( WPLIGHT_FLASHLIGHT_WORLD );*/
}

/*
================
rvWeapon::MuzzleFlash
================
*/
void rvWeapon::MuzzleFlash ( void ) {
	renderLight_t& light	  = lights[WPLIGHT_MUZZLEFLASH];
	renderLight_t& lightWorld = lights[WPLIGHT_MUZZLEFLASH_WORLD];

	if ( !g_muzzleFlash.GetBool() || flashJointView == INVALID_JOINT || !light.lightRadius[0] || q4f_ambientLighting.GetBool() ) {
		return;
	}

	/*if ( g_perfTest_weaponNoFX.GetBool() ) {
		return;
	}*/

	if ( viewModel ) {
		// these will be different each fire
		light.shaderParms[ SHADERPARM_TIMEOFFSET ]	= -MS2SEC( gameLocal.time );
		light.shaderParms[ SHADERPARM_DIVERSITY ]	= viewModel->GetRenderEntity()->shaderParms[ SHADERPARM_DIVERSITY ];
		light.noShadows = true;

		lightWorld.shaderParms[ SHADERPARM_TIMEOFFSET ]	= -MS2SEC( gameLocal.time );
		lightWorld.shaderParms[ SHADERPARM_DIVERSITY ]	= viewModel->GetRenderEntity()->shaderParms[ SHADERPARM_DIVERSITY ];
		lightWorld.noShadows = true;

		// the light will be removed at this time
		muzzleFlashEnd = gameLocal.time + muzzleFlashTime;
	} else {
		common->Warning( "NULL viewmodel %s\n", __FUNCTION__ );
	}
	UpdateMuzzleFlash ( );
}


/*
================
rvWeapon::UpdateGUI
================
*/
void rvWeapon::UpdateGUI ( void ) {
	idUserInterface* gui;

	assert( owner );
	
	if ( !viewModel ) {
		common->Warning( "NULL viewmodel %s\n", __FUNCTION__ );
		return;
	}
	
	gui = viewModel->GetRenderEntity()->gui[0];
	if ( !gui || status == WP_HOLSTERED ) {
		return;
	}
	int g;

for ( g = 0; g < MAX_RENDERENTITY_GUI && viewModel->GetRenderEntity()->gui[g]; g ++ ) {
	gui = viewModel->GetRenderEntity()->gui[g];

   	if ( gameLocal.localClientNum != owner->entityNumber ) {
		// if updating the hud for a followed client
		if ( gameLocal.localClientNum >= 0 && gameLocal.entities[ gameLocal.localClientNum ] && gameLocal.entities[ gameLocal.localClientNum ]->IsType( idPlayer::GetClassType() ) ) {
			idPlayer *p = static_cast< idPlayer * >( gameLocal.entities[ gameLocal.localClientNum ] );
			if ( !p->spectating || p->spectator != owner->entityNumber ) {
				return;
			}
		} else {
			return;
		}
	}

	int ammo = AmmoInClip();
	if ( ammo >= 0 ) {
		// show remaining ammo
		if ( gui->State().GetInt ( "player_cachedammo", "-1") != ammo ) {
			gui->SetStateInt ( "player_ammo", ammo );
			
			if ( ClipSize ( ) ) {
				gui->SetStateFloat ( "player_ammopct", (float)ammo / (float)ClipSize() );
				gui->SetStateInt ( "player_clip_size", ClipSize() );
			} else { 
				gui->SetStateFloat ( "player_ammopct", (float)ammo / (float)maxAmmo );
				gui->SetStateInt ( "player_clip_size", maxAmmo );
			}
			gui->SetStateInt ( "player_cachedammo", ammo );
			gui->HandleNamedEvent ( "weapon_ammo" );
		}	
	}

	gui->SetStateFloat( "guiPercent", guiPercent );

	//gui->Redraw( gameLocal.time );

//		viewModel->GetRenderEntity()->gui[g]->SetStateInt ( "player_clip_size", ClipSize() );
}
	for ( int i = 0; i < viewModel->pendingGUIEvents.Num(); i ++ ) {
		gui->HandleNamedEvent( viewModel->pendingGUIEvents[i] );
	}
	viewModel->pendingGUIEvents.Clear();
}

/*
================
rvWeapon::UpdateCrosshairGUI
================
*/
void rvWeapon::UpdateCrosshairGUI( idUserInterface* gui ) const {	

// cnicholson: Added support for universal crosshair
	assert( gui );

	
	if ( g_crosshairCustom.GetBool() ) {										// If there's a custom crosshair, use it.

		const char* customFile = g_crosshairCustomFile.GetString();
		gui->SetStateString( "crossImage", customFile );

		const idMaterial *material = declManager->FindMaterial( customFile );
		if ( material ) {
			material->SetSort( SS_GUI );
		}

	} else {
		gui->SetStateString( "crossImage", mtr_crosshair );

		if ( crossMaterial ) {
			crossMaterial->SetSort( SS_GUI );
		}			
	}

	gui->SetStateString( "crossColor", g_crosshairColor.GetString() );
	//gui->SetStateInt( "crossOffsetX", spawnArgs.GetInt( "crosshairOffsetX", "0" ) );
	//gui->SetStateInt( "crossOffsetY", spawnArgs.GetInt( "crosshairOffsetY", "0" ) );
 	gui->StateChanged( gameLocal.time );
}

/*
================
rvWeapon::ForeshortenAxis
================
*/
idMat3 rvWeapon::ForeshortenAxis( const idMat3& axis ) const {
	return idMat3( axis[0] * viewModelForeshortenCurrent, axis[1], axis[2] );
}

/*
================
rvWeapon::GetAngleOffsets
================
*/
void rvWeapon::GetAngleOffsets ( int *average, float *scale, float *max ) {
	*average = weaponAngleOffsetAverages;
	*scale = weaponAngleOffsetScale;
	*max = weaponAngleOffsetMax;
}

/*
================
rvWeapon::GetTimeOffsets
================
*/
void rvWeapon::GetTimeOffsets ( float *time, float *scale ) {
	*time = weaponOffsetTime;
	*scale = weaponOffsetScale;
}

/*
================
rvWeapon::GetGlobalJointTransform

This returns the offset and axis of a weapon bone in world space, suitable for attaching models or lights
================
*/
bool rvWeapon::GetGlobalJointTransform ( bool view, const jointHandle_t jointHandle, idVec3 &origin, idMat3 &axis, const idVec3& offset ) {
	if ( view) {
		// view model
		if ( viewModel && viewAnimator->GetJointTransform( jointHandle, gameLocal.time, origin, axis ) ) {
			origin = offset * axis + origin;
			origin = origin * ForeshortenAxis(viewModelAxis) + viewModelOrigin;
			axis = axis * viewModelAxis;
			return true;
		}
	} else {
		// world model
		if ( worldModel && worldAnimator->GetJointTransform( jointHandle, gameLocal.time, origin, axis ) ) {
			origin = offset * axis + origin;
			origin = worldModel->GetPhysics()->GetOrigin() + origin * worldModel->GetPhysics()->GetAxis();
			axis = axis * worldModel->GetPhysics()->GetAxis();
			return true;
		}
	}
	origin = viewModelOrigin + offset * viewModelAxis;
	axis   = viewModelAxis;
	return false;
}

/***********************************************************************

	Ammo

***********************************************************************/

/*
================
rvWeapon::GetAmmoIndexForName
================
*/
int rvWeapon::GetAmmoIndexForName( const char *ammoname ) {
	int num;

	if ( !ammoname || !ammoname[ 0 ] ) {
		return 0;
	}

	const idDict* ammoDict = gameLocal.FindEntityDefDict( "ammo_types", false );

	if ( !ammoDict ) {
		gameLocal.Error( "Could not find entity definition for 'ammo_types'\n" );
	}

	if ( !ammoDict->GetInt( ammoname, "0", num ) ) {
		//gameLocal.Error( "Unknown ammo type '%s'", ammoname );
		return 0;
	}

	if ( ( num < 0 ) || ( num >= MAX_AMMOTYPES ) ) {
		gameLocal.Error( "Ammo type '%s' value out of range.  Maximum ammo types is %d.\n", ammoname, MAX_AMMOTYPES );
	}

	return num;
}

/*
================
rvWeapon::GetAmmoNameForNum
================
*/
const char* rvWeapon::GetAmmoNameForIndex ( int index ) {
	int i;
	int num;
	const idKeyValue *kv;
	char text[ 32 ];

	sprintf( text, "%d", index );

	const idDict* ammoDict = gameLocal.FindEntityDefDict( "ammo_types", false );

	if ( !ammoDict ) {
		gameLocal.Error( "Could not find entity definition for 'ammo_types'\n" );
	}

	num = ammoDict->GetNumKeyVals();
	for( i = 0; i < num; i++ ) {
		kv = ammoDict->GetKeyVal( i );
		if ( kv->GetValue() == text ) {
			return kv->GetKey();
		}
	}

	return NULL;
}

/*
================
rvWeapon::TotalAmmoCount
================
*/
int rvWeapon::TotalAmmoCount ( void ) const {
	assert( owner );
	return owner->inventory.HasAmmo( ammoType, 1 );
}

/*
================
rvWeapon::AmmoAvailable
================
*/
int rvWeapon::AmmoAvailable( void ) const {
	if ( owner ) {
		return owner->inventory.HasAmmo( ammoType, ammoRequired );
	} else {
		return 0;
	}
}

/*
================
rvWeapon::AmmoInClip
================
*/
int rvWeapon::AmmoInClip( void ) const {
	if ( ClipSize() == 0 ) {
		return AmmoAvailable();
	}
	if ( owner )
		return owner->inventory.clip[weaponIndex];
	else
		return 0;
}

/*
================
rvWeapon::ResetAmmoClip
================
*/
void rvWeapon::ResetAmmoClip( void ) {
	SetClip( 0 );
}

/*
================
rvWeapon::GetAmmoType
================
*/
int rvWeapon::GetAmmoType( void ) const {
	return ammoType;
}

/*
================
rvWeapon::ClipSize
================
*/
int rvWeapon::ClipSize( void ) const {
	if ( owner )
		return owner->inventory.clipSizes[weaponIndex];
	else
		return 0;
}

/*
================
rvWeapon::LowAmmo
================
*/
int rvWeapon::LowAmmo() const {
	return lowAmmo;
}

/*
================
rvWeapon::AmmoRequired
================
*/
int rvWeapon::AmmoRequired( void ) const {
	return ammoRequired;
}

/*
================
rvWeapon::SetClip
================
*/
void rvWeapon::SetClip ( int amount ) {
	if ( !owner ) {
		gameLocal.Warning( "rvWeapon::SetClip - NULL owner" );
		return;
	}

	if ( amount < 0 ) {
		amount = 0;
	} else if ( amount > ClipSize() ) {
		amount = ClipSize();
	}

	owner->inventory.clip[weaponIndex] = amount;
	
	if ( !viewModel ) {
		common->Warning( "NULL viewmodel %s\n", __FUNCTION__ );
		return;
	}
	
	viewModel->PostGUIEvent ( "weapon_ammo" );
	if ( AmmoInClip() == 0 && AmmoAvailable() == 0 ) {
		viewModel->PostGUIEvent ( "weapon_noammo" );
	}
}

/*
================
rvWeapon::UseAmmo
================
*/
void rvWeapon::UseAmmo ( int amount ) {
	amount *= ammoRequired;

	assert( owner );

	owner->inventory.UseAmmo( ammoType, amount );
	if ( ClipSize() && ammoRequired ) {
		SetClip( AmmoInClip() - amount );
	}
}

/*
================
rvWeapon::AddToClip
================
*/
void rvWeapon::AddToClip ( int amount ) {
	int ammoAvail;

 	if ( gameLocal.isClient ) {
 		return;
 	}

	int ammoClip = AmmoInClip();

	ammoClip += amount;
	if ( ammoClip > ClipSize() ) {
		ammoClip = ClipSize();
	}

	ammoAvail = AmmoAvailable();

	if ( ammoAvail > 0 && ammoClip > ammoAvail ) {
		ammoClip = ammoAvail;
	}

	if ( owner )
		owner->inventory.clip[weaponIndex] = ammoClip;

	if ( !viewModel ) {
		common->Warning( "NULL viewmodel %s\n", __FUNCTION__ );
		return;
	}
	
	if ( viewModel ) {
		viewModel->PostGUIEvent ( "weapon_ammo" );
		if ( AmmoInClip() == 0 && AmmoAvailable() == 0 ) {
			viewModel->PostGUIEvent ( "weapon_noammo" );
		}
	}
}

/***********************************************************************

	Attack

***********************************************************************/

/*
================
rvWeapon::Attack
================
*/
void rvWeapon::Attack( int num_attacks, float fuseOffset, float power, float spreadScale ) {
	idVec3 muzzleOrigin;
	idMat3 muzzleAxis;

	if ( !viewModel ) {
		common->Warning( "NULL viewmodel %s\n", __FUNCTION__ );
		return;
	}
	
	if ( viewModel->IsHidden() ) {
		return;
	}

	assert( owner );

	if ( wsfl.reload == true || wsfl.reloading == true )
	{
		//gameLocal.mpGame.AddChatLine("state is.. %d\n", (int)currentState );
		SetState ( WEAP_STATE_RAISE );
		SetStage( 0 );
		return;
	}

	// avoid all ammo considerations on an MP client
	if ( !gameLocal.isClient ) {
		// check if we're out of ammo or the clip is empty
		int ammoAvail = AmmoAvailable();
		if ( !ammoAvail || ( ( ClipSize() != 0 ) && ( AmmoInClip() <= 0 ) ) ) {
			return;
		}

		owner->inventory.UseAmmo( ammoType, ammoRequired );
		SetClip( AmmoInClip() - 1 );
	}
	
	// do all the lovely effects

	// add some to the kick time, incrementally moving repeat firing weapons back
	if ( kick_endtime < gameLocal.realClientTime ) {
		kick_endtime = gameLocal.realClientTime;
	}
	kick_endtime += muzzle_kick_time;
	if ( kick_endtime > gameLocal.realClientTime + muzzle_kick_maxtime ) {
		kick_endtime = gameLocal.realClientTime + muzzle_kick_maxtime;
	}

	// add the muzzleflash LIGHT
	MuzzleFlash();

	// quad damage overlays a sound
//	if ( owner->PowerUpActive( POWERUP_QUADDAMAGE ) ) {
//		viewModel->StartSound ( "snd_quaddamage", SND_CHANNEL_VOICE, 0, false, NULL );
//	}
	// Muzzle flash effect
	viewModel->PlayEffect( "fx_muzzleflash", flashJointView, false, vec3_origin, false, EC_IGNORE );

	if ( worldModel && flashJointWorld != INVALID_JOINT ) {
		worldModel->PlayEffect( gameLocal.GetEffect( weaponDef->dict, "fx_muzzleflash_world" ), flashJointWorld, vec3_origin, mat3_identity, false, vec3_origin, false, EC_IGNORE );
	}

	owner->WeaponFireFeedback( &weaponDef->dict );

	// Inform the gui of the ammo change
	viewModel->PostGUIEvent ( "weapon_ammo" );
	if ( AmmoInClip() == 0 && AmmoAvailable() == 0 ) {
		viewModel->PostGUIEvent ( "weapon_noammo" );
	}

	StartSound( "snd_fire", SND_CHANNEL_WEAPON, 0, false, NULL );
	
	// The attack is either a hitscan or a launched projectile, do that now.
	if ( !gameLocal.isClient ) {
		// calculate the muzzle position
		muzzleAxis = playerViewAxis;	

		/*if ( wfl.attackHitscan ) {
			// go straight out of the view
			muzzleOrigin = playerViewOrigin;
		}
		else {
			// calculate the muzzle position
			if ( barrelJointView != INVALID_JOINT && spawnArgs.GetBool( "launchFromBarrel" ) ) {
				// there is an explicit joint for the muzzle
				GetGlobalJointTransform( true, barrelJointView, muzzleOrigin, muzzleAxis );
			} else {
				muzzleOrigin = owner->GetPhysics()->GetOrigin();
				if ( owner->IsCrouching() ) {
					muzzleOrigin.z += FIRE_PROJ_HEIGHT_CROUCHED;
				}
				else {
					muzzleOrigin.z += FIRE_PROJ_HEIGHT_STANDING;
				}
			}
		}*/
		muzzleOrigin = playerViewOrigin;

		if ( wfl.attackHitscan ) {
			//++ GTR bandit: Unlagged Code
			if ( gameLocal.isServer && g_unlagged.GetBool() && owner )
			{
				owner->Delag( );
				Hitscan( muzzleOrigin, num_attacks, power, spreadScale );
				owner->UndoDelag( );
			}
			else
			//-- GTR bandit: Unlagged Code
				Hitscan( muzzleOrigin, num_attacks, power, spreadScale );
		} else {
			LaunchProjectiles( muzzleOrigin, num_attacks, fuseOffset, power, spreadScale );
		}
	}
}

/*
================
rvWeapon::LaunchProjectiles
================
*/
void rvWeapon::LaunchProjectiles ( const idVec3& _muzzleOrigin, int num_projectiles, float fuseOffset, float power, float spreadScale ) {
	idProjectile*	proj;
	idEntity*		ent;
	idVec3			dir;
	//idVec3			muzzle_pos;
	idVec2			currSpread ;


	if ( gameLocal.isClient ) {
		return;
	}

	assert( owner );

	//ownerBounds = owner->GetPhysics()->GetAbsBounds();

	currSpread = spread * spreadScale;
	dir = playerViewAxis[ 0 ] + ( playerViewAxis[1] * ( currSpread.x * gameLocal.random.CRandomFloat() ) ) + ( playerViewAxis[2] * ( currSpread.y * gameLocal.random.CRandomFloat() ) );
	dir += dirOffset;

	dir.Normalize();

	// Make sure it spawns
	if ( !gameLocal.SpawnEntityDef( attackDef->dict, &ent, false ) || !ent ) {
		gameLocal.Error( "failed to spawn projectile for weapon '%s'", weaponDef->GetName ( ) );
	}
	
	assert ( ent->IsType( idProjectile::GetClassType() ) );

	// Create the projectile
	proj = static_cast<idProjectile*>(ent);
	proj->Create( attackerInfo, _muzzleOrigin, dir, NULL, owner->extraProjPassEntity );

	

	// make sure the projectile starts inside the bounding box of the owner

	/*projBounds = proj->GetPhysics()->GetBounds().Rotate( proj->GetPhysics()->GetAxis() );

	idVec3  start;
	float   distance;
	trace_t	tr;

	muzzle_pos = _muzzleOrigin + playerViewAxis[ 0 ] * 2.0f;
	if ( ( ownerBounds - projBounds).RayIntersection( muzzle_pos, playerViewAxis[0], distance ) ) {
		start = muzzle_pos + distance * playerViewAxis[0];
	} 
	else {
		start = ownerBounds.GetCenter();
	}

	gameLocal.clip.Translation( tr, start, muzzle_pos, proj->GetPhysics()->GetClipModel(), proj->GetPhysics()->GetClipModel()->GetAxis(), MASK_SHOT_RENDERMODEL, owner );

	muzzle_pos = tr.endpos;*/

	// Launch the actual projectile
	proj->Launch( _muzzleOrigin, dir, pushVelocity, fuseOffset, power );

	// Increment the projectile launch count and let the derived classes
	// mess with it if they want.
	OnLaunchProjectile ( proj );

	tfStatManager->ShotFired( attackerInfo, attackDef );
}

/*
================
rvWeapon::OnLaunchProjectile
================
*/
void rvWeapon::OnLaunchProjectile ( idProjectile* proj ) {
}

/*
================
rvWeapon::Hitscan
================
*/
void rvWeapon::Hitscan( const idVec3& muzzleOrigin, int num_hitscans, float power, float spreadScale ) {
	idVec3  fxOrigin;
	idMat3  fxAxis;
	int		i;
	idVec3	dir;
	int		areas[ 2 ];

	assert( owner && owner->entityNumber <= MAX_CLIENTS );

	idBitMsg	msg;
	byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];

	GetGlobalJointTransform( true, flashJointView, fxOrigin, fxAxis );

	if ( gameLocal.isServer ) {
		
		int ownerId = owner->entityNumber;

		msg.Init( msgBuf, sizeof( msgBuf ) );
		msg.BeginWriting();
		msg.WriteByte( GAME_UNRELIABLE_MESSAGE_HITSCAN );
		msg.WriteBits( attackDef->Index(), gameLocal.entityDefBits );
		msg.WriteBits( ownerId, ASYNC_MAX_CLIENT_BITS );
		msg.WriteBits( num_hitscans, 5 );
		msg.WriteFloat( muzzleOrigin[0] );
		msg.WriteFloat( muzzleOrigin[1] );
		msg.WriteFloat( muzzleOrigin[2] );
		msg.WriteFloat( fxOrigin[0] );
		msg.WriteFloat( fxOrigin[1] );
		msg.WriteFloat( fxOrigin[2] );
	}

	idVec3 end;

	idVec2 currSpread = spread * spreadScale;

	// prediction
	/*bool predict = q4f_hitscanCorrection.GetBool() && !gameLocal.isClient && owner && owner != gameLocal.GetLocalPlayer();

	if ( predict ) {
		int ping = ( networkSystem->ServerGetClientPing( owner->entityNumber ) / 2 );
		int fireTime = gameLocal.time - ping;
		//gameLocal.Printf( "Fireing Client's Ping: %d\n", ping );
		gameLocal.PushPlayerPredictPositions( fireTime );
	}*/

	// 3j: stats
	tfStatManager->ShotFired( attackerInfo, attackDef );

	for( i = 0; i < num_hitscans; i++ ) {
		
		// Calculate a random launch direction based on the spread

		dir = playerViewAxis[ 0 ] + ( playerViewAxis[1] * ( currSpread.x * gameLocal.random.CRandomFloat() ) ) + ( playerViewAxis[2] * ( currSpread.y * gameLocal.random.CRandomFloat() ) );
		dir.Normalize();

		gameLocal.HitScan( attackerInfo, attackDef->dict, power, dir, muzzleOrigin, fxOrigin, false, NULL, areas );

		if ( gameLocal.isServer ) {
			msg.WriteDir( dir, 24 );
			if ( i == num_hitscans - 1 ) {
				// NOTE: we emit to the areas of the last hitscan
				// there is a remote possibility that multiple hitscans for shotgun would cover more than 2 areas,
				// so in some rare case a client might miss it
				gameLocal.SendUnreliableMessagePVS( msg, owner, areas[0], areas[1] );
			}
		}
	}

	/*if ( predict ) {
		gameLocal.PopPlayerPredictPositions();
	}*/
}

/*
================
rvWeapon::EjectBrass
================
*/
void rvWeapon::EjectBrass ( void ) {
	/*if ( gameLocal.isMultiplayer ) {
		return;
	}

	if ( g_brassTime.GetFloat() <= 0.0f || !owner->CanShowWeaponViewmodel() ) {
		return;
	}

	if ( ejectJointView == INVALID_JOINT || !brassDict.GetNumKeyVals() ) {
		return;
	}

	idMat3 axis;
	idVec3 origin;
	idVec3 linear_velocity;
	idVec3 angular_velocity;
	int	   brassTime;

	if ( !GetGlobalJointTransform( true, ejectJointView, origin, axis ) ) {
		return;
	}

	// Spawn the client side moveable for the brass
	rvClientMoveable* cent = NULL;

	gameLocal.SpawnClientEntityDef( brassDict, (rvClientEntity**)(&cent), false );

	if( !cent ) {
		return;
	}

	cent->SetOwner( GetOwner() );
	cent->SetOrigin ( origin + playerViewAxis * ejectOffset );
	cent->SetAxis ( playerViewAxis );	
	
	// Depth hack the brass to make sure it clips in front of view weapon properly
	cent->GetRenderEntity()->weaponDepthHackInViewID = GetOwner()->entityNumber + 1;
	
	// Clear the depth hack soon after it clears the view
	cent->PostEventMS ( &CL_ClearDepthHack, 200 );
	
	// Fade the brass out so they dont accumulate
	brassTime =(int)SEC2MS(g_brassTime.GetFloat() / 2.0f);
	cent->PostEventMS ( &CL_FadeOut, brassTime, brassTime );

	// Generate a good velocity for the brass
	idVec3 linearVelocity = brassDict.GetVector("linear_velocity").Random( brassDict.GetVector("linear_velocity_range"), gameLocal.random );
	cent->GetPhysics()->SetLinearVelocity( GetOwner()->GetPhysics()->GetLinearVelocity() + linearVelocity * cent->GetPhysics()->GetAxis() );
	idAngles angularVelocity = brassDict.GetAngles("angular_velocity").Random( brassDict.GetVector("angular_velocity_range"), gameLocal.random );
	cent->GetPhysics()->SetAngularVelocity( angularVelocity.ToAngularVelocity() * cent->GetPhysics()->GetAxis() );
	*/
}

/*
================
rvWeapon::BloodSplat
================
*/
bool rvWeapon::BloodSplat( float size ) {
	/*float s, c;
	idMat3 localAxis, axistemp;
	idVec3 localOrigin, normal;

	if ( !viewModel ) {
		common->Warning( "NULL viewmodel %s\n", __FUNCTION__ );
		return false;
	}
	
	if ( wfl.hasBloodSplat ) {
		return true;
	}

	wfl.hasBloodSplat = true;

	if ( viewModel->modelDefHandle < 0 ) {
		return false;
	}

	if ( !GetGlobalJointTransform( true, ejectJointView, localOrigin, localAxis ) ) {
		return false;
	}

	localOrigin[0] += gameLocal.random.RandomFloat() * -10.0f;
	localOrigin[1] += gameLocal.random.RandomFloat() * 1.0f;
	localOrigin[2] += gameLocal.random.RandomFloat() * -2.0f;

	normal = idVec3( gameLocal.random.CRandomFloat(), -gameLocal.random.RandomFloat(), -1 );
	normal.Normalize();

	idMath::SinCos16( gameLocal.random.RandomFloat() * idMath::TWO_PI, s, c );

	localAxis[2] = -normal;
	localAxis[2].NormalVectors( axistemp[0], axistemp[1] );
	localAxis[0] = axistemp[ 0 ] * c + axistemp[ 1 ] * -s;
	localAxis[1] = axistemp[ 0 ] * -s + axistemp[ 1 ] * -c;

	localAxis[0] *= 1.0f / size;
	localAxis[1] *= 1.0f / size;

	idPlane		localPlane[2];

	localPlane[0] = localAxis[0];
	localPlane[0][3] = -(localOrigin * localAxis[0]) + 0.5f;

	localPlane[1] = localAxis[1];
	localPlane[1][3] = -(localOrigin * localAxis[1]) + 0.5f;

	const idMaterial *mtr = declManager->FindMaterial( "textures/decals/duffysplatgun" );

	gameRenderWorld->ProjectOverlay( viewModel->modelDefHandle, localPlane, mtr );

	return true;*/
	return false;
}
   
/*
===============
rvWeapon::PlayAnim
===============
*/
void rvWeapon::PlayAnim( int channel, const char *animname, int blendFrames ) {
	
	if ( !viewModel ) {
		common->Warning( "NULL viewmodel %s\n", __FUNCTION__ );
		return;
	}
	
	int	anim;
	
	anim = viewAnimator->GetAnim( animname );
	if ( !anim ) {
		//gameLocal.Warning( "missing '%s' animation on '%s' (%s)", animname, viewModel->GetName(), viewModel->GetEntityDefName() );
		viewAnimator->Clear( channel, gameLocal.time, FRAME2MS( blendFrames ) );
		animDoneTime[channel] = 0;
	} else {
		viewModel->Show();
		viewAnimator->PlayAnim( channel, anim, gameLocal.time, FRAME2MS( blendFrames ) );
		animDoneTime[channel] = viewAnimator->CurrentAnim( channel )->GetEndTime();
		
		// Play the animation on the world model as well
		if ( worldAnimator ) {
			worldAnimator->GetAnim( animname );
			if ( anim ) {
				worldAnimator->PlayAnim( channel, anim, gameLocal.time, FRAME2MS( blendFrames ) );
			}
		}
	}
}

/*
===============
rvWeapon::PlayCycle
===============
*/
void rvWeapon::PlayCycle( int channel, const char *animname, int blendFrames ) {
	int anim;
	
	if ( !viewModel ) {
		common->Warning( "NULL viewmodel %s\n", __FUNCTION__ );
		return;
	}
	
	anim = viewAnimator->GetAnim( animname );
	if ( !anim ) {
		//gameLocal.Warning( "missing '%s' animation on '%s' (%s)", animname, viewModel->GetName(), viewModel->GetEntityDefName() );
		viewAnimator->Clear( channel, gameLocal.time, FRAME2MS( blendFrames ) );
		animDoneTime[channel] = 0;
	} else {
		viewModel->Show();
		viewAnimator->CycleAnim( channel, anim, gameLocal.time, FRAME2MS( blendFrames ) );
		animDoneTime[channel] = viewAnimator->CurrentAnim( channel )->GetEndTime();

		// Play the animation on the world model as well
		if ( worldAnimator ) {
			anim = worldAnimator->GetAnim( animname );
			if ( anim ) {
				worldAnimator->CycleAnim( channel, anim, gameLocal.time, FRAME2MS( blendFrames ) );
			}
		}
	}
}

/*
===============
rvWeapon::AnimDone
===============
*/
bool rvWeapon::AnimDone( int channel, int blendFrames ) {
	if ( animDoneTime[channel] - FRAME2MS( blendFrames ) <= gameLocal.time ) {
		return true;
	}
	return false;
}

/*
===============
rvWeapon::StartSound
===============
*/
bool rvWeapon::StartSound ( const char *soundName, const s_channelType channel, int soundShaderFlags, bool broadcast, int *length ) {
	if ( !viewModel ) {
		common->Warning( "NULL viewmodel %s\n", __FUNCTION__ );
		return false;
	}
	return viewModel->StartSound( soundName, channel, soundShaderFlags, broadcast, length );
}

/*
===============
rvWeapon::StopSound
===============
*/
void rvWeapon::StopSound( const s_channelType channel, bool broadcast ) {
	if ( !viewModel ) {
		common->Warning( "NULL viewmodel %s\n", __FUNCTION__ );
		return;
	}
	viewModel->StopSound( channel, broadcast );
}

/*
===============
rvWeapon::PlayEffect
===============
*/
rvClientEffect* rvWeapon::PlayEffect( const char* effectName, jointHandle_t joint, bool loop, const idVec3& endOrigin, bool broadcast ) {
	if ( !viewModel ) {
		common->Warning( "NULL viewmodel %s\n", __FUNCTION__ );
		return 0;
	}

	return viewModel->PlayEffect( effectName, joint, loop, endOrigin, broadcast );
}

/*
================
rvWeapon::CacheWeapon
================
*/
void rvWeapon::CacheWeapon( const char *weaponName ) {
	const idDeclEntityDef *weaponDef;
	const char *brassDefName;
	const char *clipModelName;
	idTraceModel trm;

	weaponDef = gameLocal.FindEntityDef( weaponName, false );
	if ( !weaponDef ) {
		return;
	}

	// precache the brass collision model
	brassDefName = weaponDef->dict.GetString( "def_ejectBrass" );
	if ( brassDefName[0] ) {
		const idDeclEntityDef *brassDef = gameLocal.FindEntityDef( brassDefName, false );
		if ( brassDef ) {
			brassDef->dict.GetString( "clipmodel", "", &clipModelName );
			if ( idStr::Icmp( clipModelName, SIMPLE_TRI_NAME ) == 0 ) {
				trm.SetupPolygon( simpleTri, 3 );
			} else {
				if ( !clipModelName[0] ) {
					clipModelName = brassDef->dict.GetString( "model" );		// use the visual model
				}
				// load the trace model
				collisionModelManager->TrmFromModel( gameLocal.GetMapName(), clipModelName, trm );
			}
		}
	}

	const idKeyValue* kv;

	kv = weaponDef->dict.MatchPrefix( "gui", NULL );
	while( kv ) {
		if ( kv->GetValue().Length() ) {
			uiManager->FindGui( kv->GetValue().c_str(), true, false, true );
		}
		kv = weaponDef->dict.MatchPrefix( "gui", kv );
	}
}


/*
===============================================================================

	States 

===============================================================================
*/


/*
=====================
rvWeapon::GetDebugInfo
=====================
*/
void rvWeapon::GetDebugInfo ( debugInfoProc_t proc, void* userData ) {
	idClass::GetDebugInfo ( proc, userData );
}

// <q4f> 

void rvWeapon::AttackPressed() {
	if ( wsfl.reloading == true || wsfl.reload == true )
		return;

	SetState( WEAP_STATE_FIRE );
}

void rvWeapon::AttackHeld() {
}

int rvWeapon::GetSpeedLimit() {
	return idMath::INT_MAX;
}

float rvWeapon::GetOwnerSpeed() {
	if ( owner )
	{
		idVec3 OwnerVec = owner->GetPhysics()->GetLinearVelocity();
		idVec3 PushedVec = owner->GetPhysics()->GetPushedLinearVelocity();
		float size = ( OwnerVec - PushedVec ).Length();
		return size;
	}
	return 0.0f;
}
float rvWeapon::OwnerHasGroundContacts() {
	return owner ? owner->GetPhysics()->HasGroundContacts() : false;
}







void rvWeapon::UpdateState() {

	assert( owner );

	int oldState = currentState;

	switch( currentState ) {

		case WEAP_STATE_RAISE:
			State_Raise();
			break;

		case WEAP_STATE_LOWER:
			State_Lower();
			break;

		case WEAP_STATE_IDLE:
			State_Idle();
			break;

		case WEAP_STATE_FIRE:
			State_Fire();
			break;

		case WEAP_STATE_RELOAD:
			State_Reload();
			break;

		default:
			StateError( "Unknown state #" );
			break;
	}

	if ( oldState != currentState )
		currentStage = 0;
}

#define WEAPON_RAISELOWER_TIME 150

void rvWeapon::State_Raise() {
		
	enum {
		STAGE_INIT = 0,
		STAGE_WAIT
	};

	switch( currentStage ) {

		case STAGE_INIT:
			SetStatus ( WP_RISING );
			raiselower_time = WEAPON_RAISELOWER_TIME;
			raiselower_endtime = gameLocal.time + raiselower_time;

			PlayCycle( ANIMCHANNEL_ALL, "idle" );
			SetStage( STAGE_WAIT );
			return;

		case STAGE_WAIT:
			if ( gameLocal.time >= raiselower_endtime ) {
//				if ( wsfl.reloading == false )
//					nextAttackTime = gameLocal.time + 300;
				lowerAmount = 0.0f;
				SetStage( STAGE_INIT );
				SetState ( WEAP_STATE_IDLE );
				wsfl.reloading = false;
				wsfl.reload = false;
				return;
			}

			lowerAmount = (float)(raiselower_endtime - gameLocal.time) / (float)raiselower_time;

			if ( wsfl.lowerWeapon ) {
				SetState ( WEAP_STATE_LOWER );
			}
			return;
	}

	StateError( "Unknown stage #" );
}

void rvWeapon::State_Lower() {
		
	enum {
		STAGE_INIT = 0,
		STAGE_WAIT,
		STAGE_WAITRAISE
	};	

	switch ( currentStage ) {

		case STAGE_INIT:
			SetStatus ( WP_LOWERING );

			StartSound( "snd_lower", SND_CHANNEL_WEAPON, 0, false, NULL );

			// check if we interrupted a raise
			if ( raiselower_endtime > gameLocal.time ) {
				raiselower_time = WEAPON_RAISELOWER_TIME - ( gameLocal.time - ( raiselower_endtime - raiselower_time ) );
			}
			else {
				raiselower_time = WEAPON_RAISELOWER_TIME;
			}

			raiselower_endtime = gameLocal.time + raiselower_time;
			
			SetStage( STAGE_WAIT );
			return;
			
		case STAGE_WAIT:

			if ( gameLocal.time >= raiselower_endtime ) {
				lowerAmount = 1.0f;

				if ( wsfl.reloading ) {
					//SetState( "Reload", 0 );
					//return SRESULT_DONE;
					SetState ( WEAP_STATE_RELOAD );
					SetStage( STAGE_INIT );
					return;
				}

				SetStatus ( WP_HOLSTERED );
				SetStage( STAGE_WAITRAISE );
				return;
			}

			lowerAmount = 1.0f - ( (float)(raiselower_endtime - gameLocal.time) / (float)raiselower_time );

			return;
		
		case STAGE_WAITRAISE:
			if ( wsfl.raiseWeapon ) {
				SetState ( WEAP_STATE_RAISE );
				SetStage( STAGE_INIT );
			}
			return;
	}

	StateError( "Unknown stage #" );
}

void rvWeapon::State_Idle() {
	enum {
		STAGE_INIT = 0,
		STAGE_WAIT,
	};	
	switch ( currentStage ) {
		case STAGE_INIT:

			if ( !AmmoAvailable( ) ) {
				SetStatus( WP_OUTOFAMMO );
			} else {
				if ( wsfl.reloading == false && wsfl.reload == false )
					SetStatus( WP_READY );
			}

			wsfl.attackPressed = false;

			PlayCycle( ANIMCHANNEL_ALL, "idle" );
		
			SetStage( STAGE_WAIT );
			return;
		
		case STAGE_WAIT:			
			if ( gameLocal.time >= nextAttackTime && wsfl.lowerWeapon ) {
				SetState( WEAP_STATE_LOWER );
				return;
			}

			if ( !AmmoAvailable( ) ) {
				SetStatus( WP_OUTOFAMMO );
				return;
			}

			//stateResult_t next = SRESULT_WAIT;	// xav: ?
			if ( wsfl.reloading == false && wsfl.reload == false )
			{
				if ( wsfl.attack ) {
					if ( gameLocal.time > nextAttackTime ) {
						if ( AmmoInClip() != 0 ) {
							if ( !wsfl.attackPressed ) {
								wsfl.attackPressed = true;
								AttackPressed();
							}
							else {
								AttackHeld();
							}
						}
						else {			// out of ammo
							if ( ClipSize() > 0 ) {
								if ( AutoReload() && AmmoAvailable() > AmmoInClip() ) {
									SetState( WEAP_STATE_RELOAD );
									SetStage( STAGE_INIT );
									return/* SRESULT_DONE*/;	
								}
							}
						}
					}	// can't attack yet
				}
				else {	// not holding fire
					if ( wsfl.attackPressed ) {
						wsfl.attackPressed = false;
						AttackReleased();
					}
				}
			}
			// xavior: not sure if the below is needed
			if ( wsfl.reload && AmmoAvailable() <= AmmoInClip() )
				wsfl.reload = false;

			if ( wsfl.netReload || ( wsfl.reload && AmmoInClip() < ClipSize() && AmmoAvailable() > AmmoInClip() ) ) {
				//SetState ( "Reload", 4 );
				SetState( WEAP_STATE_RELOAD );
				SetStage( STAGE_INIT );
				return/* SRESULT_DONE*/;
			}

/*			if ( wsfl.attack && gameLocal.time >= nextAttackTime ) {
				if ( !wsfl.attackPressed ) {
					wsfl.attackPressed = true;
					AttackPressed();
				}
				else {
					AttackHeld();
				}
			}
			else if ( wsfl.attackPressed ) {
				wsfl.attackPressed = false;
				AttackReleased();
			}*/

			return;
	}
	
	StateError( "Unknown stage #" );
}

void rvWeapon::State_Fire() {

	enum {
		STAGE_INIT,
		STAGE_WAIT,
	};	

	if ( wsfl.reloading == true || wsfl.reload == true )
		// do something here
		return;

	switch ( currentStage ) {
		case STAGE_INIT:

			if ( wsfl.lowerWeapon ) {
				SetState( WEAP_STATE_LOWER );
				return;
			}

			nextAttackTime = gameLocal.time + fireRate;

			if ( owner->HasAffliction( AFFL_TRANQ ) )
			{
				nextAttackTime = gameLocal.time + ( fireRate * 2 );
			}
			Attack( num_attacks );
			PlayAnim( ANIMCHANNEL_ALL, "fire", 0 );	
			SetStage( STAGE_WAIT );
			return;
	
		case STAGE_WAIT:

			if ( gameLocal.time >= nextAttackTime ) {
				if ( wsfl.attack && AmmoInClip() ) {
					SetStage( STAGE_INIT );
				}
				else {
					SetState( WEAP_STATE_IDLE );
				}
			}

			return;
	}
	
	StateError( "Unknown stage #" );
}

void rvWeapon::StateError( const char* msg ) {
	const char* ownerName;
	const char* viewModelName;
	const char* className;

	if ( owner ) {
		ownerName = owner->GetUserInfo()->GetString( "ui_name" );
	}
	else {
		ownerName = "_null_";
	}

	if ( viewModel ) {
		viewModelName = viewModel->GetName();
	}
	else {
		viewModelName = "_null_";
	}

	className = spawnArgs.GetString( "classname" );

	gameLocal.Error( "Weapon state error:\nowner = %s\nviewModelName = %s\nclassName = %s\nstate # = %d\nstage # = %d\nmessage = %s\n",
		ownerName, viewModelName, className, currentState, currentStage, msg );

}

//--------------------------------------------------------------------------
// Reload
//--------------------------------------------------------------------------
// XavioR: No more reload anims, these are just Q3F style.
// This code is based on an older reload function that 3j gave me.
void rvWeapon::State_Reload() {
	enum
	{
		STAGE_INIT,
		STAGE_WAIT,
	};
	switch( currentStage )
	{
		case STAGE_INIT:

			if ( !wsfl.reloading ) {

				if( wsfl.netReload )
					wsfl.netReload = false;
				else
					NetReload();

				wsfl.reloading = true;
				wsfl.reload = true;

				//SetStatus( WP_RELOAD );		// just made "reload" blink on the HUD..
				SetState ( WEAP_STATE_LOWER );
				SetStage( STAGE_INIT ); // xavior: I'm not 100% sure about these..
				return;
			}
			
			nextReloadTime = gameLocal.time + reloadTime;

			raiselower_time = WEAPON_RAISELOWER_TIME;
			raiselower_endtime = gameLocal.time + raiselower_time;

			SetStatus( WP_RELOAD );
			SetStage( STAGE_WAIT );
			return;

		case STAGE_WAIT:
			if ( gameLocal.time >= nextReloadTime ) {
				AddToClip( 1 );

				if( AmmoInClip() < ClipSize() && AmmoAvailable() > AmmoInClip() ) {
					nextReloadTime = gameLocal.time + reloadTime;
					SetStatus( WP_RELOAD );
					SetStage( STAGE_WAIT );
					return;
				}

				SetStatus( WP_RELOADDONE );

				if ( wsfl.lowerWeapon ) {
					SetStatus( WP_HOLSTERED );
					SetState ( WEAP_STATE_LOWER );
					SetStage( STAGE_INIT );
					return;;
				}
				SetState ( WEAP_STATE_RAISE );
				SetStage( STAGE_INIT );
//				wsfl.reloading =	false;
				return;
			}
			if ( gameLocal.isClient ) {
				if ( AmmoInClip() >= ClipSize() ) {
					SetStatus( WP_RELOADDONE );
					SetState ( WEAP_STATE_RAISE );
					SetStage( STAGE_INIT );
					return;
				}
			}
			SetStage( STAGE_WAIT );
			return;
		}
	StateError( "Unknown stage #" );	//xavior: this looks like what 3j tried to do with the above states
	return;								//in place of SRESULT_ERROR
}

// </q4f>
