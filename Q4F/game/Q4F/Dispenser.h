#ifndef __Q4F_DISPENSER_H__
#define __Q4F_DISPENSER_H__


class Dispenser : public BuildableEntity {
	CLASS_PROTOTYPE( Dispenser );
public:

					Dispenser( void );
					~Dispenser( void );

	virtual void			Spawn( void );
	virtual void			Think( void );
	virtual void			ClientPredictionThink( void );

	virtual void			UpdateHud( idUserInterface* hud );

	virtual void			Damage_TF( const TFDamage &tfDamage, float damageScale );

	virtual void			WriteToSnapshot( idBitMsgDelta &msg ) const;
	virtual void			ReadFromSnapshot( const idBitMsgDelta &msg );

	virtual void	EmpTouch( const AttackerInfo &attacker, idVec3 &dir, float damageScale );

	void			Explode( void );

	float			RefillPlayer( idPlayer* p );

	int				ammo_shells;
	int				ammo_nails;
	int				ammo_rockets;
	int				ammo_cells;
	int				armor;

	int				lastHealTime;

protected:
	virtual void			BuildFinished( void );
	virtual void			BuildStarted( void );	

private:

	int				GiveResource( int &receiverCurrentAmount, int receiverMaxAmount,
									int &stockAmount, int maxStockAmount, int giveAmount );

	void			UpdateBuildEffect( float percent );

	int				Repair( int numCells );

	int				RefillShells( int numShells );
	int				RefillNails( int numNails );
	int				RefillRockets( int numRockets );
	int				RefillCells( int numCells );
	int				RefillArmor( int numArmor );

	bool			built;

	bool			wasHealing;
	bool			healing;

	int				oldHealth;

	int				nextRefillTime;
	int				refill_delay;
	float			refill_pct;

	int				max_ammo_shells;
	int				max_ammo_nails;
	int				max_ammo_rockets;
	int				max_ammo_cells;
	int				max_armor;

	int				max_health;

	int				refill_take_shells;
	int				refill_take_nails;
	int				refill_take_rockets;
	int				refill_take_cells;
	int				refill_take_armor;
};

#endif
