/*
===================================================================================

	A class that handles game rules related to TF, such as class names/abilities,
	class changing, requirements for building, etc...

===================================================================================
*/

#ifndef __TFGame_H__
#define __TFGame_H__

#include "../Game_local.h"

class q4fMapInfo;
class q4fPlayerStart;

#define MAX_PIPES_PER_TEAM 8
#define MAX_PIPES_PER_PLAYER 6

typedef enum {
	AFFL_NONE				= 0,
	AFFL_FLASH				= BIT( 0 ),
	AFFL_CONC				= BIT( 1 ),
	AFFL_INFECTION			= BIT( 2 ),
	AFFL_FIRE				= BIT( 3 ),
	AFFL_HALLUCINATE		= BIT( 4 ),
	AFFL_TRANQ				= BIT( 5 ),
	AFFL_NOAIR				= BIT( 6 ),
} afflType_t;

const int AFFL_COUNT = 7;

const int ASYNC_AFFL_BITS = idMath::BitsForInteger( 1 << 6 );

class TFTeam {
public:
	friend class			TFGame;

							TFTeam( void );

	bool					IsFull( void );

	int						GetMaxPlayers( void ) { return maxPlayers; };

	int						GetClassLimit( int classNum ) { return classLimits[classNum]; };

	const char*				GetName( void ) { return name.c_str(); };
	void					GetColor( idVec3 &color ) { color = this->color; };

	int						GetNumPlayers( int classCounts[CLASS_COUNT] = NULL );

	int						GetTeamNum( void ) { return teamNum; };

protected:
	int						maxPlayers;
	idStr					name;
	idVec3					color;

	int						classLimits[CLASS_COUNT];

	int						teamNum;
};

// attackerInfo
class AttackerInfo {
public:
								AttackerInfo( void ) { attacker = NULL; attackerTeam = -1; attackerClass = -1; };
								AttackerInfo( idEntity* attacker ) { this->attacker = NULL; attackerTeam = -1; attackerClass = -1; Create( attacker ); };

	void						Create( idEntity* attacker );
	void						Create( const AttackerInfo &otherInfo );

	idEntity*					GetEntity( void ) const { return attacker.GetEntity(); };
	idPlayer*					GetPlayer( void ) const;
	int							GetSpawnId( void ) const { return attacker.GetSpawnId(); };
	void						SetSpawnId( int id );
	int							GetTeam( void ) const { return attackerTeam; };
	int							GetClass( void ) const { return attackerClass; };

	AttackerInfo &				operator=( const AttackerInfo &otherInfo );

protected:
	idEntityPtr<idEntity>		attacker;
	int							attackerTeam;
	int							attackerClass;
};

ID_INLINE void AttackerInfo::SetSpawnId( int id ) {
	attacker.SetSpawnId( id );
	Create( attacker.GetEntity() );
}

ID_INLINE AttackerInfo& AttackerInfo::operator=( const AttackerInfo &otherInfo ) {
	Create( otherInfo );
	return *this;
}

ID_INLINE void AttackerInfo::Create( const AttackerInfo &otherInfo ) {
	attacker.SetSpawnId( otherInfo.attacker.GetSpawnId() );
	attackerTeam = otherInfo.attackerTeam;
	attackerClass = otherInfo.attackerClass;
}


class TFDamage {
public:
							TFDamage( void );

	void					Create( const TFDamage &otherDamage );
	void					Create( const AttackerInfo &attInfo, const char* damageDefName, float scaleDamage = 1.0000f );
	void					Create( const AttackerInfo &attInfo, const idDeclEntityDef* damageDef, float scaleDamage = 1.0000f );

	const AttackerInfo &	GetAttacker( void )  const { return attacker; };
	void					SetAttacker( const AttackerInfo &attInfo ) { attacker = attInfo; };

	float					GetDamageScale( void ) const { return damageScale; };
	void					SetDamageScale( float newScale ) { damageScale = newScale; };

	int						GetDamage( void ) const { return damage * damageScale; };
	void					SetDamage( int dmg ) { damage = dmg; };

	const idDeclEntityDef*	GetDamageDef( void ) const;
	const idDict*			GetDamageDict( void ) const;

	const idVec3 &			GetDir( void ) const { return dir; };
	void					SetDir( const idVec3 &dir ) { this->dir = dir; };

	int						GetLocation( void ) const { return location; };
	void					SetLocation( int newloc ) { location = newloc; };

	bool					HasAffliction( void )  const { return affl != AFFL_NONE; };
	afflType_t				GetAffliction( void ) const { return affl; };

	bool					IsValid( void ) const { return isValid; };

	bool					countForAccuracy;
	bool					doAffliction;

	void					Clear() { isValid = false; };

protected:

	void					Init();

	AttackerInfo			attacker;

	afflType_t				affl;

	int						damage;
	float					damageScale;

	idVec3					dir;
	int						location;

	const idDeclEntityDef*	damageDef;

	bool					isValid;
};

ID_INLINE void TFDamage::Create( const TFDamage &otherDamage ) {
	attacker = otherDamage.attacker;

	dir = otherDamage.dir;
	location = otherDamage.location;
	damageDef = otherDamage.damageDef;
	damage = otherDamage.damage;
	affl = otherDamage.affl;
	doAffliction = otherDamage.doAffliction;
	countForAccuracy = otherDamage.countForAccuracy;
	damageScale = otherDamage.damageScale;
	isValid = otherDamage.isValid;
}

ID_INLINE const idDeclEntityDef* TFDamage::GetDamageDef() const {
	assert( damageDef != NULL );

	return damageDef;
}

ID_INLINE const idDict* TFDamage::GetDamageDict() const {
	assert( damageDef != NULL );

	return &damageDef->dict;
}







typedef struct sniperDot_s {
	int					clientNum;
	rvClientEffect*		effect;
	idVec3				origin;
	idVec3				dir;
} sniperDot_t;

typedef enum {
	DISGUISE_TEAM,
	DISGUISE_CLASS
} disguiseType_t;

class TFGame {

public:

							TFGame( void );

	void					Startup( void );
	void					ShutDown( void );
	void					Clear( void );

	void					Run( void );

	void					SendInitialState( int clientNum );

	void					InitFromMapInfo( q4fMapInfo &mapinfo ); 	

	const char*				GetClassName( int classNum, bool shortName = false );
	const char*				GetClassConfig( int classNum);
	const idDeclEntityDef*	GetClassEntDef( int classNum );

	void					ChangeClassRequest( int clientNum, int classNum );			// processes a request to change classes
	bool					AllowClassChange( bool checkCurrentPCs, idPlayer* player, int classNum, msg_evt_t* msg = NULL );

	bool					AllowBuild( idPlayer* player, ENTDEF def, bool sendMessage = true );
	void					BuildRequest( const char *entName, int clientNum, const idDict *extraArgs = NULL, idVec3* pos = NULL, float rotation = 0.0f );
	void					StartPreview( ENTDEF entDef );
	void					StopPreview( void );

	void					DisguiseRequest( int clientNum, disguiseType_t type, int num );

	void					ScaleTeamDamage( idEntity* p1, idEntity* p2, int* healthloss, int* armorloss );	// scales damage based on server team settings
	float					ScaleTeamAffliction( idEntity* p1, idEntity* p2 );

	void					WriteToSnapshot( idBitMsgDelta &msg ) const;
	void					ReadFromSnapshot( const idBitMsgDelta &msg );

	TFTeam*					GetTeam( const char* teamName );
	TFTeam*					GetTeam( int teamNum );					// teamnum is in the range 0 < TEAM_COUNT
	int						GetTeamCount( void ) { return teamCount; };

	void					UpdateTeamColors( bool justUpdateEntities = false, bool justPlayers = false );

	idVec3&					GetTeamColor( int team );

	const char*				GetTeamEscapeColor( int team );

	int						GetTeamNumFromString( const char* teamstring );
	int						GetClassNumFromString( const char* classstring );

	static const void		ExtractChatMessage( const char* txt, idStr &outMsg, int &outSoundShaderIndex );


	ENTDEF					PlayerClassDefs[CLASS_COUNT];

private:
	void					LoadClassDefs( void );
	void					LoadInitialImpulses( void );

	
	bool					defsLoaded;

	idVec3					teamColors[TEAM_COUNT];

	TFTeam					teams[TEAM_COUNT];

	idVec3					vec3_one;

	int						teamCount;
};

ID_INLINE idVec3& TFGame::GetTeamColor( int team ) {
	if ( team >= 0 && team < teamCount ) {
		return teamColors[ team ];
	}

	return vec3_one;
}

ID_INLINE const char* TFGame::GetTeamEscapeColor( int team ) {
	idVec3 color = GetTeamColor( team );
	return va( "^c%d%d%d", (int)(color.x * 9), (int)(color.y * 9), (int)(color.z * 9) );
}


#endif