#include "../idlib/precompiled.h"
#pragma hdrstop

#include "Game_local.h"

#define RECORD_STATE_TRACE_LEN		2048.0f

class rvGamePlayback
{
public:
							rvGamePlayback( void );
							~rvGamePlayback( void );

			void			RecordData( const usercmd_t &cmd, idEntity *source );
private:
			int				mStartTime;
			byte			mOldFlags;
			idStr			mName;
			idClipModel		*mClipModel;
			rvDeclPlayback	*mPlayback;
};

idCVar g_recordPlayback( "g_recordPlayback", "0", CVAR_GAME | CVAR_INTEGER | CVAR_NOCHEAT, "record the player movement in a playback" );
idCVar g_playPlayback( "g_playPlayback", "0", CVAR_GAME | CVAR_INTEGER | CVAR_NOCHEAT, "plays the current playback in a camera path" );

rvGamePlayback		*gamePlayback = NULL;
rvCameraPlayback	*playbackCamera = NULL;

rvGamePlayback::rvGamePlayback( void )
{
	idStr			newName;
	const idVec3 trace_mins( -1.0f, -1.0f, -1.0f );
	const idVec3 trace_maxs( 1.0f, 1.0f, 1.0f );
	const idBounds trace_bounds( trace_mins, trace_maxs );
	idTraceModel	traceModel( trace_bounds );
		
	mStartTime = gameLocal.time;
	mOldFlags = 0;
	mClipModel = new idClipModel( traceModel );

	if( !g_currentPlayback.GetInteger() )
	{
		newName = declManager->GetNewName( DECL_PLAYBACK, "playbacks/untitled" );
		mPlayback = ( rvDeclPlayback * )declManager->CreateNewDecl( DECL_PLAYBACK, newName, newName + ".playback" );
		mPlayback->ReplaceSourceFileText();
		mPlayback->Invalidate();

		g_currentPlayback.SetInteger( mPlayback->Index() );
	}
	else
	{
		mPlayback = ( rvDeclPlayback * )declManager->PlaybackByIndex( g_currentPlayback.GetInteger() );
	}

	declManager->StartPlaybackRecord( mPlayback );
	common->Printf( "Starting playback record to %s type %d\n", mPlayback->GetName(), g_recordPlayback.GetInteger() );
}

rvGamePlayback::~rvGamePlayback( void )
{
	declManager->FinishPlayback( mPlayback );
	delete mClipModel;

	common->Printf( "Stopping playback play/record\n" );
}

void rvGamePlayback::RecordData( const usercmd_t &cmd, idEntity *source )
{
	idPlayer			*player;
	trace_t				trace;
	idMat3				axis;
	idVec3				start, end;
	rvDeclPlaybackData	info;

	info.Init();

	switch( g_recordPlayback.GetInteger() )
	{
	case 1:
		info.SetPosition( source->GetPhysics()->GetOrigin() );
		info.SetAngles( source->GetPhysics()->GetAxis().ToAngles() );
		break;

	case 2:
		gameLocal.GetPlayerView( start, axis );
		
		end = start + axis[0] * RECORD_STATE_TRACE_LEN;

		gameLocal.clip.Translation( trace, start, end, mClipModel, mat3_identity, CONTENTS_SOLID | CONTENTS_RENDERMODEL, source );

		if( trace.fraction != 1.0f ) 
		{
			info.SetPosition( trace.endpos );
			info.SetAngles( trace.c.normal.ToAngles() );
		}
		break;

	case 3:
		assert( source->IsType( idPlayer::GetClassType() ) );
		if( source->IsType( idPlayer::GetClassType() ) )
		{
			player = static_cast<idPlayer *>( source );
			info.SetPosition( player->GetEyePosition() ); 
			info.SetAngles( source->GetPhysics()->GetAxis().ToAngles() );
		}
		break;
	}

	// Record buttons
	info.SetButtons( cmd.buttons );

	// Record impulses
	if( ( cmd.flags & UCF_IMPULSE_SEQUENCE ) != ( mOldFlags & UCF_IMPULSE_SEQUENCE ) )
	{
		info.SetImpulse( cmd.impulse );
	}
	else
	{
		info.SetImpulse( 0 );
	}
	mOldFlags = cmd.flags;

	declManager->SetPlaybackData( mPlayback, gameLocal.time - mStartTime, -1, &info );
}

// ================================================================================================

void idGameEdit::DrawPlaybackDebugInfo( void )
{
	int						duration, time;
	rvDeclPlaybackData		pbd, pbdOld;
	const rvDeclPlayback	*pb;

	pb = declManager->PlaybackByIndex( g_currentPlayback.GetInteger(), true );
	if( pb )
	{
		duration = SEC2MS( pb->GetDuration() );
		pbd.Init();
		pbdOld.Init();

		declManager->GetPlaybackData( pb, -1, 0, 0, &pbdOld );
		for( time = gameLocal.GetMSec(); time < duration; time += gameLocal.GetMSec() * g_showPlayback.GetInteger() )
		{
			declManager->GetPlaybackData( pb, -1, time, time, &pbd );
			gameRenderWorld->DebugArrow( colorGreen, pbdOld.GetPosition(), pbd.GetPosition(), 2 );
			pbdOld = pbd;
		}

		gameRenderWorld->DebugBounds( colorRed, pb->GetBounds(), pb->GetOrigin() );
	}
}

void idGameEdit::RecordPlayback( const usercmd_t &cmd, idEntity *source )
{
	// Not recording - so instantly exit
	if( !g_recordPlayback.GetInteger() && !gamePlayback ) 
	{
		return;
	}

	if( !gamePlayback )
	{
		gamePlayback = new rvGamePlayback();
	}

	if( g_recordPlayback.GetInteger() )
	{
		gamePlayback->RecordData( cmd, source );
	}
	else
	{
		delete gamePlayback;
		gamePlayback = NULL;
	}
}

// ================================================================================================

bool idGameEdit::PlayPlayback( void )
{
	// Not playing - so instantly exit
	if( !g_playPlayback.GetInteger() && !playbackCamera ) 
	{
		return( false );
	}

	if( !playbackCamera )
	{
		playbackCamera = static_cast<rvCameraPlayback *>( gameLocal.SpawnEntityType( rvCameraPlayback::GetClassType() ) );
		SetCamera( playbackCamera );

		common->Printf( "Starting playback play\n" );
	}

	if( g_currentPlayback.IsModified() )
	{
		// Spawn is a misnomer - it should be init with new data
		playbackCamera->Spawn();
		g_currentPlayback.ClearModified();
	}

	if( !g_playPlayback.GetInteger() )
	{
		playbackCamera->PostEventMS( &EV_Remove, 0 );
		playbackCamera = NULL;
		SetCamera( NULL );
	}

	return( true );
}

// ================================================================================================

void idGameEdit::ShutdownPlaybacks( void )
{
	g_recordPlayback.SetInteger( 0 );
	g_playPlayback.SetInteger( 0 );

	if( gamePlayback )
	{
		delete gamePlayback;
		gamePlayback = NULL;
	}

	if( playbackCamera )
	{
		playbackCamera->PostEventMS( &EV_Remove, 0 );
		playbackCamera = NULL;
		SetCamera( NULL );
	}
}

// ================================================================================================


