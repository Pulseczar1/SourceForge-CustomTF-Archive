/*
===================================================================================

Someplace to keep our custom system commands so it's easier to keep track
for editing and documentation

===================================================================================
*/

#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"

void LocationsAdd_f( const idCmdArgs &args ) {

	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( !local )
		return;

	if ( args.Argc() == 3 ) {
		int teamNum = tfGame.GetTeamNumFromString( args.Argv( 1 ) );
		q4fLocation* loc = gameLocal.AddLocation( local->GetEyePosition(), args.Argv( 2 ), teamNum );

		if ( loc )
			gameLocal.Printf( "Location added: %s\n", loc->GetString() );
		else
			gameLocal.Printf( "Problem adding location.\n" );

		return;
	}

	gameLocal.Printf( "Usage: %s \"team # or name\" \"name of location\" \n", args.Argv( 0 ) );

}

void LocationsList_f( const idCmdArgs &args ) {
	gameLocal.PrintLocations();
}

void LocationsRemove_f( const idCmdArgs &args ) {
	if ( args.Argc() == 2 && idStr::IsNumeric( args.Argv( 1 ) ) ) {
		
		if ( gameLocal.RemoveLocation( atoi( args.Argv( 1 ) ) ) )
			gameLocal.Printf( "Location removed.\n" );
		else
			gameLocal.Printf( "Problem removing location.\n" );

		return;
	}
	
	gameLocal.Printf( "Usage: %s [location index]\nUse 'locationsList' to view the list of indices.", args.Argv( 0 ) );
}


void ComMenu_F( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( !local )
		return;

	if ( args.Argc() > 1 ) {

		const char* category = args.Argv( 1 );
		MessageList* list = gameLocal.msgListCollection.GetList( category );
		if ( !list && idStr::IsNumeric( category ) ) {
			int catNum = atoi( category );
			list = gameLocal.msgListCollection.GetList( catNum );
		}

		if ( !list ) {
			gameLocal.Printf( "Unknown communications category name or index '%s'\n", category );
		}
		else {
			if ( args.Argc() > 2 ) {
				const char* type = args.Argv( 2 );

				MessageItem* item = list->GetItem( type );
				if ( !item && idStr::IsNumeric( type ) ) {
					int itemNum = atoi( type );
					item = list->GetItem( itemNum );
				}

				if ( !item ) {
					gameLocal.Printf( "Unknown communications item name or index '%s' for category '%s'\n", type, category );
				}
				else {
					item->Execute();
					return;
				}
			}
			else {
				local->commMenuIndex = list->Index;
				local->OpenMenu( 5 );
				return;
			}
		}
	}

	local->commMenuIndex = -1;
	local->OpenMenu( 5 );

	gameLocal.Printf( "Usage: comMenu <category> <item>\ncategory and item are optional\n" );

}

void RotateSentry_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( !local || local->spectating || !local->sentryGun.GetEntity() )
		return;

	if ( args.Argc() < 2 ) {
		gameLocal.Warning( "Usage: rotateSentry <degrees>. Degrees is positive for clockwise, negative for counter-clockwise" );
		return;
	}

	int degrees = - idMath::ClampInt( -360, 360, atoi( args.Argv( 1 ) ) );

	if ( gameLocal.isClient ) {
		byte msgBuf[ MAX_GAME_MESSAGE_SIZE ];
		idBitMsg out;
		out.Init( msgBuf, sizeof( msgBuf ) );
		out.WriteByte( GAME_RELIABLE_MESSAGE_ROTATESENTRY );
		out.WriteBits( degrees, -10 );
		networkSystem->ClientSendReliableMessage( out );
	}
	else {
		local->sentryGun->Rotate( degrees );
	}

}

void PrintEndGameAwards_f( const idCmdArgs &args ) {
	if ( gameLocal.isClient ) {
		gameLocal.Printf( "This command is not valid for clients.\n" );
		return;
	}

	gameLocal.Printf( "Pringting end game awards, based on current stats...\n\n" );

	gameLocal.Printf( gameLocal.mpGame.GetStatAwards() );

	gameLocal.Printf( "\n... done printing awards.\n\n" );
}

void PrintXML( const idCmdArgs &args ) {
	tfStatManager->WriteStatsXML();
}

void Reload_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		local->PerformImpulse( IMPULSE_13 );
	}
}

void LastWeapon_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		local->PerformImpulse( IMPULSE_51 );
	}
}

void Discard_f( const idCmdArgs &args ) {

	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		local->PerformImpulse( IMPULSE_DISCARD );
	}
}

void Cmd_cvarlist_f( const idCmdArgs& args ) {

	const char* contains = NULL;
	if ( args.Argc() > 1 ) {
		contains = args.Argv( 1 );
	}

	const idDict* cvars = cvarSystem->MoveCVarsToDict( CVAR_GAME );

	idStrList cvarList;
	idStrList cvarListLeftOvers;

	int index;
	int count = 0;
	const idKeyValue* kv = cvars->GetKeyVal( count );

	if ( contains && contains[0] ) {
		while ( kv ) {
			index = idStr::FindText( kv->GetKey(), contains, false );
			if ( index == 0 ) {
				cvarList.Append( kv->GetKey() );
			}
			else if ( index > 0 ) {
				cvarListLeftOvers.Append( kv->GetKey() );
			}
			
			count++;
			kv = cvars->GetKeyVal( count );
		}
	}
	else {
		while ( kv ) {
			cvarList.Append( kv->GetKey() );
			count++;
			kv = cvars->GetKeyVal( count );
		}
	}

	cvarList.Sort();
	cvarListLeftOvers.Sort();

	for ( int i = 0; i < cvarListLeftOvers.Num(); i++ ) {
		gameLocal.Printf( "%s\n", cvarListLeftOvers[i].c_str() );
	}
	gameLocal.Printf( "\n" );
	for ( int i = 0; i < cvarList.Num(); i++ ) {
		gameLocal.Printf( "%s\n", cvarList[i].c_str() );
	}
}

//--------------------------------------------------------------------------
// Disguise
//--------------------------------------------------------------------------
void DisguiseRequest_f( const idCmdArgs &args ) {

	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( !local || local->currentPC != CLASS_SPY || local->spectating ) {
		gameLocal.Printf( "Only spies can disguise.\n" );
		return;
	}

	if ( local->health <= 0 )
		return;

	bool openMenu = true;

	if ( args.Argc() >= 2 ) {

		idStr cmd = args.Argv( 1 );

		if ( !cmd.Icmp( "team" ) ) {

			if ( args.Argc() < 3 ) {
				local->OpenMenu( 2 );
				openMenu = false;
			}
			else {
				int team =  tfGame.GetTeamNumFromString( args.Argv( 2 ) );
				if ( team == INVALID_TEAM ) {
					gameLocal.Printf( "Unknown team %s\n", args.Argv( 2 ) );
					return;
				}
				tfGame.DisguiseRequest( gameLocal.localClientNum, DISGUISE_TEAM, team );
				return;
			}
		}
		else if ( !cmd.Icmp( "class" ) ) {
			if ( args.Argc() < 3 ) {
				local->OpenMenu( 3 );
				openMenu = false;
			}
			else {
				int classNum =  tfGame.GetClassNumFromString( args.Argv( 2 ) );
				if ( classNum == INVALID_CLASS ) {
					gameLocal.Printf( "Unknown class %s\n", args.Argv( 2 ) );
					return;
				}
				tfGame.DisguiseRequest( gameLocal.localClientNum, DISGUISE_CLASS, classNum );
				return;
			}
		}
	}

	gameLocal.Printf( "Usage:\n%s team <team #/name>\n%s class <class #/name>\n", args.Argv( 0 ), args.Argv( 0 ) );

	if ( openMenu ) {
		if ( local->disguiseTeam != INVALID_TEAM && local->disguiseTeam != local->team ) {
			local->OpenMenu( 3 );
		}
		else {
			local->OpenMenu( 2 );
		}
	}

	return;
}


//--------------------------------------------------------------------------
// Build
//--------------------------------------------------------------------------
void BuildRequest_f( const idCmdArgs &args ) {

	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( !local || local->currentPC != CLASS_ENGINEER || local->spectating ) {
		gameLocal.Printf( "Only engineers can build sentry guns and dispensers.\n" );
		return;
	}

	if ( local->health <= 0 )
		return;

	if ( args.Argc() < 2 && local->isPreviewing ) {
		tfGame.BuildRequest( local->buildPreview.GetEntDef()->GetName(), gameLocal.localClientNum );
		return;
	}

	if ( args.Argc() > 1 ) {
		idStr cmd = args.Argv( 1 );
		if ( !cmd.IcmpPrefix( "sent" ) ) {
			tfGame.BuildRequest( "q4f_sentry", gameLocal.localClientNum );
			return;
		}
		else if ( !cmd.IcmpPrefix( "disp" ) ) {
			tfGame.BuildRequest( "q4f_dispenser", gameLocal.localClientNum );
			return;
		}
	}

	gameLocal.Printf( "Usage:\n%s sentrygun\n%s dispenser\n", args.Argv( 0 ), args.Argv( 0 ) );
	local->OpenMenu( 1 );
	return;
}

void Cmd_Destroy_F( const idCmdArgs &args )  {

	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( !local || local->spectating ) return;

	if ( args.Argc() > 1 ) {
		idStr cmd = args.Argv( 1 );
		if ( !cmd.IcmpPrefix( "sent" ) ) {
			local->PerformImpulse( IMPULSE_DESTROY_SENT );
			return;
		}
		else if ( !cmd.IcmpPrefix( "disp" ) ) {
			local->PerformImpulse( IMPULSE_DESTROY_DISP );
			return;
		}
	}

	gameLocal.Printf( "Usage:\n%s sentrygun\n%s dispenser\n", args.Argv( 0 ), args.Argv( 0 ) );
	return;
}

//--------------------------------------------------------------------------
// DetPak
//--------------------------------------------------------------------------
void DetPakRequest_f( const idCmdArgs &args ) {

	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( !local || local->currentPC != CLASS_DEMOMAN || local->spectating ) {
		gameLocal.Printf( "Only demomen can lay detpacks.\n" );
		return;
	}

	if ( local->health <= 0 )
		return;

	if ( args.Argc() > 1 ) {
		idStr cmd = args.Argv( 1 );

		if ( cmd.IsNumeric() ) {
			float time = idMath::ClampFloat( 5.0f, 300.0f, atof( cmd.c_str() ) );

			if ( gameLocal.isClient ) {
				idBitMsg	outMsg;
				byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];
				outMsg.Init( msgBuf, sizeof( msgBuf ) );
				outMsg.WriteByte( GAME_RELIABLE_MESSAGE_DETPACK );
				outMsg.WriteFloat( time );
				networkSystem->ClientSendReliableMessage( outMsg );
				return;
			}
			else {
				idDict dict;
				dict.Set( "chargetime", va( "%g", time ) );
				tfGame.BuildRequest( "q4f_detpak", gameLocal.localClientNum, &dict );
				return;
			}
			
			
		}
	}

	gameLocal.Printf( "Usage: detpack <seconds>\n" );
	local->OpenMenu( 4 );
}

//--------------------------------------------------------------------------
// helper function for ui_name
//--------------------------------------------------------------------------
void Name_f( const idCmdArgs &args ) {
	if ( gameLocal.localClientNum < 0 ) {
		gameLocal.Printf( "You are a server." );
		return;
	}

	if ( args.Argc() < 2 ) {
		gameLocal.Printf( va( "Your name is: %s\n", cvarSystem->GetCVarString( "ui_name" ) ) );
		return;
	}

	idStr newName;
	for ( int i = 1; i < args.Argc(); i++ ) {
		newName += args.Argv(i);
	}

	cvarSystem->SetCVarString( "ui_name", newName );
}

//--------------------------------------------------------------------------
// Drop an ammo pack
//--------------------------------------------------------------------------
void DropAmmo_f( const idCmdArgs &args ) {

	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( !local || local->spectating )
		return;

	// dropammo name amount amount
	if ( args.Argc() < 2 ) {
		gameLocal.Printf( "Usage: dropammo <ammo name> [amount to drop] [amount to retain].\n" );
		return;
	}

	int dropCount = -1;
	int save = 0;

	if ( args.Argc() > 2 ) {
		dropCount = atoi( args.Argv( 2 ) );
	}
	if ( args.Argc() > 3 ) {
		save = atoi( args.Argv( 3 ) );
	}
	
	local->DropAmmo( va( "ammo_%s", args.Argv( 1 ) ), dropCount, save );
}

void ArgCompletion_DropAmmo( const idCmdArgs &args, void(*callback)( const char *s ) )
{
	callback( va( "%s shells  [amount to drop] [amount to remain]", args.Argv( 0 ) ) );
	callback( va( "%s nails   [amount to drop] [amount to remain]", args.Argv( 0 ) ) );
	callback( va( "%s rockets [amount to drop] [amount to remain]", args.Argv( 0 ) ) );
	callback( va( "%s cells   [amount to drop] [amount to remain]", args.Argv( 0 ) ) );
}

//--------------------------------------------------------------------------
// Detonate the local player's pipebombs
//--------------------------------------------------------------------------
void DetPipe_f( const idCmdArgs &args ) {
	idPlayer* player = gameLocal.GetLocalPlayer();

	if ( player && player->currentPC == CLASS_DEMOMAN && !player->spectating ) {
		player->PerformImpulse( IMPULSE_DETPIPE );
	}
}

//--------------------------------------------------------------------------
// tells the local player to throw a grenade
//--------------------------------------------------------------------------
void ThrowGrenade_f( const idCmdArgs &args ) {

	// dont check if we're holding a grenade on throw, we ALWAYS want throw

	idPlayer* player = gameLocal.GetLocalPlayer();
	if ( !player || player->health <= 0 || player->spectating )
		return;

	// send request to server
	if ( gameLocal.isClient ) {
		idBitMsg	outMsg;
		byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_GRENADE );
		outMsg.WriteBits( 0, 1 );			// don't care about what grenade, whichever we're holding
		outMsg.WriteBits( 1, 1 );			// throwing grenade
		networkSystem->ClientSendReliableMessage( outMsg );
	}
	else {
		player->heldGrenade.playerWantsThrow = true;
	}
}

//--------------------------------------------------------------------------
// tells the local player to prime a grenade
//--------------------------------------------------------------------------
void PrimeGrenade_f( const idCmdArgs &args ) {
	idPlayer* player = gameLocal.GetLocalPlayer();

	if ( !player || player->health <= 0 || player->spectating )
		return;

	if ( gameLocal.isClient && player->heldGrenade.grenadeNum == 3 ) {
		return;
	}

	if ( player->heldGrenade.grenadeNum != 0 ) {
		if ( q4f_primethrow.GetBool() ) {
			ThrowGrenade_f( args );
		}
		else {
			gameLocal.mpGame.PrintMessageEvent( gameLocal.localClientNum, MSG_ALREADYPRIMING );
		}
		return;
	}

	bool gren1 = !idStr::Icmp( args.Argv( 0 ), "primeone" );

	if ( gameLocal.isClient ) {
		idBitMsg	outMsg;
		byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_GRENADE );
		outMsg.WriteBits( gren1 ? 0 : 1, 1 );			// first bit = 0 = first grenade, else 2nd grenade. 2nd bit is 1 for throw
		outMsg.WriteBits( 0, 1 );						// not trying to throw

		// predict the prime
		//player->heldGrenade.grenadeNum = 3;			// client just knows request is pending

		networkSystem->ClientSendReliableMessage( outMsg );
		return;
	}
	else {
		player->PrimeGrenade( gren1 ? 1 : 2 );
	}
}

//--------------------------------------------------------------------------
// Removed commands for a button press/release
//--------------------------------------------------------------------------
void Alias::Unbindalias_f( const idCmdArgs &args ) {
	if ( args.Argc() != 2 ) {
		gameLocal.Printf( "Usage: unbindalias <key> or unbindalias all\n" );
	}

	gameLocal.alias.RemoveAlias( args.Argv( 2 ) );
}
//--------------------------------------------------------------------------
// Creates commands for a button press/release
//--------------------------------------------------------------------------
void Alias::Setalias_f( const idCmdArgs &args ) {
	// should be set up like 'bindalias key press,release'
	if ( args.Argc() < 3 ) {
		idStr press, release;
		if ( args.Argc() == 2 && gameLocal.alias.GetKeyAlias( args.Argv( 1 ), press, release ) ) {
			gameLocal.Printf( "'%s' is bound to %s , %s\n", args.Argv( 1 ), press.c_str(), release.c_str() );
		}
		gameLocal.Printf( "Usage: bindalias <key> <press commands>,<release commands>\n" );
		return;
	}

	idStr wholeCMD;
	for ( int i = 2; i < args.Argc(); i++ ) {
		wholeCMD += args.Argv( i );
		wholeCMD += " ";
	}

	idList<idStr> cmds;
	wholeCMD.Split( cmds, ',', 0 );

	if ( cmds.Num() != 2 ) {
		gameLocal.Printf( "One comma is required.\n" );
		gameLocal.Printf( "Usage: bindalias <key> <press commands>,<release commands>\n");
		return;
	}

	gameLocal.alias.CreateAlias( args.Argv(1), cmds[0], cmds[1] );
}


//--------------------------------------------------------------------------
// Allows users to make custom overwritable client-side cvars
//--------------------------------------------------------------------------
/*void Alias::Setcvar_f( const idCmdArgs &args ) {
	// setcustom name commands

	if ( args.Argc() < 3 ) {
		gameLocal.Printf( "Usage: setcustom <cvar name> <commands>\n" );
		return;
	}

	// get the commands
	idStr commands;
	for ( int i = 2; i < args.Argc(); i++ ) {
		commands += args.Argv(i);
		commands += " ";
	}

	// check if it already exists
	idCVar* found = cvarSystem->Find( args.Argv( 1 ) );

	if ( found ) {
		// make sure it's a custom command
		if ( !( found->GetFlags() & CVAR_CUSTOM ) ) {
			gameLocal.Printf( "The cvar '%s' already exists.\nTo update a game cvar, use 'set' instead of 'setcustom'\n", args.Argv( 1 ) );
			return;
		}
		else {
			// tis a custom command, update it
			found->SetString( commands.c_str() );
			gameLocal.Printf( "Custom cvar updated.\n" );
			return;
		}
	}
	else {
		// doesn't exist, create it
		idCVar( args.Argv(1), commands.c_str(), CVAR_GAME | CVAR_NOCHEAT | CVAR_CUSTOM, "custom cvar" );
		gameLocal.Printf( "Custom cvar created. To execute it, use 'vstr %s'\n", args.Argv(1) );
	}
}*/

//================
// Argument completion for the setcvar system command
//================
void Alias::ArgCompletion_Setcvar( const idCmdArgs &args, void(*callback)( const char *s ) ) {
	callback( "<cvar name> <commands>" );
}

//==========================================================================
// Handles the 'changeclass' system command
//==========================================================================
void ChangeClassRequest_f( const idCmdArgs &args ) {
	
	idStr				className;
	int					classNum = CLASS_COUNT;

	idPlayer*			player = gameLocal.GetLocalPlayer();
	if ( !player ) {
		return;
	}

	if ( args.Argc() != 2 ) {

		if ( IS_VALID_CLASS_NUM( player->currentPC ) ) {
			gameLocal.Printf( "Your current class is '%s'. ", tfGame.GetClassName( player->currentPC ) );
		}
		gameLocal.Printf( "Type 'changeclass <classname>' to change class.\n" );		
		gameLocal.mpGame.ShowQ4FMenu( 2 );		
		return;
	}

	classNum = tfGame.GetClassNumFromString( args.Argv( 1 ) );

	if ( IS_VALID_CLASS_NUM( classNum ) ) {
		if ( gameLocal.isClient ) {
			// send request to server
			idBitMsg	outMsg;
			byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];
			outMsg.Init( msgBuf, sizeof( msgBuf ) );
			outMsg.WriteByte( GAME_RELIABLE_MESSAGE_CHANGECLASS );
			outMsg.WriteBits( classNum, ASYNC_CLASS_BITS );
			networkSystem->ClientSendReliableMessage( outMsg );
		}
		else {
			tfGame.ChangeClassRequest( gameLocal.localClientNum, classNum );
		}
	}
	else {
		gameLocal.Printf( "That class is not recognized.\n" );
		gameLocal.Printf( "Type 'changeclass <classname>' to change class.\n" );
	}
}

void ClassName_f( const idCmdArgs& args ) {
	idCmdArgs eh;
	eh.AppendArg( "changeclass" );
	eh.AppendArg( args.Argv( 0 ) );
	ChangeClassRequest_f( eh );
}

//================
// Argument completion for the changeclass system command
//================
void ArgCompletion_ChangeClass( const idCmdArgs &args, void(*callback)( const char *s ) )
{
	int i;

	for( i = 0; i < CLASS_COUNT; i++ ) {
		callback( va( "%s %d", args.Argv( 0 ), i ) );
	}
	for( i = 0; i < CLASS_COUNT; i++ ) {
		callback( va( "%s %s", args.Argv( 0 ), tfGame.GetClassName( i ) ) );
	}
}

//==========================================================================
// Handles the 'jointeam' system command
//==========================================================================
#define MAX_TEAMCHANGE_TIME 3000
void ChangeTeamRequest_f( const idCmdArgs &args ) {

  	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( !local ) {
		return;
	}

	if ( gameLocal.time < local->nextTeamChange ) {
		// 3j_todo: respond to GUI
		gameLocal.Printf( "Trying to change teams too quickly.\n" );
		return;
	}

	if ( args.Argc() != 2 ) {	
		gameLocal.mpGame.ShowQ4FMenu( 1 );
		return;
	}

	int newTeamNum;
	TFTeam* newTeam;
	idStr teamStr = args.Argv( 1 );

	if ( !idStr::Icmp( teamStr.c_str(), "auto" ) || !idStr::Icmp( teamStr.c_str(), "5" ) ) {
			newTeamNum = TEAM_AUTO;
	}
	else {
		if ( teamStr.IsNumeric() ) {
			newTeam = tfGame.GetTeam( atoi( teamStr ) - 1 );
		}
		else {
			newTeam = tfGame.GetTeam( teamStr );
		}

		if ( !newTeam ) {
			gameLocal.Printf( "This team is not enabled." );
			return;
		}

		newTeamNum = newTeam->GetTeamNum();
	}

	if ( newTeamNum == local->team && !local->spectating ) {
		gameLocal.Printf( "You are already on this team.\n" );
		return;
	}

	local->nextTeamChange = gameLocal.time + MAX_TEAMCHANGE_TIME;
	local->wantSpectate = false;
	
	if ( gameLocal.isClient ) {
		// send team change request to server
		idBitMsg	outMsg;
		byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_CHANGETEAM );

		outMsg.WriteBits( newTeamNum, ASYNC_TEAM_BITS );
		networkSystem->ClientSendReliableMessage( outMsg );
	}
	else {
		gameLocal.mpGame.JoinTeam( gameLocal.localClientNum, newTeamNum );
	}
}

//================
// Argument completion for the jointeam system command
//================
void ArgCompletion_ChangeTeam( const idCmdArgs &args, void(*callback)( const char *s ) ) {

	TFTeam* team = tfGame.GetTeam( 0 );

	callback( va( "%s %s", args.Argv( 0 ), "auto (autoteam)" ) );
	while ( team != NULL ) {
		callback( va( "%s %s", args.Argv( 0 ), team->GetName() ) );
		callback( va( "%s %d", args.Argv( 0 ), team->GetTeamNum() + 1 ) );

		team = tfGame.GetTeam( team->GetTeamNum() + 1 );
	}
}

//==========================================================================
// Handles the 'spectate' system command
//==========================================================================
void SpectateRequest_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( !local ) {
		return;
	}

	if ( gameLocal.time < local->nextTeamChange ) {
		// 3j_todo: respond to GUI
		gameLocal.Printf( "Trying to change teams too quickly.\n" );
		return;
	}

	if ( args.Argc() != 2 ) {	
		gameLocal.mpGame.ShowQ4FMenu( 1 );
		return;
	}

	int newTeamNum;
	TFTeam* newTeam;
	idStr teamStr = args.Argv( 1 );

	if ( !idStr::Icmp( args.Argv( 1 ), "all" ) ) {
		newTeamNum = TEAM_SPEC;
	}
	else {
		if ( teamStr.IsNumeric() ) {
			newTeam = tfGame.GetTeam( atoi( teamStr ) - 1 );
		}
		else {
			newTeam = tfGame.GetTeam( teamStr );
		}

		if ( !newTeam ) {
			gameLocal.Printf( "This team is not enabled." );
			return;
		}

		newTeamNum = newTeam->GetTeamNum();
	}

	if ( newTeamNum == local->team && local->spectating ) {
		gameLocal.Printf( "You are already spectating this team.\n" );
		return;
	}

	local->nextTeamChange = gameLocal.time + MAX_TEAMCHANGE_TIME;
	local->wantSpectate = true;
	
	if ( gameLocal.isClient ) {
		// send team change request to server
		idBitMsg	outMsg;
		byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_SPECTATE );

		outMsg.WriteBits( newTeamNum, ASYNC_TEAM_BITS );
		networkSystem->ClientSendReliableMessage( outMsg );
	}
	else {
		gameLocal.mpGame.JoinSpectators( gameLocal.localClientNum, newTeamNum );
	}
}

//================
// Argument completion for the jointeam system command
//================
void ArgCompletion_Spectate( const idCmdArgs &args, void(*callback)( const char *s ) ) {
	TFTeam* team = tfGame.GetTeam( 0 );

	callback( va( "%s %s", args.Argv( 0 ), "all (all teams)" ) );
	while ( team != NULL ) {
		callback( va( "%s %s", args.Argv( 0 ), team->GetName() ) );
		callback( va( "%s %d", args.Argv( 0 ), team->GetTeamNum() + 1 ) );
		team = tfGame.GetTeam( team->GetTeamNum() + 1 );
	}
}



//--------------------------------------------------------------------------
// DropFlag
//--------------------------------------------------------------------------
void DropFlag_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( !local || local->spectating )
		return;

	if ( gameLocal.isClient ) {
		// send request to server
		idBitMsg	outMsg;
		byte		msgBuf[ MAX_GAME_MESSAGE_SIZE ];
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_DROPFLAG );
		networkSystem->ClientSendReliableMessage( outMsg );
	}
	else {
		local->DropItems( false, TFSTATE_ACTIVE );
	}
}

void Special_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( !local || local->spectating )
		return;

	idCmdArgs bogus;
	bogus.AppendArg( "special" );

	switch ( local->currentPC ) {
		case CLASS_SCOUT:
			break;

		case CLASS_SNIPER:
			q4f_autozoom.SetBool( !q4f_autozoom.GetBool() );
			break;

		case CLASS_SOLDIER:
			local->PerformImpulse( IMPULSE_13 );
			break;

		case CLASS_DEMOMAN:
			DetPipe_f( bogus );
			break;

		case CLASS_MEDIC:
			break;

		case CLASS_HWGUY:
			break;

		case CLASS_PYRO:
			break;

		case CLASS_SPY:
			DisguiseRequest_f( bogus );
			break;

		case CLASS_ENGINEER:
			BuildRequest_f( bogus );
			break;
	}
}

void ArgCompletion_Build( const idCmdArgs &args, void(*callback)( const char *s ) ) {
	callback( va( "%s %s", args.Argv( 0 ), "sentrygun") );
	callback( va( "%s %s", args.Argv( 0 ), "dispenser" ) );
}

void ArgCompletion_Disguise( const idCmdArgs &args, void(*callback)( const char *s ) ) {
	if ( args.Argc() == 1 ) {
		callback( va( "%s team", args.Argv( 0 ) ) );
		callback( va( "%s class", args.Argv( 0 ) ) );
	}
	else if ( args.Argc() >= 2 ) {
		if ( !idStr::Icmp( args.Argv( 1 ), "team" ) ) {
			for ( int i = 0; i < TEAM_COUNT; i++ ) {
				callback( va( "%s team %d", args.Argv( 0 ), i+1 ) );
			}
		}
		else if ( !idStr::Icmp( args.Argv( 1 ), "class" ) ) {
			for ( int i = 0; i < CLASS_COUNT-1; i++ ) {
				callback( va( "%s class %d", args.Argv( 0 ), i+1 ) );
			}
			callback( va( "%s class 0", args.Argv( 0 ) ) );
		}
	}
}

void Weapon_axe_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		int num = local->currentPC;
		if ( num == CLASS_MEDIC || num == CLASS_ENGINEER || num == CLASS_SPY ) {
			gameLocal.Printf( "Your class does not have this weapon.\n" );
			return;
		}

		local->PerformImpulse( IMPULSE_0 );
	}
}

void Weapon_wrench_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		if ( local->currentPC != CLASS_ENGINEER ) {
			gameLocal.Printf( "Your class does not have this weapon.\n" );
			return;
		}

		local->PerformImpulse( IMPULSE_0 );
	}
}

void Weapon_knife_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		if ( local->currentPC != CLASS_SPY ) {
			gameLocal.Printf( "Your class does not have this weapon.\n" );
			return;
		}

		local->PerformImpulse( IMPULSE_0 );
	}
}

void Weapon_bio_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		if ( local->currentPC != CLASS_MEDIC ) {
			gameLocal.Printf( "Your class does not have this weapon.\n" );
			return;
		}

		local->PerformImpulse( IMPULSE_0 );
	}
}

void Weapon_sniper_rifle_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		if ( local->currentPC != CLASS_SNIPER ) {
			gameLocal.Printf( "Your class does not have this weapon.\n" );
			return;
		}

		local->PerformImpulse( IMPULSE_1 );
	}
}

void Weapon_auto_rifle_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		if ( local->currentPC != CLASS_SNIPER ) {
			gameLocal.Printf( "Your class does not have this weapon.\n" );
			return;
		}

		local->PerformImpulse( IMPULSE_2 );
	}
}

void Weapon_shotgun_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		switch( local->currentPC ) {
			case CLASS_SCOUT:
			case CLASS_SOLDIER:
			case CLASS_DEMOMAN:
			case CLASS_HWGUY:
			case CLASS_PYRO:
				local->PerformImpulse( IMPULSE_1 );
				return;
		}

		gameLocal.Printf( "Your class does not have this weapon.\n" );
		return;
	}
}

void Weapon_super_shotgun_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		switch( local->currentPC ) {
			case CLASS_SOLDIER:
			case CLASS_HWGUY:
			case CLASS_SPY:
			case CLASS_ENGINEER:
				local->PerformImpulse( IMPULSE_2 );
				return;

			case CLASS_MEDIC:
				local->PerformImpulse( IMPULSE_1 );
				return;

		}

		gameLocal.Printf( "Your class does not have this weapon.\n" );
		return;
	}
}

void Weapon_nailgun_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		switch( local->currentPC ) {
			case CLASS_SCOUT:
				local->PerformImpulse( IMPULSE_2 );
				return;

			case CLASS_SNIPER:
			case CLASS_SPY:
				local->PerformImpulse( IMPULSE_3 );
				return;

		}

		gameLocal.Printf( "Your class does not have this weapon.\n" );
		return;
	}
}

void Weapon_super_nailgun_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		if ( local->currentPC != CLASS_MEDIC ) {
			gameLocal.Printf( "Your class does not have this weapon.\n" );
			return;
		}

		local->PerformImpulse( IMPULSE_2 );
	}
}

void Weapon_rocket_launcher_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		if ( local->currentPC != CLASS_SOLDIER ) {
			gameLocal.Printf( "Your class does not have this weapon.\n" );
			return;
		}

		local->PerformImpulse( IMPULSE_3 );
	}
}

void Weapon_grenade_launcher_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		if ( local->currentPC != CLASS_DEMOMAN ) {
			gameLocal.Printf( "Your class does not have this weapon.\n" );
			return;
		}

		local->PerformImpulse( IMPULSE_2 );
	}
}

void Weapon_pipe_launcher_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		if ( local->currentPC != CLASS_DEMOMAN ) {
			gameLocal.Printf( "Your class does not have this weapon.\n" );
			return;
		}

		local->PerformImpulse( IMPULSE_3 );
	}
}

void Weapon_minigun_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		if ( local->currentPC != CLASS_HWGUY ) {
			gameLocal.Printf( "Your class does not have this weapon.\n" );
			return;
		}

		local->PerformImpulse( IMPULSE_3 );
	}
}

void Weapon_flamethrower_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		if ( local->currentPC != CLASS_PYRO ) {
			gameLocal.Printf( "Your class does not have this weapon.\n" );
			return;
		}

		local->PerformImpulse( IMPULSE_2 );
	}
}

void Weapon_incendiary_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		if ( local->currentPC != CLASS_PYRO ) {
			gameLocal.Printf( "Your class does not have this weapon.\n" );
			return;
		}

		local->PerformImpulse( IMPULSE_3 );
	}
}

void Weapon_tranquilizer_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		if ( local->currentPC != CLASS_SPY ) {
			gameLocal.Printf( "Your class does not have this weapon.\n" );
			return;
		}

		local->PerformImpulse( IMPULSE_1 );
	}
}

void Weapon_railgun_f( const idCmdArgs &args ) {
	idPlayer* local = gameLocal.GetLocalPlayer();
	if ( local && !local->spectating ) {
		if ( local->currentPC != CLASS_ENGINEER ) {
			gameLocal.Printf( "Your class does not have this weapon.\n" );
			return;
		}

		local->PerformImpulse( IMPULSE_1 );
	}
}

void ArgCompletion_Vote( const idCmdArgs &args, void(*callback)( const char *s ) ) {

	int index = 0;
	while ( gameLocal.mpGame.voteSystem.GetVoteOptionName( index ) ) {
		callback( va( "%s %s", args.Argv( 0 ), gameLocal.mpGame.voteSystem.GetVoteOptionName( index ) ) );
		index++;
	}
}


void idGameLocal::InitQ4fConsoleCommands()		// add a flag for q4f cmd's, and then a printer?
{
	cmdSystem->AddCommand( "changeclass",			ChangeClassRequest_f,	CMD_FL_GAME,	"Change your player class upon next spawn.", ArgCompletion_ChangeClass );
	cmdSystem->AddCommand( "jointeam",				ChangeTeamRequest_f,	CMD_FL_GAME,	"Change your team now.", ArgCompletion_ChangeTeam );
	cmdSystem->AddCommand( "team",					ChangeTeamRequest_f,	CMD_FL_GAME,	"Change your team now.", ArgCompletion_ChangeTeam );
	cmdSystem->AddCommand( "spectate",				SpectateRequest_f,		CMD_FL_GAME,	"Go to spectator", ArgCompletion_Spectate );

	cmdSystem->AddCommand( "bindalias",				Alias::Setalias_f,		CMD_FL_GAME,	"Creates a button alias for key presses and key releases.\nUsage: bindalias <key> <press commands> , <release commands>" );
	cmdSystem->AddCommand( "unbindalias",			Alias::Unbindalias_f,		CMD_FL_GAME,	"Removes an alias from a key and free its button.\nUsage: unbindalias <key> or unbindalias all" );
	//cmdSystem->AddCommand( "set_custom",			Alias::Setcvar_f,		CMD_FL_GAME,	"Similar to the 'set' command, but controls over-writable custom cvars", Alias::ArgCompletion_Setcvar );
	cmdSystem->AddCommand( "primeone",				PrimeGrenade_f,			CMD_FL_GAME,	"Primes the primary hand grenade" );
	cmdSystem->AddCommand( "primetwo",				PrimeGrenade_f,			CMD_FL_GAME,	"Primes the secondary hand grenade" );
	cmdSystem->AddCommand( "throwgren",				ThrowGrenade_f,			CMD_FL_GAME,	"Throws the currently primed grenade" );	
	cmdSystem->AddCommand( "detpipe",				DetPipe_f,				CMD_FL_GAME,	"Detonate your placed pipebombs" );
	cmdSystem->AddCommand( "dropammo",				DropAmmo_f,				CMD_FL_GAME,	"Drops an ammo pack.\nEx: \"dropammo rockets 10 25\" will only drop 10 rockets if you have more than 25 rockets in inventory.", ArgCompletion_DropAmmo );
	cmdSystem->AddCommand( "dropflag",				DropFlag_f,				CMD_FL_GAME,	"Drop all carried objects, if they have the 'allowdrop' key set to true." );

	cmdSystem->AddCommand( "name",					Name_f,					CMD_FL_GAME,	"Your name." );
	cmdSystem->AddCommand( "build",					BuildRequest_f,			CMD_FL_GAME,	"Build a sentrygun or ammo dispenser.\nUsage: build <sentrygun or dispenser>", ArgCompletion_Build );
	cmdSystem->AddCommand( "destroy",				Cmd_Destroy_F,			CMD_FL_GAME,	"Destroy your sentrygun or ammo dispenser.\nUsage: destroy <sentrygun> <dispenser>", ArgCompletion_Build );
	
	cmdSystem->AddCommand( "discard",				Discard_f,				CMD_FL_GAME,	"Discard ammo you don't need." );

	cmdSystem->AddCommand( "detpack",				DetPakRequest_f,		CMD_FL_GAME,	"Lay a detpak. Usage: detpack <seconds>" );
	cmdSystem->AddCommand( "disguise",				DisguiseRequest_f,		CMD_FL_GAME,	"Disguise as another class or team.\nUsage: disguise team<team #/name>\ndisguise class<class #/name>", ArgCompletion_Disguise );
	
	cmdSystem->AddCommand( "special",				Special_f,				CMD_FL_GAME,	"Do a class-specific special function." );

	cmdSystem->AddCommand( "writestats",			PrintXML,				CMD_FL_GAME, "" );

	cmdSystem->AddCommand( "cvarlist", Cmd_cvarlist_f, CMD_FL_GAME, "Print all cvars. Use 'cvarlist <text>' to print cvars containing <text>" );

	cmdSystem->AddCommand( "PrintEndGameAwards", PrintEndGameAwards_f, CMD_FL_GAME, "Print end game awards as of the current stats" );



	cmdSystem->AddCommand( "scout", ClassName_f, CMD_FL_GAME, "Change class to scout" );
	cmdSystem->AddCommand( "sniper", ClassName_f, CMD_FL_GAME, "Change class to sniper" );
	cmdSystem->AddCommand( "soldier", ClassName_f, CMD_FL_GAME, "Change class to soldier" );
	cmdSystem->AddCommand( "demoman", ClassName_f, CMD_FL_GAME, "Change class to demoman" );
	cmdSystem->AddCommand( "medic", ClassName_f, CMD_FL_GAME, "Change class to medic" );
	cmdSystem->AddCommand( "hwguy", ClassName_f, CMD_FL_GAME, "Change class to hwguy" );
	cmdSystem->AddCommand( "pyro", ClassName_f, CMD_FL_GAME, "Change class to pyro" );
	cmdSystem->AddCommand( "spy", ClassName_f, CMD_FL_GAME, "Change class to spy" );
	cmdSystem->AddCommand( "engineer", ClassName_f, CMD_FL_GAME, "Change class to engineer" );
	cmdSystem->AddCommand( "civilian", ClassName_f, CMD_FL_GAME, "Change class to scout" );

	cmdSystem->AddCommand( "recon", ClassName_f, CMD_FL_GAME, "Change class to scout" );
	cmdSystem->AddCommand( "grenadier", ClassName_f, CMD_FL_GAME, "Change class to demoman" );
	cmdSystem->AddCommand( "paramedic", ClassName_f, CMD_FL_GAME, "Change class to medic" );
	cmdSystem->AddCommand( "mini", ClassName_f, CMD_FL_GAME, "Change class to hwguy" );
	cmdSystem->AddCommand( "minigunner", ClassName_f, CMD_FL_GAME, "Change class to hwguy" );
	cmdSystem->AddCommand( "flametrooper", ClassName_f, CMD_FL_GAME, "Change class to pyro" );
	cmdSystem->AddCommand( "agent", ClassName_f, CMD_FL_GAME, "Change class to spy" );

	cmdSystem->AddCommand( "weapon_gauntlet", Weapon_axe_f, CMD_FL_GAME, "Switch weapons to gauntlet" );
	cmdSystem->AddCommand( "weapon_wrench", Weapon_wrench_f, CMD_FL_GAME, "Switch weapons to wrench" );
	cmdSystem->AddCommand( "weapon_knife", Weapon_knife_f, CMD_FL_GAME, "Switch weapons to knife" );
	cmdSystem->AddCommand( "weapon_bio", Weapon_bio_f, CMD_FL_GAME, "Switch weapons to bio weapon" );
	
	cmdSystem->AddCommand( "weapon_shotgun", Weapon_shotgun_f, CMD_FL_GAME, "Switch weapons to shotgun" );
	cmdSystem->AddCommand( "weapon_super_shotgun", Weapon_super_shotgun_f, CMD_FL_GAME, "Switch weapons to super shotgun" );
	cmdSystem->AddCommand( "weapon_nailgun", Weapon_nailgun_f, CMD_FL_GAME, "Switch weapons to nailgun" );
	cmdSystem->AddCommand( "weapon_super_nailgun", Weapon_super_nailgun_f, CMD_FL_GAME, "Switch weapons to super nailgun" );
	cmdSystem->AddCommand( "weapon_sniper_rifle", Weapon_sniper_rifle_f, CMD_FL_GAME, "Switch weapons to sniper rifle" );
	cmdSystem->AddCommand( "weapon_auto_rifle", Weapon_auto_rifle_f, CMD_FL_GAME, "Switch weapons to auto rifle" );

	cmdSystem->AddCommand( "weapon_rocket_launcher", Weapon_rocket_launcher_f, CMD_FL_GAME, "Switch weapons to rocket launcher" );
	cmdSystem->AddCommand( "weapon_grenade_launcher", Weapon_grenade_launcher_f, CMD_FL_GAME, "Switch weapons to grenade launcher" );
	cmdSystem->AddCommand( "weapon_pipe_launcher", Weapon_pipe_launcher_f, CMD_FL_GAME, "Switch weapons to pipe launcher" );
	cmdSystem->AddCommand( "weapon_minigun", Weapon_minigun_f, CMD_FL_GAME, "Switch weapons to minigun" );
	cmdSystem->AddCommand( "weapon_flamethrower", Weapon_flamethrower_f, CMD_FL_GAME, "Switch weapons to flamethrower" );
	cmdSystem->AddCommand( "weapon_incendiary", Weapon_incendiary_f, CMD_FL_GAME, "Switch weapons to incendiary cannon" );
	cmdSystem->AddCommand( "weapon_tranquilizer", Weapon_tranquilizer_f, CMD_FL_GAME, "Switch weapons to tranquilizer" );
	cmdSystem->AddCommand( "weapon_railgun", Weapon_railgun_f, CMD_FL_GAME, "Switch weapons to railgun" );

	cmdSystem->AddCommand( "reload", Reload_f, CMD_FL_GAME, "Reload your weapon" );
	cmdSystem->AddCommand( "lastweapon", LastWeapon_f, CMD_FL_GAME, "Switch to last selected weapon" );

	cmdSystem->AddCommand( "rotateSentry", RotateSentry_f, CMD_FL_GAME, "Rotate your sentry gun. Usage: rotateSentry <degrees>" );

	cmdSystem->AddCommand( "comMenu", ComMenu_F, CMD_FL_GAME, "Open the communications menu, or execute a communications item.\nUsage: comMenu <category> <item>" );

	cmdSystem->AddCommand( "locationsAdd", LocationsAdd_f, CMD_FL_GAME, "Add a location for this map.\nUsage: locationsAdd \"location team # or name\" \"location name\"" );
	cmdSystem->AddCommand( "locationsRemove", LocationsRemove_f, CMD_FL_GAME, "Remove a location for this map.\nUsage: locationsRemove [location index]\nUse 'locationsList' to display a list of locations and their index." );
	cmdSystem->AddCommand( "locationsList", LocationsList_f, CMD_FL_GAME, "Print a list of the map's locations." );

	cmdSystem->AddCommand( "vote", q4fVoteSys::RequestVoteStart_f, CMD_FL_GAME, "Start a vote.", ArgCompletion_Vote );

	


	//cmdSystem->AddCommand( "special",				idMultiplayerGame::ActivateSpecial_f,		CMD_FL_GAME, "Activates the class' special ability." );
	//cmdSystem->AddCommand( "build",					idMultiplayerGame::Build_f,					CMD_FL_GAME,	"" );
	//cmdSystem->AddCommand( "detpack",				idMultiplayerGame::Detpack_f,				CMD_FL_GAME,	"Places a detpack. Usage: detpack <seconds>, seconds >= 5.0" );		
}