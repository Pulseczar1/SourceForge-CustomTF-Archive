//----------------------------------------------------------------
// Instance.cpp
//
// Copyright 2002-2005 Raven Software
//----------------------------------------------------------------

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "Instance.h"

rvInstance::rvInstance( int id, bool deferPopulate ) {
	instanceID = id;
	spawnInstanceID = id;

	gameLocal.AddClipWorld( id );

	mapEntityNumbers = NULL;
	numMapEntities = 0;

	initialSpawnCount = idGameLocal::INITIAL_SPAWN_COUNT;

	if( !deferPopulate ) {
		Populate();
	}
}

rvInstance::~rvInstance() {
	delete[] mapEntityNumbers;
	gameLocal.RemoveClipWorld( instanceID );
}

void rvInstance::Populate( void ) {
	gameState_t currentState = gameLocal.GameState();
	
	if( currentState != GAMESTATE_STARTUP ) {
		gameLocal.SetGameState( GAMESTATE_RESTART );
	}

	if( gameLocal.isServer ) {
		// When populating on a server, record the entity numbers	
		numMapEntities = gameLocal.GetNumMapEntities();

		// mwhitlock: Dynamic memory consolidation
		RV_PUSH_SYS_HEAP_ID(RV_HEAP_ID_LEVEL);
		mapEntityNumbers = new unsigned short[ numMapEntities ];
		RV_POP_HEAP();

		memset( mapEntityNumbers, -1, sizeof( unsigned short ) * numMapEntities );

		// Spawn the map entities for this instance and capture their entity numbers

		// remember the spawnCount ahead of time, so that the client can accurately reconstruct its spawnIds
//		gameLocal.SpawnMapEntities( spawnInstanceID, NULL, mapEntityNumbers, &initialSpawnCount );

		// only build the message in MP
		if( gameLocal.isMultiplayer ) {
			BuildInstanceMessage();

			// force joins of anyone in our instance so they get potentially new map entitynumbers
			for( int i = 0; i < MAX_CLIENTS; i++ ) {
				idPlayer* player = (idPlayer*)gameLocal.entities[ i ];
				if( player && player->GetInstance() == instanceID ) {
					networkSystem->ServerSendReliableMessage( player->entityNumber, mapEntityMsg );
				}
			}
		}
	} else {
		// When populating on a client, spawn the map using existing numbers
		
		// check for good state
		// OK to spawn w/o specific entity numbers if we're in the startup process.  Otherwise, 
		// we need entity numbers from the server.
		assert( mapEntityNumbers || ( instanceID == 0 && gameLocal.GameState() == GAMESTATE_STARTUP ) );
		
		gameLocal.SetSpawnCount( initialSpawnCount );
//		gameLocal.SpawnMapEntities( spawnInstanceID, mapEntityNumbers, NULL );
	}


	for( int i = 0; i < numMapEntities; i++ ) {
		if( mapEntityNumbers[ i ] < 0 || mapEntityNumbers[ i ] >= MAX_GENTITIES ) {
			continue;
		}

		idEntity* ent = gameLocal.entities[ mapEntityNumbers[ i ] ];

		if( ent ) {
			ent->PostEventMS( &EV_FindTargets, 0 );
			ent->PostEventMS( &EV_PostSpawn, 0 );
		}
	}

	if( currentState != GAMESTATE_STARTUP ) {
		gameLocal.SetGameState( currentState );
	}
}

void rvInstance::PopulateFromMessage( const idBitMsg& msg ) {
	numMapEntities = msg.ReadShort();
	initialSpawnCount = msg.ReadShort();

	delete[] mapEntityNumbers;


// mwhitlock: Dynamic memory consolidation
	RV_PUSH_SYS_HEAP_ID(RV_HEAP_ID_LEVEL);
	mapEntityNumbers = new unsigned short[ numMapEntities ];
	RV_POP_HEAP();

	memset( mapEntityNumbers, -1, sizeof( unsigned short ) * numMapEntities );

	for( int i = 0; i < numMapEntities; i++ ) {
		mapEntityNumbers[ i ] = msg.ReadShort();
	}

	Populate();
}

void rvInstance::Restart( void ) {
	if( gameLocal.isMultiplayer ) {
		Populate();
	} else {
		gameLocal.SpawnMapEntities();
	}
}

void rvInstance::BuildInstanceMessage( void ) {
	// Build the client join instance msg
	mapEntityMsg.BeginWriting();
	mapEntityMsg.Init( mapEntityMsgBuf, sizeof( byte ) * MAX_GAME_MESSAGE_SIZE );
	mapEntityMsg.WriteByte( GAME_RELIABLE_MESSAGE_SET_INSTANCE );

	mapEntityMsg.WriteByte( instanceID );
	mapEntityMsg.WriteShort( numMapEntities );
	mapEntityMsg.WriteShort( initialSpawnCount );

	for( int i = 0; i < numMapEntities; i++ ) {
		mapEntityMsg.WriteShort( mapEntityNumbers[ i ] );
	}
}

void rvInstance::JoinInstance( idPlayer* player ) {
	assert( player && gameLocal.isServer );

	// Transmit the instance information to the new client
	if( gameLocal.isListenServer && player == gameLocal.GetLocalPlayer() ) {
		gameLocal.mpGame.ServerSetInstance( instanceID );
	} else {
		networkSystem->ServerSendReliableMessage( player->entityNumber, mapEntityMsg );
	}
}

void rvInstance::PrintMapNumbers( void ) {
	gameLocal.Printf( "Instance: %d\n", instanceID );
	gameLocal.Printf( "Num Map Entities: %d\n", numMapEntities );

	for( int i = 0; i < numMapEntities; i++ ) {
		gameLocal.Printf( "%d\n", mapEntityNumbers[ i ] );
	}
}

/*
================
rvInstance::SetSpawnInstanceID
Sets the spawn instance ID for this instance.  On the client, only instance 0 is ever 
used, but it spawns in map entities for other instances.  spawnInstanceID is used to
spawn map entities with the correct instance number on the client.
================
*/
void rvInstance::SetSpawnInstanceID( int newInstance ) {
	assert( gameLocal.isClient );

	spawnInstanceID = newInstance;
}
