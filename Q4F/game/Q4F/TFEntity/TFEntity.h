#ifndef __GAME_TFENTITY_H__
#define __GAME_TFENTITY_H__

#include "../../script/ScriptFuncUtility.h"

/*
===============================================================================

	Base class for entities that can have TF states ( invisible, disabled, idle, active, carried )

===============================================================================
*/

#define BITS_FOR_TFSTATE 3

typedef enum tfstate_s {
	TFSTATE_INVISIBLE = 0,
	TFSTATE_DISABLED = 1,
	TFSTATE_IDLE = 2,
	TFSTATE_ACTIVE = 3,
	TFSTATE_CARRIED = 4,
	MAX_TFSTATES
} tfstate_t;

const int ASYNC_TFSTATE_BITS = 3;

class TFEntity : public idEntity {

	CLASS_PROTOTYPE( TFEntity );

public:
								TFEntity( void );

	void						Spawn( void );

	tfstate_t					GetCurrentState( void ) const { return myState; };

	int							TimeToNextStateChange( void ) { return nextState.time > gameLocal.time ? gameLocal.time - nextState.time : 0; };

	void						SetState( tfstate_t, bool force, bool callScript, idEntity* activator = NULL, float delay = 0.0f );

	//virtual void				WriteToSnapshot( idBitMsgDelta &msg ) const;
	//virtual void				ReadFromSnapshot( const idBitMsgDelta &msg );

protected:

	virtual void				OnStateChange( tfstate_t oldState, tfstate_t newState, idEntity* activator );
	virtual bool				AllowActivate( idEntity* entity ) { return myState < TFSTATE_IDLE ? false : true; };

private:

	bool						CallScript( rvScriptFuncUtility &utility, idEntity* activator );			// returns true if script returns true

	rvScriptFuncUtility&		GetScriptForState( tfstate_t state );
	const char*					GetStateString( tfstate_t state );
	tfstate_t					GetStateFromString( const char* string );
	bool						IsValidState( tfstate_t state );

	bool						IsLegalStateChange( tfstate_t oldState, tfstate_t newState, idEntity* activator );

	//--------------------------------------
	//       events
	//--------------------------------------
	void						Event_SetState				( int newState, float delay, idEntity* activator );
	void						Event_SetStateNoScript		( int newState, float delay, idEntity* activator );
	void						Event_ForceState			( int newState, float delay, idEntity* activator );
	void						Event_NextState				( void );
	void						Event_ClearState			( void );

	struct {
		int							time;
		tfstate_t					state;
		bool						force;
		bool						callScript;
		idEntityPtr<idEntity>		activator;
	} nextState;
	
	rvScriptFuncUtility			func_onInvisible;
	rvScriptFuncUtility			func_onDisable;
	rvScriptFuncUtility			func_onIdle;
	rvScriptFuncUtility			func_onActive;
	rvScriptFuncUtility			func_onCarry;

	int							frameStateCount;				// only allow small # of state changes per frame to prevent server crash ( infinite loops )
	int							lastStateChangeTime;

	tfstate_t					myState;
						
};

#endif