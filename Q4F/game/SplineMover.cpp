#include "../idlib/precompiled.h"
#pragma hdrstop

#include "Game_local.h"
#include "spawner.h"

const idEventDef EV_OnAcceleration( "<onAcceleration>" );
const idEventDef EV_OnDeceleration( "<onDeceleration>" );
const idEventDef EV_OnCruising( "<onCruising>" );

const idEventDef EV_OnStartMoving( "<onStartMoving>" );
const idEventDef EV_OnStopMoving( "<onStopMoving>" );

//=======================================================
//
//	rvPhysics_Spline
//
//=======================================================
CLASS_DECLARATION( idPhysics_Base, rvPhysics_Spline )
	EVENT( EV_PostRestore,			rvPhysics_Spline::Event_PostRestore )
END_CLASS

void splinePState_t::ApplyAccelerationDelta( float timeStepSec ) {
	speed = SignZero(idealSpeed) * Min( idMath::Fabs(idealSpeed), idMath::Fabs(speed) + acceleration * timeStepSec );
}

void splinePState_t::ApplyDecelerationDelta( float timeStepSec ) {
	speed = SignZero(speed) * Max( idMath::Fabs(idealSpeed), idMath::Fabs(speed) - deceleration * timeStepSec );
}

void splinePState_t::UpdateDist( float timeStepSec ) {
	dist += speed * timeStepSec;
}

bool splinePState_t::ShouldAccelerate() const {
	if( Sign(idealSpeed) == Sign(speed) ) {
		return idMath::Fabs(speed) < idMath::Fabs(idealSpeed);
	} else if( !Sign(speed) ) {
		return true;
	}
	
	return false;
}

bool splinePState_t::ShouldDecelerate() const {
	if( Sign(speed) == Sign(idealSpeed) ) {
		return idMath::Fabs(speed) > idMath::Fabs(idealSpeed);
	} else if( !Sign(idealSpeed) ) {
		return true;
	}

	return false;
}

void splinePState_t::Clear() {
	origin.Zero();
	localOrigin.Zero();
	axis.Identity();
	localAxis.Identity();
	speed = 0.0f;
	idealSpeed = 0.0f;
	dist = 0.0f;
	acceleration = 0.0f;
	deceleration = 0.0f;
}

void splinePState_t::WriteToSnapshot( idBitMsgDelta &msg ) const {
	msg.WriteDeltaVec3( vec3_zero, origin );
	msg.WriteDeltaVec3( vec3_zero, localOrigin );
	msg.WriteDeltaMat3( mat3_identity, axis );
	msg.WriteDeltaMat3( mat3_identity, localAxis );
	msg.WriteDeltaFloat( 0.0f, speed );
	msg.WriteDeltaFloat( 0.0f, idealSpeed );
	msg.WriteDeltaFloat( 0.0f, dist );
	msg.WriteDeltaFloat( 0.0f, acceleration );
	msg.WriteDeltaFloat( 0.0f, deceleration );
}

void splinePState_t::ReadFromSnapshot( const idBitMsgDelta &msg ) {
	origin = msg.ReadDeltaVec3( vec3_zero );
	localOrigin = msg.ReadDeltaVec3( vec3_zero );
	axis = msg.ReadDeltaMat3( mat3_identity );
	localAxis = msg.ReadDeltaMat3( mat3_identity );
	speed = msg.ReadDeltaFloat( 0.0f );
	idealSpeed = msg.ReadDeltaFloat( 0.0f );
	dist = msg.ReadDeltaFloat( 0.0f );
	acceleration = msg.ReadDeltaFloat( 0.0f );
	deceleration = msg.ReadDeltaFloat( 0.0f );
}

void splinePState_t::Save( idSaveGame *savefile ) const {
	savefile->WriteVec3( origin );
	savefile->WriteVec3( localOrigin );
	savefile->WriteMat3( axis );
	savefile->WriteMat3( localAxis );
	savefile->WriteFloat( speed );
	savefile->WriteFloat( idealSpeed );
	savefile->WriteFloat( dist );
	savefile->WriteFloat( acceleration );
	savefile->WriteFloat( deceleration );
}

void splinePState_t::Restore( idRestoreGame *savefile ) {
	savefile->ReadVec3( origin );
	savefile->ReadVec3( localOrigin );
	savefile->ReadMat3( axis );
	savefile->ReadMat3( localAxis );
	savefile->ReadFloat( speed );
	savefile->ReadFloat( idealSpeed );
	savefile->ReadFloat( dist );
	savefile->ReadFloat( acceleration );
	savefile->ReadFloat( deceleration );
}

splinePState_t&	splinePState_t::Assign( const splinePState_t* state ) {
	SIMDProcessor->Memcpy( this, state, sizeof(splinePState_t) );
	return *this;
}

splinePState_t&	splinePState_t::operator=( const splinePState_t& state ) {
	return Assign( &state );
}

splinePState_t&	splinePState_t::operator=( const splinePState_t* state ) {
	return Assign( state );
}

/*
================
rvPhysics_Spline::rvPhysics_Spline
================
*/
rvPhysics_Spline::rvPhysics_Spline( void ) {
	accelDecelStateThread.SetName( "AccelDecel" );
	accelDecelStateThread.SetOwner( this );
	accelDecelStateThread.SetState( "Cruising" );

	clipModel = NULL;

	spline = NULL;
	SetSplineEntity( NULL );

	memset( &pushResults, 0, sizeof(trace_t) );
	pushResults.fraction = 1.0f;

	current.Clear();
	SaveState();
}

/*
================
rvPhysics_Spline::~rvPhysics_Spline
================
*/
rvPhysics_Spline::~rvPhysics_Spline( void ) {
	SAFE_DELETE_PTR( clipModel );

	SAFE_DELETE_PTR( spline );
}

/*
================
rvPhysics_Spline::Save
================
*/
void rvPhysics_Spline::Save( idSaveGame *savefile ) const {

	current.Save( savefile );
	saved.Save( savefile );

	savefile->WriteFloat( splineLength );
	// This spline was retored as NULL, so there's no reason to save it.
	//savefile->WriteInt(spline != NULL ? spline->GetTime( 0 ) : -1 );	// cnicholson: Added unsaved var
	splineEntity.Save( savefile );

	savefile->WriteTrace( pushResults );

	savefile->WriteClipModel( clipModel );

	accelDecelStateThread.Save( savefile );
}

/*
================
rvPhysics_Spline::Restore
================
*/
void rvPhysics_Spline::Event_PostRestore( void ) {

	if( splineEntity.IsValid() ) {
		spline = splineEntity->GetSpline();
	}
}

void rvPhysics_Spline::Restore( idRestoreGame *savefile ) {

	current.Restore( savefile );
	saved.Restore( savefile );

	savefile->ReadFloat( splineLength );
	SAFE_DELETE_PTR( spline );
	splineEntity.Restore( savefile );

	savefile->ReadTrace( pushResults );
	
	savefile->ReadClipModel( clipModel );

	accelDecelStateThread.Restore( savefile, this );
}

/*
================
rvPhysics_Spline::SetClipModel
================
*/
void rvPhysics_Spline::SetClipModel( idClipModel *model, const float density, int id, bool freeOld ) {

	assert( self );
	assert( model );					// we need a clip model

	if ( clipModel && clipModel != model && freeOld ) {
		delete clipModel;
	}
	
	clipModel = model;

	LinkClip();
}

/*
================
rvPhysics_Spline::GetClipModel
================
*/
idClipModel *rvPhysics_Spline::GetClipModel( int id ) const {
	return clipModel;
}

/*
================
rvPhysics_Spline::SetContents
================
*/
void rvPhysics_Spline::SetContents( int contents, int id ) {
	clipModel->SetContents( contents );
}

/*
================
rvPhysics_Spline::GetContents
================
*/
int rvPhysics_Spline::GetContents( int id ) const {
	return clipModel->GetContents();
}

/*
================
rvPhysics_Spline::GetBounds
================
*/
const idBounds &rvPhysics_Spline::GetBounds( int id ) const {
	return clipModel->GetBounds();
}

/*
================
rvPhysics_Spline::GetAbsBounds
================
*/
const idBounds &rvPhysics_Spline::GetAbsBounds( int id ) const {
	return clipModel->GetAbsBounds();
}

/*
================
rvPhysics_Spline::SetSpline
================
*/
void rvPhysics_Spline::SetSpline( idCurve_Spline<idVec3>* spline ) {
	SAFE_DELETE_PTR( this->spline );

	//Keep any left over dist from last spline to minimize hitches
	if( GetSpeed() >= 0.0f ) {
		current.dist = Max( 0.0f, current.dist - splineLength );
	}

	if( !spline ) {
		splineLength = 0.0f;
		return;
	}

	this->spline = spline;
 
	splineLength = spline->GetLengthForTime( spline->GetTime(spline->GetNumValues() - 1) );
	if( GetSpeed() < 0.0f ) {
		current.dist = splineLength - current.dist;
	}

	Activate();
}

/*
================
rvPhysics_Spline::SetSplineEntity
================
*/
void rvPhysics_Spline::SetSplineEntity( idSplinePath* spline ) {
	splineEntity = spline;
	SetSpline( (spline) ? spline->GetSpline() : NULL );
}

/*
================
rvPhysics_Spline::ComputeDecelFromSpline
================
*/
float rvPhysics_Spline::ComputeDecelFromSpline() const {
	// FIXME: merge this in better.  It seems very special case
	float numerator = GetSpeed() * GetSpeed();
	float denomonator = 2.0f * ((GetSpeed() >= 0.0f) ? (splineLength - current.dist) : current.dist);

	assert( denomonator > VECTOR_EPSILON );

	return numerator / denomonator;
}

/*
================
rvPhysics_Spline::SetLinearAcceleration
================
*/
void rvPhysics_Spline::SetLinearAcceleration( const float accel ) {
	current.acceleration = accel;
}

/*
================
rvPhysics_Spline::SetLinearDeceleration
================
*/
void rvPhysics_Spline::SetLinearDeceleration( const float decel ) {
	current.deceleration = decel;
}

/*
================
rvPhysics_Spline::SetSpeed
================
*/
void rvPhysics_Spline::SetSpeed( float speed ) {
	if( IsAtRest() || StoppedMoving() ) {
		current.dist = (speed < 0.0f) ? splineLength - current.dist : current.dist;
	}

	current.idealSpeed = speed;
	Activate();
}

/*
================
rvPhysics_Spline::GetSpeed
================
*/
float rvPhysics_Spline::GetSpeed() const {
	return current.speed;
}

/*
================
rvPhysics_Spline::Evaluate
================
*/
bool rvPhysics_Spline::Evaluate( int timeStepMSec, int endTimeMSec ) {
	idVec3 masterOrigin;
	idMat3 masterAxis;

	splinePState_t previous = current;

	if( HasValidSpline() ) {
		if( StoppedMoving() ) {
			Rest();
			return false;
		}

		accelDecelStateThread.Execute();

		// FIXME: clean this up
		if( IsAtBeginningOfSpline() || IsAtEndOfSpline() ) {
			current = previous;
			Rest();
			self->ProcessEvent( &EV_DoneMoving );
			
			if( gameLocal.program.GetReturnedBool() ) {
				current.speed = 0.0f;
				return false;
			} else {
				return true;
			}
		}
	
		float currentTime = splineEntity->GetSampledTime ( current.dist );
		if (  currentTime ==  -1.0f ) {
			currentTime = spline->GetTimeForLength( Min(current.dist, splineLength), 0.01f );
		}

		current.axis = spline->GetCurrentFirstDerivative(currentTime).ToAngles().Normalize360().ToMat3();
		current.origin = spline->GetCurrentValue( currentTime );
		current.localOrigin = current.origin;
		current.localAxis = current.axis;
	} else if( self->IsBound() ) {	
		self->GetMasterPosition( masterOrigin, masterAxis );
		current.axis = current.localAxis * masterAxis;
	    current.origin = masterOrigin + current.localOrigin * masterAxis;
	} else {
		Rest();
		return false;
	}

	gameLocal.push.ClipPush( pushResults, self, 0, previous.origin, previous.axis, current.origin, current.axis );
	if( pushResults.fraction < 1.0f ) {
		current = previous;
		LinkClip();
		current.speed = 0.0f;
		return false;
	}

	LinkClip();

	if( StoppedMoving() && !self->IsBound() ) {
		Rest();
		self->ProcessEvent( &EV_DoneMoving );
		return !gameLocal.program.GetReturnedBool();
	}

	return true;
}

/*
================
rvPhysics_Spline::Activate
================
*/
void rvPhysics_Spline::Activate( void ) {
	assert( self );
	self->BecomeActive( TH_PHYSICS );
}

/*
================
rvPhysics_Spline::Rest
================
*/
void rvPhysics_Spline::Rest( void ) {
	assert( self );
	self->BecomeInactive( TH_PHYSICS );
}

/*
================
rvPhysics_Spline::IsAtRest
================
*/
bool rvPhysics_Spline::IsAtRest( void ) const {
	assert( self );
	return !self->IsActive( TH_PHYSICS );
}

/*
================
rvPhysics_Spline::IsAtEndOfSpline
================
*/
bool rvPhysics_Spline::IsAtEndOfSpline( void ) const {
	return current.dist >= splineLength;
}

/*
================
rvPhysics_Spline::IsAtBeginningOfSpline
================
*/
bool rvPhysics_Spline::IsAtBeginningOfSpline( void ) const {
	return current.dist <= 0.0f;
}

/*
================
rvPhysics_Spline::IsPushable
================
*/
bool rvPhysics_Spline::IsPushable( void ) const {
	return !HasValidSpline() && idPhysics_Base::IsPushable();
}

/*
================
rvPhysics_Spline::StartingToMove
================
*/
bool rvPhysics_Spline::StartingToMove( void ) const {
	float firstDeltaSpeed = current.acceleration * MS2SEC(gameLocal.GetMSec());
	return idMath::Fabs(current.idealSpeed) > VECTOR_EPSILON && idMath::Fabs(current.speed) <= firstDeltaSpeed;
}

/*
================
rvPhysics_Spline::StoppedMoving
================
*/
bool rvPhysics_Spline::StoppedMoving( void ) const {
	return idMath::Fabs(current.idealSpeed) < VECTOR_EPSILON && idMath::Fabs(current.speed) < VECTOR_EPSILON;
}

/*
================
rvPhysics_Spline::HasValidSpline
================
*/
bool rvPhysics_Spline::HasValidSpline() const {
	return spline && splineLength > VECTOR_EPSILON;
}

/*
================
rvPhysics_Spline::SaveState
================
*/
void rvPhysics_Spline::SaveState( void ) {
	saved = current;
}

/*
================
rvPhysics_Spline::RestoreState
================
*/
void rvPhysics_Spline::RestoreState( void ) {
	current = saved;

	LinkClip();
}

/*
================
idPhysics::SetOrigin
================
*/
void rvPhysics_Spline::SetOrigin( const idVec3 &newOrigin, int id ) {
	idVec3 masterOrigin;
	idMat3 masterAxis;

	current.localOrigin = newOrigin;
	if( self->IsBound() ) {
		self->GetMasterPosition( masterOrigin, masterAxis );
		current.origin = masterOrigin + current.localOrigin * masterAxis;
	}
	else {
		current.origin = current.localOrigin;
	}

	LinkClip();
	Activate();
}

/*
================
idPhysics::SetAxis
================
*/
void rvPhysics_Spline::SetAxis( const idMat3 &newAxis, int id ) {
	idVec3 masterOrigin;
	idMat3 masterAxis;

	current.localAxis = newAxis;
	if ( self->IsBound() ) {
		self->GetMasterPosition( masterOrigin, masterAxis );
		current.axis = newAxis * masterAxis;
	}
	else {
		current.axis = newAxis;
	}

	LinkClip();
	Activate();
}

/*
================
rvPhysics_Spline::Translate
================
*/
void rvPhysics_Spline::Translate( const idVec3 &translation, int id ) {
	SetOrigin( GetLocalOrigin() + translation );
}

/*
================
rvPhysics_Spline::Rotate
================
*/
void rvPhysics_Spline::Rotate( const idRotation &rotation, int id ) {
	SetAxis( GetLocalAxis() * rotation.ToMat3() );
	SetOrigin( GetLocalOrigin() * rotation );
}

/*
================
rvPhysics_Spline::GetOrigin
================
*/
const idVec3 &rvPhysics_Spline::GetOrigin( int id ) const {
	return current.origin;
}

/*
================
rvPhysics_Spline::GetAxis
================
*/
const idMat3 &rvPhysics_Spline::GetAxis( int id ) const {
	return current.axis;
}

/*
================
rvPhysics_Spline::GetOrigin
================
*/
idVec3 &rvPhysics_Spline::GetOrigin( int id ) {
	return current.origin;
}

/*
================
rvPhysics_Spline::GetAxis
================
*/
idMat3 &rvPhysics_Spline::GetAxis( int id ) {
	return current.axis;
}

/*
================
rvPhysics_Spline::GetLocalOrigin
================
*/
const idVec3 &rvPhysics_Spline::GetLocalOrigin( int id ) const {
	return current.localOrigin;
}

/*
================
rvPhysics_Spline::GetLocalAxis
================
*/
const idMat3 &rvPhysics_Spline::GetLocalAxis( int id ) const {
	return current.localAxis;
}

/*
================
rvPhysics_Spline::GetLocalOrigin
================
*/
idVec3 &rvPhysics_Spline::GetLocalOrigin( int id ) {
	return current.localOrigin;
}

/*
================
rvPhysics_Spline::GetLocalAxis
================
*/
idMat3 &rvPhysics_Spline::GetLocalAxis( int id ) {
	return current.localAxis;
}

/*
================
rvPhysics_Spline::SetMaster
================
*/
void rvPhysics_Spline::SetMaster( idEntity *master, const bool orientated ) {
	idVec3 masterOrigin;
	idMat3 masterAxis;

	if( master ) {
		if( self->IsBound() ) {
			// transform from world space to master space
			self->GetMasterPosition( masterOrigin, masterAxis );
			current.localOrigin = ( GetOrigin() - masterOrigin ) * masterAxis.Transpose();
			current.localAxis = GetAxis() * masterAxis.Transpose();
		}
	}
}

/*
================
rvPhysics_Spline::ClipTranslation
================
*/
void rvPhysics_Spline::ClipTranslation( trace_t &results, const idVec3 &translation, const idClipModel *model ) const {
	if ( model ) {
		gameLocal.clip.TranslationModel( results, GetOrigin(), GetOrigin() + translation,
											clipModel, GetAxis(), clipMask,
											model->GetCollisionModel(), model->GetOrigin(), model->GetAxis() );
	}
	else {
		gameLocal.Translation( results, GetOrigin(), GetOrigin() + translation,
											clipModel, GetAxis(), clipMask, self );
	}
}

/*
================
rvPhysics_Spline::ClipRotation
================
*/
void rvPhysics_Spline::ClipRotation( trace_t &results, const idRotation &rotation, const idClipModel *model ) const {
	if ( model ) {
		gameLocal.clip.RotationModel( results, GetOrigin(), rotation,
											clipModel, GetAxis(), clipMask,
											model->GetCollisionModel(), model->GetOrigin(), model->GetAxis() );
	}
	else {
		gameLocal.clip.Rotation( results, GetOrigin(), rotation,
											clipModel, GetAxis(), clipMask, self );
	}
}

/*
================
rvPhysics_Spline::ClipContents
================
*/
int rvPhysics_Spline::ClipContents( const idClipModel *model ) const {
	if ( model ) {


		return gameLocal.clip.ContentsModel( GetOrigin(), clipModel, GetAxis(), -1,
									model->GetCollisionModel(), model->GetOrigin(), model->GetAxis() );
	}
	else {
		return gameLocal.clip.Contents( GetOrigin(), clipModel, GetAxis(), -1, NULL );

	}
}

/*
================
rvPhysics_Spline::DisableClip
================
*/
void rvPhysics_Spline::DisableClip( void ) {
	if( clipModel ) {
		clipModel->Disable();
	}
}

/*
================
rvPhysics_Spline::EnableClip
================
*/
void rvPhysics_Spline::EnableClip( void ) {
	if( clipModel ) {
		clipModel->Enable();
	}
}

/*
================
rvPhysics_Spline::UnlinkClip
================
*/
void rvPhysics_Spline::UnlinkClip( void ) {
	if( clipModel ) {
		clipModel->Unlink();
	}
}

/*
================
rvPhysics_Spline::LinkClip
================
*/
void rvPhysics_Spline::LinkClip( void ) {
	if( clipModel ) {


		clipModel->Link( self, clipModel->GetId(), GetOrigin(), GetAxis() );

	}
}

/*
================
rvPhysics_Spline::GetBlockingInfo
================
*/
const trace_t* rvPhysics_Spline::GetBlockingInfo( void ) const {
	return (pushResults.fraction < 1.0f) ? &pushResults : NULL;
}

/*
================
rvPhysics_Spline::GetBlockingEntity
================
*/
idEntity* rvPhysics_Spline::GetBlockingEntity( void ) const {
	return (pushResults.fraction < 1.0f) ? gameLocal.entities[ pushResults.c.entityNum ] : NULL;
}

/*
================
rvPhysics_Spline::WriteToSnapshot
================
*/
void rvPhysics_Spline::WriteToSnapshot( idBitMsgDelta &msg ) const {
	current.WriteToSnapshot( msg );
}

/*
================
rvPhysics_Spline::ReadFromSnapshot
================
*/
void rvPhysics_Spline::ReadFromSnapshot( const idBitMsgDelta &msg ) {
	current.ReadFromSnapshot( msg );

	LinkClip();
}

CLASS_STATES_DECLARATION( rvPhysics_Spline )
	STATE( "Accelerating",		rvPhysics_Spline::State_Accelerating )
	STATE( "Decelerating",		rvPhysics_Spline::State_Decelerating )
	STATE( "Cruising",			rvPhysics_Spline::State_Cruising )
END_CLASS_STATES

/*
================
rvPhysics_Spline::State_Accelerating
================
*/
stateResult_t rvPhysics_Spline::State_Accelerating( const stateParms_t& parms ) {
	stateResult_t returnResult = SRESULT_WAIT;

	if( !current.ShouldAccelerate() ) {
		accelDecelStateThread.SetState( current.ShouldDecelerate() ? "Decelerating" : "Cruising" );
		return SRESULT_DONE;
	}

	if( !parms.stage ) {
		if( StartingToMove() ) {
			self->ProcessEvent( &EV_OnStartMoving );
		}
		self->ProcessEvent( &EV_OnAcceleration );

		returnResult = SRESULT_STAGE( parms.stage + 1 );
	}

	float timeStepSec = MS2SEC( gameLocal.GetMSec() );
	current.ApplyAccelerationDelta( timeStepSec );
	current.UpdateDist( timeStepSec );

	return returnResult;
}

/*
================
rvPhysics_Spline::State_Decelerating
================
*/
stateResult_t rvPhysics_Spline::State_Decelerating( const stateParms_t& parms ) {
	if( !current.ShouldDecelerate() ) {
		accelDecelStateThread.SetState( current.ShouldAccelerate() ? "Accelerating" : "Cruising" );
		return SRESULT_DONE;
	}

	float timeStepSec = MS2SEC( gameLocal.GetMSec() );
	current.ApplyDecelerationDelta( timeStepSec );
	current.UpdateDist( timeStepSec );

	if( !parms.stage ) {
		self->ProcessEvent( &EV_OnDeceleration );
		return SRESULT_STAGE( parms.stage + 1 );
	}

	if( StoppedMoving() ) {
		self->ProcessEvent( &EV_OnStopMoving );
	}

	return SRESULT_WAIT;
}

/*
================
rvPhysics_Spline::State_Cruising
================
*/
stateResult_t rvPhysics_Spline::State_Cruising( const stateParms_t& parms ) {
	if( current.ShouldAccelerate() ) {
		accelDecelStateThread.SetState( "Accelerating" );
		return SRESULT_DONE;
	} else if( current.ShouldDecelerate() ) {
		accelDecelStateThread.SetState( "Decelerating" );
		return SRESULT_DONE;
	}

	current.UpdateDist( MS2SEC(gameLocal.GetMSec()) );

	if( !parms.stage ) {
		self->ProcessEvent( &EV_OnCruising );
		return SRESULT_STAGE( parms.stage + 1 );
	}

	return SRESULT_WAIT;
}



const idEventDef EV_SetSpline( "setSpline", "E" );

const idEventDef EV_SetAccel( "setAccel", "f" );
const idEventDef EV_SetDecel( "setDecel", "f" );

const idEventDef EV_SetSpeed( "setSpeed", "f" );
const idEventDef EV_GetSpeed( "getSpeed", "", 'f' );

const idEventDef EV_TramCar_SetIdealSpeed( "setIdealSpeed", "f" );
const idEventDef EV_TramCar_GetIdealSpeed( "getIdealSpeed", "", 'f' );

const idEventDef EV_TramCar_ApplySpeedScale( "applySpeedScale", "f" );

const idEventDef EV_GetCurrentTrackInfo( "getCurrentTrackInfo", "", 's' );
const idEventDef EV_GetTrackInfo( "getTrackInfo", "e", 's' );

const idEventDef EV_DoneMoving( "<doneMoving>", "", 'd' );
const idEventDef EV_StartSoundPeriodic( "<startSoundPeriodic>", "sddd" );

idLinkList<rvSplineMover> rvSplineMover::splineMovers;

//=======================================================
//
//	rvSplineMover
//
//=======================================================
CLASS_DECLARATION( idAnimatedEntity, rvSplineMover )
	EVENT( EV_PostSpawn,				rvSplineMover::Event_PostSpawn )
	EVENT( EV_Activate,					rvSplineMover::Event_Activate )
	EVENT( EV_SetSpline,				rvSplineMover::Event_SetSpline )
	EVENT( EV_SetAccel,					rvSplineMover::Event_SetAcceleration )
	EVENT( EV_SetDecel,					rvSplineMover::Event_SetDeceleration )
	EVENT( EV_SetSpeed,					rvSplineMover::Event_SetSpeed )
	EVENT( EV_GetSpeed,					rvSplineMover::Event_GetSpeed )
	EVENT( EV_Thread_SetCallback,		rvSplineMover::Event_SetCallBack )
	EVENT( EV_DoneMoving,				rvSplineMover::Event_DoneMoving )
	EVENT( EV_GetSplineEntity,			rvSplineMover::Event_GetSpline )
	EVENT( EV_GetCurrentTrackInfo,		rvSplineMover::Event_GetCurrentTrackInfo )
	EVENT( EV_GetTrackInfo,				rvSplineMover::Event_GetTrackInfo )
	EVENT( EV_TramCar_SetIdealSpeed,	rvSplineMover::Event_SetIdealSpeed )
	EVENT( EV_TramCar_GetIdealSpeed,	rvSplineMover::Event_GetIdealSpeed )
	EVENT( EV_TramCar_ApplySpeedScale,	rvSplineMover::Event_ApplySpeedScale )
	EVENT( EV_OnAcceleration,			rvSplineMover::Event_OnAcceleration )
	EVENT( EV_OnDeceleration,			rvSplineMover::Event_OnDeceleration )
	EVENT( EV_OnCruising,				rvSplineMover::Event_OnCruising )
	EVENT( EV_OnStartMoving,			rvSplineMover::Event_OnStartMoving )
	EVENT( EV_OnStopMoving,				rvSplineMover::Event_OnStopMoving )
	EVENT( EV_StartSoundPeriodic,		rvSplineMover::Event_StartSoundPeriodic )
	EVENT( EV_PartBlocked,				rvSplineMover::Event_PartBlocked )
END_CLASS

/*
================
rvSplineMover::Spawn
================
*/
void rvSplineMover::Spawn() {
	waitThreadId = -1;

	physicsObj.SetSelf( this );

// mwhitlock: Dynamic memory consolidation
	RV_PUSH_HEAP_MEM(this);

	physicsObj.SetClipModel( new idClipModel(GetPhysics()->GetClipModel()), 1.0f );

// mwhitlock: Dynamic memory consolidation
	RV_POP_HEAP();

	physicsObj.SetContents( spawnArgs.GetBool("solid", "1") ? CONTENTS_SOLID : 0 );
	physicsObj.SetClipMask( spawnArgs.GetBool("solidClip") ? CONTENTS_SOLID : 0 );
	physicsObj.SetLinearVelocity( GetPhysics()->GetLinearVelocity() );
	physicsObj.SetLinearAcceleration( spawnArgs.GetFloat("accel", "50") );
	physicsObj.SetLinearDeceleration( spawnArgs.GetFloat("decel", "50") );
	physicsObj.SetAxis( GetPhysics()->GetAxis() );
	physicsObj.SetOrigin( GetPhysics()->GetOrigin() );

	SetPhysics( &physicsObj );

	AddSelfToGlobalList();

	// This is needed so we get sorted correctly
	BecomeInactive( TH_PHYSICS );
	BecomeActive( TH_PHYSICS );

	PlayAnim( ANIMCHANNEL_ALL, "idle", 0 );

	PostEventMS( &EV_PostSpawn, 0 );
}

/*
================
rvSplineMover::~rvSplineMover
================
*/
rvSplineMover::~rvSplineMover() {
	RemoveSelfFromGlobalList();
	SetPhysics( NULL );
}

/*
================
rvSplineMover::SetSpeed
================
*/
void rvSplineMover::SetSpeed( float newSpeed ) {
	physicsObj.SetSpeed( newSpeed );
}

/*
================
rvSplineMover::GetSpeed
================
*/
float rvSplineMover::GetSpeed() const {
	return physicsObj.GetSpeed();
}

/*
================
rvSplineMover::SetIdealSpeed
================
*/
void rvSplineMover::SetIdealSpeed( float newIdealSpeed ) {
	idealSpeed = newIdealSpeed;
	SetSpeed( newIdealSpeed );
}

/*
================
rvSplineMover::GetIdealSpeed
================
*/
float rvSplineMover::GetIdealSpeed() const {
	return idealSpeed;
}

/*
================
rvSplineMover::SetSpline
================
*/
void rvSplineMover::SetSpline( idSplinePath* spline ) {
	physicsObj.SetSplineEntity( spline );
	CheckSplineForOverrides( physicsObj.GetSpline(), &spline->spawnArgs );
}

/*
================
rvSplineMover::GetSpline
================
*/
const idSplinePath* rvSplineMover::GetSpline() const {
	return physicsObj.GetSplineEntity();
}

/*
================
rvSplineMover::GetSpline
================
*/
idSplinePath* rvSplineMover::GetSpline() {
	return physicsObj.GetSplineEntity();
}

/*
================
rvSplineMover::SetAcceleration
================
*/
void rvSplineMover::SetAcceleration( float accel ) {
	physicsObj.SetLinearAcceleration( accel );
}

/*
================
rvSplineMover::SetDeceleration
================
*/
void rvSplineMover::SetDeceleration( float decel ) {
	physicsObj.SetLinearDeceleration( decel );
}

/*
================
rvSplineMover::CheckSplineForOverrides
================
*/
void rvSplineMover::CheckSplineForOverrides( const idCurve_Spline<idVec3>* spline, const idDict* args ) {
	if( !spline || !args ) {
		return;
	}

	int endSpline = args->GetInt( "end_spline" );
	if( endSpline && Sign(endSpline) == Sign(GetSpeed()) ) {
		physicsObj.SetLinearDeceleration( physicsObj.ComputeDecelFromSpline() );
		SetIdealSpeed( 0.0f );
	}
}

/*
================
rvSplineMover::RestoreFromOverrides
================
*/
void rvSplineMover::RestoreFromOverrides( const idDict* args ) {
	if( !args ) {
		return;
	}

	physicsObj.SetLinearDeceleration( args->GetFloat("decel") );
}

/*
================
rvSplineMover::PlayAnim
================
*/
int rvSplineMover::PlayAnim( int channel, const char* animName, int blendFrames ) {
	int animIndex = GetAnimator()->GetAnim( animName );
	if( !animIndex ) {
		return 0;
	}

	GetAnimator()->PlayAnim( channel, animIndex, gameLocal.GetTime(), FRAME2MS(blendFrames) );
	return GetAnimator()->CurrentAnim( channel )->Length();
}

/*
================
rvSplineMover::CycleAnim
================
*/
void rvSplineMover::CycleAnim( int channel, const char* animName, int blendFrames ) {
	int animIndex = GetAnimator()->GetAnim( animName );
	if( !animIndex ) {
		return;
	}

	GetAnimator()->CycleAnim( channel, animIndex, gameLocal.GetTime(), FRAME2MS(blendFrames) );
}

/*
================
rvSplineMover::ClearChannel
================
*/
void rvSplineMover::ClearChannel( int channel, int clearFrame ) {
	GetAnimator()->Clear( channel, gameLocal.GetTime(), FRAME2MS(clearFrame) );
}

/*
================
rvSplineMover::PreBind
================
*/
void rvSplineMover::PreBind() {
	idAnimatedEntity::PreBind();

	SetSpline( NULL );
}

/*
================
rvSplineMover::Save
================
*/
void rvSplineMover::Save( idSaveGame *savefile ) const {
	savefile->WriteStaticObject( physicsObj );
	savefile->WriteFloat( idealSpeed );
	savefile->WriteInt( waitThreadId );
}

/*
================
rvSplineMover::Restore
================
*/
void rvSplineMover::Restore( idRestoreGame *savefile ) {
	savefile->ReadStaticObject( physicsObj );
	RestorePhysics( &physicsObj );

	savefile->ReadFloat( idealSpeed );
	savefile->ReadInt( waitThreadId );

	AddSelfToGlobalList();
}

/*
================
rvSplineMover::WriteToSnapshot
================
*/
void rvSplineMover::WriteToSnapshot( idBitMsgDelta &msg ) const {
	physicsObj.WriteToSnapshot( msg );
}

/*
================
rvSplineMover::ReadFromSnapshot
================
*/
void rvSplineMover::ReadFromSnapshot( const idBitMsgDelta &msg ) {
	physicsObj.ReadFromSnapshot( msg );
}

/*
================
rvSplineMover::AddSelfToGlobalList
================
*/
void rvSplineMover::AddSelfToGlobalList() {
	splineMoverNode.SetOwner( this );

	if( !InGlobalList() ) {
		splineMoverNode.AddToEnd( splineMovers );
	}
}

/*
================
rvSplineMover::RemoveSelfFromGlobalList
================
*/
void rvSplineMover::RemoveSelfFromGlobalList() {
	splineMoverNode.Remove();
}

/*
================
rvSplineMover::InGlobalList
================
*/
bool rvSplineMover::InGlobalList() const {
	return splineMoverNode.InList();
}

/*
================
rvSplineMover::WhosVisible
================
*/
bool rvSplineMover::WhosVisible( const idFrustum& frustum, idList<rvSplineMover*>& list ) const {
	list.Clear();

	if( !frustum.IsValid() ) {
		return false;
	}

	for( rvSplineMover* node = splineMovers.Next(); node; node = node->splineMoverNode.Next() ) {
		if( node == this ) {
			continue;
		}

		if( frustum.IntersectsBounds(node->GetPhysics()->GetAbsBounds()) ) {
			list.AddUnique( node );
		}
	}

	return list.Num() > 0;
}

/*
================
rvSplineMover::GetTrackInfo
================
*/
idStr rvSplineMover::GetTrackInfo( const idSplinePath* track ) const {
	if( !track ) {
		return idStr( "" );
	}

	idStr info( track->GetName() );
	return info.Mid( info.Last('_') - 1, 1 );
}

/*
================
rvSplineMover::ConvertToMover
================
*/
rvSplineMover* rvSplineMover::ConvertToMover( idEntity* mover ) const {
	return mover && mover->IsType(rvSplineMover::Type) ? static_cast<rvSplineMover*>(mover) : NULL;
}

/*
================
rvSplineMover::ConvertToSplinePath
================
*/
idSplinePath* rvSplineMover::ConvertToSplinePath( idEntity* spline ) const {
	return (spline && spline->IsType(idSplinePath::GetClassType())) ? static_cast<idSplinePath*>(spline) : NULL;
}

/*
================
rvSplineMover::PreDoneMoving
================
*/
void rvSplineMover::PreDoneMoving() {
	if( waitThreadId >= 0 ) {
		idThread::ObjectMoveDone( waitThreadId, this );
		waitThreadId = -1;
	}

	RestoreFromOverrides( &spawnArgs );
}

/*
================
rvSplineMover::PostDoneMoving
================
*/
void rvSplineMover::PostDoneMoving() {
	CallScriptEvents( physicsObj.GetSplineEntity(), "call_doneMoving", this );
}

/*
==============
rvSplineMover::CallScriptEvents
==============
*/
// FIXME: very similier code is in the spawner...if possible try and make one function for both to call
void rvSplineMover::CallScriptEvents( const idSplinePath* spline, const char* prefixKey, idEntity* parm ) {
	if( !spline || !prefixKey || !prefixKey[0] ) {
		return;
	}

	rvScriptFuncUtility func;
	for( const idKeyValue* kv = spline->spawnArgs.MatchPrefix(prefixKey); kv; kv = spline->spawnArgs.MatchPrefix(prefixKey, kv) ) {
		if( !kv->GetValue().Length() ) {
			continue;
		}

		if( func.Init(kv->GetValue()) <= SFU_ERROR ) {
			continue;
		}

		func.InsertEntity( spline, 0 );
		func.InsertEntity( parm, 1 );
		func.CallFunc( &spawnArgs );
	}
}

/*
================
rvSplineMover::Event_PostSpawn
================
*/
void rvSplineMover::Event_PostSpawn() {
	idEntityPtr<idEntity> target;
	for( int ix = targets.Num() - 1; ix >= 0; --ix ) {
		target = targets[ix];

		if( target.IsValid() && target->IsType(idSplinePath::GetClassType()) ) {
			SetSpline( static_cast<idSplinePath*>(target.GetEntity()) );
			break;
		}
	}

	SetIdealSpeed( spawnArgs.GetBool("waitForTrigger") ? 0.0f : spawnArgs.GetFloat("speed", "50") );
}

/*
===============
rvSplineMover::Event_PartBlocked
===============
*/
void rvSplineMover::Event_PartBlocked( idEntity *blockingEntity ) {
	assert( blockingEntity );

	float damage = spawnArgs.GetFloat( "damage" );
	if( damage > 0.0f ) {
		blockingEntity->Damage( this, this, vec3_origin, "damage_moverCrush", damage, INVALID_JOINT );
	}
	if( g_debugMover.GetBool() ) {
		gameLocal.Printf( "%d: '%s' blocked by '%s'\n", gameLocal.GetTime(), GetName(), blockingEntity->GetName() );
	}
}

/*
================
rvSplineMover::Event_SetSpline
================
*/
void rvSplineMover::Event_SetSpline( idEntity* spline ) {
	SetSpline( ConvertToSplinePath(spline) );
}

/*
================
rvSplineMover::Event_GetSpline
================
*/
void rvSplineMover::Event_GetSpline() {
	idThread::ReturnEntity( GetSpline() );
}

/*
================
rvSplineMover::Event_SetAcceleration
================
*/
void rvSplineMover::Event_SetAcceleration( float accel ) {
	SetAcceleration( accel );
}

/*
================
rvSplineMover::Event_SetDeceleration
================
*/
void rvSplineMover::Event_SetDeceleration( float decel ) {
	SetDeceleration( decel );
}

/*
================
rvSplineMover::Event_SetSpeed
================
*/
void rvSplineMover::Event_SetSpeed( float speed ) {
	SetIdealSpeed( speed );
	SetSpeed( speed );
}

/*
================
rvSplineMover::Event_GetSpeed
================
*/
void rvSplineMover::Event_GetSpeed() {
	idThread::ReturnFloat( GetSpeed() );
}

/*
================
rvSplineMover::Event_SetIdealSpeed
================
*/
void rvSplineMover::Event_SetIdealSpeed( float speed ) {
	SetIdealSpeed( speed );
}

/*
================
rvSplineMover::Event_GetIdealSpeed
================
*/
void rvSplineMover::Event_GetIdealSpeed() {
	idThread::ReturnFloat( GetIdealSpeed() );
}

/*
================
rvSplineMover::Event_ApplySpeedScale
================
*/
void rvSplineMover::Event_ApplySpeedScale( float scale ) {
	SetIdealSpeed( spawnArgs.GetFloat("speed", "50") * scale );
}

/*
================
rvSplineMover::Event_SetCallBack
================
*/
void rvSplineMover::Event_SetCallBack() {
	if( waitThreadId >= 0 ) {
		idThread::ReturnInt( false );
	}

	waitThreadId = idThread::CurrentThreadNum();
	idThread::ReturnInt( true );
}

/*
================
rvSplineMover::Event_DoneMoving
================
*/
void rvSplineMover::Event_DoneMoving() {
	PreDoneMoving();
	PostDoneMoving();

	idThread::ReturnInt( !physicsObj.HasValidSpline() );
}

/*
================
rvSplineMover::Event_GetCurrentTrackInfo
================
*/
void rvSplineMover::Event_GetCurrentTrackInfo() {
	Event_GetTrackInfo( physicsObj.GetSplineEntity() );
}

/*
================
rvSplineMover::Event_GetTrackInfo
================
*/
void rvSplineMover::Event_GetTrackInfo( idEntity* track ) {
	idThread::ReturnString( GetTrackInfo(ConvertToSplinePath(track)) );
}

/*
================
rvSplineMover::Event_Activate
================
*/
void rvSplineMover::Event_Activate( idEntity* activator ) {
	// This is for my special case in tram1b

	//if( physicsObj.StoppedMoving() ) {
	//	SetIdealSpeed( spawnArgs.GetFloat("speed", "50") );
	//}
}

/*
================
rvSplineMover::Event_OnAcceleration
================
*/
void rvSplineMover::Event_OnAcceleration() {
	StartSound( "snd_accel", SND_CHANNEL_ANY, 0, false, NULL );
}

/*
================
rvSplineMover::Event_OnDeceleration
================
*/
void rvSplineMover::Event_OnDeceleration() {
	StartSound( "snd_decel", SND_CHANNEL_ANY, 0, false, NULL );
}

/*
================
rvSplineMover::Event_OnCruising
================
*/
void rvSplineMover::Event_OnCruising() {
	idVec2 range( spawnArgs.GetVec2("noisePeriodRange") * idMath::M_SEC2MS );
	if( !EventIsPosted(&EV_StartSoundPeriodic) && range.Length() > VECTOR_EPSILON ) {
		ProcessEvent( &EV_StartSoundPeriodic, "snd_noise", (int)SND_CHANNEL_ANY, (int)range[0], (int)range[1] );
	}
}

/*
================
rvSplineMover::Event_OnStopMoving
================
*/
void rvSplineMover::Event_OnStopMoving() {
	StopSound( SND_CHANNEL_ANY, false );
	CancelEvents( &EV_StartSoundPeriodic );
}

/*
================
rvSplineMover::Event_OnStartMoving
================
*/
void rvSplineMover::Event_OnStartMoving() {
}

/*
================
rvSplineMover::Event_StartSoundPeriodic
================
*/
void rvSplineMover::Event_StartSoundPeriodic( const char* sndKey, const s_channelType channel, int minDelay, int maxDelay ) {
	CancelEvents( &EV_StartSoundPeriodic );

	if( physicsObj.StoppedMoving() ) {
		return;
	}

	int length;
	StartSound( sndKey, channel, 0, false, &length );

	PostEventMS( &EV_StartSoundPeriodic, Max(rvRandom::irand(minDelay, maxDelay), length), sndKey, (int)channel, minDelay, maxDelay );
}
