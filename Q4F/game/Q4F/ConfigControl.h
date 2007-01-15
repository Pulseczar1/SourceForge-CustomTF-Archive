#ifndef __Q4F_CONFIG_CONTROL__
#define __Q4F_CONFIG_CONTROL__

typedef enum cfgLineType_s {
	CFG_MISC,
	CFG_BIND,
	CFG_BIND_ALIAS,
	CFG_CVAR,
} cfgLineType_t;

class ConfigLine {
	
public:

	ConfigLine( void );

	ConfigLine( const char* txt );

	void			Load( const char* txt );

	cfgLineType_t	GetType( void ) { return _type; };

	const idStr&			GetCVarName( void );
	const idStr&			GetCVarValue( void );

	const idStr&			GetBindKey( void );
	const idStr&			GetBindCmd( void );

	const idStr&			GetAliasKey( void );
	const idStr&			GetAliasPressCmd( void );
	const idStr&			GetAliasReleaseCmd( void );

	const idStr&			GetFullText( void ) { return _lineTxt; };

protected:

	friend class	Config;

	ConfigLine*		Next;

	idStr			val0;
	idStr			val1;
	idStr			val2;

	idStr			_lineTxt;

	cfgLineType_t	_type;
};

ID_INLINE const idStr& ConfigLine::GetCVarName( void ) {
	if ( _type != CFG_CVAR ) {
		common->Error( "ConfigLine::GetCVarName - i am not a cvar line" );
	}

	return val0;
}

ID_INLINE const idStr& ConfigLine::GetCVarValue( void ) {
	if ( _type != CFG_CVAR ) {
		common->Error( "ConfigLine::GetCVarValue - i am not a cvar line" );
	}

	return val1;
}

ID_INLINE const idStr& ConfigLine::GetBindKey( void ) {
	if ( _type != CFG_BIND ) {
		common->Error( "ConfigLine::GetBindKey - i am not a bind line" );
	}

	return val0;
}

ID_INLINE const idStr& ConfigLine::GetBindCmd( void ) {
	if ( _type != CFG_BIND ) {
		common->Error( "ConfigLine::GetBindCmd - i am not a bind line" );
	}

	return val1;
}

ID_INLINE const idStr& ConfigLine::GetAliasKey( void ) {
	if ( _type != CFG_BIND_ALIAS ) {
		common->Error( "ConfigLine::GetAliasKey - i am not an alias line" );
	}

	return val0;
}

ID_INLINE const idStr& ConfigLine::GetAliasPressCmd( void ) {
	if ( _type != CFG_BIND_ALIAS ) {
		common->Error( "ConfigLine::GetAliasPressCmd - i am not an alias line" );
	}

	return val1;
}

ID_INLINE const idStr& ConfigLine::GetAliasReleaseCmd( void ) {
	if ( _type != CFG_BIND_ALIAS ) {
		common->Error( "ConfigLine::GetAliasReleaseCmd - i am not an alias line" );
	}

	return val2;
}



class Config {
public:
					Config( void );
					~Config();

	void			Load( const char* txt );

	const char*		KeyForBind( const char* bind );
	const char*		BindForKey( const char* key );
	const char*		GetCVarVal( const char* name );

	void			AddAlias( const char* key, const char* press, const char* release );
	void			AddBind( const char* key, const char* cmd );
	void			AddCVar( const char* name, const char* val );

    void			AddLine( ConfigLine* toAdd );

					// index is -1 if add to end
	ConfigLine*		InsertLine( int index, const char* txt );
	void			RemoveLine( ConfigLine* toRemove );

	void			Save( void );

	int				ConfigNum;
	idStr			File;

private:
	void			Init( void );
	bool			ReadLine( const char* txt, int &start, char* buf );

	void			AppendToEnd( ConfigLine* line );

	ConfigLine*		GetNextType( ConfigLine* start, cfgLineType_t type );

	ConfigLine*		GetConfigLine( const char* txt );

	ConfigLine		_linesStart;
};

ID_INLINE void Config::RemoveLine( ConfigLine *toRemove ) {
	ConfigLine* curr = &_linesStart;

	while ( curr ) {
		if ( curr->Next == toRemove ) {
			curr->Next = toRemove->Next;
			delete toRemove;
			toRemove = NULL;
			break;
		}

		curr = curr->Next;
	}
}

ID_INLINE bool Config::ReadLine( const char* txt, int &start, char* buf ) {
	int bufIndex = 0;
	
	bool eof = false;
	while ( true ) {
		if ( txt[start] == '\0' ) {
			eof = true;
			break;
		}
		else if ( txt[start] == '\n' ) {
			break;
		}

		if ( txt[start] < ' ' ) {
			start++;
			continue;
		}

		buf[bufIndex] = txt[start];
		start++;
		bufIndex++;
	}

	buf[bufIndex] = '\0';
	start++;
	return eof;
}

ID_INLINE ConfigLine* Config::GetNextType( ConfigLine* lastAlias, cfgLineType_t type ) {
	ConfigLine* start = lastAlias ? lastAlias->Next : _linesStart.Next;

	while ( start ) {
		if ( start->GetType() == type ) {
			return start;
		}
		start = start->Next;
	}

	return NULL;
}

ID_INLINE ConfigLine* Config::InsertLine( int index, const char* txt ) {

	ConfigLine* current = &(_linesStart);

	if ( index < 0 ) {
		ConfigLine* newLine = new ConfigLine( txt );
		AppendToEnd( newLine );
		return newLine;
	}

	int count = 0;

	while ( count < index ) {
		count++;

		if ( current->Next == NULL ) {
			current->Next = new ConfigLine();
		}

		current = current->Next;
	}
	
	assert( current );

	ConfigLine* newLine = new ConfigLine( txt );

	newLine->Next = current->Next;
	current->Next = newLine;

	return newLine;
}





class Keyboard {
public:
						Keyboard( void );
						~Keyboard( void );

	void				LoadKBFile( const char* name );
	void				Draw( idUserInterface* GUI );

private:
	idLexer				kbLex;
	int					CommandTypeForKey( idStr &key );
};




class ConfigControl {
public:
					ConfigControl( void );
					~ConfigControl( void );

	static Config*	LoadConfig( int cfgNum );

	static void		FillGUI( idUserInterface* GUI );
	static void		SaveGUIConfig( void );

	static Config*	CurrentConfig;

private:

	static Config*	LoadConfig( const char *file );
};


#endif