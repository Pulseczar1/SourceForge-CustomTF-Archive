#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"
#include "../Weapon.h"

class SniperDot : public idEntity {
	CLASS_PROTOTYPE( SniperDot );

public:
						SniperDot( void );
						~SniperDot( void );

	void				Create( idPlayer* owner );

	void				Spawn( void );
	void				Think( void );
	void				ClientPredictionThink( void );

	virtual void		WriteToSnapshot			( idBitMsgDelta &msg ) const;
	virtual void		ReadFromSnapshot		( const idBitMsgDelta &msg );

	//virtual bool		ClientStale( void );
	virtual void		ClientUnstale( void );

private:

	void				UpdateDotPosition( void );

	float				GetDotScale( idVec3 &endPos );

	idEntityPtr<idPlayer>		owner;

	idVec3				realDotPos;
	int					realDotTime;

	idVec3				myDotPos;
	int					myDotTime;

	idMat3				dotAxis;
	float				dotDist;

	int					nextUpdateTime;
};


class SniperRifle : public rvWeapon {
public:

	CLASS_PROTOTYPE( SniperRifle );

	SniperRifle ( void );
	~SniperRifle ( void );

	virtual void			Spawn				( void );

protected:

	virtual void			AttackPressed( void );
	virtual void			AttackReleased( void );
	virtual void			AttackHeld( void );

	virtual float			GetWeaponPower( void );

	virtual int				GetSpeedLimit();

	int						charge_start_time;
	SniperDot*				sniperDot;

	ENTDEF					dotDef;

private:

	bool					limitingSpeed;
};

CLASS_DECLARATION( rvWeapon, SniperRifle )
END_CLASS


SniperRifle::SniperRifle( void ) {
	sniperDot = NULL;
}

SniperRifle::~SniperRifle() {
	if ( !gameLocal.isClient && sniperDot ) {
		sniperDot->PostEventMS( &EV_Remove, 0 );
		sniperDot = NULL;
	}
}



void SniperRifle::Spawn( void ) {
	charge_start_time = 0;
	sniperDot = NULL;
	limitingSpeed = false;

	sniperDot = NULL;

	dotDef = gameLocal.FindEntityDef( spawnArgs.GetString( "def_dot", "" ), false );
}



#define MAX_CHARGE_TIME 4000

float SniperRifle::GetWeaponPower() {
	if ( charge_start_time <= 0 )
		return 0.0f;

	float lapseTime = (float)(gameLocal.time - charge_start_time);
	if ( lapseTime > MAX_CHARGE_TIME )
		lapseTime = MAX_CHARGE_TIME;

	float ratio = lapseTime / MAX_CHARGE_TIME ;

	return idMath::ClampFloat( 0.25f, 1.0f, ratio );
}



#define MIN_SPEED_START_CHARGE 100.0f
#define MAX_SPEED_FIRE 110.0f

void SniperRifle::AttackPressed() {

	if ( !OwnerHasGroundContacts() ) {
		return;
	}

	float speed = GetOwnerSpeed();
	if ( speed > MIN_SPEED_START_CHARGE )
		return;

	charge_start_time = gameLocal.time;
	limitingSpeed = true;

	if ( !gameLocal.isClient && !sniperDot ) {
		idEntity* dot = NULL;
		
		if ( !gameLocal.SpawnEntityDef( dotDef->dict, &dot, false ) || !dot || !dot->IsType( SniperDot::GetClassType() ) ) {
			gameLocal.Error( "sniper dot is null or wrong type." );
		}

		sniperDot = static_cast<SniperDot*>(dot);

		sniperDot->Create( owner );
		sniperDot->Think();
	}

	if ( q4f_autozoom.GetBool() ) {
		owner->weaponZoomed = true;
	}

	return;
}



void SniperRifle::AttackHeld() {
	if ( charge_start_time <= 0 )
		AttackPressed();
	return;
}



void SniperRifle::AttackReleased() {

	if ( !OwnerHasGroundContacts() || GetOwnerSpeed() > MAX_SPEED_FIRE ) {
		limitingSpeed = false;
	}
	else {
		if ( charge_start_time > 0 ) {
			nextAttackTime = gameLocal.time + fireRate;
			Attack( num_attacks, 0, GetWeaponPower() );
		}
	}

	if ( !gameLocal.isClient && sniperDot ) {
		sniperDot->PostEventMS( &EV_Remove, 0 );
		sniperDot = NULL;
	}

	owner->weaponZoomed = false;

	charge_start_time = 0;
	limitingSpeed = false;

	SetState( WEAP_STATE_IDLE );
}


int SniperRifle::GetSpeedLimit() {
	if ( !limitingSpeed )
		return idMath::INT_MAX;

	return MIN_SPEED_START_CHARGE;
}









CLASS_DECLARATION( idEntity, SniperDot )
END_CLASS

SniperDot::SniperDot() {
	nextUpdateTime = 0;
	fl.networkSync = true;
	owner = NULL;
	fl.teamColored = true;
}

SniperDot::~SniperDot() {
	
}

void SniperDot::Spawn() {
	nextUpdateTime = 0;
	fl.networkSync = true;
	fl.teamColored = true;

	realDotTime = myDotTime = gameLocal.time;
	myDotPos = realDotPos = GetPhysics()->GetOrigin();

	GetPhysics()->SetContents( 0 );
	owner = NULL;
}

void SniperDot::Create( idPlayer* owner ) {
	if ( !owner )
		return;

	BecomeActive( TH_THINK );

	this->owner = owner;
	this->team = owner->team;
	idVec3 color = tfGame.GetTeamColor( owner->team );
	SetColor( color.x, color.y, color.z, 0.90f );

	//renderEntity.weaponDepthHackInViewID = owner->entityNumber + 1;
}

#define DOT_UPDATE_DELAY 12

void SniperDot::Think() {

	if ( gameLocal.time >= nextUpdateTime ) {
		nextUpdateTime = gameLocal.time + DOT_UPDATE_DELAY;

		UpdateDotPosition();

		GetPhysics()->SetOrigin( realDotPos );

	}

	BecomeActive( TH_UPDATEVISUALS );
	renderEntity.origin = realDotPos;
	renderEntity.axis = dotAxis * GetDotScale( realDotPos );
	Present();
}

void SniperDot::ClientPredictionThink() {
	idPlayer* player = owner.GetEntity();

	if ( player && player->entityNumber == gameLocal.localClientNum ) {
		UpdateDotPosition();

		GetPhysics()->SetOrigin( realDotPos );
		GetPhysics()->SetAxis( dotAxis * GetDotScale( realDotPos ) );

		renderEntity.origin = realDotPos;
		renderEntity.axis = dotAxis * GetDotScale( realDotPos );
	}
	else {

		// nonlocal or unpredictive clients lerp from last pos
		idVec3 lerp;
		lerp.Lerp( myDotPos, realDotPos, (float)( gameLocal.time - realDotTime ) / (float)( realDotTime - myDotTime ) );

		GetPhysics()->SetOrigin( lerp );

		renderEntity.origin = lerp;
		renderEntity.axis = dotAxis * GetDotScale( lerp );
	}

	BecomeActive( TH_UPDATEVISUALS );
	Present();
}

#define MAX_DIST_DOT 2048.0f
#define MIN_DIST_DOT 128.0f

void SniperDot::UpdateDotPosition() {
	idPlayer* player = owner.GetEntity();

	if ( !player ) {
		if ( !gameLocal.isClient ) {
			PostEventMS( &EV_Remove, 0 );
		}
		return;
	}

	idVec3 eyePos;
	idMat3 viewAxis;
	player->GetViewPos( eyePos, viewAxis );
	trace_t tracer;

	tracer.fraction = 1.0f;
	dotDist = 0.0f;

	int count = 0;

	do {
		gameLocal.clip.TracePoint( tracer, eyePos, eyePos + ( viewAxis[0] * 4096.0f ), MASK_SHOT_RENDERMODEL, player );
		eyePos = tracer.endpos;
		dotDist += ( 4096.0f * tracer.fraction );
		count++;
	} while ( tracer.fraction >= 1.0f && count < 3 );

	dotDist = idMath::ClampFloat( MIN_DIST_DOT, MAX_DIST_DOT, dotDist );
	dotDist = ( dotDist / ( MAX_DIST_DOT - MIN_DIST_DOT ) ) + 1.0f;

	realDotPos = tracer.endpos;
	dotAxis = tracer.c.normal.ToMat3();
}

#undef MAX_DIST_DOT
#undef MIN_DIST_DOT


float SniperDot::GetDotScale( idVec3 &endPos) {
	return q4f_sniperDotScale.GetFloat() * dotDist;

}

void SniperDot::WriteToSnapshot( idBitMsgDelta &msg ) const {
	assert( owner.GetEntity() );

	msg.WriteBits( owner.GetEntity()->entityNumber, ASYNC_MAX_CLIENT_BITS );
	msg.WriteVec3( realDotPos );
	msg.WriteDir( dotAxis[0], 18 );
	msg.WriteFloat( dotDist );
}

void SniperDot::ReadFromSnapshot ( const idBitMsgDelta &msg ) {
	int entityNum = msg.ReadBits( ASYNC_MAX_CLIENT_BITS );

	idVec3 org = msg.ReadVec3();
	idMat3 axis = msg.ReadDir( 18 ).ToMat3();

	float newDotDist = msg.ReadFloat();

	idPlayer* player = GET_PLAYER( entityNum );
	if ( player && owner.GetEntity() != player ) {
		Create( player );
	}
	
	if ( entityNumber != gameLocal.localClientNum ) {
		myDotPos = realDotPos;
		myDotTime = realDotTime;

		realDotPos = org;
		realDotTime = gameLocal.time;
		dotDist = newDotDist;
		dotAxis = axis;
	}
}

void SniperDot::ClientUnstale() {
	myDotTime = realDotTime;
	myDotPos = realDotPos;
}
