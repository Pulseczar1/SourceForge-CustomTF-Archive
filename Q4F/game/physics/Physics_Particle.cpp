#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"
#include "../Projectile.h"

CLASS_DECLARATION( idPhysics_Base, rvPhysics_Particle )
END_CLASS

const float PRT_OVERCLIP	= 1.001f;
const float PRT_BOUNCESTOP	= 10.0f;

/*
================
rvPhysics_Particle::DropToFloorAndRest

Drops the object straight down to the floor
================
*/
void rvPhysics_Particle::DropToFloorAndRest( void ) {
	idVec3 down;
	trace_t tr;

	if ( testSolid ) {
		testSolid = false;
		if ( gameLocal.clip.Contents( current.origin, clipModel, clipModel->GetAxis(), clipMask, self ) ) {
			gameLocal.Warning( "entity in solid '%s' type '%s' at (%s)",
								self->name.c_str(), self->GetType()->classname, current.origin.ToString(0) );
			PutToRest();
			dropToFloor = false;
			return;
		}
	}

	// put the body on the floor
	down = current.origin + gravityNormal *  128.0f;


	gameLocal.Translation( tr, current.origin, down, clipModel, clipModel->GetAxis(), clipMask, self );

	current.origin = tr.endpos;


	clipModel->Link( self, clipModel->GetId(), tr.endpos, clipModel->GetAxis() );


	// if on the floor already
	if ( tr.fraction == 0.0f ) {
		EvaluateContacts();//Do a final contact check.  Items that drop to floor never do this check otherwise
	} else if ( IsOutsideWorld() ) {
		gameLocal.Warning( "entity outside world bounds '%s' type '%s' at (%s)",
							self->name.c_str(), self->GetType()->classname, current.origin.ToString(0) );
	}
	PutToRest();
	dropToFloor = false;
}

/*
================
rvPhysics_Particle::DebugDraw
================
*/
void rvPhysics_Particle::DebugDraw( void ) {

	if ( rb_showBodies.GetBool() || ( rb_showActive.GetBool() && !current.atRest ) ) {
		collisionModelManager->DrawModel( clipModel->GetCollisionModel(), clipModel->GetOrigin(), clipModel->GetAxis(), vec3_origin, mat3_identity, 0.0f );
	}

	if ( rb_showContacts.GetBool() ) {
		int i;
		for ( i = 0; i < contacts.Num(); i ++ ) {
			idVec3 x, y;
			contacts[i].normal.NormalVectors( x, y );
			gameRenderWorld->DebugLine( colorWhite, contacts[i].point, contacts[i].point + 6.0f * contacts[i].normal );
			gameRenderWorld->DebugLine( colorWhite, contacts[i].point - 2.0f * x, contacts[i].point + 2.0f * x );
			gameRenderWorld->DebugLine( colorWhite, contacts[i].point - 2.0f * y, contacts[i].point + 2.0f * y );
		}		
	}	
}

/*
================
rvPhysics_Particle::rvPhysics_Particle
================
*/
rvPhysics_Particle::rvPhysics_Particle( void ) {
	SetClipMask( MASK_SOLID );
	SetBouncyness( 0.6f, true );
	clipModel = NULL;

	memset( &current, 0, sizeof( current ) );
	current.atRest = false;
	current.origin.Zero();
	saved = current;

	dropToFloor		= false;
	testSolid		= false;
	hasMaster		= false;
	
	SetFriction( 0.6f, 0.6f, 0.0f );
	SetBouncyness ( 0.5f, true );
		
	gravityNormal.Zero();

	alwaysCheckGround = false;
}

/*
================
rvPhysics_Particle::~rvPhysics_Particle
================
*/
rvPhysics_Particle::~rvPhysics_Particle( void ) {
	if ( clipModel ) {
		delete clipModel;
		clipModel = NULL;
	}
}

/*
================
rvPhysics_Particle::Save
================
*/
void rvPhysics_Particle::Save( idSaveGame *savefile ) const {
	//savefile->WriteInt( current.atRest );
	savefile->WriteVec3( current.localOrigin );
	savefile->WriteMat3( current.localAxis );
	savefile->WriteVec3( current.pushVelocity );
	savefile->WriteVec3( current.origin );
	savefile->WriteVec3( current.velocity );
	savefile->WriteBool( current.onGround );
	savefile->WriteBool( current.inWater );		// cnicholson: Added unsaved var

	//savefile->WriteInt( saved.atRest );			// cnicholson: Added unsaved vars
	savefile->WriteVec3( saved.localOrigin );
	savefile->WriteMat3( saved.localAxis );
	savefile->WriteVec3( saved.pushVelocity );
	savefile->WriteVec3( saved.origin );
	savefile->WriteVec3( saved.velocity );
	savefile->WriteBool( saved.onGround );
	savefile->WriteBool( saved.inWater );

	savefile->WriteFloat( linearFriction );
	savefile->WriteFloat( angularFriction );
	savefile->WriteFloat( contactFriction );
	savefile->WriteFloat( bouncyness );
	savefile->WriteBool ( allowBounce );
	savefile->WriteBounds ( clipModel->GetBounds ( ) );	// cnicholson: Added unsaved var

	savefile->WriteBool( dropToFloor );
	savefile->WriteBool( testSolid );

	savefile->WriteBool( hasMaster );
	savefile->WriteBool( isOrientated );	// cnicholson: Added unsaved var
	extraPassEntity.Save( savefile );

	savefile->WriteClipModel( clipModel );
}

/*
================
rvPhysics_Particle::Restore
================
*/
void rvPhysics_Particle::Restore( idRestoreGame *savefile ) {
	//savefile->ReadInt( current.atRest );
	savefile->ReadVec3( current.localOrigin );
	savefile->ReadMat3( current.localAxis );
	savefile->ReadVec3( current.pushVelocity );
	savefile->ReadVec3( current.origin );
	savefile->ReadVec3( current.velocity );
	savefile->ReadBool( current.onGround );
	savefile->ReadBool( current.inWater );		// cnicholson: Added unsaved var

	//savefile->ReadInt( saved.atRest );			// cnicholson: Added unsaved vars
	savefile->ReadVec3( saved.localOrigin );
	savefile->ReadMat3( saved.localAxis );
	savefile->ReadVec3( saved.pushVelocity );
	savefile->ReadVec3( saved.origin );
	savefile->ReadVec3( saved.velocity );
	savefile->ReadBool( saved.onGround );
	savefile->ReadBool( saved.inWater );

	savefile->ReadFloat( linearFriction );
	savefile->ReadFloat( angularFriction );
	savefile->ReadFloat( contactFriction );
	savefile->ReadFloat( bouncyness );
	savefile->ReadBool ( allowBounce );

	idBounds bounds;					// cnicholson: Added unrestored var
	delete clipModel;
	savefile->ReadBounds ( bounds );
	clipModel = new idClipModel ( idTraceModel ( bounds ) );

	savefile->ReadBool( dropToFloor );
	savefile->ReadBool( testSolid );

	savefile->ReadBool( hasMaster );
	savefile->ReadBool( isOrientated );	// cnicholson: Added unrestored var
	extraPassEntity.Restore( savefile );

	savefile->ReadClipModel( clipModel );
}

/*
================
rvPhysics_Particle::SetClipModel
================
*/
void rvPhysics_Particle::SetClipModel( idClipModel *model, const float density, int id, bool freeOld ) {

	assert( self );
	assert( model );					// we need a clip model
	assert( model->IsTraceModel() );	// and it should be a trace model

	if ( clipModel && clipModel != model && freeOld ) {
		delete clipModel;
	}
	
	clipModel = model;


	clipModel->Link( self, 0, current.origin, clipModel->GetAxis() );

}

/*
================
rvPhysics_Particle::GetClipModel
================
*/
idClipModel *rvPhysics_Particle::GetClipModel( int id ) const {
	return clipModel;
}

/*
================
rvPhysics_Particle::GetNumClipModels
================
*/
int rvPhysics_Particle::GetNumClipModels( void ) const {
	return 1;
}

/*
================
rvPhysics_Particle::SetBouncyness
================
*/
void rvPhysics_Particle::SetBouncyness( const float b, bool _allowBounce ) {
	allowBounce = _allowBounce;
	if ( b < 0.0f || b > 1.0f ) {
		return;
	}
	bouncyness = b;
}

/*
================
rvPhysics_Particle::SetFriction
================
*/
void rvPhysics_Particle::SetFriction( const float linear, const float angular, const float contact ) {
	linearFriction = linear;
	angularFriction = angular;
	contactFriction = contact;
}


/*
================
rvPhysics_Particle::PutToRest
================
*/
void rvPhysics_Particle::PutToRest( void ) {
	current.atRest = true;
	current.velocity.Zero();
	//self->BecomeInactive( TH_PHYSICS );
}

/*
================
rvPhysics_Particle::DropToFloor
================
*/
void rvPhysics_Particle::DropToFloor( void ) {
	dropToFloor = true;
	testSolid = true;
}

/*
================
rvPhysics_Particle::Activate
================
*/
void rvPhysics_Particle::Activate( void ) {
	current.atRest = false;
	self->BecomeActive( TH_PHYSICS );
}

/*
================
rvPhysics_Particle::EvaluateContacts
================
*/
bool rvPhysics_Particle::EvaluateContacts( void ) {
	ClearContacts();
	AddGroundContacts( clipModel );

	AddContactEntitiesForContacts();

	return ( contacts.Num() != 0 );
}

/*
================
rvPhysics_Particle::SetContents
================
*/
void rvPhysics_Particle::SetContents( int contents, int id ) {
	clipModel->SetContents( contents );
}

/*
================
rvPhysics_Particle::GetContents
================
*/
int rvPhysics_Particle::GetContents( int id ) const {
	return clipModel->GetContents();
}

/*
================
rvPhysics_Particle::GetBounds
================
*/
const idBounds &rvPhysics_Particle::GetBounds( int id ) const {
	return clipModel->GetBounds();
}

/*
================
rvPhysics_Particle::GetAbsBounds
================
*/
const idBounds &rvPhysics_Particle::GetAbsBounds( int id ) const {
	return clipModel->GetAbsBounds();
}

/*
================
rvPhysics_Particle::Evaluate

  Evaluate the impulse based rigid body physics.
  When a collision occurs an impulse is applied at the moment of impact but
  the remaining time after the collision is ignored.
================
*/
bool rvPhysics_Particle::Evaluate( int timeStepMSec, int endTimeMSec ) {
	particlePState_t next;
	float			 timeStep;
	float			 upspeed;

	timeStep = MS2SEC( timeStepMSec );

	// if bound to a master
	if ( hasMaster ) {
		idVec3	masterOrigin;
		idMat3	masterAxis;
		idVec3	oldOrigin;		
		
		oldOrigin = current.origin;
		
		self->GetMasterPosition( masterOrigin, masterAxis );
		current.origin = masterOrigin + current.localOrigin * masterAxis;


		clipModel->Link( self, clipModel->GetId(), current.origin, current.localAxis * masterAxis );


		trace_t tr;
		gameLocal.Translation( tr, oldOrigin, current.origin, clipModel, clipModel->GetAxis(), clipMask, self );
		
		if ( tr.fraction < 1.0f ) {
			self->Collide ( tr, current.origin - oldOrigin );
		}
		
		DebugDraw();
		
		return true;
	}

	// if putting the body to rest
	if ( dropToFloor ) {
		DropToFloorAndRest();
		return true;
	}

	// Determine if currently on the ground
	if ( alwaysCheckGround )
		CheckGround ( );

	// if the body is at rest
	if ( current.atRest ) {
		if ( alwaysCheckGround && !current.onGround ) {
			Activate();
		}
	}

	if ( current.atRest || timeStep <= 0.0f ) {
		return false;
	}

	clipModel->Unlink();

	if ( !alwaysCheckGround )
		CheckGround ( );

	SetWaterLevel();
	
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

	// update the position of the clip model


	clipModel->Link( self, clipModel->GetId(), current.origin, clipModel->GetAxis() );


	DebugDraw();

	// get all the ground contacts
	EvaluateContacts();

	current.pushVelocity.Zero();

	if ( IsOutsideWorld() ) {
		gameLocal.Warning( "clip model outside world bounds for entity '%s' at (%s)", self->name.c_str(), current.origin.ToString(0) );
		PutToRest();
	}

	return true;
}

/*
================
rvPhysics_Particle::UpdateTime
================
*/
void rvPhysics_Particle::UpdateTime( int endTimeMSec ) {
}

/*
================
rvPhysics_Particle::GetTime
================
*/
int rvPhysics_Particle::GetTime( void ) const {
	return gameLocal.time;
}

/*
================
rvPhysics_Particle::IsAtRest
================
*/
bool rvPhysics_Particle::IsAtRest( void ) const {
	return current.atRest;
}

/*
================
rvPhysics_Particle::GetRestStartTime
================
*/
int rvPhysics_Particle::GetRestStartTime( void ) const {
	return -1;
}

/*
================
rvPhysics_Particle::IsPushable
================
*/
bool rvPhysics_Particle::IsPushable( void ) const {
	return ( !hasMaster );
}

/*
================
rvPhysics_Particle::SaveState
================
*/
void rvPhysics_Particle::SaveState( void ) {
	saved = current;
}

/*
================
rvPhysics_Particle::RestoreState
================
*/
void rvPhysics_Particle::RestoreState( void ) {
	current = saved;


	clipModel->Link( self, clipModel->GetId(), current.origin, clipModel->GetAxis() );

	EvaluateContacts();
}

/*
================
idPhysics::SetOrigin
================
*/
void rvPhysics_Particle::SetOrigin( const idVec3 &newOrigin, int id ) {
	idVec3 masterOrigin;
	idMat3 masterAxis;

	current.localOrigin = newOrigin;
	if ( hasMaster ) {
		self->GetMasterPosition( masterOrigin, masterAxis );
		current.origin = masterOrigin + newOrigin * masterAxis;
	}
	else {
		current.origin = newOrigin;
	}


	clipModel->Link( self, clipModel->GetId(), current.origin, clipModel->GetAxis() );


	Activate();
}

/*
================
idPhysics::SetAxis
================
*/
void rvPhysics_Particle::SetAxis( const idMat3 &newAxis, int id ) {
	current.localAxis = newAxis;


	clipModel->Link( self, 0, clipModel->GetOrigin(), newAxis );

	Activate();
}

/*
================
rvPhysics_Particle::Translate
================
*/
void rvPhysics_Particle::Translate( const idVec3 &translation, int id ) {

	current.localOrigin += translation;
	current.origin += translation;


	clipModel->Link( self, clipModel->GetId(), current.origin, clipModel->GetAxis() );


	Activate();
}

/*
================
rvPhysics_Particle::Rotate(
================
*/
void rvPhysics_Particle::Rotate( const idRotation &rotation, int id ) {
	idVec3 masterOrigin;
	idMat3 masterAxis;

	current.origin *= rotation;
	if ( hasMaster ) {
		self->GetMasterPosition( masterOrigin, masterAxis );
		current.localOrigin = ( current.origin - masterOrigin ) * masterAxis.Transpose();
	}
	else {
		current.localOrigin = current.origin;
	}


	clipModel->Link( self, 0, current.origin, clipModel->GetAxis() * rotation.ToMat3() );

	Activate();
}

/*
================
rvPhysics_Particle::GetOrigin
================
*/
const idVec3 &rvPhysics_Particle::GetOrigin( int id ) const {
	return clipModel->GetOrigin();
}

/*
================
rvPhysics_Particle::GetAxis
================
*/
const idMat3 &rvPhysics_Particle::GetAxis( int id ) const {
	if ( !clipModel ) {
		return idPhysics_Base::GetAxis ( id );
	}
	return clipModel->GetAxis();
}

/*
================
rvPhysics_Particle::SetLinearVelocity
================
*/
void rvPhysics_Particle::SetLinearVelocity( const idVec3 &velocity, int id ) {
	current.velocity = velocity;
	Activate();
}

/*
================
rvPhysics_Particle::GetLinearVelocity
================
*/
const idVec3 &rvPhysics_Particle::GetLinearVelocity( int id ) const {
	return current.velocity;
}

/*
================
rvPhysics_Particle::ClipTranslation
================
*/
void rvPhysics_Particle::ClipTranslation( trace_t &results, const idVec3 &translation, const idClipModel *model ) const {
	if ( model ) {
		gameLocal.clip.TranslationModel( results, clipModel->GetOrigin(), clipModel->GetOrigin() + translation,
											clipModel, clipModel->GetAxis(), clipMask,
											model->GetCollisionModel(), model->GetOrigin(), model->GetAxis() );
	}
	else {
		gameLocal.Translation( results, clipModel->GetOrigin(), clipModel->GetOrigin() + translation,
											clipModel, clipModel->GetAxis(), clipMask, self );
	}
}

/*
================
rvPhysics_Particle::ClipRotation
================
*/
void rvPhysics_Particle::ClipRotation( trace_t &results, const idRotation &rotation, const idClipModel *model ) const {
	if ( model ) {
		gameLocal.clip.RotationModel( results, clipModel->GetOrigin(), rotation,
											clipModel, clipModel->GetAxis(), clipMask,
											model->GetCollisionModel(), model->GetOrigin(), model->GetAxis() );
	}
	else {
		gameLocal.clip.Rotation( results, clipModel->GetOrigin(), rotation,
											clipModel, clipModel->GetAxis(), clipMask, self );
	}
}

/*
================
rvPhysics_Particle::ClipContents
================
*/
int rvPhysics_Particle::ClipContents( const idClipModel *model ) const {
	if ( model ) {
		return gameLocal.clip.ContentsModel( clipModel->GetOrigin(), clipModel, clipModel->GetAxis(), -1,
									model->GetCollisionModel(), model->GetOrigin(), model->GetAxis() );
	}
	else {
		return gameLocal.clip.Contents( clipModel->GetOrigin(), clipModel, clipModel->GetAxis(), -1, NULL );
	}
}

/*
================
rvPhysics_Particle::DisableClip
================
*/
void rvPhysics_Particle::DisableClip( void ) {
	clipModel->Disable();
}

/*
================
rvPhysics_Particle::EnableClip
================
*/
void rvPhysics_Particle::EnableClip( void ) {
	clipModel->Enable();
}

/*
================
rvPhysics_Particle::UnlinkClip
================
*/
void rvPhysics_Particle::UnlinkClip( void ) {
	clipModel->Unlink();
}

/*
================
rvPhysics_Particle::LinkClip
================
*/
void rvPhysics_Particle::LinkClip( void ) {


	clipModel->Link( self, clipModel->GetId(), current.origin, clipModel->GetAxis() );

}

/*
================
rvPhysics_Particle::SetPushed
================
*/
void rvPhysics_Particle::SetPushed( int deltaTime ) {
	// velocity with which the particle is pushed
	current.pushVelocity = ( current.origin - saved.origin ) / ( deltaTime * idMath::M_MS2SEC );
}

/*
================
rvPhysics_Particle::GetPushedLinearVelocity
================
*/
const idVec3 &rvPhysics_Particle::GetPushedLinearVelocity( const int id ) const {
	return current.pushVelocity;
}

/*
================
rvPhysics_Particle::SetMaster
================
*/
void rvPhysics_Particle::SetMaster( idEntity *master, const bool orientated ) {
	idVec3 masterOrigin;
	idMat3 masterAxis;

	if ( master ) {
		if ( !hasMaster ) {
			// transform from world space to master space
			self->GetMasterPosition( masterOrigin, masterAxis );
			current.localOrigin = ( current.origin - masterOrigin ) * masterAxis.Transpose();
			hasMaster = true;
		}
		ClearContacts();
	}
	else {
		if ( hasMaster ) {
			hasMaster = false;
			Activate();
		}
	}
}

/*
=====================
rvPhysics_Particle::CheckGround
=====================
*/
void rvPhysics_Particle::CheckGround( void ) {
	trace_t	groundTrace;
	idVec3	down;

	if ( gravityNormal == vec3_zero ) {
		current.onGround = false;
		return;
	}

	down = current.origin + gravityNormal * CONTACT_EPSILON;
	gameLocal.Translation( groundTrace, current.origin, down, clipModel, clipModel->GetAxis(), clipMask, self );
	if ( groundTrace.fraction == 1.0f ) {
		current.onGround = false;
		return;
	}

	if ( ( groundTrace.c.normal * -gravityNormal ) < 0.7f ) {
		current.onGround = false;
		return;
	}

	current.onGround = true;
}

/*
================
rvPhysics_Particle::ApplyFriction
================
*/
void rvPhysics_Particle::ApplyFriction( float timeStep ) {
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
rvPhysics_Particle::SlideMove
================
*/
bool rvPhysics_Particle::SlideMove( idVec3 &start, idVec3 &velocity, const idVec3 &delta ) {
	int		i;
	trace_t tr;
	idVec3	move;
	bool collide, rtnValue = false;

	idEntity* pass = extraPassEntity;

	move = delta;
	for( i = 0; i < 3; i++ ) { // be sure if you change this upper value in the for() to update the exit condition below!!!!!
		gameLocal.Translation( tr, start, start + move, clipModel, clipModel->GetAxis(), clipMask, self, pass );

		start = tr.endpos;

		if ( tr.fraction == 1.0f ) {
			if ( i > 0 ) {
				return false;
			}
			return true;
		}

		//gameRenderWorld->DebugBounds( colorRed, GetAbsBounds(), vec3_zero, 20000 );

		idEntity* ent = gameLocal.entities[tr.c.entityNum];
		assert ( ent );

		if ( ent->IsType( q4fAntiTeam::GetClassType() ) && self->IsType( idProjectile::GetClassType() ) ) {
			q4fAntiTeam* at = static_cast<q4fAntiTeam*>( ent );

			if ( at->killProj ) {
				static_cast<idProjectile*>( self )->PostEventMS( &EV_Detonate, 0 );
			}
			else {
				if ( !at->blockProj ) {
					pass = at;
					i--;
					continue;
				}
				else {
					static_cast<idProjectile*>( self )->Relaunch( q4fAntiTeam::GetReflection( self, &tr ) );
					return false;
				}
			}
		}
		
		bool hitTeleporter = false;
		
		// let the entity know about the collision
		collide = self->Collide( tr, current.velocity, hitTeleporter );
		
		// If we hit water just clip the move for now and keep on going
		if ( ent->GetPhysics()->GetContents() & CONTENTS_WATER || ( tr.c.material && ( tr.c.material->GetSurfaceFlags() & CONTENTS_WATER ) ) ) {

			//gameRenderWorld->DebugBounds( colorBlue, GetAbsBounds(), vec3_zero, 20000 );

			// Make sure we dont collide with water again
			clipMask &= ~CONTENTS_WATER;
			
			current.inWater = true;
			
			// Allow the loop to go one more round to push us through the water
			//i--;
						
			//velocity *= 0.4f;
						
			move.ProjectOntoPlane( tr.c.normal, PRT_OVERCLIP );
			continue;
		// bounce the projectile
		// 3j: allow bounce in water
		//} else if ( !current.inWater && allowBounce && bouncyness ) {
		}
		else if ( allowBounce && bouncyness ) {
			if ( !hitTeleporter ) {
				float dot;
				move = tr.endpos;
				dot = DotProduct( velocity, tr.c.normal );
				velocity  = ( velocity - ( 2.0f * dot * tr.c.normal ) ) * bouncyness;
			}
			return true;

//jshepard: tr.c.material can (did) crash here if null
		} else if ( allowBounce && tr.c.material && (tr.c.material->GetSurfaceFlags ( ) & SURF_BOUNCE) ) {

			float dot;
			move = tr.endpos;
			dot = DotProduct( velocity, tr.c.normal );
			velocity  = ( velocity - ( 2.0f * dot * tr.c.normal ) );
			return true;
		}			

// dluetscher: removed redundant trace calls
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
rvPhysics_Particle::WriteToSnapshot
================
*/
void rvPhysics_Particle::WriteToSnapshot( idBitMsgDelta &msg ) const {
	msg.WriteBits( current.atRest ? 1 : 0, 1 );
	msg.WriteBits ( current.onGround ? 1 : 0, 1 );
	msg.WriteFloat( current.origin[0] );
	msg.WriteFloat( current.origin[1] );
	msg.WriteFloat( current.origin[2] );
//	msg.WriteFloat( current.velocity[0], PRT_VELOCITY_EXPONENT_BITS, PRT_VELOCITY_MANTISSA_BITS );
//	msg.WriteFloat( current.velocity[1], PRT_VELOCITY_EXPONENT_BITS, PRT_VELOCITY_MANTISSA_BITS );
//	msg.WriteFloat( current.velocity[2], PRT_VELOCITY_EXPONENT_BITS, PRT_VELOCITY_MANTISSA_BITS );
	msg.WriteDeltaFloat( 0.0f, current.velocity[0] );
	msg.WriteDeltaFloat( 0.0f, current.velocity[1] );
	msg.WriteDeltaFloat( 0.0f, current.velocity[2] );
//	msg.WriteDeltaFloat( 0.0f, current.pushVelocity[0], PRT_VELOCITY_EXPONENT_BITS, PRT_VELOCITY_MANTISSA_BITS );
//	msg.WriteDeltaFloat( 0.0f, current.pushVelocity[1], PRT_VELOCITY_EXPONENT_BITS, PRT_VELOCITY_MANTISSA_BITS );
//	msg.WriteDeltaFloat( 0.0f, current.pushVelocity[2], PRT_VELOCITY_EXPONENT_BITS, PRT_VELOCITY_MANTISSA_BITS );
	msg.WriteDeltaFloat( 0.0f, current.pushVelocity[0] );
	msg.WriteDeltaFloat( 0.0f, current.pushVelocity[1] );
	msg.WriteDeltaFloat( 0.0f, current.pushVelocity[2] );

	// TODO: Check that this conditional write to delta message is OK
	if ( hasMaster ) {
		idCQuat localQuat;
		localQuat = current.localAxis.ToCQuat();
		
		msg.WriteBits ( 1, 1 );
		msg.WriteFloat( localQuat.x );
		msg.WriteFloat( localQuat.y );
		msg.WriteFloat( localQuat.z );
		msg.WriteDeltaFloat( current.origin[0], current.localOrigin[0] );
		msg.WriteDeltaFloat( current.origin[1], current.localOrigin[1] );
		msg.WriteDeltaFloat( current.origin[2], current.localOrigin[2] );
	} else { 
		msg.WriteBits ( 0, 1 );
	}		
}

/*
================
rvPhysics_Particle::ReadFromSnapshot
================
*/
void rvPhysics_Particle::ReadFromSnapshot( const idBitMsgDelta &msg ) {
	current.atRest = msg.ReadBits( 1 ) == 1;
	current.onGround = msg.ReadBits( 1 ) == 1;
	current.origin[0] = msg.ReadFloat();
	current.origin[1] = msg.ReadFloat();
	current.origin[2] = msg.ReadFloat();
//	current.velocity[0] = msg.ReadFloat( PRT_VELOCITY_EXPONENT_BITS, PRT_VELOCITY_MANTISSA_BITS );
//	current.velocity[1] = msg.ReadFloat( PRT_VELOCITY_EXPONENT_BITS, PRT_VELOCITY_MANTISSA_BITS );
//	current.velocity[2] = msg.ReadFloat( PRT_VELOCITY_EXPONENT_BITS, PRT_VELOCITY_MANTISSA_BITS );
	current.velocity[0] = msg.ReadDeltaFloat( 0.0f );
	current.velocity[1] = msg.ReadDeltaFloat( 0.0f );
	current.velocity[2] = msg.ReadDeltaFloat( 0.0f );
//	current.pushVelocity[0] = msg.ReadDeltaFloat( 0.0f, PRT_VELOCITY_EXPONENT_BITS, PRT_VELOCITY_MANTISSA_BITS );
//	current.pushVelocity[1] = msg.ReadDeltaFloat( 0.0f, PRT_VELOCITY_EXPONENT_BITS, PRT_VELOCITY_MANTISSA_BITS );
//	current.pushVelocity[2] = msg.ReadDeltaFloat( 0.0f, PRT_VELOCITY_EXPONENT_BITS, PRT_VELOCITY_MANTISSA_BITS );
	current.pushVelocity[0] = msg.ReadDeltaFloat( 0.0f );
	current.pushVelocity[1] = msg.ReadDeltaFloat( 0.0f );
	current.pushVelocity[2] = msg.ReadDeltaFloat( 0.0f );

	if ( msg.ReadBits ( 1 ) ) {
		idCQuat localQuat;
		localQuat.x = msg.ReadFloat( );
		localQuat.y = msg.ReadFloat( );
		localQuat.z = msg.ReadFloat( );
		current.localOrigin[0] = msg.ReadDeltaFloat( current.origin[0] );
		current.localOrigin[1] = msg.ReadDeltaFloat( current.origin[1] );
		current.localOrigin[2] = msg.ReadDeltaFloat( current.origin[2] );
		current.localAxis = localQuat.ToMat3();
	}

	if ( clipModel ) {


		clipModel->Link( self, clipModel->GetId(), current.origin, clipModel->GetAxis() );

	}
}

// <q4f> 


//--------------------------------------------------------------------------
// Used to set the water level if fired inside of water, and for bubble check
//--------------------------------------------------------------------------
bool rvPhysics_Particle::SetWaterLevel() {
	waterLevel = 0.0f;
	waterType = 0;

	int contents = gameLocal.clip.Contents( current.origin, NULL, mat3_identity, -1, self );
	if ( contents & MASK_WATER ) {
		current.inWater = true;
		waterLevel = 1.0f;
		waterType = contents;
		return true;
	}

	return false;
}

// </q4f>
