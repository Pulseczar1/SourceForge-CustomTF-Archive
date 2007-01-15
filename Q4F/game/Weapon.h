
// bdube: note that this file is no longer merged with Doom3 updates
//
// MERGE_DATE 9/30/2004

#ifndef __GAME_WEAPON_H__
#define __GAME_WEAPON_H__

/*
===============================================================================

	Player Weapon
	
===============================================================================
*/

typedef enum {
	WP_READY,
	WP_OUTOFAMMO,
	WP_RELOAD,
	WP_RELOADDONE,
	WP_HOLSTERED,
	WP_RISING,
	WP_LOWERING,
	WP_FLASHLIGHT,
} weaponStatus_t;

static const int MAX_AMMOTYPES	= 16;

class idPlayer;
class idItem;
class idAnimatedEntity;
class idProjectile;

class rvWeapon;

class rvViewWeapon : public idAnimatedEntity {
public:

	CLASS_PROTOTYPE( rvViewWeapon );

							rvViewWeapon( void );
	virtual					~rvViewWeapon( void );

	// Init
	void					Spawn						( void );

	// save games
	void					Save						( idSaveGame *savefile ) const;					// archives object for save game file
	void					Restore						( idRestoreGame *savefile );					// unarchives object from save game file


	// Weapon definition management
	void					Clear						( void );

	// GUIs
	void					PostGUIEvent				( const char* event );

	virtual void			SetModel					( const char *modelname );
	void					SetPowerUpSkin				( const char *name );
	void					UpdateSkin					( void );

	// State control/player interface
	void					Think						( void );

	// Visual presentation
	void					PresentWeapon				( int ui_showgun );

	// Networking
	virtual void			WriteToSnapshot				( idBitMsgDelta &msg ) const;
	virtual void			ReadFromSnapshot			( const idBitMsgDelta &msg );
	virtual bool			ClientReceiveEvent			( int event, int time, const idBitMsg &msg );
	virtual void			ClientPredictionThink		( void );
	virtual bool			ClientStale					( void );

	virtual void			ConvertLocalToWorldTransform( idVec3 &offset, idMat3 &axis );
	virtual void			UpdateModelTransform		( void );

	// Debugging
	virtual void			GetDebugInfo				( debugInfoProc_t proc, void* userData );


	void					SetSkin						( const char *skinname );
	void					SetSkin						( const idDeclSkin* skin );

	void					SetOverlayShader			( const idMaterial* material );

	virtual void			GetPosition					( idVec3& origin, idMat3& axis ) const;

private:

	idStrList				pendingGUIEvents;

	// effects
	const idDeclSkin *		saveSkin;
	const idDeclSkin *		invisSkin;
	const idDeclSkin *		saveWorldSkin;
	const idDeclSkin *		worldInvisSkin;
	const idDeclSkin *		saveHandsSkin;
	const idDeclSkin *		handsSkin;
		
	void					Event_CallFunction			( const char* function );
	
	friend		class rvWeapon;
	rvWeapon*	weapon;
};

class rvWeapon : public idClass {
public:

	CLASS_PROTOTYPE( rvWeapon );

	rvWeapon( void );
	virtual ~rvWeapon( void );
	
	enum {
		WPLIGHT_MUZZLEFLASH,
		WPLIGHT_MUZZLEFLASH_WORLD,
		WPLIGHT_FLASHLIGHT,
		WPLIGHT_FLASHLIGHT_WORLD,
		WPLIGHT_GUI,
		WPLIGHT_MAX
	};

	enum {
		EVENT_RELOAD = idEntity::EVENT_MAXEVENTS,
		EVENT_ENDRELOAD,
		EVENT_CHANGESKIN,
		EVENT_MAXEVENTS
	};
	
	void				Init						( idPlayer* _owner, const idDeclEntityDef* def, int weaponIndex );

	// Virtual overrides
	void				Spawn						( void );
	virtual void		Think						( void );
	virtual void		CleanupWeapon				( void ) {}
	virtual void		WriteToSnapshot				( idBitMsgDelta &msg ) const;
	virtual void		ReadFromSnapshot			( const idBitMsgDelta &msg );
	virtual bool		ClientReceiveEvent			( int event, int time, const idBitMsg &msg );
	virtual void		ClientStale					( void );
	virtual void		Attack						( int num_attacks = 1, float fuseOffset = 0.0f, float power = 1.0f, float spreadScale = 1.0f );
	virtual void		GetDebugInfo				( debugInfoProc_t proc, void* userData );

	void				Save						( idSaveGame *savefile ) const;
	void				Restore						( idRestoreGame *savefile );
	virtual void		PreSave						( void );
	virtual void		PostSave					( void );


	// Visual presentation
	bool				BloodSplat					( float size );
	void				MuzzleFlash					( void );
	void				MuzzleRise					( idVec3 &origin, idMat3 &axis );
	void				WeaponRaiseLower			( idVec3 &origin, idMat3 &axis );
	float				GetMuzzleFlashLightParm		( int parm );
	void				SetMuzzleFlashLightParm		( int parm, float value );
	void				GetAngleOffsets				( int *average, float *scale, float *max );
	void				GetTimeOffsets				( float *time, float *scale );
	bool				GetGlobalJointTransform		( bool viewModel, const jointHandle_t jointHandle, idVec3 &origin, idMat3 &axis, const idVec3& offset = vec3_origin );

	// State control/player interface
	void				LowerWeapon					( void );
	void				RaiseWeapon					( void );
	void				Raise						( void );
	void				PutAway						( void );
	void				Hide						( void );
	void				Show						( void );
	void				HideWorldModel				( void );
	void				ShowWorldModel				( void );
	void				SetPushVelocity				( const idVec3 &pushVelocity );
	void				Reload						( void );
	void				OwnerDied					( void );
	void				BeginAttack					( void );
	void				EndAttack					( void );
	bool				IsReady						( void ) const;
	bool				IsReloading					( void ) const;
	bool				IsHolstered					( void ) const;
	bool				ShowCrosshair				( void ) const;
	void				CancelReload				( void );
	void				SetStatus					( weaponStatus_t status );
	bool				AutoReload					( void );
	bool				IsHidden					( void ) const;
	void				EjectBrass					( void );

	// Network helpers
	void				NetReload					( void );
	void				NetEndReload				( void );
	void				NetCatchup					( void ) { SetState( WEAP_STATE_IDLE ); };

	// Ammo
	static int			GetAmmoIndexForName			( const char *ammoname );
	static const char*	GetAmmoNameForIndex			( int index );
	int					GetAmmoType					( void ) const;
	int					AmmoAvailable				( void ) const;
	int					AmmoInClip					( void ) const;
	void				ResetAmmoClip				( void );
	int					ClipSize					( void ) const;
	int					LowAmmo						( void ) const;
	int					AmmoRequired				( void ) const;
	void				AddToClip					( int amount );
	void				UseAmmo						( int amount );
	void				SetClip						( int amount );
	int					TotalAmmoCount				( void ) const;

	// Attack
	bool				PerformAttack				( idVec3& muzzleOrigin, idMat3& muzzleAxis, float dmgPower );
	virtual void		LaunchProjectiles			( const idVec3& muzzleOrigin, int num_projectiles, float fuseOffset, float power = 1.0f, float spreadScale = 1.0f );
	void				Hitscan						( const idVec3& muzzleOrigin, int num_hitscans, float power = 1.0f, float spreadScale = 1.0f );

	rvViewWeapon*		GetViewModel				( void ) const;
	idAnimatedEntity*	GetWorldModel				( void ) const;
	idPlayer*			GetOwner					( void ) const;
	const char *		GetIcon						( void ) const;
	renderLight_t&		GetLight					( int light );
	const idAngles&		GetViewModelAngles			( void ) const;
	void				GetViewModelOffset			( float fov, idVec3 &offset );

 	static void			CacheWeapon					( const char *weaponName );
	static void			SkipFromSnapshot			( const idBitMsgDelta &msg );

	virtual int			GetSpeedLimit				( void );
	virtual float		GetOwnerSpeed				( void );
	virtual float		OwnerHasGroundContacts		( void );

protected:

	virtual void		OnLaunchProjectile			( idProjectile* proj );

	void				PlayAnim					( int channel, const char *animname, int blendFrames = 4 );
	void				PlayCycle					( int channel, const char *animname, int blendFrames = 4 );
	bool				AnimDone					( int channel, int blendFrames = 4 );
	bool				StartSound					( const char *soundName, const s_channelType channel, int soundShaderFlags, bool broadcast, int *length );
	void				StopSound					( const s_channelType channel, bool broadcast );
	rvClientEffect*		PlayEffect					( const char* effectName, jointHandle_t joint, bool loop = false, const idVec3& endOrigin = vec3_origin, bool broadcast = false );

	void				FindViewModelPositionStyle	( int ui_showGun, idVec3& viewOffset, idAngles& viewAngles ) const;

public:

	void				InitLights					( void );
	void				InitWorldModel				( void );
	void				InitViewModel				( void );
	void				InitDefs					( void );

	const char*			GetAnimPrefix				( void ) { return disguiseWeapDef ? disguiseWeapDef->dict.GetString( "animPrefix", "" ) : spawnArgs.GetString( "animPrefix", "" ); };

	int					disguiseClass;
	ENTDEF				disguiseWeapDef;

	void				FreeLight					( int lightID );
	void				UpdateLight					( int lightID );

	void				UpdateMuzzleFlash			( void );
	void				UpdateFlashlight			( void );	

	void				UpdateGUI					( void );
	void				UpdateCrosshairGUI			( idUserInterface* gui ) const;

	idMat3				ForeshortenAxis				( const idMat3& axis ) const;

	// Script state management
	struct weaponStateFlags_s {
		bool		attack				:1;
		bool		reload				:1;
		bool		netReload			:1;
		bool		netEndReload		:1;
		bool		raiseWeapon			:1;
		bool		lowerWeapon			:1;
		bool		attackPressed		:1;
		bool		reloading			:1;
	} wsfl;		
	
	// Generic flags
	struct weaponFlags_s {
		bool		attackHitscan		:1;
		bool		hide				:1;
		bool		disabled			:1;
		bool		hasBloodSplat		:1;
		bool		viewshake			:1;
		bool		hasWindupAnim		:1;
	} wfl;
	
	// joints from models
	jointHandle_t					barrelJointView;
	jointHandle_t					flashJointView;
	jointHandle_t					ejectJointView;
	jointHandle_t					guiLightJointView;
	jointHandle_t					flashlightJointView;

	jointHandle_t					flashJointWorld;
	jointHandle_t					ejectJointWorld;
	jointHandle_t					flashlightJointWorld;

	jointHandle_t					attackJoint0;
	jointHandle_t					attackJoint1;

	rvClientEntityPtr<rvClientEffect>					idleEffectWorld;
	rvClientEntityPtr<rvClientEffect>					fireEffectWorld;
	rvClientEntityPtr<rvClientEffect>					idleEffectView;
	rvClientEntityPtr<rvClientEffect>					fireEffectView;

	
	weaponStatus_t					status;
	int								lastAttack;

	// <q4f> 
	int								num_attacks;

	// </q4f>

	// hiding weapon
	int								hideTime;
 	float							hideDistance;
 	int								hideStartTime;
	float							hideStart;
	float							hideEnd;
	float							hideOffset;

	// Attack
	idVec3							pushVelocity;
	int								kick_endtime;
	int								muzzle_kick_time;
	int								muzzle_kick_maxtime;
	idAngles						muzzle_kick_angles;
	idVec3							muzzle_kick_offset;
	idVec3							muzzleOrigin;
	idMat3							muzzleAxis;
	float							muzzleOffset;
	idEntityPtr<idEntity>			projectileEnt;
	idVec3							ejectOffset;


	float							lowerAmount;
	int								raiselower_endtime;
	int								raiselower_time;
	idAngles						lower_weapon_angles;
	idVec3							lower_weapon_offset;

	int								fireRate;
	int								nextAttackTime;
	idVec2							spread;

	// we maintain local copies of the projectile and brass dictionaries so they
	// do not have to be copied across the DLL boundary when entities are spawned

	// <q4f> 

	// 3j: the damage def is now loaded at weapon init
	const idDeclEntityDef*			attackDef;		// projectile, hitscan, melee

	idDict							brassDict;

	float							guiPercent;

	// </q4f>
	

	// Melee
	float							meleeDistance;

	// lights
	renderLight_t					lights[WPLIGHT_MAX];
	int								lightHandles[WPLIGHT_MAX];
	idVec3							guiLightOffset;	
	int								muzzleFlashEnd;
	int								muzzleFlashTime;
	idVec3							muzzleFlashViewOffset;
	bool							flashlightOn;
	idVec3							flashlightViewOffset;	

	// ammo management
	int								ammoType;
	int								ammoRequired;		// amount of ammo to use each shot.  0 means weapon doesn't need ammo.

	int								lowAmmo;			// if ammo in clip hits this threshold, snd_
	int								maxAmmo;		

	// these are the player render view parms, which include bobbing
	idVec3							playerViewOrigin;
	idMat3							playerViewAxis;


	// View Model
	idVec3							viewModelOrigin;
	idMat3							viewModelAxis;
	idAngles						viewModelAngles;
	idVec3							viewModelOffset;

	int								oldShowWeap;

	// weighting for viewmodel offsets 
	int								weaponAngleOffsetAverages;
	float							weaponAngleOffsetScale;
	float							weaponAngleOffsetMax;
	float							weaponOffsetTime;
	float							weaponOffsetScale;

	// General
	idStr							icon;

	bool							forceGUIReload;

public:

	idDict							spawnArgs;

protected:

	idEntityPtr<rvViewWeapon>		viewModel;
	idAnimator*						viewAnimator;
	idEntityPtr<idAnimatedEntity>	worldModel;
	idAnimator*						worldAnimator;
	const idDeclEntityDef*			weaponDef;
	idScriptObject*					scriptObject;
	idPlayer *						owner;
	int								weaponIndex;

	float								viewModelForeshorten;
	float								viewModelForeshortenCurrent;

	int								animDoneTime[ANIM_NumAnimChannels];

	int								reloadTime;
	int								nextReloadTime;

	AttackerInfo					attackerInfo;

	// args cache
	const char*						mtr_crosshair;
	const idMaterial*				crossMaterial;
	idVec3							dirOffset;
	idVec3							fxOriginOffset;

protected:

		enum {
		WEAP_STATE_RAISE = 0,
		WEAP_STATE_LOWER,
		WEAP_STATE_IDLE,
		WEAP_STATE_FIRE,
		WEAP_STATE_RELOAD,
		WEAP_MAX_STATES
	};

	virtual void			UpdateState( void );

	virtual void			State_Raise( void );
	virtual void			State_Lower( void );
	virtual void			State_Idle( void );
	virtual void			State_Fire( void );
	virtual void			State_Reload( void );

	void					SetState( int newStateNum ) { currentState = newStateNum; SetStage( 0 ); };
	void					SetStage( int newStageNum ) { currentStage = newStageNum; };

	void					StateError( const char* msg );


	virtual void			AttackPressed( void );
	virtual void			AttackHeld( void );
	virtual void			AttackReleased( void ) {};

	int						currentState;
	int						currentStage;

	virtual float			GetWeaponPower( void ) { return 1.0f; };
};

ID_INLINE rvViewWeapon* rvWeapon::GetViewModel ( void ) const {
	return viewModel.GetEntity();
}

ID_INLINE idAnimatedEntity* rvWeapon::GetWorldModel ( void ) const {
	return worldModel;
}

ID_INLINE idPlayer* rvWeapon::GetOwner ( void ) const {
	return owner;
}

ID_INLINE const char* rvWeapon::GetIcon ( void ) const {
	return icon;
}

ID_INLINE renderLight_t& rvWeapon::GetLight ( int light ) {
	assert ( light < WPLIGHT_MAX );
	return lights[light];	
}

ID_INLINE const idAngles& rvWeapon::GetViewModelAngles( void ) const {
	return viewModelAngles;
}

static float vmProp = 2.0f;
static float pProp = 0.14f;

ID_INLINE void rvWeapon::GetViewModelOffset ( float fov, idVec3 &offset ) {
	offset = viewModelOffset;
	if ( fov > 75.0f ) {
		//offset.x += ( ( 90.0f - fov ) * pProp );
		viewModelForeshortenCurrent = viewModelForeshorten * ( 90.0f / fov )/* * vmProp*/;
	}
}

ID_INLINE void rvWeapon::PreSave ( void ) {
}

ID_INLINE void rvWeapon::PostSave ( void ) {
}

#endif /* !__GAME_WEAPON_H__ */


