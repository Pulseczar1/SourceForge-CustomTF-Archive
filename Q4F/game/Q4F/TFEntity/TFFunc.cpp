#include "../../../idlib/precompiled.h"
#pragma hdrstop

#include "../../Game_local.h"

CLASS_DECLARATION( TFEntity, q4fPlayerStart )
	EVENT( EV_Activate,			q4fPlayerStart::Event_TeleportPlayer )
END_CLASS

/*
===============
idPlayerStart::idPlayerStart
================
*/
q4fPlayerStart::q4fPlayerStart( void ) {
}

q4fPlayerStart::~q4fPlayerStart() {
	spawnType.Clear();

	gameLocal.spawnSpots.Remove( this );
}

/*
===============
idPlayerStart::Spawn
================
*/
void q4fPlayerStart::Spawn( void ) {
	spawnType = spawnArgs.GetString( "spawntype", "" );

	gameLocal.spawnSpots.AddUnique( this );
}

void q4fPlayerStart::OnStateChange( tfstate_t oldState, tfstate_t newState, idEntity* activator ) {
}

bool q4fPlayerStart::ClientReceiveEvent( int event, int time, const idBitMsg &msg ) {
	int entityNumber;

	switch( event ) {
		case EVENT_TELEPORTPLAYER: {
			entityNumber = msg.ReadBits( GENTITYNUM_BITS );
			idPlayer *player = static_cast<idPlayer *>( gameLocal.entities[entityNumber] );

			if ( player != NULL && player->IsType( idPlayer::GetClassType() ) ) {
				Event_TeleportPlayer( player );
			}
			return true;
		}
		default: {
			return TFEntity::ClientReceiveEvent( event, time, msg );
		}
	}
}

void q4fPlayerStart::TeleportPlayer( idPlayer *player ) {
	assert( player );
	player->Teleport( GetPhysics()->GetOrigin(), GetPhysics()->GetAxis().ToAngles(), NULL );
	float pushVel = spawnArgs.GetFloat( "push", "50000" );

	// multiplayer hijacked this entity, so only push the player in multiplayer
	//direct teleport, play effect & sound
	StartSound( "snd_teleport_enter", SND_CHANNEL_ANY, 0, false, NULL );
	gameLocal.PlayEffect( player->spawnArgs, "fx_teleport", player->GetPhysics()->GetOrigin(), idVec3(0,0,1).ToMat3(), false, vec3_origin );
	idVec3 impulse( pushVel, 0, 0 );
	impulse *= GetPhysics( )->GetAxis ( );
	player->ApplyImpulse( gameLocal.world, 0, player->GetPhysics( )->GetOrigin( ), impulse );
}

void q4fPlayerStart::Teleport( idEntity* other ) {
	other->SetOrigin( GetPhysics()->GetOrigin() );
	idVec3 vel = other->GetPhysics()->GetLinearVelocity();
	vel *= GetPhysics()->GetAxis();
	other->GetPhysics()->SetLinearVelocity( vel );
}

void q4fPlayerStart::Event_TeleportPlayer( idEntity *activator ) {
	idPlayer *player;

	if ( activator->IsType( idPlayer::GetClassType() ) ) {

		player = static_cast<idPlayer*>( activator );
	} else {
		player = NULL;
		Teleport( activator );
	}

	if ( player ) {
		if ( !gameLocal.isClient ) {
			idBitMsg	msg;
			byte		msgBuf[MAX_EVENT_PARAM_SIZE];

			msg.Init( msgBuf, sizeof( msgBuf ) );
			msg.BeginWriting();
			msg.WriteBits( player->entityNumber, GENTITYNUM_BITS );
			ServerSendEvent( EVENT_TELEPORTPLAYER, &msg, false, -1 );
		}

		TeleportPlayer( player );
	}
}