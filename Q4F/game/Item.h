
// bdube: note that this file is no longer merged with Doom3 updates
//
// MERGE_DATE 09/30/2004

#ifndef __GAME_ITEM_H__
#define __GAME_ITEM_H__

//extern const int ARENA_POWERUP_MASK;
//extern const idEventDef EV_ResetFlag;

/*
===============================================================================

  idMoveableItem

===============================================================================
*/

/*class idMoveableItem : public idItem {
public:
	CLASS_PROTOTYPE( idMoveableItem );

							idMoveableItem();
	virtual					~idMoveableItem();

	void					Save( idSaveGame *savefile ) const;
	void					Restore( idRestoreGame *savefile );

	void					Spawn( void );
	virtual void			Think( void );

 	static void				DropItems( idAnimatedEntity *ent, const char *type, idList<idEntity *> *list );
	static idEntity*		DropItem( const char *classname, const idVec3 &origin, const idMat3 &axis, const idVec3 &velocity, int activateDelay, int removeDelay, idDict* extraArgs = NULL );

	virtual void			WriteToSnapshot( idBitMsgDelta &msg ) const;
	virtual void			ReadFromSnapshot( const idBitMsgDelta &msg );

private:
	idPhysics_RigidBody		physicsObj;

 	void					Gib( const idVec3 &dir, const char *damageDefName );
 	void					Event_Gib( const char *damageDefName );
};*/

/*
===============================================================================

  Item removers.

===============================================================================
*/

/*class idItemRemover : public idEntity {
public:
	CLASS_PROTOTYPE( idItemRemover );

	void					Spawn();
	void					RemoveItem( idPlayer *player );

private:
	void					Event_Trigger( idEntity *activator );
};*/

#endif /* !__GAME_ITEM_H__ */



