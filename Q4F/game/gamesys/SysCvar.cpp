#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"

#if defined( _DEBUG )
	#define	BUILD_DEBUG	"-debug"
#else
	#define	BUILD_DEBUG "-release"
#endif

/*

All game cvars should be defined here.

*/

const char *si_readyArgs[]			= { "Not Ready", "Ready", NULL }; 

struct gameVersion_s {
	gameVersion_s( void ) { sprintf( string, "%s %s 1.0.%d%s %s %s %s", GAME_NAME, GAME_BUILD_TYPE, BUILD_NUMBER, BUILD_DEBUG, BUILD_STRING, __DATE__, __TIME__ ); }
	char	string[256];
} gameVersion;

idCVar g_version(					"g_version",				gameVersion.string,	CVAR_GAME | CVAR_ROM, "game version" );

idCVar si_name(						"si_name",					"Q4F Server",	CVAR_GAME | CVAR_SERVERINFO | PC_CVAR_ARCHIVE | CVAR_CASE_SENSITIVE | CVAR_SPECIAL_CONCAT, "name of the server" );

idCVar si_gameType(					"si_gameType",				"Q4F",	CVAR_GAME | CVAR_SERVERINFO | PC_CVAR_ARCHIVE | CVAR_ROM, "" );
// xavior: allow servers to disable pogo bunnyhop
idCVar si_allowPogo(				"si_allowPogo",				"1",	CVAR_GAME | CVAR_SERVERINFO | PC_CVAR_ARCHIVE | CVAR_INTEGER, "enable (1) or disable (0) pogo bunnyhopping for players on the server" );
// ddynerman: new gametype strings
idCVar si_map(						"si_map",					"q4f_mach",				CVAR_GAME | CVAR_SERVERINFO | PC_CVAR_ARCHIVE, "map to be played next on server", idCmdSystem::ArgCompletion_MapName );
idCVar si_mapCycle(					"si_mapCycle",				"q4f_mach;q4f_bases;q4f_bam",				CVAR_GAME | CVAR_SERVERINFO | PC_CVAR_ARCHIVE, "Map and gametype cycle list. Ex: bases:1;mach2:2;" );
// bdube: raise player limit
idCVar si_maxPlayers(				"si_maxPlayers",			"16",			CVAR_GAME | CVAR_SERVERINFO | PC_CVAR_ARCHIVE | CVAR_INTEGER, "max number of players allowed on the server", 1, 16 );
// ddynerman: min players to start
idCVar si_minPlayers(				"si_minPlayers",			"1",			CVAR_GAME | CVAR_SERVERINFO | PC_CVAR_ARCHIVE | CVAR_INTEGER, "min number of players to start a game (only when warmup is enabled)", 1, 16 );
// ddynerman: CTF
idCVar si_scorelimit(				"si_scorelimit",			"0",			CVAR_GAME | CVAR_SERVERINFO | PC_CVAR_ARCHIVE | CVAR_INTEGER, "score limit for CTF" );
// shouchard:  for tourney


idCVar si_allowVoting(				"si_allowVoting",			"0",			CVAR_GAME | CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_BOOL, "enable or disable server option voting" );

idCVar si_privatePlayers(			"si_privatePlayers",		"0",			CVAR_GAME | CVAR_SERVERINFO | PC_CVAR_ARCHIVE | CVAR_INTEGER, "number of private player slots reserved on the server.  subtracts from si_maxPlayers, so a server with si_maxPlayers 16 and 4 private player slots will only allow 12 public players to connect - see g_privatePassword, privatePassword", 0, 16 );
idCVar g_privatePassword(			"g_privatePassword",		"",				CVAR_GAME | PC_CVAR_ARCHIVE, "server-side password to access reserved client slots, clients set privatePassword" );
idCVar privatePassword(				"privatePassword",			"",				CVAR_GAME | CVAR_NOCHEAT, "client password used to access a servers private player slots" );
idCVar si_numPrivatePlayers(		"si_numPrivatePlayers",		"0",			CVAR_GAME | CVAR_SERVERINFO | CVAR_ROM, "number of private slots currently in use" );
idCVar si_suddenDeathRestart(		"si_suddenDeathRestart",	"1",			CVAR_GAME | CVAR_SERVERINFO | CVAR_ARCHIVE, "toggles whether or not to respawn players/items when team games enter sudden death" );

//idCVar si_fragLimit(				"si_fragLimit",				"10",			CVAR_GAME | CVAR_SERVERINFO | PC_CVAR_ARCHIVE | CVAR_INTEGER, "frag limit", 0, MP_PLAYER_MAXFRAGS );
idCVar si_timeLimit(				"si_timeLimit",				"25",			CVAR_GAME | CVAR_SERVERINFO | PC_CVAR_ARCHIVE | CVAR_INTEGER, "time limit in minutes", 0, 60 );
//idCVar si_teamDamage(				"si_teamDamage",			"0",			CVAR_GAME | CVAR_SERVERINFO | PC_CVAR_ARCHIVE | CVAR_BOOL, "enable team damage" );

idCVar si_usePass(					"si_usePass",				"0",			CVAR_GAME | CVAR_SERVERINFO | PC_CVAR_ARCHIVE | CVAR_BOOL, "enable client password checking" );
#ifdef _MPBETA
	idCVar si_pure(					"si_pure",					"1",			CVAR_GAME | CVAR_SERVERINFO | CVAR_BOOL | CVAR_ROM, "server is pure and does not allow modified data" );
#else
	idCVar si_pure(					"si_pure",					"1",			CVAR_GAME | CVAR_SERVERINFO | CVAR_BOOL, "server is pure and does not allow modified data" );
#endif // _MPBETA
idCVar si_spectators(				"si_spectators",			"1",			CVAR_GAME | CVAR_SERVERINFO | PC_CVAR_ARCHIVE | CVAR_BOOL, "allow spectators or require all clients to play" );
idCVar si_shuffle(					"si_shuffle",				"0",			CVAR_GAME | CVAR_SERVERINFO | PC_CVAR_ARCHIVE | CVAR_BOOL, "shuffle teams after each round" );
// shouchard:  g_balanceTDM->si_autobalance so we can also use it for CTF
// asalmon: Changed to archive only on PC
idCVar si_autobalance(				"si_autobalance",			"1",			CVAR_GAME | CVAR_SERVERINFO | CVAR_BOOL | PC_CVAR_ARCHIVE, "maintain even teams" );

// jscott: added entity filtering
//idCVar si_entityFilter(				"si_entityFilter",			"",				CVAR_GAME | CVAR_SERVERINFO, "filter to use when spawning entities" );
idCVar si_countDown(				"si_countDown",				"0",			CVAR_GAME | CVAR_SERVERINFO | CVAR_INTEGER | PC_CVAR_ARCHIVE, "pregame countdown in seconds", 0, 3600 );
// MCG: added "weapon stay" option
//idCVar si_weaponStay(				"si_weaponStay",			"0",			CVAR_GAME | CVAR_SERVERINFO | CVAR_BOOL, "cannot pick up weapons you already have (get no ammo from them)" );


// user info
idCVar ui_name(						"ui_name",					"Player",		CVAR_GAME | CVAR_USERINFO | PC_CVAR_ARCHIVE | CVAR_CASE_SENSITIVE | CVAR_SPECIAL_CONCAT, "player name" );
idCVar ui_clan(						"ui_clan",					"",	CVAR_GAME | CVAR_USERINFO | PC_CVAR_ARCHIVE | CVAR_CASE_SENSITIVE | CVAR_SPECIAL_CONCAT, "player clan" );
//idCVar ui_autoSwitch(				"ui_autoSwitch",			"1",			CVAR_GAME | CVAR_USERINFO | CVAR_ARCHIVE | CVAR_BOOL, "auto switch weapon" );
idCVar ui_autoReload(				"ui_autoReload",			"1",			CVAR_GAME | CVAR_USERINFO | CVAR_ARCHIVE | CVAR_BOOL, "auto reload weapon" );

idCVar ui_showGun(					"ui_showGun",				"1",			CVAR_GAME | CVAR_USERINFO | CVAR_ARCHIVE | CVAR_INTEGER, "Show gun" );
//idCVar ui_showGun(				"ui_showGun",				"1",			CVAR_GAME | CVAR_USERINFO | CVAR_ARCHIVE | CVAR_INTEGER, "How to draw gun. 0 = Don't draw, 1 = right handed, 2 = left handed, 3 = center" );

//idCVar ui_ready(					"ui_ready",				si_readyArgs[ 0 ],	CVAR_GAME | CVAR_USERINFO, "player is ready to start playing", idCmdSystem::ArgCompletion_String<si_readyArgs> );
idCVar ui_chat(						"ui_chat",					"0",			CVAR_GAME | CVAR_USERINFO | CVAR_BOOL | CVAR_ROM | CVAR_CHEAT, "player is chatting" );

// change anytime vars
idCVar developer(					"developer",				"0",			CVAR_GAME | CVAR_BOOL, "" );


// jnewquist: vertical stretch for letterboxed cinematics authored for 4:3 aspect
idCVar g_fixedHorizFOV(				"r_fixedHorizFOV",			"0",			CVAR_RENDERER | CVAR_BOOL, "vertical stretch for letterboxed cinematics authored for 4:3 aspect" );
idCVar g_cinematic(					"g_cinematic",				"1",			CVAR_GAME | CVAR_BOOL, "skips updating entities that aren't marked 'cinematic' '1' during cinematics" );
idCVar g_cinematicMaxSkipTime(		"g_cinematicMaxSkipTime",	"600",			CVAR_GAME | CVAR_FLOAT, "# of seconds to allow game to run when skipping cinematic.  prevents lock-up when cinematic doesn't end.", 0, 3600 );

idCVar g_muzzleFlash(				"g_muzzleFlash",			"1",			CVAR_GAME | CVAR_ARCHIVE | CVAR_BOOL, "show muzzle flashes" );
idCVar g_projectileLights(			"g_projectileLights",		"1",			CVAR_GAME | CVAR_ARCHIVE | CVAR_BOOL, "show dynamic lights on projectiles" );
//idCVar g_doubleVision(				"g_doubleVision",			"1",			CVAR_GAME | CVAR_ARCHIVE | CVAR_BOOL, "show double vision when taking damage" );
//idCVar g_monsters(					"g_monsters",				"1",			CVAR_GAME | CVAR_BOOL, "" );
idCVar g_decals(					"g_decals",					"1",			CVAR_GAME | PC_CVAR_ARCHIVE | CVAR_BOOL, "show decals such as bullet holes" );
idCVar g_knockback(					"g_knockback",				"1000",			CVAR_GAME | CVAR_INTEGER, "" );
//idCVar g_nightmare(					"g_nightmare",				"0",			CVAR_GAME | CVAR_ARCHIVE | CVAR_BOOL, "if nightmare mode is allowed" );
idCVar g_gravity(					"g_gravity",		DEFAULT_GRAVITY_STRING, CVAR_GAME | CVAR_FLOAT, "gravity" );
idCVar g_skipFX(					"g_skipFX",					"0",			CVAR_GAME | CVAR_BOOL, "" );
idCVar g_skipParticles(				"g_skipParticles",			"0",			CVAR_GAME | CVAR_BOOL, "" );

//idCVar g_disasm(					"g_disasm",					"0",			CVAR_GAME | CVAR_BOOL, "disassemble script into base/script/disasm.txt on the local drive when script is compiled" );
idCVar g_debugBounds(				"g_debugBounds",			"0",			CVAR_GAME | CVAR_BOOL, "checks for models with bounds > 2048" );
idCVar g_debugAnim(					"g_debugAnim",				"-1",			CVAR_GAME | CVAR_INTEGER, "displays information on which animations are playing on the specified entity number.  set to -1 to disable." );
idCVar g_debugMove(					"g_debugMove",				"0",			CVAR_GAME | CVAR_BOOL, "" );
idCVar g_debugDamage(				"g_debugDamage",			"0",			CVAR_GAME | CVAR_BOOL, "" );
idCVar g_debugWeapon(				"g_debugWeapon",			"0",			CVAR_GAME | CVAR_BOOL, "" );
idCVar g_debugScript(				"g_debugScript",			"0",			CVAR_GAME | CVAR_BOOL, "" );
idCVar g_debugMover(				"g_debugMover",				"0",			CVAR_GAME | CVAR_BOOL, "" );
idCVar g_debugTriggers(				"g_debugTriggers",			"0",			CVAR_GAME | CVAR_BOOL, "" );
idCVar g_debugCinematic(			"g_debugCinematic",			"0",			CVAR_GAME, "set to the name of the state you want to debug or * for all" );

// bdube: added
idCVar g_debugState(				"g_debugState",				"0",			CVAR_GAME, "" );
idCVar g_stopTime(					"g_stopTime",				"0",			CVAR_GAME | CVAR_BOOL, "" );
//idCVar g_damageScale(				"g_damageScale",			"1",			CVAR_GAME | CVAR_FLOAT | CVAR_ARCHIVE, "scale final damage on player by this factor" );
									   
idCVar g_armorProtection(			"g_armorProtection",		"0.66667",			CVAR_GAME | CVAR_FLOAT | PC_CVAR_ARCHIVE, "armor takes this percentage of damage" );
idCVar g_armorProtectionMP(			"g_armorProtectionMP",		"0.66667",		CVAR_GAME | CVAR_FLOAT | PC_CVAR_ARCHIVE, "armor takes this percentage of damage in mp" );
//idCVar g_useDynamicProtection(		"g_useDynamicProtection",	"1",			CVAR_GAME | CVAR_BOOL | PC_CVAR_ARCHIVE, "scale damage and armor dynamically to keep the player alive more often" );
//idCVar g_healthTakeTime(			"g_healthTakeTime",			"5",			CVAR_GAME | CVAR_INTEGER | PC_CVAR_ARCHIVE, "how often to take health in nightmare mode" );
//idCVar g_healthTakeAmt(				"g_healthTakeAmt",			"5",			CVAR_GAME | CVAR_INTEGER | PC_CVAR_ARCHIVE, "how much health to take in nightmare mode" );
//idCVar g_healthTakeLimit(			"g_healthTakeLimit",		"25",			CVAR_GAME | CVAR_INTEGER | PC_CVAR_ARCHIVE, "how low can health get taken in nightmare mode" );



idCVar g_showPVS(					"g_showPVS",				"0",			CVAR_GAME | CVAR_INTEGER, "", 0, 2 );
idCVar g_showTargets(				"g_showTargets",			"0",			CVAR_GAME | CVAR_BOOL, "draws entities and thier targets.  hidden entities are drawn grey." );
idCVar g_showTriggers(				"g_showTriggers",			"0",			CVAR_GAME | CVAR_BOOL, "draws trigger entities (orange) and thier targets (green).  disabled triggers are drawn grey." );
idCVar g_showCollisionWorld(		"g_showCollisionWorld",		"0",			CVAR_GAME | CVAR_BOOL, "" );
idCVar g_showCollisionModels(		"g_showCollisionModels",	"0",			CVAR_GAME | CVAR_INTEGER, "0 = off, 1 = draw collision models, 2 = only draw player collision models.  g_maxShowDistance controls distance." );

// rjohnson: added debug line drawing for traces
idCVar g_showCollisionTraces(		"g_showCollisionTraces",	"0",			CVAR_GAME | CVAR_INTEGER, "", 0, 2 );
// ddynerman: SD's clip sector code
idCVar g_showClipSectors(			"g_showClipSectors",		"0",			CVAR_GAME | CVAR_BOOL,	"" );
idCVar g_showClipSectorFilter(		"g_showClipSectorFilter",	"0",			CVAR_GAME,				"" );
idCVar g_showAreaClipSectors(		"g_showAreaClipSectors",	"0",			CVAR_GAME | CVAR_FLOAT, "" );

idCVar g_maxShowDistance(			"g_maxShowDistance",		"128",			CVAR_GAME | CVAR_FLOAT, "Distance at which to draw clipmodels and clipworld - Will significantly hurt performance at values above 512" );
idCVar g_showEntityInfo(			"g_showEntityInfo",			"0",			CVAR_GAME | CVAR_BOOL, "" );
idCVar g_showviewpos(				"g_showviewpos",			"0",			CVAR_GAME | CVAR_BOOL, "" );
idCVar g_showcamerainfo(			"g_showcamerainfo",			"0",			CVAR_GAME | PC_CVAR_ARCHIVE, "displays the current frame # for the camera when playing cinematics" );
idCVar g_showTestModelFrame(		"g_showTestModelFrame",		"0",			CVAR_GAME | CVAR_BOOL, "displays the current animation and frame # for testmodels" );
idCVar g_showActiveEntities(		"g_showActiveEntities",		"0",			CVAR_GAME | CVAR_BOOL, "draws boxes around thinking entities.  dormant entities (outside of pvs) are drawn yellow.  non-dormant are green." );
idCVar g_showEnemies(				"g_showEnemies",			"0",			CVAR_GAME | CVAR_BOOL, "draws boxes around monsters that have targeted the the player" );

idCVar g_frametime(					"g_frametime",				"0",			CVAR_GAME | CVAR_INTEGER, "displays timing information for each game frame" );
idCVar g_timeentities(				"g_timeEntities",			"0",			CVAR_GAME | CVAR_FLOAT, "when non-zero, shows entities whose think functions exceeded the # of milliseconds specified" );


// bdube: frame command debugging
idCVar g_showFrameCmds(				"g_showFrameCmds",			"0",			CVAR_GAME | CVAR_BOOL, "displays frame commands as they are executed" );
//idCVar g_showGodDamage(				"g_showGodDamage",			"0",			CVAR_GAME | CVAR_BOOL, "displays the amount of damage taken while in god mode on the hud" );


idCVar g_kickTime(					"g_kickTime",				"1",			CVAR_GAME | CVAR_FLOAT, "" );
idCVar g_kickAmplitude(				"g_kickAmplitude",			"0.0001",		CVAR_GAME | CVAR_FLOAT, "" );
idCVar g_blobTime(					"g_blobTime",				"1",			CVAR_GAME | CVAR_FLOAT, "" );
idCVar g_blobSize(					"g_blobSize",				"1",			CVAR_GAME | CVAR_FLOAT, "" );

idCVar g_testHealthVision(			"g_testHealthVision",		"0",			CVAR_GAME | CVAR_FLOAT, "" );
idCVar g_editEntityMode(			"g_editEntityMode",			"0",			CVAR_GAME | CVAR_INTEGER,	"0 = off\n"
																											"1 = lights\n"
																											"2 = sounds\n"
																											"3 = articulated figures\n"
																											"4 = particle systems\n"
																											"5 = monsters\n"
																											"6 = entity names\n"

// bdube: extended
																											"7 = entity models\n"
																											"8 = effects", 0, 8, idCmdSystem::ArgCompletion_Integer<0,8> );
// rhummer: Added archive flag.
idCVar g_editEntityDistance(		"g_editEntityDistance",		"512",			CVAR_GAME | CVAR_ARCHIVE,	"range to display entities to edit" );
// rhummer: Allow to customize the distance the text is drawn for edit entities, Zack request. Also added archive flag.
idCVar g_editEntityTextDistance(	"g_editEntityTextDistance",	"256",			CVAR_GAME | CVAR_ARCHIVE,	"range to display entities to edit text information");
idCVar g_testCTF(					"g_testCTF",				"0",			CVAR_GAME | CVAR_CHEAT | CVAR_BOOL, "" );
// rjohnson: entity usage stats
idCVar g_keepEntityStats(			"g_keepEntityStats",		"0",			CVAR_GAME | CVAR_CHEAT |CVAR_BOOL, "keep track of entity usage stats" );

idCVar g_dragEntity(				"g_dragEntity",				"0",			CVAR_GAME | CVAR_BOOL, "allows dragging physics objects around by placing the crosshair over them and holding the fire button" );
idCVar g_dragDamping(				"g_dragDamping",			"0.5",			CVAR_GAME | CVAR_FLOAT, "" );
idCVar g_dragShowSelection(			"g_dragShowSelection",		"0",			CVAR_GAME | CVAR_BOOL, "" );
idCVar g_dropItemRotation(			"g_dropItemRotation",		"",				CVAR_GAME, "" );

idCVar ik_enable(					"ik_enable",				"1",			CVAR_GAME | CVAR_BOOL, "enable IK" );
idCVar ik_debug(					"ik_debug",					"0",			CVAR_GAME | CVAR_BOOL, "show IK debug lines" );

idCVar af_useLinearTime(			"af_useLinearTime",			"1",			CVAR_GAME | CVAR_BOOL, "use linear time algorithm for tree-like structures" );
idCVar af_useImpulseFriction(		"af_useImpulseFriction",	"0",			CVAR_GAME | CVAR_BOOL, "use impulse based contact friction" );
idCVar af_useJointImpulseFriction(	"af_useJointImpulseFriction","0",			CVAR_GAME | CVAR_BOOL, "use impulse based joint friction" );
idCVar af_useSymmetry(				"af_useSymmetry",			"1",			CVAR_GAME | CVAR_BOOL, "use constraint matrix symmetry" );
idCVar af_skipSelfCollision(		"af_skipSelfCollision",		"0",			CVAR_GAME | CVAR_BOOL, "skip self collision detection" );
idCVar af_skipLimits(				"af_skipLimits",			"0",			CVAR_GAME | CVAR_BOOL, "skip joint limits" );
idCVar af_skipFriction(				"af_skipFriction",			"0",			CVAR_GAME | CVAR_BOOL, "skip friction" );
idCVar af_forceFriction(			"af_forceFriction",			"-1",			CVAR_GAME | CVAR_FLOAT, "force the given friction value" );
idCVar af_maxLinearVelocity(		"af_maxLinearVelocity",		"128",			CVAR_GAME | CVAR_FLOAT, "maximum linear velocity" );
idCVar af_maxAngularVelocity(		"af_maxAngularVelocity",	"1.57",			CVAR_GAME | CVAR_FLOAT, "maximum angular velocity" );
idCVar af_timeScale(				"af_timeScale",				"1",			CVAR_GAME | CVAR_FLOAT, "scales the time" );
idCVar af_jointFrictionScale(		"af_jointFrictionScale",	"0",			CVAR_GAME | CVAR_FLOAT, "scales the joint friction" );
idCVar af_contactFrictionScale(		"af_contactFrictionScale",	"0",			CVAR_GAME | CVAR_FLOAT, "scales the contact friction" );
idCVar af_highlightBody(			"af_highlightBody",			"",				CVAR_GAME, "name of the body to highlight" );
idCVar af_highlightConstraint(		"af_highlightConstraint",	"",				CVAR_GAME, "name of the constraint to highlight" );
idCVar af_showTimings(				"af_showTimings",			"0",			CVAR_GAME | CVAR_BOOL, "show articulated figure cpu usage" );
idCVar af_showConstraints(			"af_showConstraints",		"0",			CVAR_GAME | CVAR_BOOL, "show constraints" );
idCVar af_showConstraintNames(		"af_showConstraintNames",	"0",			CVAR_GAME | CVAR_BOOL, "show constraint names" );
idCVar af_showConstrainedBodies(	"af_showConstrainedBodies",	"0",			CVAR_GAME | CVAR_BOOL, "show the two bodies contrained by the highlighted constraint" );
idCVar af_showPrimaryOnly(			"af_showPrimaryOnly",		"0",			CVAR_GAME | CVAR_BOOL, "show primary constraints only" );
idCVar af_showTrees(				"af_showTrees",				"0",			CVAR_GAME | CVAR_BOOL, "show tree-like structures" );
idCVar af_showLimits(				"af_showLimits",			"0",			CVAR_GAME | CVAR_BOOL, "show joint limits" );
idCVar af_showBodies(				"af_showBodies",			"0",			CVAR_GAME | CVAR_BOOL, "show bodies" );
idCVar af_showBodyNames(			"af_showBodyNames",			"0",			CVAR_GAME | CVAR_BOOL, "show body names" );
idCVar af_showMass(					"af_showMass",				"0",			CVAR_GAME | CVAR_BOOL, "show the mass of each body" );
idCVar af_showTotalMass(			"af_showTotalMass",			"0",			CVAR_GAME | CVAR_BOOL, "show the total mass of each articulated figure" );
idCVar af_showInertia(				"af_showInertia",			"0",			CVAR_GAME | CVAR_BOOL, "show the inertia tensor of each body" );
idCVar af_showVelocity(				"af_showVelocity",			"0",			CVAR_GAME | CVAR_BOOL, "show the velocity of each body" );
idCVar af_showActive(				"af_showActive",			"0",			CVAR_GAME | CVAR_BOOL, "show tree-like structures of articulated figures not at rest" );
idCVar af_testSolid(				"af_testSolid",				"1",			CVAR_GAME | CVAR_BOOL, "test for bodies initially stuck in solid" );

idCVar rb_showTimings(				"rb_showTimings",			"0",			CVAR_GAME | CVAR_BOOL, "show rigid body cpu usage" );
idCVar rb_showBodies(				"rb_showBodies",			"0",			CVAR_GAME | CVAR_BOOL, "show rigid bodies" );
idCVar rb_showMass(					"rb_showMass",				"0",			CVAR_GAME | CVAR_BOOL, "show the mass of each rigid body" );
idCVar rb_showInertia(				"rb_showInertia",			"0",			CVAR_GAME | CVAR_BOOL, "show the inertia tensor of each rigid body" );
idCVar rb_showVelocity(				"rb_showVelocity",			"0",			CVAR_GAME | CVAR_BOOL, "show the velocity of each rigid body" );
idCVar rb_showActive(				"rb_showActive",			"0",			CVAR_GAME | CVAR_BOOL, "show rigid bodies that are not at rest" );


// bdube: more rigid body debug
idCVar rb_showContacts(				"rb_showContacts",			"0",			CVAR_GAME | CVAR_BOOL, "show rigid body contacts" );

// 3j_todo: clean this shit up

// The default values for player movement cvars are set in def/player.def
idCVar pm_jumpheight(				"pm_jumpheight",			"48",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "approximate hieght the player can jump" );
idCVar pm_stepsize(					"pm_stepsize",				"16",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "maximum height the player can step up without jumping" );
//idCVar pm_crouchspeed(			"pm_crouchspeed",			"80",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "speed the player can move while crouched" );

//idCVar pm_speed(					"pm_speed",					"160",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "speed the player can move while running" );
//idCVar pm_walkspeed(				"pm_walkspeed",				"80",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "speed the player can move while walking" );

idCVar pm_noclipspeed(				"pm_noclipspeed",			"270",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "speed the player can move while in noclip" );
idCVar pm_spectatespeed(			"pm_spectatespeed",			"450",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "speed the player can move while spectating" );
idCVar pm_spectatebbox(				"pm_spectatebbox",			"32",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "size of the spectator bounding box" );
idCVar pm_usecylinder(				"pm_usecylinder",			"0",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_BOOL | CVAR_NORESET, "use a cylinder approximation instead of a bounding box for player collision detection" );
idCVar pm_minviewpitch(				"pm_minviewpitch",			"-89",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "amount player's view can look up (negative values are up)" );
idCVar pm_maxviewpitch(				"pm_maxviewpitch",			"89",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "amount player's view can look down" );
//idCVar pm_stamina(					"pm_stamina",				"24",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "length of time player can run" );
//idCVar pm_staminathreshold(			"pm_staminathreshold",		"45",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "when stamina drops below this value, player gradually slows to a walk" );
//idCVar pm_staminarate(			"pm_staminarate",			"0.75",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "rate that player regains stamina. divide pm_stamina by this value to determine how long it takes to fully recharge." );


// ddynerman: adjusted bboxes to actual height
idCVar pm_normalheight(				"pm_normalheight",			"77",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "height of player's bounding box while standing" );
idCVar pm_crouchheight(				"pm_crouchheight",			"49",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "height of player's bounding box while crouched" );

idCVar pm_crouchviewheight(			"pm_crouchviewheight",		"36",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "height of player's view while crouched" );
idCVar pm_normalviewheight(			"pm_normalviewheight",		"72",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "height of player's view while standing" );

idCVar pm_deadheight(				"pm_deadheight",			"20",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "height of player's bounding box while dead" );
idCVar pm_deadviewheight(			"pm_deadviewheight",		"10",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "height of player's view while dead" );
idCVar pm_crouchrate(				"pm_crouchrate",			"0.87",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "time it takes for player's view to change from standing to crouching" );
idCVar pm_bboxwidth(				"pm_bboxwidth",				"32",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NORESET, "x/y size of player's bounding box" );
//idCVar pm_crouchbob(				"pm_crouchbob",				"0.5",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NOCHEAT | CVAR_NORESET, "bob much faster when crouched" );
//idCVar pm_walkbob(				"pm_walkbob",				"0.3",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NOCHEAT | CVAR_NORESET, "bob slowly when walking" );
//idCVar pm_runbob(					"pm_runbob",				"0.4",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NOCHEAT | CVAR_NORESET, "bob faster when running" );
//idCVar pm_runpitch(				"pm_runpitch",				"0.002",		CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NOCHEAT | CVAR_NORESET, "" );
//idCVar pm_runroll(				"pm_runroll",				"0.005",		CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NOCHEAT | CVAR_NORESET, "" );
//idCVar pm_bobup(					"pm_bobup",					"0.005",		CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT | CVAR_NOCHEAT | CVAR_NORESET, "" );
idCVar pm_bobpitch(					"pm_bobpitch",				"0.002",		CVAR_GAME | /*CVAR_NETWORKSYNC |*/ CVAR_FLOAT | CVAR_NOCHEAT | CVAR_NORESET | PC_CVAR_ARCHIVE, "" );
idCVar pm_bobroll(					"pm_bobroll",				"0.002",		CVAR_GAME | /*CVAR_NETWORKSYNC |*/ CVAR_FLOAT | CVAR_NOCHEAT | PC_CVAR_ARCHIVE, "" );
idCVar pm_thirdPersonRange(			"pm_thirdPersonRange",		"80",			CVAR_GAME | CVAR_FLOAT | CVAR_NORESET, "camera distance from player in 3rd person" );
idCVar pm_thirdPersonHeight(		"pm_thirdPersonHeight",		"0",			CVAR_GAME | CVAR_FLOAT | CVAR_NORESET, "height of camera from normal view height in 3rd person" );
idCVar pm_thirdPersonAngle(			"pm_thirdPersonAngle",		"0",			CVAR_GAME | CVAR_FLOAT | CVAR_NORESET, "direction of camera from player in 3rd person in degrees (0 = behind player, 180 = in front)" );
idCVar pm_thirdPersonClip(			"pm_thirdPersonClip",		"1",			CVAR_GAME | CVAR_BOOL, "clip third person view into world space" );
idCVar pm_thirdPerson(				"pm_thirdPerson",			"0",			CVAR_GAME | CVAR_BOOL, "enables third person view" );
idCVar pm_thirdPersonDeath(			"pm_thirdPersonDeath",		"0",			CVAR_GAME | CVAR_BOOL, "enables third person view when player dies" );
idCVar pm_modelView(				"pm_modelView",				"0",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_INTEGER, "draws camera from POV of player model (1 = always, 2 = when dead)", 0, 2, idCmdSystem::ArgCompletion_Integer<0,2> );

//idCVar pm_zoomedSlow(				"pm_zoomedSlow",			"100",			CVAR_GAME | CVAR_ARCHIVE | CVAR_INTEGER | CVAR_NOCHEAT | CVAR_NORESET, "Slow look speed while zoomed 0..100% of speed");
idCVar pm_isZoomed(					"pm_isZoomed",				"0",			CVAR_GAME | CVAR_INTEGER | CVAR_NOCHEAT | CVAR_NORESET, "used by code");

// nmckenzie: added ability to try alternate accelerations.
// 3j: added our own
//idCVar pm_acceloverride(			"pm_acceloverride",			"0",			CVAR_GAME | CVAR_FLOAT, "Adjust the player acceleration." );
idCVar pm_frictionoverride(			"pm_frictionoverride",		"-1",			CVAR_GAME | CVAR_FLOAT, "Adjust the player friciton." );
idCVar pm_forcespectatormove(		"pm_forcespectatormove",	"0",			CVAR_GAME | CVAR_FLOAT, "Force the player to move like a spectator (fly)." );

idCVar g_showPlayerShadow(			"g_showPlayerShadow",		"0",			CVAR_GAME | PC_CVAR_ARCHIVE | CVAR_BOOL, "enables shadow of player model" );

idCVar g_skipPlayerShadowsMP(		"g_skipPlayerShadowsMP",	"0",			CVAR_GAME | PC_CVAR_ARCHIVE | CVAR_BOOL, "disables all player shadows in multiplayer" );
idCVar g_skipItemShadowsMP(			"g_skipItemShadowsMP",		"0",			CVAR_GAME | PC_CVAR_ARCHIVE | CVAR_BOOL, "disables all item shadows in multiplayer" );

idCVar g_showHud(					"g_showHud",				"1",			CVAR_GAME | PC_CVAR_ARCHIVE | CVAR_BOOL, "" );

// dluetscher: changed to g_brassTime
//idCVar g_brassTime(					"g_brassTime",				"1",			CVAR_GAME | PC_CVAR_ARCHIVE | CVAR_FLOAT, "amount of time brass should stay in the world before dissapearing, set to 0 to disable brass" );

idCVar g_gun_x(						"g_gunX",					"0",			CVAR_GAME | CVAR_FLOAT, "" );
idCVar g_gun_y(						"g_gunY",					"0",			CVAR_GAME | CVAR_FLOAT, "" );
idCVar g_gun_z(						"g_gunZ",					"0",			CVAR_GAME | CVAR_FLOAT, "" );
idCVar g_viewNodalX(				"g_viewNodalX",				"0",			CVAR_GAME | CVAR_FLOAT, "" );
idCVar g_viewNodalZ(				"g_viewNodalZ",				"0",			CVAR_GAME | CVAR_FLOAT, "" );

idCVar g_fov(						"g_fov",					"90",			CVAR_GAME | CVAR_FLOAT | CVAR_NOCHEAT | PC_CVAR_ARCHIVE, "Field of View" );
idCVar g_zoomfov(					"g_zoomfov",				"35",			CVAR_GAME | CVAR_FLOAT | CVAR_NOCHEAT | PC_CVAR_ARCHIVE, "Field of View while zoomed" );

idCVar g_skipViewEffects(			"g_skipViewEffects",		"0",			CVAR_GAME | CVAR_BOOL, "skip damage and other view effects" );
idCVar g_mpWeaponAngleScale(		"g_mpWeaponAngleScale",		"0",			CVAR_GAME | CVAR_FLOAT, "Control the weapon sway in MP" );


// bdube: crosshairs
// mekberg: custom size
idCVar g_crosshairSize(				"g_crosshairSize",			"32",			CVAR_GAME | CVAR_INTEGER | CVAR_ARCHIVE, "crosshair size: 16,24,32,40,48", 16, 48 );
idCVar g_crosshairColor(			"g_crosshairColor",			"1 1 1 1", CVAR_GAME | CVAR_ARCHIVE, "sets the combat crosshair color" );
// cnicholson: Custom crosshair
idCVar g_crosshairCustom(			"g_crosshairCustom",		"0",			CVAR_GAME | PC_CVAR_ARCHIVE, "sets the custom combat crosshair" );
idCVar g_crosshairCustomFile(		"g_crosshairCustomFile",	"0",			CVAR_GAME | PC_CVAR_ARCHIVE, "stores the custom crosshair's filename" );
idCVar g_crosshairCharInfoFar(		"g_crosshairCharInfoFar",	"1",			CVAR_GAME | CVAR_BOOL, "instead of a green crosshair from far away, full character info always draws" );
// bdube: database entries
idCVar g_showHudPopups(				"g_showHudPopups",			"1",			CVAR_GAME | PC_CVAR_ARCHIVE | CVAR_BOOL, "displays objective and database popups on the hud" );
idCVar g_showRange(					"g_showRange",				"0",			CVAR_GAME | CVAR_CHEAT | CVAR_BOOL, "shows the range from the player to the first collision under the players crosshair" );
// bdube: debug hud
idCVar g_showDebugHud(				"g_showDebugHud",			"0",			CVAR_GAME | CVAR_INTEGER, "displays the debug hud\n"
																										  "0  = off\n"
																										  "1  = player\n"
																										  "2  = physics\n"
																										  "3  = AI\n"
																										  "4  = vehicle\n"
																										  "5  = performance\n"
																										  "6  = effects\n"
																										  "7  = map information\n"
																										  "8  = AI performance\n"
																										  "9  = MP\n"
																										  "10 = Sound\n"
																										  "32 = scratch\n" );
// bdube: cvar for messing with foreshortening and gun position
idCVar g_gun_pitch(					"g_gunPitch",				"0",			CVAR_GAME | CVAR_FLOAT,		"" );
idCVar g_gun_yaw(					"g_gunYaw",					"0",			CVAR_GAME | CVAR_FLOAT,		"" );
idCVar g_gun_roll(					"g_gunRoll",				"0",			CVAR_GAME | CVAR_FLOAT,		"" );

// jscott: cvar for debugging playbacks
idCVar g_showPlayback(				"g_showPlayback",			"0",			CVAR_GAME | CVAR_INTEGER, "show g_currentPlayback" );
idCVar g_currentPlayback(			"g_currentPlayback",		"",				CVAR_GAME, "name of playback shown by g_showPlayback" );
// jscott: unused
//idCVar g_testParticle(				"g_testParticle",			"0",			CVAR_GAME | CVAR_INTEGER, "test particle visualation, set by the particle editor" );
//idCVar g_testParticleName(			"g_testParticleName",		"",				CVAR_GAME, "name of the particle being tested by the particle editor" );

idCVar g_testModelRotate(			"g_testModelRotate",		"0",			CVAR_GAME, "test model rotation speed" );
idCVar g_testPostProcess(			"g_testPostProcess",		"",				CVAR_GAME, "name of material to draw over screen" );
idCVar g_testModelAnimate(			"g_testModelAnimate",		"0",			CVAR_GAME | CVAR_INTEGER, "test model animation,\n"
																							"0 = cycle anim with origin reset\n"
																							"1 = cycle anim with fixed origin\n"
																							"2 = cycle anim with continuous origin\n"
																							"3 = frame by frame with continuous origin\n"
																							"4 = play anim once\n"
																							"5 = frame by frame with fixed origin", 0, 5, idCmdSystem::ArgCompletion_Integer<0,5> );
idCVar g_testModelBlend(			"g_testModelBlend",			"0",			CVAR_GAME | CVAR_INTEGER, "number of frames to blend" );
idCVar g_testDeath(					"g_testDeath",				"0",			CVAR_GAME | CVAR_BOOL, "" );

idCVar g_testPlayer(				"g_testPlayer",				"",				CVAR_GAME, "test player classname" );

idCVar g_exportMask(				"g_exportMask",				"",				CVAR_GAME, "" );
idCVar g_flushSave(					"g_flushSave",				"0",			CVAR_GAME | CVAR_BOOL, "1 = don't buffer file writing for save games." );

idCVar g_password(					"g_password",				"",				CVAR_GAME | PC_CVAR_ARCHIVE, "game password" );
idCVar password(					"password",					"",				CVAR_GAME | CVAR_NOCHEAT, "client password used when connecting" );


// ddynerman: TODO extended pause default, temp for stats testing, should be replaced by stats tabs
idCVar g_gameReviewPause(			"g_gameReviewPause",		"30",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_INTEGER | PC_CVAR_ARCHIVE, "scores review time in seconds (at end game)", 2, 3600 );

idCVar net_clientPredictGUI(		"net_clientPredictGUI",		"1",			CVAR_GAME | CVAR_BOOL, "test guis in networking without prediction" );

idCVar si_voteFlags(				"si_voteFlags",				"0",			CVAR_GAME | CVAR_SERVERINFO | CVAR_INTEGER | PC_CVAR_ARCHIVE, "vote flags. bit mask of votes not allowed on this server\n"
																					"bit  0 (+1)    restart now\n"
																					"bit  1 (+2)    min players\n"
																					"bit  2 (+4)    auto balance teams\n"
																					"bit  3 (+8)    shuffle teams\n"
																					"bit  4 (+16)   kick player\n"
																					"bit  5 (+32)   change map\n"
																					"bit  6 (+64)   change gametype\n"
																					"bit  7 (+128)  time limit\n"
																					"bit  8 (+256)  tourney limit\n"
																					"bit  9 (+512)  capture limit\n"
																					"bit 10 (+1024) frag limit" );

idCVar net_warnStale( "net_warnStale", "1", CVAR_INTEGER | CVAR_GAME | CVAR_NOCHEAT, "Warn stale entity occurences on network client - == 1: only on ClientStale call, > 1 all times" );


// bdube: client entitiy cvars
idCVar g_gamelog(						"g_gamelog",					"0",			CVAR_GAME | CVAR_BOOL, "enables game logging" );
idCVar cl_showEntityInfo(			"cl_showEntityInfo",		"0",			CVAR_GAME | CVAR_BOOL, "" );
// ddynerman: announcer delay time
idCVar g_announcerDelay( "g_announcerDelay", "1000", CVAR_SOUND | PC_CVAR_ARCHIVE, "no more than one announcer sound will be played in this many ms" );
// jnewquist: Option to force undying state
idCVar g_forceUndying(				"g_forceUndying",			"0",			CVAR_GAME | CVAR_BOOL, "forces undying state" );
// mcg: combat performance testing cvars

/*
idCVar g_perfTest_weaponNoFX(				"g_perfTest_weaponNoFX",			"0",			CVAR_GAME | CVAR_BOOL, "no muzzle flash, brass eject, muzzle fx, tracers, impact fx, blood decals or blood splats (whew!)" );
idCVar g_perfTest_hitscanShort(				"g_perfTest_hitscanShort",			"0",			CVAR_GAME | CVAR_BOOL, "all hitscans capped at 2048" );
idCVar g_perfTest_hitscanBBox(				"g_perfTest_hitscanBBox",			"0",			CVAR_GAME | CVAR_BOOL, "all hitscans vs bbox, not rendermodel" );
idCVar g_perfTest_aiStationary(				"g_perfTest_aiStationary",			"0",			CVAR_GAME | CVAR_BOOL, "ai attempts no combat movement" );
idCVar g_perfTest_aiNoDodge(				"g_perfTest_aiNoDodge",				"0",			CVAR_GAME | CVAR_BOOL, "ai attempts no dodging" );
idCVar g_perfTest_aiNoRagdoll(				"g_perfTest_aiNoRagdoll",			"0",			CVAR_GAME | CVAR_BOOL, "ai does not ragdoll" );
idCVar g_perfTest_aiNoObstacleAvoid(		"g_perfTest_aiNoObstacleAvoid",		"0",			CVAR_GAME | CVAR_BOOL, "ai does not attempt obstacle avoidance" );
idCVar g_perfTest_aiUndying(				"g_perfTest_aiUndying",				"0",			CVAR_GAME | CVAR_BOOL, "makes all AI undying" );
idCVar g_perfTest_aiNoVisTrace(				"g_perfTest_aiNoVisTrace",			"0",			CVAR_GAME | CVAR_BOOL, "ai does no vis traces" );
idCVar g_perfTest_noJointTransform(			"g_perfTest_noJointTransform",		"0",			CVAR_GAME | CVAR_BOOL, "all joint transforms return origin" );
idCVar g_perfTest_noPlayerFocus(			"g_perfTest_noPlayerFocus",			"0",			CVAR_GAME | CVAR_BOOL, "doesn't do player focus traces/logic" );
idCVar g_perfTest_noProjectiles(			"g_perfTest_noProjectiles",			"0",			CVAR_GAME | CVAR_BOOL, "all projectiles are removed instantly" );
*/

idCVar g_clientProjectileCollision(			"g_clientProjectileCollision",		"1",			CVAR_GAME | CVAR_BOOL | CVAR_NOCHEAT, "allow the client to predict collisions" );

// jnewquist: Not using DLLs on Xenon
// TTimo: bad f*g aliasing for no good reason
#ifdef GAME_DLL
idCVar r_shadows( "r_shadows", "1", CVAR_RENDERER | CVAR_BOOL  | CVAR_ARCHIVE, "enable shadows" );
#endif


idCVar net_serverDownload(			"net_serverDownload",		"0",			CVAR_GAME | CVAR_INTEGER | CVAR_ARCHIVE, "enable server download redirects. 0: off 1: client exits and opens si_serverURL in web browser 2: client downloads pak files from an URL and connects again. See net_serverDl* cvars for configuration" );
idCVar net_serverDlBaseURL(			"net_serverDlBaseURL",		"",				CVAR_GAME | CVAR_ARCHIVE, "base URL for the download redirection" );
idCVar net_serverDlTable(			"net_serverDlTable",		"",				CVAR_GAME | CVAR_ARCHIVE, "pak names for which download is provided, seperated by ; - use a * to mark all paks" );

idCVar si_serverURL(				"si_serverURL",				"",				CVAR_GAME | CVAR_SERVERINFO | CVAR_ARCHIVE, "server information page" );



// GTR bandit: Unlagged Code
idCVar g_unlagged(					"g_unlagged",				"1",			CVAR_GAME | CVAR_BOOL | PC_CVAR_ARCHIVE, "enables unlagged code." );
idCVar g_unlaggedMaxPing(			"g_unlaggedMaxPing",		"80",			CVAR_GAME | CVAR_INTEGER | PC_CVAR_ARCHIVE, "maximum ping allowed to compensate" );


// bdube: cvar helps
static	idCVarHelp	help_g_showHud ( "g_showHud", "Show Player HUD", "Off;On", "0;1", CVARHELP_GAME );
static	idCVarHelp	help_g_showGun ( "g_showGun", "Show Player Weapon", "Off;On", "0;1", CVARHELP_GAME );
static	idCVarHelp	help_g_showTargets ( "g_showTargets", "Show Targets", "Off;On", "0;1", CVARHELP_GAME );
static	idCVarHelp	help_g_showTriggers ( "g_showTriggers", "Show Triggers", "Off;On", "0;1", CVARHELP_GAME );
static	idCVarHelp	help_g_showEntityInfo ( "g_showEntityInfo", "Show Entity Information", "Off;On", "0;1", CVARHELP_GAME );
static	idCVarHelp	help_g_timeentities ( "g_timeentities", "Show Entity Times", "Off;0.5s;1.0s", "0;0.5;1.0", CVARHELP_GAME );
static	idCVarHelp	help_g_showActiveEntities ( "g_showActiveEntities", "Show Active Entities", "Off;On", "0;1", CVARHELP_GAME );
static	idCVarHelp	help_g_frametime ( "g_frametime", "Show Game Frame Times", "Off;On", "0;1", CVARHELP_GAME );

static	idCVarHelp	help_g_showCollisionWorld ( "g_showCollisionWorld", "Show Collision World", "Off;On", "0;1", CVARHELP_PHYSICS );
static	idCVarHelp	help_g_showCollisionModels ( "g_showCollisionModels", "Show Collision Models", "Off;On", "0;1", CVARHELP_PHYSICS );
static	idCVarHelp	help_g_showCollisionTraces ( "g_showCollisionTraces", "Show Collision Traces", "Off;Info;Lines", "0;1;2", CVARHELP_PHYSICS );
static	idCVarHelp	help_rb_showActive ( "rb_showActive", "Show Active Rigid Bodies", "Off;On", "0;1", CVARHELP_PHYSICS );
static	idCVarHelp	help_rb_showTimings ( "rb_showTimings", "Show Rigid Body Timings", "Off;On", "0;1", CVARHELP_PHYSICS );
static	idCVarHelp	help_af_showTimings ( "af_showTimings", "Show AF Timings", "Off;On", "0;1", CVARHELP_PHYSICS );
