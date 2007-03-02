#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"

bool q4fServerBrowser::filterInitialized = false;
q4fServerFilter_t q4fServerBrowser::filter;

static q4fSortServer_t SortByArray[3];

q4fServerBrowser::q4fServerBrowser() {
	numServers = 0;
	listIndex = 0;

	modifiedSort = true;

	if ( !filterInitialized ) {
		filter.flags = 0;
		filter.map[0] = '\0';
		filter.maxPing = idMath::INT_MAX;
		filter.maxPlayers = MAX_CLIENTS;
		filter.minPlayers = 0;
		filter.name[0] = '\0';

		ClearSorting();

		filterInitialized = true;
	}
}

q4fServerBrowser::~q4fServerBrowser() {
	numServers = 0;
}

void q4fServerBrowser::AddServerIP( const char* txt ) {
}

void q4fServerBrowser::AddSort( const char* name ) {
	int newSort = SERV_SORT_NONE;

	if ( !idStr::Icmp( name, "name" ) ) {
		newSort = SERV_SORT_NAME;
	}
	else if ( !idStr::Icmp( name, "ping" ) ) {
		newSort = SERV_SORT_PING;
	}
	else if ( !idStr::Icmp( name, "players" ) ) {
		newSort = SERV_SORT_PLAYERS;
	}
	else if ( !idStr::Icmp( name, "map" ) ) {
		newSort = SERV_SORT_MAP;
	}

	q4fSortServer_t newSorts[3];

	if ( newSort != SERV_SORT_NONE ) {
		modifiedSort = true;

		newSorts[0].servSort = newSort;
		newSorts[0].ascending = 0;

		int insertIndex = 1;
		for ( int i = 0; i < 3 && insertIndex < 3; i++ ) {
			if ( SortByArray[i].servSort == newSort ) {
				newSorts[0].ascending = -SortByArray[i].ascending;
			}
			else {
				newSorts[insertIndex] = SortByArray[i];
				insertIndex++;
			}
		}

		if ( newSorts[0].ascending == 0 ) {
			switch ( newSort ) {
	
				case SERV_SORT_NAME:
					newSorts[0].ascending = 1;
					break;			

				case SERV_SORT_PING:
					newSorts[0].ascending = 1;
					break;	

				case SERV_SORT_PLAYERS:
					newSorts[0].ascending = -1;
					break;	

				case SERV_SORT_MAP:
					newSorts[0].ascending = 1;
					break;	
			}
		}
		
		for ( int i = 0; i < 3; i++ ) {
			SortByArray[i] = newSorts[i];
		}		
	}
}

void q4fServerBrowser::ClearSorting() {
    SortByArray[0].servSort = SERV_SORT_NONE;
	SortByArray[0].ascending = 0;
	SortByArray[1].servSort = SERV_SORT_NONE;
	SortByArray[1].ascending = 0;
	SortByArray[2].servSort = SERV_SORT_NONE;
	SortByArray[2].ascending = 0;
}

void q4fServerBrowser::UpdateServerList( idUserInterface* gui ) {
	bool modifiedList = RetrieveServerInfo( gui );
	bool filtersChanged = UpdateFilters( gui );

	if ( modifiedList || filtersChanged || modifiedSort ) {
		UpdateFilterList();
		SortFilterList();
		FillServerList( gui );
	}

	modifiedSort = false;
}

bool q4fServerBrowser::RetrieveServerInfo( idUserInterface* gui ) {

	const char* serverStr;

	bool modifiedList = false;
	while( listIndex < MAX_SERVERS ) {
		serverStr = gui->GetStateString( va( "serverlist_item_%d", listIndex ), "" );
		if ( serverStr && serverStr[0] ) {
			if ( ParseServerString( serverStr, listIndex ) ) {
				modifiedList = true;
			}
			listIndex++;
		}
		else {
			break;
		}
	}

	return modifiedList;
}

#define strListCpy( indedx ) \
	strPos = vals[indedx].c_str();			\
	while( strPos[0] != '\0' ) {		\
		*listStrPos = strPos[0];		\
		listStrPos++;					\
		strPos++;						\
	}									\
	*listStrPos = '\t';					\
	listStrPos++

bool q4fServerBrowser::ParseServerString( const char* serverStr, int listIndex ) {

	if ( !serverStr || !serverStr[0] )
		return false;

	idList<idStr> vals;

	idCmdArgs args;

	idStr::Split( serverStr, vals, '\t', 1 );	

	// 0 = fav
	// 1 = password
	// 2 = dedicated
	// 3 = punkbuster
	// 4 = name
	// 5 = ping
	// 6 = players
	// 7 = gametype
	// 8 = map
	// XavioR: Ok the above is moot because of QTV. "gametype" is now 8 instead of 7 (see below)

	// first check if its our mod

	if ( idStr::Icmp( vals[8], "Q4F" ) ) {
		return false;
	}

	bool isFav = false;
	bool isLocked = false;
	bool isDed = false;
	bool isPB = false;

	idStr	serverNameStripped;
	idStr	pingStr;
	int		ping = 0;
	int		players = 0;
	int		maxPlayers = 0;

	char	listStr[512];
	char*	listStrPos = listStr;
	const char*	strPos = NULL;

	// favorite
	if ( idStr::Icmp( vals[0], "^ifvd" ) ) {
		isFav = true;
	}
	strListCpy(0);

	// password
	if ( idStr::Icmp(  vals[1], "^ipdd" ) ) {
		isLocked = true;
	}
	strListCpy(1);

	// dedicated
	if ( !idStr::Icmp( vals[2], "^idse" ) ) {
		isDed = true;
	}
	strListCpy(2);

	//punkbuster
	if ( !idStr::Icmp( vals[3], "^ipbe" ) ) {
		isPB = true;
	}
	strListCpy(3);

	// name
	serverNameStripped = vals[4];
	serverNameStripped.RemoveEscapes();
	serverNameStripped.StripLeading( ' ' );
	strListCpy(4);

	//ping
	pingStr = vals[5];
	pingStr.RemoveEscapes();
	ping = atoi( pingStr.c_str() );
	strListCpy(5);

	//players
	bool doingMax = false;
	int index = 0;
	while( vals[6][index] ) {
		if ( doingMax ) {
			maxPlayers *= 10;
			maxPlayers += ( vals[6][index] - '0' );
		}
		else {
			if ( vals[6][index] == '/' ) {
				doingMax = true;
			}
			else {
				players *= 10;
				players += ( vals[6][index] - '0' );
			}
		}
		index++;
	}
	strListCpy(6);

	// add map to listStr
	strListCpy(8);
	strPos++;
	*listStrPos = '\0';

	AddServer( listIndex, listStr, serverNameStripped.c_str(), vals[8].c_str(), ping, players, maxPlayers, isFav, isLocked, isPB, isDed );	
	return true;
}

void q4fServerBrowser::AddServer( int listIndex, const char* listStr, const char* name, const char* mapname, int ping, int players, int maxPlayers, bool isFav, bool isLocked, bool isPb, bool isDed ) {
	if ( numServers >= MAX_SERVERS )
		return;

	idStr::Copynz( serverList[numServers].listStr, listStr, 256 );
	idStr::Copynz( serverList[numServers].name, name, 128 );
	idStr::Copynz( serverList[numServers].map, mapname, 64 );

	serverList[numServers].ping = ping;
	serverList[numServers].players = players;
	serverList[numServers].maxPlayers = maxPlayers;
	serverList[numServers].flags = 0;
	
	if ( isFav ) {
		serverList[numServers].flags |= SERV_FLAG_FAV;
	}

	if ( isLocked ) {
		serverList[numServers].flags |= SERV_FLAG_LOCKED;
	}

	if ( isPb ) {
		serverList[numServers].flags |= SERV_FLAG_PB;
	}

	if ( isDed ) {
		serverList[numServers].flags |= SERV_FLAG_DED;
	}

	serverList[numServers].index = listIndex;

	numServers++;
}

bool q4fServerBrowser::UpdateFilters( idUserInterface* gui ) {

	q4fServerFilter_t newFilter;
	idStr tmp;

	tmp = gui->GetStateString( "filter_minplayers", "0" );
	tmp.Strip( ' ' );

	if ( tmp && tmp[0] && tmp.IsNumeric() ) {
		newFilter.minPlayers = idMath::ClampInt( 0, MAX_CLIENTS, atoi( tmp.c_str() ) );
	}
	else {
		newFilter.minPlayers = 0;
	}

	tmp = gui->GetStateString( "filter_maxplayers", "32" );
	tmp.Strip( ' ' );
	if ( tmp && tmp[0] && tmp.IsNumeric() ) {
		newFilter.maxPlayers  = idMath::ClampInt( newFilter.minPlayers, MAX_CLIENTS, atoi( tmp.c_str() ) );
	}
	else {
		newFilter.maxPlayers = MAX_CLIENTS;
	}

	newFilter.minPlayers = idMath::ClampInt( 0, newFilter.maxPlayers, newFilter.minPlayers );

	tmp = gui->GetStateString( "filter_maxping" );
	tmp.Strip( ' ' );
	if ( tmp && tmp[0] && tmp.IsNumeric() ) {
		newFilter.maxPing = idMath::ClampInt( 0, idMath::INT_MAX, atoi( tmp.c_str() ) );
	}
	else {
		newFilter.maxPing = idMath::INT_MAX;
	}

	tmp = gui->GetStateString( "filter_map" );
	tmp.Strip( ' ' );
	idStr::Copynz( newFilter.map, tmp.c_str(), 64 );
	
	tmp = gui->GetStateString( "filter_server" );
	tmp.Strip( ' ' );
	idStr::Copynz( newFilter.name, tmp.c_str(), 128 );

	newFilter.flags = 0;

	if ( gui->GetStateInt( "filter_fav", "0" ) != 0 ) {
		newFilter.flags |= SERV_FLAG_FAV;
	}

	if ( gui->GetStateInt( "filter_locked", "0" ) != 0 ) {
		newFilter.flags |= SERV_FLAG_LOCKED;
	}

	if ( gui->GetStateInt( "filter_pb", "0" ) != 0 ) {
		newFilter.flags |= SERV_FLAG_PB;
	}

	if ( gui->GetStateInt( "filter_ded", "1" ) != 0 ) {
		newFilter.flags |= SERV_FLAG_DED;
	}

	if ( gui->GetStateInt( "filter_nofull", "0" ) != 0 ) {
		newFilter.flags |= SERV_FLAG_NOFULL;
	}

	if ( gui->GetStateInt( "filter_noempty", "0" ) != 0 ) {
		newFilter.flags |= SERV_FLAG_NOEMPTY;
	}

	// make sure the gui agrees with us
	/*gui->SetStateString( "filter_minplayers", va( "%d", newFilter.minPlayers ) );
	gui->SetStateString( "filter_maxplayers", va( "%d", newFilter.maxPlayers ) );
	gui->SetStateString( "filter_maxping", va( "%d", newFilter.maxPing ) );
	gui->SetStateString( "filter_map", newFilter.map );
	gui->SetStateString( "filter_server", newFilter.name );*/
	
	gui->SetStateBool( "filter_fav", newFilter.flags & SERV_FLAG_FAV );
	gui->SetStateBool( "filter_locked", newFilter.flags & SERV_FLAG_LOCKED );
	gui->SetStateBool( "filter_pb", newFilter.flags & SERV_FLAG_PB );
	gui->SetStateBool( "filter_ded", newFilter.flags & SERV_FLAG_DED );
	gui->SetStateBool( "filter_nofull", newFilter.flags & SERV_FLAG_NOFULL );
	gui->SetStateBool( "filter_noempty", newFilter.flags & SERV_FLAG_NOEMPTY );

	bool changed = false;

	// check if we've been changed since last time
	if (	filter.minPlayers != newFilter.minPlayers ||
			filter.maxPlayers != newFilter.maxPlayers ||
			filter.maxPing != newFilter.maxPing ||
			filter.flags != newFilter.flags ||
			idStr::Icmp( filter.map, newFilter.map ) ||
			idStr::Icmp( filter.name, newFilter.name ) ) {
		
		changed = true;
	}

	filter = newFilter;
	return changed;
}

void q4fServerBrowser::UpdateFilterList() {
	numFilteredServers = 0;
	int i = 0;

	for ( i = 0; i < numServers; i++ ) {
		if ( ServerPassesFilter( serverList[i] ) ) {
			filteredList[numFilteredServers] = i;
			numFilteredServers++;
		}
	}
}

bool q4fServerBrowser::ServerPassesFilter( q4fServerInfo_t &server ) {
	if ( server.players > filter.maxPlayers || server.players < filter.minPlayers )
		return false;

	if ( server.ping > filter.maxPing )
		return false;

	if ( ( filter.flags & SERV_FLAG_NOEMPTY ) && server.players <= 0 )
		return false;

	if ( ( filter.flags & SERV_FLAG_NOFULL ) && server.players >= server.maxPlayers )
		return false;

	if ( ( filter.flags & SERV_FLAG_DED ) && !( server.flags & SERV_FLAG_DED ) )
		return false;

	if ( ( filter.flags & SERV_FLAG_FAV ) && !( server.flags & SERV_FLAG_FAV ) )
		return false;

	if ( ( filter.flags & SERV_FLAG_LOCKED ) && ( server.flags & SERV_FLAG_LOCKED ) )
		return false;

	if ( ( filter.flags & SERV_FLAG_PB ) && !( server.flags & SERV_FLAG_PB ) )
		return false;

	if ( filter.map[0] && ( idStr::FindText( server.map, filter.map, false ) < 0 ) )
		return false;

	if ( filter.name[0] && ( idStr::FindText( server.name, filter.name, false ) < 0 ) )
		return false;

	return true;	
}

void q4fServerBrowser::FillServerList( idUserInterface* gui ) {
	int i = 0;

	for ( i = 0; i < numFilteredServers; i++ ) {
		gui->SetStateInt( va( "serverlist2_item_%d_id", i ), serverList[ filteredList[i] ].index );
		gui->SetStateString( va( "serverlist2_item_%d", i ), serverList[ filteredList[i] ].listStr );
	}

	for ( i; i < MAX_SERVERS; i++ ) {
		gui->DeleteStateVar( va( "serverlist2_item_%d_id", i ) );
		gui->DeleteStateVar( va( "serverlist2_item_%d", i ) );
	}

	gui->StateChanged ( gameLocal.time );
	gui->Redraw( gameLocal.time );
}

//--------------------------------------------------------------------------
// Sorting
//--------------------------------------------------------------------------

static int SortCompare( q4fServerInfo_t* server1, q4fServerInfo_t* server2, int criteria ) {
	switch( criteria ) {
		case SERV_SORT_NONE:
			return 0;

		case SERV_SORT_NAME:
			return idStr::Icmp( server1->name, server2->name );			

		case SERV_SORT_PING:
			return ( server1->ping - server2->ping );

		case SERV_SORT_PLAYERS:
			return ( server1->players - server2->players );

		case SERV_SORT_MAP:
			return idStr::Icmp( server1->map, server2->map );	
	}

	return 0;
}

static int SortServer( const void* left, const void* right ) {

	int* leftIndex = (int*)left;
	int* rightIndex = (int*)right;
	
	q4fServerInfo_t* server1 = gameLocal.serverBrowser->GetServerInfo( *leftIndex );
	q4fServerInfo_t* server2 = gameLocal.serverBrowser->GetServerInfo( *rightIndex );

	assert( server1 && server2 );

	int cmp;

	bool asc;

	for ( int i = 0; i < 3; i++ ) {
		if ( SortByArray[i].servSort == SERV_SORT_NONE )
			break;

		cmp = SortCompare( server1, server2, SortByArray[i].servSort );
		if ( cmp == 0 )
			continue;

		asc = SortByArray[i].ascending == 1;

		if ( ( cmp > 0 && asc ) || ( cmp < 0 && !asc ) )
			return 1;
		
		return -1;
	}

	return -1;
}

void q4fServerBrowser::SortFilterList() {
	qsort( (void*)filteredList, numFilteredServers, sizeof( filteredList[0] ), SortServer );
}

