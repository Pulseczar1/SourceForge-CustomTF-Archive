#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"
#include "../Weapon.h"
#include "../client/ClientEffect.h"
#include "../Projectile.h"

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
	
	virtual int				GetSpeedLimit();

	float					heatMax;
	float					heatPerTic;
	float					heatPerShot;
	float					heat;
	
private:

	bool					AllowFire( void );

	float					GetHeat( void );

	void					State_Idle				( void );
	void					State_Fire				( void );

	void					SpinUp				( void );
	void					SpinDown			( void );

	void					UpdateBarrel( void );

	float				currentRate;
	float				startRate;
	float				endRate;

	float				spinStart;
	float				spinEnd;

	idMat3				drumSpinAngle;
	idMat3				pinSpinAngle;

	float				barrelSpeed;
	float				barrelAccel;
	float				barrelDecel;

	float				rotation;

	jointHandle_t		spinner;
	jointHandle_t		world_spinner;

	bool				rotateAttack;

	float				attackDegrees;
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

	heat			= 0.0f;
	heatMax			= spawnArgs.GetFloat( "max_heat", "300" );
	heatPerTic		= spawnArgs.GetFloat( "heat_per_tic", "5" );
	heatPerShot		= spawnArgs.GetFloat( "heat_per_shot", "5" );
	
	currentRate = 0.0f;
	startRate = 0.0f;
	endRate = 0.0f;
	spinStart = 0.0f;
	spinEnd = 0.0f;
	drumSpinAngle = mat3_identity;
	pinSpinAngle = mat3_identity;

	barrelSpeed = spawnArgs.GetFloat( "barrel_speed", "35" );
	barrelAccel = barrelSpeed / ( spawnArgs.GetFloat( "barrel_accel_time", "0.01" ) + 0.00001f ) * 0.001f;
	barrelDecel = barrelSpeed / ( spawnArgs.GetFloat( "barrel_decel_time", "1.0" ) + 0.00001f ) * 0.001f;

	attackDegrees = 360.0f / spawnArgs.GetInt( "num_barrels", "1" );

	rotateAttack = false;
	rotation = 0.0f;
}

//--------------------------------------------------------------------------
// Update barrel
//--------------------------------------------------------------------------
void Minigun::UpdateBarrel() {
	float t;
	idVec3 ang;
	idMat3 angMat;

	float currentTime = (float)gameLocal.time;

	if ( currentTime < spinEnd ) {
		t = ( currentTime - spinStart ) / ( spinEnd - spinStart );
		currentRate = startRate + t * ( endRate - startRate );
	} else {
		currentRate = endRate;
	}
	
	if ( currentRate > 0.0f ) {
		t = currentRate * 0.016f;
		rotation -= t;
		drumSpinAngle.RotateRelative( 0, t );

		t *= -1.0f;

		pinSpinAngle.RotateRelative( 0, t );

		viewModel.GetEntity()->GetAnimator()->SetJointAxis( jointDrumView, JOINTMOD_LOCAL, drumSpinAngle );
		viewModel.GetEntity()->GetAnimator()->SetJointAxis( jointPinsView, JOINTMOD_LOCAL, pinSpinAngle );

		/*if ( world_spinner != INVALID_JOINT ) {
			worldModel->GetAnimator()->SetJointAxis( world_spinner, JOINTMOD_LOCAL, spinAngle );
		}*/
	}
}

void Minigun::SpinUp ( void ) {
	startRate = currentRate;
	endRate = barrelSpeed;
	spinStart = (float)gameLocal.time;
	spinEnd = spinStart + ( endRate - currentRate ) / barrelAccel;
}

void Minigun::SpinDown	( void ) {
	startRate = currentRate;
	endRate = 0.0f;
	spinStart = (float)gameLocal.time;
	spinEnd = spinStart + ( currentRate - endRate ) / barrelDecel;
	StopSound( SND_CHANNEL_BODY2, false );
}

void Minigun::Think() {
	rvWeapon::Think();

	if ( rotation <= 0.0f ) {
		rotation += attackDegrees;
		rotateAttack = true;
	}

	heat = idMath::ClampFloat( 0.0f, heatMax, heat - heatPerTic );

	guiPercent = GetHeat();
}

/*
===============================================================================

	States 

===============================================================================
*/


/*
================
Minigun::State_Idle

Manage the idle state of the weapon
================
*/
void Minigun::State_Idle() {
	enum {
		STAGE_INIT,
		STAGE_WAIT,
	};	

	rotateAttack = false;
	UpdateBarrel();

	switch ( currentStage ) {
		case STAGE_INIT:
			if ( !AmmoInClip ( ) ) {
				SetStatus ( WP_OUTOFAMMO );
			} else {
				SetStatus ( WP_READY );
			}		

			SpinDown();
			SetStage( STAGE_WAIT );

			return;

		case STAGE_WAIT:
			if ( wsfl.lowerWeapon ) {
				SetState( WEAP_STATE_LOWER );
			}
			else if ( gameLocal.time > nextAttackTime && wsfl.attack && AmmoAvailable ( ) ) {
				SetState( WEAP_STATE_FIRE );
				viewModel->StartSound ( "snd_spinup", NAILGUN_SPIN_SNDCHANNEL, 0, false, NULL);
				SpinUp();
			}

			return;
	}
	
	StateError( "Unknown stage #" );
}

/*
================
Minigun::State_Fire

Fire the weapon
================
*/
void Minigun::State_Fire() {
	enum {
		STAGE_FIREWAIT,
		STAGE_DONE
	};

	UpdateBarrel();

	switch ( currentStage ) {
			
		case STAGE_FIREWAIT:
			if ( !wsfl.attack || wsfl.lowerWeapon || AmmoInClip ( ) <= 0 ) {
				SetStage( STAGE_DONE );
				return;
			}

			if ( rotateAttack && AllowFire() ) {
				heat = idMath::ClampFloat( 0.0f, heatMax, heat + heatPerShot );
				Attack( num_attacks, 0.0f, 1.0f, GetHeat() );
				rotateAttack = false;

				// Play the exhaust effects
				viewModel->PlayEffect ( "fx_exhaust", jointSteamRightView, false );
				viewModel->PlayEffect ( "fx_exhaust", jointSteamLeftView, false );

				//viewModel->StartSound ( "snd_fire", SND_CHANNEL_WEAPON,	0, false, NULL );
				viewModel->StartSound ( "snd_fireStereo", SND_CHANNEL_ITEM, 0, false, NULL ); 
			}


			return;
			
		case STAGE_DONE:
			viewModel->StartSound ( "snd_spindown", SND_CHANNEL_ANY, 0, false, 0 );
			SetState( WEAP_STATE_IDLE );
			return;
	}
	
	StateError( "Unknown stage #" );
}

#define MAX_MOVE_SPEED 100.0f
#define MAX_FIRE_SPEED 5.0f

int Minigun::GetSpeedLimit() {
	if ( !wsfl.attack ) {
		return idMath::INT_MAX;
	}
	return (int)MAX_MOVE_SPEED;	// XavioR: fixes bug w/ minigunner where jumping resets to normal speed
/*	float speed = GetOwnerSpeed();

	if ( speed <= MAX_MOVE_SPEED ) {
		return (int)MAX_MOVE_SPEED;
	}
	else {
		return (int)(speed) - 5.0f;
	}*/
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
