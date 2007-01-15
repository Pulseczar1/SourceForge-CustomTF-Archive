//----------------------------------------------------------------
// GameState.h
//
// Copyright 2002-2005 Raven Software
//----------------------------------------------------------------

#ifndef __GAMESTATE_H__
#define __GAMESTATE_H__

#include "../Game_local.h"
#include "../MultiplayerGame.h"

/*
===============================================================================

TFGameState

===============================================================================
*/



typedef enum {
	INACTIVE = 0,						// not running
	WARMUP,								// warming up
	COUNTDOWN,							// post warmup pre-game
	GAMEON,								// game is on
	SUDDENDEATH,						// game is on but in sudden death, first frag wins
	GAMEREVIEW,							// game is over, scoreboard is up. we wait si_gameReviewPause seconds (which has a min value)
	NEXTGAME,
	STATE_COUNT
} mpGameState_t;

class TFGameState {
public:

					TFGameState( bool allocPrevious = true );
	virtual			~TFGameState( void );

					// clientNum == -1 except for SendInitialState
					// when clientNum >= 0, always send the state
	virtual void	SendState( int clientNum = -1 );
	virtual void	ReceiveState( const idBitMsg& msg );

	virtual void	SendInitialState( int clientNum );

	virtual void	PackState( idBitMsg& outMsg );
	virtual	void	WriteState( idBitMsg &msg );

	virtual void	UnpackState( const idBitMsg& inMsg );

	virtual void	GameStateChanged( void );

	virtual void	Run( void );
	virtual void	NewState( mpGameState_t newState );

	virtual void	ClientDisconnect( idPlayer* player );
	virtual void	Spectate( idPlayer* player );

	virtual void	Clear( void );

	mpGameState_t	GetMPGameState( void ) { return currentState; }

	mpGameState_t	GetNextMPGameState( void ) { return nextState; }
	int				GetNextMPGameStateTime( void ) { return nextStateTime; }
	void			SetNextMPGameState( mpGameState_t newState ) { nextState = newState; }
	void			SetNextMPGameStateTime( int time ) { nextStateTime = time; }

	bool			operator==( const TFGameState& rhs ) const;
	bool			operator!=( const TFGameState& rhs ) const;
	TFGameState&	operator=( const TFGameState& rhs );

	void			WriteNetworkInfo( idFile *file, int clientNum );
	void			ReadNetworkInfo( idFile *file, int clientNum );

protected:
	TFGameState*	previousGameState;
	bool			trackPrevious;

	mpGameState_t	currentState;
	mpGameState_t	nextState;
	int				nextStateTime;

	int				fragLimitTimeout;
};

#endif
