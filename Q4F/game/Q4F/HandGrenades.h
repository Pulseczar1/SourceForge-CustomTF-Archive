/*
===================================================================================

	Implementations for all hand grenades

===================================================================================
*/

#ifndef __Q4F_HANDGRENADE_H__
#define __Q4F_HANDGRENADE_H__

#if !defined(__GAME_PROJECTILE_H__)
	#include "../Projectile.h"
#endif

//============================================================================================================
// Base hand grenade class
//============================================================================================================
class HandGrenade : public idProjectile {
public:

	ABSTRACT_PROTOTYPE( HandGrenade );

							HandGrenade( void );
//							~HandGrenade( void );

	void					Spawn( void );

	// non-abstract functions

	void					Event_Detonate( void );		// called when fuse runs out
	//void					Event_Explode( void );		// grenade literally explodes

	virtual void			WriteToSnapshot( idBitMsgDelta &msg ) const;
	virtual void			ReadFromSnapshot( const idBitMsgDelta &msg );

	// abstract

	virtual void			Detonate( void );				// called when fuse runs out

protected:

	bool					detonated;

	ENTDEF					projectileDef;
};

//============================================================================================================
// Frag grenade class
//============================================================================================================
class FragGrenade : public HandGrenade {
public :
	CLASS_PROTOTYPE( FragGrenade );

	void				Detonate( void );
};

//============================================================================================================
// Concussion grenade class
//============================================================================================================
class ConcussionGrenade : public HandGrenade {
public :
	CLASS_PROTOTYPE( ConcussionGrenade );

	void				Detonate( void );
};

//============================================================================================================
// Nail grenade class
//============================================================================================================
class NailGrenade : public FragGrenade {
public :
	CLASS_PROTOTYPE( NailGrenade );

						NailGrenade( void );

	void				Spawn( void );

	void				Think( void );

	void				Detonate( void );

	virtual bool		GetPhysicsToVisualTransform( idVec3 &origin, idMat3 &axis );

	void				Event_FireNail( void );

	virtual void			WriteToSnapshot( idBitMsgDelta &msg ) const;
	virtual void			ReadFromSnapshot( const idBitMsgDelta &msg );

private:

	bool				nailSoundToggle;

	int					nailCount;
};

//============================================================================================================
// Cluster grenade class
//============================================================================================================
class ClusterGrenade : public HandGrenade {
public :
	CLASS_PROTOTYPE( ClusterGrenade );

	void				Detonate( void );
};

//============================================================================================================
// Napalm grenade class
//============================================================================================================
class NapalmGrenade : public HandGrenade {
public :
	CLASS_PROTOTYPE( NapalmGrenade );

	void				Detonate( void );
};

//============================================================================================================
// Napalm Fire
//============================================================================================================
class NapalmFire : public idProjectile {
public :
	CLASS_PROTOTYPE( NapalmFire );

							NapalmFire( void );
							~NapalmFire( void );

	void					Spawn( void );

	bool					Collide( const trace_t &collision, const idVec3 &velocity );
	void					Launch( const idVec3 &start, const idVec3 &dir, const idVec3 &pushVelocity, const float timeSinceFire = 0.0f, const float dmgPower = 1.0f );

	virtual void			WriteToSnapshot( idBitMsgDelta &msg ) const;
	virtual void			ReadFromSnapshot( const idBitMsgDelta &msg );

private:
	void					Event_Touch( idEntity *other, trace_t *trace );

	int						nextDamageTime;
};

//============================================================================================================
// Gas grenade class
//============================================================================================================

class GasGrenade : public HandGrenade {
	CLASS_PROTOTYPE( GasGrenade );
public :

						GasGrenade( void );
						~GasGrenade( void );

	void				Detonate( void );

	void				Think( void );

	//virtual bool		GetPhysicsToVisualTransform( idVec3 &origin, idMat3 &axis );

	void				Spawn( void );

private:

	void				DoDamage( void );

	float				effectRadius;
	int					effectEndTime;
	int					nextDamageTime;
};


//============================================================================================================
// Emp grenade class
//============================================================================================================
class EmpGrenade : public HandGrenade {
public :
	CLASS_PROTOTYPE( EmpGrenade );

	void				Detonate( void );
};

#endif
