#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"

//========================================================
// q4fLocation
//========================================================
q4fLocation::q4fLocation() {
	name = "unknown";
	teamNum = INVALID_TEAM;
	pos = vec3_zero;
	returnStr = "unknown";
}

void q4fLocation::Create( const idVec3 &_pos, const char* _name, int team ) {
	pos = _pos;
	name = _name;
	teamNum = team;

	UpdateReturnString();
}

void q4fLocation::UpdateReturnString() {
	TFTeam* team = tfGame.GetTeam( teamNum );

	if ( team ) {
		returnStr = va( "%s%s^7 %s", tfGame.GetTeamEscapeColor( teamNum ), team->GetName(), name.c_str() );
	}
	else {
		returnStr = name.c_str();
	}
}




//========================================================
// q4fLocationPtr
//========================================================
q4fLocationPtr::q4fLocationPtr( int _locIndex ) {
	LocIndex = _locIndex;
	Next = NULL;
}

void q4fLocationPtr::AddToEnd( q4fLocationPtr* ptr ) {
	assert( ptr );

	while( ptr->Next ) {
		ptr = ptr->Next;
	}

	assert( ptr && !ptr->Next );

	ptr->Next = this;
}




//========================================================
// q4fLocationCollection
//========================================================
q4fLocationCollection::q4fLocationCollection() {
	locationAreas = NULL;
	numAreas = 0;
	_locationsFile.Clear();
}

q4fLocationCollection::~q4fLocationCollection() {
	Shutdown();
}

void q4fLocationCollection::Shutdown() {

	for ( int i = 0; i < numAreas; i++ ) {
		q4fLocationPtr* ptr = locationAreas[i];

		while ( ptr ) {
			q4fLocationPtr* next = ptr->Next;

			delete ptr;

			ptr = next;
		}
	}
	locationAreas = NULL;
	numAreas = 0;

	locations.Clear();

	_locationsFile.Clear();
}

void q4fLocationCollection::Init( const char* mapFileNameStripped ) {

	Shutdown();

	if ( !mapFileNameStripped || !mapFileNameStripped[0] )
		common->Error( "q4fLocationCollection - mapFileNameStripped is null or empty." );

	if( !gameRenderWorld )
		common->Error( "GameRenderWorld is NULL!" );


	// allocate the area table
	numAreas = gameRenderWorld->NumAreas();
	locationAreas = new q4fLocationPtr*[ numAreas ];
	memset( locationAreas, 0, numAreas * sizeof( q4fLocationPtr* ) );

	_locationsFile = va( "config/locations/%s_locations.cfg", mapFileNameStripped );

	idLexer lex( LEXFL_NOSTRINGCONCAT );

	if ( lex.LoadFile( _locationsFile.c_str() ) ) {
		ParseLocationsFromMapFile( lex );
	}
	else {
		gameLocal.Warning( "Could not find map location file '%s'\n", _locationsFile.c_str() );
	}
	lex.FreeSource();
}

// format is: ( x y z ) "name" "team"
void q4fLocationCollection::ParseLocationsFromMapFile( idLexer &lex ) {

	idStr locName;
	int teamNum;
	idVec3 pos;
	
	idToken tok;

	gameLocal.Printf( "-------- Parsing Location Points --------\n" );

	while ( lex.ReadToken( &tok ) ) {

		if ( tok.Icmp( "(" )  ) {
			lex.Error( "Expeced \"(...\"" );
			break;
		}
		
		pos.x = ReadFloat( lex );
		pos.y = ReadFloat( lex );
		pos.z = ReadFloat( lex );

		if ( !lex.ReadToken( &tok ) || tok.Icmp( ")" ) ) {
			lex.Error( "Expeced \"( # # # )...\"" );
			break;
		}

		if ( !lex.ReadToken( &tok ) || tok.type != TT_STRING ) {
			lex.Error( "Expeced \"( # # # ) \"location name\"... \"" );
			break;
		}
		else {
			locName = tok.c_str();
		}

		if ( !lex.ReadToken( &tok ) || tok.type != TT_STRING ) {
			lex.Error( "Expeced \"( # # # ) \"location name\" \"location team\" \"" );
			break;
		}

		// all info should be valid now...
		teamNum = tfGame.GetTeamNumFromString( tok.c_str() );

		// we write team nums + 1 for user benefits
		//teamNum--;

		AddLocation( pos, locName.c_str(), teamNum );
	}

	gameLocal.Printf( "-------- ----------------------- --------\n" );
}

float q4fLocationCollection::ReadFloat( idLexer &lex ) {

	idToken tok;

	if ( !lex.ReadToken( &tok ) ) {
		lex.Error( "Expected a numeric value" );
		return 0.0f;
	}

	float num = 0.0f;

	if ( tok[0] == '-' ) {
		if ( !lex.ReadToken( &tok ) || !( tok.type & TT_NUMBER ) ) {
			lex.Error( "Expected a numeric value" );
			return 0.0f;
		}

		num = atof( tok.c_str() );
		return -1.0f * num;
	}
	else {
		return atof( tok.c_str() );
	}
}

q4fLocation* q4fLocationCollection::AddLocation( const idVec3 &pos, const char* name, int teamNum ) {
	q4fLocation* loc = &( locations.Alloc() );
	loc->Create( pos, name, teamNum );

	int areaNum = gameRenderWorld->PointInArea( pos );

	if ( areaNum < 0 ) {
		gameLocal.Warning( "q4fLocationCollection::AddLocation: location '%s' is not in a valid area\n", loc->GetString() );
		return NULL;
	}

	if ( areaNum >= numAreas ) {
		gameLocal.Error( "q4fLocationCollection::AddLocation: areaNum >= gameRenderWorld->NumAreas()" );
	}

	int index = locations.Num() - 1;
	AddLocationPointer( index, areaNum );

	// spread to all other connected areas
	int numPortals = gameRenderWorld->NumPortalsInArea( areaNum );
	for ( int i = 0; i < numPortals; i++ ) {
		exitPortal_t portal = gameRenderWorld->GetPortal( areaNum, i );
		AddLocationPointer( index, portal.areas[0] );
		AddLocationPointer( index, portal.areas[1] );
	}

	/*for ( int a = 0 ; a < numAreas ; a++ ) {
		if ( a == areaNum ) {
			continue;
		}
		if ( gameRenderWorld->AreasAreConnected( areaNum, a, PS_BLOCK_LOCATION ) ) {
			bool bob = true;
		}
	}*/

	return loc;
}

void q4fLocationCollection::AddLocationPointer( int index, int areaNum ) {
	assert( locationAreas );

	if ( index < 0 || index >= locations.Num() ) {
		gameLocal.Warning( "q4fLocationCollection::AddLocationPointer: inde '%d' is out of range", index );
		return;
	}

	// check if the location already exists in this area
	q4fLocationPtr* newPtr = locationAreas[areaNum];
	while ( newPtr ) {
		if ( newPtr->LocIndex == index )
			return;
		newPtr = newPtr->Next;
	}

	newPtr = new q4fLocationPtr( index );

	if ( locationAreas[areaNum] ) {
		// location already exists for this area, group em
		newPtr->AddToEnd( locationAreas[areaNum] );
	}
	else {
		locationAreas[areaNum] = newPtr;
	}
}

void q4fLocationCollection::Save() {
	idFile* file = fileSystem->OpenFileWrite( _locationsFile.c_str(), "q4f", false );

	if ( !file ) {
		gameLocal.Warning( "q4fLocationCollection::Save: could not create file '%s'\n", _locationsFile.c_str() );
		return;
	}

	idStr str;
	int teamNum;

	for ( int i = 0; i < locations.Num(); i++ ) {

		const idVec3& pos = locations[i].GetPos();

		teamNum =  locations[i].GetTeamNum();

		if ( !IS_VALID_TEAM( teamNum ) )
			teamNum = -1;
		else
			teamNum++;

		str = va( "( %f %f %f ) \"%s\" \"%d\"\r\n", pos.x, pos.y, pos.z, locations[i].GetName(), teamNum );

		file->Write( str.c_str(), str.Length() );
	}

	fileSystem->CloseFile( file );
}

q4fLocation* q4fLocationCollection::LocationForPoint( const idVec3 &point ) {

	int area = gameRenderWorld->PointInArea( point );
	if ( area < 0 ) {
		return NULL;
	}
	if ( area >= numAreas ) {
		gameLocal.Error( "q4fLocationCollection::LocationForPoint: area >= gameRenderWorld->NumAreas()" );
	}

	q4fLocationPtr* ptr = locationAreas[ area ];

	q4fLocation* minLoc = NULL;
	q4fLocation* tmpLoc;

	float minDist = -1.0f;

	idVec3 diff;

	while( ptr ) {
		assert( ptr->LocIndex >= 0 && ptr->LocIndex < locations.Num() );

		tmpLoc = &( locations[ptr->LocIndex] ); assert( tmpLoc );

		diff = tmpLoc->GetPos() - point;

		float dist = diff.LengthSqr();

		if ( minLoc == NULL || dist < minDist ) {
			minLoc = tmpLoc;
			minDist = dist;
		}

		ptr = ptr->Next;
	}

	return minLoc;
}

bool q4fLocationCollection::RemoveLocationIndex( int index ) {
	if ( index < 0 || index > locations.Num() )
		return false;

	for ( int i = 0; i < numAreas; i++ ) {
		q4fLocationPtr* ptr = locationAreas[ i ];
		q4fLocationPtr* prev = NULL;

		while ( ptr ) {
			if ( ptr->LocIndex == index ) {
				if ( prev ) {
					prev->Next = ptr->Next;

					delete ptr;

					ptr = prev->Next;
				}
				else {
					locationAreas[ i ] = ptr->Next;

					delete ptr;

					prev = NULL;
					ptr = locationAreas[ i ];
				}
			}
			else {
				prev = ptr;
				ptr = ptr->Next;
			}
		}
	}

	locations.RemoveIndex( index );

	return true;
}

void q4fLocationCollection::PrintLocationIndices() {
	for ( int i = 0; i < locations.Num(); i++ ) {
		gameLocal.Printf( "[%d] %s\n", i, locations[i].GetString() );
	}
}

void q4fLocationCollection::RefreshLocationStrings() {
	for ( int i = 0; i < locations.Num(); i++ ) {
		locations[i].UpdateReturnString();
	}
}




