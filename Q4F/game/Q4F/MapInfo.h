#ifndef __MAPINFO_H__
#define	__MAPINFO_H__

/*
===============================================================================

	Map information files

===============================================================================
*/

typedef struct teaminfo_s {
	idStr				name;
	int					maxPlayers;
	idVec3				color;

	bool				parsed;

	int					classLimits[CLASS_COUNT];
} teaminfo_t;

typedef struct gametype_s {
	idStr				shortName;
	idStr				longName;
	idStr				description;

	idStr				hud;
	float				hudRotate;
	idStr				radarBG;

	int					teamCount;

	bool				parsed;

	teaminfo_t			teams[TEAM_COUNT];
	
} gametype_t;


#define MAX_GAMETYPES 4

typedef struct mapinfo_s {
	idStr					longName;
	idStr					shortName;
	idStr					mapName;

	int						gameTypeCount;

	gametype_t				gameTypes[MAX_GAMETYPES];

} mapinfo_t;



typedef enum miNameType_s {
	MINAMETYPE_NONE,
	MINAMETYPE_DESCRIPTION,
	MINAMETYPE_MAPINFO,
	MINAMETYPE_LONGNAME,
	MINAMETYPE_SHORTNAME,
	MINAMETYPE_GAMETYPE,
	MINAMETYPE_TEAM,
	MINAMETYPE_NAME,
	MINAMETYPE_COLOR,
	MINAMETYPE_MAX_SCOUT,
	MINAMETYPE_MAX_SNIPER,
	MINAMETYPE_MAX_SOLDIER,
	MINAMETYPE_MAX_DEMOMAN,
	MINAMETYPE_MAX_MEDIC,
	MINAMETYPE_MAX_HWGUY,
	MINAMETYPE_MAX_PYRO,
	MINAMETYPE_MAX_SPY,
	MINAMETYPE_MAX_ENGINEER,
	MINAMETYPE_MAX_CIVILIAN,
	MINAMETYPE_MAX_PLAYERS,
	MINAMETYPE_HUD,
	MINAMETYPE_RADAR,
	MINAMETYPE_RADARROTATE
} miNameType_t;

class q4fMapInfo {

public:

							q4fMapInfo( void );

							// Loads the map's mapinfo file.
							// If it doesn't exist, it prints a warning and loads _default.mapinfo
	void					LoadMap( const char* mapname, bool loadDefault = false );

	void					WriteInfo( int gameType, idBitMsg &msg );
	void					ReadInfo( const idBitMsg &msg );

	const char*				GetMapLongName( void );
	const char*				GetMapShortName( void );

	// getters refer to #'s as defined in mapinfo files, not by their point in the arrays
	bool					GameTypeDefined( int gameType );
	const char*				GetGameTypeLongName( int gameType );
	const char*				GetGameTypeShortName( int gameType );
	const char*				GetGameTypeDesc( int gameType );

	const char*				GetGameTypeHud( int gameType );
	float					GetGameTypeRadarRotation( int gameType );
	const char*				GetGameTypeRadarBG( int gameType );
	
	bool					TeamDefined( int gameType, int teamNum );
	const char*				GetTeamName( int gameType, int teamNum );
	int						GetTeamMaxPlayers( int gameType, int teamNum );
	idVec3					GetTeamColor( int gameType, int teamNum );
	int						GetClassLimit( int gameType, int teamNum, int classNum );

	// clears the stored map data
	void					Clear( void );

private:

	gametype_t*				GetGameType( int num );

	// parser stuff
	void					ParseMapInfo( idLexer &lexer, mapinfo_t &mapinfo );
	void					ParseGameType( idLexer &lexer, gametype_t &gametype );
	void					ParseTeam( idLexer &lexer, teaminfo_t &team );	

	idStr					ReadString( idLexer &lex );
	int						ReadInt( idLexer &lex );
	idVec3					ReadVec( idLexer &lex );

							// checks if the mapinfo is valid
	bool					ValidateInfo( mapinfo_t &mapinfo );
	bool					IsValidGameType( gametype_t &gametype );

	bool					IsValidGameTypeNum( int num );
	bool					IsValidTeamNum( int num );

	void					LexError( const char* error, idLexer* lex = NULL );

	miNameType_t			GetNameType( idStr type );

	mapinfo_t				mapInfo;
	bool					isValid;
};

#endif