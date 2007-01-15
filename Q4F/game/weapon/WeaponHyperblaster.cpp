#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"
#include "../Weapon.h"

const int HYPERBLASTER_SPARM_BATTERY = 6;
const int HYPERBLASTER_SPIN_SPEED	 = 300;

class HyperBlaster : public rvWeapon {
public:

	CLASS_PROTOTYPE( HyperBlaster );

	HyperBlaster ( void );

	virtual void			Spawn				( void );

protected:

	jointHandle_t			jointBatteryView;
	bool					spinning;

	void					SpinUp				( void );
	void					SpinDown			( void );

private:

	void				State_Idle				( void );
	void				State_Fire				( void );
};

CLASS_DECLARATION( rvWeapon, HyperBlaster )
END_CLASS

/*
================
HyperBlaster::HyperBlaster
================
*/
HyperBlaster::HyperBlaster ( void ) {
}

/*
================
HyperBlaster::Spawn
================
*/
void HyperBlaster::Spawn ( void ) {
	jointBatteryView = viewAnimator->GetJointHandle ( spawnArgs.GetString ( "joint_view_battery" ) );
	spinning		 = false;
}

/*
================
HyperBlaster::SpinUp
================
*/
void HyperBlaster::SpinUp ( void ) {
	if ( spinning ) {
		return;
	}
	
	if ( jointBatteryView != INVALID_JOINT ) {
		viewAnimator->SetJointAngularVelocity ( jointBatteryView, idAngles(0,HYPERBLASTER_SPIN_SPEED,0), gameLocal.time, 50 );
	}

	StopSound ( SND_CHANNEL_BODY2, false );
	StartSound ( "snd_battery_spin", SND_CHANNEL_BODY2, 0, false, NULL );
	spinning = true;
}

/*
================
HyperBlaster::SpinDown
================
*/
void HyperBlaster::SpinDown	( void ) {
	if ( !spinning ) {
		return;
	}
	
	StopSound ( SND_CHANNEL_BODY2, false );
	StartSound ( "snd_battery_spindown", SND_CHANNEL_BODY2, 0, false, NULL );

	if ( jointBatteryView != INVALID_JOINT ) {
		viewAnimator->SetJointAngularVelocity ( jointBatteryView, idAngles(0,0,0), gameLocal.time, 500 );
	}

	spinning = false;
}

/*
===============================================================================

	States 

===============================================================================
*/

/*
================
HyperBlaster::State_Idle
================
*/
void HyperBlaster::State_Idle( ) {
	enum {
		STAGE_INIT,
		STAGE_WAIT,
	};	
	switch ( currentStage ) {
		case STAGE_INIT:
			if ( !AmmoAvailable ( ) ) {
				SetStatus ( WP_OUTOFAMMO );
			} else {
				SetStatus ( WP_READY );
			}

			SpinDown ( );

			viewModel->SetShaderParm ( HYPERBLASTER_SPARM_BATTERY, 1.0f );

			PlayCycle( ANIMCHANNEL_ALL, "idle" );
			SetStage( STAGE_WAIT );
			return;
		
		case STAGE_WAIT:			
			if ( wsfl.lowerWeapon ) {
				SetState( WEAP_STATE_LOWER );
			}		
			else if ( gameLocal.time > nextAttackTime && wsfl.attack && AmmoAvailable ( ) ) {
				SetState( WEAP_STATE_FIRE );
			} 

			return;
	}
	
	StateError( "Unknown stage #" );
}

/*
================
HyperBlaster::State_Fire
================
*/
void HyperBlaster::State_Fire () {
	enum {
		STAGE_INIT,
		STAGE_WAIT,
	};	
	switch ( currentStage ) {
		case STAGE_INIT:
			SpinUp ( );
			nextAttackTime = gameLocal.time + fireRate;
			Attack ();
			viewModel->SetShaderParm ( HYPERBLASTER_SPARM_BATTERY, 1.0f );	
			PlayAnim ( ANIMCHANNEL_ALL, "fire" );	
			SetStage( STAGE_WAIT );
			return;
	
		case STAGE_WAIT:		
			if ( wsfl.attack && gameLocal.time >= nextAttackTime && AmmoInClip() && !wsfl.lowerWeapon ) {
				SetStage( STAGE_INIT );
			}
			else if ( (!wsfl.attack || !AmmoInClip() || wsfl.lowerWeapon) && AnimDone ( ANIMCHANNEL_ALL, 0 ) ) {
				SetState( WEAP_STATE_IDLE );
			}		
			return;
	}
	
	StateError( "Unknown stage #" );
}

			
