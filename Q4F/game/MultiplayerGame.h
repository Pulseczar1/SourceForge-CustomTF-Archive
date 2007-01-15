
// ddynerman: note that this file is no longer merged with Doom3 updates
//
// MERGE_DATE 09/30/2004

#ifndef __MULTIPLAYERGAME_H__
#define	__MULTIPLAYERGAME_H__

#include "Q4F/TFGame.h"

/*
===============================================================================

	Quake IV multiplayer

===============================================================================
*/

class idPlayer;

// shouchard:  server admin command types
typedef enum {
	SERVER_ADMIN_KICK,
	SERVER_ADMIN_BAN,
	SERVER_ADMIN_REMOVE_BAN,
	SERVER_ADMIN_FORCE_SWITCH,
} serverAdmin_t;

#define SCRIPT_CACHE_SIZE 64

const int ASYNC_SCRIPT_CACHE_BITS  = 6;

#define MAX_MAP_GUI_VARS 64
#define MAX_MAP_GUI_DATASIZE 64

typedef enum {
	GUI_VAR_TYPE_NONE = 0,
	GUI_VAR_TYPE_STRING,
	GUI_VAR_TYPE_FLOAT,
	GUI_VAR_TYPE_INT,
	GUI_VAR_TYPE_BOOL,
	GUI_VAR_TYPE_COUNT
} guiVarType_t;

const int ASYNC_GUI_VAR_TYPE_BITS = 3;
const int ASYNC_GUI_VAR_NUM_BITS = 6;

typedef struct {
//	int				varNum;
	guiVarType_t	type;
	int				intVal;
	idStr			strVal;
} mapGuiVar_t;

#define MAX_PRINT_LEN		128

enum announcerSound_t {
	// General announcements
	AS_GENERAL_ONE,
	AS_GENERAL_TWO,
	AS_GENERAL_THREE,
	AS_GENERAL_YOU_WIN,
	AS_GENERAL_YOU_LOSE,
	AS_GENERAL_FIGHT,
	AS_GENERAL_SUDDEN_DEATH,
	AS_GENERAL_VOTE_FAILED,
	AS_GENERAL_VOTE_PASSED,
	AS_GENERAL_VOTE_NOW,
	AS_GENERAL_ONE_FRAG,
	AS_GENERAL_TWO_FRAGS,
	AS_GENERAL_THREE_FRAGS,
	AS_GENERAL_ONE_MINUTE,
	AS_GENERAL_FIVE_MINUTE,
	AS_GENERAL_PREPARE_TO_FIGHT,
	AS_GENERAL_QUAD_DAMAGE,
	AS_GENERAL_REGENERATION,
	AS_GENERAL_HASTE,
	AS_GENERAL_INVISIBILITY,
	// DM announcements
	AS_DM_YOU_TIED_LEAD,
	AS_DM_YOU_HAVE_TAKEN_LEAD,
	AS_DM_YOU_LOST_LEAD,
	// Team announcements
	AS_TEAM_ENEMY_SCORES,
	AS_TEAM_YOU_SCORE,
	AS_TEAM_TEAMS_TIED,
	AS_TEAM_STROGG_LEAD,
	AS_TEAM_MARINES_LEAD,
	AS_TEAM_JOIN_MARINE,
	AS_TEAM_JOIN_STROGG,
	// CTF announcements
	AS_CTF_YOU_HAVE_FLAG,
	AS_CTF_YOUR_TEAM_HAS_FLAG,
	AS_CTF_ENEMY_HAS_FLAG,
	AS_CTF_YOUR_TEAM_DROPS_FLAG,
	AS_CTF_ENEMY_DROPS_FLAG,
	AS_CTF_YOUR_FLAG_RETURNED,
	AS_CTF_ENEMY_RETURNS_FLAG,
	// Tourney announcements
	AS_TOURNEY_ADVANCE,
	AS_TOURNEY_JOIN_ARENA_ONE,
	AS_TOURNEY_JOIN_ARENA_TWO,
	AS_TOURNEY_JOIN_ARENA_THREE,
	AS_TOURNEY_JOIN_ARENA_FOUR,
	AS_TOURNEY_JOIN_ARENA_FIVE,
	AS_TOURNEY_JOIN_ARENA_SIX,
	AS_TOURNEY_JOIN_ARENA_SEVEN,
	AS_TOURNEY_JOIN_ARENA_EIGHT,
	AS_TOURNEY_JOIN_ARENA_WAITING,
	AS_TOURNEY_DONE,
	AS_TOURNEY_START,
	AS_TOURNEY_ELIMINATED,
	AS_TOURNEY_WON,
	AS_TOURNEY_PRELIMS,
	AS_TOURNEY_QUARTER_FINALS,
	AS_TOURNEY_SEMI_FINALS,
	AS_TOURNEY_FINAL_MATCH,
	AS_NUM_SOUNDS
};

typedef struct mpPlayerState_s {
	int				ping;			// player ping
	bool			scoreBoardUp;	// toggle based on player scoreboard button, used to activate de-activate the scoreboard gui
	bool			ingame;
	bool			connected;
	short			score;
	short			frags;
} mpPlayerState_t;

const int NUM_CHAT_NOTIFY	= 5;
const int CHAT_FADE_TIME	= 400;
const int FRAGLIMIT_DELAY	= 2000;
const int CAPTURELIMIT_DELAY = 750;

const int MP_PLAYER_MINFRAGS = -100;
const int MP_PLAYER_MAXFRAGS = 999;
const int MP_PLAYER_MAXWINS	= 100;
const int MP_PLAYER_MAXPING	= 999;

const int MAX_AP = 5;

const int CHAT_HISTORY_SIZE = 2048;
const int RCON_HISTORY_SIZE = 4096;

const int KILL_NOTIFICATION_LEN = 256;

const int ASYNC_PLAYER_FRAG_BITS = -idMath::BitsForInteger( MP_PLAYER_MAXFRAGS - MP_PLAYER_MINFRAGS );	// player can have negative frags
const int ASYNC_PLAYER_WINS_BITS = idMath::BitsForInteger( MP_PLAYER_MAXWINS );
const int ASYNC_PLAYER_PING_BITS = idMath::BitsForInteger( MP_PLAYER_MAXPING );


// ddynerman: game state
#include "mp/GameState.h"

typedef struct mpChatLine_s {
	idStr			line;
	short			fade;			// starts high and decreases, line is removed once reached 0
} mpChatLine_t;

typedef struct mpBanInfo_s {
	idStr			name;
	char			guid[ CLIENT_GUID_LENGTH ];
//	unsigned char	ip[ 15 ];
} mpBanInfo_t;

class idMultiplayerGame {

	// TFGameState manages our state
	friend class TFGameState;

public:

					idMultiplayerGame();

	void			Shutdown( void );

	// resets everything and prepares for a match
	void			Reset( void );


// mwhitlock: Dynamic memory consolidation
	// Made this public so that level heap can be emptied.
	void			Clear( void );


	// setup local data for a new player
	void			SpawnPlayer( int clientNum );

	// Run the MP Game
	void			Run( void );

	// Run the local client
	void			ClientRun( void );
	void			ClientEndFrame( void );

	// Run common code (client & server)
	void			CommonRun( void );

	// draws mp hud, scoredboard, etc.. 
	bool			Draw( int clientNum );
	

	void			AddChatLine( const char *fmt, ... ) id_attribute((format(printf,2,3)));
	void			AddTeamChatLine( const char *fmt, ... ) id_attribute((format(printf,2,3)));
	bool			playChatSound;


	void			UpdateMainGui( void );

	idUserInterface*	GetMainGui( void );

// bdube: global pickup sounds (powerups, etc)
	// Global item acquire sounds 
	void			PlayGlobalItemAcquireSound ( int entityDefIndex );

	bool			CanTalk( idPlayer *from, idPlayer *to, bool echo );
	void			ReceiveAndForwardVoiceData( int clientNum, const idBitMsg &inMsg, int messageType );

#ifdef _USE_VOICECHAT
// jscott: game side voice comms

	void			XmitVoiceData( void );

	void			ReceiveAndPlayVoiceData( const idBitMsg &inMsg );
#endif

// jshepard: selects a map at random that will run with the current game type
	bool			PickMap( idStr gameType );
	void			ResetRconGuiStatus( void );



	idUserInterface*	StartMenu( void );
	
	void			ClearMenu() { currentMenu = 0; }

	const char*		HandleGuiCommands( const char *menuCommand );

	void			FillStatPlayerNames( idUserInterface* gui, int selectClient );

	void			WriteToSnapshot( idBitMsgDelta &msg ) const;
	void			ReadFromSnapshot( const idBitMsgDelta &msg );

	void			ShuffleTeams( void );
	void			SetGameType( const char* mapName );
	void			SetMatchStartedTime( int time ) { matchStartedTime = time; };
	void			SetWarmupStartedTime( int time ) { warmupStartedTime = time; };

	TFGameState*	GetGameState( void );


	void			PrintMessageEvent( int to, msg_evt_t evt, int parm1 = -1, int parm2 = -1 );
	void			PrintMessage( int to, const char* message );

	void			DisconnectClient( int clientNum );
	//static void		DropWeapon_f( const idCmdArgs &args );
	static void		MessageMode_f( const idCmdArgs &args );
	static void		VoiceChat_f( const idCmdArgs &args );
	static void		VoiceChatTeam_f( const idCmdArgs &args );



// shouchard:  added console commands to mute/unmute voice chat
	static void		VoiceMute_f( const idCmdArgs &args );
	static void		VoiceUnmute_f( const idCmdArgs &args );

// jshepard: command wrappers
	static void		ForceTeamChange_f( const idCmdArgs& args );
	static void		RemoveClientFromBanList_f( const idCmdArgs& args );

// activates the admin console when a rcon password challenge returns.
	void			ProcessRconReturn( bool success );


	const char *	LocalizeGametype( void );


	void			WantKilled( int clientNum );
	int				NumActualClients( bool countSpectators, int *teamcount = NULL );
	//void			DropWeapon( int clientNum );
	void			MapRestart( void );
	// called by idPlayer whenever it detects a team change (init or switch)
	void			JoinTeam( int clientNum, int newTeam );

	// <q4f> 

	void			JoinSpectators( int clientNum, int specTeam );

	// </q4f>
	
	bool			IsPureReady( void ) const;
	void			ProcessChatMessage( int clientNum, chatTargetType_t target, const char *text, int shaderIndex );
	void			ProcessVoiceChat( int clientNum, bool team, int index );
	void			PrintChatMessage( int clientNum, chatTargetType_t target, const char* text, int shaderIndex );

	void			DeTokenChatMessage( bool asClient, idStr& msg, idEntity* chatter );

	void			PrintCenterMessage( const char* message );
	void			ProcessCenterMessage( int clientNum, const char* message );

// shouchard:  added commands to mute/unmute voice chat
	void			ClientVoiceMute( int clientNum, bool mute );
	int				GetClientNumFromPlayerName( const char *playerName );
	void			ServerHandleVoiceMuting( int clientSrc, int clientDest, bool mute );
// shouchard:  fixing a bug in multiplayer where round timer sounds (5 minute
//             warning, etc.) don't go away at the end of the round.
	void			ClearAnnouncerSounds( void );

// shouchard:  server admin stuff
	typedef struct 
	{
		bool		restartMap;
		idStr		mapName;
		int			gameType;
		int			captureLimit;
		int			fragLimit;
		int			tourneyLimit;
		int			timeLimit;
		int			minPlayers;
		bool		autoBalance;
		bool		shuffleTeams;
	} serverAdminData_t;

	void			HandleServerAdminBanPlayer( int clientNum );
	void			HandleServerAdminRemoveBan( const char * info );
	void			HandleServerAdminKickPlayer( int clientNum );
	void			HandleServerAdminForceTeamSwitch( int clientNum );
	bool			HandleServerAdminCommands( serverAdminData_t &data );


	void			Precache( void );
	
	// throttle UI switch rates
	void			ThrottleUserInfo( void );
	//void			ToggleReady( void );

	void			EnterGame( int clientNum );
	bool			CanPlay( idPlayer *p );
	bool			IsInGame( int clientNum );
	bool			WantRespawn( idPlayer *p );

	void			ServerWriteInitialReliableMessages( int clientNum );
	void			ClientReadStartState( const idBitMsg &msg );
	void			ClientReadGuiVars( const idBitMsg &msg );

	void			ServerClientConnect( int clientNum );

	void			PlayerStats( int clientNum, char *data, const int len );

	void			SetHudOverlay( idUserInterface* overlay, int duration );

	void			ClearMap ( void );

	void			EnableDamage( bool enable = true );

	int				GetPlayerTime( idPlayer* player );

	const char*		GetLongGametypeName( const char* gametype );

	void			ReceiveRemoteConsoleOutput( const char* output );

	void			AddPrivatePlayer( int clientId );
	void			RemovePrivatePlayer( int clientId );

	void			RemoveAnnouncerSound( int type );
	void			RemoveAnnouncerSoundRange( int startType, int endType );
	void			ScheduleAnnouncerSound ( announcerSound_t sound, float time, int instance = -1, bool allowOverride = false );
	void			ScheduleTimeAnnouncements( void );

	void			ShowStatSummary( void );
	
	void			UpdateHud( idUserInterface* _mphud );
	bool			TimeLimitHit( void );
	int				CaptureLimitHit( void );

	int				GetCurrentMenu( void ) { return currentMenu; }

	void			WriteNetworkInfo( idFile *file, int clientNum );
	void			ReadNetworkInfo( idFile* file, int clientNum );

	void			SetShaderParms( renderView_t *view );

	void			SetMapGuiFloat( int varNum, float val );
	void			SetMapGuiString( int varNum, const char* val );
	void			SetMapGuiInt( int varNum, int val );
	void			SetMapGuiBool( int varNum, bool val );
	void			MapGuiNamedEvent( int eventNum );

	void			ClearGuis( void );

	//idList<idStr>		messageCache[MAX_CLIENTS];
	//int					messageIndex[MAX_CLIENTS];

	idUserInterface* maphud;

	q4fVoteSys		voteSystem;

private:
	static const char	*MPGuis[];
	static const char	*ThrottleVars[];
	static const char	*ThrottleVarsInEnglish[];
	static const int	ThrottleDelay[];

	char			killNotificationMsg[ KILL_NOTIFICATION_LEN ];

	int				pingUpdateTime;			// time to update ping

	mpPlayerState_t	playerState[ MAX_CLIENTS ];

	// game state
	TFGameState		gameState;

	// time related
	int				matchStartedTime;		// time current match started
	int				warmupStartedTime;		// time current warmup started
	int				mapStartedTime;			// time the current map was loaded

	// guis
	idUserInterface *scoreBoard;			// scoreboard
	idUserInterface *mainGui;				// ready / nick / votes etc.
	idListGUI		*mapList;
	idUserInterface *msgmodeGui;			// message mode


	int				currentMenu;			// 0 - none, 1 - mainGui, 2 - msgmodeGui, 5 - classGui
	int				nextMenu;				// if 0, will do mainGui
	bool			bCurrentMenuMsg;		// send menu state updates to server


	enum {
		MPLIGHT_CTF_MARINE,
		MPLIGHT_CTF_STROGG,
		MPLIGHT_QUAD,
		MPLIGHT_HASTE,
		MPLIGHT_REGEN,
		MPLIGHT_MAX
	};

	int				lightHandles[ MPLIGHT_MAX ];
	renderLight_t	lights[ MPLIGHT_MAX ];

	// chat buffer
	idStr			chatHistory;

	// rcon buffer
	idStr			rconHistory;

public:

	const char*		GetStatAwards( void );
	idStr			awardsStr;

private:

	bool			pureReady;				// defaults to false, set to true once server game is running with pure checksums
	bool			currentSoundOverride;
	int				switchThrottle[ 3 ];
	int				voiceChatThrottle;

	idList<int>		privateClientIds;
	int				privatePlayers;
	
	// ddynerman: gametype specific scoreboard
	void			UpdateScoreboard( idUserInterface *scoreBoard );

	void			UpdateDMScoreboard( idUserInterface *scoreBoard );
	void			UpdateTeamScoreboard( idUserInterface *scoreBoard );
	

	const char*		BuildSummaryListString( idPlayer* player, int rankedScore );

	void			UpdatePrivatePlayerCount( void );

	typedef struct announcerSoundNode_s {
		announcerSound_t					soundShader;
		float								time;
		idLinkList<announcerSoundNode_s>	announcerSoundNode;
		int									instance;
		bool								allowOverride;
	} announcerSoundNode_t;

	idLinkList<announcerSoundNode_t>	announcerSoundQueue;
	announcerSound_t					lastAnnouncerSound;

	static const char* announcerSoundDefs[ AS_NUM_SOUNDS ];

	float			announcerPlayTime;

	void			PlayAnnouncerSounds ( void );

	void			DrawScoreBoard( idPlayer *player );
	void			CheckVote( void );
	bool			RoundReadyToStart( idStr* reason = NULL );
	
	const char *	GameTime( void );

	bool			EnoughClientsToPlay( void );
	void			DrawStatSummary( void );
	// go through the clients, and see if they want to be respawned, and if the game allows it
	// called during normal gameplay for death -> respawn cycles
	// and for a spectator who want back in the game (see param)
	void			CheckRespawns( void );

	void			FreeLight ( int lightID );
	void			UpdateLight ( int lightID, idPlayer *player );
	//void			ForceReady();
	// when clients disconnect or join spectate during game, check if we need to end the game
	void			CheckAbortGame( void );
	void			MessageMode( const idCmdArgs &args );
	void			DisableMenu( void );
	void			SetMapShot( void );
	// scores in TDM
	void			VoiceChat( const idCmdArgs &args, bool team );

	void			WriteStartState( int clientNum, idBitMsg &msg, bool withLocalClient );

	// <q4f> 
public:

	bool			IsValidGameType( const char* mapName, int gametype );
	bool			IsValidGameType( q4fMapInfo &mapinfo, int gametype );

	void			Respawn( idPlayer* player );
	void			ShowQ4FMenu( int tabNum );

	int				GetPlayerScore( int clientNum );

	//void			PlayerDeath_TF( idPlayer* victim, TFDamage &tfDamage );

private:

	void			UpdateGUIClassSelection( int teamNum, idUserInterface* gui );
	void			UpdateGUIClassInfo( idUserInterface* gui );
	void			UpdateGUIClassModelInfo( idUserInterface* currentGui );
	void			UpdateTeamPageClassInfo( int teamNum, idUserInterface* gui );
	
	bool			HandleQ4FMenuKeyPress( int tabNum, int keyNum );

	mapGuiVar_t		mapGuiVars[MAX_MAP_GUI_VARS];

	int				lastVoiceMessageTimes[MAX_CLIENTS];

	// </q4f>

};

ID_INLINE bool idMultiplayerGame::IsPureReady( void ) const {
	return pureReady;
}

ID_INLINE bool idMultiplayerGame::IsInGame( int clientNum ) {
	return playerState[ clientNum ].ingame;
}

ID_INLINE int idMultiplayerGame::GetPlayerScore( int clientNum ) {
	return playerState[ clientNum ].score;
}

ID_INLINE void idMultiplayerGame::ResetRconGuiStatus( void ) {
	if( mainGui) {
		mainGui->SetStateInt( "password_valid", 0 );
	}
}

ID_INLINE idUserInterface* idMultiplayerGame::GetMainGui( void ) {
	return mainGui;
}

int ComparePlayersByScore( const void* left, const void* right );
int CompareTeamsByScore( const void* left, const void* right );

#endif	/* !__MULTIPLAYERGAME_H__ */


