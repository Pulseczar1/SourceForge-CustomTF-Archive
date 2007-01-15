#ifndef __WATER_H__
#define __WATER_H__

/*
===============================================================================

	Entity to control various water properties

===============================================================================
*/

#define BUBBLE_PER_UNIT_LENGTH 25.0f
#define BUBBLE_BETWEEN_TIME 500

class q4fWater : public idEntity {
public:
	CLASS_PROTOTYPE( q4fWater );

						q4fWater( void );

	void				Spawn( void );

	void				Think( void );
	void				ClientPredictionThink( void );

private:
	
};

#endif