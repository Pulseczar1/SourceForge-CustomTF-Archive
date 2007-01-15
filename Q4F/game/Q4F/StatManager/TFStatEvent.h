#ifndef __TFSTATEVENT_H__
#define __TFSTATEVENT_H__

#define WORLD_INDEX 0x000000FF


/*
================
statType_t

The type of stat our statEvent is
================
*/
typedef enum stattype_t {
	// not an actual event, undefined marker
	STAT_NONE = 0,

	STAT_ROUND_START,
	STAT_ROUND_END,
	STAT_CLIENT_CONNECT,
	STAT_CLIENT_DISCONNECT,
	STAT_SENTRYKILL,
	STAT_DISPENSERKILL,
	STAT_DETPACKDISARM,
	STAT_PLAYERDEATH,
	STAT_FLAG_GRAB,
	STAT_FLAG_DROP,
	STAT_FLAG_CAPTURE,
	

	STAT_COUNT
};

// parent class all events derive from
class tfStat {

public:
	stattype_t			GetType( void ) const { return type; };
	int					GetTimeStamp( void ) const { return timeStamp; };
	byte				GetPlayerStatIndex( void ) const { return playerStatIndex; };

	virtual void		GetXML( int timeStart, idStr &txt ) { txt.Clear(); };

	virtual void		PackStats( idBitMsg &msg ) const {};
	virtual void		UnPackStats( const idBitMsg &msg ) {};

	virtual void		RegisterInGame() {};

	//int					GetPlayerIndex( void ) { return playerStatIndex; };

	

protected:
	stattype_t			type;
	int					timeStamp;

	// the stat number of the player associated with this statistic
	byte				playerStatIndex;

protected:
	tfStat() {};
};

// round start
class tfStatRoundStart : public tfStat {
public:
	// CHECK IF TIMESTAMP DONE FOR US
						tfStatRoundStart( int time, const char* mapname, const char* rounddate, int epochSeconds, int* playerCounts );

	idStr				mapName;
	idStr				roundDate;
	int					epochSeconds;
	byte				playersPerTeam[TEAM_COUNT];

	void				GetXML( int timeStart, idStr &txt );

	virtual void		PackStats( idBitMsg &msg ) const;
	virtual void		UnPackStats( const idBitMsg &msg );
};

// round end
class tfStatRoundEnd : public tfStat {
public:
	// CHECK IF TIMESTAMP DONE FOR US
						tfStatRoundEnd( int time, int* playerCounts, short* teamScores );

	byte				playersPerTeam[TEAM_COUNT];
	short				scorePerTeam[TEAM_COUNT];

	void				GetXML( int timeStart, idStr &txt );

	//virtual void		PackStats( idBitMsg &msg ) const;
	//virtual void		UnPackStats( const idBitMsg &msg );
};

// client connect
class tfStatClientConnect : public tfStat {
public:
						tfStatClientConnect( int time, int playerIndex ) { timeStamp = time; playerStatIndex = playerIndex; type = STAT_CLIENT_CONNECT; };
	
	void				GetXML( int timeStart, idStr &txt );
};

// client disconnect
class tfStatClientDisconnect : public tfStat {
public:
						tfStatClientDisconnect( int time, int playerIndex ) { timeStamp = time; playerStatIndex = playerIndex; type = STAT_CLIENT_DISCONNECT; };
	void				GetXML( int timeStart, idStr &txt );
};

// when a player kills a sentrygun
class tfStatSentryKill : public tfStat {
public:
						tfStatSentryKill( int time, int playerIndex, int playerTeam, int sentryOwnerIndex, int sentryOwnerTeam, int sentryLvl );

	byte				playerTeam;
	byte				ownerTeam;
	byte				ownerIndex;
	byte				sentryLevel;

	void				GetXML( int timeStart, idStr &txt );

	//virtual void		PackStats( idBitMsg &msg ) const;
	//virtual void		UnPackStats( const idBitMsg &msg );
};

// when a player kills a dispenser
class tfStatDispenserKill : public tfStat {
public:
						tfStatDispenserKill( int time, int playerIndex, int playerteam, int dispOwnerIndex, int dispOwnerTeam );

	byte				playerTeam;
	byte				ownerTeam;
	byte				ownerIndex;

	void				GetXML( int timeStart, idStr &txt );

	//virtual void		PackStats( idBitMsg &msg ) const;
	//virtual void		UnPackStats( const idBitMsg &msg );
};

// when a player disarms a detpack
class tfStatDetpackDisarm : public tfStat {
public:
						tfStatDetpackDisarm( int time, int playerIndex, int dispOwnerIndex, int timeBeforeDet );

	byte				ownerIndex;
	int					timeLeft;

	void				GetXML( int timeStart, idStr &txt );

	//virtual void		PackStats( idBitMsg &msg ) const;
	//virtual void		UnPackStats( const idBitMsg &msg );
};

// when a player is damaged
class tfStatPlayerDeath : public tfStat {
public:
						tfStatPlayerDeath( int time, idPlayer* victim, const TFDamage &damage );

	
	byte				victimTeam;
	byte				victimClass;

	byte				attackerIndex;
	byte				attackerTeam;
	byte				attackerClass;

	short				damageAmount;
	int					damageDefNum;

	void				GetXML( int timeStart, idStr &txt );

	//virtual void		PackStats( idBitMsg &msg ) const;
	//virtual void		UnPackStats( const idBitMsg &msg );
};

// when a flag is taken
class tfStatFlagGrab : public tfStat {
public:
						tfStatFlagGrab( int time, int playerIndex, int playerTeam, TFCarryItem* flag );

	idStr				flagname;
	byte				flagteam;
	byte				playerTeam;
	float				distFromStart;

	void				GetXML( int timeStart, idStr &txt );

	//virtual void		PackStats( idBitMsg &msg ) const;
	//virtual void		UnPackStats( const idBitMsg &msg );
};

// when a flag is dropped
class tfStatFlagDrop : public tfStat {
public:
						tfStatFlagDrop( int time, int playerIndex, int playerTeam, TFCarryItem* flag, TFDamage* dmg = NULL );		// if dropped with dropflag, dmg is null

	idStr				flagname;
	byte				flagteam;
	byte				playerTeam;
	byte				attackerIndex;
	byte				attackerTeam;

	bool				death;

	float				carriedDistance;

	void				GetXML( int timeStart, idStr &txt );

	//virtual void		PackStats( idBitMsg &msg ) const;
	//virtual void		UnPackStats( const idBitMsg &msg );
};

// when a flag is captured
class tfStatFlagCapture : public tfStat {
public:
						tfStatFlagCapture( int time, int playerIndex, int playerTeam, TFCarryItem* flag, short* teamScores );

	idStr				flagname;
	byte				flagteam;
	byte				playerTeam;
	float				carriedDistance;
	short				scorePerTeam[TEAM_COUNT];

	void				GetXML( int timeStart, idStr &txt );

	//virtual void		PackStats( idBitMsg &msg ) const;
	//virtual void		UnPackStats( const idBitMsg &msg );
};

#endif