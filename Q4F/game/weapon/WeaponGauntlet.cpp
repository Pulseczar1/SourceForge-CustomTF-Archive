#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"
#include "../Weapon.h"

class rvWeaponGauntlet : public rvWeapon {
public:

	CLASS_PROTOTYPE( rvWeaponGauntlet );

						rvWeaponGauntlet( void );
						~rvWeaponGauntlet( void );

	virtual void		Spawn				( void );
	virtual void		CleanupWeapon		( void );

protected:

	bool				IsBehindActor( idVec3 attackerPos, idPlayer* victim );

	idAngles			bladeSpinFast;
	idAngles			bladeSpinSlow;
	jointHandle_t		bladeJoint;
	jointHandle_t		bladeJoint_world;
	int					bladeAccel;
	
	float				range;
	
	rvClientEffectPtr	impactEffect;
	int					impactMaterial;

	void				Attack				( void );
	void				StartBlade			( void );
	void				StopBlade			( void );

	TFDamage			dmgBackStab;
	TFDamage			dmgDirect;


private:

	void				PlayLoopSound		( int sndType );
	int					loopSound;
	enum {
		LOOP_NONE,
		LOOP_WALL,
		LOOP_FLESH
	};

	virtual void		State_Idle( void );
	virtual void		State_Fire( void );

};

CLASS_DECLARATION( rvWeapon, rvWeaponGauntlet )
END_CLASS

bool rvWeaponGauntlet::IsBehindActor( idVec3 attackerPos, idPlayer* victim ) {

	idVec3 dirToAttacker = attackerPos - victim->GetEyePosition();

	return ( victim->viewAxis[0] * dirToAttacker ) < 0.0f;
}

/*
================
rvWeaponGauntlet::rvWeaponGauntlet
================
*/
rvWeaponGauntlet::rvWeaponGauntlet( void ) {
	loopSound = LOOP_NONE;
}

/*
================
rvWeaponGauntlet::~rvWeaponGauntlet
================
*/
rvWeaponGauntlet::~rvWeaponGauntlet(void)
{
	if ( viewModel ) {
		StopSound( SND_CHANNEL_WEAPON, false );
	}
	if ( impactEffect ) {
		impactEffect->Stop( );
		impactEffect = NULL;
	}
	impactMaterial = -1;

}
/*
================
rvWeaponGauntlet::Spawn
================
*/
void rvWeaponGauntlet::Spawn ( void ) {
	bladeJoint		= viewModel->GetAnimator()->GetJointHandle ( spawnArgs.GetString ( "joint_blade", "center" ) );
	bladeJoint_world= GetWorldModel()->GetAnimator()->GetJointHandle ( spawnArgs.GetString ( "joint_blade", "center" ) );

	bladeSpinFast	= spawnArgs.GetAngles ( "blade_spinfast" );
	bladeSpinSlow	= spawnArgs.GetAngles ( "blade_spinslow" );
	bladeAccel		= SEC2MS ( spawnArgs.GetFloat ( "blade_accel", ".25" ) );
	
	range			= spawnArgs.GetFloat ( "range", "32" );

	impactMaterial = -1;
	impactEffect   = NULL;
	loopSound = LOOP_NONE;

	const char* backDef = attackDef->dict.GetString( "def_damage_backstab", "" );
	if ( backDef && backDef[0] ) {
		dmgBackStab.Create( attackerInfo, backDef, 1.0f );
	}

	dmgDirect.Create( attackerInfo, attackDef->dict.GetString( "def_damage_direct", "" ), 1.0f );
}

void rvWeaponGauntlet::PlayLoopSound( int sndType ) {
	if ( loopSound == sndType ) {
		return;
	}
	const char *loopSoundString = NULL;
	switch ( sndType ) {
		case LOOP_NONE:
		default:
			loopSoundString = "snd_spin_loop";
			break;
		case LOOP_WALL:
			loopSoundString = "snd_spin_wall";
			break;
		case LOOP_FLESH:
			loopSoundString = "snd_spin_flesh";
			break;
	}
	if ( loopSoundString ) {
		loopSound = sndType;
		StartSound( loopSoundString, SND_CHANNEL_WEAPON, 0, false, 0 );
	}
}

/*
================
rvWeaponGauntlet::CleanupWeapon
================
*/
void rvWeaponGauntlet::CleanupWeapon( void ) {

	if ( impactEffect ) {
		impactEffect->Stop( );
		impactEffect = NULL;
	}
	impactMaterial = -1;
	PlayLoopSound( LOOP_NONE );
}

/*
================
rvWeaponGauntlet::Attack
================
*/
void rvWeaponGauntlet::Attack ( void ) {
	trace_t		tr;
	idEntity*	ent;

	tfStatManager->ShotFired( attackerInfo, attackDef );

	// GTR bandit: Unlagged Code
	if ( gameLocal.isServer && g_unlagged.GetBool() )
		owner->Delag( );

	int contents = MASK_SHOT_RENDERMODEL;
	if ( attackDef->dict.GetBool( "wrench", "0" ) )
		contents |= CONTENTS_WRENCH;
	
	// Cast a ray out to the lock range

// ddynerman: multiple clip worlds
	gameLocal.clip.TracePoint( tr, 
							playerViewOrigin, 
							playerViewOrigin + playerViewAxis[0] * range, 
							contents, owner );

	// GTR bandit: Unlagged Code
	if ( gameLocal.isServer && g_unlagged.GetBool() )
		owner->UndoDelag( );

	owner->WeaponFireFeedback( &weaponDef->dict );

	if ( tr.fraction >= 1.0f ) {
		if ( impactEffect ) {
			impactEffect->Stop ( );
			impactEffect = NULL;
		}
		impactMaterial = -1;
		PlayLoopSound( LOOP_NONE );
 		return;
	}
		
	// Entity we hit?
	ent = gameLocal.entities[tr.c.entityNum];

	// If the impact material changed then stop the impact effect 
	if ( (tr.c.materialType && tr.c.materialType->Index ( ) != impactMaterial) ||
		 (!tr.c.materialType && impactMaterial != -1) ) {
		if ( impactEffect ) {
			impactEffect->Stop ( );
			impactEffect = NULL;
		}
		impactMaterial = -1;
	}

	//multiplayer-- don't gauntlet dead stuff
	idPlayer * player;
	if ( ent->IsType( idPlayer::GetClassType() )) {
		player = static_cast< idPlayer* >(ent);
		if (player->health <= 0)	{
			return;
		}
	}
	
	idVec3 dir = ( tr.endpos - playerViewOrigin ).ToNormal();

	int oldHealth = ent ? ent->health : 0;
	int newHealth = oldHealth;
	
	// Do damage?
	if ( gameLocal.time > nextAttackTime ) {					
		if ( ent ) {
			if ( ent->fl.takedamage ) {
				if( ent->IsType( idPlayer::GetClassType() ) && dmgBackStab.IsValid() && IsBehindActor( playerViewOrigin, static_cast<idPlayer*>(ent) ) ) {
					dmgBackStab.SetDir( dir );
					ent->Damage_TF( dmgBackStab, 1.0f );
				}
				else {
					dmgDirect.SetDir( dir );
					ent->Damage_TF( dmgDirect, 1.0f );
				}

				newHealth = ent->health;

				if ( newHealth < oldHealth ) {
					StartSound( "snd_hit", SND_CHANNEL_ANY, 0, false, NULL );
					if ( ent->spawnArgs.GetBool( "bleed" ) ) {
						PlayLoopSound( LOOP_FLESH );
					} else {
						PlayLoopSound( LOOP_WALL );
					}
				}
			} else {
				PlayLoopSound( LOOP_WALL );
			}
		} else {
			PlayLoopSound( LOOP_NONE );
		}
		nextAttackTime = gameLocal.time + fireRate;
	}

	if ( newHealth < oldHealth ) {
		if ( !impactEffect ) {
			impactMaterial = tr.c.materialType ? tr.c.materialType->Index() : -1;
			impactEffect = gameLocal.PlayEffect ( gameLocal.GetEffect ( spawnArgs, "fx_impact", tr.c.materialType ), tr.endpos, tr.c.normal.ToMat3(), true );
		} else {
			impactEffect->SetOrigin ( tr.endpos );
			impactEffect->SetAxis ( tr.c.normal.ToMat3() );
		}
	}
}

/*
================
rvWeaponGauntlet::StartBlade
================
*/
void rvWeaponGauntlet::StartBlade ( void ) {
	if ( viewModel ) {
		viewModel->GetAnimator()->SetJointAngularVelocity ( bladeJoint, bladeSpinFast, gameLocal.time, bladeAccel ); 
	}
	
	if ( GetWorldModel() ) {	
		GetWorldModel()->GetAnimator()->SetJointAngularVelocity ( bladeJoint_world, bladeSpinFast, gameLocal.time, bladeAccel ); 
	}
	
	StopSound ( SND_CHANNEL_ITEM, false );
//	StartSound ( "snd_blade_fast", SND_CHANNEL_ITEM, 0, false, NULL );
	StartSound( "snd_spin_up", SND_CHANNEL_ITEM, 0, false, 0 );
}

/*
================
rvWeaponGauntlet::StopBlade
================
*/
void rvWeaponGauntlet::StopBlade ( void ) {
	if ( viewModel ) {
		viewModel->GetAnimator()->SetJointAngularVelocity ( bladeJoint, bladeSpinSlow, gameLocal.time, bladeAccel ); 
	}
	
	if ( GetWorldModel() ) {
		GetWorldModel()->GetAnimator()->SetJointAngularVelocity ( bladeJoint_world, bladeSpinSlow, gameLocal.time, bladeAccel ); 
	}
	
	StopSound ( SND_CHANNEL_WEAPON, false );
//	StartSound ( "snd_blade_slow", SND_CHANNEL_ITEM, 0, false, NULL );
	
	if ( impactEffect ) {
		impactEffect->Stop ( );
		impactEffect = NULL;
	}
	impactMaterial = -1;
}

void rvWeaponGauntlet::State_Idle() {	
	enum {
		IDLE_INIT,
		IDLE_WAIT,
	};	
	switch ( currentStage ) {
		case IDLE_INIT:			
			SetStatus ( WP_READY );
			StopBlade ( );
			PlayCycle( ANIMCHANNEL_ALL, "idle" );
			SetStage( IDLE_WAIT );
			return;
			
		case IDLE_WAIT:
			if ( wsfl.lowerWeapon ) {
				SetState( WEAP_STATE_LOWER );
			}
			else if ( wsfl.attack ) {
				SetState( WEAP_STATE_FIRE );
			}
			return;
	}

	StateError( "Unknown stage #" );
}


void rvWeaponGauntlet::State_Fire() {
	enum {
		STAGE_START,
		STAGE_START_WAIT,
		STAGE_LOOP,
		STAGE_LOOP_WAIT,
		STAGE_END,
		STAGE_END_WAIT
	};	

	switch ( currentStage ) {
		case STAGE_START:	
			PlayAnim ( ANIMCHANNEL_ALL, "attack_start" );
			StartBlade ( );
			loopSound = LOOP_NONE;

			SetStage( STAGE_START_WAIT );
			return;
		
		case STAGE_START_WAIT:
			if ( !wsfl.attack ) {
				SetStage( STAGE_END );
			}
			else if ( AnimDone ( ANIMCHANNEL_ALL ) ) {
				SetStage( STAGE_LOOP );
			}
			return;
			
		case STAGE_LOOP:
			PlayCycle ( ANIMCHANNEL_ALL, "attack_loop" );
			StartSound( "snd_spin_loop", SND_CHANNEL_WEAPON, 0, false, 0 );
			SetStage( STAGE_LOOP_WAIT );
			return;
			
		case STAGE_LOOP_WAIT:
			if ( !wsfl.attack || wsfl.lowerWeapon ) {
				SetStage( STAGE_END );
			}
			else {
				Attack ( );
			}
			return;
		
		case STAGE_END:
			PlayAnim ( ANIMCHANNEL_ALL, "attack_end" );
			StopBlade ( );
			StartSound( "snd_spin_down", SND_CHANNEL_WEAPON, 0, false, 0 );
			SetStage( STAGE_END_WAIT );
			return;
		
		case STAGE_END_WAIT:
			if ( wsfl.attack || AnimDone ( ANIMCHANNEL_ALL ) ) {
				SetState( WEAP_STATE_IDLE );
			}
			return;
	}	
	
	StateError( "Unknown stage #" );
}

