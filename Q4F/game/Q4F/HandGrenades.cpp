#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"
#include "../Projectile.h"
#include "HandGrenades.h"

//============================================================================================================
// Base hand grenade class
//============================================================================================================

ABSTRACT_DECLARATION( idProjectile, HandGrenade )
	EVENT( EV_Detonate,			HandGrenade::Event_Detonate )
	//EVENT( EV_Explode,			HandGrenade::Event_Explode )
END_CLASS


//--------------------------------------------------------------------------
// Constructor, init member variables.
//--------------------------------------------------------------------------
HandGrenade::HandGrenade() {
	projectileDef		= NULL;
	fl.networkSync		= true;
	detonated			= false;
}

void HandGrenade::Spawn() {
	const char* pDef = NULL;
	if ( spawnArgs.GetString( "def_projectile", "", &pDef ) && pDef && pDef[0] ) {
		projectileDef = gameLocal.FindEntityDef( pDef, false );
	}
	else {
		projectileDef = NULL;
	}
}

//--------------------------------------------------------------------------
// Inherited by child classes
//--------------------------------------------------------------------------
void HandGrenade::Detonate() {
	Hide();

	CancelEvents( &EV_Detonate );

	fl.takedamage = false;
	physicsObj.SetContents( 0 );
	physicsObj.PutToRest();
	StopAllEffects();
}

//--------------------------------------------------------------------------
// Grenade explodes, causing splash damage
//--------------------------------------------------------------------------
/*void HandGrenade::Event_Explode() {

	if ( state == EXPLODED || state == FIZZLED ) {
		return;
	}

	Hide();
	fl.takedamage = false;
	physicsObj.SetContents( 0 );
	physicsObj.PutToRest();

	if ( gameLocal.isClient ) {
		return;
	}

	PlayDetonateEffect( GetPhysics()->GetOrigin(), GetPhysics()->GetAxis() );

	gameLocal.RadiusDamage_TF( physicsObj.GetOrigin(), dmgSplash, this ); 

	PostEventMS( &EV_Remove, 0 );
}*/


//--------------------------------------------------------------------------
// Event issues by server when the grenade timer runs out
// This function is constant for all grenades, but each one can have a different Detonate()
//--------------------------------------------------------------------------
void HandGrenade::Event_Detonate( void ) {
	// call the class's explode function
	detonated = true;
	Detonate();
}


void HandGrenade::WriteToSnapshot( idBitMsgDelta &msg ) const {
	idProjectile::WriteToSnapshot( msg );
	msg.WriteBits( detonated ? 1 : 0, 1 );
}
void HandGrenade::ReadFromSnapshot( const idBitMsgDelta &msg ) {
	idProjectile::ReadFromSnapshot( msg );
	
	bool hisDetonated = msg.ReadBits( 1 ) == 1;

	if ( hisDetonated != detonated ) {
		Detonate();
	}
	detonated = hisDetonated;
}

//============================================================================================================
// Frag grenade class
//============================================================================================================
CLASS_DECLARATION( HandGrenade, FragGrenade )
END_CLASS

void FragGrenade::Detonate() {
	HandGrenade::Detonate();

	if ( gameLocal.isClient )
		return;

	PostEventMS( &EV_Explode, 0 );
}

//============================================================================================================
// Concussion grenade class
//============================================================================================================
CLASS_DECLARATION( HandGrenade, ConcussionGrenade )
END_CLASS

void ConcussionGrenade::Detonate() {

	HandGrenade::Detonate();

	if ( gameLocal.isClient )
		return;

	PlayDetonateEffect( GetPhysics()->GetOrigin(), GetPhysics()->GetAxis() );

	float radius = dmgSplash.GetDamageDict()->GetFloat( "radius", "0" );
	float divisor = spawnArgs.GetFloat( "points_divisor", "20" );
//	float push = dmgSplash.GetDamageDict()->GetFloat( "push", "0" );

	entInRadius_t list[MAX_CLIENTS];

	idVec3 org = GetPhysics()->GetOrigin();

	// WEEEEEEEEEEEeEEEEEEEEeEEEEEEEEeEEEEEEEEeEEEEEEEEeEEEEEEEEeEEEEEEEEeEEEEEEEEeEEEEEEEEeEEEEEEEEeEEEEEEEEeEEEEEEEEeEEEEEEEEe
	int numDamageEnts = gameLocal.GetEntitiesInRadius( list, MAX_CLIENTS, org, radius, true );

	float scale;

	idVec3 dir;

	
	//radius += 40.0f;

	for ( int i = 0; i < numDamageEnts; i++ ) {
		assert( list[i].ent && list[i].ent->IsType( idPlayer::GetClassType() ) );

		idPlayer* p = static_cast<idPlayer*>(list[i].ent);

		/*org = head.origin + (head.mins + head.maxs)*0.5;
				points = 0.5*vlen (org - inflictor.origin);
				if (points < 0)
					points = 0;
				points = bounce - points;*/

		float points = list[i].distance * 0.5f;
		points = radius - points;

		idVec3 newVel = list[i].point - org;

		if ( p->currentPC == CLASS_HWGUY )
			newVel *= ( ( points / divisor ) * 0.25f );
		else
			newVel *= ( points / divisor );

		/*head.velocity = org - inflictor.origin;
					head.velocity = head.velocity * (points / 20);*/

		list[i].ent->GetPhysics()->SetLinearVelocity( newVel );
		p->ApplyImpulse( ownerInfo.GetEntity(), 0, org, vec3_zero, true );

		scale = list[i].distance / radius;

		//scale = 1.0f - scale;

		//list[i].ent->Push( org, push * scale );

		// make sure the conc effect is solid
		scale *= 0.75f;
		
		if ( list[i].ent->IsType( idPlayer::GetClassType() ) ) {
			dmgSplash.SetDamageScale( 1.0f - scale );
			p->AddAffliction( dmgSplash );
		}

		tfStatManager->EntityDamaged( list[i].ent, dmgSplash, false );
	}
 	
	PostEventMS( &EV_Remove, 0 );
}


//============================================================================================================
// Nail grenade class
//============================================================================================================

const idEventDef EV_FireNail( "<firenail>", NULL );

CLASS_DECLARATION( HandGrenade, NailGrenade )
	EVENT( EV_FireNail,		NailGrenade::Event_FireNail )
END_CLASS

static int NUM_NAILGREN_NAILS = 65;
static int MIN_NAIL_TIME_MS = 55;
static int MAX_NAIL_TIME_MS = 85;
static float UP_SPEED = 250.0f;
static float YAW_ACCEL = 2.0f;

NailGrenade::NailGrenade() {
	nailCount = NUM_NAILGREN_NAILS;
	nailSoundToggle = false;
}

void NailGrenade::Spawn() {
	nailCount = NUM_NAILGREN_NAILS;
	nailSoundToggle = false;
}

void NailGrenade::Think() {

	if ( state < LAUNCHED ) {
		return;
	}

	idProjectile::Think();


	if ( detonated ) {

		// stop linear velocity if not accelerating up
		idVec3 vel = GetPhysics()->GetLinearVelocity();
		float speed = vel.Length();
		if ( vel * GetPhysics()->GetGravityNormal() >= 0.0f ) {
			GetPhysics()->SetLinearVelocity( vec3_zero );
			GetPhysics()->SetGravity( vec3_zero );
			speed = 0.0f;
		}

		visualAngles.pitch *= ( speed / UP_SPEED );
		visualAngles.roll *= ( speed / UP_SPEED );

		visualAngles.yaw += YAW_ACCEL * gameLocal.msec;
	}
	else {
		UpdateVisualAngles();
	}
}

//--------------------------------------------------------------------------
// called by update visuals -> update model -> update model transform
//--------------------------------------------------------------------------
bool NailGrenade::GetPhysicsToVisualTransform( idVec3 &origin, idMat3 &axis ) {

	if ( detonated ) {
		origin.Zero();
		axis = visualAngles.ToMat3();
	}
	else {
		idProjectile::GetPhysicsToVisualTransform( origin, axis );
	}

	return true;
}

//--------------------------------------------------------------------------
// Nail grenade's initial exlosion just initializes the firing of nails
//--------------------------------------------------------------------------
void NailGrenade::Detonate() {

	GetPhysics()->SetLinearVelocity( GetPhysics()->GetGravityNormal() * -UP_SPEED );

	angularVelocity.Zero();
	rotation.Init( 0.0f, 0.0f, mat3_identity.ToQuat(), mat3_identity.ToQuat() );
	GetPhysics()->SetAxis( mat3_identity );

	if ( gameLocal.isClient )
		return;


	PostEventMS( &EV_FireNail, 500 );
}


//--------------------------------------------------------------------------
// Launches a single nail
//--------------------------------------------------------------------------
void NailGrenade::Event_FireNail() {

	if ( !projectileDef ) {
		gameLocal.Error( "NailGrenade::Event_FireNail: could not find projectile def" );
	}

	assert( !gameLocal.isClient );

	//tfStatManager->ShotFired( ownerInfo, projectileDef );

	idProjectile*	proj;
	idEntity*		ent;
	idVec3			dir = visualAngles.ToForward();
	idVec3			org = GetCenter();

	// fire check if we're spawning inside of an entity
	idEntity* orgEnt = NULL;
	idPlayer* player;
	for ( int i = 0; i < gameLocal.numClients; i++ ) {
		player = GET_PLAYER( i );
		if ( player && player->GetPhysics()->GetAbsBounds().ContainsPoint( org )) {
			orgEnt = player;
			break;
		}
	}

	if ( orgEnt ) {
		TFDamage projDamage;
		projDamage.Create( ownerInfo, projectileDef->dict.GetString( "def_damage_direct", "" ), dmgSplash.GetDamageScale() );
		projDamage.SetDir( ( orgEnt->GetCenter() - org ).ToNormal() );
		orgEnt->Damage_TF( projDamage, 1.0f );
	}
	else {
	
		gameLocal.SpawnEntityDef( projectileDef->dict, &ent, false );

		// Make sure it spawned
		if ( !ent || !ent->IsType( idProjectile::GetClassType() ) ) {
			gameLocal.Error( "failed to spawn nail for nail grenade" );
		}

		// Create the projectile
		proj = static_cast<idProjectile*>(ent);
		proj->Create( ownerInfo, org, dir, this, this );
			
		// Launch the actual projectile
		proj->Launch( org, dir, vec3_zero, 0, dmgSplash.GetDamageScale() );
	}

	StartSound( "snd_launch_nail", SND_CHANNEL_ITEM, 0, false, NULL );
	nailSoundToggle = !nailSoundToggle;

	nailCount--;

	if ( nailCount > 0 ) {
		PostEventMS( &EV_FireNail, gameLocal.random.RandomInt( MAX_NAIL_TIME_MS - MIN_NAIL_TIME_MS ) + MIN_NAIL_TIME_MS );
	}
	else {
		FragGrenade::Detonate();
	}
}

void NailGrenade::WriteToSnapshot( idBitMsgDelta &msg ) const {
	HandGrenade::WriteToSnapshot( msg );
	msg.WriteBits( nailSoundToggle ? 1 : 0, 1 );
}
void NailGrenade::ReadFromSnapshot( const idBitMsgDelta &msg ) {
	HandGrenade::ReadFromSnapshot( msg );
	bool newToggle = msg.ReadBits( 1 ) != 0;
	if ( newToggle != nailSoundToggle ) {
		StartSound( "snd_launch_nail", SND_CHANNEL_ITEM, 0, false, NULL );
		nailSoundToggle = newToggle;
	}
}


//============================================================================================================
// Cluster grenade class
//============================================================================================================

CLASS_DECLARATION( HandGrenade, ClusterGrenade )
END_CLASS

static int NUM_GRENS = 6;

//--------------------------------------------------------------------------
// Launch 6 frag grenades
//--------------------------------------------------------------------------
void ClusterGrenade::Detonate() {

	HandGrenade::Detonate();

	if ( gameLocal.isClient )
		return;


	// do our little explosion
	PostEventMS( &EV_Explode, 0 );

	// fire our hand grenades
	if ( !projectileDef ) {
		gameLocal.Error( "ClusterGrenade::Detonate: could not find projectile def" );
	}

	idVec3 org = GetCenter();
	idVec3 dir;
	idEntity* ent;
	HandGrenade* gren;
	for ( int i = 0; i < NUM_GRENS; i++ ) {

		//tfStatManager->ShotFired( ownerInfo, projectileDef );

		gameLocal.SpawnEntityDef( projectileDef->dict, &ent, false );

		if ( !ent || !ent->IsType( HandGrenade::GetClassType() ) ) {
			gameLocal.Error( "Could not spawn hand grenade from the cluster grenade" );
		}

		dir.x = ( 300.0f * gameLocal.random.CRandomFloat() ) - 75.0f;
		dir.y = ( 300.0f * gameLocal.random.CRandomFloat() ) - 75.0f;
		dir.z = 600.0f * gameLocal.random.RandomFloat();
		dir.Normalize();

		gren = static_cast<HandGrenade*>(ent);
		gren->Create( ownerInfo, org, dir, this );
		gren->Launch( org, dir, vec3_zero, 0.5f + gameLocal.random.CRandomFloat(), dmgSplash.GetDamageScale() ); 
	}

	
}

//============================================================================================================
// Napalm grenade class
//============================================================================================================

CLASS_DECLARATION( HandGrenade, NapalmGrenade )
END_CLASS

#define NUM_FIRES 6

void NapalmGrenade::Detonate() {

	HandGrenade::Detonate();

	if ( gameLocal.isClient )
		return;


	// do our little explosion
	PostEventMS( &EV_Explode, 0 );

	// fire our napalm fires
	if ( !projectileDef ) {
		gameLocal.Error( "NapalmGrenade::Detonate: could not find projectile def" );
	}

	idVec3 org = GetCenter();
	idVec3 dir;
	idAngles dirAngles( 0.0f, 0.0f, 0.0f );
	idEntity* ent;
	NapalmFire* fire;
	for ( int i = 0; i < NUM_FIRES; i++ ) {

		//tfStatManager->ShotFired( ownerInfo, projectileDef );

		gameLocal.SpawnEntityDef( projectileDef->dict, &ent, false );

		if ( !ent || !ent->IsType( NapalmFire::GetClassType() ) ) {
			gameLocal.Error( "Could not spawn napalm fire from napalm grenade" );
		}

		dirAngles.yaw = gameLocal.random.CRandomFloat() * 360.0f;
		dirAngles.pitch = gameLocal.random.RandomFloat() * -90.0f;

		dir = dirAngles.ToForward().ToNormal();

		fire = (NapalmFire*)ent;
		fire->Create( ownerInfo, org, dir, this );
		fire->Launch( org, dir, vec3_zero );
	}
}

//============================================================================================================
// Napalm Fire class
//============================================================================================================

CLASS_DECLARATION( idProjectile, NapalmFire )
	EVENT( EV_Touch,			NapalmFire::Event_Touch )
END_CLASS

NapalmFire::NapalmFire() {
	nextDamageTime = -1;

	fl.takedamage = false;
	fl.networkSync = true;
}

NapalmFire::~NapalmFire() {
	SetPhysics( NULL );
	StopAllEffects();
}

void NapalmFire::Spawn() {
	nextDamageTime = -1;
}

void NapalmFire::Launch( const idVec3 &start, const idVec3 &dir, const idVec3 &pushVelocity, const float timeSinceFire, const float dmgPower ) {
	idProjectile::Launch( start, dir, pushVelocity, timeSinceFire, dmgPower );
	physicsObj.SetContents( physicsObj.GetContents() | CONTENTS_TRIGGER );
}

#define TOUCH_DELAY 500

//--------------------------------------------------------------------------
// Napalm is sticky, align to collision and stop physics
//--------------------------------------------------------------------------
bool NapalmFire::Collide( const trace_t &collision, const idVec3 &velocity ) {

	bool ret = idProjectile::Collide( collision, velocity );

	idEntity* ent = gameLocal.GetTraceEntity( collision );

	if ( ent && !( ent->IsType( idPlayer::GetClassType() ) ) ) {
		Bind( ent, false );
	}

	return ret;
}

void NapalmFire::WriteToSnapshot( idBitMsgDelta &msg ) const {
	idProjectile::WriteToSnapshot( msg );
	WriteBindToSnapshot( msg );
}
void NapalmFire::ReadFromSnapshot( const idBitMsgDelta &msg ) {
	idProjectile::ReadFromSnapshot( msg );
	ReadBindFromSnapshot( msg );
}

//--------------------------------------------------------------------------
// Called when a player steps into our contents
//--------------------------------------------------------------------------
void NapalmFire::Event_Touch( idEntity *other, trace_t *trace ) {
	if ( gameLocal.time >= nextDamageTime ) {
		dmgDirect.SetDir( ( other->GetPhysics()->GetAbsBounds().GetCenter() - GetPhysics()->GetAbsBounds().GetCenter() ).ToNormal() );
		other->Damage_TF( dmgDirect, 1.0f );
		nextDamageTime = gameLocal.time + TOUCH_DELAY;
	}
}

//============================================================================================================
// Emp grenade class
//============================================================================================================
CLASS_DECLARATION( HandGrenade, EmpGrenade )
END_CLASS


//--------------------------------------------------------------------------
// Explode ammunition & armor
//--------------------------------------------------------------------------
void EmpGrenade::Detonate() {
	
	HandGrenade::Detonate();

	if ( gameLocal.isClient )
		return;

	PlayDetonateEffect( GetPhysics()->GetOrigin(), GetPhysics()->GetAxis() );

	// find all entities in radius
	entInRadius_t list[128];
	idVec3 origin = GetPhysics()->GetOrigin();
	float radius = spawnArgs.GetFloat( "radius", "1.0f" );
	int numEnts = gameLocal.GetEntitiesInRadius( list, 128, GetPhysics()->GetOrigin(), radius, false );

	for ( int i = 0; i < numEnts; i++ ) {
		assert( list[i].ent );
		// let the entity know they've been EMP'd
		list[i].ent->EmpTouch( ownerInfo, list[i].dir, dmgSplash.GetDamageScale() );
	}
 	
	PostEventMS( &EV_Remove, 0 );
}







//============================================================================================================
// Gas grenade class
//============================================================================================================
CLASS_DECLARATION( HandGrenade, GasGrenade )
END_CLASS

GasGrenade::GasGrenade() {
}

GasGrenade::~GasGrenade() {
	StopEffect( "fx_gas" );
}

void GasGrenade::Spawn() {
	effectEndTime = SEC2MS( spawnArgs.GetFloat( "effect_time", "10" ) );
	effectRadius = spawnArgs.GetFloat( "effect_radius", "128" );
	nextDamageTime = 0;
}

void GasGrenade::Detonate() {
	PlayEffect( "fx_gas", renderEntity.origin, mat3_identity, true );

	effectEndTime += gameLocal.time;

	GetPhysics()->SetAxis( mat3_identity );

	BecomeActive( TH_THINK );
}

#define DAMAGE_CHECK_TIME 100

void GasGrenade::Think() {

	if ( thinkFlags & TH_PHYSICS ) {
		RunPhysics();
		UpdateVisualAngles();
	}
		
	Present();

	if ( detonated ) {

		if ( gameLocal.time >= effectEndTime ) {
			StopEffect( "fx_gas" );
			PostEventMS( &EV_Remove, 0 );
			detonated = false;
			return;
		}

		if ( gameLocal.time > nextDamageTime ) {
			nextDamageTime = gameLocal.time + DAMAGE_CHECK_TIME;

			DoDamage();
		}
	}
}

void GasGrenade::DoDamage() {
	entInRadius_t entList[MAX_CLIENTS];

	idVec3 damagepoint;

	idVec3 effectOrigin = GetPhysics()->GetOrigin();

	int numEnts = gameLocal.GetEntitiesInRadius( entList, MAX_CLIENTS, effectOrigin, effectRadius, true );

	for ( int i = 0; i < numEnts; i++ ) {
		assert( entList[i].ent );
		if ( entList[i].ent->CanDamage( GetPhysics()->GetOrigin(), damagepoint, this ) ) {
			dmgSplash.SetDir( entList[i].dir );

			entList[i].ent->Damage_TF( dmgSplash, 1.0f );
		}
	}
}
