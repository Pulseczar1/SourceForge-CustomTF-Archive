/*

Various utility objects and functions.

*/

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "Game_local.h"


// nmckenzie: added ai
#if !defined(__GAME_PROJECTILE_H__)
	#include "Projectile.h"
#endif


/*
===============================================================================

idSpawnableEntity

A simple, spawnable entity with a model and no functionable ability of it's own.
For example, it can be used as a placeholder during development, for marking
locations on maps for script, or for simple placed models without any behavior
that can be bound to other entities.  Should not be subclassed.
===============================================================================
*/

CLASS_DECLARATION( idEntity, idSpawnableEntity )
END_CLASS

/*
======================
idSpawnableEntity::Spawn
======================
*/
void idSpawnableEntity::Spawn() {
	// this just holds dict information
}

/*
===============================================================================

	idActivator

===============================================================================
*/

CLASS_DECLARATION( idEntity, idActivator )
	EVENT( EV_Activate,		idActivator::Event_Activate )
END_CLASS

/*
===============
idActivator::Save
================
*/
void idActivator::Save( idSaveGame *savefile ) const {
	savefile->WriteBool( stay_on );
}

/*
===============
idActivator::Restore
================
*/
void idActivator::Restore( idRestoreGame *savefile ) {
	savefile->ReadBool( stay_on );

	if ( stay_on ) {
		BecomeActive( TH_THINK );
	}
}

/*
===============
idActivator::Spawn
================
*/
void idActivator::Spawn( void ) {
	bool start_off;

	spawnArgs.GetBool( "stay_on", "0", stay_on );
	spawnArgs.GetBool( "start_off", "0", start_off );


// bdube: optional clip model on activators
	const char	*temp;
	if ( spawnArgs.GetString( "clipmodel", "", &temp ) ) {

// mwhitlock: Dynamic memory consolidation
		RV_PUSH_HEAP_MEM(this);

		GetPhysics()->SetClipModel( new idClipModel(temp), 1.0f );

// mwhitlock: Dynamic memory consolidation
		RV_POP_HEAP();

	} else {
		GetPhysics()->SetClipBox( idBounds( vec3_origin ).Expand( 4 ), 1.0f );
	}

	GetPhysics()->SetContents( 0 );


	if ( !start_off ) {
		BecomeActive( TH_THINK );
	}
}

/*
===============
idActivator::Think
================
*/
void idActivator::Think( void ) {
	RunPhysics();
	if ( thinkFlags & TH_THINK ) {
		if ( TouchTriggers() ) {
			if ( !stay_on ) {
				BecomeInactive( TH_THINK );
			}
		}
	}
	Present();
}

/*
===============
idActivator::Activate
================
*/
void idActivator::Event_Activate( idEntity *activator ) {
	if ( thinkFlags & TH_THINK ) {
		BecomeInactive( TH_THINK );
	} else {
		BecomeActive( TH_THINK );
	}
}


/*
===============================================================================

idPathCorner

===============================================================================
*/

CLASS_DECLARATION( idEntity, idPathCorner )
//	EVENT( AI_RandomPath,		idPathCorner::Event_RandomPath )
END_CLASS

/*
=====================
idPathCorner::Spawn
=====================
*/
void idPathCorner::Spawn( void ) {
}

/*
=====================
idPathCorner::DrawDebugInfo
=====================
*/
void idPathCorner::DrawDebugInfo( void ) {
	idEntity *ent;
	idBounds bnds( idVec3( -4.0, -4.0f, -8.0f ), idVec3( 4.0, 4.0f, 64.0f ) );

	for( ent = gameLocal.spawnedEntities.Next(); ent != NULL; ent = ent->spawnNode.Next() ) {
		if ( !ent->IsType( idPathCorner::Type ) ) {
			continue;
		}

		idVec3 org = ent->GetPhysics()->GetOrigin();
		gameRenderWorld->DebugBounds( colorRed, bnds, org, 0 );
	}
}

/*
============
idPathCorner::RandomPath
============
*/
idPathCorner *idPathCorner::RandomPath( const idEntity *source, const idEntity *ignore ) {
	int	i;
	int	num;
	int which;
	idEntity *ent;
	idPathCorner *path[ MAX_GENTITIES ];

	num = 0;
	for( i = 0; i < source->targets.Num(); i++ ) {
		ent = source->targets[ i ].GetEntity();
		if ( ent && ( ent != ignore ) && ent->IsType( idPathCorner::Type ) ) {
			path[ num++ ] = static_cast<idPathCorner *>( ent );
			if ( num >= MAX_GENTITIES ) {
				break;
			}
		}
	}

	if ( !num ) {
		return NULL;
	}

	which = gameLocal.random.RandomInt( num );
	return path[ which ];
}

/*
=====================
idPathCorner::Event_RandomPath
=====================
*/
void idPathCorner::Event_RandomPath( void ) {
	idPathCorner *path;

	path = RandomPath( this, NULL );
	idThread::ReturnEntity( path );
}

/*
===============================================================================

  idDamagable
	
===============================================================================
*/

const idEventDef EV_RestoreDamagable( "<RestoreDamagable>" );

// kfuller: spawn other things
const idEventDef EV_SpawnForcefield( "<SpawnForcefield>" );
const idEventDef EV_SpawnTriggerHurt( "<SpawnTriggerHurt>" );


CLASS_DECLARATION( idEntity, idDamagable )
	EVENT( EV_Activate,			idDamagable::Event_BecomeBroken )
	EVENT( EV_RestoreDamagable,	idDamagable::Event_RestoreDamagable )
END_CLASS

/*
================
idDamagable::idDamagable
================
*/
idDamagable::idDamagable( void ) {
	count = 0;
	nextTriggerTime = 0;
	invincibleTime = 0;
}

/*
================
idDamagable::Save
================
*/
void idDamagable::Save( idSaveGame *savefile ) const {

	savefile->WriteInt( invincibleTime );

	savefile->WriteInt( stage );
	savefile->WriteInt( stageNext );
	
	// cnicholson: Don't save the stageDict, its setup in the restore
	
	savefile->WriteInt( stageEndTime );
	savefile->WriteInt( stageEndHealth );
	savefile->WriteInt( stageEndSpeed );
	savefile->WriteBool( stageEndOnGround );
	savefile->WriteBool( activateStageOnTrigger );

	savefile->WriteInt( count );
	savefile->WriteInt( nextTriggerTime );
}

/*
================
idDamagable::Restore
================
*/
void idDamagable::Restore( idRestoreGame *savefile ) {

	const char* stageName;
	
	savefile->ReadInt( invincibleTime );

	savefile->ReadInt( stage );
	savefile->ReadInt( stageNext );
	savefile->ReadInt( stageEndTime );
	savefile->ReadInt( stageEndHealth );
	savefile->ReadInt( stageEndSpeed );
	savefile->ReadBool( stageEndOnGround );
	savefile->ReadBool( activateStageOnTrigger );

	savefile->ReadInt( count );
	savefile->ReadInt( nextTriggerTime );
	

	// Get the stage name, if there is none then there are no more stages
	stageDict = NULL;
	if ( spawnArgs.GetString ( va( "def_stage%d", stage ), "", &stageName ) && stageName ) {

		stageDict = gameLocal.FindEntityDefDict ( stageName, false );
	}
}

/*
================
idDamagable::Spawn
================
*/
void idDamagable::Spawn( void ) {
	idStr	broken;
	bool	keepContents;


// abahr: stage stuff
	stage				= 0;
	stageNext			= 1;
	stageDict			= NULL;
	stageEndTime		= 0;
	stageEndHealth		= 9999;
	stageEndSpeed		= 0;
//jshepard:
	stageEndOnGround    = false;


	health = spawnArgs.GetInt( "health", "5" );


// abahr: stage stuff
   stageEndHealth = health - 1;
	activateStageOnTrigger = spawnArgs.GetBool("activateOnTrigger");


	spawnArgs.GetInt( "count", "1", count );
	invincibleTime = gameLocal.GetTime() + SEC2MS( spawnArgs.GetFloat( "invincibleTime", "0" ) );
	nextTriggerTime = 0;
	
	// make sure the model gets cached
	spawnArgs.GetString( "broken", "", broken );
	if ( broken.Length() && !renderModelManager->CheckModel( broken ) ) {
		gameLocal.Error( "idDamagable '%s' at (%s): cannot load broken model '%s'", name.c_str(), GetPhysics()->GetOrigin().ToString(0), broken.c_str() );
	}


// bdube: turn take damage off if it has no health
	fl.takedamage = health > 0 ? true : false;


	keepContents = spawnArgs.GetBool( "KeepContents" );

	if ( keepContents ) {
		// do nothing, keep the contents from the model
	} else {
		GetPhysics()->SetContents( CONTENTS_SOLID );
	}
}

/*
================
idDamagable::BecomeBroken
================
*/
void idDamagable::BecomeBroken( idEntity *activator ) {
	float	forceState;
	int		numStates;
	int		cycle;
	float	wait;
	
	if ( gameLocal.time < nextTriggerTime ) {
		return;
	}

	spawnArgs.GetFloat( "wait", "0.1", wait );
	nextTriggerTime = gameLocal.time + SEC2MS( wait );
	if ( count > 0 ) {
		count--;
		if ( !count ) {
			fl.takedamage = false;
		} else {
			health = spawnArgs.GetInt( "health", "5" );
		}
	}

	idStr	broken;

	spawnArgs.GetString( "broken", "", broken );
	if ( broken.Length() ) {
		SetModel( broken );
	}

	// offset the start time of the shader to sync it to the gameLocal time
	renderEntity.shaderParms[ SHADERPARM_TIMEOFFSET ] = -MS2SEC( gameLocal.time );

	spawnArgs.GetInt( "numstates", "1", numStates );
	spawnArgs.GetInt( "cycle", "0", cycle );
	spawnArgs.GetFloat( "forcestate", "0", forceState );

	// set the state parm
	if ( cycle ) {
		renderEntity.shaderParms[ SHADERPARM_MODE ]++;
		if ( renderEntity.shaderParms[ SHADERPARM_MODE ] > numStates ) {
			renderEntity.shaderParms[ SHADERPARM_MODE ] = 0;
		}
	} else if ( forceState ) {
		renderEntity.shaderParms[ SHADERPARM_MODE ] = forceState;
	} else {
		renderEntity.shaderParms[ SHADERPARM_MODE ] = gameLocal.random.RandomInt( numStates ) + 1;
	}

	renderEntity.shaderParms[ SHADERPARM_TIMEOFFSET ] = -MS2SEC( gameLocal.time );

	ActivateTargets( activator );

	if ( spawnArgs.GetBool( "hideWhenBroken" ) ) {
		Hide();
		PostEventMS( &EV_RestoreDamagable, nextTriggerTime - gameLocal.time );
		BecomeActive( TH_THINK );
	}
}

/*
============
idMoveable::Damage
============
*/

// abahr
void idDamagable::Damage( idEntity *inflictor, idEntity *attacker, const idVec3 &dir, const char *damageDefName, const float damageScale, const int location ) {

	if ( invincibleTime > gameLocal.GetTime() )	{
		return;
	}

	// If there is a damage filter we need to check to see if the damage def meets the requirement
	const char* damageFilter;
	if ( spawnArgs.GetString ( "damage_filter", "", &damageFilter ) && *damageFilter ) {
		const idDict *damageDef = gameLocal.FindEntityDefDict( damageDefName, false );
		if ( !damageDef ) {
			gameLocal.Error( "Unknown damageDef '%s'\n", damageDefName );
		}
		// If the filter isnt matched then ignore it
		if ( !damageDef->GetBool ( va("filter_%s", damageFilter ) ) ) {
			return;
		}
	}
	if ( spawnArgs.GetBool( "nosplash", "0" ) ) {
		//ignore splash damage
		const idDict *damageDef = gameLocal.FindEntityDefDict( damageDefName, false );
		if ( !damageDef ) {
			gameLocal.Error( "Unknown damageDef '%s'\n", damageDefName );
		}
		//if it has radius, then it's splash damage and ignore it
		if ( damageDef->GetFloat ( "radius", "0" ) ) {
			return;
		}
	}
	
	idEntity::Damage ( inflictor, attacker, dir, damageDefName, damageScale, location );
	
	// Force a stage update so impact effects will be correct
	UpdateStage();
}

/*
================
idDamagable::Killed
================
*/
void idDamagable::Killed( idEntity *inflictor, idEntity *attacker, int damage, const idVec3 &dir, int location ) {
	if ( gameLocal.time < nextTriggerTime ) {
		health += damage;
		return;
	}

	BecomeBroken( attacker );
}

/*
================
idDamagable::UpdateStage
================
*/
void idDamagable::UpdateStage ( void ) {
	
	// If there is a stage to go to then see if its time to do that
 	if ( stage != stageNext ) {
		int	 oldstage;

		// Check to see if the stage is complete
		oldstage = stage;
		while ( health < stageEndHealth || (stageEndTime != 0 && gameLocal.time > stageEndTime ) || (stageEndOnGround && GetPhysics()->HasGroundContacts()) || activateStageOnTrigger ) {
			stage = stageNext;
			
			//this only needs to happen once
			activateStageOnTrigger = false;

			// Get the stage name, if there is none then there are no more stages
			const char* stageName;
			if ( !spawnArgs.GetString ( va("def_stage%d", stage ), "", &stageName ) || !stageName ) {
				stage = 0;
				break;
			}

			// Get the stage dictionary
			stageDict = gameLocal.FindEntityDefDict ( stageName, false );
			if ( !stageDict ) {
				gameLocal.Warning ( "could not find stage '%s' for moveable '%s'", stageName, name.c_str() );
				stage = 0;
				break;
			}

			// Get the end conditions of the stage
			stageEndHealth = stageDict->GetInt ( "end_health", "-9999" );

			stageEndOnGround = stageDict->GetBool( "end_onGround" );

			// Timed?			
			stageEndTime = SEC2MS ( GetStageFloat ( "end_time" ) );
			if ( stageEndTime > 0 ) {
				stageEndTime += gameLocal.time;			
			}		
			
			// Set the next stage to move to when end conditions met
			stageNext = stage + 1;

			// Execute the new stage
			ExecuteStage ( );
		}
	}	
}

/*
================
idDamagable::ExecuteStage
================
*/
void idDamagable::ExecuteStage ( void ) {
	const idKeyValue* kv;
	bool			  remove;
	
	// Remove the entity this frame?
	remove = stageDict->GetBool ( "remove" );
	
	// Targets?
	if ( stageDict->GetBool( "triggerTargets" ) ) {
		ActivateTargets( this );
	}

	// Unbind targets
	if ( stageDict->GetBool( "unbindTargets" ) ) {
		UnbindTargets( this );
	}

	// Stop current looping effects
	StopAllEffects ( );

	// Play all effects (if they start with "fx_loop" then also loop them
	for ( kv = stageDict->MatchPrefix ( "fx_" ); kv; kv = stageDict->MatchPrefix("fx_",kv) ) {
		if ( !kv->GetKey().Icmpn ( "fx_loop", 7 ) ) {
			if ( !remove ) {
				PlayEffect ( gameLocal.GetEffect ( *stageDict, kv->GetKey() ), 
							 renderEntity.origin + GetStageVector ( va("offset_%s", kv->GetKey().c_str() ) ), 
							 GetStageVector ( va("dir_%s", kv->GetKey().c_str() ), "1 0 0" ).ToMat3() * renderEntity.axis, 
							 true );
			}
		} else {
			gameLocal.PlayEffect ( gameLocal.GetEffect ( *stageDict, "fx_explode" ), 
								   GetPhysics()->GetOrigin() + GetStageVector ( va("offset_%s", kv->GetKey().c_str() ) ) * GetPhysics()->GetAxis(), 
								   GetStageVector ( va("dir_%s", kv->GetKey().c_str() ), "1 0 0" ).ToMat3() );
		}
	}

	// Kick off debris
	for ( kv = stageDict->MatchPrefix ( "def_debris" ); kv; kv = stageDict->MatchPrefix("def_debris",kv) ) {		
		const idDict* args = gameLocal.FindEntityDefDict ( kv->GetValue(), false );
		if ( !args ) {
			continue;
		}

		rvClientMoveable* cent = NULL;
		// force spawnclass to rvClientMoveable
		gameLocal.SpawnClientEntityDef( *args, (rvClientEntity**)(&cent), false, "rvClientMoveable" );

		if( !cent ) {
			continue;
		}

		cent->SetOrigin ( GetPhysics()->GetOrigin() + GetStageVector ( va("offset_%s", kv->GetKey().c_str()) ) * GetPhysics()->GetAxis() );
		cent->SetAxis ( GetPhysics()->GetAxis ( ) );
		
		idVec3 vel;
		vel = GetStageVector ( va("vel_%s", kv->GetKey().c_str()) ) * GetPhysics()->GetAxis();
		vel += GetPhysics()->GetLinearVelocity ( );
		cent->GetPhysics()->SetLinearVelocity ( vel );
		cent->PostEventMS ( &CL_FadeOut, 2500, 2500 );
	}

    // Apply force to all objects nearby
	float fPush;
	stageDict->GetFloat("radiusPush","0",fPush);
	if (fPush > 0)	{
		gameLocal.RadiusPush( GetPhysics()->GetOrigin(), 128, fPush, this, this, 1.0f, true );
	}
	
	// Remove the entity now?
	if ( remove ) {
		Hide ( );
		PostEventMS ( &EV_Remove, 0 );
		return;
	} 
	
	// Switch model?
	const char* model;
	if ( stageDict->GetString ( "model", "", &model ) && *model ) {			
		SetModel( model );
	}

	// Skin?
	const char* skin;
	if ( stageDict->GetString ( "skin", "", &skin ) && *skin ) {
		renderEntity.customSkin = declManager->FindSkin ( skin, false );
	}
	
	// Velocities
	idVec3 vel;
	vel  = GetStageVector ( "vel_world" );
	vel += (GetStageVector ( "vel_local" ) * GetPhysics()->GetAxis() );
	vel += GetPhysics()->GetLinearVelocity ( );	
	GetPhysics()->SetLinearVelocity ( vel );
		
	// Enable thinking to ensure stages are run
	BecomeActive ( TH_THINK );
}

/*
================
idDamagable::GetStageVector
================
*/
idVec3 idDamagable::GetStageVector ( const char* key, const char* defaultString ) const {
	idVec3 mins;
	if ( stageDict->GetVector ( va("%s_min", key ), "", mins ) ) {
		idVec3 maxs;
		stageDict->GetVector ( va("%s_max", key), mins.ToString(), maxs );
		return mins + (maxs - mins) * gameLocal.random.RandomFloat ( );
	}
	
	return stageDict->GetVector ( key, defaultString );
}

/*
================
idDamagable::GetStageFloat
================
*/
float idDamagable::GetStageFloat	( const char* key, const char* defaultString ) const {
	float minValue;
	if ( stageDict->GetFloat ( va("%s_min", key ), "", minValue ) ) {
		float maxValue;
		stageDict->GetFloat ( va("%s_max", key), va("%g",minValue), maxValue );
		return minValue + (maxValue - minValue) * gameLocal.random.CRandomFloat ( );
	}
	
	return stageDict->GetFloat ( key, defaultString );
}

/*
================
idDamagable::GetStageInt
================
*/
int idDamagable::GetStageInt	( const char* key, const char* defaultString ) const {
	int minValue;
	if ( stageDict->GetInt ( va("%s_min", key ), "", minValue ) ) {
		int maxValue;
		stageDict->GetInt ( va("%s_max", key), va("%d",minValue), maxValue );
		return minValue + (maxValue - minValue) * gameLocal.random.CRandomFloat ( );
	}
	
	return stageDict->GetInt ( key, defaultString );
}

/*
================
idDamagable::Event_BecomeBroken
================
*/
void idDamagable::Event_BecomeBroken( idEntity *activator ) {
	BecomeBroken( activator );


// bdube: start stages
	UpdateStage ( );

}

/*
================
idDamagable::Event_RestoreDamagable
================
*/
void idDamagable::Event_RestoreDamagable( void ) {
	health = spawnArgs.GetInt( "health", "5" );
	Show();
}


/*
===============================================================================

  idExplodable
	
===============================================================================
*/

CLASS_DECLARATION( idEntity, idExplodable )
	EVENT( EV_Activate,	idExplodable::Event_Explode )
END_CLASS

/*
================
idExplodable::Spawn
================
*/
void idExplodable::Spawn( void ) {
	Hide();
}

/*
================
idExplodable::Event_Explode
================
*/
void idExplodable::Event_Explode( idEntity *activator ) {
	const char *temp;

	if ( spawnArgs.GetString( "def_damage", "damage_explosion", &temp ) ) {
		gameLocal.RadiusDamage( GetPhysics()->GetOrigin(), activator, activator, this, this, temp );
	}

	StartSound( "snd_explode", SND_CHANNEL_ANY, 0, false, NULL );

	// Show() calls UpdateVisuals, so we don't need to call it ourselves after setting the shaderParms
	renderEntity.shaderParms[SHADERPARM_RED]		= 1.0f;
	renderEntity.shaderParms[SHADERPARM_GREEN]		= 1.0f;
	renderEntity.shaderParms[SHADERPARM_BLUE]		= 1.0f;
	renderEntity.shaderParms[SHADERPARM_ALPHA]		= 1.0f;
	renderEntity.shaderParms[SHADERPARM_TIMEOFFSET] = -MS2SEC( gameLocal.time );
	renderEntity.shaderParms[SHADERPARM_DIVERSITY]	= 0.0f;
	Show();

	PostEventMS( &EV_Remove, 2000 );

	ActivateTargets( activator );
}


/*
===============================================================================

  idSpring
	
===============================================================================
*/

CLASS_DECLARATION( idEntity, idSpring )
	EVENT( EV_PostSpawn,	idSpring::Event_LinkSpring )
END_CLASS

/*
================
idSpring::Think
================
*/
void idSpring::Think( void ) {
	idVec3 start, end, origin;
	idMat3 axis;

	// run physics
	RunPhysics();

	if ( thinkFlags & TH_THINK ) {
		// evaluate force
		spring.Evaluate( gameLocal.time );

		start = p1;
		if ( ent1 && ent1->GetPhysics() ) {
			axis = ent1->GetPhysics()->GetAxis();
			origin = ent1->GetPhysics()->GetOrigin();
			start = origin + start * axis;
		}

		end = p2;
		if ( ent2 && ent2->GetPhysics() ) {
			axis = ent2->GetPhysics()->GetAxis();
			origin = ent2->GetPhysics()->GetOrigin();
			end = origin + p2 * axis;
		}
		
		gameRenderWorld->DebugLine( idVec4(1, 1, 0, 1), start, end, 0, true );
	}

	Present();
}

/*
================
idSpring::Event_LinkSpring
================
*/
void idSpring::Event_LinkSpring( void ) {
	idStr name1, name2;

	spawnArgs.GetString( "ent1", "", name1 );
	spawnArgs.GetString( "ent2", "", name2 );

	if ( name1.Length() ) {
		ent1 = gameLocal.FindEntity( name1 );
		if ( !ent1 ) {
			gameLocal.Error( "idSpring '%s' at (%s): cannot find first entity '%s'", name.c_str(), GetPhysics()->GetOrigin().ToString(0), name1.c_str() );
		}
	}
	else {
		ent1 = gameLocal.entities[ENTITYNUM_WORLD];
	}

	if ( name2.Length() ) {
		ent2 = gameLocal.FindEntity( name2 );
		if ( !ent2 ) {
			gameLocal.Error( "idSpring '%s' at (%s): cannot find second entity '%s'", name.c_str(), GetPhysics()->GetOrigin().ToString(0), name2.c_str() );
		}
	}
	else {
		ent2 = gameLocal.entities[ENTITYNUM_WORLD];
	}
	spring.SetPosition( ent1->GetPhysics(), id1, p1, ent2->GetPhysics(), id2, p2 );
	BecomeActive( TH_THINK );
}

/*
================
idSpring::Spawn
================
*/
void idSpring::Spawn( void ) {
	float Kstretch, damping, restLength;

	spawnArgs.GetInt( "id1", "0", id1 );
	spawnArgs.GetInt( "id2", "0", id2 );
	spawnArgs.GetVector( "point1", "0 0 0", p1 );
	spawnArgs.GetVector( "point2", "0 0 0", p2 );
	spawnArgs.GetFloat( "constant", "100.0f", Kstretch );
	spawnArgs.GetFloat( "damping", "10.0f", damping );
	spawnArgs.GetFloat( "restlength", "0.0f", restLength );

	spring.InitSpring( Kstretch, 0.0f, damping, restLength );

	ent1 = ent2 = NULL;

	PostEventMS( &EV_PostSpawn, 0 );
}

/*
================
idSpring::Save
================
*/
void idSpring::Save( idSaveGame *savefile ) const {
	savefile->WriteInt ( id1 );
	savefile->WriteInt ( id2 );
	savefile->WriteVec3 ( p1 );
	savefile->WriteVec3 ( p2 );
	spring.Save ( savefile );
}

/*
================
idSpring::Restore
================
*/
void idSpring::Restore( idRestoreGame *savefile ) {
	savefile->ReadInt ( id1 );
	savefile->ReadInt ( id2 );
	savefile->ReadVec3 ( p1 );
	savefile->ReadVec3 ( p2 );
	spring.Restore ( savefile );
	Event_LinkSpring ( );	
}

/*
===============================================================================

  idForceField
	
===============================================================================
*/

const idEventDef EV_Toggle( "Toggle", NULL );

CLASS_DECLARATION( idEntity, idForceField )
	EVENT( EV_Activate,		idForceField::Event_Activate )
	EVENT( EV_Toggle,		idForceField::Event_Toggle )
	EVENT( EV_FindTargets,	idForceField::Event_FindTargets )
END_CLASS

/*
===============
idForceField::Toggle
================
*/
void idForceField::Toggle( void ) {
	if ( thinkFlags & TH_THINK ) {
		BecomeInactive( TH_THINK );
	} else {
		BecomeActive( TH_THINK );
	}
}

/*
================
idForceField::Think
================
*/
void idForceField::Think( void ) {
	if ( thinkFlags & TH_THINK ) {
		// evaluate force
		forceField.Evaluate( gameLocal.time );
	}
	Present();
}

/*
================
idForceField::Save
================
*/
void idForceField::Save( idSaveGame *savefile ) const {
	savefile->WriteStaticObject( forceField );
}

/*
================
idForceField::Restore
================
*/
void idForceField::Restore( idRestoreGame *savefile ) {
	savefile->ReadStaticObject( forceField );
}

/*
================
idForceField::Spawn
================
*/
void idForceField::Spawn( void ) {
	idVec3 uniform;
	float explosion, implosion, randomTorque;

	if ( spawnArgs.GetVector( "uniform", "0 0 0", uniform ) ) {
		forceField.Uniform( uniform );
	} else if ( spawnArgs.GetFloat( "explosion", "0", explosion ) ) {
		forceField.Explosion( explosion );
	} else if ( spawnArgs.GetFloat( "implosion", "0", implosion ) ) {
		forceField.Implosion( implosion );
	}

	if ( spawnArgs.GetFloat( "randomTorque", "0", randomTorque ) ) {
		forceField.RandomTorque( randomTorque );
	}

	if ( spawnArgs.GetBool( "applyForce", "0" ) ) {
		forceField.SetApplyType( FORCEFIELD_APPLY_FORCE );
	} else if ( spawnArgs.GetBool( "applyImpulse", "0" ) ) {
		forceField.SetApplyType( FORCEFIELD_APPLY_IMPULSE );
	} else {
		forceField.SetApplyType( FORCEFIELD_APPLY_VELOCITY );
	}

	forceField.SetPlayerOnly( spawnArgs.GetBool( "playerOnly", "0" ) );
	forceField.SetMonsterOnly( spawnArgs.GetBool( "monsterOnly", "0" ) );

	// set the collision model on the force field

// mwhitlock: Dynamic memory consolidation
	RV_PUSH_HEAP_MEM(this);

	forceField.SetClipModel( new idClipModel( GetPhysics()->GetClipModel() ) );

// mwhitlock: Dynamic memory consolidation
	RV_POP_HEAP();

	forceField.SetOwner( this );
	// remove the collision model from the physics object
	GetPhysics()->SetClipModel( NULL, 1.0f );

	if ( spawnArgs.GetBool( "start_on" ) ) {
		BecomeActive( TH_THINK );
	}
}

/*
===============
idForceField::Event_Toggle
================
*/
void idForceField::Event_Toggle( void ) {
	Toggle();
}

/*
================
idForceField::Event_Activate
================
*/
void idForceField::Event_Activate( idEntity *activator ) {
	float wait;

	Toggle();
	if ( spawnArgs.GetFloat( "wait", "0.01", wait ) ) {
		PostEventSec( &EV_Toggle, wait );
	}
}

/*
================
idForceField::Event_FindTargets
================
*/
void idForceField::Event_FindTargets( void ) {
	FindTargets();
	RemoveNullTargets();
	if ( targets.Num() ) {
		forceField.Uniform( targets[0].GetEntity()->GetPhysics()->GetOrigin() - GetPhysics()->GetOrigin() );
	}
}


// bdube: jump pads

/*
===============================================================================

  idForceField
	
===============================================================================
*/

const int JUMPPAD_EFFECT_DELAY	= 100;

CLASS_DECLARATION( idForceField, rvJumpPad )
	EVENT( EV_FindTargets,	rvJumpPad::Event_FindTargets )
END_CLASS

/*
================
rvJumpPad::rvJumpPad
================
*/
rvJumpPad::rvJumpPad ( void ) {
	lastEffectTime = -1;
}

/*
================
rvJumpPad::Think
================
*/
void rvJumpPad::Think( void ) {
	if ( thinkFlags & TH_THINK ) {
		// evaluate force
		forceField.Evaluate( gameLocal.time );
		
		// If force has been applied to an entity and jump pad effect hasnt been played for a bit
		// then play it now.
		if ( forceField.GetLastApplyTime ( ) - lastEffectTime > JUMPPAD_EFFECT_DELAY ) {
			// start locally
			StartSound( "snd_jump", SND_CHANNEL_ITEM, 0, false, NULL );
			if ( spawnArgs.GetString( "fx_jump" )[ 0 ] ) {
				PlayEffect( "fx_jump", renderEntity.origin, effectAxis, false, vec3_origin, false );
			}

			// send through unreliable
			if ( gameLocal.isServer ) {
				idBitMsg	msg;
				byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];

				msg.Init( msgBuf, sizeof( msgBuf ) );
				msg.WriteByte( GAME_UNRELIABLE_MESSAGE_EVENT );
				msg.WriteBits( gameLocal.GetSpawnId( this ), 32 );
				msg.WriteByte( EVENT_JUMPFX );
				gameLocal.SendUnreliableMessagePVS( msg, this, gameLocal.pvs.GetPVSArea( renderEntity.origin ) );
			}
			
			lastEffectTime = forceField.GetLastApplyTime( );
		}
	}
	Present();
}

/*
================
rvJumpPad::Spawn
================
*/
void rvJumpPad::Spawn( void ) {
	forceField.SetApplyType( FORCEFIELD_APPLY_VELOCITY );
	forceField.SetOwner( this );
}

/*
================
rvJumpPad::Event_FindTargets
================
*/
void rvJumpPad::Event_FindTargets( void ) {
	FindTargets();
	RemoveNullTargets();
	if ( targets.Num() ) {
		idEntity* ent;
		ent = targets[0].GetEntity();
		assert( ent );
		
		idVec3 vert;
		idVec3 diff;
		idVec3 vel;
		idVec3 localGravity( gameLocal.GetCurrentGravity(this) );
		idVec3 localGravityNormal( localGravity.ToNormal() );
		float  time;
		float  dist;
		
		// Find the distance along the gravity vector between the jump pad and its target
		diff = (ent->GetPhysics()->GetOrigin() - GetPhysics()->GetOrigin());
		vert = (diff * localGravityNormal) * localGravityNormal;
		
		// Determine how long it would take to cover the distance along the gravity vector
		time = idMath::Sqrt( vert.Length() / (0.5f * localGravity.Length()) );
		if ( !time ) {
			PostEventMS( &EV_Remove, 0 );
			return;
		}

		// The final velocity is the direction between the jump pad and its target using
		// the travel time to determine the forward vector and adding in an inverse gravity vector.
		vel  = diff - vert;
		dist = vel.Normalize();
		
		vel = vel * (dist / time);
		vel += (localGravity * -time);

		forceField.Uniform( vel );

		// calculate a coordinate axis where the vector to the jumppad target is forward
		// use this to play the fx_jump fx
		diff.Normalize();
		effectAxis = diff.ToMat3();
	}
}

/*
===============
rvJumpPad::ClientReceiveEvent
===============
*/
bool rvJumpPad::ClientReceiveEvent( int event, int time, const idBitMsg &msg ) {
	switch ( event ) {
	case EVENT_JUMPFX: {
		if ( spawnArgs.GetString( "fx_jump" )[ 0 ] ) {
			PlayEffect( "fx_jump", renderEntity.origin, effectAxis, false, vec3_origin, false );
		}
		StartSound( "snd_jump", SND_CHANNEL_ITEM, 0, false, NULL );
		return true;
	}
	default:
		return idEntity::ClientReceiveEvent( event, time, msg );
	}
}



/*
===============================================================================

	idAnimated

===============================================================================
*/

const idEventDef EV_Animated_Start( "<start>" );
const idEventDef EV_LaunchMissiles( "launchMissiles", "ssssdf" );
const idEventDef EV_LaunchMissilesUpdate( "<launchMissiles>", "dddd" );
const idEventDef EV_AnimDone( "<AnimDone>", "d" );
const idEventDef EV_StartRagdoll( "startRagdoll" );


// bdube: script object
const idEventDef EV_SetAnimState ( "setAnimState", "sd" );


CLASS_DECLARATION( idAFEntity_Gibbable, idAnimated )
	EVENT( EV_Activate,				idAnimated::Event_Activate )
	EVENT( EV_Animated_Start,		idAnimated::Event_Start )
	EVENT( EV_StartRagdoll,			idAnimated::Event_StartRagdoll )
	EVENT( EV_AnimDone,				idAnimated::Event_AnimDone )
	EVENT( EV_Footstep,				idAnimated::Event_Footstep )
	EVENT( EV_FootstepLeft,			idAnimated::Event_Footstep )
	EVENT( EV_FootstepRight,		idAnimated::Event_Footstep )
	EVENT( EV_LaunchMissiles,		idAnimated::Event_LaunchMissiles )
	EVENT( EV_LaunchMissilesUpdate,	idAnimated::Event_LaunchMissilesUpdate )


// bdube: script object
	EVENT( EV_SetAnimState,			idAnimated::Event_SetAnimState )
	EVENT( AI_PlayAnim,				idAnimated::Event_PlayAnim )
	EVENT( AI_PlayCycle,			idAnimated::Event_PlayCycle )
	EVENT( AI_AnimDone,				idAnimated::Event_AnimDone2 )


END_CLASS

/*
===============
idAnimated::idAnimated
================
*/
idAnimated::idAnimated() {
	int		i;

	anim = 0;
	blendFrames = 0;
	soundJoint = INVALID_JOINT;
	activated = false;
	combatModel = NULL;
	activator = NULL;
	current_anim_index = 0;
	num_anims = 0;

// bdube: script control
	scriptThread = NULL;
	for( i = 0; i < ANIM_NumAnimChannels; i++ ) {
		animDoneTime[i] = 0;
	}

}

/*
===============
idAnimated::idAnimated
================
*/
idAnimated::~idAnimated() {
	delete combatModel;
	combatModel = NULL;
	

// bdube: kill script object
	delete scriptThread;
		
}

/*
===============
idAnimated::Save
================
*/
void idAnimated::Save( idSaveGame *savefile ) const {
	int		i;

	savefile->WriteInt( num_anims );
	savefile->WriteInt( current_anim_index );
	savefile->WriteInt( anim );
	savefile->WriteInt( blendFrames );
	savefile->WriteJoint( soundJoint );
	activator.Save( savefile );
	savefile->WriteBool( activated );


	savefile->WriteObject( scriptThread );
	savefile->WriteString( state );
	savefile->WriteString( idealState );
	for( i = 0; i < ANIM_NumAnimChannels; i++ ) {
		savefile->WriteInt( animDoneTime[i] );
	}

}

/*
===============
idAnimated::Restore
================
*/
void idAnimated::Restore( idRestoreGame *savefile ) {
	int		i;

	savefile->ReadInt( num_anims );
	savefile->ReadInt( current_anim_index );
	savefile->ReadInt( anim );
	savefile->ReadInt( blendFrames );
	savefile->ReadJoint( soundJoint );
	activator.Restore( savefile );
	savefile->ReadBool( activated );


	savefile->ReadObject( reinterpret_cast<idClass *&>( scriptThread ) );
	savefile->ReadString( state );
	savefile->ReadString( idealState );
	for( i = 0; i < ANIM_NumAnimChannels; i++ ) {
		savefile->ReadInt( animDoneTime[i] );
	}

}

/*
===============
idAnimated::Spawn
================
*/
void idAnimated::Spawn( void ) {
	idStr		animname;
	int			anim2;
	float		wait;
	const char	*joint;

	joint = spawnArgs.GetString( "sound_bone", "origin" ); 
	soundJoint = animator.GetJointHandle( joint );
	if ( soundJoint == INVALID_JOINT ) {
		gameLocal.Warning( "idAnimated '%s' at (%s): cannot find joint '%s' for sound playback", name.c_str(), GetPhysics()->GetOrigin().ToString(0), joint );
	}

	LoadAF( NULL );

	// allow bullets to collide with a combat model
	if ( spawnArgs.GetBool( "combatModel", "0" ) ) {

// mwhitlock: Dynamic memory consolidation
		RV_PUSH_HEAP_MEM(this);

		combatModel = new idClipModel( modelDefHandle );

// mwhitlock: Dynamic memory consolidation
		RV_POP_HEAP();

	}

	// allow the entity to take damage
	if ( spawnArgs.GetBool( "takeDamage", "0" ) ) {
		fl.takedamage = true;
	}

	blendFrames = 0;


// bdube: script control
	// setup script object
	const char* scriptObjectName;
	if ( spawnArgs.GetString( "scriptobject", NULL, &scriptObjectName ) ) {
		if ( !scriptObject.SetType( scriptObjectName ) ) {
			gameLocal.Error( "Script object '%s' not found on entity '%s'.", scriptObjectName, name.c_str() );
		}

		// init the script object's data
		scriptObject.ClearObject();

		// call script object's constructor
		const function_t *constructor;
		constructor = scriptObject.GetConstructor();
		if ( constructor ) {
			// start a thread that will initialize after Spawn is done being called

// mwhitlock: Dynamic memory consolidation
			RV_PUSH_HEAP_MEM(this);

			scriptThread = new idThread();

// mwhitlock: Dynamic memory consolidation
			RV_POP_HEAP();

			scriptThread->ManualDelete();
			scriptThread->ManualControl();
			scriptThread->SetThreadName( name.c_str() );
			scriptThread->CallFunction( this, constructor, true );
			scriptThread->Execute ( );
		}
	
		fl.takedamage = true;

		return;
	}	


	current_anim_index = 0;
	spawnArgs.GetInt( "num_anims", "0", num_anims );

	blendFrames = spawnArgs.GetInt( "blend_in" );

	animname = spawnArgs.GetString( num_anims ? "anim1" : "anim" );
	if ( !animname.Length() ) {
		anim = 0;
	} else {
		anim = animator.GetAnim( animname );
		if ( !anim ) {
			gameLocal.Error( "idAnimated '%s' at (%s): cannot find anim '%s'", name.c_str(), GetPhysics()->GetOrigin().ToString(0), animname.c_str() );
		}
	}

	if ( spawnArgs.GetBool( "hide" ) ) {
		Hide();

		if ( !num_anims ) {
			blendFrames = 0;
		}
	} else if ( spawnArgs.GetString( "start_anim", "", animname ) ) {
		anim2 = animator.GetAnim( animname );
		if ( !anim2 ) {
			gameLocal.Error( "idAnimated '%s' at (%s): cannot find anim '%s'", name.c_str(), GetPhysics()->GetOrigin().ToString(0), animname.c_str() );
		}
		animator.CycleAnim( ANIMCHANNEL_ALL, anim2, gameLocal.time, 0 );
	} else if ( anim ) {
		// init joints to the first frame of the animation

		frameBlend_t frameBlend = { 0, 0, 0, 1.0f, 0 };
		animator.SetFrame( ANIMCHANNEL_ALL, anim, frameBlend );		


		if ( !num_anims ) {
			blendFrames = 0;
		}
	}

	spawnArgs.GetFloat( "wait", "-1", wait );

	if ( wait >= 0 ) {
		PostEventSec( &EV_Activate, wait, this );
	}
}

/*
===============
idAnimated::LoadAF
===============
*/
bool idAnimated::LoadAF( const char* keyname ) {
	idStr fileName;

	if ( !keyname || !*keyname ) {
		keyname = "ragdoll";
	}

	if ( !spawnArgs.GetString( keyname, "*unknown*", fileName ) ) {
		return false;
	}
	af.SetAnimator( GetAnimator() );
	return af.Load( this, fileName );
}

/*
===============
idAnimated::GetPhysicsToSoundTransform
===============
*/
bool idAnimated::GetPhysicsToSoundTransform( idVec3 &origin, idMat3 &axis ) {
	animator.GetJointTransform( soundJoint, gameLocal.time, origin, axis );
	axis = renderEntity.axis;
	return true;
}

/*
================
idAnimated::StartRagdoll
================
*/
bool idAnimated::StartRagdoll( void ) {
	// if no AF loaded
	if ( !af.IsLoaded() ) {
		return false;
	}

	// if the AF is already active
	if ( af.IsActive() ) {
		return true;
	}

	// disable any collision model used
	GetPhysics()->DisableClip();

	// start using the AF
	af.StartFromCurrentPose( spawnArgs.GetInt( "velocityTime", "0" ) );
	
	return true;
}

/*
=====================
idAnimated::PlayNextAnim
=====================
*/
void idAnimated::PlayNextAnim( void ) {
	const char *animname;
	int len;
	int cycle;

	if ( current_anim_index >= num_anims ) {
		Hide();
		if ( spawnArgs.GetBool( "remove" ) ) {
			PostEventMS( &EV_Remove, 0 );
		} else {
			current_anim_index = 0;
		}
		return;
	}

	Show();
	current_anim_index++;

	spawnArgs.GetString( va( "anim%d", current_anim_index ), NULL, &animname );
	if ( !animname ) {
		anim = 0;
		animator.Clear( ANIMCHANNEL_ALL, gameLocal.time, FRAME2MS( blendFrames ) );
		return;
	}

	anim = animator.GetAnim( animname );
	if ( !anim ) {
		gameLocal.Warning( "missing anim '%s' on %s", animname, name.c_str() );
		return;
	}

	if ( g_debugCinematic.GetBool() ) {
		gameLocal.Printf( "%d: '%s' start anim '%s'\n", gameLocal.framenum, GetName(), animname );
	}
		
	spawnArgs.GetInt( "cycle", "1", cycle );
	if ( ( current_anim_index == num_anims ) && spawnArgs.GetBool( "loop_last_anim" ) ) {
		cycle = -1;
	}

	animator.CycleAnim( ANIMCHANNEL_ALL, anim, gameLocal.time, FRAME2MS( blendFrames ) );
	animator.CurrentAnim( ANIMCHANNEL_ALL )->SetCycleCount( cycle );

	len = animator.CurrentAnim( ANIMCHANNEL_ALL )->PlayLength();
	if ( len >= 0 ) {
		PostEventMS( &EV_AnimDone, len, current_anim_index );
	}

	// offset the start time of the shader to sync it to the game time
	renderEntity.shaderParms[ SHADERPARM_TIMEOFFSET ] = -MS2SEC( gameLocal.time );

	animator.ForceUpdate();
	UpdateAnimation();
	UpdateVisuals();
	Present();
}

/*
===============
idAnimated::Event_StartRagdoll
================
*/
void idAnimated::Event_StartRagdoll( void ) {
	StartRagdoll();
}

/*
===============
idAnimated::Event_AnimDone
================
*/
void idAnimated::Event_AnimDone( int animindex ) {
	if ( g_debugCinematic.GetBool() ) {
		const idAnim *animPtr = animator.GetAnim( anim );
		gameLocal.Printf( "%d: '%s' end anim '%s'\n", gameLocal.framenum, GetName(), animPtr ? animPtr->Name() : "" );
	}

	if ( ( animindex >= num_anims ) && spawnArgs.GetBool( "remove" ) ) {
		Hide();
		PostEventMS( &EV_Remove, 0 );
	} else if ( spawnArgs.GetBool( "auto_advance" ) ) {
		PlayNextAnim();
	} else {
		activated = false;
	}

	ActivateTargets( activator.GetEntity() );
}

/*
===============
idAnimated::Event_Activate
================
*/
void idAnimated::Event_Activate( idEntity *_activator ) {

// bdube: script object support
	if ( scriptThread ) {
		CallHandler ( "onActivate" );
		return;
	}


	if ( num_anims ) {
		PlayNextAnim();
		activator = _activator;
		return;
	}

	if ( activated ) {
		// already activated
		return;
	}

	activated = true;
	activator = _activator;
	ProcessEvent( &EV_Animated_Start );
}

/*
===============
idAnimated::Event_Start
================
*/
void idAnimated::Event_Start( void ) {
	int cycle;
	int len;

	Show();

	if ( num_anims ) {
		PlayNextAnim();
		return;
	}

	if ( anim ) {
		if ( g_debugCinematic.GetBool() ) {
			const idAnim *animPtr = animator.GetAnim( anim );
			gameLocal.Printf( "%d: '%s' start anim '%s'\n", gameLocal.framenum, GetName(), animPtr ? animPtr->Name() : "" );
		}
		spawnArgs.GetInt( "cycle", "1", cycle );
		animator.CycleAnim( ANIMCHANNEL_ALL, anim, gameLocal.time, FRAME2MS( blendFrames ) );
		animator.CurrentAnim( ANIMCHANNEL_ALL )->SetCycleCount( cycle );

		len = animator.CurrentAnim( ANIMCHANNEL_ALL )->PlayLength();
		if ( len >= 0 ) {
			PostEventMS( &EV_AnimDone, len, 1 );
		}
	}

	// offset the start time of the shader to sync it to the game time
	renderEntity.shaderParms[ SHADERPARM_TIMEOFFSET ] = -MS2SEC( gameLocal.time );

	animator.ForceUpdate();
	UpdateAnimation();
	UpdateVisuals();
	Present();
}

/*
===============
idAnimated::Event_Footstep
===============
*/
void idAnimated::Event_Footstep( void ) {
	StartSound( "snd_footstep", SND_CHANNEL_BODY, 0, false, NULL );
}

/*
=====================
idAnimated::Event_LaunchMissilesUpdate
=====================
*/
void idAnimated::Event_LaunchMissilesUpdate( int launchjoint, int targetjoint, int numshots, int framedelay ) {
	idVec3			launchPos;
	idVec3			targetPos;
	idMat3			axis;
	idVec3			dir;
	idEntity *		ent;
	idProjectile *	projectile;
	const idDict *	projectileDef;
	const char *	projectilename;

	projectilename = spawnArgs.GetString( "projectilename" );
	projectileDef = gameLocal.FindEntityDefDict( projectilename, false );
	if ( !projectileDef ) {
		gameLocal.Warning( "idAnimated '%s' at (%s): 'launchMissiles' called with unknown projectile '%s'", name.c_str(), GetPhysics()->GetOrigin().ToString(0), projectilename );
		return;
	}

	StartSound( "snd_missile", SND_CHANNEL_WEAPON, 0, false, NULL );

	animator.GetJointTransform( ( jointHandle_t )launchjoint, gameLocal.time, launchPos, axis );
	launchPos = renderEntity.origin + launchPos * renderEntity.axis;
	

// bdube: with no target bone it will just shoot out the direction of the bones orientation
	if ( targetjoint != INVALID_JOINT ) {
		animator.GetJointTransform( ( jointHandle_t )targetjoint, gameLocal.time, targetPos, axis );
		targetPos = renderEntity.origin + targetPos * renderEntity.axis;
		dir = targetPos - launchPos;
	} else {
		axis *= renderEntity.axis;
		dir = axis[0];
	}


	dir.Normalize();

	gameLocal.SpawnEntityDef( *projectileDef, &ent, false );

// jnewquist: Use accessor for static class type 
	if ( !ent || !ent->IsType( idProjectile::GetClassType() ) ) {

		gameLocal.Error( "idAnimated '%s' at (%s): in 'launchMissiles' call '%s' is not an idProjectile", name.c_str(), GetPhysics()->GetOrigin().ToString(0), projectilename );
	}
	projectile = ( idProjectile * )ent;
	//projectile->Create( this, NULL, NULL, launchPos, dir );
	//projectile->Launch( launchPos, dir, vec3_origin );

	if ( numshots > 0 ) {
		PostEventMS( &EV_LaunchMissilesUpdate, FRAME2MS( framedelay ), launchjoint, targetjoint, numshots - 1, framedelay );
	}
}

/*
=====================
idAnimated::Event_LaunchMissiles
=====================
*/
void idAnimated::Event_LaunchMissiles( const char *projectilename, const char *sound, const char *launchjoint, const char *targetjoint, int numshots, int framedelay ) {
	const idDict *	projectileDef;
	jointHandle_t	launch;
	jointHandle_t	target;

	projectileDef = gameLocal.FindEntityDefDict( projectilename, false );
	if ( !projectileDef ) {
		gameLocal.Warning( "idAnimated '%s' at (%s): unknown projectile '%s'", name.c_str(), GetPhysics()->GetOrigin().ToString(0), projectilename );
		return;
	}

	launch = animator.GetJointHandle( launchjoint );
	if ( launch == INVALID_JOINT ) {
		gameLocal.Warning( "idAnimated '%s' at (%s): unknown launch joint '%s'", name.c_str(), GetPhysics()->GetOrigin().ToString(0), launchjoint );
		gameLocal.Error( "Unknown joint '%s'", launchjoint );
	}

	target = animator.GetJointHandle( targetjoint );

// bdube: invalid is ok now, it means shoot out the direction of the bone
//	if ( target == INVALID_JOINT ) {
//		gameLocal.Warning( "idAnimated '%s' at (%s): unknown target joint '%s'", name.c_str(), GetPhysics()->GetOrigin().ToString(0), targetjoint );
//	}


	spawnArgs.Set( "projectilename", projectilename );
	spawnArgs.Set( "missilesound", sound );

	CancelEvents( &EV_LaunchMissilesUpdate );

// nmckenzie: Do this now.  No delays.  No event loops or updates.  Just a straightforward DO THIS.  Tacky.
	if ( numshots == 1 && framedelay == 0 ){
		Event_LaunchMissilesUpdate ( launch, target, 1, 0 );
	}
	else{
		ProcessEvent( &EV_LaunchMissilesUpdate, launch, target, numshots - 1, framedelay );
	}

}


// bdube: added
/*
=====================
idAnimated::ShouldConstructScriptObjectAtSpawn
=====================
*/
bool idAnimated::ShouldConstructScriptObjectAtSpawn( void ) const {
	return false;
}

/*
=====================
idAnimated::Think
=====================
*/
void idAnimated::Think ( void ) {
	UpdateScript ( );
	idAFEntity_Gibbable::Think ( );
}

/*
=====================
idAnimated::Think
=====================
*/
void idAnimated::Damage ( idEntity* inflictor, idEntity* attacker, const idVec3& dir, const char* damageDefName, const float damageScale, const int location ) {
	if ( !scriptThread ) {
		return;
	}

	CallHandler ( "onDamage" );	
}

/*
=====================
idAnimated::Event_PlayAnim
=====================
*/
void idAnimated::Event_PlayAnim( int channel, const char *animname ) {
	int anim;
	
	anim = animator.GetAnim( animname );
	if ( !anim ) {
		gameLocal.Warning( "missing '%s' animation on '%s' (%s)", animname, name.c_str(), GetEntityDefName() );
		animator.Clear( channel, gameLocal.time, FRAME2MS( blendFrames ) );
		animDoneTime[channel] = 0;
		idThread::ReturnFloat( false );
	} else {
		animator.PlayAnim( channel, anim, gameLocal.time, FRAME2MS( blendFrames ) );
		animDoneTime[channel] = animator.CurrentAnim( channel )->GetEndTime();
		idThread::ReturnFloat( MS2SEC( animDoneTime[channel] - gameLocal.time ) );
	}
	blendFrames = 0;
}

/*
===============
idAnimated::Event_PlayCycle
===============
*/
void idAnimated::Event_PlayCycle( int channel, const char *animname ) {
	int anim;

	anim = animator.GetAnim( animname );
	if ( !anim ) {
		gameLocal.Warning( "missing '%s' animation on '%s' (%s)", animname, name.c_str(), GetEntityDefName() );
		animator.Clear( channel, gameLocal.time, FRAME2MS( blendFrames ) );
		animDoneTime[channel] = 0;
	} else {
		animator.CycleAnim( channel, anim, gameLocal.time, FRAME2MS( blendFrames ) );
		animDoneTime[channel] = animator.CurrentAnim( channel )->GetEndTime();
	}
	blendFrames = 0;
}

/*
===============
idAnimated::Event_AnimDone2
===============
*/
void idAnimated::Event_AnimDone2( int channel, int blend ) {
	if ( animDoneTime[channel] - FRAME2MS( blend ) <= gameLocal.time ) {
		idThread::ReturnInt( true );
	} else {
		idThread::ReturnInt( false );
	}
}

/*
===============
idAnimated::Event_SetAnimState 
===============
*/
void idAnimated::Event_SetAnimState  ( const char* statename, int blend ) {
	const function_t *func;

	func = scriptObject.GetFunction( statename );
	if ( !func ) {
		gameLocal.Error( "Can't find function '%s' in object '%s'", statename, scriptObject.GetTypeName() );
	}

	idealState = statename;
	blendFrames = blend;
	scriptThread->DoneProcessing();
}

/*
================
idAnimated::UpdateScript
================
*/
void idAnimated::UpdateScript( void ) {
	int	count;

	if ( !scriptThread || !gameLocal.isNewFrame  ) {
		return;
	}

	if ( idealState.Length() ) {
		SetState( idealState, blendFrames );
	}
	
	// If no state has been set then dont execute nothing
	if ( !state.Length ( ) || scriptThread->IsWaiting() ) {
		return;
	}

	// update script state
	count = 10;
	while( ( scriptThread->Execute() || idealState.Length() ) && count-- ) {
		if ( idealState.Length() ) {
			SetState( idealState, blendFrames );
		}
	}
}

/*
=====================
idAnimated::CallHandler
=====================
*/
void idAnimated::CallHandler ( const char* handler ) {
	const function_t *func;
	func = scriptObject.GetFunction( handler );
	if ( !func ) {
		return;
	}

	scriptThread->CallFunction( this, func, false );
	scriptThread->Execute ( );
}

/*
=====================
idAnimated::SetState
=====================
*/
void idAnimated::SetState( const char *statename, int frames ) {
	const function_t *func;

	func = scriptObject.GetFunction( statename );
	if ( !func ) {
		gameLocal.Error( "Can't find function '%s' in object '%s'", statename, scriptObject.GetTypeName() );
	}

	scriptThread->CallFunction( this, func, true );
	state = statename;
	blendFrames = frames;
	idealState = "";
}



/*
===============================================================================

	idStaticEntity

	Some static entities may be optimized into inline geometry by dmap

===============================================================================
*/

CLASS_DECLARATION( idEntity, idStaticEntity )
	EVENT( EV_Activate,				idStaticEntity::Event_Activate )
END_CLASS

/*
===============
idStaticEntity::idStaticEntity
===============
*/
idStaticEntity::idStaticEntity( void ) {
	spawnTime = 0;
	active = false;
	fadeFrom.Set( 1, 1, 1, 1 );
	fadeTo.Set( 1, 1, 1, 1 );
	fadeStart = 0;
	fadeEnd	= 0;
	runGui = false;
}

/*
===============
idStaticEntity::Save
===============
*/
void idStaticEntity::Save( idSaveGame *savefile ) const {
	savefile->WriteInt( spawnTime );
	savefile->WriteBool( active );
	savefile->WriteVec4( fadeFrom );
	savefile->WriteVec4( fadeTo );
	savefile->WriteInt( fadeStart );
	savefile->WriteInt( fadeEnd );
	savefile->WriteBool( runGui );
}

/*
===============
idStaticEntity::Restore
===============
*/
void idStaticEntity::Restore( idRestoreGame *savefile ) {
	savefile->ReadInt( spawnTime );
	savefile->ReadBool( active );
	savefile->ReadVec4( fadeFrom );
	savefile->ReadVec4( fadeTo );
	savefile->ReadInt( fadeStart );
	savefile->ReadInt( fadeEnd );
	savefile->ReadBool( runGui );
}

/*
===============
idStaticEntity::Spawn
===============
*/
void idStaticEntity::Spawn( void ) {
	bool solid;
	bool hidden;
	bool keepContents;


// rjohnson: inline models can be solid, since the entities hang around anyway (don't know why it was done that way)
	solid = spawnArgs.GetBool( "solid" );

	// an inline static model will not do anything at all
	if ( spawnArgs.GetBool( "inline" ) || gameLocal.world->spawnArgs.GetBool( "inlineAllStatics" ) ) {
		Hide();
		if ( solid ) {
			GetPhysics()->SetContents( CONTENTS_SOLID );
		}
		return;
	}


	hidden = spawnArgs.GetBool( "hide" );
	keepContents = spawnArgs.GetBool( "KeepContents" );

	if ( keepContents ) {
		// do nothing, keep the contents from the model
	} else if ( solid && !hidden ) {
		GetPhysics()->SetContents( CONTENTS_SOLID );
	} else {
		GetPhysics()->SetContents( 0 );
	}

	spawnTime = gameLocal.time;
	active = false;

	idStr model = spawnArgs.GetString( "model" );
	// FIXME: temp also catch obsolete .ips extension
	if ( model.Find( ".ips" ) >= 0 || model.Find( ".prt" ) >= 0 ) {
		// we want the parametric particles out of sync with each other
		renderEntity.shaderParms[ SHADERPARM_TIMEOFFSET ] = gameLocal.random.RandomInt( 32767 );
	}

	fadeFrom.Set( 1, 1, 1, 1 );
	fadeTo.Set( 1, 1, 1, 1 );
	fadeStart = 0;
	fadeEnd	= 0;

	// NOTE: this should be used very rarely because it is expensive
	runGui = spawnArgs.GetBool( "runGui" );
	if ( runGui ) {
		BecomeActive( TH_THINK );
	}
}

/*
================
idStaticEntity::ShowEditingDialog
================
*/
void idStaticEntity::ShowEditingDialog( void ) {

// bdube: not using
//	common->InitTool( EDITOR_PARTICLE, &spawnArgs );

}
/*
================
idStaticEntity::Think
================
*/
void idStaticEntity::Think( void ) {
	idEntity::Think();
	if ( thinkFlags & TH_THINK ) {
		if ( runGui && renderEntity.gui[0] ) {
			idPlayer *player = gameLocal.GetLocalPlayer();
			if ( player ) {
				for( int i = 0; i < MAX_RENDERENTITY_GUI; i++ ) {
					if ( renderEntity.gui[ i ] ) {
						renderEntity.gui[ i ]->StateChanged( gameLocal.time, true );
					}
				}
			}
		}
		if ( fadeEnd > 0 ) {
			idVec4 color;
			if ( gameLocal.time < fadeEnd ) {
				color.Lerp( fadeFrom, fadeTo, ( float )( gameLocal.time - fadeStart ) / ( float )( fadeEnd - fadeStart ) );
			} else {
				color = fadeTo;
				fadeEnd = 0;
				BecomeInactive( TH_THINK );
			}
			SetColor( color );
		}
	}
}

/*
================
idStaticEntity::Fade
================
*/
void idStaticEntity::Fade( const idVec4 &to, float fadeTime ) {
	GetColor( fadeFrom );
	fadeTo = to;
	fadeStart = gameLocal.time;
	fadeEnd = gameLocal.time + SEC2MS( fadeTime );
	BecomeActive( TH_THINK );
}

/*
================
idStaticEntity::Hide
================
*/
void idStaticEntity::Hide( void ) {
	idEntity::Hide();
	GetPhysics()->SetContents( 0 );
}

/*
================
idStaticEntity::Show
================
*/
void idStaticEntity::Show( void ) {
	idEntity::Show();
	if ( spawnArgs.GetBool( "solid" ) ) {
		GetPhysics()->SetContents( CONTENTS_SOLID );
	}
}

/*
================
idStaticEntity::Event_Activate
================
*/
void idStaticEntity::Event_Activate( idEntity *activator ) {
	idStr activateGui;

	spawnTime = gameLocal.time;
	active = !active;

	const idKeyValue *kv = spawnArgs.FindKey( "hide" );
	if ( kv ) {
		if ( IsHidden() ) {
			Show();
		} else {
			Hide();
		}
	}

	renderEntity.shaderParms[ SHADERPARM_TIMEOFFSET ] = -MS2SEC( spawnTime );
	renderEntity.shaderParms[5] = active;
	// this change should be a good thing, it will automatically turn on 
	// lights etc.. when triggered so that does not have to be specifically done
	// with trigger parms.. it MIGHT break things so need to keep an eye on it
	renderEntity.shaderParms[ SHADERPARM_MODE ] = ( renderEntity.shaderParms[ SHADERPARM_MODE ] ) ?  0.0f : 1.0f;
	BecomeActive( TH_UPDATEVISUALS );
}

/*
================
idStaticEntity::WriteToSnapshot
================
*/
void idStaticEntity::WriteToSnapshot( idBitMsgDelta &msg ) const {
	GetPhysics()->WriteToSnapshot( msg );
	WriteBindToSnapshot( msg );
	//WriteColorToSnapshot( msg );
	WriteGUIToSnapshot( msg );
	msg.WriteBits( IsHidden()?1:0, 1 );
}

/*
================
idStaticEntity::ReadFromSnapshot
================
*/
void idStaticEntity::ReadFromSnapshot( const idBitMsgDelta &msg ) {
	bool hidden;

	GetPhysics()->ReadFromSnapshot( msg );
	ReadBindFromSnapshot( msg );
	//ReadColorFromSnapshot( msg );
	ReadGUIFromSnapshot( msg );
	hidden = msg.ReadBits( 1 ) == 1;
	if ( hidden != IsHidden() ) {
		if ( hidden ) {
			Hide();
		} else {
			Show();
		}
	}
	if ( msg.HasChanged() ) {
		UpdateVisuals();
	}
}


/*
===============================================================================

idFuncEmitter

===============================================================================
*/


CLASS_DECLARATION( idStaticEntity, idFuncEmitter )
EVENT( EV_Activate,				idFuncEmitter::Event_Activate )
END_CLASS

/*
===============
idFuncEmitter::idFuncEmitter
===============
*/
idFuncEmitter::idFuncEmitter( void ) {
	hidden = false;
}

/*
===============
idFuncEmitter::Spawn
===============
*/
void idFuncEmitter::Spawn( void ) {
	if ( spawnArgs.GetBool( "start_off" ) ) {
		hidden = true;
		renderEntity.shaderParms[SHADERPARM_PARTICLE_STOPTIME] = MS2SEC( 1 );
		UpdateVisuals();
	} else {
		hidden = false;
	}
}

/*
===============
idFuncEmitter::Save
===============
*/
void idFuncEmitter::Save( idSaveGame *savefile ) const {
	savefile->WriteBool( hidden );
}

/*
===============
idFuncEmitter::Restore
===============
*/
void idFuncEmitter::Restore( idRestoreGame *savefile ) {
	savefile->ReadBool( hidden );
}

/*
================
idFuncEmitter::Event_Activate
================
*/
void idFuncEmitter::Event_Activate( idEntity *activator ) {
	if ( hidden || spawnArgs.GetBool( "cycleTrigger" ) ) {
		renderEntity.shaderParms[SHADERPARM_PARTICLE_STOPTIME] = 0;
		renderEntity.shaderParms[SHADERPARM_TIMEOFFSET] = -MS2SEC( gameLocal.time );
		hidden = false;
	} else {
		renderEntity.shaderParms[SHADERPARM_PARTICLE_STOPTIME] = MS2SEC( gameLocal.time );
		hidden = true;
	}
	UpdateVisuals();
}

/*
================
idFuncEmitter::WriteToSnapshot
================
*/
void idFuncEmitter::WriteToSnapshot( idBitMsgDelta &msg ) const {
	msg.WriteBits( hidden ? 1 : 0, 1 );
	msg.WriteFloat( renderEntity.shaderParms[ SHADERPARM_PARTICLE_STOPTIME ] );
	msg.WriteFloat( renderEntity.shaderParms[ SHADERPARM_TIMEOFFSET ] );
}

/*
================
idFuncEmitter::ReadFromSnapshot
================
*/
void idFuncEmitter::ReadFromSnapshot( const idBitMsgDelta &msg ) {
	hidden = msg.ReadBits( 1 ) != 0;
	renderEntity.shaderParms[ SHADERPARM_PARTICLE_STOPTIME ] = msg.ReadFloat();
	renderEntity.shaderParms[ SHADERPARM_TIMEOFFSET ] = msg.ReadFloat();
	if ( msg.HasChanged() ) {
		UpdateVisuals();
	}
}




/*
===============================================================================

	idVacuumSeperatorEntity

	Can be triggered to let vacuum through a portal (blown out window)

===============================================================================
*/

CLASS_DECLARATION( idEntity, idVacuumSeparatorEntity )
	EVENT( EV_Activate,		idVacuumSeparatorEntity::Event_Activate )
END_CLASS


/*
================
idVacuumSeparatorEntity::idVacuumSeparatorEntity
================
*/
idVacuumSeparatorEntity::idVacuumSeparatorEntity( void ) {
	portal = 0;
}

/*
================
idVacuumSeparatorEntity::Save
================
*/
void idVacuumSeparatorEntity::Save( idSaveGame *savefile ) const {
	savefile->WriteInt( (int)portal );
	savefile->WriteInt( gameRenderWorld->GetPortalState( portal ) );
}

/*
================
idVacuumSeparatorEntity::Restore
================
*/
void idVacuumSeparatorEntity::Restore( idRestoreGame *savefile ) {
	int state;

	savefile->ReadInt( (int &)portal );
	savefile->ReadInt( state );

	gameLocal.SetPortalState( portal, state );
}

/*
================
idVacuumSeparatorEntity::Spawn
================
*/
void idVacuumSeparatorEntity::Spawn() {
	idBounds b;

	b = idBounds( spawnArgs.GetVector( "origin" ) ).Expand( 16 );
	portal = gameRenderWorld->FindPortal( b );
	if ( !portal ) {
		gameLocal.Warning( "VacuumSeparator '%s' didn't contact a portal", spawnArgs.GetString( "name" ) );
		return;
	}
	gameLocal.SetPortalState( portal, PS_BLOCK_AIR | PS_BLOCK_LOCATION );
}

/*
================
idVacuumSeparatorEntity::Event_Activate
================
*/
void idVacuumSeparatorEntity::Event_Activate( idEntity *activator ) {
	if ( !portal ) {
		return;
	}
	gameLocal.SetPortalState( portal, PS_BLOCK_NONE );
}


/*
===============================================================================

idLocationSeparatorEntity

===============================================================================
*/

CLASS_DECLARATION( idEntity, idLocationSeparatorEntity )
END_CLASS

/*
================
idLocationSeparatorEntity::Spawn
================
*/
void idLocationSeparatorEntity::Spawn() {
	idBounds b;

	b = idBounds( spawnArgs.GetVector( "origin" ) ).Expand( 16 );
	qhandle_t portal = gameRenderWorld->FindPortal( b );
	if ( !portal ) {
		gameLocal.Warning( "LocationSeparator '%s' didn't contact a portal", spawnArgs.GetString( "name" ) );
	}
	gameLocal.SetPortalState( portal, PS_BLOCK_LOCATION );
}


/*
===============================================================================

	idVacuumEntity

	Levels should only have a single vacuum entity.

===============================================================================
*/

CLASS_DECLARATION( idEntity, idVacuumEntity )
END_CLASS

/*
================
idVacuumEntity::Spawn
================
*/
void idVacuumEntity::Spawn() {
	if ( gameLocal.vacuumAreaNum != -1 ) {
		gameLocal.Warning( "idVacuumEntity::Spawn: multiple idVacuumEntity in level" );
		return;
	}

	idVec3 org = spawnArgs.GetVector( "origin" );

	gameLocal.vacuumAreaNum = gameRenderWorld->PointInArea( org );
}


// abahr:
/*
===============================================================================

	rvGravitySeparatorEntity

===============================================================================
*/

CLASS_DECLARATION( idEntity, rvGravitySeparatorEntity )
	EVENT( EV_Activate,		rvGravitySeparatorEntity::Event_Activate )
END_CLASS


/*
================
rvGravitySeparatorEntity::idVacuumSeparatorEntity
================
*/
rvGravitySeparatorEntity::rvGravitySeparatorEntity( void ) {
	portal = 0;
}

/*
================
rvGravitySeparatorEntity::Save
================
*/
void rvGravitySeparatorEntity::Save( idSaveGame *savefile ) const {
	savefile->WriteInt( (int)portal );
	savefile->WriteInt( gameRenderWorld->GetPortalState( portal ) );
}

/*
================
rvGravitySeparatorEntity::Restore
================
*/
void rvGravitySeparatorEntity::Restore( idRestoreGame *savefile ) {
	int state;

	savefile->ReadInt( (int &)portal );
	savefile->ReadInt( state );

	gameLocal.SetPortalState( portal, state );
}

/*
================
rvGravitySeparatorEntity::Spawn
================
*/
void rvGravitySeparatorEntity::Spawn() {
	idBounds b;

	b = idBounds( spawnArgs.GetVector( "origin" ) ).Expand( 16 );
	portal = gameRenderWorld->FindPortal( b );
	if ( !portal ) {
		gameLocal.Warning( "GravitySeparator '%s' didn't contact a portal", spawnArgs.GetString( "name" ) );
		return;
	}
	gameLocal.SetPortalState( portal, gameRenderWorld->GetPortalState(portal) | PS_BLOCK_GRAVITY );
}

/*
================
rvGravitySeparatorEntity::Event_Activate
================
*/
void rvGravitySeparatorEntity::Event_Activate( idEntity *activator ) {
	if ( !portal ) {
		return;
	}

	int portalState = gameRenderWorld->GetPortalState( portal );
	gameLocal.SetPortalState( portal, (portalState & PS_BLOCK_GRAVITY) > 0 ? (portalState & ~PS_BLOCK_GRAVITY) : portalState | PS_BLOCK_GRAVITY );
}

/*
===============================================================================

	rvGravityEntity

===============================================================================
*/
ABSTRACT_DECLARATION( idEntity, rvGravityArea )
END_CLASS

/*
================
rvGravityArea::Spawn
================
*/
void rvGravityArea::Spawn() {
	area = gameRenderWorld->PointInArea( spawnArgs.GetVector("origin") );
	gameLocal.AddUniqueGravityInfo( this );
}

/*
================
rvGravityArea::Save
================
*/
void rvGravityArea::Save( idSaveGame *savefile ) const {
	savefile->WriteInt( area );
}

/*
================
rvGravityArea::Restore
================
*/
void rvGravityArea::Restore( idRestoreGame *savefile ) {
	savefile->ReadInt( area );
}

/*
================
rvGravityArea::IsEqualTo
================
*/
bool rvGravityArea::IsEqualTo( const rvGravityArea* area ) const {
	assert( area );
	return !idStr::Icmp( GetName(), area->GetName() );
}

/*
================
rvGravityArea::operator==
================
*/
bool rvGravityArea::operator==( const rvGravityArea* area ) const {
	return IsEqualTo( area );
}

/*
================
rvGravityArea::operator==
================
*/
bool rvGravityArea::operator==( const rvGravityArea& area ) const {
	return IsEqualTo( &area );
}

/*
================
rvGravityArea::operator!=
================
*/
bool rvGravityArea::operator!=( const rvGravityArea* area ) const {
	return !IsEqualTo( area );
}

/*
================
rvGravityArea::operator!=
================
*/
bool rvGravityArea::operator!=( const rvGravityArea& area ) const {
	return !IsEqualTo( &area );
}

/*
===============================================================================

	rvGravityEntity_Static

===============================================================================
*/
CLASS_DECLARATION( rvGravityArea, rvGravityArea_Static )
END_CLASS

/*
================
rvGravityArea_Static::Spawn
================
*/
void rvGravityArea_Static::Spawn() {
	gravity = spawnArgs.GetVector( "gravity" );// * gameLocal.GetGravity().Length();
}

/*
================
rvGravityArea_Static::Save
================
*/
void rvGravityArea_Static::Save( idSaveGame *savefile ) const {
	savefile->WriteVec3( gravity );
}

/*
================
rvGravityArea_Static::Restore
================
*/
void rvGravityArea_Static::Restore( idRestoreGame *savefile ) {
	savefile->ReadVec3( gravity );
}

/*
===============================================================================

	rvGravityArea_SurfaceNormal

===============================================================================
*/
CLASS_DECLARATION( rvGravityArea, rvGravityArea_SurfaceNormal )
END_CLASS

/*
================
rvGravityArea_SurfaceNormal::GetGravity
================
*/
const idVec3 rvGravityArea_SurfaceNormal::GetGravity( const idVec3& origin, const idMat3& axis, int clipMask, idEntity* passEntity ) const {
	trace_t results;



	if( !gameLocal.clip.TracePoint( results, origin, origin + -axis[2] * 50.0f, clipMask, passEntity ) ) {

		return gameLocal.GetGravity();
	}

	return -results.c.normal * gameLocal.GetGravity().Length();
}

/*
================
rvGravityArea_SurfaceNormal::GetGravity
================
*/
const idVec3 rvGravityArea_SurfaceNormal::GetGravity( const idEntity* ent ) const {
	return GetGravity( ent->GetPhysics() );
}

/*
================
rvGravityArea_SurfaceNormal::GetGravity
================
*/
const idVec3 rvGravityArea_SurfaceNormal::GetGravity( const rvClientEntity* ent ) const {
	return GetGravity( ent->GetPhysics() );
}

/*
================
rvGravityArea_SurfaceNormal::GetGravity
================
*/
const idVec3 rvGravityArea_SurfaceNormal::GetGravity( const idPhysics* physics ) const {
	return GetGravity( physics->GetOrigin(), physics->GetAxis(), physics->GetClipMask(), physics->GetSelf() );
}



/*
===============================================================================

idLocationEntity

===============================================================================
*/

CLASS_DECLARATION( idEntity, idLocationEntity )
END_CLASS

/*
======================
idLocationEntity::Spawn
======================
*/
void idLocationEntity::Spawn() {
	idStr realName;

	// this just holds dict information

	// if "location" not already set, use the entity name.
	if ( !spawnArgs.GetString( "location", "", realName ) ) {
		spawnArgs.Set( "location", name );
	}
}

/*
======================
idLocationEntity::GetLocation
======================
*/
const char *idLocationEntity::GetLocation( void ) const {
	return spawnArgs.GetString( "location" );
}


/*
===============================================================================

	idFuncPortal

===============================================================================
*/

CLASS_DECLARATION( idEntity, idFuncPortal )
	EVENT( EV_Activate,				idFuncPortal::Event_Activate )
END_CLASS

/*
===============
idFuncPortal::idFuncPortal
===============
*/
idFuncPortal::idFuncPortal() {
	portal = 0;
	state = false;
}

/*
===============
idFuncPortal::Save
===============
*/
void idFuncPortal::Save( idSaveGame *savefile ) const {
	savefile->WriteInt( (int)portal );
	savefile->WriteBool( state );
}

/*
===============
idFuncPortal::Restore
===============
*/
void idFuncPortal::Restore( idRestoreGame *savefile ) {
	savefile->ReadInt( (int &)portal );
	savefile->ReadBool( state );
	gameLocal.SetPortalState( portal, state ? PS_BLOCK_ALL : PS_BLOCK_NONE );
}

/*
===============
idFuncPortal::Spawn
===============
*/
void idFuncPortal::Spawn( void ) {
	portal = gameRenderWorld->FindPortal( GetPhysics()->GetAbsBounds().Expand( 32.0f ) );
	if ( portal > 0 ) {
		state = spawnArgs.GetBool( "start_on" );
		gameLocal.SetPortalState( portal, state ? PS_BLOCK_ALL : PS_BLOCK_NONE );
	}
}

/*
================
idFuncPortal::Event_Activate
================
*/
void idFuncPortal::Event_Activate( idEntity *activator ) {
	if ( portal > 0 ) {
		state = !state;
		gameLocal.SetPortalState( portal, state ? PS_BLOCK_ALL : PS_BLOCK_NONE );
	}
}

