#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"

const idEventDef EV_errr( "<explode>", NULL );

const int CLASS_COUNT_BITS = idMath::BitsForInteger( MAX_CLIENTS );

//--------------------------------------------------------------------------
// Constructor
//--------------------------------------------------------------------------
TFGame::TFGame() {
	memset( PlayerClassDefs, 0, sizeof( PlayerClassDefs ) );

	teamCount = 0;

	vec3_one.x = 1.0f;
	vec3_one.y = 1.0f;
	vec3_one.z = 1.0f;

	defsLoaded = false;
}


//--------------------------------------------------------------------------
// Startup, called each map
//--------------------------------------------------------------------------
void TFGame::Startup() {
	Clear();

	ENTDEF def = gameLocal.FindEntityDef( "def_q4f_precache", false );
	assert( def );
	gameLocal.CacheDictionaryMedia( &(def->dict) );

	LoadClassDefs();

	tfStatManager->Init();

	cmdSystem->BufferCommandText( CMD_EXEC_APPEND, "exec autoexec.cfg" );

	if ( !gameLocal.isClient ) {
		tfGame.InitFromMapInfo( gameLocal.mapInfo );	
		//tfStatManager->RoundStart( gameLocal.mapFileNameStripped.c_str() );
	}	

	gameLocal.msgListCollection.Load();

	LoadInitialImpulses( );
}

void TFGame::Clear() {
	teamCount = 0;
	tfStatManager->ShutDown();
}

void TFGame::LoadClassDefs() {
	PlayerClassDefs[CLASS_SCOUT]	= gameLocal.FindEntityDef( "q4f_pc_scout", false );
	PlayerClassDefs[CLASS_SNIPER]	= gameLocal.FindEntityDef( "q4f_pc_sniper", false );
	PlayerClassDefs[CLASS_SOLDIER]	= gameLocal.FindEntityDef( "q4f_pc_soldier", false );
	PlayerClassDefs[CLASS_DEMOMAN]	= gameLocal.FindEntityDef( "q4f_pc_demoman", false );
	PlayerClassDefs[CLASS_MEDIC]	= gameLocal.FindEntityDef( "q4f_pc_medic", false );
	PlayerClassDefs[CLASS_HWGUY]	= gameLocal.FindEntityDef( "q4f_pc_hwguy", false );
	PlayerClassDefs[CLASS_PYRO]		= gameLocal.FindEntityDef( "q4f_pc_pyro", false );
	PlayerClassDefs[CLASS_SPY]		= gameLocal.FindEntityDef( "q4f_pc_spy", false );
	PlayerClassDefs[CLASS_ENGINEER] = gameLocal.FindEntityDef( "q4f_pc_engineer", false );
	PlayerClassDefs[CLASS_CIVILIAN] = gameLocal.FindEntityDef( "q4f_pc_civilian", false );
	defsLoaded = true;
}

void TFGame::LoadInitialImpulses() {
	if ( q4f_impulseBound.GetBool() )
		return;

	for ( int i = 0; i < 10; i++ ) {
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "bind %d _impulse%d", i + 1, i ) );
	}
}

void TFGame::InitFromMapInfo( q4fMapInfo &mapinfo ) { 
	gameLocal.Printf( "----------- TFGame -> Client Initialize Mapinfo -----------\n" );

	int gm = gameLocal.gameType;

	gameLocal.Printf( "Game type #: %d\n", gm );

	teamCount = 0;

	// init team names, colors, and limits
	for ( int i = 0; i < TEAM_COUNT; i++ ) {
		if ( mapinfo.TeamDefined( gm, teamCount ) ) {
			
			for ( int c = 0; c < CLASS_COUNT; c++ ) {
				teams[teamCount].classLimits[c] = mapinfo.GetClassLimit( gm, i, c );
			}

			teams[teamCount].color = mapinfo.GetTeamColor( gm, i );
			teams[teamCount].name = mapinfo.GetTeamName( gm, i );
			teams[teamCount].maxPlayers = mapinfo.GetTeamMaxPlayers( gm, i );
			teams[teamCount].teamNum = i;

			teamCount++;
		}
		else {
			break;
		}
	}

	if ( teamCount <= 0 ) {
		gameLocal.Error( "Could not load any teams for gametype %d.", gm );
	}

	gameLocal.Printf( "----------- TFGame -> Client Initialize Mapinfo END -----------\n" );

	UpdateTeamColors( false );

	// create locations
	gameLocal.InitLocations();
}

//--------------------------------------------------------------------------
// Shutdown
//--------------------------------------------------------------------------
void TFGame::ShutDown() {
	Clear();
}


//--------------------------------------------------------------------------
// Run a frame
//--------------------------------------------------------------------------
void TFGame::Run() {
	
	if ( q4f_useCustomColors.IsModified() || q4f_team0color.IsModified() ||  q4f_team1color.IsModified() ||  q4f_team2color.IsModified() ||  q4f_team3color.IsModified() ) {
		UpdateTeamColors( false );
		q4f_useCustomColors.ClearModified();
		q4f_team0color.ClearModified();
		q4f_team1color.ClearModified();
		q4f_team2color.ClearModified();
		q4f_team3color.ClearModified();
	}

	idCVar* simp = cvarSystem->Find( "r_useSimpleInteraction" );
	assert( simp );

	if ( q4f_lightDetailLevel.IsModified() || q4f_ambientLighting.IsModified() || simp->IsModified()  ) {
		gameLocal.UpdateLights( q4f_lightDetailLevel.GetFloat(), q4f_ambientLighting.GetBool() );
		q4f_lightDetailLevel.ClearModified();
		q4f_ambientLighting.ClearModified();
		simp->ClearModified();
	}
}

void TFGame::SendInitialState( int clientNum ) {
}


//--------------------------------------------------------------------------
// Create the viewable colors
//--------------------------------------------------------------------------
void TFGame::UpdateTeamColors( bool justUpdateEntities, bool justPlayers ) {
	int i, tCount;
	idPlayer* local = gameLocal.GetLocalPlayer();

	if ( !local || local->HasAffliction( AFFL_HALLUCINATE ) )
		return;

	int lTeam = local->team;

	if ( !justUpdateEntities && !justPlayers ) {

		int colorType = q4f_useCustomColors.GetInteger();

		if ( ( colorType == 1 &&  IS_VALID_TEAM( lTeam ) ) || colorType == 2 ) {
			if ( colorType == 1 ) {
				tCount = 0;
				for ( i = 0; i < teamCount; i++ ) {
					if ( i == lTeam ) {
						sscanf( q4f_team0color.GetString(), "%f %f %f", &( teamColors[i].x ), &( teamColors[i].y ), &( teamColors[i].z ) );
					}
					else {
						switch( tCount ) {
							case 0:
								sscanf( q4f_team1color.GetString(), "%f %f %f", &( teamColors[i].x ), &( teamColors[i].y ), &( teamColors[i].z ) );
								break;

							case 1:
								sscanf( q4f_team2color.GetString(), "%f %f %f", &( teamColors[i].x ), &( teamColors[i].y ), &( teamColors[i].z ) );
								break;

							case 2:
								sscanf( q4f_team3color.GetString(), "%f %f %f", &( teamColors[i].x ), &( teamColors[i].y ), &( teamColors[i].z ) );
								break;

							default:
								assert( 0 );
						}
						tCount++;
					}
				}
			}
			else {
				for ( i = 0; i < teamCount; i++ ) {
					switch( i ) {
						case 0:
							sscanf( q4f_team0color.GetString(), "%f %f %f", &( teamColors[0].x ), &( teamColors[0].y ), &( teamColors[0].z ) );
							break;

						case 1:
							sscanf( q4f_team1color.GetString(), "%f %f %f", &( teamColors[1].x ), &( teamColors[1].y ), &( teamColors[1].z ) );
							break;

						case 2:
							sscanf( q4f_team2color.GetString(), "%f %f %f", &( teamColors[2].x ), &( teamColors[2].y ), &( teamColors[2].z ) );
							break;

						case 3:
							sscanf( q4f_team3color.GetString(), "%f %f %f", &( teamColors[3].x ), &( teamColors[3].y ), &( teamColors[3].z ) );
							break;

						default:
							assert( 0 );
					}
				}
			}
		}
		else {
			for ( i = 0; i < teamCount; i++ ) {
				teamColors[i] = teams[i].color;
			}
		}
	}

	if ( justPlayers ) {

		idPlayer* p;

		for ( int i = 0; i < gameLocal.numClients; i++ ) {
			p = GET_PLAYER( i );
			if ( p ) {
				p->UpdateVisibleColor();
			}
		}

		return;
	}

	// update all entities that are teamcolored
	idEntity* ent;
	for ( ent = gameLocal.spawnedEntities.Next(); ent != NULL; ent = ent->spawnNode.Next() ) {
		if ( ent->fl.teamColored ) {
			ent->UpdateVisibleColor();
		}
	}

	// update global parms
	gameLocal.globalShaderParms[0] = teamColors[0].x;
	gameLocal.globalShaderParms[1] = teamColors[0].y;
	gameLocal.globalShaderParms[2] = teamColors[0].z;

	gameLocal.globalShaderParms[3] = teamColors[1].x;
	gameLocal.globalShaderParms[4] = teamColors[1].y;
	gameLocal.globalShaderParms[5] = teamColors[1].z;

	gameLocal.globalShaderParms[6] = teamColors[2].x;
	gameLocal.globalShaderParms[7] = teamColors[2].y;
	gameLocal.globalShaderParms[8] = teamColors[2].z;

	gameLocal.globalShaderParms[9] = teamColors[3].x;
	gameLocal.globalShaderParms[10] = teamColors[3].y;
	gameLocal.globalShaderParms[11] = teamColors[3].z;

	// update locations
	gameLocal.RefreshLocationStrings();

	local->UpdateHudTeamColor();
}

//--------------------------------------------------------------------------
// Clear and allocate team spawns based on the map info settings
//--------------------------------------------------------------------------
/*void TFGame::InitSpawns() {

	for ( int i = 0; i < TEAM_COUNT; i++ ) {
		teams[i].spawnSpots.Clear();
	}

	idPlayerStart* spot;

	// init our team spawn spots
	for ( int i = 0; i < MAX_GENTITIES; i++ ) {
		if ( gameLocal.entities[i] && gameLocal.entities[i]->IsType( idPlayerStart::GetClassType() ) && !gameLocal.entities[i]->spawnArgs.GetBool( "teleporter", "0" ) ) {
			spot = static_cast<idPlayerStart*>(gameLocal.entities[i]);
			if ( IS_VALID_TEAM( spot->team ) ) {
				teams[ spot->team ].spawnSpots.Append( spot );
			}
			else {
				gameLocal.nonTeamSpawnSpots.Append( spot );
			}
		}
	}
}*/

//--------------------------------------------------------------------------
// Returns the class's name
//--------------------------------------------------------------------------
const char* TFGame::GetClassName( int classNum, bool shortName ) {
	if ( IS_VALID_CLASS_NUM( classNum ) ) {
		return TFGame::PlayerClassDefs[ classNum ]->dict.GetString( shortName? "pc_shortname" : "pc_name", "no_name" );
	}

	gameLocal.Warning( "Cannot get class name for invalid class num: %d\n", classNum );

	return "INVALID CLASS NAME";
}


const char* TFGame::GetClassConfig( int classNum ) {
	switch( classNum ) {
		case CLASS_SCOUT:
			return "config/classes/scout.cfg";

		case CLASS_SNIPER:
			return "config/classes/sniper.cfg";

		case CLASS_SOLDIER:
			return "config/classes/soldier.cfg";

		case CLASS_DEMOMAN:
			return "config/classes/demoman.cfg";

		case CLASS_MEDIC:
			return "config/classes/medic.cfg";

		case CLASS_HWGUY:
			return "config/classes/hwguy.cfg";

		case CLASS_PYRO:
			return "config/classes/pyro.cfg";

		case CLASS_SPY:
			return "config/classes/spy.cfg";

		case CLASS_ENGINEER:
			return "config/classes/engineer.cfg";

		case CLASS_CIVILIAN:
			return "config/classes/civilian.cfg";
	}

	return "__empty__.cfg";
}

//--------------------------------------------------------------------------
// Returns the class's def file
//--------------------------------------------------------------------------
const idDeclEntityDef* TFGame::GetClassEntDef( int classNum ) {
	if ( !defsLoaded )
		LoadClassDefs();

	if ( !IS_VALID_CLASS_NUM( classNum ) ) {
		//gameLocal.Error( "TFGame::GetClassEntDef - invalid classnum %d\n", classNum );
		return gameLocal.FindEntityDef( "q4f_pc_base" );
	}
	
	return TFGame::PlayerClassDefs[ classNum ];
}

//--------------------------------------------------------------------------
// Checks class limits ( and maybe other things? ) to see if this class is allowed.
// checkCurrentPCs: set to true if it is to check the player's current PC's; otherwise check next.
//--------------------------------------------------------------------------
bool TFGame::AllowClassChange( bool checkCurrentPCs, idPlayer* player, int classNum, msg_evt_t* msg ) {

	// if the max allowed of this class for this team is -1, always return true

	// here, check if the class is completely disabled ( max allowed = 0 )
	// if so, give disabled message and return false
	
	// here we would check to make sure the player's team isn't full of this class
	// if it is, give full message and return false



	if ( msg != NULL )
		*msg = MSG_CLASSALLOWED;
	return true;
}


//--------------------------------------------------------------------------
// Processes a changeclass request
//--------------------------------------------------------------------------
void TFGame::ChangeClassRequest( int clientNum, int classNum ) {
	assert( IS_VALID_CLASS_NUM( classNum ) );
	assert( !gameLocal.isClient );

	mpGameState_t state = gameLocal.mpGame.GetGameState()->GetMPGameState();
	if ( state == GAMEREVIEW )
		return;

	idPlayer* player = GET_PLAYER( clientNum );

	if ( !player )
		return;

	if ( player->restrictedClass != INVALID_CLASS && classNum == player->restrictedClass ) {
		gameLocal.mpGame.PrintMessageEvent( clientNum, MSG_CLASSDISABLED, classNum );
	}

	// right now we only care if the class is disabled
	msg_evt_t eventMsg;
	AllowClassChange( false, player, classNum, &eventMsg );

	if ( eventMsg != MSG_CLASSDISABLED  ) {
		// the class may just be full... if it is, we want to queue
		// this person to change classes whenever it is available
		player->nextPC = classNum;
		player->wantSpectate = false;
	}

	gameLocal.mpGame.PrintMessageEvent( clientNum, eventMsg, classNum );
}


//--------------------------------------------------------------------------
// Scales the damage depending on the server teamplay settings.
// If mirror damage, the health and armor values will be negated
//--------------------------------------------------------------------------
void TFGame::ScaleTeamDamage( idEntity* p1, idEntity* p2, int* healthloss, int* armorloss ) {

	if ( p1 == p2 || !p1 || !p2 || p2->team < 0 || p1->team < 0 ) {
		return;
	}

	if ( p1->team == p2->team ) {
		*healthloss *= gameLocal.serverInfo.GetFloat( "si_teamHealthDamage" );
		*armorloss  *= gameLocal.serverInfo.GetFloat( "si_teamArmorDamage" );
	}
}

float TFGame::ScaleTeamAffliction( idEntity* p1, idEntity* p2 ) {

	if ( p1 == p2 || !p1 || !p2 || p2->team < 0 || p1->team < 0 ) {
		return 1.0f;
	}

	if ( p1->team == p2->team ) {
		return gameLocal.serverInfo.GetFloat( "si_teamAffliction" );
	}

	return 1.0f;
}


//--------------------------------------------------------------------------
// Write to the snapshot
//--------------------------------------------------------------------------
void TFGame::WriteToSnapshot( idBitMsgDelta &msg ) const {

	tfStatManager->WriteToSnapshot( msg );
}

void TFGame::ReadFromSnapshot( const idBitMsgDelta &msg ) {

	tfStatManager->ReadFromSnapshot( msg );
}

TFTeam* TFGame::GetTeam( const char* teamName ) {
	if ( !teamName || !teamName[0] ) {
		return NULL;
	}

	idStr teamNameStr = teamName;
	teamNameStr.Strip( ' ' );

	for ( int i = 0; i < teamCount; i++ ) {
		if ( !teams[i].name.Icmp( teamNameStr ) ) {
			return &(teams[i]);
		}
	}

	return NULL;
}

TFTeam* TFGame::GetTeam( int teamNum ) {
	if ( !IS_VALID_TEAM( teamNum ) || teamNum >= teamCount ) {
		return NULL;
	}

	return &(teams[teamNum]);
}

int TFGame::GetClassNumFromString( const char* classtring ) {
	idStr className = classtring;
	className.ToLower();

	int classNum = INVALID_CLASS;

	switch ( className[0] ) {
		case '1':
			classNum = CLASS_SCOUT;
			break;

		case '2':
			classNum = CLASS_SNIPER;
			break;

		case '3':
			classNum = CLASS_SOLDIER;
			break;

		case '4':
			classNum = CLASS_DEMOMAN;
			break;

		case '5':
			classNum = CLASS_MEDIC;
			break;

		case '6':
			classNum = CLASS_HWGUY;
			break;

		case '7':
			classNum = CLASS_PYRO;
			break;

		case '8':
			classNum = CLASS_SPY;
			break;

		case '9':
			classNum = CLASS_ENGINEER;
			break;

		case '0':
			classNum = CLASS_CIVILIAN;
			break;

		case 'a':
			classNum = CLASS_SPY; // agent ( for q3f boys )
			break;

		case 'c':
			classNum = CLASS_CIVILIAN; //civilian
			break;

		case 'd':
			classNum = CLASS_DEMOMAN; //demo,demoman
			break;

		case 'e':
			classNum = CLASS_ENGINEER; //engy,engineer
			break;

		case 'f':
			classNum = CLASS_PYRO; //flamer, flametrooper
			break;

		case 'g':
			classNum =CLASS_DEMOMAN; //grenadier
			break;

		case 'h':
			classNum = CLASS_HWGUY; //hwguy,heavyweaponsguy
			break;

		case 'm':
			switch ( className[1] ) {
				case 'i': //mini,minigunner
						classNum = CLASS_HWGUY;
						break;

				default:
				case 'e': //medic
						classNum = CLASS_MEDIC;
						break;
			}
			break;

		case 'p':
			switch ( className[1] ) {		
				case 'a': //paramedic
						classNum = CLASS_MEDIC;
						break;

				default:
				case 'y': //pyro,pyromaniac
						classNum = CLASS_PYRO;
						break;
			}
			break;

		case 'r':
			classNum = CLASS_SCOUT; //recon
				break;

		case 's':
			switch ( className[1] ) {
				case 'c': //scout
						classNum = CLASS_SCOUT;
						break;

				case 'n': //sniper
						classNum = CLASS_SNIPER;
						break;

				case 'p': //spy
						classNum = CLASS_SPY;
						break;

				default:
				case 'o': //soldier
						classNum = CLASS_SOLDIER;
						break;
			}
			break;

		default:
			classNum = INVALID_CLASS;
	}

	return classNum;
}

int TFGame::GetTeamNumFromString( const char* teamstring ) {
	idStr teamStr = teamstring;

	teamStr.Strip( " " );

	// first check if it is numeric
	if ( teamStr.IsNumeric() ) {
		return atoi( teamStr ) - 1;
	}

	// check custom map names
	for ( int i = 0; i < teamCount; i++ ) {
		if ( !teamStr.Icmp( teams[i].name ) ) {
			return i;
		}
	}

	// try default map names
	if ( !teamStr.Icmp( "blue" ) ) {
		return 0;
	}
	else if ( !teamStr.Icmp( "red" ) ) {
		return 1;
	}
	else if ( !teamStr.Icmp( "green" ) ) {
		return 2;
	}
	else if ( !teamStr.Icmp( "orange" ) ) {
		return 3;
	}

	return INVALID_TEAM;
}

void TFGame::DisguiseRequest( int clientNum, disguiseType_t type, int num ) {
	if ( clientNum < 0 )
		return;

	idPlayer* player = GET_PLAYER( clientNum );

	if ( !player || player->spectating )
		return;

	if ( player->currentPC != CLASS_SPY )
		return;

	if ( type == DISGUISE_TEAM && !IS_VALID_TEAM( num ) ) {
		return;
	}

	if ( type == DISGUISE_CLASS && !IS_VALID_CLASS_NUM( num ) ) {
		return;
	}

	if ( gameLocal.isClient ) {
		idBitMsg	outMsg;
		byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_DISGUISE );
		outMsg.WriteBits( type, 2 );
		outMsg.WriteBits( num, ASYNC_CLASS_BITS );
		networkSystem->ClientSendReliableMessage( outMsg );

		return;
	}

	player->StartDisguise( type, num );
}

void TFGame::BuildRequest( const char *entName, int clientNum, const idDict *extraArgs, idVec3* pos, float rotation ) {
	assert( clientNum >= 0 && clientNum < MAX_CLIENTS );
	assert( entName );

	idPlayer* player = GET_PLAYER( clientNum );

	if ( !player ) {
		return;
	}

	if ( player->isBuilding )
		return;

	assert( gameLocal.isServer || player == gameLocal.GetLocalPlayer() );

	ENTDEF entDef = gameLocal.FindEntityDef( entName );

	if ( !entDef )
		return;

	bool skipPreview = entDef->dict.GetBool( "skipPreview", "0" );

	idVec3 myPos;

	if ( !skipPreview ) {

		if ( player == gameLocal.GetLocalPlayer() ) {
			if ( !player->isPreviewing ) {
				if ( !AllowBuild( player, entDef, true ) ) {
					return;
				}

				player->StartPreview( entDef );
				return;
			}
			else {
				if ( player->buildPreview.GetEntDef() != entDef ) {
					player->StopPreview();
					BuildRequest( entName, clientNum, extraArgs );
					return;
				}

				player->buildPreview.CalcPosition();
				if ( !player->buildPreview.AllowBuild() ) {
					// do error sound
					return;
				}

				myPos = player->buildPreview.GetPosition();
				pos = &myPos;
				rotation = player->buildPreview.GetRotation();
			}
		}
	}
	else {
		player->StartPreview( entDef );
		player->buildPreview.CalcPosition();
		if ( !player->buildPreview.AllowBuild() ) {
			// do error sound
			player->StopPreview();
			return;
		}
		myPos = player->buildPreview.GetPosition();
		pos = &myPos;
		rotation = player->viewAngles.yaw;
	}

	player->StopPreview();

	assert( pos );

	// by this point we're already previewing, send the build request
	if ( gameLocal.isClient ) {

		// assume we are building to prevent duplicate requests
		player->isBuilding = true;

		idBitMsg	outMsg;
		byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_BUILD );
		gameLocal.WriteDecl( outMsg, entDef );
		outMsg.WriteFloat( pos->x );
		outMsg.WriteFloat( pos->y );
		outMsg.WriteFloat( pos->z );
		outMsg.WriteFloat( rotation );

		networkSystem->ClientSendReliableMessage( outMsg );

		return;
	}

	if ( !AllowBuild( player, entDef, true ) ) {
		return;
	}

	player->StartPreview( entDef );
	player->buildPreview.Rotate( rotation );
	idAngles ang( 0.0f, rotation, 0.0f );
	idMat3 axis = ang.ToMat3();
	if ( !player->buildPreview.IsValidPos( *pos, axis ) ) {
		gameLocal.mpGame.PrintMessageEvent( clientNum, MSG_BUILD_BADBUILDPOS );
		player->StopPreview();
		return;
	}

	player->StopPreview();
	
	idEntity *ent = NULL;

	// copy over extra args
	idDict finalArgs;

	finalArgs.Copy( entDef->dict );

	if( extraArgs != NULL ) {
        finalArgs.Copy( *extraArgs );
	}

	if( !gameLocal.SpawnEntityDef( finalArgs, &ent ) || !ent || !ent->IsType( BuildableEntity::GetClassType() ) ) {
		gameLocal.Error( "BuildRequest: Error spawning the entity." );
	}

	static_cast<BuildableEntity*>(ent)->StartBuilding( player, *pos, rotation, gameLocal.time );
}

bool TFGame::AllowBuild( idPlayer* player, ENTDEF def, bool sendMsg ) {
	assert( player && def );

	assert( gameLocal.isServer || player == gameLocal.GetLocalPlayer() );

	// already building?
	if ( player->isBuilding ) {
		if ( sendMsg ) {
			gameLocal.mpGame.PrintMessageEvent( player->entityNumber, MSG_BUILD_BADBUILDPOS );
		}
		return false;
	}

	// check required class
	int classNums = def->dict.GetInt( "allow_class_flags", "0" );
	if ( classNums != 0 && ( ( 1 << player->currentPC ) & classNums ) == 0 ) {
		if ( sendMsg ) {
			gameLocal.mpGame.PrintMessageEvent( player->entityNumber, MSG_BUILD_WRONGCLASS, def->Index() );
		}
		return false;
	}

	// check limit
	bool exists = false;

	const char* spawnclass = def->dict.GetString( "spawnclass" );
	if ( !idStr::Icmp( spawnclass, "SentryGun" ) ) {
		if ( player->sentryGun.GetEntity() ) {
			exists = true;
		}
	}
	else if ( !idStr::Icmp( spawnclass, "Dispenser" ) ) {
		if ( player->dispenser.GetEntity() ) {
			exists = true;
		}
	}
	else if ( !idStr::Icmp( spawnclass, "Detpak" ) ) {
		if ( player->detpack.GetEntity() ) {
			exists = true;
		}
	}
	
	if ( exists ) {
		if ( sendMsg ) {
			gameLocal.mpGame.PrintMessageEvent( player->entityNumber, MSG_BUILD_BUILDLIMIT, def->Index() );
		}
		return false;
	}

	// check enough ammo
	int numAmmoRequired = def->dict.GetInt( "ammo_required", "0" );
	if ( numAmmoRequired > 0 ) {
		int ammoType = player->inventory.AmmoIndexForAmmoClass( def->dict.GetString( "ammo_type", "ammo_none" ) );

		if ( player->inventory.HasAmmo( ammoType, numAmmoRequired ) == 0 ) {
			if ( sendMsg ) {
				gameLocal.mpGame.PrintMessageEvent( player->entityNumber, MSG_BUILD_NOTENOUGHAMMO, def->Index() );
			}
			return false;
		}
	}

	return true;
}

const void TFGame::ExtractChatMessage( const char* txt, idStr &outMsg, int &outSoundShaderIndex ) {

	outSoundShaderIndex = -1;

	// get rid of whitespace at start
	while( txt[0] <= ' ' && txt[0] != '\0' )
		txt++;
	
	// check if its a sound shader
	if ( !txt || txt[0] != '!' ) {
		outMsg = txt;
		return;
	}

	// move past the '!'
	txt++;

	// get rid of white space after the '!'
	while( txt[0] <= ' ' && txt[0] != '\0' )
		txt++;

	// make sure not end of string
	if ( !txt || !txt[0] ) {
		outMsg = txt;
		return;
	}

	// read in the sound shader
	char sndBuf[16];
	int count = 0;

	while ( txt[0] > ' ' && count < 15 ) {
		sndBuf[count] = txt[0];
		txt++;
		count++;
	}
	sndBuf[count] = 0;

	// get rid of white space after the sound
	while( txt[0] <= ' ' && txt[0] != '\0' )
		txt++;

	// set the actual text
	outMsg = txt;

	// find the soud shader

	const idDict* baseDict = gameLocal.FindEntityDefDict( "q4f_pc_base", false );

	if ( !baseDict )
		return;

	const char* soundKey = va( "snd_vo_%s", sndBuf );
	const char* sndName = baseDict->GetString( soundKey, "" );

	if ( !sndName || !sndName[0] ) {
		gameLocal.Warning( "Could not find sound file '%s'.", soundKey );
		return;
	}

	const idSoundShader* shader = declManager->FindSound( sndName, false );

	if ( !shader ) {
		gameLocal.Warning( "Could not find sound shader '%s'.", sndName );
		return;
	}

	outSoundShaderIndex = shader->Index();
}





// damage class
TFDamage::TFDamage() {
	dir = vec3_zero;
	location = -1;
	damageDef = NULL;
	damage = 0;
	doAffliction = true;
	countForAccuracy = true;
	damageScale = 1.0f;
	isValid = false;
	affl = AFFL_NONE;
}

void TFDamage::Create( const AttackerInfo &attInfo, const char* damageDefName, float scaleDamage ) {
	damageDef = NULL;
	if ( damageDefName && damageDefName[0] ) {
		damageDef = gameLocal.FindEntityDef( damageDefName, false );
	}
	else {
		gameLocal.Error( "TFDamage: damageDefName is empty" );
	}

	this->damageScale = scaleDamage;

	SetAttacker( attInfo );

	Init();
}

void TFDamage::Create( const AttackerInfo &attInfo, const idDeclEntityDef* damageDef, float scaleDamage) {

	this->damageDef = damageDef;
	this->damageScale = scaleDamage;

	SetAttacker( attInfo );

	Init();
}

void TFDamage::Init() {
 	if ( damageDef == NULL ) {
		gameLocal.Error( "TFDamage: no damage def specified or could not be found." );
	}

	damage = damageDef->dict.GetInt( "damage", "0" );

	affl = AFFL_NONE;

	const char* afflStr = NULL;
	if ( damageDef->dict.GetString( "affliction", "", &afflStr ) && afflStr && afflStr[0] ) {

		if ( !idStr::Icmp( afflStr, "conc" ) ) {
			affl = AFFL_CONC;
		}
		else if ( !idStr::Icmp( afflStr, "fire" ) ) {
			affl = AFFL_FIRE;
		}
		else if ( !idStr::Icmp( afflStr, "flash" ) ) {
			affl = AFFL_FLASH;
		}
		else if ( !idStr::Icmp( afflStr, "infection" ) ) {
			affl = AFFL_INFECTION;
		}
		else if ( !idStr::Icmp( afflStr, "hallucinate" ) ) {
			affl = AFFL_HALLUCINATE;
		}
		else if ( !idStr::Icmp( afflStr, "tranquilize" ) ) {
			affl = AFFL_TRANQ;
		}
	}

	isValid = true;
}






// teams class
TFTeam::TFTeam() {
	name = "";
	memset( classLimits, 0, sizeof(classLimits) );
	teamNum = -1;
}

int TFTeam::GetNumPlayers( int classCounts[CLASS_COUNT] ) {
	int totalCount = 0;

	if ( classCounts )
		memset( classCounts, 0, sizeof( int ) * CLASS_COUNT );

	idPlayer* p;
	for ( int i = 0; i < gameLocal.numClients; i++ ) {
		p = GET_PLAYER( i );
		if ( p && p->team == teamNum ) {
			if ( classCounts && IS_VALID_CLASS_NUM( p->currentPC ) )
				classCounts[ p->currentPC ]++;

			totalCount++;
		}
	}

	return totalCount;
}

bool TFTeam::IsFull() {
	int classCounts[CLASS_COUNT];
	
	int numPlayers = GetNumPlayers( classCounts );

	if ( maxPlayers >= 0 && numPlayers >= maxPlayers )
		return true;

	int numClassesAvail = CLASS_COUNT;

	for ( int i = 0; i < CLASS_COUNT; i++ ) {
		if ( classLimits[i] >= 0 && classCounts[i] >= classLimits[i] )
			numClassesAvail--;
	}

	return numClassesAvail <= 0;
}






idPlayer* AttackerInfo::GetPlayer( void ) const {
	idEntity* att = attacker.GetEntity();
	if ( att && att->IsType( idPlayer::GetClassType() ) ) {
		return static_cast<idPlayer*>( att );
	}

	return NULL;
}

void AttackerInfo::Create( idEntity* att ) {
	attacker = att;

	if ( att && att->IsType( idPlayer::GetClassType() ) ) {
		attackerTeam = static_cast<idPlayer*>(att)->team;
		attackerClass = static_cast<idPlayer*>(att)->currentPC;
	}
	else {
		attackerTeam = TEAM_COUNT;
		attackerClass = INVALID_CLASS;
	}
}
