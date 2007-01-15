
// bdube: note that this file is no longer merged with Doom3 updates
//
// MERGE_DATE 09/30/2004

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "Game_local.h"
#include "Projectile.h"
#include "spawner.h"

/*
===============================================================================

	idProjectile

===============================================================================
*/

static const float BOUNCE_SOUND_MIN_VELOCITY	= 200.0f;
static const float BOUNCE_SOUND_MAX_VELOCITY	= 400.0f;

const idEventDef EV_Explode( "<explode>", NULL );
const idEventDef EV_Fizzle( "<fizzle>", NULL );
const idEventDef EV_RadiusDamage( "<radiusdmg>", "E" );
const idEventDef EV_ResidualDamage ( "<residualdmg>", "E" );
const idEventDef EV_Detonate( "<detonate>", NULL );
const idEventDef EV_StopFlyEffect( "<stopfly>", NULL );

CLASS_DECLARATION( idEntity, idProjectile )
	EVENT( EV_Detonate,			idProjectile::Event_Detonate )
	EVENT( EV_Explode,			idProjectile::Event_Explode )
	EVENT( EV_Fizzle,			idProjectile::Event_Fizzle )
	EVENT( EV_Touch,			idProjectile::Event_Touch )
	EVENT( EV_RadiusDamage,		idProjectile::Event_RadiusDamage )
	EVENT( EV_ResidualDamage,	idProjectile::Event_ResidualDamage )
	EVENT( EV_StopFlyEffect,	idProjectile::Event_StopFlyEffect )
END_CLASS

/*
================
idProjectile::idProjectile
================
*/
idProjectile::idProjectile( void ) {
	memset( &projectileFlags, 0, sizeof( projectileFlags ) );

	memset( &renderLight, 0, sizeof( renderLight ) );

	lightDefHandle		= -1;
	lightOffset.Zero();
	lightStartTime		= 0;
	lightEndTime		= 0;
	lightColor.Zero();

	visualAngles.Zero();
	angularVelocity.Zero();
	speed.Init( 0.0f, 0.0f, 0.0f, 0.0f );
	updateVelocity		= false;

	rotation.Init( 0, 0.0f, mat3_identity.ToQuat(), mat3_identity.ToQuat() );

	flyEffectAttenuateSpeed = 0.0f;
	state				= SPAWNED;
	
	fl.networkSync		= true;

	prePredictTime		= 0;

	syncPhysics			= false;

	launchTime			= 0;
	launchOrig			= vec3_origin;
	launchDir			= vec3_origin;
	launchSpeed			= 0.0f;

	flyEffect = NULL;
}

/*
=================
idProjectile::~idProjectile
=================
*/
idProjectile::~idProjectile() {
	StopSound( SND_CHANNEL_ANY, false );
	FreeLightDef();
	SetPhysics( NULL );
}

/*
================
idProjectile::Spawn
================
*/
void idProjectile::Spawn( void ) {
 	physicsObj.SetSelf( this );

	RV_PUSH_HEAP_MEM(this);
 	physicsObj.SetClipModel( new idClipModel( GetPhysics()->GetClipModel() ), 1.0f );
	RV_POP_HEAP();

 	physicsObj.SetContents( 0 );
 	physicsObj.SetClipMask( 0 );
 	physicsObj.PutToRest();
 	SetPhysics( &physicsObj );

	prePredictTime = spawnArgs.GetInt( "predictTime", "0" );
	syncPhysics = spawnArgs.GetBool( "net_syncPhysics", "0" );

	if ( gameLocal.isClient ) {
		Hide();
	}
}

/*
================
idProjectile::GetOwner
================
*/
idEntity *idProjectile::GetOwner( void ) {
	return ownerInfo.GetEntity();
}

/*
================
idProjectile::Create
================
*/
void idProjectile::Create( const AttackerInfo &info, const idVec3 &start, const idVec3 &dir, idEntity* ignore, idEntity* extraPassEntity ) {
	idDict		args;
	idStr		shaderName;
	idVec3		light_color;
	idVec3		light_offset;
	idVec3		tmp;
	idMat3		axis;

	ownerInfo.Create( info ); 

	team = info.GetEntity() ? info.GetEntity()->team : INVALID_TEAM;
	
	Unbind();

	axis = dir.ToMat3();

 	physicsObj.SetOrigin( start );
 	physicsObj.SetAxis( axis );

	//physicsObj.GetClipModel()->SetOwner( ignore ? ignore : info.GetEntity() );
	physicsObj.extraPassEntity = extraPassEntity ? extraPassEntity : info.GetEntity();

	memset( &renderLight, 0, sizeof( renderLight ) );
	shaderName = spawnArgs.GetString( "mtr_light_shader" );
	if ( *shaderName ) {
		renderLight.shader = declManager->FindMaterial( shaderName, false );
		renderLight.pointLight = true;
		renderLight.lightRadius[0] =
		renderLight.lightRadius[1] =
		renderLight.lightRadius[2] = spawnArgs.GetFloat( "light_radius" );
		spawnArgs.GetVector( "light_color", "1 1 1", light_color );
		renderLight.shaderParms[0] = light_color[0];
		renderLight.shaderParms[1] = light_color[1];
		renderLight.shaderParms[2] = light_color[2];
		renderLight.shaderParms[3] = 1.0f;
		renderLight.detailLevel = DEFAULT_LIGHT_DETAIL_LEVEL;
		renderLight.noShadows = cvarSystem->GetCVarInteger("com_machineSpec") < 3;
	}

	spawnArgs.GetVector( "light_offset", "0 0 0", lightOffset );

	lightStartTime = 0;
	lightEndTime = 0;

	idStr dmgDefStr;
	if ( spawnArgs.GetString( "def_damage_splash", "", dmgDefStr ) && dmgDefStr && dmgDefStr[0] ) {
		dmgSplash.Create( ownerInfo, dmgDefStr.c_str() );
	}
	if ( spawnArgs.GetString( "def_damage_direct", "", dmgDefStr ) && dmgDefStr && dmgDefStr[0] ) {
		dmgDirect.Create( ownerInfo, dmgDefStr.c_str() );
	}

 	UpdateVisuals();

	state = CREATED;
}

/*
=================
idProjectile::FreeLightDef
=================
*/
void idProjectile::FreeLightDef( void ) {
	if ( lightDefHandle != -1 ) {
		gameRenderWorld->FreeLightDef( lightDefHandle );
		lightDefHandle = -1;
	}
}

/*
=================
idProjectile::Launch
=================
*/
void idProjectile::Launch( const idVec3 &start, const idVec3 &dir, const idVec3 &pushVelocity, const float timeSinceFire, const float dmgPower ) {
	float			fuse;
	idVec3			velocity;
	float			linear_friction;
	float			angular_friction;
	float			contact_friction;
	float			bounce;
	float			mass;
	float			gravity;
	float			temp, temp2;
	idVec3			gravVec;
	idVec3			tmp;
	int				contents;
 	int				clipMask;

	// Set the damage
	dmgSplash.SetDamageScale( dmgPower );
	dmgDirect.SetDamageScale( dmgPower );

	if ( !spawnArgs.GetFloat( "speed", "0", temp ) ) {
		spawnArgs.GetVector( "velocity", "0 0 0", tmp );
		temp = tmp[0];
	}
	if ( !spawnArgs.GetFloat( "speed_end", "0", temp2 ) ) {
		temp2 = temp;
	}
	float speedDuration = SEC2MS( spawnArgs.GetFloat( "speed_duration", "0" ) );
	speed.Init( gameLocal.time, speedDuration, temp, temp2 );
	if ( speedDuration > 0 && temp != temp2 ) {
		updateVelocity = true;
	}
	launchSpeed = temp;
	spawnArgs.GetAngles( "angular_velocity", "0 0 0", angularVelocity );

	if ( syncPhysics ) {
		launchSpeed += gameLocal.random.RandomFloat() * 5.0f;
	}

	linear_friction		= spawnArgs.GetFloat( "linear_friction" );
	angular_friction	= spawnArgs.GetFloat( "angular_friction" );
	contact_friction	= spawnArgs.GetFloat( "contact_friction" );
	bounce				= spawnArgs.GetFloat( "bounce" );
	mass				= spawnArgs.GetFloat( "mass" );
	gravity				= spawnArgs.GetFloat( "gravity" );
	fuse				= spawnArgs.GetFloat( "fuse" ) + ( spawnArgs.GetFloat( "fuse_random", "0" ) * gameLocal.random.RandomFloat() );
	
	projectileFlags.detonate_on_world	= spawnArgs.GetBool( "detonate_on_world" );
	projectileFlags.detonate_on_actor	= spawnArgs.GetBool( "detonate_on_actor" );
	projectileFlags.detonate_on_bounce  = spawnArgs.GetBool( "detonate_on_bounce" );
	projectileFlags.bounce_only_on_world  = spawnArgs.GetBool( "bounce_only_on_world" );

	lightStartTime = 0;
	lightEndTime = 0;

	if ( health ) {
		fl.takedamage = true;
	}

	gravVec = ( idMath::Fabs(gravity) > VECTOR_EPSILON ) ? gameLocal.GetCurrentGravity(this) * gravity : vec3_zero;

	Unbind();

	contents = 0;
	clipMask = spawnArgs.GetBool( "clipmask_rendermodel", "1" ) ? MASK_SHOT_RENDERMODEL : MASK_SHOT_BOUNDINGBOX;
	clipMask |= CONTENTS_PROJECTILECLIP;

	if ( spawnArgs.GetBool( "clipmask_largeshot", "1" ) ) {
		clipMask |= CONTENTS_LARGESHOTCLIP;
	}
	if ( spawnArgs.GetBool( "clipmask_moveable", "0" ) ) {
		clipMask |= CONTENTS_MOVEABLECLIP;
	}
	if ( spawnArgs.GetBool( "clipmask_monsterclip", "0" ) ) {
		clipMask |= CONTENTS_MONSTERCLIP;
	}
	
	if ( spawnArgs.GetBool( "detonate_on_trigger" ) ) {
		contents |= CONTENTS_TRIGGER;
	}

 	if ( !spawnArgs.GetBool( "no_contents", "1" ) ) {
 		contents |= CONTENTS_PROJECTILE;
 	}

	//clipMask |= CONTENTS_PROJECTILE;

	clipMask |= MASK_WATER;

	idMat3 axis;
	if ( dir != vec3_zero ) {
		axis = dir.ToMat3();
	}
	else {
		axis.Identity();
	}

	physicsObj.SetMass( mass );
	physicsObj.SetFriction( linear_friction, angular_friction, contact_friction );
	physicsObj.SetBouncyness( bounce, !projectileFlags.detonate_on_bounce );
	physicsObj.SetGravity( gravVec );
	physicsObj.SetContents( contents );
 	physicsObj.SetClipMask( clipMask | CONTENTS_WATER );
	physicsObj.SetLinearVelocity( dir * speed.GetCurrentValue(gameLocal.time) + pushVelocity );
	physicsObj.SetOrigin( start );
	physicsObj.SetAxis( axis );

	physicsObj.alwaysCheckGround = syncPhysics;

	if ( !gameLocal.isClient ) {
		if ( fuse <= 0 ) {
			// run physics for 1 second
			//RunPhysics();
			PostEventMS( &EV_Remove, spawnArgs.GetInt( "remove_time", "1500" ) );
		} else {
			fuse -= timeSinceFire;
			if ( fuse < 0.0f ) {
				fuse = 0.0f;
			}
			PostEventSec( &EV_Detonate, fuse );
		}
	}

	idQuat q( dir.ToMat3().ToQuat() );
	rotation.Init( gameLocal.GetTime(), 0.0f, q, q );

	StartSound( "snd_fly", SND_CHANNEL_BODY, 0, false, NULL );

 	UpdateVisuals();

	// Make sure these come after update visuals so the origin and axis are correct
	PlayEffect( "fx_launch", renderEntity.origin, renderEntity.axis );

	if ( q4f_showProjectileTrails.GetBool() ) {
		flyEffect = PlayEffect( "fx_fly", renderEntity.origin, renderEntity.axis, !spawnArgs.GetBool( "fly_noloop" ) );
		flyEffectAttenuateSpeed = spawnArgs.GetFloat( "flyEffectAttenuateSpeed", "0" );
	}

	state = LAUNCHED;

	predictTime = prePredictTime;

	if ( gameLocal.isServer ) {
		// store launch information for networking
		launchTime = gameLocal.time;
		launchOrig = physicsObj.GetOrigin();
		launchDir = dir;
	}

	// <q4f> 

	hurt_owner = spawnArgs.GetBool( "hurt_owner", "0" );
	noWater = spawnArgs.GetBool( "nowater", "0" );
	angleBounce = spawnArgs.GetBool( "anglebounce" );

	physicsObj.SetWaterLevel();

	// </q4f>
}

void idProjectile::Relaunch( const idVec3 &newDir ) {
	launchOrig = physicsObj.GetOrigin() + ( newDir * 5.0f );
	launchDir = newDir;
	launchTime = gameLocal.time;

	speed.SetStartTime( launchTime );
	GetPhysics()->SetLinearVelocity( launchDir * speed.GetCurrentValue( gameLocal.time ) );

	hurt_owner = !syncPhysics;
	physicsObj.extraPassEntity = NULL;
}


/*
================
idProjectile::Think
================
*/
void idProjectile::Think( void ) {
	// run physics
	if ( thinkFlags & TH_PHYSICS ) {

		// Update the velocity to match the changing speed
		if ( updateVelocity ) {
			idVec3 vel;
			vel = physicsObj.GetLinearVelocity ( );
			vel.Normalize ( );
			physicsObj.SetLinearVelocity ( speed.GetCurrentValue ( gameLocal.time ) * vel );
			if ( speed.IsDone ( gameLocal.time ) ) {
				updateVelocity = false;
			}
		}
		
		RunPhysics();
		
		// If we werent at rest and are now then start the atrest fuse
		/*if ( physicsObj.IsAtRest( ) ) {
			float fuse = spawnArgs.GetFloat( "fuse_atrest" );
			if ( fuse > 0.0f ) {
				if ( spawnArgs.GetBool( "detonate_on_fuse" ) ) {
					CancelEvents( &EV_Explode );
					PostEventSec( &EV_Explode, fuse );
				} else {
					CancelEvents( &EV_Fizzle );
					PostEventSec( &EV_Fizzle, fuse );
				}
			}
		}*/

		// Stop the trail effect if the physics flag was removed
		if ( flyEffect && flyEffectAttenuateSpeed > 0.0f ) {
			if ( physicsObj.IsAtRest( ) ) {
				flyEffect->Stop( );
				flyEffect = NULL;				
			} else {
				float speed;
				speed = idMath::ClampFloat( 0, flyEffectAttenuateSpeed, physicsObj.GetLinearVelocity ( ).LengthFast ( ) );
				flyEffect->Attenuate( speed / flyEffectAttenuateSpeed );
			}
		}

		if ( physicsObj.IsInWater() ) {
			if ( !gameLocal.isClient && noWater ) {
				PostEventMS( &EV_Remove, 0 );
			}
		}

		UpdateVisualAngles();
	}
		
	Present();

	// add the light
 	if ( renderLight.lightRadius.x > 0.0f && g_projectileLights.GetBool() ) {
		renderLight.origin = GetPhysics()->GetOrigin() + GetPhysics()->GetAxis() * lightOffset;
		renderLight.axis = GetPhysics()->GetAxis();
		if ( ( lightDefHandle != -1 ) ) {
			if ( lightEndTime > 0 && gameLocal.time <= lightEndTime + gameLocal.GetMSec() ) {
				idVec3 color( 0, 0, 0 );
				if ( gameLocal.time < lightEndTime ) {
					float frac = ( float )( gameLocal.time - lightStartTime ) / ( float )( lightEndTime - lightStartTime );
					color.Lerp( lightColor, color, frac );
				} 
				renderLight.shaderParms[SHADERPARM_RED] = color.x;
				renderLight.shaderParms[SHADERPARM_GREEN] = color.y;
				renderLight.shaderParms[SHADERPARM_BLUE] = color.z;
			} 
			gameRenderWorld->UpdateLightDef( lightDefHandle, &renderLight );
		} else {
			lightDefHandle = gameRenderWorld->AddLightDef( &renderLight );
		}
	}
}

/*
=================
idProjectile::UpdateVisualAngles
=================
*/
void idProjectile::UpdateVisualAngles() {
	if ( !syncPhysics )
		return;

	idVec3 linearVelocity( GetPhysics()->GetLinearVelocity() );

	if( angularVelocity.Compare(ang_zero, VECTOR_EPSILON) ) {
		rotation.Init( gameLocal.GetTime(), 0.0f, rotation.GetCurrentValue(gameLocal.GetTime()), linearVelocity.ToNormal().ToMat3().ToQuat()  );
		return;
	}

	if( physicsObj.IsOnGround() ) {
		return;
	}

	if( !rotation.IsDone(gameLocal.GetTime()) ) {
		return;
	}

	if( linearVelocity.Length() <= BOUNCE_SOUND_MIN_VELOCITY ) {
		return;
	}

	visualAngles += angularVelocity;
	idQuat q = visualAngles.ToQuat() * linearVelocity.ToNormal().ToMat3().ToQuat();
	rotation.Init( gameLocal.GetTime(), gameLocal.GetMSec(), rotation.GetCurrentValue(gameLocal.GetTime()), q  );
}

/*
=================
idProjectile::Collide
=================
*/
bool idProjectile::Collide( const trace_t &collision, const idVec3 &velocity ) {
	bool bob = false;
	return Collide( collision, velocity, bob );
}

bool idProjectile::Collide( const trace_t &collision, const idVec3 &velocity, bool &hitTeleporter ) {
 	idEntity*	ent;
//	idEntity*	actualHitEnt = NULL;
 	idEntity*	ignore;
 	idVec3		dir;
 	bool		canDamage;

	hitTeleporter = false;

	if ( state == EXPLODED || state == FIZZLED ) {
		return true;
	}

	ent = gameLocal.entities[ collision.c.entityNum ];

	// allow projectiles to hit triggers (teleports)
	/*if( collision.c.contents & CONTENTS_TRIGGER ) {
		idEntity* trigger = gameLocal.entities[ collision.c.entityNum ];
		if( trigger ) {
			if ( trigger->RespondsTo( EV_Touch ) || trigger->HasSignal( SIG_TOUCH ) ) {
				
				trace_t trace;
				trace.endpos = physicsObj.GetOrigin();
				trace.endAxis = physicsObj.GetAxis();
				trace.c.contents = collision.c.contents;
				trace.c.entityNum = collision.c.entityNum;
				if( trigger->GetPhysics()->GetClipModel() ) {
					trace.c.id = trigger->GetPhysics()->GetClipModel()->GetId();
				} else {
					trace.c.id = 0;
				}

				hitTeleporter = true;

				trigger->Signal( SIG_TOUCH );
				trigger->ProcessEvent( &EV_Touch, this, &collision );
			}
		}

		// when we hit a trigger, align our velocity to the trigger's coordinate plane
		if( gameLocal.isServer ) {
			idVec3 up( 0.0f, 0.0f, 1.0f );
			idVec3 right = collision.c.normal.Cross( up );
			idMat3 mat( collision.c.normal, right, up );

			physicsObj.SetLinearVelocity( -1.0f * (physicsObj.GetLinearVelocity() * mat.Transpose()) );
			physicsObj.SetLinearVelocity( idVec3( physicsObj.GetLinearVelocity()[ 0 ], -1.0 *physicsObj.GetLinearVelocity()[ 1 ], -1.0 * physicsObj.GetLinearVelocity()[ 2 ] ) );

			// update the projectile's launchdir and launch origin
			// this will propagate the change to the clients for prediction
			// re-launch the projectile

			idVec3 newDir = physicsObj.GetLinearVelocity();
			newDir.Normalize();
			launchTime = gameLocal.time;
			launchDir = newDir;
			physicsObj.SetOrigin( physicsObj.GetOrigin() + idVec3( 0.0f, 0.0f, 32.0f ) );
			physicsObj.SetAxis( newDir.ToMat3() );
			launchOrig = physicsObj.GetOrigin();
		}

		if( !(collision.c.contents & CONTENTS_SOLID) || hitTeleporter ) {
			return false;
		}
	}*/

	// don't predict collisions on projectiles that need their physics synced (e.g. grenades)
	if ( gameLocal.isClient && (!g_clientProjectileCollision.GetBool() || syncPhysics) ) {
		// optionally do not try to predict detonates, that causes projectiles disappearing
		// but most of the time works well to stop projectiles clipping through geometry on clients
		return false;
	}

 	// remove projectile when a 'noimpact' surface is hit
 	if ( ( collision.c.material != NULL ) && ( collision.c.material->GetSurfaceFlags() & SURF_NOIMPACT ) ) {
 		PostEventMS( &EV_Remove, 0 );
		StopEffect( "fx_fly" );
 		return true;
 	}

	// get the entity the projectile collided with
	if ( ent == ownerInfo.GetEntity() && !hurt_owner ) {
		return false;
	}

 	// just get rid of the projectile when it hits a player in noclip
 	/*if ( ent->IsType( idPlayer::GetClassType() ) && static_cast<idPlayer *>( ent )->noclip ) {
   		PostEventMS( &EV_Remove, 0 );
  		common->DPrintf( "Projectile collision no impact\n" );
   		return true;
   	}*/

	// If the hit entity is bound to an actor use the actor instead
	/*if ( ent->GetTeamMaster( ) && ent->GetTeamMaster( )->IsType ( idActor::GetClassType() ) ) {
		actualHitEnt = ent;
		ent = ent->GetTeamMaster( );
	}*/

	// Can the projectile damage?  
	canDamage = ent->fl.takedamage && !(( collision.c.material != NULL ) && ( collision.c.material->GetSurfaceFlags() & SURF_NODAMAGE )) && dmgDirect.IsValid();
  
 	// direction of projectile
 	dir = velocity;
 	dir.Normalize();
 
 	// projectiles can apply an additional impulse next to the rigid body physics impulse
	if ( dmgDirect.IsValid() ) {
		ent->ApplyImpulse( this, collision.c.id, collision.endpos, dir, dmgDirect.GetDamageDict() );
	}

	// If the projectile hits water then we need to let the projectile keep going
	if ( ent->GetPhysics()->GetContents() & CONTENTS_WATER || collision.c.contents & CONTENTS_WATER ) {
		if ( /*!gameLocal.isClient && */!physicsObj.IsInWater( ) ) {
			gameLocal.PlayEffect( spawnArgs, "fx_impact_water", collision.endpos, collision.c.normal.ToMat3(), false, vec3_origin, /*true*/syncPhysics, EC_IMPACT );
		}
		return false;
	}
	else if ( canDamage && ent->IsType( idActor::GetClassType() ) ) {
		if ( !projectileFlags.detonate_on_actor && !projectileFlags.bounce_only_on_world ) {
			return false;
		}
	} else {
		bool bounce = false;
		bounce = !projectileFlags.detonate_on_world && !canDamage;
		//assert(collision.c.material);
		if ( !bounce && collision.c.material && (collision.c.material->GetSurfaceFlags() & SURF_BOUNCE) ) {
			bounce = !projectileFlags.detonate_on_bounce;
		}
		if ( bounce ) {

			updateVelocity = false;

			if ( angleBounce ) {
				GetPhysics()->SetLinearVelocity( velocity * ( ( velocity.ToNormal() * collision.c.normal ) + 1.0f ) );
			}

			float len = velocity.Length();

			if ( len > BOUNCE_SOUND_MIN_VELOCITY ) {
				StartSound( "snd_ricochet", SND_CHANNEL_ITEM, 0, true, NULL );		
			}
			
			// FIXME: clean up
			idMat3 axis( rotation.GetCurrentValue(gameLocal.GetTime()).ToMat3() );
			axis[0].ProjectOntoPlane( collision.c.normal );
			axis[0].Normalize();
			axis[2] = collision.c.normal;
			axis[1] = axis[2].Cross( axis[0] ).ToNormal();

			rotation.Init( gameLocal.GetTime(), SEC2MS(spawnArgs.GetFloat("settle_duration")), rotation.GetCurrentValue(gameLocal.GetTime()), axis.ToQuat() );

			//visualAngles = collision.c.normal.ToAngles();

			return false;		
		}
	}

	SetOrigin( collision.endpos );

	GetPhysics()->UnlinkClip();

	ignore = NULL;

	// if the hit entity takes damage
	if ( canDamage ) {

		int hitJoint = CLIPMODEL_ID_TO_JOINT_HANDLE(collision.c.id);
		/*if ( ent->IsType(idActor::GetClassType()) )
		{
			idActor* entActor = static_cast<idActor*>(ent);
			if ( entActor && entActor->GetHead() && entActor->GetHead()->IsType(idAFAttachment::GetClassType()) )
			{
				idAFAttachment* headEnt = static_cast<idAFAttachment*>(entActor->GetHead());
				if ( headEnt && headEnt->entityNumber == collision.c.entityNum )
				{//hit ent's head, get the proper joint for the head
					hitJoint = entActor->GetAnimator()->GetJointHandle("head");
				}
			}
		}*/

		dmgDirect.SetDir( dir );
		dmgDirect.SetLocation( hitJoint );
		ent->Damage_TF( dmgDirect, 1.0f );
		ignore = ent;
	}

	// TODO: fixme
	ent->AddDamageEffect ( collision, velocity, dmgDirect.GetDamageDef()->GetName(), ownerInfo.GetEntity() );

	if( !gameLocal.isClient ) {
		DefaultDamageEffect( collision, velocity, dmgDirect.GetDamageDef() );
		Explode( &collision, false, ignore );
	}

	return true;
}

/*
=================
idProjectile::DefaultDamageEffect
=================
*/
void idProjectile::DefaultDamageEffect( const trace_t &tr, const idVec3 &velocity, ENTDEF dmgDef ) {
	idEntity* ent;
	idMat3	  axis;
	ent = gameLocal.entities[ tr.c.entityNum ];	

	// Make sure we want to play effects
	if  ( (!dmgSplash.IsValid() || spawnArgs.GetBool( "bloodyImpactEffect" ))
		&& ownerInfo.GetEntity( ) && !ent->CanPlayImpactEffect( ownerInfo.GetEntity(), ent ) ) {
		return;
	}

	// Effect axis when hitting actors is along the direction of impact because actor models are 
	// very detailed.
	if ( ent->IsType( idActor::GetClassType() ) || ent->IsType( idAFAttachment::GetClassType() ) ) {
		idVec3 dir;
		dir = velocity;
		dir.Normalize ( );
		axis = ((-dir + tr.c.normal) * 0.5f).ToMat3();
		
		// Play an actor specific impact effect?
		const idDecl *actorImpactEffect = gameLocal.GetEffect( spawnArgs, "fx_impact_actor", tr.c.materialType );
		if ( actorImpactEffect ) {
			gameLocal.PlayEffect( actorImpactEffect, tr.c.point, axis, false, vec3_origin, true );
			return;
		}
	} else {
		axis = tr.c.normal.ToMat3();
	}
	
	// Play an impact effect on the entity that got hit
	if ( ent->IsType( idMover::GetClassType ( ) ) ) {
		ent->PlayEffect( gameLocal.GetEffect( spawnArgs, "fx_impact", tr.c.materialType ), tr.c.point, axis, false, vec3_origin, true );
	} else { 
		gameLocal.PlayEffect( gameLocal.GetEffect( spawnArgs, "fx_impact", tr.c.materialType ), tr.c.point, axis, false, vec3_origin, true );
	}
}

/*
================
idProjectile::Killed
================
*/
void idProjectile::Killed( idEntity *inflictor, idEntity *attacker, int damage, const idVec3 &dir, int location ) {
	if ( spawnArgs.GetBool( "detonate_on_death" ) ) {
		Explode( NULL, true );
		physicsObj.ClearContacts();
		physicsObj.PutToRest();
	} else {
		Fizzle();
	}
}

/*
================
idProjectile::Fizzle
================
*/
void idProjectile::Fizzle( void ) {

	if ( gameLocal.isClient || state == EXPLODED || state == FIZZLED ) {
		return;
	}

	StopSound( SND_CHANNEL_BODY, false );
	StartSound( "snd_fizzle", SND_CHANNEL_BODY, 0, false, NULL );
	
	gameLocal.PlayEffect( spawnArgs, "fx_fuse", GetPhysics()->GetOrigin(), GetPhysics()->GetAxis(), false, vec3_origin, true );

	fl.takedamage = false;
	physicsObj.SetContents( 0 );
	//physicsObj.GetClipModel()->Unlink();
	physicsObj.PutToRest();

	// No more fly effects
	PostEventMS( &EV_StopFlyEffect, spawnArgs.GetInt( "stop_fly_effect_delay", "0" ) );

	Hide();
	FreeLightDef();

	state = FIZZLED;

 	CancelEvents( &EV_Fizzle );
	PostEventMS( &EV_Remove, spawnArgs.GetInt( "remove_time", "1500" ) );
}

/*
================
idProjectile::Event_RadiusDamage
================
*/
void idProjectile::Event_RadiusDamage( idEntity *ignore ) {
	/*const char *splash_damage = spawnArgs.GetString( "def_splash_damage" );
	if ( splash_damage[0] != '\0' ) {
		gameLocal.RadiusDamage( physicsObj.GetOrigin(), this, owner, ignore, this, splash_damage, damagePower, &hitCount );
	}*/

	// <q4f> 

	if ( !dmgSplash.IsValid() ) {
		return;
	}

	gameLocal.RadiusDamage_TF( physicsObj.GetOrigin(), dmgSplash, ignore );

	// </q4f>
}

/*
================
idProjectile::Event_ResidualDamage
================
*/
void idProjectile::Event_ResidualDamage ( idEntity* ignore ) {
	return;
}

/*
================
idProjectile::Explode
================
*/
void idProjectile::Explode( const trace_t *collision, const bool showExplodeFX, idEntity *ignore, const char *sndExplode ) {
	idVec3		normal, endpos;
	int			removeTime;

	if ( state == EXPLODED || state == FIZZLED ) {
		return;
	}

	if ( spawnArgs.GetVector( "detonation_axis", "", normal ) ) {
		GetPhysics()->SetAxis( normal.ToMat3() );
	} else {
		normal = collision ? collision->c.normal : idVec3( 0, 0, 1 );
	}
	endpos = ( collision ) ? collision->endpos : GetPhysics()->GetOrigin();

	// play sound
	StopSound( SND_CHANNEL_BODY, false );
	StartSound( sndExplode, SND_CHANNEL_BODY, 0, false, NULL );

	if ( showExplodeFX ) {
		idVec3 fxDir;
		if ( physicsObj.GetGravityNormal( ) != vec3_zero ) {
			fxDir = -physicsObj.GetGravityNormal( );
		} else { 
			fxDir = -physicsObj.GetLinearVelocity( );
			fxDir.Normalize( );
		}
		// FIXME: This should be done in a better way
		PlayDetonateEffect( endpos, fxDir.ToMat3() );
	}

	// Stop the fly effect without destroying particles to ensure the trail within can persist.
	StopEffect( "fx_fly" );	
	if( flyEffect)	{
		//flyEffect->Event_Remove();
	}
	
	// Stop the remaining particles
	StopAllEffects( );

	Hide();
	FreeLightDef();

	GetPhysics()->SetOrigin( GetPhysics()->GetOrigin() + 8.0f * normal );

	fl.takedamage = false;
	physicsObj.SetContents( 0 );
	physicsObj.PutToRest();

	state = EXPLODED;

	if ( gameLocal.isClient ) {
		return;
	}

	// bind the projectile to the impact entity if necesary
	if ( collision && gameLocal.entities[collision->c.entityNum] && spawnArgs.GetBool( "bindOnImpact" ) ) {
		Bind( gameLocal.entities[collision->c.entityNum], true );
	}

	// splash damage
	removeTime = spawnArgs.GetInt( "remove_time", "1500" );
	float delay = spawnArgs.GetFloat( "delay_splash" );
	if ( delay ) {
		if ( removeTime < delay * 1000 ) {
			removeTime = ( delay + 0.10 ) * 1000;
		}
		PostEventSec( &EV_RadiusDamage, delay, ignore );
	} else {
		Event_RadiusDamage( ignore );
	}

	// Residual damage (damage over time)
	delay = SEC2MS ( spawnArgs.GetFloat ( "delay_residual" ) );
	if ( delay > 0.0f ) {
		PostEventMS ( &EV_ResidualDamage, delay, ignore );

		// Keep the projectile around until the residual damage is done		
		delay = SEC2MS ( spawnArgs.GetFloat ( "residual_time" ) );
		if ( removeTime < delay ) {
			removeTime = delay;
		}
	}
			
 	CancelEvents( &EV_Explode );
	PostEventMS( &EV_Remove, removeTime );
}

/*
================
idProjectile::GetVelocity
================
*/
idVec3 idProjectile::GetVelocity( const idDict *projectile ) {
	idVec3 velocity;	

	velocity.Zero ( );
	if ( projectile && !projectile->GetFloat ( "speed", "0", velocity.x ) ) {
		projectile->GetVector( "velocity", "0 0 0", velocity );
	}
	return velocity;
}

/*
================
idProjectile::GetGravity
================
*/
idVec3 idProjectile::GetGravity( const idDict *projectile ) {
	if ( projectile ) {
		return gameLocal.GetGravity ( ) * projectile->GetFloat( "gravity" );
	}
	return vec3_origin;
}

/*
================
idProjectile::PlayPainEffect
================
*/
void idProjectile::PlayPainEffect ( idEntity* ent, int damage, const rvDeclMatType* materialType, const idVec3& origin, const idVec3& dir )  {
	static int  damageTable[] = { 100, 50, 25, 10, 0 };
	int			index;

	// Normalize the damage value to the damage table	
	for ( index = 0; damage < damageTable[index] && damageTable[index]; index ++ );
	
	// loop until we find a pain effect, trying lower damage numbers if needed
	for ( ; damageTable[index]; index ++ ) {
		// Try the pain effect for the  current damage value and if it plays then
		// we are done
		if ( ent->PlayEffect( gameLocal.GetEffect( spawnArgs, va( "fx_pain%d", damageTable[index] ), materialType ), origin, dir.ToMat3()  ) ) {
			return;
		}
	}

	// Play the default pain effect		
	ent->PlayEffect( gameLocal.GetEffect ( spawnArgs, "fx_pain", materialType ), origin, dir.ToMat3() );
}

void idProjectile::Event_Detonate( void ) {
	if ( spawnArgs.GetBool( "detonate_on_fuse" ) ) {
		Explode( NULL, true );
	}
	else {
		Fizzle();
	}
}

/*
================
idProjectile::Event_Explode
================
*/
void idProjectile::Event_Explode( void ) {
	Explode( NULL, true );
}

/*
================
idProjectile::Event_Fizzle
================
*/
void idProjectile::Event_Fizzle( void ) {
	Fizzle();
}

/*
================
idProjectile::Event_Touch
================
*/
void idProjectile::Event_Touch( idEntity *other, trace_t *trace ) {
	if ( IsHidden() ) {
		return;
	}

	if ( other != ownerInfo.GetEntity() ) {
		trace_t collision;

		memset( &collision, 0, sizeof( collision ) );
		collision.c.point = GetPhysics()->GetOrigin();
		collision.c.normal.Set( 0, 0, 1 );
		//DefaultDamageEffect( collision, collision.c.normal, NULL );
		Explode( NULL, true );
	}
}

/*
================
idProjectile::ClientPredictionThink
================
*/
void idProjectile::ClientPredictionThink( void ) {
	if ( !renderEntity.hModel && clientEntities.IsListEmpty() ) {
		return;
	}
	if ( !syncPhysics && state == LAUNCHED ) {
		idMat3 axis = launchDir.ToMat3();
		idVec3 origin( launchOrig );

		float mySpeed = speed.GetCurrentValue( gameLocal.time );
		origin += ( ( gameLocal.time - launchTime ) / 1000.0f ) * mySpeed * launchDir;
		physicsObj.SetAxis( axis );
		physicsObj.SetOrigin( origin );
		physicsObj.SetLinearVelocity( mySpeed * launchDir );
	}
	Think();
}

/*
================
idProjectile::WriteToSnapshot
================
*/
void idProjectile::WriteToSnapshot( idBitMsgDelta &msg ) const {
	if ( syncPhysics ) {
		physicsObj.WriteToSnapshot( msg );
		msg.WriteBits( ownerInfo.GetSpawnId(), 32 );
	}

	msg.WriteBits( state, 3 );
	if ( state >= LAUNCHED ) {
		// feed the client with start position, direction and time. let the client do everything else
		// this won't change during projectile life and be completely deltified away
		msg.WriteLong( launchTime );
		msg.WriteFloat( launchOrig[ 0 ] );
		msg.WriteFloat( launchOrig[ 1 ] );
		msg.WriteFloat( launchOrig[ 2 ] );
		msg.WriteDir( launchDir, 24 );
		//msg.WriteBits( ownerInfo.GetSpawnId(), 32 );
	}

	msg.WriteBits( hurt_owner ? 1 : 0, 1 );
}

/*
================
idProjectile::ReadFromSnapshot
================
*/
void idProjectile::ReadFromSnapshot( const idBitMsgDelta &msg ) {
	projectileState_t newState;

	if ( syncPhysics ) {
		physicsObj.ReadFromSnapshot( msg );
		ownerInfo.SetSpawnId( msg.ReadBits( 32 ) );
	}

	//int ownerSpawnID = -1;

	newState = (projectileState_t) msg.ReadBits( 3 );
	if ( newState >= LAUNCHED ) {
		launchTime = msg.ReadLong( );
		launchOrig[ 0 ] = msg.ReadFloat();
		launchOrig[ 1 ] = msg.ReadFloat();
		launchOrig[ 2 ] = msg.ReadFloat();
		launchDir = msg.ReadDir( 24 );
		//ownerSpawnID = msg.ReadBits( 32 );
		speed.SetStartTime( launchTime );
	}

	// we always create and launch at the same time
	// state on a client can be SPAWNED, LAUNCHED, EXPLODED
	// expect never to get a CREATED projectile, they should launch right away
	assert( state != CREATED && state != FIZZLED && newState != CREATED );
	if ( newState != state ) {
		switch ( newState ) {
		case LAUNCHED:
			//assert( ownerSpawnID >= 0 );
			//ownerInfo.SetSpawnId( ownerSpawnID );
			Create( ownerInfo, launchOrig, launchDir/*, ownerInfo.GetEntity(), ownerInfo.GetEntity()*/ );
			Launch( launchOrig, launchDir, vec3_origin );
			speed.SetStartTime( launchTime );
			Show();
			break;
		case FIZZLED:
		case EXPLODED:
			if ( state != EXPLODED ) {
				StopSound( SND_CHANNEL_BODY, false );
				StopAllEffects();
				Hide();
				FreeLightDef();
				state = EXPLODED;
				BecomeInactive( TH_PHYSICS );
			}
			break;
		}
	}

	hurt_owner = msg.ReadBits( 1 ) != 0;

	if ( msg.HasChanged() ) {
		if( !syncPhysics && state == LAUNCHED ) {
			idMat3 axis = launchDir.ToMat3();
			idVec3 origin( launchOrig );
			origin += ( ( gameLocal.time - launchTime ) / 1000.0f ) * launchSpeed * launchDir;
			physicsObj.SetAxis( axis );
			physicsObj.SetOrigin( origin );
			physicsObj.SetLinearVelocity( launchSpeed * launchDir );
		}
	
		UpdateVisuals();
	}
}

/*
===============
idProjectile::ClientStale
===============
*/
bool idProjectile::ClientStale( void ) {
	// delete stale projectile ents. if they pop back in pvs, they will be re-spawned ( rare case anyway )
	StopAllEffects();
	return true;
}

/*
================
idProjectile::GetPhysicsToVisualTransform
================
*/
bool idProjectile::GetPhysicsToVisualTransform( idVec3 &origin, idMat3 &axis ) {
	axis = rotation.GetCurrentValue( gameLocal.GetTime() ).ToMat3() * GetPhysics()->GetAxis().Transpose();

	origin.Zero();
	return true;
}

//============================================================================================================
// Pipebombs
//============================================================================================================
CLASS_DECLARATION( idProjectile, Pipebomb )
END_CLASS

Pipebomb::Pipebomb() {
	spawnTime = gameLocal.time;
	removed = false;
}

Pipebomb::~Pipebomb() {
	RemoveFromPlayer();
}

void Pipebomb::Launch( const idVec3 &start, const idVec3 &dir, const idVec3 &pushVelocity, const float timeSinceFire, const float dmgPower ) {
	
	if ( !gameLocal.isClient ) {
		idPlayer* player = ownerInfo.GetPlayer();
		if ( player ) {
			player->AddPipe( this );
		}
	}

	idProjectile::Launch( start, dir, pushVelocity, timeSinceFire, dmgPower );
}

void Pipebomb::RemoveFromPlayer() {
	if ( !removed ) {
		idPlayer* player = ownerInfo.GetPlayer();
		if ( player ) {
			player->RemovePipe( this );
		}
		removed = true;
	}
}

void idProjectile::EmpTouch( const AttackerInfo &attacker, idVec3 &dir, float damageScale ) {
	CancelEvents( &EV_Detonate );
	PostEventMS( &EV_Detonate, 100 + ( gameLocal.random.RandomFloat() * 1000 ) );
}

void idProjectile::Event_StopFlyEffect() {
	StopEffect( "fx_fly" );
	if( flyEffect)	{
		//flyEffect->Event_Remove();
	}
}
