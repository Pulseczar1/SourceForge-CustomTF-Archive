#include "../../../idlib/precompiled.h"
#pragma hdrstop

#include "../../Game_local.h"

const idEventDef EV_EmpExplode( "<empexplode>" );
const idEventDef EV_AllowPickup( "<allowpickup>" );

CLASS_DECLARATION( TFEntity, TFItem )
	EVENT( EV_Touch,			TFItem::Event_Touch )
	EVENT( EV_EmpExplode,		TFItem::Event_EmpExplode )
	EVENT( EV_AllowPickup,		TFItem::Event_AllowPickup )
	EVENT( EV_Activate,			TFItem::Event_Activate )
END_CLASS



TFItem::TFItem() {

	currentEffect	= NULL;

	skin			= NULL;
	pickupSkin		= NULL;
	trigger			= NULL;

	fl.networkSync	= true;
	usingSkin		= false;
	spawned			= false;
	syncPhysics		= false;

	simpleItem = false;
	pickedUp = false;

	dropToFloor		= false;

	spawnTime		= gameLocal.time;

	clientState = TFSTATE_INVISIBLE;
}

/*
================
TFItem::~TFItem
================
*/
TFItem::~TFItem() {
	if ( trigger ) {
		delete trigger;
		trigger = NULL;
	}

	if ( currentEffect ) {
		currentEffect->Stop();
	}

	currentEffect	= NULL;
	doTrans = false;

	SetPhysics( NULL );
}


void TFItem::Spawn( void ) {
	idVec3		vSize;
	idBounds	bounds( vec3_origin );

	// check for triggerbounds, which allows for non-square triggers (useful for, say, a CTF flag)
	if ( spawnArgs.GetVector( "triggerbounds", "16 16 16", vSize )) {
		bounds.AddPoint(idVec3( vSize.x*0.5f,  vSize.y*0.5f, -2.0f));
		bounds.AddPoint(idVec3(-vSize.x*0.5f, -vSize.y*0.5f, vSize.z + 2.0f ));
	}
	else {
		// use the model as our bounds
		bounds = renderEntity.bounds;
	}

	RV_PUSH_HEAP_MEM(this);
	trigger = new idClipModel( idTraceModel( bounds ) );
	RV_POP_HEAP();

	trigger->Link( this, 0, GetPhysics()->GetOrigin(), GetPhysics()->GetAxis() );
	trigger->SetContents( CONTENTS_TRIGGER );

	physicsObj.SetSelf ( this );
	
	int numSides;
	idTraceModel trm;
	if ( spawnArgs.GetInt( "cylinder", "0", numSides ) ) {
		trm.SetupCylinder( renderEntity.bounds, numSides < 3 ? 3 : numSides );
	} else if ( spawnArgs.GetInt( "cone", "0", numSides ) ) {
		trm.SetupCone( renderEntity.bounds, numSides < 3 ? 3 : numSides );

	} else if ( spawnArgs.GetInt( "dodecahedron", "0", numSides ) && numSides > 0 ) {
		trm.SetupDodecahedron ( bounds );
	} else {
		// make our collision model the same size as the render model
		trm.SetupBox( renderEntity.bounds );	
	}

	RV_PUSH_HEAP_MEM(this);
	physicsObj.SetClipModel( new idClipModel( trm ), 1.0f );
	RV_POP_HEAP();

	physicsObj.SetOrigin( GetPhysics()->GetOrigin() );
	physicsObj.SetAxis( GetPhysics()->GetAxis() );
	physicsObj.SetGravity( gameLocal.GetGravity() * spawnArgs.GetFloat( "gravity", "1" ) );
	physicsObj.SetContents( 0 );
	GetPhysics( )->SetClipMask( GetPhysics( )->GetClipMask( ) | CONTENTS_ITEMCLIP );
	physicsObj.SetFriction( 0.0f, 0.0f, spawnArgs.GetFloat( "friction", "6.0" ) );
	SetPhysics( &physicsObj );

	skin = NULL;
	if ( spawnArgs.GetString( "skin", NULL ) ) {
		skin = declManager->FindSkin( spawnArgs.GetString( "skin" ), false );
		if( skin ) {
			SetSkin( skin );
		}
	}
	if ( skin == NULL ) {
		skin = GetSkin();
	}

	pickupSkin = NULL;
	if ( spawnArgs.GetString( "skin_pickup", NULL ) ) {
		pickupSkin = declManager->FindSkin( spawnArgs.GetString( "skin_pickup" ), false );
	}

	transScale = spawnArgs.GetFloat( "bouncescale", "0" );
	transSpin = spawnArgs.GetFloat( "spin", "0" );
	doTrans = ( transSpin == 0.0f && transScale <= 0.0f );

	dropToFloor = false;

	if ( spawnArgs.GetBool( "dropped" ) ) {
		syncPhysics = true;
	}
	else if ( spawnArgs.GetBool( "droptofloor", "1" ) && !spawnArgs.GetBool( "nodrop", "0" ) ) {
		dropToFloor = true;
		physicsObj.DropToFloor();
	}

	BecomeActive( TH_THINK );

	spawned = true;

	spawnOrigin = GetPhysics()->GetOrigin();
	spawnOrigin.z += 1.0f;

	idStr mtrIcon = spawnArgs.GetString( "mtr_simple_icon", "" );

	simpleItem = false;
/*	simpleItem = g_simpleItems.GetBool() && mtrIcon[0];
	if( simpleItem ) {
		memset( &renderEntity, 0, sizeof( renderEntity ) );
		renderEntity.axis		= mat3_identity;
		renderEntity.shaderParms[ SHADERPARM_RED ]				= 1.0f;
		renderEntity.shaderParms[ SHADERPARM_GREEN ]			= 1.0f;
		renderEntity.shaderParms[ SHADERPARM_BLUE ]				= 1.0f;
		renderEntity.shaderParms[ SHADERPARM_ALPHA ]			= 1.0f;
		renderEntity.shaderParms[ SHADERPARM_SPRITE_WIDTH ]		= 32.0f;
		renderEntity.shaderParms[ SHADERPARM_SPRITE_HEIGHT ]	= 32.0f;
		renderEntity.hModel = renderModelManager->FindModel( "_sprite" );
		renderEntity.callback = NULL;
		renderEntity.numJoints = 0;
		renderEntity.joints = NULL;
		renderEntity.customSkin = 0;
		renderEntity.noShadow = true;
		renderEntity.noSelfShadow = true;
		renderEntity.customShader = declManager->FindMaterial( mtrIcon.c_str() );

		renderEntity.referenceShader = 0;
		renderEntity.bounds = renderEntity.hModel->Bounds( &renderEntity );
		SetAxis( mat3_identity );
	}*/

	
	GetPhysics( )->SetClipMask( GetPhysics( )->GetClipMask( ) | CONTENTS_ITEMCLIP );
	pickedUp = false;

	currentEffect	= NULL;

	clientState = TFSTATE_INVISIBLE;

	if ( syncPhysics || dropToFloor )
		BecomeActive( TH_PHYSICS );
	else
		BecomeInactive( TH_PHYSICS );
}

void TFItem::StartEffectState( tfstate_t newState ) {
	if ( currentEffect != NULL ) {
		currentEffect->Stop();
	}
	currentEffect = NULL;

	switch( newState ) {
		case TFSTATE_DISABLED:
			currentEffect = gameLocal.PlayEffect( spawnArgs, "fx_disabled", GetPhysics()->GetOrigin(), mat3_identity, true );
			break;

		case TFSTATE_IDLE:
			currentEffect = gameLocal.PlayEffect( spawnArgs, "fx_idle", GetPhysics()->GetOrigin(), mat3_identity, true );
			break;

		case TFSTATE_ACTIVE:
			currentEffect = gameLocal.PlayEffect( spawnArgs, "fx_active", GetPhysics()->GetOrigin(), mat3_identity, true );
			break;

		case TFSTATE_CARRIED:
			currentEffect = gameLocal.PlayEffect( spawnArgs, "fx_carry", GetPhysics()->GetOrigin(), mat3_identity, true );
			break;
	}

	if ( currentEffect && fl.teamColored ) {
		idVec3 tColor = tfGame.GetTeamColor( team );
		idVec4 c( tColor.x, tColor.y, tColor.z, 1.0f );
		currentEffect->SetColor( c );
	}
}

void TFItem::UpdateEffectState() {
	if ( currentEffect ) {
		currentEffect->SetOrigin( GetPhysics()->GetOrigin() );
	}
}

bool TFItem::ClientStale() {
	idEntity::ClientStale();

	if ( currentEffect ) {
		currentEffect->Stop();
	}
	currentEffect = NULL;
	clientState = TFSTATE_INVISIBLE;
	return false;
}

void TFItem::ClientUnstale() {
	idEntity::ClientUnstale();
	UpdateModelTransform();

	//StartEffectState( clientState );
}

//--------------------------------------------------------------------------
// Called when we are touched by something
//--------------------------------------------------------------------------
void TFItem::Event_Touch( idEntity *other, trace_t *trace ) {
	if ( gameLocal.isClient ) {
		return;						// clients not allowed
	}

	Event_Activate( other );
}

void TFItem::Event_Activate( idEntity* other ) {
	if ( AllowActivate( other ) ) {
		SetState( TFSTATE_ACTIVE, false, true, other );
	}
}



bool TFItem::AllowActivate( idEntity* player ) {
	if ( gameLocal.isClient ) {
		return false;						// clients not allowed
	}

	if ( !player || !player->IsType( idPlayer::GetClassType() ) || static_cast<idPlayer*>(player)->spectating || player->health <= 0 || ( gameLocal.time < ignoreTime && player == ignorePlayer ) ) {
		return false;
	}

	// if we;re disabled or invisible, don't do shit
	if ( GetCurrentState() != TFSTATE_IDLE ) {
		return false;
	}

	return true;
}

//--------------------------------------------------------------------------
// Called whenever our state changes.
//--------------------------------------------------------------------------
void TFItem::OnStateChange( tfstate_t oldState, tfstate_t newState, idEntity* activator ) {
	assert( !gameLocal.isClient );

	if ( !spawned ) {
		return;
	}

	if ( oldState == TFSTATE_INVISIBLE || oldState == TFSTATE_ACTIVE ) {
		Show();
	}

	StartEffectState( newState );

	switch ( newState ) {
		case TFSTATE_ACTIVE: {

			if ( spawnArgs.GetBool( "dropped" ) ) {
				Hide();
				usingSkin = false;
				PostEventMS( &EV_Remove, 1000 );
				break;
			}

			// hide the model, or switch to the pickup skin
			if ( pickupSkin && skin ) {
				SetSkin( pickupSkin );
				usingSkin = true;
				trigger->SetContents ( 0 );
			} else {
				Hide();
				usingSkin = false;
			}
			break;
		}

		case TFSTATE_IDLE: {
			if ( pickupSkin && skin ) {
				SetSkin( skin );
				usingSkin = false;
			}

			// return back to our start position & axis
			//GetPhysics()->SetOrigin( spawnOrigin );
			//GetPhysics()->SetAxis( spawnAxis );

			break;
		}

		case TFSTATE_INVISIBLE: {
			Hide();
			break;
		}
	}

	CancelEvents( &EV_EmpExplode );
}


//--------------------------------------------------------------------------
// Update the trigger position to match our world position
//--------------------------------------------------------------------------
void TFItem::UpdateTrigger ( void ) {
	if ( trigger )
		trigger->Link( this, 0, GetPhysics()->GetOrigin(), mat3_identity );
}


//--------------------------------------------------------------------------
// Called by UpdateModelTransform. Return false if you just want the
// render entity to use the physics axis and origin.
//--------------------------------------------------------------------------
bool TFItem::GetPhysicsToVisualTransform( idVec3 &origin, idMat3 &axis ) {
	if ( ( gameLocal.isServer && !gameLocal.isListenServer ) || !doTrans )
		return false;

	/*if( simpleItem ) {
		if( gameLocal.GetLocalPlayer() && gameLocal.GetLocalPlayer()->GetRenderView() ) {
			if( gameLocal.GetLocalPlayer()->spectating ) {
				idPlayer* spec = (idPlayer*)gameLocal.entities[ gameLocal.GetLocalPlayer()->spectator ];
				if( spec && spec->GetRenderView() ) {
					axis = spec->GetRenderView()->viewaxis;
				}
			} else {
				axis = gameLocal.GetLocalPlayer()->GetRenderView()->viewaxis;	
			}
		}
		origin = idVec3( 0.0f, 0.0f, 32.0f );
		return true;
	}*/

	idAngles ang( 0.0f, ( ( gameLocal.time & 4095 ) * 360.0f / -4096.0f ) * transSpin, 0.0f );
	axis = ang.ToMat3() * GetPhysics()->GetAxis();

	origin.Zero();
	origin += GetPhysics()->GetAxis()[2] * ( idMath::Cos( ( gameLocal.time + entityNumber ) * transScale * 0.005f ) * 8.0f );

	return true;
}



//--------------------------------------------------------------------------
// Check if we hit an item clip
//--------------------------------------------------------------------------
bool TFItem::Collide( const trace_t &collision, const idVec3 &velocity ) {

	//idEntity* lol = gameLocal.entities[ collision.c.entityNum ];
	if ( !gameLocal.isClient && collision.c.contents & CONTENTS_ITEMCLIP /*&& lol && !lol->IsType( TFItem::GetClassType() )*/ ) {
		// if we were dropped, remove ourselves
		if ( spawnArgs.GetBool( "dropped", "0" ) ) {
			PostEventMS( &EV_Remove, 0 );
		}
		else {
			// go idle
			SetState( TFSTATE_IDLE, true, true, NULL );
		}
	}

	return false;
}



//--------------------------------------------------------------------------
// Think
//--------------------------------------------------------------------------
void TFItem::Think( void ) {

	if ( thinkFlags & TH_PHYSICS ) {
		RunPhysics();		
		UpdateTrigger();
		UpdateEffectState();
	}

	if ( g_skipItemShadowsMP.GetBool() ) {
		renderEntity.suppressShadowInViewID = gameLocal.localClientNum + 1;
	} else {
		renderEntity.suppressShadowInViewID = 0;
	}

	if ( q4f_drawItemTriggers.GetBool() ) {
		gameRenderWorld->DebugBounds( colorRed, trigger->GetAbsBounds(), vec3_origin, 1, true );
	}

	if( !(simpleItem && pickedUp) ) {
		UpdateVisuals();
		Present();
	}
}

//--------------------------------------------------------------------------
// Hide
//--------------------------------------------------------------------------
void TFItem::Hide( void ) {
	fl.hidden = true;
	FreeModelDef();
	UpdateVisuals();
//	physicsObj.SetClipMask( 0 );
	if ( trigger )
		trigger->SetContents ( 0 );
}


//--------------------------------------------------------------------------
// Show
//--------------------------------------------------------------------------
void TFItem::Show( void ) {
	fl.hidden = false;
	UpdateVisuals();
	physicsObj.SetClipMask( MASK_SOLID | CONTENTS_ITEMCLIP );
	if ( trigger )
		trigger->SetContents( CONTENTS_TRIGGER );
}

//--------------------------------------------------------------------------
// Client Thinking
//--------------------------------------------------------------------------
void TFItem::ClientPredictionThink( void ) {
	// only think forward because the state is not synced through snapshots
	if ( !gameLocal.isNewFrame ) {
		return;
	}
	Think();
}


//--------------------------------------------------------------------------
// States are synced, TFItem cares about showing pickup skin and flag model
//--------------------------------------------------------------------------
void TFItem::WriteToSnapshot( idBitMsgDelta &msg ) const {
	if ( syncPhysics ) {
		msg.WriteBits( 1,1 );
		physicsObj.WriteToSnapshot( msg );
		WriteBindToSnapshot( msg );
	}
	else {
		msg.WriteBits( 0,1 );
	}

	msg.WriteBits( GetCurrentState(), ASYNC_TFSTATE_BITS );

	msg.WriteBits( usingSkin ? 1 : 0, 1 );
	msg.WriteBits( IsHidden() ? 1 : 0, 1 );
}


//--------------------------------------------------------------------------
// Sync with server
//--------------------------------------------------------------------------
void TFItem::ReadFromSnapshot( const idBitMsgDelta &msg ) {

	if ( msg.ReadBits( 1 ) ) {
		physicsObj.ReadFromSnapshot( msg );
		ReadBindFromSnapshot( msg );
	}

	tfstate_t newState = (tfstate_t)msg.ReadBits( ASYNC_TFSTATE_BITS );

	if ( newState != clientState ) {
		StartEffectState( newState );
		clientState = newState;
	}

	bool nowUsingSkin = msg.ReadBits( 1 ) != 0;
	bool isHidden = msg.ReadBits( 1 ) != 0;

	if ( nowUsingSkin != usingSkin ) {
		if ( nowUsingSkin ) {
			SetSkin( pickupSkin );
		}
		else {
			SetSkin( skin );
		}
	}
	usingSkin = nowUsingSkin;

	if ( isHidden ) {
		if ( !IsHidden() ) {
			Hide();
		}
	}
	else {
		if ( IsHidden() ) {
			Show();
		}
	}
}

//--------------------------------------------------------------------------
// Called when an emp hits us
//--------------------------------------------------------------------------
void TFItem::EmpTouch( const AttackerInfo &attacker, idVec3 &dir, float damageScale ) {
	assert( !gameLocal.isClient );

	if ( GetCurrentState() != TFSTATE_IDLE )
		return;

	const char* empDamageStr = NULL;
	if ( !spawnArgs.GetString( "def_empdamage", "", &empDamageStr ) || !empDamageStr || !empDamageStr[0] )
		return;

	int shells = spawnArgs.GetInt( "give_ammo_shells", "0" );
	int nails = spawnArgs.GetInt( "give_ammo_nails", "0" );
	int rockets = spawnArgs.GetInt( "give_ammo_rockets", "0" );
	int cells = spawnArgs.GetInt( "give_ammo_cells", "0" );

	int damage = 0;

	if ( shells > 0 ) {
		damage += 50 + shells;
	}
	
	if ( nails > 0 ) {
		damage += 40;
	}
	
	if ( rockets > 0 ) {
		damage += 100 + ( rockets * 4 );
	}
	
	if ( cells > 0 ) {
		damage += 100 + ( cells * 3 );
	}

	if ( damage <= 0 )
		return;

	// set up our damage entity
	empDamage.Create( attacker, empDamageStr, damageScale );
	empDamage.SetDir( dir );
	empDamage.SetDamage( damage );

	// make sure we don't get picked up
	SetState( TFSTATE_DISABLED, true, false, NULL );

	int explodeTime = SEC2MS( 0.5f + gameLocal.random.RandomFloat() );
	PostEventMS( &EV_EmpExplode, explodeTime );
}


//--------------------------------------------------------------------------
// Go boom boom
//--------------------------------------------------------------------------
void TFItem::Event_EmpExplode() {

	assert( !gameLocal.isClient );

	PlayDetonateEffect( GetPhysics()->GetOrigin(), GetPhysics()->GetAxis() );	

	// do the damage
	gameLocal.RadiusDamage_TF( GetPhysics()->GetOrigin(), empDamage, this );

	// become idle
	SetState( TFSTATE_IDLE, true, false, NULL );
	SetState( TFSTATE_ACTIVE, true, false, NULL );
}


//--------------------------------------------------------------------------
// Enables pickup
//--------------------------------------------------------------------------
void TFItem::Event_AllowPickup() {
	physicsObj.extraPassEntity = NULL;
	trigger->SetContents( CONTENTS_TRIGGER );
}


















const idEventDef EV_GetNumCarriers		( "getNumCarriers",		 NULL,		'd' );				// return # of carriers
const idEventDef EV_GetCarrierNum		( "getCarrierNum",		 "d",		'E' );				// return carrier entity
const idEventDef EV_GetCarrier			( "getCarrier",			 NULL,		'E' );				// return carrier entity
const idEventDef EV_GetCarrierGrabPos	( "getCarrierGrabPos",	 "d",		'v' );				// return grab position
const idEventDef EV_GetCarrierDropPos	( "getCarrierDropPos",	 "d",		'v' );				// return drop position

CLASS_DECLARATION( TFItem, TFCarryItem )
	EVENT( EV_Touch,			TFItem::Event_Touch )
	EVENT( EV_Activate,			TFCarryItem::Event_Activate )
	EVENT( EV_AllowPickup,		TFItem::Event_AllowPickup )
	EVENT( EV_GetNumCarriers,		TFCarryItem::Event_GetNumCarriers )
	EVENT( EV_GetCarrier,			TFCarryItem::Event_GetCarrier )
	EVENT( EV_GetCarrierNum,		TFCarryItem::Event_GetCarrierNum )
	EVENT( EV_GetCarrierGrabPos,	TFCarryItem::Event_GetCarrierGrabPos )
	EVENT( EV_GetCarrierDropPos,	TFCarryItem::Event_GetCarrierDropPos )
END_CLASS

TFCarryItem::TFCarryItem() {
	showCarry		= false;
	syncPhysics		= true;
	carrier			= NULL;

	//spawnAxis.Identity();
	carriers.Clear();
}

TFCarryItem::~TFCarryItem() {
	if ( carrier.GetEntity() ) {
		carrier.GetEntity()->RemoveTFItem( this );
	}

	gameLocal.carryItems.Remove( this );
}

void TFCarryItem::Spawn() {
	showCarry = spawnArgs.GetBool( "showcarry", "0" );

	//spawnAxis = GetPhysics()->GetAxis();

	gameLocal.carryItems.AddUnique( this );

	lastGrabPos = spawnOrigin;

	fl.bindOrientated = false;
}

//--------------------------------------------------------------------------
// Called whenever our state changes.
//--------------------------------------------------------------------------
void TFCarryItem::OnStateChange( tfstate_t oldState, tfstate_t newState, idEntity* activator ) {
	assert( !gameLocal.isClient );

	if ( !spawned ) {
		return;
	}

	if ( oldState == TFSTATE_INVISIBLE ) {
		Show();
	}

	idVec3 fxOrg = GetPhysics()->GetOrigin();

	idPlayer* myCarrier = NULL;

	if ( oldState == TFSTATE_CARRIED ) {
		Unbind();
		myCarrier = carrier.GetEntity();
		if ( myCarrier ) {
			myCarrier->RemoveTFItem( this );

			idAngles wishAngles = myCarrier->viewAngles;
		
			wishAngles.pitch += ( gameLocal.random.CRandomFloat() * 12.0f );
			wishAngles.yaw += ( gameLocal.random.CRandomFloat() * 8.0f );

			if ( wishAngles.pitch > -25.0f )
				wishAngles.pitch = -25.0f;

			idVec3 forward = wishAngles.ToForward();
			forward *= ( 256.0f + ( gameLocal.random.CRandomFloat() * 64.0f ) );

			// 3j: start inside player so we dont go through walls
			//GetPhysics()->SetOrigin( myCarrier->GetPhysics()->GetAbsBounds().GetCenter() + ( viewForward * 32.0f ) );
			// 3j: start at origin instead of center
			idVec3 org = myCarrier->GetPhysics()->GetOrigin();
			org.z += 5.0f;
			GetPhysics()->SetOrigin( org );
			GetPhysics()->SetLinearVelocity( forward );
			physicsObj.extraPassEntity = myCarrier;

			carrierInfo_t* carierInfo = FindCarrier( myCarrier );
			assert( carierInfo );
			carierInfo->endPos = GetPhysics()->GetAbsBounds().GetCenter();

		}
		carrier = NULL;
		Show();

		// make sure we don't get picked up in the next half second
		trigger->SetContents( 0 );
		PostEventMS( &EV_AllowPickup, 500 );
	}

	switch ( newState ) {
		case TFSTATE_CARRIED: {
			if ( !activator || !activator->IsType( idPlayer::GetClassType() ) ) {
				gameLocal.Error( "TFCarryItem %s was told to go carried with an invalid player '%s'\n", GetName(), activator ? activator->GetName() : "NULL" );
				break;
			}
			myCarrier = static_cast<idPlayer*>(activator);

			if ( !myCarrier->GiveTFItem( this ) ) {
				gameLocal.Warning( "Player %s would not accept item '%s'.", myCarrier->GetName(), GetName() );
				SetState( TFSTATE_IDLE, true, false, NULL );
				break;
			}

			// check carrier list
			carrierInfo_t* carierInfo = FindCarrier( myCarrier );
			if ( !carierInfo ) {
				carierInfo = &(carriers.Alloc());
				carierInfo->carrier = myCarrier;
				carierInfo->startPos = GetPhysics()->GetAbsBounds().GetCenter();
				carierInfo->endPos = carierInfo->startPos;
			}

			carrier = myCarrier;

			myCarrier->ClearDisguise();

			if ( showCarry ) {
				physicsObj.SetClipMask( 0 );
				trigger->SetContents( 0 );

				idVec3 backview = -myCarrier->viewAngles.ToForward();
				idVec3 norm = myCarrier->GetPhysics()->GetGravityNormal();
				backview -= ( backview * norm ) * norm;
				backview = ( backview.ToNormal() * (18.0f + gameLocal.random.CRandomFloat() * 8.0f ) );
				fxOrg = myCarrier->GetPhysics()->GetOrigin() + backview;
				physicsObj.SetOrigin( fxOrg );
				Bind( myCarrier, false );
			}
			else {
				Hide();
			}

			lastGrabPos = GetPhysics()->GetOrigin();

			break;
		}

		case TFSTATE_IDLE: {

			// return back to our start position & axis
			physicsObj.SetLinearVelocity( vec3_zero );
			physicsObj.SetOrigin( spawnOrigin + physicsObj.GetGravityNormal() * -8.0f);
			//physicsObj.SetAxis( spawnAxis );
			if ( dropToFloor ) {
				physicsObj.DropToFloor();
			}
			carriers.Clear();

			break;
		}

		case TFSTATE_INVISIBLE: {
			Hide();
			break;
		}
	}

	StartEffectState( newState );
}

bool TFCarryItem::AllowActivate( idEntity* player ) {
	if ( gameLocal.isClient ) {
		return false;						// clients not allowed
	}

	if ( !player || !player->IsType( idPlayer::GetClassType() ) || static_cast<idPlayer*>(player)->spectating || player->health <= 0 || ( gameLocal.time < ignoreTime && player == ignorePlayer ) ) {
		return false;
	}

	// if we;re disabled or invisible, don't do shit
	if ( GetCurrentState() != TFSTATE_IDLE && GetCurrentState() != TFSTATE_ACTIVE ) {
		return false;
	}

	return true;
}

void TFCarryItem::Event_Activate( idEntity* activator ) {
	
	if ( AllowActivate( activator ) ) {
		SetState( TFSTATE_CARRIED, false, true, activator );
	}
}

void TFCarryItem::Event_GetSpawnPos			( void )	{ idThread::ReturnVector( spawnOrigin ); }
void TFCarryItem::Event_GetNumCarriers		( void )	{ idThread::ReturnInt( GetNumCarriers() ); }
void TFCarryItem::Event_GetCarrier			( void )	{ idThread::ReturnEntity( carrier.GetEntity() ); }
void TFCarryItem::Event_GetCarrierNum		( int num )	{ idThread::ReturnEntity( GetCarrierNum( num ) ); }
void TFCarryItem::Event_GetCarrierGrabPos( int num )	{ idThread::ReturnVector( GetCarrierGrabPos( num ) ); }
void TFCarryItem::Event_GetCarrierDropPos( int num )	{ idThread::ReturnVector( GetCarrierDropPos( num ) ); }

//--------------------------------------------------------------------------
// Called by UpdateModelTransform. Return false if you just want the
// render entity to use the physics axis and origin.
//--------------------------------------------------------------------------
bool TFCarryItem::GetPhysicsToVisualTransform( idVec3 &origin, idMat3 &axis ) {
	/*if( simpleItem ) {
		if( gameLocal.GetLocalPlayer() && gameLocal.GetLocalPlayer()->GetRenderView() ) {
			if( gameLocal.GetLocalPlayer()->spectating ) {
				idPlayer* spec = (idPlayer*)gameLocal.entities[ gameLocal.GetLocalPlayer()->spectator ];
				if( spec && spec->GetRenderView() ) {
					axis = spec->GetRenderView()->viewaxis;
				}
			} else {
				axis = gameLocal.GetLocalPlayer()->GetRenderView()->viewaxis;	
			}
		}
		origin = idVec3( 0.0f, 0.0f, 32.0f );
		return true;
	}*/

	return false;
}