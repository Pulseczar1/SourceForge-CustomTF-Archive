#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"

#define PLACE_ENT_BUFFER 2.0f

/*
===============================================================================

	Positions the ghost of an entity in front if the player for construction.

===============================================================================
*/

//==========================================================================
// Constructor. Make sure our variables are clear
//==========================================================================
BuildPreview::BuildPreview() {
	Init();
}

BuildPreview::~BuildPreview() {
	RemoveModel();
	if ( clipModel ) {
		delete clipModel;
		clipModel = NULL;
	}
}

//==========================================================================
// Make sure our variables are clear
//==========================================================================
void BuildPreview::Init() {
	owner				= NULL;
	
	modelCenter.Zero();
	modelRotation		= 0.0f;
	lastValidPos.Zero();
	lastValidAxis.Identity();
	
	modelHandle = -1;
	memset( &renderModel, 0, sizeof( renderModel ) );

	previewing = false;

	previewDef = NULL;
	distStartBuild = 0.0f;
	distSetupBuild = 0.0f;

	clipModel = NULL;

	allowBuild = false;

	up.Zero();
	up.z = 1.0f;
}

//==========================================================================
// Initialize variables and start preview
//==========================================================================
void BuildPreview::Start( idPlayer* player, const idDeclEntityDef* entDef ) {
	idVec2					tmpVec2;

	// make sure we aren't already trying to place something
	if ( previewing ) {
		gameLocal.Warning( "BuildPreview::Start - Already placing entity.\n" );
		return;
	}

	// clear our shizazzle
	Init();

	// check the basics
	if ( entDef == NULL || player == NULL || !player->IsType( idPlayer::GetClassType() ) ) {
		gameLocal.Warning( "BuildPreview::Start - Bad arguments" );
		return;
	}

	owner = player;
	previewDef = entDef;

	InitModel();

	// set up bounds variables
	heightAdjust			= renderModel.bounds.GetCenter().z;
	idBounds playerBounds	= player->GetPhysics()->GetBounds();
	
	idBounds modelBounds;
	modelBounds.Zero();
	modelBounds.AddPoint( previewDef->dict.GetVector( "mins", "-1 -1 0" ) );
	modelBounds.AddPoint( previewDef->dict.GetVector( "maxs", "1 1 1" ) );

	modelCenterOffset = modelBounds.GetCenter();
	modelCenterOffset.z = 0.0f;


	// load values
	distStartBuild	= previewDef->dict.GetFloat( "start_build_dist", "0.0" );
	
	// position the model in front of the player, playerRadius + modelRadius distance away
	// if this puts us past our distStartBuild, then the model is too damn fat or the place distance is too small
	// which means we adjust the max build distance to setupBuild
	//tmpVec2				 = idVec2( modelBounds[0].x, modelBounds[0].y ) - idVec2( modelBounds[1].x, modelBounds[1].y );
	//distSetupBuild		 = tmpVec2.Length();
	//tmpVec2				 = idVec2( playerBounds[0].x, playerBounds[0].y ) - idVec2( playerBounds[1].x, playerBounds[1].y );
	//distSetupBuild		 = ( distSetupBuild + tmpVec2.Length() ) / 2;

	if ( !previewDef->dict.GetBool( "skipPreview" ) ) {
		distSetupBuild = GetRadius( playerBounds ) + GetRadius( modelBounds );

		if ( distSetupBuild > distStartBuild ) {
			gameLocal.Warning( "BuildPreview::Start - Cannot place entity far enough away\n" );
			distStartBuild = distSetupBuild;
		}
	}
	else {
		distSetupBuild = 16.0f;
	}

	idTraceModel trm( modelBounds );

	clipModel = NULL;
	RV_PUSH_HEAP_MEM(this);

	clipModel = new idClipModel( trm, NULL );

	RV_POP_HEAP();

	clipModel->SetContents( CONTENTS_SOLID );

	previewing = true;
	allowBuild = false;
}


//--------------------------------------------------------------------------
// Initialize our model
//--------------------------------------------------------------------------
void BuildPreview::InitModel() {
	assert( previewDef );

	const idDict* dict = &(previewDef->dict);

	const idDeclEntityDef* modelDef = gameLocal.FindEntityDef( dict->GetString( "def_previewModel" ), false );
	if ( !modelDef ) {
		gameLocal.Error( "BuildPreview::InitModels - could not find model def for def_previewModel" );
		return;
	}

	const idDeclModelDef* model = static_cast<const idDeclModelDef *>( declManager->FindType( DECL_MODELDEF, modelDef->dict.GetString( "model" ), false ) );
	if ( model ) {
		renderModel.hModel = model->ModelHandle();
	}
	if ( !renderModel.hModel ) {
		renderModel.hModel = renderModelManager->FindModel( modelDef->dict.GetString( "model" ) );
	}
	if ( renderModel.hModel ) {
		renderModel.bounds = renderModel.hModel->Bounds( &renderModel );
	}
	else {
		renderModel.bounds.Zero();
	}

	const char* temp = modelDef->dict.GetString( "skin" );
	if ( temp[0] != '\0' ) {
		renderModel.customSkin = declManager->FindSkin( temp );
	} else if ( model ) {
		renderModel.customSkin = model->GetDefaultSkin();
	}

	renderModel.origin = vec3_zero;
	renderModel.axis.Identity();

	// get shader parms
	renderModel.shaderParms[ SHADERPARM_RED ]	= 1.0f;
	renderModel.shaderParms[ SHADERPARM_GREEN ]	= 1.0f;
	renderModel.shaderParms[ SHADERPARM_BLUE ]	= 1.0f;
	renderModel.shaderParms[ SHADERPARM_ALPHA ]	= 1.0f;

	modelHandle = -1;
	modelHandle = gameRenderWorld->AddEntityDef( &renderModel );
}

//==========================================================================
// Initializes the variables that will be needed by all checks
// Calls the necessary checks
// Sets the placeEnt RGB colors and allowBuild var
//==========================================================================
void BuildPreview::CalcPosition() {
	if ( !previewing || owner.GetEntity() == NULL ) {
		previewing = false;
		gameLocal.Warning( "BuildPreview::CalcPosition - not in preview or owner is null\n" );
		return;
	}

	allowBuild = false;

	idMat3 playerAxis;
	idVec3 playerEyePos;
	owner->GetViewPos( playerEyePos, playerAxis );

	idVec3 playerOrigin			= owner->GetPhysics()->GetOrigin();
	idAngles playerAngles		= playerAxis.ToAngles();
	idVec3 playerCenter			= owner->GetPhysics()->GetAbsBounds().GetCenter();
	idVec3 toForward			= playerAngles.ToForward();

	// face model towards player
	idAngles tmpAngles = idAngles( 0.0f, playerAngles.yaw + modelRotation, 0.0f );
	currentRotation = tmpAngles.yaw;
	renderModel.axis = tmpAngles.ToMat3();

	// place model in front of player, at a height based on the viewangles
	// negative pitch means looking up
	// modelCenter holds where our model is for positioning
	float sy, cy;
	idMath::SinCos( DEG2RAD( playerAngles.yaw ), sy, cy );
	modelCenter				 = idVec3( cy, sy, 0.0f ) * ( distSetupBuild + PLACE_ENT_BUFFER );
	modelCenter				+= playerCenter;
	modelCenter				+= ( modelCenterOffset * renderModel.axis );
	idVec3 resetPos			 = modelCenter;
	idVec3 lowestFloorPos	 = modelCenter;
	lowestFloorPos.z		-= distStartBuild;
	modelCenter.z			+= distStartBuild;

	// find all of our floor positions
	int floorCount = 0;
	int validPosCount = 0;

	while( GetFloorPos( modelCenter, renderModel.axis, lowestFloorPos ) ) {
		floorPositions[floorCount] = modelCenter;
		floorCount++;
		if ( floorCount >= MAX_FLOOR_POS ) break;

		modelCenter.z -= 16.0f;							// arbitrary: find next floor
	}

	for ( int i = 0; i < floorCount; i++ ) {
		if ( IsValidPos( floorPositions[i], renderModel.axis ) ) {
			validPositions[validPosCount] = floorPositions[i];
			validPosCount++;
		}
		if ( validPosCount >= MAX_VALID_POS ) break;
	}

	if ( validPosCount <= 0 ) {
		// no valid positions, try last valid position
		/*
		lowestFloorPos.x = lastValidPos.x;
		lowestFloorPos.y = lastValidPos.y;
		if ( GetFloorPos( lastValidPos, lastValidAxis, lowestFloorPos ) && IsValidPos( lastValidPos, lastValidAxis ) ) {
				modelCenter = lastValidPos;
				modelRotation = lastValidAxis.ToAngles().yaw;
				renderModel.axis = lastValidAxis;
				allowBuild = true;
		}
		else */{
			// absolutely no valid positions
			// draw in front of player based on their angle
			//modelCenter = playerEyePos + ( toForward * distStartBuild );
			modelCenter.z = lastValidPos.z;
			//modelCenter.z -= heightAdjust;
		}
	}
	else {
		// atleast one valid position, first try the simple case
		if ( validPosCount == 1 ) {
			modelCenter = validPositions[0];
		}
		else {
			// the bigger the dot product, the smaller the angle

			idVec3 tmpVec	 = validPositions[0] - playerEyePos;
			tmpVec.z		+= heightAdjust;						// move to center
			tmpVec.Normalize();
			float tmpFloat	= ( tmpVec * toForward );
			int tmpInt	= 0;
			for ( int i = 1; i < validPosCount; i++ ) {
				tmpVec		= validPositions[i] - playerEyePos;
				tmpVec.Normalize();
				cy			= ( tmpVec * toForward );

				if ( cy > tmpFloat ) {
					tmpFloat	= cy;
					tmpInt		= i;
				}
			}
			modelCenter = floorPositions[tmpInt];
		}
		lastValidPos = modelCenter;
		lastValidAxis = renderModel.axis;
		allowBuild = true;
	}
}


//--------------------------------------------------------------------------
// Draw the current position
//--------------------------------------------------------------------------
void BuildPreview::Draw() {
	if ( allowBuild ) {
		// set skin to an allowed color ( white effect )....
		renderModel.shaderParms[ SHADERPARM_GREEN ] = 1.0f;
		renderModel.shaderParms[ SHADERPARM_BLUE ] = 1.0f;
	} else {
		// set skin to redish color....
		renderModel.shaderParms[ SHADERPARM_GREEN ] = 0.0f;
		renderModel.shaderParms[ SHADERPARM_BLUE ] = 0.0f;
	}

	// position model
	renderModel.origin = modelCenter;
	
	// send update to renderer
	if ( modelHandle != -1 )
		gameRenderWorld->UpdateEntityDef( modelHandle, &renderModel );
}

//==========================================================================
// Check if the model isn't in solid volume and isn't too close / far away
//==========================================================================
bool BuildPreview::IsValidPos( idVec3 &pos, idMat3 &axis ) {
	assert( previewing );

	idVec3 myPos = pos;
	myPos.z += heightAdjust;

	// make sure we're close enough / not too close
	float dist = ( owner->GetPhysics()->GetAbsBounds().GetCenter() - myPos ).Length();

	if ( dist > distStartBuild || dist < distSetupBuild )
		return false;
	
	// intersected by any solids?
	if ( !FitsVolume( pos, axis ) )
		return false;
	
	return true;
}

//==========================================================================
// Sets floorPos to the next floor position( w/ buffer )
// Returns false if no floor position found
//==========================================================================
bool BuildPreview::GetFloorPos( idVec3 &pos, idMat3 &axis, idVec3 &lowestPos )
{

	// find a floor position for the entity
	trace_t tracer;
	gameLocal.clip.Translation( tracer, pos, lowestPos, clipModel, axis, MASK_SOLID | CONTENTS_WRENCH, owner );
	if ( tracer.fraction < 1.0f && tracer.c.entityNum != ENTITYNUM_NONE ) {
		// don't allow building on > 45 degree slope
		float dot = ( tracer.c.normal * up );
		if ( dot > 0.707f ) {
			pos = tracer.endpos;
			pos.z += PLACE_ENT_BUFFER;

			//gameRenderWorld->DebugBounds( colorGreen, clipModel->GetBounds(), tracer.endpos, 10 );

			return true;
		}
	}
	return false;
}

//==========================================================================
// Checks if the position + bounds has any intersecting solid material
// *** Now that the bounds are fixed, this guy should never hit the player
//==========================================================================
bool BuildPreview::FitsVolume( idVec3 &pos, idMat3 &axis ) {
	int contents = gameLocal.clip.Contents( pos, clipModel, axis, MASK_PLAYERSOLID, owner );

	if ( contents & MASK_PLAYERSOLID) {
		return false;
	}

	return true;
}

//==========================================================================
// Used for rotating the entity's orientation
//==========================================================================
void BuildPreview::Rotate( float degrees ) {
	modelRotation += degrees;
	if ( modelRotation >= 360.0f )	modelRotation -= 360.0f;
	else if ( modelRotation <= 0.0f ) modelRotation += 360.0f;
}

//==========================================================================
// Unconditional stop of placement
//==========================================================================
void BuildPreview::Stop() {
	RemoveModel();
	Init();
}

//==========================================================================
// Frees the model def
//==========================================================================
void BuildPreview::RemoveModel() {
	if ( modelHandle != -1 ) {
		gameRenderWorld->FreeEntityDef( modelHandle );
		modelHandle = -1;
	}
}