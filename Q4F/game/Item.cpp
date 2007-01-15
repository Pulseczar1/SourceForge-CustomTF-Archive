//
//// bdube: note that this file is no longer merged with Doom3 updates
////
//// MERGE_DATE 09/30/2004
//
#include "../idlib/precompiled.h"
#pragma hdrstop
//
//#include "Game_local.h"
//
//
///*
//===============================================================================
//
//  idItem
//
//===============================================================================
//*/
//
//const idEventDef EV_DropToFloor( "<dropToFloor>" );
//const idEventDef EV_RespawnItem( "respawn" );
//const idEventDef EV_RespawnFx( "<respawnFx>" );
//const idEventDef EV_GetPlayerPos( "<getplayerpos>" );
//const idEventDef EV_HideObjective( "<hideobjective>", "e" );
//const idEventDef EV_CamShot( "<camshot>" );
//
//// abahr:
//const idEventDef EV_SetGravity( "<setGravity>" );
//
//
//CLASS_DECLARATION( idEntity, idItem )
//	EVENT( EV_DropToFloor,		idItem::Event_DropToFloor )
//	EVENT( EV_Touch,			idItem::Event_Touch )
//	EVENT( EV_Activate,			idItem::Event_Trigger )
//	EVENT( EV_RespawnItem,		idItem::Event_Respawn )
//	EVENT( EV_RespawnFx,		idItem::Event_RespawnFx )
//
//// abahr
//	EVENT( EV_SetGravity,		idItem::Event_SetGravity )
//
//END_CLASS
//
//
///*
//================
//idItem::idItem
//================
//*/
//idItem::idItem() {
//	spin = false;
//	inView = false;
//	skin = NULL;
//	pickupSkin = NULL;
//	inViewTime = 0;
//	lastCycle = 0;
//	lastRenderViewTime = -1;
//	itemShellHandle = -1;
//	shellMaterial = NULL;
//	orgOrigin.Zero();
//	canPickUp = true;
//	fl.networkSync = true;
//	trigger = NULL;
//	syncPhysics = false;
//	srvReady = -1;
//	clReady = -1;
//	effectIdle = NULL;
//	itemPVSArea = 0;
//
//	// <q4f> 
//
//	empExplodeTime = -1;
//	owner = NULL;
//	spawnTime = gameLocal.time;
//
//	// </q4f>
//}
//
///*
//================
//idItem::~idItem
//================
//*/
//idItem::~idItem() {
//	// remove the highlight shell
//	if ( itemShellHandle != -1 ) {
//		gameRenderWorld->FreeEntityDef( itemShellHandle );
//	}
//	if ( trigger ) {
//		delete trigger;
//	}
//	
//	SetPhysics( NULL );
//}
//
///*
//================
//idItem::Save
//================
//*/
//void idItem::Save( idSaveGame *savefile ) const {
//   	savefile->WriteClipModel( trigger );
//	savefile->WriteBool( spin );
//
//	savefile->WriteSkin( skin );
//	savefile->WriteSkin( pickupSkin );
//
//	savefile->WriteVec3( orgOrigin );
//
//	savefile->WriteBool( pulse );
//	savefile->WriteBool( canPickUp );
//
//	savefile->WriteStaticObject( physicsObj );
//
////	savefile->WriteInt(itemShellHandle);	// cnicholson: Set at end of Restore, do not save
//	savefile->WriteMaterial( shellMaterial );
//
//	savefile->WriteBool( inView );
//	savefile->WriteInt( inViewTime );
//	savefile->WriteInt( lastCycle );
//	savefile->WriteInt( lastRenderViewTime );
//}
//
///*
//================
//idItem::Restore
//================
//*/
//void idItem::Restore( idRestoreGame *savefile ) {
//	savefile->ReadClipModel( trigger );
//	savefile->ReadBool( spin );
//
//	savefile->ReadSkin( skin );
//	savefile->ReadSkin( pickupSkin );
//
//	savefile->ReadVec3( orgOrigin );
//
//	savefile->ReadBool( pulse );
//	savefile->ReadBool( canPickUp );
//
//	savefile->ReadStaticObject ( physicsObj );
//
////	savefile->ReadInt(itemShellHandle);	// cnicholson: Set at end of function, do not restore
//	savefile->ReadMaterial( shellMaterial );
//
//	savefile->ReadBool( inView );
//	savefile->ReadInt( inViewTime );
//	savefile->ReadInt( lastCycle );
//	savefile->ReadInt( lastRenderViewTime );
//
//	RestorePhysics( &physicsObj );
//	
//	physicsObj.SetSelf( this );
//	
//	itemShellHandle = -1;
//}
//
///*
//================
//idItem::UpdateRenderEntity
//================
//*/
//bool idItem::UpdateRenderEntity( renderEntity_s *renderEntity, const renderView_t *renderView ) const {
//
//	if ( lastRenderViewTime == renderView->time ) {
//		return false;
//	}
//
//	lastRenderViewTime = renderView->time;
//
//	// check for glow highlighting if near the center of the view
//	idVec3 dir = renderEntity->origin - renderView->vieworg;
//	dir.Normalize();
//	float d = dir * renderView->viewaxis[0];
//
//	// two second pulse cycle
//	float cycle = ( renderView->time - inViewTime ) / 2000.0f;
//
//	if ( d > 0.94f ) {
//		if ( !inView ) {
//			inView = true;
//			if ( cycle > lastCycle ) {
//				// restart at the beginning
//				inViewTime = renderView->time;
//				cycle = 0.0f;
//			}
//		}
//	} else {
//		if ( inView ) {
//			inView = false;
//			lastCycle = ceil( cycle );
//		}
//	}
//
//	// fade down after the last pulse finishes 
//	if ( !inView && cycle > lastCycle ) {
//		renderEntity->shaderParms[4] = 0.0f;
//	} else {
//		// pulse up in 1/4 second
//		cycle -= (int)cycle;
//		if ( cycle < 0.1f ) {
//			renderEntity->shaderParms[4] = cycle * 10.0f;
//		} else if ( cycle < 0.2f ) {
//			renderEntity->shaderParms[4] = 1.0f;
//		} else if ( cycle < 0.3f ) {
//			renderEntity->shaderParms[4] = 1.0f - ( cycle - 0.2f ) * 10.0f;
//		} else {
//			// stay off between pulses
//			renderEntity->shaderParms[4] = 0.0f;
//		}
//	}
//
//	// update every single time this is in view
//	return true;
//}
//
///*
//================
//idItem::UpdateTrigger
//================
//*/
//void idItem::UpdateTrigger ( void ) {
//	// update trigger position
//
//
//	trigger->Link( this, 0, GetPhysics()->GetOrigin(), mat3_identity );
//}
//
///*
//================
//idItem::ModelCallback
//================
//*/
//bool idItem::ModelCallback( renderEntity_t *renderEntity, const renderView_t *renderView ) {
//	const idItem *ent;
//
//	// this may be triggered by a model trace or other non-view related source
//	if ( !renderView ) {
//		return false;
//	}
//
//	ent = static_cast<idItem *>(gameLocal.entities[ renderEntity->entityNum ]);
//	if ( !ent ) {
//		gameLocal.Error( "idItem::ModelCallback: callback with NULL game entity" );
//	}
//
//	return ent->UpdateRenderEntity( renderEntity, renderView );
//}
//
//
///*
//================
//idItem::GetPhysicsToVisualTransform
//================
//*/
//bool idItem::GetPhysicsToVisualTransform( idVec3 &origin, idMat3 &axis ) {
//	if( !spin || (gameLocal.isServer && !gameLocal.isListenServer) ) {
//		return false;
//	}
//	
//	idAngles ang;
//	ang.pitch = ang.roll = 0.0f;
//	ang.yaw = ( gameLocal.time & 4095 ) * 360.0f / -4096.0f;
//	axis = ang.ToMat3() * GetPhysics()->GetAxis();
//
//	float scale = 0.005f + entityNumber * 0.00001f;
//	origin.Zero();
//
//	origin += GetPhysics()->GetAxis()[2] * (4.0f + idMath::Cos( ( gameLocal.time + 1000 ) * scale ) * 4.0f);
//
//	return true;
//}
//
//
//// mekberg: added
///*
//================
//idItem::Collide
//================
//*/
//bool idItem::Collide( const trace_t &collision, const idVec3 &velocity ) {
//	if ( gameLocal.isMultiplayer && collision.c.contents & CONTENTS_ITEMCLIP ) {
//		PostEventMS( &EV_Remove, 0 );
//	}
//	return false;
//}
//
//
///*
//================
//idItem::Think
//================
//*/
//void idItem::Think( void ) {
//	if ( thinkFlags & TH_PHYSICS ) {
//		RunPhysics();		
//		UpdateTrigger();
//	}
//
//	if ( gameLocal.IsMultiplayer() && g_skipItemShadowsMP.GetBool() ) {
//		renderEntity.suppressShadowInViewID = gameLocal.localClientNum + 1;
//	} else {
//		renderEntity.suppressShadowInViewID = 0;
//	}
//
//	if ( !gameLocal.isClient ) {
//		if ( empExplodeTime >= 0 && gameLocal.time > empExplodeTime ) {
//			EmpExplode();
//		}
//	}
//
//	UpdateVisuals();
//	Present();
//}
//
///*
//================
//idItem::Present
//================
//*/
//void idItem::Present( void ) {
//	idEntity::Present();
//
//	if ( !fl.hidden && pulse ) {
//		// also add a highlight shell model
//		renderEntity_t	shell;
//
//		shell = renderEntity;
//
//		// we will mess with shader parms when the item is in view
//		// to give the "item pulse" effect
//		shell.callback = idItem::ModelCallback;
//		shell.entityNum = entityNumber;
//		shell.customShader = shellMaterial;
//		if ( itemShellHandle == -1 ) {
//			itemShellHandle = gameRenderWorld->AddEntityDef( &shell );
//		} else {
//			gameRenderWorld->UpdateEntityDef( itemShellHandle, &shell );
//		}
//	}
//}
//
///*
//================
//idItem::Spawn
//================
//*/
//void idItem::Spawn( void ) {
//	idStr		giveTo;
//	idEntity *	ent;
//	idVec3		vSize;
//	idBounds	bounds(vec3_origin);
//
//	// check for triggerbounds, which allows for non-square triggers (useful for, say, a CTF flag)
//	if ( spawnArgs.GetVector( "triggerbounds", "16 16 16", vSize )) {
//		bounds.AddPoint(idVec3( vSize.x*0.5f,  vSize.y*0.5f, 0.0f));
//		bounds.AddPoint(idVec3(-vSize.x*0.5f, -vSize.y*0.5f, vSize.z));
//	}
//	else {
//		// create a square trigger for item pickup
//		float tsize;
//		spawnArgs.GetFloat( "triggersize", "16.0", tsize );
//		bounds.ExpandSelf( tsize );
//	}
//
//
//// mwhitlock: Dynamic memory consolidation
//	RV_PUSH_HEAP_MEM(this);
//
//	trigger = new idClipModel( idTraceModel( bounds ));
//
//// mwhitlock: Dynamic memory consolidation
//	RV_POP_HEAP();
//
//
//
//	trigger->Link( this, 0, GetPhysics()->GetOrigin(), GetPhysics()->GetAxis() );
//
//
//	physicsObj.SetSelf ( this );
//
//// mwhitlock: Dynamic memory consolidation
//	RV_PUSH_HEAP_MEM(this);
//
//
//	physicsObj.SetClipModel( new idClipModel( GetPhysics()->GetClipModel() ), 1.0f );
//
//
//// mwhitlock: Dynamic memory consolidation
//	RV_POP_HEAP();
//
//	physicsObj.SetOrigin( GetPhysics()->GetOrigin() );
//	physicsObj.SetAxis( GetPhysics()->GetAxis() );
//	physicsObj.SetGravity( gameLocal.GetGravity() );
//	physicsObj.SetContents( 0 );
//	physicsObj.SetClipMask( MASK_SOLID );
//	physicsObj.SetFriction( 0.0f, 0.0f, 6.0f );
//	SetPhysics( &physicsObj );
//
//	if ( spawnArgs.GetBool( "start_off" ) ) {
//		trigger->SetContents( 0 );
//		Hide();
//	} else {
//		trigger->SetContents( CONTENTS_TRIGGER );
//	}
//
//	giveTo = spawnArgs.GetString( "owner" );
//	if ( giveTo.Length() ) {
//		ent = gameLocal.FindEntity( giveTo );
//		if ( !ent ) {
//			gameLocal.Error( "Item couldn't find owner '%s'", giveTo.c_str() );
//		}
//		PostEventMS( &EV_Touch, 0, ent, NULL );
//	}
//
//	if ( spawnArgs.GetBool( "spin" ) || gameLocal.isMultiplayer ) {
//		spin = true;
//		BecomeActive( TH_THINK );
//	}
//
//	if ( spawnArgs.GetString( "fx_idle" ) ) {
//		effectIdle = PlayEffect( "fx_idle", GetPhysics()->GetOrigin(), GetPhysics()->GetAxis(), true );
//	}
//
//	// pulse ( and therefore itemShellHandle ) was taken out and shot. do not sync
//	//pulse = !spawnArgs.GetBool( "nopulse" );
//	pulse = false;
//	orgOrigin = GetPhysics()->GetOrigin();
//
//	canPickUp = !( spawnArgs.GetBool( "triggerFirst" ) || spawnArgs.GetBool( "no_touch" ) );
//
//	inViewTime = -1000;
//	lastCycle = -1;
//	itemShellHandle = -1;
//
//// abahr: move texture to def file for precaching
//	shellMaterial = declManager->FindMaterial( spawnArgs.GetString("mtr_highlight", "_default") );
//	PostEventMS( &EV_SetGravity, 0 );
//
//	if ( spawnArgs.GetString( "skin", NULL ) ) {
//		skin = declManager->FindSkin( spawnArgs.GetString( "skin" ), false );
//		if( skin ) {
//			SetSkin( skin );
//			srvReady = 1;
//		}
//	} else {
//		skin = NULL;
//	}
//
//	if ( spawnArgs.GetString( "skin_pickup", NULL ) ) {
//		pickupSkin = declManager->FindSkin( spawnArgs.GetString( "skin_pickup" ), false );
//	} else {
//		pickupSkin = NULL;
//	}
//
//	syncPhysics = spawnArgs.GetBool( "net_syncPhysics", "0" );
//
//	if ( srvReady == -1 ) {
//		srvReady = IsHidden() ? 0 : 1;
//	}
//
//
//// mekberg: added for removing pickups in mp in pits
//	if ( gameLocal.isMultiplayer ) {
//		GetPhysics( )->SetClipMask( GetPhysics( )->GetClipMask( ) | CONTENTS_ITEMCLIP );
//	}
//
//
//	if( gameLocal.isMultiplayer ) {
//		itemPVSArea = gameLocal.pvs.GetPVSArea( GetPhysics()->GetOrigin() );
//	} else {
//		itemPVSArea = 0;
//	}
//}
//
///*
//================
//idItem::Event_SetGravity
//================
//*/
//void idItem::Event_SetGravity() {
//	// If the item isnt a dropped item then see if it should settle itself
//	// to the floor or not
//	if ( !spawnArgs.GetBool( "dropped" ) ) {
//		if ( spawnArgs.GetBool( "nodrop" ) ) {
//			physicsObj.PutToRest();
//		} else {
//	 		PostEventMS( &EV_DropToFloor, 0 );
//		}
//	}
//}
//
//
///*
//================
//idItem::GetAttributes
//================
//*/
//void idItem::GetAttributes( idDict &attributes ) {
//	int					i;
//	const idKeyValue	*arg;
//
//	for( i = 0; i < spawnArgs.GetNumKeyVals(); i++ ) {
//		arg = spawnArgs.GetKeyVal( i );
//		if ( arg->GetKey().Left( 4 ) == "inv_" ) {
//			attributes.Set( arg->GetKey().Right( arg->GetKey().Length() - 4 ), arg->GetValue() );
//		}
//	}
//}
//
///*
//================
//idItem::GiveToPlayer
//================
//*/
//bool idItem::GiveToPlayer( idPlayer *player ) {
//	if ( player == NULL ) {
//		return false;
//	}
//
//	if ( spawnArgs.GetBool( "inv_carry" ) ) {
//		return player->GiveInventoryItem( &spawnArgs );
//	} 
//	
//	return player->GiveItem( this );
//}
//
///*
//===============
//idItem::SendPickupMsg
//===============
//*/
//void idItem::SendPickupMsg( int clientNum ) {
//	idBitMsg	msg;
//	byte		msgBuf[MAX_GAME_MESSAGE_SIZE];
//
//	msg.Init( msgBuf, sizeof( msgBuf ) );
//	msg.WriteByte( GAME_UNRELIABLE_MESSAGE_EVENT );
//	msg.WriteBits( gameLocal.GetSpawnId( this ), 32 );
//	msg.WriteByte( EVENT_PICKUP );
//	msg.WriteByte( clientNum );
//
//	// send as unreliable to client picking up the item, so it can play HUD things
//	for( int i = 0; i < MAX_CLIENTS; i++ ) {
//		if( gameLocal.entities[ i ] ) {
//			gameLocal.SendUnreliableMessagePVS( msg, itemPVSArea );	
//		}
//	}
//}
//
///*
//================
//idItem::Pickup
//================
//*/
//bool idItem::Pickup( idPlayer *player ) {
//	assert( !gameLocal.isClient );
//	
//	if ( !GiveToPlayer( player ) ) {
//		return false;
//	}
//
//	if ( gameLocal.isServer ) {
//		SendPickupMsg( player->entityNumber );
//	}
//
//	// Check for global acquire sounds in multiplayer
// 	if ( gameLocal.isMultiplayer && spawnArgs.GetBool( "globalAcquireSound" ) ) {
//		gameLocal.mpGame.PlayGlobalItemAcquireSound( entityDefNumber );
//	} else {
//		StartSound( "snd_acquire", SND_CHANNEL_ITEM, 0, false, NULL );
//	}
//		
//	// trigger our targets
//	ActivateTargets( player );
//
//	//dropped weapon?
//	bool dropped = spawnArgs.GetBool( "dropped" );
//
//	//if a placed item and si_weaponStay is on and we're a weapon, don't remove and respawn
//	if ( gameLocal.IsMultiplayer() ) {
//		if ( !dropped )	{
//			if ( spawnArgs.FindKey( "weaponclass" ) ) { 
//				if ( gameLocal.serverInfo.GetBool( "si_weaponStay" ) ) {
//					return true;
//				}
//			}
//		}
//	}
//
//	Deactivate();
//	return true;
//}
//
///*
//================
//idItem::Hide
//================
//*/
//void idItem::Hide( void ) {
//	srvReady = 0;
//	idEntity::Hide( );	
//	trigger->SetContents ( 0 );
//}
//
///*
//================
//idItem::Show
//================
//*/
//void idItem::Show( void ) {
//	srvReady = 1;
//	idEntity::Show( );
//	trigger->SetContents( CONTENTS_TRIGGER );
//}
//
///*
//================
//idItem::ClientStale
//================
//*/
//bool idItem::ClientStale( void ) {
//	idEntity::ClientStale();
//
//	StopEffect( "fx_idle" );
//	return false;
//}
//
///*
//================
//idItem::ClientUnstale
//================
//*/
//void idItem::ClientUnstale( void ) {
//	idEntity::ClientUnstale();
//
//	UpdateModelTransform();
//	if ( spawnArgs.GetString( "fx_idle" ) ) {
//		PlayEffect( "fx_idle", GetPhysics()->GetOrigin(), GetPhysics()->GetAxis(), true );
//	}
//}
//
///*
//================
//idItem::ClientPredictionThink
//================
//*/
//void idItem::ClientPredictionThink( void ) {
//	// only think forward because the state is not synced through snapshots
//	if ( !gameLocal.isNewFrame ) {
//		return;
//	}
//	Think();
//}
//
///*
//================
//idItem::WriteFromSnapshot
//================
//*/
//void idItem::WriteToSnapshot( idBitMsgDelta &msg ) const {
//	if ( syncPhysics ) {
//		physicsObj.WriteToSnapshot( msg );
//	}
//	assert( srvReady != -1 );
//	msg.WriteBits( ( srvReady == 1 ), 1 );
//}
//
///*
//================
//idItem::ReadFromSnapshot
//================
//*/
//void idItem::ReadFromSnapshot( const idBitMsgDelta &msg ) {
//	if ( syncPhysics ) {
//		physicsObj.ReadFromSnapshot( msg );
//	}
//	int newReady = ( msg.ReadBits( 1 ) != 0 );
//	idVec3 resetOrigin( 0, 0, 0 );
//	// client spawns the ent with ready == -1 so the state set happens at least once
//	if ( newReady != clReady ) {
//		if ( newReady ) {
//			if ( pickupSkin ) {
//				SetSkin( skin );
//			} else {
//				Show();
//			}
//
//			if ( effectIdle.GetEntity( ) ) {
//				UpdateModelTransform();
//				effectIdle->SetOrigin( resetOrigin );
//			} else if ( spawnArgs.GetString( "fx_idle" ) ) {
//				UpdateModelTransform();
//				effectIdle = PlayEffect( "fx_idle", GetPhysics()->GetOrigin(), GetPhysics()->GetAxis(), true );
//			}
//		} else {
//			if ( pickupSkin ) {
//				SetSkin( pickupSkin );
//			} else {
//				Hide();
//			}
//			StopEffect( "fx_idle" );
//			effectIdle = NULL;
//		}
//	}
//	clReady = newReady;
//}
//
///*
//================
//idItem::Event_Pickup
//================
//*/
//void idItem::Event_Pickup( int clientNum ) {
//	idPlayer *player;
//
//	assert( gameLocal.isClient );
//	
//	// play pickup sound
//	if ( !spawnArgs.GetBool( "globalAcquireSound" ) ) {
//		StartSound( "snd_acquire", SND_CHANNEL_ITEM, 0, false, NULL );
//	}
//
//	if( clientNum == gameLocal.localClientNum ) {
//		player = (idPlayer*)gameLocal.entities[ clientNum ];
//		if ( player ) {
//			player->GiveItem( this );
//		}
//	}
//}
//
///*
//================
//idItem::ClientReceiveEvent
//================
//*/
//bool idItem::ClientReceiveEvent( int event, int time, const idBitMsg &msg ) {
//	switch( event ) {
//		case EVENT_PICKUP: {
//			int clientNum = msg.ReadByte();
//			if( clientNum >= 0 && clientNum < MAX_CLIENTS ) {
//				Event_Pickup( clientNum );
//			}
//			return true;
//		}
//		case EVENT_RESPAWNFX: {
//			Event_RespawnFx();
//			return true;
//		}
//		// <q4f> 
//
//		case EVENT_EMPEXPLODE: {
//			EmpExplode();
//			return true;
//		}
//
//		 // </q4f>
//		default: {
//			return idEntity::ClientReceiveEvent( event, time, msg );
//		}
//	}
////unreachable
////	return false;
//}
//
///*
//================
//idItem::Event_DropToFloor
//================
//*/
//void idItem::Event_DropToFloor( void ) {
// 	// don't drop the floor if bound to another entity
// 	if ( GetBindMaster() != NULL && GetBindMaster() != this ) {
// 		return;
// 	}
// 	
// 	physicsObj.DropToFloor( );
//}
//
///*
//================
//idItem::Event_Touch
//================
//*/
//void idItem::Event_Touch( idEntity *other, trace_t *trace ) {
//
//// jnewquist: Use accessor for static class type 
//	if ( !other->IsType( idPlayer::GetClassType() ) ) {
//
//		return;
//	}
//
//	if ( !canPickUp ) {
//		return;
//	}
//
//	Pickup( static_cast<idPlayer *>(other) );
//}
//
///*
//================
//idItem::Event_Trigger
//================
//*/
//void idItem::Event_Trigger( idEntity *activator ) {
//	if ( !canPickUp && spawnArgs.GetBool( "triggerFirst" ) ) {
//		canPickUp = true;
//		return;
//	}
//
//
//// jnewquist: Use accessor for static class type 
//	if ( activator && activator->IsType( idPlayer::GetClassType() ) ) {
//
//		Pickup( static_cast<idPlayer *>( activator ) );
//	}
//}
//
///*
//================
//idItem::Event_Respawn
//================
//*/
//void idItem::Event_Respawn( void ) {
//
//	if ( pickupSkin ) {
//		SetSkin( skin );
//		srvReady = true;
//	} else {
//		BecomeActive( TH_THINK );	
//		Show();
//	}
//
//	inViewTime = -1000;
//	lastCycle = -1;
//	trigger->SetContents ( CONTENTS_TRIGGER );
//	SetOrigin( orgOrigin );
//	StartSound( "snd_respawn", SND_CHANNEL_ITEM, 0, false, NULL );
//	PostEventMS( &EV_SetGravity, 0 );
//	CancelEvents( &EV_RespawnItem ); // don't double respawn
//
//	if ( spawnArgs.GetString( "fx_idle" ) ) {
//		PlayEffect( "fx_idle", GetPhysics()->GetOrigin(), GetPhysics()->GetAxis(), true );
//	}
//
//	// <q4f> 
//
//	canPickUp = true;
//
//	// </q4f>
//}
//
///*
//================
//idItem::Event_RespawnFx
//================
//*/
//void idItem::Event_RespawnFx( void ) {
//	idBitMsg	msg;
//	byte		msgBuf[MAX_GAME_MESSAGE_SIZE];
//
//	if ( gameLocal.isServer ) {
//		msg.Init( msgBuf, sizeof( msgBuf ) );
//		msg.WriteByte( GAME_UNRELIABLE_MESSAGE_EVENT );
//		msg.WriteBits( gameLocal.GetSpawnId( this ), 32 );
//		msg.WriteByte( EVENT_RESPAWNFX );
//		// send unreliable PVS-sensitive
//		gameLocal.SendUnreliableMessagePVS( msg, gameLocal.pvs.GetPVSArea( GetPhysics()->GetOrigin() ) );
//	}
//
//	gameLocal.PlayEffect( spawnArgs, "fx_respawn", GetPhysics()->GetOrigin(), idVec3(0,0,1).ToMat3(), false, vec3_origin );
//}
//
///*
//===============================================================================
//
//  idItemPowerup
//
//===============================================================================
//*/
//
///*
//===============
//idItemPowerup
//===============
//*/
//
//CLASS_DECLARATION( idItem, idItemPowerup )
//END_CLASS
//
///*
//================
//idItemPowerup::idItemPowerup
//================
//*/
//idItemPowerup::idItemPowerup() {
//	time = 0;
//	type = 0;
//	droppedTime = 0;
//	unique = false;
//}
//
///*
//================
//idItemPowerup::Save
//================
//*/
//void idItemPowerup::Save( idSaveGame *savefile ) const {
//	savefile->WriteInt( time );
//	savefile->WriteInt( type );
//	savefile->WriteInt( droppedTime );	// cnicholson: Added unsaved var
//}
//
///*
//================
//idItemPowerup::Restore
//================
//*/
//void idItemPowerup::Restore( idRestoreGame *savefile ) {
//	savefile->ReadInt( time );
//	savefile->ReadInt( type );
//	savefile->ReadInt( droppedTime );	// cnicholson: Added unrestored var
//}
//
///*
//================
//idItemPowerup::Spawn
//================
//*/
//void idItemPowerup::Spawn( void ) {
//	time = SEC2MS( spawnArgs.GetInt( "time", "30" ) );
//	// SEC2MS screws up when we want -1 time (no expiration)
//	if( spawnArgs.GetInt( "time" ) == -1 ) {
//		time = -1;
//	}
//
//	type = spawnArgs.GetInt( "type", "0" );
//	
//	// If the powerup was dropped then make it dissapear using its remaining time.
//	if ( spawnArgs.GetBool( "dropped" ) ) {
//		droppedTime = gameLocal.time + time;
//		PostEventMS( &EV_Remove, time );
//	}
//
//	// unique powerpus won't respawn while a player has them
//	unique = spawnArgs.GetBool( "unique", "0" );
//	if( unique ) {
//		spawnArgs.SetBool( "no_respawn", true );
//	}
//
//	/*if ( !idStr::Icmp( spawnArgs.GetString( "team" ), "strogg" ) ) {
//		team = TEAM_STROGG;
//	} else if( !idStr::Icmp( spawnArgs.GetString( "team" ), "marine" ) ) {
//		team = TEAM_MARINE;
//	} else {
//		team = -1;
//	}*/
//}
//
///*
//================
//idItemPowerup::GiveToPlayer
//================
//*/
//bool idItemPowerup::GiveToPlayer( idPlayer *player ) {
//	if ( !player || player->spectating ) {
//		return false;
//	}
//	
//	// only one arena CTF powerup at a time
//	if( type >= POWERUP_AMMOREGEN && type <= POWERUP_SCOUT ) {
//		if( (player->inventory.powerups & ARENA_POWERUP_MASK) != 0 ) {
//			return false;
//		} 
//	}
//
//	// in flavours of arena CTF (or are idItemPowerups only used in Arena? or even, are idItemPowerups MP only?), 
//	//	ensure that items with a team can only be picked up by members of that team
//	if ( gameLocal.IsMultiplayer() && gameLocal.IsTeamGame() && team >= 0 ) {
//		if( team != player->team ) {
//			return false;
//		}
//	}
//
//	if ( droppedTime > 0 ) {
//		player->GivePowerUp( type, droppedTime - gameLocal.time );
//	} else {
//		player->GivePowerUp( type, time );
//	}
//
//	// also call idItem::GiveToPlayer so any inv_* keywords get applied
//	idItem::GiveToPlayer( player );
//
//	return true;
//}
//
///*
//================
//idItemPowerup::Think
//================
//*/
//void idItemPowerup::Think( void ) {
//	int i;
//
//	// idItem::Think() only needs to be called if we're spawned in
//	if( !IsHidden() || (pickupSkin && GetSkin() != pickupSkin ) ) {
//		// only get here if spawned in
//		idItem::Think();
//		return;
//	}
//
//	if( !unique ) {
//		// non-unique despawned powerups don't need to think
//		return;
//	}
//
//	for( i = 0; i < gameLocal.numClients; i++ ) {
//		idPlayer* p = (idPlayer*)gameLocal.entities[ i ];
//		if( p == NULL ) {
//			continue;
//		}
//
//		// only spawn back in if noone on your team has the powerup
//		if( p->PowerUpActive( type ) && p->team == team ) {
//			break;
//		}
//	}
//
//	if( i >= gameLocal.numClients ) {
//		PostEventMS( &EV_RespawnItem, 0 );
//	}
//}
//
///*
//================
//idItemPowerup::Pickup
//================
//*/
//bool idItemPowerup::Pickup( idPlayer* player ) {
//	// regular pickup routine, but unique items need to think to know when to respawn
//	bool pickup;
//	
//	pickup = idItem::Pickup( player );
//	if( unique ) {
//		BecomeActive( TH_THINK );
//	}
//
//	return pickup;
//}
//
///*
//===============================================================================
//
//  idObjective
//
//===============================================================================
//*/
//
//CLASS_DECLARATION( idItem, idObjective )
//	EVENT( EV_Activate,			idObjective::Event_Trigger )
//	EVENT( EV_HideObjective,	idObjective::Event_HideObjective )
//	EVENT( EV_GetPlayerPos,		idObjective::Event_GetPlayerPos )
// 	EVENT( EV_CamShot,			idObjective::Event_CamShot )
//END_CLASS
//
///*
//================
//idObjective::idObjective
//================
//*/
//idObjective::idObjective() {
//	playerPos.Zero();
//
//
//// mekberg: store triggered time for timed removal.
//	triggerTime = 0;
//
//}
//
///*
//================
//idObjective::Save
//================
//*/
//void idObjective::Save( idSaveGame *savefile ) const {
//	savefile->WriteVec3( playerPos );
//}
//
///*
//================
//idObjective::Restore
//================
//*/
//void idObjective::Restore( idRestoreGame *savefile ) {
//	savefile->ReadVec3( playerPos );
//
// 	PostEventMS( &EV_CamShot, 250 );
//}
//
///*
//================
//idObjective::Spawn
//================
//*/
//void idObjective::Spawn( void ) {
//	Hide();
//
//	const char *camName;
//	if ( spawnArgs.GetString( "camShot", "", &camName ) ) {
//		common->Warning( "SpawnArg camShot on %s is not recommended.", spawnArgs.GetString( "name" ) );
// 		PostEventMS( &EV_CamShot, 250 );
//	}
//}
//
///*
//================
//idObjective::Event_Screenshot
//================
//*/
//void idObjective::Event_CamShot( ) {
//	const char *camName;
//
//// bdube: changed screenshot location
// 	idStr shotName = "gfx/objectives/";
// 	shotName += spawnArgs.GetString( "screenshot" );
// 	shotName.SetFileExtension( ".tga" );
// 
//	if ( spawnArgs.GetString( "camShot", "", &camName ) ) {
//		idEntity *ent = gameLocal.FindEntity( camName );
//		if ( ent && ent->cameraTarget ) {
//			const renderView_t *view = ent->cameraTarget->GetRenderView();
//			renderView_t fullView = *view;
//			fullView.width = SCREEN_WIDTH;
//			fullView.height = SCREEN_HEIGHT;
//
//			// draw a view to a texture
//			renderSystem->CropRenderSize( 256, 256, true );
//			gameRenderWorld->RenderScene( &fullView );
// 			renderSystem->CaptureRenderToFile( shotName );
//			renderSystem->UnCrop();
//		}
//	}
//}  
//
///*
//================
//idObjective::Event_Trigger
//================
//*/
//void idObjective::Event_Trigger( idEntity *activator ) {
//	idPlayer *player = gameLocal.GetLocalPlayer();
//	if ( player ) {
//		if ( spawnArgs.GetString( "inv_objective", NULL ) ) {
//
//	 		if ( player && player->GetObjectiveHud() ) {
//// bdube: changed screenshot location
//				idStr shotName = spawnArgs.GetString( "screenshot" );
//
//				player->GetObjectiveHud()->SetStateString( "screenshot", shotName );
//				player->GetObjectiveHud()->SetStateString( "objective", "1" );
//				player->GetObjectiveHud()->SetStateString( "objectivetext", common->GetLocalizedString( spawnArgs.GetString( "objectivetext" ) ) );
//				player->GetObjectiveHud()->SetStateString( "objectivetitle", common->GetLocalizedString( spawnArgs.GetString( "objectivetitle" ) ) );
//
// 				player->GiveObjective( spawnArgs.GetString( "objectivetitle" ), spawnArgs.GetString( "objectivetext" ), shotName );
//
//				// a tad slow but keeps from having to update all objectives in all maps with a name ptr
//				for( int i = 0; i < gameLocal.num_entities; i++ ) {
//
//// jnewquist: Use accessor for static class type 
//					if ( gameLocal.entities[ i ] && gameLocal.entities[ i ]->IsType( idObjectiveComplete::GetClassType() ) ) {
//
//						if ( idStr::Icmp( spawnArgs.GetString( "objectivetitle" ), gameLocal.entities[ i ]->spawnArgs.GetString( "objectivetitle" ) ) == 0 ){
//							gameLocal.entities[ i ]->spawnArgs.SetBool( "objEnabled", true );
//							break;
//						}
//					}
//				}
//
//				PostEventMS( &EV_GetPlayerPos, 2000 );
//
//// mekberg: store triggered time for timed removal.
//				triggerTime = gameLocal.time;
//
//			}
//		}
//	}
//}
//
///*
//================
//idObjective::Event_GetPlayerPos
//================
//*/
//void idObjective::Event_GetPlayerPos() {
//	idPlayer *player = gameLocal.GetLocalPlayer();
//	if ( player ) {
//		playerPos = player->GetPhysics()->GetOrigin();
//		PostEventMS( &EV_HideObjective, 100, player );
//	}
//}
//
///*
//================
//idObjective::Event_HideObjective
//================
//*/
//void idObjective::Event_HideObjective(idEntity *e) {
//	idPlayer *player = gameLocal.GetLocalPlayer();
//	if ( player ) {
//		idVec3 v = player->GetPhysics()->GetOrigin() - playerPos;
//
//// mekberg: hide time done internally now
//		if ( v.Length() > 64.0f || gameLocal.time > triggerTime + 5000 ) {
//
//			player->HideObjective ( );
//			PostEventMS( &EV_Remove, 0 );
//		} else {
//			PostEventMS( &EV_HideObjective, 100, player );
//		}
//	}
//}
//
///*
//===============================================================================
//
//  idMoveableItem
//	
//===============================================================================
//*/
//
//CLASS_DECLARATION( idItem, idMoveableItem )
// 	EVENT( EV_Gib,			idMoveableItem::Event_Gib )
//END_CLASS
//
///*
//================
//idMoveableItem::idMoveableItem
//================
//*/
//idMoveableItem::idMoveableItem() {
//}
//
///*
//================
//idMoveableItem::~idMoveableItem
//================
//*/
//idMoveableItem::~idMoveableItem() {
//	// If this entity has been allocated, but not spawned, the physics object will
//	// not have a self pointer, and will not unregister itself from the entity.
//	SetPhysics( NULL );
//}
//
///*
//================
//idMoveableItem::Save
//================
//*/
//void idMoveableItem::Save( idSaveGame *savefile ) const {
//   	savefile->WriteStaticObject( physicsObj );
//}
//
///*
//================
//idMoveableItem::Restore
//================
//*/
//void idMoveableItem::Restore( idRestoreGame *savefile ) {
//	savefile->ReadStaticObject ( physicsObj );
//	RestorePhysics ( &physicsObj );
//}
//
///*
//================
//idMoveableItem::Spawn
//================
//*/
//void idMoveableItem::Spawn( void ) {
//	idTraceModel trm;
//	float density, friction, bouncyness;
//	idStr clipModelName;
//	idBounds bounds;
//
//	// if the model should be shrinked
//	if ( spawnArgs.GetBool( "clipshrink" ) ) {
//		trm.Shrink( CM_CLIP_EPSILON );
//	}
//
//	// get rigid body properties
//	spawnArgs.GetFloat( "density", "0.5", density );
//	density = idMath::ClampFloat( 0.001f, 1000.0f, density );
//	spawnArgs.GetFloat( "friction", "0.05", friction );
//	friction = idMath::ClampFloat( 0.0f, 1.0f, friction );
//	spawnArgs.GetFloat( "bouncyness", "0.6", bouncyness );
//	bouncyness = idMath::ClampFloat( 0.0f, 1.0f, bouncyness );
//
//	// setup the physics
//	physicsObj.SetSelf( this );
//
//
//// mwhitlock: Dynamic memory consolidation
//	RV_PUSH_HEAP_MEM(this);
//	// check if a clip model is set
//	spawnArgs.GetString( "itemclipmodel", "", clipModelName );
//	if ( clipModelName[0] ) {
//		if ( collisionModelManager->TrmFromModel( gameLocal.GetMapName(), clipModelName, trm ) ) {
//			physicsObj.SetClipModel( new idClipModel( trm ), density );
//		} else {
//			// fallback
//			physicsObj.SetClipModel( new idClipModel( GetPhysics()->GetClipModel() ), density );
//		}
//	} else {
//		// fallback
//		physicsObj.SetClipModel( new idClipModel( GetPhysics()->GetClipModel() ), density );
//	}
//
//// mwhitlock: Dynamic memory consolidation
//	RV_POP_HEAP();
//
//	physicsObj.SetOrigin( GetPhysics()->GetOrigin() );
//	physicsObj.SetAxis( GetPhysics()->GetAxis() );
//	physicsObj.SetBouncyness( bouncyness );
//	physicsObj.SetFriction( 0.6f, 0.6f, friction );
//	physicsObj.SetGravity( gameLocal.GetGravity() );
//	physicsObj.SetContents( CONTENTS_RENDERMODEL );
//	physicsObj.SetClipMask( MASK_SOLID | CONTENTS_MOVEABLECLIP );
//	SetPhysics( &physicsObj );
//
//
//// mekberg: added
//	if ( spawnArgs.GetBool( "noimpact" ) || spawnArgs.GetBool( "notPushable" ) ) {
//		physicsObj.DisableImpact();
//	}
//
//}
//
///*
//================
//idMoveableItem::Think
//================
//*/
//void idMoveableItem::Think( void ) {
//	RunPhysics();
//	UpdateTrigger( );
//	Present();
//
//	if ( !gameLocal.isClient ) {
//		if ( empExplodeTime >= 0 ) {
//			if ( gameLocal.time > empExplodeTime ) {
//				EmpExplode();
//			}
//		}
//	}
//}
//
///*
//================
//idMoveableItem::DropItem
//================
//*/
//idEntity *idMoveableItem::DropItem( const char *classname, const idVec3 &origin, const idMat3 &axis, const idVec3 &velocity, int activateDelay, int removeDelay, idDict* extraArgs ) {
//	
//	idDict args;
//	idEntity *item;
//
//	if ( extraArgs ) {
//		args.Copy( *extraArgs );
//	}
//
//	args.Set( "classname", classname );
//	args.Set( "dropped", "1" );
//
// 	// we sometimes drop idMoveables here, so set 'nodrop' to 1 so that it doesn't get put on the floor
// 	args.Set( "nodrop", "1" ); 
//
//	if ( activateDelay ) {
//		args.SetBool( "triggerFirst", true );
//	}
//
//	gameLocal.SpawnEntityDef( args, &item );
//	if ( item ) {
//		// set item position
//		item->GetPhysics()->SetOrigin( origin );
//		item->GetPhysics()->SetAxis( axis );
//		item->GetPhysics()->SetLinearVelocity( velocity );
// 		item->UpdateVisuals();
//		if ( activateDelay ) {
//			item->PostEventMS( &EV_Activate, activateDelay, item );
//		}
//		if ( !removeDelay ) {
//			removeDelay = 5 * 60 * 1000;
//		}
//		// always remove a dropped item after 5 minutes in case it dropped to an unreachable location
//		item->PostEventMS( &EV_Remove, removeDelay );
//	}
//
// 	return item;
//}
//
///*
//================
//idMoveableItem::DropItems
//
//  The entity should have the following key/value pairs set:
// 	"def_drop<type>Item"			"item def"
// 	"drop<type>ItemJoint"			"joint name"
// 	"drop<type>ItemRotation"		"pitch yaw roll"
// 	"drop<type>ItemOffset"			"x y z"
// 	"skin_drop<type>"				"skin name"
//  To drop multiple items the following key/value pairs can be used:
// 	"def_drop<type>Item<X>"			"item def"
// 	"drop<type>Item<X>Joint"		"joint name"
// 	"drop<type>Item<X>Rotation"		"pitch yaw roll"
// 	"drop<type>Item<X>Offset"		"x y z"
//  where <X> is an aribtrary string.
//================
//*/
//void idMoveableItem::DropItems( idAnimatedEntity  *ent, const char *type, idList<idEntity *> *list ) {
//	const idKeyValue *kv;
//	const char *skinName, *c, *jointName;
//	idStr key, key2;
//	idVec3 origin;
//	idMat3 axis;
//	idAngles angles;
//	const idDeclSkin *skin;
//	jointHandle_t joint;
//	idEntity *item;
//
//	// drop all items
//	kv = ent->spawnArgs.MatchPrefix( va( "def_drop%sItem", type ), NULL );
//	while ( kv ) {
//
//		c = kv->GetKey().c_str() + kv->GetKey().Length();
//		if ( idStr::Icmp( c - 5, "Joint" ) != 0 && idStr::Icmp( c - 8, "Rotation" ) != 0 ) {
//
//			key = kv->GetKey().c_str() + 4;
//			key2 = key;
//			key += "Joint";
//			key2 += "Offset";
//			jointName = ent->spawnArgs.GetString( key );
//			joint = ent->GetAnimator()->GetJointHandle( jointName );
//			if ( !ent->GetJointWorldTransform( joint, gameLocal.time, origin, axis ) ) {
//				gameLocal.Warning( "%s refers to invalid joint '%s' on entity '%s'\n", key.c_str(), jointName, ent->name.c_str() );
//				origin = ent->GetPhysics()->GetOrigin();
//				axis = ent->GetPhysics()->GetAxis();
//			}
//			if ( g_dropItemRotation.GetString()[0] ) {
//				angles.Zero();
//				sscanf( g_dropItemRotation.GetString(), "%f %f %f", &angles.pitch, &angles.yaw, &angles.roll );
//			} else {
//				key = kv->GetKey().c_str() + 4;
//				key += "Rotation";
//				ent->spawnArgs.GetAngles( key, "0 0 0", angles );
//			}
//			axis *= angles.ToMat3() * axis;
//
//			origin += ent->spawnArgs.GetVector( key2, "0 0 0" );
//
//			item = DropItem( kv->GetValue(), origin, axis, vec3_origin, 0, 0 );
//			if ( list && item ) {
//				list->Append( item );
//			}
//		}
//
//		kv = ent->spawnArgs.MatchPrefix( va( "def_drop%sItem", type ), kv );
//	}
//
//	// change the skin to hide all items
// 	skinName = ent->spawnArgs.GetString( va( "skin_drop%s", type ) );
//	if ( skinName[0] ) {
//		skin = declManager->FindSkin( skinName );
//		ent->SetSkin( skin );
//	}
//}
//
///*
//======================
//idMoveableItem::WriteToSnapshot
//======================
//*/
//void idMoveableItem::WriteToSnapshot( idBitMsgDelta &msg ) const {
//	physicsObj.WriteToSnapshot( msg );
//}
//
///*
//======================
//idMoveableItem::ReadFromSnapshot
//======================
//*/
//void idMoveableItem::ReadFromSnapshot( const idBitMsgDelta &msg ) {
//	physicsObj.ReadFromSnapshot( msg );
// 	if ( msg.HasChanged() ) {
//		UpdateVisuals();
// 	}
//}
//
///*
//============
//idMoveableItem::Gib
//============
//*/
//void idMoveableItem::Gib( const idVec3 &dir, const char *damageDefName ) {
//	// remove the entity
//	PostEventMS( &EV_Remove, 0 );
//}
//
///*
//============
//idMoveableItem::Event_Gib
//============
//*/
//void idMoveableItem::Event_Gib( const char *damageDefName ) {
//	Gib( idVec3( 0, 0, 1 ), damageDefName );
//}
//
///*
//===============================================================================
//
//  idItemRemover
//
//===============================================================================
//*/
//
//CLASS_DECLARATION( idEntity, idItemRemover )
//	EVENT( EV_Activate,		idItemRemover::Event_Trigger )
//END_CLASS
//
///*
//================
//idItemRemover::Spawn
//================
//*/
//void idItemRemover::Spawn( void ) {
//}
//
///*
//================
//idItemRemover::RemoveItem
//================
//*/
//void idItemRemover::RemoveItem( idPlayer *player ) {
//	const char *remove;
//	
//	remove = spawnArgs.GetString( "remove" );
//	player->RemoveInventoryItem( remove );
//}
//
///*
//================
//idItemRemover::Event_Trigger
//================
//*/
//void idItemRemover::Event_Trigger( idEntity *activator ) {
//
//// jnewquist: Use accessor for static class type 
//	if ( activator->IsType( idPlayer::GetClassType() ) ) {
//
//		RemoveItem( static_cast<idPlayer *>(activator) );
//	}
//}
//
///*
//===============================================================================
//
//  idObjectiveComplete
//
//===============================================================================
//*/
//
//CLASS_DECLARATION( idItemRemover, idObjectiveComplete )
//	EVENT( EV_Activate,			idObjectiveComplete::Event_Trigger )
//	EVENT( EV_HideObjective,	idObjectiveComplete::Event_HideObjective )
//	EVENT( EV_GetPlayerPos,		idObjectiveComplete::Event_GetPlayerPos )
//END_CLASS
//
///*
//================
//idObjectiveComplete::idObjectiveComplete
//================
//*/
//idObjectiveComplete::idObjectiveComplete() {
//	playerPos.Zero();
//
//
//// mekberg: store triggered time for timed removal.
//	triggerTime = 0;
//
//}
//
///*
//================
//idObjectiveComplete::Save
//================
//*/
//void idObjectiveComplete::Save( idSaveGame *savefile ) const {
//	savefile->WriteVec3( playerPos );
//}
//
///*
//================
//idObjectiveComplete::Restore
//================
//*/
//void idObjectiveComplete::Restore( idRestoreGame *savefile ) {
//	savefile->ReadVec3( playerPos );
//}
//
///*
//================
//idObjectiveComplete::Spawn
//================
//*/
//void idObjectiveComplete::Spawn( void ) {
// 	spawnArgs.SetBool( "objEnabled", false );
//	Hide();
//}
//
///*
//================
//idObjectiveComplete::Event_Trigger
//================
//*/
//void idObjectiveComplete::Event_Trigger( idEntity *activator ) {
// 	if ( !spawnArgs.GetBool( "objEnabled" ) ) {
// 		return;
// 	}
//	idPlayer *player = gameLocal.GetLocalPlayer();
//	if ( player ) {
//		RemoveItem( player );
//
//		if ( spawnArgs.GetString( "inv_objective", NULL ) ) {
//
//	 		if ( player->GetObjectiveHud() ) {
//				player->GetObjectiveHud()->SetStateString( "objective", "2" );
//				player->GetObjectiveHud()->SetStateString( "objectivetext", common->GetLocalizedString( spawnArgs.GetString( "objectivetext" ) ) );
//				player->GetObjectiveHud()->SetStateString( "objectivetitle", common->GetLocalizedString( spawnArgs.GetString( "objectivetitle" ) ) );
//
//				player->CompleteObjective( spawnArgs.GetString( "objectivetitle" ) );
//				PostEventMS( &EV_GetPlayerPos, 2000 );
//
//// mekberg: store triggered time for timed removal.
//				triggerTime = gameLocal.time;
//
//			}
//		}
//	}
//}
//
///*
//================
//idObjectiveComplete::Event_GetPlayerPos
//================
//*/
//void idObjectiveComplete::Event_GetPlayerPos() {
//	idPlayer *player = gameLocal.GetLocalPlayer();
//	if ( player ) {
//		playerPos = player->GetPhysics()->GetOrigin();
//		PostEventMS( &EV_HideObjective, 100, player );
//	}
//}
//
///*
//================
//idObjectiveComplete::Event_HideObjective
//================
//*/
//void idObjectiveComplete::Event_HideObjective( idEntity *e ) {
//	idPlayer *player = gameLocal.GetLocalPlayer();
//	if ( player && player->GetObjectiveHud() ) {
//		idVec3 v = player->GetPhysics()->GetOrigin();
//		v -= playerPos;
//
//// mekberg: hide time done internally now
//		if ( v.Length() > 64.0f || gameLocal.time > triggerTime + 5000 ) {
//
//			player->HideObjective ( );
//			PostEventMS( &EV_Remove, 0 );
//		} else {
//			PostEventMS( &EV_HideObjective, 100, player );
//		}
//	}
//}
//
///*
//===============================================================================
//
//  rvObjectiveFailed
//
//===============================================================================
//*/
//CLASS_DECLARATION( idItemRemover, rvObjectiveFailed )
//	EVENT( EV_Activate,			rvObjectiveFailed::Event_Trigger )
//END_CLASS
//
//rvObjectiveFailed::rvObjectiveFailed ( void ) {
//}
//
///*
//================
//rvObjectiveFailed::Event_Trigger
//================
//*/
//void rvObjectiveFailed::Event_Trigger( idEntity *activator ) {
//	idPlayer *player = gameLocal.GetLocalPlayer();
//	if ( !player || !player->GetObjectiveHud() ) {
//		return;
//	}
//	if ( !spawnArgs.GetString( "inv_objective", NULL ) ) {
//		return;
//	}	
//
//	player->GetObjectiveHud()->SetStateString( "objective", "2" );
//	player->GetObjectiveHud()->SetStateString( "objectivetext", common->GetLocalizedString( spawnArgs.GetString( "objectivetext" ) ) );
//	player->GetObjectiveHud()->SetStateString( "objectivetitle", common->GetLocalizedString( spawnArgs.GetString( "objectivetitle" ) ) );
//	player->FailObjective( spawnArgs.GetString( "objectivetitle" ) );
//}
//
//// <q4f> 
//
//void idItem::EmpTouch( const AttackerInfo &attacker, idVec3 &dir, float damageScale ) {
//	/*assert( !gameLocal.isClient );
//
//	// check if we have ammo to explode
//	int damage = 0;
//
//	int shells = spawnArgs.GetInt( "inv_ammo_shells", "0" );
//	int nails = spawnArgs.GetInt( "inv_ammo_nails", "0" );
//	int rockets = spawnArgs.GetInt( "inv_ammo_rockets", "0" );
//	int cells = spawnArgs.GetInt( "inv_ammo_cells", "0" );
//
//	if ( shells > 0 ) {
//		damage += 50 + shells;
//	}
//	
//	if ( nails > 0 ) {
//		damage += 40;
//	}
//	
//	if ( rockets > 0 ) {
//		damage += 100 + ( rockets * 4 );
//	}
//	
//	if ( cells > 0 ) {
//		damage += 100 + ( cells * 3 );
//	}
//
//	damage *= damageScale;
//
//	if ( damage > 0 ) {
//		empExplodeTime = SEC2MS( 0.5f + gameLocal.random.RandomFloat() ) + gameLocal.time;
//
//		empDamage.Create( attacker, NULL, dir, gameLocal.FindEntityDef( "q4f_damage_emp_itemExplode", false ) );
//		empDamage.SetDamage( damage );
//	}
//
//	// dont let ourselves get picked up
//	canPickUp = false;*/
//}
//
//
////--------------------------------------------------------------------------
//// Go boom boom
////--------------------------------------------------------------------------
//void idItem::EmpExplode() {
//
//	PlayDetonateEffect();	
//
//	if ( !gameLocal.isClient ) {
//		// send the event
//		ServerSendEvent( EVENT_EMPEXPLODE, NULL, false, -1 );
//
//		// do the damage
//		gameLocal.RadiusDamage_TF( GetPhysics()->GetOrigin(), empDamage, this );
//
//		Deactivate();
//	}
//
//	empExplodeTime = -1;
//}
//
//
////--------------------------------------------------------------------------
//// Helper function for pickup and emp explode
////--------------------------------------------------------------------------
//void idItem::Deactivate() {
//	// clear our contents so the object isn't picked up twice
//	GetPhysics()->SetContents( 0 );
//
//	// hide the model, or switch to the pickup skin
//	if ( pickupSkin ) {
//		SetSkin( pickupSkin );
//		srvReady = 0;
//	} else {
//		Hide();
//		BecomeInactive( TH_THINK );
//	}
//
//	// remove the highlight shell
//	if ( itemShellHandle != -1 ) {
//		gameRenderWorld->FreeEntityDef( itemShellHandle );
//		itemShellHandle = -1;
//	}
//
//	// asalmon: Added option for a differnt respawn rate based on gametype.
//	/*float respawn = spawnArgs.GetFloat(va("respawn_%s",gameLocal.serverInfo.GetString( "si_gameType" )), "-1.0");
//	if( respawn == -1.0f ) {
//		respawn = spawnArgs.GetFloat( "respawn", "5.0" );
//	}*/
//
//	float respawn = 15.0f;
//
//	bool no_respawn = spawnArgs.GetBool( "no_respawn" );
//
//	if ( !gameLocal.isMultiplayer ) {
//		respawn = 0.0f;
//	}
//
//	if ( respawn && !spawnArgs.GetBool( "dropped" ) && !no_respawn ) {
//		const char *sfx = spawnArgs.GetString( "fx_Respawn" );
//		if ( sfx && *sfx ) {
//			PostEventSec( &EV_RespawnFx, respawn - 0.5f );
//		}
//		PostEventSec( &EV_RespawnItem, respawn );
//	} else if ( !spawnArgs.GetBool( "inv_objective" ) && !no_respawn ) {
//		// give some time for the pickup sound to play
//		// FIXME: Play on the owner
//		if ( !spawnArgs.GetBool( "inv_carry" ) ) {
//			PostEventMS( &EV_Remove, 5000 );
//		}
//	}
//	
//	trigger->SetContents( 0 );	
//	
//	StopEffect( "fx_idle" );
//}
//
//// </q4f>