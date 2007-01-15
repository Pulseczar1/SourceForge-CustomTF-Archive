#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"
#include "../Weapon.h"
#include "../client/ClientEffect.h"
#include "../Projectile.h"

class Flamethrower : public rvWeapon {
public:

	CLASS_PROTOTYPE( Flamethrower );

	Flamethrower ( void );
	~Flamethrower ( void );

	virtual void		Spawn					( void );


protected:

	void				StartIdleEffect( void );
	void				StopIdleEffect( void );
	void				StartFireEffect( void );
	void				StopFireEffect( void );

	fxPtr				idleEffectWorld;
	fxPtr				fireEffectWorld;
	fxPtr				idleEffectView;
	fxPtr				fireEffectView;
	
private:

	
	void					State_Idle				( void );
	void					State_Fire				( void );
};

CLASS_DECLARATION( rvWeapon, Flamethrower )
END_CLASS

/*
================
Flamethrower::Flamethrower
================
*/
Flamethrower::Flamethrower ( void ) {
	idleEffectWorld		= NULL;
	fireEffectWorld		= NULL;
	idleEffectView		= NULL;
	fireEffectView		= NULL;
}

/*
================
Flamethrower::~Flamethrower
================
*/
Flamethrower::~Flamethrower ( void ) {
	StopIdleEffect();
	StopFireEffect();
}


/*
================
Flamethrower::Spawn
================
*/
void Flamethrower::Spawn ( void ) {
	
	idleEffectWorld		= NULL;
	fireEffectWorld		= NULL;
	idleEffectView		= NULL;
	fireEffectView		= NULL;
}

void Flamethrower::StartIdleEffect( void ) {
	if ( viewModel && !idleEffectView ) {
		idleEffectView = viewModel->PlayEffect( "fx_idle", flashJointView, true );
	}
	if ( worldModel && !idleEffectWorld ) {
		idleEffectWorld = worldModel->PlayEffect( "fx_idle", flashJointWorld, true );
	}
}

void Flamethrower::StopIdleEffect( void ) {
	if ( idleEffectView ) {
		idleEffectView->Stop();
		idleEffectView = NULL;
	}

	if ( idleEffectWorld ) {
		idleEffectWorld->Stop();
		idleEffectWorld = NULL;
	}
}

void Flamethrower::StartFireEffect( void ) {
	if ( viewModel && !fireEffectView ) {
		fireEffectView = viewModel->PlayEffect( "fx_fire", flashJointView, true );
	}
	if ( worldModel ) {
		if ( !fireEffectWorld ) {
			fireEffectWorld = worldModel->PlayEffect( "fx_fire", flashJointWorld, true );
		}
	}

	StartSound( "snd_fire_start", SND_CHANNEL_BODY, 0, false, NULL );
	StartSound( "snd_fire_loop", SND_CHANNEL_AMBIENT, 0, false, NULL );
}

void Flamethrower::StopFireEffect( void ) {
	if ( fireEffectView ) {
		fireEffectView->Stop();
		fireEffectView = NULL;
	}

	if ( fireEffectWorld ) {
		fireEffectWorld->Stop();
		fireEffectWorld = NULL;
	}

	StopSound( SND_CHANNEL_AMBIENT, false );
}

/*
===============================================================================

	States 

===============================================================================
*/

void Flamethrower::State_Idle() {
	enum {
		STAGE_INIT = 0,
		STAGE_WAIT,
	};	
	switch ( currentStage ) {
		case STAGE_INIT:

			if ( !AmmoAvailable( ) ) {
				SetStatus( WP_OUTOFAMMO );
				StopIdleEffect();
			} else {
				SetStatus( WP_READY );
				StartIdleEffect();
			}

			StopFireEffect();

			wsfl.attackPressed = false;

			PlayCycle( ANIMCHANNEL_ALL, "idle" );
		
			SetStage( STAGE_WAIT );
			return;
		
		case STAGE_WAIT:			
			if ( gameLocal.time >= nextAttackTime && wsfl.lowerWeapon ) {
				SetState( WEAP_STATE_LOWER );
				return;
			}

			if ( !AmmoAvailable( ) ) {
				SetStatus( WP_OUTOFAMMO );
				StopIdleEffect();
				return;
			}

			if ( wsfl.attack && gameLocal.time >= nextAttackTime ) {
				if ( owner->GetPhysics()->GetWaterLevel() >= WATERLEVEL_HEAD ) {
					nextAttackTime = gameLocal.time + fireRate;
					StartSound( "snd_noAmmo", SND_CHANNEL_WEAPON, 0, false, NULL );
					return;
				}

				StopIdleEffect();
				StartFireEffect();
				SetState( WEAP_STATE_FIRE );
			}

			return;
	}
	
	StateError( "Unknown stage #" );
}

void Flamethrower::State_Fire() {

	enum {
		STAGE_INIT,
		STAGE_WAIT,
	};	

	switch ( currentStage ) {
		case STAGE_INIT:

			if ( wsfl.lowerWeapon ) {
				SetState( WEAP_STATE_LOWER );
				return;
			}

			nextAttackTime = gameLocal.time + fireRate;

			if ( owner->GetPhysics()->GetWaterLevel() >= WATERLEVEL_HEAD ) {
				StartSound( "snd_noAmmo", SND_CHANNEL_WEAPON, 0, false, NULL );
				SetStage( STAGE_WAIT );
				return;
			}

			Attack( num_attacks );
			PlayAnim( ANIMCHANNEL_ALL, "fire", 0 );	
			SetStage( STAGE_WAIT );
			return;
	
		case STAGE_WAIT:

			if ( gameLocal.time >= nextAttackTime ) {
				if ( wsfl.attack && AmmoInClip() ) {
					SetStage( STAGE_INIT );
				}
				else {
					SetState( WEAP_STATE_IDLE );
				}
			}

			return;
	}
	
	StateError( "Unknown stage #" );
}
