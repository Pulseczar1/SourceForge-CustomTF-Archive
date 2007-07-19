#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"

const idEventDef EV_Charge( "<charge>", NULL );

CLASS_DECLARATION( BuildableEntity, DetPak )
	EVENT( EV_Explode,			DetPak::Event_Explode )
	EVENT( EV_Charge,			DetPak::Event_Charge )
END_CLASS

DetPak::DetPak() {
	built = false;
	exploded = false;
	splodeTime = 0;
	oldStyle = false;
}

DetPak::~DetPak() {
	SetPhysics( NULL );
}

void DetPak::Spawn( void ) {

	projCalcDelay = spawnArgs.GetInt( "proj_calc_delay_ms", "64" );
	maxStartSpeed = spawnArgs.GetFloat( "proj_max_start_speed", "2000" );
	minStartSpeed = spawnArgs.GetFloat( "proj_min_start_speed", "500" );

	maxLifeTime = SEC2MS( spawnArgs.GetFloat( "proj_max_lifetime", "1.5" ) );
	minLifeTime = SEC2MS( spawnArgs.GetFloat( "proj_min_lifetime", ".5" ) );

	airFriction = spawnArgs.GetFloat( "proj_air_friction", "0.1" );
	gravityScale = spawnArgs.GetFloat( "proj_gravity_scale", "0.25" );
	bounce = spawnArgs.GetFloat( "proj_bounce", "0.5" );

	minSplodeDist = spawnArgs.GetFloat( "proj_min_splode_dist", "64" );

	onlyLOS = spawnArgs.GetBool( "proj_viewable_los", "1" );

	oldStyle = spawnArgs.GetBool( "old_style_detpack", "0" );

	splodeTime = 0;

	myDamage.Clear();

	physicsObj.SetContents( 0 );
}

void DetPak::Think( void ) {

	idPlayer* owner = ownerInfo.GetPlayer();
	if ( owner == NULL || team != owner->team || ownerInfo.GetClass() != owner->currentPC ) {
		PostEventMS( &EV_Remove, 0 );
		return;
	}

	if ( !built ) {
		UpdateBuildStatus();
	}
	else if ( !oldStyle && exploded ) {
		UpdateExplosion();
	}

	Present();
}

void DetPak::BuildStarted() {
	physicsObj.SetContents( 0 );

	BecomeActive( TH_THINK );

	if ( gameLocal.isClient )
		return;

	if ( oldStyle ) {
		myDamage.Create( ownerInfo, spawnArgs.GetString( "def_damage_splash_old", "" ), 1.0f );
	}
	else {
		myDamage.Create( ownerInfo, spawnArgs.GetString( "def_damage_splash", "" ), 1.0f );
	}

	tfStatManager->ShotFired( ownerInfo, GetEntityDef() );
}

void DetPak::BuildFinished( void ) {
	built = true;

	float charge = spawnArgs.GetFloat( "chargetime" );
	splodeTime = SEC2MS( charge );

	PostEventMS( &EV_Explode, splodeTime );
	PostEventMS( &EV_Charge, splodeTime - 4800 );
	splodeTime += gameLocal.time;
}

void DetPak::WriteToSnapshot( idBitMsgDelta &msg ) const {
	BuildableEntity::WriteToSnapshot( msg );
	//msg.WriteBits( IsHidden() ? 1 : 0, 1 );
}

void DetPak::ReadFromSnapshot( const idBitMsgDelta &msg ) {
	BuildableEntity::ReadFromSnapshot( msg );
	//if ( msg.ReadBits( 1 ) != 0 && !IsHidden() )
	//	Hide();
}

#define yaw_spread 72.0f
#define pitch_spread 30.0f

void DetPak::Event_Explode( void ) {
	exploded = true;

	idVec3 org = GetPhysics()->GetOrigin();

	if ( oldStyle ) {
		gameLocal.RadiusDamage_TF( org, myDamage, this );
		PostEventMS( &EV_Remove, 0 );
	}
	else {
		idAngles ang( -20.0f, gameLocal.random.RandomFloat() * 360.0f, 0.0f );

		for ( int i = 0; i < NUM_DETPACK_PROJECTILES; i++ ) {

			if ( ang.yaw > 360.0f ) {
				ang.yaw -= 360.0f;
				ang.pitch += pitch_spread;
			}

			projectiles[i].velocity = ang.ToForward() * ( minStartSpeed + gameLocal.random.RandomFloat() * ( maxStartSpeed - minStartSpeed ) );

			projectiles[i].origin = org;
			projectiles[i].timeEnd = gameLocal.time + minLifeTime + gameLocal.random.RandomInt( maxLifeTime - minLifeTime );
			projectiles[i].lastCalcTime = gameLocal.time - gameLocal.random.RandomInt( projCalcDelay );
			projectiles[i].timeStart = projectiles[i].lastCalcTime;
			projectiles[i].distSum = 0.0f;
			projectiles[i].distLastSplode = 0.0f;

			ang.yaw += yaw_spread;
		}
	}

	gameLocal.PlayEffect( spawnArgs, "fx_explode", org, (-(physicsObj.GetGravityNormal())).ToMat3(), false, vec3_origin, true );

	Hide();
}

void DetPak::UpdateExplosion() {
	assert( !gameLocal.isClient );

	bool hasProjectiles = false;

	for ( int i = 0; i < NUM_DETPACK_PROJECTILES; i++ ) {
		if ( gameLocal.time >= projectiles[i].timeEnd )
			continue;

		hasProjectiles = true;

		if ( projectiles[i].lastCalcTime + projCalcDelay < gameLocal.time ) {
			continue;
		}

		CalcNextPosition( projectiles[i] );
	}

	if ( !hasProjectiles ) {
		PostEventMS( &EV_Remove, 0 );
	}
}

void DetPak::CalcNextPosition( detPackProjectile_t &proj ) {

	assert( !gameLocal.isClient );

	int timeMS = gameLocal.time - proj.lastCalcTime;
	float timeSec = MS2SEC( timeMS );

	idVec3 oldPos = proj.origin;

	idVec3 travel = ( proj.velocity * timeSec );

	trace_t tr;
	idEntity* ent;

	idEntity* ignore = this;

	idVec3 startPos = proj.origin;

	while ( true ) {
		gameLocal.clip.TracePoint( tr, proj.origin, proj.origin + travel, MASK_SOLID, ignore );

		proj.origin = tr.endpos;

		if ( tr.fraction >= 1.0f )
			break;

		// if we hit an entity, check if we hurt + go thru it
		
		ent = gameLocal.GetTraceEntity( tr );
		if ( ent->IsType( idActor::GetClassType() ) ||
			ent->IsType( idProjectile::GetClassType() ) ||
			ent->IsType( BuildableEntity::GetClassType() ) ) {

			myDamage.SetDamageScale( 1.0f );
			ent->Damage_TF( myDamage, GetProjRadius( proj ) );
			travel *= tr.fraction;
			ignore = ent;
			continue;
		}

		//consider the entity solid and bounce off
		float dot = proj.velocity * tr.c.normal;
		proj.velocity  = ( proj.velocity - ( 2.0f * dot * tr.c.normal ) ) * bounce;

		break;
	}

	float dist = ( proj.origin - startPos ).Length();

	// apply friction
	float speed = proj.velocity.Length();
	float newSpeed = speed - ( dist * airFriction );
	if ( newSpeed < 0.0f )
		newSpeed = 0.0f;

	proj.velocity *= ( newSpeed / speed );

	// apply gravity
	proj.velocity += ( gameLocal.GetGravity() * timeSec * gravityScale );

	proj.distSum += dist;

	float distSinceLastSplode = proj.distSum - proj.distLastSplode;

	// draw explosion?
	if ( distSinceLastSplode >= minSplodeDist ) {
		proj.distLastSplode = proj.distSum;
		DoExplosion( proj );
	}

	proj.lastCalcTime = gameLocal.time;
}

void DetPak::DoExplosion( const detPackProjectile_t &proj ) {
	assert( !gameLocal.isClient );

	float radius = GetProjRadius( proj );

	// damage entities
	myDamage.SetDamageScale( radius );
	gameLocal.RadiusDamage_TF( proj.origin, myDamage, this );

	// draw the explosion
	DrawExplosion( proj.origin, radius );
}

void DetPak::DrawExplosion( const idVec3 &pos, float radius ) {
	assert( !gameLocal.isClient );

	byte msgBuf[MAX_GAME_MESSAGE_SIZE];

	idBitMsg outMsg;
	outMsg.Init( msgBuf, sizeof( msgBuf ) );
	outMsg.BeginWriting();
	outMsg.WriteByte( GAME_UNRELIABLE_MESSAGE_DETSPLODE );	
	outMsg.WriteFloat( pos.x );
	outMsg.WriteFloat( pos.y );
	outMsg.WriteFloat( pos.z );
	outMsg.WriteByte( idMath::ClampByte( (int)(radius * 255) ) );

	int areaNum = gameLocal.pvs.GetPVSArea( pos );
	
	if ( !onlyLOS ) {
		gameLocal.SendUnreliableMessagePVS( outMsg, this, areaNum );
	}
	else {
		// 3j_todo ?
		gameLocal.SendUnreliableMessagePVS( outMsg, this, areaNum );
	}


	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local ) {
		if ( gameLocal.clientsPVS[ local->entityNumber ].i >= 0 ) {
			if ( gameLocal.pvs.InCurrentPVS( gameLocal.clientsPVS[ local->entityNumber ], &areaNum, 1 ) ) {
				gameLocal.DrawDetpackSplode( pos, radius );
			}
		}
	}
}

void DetPak::Event_Charge() {
	StartSound( "snd_countdown", SND_CHANNEL_ITEM, 0, true, NULL );
}

float DetPak::GetProjRadius( const detPackProjectile_t &proj ) {
	return idMath::ClampFloat( 0.5f, 1.0f, 1.0f - ( (float)( gameLocal.time - proj.timeStart ) / (float)( proj.timeEnd - proj.timeStart ) ) );
}

void DetPak::EmpTouch( const AttackerInfo &attacker, idVec3 &dir, float damageScale ) {
	if ( gameLocal.isClient || !built )
		return;

	CancelEvents( &EV_Explode );
	CancelEvents( &EV_Charge );

	const char* empDamageStr = NULL;
	if ( !spawnArgs.GetString( "def_empdamage", "", &empDamageStr ) || !empDamageStr || !empDamageStr[0] )
		return;

	myDamage.Create( attacker, empDamageStr, 1.0f );

	PostEventSec( &EV_Explode, 0.1f + gameLocal.random.RandomFloat() );
}




