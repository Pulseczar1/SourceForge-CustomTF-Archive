
// bdube: note that this file is no longer merged with Doom3 updates
//
// MERGE_DATE 09/30/2004

#ifndef __GAME_TFITEM_H__
#define __GAME_TFITEM_H__

extern const idEventDef EV_SetGravity;

/*
===============================================================================

  Items the player can pick up or use.

===============================================================================
*/

const int ASYNC_ITEM_EFFECT_BITS = 3;

class TFItem : public TFEntity {
public:
	CLASS_PROTOTYPE( TFItem );

							TFItem();
	virtual					~TFItem();

	void					Spawn( void );

	virtual void			Think( void );

	virtual bool			GetPhysicsToVisualTransform( idVec3 &origin, idMat3 &axis );

	virtual bool			Collide( const trace_t &collision, const idVec3 &velocity );

	virtual void			ClientPredictionThink( void );

	// networking
	virtual void			WriteToSnapshot( idBitMsgDelta &msg ) const;
	virtual void			ReadFromSnapshot( const idBitMsgDelta &msg );

	virtual void			Hide( void );
	virtual void			Show( void );

	virtual bool			ClientStale( void );
	virtual void			ClientUnstale( void );

	void					EmpTouch( const AttackerInfo &attacker, idVec3 &dir, float damageScale );

	int						GetSpawnTime( void ) { return spawnTime; };

	virtual void			UpdateVisibleColor( void );

	virtual	void			Event_Touch				( idEntity *other, trace_t *trace );
	virtual	void			Event_EmpExplode		( void );
	virtual	void			Event_Activate			( idEntity *activator );
	virtual	void			Event_AllowPickup		( void );


	idPlayer*				ignorePlayer;
	int						ignoreTime;


protected:
	virtual void			OnStateChange( tfstate_t oldState, tfstate_t newState, idEntity* activator );

	virtual void			UpdateTrigger( void );

	virtual bool			AllowActivate( idEntity* player );

	void					StartEffectState( tfstate_t newState );
	void					UpdateEffectState( void );

	tfstate_t				clientState;

	idClipModel*			trigger;

	bool					dropToFloor;

	float					transScale;
	float					transSpin;
	bool					doTrans;

	int						spawnTime;

	bool					spawned;

	bool					syncPhysics;

	rvPhysics_Particle		physicsObj;

	bool					simpleItem;
	bool					pickedUp;

	rvClientEntityPtr<rvClientEffect>			currentEffect;

	

private:

	TFDamage				empDamage;
	const idDeclSkin*		skin;
	const idDeclSkin*		pickupSkin;
	bool					usingSkin;
};

ID_INLINE void TFItem::UpdateVisibleColor( void ) {
	if ( fl.teamColored ) {
		idVec3 myColor = GetTeamColor( true );
		myColor *= teamColorScale;
		SetColor( myColor );

		if ( currentEffect ) {
			idVec4 c( myColor.x, myColor.y, myColor.z, 1.0f );
			currentEffect->SetColor( c );
		}
	}
}





typedef struct carrierInfo_s {
	idEntityPtr< idPlayer >		carrier;
	idVec3						startPos;
	idVec3						endPos;
} carrierInfo_t;

class TFCarryItem : public TFItem {
public:
	CLASS_PROTOTYPE( TFCarryItem );

							TFCarryItem( void );
							~TFCarryItem( void );

	void					Spawn( void );

	virtual bool			GetPhysicsToVisualTransform( idVec3 &origin, idMat3 &axis );

public:
	void					OnStateChange( tfstate_t oldState, tfstate_t newState, idEntity* activator );

	int						GetNumCarriers( void ) { return carriers.Num(); };
	idPlayer*				GetCarrier( void );
	idPlayer*				GetCarrierNum( int num );
	const idVec3&			GetCarrierGrabPos( int num );
	const idVec3&			GetCarrierDropPos( int num );

	float					GetCarryDistance( void ) { return ( GetPhysics()->GetOrigin() - lastGrabPos ).Length(); };

protected:

	virtual bool			AllowActivate( idEntity* player );

	void					Event_GetSpawnPos			( void );
	void					Event_GetCarrier			( void );
	void					Event_GetNumCarriers		( void );
	void					Event_GetCarrierNum			( int num );
	void					Event_GetCarrierGrabPos		( int num );
	void					Event_GetCarrierDropPos		( int num );

private:

	carrierInfo_t*			FindCarrier( idPlayer* newCarrier );

	void					Event_Activate			( idEntity *activator );

	idMat3					spawnAxis;

	bool					showCarry;
	idEntityPtr<idPlayer>	carrier;
	idList<carrierInfo_t>	carriers;

	idVec3					lastGrabPos;
};

ID_INLINE const idVec3& TFCarryItem::GetCarrierGrabPos( int num ) {
	if ( num >= 0 && num < carriers.Num() ) {
		return carriers[num].startPos;
	}
	gameLocal.Warning( "GetCarrierGrabPos; num '%d' is outside range of [0,numCarriers)", num );
	return vec3_zero;
}

ID_INLINE const idVec3& TFCarryItem::GetCarrierDropPos( int num ) {
	if ( num >= 0 && num < carriers.Num() ) {
		if ( carriers[num].carrier == carrier ) {
			return physicsObj.GetOrigin();
		}
		return carriers[num].endPos;
	}
	gameLocal.Warning( "GetCarrierDropPos; num '%d' is outside range of [0,numCarriers)", num );
	return vec3_zero;
}

ID_INLINE idPlayer* TFCarryItem::GetCarrier( void ) {
	return carrier.GetEntity();
}

ID_INLINE idPlayer* TFCarryItem::GetCarrierNum( int num ) {
	if ( num >= 0 && num < carriers.Num() )
		return carriers[num].carrier.GetEntity();

	return NULL;
}

ID_INLINE carrierInfo_t* TFCarryItem::FindCarrier( idPlayer* newCarrier ) {
	assert( newCarrier );

	for( int i = 0; i < carriers.Num(); i++ ) {
		if ( carriers[i].carrier.GetEntity() == newCarrier ) {
			return &(carriers[i]);
		}
	}

	return NULL;
}

/*





class TFItemPowerup : public TFItem {
public:
	CLASS_PROTOTYPE( TFItemPowerup );

							TFItemPowerup();

	void					Save( idSaveGame *savefile ) const;
	void					Restore( idRestoreGame *savefile );

	void					Spawn();
	virtual bool			GiveToPlayer( idPlayer *player );
	virtual void			Think( void );
	virtual bool			Pickup( idPlayer *player );

protected:

	int						time;
	int						type;
	int						droppedTime;
	int						team;
	bool					unique;
};



class rvItemCTFFlag : public TFItem {
public:
	CLASS_PROTOTYPE( rvItemCTFFlag );
	
							rvItemCTFFlag();
							
	void					Spawn();
	virtual bool			GiveToPlayer ( idPlayer* player );
	virtual bool			Pickup( idPlayer *player );
	
	static void				ResetFlag( int type );
	virtual void			Think( void );

	virtual bool			Collide( const trace_t &collision, const idVec3 &velocity );

private:
	int						team;
	int						powerup;
	bool					dropped;
	
	void					Event_ResetFlag( void );
	void					Event_LinkTrigger( void );
};

*/

#endif


