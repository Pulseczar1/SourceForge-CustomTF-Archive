/*
===================================================================================

	Only run locally, this guy is a hackish attempt to allow players to have custom
	key press/key release aliases

===================================================================================
*/

#ifndef __Q4F_ALIAS_H__
#define __Q4F_ALIAS_H__

const int BUTTON_1            = BIT(9);
const int BUTTON_2            = BIT(10);
const int BUTTON_3            = BIT(11);
const int BUTTON_4            = BIT(12);
const int BUTTON_5            = BIT(13);
const int BUTTON_6            = BIT(14); 

class Alias {

public:
							Alias( void );

	static void				Setalias_f( const idCmdArgs &args );
	static void				Unbindalias_f( const idCmdArgs &args );
	static void				ArgCompletion_Setalias( const idCmdArgs &args, void(*callback)( const char *s ) );


	static void				Setcvar_f( const idCmdArgs &args );
	static void				ArgCompletion_Setcvar( const idCmdArgs &args, void(*callback)( const char *s ) );

	void					UpdateAliases( short oldButtons, short newButtons );
	void					CreateAlias( const char* key, idStr &pressCmds, idStr &releaseCmds );
	void					RemoveAlias( const char* key );

	bool					GetKeyAlias( const char* key, idStr &press, idStr &release );

	void					AddCVar( idStr &name, idStr &commands );

private:

	typedef struct alias_s {
		bool				inUse;
		int					button;
		idStr				key;
		idStr				pressCommands;
		idStr				releaseCommands;
	} alias_t;

	alias_t					aliases[BUTTON_COUNT];


	idList<idCVar>			aliasCVars;
};

#endif