#ifndef __Q4F_BROWSER_H__
#define __Q4F_BROWSER_H__

enum {
	SERV_FLAG_FAV		= BIT( 0 ),
	SERV_FLAG_LOCKED	= BIT( 1 ),
	SERV_FLAG_PB		= BIT( 2 ),
	SERV_FLAG_DED		= BIT( 3 ),
	SERV_FLAG_NOFULL	= BIT( 4 ),
	SERV_FLAG_NOEMPTY	= BIT( 5 )
};

enum  {
	SERV_SORT_NONE = 0,
    SERV_SORT_NAME = 1,
	SERV_SORT_PING = 2,
	SERV_SORT_PLAYERS = 3,
	SERV_SORT_MAP = 4
};

typedef struct q4fSortServer_s {
	int			servSort;
	int			ascending;			// -1 = descending, 0 = undecided, 1 = ascending
} q4fSortServer_t;

typedef struct q4fServerFilter_s {

	int			minPlayers;
	int			maxPlayers;
	char		name[ 128 ];
	char		map[ 64 ];
	int			maxPing;

	byte		flags;

} q4fServerFilter_t;

typedef struct q4fServerInfo_s {
	char			listStr[ 256 ];
	char			name[ 128 ];
	char			map[ 64 ];
	short			ping;
	byte			players;
	byte			maxPlayers;

	byte			flags;

	int				index;
} q4fServerInfo_t;

#define MAX_SERVERS 1000

class q4fServerBrowser {

public:
					q4fServerBrowser( void );
					~q4fServerBrowser( void );


	void			UpdateServerList( idUserInterface* gui );
	void			ClearServerList( void );

	void			ClearSorting( void );
	void			AddSort( const char* name );
	void			AddServerIP( const char* txt );

	q4fServerInfo_t*	GetServerInfo( int index );

	static q4fServerFilter_t	filter;


private:

	static bool		filterInitialized;

	bool			RetrieveServerInfo( idUserInterface* gui );
	bool			ParseServerString( const char* serverStr, int listIndex );
	void			AddServer( int listIndex, const char* listStr, const char* name, const char* mapname, int ping, int players, int maxPlayers, bool isFav, bool isLocked, bool isPb, bool isDed );
	void			FillServerList( idUserInterface* gui );
	bool			UpdateFilters( idUserInterface* gui );
	void			UpdateFilterList( void );
	void			SortFilterList( void );
	bool			ServerPassesFilter( q4fServerInfo_t &server );

	q4fServerInfo_t	serverList[MAX_SERVERS];
	int				numServers;

	int				filteredList[MAX_SERVERS];
	int				numFilteredServers;

	bool			modifiedSort;

	int				listIndex;

};

ID_INLINE q4fServerInfo_t* q4fServerBrowser::GetServerInfo( int index ) {
	if ( index < 0 || index >= numServers )
		return NULL;

	return &(serverList[index]);
}

#endif