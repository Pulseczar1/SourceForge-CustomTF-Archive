#include "../../../idlib/precompiled.h"
#pragma hdrstop

#include "../../Game_local.h"

const idEventDef EV_SetState				( "setState",			"dfE",	 NULL );			// state, delay, activator
const idEventDef EV_SetStateNoScript		( "setStateNoScript",	"dfE",	 NULL );			// state, delay, activator
const idEventDef EV_ForceState				( "forceState",			"dfE",	 NULL );			// state, delay, activator
const idEventDef EV_ClearState				( "clearNextState",		NULL,	 NULL );			//
const idEventDef EV_NextState				( "<nextState>",		NULL,	 NULL );

ABSTRACT_DECLARATION( idEntity, TFEntity )
	EVENT( EV_SetState,				TFEntity::Event_SetState )
	EVENT( EV_SetStateNoScript,		TFEntity::Event_SetStateNoScript )
	EVENT( EV_ForceState,			TFEntity::Event_ForceState )
	EVENT( EV_NextState,			TFEntity::Event_NextState )
	EVENT( EV_ClearState,			TFEntity::Event_ClearState )
END_CLASS

#define MAX_STATES_PER_FRAME 5

TFEntity::TFEntity() {

	frameStateCount = 0;
	myState = TFSTATE_DISABLED;
	lastStateChangeTime = 0;
}

void TFEntity::Spawn() {

	idStr callFunc;

	memset( &nextState, 0, sizeof( nextState ) );
	
	if ( spawnArgs.GetString( "callOnInvisible", "", callFunc ) && callFunc[0] ) {
		if ( SFU_OK != func_onInvisible.Init( callFunc ) ) {
			gameLocal.Warning( "TFEntity '%s' at (%s) has callOnInvisible set to an unknown script function '%s'.", name.c_str(), 
																			GetPhysics()->GetOrigin().ToString(0), callFunc.c_str() );
		}
		else {
			func_onInvisible.SetReturnKey( "funcReturn" );
		}
	}

	if ( spawnArgs.GetString( "callOnDisable", "", callFunc ) && callFunc[0] ) {
		if ( SFU_OK != func_onDisable.Init( callFunc ) ) {
			gameLocal.Warning( "TFEntity '%s' at (%s) has callOnDisabled set to an unknown script function '%s'.", name.c_str(), 
																			GetPhysics()->GetOrigin().ToString(0), callFunc.c_str() );
		}
		else {
			func_onDisable.SetReturnKey( "funcReturn" );
		}
	}

	if ( spawnArgs.GetString( "callOnIdle", "", callFunc ) && callFunc[0] ) {
		if ( SFU_OK != func_onIdle.Init( callFunc ) ) {
			gameLocal.Warning( "TFEntity '%s' at (%s) has callOnIdle set to an unknown script function '%s'.", name.c_str(), 
																			GetPhysics()->GetOrigin().ToString(0), callFunc.c_str() );
		}
		else {
			func_onIdle.SetReturnKey( "funcReturn" );
		}
	}

	if ( spawnArgs.GetString( "callOnActive", "", callFunc ) && callFunc[0] ) {
		if ( SFU_OK != func_onActive.Init( callFunc ) ) {
			gameLocal.Warning( "TFEntity '%s' at (%s) has callOnActive set to an unknown script function '%s'.", name.c_str(), 
																			GetPhysics()->GetOrigin().ToString(0), callFunc.c_str() );
		}
		else {
			func_onActive.SetReturnKey( "funcReturn" );
		}
	}

	if ( spawnArgs.GetString( "callOnCarry", "", callFunc ) && callFunc[0] ) {
		if ( SFU_OK != func_onCarry.Init( callFunc ) ) {
			gameLocal.Warning( "TFEntity '%s' at (%s) has callOnCarry set to an unknown script function '%s'.", name.c_str(), 
																			GetPhysics()->GetOrigin().ToString(0), callFunc.c_str() );
		}
		else {
			func_onCarry.SetReturnKey( "funcReturn" );
		}
	}

	if ( !gameLocal.isClient ) {
		PostEventMS( &EV_ForceState, 0, GetStateFromString( spawnArgs.GetString( "startstate", "idle" ) ), 0.0f, NULL );
	}
}

bool TFEntity::CallScript( rvScriptFuncUtility &utility, idEntity* activator ) {

	if ( !utility.GetFunc() ) {			// no script to load, allow state change
		return true;
	}

	idDict returnArgs;

	utility.InsertFloat( (float)myState, 0 );
	utility.InsertEntity( this, 1 );
	utility.InsertEntity( activator ? activator : gameLocal.world, 2 );
	utility.CallFunc( &returnArgs );

	return returnArgs.GetBool( "funcReturn", "1" );
}

void TFEntity::SetState( tfstate_t newState, bool force, bool callScript, idEntity* activator, float delay ) {
	assert( !gameLocal.isClient );
	if ( !IsValidState( newState ) ) {
		gameLocal.Warning( "SetState: unknown state # %d\n", newState );
		return;
	}

	if ( delay < 0.0f ) {
		// remove
		CancelEvents( &EV_NextState );
		Hide();
		myState = TFSTATE_INVISIBLE;
		PostEventSec( &EV_Remove, 1.0f );
		return;
	}
	else if ( delay > 0.0f ) {
		nextState.callScript = callScript;
		nextState.force = force;
		nextState.activator = activator;
		nextState.state = newState;
		nextState.time = SEC2MS( delay );
		CancelEvents( &EV_NextState );
		PostEventMS( &EV_NextState, nextState.time );
		nextState.time += gameLocal.time;
		return;
	}

	// check to make sure we're not in an infinite loop
	if ( gameLocal.time > lastStateChangeTime ) {
		frameStateCount = 0;
		lastStateChangeTime = gameLocal.time;
	}
	else {
		frameStateCount++;

		if ( frameStateCount >= MAX_STATES_PER_FRAME ) {
			gameLocal.Warning( "TFEntity::SetState - attempting to change state more than %d times in a frame... possible infinite loop?\n", MAX_STATES_PER_FRAME );
			return;
		}
	}

	// don't call our shit if we're already there
	if ( newState == myState ) {
		return;
	}

	// don't get carried if no activator
	if ( newState == TFSTATE_CARRIED && ( !activator || !activator->IsType( idPlayer::GetClassType() ) ) ) {
		gameLocal.Error( "SetState: item %s attempting to become carried without an activator.\n", GetName() );
	}

	// make sure it's a legal state change
	if ( !IsLegalStateChange( myState, newState, activator ) ) {
		gameLocal.Warning( "TFEntity::SetState - entity '%s' trying to do an illegal state change from '%s' to '%s'.\n",
								GetName(), GetStateString( myState ), GetStateString( newState ) );
		return;
	}

	if ( newState == TFSTATE_CARRIED && ( !activator || !activator->IsType( idPlayer::GetClassType() ) || ((idPlayer*)activator)->spectating ) ) {
		gameLocal.Warning( "TFEntity::SetState - entity '%s' trying to become carried with an invalid player entity '%s'\n",
								GetName(), activator ? activator->GetName() : "NULL" );
		return;
	}

	if ( ( callScript && CallScript( GetScriptForState( newState ), activator ) ) || force ) {
		OnStateChange( myState, newState, activator );
		
		myState = newState;
	}
}

// inherited by subclasses
void TFEntity::OnStateChange( tfstate_t oldState, tfstate_t newState, idEntity* activator ) {
}

rvScriptFuncUtility& TFEntity::GetScriptForState( tfstate_t state ) {
	switch( state ) {
		case TFSTATE_INVISIBLE:
			return func_onInvisible;
		case TFSTATE_DISABLED:
			return func_onDisable;
		case TFSTATE_IDLE:
			return func_onIdle;
		case TFSTATE_ACTIVE:
			return func_onActive;
		case TFSTATE_CARRIED:
			return func_onCarry;
		default:
			gameLocal.Error( "TFEntity::GetScriptForState - unkown state # %d\n", state );
			return func_onInvisible;
	}
}

const char* TFEntity::GetStateString( tfstate_t state ) {
	switch( state ) {
		case TFSTATE_INVISIBLE:
			return "INVISIBLE";
		case TFSTATE_DISABLED:
			return "DISABLED";
		case TFSTATE_IDLE:
			return "IDLE";
		case TFSTATE_ACTIVE:
			return "ACTIVE";
		case TFSTATE_CARRIED:
			return "CARRIED";
		default:
			gameLocal.Error( "TFEntity::GetStateString - unkown state # %d\n", state );
			return "ERROR";
	}
}

bool TFEntity::IsLegalStateChange( tfstate_t oldState, tfstate_t newState, idEntity* activator ) {

	switch( oldState ) {
		case MAX_TFSTATES:
			return true;
			break;

		case TFSTATE_INVISIBLE:
			if ( newState < TFSTATE_IDLE ) {
				return true;
			}
			break;

		case TFSTATE_DISABLED:
			if ( newState == TFSTATE_IDLE || newState == TFSTATE_INVISIBLE ) {
				return true;
			}
			break;

		case TFSTATE_IDLE:
			return true;
			break;

		case TFSTATE_ACTIVE:
			if ( newState == TFSTATE_IDLE || ( newState == TFSTATE_CARRIED && this->IsType( TFCarryItem::GetClassType() ) ) ) {
				return true;
			}
			break;

		case TFSTATE_CARRIED:
			if ( newState == TFSTATE_ACTIVE || newState == TFSTATE_IDLE ) {
				return true;
			}
			break;

		default:
			gameLocal.Error( "TFEntity::IsLegalStateChange - unkown state # %d\n", oldState );
			break;
	}

	return false;
}

tfstate_t TFEntity::GetStateFromString( const char* string ) {

	tfstate_t state;
	
	// common cases first
	if ( !idStr::Icmp( string, "idle" ) ) {
		return TFSTATE_IDLE;
	}
	else if ( !idStr::Icmp( string, "invisible" ) ) {
		return TFSTATE_INVISIBLE;
	}
	else if ( !idStr::Icmp( string, "disabled" ) ) {
		return TFSTATE_DISABLED;
	}
	else if ( !idStr::Icmp( string, "active" ) ) {
		return TFSTATE_ACTIVE;
	}
	else if ( !idStr::Icmp( string, "carried" ) ) {
		return TFSTATE_CARRIED;
	}
	else {
		// maybe they entered a number?
		idStr stateStr = string;
		if ( stateStr.IsNumeric() ) {
			state = (tfstate_t)atoi( string );
			if ( IsValidState( state ) ) {
				return state;
			}
		}
	}

	gameLocal.Error( "TFEntity: cannot parse state from state string '%s'\n", string );
	return TFSTATE_INVISIBLE;
}

bool TFEntity::IsValidState( tfstate_t state ) {
	if ( state < 0 || state >= MAX_TFSTATES ) {
		return false;
	}
	return true;
}

//=====================================================================================
//                script events
//=====================================================================================

void TFEntity::Event_SetState( int newState, float delay, idEntity* activator ) {
	if ( gameLocal.isClient ) {
		return;						// clients don't run setstate in scripts
	}

	tfstate_t state = (tfstate_t)newState;

	SetState( state, false, true, activator, delay );
}

void TFEntity::Event_SetStateNoScript( int newState, float delay, idEntity* activator ) {
	if ( gameLocal.isClient ) {
		return;						// clients don't run setstate in scripts
	}

	tfstate_t state = (tfstate_t)newState;

	SetState( state, true, false, activator, delay );
}

void TFEntity::Event_ForceState( int newState, float delay, idEntity* activator ) {
	if ( gameLocal.isClient ) {
		return;						// clients don't run setstate in scripts
	}

	tfstate_t state = (tfstate_t)newState;

	SetState( state, true, true, activator, delay );
}

void TFEntity::Event_NextState() {
	//assert( nextState.time <= gameLocal.time );
	SetState( nextState.state, nextState.force, nextState.callScript, nextState.activator );
}

void TFEntity::Event_ClearState() {
	CancelEvents( &EV_NextState );
}