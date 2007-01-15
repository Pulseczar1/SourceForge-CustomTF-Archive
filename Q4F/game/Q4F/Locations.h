#ifndef __Q4F_LOCATIONS_H__
#define __Q4F_LOCATIONS_H__

class q4fLocation {
	
public:

						q4fLocation( void );

	void				Create( const idVec3 &pos, const char* name, int team );

	void				UpdateReturnString( void );

	const char*			GetString( void ) { return returnStr.c_str(); };

	const idVec3 &		GetPos( void ) { return pos; }

	const char*			GetName( void ) { return name.c_str(); }
	int					GetTeamNum( void ) { if ( !IS_VALID_TEAM( teamNum ) ) return INVALID_TEAM; return teamNum; };

private:

	int					teamNum;
	idVec3				pos;
	idStr				name;
	idStr				returnStr;
};

class q4fLocationPtr {

public:

						q4fLocationPtr( int _locIndex );

	int					LocIndex;
	q4fLocationPtr*		Next;

	void				AddToEnd( q4fLocationPtr* ptr );

};


class q4fLocationCollection {
public:

						q4fLocationCollection( void );

						~q4fLocationCollection();


	void				Init( const char* mapFileNameStripped );

	void				Shutdown( void );

	q4fLocation*		AddLocation( const idVec3 &pos, const char* name, int teamNum );
	bool				RemoveLocationIndex( int index );
	void				PrintLocationIndices( void );
	void				Save( void );

	q4fLocation*		LocationForPoint( const idVec3 &point );

	void				RefreshLocationStrings( void );

private:

	void					ParseLocationsFromMapFile( idLexer &lex );
	//void					BuildAreaTable( void );
	void					AddLocationPointer( int index, int areaNum );

	float					ReadFloat( idLexer &lex );

	idList<q4fLocation>		locations;

	q4fLocationPtr**		locationAreas;
	int						numAreas;

	idStr					_locationsFile;
		
};


#endif
