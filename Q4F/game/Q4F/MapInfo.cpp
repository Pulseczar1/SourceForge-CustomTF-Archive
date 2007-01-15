#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"


//--------------------------------------------------------------------------
// Initialize our smack
//--------------------------------------------------------------------------
q4fMapInfo::q4fMapInfo() {
}


//--------------------------------------------------------------------------
// Load a mapinfo from the specified map name. If the mapinfo doesn't exist,
// _default.mapinfo is loaded instead.
//--------------------------------------------------------------------------
void q4fMapInfo::LoadMap( const char* mapname, bool loadDefault ) {

	idLexer mainLex;

	if ( !loadDefault ) {
		if ( !mapname || !mapname[0] ) {
			LexError( "mapname is null or empty." );
			return;
		}

		mapInfo.mapName = mapname;

		const char* mapfile = va( va( "mapinfo/%s.cfg", mapname ) );

		if ( !mainLex.LoadFile( mapfile ) ) {
			gameLocal.Warning( "Mapinfo: could not load mapinfo file '%s'. Loading default.\n", mapfile );
			LoadMap( mapname, true );
			return;
		}
	}
	else {		// load default
		if ( !mapname || !mapname[0] ) {
			mapInfo.mapName = "UNNAMED_MAP";
		}
		else {
			mapInfo.mapName = mapname;
		}

		if ( !mainLex.LoadFile( "mapinfo/_defaultmap.cfg" ) ) {
			LexError( "could not load default mapinfo file." );
			return;
		}
	}

	if ( !mainLex.IsLoaded() ) {
		LexError( "could not load lexer." );
		return;
	}

	Clear();

	ParseMapInfo( mainLex, mapInfo );
	mainLex.FreeSource();
}

void q4fMapInfo::Clear() {
	mapInfo.gameTypeCount = 0;
	mapInfo.longName.Clear();
	mapInfo.mapName.Clear();
	mapInfo.shortName.Clear();

	for ( int g = 0; g < MAX_GAMETYPES; g++ ) {
		mapInfo.gameTypes[g].longName.Clear();
		mapInfo.gameTypes[g].shortName.Clear();
		mapInfo.gameTypes[g].description.Clear();
		mapInfo.gameTypes[g].parsed = false;
		mapInfo.gameTypes[g].teamCount = 0;
		mapInfo.gameTypes[g].hud.Clear();
		mapInfo.gameTypes[g].hudRotate = 0.0f;
		mapInfo.gameTypes[g].radarBG.Clear();
		
		for ( int t = 0; t < TEAM_COUNT; t++ ) {
			memset( mapInfo.gameTypes[g].teams[t].classLimits, -1, sizeof( mapInfo.gameTypes[g].teams[t].classLimits ) );
			mapInfo.gameTypes[g].teams[t].parsed = false;
			mapInfo.gameTypes[g].teams[t].color = vec3_zero;
			mapInfo.gameTypes[g].teams[t].maxPlayers = 0;
			mapInfo.gameTypes[g].teams[t].name.Clear();
		}
	}

	isValid =  false;
}

void q4fMapInfo::WriteInfo( int gameType, idBitMsg &msg ) {
	assert( GameTypeDefined( gameType ) );

	//msg.WriteString( mapInfo.longName.c_str() );
	//msg.WriteString( mapInfo.shortName.c_str() );

	gametype_t* gm = GetGameType( gameType );

	assert( gameType > 0 );

	msg.WriteByte( (gameType-1) );

	//msg.WriteString( gm->longName.c_str() );
	//msg.WriteString( gm->shortName.c_str() );
	//msg.WriteString( gm->description.c_str() );

	assert( gm->teamCount >= 0 );

	msg.WriteByte( gm->teamCount );

	for ( int j = 0; j < gm->teamCount; j++ ) {
		msg.WriteFloat( gm->teams[j].color.x );
		msg.WriteFloat( gm->teams[j].color.y );
		msg.WriteFloat( gm->teams[j].color.z );
		msg.WriteString( gm->teams[j].name.c_str() );
		msg.WriteShort( gm->teams[j].maxPlayers );
		
		for ( int k = 0; k < CLASS_COUNT; k++ ) {
			msg.WriteShort( gm->teams[j].classLimits[k] );
		}
	}
}

void q4fMapInfo::ReadInfo( const idBitMsg &msg ) {

	gameLocal.Printf( "MapInfo -> Begin Reading From Server\n" );

	isValid = true;

	char msgBuf[1024];

	//msg.ReadString( msgBuf, 1024 );
	//mapInfo.longName = msgBuf;

	//gameLocal.Printf( "MapInfo:: longName = %s\n", mapInfo.longName );

	//msg.ReadString( msgBuf, 1024 );
	//mapInfo.shortName = msgBuf;

	//gameLocal.Printf( "MapInfo:: shortName = %s\n", mapInfo.shortName );

	mapInfo.gameTypeCount = 999;

	int gm = msg.ReadByte();

	gameLocal.Printf( "MapInfo:: gameindex = %d\n", gm );

	//msg.ReadString( msgBuf, 1024 );
	//mapInfo.gameTypes[gm].longName = msgBuf;

	//gameLocal.Printf( "MapInfo:: gameindex longName = %s\n", msgBuf );

	//msg.ReadString( msgBuf, 1024 );
	//mapInfo.gameTypes[gm].shortName = msgBuf;

	//gameLocal.Printf( "MapInfo:: gameindex shortName = %s\n", msgBuf );

	//msg.ReadString( msgBuf, 1024 );
	//mapInfo.gameTypes[gm].description = msgBuf;

	//gameLocal.Printf( "MapInfo:: gameindex description = %s\n", msgBuf );

	mapInfo.gameTypes[gm].teamCount = msg.ReadByte();

	gameLocal.Printf( "MapInfo:: gameindex teamcount = %d\n", mapInfo.gameTypes[gm].teamCount );

	for ( int j = 0; j < mapInfo.gameTypes[gm].teamCount; j++ ) {
		mapInfo.gameTypes[gm].teams[j].color.x = msg.ReadFloat();
		mapInfo.gameTypes[gm].teams[j].color.y = msg.ReadFloat();
		mapInfo.gameTypes[gm].teams[j].color.z = msg.ReadFloat();

		gameLocal.Printf( "MapInfo:: team %d color = %g %g %g\n", j , mapInfo.gameTypes[gm].teams[j].color.x, mapInfo.gameTypes[gm].teams[j].color.y, mapInfo.gameTypes[gm].teams[j].color.z);

		msg.ReadString( msgBuf, 1024 );
		mapInfo.gameTypes[gm].teams[j].name = msgBuf;

		gameLocal.Printf( "MapInfo:: team %d name = %s\n", j, msgBuf );

		mapInfo.gameTypes[gm].teams[j].maxPlayers = msg.ReadShort();

		gameLocal.Printf( "MapInfo:: team %d maxplayers = %d\n", j, mapInfo.gameTypes[gm].teams[j].maxPlayers );

		for ( int k = 0; k < CLASS_COUNT; k++ ) {
			mapInfo.gameTypes[gm].teams[j].classLimits[k] = msg.ReadShort();
			gameLocal.Printf( "MapInfo:: team %d classlimit %d = %d\n", j, k, mapInfo.gameTypes[gm].teams[j].classLimits[k] );
		}
	}
}

// getters

bool q4fMapInfo::GameTypeDefined( int gameType ) {
	if ( !isValid ) {
		gameLocal.Error( "q4fMapInfo::GameTypeDefined - map info not loaded yet." );
	}

	gameType--;

	if ( gameType >= 0 && gameType < mapInfo.gameTypeCount ) {
		return true;
	}

	return false;
}

const char* q4fMapInfo::GetMapLongName() {
	return mapInfo.longName;
}

const char* q4fMapInfo::GetMapShortName() {
	return mapInfo.shortName;
}

const char* q4fMapInfo::GetGameTypeDesc( int num ) {
	if ( GameTypeDefined( num ) ) {
		return mapInfo.gameTypes[num-1].description.c_str();
	}

	return NULL;
}

gametype_t* q4fMapInfo::GetGameType( int num ) {
	if ( GameTypeDefined( num ) ) {
		return &(mapInfo.gameTypes[num-1]);
	}

	return NULL;
}

const char* q4fMapInfo::GetGameTypeHud( int gameType ) {
	if ( GameTypeDefined( gameType ) ) {
		return mapInfo.gameTypes[gameType-1].hud;
	}

	return "guis/maps/_defaultmap.gui";
}

float q4fMapInfo::GetGameTypeRadarRotation( int gameType ) {
	if ( GameTypeDefined( gameType ) ) {
		return mapInfo.gameTypes[gameType-1].hudRotate;
	}

	return 0.0f;
}

const char* q4fMapInfo::GetGameTypeRadarBG( int gameType ) {
	if ( GameTypeDefined( gameType ) ) {
		return mapInfo.gameTypes[gameType-1].radarBG;
	}

	return "";
}

const char* q4fMapInfo::GetGameTypeLongName( int gameType ) {
	if ( !isValid || !GameTypeDefined( gameType ) ) {
		return "Advanced CTF";
	}

	return mapInfo.gameTypes[gameType-1].longName;
}

const char* q4fMapInfo::GetGameTypeShortName( int gameType ) {
	if ( !isValid || !GameTypeDefined( gameType ) ) {
		return "ACTF";
	}

	return mapInfo.gameTypes[gameType-1].shortName;
}

bool q4fMapInfo::TeamDefined( int gameType, int teamNum ) {
	if ( !isValid || !GameTypeDefined( gameType ) ) {
		return false;
	}

	if ( teamNum >= 0 && teamNum < mapInfo.gameTypes[gameType-1].teamCount ) {
		return true;
	}

	return false;
}

const char* q4fMapInfo::GetTeamName( int gameType, int teamNum ) {
	if ( !TeamDefined( gameType, teamNum ) ) {
		return "NoName";
	}

	return mapInfo.gameTypes[gameType-1].teams[teamNum].name;
}

int q4fMapInfo::GetTeamMaxPlayers( int gameType, int teamNum ) {
	if ( !TeamDefined( gameType, teamNum ) ) {
		return -1;
	}

	return mapInfo.gameTypes[gameType-1].teams[teamNum].maxPlayers;
}

idVec3 q4fMapInfo::GetTeamColor( int gameType, int teamNum ) {
	if ( !TeamDefined( gameType, teamNum ) ) {
		return vec3_origin;
	}

	return mapInfo.gameTypes[gameType-1].teams[teamNum].color;
}

int q4fMapInfo::GetClassLimit( int gameType, int teamNum, int classNum ) {
	if ( !GameTypeDefined( gameType ) || !TeamDefined( gameType, teamNum ) ) {
		return -1;
	}

	return mapInfo.gameTypes[gameType-1].teams[teamNum].classLimits[classNum];
}

// parser stuff


//--------------------------------------------------------------------------
// Parse a map info file
//--------------------------------------------------------------------------
void q4fMapInfo::ParseMapInfo( idLexer &lexer, mapinfo_t &mapinfo ) {
	if ( !lexer.IsLoaded() ) {
		gameLocal.Error( "Mapinfo: ParseMapInfo: lexer is not loaded." );
		return;
	}

	idToken tok;

	// make sure it's a mapinfo file
	if ( !lexer.ReadToken( &tok ) || GetNameType( tok ) != MINAMETYPE_MAPINFO ){
		LexError( "file does not start with 'mapinfo'.", &lexer );
		return;
	}

	if ( !lexer.ExpectTokenString( "{" ) ) {
		LexError( "Expected '{'" );
		return;
	}

	miNameType_t miType;

	int typeNum;

	while ( lexer.ReadToken( &tok ) ) {

		if ( !idStr::Icmp( tok, "}" ) ) {
			break;
		}

		miType = GetNameType( tok );

		if ( miType == MINAMETYPE_NONE ) {
			LexError( va( "Unknown token %s", tok.c_str() ) );
			return;
		}

		switch ( miType ) {
			case MINAMETYPE_LONGNAME:
				mapinfo.longName = ReadString( lexer );
				break;

			case MINAMETYPE_SHORTNAME:
				mapinfo.shortName = ReadString( lexer );
				break;

			case MINAMETYPE_GAMETYPE:
				typeNum = ReadInt( lexer );
				if ( !IsValidGameTypeNum( typeNum ) ) {
					LexError( va( "gameindex # '%d' is outside valid range.", typeNum ), &lexer );
					return;
				}

				ParseGameType( lexer, mapinfo.gameTypes[ typeNum - 1 ] );
				break;

			default:
				LexError( va( "Unexpected token '%s'. Expected 'inherit', 'longname', 'shortname', or 'gameindex'.", tok.c_str() ) );
				return;
		}
	}

	isValid = ValidateInfo( mapinfo );

	if ( !isValid ) {
		LexError( va( "Mapinfo file '%s' is invalid.", lexer.GetFileName() ) );
	}
}


//--------------------------------------------------------------------------
// Parse gametype information
//--------------------------------------------------------------------------
void q4fMapInfo::ParseGameType( idLexer &lexer, gametype_t &gametype ) {

	if ( !lexer.ExpectTokenString( "{" ) ) {
		LexError( "Expected '{'" );
		return;
	}

	idToken			tok;
	miNameType_t	miType;
	int				teamNum;

	while ( lexer.ReadToken( &tok ) ) {

		if ( !idStr::Icmp( tok, "}" ) ) {
			break;
		}

		miType = GetNameType( tok );

		if ( miType == MINAMETYPE_NONE ) {
			LexError( va( "Unknown token %s", tok.c_str() ) );
			return;
		}

		switch ( miType ) {

			case MINAMETYPE_LONGNAME:
				gametype.longName = ReadString( lexer);
				break;

			case MINAMETYPE_SHORTNAME:
				gametype.shortName = ReadString( lexer);
				break;

			case MINAMETYPE_DESCRIPTION:
				gametype.description = ReadString( lexer);
				break;

			case MINAMETYPE_HUD:
				gametype.hud= ReadString( lexer);
				break;

			case MINAMETYPE_RADARROTATE:
				gametype.hudRotate = lexer.ParseFloat();
				break;

			case MINAMETYPE_RADAR:
				gametype.radarBG = ReadString( lexer);
				break;

			case MINAMETYPE_TEAM:
				teamNum = ReadInt( lexer );
				if ( !IsValidTeamNum( teamNum ) ) {
					LexError( va( "team # '%d' is outside valid range.", teamNum ), &lexer );
					return;
				}

				ParseTeam( lexer, gametype.teams[ teamNum - 1 ] );
				break;

			default:
				LexError( va( "Unexpected token '%s'. Expected 'longname', 'shortname', 'description', 'hud', 'radarRotate', 'radar', or 'team'.", tok.c_str() ) );
				return;
		}
	}

	gametype.parsed = true;
}


//--------------------------------------------------------------------------
// parse team information
//--------------------------------------------------------------------------
void q4fMapInfo::ParseTeam( idLexer &lexer, teaminfo_t &team ) {
	if ( !lexer.ExpectTokenString( "{" ) ) {
		LexError( "Expected '{'" );
		return;
	}

	idToken			tok;
	miNameType_t	miType;

	while ( lexer.ReadToken( &tok ) ) {

		if ( !idStr::Icmp( tok, "}" ) ) {
			break;
		}

		miType = GetNameType( tok );

		if ( miType == MINAMETYPE_NONE ) {
			LexError( va( "Unknown token %s", tok.c_str() ) );
			return;
		}

		switch ( miType ) {
			case MINAMETYPE_NAME:
				team.name = ReadString( lexer );
				break;

			case MINAMETYPE_COLOR:
				team.color = ReadVec( lexer );
				break;

			case MINAMETYPE_MAX_PLAYERS:
				team.maxPlayers = ReadInt( lexer );
				break;

			case MINAMETYPE_MAX_SCOUT:
				team.classLimits[ CLASS_SCOUT ] = ReadInt( lexer );
				break;

			case MINAMETYPE_MAX_SNIPER:
				team.classLimits[ CLASS_SNIPER ] = ReadInt( lexer );
				break;

			case MINAMETYPE_MAX_SOLDIER:
				team.classLimits[ CLASS_SOLDIER ] = ReadInt( lexer );
				break;

			case MINAMETYPE_MAX_DEMOMAN:
				team.classLimits[ CLASS_DEMOMAN ] = ReadInt( lexer );
				break;

			case MINAMETYPE_MAX_MEDIC:
				team.classLimits[ CLASS_MEDIC ] = ReadInt( lexer );
				break;

			case MINAMETYPE_MAX_HWGUY:
				team.classLimits[ CLASS_HWGUY ] = ReadInt( lexer );
				break;

			case MINAMETYPE_MAX_PYRO:
				team.classLimits[ CLASS_PYRO ] = ReadInt( lexer );
				break;

			case MINAMETYPE_MAX_SPY:
				team.classLimits[ CLASS_SPY ] = ReadInt( lexer );
				break;

			case MINAMETYPE_MAX_ENGINEER:
				team.classLimits[ CLASS_ENGINEER ] = ReadInt( lexer );
				break;

			case MINAMETYPE_MAX_CIVILIAN:
				team.classLimits[ CLASS_CIVILIAN ] = ReadInt( lexer );
				break;

			default:
				LexError( va( "Unexpected token '%s'. Expected 'name', 'color', or 'max_*'.", tok.c_str() ) );
				return;
		}
	}

	team.parsed = true;
}


//--------------------------------------------------------------------------
// returns true if the gametype num is in the valid mapinfo range
//--------------------------------------------------------------------------
bool q4fMapInfo::IsValidGameTypeNum( int num ) {
	if ( num >= 1 && num <= MAX_GAMETYPES ) {
		return true;
	}

	return false;
}


//--------------------------------------------------------------------------
// returns true if team num is in the valid team range
//--------------------------------------------------------------------------
bool q4fMapInfo::IsValidTeamNum( int num ) {
	if ( num >= 1 && num <= TEAM_COUNT ) {
		return true;
	}

	return false;
}


//--------------------------------------------------------------------------
// Read a string value
//--------------------------------------------------------------------------
idStr q4fMapInfo::ReadString( idLexer &lex ) {
	idToken tok;

	if ( !lex.ReadToken( &tok ) ) {
		LexError( "Expected string value.", &lex );
		return "";
	}

	return tok;
}


//--------------------------------------------------------------------------
// read an integer value
//--------------------------------------------------------------------------
int q4fMapInfo::ReadInt( idLexer &lex ) {
	return lex.ParseInt();
}


//--------------------------------------------------------------------------
// read a vec3
//--------------------------------------------------------------------------
idVec3 q4fMapInfo::ReadVec( idLexer &lex ) {
	float vec[3];

	if ( !lex.Parse1DMatrix( 3, vec ) ) {
		LexError( "Token is not a vector - ( # # # ): %s", &lex );
	}

	return idVec3( vec[0], vec[1], vec[2] );
}

//--------------------------------------------------------------------------
// Run various checks to make sure the mapinfo is valid, or to fill in default values
//--------------------------------------------------------------------------
bool q4fMapInfo::ValidateInfo( mapinfo_t &mapinfo ) {

	if ( mapinfo.shortName == "" ) {
		mapinfo.shortName = mapinfo.mapName;
	}

	if ( mapinfo.longName == "" ) {
		mapinfo.longName = mapinfo.shortName;
	}

	mapinfo.gameTypeCount = 0;

	for ( int g = 0; g < MAX_GAMETYPES; g++ ) {
		
		if ( IsValidGameType( mapinfo.gameTypes[ g ] ) ) {
			if ( mapinfo.gameTypes[ g ].teamCount <= 0 ) {
				LexError( va( "Gametype %d has no valid teams.", g+1 ) );
				return false;
			}
			else if ( g != mapinfo.gameTypeCount ) {
				LexError( va( "Unexpected gametype %d. A gametype definition has been skipped.", g+1 ) );
				return false;
			}

			mapinfo.gameTypeCount++;
		}
	}

	if ( mapinfo.gameTypeCount <= 0 ) {
		LexError( va( "map '%s' has no valid gametypes defined.", mapinfo.mapName.c_str() ) );
		return false;
	}

	return true;
}



//--------------------------------------------------------------------------
// validats a gametype
//--------------------------------------------------------------------------
bool q4fMapInfo::IsValidGameType( gametype_t &gametype ) {

	bool checkingTeams = true;

	gametype.teamCount = 0;

	if ( !gametype.parsed ) {
		return false;
	}

	for ( int t = 0; t < TEAM_COUNT; t++ ) {
		if ( gametype.teams[t].parsed ) {
			if ( !checkingTeams ) {
				LexError( va( "Unexpected team %d. A team definition has been skipped.", t+1 ) );
				return false;
			}
			else if ( gametype.teams[t].maxPlayers == 0 ) {
				LexError( va( "Team %d has maxplayers set to zero.", t+1 ) );
				return false;
			}
			else if ( gametype.teams[t].name == "" ) {
				LexError( va( "Team %d has no name.", t+1 ) );
				return false;
			}
			else {
				if ( gametype.teams[t].name.IsNumeric() ) {
					gametype.teams[t].name.Append( "_" );
				}
				else if ( !gametype.teams[t].name.Icmp( "all" ) ) {
					gametype.teams[t].name.Append( "_" );
				}
				else if ( !gametype.teams[t].name.Icmp( "auto" ) ) {
					gametype.teams[t].name.Append( "_" );
				}

				for ( int k = 0; k < t; k++ ) {
					if ( !gametype.teams[k].name.Icmp( gametype.teams[t].name ) ) {
						LexError( va( "Duplicate team names: '%s'", gametype.teams[t].name.c_str() ) );
						return false;
					}
				}

				// make sure this team has atleast some classlimits
				bool hasClass = false;
				for ( int c = 0; c < CLASS_COUNT; c++ ) {
					if ( gametype.teams[t].classLimits[c] != 0 ) {
						hasClass = true;
						break;
					}
				}

				if ( !hasClass ) {
					LexError( va( "Team %s does not have any classes enabled.", gametype.teams[t].name.c_str() ) );
					return false;
				}

				gametype.teamCount++;
			}
		}
		else {
			checkingTeams = false;
		}
	}

	return true;
}

//--------------------------------------------------------------------------
// Return the type that the name is
//--------------------------------------------------------------------------
miNameType_t q4fMapInfo::GetNameType( idStr type ) {

	if ( !type.Cmp( "mapinfo" ) ) {
		return MINAMETYPE_MAPINFO;
	}
	else if ( !type.Cmp( "description" ) ) {
		return MINAMETYPE_DESCRIPTION;
	}
	else if ( !type.Cmp( "longname" ) ) {
		return MINAMETYPE_LONGNAME;
	}
	else if ( !type.Cmp( "shortname" ) ) {
		return MINAMETYPE_SHORTNAME;
	}
	else if ( !type.Cmp( "gameindex" ) ) {
		return MINAMETYPE_GAMETYPE;
	}
	else if ( !type.Cmp( "team" ) ) {
		return MINAMETYPE_TEAM;
	}
	else if ( !type.Cmp( "name" ) ) {
		return MINAMETYPE_NAME;
	}
	else if ( !type.Cmp( "color" ) ) {
		return MINAMETYPE_COLOR;
	}
	else if ( !type.Cmp( "hud" ) ) {
		return MINAMETYPE_HUD;
	}
	else if ( !type.Cmp( "radar" ) ) {
		return MINAMETYPE_RADAR;
	}
	else if ( !type.Cmp( "radarRotate" ) ) {
		return MINAMETYPE_RADARROTATE;
	}
	else if ( !type.CmpPrefix( "max_" ) ) {
		if ( !type.Cmp( "max_scout" ) ) {
			return MINAMETYPE_MAX_SCOUT;
		}
		else if ( !type.Cmp( "max_sniper" ) ) {
			return MINAMETYPE_MAX_SNIPER;
		}
		else if ( !type.Cmp( "max_soldier" ) ) {
			return MINAMETYPE_MAX_SOLDIER;
		}
		else if ( !type.Cmp( "max_demoman" ) ) {
			return MINAMETYPE_MAX_SOLDIER;
		}
		else if ( !type.Cmp( "max_medic" ) ) {
			return MINAMETYPE_MAX_MEDIC;
		}
		else if ( !type.Cmp( "max_hwguy" ) ) {
			return MINAMETYPE_MAX_HWGUY;
		}
		else if ( !type.Cmp( "max_pyro" ) ) {
			return MINAMETYPE_MAX_PYRO;
		}
		else if ( !type.Cmp( "max_spy" ) ) {
			return MINAMETYPE_MAX_SPY;
		}
		else if ( !type.Cmp( "max_engineer" ) ) {
			return MINAMETYPE_MAX_ENGINEER;
		}
		else if ( !type.Cmp( "max_civilian" ) ) {
			return MINAMETYPE_MAX_CIVILIAN;
		}
		else if ( !type.Cmp( "max_players" ) ) {
			return MINAMETYPE_MAX_PLAYERS;
		}
	}

	return MINAMETYPE_NONE;
}

//--------------------------------------------------------------------------
// Throw an error to the game
//--------------------------------------------------------------------------
void q4fMapInfo::LexError( const char* error, idLexer* lex ) {
	if ( lex ) {
		lex->FreeSource();
		gameLocal.Error( va( "MapInfo: %s :: file %s line %d\n", error, lex->GetFileName(), lex->GetLineNum() ) );
	}
	else {
		gameLocal.Error( va( "%s\n", error ) );
	}
}
