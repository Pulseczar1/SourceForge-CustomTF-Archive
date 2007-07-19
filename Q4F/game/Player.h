
// bdube: note that this file is no longer merged with Doom3 updates
//
// MERGE_DATE 07/07/2004

#ifndef __GAME_PLAYER_H__
#define __GAME_PLAYER_H__

#include "Projectile.h"

/*
===============================================================================

	Player entity.
	
===============================================================================
*/

extern const idEventDef EV_Player_GetButtons;
extern const idEventDef EV_Player_GetMove;
extern const idEventDef EV_Player_GetViewAngles;
extern const idEventDef EV_Player_SetViewAngles;
extern const idEventDef EV_Player_EnableWeapon;
extern const idEventDef EV_Player_DisableWeapon;
extern const idEventDef EV_Player_ExitTeleporter;
extern const idEventDef EV_Player_SelectWeapon;
extern const idEventDef EV_Player_Freeze;
extern const idEventDef EV_SpectatorTouch;
extern const idEventDef EV_Player_SetArmor;
extern const idEventDef EV_Player_SetExtraProjPassEntity;
extern const idEventDef EV_Player_DamageEffect;

#define MAX_CONCURRENT_VOICES	3

// <q4f> 

#define MAX_DROPAMMOS 4

#define AMMO_SHELLS_INDEX 1
#define AMMO_NAILS_INDEX 2
#define AMMO_ROCKETS_INDEX 3
#define AMMO_CELLS_INDEX 4
#define AMMO_GREN1_INDEX 5
#define AMMO_GREN2_INDEX 6
#define AMMO_DETPACK_INDEX 7

#define FIRE_PROJ_HEIGHT_STANDING 58.0f;
#define FIRE_PROJ_HEIGHT_CROUCHED 29.0f;

#define NUM_LOGGED_POSITIONS 15

// </q4f>


//++ GTR bandit: Unlagged Code
// the size of history we'll keep
#define NUM_CLIENT_HISTORY 15 // 15 * 16ms = 240ms (maximum possible ping to compensate)

// everything we need to know to backward reconcile
typedef struct {
	idVec3			origin;
	idTraceModel	traceModel;
} historyData_t;

typedef struct {
	int				lastFrame;
	int				head;						// the head of the history queue
	historyData_t	data[NUM_CLIENT_HISTORY];	// the history queue
	historyData_t	savedData;					// the client's saved position
												// used to restore after frame shift
	bool			isSaved;
} clientHistory_t;
//-- GTR bandit: Unlagged Code


const float THIRD_PERSON_FOCUS_DISTANCE	= 512.0f;
const int	LAND_DEFLECT_TIME			= 150;
const int	LAND_RETURN_TIME			= 300;
const int	FOCUS_TIME					= 200;
const int	FOCUS_GUI_TIME				= 300;
const int	FOCUS_USABLE_TIME			= 100;

const int	MAX_WEAPONS					= 4;
const int	MAX_AMMO					= 8;

const int	MAX_SKILL_LEVELS			= 4;

const int	ZERO_VOLUME					= -40;			// volume at zero
const int	DMG_VOLUME					= 5;			// volume when taking damage
const int	DEATH_VOLUME				= 15;			// volume at death

const int	SAVING_THROW_TIME			= 5000;			// maximum one "saving throw" every five seconds

#define MAX_AMOUNT_PER_AMMO				500
#define MAX_AMOUNT_IN_CLIP				8			// no guns have a clip larger than 8
#define MAX_HEALTH						200
#define MAX_ARMOR						500

#define MAX_TFITEMS						10			// max # of carryable tf items

const int	ASYNC_PLAYER_INV_AMMO_BITS = -( idMath::BitsForInteger( MAX_AMOUNT_PER_AMMO ) + 1 );
const int	ASYNC_PLAYER_INV_CLIP_BITS = idMath::BitsForInteger( MAX_AMOUNT_IN_CLIP );
const int	ASYNC_PLAYER_INV_AMMOTYPE_BITS = idMath::BitsForInteger( MAX_AMMO );
const int	ASYNC_PLAYER_INV_WEAPON_BITS = idMath::BitsForInteger( MAX_WEAPONS );
const int	ASYNC_PLAYER_INV_ITEMS_BITS = idMath::BitsForInteger( MAX_TFITEMS );
const int	ASYNC_PLAYER_INV_ARMOR_BITS = idMath::BitsForInteger( MAX_ARMOR );
const int	ASYNC_PLAYER_INV_HEALTH_BITS = -( idMath::BitsForInteger( MAX_HEALTH ) + 1 );

const int	IMPULSE_NUMBER_OF_BITS		= 6;

typedef struct {
	bool		visible;
	int			lastCalcTime;
	float		xRel;
	float		yRel;
	float		yaw;
} playerRadarPos_t;

typedef struct {
	int		time;
	idVec3	org;
	idMat3	axis;
} loggedPosition_t;

typedef struct {
	int		time;
	idVec3	dir;		// scaled larger for running
} loggedAccel_t;

typedef enum {
	PE_NONE,
	PE_GRAB_A,
	PE_GRAB_B,
	PE_SALUTE,
	PE_CHEER,
	PE_TAUNT
} playerEmote_t;

class idInventory {
public:
	int						maxHealth;
	int						armor;
	int						maxarmor;
	int						ammo[ MAX_AMMO ];
	int						clip[ MAX_WEAPONS ];
	int						clipSizes[ MAX_WEAPONS ];

	int						minigunAttackEnd;

 	// multiplayer
 	int						ammoPredictTime;
	int						ammoIndices[ MAX_WEAPONS ];

							idInventory() { Clear(); }
							~idInventory() { Clear(); }

	// save games
	void					Save( idSaveGame *savefile ) const;					// archives object for save game file
	void					Restore( idRestoreGame *savefile );					// unarchives object from save game file

	void					Clear( void );

	void					GetPersistantData( idDict &dict );
	void					RestoreInventory( idPlayer *owner, const idDict &dict );
	bool					Give( idPlayer *owner, const idDict &spawnArgs, const char *statname, const char *value, int *idealWeapon, bool updateHud, bool dropped = false, bool checkOnly = false );
	int						AmmoIndexForAmmoClass( const char *ammo_classname ) const;
	const char*				AmmoClassForAmmoIndex( int index ) const;
	int						MaxAmmoForAmmoClass( idPlayer *owner, const char *ammo_classname ) const;
	int						AmmoIndexForWeaponClass( const char *weapon_classname, int *ammoRequired = NULL );
	const char *			AmmoClassForWeaponClass( const char *weapon_classname);

	int						HasAmmo( int index, int amount );
	bool					UseAmmo( int index, int amount );
	int						HasAmmo( const char *weapon_classname );			// looks up the ammo information for the weapon class first

	// <q4f> 
	bool					GiveTFItem( TFCarryItem* item );
	void					RemoveTFItem( TFCarryItem* item );
	idList<TFCarryItem*>	tfitems;


	// </q4f>
};

class idPlayer : public idActor {
public:
 	
 	enum {
 		EVENT_IMPULSE = idEntity::EVENT_MAXEVENTS,
 		EVENT_EXIT_TELEPORTER,
 		EVENT_ABORT_TELEPORTER,
 		EVENT_SPECTATE,
		EVENT_EMOTE,
 		EVENT_MAXEVENTS
 	};

	friend class idThread;

	usercmd_t				usercmd;

	class idPlayerView		playerView;			// handles damage kicks and effects

	bool					noclip;
	bool					godmode;
	int						godmodeDamage;

	bool					spawnAnglesSet;		// on first usercmd, we must set deltaAngles
	idAngles				spawnAngles;
	idAngles				viewAngles;			// player view angles
	idAngles				cmdAngles;			// player cmd angles

	int						buttonMask;
	int						oldButtons;
	int						oldFlags;

	int						lastHitTime;			// last time projectile fired by player hit target

	struct playerFlags_s {
		bool		forward			:1;
		bool		backward		:1;
		bool		strafeLeft		:1;
		bool		strafeRight		:1;
		bool		attackHeld		:1;
		bool		weaponFired		:1;
		bool		jump			:1;
		bool		crouch			:1;
		bool		onGround		:1;
		bool		onLadder		:1;
		bool		dead			:1;
		bool		run				:1;
		bool		pain			:1;
		bool		hardLanding		:1;
		bool		softLanding		:1;
		bool		reload			:1;
		bool		teleport		:1;
		bool		turnLeft		:1;
		bool		turnRight		:1;
		bool		hearingLoss		:1;
		bool		objectiveFailed	:1;
		bool		noFallingDamage :1;
		bool		inWater			:1;
	} pfl;
		
	// inventory
	idInventory				inventory;

	rvWeapon*						weapon;
	bool							weaponRunning;

	idEntityPtr<rvViewWeapon>		weaponViewModel;
	idEntityPtr<idAnimatedEntity>	weaponWorldModel;
	const idDeclEntityDef*			weaponDef;


 	idUserInterface *		hud;				// Common hud
	idUserInterface *		mphud;				// hud overlay containing MP elements
	
	bool					disableHud;

	int						lastDmgTime;
	int						deathClearContentsTime;
 	bool					doingDeathSkin;
	int						nextHealthPulse;	// time when health will tick down
	int						nextArmorPulse;		// time when armor will tick down
	bool					hiddenWeapon;		// if the weapon is hidden ( in noWeapons maps )

	// mp stuff
	int						spectator;

	bool					scoreBoardOpen;
	bool					forceScoreBoard;
	bool					forceRespawn;
	int						forceScoreBoardTime;

	bool					spectating;
	bool					lastHitToggle;
	bool					lastArmorHit;
	
	bool					wantSpectate;			// from userInfo
	bool					jumpDuringHitch;

 	bool					weaponGone;				// force stop firing
 	bool					isLagged;				// replicated from server, true if packets haven't been received from client.
 	bool					isChatting;				// replicated from server, true if the player is chatting.

	int						lastSpectateTeleport;
 	int						spawnedTime;			// when client first enters the game

 	idEntityPtr<idEntity>	teleportEntity;			// while being teleported, this is set to the entity we'll use for exit
	int						teleportKiller;			// entity number of an entity killing us at teleporter exit

	idEntityPtr<idPlayer>	lastKiller;

	// timers
	int						minRespawnTime;			// can respawn when time > this, force after g_forcerespawn
	int						maxRespawnTime;			// force respawn after this time

	// the first person view values are always calculated, even
	// if a third person view is used
	idVec3					firstPersonViewOrigin;
	idMat3					firstPersonViewAxis;

	// <q4f> 

	idMat3					weaponViewAxis;

	// </q4f>
	
	idDragEntity			dragEntity;

	idEntityPtr<idEntity>	extraProjPassEntity;
	
	bool					vsMsgState;

	//++ GTR bandit: Unlagged Code
private:
	clientHistory_t			clientHistory;

	void					ResetHistory( void );
	void					StoreHistory( void );
	void					GetClipModel ( historyData_t &historyData );
	void					SetClipModel ( const historyData_t &historyData );

public:
	void					Delag ( int frameOffset = -1 );
	void					UndoDelag ( bool justSelf = false );
	//-- GTR bandit: Unlagged Code

public:
	CLASS_PROTOTYPE( idPlayer );

							idPlayer();
	virtual					~idPlayer();

	void					Spawn( void );
	void					Think( void );

	// save games
	void					Save( idSaveGame *savefile ) const;					// archives object for save game file
	void					Restore( idRestoreGame *savefile );					// unarchives object from save game file

	static const char*		GetSpawnClassname ( void );

	virtual void			Hide( void );
	virtual void			Show( void );

	void					Init( void );
 	void					PrepareForRestart( void );
 	virtual void			Restart( void );
	void					SetWeapon ( int weapon );
	void					SetupWeaponEntity( void );
	bool					SelectSpawnPoint( idVec3 &origin, idAngles &angles );
	bool					SpawnFromSpawnSpot( void );
	void					SpawnToPoint( const idVec3	&spawn_origin, const idAngles &spawn_angles );
	void					SetClipModel( bool forceSpectatorBBox = false );	// spectator mode uses a different bbox size

	void					SavePersistantInfo( void );
	void					RestorePersistantInfo( void );

 	bool					UserInfoChanged( void );
	idDict *				GetUserInfo( void );

// shouchard:  BalanceTDM->BalanceTeam (now used for CTF as well as TDM)
	bool					BalanceTeam( void );

	void					CacheWeapons( void );

 	bool					HandleESC( void );
   	void					EnterCinematic( void );
   	void					ExitCinematic( void );
 	bool					SkipCinematic( void );

	void					UpdateConditions( void );
	void					SetViewAngles( const idAngles &angles );

							// delta view angles to allow movers to rotate the view of the player
	void					UpdateDeltaViewAngles( const idAngles &angles );

	virtual bool			Collide( const trace_t &collision, const idVec3 &velocity );

	virtual bool			CanPlayImpactEffect ( idEntity* attacker, idEntity* target );
	virtual void			AddDamageEffect( const trace_t &collision, const idVec3 &velocity, const char *damageDefName, idEntity* inflictor );
	virtual void			ProjectHeadOverlay( const idVec3 &point, const idVec3 &dir, float size, const char *decal );
 							// use exitEntityNum to specify a teleport with private camera view and delayed exit
 	virtual void			Teleport( const idVec3 &origin, const idAngles &angles, idEntity *destination );

	virtual void			GetDebugInfo ( debugInfoProc_t proc, void* userData );

	virtual bool			CanDamage( const idVec3 &origin, idVec3 &damagePoint, idEntity *ignoreEnt );

 	void					Kill( bool delayRespawn, bool nodamage );

	renderView_t *			GetRenderView( void );
	void					SmoothenRenderView( bool firstPerson );
	void					CalculateRenderView( void );	// called every tic by player code
	void					CalculateFirstPersonView( void );
	
	void					DrawShadow( renderEntity_t *headRenderEnt );
	void					DrawHUD( idUserInterface *hud );
	void					StartRadioChatter ( void );
	void					StopRadioChatter ( void );

	void					WeaponFireFeedback( const idDict *weaponDef );

 	float					DefaultFov( void ) const;
 	float					CalcFov( void);
	void					CalculateViewWeaponPos( idVec3 &origin, idMat3 &axis );
	void					GetViewPos( idVec3 &origin, idMat3 &viewAxis ) const;
 	void					OffsetThirdPersonView( float angle, float range, float height, bool clip );

	bool					OffsetThirdPersonTargetView		( void );

	bool					Give( const char *statname, const char *value, bool dropped = false );
	
	// Helper methods to retrieving dictionaries
	const idDeclEntityDef*	GetWeaponDef				( int weaponIndex );

	int						SlotForWeapon				( const char *weaponName );

	idAngles				GunTurningOffset( int avgCount, float offSetScale, float offsetMax );


// abahr:
	bool					WeaponIsEnabled				( void ) const { return weaponEnabled; }
	void					ShowCrosshair				( void );
	void					HideCrosshair				( void );

	void					Reload						( void );
	void					NextWeapon					( void );
	void					NextBestWeapon				( void );
	void					PrevWeapon					( void );
	void					LastWeapon					( void );
 	void					SelectWeapon				( int num, bool force );
	void					SelectWeapon				( const char * );

	void					SetLastHitTime				( int time, bool armorHit );
 	void					LowerWeapon					( void );
 	void					RaiseWeapon					( void );
 	void					WeaponLoweringCallback		( void );
 	void					WeaponRisingCallback		( void );
 	bool					CanShowWeaponViewmodel		( void ) const;

	virtual bool			HandleSingleGuiCommand( idEntity *entityGui, idLexer *src );
	bool					GuiActive( void ) { return false; };

	void					PerformImpulse( int impulse );
	void					Spectate( bool spectate, bool force = false );
 	void					ToggleScoreboard( void );
	void					RouteGuiMouse( idUserInterface *gui );
 	void					UpdateHud( void );
	idUserInterface*		GetHud();
	const idUserInterface*	GetHud() const;
	void					SetPrivateCameraView( idCamera *camView );
	idCamera *				GetPrivateCameraView( void ) const { return privateCameraView; }
 	void					UpdateHudWeapon( int displayWeapon=-1 );
 	void					UpdateHudStats( idUserInterface *hud );
	void					UpdateHudBuildables( idUserInterface *hud );
 	void					UpdateHudAmmo( idUserInterface *hud );

	idVec3					GetEyePosition ( void ) const;

	void					LocalClientPredictionThink( void );
	void					NonLocalClientPredictionThink( void );
	virtual void			ClientPredictionThink( void );
	virtual void			WriteToSnapshot( idBitMsgDelta &msg ) const;
	virtual void			ReadFromSnapshot( const idBitMsgDelta &msg );
	void					WritePlayerStateToSnapshot( idBitMsgDelta &msg ) const;
	void					ReadPlayerStateFromSnapshot( const idBitMsgDelta &msg );

	virtual bool			ClientStale( void );
	virtual void			ClientUnstale( void );

	virtual bool			ServerReceiveEvent( int event, int time, const idBitMsg &msg );

	virtual bool			GetMasterPosition( idVec3 &masterOrigin, idMat3 &masterAxis ) const;
	virtual bool			GetPhysicsToVisualTransform( idVec3 &origin, idMat3 &axis );
	virtual bool			GetPhysicsToSoundTransform( idVec3 &origin, idMat3 &axis );

	virtual bool			ClientReceiveEvent( int event, int time, const idBitMsg &msg );
	
 	//bool					IsReady			( void );
 	bool					IsRespawning	( void );
 	bool					IsInTeleport	( void );
	bool					IsZoomed		( void );
	bool					IsFlashlightOn	( void );
	virtual bool			IsCrouching		( void ) const;
	
	// voice com muting
	bool					IsPlayerMuted	( idPlayer* player ) const;
	bool					IsPlayerMuted	( int clientNum ) const;
	void					MutePlayer		( idPlayer* player, bool mute );
	void					MutePlayer		( int clientNum, bool mute );
	

	// buddy list
	void					SetFriend		( idPlayer* player, bool isFriend );
	void					SetFriend		( int clientNum, bool isFriend );
	bool					IsFriend		( idPlayer* player ) const;
	bool					IsFriend		( int clientNum ) const;

	// time joined server
	int						GetConnectTime	( void ) const;
	void					SetConnectTime	( int time );

	// emotes
	void					SetEmote		( playerEmote_t emote );
    
	// rankings
	int						GetRank			( void ) const;
	void					SetRank			( int newRank );

	// server side work for in/out of spectate. takes care of spawning it into the world as well
	void					ServerSpectate( bool spectate );

	// for very specific usage. != GetPhysics()
	idPhysics				*GetPlayerPhysics( void );
 	void					TeleportDeath( int killer );

 	void					UpdateModelSetup( bool forceReload = false );

	bool					OnLadder( void ) const;

	rvViewWeapon*			GetWeaponViewModel	( void ) const;
	idAnimatedEntity*		GetWeaponWorldModel ( void ) const;
	int						GetCurrentWeapon	( void ) const;

	bool					IsGibbed			( void ) const;
	const idVec3&			GetGibDir			( void ) const;

	void					SetInitialHud ( void );

	void					RemoveClientModel ( const char* entityDefName );
	void					RemoveClientModels ( void );
	
	rvClientEntityPtr<rvClientModel> AddClientModel ( const char* entityDefName, const char* shaderName = NULL );

	void					ClientGib			( const idVec3& dir );
	void					ClientDamageEffects ( const idDict& damageDef, const idVec3& dir, int damage );


	void					ApplyImpulse( idEntity *ent, int id, const idVec3 &point, const idVec3 &impulse, bool splash = false );

	void					GUIMainNotice( const char* message, bool persist = false );
	void					GUIFragNotice( const char* message, bool persist = false );


	virtual idEntity*		GetGroundElevator( idEntity* testElevator=NULL ) const;
	
	int						GetWeaponIndex( const char* weaponName ) const;

	void					SetShowHud( bool showHud );
	bool					GetShowHud( void );


	// mekberg: wrap saveMessages
	void					SaveMessage( void );

	// mekberg: set pm_ cvars
	void					SetPMCVars( void );

	void					ForceScoreboard( bool force, int time );

	// call only on the local player
	idUserInterface*		GetCursorGUI( void );

	bool					AllowedVoiceDest( int from );

	static const int		NUM_LOGGED_VIEW_ANGLES = 16;		// for weapon turning angle offsets
	idAngles				loggedViewAngles[NUM_LOGGED_VIEW_ANGLES];	// [gameLocal.framenum&(LOGGED_VIEW_ANGLES-1)]

	int						showWeaponViewModel;

	//virtual idVec3			GetCenter( void ) const;

protected:
	void					SetupHead( const char* modelKeyName = "", idVec3 headOffset = idVec3(0, 0, 0) );

private:

	jointHandle_t			hipJoint;
	jointHandle_t			chestJoint;
	jointHandle_t			neckLeanJoint;

	idPhysics_Player		physicsObj;			// player physics

	idStr					modelName;			// current model name
	const idDict*			modelDict;

	int						bobFoot;
	float					bobFrac;
	float					bobfracsin;
	int						bobCycle;			// for view bobbing and footstep generation
	float					xyspeed;
	int						stepUpTime;
	float					stepUpDelta;
	float					idealLegsYaw;
	float					legsYaw;
 	bool					legsForward;
	float					oldViewYaw;
	idAngles				viewBobAngles;
	idVec3					viewBob;
	int						landChange;
	int						landTime;
	
	// ddynerman: we read fall deltas from spawnargs, cache them to save some lookups
	float					fatalFallDelta;
	float					hardFallDelta;
	float					softFallDelta;
	float					noFallDelta;

	int						currentWeapon;
	int						idealWeapon;
	int						previousWeapon;
	int						weaponSwitchTime;
	bool					weaponEnabled;


	rvClientEntityPtr<rvClientAFAttachment>	clientHead;



	bool					flashlightOn;
	bool					zoomed;

	bool					reloadModel;

	const idDeclSkin *		skin;
	const idDeclSkin *		weaponViewSkin;
	const idDeclSkin *		headSkin;

	const idDeclSkin *		gibSkin;

	bool					gibDeath;
	bool					gibsLaunched;
	idVec3					gibDir;

	idInterpolate<float>	zoomFov;
	bool					showCalcFov;

	idInterpolate<float>	centerView;

	idCamera *				privateCameraView;

	static const int		NUM_LOGGED_ACCELS = 16;			// for weapon turning angle offsets
	loggedAccel_t			loggedAccel[NUM_LOGGED_ACCELS];	// [currentLoggedAccel & (NUM_LOGGED_ACCELS-1)]
	int						currentLoggedAccel;

	int						demoViewAngleTime;
	idAngles					demoViewAngles;

	idUserInterface *		cursor;
	
	// full screen guis track mouse movements directly
	int						oldMouseX;
	int						oldMouseY;

	int						lastDamageDef;
	idVec3					lastDamageDir;
	int						lastDamageLocation;

	int						predictedFrame;
	idVec3					predictedOrigin;
	idAngles				predictedAngles;
	bool					predictedUpdated;
	idVec3					predictionOriginError;
	idAngles				predictionAnglesError;
	int						predictionErrorTime;

	// mp
 	bool					respawning;				// set to true while in SpawnToPoint for telefrag checks
 	bool					weaponCatchup;			// raise up the weapon silently ( state catchups )
	bool					isTelefragged;			// proper obituaries
	
	int						lastSpectateChange;
 	int						lastTeleFX;
 	unsigned int			lastSnapshotSequence;	// track state hitches on clients
 	
	int						aimClientNum;			// player num in aim

	idEntityPtr<idPlayer>	lastImpulsePlayer;		// the last player who gave me an impulse, may be null

	int						connectTime;
	int						mutedPlayers;			// bitfield set to which clients this player wants muted
	int						friendPlayers;			// bitfield set to which clients this player has marked as friends

	int						voiceDest[MAX_CONCURRENT_VOICES];
	int						voiceDestTimes[MAX_CONCURRENT_VOICES];

	int						deathSkinTime;
	bool					deathStateHitch;

	playerEmote_t			emote;

	// end mp

	int						lastImpulseTime;		// time of last impulse

	const idDeclEntityDef*	cachedWeaponDefs [ MAX_WEAPONS ];

	bool					WantSmoothing( void ) const;
	void					PredictionErrorDecay( void );

	void					LookAtKiller( const idVec3 &dir );

	idVec3					leanVelocity;

	// lean props
	float					leanMaxSpeed;
	float					leanBlendRatio;
	float					leanMaxLateralAngle;
	float					leanMaxForwardAngle;
	float					leanHeadRatio;
	float					leanHipRatio;

	void					StopFiring( void );
	void					FireWeapon( void );
	void					Weapon_Combat( void );
	void					Weapon_GUI( void );
	void					Weapon_Usable ( void );
	void					SpectateFreeFly( bool force );	// ignore the timeout to force when followed spec is no longer valid
	void					SpectateCycle( void );
	idVec3					GunAcceleratingOffset( void );

	void					CrashLand( const idVec3 &oldOrigin, const idVec3 &oldVelocity );
	void					BobCycle( const idVec3 &pushVelocity );
	void					EvaluateControls( void );
	void					AdjustSpeed( void );
	void					AdjustBodyAngles( void );
	void					Move( void );
	void					SetSpectateOrigin( void );

	idUserInterface *		ActiveGui( void );

	void					UpdateWeapon				( void );
	void					UpdateSpectating			( void );

// abahr
	void					UpdateGravity				( void );
// nrausch: common handling for objective screen toggle	

	void					HandleCheats				( void );
	void					ClearCheatState				( void );

	void					UpdateViewAngles			( void );
 	void					UpdateDeathSkin				( bool state_hitch );
	void					UpdateFocus					( void );
 	void					UpdateLocation				( void );

	void					LoadDeferredModel			( void );

	void					ClearFocus					( void );

	void					Event_GetButtons			( void );
	void					Event_GetMove				( void );
	void					Event_GetViewAngles			( void );
	void					Event_SetViewAngles			( const idVec3 &vec );
	void					Event_EnableWeapon			( void );
	void					Event_DisableWeapon			( void );
	void					Event_GetCurrentWeapon		( void );
	void					Event_GetPreviousWeapon		( void );
	void					Event_SelectWeapon			( const char *weaponName );
	void					Event_GetWeaponEntity		( void );
	void					Event_ExitTeleporter		( void );
	void					Event_HideTip				( void );
	void					Event_LevelTrigger			( void );
	void					Event_GetViewPos			( void );
	void					Event_TeleportPlayer		( idVec3 &newPos, idVec3 &newAngles );
	void					Event_Freeze				( float f );
	void					Event_FinishHearingLoss		( float fadeTime );
	void					Event_GetAmmoData			( const char *ammoClass );
	
	void					Event_EnableTarget			( void );
	void					Event_DisableTarget			( void );
	virtual void			Event_DamageOverTimeEffect	( int endTime, int interval, const char *damageDefName );
	
	
	// twhitaker: added Event_ApplyImpulse
	void					Event_ApplyImpulse			( idEntity* ent, idVec3 &point, idVec3 &impulse	);

	// mekberg:	added sethealth
	void					Event_SetHealth					( float newHealth );
	void					Event_SetArmor					( float newArmor );

	void					Event_SetExtraProjPassEntity( idEntity* _extraProjPassEntity );
	void					Event_DamageEffect			( const char *damageDefName, idEntity* _damageFromEnt  );

	void					Event_Touch					( idEntity *other, trace_t *trace );

	// twhitaker: death shader
	void					UpdateDeathShader			( bool state_hitch );
	
	bool doInitWeapon;
	void					InitWeapon			( void );
	

	bool					IsLegsIdle						( bool crouching ) const;
	
	stateResult_t			State_Wait_Alive				( const stateParms_t& parms );
	stateResult_t			State_Wait_ReloadAnim			( const stateParms_t& parms );
	
	stateResult_t			State_Torso_Idle				( const stateParms_t& parms );
	stateResult_t			State_Torso_IdleThink			( const stateParms_t& parms );
	stateResult_t			State_Torso_Teleport			( const stateParms_t& parms );
	stateResult_t			State_Torso_RaiseWeapon			( const stateParms_t& parms );
	stateResult_t			State_Torso_LowerWeapon			( const stateParms_t& parms );
	stateResult_t			State_Torso_Fire				( const stateParms_t& parms );
	stateResult_t			State_Torso_Fire_Windup			( const stateParms_t& parms );

	stateResult_t			State_Torso_Reload				( const stateParms_t& parms );
	stateResult_t			State_Torso_Pain				( const stateParms_t& parms );
	stateResult_t			State_Torso_Dead				( const stateParms_t& parms );
	stateResult_t			State_Torso_Emote				( const stateParms_t& parms );
	
	stateResult_t			State_Legs_Idle					( const stateParms_t& parms );
	stateResult_t			State_Legs_Run_Forward			( const stateParms_t& parms );
	stateResult_t			State_Legs_Run_Backward			( const stateParms_t& parms );
	stateResult_t			State_Legs_Run_Left				( const stateParms_t& parms );
	stateResult_t			State_Legs_Run_Right			( const stateParms_t& parms );
	stateResult_t			State_Legs_Walk_Forward			( const stateParms_t& parms );
	stateResult_t			State_Legs_Walk_Backward		( const stateParms_t& parms );
	stateResult_t			State_Legs_Walk_Left			( const stateParms_t& parms );
	stateResult_t			State_Legs_Walk_Right			( const stateParms_t& parms );
	stateResult_t			State_Legs_Crouch				( const stateParms_t& parms );
	stateResult_t			State_Legs_Uncrouch				( const stateParms_t& parms );
	stateResult_t			State_Legs_Crouch_Idle			( const stateParms_t& parms );
	stateResult_t			State_Legs_Crouch_Forward		( const stateParms_t& parms );
	stateResult_t			State_Legs_Crouch_Backward		( const stateParms_t& parms );
	stateResult_t			State_Legs_Jump					( const stateParms_t& parms );
	stateResult_t			State_Legs_Fall					( const stateParms_t& parms );
	stateResult_t			State_Legs_Land					( const stateParms_t& parms );
	stateResult_t			State_Legs_Dead					( const stateParms_t& parms );
	
 	CLASS_STATES_PROTOTYPE( idPlayer );

	// <q4f>

public:

	void					WaterLevelChange( float oldLevel, float newLevel );

	void					ChangeClass( int classNum, bool broadcast = true );						// forces the player to change classes
	void					ChangeTeam( int teamNum );							// forces a player to change teams

	short					GetButtons( void ) { return usercmd.buttons; };				// used by the alias class

	void					PrimeGrenade( int grenadeNum );
	void					ThrowGrenade( bool heldpin, bool dropped );

	int						DamageHealsArmor( const idDict* dmgDict );
	int						DamageHealsHealth( const idDict* dmgDict );


	void					Damage_TF( const TFDamage &dmg, float damageScale );
	void					DamageFeedback_TF( idEntity *victim, const TFDamage &tfDamage );
	void					CalcDamagePoints_TF( const TFDamage &tfDamage, int* healthLoss, int* armorLoss );
	void					Killed_TF( const TFDamage &tfDamage, int healthLoss );

	//void					Push( idVec3 origin, float amount );

	//void					DrawPlayerNames( idUserInterface *hud );
	
	void					SetSpeedPercent( float percent );			//sets the player speed to a percentage of their starting speed

	void					AddPipe( Pipebomb* pipe );
	void					DetPipe( bool detAll, bool force = false );						// if detAll == true, dets all pipes. otherwise dets oldest.
	void					RemovePipe( Pipebomb* pipe );					// remove a pipe from our pipe list
	int						GetNumPipes( void ) { return pipes.Num(); };
	int						GetOldestPipeTime( void );

	void					EmpTouch( const AttackerInfo &attacker, idVec3 &dir, float damageScale );

	void					DropAmmo( const char* ammoName, int drop, int save );
	void					DropBackPack( bool dropAllAmmo );
	void					DropItem( const char* defName, idDict* additionalArgs, float removeTimeSec, float forwardSpeed, float upSpeed );
	void					RemoveDropAmmo( idItem* ammo );

	// returns if anything was given
	bool					Give_TF( const char* type, int amount, bool allowLower = true, bool exceedMax = false, bool setAbsolute = false, int* invAmount = NULL, int* invMaxAmount = NULL );

	bool					GiveTFItem( TFCarryItem* item );
	void					RemoveTFItem( TFCarryItem* item );

	const char*				GetGrenadeName( int grenadeNum ) { return grenadeNum == 1 ? 
																	grenadeDef_1->dict.GetString( "grenadeName", "" ) : 
																	grenadeDef_2->dict.GetString( "grenadeName", "" ); };

	float					GetMaxSpeed( void ) { return runSpeed; };

	void					DropItems( bool force, tfstate_t newState );

	bool					ReadyToPlay( void );

	void					UpdateHudTeamColor( void );
	idVec3&					GetTeamColor( bool visibleColor = false );
	void					UpdateVisibleColor( void );
	void					UpdateVisibleColor( int teamNum );
	void					UpdateVisibleColor( idVec3 color );

	bool					AddToMessageQueue( const char* msg );

	virtual bool			IsHolding( TFCarryItem* item );

	void					StartPreview( const idDeclEntityDef* entDef );
	void					StopPreview( void );
	void					UpdateBuildStatus( void );

	void					ZoomIn( void );
	void					ZoomOut( void );
	void					CheckZoom( void );
	bool					weaponZoomed;

	void					CheckWater( void );

	void					AddAffliction( const TFDamage &dmg );
	void					ClearAfflictions( void );

	void					StartDisguise( disguiseType_t type, int num );
	void					UpdateDisguise( void );
	void					DisguiseChanged( int oldTeam, int oldClass, int newTeam, int newClass );
	void					ClearDisguise( void );
	void					UpdateDisguiseShader( float percentage );

	void					AdjustAnimRates( float runMult, float walkMult, float crouchMult );
	void					AdjustAnimRate( const char* animName, float multiplier );
	void					UpdateAnimPrefix( void );
	bool					DisguiseFinished( void );

	virtual TFDamage*		GetKillerDamage( void ) { return damageKilledWith.IsValid() ? &damageKilledWith : NULL; };

	void					CheckDispensers( void );

	bool					HasAffliction( afflType_t type ) { return afflictions & type; };

	int						currentPC;			// the current player class
	int						nextPC;				// the player class to change to on spawn
	int						restrictedClass;

	int						nextTeamChange;

	int						disguiseClass;
	int						disguiseTeam;
	int						disguiseClassTo;
	int						disguiseTeamTo;
	int						disguiseStart;
	int						disguiseName;

	idEntityPtr<SentryGun>	sentryGun;
	idEntityPtr<Dispenser>	dispenser;
	idEntityPtr<DetPak>		detpack;

	idEntityPtr<idEntity>	focusEnt;
	float					focusDist;

	float					dispFillAmount;
	float					dispFillStartAmount;

	int					lastCrashLandTime;
	

	BuildPreview			buildPreview;
	bool					isPreviewing;
	bool					isBuilding;

	bool					isDispensing;
	bool					isFacingDispenser;

	q4fLocation*			currentLocation;
	q4fLocation*			deathLocation;

	void					DrawRadar( idUserInterface *hud );
	void					CalcRadarPositions();

	bool					GetPlayerRadarPosition( playerRadarPos_t &pos, const idPlayer* player );

	playerRadarPos_t		radarPositions[MAX_CLIENTS];

	int						radarTime;

	int						allowNextFireTime;

	struct heldGrenade_t {
		int				grenadeNum;				// which grenade is primed. 0 = no grenade primed
		int				primeTime;
		bool			playerWantsThrow;
	} heldGrenade;

	int						grenSoundCycle;

	void					ResetToTime( int time );
	void					RestoreFromReset( void );

	void					MenuSlotSelected( int num );
	void					OpenMenu( int num );
	void					CloseMenu( void );
	int					menuNum;

	int					commMenuIndex;


	// userinfo cache
	bool					uiAutoReload;
	const char*			uiName;
	const char*			uiClan;

private:

	void					CommonUpdates( void );
	void					CommonClear( void );

	void					RunAfflictions( void );

	void					UpdateColors( void );

	void					InitClassInformation( void );

	void					ClearHeldGrenade( void );
	void					CheckHeldGrenade( void );			// check the status of our held grenade
	void					LoadGrenades( void );			// loads the grenades def file

	void					ShowMenu( int tabNum );

	void					Event_LimitSpeed ( float multiplier, float time );
	void					Event_GetCurrentKiller( void );
	void					Event_GetStat( const char* stat );
	int						GetStat( const char* stat );

	void					Event_GetPlayerName( void );

	//idList< rvPair< idStr, int > >		messageQueue;
	idStr					messageQueue;
	int						nextMsgChange;

	float					speedMultiplier;

	idList<Pipebomb*>		pipes;
	int						nextPipeAttack;

	idEntityPtr<TFItem>		dropAmmos[ MAX_DROPAMMOS ];


	const idDeclEntityDef*	grenadeDef_1;			// cache our primary grenade def;
	const idDeclEntityDef*	grenadeDef_2;			// cache our secondary grenade def;

	float					runSpeed;
	float					walkSpeed;
	float					crouchSpeed;	

	int						nextFocusUpdateTime;

	// AFFLICATIONS

	int						oldAfflictions;
	int						afflictions;

	int					flashStartTime;
	float					flashScale;
	bool					flashBurned;
	int					hearingLossEnd;
	int					flash_fade_start;
	int					flash_fade_time;
	
	int						concStartTime;
	float					concScale;
	idAngles				drunkAngles;
	int					conc_time;
	int					conc_yaw;
	int					conc_pitch;

	TFDamage				dmgInfection;
	int					lastDmgInfection;
	int					infection_delay;

	TFDamage				dmgFire;
	int						dmgFireCount;
	int						lastDmgFire;
	int					fire_delay;

	int						tranqStartTime;
	float					tranqScale;
	float					tranqSpeed;
	int					tranq_time;
	float					tranq_speed_start;
	float					tranq_speed_end;

	int					hallucinateStartTime;
	float					hallucinateScale;
	int					hallucinate_time;
	bool					halluColors;

	TFDamage				dmgNoAir;
	int					lastDmgAir;
	int					noair_delay;

	rvClientEntityPtr<rvClientEffect>			fxAfflFlash;
	rvClientEntityPtr<rvClientEffect>			fxAfflConc;
	rvClientEntityPtr<rvClientEffect>			fxAfflDisease;
	rvClientEntityPtr<rvClientEffect>			fxAfflFire;

	TFDamage				damageKilledWith;

	int						nextHealTime;

	loggedPosition_t		loggedPositions[ NUM_LOGGED_POSITIONS ];
	int						currentLoggedPosition;
	loggedPosition_t		restorePosition;

	// </q4f>
};

/*ID_INLINE idVec3 idPlayer::GetCenter( void )  const {
	idVec3 center  = physicsObj.GetAbsBounds().GetCenter();

	if ( IsCrouching() ) {
		center.z = physicsObj.GetOrigin().z + FIRE_PROJ_HEIGHT_CROUCHED;
	}
	else {
		center.z = physicsObj.GetOrigin().z + FIRE_PROJ_HEIGHT_STANDING;
	}
	return center;
}*/

ID_INLINE void idPlayer::UpdateDisguiseShader( float percentage ) {
	renderEntity.shaderParms[ 8 ] = percentage;
	if( clientHead ) {
		clientHead.GetEntity()->GetRenderEntity()->shaderParms[ 8 ] = percentage;
	}

	if ( weapon ) {
		if ( weapon->GetWorldModel() )
			weapon->GetWorldModel()->GetRenderEntity()->shaderParms[ 8 ] = percentage;
		if ( weapon->GetViewModel() )
			weapon->GetViewModel()->GetRenderEntity()->shaderParms[ 8 ] = percentage;
	}
}

ID_INLINE void idPlayer::UpdateAnimPrefix( void ) {
	if ( weapon ) {
		animPrefix = weapon->GetAnimPrefix();
	}
	else if ( GetWeaponDef( currentWeapon ) ) {
		animPrefix = GetWeaponDef( currentWeapon )->dict.GetString( "animPrefix", "" );	
	}
	animPrefix.Strip( "weapon_" );
}

ID_INLINE bool idPlayer::DisguiseFinished() {
	if ( disguiseClassTo != INVALID_CLASS || disguiseTeamTo != INVALID_CLASS )
		return false;

	return true;
}

ID_INLINE void idPlayer::CheckZoom( void ) {
	if ( !gameLocal.isNewFrame || entityNumber != gameLocal.localClientNum )
		return;

	bool zoom = (usercmd.buttons & BUTTON_ZOOM) || weaponZoomed;
	if ( zoom != zoomed ) {
		if ( zoom ) {
			ZoomIn();
		} else {
			ZoomOut();
		}
	}

	if ( g_fov.IsModified() ) {
		//gameLocal.Printf( "Detected g_fov has been modified. Clearing the modified flag.\n" );
		g_fov.ClearModified();
		//gameLocal.Printf( "g_fov modified flag cleared. G_fov current value is '%g'\n", g_fov.GetFloat() );
		zoomFov.Init( gameLocal.time, gameLocal.time, g_fov.GetFloat(), g_fov.GetFloat() );
		//gameLocal.Printf( "The zoom interpolater has been set to g_fov's value. Retrieving its current value yields '%g'\n", zoomFov.GetCurrentValue( gameLocal.time ) );
	}
}

ID_INLINE void idPlayer::UpdateBuildStatus( void ) {
	if ( isPreviewing && entityNumber == gameLocal.localClientNum ) {
		assert( !isBuilding );
		buildPreview.CalcPosition();
		buildPreview.Draw();
	}
	else if ( isBuilding ) {
		usercmd.forwardmove = 0.0f;
		usercmd.rightmove = 0.0f;
		LowerWeapon();
	}
}

ID_INLINE bool idPlayer::IsHolding( TFCarryItem* item ) {
	if ( inventory.tfitems.Find( item ) )
		return true;

	return false;
}

ID_INLINE idVec3& idPlayer::GetTeamColor( bool visibleColor ) {
	if ( visibleColor && tfGame.GetTeam( disguiseTeam ) ) {
		return tfGame.GetTeamColor( disguiseTeam );
	}
	return tfGame.GetTeamColor( team );
}

ID_INLINE void idPlayer::UpdateVisibleColor( void ) {
	UpdateVisibleColor( GetTeamColor( true ) );
}

ID_INLINE void idPlayer::UpdateVisibleColor( int teamNum ) {
	idVec3 c = tfGame.GetTeamColor( teamNum );
	UpdateVisibleColor( c );
}

ID_INLINE void idPlayer::UpdateVisibleColor( idVec3 color ) {
	if ( fl.teamColored ) {
		idVec3 myColor = color;
		myColor *= teamColorScale;
		SetColor( myColor );

		if ( clientHead ) {
			clientHead.GetEntity()->SetColor( myColor );
		}

	}
}


ID_INLINE bool idPlayer::IsRespawning( void ) {
 	return respawning;
}

ID_INLINE idPhysics* idPlayer::GetPlayerPhysics( void ) {
	return &physicsObj;
}

ID_INLINE bool idPlayer::IsInTeleport( void ) {
 	return ( teleportEntity.GetEntity() != NULL );
}

ID_INLINE bool idPlayer::IsZoomed ( void ) {
	return zoomed || weaponZoomed;
}

ID_INLINE bool idPlayer::IsFlashlightOn ( void ) {
	return flashlightOn;
}

ID_INLINE rvViewWeapon* idPlayer::GetWeaponViewModel ( void ) const {
	return weaponViewModel;
}

ID_INLINE idAnimatedEntity* idPlayer::GetWeaponWorldModel ( void ) const {
	return weaponWorldModel;
}

ID_INLINE int idPlayer::GetCurrentWeapon( void ) const {
	return currentWeapon;
}

ID_INLINE bool idPlayer::IsGibbed( void ) const {
	return gibDeath;
}

ID_INLINE const idVec3& idPlayer::GetGibDir( void ) const {
	return gibDir;
}

ID_INLINE int idPlayer::GetWeaponIndex( const char* weaponName ) const {
	for( int i = 0; i < MAX_WEAPONS; i++ ) {
		if( !idStr::Icmp( spawnArgs.GetString( va( "def_weapon%d", i ), "" ), weaponName ) ) {
			return i;
		}
	}

	return 0;
}

ID_INLINE idUserInterface* idPlayer::GetHud() {
	return hud;
}

ID_INLINE const idUserInterface* idPlayer::GetHud() const {
	return hud;
}

ID_INLINE bool idPlayer::IsPlayerMuted( idPlayer* player ) const {
	return !!( mutedPlayers & ( 1 << player->entityNumber ) );
}

ID_INLINE bool idPlayer::IsPlayerMuted( int clientNum ) const {
	return !!( mutedPlayers & ( 1 << clientNum ) );
}

ID_INLINE void idPlayer::MutePlayer( idPlayer* player, bool mute ) {
	if( mute ) {
		mutedPlayers |= ( 1 << player->entityNumber );
	} else {
		mutedPlayers &= ~( 1 << player->entityNumber );
	}
}

ID_INLINE void idPlayer::MutePlayer( int clientNum, bool mute ) {
	if( mute ) {
		mutedPlayers |= ( 1 << clientNum );
	} else {
		mutedPlayers &= ~( 1 << clientNum );
	}
}

ID_INLINE bool idPlayer::IsFriend( idPlayer* player ) const {
	return !!( friendPlayers & ( 1 << player->entityNumber ) );
}

ID_INLINE bool idPlayer::IsFriend( int clientNum ) const {
	return !!( friendPlayers & ( 1 << clientNum ) );
}

ID_INLINE void idPlayer::SetFriend( idPlayer* player, bool isFriend ) {
	if( isFriend ) {
		friendPlayers |= ( 1 << player->entityNumber ); 
	} else {
		friendPlayers &= ~( 1 << player->entityNumber );
	}
}

ID_INLINE void idPlayer::SetFriend( int clientNum, bool isFriend ) {
	if( isFriend ) {
		friendPlayers |= ( 1 << clientNum );
	} else {
		friendPlayers &= ~( 1 << clientNum );
	}
}

ID_INLINE int idPlayer::GetConnectTime( void ) const {
	return connectTime;
}

ID_INLINE void idPlayer::SetConnectTime( int time ) {
	connectTime = time;
}

ID_INLINE int idPlayer::GetRank( void ) const {
	return rank;
}

ID_INLINE void idPlayer::SetRank( int newRank ) {
	rank = newRank;
}

// <q4f> 

ID_INLINE int idPlayer::GetOldestPipeTime( void ) {
	if ( pipes.Num() <= 0 ) {
		return gameLocal.time + 1000;
	}
	assert( pipes[0] );

	return pipes[0]->GetSpawnTime();
}

// </q4f>

#endif /* !__GAME_PLAYER_H__ */


