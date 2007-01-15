#include "../../../idlib/precompiled.h"
#pragma hdrstop

#include "../../Game_local.h"

// ==================================================
// MesageItem
// ==================================================

const char* MessageItem::GetLabel() {
	return Args.GetString( "label", "no label" ) ;
}

const char* MessageItem::GetName() {
	return Args.GetString( "name", "no name" );
}

void MessageItem::Execute() {
	const char* snd = Args.GetString( "sound", "" );
	const char* msg = Args.GetString( "message", "" );
	const char* targetStr = Args.GetString( "target", "team" );

	if ( !msg || !msg[0] ) {
		gameLocal.Warning( "MessagItem '%s': Message is empty.", GetLabel() );
		return;
	}

	int target = 0;		// 0=team,1=all,2=target

	if ( !idStr::Icmp( targetStr, "all" ) )
		target = 1;
	else if ( !idStr::Icmp( targetStr, "target" ) )
		target = 2;

	if ( target == 0 ) {
		if ( snd[0] )
			cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "sayTeam \"!%s %s\"", snd, msg ) );
		else
			cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "sayTeam \"%s\"", msg ) );
	}
	else if ( target == 1 ) {
		if ( snd[0] )
			cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "say \"!%s %s\"", snd, msg ) );
		else
			cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "say \"%s\"", msg ) );
	}
	else if ( target == 2 ) {
		if ( snd[0] )
			cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "sayTarget \"!%s %s\"", snd, msg ) );
		else
			cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "sayTarget \"%s\"", msg ) );
	}
}



// ==================================================
// MesageList
// ==================================================

MessageList::MessageList() {
	_numitems = 0;
}

MessageItem* MessageList::GetItem( int num ) {
	if ( num < 0 || num >= _numitems )
		return NULL;

	return &(_messages[num]);
}


MessageItem* MessageList::GetItem( const char* name ) {
	for ( int i = 0; i < _numitems; i++ ) {
		if ( !idStr::Icmp( _messages[i].GetName(), name ) )
			return &(_messages[i]);
	}
	return NULL;
}

MessageItem* MessageList::AddItem() {
	if ( _numitems >= MAX_MESSAGE_LIST_ITEMS )
		return NULL;

	_numitems++;

	return &(_messages[_numitems-1]);
}

const char* MessageList::GetName() {
	return Args.GetString( "name", "no name" );
}

const char* MessageList::GetLabel() {
	return Args.GetString( "label", "no label" );
}

void MessageList::Clear() {
	for ( int i = 0; i < MAX_MESSAGE_LIST_ITEMS; i++ ) {
		_messages[i].Args.Clear();
	}
}




// ==================================================
// MesageListCollection
// ==================================================

//--------------------------------------------------------------------------
// Initialize our smack
//--------------------------------------------------------------------------
MessageListCollection::MessageListCollection() {
}


//--------------------------------------------------------------------------
// Load a mapinfo from the specified map name. If the mapinfo doesn't exist,
// _default.mapinfo is loaded instead.
//--------------------------------------------------------------------------
void MessageListCollection::Load( void ) {

	const char* filePath = "config/comm/communication.cfg";

	idLexer mainLex;

	if ( !mainLex.LoadFile( filePath ) ) {
		LexError( va( "could not the communication config file '%s'", filePath ) );
		return;
	}

	if ( !mainLex.IsLoaded() ) {
		LexError( "could not load lexer." );
		return;
	}

	_lists.Clear();
	ParseMessageList( mainLex );
	mainLex.FreeSource();
}

//--------------------------------------------------------------------------
// Parse a map info file
//--------------------------------------------------------------------------
void MessageListCollection::ParseMessageList( idLexer &lex ) {

	if ( !lex.IsLoaded() ) {
		gameLocal.Error( "MessageListCollection: ParseMessageList: lexer is not loaded." );
		return;
	}

	idToken tok, tok2;

	int state = 0;

	MessageList* currentList = NULL;
	MessageItem* currentItem = NULL;

	while ( lex.ReadToken( &tok ) ) {
		switch( state ) {
			case 0:
				if ( !idStr::Icmp( tok, "msgList" ) ) {
					currentList = &(_lists.Alloc());
					if ( !lex.ReadToken( &tok ) || !idStr::Icmp( tok, "{" ) ) {
						LexError( "Expected a name for msgList", &lex );
						return;
					}
					currentList->Args.Set( "name", tok.c_str() );
					currentList->Index = _lists.Num() - 1;
					state = 1;
					continue;
				}
				break;

			case 1:
				if ( !idStr::Icmp( tok, "{" ) ) {
					state = 2;
					continue;
				}

				break;

			case 2:
				if ( !idStr::Icmp( tok, "msgItem" ) ) {
					if ( !lex.ReadToken( &tok ) || !idStr::Icmp( tok, "{" ) ) {
						LexError( "Expected a name for msgItem", &lex );
						return;
					}
					currentItem = currentList->AddItem();

					if ( currentItem == NULL ) {
						LexError( va( "Too many message items for list '%s'. Max is '%d'", currentList->GetName(), MAX_MESSAGE_LIST_ITEMS ), &lex );
						return;
					}

					currentItem->Args.Set( "name", tok.c_str() );
					state = 3;
					continue;
				}
				else if ( !idStr::Icmp( tok, "}" ) ) {
					state = 0;
					continue;
				}
				else {
					lex.ReadToken( &tok2 );
					currentList->Args.Set( tok.c_str(), tok2.c_str() );
					continue;
				}

				break;

			case 3:
				if ( !idStr::Icmp( tok, "{" ) ) {
					state = 4;
					continue;
				}

				break;

			case 4:
				if ( !idStr::Icmp( tok, "}" ) ) {
					state = 2;
					continue;
				}
				else {
					lex.ReadToken( &tok2 );
					currentItem->Args.Set( tok.c_str(), tok2.c_str() );
					continue;
				}

				break;

		}

		LexError( va( "Unexpected token '%s'", tok.c_str() ), &lex );
		return;
	}
}

MessageList* MessageListCollection::GetList( const char* name ) {
	for ( int i = 0; i < _lists.Num(); i++ ) {
		if ( !idStr::Icmp( _lists[i].GetName(), name ) )
			return &(_lists[i]);
	}
	return NULL;
}

MessageList* MessageListCollection::GetList( int num ) {
	if ( num >= 0 && num < _lists.Num() )
		return &(_lists[num]);
	return NULL;
}

void MessageListCollection::Clear() {
	for ( int i = 0; i < _lists.Num(); i++ ) {
		_lists[i].Clear();
	}
	_lists.Clear();
}

//--------------------------------------------------------------------------
// Throw an error to the game
//--------------------------------------------------------------------------
void MessageListCollection::LexError( const char* error, idLexer* lex ) {
	if ( lex ) {
		lex->FreeSource();
		gameLocal.Error( va( "MapInfo: %s :: file %s line %d\n", error, lex->GetFileName(), lex->GetLineNum() ) );
	}
	else {
		gameLocal.Error( va( "%s\n", error ) );
	}
}
