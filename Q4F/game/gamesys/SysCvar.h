
#ifndef __SYS_CVAR_H__
#define __SYS_CVAR_H__

extern idCVar	si_gameType;

extern idCVar	developer;

extern idCVar	g_cinematic;
extern idCVar	g_cinematicMaxSkipTime;

extern idCVar	net_warnStale;

// GTR bandit: Unlagged Code
extern idCVar	g_unlagged;
extern idCVar	g_unlaggedMaxPing;


// jnewquist: vertical stretch for letterboxed cinematics authored for 4:3 aspect
extern idCVar	g_fixedHorizFOV;


extern idCVar	g_monsters;
extern idCVar	g_decals;
extern idCVar	g_knockback;
extern idCVar	g_gravity;
extern idCVar	g_skipFX;
extern idCVar	g_skipParticles;
extern idCVar	g_projectileLights;
extern idCVar	g_doubleVision;
extern idCVar	g_muzzleFlash;

//extern idCVar	g_disasm;
extern idCVar	g_debugBounds;
extern idCVar	g_debugAnim;
extern idCVar	g_debugMove;
extern idCVar	g_debugDamage;
extern idCVar	g_debugWeapon;
extern idCVar	g_debugScript;
extern idCVar	g_debugMover;
extern idCVar	g_debugTriggers;
extern idCVar	g_debugCinematic;

// bdube: added
extern idCVar	g_debugState;
extern idCVar	g_stopTime;
extern idCVar	g_armorProtection;
extern idCVar	g_armorProtectionMP;
//extern idCVar	g_damageScale;
// jsinger: added to support binary read/write
extern idCVar	com_BinaryRead;
#ifdef RV_BINARYDECLS
extern idCVar	com_BinaryDeclRead;
#endif
// jsinger: added to support loading all decls from a single file
#ifdef RV_SINGLE_DECL_FILE
extern idCVar	com_SingleDeclFile;
extern idCVar	com_WriteSingleDeclFile;
#endif
extern idCVar	com_BinaryWrite;

extern idCVar	g_useDynamicProtection;
extern idCVar	g_healthTakeTime;
extern idCVar	g_healthTakeAmt;
extern idCVar	g_healthTakeLimit;

extern idCVar	g_showPVS;
extern idCVar	g_showTargets;
extern idCVar	g_showTriggers;
extern idCVar	g_showCollisionWorld;
extern idCVar	g_showCollisionModels;
extern idCVar	g_showCollisionTraces;

// ddynerman: SD's clip sector code
extern idCVar	g_showClipSectors;
extern idCVar	g_showClipSectorFilter;
extern idCVar	g_showAreaClipSectors;

extern idCVar	g_maxShowDistance;
extern idCVar	g_showEntityInfo;
extern idCVar	g_showviewpos;
extern idCVar	g_showcamerainfo;
extern idCVar	g_showTestModelFrame;
extern idCVar	g_showActiveEntities;
extern idCVar	g_showEnemies;
extern idCVar	g_frametime;
extern idCVar	g_timeentities;

extern idCVar	g_showFrameCmds;
extern idCVar	g_showGodDamage;

extern idCVar	g_kickTime;
extern idCVar	g_kickAmplitude;
extern idCVar	g_blobTime;
extern idCVar	g_blobSize;

extern idCVar	g_testHealthVision;
extern idCVar	g_editEntityMode;

extern idCVar	g_editEntityDistance;
// rhummer: Allow to customize the distance the text is drawn for edit entities, Zack request.
extern idCVar	g_editEntityTextDistance;
// rjohnson: entity usage stats
extern idCVar	g_keepEntityStats;

extern idCVar	g_dragEntity;
extern idCVar	g_dragDamping;
extern idCVar	g_dragShowSelection;
extern idCVar	g_dropItemRotation;

extern idCVar	ik_enable;
extern idCVar	ik_debug;

extern idCVar	af_useLinearTime;
extern idCVar	af_useImpulseFriction;
extern idCVar	af_useJointImpulseFriction;
extern idCVar	af_useSymmetry;
extern idCVar	af_skipSelfCollision;
extern idCVar	af_skipLimits;
extern idCVar	af_skipFriction;
extern idCVar	af_forceFriction;
extern idCVar	af_maxLinearVelocity;
extern idCVar	af_maxAngularVelocity;
extern idCVar	af_timeScale;
extern idCVar	af_jointFrictionScale;
extern idCVar	af_contactFrictionScale;
extern idCVar	af_highlightBody;
extern idCVar	af_highlightConstraint;
extern idCVar	af_showTimings;
extern idCVar	af_showConstraints;
extern idCVar	af_showConstraintNames;
extern idCVar	af_showConstrainedBodies;
extern idCVar	af_showPrimaryOnly;
extern idCVar	af_showTrees;
extern idCVar	af_showLimits;
extern idCVar	af_showBodies;
extern idCVar	af_showBodyNames;
extern idCVar	af_showMass;
extern idCVar	af_showTotalMass;
extern idCVar	af_showInertia;
extern idCVar	af_showVelocity;
extern idCVar	af_showActive;
extern idCVar	af_testSolid;

extern idCVar	rb_showTimings;
extern idCVar	rb_showBodies;
extern idCVar	rb_showMass;
extern idCVar	rb_showInertia;
extern idCVar	rb_showVelocity;
extern idCVar	rb_showActive;

extern idCVar	pm_jumpheight;
extern idCVar	pm_stepsize;

extern idCVar	pm_noclipspeed;
extern idCVar	pm_spectatespeed;
extern idCVar	pm_spectatebbox;
extern idCVar	pm_usecylinder;
extern idCVar	pm_minviewpitch;
extern idCVar	pm_maxviewpitch;
//extern idCVar	pm_stamina;
//extern idCVar	pm_staminathreshold;
//extern idCVar	pm_staminarate;
extern idCVar	pm_crouchheight;
extern idCVar	pm_crouchviewheight;
extern idCVar	pm_normalheight;
extern idCVar	pm_normalviewheight;
extern idCVar	pm_deadheight;
extern idCVar	pm_deadviewheight;
extern idCVar	pm_crouchrate;
extern idCVar	pm_bboxwidth;
//extern idCVar	pm_crouchbob;
//extern idCVar	pm_walkbob;
//extern idCVar	pm_runbob;
//extern idCVar	pm_runpitch;
//extern idCVar	pm_runroll;
//extern idCVar	pm_bobup;
extern idCVar	pm_bobpitch;
extern idCVar	pm_bobroll;
extern idCVar	pm_thirdPersonRange;
extern idCVar	pm_thirdPersonHeight;
extern idCVar	pm_thirdPersonAngle;
extern idCVar	pm_thirdPersonClip;
extern idCVar	pm_thirdPerson;
extern idCVar	pm_thirdPersonDeath;
extern idCVar	pm_modelView;

extern idCVar	pm_zoomedSlow;
extern idCVar 	pm_isZoomed;

// nmckenzie: added ability to try alternate accelerations.
//3j: added out own
//extern idCVar	pm_acceloverride;
extern idCVar	pm_frictionoverride;
extern idCVar	pm_forcespectatormove;
extern idCVar	pm_thirdPersonTarget;

extern idCVar	g_showPlayerShadow;

extern idCVar	g_skipPlayerShadowsMP;
extern idCVar	g_skipItemShadowsMP;

extern idCVar	g_showHud;

extern idCVar	g_crosshairColor;
// cnicholson: Custom Crosshair 
extern idCVar	g_crosshairCustom;
extern idCVar	g_crosshairCustomFile;
extern idCVar	g_crosshairCharInfoFar;
// bdube: hud popups
extern idCVar	g_showHudPopups;
// bdube: range
extern idCVar	g_showRange;
// bdube: debug hud
extern idCVar	g_showDebugHud;

// bdube: brass time
//extern idCVar	g_brassTime;

extern idCVar	g_gun_x;
extern idCVar	g_gun_y;
extern idCVar	g_gun_z;

// bdube: cvar for messing with foreshortening
extern idCVar	g_gun_pitch;
extern idCVar	g_gun_yaw;
extern idCVar	g_gun_roll;
// abahr:
extern idCVar	g_gunViewStyle;
// jscott: for playbacks
extern idCVar	g_showPlayback;
extern idCVar	g_currentPlayback;

extern idCVar	g_viewNodalX;
extern idCVar	g_viewNodalZ;
extern idCVar	g_fov;
extern idCVar	g_zoomfov;
extern idCVar	g_testDeath;
extern idCVar	g_skipViewEffects;
extern idCVar   g_mpWeaponAngleScale;

extern idCVar	g_testParticle;
extern idCVar	g_testParticleName;

// bdube: more rigid body debug
extern idCVar	rb_showContacts;


extern idCVar	g_testPostProcess;

extern idCVar	g_testModelRotate;
extern idCVar	g_testModelAnimate;
extern idCVar	g_testModelBlend;

// bdube: test scoreboard
extern idCVar	g_testScoreboard;
extern idCVar	g_testPlayer;

extern idCVar	g_exportMask;
extern idCVar	g_flushSave;

extern idCVar	net_clientPredictGUI;

extern idCVar	g_voteFlags;
extern idCVar	g_mapCycle;

extern idCVar	si_voteFlags;

// shouchard:  g_balanceTDM->g_balanceTeams so we can also use it for CTF
extern idCVar	si_autobalance;


extern idCVar	si_timeLimit;
extern idCVar	si_map;
extern idCVar	si_mapCycle;
extern idCVar	si_spectators;
extern idCVar	si_minPlayers;

// bdube: client entities
extern idCVar	g_gamelog;
extern idCVar	cl_showEntityInfo;
// jnewquist: Option to force undying state
extern idCVar	g_forceUndying;
// mcg: combat performance testing cvars

/*extern idCVar g_perfTest_weaponNoFX;
extern idCVar g_perfTest_hitscanShort;
extern idCVar g_perfTest_hitscanBBox;
extern idCVar g_perfTest_aiStationary;
extern idCVar g_perfTest_aiNoDodge;
extern idCVar g_perfTest_aiNoRagdoll;
extern idCVar g_perfTest_aiNoObstacleAvoid;
extern idCVar g_perfTest_aiUndying;
extern idCVar g_perfTest_aiNoVisTrace;
extern idCVar g_perfTest_noJointTransform;
extern idCVar g_perfTest_noPlayerFocus;
extern idCVar g_perfTest_noProjectiles;*/

extern idCVar g_clientProjectileCollision;

extern idCVar	net_clientLagOMeter;

extern idCVar ri_useViewerPass;
extern idCVar ri_privateViewers;
extern idCVar ri_numViewers;
extern idCVar ri_numPrivateViewers;
extern idCVar ri_name;

extern idCVar g_noTVChat;

extern idCVar	r_shadows;

// 1.4.2
extern idCVar g_playerLean;

#endif /* !__SYS_CVAR_H__ */
