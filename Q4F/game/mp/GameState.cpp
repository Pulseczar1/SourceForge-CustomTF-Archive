//----------------------------------------------------------------
// GameState.cpp
//
// Copyright 2002-2005 Raven Software
//----------------------------------------------------------------

#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "GameState.h"

/*
===============================================================================

TFGameState

===============================================================================
*/

/*
================
TFGameState::TFGameState
================
*/
TFGameState::TFGameState( bool allocPrevious ) {
	previousGameState = NULL;
	Clear();

	if( allocPrevious ) {
		previousGameState = new TFGameState( false );
	} else {
		previousGameState = NULL;
	}
	
	trackPrevious = allocPrevious;
}

/*
================
TFGameState::~TFGameState
================
*/
TFGameState::~TFGameState( void ) {
	Clear();
	//if ( previousGameState )
		//delete previousGameState;		// 3j_todo: deleting previous gamestate crashes game
	previousGameState = NULL;
}

/*
================
TFGameState::Clear
================
*/
void TFGameState::Clear( void ) {

	currentState = INACTIVE;
	nextState = INACTIVE;
	nextStateTime = 0;
	fragLimitTimeout = 0;

	// mekberg: clear previous game state.
	if ( previousGameState ) {
		previousGameState->Clear( );
	}		


	// 3j_todo: return flags back to base ? should be done for all ents
}

/*
================
TFGameState::SendState
================
*/
void TFGameState::SendState( int clientNum ) {
	idBitMsg	outMsg;
	byte		msgBuf[MAX_GAME_MESSAGE_SIZE];

	assert( !gameLocal.isClient && trackPrevious );

	if( clientNum == -1 && (*this) == (*previousGameState) ) {
		return;
	}

	outMsg.Init( msgBuf, sizeof( msgBuf ) );
	outMsg.WriteByte( GAME_RELIABLE_MESSAGE_GAMESTATE );

	WriteState( outMsg );

	networkSystem->ServerSendReliableMessage( clientNum, outMsg );
	
	// don't update the state if we are working for a single client
	if ( clientNum == -1 ) {
		outMsg.ReadByte(); // pop off the msg ID
		ReceiveState( outMsg );
	}
}

/*
===============
TFGameState::WriteState
===============
*/
void TFGameState::WriteState( idBitMsg &msg ) {
	PackState( msg );
}

/*
================
TFGameState::SendInitialState
================
*/
void TFGameState::SendInitialState( int clientNum ) {
	TFGameState* previousState = previousGameState;

	TFGameState invalidState;

	previousGameState = &invalidState;

	SendState( clientNum );

	previousGameState = previousState;
}

/*
================
TFGameState::ReceiveState
================
*/
void TFGameState::ReceiveState( const idBitMsg& msg ) {
	UnpackState( msg );

	if ( gameLocal.localClientNum >= 0 ) {
		GameStateChanged();
	}

	(*previousGameState) = (*this);
}

/*
================
TFGameState::PackState
================
*/
void TFGameState::PackState( idBitMsg& outMsg ) {
	// for now, we only transmit 3 bytes.  If we need to sync more data, we should
	// only transmit the diff
	outMsg.WriteByte( currentState );
	outMsg.WriteByte( nextState );
	outMsg.WriteLong( nextStateTime );
}

/*
================
TFGameState::UnpackState
================
*/
void TFGameState::UnpackState( const idBitMsg& inMsg ) {
	currentState = (mpGameState_t)inMsg.ReadByte();
	nextState = (mpGameState_t)inMsg.ReadByte();
	nextStateTime = inMsg.ReadLong();
}

/*
================
TFGameState::GameStateChanged

called on local client or listen server, just does sounds and stuff
================
*/
void TFGameState::GameStateChanged( void ) {

	idPlayer* player = gameLocal.GetLocalPlayer();
	if ( !player ) {
		if ( gameLocal.GetDemoState() == DEMO_PLAYING && gameLocal.IsServerDemo() && gameLocal.GetDemoFollowClient() >= 0 ) {
			player = static_cast< idPlayer * >( gameLocal.entities[ gameLocal.GetDemoFollowClient() ] );
		}
	}
	if ( !player ) {
		gameLocal.Warning( "TFGameState::GameStateChanged() - NULL local player\n" ) ;
		return;
	}

	// Check for a currentState change
	if( currentState != previousGameState->currentState ) {
		if( currentState == WARMUP ) {
			player->GUIMainNotice( common->GetLocalizedString( "#str_107706" ), true );		

			gameLocal.mpGame.ClearGuis();

			soundSystem->SetActiveSoundWorld(true);

		} else if( currentState == COUNTDOWN ) {
			player->GUIMainNotice( common->GetLocalizedString( "#str_107706" ), true );		

			soundSystem->SetActiveSoundWorld(true);
			if( previousGameState->currentState != INACTIVE ) {
				gameLocal.mpGame.RemoveAnnouncerSound( AS_GENERAL_PREPARE_TO_FIGHT );
				gameLocal.mpGame.RemoveAnnouncerSound( AS_GENERAL_THREE );
				gameLocal.mpGame.RemoveAnnouncerSound( AS_GENERAL_TWO );
				gameLocal.mpGame.RemoveAnnouncerSound( AS_GENERAL_ONE );

				gameLocal.mpGame.ScheduleAnnouncerSound( AS_GENERAL_PREPARE_TO_FIGHT, gameLocal.time );
				gameLocal.mpGame.ScheduleAnnouncerSound( AS_GENERAL_THREE, nextStateTime - 3000 );
				gameLocal.mpGame.ScheduleAnnouncerSound( AS_GENERAL_TWO, nextStateTime - 2000 );
				gameLocal.mpGame.ScheduleAnnouncerSound( AS_GENERAL_ONE, nextStateTime - 1000 );
			}
		} else if( currentState == GAMEON ) {
			if ( !player->vsMsgState ) {
				player->GUIMainNotice( "" );
				player->GUIFragNotice( "" );
			} else {
				player->vsMsgState = false;
			}
			gameLocal.mpGame.ScheduleAnnouncerSound( AS_GENERAL_FIGHT, gameLocal.time );

			gameLocal.mpGame.ScheduleTimeAnnouncements( );
 		} else if( currentState == SUDDENDEATH ) {
			gameLocal.mpGame.ScheduleAnnouncerSound( AS_GENERAL_SUDDEN_DEATH, gameLocal.time );
			player->GUIMainNotice( common->GetLocalizedString( "#str_104287" ) );
		} else if( currentState == GAMEREVIEW ) {
			// the game goes into (GAMEREVIEW->INACTIVE) before going into (GAMEREVIEW->WARMUP), so
			// check nextState to make sure this only gets called once
			//if( nextState == INACTIVE ) {
				gameLocal.mpGame.ShowStatSummary();

				gameLocal.mpGame.ClearGuis();

				soundSystem->SetActiveSoundWorld( true );

				if( gameLocal.IsTeamGame() && IS_VALID_TEAM( player->team ) ) {
					int winningTeam = -1;
					int highscore = idMath::INT_MIN;
					int score;
					TFTeam* team = tfGame.GetTeam( 0 );
					while ( team ) {
						score = tfStatManager->GetTeamScore( team->GetTeamNum() );
						if ( score > highscore ) {
							highscore = score;
							winningTeam = team->GetTeamNum();
						}
						else if ( score == highscore ) {
							winningTeam = -1;
						}
						team = tfGame.GetTeam( team->GetTeamNum() + 1 );
					}
					if ( winningTeam >= 0 ) {
						// 3j_todo: this doesn't work on score limit reached cuz player's havn't received score in snapshot yet
						// send scores with state? send winning team with state?
						if ( player->team == winningTeam ) {
							gameLocal.mpGame.ScheduleAnnouncerSound( AS_GENERAL_YOU_WIN, gameLocal.time );
						}
						else if ( IS_VALID_TEAM( player->team ) ) {
							gameLocal.mpGame.ScheduleAnnouncerSound( AS_GENERAL_YOU_LOSE, gameLocal.time );
						}
					}
					else if ( highscore == 0 ) {
						// 3j_todo: YOU WIN to highest scoring player?
					}
				}
			//}
		}
	}
}

/*
================
TFGameState::Run
================
*/
void TFGameState::Run( void ) {
	if ( currentState == INACTIVE ) {
		NewState( WARMUP );
	}

	if ( nextState != INACTIVE && gameLocal.time > nextStateTime ) {
		NewState( nextState );
		nextState = INACTIVE;
	}

	switch( currentState ) {
		case INACTIVE:
			break;

		case GAMEON:
			if ( gameLocal.mpGame.TimeLimitHit() ) {
				gameLocal.mpGame.PrintMessageEvent( -1, MSG_TIMELIMIT );
				NewState( GAMEREVIEW );
			}
			else {
				int capTeam = gameLocal.mpGame.CaptureLimitHit();

				if ( capTeam >= 0 ) {
					gameLocal.mpGame.PrintMessageEvent( -1, MSG_CAPTURELIMIT, capTeam );
					NewState( GAMEREVIEW );
				}
			}
			break;

		case GAMEREVIEW: {
			if ( nextState == INACTIVE ) {
				nextState = NEXTGAME;
				// allow a little extra time in tourney since we have to display end brackets
				nextStateTime = gameLocal.time + (1000 * cvarSystem->GetCVarInteger( "g_gameReviewPause" ));				
			}
			break;
		}
		case NEXTGAME: {
			// the core will force a restart at 12 hours max
			// but it's nicer if we can wait for a game transition to perform the restart so the game is not interrupted
			// perform a restart once we are past 8 hours

			tfStatManager->ClearRound();

			if ( networkSystem->ServerGetServerTime() > 8*60*60*1000 ) {
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, "nextMap\n" );
				return;
			}

			if ( nextState == INACTIVE ) {
				// game rotation, new map, gametype etc.
				if ( gameLocal.NextMap() ) {
					cmdSystem->BufferCommandText( CMD_EXEC_NOW, "serverMapRestart\n" );
					return;
				}

				NewState( WARMUP );

				gameLocal.mpGame.CheckRespawns();
			}
			break;
		}
		case WARMUP: {
			// check to see if we actually want to do a warmup, or if we fall through

			if ( gameLocal.mpGame.RoundReadyToStart() ) {	
				int count = gameLocal.serverInfo.GetInt( "si_countDown" );
				if ( count < 1 ) {
					nextState = GAMEON;
					nextStateTime = gameLocal.time;
				}
				else {
					NewState( COUNTDOWN );
					nextState = GAMEON;
					nextStateTime = gameLocal.time + 1000 * count;
				}
			}
			break;
		}
		case COUNTDOWN: {
			break;
		}
	}
}

/*
================
TFGameState::NewState
================
*/
void TFGameState::NewState( mpGameState_t newState ) {
	idBitMsg	outMsg;
	byte		msgBuf[MAX_GAME_MESSAGE_SIZE];
	int			i;

	assert( (newState != currentState) && !gameLocal.isClient );
	
	switch( newState ) {
		case WARMUP: {
			// if shuffle is on, shuffle the teams around
			if( gameLocal.serverInfo.GetBool( "si_shuffle" ) ) {
				gameLocal.mpGame.ShuffleTeams();
			}

			// allow damage in warmup
			//gameLocal.mpGame.EnableDamage( false );

			gameLocal.mpGame.SetWarmupStartedTime( gameLocal.time );

			break;
		}
		case GAMEON: {
			// allow damage in warmup
			//gameLocal.mpGame.EnableDamage( true );

			gameLocal.LocalMapRestart();

			tfStatManager->RoundStart( gameLocal.mapFileNameStripped.c_str() );

			outMsg.Init( msgBuf, sizeof( msgBuf ) );
			outMsg.WriteByte( GAME_RELIABLE_MESSAGE_RESTART );
			outMsg.WriteBits( 0, 1 );
			networkSystem->ServerSendReliableMessage( -1, outMsg );

			gameLocal.mpGame.SetMatchStartedTime( gameLocal.time );

			fragLimitTimeout = 0;

			// write server initial reliable messages to give everyone new base
			/*for( i = 0; i < MAX_CLIENTS; i++ ) {
				// dont send this to server - we have all the data already and this will
				// just trigger extra gamestate detection
				if( gameLocal.entities[ i ] && i != gameLocal.localClientNum ) {
					gameLocal.mpGame.ServerWriteInitialReliableMessages( i );
				}
			}*/

			idPlayer* p;
			for ( i = 0; i < gameLocal.numClients; i++ ) {
				p = GET_PLAYER( i );
				if ( p ) {
					if ( i != gameLocal.localClientNum )
						gameLocal.mpGame.ServerWriteInitialReliableMessages( p->entityNumber );

					p->ServerSpectate( p->wantSpectate || 
						!gameLocal.mpGame.CanPlay( p ) );
				}
			}

			gameLocal.mpGame.switchThrottle[ 1 ] = 0;	// passby the throttle
			break;
		}
		case GAMEREVIEW: {

			const char* awardsStr = gameLocal.mpGame.GetStatAwards();
			gameLocal.mpGame.GetMainGui()->SetStateString( "end_game_awards", awardsStr );
			gameLocal.mpGame.GetMainGui()->SetStateString( "end_game_awards2", "BLAH!" );
			gameLocal.mpGame.GetMainGui()->StateChanged( gameLocal.time );

			outMsg.Init( msgBuf, sizeof( msgBuf ) );
			outMsg.WriteByte( GAME_RELIABLE_MESSAGE_ENDGAMEAWARDS );
			outMsg.WriteString( awardsStr, MAX_GAME_MESSAGE_SIZE - 2 );
			networkSystem->ServerSendReliableMessage( -1, outMsg );

			tfStatManager->RoundEnd();

			//statManager->DebugPrint();
			nextState = INACTIVE;	// used to abort a game. cancel out any upcoming state change

			for( i = 0; i < gameLocal.numClients; i++ ) {
				idEntity *ent = gameLocal.entities[ i ];
				
				// jnewquist: Use accessor for static class type 
				if ( !ent || !ent->IsType( idPlayer::GetClassType() ) ) {
					
					continue;
				}
				static_cast<idPlayer *>(ent)->ServerSpectate( true );
			}
			break;
		}
		case SUDDENDEATH: {
			gameLocal.mpGame.PrintMessageEvent( -1, MSG_SUDDENDEATH );

			if( gameLocal.serverInfo.GetBool( "si_suddenDeathRestart" ) ) {
				gameLocal.LocalMapRestart();
			}
			
			break;
		}
		default: {
			break;
		}
	}

	currentState = newState;
}

/*
================
TFGameState::ClientDisconnect
================
*/
void TFGameState::ClientDisconnect( idPlayer* player ) {
	return;
}

/*
================
TFGameState::Spectate
================
*/
void TFGameState::Spectate( idPlayer* player ) {
	/*if( player->spectating && player->wantSpectate ) {
		gameLocal.mpGame.ClearFrags( player->entityNumber );
	}*/
	return;
}

/*
================
TFGameState::operator==
================
*/
bool TFGameState::operator==( const TFGameState& rhs ) const {
	return	(
		( currentState == rhs.currentState ) &&
		( nextState	== rhs.nextState ) &&
		( nextStateTime == rhs.nextStateTime ) 
		);
}

/*
================
TFGameState::operator!=
================
*/
bool TFGameState::operator!=( const TFGameState& rhs ) const {
	return	(
		( currentState != rhs.currentState ) ||
		( nextState	!= rhs.nextState ) ||
		( nextStateTime != rhs.nextStateTime ) 
		);
}

/*
================
TFGameState::operator=
================
*/
TFGameState& TFGameState::operator=( const TFGameState& rhs ) {
	currentState = rhs.currentState;
	nextState = rhs.nextState;
	nextStateTime = rhs.nextStateTime;
	return (*this);
}

/*
===============
TFGameState::WriteClientNetworkInfo
===============
*/
void TFGameState::WriteNetworkInfo( idFile *file, int clientNum ) {
	idBitMsg	msg;
	byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];
	
	msg.Init( msgBuf, sizeof( msgBuf ) );
	msg.BeginWriting();
	WriteState( msg );
	file->WriteInt( msg.GetSize() );
	file->Write( msg.GetData(), msg.GetSize() );
}

/*
===============
TFGameState::ReadClientNetworkInfo
===============
*/
void TFGameState::ReadNetworkInfo( idFile *file, int clientNum ) {
	idBitMsg	msg;
	byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];
	int			size;

	file->ReadInt( size );
	msg.Init( msgBuf, size );
	msg.SetSize( size );
	file->Read( msg.GetData(), size );
	ReceiveState( msg );
}
