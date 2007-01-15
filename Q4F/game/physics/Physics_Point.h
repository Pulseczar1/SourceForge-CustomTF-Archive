#ifndef __PHYSICS_POINT_H__
#define __PHYSICS_POINT_H__

/*
===================================================================================

	Point Physics

	Similar to particle, but relies only on tracepoints and a given radius
	Very simplistic, nothing can run into this

	may alter in the future to allow a given radius and length

===================================================================================
*/

typedef struct pointPState_s {
	bool					atRest;
	idVec3					origin;
	idVec3					velocity;
	idMat3					axis;
	bool					onGround;
	bool					inWater;
} pointPState_t;

class q4fPhysics_Point : public idPhysics_Base {

public:

	CLASS_PROTOTYPE( q4fPhysics_Point );

							q4fPhysics_Point( void );
							~q4fPhysics_Point( void );

							// initialisation
	void					SetFriction( const float linear, const float angular, const float contact );
	void					SetBouncyness( const float b, bool allowBounce );

	void					SetRadius( float radius ) { this->radius = radius; };

							// put to rest untill something collides with this physics object
	void					PutToRest( void );
							// same as above but drop to the floor first
	void					DropToFloor( void );

							// returns true if touching the ground
	bool					IsOnGround ( void ) const;
	bool					IsInWater ( void ) const;

public:	// common physics interface
	void					SetClipModel( idClipModel *model, float density, int id = 0, bool freeOld = true ) { if ( model ) delete model; };
	idClipModel *			GetClipModel( int id = 0 ) const { return NULL; };
	int						GetNumClipModels( void ) const { return 0; };

	void					SetContents( int contents, int id = -1 );
	int						GetContents( int id = -1 ) const;

	const idBounds &		GetBounds( int id = -1 ) const;
	const idBounds &		GetAbsBounds( int id = -1 ) const;

	bool					Evaluate( int timeStepMSec, int endTimeMSec );
	void					UpdateTime( int endTimeMSec );
	int						GetTime( void ) const;

	bool					CanBounce ( void ) const;

	bool					EvaluateContacts( void );

	void					Activate( void );
	bool					IsAtRest( void ) const;
	int						GetRestStartTime( void ) const;
	bool					IsPushable( void ) const;

	//void					SaveState( void );
	//void					RestoreState( void );

	void					SetOrigin( const idVec3 &newOrigin, int id = -1 );
	void					SetAxis( const idMat3 &newAxis, int id = -1 );

	void					Translate( const idVec3 &translation, int id = -1 );
	void					Rotate( const idRotation &rotation, int id = -1 );

	const idVec3 &			GetOrigin( int id = 0 ) const;
	const idMat3 &			GetAxis( int id = 0 ) const;

	void					SetLinearVelocity( const idVec3 &newLinearVelocity, int id = 0 );

	const idVec3 &			GetLinearVelocity( int id = 0 ) const;

	//void					ClipTranslation( trace_t &results, const idVec3 &translation, const idClipModel *model ) const;
	//void					ClipRotation( trace_t &results, const idRotation &rotation, const idClipModel *model ) const;
	//int					ClipContents( const idClipModel *model ) const;

	//void					DisableClip( void );
	//void					EnableClip( void );

	//void					UnlinkClip( void );
	//void					LinkClip( void );

	//void					SetPushed( int deltaTime );
	//const idVec3 &			GetPushedLinearVelocity( const int id = 0 ) const;

	//void					SetMaster( idEntity *master, const bool orientated );

	void					WriteToSnapshot( idBitMsgDelta &msg ) const;
	void					ReadFromSnapshot( const idBitMsgDelta &msg );

	idEntityPtr<idEntity>	extraPassEntity;

	bool					alwaysCheckGround;

private:
	// state of the particle
	pointPState_t		current;

	float					radius;

	// particle properties
	float					linearFriction;				// translational friction
	float					angularFriction;			// rotational friction
	float					contactFriction;			// friction with contact surfaces
	float					bouncyness;					// bouncyness
	bool					allowBounce;				// Allowed to bounce at all?

	bool					dropToFloor;				// true if dropping to the floor and putting to rest
	bool					testSolid;					// true if testing for inside solid during a drop

	contactInfo_t			contact;
	int						contents;
	idBounds				bounds;
	idBounds				absBounds;

	// master
	//bool					hasMaster;
	//bool					isOrientated;

private:

	void					DropToFloorAndRest	( void );
	bool					SlideMove			( idVec3& start, idVec3& velocity, const idVec3& delta );
	bool					CheckGround			( void );
	void					ApplyFriction		( float timeStep );
	//void					DebugDraw			( void );

public:
	bool					SetWaterLevel( void );
};

ID_INLINE bool q4fPhysics_Point::IsOnGround ( void ) const {
	return current.onGround;
}

ID_INLINE bool q4fPhysics_Point::IsInWater ( void ) const {
	return current.inWater;
}

ID_INLINE bool q4fPhysics_Point::CanBounce ( void ) const {
	return allowBounce;
}

#endif /* !__PHYSICS_PARTICLE_H__ */
