#ifndef __Q4F_DETPAK_H__
#define __Q4F_DETPAK_H__

typedef struct {
	idVec3		velocity;
	idVec3		origin;
	int			timeStart;
	int			timeEnd;
	int			lastCalcTime;
	float		distSum;
	float		distLastSplode;
} detPackProjectile_t;

#define NUM_DETPACK_PROJECTILES 15

class DetPak : public BuildableEntity {
	CLASS_PROTOTYPE( DetPak );

public:
	DetPak( void );
	~DetPak( void );

	void			Spawn( void );
	void			Think( void );

	virtual void	WriteToSnapshot( idBitMsgDelta &msg ) const;
	virtual void	ReadFromSnapshot( const idBitMsgDelta &msg );

	float			GetTimeRemaining();

	int				splodeTime;

	void			EmpTouch( const AttackerInfo &attacker, idVec3 &dir, float damageScale );

protected:
	void			Event_Charge( void );
	void			Event_Explode( void );
	void			BuildFinished( void );
	void			BuildStarted( void );

	void			UpdateExplosion( void );
	void			CalcNextPosition( detPackProjectile_t &proj );
	void			DoExplosion( const detPackProjectile_t &proj );

	void			DrawExplosion( const idVec3 &pos, float radius );

	float			GetProjRadius( const detPackProjectile_t &proj );

private:

	TFDamage		myDamage;

	detPackProjectile_t		projectiles[NUM_DETPACK_PROJECTILES];

	bool			oldStyle;

	bool			exploded;
	bool			built;

	int				projCalcDelay;
	float			maxStartSpeed;
	float			minStartSpeed;
	int				maxLifeTime;
	int				minLifeTime;
	float			airFriction;
	float			gravityScale;
	float			minSplodeDist;
	float			bounce;
	bool			onlyLOS;

};

ID_INLINE float DetPak::GetTimeRemaining( void ) {
	if ( splodeTime <= 0 ) {
		return 0.0f;
	}
	return MS2SEC( splodeTime - gameLocal.time );
}

#endif
