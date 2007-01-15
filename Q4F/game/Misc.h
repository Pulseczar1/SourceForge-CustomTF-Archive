
#ifndef __GAME_MISC_H__
#define __GAME_MISC_H__

/*
===============================================================================

idSpawnableEntity

A simple, spawnable entity with a model and no functionable ability of it's own.
For example, it can be used as a placeholder during development, for marking
locations on maps for script, or for simple placed models without any behavior
that can be bound to other entities.  Should not be subclassed.
===============================================================================
*/

class idSpawnableEntity : public idEntity {
public:
	CLASS_PROTOTYPE( idSpawnableEntity );

	void				Spawn( void );

private:
};

/*
===============================================================================

  Non-displayed entity used to activate triggers when it touches them.
  Bind to a mover to have the mover activate a trigger as it moves.
  When target by triggers, activating the trigger will toggle the
  activator on and off. Check "start_off" to have it spawn disabled.
	
===============================================================================
*/

class idActivator : public idEntity {
public:
	CLASS_PROTOTYPE( idActivator );

	void				Spawn( void );

	void				Save( idSaveGame *savefile ) const;
	void				Restore( idRestoreGame *savefile );

	virtual void		Think( void );

private:
	bool				stay_on;

	void				Event_Activate( idEntity *activator );
};

/*
===============================================================================

  Path entities for monsters to follow.

===============================================================================
*/
class idPathCorner : public idEntity {
public:
	CLASS_PROTOTYPE( idPathCorner );

	void				Spawn( void );

	static void			DrawDebugInfo( void );

	static idPathCorner *RandomPath( const idEntity *source, const idEntity *ignore );

private:
	void				Event_RandomPath( void );
};

/*
===============================================================================

  Object that fires targets and changes shader parms when damaged.

===============================================================================
*/

class idDamagable : public idEntity {
public:
	CLASS_PROTOTYPE( idDamagable );

						idDamagable( void );

	void				Save( idSaveGame *savefile ) const;
	void				Restore( idRestoreGame *savefile );

	void				Spawn( void );
	void				Killed( idEntity *inflictor, idEntity *attacker, int damage, const idVec3 &dir, int location );


// abahr:
	virtual void		Damage( idEntity *inflictor, idEntity *attacker, const idVec3 &dir, const char *damageDefName, const float damageScale, const int location );

	int					invincibleTime;

// abahr: changed to protected
protected:
	int					stage;
	int					stageNext;
	const idDict*		stageDict;
	int					stageEndTime;
	int					stageEndHealth;
	int					stageEndSpeed;
//jshepard: used to end a stage if a moveable is on the ground (for falling objects)
	bool				stageEndOnGround;
//jshepard: we want to activate certain objects when triggered-- falling blocks yes, barrels no.
	bool				activateStageOnTrigger;
		
	virtual void		ExecuteStage	( void );
	void				UpdateStage		( void );
	idVec3				GetStageVector	( const char* key, const char* defaultString = "" ) const;
	float				GetStageFloat	( const char* key, const char* defaultString = "" ) const;
	int					GetStageInt		( const char* key, const char* defaultString = "" ) const;


	int					count;
	int					nextTriggerTime;

	void				BecomeBroken( idEntity *activator );
	void				Event_BecomeBroken( idEntity *activator );
	void				Event_RestoreDamagable( void );
};

/*
===============================================================================

  Hidden object that explodes when activated

===============================================================================
*/

class idExplodable : public idEntity {
public:
	CLASS_PROTOTYPE( idExplodable );

	void				Spawn( void );

private:
	void				Event_Explode( idEntity *activator );
};


/*
===============================================================================

  idSpring

===============================================================================
*/

class idSpring : public idEntity {
public:
	CLASS_PROTOTYPE( idSpring );

	void				Spawn( void );
	void				Save( idSaveGame *savefile ) const;
	void				Restore( idRestoreGame *savefile );

	virtual void		Think( void );

private:
	idEntityPtr<idEntity>	ent1;
	idEntityPtr<idEntity>	ent2;
	int						id1;
	int						id2;
	idVec3					p1;
	idVec3					p2;
	idForce_Spring			spring;

	void				Event_LinkSpring( void );
};


/*
===============================================================================

  idForceField

===============================================================================
*/

class idForceField : public idEntity {
public:
	CLASS_PROTOTYPE( idForceField );

	void				Save( idSaveGame *savefile ) const;
	void				Restore( idRestoreGame *savefile );

	void				Spawn( void );

	virtual void		Think( void );


// kfuller: idDamagable may want to change some things on the fly
	void				SetExplosion(float force) { forceField.Explosion(force); }




// bdube: made force field protected
protected:

	idForce_Field		forceField;
	
private:

	void				Toggle( void );

	void				Event_Activate( idEntity *activator );
	void				Event_Toggle( void );
	void				Event_FindTargets( void );
};


// bdube: jump pads
/*
===============================================================================

  rvJumpPad

===============================================================================
*/

class rvJumpPad : public idForceField {
public:
	CLASS_PROTOTYPE( rvJumpPad );

	rvJumpPad ( void );

	void				Spawn( void );
	void				Think( void );

private:

	int					lastEffectTime;

	void				Event_FindTargets( void );

	enum {
		EVENT_JUMPFX = idEntity::EVENT_MAXEVENTS,
		EVENT_MAXEVENTS
	};
	bool				ClientReceiveEvent( int event, int time, const idBitMsg &msg );

	idMat3				effectAxis;
};


/*
===============================================================================

  idAnimated

===============================================================================
*/

class idAnimated : public idAFEntity_Gibbable {
public:
	CLASS_PROTOTYPE( idAnimated );

							idAnimated();
							~idAnimated();

	void					Save( idSaveGame *savefile ) const;
	void					Restore( idRestoreGame *savefile );

	void					Spawn( void );
	virtual bool			LoadAF( const char* keyname );
	bool					StartRagdoll( void );
	virtual bool			GetPhysicsToSoundTransform( idVec3 &origin, idMat3 &axis );


// bdube: script 
	void					Think ( void );
	
	virtual	void			Damage( idEntity *inflictor, idEntity *attacker, const idVec3 &dir, const char *damageDefName, const float damageScale, const int location );
 	virtual bool			ShouldConstructScriptObjectAtSpawn( void ) const;


private:
	int						num_anims;
	int						current_anim_index;
	int						anim;
	int						blendFrames;
	jointHandle_t			soundJoint;
	idEntityPtr<idEntity>	activator;
	bool					activated;


// bdube: script variables
	// script control
	idThread *				scriptThread;
	idStr					state;
	idStr					idealState;
	int						animDoneTime[ANIM_NumAnimChannels];

	// Script state management
	void					UpdateScript( void );
	void					SetState( const char *statename, int blend );
	void					CallHandler ( const char* handler );


	void					PlayNextAnim( void );

	void					Event_Activate( idEntity *activator );	
	void					Event_Start( void );
	void					Event_StartRagdoll( void );
	void					Event_AnimDone( int animIndex );
	void					Event_Footstep( void );
	void					Event_LaunchMissiles( const char *projectilename, const char *sound, const char *launchjoint, const char *targetjoint, int numshots, int framedelay );
	void					Event_LaunchMissilesUpdate( int launchjoint, int targetjoint, int numshots, int framedelay );


// kfuller: added
	void					Event_SetAnimState( const char* state, int blendframes );
	void					Event_PlayAnim( int channel, const char *animname );
	void					Event_PlayCycle( int channel, const char *animname );
	void					Event_AnimDone2( int channel, int blendFrames );
	
};

/*
===============================================================================

  idStaticEntity

===============================================================================
*/

class idStaticEntity : public idEntity {
public:
	CLASS_PROTOTYPE( idStaticEntity );

						idStaticEntity( void );

	void				Save( idSaveGame *savefile ) const;
	void				Restore( idRestoreGame *savefile );

	void				Spawn( void );
	void				ShowEditingDialog( void );
	virtual void		Hide( void );
	virtual void		Show( void );
	void				Fade( const idVec4 &to, float fadeTime );
	virtual void		Think( void );

	virtual void		WriteToSnapshot( idBitMsgDelta &msg ) const;
	virtual void		ReadFromSnapshot( const idBitMsgDelta &msg );

private:
	void				Event_Activate( idEntity *activator );

	int					spawnTime;
	bool				active;
	idVec4				fadeFrom;
	idVec4				fadeTo;
	int					fadeStart;
	int					fadeEnd;
	bool				runGui;
};


/*
===============================================================================

idFuncEmitter

===============================================================================
*/

class idFuncEmitter : public idStaticEntity {
public:
	CLASS_PROTOTYPE( idFuncEmitter );

						idFuncEmitter( void );

	void				Save( idSaveGame *savefile ) const;
	void				Restore( idRestoreGame *savefile );

	void				Spawn( void );
	void				Event_Activate( idEntity *activator );

	virtual void		WriteToSnapshot( idBitMsgDelta &msg ) const;
	virtual void		ReadFromSnapshot( const idBitMsgDelta &msg );

private:
	bool				hidden;

};


/*
===============================================================================

idLocationEntity

===============================================================================
*/

class idLocationEntity : public idEntity {
public:
	CLASS_PROTOTYPE( idLocationEntity );

	void				Spawn( void );

	const char *		GetLocation( void ) const;

private:
};

class idLocationSeparatorEntity : public idEntity {
public:
	CLASS_PROTOTYPE( idLocationSeparatorEntity );

	void				Spawn( void );

private:
};

class idVacuumSeparatorEntity : public idEntity {
public:
	CLASS_PROTOTYPE( idVacuumSeparatorEntity );

						idVacuumSeparatorEntity( void );

	void				Spawn( void );

	void				Save( idSaveGame *savefile ) const;
	void				Restore( idRestoreGame *savefile );

	void				Event_Activate( idEntity *activator );	

private:
	qhandle_t			portal;
};

class idVacuumEntity : public idEntity {
public:
	CLASS_PROTOTYPE( idVacuumEntity );

	void				Spawn( void );

private:
};


// abahr
class rvGravitySeparatorEntity : public idEntity {
public:
	CLASS_PROTOTYPE( rvGravitySeparatorEntity );

						rvGravitySeparatorEntity( void );

	void				Spawn( void );

	void				Save( idSaveGame *savefile ) const;
	void				Restore( idRestoreGame *savefile );

	void				Event_Activate( idEntity *activator );	

private:
	qhandle_t			portal;
};

class rvGravityArea : public idEntity {
public:
	ABSTRACT_PROTOTYPE( rvGravityArea );

	void					Spawn( void );

	virtual int				GetArea() const { return area; }
	virtual const idVec3	GetGravity( const idVec3& origin, const idMat3& axis, int clipMask, idEntity* passEntity ) const = 0;
	virtual const idVec3	GetGravity( const idEntity* ent ) const = 0;
	virtual const idVec3	GetGravity( const rvClientEntity* ent ) const = 0;

	void					Save( idSaveGame *savefile ) const;
	void					Restore( idRestoreGame *savefile );

	bool					IsEqualTo( const rvGravityArea* area ) const;
	bool					operator==( const rvGravityArea* area ) const;
	bool					operator==( const rvGravityArea& area ) const;
	bool					operator!=( const rvGravityArea* area ) const;
	bool					operator!=( const rvGravityArea& area ) const;

protected:
	int						area;
};

class rvGravityArea_Static : public rvGravityArea {
public:
	CLASS_PROTOTYPE( rvGravityArea_Static );

	void					Spawn( void );

	virtual const idVec3	GetGravity( const idVec3& origin, const idMat3& axis, int clipMask, idEntity* passEntity ) const { return gravity; }
	virtual const idVec3	GetGravity( const idEntity* ent ) const { return gravity; }
	virtual const idVec3	GetGravity( const rvClientEntity* ent ) const { return gravity; }

	void					Save( idSaveGame *savefile ) const;
	void					Restore( idRestoreGame *savefile );

protected:
	idVec3					gravity;
};

class rvGravityArea_SurfaceNormal : public rvGravityArea {
public:
	CLASS_PROTOTYPE( rvGravityArea_SurfaceNormal );

	virtual const idVec3	GetGravity( const idVec3& origin, const idMat3& axis, int clipMask, idEntity* passEntity ) const;
	virtual const idVec3	GetGravity( const idEntity* ent ) const;
	virtual const idVec3	GetGravity( const rvClientEntity* ent ) const;

protected:
	virtual const idVec3	GetGravity( const idPhysics* physics ) const;
};


/*
===============================================================================

  idFuncPortal

===============================================================================
*/

class idFuncPortal : public idEntity {
public:
	CLASS_PROTOTYPE( idFuncPortal );
			
						idFuncPortal();

	void				Spawn( void );

	void				Save( idSaveGame *savefile ) const;
	void				Restore( idRestoreGame *savefile );

private:
	qhandle_t			portal;
	bool				state;

	void				Event_Activate( idEntity *activator );
};


#endif /* !__GAME_MISC_H__ */
