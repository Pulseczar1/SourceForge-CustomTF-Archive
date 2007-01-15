
// bdube: note that this file is no longer merged with Doom3 updates
//
// MERGE_DATE 09/30/2004

#ifndef __GAME_PROJECTILE_H__
#define __GAME_PROJECTILE_H__

/*
===============================================================================

  idProjectile
	
===============================================================================
*/

#define MAX_SIMUL_SPLASHES 3

extern const idEventDef EV_Explode;
extern const idEventDef	EV_Detonate;

class idProjectile : public idEntity {
public :
	CLASS_PROTOTYPE( idProjectile );

							idProjectile();
	virtual					~idProjectile();

	void					Spawn( void );

	void					Create( const AttackerInfo &owner, const idVec3 &start, const idVec3 &dir, idEntity* ignore = NULL, idEntity* extraPassEntity = NULL );
	virtual void			Launch( const idVec3 &start, const idVec3 &dir, const idVec3 &pushVelocity, const float timeSinceFire = 0.0f, const float dmgPower = 1.0f );
	virtual void			Relaunch( const idVec3 &newDir );

	virtual void			FreeLightDef( void );

	idEntity *				GetOwner( void );

	virtual void			Think( void );
	virtual void			Killed( idEntity *inflictor, idEntity *attacker, int damage, const idVec3 &dir, int location );
	virtual bool			GetPhysicsToVisualTransform( idVec3 &origin, idMat3 &axis );

	virtual bool			Collide( const trace_t &collision, const idVec3 &velocity );
	virtual bool			Collide( const trace_t &collision, const idVec3 &velocity, bool &hitTeleporter );
	virtual void			Explode( const trace_t *collision, const bool showExplodeFX, idEntity *ignore = NULL, const char *sndExplode = "snd_explode" );
	void					Fizzle( void );

	static idVec3			GetVelocity( const idDict *projectile );
	static idVec3			GetGravity( const idDict *projectile );

	float					GetSpeed		( void ) const;

	virtual void			UpdateVisualAngles();

	virtual void			ClientPredictionThink( void );
	virtual void			WriteToSnapshot( idBitMsgDelta &msg ) const;
	virtual void			ReadFromSnapshot( const idBitMsgDelta &msg );

	virtual bool			ClientStale( void );

	virtual void			EmpTouch( const AttackerInfo &attacker, idVec3 &dir, float damageScale );
	
protected:

	virtual void			OnLaunch( void ) { };		// for subclasses

	AttackerInfo			ownerInfo;
	TFDamage				dmgSplash;
	TFDamage				dmgDirect;

	struct projectileFlags_s {
		bool				detonate_on_world			: 1;
		bool				detonate_on_actor			: 1;
		bool				detonate_on_bounce			: 1;		// Detonate if hit a bounce surface
		bool				bounce_only_on_world		: 1;
		bool				sticky						: 1;
	} projectileFlags;

	renderLight_t			renderLight;
	qhandle_t				lightDefHandle;				// handle to renderer light def
	idVec3					lightOffset;
	int						lightStartTime;
	int						lightEndTime;
	idVec3					lightColor;

	rvPhysics_Particle		physicsObj;
	idAngles				visualAngles;
	idAngles				angularVelocity;
	idInterpolate<float>	speed;
	bool					updateVelocity;

	bool					hurt_owner;

	rvSphericalInterpolate	rotation;

	rvClientEffectPtr		flyEffect;
	float					flyEffectAttenuateSpeed;

// ddynerman: pre-prediction ( rocket jumping )
	int						prePredictTime;

	typedef enum {
		SPAWNED = 0,
		CREATED = 1,
		LAUNCHED = 2,
		FIZZLED = 3,
		EXPLODED = 4
	} projectileState_t;
	
	projectileState_t		state;

	void					PlayPainEffect		( idEntity* ent, int damage, const rvDeclMatType* materialType, const idVec3& origin, const idVec3& direction );


private:
	void					DefaultDamageEffect	( const trace_t &collision, const idVec3 &velocity, ENTDEF dmgDef );

	void					Event_Detonate			( void );
	void					Event_Explode			( void );
	void					Event_Fizzle			( void );
	void					Event_RadiusDamage		( idEntity *ignore );
	void					Event_ResidualDamage	( idEntity *ignore );
	void					Event_Touch				( idEntity *other, trace_t *trace );
	void					Event_StopFlyEffect		( void );

private:
	bool					syncPhysics;
	// cheap linear client side projectiles
	// transmitted in snapshot
public:
	int						launchTime;
private:
	idVec3					launchOrig;
	idVec3					launchDir;
	// set from def file in :Launch on both client and server
	float					launchSpeed;

	bool					noWater;
	bool					angleBounce;
};

ID_INLINE float idProjectile::GetSpeed ( void ) const {
	return speed.GetCurrentValue( gameLocal.time );
}

//============================================================================================================
// Pipebombs
//============================================================================================================
class Pipebomb : public idProjectile {
public:
	CLASS_PROTOTYPE( Pipebomb );

						Pipebomb( void );
						~Pipebomb( void );

	void				Launch( const idVec3 &start, const idVec3 &dir, const idVec3 &pushVelocity, const float timeSinceFire = 0.0f, const float dmgPower = 1.0f );
	void				RemoveFromPlayer( void );
	int					GetSpawnTime( void ) { return spawnTime; };

	virtual bool		ClientStale( void ) { return false; };

private:
	int					spawnTime;
	bool				removed;
};


#endif /* !__GAME_PROJECTILE_H__ */


