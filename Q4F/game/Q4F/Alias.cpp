#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"


Alias::Alias() {
	for ( int i = 0; i < BUTTON_COUNT; i++ ) {
		aliases[i].inUse = false;
		aliases[i].button = BIT( i + 9 );
		aliases[i].pressCommands.Clear();
		aliases[i].releaseCommands.Clear();
		aliases[i].key.Clear();
	}

	aliasCVars.Clear();
}

void Alias::CreateAlias( const char* key, idStr &pressCmds, idStr &releaseCmds ) {

	idStr myKey = key;
	myKey.Strip( " " );

	int butIndex = -1;
	// check if this key is already bound
	for ( int i = 0; i < BUTTON_COUNT; i++ ) {
		if ( !aliases[i].key.Icmp( myKey ) ) {
			butIndex = i;
			break;
		}
	}

	if ( butIndex < 0 ) {
		// find free index
		for ( int i = 0; i < BUTTON_COUNT; i++ ) {
			if ( !aliases[i].inUse ) {
				butIndex = i;
				break;
			}
		}
	}

	if ( butIndex < 0 ) {
		gameLocal.Warning( "Alias: could not find a free _button for the alias. Try unbinding an alias using 'unbindalias <key>' or 'unbindalias all'" );
		return;
	}

	assert( butIndex >= 0 && butIndex < BUTTON_COUNT );

	aliases[butIndex].key = myKey;
	aliases[butIndex].inUse = true;
	aliases[butIndex].pressCommands = pressCmds;
	aliases[butIndex].releaseCommands = releaseCmds;

	cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "bind %s _button%d", key, butIndex+1 ) );

	gameLocal.Printf( "Alias created. Press '%s' to start using it.\n", myKey.c_str() );
}

void Alias::RemoveAlias( const char* key ) {
	idStr myKey = key;
	myKey.Strip( " " );

	if ( !myKey.Icmp( "all" ) ) {
		for ( int i = 0; i < BUTTON_COUNT; i++ ) {
			if ( aliases[i].inUse ) {
				aliases[i].inUse = false;
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "unbind %s", aliases[i].key.c_str() ) );
			}
		}
	}
	else {
		for ( int i = 0; i < BUTTON_COUNT; i++ ) {
			if ( aliases[i].inUse && !myKey.Icmp( aliases[i].key ) ) {
				aliases[i].inUse = false;
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "unbind %s", aliases[i].key.c_str() ) );
			}
		}
	}
}

bool Alias::GetKeyAlias( const char* key, idStr & press, idStr &release ) {
	idStr mykey = key;
	mykey.Strip( " " );

	for ( int i = 0; i < BUTTON_COUNT; i++ ) {
		if ( !aliases[i].key.Icmp( mykey ) ) {
			press = aliases[i].pressCommands;
			release = aliases[i].releaseCommands;
			return true;
		}
	}

	return false;
}

void Alias::AddCVar( idStr &name, idStr &commands ) {
	// check if this cvar already exists in the game's cvars
	idCVar* found = cvarSystem->Find( name.c_str() );

	if ( found ) {
		gameLocal.Printf( "The cvar '%s' already exists.\nTo update a game cvar, use 'set' instead of 'setcustom'\n", name.c_str() );
		return;
	}

	// check if our list already has it. If so, update it
	for ( int i = 0; i < aliasCVars.Num(); i++ ) {
		if ( idStr::Icmp( aliasCVars[i].GetName(), name.c_str() ) ) {
			// already exists, update it
			aliasCVars[i].SetString( commands.c_str() );
			gameLocal.Printf( "Custom CVar updated.\n" );
			return;
		}
	}

	// it doesn't exist, add it
	idCVar newvar( name.c_str(), commands.c_str(), CVAR_GAME , "custom cvar" );
	aliasCVars.Append( newvar );

	gameLocal.Printf( "New custom CVar created.\n" );
}


//--------------------------------------------------------------------------
// Should be called before the player thinks about ANYTHING
//--------------------------------------------------------------------------
void Alias::UpdateAliases( short oldButtons, short newButtons ) {

	if ( !gameLocal.isLastPredictFrame ) {
		return;
	}
	
	for ( int i = 0; i < BUTTON_COUNT; i++ ) {
		if ( aliases[i].inUse ) {

			// if pressed...
			if ( !( oldButtons & aliases[i].button ) && ( newButtons & aliases[i].button ) ) {
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, aliases[i].pressCommands.c_str() );
			}

			// if released...
			else if ( ( oldButtons & aliases[i].button ) && !( newButtons & aliases[i].button ) ) {
				cmdSystem->BufferCommandText( CMD_EXEC_NOW, aliases[i].releaseCommands.c_str() );
			}
		}
	}
}