
// bdube: note that this file is no longer merged with Doom3 updates
//
// MERGE_DATE 07/07/2004

#ifndef __GAME_PLAYERVIEW_H__
#define __GAME_PLAYERVIEW_H__

/*
===============================================================================

  Player view.

===============================================================================
*/

// screenBlob_t are for the on-screen damage claw marks, etc
typedef struct {
	const idMaterial *	material;
	float				x, y, w, h;
	float				s1, t1, s2, t2;
	int					finishTime;
	int					startFadeTime;
	float				driftAmount;
} screenBlob_t;

#define	MAX_SCREEN_BLOBS	8

class idPlayerView {
public:
						idPlayerView();

	void				Save( idSaveGame *savefile ) const;
	void				Restore( idRestoreGame *savefile );

	void				SetPlayerEntity( class idPlayer *playerEnt );

	void				ClearEffects( void );


// jnewquist: Controller rumble
	void				DamageImpulse( idVec3 localKickDir, const idDict *damageDef, int damage );


	void				WeaponFireFeedback( const idDict *weaponDef );
	void				WeaponFireFeedback( int recoilTime, idAngles &recoilAngles );

	idAngles			AngleOffset( void ) const;			// returns the current kick angle


// jnewquist: Controller rumble
	float				CalculateShake( idAngles &shakeAngleOffset ) const;


// jscott: for screen shake
	void				ShakeOffsets( idVec3 &shakeOffset, idAngles &shakeAngleOffset, const idBounds bounds ) const;


	// adds little entities to the renderer for local blood blobs, etc

	// this may involve rendering to a texture and displaying
	// that with a warp model or in double vision mode
	void				RenderPlayerView( idUserInterface *hud );

	void				Fade( idVec4 color, int time );

	void				Flash( idVec4 color, int time );

	void				AddBloodSpray( float duration );

	// temp for view testing
	void				EnableBFGVision( bool b ) { bfgVision = b; };


// jscott: accessors required for the fx system
	void				SetDoubleVisionParms( float time, float scale );
	void				SetShakeParms( float time, float scale ) { shakeFinishTime = SEC2MS( time ); shakeScale = scale; }
	void				SetTunnelParms( float time, float scale ) { tvStartTime = gameLocal.time; tvFinishTime = tvStartTime + time; tvScale = 1.0f / scale; }

private:

// AReis: Modified SingleView() signature to include renderFlags variable.
	void				SingleView( idUserInterface *hud, const renderView_t *view, int renderFlags = RF_NORMAL );

	void				DoubleVision( idUserInterface *hud, const renderView_t *view, float amount );
	void				ScreenFade();

	screenBlob_t *		GetScreenBlob();

	screenBlob_t		screenBlobs[MAX_SCREEN_BLOBS];

	int					dvFinishTime;		// double vision will be stopped at this time
	const idMaterial *	dvMaterial;			// material to take the double vision screen shot

// jscott: to make double vision work with alpha components
	const idMaterial *	dvMaterialBlend;
// jscott: for effects
	float				dvScale;


	int					kickFinishTime;		// view kick will be stopped at this time
	idAngles			kickAngles;			

	bool				bfgVision;			// 

	const idMaterial *	tunnelMaterial;		// health tunnel vision
	const idMaterial *	armorMaterial;		// armor damage view effect

// bdube: not using these
//	const idMaterial *	berserkMaterial;	// berserk effect
//	const idMaterial *	irGogglesMaterial;	// ir effect
	const idMaterial *	bloodSprayMaterial; // blood spray
//	const idMaterial *	bfgMaterial;		// when targeted with BFG

	const idMaterial *	lagoMaterial;		// lagometer drawing

	float				lastDamageTime;		// accentuate the tunnel effect for a while


// jscott: for effects
	float				shakeFinishTime;
	float				shakeScale;
	float				tvScale;
	int					tvFinishTime;
	int					tvStartTime;


	idVec4				fadeColor;			// fade color
	idVec4				fadeToColor;		// color to fade to
	idVec4				fadeFromColor;		// color to fade from
	float				fadeRate;			// fade rate
	int					fadeTime;			// fade time

	idPlayer *			player;
	renderView_t		view;

	// <q4f> 

public:
	void				Retinalburn( idUserInterface *hud );
	void				RemoveRetinalburn( void ) { retinalBurn = NULL; };

	void				UpdateFlash( idVec4 &newSplashColor );
	void				ClearFlash( void ) { splashColor.Zero(); };

	void				SetHallucinateScale( float scale ) { halluScale = scale; };
	void				ClearHallucinate( void ) { halluScale = 0.0f; };

	
private:
	void				DrawFlash( idUserInterface *hud, const renderView_t *view );
	void				Hallucinate( idUserInterface *hud, const renderView_t *view, float amount );

	const idMaterial*	retinalBurn;

	idVec4				splashColor;
	float				retinaAlpha;
	bool				drawFlash;

	float				dvAmount;
	float				halluScale;

	// </q4f>
};

ID_INLINE void idPlayerView::UpdateFlash( idVec4 &addSplashColor ) {
	splashColor += addSplashColor;

	if ( splashColor[0] > 1.0f ) splashColor[0] = 1.0f;
	if ( splashColor[1] > 1.0f ) splashColor[1] = 1.0f;
	if ( splashColor[2] > 1.0f ) splashColor[2] = 1.0f;
	if ( splashColor[3] > 1.0f ) splashColor[3] = 1.0f;

	drawFlash = true;
}

ID_INLINE void idPlayerView::SetDoubleVisionParms( float time, float scale ) {
		 dvFinishTime = SEC2MS( time );
		 dvScale = scale;
}

#endif /* !__GAME_PLAYERVIEW_H__ */


