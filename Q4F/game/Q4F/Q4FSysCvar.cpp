#include "../../idlib/precompiled.h"

#pragma hdrstop

#include "../Game_local.h"

// GUIS

idCVar gui_tcolor0_r( "gui_tcolor0_red", "", CVAR_GAME | CVAR_NOCHEAT, "gui tmp" );
idCVar gui_tcolor0_g( "gui_tcolor0_green", "", CVAR_GAME | CVAR_NOCHEAT, "gui tmp" );
idCVar gui_tcolor0_b( "gui_tcolor0_blue", "", CVAR_GAME | CVAR_NOCHEAT, "gui tmp" );

idCVar gui_tcolor1_r( "gui_tcolor1_red", "", CVAR_GAME | CVAR_NOCHEAT, "gui tmp" );
idCVar gui_tcolor1_g( "gui_tcolor1_green", "", CVAR_GAME | CVAR_NOCHEAT, "gui tmp" );
idCVar gui_tcolor1_b( "gui_tcolor1_blue", "", CVAR_GAME | CVAR_NOCHEAT, "gui tmp" );

idCVar gui_tcolor2_r( "gui_tcolor2_red", "", CVAR_GAME | CVAR_NOCHEAT, "gui tmp" );
idCVar gui_tcolor2_g( "gui_tcolor2_green", "", CVAR_GAME | CVAR_NOCHEAT, "gui tmp" );
idCVar gui_tcolor2_b( "gui_tcolor2_blue", "", CVAR_GAME | CVAR_NOCHEAT, "gui tmp" );

idCVar gui_tcolor3_r( "gui_tcolor3_red", "", CVAR_GAME | CVAR_NOCHEAT, "gui tmp" );
idCVar gui_tcolor3_g( "gui_tcolor3_green", "", CVAR_GAME | CVAR_NOCHEAT, "gui tmp" );
idCVar gui_tcolor3_b( "gui_tcolor3_blue", "", CVAR_GAME | CVAR_NOCHEAT, "gui tmp" );

idCVar pm_airMaxYaw(			"pm_airMaxYaw",			"10",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT,		"" );
idCVar pm_airAccel(				"pm_airAccel",			"1",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT,		"" );
idCVar pm_airWishSpeedMult(		"pm_airWishSpeedMult",	".8",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT,		"" );
idCVar pm_jumpOffNormal(		"pm_jumpOffNormal",		"0",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_BOOL,		"" );

// TEMPORARIES
idCVar q4f_rj(					"q4f_rj",				"2",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_FLOAT,		"Rocketjump modifier" );
//idCVar q4f_hitscanCorrection(	"q4f_hitscanCorrection", "1",			CVAR_GAME | CVAR_NETWORKSYNC | CVAR_BOOL, "" );

idCVar ui_pogostick(			"ui_pogostick",			"1",			CVAR_GAME | CVAR_BOOL | CVAR_ARCHIVE | CVAR_USERINFO,			"Whether or not to 'pogostick' when holding jump key" );
idCVar ui_adjustSpeed(			"ui_adjustSpeed",		"1",			CVAR_GAME | CVAR_BOOL | CVAR_ARCHIVE | CVAR_USERINFO,			"Automatically adjust spy speed to the disguised class." );

idCVar q4f_primethrow(			"q4f_primethrow",		"1",			CVAR_GAME | CVAR_BOOL | CVAR_ARCHIVE,			"Pressing primeone or primetwo when a grenade is primed will throw it." );
idCVar q4f_autozoom(			"q4f_autozoom",			"0",			CVAR_GAME | CVAR_BOOL | CVAR_ARCHIVE,			"Auto zoom with the sniper rifle." );


idCVar q4f_primeSoundPrimary(		"q4f_primeSoundPrimary",		"1",			CVAR_GAME | CVAR_INTEGER | CVAR_ARCHIVE,		"The grenade prime sound # to play upon priming a primary grenade. Valid values are [0->5]. 0 is none." );
idCVar q4f_primeSoundSecondary(		"q4f_primeSoundSecondary",		"1",			CVAR_GAME | CVAR_INTEGER | CVAR_ARCHIVE,		"The grenade prime sound # to play upon priming a secondary grenade. Valid values are [0->5]. 0 is none." );
idCVar q4f_grenadeTimer(			"q4f_grenadeTimer",				"1",			CVAR_GAME | CVAR_INTEGER | CVAR_ARCHIVE,		"Draw the visual grenade timer around the crosshair." );

idCVar si_teamHealthDamage(			"si_teamHealthDamage",		"1",			CVAR_GAME | CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_FLOAT, "How much health a team attack should take off. Range is [-1.0,1.0]\nNegative values provide mirror damage ( attacker damages himself ).\nEx: 1.0 is full health loss, 0.0 is no health loss, -0.5 is half mirror." );
idCVar si_teamArmorDamage(			"si_teamArmorDamage",		"1",			CVAR_GAME | CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_FLOAT, "How much armor a team attack should take off. Range is [-1.0,1.0]\nNegative values provide mirror damage ( attacker damages himself ).\nEx: 1.0 is full armor loss, 0.0 is no armor loss, -0.5 is half mirror." );
idCVar si_teamAffects(				"si_teamAffliction",		"1",			CVAR_GAME | CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_FLOAT, "How much team players are affected by each other's afflictions ( conc, flash, tranquilizer, etc ). Range is [-1.0,1.0].\n 1.0 is full effect, 0 is no effect, -1 is mirror effect ( conc thrower is conced, etc... )." );

idCVar si_gameindex(				"si_gameindex",				"1",			CVAR_GAME | CVAR_SERVERINFO | CVAR_INTEGER				 , "The current gameindex to use for gameplay." );

idCVar si_prematch(					"si_prematch",				"0",			CVAR_GAME | CVAR_SERVERINFO | CVAR_INTEGER			   , "# of seconds of prematch to do." );
idCVar si_matchwait(				"si_matchwait",				"0",			CVAR_GAME | CVAR_SERVERINFO | CVAR_INTEGER			   , "# of seconds to wait for all players finish loading the map." );

idCVar q4f_useCustomColors(			"q4f_useCustomColors",		"0",			CVAR_GAME | CVAR_INTEGER | PC_CVAR_ARCHIVE				, "0 = do not use custom colors.\n1 = Your team color is always the same.\n2 = team#color is the color of the corresponging team #" );
idCVar q4f_team0color(				"q4f_team1color",			"0 1 0",		CVAR_GAME | PC_CVAR_ARCHIVE								, "If q4f_useCustomColors is 1, this is your team color.\nIf q4f_useCustomColors is 2, this is team 1's color." );
idCVar q4f_team1color(				"q4f_team2color",			"1 1 0",		CVAR_GAME | PC_CVAR_ARCHIVE								, "If q4f_useCustomColors is 1, this is the first enemy color.\nIf q4f_useCustomColors is 2, this is team 2's color." );
idCVar q4f_team2color(				"q4f_team3color",			"1 0 0",		CVAR_GAME | PC_CVAR_ARCHIVE								, "If q4f_useCustomColors is 1, this is the second enemy color.\nIf q4f_useCustomColors is 2, this is team 3's color." );
idCVar q4f_team3color(				"q4f_team4color",			"1 0 1",		CVAR_GAME | PC_CVAR_ARCHIVE								, "If q4f_useCustomColors is 1, this is the third enemy color.\nIf q4f_useCustomColors is 2, this is team 3's color." );

idCVar q4f_sniperDotScale(			"q4f_sniperDotScale",		"2",			CVAR_GAME | PC_CVAR_ARCHIVE	| CVAR_FLOAT				, "Scale the sniper dot.", 0.01f, 5.0f );

idCVar q4f_drawItemTriggers(		"q4f_drawItemTriggers",		"0",			CVAR_GAME | CVAR_BOOL | CVAR_CHEAT,						 "Draw the trigger bounds for TF Items." );

idCVar q4f_lightDetailLevel(		"q4f_lightDetailLevel",		"1.0",			CVAR_GAME | CVAR_FLOAT | PC_CVAR_ARCHIVE				, "Don't display lights above this detail" , 0.0f, 1.0f );
idCVar q4f_ambientLighting(			"q4f_ambientLighting",		"0",			CVAR_GAME | CVAR_BOOL | PC_CVAR_ARCHIVE					, "Enable single ambient lighting" );

idCVar q4f_execClassConfigs(		"q4f_execClassConfigs",		"1",			CVAR_GAME | CVAR_INTEGER | PC_CVAR_ARCHIVE				, "When to execute class configs. 0 = never, 1 = on first spawn, 2 = on every spawn." );
idCVar q4f_execMapConfigs(			"q4f_execMapConfigs",		"1",			CVAR_GAME | CVAR_BOOL | PC_CVAR_ARCHIVE					, "Automatically execute map configs on map load?" );

idCVar q4f_showProjectileTrails(	"q4f_showProjectileTrails",		"1",		CVAR_GAME | CVAR_BOOL | PC_CVAR_ARCHIVE					, "Draw projectile trails." );
idCVar q4f_showGibs(				"q4f_showGibs",					"1",		CVAR_GAME | CVAR_BOOL | PC_CVAR_ARCHIVE					, "Draw giblets when players explode :)." );
idCVar q4f_showBlood(				"q4f_showBlood",				"1",		CVAR_GAME | CVAR_BOOL | PC_CVAR_ARCHIVE					, "Draw blood when damaged." );
idCVar q4f_showDamageBlip(			"q4f_showDamageBlip",			"1",		CVAR_GAME | CVAR_BOOL | PC_CVAR_ARCHIVE					, "Show the damage blip on the hud that indicates what direction the damage came from" );

const char *q4f_scoreboardSortArgs[] = { "ScoreDEC", "ScoreASC", "FragsDEC", "FragsASC", NULL }; 
idCVar q4f_scoreboardSort(					"q4f_scoreboardSort",			q4f_scoreboardSortArgs[0],		CVAR_GAME | PC_CVAR_ARCHIVE			, "How to sort the scoreboard", idCmdSystem::ArgCompletion_String<q4f_scoreboardSortArgs>  );

const char *q4f_scoreboardGroupArgs[] = { "Team", "None", NULL }; 
idCVar q4f_scoreboardGroup(					"q4f_scoreboardGroup",			q4f_scoreboardGroupArgs[0],		CVAR_GAME | PC_CVAR_ARCHIVE			, "How to group players on the scoreboard", idCmdSystem::ArgCompletion_String<q4f_scoreboardGroupArgs>  );

idCVar ui_showradar(				"ui_showradar",					"0",			CVAR_GAME | CVAR_BOOL | CVAR_USERINFO | PC_CVAR_ARCHIVE,				"Toggle the radar" );

idCVar q4f_awardsScript(			"q4f_awardsScript",				"awards.scriptcfg",			CVAR_GAME | PC_CVAR_ARCHIVE,				"the file to read awards from. See awards.scriptcfg" );

idCVar q4f_impulseBound(			"g_impulseBound",				"0",			CVAR_GAME | CVAR_BOOL | PC_CVAR_ARCHIVE, "" );

