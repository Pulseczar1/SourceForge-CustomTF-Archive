#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"

CLASS_DECLARATION( idEntity, BuildableEntity )
END_CLASS

BuildableEntity::BuildableEntity() {
	ownerInfo.Create( NULL );
	buildStartTime = 0;
	fl.networkSync = true;
}

BuildableEntity::~BuildableEntity() {
	SetPhysics( NULL );
}

void BuildableEntity::Spawn() {
	buildTime = SEC2MS( spawnArgs.GetInt( "build_time", "5" ) );
	maxBuildDist = spawnArgs.GetFloat( "max_build_dist", "64.0" );

	physicsObj.SetSelf( this );

	RV_PUSH_HEAP_MEM(this);
 	physicsObj.SetClipModel( new idClipModel( GetPhysics()->GetClipModel() ), 1.0f );
	RV_POP_HEAP();

 	physicsObj.SetContents( 0 );
 	physicsObj.SetClipMask( 0 );
 	physicsObj.PutToRest();
 	SetPhysics( &physicsObj );

	physicsObj.alwaysCheckGround = true;

	buildStartTime = 0;

	if ( gameLocal.isClient )
		Hide();
}

void BuildableEntity::SetOwner( idPlayer* newOwner ) {
	assert( newOwner );

	ownerInfo.Create( newOwner );
	team = newOwner->team;
	UpdateVisibleColor();
}


void BuildableEntity::StartBuilding( idPlayer* owner, const idVec3 &pos, float rotation, int _buildStartTime ) {

	assert( buildStartTime <= 0 );

	SetOwner( owner );

	physicsObj.SetFriction( 0.0f, 0.0f, 0.0f );
	physicsObj.SetBouncyness( 0.0f, false );
	physicsObj.SetGravity( gameLocal.GetCurrentGravity(this) );
	physicsObj.SetContents( CONTENTS_SOLID );
 	physicsObj.SetClipMask( MASK_SOLID );

	// sigh....
	if ( !gameLocal.isClient ) {

		idAngles ang( 0.0f, rotation, 0.0f );

		physicsObj.SetLinearVelocity( vec3_zero );
		physicsObj.SetOrigin( pos );
		physicsObj.SetAxis( ang.ToMat3() );
		
		ownerInfo.GetPlayer()->isBuilding = true;
	}

	physicsObj.EnableClip();
	physicsObj.Activate();

	buildStartTime = _buildStartTime;

	UpdateVisuals();

	BuildStarted();

	SendEffectEvent( BUILD_FX_START );
}

void BuildableEntity::SendEffectEvent( buildFxEvent_t event ) {
	if ( gameLocal.isClient )
		return;

	idBitMsg	msg;
	byte		msgBuf[MAX_EVENT_PARAM_SIZE];

	//if ( ReceiveEffectEvent( event ) ) {
		msg.Init( msgBuf, sizeof( msgBuf ) );
		msg.BeginWriting();
		msg.WriteBits( event, 2 );
		ServerSendEvent( EVENT_BUILDEFFECT, &msg, false, -1 );
	//}
	ReceiveEffectEvent( event );
}


bool BuildableEntity::ReceiveEffectEvent( buildFxEvent_t event ) {
	switch( event ) {
		case BUILD_FX_START:
			return PlayEffect( "fx_build", GetPhysics()->GetOrigin(), mat3_identity ) != NULL;

		case BUILD_FX_STOP:
			StopEffect( "fx_build", false );
			return true;


		case BUILD_FX_FINISHED:
			StopEffect( "fx_build", false );
			return PlayEffect( "fx_buildfinished", GetPhysics()->GetOrigin(), mat3_identity ) != NULL;
	}

	return false;
}

bool BuildableEntity::ClientReceiveEvent( int event, int time, const idBitMsg &msg ) {
	int action;

	switch( event ) {
		case EVENT_BUILDEFFECT:
			action = msg.ReadBits( 2 );

			ReceiveEffectEvent( (buildFxEvent_t)action );
			return true;
	}

	return idEntity::ClientReceiveEvent( event, time, msg );
}

void BuildableEntity::StopBuilding() {
	assert( !gameLocal.isClient );

	ownerInfo.GetPlayer()->isBuilding = false;

	//SendEffectEvent( BUILD_FX_STOP );

	PostEventMS( &EV_Remove, 0 );
}

float BuildableEntity::UpdateBuildStatus() {
	assert( !gameLocal.isClient );

	float percent = GetBuildPercent( gameLocal.time );

	idPlayer* owner = ownerInfo.GetPlayer();

	if ( percent >= 1.0f ) {

		if ( owner ) {
			owner->isBuilding = false;

			int numAmmoRequired = spawnArgs.GetInt( "ammo_required", "0" );
			if ( numAmmoRequired > 0 ) {
				int ammoType = owner->inventory.AmmoIndexForAmmoClass( spawnArgs.GetString( "ammo_type", "ammo_none" ) );
				owner->inventory.UseAmmo( ammoType, numAmmoRequired );
			}
		}

		SendEffectEvent( BUILD_FX_FINISHED );

		BuildFinished();
		return 1.0f;
	}

	if ( owner ) {
		float dist = ( GetPhysics()->GetAbsBounds().GetCenter() - ownerInfo.GetPlayer()->GetPhysics()->GetAbsBounds().GetCenter() ).Length();
		if ( dist > maxBuildDist || ownerInfo.GetPlayer()->health <= 0 || ownerInfo.GetPlayer()->spectating ) {
			StopBuilding();
			return -1.0f;
		}
	}

	return percent;        
}

void BuildableEntity::WriteToSnapshot( idBitMsgDelta &msg ) const {
	physicsObj.WriteToSnapshot( msg );

	msg.WriteLong( buildStartTime );

	if ( buildStartTime > 0 ) {
		idPlayer* owner = ownerInfo.GetPlayer();
		msg.WriteBits( owner ? owner->entityNumber : 32, ASYNC_MAX_CLIENT_BITS );
		msg.WriteFloat( physicsObj.GetAxis().ToAngles().yaw );
	}
}

void BuildableEntity::ReadFromSnapshot( const idBitMsgDelta &msg ) {
	physicsObj.ReadFromSnapshot( msg );
	
	int oldBuildTime = buildStartTime;
	int buildTime = msg.ReadLong();

	if ( buildTime > 0 ) {
		int ownerNum = msg.ReadBits( ASYNC_MAX_CLIENT_BITS );

		float yaw = msg.ReadFloat();
		idAngles ang( 0.0f, yaw, 0.0f );
		physicsObj.SetAxis( ang.ToMat3() );

		if ( oldBuildTime <= 0 && ownerNum < MAX_CLIENTS ) {
			StartBuilding( GET_PLAYER( ownerNum ), vec3_zero, 0.0f, buildStartTime );
			Show();
			buildStartTime = buildTime;
		}
	}
}
