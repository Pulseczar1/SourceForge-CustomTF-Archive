#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"

/*
===============================================================================

	Voting System

===============================================================================
*/

q4fVoteSys::q4fVoteSys() {
	_bStarted = false;
}

void q4fVoteSys::Startup() {
	if ( _bStarted )
		return;

	_bStarted = true;
	_currentVote = NULL;

	RegisterVoteClasses();
}

void q4fVoteSys::Shutdown() {
	_listVotes.DeleteContents( true );
	_bStarted = false;
	_currentVote = NULL;
}

void q4fVoteSys::RegisterVoteClasses() {

	RegisterVoteClass( new q4fVoteOptionKickPlayer() );
	RegisterVoteClass( new q4fVoteOptionClassChange() );
}

void q4fVoteSys::RegisterVoteClass( q4fVoteOption* option ) {
	assert( option );

	option->SetID( _listVotes.Num() );
	_listVotes.Append( option );
}

void q4fVoteSys::ClearVote( bool justVoteStatus ) {

	if ( justVoteStatus ) {
		for ( int i = 0; i < MAX_CLIENTS; i++ ) {
			_clientVoteData[i].vote = CLIENT_VOTE_UNDECIDED;
		}
	}
	else {
		memset( _clientVoteData, 0, sizeof( clientVoteData_t ) * MAX_CLIENTS );
	}
}

void q4fVoteSys::ClearClientVote( int clientNum ) {
	assert( clientNum >= 0 && clientNum < MAX_CLIENTS );

	_clientVoteData[clientNum].lastVoteCastTime = 0;
	_clientVoteData[clientNum].lastVoteFailTime = 0;
	_clientVoteData[clientNum].numVotesCalledFailed = 0;
	_clientVoteData[clientNum].numVotesCalledPass = 0;
	_clientVoteData[clientNum].vote = CLIENT_VOTE_UNDECIDED;
}

void q4fVoteSys::RequestVoteStart_f( const idCmdArgs &args ) {
	gameLocal.Printf( "voting disabled.\n" );

	//gameLocal.mpGame.voteSystem.RequestVoteStart( gameLocal.localClientNum, args );
}

void q4fVoteSys::RequestVoteStart( int clientNum, const idCmdArgs &args ) {

	if ( args.Argc() < 2 ) {
		gameLocal.Printf( "Usage: vote <vote type>\n" );
		return;
	}

	const char* type = args.Argv( 1 );

	q4fVoteOption* opt = NULL;

	for ( int i = 0; i < _listVotes.Num(); i++ ) {
		if ( !idStr::Icmp( _listVotes[i]->GetName(), type ) ) {
			opt = _listVotes[i];
			break;
		}
	}

	if ( !opt ) {
		gameLocal.Printf( "Unknown vote option '%s'\n", type );
		return;
	}

	if ( opt->ReadData( clientNum, args ) ) {

		ProcessVoteRequest( clientNum, opt );
	}
}

void q4fVoteSys::ReceiveVoteRequest( int clientNum, const idBitMsg &msg ) {
	assert( !gameLocal.isClient );

	int id = msg.ReadByte();

	if ( _currentVote || id < 0 || id >= _listVotes.Num() ) {
		gameLocal.Error( "q4fVoteSys::ReceiveVoteRequest - vote option id #%d is out of range.", id );
	}

	if ( _listVotes[ id ]->ReadData( clientNum, msg ) ) {

		ProcessVoteRequest( clientNum, _listVotes[ id ] );
	}
}

void q4fVoteSys::ProcessVoteRequest( int clientNum, q4fVoteOption* option ) {
	assert( option );

	if ( VoteInProgress() ) {
		gameLocal.Printf( "A vote is already in progress.\n" );
		return;
	}

	int id = option->GetID();

	if ( id < 0 || id >= _listVotes.Num() ) {
		gameLocal.Warning( "Vote option %s has invalid id #%d\n", option->GetName(), id );
		return;
	}

	if ( gameLocal.isClient ) {

		// send request to server
		byte msgBuf[ MAX_GAME_MESSAGE_SIZE ];
		idBitMsg outMsg;
		outMsg.Init( msgBuf, sizeof( msgBuf ) );

		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_STARTVOTE );
		outMsg.WriteByte( id );

		option->PackData( outMsg );
		networkSystem->ClientSendReliableMessage( outMsg );
	}
	else {
		// server received a request from a client or is calling the vote itself
		assert( _currentVote == NULL );

		_currentVote = option;

		if ( !_currentVote->Start() ) {
			_currentVote = NULL;
		}
	}
}

void q4fVoteSys::Run() {
	if ( _currentVote ) {
		if ( _currentVote->VoteInProgress() && _currentVote->VotePasses( _clientVoteData ) ) {
			VoteSuccess();
			_currentVote->Execute();
			_currentVote->Stop();
			_currentVote = NULL;
		}
		else if ( _currentVote->VoteTimeRemaining() <= 0 ) {
			VoteFailure();
			_currentVote->Stop();
			_currentVote = NULL;
		}
	}
}

void q4fVoteSys::VoteSuccess() {
}

void q4fVoteSys::VoteFailure() {
}

const char* q4fVoteSys::GetVoteOptionName( int index ) {
	if ( index < 0 || index >= _listVotes.Num() )
		return NULL;

	return _listVotes[index]->GetName();
}





/*
===============================================================================

	Vote Options

===============================================================================
*/

//-------------------------
// base
//-------------------------

q4fVoteOption::q4fVoteOption() {
	_voteStartTime = 0;
	_voteClientNum = -1;
	_voteTime = 30000;
	_id = -1;
}

void q4fVoteOption::PackData( idBitMsg &msg ) {
	msg.WriteLong( _voteStartTime );
	msg.WriteBits( _voteClientNum, ASYNC_MAX_CLIENT_BITS );
}

bool q4fVoteOption::ReadData( int clientWhoCalledVote, const idBitMsg &msg ) {
	int vs = msg.ReadLong();
	int vcn = msg.ReadBits( ASYNC_MAX_CLIENT_BITS );

	if ( !VoteInProgress() ) {
		_voteStartTime = vs;
		_voteClientNum = vcn;
		_voteClientNum = clientWhoCalledVote;

		return InternalDataIsValid();
	}

	return false;
}

bool q4fVoteOption::ReadData( int clientWhoCalledVote, const idCmdArgs &args ) {
	if ( VoteInProgress() ) {
		gameLocal.Printf( "Vote already in progress.\n" );
		return false;
	}

	_voteClientNum = clientWhoCalledVote;
	return InternalDataIsValid();
}

bool q4fVoteOption::InternalDataIsValid() {
	return _voteClientNum >= 0 && _voteClientNum < gameLocal.numClients && GET_PLAYER( _voteClientNum );
}

bool q4fVoteOption::Start() {

	if ( !InternalDataIsValid() )
		return false;

	_voteStartTime = gameLocal.time;

	return true;
}

bool q4fVoteOption::VotePasses( clientVoteData_t clientVotes[ MAX_CLIENTS ] ) {

	if ( !VoteInProgress() )
		return false;

	bool timeIsUp = VoteTimeRemaining() > 0;

	clientVoteTotals_t totalVotes;
	
	GatherVoteData( clientVotes, totalVotes );

	return VotePasses( totalVotes, timeIsUp );
}

void q4fVoteOption::GatherVoteData( clientVoteData_t clientVotes[ MAX_CLIENTS ], clientVoteTotals_t &voteTotals ) {

	voteTotals.numVotesYes = 0;
	voteTotals.numVotesNo = 0;
	voteTotals.numPlayers = 0;

	for ( int i = 0; i < gameLocal.numClients; i++ ) {
		if ( gameLocal.mpGame.IsInGame( i ) ) {
			voteTotals.numPlayers++;

			if ( clientVotes[i].vote == CLIENT_VOTE_YES ) {
				voteTotals.numVotesYes++;
			}
			else if ( clientVotes[i].vote == CLIENT_VOTE_NO ) {
				voteTotals.numVotesNo++;
			}
		}
	}
}

bool q4fVoteOption::VotePasses( clientVoteTotals_t &voteTotals, bool timeIsUp ) {
	if ( voteTotals.numPlayers <= 1 )
		return false;

	// tie?
	if ( voteTotals.numVotesYes == voteTotals.numVotesNo )
		return false;

	// first check if majority of server is yes or no
	if ( (float)voteTotals.numVotesYes / (float)voteTotals.numPlayers > 0.5f )
		return true;

	if ( (float)voteTotals.numVotesNo / (float)voteTotals.numPlayers > 0.5f )
		return true;

	// if out of time, just see who is the majority
	if ( timeIsUp ) {
		if ( voteTotals.numVotesYes > voteTotals.numVotesNo )
			return true;
		else
			return false;
	}

	return false;
}

int q4fVoteOption::VoteTimeRemaining() {
	if ( !VoteInProgress() )
		return 0;

	int timeLeft = _voteTime - ( gameLocal.time - _voteStartTime );

	if ( timeLeft <= 0 )
		return 0;

	return timeLeft;
}

void q4fVoteOption::VoteArgumentError( const char* err ) {
	gameLocal.Printf( "%s\n", err );
}


//-------------------------
// team base
//-------------------------
q4fVoteOptionTeam::q4fVoteOptionTeam() {
	_preferredTeam = INVALID_TEAM;
}

void q4fVoteOptionTeam::PackData( idBitMsg &msg ) {
	q4fVoteOption::PackData( msg );
	msg.WriteBits( _preferredTeam, ASYNC_TEAM_BITS );
}

bool q4fVoteOptionTeam::ReadData( int clientWhoCalledVote, const idBitMsg &msg ) {
	bool valid = q4fVoteOption::ReadData( clientWhoCalledVote, msg );

	int pft = msg.ReadBits( ASYNC_TEAM_BITS );

	if ( !VoteInProgress() ) {
		_preferredTeam = pft;

		return valid && InternalDataIsValid();
	}

	return false;
}

bool q4fVoteOptionTeam::InternalDataIsValid() {
	return _preferredTeam >= 0 && _preferredTeam <= INVALID_TEAM;
}

bool q4fVoteOptionTeam::VotePasses( clientVoteData_t clientVotes[ MAX_CLIENTS ] ) {

	if ( !VoteInProgress() )
		return false;

	bool timeIsUp = VoteTimeRemaining() > 0;

	clientVoteTotals_t teamVotes;
	clientVoteTotals_t totalVotes;

	GatherVoteData( clientVotes, teamVotes, totalVotes );

	// check if everyone passes
	bool pass = q4fVoteOption::VotePasses( totalVotes, timeIsUp );

	// check if team passes
	if ( !pass )
		pass = q4fVoteOption::VotePasses( teamVotes, timeIsUp );

	return pass;
}

void q4fVoteOptionTeam::GatherVoteData( clientVoteData_t clientVotes[ MAX_CLIENTS ], clientVoteTotals_t &teamVotes, clientVoteTotals_t &totalVotes ) {

	memset( &teamVotes, 0, sizeof( teamVotes ) );
	memset( &totalVotes, 0, sizeof( totalVotes ) );

	for ( int i = 0; i < gameLocal.numClients; i++ ) {
		if ( gameLocal.mpGame.IsInGame( i ) ) {
			idPlayer* p = GET_PLAYER( i );

			if ( !p )
				continue;

			if ( p->team == _preferredTeam ) {
				teamVotes.numPlayers++;

				if ( clientVotes[i].vote == CLIENT_VOTE_YES ) {
					teamVotes.numVotesYes++;
				}
				else if ( clientVotes[i].vote == CLIENT_VOTE_NO ) {
					teamVotes.numVotesNo++;
				}
			}

			totalVotes.numPlayers++;

			if ( clientVotes[i].vote == CLIENT_VOTE_YES ) {
				totalVotes.numVotesYes++;
			}
			else if ( clientVotes[i].vote == CLIENT_VOTE_NO ) {
				totalVotes.numVotesNo++;
			}
		}
	}
}

//-------------------------
// team player base
//-------------------------
q4fVoteOptionTeamPlayer::q4fVoteOptionTeamPlayer() {
	_targetClientNum = -1;
}

void q4fVoteOptionTeamPlayer::PackData( idBitMsg &msg ) {
	q4fVoteOptionTeam::PackData( msg );
	msg.WriteBits( _targetClientNum, ASYNC_MAX_CLIENT_BITS );
}

bool q4fVoteOptionTeamPlayer::ReadData( int clientWhoCalledVote, const idBitMsg &msg ) {
	bool valid = q4fVoteOptionTeam::ReadData( clientWhoCalledVote, msg );

	int tcn = msg.ReadBits( ASYNC_MAX_CLIENT_BITS );

	if ( !VoteInProgress() ) {
		_targetClientNum = tcn;

		return valid && InternalDataIsValid();
	}

	return false;
}

bool q4fVoteOptionTeamPlayer::ReadData( int clientWhoCalledVote, const idCmdArgs &args ) {

	if ( !q4fVoteOptionTeam::ReadData( clientWhoCalledVote, args ) )
		return false;

	_targetClientNum = -1;

	if ( args.Argc() < 3 ) {
		gameLocal.Printf( "Usage: vote kick <player name or #>\n" );

		//print list of players
		idStr pName;

		gameLocal.Printf( "Players:\n" );

		for ( int i = 0; i < gameLocal.numClients; i++ ) {
			idPlayer* p = GET_PLAYER( i );

			if ( p ) {
				pName = p->uiName;
				pName.RemoveEscapes();

				gameLocal.Printf( "%d: %s\n", i, pName.c_str() );
			}
		}

		return false;
	}

	idStr pName = args.Argv( 2 );

	if ( pName.IsNumeric() ) {

		int clientNum = atoi( pName.c_str() );

		if ( clientNum < 0 || clientNum >= gameLocal.numClients ) {
			VoteArgumentError( va( "Client #%d is out of range", clientNum ) );
			return false;
		}

		idPlayer* p = GET_PLAYER( clientNum );

		if ( !p ) {
			VoteArgumentError( va( "Could not find player for client #%d", clientNum ) );
			return false;
		}

		_targetClientNum = clientNum;
	}
	else {
		idPlayer* p = gameLocal.GetClientByName( pName.c_str() );

		if ( !p ) {
			VoteArgumentError( va( "Could not find player named '%s'", pName.c_str() ) );
			return false;
		}

		_targetClientNum = p->entityNumber;
	}

	return _targetClientNum >= 0 && _targetClientNum < gameLocal.numClients;
}

bool q4fVoteOptionTeamPlayer::InternalDataIsValid() {
	return _targetClientNum >= 0 && _targetClientNum < gameLocal.numClients && GET_PLAYER( _targetClientNum );
}

//-------------------------
// kick player
//-------------------------
void q4fVoteOptionKickPlayer::Execute( void ) {
	assert( !gameLocal.isClient );

	if ( _targetClientNum < 0 || _targetClientNum >= gameLocal.numClients ) {
		common->DPrintf( "q4fVoteOptionKickPlayer::Execute: bad client num %d\n", _targetClientNum );
		return;
	}

	cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "kick %i", _targetClientNum ) );
}

//-------------------------
// change class
//-------------------------
void q4fVoteOptionClassChange::Execute( void ) {
	assert( !gameLocal.isClient );

	if ( _targetClientNum < 0 || _targetClientNum >= gameLocal.numClients ) {
		common->DPrintf( "q4fVoteOptionKickPlayer::Execute: bad client num %d\n", _targetClientNum );
		return;
	}

	idPlayer* p = GET_PLAYER( _targetClientNum );

	if ( !p ) {
		common->DPrintf( "q4fVoteOptionClassChange::Execute: cannot find player num %d\n", _targetClientNum );
		return;
	}

	p->restrictedClass = p->currentPC;
	p->ServerSpectate( true );
}











