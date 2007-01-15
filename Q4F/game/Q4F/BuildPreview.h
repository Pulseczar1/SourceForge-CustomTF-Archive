#ifndef __GAME_BUILDPREVIEW_H__
#define __GAME_BUILDPREVIEW_H__


/*
===============================================================================

	Entity Placement

===============================================================================
*/

#define MAX_VALID_POS 3
#define MAX_FLOOR_POS 6

class idStaticEntity;

class BuildPreview {
public:
						BuildPreview( void );
						~BuildPreview( void );

	void				Init( void );

	void				Start( idPlayer* owner, const idDeclEntityDef* entDef );
	void				CalcPosition( void );
	void				Draw( void );
	void				Stop( void );

	bool				AllowBuild( void ) { return allowBuild; };

	const idVec3 &		GetPosition( void ) { return modelCenter; };
	float				GetRotation( void ) { return currentRotation; };

	bool				IsValidPos( idVec3 &pos, idMat3 &axis );

	void				Rotate( float degrees );
	

	const idDeclEntityDef* GetEntDef( void ) { return previewDef; };


private:
	bool				FitsVolume( idVec3 &pos, idMat3 &axis );
	bool				GetFloorPos( idVec3 &pos, idMat3 &axis, idVec3 &lowestPos );

	float				GetRadius( idBounds &bounds );

	void				InitModel( void );
	void				RenderModel( void );
	void				RemoveModel( void );

	idEntityPtr<idPlayer>	owner;

	bool					allowBuild;

	idVec3					modelCenterOffset;
	idVec3					modelCenter;
	float					modelRotation;

	float					currentRotation;
	idVec3					lastValidPos;
	idMat3					lastValidAxis;

	int						modelHandle;
	renderEntity_t			renderModel;

	bool					previewing;

	const					idDeclEntityDef* previewDef; 

	idVec3					validPositions[MAX_VALID_POS];
	idVec3					floorPositions[MAX_FLOOR_POS];

	// semi constants
	float				distStartBuild;				// how far to start building
	float				distSetupBuild;				// how far away (x,y) to place the entity ( also min distance )
	idVec3				up;

	float				heightAdjust;

	idClipModel*		clipModel;
};

ID_INLINE float BuildPreview::GetRadius( idBounds &bounds ) {
	float x1,x2,y1,y2;

	x1 = idMath::Fabs( bounds.b[0].x );
	x2 = idMath::Fabs( bounds.b[1].x );
	y1 = idMath::Fabs( bounds.b[0].y );
	y2 = idMath::Fabs( bounds.b[1].y );
	
	float diag = x1 > x2 ? x1*x1 : x2*x2;
	diag += y1 > y2 ? y1*y1 : y2*y2;

	return idMath::Sqrt( diag );
}

#endif