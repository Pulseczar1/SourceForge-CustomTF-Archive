
#include "../../../idlib/precompiled.h"
#pragma hdrstop

#include "../../Game_local.h"

CLASS_DECLARATION( TFEntity, TFTrigger )
	EVENT( EV_Touch,			TFTrigger::Event_Touch )
	EVENT( EV_Activate,			TFTrigger::Event_Activate )
END_CLASS



TFTrigger::TFTrigger( void ) {
	nextTriggerTime = 0;
}

void TFTrigger::Spawn( void ) {
	GetPhysics()->SetContents( CONTENTS_TRIGGER );
	nextTriggerTime = 0;
}

//--------------------------------------------------------------------------
// Called when we are touched by something
//--------------------------------------------------------------------------
void TFTrigger::Event_Touch( idEntity *other, trace_t *trace ) {
	if ( gameLocal.isClient ) {
		return;						// clients not allowed
	}

	Event_Activate( other );
}

void TFTrigger::Event_Activate( idEntity* activator ) {

	if ( AllowActivate( activator ) ) {
		nextTriggerTime = gameLocal.time + 1;
		float wait = spawnArgs.GetFloat( "wait", ".5" );
		wait += gameLocal.random.RandomFloat() * spawnArgs.GetFloat( "random_wait", "0.0" );
		if ( wait < 0.0f )
			wait = 0.0f;
		nextTriggerTime += SEC2MS( wait );

		float delay = spawnArgs.GetFloat( "delay", "0" );
		delay += gameLocal.random.RandomFloat() * spawnArgs.GetFloat( "random_delay", "0.0" );
		if ( delay < 0.0f )
			delay = 0.0f;

		int count = spawnArgs.GetInt( "count", "-1" );
		if ( count > 0 )
			count--;
		spawnArgs.SetInt( "count", count );

		SetState( TFSTATE_ACTIVE, false, true, activator, delay );
		SetState( TFSTATE_IDLE, false, true, activator, wait );
	}
}

bool TFTrigger::AllowActivate( idEntity* activator ) {
	if ( gameLocal.isClient ) {
		return false;						// clients not allowed
	}

	if ( gameLocal.time < nextTriggerTime )
		return false;

	// if we;re disabled or invisible, don't do shit
	if ( GetCurrentState() != TFSTATE_IDLE ) {
		return false;
	}

	if ( !activator || ( activator->IsType( idPlayer::GetClassType() ) && ( static_cast<idPlayer*>(activator)->spectating ) ) ) {
		return false;
	}

	if ( spawnArgs.GetInt( "count", "-1" ) == 0 )
		return false;

	return true;
}