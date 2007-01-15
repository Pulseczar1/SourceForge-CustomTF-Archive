
#ifndef __GAME_TARGET_H__
#define __GAME_TARGET_H__

//Used to compare two ammoData structs and see who has more.
int					CompareAmmoData( const void* ammo1, const void* ammo2);


/*
===============================================================================

idTarget

===============================================================================
*/

class idTarget : public idEntity {
public:
	CLASS_PROTOTYPE( idTarget );
};
 
#endif /* !__GAME_TARGET_H__ */
