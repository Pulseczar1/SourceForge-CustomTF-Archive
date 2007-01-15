#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"
#include "../Weapon.h"

class Nailgun : public rvWeapon {
public:

	CLASS_PROTOTYPE( Nailgun );

	Nailgun ( void );
	~Nailgun ( void );

	virtual void			Spawn				( void );

protected:

	virtual void			State_Fire( void );

	virtual void			LaunchProjectiles			( const idVec3& muzzleOrigin, int num_projectiles, float fuseOffset, float power = 1.0f, float spreadScale = 1.0f );

	bool					altAttack;

	idVec3					muzzleOrgOffset0;
	idVec3					muzzleOrgOffset1;

	jointHandle_t			attackJoint0;
	jointHandle_t			attackJoint1;
};

CLASS_DECLARATION( rvWeapon, Nailgun )
END_CLASS


Nailgun::Nailgun( void ) {
}

Nailgun::~Nailgun() {
}



void Nailgun::Spawn( void ) {
	altAttack = false;

	spawnArgs.GetVector( "startOffset", "0 0 0", muzzleOrgOffset0 );
	spawnArgs.GetVector( "startOffset2", "0 0 0", muzzleOrgOffset1 );

	attackJoint0		= viewAnimator->GetJointHandle( spawnArgs.GetString ( "joint_attack_0", "barrel" ) );
	attackJoint1		= viewAnimator->GetJointHandle( spawnArgs.GetString ( "joint_attack_1", "barrel" ) );
}



void Nailgun::State_Fire() {

	enum {
		STAGE_INIT,
		STAGE_WAIT,
	};	

	switch ( currentStage ) {
		case STAGE_INIT:

			altAttack = false;

			nextAttackTime = gameLocal.time + fireRate;
			Attack();
			PlayAnim( ANIMCHANNEL_ALL, "fire", 0 );	
			SetStage( STAGE_WAIT );
			return;
	
		case STAGE_WAIT:

			if ( gameLocal.time >= nextAttackTime ) {

				if ( wsfl.attack && AmmoInClip() ) {
					if ( AnimDone( ANIMCHANNEL_ALL, 0 ) ) {
						PlayAnim( ANIMCHANNEL_ALL, "fire", 0 );
					}

					nextAttackTime = gameLocal.time + fireRate;
					Attack();

					return;
				}

				SetState( WEAP_STATE_IDLE );
			}

			return;
	}
	
	StateError( "Unknown stage #" );
}

void Nailgun::LaunchProjectiles( const idVec3& _muzzleOrigin, int num_projectiles, float fuseOffset, float power, float spreadScale ) {

	idVec3 newOrg;

	if ( !altAttack ) {
		newOrg = muzzleOrgOffset0 * playerViewAxis;
		flashJointView = attackJoint0;
	}
	else {
		newOrg = muzzleOrgOffset1 *playerViewAxis;
		flashJointView = attackJoint1;
	}

	altAttack = !altAttack;

	newOrg += _muzzleOrigin;

	rvWeapon::LaunchProjectiles( newOrg, num_projectiles, fuseOffset, power, spreadScale );
}


