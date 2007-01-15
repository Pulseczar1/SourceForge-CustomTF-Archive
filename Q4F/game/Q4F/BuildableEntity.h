#ifndef __Q4F_BUILDABLE_H__
#define __Q4F_BUILDABLE_H__

/*
===============================================================================

	Parent class for entities that a player can build... just a prototyper

===============================================================================
*/

typedef enum {
	BUILD_FX_START = 0,
	BUILD_FX_STOP = 1,
	BUILD_FX_FINISHED = 2
} buildFxEvent_t;

class BuildableEntity : public idEntity {
	ABSTRACT_PROTOTYPE( BuildableEntity );

public:
							BuildableEntity( void );
							~BuildableEntity();

	void			Spawn( void );

	virtual void	UpdateHud( idUserInterface* hud ) {};

	void			StartBuilding( idPlayer* owner, const idVec3 &pos, float rotation, int buildStartTime );		// begin building
	void			StopBuilding( void );									// cancel building due to some error

	void			WriteToSnapshot( idBitMsgDelta &msg ) const;
	void			ReadFromSnapshot( const idBitMsgDelta &msg );

	idPlayer*		GetOwner( void ) const;
	void			SetOwner( idPlayer* newOwner );


	float			GetBuildPercent( int time );

	enum {
		EVENT_BUILDEFFECT = idEntity::EVENT_MAXEVENTS,
		EVENT_MAXEVENTS
	};

	void			SendEffectEvent( buildFxEvent_t event );
	bool			ReceiveEffectEvent( buildFxEvent_t event );

	virtual bool			ClientReceiveEvent( int event, int time, const idBitMsg &msg );

protected:
	float			UpdateBuildStatus( void );

	virtual void	BuildFinished( void ) {};
	virtual void	BuildStarted( void ) {};

	AttackerInfo	ownerInfo;

	rvPhysics_Particle		physicsObj;

private:

	int						buildStartTime;
	int						buildTime;
	float					maxBuildDist;


};

ID_INLINE idPlayer* BuildableEntity::GetOwner( void ) const {
	return ownerInfo.GetPlayer();
}

ID_INLINE float BuildableEntity::GetBuildPercent( int time ) {
	if ( buildStartTime <= 0 ) {
		return 0.0f;
	}
	int diff = time - buildStartTime;
	if ( diff >= buildTime ) {
		return 1.0f;
	}

	return (float)diff / (float)buildTime;
}


#endif