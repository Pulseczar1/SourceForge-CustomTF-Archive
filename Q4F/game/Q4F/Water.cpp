#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"

CLASS_DECLARATION( idEntity, q4fWater )
END_CLASS


q4fWater::q4fWater() {
	fl.networkSync = false;
}



//--------------------------------------------------------------------------
// Pass our spawn parameters to shader
//--------------------------------------------------------------------------
void q4fWater::Spawn() {
	GetPhysics()->SetContents( CONTENTS_WATER );
	fl.networkSync = false;
	gameLocal.waterEnts.AddUnique( this );
}

//--------------------------------------------------------------------------
// Calculate movement on server
//--------------------------------------------------------------------------
void q4fWater::Think() {
	idEntity::Think();
}


//--------------------------------------------------------------------------
// Just calculate reflection on client
//--------------------------------------------------------------------------
void q4fWater::ClientPredictionThink( void ) {
	idEntity::Think();
}