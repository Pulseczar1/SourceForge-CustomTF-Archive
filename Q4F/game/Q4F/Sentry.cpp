#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"

#define WORLD_POS( vec ) ( ( vec * viewAngles.ToMat3() ) + GetPhysics()->GetOrigin() )

CLASS_DECLARATION( BuildableEntity, SentryGun )
	EVENT( EV_Explode, SentryGun::Explode )
END_CLASS

SentryGun::SentryGun() {
	state = SENTRY_STATE_SPAWNED;
	target = NULL;
	sentryClipModel = NULL;
	baseClipModel = NULL;
	sentLevel = 0;
	sentryModelDefHandle = -1;
	oldHealth = 0;
	snapAngles.Zero();
	offsetViewAngles.Zero();
}

SentryGun::~SentryGun() {
	FreeModelDef();

	ClearClipModels();

	SetPhysics( NULL );
}

void SentryGun::Spawn() {
	nextMGAttackTime = 0;
	nextRocketAttackTime = 0;
	track_start_time = 0;
	gunNum = 0;
	rocketNum = 0;

	shells = 0;
	rockets = 0;
	health = 0;

	target_site_time = 0;

	fl.takedamage = true;

	oldHealth = 0;

	memset( &sentryRenderEntity, 0, sizeof ( sentryRenderEntity ) );
	sentryModelDefHandle = -1;

	snapAngles.Zero();
	offsetViewAngles.Zero();
}

void SentryGun::Think() {
	if( state <= SENTRY_STATE_SPAWNED )
		return;

	idPlayer* owner = ownerInfo.GetPlayer();
	if ( owner == NULL || team != owner->team || ownerInfo.GetClass() != owner->currentPC ) {
		PostEventMS( &EV_Remove, 0 );
		return;
	}

	trace_t trace;
	idPlayer* targ = NULL;
	float percent;

	switch( state ) {
		case SENTRY_STATE_BUILDING:
			percent = UpdateBuildStatus();
			UpdateBuildEffect( percent );
			break;

		case SENTRY_STATE_SCANNING:
			if ( target.GetEntity() == NULL || !CanTarget( target ) ) {
				target = NULL;
				targ = FindTarget();
				if ( targ ) {
					target_site_time = gameLocal.time;
					target = targ;
				}
			}
			else {
				if ( gameLocal.time > target_site_time + sentryInfo.track_delay ) {
					state = SENTRY_STATE_ATTACKING;
					StartSound( "snd_sight", SND_CHANNEL_ANY, 0, true, NULL );
					break;
				}
			}
			
			{
				sentryInfo.LoopScanYaw();
				idAngles ang = GetPhysics()->GetAxis().ToAngles();
				ang.yaw += sentryInfo.scanYaw.GetCurrentValue( gameLocal.time );
				LookAtAngles( ang, 0.5f );
			}
			break;

		case SENTRY_STATE_TRACKING:
			if ( target.GetEntity() == NULL || !CanTarget( target ) ) {
				target = NULL;
				state = SENTRY_STATE_SCANNING;
				break;
			}

			if ( track_start_time <= 0 ) {
				track_start_time = gameLocal.time;
			}
			else if ( gameLocal.time - track_start_time >= sentryInfo.track_time ) {
				target = NULL;
				state = SENTRY_STATE_SCANNING;
				track_start_time = 0;
				break;
			}

			
			if ( CanSee( target, trace, true ) ) {
				track_start_time = 0;
				state = SENTRY_STATE_ATTACKING;
			}
			else {
				targ = FindTarget();
				if ( targ ) {
					target = targ;
					track_start_time = 0;
					state = SENTRY_STATE_ATTACKING;
				}
			}
			break;

		case SENTRY_STATE_ATTACKING:
			if ( !CanTarget( target, true ) ) {
				nextRocketAttackTime = 0;
				nextMGAttackTime = 0;
				state = SENTRY_STATE_SCANNING;
				break;
			}

			if ( CanSee( target, trace, true ) ) {
				LookAtDir( trace.endAxis[0] );

				if ( viewDir * trace.endAxis[0] >= sentryInfo.attackEpsilon ) {
					if ( nextMGAttackTime <= 0 ) {
						nextMGAttackTime = gameLocal.time + sentryInfo.mgAttackDelay;
					}
					else if ( gameLocal.time >= nextMGAttackTime ) {
						FireMG( trace.endAxis[0] );
						nextMGAttackTime = gameLocal.time + sentryInfo.mgAttackDelay;
					}
					
					
					if ( nextRocketAttackTime <= 0 ) {
						nextRocketAttackTime = gameLocal.time + sentryInfo.rocketAttackDelay;
					}
					else if ( gameLocal.time >= nextRocketAttackTime ) {
						FireRocket( trace.endpos, target->GetPhysics()->GetLinearVelocity() );
						nextRocketAttackTime = gameLocal.time + sentryInfo.rocketAttackDelay;
					}
					
				}
			}
			else {
				nextRocketAttackTime = 0;
				nextMGAttackTime = 0;
				state = SENTRY_STATE_TRACKING;
			}
			break;
	}

	RunPhysics();
	Present();
}

void SentryGun::BuildStarted() {
	viewDir = GetPhysics()->GetAxis()[0];
	viewAngles = viewDir.ToAngles();
	viewAngles.roll = 0.0f;

	physicsObj.SetContents( CONTENTS_PLAYERCLIP | CONTENTS_WRENCH );
	physicsObj.SetClipMask( physicsObj.GetClipMask() | CONTENTS_WRENCH );

	oldHealth = 0;

	if ( !gameLocal.isClient ) {
		state = SENTRY_STATE_BUILDING;
		Upgrade( 0, 1, false );
	}

	BecomeActive( TH_THINK );
}

void SentryGun::BuildFinished() {
	state = SENTRY_STATE_SCANNING;

	shells = sentryInfo.max_shells;
	rockets = sentryInfo.max_rockets;

	GetOwner()->sentryGun = this;

	TFPlayerStats* stats = tfStatManager->GetPlayerStatsPlayer( GetOwner() );
	if ( stats ) {
		stats->sentryBuildCount++;
	}

}

idPlayer* SentryGun::FindTarget() {

	idPlayer* enemy = NULL;
	idPlayer* found = NULL;
	float dist = sentryInfo.searchForwardDist;
	trace_t trace;

	bool foundInFront = false;

	int seeResult;

	for ( int i = 0; i < gameLocal.numClients; i++ ) {
		enemy = GET_PLAYER( i );
		if ( CanTarget( enemy ) ) {
			
			seeResult = CanSee( enemy, trace, !foundInFront );

			if ( seeResult <= 0 )
				continue;

			if ( foundInFront && seeResult == 2 )
				continue;

			if ( seeResult == 1 )
				foundInFront = true;

			if ( trace.c.dist < dist ) {
				dist = trace.c.dist;
				found = enemy;
			}
		}
	}

	return found;
}

#define TRACE_CHECK_INC 5.0f

// 0 = no, 1 = in front, 2 = behind
int SentryGun::CanSee( idEntity* enemy, trace_t &trace, bool allowBehind ) {
	if ( !enemy )
		return 0;

	idVec3 eyePos = WORLD_POS( sentryInfo.eyePos );

	idBounds enemyBounds = enemy->GetPhysics()->GetAbsBounds();
	idVec3 point = enemyBounds.GetCenter();
	idVec3 dir = point - eyePos;
	float dist = dir.Normalize();

	bool inFront = ( viewDir * dir ) > 0.0f;

	if ( inFront && dist > sentryInfo.searchForwardDist ) {
		return 0;
	}
	else if ( !inFront ) {
		if ( !allowBehind || dist > sentryInfo.searchBackwardDist ) {
			return 0;
		}
	}

	// update: just look at chest and eyes
	if ( gameLocal.clip.TracePoint( trace, eyePos, point, CONTENTS_SOLID | CONTENTS_WATER, this ) ) {
		if ( gameLocal.GetTraceEntity( trace ) == enemy ) {
			trace.c.dist = ( eyePos - trace.endpos ).Length();
			trace.endAxis = ( trace.endpos - eyePos ).ToNormal().ToMat3();
			return inFront ? 1 : 2;
		}
	}

	if ( enemy->IsType( idPlayer::GetClassType() ) ) {
		point = static_cast<idPlayer*>(enemy)->GetEyePosition();

		if ( gameLocal.clip.TracePoint( trace, eyePos, point, CONTENTS_SOLID | CONTENTS_WATER, this ) ) {
			if ( gameLocal.GetTraceEntity( trace ) == enemy ) {
				trace.c.dist = ( eyePos - trace.endpos ).Length();
				trace.endAxis = ( trace.endpos - eyePos ).ToNormal().ToMat3();
				return inFront ? 1 : 2;
			}
		}
	}

	/*idVec3 left, down, tmpPoint;

	// remove gravity from dir
	dir -= ( GetPhysics()->GetGravityNormal() * dir ) * GetPhysics()->GetGravityNormal();
	dir.Normalize();

	down.Zero();
	down.z = -1.0f;

	left.Cross( down, dir );

	float width = idMath::Fabs( enemyBounds[0].x - enemyBounds[1].x ) / 2.0f;
	float height = idMath::Fabs( enemyBounds[0].z - enemyBounds[1].z ) / 2.0f;


	float wPos, hPos;

	// start at center
	for ( wPos = 0.0f; wPos <= width; wPos += TRACE_CHECK_INC ) {
		for ( hPos = 0.0f; hPos <= height; hPos += TRACE_CHECK_INC ) {
			tmpPoint = point + ( left * wPos );
			tmpPoint += ( down * hPos );

			if ( gameLocal.clip.TracePoint( trace, eyePos, tmpPoint, CONTENTS_SOLID | CONTENTS_WATER, this ) ) {
				if ( gameLocal.GetTraceEntity( trace ) == enemy ) {
					trace.c.dist = ( eyePos - trace.endpos ).Length();
					trace.endAxis = ( trace.endpos - eyePos ).ToNormal().ToMat3();
					return inFront ? 1 : 2;
				}
			}
		}
	}

	width = -width;
	height = -height;

	for ( wPos = -TRACE_CHECK_INC; wPos >= width; wPos -= TRACE_CHECK_INC ) {
		for ( hPos = -TRACE_CHECK_INC; hPos >= height; hPos -= TRACE_CHECK_INC ) {
			tmpPoint = point + ( left * wPos );
			tmpPoint += ( down * hPos );

			if ( gameLocal.clip.TracePoint( trace, eyePos, tmpPoint, CONTENTS_SOLID, this ) ) {
				if ( gameLocal.GetTraceEntity( trace ) == enemy ) {
					trace.endAxis = ( trace.endpos - eyePos ).ToNormal().ToMat3();
					return inFront ? 1 : 2;
				}
			}
		}
	}*/

	

	return 0;
}



//--------------------------------------------------------------------------
// should be the only function that controls where the sentry looks
//--------------------------------------------------------------------------
void SentryGun::LookAtPos( idVec3 &pos, float turnSpeedMultiplier ) {
	idVec3 eyePos = WORLD_POS( sentryInfo.eyePos );

	idVec3 dir = ( pos - eyePos ).ToNormal();
	LookAtDir( dir, turnSpeedMultiplier );
}

void SentryGun::LookAtDir( idVec3 &dir, float turnSpeedMultiplier ) {
	idAngles ang = dir.ToAngles();
	LookAtAngles( ang, turnSpeedMultiplier );
}

void SentryGun::LookAtAngles( idAngles &angles, float turnSpeedMultiplier ) {

	float turnRate = sentryInfo.turnRate * turnSpeedMultiplier;
	
	float diff = angles.yaw - viewAngles.yaw;

	if ( diff > 180.0f )
		diff -= 360.0f;
	else if ( diff < -180.0f )
		diff += 360.0f;

	if ( diff > turnRate )
		diff = turnRate;
	else if ( diff < -turnRate )
		diff = -turnRate;

	viewAngles.yaw += diff;

	if ( viewAngles.yaw > 360.0f )
		viewAngles.yaw -= 360.0f;
	else if ( viewAngles.yaw < 0.0f )
		viewAngles.yaw += 360.0f;

	angles.Normalize180();
	diff = angles.pitch - viewAngles.pitch;

	if ( diff > 90.0f )
		diff -= 180;
	else if ( diff < -90.0f )
		diff += 180.0f;

	if ( diff > turnRate )
		diff = turnRate;
	else if ( diff < -turnRate )
		diff = -turnRate;

	viewAngles.pitch += diff;

	if ( viewAngles.pitch > 90.0f )
		viewAngles.pitch -= 90.0f;
	else if ( viewAngles.pitch < -90.0f )
		viewAngles.pitch += 90.0f;

	viewAngles.roll = 0.0f;

	idAngles sumAngles = viewAngles;
	sumAngles.yaw += offsetViewAngles.yaw;

	viewDir = sumAngles.ToForward();

	UpdateClipModels( true );
	UpdateVisuals();
}

void SentryGun::UpdateModelTransform() {
	idMat3 axis;
	GetSentryOrientation( NULL, &axis, NULL );
	sentryRenderEntity.axis = axis;
	sentryRenderEntity.origin = GetPhysics()->GetOrigin() + sentryInfo.sentryPos;

	renderEntity.origin = GetPhysics()->GetOrigin();
	renderEntity.axis = GetPhysics()->GetAxis();
}

void SentryGun::FireMG( idVec3 &dir ) {
	assert( !gameLocal.isClient );

	if ( !sentryInfo.hitscanDef || shells <= 0 ) {
		shells = 0;
		return;
	}

	shells--;

	//TFDamage	attDmg = sentryInfo.hitscanDmg;
	ENTDEF		attackDef = sentryInfo.hitscanDef;

	tfStatManager->ShotFired( ownerInfo, attackDef );

	idVec3 gunPos;

	GetGunPos( gunNum, gunPos );

	gunNum++;
	if ( gunNum > 3 )
		gunNum = 0;


	idVec3 eyePos;
	GetSentryOrientation( NULL, NULL, &eyePos );

	idBitMsg	msg;
	byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];

	if ( gameLocal.isServer ) {
		int ownerId = GetOwner() ? GetOwner()->entityNumber : 0;

		msg.Init( msgBuf, sizeof( msgBuf ) );
		msg.BeginWriting();
		msg.WriteByte( GAME_UNRELIABLE_MESSAGE_HITSCAN );
		msg.WriteBits( attackDef->Index(), gameLocal.entityDefBits );
		msg.WriteBits( ownerId, ASYNC_MAX_CLIENT_BITS );
		msg.WriteBits( 1, 5 );
		msg.WriteFloat( eyePos[0] );
		msg.WriteFloat( eyePos[1] );
		msg.WriteFloat( eyePos[2] );
		msg.WriteFloat( gunPos[0] );
		msg.WriteFloat( gunPos[1] );
		msg.WriteFloat( gunPos[2] );
		msg.WriteDir( dir, 24 );
	}

	int		areas[ 2 ];

	gameLocal.HitScan( ownerInfo, attackDef->dict, 1.0f, dir, eyePos, gunPos, false, this, areas );
	gameLocal.SendUnreliableMessagePVS( msg, areas[0], areas[1] );

	idVec3 dirToGun = gunPos - eyePos;
	dirToGun.Normalize();

	LookAtDir( dirToGun, 1.5f );

	//gameRenderWorld->DebugArrow( colorGreen, eyePos, eyePos + ( dir * 1000.0f ), 10, 500 );
	//gameRenderWorld->DebugArrow( colorRed, gunPos, gunPos + ( dir * 1000.0f ), 10, 500 );
}

void SentryGun::FireRocket( const idVec3 &targetPos, const idVec3 &targetVelocity ) {
	assert( !gameLocal.isClient );

	if ( sentryInfo.projectileDef == NULL || rockets <= 0 ) {
		rockets = 0;
		return;
	}

	tfStatManager->ShotFired( ownerInfo, sentryInfo.projectileDef );

	rockets--;

	idVec3 dir = vec3_zero;

	idVec3 launchPos;
	
	if ( rocketNum == 1 ) {
		launchPos = WORLD_POS( sentryInfo.rocketPos2 );
		rocketNum = 0;
	}
	else {
		launchPos = WORLD_POS( sentryInfo.rocketPos1 );
		rocketNum = 1;
	}

	PredictAim( launchPos, 30.0f, sentryInfo.projectileDef->dict.GetFloat( "speed", "900" ), targetPos, targetVelocity, dir );

	// make sure we aren't going to screw ourselves over
	modelTrace_t trace;
	gameRenderWorld->FastWorldTrace( trace, launchPos, launchPos + ( dir * 100.0f ) );
	if ( trace.fraction < 1.0f ) {
		return;
	}

	idEntity* ent = NULL;
	gameLocal.SpawnEntityDef( sentryInfo.projectileDef->dict, &ent, false );

	// Make sure it spawned
	if ( !ent || !ent->IsType( idProjectile::GetClassType() ) ) {
		gameLocal.Error( "failed to spawn projectile for sentry gun" );
	}

	// Create the projectile
	idProjectile* proj = static_cast<idProjectile*>(ent);
	proj->Create( ownerInfo, launchPos, dir, this, this );
	proj->Launch( launchPos, dir, vec3_zero );

	SendRocketEvent( !rocketNum );
}

void SentryGun::PredictAim( const idVec3& source, float maxAngle, float projectileSpeed, const idVec3& target, const idVec3& _targetVelocity, idVec3& newAimDir ) const {
	float  a;
	float  b;
	float  c;
	float  d;
	float  t;
	idVec3 r;

	assert( maxAngle < 90.0f );
	
	// Make sure there is something to predict
	if ( _targetVelocity.LengthSqr ( ) == 0.0f ) {
		newAimDir = ( target - source ).ToNormal();
		return;
	}

	// only predict lateral motion
	// note, should probably remove according to target's gravity dir but im lazy
	idVec3 targetVelocity = _targetVelocity;
	targetVelocity.z = 0.0f;

	r = (target-source);
	float distToTarget = r.Length();

	// calculate max dist from the given angle
	float opp = ( 90.0f - maxAngle );
	float maxDist = distToTarget / ( idMath::Tan( DEG2RAD( opp ) ) );
	
	// Solve for (t):  magnitude(targetVelocity * t + target - source) = projectileSpeed * t	
	a = (targetVelocity * targetVelocity) - Square(projectileSpeed);
	b = (targetVelocity * 2.0f) * r;
	c = r*r;
	d = b*b - 4*a*c; 
	t = 0.0f;
	
	if ( d >= 0.0f ) {
		float  t1;
		float  t2;
		float  denom;
		d     = idMath::Sqrt(d);
		denom = 1.0f / (2.0f * a);
		t1    = (-b + d) * denom;
		t2    = (-b - d) * denom;
		if ( t1 < 0.0f && t2 < 0.0f ) {
			t = 0.0f;
		} else if ( t1 < 0.0f ) {
			t = t2;
		} else if ( t2 < 0.0f ) {
			t = t1;
		} else {
			t = Min(t1,t2);
		}
	}

	idVec3 add = targetVelocity * t;
	if ( add.Length() > maxDist )
		add = targetVelocity.ToNormal() * maxDist;

	newAimDir = ( ( target + add ) - source).ToNormal();
}

bool SentryGun::ClientReceiveEvent( int event, int time, const idBitMsg &msg ) {
	switch ( event ) {
		case EVENT_UPGRADE:
			ReceiveUpgradeEvent();
			return true;
		case EVENT_FIREROCKET:
			bool rocketPos = msg.ReadBits( 1 ) == 1;
			ReceiveRocketEvent( rocketPos );
			return true;
	}
	return BuildableEntity::ClientReceiveEvent( event, time, msg );
}

void SentryGun::SendRocketEvent( bool rocketPos ) {
	idBitMsg	msg;
	byte		msgBuf[MAX_EVENT_PARAM_SIZE];

	msg.Init( msgBuf, sizeof( msgBuf ) );
	msg.BeginWriting();
	msg.WriteBits( rocketPos ? 1 : 0, 1 );
	ServerSendEvent( EVENT_FIREROCKET, &msg, false, -1 );

	ReceiveRocketEvent(rocketPos );
}

void SentryGun::ReceiveRocketEvent( bool rocketPos ) {
	if ( rocketPos ) {
		PlayEffect( "fx_rocketfire", WORLD_POS( sentryInfo.rocketPos2 ), viewAngles.ToMat3() );
	}
	else {
		PlayEffect( "fx_rocketfire", WORLD_POS( sentryInfo.rocketPos1 ), viewAngles.ToMat3() );
	}
}

void SentryGun::SendUpgradeEvent() {
	idBitMsg	msg;
	byte		msgBuf[MAX_EVENT_PARAM_SIZE];

	msg.Init( msgBuf, sizeof( msgBuf ) );
	msg.BeginWriting();
	ServerSendEvent( EVENT_UPGRADE, &msg, false, -1 );

	ReceiveUpgradeEvent();
}

void SentryGun::ReceiveUpgradeEvent() {
	PlayEffect( "fx_buildfinished", GetPhysics()->GetOrigin(), mat3_identity );
}

bool SentryGun::CanTarget( idPlayer* player, bool seeThruDisguise ) {
	assert( GetOwner() );
	return player && !player->spectating && player->health > 0 && ( player->team != GetOwner()->team ) && ( seeThruDisguise || player->disguiseTeam != GetOwner()->team );
}

void SentryGun::FreeModelDef( void ) {
	idEntity::FreeModelDef();

	if ( sentryModelDefHandle != -1 ) {
		gameRenderWorld->FreeEntityDef( sentryModelDefHandle );
		sentryModelDefHandle = -1;
	}
}

void SentryGun::Present( void ) {

	if ( !gameLocal.isNewFrame ) {
		return;
	}

	if ( !gameLocal.isLastPredictFrame && modelDefHandle != -1 && sentryModelDefHandle != -1 ) {
		return;
	}

	// don't present to the renderer if the entity hasn't changed
	if ( !( thinkFlags & TH_UPDATEVISUALS ) ) {
		return;
	}
	BecomeInactive( TH_UPDATEVISUALS );

	// if set to invisible, skip
	if ( renderEntity.hModel && !IsHidden() ) {
		if ( modelDefHandle == -1 ) {
			modelDefHandle = gameRenderWorld->AddEntityDef( &renderEntity );
		} else {
			gameRenderWorld->UpdateEntityDef( modelDefHandle, &renderEntity );
		}	
	}

	if ( sentryRenderEntity.hModel && !IsHidden() ) {
		if ( sentryModelDefHandle == -1 ) {
			sentryModelDefHandle = gameRenderWorld->AddEntityDef( &sentryRenderEntity );
		} else {
			gameRenderWorld->UpdateEntityDef( sentryModelDefHandle, &sentryRenderEntity );
		}	
	}

	// add to refresh list
}

void SentryGun::Damage_TF( const TFDamage &dmg, float damageScale ) {

	// damage is only processed on server
	if ( gameLocal.isClient ) {
		return;
	}

	if ( health <= 0 )
		return;

	idEntity* attacker = dmg.GetAttacker().GetEntity();

	// check if we repair
	idPlayer* playerAttacker = dmg.GetAttacker().GetPlayer();
	if ( playerAttacker && playerAttacker->team == team ) {
		if ( dmg.GetDamageDict()->GetBool( "repair", "0" ) ) {

			int numCells = playerAttacker->inventory.ammo[AMMO_CELLS_INDEX];
			numCells -= Repair( numCells );			// returns how many cells are left
			assert( numCells >= 0 );

			numCells -= Upgrade( numCells, sentLevel + 1, true, playerAttacker->entityNumber );

			assert( numCells >= 0 );

			int numShells = playerAttacker->inventory.ammo[AMMO_SHELLS_INDEX];
			numShells -= RefillShells( numShells );
			assert( numShells >= 0 );

			int numRockets = playerAttacker->inventory.ammo[AMMO_ROCKETS_INDEX];
			numRockets -= RefillRockets( numRockets );
			assert( numRockets >= 0 );
			
            playerAttacker->inventory.ammo[AMMO_CELLS_INDEX] = numCells;
			playerAttacker->inventory.ammo[AMMO_SHELLS_INDEX] = numShells;
			playerAttacker->inventory.ammo[AMMO_ROCKETS_INDEX] = numRockets;
			return;
		}
	}

	if ( attacker != NULL ) {
		attacker->DamageFeedback_TF( this, dmg );
	}

	int damage = dmg.GetDamage() * 0.75f;
	health -= damage;

	

	if ( health <= 0 ) {
		health = 0;

		tfStatManager->SentryKilled( this, dmg );
		tfStatManager->EntityDamaged( this, dmg, true );

		idPlayer* owner = GetOwner();
		idEntity* attacker = dmg.GetAttacker().GetEntity();
		if ( !attacker )
			attacker = gameLocal.world;

		assert( attacker );

		if ( owner )
			gameLocal.mpGame.PrintMessageEvent( -1, MSG_SENTRY_KILL, owner->entityNumber, attacker->entityNumber );

		PostEventMS( &EV_Explode, 0 );
	}
	else {
		tfStatManager->EntityDamaged( this, dmg, false );
	}
}

void SentryGun::Explode() {
	StopAllEffects();
	ClearClipModels();
	Hide();

	if ( !gameLocal.isClient ) {
		TFDamage splode;
		splode.Create( ownerInfo, spawnArgs.GetString( "def_damage_explode" ), 1.0f );
		gameLocal.RadiusDamage_TF( GetCenter(), splode, this ); 

		gameLocal.PlayEffect( spawnArgs, "fx_explode", GetPhysics()->GetOrigin(), (-GetPhysics()->GetGravityNormal()).ToMat3(), false, vec3_origin, true );
		PostEventMS( &EV_Remove, 0 );
	}
}

int SentryGun::Upgrade( int numCells, int newLevel, bool playEffect, int clientToTell ) {

	if ( newLevel >= 4 )
		return 0;

	if ( !gameLocal.isClient && newLevel > 1 && state <= SENTRY_STATE_BUILDING )
		return 0;

	const idDict* upgradeArgs = GetSpawnArgsDict( va( "def_level%d", newLevel ) );
	if ( !upgradeArgs ) {
		gameLocal.Warning( "SentryGun::Upgrade: cannot find def for level %d\n", newLevel );
		return 0;
	}
	
	int cellsRequired = 0;
	if ( !gameLocal.isClient ) {
		cellsRequired = upgradeArgs->GetInt( "cells_required", "0" );
		if ( numCells < cellsRequired ) {
			if ( clientToTell >= 0 )
				gameLocal.mpGame.PrintMessageEvent( clientToTell, MSG_NEED_MORE_CELLS_SENT );
			return 0;
		}
	}

	sentLevel = newLevel;

	if ( sentryClipModel ) {
		delete sentryClipModel;
		sentryClipModel = NULL;
	}

	FreeModelDef();

	sentryInfo.Init( ownerInfo, upgradeArgs );

	memset( &sentryRenderEntity, 0, sizeof( sentryRenderEntity ) );
	gameEdit->ParseSpawnArgsToRenderEntity( upgradeArgs, &sentryRenderEntity );
	sentryModelDefHandle = -1;

	UpdateVisibleColor();

	UpdateClipModels( true );

	health = sentryInfo.max_armor;

	if ( playEffect ) {
		SendUpgradeEvent();
	}

	return cellsRequired;
}

int SentryGun::Repair( int numCells ) {
	int damage = sentryInfo.max_armor - health;

	if ( damage > numCells )
		damage = numCells;

	health += damage;
	return damage;
}

int SentryGun::RefillShells( int numShells ) {
	if ( numShells <= 16 )
		return 0;

	numShells -= 16;

	int empty = sentryInfo.max_shells - shells;
	
	if ( empty > numShells )
		empty = numShells;

	shells += empty;
	return empty;
}

int SentryGun::RefillRockets( int numRockets ) {
	int empty = sentryInfo.max_rockets - rockets;
	
	if ( empty > numRockets )
		empty = numRockets;

	rockets += empty;
	return empty;
}

void SentryGun::UpdateClipModels( bool enable ) {
	if ( enable ) {
		if ( sentryClipModel == NULL ) {
			if( !sentryInfo.model || !sentryInfo.model[0] ) {
				idStr ermsg = "SentryGun::UpdateClipModels - the sentry's model name is null or empty...\n";
				ermsg.Append( va( "Sentry: level=%d, state=%d", GetLevel(), GetState() ) );
				gameLocal.Warning( ermsg.c_str() );
			}
			else {
				RV_PUSH_HEAP_MEM(this);
				sentryClipModel = new idClipModel( sentryInfo.model );
				RV_POP_HEAP();

				assert( sentryClipModel );

				sentryClipModel->SetContents( CONTENTS_PROJECTILECLIP );
			}
		}

		if ( baseClipModel == NULL ) {
			RV_PUSH_HEAP_MEM(this);
			baseClipModel = new idClipModel( spawnArgs.GetString( "model" ) );
			RV_POP_HEAP();

			assert( baseClipModel );

			baseClipModel->SetContents( CONTENTS_PROJECTILECLIP );
		}

		idVec3 org;
		idMat3 axis;
		GetSentryOrientation( &org, &axis, NULL );
		sentryClipModel->Link( this, 0, org, axis, sentryModelDefHandle );
		baseClipModel->Link( this, 1, GetPhysics()->GetOrigin(), GetPhysics()->GetAxis(), modelDefHandle );
	}
	else {
		if ( sentryClipModel != NULL ) {
			sentryClipModel->Unlink();
		}

		if ( baseClipModel != NULL ) {
			baseClipModel->Unlink();
		}
	}
}

void SentryGun::ClearClipModels() {
	if ( sentryClipModel ) {
		delete sentryClipModel;
		sentryClipModel = NULL;
	}
	if ( baseClipModel ) {
		delete baseClipModel;
		baseClipModel = NULL;
	}
}

void SentryGun::UpdateBuildEffect( float percent ) {

	if ( percent > 0.0f ) {
		percent = idMath::ClampFloat( 0.0f, 1.0f, 1.0f - percent );

		renderEntity.shaderParms[9] = percent;
		sentryRenderEntity.shaderParms[9] = percent;
		UpdateVisuals();
	}
}

void SentryGun::WriteToSnapshot( idBitMsgDelta &msg ) const {
	BuildableEntity::WriteToSnapshot( msg );

	msg.WriteFloat( offsetViewAngles.yaw );

	msg.WriteBits( sentLevel, 2 );

	if ( state <= SENTRY_STATE_BUILDING ) {
		msg.WriteBits( 0, 2 );
	}
	else if ( state == SENTRY_STATE_SCANNING ) {
		msg.WriteBits( 1, 2 );
	}
	else {
		msg.WriteBits( 2, 2 );
		msg.WriteFloat( viewAngles.pitch );
		msg.WriteFloat( viewAngles.yaw );
	}

	//msg.WriteBits( health <= 0 ? 1 : 0, 1 );

	msg.WriteByte( health );
	msg.WriteByte( shells );
	msg.WriteBits( rockets, 5 );
}

void SentryGun::ReadFromSnapshot( const idBitMsgDelta &msg ) {
	BuildableEntity::ReadFromSnapshot( msg );

	offsetViewAngles.yaw = msg.ReadFloat();
	
	int newLevel = msg.ReadBits( 2 );

	int newState = msg.ReadBits( 2 );
	if ( newState == 0 ) {
		state = SENTRY_STATE_BUILDING;
		viewAngles.yaw = physicsObj.GetAxis().ToAngles().yaw;
	}
	else if ( newState == 1 ) {
		state = SENTRY_STATE_SCANNING;
	}
	else if ( newState == 2 ){
		state = SENTRY_STATE_ATTACKING;
		snapAngles.pitch = msg.ReadFloat();
		snapAngles.yaw = msg.ReadFloat();
		snapAngles.roll = 0.0f;
	}

	// don't upgrade before reading state!
	if ( newLevel != sentLevel ) {
		Upgrade( 0, newLevel, false );
	}

	int oldHealth = health;

	health = msg.ReadByte();
	shells = msg.ReadByte();
	rockets = msg.ReadBits( 5 );

	if ( oldHealth > 0 && health <= 0 ) {
		Explode();
	}
}

void SentryGun::ClientPredictionThink() {

	idAngles ang;

	if ( sentLevel <= 0 )
		return;

	UpdateBuildEffect( GetBuildPercent( gameLocal.time ) );

	switch ( state ) {
		case SENTRY_STATE_BUILDING:
			break;
			
		case SENTRY_STATE_SCANNING:
			sentryInfo.LoopScanYaw();
			ang = GetPhysics()->GetAxis().ToAngles();
			ang.yaw += sentryInfo.scanYaw.GetCurrentValue( gameLocal.time );
			LookAtAngles( ang, 0.5f );
			break;

		case SENTRY_STATE_ATTACKING:
			LookAtAngles( snapAngles );
			break;
	}

	RunPhysics();
	Present();
}

void SentryGun::UpdateHud( idUserInterface* hud ) {
	assert( hud );

	if ( oldHealth < health ) {
		oldHealth += 2;

		if ( oldHealth > health )
			oldHealth = health;
	}
	else if ( oldHealth > health ) {
		oldHealth -= 2;

		if ( oldHealth < health )
			oldHealth = health;
	}

	hud->SetStateInt( "sentry_health", oldHealth );
	hud->SetStateInt( "sentry_shells", shells );

	if ( sentLevel >= 3 )
		hud->SetStateInt( "sentry_rockets", rockets );
	else
		hud->SetStateInt( "sentry_rockets", -1 );
}

void SentryGun::EmpTouch( const AttackerInfo &attacker, idVec3 &dir, float damageScale ) {

	if ( state <= SENTRY_STATE_BUILDING )
		return;

	int damage = ( rockets * 4 ) + ( shells / 2 );

	rockets *= 0.25f;
	shells *= 0.5f;

	TFDamage empDamage;
	empDamage.Create( attacker, spawnArgs.GetString( "def_empdamage" ), damageScale );
	empDamage.SetDamage( damage );
	gameLocal.RadiusDamage_TF( GetCenter(), empDamage, NULL );
}

void SentryGun::Rotate( int degrees ) {
	offsetViewAngles.yaw += (float)degrees;
}

void SentryGun::GetGunPos( int gunNum, idVec3 &pos ) {
	if ( gunNum == 0 ) {
		pos = WORLD_POS( sentryInfo.gunPos1 );
	}
	else if ( gunNum == 1 ) {
		pos = WORLD_POS( sentryInfo.gunPos2 );
	}
	else if ( gunNum == 2 ) {
		pos = WORLD_POS( sentryInfo.gunPos3 );
	}
	else {
		pos = WORLD_POS( sentryInfo.gunPos4 );
	}
}












void SentryLevelInfo::Init( AttackerInfo &owner, const idDict* args ) {

	assert( args );

	const char* temp = NULL;

	max_armor = args->GetInt( "max_armor", "150" );
	max_shells = args->GetInt( "max_shells", "100" );
	max_rockets = args->GetInt( "max_rockets", "0" );

	model = NULL;
	model = args->GetString( "model", "" );

	if ( !model || !model[0] ) {
		idStr ermsg = "SentryLevelInfo::Init - the model string is empty or null.\n";
		ermsg.Append( va( "Arg's hitscan def is '%s'\n", args->GetString( "def_hitscan", "null" ) ) );

		idPlayer* ownerP = owner.GetPlayer();

		if ( ownerP == NULL ) {
			ermsg.Append( "The owning player is null...." );
		}
		else {
			SentryGun* gun = ownerP->sentryGun.GetEntity();
			if ( gun == NULL ) {
				ermsg.Append( "Could not get the owning player's sentry." );
			}
			else {
				ermsg.Append( va( "Sentry: level=%d, state=%d", gun->GetLevel(), gun->GetState() ) );
			}
		}

		gameLocal.Error( ermsg.c_str() );
		
	}
	
	if ( args->GetString( "def_hitscan", "", &temp ) && temp && temp[0] ) {
		hitscanDef = gameLocal.FindEntityDef( temp, false );
	}
	else {
		hitscanDef = NULL;
	}

	/*if ( hitscanDef != NULL ) {
		hitscanDmg.Create( owner, hitscanDef->dict.GetString( "def_damage_direct", "" ), 1.0f );
	}
	else {
		hitscanDmg.Clear();
	}*/

	if ( args->GetString( "def_projectile", "", &temp ) && temp && temp[0] ) {
		projectileDef = gameLocal.FindEntityDef( temp, false );
	}
	else {
		projectileDef = NULL;
	}

	track_delay = SEC2MS( args->GetFloat( "track_delay" ) );

	attackAngle = args->GetFloat( "max_attack_angle", "10" );
	attackEpsilon = idMath::Cos16( DEG2RAD( attackAngle ) );

	track_time = SEC2MS( args->GetFloat( "track_time", "1" ) );

	turnRate = args->GetFloat( "turn_rate", "5" ) * 001.0f;

	mgAttackDelay = SEC2MS( args->GetFloat( "machinegun_attack_delay", "0.1" ) );
	rocketAttackDelay = SEC2MS( args->GetFloat( "rocket_attack_delay", "1.0" ) );

	sentryPos = args->GetVector( "sentry_pos", "0 0 0" );

	gunPos1 = args->GetVector( "gun_pos_1", "0 0 0" );
	gunPos2 = args->GetVector( "gun_pos_2", "0 0 0" );
	gunPos3 = args->GetVector( "gun_pos_3", "0 0 0" );
	gunPos4 = args->GetVector( "gun_pos_4", "0 0 0" );

	rocketPos1 = args->GetVector( "rocket_pos_1", "0 0 0" );
	rocketPos2 = args->GetVector( "rocket_pos_2", "0 0 0" );

	projectilePos1 = args->GetVector( "projectile_pos_1", "0 0 0" );
	projectilePos2 = args->GetVector( "projectile_pos_2", "0 0 0" );

	eyePos = args->GetVector( "eye_pos", "0 0 0" );
	
	searchForwardDist = args->GetFloat( "search_forward_dist", "4096.0" );
	searchBackwardDist = args->GetFloat( "search_backward_dist", "4096.0" );

	float yawSpread = args->GetFloat( "scan_yaw_spread", "5" ) / 2.0f;
	int accelTime = SEC2MS( args->GetFloat( "scan_yaw_accel_time", ".5" ) );
	int decelTime = SEC2MS( args->GetFloat( "scan_yaw_decel_time", ".5" ) );
	int scanTime = SEC2MS( args->GetFloat( "scan_yaw_time", "4" ) );
	scanYaw.Init( gameLocal.time, accelTime, decelTime, scanTime, -yawSpread, yawSpread );
}

void SentryLevelInfo::LoopScanYaw() {
	if ( scanYaw.IsDone( gameLocal.time ) ) {
		scanYaw.Init( gameLocal.time, scanYaw.GetAcceleration(), scanYaw.GetDeceleration(), scanYaw.GetDuration(), -(scanYaw.GetStartValue()), -(scanYaw.GetEndValue()) );
	}
}

#undef WORLD_POS