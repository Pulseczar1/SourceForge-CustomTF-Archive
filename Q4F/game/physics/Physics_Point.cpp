#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"
#include "../Projectile.h"

CLASS_DECLARATION( idPhysics_Base, q4fPhysics_Point )
END_CLASS

const float PRT_OVERCLIP	= 1.001f;
const float PRT_BOUNCESTOP	= 10.0f;

/*
================
q4fPhysics_Point::DropToFloorAndRest

Drops the object straight down to the floor
================
*/
void q4fPhysics_Point::DropToFloorAndRest( void ) {
	idVec3 down;
	trace_t tr;

	if ( testSolid ) {
		testSolid = false;
		if ( gameLocal.clip.Contents( current.origin, NULL, current.axis, clipMask, self ) ) {
			gameLocal.Warning( "entity in solid '%s' type '%s' at (%s)",
								self->name.c_str(), self->GetType()->classname, current.origin.ToString(0) );
			PutToRest();
			dropToFloor = false;
			return;
		}
	}

	// put the body on the floor
	down = current.origin + gravityNormal * 128.0f;

	gameLocal.clip.TracePoint( tr, current.origin, down, clipMask, self );

	current.origin = tr.endpos;


	// if on the floor already
	if ( tr.fraction <= 0.0f ) {
		PutToRest();
		EvaluateContacts();//Do a final contact check.  Items that drop to floor never do this check otherwise
		dropToFloor = false;
	} else if ( IsOutsideWorld() ) {
		gameLocal.Warning( "entity outside world bounds '%s' type '%s' at (%s)",
							self->name.c_str(), self->GetType()->classname, current.origin.ToString(0) );
		PutToRest();
		dropToFloor = false;
	}
}

/*
================
q4fPhysics_Point::q4fPhysics_Point
================
*/
q4fPhysics_Point::q4fPhysics_Point( void ) {
	SetClipMask( MASK_SOLID );

	memset( &current, 0, sizeof( current ) );
	current.atRest = false;
	current.origin.Zero();
	current.axis.Identity();
	bounds.Zero();
	absBounds.Zero();

	dropToFloor		= false;
	testSolid		= false;
	
	SetFriction( 0.6f, 0.6f, 0.0f );
	SetBouncyness( 0.5f, true );
		
	gravityNormal.Zero();

	radius = 0.0f;

	alwaysCheckGround = false;
}

/*
================
q4fPhysics_Point::~q4fPhysics_Point
================
*/
q4fPhysics_Point::~q4fPhysics_Point( void ) {
}

/*
================
q4fPhysics_Point::SetBouncyness
================
*/
void q4fPhysics_Point::SetBouncyness( const float b, bool _allowBounce ) {
	allowBounce = _allowBounce;
	if ( b < 0.0f || b > 1.0f ) {
		return;
	}
	bouncyness = b;
}

/*
================
q4fPhysics_Point::SetFriction
================
*/
void q4fPhysics_Point::SetFriction( const float linear, const float angular, const float contact ) {
	linearFriction = linear;
	angularFriction = angular;
	contactFriction = contact;
}


/*
================
q4fPhysics_Point::PutToRest
================
*/
void q4fPhysics_Point::PutToRest( void ) {
	current.atRest = true;
	current.velocity.Zero();
	//self->BecomeInactive( TH_PHYSICS );
}

/*
================
q4fPhysics_Point::DropToFloor
================
*/
void q4fPhysics_Point::DropToFloor( void ) {
	dropToFloor = true;
	testSolid = true;
}

/*
================
q4fPhysics_Point::Activate
================
*/
void q4fPhysics_Point::Activate( void ) {
	current.atRest = false;
	self->BecomeActive( TH_PHYSICS );
}

/*
================
q4fPhysics_Point::EvaluateContacts
================
*/
bool q4fPhysics_Point::EvaluateContacts( void ) {
	/*ClearContacts();
	AddGroundContacts( clipModel );

	AddContactEntitiesForContacts();

	return ( contacts.Num() != 0 );*/
	return current.onGround;
}

/*
================
q4fPhysics_Point::SetContents
================
*/
void q4fPhysics_Point::SetContents( int contents, int id ) {
	this->contents = contents;
}

/*
================
q4fPhysics_Point::GetContents
================
*/
int q4fPhysics_Point::GetContents( int id ) const {
	return contents;
}

/*
================
q4fPhysics_Point::GetBounds
================
*/
const idBounds &q4fPhysics_Point::GetBounds( int id ) const {
	return bounds;
}

/*
================
q4fPhysics_Point::GetAbsBounds
================
*/
const idBounds &q4fPhysics_Point::GetAbsBounds( int id ) const {
	return absBounds;
}

/*
================
q4fPhysics_Point::Evaluate

  Evaluate the impulse based rigid body physics.
  When a collision occurs an impulse is applied at the moment of impact but
  the remaining time after the collision is ignored.
================
*/
bool q4fPhysics_Point::Evaluate( int timeStepMSec, int endTimeMSec ) {
	pointPState_t next;

	float			 timeStep;
	float			 upspeed;

	timeStep = MS2SEC( timeStepMSec );

	// if putting the body to rest
	if ( dropToFloor ) {
		DropToFloorAndRest();
		return true;
	}

	// even if we're at rest, continue to check the ground
	if ( alwaysCheckGround )
		CheckGround();

	if ( current.atRest ) {
		if ( alwaysCheckGround && !current.onGround ) {
			Activate();
		}
	}

	if ( current.atRest || timeStep <= 0.0f ) {
		return false;
	}

	if ( !alwaysCheckGround )
		CheckGround();

	// Determine the current upward velocity
	if ( gravityNormal != vec3_zero ) {
		upspeed = -( current.velocity * gravityNormal );
	} else {
		upspeed = current.velocity.z;
	}

	// If not on the ground, or moving upwards, or bouncing and moving toward gravity then do a straight 
	// forward slide move and gravity.		
	if ( !current.onGround || upspeed > 1.0f || (bouncyness > 0.0f && upspeed < -PRT_BOUNCESTOP ) ) {
		// Force ground off when moving upward
		if ( upspeed > 0.0f ) {
			current.onGround = false;
		}
		SlideMove( current.origin, current.velocity, current.velocity * timeStep );		
		if ( current.onGround && upspeed < PRT_BOUNCESTOP ) {
			current.velocity -= ( current.velocity * gravityNormal ) * gravityNormal;
		} else {
			current.velocity += (gravityVector * timeStep);	
		}
	} else {
		idVec3 delta;

		// Slow down due to friction
		ApplyFriction ( timeStep );
	
		delta = current.velocity * timeStep;
		current.velocity -= ( current.velocity * gravityNormal ) * gravityNormal;
		if ( delta == vec3_origin ) {
			PutToRest( );
		} else {
			SlideMove( current.origin, current.velocity, delta );
		}
	}

	// update the position of abs bounds
	absBounds = bounds + current.origin;

	if ( IsOutsideWorld() ) {
		gameLocal.Warning( "clip model outside world bounds for entity '%s' at (%s)", self->name.c_str(), current.origin.ToString(0) );
		PutToRest();
	}

	return true;
}

/*
================
q4fPhysics_Point::UpdateTime
================
*/
void q4fPhysics_Point::UpdateTime( int endTimeMSec ) {
}

/*
================
q4fPhysics_Point::GetTime
================
*/
int q4fPhysics_Point::GetTime( void ) const {
	return gameLocal.time;
}

/*
================
q4fPhysics_Point::IsAtRest
================
*/
bool q4fPhysics_Point::IsAtRest( void ) const {
	return current.atRest;
}

/*
================
q4fPhysics_Point::GetRestStartTime
================
*/
int q4fPhysics_Point::GetRestStartTime( void ) const {
	return -1;
}

/*
================
q4fPhysics_Point::IsPushable
================
*/
bool q4fPhysics_Point::IsPushable( void ) const {
	return true;
}

/*
================
q4fPhysics_Point::SetOrigin
================
*/
void q4fPhysics_Point::SetOrigin( const idVec3 &newOrigin, int id ) {
	absBounds = bounds + current.origin;
	current.origin = newOrigin;
	Activate();
}

/*
================
q4fPhysics_Point::SetAxis
================
*/
void q4fPhysics_Point::SetAxis( const idMat3 &newAxis, int id ) {
	current.axis = newAxis;
	Activate();
}

/*
================
q4fPhysics_Point::Translate
================
*/
void q4fPhysics_Point::Translate( const idVec3 &translation, int id ) {
	current.origin += translation;
	absBounds = bounds + current.origin;
	Activate();
}

/*
================
q4fPhysics_Point::Rotate
================
*/
void q4fPhysics_Point::Rotate( const idRotation &rotation, int id ) {
	current.axis *= rotation.ToMat3();
	Activate();
}

/*
================
q4fPhysics_Point::GetOrigin
================
*/
const idVec3 &q4fPhysics_Point::GetOrigin( int id ) const {
	return current.origin;
}

/*
================
q4fPhysics_Point::GetAxis
================
*/
const idMat3 &q4fPhysics_Point::GetAxis( int id ) const {
	return current.axis;
}

/*
================
q4fPhysics_Point::SetLinearVelocity
================
*/
void q4fPhysics_Point::SetLinearVelocity( const idVec3 &velocity, int id ) {
	current.velocity = velocity;
	Activate();
}

/*
================
q4fPhysics_Point::GetLinearVelocity
================
*/
const idVec3 &q4fPhysics_Point::GetLinearVelocity( int id ) const {
	return current.velocity;
}

/*
=====================
q4fPhysics_Point::CheckGround
=====================
*/
bool q4fPhysics_Point::CheckGround( void ) {
	trace_t	groundTrace;
	idVec3	down;

	if ( gravityNormal == vec3_zero ) {
		current.onGround = false;
		return false;
	}

	down = current.origin + ( gravityNormal * ( CONTACT_EPSILON + radius ) );
	gameLocal.clip.TracePoint( groundTrace, current.origin, down, clipMask, self );
	if ( groundTrace.fraction >= 1.0f ) {
		current.onGround = false;
		return false;
	}

	current.origin = groundTrace.endpos + ( groundTrace.c.normal * radius );

	if ( ( groundTrace.c.normal * -gravityNormal ) < 0.7f ) {
		current.onGround = false;
		return false;
	}

	current.onGround = true;
	return true;
}

/*
================
q4fPhysics_Point::ApplyFriction
================
*/
void q4fPhysics_Point::ApplyFriction( float timeStep ) {
	idVec3	vel;
	float	speed;
	float	newspeed;
	
	// ignore slope movement, remove all velocity in gravity direction
	vel = current.velocity + (current.velocity * gravityNormal) * gravityNormal;

	speed = vel.Length();
	if ( speed < 1.0f ) {
		// remove all movement orthogonal to gravity, allows for sinking underwater
		current.velocity = (current.velocity * gravityNormal) * gravityNormal;
		return;
	}

	// scale the velocity
	if ( current.onGround ) {		
		newspeed = speed - ((speed * contactFriction) * timeStep);
	} else {
		newspeed = speed - ((speed * linearFriction) * timeStep);
	}
		
	if (newspeed < 0) {
		newspeed = 0;
	}
	
	current.velocity *= ( newspeed / speed );
}

/*
================
q4fPhysics_Point::SlideMove
================
*/
bool q4fPhysics_Point::SlideMove( idVec3 &start, idVec3 &velocity, const idVec3 &delta ) {
	int		i;
	trace_t tr;
	idVec3	move;
	bool collide, rtnValue = false;

	int mask = clipMask;

	idVec3 extraMove = ( velocity.ToNormal() * radius );

	move = delta + extraMove;
	for( i = 0; i < 3; i++ ) { // be sure if you change this upper value in the for() to update the exit condition below!!!!!
		gameLocal.clip.TracePoint( tr, start, start + move, mask, extraPassEntity ); 
		
		if ( tr.fraction >= 1.0f ) {
			start += delta;
			if ( i > 0 ) {
				return false;
			}
			return true;
		}

		bool hitTeleporter = false;
		
		// let the entity know about the collision
		collide = self->Collide( tr, current.velocity, hitTeleporter );

		if ( collide ) {
			tr.endpos = tr.endpos + ( tr.c.normal * radius );
			start = tr.endpos;
		}
		else {
			start += delta;
		}	
		
		idEntity* ent;
		ent = gameLocal.entities[tr.c.entityNum];
		assert ( ent );
		
		if ( ent->GetPhysics()->GetContents() & CONTENTS_WATER || tr.c.contents & CONTENTS_WATER ) {
			// Make sure we dont collide with water again
			mask &= ~CONTENTS_WATER;

			// Allow the loop to go one more round to push us through the water
			i--;

			//velocity *= 0.4f;

			//move.ProjectOntoPlane( tr.c.normal, PRT_OVERCLIP );
			continue;
		}
		if ( collide && allowBounce && ( bouncyness > 0.0f || ( tr.c.material && (tr.c.material->GetSurfaceFlags ( ) & SURF_BOUNCE) ) ) ) {
			if ( !hitTeleporter ) {
				float dot;
				move = tr.endpos;
				dot = DotProduct( velocity, tr.c.normal );
				velocity  = ( velocity - ( 2.0f * dot * tr.c.normal ) ) * bouncyness * rvRandom::flrand( 0.99f, 1.01f );
			}
			return true;
		}			
		else {
			i = 4;
			rtnValue = true;
		}


		// clip the movement delta and velocity
		if( collide ) {
			move.ProjectOntoPlane( tr.c.normal, PRT_OVERCLIP );
			velocity.ProjectOntoPlane( tr.c.normal, PRT_OVERCLIP );
		}
	}

	return rtnValue;
}

const float	PRT_VELOCITY_MAX			= 16000;
const int	PRT_VELOCITY_TOTAL_BITS		= 16;
const int	PRT_VELOCITY_EXPONENT_BITS	= idMath::BitsForInteger( idMath::BitsForFloat( PRT_VELOCITY_MAX ) ) + 1;
const int	PRT_VELOCITY_MANTISSA_BITS	= PRT_VELOCITY_TOTAL_BITS - 1 - PRT_VELOCITY_EXPONENT_BITS;

/*
================
q4fPhysics_Point::WriteToSnapshot
================
*/
void q4fPhysics_Point::WriteToSnapshot( idBitMsgDelta &msg ) const {
	msg.WriteBits( current.atRest ? 1 : 0, 1 );
	msg.WriteBits ( current.onGround, 1 );
	msg.WriteFloat( current.origin[0] );
	msg.WriteFloat( current.origin[1] );
	msg.WriteFloat( current.origin[2] );
	msg.WriteDeltaFloat( 0.0f, current.velocity[0] );
	msg.WriteDeltaFloat( 0.0f, current.velocity[1] );
	msg.WriteDeltaFloat( 0.0f, current.velocity[2] );	
}

/*
================
q4fPhysics_Point::ReadFromSnapshot
================
*/
void q4fPhysics_Point::ReadFromSnapshot( const idBitMsgDelta &msg ) {
	//current.atRest = msg.ReadLong();
	current.atRest = msg.ReadBits( 1 ) != 0 ;
	current.onGround = msg.ReadBits( 1 ) != 0 ;
	current.origin[0] = msg.ReadFloat();
	current.origin[1] = msg.ReadFloat();
	current.origin[2] = msg.ReadFloat();
	current.velocity[0] = msg.ReadDeltaFloat( 0.0f );
	current.velocity[1] = msg.ReadDeltaFloat( 0.0f );
	current.velocity[2] = msg.ReadDeltaFloat( 0.0f );

	absBounds = bounds + current.origin;
}

//--------------------------------------------------------------------------
// Used to set the water level if fired inside of water, and for bubble check
//--------------------------------------------------------------------------
bool q4fPhysics_Point::SetWaterLevel() {

	return false;
}
