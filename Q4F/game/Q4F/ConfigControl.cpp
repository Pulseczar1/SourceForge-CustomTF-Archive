
#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"

ConfigLine::ConfigLine() {
	_type = CFG_MISC;
	Next = NULL;
	_lineTxt.Clear();
}

ConfigLine::ConfigLine( const char* txt ) {
	_type = CFG_MISC;
	Next = NULL;
	Load( txt );
}

void ConfigLine::Load( const char* txt ) {
	_lineTxt = txt;

	val0.Clear();
	val1.Clear();
	val2.Clear();

	idCmdArgs args;
	args.TokenizeString( txt, false );

	if ( !idStr::Icmp( args.Argv( 0 ), "bind" ) ) {
		if ( args.Argc() < 3 ) {
			gameLocal.Warning( "ConfigLine::Load - unknown format for bind line '%s'\n", txt );
			return;
		}

		val0 = args.Argv( 1 );

		for ( int i = 2; i < args.Argc(); i++ ) {
			val1.Append( args.Argv( 1 ) );
			val1.Append( " " );
		}

		_type = CFG_BIND;
	}
	else if ( !idStr::Icmp( args.Argv( 0 ), "seta" ) ||
		!idStr::Icmp( args.Argv( 0 ), "set" ) ) {

		if ( args.Argc() < 3 ) {
			gameLocal.Warning( "ConfigLine::Load - unknown format for cvar line '%s'\n", txt );
			return;
		}

		val0 = args.Argv( 1 );

		for ( int i = 2; i < args.Argc(); i++ ) {
			val1.Append( args.Argv( 1 ) );
			val1.Append( " " );
		}

		_type = CFG_CVAR;
	}
	else if ( !idStr::Icmp( args.Argv( 0 ), "bind_alias" ) ) {
		if ( args.Argc() < 3 ) {
			gameLocal.Warning( "ConfigLine::Load - unknown format for bind_alias line '%s'\n", txt );
			return;
		}

		val0 = args.Argv( 1 );

		idStr wholeCMD;
		for ( int i = 2; i < args.Argc(); i++ ) {
			wholeCMD.Append( args.Argv( i ) );
			wholeCMD.Append( " " );
		}

		idList<idStr> cmds;
		wholeCMD.Split( cmds, ',', 0 );

		if ( cmds.Num() != 2 ) {
			gameLocal.Warning( "ConfigLine::Load - unknown format for bind_alias line '%s'\n", txt );
			return;
		}

		val1 = cmds[0];
		val2 = cmds[1];
	}
}


Config::Config() {
	ConfigNum = -1;
	File = "";
}

Config::~Config() {
	ConfigLine* line = _linesStart.Next;
	ConfigLine* nextLine;

	while ( line ) {
		nextLine = line->Next;
		delete line;
		line = nextLine;
	}
}

void Config::Init() {
	_linesStart.Next = NULL;
}

void Config::Load( const char* txt ) {
	Init();

	if ( !txt || !txt[0] )
		return;

	ConfigLine* currLine = &_linesStart;

	int index = 0;

	char lineBuf[256];
	bool eof = false;

	while ( !eof ) {
		eof = ReadLine( txt, index, lineBuf );

		currLine->Next = GetConfigLine( lineBuf );
		currLine->Next->Load( lineBuf );
		currLine = currLine->Next;
	}
}

void Config::Save() {
	if ( !File[0] ) {
		gameLocal.Warning( "Config: cannot save, file is not specified." );
		return;
	}

	idFile* file = fileSystem->OpenFileWrite( File.c_str(), "q4f" );
	if ( !file ) {
		gameLocal.Warning( "Config: could not open file '%s' for writing.", File.c_str() );
		return;
	}

	ConfigLine* line = _linesStart.Next;

	idStr text;

	while ( line ) {
		text = line->GetFullText();
		file->Write( text.c_str(), text.Length() + 1 );
		line = line->Next;
		if ( line )
			file->Write( "\n", 1 );
	}

	fileSystem->CloseFile( file );
}

ConfigLine* Config::GetConfigLine( const char* txt ) {

	while ( txt[0] != '\0' && txt[0] <= ' ' ) {
		txt++;
	}

	ConfigLine* line = new ConfigLine();
	line->Load( txt );
	return line;
}

const char* Config::GetCVarVal( const char* name ) {
	const char* val = NULL;

	ConfigLine* line = GetNextType( NULL, CFG_CVAR );

	while ( line ) {
		if ( line->GetCVarName().Icmp( name ) == 0 ) {
			val = line->GetCVarName().c_str();
		}
		line = GetNextType( line, CFG_CVAR );
	}

	return val;
}

const char* Config::KeyForBind( const char* bind ) {

	const char* key = NULL;

	ConfigLine* line = GetNextType( NULL, CFG_BIND );

	while ( line ) {

		if ( line->GetBindCmd().Icmp( bind ) == 0 ) {
			key = line->GetBindKey();
		}
		line = GetNextType( line, CFG_BIND );
	}

	return key;
}

const char* Config::BindForKey( const char* key ) {
	
	const char* bind = NULL;

	ConfigLine* line = GetNextType( NULL, CFG_BIND );

	while ( line ) {

		if ( line->GetBindKey().Icmp( key ) == 0 ) {
			bind = line->GetBindCmd();
		}
		line = GetNextType( line, CFG_BIND );
	}

	return bind;
}

void Config::AddAlias( const char* key, const char* press, const char* release ) {
	/*ConfigAlias* newAlias = new ConfigAlias();
	newAlias->Key = key;
	newAlias->Press = press;
	newAlias->Release = release;

	AddLine( newAlias );*/
}

void Config::AddBind( const char* key, const char* cmd ) {
	/*ConfigBind* newBind = new ConfigBind();
	newBind->Key = key;
	newBind->Command = cmd;

	AddLine( newBind );*/
}

void Config::AddCVar( const char* name, const char* val ) {
	/*ConfigCVar* newCVar = new ConfigCVar();
	newCVar->Name = name;
	newCVar->Value = val;

	AddLine( newCVar );*/
}

void Config::AddLine( ConfigLine* toAdd ) {
	/*assert( toAdd );

	ConfigLine* next = GetNextType( NULL, toAdd->GetType() );
	ConfigLine* lastRemove = NULL;
	ConfigLine* prev = &_linesStart;

	while ( next != NULL ) {
		if ( toAdd->Equals( next ) ) {
			RemoveLine( next );
			lastRemove = prev;
		}
		prev = next;
		next = GetNextType( next, toAdd->GetType() );
	}

	if ( lastRemove ) {
		toAdd->Next = lastRemove->Next;
		lastRemove->Next = toAdd;
	}
	else {
		AppendToEnd( toAdd );
	}*/
}

void Config::AppendToEnd( ConfigLine* line ) {
	/*ConfigLine* next = &_linesStart;
	while( next->Next ) {
		next = next->Next;
	}

	assert( next && !next->Next );
	line->Next = NULL;
	next->Next = line;*/
}


Keyboard::Keyboard() {
}

Keyboard::~Keyboard() {
	kbLex.FreeSource();
}

void Keyboard::LoadKBFile( const char* name ) {
	kbLex.FreeSource();

	const char* file = va( "config/keyboards/%s", name );

	if ( !kbLex.LoadFile( file, false ) ) {
		gameLocal.Error( "Could not load the keyboard file: %s\n", file );
	}
}

void Keyboard::Draw( idUserInterface* gui ) {

	if ( !kbLex.IsLoaded() ) {
		gameLocal.Warning( "Could not draw the keyboard gui, no keyboard file has been loaded." );
		return;
	}

	kbLex.Reset();

	kbLex.ExpectTokenString( "keyboard" );
	kbLex.ExpectTokenString( "{" );

	idToken tok;

	int rowY = 0;
	int colX = 0;

	while ( kbLex.ReadToken( &tok ) ) {

		if ( !tok.Icmp( "key" )) {
			kbLex.ExpectTokenString( "(" );

			kbLex.ReadToken( &tok );
			idStr key = tok;

			kbLex.ReadToken( &tok );
			idStr txt = tok;

			kbLex.ReadToken( &tok );
			int width = tok.GetIntValue();

			kbLex.ReadToken( &tok );
			int height = tok.GetIntValue();

			kbLex.ExpectTokenString( ")" );

			gui->SetStateInt( va( "kb_%s_rect_x", key.c_str() ), colX );
			gui->SetStateInt( va( "kb_%s_rect_y", key.c_str() ), rowY );
			gui->SetStateInt( va( "kb_%s_rect_z", key.c_str() ), width );
			gui->SetStateInt( va( "kb_%s_rect_w", key.c_str() ), height );

			gui->SetStateString( va( "gui::kb_%s_text", key.c_str() ), txt.c_str() );
			gui->SetStateInt( va( "kb_%s_type", key.c_str() ), CommandTypeForKey( key ) );

			colX += width;
		}
		else if ( !tok.Icmp( "space" )) {
			kbLex.ExpectTokenString( "(" );

			kbLex.ReadToken( &tok );
			int width = tok.GetIntValue();

			colX += width;

			kbLex.ExpectTokenString( ")" );
		}
		else if ( !tok.Icmp( "row" )) {
			kbLex.ExpectTokenString( "(" );

			kbLex.ReadToken( &tok );
			int height = tok.GetIntValue();

			rowY += height;
			colX = 0;

			kbLex.ExpectTokenString( ")" );
		}
		else if ( !tok.Icmp( "version" ) ) {
			kbLex.ExpectTokenString( "(" );
			kbLex.ReadToken( &tok );
			kbLex.ExpectTokenString( ")" );
		}
	}

	kbLex.ExpectTokenString( "}" );
}

int Keyboard::CommandTypeForKey( idStr &key ) {

	const char* cmd = common->BindingFromKey( key.c_str() );

	if ( !cmd || !cmd[0] ) {
		return 0;
	}

	idCmdArgs args;
	args.TokenizeString( cmd, false );

	const char* arg = NULL;

	for ( int i = 0; i < args.Argc(); i++ ) {
		arg =  args.Argv( i );
		if ( !idStr::Icmpn( arg, "_", 1 ) ) {
			if ( !idStr::Icmp( arg, "_forward" ) ||
				 !idStr::Icmp( arg, "_backward" ) ||
				 !idStr::Icmp( arg, "_moveleft" ) ||
				 !idStr::Icmp( arg, "_moveright" ) ||
				 !idStr::Icmp( arg, "_moveup" ) ||
				 !idStr::Icmp( arg, "_movedown" ) ||
				 !idStr::Icmp( arg, "_zoom" ) )			return 1;

			else if ( !idStr::Icmp( arg, "_attack" ) ||

				( !idStr::Icmpn( arg, "_impulse", 8 ) && (
				  !idStr::Icmp( arg, "_impulse0" ) ||
				  !idStr::Icmp( arg, "_impulse1" ) ||
				  !idStr::Icmp( arg, "_impulse2" ) ||
				  !idStr::Icmp( arg, "_impulse3" ) ||
				  !idStr::Icmp( arg, "_impulse13" ) ||
				  !idStr::Icmp( arg, "_impulse14" ) ||
				  !idStr::Icmp( arg, "_impulse15" ) ) ) )		return 2;
		}

		else if ( !idStr::Icmp( arg, "primeone" ) ||
			      !idStr::Icmp( arg, "primetwo" ) ||
				  !idStr::Icmp( arg, "throwgren" ) )			return 2;

		else if ( !idStr::Icmp( arg, "say" ) ||
			      !idStr::Icmp( arg, "say_team" ) )			return 3;


	}
	
	return 5;
}



Config* ConfigControl::CurrentConfig = NULL;

#define MAX_CFG_LENGTH 15000

ConfigControl::ConfigControl() {
	CurrentConfig = NULL;
}

ConfigControl::~ConfigControl() {
	if ( CurrentConfig ) {
		delete CurrentConfig;
		CurrentConfig = NULL;
	}
}

const char* index2config[] = {
	"config/classes/scout.cfg",
	"config/classes/sniper.cfg",
	"config/classes/soldier.cfg",
	"config/classes/demoman.cfg",
	"config/classes/medic.cfg",
	"config/classes/hwguy.cfg",
	"config/classes/pyro.cfg",
	"config/classes/spy.cfg",
	"config/classes/engineer.cfg",
	"config/classes/civilian.cfg",
	"config/classes/_base.cfg",
	"quake4config.cfg",
	"autoexec.cfg",
	NULL
};

Config* ConfigControl::LoadConfig( int cfgNum ) {
	return LoadConfig( index2config[ cfgNum ] );
}

Config* ConfigControl::LoadConfig( const char *filename ) {
	if ( CurrentConfig ) {
		delete CurrentConfig;
		CurrentConfig = NULL;
	}

	char fileBuf[MAX_CFG_LENGTH];
	idFile* file;

	CurrentConfig = new Config();

	file = fileSystem->OpenFileRead( filename );
	if ( file ) {
		file->Read( fileBuf, MAX_CFG_LENGTH );
		fileBuf[file->Length()] = '\0'; \
		fileSystem->CloseFile( file ); \
 
		CurrentConfig->Load( fileBuf );
		CurrentConfig->File = filename;
	}

	return CurrentConfig;
}


void ConfigControl::FillGUI( idUserInterface* gui ) {

	int guiNum = gui->GetStateInt( "current_config_num", "0" );
	LoadConfig( guiNum );
}

void ConfigControl::SaveGUIConfig() {
	if ( !CurrentConfig ) {
		gameLocal.Warning( "Cannot save config, no config is loaded." );
		return;
	}

	CurrentConfig->Save();
}
