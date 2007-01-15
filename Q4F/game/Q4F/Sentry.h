#ifndef __Q4F_SENTRY_H__
#define __Q4F_SENTRY_H__

typedef enum sentryState_s {
	SENTRY_STATE_SPAWNED,
	SENTRY_STATE_BUILDING,
	SENTRY_STATE_SCANNING,
	SENTRY_STATE_TRACKING,
	SENTRY_STATE_ATTACKING,
	SENTRY_STATE_DISABLED
} sentryState_t;

class SentryLevelInfo {
public:

	int				max_armor;
	int				max_shells;
	int				max_rockets;

	int				track_delay;

	const char*		model;

	ENTDEF			hitscanDef;
	//TFDamage		hitscanDmg;

	ENTDEF			projectileDef;

	float			attackEpsilon;
	float			attackAngle;

	int				track_time;

	float			turnRate;

	int				mgAttackDelay;
	int				rocketAttackDelay;

	idVec3			sentryPos;

	idVec3			gunPos1;
	idVec3			gunPos2;
	idVec3			gunPos3;
	idVec3			gunPos4;

	idVec3			rocketPos1;
	idVec3			rocketPos2;

	idVec3			projectilePos1;
	idVec3			projectilePos2;

	idVec3			eyePos;

	float			searchForwardDist;
	float			searchBackwardDist;

	idInterpolateAccelDecelSine<float>	scanYaw;

	void			Init( AttackerInfo &owner, const idDict* args );
	void			LoopScanYaw( void );
};

class SentryGun : public BuildableEntity {
	CLASS_PROTOTYPE( SentryGun );
public:

					SentryGun( void );
					~SentryGun( void );

	virtual void			Spawn( void );
	virtual void			Think( void );
	virtual void			ClientPredictionThink( void );

	virtual void			UpdateHud( idUserInterface* hud );

	virtual void			Damage_TF( const TFDamage &tfDamage, float damageScale );

	virtual void			UpdateModelTransform( void );
	virtual void			FreeModelDef( void );
	virtual void			Present( void );

	virtual void			UpdateVisibleColor( void );

	virtual void			WriteToSnapshot( idBitMsgDelta &msg ) const;
	virtual void			ReadFromSnapshot( const idBitMsgDelta &msg );

	enum {
		EVENT_UPGRADE = BuildableEntity::EVENT_MAXEVENTS,
		EVENT_FIREROCKET,
		EVENT_MAXEVENTS
	};

	void			SendRocketEvent( bool rocketPos );
	void			ReceiveRocketEvent( bool rocketPos );

	void			SendUpgradeEvent( void );
	void			ReceiveUpgradeEvent( void );

	virtual bool			ClientReceiveEvent( int event, int time, const idBitMsg &msg );

	int				GetLevel( void ) const { return sentLevel; };

	sentryState_t	GetState( void ) const { return state; };

	virtual void	EmpTouch( const AttackerInfo &attacker, idVec3 &dir, float damageScale );

	void			Explode( void );

	void			Rotate( int degrees );

	int				shells;
	int				rockets;

	SentryLevelInfo	sentryInfo;

protected:
	virtual void			BuildFinished( void );
	virtual void			BuildStarted( void );	

private:

	int				Repair( int numCells );
	int				RefillShells( int numShells );
	int				RefillRockets( int numRockets );

	bool			CanTarget( idPlayer* player, bool seeThruDisguise = false );

	idPlayer*		FindTarget( void );
	int				CanSee( idEntity* ent, trace_t &trace, bool allowBehind );
	void			LookAtDir( idVec3 &dir, float turnSpeedMultiplier = 1.0f );
	void			LookAtPos( idVec3 &pos, float turnSpeedMultiplier = 1.0f );
	void			LookAtAngles( idAngles &angles, float turnSpeedMultiplier = 1.0f );

	void			FireMG( idVec3 &dir );
	void			FireRocket( const idVec3 &targetPos, const idVec3 &targetVelocity );

	void			PredictAim( const idVec3& source, float maxAngle, float projectileSpeed, const idVec3& target, const idVec3& targetVelocity, idVec3& newAimDir ) const;

	int				Upgrade( int numCells, int newSentryNum, bool playEffect = true, int clientToTell = -1 );

	void			UpdateClipModels( bool enable = true );
	void			ClearClipModels( void );

	void			GetSentryOrientation( idVec3* sentryPos = NULL, idMat3* sentryAxis = NULL, idVec3* eyePos = NULL );

	void			UpdateBuildEffect( float percent );

	void			GetGunPos( int gunNum, idVec3 &pos );

	renderEntity_t	sentryRenderEntity;
	int				sentryModelDefHandle;

	int				oldHealth;

	idClipModel*	sentryClipModel;
	idClipModel*	baseClipModel;
	sentryState_t	state;

	int				target_site_time;

	int				sentLevel;

	int				gunNum;
	int				rocketNum;

	idAngles		offsetViewAngles;
	idAngles		snapAngles;
	idAngles		viewAngles;
	idVec3			viewDir;

	int				track_start_time;
	
	int				nextMGAttackTime;
	int				nextRocketAttackTime;

	idEntityPtr<idPlayer>	target;
};

ID_INLINE void SentryGun::GetSentryOrientation( idVec3* sentryPos, idMat3* sentryAxis, idVec3* eyePos ) {
	idAngles sumAngles = viewAngles;
	sumAngles.yaw += offsetViewAngles.yaw;

	idMat3 axis = sumAngles.ToMat3();

	if ( sentryPos ) {
		*sentryPos = ( sentryInfo.sentryPos * axis ) + GetPhysics()->GetOrigin();
	}
	if ( sentryAxis ) {
		*sentryAxis = axis;
	}
	if ( eyePos ) {
		*eyePos = ( sentryInfo.eyePos * axis ) + GetPhysics()->GetOrigin();
	} 
}

ID_INLINE void SentryGun::UpdateVisibleColor( void ) {
	idEntity::UpdateVisibleColor();
	memcpy( &(sentryRenderEntity.shaderParms), &(renderEntity.shaderParms), sizeof( sentryRenderEntity.shaderParms ) );
}


#endif
