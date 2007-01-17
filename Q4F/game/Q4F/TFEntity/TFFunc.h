/*
===================================================================================

	q4f functions and misc ents

===================================================================================
*/

#ifndef __TFFunc_H__
#define __TFFunc_H__


//--------------------------------------------------------------------------
// Spawning position for players
// Triggering this will cause the player to be spawned to this spot
// unlike idPlayerStart, this is instant
//--------------------------------------------------------------------------
class q4fPlayerStart : public TFEntity {
public:
	CLASS_PROTOTYPE( q4fPlayerStart );

	enum {
		EVENT_TELEPORTPLAYER = TFEntity::EVENT_MAXEVENTS,
		EVENT_MAXEVENTS
	};

						q4fPlayerStart( void );
						~q4fPlayerStart( void );

	void				Spawn( void );

	virtual bool		ClientReceiveEvent( int event, int time, const idBitMsg &msg );

	const char*			GetSpawnType( void ) { return spawnType.c_str(); };

protected:
	virtual void		OnStateChange( tfstate_t oldState, tfstate_t newState, idEntity* activator );

private:
	void				Event_TeleportPlayer( idEntity *activator );
	void				Teleport( idEntity* other );
	void				TeleportPlayer( idPlayer *player );

	idStr				spawnType;
};

#endif