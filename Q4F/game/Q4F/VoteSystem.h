#ifndef __Q4F_VOTE_H__
#define __Q4F_VOTE_H__


typedef enum {
	CLIENT_VOTE_UNDECIDED = 0,
	CLIENT_VOTE_YES,
	CLIENT_VOTE_NO
} clientVoteStatus_t;

typedef struct {
	int					numVotesYes;
	int					numVotesNo;
	int					numPlayers;
} clientVoteTotals_t;

typedef struct {
	clientVoteStatus_t		vote;
	int						numVotesCalledPass;
	int						numVotesCalledFailed;
	int						lastVoteFailTime;
	int						lastVoteCastTime;
} clientVoteData_t;

/*
===============================================================================

	Vote Options

===============================================================================
*/



// base class for all vote options
class q4fVoteOption {

public:

									q4fVoteOption( void );

	virtual bool				Start( void );
	virtual void				Stop( void ) { _voteStartTime = 0; };
	virtual bool				VotePasses( clientVoteData_t clientVotes[ MAX_CLIENTS ] );
							
									// execute the action associated with this vote
	virtual void				Execute( void ) {};

	virtual const char*			GetName( void ) { return ""; };
	virtual const char*			GetDesc( void ) { return ""; };

	bool						VoteInProgress( void ) { return _voteStartTime > 0; };
	int							VoteStartTime( void ) { return _voteStartTime; };
	int							VoteTimeRemaining( void );
	int							VoteCallerClientNum( void ) { return _voteClientNum; };

									// pack out data into the msg
	virtual void				PackData( idBitMsg &msg );

									// returns true if the data read is valid
	virtual bool				ReadData( int clientWhoCalledVote, const idBitMsg &msg );
	virtual bool				ReadData( int clientWhoCalledVote, const idCmdArgs &args );

	void						SetID( int newID ) { _id = newID; };
	int							GetID( void ) { return _id; };

protected:

	virtual void				GatherVoteData( clientVoteData_t clientVotes[ MAX_CLIENTS ], clientVoteTotals_t &voteTotals );
	virtual bool				VotePasses( clientVoteTotals_t &voteTotals, bool timeIsUp );
	virtual void				VoteArgumentError( const char* err );

	bool						InternalDataIsValid( void );

	int							_voteClientNum;
	int							_voteStartTime;
	int							_voteTime;

private:

	int							_id;
};

// base class for all vote options that have preferences for the team
class q4fVoteOptionTeam : public q4fVoteOption {
public:

									q4fVoteOptionTeam( void );

	virtual bool				VotePasses( clientVoteData_t clientVotes[ MAX_CLIENTS ] );

	virtual void				PackData( idBitMsg &msg );
	virtual bool				ReadData( int clientWhoCalledVote, const idBitMsg &msg );
	virtual bool				ReadData( int clientWhoCalledVote, const idCmdArgs &args ) \
	{ return q4fVoteOption::ReadData( clientWhoCalledVote, args ); };

protected:

	bool							InternalDataIsValid( void );

	virtual void				GatherVoteData( clientVoteData_t clientVotes[ MAX_CLIENTS ], clientVoteTotals_t &teamVotes, clientVoteTotals_t &totalVotes );

	int							_preferredTeam;
};

// base class for options related to players
// preference is given to player's team
class q4fVoteOptionTeamPlayer : public q4fVoteOptionTeam {
public:

									q4fVoteOptionTeamPlayer( void );

	virtual int					GetTargetClientNum( void ) { return _targetClientNum; };

	virtual void				PackData( idBitMsg &msg );
	virtual bool				ReadData( int clientWhoCalledVote, const idBitMsg &msg );
	virtual bool				ReadData( int clientWhoCalledVote, const idCmdArgs &args );

protected:

	bool							InternalDataIsValid();

	int							_targetClientNum;
};

class q4fVoteOptionKickPlayer : public q4fVoteOptionTeamPlayer {

public:

	virtual const char*		GetName( void ) { return "kick"; };
	virtual const char*		GetDesc( void ) { return "Kick a player from the game. Voting preference is given to the player's team."; };

	virtual void				Execute();
};

class q4fVoteOptionClassChange : public q4fVoteOptionTeamPlayer {

public:

	virtual const char*		GetName( void ) { return "changeclass"; };
	virtual const char*		GetDesc( void ) { return "Force a player to change classes. Voting preference is given to the player's team."; };

	virtual void				Execute();
};



/*
===============================================================================

	Vocting System

===============================================================================
*/


class q4fVoteSys {
public:

									q4fVoteSys( void );
	
	void							Startup( void );
	void							Shutdown( void );
	void							Run( void );

	void							ClearVote( bool justVoteStatus );
	void							ClearClientVote( int clientNum );

	void							RequestVoteStart( int clientNum, const idCmdArgs &args );
	static void						RequestVoteStart_f( const idCmdArgs &args );

	const char*						GetVoteOptionName( int index );

	bool							VoteInProgress( void ) { return _currentVote && _currentVote->VoteInProgress(); };
private:

	void							RegisterVoteClasses( void );
	void							RegisterVoteClass( q4fVoteOption* option );
	void							ProcessVoteRequest( int clientNum, q4fVoteOption* option );
	void							ReceiveVoteRequest( int clientNum, const idBitMsg &msg );

	void							VoteSuccess();
	void							VoteFailure();

	clientVoteData_t				_clientVoteData[ MAX_CLIENTS ];

	bool							_bStarted;
	idList<q4fVoteOption*>			_listVotes;
	
	q4fVoteOption*					_currentVote;
};

#endif