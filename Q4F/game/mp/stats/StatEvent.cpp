//----------------------------------------------------------------
// StatEvent.cpp
//
// Copyright 2002-2005 Raven Software
//----------------------------------------------------------------

#include "../../../idlib/precompiled.h"
#pragma hdrstop

#include "../../Game_local.h"
#include "StatManager.h"


rvStatHit::rvStatHit( int t, int p, int v, int w, bool countForAccuracy ) : rvStat( t ) { 
	playerClientNum = p;
	victimClientNum = v;
	weapon = w;
	trackAccuracy = countForAccuracy;
	type = ST_HIT; 
	RegisterInGame( statManager->GetPlayerStats() );
}

void rvStatHit::RegisterInGame( rvPlayerStat* stats ) {
	if( playerClientNum >= 0 && playerClientNum < MAX_CLIENTS && weapon >= 0 && weapon < MAX_WEAPONS && trackAccuracy ) {
		stats[ playerClientNum ].weaponHits[ weapon ]++;	
	}
	idPlayer* player = (idPlayer*)gameLocal.entities[ playerClientNum ];
	if( !idStr::Icmp( player->spawnArgs.GetString( va( "def_weapon%d", weapon ) ), "weapon_railgun" ) ) {
		rvStatHit* lastHits[ 2 ] = { NULL, NULL };
		statManager->GetLastClientStats( playerClientNum, ST_HIT, gameLocal.time - 8000, 2, (rvStat**)lastHits );
		if( lastHits[0] ) {
			if(  !idStr::Icmp(player->spawnArgs.GetString( va( "def_weapon%d", ((rvStatHit*)lastHits[0])->weapon ) ), "weapon_railgun" ) ) {

				//Check to make sure we don't chain impressive awards.
				if(lastHits[1] 
				&& !idStr::Icmp(player->spawnArgs.GetString( va( "def_weapon%d", ((rvStatHit*)lastHits[1])->weapon ) ), "weapon_railgun" )
					&& (lastHits[1]->GetTimeStamp() - lastHits[0]->GetTimeStamp()) < 4000) {
						return;
				
				}

				if(gameLocal.time - lastHits[0]->GetTimeStamp() < 4000){
					statManager->GiveInGameAward( IGA_IMPRESSIVE, playerClientNum );
				}
			}
		}
	}
}

rvStatKill::rvStatKill( int t, int p, int v, bool g, int mod ) : rvStat( t ) { 
	type = ST_KILL; 
	playerClientNum = p;
	victimClientNum = v;
	gibbed = g;
	methodOfDeath = mod;
	RegisterInGame( statManager->GetPlayerStats() );
}

void rvStatKill::RegisterInGame( rvPlayerStat* stats ) {
	/*
	if( playerClientNum >= 0 && playerClientNum < MAX_CLIENTS ) {
		stats[ playerClientNum ].kills++;
		if( methodOfDeath >= 0 && methodOfDeath < MAX_WEAPONS ) {
			stats[ playerClientNum ].weaponKills[ methodOfDeath ]++;
		}
		if( victimClientNum == playerClientNum ) {
			stats[ playerClientNum ].suicides++;
		}
	}

	// check for humiliation award
	idPlayer* player = (idPlayer*)gameLocal.entities[ playerClientNum ];
	idPlayer* victim = (idPlayer*)gameLocal.entities[ victimClientNum ];
	if( !idStr::Icmp( player->spawnArgs.GetString( va( "def_weapon%d", methodOfDeath ) ), "weapon_gauntlet" ) ) {
		statManager->GiveInGameAward( IGA_HUMILIATION, playerClientNum );
	}

	rvStatKill* lastKills[ 2 ] = { NULL, NULL };

	statManager->GetLastClientStats( playerClientNum, ST_KILL, gameLocal.time - 5000, 2, (rvStat**)lastKills );

	// check for excellent award
	if( lastKills[ 0 ] && lastKills[ 0 ]->GetTimeStamp() >= (gameLocal.time - 2000) && lastKills[ 0 ]->victimClientNum != playerClientNum && victimClientNum != playerClientNum ) {
		statManager->GiveInGameAward( IGA_EXCELLENT, playerClientNum );
	}

	// check for rampage award
	if( ( gibbed && victimClientNum != playerClientNum ) && 
		( lastKills[ 0 ] && lastKills[ 0 ]->gibbed && lastKills[ 0 ]->victimClientNum != playerClientNum ) && 
		( lastKills[ 1 ] && lastKills[ 1 ]->gibbed && lastKills[ 1 ]->victimClientNum != playerClientNum ) ) {
			statManager->GiveInGameAward( IGA_RAMPAGE, playerClientNum );
	}


	// check for combo kill award
	if( victimClientNum != playerClientNum && !idStr::Icmp( player->spawnArgs.GetString( va( "def_weapon%d", methodOfDeath ) ), "weapon_railgun" ) ) {
		// the rail killing shot is the last hit, so look for the one past that
		rvStatHit* lastHits[ 2 ] = { NULL, NULL };

		statManager->GetLastClientStats( playerClientNum, ST_HIT, gameLocal.time - 3000, 2, (rvStat**)lastHits );

		if( lastHits[ 1 ] && lastHits[ 1 ]->GetVictimClientNum() != playerClientNum && !idStr::Icmp( player->spawnArgs.GetString( va( "def_weapon%d", lastHits[ 1 ]->GetWeapon() ) ), "weapon_rocketlauncher" )  ) {
			statManager->GiveInGameAward( IGA_COMBO_KILL, playerClientNum );
		}
	}


	// check for defense award
	if( gameLocal.IsFlagGameType() && player->team != victim->team && player != victim ) {
		if( ((rvCTFGameState*)gameLocal.mpGame.GetGameState())->GetFlagState( player->team ) == FS_AT_BASE ) {
			if( ( gameLocal.mpGame.flagBaseLocation[ player->team ] - player->GetPhysics()->GetOrigin() ).LengthSqr() < 250000 ) {
				statManager->GiveInGameAward( IGA_DEFENSE, playerClientNum );
			} else if ( victim->team != player->team && ( gameLocal.mpGame.flagBaseLocation[ player->team ] - victim->GetPhysics()->GetOrigin() ).LengthSqr() < 250000 ) {
				statManager->GiveInGameAward( IGA_DEFENSE, playerClientNum );
			}
		}
	}

	// check for holy shit award
	if( gameLocal.IsFlagGameType() && player->team != victim->team && player != victim ) {
		if( (player->team == TEAM_MARINE && victim->PowerUpActive( POWERUP_CTF_MARINEFLAG )) ||
			(player->team == TEAM_STROGG && victim->PowerUpActive( POWERUP_CTF_STROGGFLAG )) ) {
			if( ((rvCTFGameState*)gameLocal.mpGame.GetGameState())->GetFlagState( victim->team ) == FS_AT_BASE ) {
				if( (gameLocal.mpGame.flagBaseLocation[ victim->team ] - victim->GetPhysics()->GetOrigin()).LengthSqr() < 40000 ) {
					statManager->GiveInGameAward( IGA_HOLY_SHIT, playerClientNum );					
				}
			}
		}
	}
	*/
}

/*
================
rvStatDeath

A player died
================
*/
rvStatDeath::rvStatDeath( int t, int p, int mod ) : rvStat( t ) {
	type = ST_DEATH; 
	playerClientNum = p;
	RegisterInGame( statManager->GetPlayerStats() );
}

void rvStatDeath::RegisterInGame( rvPlayerStat* stats ) {
	stats[ playerClientNum ].deaths++;	
}

/*
================
rvStatDamageDealt

A player damaged another player
================
*/
rvStatDamageDealt::rvStatDamageDealt( int t, int p, int w, int d ) : rvStat( t ) { 
	playerClientNum = p;
	weapon = w;
	damage = d;
	type = ST_DAMAGE_DEALT; 
	RegisterInGame( statManager->GetPlayerStats() );
}

void rvStatDamageDealt::RegisterInGame( rvPlayerStat* stats ) {
	if( playerClientNum >= 0 && playerClientNum < MAX_CLIENTS ) {
		stats[ playerClientNum ].damageGiven += damage;	
	}
}

/*
================
rvStatDamageTaken

A player took damage from another player
================
*/
rvStatDamageTaken::rvStatDamageTaken( int t, int p, int w, int d ) : rvStat( t ) { 
	playerClientNum = p;
	weapon = w;
	damage = d;
	type = ST_DAMAGE_TAKEN; 
	RegisterInGame( statManager->GetPlayerStats() );
}

void rvStatDamageTaken::RegisterInGame( rvPlayerStat* stats ) {
	if( playerClientNum >= 0 && playerClientNum < MAX_CLIENTS ) {
		stats[ playerClientNum ].damageTaken += damage;	
	}
}

/*
================
rvStatFlagDrop

A player dropped the flag (CTF)
================
*/
rvStatFlagDrop::rvStatFlagDrop( int t, int p, int a, int tm ) : rvStatTeam( t, tm ) { 
	playerClientNum = p;
	attacker = a;
	type = ST_CTF_FLAG_DROP; 
}

/*
================
rvStatFlagReturn

A player returned his teams flag
================
*/
rvStatFlagReturn::rvStatFlagReturn( int t, int p, int tm ) : rvStatTeam( t, tm ) { 
	playerClientNum = p;
	type = ST_CTF_FLAG_RETURN; 
}

/*
================
rvStatFlagCapture

A player captured a flag (CTF)
================
*/
rvStatFlagCapture::rvStatFlagCapture( int t, int p, int f, int tm ) : rvStatTeam( t, tm ) { 
	playerClientNum = p;
	flagTeam = f;
	type = ST_CTF_FLAG_CAPTURE; 
	RegisterInGame( statManager->GetPlayerStats() );
}

void rvStatFlagCapture::RegisterInGame( rvPlayerStat* stats ) {
	statManager->GiveInGameAward( IGA_CAPTURE, playerClientNum );
	// figure out if we need to give an assist

	// see if someone carried the flag a bit, lost it, but it was capped
	rvStatFlagDrop* flagDrop = (rvStatFlagDrop*)statManager->GetLastTeamStat( team, ST_CTF_FLAG_DROP, gameLocal.time - 10000 );
	if( flagDrop && flagDrop->GetTeam() == team ) {
		// only give the award if there was no flag return between the flag drop and the flag capture
		rvStatFlagReturn* flagReturn = (rvStatFlagReturn*)statManager->GetLastTeamStat( flagTeam, ST_CTF_FLAG_RETURN, gameLocal.time - 10000 );
		if( flagReturn == NULL ) {
			statManager->GiveInGameAward( IGA_ASSIST, flagDrop->GetPlayerClientNum() );
		}
	}

	// see if someone returned the flag, allowing a cap
	rvStatFlagReturn* flagReturn = (rvStatFlagReturn*)statManager->GetLastTeamStat( team, ST_CTF_FLAG_RETURN, gameLocal.time - 10000 );
	if( flagReturn ) {
		statManager->GiveInGameAward( IGA_ASSIST, flagReturn->GetPlayerClientNum() );
	}
}
