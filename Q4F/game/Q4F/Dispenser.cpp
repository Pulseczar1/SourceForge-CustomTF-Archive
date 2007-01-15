#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"

CLASS_DECLARATION( BuildableEntity, Dispenser )
	EVENT( EV_Explode, Dispenser::Explode )
END_CLASS

Dispenser::Dispenser() {
	built = false;
	healing = false;
	wasHealing = false;
	lastHealTime = 0;
}

Dispenser::~Dispenser() {
	SetPhysics( NULL );
}

void Dispenser::Spawn() {

	ammo_shells = 0;
	ammo_nails = 0;
	ammo_rockets = 0;
	ammo_cells = 0;
	armor = 0;
	nextRefillTime = 0;

	refill_delay = SEC2MS( spawnArgs.GetFloat( "refill_delay", "10" ) );
	refill_pct = spawnArgs.GetFloat( "refill_pct", "0.05" );

	max_ammo_shells = spawnArgs.GetInt( "max_ammo_shells", "100" );
	max_ammo_nails = spawnArgs.GetInt( "max_ammo_nails", "100" );
	max_ammo_rockets = spawnArgs.GetInt( "max_ammo_rockets", "100" );
	max_ammo_cells = spawnArgs.GetInt( "max_ammo_cells", "100" );
	max_armor = spawnArgs.GetInt( "max_armor", "100" );

	refill_take_shells = spawnArgs.GetInt( "refill_take_shells", "100" );
	refill_take_nails = spawnArgs.GetInt( "refill_take_nails", "100" );
	refill_take_rockets = spawnArgs.GetInt( "refill_take_rockets", "100" );
	refill_take_cells = spawnArgs.GetInt( "refill_take_cells", "100" );
	refill_take_armor = spawnArgs.GetInt( "refill_take_armor", "100" );

	max_health = spawnArgs.GetInt( "max_health", "100" );

	health = 0;

	oldHealth = 0;

	built = false;

	fl.takedamage = true;
}

#define DISP_HEAL_FADE_TIME 32

void Dispenser::Think() {

	idPlayer* owner = ownerInfo.GetPlayer();
	if ( owner == NULL || team != owner->team || ownerInfo.GetClass() != owner->currentPC ) {
		PostEventMS( &EV_Remove, 0 );
		return;
	}

	if ( !built ) {
		UpdateBuildEffect( UpdateBuildStatus() );
	}
	else {
		renderEntity.shaderParms[9] = 0.0f;
		healing = gameLocal.time - lastHealTime <= DISP_HEAL_FADE_TIME;

		if ( !wasHealing && healing ) {
			StartSound( "snd_healing", SND_CHANNEL_ITEM, 0, false, NULL );
		}
		else if ( wasHealing && !healing ) {
			StopSound( SND_CHANNEL_ITEM, false );
			StartSound( "snd_heal_stop", SND_CHANNEL_BODY, 0, false, NULL );
		}
		wasHealing = healing;

		if ( gameLocal.time >= nextRefillTime ) {

			ammo_shells = idMath::ClampInt( 0, max_ammo_shells, ammo_shells + refill_pct * max_ammo_shells );
			ammo_nails = idMath::ClampInt( 0, max_ammo_nails, ammo_nails + refill_pct * max_ammo_nails );
			ammo_rockets = idMath::ClampInt( 0, max_ammo_rockets, ammo_rockets + refill_pct * max_ammo_rockets );
			ammo_cells = idMath::ClampInt( 0, max_ammo_cells, ammo_cells + refill_pct * max_ammo_cells );
			armor = idMath::ClampInt( 0, max_armor, armor + refill_pct * max_armor );

			nextRefillTime = gameLocal.time + refill_delay;
		}
	}

	RunPhysics();
	Present();
}

void Dispenser::BuildStarted() {
	physicsObj.SetContents( CONTENTS_SOLID | CONTENTS_WRENCH );
	physicsObj.SetClipMask( physicsObj.GetClipMask() | CONTENTS_WRENCH );

	BecomeActive( TH_THINK );
}

void Dispenser::BuildFinished() {
	if ( gameLocal.isClient )
		return;

	built = true;

	nextRefillTime = refill_delay + gameLocal.time;

	health = max_health;

	idPlayer* owner = GetOwner();
	assert( owner );

	owner->dispenser = this;

	TFPlayerStats* stats = tfStatManager->GetPlayerStatsPlayer( owner );
	if ( stats ) {
		stats->dispenserBuildCount++;
	}
}

void Dispenser::Damage_TF( const TFDamage &dmg, float damageScale ) {

	// damage is only processed on server
	if ( gameLocal.isClient ) {
		return;
	}

	if ( health <= 0 )
		return;

	idEntity* attacker = dmg.GetAttacker().GetEntity();

	// check if we repair
	idPlayer* playerAttacker = dmg.GetAttacker().GetPlayer();
	if ( playerAttacker && playerAttacker->team == team ) {
		if ( dmg.GetDamageDict()->GetBool( "repair", "0" ) ) {

			int numCells = playerAttacker->inventory.ammo[AMMO_CELLS_INDEX];
			numCells -= Repair( numCells );			// returns how many cells are left
			assert( numCells >= 0 );

			numCells -= RefillCells( numCells );
			assert( numCells >= 0 );

			int numShells = playerAttacker->inventory.ammo[AMMO_SHELLS_INDEX];
			numShells -= RefillShells( numShells );
			assert( numShells >= 0 );

			int numNails = playerAttacker->inventory.ammo[AMMO_NAILS_INDEX];
			numNails -= RefillNails( numNails );
			assert( numNails >= 0 );

			int numRockets = playerAttacker->inventory.ammo[AMMO_ROCKETS_INDEX];
			numRockets -= RefillRockets( numRockets );
			assert( numRockets >= 0 );

			int numArmor = playerAttacker->inventory.armor;
			numArmor -= RefillArmor( numArmor );
			
           
			playerAttacker->inventory.ammo[AMMO_SHELLS_INDEX] = numShells;
			playerAttacker->inventory.ammo[AMMO_NAILS_INDEX] = numNails;
			playerAttacker->inventory.ammo[AMMO_ROCKETS_INDEX] = numRockets;
			playerAttacker->inventory.ammo[AMMO_CELLS_INDEX] = numCells;
			playerAttacker->inventory.armor = numArmor;
			return;
		}
	}

	if ( attacker != NULL ) {
		attacker->DamageFeedback_TF( this, dmg );
	}

	int damage = dmg.GetDamage();
	health -= damage;

	if ( health <= 0 ) {
		health = 0;

		//tfStatManager->Dispen( this, dmg );

		PostEventMS( &EV_Explode, 0 );
	}
}

void Dispenser::Explode() {
	StopAllEffects();
	Hide();

	if ( !gameLocal.isClient ) {
		gameLocal.PlayEffect( spawnArgs, "fx_explode", GetPhysics()->GetOrigin(), (-GetPhysics()->GetGravityNormal()).ToMat3(), false, vec3_origin, true );

		TFDamage tfDamage;
		tfDamage.Create( ownerInfo, spawnArgs.GetString( "def_damage_splode" ), 1.0f );

		int damage = spawnArgs.GetFloat( "dmg_shells" ) * ammo_shells;
		damage += spawnArgs.GetFloat( "dmg_nails" ) * ammo_nails;
		damage += spawnArgs.GetFloat( "dmg_rockets" ) * ammo_rockets;
		damage += spawnArgs.GetFloat( "dmg_cells" ) * ammo_cells;
		damage += spawnArgs.GetFloat( "dmg_armor" ) * armor;

		tfDamage.SetDamage( damage );

		gameLocal.RadiusDamage_TF( GetCenter(), tfDamage, this );

		PostEventMS( &EV_Remove, 0 );
	}
}

int Dispenser::Repair( int numCells ) {
	int damage = max_health - health;

	if ( damage > numCells )
		damage = numCells;

	health += damage;
	return damage;
}

int Dispenser::RefillShells( int numShells ) {
	if ( numShells <= 16 )
		return 0;

	numShells -= 16;

	int empty = max_ammo_shells - ammo_shells;
	
	if ( empty > numShells )
		empty = numShells;

	if ( empty > refill_take_shells )
		empty = refill_take_shells;

	ammo_shells += empty;
	return empty;
}

int Dispenser::RefillNails( int numNails ) {
	if ( numNails <= 10 )
		return 0;

	numNails -= 10;

	int empty = max_ammo_nails - ammo_nails;
	
	if ( empty > numNails )
		empty = numNails;

	if ( empty > refill_take_nails )
		empty = refill_take_nails;

	ammo_nails += empty;
	return empty;
}

int Dispenser::RefillRockets( int numRockets ) {
	int empty = max_ammo_rockets - ammo_rockets;
	
	if ( empty > numRockets )
		empty = numRockets;

	if ( empty > refill_take_rockets )
		empty = refill_take_rockets;

	ammo_rockets += empty;
	return empty;
}

int Dispenser::RefillCells( int numCells ) {
	int empty = max_ammo_cells - ammo_cells;
	
	if ( empty > numCells )
		empty = numCells;

	if ( empty > refill_take_cells )
		empty = refill_take_cells;

	ammo_cells += empty;
	return empty;
}

int Dispenser::RefillArmor( int numArmor ) {
	int empty = max_armor - armor;
	
	if ( empty > numArmor )
		empty = numArmor;

	if ( empty > refill_take_armor )
		empty = refill_take_armor;

	armor += empty;
	return empty;
}

void Dispenser::UpdateBuildEffect( float percent ) {

	if ( percent > 0.0f ) {
		percent = 1.0f - percent;

		renderEntity.shaderParms[9] = percent;
		UpdateVisuals();
	}
}

void Dispenser::WriteToSnapshot( idBitMsgDelta &msg ) const {
	BuildableEntity::WriteToSnapshot( msg );
	
	msg.WriteByte( health );
	msg.WriteBits( built ? 1 : 0, 1 );
	msg.WriteBits( healing ? 1 : 0, 1 );
}

void Dispenser::ReadFromSnapshot( const idBitMsgDelta &msg ) {
	BuildableEntity::ReadFromSnapshot( msg );
	
	health = msg.ReadByte();
	built = msg.ReadBits( 1 ) != 0;

	wasHealing = healing;
	healing = msg.ReadBits( 1 ) != 0;

	if ( !wasHealing && healing ) {
		StartSound( "snd_healing", SND_CHANNEL_ITEM, 0, false, NULL );
	}
	else if ( wasHealing && !healing ) {
		StopSound( SND_CHANNEL_ITEM, false );
		StartSound( "snd_heal_stop", SND_CHANNEL_BODY, 0, false, NULL );
	}
}

void Dispenser::ClientPredictionThink() {

	UpdateBuildEffect( GetBuildPercent( gameLocal.time ) );

	RunPhysics();
	Present();
}

void Dispenser::UpdateHud( idUserInterface* hud ) {
	if ( oldHealth < health ) {
		oldHealth += 2;

		if ( oldHealth > health )
			oldHealth = health;
	}
	else if ( oldHealth > health ) {
		oldHealth -= 2;

		if ( oldHealth < health )
			oldHealth = health;
	}

	hud->SetStateInt( "disp_health", oldHealth );
}

void Dispenser::EmpTouch( const AttackerInfo &attacker, idVec3 &dir, float damageScale ) {

	if ( !built )
		return;

	int damage = ( ammo_rockets * .5 ) + ( ammo_shells * .25 ) + ( ammo_cells * .3 );

	ammo_rockets *= 0.5f;
	ammo_shells *= 0.75f;
	ammo_cells *= 0.7f;

	TFDamage empDamage;
	empDamage.Create( attacker, spawnArgs.GetString( "def_empdamage" ), damageScale );
	empDamage.SetDamage( damage );
	gameLocal.RadiusDamage_TF( GetCenter(), empDamage, NULL );
}

int Dispenser::GiveResource( int &receiverCurrentAmount, int receiverMaxAmount,
							 int &stockAmount, int maxStockAmount, int giveAmount )
{

	if ( receiverCurrentAmount >= receiverMaxAmount )
		return 0;

	if ( stockAmount <= 0 )
		return 0;

	if ( giveAmount > stockAmount )
		giveAmount = stockAmount;

	giveAmount = idMath::ClampInt( 0, receiverMaxAmount - receiverCurrentAmount, giveAmount );

	receiverCurrentAmount += giveAmount;
	stockAmount -= giveAmount;

	return giveAmount;
}

float Dispenser::RefillPlayer( idPlayer* p ) {

	assert( p );

	int totalMax = 0;
	int totalHas = 0;
	int totalGive = 0;

	int max = p->inventory.MaxAmmoForAmmoClass( p, "ammo_shells" );
	totalMax += max;

	totalGive += GiveResource( p->inventory.ammo[ AMMO_SHELLS_INDEX ], max,
		ammo_shells, max_ammo_shells, 1 );

	totalHas += p->inventory.ammo[ AMMO_SHELLS_INDEX ];

	max = p->inventory.MaxAmmoForAmmoClass( p, "ammo_nails" );
	totalMax += max;

	totalGive += GiveResource( p->inventory.ammo[ AMMO_NAILS_INDEX ], max,
		ammo_nails, max_ammo_nails, 1 );

	totalHas += p->inventory.ammo[ AMMO_NAILS_INDEX ];

	max = p->inventory.MaxAmmoForAmmoClass( p, "ammo_rockets" );
	totalMax += max;

	totalGive += GiveResource( p->inventory.ammo[ AMMO_ROCKETS_INDEX ], max,
		ammo_rockets, max_ammo_rockets, 1 );

	totalHas += p->inventory.ammo[ AMMO_ROCKETS_INDEX ];

	max = p->inventory.MaxAmmoForAmmoClass( p, "ammo_cells" );
	totalMax += max;

	totalGive += GiveResource( p->inventory.ammo[ AMMO_CELLS_INDEX ], max,
		ammo_cells, max_ammo_cells, 1 );

	totalHas += p->inventory.ammo[ AMMO_CELLS_INDEX ];

	totalMax += p->inventory.maxarmor;

	totalGive += GiveResource( p->inventory.armor, p->inventory.maxarmor,
		armor, max_armor, 1 );

	totalHas += p->inventory.armor;

	if ( totalGive <= 0 )
		return 1.0f;

	if ( totalMax <= 0 )
		return 1.0f;

	return (float)totalHas / (float)totalMax;
}
