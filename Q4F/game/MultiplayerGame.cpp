
// ddynerman: note that this file is no longer merged with Doom3 updates
//
// MERGE_DATE 09/30/2004

#include "../idlib/precompiled.h"
#pragma hdrstop

#include "Game_local.h"

idCVar g_spectatorChat( "g_spectatorChat", "0", CVAR_GAME | CVAR_ARCHIVE | CVAR_BOOL, "let spectators talk to everyone during game" );

const char* Q4F_MENU = "/guis/q4fmenu.gui";

const char *idMultiplayerGame::MPGuis[] = {

// bdube: use regular hud for now
	"guis/q4fhud.gui",			// 0

	"guis/q4fmenu.gui",		// 1
	"guis/mpmsgmode.gui",	// 2
	"guis/netmenu.gui",		// 3
	"guis/q4fmphud.gui",	// 4
	"guis/q4fmenu.gui",	// 5
	NULL
};

const char *idMultiplayerGame::ThrottleVars[] = {
	"ui_ready",
	NULL
};

const char *idMultiplayerGame::ThrottleVarsInEnglish[] = {
	"#str_106738",
	"#str_106737",
	"#str_101991",
	NULL
};

const int idMultiplayerGame::ThrottleDelay[] = {
	8,
	5,
	5
};

/*
================
ComparePlayerByScore
================
*/
int ComparePlayersByScore( const void* left, const void* right ) {
	return ((const rvPair<idPlayer*, int>*)right)->Second() - 
		((const rvPair<idPlayer*, int>*)left)->Second();
}

/*
================
CompareTeamByScore
================
*/
int CompareTeamsByScore( const void* left, const void* right ) {
	return ((const rvPair<int, int>*)right)->Second() - 
	 		((const rvPair<int, int>*)left)->Second();
}

/*
================
idMultiplayerGame::idMultiplayerGame
================
*/
idMultiplayerGame::idMultiplayerGame() {
	scoreBoard = NULL;
	mainGui = NULL;
	mapList = NULL;
	msgmodeGui = NULL;
	maphud = NULL;

	memset( mapGuiVars, 0, sizeof( mapGuiVars ) );

	memset ( lights, 0, sizeof( lights ) );
	memset ( lightHandles, -1, sizeof( lightHandles ) );

	Clear();

	announcerSoundQueue.Clear();
	announcerPlayTime = 0;

	currentSoundOverride = false;

	privatePlayers = 0;
	lastAnnouncerSound = AS_NUM_SOUNDS;

	playChatSound = false;
}

/*
================
idMultiplayerGame::Shutdown
================
*/
void idMultiplayerGame::Shutdown( void ) {

	Clear();
	tfStatManager->ShutDown();
	voteSystem.Shutdown();

	gameState.Clear();
}

/*
================
idMultiplayerGame::Reset
================
*/
void idMultiplayerGame::Reset() {
	Clear();
	assert( !scoreBoard && !mainGui && !mapList );
	
	scoreBoard = uiManager->FindGui( "guis/scoreboard.gui", true, false, true );

	mainGui = uiManager->FindGui( MPGuis[1], true, false, true );
	mapList = uiManager->AllocListGUI( );
	mapList->Config( mainGui, "mapList" );
	
	// set this GUI so that our Draw function is still called when it becomes the active/fullscreen GUI
	mainGui->SetStateBool( "gameDraw", true );
	mainGui->SetKeyBindingNames();
	mainGui->SetStateInt( "com_machineSpec", cvarSystem->GetCVarInteger( "com_machineSpec" ) );

//	SetMenuSkin();
	
	msgmodeGui = uiManager->FindGui( "guis/mpmsgmode.gui", true, false, true );
	msgmodeGui->SetStateBool( "gameDraw", true );

	const char* temp = gameLocal.mapInfo.GetGameTypeHud( gameLocal.gameType );
	if ( temp && temp[0] ) {
  		maphud = uiManager->FindGui( temp, true, false, true );
		if ( maphud ) {
			maphud->Activate( true, gameLocal.time );
		}
	}
	if ( !maphud ) {
		gameLocal.Warning( "idPlayer::Spawn() - No Map hud overlay while in MP.");
	}

	memset ( lights, 0, sizeof( lights ) );
	memset ( lightHandles, -1, sizeof( lightHandles ) );

	renderLight_t	*light;
	const char		*shader;

	light = &lights[ MPLIGHT_CTF_MARINE ];
	shader = "lights/mpCTFLight";
	if ( shader && *shader ) {
		light->axis.Identity();
		light->shader = declManager->FindMaterial( shader, false );
		light->lightRadius[0] = light->lightRadius[1] = light->lightRadius[2] = 64.0f;
		light->shaderParms[ SHADERPARM_RED ]	= 142.0f / 255.0f;
		light->shaderParms[ SHADERPARM_GREEN ]	= 190.0f / 255.0f;
		light->shaderParms[ SHADERPARM_BLUE ]	= 84.0f / 255.0f;
		light->shaderParms[ SHADERPARM_ALPHA ]	= 1.0f;
		light->detailLevel = DEFAULT_LIGHT_DETAIL_LEVEL;
		light->pointLight = true;
		light->noShadows = true;
		light->noDynamicShadows = true;
		light->lightId = -MPLIGHT_CTF_MARINE;
		light->allowLightInViewID = 0;
	}

	light = &lights[ MPLIGHT_CTF_STROGG ];
	shader = "lights/mpCTFLight";
	if ( shader && *shader ) {
		light->axis.Identity();
		light->shader = declManager->FindMaterial( shader, false );
		light->lightRadius[0] = light->lightRadius[1] = light->lightRadius[2] = 64.0f;
		light->shaderParms[ SHADERPARM_RED ]	= 255.0f / 255.0f;
		light->shaderParms[ SHADERPARM_GREEN ]	= 153.0f / 255.0f;
		light->shaderParms[ SHADERPARM_BLUE ]	= 0.0f / 255.0f;
		light->shaderParms[ SHADERPARM_ALPHA ]	= 1.0f;
		light->detailLevel = DEFAULT_LIGHT_DETAIL_LEVEL;
		light->pointLight = true;
		light->noShadows = true;
		light->noDynamicShadows = true;
		light->lightId = -MPLIGHT_CTF_STROGG;
		light->allowLightInViewID = 0;
	}

	light = &lights[ MPLIGHT_QUAD ];
	shader = "lights/mpCTFLight";
	if ( shader && *shader ) {
		light->axis.Identity();
		light->shader = declManager->FindMaterial( shader, false );
		light->lightRadius[0] = light->lightRadius[1] = light->lightRadius[2] = 64.0f;
		light->shaderParms[ SHADERPARM_RED ]	= 0.0f;
		light->shaderParms[ SHADERPARM_GREEN ]	= 128.0f / 255.0f;
		light->shaderParms[ SHADERPARM_BLUE ]	= 255.0f / 255.0f;
		light->shaderParms[ SHADERPARM_ALPHA ]	= 1.0f;
		light->detailLevel = DEFAULT_LIGHT_DETAIL_LEVEL;
		light->pointLight = true;
		light->noShadows = true;
		light->noDynamicShadows = true;
		light->lightId = -MPLIGHT_CTF_STROGG;
		light->allowLightInViewID = 0;
	}

	light = &lights[ MPLIGHT_HASTE ];
	shader = "lights/mpCTFLight";
	if ( shader && *shader ) {
		light->axis.Identity();
		light->shader = declManager->FindMaterial( shader, false );
		light->lightRadius[0] = light->lightRadius[1] = light->lightRadius[2] = 64.0f;
		light->shaderParms[ SHADERPARM_RED ]	= 225.0f / 255.0f;
		light->shaderParms[ SHADERPARM_GREEN ]	= 255.0f / 255.0f;
		light->shaderParms[ SHADERPARM_BLUE ]	= 0.0f;
		light->shaderParms[ SHADERPARM_ALPHA ]	= 1.0f;
		light->detailLevel = DEFAULT_LIGHT_DETAIL_LEVEL;
		light->pointLight = true;
		light->noShadows = true;
		light->noDynamicShadows = true;
		light->lightId = -MPLIGHT_CTF_STROGG;
		light->allowLightInViewID = 0;
	}

	light = &lights[ MPLIGHT_REGEN ];
	shader = "lights/mpCTFLight";
	if ( shader && *shader ) {
		light->axis.Identity();
		light->shader = declManager->FindMaterial( shader, false );
		light->lightRadius[0] = light->lightRadius[1] = light->lightRadius[2] = 64.0f;
		light->shaderParms[ SHADERPARM_RED ]	= 255.0f / 255.0f;
		light->shaderParms[ SHADERPARM_GREEN ]	= 0.0f;
		light->shaderParms[ SHADERPARM_BLUE ]	= 0.0f;
		light->shaderParms[ SHADERPARM_ALPHA ]	= 1.0f;
		light->detailLevel = DEFAULT_LIGHT_DETAIL_LEVEL;
		light->pointLight = true;
		light->noShadows = true;
		light->noDynamicShadows = true;
		light->lightId = -MPLIGHT_CTF_STROGG;
		light->allowLightInViewID = 0;
	}

	ClearGuis();

	scoreBoard->SetStateString( "servername", gameLocal.serverInfo.GetString( "si_name" ) );
	scoreBoard->SetStateString( "servermap", va( "%s (%s)", gameLocal.mapInfo.GetMapLongName(), gameLocal.mapFileNameStripped.c_str() ) );
	scoreBoard->SetStateString( "serverip",	networkSystem->GetServerAddress() );

	scoreBoard->SetStateString( "servergametype", gameLocal.mapInfo.GetGameTypeLongName( gameLocal.gameType ) );
	scoreBoard->SetStateString( "servertimelimit", va( "%s: %d", common->GetLocalizedString( "#str_107659" ), gameLocal.serverInfo.GetInt( "si_timeLimit" ) ) );
	scoreBoard->SetStateString( "serverlimit", va( "Score Limit: %d", gameLocal.serverInfo.GetInt( "si_scorelimit" ) ) );

	iconManager->Shutdown();

	// update serverinfo
	UpdatePrivatePlayerCount();

	cvarSystem->SetCVarBool( "s_voiceChatTest", false );
}

/*
================
idMultiplayerGame::ServerClientConnect
================
*/
void idMultiplayerGame::ServerClientConnect( int clientNum ) {
	memset( &playerState[ clientNum ], 0, sizeof( playerState[ clientNum ] ) );
	playerState[ clientNum ].connected = true;
}

/*
================
idMultiplayerGame::SpawnPlayer
================
*/
void idMultiplayerGame::SpawnPlayer( int clientNum ) {

	TIME_THIS_SCOPE( __FUNCLINE__);

	bool ingame = playerState[ clientNum ].ingame;
 	// keep ingame to true if needed, that should only happen for local player
 	
	memset( &playerState[ clientNum ], 0, sizeof( playerState[ clientNum ] ) );
	if ( !gameLocal.isClient ) {
		idPlayer *p = static_cast< idPlayer * >( gameLocal.entities[ clientNum ] );
		p->spawnedTime = gameLocal.time;
 		playerState[ clientNum ].ingame = ingame;
		playerState[ clientNum ].connected = true;
	}
}

/*
================
idMultiplayerGame::Clear
================
*/
void idMultiplayerGame::Clear() {
	
	int i;

	voteSystem.ClearVote( false );

	pingUpdateTime = 0;
	matchStartedTime = 0;
	warmupStartedTime = 0;
	mapStartedTime = 0;
	memset( &playerState, 0 , sizeof( playerState ) );
	currentMenu = 0;
	bCurrentMenuMsg = false;
	nextMenu = 0;
	pureReady = false;
	scoreBoard = NULL;
	mainGui = NULL;
	msgmodeGui = NULL;
	if ( mapList ) {
 		uiManager->FreeListGUI( mapList );
		mapList = NULL;
	}
	memset( &switchThrottle, 0, sizeof( switchThrottle ) );
	voiceChatThrottle = 0;

	for ( i = 0; i < MPLIGHT_MAX; i ++ ) {
		FreeLight( i );
	}

	chatHistory.Clear();
	rconHistory.Clear();

	gameState.Clear();

	ClearAnnouncerSounds();

	memset ( lastVoiceMessageTimes, 0, sizeof ( int ) * MAX_CLIENTS );

	//memset( messageIndex, 0, sizeof ( messageIndex ) );
}

/*
================
idMultiplayerGame::ClearMap
================
*/
void idMultiplayerGame::ClearMap ( void ) {
	//ClearAnnouncerSounds();
	//announcerPlayTime = 0;
}

/*
================
idMultiplayerGame::ClearGuis
================
*/
void idMultiplayerGame::ClearGuis() {
	if ( maphud )
		maphud->HandleNamedEvent( "Clear" );

	memset( mapGuiVars, 0, sizeof( mapGuiVars ) );

	voteSystem.ClearVote( false );
}

// ddynerman: Gametype specific scoreboard
/*
================
idMultiplayerGame::UpdateScoreboard
================
*/
void idMultiplayerGame::UpdateScoreboard( idUserInterface *scoreBoard ) {
	//scoreBoard->SetStateInt( "gametype", gameLocal.gameType );

	//statManager->UpdateInGameHud( scoreBoard, true );

	UpdateTeamScoreboard( scoreBoard );

	return;
}

typedef struct {
	idPlayer* player;
	int score;
	int frags;
} scoreBoardInfo_t;

static int sbSortType = 0;
static int sbSortGroup = 0;

static int SortActivePlayers( const void* a, const void* b ) {
	scoreBoardInfo_t* p1 = (scoreBoardInfo_t*)(a);
	scoreBoardInfo_t* p2 = (scoreBoardInfo_t*)(b);

	if ( p1->player == NULL ) {
		return 1;
	}
	else if ( p2->player == NULL ) {
		return -1;
	}

	int p1PrimNum = 0;
	int p2PrimNum = 0;
	bool asc = false;

	switch( sbSortType ) {
		case 0:			// score DEC
			
			if ( p1->score != p2->score ) {
				p1PrimNum = p1->score;
				p2PrimNum = p2->score;
			}
			else {
				p1PrimNum = p1->frags;
				p2PrimNum = p2->frags;
			}
			asc = false;
			break;

		case 1:			// score ASC
			if ( p1->score != p2->score ) {
				p1PrimNum = p1->score;
				p2PrimNum = p2->score;
			}
			else {
				p1PrimNum = p1->frags;
				p2PrimNum = p2->frags;
			}
			asc = true;
			break;

		case 2:			// frags DEC
			if ( p1->frags != p2->frags ) {
				p1PrimNum = p1->frags;
				p2PrimNum = p2->frags;
			}
			else {
				p1PrimNum = p1->score;
				p2PrimNum = p2->score;
			}
			asc = false;
			break;

		case 3:			// frags ASC
			if ( p1->frags != p2->frags ) {
				p1PrimNum = p1->frags;
				p2PrimNum = p2->frags;
			}
			else {
				p1PrimNum = p1->score;
				p2PrimNum = p2->score;
			}
			asc = true;
			break;

		default:
			gameLocal.Error( "SortActivePlayers - unknown sort type %d", sbSortType );
	}
	

	if ( sbSortGroup == 0 ) {			// group by teams
		TFTeam* p1team = tfGame.GetTeam( p1->player->team );
		TFTeam* p2team = tfGame.GetTeam( p2->player->team );

		if ( p1team == p2team ) {
			if ( p1PrimNum > p2PrimNum ) {
				return asc ? -1 : 1;
			}
			return -1;
		}
		else if ( !p1team ) {
			return 1;
		}
		else if ( !p2team ) {
			return -1;
		}
		else if ( tfStatManager->GetTeamScore( p1team->GetTeamNum() ) >
				  tfStatManager->GetTeamScore( p2team->GetTeamNum() ) ) {
				  return -1;
		}
		else {
			return 1;
		}
	}
	else {				// no grouping
		if ( p1PrimNum > p2PrimNum ) {
			return asc ? -1 : 1;
		}
	}

	return -1;
}

/*
================
idMultiplayerGame::UpdateTeamScoreboard
================
*/
void idMultiplayerGame::UpdateTeamScoreboard( idUserInterface *scoreBoard ) {

	idPlayer* local = gameLocal.GetLocalPlayer();

	if ( !local )
		return;

	const char* sortType = q4f_scoreboardSort.GetString();

	if ( !idStr::Icmp( sortType, "ScoreDEC" ) ) {
		sbSortType = 0;
	}
	else if ( !idStr::Icmp( sortType, "ScoreASC" ) ) {
		sbSortType = 1;
	}
	else if ( !idStr::Icmp( sortType, "FragsDEC" ) ) {
		sbSortType = 2;
	}
	else {
		sbSortType = 3;
	}

	const char* sortGroup = q4f_scoreboardGroup.GetString();
	if ( !idStr::Icmp( sortGroup, "Team" ) ) {
		sbSortType = 0;
	}
	else {
		sbSortType = 1;
	}

	scoreBoardInfo_t activePlayers[MAX_CLIENTS];
	int i;

	for ( i = 0; i < MAX_CLIENTS; i++ ) {
		activePlayers[i].player = GET_PLAYER( i );
		activePlayers[i].score = playerState[ i ].score;
		activePlayers[i].frags = playerState[ i ].frags;
	}

	qsort( (void*)activePlayers, MAX_CLIENTS, sizeof( activePlayers[0] ), SortActivePlayers );

	idPlayer* spec = local->spectating && local->spectator >= 0 ? GET_PLAYER( local->spectator ) : NULL;

	idVec3 teamColor = tfGame.GetTeamColor( spec ? spec->team : local->team );
	scoreBoard ->SetStateFloat( "team_color_x", teamColor.x );
	scoreBoard ->SetStateFloat( "team_color_y", teamColor.y );
	scoreBoard ->SetStateFloat( "team_color_z", teamColor.z );

	scoreBoard->SetStateInt( "player_score_list_sel_0", -1 );

	idVec4 highlightColor;

	int selfIndex = -1;

	int lastTeam = -TEAM_COUNT;
	idPlayer* current;
	for ( i = 0; i < MAX_CLIENTS; i++ ) {
		if ( activePlayers[i].player == NULL )
			break;

		current = activePlayers[i].player;

		if ( current->team != lastTeam ) {
			teamColor = tfGame.GetTeamColor( current->team );
			highlightColor = idVec4( teamColor.x, teamColor.y, teamColor.z, 0.65f );
			lastTeam = current->team;
		}

		if ( current == spec || current == local ) {
			selfIndex = i;
		}

		scoreBoard->SetStateVec4( va( "player_score_list_item_%d_highlight", i ), highlightColor );

		scoreBoard->SetStateString ( 
			va( "player_score_list_item_%d", i ), 

			va( "%s\t%s\t%s\t%s\t%i\t%i\t%i\t%i\t", 
			( local->team == current->team && current->IsPlayerMuted( current ) ? I_VOICE_DISABLED : I_VOICE_ENABLED ), // mute icon
			( local->IsFriend( current ) ? I_FRIEND_ENABLED : I_FRIEND_DISABLED ),	// friend icon
			current->GetUserInfo()->GetString( "ui_name" ),							// name
			current->GetUserInfo()->GetString( "ui_clan" ),							// clan
			activePlayers[i].frags,													// frags	
			activePlayers[i].score,													// score					
			GetPlayerTime( current ),												// time
			playerState[ current->entityNumber ].ping ) );		
	}

	scoreBoard->SetStateInt( "num_total_players", i );
	scoreBoard->SetStateInt( "current_player_index", selfIndex );

	for ( i; i < MAX_CLIENTS; i++ ) {
		scoreBoard->SetStateString ( 
			va( "player_score_list_item_%d", i ), 
			"" );
	}

	for ( i = 0; i < TEAM_COUNT; i++ ) {
		scoreBoard->SetStateBool( va( "team_%d", i), false );
	}

	int teamNum;
	TFTeam* team = tfGame.GetTeam( 0 );
	while ( team ) {
		teamNum = team->GetTeamNum();

		scoreBoard->SetStateBool( va( "team_%d", teamNum ), true );
		scoreBoard->SetStateString( va( "team_score_%d", teamNum ),
			va( "%s%s^0: %d",
			tfGame.GetTeamEscapeColor( teamNum ),
			team->GetName(), tfStatManager->GetTeamScore( teamNum ) ) );

		team = tfGame.GetTeam( teamNum + 1 );
	}

	scoreBoard->SetStateString( "timeleft", GameTime() );

	int timeLimit = gameLocal.serverInfo.GetInt( "si_timeLimit" );
	mpGameState_t state = gameState.GetMPGameState();
	scoreBoard->SetStateBool( "infinity", ( !timeLimit && state != COUNTDOWN ) || state == WARMUP || state == GAMEREVIEW || state == SUDDENDEATH );

	scoreBoard->HandleNamedEvent( "UpdatePlayerCount" );

	scoreBoard->StateChanged ( gameLocal.time );
	scoreBoard->Redraw( gameLocal.time );
}

/*
================
idMultiplayerGame::BuildSummaryListString
Returns a summary string for the specified player
================
*/
const char* idMultiplayerGame::BuildSummaryListString( idPlayer* player, int rankedScore ) {
	

	/*return 	va("%d. %s\t%s\t%d\t%s\t", 
			player->GetRank() + 1,
			player->GetUserInfo()->GetString( "ui_name" ),								// name
			player->GetUserInfo()->GetString( "ui_clan" ),								// clan
			rankedScore,																// score
			weaponString.c_str() );
}*/
	return "";
}

const char* idMultiplayerGame::GetStatAwards() {
	const char* awardsScript = q4f_awardsScript.GetString();

	if ( !awardsScript[0] ) {
		gameLocal.Warning( "q4f_awardsScript is empty, no awards will be printed.\n" );
		return "";
	}

	if ( fileSystem->ReadFile( awardsScript, NULL, NULL ) < 0 ) {
		awardsScript = va( "%s.scriptcfg", awardsScript );

		if ( fileSystem->ReadFile( awardsScript, NULL, NULL ) < 0 ) {
			gameLocal.Warning( "Could not find the awards script '%s'\n", q4f_awardsScript.GetString() );
			return "";
		} else {
			q4f_awardsScript.SetString( awardsScript );
		}
	}

	const function_t	*func;
	idThread			*thread;

	gameLocal.Printf( "awards script: '%s'\n", awardsScript );
	func = gameLocal.program.FindFunction( "Awards::GiveEndGameAwards" );
	if ( !func ) {
		gameLocal.program.CompileFile( awardsScript );
		func = gameLocal.program.FindFunction( "Awards::GiveEndGameAwards"  );
	}
	if ( !func ) {
		gameLocal.Warning( "Couldn't find Awards::GiveEndGameAwards\n" );
		return "";
	}

	awardsStr.Clear();

	thread = new idThread( func );
	thread->Start();
	delete thread;

	return awardsStr.c_str();
}

/*
================
idMultiplayerGame::GameTime
================
*/
const char *idMultiplayerGame::GameTime( void ) {
	static char buff[16];
	int m, s, t, ms;

	bool inCountdown = false;

	ms = 0;
	if( gameState.GetMPGameState() == COUNTDOWN ) {
		inCountdown = true;
		ms = gameState.GetNextMPGameStateTime() - gameLocal.realClientTime;
	}
	if ( inCountdown ) {
		s = ms / 1000 + 1;
		if ( ms <= 0 ) {
			// in tourney mode use a different string since warmups happen before each round
			// (not really before the overall game)
			strcpy( buff, va( "%s --", common->GetLocalizedString( "#str_107706" ) ) );
		} else {
			sprintf( buff, "%s %i", common->GetLocalizedString( "#str_107706" ), s );
		}
	} else {
		int timeLimit = gameLocal.serverInfo.GetInt( "si_timeLimit" );
		int startTime = matchStartedTime;

		if ( timeLimit ) {
			ms = ( timeLimit * 60000 ) - ( gameLocal.time - startTime );
		} else {
			ms = gameLocal.time - startTime;
		}
		if ( ms < 0 ) {
			ms = 0;
		}
	
		s = ms / 1000;
		m = s / 60;
		s -= m * 60;
		t = s / 10;
		s -= t * 10;

		sprintf( buff, "%i:%i%i", m, t, s );
	}
	return &buff[0];
}

/*
================
idMultiplayerGame::NumActualClients
================
*/
int idMultiplayerGame::NumActualClients( bool countSpectators, int *teamcounts ) {
	idPlayer *p;
	int c = 0;

	if ( teamcounts ) {
		for ( int i = 0; i < TEAM_COUNT; i++ ) {
			teamcounts[i] = 0;
		}
	}

	for( int i = 0 ; i < gameLocal.numClients ; i++ ) {
		p = GET_PLAYER( i );

		if ( p && ( countSpectators || CanPlay( p ) ) ) {
			c++;

			if ( teamcounts && IS_VALID_TEAM( p->team ) ) {
				teamcounts[ p->team ]++;
			}
		}
	}
	return c;
}


/*
================
idMultiplayerGame::RoundReadyToStart
================
*/
bool idMultiplayerGame::RoundReadyToStart( idStr* reason ) {
	int			minClients, numClients;

	// check minimum # of players
	
	minClients = Max( 1, gameLocal.serverInfo.GetInt( "si_minPlayers" ) );
	numClients = NumActualClients( false, NULL );
	if ( numClients < minClients ) { 
		if( reason ) {
			// stupid english plurals
			if( minClients == 2 ) {
				*reason = common->GetLocalizedString( "#str_107674" );
			} else {
				*reason = va( common->GetLocalizedString( "#str_107732" ), minClients - numClients );
			}
			
		}
	
		return false;
	}

	// check prematch
	int prematchTime = SEC2MS( gameLocal.serverInfo.GetInt( "si_prematch", "0" ) );
	int timeDiff = ( warmupStartedTime + prematchTime ) - gameLocal.time;

	if ( timeDiff > 0 ) {

		if ( reason ) {
			*reason = va( "PreMatch: %d seconds remaining", (int)(MS2SEC( timeDiff ) ));
		}

		return false;
	}

	// check all players connected
	prematchTime = SEC2MS( gameLocal.serverInfo.GetInt( "si_matchwait", "0" ) );
	timeDiff = ( mapStartedTime + prematchTime ) - gameLocal.time;
	if ( timeDiff > 0 ) {
		for ( int i = 0; i < MAX_CLIENTS; i++ ) {
			if ( !playerState[ i ].ingame ) {
				if ( playerState[ i ].connected )  {
					if ( reason ) {
						*reason = va( "Waiting for connecting players", MS2SEC( timeDiff ) );
					}

					return false;
				}
			}
		}
	}

	return true;
}

/*
================
idMultiplayerGame::TimeLimitHit
================
*/
bool idMultiplayerGame::TimeLimitHit( void ) {	
	int timeLimit = gameLocal.serverInfo.GetInt( "si_timeLimit" );
	if ( timeLimit ) {
		if ( gameLocal.time >= matchStartedTime + timeLimit * 60000 ) {
			return true;
		}
	}
	return false;
}

int idMultiplayerGame::CaptureLimitHit() {

	int maxScore = gameLocal.serverInfo.GetInt( "si_scorelimit", "100" );
	if ( maxScore <= 0 )
		return -1;

	for ( int i = 0; i < tfGame.GetTeamCount(); i++ ) {
		if ( tfStatManager->GetTeamScore( i ) > maxScore )
			return i;
	}

	return -1;
}

/*
================
idMultiplayerGame::PlayerStats
================
*/
void idMultiplayerGame::PlayerStats( int clientNum, char *data, const int len ) {

	idEntity *ent;
	int team;

	*data = 0;

	// make sure we don't exceed the client list
	if ( clientNum < 0 || clientNum >= gameLocal.numClients ) {
		return;
	}

	// find which team this player is on
	ent = gameLocal.entities[ clientNum ]; 
	if ( ent && ent->IsType( idPlayer::GetClassType() ) ) {
		team = static_cast< idPlayer * >(ent)->team;
	} else {
		return;
	}

	idStr::snPrintf( data, len, "team=%d score=%ld tks=%ld", team, playerState[ clientNum ].frags, 0 );
}

/*
================
idMultiplayerGame::ClientEndFrame
Called once each render frame (client) after all idGameLocal::ClientPredictionThink() calls
================
*/
void idMultiplayerGame::ClientEndFrame( void ) {
	iconManager->UpdateIcons();
}

/*
================
idMultiplayerGame::CommonRun
Called once each render frame (client)/once each game frame (server)
================
*/
void idMultiplayerGame::CommonRun( void ) {
	tfGame.Run();
	voteSystem.Run();

	idPlayer* player = gameLocal.GetLocalPlayer();

	// twhitaker r282
	// TTimo: sure is a nasty way to do it
	/*if ( gameLocal.isServer && ( gameLocal.serverInfo.GetInt( "net_serverDedicated" ) != cvarSystem->GetCVarInteger( "net_serverDedicated" ) ) ) {
		cmdSystem->BufferCommandText( CMD_EXEC_APPEND, "spawnServer\n" );
	}*/

	if( player && player->mphud ) {
		// update icons
		if ( gameLocal.isServer ) {
			iconManager->UpdateIcons();
		}
#ifdef _USE_VOICECHAT
		float	micLevel;
		bool	sending, testing;

		// jscott: enable the voice recording
		testing = cvarSystem->GetCVarBool( "s_voiceChatTest" );
		sending = soundSystem->EnableRecording( !!( player->usercmd.buttons & BUTTON_VOICECHAT ), testing, micLevel );

		if( mainGui ) {
			mainGui->SetStateFloat( "s_micLevel", micLevel );
			mainGui->SetStateFloat( "s_micInputLevel", cvarSystem->GetCVarFloat( "s_micInputLevel" ) );
		}


// shouchard:  let the UI know about voicechat states
		if ( !testing && sending ) {
			player->mphud->HandleNamedEvent( "show_transmit_self" );
		} else {
			player->mphud->HandleNamedEvent( "hide_transmit_self" );
		}

		if( player->GetUserInfo()->GetBool( "s_voiceChatReceive" ) ) {
			int maxChannels = soundSystem->GetNumVoiceChannels();
			int clientNum = -1;
			for (int channels = 0; channels < maxChannels; channels++ ) {
				clientNum = soundSystem->GetCommClientNum( channels );
				if ( -1 != clientNum ) {
					break;
				}
			}

			// Sanity check for network errors
			assert( clientNum > -2 && clientNum < MAX_CLIENTS );

			if ( clientNum > -1 && clientNum < MAX_CLIENTS ) {
				idPlayer *from = ( idPlayer * )gameLocal.entities[clientNum];
				if( from ) {
					player->mphud->SetStateString( "audio_name", from->GetUserInfo()->GetString( "ui_name" ) );

					player->mphud->HandleNamedEvent( "show_transmit" );
				}
			} else {
				player->mphud->HandleNamedEvent( "hide_transmit" );
			}
		}
		else {
			player->mphud->HandleNamedEvent( "hide_transmit" );
		}
#endif // _USE_VOICECHAT

	}
#ifdef _USE_VOICECHAT
	// jscott: Send any new voice data
	XmitVoiceData();
#endif

	PlayAnnouncerSounds();
}

/*
================
idMultiplayerGame::ClientRun
Called once each client render frame (before any ClientPrediction frames have been run)
================
*/
void idMultiplayerGame::ClientRun( void ) {
	CommonRun();
}


/*
================
idMultiplayerGame::Run
================
*/
void idMultiplayerGame::Run( void ) {
	pureReady = true;

	//assert( gameLocal.isMultiplayer && gameLocal.isServer );
	assert( !gameLocal.isClient );

	CommonRun();

	//CheckVote();

	CheckRespawns();

	gameState.Run();

	gameState.SendState();

	// don't update the ping every frame to save bandwidth
	if ( gameLocal.time > pingUpdateTime ) {
		for ( int i = 0; i < gameLocal.numClients; i++ ) {
			playerState[i].ping = networkSystem->ServerGetClientPing( i );
		}
		pingUpdateTime = gameLocal.time + 1000;
	}

	TFPlayerStats* stat;
	for ( int i = 0; i < gameLocal.numClients; i++ ) {
		stat = tfStatManager->GetPlayerStatsClientNum( i );
		if ( stat ) {
			playerState[i].score = stat->score;
			playerState[i].frags = stat->frags;
		}
		else {
			playerState[i].score = 0;
			playerState[i].frags = 0;
		}
	}
}

/*
================
idMultiplayerGame::UpdateMainGui
================
*/
void idMultiplayerGame::UpdateMainGui( void ) {

	int currentTab = mainGui->GetStateInt( "currentTab", "0" );

	idPlayer* local = gameLocal.GetLocalPlayer();

	if ( !local )
		return;

	// key handler
	int keyNum = -1;
	const char* key = mainGui->GetStateString( "keyHandlerText", "" );
	if ( key && key[0] ) {
		bool close = false;
		if ( idStr::IsNumeric( key ) ) {
			keyNum = atoi( key );

			close = HandleQ4FMenuKeyPress( currentTab, keyNum );
		}
		mainGui->SetStateString( "keyHandlerText", "" );
		mainGui->StateChanged( gameLocal.time );
		if ( close ) {
			mainGui->HandleNamedEvent( "forceClose" );
		}
	}

	if ( currentTab == 1 ) {
		int teamNum;

		mainGui->SetStateInt( "current_team_num",  local->spectating ? TEAM_COUNT : local->team );
		mainGui->SetStateInt( "current_team_spec", local->spectating ? local->team : TEAM_COUNT );

		idVec3 color;
		TFTeam* guiTeam = tfGame.GetTeam( 0 );
		while ( guiTeam ) {
			teamNum = guiTeam->GetTeamNum();

			mainGui->SetStateString(	va( "team_%d_name",		teamNum	), va( "%d. %s", teamNum+1, guiTeam->GetName() ) );			// 3j_todo: move the static stuff into mpgame init or something.
			mainGui->SetStateInt(		va( "team_%d_score",	teamNum	), tfStatManager->GetTeamScore( teamNum ) );
			mainGui->SetStateInt(		va( "team_%d_players",	teamNum	), guiTeam->GetNumPlayers() );

			color = tfGame.GetTeamColor( teamNum );

			mainGui->SetStateFloat(		va( "team_%d_color_x",	teamNum	), color.x );
			mainGui->SetStateFloat(		va( "team_%d_color_y",	teamNum	), color.y );
			mainGui->SetStateFloat(		va( "team_%d_color_z",	teamNum	), color.z );

			UpdateTeamPageClassInfo( teamNum, mainGui );

			guiTeam = tfGame.GetTeam( teamNum + 1 );
		}
	}
	else if ( currentTab == 2 ) {

		UpdateGUIClassSelection( local->team, mainGui );
		UpdateGUIClassModelInfo( mainGui );
	}
	/*else if ( currentTab == 5 ) {
		// update player stat names
		FillStatPlayerNames( mainGui, false );
	}*/
}

/*void idMultiplayerGame::FillStatPlayerNames( idUserInterface* gui, int selectClient ) {
	idPlayer* selected = NULL;

	gui->SetStateInt( "stat_dmg_info_sel_0", -1 );

	//mainGui->DeleteStateVar( "stats_clientlist" );

	if ( selectClient >= 0 ) {
		mainGui->SetStateString( "stats_clientlist_sel_0", "-1" );
		selected = GET_PLAYER( selectClient );
	}
	else {
		int index = gui->GetStateInt( "stats_clientlist_sel_0", "-1" );

		if ( index >= 0 && index < MAX_CLIENTS ) {
			index = gui->GetStateInt( va( "stats_clientlist_item_%d_id", index ), "-1" );
			if ( index >= 0 && index < MAX_CLIENTS )
				selected = GET_PLAYER( index );
		}
	}

	int numStatSlots = 0;
	for ( int i = 0; i < gameLocal.numClients; i++ ) {
		idPlayer* p = GET_PLAYER( i );
		if ( playerState[i].ingame && p ) {

			if ( i == selectClient ) {
				mainGui->SetStateInt( "stats_clientlist_sel_0", numStatSlots );
			}

			gui->SetStateInt( va( "stats_clientlist_item_%d_id", numStatSlots ), i );
			gui->SetStateString( va( "stats_clientlist_item_%d", numStatSlots ), p->GetUserInfo()->GetString( "ui_name" ) );
			numStatSlots++;
		}
	}

	for ( numStatSlots; numStatSlots < MAX_CLIENTS; numStatSlots++ ) {
		mainGui->DeleteStateVar( va( "stats_clientlist_item_%d_id", numStatSlots ) );
		mainGui->DeleteStateVar( va( "stats_clientlist_item_%d", numStatSlots ) );
	}

	if ( selected != NULL ) {
		mainGui->SetStateString( "stat_selected_name", selected->GetUserInfo()->GetString( "ui_name", "unnamed" ) );
	}
	else {
		mainGui->SetStateString( "stat_selected_name", "unnamed" );
	}
}*/

bool idMultiplayerGame::HandleQ4FMenuKeyPress( int tabNum, int keyNum ) {
	switch( tabNum ) {
		case 1:
			switch( keyNum ) {
				case 5:
				case 0:
					HandleGuiCommands( "jointeam 4; play main_menu_selection" );
					break;
				case 1:
					HandleGuiCommands( "jointeam 0; play main_menu_selection" );
					break;
				case 2:
					HandleGuiCommands( "jointeam 1; play main_menu_selection" );
					break;
				case 3:
					HandleGuiCommands( "jointeam 2; play main_menu_selection" );
					break;
				case 4:
					HandleGuiCommands( "jointeam 3; play main_menu_selection" );
					break;
			}
			break;

		case 2:
			switch( keyNum ) {
				case 1:
					HandleGuiCommands( "changeclass 0; play main_menu_selection" );
					return true;
				case 2:
					HandleGuiCommands( "changeclass 1; play main_menu_selection" );
					return true;
				case 3:
					HandleGuiCommands( "changeclass 2; play main_menu_selection" );
					return true;
				case 4:
					HandleGuiCommands( "changeclass 3; play main_menu_selection" );
					return true;
				case 5:
					HandleGuiCommands( "changeclass 4; play main_menu_selection" );
					return true;
				case 6:
					HandleGuiCommands( "changeclass 5; play main_menu_selection" );
					return true;
				case 7:
					HandleGuiCommands( "changeclass 6; play main_menu_selection" );
					return true;
				case 8:
					HandleGuiCommands( "changeclass 7; play main_menu_selection" );
					return true;
				case 9:
					HandleGuiCommands( "changeclass 8; play main_menu_selection" );
					return true;
				case 0:
					HandleGuiCommands( "changeclass 9; play main_menu_selection" );
					return true;
			}
			break;
	}

	return false;

}


//--------------------------------------------------------------------------
// Update the model displayed on the GUI class selection page
//--------------------------------------------------------------------------
void idMultiplayerGame::UpdateGUIClassModelInfo( idUserInterface* gui ) {
	if ( !gui )
		return;

	int selectedClass = gui->GetStateInt( "selectedClass", "0" );

	const idDict* modelDict = gameLocal.FindEntityDefDict( tfGame.GetClassEntDef( selectedClass )->dict.GetString( "def_model" ), false );
	
	if ( !modelDict )
		return;
	
	gui->SetStateString( "class_model_name", modelDict->GetString( "model" ) );
	gui->SetStateString( "class_skin_name", modelDict->GetString( "skin" ) );

	if ( idStr::Icmp( modelDict->GetString( "def_head", "" ), "" ) ) {
		modelDict = gameLocal.FindEntityDefDict( modelDict->GetString( "def_head" ), false );
		assert( modelDict );
		gui->SetStateString( "player_head_model_name", modelDict->GetString( "model" ) );
	}
	else {
		gui->SetStateString( "player_head_model_name", "" );
	}
	gui->SetStateBool( "need_update", true );
}

//--------------------------------------------------------------------------
// Update the information displayed on the GUI class selection page
//--------------------------------------------------------------------------
#define MOST_ARMOR		250.0f
#define MOST_HEALTH		100.0f
#define MOST_SPEED		498.0f

void idMultiplayerGame::UpdateGUIClassInfo( idUserInterface* gui ) {
	if ( !gui )
		return;

	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( !local )
		return;

	int selectedClass = gui->GetStateInt( "selectedClass", "0" );

	const idDict* classDict = &(tfGame.GetClassEntDef( selectedClass )->dict);

	gui->SetStateString( "status", classDict->GetString( "pc_name" ) );
	
	gui->SetStateInt( "class_health", classDict->GetInt( "maxhealth" ) );
	gui->SetStateFloat( "class_health_pct", classDict->GetInt( "maxhealth" ) / MOST_HEALTH );

	gui->SetStateInt( "class_armor", classDict->GetInt( "maxarmor" ) );
	gui->SetStateFloat( "class_armor_pct", classDict->GetInt( "maxarmor" ) / MOST_ARMOR );

	// round to nearest 10 for speed
	int speed = ( classDict->GetInt( "runspeed" ) - 1 ) / 10;
	speed *= 10;
	gui->SetStateInt( "class_speed", speed );
	gui->SetStateFloat( "class_speed_pct", classDict->GetInt( "runspeed" ) / MOST_SPEED );

	gui->SetStateString( "class_desc", classDict->GetString( "description" ) );

	ENTDEF grenDef = gameLocal.FindEntityDef( classDict->GetString( "def_gren0" ) );
	if ( grenDef ) {
		gui->SetStateString( "gren_0_name", grenDef->dict.GetString( "grenadeName" ) );
		gui->SetStateString( "gren_0_desc", grenDef->dict.GetString( "description" ) );
		gui->SetStateString( "gren_0_icon", grenDef->dict.GetString( "inv_icon" ) );
	}
	else {
		gui->SetStateString( "gren_0_name", "" );
		gui->SetStateString( "gren_0_desc", "" );
		gui->SetStateString( "gren_0_icon", "" );
	}

	grenDef = gameLocal.FindEntityDef( classDict->GetString( "def_gren1" ) );
	if ( grenDef ) {
		gui->SetStateString( "gren_1_name", grenDef->dict.GetString( "grenadeName" ) );
		gui->SetStateString( "gren_1_desc", grenDef->dict.GetString( "description" ) );
		gui->SetStateString( "gren_1_icon", grenDef->dict.GetString( "inv_icon" ) );
	}
	else {
		gui->SetStateString( "gren_1_name", "" );
		gui->SetStateString( "gren_1_desc", "" );
		gui->SetStateString( "gren_1_icon", "" );
	}
	

	const idDict* weapDict;

	int i = 0;
	for ( i = 0; i < MAX_WEAPONS; i++ ) {
		weapDict = gameLocal.FindEntityDefDict( classDict->GetString( va( "def_weapon%d", i ) ), false );
		if ( weapDict ) {
			gui->SetStateString( va( "weapon_%d_name", i ), weapDict->GetString( "inv_name" ) );
			gui->SetStateString( va( "weapon_%d_desc", i ), weapDict->GetString( "description" ) );
			gui->SetStateString( va( "weapon_%d_icon", i ), weapDict->GetString( "inv_icon" ) );
		}
		else {
			break;
		}
	}

	gui->SetStateInt( "weapon_count", i );

	UpdateGUIClassModelInfo( gui );
}

void idMultiplayerGame::UpdateGUIClassSelection( int teamNum, idUserInterface* gui ) {

	if ( !gui )
		return;

	int classLimit;
	int classCount;

	TFTeam* team = tfGame.GetTeam( teamNum );

	int classCounts[CLASS_COUNT];

	if ( team )
		team->GetNumPlayers( classCounts );

	for ( int c = 0; c < CLASS_COUNT; c++ ) {
		if ( !team ) {
			classLimit = 0;
			classCount = 0;
		}
		else {
			classLimit = team->GetClassLimit( c );
			classCount = classCounts[c];
		}

		gui->SetStateInt( va( "class_%d_limit", c ), classLimit );
		gui->SetStateInt( va( "class_%d_count", c ), classCount );
		gui->SetStateString( va( "class_%d_name", c ), va( "%d. %s", c+1 == 10 ? 0 : c+1, tfGame.GetClassName( c, false ) ) );

		gui->SetStateBool( va( "allow_class_%d", c ), classLimit < 0 || classCount < classLimit );
		if ( classLimit > 0 ) {
			gui->SetStateString( va( "class_%d_countlimit", c ), va( "%s%d/%d", classCount < classLimit ? "^0" : "^1", classCount, classLimit ) );		// 3j_todo: move statics
		}
		else if ( classLimit < 0 ){
			gui->SetStateString( va( "class_%d_countlimit", c ), va( "%d", classCount ) );
		}
		else {
			gui->SetStateString( va( "class_%d_countlimit", c ), "" );
			gui->SetStateInt( va( "allow_class_%d", c ), 0 );
		}
	}
}

//--------------------------------------------------------------------------
// Update the gui team's class information information
//--------------------------------------------------------------------------
void idMultiplayerGame::UpdateTeamPageClassInfo( int teamNum, idUserInterface* gui ) {

	int max_class = 0;
	int classLimit;
	int classCount;

	TFTeam* guiTeam = tfGame.GetTeam( teamNum );

	if ( !guiTeam || !gui ) {
		return;
	}

	idStr playerNames;

	int guiClass = 0;

	int classCounts[CLASS_COUNT];
	guiTeam->GetNumPlayers( classCounts );

	idPlayer* p;

	for ( int c = 0; c < CLASS_COUNT; c++ ) {
		classLimit = guiTeam->GetClassLimit( c );
		classCount = classCounts[ c ];

		if ( classCount > max_class ) {
			max_class = classCount;
		}

		if ( classLimit != 0 ) {
			gui->SetStateInt( va( "team_%d_class_%d_limit", teamNum, guiClass ), classLimit );

			if ( classLimit < 0 ) {
				gui->SetStateString( va( "team_%d_class_%d_namelimit", teamNum, guiClass ), tfGame.GetClassName( guiClass, true ) );
			}
			else {
				gui->SetStateString( va( "team_%d_class_%d_namelimit", teamNum, guiClass ), va( "%s %s%d/%d", tfGame.GetClassName( guiClass, true ), classCount < classLimit ? "^0" : "^1", classCount, classLimit ) );
			}

			playerNames = "";
			for ( int cp = 0; cp < gameLocal.numClients; cp++ ) {
				p = GET_PLAYER( cp );

				if ( p && p->team == guiTeam->GetTeamNum() && p->currentPC == c )
					playerNames.Append( va( "%s\n", p->GetUserInfo()->GetString( "ui_name" ) ) );
			}
			gui->SetStateString( va( "team_%d_class_%d_names", teamNum, guiClass ), playerNames );

			guiClass++;
		}
	}

	while ( guiClass < CLASS_COUNT ) {
		gui->SetStateInt( va( "team_%d_class_%d_limit", teamNum, guiClass ), 0 );
		gui->SetStateString( va( "team_%d_class_%d_names", teamNum, guiClass ), "" );
		guiClass++;
	}

	gui->SetStateInt( va( "class_count_%d", teamNum ), max_class );
}

/*
================
idMultiplayerGame::StartMenu
================
*/
idUserInterface* idMultiplayerGame::StartMenu( void ) {
	if ( mainGui == NULL ) {
		return NULL;
	}

	idPlayer* local = gameLocal.GetLocalPlayer();

	if ( !local )
		return NULL;

	// check if player has build menu open
	if ( local->menuNum > 0 ) {
		
		if ( local->isPreviewing ) {
			local->StopPreview();
		}

		local->CloseMenu();
		return NULL;
	}

	if ( local->isPreviewing ) {
		local->StopPreview();
		return NULL;
	}


	//if we're the server, allow access to the admin tab right away. Otherwise, make sure we don't have it.
	if( gameLocal.isServer	)	{
		mainGui->SetStateInt( "password_valid", 1 );
	} else {
		mainGui->SetStateInt( "password_valid", 0 );
	}

	if ( currentMenu ) {
		currentMenu = 0;
 		cvarSystem->SetCVarBool( "ui_chat", false );
	} else {
		if ( nextMenu >= 2 ) {
			currentMenu = nextMenu;
		} else {
			// for default and explicit
			currentMenu = 1;
		}
 		cvarSystem->SetCVarBool( "ui_chat", true );
	}

	local->disableHud = true;

	nextMenu = 0;
	if ( currentMenu == 1 ) {
		mainGui->SetStateInt( "currentMenu", 1 );

		if ( mainGui->GetStateInt( "currentTab", "0" ) == 5 ) {
			tfStatManager->UpdateGUIStats( false );
		}

		UpdateMainGui();

		mainGui->SetStateInt( "team_count", tfGame.GetTeamCount() );

		UpdateGUIClassInfo( mainGui );

		mainGui->SetStateString( "chattext", "" );
		mainGui->Activate( true, gameLocal.time );

		return mainGui;
	} else if ( currentMenu == 2 ) {
		// the setup is done in MessageMode
		local->disableHud = false;

		msgmodeGui->Activate( true, gameLocal.time );
 		cvarSystem->SetCVarBool( "ui_chat", true );
		return msgmodeGui;
	} else if ( currentMenu == 3 ) {
		mainGui->SetStateInt( "currentMenu", 3 );
		UpdateScoreboard( mainGui );
		mainGui->Activate( true, gameLocal.time );
		scoreBoard->StateChanged ( gameLocal.time );
		scoreBoard->Redraw( gameLocal.time );
		return mainGui;
	}

	return NULL;
}

/*
================
idMultiplayerGame::DisableMenu
================
*/
void idMultiplayerGame::DisableMenu( void ) {
	gameLocal.sessionCommand = "";	// in case we used "game_startMenu" to trigger the menu
	if ( currentMenu == 1 ) {
		mainGui->Activate( false, gameLocal.time );
	} else if ( currentMenu == 2 ) {
		msgmodeGui->Activate( false, gameLocal.time );
	} else if( currentMenu == 3 ) {
		mainGui->Activate( false, gameLocal.time );
	}

	currentMenu = 0;
	nextMenu = 0;
 	cvarSystem->SetCVarBool( "ui_chat", false );
	
	if( gameLocal.GetLocalPlayer() ) {
		gameLocal.GetLocalPlayer()->disableHud = false;
		if( gameLocal.GetLocalPlayer()->mphud)	{
			gameLocal.GetLocalPlayer()->mphud->Activate( true, gameLocal.time );
		}
	}

	mainGui->DeleteStateVar( va( "sa_playerList_item_%d", 0 ) );
	mainGui->SetStateString( "sa_playerList_sel_0", "-1" );

	mainGui->DeleteStateVar( va( "sa_banList_item_%d", 0 ) );
	mainGui->SetStateString( "sa_banList_sel_0", "-1" );
}

/*
================
idMultiplayerGame::SetMapShot
================
*/
void idMultiplayerGame::SetMapShot( void ) {
	char screenshot[ MAX_STRING_CHARS ];
	int mapNum = mapList->GetSelection( NULL, 0 );
	const idDict *dict = NULL;
	if ( mapNum >= 0 ) {
		dict = fileSystem->GetMapDecl( mapNum );
	}
	fileSystem->FindMapScreenshot( dict ? dict->GetString( "path" ) : "", screenshot, MAX_STRING_CHARS );
	mainGui->SetStateString( "current_levelshot", screenshot );

// cnicholson: Need to sort the material screenshot so it doesn't overlap other things
	const idMaterial *mat = declManager->FindMaterial( screenshot );
	mat->SetSort( SS_GUI );
}

/*
================
LocalServerRedirect
Dummy local redirect for gui rcon functionality on a local server
================
*/
void LocalServerRedirect( const char* string ) {
	gameLocal.mpGame.ReceiveRemoteConsoleOutput( string );
}

/*
================
idMultiplayerGame::HandleGuiCommands
================
*/

const char* idMultiplayerGame::HandleGuiCommands( const char *_menuCommand ) {

	idUserInterface	*currentGui;

	if ( !_menuCommand[ 0 ] ) {
		common->Printf( "idMultiplayerGame::HandleGuiCommands: empty command\n" );
		return "continue";
	}

	switch ( currentMenu ) {
		case 0:
			return NULL;	// this will tell session to not send us events/commands anymore
		
		case 1:
			currentGui = mainGui;
			break;

		case 2:
			currentGui = msgmodeGui;
			break;

		case 3:
			currentGui = mainGui;
			break;

		default:
			gameLocal.Warning( "idMultiplayerGame::HandleGuiCommands() - Unknown current menu '%d'\n", currentMenu );
			return NULL;
	}
	
 	idCmdArgs args;
	args.TokenizeString( _menuCommand, false );

	const char* cmd;

#define MATCH(_str_) (!idStr::Icmp( cmd, _str_ ))

	for ( int argv = 0; argv < args.Argc(); ) {
		cmd = args.Argv( argv++ );

		switch ( cmd[0] ) {
			case ';':
				continue;

			case 'c':
				if ( MATCH( "close" ) ) {
					DisableMenu();
					return NULL;
				}
				else if ( !idStr::Icmp( cmd, "chatmessage" ) ) {
					int	mode = currentGui->State().GetInt( "messagemode" );
					const char* text;
					text = currentGui->State().GetString( "chattext" );
					if ( *text ) {
						if ( mode > 0 ) {
							cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "sayTeam \"%s\"", text ) );
						} else {
							cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "say \"%s\"", text ) );
						}
					}

					if ( currentMenu ==	1 || currentMenu == 3 )	{
						return "continue";
					} else {
						DisableMenu();
						return NULL;
					}
				}
				else if ( MATCH( "changeclass" ) ) {
					int classNum = atoi( args.Argv( argv++ ) ) + 1;
					cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "changeclass %d", classNum ) );
				}
				
				break;

			case 'g':
				if ( MATCH( "gotoMainMenu" ) ) {
					DisableMenu();
					static idStr menuCmd;
					menuCmd.Clear();						// cnicholson: In order to avoid repeated eventnames from screwing up the menu system, clear it.
					menuCmd.Append( "main" );
					const char* eventName = "";
					if( args.Argc() - argv >= 1 ) {
						eventName = args.Argv( argv++ );
						menuCmd.Append( " " );
						menuCmd.Append( eventName );
					}
					return menuCmd.c_str();
				}
				break;

			case 'j':
				if ( MATCH( "jointeam" ) ) {
					int teamNum = atoi( args.Argv( argv++ ) ) + 1;
					cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "jointeam %d", teamNum ) );
				}
				break;

			case 'p':
				if ( MATCH( "play" ) ) {
					idStr snd =	args.Argv( argv++ );
					int	channel	= 1;
					if ( snd.Length() == 1 ) {
						channel	= atoi(	snd	);
						snd	= args.Argv( argv++	);
					}
					soundSystem->PlayShaderDirectly( SOUNDWORLD_GAME, snd, channel );
					continue;
				}
				break;

			case 'q':
				if ( MATCH( "q4f_updateStats" ) ) {
					tfStatManager->UpdateGUIStats( true );
				}
				else if ( MATCH( "q4f_redrawStats" ) ) {
					tfStatManager->RedrawGUIStats( mainGui );
				}
				break;

			case 's':
				if ( MATCH( "spectate" ) ) {
					int teamNum = atoi( args.Argv( argv++ ) ) + 1;
					cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "spectate %d", teamNum ) );
				}
				break;

			case 'u':
				if ( MATCH( "updateClass" ) ) {
					UpdateGUIClassInfo( mainGui );
				}
				break;
		}
	}
	

#undef MATCH

		
	return "continue";
}

/*
================
idMultiplayerGame::Draw
================
*/
bool idMultiplayerGame::Draw( int clientNum ) {
	idPlayer *player, *viewPlayer;

	idUserInterface *hud = NULL;

	if ( clientNum == MAX_CLIENTS ) {
		assert( gameLocal.GetDemoState() == DEMO_PLAYING );
		clientNum = gameLocal.GetDemoFollowClient();
		hud = gameLocal.GetDemoHud();
		if ( clientNum == -1 ) {
			gameLocal.freeView.Draw();
			return true;
		}
	}

	if ( clientNum < 0 )
		return false;

	player = viewPlayer = GET_PLAYER( clientNum );

	if ( player == NULL ) {
		return false;
	}

	if ( player->spectating ) {
		viewPlayer = GET_PLAYER( player->spectator );
		if ( viewPlayer == NULL ) {
			return false;
		}
	}

	if ( !viewPlayer->GetRenderView() ) {
		return false;
	}

	// use the hud of the local player
	if ( !hud ) {
		hud = player->hud;
	}
	viewPlayer->playerView.RenderPlayerView( hud );

	// allow force scoreboard to overwrite a fullscreen menu
	if ( currentMenu ) { 
		if ( player->wantSpectate ) {
			mainGui->SetStateString( "spectext", common->GetLocalizedString( "#str_104249" ) );
		} else {
			mainGui->SetStateString( "spectext", common->GetLocalizedString( "#str_104250" ) );
		}
		// if we died, isChatting is cleared, so re-set our chatting cvar
		if ( gameLocal.GetLocalPlayer() && !gameLocal.GetLocalPlayer()->isChatting && !gameLocal.GetLocalPlayer()->pfl.dead ) {
			cvarSystem->SetCVarBool( "ui_chat", true );
			cvarSystem->SetModifiedFlags( CVAR_USERINFO ); // force update
		}
		if ( currentMenu == 1 ) {
			UpdateMainGui();
			mainGui->Redraw( gameLocal.time );
		} else if( currentMenu == 2 ) {
			msgmodeGui->Redraw( gameLocal.time );
		} else if( currentMenu == 3 ) {
			DrawStatSummary();
		}
	} else {
		DrawScoreBoard( player );
	}

	if ( maphud )
		maphud->Redraw( gameLocal.time );

	gameDebug.DrawHud();

	return true;
}

/*
================
idMultiplayerGame::UpdateHud
================
*/
void idMultiplayerGame::UpdateHud( idUserInterface* _mphud ) {
	if ( !_mphud ) {
		return;
	}

	idPlayer *localPlayer;

	// server demos don't have a true local player, but need one for hud updates
	localPlayer = gameLocal.GetLocalPlayer();
	if ( !localPlayer ) {
		assert( gameLocal.GetDemoState() == DEMO_PLAYING && gameLocal.IsServerDemo() );
		assert( gameLocal.GetDemoFollowClient() >= 0 );
		assert( gameLocal.entities[ gameLocal.GetDemoFollowClient() ] && gameLocal.entities[ gameLocal.GetDemoFollowClient() ]->IsType( idPlayer::GetClassType() ) );
		localPlayer = static_cast< idPlayer * >( gameLocal.entities[ gameLocal.GetDemoFollowClient() ] );
	}

	assert( localPlayer );


//asalmon: Turn on/off the lag icon so that clients know that they are losing connection
	if (  networkSystem->ClientGetTimeSinceLastPacket() > 0 && ( networkSystem->ClientGetTimeSinceLastPacket() > cvarSystem->GetCVarInteger("net_clientServerTimeout")*500 ) ) {
		_mphud->SetStateBool("IsLagged", true);
	}
	else{
		_mphud->SetStateBool("IsLagged", false);
	}

	int timeLimit = gameLocal.serverInfo.GetInt( "si_timeLimit" );
	
	// Always show GameTime() for WARMUP and COUNTDOWN.
	mpGameState_t state = gameState.GetMPGameState();
	_mphud->SetStateString( "timeleft", GameTime() );

	bool inNonTimedState = (state == SUDDENDEATH) || (state == WARMUP) || (state == GAMEREVIEW);
	bool inCountdownState = (state == COUNTDOWN);

	_mphud->SetStateBool( "infinity", ( !timeLimit && !inCountdownState ) || inNonTimedState );

	_mphud->SetStateBool( "waitroom", false );

	idStr spectateText0;
	idStr spectateText1;
	idStr spectateText2;

	// non-tourney spectate text
	if( localPlayer->spectating ) {
		if( localPlayer->spectator != localPlayer->entityNumber ) {
			spectateText0 = va( common->GetLocalizedString( "#str_107672" ), gameLocal.GetClientByNum( localPlayer->spectator )->GetUserInfo()->GetString( "ui_name" ) );
		} else if( localPlayer->spectating ) {
			spectateText0 = common->GetLocalizedString( "#str_107673" );
		}

		// spectating instructions
		if( localPlayer->spectator != localPlayer->entityNumber ) {
			//cycle & exit follow
			spectateText1 = va( common->GetLocalizedString( "#str_107698" ), common->KeysFromBinding( "_attack" ), common->KeysFromBinding( "_moveup" )  );
		} else {
			//start follow
			spectateText1 = va( common->GetLocalizedString( "#str_108024" ), common->KeysFromBinding( "_attack" )  );
		}
		
	}

	if( gameState.GetMPGameState() == WARMUP ) {
		RoundReadyToStart( &spectateText1 );
	} else if( gameState.GetMPGameState() == COUNTDOWN ) {
		spectateText1 = va( common->GetLocalizedString( "#str_107671" ), Max( ((gameState.GetNextMPGameStateTime() - gameLocal.time) / 1000) + 1, 0 ) );
	}

	_mphud->SetStateString( "spectatetext0", spectateText0 );
	_mphud->SetStateString( "spectatetext1", spectateText1 );
	_mphud->SetStateString( "spectatetext2", spectateText2 );

	_mphud->StateChanged( gameLocal.time );

	//update awards
	if ( gameLocal.isClient || gameLocal.isListenServer ) {
		tfStatManager->CheckAwardQueue();
	}
}

/*
================
idMultiplayerGame::DrawScoreBoard
================
*/
void idMultiplayerGame::DrawScoreBoard( idPlayer *player ) {

	if ( player->scoreBoardOpen ) {
		if ( !playerState[ player->entityNumber ].scoreBoardUp ) {
			scoreBoard->Activate( true, gameLocal.time );
			playerState[ player->entityNumber ].scoreBoardUp = true;
			player->disableHud = true;
		}
		UpdateScoreboard( scoreBoard );
	} else {
		if ( playerState[ player->entityNumber ].scoreBoardUp ) {
			scoreBoard->Activate( false, gameLocal.time );
			playerState[ player->entityNumber ].scoreBoardUp = false;
			player->disableHud = false;
		}
	}
}

/*
===============
idMultiplayerGame::AddChatLine
===============
*/
void idMultiplayerGame::AddChatLine( const char *fmt, ... ) {

	if ( gameLocal.GameState() <= GAMESTATE_NOMAP )
		return;

	idStr temp;
	va_list argptr;

// mekberg: chat changes.
	wrapInfo_t wrapInfo;
	idStr wrap1;
	idStr wrap2;
	
	va_start( argptr, fmt );
	vsprintf( temp, fmt, argptr );
	va_end( argptr );
	
	temp.StripTrailingOnce("\n");
	
	gameLocal.Printf( "%s\n", temp.c_str() );
	
	// bdube: new chat interraction with hud
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && local->mphud ) {
			wrap1 = temp;
			wrap2 = temp;
		do {
			memset( &wrapInfo, -1, sizeof ( wrapInfo_t ) );
			local->mphud->GetMaxTextIndex( "win_chat", wrap1.c_str( ), wrapInfo );

			// If we have a whitespace near the end. Otherwise the user could enter a giant word.
			if ( wrapInfo.lastWhitespace != -1 &&  float( wrapInfo.lastWhitespace ) / float( wrapInfo.maxIndex ) > .75 ) {
				wrap2 = wrap1.Left( wrapInfo.lastWhitespace++ );

			// Just text wrap, no word wrap.
			} else if ( wrapInfo.maxIndex != -1 ) {					
				wrap2 = wrap1.Left( wrapInfo.maxIndex );

			// We fit in less than a line.
			} else {
				wrap2 = wrap1;
			}

			// Recalc the base string.
			wrap1 = wrap1.Right( wrap1.Length( ) - wrap2.Length( ) );

			// Push to gui.
			local->mphud->SetStateString( "chattext", wrap2.c_str( ) );
			local->mphud->HandleNamedEvent( "addchatline" );
		} while ( wrapInfo.maxIndex != -1 );
	}

	if( chatHistory.Length() + temp.Length() > CHAT_HISTORY_SIZE ) {
		int removeLength = chatHistory.Find( '\n' );
		if( removeLength == -1 ) {
			// nuke the whole string
			chatHistory.Empty();
		} else {
			while( (chatHistory.Length() - removeLength) + temp.Length() > CHAT_HISTORY_SIZE ) {
				removeLength = chatHistory.Find( '\n', removeLength + 1 );
 				if( removeLength == -1 ) {
					chatHistory.Empty();
					break;
				}
			}
		}
		chatHistory = chatHistory.Right( chatHistory.Length() - removeLength );
	}

	chatHistory.Append( temp );
	chatHistory.Append( '\n' );

	if( mainGui ) {
		mainGui->SetStateString( "chat", chatHistory.c_str() );
	}
	
	// play chat sound
	if ( local && playChatSound )
		local->StartSound( "snd_chat", SND_CHANNEL_ANY, 0, false, NULL );
}

void idMultiplayerGame::AddTeamChatLine( const char *fmt, ... ) {
	idStr temp;
	va_list argptr;

// mekberg: chat changes.
	wrapInfo_t wrapInfo;
	idStr wrap1;
	idStr wrap2;
	
	va_start( argptr, fmt );
	vsprintf( temp, fmt, argptr );
	va_end( argptr );
	
	temp.StripTrailingOnce("\n");
	
	gameLocal.Printf( "%s\n", temp.c_str() );
	
	// bdube: new chat interraction with hud
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && local->mphud ) {
			wrap1 = temp;
			wrap2 = temp;
		do {
			memset( &wrapInfo, -1, sizeof ( wrapInfo_t ) );
			local->mphud->GetMaxTextIndex( "win_chat_team", wrap1.c_str( ), wrapInfo );

			// If we have a whitespace near the end. Otherwise the user could enter a giant word.
			if ( wrapInfo.lastWhitespace != -1 &&  float( wrapInfo.lastWhitespace ) / float( wrapInfo.maxIndex ) > .75 ) {
				wrap2 = wrap1.Left( wrapInfo.lastWhitespace++ );

			// Just text wrap, no word wrap.
			} else if ( wrapInfo.maxIndex != -1 ) {					
				wrap2 = wrap1.Left( wrapInfo.maxIndex );

			// We fit in less than a line.
			} else {
				wrap2 = wrap1;
			}

			// Recalc the base string.
			wrap1 = wrap1.Right( wrap1.Length( ) - wrap2.Length( ) );

			// Push to gui.
			local->mphud->SetStateString( "teamChatText", wrap2.c_str( ) );
			local->mphud->HandleNamedEvent( "addteamchatline" );
		} while ( wrapInfo.maxIndex != -1 );
	}

	if( chatHistory.Length() + temp.Length() > CHAT_HISTORY_SIZE ) {
		int removeLength = chatHistory.Find( '\n' );
		if( removeLength == -1 ) {
			// nuke the whole string
			chatHistory.Empty();
		} else {
			while( (chatHistory.Length() - removeLength) + temp.Length() > CHAT_HISTORY_SIZE ) {
				removeLength = chatHistory.Find( '\n', removeLength + 1 );
 				if( removeLength == -1 ) {
					chatHistory.Empty();
					break;
				}
			}
		}
		chatHistory = chatHistory.Right( chatHistory.Length() - removeLength );
	}

	chatHistory.Append( temp );
	chatHistory.Append( '\n' );

	if( mainGui ) {
		mainGui->SetStateString( "chat", chatHistory.c_str() );
	}
	
	// play chat sound
	if ( local )
		local->StartSound( "snd_teamchat", SND_CHANNEL_ANY, 0, false, NULL );
}

void idMultiplayerGame::DrawStatSummary( void ) {
	UpdateScoreboard( mainGui );
	mainGui->Redraw( gameLocal.time );
}

void idMultiplayerGame::ShowStatSummary( void ) {
	if ( !gameLocal.GetLocalPlayer() ) {
		assert( false );
		return;
	}
	DisableMenu( );
	nextMenu = 3;
	mainGui->SetStateInt( "currentTab", 1 );
	gameLocal.sessionCommand = "game_startmenu";
	gameLocal.GetLocalPlayer()->GUIMainNotice( "" );
	gameLocal.GetLocalPlayer()->GUIFragNotice( "" );
}

/*
================
idMultiplayerGame::WriteToSnapshot
================
*/
void idMultiplayerGame::WriteToSnapshot( idBitMsgDelta &msg ) const {
	int 		i;
 	int 		value;

	// 3j: me no thinky we ever go above 32 players;
	int inGamePlayers = 0;

	// write ingame bits first, then we only sync down for ingame clients
	// do a single write, this doesn't change often it's best to deltify in a single shot
	for ( i = 0; i < MAX_CLIENTS; i++ ) {
		if ( playerState[i].ingame ) {
			inGamePlayers |= ( 1 << i );
		}
	}
	msg.WriteLong( inGamePlayers );

	idPlayer* player;

	// those rarely change as well and will deltify away nicely
	for ( i = 0; i < MAX_CLIENTS; i++ ) {
		if ( playerState[i].ingame ) {
			player = GET_PLAYER( i );
	
			msg.WriteBits( player ? player->team : INVALID_TEAM, ASYNC_TEAM_BITS );
			msg.WriteBits( player ? player->currentPC : INVALID_CLASS, ASYNC_CLASS_BITS );

			//msg.WriteBits( player->team, ASYNC_TEAM_BITS );
			//msg.WriteBits( player->currentPC, ASYNC_CLASS_BITS );

			msg.WriteShort( playerState[i].score );
			msg.WriteShort( playerState[i].frags );
		}
	}

	// those change all the time, keep them in a single pack

	for ( i = 0; i < MAX_CLIENTS; i++ ) {
		if ( playerState[i].ingame ) {
			value = idMath::ClampInt( 0, MP_PLAYER_MAXPING, playerState[i].ping );
			msg.WriteBits( value, ASYNC_PLAYER_PING_BITS );
		}
	}
}

/*
================
idMultiplayerGame::ReadFromSnapshot
================
*/
void idMultiplayerGame::ReadFromSnapshot( const idBitMsgDelta &msg ) {
	int 		i;

	int inGamePlayers = msg.ReadLong();

	idPlayer* player;
	int newTeam, newClass;

	for ( i = 0; i < MAX_CLIENTS; i++ ) {
		if ( inGamePlayers & ( 1 << i ) ) {
			playerState[i].ingame = true;

			player = GET_PLAYER( i );
			//assert( player );

			newTeam = msg.ReadBits( ASYNC_TEAM_BITS );
			newClass = msg.ReadBits( ASYNC_CLASS_BITS );

			playerState[i].score = msg.ReadShort();
			playerState[i].frags = msg.ReadShort();

			if ( player && newTeam != player->team )
				player->ChangeTeam( newTeam );

			if ( player && newClass != player->currentPC ) {
				player->ChangeClass( newClass );
			}
		}
		else {
			playerState[i].ingame = false;
		}
	}

	for ( i = 0; i < MAX_CLIENTS; i++ ) {
		if ( playerState[i].ingame ) {
			playerState[ i ].ping = msg.ReadBits( ASYNC_PLAYER_PING_BITS );
		}
	}
}


// bdube: global item sounds
/*
================
idMultiplayerGame::PlayGlobalItemAcquireSound
================
*/
void idMultiplayerGame::PlayGlobalItemAcquireSound( int defIndex ) {
	const idDeclEntityDef*  def;
	def = static_cast<const idDeclEntityDef*>( declManager->DeclByIndex( DECL_ENTITYDEF, defIndex, false ) );
	if ( !def ) {
		gameLocal.Warning ( "NET: invalid entity def index (%d) for global item acquire sound", defIndex );
		return;
	}

	soundSystem->PlayShaderDirectly ( SOUNDWORLD_GAME, def->dict.GetString ( "snd_acquire" ) );	

	if ( gameLocal.isServer ) {
		idBitMsg outMsg;
		byte msgBuf[1024];
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_ITEMACQUIRESOUND );
		outMsg.WriteBits ( defIndex, gameLocal.entityDefBits );
		networkSystem->ServerSendReliableMessage( -1, outMsg );
	}	
}


/*
================
idMultiplayerGame::PrintMessageEvent
================
*/
void idMultiplayerGame::PrintMessageEvent( int to, msg_evt_t evt, int parm1, int parm2 ) {
	ENTDEF decl;

	idPlayer *p = gameLocal.GetLocalPlayer();
	if ( to == -1 || ( p && to == p->entityNumber ) ) {
		switch ( evt ) {
			case MSG_SUICIDE:
				assert( parm1 >= 0 );
				AddChatLine( common->GetLocalizedString( "#str_104293" ), gameLocal.userInfo[ parm1 ].GetString( "ui_name" ) );
				break;
			case MSG_KILLED:
				assert( parm1 >= 0 && parm2 >= 0 );
				AddChatLine( common->GetLocalizedString( "#str_104292" ), gameLocal.userInfo[ parm1 ].GetString( "ui_name" ), gameLocal.userInfo[ parm2 ].GetString( "ui_name" ) );
				break;
			case MSG_KILLEDTEAM:
				assert( parm1 >= 0 && parm2 >= 0 );
				AddChatLine( common->GetLocalizedString( "#str_104291" ), gameLocal.userInfo[ parm1 ].GetString( "ui_name" ), gameLocal.userInfo[ parm2 ].GetString( "ui_name" ) );
				break;
			case MSG_TELEFRAGGED:
				assert( parm1 >= 0 && parm2 >= 0 );
				AddChatLine( common->GetLocalizedString( "#str_104290" ), gameLocal.userInfo[ parm1 ].GetString( "ui_name" ), gameLocal.userInfo[ parm2 ].GetString( "ui_name" ) );
				break;
			case MSG_DIED:
				assert( parm1 >= 0 );
				AddChatLine( common->GetLocalizedString( "#str_104289" ), gameLocal.userInfo[ parm1 ].GetString( "ui_name" ) );
				break;
			case MSG_VOTE:
				AddChatLine( common->GetLocalizedString( "#str_104288" ) );
				break;
			case MSG_SUDDENDEATH:
				AddChatLine( common->GetLocalizedString( "#str_104287" ) );
				break;
			case MSG_JOINEDSPEC:
				if ( parm2 == TEAM_SPEC ) {
					AddChatLine( "%s has joined the spectators.", gameLocal.userInfo[ parm1 ].GetString( "ui_name" ) );
				}
				else {
					assert( tfGame.GetTeam( parm2 ) );
					if ( p && p->spectating ) {
						AddChatLine( "%s is spectating the %s team.", gameLocal.userInfo[ parm1 ].GetString( "ui_name" ), tfGame.GetTeam( parm2 )->GetName() );
					}
				}
				
				break;
			case MSG_TIMELIMIT:
				AddChatLine( common->GetLocalizedString( "#str_104284" ) );
				break;
			case MSG_FRAGLIMIT:
				AddChatLine( common->GetLocalizedString( "#str_104281" ), gameLocal.userInfo[ parm1 ].GetString( "ui_name" ) );
				break;
			case MSG_CAPTURELIMIT:
				AddChatLine( "%s team hit the capture limit.", tfGame.GetTeam( parm1 )->GetName() );
				break;
			case MSG_JOINTEAM:
				assert( tfGame.GetTeam( parm2 ) );
				AddChatLine( "%s^0 joined the %s%s^0 team", gameLocal.userInfo[ parm1 ].GetString( "ui_name" ), tfGame.GetTeamEscapeColor( parm2 ), tfGame.GetTeam( parm2 )->GetName() );
				break;
			case MSG_HOLYSHIT:
				AddChatLine( common->GetLocalizedString( "#str_106732" ) );
				break;

			// <q4f>
			case MSG_CLASSALLOWED:
				AddChatLine( "After dying you will become a%s %s.", parm1 == CLASS_ENGINEER ? "n" : "", tfGame.GetClassName( parm1 ) );
				break;
			case MSG_CLASSDISABLED:
				AddChatLine( "Sorry, that class is disabled."  );
				break;
			case MSG_CLASSFULL:
				AddChatLine( "Sorry, that class is full. You will change classes when it becomes available."  );
				break;
			case MSG_NOGRENADES:
				if ( p )
					AddChatLine( "You are out of %s grenades.", p->GetGrenadeName( parm1 ) );
				// 3j_todo: play boop sound
				break;
			case MSG_ALREADYPRIMING:
				AddChatLine( "Only one grenade can be primed at a time." );
				break;
			case MSG_HOLDPIN:
				AddChatLine( "No %s^0, throw the grenade, not the pin!", gameLocal.userInfo[ parm1 ].GetString( "ui_name" ) );
				break;
			case MSG_BUILD_BADBUILDPOS:
				// 3j_todo: play sound error sound...
				break;
			case MSG_BUILD_WRONGCLASS:
				decl = static_cast<ENTDEF>(declManager->DeclByIndex( DECL_ENTITYDEF, parm1, false ));
				if ( decl ) {
					AddChatLine( decl->dict.GetString( "msg_wrongclass", "wrong class." ) );
				}
				break;
			case MSG_BUILD_BUILDLIMIT:
				decl = static_cast<ENTDEF>(declManager->DeclByIndex( DECL_ENTITYDEF, parm1, false ));
				if ( decl ) {
					AddChatLine( decl->dict.GetString( "msg_buildlimit", "build limit." ) );
				}
				break;
			case MSG_BUILD_NOTENOUGHAMMO:
				decl = static_cast<ENTDEF>(declManager->DeclByIndex( DECL_ENTITYDEF, parm1, false ));
				if ( decl ) {
					AddChatLine( decl->dict.GetString( "msg_notenoughammo", "not enough ammo." ) );
				}
				break;
			case MSG_SENTRY_KILL:
				if ( parm1 >= 0 && parm1 < MAX_CLIENTS ) {
					idPlayer* owner = GET_PLAYER( parm1 );
					if ( owner ) {
						idStr ownerName = owner->GetUserInfo()->GetString( "ui_name" );
						ownerName.RemoveEscapes();

						idEntity* attacker = gameLocal.entities[ parm2 ];

						if ( !attacker || !attacker->IsType( idPlayer::GetClassType() ) ) {
							AddChatLine( "%s%s's ^3sentry gun malfunctioned.", tfGame.GetTeamEscapeColor( owner->team ), ownerName.c_str() );
						}
						else if ( owner == attacker ) {
							AddChatLine( "%s%s ^3destroyed his own sentry gun.", tfGame.GetTeamEscapeColor( owner->team ), ownerName.c_str() );
						}
						else {
							idStr attackerName = static_cast<idPlayer*>(attacker)->GetUserInfo()->GetString( "ui_name" );
							attackerName.RemoveEscapes();
							AddChatLine( "%s%s destroyed %s%s's ^3sentry gun.", tfGame.GetTeamEscapeColor( attacker->team ), attackerName.c_str(), tfGame.GetTeamEscapeColor( owner->team ), ownerName.c_str() );
						}
					}
				}
				break;
			case MSG_NEED_MORE_CELLS_SENT:
				AddChatLine( "You need 130 cells to upgrade a sentry." );
				break;

			// </q4f>

			default:
				gameLocal.DPrintf( "PrintMessageEvent: unknown message type %d\n", evt );
				return;
		}
	}
	if ( !gameLocal.isClient && ( to < 0 || to != gameLocal.localClientNum ) ) {
		idBitMsg outMsg;
		byte msgBuf[1024];
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_DB );
		outMsg.WriteByte( evt );
		outMsg.WriteLong( parm1 );
		outMsg.WriteLong( parm2 );
		networkSystem->ServerSendReliableMessage( to, outMsg );
	}
}


/*
================
idMultiplayerGame::PrintMessage
================
*/
void idMultiplayerGame::PrintMessage( int to, const char* msg ) {
	if( idStr::Length( msg ) >= MAX_PRINT_LEN ) {
		common->Warning( "idMultiplayerGame::PrintMessage() - Not transmitting message of length %d", idStr::Length( msg ) );
		return;
	}

	AddChatLine( msg );

	if ( !gameLocal.isClient ) {
		idBitMsg outMsg;
		byte msgBuf[1024];
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_PRINT );
		outMsg.WriteString( msg );
		networkSystem->ServerSendReliableMessage( to, outMsg );
	}
}


/*
================
idMultiplayerGame::CheckSpawns
================
*/
void idMultiplayerGame::CheckRespawns() {
	mpGameState_t state = gameState.GetMPGameState();

	idPlayer* p = NULL;
	for ( int i = 0; i < gameLocal.numClients; i++ ) {
		p = GET_PLAYER( i );

		if ( p ) {
			if ( WantRespawn( p ) ) {
				if ( state == SUDDENDEATH || state == WARMUP || state == COUNTDOWN || state == GAMEON ) {
					Respawn( p);
				}
			} else if ( p->wantSpectate && !p->spectating ) {
				p->ServerSpectate( true );
				CheckAbortGame();
			}
		}
	}
}

void idMultiplayerGame::FreeLight ( int lightID ) {
	if ( lightHandles[lightID] != -1 && gameRenderWorld ) {
		gameRenderWorld->FreeLightDef( lightHandles[lightID] );
		lightHandles[lightID] = -1;
	}
}

void idMultiplayerGame::UpdateLight ( int lightID, idPlayer *player ) {
	lights[ lightID ].origin = player->GetPhysics()->GetOrigin() + idVec3( 0, 0, 20 );
	
	if ( lightHandles[ lightID ] == -1 ) {
		lightHandles[ lightID ] = gameRenderWorld->AddLightDef ( &lights[ lightID ] );
	} else {
		gameRenderWorld->UpdateLightDef( lightHandles[ lightID ], &lights[ lightID ] );
	}
}

/*
================
idMultiplayerGame::MessageMode_f
================
*/
void idMultiplayerGame::MessageMode_f( const idCmdArgs &args ) {
	gameLocal.mpGame.MessageMode( args );
}

/*
================
idMultiplayerGame::MessageMode
================
*/
void idMultiplayerGame::MessageMode( const idCmdArgs &args ) {
	const char *mode;
	int imode;

	if ( !gameLocal.isMultiplayer ) {
		common->Printf( "clientMessageMode: only valid in multiplayer\n" );
		return;
	}
	if ( !mainGui ) {
		common->Printf( "no local client\n" );
		return;
	}
	mode = args.Argv( 1 );
	if ( !mode[ 0 ] || !gameLocal.IsTeamGame() ) {
		imode = 0;
	} else {
		imode = atoi( mode );
	}
	msgmodeGui->SetStateString( "messagemode", imode ? "1" : "0" );
	msgmodeGui->SetStateString( "chattext", "" );
	nextMenu = 2;
	// let the session know that we want our ingame main menu opened
	gameLocal.sessionCommand = "game_startmenu";
}

/*
================
idMultiplayerGame::VoiceMute_f
================
*/
void idMultiplayerGame::VoiceMute_f( const idCmdArgs &args ) {
	if ( args.Argc() < 2 ) {
		common->Printf( "USAGE: clientvoicemute <player>\n" );
		return;
	}
	gameLocal.mpGame.ClientVoiceMute( gameLocal.mpGame.GetClientNumFromPlayerName( args.Argv( 1 ) ), true );
}

/*
================
idMultiplayerGame::VoiceUnmute_f
================
*/
void idMultiplayerGame::VoiceUnmute_f( const idCmdArgs &args ) {
	if ( args.Argc() < 2 ) {
		common->Printf( "USAGE: clientvoiceunmute <player>\n" );
		return;
	}
	gameLocal.mpGame.ClientVoiceMute( gameLocal.mpGame.GetClientNumFromPlayerName( args.Argv( 1 ) ), false );
}


/*
================
idMultiplayerGame::ForceTeamChange_f
================
*/
void idMultiplayerGame::ForceTeamChange_f( const idCmdArgs &args)	{

	if( !gameLocal.isMultiplayer || args.Argc() < 3 )	{
		common->Printf( "[MP ONLY] Forces player to change teams. Usage: ForceTeamChange <client number> <team name>\n" );
		return;
	}

	idStr clientId;
	int clientNum;

	clientId = args.Argv( 1 );
	if ( !clientId.IsNumeric() ) {
		common->Printf( "usage: ForceTeamChange <client NUMBER> <team name>\n" );
		return;
	}

	clientNum = atoi( clientId );

	TFTeam* team = tfGame.GetTeam( args.Argv( 2 ) );
	
	if ( !team ) {
		common->Printf( "Unknown or disabled team name '%s'\n", args.Argv( 2 ) );
		return;
	}

	idPlayer* player = GET_PLAYER( clientNum );
	
	if ( player ) {
		gameLocal.mpGame.JoinTeam( clientNum, team->GetTeamNum() );
	}
}


/*
================
idMultiplayerGame::RemoveClientFromBanList_f
================
*/
void idMultiplayerGame::RemoveClientFromBanList_f( const idCmdArgs& args )	{

	if( !gameLocal.isMultiplayer )	{
		common->Printf( "[MP ONLY] Remove player from banlist. Usage: RemoveClientFromBanList <client number>\n" );
		return;
	}
	
	idStr clientId;
	clientId = args.Argv( 1 );
	int clientNum;

	if ( !clientId.IsNumeric() ) {
		common->Printf( "Usage: RemoveClientFromBanList <client number>\n" );
		return;
	}

	clientNum = atoi( clientId );

	const char *clientGuid = networkSystem->GetClientGUID( clientNum ); //  gameLocal.GetGuidByClientNum( clientNum );

	if ( NULL == clientGuid || !clientGuid[ 0 ]) {
		common->DPrintf( "idMultiplayerGame::HandleServerAdminRemoveBan:  bad guid!\n" );
		return;
	}

	if ( gameLocal.isServer || gameLocal.isListenServer ) {
		// remove from the ban list
		gameLocal.RemoveGuidFromBanList( clientGuid );
	}

}

/*
================
idMultiplayerGame::ProcessRconReturn
================
*/
void idMultiplayerGame::ProcessRconReturn( bool success )	{

	if( success )	{
		mainGui->HandleNamedEvent("adminPasswordSuccess");
	} else {
		mainGui->HandleNamedEvent("adminPasswordFail");
	}
}

/*
================
idMultiplayerGame::DisconnectClient
================
*/
void idMultiplayerGame::DisconnectClient( int clientNum ) {

	// gameLocal.entities[ clientNum ] could be null if server is shutting down
	if( gameLocal.entities[ clientNum ] ) {
		// only kill non-spectators
		idPlayer* p = GET_PLAYER( clientNum );
		if( !p->spectating ) {
			p->Kill( true, true );
		}
	}

	delete gameLocal.entities[ clientNum ];

	voteSystem.ClearClientVote( clientNum );

	CheckAbortGame();

	privatePlayers &= ~( 1 << clientNum );

	// update serverinfo
	UpdatePrivatePlayerCount();
}

/*
================
idMultiplayerGame::CheckAbortGame
================
*/
void idMultiplayerGame::CheckAbortGame( void ) {
	// only checks for aborts -> game review below
	if ( gameState.GetMPGameState() != COUNTDOWN && gameState.GetMPGameState() != GAMEON && gameState.GetMPGameState() != SUDDENDEATH ) {
		return;
	}

	if ( TimeLimitHit() ) {
		gameState.NewState( GAMEREVIEW );
	}
}

/*
================
idMultiplayerGame::WantKilled
================
*/
void idMultiplayerGame::WantKilled( int clientNum ) {
	idEntity *ent = gameLocal.entities[ clientNum ];

// jnewquist: Use accessor for static class type 
	if ( ent && ent->IsType( idPlayer::GetClassType() ) ) {

		static_cast<idPlayer *>( ent )->Kill( false, false );
	}
}

/*
================
idMultiplayerGame::MapRestart
================
*/
void idMultiplayerGame::MapRestart( void ) {

	// jshepard: clean up votes
	//ClearVote();

	assert( !gameLocal.isClient );

	ClearAnnouncerSounds();

	if ( gameLocal.GameState() != GAMESTATE_SHUTDOWN && gameState.GetMPGameState() != WARMUP ) {
		gameState.NewState( WARMUP );
		// force an immediate state detection/update, otherwise if we update our state this
		// same frame we'll miss transitions
		gameState.SendState();

		gameState.SetNextMPGameState( INACTIVE );
		gameState.SetNextMPGameStateTime( 0 );
	}
}

/*
================
idMultiplayerGame::JoinTeam
================
*/
void idMultiplayerGame::JoinTeam( int clientNum, int newTeam ) {

	assert( !gameLocal.isClient );
	assert( clientNum >= 0 && clientNum < MAX_CLIENTS );
	
	idPlayer* player = GET_PLAYER( clientNum );
	
	if ( !player )
		return;

	// don't switch teams if we're already on it
	/*
	if ( newTeam == player->team && !player->spectating ) {
		return;
	}
	*/

	TFTeam* team = NULL;

	int numTeamPlayers;

	if( newTeam == TEAM_AUTO ) {
		// autoteam
		int minCount = MAX_CLIENTS;

		idList<int> minTeams;

		for( int i = 0; i < tfGame.GetTeamCount(); i++ ) {
			team = tfGame.GetTeam( i );

			// don't join this team if it's full
			if ( team->IsFull() ) {
				continue;
			}

			numTeamPlayers = team->GetNumPlayers();

			if( numTeamPlayers < minCount ) {
				minCount = numTeamPlayers;
				minTeams.Clear();
				minTeams.Append( i );
			}
			else if ( numTeamPlayers == minCount ) {
				minTeams.Append( i );
			}
		}

		if ( minTeams.Num() <= 0 ) {
			//gameLocal.Warning( "JoinTeam: could not find an open team." );
			return;
		}

		int randTeam = gameLocal.random.RandomInt( minTeams.Num() - 1 );
		assert( randTeam < minTeams.Num() );
		
		newTeam = minTeams[ randTeam ];
	}
	else {
		// don't allow joins if full
		team = tfGame.GetTeam( newTeam );
		if ( !team || team->IsFull() )
			return;
	}

	static bool lastAuto = true;
	if( newTeam == TEAM_AUTO ) {
		if ( lastAuto )
			newTeam = 0;
		else
			newTeam = 1;
		lastAuto = !lastAuto;
	}

	
	team = tfGame.GetTeam( newTeam );

	if ( !team ) {
		gameLocal.Warning( "JoinTeam: unknown or disabled team num %d\n", newTeam );
		return;
	}

	player->wantSpectate = false;

	if ( player->IsInTeleport() ) {
 		player->ServerSendEvent( idPlayer::EVENT_ABORT_TELEPORTER, NULL, false, -1 );
		player->SetPrivateCameraView( NULL );
	}

	player->Kill( true, true );
	CheckAbortGame();

	if ( IsInGame( clientNum ) ) {
		PrintMessageEvent( -1, MSG_JOINTEAM, clientNum, newTeam );
	}

	player->ChangeTeam( newTeam );

	player->ChangeClass( INVALID_CLASS, true );
}


//--------------------------------------------------------------------------
// Process a request to join the spectators
//--------------------------------------------------------------------------
void idMultiplayerGame::JoinSpectators( int clientNum, int specTeam ) {

	assert( !gameLocal.isClient );
	assert( clientNum >= 0 && clientNum < MAX_CLIENTS );
	

	idPlayer* player = static_cast<idPlayer *>( gameLocal.entities[ clientNum ] );
	
	if ( !player )
		return;

	player->wantSpectate = true;

	if ( !player->spectating ) {
		if ( player->IsInTeleport() ) {
 			player->ServerSendEvent( idPlayer::EVENT_ABORT_TELEPORTER, NULL, false, -1 );
			player->SetPrivateCameraView( NULL );
		}

		player->Kill( true, true );
		CheckAbortGame();
	}

	if ( IsInGame( clientNum ) ) {
		PrintMessageEvent( -1, MSG_JOINEDSPEC, clientNum, specTeam );
	}

	player->team = specTeam;
	player->currentPC = CLASS_COUNT;
	player->nextPC = CLASS_COUNT;

	player->ServerSpectate( true );
}

/*
================
idMultiplayerGame::ProcessChatMessage
================
*/
void idMultiplayerGame::ProcessChatMessage( int clientNum, chatTargetType_t target, const char *text, int shaderIndex ) {
	idBitMsg	outMsg;
	byte		msgBuf[ 256 ];
	int			send_to; // 0 - all, 1 - specs, 2 - team
	idPlayer*	p = NULL;

	assert( !gameLocal.isClient );

	bool team;

	if ( target == CHAT_TARGET_ALL )
		team = false;
	else if ( target == CHAT_TARGET_TEAM )
		team = true;
	else
		return;

	if ( clientNum >= 0 ) {
		p = GET_PLAYER( clientNum );
		if ( !p ) {
			return;
		}

		if ( p->spectating && p->wantSpectate ) {
			if ( team || ( !g_spectatorChat.GetBool() && ( gameState.GetMPGameState() == GAMEON || gameState.GetMPGameState() == SUDDENDEATH ) ) ) {
				team = true;
				send_to = 1;
			} else {
				// to all
				send_to = 0;
			}
		}
		else if ( team ) {
			/*TFTeam* pteam = tfGame.GetTeam( p->team );
			if ( !pteam )
				return;*/

			send_to = 2;
		} else {
			// to all
			send_to = 0;
		}
	} else {
		send_to = 0;
	}

	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
		clientNum = MAX_CLIENTS;
	}
	else if ( shaderIndex >= 0 ) {
		if ( gameLocal.time < lastVoiceMessageTimes[ clientNum ] + 1000 )
			shaderIndex = -1;
		else
			lastVoiceMessageTimes[ clientNum ] = gameLocal.time;
	}

	idStr txt = text;

	DeTokenChatMessage( false, txt, p );

	// put the message together
	outMsg.Init( msgBuf, sizeof( msgBuf ) );
	outMsg.WriteByte( GAME_RELIABLE_MESSAGE_TFCHAT );
	outMsg.WriteBits( target, 2 );
	outMsg.WriteString( txt.c_str() );

	if ( shaderIndex >= 0 ) {
		outMsg.WriteBits( 1, 1 );
		outMsg.WriteLong( shaderIndex );
	}
	else {
		outMsg.WriteBits( 0, 1 );
	}
	outMsg.WriteBits( clientNum, ASYNC_MAX_CLIENT_BITS );

	// always write last death and current locations
	if ( !p ) {
		outMsg.WriteByte( 0 );
		outMsg.WriteByte( 0 );
		outMsg.WriteByte( 0 );
		outMsg.WriteByte( 0 );
		outMsg.WriteByte( 0 );
		outMsg.WriteByte( 0 );
	}
	else {
		byte bytes[3];
		gameLocal.NormalizePositionVector( p->currentLocation ? p->currentLocation->GetPos() : vec3_zero, bytes );
		outMsg.WriteByte( bytes[0] );
		outMsg.WriteByte( bytes[1] );
		outMsg.WriteByte( bytes[2] );
		gameLocal.NormalizePositionVector( p->deathLocation ? p->deathLocation->GetPos() : vec3_zero, bytes );
		outMsg.WriteByte( bytes[0] );
		outMsg.WriteByte( bytes[1] );
		outMsg.WriteByte( bytes[2] );
	}

	if ( !gameLocal.isClient && !gameLocal.isListenServer ) {
		gameLocal.Printf( "%s\n", txt.c_str() );
	}

	idPlayer* to = NULL;
	for ( int i = 0; i < gameLocal.numClients; i++ ) {
		to = GET_PLAYER( i );
		if ( !to )
			continue;

		switch( send_to ) {
			case 0:
				if ( !p || !to->IsPlayerMuted( p ) ) {
					if ( to->entityNumber == gameLocal.localClientNum ) {
						PrintChatMessage( clientNum, target, txt.c_str(), shaderIndex );
					}
					else {
						networkSystem->ServerSendReliableMessage( to->entityNumber, outMsg );
					}
				}
				break;

			case 1:
				if ( !p || ( to->spectating && !to->IsPlayerMuted( p ) ) ) {
					if ( to->entityNumber == gameLocal.localClientNum ) {
						PrintChatMessage( clientNum, target, txt.c_str(), shaderIndex );
					}
					else {
						networkSystem->ServerSendReliableMessage( to->entityNumber, outMsg );
					}
				}
				break;

			case 2:
				if ( !p || ( to->team == p->team && !to->IsPlayerMuted( p ) ) ) {
					if ( to->entityNumber == gameLocal.localClientNum ) {
						PrintChatMessage( clientNum, target, txt.c_str(), shaderIndex );
					}
					else {
						networkSystem->ServerSendReliableMessage( to->entityNumber, outMsg );
					}
				}
				break;
		}
	}
}

void idMultiplayerGame::PrintChatMessage( int clientNum, chatTargetType_t target, const char* text, int shaderIndex ) {
	if ( clientNum >= 0 && clientNum < MAX_CLIENTS ) {
		idPlayer* sender = GET_PLAYER( clientNum );

		if ( !sender )
			return;

		idStr str = text;

		DeTokenChatMessage( true, str, sender );

		const idSoundShader* shader = NULL;

		if ( shaderIndex >= 0 ) {
			shader = (const idSoundShader*)declManager->DeclByIndex( DECL_SOUND, shaderIndex, false );
			
			if ( shader )
				soundSystem->PlayShaderDirectly( SOUNDWORLD_GAME, shader->GetName(), SND_CHANNEL_ANY );
				//sender->StartSoundShader( shader, SND_CHANNEL_ANY, 0, false, NULL );
		}

		bool team = target == CHAT_TARGET_TEAM;

		if ( !team ) {
			playChatSound = true;

			if ( shader ) {
				AddChatLine( "%s %s^0: %s", I_VOICE_ENABLED, sender->GetUserInfo()->GetString( "ui_name", "player" ), str.c_str() );
			}
			else {
				AddChatLine( "%s^0: %s", sender->GetUserInfo()->GetString( "ui_name", "player" ), str.c_str() );
			}
			playChatSound = false;
		}
		else {
			const char* pos = sender->currentLocation ? sender->currentLocation->GetString() : "unknown";

			if ( shader ) {
				AddTeamChatLine( "%s %s^0 ( %s^0 ): %s", I_VOICE_ENABLED, sender->GetUserInfo()->GetString( "ui_name", "player" ), pos, str.c_str() );
			}
			else {
				AddTeamChatLine( "%s^0 ^7( %s^0 ^7)^0: %s", sender->GetUserInfo()->GetString( "ui_name", "player" ), pos, str.c_str() );
			}
		}
	}
	else {
		AddChatLine( "server: %s", text );
	}
}

void idMultiplayerGame::DeTokenChatMessage( bool asClient, idStr& msg, idEntity* chatter ) {

	if ( !chatter )
		return;

	if ( chatter->IsType( idPlayer::GetClassType() ) ) {
		idPlayer* p = static_cast<idPlayer*>(chatter);

		if ( asClient ) {
	
			const char* cloc = p->currentLocation ? p->currentLocation->GetString() : "unknown";
			const char* dloc = p->deathLocation ? p->deathLocation->GetString() : "unknown";

			msg.Replace( "/L", cloc );
			msg.Replace( "/D", dloc );
			msg.Replace( "/N", p->uiName );

			if ( IS_VALID_CLASS_NUM( p->currentPC ) )
				msg.Replace( "/C", tfGame.GetClassName( p->currentPC ) );
			else
				msg.Replace( "/C", "spectator" );
		}
		else {
			msg.Replace( "/H", va( "%d", p->health ) );
			msg.Replace( "/A", va( "%d", p->inventory.armor ) );

			if ( !p->spectating ) {
				int pTeamNum = p->disguiseTeam != INVALID_TEAM ? p->disguiseTeam : p->team;
				TFTeam* pTeam = tfGame.GetTeam( pTeamNum );
				int pClass = p->disguiseClass != INVALID_CLASS ? p->disguiseClass : p->currentPC;

				const char* disguise = va( "%s%s^0 %s",
					tfGame.GetTeamEscapeColor( pTeamNum ),
					pTeam ? pTeam->GetName() : "Spec",
					pClass != INVALID_CLASS ? tfGame.GetClassName( pClass, false ) : "" );

				msg.Replace( "/G", disguise );
			}
			else {
				msg.Replace( "/G", "spectator" );
			}
		}
	}
}

/*
================
idMultiplayerGame::Precache
================
*/
void idMultiplayerGame::Precache( void ) {
	int			i;

	gameLocal.FindEntityDef( "player_marine", false );
	
	// MP game sounds
	for ( i = 0; i < AS_NUM_SOUNDS; i++ ) {
		declManager->FindSound( announcerSoundDefs[ i ], false );
	}

	// MP guis. just make sure we hit all of them
	i = 0;
	while ( MPGuis[ i ] ) {
		uiManager->FindGui( MPGuis[ i ], true );
		i++;
	};
}

/*
================
idMultiplayerGame::ToggleUserInfo
================
*/
void idMultiplayerGame::ThrottleUserInfo( void ) {
	int i;

	assert( gameLocal.localClientNum >= 0 );

	i = 0;
	while ( ThrottleVars[ i ] ) {
		if ( idStr::Icmp( gameLocal.userInfo[ gameLocal.localClientNum ].GetString( ThrottleVars[ i ] ),
			cvarSystem->GetCVarString( ThrottleVars[ i ] ) ) ) {
			if ( gameLocal.realClientTime < switchThrottle[ i ] ) {
				AddChatLine( common->GetLocalizedString( "#str_104299" ), common->GetLocalizedString( ThrottleVarsInEnglish[ i ] ), ( switchThrottle[ i ] - gameLocal.time ) / 1000 + 1 );
				cvarSystem->SetCVarString( ThrottleVars[ i ], gameLocal.userInfo[ gameLocal.localClientNum ].GetString( ThrottleVars[ i ] ) );
			} else {
				switchThrottle[ i ] = gameLocal.time + ThrottleDelay[ i ] * 1000;
			}
		}
		i++;
	}
}

/*
================
idMultiplayerGame::CanPlay
================
*/
bool idMultiplayerGame::CanPlay( idPlayer *p ) {
	return p && playerState[ p->entityNumber ].ingame && p->ReadyToPlay();
}

/*
================
idMultiplayerGame::EnterGame
================
*/
void idMultiplayerGame::EnterGame( int clientNum ) {
 	assert( !gameLocal.isClient );
 
 	if ( !playerState[ clientNum ].ingame ) {
 		playerState[ clientNum ].ingame = true;

		// mark them as private and update si_numPrivatePlayers
		for( int i = 0; i < privateClientIds.Num(); i++ ) {
			int num = networkSystem->ServerGetClientNum( privateClientIds[ i ] );

			// check for timed out clientids
			if( num < 0 ) {
				privateClientIds.RemoveIndex( i );
				i--;
				continue;
			}

			if( num == clientNum ) {
				privatePlayers |= (1 << clientNum);
			}
		}

		// update serverinfo
		UpdatePrivatePlayerCount();
 	}
}

/*
================
idMultiplayerGame::WantRespawn
================
*/
bool idMultiplayerGame::WantRespawn( idPlayer *p ) {
	return p->forceRespawn && CanPlay( p );
}

/*
================
idMultiplayerGame::VoiceChat
================
*/
void idMultiplayerGame::VoiceChat_f( const idCmdArgs &args ) {
	gameLocal.mpGame.VoiceChat( args, false );
}

/*
================
idMultiplayerGame::VoiceChatTeam
================
*/
void idMultiplayerGame::VoiceChatTeam_f( const idCmdArgs &args ) {
	gameLocal.mpGame.VoiceChat( args, true );
}

/*
================
idMultiplayerGame::VoiceChat
================
*/
void idMultiplayerGame::VoiceChat( const idCmdArgs &args, bool team ) {
	idBitMsg			outMsg;
	byte				msgBuf[128];
	const char			*voc;
	const idDict		*spawnArgs;
	const idKeyValue	*keyval;
	int					index;

	if ( !gameLocal.isMultiplayer ) {
		common->Printf( "clientVoiceChat: only valid in multiplayer\n" );
		return;
	}
	if ( args.Argc() != 2 ) {
		common->Printf( "clientVoiceChat: bad args\n" );
		return;
	}
	// throttle
	if ( gameLocal.realClientTime < voiceChatThrottle ) {
		return;
	}

	voc = args.Argv( 1 );
	spawnArgs = gameLocal.FindEntityDefDict( "player_marine", false );
	keyval = spawnArgs->MatchPrefix( "snd_voc_", NULL );
	index = 0;
	while ( keyval ) {
		if ( !keyval->GetValue().Icmp( voc ) ) {
			break;
		}
		keyval = spawnArgs->MatchPrefix( "snd_voc_", keyval );
		index++;
	}
	if ( !keyval ) {
		common->Printf( "Voice command not found: %s\n", voc );
		return;
	}
	voiceChatThrottle = gameLocal.realClientTime + 1000;

	outMsg.Init( msgBuf, sizeof( msgBuf ) );
	outMsg.WriteByte( GAME_RELIABLE_MESSAGE_VCHAT );
	outMsg.WriteLong( index );
	outMsg.WriteBits( team ? 1 : 0, 1 );
	networkSystem->ClientSendReliableMessage( outMsg );
}

/*
================
idMultiplayerGame::ProcessVoiceChat
================
*/
void idMultiplayerGame::ProcessVoiceChat( int clientNum, bool team, int index ) {
	/*const idDict		*spawnArgs;
	const idKeyValue	*keyval;
	idStr				name;
	idStr				snd_key;
	idStr				text_key;
	idPlayer			*p;

	p = static_cast< idPlayer * >( gameLocal.entities[ clientNum ] );

// jnewquist: Use accessor for static class type 
	if ( !( p && p->IsType( idPlayer::GetClassType() ) ) ) {

		return;
	}

	if ( p->spectating ) {
		return;
	}

	// lookup the sound def
	spawnArgs = gameLocal.FindEntityDefDict( "player_marine", false );
	keyval = spawnArgs->MatchPrefix( "snd_voc_", NULL );
	while ( index > 0 && keyval ) {
		keyval = spawnArgs->MatchPrefix( "snd_voc_", keyval );
		index--;
	}
	if ( !keyval ) {
		common->DPrintf( "ProcessVoiceChat: unknown chat index %d\n", index );
		return;
	}
	snd_key = keyval->GetKey();
	name = gameLocal.userInfo[ clientNum ].GetString( "ui_name" );
	sprintf( text_key, "txt_%s", snd_key.Right( snd_key.Length() - 4 ).c_str() );
	if ( team || gameState.GetMPGameState() == COUNTDOWN || gameState.GetMPGameState() == GAMEREVIEW ) {
		ProcessChatMessage( clientNum, team, name, spawnArgs->GetString( text_key ), spawnArgs->GetString( snd_key ) );
	} else {
		p->StartSound( snd_key, SND_CHANNEL_ANY, 0, true, NULL );
		ProcessChatMessage( clientNum, team, name, spawnArgs->GetString( text_key ), NULL );
	}*/
}


// shouchard:  added commands to mute/unmute voice chat
/*
================
idMultiplayerGame::ClientVoiceMute
================
*/
void idMultiplayerGame::ClientVoiceMute( int muteClient, bool mute ) {
	// clients/listen server only
	assert( gameLocal.isListenServer || gameLocal.isClient );

	if ( NULL == gameLocal.GetLocalPlayer() ) {
		return;
	}

	if ( muteClient == -1 || !gameLocal.mpGame.IsInGame( muteClient ) ) {
		gameLocal.Warning( "idMultiplayerGame::ClientVoiceMute() - Invalid client '%d' specified", muteClient );
		return;
	}

	// do the mute/unmute
	gameLocal.GetLocalPlayer()->MutePlayer( muteClient, mute );

	// tell the server
	if( gameLocal.isClient ) {
		idBitMsg outMsg;
		byte msgBuf[128];
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_VOICECHAT_MUTING );
		outMsg.WriteByte( muteClient );
		outMsg.WriteByte( mute ? 1 : 0 ); // 1 for mute, 0 for unmute
		networkSystem->ClientSendReliableMessage( outMsg );
	}

	// display some niceties
	common->Printf( "Player %s's has been %s.\n", gameLocal.GetUserInfo( muteClient )->GetString( "ui_name" ), mute ? "muted" : "unmuted" );
}

/*
================
idMultiplayerGame::GetClientNumFromPlayerName
================
*/
int idMultiplayerGame::GetClientNumFromPlayerName( const char *playerName ) {
	if ( NULL == playerName || '\0' == *playerName ) {
		return -1;
	}

	int clientNum = -1;

	for ( int i = 0; i < gameLocal.numClients; i++ ) {
		if ( gameLocal.entities[ i ] && gameLocal.entities[ i ]->IsType( idPlayer::GetClassType() ) ) {
			if ( 0 == idStr::Icmp( gameLocal.userInfo[ i ].GetString( "ui_name" ), playerName ) ) {
				clientNum = i;
				break;
			}
		}
	}

	if ( -1 == clientNum ) {
		common->Warning( "idMultiplayerGame::GetClientNumFromPlayerName():  unknown player '%s'\n", playerName );
	}

	return clientNum;
}

/*
================
idMultiplayerGame::ServerHandleVoiceMuting
================
*/
void idMultiplayerGame::ServerHandleVoiceMuting( int clientSrc, int clientDest, bool mute ) {
	assert( !gameLocal.isClient );

	idPlayer *playerSrc = gameLocal.GetClientByNum( clientSrc );
	idPlayer *playerDest = gameLocal.GetClientByNum( clientDest );

	if ( NULL == playerSrc ) {
		common->DPrintf( "idMultiplayerGame::ServerHandleVoiceMuting:  couldn't map client %d to a player\n", clientSrc );
		return;
	}

	if ( NULL == playerDest ) {
		common->DPrintf( "idMultiplayerGame::ServerHandleVoiceMuting:  couldn't map client %d to a player\n", clientDest );
		return;
	}

	if ( mute ) {
		playerSrc->MutePlayer( playerDest, true );
		common->DPrintf( "DEBUG:  client %s muted to client %s\n", 
			gameLocal.userInfo[ clientDest ].GetString( "ui_name" ),
			gameLocal.userInfo[ clientSrc ].GetString( "ui_name" ) );
	} else {
		playerSrc->MutePlayer( playerDest, false );
		common->DPrintf( "DEBUG:  client %s unmuted to client %s\n", 
			gameLocal.userInfo[ clientDest ].GetString( "ui_name" ),
			gameLocal.userInfo[ clientSrc ].GetString( "ui_name" ) );
	}
}


/*
================
idMultiplayerGame::ClearAnnouncerSounds

This method deletes unplayed announcer sounds at the end of a game round.  
This fixes a bug where the round time warnings were being played from 
previous rounds.
================
*/
void idMultiplayerGame::ClearAnnouncerSounds() {
	announcerSoundNode_t* snd = NULL;	
	announcerSoundNode_t* nextSnd = NULL;	
	
	for ( snd = announcerSoundQueue.Next(); snd != NULL; snd = nextSnd ) {
		nextSnd = snd->announcerSoundNode.Next();
		snd->announcerSoundNode.Remove ( );
		delete snd;
	}

	announcerPlayTime = 0;
}

/*
================
idMultiplayerGame::HandleServerAdminBanPlayer
================
*/	
void idMultiplayerGame::HandleServerAdminBanPlayer( int clientNum ) {
	if ( clientNum < 0 || clientNum >= gameLocal.numClients ) {
		common->DPrintf( "idMultiplayerGame::HandleServerAdminBanPlayer:  bad client num %d\n", clientNum );
		return;
	}

	if ( gameLocal.isServer	|| gameLocal.isListenServer ) {
		if ( gameLocal.isListenServer && clientNum == gameLocal.localClientNum ) {
			common->DPrintf( "idMultiplayerGame::HandleServerAdminBanPlayer: Cannot ban the host!\n" );
			return;
		}
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "kick %i ban", clientNum ) );
	} else {
		if ( clientNum == gameLocal.localClientNum ) {
			common->DPrintf( "idMultiplayerGame::HandleServerAdminBanPlayer: Cannot ban yourserlf!\n" );
			return;
		}
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "rcon kick %i ban", clientNum ) );		
	}
}

/*
================
idMultiplayerGame::HandleServerAdminRemoveBan
================
*/
void idMultiplayerGame::HandleServerAdminRemoveBan( const char * clientGuid ) {
	if ( NULL == clientGuid || !clientGuid[ 0 ]) {
		common->DPrintf( "idMultiplayerGame::HandleServerAdminRemoveBan:  bad guid!\n" );
		return;
	}

	if ( gameLocal.isServer || gameLocal.isListenServer ) {
		gameLocal.RemoveGuidFromBanList( clientGuid );
	} else {
		int clientNum = gameLocal.GetClientNumByGuid( clientGuid );
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "rcon removeClientFromBanList %d", clientNum ) ); 
	}
}

/*
================
idMultiplayerGame::HandleServerAdminKickPlayer
================
*/
void idMultiplayerGame::HandleServerAdminKickPlayer( int clientNum ) {
	if ( clientNum < 0 || clientNum >= gameLocal.numClients ) {
		common->DPrintf( "idMultiplayerGame::HandleServerAdminKickPlayer:  bad client num %d\n", clientNum );
		return;
	}

	if ( gameLocal.isServer || gameLocal.isListenServer ) {
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "kick %i", clientNum ) );
	} else { 
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "rcon kick %i", clientNum ) );
	}
}

/*
================
idMultiplayerGame::HandleServerAdminForceTeamSwitch
================
*/
void idMultiplayerGame::HandleServerAdminForceTeamSwitch( int clientNum ) {
	if ( !gameLocal.IsTeamGame() ) {
		return;
	}

	if ( clientNum < 0 || clientNum >= gameLocal.numClients ) {
		common->DPrintf( "idMultiplayerGame::HandleServerAdminForceTeamSwitch:  bad client num %d\n", clientNum );
		return;
	}

	if ( gameLocal.isServer || gameLocal.isListenServer ) {
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "forceTeamChange %d\n", clientNum));

/*		if ( gameLocal.entities[ clientNum ] && gameLocal.entities[ clientNum ]->IsType( idPlayer::GetClassType() ) )
		{
			idPlayer *player = static_cast< idPlayer *>( gameLocal.entities[ clientNum ] );
			player->GetUserInfo()->Set( "ui_team", player->team ? "Marine" : "Strogg" );
			cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "updateUI %d\n", clientNum ) );
		}*/
	} else {
/*		idBitMsg outMsg;
		byte msgBuf[ MAX_GAME_MESSAGE_SIZE ];
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_SERVER_ADMIN );
		outMsg.WriteByte( SERVER_ADMIN_FORCE_SWITCH );
		outMsg.WriteByte( clientNum );
		networkSystem->ClientSendReliableMessage( outMsg ); */

		//jshepard: need to be able to do this via rcon
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "rcon forceTeamChange %d\n", clientNum));

	}
}

/*
================
idMultiplayerGame::HandleServerAdminCommands
================
*/
bool idMultiplayerGame::HandleServerAdminCommands( serverAdminData_t &data ) {
	return false;

	/*
	bool restartNeeded = false;
	bool nextMapNeeded = false;
	bool anyChanges = false;
	bool runPickMap = false;
	int nGameType = 0;
	idStr currentMap = si_map.GetString( );

	const char *szGameType = gameLocal.serverInfo.GetString( "si_gametype" );
	if ( 0 == idStr::Icmp( szGameType, "DM" ) ) {
		nGameType = GAME_DM;
	} else if ( 0 == idStr::Icmp( szGameType, "Team DM" ) ) {
		nGameType = GAME_TDM;
	} else if ( 0 == idStr::Icmp( szGameType, "CTF" ) ) {
		nGameType = GAME_CTF;
	} else if ( 0 == idStr::Icmp( szGameType, "Tourney" ) ) {
		nGameType = GAME_TOURNEY;
	} else if ( 0 == idStr::Icmp( szGameType, "Arena CTF" ) ) {
		nGameType = GAME_ARENA_CTF;
	} else {
		nGameType = GAME_SP;
	}
	if ( nGameType != data.gameType ) {
		
		switch ( data.gameType ) {
			case GAME_TDM:			szGameType = "Team DM";		break;
			case GAME_TOURNEY:		szGameType = "Tourney";		break;
			case GAME_CTF:			szGameType = "CTF";			runPickMap = true; break;
			case GAME_ARENA_CTF:	szGameType = "Arena CTF";	runPickMap = true; break;

			// mekberg: hack, if we had 1f ctf the gui index wouldn't be off =(
			case GAME_1F_CTF:		szGameType = "Arena CTF";	runPickMap = true; break;
			default:
			case GAME_DM:			szGameType = "DM";			break;
		}

		//we're going to reset the map here, so make sure to kill the active vote.
		ClientUpdateVote( VOTE_RESET, 0, 0, currentVoteData );
		vote = VOTE_NONE;
		restartNeeded = true;
		anyChanges = true;

		si_gameType.SetString( szGameType );
		if( runPickMap && gameLocal.isServer )	{
			//set the selected map to the admin data value, then make sure it can run the selected gametype.
			si_map.SetString( data.mapName.c_str() );
			if( PickMap( szGameType ) || idStr::Icmp( si_map.GetString( ), currentMap.c_str( ) ) )	{
				nextMapNeeded = true;
				restartNeeded = false;
				data.mapName = idStr( si_map.GetString() );
				data.restartMap = true;
			}
		}
	} 

	// Rcon these cvars if this isn't the server. We can trust the input from the gui that the
	// gametype and map always match.
	if ( !gameLocal.isServer ) {
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "rcon si_autoBalance %d",	data.autoBalance ) );
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "rcon si_captureLimit %d",	data.captureLimit ) );
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "rcon si_fragLimit %d",		data.fragLimit ) );
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "rcon si_gameType %s",		szGameType ) );
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "rcon si_map %s",			data.mapName.c_str() ) );
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "rcon si_tourneyLimit %d",	data.tourneyLimit ) );
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "rcon si_minPlayers %d",	data.minPlayers ) );
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "rcon si_timeLimit %d",		data.timeLimit ) );
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "rcon verifyServerSettings" ) );
		
		if( restartNeeded )	{
			cmdSystem->BufferCommandText( CMD_EXEC_NOW, "rcon serverMapRestart" );
		} else if( data.restartMap || nextMapNeeded || idStr::Icmp( gameLocal.serverInfo.GetString( "si_map" ), data.mapName.c_str() ) ) {
			cmdSystem->BufferCommandText( CMD_EXEC_NOW, "rcon nextMap" );
		}
		else
		{
			cmdSystem->BufferCommandText( CMD_EXEC_NOW, "rcon rescanSI" );
		}
		
		return true;
	}

	if ( data.restartMap ) {
		ClientUpdateVote( VOTE_RESET, 0, 0, currentVoteData );
		vote = VOTE_NONE;
		restartNeeded = true;
		anyChanges = true;
	}

	//this section won't be encountered if the gametype was changed. But that's ok.
	if ( data.mapName.c_str() && idStr::Icmp( data.mapName.c_str(), si_map.GetString() ) ) {
		ClientUpdateVote( VOTE_RESET, 0, 0, currentVoteData );
		vote = VOTE_NONE;
		si_map.SetString(data.mapName.c_str());
		nextMapNeeded = true;
		anyChanges = true;
	}

	if ( data.captureLimit != gameLocal.serverInfo.GetInt( "si_captureLimit" ) ) {
		si_captureLimit.SetInteger( data.captureLimit );
		anyChanges = true;
	}
	if ( data.fragLimit !=  gameLocal.serverInfo.GetInt( "si_fragLimit" ) ) {
		si_fragLimit.SetInteger( data.fragLimit );
		anyChanges = true;
	}
	if ( data.tourneyLimit != gameLocal.serverInfo.GetInt( "si_tourneyLimit" ) ) {
		anyChanges = true;
	}
	if ( data.timeLimit != gameLocal.serverInfo.GetInt( "si_timeLimit" ) ) {
		si_timeLimit.SetInteger( data.timeLimit );
		anyChanges = true;
	}
	if ( data.minPlayers != gameLocal.serverInfo.GetInt( "si_minPlayers" ) ) {
		si_minPlayers.SetInteger( data.minPlayers );
		anyChanges = true;
	}
	if ( data.autoBalance != gameLocal.serverInfo.GetBool( "si_autobalance" ) ) {
		si_autobalance.SetBool( data.autoBalance );
		anyChanges = true;
	}

	
	if ( nextMapNeeded )	{
		ClientUpdateVote( VOTE_RESET, 0, 0, currentVoteData );
		vote = VOTE_NONE;
		cmdSystem->BufferCommandText( CMD_EXEC_APPEND, "nextMap" );
		return anyChanges;
	}
	else if ( gameLocal.NeedRestart() || restartNeeded ) {
		ClientUpdateVote( VOTE_RESET, 0, 0, currentVoteData );
		vote = VOTE_NONE;
		cmdSystem->BufferCommandText( CMD_EXEC_APPEND, "serverMapRestart" );
	}
	else
	{
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, "rescanSI" " " __FILE__ " " __LINESTR__ );
	}
	
	return anyChanges;
	*/
}




/*
===============
idMultiplayerGame::ServerWriteStartState
===============
*/
void idMultiplayerGame::WriteStartState( int clientNum, idBitMsg &msg, bool withLocalClient ) {
	int			i;
	idEntity	*ent;

	// send the start time
	msg.WriteLong( matchStartedTime );
	msg.WriteLong( warmupStartedTime );

	// send the powerup states and the spectate states
	for( i = 0; i < gameLocal.numClients; i++ ) {
		msg.WriteBits( 1, 1 );
		ent = gameLocal.entities[ i ]; 

		if ( ( withLocalClient || i != clientNum ) && ent && ent->IsType( idPlayer::GetClassType() ) ) {
			msg.WriteBits( 1, 1 );
			msg.WriteBits( static_cast< idPlayer * >( ent )->spectating, 1 );
			msg.WriteBits( static_cast< idPlayer * >( ent )->team, ASYNC_TEAM_BITS );
		}
		else {
			msg.WriteBits( 0, 1 );
		}
	}
	msg.WriteBits( 0, 1 );	
}

/*
================
idMultiplayerGame::ServerWriteInitialReliableMessages
================
*/
void idMultiplayerGame::ServerWriteInitialReliableMessages( int clientNum ) {
	idBitMsg	outMsg;
	byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];

	outMsg.Init( msgBuf, sizeof( msgBuf ) );
	outMsg.BeginWriting();
	outMsg.WriteByte( GAME_RELIABLE_MESSAGE_STARTSTATE );
	WriteStartState( clientNum, outMsg, false );
	networkSystem->ServerSendReliableMessage( clientNum, outMsg );

	// we send SI in connectResponse messages, but it may have been modified already
	outMsg.BeginWriting( );
 	outMsg.WriteByte( GAME_RELIABLE_MESSAGE_SERVERINFO );
	outMsg.WriteDeltaDict( gameLocal.serverInfo, NULL );
	networkSystem->ServerSendReliableMessage( clientNum, outMsg );

	outMsg.BeginWriting();
	outMsg.WriteByte( GAME_RELIABLE_MESSAGE_MAPGUI_ALLVARS );

	for ( int i = 0; i < MAX_MAP_GUI_VARS; i++ ) {
		if ( mapGuiVars[i].type != GUI_VAR_TYPE_NONE ) {
			outMsg.WriteBits( 1, 1 );
			outMsg.WriteBits( mapGuiVars[i].type, ASYNC_GUI_VAR_TYPE_BITS );

			switch( mapGuiVars[i].type ) {
				case GUI_VAR_TYPE_BOOL:
					outMsg.WriteBits( mapGuiVars[i].intVal, 1 );
					break;

				case GUI_VAR_TYPE_INT:
				case GUI_VAR_TYPE_FLOAT:
					outMsg.WriteLong( mapGuiVars[i].intVal );
					break;

				case GUI_VAR_TYPE_STRING:
					outMsg.WriteString( mapGuiVars[i].strVal.c_str(), MAX_MAP_GUI_DATASIZE );
					break;
			}
		}
		else {
			outMsg.WriteBits( 0, 1 );
		}
	}
	networkSystem->ServerSendReliableMessage( clientNum, outMsg );

	gameState.SendInitialState( clientNum );
}

void idMultiplayerGame::ClientReadGuiVars( const idBitMsg &msg ) {
	guiVarType_t type;
	int l;
	char buf[ MAX_MAP_GUI_DATASIZE ];

	for ( int i = 0; i < MAX_MAP_GUI_VARS; i++ ) {
		if ( msg.ReadBits( 1 ) ) {
			type = (guiVarType_t)msg.ReadBits( ASYNC_GUI_VAR_TYPE_BITS );

			switch( type) {
				case GUI_VAR_TYPE_BOOL:
					SetMapGuiBool( i, msg.ReadBits( 1 ) != 0 );
					break;

				case GUI_VAR_TYPE_INT:
					SetMapGuiInt( i, msg.ReadLong() );
					break;

				case GUI_VAR_TYPE_FLOAT:
					l = msg.ReadLong();
					SetMapGuiFloat( i, *(reinterpret_cast<float*>(&l) ) );
					break;

				case GUI_VAR_TYPE_STRING:
					msg.ReadString( buf, MAX_MAP_GUI_DATASIZE );
					SetMapGuiString( i, buf );
					break;
			}
		}
	}
}

/*
================
idMultiplayerGame::ClientReadStartState
================
*/
void idMultiplayerGame::ClientReadStartState( const idBitMsg &msg ) {
	int client;

	assert( gameLocal.isClient );

	// read the state in preparation for reading snapshot updates
	matchStartedTime = msg.ReadLong( );
	warmupStartedTime = msg.ReadLong();

	client = 0;
	while ( msg.ReadBits( 1 ) ) {
		if ( msg.ReadBits( 1 ) ) {

			assert( gameLocal.entities[ client ] && gameLocal.entities[ client ]->IsType( idPlayer::GetClassType() ) );

			bool spectate = ( msg.ReadBits( 1 ) != 0 );
			static_cast< idPlayer * >( gameLocal.entities[ client ] )->Spectate( spectate );
			static_cast< idPlayer* >( gameLocal.entities[client] )->ChangeTeam( msg.ReadBits( ASYNC_TEAM_BITS ) );
		}

		client++;
	}
}

const char* idMultiplayerGame::announcerSoundDefs[ AS_NUM_SOUNDS ] = {
	// General announcements
	"announce_general_one",					// AS_GENERAL_ONE
	"announce_general_two",					// AS_GENERAL_TWO
	"announce_general_three",				// AS_GENERAL_THREE
	"announce_general_you_win",				// AS_GENERAL_YOU_WIN
	"announce_general_you_lose",			// AS_GENERAL_YOU_LOSE
	"announce_general_fight",				// AS_GENERAL_FIGHT
	"announce_general_sudden_death",		// AS_GENERAL_SUDDEN_DEATH
	"announce_general_vote_failed",			// AS_GENERAL_VOTE_FAILED
	"announce_general_vote_passed",			// AS_GENERAL_VOTE_PASSED
	"announce_general_vote_now",			// AS_GENERAL_VOTE_NOW
	"announce_general_one_frag",			// AS_GENERAL_ONE_FRAG
	"announce_general_two_frags",			// AS_GENERAL_TWO_FRAGS
	"announce_general_three_frags",			// AS_GENERAL_THREE_FRAGS
	"announce_general_one_minute",			// AS_GENERAL_ONE_MINUTE
	"announce_general_five_minute",			// AS_GENERAL_FIVE_MINUTE
	"announce_general_prepare_to_fight",	// AS_GENERAL_PREPARE_TO_FIGHT
	"announce_general_quad_damage",			// AS_GENERAL_QUAD_DAMAGE
	"announce_general_regeneration",		// AS_GENERAL_REGENERATION
	"announce_general_haste",				// AS_GENERAL_HASTE
	"announce_general_invisibility",		// AS_GENERAL_INVISIBILITY
	// DM announcements
	"announce_dm_you_tied_lead",			// AS_DM_YOU_TIED_LEAD
	"announce_dm_you_have_taken_lead",		// AS_DM_YOU_HAVE_TAKEN_LEAD
	"announce_dm_you_lost_lead",			// AS_DM_YOU_LOST_LEAD
    // Team announcements
	"announce_team_enemy_score",			// AS_TEAM_ENEMY_SCORES
	"announce_team_you_score",				// AS_TEAM_YOU_SCORE
	"announce_team_teams_tied",				// AS_TEAM_TEAMS_TIED
	"announce_team_strogg_lead",			// AS_TEAM_STROGG_LEAD
	"announce_team_marines_lead",			// AS_TEAM_MARINES_LEAD
	"announce_team_join_marine",			// AS_TEAM_JOIN_MARINE
	"announce_team_join_strogg",			// AS_TEAM_JOIN_STROGG
	// CTF announcements
	"announce_ctf_you_have_flag",			// AS_CTF_YOU_HAVE_FLAG
	"announce_ctf_your_team_has_flag",		// AS_CTF_YOUR_TEAM_HAS_FLAG
	"announce_ctf_enemy_has_flag",			// AS_CTF_ENEMY_HAS_FLAG
	"announce_ctf_your_team_drops_flag",	// AS_CTF_YOUR_TEAM_DROPS_FLAG
	"announce_ctf_enemy_drops_flag",		// AS_CTF_ENEMY_DROPS_FLAG
	"announce_ctf_your_flag_returned",		// AS_CTF_YOUR_FLAG_RETURNED
	"announce_ctf_enemy_returns_flag",		// AS_CTF_ENEMY_RETURNS_FLAG
	// Tourney announcements
	"announce_tourney_advance",				// AS_TOURNEY_ADVANCE
	"announce_tourney_join_arena_one",		// AS_TOURNEY_JOIN_ARENA_ONE
	"announce_tourney_join_arena_two",		// AS_TOURNEY_JOIN_ARENA_TWO
	"announce_tourney_join_arena_three",	// AS_TOURNEY_JOIN_ARENA_THREE
	"announce_tourney_join_arena_four",		// AS_TOURNEY_JOIN_ARENA_FOUR
	"announce_tourney_join_arena_five",		// AS_TOURNEY_JOIN_ARENA_FIVE
	"announce_tourney_join_arena_six",		// AS_TOURNEY_JOIN_ARENA_SIX
	"announce_tourney_join_arena_seven",	// AS_TOURNEY_JOIN_ARENA_SEVEN
	"announce_tourney_join_arena_eight",	// AS_TOURNEY_JOIN_ARENA_EIGHT
	"announce_tourney_join_arena_waiting",	// AS_TOURNEY_JOIN_ARENA_WAITING
	"announce_tourney_done",				// AS_TOURNEY_DONE
	"announce_tourney_start",				// AS_TOURNEY_START
	"announce_tourney_eliminated",			// AS_TOURNEY_ELIMINATED
	"announce_tourney_won",					// AS_TOURNEY_WON
	"announce_tourney_prelims",				// AS_TOURNEY_PRELIMS
	"announce_tourney_quarter_finals",		// AS_TOURNEY_QUARTER_FINALS
	"announce_tourney_semi_finals",			// AS_TOURNEY_SEMI_FINALS
	"announce_tourney_final_match"			// AS_TOURNEY_FINAL_MATCH
};

void idMultiplayerGame::ScheduleAnnouncerSound ( announcerSound_t sound, float time, int instance, bool allowOverride ) {
	if( !gameLocal.GetLocalPlayer() ) {
		return;
	}

	if ( time < gameLocal.time ) {
		return;
	}

	announcerSoundNode_t* newSound = new announcerSoundNode_t;
	newSound->soundShader = sound;
	newSound->time = time;
	newSound->announcerSoundNode.SetOwner ( newSound );
	newSound->instance = instance;
	newSound->allowOverride = allowOverride;

	announcerSoundNode_t* snd = NULL;
	for ( snd = announcerSoundQueue.Next(); snd != NULL; snd = snd->announcerSoundNode.Next() ) {
		if ( snd->time > newSound->time ) {
			newSound->announcerSoundNode.InsertBefore ( snd->announcerSoundNode );
			break;
		}
	}
	if ( snd == NULL ) {
 		newSound->announcerSoundNode.AddToEnd ( announcerSoundQueue );
	}
}

void idMultiplayerGame::RemoveAnnouncerSound( int type ) {
	// clean out any preexisting announcer sounds
	announcerSoundNode_t* snd = NULL;	
	announcerSoundNode_t* nextSnd = NULL;	
	for ( snd = announcerSoundQueue.Next(); snd != NULL; snd = nextSnd ) {
		nextSnd = snd->announcerSoundNode.Next();
		if ( snd->soundShader == type ) {
			snd->announcerSoundNode.Remove( );
			delete snd;
			break;
		}
	}

	// if a sound is currently playing, stop it
	if( lastAnnouncerSound == type && gameLocal.GetLocalPlayer() ) {
		gameLocal.GetLocalPlayer()->StopSound( SND_CHANNEL_MP_ANNOUNCER, false );
		lastAnnouncerSound = AS_NUM_SOUNDS;
	}
}

void idMultiplayerGame::RemoveAnnouncerSoundRange( int startType, int endType ) {
	if ( !gameLocal.GetLocalPlayer() )
		return;

	// clean out any preexisting announcer sounds
	announcerSoundNode_t* snd = NULL;	
	announcerSoundNode_t* nextSnd = NULL;	
	for ( snd = announcerSoundQueue.Next(); snd != NULL; snd = nextSnd ) {
		nextSnd = snd->announcerSoundNode.Next();
		for( int i = startType; i <= endType; i++ ) {
			if ( snd->soundShader == i ) {
				snd->announcerSoundNode.Remove( );
				delete snd;
			}
		}
	}

	// if a sound is currently playing, stop it
	for( int i = startType; i <= endType; i++ ) {
		if( lastAnnouncerSound == i ) {
			gameLocal.GetLocalPlayer()->StopSound( SND_CHANNEL_MP_ANNOUNCER, false );
			lastAnnouncerSound = AS_NUM_SOUNDS;
			break;
		}
	}
}


void idMultiplayerGame::ScheduleTimeAnnouncements( void ) {
	if( !gameLocal.GetLocalPlayer() ) {
		// too early
		return;
	}

	if( gameState.GetMPGameState() != COUNTDOWN && gameState.GetMPGameState() != WARMUP ) {
		int timeLimit = gameLocal.serverInfo.GetInt( "si_timeLimit" );
		int endGameTime = 0;

		endGameTime = matchStartedTime + ( timeLimit * 60000 );

		// clean out any preexisting announcer sounds
		RemoveAnnouncerSound( AS_GENERAL_ONE_MINUTE );
		RemoveAnnouncerSound( AS_GENERAL_FIVE_MINUTE );

		if( timeLimit > 5 ) {
			ScheduleAnnouncerSound( AS_GENERAL_FIVE_MINUTE, endGameTime - (5 * 60000) );
		}
		if( timeLimit > 1 ) {
			ScheduleAnnouncerSound( AS_GENERAL_ONE_MINUTE, endGameTime - (60000) );
		}
	}
}

void idMultiplayerGame::PlayAnnouncerSounds( void ) {
	announcerSoundNode_t* snd = NULL;		

	if( !gameLocal.GetLocalPlayer() ) {
		return;
	}

	// if we're done playing the last sound reset override status
	if( announcerPlayTime <= gameLocal.time ) {
		currentSoundOverride = false;
	}

	if ( announcerPlayTime > gameLocal.time && !currentSoundOverride ) {
		return;
	} 

	snd = announcerSoundQueue.Next();
	if( snd && snd->time > gameLocal.time ) {
		return;
	}


	// play the sound locally
	if ( snd && snd->soundShader < AS_NUM_SOUNDS ) {
		int length = 0;

		//don't play timelimit countdown announcements if game is already over
		mpGameState_t state = gameState.GetMPGameState();
		if ( state == GAMEREVIEW //game is over, in scoreboard
			&& ( snd->soundShader == AS_GENERAL_ONE_MINUTE
				|| snd->soundShader == AS_GENERAL_FIVE_MINUTE ) ) {
			//ignore scheduled time limit warnings that haven't executed yet
			snd->announcerSoundNode.Remove();
			delete snd;
		} else {
			snd->announcerSoundNode.Remove();

			gameLocal.GetLocalPlayer()->StartSoundShader( declManager->FindSound( announcerSoundDefs[ snd->soundShader ], false ), SND_CHANNEL_MP_ANNOUNCER, 0, false, &length );
			currentSoundOverride = snd->allowOverride;
			lastAnnouncerSound = snd->soundShader;

			delete snd;
		}

		// if sounds remain to be played, check again	
		announcerPlayTime = gameLocal.time + length;
	} 
}

const char* idMultiplayerGame::GetLongGametypeName( const char* gametype ) {
	return "Quake 4 Fortress";
}

int idMultiplayerGame::GetPlayerTime( idPlayer* player ) {
	return ( gameLocal.time - player->GetConnectTime() ) / 60000;
}

void idMultiplayerGame::EnableDamage( bool enable ) {
	for( int i = 0; i < gameLocal.numClients; i++ ) {
		idPlayer* player = GET_PLAYER( i );

		if( player == NULL ) {
			continue;
		}

		player->fl.takedamage = enable;
	}
}

void idMultiplayerGame::ReceiveRemoteConsoleOutput( const char* output ) {
	if( mainGui ) {
		idStr newOutput( output );

		if( rconHistory.Length() + newOutput.Length() > RCON_HISTORY_SIZE ) {
			int removeLength = rconHistory.Find( '\n' );
			if( removeLength == -1 ) {
				// nuke the whole string
				rconHistory.Empty();
			} else {
				while( (rconHistory.Length() - removeLength) + newOutput.Length() > RCON_HISTORY_SIZE ) {
					removeLength = rconHistory.Find( '\n', removeLength + 1 );
					if( removeLength == -1 ) {
						rconHistory.Empty();
						break;
					}
				}
			}
			rconHistory = rconHistory.Right( rconHistory.Length() - removeLength );
		}


		int consoleInputStart = newOutput.Find( "Console Input: " );
		if( consoleInputStart != -1 ) {
			idStr consoleInput = newOutput.Right( newOutput.Length() - consoleInputStart - 15 );
			newOutput = newOutput.Left( consoleInputStart );
			newOutput.StripTrailing( "\n" );
			consoleInput.StripTrailing( "\n" );
			mainGui->SetStateString( "admin_console_input", consoleInput.c_str() );
		} 

		if( newOutput.Length() ) {
			rconHistory.Append( newOutput );
			rconHistory.Append( '\n' );
		}

		mainGui->SetStateString( "admin_console_history", rconHistory.c_str() );
	}
}

void idMultiplayerGame::ShuffleTeams( void ) {
	idPlayer* p;

	for ( int i = 0; i < gameLocal.numClients; i++ ) {
		p = GET_PLAYER( i );
		if ( !p || p->spectating  || p->wantSpectate ) {
			continue;
		}

		p->team = INVALID_TEAM;
	}

	for ( int i = 0; i < gameLocal.numClients; i++ ) {
		p = GET_PLAYER( i );

		if ( p ) {
			JoinTeam( p->entityNumber, TEAM_AUTO );
		}
	}
}


TFGameState* idMultiplayerGame::GetGameState( void ) { 
	return &gameState; 
}


//--------------------------------------------------------------------------
// Should be called after the new map is loaded
//--------------------------------------------------------------------------
void idMultiplayerGame::SetGameType( const char* mapName ) {
	int gametype = gameLocal.serverInfo.GetInt( "si_gameindex", "1" );

	 // load the mapinfo file
	idStr mapFileNameStripped = mapName;
	mapFileNameStripped.StripFileExtension();
	mapFileNameStripped.StripPath();
	gameLocal.mapInfo.LoadMap( mapFileNameStripped );

	if ( gameLocal.isClient ) {
		gameLocal.gameType = gametype;
		gameState.Clear();
		return;
	}

	// as server, make sure our new gametype is valid

	if ( gametype < 1 ) {
		gametype = 1;
		gameLocal.serverInfo.SetInt( "si_gameindex", 1 );
	}

	if ( !IsValidGameType( gameLocal.mapInfo, gametype ) ) {
		if ( gametype != 1 ) {
			if ( !IsValidGameType( gameLocal.mapInfo, 1 ) ) {
				gameLocal.Error( "No valid gametypes could be found for map %s.", mapName );
				return;
			}
			
			gameLocal.Warning( "Gametype %d is invalid for map %s. Switching to gametype 1.",  gametype, mapName );
			gameLocal.serverInfo.SetInt( "si_gameindex", 1 );
			gametype = 1;
		}
		else {
			gameLocal.Error( "No valid gametypes could be found for map %s.", si_map.GetString() );
			return;
		}
	}

	gameLocal.gameType = gametype;

	cmdSystem->BufferCommandText( CMD_EXEC_NOW, "rescanSI" " " __FILE__ " " __LINESTR__ );

	gameState.Clear();
}

/*
===============
idMultiplayerGame::PickMap
===============
*/
bool idMultiplayerGame::PickMap( idStr gameType ) {
	
	idStrList maps;
	int miss = 0;
	const idDecl *mapDecl;
	const idDeclEntityDef *mapDef;
	int index = 0;
	int btype;
	const char* mapName;

	mapName = si_map.GetString();

	//if we're playing a map of this gametype, don't change.
	mapDecl = declManager->FindType( DECL_MAPDEF, mapName, false );
	mapDef = static_cast<const idDeclEntityDef *>( mapDecl );
	if ( mapDef ) {
		btype = mapDef->dict.GetInt( gameType );
		if(btype)
		{					
			cvarSystem->SetCVarString("si_map",mapName);
			si_map.SetString( mapName );
			return false;
			
		}
	}


	int i;
	idFileList *files;
	idStrList fileList;
	
	int count = 0;

	files = fileSystem->ListFiles( "maps/mp", ".map" );
	for ( i = 0; i < files->GetList().Num(); i++, count++ ) {
		fileList.AddUnique( va( "mp/%s", files->GetList()[i].c_str() ) );
	}
	fileSystem->FreeFileList( files );

	files = fileSystem->ListFiles( "maps/mp", ".mapc" );
	for ( i = 0; i < files->GetList().Num(); i++, count++ ) {
		idStr fixedExtension(files->GetList()[i]);
		fixedExtension.SetFileExtension("map");
		fileList.AddUnique( va( "mp/%s", fixedExtension.c_str() ) );
	}

	fileList.Sort();

	idStr name;
	idStr cycle;

	//Populate the map list
	for ( i = 0; i < fileList.Num(); i++) {
		//Add only MP maps.
		if(!idStr::FindText(fileList[i].c_str(), "mp/"))
		{
			maps.AddUnique(fileList[i].c_str());
		}
	}
	maps.Sort();

	if(maps.Num() > 0)
	{
		while(miss < 100)
		{
			index = gameLocal.random.RandomInt( maps.Num() );
			mapName = maps[index].c_str();
			
			mapDecl = declManager->FindType( DECL_MAPDEF, mapName, false );
			mapDef = static_cast<const idDeclEntityDef *>( mapDecl );
			if ( mapDef ) {
				btype = mapDef->dict.GetInt( gameType );
				if(btype)
				{					
					cvarSystem->SetCVarString("si_map",mapName);
					si_map.SetString( mapName );
					return true;
					
				}
			}
			miss++;
		
		}
	
	}

	//something is wrong and there are no maps for this game type.  This should never happen.
	gameLocal.Warning( "No maps found for game type: %s.\n", gameType.c_str() );
	return false;
}

/*
===============
idMultiplayerGame::WriteNetworkInfo
===============
*/
void idMultiplayerGame::WriteNetworkInfo( idFile *file, int clientNum ) {
	idBitMsg	msg;
	byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];
	
	msg.Init( msgBuf, sizeof( msgBuf ) );
	msg.BeginWriting();
	WriteStartState( clientNum, msg, true );
	file->WriteInt( msg.GetSize() );
	file->Write( msg.GetData(), msg.GetSize() );

	gameState.WriteNetworkInfo( file, clientNum );
}

/*
===============
idMultiplayerGame::ReadNetworkInfo
===============
*/
void idMultiplayerGame::ReadNetworkInfo( idFile* file, int clientNum ) {
	idBitMsg	msg;
	byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];
	int			size;

	file->ReadInt( size );
	msg.Init( msgBuf, sizeof( msgBuf ) );
	msg.SetSize( size );
	file->Read( msg.GetData(), size );
	ClientReadStartState( msg );

	gameState.ReadNetworkInfo( file, clientNum );
}

void idMultiplayerGame::AddPrivatePlayer( int clientId ) {
	privateClientIds.Append( clientId );
}

void idMultiplayerGame::RemovePrivatePlayer( int clientId ) {
	for( int i = 0; i < privateClientIds.Num(); i++ ) {
		if( clientId == privateClientIds[ i ] ) {
			privateClientIds.RemoveIndex( i );
			i--;
		}
	}
}

void idMultiplayerGame::UpdatePrivatePlayerCount( void ) {
	if ( !gameLocal.isServer ) {
		return;
	}

	int numPrivatePlayers = 0;
	for( int i = 0; i < MAX_CLIENTS; i++ ) {
		if( privatePlayers & (1 << i) ) {
			if( gameLocal.entities[ i ] ) {
				numPrivatePlayers++;
			} else {
				privatePlayers &= ~( 1 << i );
			}
		}
	}

	cvarSystem->SetCVarInteger( "si_numPrivatePlayers", numPrivatePlayers );
	cmdSystem->BufferCommandText( CMD_EXEC_NOW, "rescanSI" " " __FILE__ " " __LINESTR__ );
}

/*
================
idMultiplayerGame::LocalizeGametype
dupe of rvServerScanGUI::LocalizeGametype
================
*/
const char *idMultiplayerGame::LocalizeGametype( void ) {
	return "q4f";
}

// <q4f> 

//==========================================================================
// Helper function that replaced p->serverSpectate( false );
// This guy is what checks to see if a new class is needed
//==========================================================================
void idMultiplayerGame::Respawn( idPlayer* player )
{
	// TODO: do we need to check to make sure the current pc is still valid,
	// for some future gameplay types where class limits are dynamic?
	// if current class is disabled, force to spectate w/ changeclass menu... i guess
	
	// check if this player wishes/needs to change classes
	if ( player->currentPC != player->nextPC )
	{
		// this player may just be queued to change classes, so make sure one is available
		if ( tfGame.AllowClassChange( true, player, player->nextPC ) ) {
			// player wants to change class, player can change class, lets DO IT
			player->ChangeClass( player->nextPC );
		}
	}

	player->ServerSpectate( false );
}

//==========================================================================
// Activate class selection gui and sets teamcolour
//==========================================================================
void idMultiplayerGame::ShowQ4FMenu( int tabNum ) {

	mainGui->SetStateInt( "currentTab", tabNum );

	if ( currentMenu == 1 ) {
		return;
	}

	nextMenu = 1;
	gameLocal.sessionCommand = "game_startmenu";
}

//--------------------------------------------------------------------------
// Called when a player is killed
//--------------------------------------------------------------------------
/*void idMultiplayerGame::PlayerDeath_TF( idPlayer* victim, TFDamage &tfDamage ) {
	// don't do PrintMessageEvent
	tfStatManager->EntityDamaged( victim, tfDamage, true );
}*/

//--------------------------------------------------------------------------
// Functions to determine if the given gametype is
// valid for the given map
//--------------------------------------------------------------------------
bool idMultiplayerGame::IsValidGameType( const char* mapName, int gameType ) {
	idStr mapNameStripped = mapName;
	mapNameStripped.StripFileExtension();
	mapNameStripped.StripPath();

	q4fMapInfo newInfo;
	newInfo.LoadMap( mapNameStripped );

	return IsValidGameType( newInfo, gameType );
}

bool idMultiplayerGame::IsValidGameType( q4fMapInfo &mapinfo, int gameType ) {
	return mapinfo.GameTypeDefined( gameType );
}

void idMultiplayerGame::PrintCenterMessage( const char* message ){
	
	gameLocal.Printf( "%s\n", message );
	
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && local->mphud ) {
		local->mphud->SetStateString( "messagetext", message );
		local->mphud->HandleNamedEvent( "addmessageline" );
	}
}

void idMultiplayerGame::ProcessCenterMessage( int clientNum, const char* message ) {
	assert( !gameLocal.isClient );

	idStr msg = message;
	msg.StripTrailing( "\n" );

	// check if the message is cached
	/*int cacheIndex = messageCache[clientNum].FindIndex( msg );

	bool writeStr = false;

	if ( cacheIndex < 0 ) {
		writeStr = true;

		if ( messageCache[clientNum].Num() >= SCRIPT_CACHE_SIZE ) {
			cacheIndex = messageIndex[clientNum] % SCRIPT_CACHE_SIZE;
			messageIndex[clientNum]++;
		}
		else {

			cacheIndex = messageCache[clientNum].Num();
			messageCache[clientNum].Append( msg );
			messageIndex[clientNum] = cacheIndex + 1;
		}
	}*/

	if ( clientNum == gameLocal.localClientNum ) {
		PrintCenterMessage( msg.c_str() );
	}
	else {
		idBitMsg	outMsg;
		byte		msgBuf[ MAX_CENTER_MSG_SIZE ];
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_SCRIPT_MESSAGE );

		/*outMsg.WriteBits( cacheIndex, ASYNC_SCRIPT_CACHE_BITS );
		if ( writeStr ) {
			outMsg.WriteBits( 0, 1 );
			outMsg.WriteString( msg.c_str(), MAX_CENTER_MSG_SIZE );
		}
		else {
			outMsg.WriteBits( 1, 1 );
		}*/
		outMsg.WriteString( msg.c_str(), MAX_CENTER_MSG_SIZE );

		networkSystem->ServerSendReliableMessage( clientNum, outMsg );
	}
}

void idMultiplayerGame::SetMapGuiFloat( int varNum, float val ) {

	if ( varNum >= MAX_MAP_GUI_VARS ) {
		gameLocal.Warning( "SetMapGuiFloat - VarNum %d is out of range. Max is %d", varNum, MAX_MAP_GUI_VARS - 1 );
		return;
	}

	mapGuiVars[ varNum ].type = GUI_VAR_TYPE_FLOAT;
	mapGuiVars[ varNum ].intVal = *(reinterpret_cast<int*>(&val));

	if ( maphud ) {
		maphud->SetStateFloat( va( "ScriptVar_%d", varNum ), val );
	}
	
	if ( !gameLocal.isClient ) {
		idBitMsg	outMsg;
		byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_MAPGUI_FLOAT );

		outMsg.WriteBits( varNum, ASYNC_GUI_VAR_NUM_BITS );
		//outMsg.WriteBits( var.type, ASYNC_GUI_VAR_TYPE_BITS );
		outMsg.WriteFloat( val );

		networkSystem->ServerSendReliableMessage( -1, outMsg );
	}
}
void idMultiplayerGame::SetMapGuiString( int varNum, const char* val ) {

	if ( varNum >= MAX_MAP_GUI_VARS ) {
		gameLocal.Warning( "SetMapGuiString - VarNum %d is out of range. Max is %d", varNum, MAX_MAP_GUI_VARS - 1 );
		return;
	}

	int len = strlen( val );
	if ( len >= MAX_MAP_GUI_DATASIZE ) {
		gameLocal.Warning( "SetMapGuiString - val is too long. Max is %d characters", MAX_MAP_GUI_DATASIZE - 1 );
		return;
	}

	mapGuiVars[ varNum ].type = GUI_VAR_TYPE_STRING;
	mapGuiVars[ varNum ].strVal = val;

	if ( maphud ) {
		maphud->SetStateString( va( "ScriptVar_%d", varNum ), val );
	}
	
	if ( !gameLocal.isClient ) {
		idBitMsg	outMsg;
		byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_MAPGUI_STRING );

		outMsg.WriteBits( varNum, ASYNC_GUI_VAR_NUM_BITS );
		//outMsg.WriteBits( var.type, ASYNC_GUI_VAR_TYPE_BITS );
		outMsg.WriteString( val );

		networkSystem->ServerSendReliableMessage( -1, outMsg );
	}
}

void idMultiplayerGame::SetMapGuiInt( int varNum, int val ) {

	if ( varNum >= MAX_MAP_GUI_VARS ) {
		gameLocal.Warning( "SetMapGuiInt - VarNum %d is out of range. Max is %d", varNum, MAX_MAP_GUI_VARS - 1 );
		return;
	}

	mapGuiVars[ varNum ].type = GUI_VAR_TYPE_INT;
	mapGuiVars[ varNum ].intVal = val;

	if ( maphud ) {
		maphud->SetStateInt( va( "ScriptVar_%d", varNum ), val );
	}
	
	if ( !gameLocal.isClient ) {
		idBitMsg	outMsg;
		byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_MAPGUI_INT );

		outMsg.WriteBits( varNum, ASYNC_GUI_VAR_NUM_BITS );
		//outMsg.WriteBits( var.type, ASYNC_GUI_VAR_TYPE_BITS );
		outMsg.WriteLong( val );

		networkSystem->ServerSendReliableMessage( -1, outMsg );
	}
}

void idMultiplayerGame::SetMapGuiBool( int varNum, bool val ) {

	if ( varNum >= MAX_MAP_GUI_VARS ) {
		gameLocal.Warning( "SetMapGuiBool - VarNum %d is out of range. Max is %d", varNum, MAX_MAP_GUI_VARS - 1 );
		return;
	}

	mapGuiVars[ varNum ].type = GUI_VAR_TYPE_BOOL;
	mapGuiVars[ varNum ].intVal = val ? 1 : 0;

	if ( maphud ) {
		maphud->SetStateBool( va( "ScriptVar_%d", varNum ), val );
	}
	
	if ( !gameLocal.isClient ) {
		idBitMsg	outMsg;
		byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_MAPGUI_BOOL );

		outMsg.WriteBits( varNum, ASYNC_GUI_VAR_NUM_BITS );
		//outMsg.WriteBits( var.type, ASYNC_GUI_VAR_TYPE_BITS );
		outMsg.WriteBits( val ? 1 : 0, 1 );

		networkSystem->ServerSendReliableMessage( -1, outMsg );
	}
}

void idMultiplayerGame::MapGuiNamedEvent( int eventNum ) {

	if ( !gameLocal.isClient ) {
		idBitMsg	outMsg;
		byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_MAPGUI_EVENT );

		outMsg.WriteByte( eventNum );
		networkSystem->ServerSendReliableMessage( -1, outMsg );
	}

	if ( maphud ) {
		maphud->HandleNamedEvent( va( "ScriptEvent_%d", eventNum ) );
	}
}

// </q4f>