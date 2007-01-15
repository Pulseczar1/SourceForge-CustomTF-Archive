#ifndef __Q4F_MISC_H__
#define __Q4F_MISC_H__


/*
===============================================================================

	AntiTeam

===============================================================================
*/

class q4fAntiTeam : public idEntity {
	CLASS_PROTOTYPE( q4fAntiTeam );

public:
	

	void				Spawn( void );
	void				Think( void );

	static idVec3		GetReflection( idEntity* ent, trace_t* trace );

protected:

	void				Event_Touch( idEntity *other, trace_t *trace );

public:

	bool				killPlayers;
	bool				blockPlayers;
	bool				killProj;
	bool				blockProj;

	TFDamage			myDamage;
};


#endif