#ifndef __TFSTATMANAGER_H__
#define __TFSTATMANAGER_H__

/*
===================================================================================
	Player Stats
===================================================================================
*/

#include "TFStatEvent.h"

struct inGameAwardInfo_t {
	char* name;
};

typedef enum {
	IGA_INVALID = 0,
	IGA_CAPTURE,
	IGA_HUMILIATION,
	IGA_IMPRESSIVE,
	IGA_EXCELLENT,
	IGA_ASSIST,
	IGA_DEFENSE,
	IGA_COMBO_KILL,
	IGA_RAMPAGE,
	IGA_HOLY_SHIT,
	IGA_NUM_AWARDS
} inGameAward_t;

#define MAX_STAT_NAME_LENGTH 20

typedef struct dmgStat_s {
	word		hitsToEnemy;
	word		hitsToTeam;

	word		hitsFromEnemy;
	word		hitsFromTeam;
	word		hitsFromSelf;

	word		killsEnemy;
	word		killsTeam;
	word		killsSelf;

	word		deathsEnemy;
	word		deathsTeam;

	word		damageToEnemy;
	word		damageToTeam;

	word		damageFromEnemy;
	word		damageFromTeam;
	word		damageFromSelf;

	ENTDEF		dmgDef;
} dmgStat_t;

typedef struct attackStat_s {
	idStr		stat_group;

	word		shotsFired;

	dmgStat_t	totalDamage;
} attackStat_t;

class TFPlayerStats {
public:
	TFPlayerStats( void ) { Clear(); };

	void			Init( int spawnID, int statsIndex, const char* guid );
	void			Clear( void );

	idPlayer*		GetPlayer( void ) const;

	dmgStat_t*			GetDmgStat( ENTDEF damageDef );
	dmgStat_t*			GetDmgStat( int defIndex );
	const dmgStat_t*	GetDmgStat( ENTDEF damageDef ) const;
	const dmgStat_t*	GetDmgStat( int defIndex ) const;
	attackStat_t*		GetAttackStat( ENTDEF attackDef );
	attackStat_t*		GetAttackStat( const char* stat_group);
	const attackStat_t*	GetAttackStat( ENTDEF attackDef ) const;
	const attackStat_t*	GetAttackStat( const char* stat_group) const;

	//const attackStat_t*	GetNextAttackStat( const char* category, const attackStat_t* previous ) const;

	dmgStat_t*		AddDmgStat( int defIndex );
	dmgStat_t*		AddDmgStat( ENTDEF damageDef );
	attackStat_t*	AddAttackStat( const char* stat_group );
	attackStat_t*	AddAttackStat( ENTDEF attackDef );

	int				StatKillsEnemy( void ) const;
	int				StatKillsEnemy( dmgStat_t* dmg ) const;
	int				StatKillsEnemy( const char* stat_group ) const;

	int				StatKillsTeam( void ) const;
	int				StatKillsTeam( dmgStat_t* dmg ) const;
	int				StatKillsTeam( const char* stat_group ) const;

	int				StatKillsSelf( void ) const;
	int				StatKillsSelf( dmgStat_t* dmg ) const;
	int				StatKillsSelf( const char* stat_group ) const;

	int				StatDeathsEnemy( void ) const;
	int				StatDeathsEnemy( dmgStat_t* dmg ) const;
	int				StatDeathsEnemy( const char* stat_group ) const;

	int				StatDeathsTeam( void ) const;
	int				StatDeathsTeam( dmgStat_t* dmg ) const;
	int				StatDeathsTeam( const char* stat_group ) const;

	int				StatHitsToEnemy( void ) const;
	int				StatHitsToEnemy( dmgStat_t* dmg ) const;
	int				StatHitsToEnemy( const char* stat_group ) const;

	int				StatHitsToTeam( void ) const;
	int				StatHitsToTeam( dmgStat_t* dmg ) const;
	int				StatHitsToTeam( const char* stat_group ) const;

	int				StatHitsFromEnemy( void ) const;
	int				StatHitsFromEnemy( dmgStat_t* dmg ) const;
	int				StatHitsFromEnemy( const char* stat_group ) const;

	int				StatHitsFromTeam( void ) const;
	int				StatHitsFromTeam( dmgStat_t* dmg ) const;
	int				StatHitsFromTeam( const char* stat_group ) const;

	int				StatHitsFromSelf( void ) const;
	int				StatHitsFromSelf( dmgStat_t* dmg ) const;
	int				StatHitsFromSelf( const char* stat_group ) const;

	int				StatDamageToEnemy( void ) const;
	int				StatDamageToEnemy( dmgStat_t* dmg ) const;
	int				StatDamageToEnemy( const char* stat_group ) const;

	int				StatDamageToTeam( void ) const;
	int				StatDamageToTeam( dmgStat_t* dmg ) const;
	int				StatDamageToTeam( const char* stat_group ) const;

	int				StatDamageFromEnemy( void ) const;
	int				StatDamageFromEnemy( dmgStat_t* dmg ) const;
	int				StatDamageFromEnemy( const char* stat_group ) const;

	int				StatDamageFromTeam( void ) const;
	int				StatDamageFromTeam( dmgStat_t* dmg ) const;
	int				StatDamageFromTeam( const char* stat_group ) const;

	int				StatDamageFromSelf( void ) const;
	int				StatDamageFromSelf( dmgStat_t* dmg ) const;
	int				StatDamageFromSelf( const char* stat_group ) const;

	int				StatShotsFired( void ) const;
	int				StatShotsFired( dmgStat_t* dmg ) const;
	int				StatShotsFired( const char* stat_group ) const;

	void			GetXML( int myIndex, idStr &str ) const;

	idList<dmgStat_t>		dmgStats;
	idHashIndex				index2dmgStat;

	idList<attackStat_t>	attackStats;
	idHashIndex				group2attackStat;

	idList<int>				awardQueue;
	int						awardCounts[IGA_NUM_AWARDS];

	dmgStat_t		totalDamage;

	short			score;			// just teamplay score stuff

	short			frags;			// frags is just kills + teamkills + suicides, for snapshot
	word			suicides;
	
	word			sentryBuildCount;
	word			sentryKillCount;		// how many sentries we've killed

	word			dispenserBuildCount;
	word			dispenserKillCount;		// how many dispensers we've killed

	word			flagGrabs;
	word			flagSaves;
	word			flagCaptures;
	word			flagDrops;

	int				GetPlayTime( void ) const;
	int				playTime;
	int				playStartTime;

	idStr			guid;

	int						spawnID;
	idEntityPtr<idPlayer>	player;

	bool					inGame;					// if client is still connected to server

	idStr					lastKnownName;
	idStr					lastKnownClan;
	int						lastKnownTeam;

	int				statsIndex;

private:
	void			WriteNonZeroValue( int val, idBitMsg &msg ) const;
	int				ReadNonZeroValue( const idBitMsg &msg );
};

#define STAT_GETTER( _func_, _var_ ) \
ID_INLINE int TFPlayerStats::_func_( void ) const {						\
	int sum = 0;									\
	for ( int i = 0; i < dmgStats.Num(); i++ ) {		\
		sum += dmgStats[i]._var_;					\
	}												\
	return sum;										\
}													\
ID_INLINE int TFPlayerStats::_func_( const char* stat_group ) const {	\
	int sum = 0;									\
	for ( int i = 0; i < dmgStats.Num(); i++ ) {	\
		if ( !idStr::Icmp( dmgStats[i].dmgDef->dict.GetString( "stat_group" ), stat_group ) ) {	\
			sum += dmgStats[i]._var_;				\
		}											\
	}												\
	return sum;										\
}													\
ID_INLINE int TFPlayerStats::_func_( dmgStat_t* dmg ) const {			\
	assert( dmg );									\
	return dmg->_var_;								\
}													\


STAT_GETTER( StatKillsEnemy, killsEnemy )
STAT_GETTER( StatKillsTeam, killsTeam )
STAT_GETTER( StatKillsSelf, killsSelf )

STAT_GETTER( StatDeathsEnemy, deathsEnemy )
STAT_GETTER( StatDeathsTeam, deathsTeam )

STAT_GETTER( StatHitsToEnemy, hitsToEnemy )
STAT_GETTER( StatHitsToTeam, hitsToTeam )

STAT_GETTER( StatHitsFromEnemy, hitsFromEnemy )
STAT_GETTER( StatHitsFromTeam, hitsFromTeam )
STAT_GETTER( StatHitsFromSelf, hitsFromSelf )

STAT_GETTER( StatDamageToEnemy, damageToEnemy )
STAT_GETTER( StatDamageToTeam, damageToTeam )

STAT_GETTER( StatDamageFromEnemy, damageFromEnemy )
STAT_GETTER( StatDamageFromTeam, damageFromTeam )
STAT_GETTER( StatDamageFromSelf, damageFromSelf )

#undef STAT_GETTER

ID_INLINE int TFPlayerStats::StatShotsFired( void ) const {
	int sum = 0;
	for ( int i = 0; i < attackStats.Num(); i++ ) {
		sum += attackStats[i].shotsFired;
	}
	return sum;
}
ID_INLINE int TFPlayerStats::StatShotsFired( dmgStat_t* dmgStat ) const {
	return StatShotsFired( dmgStat->dmgDef->dict.GetString( "stat_group" ) );
}
ID_INLINE int TFPlayerStats::StatShotsFired( const char* stat_group ) const {
	const attackStat_t* att = GetAttackStat( stat_group );
	if ( att )
		return att->shotsFired;
	return 0;
}


ID_INLINE dmgStat_t* TFPlayerStats::GetDmgStat( ENTDEF damageDef ) {
	if ( damageDef )
		return GetDmgStat( damageDef->Index() );
	return NULL;
}

ID_INLINE const dmgStat_t* TFPlayerStats::GetDmgStat( ENTDEF damageDef ) const {
	if ( damageDef )
		return GetDmgStat( damageDef->Index() );
	return NULL;
}

ID_INLINE dmgStat_t* TFPlayerStats::GetDmgStat( int defIndex ) {
	int hash, i;

	hash = index2dmgStat.GenerateKey( defIndex, defIndex );
	for ( i = index2dmgStat.First( hash ); i != -1; i = index2dmgStat.Next( i ) ) {
		if ( dmgStats[i].dmgDef->Index() == defIndex )
			return &(dmgStats[i]);
	}

	return NULL;
}

ID_INLINE const dmgStat_t* TFPlayerStats::GetDmgStat( int defIndex ) const {
	int hash, i;

	hash = index2dmgStat.GenerateKey( defIndex, defIndex );
	for ( i = index2dmgStat.First( hash ); i != -1; i = index2dmgStat.Next( i ) ) {
		if ( dmgStats[i].dmgDef->Index() == defIndex )
			return &(dmgStats[i]);
	}

	return NULL;
}

ID_INLINE attackStat_t* TFPlayerStats::GetAttackStat( ENTDEF attackDef ) {
	if ( attackDef )
		return GetAttackStat( attackDef->dict.GetString( "stat_group" ) );
	return NULL;
}

ID_INLINE const attackStat_t* TFPlayerStats::GetAttackStat( ENTDEF attackDef ) const {
	if ( attackDef )
		return GetAttackStat( attackDef->dict.GetString( "stat_group" ) );
	return NULL;
}

ID_INLINE attackStat_t* TFPlayerStats::GetAttackStat( const char* stat_group ) {
	if ( !stat_group || !stat_group[0] )
		return NULL;

	int hash, i;

	hash = group2attackStat.GenerateKey( stat_group, false );
	for ( i = group2attackStat.First( hash ); i != -1; i = group2attackStat.Next( i ) ) {
		if ( !idStr::Icmp( attackStats[i].stat_group.c_str(), stat_group ) )
			return &(attackStats[i]);
	}

	return NULL;
}

ID_INLINE const attackStat_t* TFPlayerStats::GetAttackStat( const char* stat_group ) const {
	if ( !stat_group || !stat_group[0] )
		return NULL;

	int hash, i;

	hash = group2attackStat.GenerateKey( stat_group, false );
	for ( i = group2attackStat.First( hash ); i != -1; i = group2attackStat.Next( i ) ) {
		if ( !idStr::Icmp( attackStats[i].stat_group.c_str(), stat_group ) )
			return &(attackStats[i]);
	}

	return NULL;
}

ID_INLINE void TFPlayerStats::WriteNonZeroValue( int val, idBitMsg &msg ) const {
	if ( val > 0 ) {
		msg.WriteBits( 1, 1 );
		msg.WriteBits( val, 16 );
	}
	else {
		msg.WriteBits( 0, 1 );
	}
}

ID_INLINE int TFPlayerStats::ReadNonZeroValue( const idBitMsg &msg ) {
	if ( msg.ReadBits( 1 ) ) {
		return msg.ReadBits( 16 );
	}

	return 0;
}

ID_INLINE idPlayer* TFPlayerStats::GetPlayer() const {
	return player.GetEntity();
}













/*
===================================================================================
	Statistics Manager. Run only server side, clients are updated
thru reliable messages.
===================================================================================
*/

typedef enum {
	METRIC_GENERAL = 0,
	METRIC_CTF = 1,
	METRIC_ATTACK = 2,
	METRIC_DAMAGE = 3
} statsMetricType_t;

#define ASYNC_STATS_METRIC_TYPE_BITS 2

typedef enum {
	VERSUS_ENEMY = 0,
	VERSUS_TEAM = 1,
	VERSUS_SELF = 2,
} statsVersusType_t;

typedef enum {
	MEASURE_TOTAL = 0,
	MEASURE_MINUTE = 1
} statsMeasureType_t;

#define ASYNC_STATS_VERSUS_TYPE_BITS 2

typedef enum {
	ST_SORT_NAME = 0,
	ST_SORT_SHOTS_FIRED = 1,
	ST_SORT_SHOTS_HIT = 2,
	ST_SORT_ACCURACY = 3,
	ST_SORT_KILLS = 4,
	ST_SORT_DEATHS = 5,
	ST_SORT_DMG_GIVEN = 6,
	ST_SORT_DMG_TAKEN = 7,
	ST_SORT_SCORE = 8,
	ST_SORT_STEALS = 9,
	ST_SORT_DROPS = 10,
	ST_SORT_CAPTURES = 11,
	ST_SORT_SAVES = 12,
	ST_SORT_PLAYTIME = 13
} statsSortType_t;

typedef enum {
	ST_SORT_OR_ASC = 0,
	ST_SORT_OR_DEC = 1
} statsSortOrder_t;

typedef struct {
	int clientNum;
	short shots_fired;
	short shots_hit;
	float accuracy;
	short kills;
	short deaths;
	short dmgGiven;
	short dmgTaken;
} statsTypeAttack_t;

typedef struct {
	int clientNum;
	short kills;
	short deaths;
	short dmgGiven;
	short dmgTaken;
} statsTypeGeneral_t;

typedef struct {
	int clientNum;
	short score;
	short steals;
	short drops;
	short captures;
	short saves;
} statsTypeCTF_t;

class TFStatManager {
public:
					TFStatManager( void );

	void			Init();
	void			ClearRound( void );
	void			ClearPlayers( void );
	void			ShutDown( );

	void			WriteToSnapshot( idBitMsgDelta &msg ) const;
	void			ReadFromSnapshot( const idBitMsgDelta &msg );

	void			ClientConnect( idPlayer* player );
	void			ClientDisconnect( int clientNum );

	void			RoundStart( const char* mapName );
	void			RoundEnd( void );

	void			ShotFired( const AttackerInfo &attacker, ENTDEF attackDef );

	void			EntityDamaged( idEntity* victim, const TFDamage &dmg, bool death );

	void			PlayerChangeTeam( idPlayer* player, int oldTeam, int newTeam );
	void			PlayerChangeClass( idPlayer* player, int oldClass, int newClass );

	void			SentryKilled( const SentryGun* sentry, const TFDamage &damage );
	void			DispenserKilled( Dispenser* dispenser, TFDamage &damage );
	//void			DetpackDisarmed( q4fDetpack* detpack, idPlayer* disarmer );

	void			FlagGrab( TFCarryItem* flag, idPlayer* stealer );
	void			FlagDrop( TFCarryItem* flag, idPlayer* carrier, TFDamage* dmg = NULL );
	void			FlagCapture( TFCarryItem* flag, idPlayer* carrier );

	void			AddPlayerScore( int clientNum, int score );
	int				GetPlayerScore( int clientNum ) const;
	void			AddTeamScore( int team, int score );
	int				GetTeamScore( int team ) const;
	
	void			PrintDeathMsg( int attackerIndex, int victimIndex, int dmgDefNum ) const;

	void			UpdateGUIStats( bool force );
	void			RedrawGUIStats( idUserInterface* gui, ENTDEF attackDef = NULL );


	void			DistributeStats( void ) const;
	void			WriteStatsXML( void ) const;

	void			GetDamageList( const TFPlayerStats* stats, const char* stat_group, idList<const dmgStat_t*> &list ) const;

	bool			RoundInProgress( void ) { return roundInProgress; };

	const TFPlayerStats*	GetPlayerStatsSpawnID( int spawnID ) const;
	TFPlayerStats*			GetPlayerStatsSpawnID( int spawnID );
	const TFPlayerStats*	GetPlayerStatsClientNum( int clientNum ) const;
	TFPlayerStats*			GetPlayerStatsClientNum( int clientNum );
	const TFPlayerStats*	GetPlayerStatsPlayer( idPlayer* player ) const;
	TFPlayerStats*			GetPlayerStatsPlayer( idPlayer* player );
	
	void					ClientRequestsStats( int clientNum, const idBitMsg &msg );
	void					ClientReceiveStats( const idBitMsg &msg );

	void					CheckAwardQueue( void );
	void					ReceiveInGameAward( const idBitMsg &msg );

private:

	void					SendInGameAward( int clientNum, inGameAward_t award, int awardCount );
	
	const char* 			GetDeathMsg( const char* attacker, const char* victim, const idDeclEntityDef* dmgDef ) const;

	statsMetricType_t		GetMetricType( idUserInterface* gui );
	void					SetMetricType( idUserInterface* gui, statsMetricType_t type );
	statsVersusType_t		GetVersusType( idUserInterface* gui );
	void					SetVersusType( idUserInterface* gui, statsVersusType_t type );
	statsSortType_t			GetSortType( idUserInterface* gui );
	statsSortOrder_t		GetSortOrder( idUserInterface* gui );
	statsMeasureType_t		GetMeasureType( idUserInterface* gui );

	void					DrawStatsGeneral( idUserInterface* gui  );
	void					DrawStatsCTF( idUserInterface* gui  );
	void					DrawStatsAttack( idUserInterface* gui  );

	statsTypeGeneral_t generalStats[MAX_CLIENTS];
	statsTypeCTF_t ctfStats[MAX_CLIENTS];
	statsTypeAttack_t attackStats[MAX_CLIENTS];
	int playTimes[MAX_CLIENTS];

	bool					roundInProgress;

	idList<tfStat*>			statQueue;

	idList<TFPlayerStats>	playerStats;
	int						client2index[MAX_CLIENTS];
	idHashIndex				spawnIdHash;

	short					teamScores[TEAM_COUNT];

	int						lastStatsRequestTime;
};

ID_INLINE const TFPlayerStats* TFStatManager::GetPlayerStatsClientNum( int clientNum ) const {
	assert( clientNum >= 0 && clientNum < MAX_CLIENTS );
	int index = client2index[clientNum];

	if ( index >= 0 && index < playerStats.Num() )
		return &(playerStats[ index ]);

	return NULL;
}

ID_INLINE TFPlayerStats* TFStatManager::GetPlayerStatsClientNum( int clientNum ) {
	assert( clientNum >= 0 && clientNum < MAX_CLIENTS );
	int index = client2index[clientNum];

	if ( index >= 0 && index < playerStats.Num() )
		return &(playerStats[ index ]);

	return NULL;
}

ID_INLINE const TFPlayerStats* TFStatManager::GetPlayerStatsSpawnID( int spawnID ) const {
	int hash, i;

	hash = spawnIdHash.GenerateKey( spawnID, spawnID );
	for ( i = spawnIdHash.First( hash ); i != -1; i = spawnIdHash.Next( i ) ) {
		if ( playerStats[i].spawnID == spawnID ) {
			return &(playerStats[i]);
		}
	}

	return NULL;
}

ID_INLINE TFPlayerStats* TFStatManager::GetPlayerStatsSpawnID( int spawnID ) {
	int hash, i;

	hash = spawnIdHash.GenerateKey( spawnID, spawnID );
	for ( i = spawnIdHash.First( hash ); i != -1; i = spawnIdHash.Next( i ) ) {
		if ( playerStats[i].spawnID == spawnID ) {
			return &(playerStats[i]);
		}
	}

	return NULL;
}

ID_INLINE const TFPlayerStats* TFStatManager::GetPlayerStatsPlayer( idPlayer* player ) const {
	if ( !player )
		return NULL;

	return GetPlayerStatsClientNum( player->entityNumber );
}

ID_INLINE TFPlayerStats* TFStatManager::GetPlayerStatsPlayer( idPlayer* player ) {
	if ( !player )
		return NULL;

	return GetPlayerStatsClientNum( player->entityNumber );
}

ID_INLINE int TFStatManager::GetPlayerScore( int clientNum ) const {
	const TFPlayerStats* stat = GetPlayerStatsClientNum( clientNum );
	
	if ( stat ) {
		return stat->score;
	}

	return 0;
}

ID_INLINE int TFStatManager::GetTeamScore( int team ) const {
	assert( IS_VALID_TEAM( team ) );
	return teamScores[team];
}

#endif