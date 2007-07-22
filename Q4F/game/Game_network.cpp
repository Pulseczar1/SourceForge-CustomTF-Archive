#include "../idlib/precompiled.h"
#pragma hdrstop

#include "Game_local.h"

// bdube: client entities
#include "client/ClientEffect.h"
// shouchard:  ban list support
#define BANLIST_FILENAME "banlist.txt"


/*
===============================================================================

	Client running game code:
	- entity events don't work and should not be issued
	- entities should never be spawned outside idGameLocal::ClientReadSnapshot

===============================================================================
*/

// adds tags to the network protocol to detect when things go bad ( internal consistency )
// NOTE: this changes the network protocol
#ifndef ASYNC_WRITE_TAGS
	#define ASYNC_WRITE_TAGS 1
#endif

idCVar net_clientShowSnapshot( "net_clientShowSnapshot", "0", CVAR_GAME | CVAR_INTEGER, "", 0, 3, idCmdSystem::ArgCompletion_Integer<0,3> );
idCVar net_clientShowSnapshotRadius( "net_clientShowSnapshotRadius", "128", CVAR_GAME | CVAR_FLOAT, "" );
idCVar net_clientMaxPrediction( "net_clientMaxPrediction", "1000", CVAR_SYSTEM | CVAR_INTEGER | CVAR_NOCHEAT, "maximum number of milliseconds a client can predict ahead of server." );
idCVar net_clientLagOMeter( "net_clientLagOMeter", "0", CVAR_GAME | CVAR_BOOL | CVAR_NOCHEAT | PC_CVAR_ARCHIVE, "draw prediction graph" );


// ddynerman: performance profiling
int net_entsInSnapshot;
int net_snapshotSize;

extern const int ASYNC_PLAYER_FRAG_BITS;

// message senders
idNullMessageSender nullSender;
idServerReliableMessageSender serverReliableSender;
idRepeaterReliableMessageSender repeaterReliableSender;

/*
================
idGameLocal::InitAsyncNetwork
================
*/
void idGameLocal::InitAsyncNetwork( void ) {
	memset( clientEntityStates, 0, sizeof( clientEntityStates ) );
	memset( clientPVS, 0, sizeof( clientPVS ) );
	memset( clientSnapshots, 0, sizeof( clientSnapshots ) );

	memset( viewerEntityStates, 0, sizeof( *viewerEntityStates ) * maxViewers );
	memset( viewerPVS, 0, sizeof( *viewerPVS ) * maxViewers );
	memset( viewerSnapshots, 0, sizeof( *viewerSnapshots ) * maxViewers );
	memset( viewerUnreliableMessages, 0, sizeof (*viewerUnreliableMessages) * maxViewers );

	eventQueue.Init();

	entityDefBits = -( idMath::BitsForInteger( declManager->GetNumDecls( DECL_ENTITYDEF ) ) + 1 );
	localClientNum = 0; // on a listen server SetLocalUser will set this right
	realClientTime = 0;
	isNewFrame = true;
}

/*
================
idGameLocal::ShutdownAsyncNetwork
================
*/
void idGameLocal::ShutdownAsyncNetwork( void ) {
	entityStateAllocator.Shutdown();
	snapshotAllocator.Shutdown();
	eventQueue.Shutdown();
	memset( clientEntityStates, 0, sizeof( clientEntityStates ) );
	memset( clientPVS, 0, sizeof( clientPVS ) );
	memset( clientSnapshots, 0, sizeof( clientSnapshots ) );

	memset( viewerEntityStates, 0, sizeof( *viewerEntityStates ) * maxViewers );
	memset( viewerPVS, 0, sizeof( *viewerPVS ) * maxViewers );
	memset( viewerSnapshots, 0, sizeof( *viewerSnapshots ) * maxViewers );
	memset( viewerUnreliableMessages, 0, sizeof (*viewerUnreliableMessages) * maxViewers );
}

/*
================
idGameLocal::InitLocalClient
================
*/
void idGameLocal::InitLocalClient( int clientNum ) {
	isServer = false;
	isClient = true;
	localClientNum = clientNum;
}

/*
================
idGameLocal::ServerAllowClient
clientId is the ID of the connecting client - can later be mapped to a clientNum by calling networkSystem->ServerGetClientNum( clientId )
================
*/
allowReply_t idGameLocal::ServerAllowClient( int clientId, int numClients, const char *IP, const char *guid, const char *password, const char *privatePassword, char reason[ MAX_STRING_CHARS ] ) {
	reason[0] = '\0';

// RAVEN BEGIN
// shouchard:  ban support
	if ( IsGuidBanned( guid ) ) {
		idStr::snPrintf( reason, MAX_STRING_CHARS, "#str_107239" );
		return ALLOW_NO;
	}
// RAVEN END

	if ( serverInfo.GetInt( "si_pure" ) && !mpGame.IsPureReady() ) {
		idStr::snPrintf( reason, MAX_STRING_CHARS, "#str_107139" );
		return ALLOW_NOTYET;
	}

	if ( !serverInfo.GetInt( "si_maxPlayers" ) ) {
		idStr::snPrintf( reason, MAX_STRING_CHARS, "#str_107140" );
		return ALLOW_NOTYET;
	}

	// completely full
	if ( numClients >= serverInfo.GetInt( "si_maxPlayers" ) ) {
		idStr::snPrintf( reason, MAX_STRING_CHARS, "#str_107141" );
		return ALLOW_NOTYET;
	}

	// check private clients
	if( serverInfo.GetInt( "si_privatePlayers" ) > 0 ) {
		// just in case somehow we have a stale private clientId that matches a new client
		mpGame.RemovePrivatePlayer( clientId );

		const char *privatePass = cvarSystem->GetCVarString( "g_privatePassword" );
		if( privatePass[ 0 ] == '\0' ) {
			common->Warning( "idGameLocal::ServerAllowClient() - si_privatePlayers > 0 with no g_privatePassword" );
			cmdSystem->BufferCommandText( CMD_EXEC_NOW, "say si_privatePlayers is set but g_privatePassword is empty" );
			idStr::snPrintf( reason, MAX_STRING_CHARS, "#str_107142" );
			return ALLOW_NOTYET;
		}


		int numPrivateClients = cvarSystem->GetCVarInteger( "si_numPrivatePlayers" );

		// private clients that take up public slots are considered public clients
		numPrivateClients = idMath::ClampInt( 0, serverInfo.GetInt( "si_privatePlayers" ), numPrivateClients );

		if ( !idStr::Cmp( privatePass, privatePassword ) ) {
			// once this client spawns in, they'll be marked private
			mpGame.AddPrivatePlayer( clientId );
		} else if( (numClients - numPrivateClients) >= (serverInfo.GetInt( "si_maxPlayers" ) - serverInfo.GetInt( "si_privatePlayers" )) ) {
			// if the number of public clients is greater than or equal to the number of public slots, require a private slot
			idStr::snPrintf( reason, MAX_STRING_CHARS, "#str_107141" );
			return ALLOW_NOTYET;
		}
	} 
	

	if ( !cvarSystem->GetCVarBool( "si_usePass" ) ) {
		return ALLOW_YES;
	}

	const char *pass = cvarSystem->GetCVarString( "g_password" );
	if ( pass[ 0 ] == '\0' ) {
		common->Warning( "si_usePass is set but g_password is empty" );
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, "say si_usePass is set but g_password is empty" );
		// avoids silent misconfigured state
		idStr::snPrintf( reason, MAX_STRING_CHARS, "#str_107142" );
		return ALLOW_NOTYET;
	}

	if ( !idStr::Cmp( pass, password ) ) {
		return ALLOW_YES;
	}

	idStr::snPrintf( reason, MAX_STRING_CHARS, "#str_107143" );
	Printf( "Rejecting client %s from IP %s: invalid password\n", guid, IP );
	return ALLOW_BADPASS;
}

/*
================
idGameLocal::ReallocViewers
Allocate/Reallocate space for viewers
================
*/
template<typename T> static ID_INLINE void ReallocateZero( T *&var, int oldSize, int newSize ) {
	T *new_var = newSize ? new T[ newSize ] : NULL;
	SIMDProcessor->Memcpy( new_var, var, sizeof(*new_var) * Min( newSize, oldSize ) );
	delete[] var;
	var = new_var;
	if ( newSize > oldSize ) {
		SIMDProcessor->Memset( var + oldSize, 0, sizeof(*var) * (newSize - oldSize) );
	}
}

/*
================
idGameLocal::RepeaterAllowClient
clientId is the ID of the connecting client - can later be mapped to a clientNum by calling networkSystem->ServerGetClientNum( clientId )
================
*/
allowReply_t idGameLocal::RepeaterAllowClient( int clientId, int numClients, const char *IP, const char *guid, bool repeater, const char *password, const char *privatePassword, char reason[ MAX_STRING_CHARS ] ) {
	reason[0] = '\0';

	if ( IsGuidBanned( guid ) ) {
		idStr::snPrintf( reason, MAX_STRING_CHARS, "#str_107239" );
		return ALLOW_NO;
	}

	if ( serverInfo.GetInt( "si_pure" ) != 0 && !mpGame.IsPureReady() ) {
		idStr::snPrintf( reason, MAX_STRING_CHARS, "#str_107139" );
		return ALLOW_NOTYET;
	}

	if ( !cvarSystem->GetCVarInteger( "ri_maxViewers" ) ) {
		idStr::snPrintf( reason, MAX_STRING_CHARS, "#str_123000" );
		return ALLOW_NOTYET;
	}

	// completely full
	if ( numClients >= cvarSystem->GetCVarInteger( "ri_maxViewers" ) ) {
		idStr::snPrintf( reason, MAX_STRING_CHARS, "#str_123000" );
		return ALLOW_NOTYET;
	}

	// check private clients
	// just in case somehow we have a stale private clientId that matches a new client
	privateViewerIds.Remove( clientId );
	nopvsViewerIds.Remove( clientId );

	const char *privatePass = cvarSystem->GetCVarString( "g_privateViewerPassword" );
	if ( privatePass[ 0 ] == '\0' && ri_privateViewers.GetInteger() > 0 ) {
		common->Warning( "idGameLocal::RepeaterAllowClient() - ri_privateViewers > 0 with no g_privateViewerPassword" );
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, "say ri_privateViewers is set but g_privateViewerPassword is empty" );
		idStr::snPrintf( reason, MAX_STRING_CHARS, "#str_107142" );
		return ALLOW_NOTYET;
	}

	int numPrivateClients = privateViewerIds.Num();

	// private clients that take up public slots are considered public clients
	numPrivateClients = idMath::ClampInt( 0, ri_privateViewers.GetInteger(), numPrivateClients );

	if ( repeater ) {
		const char *nopvsPass = cvarSystem->GetCVarString( "g_repeaterPassword" );

		if ( nopvsPass[ 0 ] != '\0' ) {
			if ( idStr::Cmp( nopvsPass, privatePassword ) ) {
				// password is set, and they don't match.
				idStr::snPrintf( reason, MAX_STRING_CHARS, "#str_107143" );
				Printf( "Rejecting viewer %s from IP %s: invalid password for repeater\n", guid, IP );
				return ALLOW_BADPASS;
			}

			// once this client spawns in, they'll be marked private
			privateViewerIds.Append( clientId );
		} else {
			if ( privatePass[ 0 ] != '\0' && !idStr::Cmp( privatePass, privatePassword ) ) {
				// once this client spawns in, they'll be marked private
				privateViewerIds.Append( clientId );
			}
		}

		// once this client spawns in, they'll be marked as a broadcaster
		nopvsViewerIds.Append( clientId );
	} else if ( privatePass[ 0 ] != '\0' && !idStr::Cmp( privatePass, privatePassword ) ) {
		// once this client spawns in, they'll be marked private
		privateViewerIds.Append( clientId );
	} else if( (numClients - numPrivateClients) >= ( cvarSystem->GetCVarInteger( "ri_maxViewers" ) - ri_privateViewers.GetInteger() ) ) {
		// if the number of public clients is greater than or equal to the number of public slots, require a private slot
		idStr::snPrintf( reason, MAX_STRING_CHARS, "#str_107141" );
		return ALLOW_NOTYET;
	}

	if ( !ri_useViewerPass.GetBool() ) {
		return ALLOW_YES;
	}

	const char *pass = cvarSystem->GetCVarString( "g_viewerPassword" );
	if ( pass[ 0 ] == '\0' ) {
		common->Warning( "ri_useViewerPass is set but g_viewerPassword is empty" );
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, "say ri_useViewerPass is set but g_viewerPassword is empty" );
		// avoids silent misconfigured state
		idStr::snPrintf( reason, MAX_STRING_CHARS, "#str_107142" );
		return ALLOW_NOTYET;
	}

	if ( !idStr::Cmp( pass, password ) ) {
		return ALLOW_YES;
	}

	idStr::snPrintf( reason, MAX_STRING_CHARS, "#str_107143" );
	Printf( "Rejecting viewer %s from IP %s: invalid password\n", guid, IP );
	return ALLOW_BADPASS;
}
/*
================
idGameLocal::ServerClientConnect
================
*/
//void idGameLocal::ServerClientConnect( int clientNum ) {
void idGameLocal::ServerClientConnect( int clientNum, const char *guid ) {
	// make sure no parasite entity is left
	if ( entities[ clientNum ] ) {
		common->DPrintf( "ServerClientConnect: remove old player entity\n" );
		delete entities[ clientNum ];
	}
	unreliableMessages[ clientNum ].Init( 0 );
	userInfo[ clientNum ].Clear();
	mpGame.ServerClientConnect( clientNum );
	Printf( "client %d connected.\n", clientNum );
}

/*
================
idGameLocal::ServerClientBegin
================
*/
void idGameLocal::ServerClientBegin( int clientNum ) {
	idBitMsg	outMsg;
	byte		msgBuf[MAX_GAME_MESSAGE_SIZE];

	// spawn the player
	SpawnPlayer( clientNum );
	if( clientNum == localClientNum ) {
		mpGame.EnterGame( clientNum );
	}

	// ddynerman: connect time
	((idPlayer*)entities[ clientNum ])->SetConnectTime( time );

	// send message to spawn the player at the clients
	outMsg.Init( msgBuf, sizeof( msgBuf ) );
	outMsg.BeginWriting();
	outMsg.WriteByte( GAME_RELIABLE_MESSAGE_SPAWN_PLAYER );
	outMsg.WriteBits( clientNum, ASYNC_MAX_CLIENT_BITS );
	outMsg.WriteLong( spawnIds[ clientNum ] );
	networkSystem->ServerSendReliableMessage( -1, outMsg );
}

/*
================
idGameLocal::ServerClientDisconnect
clientNum == MAX_CLIENTS for cleanup of server demo recording data
================
*/
void idGameLocal::ServerClientDisconnect( int clientNum ) {
	int			i;
	idBitMsg	outMsg;
	byte		msgBuf[MAX_GAME_MESSAGE_SIZE];

	qqq( "------- ServerClientDisconnect -------" );

	tfStatManager->ClientDisconnect( clientNum );
	
	qqd( "Client Num", clientNum );

	if ( clientNum < MAX_CLIENTS ) {
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.BeginWriting();
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_DELETE_ENT );
		outMsg.WriteBits( ( spawnIds[ clientNum ] << GENTITYNUM_BITS ) | clientNum, 32 ); // see GetSpawnId
		networkSystem->ServerSendReliableMessage( -1, outMsg );
	}

	qqq( "Free Old Snapshots" );

	// free snapshots stored for this client
	FreeSnapshotsOlderThanSequence( clientNum, 0x7FFFFFFF );

	qqq( "Free Entity States" );


	// free entity states stored for this client
	for ( i = 0; i < MAX_GENTITIES; i++ ) {
		if ( clientEntityStates[ clientNum ][ i ] ) {
			entityStateAllocator.Free( clientEntityStates[ clientNum ][ i ] );
			clientEntityStates[ clientNum ][ i ] = NULL;
		}
	}

	qqq( "Clear Client PVS" );

	// clear the client PVS
	memset( clientPVS[ clientNum ], 0, sizeof( clientPVS[ clientNum ] ) );

	if ( clientNum == MAX_CLIENTS ) {
		return;
	}

	// only drop MP clients if we're in multiplayer and the server isn't going down
	if( gameLocal.isMultiplayer && !(gameLocal.isListenServer && clientNum == gameLocal.localClientNum ) ) {
		// idMultiplayerGame::DisconnectClient will do the delete in MP
		mpGame.DisconnectClient( clientNum );
	} else {
		// delete the player entity
		qqq( "Deleting entity..." );
		delete entities[ clientNum ];
	}

	/*while ( numClients - 1 >= 0 && entities[ numClients - 1 ] == NULL ) {
		qqd( "Reducing numclients to", numClients - 1 );
		numClients--;
	}*/

	qqq( "-----------------------------" );
}

/*
================
idGameLocal::ServerWriteInitialReliableMessages

  Send reliable messages to initialize the client game up to a certain initial state.
================
*/
void idGameLocal::ServerWriteInitialReliableMessages( int clientNum ) {
	int			i;
	idBitMsg	outMsg;
	byte		msgBuf[MAX_GAME_MESSAGE_SIZE];

	// spawn players
	for ( i = 0; i < MAX_CLIENTS; i++ ) {
		if ( entities[i] == NULL || i == clientNum ) {
			continue;
		}
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.BeginWriting( );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_SPAWN_PLAYER );
		outMsg.WriteByte( i );
		outMsg.WriteLong( spawnIds[ i ] );
		networkSystem->ServerSendReliableMessage( clientNum, outMsg );
	}

	// update portals for opened doors
	int numPortals = gameRenderWorld->NumPortals();
	outMsg.Init( msgBuf, sizeof( msgBuf ) );
	outMsg.BeginWriting();
	outMsg.WriteByte( GAME_RELIABLE_MESSAGE_PORTALSTATES );
	outMsg.WriteLong( numPortals );
	for ( i = 0; i < numPortals; i++ ) {
		outMsg.WriteBits( gameRenderWorld->GetPortalState( (qhandle_t) (i+1) ) , NUM_RENDER_PORTAL_BITS );
	}
	networkSystem->ServerSendReliableMessage( clientNum, outMsg );

	mpGame.ServerWriteInitialReliableMessages( clientNum );
}

/*
================
idGameLocal::FreeSnapshotsOlderThanSequence
================
*/
void idGameLocal::FreeSnapshotsOlderThanSequence( snapshot_t *&clientSnapshot, int sequence ) {
	snapshot_t *snapshot, *lastSnapshot, *nextSnapshot;
	entityState_t *state;

	for ( lastSnapshot = NULL, snapshot = clientSnapshot; snapshot; snapshot = nextSnapshot ) {
		nextSnapshot = snapshot->next;
		if ( snapshot->sequence < sequence ) {
			for ( state = snapshot->firstEntityState; state; state = snapshot->firstEntityState ) {
				snapshot->firstEntityState = snapshot->firstEntityState->next;
				entityStateAllocator.Free( state );
			}
			if ( lastSnapshot ) {
				lastSnapshot->next = snapshot->next;
			} else {
				clientSnapshot = snapshot->next;
			}
			snapshotAllocator.Free( snapshot );
		} else {
			lastSnapshot = snapshot;
		}
	}
}

/*
================
idGameLocal::FreeSnapshotsOlderThanSequence
================
*/
void idGameLocal::FreeSnapshotsOlderThanSequence( int clientNum, int sequence ) {
	FreeSnapshotsOlderThanSequence( clientSnapshots[ clientNum ], sequence );
}

/*
================
idGameLocal::ApplySnapshot
================
*/
bool idGameLocal::ApplySnapshot( int clientNum, int sequence ) {
	snapshot_t *snapshot, *lastSnapshot, *nextSnapshot;
	entityState_t *state;

	FreeSnapshotsOlderThanSequence( clientNum, sequence );

	for ( lastSnapshot = NULL, snapshot = clientSnapshots[clientNum]; snapshot; snapshot = nextSnapshot ) {
		nextSnapshot = snapshot->next;
		if ( snapshot->sequence == sequence ) {
			for ( state = snapshot->firstEntityState; state; state = state->next ) {
				if ( clientEntityStates[clientNum][state->entityNumber] ) {
					entityStateAllocator.Free( clientEntityStates[clientNum][state->entityNumber] );
				}
				clientEntityStates[clientNum][state->entityNumber] = state;
			}
			// ~512 bytes
			memcpy( clientPVS[clientNum], snapshot->pvs, sizeof( snapshot->pvs ) );
			if ( lastSnapshot ) {
				lastSnapshot->next = nextSnapshot;
			} else {
				clientSnapshots[clientNum] = nextSnapshot;
			}
			snapshotAllocator.Free( snapshot );
			return true;
		} else {
			lastSnapshot = snapshot;
		}
	}

	return false;
}

/*
================
idGameLocal::WriteGameStateToSnapshot
================
*/
void idGameLocal::WriteGameStateToSnapshot( idBitMsgDelta &msg ) const {
	int i;

	for( i = 0; i < MAX_GLOBAL_SHADER_PARMS; i++ ) {
		msg.WriteFloat( globalShaderParms[i] );
	}

	mpGame.WriteToSnapshot( msg );
}

/*
================
idGameLocal::ReadGameStateFromSnapshot
================
*/
void idGameLocal::ReadGameStateFromSnapshot( const idBitMsgDelta &msg ) {
	int i;

	for( i = 0; i < MAX_GLOBAL_SHADER_PARMS; i++ ) {
		globalShaderParms[i] = msg.ReadFloat();
	}

	mpGame.ReadFromSnapshot( msg );
}

/*
================
idGameLocal::ServerWriteSnapshot
Write a snapshot of the current game state for the given client.
================
*/
// RAVEN BEGIN
// jnewquist: Use dword array to match pvs array so we don't have endianness problems.
void idGameLocal::ServerWriteSnapshot( int clientNum, int sequence, idBitMsg &msg, dword *clientInPVS, int numPVSClients, int lastSnapshotFrame ) {
// RAVEN END
	int i, msgSize, msgWriteBit;
	idPlayer *player, *spectated = NULL;
	idEntity *ent;
	pvsHandle_t pvsHandle;
	idBitMsgDelta deltaMsg;
	snapshot_t *snapshot;
	entityState_t *base, *newBase;
	int numSourceAreas, sourceAreas[ idEntity::MAX_PVS_AREAS ];

	player = static_cast<idPlayer *>( entities[ clientNum ] );
	if ( !player ) {
		return;
	}
	if ( player->spectating && player->spectator != clientNum && entities[ player->spectator ] ) {
		spectated = static_cast< idPlayer * >( entities[ player->spectator ] );
	} else {
		spectated = player;
	}
	
	// free too old snapshots
	// ( that's a security, normal acking from server keeps a smaller backlog of snaps )
	FreeSnapshotsOlderThanSequence( clientNum, sequence - 64 );

	// allocate new snapshot
	snapshot = snapshotAllocator.Alloc();
	snapshot->sequence = sequence;
	snapshot->firstEntityState = NULL;
	snapshot->next = clientSnapshots[clientNum];
	clientSnapshots[clientNum] = snapshot;
	memset( snapshot->pvs, 0, sizeof( snapshot->pvs ) );

	// get PVS for this player
	// don't use PVSAreas for networking - PVSAreas depends on animations (and md5 bounds), which are not synchronized
	numSourceAreas = gameRenderWorld->BoundsInAreas( spectated->GetPlayerPhysics()->GetAbsBounds(), sourceAreas, idEntity::MAX_PVS_AREAS );
	pvsHandle = gameLocal.pvs.SetupCurrentPVS( sourceAreas, numSourceAreas, PVS_NORMAL );

#if ASYNC_WRITE_TAGS
	idRandom tagRandom;
	tagRandom.SetSeed( random.RandomInt() );
	msg.WriteLong( tagRandom.GetSeed() );
#endif
	
	// write unreliable messages
	unreliableMessages[ clientNum ].FlushTo( msg );

#if ASYNC_WRITE_TAGS
	msg.WriteLong( tagRandom.RandomInt() );
#endif

	// create the snapshot
	for( ent = spawnedEntities.Next(); ent != NULL; ent = ent->spawnNode.Next() ) {	

		// if the entity is not in the player PVS
		if ( !ent->PhysicsTeamInPVS( pvsHandle ) && ent->entityNumber != clientNum ) {
			continue;
		}

// RAVEN BEGIN
// ddynerman: don't transmit entities not in your clip world
		if ( ent->GetInstance() != player->GetInstance() ) {
			continue;
		}
// RAVEN END

		// if the entity is a map entity, mark it in PVS
		if ( isMapEntity[ ent->entityNumber ] ) {
			snapshot->pvs[ ent->entityNumber >> 5 ] |= 1 << ( ent->entityNumber & 31 );
		}

		// if that entity is not marked for network synchronization
		if ( !ent->fl.networkSync ) {
			continue;
		}

		// add the entity to the snapshot PVS
		snapshot->pvs[ ent->entityNumber >> 5 ] |= 1 << ( ent->entityNumber & 31 );

		// save the write state to which we can revert when the entity didn't change at all
		msg.SaveWriteState( msgSize, msgWriteBit );

		// write the entity to the snapshot
		msg.WriteBits( ent->entityNumber, GENTITYNUM_BITS );

		base = clientEntityStates[clientNum][ent->entityNumber];
		if ( base ) {
			base->state.BeginReading();
		}
		newBase = entityStateAllocator.Alloc();
		newBase->entityNumber = ent->entityNumber;
		newBase->state.Init( newBase->stateBuf, sizeof( newBase->stateBuf ) );
		newBase->state.BeginWriting();

		deltaMsg.InitWriting( base ? &base->state : NULL, &newBase->state, &msg );

		deltaMsg.WriteBits( spawnIds[ ent->entityNumber ], 32 - GENTITYNUM_BITS );
		assert( ent->entityDefNumber > 0 );
		deltaMsg.WriteBits( ent->entityDefNumber, entityDefBits );

		// write the class specific data to the snapshot
		ent->WriteToSnapshot( deltaMsg );

		if ( !deltaMsg.HasChanged() ) {
			msg.RestoreWriteState( msgSize, msgWriteBit );
			entityStateAllocator.Free( newBase );
		} else {
			newBase->next = snapshot->firstEntityState;
			snapshot->firstEntityState = newBase;

#if ASYNC_WRITE_TAGS
			msg.WriteLong( tagRandom.RandomInt() );
#endif
		}
	}

	msg.WriteBits( ENTITYNUM_NONE, GENTITYNUM_BITS );

	// write the PVS to the snapshot
#if ASYNC_WRITE_PVS
	for ( i = 0; i < idEntity::MAX_PVS_AREAS; i++ ) {
		if ( i < numSourceAreas ) {
			msg.WriteLong( sourceAreas[ i ] );
		} else {
			msg.WriteLong( 0 );
		}
	}
	gameLocal.pvs.WritePVS( pvsHandle, msg );
#endif
	for ( i = 0; i < ENTITY_PVS_SIZE; i++ ) {
		msg.WriteDeltaLong( clientPVS[clientNum][i], snapshot->pvs[i] );
	}

	// free the PVS
	pvs.FreeCurrentPVS( pvsHandle );

	// write the game and player state to the snapshot
	base = clientEntityStates[clientNum][ENTITYNUM_NONE];	// ENTITYNUM_NONE is used for the game and player state
	if ( base ) {
		base->state.BeginReading();
	}
	newBase = entityStateAllocator.Alloc();
	newBase->entityNumber = ENTITYNUM_NONE;
	newBase->next = snapshot->firstEntityState;
	snapshot->firstEntityState = newBase;
	newBase->state.Init( newBase->stateBuf, sizeof( newBase->stateBuf ) );
	newBase->state.BeginWriting();
	deltaMsg.InitWriting( base ? &base->state : NULL, &newBase->state, &msg );

	if ( player->spectating && player->spectator != player->entityNumber && entities[ player->spectator ] ) {
		assert( entities[ player->spectator ]->IsType( idPlayer::GetClassType() ) );
		deltaMsg.WriteBits( player->spectator, idMath::BitsForInteger( MAX_CLIENTS ) );
		static_cast< idPlayer * >( gameLocal.entities[ player->spectator ] )->WritePlayerStateToSnapshot( deltaMsg );
	} else {
		deltaMsg.WriteBits( player->entityNumber, idMath::BitsForInteger( MAX_CLIENTS ) );
		player->WritePlayerStateToSnapshot( deltaMsg );
	}
	WriteGameStateToSnapshot( deltaMsg );

	// copy the client PVS string
// RAVEN BEGIN
// JSinger: Changed to call optimized memcpy
// jnewquist: Use dword array to match pvs array so we don't have endianness problems.
	const int numDwords = ( numPVSClients + 31 ) >> 5;
	for ( i = 0; i < numDwords; i++ ) {
		clientInPVS[i] = snapshot->pvs[i];
	}
// RAVEN END
}

/*
===============
idGameLocal::ServerWriteServerDemoSnapshot
===============
*/
void idGameLocal::ServerWriteServerDemoSnapshot( int sequence, idBitMsg &msg, int lastSnapshotFrame ) {
	snapshot_t		*snapshot;
	int				i, msgSize, msgWriteBit;
	idEntity		*ent;
	entityState_t	*base, *newBase;
	idBitMsgDelta	deltaMsg;

	bool ret = ServerApplySnapshot( MAX_CLIENTS, sequence - 1 );
	ret = ret; // silence warning
	assert( ret || sequence == 1 );	// past the first snapshot of the server demo stream, there's always exactly one to clear

	snapshot = snapshotAllocator.Alloc();
	snapshot->sequence = sequence;
	snapshot->firstEntityState = NULL;
	snapshot->next = clientSnapshots[ MAX_CLIENTS ];
	clientSnapshots[ MAX_CLIENTS ] = snapshot;
	
	unreliableMessages[ MAX_CLIENTS ].FlushTo( msg );

	for ( ent = spawnedEntities.Next(); ent != NULL; ent = ent->spawnNode.Next() ) {

		if ( !ent->fl.networkSync ) {
			continue;
		}

		// only record instance 0 ( tourney games )
		if ( ent->GetInstance() != 0 ) {
			continue;
		}

		msg.SaveWriteState( msgSize, msgWriteBit );

		msg.WriteBits( ent->entityNumber, GENTITYNUM_BITS );

		base = clientEntityStates[ MAX_CLIENTS ][ ent->entityNumber ];
		if ( base ) {
			base->state.BeginReading();
		}

		newBase = entityStateAllocator.Alloc();
		newBase->entityNumber = ent->entityNumber;
		newBase->state.Init( newBase->stateBuf, sizeof( newBase->stateBuf ) );
		newBase->state.BeginWriting();

		deltaMsg.InitWriting( base ? &base->state : NULL, &newBase->state, &msg );

		deltaMsg.WriteBits( spawnIds[ ent->entityNumber ], 32 - GENTITYNUM_BITS );
		assert( ent->entityDefNumber > 0 );
		deltaMsg.WriteBits( ent->entityDefNumber, entityDefBits );

		ent->WriteToSnapshot( deltaMsg );

		if ( !deltaMsg.HasChanged() ) {
			msg.RestoreWriteState( msgSize, msgWriteBit );
			entityStateAllocator.Free( newBase );
		} else {
			newBase->next = snapshot->firstEntityState;
			snapshot->firstEntityState = newBase;
		}		
	}
	msg.WriteBits( ENTITYNUM_NONE, GENTITYNUM_BITS );

	// write player states and game states
	base = clientEntityStates[MAX_CLIENTS][ENTITYNUM_NONE];	// ENTITYNUM_NONE is used for the game and player state
	if ( base ) {
		base->state.BeginReading();
	}
	newBase = entityStateAllocator.Alloc();
	newBase->entityNumber = ENTITYNUM_NONE;
	newBase->next = snapshot->firstEntityState;
	snapshot->firstEntityState = newBase;
	newBase->state.Init( newBase->stateBuf, sizeof( newBase->stateBuf ) );
	newBase->state.BeginWriting();
	deltaMsg.InitWriting( base ? &base->state : NULL, &newBase->state, &msg );

	// all the players
	for ( i = 0; i < numClients; i++ ) {
		if ( entities[i] ) {
			assert( entities[i]->IsType( idPlayer::GetClassType() ) );
			idPlayer *p = static_cast< idPlayer * >( entities[i] );
			p->WritePlayerStateToSnapshot( deltaMsg );
		}
	}
	// and the game state
	WriteGameStateToSnapshot( deltaMsg );
	
}

/*
===============
idGameLocal::RepeaterEndSnapshots
===============
*/
void idGameLocal::RepeaterEndSnapshots( void ) {
}

/*
================
idGameLocal::ServerApplySnapshot
================
*/
bool idGameLocal::ServerApplySnapshot( int clientNum, int sequence ) {
	return ApplySnapshot( clientNum, sequence );
}

/*
================
idGameLocal::NetworkEventWarning
================
*/
void idGameLocal::NetworkEventWarning( const entityNetEvent_t *event, const char *fmt, ... ) {
	char buf[1024];
	int length = 0;
	va_list argptr;

	int entityNum	= event->spawnId & ( ( 1 << GENTITYNUM_BITS ) - 1 );
	int id			= event->spawnId >> GENTITYNUM_BITS;

	length += idStr::snPrintf( buf+length, sizeof(buf)-1-length, "event %d for entity %d %d: ", event->event, entityNum, id );
	va_start( argptr, fmt );
	length = idStr::vsnPrintf( buf+length, sizeof(buf)-1-length, fmt, argptr );
	va_end( argptr );
	idStr::Append( buf, sizeof(buf), "\n" );

	common->DWarning( buf );
}

/*
================
idGameLocal::ServerProcessEntityNetworkEventQueue
================
*/
void idGameLocal::ServerProcessEntityNetworkEventQueue( void ) {
	idEntity			*ent;
	entityNetEvent_t	*event;
	idBitMsg			eventMsg;

	while ( eventQueue.Start() ) {
		event = eventQueue.Start();

		if ( event->time > time ) {
			break;
		}

		idEntityPtr< idEntity > entPtr;
			
		if( !entPtr.SetSpawnId( event->spawnId ) ) {
			NetworkEventWarning( event, "Entity does not exist any longer, or has not been spawned yet." );
		} else {
			ent = entPtr.GetEntity();
			assert( ent );

			eventMsg.Init( event->paramsBuf, sizeof( event->paramsBuf ) );
			eventMsg.SetSize( event->paramsSize );
			eventMsg.BeginReading();
			if ( !ent->ServerReceiveEvent( event->event, event->time, eventMsg ) ) {
				NetworkEventWarning( event, "unknown event" );
			}
		}

#ifdef _DEBUG
		entityNetEvent_t* freedEvent = eventQueue.Dequeue();
		assert( freedEvent == event );
#else
		eventQueue.Dequeue();
#endif
		eventQueue.Free( event );
	}
}

/*
================
idGameLocal::ServerSendChatMessage
================
*/
void idGameLocal::ServerSendChatMessage( int to, const char *name, const char *text, const char *parm ) {
	/*idBitMsg outMsg;
	byte msgBuf[ MAX_GAME_MESSAGE_SIZE ];

	outMsg.Init( msgBuf, sizeof( msgBuf ) );
	outMsg.BeginWriting();
	outMsg.WriteByte( GAME_RELIABLE_MESSAGE_CHAT );
	outMsg.WriteString( name );
	outMsg.WriteString( text );
	outMsg.WriteString( parm );
	networkSystem->ServerSendReliableMessage( to, outMsg );

	if ( to == -1 || to == localClientNum ) {
		idStr temp = va( "%s%s", common->GetLocalizedString( text ), parm );
		mpGame.AddChatLine( "%s^0: %s", name, temp.c_str() );
	}*/

	// 3j_todo
}

/*
================
idGameLocal::ServerProcessReliableMessage
================
*/
void idGameLocal::ServerProcessReliableMessage( int clientNum, const idBitMsg &msg ) {
	int id;

	id = msg.ReadByte();
	switch( id ) {
		case GAME_RELIABLE_MESSAGE_DISGUISE: {
			disguiseType_t type = (disguiseType_t)(msg.ReadBits( 2 ) );
			int num = msg.ReadBits( ASYNC_CLASS_BITS );
			tfGame.DisguiseRequest( clientNum, type, num );
			break;
		}
		case GAME_RELIABLE_MESSAGE_TFCHAT: {
			char text[128];
			chatTargetType_t target = (chatTargetType_t)msg.ReadBits( 2 );
			msg.ReadString( text, sizeof( text ) );
			int shaderIndex = -1;
			if ( msg.ReadBits( 1 ) ) {
				shaderIndex = msg.ReadLong();
			}
			mpGame.ProcessChatMessage( clientNum, target, text, shaderIndex );
			break;
		}
		case GAME_RELIABLE_MESSAGE_VCHAT: {
			int index = msg.ReadLong();
			bool team = msg.ReadBits( 1 ) != 0;
			mpGame.ProcessVoiceChat( clientNum, team, index );
			break;
		}
		case GAME_RELIABLE_MESSAGE_KILL: {
			mpGame.WantKilled( clientNum );
			break;
		}

#if 0
		// uncomment this if you want to track when players are in a menu
		case GAME_RELIABLE_MESSAGE_MENU: {
			bool menuUp = ( msg.ReadBits( 1 ) != 0 );
			break;
		}
#endif
		case GAME_RELIABLE_MESSAGE_EVENT: {
			entityNetEvent_t *event;

			// allocate new event
			event = eventQueue.Alloc();
			eventQueue.Enqueue( event, idEventQueue::OUTOFORDER_DROP );

			event->spawnId = msg.ReadBits( 32 );
			event->event = msg.ReadByte();
			event->time = msg.ReadLong();

			event->paramsSize = msg.ReadBits( idMath::BitsForInteger( MAX_EVENT_PARAM_SIZE ) );
			if ( event->paramsSize ) {
				if ( event->paramsSize > MAX_EVENT_PARAM_SIZE ) {
					NetworkEventWarning( event, "invalid param size" );
					return;
				}
				msg.ReadByteAlign();
				msg.ReadData( event->paramsBuf, event->paramsSize );
			}
			break;
		}


#ifdef _USE_VOICECHAT
// jscott: voice comms
		case GAME_RELIABLE_MESSAGE_VOICEDATA_CLIENT:
		case GAME_RELIABLE_MESSAGE_VOICEDATA_CLIENT_ECHO:
		case GAME_RELIABLE_MESSAGE_VOICEDATA_CLIENT_TEST:
		case GAME_RELIABLE_MESSAGE_VOICEDATA_CLIENT_ECHO_TEST: {
			mpGame.ReceiveAndForwardVoiceData( clientNum, msg, id - GAME_RELIABLE_MESSAGE_VOICEDATA_CLIENT );
			break;
		}
#endif
// shouchard:  voice chat
		case GAME_RELIABLE_MESSAGE_VOICECHAT_MUTING: {
			int clientDest = msg.ReadByte();
			bool mute = ( 0 != msg.ReadByte() );
			mpGame.ServerHandleVoiceMuting( clientNum, clientDest, mute );
			break;
		}
// shouchard:  server admin
		case GAME_RELIABLE_MESSAGE_SERVER_ADMIN: {
			int commandType = msg.ReadByte();
			int clientNum = msg.ReadByte();
			if ( SERVER_ADMIN_REMOVE_BAN == commandType ) {
				mpGame.HandleServerAdminRemoveBan( "" );
			} else if ( SERVER_ADMIN_KICK == commandType ) {
				mpGame.HandleServerAdminKickPlayer( clientNum );
			} else if ( SERVER_ADMIN_FORCE_SWITCH == commandType ) {
				mpGame.HandleServerAdminForceTeamSwitch( clientNum );
			} else {
				Warning( "Server admin packet with bad type %d", commandType );
			}
			break;
		}
// mekberg: get ban list for server
		case GAME_RELIABLE_MESSAGE_GETADMINBANLIST: {
			ServerSendBanList( clientNum );
			break;
		}

		// <q4f>
		case GAME_RELIABLE_MESSAGE_CHANGECLASS:	{
			int classNum = msg.ReadBits( ASYNC_CLASS_BITS );
			if ( !IS_VALID_CLASS_NUM( classNum ) )
			{
				gameLocal.Warning( "ServerProcess: classNum %d invalid", classNum );
				break;
			}
			tfGame.ChangeClassRequest( clientNum, classNum );
			break;
		}
		case GAME_RELIABLE_MESSAGE_CHANGETEAM: {
			int teamNum = msg.ReadBits( ASYNC_TEAM_BITS );
			mpGame.JoinTeam( clientNum, teamNum );
			break;
		}
	    case GAME_RELIABLE_MESSAGE_SPECTATE: {
			// 0 -> TEAM_COUNT is the team, or TEAM_COUNT means auto, or TEAM_COUNT + 1 means spec
			int teamNum = msg.ReadBits( ASYNC_TEAM_BITS );
			mpGame.JoinSpectators( clientNum, teamNum );
			break;
		}
		case GAME_RELIABLE_MESSAGE_GRENADE: {		// first bit is which grenade, 2nd is throw or now

			idPlayer* player = static_cast<idPlayer*>(gameLocal.entities[clientNum]);

			int grenadeNum = msg.ReadBits( 1 ) + 1;
			bool throwGren = msg.ReadBits( 1 ) == 1;

			if ( player && !player->spectating && player->health >= 0 ) {
				if ( throwGren ) {
					if ( player->heldGrenade.grenadeNum > 0 ) {
						player->heldGrenade.playerWantsThrow = true;
					}
				}
				else {
					player->PrimeGrenade( grenadeNum );
				}
			}
			break;
		}
		case GAME_RELIABLE_MESSAGE_DROPAMMO: {
			int ammoIndex = msg.ReadBits( ASYNC_PLAYER_INV_AMMOTYPE_BITS );
			int drop = -1;
			int save = 0;
			if ( msg.ReadBits( 1 ) ) {
				drop = msg.ReadBits( ASYNC_PLAYER_INV_AMMO_BITS );

				if ( msg.ReadBits( 1 ) ) {
					save = msg.ReadBits( ASYNC_PLAYER_INV_AMMO_BITS );
				}
			}

			idPlayer* player = static_cast<idPlayer*>(gameLocal.entities[clientNum]);
			if ( player ) {
				player->DropAmmo( player->inventory.AmmoClassForAmmoIndex( ammoIndex ), drop, save );
			}
			break;
		}
		case GAME_RELIABLE_MESSAGE_DROPFLAG: {
			idPlayer* player = static_cast<idPlayer*>(gameLocal.entities[clientNum]);
			if ( player ) {
				player->DropItems( false, TFSTATE_ACTIVE );
			}
			break;
		}
		case GAME_RELIABLE_MESSAGE_PLAYERSTATS: {
			tfStatManager->ClientRequestsStats( clientNum, msg );
			break;
		}
		case GAME_RELIABLE_MESSAGE_BUILD: {
			ENTDEF def = static_cast<ENTDEF>(gameLocal.ReadDecl( msg, DECL_ENTITYDEF ));
			idVec3 pos;
			pos.x = msg.ReadFloat();
			pos.y = msg.ReadFloat();
			pos.z = msg.ReadFloat();
			float rotation = msg.ReadFloat();
			tfGame.BuildRequest( def->GetName(), clientNum, NULL, &pos, rotation );
			break;
		}
		case GAME_RELIABLE_MESSAGE_ROTATESENTRY: {
			int degrees = msg.ReadBits( -10 );
			idPlayer* p = GET_PLAYER( clientNum );
			if ( p && p->sentryGun ) {
				p->sentryGun->Rotate( degrees );
			}
			break;
		}
		case GAME_RELIABLE_MESSAGE_DETPACK: {
			float num = msg.ReadFloat();
			idDict dict;
			dict.Set( "chargetime", va( "%g", num ) );
			tfGame.BuildRequest( "q4f_detpak", clientNum, &dict );
			break;
		}
		// </q4f>			DONT FORGET BREAKS

		// JARED IF YOU FORGET ONE MORE FUCKING BREAK I'll BREAK YOUR FUCKING SHIN

		default: {
			Warning( "Unknown client->server reliable message: %d", id );
			break;
		}
	}
}

/*
================
idGameLocal::ClientShowSnapshot
================
*/
void idGameLocal::ClientShowSnapshot( int clientNum ) const {
	int baseBits;
	idEntity *ent;
	idPlayer *player;
	idMat3 viewAxis;
	idBounds viewBounds;
	entityState_t *base;

	if ( !net_clientShowSnapshot.GetInteger() ) {
		return;
	}

	player = static_cast<idPlayer *>( entities[clientNum] );
	if ( !player ) {
		return;
	}

	viewAxis = player->viewAngles.ToMat3();
	viewBounds = player->GetPhysics()->GetAbsBounds().Expand( net_clientShowSnapshotRadius.GetFloat() );

	for( ent = snapshotEntities.Next(); ent != NULL; ent = ent->snapshotNode.Next() ) {

		if ( net_clientShowSnapshot.GetInteger() == 1 && ent->snapshotBits == 0 ) {
			continue;
		}

		const idBounds &entBounds = ent->GetPhysics()->GetAbsBounds();

		if ( !entBounds.IntersectsBounds( viewBounds ) ) {
			continue;
		}

		base = clientEntityStates[clientNum][ent->entityNumber];
		if ( base ) {
			baseBits = base->state.GetNumBitsWritten();
		} else {
			baseBits = 0;
		}

		if ( net_clientShowSnapshot.GetInteger() == 2 && baseBits == 0 ) {
			continue;
		}

		gameRenderWorld->DebugBounds( colorGreen, entBounds );
		gameRenderWorld->DrawText( va( "%d: %s (%d,%d bytes of %d,%d)\n", ent->entityNumber,
						ent->name.c_str(), ent->snapshotBits >> 3, ent->snapshotBits & 7, baseBits >> 3, baseBits & 7 ),
							entBounds.GetCenter(), 0.1f, colorWhite, viewAxis, 1 );
	}
}

/*
================
idGameLocal::UpdateLagometer
================
*/
void idGameLocal::UpdateLagometer( int aheadOfServer, int dupeUsercmds ) {
		int i, j, ahead;
		for ( i = 0; i < LAGO_HEIGHT; i++ ) {
			memmove( (byte *)lagometer + LAGO_WIDTH * 4 * i, (byte *)lagometer + LAGO_WIDTH * 4 * i + 4, ( LAGO_WIDTH - 1 ) * 4 );
		}
		j = LAGO_WIDTH - 1;
		for ( i = 0; i < LAGO_HEIGHT; i++ ) {
			lagometer[i][j][0] = lagometer[i][j][1] = lagometer[i][j][2] = lagometer[i][j][3] = 0;
		}
		ahead = idMath::Rint( (float)aheadOfServer / 16.0f );
		if ( ahead >= 0 ) {
			for ( i = 2 * Max( 0, 5 - ahead ); i < 2 * 5; i++ ) {
				lagometer[i][j][1] = 255;
				lagometer[i][j][3] = 255;
			}
		} else {
			for ( i = 2 * 5; i < 2 * ( 5 + Min( 10, -ahead ) ); i++ ) {
				lagometer[i][j][0] = 255;
				lagometer[i][j][1] = 255;
				lagometer[i][j][3] = 255;
			}
		}
		for ( i = LAGO_HEIGHT - 2 * Min( 6, dupeUsercmds ); i < LAGO_HEIGHT; i++ ) {
			lagometer[i][j][0] = 255;
			lagometer[i][j][1] = 255;
			lagometer[i][j][3] = 255;
		}
}

/*
================
idGameLocal::ClientReadSnapshot
================
*/
void idGameLocal::ClientReadSnapshot( int clientNum, int sequence, const int gameFrame, const int gameTime, const int dupeUsercmds, const int aheadOfServer, const idBitMsg &msg ) {
	int						i, entityDefNumber, numBitsRead;

	idEntity		*ent;
	idPlayer		*player, *spectated;
	pvsHandle_t		pvsHandle;
	idDict			args;
	idBitMsgDelta	deltaMsg;
	snapshot_t		*snapshot;
	entityState_t	*base, *newBase;
	int				spawnId;
	int				numSourceAreas, sourceAreas[ idEntity::MAX_PVS_AREAS ];

	const idDeclEntityDef	*decl;

	if ( net_clientLagOMeter.GetBool() && renderSystem && !IsServerDemo() ) {
		UpdateLagometer( aheadOfServer, dupeUsercmds );
		if ( !renderSystem->UploadImage( LAGO_IMAGE, (byte *)lagometer, LAGO_IMG_WIDTH, LAGO_IMG_HEIGHT ) ) {
			common->Printf( "lagometer: UploadImage failed. turning off net_clientLagOMeter\n" );
			net_clientLagOMeter.SetBool( false );
		}
	}

	InitLocalClient( clientNum );

	gameRenderWorld->DebugClear( time );

	// update the game time
	framenum = gameFrame;
	time = gameTime;

// bdube: use GetMSec access rather than USERCMD_TIME
	previousTime = time - GetMSec();


	// so that StartSound/StopSound doesn't risk skipping
	isNewFrame = true;

	// clear the snapshot entity list
	snapshotEntities.Clear();

	// allocate new snapshot
	snapshot = snapshotAllocator.Alloc();
	snapshot->sequence = sequence;
	snapshot->firstEntityState = NULL;
	snapshot->next = clientSnapshots[clientNum];
	clientSnapshots[clientNum] = snapshot;

#if ASYNC_WRITE_TAGS
	idRandom tagRandom;
	tagRandom.SetSeed( msg.ReadLong() );
#endif

	ClientReadUnreliableMessages( msg );

#if ASYNC_WRITE_TAGS
	if ( msg.ReadLong() != tagRandom.RandomInt() ) {
		Error( "error after read unreliable" );
	}
#endif

	// read all entities from the snapshot
	for ( i = msg.ReadBits( GENTITYNUM_BITS ); i != ENTITYNUM_NONE; i = msg.ReadBits( GENTITYNUM_BITS ) ) {
		base = clientEntityStates[clientNum][i];
		if ( base ) {
			base->state.BeginReading();
		}
		newBase = entityStateAllocator.Alloc();
		newBase->entityNumber = i;
		newBase->next = snapshot->firstEntityState;
		snapshot->firstEntityState = newBase;
		newBase->state.Init( newBase->stateBuf, sizeof( newBase->stateBuf ) );
		newBase->state.BeginWriting();

		numBitsRead = msg.GetNumBitsRead();

		deltaMsg.InitReading( base ? &base->state : NULL, &newBase->state, &msg );

		spawnId = deltaMsg.ReadBits( 32 - GENTITYNUM_BITS );
		entityDefNumber = deltaMsg.ReadBits( entityDefBits );

		ent = entities[i];

		// if there is no entity or an entity of the wrong type
		if ( !ent || ent->entityDefNumber != entityDefNumber || spawnId != spawnIds[ i ] ) {

			if ( i < MAX_CLIENTS && ent ) {
				// SPAWN_PLAYER should be taking care of spawning the entity with the right spawnId
				common->Warning( "ClientReadSnapshot: recycling client entity %d Reason:\n", i );
				if ( !ent ) {
					common->Warning( "entity is null." );
				}
				else if ( ent->entityDefNumber != entityDefNumber ) {
					common->Warning( "def # is different" );
				}
				else if ( spawnId != spawnIds[ i ] ) {
					common->Warning( "spawn ids are different - old=%d, new=%d", spawnIds[ i ], spawnId );
				}
			}

			delete ent;

			spawnCount = spawnId;

			args.Clear();
			args.SetInt( "spawn_entnum", i );
			args.Set( "name", va( "entity%d", i ) );

			if ( entityDefNumber >= 0 ) {
				if ( entityDefNumber >= declManager->GetNumDecls( DECL_ENTITYDEF ) ) {
					Error( "server has %d entityDefs instead of %d", entityDefNumber, declManager->GetNumDecls( DECL_ENTITYDEF ) );
				}
				decl = static_cast< const idDeclEntityDef * >( declManager->DeclByIndex( DECL_ENTITYDEF, entityDefNumber, false ) );
				assert( decl && decl->GetType() == DECL_ENTITYDEF );
				args.Set( "classname", decl->GetName() );
				if ( !SpawnEntityDef( args, &ent ) || !entities[i] ) {
					Error( "Failed to spawn entity with classname '%s' of type '%s'", decl->GetName(), decl->dict.GetString( "spawnclass" ) );
				}
			} else {
				// we no longer support spawning entities by type num only. we would only hit this when playing 1.2 demos for backward compatibility
				Error( "ClientReadSnapShot - entityDefNumber < 0" );
			}
			if ( i < MAX_CLIENTS && i >= numClients ) {
				numClients = i + 1;
			}
		}

		// add the entity to the snapshot list
		ent->snapshotNode.AddToEnd( snapshotEntities );
		ent->snapshotSequence = sequence;


// bdube: stale network entities
		// Ensure the clipmodel is relinked when transitioning from state
		if ( ent->fl.networkStale ) {
			ent->GetPhysics()->LinkClip();
		}


		// read the class specific data from the snapshot
		ent->ReadFromSnapshot( deltaMsg );

		// once we read new snapshot data, unstale the ent
		if( ent->fl.networkStale ) {
			ent->ClientUnstale();
			ent->fl.networkStale = false;
		}
		ent->snapshotBits = msg.GetNumBitsRead() - numBitsRead;

#if ASYNC_WRITE_TAGS
		if ( msg.ReadLong() != tagRandom.RandomInt() ) {
			//cmdSystem->BufferCommandText( CMD_EXEC_NOW, "writeGameState" );
			assert( entityDefNumber >= 0 );
			assert( entityDefNumber < declManager->GetNumDecls( DECL_ENTITYDEF ) );
			const char * classname = declManager->DeclByIndex( DECL_ENTITYDEF, entityDefNumber, false )->GetName();
			Error( "write to and read from snapshot out of sync for classname '%s'\n", classname );
		}
#endif
	}

	player = static_cast<idPlayer *>( entities[clientNum] );
	if ( !player ) {
		return;
	}

	if ( player->spectating && player->spectator != clientNum && entities[ player->spectator ] ) {
		spectated = static_cast< idPlayer * >( entities[ player->spectator ] );
	} else {
		spectated = player;
	}

	// get PVS for this player
	// don't use PVSAreas for networking - PVSAreas depends on animations (and md5 bounds), which are not synchronized
	numSourceAreas = gameRenderWorld->BoundsInAreas( spectated->GetPlayerPhysics()->GetAbsBounds(), sourceAreas, idEntity::MAX_PVS_AREAS );
	pvsHandle = gameLocal.pvs.SetupCurrentPVS( sourceAreas, numSourceAreas, PVS_NORMAL );

	// read the PVS from the snapshot
#if ASYNC_WRITE_PVS
	int serverPVS[idEntity::MAX_PVS_AREAS];
	i = numSourceAreas;
	while ( i < idEntity::MAX_PVS_AREAS ) {
		sourceAreas[ i++ ] = 0;
	}
	for ( i = 0; i < idEntity::MAX_PVS_AREAS; i++ ) {
		serverPVS[ i ] = msg.ReadLong();
	}
	if ( memcmp( sourceAreas, serverPVS, idEntity::MAX_PVS_AREAS * sizeof( int ) ) ) {
		common->Warning( "client PVS areas != server PVS areas, sequence 0x%x", sequence );
		for ( i = 0; i < idEntity::MAX_PVS_AREAS; i++ ) {
			common->DPrintf( "%3d ", sourceAreas[ i ] );
		}
		common->DPrintf( "\n" );
		for ( i = 0; i < idEntity::MAX_PVS_AREAS; i++ ) {
			common->DPrintf( "%3d ", serverPVS[ i ] );
		}
		common->DPrintf( "\n" );
	}
	gameLocal.pvs.ReadPVS( pvsHandle, msg );
#endif
	for ( i = 0; i < ENTITY_PVS_SIZE; i++ ) {
		snapshot->pvs[i] = msg.ReadDeltaLong( clientPVS[clientNum][i] );
	}

// ddynerman: performance profiling
	net_entsInSnapshot += snapshotEntities.Num();
	net_snapshotSize += msg.GetSize();

	// add entities in the PVS that haven't changed since the last applied snapshot
	idEntity *nextSpawnedEnt;
	for( ent = spawnedEntities.Next(); ent != NULL; ent = nextSpawnedEnt ) {
		nextSpawnedEnt = ent->spawnNode.Next();

		// if the entity is already in the snapshot
		if ( ent->snapshotSequence == sequence ) {
			continue;
		}

		// if the entity is not in the snapshot PVS
		if ( !( snapshot->pvs[ent->entityNumber >> 5] & ( 1 << ( ent->entityNumber & 31 ) ) ) ) {

			if ( !ent->fl.networkSync ) {
				// don't do stale / unstale on entities that are not marked network sync
				continue;
			}

			if ( ent->PhysicsTeamInPVS( pvsHandle ) ) {
				if ( ent->entityNumber >= MAX_CLIENTS && isMapEntity[ ent->entityNumber ] ) {
					// server says it's not in PVS, client says it's in PVS
					// if that happens on map entities, most likely something is wrong
					// I can see that moving pieces along several PVS could be a legit situation though
					// this is a band aid, which means something is not done right elsewhere
					if ( net_warnStale.GetInteger() > 1 || ( net_warnStale.GetInteger() == 1 && !ent->fl.networkStale ) ) {
						common->Warning( "client thinks map entity 0x%x (%s) is stale, sequence 0x%x", ent->entityNumber, ent->name.c_str(), sequence );
					}
				}

// bdube: hide while not in snapshot
				if ( !ent->fl.networkStale ) {
					if ( ent->ClientStale() ) {
						delete ent;
						ent = NULL;
					} else {
						ent->fl.networkStale = true;
					}
				}

			} else {
				if ( !ent->fl.networkStale ) {
					if ( ent->ClientStale() ) {
						delete ent;
						ent = NULL;
					} else {
						ent->fl.networkStale = true;
					}
				}
			}


			continue;
		}

		// add the entity to the snapshot list
		ent->snapshotNode.AddToEnd( snapshotEntities );
		ent->snapshotSequence = sequence;
		ent->snapshotBits = 0;


// bdube: hide while not in snapshot
		// Ensure the clipmodel is relinked when transitioning from state
		if ( ent->fl.networkStale ) {
			ent->GetPhysics()->LinkClip();
		}


		base = clientEntityStates[clientNum][ent->entityNumber];
		if ( !base ) {
			// entity has probably fl.networkSync set to false
			// non netsynced map entities go in and out of PVS, and may need stale/unstale calls
			if ( ent->fl.networkStale ) {
				ent->ClientUnstale();
				ent->fl.networkStale = false;
			}
			continue;
		}

		if ( !ent->fl.networkSync ) {
			// this is not supposed to happen
			// it did however, when restarting a map with a different inhibit of entities caused entity numbers to be laid differently
			// an idLight would occupy the entity number of an idItem for instance, and although it's not network-synced ( static level light ),
			// the presence of a base would cause the system to think that it is and corrupt things
			// we changed the map population so the entity numbers are kept the same no matter how things are inhibited
			// this code is left as a fall-through fixup / sanity type of thing
			// if this still happens, it's likely "client thinks map entity is stale" is happening as well, and we're still at risk of corruption
			Warning( "ClientReadSnapshot: entity %d of type %s is not networkSync and has a snapshot base", ent->entityNumber, ent->GetType()->classname );
			entityStateAllocator.Free( clientEntityStates[clientNum][ent->entityNumber] );
			clientEntityStates[clientNum][ent->entityNumber] = NULL;
			continue;
		}

		base->state.BeginReading();

		deltaMsg.InitReading( &base->state, NULL, (const idBitMsg *)NULL );
		spawnId = deltaMsg.ReadBits( 32 - GENTITYNUM_BITS );
		entityDefNumber = deltaMsg.ReadBits( entityDefBits );

		// read the class specific data from the base state
		ent->ReadFromSnapshot( deltaMsg );

		// after snapshot read, notify client of unstale
		if( ent->fl.networkStale ) {
			ent->ClientUnstale();
			ent->fl.networkStale = false;
		}
	}


// ddynerman: add the ambient lights to the snapshot entities
	for( int i = 0; i < ambientLights.Num(); i++ ) {
		ambientLights[ i ]->snapshotNode.AddToEnd( snapshotEntities );
		ambientLights[ i ]->fl.networkStale = false;
	}
	for( int i = 0; i < waterEnts.Num(); i++ ) {
		waterEnts[ i ]->snapshotNode.AddToEnd( snapshotEntities );
		waterEnts[ i ]->fl.networkStale = false;
	}
//	entities[SINGLE_LIGHT]->snapshotNode.AddToEnd( snapshotEntities );
//	entities[SINGLE_LIGHT]->fl.networkStale = false;
	singleLight->snapshotNode.AddToEnd( snapshotEntities );
	singleLight->fl.networkStale = false;


	// free the PVS
	pvs.FreeCurrentPVS( pvsHandle );

	// read the game and player state from the snapshot
	base = clientEntityStates[clientNum][ENTITYNUM_NONE];	// ENTITYNUM_NONE is used for the game and player state
	if ( base ) {
		base->state.BeginReading();
	}
	newBase = entityStateAllocator.Alloc();
	newBase->entityNumber = ENTITYNUM_NONE;
	newBase->next = snapshot->firstEntityState;
	snapshot->firstEntityState = newBase;
	newBase->state.Init( newBase->stateBuf, sizeof( newBase->stateBuf ) );
	newBase->state.BeginWriting();
	deltaMsg.InitReading( base ? &base->state : NULL, &newBase->state, &msg );

	#if ASYNC_WRITE_TAGS
		int check = deltaMsg.ReadLong();
	#endif
		
	int targetPlayer = deltaMsg.ReadBits( ASYNC_MAX_CLIENT_BITS );
	if ( entities[ targetPlayer ] ) {
		static_cast< idPlayer* >( entities[ targetPlayer ] )->ReadPlayerStateFromSnapshot( deltaMsg );
	} else {
		player->ReadPlayerStateFromSnapshot( deltaMsg );
	}

	#if ASYNC_WRITE_TAGS
	if ( check != deltaMsg.ReadLong() ) {
		gameLocal.Error( "player state out of sync with snapshot." );
	}
	#endif

	ReadGameStateFromSnapshot( deltaMsg );

	// visualize the snapshot
	ClientShowSnapshot( clientNum );

	// process entity events
	ClientProcessEntityNetworkEventQueue();
}


/*
===============
idGameLocal::ClientReadServerDemoSnapshot

server demos use a slightly different snapshot format
mostly, we don't need to transmit any PVS visibility information, as we transmit the whole entity activity
plus, we read that data to the virtual 'seeing it all' MAX_CLIENTS client

===============
*/
void idGameLocal::ClientReadServerDemoSnapshot( int sequence, const int gameFrame, const int gameTime, const idBitMsg &msg ) {
	int				i;
	snapshot_t		*snapshot;
	entityState_t	*base, *newBase;
	idBitMsgDelta	deltaMsg;
	int				numBitsRead, spawnId, entityDefNumber;
	idEntity		*ent;
	idDict			args;
	ENTDEF			decl;

	bool ret = ClientApplySnapshot( MAX_CLIENTS, sequence - 1 );
	assert( ret || sequence == 1 ); // past the first snapshot of the server demo stream, there's always exactly one to clear

	gameRenderWorld->DebugClear( time );
	
	framenum = gameFrame;
	time = gameTime;
	previousTime = time - GetMSec();
	
	isNewFrame = true;

	snapshotEntities.Clear();
	
	snapshot = snapshotAllocator.Alloc();
	snapshot->sequence = sequence;
	snapshot->firstEntityState = NULL;
	snapshot->next = clientSnapshots[ MAX_CLIENTS ];
	clientSnapshots[ MAX_CLIENTS ] = snapshot;

	ClientReadUnreliableMessages( msg );

	for ( i = msg.ReadBits( GENTITYNUM_BITS ); i != ENTITYNUM_NONE; i = msg.ReadBits( GENTITYNUM_BITS ) ) {

		base = clientEntityStates[ MAX_CLIENTS ][i];
		if ( base ) {
			base->state.BeginReading();
		}
		newBase = entityStateAllocator.Alloc();
		newBase->entityNumber = i;
		newBase->next = snapshot->firstEntityState;
		snapshot->firstEntityState = newBase;
		newBase->state.Init( newBase->stateBuf, sizeof( newBase->stateBuf ) );
		newBase->state.BeginWriting();

		numBitsRead = msg.GetNumBitsRead();

		deltaMsg.InitReading( base ? &base->state : NULL, &newBase->state, &msg );

		spawnId = deltaMsg.ReadBits( 32 - GENTITYNUM_BITS );
		entityDefNumber = deltaMsg.ReadBits( entityDefBits );

		ent = entities[i];

		// if there is no entity or an entity of the wrong type
		if ( !ent || ent->entityDefNumber != entityDefNumber || spawnId != spawnIds[ i ] ) {

			if ( i < MAX_CLIENTS && ent ) {
				// SpawnPlayer should be taking care of spawning the entity with the right spawnId
				common->Warning( "ClientReadServerDemoSnapshot: recycling client entity %d\n", i );
			}

			delete ent;

			spawnCount = spawnId;

			args.Clear();
			args.SetInt( "spawn_entnum", i );
			args.Set( "name", va( "entity%d", i ) );

			
			if ( entityDefNumber >= 0 ) {
				if ( entityDefNumber >= declManager->GetNumDecls( DECL_ENTITYDEF ) ) {
					Error( "server has %d entityDefs instead of %d", entityDefNumber, declManager->GetNumDecls( DECL_ENTITYDEF ) );
				}
				decl = static_cast< const idDeclEntityDef * >( declManager->DeclByIndex( DECL_ENTITYDEF, entityDefNumber, false ) );
				assert( decl && decl->GetType() == DECL_ENTITYDEF );
				args.Set( "classname", decl->GetName() );
				if ( !SpawnEntityDef( args, &ent ) || !entities[i] ) {
					Error( "Failed to spawn entity with classname '%s' of type '%s'", decl->GetName(), decl->dict.GetString( "spawnclass" ) );
				}
			} else {
				Error( "ClientReadServerDemoSnapshot: entityDefNumber < 0" );
			}
			if ( i < MAX_CLIENTS && i >= numClients ) {
				numClients = i + 1;
			}
		}

		// add the entity to the snapshot list
		ent->snapshotNode.AddToEnd( snapshotEntities );
		ent->snapshotSequence = sequence;


// bdube: stale network entities
		// Ensure the clipmodel is relinked when transitioning from state
		if ( ent->fl.networkStale ) {
			ent->GetPhysics()->LinkClip();
		}


		// read the class specific data from the snapshot
		ent->ReadFromSnapshot( deltaMsg );

		// once we read new snapshot data, unstale the ent
		if( ent->fl.networkStale ) {
			ent->ClientUnstale();
			ent->fl.networkStale = false;
		}
		ent->snapshotBits = msg.GetNumBitsRead() - numBitsRead;

	}

	// add entities that haven't changed since the last applied snapshot
	idEntity *nextSpawnedEnt;
	for( ent = spawnedEntities.Next(); ent != NULL; ent = nextSpawnedEnt ) {
		nextSpawnedEnt = ent->spawnNode.Next();

		// if the entity is already in the snapshot
		if ( ent->snapshotSequence == sequence ) {
			continue;
		}

		// add the entity to the snapshot list
		ent->snapshotNode.AddToEnd( snapshotEntities );
		ent->snapshotSequence = sequence;
		ent->snapshotBits = 0;

		// Ensure the clipmodel is relinked when transitioning from stale
		if ( ent->fl.networkStale ) {
			ent->GetPhysics()->LinkClip();
		}

		base = clientEntityStates[ MAX_CLIENTS ][ ent->entityNumber ];
		if ( !base ) {
			// entity has probably fl.networkSync set to false
			// non netsynced map entities go in and out of PVS, and may need stale/unstale calls
			if ( ent->fl.networkStale ) {
				ent->ClientUnstale();
				ent->fl.networkStale = false;
			}
			continue;
		}

		base->state.BeginReading();

		deltaMsg.InitReading( &base->state, NULL, (const idBitMsg *)NULL );
		spawnId = deltaMsg.ReadBits( 32 - GENTITYNUM_BITS );
		entityDefNumber = deltaMsg.ReadBits( entityDefBits );

		// if the entity is not the right type
		if ( ent->entityDefNumber != entityDefNumber ) {
			// should never happen
			common->DWarning( "entity '%s' is not the right type ( 0x%x, expected 0x%x )", ent->GetName(), ent->entityDefNumber, entityDefNumber );
			continue;
		}

		// read the class specific data from the base state
		ent->ReadFromSnapshot( deltaMsg );

		// after snapshot read, notify client of unstale
		if( ent->fl.networkStale ) {
			// FIXME: does this happen ( in a server demo replay? )
			assert( false );
			ent->ClientUnstale();
			ent->fl.networkStale = false;
		}
	}


// ddynerman: add the ambient lights to the snapshot entities
	for( i = 0; i < ambientLights.Num(); i++ ) {
		ambientLights[ i ]->snapshotNode.AddToEnd( snapshotEntities );
		ambientLights[ i ]->fl.networkStale = false;
	}
	for( i = 0; i < waterEnts.Num(); i++ ) {
		waterEnts[ i ]->snapshotNode.AddToEnd( snapshotEntities );
		waterEnts[ i ]->fl.networkStale = false;
	}
//	entities[SINGLE_LIGHT]->snapshotNode.AddToEnd( snapshotEntities );
//	entities[SINGLE_LIGHT]->fl.networkStale = false;
	singleLight->snapshotNode.AddToEnd( snapshotEntities );
	singleLight->fl.networkStale = false;


	// visualize the snapshot
	// FIXME
	//	ClientShowSnapshot( MAX_CLIENTS );

	// read the game and player states
	base = clientEntityStates[MAX_CLIENTS][ENTITYNUM_NONE];	// ENTITYNUM_NONE is used for the game and player state
	if ( base ) {
		base->state.BeginReading();
	}
	newBase = entityStateAllocator.Alloc();
	newBase->entityNumber = ENTITYNUM_NONE;
	newBase->next = snapshot->firstEntityState;
	snapshot->firstEntityState = newBase;
	newBase->state.Init( newBase->stateBuf, sizeof( newBase->stateBuf ) );
	newBase->state.BeginWriting();
	deltaMsg.InitReading( base ? &base->state : NULL, &newBase->state, &msg );

	// all the players
	for ( i = 0; i < numClients; i++ ) {
		if ( entities[i] ) {
			assert( entities[i]->IsType( idPlayer::GetClassType() ) );
			idPlayer *p = static_cast< idPlayer * >( entities[i] );
			p->ReadPlayerStateFromSnapshot( deltaMsg );
		}
	}
	// the game state
	ReadGameStateFromSnapshot( deltaMsg );

	// process entity events
	ClientProcessEntityNetworkEventQueue();

}

/*
================
idGameLocal::ClientApplySnapshot
================
*/
bool idGameLocal::ClientApplySnapshot( int clientNum, int sequence ) {
	return ApplySnapshot( clientNum, sequence );
}

/*
================
idGameLocal::ClientProcessEntityNetworkEventQueue
================
*/
void idGameLocal::ClientProcessEntityNetworkEventQueue( void ) {
	idEntity			*ent;
	entityNetEvent_t	*event;
	idBitMsg			eventMsg;

	while( eventQueue.Start() ) {
		event = eventQueue.Start();

		// only process forward, in order
		if ( event->time > time ) {
			break;
		}

		idEntityPtr< idEntity > entPtr;
			
		if( !entPtr.SetSpawnId( event->spawnId ) ) {
			if( !gameLocal.entities[ event->spawnId & ( ( 1 << GENTITYNUM_BITS ) - 1 ) ] ) {
				// if new entity exists in this position, silently ignore
				NetworkEventWarning( event, "Entity does not exist any longer, or has not been spawned yet." );
			}
		} else {
			ent = entPtr.GetEntity();
			assert( ent );

			eventMsg.Init( event->paramsBuf, sizeof( event->paramsBuf ) );
			eventMsg.SetSize( event->paramsSize );
			eventMsg.BeginReading();
			if ( !ent->ClientReceiveEvent( event->event, event->time, eventMsg ) ) {
				NetworkEventWarning( event, "unknown event" );
			}
		}

#ifdef _DEBUG
		entityNetEvent_t* freedEvent = eventQueue.Dequeue();
		assert( freedEvent == event );
#else
		eventQueue.Dequeue();
#endif
		eventQueue.Free( event );
	}
}

// bdube: client side hitscan

/*
================
idGameLocal::ClientHitScan
================
*/
void idGameLocal::ClientHitScan( const idBitMsg &msg ) {

	assert( isClient );

	ENTDEF attackDef = static_cast<ENTDEF>( declManager->DeclByIndex( DECL_ENTITYDEF, msg.ReadBits( gameLocal.entityDefBits ), false ) );

	int ownerId = msg.ReadBits( ASYNC_MAX_CLIENT_BITS );

	idPlayer* owner = GET_PLAYER( ownerId );
	int num_hitscans = msg.ReadBits( 5 );


	idVec3 muzzleOrigin;
	idVec3 fxOrigin;

	muzzleOrigin[0] = msg.ReadFloat();
	muzzleOrigin[1] = msg.ReadFloat();
	muzzleOrigin[2] = msg.ReadFloat();
	fxOrigin[0] = msg.ReadFloat();
	fxOrigin[1] = msg.ReadFloat();
	fxOrigin[2] = msg.ReadFloat();

	if ( !owner )
		return;

	if ( !attackDef ) {
		gameLocal.Warning( "ClientHitScan - could not find hitscan def %s ", attackDef->GetName() );
		return;
	}

	AttackerInfo att( owner );
	idVec3 dir;

	// one direction sent per hitscan
	for( int i = 0; i < num_hitscans; i++ ) {
		dir = msg.ReadDir( 24 );
		gameLocal.HitScan( att, attackDef->dict, 1.0f, dir, muzzleOrigin, fxOrigin, owner );

	}
}



/*
================
idGameLocal::ClientProcessReliableMessage
================
*/
void idGameLocal::ClientProcessReliableMessage( int clientNum, const idBitMsg &msg ) {
	int			id;
	idDict		backupSI;

	InitLocalClient( clientNum );

	if ( serverDemo ) {
		assert( demoState == DEMO_PLAYING );
		int record_type = msg.ReadByte();
		assert( record_type < DEMO_RECORD_COUNT );
		// if you need to do some special filtering:
		switch ( record_type ) {
		case DEMO_RECORD_CLIENTNUM: {
			msg.ReadByte();
			/*
			int client = msg.ReadByte();
			if ( client != -1 ) {
				// reliable was targetted
				if ( followPlayer != client ) {
					// we're free flying or following someone else
					return;
				}
			}
			*/
			break;			
		}
		case DEMO_RECORD_EXCLUDE: {
			int exclude = msg.ReadByte();
			assert( exclude != -1 );
			/*
			if ( exclude == followPlayer ) {
				return;
			}
			*/
			break;
		}
		}
	}

	id = msg.ReadByte();
	switch( id ) {
		case GAME_RELIABLE_MESSAGE_SPAWN_PLAYER: {
			int client = msg.ReadBits( ASYNC_MAX_CLIENT_BITS );
			int spawnId = msg.ReadLong();
			if ( !entities[ client ] ) {
				SpawnPlayer( client );
				entities[ client ]->FreeModelDef();
			}

			// fix up the spawnId to match what the server says
			// otherwise there is going to be a bogus delete/new of the client entity in the first ClientReadFromSnapshot
			spawnIds[ client ] = spawnId;
			break;
		}
		case GAME_RELIABLE_MESSAGE_DELETE_ENT: {
			int spawnId = msg.ReadBits( 32 );
			idEntityPtr< idEntity > entPtr;
			if( !entPtr.SetSpawnId( spawnId ) ) {
				break;
			}
			int entNum = entPtr.GetEntity() ? entPtr.GetEntity()->entityNumber: MAX_CLIENTS;
			delete entPtr.GetEntity();

			if ( entNum >= 0 && entNum < MAX_CLIENTS ) {
				while ( numClients - 1 >= 0 && entities[ numClients - 1 ] == NULL ) {
					numClients--;
				}
			}
			
			break;
		}
		case GAME_RELIABLE_MESSAGE_TFCHAT: {
			char text[128];
			chatTargetType_t target = (chatTargetType_t)msg.ReadBits( 2 );
			msg.ReadString( text, sizeof( text ) );
			int shaderIndex = -1;
			if ( msg.ReadBits( 1 ) ) {
				shaderIndex = msg.ReadLong();
			}
			int clientNum = msg.ReadBits( ASYNC_MAX_CLIENT_BITS );

			byte currByte[3];

			currByte[0] = msg.ReadByte();
			currByte[1] = msg.ReadByte();
			currByte[2] = msg.ReadByte();

			byte deathByte[3];

			deathByte[0] = msg.ReadByte();
			deathByte[1] = msg.ReadByte();
			deathByte[2] = msg.ReadByte();

			if ( clientNum >= 0 && clientNum < numClients ) {
				idPlayer* p = GET_PLAYER( clientNum );

				if ( p ) {
					idVec3 out;
					DeNormalizePositionVector( currByte, out );
					p->currentLocation = LocationForPointQ4F( out );

					DeNormalizePositionVector( deathByte, out );
					p->deathLocation = LocationForPointQ4F( out );
				}
			}

			mpGame.PrintChatMessage( clientNum, target, text, shaderIndex );
			break;
		}
		case GAME_RELIABLE_MESSAGE_DB: {
			msg_evt_t msg_evt = (msg_evt_t)msg.ReadByte();
			int parm1, parm2;
			parm1 = msg.ReadLong( );
			parm2 = msg.ReadLong( );
			mpGame.PrintMessageEvent( -1, msg_evt, parm1, parm2 );
			break;
		}
		case GAME_RELIABLE_MESSAGE_EVENT: {
			entityNetEvent_t *event;

			// allocate new event
			event = eventQueue.Alloc();
			eventQueue.Enqueue( event, idEventQueue::OUTOFORDER_IGNORE );

			event->spawnId = msg.ReadBits( 32 );
			event->event = msg.ReadByte();
			event->time = msg.ReadLong();

			event->paramsSize = msg.ReadBits( idMath::BitsForInteger( MAX_EVENT_PARAM_SIZE ) );
			if ( event->paramsSize ) {
				if ( event->paramsSize > MAX_EVENT_PARAM_SIZE ) {
					NetworkEventWarning( event, "invalid param size" );
					return;
				}
				msg.ReadByteAlign();
				msg.ReadData( event->paramsBuf, event->paramsSize );
			}
			break;
		}
		case GAME_RELIABLE_MESSAGE_SERVERINFO: {
			idDict info;
			msg.ReadDeltaDict( info, NULL );
			SetServerInfo( info );
			break;
		}
		case GAME_RELIABLE_MESSAGE_RESTART: {
			MapRestart();
			break;
		}

		case GAME_RELIABLE_MESSAGE_PRINT: {
			char str[ MAX_PRINT_LEN ] = { '\0' };
			msg.ReadString( str, MAX_PRINT_LEN );
			mpGame.PrintMessage( -1, str );
			break;
		}

		case GAME_RELIABLE_MESSAGE_PORTALSTATES: {
			int numPortals = msg.ReadLong();
			assert( numPortals == gameRenderWorld->NumPortals() );
			for ( int i = 0; i < numPortals; i++ ) {
				gameRenderWorld->SetPortalState( (qhandle_t) (i+1), msg.ReadBits( NUM_RENDER_PORTAL_BITS ) );
			}
			break;
		}
		case GAME_RELIABLE_MESSAGE_PORTAL: {
			qhandle_t portal = msg.ReadLong();
			int blockingBits = msg.ReadBits( NUM_RENDER_PORTAL_BITS );
			assert( portal > 0 && portal <= gameRenderWorld->NumPortals() );
			gameRenderWorld->SetPortalState( portal, blockingBits );
			break;
		}
		case GAME_RELIABLE_MESSAGE_STARTSTATE: {
			mpGame.ClientReadStartState( msg );
			break;
		}

// bdube: 		
		case GAME_RELIABLE_MESSAGE_ITEMACQUIRESOUND:
			mpGame.PlayGlobalItemAcquireSound ( msg.ReadBits ( gameLocal.entityDefBits ) );
			break;

// ddynerman: game state
		case GAME_RELIABLE_MESSAGE_GAMESTATE: {
			mpGame.GetGameState()->ReceiveState( msg );
			break;
		}
// ddynerman: awards
		case GAME_RELIABLE_MESSAGE_INGAMEAWARD: {
			// 3j_todo
			//statManager->ReceiveInGameAward( msg );
			break;
		}

// mekberg: get ban list for server
		case GAME_RELIABLE_MESSAGE_GETADMINBANLIST: {
			mpBanInfo_t banInfo;
			char name[MAX_STRING_CHARS];
			char guid[MAX_STRING_CHARS];

			FlushBanList( );
			while ( msg.ReadString( name, MAX_STRING_CHARS ) && msg.ReadString( guid, MAX_STRING_CHARS ) ) {
				banInfo.name = name;
				strncpy( banInfo.guid, guid, CLIENT_GUID_LENGTH );
				banList.Append( banInfo );
			}

			break;
		}

		// <q4f>
		/*case GAME_RELIABLE_MESSAGE_CHANGECLASS:	{
			int clientNum = msg.ReadBits( ASYNC_MAX_CLIENT_BITS );
			idPlayer* player = GET_PLAYER( clientNum );
			if ( !player )	{
				gameLocal.Error( "Client changeclass: entity is null or not a player." );
				return;
			}
			int classNum = msg.ReadBits( ASYNC_CLASS_BITS );
			player->ChangeClass( classNum );
			break;
		}*/
		case GAME_RELIABLE_MESSAGE_DEATH_TF: {
			int attacker = msg.ReadBits( ASYNC_MAX_CLIENT_BITS );
			int victim = msg.ReadBits( ASYNC_MAX_CLIENT_BITS );
			int defNum = msg.ReadBits( gameLocal.entityDefBits );
			tfStatManager->PrintDeathMsg( attacker, victim, defNum  );
			break;
		}
		case GAME_RELIABLE_MESSAGE_GRENADE: {
			// server is letting us know its ok to prime
			//int grenNum = msg.ReadBits( 1 ) + 1;
			//gameLocal.GetLocalPlayer()->PrimeGrenade( grenNum );
			break;
		}
		case GAME_RELIABLE_MESSAGE_SCRIPTSOUND: {
			const idSoundShader* shader = static_cast< const idSoundShader* >( idGameLocal::ReadDecl( msg, DECL_SOUND ) );
			if ( shader ) {
				soundSystem->PlayShaderDirectly( SOUNDWORLD_GAME, shader->GetName() );
			}
			break;
		}
		case GAME_RELIABLE_MESSAGE_MAPINFO: {
			gameLocal.mapInfo.ReadInfo( msg );
			tfGame.InitFromMapInfo( gameLocal.mapInfo );
			break;
		}
		case GAME_RELIABLE_MESSAGE_SCRIPT_MESSAGE: {
			char strMsg[MAX_CENTER_MSG_SIZE];

			/*int index = msg.ReadBits( ASYNC_SCRIPT_CACHE_BITS );
			
			if ( msg.ReadBits( 1 ) == 0 ) {
				msg.ReadString( strMsg, sizeof( strMsg ) );

				while ( index >= gameLocal.mpGame.messageCache[clientNum].Num() ) {
					gameLocal.mpGame.messageCache[clientNum].Alloc();
				}

				gameLocal.mpGame.messageCache[clientNum][index] = strMsg;
			}

			gameLocal.mpGame.PrintCenterMessage( gameLocal.mpGame.messageCache[clientNum][index].c_str() );*/
			msg.ReadString( strMsg, sizeof( strMsg ) );
			gameLocal.mpGame.PrintCenterMessage( strMsg );
			break;
		}
		case GAME_RELIABLE_MESSAGE_MAPGUI_ALLVARS: {
			mpGame.ClientReadGuiVars( msg );
			break;
		}
	    case GAME_RELIABLE_MESSAGE_MAPGUI_FLOAT: {
			int varNum = msg.ReadBits( ASYNC_GUI_VAR_NUM_BITS );
			float val = msg.ReadFloat();
			gameLocal.mpGame.SetMapGuiFloat( varNum, val );
			break;
		}
		case GAME_RELIABLE_MESSAGE_MAPGUI_STRING: {
			int varNum = msg.ReadBits( ASYNC_GUI_VAR_NUM_BITS );
			char str[MAX_MAP_GUI_DATASIZE];
			msg.ReadString( str, MAX_MAP_GUI_DATASIZE );
			gameLocal.mpGame.SetMapGuiString( varNum, str );
			break;
		}
		 case GAME_RELIABLE_MESSAGE_MAPGUI_INT: {
			int varNum = msg.ReadBits( ASYNC_GUI_VAR_NUM_BITS );
			int val = msg.ReadLong();
			gameLocal.mpGame.SetMapGuiInt( varNum, val );
			break;
		}
		case GAME_RELIABLE_MESSAGE_MAPGUI_BOOL: {
			int varNum = msg.ReadBits( ASYNC_GUI_VAR_NUM_BITS );
			bool val = msg.ReadBits( 1 ) == 1;
			gameLocal.mpGame.SetMapGuiBool( varNum, val );
			break;
		}
		case GAME_RELIABLE_MESSAGE_MAPGUI_EVENT: {
			int eventNum = msg.ReadByte();
			gameLocal.mpGame.MapGuiNamedEvent( eventNum);
			break;
		}
		case GAME_RELIABLE_MESSAGE_PLAYERSTATS: {
			tfStatManager->ClientReceiveStats( msg );
			break;
		}
		case GAME_RELIABLE_MESSAGE_ENDGAMEAWARDS: {
			char awardsStr[ MAX_GAME_MESSAGE_SIZE ];
			msg.ReadString( awardsStr, sizeof( awardsStr ) );
			gameLocal.mpGame.GetMainGui()->SetStateString( "end_game_awards", awardsStr );
			break;
		}
		// </q4f>				// DONT FORGET THE FRIGGEN BREAKS
	
	
		default: {
			Error( "Unknown server->client reliable message: %d", id );
			break;
		}
	}
}


/*
================
idGameLocal::ClientRun
Called once each client render frame (before any ClientPrediction frames have been run)
================
*/
void idGameLocal::ClientRun( void ) {
	if( isMultiplayer ) {
		mpGame.ClientRun();
	}
}

/*
================
idGameLocal::ClientEndFrame
Called once each client render frame (after all ClientPrediction frames have been run)
================
*/
void idGameLocal::ClientEndFrame( void ) {
	if( isMultiplayer ) {
		mpGame.ClientEndFrame();
	}
}

/*
================
idGameLocal::ProcessRconReturn
================
*/
void idGameLocal::ProcessRconReturn( bool success )	{
	if( isMultiplayer )	{
		mpGame.ProcessRconReturn( success );
	}
}

/*
================
idGameLocal::ResetGuiRconStatus
================
*/
void idGameLocal::ResetRconGuiStatus( void )	{
	if( isMultiplayer )	{
		mpGame.ResetRconGuiStatus( );
	}
}



/*
================
idGameLocal::ClientPrediction
server demos: clientNum == MAX_CLIENTS
================
*/
gameReturn_t idGameLocal::ClientPrediction( int clientNum, const usercmd_t *clientCmds, bool lastPredictFrame, ClientStats_t *cs ) {
	idEntity *ent;
	idPlayer *player;
	gameReturn_t ret;

	ret.sessionCommand[ 0 ] = '\0';

	if ( clientNum == MAX_CLIENTS ) {
		// clientCmds[ MAX_CLIENTS ] has the local interaction
		// firing -> cycle follow players, jump -> free fly and cycle map spawns

		int btn_mask;

		player = NULL;
		oldUsercmd = usercmd;
		usercmd = clientCmds[ MAX_CLIENTS ];
		btn_mask = usercmd.buttons ^ oldUsercmd.buttons;

		if ( usercmd.buttons & btn_mask & BUTTON_ATTACK ) {
			// find the next suitable player to follow
			int delta = 0;
			while ( true ) {
				int i_next = GetNextClientNum( followPlayer );
				if ( followPlayer < i_next ) {
					delta += i_next - followPlayer;
				} else {
					delta += numClients - followPlayer + i_next;
				}
				if ( delta > numClients ) {
					// tried them all, no fit
					followPlayer = -1;
					break;
				}
				followPlayer = i_next;
				if ( !entities[ followPlayer ] ) {
					continue;
				}
				idPlayer *p = static_cast< idPlayer * >( entities[ followPlayer ] );
				if ( p->spectating ) {
					continue;
				}
				break;
			}
		}
		if ( usercmd.upmove & !oldUsercmd.upmove ) {
			if ( followPlayer != -1 ) {
				// set yourself up a bit above whoever you were following
				freeView.SetFreeView( followPlayer );
			} else {
				// pick a random spawn spot to start flying from
				freeView.PickRandomSpawn();
			}
			followPlayer = -1;			
		}
		
		player = NULL;
		if ( followPlayer >= 0 ) {
			player = static_cast< idPlayer* >( entities[ followPlayer ] );
			if ( !player ) {
				// that player we were following was removed from the game
				freeView.PickRandomSpawn();
			} else if ( player->spectating ) {
				// our followed player went spectator, go free fly
				freeView.SetFreeView( followPlayer );
				player = NULL;
				followPlayer = -1;
			}
		}

		if ( !player && !freeView.Initialized() ) {
			freeView.PickRandomSpawn();
		}

	} else {
		player = static_cast<idPlayer *>( entities[clientNum] );
	}


// bdube: added advanced debug support
	if ( g_showDebugHud.GetInteger() && net_entsInSnapshot && net_snapshotSize) {
		gameDebug.SetInt( "snap_ents", net_entsInSnapshot );
		gameDebug.SetInt( "snap_size", net_snapshotSize );

		net_entsInSnapshot = 0;
		net_snapshotSize = 0; 
	}

	if ( clientNum == localClientNum ) {
		gameDebug.BeginFrame( );
		gameLog->BeginFrame( time );
	}

	isLastPredictFrame = lastPredictFrame;


	// check for local client lag
	if ( player ) {
		if ( networkSystem->ClientGetTimeSinceLastPacket() >= net_clientMaxPrediction.GetInteger() ) {
			player->isLagged = true;
		} else {
			player->isLagged = false;
		}
	}

	InitLocalClient( clientNum );

	// update the game time
	framenum++;
	previousTime = time;

// bdube: use GetMSec access rather than USERCMD_TIME
	time += GetMSec();


	// update the real client time and the new frame flag
	if ( time > realClientTime ) {
		realClientTime = time;
		isNewFrame = true;
	} else {
		isNewFrame = false;
	}

	if ( cs ) {
		cs->isLastPredictFrame = isLastPredictFrame;
		cs->isLagged = player ? player->isLagged : false;
		cs->isNewFrame = isNewFrame;
	}

	// set the user commands for this frame

	usercmds = clientCmds;

	if ( clientNum == MAX_CLIENTS && !player ) {
		freeView.Fly( usercmd );
	}


	// TMP
	bool verbose = cvarSystem->GetCVarBool( "verbose_predict" );

	// run prediction on all entities from the last snapshot
	for ( ent = snapshotEntities.Next(); ent != NULL; ent = ent->snapshotNode.Next() ) {
#if 0
		ent->thinkFlags |= TH_PHYSICS;
		ent->ClientPredictionThink();
#else
		// don't force TH_PHYSICS on, only call ClientPredictionThink if thinkFlags != 0
		// it's better to synchronize TH_PHYSICS on specific entities when needed ( movers may be trouble )
		// thinkMask is a temp thing see if there are problems with only checking for TH_PHYSICS
		if ( ent->thinkFlags != 0 ) {
			if ( verbose ) {
				common->Printf( "%d: %s %d\n", ent->entityNumber, ent->GetType()->classname, ent->thinkFlags );
			}
			ent->ClientPredictionThink();
		} else {
			if ( verbose ) {
				common->Printf( "skip %d: %s %d\n", ent->entityNumber, ent->GetType()->classname, ent->thinkFlags );
			}
		}
#endif
	}


// bdube: client entities
	// run client entities
	if ( isNewFrame ) {
		// rjohnson: only run the entire logic when it is a new frame
		rvClientEntity* cent;
		for ( cent = clientSpawnedEntities.Next(); cent != NULL; cent = cent->spawnNode.Next() ) {
			cent->Think();
		}
	}


	// service any pending events
	idEvent::ServiceEvents();

	// show any debug info for this frame
	if ( isNewFrame ) {
		RunDebugInfo();
		D_DrawDebugLines();
	}

	if ( sessionCommand.Length() ) {
		strncpy( ret.sessionCommand, sessionCommand, sizeof( ret.sessionCommand ) );
		sessionCommand = "";
	}


// ddynerman: client logging/debugging
	if( clientNum == localClientNum ) {
		gameDebug.EndFrame( );
		gameLog->EndFrame( );
	}

	return ret;
}

/*
===============
idGameLocal::Tokenize
===============
*/
void idGameLocal::Tokenize( idStrList &out, const char *in ) {
	char buf[ MAX_STRING_CHARS ];
	char *token, *next;

	idStr::Copynz( buf, in, MAX_STRING_CHARS );
	token = buf;
	next = strchr( token, ';' );
	while ( token ) {
		if ( next ) {
			*next = '\0';
		}
		idStr::ToLower( token );
		out.Append( token );
		if ( next ) {
			token = next + 1;
			next = strchr( token, ';' );
		} else {
			token = NULL;
		}		
	}
}

/*
===============
idGameLocal::DownloadRequest
===============
*/
bool idGameLocal::DownloadRequest( const char *IP, const char *guid, const char *paks, char urls[ MAX_STRING_CHARS ] ) {
	if ( !cvarSystem->GetCVarInteger( "net_serverDownload" ) ) {
		return false;
	}
	if ( cvarSystem->GetCVarInteger( "net_serverDownload" ) == 1 ) {
		// 1: single URL redirect
		if ( !strlen( cvarSystem->GetCVarString( "si_serverURL" ) ) ) {
			common->Warning( "si_serverURL not set" );
			return false;
		}
		idStr::snPrintf( urls, MAX_STRING_CHARS, "1;%s", cvarSystem->GetCVarString( "si_serverURL" ) );
		return true;
	} else {
		// 2: table of pak URLs
		// 3: table of pak URLs with built-in http server
		// first token is the game pak if requested, empty if not requested by the client
		// there may be empty tokens for paks the server couldn't pinpoint - the order matters
		idStr 		reply = "2;";
		idStrList	dlTable, pakList;
		bool		matchAll = false;
		int			i, j;

		if ( !idStr::Icmp( cvarSystem->GetCVarString( "net_serverDlTable" ), "*" ) ) {
			matchAll = true;
		} else {
			Tokenize( dlTable, cvarSystem->GetCVarString( "net_serverDlTable" ) );
		}
		Tokenize( pakList, paks );

		for ( i = 0; i < pakList.Num(); i++ ) {
			if ( i > 0 ) {
				reply += ";";
			}
			if ( pakList[ i ][ 0 ] == '\0' ) {
				if ( i == 0 ) {
					// pak 0 will always miss when client doesn't ask for game bin
					common->DPrintf( "no game pak request\n" );
				} else {
					common->DPrintf( "no pak %d\n", i );
				}
				continue;
			}

			idStr url = cvarSystem->GetCVarString( "net_serverDlBaseURL" );

			if ( !url.Length() ) {
				if ( cvarSystem->GetCVarInteger( "net_serverDownload" ) == 2 ) {
					common->Warning( "net_serverDownload == 2 and net_serverDlBaseURL not set" );
				} else {
					url = cvarSystem->GetCVarString( "net_httpServerBaseURL" );
				}
			}
			
			if ( matchAll ) {
				url.AppendPath( pakList[i] );
				reply += url;
				common->Printf( "download for %s: %s\n", IP, url.c_str() );
			} else {
				for ( j = 0; j < dlTable.Num(); j++ ) {
					if ( !pakList[ i ].Icmp( dlTable[ j ] ) ) {
						break;
					}
				}
				if ( j == dlTable.Num() ) {
					common->Printf( "download for %s: pak not matched: %s\n", IP, pakList[ i ].c_str() );
				} else {
					url.AppendPath( dlTable[ j ] );
					reply += url;
					common->Printf( "download for %s: %s\n", IP, url.c_str() );
				}
			}
		}

		idStr::Copynz( urls, reply, MAX_STRING_CHARS );
		return true;
	}
}

/*
===============
idGameLocal::HTTPRequest
===============
*/
bool idGameLocal::HTTPRequest( const char *IP, const char *file, bool isGamePak ) {
	idStrList	dlTable;
	int			i;

	if ( !idStr::Icmp( cvarSystem->GetCVarString( "net_serverDlTable" ), "*" ) ) {
		return true;
	}

	Tokenize( dlTable, cvarSystem->GetCVarString( "net_serverDlTable" ) );
	while ( *file == '/' ) ++file; // net_serverDlTable doesn't include the initial /

	for ( i = 0; i < dlTable.Num(); i++ ) {
		if ( !dlTable[ i ].Icmp( file ) ) {
			return true;
		}
	}

	return false;
}

/*
===============
idEventQueue::Alloc
===============
*/
entityNetEvent_t* idEventQueue::Alloc() {
	entityNetEvent_t* event = eventAllocator.Alloc();
	event->prev = NULL;
	event->next = NULL;
	return event;
}

/*
===============
idEventQueue::Free
===============
*/
void idEventQueue::Free( entityNetEvent_t *event ) {
	// should only be called on an unlinked event!
	assert( !event->next && !event->prev );
	eventAllocator.Free( event );
}

/*
===============
idEventQueue::Shutdown
===============
*/
void idEventQueue::Shutdown() {
	eventAllocator.Shutdown();
	this->Init();
}

/*
===============
idEventQueue::Init
===============
*/
void idEventQueue::Init( void ) {
	start = NULL;
	end = NULL;
}

/*
===============
idEventQueue::Dequeue
===============
*/
entityNetEvent_t* idEventQueue::Dequeue( void ) {
	entityNetEvent_t* event = start;
	if ( !event ) {
		return NULL;
	}

	start = start->next;

	if ( !start ) {
		end = NULL;
	} else {
		start->prev = NULL;
	}

	event->next = NULL;
	event->prev = NULL;

	return event;
}

/*
===============
idEventQueue::RemoveLast
===============
*/
entityNetEvent_t* idEventQueue::RemoveLast( void ) {
	entityNetEvent_t *event = end;
	if ( !event ) {
		return NULL;
	}

	end = event->prev;

	if ( !end ) {
		start = NULL;
	} else {
		end->next = NULL;		
	}

	event->next = NULL;
	event->prev = NULL;

	return event;
}

/*
===============
idEventQueue::Enqueue
===============
*/
void idEventQueue::Enqueue( entityNetEvent_t *event, outOfOrderBehaviour_t behaviour ) {
	if ( behaviour == OUTOFORDER_DROP ) {
		// go backwards through the queue and determine if there are
		// any out-of-order events
		while ( end && end->time > event->time ) {
			entityNetEvent_t *outOfOrder = RemoveLast();
			common->DPrintf( "WARNING: new event with id %d ( time %d ) caused removal of event with id %d ( time %d ), game time = %d.\n", event->event, event->time, outOfOrder->event, outOfOrder->time, gameLocal.time );
			Free( outOfOrder );
		}
	} else if ( behaviour == OUTOFORDER_SORT && end ) {
		// NOT TESTED -- sorting out of order packets hasn't been
		//				 tested yet... wasn't strictly necessary for
		//				 the patch fix.
		entityNetEvent_t *cur = end;
		// iterate until we find a time < the new event's
		while ( cur && cur->time > event->time ) {
			cur = cur->prev;
		}
		if ( !cur ) {
			// add to start
			event->next = start;
			event->prev = NULL;
			start = event;
		} else {
			// insert
			event->prev = cur;
			event->next = cur->next;
			cur->next = event;
		}
		return;
	} 

	// add the new event
	event->next = NULL;
	event->prev = NULL;

	if ( end ) {
		end->next = event;
		event->prev = end;
	} else {
		start = event;
	}
	end = event;
}


// shouchard:  ban list stuff here

/*
================
idGameLocal::LoadBanList
================
*/
void idGameLocal::LoadBanList() {

	// open file
	idStr token;
	idFile *banFile = fileSystem->OpenFileRead( BANLIST_FILENAME );
	mpBanInfo_t banInfo;
	if ( NULL == banFile ) {
		common->DPrintf( "idGameLocal::LoadBanList:  unable to open ban list file!\n" ); // fixme:  need something better here
		return;
	}

	// parse file (read three consecutive strings per banInfo (real complex ;) ) )
	while ( banFile->ReadString( token ) > 0 ) {
		// name
		banInfo.name = token;

		// guid
		if ( banFile->ReadString( token ) > 0 && token.Length() >= 11 ) {
			idStr::Copynz( banInfo.guid, token.c_str(), CLIENT_GUID_LENGTH );

			// ip
			banList.Append( banInfo );
			continue;
		}

		gameLocal.Warning( "idGameLocal::LoadBanList:  Potential curruption of banlist file (%s).", BANLIST_FILENAME );
	}
	fileSystem->CloseFile( banFile );

	banListLoaded = true;
	banListChanged = false;
}

/*
================
idGameLocal::SaveBanList
================
*/
void idGameLocal::SaveBanList() {
	if ( !banListChanged ) {
		return;
	}

	// open file
	idFile *banFile = fileSystem->OpenFileWrite( BANLIST_FILENAME );
	if ( NULL == banFile ) {
		common->DPrintf( "idGameLocal::SaveBanList:  unable to open ban list file!\n" ); // fixme:  need something better here
		return;
	}

	for ( int i = 0; i < banList.Num(); i++ ) {
		const mpBanInfo_t& banInfo = banList[ i ];
		char temp[ 16 ] = { 0, };
		banFile->WriteString( va( "%s", banInfo.name.c_str() ) );
		idStr::Copynz( temp, banInfo.guid, CLIENT_GUID_LENGTH );
		banFile->WriteString( temp );
//		idStr::Copynz( temp, (const char*)banInfo.ip, 15 );
//		banFile->WriteString( "255.255.255.255" );
	}
	fileSystem->CloseFile( banFile );
	banListChanged = false;
}

/*
================
idGameLocal::FlushBanList
================
*/
void idGameLocal::FlushBanList() {
	banList.Clear();
	banListLoaded = false;
	banListChanged = false;
}

/*
================
idGameLocal::IsPlayerBanned
================
*/
bool idGameLocal::IsPlayerBanned( const char *name ) {
	assert( name );

	if ( !banListLoaded ) {
		LoadBanList();
	}

	// check vs. each line in the list, if we found one return true
	for ( int i = 0; i < banList.Num(); i++ ) {
		if ( 0 == idStr::Icmp( name, banList[ i ].name ) ) {
			return true;
		}
	}

	return false;
}

/*
================
idGameLocal::IsGuidBanned
================
*/
bool idGameLocal::IsGuidBanned( const char *guid ) {
	assert( guid );

	if ( !banListLoaded ) {
		LoadBanList();
	}

	// check vs. each line in the list, if we found one return true
	for ( int i = 0; i < banList.Num(); i++ ) {
		if ( 0 == idStr::Icmp( guid, banList[ i ].guid ) ) {
			return true;
		}
	}

	return false;
}

/*
================
idGameLocal::AddGuidToBanList
================
*/
void idGameLocal::AddGuidToBanList( const char *guid ) {
	assert( guid );

	if ( !banListLoaded ) {
		LoadBanList();
	}

	mpBanInfo_t banInfo;
	char name[ 512 ];	// TODO: clean this up
	gameLocal.GetPlayerName( gameLocal.GetClientNumByGuid( guid ), name );
	banInfo.name = name;
	idStr::Copynz( banInfo.guid, guid, CLIENT_GUID_LENGTH );
//	SIMDProcessor->Memset( banInfo.ip, 0xFF, 15 );
	banList.Append( banInfo );
	banListChanged = true;
}

/*
================
idGameLocal::RemoveGuidFromBanList
================
*/
void idGameLocal::RemoveGuidFromBanList( const char *guid ) {
	assert( guid );

	if ( !banListLoaded ) {
		LoadBanList();
	}

	// check vs. each line in the list, if we find a match remove it.
	for ( int i = 0; i < banList.Num(); i++ ) {
		if ( 0 == idStr::Icmp( guid, banList[ i ].guid ) ) {
			banList.RemoveIndex( i );
			banListChanged = true;
			return;
		}
	}
}

/*
================
idGameLocal::RegisterClientGuid
================
*/
void idGameLocal::RegisterClientGuid( int clientNum, const char *guid ) {
	assert( clientNum >= 0 && clientNum < MAX_CLIENTS );
	assert( guid );
	memset( clientGuids[ clientNum ], 0, CLIENT_GUID_LENGTH ); // just in case
	idStr::Copynz( clientGuids[ clientNum ], guid, CLIENT_GUID_LENGTH );
}

/*
================
idGameLocal::GetBanListCount
================
*/
int idGameLocal::GetBanListCount() {
	if ( !banListLoaded ) {
		LoadBanList();
	}

	return banList.Num();
}

/*
================
idGameLocal::GetBanListEntry
================
*/
const mpBanInfo_t* idGameLocal::GetBanListEntry( int entry ) {
	if ( !banListLoaded ) {
		LoadBanList();
	}

	if ( entry < 0 || entry >= banList.Num() ) {
		return NULL;
	}

	return &banList[ entry ];
}

/*
================
idGameLocal::GetGuidByClientNum
================
*/
const char *idGameLocal::GetGuidByClientNum( int clientNum ) {
	assert( clientNum >= 0 && clientNum < numClients );

	return clientGuids[ clientNum ];
}

/*
================
idGameLocal::GetClientNumByGuid
================
*/
int idGameLocal::GetClientNumByGuid( const char * guid ) {
	assert( guid );

	for ( int i = 0; i < MAX_CLIENTS; i++ ) {
		if ( !idStr::Icmp( networkSystem->GetClientGUID( i ), guid ) ) {
			return i;
		}
	}
	return -1;
}

// mekberg: send ban list to client
/*
================
idGameLocal::ServerSendBanList
================
*/
void idGameLocal::ServerSendBanList( int clientNum ) {
	idBitMsg	outMsg;
	byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];

	outMsg.Init( msgBuf, sizeof( msgBuf ) );
	outMsg.WriteByte( GAME_RELIABLE_MESSAGE_GETADMINBANLIST ) ;

	if ( !banListLoaded ) {
		LoadBanList();
	}

	int i;
	int c = banList.Num();
	for ( i = 0; i < c; i++ ) {
		outMsg.WriteString( banList[ i ].name.c_str() );
		outMsg.WriteString( banList[ i ].guid, CLIENT_GUID_LENGTH );
	}

	networkSystem->ServerSendReliableMessage( clientNum, outMsg );
}

// mekberg: so we can populate ban list outside of multiplayer game
/*
===================
idGameLocal::PopulateBanList
===================
*/
void idGameLocal::PopulateBanList( idUserInterface* hud ) {
	if ( !hud ) {
		return;
	}

	int bans = GetBanListCount();
	for ( int i = 0; i < bans; i++ ) {
		const mpBanInfo_t * banInfo = GetBanListEntry( i );
		hud->SetStateString( va( "sa_banList_item_%d", i ), va( "%d:  %s\t%s", i+1, banInfo->name.c_str(), banInfo->guid ) );
	}
	hud->DeleteStateVar( va( "sa_banList_item_%d", bans ) );
	hud->SetStateString( "sa_banList_sel_0", "-1" );
	// used to trigger a redraw, was slow, and doesn't seem to do anything so took it out. fixes #13675
	hud->StateChanged( gameLocal.time, false );
}

/*
===============
idGameLocal::SendUnreliableMessage
for spectating support, we have to loop through the clients and emit to the spectator client too
note that a clientNum == -1 means send to everyone
===============
*/
void idGameLocal::SendUnreliableMessage( const idBitMsg &msg, const int clientNum ) {
	int icl;
	idPlayer *player;
	
	for ( icl = 0; icl < numClients; icl++ ) {
		if ( icl == localClientNum ) {
			// not to local client
			// not that if local is spectated he will still get it
			continue;
		}
		if ( !entities[ icl ] ) {
			continue;
		}
		if ( icl != clientNum ) {
			player = static_cast< idPlayer * >( entities[ icl ] );
			// drop all clients except the ones that follow the client we emit to
			if ( !player->spectating || player->spectator != clientNum ) {
				continue;
			}
		}
		unreliableMessages[ icl ].Add( msg.GetData(), msg.GetSize(), false );
	}

	if ( demoState == DEMO_RECORDING ) {
		// record the type and destination for remap on readback
		idBitMsg	dest;
		byte		msgBuf[ 16 ];
		
		dest.Init( msgBuf, sizeof( msgBuf ) );
		dest.WriteByte( GAME_UNRELIABLE_RECORD_CLIENTNUM );
		dest.WriteByte( clientNum );
		
		unreliableMessages[ MAX_CLIENTS ].AddConcat( dest.GetData(), dest.GetSize(), msg.GetData(), msg.GetSize(), false );
	}
}

/*
===============
idGameLocal::SendUnreliableMessagePVS
excludeClient to -1 for no exclusions
===============
*/
void idGameLocal::SendUnreliableMessagePVS( const idBitMsg &msg, const idEntity *instanceEnt, int area1, int area2 ) {
	int			icl;
	int			matchInstance = instanceEnt ? instanceEnt->GetInstance() : -1;
	idPlayer	*player;
	int			areas[ 2 ];
	int			numEvAreas;

	numEvAreas = 0;
	if ( area1 != -1 ) {
		areas[ 0 ] = area1;
		numEvAreas++;
	}
	if ( area2 != -1 ) {
		areas[ numEvAreas ] = area2;
		numEvAreas++;
	}

	for ( icl = 0; icl < numClients; icl++ ) {
		if ( icl == localClientNum ) {
			// local client is always excluded
			continue;
		}
		if ( !entities[ icl ] ) {
			continue;
		}
		if ( matchInstance >= 0 && entities[ icl ]->GetInstance() != matchInstance ) {
			continue;
		}
		if ( clientsPVS[ icl ].i < 0 ) {
			// clients for which we don't have PVS info won't get anything
			continue;
		}
		player = static_cast< idPlayer * >( entities[ icl ] );

		// if no areas are given, this is a global emit
		if ( numEvAreas ) {
			// ony send if pvs says this client can see it
			if ( !pvs.InCurrentPVS( clientsPVS[ icl ], areas, numEvAreas ) ) {
				continue;
			}
		}

		unreliableMessages[ icl ].Add( msg.GetData(), msg.GetSize(), false );
	}

	if ( demoState == DEMO_RECORDING ) {
		// record the target areas to the message
		idBitMsg	dest;
		byte		msgBuf[ 16 ];

		// Tourney games: only record from instance 0
		if ( !instanceEnt || instanceEnt->GetInstance() == 0 ) {
		
			dest.Init( msgBuf, sizeof( msgBuf ) );
			dest.WriteByte( GAME_UNRELIABLE_RECORD_AREAS );
			dest.WriteLong( area1 );
			dest.WriteLong( area2 );
			
			unreliableMessages[ MAX_CLIENTS ].AddConcat( dest.GetData(), dest.GetSize(), msg.GetData(), msg.GetSize(), false );
		}
	}
}

/*
===============
idGameLocal::ClientReadUnreliableMessages
===============
*/
void idGameLocal::ClientReadUnreliableMessages( const idBitMsg &_msg ) {
	idMsgQueue	localQueue;
	int			size;
	byte		msgBuf[MAX_GAME_MESSAGE_SIZE];
	idBitMsg	msg;

	localQueue.ReadFrom( _msg );

	msg.Init( msgBuf, sizeof( msgBuf ) );
	while ( localQueue.Get( msg.GetData(), msg.GetMaxSize(), size, false ) ) {
		msg.SetSize( size );
		msg.BeginReading();
		ProcessUnreliableMessage( msg );
		msg.BeginWriting();
	}
}

/*
===============
idGameLocal::DemoReplayInAreas
checks if our current demo replay view ( server demo ) matches the areas given
===============
*/
bool idGameLocal::IsDemoReplayInAreas( int area1, int area2 ) {
	int				areas[2];
	int				numAreas;

	idVec3			view;
	pvsHandle_t		handle;

	bool			ret;

	numAreas = 0;
	if ( area1 != -1 ) {
		areas[ 0 ] = area1;
		numAreas++;
	}
	if ( area2 != -1 ) {
		areas[ numAreas ] = area2;
		numAreas++;
	}	

	assert( serverDemo );
	assert( demoState == DEMO_PLAYING );

	if ( followPlayer == -1 ) {
		view = freeView.GetOrigin();
	} else {
		view = entities[ followPlayer ]->GetPhysics()->GetOrigin();
	}

	// could probably factorize this, at least for processing all unreliable messages, maybe at a higher level of the loop?
	handle = pvs.SetupCurrentPVS( view );
	ret = pvs.InCurrentPVS( handle, areas, numAreas );
	pvs.FreeCurrentPVS( handle );
	return ret;   
}

/*
===============
idGameLocal::ProcessUnreliableMessage
===============
*/
void idGameLocal::ProcessUnreliableMessage( const idBitMsg &msg ) {
	if ( serverDemo ) {
		assert( demoState == DEMO_PLAYING );		
		int record_type = msg.ReadByte();
		assert( record_type < GAME_UNRELIABLE_RECORD_COUNT );
		switch ( record_type ) {
		case GAME_UNRELIABLE_RECORD_CLIENTNUM: {
			int client = msg.ReadByte();
			if ( client != -1 ) {
				// unreliable was targetted
				if ( followPlayer != client ) {
					// either free flying, or following someone else
					return;
				}
			}
			break;
			}
		case GAME_UNRELIABLE_RECORD_AREAS: {
			int	area1 = msg.ReadLong();
			int area2 = msg.ReadLong();
			if ( !IsDemoReplayInAreas( area1, area2 ) ) {
				return;
			}
			break;
			}
		}
	}

	int type = msg.ReadByte();
	switch ( type ) {
		case GAME_UNRELIABLE_MESSAGE_EVENT: {
			idEntityPtr<idEntity> p;
			int spawnId = msg.ReadBits( 32 );
			p.SetSpawnId( spawnId );
			
			if ( p.GetEntity() ) {
				p.GetEntity()->ClientReceiveEvent( msg.ReadByte(), time, msg );
			} else {
				Warning( "ProcessUnreliableMessage: no local entity 0x%x for event %d", spawnId & ( ( 1 << GENTITYNUM_BITS ) - 1 ), msg.ReadByte() );
			}
			break;
		}
		case GAME_UNRELIABLE_MESSAGE_EFFECT: {
			idCQuat				quat;
			idVec3				origin, origin2;
			rvClientEffect*		effect;
			effectCategory_t	category;
			const idDecl		*decl;
				
			decl = idGameLocal::ReadDecl( msg, DECL_EFFECT );

			origin.x = msg.ReadFloat( );
			origin.y = msg.ReadFloat( );
			origin.z = msg.ReadFloat( );
				
			quat.x = msg.ReadFloat( );
			quat.y = msg.ReadFloat( );
			quat.z = msg.ReadFloat( );
			
			bool loop = msg.ReadBits( 1 ) != 0;

			origin2.x = msg.ReadFloat( );
			origin2.y = msg.ReadFloat( );
			origin2.z = msg.ReadFloat( );

			category = ( effectCategory_t )msg.ReadByte();

			if ( bse->CanPlayRateLimited( category ) ) {
				effect = new rvClientEffect( decl );
				effect->SetOrigin( origin );
				effect->SetAxis( quat.ToMat3() );
				effect->Play( time, loop, origin2 );
			}
			
			break;
		}
		case GAME_UNRELIABLE_MESSAGE_HITSCAN: {
			ClientHitScan( msg );
			break;
		}
#ifdef _USE_VOICECHAT
		case GAME_UNRELIABLE_MESSAGE_VOICEDATA_SERVER: {
			mpGame.ReceiveAndPlayVoiceData( msg );
			break;
		}
#else
		case GAME_UNRELIABLE_MESSAGE_VOICEDATA_SERVER: {
			break;
		}
#endif
		default: {
			Error( "idGameLocal::ProcessUnreliableMessage() - Unknown unreliable message '%d'\n", type );
		}
	}
}


/*
===============
idGameLocal::WriteNetworkInfo
===============
*/
void idGameLocal::WriteNetworkInfo( idFile* file, int clientNum ) {
	int				i, j;
	snapshot_t		*snapshot;
	entityState_t	*entityState;

	if ( !IsServerDemo() ) {

		// save the current states
		for ( i = 0; i < MAX_GENTITIES; i++ ) {
			entityState = clientEntityStates[clientNum][i];
			file->WriteBool( !!entityState );
			if ( entityState ) {
				file->WriteInt( entityState->entityNumber );
				file->WriteInt( entityState->state.GetSize() );
				file->Write( entityState->state.GetData(), entityState->state.GetSize() );
			}
		}

		// save the PVS states
		for ( i = 0; i < MAX_CLIENTS; i++ ) {
			for ( j = 0; j < ENTITY_PVS_SIZE; j++ ) {
				file->WriteInt( clientPVS[i][j] );
			}
		}

	}

	// players ( including local client )
	j = 0;
	for ( i = 0; i < MAX_CLIENTS; i++ ) {
		if ( !entities[i] ) {
			continue;
		}
		j++;
	}
	file->WriteInt( j );
	for ( i = 0; i < MAX_CLIENTS; i++ ) {
		if ( !entities[i] ) {
			continue;
		}
		file->WriteInt( i );
		file->WriteInt( spawnIds[ i ] );
	}

	if ( !IsServerDemo() ) {

		// write number of snapshots so on readback we know how many to allocate
		i = 0;
		for ( snapshot = clientSnapshots[ clientNum ]; snapshot; snapshot = snapshot->next ) {
			i++;
		}
		file->WriteInt( i );

		for ( snapshot = clientSnapshots[ clientNum ]; snapshot; snapshot = snapshot->next ) {
			file->WriteInt( snapshot->sequence );

			// write number of entity states in the snapshot
			i = 0;
			for ( entityState = snapshot->firstEntityState; entityState; entityState = entityState->next ) {
				i++;
			}
			file->WriteInt( i );
		
			for ( entityState = snapshot->firstEntityState; entityState; entityState = entityState->next ) {
				file->WriteInt( entityState->entityNumber );
				file->WriteInt( entityState->state.GetSize() );
				file->Write( entityState->state.GetData(), entityState->state.GetSize() );
			}

			file->Write( snapshot->pvs, sizeof( snapshot->pvs ) );
		}

	}

	// write the 'initial reliables' data
	mpGame.WriteNetworkInfo( file, clientNum );
}

/*
===============
idGameLocal::ReadNetworkInfo
===============
*/
void idGameLocal::ReadNetworkInfo( int gameTime, idFile* file, int clientNum ) {
	int				i, j, num, numStates, stateSize;
	snapshot_t		*snapshot, **lastSnap;
	entityState_t	*entityState, **lastState;

	assert( clientNum == MAX_CLIENTS || !IsServerDemo() );
	InitLocalClient( clientNum );

	time = gameTime;
	previousTime = gameTime;

	// force new frame
	realClientTime = 0;
	isNewFrame = true;

	// clear the snapshot entity list
	snapshotEntities.Clear();

	if ( !IsServerDemo() ) {

		for ( i = 0; i < MAX_GENTITIES; i++ ) {
			bool isValid;
		
			file->ReadBool( isValid );
			if ( isValid ) {
				clientEntityStates[clientNum][i] = entityStateAllocator.Alloc();
				entityState = clientEntityStates[clientNum][i];
				entityState->next = NULL;
				file->ReadInt( entityState->entityNumber );
				file->ReadInt( stateSize );
				entityState->state.Init( entityState->stateBuf, sizeof( entityState->stateBuf ) );
				entityState->state.SetSize( stateSize );
				file->Read( entityState->state.GetData(), stateSize );
			} else {
				clientEntityStates[clientNum][i] = NULL;
			}
		}

		for ( i = 0; i < MAX_CLIENTS; i++ ) {
			for ( j = 0; j < ENTITY_PVS_SIZE; j++ ) {
				file->ReadInt( clientPVS[i][j] );
			}
		}

	}

	// spawn player entities. ( numClients is not a count but the watermark of client indexes )


	file->ReadInt( num );
	for ( i = 0; i < num; i++ ) {
		int icl, spawnId;
		file->ReadInt( icl );
		file->ReadInt( spawnId );
		SpawnPlayer( icl );
		spawnIds[ icl ] = spawnId;
		numClients = icl + 1;
	}

	if ( !IsServerDemo() ) {

		file->ReadInt( num );
		lastSnap = &clientSnapshots[ localClientNum ];
		for ( i = 0; i < num; i++ ) {
			snapshot = snapshotAllocator.Alloc();
			snapshot->firstEntityState = NULL;
			snapshot->next = NULL;
			file->ReadInt( snapshot->sequence );

			file->ReadInt( numStates );
			lastState = &snapshot->firstEntityState;
			for ( j = 0; j < numStates; j++ ) {			
				entityState = entityStateAllocator.Alloc();
				file->ReadInt( entityState->entityNumber );
				file->ReadInt( stateSize );
				entityState->state.Init( entityState->stateBuf, sizeof( entityState->stateBuf ) );
				entityState->state.SetSize( stateSize );
				file->Read( entityState->state.GetData(), stateSize );
				entityState->next = NULL;
				assert( !(*lastState ) );
				*lastState = entityState;
				lastState = &entityState->next;
			}

			file->Read( snapshot->pvs, sizeof( snapshot->pvs ) );

			assert( !(*lastSnap) );
			*lastSnap = snapshot;
			lastSnap = &snapshot->next;
		}

		// spawn entities
		for ( i = 0; i < ENTITYNUM_NONE; i++ ) {
			int				spawnId, entityDefNumber;
			idBitMsgDelta	deltaMsg;
			idDict			args;
			entityState_t	*base = clientEntityStates[clientNum][i];
			idEntity		*ent = entities[i];
			const idDeclEntityDef	*decl;
		
			if ( !base ) {
				continue;
			}
			base->state.BeginReading();
			deltaMsg.InitReading( &base->state, NULL, NULL );

			spawnId = deltaMsg.ReadBits( 32 - GENTITYNUM_BITS );
			entityDefNumber = deltaMsg.ReadBits( entityDefBits );

			if ( !ent || ent->entityDefNumber != entityDefNumber || spawnId != spawnIds[ i ] ) {

				delete ent;

				spawnCount = spawnId;

				args.Clear();
				args.SetInt( "spawn_entnum", i );
				args.Set( "name", va( "entity%d", i ) );

				if ( entityDefNumber >= 0 ) {
					if ( entityDefNumber >= declManager->GetNumDecls( DECL_ENTITYDEF ) ) {
						Error( "server has %d entityDefs instead of %d", entityDefNumber, declManager->GetNumDecls( DECL_ENTITYDEF ) );
					}
					decl = static_cast< const idDeclEntityDef * >( declManager->DeclByIndex( DECL_ENTITYDEF, entityDefNumber, false ) );
					assert( decl && decl->GetType() == DECL_ENTITYDEF );
					args.Set( "classname", decl->GetName() );					
					if ( !SpawnEntityDef( args, &ent ) || !entities[i] ) {
						Error( "Failed to spawn entity with classname '%s' of type '%s'", decl->GetName(), decl->dict.GetString("spawnclass") );
					}
				} else {
					Error( "ReadNetorkInfo - entityDefNumber < 0" );
				}

			}

			// add the entity to the snapshot list
			ent->snapshotNode.AddToEnd( snapshotEntities );
		
			// read the class specific data from the snapshot
			ent->ReadFromSnapshot( deltaMsg );

			// this is useful. for instance on idPlayer, resets stuff so powerups actually appear
			ent->ClientUnstale();
		}

		{
			// specific state read for game and player state
			idBitMsgDelta	deltaMsg;
			entityState_t	*base = clientEntityStates[clientNum][ENTITYNUM_NONE];
			idPlayer		*player;
			int				targetPlayer;

			// it's possible to have a recording start right at CS_INGAME and not have a base for reading this yet
			if ( base ) {
				base->state.BeginReading();
				deltaMsg.InitReading( &base->state, NULL, NULL );

				targetPlayer = deltaMsg.ReadBits( idMath::BitsForInteger( MAX_CLIENTS ) );
				player = static_cast< idPlayer* >( entities[ targetPlayer ] );
				if ( !player ) {
					Error( "ReadNetworkInfo: no local player entity" );
					return;
				}
				player->ReadPlayerStateFromSnapshot( deltaMsg );
				ReadGameStateFromSnapshot( deltaMsg );
			}
		}

		// set self spectating state according to userinfo settings
		GetLocalPlayer()->Spectate( idStr::Icmp( userInfo[ clientNum ].GetString( "ui_spectate" ), "Spectate" ) == 0 );

	}

	// read the 'initial reliables' data
	mpGame.ReadNetworkInfo( file, clientNum );
}

/*
============
idGameLocal::SetDemoState
============
*/
void idGameLocal::SetDemoState( demoState_t state, bool _serverDemo, bool _timeDemo ) {
	if ( demoState == DEMO_RECORDING && state == DEMO_NONE ) {
		ServerClientDisconnect( MAX_CLIENTS );
	}
	demoState = state;
	serverDemo = _serverDemo;
	timeDemo = _timeDemo;
	if ( demoState == DEMO_NONE ) {
		demo_hud = NULL;
		demo_mphud = NULL;
		demo_cursor = NULL;
	}
}

/*
===============
idGameLocal::ValidateDemoProtocol
===============
*/
bool idGameLocal::ValidateDemoProtocol( int minor_ref, int minor ) {
	// 1.1 beta : 67
	// 1.1 final: 68
	// attention mod makers:
	// there were some incompatible changes between beta and final,
	// you can't just check for minor 67 with a minor_ref of 68 here and accept replay
	// you would have to compare 1.1 beta snapshotting code with final and appropriately interpret depending wether reading protocol 67 or 68
	return ( minor_ref == minor );
}

