
#ifndef __GAME_TFTRIGGER_H__
#define __GAME_TFTRIGGER_H__

/*
===============================================================================

  Trigger which can be activated multiple times.

===============================================================================
*/

class TFTrigger : public TFEntity {
public:
	CLASS_PROTOTYPE( TFTrigger );

						TFTrigger( void );

	void				Spawn( void );

protected:

	bool				AllowActivate( idEntity* ent );


private:

	int					nextTriggerTime;

	void				Event_Activate(  idEntity* activator );
	void				Event_Touch( idEntity *other, trace_t *trace );
};

#endif /* !__GAME_TFTRIGGER_H__ */
