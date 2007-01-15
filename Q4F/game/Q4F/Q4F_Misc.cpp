#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"

/*
===============================================================================

	AntiTeam

===============================================================================
*/

CLASS_DECLARATION( idEntity, q4fAntiTeam )
	EVENT( EV_Touch,			q4fAntiTeam::Event_Touch )
END_CLASS

void q4fAntiTeam::Spawn() {
	blockPlayers	= spawnArgs.GetBool( "block_players", "0" );
	killPlayers		= spawnArgs.GetBool( "kill_players", "0" );
	blockProj		= spawnArgs.GetBool( "block_projectiles", "0" );
	killProj		= spawnArgs.GetBool( "kill_projectiles", "0" );

	/*if ( blockProj ) {
		gameLocal.Warning( "q4fAntiTeam - blocking projectiles has been removed, assuming kill projectiles." );
		killProj = true;
	}*/

	AttackerInfo me;
	me.Create( this );

	myDamage.Create( me, spawnArgs.GetString( "def_damage", "" ), 1.0f );

	int contents = 0;
	
	if ( blockPlayers || killPlayers )
		contents |= CONTENTS_BODY | CONTENTS_FORCEFIELD;

	if ( blockProj || killProj )
		contents |= CONTENTS_PROJECTILECLIP | CONTENTS_FORCEFIELD;

	GetPhysics()->SetContents( contents );

	BecomeActive( TH_THINK );
}

void q4fAntiTeam::Think() {
	idEntity::Think();
}

idVec3 q4fAntiTeam::GetReflection( idEntity* ent, trace_t* trace ) {
	assert( ent && trace );

	idVec3 velocity = ent->GetPhysics()->GetLinearVelocity();

	float dot = velocity * trace->c.normal;

	idVec3 reflection = ( velocity - ( 2.0f * dot * trace->c.normal ) );
	reflection.Normalize();
	return reflection;
}

void q4fAntiTeam::Event_Touch( idEntity *other, trace_t *trace ) {
	if ( !other || !trace || trace->c.normal.IsZero() )
		return;

	if ( other->IsType( idPlayer::GetClassType() ) && other->team != team ) {
		if ( killPlayers ) {
			other->Damage_TF( myDamage, 1.0f );
		}
		/*else if ( pushPlayers ) {
			idVec3 dir = GetReflection( other, trace );
			other->GetPhysics()->SetOrigin( other->GetPhysics()->GetOrigin() + ( dir * 5.0f ) );
			dir *= 350.0f;
			other->GetPhysics()->SetLinearVelocity( dir );
		}*/
	}
	else if ( other->IsType( idProjectile::GetClassType() ) ) {
		idProjectile* proj = static_cast<idProjectile*>(other);

		if ( killProj ) {
			proj->ProcessEvent( &EV_Detonate );
		}
		else if ( blockProj ) {
			idVec3 dir = GetReflection( other, trace );
			proj->Relaunch( dir );
		}		
	}

}