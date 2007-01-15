/*

Base class for all C++ objects.  Provides fast run-time type checking and run-time
instancing of objects.

*/

#include "../../idlib/precompiled.h"
#pragma hdrstop

#include "../Game_local.h"

#ifdef _WIN32
#include "TypeInfo.h"
#else
#include "NoGameTypeInfo.h"
#endif

/***********************************************************************

  idTypeInfo

***********************************************************************/

// this is the head of a singly linked list of all the idTypes
static idTypeInfo				*typelist = NULL;
static idHierarchy<idTypeInfo>	classHierarchy;
static int						eventCallbackMemory	= 0;

/*
================
idTypeInfo::idClassType()

Constructor for class.  Should only be called from CLASS_DECLARATION macro.
Handles linking class definition into class hierarchy.  This should only happen
at startup as idTypeInfos are statically defined.  Since static variables can be
initialized in any order, the constructor must handle the case that subclasses
are initialized before superclasses.
================
*/
idTypeInfo::idTypeInfo( const char *classname, const char *superclass, idEventFunc<idClass> *eventCallbacks, idClass *( *CreateInstance )( void ), 

// bdube: added states
	void ( idClass::*Spawn )( void ), 
	rvStateFunc<idClass>* stateCallbacks,
	void ( idClass::*Save )( idSaveGame *savefile ) const, void ( idClass::*Restore )( idRestoreGame *savefile ) ) {									


	idTypeInfo *type;
	idTypeInfo **insert;

	this->classname			= classname;
	this->superclass		= superclass;
	this->eventCallbacks	= eventCallbacks;
	this->eventMap			= NULL;
	this->Spawn				= Spawn;
	this->Save				= Save;
	this->Restore			= Restore;
	this->CreateInstance	= CreateInstance;
	this->super				= idClass::GetClass( superclass );
	this->freeEventMap		= false;
	typeNum					= 0;
	lastChild				= 0;


// bdube: added states
	this->stateCallbacks = stateCallbacks;


	// Check if any subclasses were initialized before their superclass
	for( type = typelist; type != NULL; type = type->next ) {
		if ( ( type->super == NULL ) && !idStr::Cmp( type->superclass, this->classname ) && 
			idStr::Cmp( type->classname, "idClass" ) ) {
			type->super	= this;
		}
	}

	// Insert sorted
	for ( insert = &typelist; *insert; insert = &(*insert)->next ) {
		assert( idStr::Cmp( classname, (*insert)->classname ) );
		if ( idStr::Cmp( classname, (*insert)->classname ) < 0 ) {
			next = *insert;
			*insert = this;
			break;
		}
	}
	if ( !*insert ) {
		*insert = this;
		next = NULL;
	}
}

/*
================
idTypeInfo::~idTypeInfo
================
*/
idTypeInfo::~idTypeInfo() {
	Shutdown();
}

/*
================
idTypeInfo::Init

Initializes the event callback table for the class.  Creates a 
table for fast lookups of event functions.  Should only be called once.
================
*/
void idTypeInfo::Init( void ) {
	idTypeInfo				*c;
	idEventFunc<idClass>	*def;
	int						ev;
	int						i;
	bool					*set;
	int						num;

	if ( eventMap ) {
		// we've already been initialized by a subclass
		return;
	}

	// make sure our superclass is initialized first
	if ( super && !super->eventMap ) {
		super->Init();
	}

	// add to our node hierarchy
	if ( super ) {
		node.ParentTo( super->node );
	} else {
		node.ParentTo( classHierarchy );
	}
	node.SetOwner( this );

	// keep track of the number of children below each class
	for( c = super; c != NULL; c = c->super ) {
		c->lastChild++;
	}

	// if we're not adding any new event callbacks, we can just use our superclass's table
	if ( ( !eventCallbacks || !eventCallbacks->event ) && super ) {
		eventMap = super->eventMap;
		return;
	}

	// set a flag so we know to delete the eventMap table
	freeEventMap = true;

	// Allocate our new table.  It has to have as many entries as there
	// are events.  NOTE: could save some space by keeping track of the maximum
	// event that the class responds to and doing range checking.
	num = idEventDef::NumEventCommands();
	eventMap = new eventCallback_t[ num ];
	memset( eventMap, 0, sizeof( eventCallback_t ) * num );
	eventCallbackMemory += sizeof( eventCallback_t ) * num;

	// allocate temporary memory for flags so that the subclass's event callbacks
	// override the superclass's event callback
	set = new bool[ num ];
	memset( set, 0, sizeof( bool ) * num );

	// go through the inheritence order and copies the event callback function into
	// a list indexed by the event number.  This allows fast lookups of
	// event functions.
	for( c = this; c != NULL; c = c->super ) {
		def = c->eventCallbacks;
		if ( !def ) {
			continue;
		}

		// go through each entry until we hit the NULL terminator
		for( i = 0; def[ i ].event != NULL; i++ )	{
			ev = def[ i ].event->GetEventNum();

			if ( set[ ev ] ) {
				continue;
			}
			set[ ev ] = true;
			eventMap[ ev ] = def[ i ].function;
		}
	}

	delete[] set;
}

/*
================
idTypeInfo::Shutdown

Should only be called when DLL or EXE is being shutdown.
Although it cleans up any allocated memory, it doesn't bother to remove itself 
from the class list since the program is shutting down.
================
*/
void idTypeInfo::Shutdown() {
	// free up the memory used for event lookups
	if ( eventMap ) {
		if ( freeEventMap ) {
			delete[] eventMap;
		}
		eventMap = NULL;
	}
	typeNum = 0;
	lastChild = 0;
}


/***********************************************************************

  idClass

***********************************************************************/

const idEventDef EV_PostRestore( "<postRestore>", NULL );
const idEventDef EV_Remove( "<immediateremove>", NULL );
const idEventDef EV_SafeRemove( "remove", NULL );							// 3j_script: check for multiplayer, dont remove map entities?

ABSTRACT_DECLARATION( NULL, idClass )

	EVENT( EV_PostRestore,			idClass::Event_PostRestore )

	EVENT( EV_Remove,				idClass::Event_Remove )
	EVENT( EV_SafeRemove,			idClass::Event_SafeRemove )
END_CLASS

CLASS_STATES_DECLARATION(idClass)
END_CLASS_STATES

// alphabetical order
idList<idTypeInfo *>	idClass::types;
// typenum order
idList<idTypeInfo *>	idClass::typenums;

bool	idClass::initialized	= false;
int		idClass::typeNumBits	= 0;
int		idClass::memused		= 0;
int		idClass::numobjects		= 0;

/*
================
idClass::CallSpawn
================
*/
void idClass::CallSpawn( void ) {
	idTypeInfo *type;

	type = GetType();
	CallSpawnFunc( type );
}

/*
================
idClass::CallSpawnFunc
================
*/
classSpawnFunc_t idClass::CallSpawnFunc( idTypeInfo *cls ) {
	classSpawnFunc_t func;

	if ( cls->super ) {
		func = CallSpawnFunc( cls->super );
		if ( func == cls->Spawn ) {
			// don't call the same function twice in a row.
			// this can happen when subclasses don't have their own spawn function.
			return func;
		}
	}

	
	// hmmm.... stompage of memory has occured
	assert(cls->Spawn != 0);
	

	( this->*cls->Spawn )();

	return cls->Spawn;
}

/*
================
idClass::FindUninitializedMemory
================
*/
void idClass::FindUninitializedMemory( void ) {
#ifdef ID_DEBUG_MEMORY
	unsigned long *ptr = ( ( unsigned long * )this ) - 1;
	int size = *ptr;
	assert( ( size & 3 ) == 0 );
	size >>= 2;
	for ( int i = 0; i < size; i++ ) {
		if ( ptr[i] == 0xcdcdcdcd ) {

			gameLocal.Warning( "type '%s' has uninitialized variable (offset %d)", GetClassname(), i << 2 );

		}
	}
#endif
}

/*
================
idClass::Spawn
================
*/
void idClass::Spawn( void ) {
}

/*
================
idClass::~idClass

Destructor for object.  Cancels any events that depend on this object.
================
*/
idClass::~idClass() {
	idEvent::CancelEvents( this );
}

/*
================
idClass::DisplayInfo_f
================
*/
void idClass::DisplayInfo_f( const idCmdArgs &args ) {
	gameLocal.Printf( "Class memory status: %i bytes allocated in %i objects\n", memused, numobjects );
}

/*
================
idClass::ListClasses_f
================
*/
void idClass::ListClasses_f( const idCmdArgs &args ) {
	int			i;
	idTypeInfo *type;

	gameLocal.Printf( "%-24s %-24s %-6s %-6s\n", "Classname", "Superclass", "Type", "Subclasses" );
	gameLocal.Printf( "----------------------------------------------------------------------\n" );

	for( i = 0; i < types.Num(); i++ ) {
		type = types[ i ];
		gameLocal.Printf( "%-24s %-24s %6d %6d\n", type->classname, type->superclass, type->typeNum, type->lastChild - type->typeNum );
	}

	gameLocal.Printf( "...%d classes", types.Num() );
}

/*
================
idClass::CreateInstance
================
*/
idClass *idClass::CreateInstance( const char *name ) {
	const idTypeInfo	*type;
	idClass				*obj;

	type = idClass::GetClass( name );
	if ( !type ) {
		return NULL;
	}

	obj = type->CreateInstance();
	return obj;
}

/*
================
idClass::Init

Should be called after all idTypeInfos are initialized, so must be called
manually upon game code initialization.  Tells all the idTypeInfos to initialize
their event callback table for the associated class.  This should only be called
once during the execution of the program or DLL.
================
*/
void idClass::Init( void ) {
	idTypeInfo	*c;
	int			num;

// jnewquist: Tag scope and callees to track allocations using "new".
	MEM_SCOPED_TAG(tag,MA_CLASS);


	gameLocal.Printf( "Initializing class hierarchy\n" );

	if ( initialized ) {
		gameLocal.Printf( "...already initialized\n" );
		return;
	}

	// init the event callback tables for all the classes
	for( c = typelist; c != NULL; c = c->next ) {

// jnewquist: Make sure the superclass was actually registered!
		if ( c->super == NULL && (c->superclass && idStr::Cmp(c->superclass, "NULL")) ) {
			common->Error("Superclass %s of %s was never registered!", c->superclass, c->classname);
		}		

		c->Init();
	}

	// number the types according to the class hierarchy so we can quickly determine if a class
	// is a subclass of another
	num = 0;
	for( c = classHierarchy.GetNext(); c != NULL; c = c->node.GetNext(), num++ ) {
        c->typeNum = num;
		c->lastChild += num;
	}

	// number of bits needed to send types over network
	typeNumBits = idMath::BitsForInteger( num );

	// create a list of the types so we can do quick lookups
	// one list in alphabetical order, one in typenum order
	types.SetGranularity( 1 );
	types.SetNum( num );
	typenums.SetGranularity( 1 );
	typenums.SetNum( num );
	num = 0;
	for( c = typelist; c != NULL; c = c->next, num++ ) {
		types[ num ] = c;
		typenums[ c->typeNum ] = c;
	}

	initialized = true;

	gameLocal.Printf( "...%i classes, %i bytes for event callbacks\n", types.Num(), eventCallbackMemory );
}

/*
================
idClass::Shutdown
================
*/
void idClass::Shutdown( void ) {
	idTypeInfo	*c;

	for( c = typelist; c != NULL; c = c->next ) {
		c->Shutdown();
	}
	types.Clear();
	typenums.Clear();

	initialized = false;
}

/*
================
idClass::new
================
*/
#ifdef ID_DEBUG_MEMORY
#undef new
#endif

void * idClass::operator new( size_t s ) {
	int *p;

	s += sizeof( int );

//amccarthy: Added memory allocation tag
	p = (int *)Mem_Alloc( s, MA_CLASS );

	*p = s;
	memused += s;
	numobjects++;

#ifdef ID_DEBUG_MEMORY
	unsigned long *ptr = (unsigned long *)p;
	int size = s;
	assert( ( size & 3 ) == 0 );
	size >>= 3;
	for ( int i = 1; i < size; i++ ) {
		ptr[i] = 0xcdcdcdcd;
	}
#endif

	return p + 1;
}

void * idClass::operator new( size_t s, int, int, char *, int ) {
	int *p;

	s += sizeof( int );

//amccarthy: Added memory allocation tag
	p = (int *)Mem_Alloc( s, MA_CLASS );

	*p = s;
	memused += s;
	numobjects++;

#ifdef ID_DEBUG_MEMORY
	unsigned long *ptr = (unsigned long *)p;
	int size = s;
	assert( ( size & 3 ) == 0 );
	size >>= 3;
	for ( int i = 1; i < size; i++ ) {
		ptr[i] = 0xcdcdcdcd;
	}
#endif

	return p + 1;
}

#ifdef ID_DEBUG_MEMORY
#define new ID_DEBUG_NEW
#endif

/*
================
idClass::delete
================
*/
void idClass::operator delete( void *ptr ) {
	int *p;

	if ( ptr ) {
		p = ( ( int * )ptr ) - 1;
		memused -= *p;
		numobjects--;
        Mem_Free( p );
	}
}

void idClass::operator delete( void *ptr, int, int, char *, int ) {
	int *p;

	if ( ptr ) {
		p = ( ( int * )ptr ) - 1;
		memused -= *p;
		numobjects--;
        Mem_Free( p );
	}
}

/*
================
idClass::GetClass

Returns the idTypeInfo for the name of the class passed in.  This is a static function
so it must be called as idClass::GetClass( classname )
================
*/
idTypeInfo *idClass::GetClass( const char *name ) {
	idTypeInfo	*c;
	int			order;
	int			mid;
	int			min;
	int			max;

	if ( !initialized ) {
		// idClass::Init hasn't been called yet, so do a slow lookup
		for( c = typelist; c != NULL; c = c->next ) {
			if ( !idStr::Cmp( c->classname, name ) ) {
				return c;
			}
		}
	} else {
		// do a binary search through the list of types
		min = 0;
		max = types.Num() - 1;
		while( min <= max ) {
			mid = ( min + max ) / 2;
			c = types[ mid ];
			order = idStr::Cmp( c->classname, name );
			if ( !order ) {
				return c;
			} else if ( order > 0 ) {
				max = mid - 1;
			} else {
				min = mid + 1;
			}
		}
	}

	return NULL;
}

/*
================
idClass::GetType
================
*/
idTypeInfo *idClass::GetType( const int typeNum ) {
	idTypeInfo *c;

	if ( !initialized ) {
		for( c = typelist; c != NULL; c = c->next ) {
			if ( c->typeNum == typeNum ) {
				return c;
			}
		}
	} else if ( ( typeNum >= 0 ) && ( typeNum < types.Num() ) ) {
		return typenums[ typeNum ];
	}

	return NULL;
}

/*
================
idClass::GetClassname

Returns the text classname of the object.
================
*/
const char *idClass::GetClassname( void ) const {
	idTypeInfo *type;

	type = GetType();
	return type->classname;
}

/*
================
idClass::GetSuperclass

Returns the text classname of the superclass.
================
*/
const char *idClass::GetSuperclass( void ) const {
	idTypeInfo *cls;

	cls = GetType();
	return cls->superclass;
}

/*
================
idClass::CancelEvents
================
*/
void idClass::CancelEvents( const idEventDef *ev ) {
	idEvent::CancelEvents( this, ev );
}


// abahr:
/*
================
idClass::EventIsPosted
================
*/
bool idClass::EventIsPosted( const idEventDef *ev ) const {
	return idEvent::EventIsPosted( this, ev );
}


/*
================
idClass::PostEventArgs
================
*/
bool idClass::PostEventArgs( const idEventDef *ev, int time, int numargs, ... ) {
	idTypeInfo	*c;
	idEvent		*event;
	va_list		args;
	
	assert( ev );
	
	if ( !idEvent::initialized ) {
		return false;
	}

	c = GetType();
	if ( !c->eventMap[ ev->GetEventNum() ] ) {
		// we don't respond to this event, so ignore it
		return false;
	}

	// we service events on the client to avoid any bad code filling up the event pool
	// we don't want them processed usually, unless when the map is (re)loading.
	// we allow threads to run fine, though.

// bdube: added a check to see if this is a client entity
// jnewquist: Use accessor for static class type 
	bool isClient = !IsClient() && gameLocal.isClient;

	if(  isClient && ( gameLocal.GameState() != GAMESTATE_STARTUP ) && ( gameLocal.GameState() != GAMESTATE_RESTART ) && !IsType( idThread::GetClassType() ) ) {

		return true;
	}

	va_start( args, numargs );
	event = idEvent::Alloc( ev, numargs, args );
	va_end( args );

	event->Schedule( this, c, time );

	return true;
}

/*
================
idClass::PostEventMS
================
*/
bool idClass::PostEventMS( const idEventDef *ev, int time ) {
	return PostEventArgs( ev, time, 0 );
}

/*
================
idClass::PostEventMS
================
*/
bool idClass::PostEventMS( const idEventDef *ev, int time, idEventArg arg1 ) {
	return PostEventArgs( ev, time, 1, &arg1 );
}

/*
================
idClass::PostEventMS
================
*/
bool idClass::PostEventMS( const idEventDef *ev, int time, idEventArg arg1, idEventArg arg2 ) {
	return PostEventArgs( ev, time, 2, &arg1, &arg2 );
}

/*
================
idClass::PostEventMS
================
*/
bool idClass::PostEventMS( const idEventDef *ev, int time, idEventArg arg1, idEventArg arg2, idEventArg arg3 ) {
	return PostEventArgs( ev, time, 3, &arg1, &arg2, &arg3 );
}

/*
================
idClass::PostEventMS
================
*/
bool idClass::PostEventMS( const idEventDef *ev, int time, idEventArg arg1, idEventArg arg2, idEventArg arg3, idEventArg arg4 ) {
	return PostEventArgs( ev, time, 4, &arg1, &arg2, &arg3, &arg4 );
}

/*
================
idClass::PostEventMS
================
*/
bool idClass::PostEventMS( const idEventDef *ev, int time, idEventArg arg1, idEventArg arg2, idEventArg arg3, idEventArg arg4, idEventArg arg5 ) {
	return PostEventArgs( ev, time, 5, &arg1, &arg2, &arg3, &arg4, &arg5 );
}

/*
================
idClass::PostEventMS
================
*/
bool idClass::PostEventMS( const idEventDef *ev, int time, idEventArg arg1, idEventArg arg2, idEventArg arg3, idEventArg arg4, idEventArg arg5, idEventArg arg6 ) {
	return PostEventArgs( ev, time, 6, &arg1, &arg2, &arg3, &arg4, &arg5, &arg6 );
}

/*
================
idClass::PostEventMS
================
*/
bool idClass::PostEventMS( const idEventDef *ev, int time, idEventArg arg1, idEventArg arg2, idEventArg arg3, idEventArg arg4, idEventArg arg5, idEventArg arg6, idEventArg arg7 ) {
	return PostEventArgs( ev, time, 7, &arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7 );
}

/*
================
idClass::PostEventMS
================
*/
bool idClass::PostEventMS( const idEventDef *ev, int time, idEventArg arg1, idEventArg arg2, idEventArg arg3, idEventArg arg4, idEventArg arg5, idEventArg arg6, idEventArg arg7, idEventArg arg8 ) {
	return PostEventArgs( ev, time, 8, &arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7, &arg8 );
}

/*
================
idClass::PostEventSec
================
*/
bool idClass::PostEventSec( const idEventDef *ev, float time ) {
	return PostEventArgs( ev, SEC2MS( time ), 0 );
}

/*
================
idClass::PostEventSec
================
*/
bool idClass::PostEventSec( const idEventDef *ev, float time, idEventArg arg1 ) {
	return PostEventArgs( ev, SEC2MS( time ), 1, &arg1 );
}

/*
================
idClass::PostEventSec
================
*/
bool idClass::PostEventSec( const idEventDef *ev, float time, idEventArg arg1, idEventArg arg2 ) {
	return PostEventArgs( ev, SEC2MS( time ), 2, &arg1, &arg2 );
}

/*
================
idClass::PostEventSec
================
*/
bool idClass::PostEventSec( const idEventDef *ev, float time, idEventArg arg1, idEventArg arg2, idEventArg arg3 ) {
	return PostEventArgs( ev, SEC2MS( time ), 3, &arg1, &arg2, &arg3 );
}

/*
================
idClass::PostEventSec
================
*/
bool idClass::PostEventSec( const idEventDef *ev, float time, idEventArg arg1, idEventArg arg2, idEventArg arg3, idEventArg arg4 ) {
	return PostEventArgs( ev, SEC2MS( time ), 4, &arg1, &arg2, &arg3, &arg4 );
}

/*
================
idClass::PostEventSec
================
*/
bool idClass::PostEventSec( const idEventDef *ev, float time, idEventArg arg1, idEventArg arg2, idEventArg arg3, idEventArg arg4, idEventArg arg5 ) {
	return PostEventArgs( ev, SEC2MS( time ), 5, &arg1, &arg2, &arg3, &arg4, &arg5 );
}

/*
================
idClass::PostEventSec
================
*/
bool idClass::PostEventSec( const idEventDef *ev, float time, idEventArg arg1, idEventArg arg2, idEventArg arg3, idEventArg arg4, idEventArg arg5, idEventArg arg6 ) {
	return PostEventArgs( ev, SEC2MS( time ), 6, &arg1, &arg2, &arg3, &arg4, &arg5, &arg6 );
}

/*
================
idClass::PostEventSec
================
*/
bool idClass::PostEventSec( const idEventDef *ev, float time, idEventArg arg1, idEventArg arg2, idEventArg arg3, idEventArg arg4, idEventArg arg5, idEventArg arg6, idEventArg arg7 ) {
	return PostEventArgs( ev, SEC2MS( time ), 7, &arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7 );
}

/*
================
idClass::PostEventSec
================
*/
bool idClass::PostEventSec( const idEventDef *ev, float time, idEventArg arg1, idEventArg arg2, idEventArg arg3, idEventArg arg4, idEventArg arg5, idEventArg arg6, idEventArg arg7, idEventArg arg8 ) {
	return PostEventArgs( ev, SEC2MS( time ), 8, &arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7, &arg8 );
}

/*
================
idClass::ProcessEventArgs
================
*/
bool idClass::ProcessEventArgs( const idEventDef *ev, int numargs, ... ) {
	idTypeInfo	*c;
	int			num;
	int			data[ D_EVENT_MAXARGS ];
	va_list		args;
	
	assert( ev );
	assert( idEvent::initialized );

	c = GetType();
	num = ev->GetEventNum();
	if ( !c->eventMap[ num ] ) {
		// we don't respond to this event, so ignore it
		return false;
	}

	va_start( args, numargs );
	idEvent::CopyArgs( ev, numargs, args, data );
	va_end( args );

	ProcessEventArgPtr( ev, data );

	return true;
}

/*
================
idClass::ProcessEvent
================
*/
bool idClass::ProcessEvent( const idEventDef *ev ) {
	return ProcessEventArgs( ev, 0 );
}

/*
================
idClass::ProcessEvent
================
*/
bool idClass::ProcessEvent( const idEventDef *ev, idEventArg arg1 ) {
	return ProcessEventArgs( ev, 1, &arg1 );
}

/*
================
idClass::ProcessEvent
================
*/
bool idClass::ProcessEvent( const idEventDef *ev, idEventArg arg1, idEventArg arg2 ) {
	return ProcessEventArgs( ev, 2, &arg1, &arg2 );
}

/*
================
idClass::ProcessEvent
================
*/
bool idClass::ProcessEvent( const idEventDef *ev, idEventArg arg1, idEventArg arg2, idEventArg arg3 ) {
	return ProcessEventArgs( ev, 3, &arg1, &arg2, &arg3 );
}

/*
================
idClass::ProcessEvent
================
*/
bool idClass::ProcessEvent( const idEventDef *ev, idEventArg arg1, idEventArg arg2, idEventArg arg3, idEventArg arg4 ) {
	return ProcessEventArgs( ev, 4, &arg1, &arg2, &arg3, &arg4 );
}

/*
================
idClass::ProcessEvent
================
*/
bool idClass::ProcessEvent( const idEventDef *ev, idEventArg arg1, idEventArg arg2, idEventArg arg3, idEventArg arg4, idEventArg arg5 ) {
	return ProcessEventArgs( ev, 5, &arg1, &arg2, &arg3, &arg4, &arg5 );
}

/*
================
idClass::ProcessEvent
================
*/
bool idClass::ProcessEvent( const idEventDef *ev, idEventArg arg1, idEventArg arg2, idEventArg arg3, idEventArg arg4, idEventArg arg5, idEventArg arg6 ) {
	return ProcessEventArgs( ev, 6, &arg1, &arg2, &arg3, &arg4, &arg5, &arg6 );
}

/*
================
idClass::ProcessEvent
================
*/
bool idClass::ProcessEvent( const idEventDef *ev, idEventArg arg1, idEventArg arg2, idEventArg arg3, idEventArg arg4, idEventArg arg5, idEventArg arg6, idEventArg arg7 ) {
	return ProcessEventArgs( ev, 7, &arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7 );
}

/*
================
idClass::ProcessEvent
================
*/
bool idClass::ProcessEvent( const idEventDef *ev, idEventArg arg1, idEventArg arg2, idEventArg arg3, idEventArg arg4, idEventArg arg5, idEventArg arg6, idEventArg arg7, idEventArg arg8 ) {
	return ProcessEventArgs( ev, 8, &arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7, &arg8 );
}

/*
================
idClass::ProcessEventArgPtr
================
*/
bool idClass::ProcessEventArgPtr( const idEventDef *ev, int *data ) {
	idTypeInfo	*c;
	int			num;
	eventCallback_t	callback;

	assert( ev );
	assert( idEvent::initialized );


// jnewquist: Use accessor for static class type 
	if ( g_debugTriggers.GetBool() && ( ev == &EV_Activate ) && IsType( idEntity::GetClassType() ) ) {

		const idEntity *ent = *reinterpret_cast<idEntity **>( data );
		gameLocal.Printf( "%d: '%s' activated by '%s'\n", gameLocal.framenum, static_cast<idEntity *>( this )->GetName(), ent ? ent->GetName() : "NULL" );
	}

	c = GetType();
	num = ev->GetEventNum();
	if ( !c->eventMap[ num ] ) {
		// we don't respond to this event, so ignore it
		return false;
	}

	callback = c->eventMap[ num ];

#if !CPU_EASYARGS

/*
on ppc architecture, floats are passed in a seperate set of registers
the function prototypes must have matching float declaration

http://developer.apple.com/documentation/DeveloperTools/Conceptual/MachORuntime/2rt_powerpc_abi/chapter_9_section_5.html
*/

	switch( ev->GetFormatspecIndex() ) {
	case 1 << D_EVENT_MAXARGS :
		( this->*callback )();
		break;

// generated file - see CREATE_EVENT_CODE
#include "Callbacks.cpp"

	default:
		gameLocal.Warning( "Invalid formatspec on event '%s'", ev->GetName() );
		break;
	}

#else

	assert( D_EVENT_MAXARGS == 8 );

	switch( ev->GetNumArgs() ) {
	case 0 :
		( this->*callback )();
		break;

	case 1 :
		typedef void ( idClass::*eventCallback_1_t )( const int );
		( this->*( eventCallback_1_t )callback )( data[ 0 ] );
		break;

	case 2 :
		typedef void ( idClass::*eventCallback_2_t )( const int, const int );
		( this->*( eventCallback_2_t )callback )( data[ 0 ], data[ 1 ] );
		break;

	case 3 :
		typedef void ( idClass::*eventCallback_3_t )( const int, const int, const int );
		( this->*( eventCallback_3_t )callback )( data[ 0 ], data[ 1 ], data[ 2 ] );
		break;

	case 4 :
		typedef void ( idClass::*eventCallback_4_t )( const int, const int, const int, const int );
		( this->*( eventCallback_4_t )callback )( data[ 0 ], data[ 1 ], data[ 2 ], data[ 3 ] );
		break;

	case 5 :
		typedef void ( idClass::*eventCallback_5_t )( const int, const int, const int, const int, const int );
		( this->*( eventCallback_5_t )callback )( data[ 0 ], data[ 1 ], data[ 2 ], data[ 3 ], data[ 4 ] );
		break;

	case 6 :
		typedef void ( idClass::*eventCallback_6_t )( const int, const int, const int, const int, const int, const int );
		( this->*( eventCallback_6_t )callback )( data[ 0 ], data[ 1 ], data[ 2 ], data[ 3 ], data[ 4 ], data[ 5 ] );
		break;

	case 7 :
		typedef void ( idClass::*eventCallback_7_t )( const int, const int, const int, const int, const int, const int, const int );
		( this->*( eventCallback_7_t )callback )( data[ 0 ], data[ 1 ], data[ 2 ], data[ 3 ], data[ 4 ], data[ 5 ], data[ 6 ] );
		break;

	case 8 :
		typedef void ( idClass::*eventCallback_8_t )( const int, const int, const int, const int, const int, const int, const int, const int );
		( this->*( eventCallback_8_t )callback )( data[ 0 ], data[ 1 ], data[ 2 ], data[ 3 ], data[ 4 ], data[ 5 ], data[ 6 ], data[ 7 ] );
		break;

	default:
		gameLocal.Warning( "Invalid formatspec on event '%s'", ev->GetName() );
		break;
	}

#endif

	return true;
}

/*
================
idClass::Event_Remove
================
*/
void idClass::Event_Remove( void ) {
	delete this;
}

/*
================
idClass::Event_SafeRemove
================
*/
void idClass::Event_SafeRemove( void ) {
	// Forces the remove to be done at a safe time
	PostEventMS( &EV_Remove, 0 );
}


// bdube: client entities
/*
================
idClass::IsClient
================
*/
bool idClass::IsClient ( void ) const {
	return false;
}

/*
================
idClass::GetDebugInfo
================
*/
void idClass::GetDebugInfo ( debugInfoProc_t proc, void* userData ) {
}

/*
================
idClass::ProcessState
================
*/
stateResult_t idClass::ProcessState ( const rvStateFunc<idClass>* state, const stateParms_t& parms ) {
	return (this->*(state->function)) ( parms );
}

stateResult_t idClass::ProcessState ( const char* name, const stateParms_t& parms ) {
	int				i;
	idTypeInfo*		cls;
	
	for ( cls = GetType(); cls; cls = cls->super ) {
		for ( i = 0; cls->stateCallbacks[i].function; i ++ ) {
			if ( !idStr::Icmp ( cls->stateCallbacks[i].name, name ) ) {
				return (this->*(cls->stateCallbacks[i].function)) ( parms );
			}
		}
	}
	
	return SRESULT_ERROR;
}

/*
================
idClass::FindState
================
*/
const rvStateFunc<idClass>* idClass::FindState ( const char* name ) const {
	int				i;
	idTypeInfo*		cls;
	
	for ( cls = GetType(); cls; cls = cls->super ) {
		for ( i = 0; cls->stateCallbacks[i].function; i ++ ) {
			if ( !idStr::Icmp ( cls->stateCallbacks[i].name, name ) ) {
				return &cls->stateCallbacks[i];
			}
		}
	}
	
	return NULL;
}

/*
================
idClass::RegisterClasses
================
*/
void idClass::RegisterClasses( void )
{
// jnewquist: Register subclasses explicitly so they aren't dead-stripped
#define REGISTER(name) void Register_##name(void); Register_##name();
	REGISTER(idAFAttachment); // ..\..\code\game\AFEntity.cpp
	REGISTER(idAFEntity_Base); // ..\..\code\game\AFEntity.cpp
	REGISTER(idAFEntity_ClawFourFingers); // ..\..\code\game\AFEntity.cpp
	REGISTER(idAFEntity_Generic); // ..\..\code\game\AFEntity.cpp
	REGISTER(idAFEntity_Gibbable); // ..\..\code\game\AFEntity.cpp
	REGISTER(idAFEntity_SteamPipe); // ..\..\code\game\AFEntity.cpp
	REGISTER(idAFEntity_WithAttachedHead); // ..\..\code\game\AFEntity.cpp
	REGISTER(idActivator); // ..\..\code\game\Misc.cpp
	REGISTER(idActor); // ..\..\code\game\Actor.cpp
	REGISTER(idAnimated); // ..\..\code\game\Misc.cpp
	REGISTER(idAnimatedEntity); // ..\..\code\game\Entity.cpp
	REGISTER(idBarrel); // ..\..\code\game\Moveable.cpp
	REGISTER(idBobber); // ..\..\code\game\Mover.cpp
	REGISTER(idBrittleFracture); // ..\..\code\game\BrittleFracture.cpp
	REGISTER(idCamera); // ..\..\code\game\Camera.cpp
	REGISTER(idCameraAnim); // ..\..\code\game\Camera.cpp
	REGISTER(idCameraView); // ..\..\code\game\Camera.cpp
	REGISTER(idChain); // ..\..\code\game\AFEntity.cpp
	REGISTER(idClass); // ..\..\code\game\gamesys\Class.cpp
	REGISTER(idCursor3D); // ..\..\code\game\GameEdit.cpp
	REGISTER(idDamagable); // ..\..\code\game\Misc.cpp
	REGISTER(idDoor); // ..\..\code\game\Mover.cpp
	REGISTER(idElevator); // ..\..\code\game\Mover.cpp
	REGISTER(idEntity); // ..\..\code\game\Entity.cpp
	REGISTER(idExplodable); // ..\..\code\game\Misc.cpp
	REGISTER(idExplodingBarrel); // ..\..\code\game\Moveable.cpp
	REGISTER(idForce); // ..\..\code\game\physics\Force.cpp
	REGISTER(idForceField); // ..\..\code\game\Misc.cpp
	REGISTER(idForce_Constant); // ..\..\code\game\physics\Force_Constant.cpp
	REGISTER(idForce_Drag); // ..\..\code\game\physics\Force_Drag.cpp
	REGISTER(idForce_Field); // ..\..\code\game\physics\Force_Field.cpp
	REGISTER(idForce_Spring); // ..\..\code\game\physics\Force_Spring.cpp

	REGISTER(rvAnimatedClientEntity); // ..\..\code\game\client\ClientModel.cpp
	REGISTER(rvClientAFEntity); // ..\..\code\game\client\ClientAFEntity.cpp
	REGISTER(rvClientAFAttachment); // ..\..\code\game\client\ClientAFEntity.cpp

	REGISTER(idLight); // ..\..\code\game\Light.cpp
	REGISTER(idLocationEntity); // ..\..\code\game\Misc.cpp
	REGISTER(idLocationSeparatorEntity); // ..\..\code\game\Misc.cpp
	REGISTER(idMoveable); // ..\..\code\game\Moveable.cpp

	REGISTER(idMover); // ..\..\code\game\Mover.cpp
	REGISTER(idMover_Binary); // ..\..\code\game\Mover.cpp
	REGISTER(idMover_Periodic); // ..\..\code\game\Mover.cpp
	REGISTER(idMultiModelAF); // ..\..\code\game\AFEntity.cpp

	REGISTER(idPathCorner); // ..\..\code\game\Misc.cpp
	REGISTER(idPendulum); // ..\..\code\game\Mover.cpp
	REGISTER(idPhysics); // ..\..\code\game\physics\Physics.cpp
	REGISTER(idPhysics_AF); // ..\..\code\game\physics\Physics_AF.cpp
	REGISTER(idPhysics_Actor); // ..\..\code\game\physics\Physics_Actor.cpp
	REGISTER(idPhysics_Base); // ..\..\code\game\physics\Physics_Base.cpp
	REGISTER(idPhysics_Parametric); // ..\..\code\game\physics\Physics_Parametric.cpp
	REGISTER(idPhysics_Player); // ..\..\code\game\physics\Physics_Player.cpp
	REGISTER(idPhysics_RigidBody); // ..\..\code\game\physics\Physics_RigidBody.cpp
	REGISTER(idPhysics_Static); // ..\..\code\game\physics\Physics_Static.cpp
	REGISTER(idPhysics_StaticMulti); // ..\..\code\game\physics\Physics_StaticMulti.cpp
	REGISTER(idPlat); // ..\..\code\game\Mover.cpp
	REGISTER(idPlayer); // ..\..\code\game\Player.cpp
	REGISTER(idProjectile); // ..\..\code\game\Projectile.cpp
	REGISTER(idRiser); // ..\..\code\game\Mover.cpp
	REGISTER(idRotater); // ..\..\code\game\Mover.cpp
	REGISTER(idSecurityCamera); // ..\..\code\game\SecurityCamera.cpp
	REGISTER(idSound); // ..\..\code\game\Sound.cpp
	REGISTER(idSpawnableEntity); // ..\..\code\game\Misc.cpp
	REGISTER(idSplinePath); // ..\..\code\game\Mover.cpp
	REGISTER(idSpring); // ..\..\code\game\Misc.cpp
	REGISTER(idStaticEntity); // ..\..\code\game\Misc.cpp
	REGISTER(idTarget); // ..\..\code\game\Target.cpp

	REGISTER(idTestModel); // ..\..\code\game\anim\Anim_Testmodel.cpp
	REGISTER(idThread); // ..\..\code\game\script\Script_Thread.cpp
	REGISTER(idTrigger); // ..\..\code\game\Trigger.cpp
	REGISTER(idTrigger_Count); // ..\..\code\game\Trigger.cpp
	REGISTER(idTrigger_EntityName); // ..\..\code\game\Trigger.cpp
	REGISTER(idTrigger_Fade); // ..\..\code\game\Trigger.cpp
	REGISTER(idTrigger_Hurt); // ..\..\code\game\Trigger.cpp
	REGISTER(idTrigger_Multi); // ..\..\code\game\Trigger.cpp
	REGISTER(idTrigger_Timer); // ..\..\code\game\Trigger.cpp
	REGISTER(idTrigger_Touch); // ..\..\code\game\Trigger.cpp
	REGISTER(idVacuumEntity); // ..\..\code\game\Misc.cpp
	REGISTER(idVacuumSeparatorEntity); // ..\..\code\game\Misc.cpp
	REGISTER(idWorldspawn); // ..\..\code\game\WorldSpawn.cpp
	REGISTER(rvAFAttractor); // ..\..\code\game\AFEntity.cpp
	REGISTER(rvCameraPlayback); // ..\..\code\game\Camera.cpp
	REGISTER(rvCameraPortalSky); // ..\..\code\game\Camera.cpp
	REGISTER(rvClientCrawlEffect); // ..\..\code\game\client\ClientEffect.cpp
	REGISTER(rvClientEffect); // ..\..\code\game\client\ClientEffect.cpp
	REGISTER(rvClientEntity); // ..\..\code\game\client\ClientEntity.cpp
	REGISTER(rvClientModel); // ..\..\code\game\client\ClientModel.cpp
	REGISTER(rvClientMoveable); // ..\..\code\game\client\ClientMoveable.cpp
	REGISTER(rvClientPhysics); // ..\..\code\game\client\ClientEntity.cpp
	REGISTER(rvConveyor); // ..\..\code\game\Mover.cpp

	REGISTER(rvEffect); // ..\..\code\game\Effect.cpp
	REGISTER(rvGravityArea); // ..\..\code\game\Misc.cpp
	REGISTER(rvGravityArea_Static); // ..\..\code\game\Misc.cpp
	REGISTER(rvGravityArea_SurfaceNormal); // ..\..\code\game\Misc.cpp
	REGISTER(rvGravitySeparatorEntity); // ..\..\code\game\Misc.cpp
	REGISTER(rvHealingStation); // ..\..\code\game\Healing_Station.cpp
	REGISTER(rvJumpPad); // ..\..\code\game\Misc.cpp
	REGISTER(rvModviewModel); // ..\..\code\game\GameEdit.cpp
	REGISTER(rvPusher); // ..\..\code\game\Mover.cpp

	REGISTER(rvPhysics_Particle); // ..\..\code\game\physics\Physics_Particle.cpp
	REGISTER(rvPhysics_Spline); // ..\..\code\game\SplineMover.cpp
	REGISTER(rvSpawner); // ..\..\code\game\spawner.cpp
	REGISTER(rvSplineMover); // ..\..\code\game\SplineMover.cpp

	REGISTER(rvViewWeapon); // ..\..\code\game\Weapon.cpp
	REGISTER(rvWeapon); // ..\..\code\game\Weapon.cpp

	// <q4f>
	REGISTER(HandGrenade); // ..\..\code\game\Q4F\HandGrenades.cpp
	REGISTER(FragGrenade); // ..\..\code\game\Q4F\HandGrenades.cpp
	//REGISTER(FlashGrenade); // ..\..\code\game\Q4F\HandGrenades.cpp
	REGISTER(ConcussionGrenade); // ..\..\code\game\Q4F\HandGrenades.cpp
	REGISTER(NailGrenade); // ..\..\code\game\Q4F\HandGrenades.cpp
	REGISTER(ClusterGrenade); // ..\..\code\game\Q4F\HandGrenades.cpp
	REGISTER(NapalmGrenade); // ..\..\code\game\Q4F\HandGrenades.cpp
	REGISTER(NapalmFire); // ..\..\code\game\Q4F\HandGrenades.cpp
	REGISTER(GasGrenade); // ..\..\code\game\Q4F\HandGrenades.cpp
	REGISTER(EmpGrenade); // ..\..\code\game\Q4F\HandGrenades.cpp
	REGISTER(q4fWater); // ..\..\code\game\Q4F\Water.cpp

	REGISTER(BuildableEntity); // ..\..\code\game\Q4F\BuildableEntity.cpp
	REGISTER(DetPak); // ..\..\code\game\Q4F\DetPak.cpp
	REGISTER(SentryGun); // ..\..\code\game\Q4F\Sentry.cpp
	REGISTER(Dispenser); // ..\..\code\game\Q4F\Dispenser.cpp

	REGISTER(SniperDot); // ..\..\code\game\weapon.cpp
	REGISTER(rvWeaponGauntlet); // ..\..\code\game\weapon.cpp
	REGISTER(SniperRifle); // ..\..\code\game\weapon.cpp
	REGISTER(Minigun); // ..\..\code\game\weapon.cpp
	REGISTER(Nailgun); // ..\..\code\game\weapon.cpp
	REGISTER(HyperBlaster); // ..\..\code\game\weapon.cpp
	REGISTER(Flamethrower); // ..\..\code\game\weapon.cpp
	REGISTER(Pipebomb);


	// TF ents
	REGISTER(TFEntity); // ..\..\code\game\Q4F\TFEntity\TFEntity.cpp
	REGISTER(TFItem); // ..\..\code\game\Q4F\TFEntity\TFItem.cpp
	REGISTER(TFTrigger); // ..\..\code\game\Q4F\TFEntity\TFTrigger.cpp
	REGISTER(TFCarryItem); // ..\..\code\game\Q4F\TFEntity\TFItem.cpp
	REGISTER(q4fPlayerStart); // ..\..\code\game\Q4F\TFEntity\TFFunc.cpp

	REGISTER(q4fAntiTeam);

	// </q4f>
#undef REGISTER
}



