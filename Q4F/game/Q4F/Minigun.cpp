#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"
#include "../Weapon.h"
#include "../client/ClientEffect.h"
#include "../Projectile.h"

// Available drum speeds
const int NAILGUN_DRUMSPEED_STOPPED		= 0;
const int NAILGUN_DRUMSPEED_SLOW		= 1;
const int NAILGUN_DRUMSPEED_FAST		= 2;

// Spinup and spindown times
const int NAILGUN_SPINDOWN_TIME			= 1000;
const int NAILGUN_SPINUP_TIME			= 800;

// Nailgun shader parms
const int NAILGUN_SPARM_PLAYLEADIN		= 7;

const int NAILGUN_SPIN_SNDCHANNEL		= SND_CHANNEL_BODY2;

class Minigun : public rvWeapon {
public:

	CLASS_PROTOTYPE( Minigun );

	Minigun ( void );
	~Minigun ( void );

	virtual void		Spawn					( void );
	virtual void		Think					( void );


protected:

	jointHandle_t						jointDrumView;
	jointHandle_t						jointPinsView;
	jointHandle_t						jointSteamRightView;
	jointHandle_t						jointSteamLeftView;

	jointHandle_t						jointGuideEnt;
	
	int									drumSpeed;
	int									drumSpeedIdeal;
	float								drumMultiplier;

	virtual int				GetSpeedLimit();

	float					heatMax;
	float					heatPerTic;
	float					heatPerShot;
	float					heat;
	
private:

	bool					AllowFire( void );

	float					GetHeat( void );

	bool				DrumSpin				( int speed, int blendFrames );

	stateResult_t		State_Idle				( const stateParms_t& parms );
	stateResult_t		State_Fire				( const stateParms_t& parms );

	stateResult_t		State_DrumSpinDown		( const stateParms_t& parms );
	stateResult_t		State_DrumSpinUp		( const stateParms_t& parms );

	stateResult_t		Frame_ClaspOpen			( const stateParms_t& parms );
	stateResult_t		Frame_ClaspClose		( const stateParms_t& parms );	
	
	CLASS_STATES_PROTOTYPE ( Minigun );
};

CLASS_DECLARATION( rvWeapon, Minigun )
END_CLASS

/*
================
Minigun::Minigun
================
*/
Minigun::Minigun ( void ) {
}

/*
================
Minigun::~Minigun
================
*/
Minigun::~Minigun ( void ) {
	if( viewModel ) {
		viewModel->StopSound( NAILGUN_SPIN_SNDCHANNEL, false );
	}
}


/*
================
Minigun::Spawn
================
*/
void Minigun::Spawn ( void ) {
	
	jointDrumView		= viewAnimator->GetJointHandle ( spawnArgs.GetString ( "joint_view_drum" ) );
	jointPinsView		= viewAnimator->GetJointHandle ( spawnArgs.GetString ( "joint_view_pins" ) );
	jointSteamRightView = viewAnimator->GetJointHandle ( spawnArgs.GetString ( "joint_view_steamRight" ) );
	jointSteamLeftView  = viewAnimator->GetJointHandle ( spawnArgs.GetString ( "joint_view_steamLeft" ) );

	jointGuideEnt		= INVALID_JOINT;
	
	drumSpeed		= NAILGUN_DRUMSPEED_STOPPED;
	drumSpeedIdeal	= drumSpeed;
	drumMultiplier	= spawnArgs.GetFloat ( "drumSpeed" );

	heat			= 0.0f;
	heatMax			= spawnArgs.GetFloat( "max_heat", "300" );
	heatPerTic		= spawnArgs.GetFloat( "heat_per_tic", "5" );
	heatPerShot		= spawnArgs.GetFloat( "heat_per_shot", "5" );
	
	ExecuteState ( "ClaspClose" );	
	SetState ( "Raise", 0 );
}

void Minigun::Think() {
	rvWeapon::Think();

	heat = idMath::ClampFloat( 0.0f, heatMax, heat - heatPerTic );

	guiPercent = GetHeat();
}

/*
================
Minigun::DrumSpin

Set the drum spin speed 
================
*/
bool Minigun::DrumSpin ( int speed, int blendFrames ) {
	// Dont bother if the drum is already spinning at the desired speed
	if ( drumSpeedIdeal == speed ) {
		return false;
	}

	drumSpeedIdeal = speed;

	switch ( speed ) {
		case NAILGUN_DRUMSPEED_STOPPED:
			viewModel->StopSound ( NAILGUN_SPIN_SNDCHANNEL, false );
			viewAnimator->SetJointAngularVelocity ( jointDrumView, idAngles(0,0,0), gameLocal.time, 250 );
			viewAnimator->SetJointAngularVelocity ( jointPinsView, idAngles(0,0,0), gameLocal.time, 250 );
		
			// Spin the barrel down if we were spinning fast
			if ( drumSpeed == NAILGUN_DRUMSPEED_FAST ) {
				PostState ( "DrumSpinDown", blendFrames );
				return true;
			}
			break;
			
		case NAILGUN_DRUMSPEED_SLOW:
			viewAnimator->SetJointAngularVelocity ( jointDrumView, idAngles(0,0,45), gameLocal.time, NAILGUN_SPINDOWN_TIME );
			viewAnimator->SetJointAngularVelocity ( jointPinsView, idAngles(0,0,-35), gameLocal.time, NAILGUN_SPINDOWN_TIME );		
			viewModel->StopSound ( NAILGUN_SPIN_SNDCHANNEL, false );
			viewModel->StartSound ( "snd_spinslow", NAILGUN_SPIN_SNDCHANNEL, 0, false, NULL );		

			// Spin the barrel down if we were spinning fast		
			if ( drumSpeed == NAILGUN_DRUMSPEED_FAST ) {
				PostState ( "DrumSpinDown", blendFrames );
				return true;
			}
			break;
		
		case NAILGUN_DRUMSPEED_FAST:
			// Start the barrel spinning faster
			viewAnimator->SetJointAngularVelocity ( jointDrumView, idAngles(0,0,360.0f * drumMultiplier), gameLocal.time, NAILGUN_SPINUP_TIME );
			viewAnimator->SetJointAngularVelocity ( jointPinsView, idAngles(0,0,-300.0f * drumMultiplier), gameLocal.time, NAILGUN_SPINUP_TIME );
			nextAttackTime = gameLocal.time + NAILGUN_SPINUP_TIME;

			PostState ( "DrumSpinUp", blendFrames );
			return true;
	}
	
	drumSpeed = drumSpeedIdeal;
	
	return false;
}

/*
===============================================================================

	States 

===============================================================================
*/

CLASS_STATES_DECLARATION ( Minigun )
	STATE ( "Idle",							Minigun::State_Idle)
	STATE ( "Fire",							Minigun::State_Fire )
	STATE ( "DrumSpinDown",					Minigun::State_DrumSpinDown )
	STATE ( "DrumSpinUp",					Minigun::State_DrumSpinUp )
	
	STATE ( "ClaspOpen",					Minigun::Frame_ClaspOpen )
	STATE ( "ClaspClose",					Minigun::Frame_ClaspClose )
END_CLASS_STATES


/*
================
Minigun::State_Idle

Manage the idle state of the weapon
================
*/
stateResult_t Minigun::State_Idle( const stateParms_t& parms ) {
	enum {
		STAGE_INIT,
		STAGE_WAIT,
	};	
	switch ( parms.stage ) {
		case STAGE_INIT:
			if ( !AmmoInClip ( ) ) {
				SetStatus ( WP_OUTOFAMMO );
			} else {
				SetStatus ( WP_READY );
			}			
			// Do we need to spin the drum down?
			if ( DrumSpin ( NAILGUN_DRUMSPEED_SLOW, parms.blendFrames ) ) {
				PostState ( "Idle", parms.blendFrames );
				return SRESULT_DONE;
			}
				
			PlayCycle( ANIMCHANNEL_LEGS, "idle", parms.blendFrames );
			return SRESULT_STAGE ( STAGE_WAIT );

		case STAGE_WAIT:
			if ( wsfl.lowerWeapon ) {
				SetState ( "Lower", 4 );
				return SRESULT_DONE;
			}
		
			if ( !ClipSize() ) {
				if ( gameLocal.time > nextAttackTime && wsfl.attack && AmmoAvailable ( ) ) {
					SetState ( "Fire", 0 );
					return SRESULT_DONE;
				}
			} else {
				if ( gameLocal.time > nextAttackTime && wsfl.attack && AmmoInClip ( ) ) {
					SetState ( "Fire", 0 );
					return SRESULT_DONE;
				}  
				if ( wsfl.attack && AutoReload() && !AmmoInClip ( ) && AmmoAvailable () ) {
					SetState ( "Reload", 4 );
					return SRESULT_DONE;			
				}
				if ( wsfl.netReload || (wsfl.reload && AmmoInClip() < ClipSize() && AmmoAvailable()>AmmoInClip()) ) {
					SetState ( "Reload", 4 );
					return SRESULT_DONE;			
				}				
			}
			return SRESULT_WAIT;
	}
	return SRESULT_ERROR;
}

/*
================
Minigun::State_Fire

Fire the weapon
================
*/
stateResult_t Minigun::State_Fire( const stateParms_t& parms ) {
	enum {
		STAGE_INIT,
		STAGE_FIRE,
		STAGE_FIREWAIT,
		STAGE_DONE,
		STAGE_SPINEMPTY,		
	};	
	switch ( parms.stage ) {
		case STAGE_INIT:
			if ( !wsfl.attack ) {
				SetState ( "Idle", parms.blendFrames );				
				return SRESULT_DONE;
			}
			if ( DrumSpin ( NAILGUN_DRUMSPEED_FAST, 2 ) ) {
				PostState ( "Fire", 2 );
				return SRESULT_DONE;
			}

			nextAttackTime = gameLocal.time;

			if (  !AllowFire() ) {
				return SRESULT_STAGE( STAGE_FIREWAIT );
			}

			return SRESULT_STAGE ( STAGE_FIRE );
			
		case STAGE_FIRE:
			if ( !wsfl.attack || wsfl.reload || wsfl.lowerWeapon || AmmoInClip ( ) <= 0 ) {
				return SRESULT_STAGE ( STAGE_DONE );
			}
			PlayCycle ( ANIMCHANNEL_LEGS, "fire_fast", 4 );

			heat = idMath::ClampFloat( 0.0f, heatMax, heat + heatPerShot );

			Attack( num_attacks, 0.0f, 1.0f, GetHeat() );
			nextAttackTime = gameLocal.time + (fireRate);
			
			// Play the exhaust effects
			viewModel->PlayEffect ( "fx_exhaust", jointSteamRightView, false );
			viewModel->PlayEffect ( "fx_exhaust", jointSteamLeftView, false );

			//viewModel->StartSound ( "snd_fire", SND_CHANNEL_WEAPON,	0, false, NULL );
			viewModel->StartSound ( "snd_fireStereo", SND_CHANNEL_ITEM, 0, false, NULL ); 
					
			return SRESULT_STAGE ( STAGE_FIREWAIT );

		case STAGE_FIREWAIT:
			if ( !wsfl.attack || wsfl.reload || wsfl.lowerWeapon || AmmoInClip ( ) <= 0 ) {
				return SRESULT_STAGE ( STAGE_DONE );
			}

			if ( AllowFire() && gameLocal.time >= nextAttackTime ) {
				return SRESULT_STAGE ( STAGE_FIRE );
			}
			return SRESULT_WAIT;
			
		case STAGE_DONE:
			if ( ClipSize() && wsfl.attack && !wsfl.lowerWeapon && !wsfl.reload ) {
				PlayCycle ( ANIMCHANNEL_LEGS, "spinempty", 4 );
				return SRESULT_STAGE ( STAGE_SPINEMPTY );
			}
			DrumSpin ( NAILGUN_DRUMSPEED_SLOW, 4 );
			if ( !wsfl.attack && !AmmoInClip() && AmmoAvailable() && AutoReload ( ) && !wsfl.lowerWeapon ) {
				PostState ( "Reload", 4 );
			} else {
				PostState ( "Idle", 4 );
			}
			return SRESULT_DONE;
			
		case STAGE_SPINEMPTY:
			if ( !wsfl.attack || wsfl.reload || wsfl.lowerWeapon ) {
				return SRESULT_STAGE ( STAGE_DONE );
			}
			return SRESULT_WAIT;
	}
	return SRESULT_ERROR;
}

/*
================
Minigun::State_DrumSpinUp

Spin the drum from a slow speed to a fast speed
================
*/
stateResult_t Minigun::State_DrumSpinUp ( const stateParms_t& parms ) {
	enum {
		STAGE_INIT,
		STAGE_WAIT,
	};	
	switch ( parms.stage ) {
		case STAGE_INIT:
			viewModel->StartSound ( "snd_spinup", NAILGUN_SPIN_SNDCHANNEL, 0, false, NULL);
			PlayAnim ( ANIMCHANNEL_LEGS, "spinup", 4 );
			return SRESULT_STAGE(STAGE_WAIT);
		
		case STAGE_WAIT:
			if ( AnimDone ( ANIMCHANNEL_LEGS, 0 ) ) {
				viewModel->StartSound ( "snd_spinfast", NAILGUN_SPIN_SNDCHANNEL, 0, false, NULL );
				drumSpeed = drumSpeedIdeal;
				return SRESULT_DONE;
			}
			if ( !wsfl.attack ) {
				int oldSpeed = drumSpeed;
				drumSpeed = drumSpeedIdeal;
				DrumSpin ( oldSpeed, 0 );
				return SRESULT_DONE;
			}
			return SRESULT_WAIT;
	}
	return SRESULT_ERROR;
}

/*
================
Minigun::State_DrumSpinDown

Spin the drum down from a faster speed
================
*/
stateResult_t Minigun::State_DrumSpinDown ( const stateParms_t& parms ) {
	enum {
		STAGE_INIT,
		STAGE_WAIT,
	};	
	switch ( parms.stage ) {
		case STAGE_INIT:
			viewModel->StartSound ( "snd_spindown", SND_CHANNEL_ANY, 0, false, 0 );

			// Spin down animation	
			PlayAnim( ANIMCHANNEL_LEGS, "spindown", parms.blendFrames );
			return SRESULT_STAGE ( STAGE_WAIT );
			
		case STAGE_WAIT:
			if ( AnimDone ( ANIMCHANNEL_LEGS, 4 ) ) {
				drumSpeed = drumSpeedIdeal;
				return SRESULT_DONE;
			}
			if ( wsfl.lowerWeapon ) {
				viewModel->StopSound ( NAILGUN_SPIN_SNDCHANNEL, false );
				SetState ( "Lower", 4 );
				return SRESULT_DONE;
			}
			if ( wsfl.attack && AmmoInClip ( ) ) {
				viewModel->StopSound ( NAILGUN_SPIN_SNDCHANNEL, false );
				SetState ( "Fire", 4 );
				return SRESULT_DONE;
			}
			if ( wsfl.netReload || (wsfl.reload && AmmoAvailable() > AmmoInClip() && AmmoInClip() < ClipSize()) ) {
				SetState ( "Reload", 4 );
				return SRESULT_DONE;
			}
			return SRESULT_WAIT;
	}
	return SRESULT_ERROR;
}

/*
================
Minigun::Frame_ClaspOpen

Open the clasp that holds in the clips
================
*/
stateResult_t Minigun::Frame_ClaspOpen ( const stateParms_t& parms ) {
	PlayAnim ( ANIMCHANNEL_TORSO, "clasp_open", 0 );
	return SRESULT_OK;
}

/*
================
Minigun::Frame_ClaspOpen

Close the clasp that holds in the clips and make sure to use the
correct positioning depending on whether you have one or two clips
in the gun.
================
*/
stateResult_t Minigun::Frame_ClaspClose ( const stateParms_t& parms ) {
	PlayAnim( ANIMCHANNEL_TORSO, "clasp_2clip", 0 );
	return SRESULT_OK;
}



#define MAX_MOVE_SPEED 100.0f
#define MAX_FIRE_SPEED 5.0f

int Minigun::GetSpeedLimit() {
	if ( !wsfl.attack ) {
		return idMath::INT_MAX;
	}

	float speed = GetOwnerSpeed();

	if ( speed <= MAX_MOVE_SPEED ) {
		return (int)MAX_MOVE_SPEED;
	}
	else {
		return (int)(speed) - 5.0f;
	}
}

bool Minigun::AllowFire() {
	if ( !OwnerHasGroundContacts() )
		return false;

	float speed = GetOwnerSpeed();
	if ( speed > MAX_FIRE_SPEED )
		return false;

	return true;

}

float Minigun::GetHeat() {
	float heatp = idMath::ClampFloat( 0.0f, 1.0f, heat / heatMax );

	return heatp;
}
