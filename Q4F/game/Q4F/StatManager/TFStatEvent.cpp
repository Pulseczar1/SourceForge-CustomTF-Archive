#include "../../../idlib/precompiled.h"
#pragma hdrstop

#include "../../Game_local.h"
#include "TFStatEvent.h"

void tfStatRoundStart::GetXML( int timeStart, idStr &txt ) {
	txt.Clear();
	txt.Append( va( "\t\t<Event time=\"%d\" type=\"roundstart\" mapname=\"%s\" date=\"%s\"", timeStamp - timeStart, mapName.c_str(), roundDate.c_str() ) );

	for ( int i = 0; i < TEAM_COUNT; i++ ) {
		txt.Append( va( " team%dplayers=\"%d\"", i+1, playersPerTeam[i] ) );
	}

	txt.Append( " />\r\n" );
}

void tfStatRoundStart::PackStats( idBitMsg &msg ) const {
	msg.WriteString( mapName.c_str(), mapName.Length() );
	msg.WriteString( roundDate.c_str(), roundDate.Length() );

	for ( int i = 0; i < TEAM_COUNT; i++ ) {
		msg.WriteBits( playersPerTeam[i], ASYNC_MAX_CLIENT_BITS );
	}
}

void tfStatRoundStart::UnPackStats( const idBitMsg &msg ) {
	char str[256];

	msg.ReadString( str, 256 );
	mapName = str;

	msg.ReadString( str, 256 );
	roundDate = str;

	for ( int i = 0; i < TEAM_COUNT; i++ ) {
		playersPerTeam[i] = msg.ReadBits( ASYNC_MAX_CLIENT_BITS );
	}
}

void tfStatRoundEnd::GetXML( int timeStart, idStr &txt ) {
	txt.Clear();
	txt.Append( va( "\t\t<Event time=\"%d\" type=\"roundend\"", timeStamp - timeStart ) );

	for ( int i = 0; i < TEAM_COUNT; i++ ) {
		txt.Append( va( " team%dplayers=\"%d\"", i+1, playersPerTeam[i] ) );
		txt.Append( va( " team%dscore=\"%d\"", i+1, scorePerTeam[i] ) );
	}

	txt.Append( " />\r\n" );
}

void tfStatClientConnect::GetXML( int timeStart, idStr &txt ) {
	txt.Clear();
	txt.Append( va( "\t\t<Event time=\"%d\" type=\"clientconnect\" playerindex=\"%d\" />\r\n", timeStamp - timeStart, playerStatIndex ) );
}

void tfStatClientDisconnect::GetXML( int timeStart, idStr &txt ) {
	txt.Clear();
	txt.Append( va( "\t\t<Event time=\"%d\" type=\"clientdisconnect\" playerindex=\"%d\" />\r\n", timeStamp - timeStart, playerStatIndex ) );
}

void tfStatSentryKill::GetXML( int timeStart, idStr &txt ) {
	txt.Clear();
	txt.Append( va( "\t\t<Event time=\"%d\" type=\"sentrykilled\" attackerindex=\"%d\" attackerteam=\"%d\" ownerindex=\"%d\" ownerteam=\"%d\" sentrylevel=\"%d\" />\r\n", timeStamp - timeStart, playerStatIndex, playerTeam + 1, ownerIndex, ownerTeam + 1, sentryLevel ) );
}

void tfStatDispenserKill::GetXML( int timeStart, idStr &txt ) {
	txt.Clear();
	txt.Append( va( "\t\t<Event time=\"%d\" type=\"dispenserkilled\" attackerindex=\"%d\" attackerteam=\"%d\" ownerindex=\"%d\" ownerteam=\"%d\" />\r\n", timeStamp - timeStart, playerStatIndex, playerTeam + 1, ownerIndex, ownerTeam + 1 ) );
}

void tfStatDetpackDisarm::GetXML( int timeStart, idStr &txt ) {
	txt.Clear();
	txt.Append( va( "\t\t<Event time=\"%d\" type=\"detpackdisarmed\" disarmerindex=\"%d\" ownerindex=\"%d\" timeleft=\"%d\" />\r\n", timeStamp - timeStart, playerStatIndex, ownerIndex, timeLeft ) );
}

void tfStatPlayerDeath::GetXML( int timeStart, idStr &txt ) {

	ENTDEF dmgDef = static_cast<ENTDEF>(declManager->DeclByIndex( DECL_ENTITYDEF, damageDefNum ));

	const char* name = dmgDef ? dmgDef->dict.GetString( "stat_type", "" ) : "";
	const char* group = dmgDef ? dmgDef->dict.GetString( "stat_group", "" ) : "";

	txt.Clear();
	txt.Append( va( "\t\t<Event time=\"%d\" type=\"playerdeath\" victimindex=\"%d\" victimteam=\"%d\" victimclass=\"%d\" attackerindex=\"%d\" attackerteam=\"%d\" attackerclass=\"%d\" damage=\"%d\" damagegroup=\"%s\" damagetype=\"%s\" />\r\n", timeStamp - timeStart, playerStatIndex, victimTeam + 1, victimClass + 1, attackerIndex, attackerTeam + 1, attackerClass + 1, damageAmount, group, name ) );
}

void tfStatFlagGrab::GetXML( int timeStart, idStr &txt ) {
	txt.Clear();
	txt.Append( va( "\t\t<Event time=\"%d\" type=\"itemgrab\" playerindex=\"%d\" playerteam=\"%d\" flagname=\"%s\" flagteam=\"%d\" distancefromstart=\"%g\" />\r\n", timeStamp - timeStart, playerStatIndex, playerTeam + 1, flagname.c_str(), flagteam + 1, distFromStart ) );
}

void tfStatFlagDrop::GetXML( int timeStart, idStr &txt ) {
	txt.Clear();

	if ( death ) {
		txt.Append( va( "\t\t<Event time=\"%d\" type=\"itemdrop\" playerindex=\"%d\" playerteam=\"%d\" flagname=\"%s\" flagteam=\"%d\" carrydistance=\"%g\" dropflag=\"false\" attackerindex=\"%d\" attackerteam=\"%d\" />\r\n", timeStamp - timeStart, playerStatIndex, playerTeam + 1, flagname.c_str(), flagteam + 1, carriedDistance, attackerIndex, attackerTeam + 1 ) );
	}
	else {
		txt.Append( va( "\t\t<Event time=\"%d\" type=\"itemdrop\" playerindex=\"%d\" playerteam=\"%d\" flagname=\"%s\" flagteam=\"%d\" carrydistance=\"%g\" dropflag=\"true\" />\r\n", timeStamp - timeStart, playerStatIndex, playerTeam + 1, flagname.c_str(), flagteam + 1, carriedDistance ) );
	}
}

void tfStatFlagCapture::GetXML( int timeStart, idStr &txt ) {
	txt.Clear();


	txt.Append( va( "\t\t<Event time=\"%d\" type=\"itemcapture\" playerindex=\"%d\" playerteam=\"%d\" flagname=\"%s\" flagteam=\"%d\" carrydistance=\"%g\" />\r\n", timeStamp - timeStart, playerStatIndex, playerTeam + 1, flagname.c_str(), flagteam + 1, carriedDistance ) );
}







tfStatRoundStart::tfStatRoundStart( int time, const char* mapname, const char* rounddate, int epochSeconds, int* playerCounts ) {
	timeStamp			= time;
	playerStatIndex		= WORLD_INDEX;
	type				= STAT_ROUND_START;

	mapName = mapname;
	roundDate = rounddate;
	this->epochSeconds = epochSeconds;

	for ( int i = 0; i < TEAM_COUNT; i++ ) {
		playersPerTeam[i] = playerCounts[i];
	}
}

tfStatRoundEnd::tfStatRoundEnd( int time, int* playerCounts, short* teamScores ) {
	timeStamp			= time;
	playerStatIndex		= WORLD_INDEX;
	type				= STAT_ROUND_END;

	for ( int i = 0; i < TEAM_COUNT; i++ ) {
		playersPerTeam[i] = playerCounts[i];
		scorePerTeam[i] = teamScores[i];
	}
}

tfStatSentryKill::tfStatSentryKill( int time, int playerIndex, int playerteam, int sentryOwnerIndex, int sentryOwnerTeam, int sentryLvl ) {
	timeStamp			= time;
	playerStatIndex		= playerIndex;
	ownerIndex			= sentryOwnerIndex;
	sentryLevel			= sentryLvl;
	type				= STAT_SENTRYKILL;

	ownerTeam			= sentryOwnerTeam;
	playerTeam			= playerteam;
}

tfStatDispenserKill::tfStatDispenserKill( int time, int playerIndex, int playerteam, int dispOwnerIndex, int dispOwnerTeam ) {
	timeStamp			= time;
	playerStatIndex		= playerIndex;
	ownerIndex			= dispOwnerIndex;
	type				= STAT_DISPENSERKILL;

	ownerTeam			= dispOwnerTeam;
	playerTeam			= playerteam;
}

tfStatDetpackDisarm::tfStatDetpackDisarm( int time, int playerIndex, int detOwnerIndex, int timeBeforeDet ) {
	timeStamp			= time;
	playerStatIndex		= playerIndex;
	ownerIndex			= detOwnerIndex;
	timeLeft			= timeBeforeDet;
	type				= STAT_DETPACKDISARM;
}

tfStatPlayerDeath::tfStatPlayerDeath( int time, idPlayer* victim, const TFDamage &damage ) {
	assert( victim );
	assert( victim->IsType( idPlayer::GetClassType() ) );

	TFPlayerStats* victimStats = tfStatManager->GetPlayerStatsPlayer( victim );
	assert( victimStats );

	timeStamp			= time;
	playerStatIndex		= victimStats->statsIndex;
	type				= STAT_PLAYERDEATH;

	TFPlayerStats* attStats = tfStatManager->GetPlayerStatsSpawnID( damage.GetAttacker().GetSpawnId() );

	attackerIndex = attStats ? attStats->statsIndex : WORLD_INDEX;
	attackerClass = damage.GetAttacker().GetClass();
	attackerTeam  = damage.GetAttacker().GetTeam();

	victimTeam	= victim->team;
	victimClass	= victim->currentPC;

	damageAmount		= damage.GetDamage();
	damageDefNum		= damage.GetDamageDef()->Index();
}

tfStatFlagGrab::tfStatFlagGrab( int time, int playerIndex, int playerTeam, TFCarryItem* flag ) {
	assert( flag );

	timeStamp			= time;
	playerStatIndex		= playerIndex;
	type				= STAT_FLAG_GRAB;

	flagteam			= flag->team;
	this->playerTeam	= playerTeam;
	flagname			= flag->GetName();

	if ( flag->GetNumCarriers() <= 0 ) {
		distFromStart = 0.0f;
	}
	else {
		distFromStart		= ( flag->GetPhysics()->GetOrigin() - flag->spawnOrigin ).Length();
	}
}

tfStatFlagDrop::tfStatFlagDrop( int time, int playerIndex, int playerTeam, TFCarryItem* flag, TFDamage* dmg ) {
	assert( flag );

	timeStamp			= time;
	playerStatIndex		= playerIndex;
	type				= STAT_FLAG_CAPTURE;

	this->attackerIndex	= attackerIndex;
	this->playerTeam	= playerTeam;
	flagteam			= flag->team;
	flagname			= flag->GetName();

	death				= dmg != NULL;

	if ( death ) {
		TFPlayerStats* stats = NULL;

		if ( dmg ) {
			stats = tfStatManager->GetPlayerStatsSpawnID( dmg->GetAttacker().GetSpawnId() );
		}

		attackerIndex = stats ? stats->statsIndex : WORLD_INDEX;
		attackerTeam  = dmg->GetAttacker().GetTeam();
	}

	carriedDistance	= flag->GetCarryDistance();
}

tfStatFlagCapture::tfStatFlagCapture( int time, int playerIndex, int playerTeam, TFCarryItem* flag, short* teamScores ) {
	assert( flag );

	timeStamp			= time;
	playerStatIndex		= playerIndex;
	type				= STAT_FLAG_CAPTURE;

	for ( int i = 0; i < TEAM_COUNT; i++ ) {
		scorePerTeam[i] = teamScores[i];
	}

	flagname			= flag->GetName();
	flagteam			= flag->team;
	this->playerTeam	= playerTeam;
	carriedDistance		= flag->GetCarryDistance();
}