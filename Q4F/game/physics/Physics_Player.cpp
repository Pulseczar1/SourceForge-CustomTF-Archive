#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"

CLASS_DECLARATION( idPhysics_Actor, idPhysics_Player )
END_CLASS

// movement parameters
const float PM_STOPSPEED		= 100.0f;
const float PM_SWIMSCALE		= 0.8f;
const float PM_LADDERSPEED		= 200.0f;
const float PM_STEPSCALE		= 1.0f;

const float PM_LADDERSPEEDSCALE = 0.75f;

const float PM_ACCELERATE		= 12.5f;

const float PM_AIRACCELERATE	= 1.08f;

const float PM_WATERACCELERATE	= 4.0f;
const float PM_FLYACCELERATE	= 8.0f;

const float PM_FRICTION			= 6.0f;
const float PM_AIRFRICTION		= 0.0f;

const float PM_WATERFRICTION	= 2.0f;

const float PM_FLYFRICTION		= 3.0f;
const float PM_NOCLIPFRICTION	= 12.0f;

// bdube: sliding
const float PM_SLIDEFRICTION    = 0.5f;


const float MIN_WALK_NORMAL		= 0.7f;		// can't walk on very steep slopes
const float OVERCLIP			= 1.001f;

// movementFlags
const int PMF_DUCKED			= 1;		// set when ducking
const int PMF_JUMPED			= 2;		// set when the player jumped this frame
const int PMF_STEPPED_UP		= 4;		// set when the player stepped up this frame
const int PMF_STEPPED_DOWN		= 8;		// set when the player stepped down this frame
const int PMF_JUMP_HELD			= 16;		// set when jump button is held down
const int PMF_JUMP_AIR			= 256;		// set if the playe pressed jump while in air
const int PMF_TIME_LAND			= 32;		// movementTime is time before rejump
const int PMF_TIME_KNOCKBACK	= 64;		// movementTime is an air-accelerate only time
const int PMF_TIME_WATERJUMP	= 128;		// movementTime is waterjump
const int PMF_ALL_TIMES			= (PMF_TIME_WATERJUMP|PMF_TIME_LAND|PMF_TIME_KNOCKBACK);

int c_pmove = 0;

const int NUM_AVG_ANGLES = 16;
const float AVG_SCALE = 1.0f;

//--------------------------------------------------------------------------
// Stole logged view accel from weaponangleoffset stuff :P
//--------------------------------------------------------------------------
float idPhysics_Player::GetAverageYaw() {
	if ( gameLocal.framenum < idPlayer::NUM_LOGGED_VIEW_ANGLES ) {
		return 0.0f;
	}

	idPlayer* owner = static_cast<idPlayer*>(self);

	float current = owner->loggedViewAngles[ gameLocal.framenum & (idPlayer::NUM_LOGGED_VIEW_ANGLES-1) ].yaw;

	float av = current, delta;

	float div = 1.0f / NUM_AVG_ANGLES;

	for ( int j = 1 ; j < NUM_AVG_ANGLES ; j++ ) {
		delta = owner->loggedViewAngles[ ( gameLocal.framenum - j ) & (idPlayer::NUM_LOGGED_VIEW_ANGLES-1) ].yaw - current;

		if ( delta > 180.0f ) {
			delta -= 360.0f;
		} else if ( delta < -180.0f ) {
			delta += 360.0f;
		}

		av += delta * div;
	}

	return ( av - current ) * AVG_SCALE;
}

/*
============
idPhysics_Player::CmdScale

Returns the scale factor to apply to cmd movements
This allows the clients to use axial -127 to 127 values for all directions
without getting a sqrt(2) distortion in speed.
============
*/
float idPhysics_Player::CmdScale( const usercmd_t &cmd ) const {
	int		max;
	float	total;
	float	scale;
	int		forwardmove;
	int		rightmove;
	int		upmove;

	forwardmove = cmd.forwardmove;
	rightmove = cmd.rightmove;

	// since the crouch key doubles as downward movement, ignore downward movement when we're on the ground
	// otherwise crouch speed will be lower than specified
	if ( walking ) {
		upmove = 0;
	} else { 
		upmove = cmd.upmove;
	}

	max = abs( forwardmove );
	if ( abs( rightmove ) > max ) {
		max = abs( rightmove );
	}
	if ( abs( upmove ) > max ) {
		max = abs( upmove );
	}

	if ( !max ) {
		return 0.0f;
	}

	total = idMath::Sqrt( (float) forwardmove * forwardmove + rightmove * rightmove + upmove * upmove );
	scale = (float) playerSpeed * max / ( 127.0f * total );

	return scale;
}

/*
==============
idPhysics_Player::Accelerate

Handles user intended acceleration
==============
*/
void idPhysics_Player::Accelerate( const idVec3 &wishdir, const float wishspeed, const float accel ) {
#if 1
	// q2 style
	float addspeed, accelspeed, currentspeed;

	currentspeed = current.velocity * wishdir;
	addspeed = wishspeed - currentspeed;
	if (addspeed <= 0) {
		return;
	}
// RAVEN BEGIN
// nmckenzie: added ability to try alternate accelerations.
	/*if ( pm_acceloverride.GetFloat() > 0.0f ) {
		accelspeed = pm_acceloverride.GetFloat() * frametime * wishspeed;
	} else {*/
		accelspeed = accel * frametime * wishspeed;
	//}
// RAVEN END
	if ( accelspeed > addspeed ) {
		accelspeed = addspeed;
	}
	
	current.velocity += accelspeed * wishdir;

#else
	// proper way (avoids strafe jump maxspeed bug), but feels bad
	idVec3		wishVelocity;
	idVec3		pushDir;
	float		pushLen;
	float		canPush;

	wishVelocity = wishdir * wishspeed;
	pushDir = wishVelocity - current.velocity;
	pushLen = pushDir.Normalize();

	canPush = accel * frametime * wishspeed;
	if ( canPush > pushLen ) {
		canPush = pushLen;
	}

	current.velocity += canPush * pushDir;
#endif
}

/*
==================
idPhysics_Player::SlideMove

Returns true if the velocity was clipped in some way
==================
*/
#define	MAX_CLIP_PLANES	5

bool idPhysics_Player::SlideMove( bool gravity, bool stepUp, bool stepDown, bool push ) {
	int			i, j, k, pushFlags;
	int			bumpcount, numbumps, numplanes;
	float		d, time_left, into, totalMass;
	idVec3		dir, planes[MAX_CLIP_PLANES];
	idVec3		end, stepEnd, primal_velocity, endVelocity, endClipVelocity, clipVelocity;
	trace_t		trace, stepTrace, downTrace;
	bool		nearGround, stepped, pushed;

	numbumps = 4;

	primal_velocity = current.velocity;

	if ( gravity ) {
		endVelocity = current.velocity + gravityVector * frametime;
		current.velocity = ( current.velocity + endVelocity ) * 0.5f;
		primal_velocity = endVelocity;
		if ( groundPlane ) {
			// slide along the ground plane
			current.velocity.ProjectOntoPlane( groundTrace.c.normal, OVERCLIP );
		}
	}
	else {
		endVelocity = current.velocity;
	}

	time_left = frametime;

	// never turn against the ground plane
	if ( groundPlane ) {
		numplanes = 1;
		planes[0] = groundTrace.c.normal;
	} else {
		numplanes = 0;
	}

	// never turn against original velocity
	planes[numplanes] = current.velocity;
	planes[numplanes].Normalize();
	numplanes++;

	idEntity* addIgnore = NULL;

	for ( bumpcount = 0; bumpcount < numbumps; bumpcount++ ) {

		// calculate position we are trying to move to
		end = current.origin + time_left * current.velocity;

		// see if we can make it there

// ddynerman: multiple clip worlds
		gameLocal.clip.Translation( trace, current.origin, end, clipModel, clipModel->GetAxis(), clipMask, self, addIgnore );

		time_left -= time_left * trace.fraction;
		current.origin = trace.endpos;

		// if moved the entire distance
		if ( trace.fraction >= 1.0f ) {
			break;
		}

		idEntity* ent = gameLocal.GetTraceEntity( trace );

		if ( current.movementType == PM_SPECTATOR && ent && ( ent->IsType( idMover::GetClassType() ) || ent->IsType( idMover_Binary::GetClassType() ) ) ) {
			/*idVec3 pos = current.origin + ( trace.c.normal * -32.f );

			if ( !gameLocal.clip.TracePoint( trace, current.origin + ( trace.c.normal * -2.0f ), pos, MASK_PLAYERSOLID, ent ) ) {
				current.origin = pos;
				continue;
			}*/
			current.origin = end;
			break;
		}

		if ( ent && ent->IsType( q4fAntiTeam::GetClassType() ) ) {

			q4fAntiTeam* antiteam = static_cast<q4fAntiTeam*>( ent );

			if ( antiteam->team != self->team && antiteam->killPlayers ) {
				antiteam->PostEventMS( &EV_Touch, 0, self, &trace );
			}

			if ( ent->team == self->team || !antiteam->blockPlayers ) {
				addIgnore = ent;
				bumpcount--;
				continue;
			}
		}

		stepped = pushed = false;

		// if we are allowed to step up
		if ( stepUp && ( trace.c.normal * -gravityNormal ) < MIN_WALK_NORMAL ) {
			nearGround = groundPlane | ladder;

			if ( !nearGround ) {
				// trace down to see if the player is near the ground
				// step checking when near the ground allows the player to move up stairs smoothly while jumping
				stepEnd = current.origin + maxStepHeight * gravityNormal;

// ddynerman: multiple clip worlds
				gameLocal.clip.Translation( downTrace, current.origin, stepEnd, clipModel, clipModel->GetAxis(), clipMask, self );

				nearGround = ( downTrace.fraction < 1.0f && (downTrace.c.normal * -gravityNormal) > MIN_WALK_NORMAL );
			}

			// may only step up if near the ground or on a ladder
			if ( nearGround ) {

				// step up
				stepEnd = current.origin - maxStepHeight * gravityNormal;

// ddynerman: multiple clip worlds
				gameLocal.clip.Translation( downTrace, current.origin, stepEnd, clipModel, clipModel->GetAxis(), clipMask, self );


				// trace along velocity
				stepEnd = downTrace.endpos + time_left * current.velocity;

// ddynerman: multiple clip worlds
				gameLocal.clip.Translation( stepTrace, downTrace.endpos, stepEnd, clipModel, clipModel->GetAxis(), clipMask, self );


				// step down
				stepEnd = stepTrace.endpos + maxStepHeight * gravityNormal;

// ddynerman: multiple clip worlds
				gameLocal.clip.Translation( downTrace, stepTrace.endpos, stepEnd, clipModel, clipModel->GetAxis(), clipMask, self );


  				if ( downTrace.fraction >= 1.0f || (downTrace.c.normal * -gravityNormal) > MIN_WALK_NORMAL ) {
					// if moved the entire distance
   					if ( stepTrace.fraction >= 1.0f ) {
						time_left = 0;
  						current.stepUp -= ( downTrace.endpos - current.origin ) * gravityNormal;
						current.origin = downTrace.endpos;
						current.movementFlags |= PMF_STEPPED_UP;
						current.velocity *= PM_STEPSCALE;
						break;
					}

					// if the move is further when stepping up
					if ( stepTrace.fraction > trace.fraction ) {
 						time_left -= time_left * stepTrace.fraction;
						current.stepUp -= ( downTrace.endpos - current.origin ) * gravityNormal;
						current.origin = downTrace.endpos;
						current.movementFlags |= PMF_STEPPED_UP;
						current.velocity *= PM_STEPSCALE;
						trace = stepTrace;
						stepped = true;
					}
				}
			}
		}

		// if we can push other entities and not blocked by the world
		if ( push && trace.c.entityNum != ENTITYNUM_WORLD ) {

			clipModel->SetPosition( current.origin, clipModel->GetAxis() );

			// clip movement, only push idMoveables, don't push entities the player is standing on
			// apply impact to pushed objects
			pushFlags = PUSHFL_CLIP|PUSHFL_ONLYMOVEABLE|PUSHFL_NOGROUNDENTITIES|PUSHFL_APPLYIMPULSE;

			// clip & push
			totalMass = gameLocal.push.ClipTranslationalPush( trace, self, pushFlags, end, end - current.origin );

			if ( totalMass > 0.0f ) {
				// decrease velocity based on the total mass of the objects being pushed ?
				current.velocity *= 1.0f - idMath::ClampFloat( 0.0f, 1000.0f, totalMass - 20.0f ) * ( 1.0f / 950.0f );
				pushed = true;
			}
	
			current.origin = trace.endpos;
			time_left -= time_left * trace.fraction;

			// if moved the entire distance
			if ( trace.fraction >= 1.0f ) {
				break;
			}
		}

		if ( !stepped && self ) {
			// let the entity know about the collision
			self->Collide( trace, current.velocity );
		}

		if ( numplanes >= MAX_CLIP_PLANES ) {
			// MrElusive: I think we have some relatively high poly LWO models with a lot of slanted tris
			// where it may hit the max clip planes
			current.velocity = vec3_origin;
			return true;
		}

		//
		// if this is the same plane we hit before, nudge velocity out along it,
		// which fixes some epsilon issues with non-axial planes
		//
		for ( i = 0; i < numplanes; i++ ) {
			if ( ( trace.c.normal * planes[i] ) > 0.999f ) {
				// clip into the trace normal just in case this normal is almost but not exactly the same as the groundTrace normal
				current.velocity.ProjectOntoPlane( trace.c.normal, OVERCLIP );
				// also add the normal to nudge the velocity out
				current.velocity += trace.c.normal;
				break;
			}
		}
		if ( i < numplanes ) {
			continue;
		}
		planes[numplanes] = trace.c.normal;
		numplanes++;

		//
		// modify velocity so it parallels all of the clip planes
		//
		
		// find a plane that it enters
		for ( i = 0; i < numplanes; i++ ) {
			into = current.velocity * planes[i];
			if ( into >= 0.1f ) {
				continue;		// move doesn't interact with the plane
			}

			// slide along the plane
			clipVelocity = current.velocity;
			clipVelocity.ProjectOntoPlane( planes[i], OVERCLIP );

			// slide along the plane
			endClipVelocity = endVelocity;
			endClipVelocity.ProjectOntoPlane( planes[i], OVERCLIP );

			// see if there is a second plane that the new move enters
			for ( j = 0; j < numplanes; j++ ) {
				if ( j == i ) {
					continue;
				}
				if ( ( clipVelocity * planes[j] ) >= 0.1f ) {
					continue;		// move doesn't interact with the plane
				}

				// try clipping the move to the plane
				clipVelocity.ProjectOntoPlane( planes[j], OVERCLIP );
				endClipVelocity.ProjectOntoPlane( planes[j], OVERCLIP );

				// see if it goes back into the first clip plane
				if ( ( clipVelocity * planes[i] ) >= 0 ) {
					continue;
				}

				// slide the original velocity along the crease
				dir = planes[i].Cross( planes[j] );
				dir.Normalize();
				d = dir * current.velocity;
				clipVelocity = d * dir;

				dir = planes[i].Cross( planes[j] );
				dir.Normalize();
				d = dir * endVelocity;
				endClipVelocity = d * dir;

				// see if there is a third plane the the new move enters
				for ( k = 0; k < numplanes; k++ ) {
					if ( k == i || k == j ) {
						continue;
					}
					if ( ( clipVelocity * planes[k] ) >= 0.1f ) {
						continue;		// move doesn't interact with the plane
					}

					// stop dead at a tripple plane interaction
					current.velocity = vec3_origin;
					return true;
				}
			}

			// if we have fixed all interactions, try another move
			current.velocity = clipVelocity;
			endVelocity = endClipVelocity;
			break;
		}
	}

	// step down
	if ( stepDown && groundPlane ) {
		stepEnd = current.origin + gravityNormal * maxStepHeight;

// ddynerman: multiple clip worlds
		gameLocal.clip.Translation( downTrace, current.origin, stepEnd, clipModel, clipModel->GetAxis(), clipMask, self );

		if ( downTrace.fraction > 1e-4f && downTrace.fraction < 1.0f ) {
			current.stepUp -= ( downTrace.endpos - current.origin ) * gravityNormal;
			current.origin = downTrace.endpos;
			current.movementFlags |= PMF_STEPPED_DOWN;
			current.velocity *= PM_STEPSCALE;
		}
	}

	if ( gravity ) {
		current.velocity = endVelocity;
	}

	// come to a dead stop when the velocity orthogonal to the gravity flipped
	clipVelocity = current.velocity - gravityNormal * current.velocity * gravityNormal;
	endClipVelocity = endVelocity - gravityNormal * endVelocity * gravityNormal;
	if ( clipVelocity * endClipVelocity < 0.0f ) {
		current.velocity = gravityNormal * current.velocity * gravityNormal;
	}

	return ( bumpcount == 0 );
}

/*
==================
idPhysics_Player::Friction

Handles both ground friction and water friction
==================
*/
void idPhysics_Player::Friction( void ) {
	idVec3	vel;
	float	speed, newspeed, control;
	float	drop;

	vel = current.velocity;
	if ( walking ) {
		// ignore slope movement, remove all velocity in gravity direction
		vel += (vel * gravityNormal) * gravityNormal;
	}

	speed = vel.Length();
	if ( speed < 1.0f ) {
		current.velocity.Zero();
		return;
	}

	drop = 0;

	// spectator friction

// nmckenzie: allow trying custom frictions
	if ( pm_frictionoverride.GetFloat() > -1 ) {
		drop += speed * pm_frictionoverride.GetFloat() * frametime;
	} else if ( current.movementType == PM_SPECTATOR ) {

		drop += speed * PM_FLYFRICTION * frametime;
	}
	// apply ground friction
	else if ( walking && waterLevel <= WATERLEVEL_NONE ) {
		// no friction on slick surfaces
		if ( !(groundMaterial && groundMaterial->GetSurfaceFlags() & SURF_SLICK) ) {
			// if getting knocked back, no friction
			if ( !(current.movementFlags & PMF_TIME_KNOCKBACK) ) {
				control = speed < PM_STOPSPEED ? PM_STOPSPEED : speed;

				drop += control * PM_FRICTION * frametime;
			}
		}
	}
	// apply water friction even if just wading
	else if ( waterLevel >= WATERLEVEL_WAIST ) {
		drop += speed * PM_WATERFRICTION * waterLevel * frametime;
	}
	// apply air friction
	else {
		drop += speed * PM_AIRFRICTION * frametime;
	}

	// scale the velocity
	newspeed = speed - drop;
	if ( newspeed < 0 ) {
		newspeed = 0;
	}
	current.velocity *= ( newspeed / speed );

	// TTimo - snap to avoid denormals
	if ( fabs( current.velocity.x ) < 1.0e-5f ) {
		current.velocity.x = 0.0f;
	}
	if ( fabs( current.velocity.y ) < 1.0e-5f ) {
		current.velocity.y = 0.0f;
	}
	if ( fabs( current.velocity.z ) < 1.0e-5f ) {
		current.velocity.z = 0.0f;
	}
}

/*
===================
idPhysics_Player::WaterJumpMove

Flying out of the water
===================
*/
void idPhysics_Player::WaterJumpMove( void ) {

	// waterjump has no control, but falls
	idPhysics_Player::SlideMove( true, true, false, false );

	// add gravity
	current.velocity += gravityNormal * frametime;
	// if falling down
	if ( current.velocity * gravityNormal > 0.0f ) {
		// cancel as soon as we are falling down again
		current.movementFlags &= ~PMF_ALL_TIMES;
		current.movementTime = 0;
	}
	skipNextPogo = true;
	current.movementFlags |= PMF_JUMP_HELD;
}

/*
===================
idPhysics_Player::WaterMove
===================
*/
void idPhysics_Player::WaterMove( void ) {
	idVec3	wishvel;
	float	wishspeed;
	idVec3	wishdir;
	float	scale;
	float	vel;

	if ( idPhysics_Player::CheckWaterJump() ) {
		idPhysics_Player::WaterJumpMove();
		return;
	}

	idPhysics_Player::Friction();

	// user intentions
	// 3j: updated to skip cmdscale... havn't tested
	if ( !command.rightmove && !command.forwardmove && !command.upmove ) {
		wishvel = gravityNormal * 60; // sink towards bottom
	} else {
		if ( !cvarSystem->GetCVarBool( "in_freelook" ) ) {
			scale = idPhysics_Player::CmdScale( command );
			wishvel = scale * (viewForward * command.forwardmove + viewRight * command.rightmove);
			wishvel -= scale * gravityNormal * command.upmove;
		}
		else {
			wishvel = ( ( viewForward * ( command.forwardmove /127 ) ) + 
				( viewRight * ( command.rightmove / 127 ) ) );
			wishvel.Normalize();
			wishvel *= playerSpeed;

			// account for being able to swim up in water
			wishvel -= ( playerSpeed * ( command.upmove /127 ) ) * gravityNormal;
		}
	}

	wishdir = wishvel;
	wishspeed = wishdir.Normalize();

	if ( wishspeed > playerSpeed * PM_SWIMSCALE ) {
		wishspeed = playerSpeed * PM_SWIMSCALE;
	}

	if ( groundPlane ) {			// move faster when on ground
		wishspeed *= 1.5f;
	}

	idPhysics_Player::Accelerate( wishdir, wishspeed * waterLevel, PM_WATERACCELERATE );

	// make sure we can go up slopes easily under water
	if ( groundPlane && ( current.velocity * groundTrace.c.normal ) < 0.0f ) {
		vel = current.velocity.Length();
		// slide along the ground plane
		current.velocity.ProjectOntoPlane( groundTrace.c.normal, OVERCLIP );

		current.velocity.Normalize();
		current.velocity *= vel;
	}

	idPhysics_Player::SlideMove( false, true, false, false );
}

/*
===================
idPhysics_Player::FlyMove
===================
*/
void idPhysics_Player::FlyMove( void ) {
	idVec3	wishvel;
	float	wishspeed;
	idVec3	wishdir;
	float	scale;

	// normal slowdown
	idPhysics_Player::Friction();

	scale = idPhysics_Player::CmdScale( command );

	if ( !scale ) {
		wishvel = vec3_origin;
	} else {
		wishvel = scale * (viewForward * command.forwardmove + viewRight * command.rightmove);
		wishvel -= scale * gravityNormal * command.upmove;
	}

	wishdir = wishvel;
	wishspeed = wishdir.Normalize();

	idPhysics_Player::Accelerate( wishdir, wishspeed, PM_FLYACCELERATE );

	idPhysics_Player::SlideMove( false, false, false, false );
}

/*
===================
idPhysics_Player::AirMove
===================
*/
void idPhysics_Player::AirMove( void ) {
	idVec3		wishvel;
	idVec3		wishdir;
	float		wishspeed;
	float		scale;

	idPhysics_Player::Friction();

	scale = idPhysics_Player::CmdScale( command );

	// project moves down to flat plane
	viewForward -= (viewForward * gravityNormal) * gravityNormal;
	viewRight -= (viewRight * gravityNormal) * gravityNormal;
	viewForward.Normalize();
	viewRight.Normalize();

	wishvel = viewForward * command.forwardmove + viewRight * command.rightmove;
	wishvel -= (wishvel * gravityNormal) * gravityNormal;
	wishdir = wishvel;
	wishspeed = wishdir.Normalize();
	wishspeed *= scale;

	// not on ground, so little effect on velocity
	idPhysics_Player::Accelerate( wishdir, wishspeed, PM_AIRACCELERATE );

	// we may have a ground plane that is very steep, even
	// though we don't have a groundentity
	// slide along the steep plane
	if ( groundPlane ) {
		current.velocity.ProjectOntoPlane( groundTrace.c.normal, OVERCLIP );
	}

	// NOTE: enable stair checking while moving through the air in multiplayer to allow bunny hopping onto stairs
	idPhysics_Player::SlideMove( true, true, false, false );
}

// <q4f> 

void idPhysics_Player::AirMove_3j3( void ) {

	// check if the player even wants air control
	if ( idMath::Abs( command.forwardmove ) > 10 || idMath::Abs( command.rightmove ) > 10 ) {

		// project moves down to flat plane
		viewForward -= (viewForward * gravityNormal) * gravityNormal;
		viewRight -= (viewRight * gravityNormal) * gravityNormal;
		viewForward.Normalize();
		viewRight.Normalize();

		// save our velocity in the direction of gravity
		idVec3 currentGravityVelocity = ( current.velocity * gravityNormal ) * gravityNormal;

		// remove this gravitational velocity from further calculations
		idVec3 currVelDir = current.velocity;
		currVelDir -= currentGravityVelocity;
		
		// get the current lateral speed of the player
		float currSpeed = currVelDir.Normalize();

		float turnYaw = pm_airMaxYaw.GetFloat();

		// decide if we should use default QW air control or augment it
		float wishForwardSpeed = ( command.forwardmove / 127 ) * playerSpeed;
		float wishSideSpeed = ( command.rightmove / 127 ) * playerSpeed;

		idVec3 wishdir = ( wishForwardSpeed * viewForward ) + ( wishSideSpeed * viewRight );
		float wishspeed = wishdir.Normalize();

		// if the dot product between their wish dir and current speed is negative ( angle > 90 ),
		// just perform the default QW air control. Otherwise, we may tweak it
		float dot = currVelDir * wishdir;
		if ( 0.0f < dot ) {

			turnYaw = GetAverageYaw();

			float t = currSpeed / playerSpeed;
			t = t * idMath::Fabs( turnYaw ) / pm_airMaxYaw.GetFloat();

			// allow air control if holding backward
			if ( command.forwardmove < -10 )
				turnYaw *= -1.0f;

			if ( turnYaw > 0.0f ) {	// turning right
				// if they are turning right but strafing left, don't allow air control
				if ( command.rightmove >= 0 ) {
					wishdir.Lerp( wishdir, viewRight, t );
				}
			}
			else if ( turnYaw < 0.0f ) {								// turning left
				// if they are turning left but strafing right, don't allow air control
				if ( command.rightmove <= 0 ) {
					wishdir.Lerp( wishdir, -viewRight, t );
				}
			}
		}	
		//gameRenderWorld->DebugArrow( colorRed, current.origin, current.origin + ( wishdir * 100.0f ), 10, 10000 );

// simulate quake style air control

		// Allow cardinal direction air control w/ the movement keys.
		// A player is allowed to accelerate only if they are not already faster than their max speed
		// Otherwise they can still alter their direction but will not gain speed

		// limit our wishspeed
		float maxWishSpeed = playerSpeed * pm_airWishSpeedMult.GetFloat();
		if ( wishspeed > maxWishSpeed ) {
			wishspeed = maxWishSpeed;
		}
	
		// get our acceleration speed
		// for all airmoves, if we're moving against current velocity, do full acceleration
		
		float accelspeed = 1.0f;

		if ( currVelDir * wishdir >= 0.0f ) {			// attempting to move with velocity
			accelspeed = wishspeed * frametime * PM_AIRACCELERATE;
			if ( idMath::Fabs( wishdir * viewRight ) > 0.1f ) {
				// don't accel to side if not holding rightmove
				if ( idMath::Abs( command.rightmove ) < 10 ) {
					accelspeed = 0.0f;
				}
			}
		}
		else {
			/*accelspeed = ( idMath::Fabs( turnYaw )/ pm_airMaxYaw.GetFloat() );
			if ( accelspeed > 1.0f )
				accelspeed = 1.0f;*/

			accelspeed *= wishspeed * frametime * pm_airAccel.GetFloat();
		}
		/*if ( currVelDir * wishdir < 0.0f ) {
			accelspeed = wishspeed * frametime * PM_ACCELERATE;
		}
		else {
			accelspeed = wishspeed * frametime * PM_AIRACCELERATE;
		}*/

		

		// To make sure we aren't gaining speed on our own in the air:
		
		// calculate our new lateral velocity
		idVec3 newLateralVelocity = ( accelspeed * wishdir ) + ( currVelDir * currSpeed );
		
		// get the new lateral speed of the player
		float newSpeed = newLateralVelocity.Length();

		// make sure we don't accelerate past max speed if we were lower
		if ( newSpeed > currSpeed && newSpeed > ( playerSpeed * 1.5f ) ) {
            newLateralVelocity *= ( currSpeed / newSpeed );
		}

		// add back our gravitational velocity
		newLateralVelocity += currentGravityVelocity;

		current.velocity = newLateralVelocity;
	}


	// we may have a ground plane that is very steep, even
	// though we don't have a groundentity
	// slide along the steep plane
	if ( groundPlane ) {
		current.velocity.ProjectOntoPlane( groundTrace.c.normal, OVERCLIP );
	}

	// NOTE: enable stair checking while moving through the air in multiplayer to allow bunny hopping onto stairs
	idPhysics_Player::SlideMove( true, gameLocal.isMultiplayer, false, false );
}

void idPhysics_Player::AirMove_3j4( void ) {
	idVec3		wishvel;
	idVec3		wishdir;
	float		wishspeed;
	//float		scale;

	idPhysics_Player::Friction();

	// project moves down to flat plane
	viewForward -= (viewForward * gravityNormal) * gravityNormal;
	viewRight -= (viewRight * gravityNormal) * gravityNormal;
	viewForward.Normalize();
	viewRight.Normalize();

	idVec3 wishForward = ( ( command.forwardmove / 127.0f ) * playerSpeed ) * viewForward;
	idVec3 wishRight = ( ( command.rightmove / 127.0f ) * playerSpeed ) * viewRight;

	wishvel = wishForward + wishRight;
	wishvel -= ( wishvel * gravityNormal ) * gravityNormal;
	wishdir = wishvel;
	wishspeed = wishdir.Normalize();

	if ( wishspeed > playerSpeed )
		wishspeed = playerSpeed;

	idVec3 flatVel = current.velocity;
	flatVel -= ( flatVel * gravityNormal ) * gravityNormal;
	flatVel.Normalize();

	// not on ground, so little effect on velocity
	if ( wishdir * flatVel >= 0.0f )
		idPhysics_Player::Accelerate( wishdir, wishspeed, PM_AIRACCELERATE );
	else
		idPhysics_Player::Accelerate( wishdir, wishspeed, PM_AIRACCELERATE * 2.0f );

	if ( command.forwardmove != 0 ) {
		// remove gravity from velocity
		idVec3 curDir = current.velocity;
		idVec3 grav = ( curDir * gravityNormal ) * gravityNormal;
		curDir -= grav;

		float newSpeed = curDir.Normalize();

		float div;
		if ( playerSpeed <= 0.0f )
			div = 1.0f;
		else
			div = newSpeed / playerSpeed;

		idVec3 lerp = ( command.forwardmove / 127.0f ) * viewForward;
		//lerp.Normalize();

		float dot = flatVel * lerp;
		if ( dot >= 0.0f )
			curDir.Lerp( curDir, lerp, dot * 0.0952f * div );//curDir.Lerp( curDir, lerp, ( 1.0f - dot ) * 0.0952f * div );

		current.velocity = ( curDir * newSpeed ) + grav;
	}

	// we may have a ground plane that is very steep, even
	// though we don't have a groundentity
	// slide along the steep plane
	if ( groundPlane ) {
		current.velocity.ProjectOntoPlane( groundTrace.c.normal, OVERCLIP );
	}

	// NOTE: enable stair checking while moving through the air in multiplayer to allow bunny hopping onto stairs
	idPhysics_Player::SlideMove( true, true, false, false );
}

void idPhysics_Player::AirMove_3j5( void ) {

	idVec3		wishvel;
	idVec3		wishdir;
	float		wishspeed;
	float		scale;

	idPhysics_Player::Friction();

	scale = idPhysics_Player::CmdScale( command );

	// project moves down to flat plane
	viewForward -= (viewForward * gravityNormal) * gravityNormal;
	viewRight -= (viewRight * gravityNormal) * gravityNormal;
	viewForward.Normalize();
	viewRight.Normalize();

	wishvel = viewForward * command.forwardmove + viewRight * command.rightmove;
	wishvel -= (wishvel * gravityNormal) * gravityNormal;
	wishdir = wishvel;
	wishspeed = wishdir.Normalize();
	wishspeed *= scale;

	// not on ground, so little effect on velocity
	idPhysics_Player::Accelerate( wishdir, wishspeed, PM_AIRACCELERATE );

	if ( command.forwardmove != 0 ) {
		//remove gravity
		idVec3 grav = ( current.velocity * gravityNormal ) * gravityNormal;
		idVec3 vel = current.velocity - grav;

		idVec3 wish = ( ( command.forwardmove / 127.0f ) * viewForward );
		wish.Normalize();
		float speed = vel.Normalize();
		float dot = vel * wish;

		if ( dot > 0.0f ) {

			float lerp = idMath::ClampFloat( 0.0f, 0.15f, dot );

			vel.Lerp( vel * speed, wish * speed, lerp );
			current.velocity = vel + grav;
		}
	}

	// we may have a ground plane that is very steep, even
	// though we don't have a groundentity
	// slide along the steep plane
	if ( groundPlane ) {
		current.velocity.ProjectOntoPlane( groundTrace.c.normal, OVERCLIP );
	}

	// NOTE: enable stair checking while moving through the air in multiplayer to allow bunny hopping onto stairs
	idPhysics_Player::SlideMove( true, true, false, false );
}

void idPhysics_Player::AirMove_3j6( void ) {

	// check if the player even wants air control
	if ( idMath::Abs( command.forwardmove ) > 10 || idMath::Abs( command.rightmove ) > 10 ) {

		// project moves down to flat plane
		viewForward -= (viewForward * gravityNormal) * gravityNormal;
		viewRight -= (viewRight * gravityNormal) * gravityNormal;
		viewForward.Normalize();
		viewRight.Normalize();

		// save our velocity in the direction of gravity
		idVec3 currentGravityVelocity = ( current.velocity * gravityNormal ) * gravityNormal;

		// remove this gravitational velocity from further calculations
		idVec3 currVelDir = current.velocity;
		currVelDir -= currentGravityVelocity;
		
		// get the current lateral speed of the player
		float currSpeed = currVelDir.Normalize();

		// decide if we should use default QW air control or augment it
		float wishForwardSpeed = ( command.forwardmove / 127.0f ) * playerSpeed;
		float wishSideSpeed = ( command.rightmove / 127.0f ) * playerSpeed;

		idVec3 wishdir = ( wishForwardSpeed * viewForward ) + ( wishSideSpeed * viewRight );
		float wishspeed = wishdir.Normalize();

		// limit our wishspeed
		/*float maxWishSpeed = playerSpeed * pm_airWishSpeedMult.GetFloat();
		if ( wishspeed > maxWishSpeed ) {
			wishspeed = maxWishSpeed;
		}*/

		// use different acceration depending on if we are moving w/ velocity or not
		float dot = currVelDir * wishdir;

		if ( dot < 0.0f ) {
			dot *= 0.75f;

			float accelspeed = wishspeed * frametime * PM_ACCELERATE * (1.0f + dot);
			current.velocity += ( accelspeed * wishdir );
		}
		else if ( currSpeed < playerSpeed ) {
			float accelspeed = wishspeed * frametime * pm_airAccel.GetFloat();
			current.velocity += ( accelspeed * wishdir );
		}

/*

		// To make sure we aren't gaining speed on our own in the air:
		
		// calculate our new lateral velocity
		idVec3 newLateralVelocity = ( accelspeed * wishdir ) + ( currVelDir * currSpeed );
		
		// get the new lateral speed of the player
		float newSpeed = newLateralVelocity.Length();

		// make sure we don't accelerate past max speed if we were lower
		if ( newSpeed > currSpeed && newSpeed > ( playerSpeed * 1.5f ) ) {
            newLateralVelocity *= ( currSpeed / newSpeed );
		}

		// add back our gravitational velocity
		newLateralVelocity += currentGravityVelocity;

		current.velocity = newLateralVelocity;*/
	}


	// we may have a ground plane that is very steep, even
	// though we don't have a groundentity
	// slide along the steep plane
	if ( groundPlane ) {
		current.velocity.ProjectOntoPlane( groundTrace.c.normal, OVERCLIP );
	}

	// NOTE: enable stair checking while moving through the air in multiplayer to allow bunny hopping onto stairs
	idPhysics_Player::SlideMove( true, true, false, false );
}

// </q4f>

/*
===================
idPhysics_Player::WalkMove
===================
*/
void idPhysics_Player::WalkMove( void ) {
	idVec3		wishvel;
	idVec3		wishdir;
	float		wishspeed;
	float		scale;
	float		accelerate;
	idVec3		oldVelocity, vel;
	float		oldVel, newVel;

	if ( waterLevel >= WATERLEVEL_WAIST && ( viewForward * groundTrace.c.normal ) > 0.0f ) {
		// begin swimming
		idPhysics_Player::WaterMove();
		return;
	}

	if ( idPhysics_Player::CheckJump() ) {
		// jumped away
		if ( waterLevel > WATERLEVEL_FEET ) {
			idPhysics_Player::WaterMove();
		}
		else {
			idPhysics_Player::AirMove_3j6();
		}
		return;
	}

	idPhysics_Player::Friction();

	scale = idPhysics_Player::CmdScale( command );

	// project moves down to flat plane
	viewForward -= (viewForward * gravityNormal) * gravityNormal;
	viewRight -= (viewRight * gravityNormal) * gravityNormal;

	// project the forward and right directions onto the ground plane
	viewForward.ProjectOntoPlane( groundTrace.c.normal, OVERCLIP );
	viewRight.ProjectOntoPlane( groundTrace.c.normal, OVERCLIP );
	//
	viewForward.Normalize();
	viewRight.Normalize();

	wishvel = viewForward * command.forwardmove + viewRight * command.rightmove;
	wishdir = wishvel;
	wishspeed = wishdir.Normalize();
	wishspeed *= scale;

	// clamp the speed lower if wading or walking on the bottom
	if ( waterLevel > WATERLEVEL_NONE ) {
		float	waterScale;

		waterScale = waterLevel / 3.0f;
		waterScale = 1.0f - ( 1.0f - PM_SWIMSCALE ) * waterScale;
		if ( wishspeed > playerSpeed * waterScale ) {
			wishspeed = playerSpeed * waterScale;
		}
	}

	// when a player gets hit, they temporarily lose full control, which allows them to be moved a bit
	if ( ( groundMaterial && groundMaterial->GetSurfaceFlags() & SURF_SLICK ) || current.movementFlags & PMF_TIME_KNOCKBACK ) {
		accelerate = PM_AIRACCELERATE;
	}
	else {
		accelerate = PM_ACCELERATE;
	}

	idPhysics_Player::Accelerate( wishdir, wishspeed, accelerate );

	if ( ( groundMaterial && groundMaterial->GetSurfaceFlags() & SURF_SLICK ) || current.movementFlags & PMF_TIME_KNOCKBACK ) {
		current.velocity += gravityVector * frametime;
	}

	oldVelocity = current.velocity;

	// slide along the ground plane
	current.velocity.ProjectOntoPlane( groundTrace.c.normal, OVERCLIP );

	// if not clipped into the opposite direction
	if ( oldVelocity * current.velocity > 0.0f ) {
		newVel = current.velocity.LengthSqr();
		if ( newVel > 1.0f ) {
			oldVel = oldVelocity.LengthSqr();
			if ( oldVel > 1.0f ) {
				// don't decrease velocity when going up or down a slope
				current.velocity *= idMath::Sqrt( oldVel / newVel );
			}
		}
	}

	// don't do anything if standing still
	vel = current.velocity - (current.velocity * gravityNormal) * gravityNormal;
	if ( vel.IsZero() ) {
		return;
	}

	gameLocal.push.InitSavingPushedEntityPositions();

	idPhysics_Player::SlideMove( false, true, true, !gameLocal.isMultiplayer );
}

/*
==============
idPhysics_Player::DeadMove
==============
*/
void idPhysics_Player::DeadMove( void ) {
	float	forward;

	if ( !walking ) {
		return;
	}

	// extra friction
	forward = current.velocity.Length();
	forward -= 20;
	if ( forward <= 0 ) {
		current.velocity = vec3_origin;
	}
	else {
		current.velocity.Normalize();
		current.velocity *= forward;
	}
}

/*
===============
idPhysics_Player::NoclipMove
===============
*/
void idPhysics_Player::NoclipMove( void ) {
	float		speed, drop, friction, newspeed, stopspeed;
	float		scale, wishspeed;
	idVec3		wishdir;


// nmckenzie: allow trying custom frictions
	if ( pm_frictionoverride.GetFloat ( ) > -1 ) {
		idPhysics_Player::Friction();
	} else {


	// friction
	speed = current.velocity.Length();
	if ( speed < 20.0f ) {
		current.velocity = vec3_origin;
	}
	else {
		stopspeed = playerSpeed * 0.3f;
		if ( speed < stopspeed ) {
			speed = stopspeed;
		}
		friction = PM_NOCLIPFRICTION;
		drop = speed * friction * frametime;

		// scale the velocity
		newspeed = speed - drop;
		if (newspeed < 0) {
			newspeed = 0;
		}

		current.velocity *= newspeed / speed;
	}


// nmckenzie: allow trying custom frictions
	}


	// accelerate
	scale = idPhysics_Player::CmdScale( command );

	wishdir = scale * (viewForward * command.forwardmove + viewRight * command.rightmove);
	wishdir -= scale * gravityNormal * command.upmove;
	wishspeed = wishdir.Normalize();
	wishspeed *= scale;

	idPhysics_Player::Accelerate( wishdir, wishspeed, PM_ACCELERATE );

	// move
	current.origin += frametime * current.velocity;
}

/*
===============
idPhysics_Player::SpectatorMove
===============
*/
void idPhysics_Player::SpectatorMove( void ) {
	idVec3	wishvel;
	float	wishspeed;
	idVec3	wishdir;
	float	scale;

	trace_t	trace;
	idVec3	end;

	// fly movement

	idPhysics_Player::Friction();

	scale = idPhysics_Player::CmdScale( command );

	if ( !scale ) {
		wishvel = vec3_origin;
	} else {
		wishvel = scale * (viewForward * command.forwardmove + viewRight * command.rightmove);
		wishvel -= scale * gravityNormal * command.upmove;
	}

	wishdir = wishvel;
	wishspeed = wishdir.Normalize();

	idPhysics_Player::Accelerate( wishdir, wishspeed, PM_FLYACCELERATE );

	idPhysics_Player::SlideMove( false, false, false, false );
}

/*
============
idPhysics_Player::LadderMove
============
*/
void idPhysics_Player::LadderMove( void ) {
	idVec3	wishdir, wishvel, right;
	float	wishspeed, scale;
	float	upscale;

	// stick to the ladder
	wishvel = -( playerSpeed * 0.75f ) * ladderNormal;
	current.velocity = (gravityNormal * current.velocity) * gravityNormal + wishvel;

	upscale = (-gravityNormal * viewForward + 0.5f) * 2.5f;
	if ( upscale > 1.0f ) {
		upscale = 1.0f;
	}
	else if ( upscale < -1.0f ) {
		upscale = -1.0f;
	}

	scale = idPhysics_Player::CmdScale( command );
	wishvel = -0.9f * gravityNormal * upscale * scale * (float)command.forwardmove;

	// strafe
	if ( command.rightmove ) {
		// right vector orthogonal to gravity
		right = viewRight - (gravityNormal * viewRight) * gravityNormal;
		// project right vector into ladder plane
		right = right - (ladderNormal * right) * ladderNormal;
		right.Normalize();

		// if we are looking away from the ladder, reverse the right vector
		if ( ladderNormal * viewForward > 0.0f ) {
			right = -right;
		}
		wishvel += 2.0f * right * scale * (float) command.rightmove;
	}

	// up down movement
	if ( command.upmove ) {
		wishvel += -0.5f * gravityNormal * scale * (float) command.upmove;
	}

	// do strafe friction
	idPhysics_Player::Friction();

	// accelerate
	wishspeed = wishvel.Normalize();
	idPhysics_Player::Accelerate( wishvel, wishspeed, PM_ACCELERATE );

	// cap the vertical velocity
	upscale = current.velocity * -gravityNormal;
	float lSpeed = ( PM_LADDERSPEEDSCALE * playerSpeed );
	if ( upscale < -lSpeed ) {
		current.velocity += gravityNormal * (upscale + lSpeed);
	}
	else if ( upscale > lSpeed ) {
		current.velocity += gravityNormal * (upscale - lSpeed);
	}

	if ( (wishvel * gravityNormal) == 0.0f ) {
		if ( current.velocity * gravityNormal < 0.0f ) {
			current.velocity += gravityVector * frametime;
			if ( current.velocity * gravityNormal > 0.0f ) {
				current.velocity -= (gravityNormal * current.velocity) * gravityNormal;
			}
		}
		else {
			current.velocity -= gravityVector * frametime;
			if ( current.velocity * gravityNormal < 0.0f ) {
				current.velocity -= (gravityNormal * current.velocity) * gravityNormal;
			}
		}
	}

	idPhysics_Player::SlideMove( false, ( command.forwardmove > 0 ), false, false );
}

/*
=============
idPhysics_Player::CorrectAllSolid
=============
*/
void idPhysics_Player::CorrectAllSolid( trace_t &trace, int contents ) {
	if ( debugLevel ) {
		gameLocal.Printf( "%i:allsolid\n", c_pmove );
	}

	// FIXME: jitter around to find a free spot ?

	if ( trace.fraction >= 1.0f ) {
		memset( &trace, 0, sizeof( trace ) );
		trace.endpos = current.origin;
		trace.endAxis = clipModelAxis;
		trace.fraction = 0.0f;
		trace.c.dist = current.origin.z;
		trace.c.normal.Set( 0, 0, 1 );
		trace.c.point = current.origin;
		trace.c.entityNum = ENTITYNUM_WORLD;
		trace.c.id = 0;
		trace.c.type = CONTACT_TRMVERTEX;
		trace.c.material = NULL;
		trace.c.contents = contents;
	}
}

/*
=============
idPhysics_Player::CheckGround
=============
*/

// MrE: check stuck
void idPhysics_Player::CheckGround( bool checkStuck ) {

	int i, contents;
	idVec3 point;
	bool hadGroundContacts;

	hadGroundContacts = HasGroundContacts();

	// set the clip model origin before getting the contacts
	clipModel->SetPosition( current.origin, clipModel->GetAxis() );

	EvaluateContacts();

	// setup a ground trace from the contacts
	groundTrace.endpos = current.origin;
	groundTrace.endAxis = clipModel->GetAxis();
	if ( contacts.Num() ) {
		groundTrace.fraction = 0.0f;
		groundTrace.c = contacts[0];
		for ( i = 1; i < contacts.Num(); i++ ) {
			groundTrace.c.normal += contacts[i].normal;
		}
		groundTrace.c.normal.Normalize();
	} else {
		groundTrace.fraction = 1.0f;
	}


// ddynerman: multiple collision worlds
// MrE: check stuck
	if ( checkStuck ) {
		contents = gameLocal.clip.Contents( current.origin, clipModel, clipModel->GetAxis(), -1, self );
		if ( contents & MASK_SOLID ) {
			// do something corrective if stuck in solid
			idPhysics_Player::CorrectAllSolid( groundTrace, contents );
		}
	}


	// if the trace didn't hit anything, we are in free fall
	if ( groundTrace.fraction == 1.0f ) {
		groundPlane = false;
		walking = false;
		groundEntityPtr = NULL;
		return;
	}

	groundMaterial = groundTrace.c.material;
	groundEntityPtr = gameLocal.entities[ groundTrace.c.entityNum ];

	// check if getting thrown off the ground
	if ( (current.velocity * -gravityNormal) > 0.0f && ( current.velocity * groundTrace.c.normal ) > 10.0f ) {
		if ( debugLevel ) {
			gameLocal.Printf( "%i:kickoff\n", c_pmove );
		}

		groundPlane = false;
		walking = false;
		return;
	}
	
	// slopes that are too steep will not be considered onground
	if ( ( groundTrace.c.normal * -gravityNormal ) < MIN_WALK_NORMAL ) {
		if ( debugLevel ) {
			gameLocal.Printf( "%i:steep\n", c_pmove );
		}

		// FIXME: if they can't slide down the slope, let them walk (sharp crevices)

		if( gameLocal.isMultiplayer ) {
			// in multiplayer, instead of sliding push the player out from the normal for some free fall
			current.origin += groundTrace.c.normal;
			
			groundPlane = false;
			walking = false;
		} else {
			// make sure we don't die from sliding down a steep slope
			if ( current.velocity * gravityNormal > 150.0f ) {
				current.velocity -= ( current.velocity * gravityNormal - 150.0f ) * gravityNormal;
			}
			groundPlane = true;
			walking = false;
		}

		return;
	}

	groundPlane = true;
	walking = true;

	// hitting solid ground will end a waterjump
	if ( current.movementFlags & PMF_TIME_WATERJUMP ) {
		current.movementFlags &= ~( PMF_TIME_WATERJUMP | PMF_TIME_LAND );
		current.movementTime = 0;
	}

	// if the player didn't have ground contacts the previous frame
	if ( !hadGroundContacts ) {
		// don't do landing time if we were just going down a slope
		if ( (current.velocity * -gravityNormal) < -200.0f ) {
			// don't allow another jump for a little while
			current.movementFlags |= PMF_TIME_LAND;
			current.movementTime = 250;
		}		
	}

	// let the entity know about the collision
	if ( self ) {
		self->Collide( groundTrace, current.velocity );
	}


	if ( groundEntityPtr.GetEntity() ) {
		impactInfo_t info;
		groundEntityPtr.GetEntity()->GetImpactInfo( self, groundTrace.c.id, groundTrace.c.point, &info );
		if ( info.invMass != 0.0f ) {
			groundEntityPtr.GetEntity()->ApplyImpulse( self, groundTrace.c.id, groundTrace.c.point, current.velocity / ( info.invMass * 10.0f ) );
		}
	}
}

/*
==============
idPhysics_Player::CheckDuck

Sets clip model size
==============
*/
void idPhysics_Player::CheckDuck( void ) {
	trace_t	trace;
	idVec3 end;
	idBounds bounds;
	float maxZ;

	if ( current.movementType == PM_DEAD ) {
		maxZ = pm_deadheight.GetFloat();
	} else {
		// stand up when up against a ladder
		if ( command.upmove < 0 && !ladder ) {
			// duck
			current.movementFlags |= PMF_DUCKED;
		} else {
			// stand up if possible
			if ( current.movementFlags & PMF_DUCKED ) {
				// try to stand up
				end = current.origin - ( pm_normalheight.GetFloat() - pm_crouchheight.GetFloat() ) * gravityNormal;


				gameLocal.Translation( trace, current.origin, end, clipModel, clipModel->GetAxis(), clipMask, self );

				if ( trace.fraction >= 1.0f ) {
					current.movementFlags &= ~PMF_DUCKED;
				}
			}
		}

		if ( current.movementFlags & PMF_DUCKED ) {
			maxZ = pm_crouchheight.GetFloat();			
		} else {
			maxZ = pm_normalheight.GetFloat();
		}
	}
	// if the clipModel height should change
	if ( clipModel->GetBounds()[1][2] != maxZ ) {
		
		bounds = clipModel->GetBounds();
		bounds[1][2] = maxZ;
		if ( pm_usecylinder.GetBool() ) {
			clipModel->LoadModel( idTraceModel( bounds, 8 ), NULL );
		} else {
			clipModel->LoadModel( idTraceModel( bounds ), NULL );
		}
	}
}

/*
================
idPhysics_Player::CheckLadder
================
*/
void idPhysics_Player::CheckLadder( void ) {
	idVec3		forward, start, end;
	trace_t		trace;
	float		tracedist;
	
	if ( current.movementTime ) {
		return;
	}

	// if on the ground moving backwards
	if ( walking && command.forwardmove <= 0 ) {
		return;
	}

	// forward vector orthogonal to gravity
	forward = viewForward - (gravityNormal * viewForward) * gravityNormal;
	forward.Normalize();

	if ( walking ) {
		// don't want to get sucked towards the ladder when still walking
		tracedist = 1.0f;
	} else {
		tracedist = 48.0f;
	}

	end = current.origin + tracedist * forward;


	gameLocal.Translation( trace, current.origin, end, clipModel, clipModel->GetAxis(), clipMask, self );

	// if near a surface
	if ( trace.fraction < 1.0f ) {

		// if a ladder surface
		if ( trace.c.material && ( trace.c.material->GetSurfaceFlags() & SURF_LADDER ) ) {

			// check a step height higher
			end = current.origin - gravityNormal * ( maxStepHeight * 0.75f );


			gameLocal.Translation( trace, current.origin, end, clipModel, clipModel->GetAxis(), clipMask, self );

			start = trace.endpos;
			end = start + tracedist * forward;


			gameLocal.Translation( trace, start, end, clipModel, clipModel->GetAxis(), clipMask, self );


			// if also near a surface a step height higher
			if ( trace.fraction < 1.0f ) {

				// if it also is a ladder surface
				if ( trace.c.material && trace.c.material->GetSurfaceFlags() & SURF_LADDER ) {
					ladder = true;
					ladderNormal = trace.c.normal;
				}
			}
		}
	}
}

/*
=============
idPhysics_Player::CheckJump

3j: only called when walking ( has ground contacts )
=============
*/

#define AC_LIMIT_BHOP_SPEED 1

bool idPhysics_Player::CheckJump( void ) {

	assert( groundPlane );

	idVec3 addVelocity;

	if ( command.upmove < 10 ) {
		// not holding jump
		current.movementFlags &= ~PMF_JUMP_AIR;
		return false;
	}

	// must wait for jump to be released
	// 3j: easybunny
	if ( ( current.movementFlags & PMF_JUMP_HELD ) && ( !pogo || skipNextPogo ) ) {
		return false;
	}

	skipNextPogo = false;

	// don't jump if we can't stand up
	if ( current.movementFlags & PMF_DUCKED ) {
		return false;
	}

#ifndef AC_LIMIT_BHOP_SPEED

	//

#endif

	groundPlane = false;		// jumping away
	walking = false;
	current.movementFlags |= PMF_JUMP_HELD | PMF_JUMPED;
	current.movementFlags &= ~PMF_JUMP_AIR;

	

	// <q4f> 

	//addVelocity = 2.0f * maxJumpHeight * -gravityVector;
	addVelocity = gravityVector;
	float jumpLength = 2.0f * maxJumpHeight * addVelocity.Normalize();

	if ( pm_jumpOffNormal.GetBool() ) {
		// 3j: jump in direction of ground
		addVelocity = groundTrace.c.normal * idMath::Sqrt( jumpLength );
	}
	else {
		addVelocity *= ( -idMath::Sqrt( jumpLength ) );
	}
	current.velocity += addVelocity;

	// </q4f>

	return true;
}

/*
=============
idPhysics_Player::CheckWaterJump
=============
*/
bool idPhysics_Player::CheckWaterJump( void ) {
	idVec3	spot;
	idVec3	flatforward;

	if ( current.movementTime ) {
		return false;
	}

	// check for water jump
	if ( waterLevel < WATERLEVEL_WAIST ) {
		return false;
	}

	if ( current.velocity.z < -50.0f )
		return false;

	flatforward = viewForward - ( (viewForward * gravityNormal) * gravityNormal );
	flatforward.Normalize();

	idVec3 start = GetAbsBounds().GetCenter();
	spot = start + ( 32.0f * flatforward );

	trace_t tr;
	gameLocal.clip.TracePoint( tr, start, spot, MASK_SOLID, self );

	// dont jump if we dont have a solid in front of us to jump onto
	if ( tr.fraction >= 1.0f ) {
		//gameRenderWorld->DebugArrow( colorRed, start, spot, 10, 100 );
		return false;
	}

	start -= ( gravityNormal * 24.0f );
	spot -= ( gravityNormal * 24.0f );

	gameLocal.clip.TracePoint( tr, start, spot, MASK_SOLID, self );

	if ( tr.fraction < 1.0f ) {
		//gameRenderWorld->DebugArrow( colorGreen, start, spot, 10, 100 );
		return false;
	}

	// jump out of water
	current.velocity = -350.0f * gravityNormal;
	current.movementFlags |= PMF_TIME_WATERJUMP;
	current.movementTime = 2000;

	return true;
}

/*
================
idPhysics_Player::DropTimers
================
*/
void idPhysics_Player::DropTimers( void ) {
	// drop misc timing counter
	if ( current.movementTime ) {
		if ( framemsec >= current.movementTime ) {
			current.movementFlags &= ~PMF_ALL_TIMES;
			current.movementTime = 0;
		}
		else {
			current.movementTime -= framemsec;
		}
	}
}

/*
================
idPhysics_Player::MovePlayer
================
*/
void idPhysics_Player::MovePlayer( int msec ) {

	// this counter lets us debug movement problems with a journal
	// by setting a conditional breakpoint for the previous frame
	c_pmove++;

	walking = false;
	groundPlane = false;
	ladder = false;

	// determine the time
	framemsec = msec;
	frametime = framemsec * 0.001f;

	// default speed
	playerSpeed = walkSpeed;

	// remove jumped and stepped up flag
	current.movementFlags &= ~(PMF_JUMPED|PMF_STEPPED_UP|PMF_STEPPED_DOWN);
	current.stepUp = 0.0f;

	if ( command.upmove < 10 ) {
		// not holding jump
		current.movementFlags &= ~PMF_JUMP_HELD;
	}

	// if no movement at all
	if ( current.movementType == PM_FREEZE ) {
		return;
	}

	// move the player velocity into the frame of a pusher
	current.velocity -= current.pushVelocity;

	// view vectors
	viewAngles.ToVectors( &viewForward, NULL, NULL );

	viewForward *= clipModelAxis;
	viewRight = gravityNormal.Cross( viewForward );
	viewRight.Normalize();

	// fly in spectator mode

// nmckenzie: Allowing ways to force spectator movement.
	if ( current.movementType == PM_SPECTATOR || pm_forcespectatormove.GetBool() ) {

		SpectatorMove();
		idPhysics_Player::DropTimers();

// abahr: need to clear pushVelocity.  Was causing problems when noclipping while on a mover
		ClearPushedVelocity();

		return;
	}

	// special no clip mode
	if ( current.movementType == PM_NOCLIP ) {
		idPhysics_Player::NoclipMove();
		idPhysics_Player::DropTimers();

// abahr: need to clear pushVelocity.  Was causing problems when noclipping while on a mover
		ClearPushedVelocity();

		return;
	}

	// no control when dead
	if ( current.movementType == PM_DEAD ) {
		command.forwardmove = 0;
		command.rightmove = 0;
		command.upmove = 0;
	}

	// set watertype and waterlevel
	float oldLevel = waterLevel;
	current.inWater = SetWaterLevel();

	if ( idMath::Fabs( oldLevel - waterLevel ) > 0.01f ) {
		self->WaterLevelChange( oldLevel, waterLevel );
	}

	if ( waterLevel >= WATERLEVEL_WAIST ) {
		groundPlane = false;
	}
	else {
		idPhysics_Player::CheckGround( true );
		idPhysics_Player::CheckLadder();
	}

	// set clip model size
	idPhysics_Player::CheckDuck();

	// handle timers
	idPhysics_Player::DropTimers();

	// move
	if ( current.movementType == PM_DEAD ) {
		// dead
		idPhysics_Player::DeadMove();
	}
	else if ( ladder ) {
		// going up or down a ladder
		idPhysics_Player::LadderMove();
	}

	else if ( current.movementFlags & PMF_TIME_WATERJUMP ) {

		// jumping out of water
		idPhysics_Player::WaterJumpMove();
	}
	else if ( waterLevel >= WATERLEVEL_WAIST ) {

		// swimming
		idPhysics_Player::WaterMove();
	}
	else if ( walking ) {
		// walking on ground
		idPhysics_Player::WalkMove();
	}
	else {
		// airborne
		idPhysics_Player::AirMove_3j6();
	}

	idPhysics_Player::CheckGround( false );

	// move the player velocity back into the world frame
	current.velocity += current.pushVelocity;
	current.lastPushVelocity = current.pushVelocity;
	current.pushVelocity.Zero();
}

/*
================
idPhysics_Player::HasJumped
================
*/
bool idPhysics_Player::HasJumped( void ) const {
	return ( ( current.movementFlags & PMF_JUMPED ) != 0 );
}

/*
================
idPhysics_Player::HasSteppedUp
================
*/
bool idPhysics_Player::HasSteppedUp( void ) const {
	return ( ( current.movementFlags & ( PMF_STEPPED_UP | PMF_STEPPED_DOWN ) ) != 0 );
}

/*
================
idPhysics_Player::GetStepUp
================
*/
float idPhysics_Player::GetStepUp( void ) const {
	return current.stepUp;
}

/*
================
idPhysics_Player::IsCrouching
================
*/
bool idPhysics_Player::IsCrouching( void ) const {
	//MCG: if bound, never think we're crouched
	return ( !masterEntity&&( current.movementFlags & PMF_DUCKED ) != 0 );
}

/*
================
idPhysics_Player::OnLadder
================
*/
bool idPhysics_Player::OnLadder( void ) const {
	return ladder;
}

/*
================
idPhysics_Player::idPhysics_Player
================
*/
idPhysics_Player::idPhysics_Player( void ) {
	debugLevel = false;
	clipModel = NULL;
	clipMask = 0;
	memset( &current, 0, sizeof( current ) );
	saved = current;
	walkSpeed = 0;
	crouchSpeed = 0;
	maxStepHeight = 0;
	maxJumpHeight = 0;
	memset( &command, 0, sizeof( command ) );
	viewAngles.Zero();
	framemsec = 0;
	frametime = 0;
	playerSpeed = 0;
	viewForward.Zero();
	viewRight.Zero();
	walking = false;
	groundPlane = false;
	memset( &groundTrace, 0, sizeof( groundTrace ) );
	groundMaterial = NULL;
	ladder = false;
	ladderNormal.Zero();

	// <q4f> 

	skipNextPogo = false;
	pogo = true;

	waterLevel = 0.0f;

	// </q4f>
}

/*
================
idPhysics_Player_SavePState
================
*/
void idPhysics_Player_SavePState( idSaveGame *savefile, const playerPState_t &state ) {
	savefile->WriteVec3( state.origin );
	savefile->WriteVec3( state.velocity );
	savefile->WriteVec3( state.localOrigin );
	savefile->WriteVec3( state.pushVelocity );
	
	savefile->WriteVec3( state.lastPushVelocity );	// cnicholson Added unsaved var
	
	savefile->WriteFloat( state.stepUp );
	savefile->WriteInt( state.movementType );
	savefile->WriteInt( state.movementFlags );
	savefile->WriteInt( state.movementTime );
}

/*
================
idPhysics_Player_RestorePState
================
*/
void idPhysics_Player_RestorePState( idRestoreGame *savefile, playerPState_t &state ) {
	savefile->ReadVec3( state.origin );
	savefile->ReadVec3( state.velocity );
	savefile->ReadVec3( state.localOrigin );
	savefile->ReadVec3( state.pushVelocity );

	savefile->ReadVec3( state.lastPushVelocity );	// cnicholson Added unrestored var

	savefile->ReadFloat( state.stepUp );
	savefile->ReadInt( state.movementType );
	savefile->ReadInt( state.movementFlags );
	savefile->ReadInt( state.movementTime );
}

/*
================
idPhysics_Player::Save
================
*/
void idPhysics_Player::Save( idSaveGame *savefile ) const {

	idPhysics_Player_SavePState( savefile, current );
	idPhysics_Player_SavePState( savefile, saved );

	savefile->WriteFloat( walkSpeed );
	savefile->WriteFloat( crouchSpeed );
	savefile->WriteFloat( maxStepHeight );
	savefile->WriteFloat( maxJumpHeight );
	savefile->WriteInt( debugLevel );

	savefile->WriteUsercmd( command );
	savefile->WriteAngles( viewAngles );

	savefile->WriteInt( framemsec );
	savefile->WriteFloat( frametime );
	savefile->WriteFloat( playerSpeed );
	savefile->WriteVec3( viewForward );
	savefile->WriteVec3( viewRight );

	savefile->WriteBool( walking );
	savefile->WriteBool( groundPlane );
	savefile->WriteTrace( groundTrace );
	savefile->WriteMaterial( groundMaterial );

	savefile->WriteBool( ladder );
	savefile->WriteVec3( ladderNormal );

	savefile->WriteFloat( waterLevel );
	savefile->WriteInt( waterType );
}

/*
================
idPhysics_Player::Restore
================
*/
void idPhysics_Player::Restore( idRestoreGame *savefile ) {

	idPhysics_Player_RestorePState( savefile, current );
	idPhysics_Player_RestorePState( savefile, saved );

	savefile->ReadFloat( walkSpeed );
	savefile->ReadFloat( crouchSpeed );
	savefile->ReadFloat( maxStepHeight );
	savefile->ReadFloat( maxJumpHeight );
	savefile->ReadInt( debugLevel );

	savefile->ReadUsercmd( command );
	savefile->ReadAngles( viewAngles );

	savefile->ReadInt( framemsec );
	savefile->ReadFloat( frametime );
	savefile->ReadFloat( playerSpeed );
	savefile->ReadVec3( viewForward );
	savefile->ReadVec3( viewRight );

	savefile->ReadBool( walking );
	savefile->ReadBool( groundPlane );
	savefile->ReadTrace( groundTrace );
	savefile->ReadMaterial( groundMaterial );

	savefile->ReadBool( ladder );
	savefile->ReadVec3( ladderNormal );

	savefile->ReadFloat( waterLevel );
	savefile->ReadInt( waterType );
}

/*
================
idPhysics_Player::SetPlayerInput
================
*/
void idPhysics_Player::SetPlayerInput( const usercmd_t &cmd, const idAngles &newViewAngles ) {
	command = cmd;
	viewAngles = newViewAngles;		// can't use cmd.angles cause of the delta_angles
}

/*
================
idPhysics_Player::SetSpeed
================
*/
void idPhysics_Player::SetSpeed( const float newWalkSpeed, const float newCrouchSpeed ) {
	walkSpeed = newWalkSpeed;
	crouchSpeed = newCrouchSpeed;
}

/*
================
idPhysics_Player::SetMaxStepHeight
================
*/
void idPhysics_Player::SetMaxStepHeight( const float newMaxStepHeight ) {
	maxStepHeight = newMaxStepHeight;
}

/*
================
idPhysics_Player::GetMaxStepHeight
================
*/
float idPhysics_Player::GetMaxStepHeight( void ) const {
	return maxStepHeight;
}

/*
================
idPhysics_Player::SetMaxJumpHeight
================
*/
void idPhysics_Player::SetMaxJumpHeight( const float newMaxJumpHeight ) {
	maxJumpHeight = newMaxJumpHeight;
}

/*
================
idPhysics_Player::SetMovementType
================
*/
void idPhysics_Player::SetMovementType( const pmtype_t type ) {
	current.movementType = type;
}

/*
================
idPhysics_Player::SetKnockBack
================
*/
void idPhysics_Player::SetKnockBack( const int knockBackTime ) {
	if ( current.movementTime ) {
		return;
	}
	current.movementFlags |= PMF_TIME_KNOCKBACK;
	current.movementTime = knockBackTime;
}

/*
================
idPhysics_Player::SetDebugLevel
================
*/
void idPhysics_Player::SetDebugLevel( bool set ) {
	debugLevel = set;
}

/*
================
idPhysics_Player::Evaluate
================
*/
bool idPhysics_Player::Evaluate( int timeStepMSec, int endTimeMSec ) {
	idVec3 masterOrigin, oldOrigin;
	idMat3 masterAxis;

	waterType = 0;
	oldOrigin = current.origin;

	clipModel->Unlink();

	// if bound to a master
	if ( masterEntity ) {
		assert( self );
		self->GetMasterPosition( masterOrigin, masterAxis );
		current.origin = masterOrigin + current.localOrigin * masterAxis;


		clipModel->Link( self, 0, current.origin, clipModel->GetAxis() );

		current.velocity = ( current.origin - oldOrigin ) / ( timeStepMSec * 0.001f );
		masterDeltaYaw = masterYaw;
		masterYaw = masterAxis[0].ToYaw();
		masterDeltaYaw = masterYaw - masterDeltaYaw;
		return true;
	}

	ActivateContactEntities();

	idPhysics_Player::MovePlayer( timeStepMSec );

	// TTimo: only if tied to an ent
	if ( self ) {
		clipModel->Link( self, 0, current.origin, clipModel->GetAxis() );


		// IsOutsideWorld uses self, so it needs to be non null
		if ( IsOutsideWorld() ) {
			gameLocal.Warning( "clip model outside world bounds for entity '%s' at (%s)", self ? "NULL" : self->name.c_str(), current.origin.ToString(0) );
		}
	}

	return true; //( current.origin != oldOrigin );
}

/*
================
idPhysics_Player::UpdateTime
================
*/
void idPhysics_Player::UpdateTime( int endTimeMSec ) {
}

/*
================
idPhysics_Player::GetTime
================
*/
int idPhysics_Player::GetTime( void ) const {
	return gameLocal.time;
}

/*
================
idPhysics_Player::GetImpactInfo
================
*/
void idPhysics_Player::GetImpactInfo( const int id, const idVec3 &point, impactInfo_t *info ) const {
	info->invMass = invMass;
	info->invInertiaTensor.Zero();
	info->position.Zero();
	info->velocity = current.velocity;
}

/*
================
idPhysics_Player::ApplyImpulse
================
*/
void idPhysics_Player::ApplyImpulse( const int id, const idVec3 &point, const idVec3 &impulse ) {
	if ( current.movementType != PM_NOCLIP ) {
		current.velocity += impulse * invMass;
	}
}

/*
================
idPhysics_Player::IsAtRest
================
*/
bool idPhysics_Player::IsAtRest( void ) const {
	return false;
}

/*
================
idPhysics_Player::GetRestStartTime
================
*/
int idPhysics_Player::GetRestStartTime( void ) const {
	return -1;
}

/*
================
idPhysics_Player::SaveState
================
*/
void idPhysics_Player::SaveState( void ) {
	saved = current;
}

/*
================
idPhysics_Player::RestoreState
================
*/
void idPhysics_Player::RestoreState( void ) {
	current = saved;


	clipModel->Link( self, 0, current.origin, clipModel->GetAxis() );


	EvaluateContacts();
}

/*
================
idPhysics_Player::SetOrigin
================
*/
void idPhysics_Player::SetOrigin( const idVec3 &newOrigin, int id ) {
	idVec3 masterOrigin;
	idMat3 masterAxis;

	current.localOrigin = newOrigin;
	if ( masterEntity ) {
		assert( self );
		self->GetMasterPosition( masterOrigin, masterAxis );
		current.origin = masterOrigin + newOrigin * masterAxis;
	}
	else {
		current.origin = newOrigin;
	}


	if ( self ) {
		clipModel->Link( self, 0, newOrigin, clipModel->GetAxis() );
	}
}

/*
================
idPhysics_Player::GetOrigin
================
*/
const idVec3 & idPhysics_Player::PlayerGetOrigin( void ) const {
	return current.origin;
}

/*
================
idPhysics_Player::SetAxis
================
*/
void idPhysics_Player::SetAxis( const idMat3 &newAxis, int id ) {


	clipModel->Link( self, 0, clipModel->GetOrigin(), newAxis );

}

/*
================
idPhysics_Player::Translate
================
*/
void idPhysics_Player::Translate( const idVec3 &translation, int id ) {

	current.localOrigin += translation;
	current.origin += translation;


	clipModel->Link( self, 0, current.origin, clipModel->GetAxis() );

}

/*
================
idPhysics_Player::Rotate
================
*/
void idPhysics_Player::Rotate( const idRotation &rotation, int id ) {
	idVec3 masterOrigin;
	idMat3 masterAxis;

	current.origin *= rotation;
	if ( masterEntity ) {
		self->GetMasterPosition( masterOrigin, masterAxis );
		current.localOrigin = ( current.origin - masterOrigin ) * masterAxis.Transpose();
	}
	else {
		current.localOrigin = current.origin;
	}


	clipModel->Link( self, 0, current.origin, clipModel->GetAxis() * rotation.ToMat3() );

}

/*
================
idPhysics_Player::SetLinearVelocity
================
*/
void idPhysics_Player::SetLinearVelocity( const idVec3 &newLinearVelocity, int id ) {
	current.velocity = newLinearVelocity;
}

/*
================
idPhysics_Player::GetLinearVelocity
================
*/
const idVec3 &idPhysics_Player::GetLinearVelocity( int id ) const {
	return current.velocity;
}

/*
================
idPhysics_Player::SetPushed
================
*/
void idPhysics_Player::SetPushed( int deltaTime ) {
	idVec3 velocity;
	float d;

	// velocity with which the player is pushed
	velocity = ( current.origin - saved.origin ) / ( deltaTime * idMath::M_MS2SEC );

	// remove any downward push velocity
	d = velocity * gravityNormal;
	if ( d > 0.0f ) {
		velocity -= d * gravityNormal;
	}

	current.pushVelocity += velocity;
}

/*
================
idPhysics_Player::GetPushedLinearVelocity
================
*/
const idVec3 &idPhysics_Player::GetPushedLinearVelocity( const int id ) const {
	return current.lastPushVelocity;
}

/*
================
idPhysics_Player::ClearPushedVelocity
================
*/
void idPhysics_Player::ClearPushedVelocity( void ) {
	current.pushVelocity.Zero();
	current.lastPushVelocity.Zero ( );
}

/*
================
idPhysics_Player::SetMaster

  the binding is never orientated
================
*/
void idPhysics_Player::SetMaster( idEntity *master, const bool orientated ) {
	idVec3 masterOrigin;
	idMat3 masterAxis;

	if ( master ) {
		if ( !masterEntity ) {
			// transform from world space to master space
			self->GetMasterPosition( masterOrigin, masterAxis );
			current.localOrigin = ( current.origin - masterOrigin ) * masterAxis.Transpose();
			masterEntity = master;
			masterYaw = masterAxis[0].ToYaw();
		}
		ClearContacts();
	}
	else {
		if ( masterEntity ) {
			masterEntity = NULL;
		}
	}
}

const float	PLAYER_VELOCITY_MAX				= 4000;
const int	PLAYER_VELOCITY_TOTAL_BITS		= 16;
const int	PLAYER_VELOCITY_EXPONENT_BITS	= idMath::BitsForInteger( idMath::BitsForFloat( PLAYER_VELOCITY_MAX ) ) + 1;
const int	PLAYER_VELOCITY_MANTISSA_BITS	= PLAYER_VELOCITY_TOTAL_BITS - 1 - PLAYER_VELOCITY_EXPONENT_BITS;
const int	PLAYER_MOVEMENT_TYPE_BITS		= 3;
const int	PLAYER_MOVEMENT_FLAGS_BITS		= 8;

/*
================
idPhysics_Player::WriteToSnapshot
================
*/
void idPhysics_Player::WriteToSnapshot( idBitMsgDelta &msg ) const {
	msg.WriteFloat( current.origin[0] );
	msg.WriteFloat( current.origin[1] );
	msg.WriteFloat( current.origin[2] );

	msg.WriteDeltaFloat( 0.0f, current.velocity[0] );
	msg.WriteDeltaFloat( 0.0f, current.velocity[1] );
	msg.WriteDeltaFloat( 0.0f, current.velocity[2] );

	msg.WriteDeltaFloat( current.origin[0], current.localOrigin[0] );
	msg.WriteDeltaFloat( current.origin[1], current.localOrigin[1] );
	msg.WriteDeltaFloat( current.origin[2], current.localOrigin[2] );

	msg.WriteDeltaFloat( 0.0f, current.pushVelocity[0] );
	msg.WriteDeltaFloat( 0.0f, current.pushVelocity[1] );
	msg.WriteDeltaFloat( 0.0f, current.pushVelocity[2] );

	msg.WriteDeltaFloat( 0.0f, current.stepUp );
	msg.WriteBits( current.movementType, PLAYER_MOVEMENT_TYPE_BITS );
	msg.WriteBits( current.movementFlags, PLAYER_MOVEMENT_FLAGS_BITS );
	msg.WriteDeltaLong( 0, current.movementTime );
}

/*
================
idPhysics_Player::ReadFromSnapshot
================
*/
void idPhysics_Player::ReadFromSnapshot( const idBitMsgDelta &msg ) {
	
	idVec3 oldOrigin = current.origin;

	current.origin[0] = msg.ReadFloat();
	current.origin[1] = msg.ReadFloat();
	current.origin[2] = msg.ReadFloat();

	GAMELOG_SET( "origin_delta_x", (current.origin - oldOrigin).x );
	GAMELOG_SET( "origin_delta_y", (current.origin - oldOrigin).y );
	GAMELOG_SET( "origin_delta_z", (current.origin - oldOrigin).z );

//	current.velocity[0] = msg.ReadFloat( PLAYER_VELOCITY_EXPONENT_BITS, PLAYER_VELOCITY_MANTISSA_BITS );
//	current.velocity[1] = msg.ReadFloat( PLAYER_VELOCITY_EXPONENT_BITS, PLAYER_VELOCITY_MANTISSA_BITS );
//	current.velocity[2] = msg.ReadFloat( PLAYER_VELOCITY_EXPONENT_BITS, PLAYER_VELOCITY_MANTISSA_BITS );

	idVec3 oldVelocity = current.velocity;

	current.velocity[0] = msg.ReadDeltaFloat( 0.0f );
	current.velocity[1] = msg.ReadDeltaFloat( 0.0f );
	current.velocity[2] = msg.ReadDeltaFloat( 0.0f );

	GAMELOG_SET( "velocity_delta_x", (current.velocity - oldVelocity).x );
	GAMELOG_SET( "velocity_delta_y", (current.velocity - oldVelocity).y );
	GAMELOG_SET( "velocity_delta_z", (current.velocity - oldVelocity).z );

	current.localOrigin[0] = msg.ReadDeltaFloat( current.origin[0] );
	current.localOrigin[1] = msg.ReadDeltaFloat( current.origin[1] );
	current.localOrigin[2] = msg.ReadDeltaFloat( current.origin[2] );
//	current.pushVelocity[0] = msg.ReadDeltaFloat( 0.0f, PLAYER_VELOCITY_EXPONENT_BITS, PLAYER_VELOCITY_MANTISSA_BITS );
//	current.pushVelocity[1] = msg.ReadDeltaFloat( 0.0f, PLAYER_VELOCITY_EXPONENT_BITS, PLAYER_VELOCITY_MANTISSA_BITS );
//	current.pushVelocity[2] = msg.ReadDeltaFloat( 0.0f, PLAYER_VELOCITY_EXPONENT_BITS, PLAYER_VELOCITY_MANTISSA_BITS );
	current.pushVelocity[0] = msg.ReadDeltaFloat( 0.0f );
	current.pushVelocity[1] = msg.ReadDeltaFloat( 0.0f );
	current.pushVelocity[2] = msg.ReadDeltaFloat( 0.0f );

	current.stepUp = msg.ReadDeltaFloat( 0.0f );
	current.movementType = msg.ReadBits( PLAYER_MOVEMENT_TYPE_BITS );
	
	current.movementFlags = msg.ReadBits( PLAYER_MOVEMENT_FLAGS_BITS );
	if( !( saved.movementFlags & PMF_JUMP_HELD ) && current.movementFlags & PMF_JUMP_HELD ) {
		assert( self && self->IsType( idPlayer::GetClassType() ) );
		((idPlayer*)self)->jumpDuringHitch = true;
	}

	current.movementTime = msg.ReadDeltaLong( 0 );

	if ( clipModel ) {


		clipModel->Link( self, 0, current.origin, clipModel->GetAxis() );

	}
}

/*
===============
idPhysics_Player::SetClipModelNoLink
===============
*/
void idPhysics_Player::SetClipModelNoLink( idClipModel *model ) {
	assert( model );
	assert( model->IsTraceModel() );

	if ( clipModel && clipModel != model ) {
		delete clipModel;
	}
	clipModel = model;
}

bool idPhysics_Player::SetWaterLevel() {

	waterLevel = 0.0f;
	waterType = 0;

	idVec3		point;
	idBounds	bounds;

	bounds = clipModel->GetBounds();

	//float height = bounds[1][2] - bounds[0][2];

	// check at feet level

	idBounds waterBounds;

	idBounds selfBounds = GetBounds().Translate( GetOrigin() ).Rotate( GetAxis() );
	float selfVolume = selfBounds.GetVolume();

	idBounds iSect;
	float iSectVolume;

	float totalWaterLevel = 0.0f;

	for ( int i = 0; i < gameLocal.waterEnts.Num() && waterLevel < WATERLEVEL_HEAD; i++ ) {
		waterBounds = gameLocal.waterEnts[i]->GetPhysics()->GetAbsBounds();

		iSect = waterBounds.Intersect( selfBounds );
		iSectVolume = iSect.GetVolume();

		totalWaterLevel += ( iSectVolume / selfVolume );

		// check at feet level
		/*if ( waterLevel < WATERLEVEL_FEET ) {

			point = current.origin - ( height * WATERLEVEL_FEET ) * gravityNormal;

			if ( waterBounds.ContainsPoint( point ) )
				waterLevel = WATERLEVEL_FEET;
		}

		// check at waist level
		if ( waterLevel >= WATERLEVEL_FEET && waterLevel < WATERLEVEL_WAIST ) {
			point = current.origin - ( height * WATERLEVEL_WAIST ) * gravityNormal;

			if ( waterBounds.ContainsPoint( point ) )
				waterLevel = WATERLEVEL_WAIST;
		}

		// check at head level
		if ( waterLevel >= WATERLEVEL_WAIST && waterLevel < WATERLEVEL_HEAD ) {
			point = current.origin - ( height * WATERLEVEL_HEAD ) * gravityNormal;

			if ( waterBounds.ContainsPoint( point ) )
				waterLevel = WATERLEVEL_HEAD;
		}*/
	}
	waterLevel = idMath::ClampFloat( 0.0f, 1.0f, totalWaterLevel );

	return waterLevel > WATERLEVEL_NONE;
}
