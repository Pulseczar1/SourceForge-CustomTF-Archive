#include "../../../idlib/precompiled.h"
#pragma hdrstop

#include "../../Game_local.h"

struct inGameAwardInfo_t inGameAwardInfo[ IGA_NUM_AWARDS ] = {
	//IGA_INVALID
	{ NULL },

	//IGA_CAPTURE
	{ "capture" },

	//IGA_HUMILIATION
	{
		"humiliation"
	},
	//IGA_IMPRESSIVE
	{
		"impressive"
	},
	//IGA_EXCELLENT
	{
		"excellent"
	},
	//IGA_ASSIST
	{
		"assist"
	},
	//IGA_DEFENSE
	{
		"defense"
	},
	//IGA_COMBO_KILL
	{
		"combo_kill"
	},
	//IGA_RAMPAGE
	{
		"rampage"
	},
	//IGA_HOLY_SHIT
	{
		"holy_shit"
	}
};

/*
===================================================================================
	Player Stats
===================================================================================
*/

//int ASYNC_STAT_TYPE_BITS = idMath::BitsForInteger( STAT_COUNT );

void TFPlayerStats::Init( int spawnID, int statIndex, const char* guid ) {
	Clear();

	statsIndex = statIndex;

	this->guid				= guid;

	player.SetSpawnId( spawnID );
	this->spawnID = spawnID;

	assert( player.GetEntity() && player.GetEntity()->IsType( idPlayer::GetClassType() ) );
}

void TFPlayerStats::Clear() {
	player		= NULL;
	spawnID		= 0;
	statsIndex	= -1;

	lastKnownTeam = INVALID_TEAM;

	dmgStats.Clear();
	index2dmgStat.Clear( 64, 64 );

	attackStats.Clear();
	group2attackStat.Clear( 32, 32 );

	frags			= 0;
	suicides		= 0;

	flagGrabs		= 0;
	flagSaves		= 0;
	flagCaptures	= 0;
	flagDrops		= 0;

	score			= 0;

	sentryBuildCount	= 0;
	sentryKillCount		= 0;

	dispenserBuildCount	= 0;
	dispenserKillCount	= 0;

	playTime = 0;
	playStartTime = -1;

	guid.Clear();
	lastKnownName.Clear();
	lastKnownClan.Clear();
	inGame = false;

	awardQueue.Clear();
	memset( awardCounts, 0, sizeof( int ) * (int)IGA_NUM_AWARDS );

	memset( &totalDamage, 0, sizeof( totalDamage ) );
}

dmgStat_t* TFPlayerStats::AddDmgStat( int defIndex ) {
	ENTDEF def = static_cast<ENTDEF>( declManager->DeclByIndex( DECL_ENTITYDEF, defIndex ) );
	return AddDmgStat( def );
}

dmgStat_t* TFPlayerStats::AddDmgStat( ENTDEF damageDef ) {
	if ( !damageDef ) {
		//gameLocal.Error( "AddDmgStat - damageDef is null." );
		return NULL;
	}

	// in case we already exist
	dmgStat_t* stat = GetDmgStat( damageDef );

	if ( !stat ) {
		stat = &( dmgStats.Alloc() );

		memset( stat, 0, sizeof( *stat ) );
		
		stat->dmgDef = damageDef;

		index2dmgStat.Add( index2dmgStat.GenerateKey( damageDef->Index(), damageDef->Index() ), dmgStats.Num() - 1 );
	}

	return stat;
}

attackStat_t* TFPlayerStats::AddAttackStat( ENTDEF attackDef ) {
	if ( !attackDef ) {
		//gameLocal.Error( "AddAttackStat - attackDef is null." );
		return NULL;
	}
	return AddAttackStat( attackDef->dict.GetString( "stat_group" ) );
}

attackStat_t* TFPlayerStats::AddAttackStat( const char* stat_group) {
	if ( !stat_group || !stat_group[0] ) {
		//gameLocal.Error( "AddAttackStat - stat_group is null or empty." );
		return NULL;
	}

	// in case we already exist
	attackStat_t* stat = GetAttackStat( stat_group );

	if ( !stat ) {
		stat = &( attackStats.Alloc() );

		stat->shotsFired		= 0;
		stat->stat_group		= stat_group;

		memset( &(stat->totalDamage), 0, sizeof( stat->totalDamage ) );

		group2attackStat.Add( group2attackStat.GenerateKey( stat_group, false ), attackStats.Num() - 1 );
	}

	return stat;
}

void TFPlayerStats::GetXML( int myIndex, idStr &txt ) const {
	static const char* headerFormat = "\t\t<Player id=\"%d\" name=\"%s\" clan=\"%s\" team=\"%d\" playtime=\"%d\" guid=\"%s\" score=\"%d\" frags=\"%d\" kills=\"%d\" teamkills=\"%d\" deaths=\"%d\" teamdeaths=\"%d\" suicides=\"%d\" flaggrabs=\"%d\" flagdrops=\"%d\" flagcaptures=\"%d\" flagsaves=\"%d\">\r\n";
	static const char* attFormat = "\t\t\t<Attack group=\"%s\" shotsfired=\"%d\" hitsToEnemy=\"%d\" hitsToTeam=\"%d\" hitsFromEnemy=\"%d\" hitsFromTeam=\"%d\" hitsFromSelf=\"%d\">\r\n";
	static const char* dmgFormat = "\t\t\t\t<Damage type=\"%s\" hitsToEnemy=\"%d\" hitsToTeam=\"%d\" hitsFromEnemy=\"%d\" hitsFromTeam=\"%d\" hitsFromSelf=\"%d\" killsEnemy=\"%d\" killsTeam=\"%d\" killsSelf=\"%d\" deathsEnemy=\"%d\" deathsTeam=\"%d\" damageToEnemy=\"%d\" damageToTeam=\"%d\" damageFromEnemy=\"%d\" damageFromTeam=\"%d\" damageFromSelf=\"%d\" />\r\n";

	idList<const dmgStat_t*> dmgList;
	txt.Clear();

	const dmgStat_t* dmgStat;

	int hitsToEnemy, hitsToTeam, hitsFromEnemy, hitsFromTeam, hitsFromSelf;

	txt = va( headerFormat, myIndex, lastKnownName.c_str(), lastKnownClan.c_str(), lastKnownTeam + 1, GetPlayTime(), guid.c_str(), score, frags, StatKillsEnemy(), StatKillsTeam(), StatDeathsEnemy(), StatDeathsTeam(), StatKillsSelf(), flagGrabs, flagDrops, flagCaptures, flagSaves );

	int i, j;
	for ( i = 0; i < attackStats.Num(); i++ ) {

		tfStatManager->GetDamageList( this, attackStats[i].stat_group.c_str(), dmgList );

		hitsToEnemy = hitsToTeam = hitsFromEnemy = hitsFromTeam = hitsFromSelf = 0;

		for ( j = 0; j < dmgList.Num(); j++ ) {
			hitsToEnemy += dmgList[j]->hitsToEnemy;
			hitsToTeam += dmgList[j]->hitsToTeam;
			hitsFromEnemy += dmgList[j]->hitsFromEnemy;
			hitsFromTeam += dmgList[j]->hitsFromTeam;
			hitsFromSelf += dmgList[j]->hitsFromSelf;
		}

		txt.Append( va( attFormat, attackStats[i].stat_group.c_str(), attackStats[i].shotsFired, hitsToEnemy, hitsToTeam, hitsFromEnemy, hitsFromTeam, hitsFromSelf ) );
		
		for ( j = 0; j < dmgList.Num(); j++ ) {
			dmgStat = dmgList[j];
			txt.Append( va( dmgFormat, dmgStat->dmgDef->dict.GetString( "stat_type", "" )
				, dmgStat->hitsToEnemy
				, dmgStat->hitsToTeam
				, dmgStat->hitsFromEnemy
				, dmgStat->hitsFromTeam
				, dmgStat->hitsFromSelf
				, dmgStat->killsEnemy
				, dmgStat->killsTeam
				, dmgStat->killsSelf
				, dmgStat->deathsEnemy
				, dmgStat->deathsTeam
				, dmgStat->damageToEnemy
				, dmgStat->damageToTeam
				, dmgStat->damageFromEnemy
				, dmgStat->damageFromTeam
				, dmgStat->damageFromSelf ) );
		}

		txt.Append( "\t\t\t</Attack>\r\n" );
	}

	txt.Append( "\t\t</Player>\r\n" );
}

int TFPlayerStats::GetPlayTime( void ) const {
	if ( playStartTime >= 0 ) {
		return ( gameLocal.time - playStartTime ) + playTime;
	}

	return playTime;
}
















TFStatManager	tfStatManagerLocal;
TFStatManager*	tfStatManager = &tfStatManagerLocal;

TFStatManager::TFStatManager() {
}

void TFStatManager::Init() {
	ShutDown();

	lastStatsRequestTime = 0;
	roundInProgress = false;
    
	statQueue.SetGranularity( 1024 );

	memset( &teamScores, 0, sizeof( teamScores ) );
}

void TFStatManager::ShutDown() {

	qqq ( "--- Stat Manager Shutdown ---" );

	ClearRound();
	ClearPlayers();

	qqq ( "--------------------------" );
}

void TFStatManager::ClearPlayers() {
	qqq( "TFStatManager::ClearPlayers" );

	memset( client2index, -1, sizeof( client2index ) );

	spawnIdHash.Clear();

	playerStats.Clear();
}

void TFStatManager::ClearRound() {
	qqq( "TFStatManager::ClearRound()" );

	roundInProgress = false;

	statQueue.DeleteContents( true );

	for ( int i = 0; i < playerStats.Num(); i++ ) {
		playerStats[i].dmgStats.Clear();
		playerStats[i].index2dmgStat.Clear();
		playerStats[i].attackStats.Clear();
		playerStats[i].group2attackStat.Clear();
		memset( &(playerStats[i].totalDamage), 0, sizeof( playerStats[i].totalDamage ) );
		playerStats[i].dispenserBuildCount = 0;
		playerStats[i].dispenserKillCount = 0;
		playerStats[i].flagCaptures = 0;
		playerStats[i].flagDrops = 0;
		playerStats[i].flagGrabs = 0;
		playerStats[i].flagSaves = 0;
		playerStats[i].frags = 0;
		playerStats[i].score = 0;
		playerStats[i].sentryBuildCount = 0;
		playerStats[i].sentryKillCount = 0;
		playerStats[i].suicides = 0;
		playerStats[i].awardQueue.Clear();
		memset( playerStats[i].awardCounts, 0, sizeof( int ) * (int)IGA_NUM_AWARDS );
	}

	memset ( teamScores, 0, sizeof( teamScores ) );

	statQueue.Clear();
}

void TFStatManager::WriteToSnapshot( idBitMsgDelta &msg ) const {
	for ( int i = 0; i < TEAM_COUNT; i++ ) {
		msg.WriteDeltaShort( 0, teamScores[i] );
	}
}

void TFStatManager::ReadFromSnapshot( const idBitMsgDelta &msg ) {
	for ( int i = 0; i < TEAM_COUNT; i++ ) {
		teamScores[i] = msg.ReadDeltaShort( 0 );
	}
}

void TFStatManager::ClientConnect( idPlayer* player ) {

	if ( gameLocal.isClient ) return;

	assert( player );

	if ( playerStats.Num() >= WORLD_INDEX ) {
		gameLocal.Error( "StatManager: more than 254 unique players have joined the server since this round started. Maybe try resetting the map every once in a while?" );
	}

	// check if this player already has a stat index ( in case someone reconnects )
	int statIndex = -1;
	for ( int i = 0; i < playerStats.Num(); i++ ) {
		if ( !playerStats[i].guid.Icmp( networkSystem->GetClientGUID( player->entityNumber ) ) ) {
			// player already exists, check if it's a duplicate connection
			if ( playerStats[i].inGame ) {
				continue;
			}
			else {
				gameLocal.Printf( "ClientConnect - recycling client GUID %s", playerStats[i].guid.c_str() );
				statIndex = i;
				break;
			}
		}
	}

	int spawnID = gameLocal.GetSpawnId( player );

	// if the player doesn't already have a stat index
	if ( statIndex < 0 ) {

		// create a new stat index
		statIndex = playerStats.Num();
		TFPlayerStats* newPStat = &( playerStats.Alloc() );
		newPStat->Init( spawnID, statIndex, networkSystem->GetClientGUID( player->entityNumber ) );
	}

	playerStats[statIndex].player = player;
	playerStats[statIndex].spawnID = spawnID;
	playerStats[statIndex].lastKnownName = "no-name-yet";
	playerStats[statIndex].lastKnownClan = "no-clan-yet";
	playerStats[statIndex].inGame = true;

	spawnIdHash.Add( spawnIdHash.GenerateKey( spawnID, spawnID ), statIndex );

	// update our client2index array
	client2index[ player->entityNumber ] = statIndex;

	// add to queue
	//tfStatClientConnect* stat = new tfStatClientConnect( gameLocal.time, statIndex );
	//statQueue.Append( stat );
}

void TFStatManager::ClientDisconnect( int clientNum ) {
	if ( gameLocal.isClient ) return;

	assert( clientNum >= 0 && clientNum < MAX_CLIENTS );

	TFPlayerStats* stat = GetPlayerStatsClientNum( clientNum );

	if ( !stat ) {
		gameLocal.Warning( "Stats: ClientDisconnect: could not find stats for client %d", clientNum );
		client2index[ clientNum ] = -1;
		return;
	}

	if ( stat->playStartTime >= 0 ) {
		stat->playTime += ( gameLocal.time - stat->playStartTime );
		stat->playStartTime = -1;
	}

	// update our client2index array
	client2index[ clientNum ] = -1;

	stat->spawnID = stat->player.GetSpawnId();
	stat->inGame = false;
	stat->player = NULL;
	//stat->lastKnownName = gameLocal.userInfo[ clientNum ].GetString( "ui_name" );

	// add to queue
	//tfStatClientDisconnect* stat = new tfStatClientDisconnect( gameLocal.time, playerIndex );
	//statQueue.Append( stat );
}

void TFStatManager::PlayerChangeTeam( idPlayer* player, int oldTeam, int newTeam ) {
	if ( gameLocal.isClient || !roundInProgress ) return;

	TFPlayerStats* stat = GetPlayerStatsPlayer( player );

	if ( !stat )
		return;

	stat->lastKnownTeam = newTeam;
}

void TFStatManager::PlayerChangeClass( idPlayer* player, int oldClass, int newClass ) {
	if ( gameLocal.isClient || !roundInProgress ) return;

	TFPlayerStats* stat = GetPlayerStatsPlayer( player );

	if ( !stat )
		return;

	if ( oldClass != INVALID_CLASS && newClass == INVALID_CLASS ) {
		stat->playTime += ( gameLocal.time - stat->playStartTime );
		stat->playStartTime = -1;
	}
	else if ( oldClass == INVALID_CLASS && newClass != INVALID_CLASS ) {
		stat->playStartTime = gameLocal.time;
	}
}


void TFStatManager::RoundStart( const char* mapName ) {
	if ( gameLocal.isClient ) return;

	if ( roundInProgress ) {
		gameLocal.Warning( "TFStatManager::RoundStart called while a round is in progress." );
		return;
	}

	qqq( "----- StatManager Round Start -----" );
	
	// clear our smack when loading new rounds
	ClearRound();

	roundInProgress = true;

	// get date information
	struct tm *newtime;
	time_t aclock;
	time( &aclock );
	newtime = localtime( &aclock );

	// YEAR MONTH DAY HOUR MINUTE SECOND
	const char* timeStr = va( "%4d-%02d-%02d-%02d-%02d-%02d",	newtime->tm_year + 1900, 
																newtime->tm_mon + 1,
																newtime->tm_mday,
																newtime->tm_hour,
																newtime->tm_min,
																newtime->tm_sec );

	time_t epoch = time( NULL );
	int seconds = epoch;


	// build a list of player counts for all teams
	int playerCounts[TEAM_COUNT];
	memset( &playerCounts, 0, sizeof( playerCounts ) );

	for ( int i = 0; i < tfGame.GetTeamCount(); i++ ) {
		playerCounts[i] = tfGame.GetTeam( i )->GetNumPlayers();
	}

	TFPlayerStats* stat;
	for ( int i = 0; i < gameLocal.numClients; i++ ) {
		stat = GetPlayerStatsClientNum( i );
		if ( stat ) {
			stat->playStartTime = gameLocal.time;
			stat->playTime = 0;
		}
	}

	// our very first queue entry will be round start
	tfStatRoundStart* newStat = new tfStatRoundStart( gameLocal.time, mapName, timeStr, seconds, playerCounts );
	statQueue.Append( newStat );

	qqq( "----------------------------" );
}

void TFStatManager::RoundEnd() {
	if ( gameLocal.isClient ) return;

	if ( !roundInProgress ) {
		gameLocal.Warning( "TFStatManager::RoundEnd called while a round isn't in progress." );
		return;
	}

	qqq( "----- StatManager Round End -----" );

	roundInProgress = false;

	// build a list of player counts for all teams
	int playerCounts[TEAM_COUNT];
	memset( &playerCounts, 0, sizeof( playerCounts ) );

	for ( int i = 0; i < tfGame.GetTeamCount(); i++ ) {
		playerCounts[i] = tfGame.GetTeam( i )->GetNumPlayers();
	}

	TFPlayerStats* stat;
	for ( int i = 0; i < gameLocal.numClients; i++ ) {
		stat = GetPlayerStatsClientNum( i );
		if ( stat && stat->playStartTime >= 0 ) {
			stat->playTime += ( gameLocal.time - stat->playStartTime );
			stat->playStartTime = -1;
		}
	}

	tfStatRoundEnd* newStat = new tfStatRoundEnd( gameLocal.time, playerCounts, teamScores );
	statQueue.Append( newStat );

	DistributeStats();
	WriteStatsXML();

	qqq( "----------------------------" );
}

void TFStatManager::ShotFired( const AttackerInfo &attacker, ENTDEF attackDef ) {
	if ( gameLocal.isClient || !attackDef || !roundInProgress ) return;

	TFPlayerStats* stats = GetPlayerStatsSpawnID( attacker.GetSpawnId() );

	if ( !stats )
		return;

	// the player stat will automatically check if the damage already exists
	attackStat_t* attStat = stats->AddAttackStat( attackDef );

	if ( attStat )
		attStat->shotsFired++;
}

// now for the hard part
void TFStatManager::EntityDamaged( idEntity* victim, const TFDamage &dmg, bool death ) {
	if ( gameLocal.isClient || !roundInProgress || !victim || ( victim->health <= 0 && !death ) ) return;

	TFPlayerStats*	attackerStats = NULL;
	idPlayer*		attackerPlayer = NULL;

	TFPlayerStats*	victimStats = NULL;
	idPlayer*		victimPlayer = NULL;

	idEntity* attacker			= dmg.GetAttacker().GetEntity();

	int damage					= dmg.GetDamage();
	
	ENTDEF dmgDef				= dmg.GetDamageDef();
	int dmgIndex				= dmgDef->Index();

	const char* stat_type = dmgDef->dict.GetString( "stat_type", "" );
	const char* stat_group = dmgDef->dict.GetString( "stat_group", "" );

	int vicTeam = victim->team;
	int attTeam = dmg.GetAttacker().GetTeam();
	

	if ( attacker && attacker->IsType( idPlayer::GetClassType() ) ) {
		attackerPlayer = static_cast<idPlayer*>( attacker );
	}
	attackerStats = GetPlayerStatsSpawnID( dmg.GetAttacker().GetSpawnId() );

	if ( victim->IsType( idPlayer::GetClassType() ) ) {
		victimPlayer = static_cast<idPlayer*>( victim );
		victimStats = GetPlayerStatsPlayer( victimPlayer );
	}

	// handle victim stats
	if ( victimStats ) {

		if ( death ) {
			tfStatPlayerDeath* newStat = new tfStatPlayerDeath( gameLocal.time, victimPlayer, dmg );
			statQueue.Append( newStat );
			PrintDeathMsg( attackerPlayer ? attackerPlayer->entityNumber : MAX_CLIENTS, victimPlayer ? victimPlayer->entityNumber : MAX_CLIENTS, dmgIndex );
		}

		// IF DAMAGED FROM NON-PLAYER
		if ( !attackerStats ) {
			if ( death ) {
				victimStats->suicides++;
				victimStats->frags--;
				victimStats->totalDamage.killsSelf++;
			}
			return;
		}

		// IF HURTING SELF
		else if ( victimStats == attackerStats ) {

			if ( death ) {
				victimStats->suicides++;
				victimStats->frags--;
				victimStats->totalDamage.killsSelf++;
			}
			
			if ( stat_type && stat_type[0] && stat_group && stat_group[0] ) {
				dmgStat_t* dmgStat = victimStats->AddDmgStat( dmgDef );
				assert( dmgStat );
				
				attackStat_t* attStat = victimStats->AddAttackStat( stat_group );
				assert( attStat );

				dmgStat->damageFromSelf += damage;
				dmgStat->hitsFromSelf++;

				attStat->totalDamage.damageFromSelf += damage;
				attStat->totalDamage.hitsFromSelf++;

				victimStats->totalDamage.damageFromSelf += damage;
				victimStats->totalDamage.hitsFromSelf++;

				if ( death ) {
					dmgStat->killsSelf++;
					//attStat->totalDamage.killsSelf++;
				}
			}

			return;
		}

		// MUST BE PLAYER VS PLAYER
		else {

			assert( victimStats );			// bogus asserts, as of right now no possible way to get here if both are null
			assert( attackerStats );

			// IF DEATH
			if ( death ) {

				// IF SAME TEAM
				if ( vicTeam == attTeam  ) {
					attackerStats->frags--;
				}
				else {
					attackerStats->frags++;
				}
			}

			if ( stat_type && stat_type[0] && stat_group && stat_group[0] ) {

				dmgStat_t* vicDmgStat = victimStats->AddDmgStat( dmgDef );
				assert( vicDmgStat );

				dmgStat_t* attDmgStat = attackerStats->AddDmgStat( dmgDef );
				assert( attDmgStat );

				attackStat_t* vicAttStat = victimStats->AddAttackStat( stat_group );
				assert( vicAttStat );

				attackStat_t* attAttStat = attackerStats->AddAttackStat( stat_group );
				assert( attAttStat );

				// if team damage
				if ( vicTeam == attTeam ) {
					vicDmgStat->damageFromTeam += damage;
					vicDmgStat->hitsFromTeam++;
					vicAttStat->totalDamage.damageFromTeam += damage;
					vicAttStat->totalDamage.hitsFromTeam++;
					victimStats->totalDamage.damageFromTeam += damage;
					victimStats->totalDamage.hitsFromTeam++;

					attDmgStat->damageToTeam += damage;
					attDmgStat->hitsToTeam++;
					attAttStat->totalDamage.damageToTeam += damage;
					attAttStat->totalDamage.hitsToTeam++;
					attackerStats->totalDamage.damageToTeam += damage;
					attackerStats->totalDamage.hitsToTeam++;

					if ( death ) {
						vicDmgStat->deathsTeam++;
						vicAttStat->totalDamage.deathsTeam++;
						victimStats->totalDamage.deathsTeam++;

						attDmgStat->killsTeam++;
						attAttStat->totalDamage.killsTeam++;
						attackerStats->totalDamage.killsTeam++;
					}
				}

				// normal enemy vs enemy
				else {
					vicDmgStat->damageFromEnemy += damage;
					vicDmgStat->hitsFromEnemy++;
					vicAttStat->totalDamage.damageFromEnemy += damage;
					vicAttStat->totalDamage.hitsFromEnemy++;
					victimStats->totalDamage.damageFromEnemy += damage;
					victimStats->totalDamage.hitsFromEnemy++;

					attDmgStat->damageToEnemy += damage;
					attDmgStat->hitsToEnemy++;
					attAttStat->totalDamage.damageToEnemy += damage;
					attAttStat->totalDamage.hitsToEnemy++;
					attackerStats->totalDamage.damageToEnemy += damage;
					attackerStats->totalDamage.hitsToEnemy++;

					if ( death ) {
						vicDmgStat->deathsEnemy++;
						vicAttStat->totalDamage.deathsEnemy++;
						victimStats->totalDamage.deathsEnemy++;

						attDmgStat->killsEnemy++;
						attAttStat->totalDamage.killsEnemy++;
						attackerStats->totalDamage.killsEnemy++;
					}
				}
			}
		}


		return;
	}

	if ( !attackerStats )
		return;

	// victim is not a player, handle attacker player stats
	// 3j_todo: check for sentries & disps here?

	if ( death ) {
		if ( vicTeam == attTeam ) {
			attackerStats->frags--;
		}
		else {
			attackerStats->frags++;
		}
	}

	if ( stat_type && stat_type[0] && stat_group && stat_group[0]  ) {

		dmgStat_t* dmgStat = attackerStats->AddDmgStat( dmgDef );
		assert( dmgStat );

		attackStat_t* attStat = attackerStats->AddAttackStat( stat_group );
		assert( attStat );

		if ( vicTeam == attTeam ) {
			dmgStat->hitsToTeam++;
			dmgStat->damageToTeam += damage;

			attStat->totalDamage.hitsToTeam++;
			attStat->totalDamage.damageToTeam += damage;

			attackerStats->totalDamage.hitsToTeam++;
			attackerStats->totalDamage.damageToTeam += damage;
			
			/*if ( death ) {
				dmgStat->killsTeam++;
			}*/
		}
		else {
			dmgStat->hitsToEnemy++;
			dmgStat->damageToEnemy += damage;

			attStat->totalDamage.hitsToEnemy++;
			attStat->totalDamage.damageToEnemy += damage;

			attackerStats->totalDamage.hitsToEnemy++;
			attackerStats->totalDamage.damageToEnemy += damage;
			
			/*if ( death ) {
				dmgStat->killsEnemy++;
			}*/
		}
	}
}

void TFStatManager::FlagGrab( TFCarryItem* flag, idPlayer* stealer ) {

	if ( gameLocal.isClient || !roundInProgress || !flag ) return;

	TFPlayerStats* stealerStats = GetPlayerStatsPlayer( stealer );
	if ( stealerStats /*&& !flag->GetCarrierNum( 0 )*/ )
		stealerStats->flagGrabs++;

	tfStatFlagGrab* newStat = new tfStatFlagGrab( gameLocal.time, stealerStats ? stealerStats->statsIndex : -1, stealer ? stealer->team : INVALID_TEAM, flag );
	statQueue.Append( newStat );
}

void TFStatManager::FlagDrop( TFCarryItem* flag, idPlayer* carrier, TFDamage* dmg ) {
	if ( gameLocal.isClient || !flag || !roundInProgress ) return;

	int flagTeam = flag->team;
	int carrierTeam = carrier ? carrier->team : INVALID_TEAM;
	int attackerTeam = dmg ? dmg->GetAttacker().GetTeam() : INVALID_TEAM;

	TFPlayerStats* carrierStats = GetPlayerStatsPlayer( carrier);
	if ( carrierStats /*&& dmg*/ ) {
		carrierStats->flagDrops++;
	}

	tfStatFlagDrop* newStat = new tfStatFlagDrop( gameLocal.time, carrierStats ? carrierStats->statsIndex : -1, carrierTeam, flag, dmg );
	statQueue.Append( newStat );

	if ( attackerTeam == flagTeam && dmg && attackerTeam != carrierTeam ) {
		TFPlayerStats* attackerStats = GetPlayerStatsSpawnID( dmg->GetAttacker().GetSpawnId() );

		if ( attackerStats && attackerStats != carrierStats ) {
			attackerStats->flagSaves++;
			attackerStats->score += 2;
		}
	}
}

void TFStatManager::FlagCapture( TFCarryItem* flag, idPlayer* carrier ) {
	if ( gameLocal.isClient || !roundInProgress ) return;

	TFPlayerStats* carrierStats = GetPlayerStatsPlayer( carrier);
	if ( carrierStats ) {
		carrierStats->flagCaptures++;
	}

	tfStatFlagCapture* newStat = new tfStatFlagCapture( gameLocal.time, carrierStats ? carrierStats->statsIndex : -1, carrier ? carrier->team : INVALID_TEAM, flag, teamScores );
	statQueue.Append( newStat );
}

void TFStatManager::SentryKilled( const SentryGun* sentry, const TFDamage &damage ) {
	if ( gameLocal.isClient || !roundInProgress || !sentry ) return;

	idPlayer* owner = sentry->GetOwner();
	TFPlayerStats* ownerStats = GetPlayerStatsPlayer( owner );

	TFPlayerStats*  attackerStats = GetPlayerStatsSpawnID( damage.GetAttacker().GetSpawnId() );

	if ( attackerStats ) {
		attackerStats->sentryKillCount++;
	}

	tfStatSentryKill* newStat = new tfStatSentryKill( gameLocal.time, attackerStats ? attackerStats->statsIndex : -1, damage.GetAttacker().GetTeam(), ownerStats ? ownerStats->statsIndex : -1, owner ? owner->team : INVALID_TEAM, sentry->GetLevel() );
	statQueue.Append( newStat );
}

void TFStatManager::DispenserKilled( Dispenser* dispenser, TFDamage &damage ) {
	if ( gameLocal.isClient || !roundInProgress || !dispenser ) return;

	idPlayer* owner = dispenser->GetOwner();
	TFPlayerStats* ownerStats = GetPlayerStatsPlayer( owner );

	TFPlayerStats* attackerStats = GetPlayerStatsSpawnID( damage.GetAttacker().GetSpawnId() );

	if ( attackerStats ) {
		attackerStats->dispenserKillCount++;
	}

	tfStatDispenserKill* newStat = new tfStatDispenserKill( gameLocal.time, attackerStats ? attackerStats->statsIndex : -1, damage.GetAttacker().GetTeam(), ownerStats ? ownerStats->statsIndex : -1, owner ? owner->team : INVALID_TEAM );
	statQueue.Append( newStat );
}

//--------------------------------------------------------------------------
// Print a death message to all the players
//--------------------------------------------------------------------------
void TFStatManager::PrintDeathMsg( int attackerIndex, int victimIndex, int dmgDefNum ) const {

	if( !gameLocal.isClient ) {
		idBitMsg outMsg;
		byte msgBuf[1024];
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_DEATH_TF );
		outMsg.WriteBits( attackerIndex, ASYNC_MAX_CLIENT_BITS );
		outMsg.WriteBits( victimIndex, ASYNC_MAX_CLIENT_BITS );
		outMsg.WriteBits( dmgDefNum, gameLocal.entityDefBits );
		networkSystem->ServerSendReliableMessage( -1, outMsg );	
	}

	idPlayer* local = gameLocal.GetLocalPlayer();

	if( local == NULL ) {
		return;
	}

	idDeclEntityDef* damageDef = (idDeclEntityDef*)declManager->DeclByIndex( DECL_ENTITYDEF, dmgDefNum, false );

	if ( !damageDef ) {
		gameLocal.Warning( "TFStatManager::PrintDeathMsg: unable to acquire damage def.\r\n" );
		return;
	}

	idStr		attackerName = "";
	idStr		victimName = "";
	idStr		attackTeamColor = S_COLOR_WHITE;
	idStr		vicTeamColor = S_COLOR_WHITE;

	idPlayer* attacker = NULL;
	idPlayer* victim = NULL;

	if ( attackerIndex >= 0 && attackerIndex < gameLocal.numClients )
		attacker = GET_PLAYER( attackerIndex );

	if ( victimIndex >= 0 && victimIndex < gameLocal.numClients )
		victim = GET_PLAYER( victimIndex );

	if ( attacker ) {
		attackerName = attacker->uiName;
		attackTeamColor = tfGame.GetTeamEscapeColor( attacker->team );
	}

	if ( victim ) {
		victimName = victim->uiName;
		vicTeamColor = tfGame.GetTeamEscapeColor( victim->team );
	}

	// echo to console
	idStr deathmsg = damageDef->dict.GetString( "deathmsg", "%v was killed by %k" );

	if ( victim == attacker ) {
		deathmsg = damageDef->dict.GetString( "deathmsg_self", deathmsg.c_str() );
	}

	attackerName.RemoveEscapes();
	victimName.RemoveEscapes();
	attackerName.Insert( attackTeamColor.c_str(), 0 );
	victimName.Insert( vicTeamColor.c_str(), 0 );
	attackerName.Append( "^0" );
	victimName.Append( "^0" );

	deathmsg.Replace( "%v", va( "%s^3", victimName.c_str() ) );
	deathmsg.Replace( "%k", va( "%s^3", attackerName.c_str() ) );
	gameLocal.mpGame.AddChatLine( "^3%s^0", deathmsg.c_str() );

	if( local->mphud ) {
		local->mphud->SetStateString ( "deathinfo",  GetDeathMsg( attackerName.c_str(), victimName.c_str(), damageDef ) );
		local->mphud->HandleNamedEvent ( "addDeathLine" );
	}

	// display message on hud
	if ( attacker && victim && attacker != victim ) {
		if ( local == attacker ) {
			gameLocal.mpGame.PrintCenterMessage( va( common->GetLocalizedString( "#str_107295" ), victimName.c_str() ) );
		}
		else if ( local == victim ) {
			gameLocal.mpGame.PrintCenterMessage( va( common->GetLocalizedString( "#str_107296" ), attackerName.c_str() ) );
		}
	}
}

//--------------------------------------------------------------------------
// Create the quick info death msg ( player icon player )
//--------------------------------------------------------------------------
const char*  TFStatManager::GetDeathMsg( const char* attacker, const char* victim, const idDeclEntityDef* dmgDef ) const {
	assert( attacker && victim && dmgDef );
	return va( "%s ^r^i%s %s", attacker, dmgDef->dict.GetString( "deathicon", "" ), victim );
}


//--------------------------------------------------------------------------
// Add to a player's score
//--------------------------------------------------------------------------
void TFStatManager::AddPlayerScore( int clientNum, int score ) {
	if ( !roundInProgress ) return;

	TFPlayerStats* stats = GetPlayerStatsClientNum( clientNum );

	if ( stats ) {
		stats->score += score;
	}
}


//--------------------------------------------------------------------------
// Add to a team's score
//--------------------------------------------------------------------------
void TFStatManager::AddTeamScore( int team, int score ) {
	if ( !roundInProgress ) return;

	assert( IS_VALID_TEAM( team ) );
	teamScores[team] += score;
}













void TFStatManager::UpdateGUIStats( bool force ) {

	idUserInterface* gui = gameLocal.mpGame.GetMainGui();

	if ( !gui )
		return;

	statsMetricType_t metricType = GetMetricType( gui );
	statsVersusType_t versusType = GetVersusType( gui );

	// get the entity def, if needed

	int defNum = 0;
	if ( metricType == METRIC_ATTACK || metricType == METRIC_DAMAGE ) {
		const char* defName = gui->GetStateString( "stats_defName" );
		if ( !defName || !defName[0] ) {
			gameLocal.Warning( "UpdateGUIStats() - no damage def name specified for an attack or damage stat." );
			return;
		}
		ENTDEF def = gameLocal.FindEntityDef( defName, false );
		if ( !def ) {
			gameLocal.Warning( "UpdateGUIStats() - could not find entity def '%s'", defName );
			return;
		}

		defNum = def->Index();
	}

	// if we're a client, just make a request to there server for all of our stats
	//if ( gameLocal.isClient ) {

		// so we don't flood the server with requests
		if ( /*!force && */gameLocal.time - lastStatsRequestTime < 500 ) {
			gameLocal.Warning( "UpdateGUIStats - trying to change stats too quickly, try again in a sec..." );
			return;
		}

		lastStatsRequestTime = gameLocal.time;

		byte msgBuf[MAX_GAME_MESSAGE_SIZE];
		idBitMsg outMsg;
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_PLAYERSTATS );

		outMsg.WriteBits( metricType, ASYNC_STATS_METRIC_TYPE_BITS );
		outMsg.WriteBits( versusType, ASYNC_STATS_VERSUS_TYPE_BITS );
		
		if ( metricType == METRIC_ATTACK || metricType == METRIC_DAMAGE )
			outMsg.WriteLong( defNum );
		
		networkSystem->ClientSendReliableMessage( outMsg );

		return;
	//}

}

void TFStatManager::ClientRequestsStats( int clientNum, const idBitMsg &inMsg ) {
	statsMetricType_t metricType = (statsMetricType_t)inMsg.ReadBits( ASYNC_STATS_METRIC_TYPE_BITS );
	statsVersusType_t versusType = (statsVersusType_t)inMsg.ReadBits( ASYNC_STATS_VERSUS_TYPE_BITS );

	ENTDEF entDef = NULL;
	if ( metricType == METRIC_ATTACK || metricType == METRIC_DAMAGE ) {
		int defNum = inMsg.ReadLong();

		entDef = static_cast<ENTDEF>( declManager->DeclByIndex( DECL_ENTITYDEF, defNum ) );
		if ( !entDef ) {
			gameLocal.Warning( "ClientRequestsStats - could not find the entity def for def index %d", defNum );
			return;
		}
	}

	const char* stat_group = NULL;
	dmgStat_t* dmgStat = NULL;

	byte msgBuf[MAX_GAME_MESSAGE_SIZE];
	idBitMsg msg;
	msg.Init( msgBuf, sizeof( msgBuf ) );
	msg.WriteByte( GAME_RELIABLE_MESSAGE_PLAYERSTATS );
	
	msg.WriteBits( metricType, ASYNC_STATS_METRIC_TYPE_BITS );
	msg.WriteBits( versusType, ASYNC_STATS_VERSUS_TYPE_BITS );
		
	if ( metricType == METRIC_ATTACK || metricType == METRIC_DAMAGE )
		msg.WriteLong( entDef->Index() );

	gameLocal.Printf( "ClientRequestsStats - client %d requesting.\n", clientNum );

	TFPlayerStats* stats;
	
	for ( int i = 0; i < MAX_CLIENTS; i++ ) {
		stats = GetPlayerStatsClientNum( i );
		if ( stats ) {
			msg.WriteBits( 1, 1 );

			msg.WriteLong( stats->GetPlayTime() );

			switch( metricType ) {
				case METRIC_GENERAL: {

					switch( versusType ) {

						case VERSUS_ENEMY:

							msg.WriteShort( stats->StatKillsEnemy() );
							msg.WriteShort( stats->StatDeathsEnemy() );
							msg.WriteShort( stats->StatDamageToEnemy() );
							msg.WriteShort( stats->StatDamageFromEnemy() );
							break;

						case VERSUS_TEAM:

							msg.WriteShort( stats->StatKillsTeam() );
							msg.WriteShort( stats->StatDeathsTeam() );
							msg.WriteShort( stats->StatDamageToTeam() );
							msg.WriteShort( stats->StatDamageFromTeam() );
							break;

						case VERSUS_SELF:

							msg.WriteShort( stats->StatKillsSelf() );
							msg.WriteShort( stats->StatKillsSelf() );
							msg.WriteShort( stats->StatDamageFromSelf() );
							msg.WriteShort( stats->StatDamageFromSelf() );
							break;
					}

					break;
				}

				case METRIC_CTF: {

					msg.WriteShort( stats->flagGrabs );
					msg.WriteShort( stats->flagDrops );
					msg.WriteShort( stats->flagCaptures );
					msg.WriteShort( stats->flagSaves );

					break;
				}

				
				case METRIC_DAMAGE:
				case METRIC_ATTACK: {

					assert( entDef );

					stat_group = NULL;
					dmgStat = NULL;

					bool isDamage;

					if ( metricType == METRIC_DAMAGE ) {
						isDamage = true;
						dmgStat = stats->GetDmgStat( entDef->Index() );
					}
					else {
						isDamage = false;
						stat_group = entDef->dict.GetString( "stat_group" );

						if ( !stat_group || !stat_group[0] ) {
							gameLocal.Warning( "ClientRequestsStats - somehow both dmgStat and stat_group are null for def %s.", entDef->GetName() );
							return;
						}
					}

					if ( !dmgStat && ( !stat_group || !stat_group[0] ) ) {
						msg.WriteDeltaShort( 0, 0 );
						msg.WriteDeltaShort( 0, 0 );
						msg.WriteDeltaShort( 0, 0 );
						msg.WriteDeltaShort( 0, 0 );
						msg.WriteDeltaShort( 0, 0 );
						msg.WriteDeltaShort( 0, 0 );
					}
					else {
					
						switch( versusType ) {

							case VERSUS_ENEMY:
								msg.WriteDeltaShort( 0, isDamage ? stats->StatShotsFired( dmgStat ) : stats->StatShotsFired( stat_group ) );
								msg.WriteDeltaShort( 0, isDamage ? stats->StatHitsToEnemy( dmgStat ) : stats->StatHitsToEnemy( stat_group ) );
								msg.WriteDeltaShort( 0, isDamage ? stats->StatKillsEnemy( dmgStat ) : stats->StatKillsEnemy( stat_group ) );
								msg.WriteDeltaShort( 0, isDamage ? stats->StatDeathsEnemy( dmgStat ) : stats->StatDeathsEnemy( stat_group ) );
								msg.WriteDeltaShort( 0, isDamage ? stats->StatDamageToEnemy( dmgStat ) : stats->StatDamageToEnemy( stat_group ) );
								msg.WriteDeltaShort( 0, isDamage ? stats->StatDamageFromEnemy( dmgStat ) : stats->StatDamageFromEnemy( stat_group ) );
								break;

							case VERSUS_TEAM:
								msg.WriteDeltaShort( 0, isDamage ? stats->StatShotsFired( dmgStat ) : stats->StatShotsFired( stat_group ) );
								msg.WriteDeltaShort( 0, isDamage ? stats->StatHitsToTeam( dmgStat ) : stats->StatHitsToTeam( stat_group ) );
								msg.WriteDeltaShort( 0, isDamage ? stats->StatKillsTeam( dmgStat ) : stats->StatKillsTeam( stat_group ) );
								msg.WriteDeltaShort( 0, isDamage ? stats->StatDeathsTeam( dmgStat ) : stats->StatDeathsTeam( stat_group ) );
								msg.WriteDeltaShort( 0, isDamage ? stats->StatDamageToTeam( dmgStat ) : stats->StatDamageToTeam( stat_group ) );
								msg.WriteDeltaShort( 0, isDamage ? stats->StatDamageFromTeam( dmgStat ) : stats->StatDamageFromTeam( stat_group ) );
								break;

							case VERSUS_SELF:
								msg.WriteDeltaShort( 0, isDamage ? stats->StatShotsFired( dmgStat ) : stats->StatShotsFired( stat_group ) );
								msg.WriteDeltaShort( 0, isDamage ? stats->StatHitsFromSelf( dmgStat ) : stats->StatHitsFromSelf( stat_group ) );
								msg.WriteDeltaShort( 0, isDamage ? stats->StatKillsSelf( dmgStat ) : stats->StatKillsSelf( stat_group ) );
								msg.WriteDeltaShort( 0, isDamage ? stats->StatKillsSelf( dmgStat ) : stats->StatKillsSelf( stat_group ) );
								msg.WriteDeltaShort( 0, isDamage ? stats->StatDamageFromSelf( dmgStat ) : stats->StatDamageFromSelf( stat_group ) );
								msg.WriteDeltaShort( 0, isDamage ? stats->StatDamageFromSelf( dmgStat ) : stats->StatDamageFromSelf( stat_group ) );
								break;
						}
					}
				}
			}
		}
		else {
			msg.WriteBits( 0, 1 );
		}
	}

	gameLocal.Printf( "ClientRequestsStats - sending %d bytes of information.\n", msg.GetNumBitsWritten() / 8 );

	if ( clientNum == gameLocal.localClientNum ) {
		msg.ReadByte();
		ClientReceiveStats( msg );
	}
	else {
		networkSystem->ServerSendReliableMessage( clientNum, msg );
	}
}

void TFStatManager::ClientReceiveStats( const idBitMsg &msg ) {
	statsMetricType_t metricType = (statsMetricType_t)msg.ReadBits( ASYNC_STATS_METRIC_TYPE_BITS );
	statsVersusType_t versusType = (statsVersusType_t)msg.ReadBits( ASYNC_STATS_VERSUS_TYPE_BITS );

	ENTDEF entDef = NULL;
	if ( metricType == METRIC_ATTACK || metricType == METRIC_DAMAGE ) {
		int defNum = msg.ReadLong();

		entDef = static_cast<ENTDEF>( declManager->DeclByIndex( DECL_ENTITYDEF, defNum ) );
		if ( !entDef ) {
			gameLocal.Warning( "ClientReceiveStats - could not find the entity def for def index %d", defNum );
			return;
		}
	}

	qqq( "ClientReceiveStats start..." );

	for ( int i = 0; i < MAX_CLIENTS; i++ ) {
		generalStats[i].clientNum = -1;
		ctfStats[i].clientNum = -1;
		attackStats[i].clientNum = -1;

		if ( msg.ReadBits( 1 ) ) {

			playTimes[i] = msg.ReadLong() / 60000;
			if ( playTimes[i] <= 0 )
				playTimes[i] = 1;

			switch( metricType ) {
				case METRIC_GENERAL: {

					generalStats[i].clientNum = i;
					generalStats[i].kills = msg.ReadShort();
					generalStats[i].deaths = msg.ReadShort();
					generalStats[i].dmgGiven = msg.ReadShort();
					generalStats[i].dmgTaken = msg.ReadShort();

					break;
				}

				case METRIC_CTF: {

					ctfStats[i].clientNum = i;
					ctfStats[i].steals = msg.ReadShort();
					ctfStats[i].drops = msg.ReadShort();
					ctfStats[i].captures = msg.ReadShort();
					ctfStats[i].saves = msg.ReadShort();
					ctfStats[i].score = gameLocal.mpGame.GetPlayerScore( i );
					break;
				}


				case METRIC_DAMAGE:
				case METRIC_ATTACK: {

					attackStats[i].clientNum = i;
					attackStats[i].shots_fired = msg.ReadDeltaShort( 0 );
					attackStats[i].shots_hit = msg.ReadDeltaShort( 0 );
					attackStats[i].kills = msg.ReadDeltaShort( 0 );
					attackStats[i].deaths = msg.ReadDeltaShort( 0 );
					attackStats[i].dmgGiven = msg.ReadDeltaShort( 0 );
					attackStats[i].dmgTaken = msg.ReadDeltaShort( 0 );

					if ( attackStats[i].shots_hit > 0 ) {
						attackStats[i].accuracy = (float)attackStats[i].shots_hit / (float)attackStats[i].shots_fired;
					}
					else {
						attackStats[i].accuracy = 0.0f;
					}
				}
			}
		}
	}

	idUserInterface* gui = gameLocal.mpGame.GetMainGui();

	if ( !gui )
		return;

	SetMetricType( gui, metricType );
	SetVersusType( gui, versusType );
	gui->SetStateString( "stats_defName", entDef ? entDef->GetName() : "" );

	RedrawGUIStats( gui, entDef );

	qqq( "...ClientReceiveStats Done" );
}

static statsSortType_t sortType = ST_SORT_NAME;
static statsSortOrder_t sortOrder = ST_SORT_OR_DEC;

void TFStatManager::RedrawGUIStats( idUserInterface* gui, ENTDEF attackDef ) {

	if ( !gui )
		return;

	statsMetricType_t metricType = GetMetricType( gui );
	sortType = GetSortType( gui );
	sortOrder = GetSortOrder( gui );

	if ( metricType == METRIC_GENERAL ) {
		DrawStatsGeneral( gui );
		gui->SetStateString( "txtMetric", "General" );
	}
	else if ( metricType == METRIC_CTF ) {
		DrawStatsCTF( gui );
		gui->SetStateString( "txtMetric", "Teamplay" );
	}
	else if ( metricType == METRIC_ATTACK || metricType == METRIC_DAMAGE ) {
		DrawStatsAttack( gui );

		if ( attackDef ) {
			const char* group = attackDef->dict.GetString( "stat_group" );
			const char* type = attackDef->dict.GetString( "stat_type" );
			if ( !type || !type[0] || !idStr::Icmp( group, type ) ) {
				gui->SetStateString( "txtMetric", group );
			}
			else {
				gui->SetStateString( "txtMetric", va( "%s - %s", group, type ) );
			}
		}
	}

	statsMeasureType_t measureType = GetMeasureType( gui );

	if ( measureType == MEASURE_TOTAL ) {
		gui->SetStateString( "txtMeasure", "Total" );
	}
	else {
		gui->SetStateString( "txtMeasure", "Average Per Minute" );
	}

	statsVersusType_t versusType = GetVersusType( gui );

	if ( versusType == VERSUS_ENEMY ) {
		gui->SetStateString( "txtTarget", "To/From Enemy" );
	}
	else if ( versusType == VERSUS_TEAM ) {
		gui->SetStateString( "txtTarget", "To/From Team" );
	}
	else {
		gui->SetStateString( "txtTarget", "To/From Self" );
	}

	gui->StateChanged( gameLocal.time );
}

// metric types are: general, ctf, attack, damage
statsMetricType_t TFStatManager::GetMetricType( idUserInterface* gui ) {
	const char* metricType = gui->GetStateString( "stats_metric", "general" );

	if ( !idStr::Icmp( metricType, "general" ) ) {
		return METRIC_GENERAL;
	}
	else if ( !idStr::Icmp( metricType, "ctf" ) ) {
		return METRIC_CTF;
	}
	else if ( !idStr::Icmp( metricType, "attack" ) ) {
		return METRIC_ATTACK;
	}
	else if ( !idStr::Icmp( metricType, "damage" ) ) {
		return METRIC_DAMAGE;
	}

	//gameLocal.Warning( "GetMetricType - unknown metric type '%s'", metricType );
	return METRIC_GENERAL;
}

void TFStatManager::SetMetricType( idUserInterface* gui, statsMetricType_t type ) {

	switch( type ) {
		case METRIC_GENERAL:
			gui->SetStateString( "stats_metric", "general" );
			break;

		case METRIC_CTF:
			gui->SetStateString( "stats_metric", "ctf" );
			break;

		case METRIC_ATTACK:
			gui->SetStateString( "stats_metric", "attack" );
			break;

		case METRIC_DAMAGE:
			gui->SetStateString( "stats_metric", "damage" );
			break;
	}
}

// metric types are: enemy, team, self
statsVersusType_t TFStatManager::GetVersusType( idUserInterface* gui ) {
	const char* vType = gui->GetStateString( "stats_versus", "enemy" );

	if ( !idStr::Icmp( vType, "enemy" ) ) {
		return VERSUS_ENEMY;
	}
	else if ( !idStr::Icmp( vType, "team" ) ) {
		return VERSUS_TEAM;
	}
	else if ( !idStr::Icmp( vType, "self" ) ) {
		return VERSUS_SELF;
	}

	//gameLocal.Warning( "GetVersusType - unknown versus type '%s'", vType );
	return VERSUS_ENEMY;
}

void TFStatManager::SetVersusType( idUserInterface* gui, statsVersusType_t type ) {
	switch( type ) {
		case VERSUS_ENEMY:
			gui->SetStateString( "stats_versus", "enemy" );
			break;

		case VERSUS_TEAM:
			gui->SetStateString( "stats_versus", "team" );
			break;

		case VERSUS_SELF:
			gui->SetStateString( "stats_versus", "self" );
			break;
	}
}
// measure types are: total, minute
statsMeasureType_t TFStatManager::GetMeasureType( idUserInterface* gui ) {
	const char* sType = gui->GetStateString( "stats_measure", "total" );

	if ( !idStr::Icmp( sType, "total" ) ) {
		return MEASURE_TOTAL;
	}
	else if ( !idStr::Icmp( sType, "minute" ) ) {
		return MEASURE_MINUTE;
	}

	//gameLocal.Warning( "GetMeasureType - unknown measure type '%s'", sType );
	return MEASURE_TOTAL;
}

// sort types are: name, fired, hit, accuracy, kills, deaths,
// dmgGiven, dmgTaken, score, steals, drops, captures, saves, playtime
statsSortType_t TFStatManager::GetSortType( idUserInterface* gui ) {

	statsSortType_t newType = ST_SORT_KILLS;

	const char* sType = gui->GetStateString( "stats_sort", "name" );

	if ( !idStr::Icmp( sType, "name" ) ) {
		newType = ST_SORT_NAME;
	}
	else if ( !idStr::Icmp( sType, "fired" ) ) {
		newType = ST_SORT_SHOTS_FIRED;
	}
	else if ( !idStr::Icmp( sType, "hit" ) ) {
		newType = ST_SORT_SHOTS_HIT;
	}
	else if ( !idStr::Icmp( sType, "accuracy" ) ) {
		newType = ST_SORT_ACCURACY;
	}
	else if ( !idStr::Icmp( sType, "kills" ) ) {
		newType = ST_SORT_KILLS;
	}
	else if ( !idStr::Icmp( sType, "deaths" ) ) {
		newType = ST_SORT_DEATHS;
	}
	else if ( !idStr::Icmp( sType, "dmgGiven" ) ) {
		newType = ST_SORT_DMG_GIVEN;
	}
	else if ( !idStr::Icmp( sType, "dmgTaken" ) ) {
		newType = ST_SORT_DMG_TAKEN;
	}
	else if ( !idStr::Icmp( sType, "score" ) ) {
		newType = ST_SORT_SCORE;
	}
	else if ( !idStr::Icmp( sType, "steals" ) ) {
		newType = ST_SORT_STEALS;
	}
	else if ( !idStr::Icmp( sType, "drops" ) ) {
		newType = ST_SORT_DROPS;
	}
	else if ( !idStr::Icmp( sType, "captures" ) ) {
		newType = ST_SORT_CAPTURES;
	}
	else if ( !idStr::Icmp( sType, "saves" ) ) {
		newType = ST_SORT_SAVES;
	}
	else if ( !idStr::Icmp( sType, "playtime" ) ) {
		newType = ST_SORT_PLAYTIME;
	}

	if ( newType == sortType ) {
		if ( sortOrder == ST_SORT_OR_ASC )
			gui->SetStateInt( "stats_sort_order", 1 );
		else
			gui->SetStateInt( "stats_sort_order", 0 );
	}
	
	return newType;
}

// sort orders are: asc, dec
statsSortOrder_t TFStatManager::GetSortOrder( idUserInterface* gui ) {
	int sType = gui->GetStateInt( "stats_sort_order", "0" );

	if ( sType == 0 ) {
		return ST_SORT_OR_ASC;
	}
	else if ( sType == 1 ) {
		return ST_SORT_OR_DEC;
	}

	gameLocal.Warning( "GetSortOrder - unknown sort order '%s'", sType );
	return ST_SORT_OR_DEC;
}




int q4fStatsGeneralCompare( const statsTypeGeneral_t** a, const statsTypeGeneral_t** b ) {
	const statsTypeGeneral_t* g1 = *a;
	const statsTypeGeneral_t* g2 = *b;

	idStr n1;
	idStr n2;

	int cmp;

	switch( sortType ) {
		case ST_SORT_NAME:
			n1 = gameLocal.userInfo[ g1->clientNum ].GetString( "ui_name" );
			n2 = gameLocal.userInfo[ g2->clientNum ].GetString( "ui_name" );
			n1.RemoveEscapes();
			n2.RemoveEscapes();
			cmp = idStr::Icmp( n1.c_str(), n2.c_str() );
			return sortOrder == ST_SORT_OR_ASC ? cmp : -1 * cmp;

		case ST_SORT_KILLS:
			cmp = g2->kills < g1->kills ? 1 : -1;
			return sortOrder == ST_SORT_OR_ASC ? cmp : -1 * cmp;

		case ST_SORT_DEATHS:
			cmp = g2->deaths < g1->deaths ? 1 : -1;
			return sortOrder == ST_SORT_OR_ASC ? cmp : -1 * cmp;

		case ST_SORT_DMG_GIVEN:
			cmp = g2->dmgGiven < g1->dmgGiven ? 1 : -1;
			return sortOrder == ST_SORT_OR_ASC ? cmp : -1 * cmp;

		case ST_SORT_DMG_TAKEN:
			cmp = g2->dmgTaken < g1->dmgTaken ? 1 : -1;
			return sortOrder == ST_SORT_OR_ASC ? cmp : -1 * cmp;
	}

	return 1;
}

int q4fStatsCTFCompare( const statsTypeCTF_t** a, const statsTypeCTF_t** b ) {
	const statsTypeCTF_t* c1 = *a;
	const statsTypeCTF_t* c2 = *b;

	idStr n1;
	idStr n2;

	int cmp;

	switch( sortType ) {
		case ST_SORT_NAME:
			n1 = gameLocal.userInfo[ c1->clientNum ].GetString( "ui_name" );
			n2 = gameLocal.userInfo[ c2->clientNum ].GetString( "ui_name" );
			n1.RemoveEscapes();
			n2.RemoveEscapes();
			cmp = idStr::Icmp( n1.c_str(), n2.c_str() );
			return sortOrder == ST_SORT_OR_ASC ? cmp : -1 * cmp;

		case ST_SORT_SCORE:
			cmp = c2->score < c1->score ? 1 : -1;
			return sortOrder == ST_SORT_OR_ASC ? cmp : -1 * cmp;

		case ST_SORT_STEALS:
			cmp = c2->steals < c1->steals ? 1 : -1;
			return sortOrder == ST_SORT_OR_ASC ? cmp : -1 * cmp;

		case ST_SORT_DROPS:
			cmp = c2->drops < c1->drops ? 1 : -1;
			return sortOrder == ST_SORT_OR_ASC ? cmp : -1 * cmp;

		case ST_SORT_CAPTURES:
			cmp = c2->captures < c1->captures ? 1 : -1;
			return sortOrder == ST_SORT_OR_ASC ? cmp : -1 * cmp;

		case ST_SORT_SAVES:
			cmp = c2->saves < c1->saves ? 1 : -1;
			return sortOrder == ST_SORT_OR_ASC ? cmp : -1 * cmp;
	}

	return 1;
}

int q4fStatsAttackCompare( const statsTypeAttack_t** a, const statsTypeAttack_t** b ) {
	const statsTypeAttack_t* a1 = *a;
	const statsTypeAttack_t* a2 = *b;

	idStr n1;
	idStr n2;

	int cmp;

	switch( sortType ) {
		case ST_SORT_NAME:
			n1 = gameLocal.userInfo[ a1->clientNum ].GetString( "ui_name" );
			n2 = gameLocal.userInfo[ a2->clientNum ].GetString( "ui_name" );
			n1.RemoveEscapes();
			n2.RemoveEscapes();
			cmp = idStr::Icmp( n1.c_str(), n2.c_str() );
			return sortOrder == ST_SORT_OR_ASC ? cmp : -1 * cmp;

		case ST_SORT_SHOTS_FIRED:
			cmp = a2->shots_fired < a1->shots_fired ? 1 : -1;
			return sortOrder == ST_SORT_OR_ASC ? cmp : -1 * cmp;

		case ST_SORT_SHOTS_HIT:
			cmp = a2->shots_hit < a1->shots_hit ? 1 : -1;
			return sortOrder == ST_SORT_OR_ASC ? cmp : -1 * cmp;

		case ST_SORT_ACCURACY:
			cmp = a2->accuracy < a1->accuracy ? 1 : -1;
			return sortOrder == ST_SORT_OR_ASC ? cmp : -1 * cmp;

		case ST_SORT_KILLS:
			cmp = a2->kills < a1->kills ? 1 : -1;
			return sortOrder == ST_SORT_OR_ASC ? cmp : -1 * cmp;

		case ST_SORT_DEATHS:
			cmp = a2->deaths < a1->deaths ? 1 : -1;
			return sortOrder == ST_SORT_OR_ASC ? cmp : -1 * cmp;

		case ST_SORT_DMG_GIVEN:
			cmp = a2->dmgGiven < a1->dmgGiven ? 1 : -1;
			return sortOrder == ST_SORT_OR_ASC ? cmp : -1 * cmp;

		case ST_SORT_DMG_TAKEN:
			cmp = a2->dmgTaken < a1->dmgTaken ? 1 : -1;
			return sortOrder == ST_SORT_OR_ASC ? cmp : -1 * cmp;
	}

	return 1;
}

void TFStatManager::DrawStatsGeneral( idUserInterface* gui ) {
	
	idList< statsTypeGeneral_t* > list;

	for ( int i = 0; i < gameLocal.numClients; i++ ) {
		if ( generalStats[i].clientNum >= 0 && gameLocal.mpGame.IsInGame( i ) )
			list.Append( &(generalStats[i]) );
	}

	list.Sort( ( idList< statsTypeGeneral_t* >::cmp_t * )&q4fStatsGeneralCompare );

	statsMeasureType_t measureType = GetMeasureType( gui );

	gui->SetStateInt( "stats_viewNum", 1 );

	if ( measureType == MEASURE_TOTAL ) {
		for ( int i = 0; i < list.Num(); i++ ) {
			gui->SetStateString( va( "stats_list_item_%d", i ), va( "%s\t%d\t%d\t%d\t%d\t%d\t",
				gameLocal.userInfo[ list[i]->clientNum ].GetString( "ui_name", "" ),
				playTimes[ list[i]->clientNum ],
				list[i]->kills,
				list[i]->deaths,
				list[i]->dmgGiven,
				list[i]->dmgTaken ) );
		}
	}
	else {
		for ( int i = 0; i < list.Num(); i++ ) {
			gui->SetStateString( va( "stats_list_item_%d", i ), va( "%s\t%d\t%4.3f\t%4.3f\t%4.3f\t%4.3f\t",
				gameLocal.userInfo[ list[i]->clientNum ].GetString( "ui_name", "" ),
				playTimes[ list[i]->clientNum ],
				(float)(list[i]->kills) / (float)(playTimes[ list[i]->clientNum ]),
				(float)(list[i]->deaths) / (float)(playTimes[ list[i]->clientNum ]),
				(float)(list[i]->dmgGiven) / (float)(playTimes[ list[i]->clientNum ]),
				(float)(list[i]->dmgTaken) / (float)(playTimes[ list[i]->clientNum ]) ) );
		}
	}
}

void TFStatManager::DrawStatsCTF( idUserInterface* gui ) {

	idList< statsTypeCTF_t* > list;

	for ( int i = 0; i < gameLocal.numClients; i++ ) {
		if ( ctfStats[i].clientNum >= 0 && gameLocal.mpGame.IsInGame( i ) )
			list.Append( &(ctfStats[i]) );
	}

	list.Sort( ( idList< statsTypeCTF_t* >::cmp_t * )&q4fStatsCTFCompare );

	statsMeasureType_t measureType = GetMeasureType( gui );

	gui->SetStateInt( "stats_viewNum", 2 );

	if ( measureType == MEASURE_TOTAL ) {
		for ( int i = 0; i < list.Num(); i++ ) {
			gui->SetStateString( va( "stats_list_item_%d", i ), va( "%s\t%d\t%d\t%d\t%d\t%d\t",
				gameLocal.userInfo[ list[i]->clientNum ].GetString( "ui_name", "" ),
				list[i]->score,
				list[i]->steals,
				list[i]->drops,
				list[i]->captures,
				list[i]->saves ) );
		}
	}
	else {
		for ( int i = 0; i < list.Num(); i++ ) {
			gui->SetStateString( va( "stats_list_item_%d", i ), va( "%s\t%4.3f\t%4.3f\t%4.3f\t%4.3f\t%4.3f\t",
				gameLocal.userInfo[ list[i]->clientNum ].GetString( "ui_name", "" ),
				(float)(list[i]->score) / (float)(playTimes[ list[i]->clientNum ]),
				(float)(list[i]->steals) / (float)(playTimes[ list[i]->clientNum ]),
				(float)(list[i]->drops) / (float)(playTimes[ list[i]->clientNum ]),
				(float)(list[i]->captures) / (float)(playTimes[ list[i]->clientNum ]),
				(float)(list[i]->saves) / (float)(playTimes[ list[i]->clientNum ]) ) );
		}
	}
}

void TFStatManager::DrawStatsAttack( idUserInterface* gui ) {

	idList< statsTypeAttack_t* > list;

	for ( int i = 0; i < gameLocal.numClients; i++ ) {
		if ( attackStats[i].clientNum >= 0 && gameLocal.mpGame.IsInGame( i ) )
			list.Append( &(attackStats[i]) );
	}

	list.Sort( ( idList< statsTypeAttack_t* >::cmp_t * )&q4fStatsAttackCompare );

	statsMeasureType_t measureType = GetMeasureType( gui );

	gui->SetStateInt( "stats_viewNum", 3 );

	if ( measureType == MEASURE_TOTAL ) {
		for ( int i = 0; i < list.Num(); i++ ) {
			gui->SetStateString( va( "stats_list_item_%d", i ), va( "%s\t%d\t%d\t%4.3f\t%d\t%d\t%d\t%d\t",
				gameLocal.userInfo[ list[i]->clientNum ].GetString( "ui_name", "" ),
				list[i]->shots_fired,
				list[i]->shots_hit,
				list[i]->accuracy,
				list[i]->kills,
				list[i]->deaths,
				list[i]->dmgGiven,
				list[i]->dmgTaken ) );
		}
	}
	else {
		for ( int i = 0; i < list.Num(); i++ ) {
			gui->SetStateString( va( "stats_list_item_%d", i ), va( "%s\t%4.3f\t%4.3f\t%4.3f\t%4.3f\t%4.3f\t%4.3f\t%4.3f\t",
				gameLocal.userInfo[ list[i]->clientNum ].GetString( "ui_name", "" ),
				(float)(list[i]->shots_fired) / (float)(playTimes[ list[i]->clientNum ]),
				(float)(list[i]->shots_hit) / (float)(playTimes[ list[i]->clientNum ]),
				(float)(list[i]->accuracy)/* / (float)(playTimes[ list[i]->clientNum ])*/,
				(float)(list[i]->kills) / (float)(playTimes[ list[i]->clientNum ]),
				(float)(list[i]->deaths) / (float)(playTimes[ list[i]->clientNum ]),
				(float)(list[i]->dmgGiven) / (float)(playTimes[ list[i]->clientNum ]),
				(float)(list[i]->dmgTaken) / (float)(playTimes[ list[i]->clientNum ]) ) );
		}
	}
}






void TFStatManager::GetDamageList( const TFPlayerStats* stats, const char* stat_group, idList<const dmgStat_t*> &list ) const {
	list.Clear();

	if ( !stat_group || !stat_group[0] )
		return;

	for ( int j = 0; j < stats->dmgStats.Num(); j++ ) {
		if ( !idStr::Icmp( stats->dmgStats[j].dmgDef->dict.GetString( "stat_group" ), stat_group ) )
			list.Append( &( stats->dmgStats[j]) );
	}
}

#define LARGEST_EVENT_BIT_COUNT 1000

void TFStatManager::DistributeStats( void ) const {
	/*assert( statQueue.Num() > 0 );

	byte msgBuf[MAX_GAME_MESSAGE_SIZE];
	idBitMsg msg;

	int maxBits = MAX_GAME_MESSAGE_SIZE - LARGEST_EVENT_BIT_COUNT;

	msg.Init( msgBuf, MAX_GAME_MESSAGE_SIZE );
	msg.WriteByte( GAME_RELIABLE_MESSAGE_STATEVENT );
	msg.WriteBits( num, 16 );

	int num = statQueue.Num();
	
	for ( int i = 0; i < num; i++ ) {

		if ( msg.GetNumBitsWritten() > maxBits || i == num - 1 ) {

			networkSystem->ServerSendReliableMessage( -1, msg );	

			msg.Init( msgBuf, MAX_GAME_MESSAGE_SIZE );
			msg.WriteByte( GAME_RELIABLE_MESSAGE_STATEVENT );
			msg.WriteBits( num, 16 );
		}
		
		msg.WriteBits( i, 16 );
		msg.WriteBits( statQueue[i]->GetType(), ASYNC_STAT_TYPE_BITS );
		msg.WriteBits( statQueue[i]->GetTimeStamp(), 32 );
		statQueue[i]->PackStats( msg );
	}*/
}

void TFStatManager::WriteStatsXML() const {

	if ( statQueue.Num() <= 0 ) {
		gameLocal.Warning( "WriteStatsXML - empty stat queue - exiting." );
		return;
	}

	qqq( "----- StatManager WriteStatsXML -----" );

	tfStatRoundStart* roundStart = static_cast<tfStatRoundStart*>(statQueue[0]);

	if ( !roundStart || roundStart->GetType() != STAT_ROUND_START ) {
		gameLocal.Warning( "TFStatManager::WriteStatsXML - missing round start stat." );
		return;
	}

	int timeStart = roundStart->GetTimeStamp();

	idStr fileName = "xml/";
	fileName.Append( roundStart->mapName.c_str() );
	fileName.Append( "_" );
	fileName.Append(  roundStart->roundDate.c_str() );
	fileName.Append( ".xml" );

	idFile* xmlFile = fileSystem->OpenFileWrite( fileName.c_str(), "q4f", false );

	if ( !xmlFile ) {
		gameLocal.Warning( "TFStatManager::WriteStatsXML - could not create xml file." );
		return;
	}

	idStr opening = va( "<Q4FStats map=\"%s\" epochSeconds=\"%d\">\r\n", roundStart->mapName.c_str(), roundStart->epochSeconds );

	xmlFile->Write( opening.c_str(), opening.Length() );
	xmlFile->Write( "\t<Players>\r\n", 12 );

	idStr txt;

	for ( int i = 0; i < playerStats.Num(); i++ ) {
		playerStats[i].GetXML( i, txt );
		xmlFile->Write( txt, txt.Length() );
	}

	xmlFile->Write( "\t</Players>\r\n\t<Events>\r\n", 24 );

	for ( int i = 0; i < statQueue.Num(); i++ ) {
		statQueue[i]->GetXML( timeStart, txt );
		xmlFile->Write( txt, txt.Length() );
	}

	xmlFile->Write( "\t</Events>\r\n", 12 );

	xmlFile->Write( "</Q4FStats>\r\n", 13 );

	fileSystem->CloseFile( xmlFile );

	qqq( "--------------------------" );
}

void TFStatManager::CheckAwardQueue() {
	
}

const int ASYNC_AWARD_TYPE_BITS = idMath::BitsForInteger( IGA_NUM_AWARDS );
const int MAX_AWARDS = 64;
const int ASYNC_AWARD_COUNT_BITS = 6;

void TFStatManager::SendInGameAward( int clientNum, inGameAward_t award, int awardCount ) {
	assert( gameLocal.isServer );

	if ( awardCount > MAX_AWARDS )
		awardCount = MAX_AWARDS;

	idBitMsg msg;
	byte msgBuf[1024];
	msg.Init( msgBuf, sizeof( msgBuf ) );
	msg.WriteByte( GAME_RELIABLE_MESSAGE_INGAMEAWARD );

	msg.WriteBits( award, ASYNC_AWARD_TYPE_BITS );
	msg.WriteBits( awardCount, ASYNC_AWARD_COUNT_BITS );

	if ( clientNum == gameLocal.localClientNum ) {
		msg.ReadByte();
		ReceiveInGameAward( msg );
	}
	else {
		networkSystem->ServerSendReliableMessage( clientNum, msg );
	}
}

void TFStatManager::ReceiveInGameAward( const idBitMsg &msg ) {
	assert( gameLocal.isClient || gameLocal.isListenServer );

	// read from msg
	inGameAward_t award = (inGameAward_t)msg.ReadBits( ASYNC_AWARD_TYPE_BITS );
	int awardCount = msg.ReadBits( ASYNC_AWARD_COUNT_BITS );

	// should never happen...
	idPlayer* player = gameLocal.GetLocalPlayer();
	if ( !player || !player->mphud )
		return;



	// do icon
	player->mphud->HandleNamedEvent( "clearIGA" );
	player->mphud->SetStateInt( "ig_awards", idMath::ClampInt( 0, 10, awardCount ) );
	player->mphud->SetStateString( "ig_award", va( "gfx/mp/awards/%s", inGameAwardInfo[ award ] ) );	

	if( awardCount < 10 ) {
		player->mphud->SetStateString( "ig_award_num", "" );
		for( int i = 0; i < idMath::ClampInt( 0, 10, awardCount ); i++ )  {
			player->mphud->SetStateInt( va( "ig_awards_%d", i + 1 ), 1 );
		}
	} else {
		player->mphud->SetStateInt( "ig_award_num", awardCount );
		player->mphud->SetStateInt( "ig_awards", 1  );
		player->mphud->SetStateInt( va( "ig_awards_%d", 1 ), 1 );
	}

	player->mphud->HandleNamedEvent( "giveIGA" );
	player->mphud->StateChanged( gameLocal.time );

	// do sound
	player->StartSound( va( "snd_award_%s", inGameAwardInfo[ award ] ), SND_CHANNEL_ANY, 0, false, NULL );
}












