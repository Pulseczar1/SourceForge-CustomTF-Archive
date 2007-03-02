#include "../idlib/precompiled.h"
#pragma hdrstop

#include "Game_local.h"

struct game_name_s {
	game_name_s( void ) {
		sprintf( string, "Q4F %s", "1.1c" );
	}
	char string[256];
} game_name;

idCVar gamename( "gamename", game_name.string, CVAR_GAME | CVAR_SERVERINFO | CVAR_ROM, "" );


#include "../bse/BSEInterface.h"
#include "Projectile.h"
#include "client/ClientEffect.h"
#include "Game_Log.h"


//#define UI_DEBUG	1

#ifdef GAME_DLL

idSys *						sys = NULL;
idCommon *					common = NULL;
idCmdSystem *				cmdSystem = NULL;
idCVarSystem *				cvarSystem = NULL;
idFileSystem *				fileSystem = NULL;
idNetworkSystem *			networkSystem = NULL;
idRenderSystem *			renderSystem = NULL;
idSoundSystem *				soundSystem = NULL;
idRenderModelManager *		renderModelManager = NULL;
idUserInterfaceManager *	uiManager = NULL;
idDeclManager *				declManager = NULL;
idAASFileManager *			AASFileManager = NULL;
idCollisionModelManager *	collisionModelManager = NULL;


// jscott: game interface to the fx system
rvBSEManager *				bse = NULL;


idCVar *					idCVar::staticVars = NULL;


// rjohnson: new help system for cvar ui
idCVarHelp *				idCVarHelp::staticCVarHelps = NULL;
idCVarHelp *				idCVarHelp::staticCVarHelpsTail = NULL;



idCVar com_forceGenericSIMD( "com_forceGenericSIMD", "0", CVAR_BOOL|CVAR_SYSTEM, "force generic platform independent SIMD" );

#endif

idRenderWorld *				gameRenderWorld = NULL;		// all drawing is done to this world

static gameExport_t			gameExport;

// global animation lib

// jsinger: changed to a pointer to prevent its constructor from allocating
//          memory before the unified allocator could be initialized
idAnimManager				*animationLib = NULL;


// the rest of the engine will only reference the "game" variable, while all local aspects stay hidden
idGameLocal					gameLocal;
idGame *					game = &gameLocal;	// statically pointed at an idGameLocal

// <q4f>
TFGame						tfGame;		// team fortress game rules and actions
Alias						alias;
// </q4f>

const char *idGameLocal::sufaceTypeNames[ MAX_SURFACE_TYPES ] = {
	"none",	"metal", "stone", "flesh", "wood", "cardboard", "liquid", "glass", "plastic",
	"ricochet", "surftype10", "surftype11", "surftype12", "surftype13", "surftype14", "surftype15"
};

/*
===========
GetGameAPI
============
*/
#if __GNUC__ >= 4
#pragma GCC visibility push(default)
#endif
extern "C" gameExport_t *GetGameAPI( gameImport_t *import ) {\

	if ( import->version == GAME_API_VERSION ) {

		// set interface pointers used by the game
		sys							= import->sys;
		common						= import->common;
		cmdSystem					= import->cmdSystem;
		cvarSystem					= import->cvarSystem;
		fileSystem					= import->fileSystem;
		networkSystem				= import->networkSystem;
		renderSystem				= import->renderSystem;
		soundSystem					= import->soundSystem;
		renderModelManager			= import->renderModelManager;
		uiManager					= import->uiManager;
		declManager					= import->declManager;
		AASFileManager				= import->AASFileManager;
		collisionModelManager		= import->collisionModelManager;

// jscott: import the fx system
		bse							= import->bse;



// dluetscher: import the memory system variables
#ifdef _RV_MEM_SYS_SUPPORT
		::currentHeapArena			= import->heapArena;
		rvSetAllSysHeaps( import->systemHeapArray );
#endif

	}

	// set interface pointers used by idLib
	idLib::sys					= sys;
	idLib::common				= common;
	idLib::cvarSystem			= cvarSystem;
	idLib::fileSystem			= fileSystem;

	// setup export interface
	gameExport.version = GAME_API_VERSION;
	gameExport.game = game;
	gameExport.gameEdit = gameEdit;

// bdube: game log
	gameExport.gameLog = gameLog;
	

	return &gameExport;
}
#if __GNUC__ >= 4
#pragma GCC visibility pop
#endif

/*
===========
TestGameAPI
============
*/
void TestGameAPI( void ) {
	gameImport_t testImport;
	gameExport_t testExport;

	testImport.sys						= ::sys;
	testImport.common					= ::common;
	testImport.cmdSystem				= ::cmdSystem;
	testImport.cvarSystem				= ::cvarSystem;
	testImport.fileSystem				= ::fileSystem;
	testImport.networkSystem			= ::networkSystem;
	testImport.renderSystem				= ::renderSystem;
	testImport.soundSystem				= ::soundSystem;
	testImport.renderModelManager		= ::renderModelManager;
	testImport.uiManager				= ::uiManager;
	testImport.declManager				= ::declManager;
	testImport.AASFileManager			= ::AASFileManager;
	testImport.collisionModelManager	= ::collisionModelManager;


// jscott: import the fx system
	testImport.bse						= ::bse;


	testExport = *GetGameAPI( &testImport );
}

/*
================
idGameLocal::BuildModList
================
*/
void idGameLocal::BuildModList( ) {
	int i;
	idStr currentMod;

	int numServers = networkSystem->GetNumScannedServers();

	if ( filterMod >= 0 && filterMod < modList.Num() ) {
		currentMod = modList[ filterMod ];
	} else {
		currentMod = "";
	}

	modList.Clear();
	for (i = 0; i < numServers; i++) {
		const scannedServer_t *server;
		idStr modname;

		server = networkSystem->GetScannedServerInfo( i );

		server->serverInfo.GetString( "fs_game", "", modname );
		modname.ToLower();
		modList.AddUnique( modname );
	}

	modList.Sort();

	if ( modList.Num() > 0 && (modList[ 0 ].Cmp( "" ) == 0) ) {
		modList.RemoveIndex( 0 );
	}

	filterMod = modList.Num();
	for (i = 0; i < modList.Num(); i++) {
		if ( modList[ i ].Icmp( currentMod ) == 0 ) {
			filterMod = i;
		}
	}
}

/*
================
FilterByMod
================
*/
static int FilterByMod( const int* serverIndex ) {
	const scannedServer_t *server;

	if ( gameLocal.filterMod < 0 || gameLocal.filterMod >= gameLocal.modList.Num() ) {
		return (int)false;
	}

	server = networkSystem->GetScannedServerInfo( *serverIndex );

	return (int)(gameLocal.modList[ gameLocal.filterMod ].Icmp( server->serverInfo.GetString( "fs_game" ) ) != 0);
}

static sortInfo_t filterByMod = {
	SC_ALL,
	NULL,
	FilterByMod,
	"#str_123006"
};

/*
===========
idGameLocal::idGameLocal
============
*/
idGameLocal::idGameLocal() {
	serverBrowser = NULL;
	Clear();
}

/*
===========
idGameLocal::Clear
============
*/
void idGameLocal::Clear( void ) {
	int i;

	forceUnreliableClient = -1;

	mapInfo.Clear();

	radarWorldScale = 1.0f;
	//worldLowerBounds.Zero();
	//worldBoundsSize.Zero();

	waterEnts.Clear();
	nonAmibentLightCount = 0;
	nonAmbientLights.Clear();
	singleLight = NULL;

	if ( serverBrowser ) {
		delete serverBrowser;
		serverBrowser = NULL;
	}

	serverInfo.Clear();
	numClients = 0;
	carryItems.Clear();
	for ( i = 0; i < MAX_CLIENTS; i++ ) {
		userInfo[i].Clear();
		persistentPlayerInfo[i].Clear();
	}
	usercmds = NULL;
	memset( entities, 0, sizeof( entities ) );
	memset( spawnIds, -1, sizeof( spawnIds ) );
	firstFreeIndex = 0;
	num_entities = 0;
	spawnedEntities.Clear();
	activeEntities.Clear();
	numEntitiesToDeactivate = 0;
	sortPushers = false;
	sortTeamMasters = false;
	memset( globalShaderParms, 0, sizeof( globalShaderParms ) );
	random.SetSeed( 0 );
	world = NULL;
	frameCommandThread = NULL;
	testmodel = NULL;

	if( gamestate != GAMESTATE_UNINITIALIZED ) {
		clip.Shutdown();
		idClip::FreeDefaultClipModel();
	}

// mwhitlock: Dynamic memory consolidation
	
	for ( i = 0; i < MAX_CLIENTS; i++ ) {
		clientsPVS[ i ].i = -1;
		clientsPVS[ i ].h = -1;
	}
	freePlayerPVS = false;
	pvs.Shutdown();
	sessionCommand.Clear();
	locationEntities = NULL;
	editEntities = NULL;
	entityHash.Clear( 1024, MAX_GENTITIES );
	inCinematic = false;
	cinematicSkipTime = 0;
	cinematicStopTime = 0;
	cinematicMaxSkipTime = 0;
	framenum = 0;
	previousTime = 0;
	time = 0;
	vacuumAreaNum = 0;


// abahr
	gravityInfo.Clear();
	scriptObjectProxies.Clear();


	mapFileName.Clear();

// rjohnson: entity usage stats
	mapFileNameStripped.Clear();

	mapFile = NULL;
	spawnCount = INITIAL_SPAWN_COUNT;
	memset( isMapEntity, 0, sizeof( bool ) * MAX_GENTITIES );

	camera = NULL;


// jscott: for portal skies
	portalSky = NULL;

// bdube: added
	lastAIAlertEntity = NULL;
	lastAIAlertEntityTime = 0;
	lastAIAlertActor = NULL;
	lastAIAlertActorTime = 0;

	spawnArgs.Clear();
	gravity.Set( 0, 0, -1 );
	playerPVS.i = -1;
	playerPVS.h = -1;
	playerConnectedAreas.i = -1;
	playerConnectedAreas.h = -1;
	gamestate = GAMESTATE_UNINITIALIZED;
	skipCinematic = false;
	influenceActive = false;

	localClientNum = 0;
	isMultiplayer = false;
	isServer = false;
	isClient = false;
	realClientTime = 0;
	isNewFrame = true;
	entityDefBits = 0;

	globalMaterial = NULL;
	newInfo.Clear();
	lastGUIEnt = NULL;
	lastGUI = 0;
	
	memset( clientEntityStates, 0, sizeof( clientEntityStates ) );
	memset( clientPVS, 0, sizeof( clientPVS ) );
	memset( clientSnapshots, 0, sizeof( clientSnapshots ) );

	eventQueue.Init();
//	savedEventQueue.Init();


// bdube: client entities
	clientSpawnCount = INITIAL_SPAWN_COUNT;
	clientSpawnedEntities.Clear();
	memset( clientEntities, 0, sizeof( clientEntities ) );
	memset( clientSpawnIds, -1, sizeof( clientSpawnIds ) );

	gameDebug.Shutdown ( );
	gameLogLocal.Shutdown ( );


	memset( lagometer, 0, sizeof( lagometer ) );

	demoState = DEMO_NONE;
	serverDemo = false;
	timeDemo = false;

	memset( &usercmd, 0, sizeof( usercmd ) );
	memset( &oldUsercmd, 0, sizeof( oldUsercmd ) );
	followPlayer = -1;	// start free flying
	demo_hud = NULL;
	demo_mphud = NULL;
	demo_cursor = NULL;

	demo_protocol = 0;

//	instancesEntityIndexWatermarks.Clear();			// xav: SBH (Should Be Here)?
//	clientInstanceFirstFreeIndex = MAX_CLIENTS;
//	minSpawnIndex = MAX_CLIENTS;

	modList.Clear();
	filterMod = -1;
	if ( networkSystem ) {
		networkSystem->UseSortFunction( filterByMod, false );
	}
}

/*
===========
idGameLocal::Init

  initialize the game object, only happens once at startup, not each level load
============
*/

// jsinger: attempt to eliminate cross-DLL allocation issues
extern idHashTable<rvViseme> *visemeTable100;
extern idHashTable<rvViseme> *visemeTable66;
extern idHashTable<rvViseme> *visemeTable33;
#ifdef RV_UNIFIED_ALLOCATOR
void idGameLocal::Init( void *(*allocator)(size_t size), void (*deallocator)( void *ptr ), size_t (*msize)(void *ptr) ) {
#else
void idGameLocal::Init( void ) {
#endif

#ifndef GAME_DLL

	TestGameAPI();

#else

	mHz = common->GetUserCmdHz();
	msec = common->GetUserCmdMSec();


// jsinger: attempt to eliminate cross-DLL allocation issues
#ifdef RV_UNIFIED_ALLOCATOR
	Memory::InitAllocator(allocator, deallocator, msize);
#endif

	// initialize idLib
	idLib::Init();

	// register static cvars declared in the game
	idCVar::RegisterStaticVars();

	// initialize processor specific SIMD
	idSIMD::InitProcessor( "game", com_forceGenericSIMD.GetBool() );

#endif

// jsinger: these need to be initialized after the InitAllocator call above in order
//          to avoid crashes when the allocator is used.
	animationLib = new idAnimManager();
	visemeTable100 = new idHashTable<rvViseme>;
	visemeTable66 = new idHashTable<rvViseme>;
	visemeTable33 = new idHashTable<rvViseme>;


	Printf( "------------- Initializing Game -------------\n" );
	Printf( "gamename: %s\n", GAME_VERSION );
	Printf( "gamedate: %s\n", __DATE__ );


// rjohnson: new help system for cvar ui
	idCVarHelp::RegisterStatics();

// jsinger: added to support serialization/deserialization of binary decls
#ifdef RV_BINARYDECLS
	idStr prefix="";
	if(cvarSystem->GetCVarBool("com_binaryDeclRead"))
	{
		prefix = "binary/";
	}
	declManager->RegisterDeclType( "model",				DECL_MODELDEF,		idDeclAllocator<idDeclModelDef>, idDeclStreamAllocator<idDeclModelDef> );
	//declManager->RegisterDeclType( "export",			DECL_MODELEXPORT,	idDeclAllocator<idDecl>, idDeclStreamAllocator<idDecl> );
	declManager->RegisterDeclType( "camera",			DECL_CAMERADEF,		idDeclAllocator<idDeclCameraDef>, idDeclStreamAllocator<idDeclCameraDef> );
	declManager->RegisterDeclFolderWrapper( prefix + "def",			".def",			DECL_ENTITYDEF );
	declManager->RegisterDeclFolderWrapper( prefix + "af",			".af",			DECL_AF );
#else

	// register game specific decl types
	declManager->RegisterDeclType( "model",				DECL_MODELDEF,		idDeclAllocator<idDeclModelDef> );
	declManager->RegisterDeclType( "export",			DECL_MODELEXPORT,	idDeclAllocator<idDecl> );


// rjohnson: camera is now contained in a def for frame commands
	declManager->RegisterDeclType( "camera",			DECL_CAMERADEF,		idDeclAllocator<idDeclCameraDef> );


	// register game specific decl folders

#ifndef RV_SINGLE_DECL_FILE
	declManager->RegisterDeclFolderWrapper( "def",			".def",			DECL_ENTITYDEF );
// bdube: not used in quake 4
//	declManager->RegisterDeclFolder( "fx",					".fx",			DECL_FX );
//	declManager->RegisterDeclFolder( "particles",			".prt",			DECL_PARTICLE );
	declManager->RegisterDeclFolderWrapper( "af",			".af",			DECL_AF );
//	declManager->RegisterDeclFolderWrapper( "newpdas",		".pda",			DECL_PDA );
#else
	if(!cvarSystem->GetCVarBool("com_SingleDeclFile"))
	{
		declManager->RegisterDeclFolderWrapper( "def",			".def",			DECL_ENTITYDEF );
		declManager->RegisterDeclFolderWrapper( "af",			".af",			DECL_AF );
	}
	else
	{
		// loads the second set of decls from the file which will contain
		// modles, cameras
		declManager->LoadDeclsFromFile();
		declManager->FinishLoadingDecls();
	}
#endif
#endif  // RV_BINARYDECLS


	cmdSystem->AddCommand( "listModelDefs", idListDecls_f<DECL_MODELDEF>, CMD_FL_SYSTEM|CMD_FL_GAME, "lists model defs" );
	cmdSystem->AddCommand( "printModelDefs", idPrintDecls_f<DECL_MODELDEF>, CMD_FL_SYSTEM|CMD_FL_GAME, "prints a model def", idCmdSystem::ArgCompletion_Decl<DECL_MODELDEF> );

	Clear();

	idEvent::Init();

// jnewquist: Register subclasses explicitly so they aren't dead-stripped
	idClass::RegisterClasses();

	idClass::Init();

	InitConsoleCommands();

	// 3j: for our cmds
	InitQ4fConsoleCommands();

	// load default scripts
	program.Startup( SCRIPT_DEFAULT );

	// load vote system
	mpGame.voteSystem.Startup();

	gamestate = GAMESTATE_NOMAP;

	Printf( "game initialized.\n" );
	Printf( "---------------------------------------------\n" );
	

// bdube: debug stuff
	gameDebug.Init ( );
	gameLogLocal.Init ( );

// jscott: facial animation init
	if( !FAS_Init( "annosoft" ) ) {
		common->Warning( "Failed to load viseme file" );
	}

// jnewquist: Tag scope and callees to track allocations using "new".
	MEM_SCOPED_TAG(tag,MA_RENDER);
// shouchard:  make sure ban list starts out in a known state
	banListLoaded = false;
	banListChanged = false;
	memset( clientGuids, 0, sizeof( clientGuids ) );



// mwhitlock: Dynamic memory consolidation
#if defined(_RV_MEM_SYS_SUPPORT)
	for(int i=0;i<MAX_CLIENTS;i++)
	{
		persistentPlayerInfo[i].SetAllocatorHeap(rvGetSysHeap(RV_HEAP_ID_PERMANENT));
	}
	entityHash.SetAllocatorHeap(rvGetSysHeap(RV_HEAP_ID_LEVEL));
	gravityInfo.SetAllocatorHeap(rvGetSysHeap(RV_HEAP_ID_LEVEL));
	scriptObjectProxies.SetAllocatorHeap(rvGetSysHeap(RV_HEAP_ID_LEVEL));
	entityUsageList.SetAllocatorHeap(rvGetSysHeap(RV_HEAP_ID_LEVEL));
	ambientLights.SetAllocatorHeap(rvGetSysHeap(RV_HEAP_ID_LEVEL));builtEntities.SetAllocatorHeap(rvGetSysHeap(RV_HEAP_ID_LEVEL));spawnSpots.SetAllocatorHeap(rvGetSysHeap(RV_HEAP_ID_LEVEL));/*aasList.SetAllocatorHeap(rvGetSysHeap(RV_HEAP_ID_LEVEL));*/banList.SetAllocatorHeap(rvGetSysHeap(RV_HEAP_ID_LEVEL));
	carryItems.SetAllocatorHeap(rvGetSysHeap(RV_HEAP_ID_LEVEL));
	players.SetAllocatorHeap(rvGetSysHeap(RV_HEAP_ID_LEVEL));
	//clip.SetAllocatorHeap(rvGetSysHeap(RV_HEAP_ID_LEVEL));
#endif
	networkSystem->AddSortFunction( filterByMod );

}

/*
===========
idGameLocal::Shutdown

  shut down the entire game
============
*/
void idGameLocal::Shutdown( void ) {

	int		i;

	if ( !common ) {
		return;
	}


// jscott: FAS
	FAS_Shutdown();
// shouchard:  clean up ban list stuff
	SaveBanList();
	FlushBanList();


	Printf( "--------------- Game Shutdown ---------------\n" );

	networkSystem->RemoveSortFunction( filterByMod );

	mpGame.Shutdown();

	MapShutdown();

	msgListCollection.Clear();

	locationCollection.Shutdown();

	// shutdown the model exporter
	idModelExport::Shutdown();

	idEvent::Shutdown();

	program.Shutdown();

	idClass::Shutdown();

	// clear list with forces
	idForce::ClearForceList();

	// free the program data
	program.FreeData();

	// delete the .map file
	delete mapFile;
	mapFile = NULL;

	// free the collision map
	collisionModelManager->FreeMap( GetMapName() );


// jscott: free up static objects
	for( i = 0; i < MAX_CLIENTS; i++ ) {
		userInfo[i].Clear();
		persistentPlayerInfo[i].Clear();
	}

	for( i = 0; i < entityUsageList.Num(); i++ ) {
		entityUsageList[i].Clear();
	}

	serverInfo.Clear();
	sessionCommand.Clear();
	mapFileName.Clear();
	mapFileNameStripped.Clear();
	entityUsageList.Clear();

	newInfo.Clear();
	spawnArgs.Clear();
	shakeSounds.Clear();

	ShutdownConsoleCommands();

	// free memory allocated by class objects
	Clear();

	// shut down the animation manager

// jsinger: animationLib changed to a pointer
	animationLib->Shutdown();



// rjohnson: entity usage stats
	entityUsageList.Clear();

	freeView.Shutdown();

	Printf( "---------------------------------------------\n" );

#ifdef GAME_DLL

	// remove auto-completion function pointers pointing into this DLL
	cvarSystem->RemoveFlaggedAutoCompletion( CVAR_GAME );

	// enable leak test
	Mem_EnableLeakTest( "game" );

	// shutdown idLib
	idLib::ShutDown();

#endif
}

/*
===========
idGameLocal::SaveGame

save the current player state, level name, and level state
the session may have written some data to the file already
============
*/

// mekberg: added saveTypes
void idGameLocal::SaveGame( idFile *f, saveType_t saveType ) {

	int i;
	idEntity *ent;
	idEntity *link;

	//remove weapon effect entites from the world
	if(	GetLocalPlayer() &&	GetLocalPlayer()->weapon )	{
		
		GetLocalPlayer()->weapon->PreSave();
	}

	idSaveGame savegame( f );

	if (g_flushSave.GetBool( ) == true ) { 
		// force flushing with each write... for tracking down
		// save game bugs.
		f->ForceFlush();
	}

	savegame.WriteBuildNumber( BUILD_NUMBER );

	// go through all entities and threads and add them to the object list
	for( i = 0; i < MAX_GENTITIES; i++ ) {
		ent = entities[i];

		if ( ent ) {
			if ( ent->GetTeamMaster() && ent->GetTeamMaster() != ent ) {
				continue;
			}
			for ( link = ent; link != NULL; link = link->GetNextTeamEntity() ) {
				savegame.AddObject( link );
			}
		}
	}

	idList<idThread *> threads;
	threads = idThread::GetThreads();

	for( i = 0; i < threads.Num(); i++ ) {
		savegame.AddObject( threads[i] );
	}


// abahr: saving clientEntities
	rvClientEntity* clientEnt = NULL;
	for( i = 0; i < MAX_CENTITIES; ++i ) {
		clientEnt = clientEntities[ i ];
		if( !clientEnt ) {
			continue;
		}
//		if( clientEnt->IsType( rvClientEffect::GetClassType() )){
//			continue;
//		}
		savegame.AddObject( clientEnt );
	}


	// write out complete object list
	savegame.WriteObjectList();

	program.Save( &savegame );

	savegame.WriteDict( &serverInfo );

	savegame.WriteInt( numClients );
	for( i = 0; i < numClients; i++ ) {

// mekberg: don't write out userinfo. Grab from cvars
//		savegame.WriteDict( &userInfo[ i ] );

//		savegame.WriteUsercmd( usercmds[ i ] );
		savegame.WriteDict( &persistentPlayerInfo[ i ] );
	}

	for( i = 0; i < MAX_GENTITIES; i++ ) {
		savegame.WriteObject( entities[ i ] );
		savegame.WriteInt( spawnIds[ i ] );
	}


// abahr: more clientEntities saving
	for( i = 0; i < MAX_CENTITIES; i++ ) {
//		if( clientEntities[ i ] && clientEntities[ i ]->IsType( rvClientEffect::GetClassType() )){
//			continue;
//		}
		savegame.WriteObject( clientEntities[ i ] );
		savegame.WriteInt( clientSpawnIds[ i ] );
	}


	savegame.WriteInt( firstFreeIndex );
	savegame.WriteInt( num_entities );

	// enityHash is restored by idEntity::Restore setting the entity name.

	savegame.WriteObject( world );

	savegame.WriteInt( spawnedEntities.Num() );
	for( ent = spawnedEntities.Next(); ent != NULL; ent = ent->spawnNode.Next() ) {
		savegame.WriteObject( ent );
	}


// abahr: saving scriptObject proxies
	savegame.WriteInt( scriptObjectProxies.Num() );
	for( i = 0; i < scriptObjectProxies.Num(); ++i ) {
		scriptObjectProxies[i].Save( &savegame );
	}
// abahr: save out client stuff
	savegame.WriteInt( clientSpawnedEntities.Num() );
	for( clientEnt = clientSpawnedEntities.Next(); clientEnt != NULL; clientEnt = clientEnt->spawnNode.Next() ) {
		savegame.WriteObject( clientEnt );
	}


	savegame.WriteInt( activeEntities.Num() );
	for( ent = activeEntities.Next(); ent != NULL; ent = ent->activeNode.Next() ) {
		savegame.WriteObject( ent );
	}

	savegame.WriteInt( numEntitiesToDeactivate );
	savegame.WriteBool( sortPushers );
	savegame.WriteBool( sortTeamMasters );

	for( i = 0; i < MAX_GLOBAL_SHADER_PARMS; i++ ) {
		savegame.WriteFloat( globalShaderParms[ i ] );
	}

	savegame.WriteInt( random.GetSeed() );
	savegame.WriteObject( frameCommandThread );

	// clip
	// push
	// pvs

	testmodel = NULL;

// bdube: no test fx
//	testFx = NULL;


	savegame.WriteString( sessionCommand );

	// FIXME: save smoke particles

	savegame.WriteInt( cinematicSkipTime );
	savegame.WriteInt( cinematicStopTime );
	savegame.WriteInt( cinematicMaxSkipTime );
	savegame.WriteBool( inCinematic );
	savegame.WriteBool( skipCinematic );

	savegame.WriteBool( isMultiplayer );
//	savegame.WriteInt( gameType );

	savegame.WriteInt( framenum );
	savegame.WriteInt( previousTime );
	savegame.WriteInt( time );

	savegame.WriteInt( vacuumAreaNum );

	savegame.WriteInt( entityDefBits );
	savegame.WriteBool( isServer );
	savegame.WriteBool( isClient );

	savegame.WriteBool( isListenServer );


	savegame.WriteInt( localClientNum );

	// snapshotEntities is used for multiplayer only

	savegame.WriteInt( realClientTime );
	savegame.WriteBool( isNewFrame );

	savegame.WriteBool( mapCycleLoaded );
	savegame.WriteInt( spawnCount );

/*	if ( !locationEntities ) {
		savegame.WriteInt( 0 );
	} else {
		savegame.WriteInt( gameRenderWorld->NumAreas() );
		for( i = 0; i < gameRenderWorld->NumAreas(); i++ ) {
			savegame.WriteObject( locationEntities[ i ] );
		}
	}*/

	savegame.WriteObject( camera );

	savegame.WriteMaterial( globalMaterial );


// bdube: added
	lastAIAlertActor.Save( &savegame );
	lastAIAlertEntity.Save( &savegame );
	savegame.WriteInt( lastAIAlertEntityTime );
	savegame.WriteInt( lastAIAlertActorTime );


	savegame.WriteDict( &spawnArgs );

	savegame.WriteInt( playerPVS.i );
	savegame.WriteInt( playerPVS.h );
	savegame.WriteInt( playerConnectedAreas.i );
	savegame.WriteInt( playerConnectedAreas.h );

	savegame.WriteVec3( gravity );

	// gamestate

	savegame.WriteBool( influenceActive );

	// spawnSpots
	// initialSpots
	// currentInitialSpot
	// newInfo
	// makingBuild
	// shakeSounds

	// write out pending events
	idEvent::Save( &savegame );

	savegame.Close();


// mekberg: added saveTypes and wrapped saveMessage
	if ( saveType != ST_AUTO && GetLocalPlayer() && GetLocalPlayer()->GetHud() ) {
		GetLocalPlayer()->SaveMessage();
	}

// jshepard: resume weapon operation
	if(	GetLocalPlayer() &&	
		GetLocalPlayer()->weapon )	{
		GetLocalPlayer()->weapon->PostSave();
	}

}

/*
===========
idGameLocal::GetPersistentPlayerInfo
============
*/
const idDict &idGameLocal::GetPersistentPlayerInfo( int clientNum ) {
	idEntity	*ent;

	persistentPlayerInfo[ clientNum ].Clear();
	ent = entities[ clientNum ];

// jnewquist: Use accessor for static class type 
	if ( ent && ent->IsType( idPlayer::GetClassType() ) ) {

		static_cast<idPlayer *>(ent)->SavePersistantInfo();
	}

	return persistentPlayerInfo[ clientNum ];
}

/*
===========
idGameLocal::SetPersistentPlayerInfo
============
*/
void idGameLocal::SetPersistentPlayerInfo( int clientNum, const idDict &playerInfo ) {
	TIME_THIS_SCOPE( __FUNCLINE__);
	persistentPlayerInfo[ clientNum ] = playerInfo;
}

/*
============
idGameLocal::Printf
============
*/
void idGameLocal::Printf( const char *fmt, ... ) const {
	va_list		argptr;
	char		text[MAX_STRING_CHARS];

	va_start( argptr, fmt );
	idStr::vsnPrintf( text, sizeof( text ), fmt, argptr );
	va_end( argptr );

	common->Printf( "%s", text );
}

/*
============
idGameLocal::DPrintf
============
*/
void idGameLocal::DPrintf( const char *fmt, ... ) const {
	va_list		argptr;
	char		text[MAX_STRING_CHARS];

	if ( !developer.GetBool() ) {
		return;
	}

	va_start( argptr, fmt );
	idStr::vsnPrintf( text, sizeof( text ), fmt, argptr );
	va_end( argptr );

	common->Printf( "%s", text );
}

/*
============
idGameLocal::Warning
============
*/
void idGameLocal::Warning( const char *fmt, ... ) const {
	va_list		argptr;
	char		text[MAX_STRING_CHARS];
	idThread *	thread;

	va_start( argptr, fmt );
	idStr::vsnPrintf( text, sizeof( text ), fmt, argptr );
	va_end( argptr );

	thread = idThread::CurrentThread();
// MERGE:FIXME - the following now gets into a recursive stack overflow when enemies are killed.  Not sure why.
// nmckenzie:
/*	if ( thread ) {
		thread->Warning( "%s", text );
	} else {*/
		common->Warning( "%s", text );
//	}
}

/*
============
idGameLocal::DWarning
============
*/
void idGameLocal::DWarning( const char *fmt, ... ) const {
	va_list		argptr;
	char		text[MAX_STRING_CHARS];
	idThread *	thread;

	if ( !developer.GetBool() ) {
		return;
	}

	va_start( argptr, fmt );
	idStr::vsnPrintf( text, sizeof( text ), fmt, argptr );
	va_end( argptr );

	thread = idThread::CurrentThread();
	if ( thread ) {
		thread->Warning( "%s", text );
	} else {
		common->DWarning( "%s", text );
	}
}

/*
============
idGameLocal::Error
============
*/
void idGameLocal::Error( const char *fmt, ... ) const {
	va_list		argptr;
	char		text[MAX_STRING_CHARS];
	idThread *	thread;

	va_start( argptr, fmt );
	idStr::vsnPrintf( text, sizeof( text ), fmt, argptr );
	va_end( argptr );


// scork: some model errors arrive here during validation which kills the whole process, so let's just warn about them instead...
	if ( common->DoingDeclValidation() ) {
		this->Warning( "%s", text );
		return;
	}


	thread = idThread::CurrentThread();
	if ( thread ) {
		thread->Error( "%s", text );
	} else {
		common->Error( "%s", text );
	}
}

/*
===============
gameError
===============
*/
void gameError( const char *fmt, ... ) {
	va_list		argptr;
	char		text[MAX_STRING_CHARS];

	va_start( argptr, fmt );
	idStr::vsnPrintf( text, sizeof( text ), fmt, argptr );
	va_end( argptr );

	gameLocal.Error( "%s", text );
}

/*
===========
idGameLocal::SetLocalClient
============
*/
void idGameLocal::SetLocalClient( int clientNum ) {
	localClientNum = clientNum;
}

/*
===========
idGameLocal::SetUserInfo
============
*/
const idDict* idGameLocal::SetUserInfo( int clientNum, const idDict &userInfo, bool isClient ) {
	
	TIME_THIS_SCOPE( __FUNCLINE__);
	
	int i;
	bool modifiedInfo = false;

	this->isClient = isClient;

	if ( clientNum >= 0 && clientNum < MAX_CLIENTS ) {
		idGameLocal::userInfo[ clientNum ] = userInfo;

		// server sanity
		if ( !isClient ) {

			// 3j: make sure people don't use icons in their names
			/*idStr newName = idGameLocal::userInfo[ clientNum ].GetString( "ui_name" );
			newName.RemoveEscapes( S_ESCAPE_ICON );

			if ( newName.Icmp( idGameLocal::userInfo[ clientNum ].GetString( "ui_name" ) ) ) {
				// bastard is trying to use icons in his name
				idGameLocal::userInfo[ clientNum ].Set( "ui_name", newName.c_str() );
				modifiedInfo = true;
			}*/

			// don't allow "server" names
			if ( !idStr::Cmp( this->userInfo[ clientNum ].GetString( "ui_name" ), "server" ) ) {
				idGameLocal::userInfo[ clientNum ].Set( "ui_name", "server_wannabe" );
				modifiedInfo = true;
			}

			// don't let numeric nicknames, it can be exploited to go around kick and ban commands from the server
			if ( idStr::IsNumeric( this->userInfo[ clientNum ].GetString( "ui_name" ) ) ) {
				idGameLocal::userInfo[ clientNum ].Set( "ui_name", va( "%s_", idGameLocal::userInfo[ clientNum ].GetString( "ui_name" ) ) );
				modifiedInfo = true;
			}

			
		
			// don't allow dupe nicknames
			for ( i = 0; i < numClients; i++ ) {
				if ( i == clientNum ) {
					continue;
				}

// jnewquist: Use accessor for static class type 
				if ( entities[ i ] && entities[ i ]->IsType( idPlayer::GetClassType() ) ) {

					if ( !idStr::Icmp( idGameLocal::userInfo[ clientNum ].GetString( "ui_name" ), idGameLocal::userInfo[ i ].GetString( "ui_name" ) ) ) {
						idGameLocal::userInfo[ clientNum ].Set( "ui_name", va( "%s_", idGameLocal::userInfo[ clientNum ].GetString( "ui_name" ) ) );
						modifiedInfo = true;
						i = -1;	// rescan
						continue;
					}
				}
			}
		}


// jnewquist: Use accessor for static class type 
		if ( entities[ clientNum ] && entities[ clientNum ]->IsType( idPlayer::GetClassType() ) ) {

			modifiedInfo |= static_cast<idPlayer *>( entities[ clientNum ] )->UserInfoChanged();
		}

		if ( !isClient ) {
			// now mark this client in game
			mpGame.EnterGame( clientNum );
		}
	}

	if ( modifiedInfo ) {
		newInfo = idGameLocal::userInfo[ clientNum ];
		return &newInfo;
	}
	return NULL;
}

/*
===========
idGameLocal::GetUserInfo
============
*/
const idDict* idGameLocal::GetUserInfo( int clientNum ) {

// jnewquist: Use accessor for static class type 
	if ( entities[ clientNum ] && entities[ clientNum ]->IsType( idPlayer::GetClassType() ) ) {

		return &userInfo[ clientNum ];
	}
	return NULL;
}

/*
===========
idGameLocal::IsClientActive
============
*/
bool idGameLocal::IsClientActive( int clientNum ) {
	if ( entities[ clientNum ] && entities[ clientNum ]->IsType( idPlayer::GetClassType() ) ) {
		return true;
	}

	return false;
}


/*
===========
idGameLocal::SetServerInfo
============
*/
void idGameLocal::SetServerInfo( const idDict &_serverInfo ) {
	TIME_THIS_SCOPE( __FUNCLINE__);
	
	idBitMsg	outMsg;
	byte		msgBuf[MAX_GAME_MESSAGE_SIZE];
	bool timeLimitChanged = false;


// mekberg: clear announcer and reschedule time announcements
	if ( ( isClient || isListenServer ) && mpGame.GetGameState( ) && mpGame.GetGameState( )->GetMPGameState( ) == GAMEON &&
		serverInfo.GetInt( "si_timelimit" ) != _serverInfo.GetInt( "si_timelimit" ) ) {
			timeLimitChanged = true;
	}

	serverInfo = _serverInfo;

	if ( timeLimitChanged ) {
		mpGame.ClearAnnouncerSounds( );
		mpGame.ScheduleTimeAnnouncements( );
	}


	if ( isServer ) {
		// Let our clients know the server info changed
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_SERVERINFO );
		outMsg.WriteDeltaDict( gameLocal.serverInfo, NULL );
		networkSystem->ServerSendReliableMessage( -1, outMsg );
	}
}

/*
===================
idGameLocal::LoadMap

Initializes all map variables common to both save games and spawned games.
===================
*/
void idGameLocal::LoadMap( const char *mapName, int randseed ) {

// jnewquist: Tag scope and callees to track allocations using "new".
	MEM_SCOPED_TAG(tag,MA_PARSER);

	bool sameMap = (mapFile && idStr::Icmp(mapFile->GetName(), mapName) == 0);

	networkSystem->SetLoadingText( mapName );

	InitAsyncNetwork();

	// these can changed based upon sp / mp
	mHz = common->GetUserCmdHz();
	msec = common->GetUserCmdMSec();

	if ( !sameMap || ( mapFile && mapFile->NeedsReload() ) ) {
		// load the .map file
		if ( mapFile ) {
			delete mapFile;
		}
		mapFile = new idMapFile;
		if ( !mapFile->Parse( idStr( mapName ) + ".map" ) ) {
			delete mapFile;
			mapFile = NULL;
			Error( "Couldn't load %s", mapName );
		}

// rjohnson: added resolve for handling func_groups and other aspects.  Before, radiant would do this processing on a map destroying the original data
		mapFile->Resolve();
	}
	mapFileName = mapFile->GetName();
	
	assert(!idStr::Cmp(mapFileName, mapFile->GetName()));
	

// rjohnson: entity usage stats
	mapFileNameStripped = mapFileName;
	mapFileNameStripped.StripFileExtension();
	mapFileNameStripped.StripPath();

	// load the collision map
	networkSystem->SetLoadingText( common->GetLocalizedString( "#str_107668" ) );
	collisionModelManager->LoadMap( mapFile, false );

	numClients = 0;

	// initialize all entities for this game
	memset( entities, 0, sizeof( entities ) );
	usercmds = NULL;
	memset( spawnIds, -1, sizeof( spawnIds ) );
	spawnCount = INITIAL_SPAWN_COUNT;
	
	spawnedEntities.Clear();
	activeEntities.Clear();
	numEntitiesToDeactivate = 0;
	sortTeamMasters = false;
	sortPushers = false;
	lastGUIEnt = NULL;
	lastGUI = 0;


// bdube: client entities
	clientSpawnCount = INITIAL_SPAWN_COUNT;
	clientSpawnedEntities.Clear ( );
	memset ( clientSpawnIds, -1, sizeof(clientSpawnIds ) );
	memset ( clientEntities, 0, sizeof(clientEntities) );
	firstFreeClientIndex = 0;


	globalMaterial = NULL;

	memset( globalShaderParms, 0, sizeof( globalShaderParms ) );

	// always leave room for the max number of clients,
	// even if they aren't all used, so numbers inside that
	// range are NEVER anything but clients
	num_entities	= MAX_CLIENTS;
	firstFreeIndex	= MAX_CLIENTS;

	// reset the random number generator.
	random.SetSeed( isMultiplayer ? randseed : 0 );

	camera			= NULL;
	world			= NULL;
	testmodel		= NULL;

// bdube: not using id effects
//	testFx			= NULL;



// bdube: merged
	lastAIAlertEntity = NULL;
	lastAIAlertEntityTime = 0;
	lastAIAlertActor = NULL;
	lastAIAlertActorTime = 0;

	
	previousTime	= 0;
	time			= 0;
	framenum		= 0;
	sessionCommand = "";

	vacuumAreaNum = -1;		// if an info_vacuum is spawned, it will set this			// 3j: don't need?


// abahr
	gravityInfo.Clear();
	scriptObjectProxies.Clear();


	if ( !editEntities ) {
		editEntities = new idEditEntities;
	}

	gravity.Set( 0, 0, -g_gravity.GetFloat() );

	spawnArgs.Clear();

	// 3j_todo: don't need
	skipCinematic = false;
	inCinematic = false;
	cinematicSkipTime = 0;
	cinematicStopTime = 0;
	cinematicMaxSkipTime = 0;

	clip.Init();

	pvs.Init();

	playerPVS.i = -1;
	playerConnectedAreas.i = -1;

// bdube: not using smoke particles
	// clear the smoke particle free list
//	smokeParticles->Init();

	FindEntityDef( "preCacheExtras", false );

	if ( !sameMap ) {
		mapFile->RemovePrimitiveData();
	}


// ddynerman: ambient light list
	waterEnts.Clear();
	ambientLights.Clear();
	nonAmbientLights.Clear();
	singleLight = NULL;

	idBounds worldMaxBounds = clip.GetWorldBounds();
	float xDiff = worldMaxBounds[1].x - worldMaxBounds[0].x;
	float yDiff = worldMaxBounds[1].y - worldMaxBounds[0].y;
	float diff;

	radarWorldScale = ( ( xDiff + yDiff ) * 0.5f ) / RADAR_RANGE;

	if ( xDiff > yDiff ) {
		diff = ( xDiff - yDiff ) / 2.0f;
		worldMaxBounds[1].y += diff;
		worldMaxBounds[0].y -= diff;
	}
	else {
		diff = ( yDiff - xDiff ) / 2.0f;
		worldMaxBounds[1].x += diff;
		worldMaxBounds[0].x -= diff;
	}

	worldLowerBounds.x = worldMaxBounds[0].x;
	worldLowerBounds.y = worldMaxBounds[0].y;
	worldBoundsSize.x = worldMaxBounds[1].x - worldMaxBounds[0].x;
	worldBoundsSize.y = worldMaxBounds[1].y - worldMaxBounds[0].y;
}

/*
===================
idGameLocal::LocalMapRestart
===================
*/
void idGameLocal::LocalMapRestart( ) {
	int i, latchSpawnCount;

	Printf( "----------- Game Map Restart ------------\n" );

	if ( tfStatManager->RoundInProgress() ) {
		tfStatManager->RoundEnd();
		tfStatManager->ClearRound();
	}

	mpGame.ClearGuis();

	// client always respawns everything, so make sure it picks up the right map entities
	memset( isMapEntity, 0, sizeof(bool) * MAX_GENTITIES );

	gamestate = GAMESTATE_SHUTDOWN;

	for ( i = 0; i < MAX_CLIENTS; i++ ) {

		if ( entities[ i ] && entities[ i ]->IsType( idPlayer::GetClassType() ) ) {

			static_cast< idPlayer * >( entities[ i ] )->PrepareForRestart();
		}
	}

	eventQueue.Shutdown();

	MapClear( false );

	// clear the sound system
	soundSystem->StopAllSounds( SOUNDWORLD_GAME );

	// clear icons
	iconManager->Shutdown();

	// the spawnCount is reset to zero temporarily to spawn the map entities with the same spawnId
	// if we don't do that, network clients are confused and don't show any map entities
	latchSpawnCount = spawnCount;
	spawnCount = INITIAL_SPAWN_COUNT;

	gamestate = GAMESTATE_STARTUP;

	program.Restart();

	InitScriptForMap();

	MapPopulate();

	// once the map is populated, set the spawnCount back to where it was so we don't risk any collision
	// (note that if there are no players in the game, we could just leave it at it's current value)
	spawnCount = latchSpawnCount;

	// setup the client entities again
	for ( i = 0; i < MAX_CLIENTS; i++ ) {

		if ( entities[ i ] && entities[ i ]->IsType( idPlayer::GetClassType() ) ) {

			static_cast< idPlayer * >( entities[ i ] )->Restart();
		}
	}

	tfGame.UpdateTeamColors();

	UpdateLights( q4f_lightDetailLevel.GetFloat(), q4f_ambientLighting.GetBool() );

	gamestate = GAMESTATE_ACTIVE;

	/*if ( q4f_execMapConfigs.GetBool() ) {
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "exec config/maps/%s.cfg", mapFileNameStripped.c_str() ) );
	}*/


// shouchard:  profiling
	if ( cvarSystem->GetCVarBool( "net_debugFrameTime" ) ) {
		cvarSystem->SetCVarBool( "net_debugStartLevel", true );
	}


	Printf( "--------------------------------------\n" );
}

/*
===================
idGameLocal::MapRestart
===================
*/
void idGameLocal::MapRestart() {
	idBitMsg	outMsg;
	byte		msgBuf[MAX_GAME_MESSAGE_SIZE];
	idDict		newInfo;
	int			i;
	const idKeyValue *keyval, *keyval2;

	if ( isClient ) {
		SetGameType( si_map.GetString() );
		LocalMapRestart();
	} else {
		newInfo = *cvarSystem->MoveCVarsToDict( CVAR_SERVERINFO );
		// this has to be after the cvars are moved to the dict
		for ( i = 0; i < newInfo.GetNumKeyVals(); i++ ) {

			keyval = newInfo.GetKeyVal( i );
			keyval2 = serverInfo.FindKey( keyval->GetKey() );
			if ( !keyval2 ) {
				break;
			}
			// a select set of si_ changes will cause a full restart of the server
			if ( keyval->GetValue().Icmp( keyval2->GetValue() ) &&
				( !keyval->GetKey().Icmp( "si_pure" ) || !keyval->GetKey().Icmp( "si_map" ) ) ) {
				break;
			}
			// some calculations about time are done from the frame, and
			// that changes when si_fps changes.  full restart resets to 0.
			if ( keyval->GetValue().Icmp( keyval2->GetValue() ) &&
				!keyval->GetKey().Icmp( "si_fps" ) ) {
				break;
			}
		}

		cmdSystem->BufferCommandText( CMD_EXEC_NOW, "rescanSI" " " __FILE__ " " __LINESTR__ );

		SetGameType( si_map.GetString() );

		/*if ( !mpGame.IsValidGameType( si_map.GetString(), si_gametype.GetInteger() ) ) {
			gameLocal.Warning( "Map %s does not support gametype %d.", si_map.GetString(), si_gametype.GetInteger() );
			return;
		}*/

		if ( i != newInfo.GetNumKeyVals() ) {
			gameLocal.sessionCommand = "nextMap";
			//cmdSystem->BufferCommandText( CMD_EXEC_APPEND, "nextMap" );
		} else {
			outMsg.Init( msgBuf, sizeof( msgBuf ) );
			outMsg.WriteByte( GAME_RELIABLE_MESSAGE_RESTART );
			outMsg.WriteBits( 1, 1 );
			outMsg.WriteDeltaDict( serverInfo, NULL );
			networkSystem->ServerSendReliableMessage( -1, outMsg );

			LocalMapRestart();
			mpGame.MapRestart();
		}
	}
}

/*
===================
idGameLocal::MapRestart_f
===================
*/
void idGameLocal::MapRestart_f( const idCmdArgs &args ) {
	si_gameType.SetString( "Q4F" );
	if ( gameLocal.GameState() == GAMESTATE_NOMAP || !gameLocal.isMultiplayer || gameLocal.isClient ) {
		common->Printf( "server is not running - use spawnServer\n" );
		cmdSystem->BufferCommandText( CMD_EXEC_APPEND, "spawnServer\n" );
		return;
	}

	gameLocal.MapRestart( );
}


//--------------------------------------------------------------------------
// Retrieve the list of maps and gametypes from mapcycle
//--------------------------------------------------------------------------
void idGameLocal::GetMapList( idList<mapCycleEntry_t> &list ) {
	const char* mapCycleList = gameLocal.serverInfo.GetString( "si_mapCycle", "" );

	if ( !mapCycleList || !mapCycleList[0] )
		return;

	idLexer src;

	src.FreeSource();
	src.SetFlags( LEXFL_NOFATALERRORS | LEXFL_ALLOWPATHNAMES | LEXFL_ALLOWMULTICHARLITERALS | LEXFL_ALLOWBACKSLASHSTRINGCONCAT );
	src.LoadMemory( mapCycleList, strlen( mapCycleList ), "idGameLocal::GetMapList" );

	mapCycleEntry_t entry;

	bool expectGameType = false;

	if ( src.IsLoaded() ) {
		idToken tok;

		entry.gameTypeNum = 1;
		entry.name = "";

		while( src.ReadToken( &tok ) ) {
			if ( tok == ";" ) {

				if ( entry.name[0] ) {
					list.Append( entry );
				}

				entry.gameTypeNum = 1;
				entry.name = "";

				continue;
			}
			else if ( tok == ":" ) {
				expectGameType = true;

			}
			else if ( expectGameType ) {
				entry.gameTypeNum = atoi( tok.c_str() );
			}
			else {
				entry.name = tok;
			}
		}

		if ( entry.name[0] ) {
			list.Append( entry );
		}
	}

	src.FreeSource();
}

/*
===================
idGameLocal::NextMap
===================
*/
bool idGameLocal::NextMap( void ) {

	int i;

	const char* currentMap = serverInfo.GetString( "si_map", "" );
	int currentGameType = atoi( serverInfo.GetString( "si_gameindex", "1" ) );

	idList<mapCycleEntry_t> list;

	GetMapList( list );

	if ( list.Num() <= 0 )
		return false;

	int currentIndex = list.Num();

	for ( i = 0; i < list.Num(); i++ ) {
		if ( list[i].gameTypeNum == currentGameType && !idStr::Icmp( currentMap, list[i].name.c_str() ) ) {
			currentIndex = i;
			break;
		}
	}

	currentIndex++;

	if ( currentIndex >= list.Num() ) {
		currentIndex = 0;
	}

	si_map.SetString( list[currentIndex].name.c_str() );
	si_gameindex.SetInteger( list[currentIndex].gameTypeNum );

	const idKeyValue* keyval;
	const idKeyValue* keyval2;
	idDict newInfo = *cvarSystem->MoveCVarsToDict( CVAR_SERVERINFO );
	i = 0;
	for ( i = 0; i < newInfo.GetNumKeyVals(); i++ ) {
		keyval = newInfo.GetKeyVal( i );
		keyval2 = serverInfo.FindKey( keyval->GetKey() );
		if ( !keyval2 || keyval->GetValue().Icmp( keyval2->GetValue() ) ) {
			break;
		}
	}
	return ( i != newInfo.GetNumKeyVals() );
}


/*
===================
idGameLocal::NextMap_f
===================
*/
void idGameLocal::NextMap_f( const idCmdArgs &args ) {
	if ( !gameLocal.isMultiplayer || gameLocal.isClient ) {
		common->Printf( "server is not running\n" );
		return;
	}

	gameLocal.NextMap( );
	// next map was either voted for or triggered by a server command - always restart
	gameLocal.MapRestart( );
}

/*
===================
idGameLocal::MapPopulate
===================
*/
void idGameLocal::MapPopulate() {


// jnewquist: Tag scope and callees to track allocations using "new".
	MEM_SCOPED_TAG(tag,MA_ENTITY);


	/*if ( isMultiplayer ) {
		cvarSystem->SetCVarBool( "r_skipSpecular", false );
	}*/

	// parse the key/value pairs and spawn entities
	gameState_t currentState = gameLocal.GameState();
	
	if( currentState != GAMESTATE_STARTUP ) {
		gameLocal.SetGameState( GAMESTATE_RESTART );
	}
	SpawnMapEntities();
	if( currentState != GAMESTATE_STARTUP ) {
		gameLocal.SetGameState( currentState );
	}

	// mark location entities in all connected areas
	SpreadLocations();

	
	// ddynerman: prepare the list of spawn spots
	InitializeSpawns();
	

	// execute pending events before the very first game frame
	// this makes sure the map script main() function is called
	// before the physics are run so entities can bind correctly
	Printf( "------------ Processing events --------------\n" );
	idEvent::ServiceEvents();
}

/*
===================
idGameLocal::InitFromNewMap
===================
*/
void idGameLocal::InitFromNewMap( const char *mapName, idRenderWorld *renderWorld, bool isServer, bool isClient, int randseed ) {

	TIME_THIS_SCOPE( __FUNCLINE__);
	
	this->isServer = isServer;
	this->isClient = isClient;

// ddynerman: listen server
	this->isListenServer = isServer && !cvarSystem->GetCVarBool( "net_serverDedicated" );

	this->isMultiplayer = isServer || isClient;

	if ( mapFileName.Length() ) {
		MapShutdown();
	}

	Printf( "-------------- Game Map Init ----------------\n" );

	gamestate = GAMESTATE_STARTUP;

	gameRenderWorld = renderWorld;


// mwhitlock: Dynamic memory consolidation
#if defined(_RV_MEM_SYS_SUPPORT)
	animationLib->BeginLevelLoad();
#endif

	SetGameType( mapName );

	InitLoadingGUI( gameLocal.gameType, gameLocal.mapInfo );

	LoadMap( mapName, randseed );

	//SetGameType( mapName );

	// <q4f> 

	tfGame.Startup();

	cvarSystem->SetCVarInteger( "r_lightdetaillevel", 0 );

	// </q4f>

	InitScriptForMap();

	MapPopulate();

	mpGame.Reset();

	mpGame.Precache();

	gameLocal.UpdateLights( q4f_lightDetailLevel.GetFloat(), q4f_ambientLighting.GetBool() );

// mwhitlock: Dynamic memory consolidation
#if defined(_RV_MEM_SYS_SUPPORT)
	animationLib->EndLevelLoad();
#endif


	// free up any unused animations

// jsinger: animationLib changed to a pointer
	animationLib->FlushUnusedAnims();

	if ( q4f_execMapConfigs.GetBool() ) {
		cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "exec config/maps/%s.cfg", mapFileNameStripped.c_str() ) );
	}

	gamestate = GAMESTATE_ACTIVE;

	Printf( "---------------------------------------------\n" );
}

void idGameLocal::InitLoadingGUI( int gameType, q4fMapInfo &mapInfo ) {
	idUserInterface* loader = uiManager->FindGui( "guis/loading/mplevel.gui", false, true, true );

	if ( loader ) {

		idStr mapName = mapInfo.GetMapLongName();
		if ( !mapName[0] ) {
			mapName = serverInfo.GetString( "si_map", "map" );
			mapName.StripFileExtension();
			mapName.StripPath();
		}

		int capLimit = serverInfo.GetInt( "si_scorelimit", "99" );

		if ( capLimit > 0 ) {
			loader->SetStateString( "caplimit", va( "Score limit: %d", capLimit ) );
		}
		else {
			loader->SetStateString( "caplimit", "No capture limit" );
		}
		loader->SetStateString( "mapandgame", va( "%s - %s", mapName.c_str(), mapInfo.GetGameTypeLongName( gameType ) ) );

		loader->SetStateString( "gamedesc", mapInfo.GetGameTypeDesc( gameType ) );
		loader->SetStateBool( "loadstarted", true );


		if ( random.RandomFloat() > 0.5f ) {
			loader->SetStateFloat( "teamcolor_x", 0.2f );
			loader->SetStateFloat( "teamcolor_y", 0.2f );
			loader->SetStateFloat( "teamcolor_z", 0.9f );
		}
		else {
			loader->SetStateFloat( "teamcolor_x", 0.9f );
			loader->SetStateFloat( "teamcolor_y", 0.0f );
			loader->SetStateFloat( "teamcolor_z", 0.1f );
		}

		loader->StateChanged( gameLocal.time, true );
	}
}

/*
=================
idGameLocal::InitFromSaveGame
=================
*/
bool idGameLocal::InitFromSaveGame( const char *mapName, idRenderWorld *renderWorld, idFile *saveGameFile ) {
	TIME_THIS_SCOPE( __FUNCLINE__);
	
	int i;
	int num;
	idEntity *ent;
	idDict si;

	if ( mapFileName.Length() ) {
		MapShutdown();
	}

	Printf( "---------- Game Map Init SaveGame -----------\n" );

	gamestate = GAMESTATE_STARTUP;

	gameRenderWorld = renderWorld;

	idRestoreGame savegame( saveGameFile );

	savegame.ReadBuildNumber();

	// Create the list of all objects in the game
	savegame.CreateObjects();

	// Load the idProgram, also checking to make sure scripting hasn't changed since the savegame
	if ( program.Restore( &savegame ) == false ) {

		// Abort the load process, and let the session know so that it can restart the level
		// with the player persistent data.
		savegame.DeleteObjects();
		program.Restart();

		return false;
	}

	// load the map needed for this savegame
	LoadMap( mapName, 0 );

	// precache any media specified in the map
	for ( i = 0; i < mapFile->GetNumEntities(); i++ ) {
		idMapEntity *mapEnt = mapFile->GetEntity( i );

		if ( !InhibitEntitySpawn( mapEnt->epairs ) ) {
			CacheDictionaryMedia( &mapEnt->epairs );
			const char *classname = mapEnt->epairs.GetString( "classname" );
			if ( classname != '\0' ) {
				FindEntityDef( classname, false );
			}
		}
	}

	savegame.ReadDict( &si );
	SetServerInfo( si );

	savegame.ReadInt( numClients );
	for( i = 0; i < numClients; i++ ) {

// mekberg: don't read in userinfo. Grab from cvars
//		savegame.ReadDict( &userInfo[ i ] );

//		savegame.ReadUsercmd( usercmds[ i ] );
		savegame.ReadDict( &persistentPlayerInfo[ i ] );
	}

	for( i = 0; i < MAX_GENTITIES; i++ ) {
		savegame.ReadObject( reinterpret_cast<idClass *&>( entities[ i ] ) );
		savegame.ReadInt( spawnIds[ i ] );

		// restore the entityNumber
		if ( entities[ i ] != NULL ) {
			entities[ i ]->entityNumber = i;
		}
	}

	// Precache the player

// bdube: changed so we actually cache stuff
	FindEntityDef ( idPlayer::GetSpawnClassname ( ) );

// abahr: saving clientEntities
	for( i = 0; i < MAX_CENTITIES; i++ ) {
		savegame.ReadObject( reinterpret_cast<idClass *&>( clientEntities[ i ] ) );
		savegame.ReadInt( clientSpawnIds[ i ] );

		// restore the entityNumber
		if ( clientEntities[ i ] != NULL ) {
			clientEntities[ i ]->entityNumber = i;
		}
	}


	savegame.ReadInt( firstFreeIndex );
	savegame.ReadInt( num_entities );

	// enityHash is restored by idEntity::Restore setting the entity name.

	savegame.ReadObject( reinterpret_cast<idClass *&>( world ) );

	savegame.ReadInt( num );
	for( i = 0; i < num; i++ ) {
		savegame.ReadObject( reinterpret_cast<idClass *&>( ent ) );
		assert( ent );
		if ( ent ) {
			ent->spawnNode.AddToEnd( spawnedEntities );
		}
	}


// abahr: save scriptObject proxies
	savegame.ReadInt( num );
	scriptObjectProxies.SetNum( num );
	for( i = 0; i < num; ++i ) {
		scriptObjectProxies[i].Restore( &savegame );
	}
// abahr: save client entity stuff
	rvClientEntity* clientEnt = NULL;
	savegame.ReadInt( num );
	for( i = 0; i < num; ++i ) {
		savegame.ReadObject( reinterpret_cast<idClass *&>( clientEnt ) );
		assert( clientEnt );
		if ( clientEnt  ) {
			clientEnt->spawnNode.AddToEnd( clientSpawnedEntities );
		}
	}


	savegame.ReadInt( num );
	for( i = 0; i < num; i++ ) {
		savegame.ReadObject( reinterpret_cast<idClass *&>( ent ) );
		assert( ent );
		if ( ent ) {
			ent->activeNode.AddToEnd( activeEntities );
		}
	}

	savegame.ReadInt( numEntitiesToDeactivate );
	savegame.ReadBool( sortPushers );
	savegame.ReadBool( sortTeamMasters );

	for( i = 0; i < MAX_GLOBAL_SHADER_PARMS; i++ ) {
		savegame.ReadFloat( globalShaderParms[ i ] );
	}

	savegame.ReadInt( i );
	random.SetSeed( i );

	savegame.ReadObject( reinterpret_cast<idClass *&>( frameCommandThread ) );

	// clip
	// push
	// pvs

	// testmodel = "<NULL>"
	// testFx = "<NULL>"

	savegame.ReadString( sessionCommand );

	// FIXME: save smoke particles

	savegame.ReadInt( cinematicSkipTime );
	savegame.ReadInt( cinematicStopTime );
	savegame.ReadInt( cinematicMaxSkipTime );
	savegame.ReadBool( inCinematic );
	savegame.ReadBool( skipCinematic );

	savegame.ReadBool( isMultiplayer );
//	savegame.ReadInt( (int &)gameType );

	savegame.ReadInt( framenum );
	savegame.ReadInt( previousTime );
	savegame.ReadInt( time );

	savegame.ReadInt( vacuumAreaNum );

	savegame.ReadInt( entityDefBits );
	savegame.ReadBool( isServer );
	savegame.ReadBool( isClient );

	savegame.ReadBool( isListenServer );


	savegame.ReadInt( localClientNum );

	// snapshotEntities is used for multiplayer only

	savegame.ReadInt( realClientTime );
	savegame.ReadBool( isNewFrame );

	savegame.ReadBool( mapCycleLoaded );
	savegame.ReadInt( spawnCount );

	/*savegame.ReadInt( num );
	if ( num ) {
		if ( num != gameRenderWorld->NumAreas() ) {
			savegame.Error( "idGameLocal::InitFromSaveGame: number of areas in map differs from save game." );
		}

		locationEntities = new idLocationEntity *[ num ];
		for( i = 0; i < num; i++ ) {
			savegame.ReadObject( reinterpret_cast<idClass *&>( locationEntities[ i ] ) );
		}
	}*/

	savegame.ReadObject( reinterpret_cast<idClass *&>( camera ) );

	savegame.ReadMaterial( globalMaterial );


// bdube: added
	lastAIAlertEntity.Restore( &savegame );
	savegame.ReadInt( lastAIAlertEntityTime );
	lastAIAlertActor.Restore( &savegame );
	savegame.ReadInt( lastAIAlertActorTime );


	savegame.ReadDict( &spawnArgs );

	savegame.ReadInt( playerPVS.i );
	savegame.ReadInt( (int &)playerPVS.h );
	savegame.ReadInt( playerConnectedAreas.i );
	savegame.ReadInt( (int &)playerConnectedAreas.h );

	savegame.ReadVec3( gravity );

	// gamestate is restored after restoring everything else

	savegame.ReadBool( influenceActive );

	// spawnSpots
	// initialSpots
	// currentInitialSpot
	// newInfo
	// makingBuild
	// shakeSounds

	// Read out pending events
	idEvent::Restore( &savegame );

	savegame.RestoreObjects();

	mpGame.Reset();

	mpGame.Precache();

	// free up any unused animations

// jsinger: animationLib changed to a pointer
	animationLib->FlushUnusedAnims();


	gamestate = GAMESTATE_ACTIVE;

	Printf( "--------------------------------------\n" );

	return true;
}

/*
===========
idGameLocal::MapClear
===========
*/

void idGameLocal::MapClear( bool clearClients ) {

	int i;


// bdube: delete client entities first since they reference real entities
	for( i = 0; i < MAX_CENTITIES; i++ ) {
		delete clientEntities[ i ];
		clientEntities[ i ] = NULL;
		clientSpawnIds[ i ] = -1;
	}


	for( i = ( clearClients ? 0 : MAX_CLIENTS ); i < MAX_GENTITIES; i++ ) {

		//if ( entities[i] )
		delete entities[ i ];
		// ~idEntity is in charge of setting the pointer to NULL
		// it will also clear pending events for this entity
		assert( !entities[ i ] );

// see FIXME in idRestoreGame::Error
		entities[ i ] = NULL;

		spawnIds[ i ] = -1;
	}

	entityHash.Clear( 1024, MAX_GENTITIES );
	spawnedEntities.Clear();

	if ( !clearClients ) {
		for ( i = 0; i < MAX_GENTITIES; i++ ) {
			if ( !entities[ i ] ) {
				continue;
			}
			entityHash.Add( entityHash.GenerateKey( entities[ i ]->name.c_str(), true ), i );
			entities[ i ]->spawnNode.AddToEnd( spawnedEntities );
		}
	}


// jscott: clear out portal skies
	portalSky = NULL;
// abahr:
	gravityInfo.Clear();
	scriptObjectProxies.Clear();


	delete frameCommandThread;
	frameCommandThread = NULL;

	if ( editEntities ) {
		delete editEntities;
		editEntities = NULL;
	}

	delete[] locationEntities;
	locationEntities = NULL;
	

// ddynerman: mp clear
	//if( gameLocal.isMultiplayer ) {
		spawnSpots.Clear();
		mpGame.ClearMap();
	//}
	ambientLights.Clear();
	nonAmbientLights.Clear();
	nonAmibentLightCount = 0;
	waterEnts.Clear();
}

/*
===========
idGameLocal::MapShutdown
============
*/
void idGameLocal::MapShutdown( void ) {
	Printf( "------------ Game Map Shutdown --------------\n" );
	
	gamestate = GAMESTATE_SHUTDOWN;

	Printf( "Clearing mplevel gui...\n" );

	idUserInterface* loader = uiManager->FindGui( "guis/loading/mplevel.gui", false, true, true );
	if ( loader ) {
		loader->SetStateBool( "loadstarted", false );
		loader->StateChanged( gameLocal.time, true );
	}

	if ( soundSystem ) {
		qqq( "soundSystem->ResetListener()...." );
		soundSystem->ResetListener();
	}


	qqq( "Shutting down special effects..." );
// rjohnson: new blur special effect
	renderSystem->ShutdownSpecialEffects();

	// clear out camera if we're in a cinematic
	if ( inCinematic ) {
		camera = NULL;
		inCinematic = false;
	}

	qqq( "Shutting down playbacks" );

// jscott: cleanup playbacks
	gameEdit->ShutdownPlaybacks();

	qqq( "Beginning Mapclear" );

	MapClear( true );

	qqq ( "ClearEventList" );

// jscott: make sure any spurious events are killed
	idEvent::ClearEventList();

	qqq ( "Restart program" );

	// reset the script to the state it was before the map was started
	program.Restart();

	qqq ( "shutdown gamedebug" );

// bdube: game debug
	gameDebug.Shutdown( );

	qqq ( "shutdown gameLog" );

	gameLogLocal.Shutdown( );

	qqq ( "shutdown iconmanager" );

	iconManager->Shutdown();

	qqq ( "shutdown pvs" );

	pvs.Shutdown();

	if( gamestate != GAMESTATE_UNINITIALIZED ) {

		qqq ( "shutdown clip" );

		clip.Shutdown();

		qqq ( "free default clip model" );

		idClip::FreeDefaultClipModel();
	}

// mwhitlock: Dynamic memory consolidation

	qqq ( "Clear trace model cache" );

	idClipModel::ClearTraceModelCache();


// mwhitlock: Dynamic memory consolidation
#if defined(_RV_MEM_SYS_SUPPORT)
	qqq ( "Clear force list" );
	idForce::ClearForceList();
#endif

	qqq ( "shut down async" );

	ShutdownAsyncNetwork();

	mapFileName.Clear();

	gameRenderWorld = NULL;

	gamestate = GAMESTATE_NOMAP;

	// <q4f> 

	qqq ( "shut down tfgame" );

	tfGame.ShutDown();

	// </q4f>

	Printf( "---------------------------------------------\n" );
}

/*
===================
idGameLocal::DumpOggSounds
===================
*/
void idGameLocal::DumpOggSounds( void ) {
	int i, j, k, size, totalSize;
	idFile *file;
	idStrList oggSounds, weaponSounds;
	const idSoundShader *soundShader;
	const soundShaderParms_t *parms;
	idStr soundName;

	for ( i = 0; i < declManager->GetNumDecls( DECL_SOUND ); i++ ) {
		soundShader = static_cast<const idSoundShader *>(declManager->DeclByIndex( DECL_SOUND, i, false ));
		parms = soundShader->GetParms();

		if ( soundShader->EverReferenced() && soundShader->GetState() != DS_DEFAULTED ) {

			const_cast<idSoundShader *>(soundShader)->EnsureNotPurged();

			for ( j = 0; j < soundShader->GetNumSounds(); j++ ) {
				soundName = soundShader->GetSound( j );
				soundName.BackSlashesToSlashes();

				// don't OGG sounds that cause a shake because that would
				// cause continuous seeking on the OGG file which is expensive
				if ( parms->shakes != 0.0f ) {
					shakeSounds.AddUnique( soundName );
					continue;
				}

				// if not voice over or combat chatter
				if (	soundName.Find( "/vo/", false ) == -1 &&
						soundName.Find( "/combat_chatter/", false ) == -1 &&
						soundName.Find( "/bfgcarnage/", false ) == -1 &&
						soundName.Find( "/enpro/", false ) == - 1 &&
						soundName.Find( "/soulcube/energize_01.wav", false ) == -1 ) {
					// don't OGG weapon sounds
					if (	soundName.Find( "weapon", false ) != -1 ||
							soundName.Find( "gun", false ) != -1 ||
							soundName.Find( "bullet", false ) != -1 ||
							soundName.Find( "bfg", false ) != -1 ||
							soundName.Find( "plasma", false ) != -1 ) {
						weaponSounds.AddUnique( soundName );
						continue;
					}
				}

				for ( k = 0; k < shakeSounds.Num(); k++ ) {
					if ( shakeSounds[k].IcmpPath( soundName ) == 0 ) {
						break;
					}
				}
				if ( k < shakeSounds.Num() ) {
					continue;
				}

				oggSounds.AddUnique( soundName );
			}
		}
	}

	file = fileSystem->OpenFileWrite( "makeogg.bat", "fs_savepath" );
	if ( file == NULL ) {
		common->Warning( "Couldn't open makeogg.bat" );
		return;
	}

	// list all the shake sounds
	totalSize = 0;
	for ( i = 0; i < shakeSounds.Num(); i++ ) {
		size = fileSystem->ReadFile( shakeSounds[i], NULL, NULL );
		totalSize += size;
		shakeSounds[i].Replace( "/", "\\" );
		file->Printf( "echo \"%s\" (%d kB)\n", shakeSounds[i].c_str(), size >> 10 );
	}
	file->Printf( "echo %d kB in shake sounds\n\n\n", totalSize >> 10 );

	// list all the weapon sounds
	totalSize = 0;
	for ( i = 0; i < weaponSounds.Num(); i++ ) {
		size = fileSystem->ReadFile( weaponSounds[i], NULL, NULL );
		totalSize += size;
		weaponSounds[i].Replace( "/", "\\" );
		file->Printf( "echo \"%s\" (%d kB)\n", weaponSounds[i].c_str(), size >> 10 );
	}
	file->Printf( "echo %d kB in weapon sounds\n\n\n", totalSize >> 10 );

	// list commands to convert all other sounds to ogg
	totalSize = 0;
	for ( i = 0; i < oggSounds.Num(); i++ ) {

// rjohnson: changed path to raven's directories
// jnewquist: Use filesystem search path to get absolute file path
		idStr	tempFile;
		idFile *f = fileSystem->OpenFileRead( oggSounds[i] );
		if ( !f ) {
			continue;
		}
		size = f->Length();
		totalSize += size;
		tempFile = f->GetFullPath();
		fileSystem->CloseFile(f);
		f = NULL;
		tempFile.Replace( "/", "\\" );

// jnewquist: prevent alterations to files relative to cdpath
		const char *cdPath = cvarSystem->GetCVarString("fs_cdpath");
		const int cdPathLen = idStr::Length(cdPath);
		if ( cdPathLen > 0 && idStr::Icmpn(cdPath, tempFile, cdPathLen) == 0 ) {
			file->Printf( "rem Ignored file from CD path: %s\n", tempFile.c_str() );
			continue;
		}

		file->Printf( "echo %d / %d\n", i, oggSounds.Num() );
		file->Printf( "k:\\utility\\oggenc -q 0 \"%s\"\n", tempFile.c_str() );
		file->Printf( "del \"%s\"\n", tempFile.c_str() );

	}
	file->Printf( "\n\necho %d kB in OGG sounds\n\n\n", totalSize >> 10 );

	fileSystem->CloseFile( file );

	shakeSounds.Clear();
}

/*
===================
idGameLocal::GetShakeSounds
===================
*/
void idGameLocal::GetShakeSounds( const idDict *dict ) {
	const idSoundShader *soundShader;
	const char *soundShaderName;
	idStr soundName;

	soundShaderName = dict->GetString( "s_shader" );
	if ( soundShaderName != '\0' && dict->GetFloat( "s_shakes" ) != 0.0f ) {
		soundShader = declManager->FindSound( soundShaderName );

		for ( int i = 0; i < soundShader->GetNumSounds(); i++ ) {
			soundName = soundShader->GetSound( i );
			soundName.BackSlashesToSlashes();

			shakeSounds.AddUnique( soundName );
		}
	}
}

/*
===================
idGameLocal::CacheDictionaryMedia

This is called after parsing an EntityDef and for each entity spawnArgs before
merging the entitydef.  It could be done post-merge, but that would
avoid the fast pre-cache check associated with each entityDef
===================
*/
void idGameLocal::CacheDictionaryMedia( const idDict *dict ) {
	idDict spawnerArgs;
	
	TIME_THIS_SCOPE( __FUNCLINE__);

	if ( dict == NULL ) {
		if ( cvarSystem->GetCVarBool( "com_makingBuild") ) {
			DumpOggSounds();
		}
		return;
	}

	if ( cvarSystem->GetCVarBool( "com_makingBuild" ) ) {
		GetShakeSounds( dict );
	}

//	const idDeclEntityDef* cacheDef;

	int numVals = dict->GetNumKeyVals();
	
	for ( int i = 0; i < numVals; ++i ) {
		const idKeyValue *kv = dict->GetKeyVal( i );
		
		#define MATCH(s) \
			(!kv->GetKey().Icmpn( s, strlen(s) ))
		/**/
		
		if ( !kv || !kv->GetValue().Length() ) {
			continue;
		}
		
		if ( MATCH( "model" ) ) {
			
			TIME_THIS_SCOPE( __FUNCLINE__);
			
			MEM_SCOPED_TAG(tag,MA_MODEL);
			declManager->MediaPrint( "Precaching model %s\n", kv->GetValue().c_str() );
			// precache model/animations
			if ( declManager->FindType( DECL_MODELDEF, kv->GetValue(), false ) == NULL ) {
				// precache the render model
				renderModelManager->FindModel( kv->GetValue() );
				// precache .cm files only
				collisionModelManager->PreCacheModel( GetMapName(), kv->GetValue() );
			}
		} else if ( MATCH( "s_shader" ) ) {
			
			TIME_THIS_SCOPE( __FUNCLINE__);
			
			MEM_SCOPED_TAG(tag,MA_SOUND);
			declManager->FindType( DECL_SOUND, kv->GetValue() );
		} else if ( MATCH( "snd_" ) ) {
			
			TIME_THIS_SCOPE( __FUNCLINE__);
			
			MEM_SCOPED_TAG(tag,MA_SOUND);
			declManager->FindType( DECL_SOUND, kv->GetValue() );
		} else if ( MATCH( "gui_" ) ) {
			
			TIME_THIS_SCOPE( __FUNCLINE__);
			
			MEM_SCOPED_TAG(tag,MA_GUI);
			if ( !idStr::Icmp( kv->GetKey(), "gui_noninteractive" )
				|| !idStr::Icmpn( kv->GetKey(), "gui_parm", 8 )	
				|| !idStr::Icmp( kv->GetKey(), "gui_inventory" ) ) {
				// unfortunate flag names, they aren't actually a gui
			} else {
				declManager->MediaPrint( "Precaching gui %s\n", kv->GetValue().c_str() );
				uiManager->FindGui( kv->GetValue().c_str(), true );
			}
		} else if ( MATCH( "texture" ) ) {
			
			TIME_THIS_SCOPE( __FUNCLINE__);
			
			MEM_SCOPED_TAG(tag,MA_MATERIAL);
			declManager->FindType( DECL_MATERIAL, kv->GetValue() );
		} else if ( MATCH( "mtr_" ) ) {
			
			TIME_THIS_SCOPE( __FUNCLINE__);
			
			MEM_SCOPED_TAG(tag,MA_MATERIAL);
			declManager->FindType( DECL_MATERIAL, kv->GetValue() );
		} else if ( MATCH( "screenShot" ) ) {
		
			TIME_THIS_SCOPE( __FUNCLINE__);
			
			MEM_SCOPED_TAG(tag,MA_MATERIAL);
			declManager->FindType( DECL_MATERIAL, kv->GetValue() );
		} else if ( MATCH( "inv_icon" ) ) {
			
			TIME_THIS_SCOPE( __FUNCLINE__);
			
			MEM_SCOPED_TAG(tag,MA_MATERIAL);
			declManager->FindType( DECL_MATERIAL, kv->GetValue() );
		} else if ( MATCH( "teleport" ) ) {
			
			TIME_THIS_SCOPE( __FUNCLINE__);
			
			MEM_SCOPED_TAG(tag,MA_EFFECT);
			int teleportType = atoi( kv->GetValue() );
			const char *p = ( teleportType ) ? va( "effects/teleporter%i.fx", teleportType ) : "effects/teleporter.fx";
			declManager->FindType( DECL_EFFECT, p );
		} else if ( MATCH( "fx_" ) ) {
			
			TIME_THIS_SCOPE( __FUNCLINE__);
			
			MEM_SCOPED_TAG(tag,MA_EFFECT);
			declManager->MediaPrint( "Precaching fx %s\n", kv->GetValue().c_str() );
			declManager->FindEffect( kv->GetValue() );
		} else if ( MATCH( "skin" ) ) {
			
			TIME_THIS_SCOPE( __FUNCLINE__);
			
			MEM_SCOPED_TAG(tag,MA_MATERIAL);
			declManager->MediaPrint( "Precaching skin %s\n", kv->GetValue().c_str() );
			declManager->FindType( DECL_SKIN, kv->GetValue() );
		} else if ( MATCH( "def_" ) ) {
			
			TIME_THIS_SCOPE( __FUNCLINE__);
			
			MEM_SCOPED_TAG(tag,MA_DECL);
			/*cacheDef = FindEntityDef( kv->GetValue().c_str(), false );
			if ( cacheDef ) {
				CacheDictionaryMedia( &(cacheDef->dict) );
			}*/
			FindEntityDef( kv->GetValue().c_str(), false );
		} else if ( MATCH( "playback_" ) ) {
			
			TIME_THIS_SCOPE( __FUNCLINE__);
			
			MEM_SCOPED_TAG(tag,MA_ANIM);
			declManager->MediaPrint( "Precaching playback %s\n", kv->GetValue().c_str() );
			declManager->FindPlayback( kv->GetValue() );
		} else if ( MATCH( "lipsync_" ) ) {
			
			TIME_THIS_SCOPE( __FUNCLINE__);
			
			MEM_SCOPED_TAG(tag,MA_ANIM);
			declManager->MediaPrint( "Precaching lipsync %s\n", kv->GetValue().c_str() );
			declManager->FindLipSync( kv->GetValue() );
			declManager->FindSound ( kv->GetValue() );
		} else if ( MATCH( "icon " ) ) {
			
			TIME_THIS_SCOPE( __FUNCLINE__);
			
			MEM_SCOPED_TAG(tag,MA_MATERIAL);
			idLexer  src ( LEXFL_ALLOWPATHNAMES );
			idToken  token;
			idToken	 token2;
			src.LoadMemory( kv->GetValue(), kv->GetValue().Length(), "icon" );
			
			src.ReadToken ( &token );
			if ( src.CheckTokenString ( "," ) ) {
				int x, y, w, h;
				src.ReadToken ( &token2 ) ;
				x = token2.GetIntValue ( );
				src.ExpectTokenString ( "," );
				
				src.ReadToken ( &token2 ) ;
				y = token2.GetIntValue ( );
				src.ExpectTokenString ( "," );

				src.ReadToken ( &token2 ) ;
				w = token2.GetIntValue ( );
				src.ExpectTokenString ( "," );

				src.ReadToken ( &token2 ) ;
				h = token2.GetIntValue ( );
				
				uiManager->RegisterIcon ( kv->GetKey ( ).c_str() + 5, token, x, y, w, h );
			} else { 
				uiManager->RegisterIcon ( kv->GetKey ( ).c_str() + 5, token );
			}
		} else if ( MATCH( "spawn_" ) ) {
			
			TIME_THIS_SCOPE( __FUNCLINE__);
			
			MEM_SCOPED_TAG(tag,MA_DECL);
			spawnerArgs.Set ( kv->GetKey ( ).c_str() + 6, kv->GetValue ( ) );
		}
		
		#undef MATCH
	}

	if ( spawnerArgs.GetNumKeyVals() ) {
		CacheDictionaryMedia ( &spawnerArgs );
	}

}

/*
===========
idGameLocal::InitScriptForMap
============
*/
void idGameLocal::InitScriptForMap( void ) {


// jnewquist: Tag scope and callees to track allocations using "new".
	MEM_SCOPED_TAG(tag,MA_DEFAULT);

	// create a thread to run frame commands on
	frameCommandThread = new idThread();
	frameCommandThread->ManualDelete();
	frameCommandThread->SetThreadName( "frameCommands" );


// jnewquist: Tag scope and callees to track allocations using "new".
	MEM_SCOPED_TAG_SET(tag,MA_SCRIPT);

	// run the main game script function (not the level specific main)
	const function_t *func = program.FindFunction( SCRIPT_DEFAULTFUNC );


// jnewquist: Tag scope and callees to track allocations using "new".
	MEM_SCOPED_TAG_SET(tag,MA_DEFAULT);

	if ( func != NULL ) {
		idThread *thread = new idThread( func );
		if ( thread->Start() ) {
			// thread has finished executing, so delete it
			delete thread;
		}
	}



}

/*
===========
idGameLocal::SpawnPlayer
============
*/
void idGameLocal::SpawnPlayer( int clientNum ) {

	idEntity	*ent;
	idDict		args;

	// they can connect
	common->DPrintf( "SpawnPlayer: %i\n", clientNum );

	args.SetInt( "spawn_entnum", clientNum );
	args.Set( "name", va( "player%d", clientNum + 1 ) );

	args.Set( "classname", "q4f_pc_base" );

	// This takes a really long time.
	if ( !SpawnEntityDef( args, &ent ) || !entities[ clientNum ] ) {
		Error( "Failed to spawn player as '%s'", args.GetString( "classname" ) );
	}

// jnewquist: Use accessor for static class type 
	if ( !ent->IsType( idPlayer::GetClassType() ) ) {
		Error( "'%s' spawned the player as a '%s'.  Player spawnclass must be a subclass of idPlayer.", args.GetString( "classname" ), ent->GetClassname() );
	}

	gameLocal.Printf( "Spawnplayer - Start: clientNum is %d, numClients is %d\n", clientNum, numClients );

	if ( clientNum >= numClients ) {
		numClients = clientNum + 1;
	}

	gameLocal.Printf( "Spawnplayer - End: clientNum is %d, numClients is %d\n", clientNum, numClients );

	tfStatManager->ClientConnect( static_cast<idPlayer*>(ent) );

	mpGame.SpawnPlayer( clientNum );
}

/*
================
idGameLocal::GetClientByNum
================
*/
idPlayer *idGameLocal::GetClientByNum( int current ) const {
	if ( current == MAX_CLIENTS ) {
		return NULL;
	}
	if ( current < 0 || current >= numClients ) {
		// that's a bit nasty but I suppose it has it's use
		current = 0;
	}
	if ( entities[current] ) {
		return static_cast<idPlayer *>( entities[ current ] );
	}
	return NULL;
}

/*
================
idGameLocal::GetClientByName
================
*/
idPlayer *idGameLocal::GetClientByName( const char *name ) const {
	int i;
	idEntity *ent;
	for ( i = 0 ; i < numClients ; i++ ) {
		ent = entities[ i ];

// jnewquist: Use accessor for static class type 
		if ( ent && ent->IsType( idPlayer::GetClassType() ) ) {


// bdube: escape codes
			if ( idStr::IcmpNoEscape( name, userInfo[ i ].GetString( "ui_name" ) ) == 0 ) {
			
				return static_cast<idPlayer *>( ent );
			}
		}
	}
	return NULL;
}

/*
================
idGameLocal::GetClientByCmdArgs
================
*/
idPlayer *idGameLocal::GetClientByCmdArgs( const idCmdArgs &args ) const {
	idPlayer *player;
	idStr client = args.Argv( 1 );
	if ( !client.Length() ) {
		return NULL;
	}
	// we don't allow numeric ui_name so this can't go wrong
	if ( client.IsNumeric() ) {
		player = GetClientByNum( atoi( client.c_str() ) );
	} else {
		player = GetClientByName( client.c_str() );
	}
	if ( !player ) {
		common->Printf( "Player '%s' not found\n", client.c_str() );
	}
	return player;
}

/*
================
idGameLocal::GetClientNumByName
================
*/
int idGameLocal::GetClientNumByName( const char *name ) const {
	int i;
	idEntity *ent;
	for ( i = 0 ; i < numClients ; i++ ) {
		ent = entities[ i ];

		if ( ent && ent->IsType( idPlayer::GetClassType() ) ) {
			if ( idStr::IcmpNoEscape( name, userInfo[ i ].GetString( "ui_name" ) ) == 0 ) {
				return i;
			}
		}
	}
	return -1;
}

/*
================
idGameLocal::GetNextClientNum
================
*/
int idGameLocal::GetNextClientNum( int _current ) const {
	int i, current;

	current = 0;
	for ( i = 0; i < numClients; i++) {
		current = ( _current + i + 1 ) % numClients;

// jnewquist: Use accessor for static class type 
		if ( entities[ current ] && entities[ current ]->IsType( idPlayer::GetClassType() ) ) {

			return current;
		}
	}

	return current;
}

/*
================
idGameLocal::GetLocalPlayer

Nothing in the game tic should EVER make a decision based on what the
local client number is, it shouldn't even be aware that there is a
draw phase even happening.

localClientNum == MAX_CLIENTS when playing server demos
don't send back the wrong entity obviously
================
*/
idPlayer *idGameLocal::GetLocalPlayer() const {
	if ( localClientNum < 0 || localClientNum >= MAX_CLIENTS ) {
		return NULL;
	}


// jnewquist: Use accessor for static class type 
	if ( !entities[ localClientNum ] || !entities[ localClientNum ]->IsType( idPlayer::GetClassType() ) ) {

		// not fully in game yet
		return NULL;
	}
	return static_cast<idPlayer *>( entities[ localClientNum ] );
}

/*
================
idGameLocal::SetupClientPVS
for client spectating others, get the pvs of spectated
================
*/
pvsHandle_t idGameLocal::GetClientPVS( idPlayer *player, pvsType_t type ) {
	if ( player->GetPrivateCameraView() ) {
		return pvs.SetupCurrentPVS( player->GetPrivateCameraView()->GetPVSAreas(), player->GetPrivateCameraView()->GetNumPVSAreas() );
	} else if ( camera ) {
		return pvs.SetupCurrentPVS( camera->GetPVSAreas(), camera->GetNumPVSAreas() );
	} else {
		if ( player->spectating && player->spectator != player->entityNumber && entities[ player->spectator ] ) {
			player = static_cast<idPlayer*>( entities[ player->spectator ] );
		}
		return pvs.SetupCurrentPVS( player->GetPVSAreas(), player->GetNumPVSAreas() );
	}
}


// jscott: for portal skies
/*
================
idGameLocal::GetSpawnCount
================
*/
int idGameLocal::GetSpawnCount ( void ) const {
	return spawnCount;
}

/*
================
idGameLocal::SetupPortalSkyPVS
================
*/
bool idGameLocal::SetupPortalSkyPVS( idPlayer *player ) {

	int			i, count, numAreas;
	const int	*areaNums;
	bool		*visibleAreas;

	if( !portalSky ) {

		return( false );
	}

	// Allocate room for the area flags
	numAreas = gameRenderWorld->NumAreas();
	visibleAreas = ( bool * )_alloca( numAreas );
	memset( visibleAreas, 0, numAreas );

	// Grab the areas the player can see....
	count = player->GetNumPVSAreas();
	areaNums = player->GetPVSAreas();
	for( i = 0; i < count; i++ ) {

		// Work out the referenced areas
		gameRenderWorld->FindVisibleAreas( player->GetPhysics()->GetOrigin(), areaNums[i], visibleAreas );
	}

	// Do any of the visible areas have a skybox?
	for( i = 0; i < numAreas; i++ ) {

		if( !visibleAreas[i] ) {

			continue;
		}

		if( gameRenderWorld->HasSkybox( i ) ) {

			break;
		}
	}

	// .. if any one has a skybox component, then merge in the portal sky
	return ( i != numAreas );
}


/*
===============
idGameLocal::UpdateClientsPVS
===============
*/
void idGameLocal::UpdateClientsPVS( void ) {
	int i;
	for ( i = 0; i < numClients; i++ ) {
		if ( !entities[ i ] ) {
			continue;
		}
		assert( clientsPVS[ i ].i == -1 );
		clientsPVS[ i ] = GetClientPVS( static_cast< idPlayer * >( entities[ i ] ), PVS_NORMAL );
	}
}

/*
================
idGameLocal::SetupPlayerPVS
================
*/
void idGameLocal::SetupPlayerPVS( void ) {
	int			i = 0;
	idPlayer *	player = NULL;
	pvsHandle_t	otherPVS, newPVS;

	UpdateClientsPVS( );

	playerPVS.i = -1;
	for ( i = 0; i < numClients; i++ ) {
		if ( !entities[i] ) {
			return;
		}
		assert( entities[i]->IsType( idPlayer::GetClassType() ) );

		player = static_cast<idPlayer *>( entities[ i ] );

		if ( playerPVS.i == -1 ) {
			playerPVS = clientsPVS[ i ];
			freePlayerPVS = false;	// don't try to free it as long as we stick to the client PVS
		} else {
			otherPVS = clientsPVS[ i ];
			newPVS = pvs.MergeCurrentPVS( playerPVS, otherPVS );
			if ( freePlayerPVS ) {
				pvs.FreeCurrentPVS( playerPVS );
				freePlayerPVS = false;
			}
			playerPVS = newPVS;
			freePlayerPVS = true;	// that merged one will need to be freed
		}


// jscott: for portal skies
		portalSkyVisible = SetupPortalSkyPVS( player );
		if ( portalSkyVisible ) {

			otherPVS = pvs.SetupCurrentPVS( portalSky->GetPVSAreas(), portalSky->GetNumPVSAreas() );
			newPVS = pvs.MergeCurrentPVS( playerPVS, otherPVS );

			if ( freePlayerPVS ) {
				pvs.FreeCurrentPVS( playerPVS );
				freePlayerPVS = false;
			}
			pvs.FreeCurrentPVS( otherPVS );
			playerPVS = newPVS;
			freePlayerPVS = true;
		}


		if ( playerConnectedAreas.i == -1 ) {
			playerConnectedAreas = GetClientPVS( player, PVS_CONNECTED_AREAS );
		} else {
			otherPVS = GetClientPVS( player, PVS_CONNECTED_AREAS );
			newPVS = pvs.MergeCurrentPVS( playerConnectedAreas, otherPVS );
			pvs.FreeCurrentPVS( playerConnectedAreas );
			pvs.FreeCurrentPVS( otherPVS );
			playerConnectedAreas = newPVS;
		}
	}
}

/*
================
idGameLocal::FreePlayerPVS
================
*/
void idGameLocal::FreePlayerPVS( void ) {
	int i;

	// only clear playerPVS if it's a different handle than the one in clientsPVS
	if ( freePlayerPVS && playerPVS.i != -1 ) {
		pvs.FreeCurrentPVS( playerPVS );
		freePlayerPVS = false;
	}
	playerPVS.i = -1;
	for ( i = 0; i < MAX_CLIENTS; i++ ) {
		if ( clientsPVS[ i ].i >= 0 ) {
			pvs.FreeCurrentPVS( clientsPVS[ i ] );
			clientsPVS[i].i = -1;
		}
	}
	if ( playerConnectedAreas.i != -1 ) {
		pvs.FreeCurrentPVS( playerConnectedAreas );
		playerConnectedAreas.i = -1;
	}
}

/*
================
idGameLocal::InPlayerPVS

  should only be called during entity thinking and event handling
================
*/
bool idGameLocal::InPlayerPVS( idEntity *ent ) const {
	if ( playerPVS.i == -1 ) {
		return false;
	}
    return pvs.InCurrentPVS( playerPVS, ent->GetPVSAreas(), ent->GetNumPVSAreas() );
}

/*
================
idGameLocal::InPlayerConnectedArea

  should only be called during entity thinking and event handling
================
*/
bool idGameLocal::InPlayerConnectedArea( idEntity *ent ) const {
	if ( playerConnectedAreas.i == -1 ) {
		return false;
	}
    return pvs.InCurrentPVS( playerConnectedAreas, ent->GetPVSAreas(), ent->GetNumPVSAreas() );
}


/*
================
idGameLocal::UpdateGravity
================
*/
void idGameLocal::UpdateGravity( void ) {
	idEntity *ent;
	
	idCVar* gravityCVar = NULL;

	gravityCVar = &g_gravity;

	if ( gravityCVar->IsModified() ) {
		if ( gravityCVar->GetFloat() == 0.0f ) {
			gravityCVar->SetFloat( 1.0f );
		}
        gravity.Set( 0, 0, -gravityCVar->GetFloat() );

		// update all physics objects
		for( ent = spawnedEntities.Next(); ent != NULL; ent = ent->spawnNode.Next() ) {

// jnewquist: Use accessor for static class type 
			if ( ent->IsType( idAFEntity_Generic::GetClassType() ) ) {

				idPhysics *phys = ent->GetPhysics();
				if ( phys ) {
					phys->SetGravity( gravity );
				}

// ddynerman: jump pads
			} else if ( ent->IsType( rvJumpPad::GetClassType() ) ) {
				ent->PostEventMS( &EV_FindTargets, 0 );
			}

		}
		gravityCVar->ClearModified();
	}
}

/*
================
idGameLocal::GetGravity
================
*/
const idVec3 &idGameLocal::GetGravity( void ) const {
	return gravity;
}

/*
================
idGameLocal::SortActiveEntityList

  Sorts the active entity list such that pushing entities come first,
  actors come next and physics team slaves appear after their master.
================
*/
void idGameLocal::SortActiveEntityList( void ) {
	idEntity *ent, *next_ent, *master, *part;

	// if the active entity list needs to be reordered to place physics team masters at the front
	if ( sortTeamMasters ) {
		// Sort bind masters first
		for ( ent = activeEntities.Next(); ent != NULL; ent = next_ent ) {
			next_ent = ent->activeNode.Next();
			for ( part = ent->GetBindMaster ( ); part; part = part->GetBindMaster ( ) ) {
				// Ensure we dont rerun the whole active entity list if our cached next_ent is one 
				// of the entities we are moving
				if ( next_ent == part ) {
					next_ent = next_ent->activeNode.Next();
					part = ent->GetBindMaster ( );
					continue;
				}
				part->activeNode.Remove();
				part->activeNode.AddToFront( activeEntities );												
			}
		}				
	
		for ( ent = activeEntities.Next(); ent != NULL; ent = next_ent ) {
			next_ent = ent->activeNode.Next();
			master = ent->GetTeamMaster();
			if ( master && master == ent ) {
				ent->activeNode.Remove();
				ent->activeNode.AddToFront( activeEntities );												
			}
		}
	}

	// if the active entity list needs to be reordered to place pushers at the front
	if ( sortPushers ) {

		for ( ent = activeEntities.Next(); ent != NULL; ent = next_ent ) {
			next_ent = ent->activeNode.Next();
			master = ent->GetTeamMaster();
			if ( !master || master == ent ) {
				// check if there is an actor on the team
				for ( part = ent; part != NULL; part = part->GetNextTeamEntity() ) {

// jnewquist: Use accessor for static class type 
					if ( part->GetPhysics()->IsType( idPhysics_Actor::GetClassType() ) ) {

						break;
					}
				}
				// if there is an actor on the team
				if ( part ) {
					ent->activeNode.Remove();
					ent->activeNode.AddToFront( activeEntities );
				}
			}
		}

		for ( ent = activeEntities.Next(); ent != NULL; ent = next_ent ) {
			next_ent = ent->activeNode.Next();
			master = ent->GetTeamMaster();
			if ( !master || master == ent ) {
				// check if there is an entity on the team using parametric physics
				for ( part = ent; part != NULL; part = part->GetNextTeamEntity() ) {
					if ( part->GetPhysics()->IsType( idPhysics_Parametric::GetClassType() ) ) {
						break;
					}
					if ( part->GetPhysics()->IsType( rvPhysics_Spline::GetClassType() ) ) {
						break;
					}
				}
				// if there is an entity on the team using parametric physics
				if ( part ) {
					ent->activeNode.Remove();
					ent->activeNode.AddToFront( activeEntities );
				}
			}
		}
	}

	sortTeamMasters = false;
	sortPushers = false;
}

/*
================
idGameLocal::MenuFrame
Called each session frame when a map is not running (e.g. usually in the main menu)
================
*/
void idGameLocal::MenuFrame( void ) { }

/*
================
idGameLocal::RunFrame
================
*/

gameReturn_t idGameLocal::RunFrame( const usercmd_t *clientCmds, int activeEditors, bool lastCatchupFrame ) {
	idEntity *	ent;
	int			num;
	float		ms;
	idTimer		timer_think, timer_events, timer_singlethink;
	idTimer		timer_misc, timer_misc2;
	gameReturn_t ret;
	idPlayer	*player;
	const renderView_t *view;

	editors = activeEditors;
	isLastPredictFrame = lastCatchupFrame;

	assert( !isClient );

	player = GetLocalPlayer();

	/*if ( !isMultiplayer && g_stopTime.GetBool() ) {

		// set the user commands for this frame
		usercmds = clientCmds;

		if ( player ) {
			player->Think();
		}
	} else */do {
		// update the game time
		framenum++;
		previousTime = time;
		// bdube: use GetMSec access rather than USERCMD_TIME
		time += GetMSec();

		realClientTime = time;
		{
			TIME_THIS_SCOPE("idGameLocal::RunFrame - gameDebug.BeginFrame()");
			// bdube: added advanced debug support
			gameDebug.BeginFrame( );
			gameLogLocal.BeginFrame( time );
		}

#ifdef GAME_DLL
		// allow changing SIMD usage on the fly
		if ( com_forceGenericSIMD.IsModified() ) {
			idSIMD::InitProcessor( "game", com_forceGenericSIMD.GetBool() );
		}
#endif

		// make sure the random number counter is used each frame so random events
		// are influenced by the player's actions
		random.RandomInt();

		if ( player ) {
			// update the renderview so that any gui videos play from the right frame
			view = player->GetRenderView();
			if ( view ) {
				gameRenderWorld->SetRenderView( view );
			}
		}

		// If modview is running then let it think
		common->ModViewThink( );	

		// rjohnson: added option for guis to always think
		common->RunAlwaysThinkGUIs( time );

		timer_misc.Start();
		
		// set the user commands for this frame
		usercmds = clientCmds;

		// create a merged pvs for all players
		// do this before we process events, which may rely on PVS info
		SetupPlayerPVS();

		// process events on the server
		ServerProcessEntityNetworkEventQueue();

		// update our gravity vector if needed.
		UpdateGravity();

		if ( isLastPredictFrame ) {
			// jscott: effect system uses gravity and the player PVS
			bse->StartFrame();
		}

		// sort the active entity list
		SortActiveEntityList();

		timer_think.Clear();
		timer_think.Start();

		// jscott: for timing and effect handling
		timer_misc2.Start();
		timer_misc.Stop();

		// let entities think
		if ( g_timeentities.GetFloat() ) {
			// rjohnson: will now draw entity info for long thinkers
			idPlayer *player;
			idVec3 origin;

			player = GetLocalPlayer();
			if ( player ) {
				origin = player->GetPhysics()->GetOrigin();
			}

			idBounds	viewTextBounds( origin );
			viewTextBounds.ExpandSelf( 128.0f );

			num = 0;

			for( ent = activeEntities.Next(); ent != NULL; ent = ent->activeNode.Next() ) {
				if ( g_cinematic.GetBool() && inCinematic && !ent->cinematic ) {
					ent->GetPhysics()->UpdateTime( time );
					continue;
				}
				timer_singlethink.Clear();
				timer_singlethink.Start();
				ent->Think();
				timer_singlethink.Stop();
				ms = timer_singlethink.Milliseconds();
				if ( ms >= g_timeentities.GetFloat() ) {
					// rjohnson: will now draw entity info for long thinkers
					Printf( "%d: entity '%s' [%s]: %.1f ms\n", time, ent->name.c_str(), ent->GetPhysics()->GetOrigin().ToString(), ms );

					if ( ms >= g_timeentities.GetFloat() * 3.0f )
					{
						ent->mLastLongThinkColor = colorRed;
					}
					else
					{
						ent->mLastLongThinkColor[0] = 1.0f;
						ent->mLastLongThinkColor[1] = 2.0f - (( ms - g_timeentities.GetFloat()) / g_timeentities.GetFloat() );
						ent->mLastLongThinkColor[2] = 0.0f;
						ent->mLastLongThinkColor[3] = 1.0f;
					}
					ent->DrawDebugEntityInfo( 0, &viewTextBounds, &ent->mLastLongThinkColor );
					ent->mLastLongThinkTime = time + 2000;
				}
				else if ( ent->mLastLongThinkTime > time )
				{
					ent->DrawDebugEntityInfo( 0, &viewTextBounds, &ent->mLastLongThinkColor );
				}
				num++;
			}
		} else {
			if ( inCinematic ) {
				num = 0;
				for( ent = activeEntities.Next(); ent != NULL; ent = ent->activeNode.Next() ) {
					if ( g_cinematic.GetBool() && !ent->cinematic ) {
						ent->GetPhysics()->UpdateTime( time );
						continue;
					}
					ent->Think();
					num++;
				}
			} else {
				num = 0;
				for( ent = activeEntities.Next(); ent != NULL; ent = ent->activeNode.Next() ) {
					ent->Think();
					num++;
				}
			}
		}

		// remove any entities that have stopped thinking
		if ( numEntitiesToDeactivate ) {
			idEntity *next_ent;
			int c = 0;
			for( ent = activeEntities.Next(); ent != NULL; ent = next_ent ) {
				next_ent = ent->activeNode.Next();
				if ( !ent->thinkFlags ) {
					ent->activeNode.Remove();
					c++;
				}
			}
			//assert( numEntitiesToDeactivate == c );
			numEntitiesToDeactivate = 0;
		}

		timer_think.Stop();
		timer_events.Clear();
		timer_events.Start();

		if ( isLastPredictFrame ) {
			// bdube: client entities
			rvClientEntity* cent;
			for( cent = clientSpawnedEntities.Next(); cent != NULL; cent = cent->spawnNode.Next() ) {
				cent->Think();			
			}	
		}

		// service any pending events
		idEvent::ServiceEvents();

		// nrausch: player could have been deleted in an event
		player = GetLocalPlayer();

		timer_events.Stop();

		if ( isLastPredictFrame ) {
			// jscott: effect system uses gravity and the player PVS
			bse->EndFrame();
		}

		// do multiplayer related stuff
		//if ( isMultiplayer ) {
			mpGame.Run();
		//}

		// free the player pvs
		FreePlayerPVS();

		// display how long it took to calculate the current game frame
		if ( g_frametime.GetBool() ) {
			Printf( "game %d: all:%.1f th:%.1f ev:%.1f %d ents \n",
				time, timer_think.Milliseconds() + timer_events.Milliseconds(),
				timer_think.Milliseconds(), timer_events.Milliseconds(), num );
		}

		// build the return value
		ret.consistencyHash = 0;
		ret.sessionCommand[0] = 0;

		/*if ( !isMultiplayer && player ) {
			ret.health = player->health;
			ret.heartRate = 0.0f;
			ret.stamina = 0.0f;
			// combat is a 0-100 value based on lastHitTime and lastDmgTime
			// each make up 50% of the time spread over 10 seconds
			ret.combat = 0;
			if ( player->lastDmgTime > 0 && time < player->lastDmgTime + 10000 ) {
				ret.combat += 50.0f * (float) ( time - player->lastDmgTime ) / 10000;
			}
			if ( player->lastHitTime > 0 && time < player->lastHitTime + 10000 ) {
				ret.combat += 50.0f * (float) ( time - player->lastHitTime ) / 10000;
			}
		}*/

		// see if a target_sessionCommand has forced a changelevel
		if ( sessionCommand.Length() ) {
			strncpy( ret.sessionCommand, sessionCommand, sizeof( ret.sessionCommand ) );
			sessionCommand = "";
			break;
		}

		// make sure we don't loop forever when skipping a cinematic
		if ( skipCinematic && ( time > cinematicMaxSkipTime ) ) {
			Warning( "Exceeded maximum cinematic skip length.  Cinematic may be looping infinitely." );
			skipCinematic = false;
			break;
		}

		// jscott: additional timings
		timer_misc2.Stop();

		if ( g_frametime.GetInteger() > 1 )  {
			gameLocal.Printf( "misc:%.1f misc2:%.1f\n", timer_misc.Milliseconds(), timer_misc2.Milliseconds() );
		}
		// bdube: let gameDebug know that its not in a game frame anymore
		gameDebug.EndFrame( );
		gameLogLocal.EndFrame( );

	} while( ( inCinematic || ( time < cinematicStopTime ) ) && skipCinematic );

	ret.syncNextGameFrame = skipCinematic;
	if ( skipCinematic ) {
		soundSystem->EndCinematic();
		soundSystem->SetMute( false );
		skipCinematic = false;		
	}

	// show any debug info for this frame
	RunDebugInfo();
	D_DrawDebugLines();

	return ret;
}



/*
======================================================================

  Game view drawing

======================================================================
*/

/*
====================
idGameLocal::CalcFov

Calculates the horizontal and vertical field of view based on a horizontal field of view and custom aspect ratio
====================
*/
void idGameLocal::CalcFov( float base_fov, float &fov_x, float &fov_y ) const {
	float	x;
	float	y;
	float	ratio_x;
	float	ratio_y;
	
	if ( !sys->FPU_StackIsEmpty() ) {
		Printf( sys->FPU_GetState() );
		Error( "idGameLocal::CalcFov: FPU stack not empty" );
	}


// jnewquist: Option to adjust vertical fov instead of horizontal for non 4:3 modes
	if ( g_fixedHorizFOV.GetBool() ) {
		int aspectChoice = cvarSystem->GetCVarInteger( "r_aspectRatio" );
		switch( aspectChoice ) {
		default :
		case 0 :
			// 4:3
			ratio_x = 4.0f;
			ratio_y = 3.0f;
			break;

		case 1 :
			// 16:9
			ratio_x = 16.0f;
			ratio_y = 9.0f;
			break;

		case 2 :
			// 16:10
			ratio_x = 16.0f;
			ratio_y = 10.0f;
			break;
		}
		x = ratio_x / idMath::Tan( base_fov / 360.0f * idMath::PI );
		y = idMath::ATan( ratio_y, x );
		fov_y = y * 360.0f / idMath::PI;
		fov_x = base_fov;
		return;
	}


	// first, calculate the vertical fov based on a 640x480 view
	x = 640.0f / idMath::Tan( base_fov / 360.0f * idMath::PI );
	y = idMath::ATan( 480.0f, x );
	fov_y = y * 360.0f / idMath::PI;

	// FIXME: somehow, this is happening occasionally
	assert( fov_y > 0 );
	if ( fov_y <= 0 ) {
		Printf( sys->FPU_GetState() );
		Error( "idGameLocal::CalcFov: bad result" );
	}

	int aspectChoice = cvarSystem->GetCVarInteger( "r_aspectRatio" );
	switch( aspectChoice ) {
	default :
	case 0 :
		// 4:3
		fov_x = base_fov;
		return;
		break;

	case 1 :
		// 16:9
		ratio_x = 16.0f;
		ratio_y = 9.0f;
		break;

	case 2 :
		// 16:10
		ratio_x = 16.0f;
		ratio_y = 10.0f;
		break;
	}

	y = ratio_y / idMath::Tan( fov_y / 360.0f * idMath::PI );
	fov_x = idMath::ATan( ratio_x, y ) * 360.0f / idMath::PI;

	if ( fov_x < base_fov ) {
		fov_x = base_fov;
		x = ratio_x / idMath::Tan( fov_x / 360.0f * idMath::PI );
		fov_y = idMath::ATan( ratio_y, x ) * 360.0f / idMath::PI;
	}

	// FIXME: somehow, this is happening occasionally
	assert( ( fov_x > 0 ) && ( fov_y > 0 ) );
	if ( ( fov_y <= 0 ) || ( fov_x <= 0 ) ) {
		Printf( sys->FPU_GetState() );
		Error( "idGameLocal::CalcFov: bad result" );
	}
}

void ClearClipProfile( void );
void DisplayClipProfile( void );

/*
================
idGameLocal::Draw

makes rendering and sound system calls
================
*/
bool idGameLocal::Draw( int clientNum ) {
//	DisplayClipProfile( );
//	ClearClipProfile( );

	if ( isMultiplayer || true ) {
		return mpGame.Draw( clientNum );
	}

	idPlayer *player = static_cast<idPlayer *>(entities[ clientNum ]);

	if ( !player ) {
		return false;
	}

	// render the scene
	player->playerView.RenderPlayerView( player->hud );

#if defined(TEST_MANUAL_STREAMING)
	if(renderSystem->IsManuallyStreaming()) {
		renderSystem->ServiceManualStreaming();
	}
#endif


// bdube: debugging HUD
	gameDebug.DrawHud ( );


	return true;
}

/*
================
idGameLocal::HandleESC
================
*/
escReply_t idGameLocal::HandleESC( idUserInterface **gui ) {

	if ( isMultiplayer || true ) {
		*gui = StartMenu();
		// we may set the gui back to NULL to hide it
		return ESC_GUI;
	}
	idPlayer *player = GetLocalPlayer();
	if ( player ) {
		if ( player->HandleESC() ) {
			return ESC_IGNORE;
		} else {
			return ESC_MAIN;
		}
	}
	return ESC_MAIN;
}

/*
================
idGameLocal::UpdatePlayerPostMainMenu
================
*/
void idGameLocal::UpdatePlayerPostMainMenu()	{
	idPlayer* player = GetLocalPlayer();

	//dedicated server?
	if( !player)	{
		return;
	}	
	
	//crosshair may have changed
	player->UpdateHudWeapon();
}

/*
================
idGameLocal::StartMenu
================
*/
idUserInterface* idGameLocal::StartMenu( void ) {
	//if ( !isMultiplayer ) {
	//	return NULL;
	//}
	return mpGame.StartMenu();
}

/*
================
idGameLocal::GetClientStats
================
*/
void idGameLocal::GetClientStats( int clientNum, char *data, const int len ) {
	mpGame.PlayerStats( clientNum, data, len );
}

/*
================
idGameLocal::SwitchTeam
================
*/
void idGameLocal::SwitchTeam( int clientNum, int team ) {

	mpGame.JoinTeam( clientNum, team );
}

/*
================
idGameLocal::HandleGuiCommands
================
*/
const char* idGameLocal::HandleGuiCommands( const char *menuCommand ) {
	//if ( !isMultiplayer ) {
	//	return NULL;
	//

	return mpGame.HandleGuiCommands( menuCommand );
}


void SendGuiTeamColors( idUserInterface* gui ) {
	idVec3 color ;

	int custNum = q4f_useCustomColors.GetInteger();

	idStr desc;
	const char* name = NULL;

	for ( int i = 0; i < TEAM_COUNT; i++ ) {
		sscanf( cvarSystem->GetCVarString( va( "q4f_team%dcolor", i+1 ) ), "%f %f %f", &( color.x ), &( color.y ), &( color.z ) );
		cvarSystem->SetCVarFloat( va( "gui_tcolor%d_red", i ), color.x );
		cvarSystem->SetCVarFloat( va( "gui_tcolor%d_green", i ), color.y );
		cvarSystem->SetCVarFloat( va( "gui_tcolor%d_blue", i ), color.z );
		gui->SetStateFloat( va( "tcolor%d_x", i ), color.x );
		gui->SetStateFloat( va( "tcolor%d_y", i ), color.y );
		gui->SetStateFloat( va( "tcolor%d_z", i ), color.z );

		switch ( i ) {
			case 0:
				if ( custNum == 1 ) {
					name = "Team Color :";
				}
				else {
					name = "Team 1 Color :";
				}
				desc = q4f_team0color.GetDescription();
				desc.Replace( "\n", " " );
				break;

			case 1:
				if ( custNum == 1 ) {
					name = "1st Enemy Color :";
				}
				else {
					name = "Team 2 Color :";
				}
				desc = q4f_team1color.GetDescription();
				desc.Replace( "\n", " " );
				break;

			case 2:
				if ( custNum == 1 ) {
					name = "2nd Enemy Color :";
				}
				else {
					name = "Team 3 Color :";
				}
				desc = q4f_team2color.GetDescription();
				desc.Replace( "\n", " " );
				break;

			case 3:
				if ( custNum == 1 ) {
					name = "3rd Enemy Color :";
				}
				else {
					name = "Team 4 Color :";
				}
				desc = q4f_team3color.GetDescription();
				desc.Replace( "\n", " " );
				break;

			default:
				assert( 0 );
		}

		gui->SetStateString( va( "team%dcolordesc", i ), desc.c_str() );
		gui->SetStateString( va( "team%dcolorlabel", i ), name );
	}

	gui->SetStateInt( "customColors", custNum );

	gui->StateChanged( gameLocal.time );
}

void FillGUIConfig( idUserInterface* gui, Config* cfg, int cfgNum ) {
	assert( cfg );

	// options

	// weapon names
	if ( cfgNum >= 0 && cfgNum < 10 ) {
		ENTDEF classDef = tfGame.GetClassEntDef( cfgNum );
		ENTDEF weapDef;
		idStr weaponDefStr;
		int numWeaps = 0;
		for ( numWeaps = 0; numWeaps < MAX_WEAPONS; numWeaps++ ) {
			if ( classDef->dict.GetString( va( "def_weapon%d", numWeaps ), "", weaponDefStr ) ) {
				weapDef = gameLocal.FindEntityDef( weaponDefStr.c_str(), false );

				if( weapDef == NULL ) {
					gameLocal.Warning( "Couldn't not find weapon def for '%s'", weaponDefStr.c_str() );
				} else {
					gui->SetStateString( va( "weapon_name%d", numWeaps ), weapDef->dict.GetString( "weaponname", "" ) );
				}
			}
			else {
				break;
			}
		}

		gui->SetStateInt( "num_weaps", numWeaps );
	}
	else {
		for ( int i = 0; i < MAX_WEAPONS; i++ ) {
			gui->SetStateString( va( "weapon_name%d", i ), va( "Weapon %d", i + 1 ) );
		}
		gui->SetStateInt( "num_weaps", MAX_WEAPONS );
	}

	// weapon crosshairs
	for ( int i = 0; i < MAX_WEAPONS; i++ ) {
		gui->SetStateString( va( "q4f_crosshair%d", i ), cfg->GetCVarVal( va( "q4f_crosshair%d", i ) ) );
		gui->SetStateString( va( "q4f_crosshairColor%d", i ), cfg->GetCVarVal( va( "q4f_crosshairColor%d", i ) ) );
		gui->SetStateString( va( "q4f_crosshairSize%d", i ), cfg->GetCVarVal( va( "q4f_crosshairSize%d", i ) ) );
	}





	// movement
	//gui->SetStateInt( "num_weaps", MAX_WEAPONS )

}

/*
================
idGameLocal::HandleMainMenuCommands
================
*/
void idGameLocal::HandleMainMenuCommands( const char *menuCommand, idUserInterface *gui ) {
	
	//idCmdArgs args;
	//args.TokenizeString( menuCommand, false );

	if ( !menuCommand || menuCommand[0] != 'q' )
		return;

	
	if ( !idStr::Icmp( menuCommand, "q4f_updateServerList" ) ) {
		if ( !serverBrowser ) {
			serverBrowser = new q4fServerBrowser();
		}
		serverBrowser->UpdateServerList( gui );
	}
	else if ( !idStr::Icmp( menuCommand, "q4f_updateServers" ) ) {
		if ( serverBrowser ) {
			delete serverBrowser;
			serverBrowser = NULL;
		}
		serverBrowser = new q4fServerBrowser();
	}
	else if ( !idStr::Icmp( menuCommand, "q4f_closeServerBrowser" ) ) {
		if ( serverBrowser ) {
			delete serverBrowser;
			serverBrowser = NULL;
		}
	}
	else if ( !idStr::Icmp( menuCommand, "q4f_addSortName" ) ) {
		if ( serverBrowser ) {
			serverBrowser->AddSort( "name" );
		}
	}
	else if ( !idStr::Icmp( menuCommand, "q4f_addSortPing" ) ) {
		if ( serverBrowser ) {
			serverBrowser->AddSort( "ping" );
		}
	}
	else if ( !idStr::Icmp( menuCommand, "q4f_addSortPlayers" ) ) {
		if ( serverBrowser ) {
			serverBrowser->AddSort( "players" );
		}
	}
	else if ( !idStr::Icmp( menuCommand, "q4f_addSortMap" ) ) {
		if ( serverBrowser ) {
			serverBrowser->AddSort( "map" );
		}
	}
	else if ( !idStr::Icmp( menuCommand, "q4f_click_serverList" ) ) {
		int selection = gui->State().GetInt( "serverlist2_sel_0" );
		if ( selection >= 0 ) {
			int id = gui->State().GetInt( va( "serverlist2_item_%d_id", selection ) );
			gui->SetStateInt( "serverlist_sel_0", id );

			gui->StateChanged ( gameLocal.time );
			gui->Redraw( gameLocal.time );

			gui->HandleNamedEvent( "q4fServerClick" );
		}
	}
	/*else if ( !idStr::Icmp( menuCommand, "q4f_addServerIP" ) ) {
		if ( serverBrowser ) {
			const char* txt = gui->State().GetString( "loadNotice", "" );
			if ( txt && txt[0] ) {
				serverBrowser->AddServerIP( txt );
			}
		}
	}*/
	else if ( !idStr::Icmp( menuCommand, "q4f_initGuiTeamColors" ) ) {
		SendGuiTeamColors( gui );
	}
	else if ( !idStr::Icmp( menuCommand, "q4f_updateColors" ) ) {
		for ( int i = 0; i < TEAM_COUNT; i++ ) {
			cvarSystem->SetCVarString( va( "q4f_team%dcolor", i+1 ), va( "%f %f %f",	cvarSystem->GetCVarFloat( va( "gui_tcolor%d_red", i ) ),
													cvarSystem->GetCVarFloat( va( "gui_tcolor%d_green", i ) ),
													cvarSystem->GetCVarFloat( va( "gui_tcolor%d_blue", i ) ) ) );
		}

		tfGame.UpdateTeamColors();
		SendGuiTeamColors( gui );
	}
	else if ( !idStr::Icmp( menuCommand, "q4f_loadconfig" ) ) {
		ConfigControl::FillGUI( gui );
	}
	else if ( !idStr::Icmp( menuCommand, "q4f_LoadMapEnter" ) ) {
		int selection = gui->State().GetInt( "maplist_sel_0" );
		if ( selection >= 0 ) {
			const char* mapname = gui->GetStateString( va( "maplist_item_%d", selection ) );

			cmdSystem->BufferCommandText( CMD_EXEC_NOW, va( "si_map %s", mapname ) );
			cmdSystem->BufferCommandText( CMD_EXEC_NOW, "servermaprestart" );
		}
	}
	else if ( !idStr::Icmp( menuCommand, "q4f_LoadMapList" ) ) {
		idStrList fileList;

		idFileList* files = fileSystem->ListFiles( "maps", ".map" );
		for ( int i = 0; i < files->GetList().Num(); i++ ) {
			fileList.AddUnique( files->GetList()[i] );
		}
		fileSystem->FreeFileList( files );

		idStr name;
		idStr cycle;

		for ( int i = 0; i < fileList.Num(); i++ )
		{
			gui->SetStateInt( va( "maplist_item_%d_id", i ), i );
			gui->SetStateString( va( "maplist_item_%d", i ), fileList[i].c_str() );
		}

		gui->StateChanged ( gameLocal.time );
		gui->Redraw( gameLocal.time );
	}	
}

/*
================
idGameLocal::GetLevelMap

  should only be used for in-game level editing
================
*/
idMapFile *idGameLocal::GetLevelMap( void ) {

// rhummer: Added the HasBeenResolved check, if resolve has been run then it doesn't have func_groups.
//			Which we probably don't want, so force the map to be reloaded.
	if ( mapFile && mapFile->HasPrimitiveData() && !mapFile->HasBeenResloved() ) {

		return mapFile;
	}
	if ( !mapFileName.Length() ) {
		return NULL;
	}

	if ( mapFile ) {
		delete mapFile;
	}

	mapFile = new idMapFile;
	if ( !mapFile->Parse( mapFileName ) ) {
		delete mapFile;
		mapFile = NULL;
	}

	return mapFile;
}

/*
================
idGameLocal::GetMapName
================
*/
const char *idGameLocal::GetMapName( void ) const {
	return mapFileName.c_str();
}

/*
================
idGameLocal::CallFrameCommand
================
*/
void idGameLocal::CallFrameCommand( idEntity* ent, const char* frameCommand ) {
	const function_t *func = program.FindFunction( frameCommand );
	if ( !func ) {
		Warning( "Script function '%s' not found.", frameCommand );
		return;
	}
	CallFrameCommand ( ent, func );
}

void idGameLocal::CallFrameCommand( idEntity *ent, const function_t *frameCommand ) {
	frameCommandThread->CallFunction( ent, frameCommand, true );
	frameCommandThread->Execute();
}

/*
================
idGameLocal::CallObjectFrameCommand
================
*/
void idGameLocal::CallObjectFrameCommand( idEntity *ent, const char *frameCommand ) {
	const function_t *func;

	func = ent->scriptObject.GetFunction( frameCommand );
	if ( !func ) {

// jnewquist: Use accessor for static class type 
		if ( !ent->IsType( idTestModel::GetClassType() ) ) {

			Error( "Unknown function '%s' called for frame command on entity '%s'", frameCommand, ent->name.c_str() );
		}
	} else {
		frameCommandThread->CallFunction( ent, func, true );
		frameCommandThread->Execute();
	}
}

/*
================
idGameLocal::ShowTargets
================
*/
void idGameLocal::ShowTargets( void ) {
	assert( GetLocalPlayer() );

	idMat3		axis = GetLocalPlayer()->viewAngles.ToMat3();
	idVec3		up = axis[ 2 ] * 5.0f;
	const idVec3 &viewPos = GetLocalPlayer()->GetPhysics()->GetOrigin();
	idBounds	viewTextBounds( viewPos );
	idBounds	viewBounds( viewPos );
	idBounds	box( idVec3( -4.0f, -4.0f, -4.0f ), idVec3( 4.0f, 4.0f, 4.0f ) );
	idEntity	*ent;
	idEntity	*target;
	int			i;
	idBounds	totalBounds;

	viewTextBounds.ExpandSelf( 128.0f );
	viewBounds.ExpandSelf( 512.0f );
	for( ent = spawnedEntities.Next(); ent != NULL; ent = ent->spawnNode.Next() ) {
		totalBounds = ent->GetPhysics()->GetAbsBounds();
		for( i = 0; i < ent->targets.Num(); i++ ) {
			target = ent->targets[ i ].GetEntity();
			if ( target ) {
				totalBounds.AddBounds( target->GetPhysics()->GetAbsBounds() );
			}
		}

		if ( !viewBounds.IntersectsBounds( totalBounds ) ) {
			continue;
		}

		float dist;
		idVec3 dir = totalBounds.GetCenter() - viewPos;
		dir.NormalizeFast();
		totalBounds.RayIntersection( viewPos, dir, dist );
		float frac = ( 512.0f - dist ) / 512.0f;
		if ( frac < 0.0f ) {
			continue;
		}

		gameRenderWorld->DebugBounds( ( ent->IsHidden() ? colorLtGrey : colorOrange ) * frac, ent->GetPhysics()->GetAbsBounds() );
		if ( viewTextBounds.IntersectsBounds( ent->GetPhysics()->GetAbsBounds() ) ) {
			idVec3 center = ent->GetPhysics()->GetAbsBounds().GetCenter();
			gameRenderWorld->DrawText( ent->name.c_str(), center - up, 0.1f, colorWhite * frac, axis, 1 );
			gameRenderWorld->DrawText( ent->GetEntityDefName(), center, 0.1f, colorWhite * frac, axis, 1 );
			gameRenderWorld->DrawText( va( "#%d", ent->entityNumber ), center + up, 0.1f, colorWhite * frac, axis, 1 );
		}

		for( i = 0; i < ent->targets.Num(); i++ ) {
			target = ent->targets[ i ].GetEntity();
			if ( target ) {
				gameRenderWorld->DebugArrow( colorYellow * frac, ent->GetCenter(), target->GetPhysics()->GetOrigin(), 10, 0 );
				gameRenderWorld->DebugBounds( colorGreen * frac, box, target->GetPhysics()->GetOrigin() );
			}
		}
	}
}

/*
================
idGameLocal::RunDebugInfo
================
*/
void idGameLocal::RunDebugInfo( void ) {
	idEntity *ent;
	idPlayer *player;

	player = GetLocalPlayer();
	if ( !player ) {
		return;
	}

	const idVec3 &origin = player->GetPhysics()->GetOrigin();

	if ( g_showEntityInfo.GetBool() ) {
		idBounds	viewTextBounds( origin );
		idBounds	viewBounds( origin );

		viewTextBounds.ExpandSelf( 128.0f );
		viewBounds.ExpandSelf( 512.0f );
		for( ent = spawnedEntities.Next(); ent != NULL; ent = ent->spawnNode.Next() ) {
			// don't draw the worldspawn
			if ( ent == world ) {
				continue;
			}


// rjohnson: moved entity info out of idGameLocal into its own function
			ent->DrawDebugEntityInfo(&viewBounds, &viewTextBounds);

		}
	}

	// debug tool to draw bounding boxes around active entities
	if ( g_showActiveEntities.GetBool() ) {
		for( ent = activeEntities.Next(); ent != NULL; ent = ent->activeNode.Next() ) {
			idBounds	b = ent->GetPhysics()->GetBounds();
			if ( b.GetVolume() <= 0 ) {
				b[0][0] = b[0][1] = b[0][2] = -8;
				b[1][0] = b[1][1] = b[1][2] = 8;
			}
			if ( ent->fl.isDormant ) {
				gameRenderWorld->DebugBounds( colorYellow, b, ent->GetPhysics()->GetOrigin() );
			} else {
				gameRenderWorld->DebugBounds( colorGreen, b, ent->GetPhysics()->GetOrigin() );
			}
		}
	}


// bdube: client entities
	if ( cl_showEntityInfo.GetBool ( ) ) {
		rvClientEntity* cent;
		for( cent = clientSpawnedEntities.Next(); cent != NULL; cent = cent->spawnNode.Next() ) {
			cent->DrawDebugInfo ( );
		}				
	}


	if ( g_showTargets.GetBool() ) {
		ShowTargets();
	}

	if ( g_showTriggers.GetBool() ) {
		idTrigger::DrawDebugInfo();
	}

	if ( g_editEntityMode.GetBool() ) {
		if ( gameLocal.isMultiplayer ) 	{
			g_editEntityMode.SetInteger(0);
			Printf( "Not allowed in multiplayer.\n" );
		} else {
			editEntities->DisplayEntities();
		}
	}

	if ( g_showCollisionWorld.GetBool() ) {
		// use g_maxShowDistance value instead of 128.0f
		collisionModelManager->DrawModel( clip.GetWorldCollisionModel(), vec3_origin, mat3_identity, origin, mat3_identity, g_maxShowDistance.GetFloat() );
	}

	if ( g_showCollisionModels.GetBool() ) {
		if( g_showCollisionModels.GetInteger() == 2 ) {
			clip.DrawClipModels( player->GetEyePosition(), g_maxShowDistance.GetFloat(), pm_thirdPerson.GetBool() ? NULL : player, &idPlayer::GetClassType() );
		} else {
			clip.DrawClipModels( player->GetEyePosition(), g_maxShowDistance.GetFloat(), pm_thirdPerson.GetBool() ? NULL : player );
		}
		
	}

	if ( g_showCollisionTraces.GetBool() ) {
		clip.PrintStatistics();
	}

	if ( g_showPVS.GetInteger() ) {
		pvs.DrawPVS( origin, ( g_showPVS.GetInteger() == 2 ) ? PVS_ALL_PORTALS_OPEN : PVS_NORMAL );
	}


// rjohnson: added debug hud
	if ( gameDebug.IsHudActive ( DBGHUD_PHYSICS ) )	{
		clip.DebugHudStatistics();
	}

	clip.ClearStatistics();


	// collision map debug output
	collisionModelManager->DebugOutput( player->GetEyePosition(), mat3_identity );


// jscott: for debugging playbacks
	if( g_showPlayback.GetInteger() ) {
		gameEdit->DrawPlaybackDebugInfo();
	}



// ddynerman: SD's clip sector code
	if ( g_showClipSectors.GetBool() ) {
		clip.DrawClipSectors();
	}

	if ( g_showAreaClipSectors.GetFloat() ) {
		clip.DrawAreaClipSectors( g_showAreaClipSectors.GetFloat() );
	}

}

// mwhitlock: added entity memory usage stuff.
/*
==================
idGameLocal::GetEntityMemoryUsage

Compute combined total memory footprint of server and client entity storage.
==================
*/

size_t idGameLocal::GetEntityMemoryUsage ( void ) const {

	// Server ents.
	size_t serverEntitiesSize = 0;
	for( idEntity *ent = gameLocal.spawnedEntities.Next(); ent != NULL; ent = ent->spawnNode.Next() ) {
		 serverEntitiesSize += sizeof( idEntity );
	}
	
	// Client ents.
	size_t clientEntitiesSize = 0;
	for( rvClientEntity *ent = gameLocal.clientSpawnedEntities.Next() ; ent != NULL; ent = ent->spawnNode.Next() ) {
		 clientEntitiesSize += ent->Size();
	}
	
	return serverEntitiesSize + clientEntitiesSize;
}


/*
==================
idGameLocal::CheatsOk
==================
*/
bool idGameLocal::CheatsOk( bool requirePlayer ) {
	idPlayer *player;

	if ( isMultiplayer && !cvarSystem->GetCVarBool( "net_allowCheats" ) ) {
		Printf( "Not allowed in multiplayer.\n" );
		return false;
	}

	if ( developer.GetBool() ) {
		return true;
	}

	player = GetLocalPlayer();
	if ( !requirePlayer || ( player && ( player->health > 0 ) ) ) {
		return true;
	}

	Printf( "You must be alive to use this command.\n" );

	return false;
}

/*
===================
idGameLocal::RegisterEntity
===================
*/
void idGameLocal::RegisterEntity( idEntity *ent ) {
	int spawn_entnum;

	if ( spawnCount >= ( 1 << ( 32 - GENTITYNUM_BITS ) ) ) {
		Error( "idGameLocal::RegisterEntity: spawn count overflow" );
	}

	if ( !spawnArgs.GetInt( "spawn_entnum", "0", spawn_entnum ) ) {
		while( entities[firstFreeIndex] && firstFreeIndex < ENTITYNUM_MAX_NORMAL ) {
			firstFreeIndex++;
		}
		if ( firstFreeIndex >= ENTITYNUM_MAX_NORMAL ) {
			Error( "no free entities" );
		}
		spawn_entnum = firstFreeIndex++;
	}

	entities[ spawn_entnum ] = ent;
	spawnIds[ spawn_entnum ] = spawnCount++;
	ent->entityNumber = spawn_entnum;
	ent->spawnNode.AddToEnd( spawnedEntities );
	ent->spawnArgs.TransferKeyValues( spawnArgs );

	if ( spawn_entnum >= num_entities ) {
		num_entities++;
	}


// bdube: keep track of last time an entity was registered	
	entityRegisterTime = time;

}

/*
===================
idGameLocal::UnregisterEntity
===================
*/
void idGameLocal::UnregisterEntity( idEntity *ent ) {
	assert( ent );

	if ( editEntities ) {
		editEntities->RemoveSelectedEntity( ent );
	}

	if ( ( ent->entityNumber != ENTITYNUM_NONE ) && ( entities[ ent->entityNumber ] == ent ) ) {
		ent->spawnNode.Remove();
		entities[ ent->entityNumber ] = NULL;
		spawnIds[ ent->entityNumber ] = -1;
		if ( ent->entityNumber >= MAX_CLIENTS && ent->entityNumber < firstFreeIndex ) {
			firstFreeIndex = ent->entityNumber;
		}
		ent->entityNumber = ENTITYNUM_NONE;
	}


// bdube: keep track of last time an entity was registered	
	entityRegisterTime = time;

}

/*
================
idGameLocal::SpawnEntityType
================
*/
idEntity *idGameLocal::SpawnEntityType( const idTypeInfo &classdef, const idDict *args, bool bIsClientReadSnapshot ) {
	idClass *obj;

#ifdef _DEBUG
	if ( isClient ) {
		assert( bIsClientReadSnapshot );
	}
#endif


// jnewquist: Use accessor for static class type 
	if ( !classdef.IsType( idEntity::GetClassType() ) ) {

		Error( "Attempted to spawn non-entity class '%s'", classdef.classname );
	}

	try {
		if ( args ) {
			spawnArgs = *args;
		} else {
			spawnArgs.Clear();
		}
		obj = classdef.CreateInstance();
		obj->CallSpawn();
	}
	
	catch( idAllocError & ) {
		obj = NULL;
	}
	spawnArgs.Clear();

	return static_cast<idEntity *>(obj);
}

/*
===================
idGameLocal::SpawnClientEntityDef

Finds the spawn function for the client entity and calls it,
returning false if not found
===================
*/
bool idGameLocal::SpawnClientEntityDef( const idDict &args, rvClientEntity **cent, bool setDefaults, const char* spawn ) {
	const char	*classname;
	idTypeInfo	*cls;
	idClass		*obj;
	idStr		error;
	const char  *name;

	if ( cent ) {
		*cent = NULL;
	}

	spawnArgs = args;

	if ( spawnArgs.GetBool( "nospawn" ) ){
		//not meant to actually spawn, just there for some compiling process
		return false;
	}

	if ( spawnArgs.GetString( "name", "", &name ) ) {
		error = va( " on '%s'", name );
	}

	spawnArgs.GetString( "classname", NULL, &classname );

	const idDeclEntityDef *def = FindEntityDef( classname, false );
	if ( !def ) {
		
		// jscott: a NULL classname would crash Warning()
		if( classname ) {
			Warning( "Unknown classname '%s'%s.", classname, error.c_str() );
		}
		
		return false;
	}

	spawnArgs.SetDefaults( &def->dict );

	// check if we should spawn a class object
	if( spawn == NULL ) {
		spawnArgs.GetString( "spawnclass", NULL, &spawn );
	}

	if ( spawn ) {

		cls = idClass::GetClass( spawn );
		if ( !cls ) {
			Warning( "Could not spawn '%s'.  Class '%s' not found%s.", classname, spawn, error.c_str() );
			return false;
		}

		obj = cls->CreateInstance();
		if ( !obj ) {
			Warning( "Could not spawn '%s'. Instance could not be created%s.", classname, error.c_str() );
			return false;
		}

		obj->CallSpawn();

		if ( cent && obj->IsType( rvClientEntity::GetClassType() ) ) {
			*cent = static_cast<rvClientEntity*>(obj);
		}

		return true;
	}

	Warning( "%s doesn't include a spawnfunc%s.", classname, error.c_str() );
	return false;
}

/*
===================
idGameLocal::SpawnEntityDef

Finds the spawn function for the entity and calls it,
returning false if not found
===================
*/
bool idGameLocal::SpawnEntityDef( const idDict &args, idEntity **ent, bool setDefaults ) {
	const char	*classname;
	const char	*spawn;
	idTypeInfo	*cls;
	idClass		*obj;
	idStr		error;
	const char  *name;

	TIME_THIS_SCOPE( __FUNCLINE__);
	
	if ( ent ) {
		*ent = NULL;
	}

	spawnArgs = args;

	if ( spawnArgs.GetBool( "nospawn" ) )
	{//not meant to actually spawn, just there for some compiling process
		return false;
	}

	if ( spawnArgs.GetString( "name", "", &name ) ) {

// jscott: fixed sprintf to idStr
		error = va( " on '%s'", name );

	}
	spawnArgs.GetString( "classname", NULL, &classname );
	// 3j_todo: this is repeated from the other spawnEntityDef
	const idDeclEntityDef *def = FindEntityDef( classname, false );
	if ( !def ) {

// jscott: a NULL classname would crash Warning()
		if( classname ) {
			Warning( "Unknown classname '%s'%s.", classname, error.c_str() );
		}

		return false;
	}

	spawnArgs.SetDefaults( &def->dict );


// rjohnson: entity usage stats
	if ( g_keepEntityStats.GetBool() ) {
		if ( idStr::Icmp( classname, "func_spawner" ) == 0 || 
			 idStr::Icmp( classname, "func_spawner_enemy" ) == 0 ) {
			// special case for spawners
			for( int i = 1; ; i++ ) {
				char		tempSpawn[128];
				const char	*tempClassname;

				sprintf( tempSpawn, "def_spawn_type%d", i );
				tempClassname = spawnArgs.GetString( tempSpawn, NULL );
				if ( tempClassname ) {
					const idDeclEntityDef *tempDef = FindEntityDef( tempClassname, false );

					if ( tempDef ) {
						idDict	tempArgs = tempDef->dict;

						tempArgs.Set( "mapFileName", mapFileNameStripped );
						entityUsageList.Insert( tempArgs );
					}
				} else {
					break;
				}
			}
		}
		else if ( def->dict.GetBool( "report_stats" ) ) {
			idDict	tempArgs = spawnArgs;
			tempArgs.Set( "mapFileName", mapFileNameStripped );
			entityUsageList.Insert( tempArgs );
		}
	}


	// check if we should spawn a class object
	spawnArgs.GetString( "spawnclass", NULL, &spawn );
	if ( spawn ) {

		cls = idClass::GetClass( spawn );
		if ( !cls ) {
			Warning( "Could not spawn '%s'.  Class '%s' not found%s.", classname, spawn, error.c_str() );
			return false;
		}

		obj = cls->CreateInstance();
		if ( !obj ) {
			Warning( "Could not spawn '%s'. Instance could not be created%s.", classname, error.c_str() );
			return false;
		}

		obj->CallSpawn();


// jnewquist: Use accessor for static class type 
		if ( ent && obj->IsType( idEntity::GetClassType() ) ) {

			*ent = static_cast<idEntity *>(obj);

		}

		return true;
	}

	// check if we should call a script function to spawn
	spawnArgs.GetString( "spawnfunc", NULL, &spawn );
	if ( spawn ) {
		const function_t *func = program.FindFunction( spawn );
		if ( !func ) {
			Warning( "Could not spawn '%s'.  Script function '%s' not found%s.", classname, spawn, error.c_str() );
			return false;
		}
		idThread *thread = new idThread( func );
		thread->DelayedStart( 0 );

		return true;
	}

	Warning( "%s doesn't include a spawnfunc or spawnclass%s.", classname, error.c_str() );
	return false;
}

// abahr:
idEntity* idGameLocal::SpawnEntityDef( const char* entityDefName, const idDict* additionalArgs ) {
	idDict			finalArgs;
	const idDict*	entityDict = NULL;
	idEntity*		entity = NULL;
	
	TIME_THIS_SCOPE( __FUNCLINE__);

	if( !entityDefName ) {
		return NULL;
	}

	entityDict = FindEntityDefDict( entityDefName, false );
	if( !entityDict ) {
		return NULL;
	}

	if( !additionalArgs ) {
		SpawnEntityDef( *entityDict, &entity );
	} else {
		finalArgs.Copy( *entityDict );
		finalArgs.Copy( *additionalArgs );
		SpawnEntityDef( finalArgs, &entity );
	}

	return entity;
}


/*
================
idGameLocal::FindEntityDef
================
*/
const idDeclEntityDef *idGameLocal::FindEntityDef( const char *name, bool makeDefault ) const {
	TIME_THIS_SCOPE( __FUNCLINE__);
	const idDecl *decl = NULL;
	//if ( isMultiplayer ) {
		// 3j_todo: we can pass this step
	//	decl = declManager->FindType( DECL_ENTITYDEF, va( "%s_mp", name ), false );
	//}
	//if ( !decl ) {
		decl = declManager->FindType( DECL_ENTITYDEF, name, /*makeDefault*/false );
	//}
	return static_cast<const idDeclEntityDef *>( decl );
}

/*
================
idGameLocal::FindEntityDefDict
================
*/
const idDict *idGameLocal::FindEntityDefDict( const char *name, bool makeDefault ) const {
	TIME_THIS_SCOPE( __FUNCLINE__);
	const idDeclEntityDef *decl = FindEntityDef( name, makeDefault );
	return decl ? &decl->dict : NULL;
}

/*
================
idGameLocal::InhibitEntitySpawn
================
*/
bool idGameLocal::InhibitEntitySpawn( idDict &spawnArgs ) {
	if ( spawnArgs.GetInt( "gameindex", va( "%d", gameLocal.gameType ) ) != gameLocal.gameType ) {
		return true;
	}

	return false;
}

/*
================
idGameLocal::SetSkill
================
*/
void idGameLocal::SetSkill( int value ) {
}

/*
==============
idGameLocal::GameState

Used to allow entities to know if they're being spawned during the initial spawn.
==============
*/
gameState_t	idGameLocal::GameState( void ) const {
	return gamestate;
}

void idGameLocal::SpawnSingleLight() {
	idDict args;

	args.Set( "texture", 					"lights/ambientLight" );
	args.Set( "globalLight", 				"1" );
	args.Set( "noRegister", 				"1" );
	args.Set( "light", 						"12000"	 );
	args.Set( "networkSync", 				"0" );
	args.Set( "noshadows", 					"1" );
	args.Set( "noDynamicShadows", 			"1" );
	args.Set( "nospecular", 				"1" );

	//args.SetInt( "spawn_entnum", SINGLE_LIGHT );

	idEntity* ent = SpawnEntityDef( "light", &args );
	if ( !ent || !ent->IsType( idLight::GetClassType() ) ) {
		Error( "Problem spawning single ambient light entity" );
	}
	singleLight = static_cast<idLight*>(ent);
	isMapEntity[ singleLight->entityNumber ] = true;
}

/*
==============
idGameLocal::SpawnMapEntities

Parses textual entity definitions out of an entstring and spawns gentities.
==============
*/

void idGameLocal::SpawnMapEntities() {

	int			i;
	int			num;
	int			inhibit;
	idMapEntity	*mapEnt;
	int			numEntities;
	idDict		args;
	idDict		items;
	int			latchedSpawnCount = -1;

	Printf( "Spawning entities\n" );
	
	TIME_THIS_SCOPE( __FUNCLINE__);

	if ( mapFile == NULL ) {
		Printf("No mapfile present\n");
		return;
	}

	numEntities = mapFile->GetNumEntities();
	if ( numEntities == 0 ) {
		Error( "...no entities" );
	}

	// Spawn the world
	mapEnt = mapFile->GetEntity( 0 );
	args = mapEnt->epairs;
	args.SetInt( "spawn_entnum", ENTITYNUM_WORLD );

	// precache stuff on worldSpawn like player def and other misc things
	CacheDictionaryMedia( &args );

	if( gameLocal.isClient && spawnCount != INITIAL_SPAWN_COUNT ) {
		latchedSpawnCount = spawnCount;
		spawnCount = INITIAL_SPAWN_COUNT;
	}

	if ( !SpawnEntityDef( args ) || !entities[ ENTITYNUM_WORLD ] || !entities[ ENTITYNUM_WORLD ]->IsType( idWorldspawn::GetClassType() ) ) {
		Error( "Problem spawning world entity" );
	}
	
// bdube: dummy entity for client entities with physics
	args.Clear ( );
	args.SetInt( "spawn_entnum", ENTITYNUM_CLIENT );

	if ( !SpawnEntityType( rvClientPhysics::GetClassType(), &args, true ) || !entities[ ENTITYNUM_CLIENT ] ) {	
		Error( "Problem spawning client physics entity" );
	}

	if( gameLocal.isClient && latchedSpawnCount != -1 ) {
		spawnCount = latchedSpawnCount;
	}

	isMapEntity[ ENTITYNUM_CLIENT ] = true;
	isMapEntity[ ENTITYNUM_WORLD ] = true;

	SpawnSingleLight();

	num = 2;
	inhibit = 0;


	// finally spawn all the map entities
	for ( i = 1 ; i < numEntities ; i++ ) {

		mapEnt = mapFile->GetEntity( i );
		args = mapEnt->epairs;

		// xavior: lets try to convert q4 ctf spawn points to q4f (thx AnthonyJ)
		if (idStr::Cmp(args.GetString("classname"), "info_player_team") == 0) 
		{
			// change classname
			args.Delete("classname");
			args.Set("classname", "info_player_spawn");
			// convert team #
			if (idStr::Cmp(args.GetString("team"), "strogg") == 0)
				args.Set("team", "red");
			else if (idStr::Cmp(args.GetString("team"), "marine") == 0)
				args.Set("team", "blue");
			else
				args.Set("team", "-1");
		}
		else if (idStr::Cmp(args.GetString("classname"), "mp_ctf_marine_flag") == 0) 
		{
			// change classname
			args.Delete("classname");
			args.Set("classname", "ctf_flag");
			args.Set("name", "blue_flag");
			args.Set("team", "1");
			args.Set("carrying", "red_flag");
			args.Set("teamscore", "10");
			args.Set("callOnCarry", "Q4FBase::pickupCTFFlag_regular");
			args.Set("snd_capture_team", "announce_team_enemy_score");
			args.Set("snd_capture", "announce_team_you_score");
		}
		else if (idStr::Cmp(args.GetString("classname"), "mp_ctf_strogg_flag") == 0) 
		{
			// change classname
			args.Delete("classname");
			args.Set("classname", "ctf_flag");
			args.Set("name", "red_flag");
			args.Set("team", "2");
			args.Set("carrying", "blue_flag");
			args.Set("teamscore", "10");
			args.Set("callOnCarry", "Q4FBase::pickupCTFFlag_regular");
			args.Set("snd_capture_team", "announce_team_enemy_score");
			args.Set("snd_capture", "announce_team_you_score");
		}

// ddynerman: merge the dicts ahead of SpawnEntityDef() so we can inhibit using merged info
		const idDeclEntityDef* entityDef = FindEntityDef( args.GetString( "classname" ), false );
		
		if( entityDef == NULL ) {
			gameLocal.Warning( "idGameLocal::SpawnMapEntities() - Unknown entity classname '%s'\n", args.GetString( "classname" ) );
			continue;
			//gameLocal.Error( "idGameLocal::SpawnMapEntities() - Unknown entity classname '%s'\n", args.GetString( "classname" ) );
			//return;
		}
		args.SetDefaults( &(entityDef->dict) );


		if ( !InhibitEntitySpawn( args ) ) {			// entity filtering

			// draw items in the load screen
			if( args.GetBool( "inv_item" ) ) {

				// make sure we only display it once
				if( !items.GetBool( args.GetString( "inv_icon" ) ) ) {
					networkSystem->AddLoadingIcon( args.GetString( "inv_icon" ) );
					networkSystem->SetLoadingText( common->GetLocalizedString( args.GetString( "inv_name" ) ) );
					items.SetBool( args.GetString( "inv_icon" ), true );
				}
			}

			// precache any media specified in the map entity
			CacheDictionaryMedia( &args );

			idEntity* ent = NULL;
			SpawnEntityDef( args, &ent );

			if ( ent ) {
				isMapEntity[ ent->entityNumber ] = true;
			}

			num++;
		} else {
			inhibit++;
		}
	}

	Printf( "...%i entities spawned, %i inhibited\n\n", num, inhibit );
}


/*
================
idGameLocal::AddEntityToHash
================
*/
void idGameLocal::AddEntityToHash( const char *name, idEntity *ent ) {
	if ( FindEntity( name ) ) {
		Error( "Multiple entities named '%s'", name );
	}
	entityHash.Add( entityHash.GenerateKey( name, true ), ent->entityNumber );
}

/*
================
idGameLocal::RemoveEntityFromHash
================
*/
bool idGameLocal::RemoveEntityFromHash( const char *name, idEntity *ent ) {
	int hash, i;

	hash = entityHash.GenerateKey( name, true );
	for ( i = entityHash.First( hash ); i != -1; i = entityHash.Next( i ) ) {
		if ( entities[i] && entities[i] == ent && entities[i]->name.Icmp( name ) == 0 ) {
			entityHash.Remove( hash, i );
			return true;
		}
	}
	return false;
}

/*
================
idGameLocal::GetTargets
================
*/
int idGameLocal::GetTargets( const idDict &args, idList< idEntityPtr<idEntity> > &list, const char *ref ) const {
	int i, num, refLength;
	const idKeyValue *arg;
	idEntity *ent;

	list.Clear();

	refLength = strlen( ref );
	num = args.GetNumKeyVals();
	for( i = 0; i < num; i++ ) {

		arg = args.GetKeyVal( i );
		if ( arg->GetKey().Icmpn( ref, refLength ) == 0 ) {

			ent = FindEntity( arg->GetValue() );
			if ( ent ) {
				idEntityPtr<idEntity> &entityPtr = list.Alloc();
                entityPtr = ent;
			}
		}
	}

	return list.Num();
}

/*
=============
idGameLocal::GetTraceEntity

returns the master entity of a trace.  for example, if the trace entity is the player's head, it will return the player.
=============
*/
idEntity *idGameLocal::GetTraceEntity( const trace_t &trace ) const {
	idEntity *master;

	if ( !entities[ trace.c.entityNum ] ) {
		return NULL;
	}
	master = entities[ trace.c.entityNum ]->GetBindMaster();
	if ( master ) {
		return master;
	}
	return entities[ trace.c.entityNum ];
}

/*
=============
idGameLocal::ArgCompletion_EntityName

Argument completion for entity names
=============
*/
void idGameLocal::ArgCompletion_EntityName( const idCmdArgs &args, void(*callback)( const char *s ) ) {
	int i;

	for( i = 0; i < gameLocal.num_entities; i++ ) {
		if ( gameLocal.entities[ i ] ) {
			callback( va( "%s %s", args.Argv( 0 ), gameLocal.entities[ i ]->name.c_str() ) );
		}
	}
}

/*
=============
idGameLocal::FindEntity

Returns the entity whose name matches the specified string.
=============
*/
idEntity *idGameLocal::FindEntity( const char *name ) const {
	int hash, i;

	hash = entityHash.GenerateKey( name, true );
	for ( i = entityHash.First( hash ); i != -1; i = entityHash.Next( i ) ) {
		if ( entities[i] && entities[i]->name.Icmp( name ) == 0 ) {
			return entities[i];
		}
	}

	return NULL;
}

/*
=============
idGameLocal::FindEntityUsingDef

Searches all active entities for the next one using the specified entityDef.

Searches beginning at the entity after from, or the beginning if NULL
NULL will be returned if the end of the list is reached.
=============
*/
idEntity *idGameLocal::FindEntityUsingDef( idEntity *from, const char *match ) const {
	idEntity	*ent;

	if ( !from ) {
		ent = spawnedEntities.Next();
	} else {
		ent = from->spawnNode.Next();
	}

	for ( ; ent != NULL; ent = ent->spawnNode.Next() ) {
		assert( ent );
		if ( idStr::Icmp( ent->GetEntityDefName(), match ) == 0 ) {
			return ent;
		}
	}

	return NULL;
}

/*
=============
idGameLocal::FindTraceEntity

Searches all active entities for the closest ( to start ) match that intersects
the line start,end
=============
*/
idEntity *idGameLocal::FindTraceEntity( idVec3 start, idVec3 end, const idTypeInfo &c, const idEntity *skip ) const {
	idEntity *ent;
	idEntity *bestEnt;
	float scale;
	float bestScale;
	idBounds b;

	bestEnt = NULL;
	bestScale = 1.0f;
	for( ent = spawnedEntities.Next(); ent != NULL; ent = ent->spawnNode.Next() ) {
		if ( ent->IsType( c ) && ent != skip ) {
			b = ent->GetPhysics()->GetAbsBounds().Expand( 16 );
			if ( b.RayIntersection( start, end-start, scale ) ) {
				if ( scale >= 0.0f && scale < bestScale ) {
					bestEnt = ent;
					bestScale = scale;
				}
			}
		}
	}

	return bestEnt;
}

/*
================
idGameLocal::EntitiesWithinRadius
================
*/
int idGameLocal::EntitiesWithinRadius( const idVec3 org, float radius, idEntity **entityList, int maxCount ) const {
	idEntity *ent;
	idBounds bo( org );
	int entCount = 0;

	bo.ExpandSelf( radius );
	for( ent = spawnedEntities.Next(); ent != NULL; ent = ent->spawnNode.Next() ) {
		if ( ent->GetPhysics()->GetAbsBounds().IntersectsBounds( bo ) ) {
			entityList[entCount++] = ent;
		}
	}

	return entCount;
}

/*
=================
idGameLocal::KillBox

Kills all entities that would touch the proposed new positioning of ent. The ent itself will not being killed.
Checks if player entities are in the teleporter, and marks them to die at teleport exit instead of immediately.
If catch_teleport, this only marks teleport players for death on exit
=================
*/
void idGameLocal::KillBox( idEntity *ent, bool catch_teleport ) {
	int			i;
	int			num;
	idEntity *	hit;
	idClipModel *cm;
	idClipModel *clipModels[ MAX_GENTITIES ];
	idPhysics	*phys;

	phys = ent->GetPhysics();
	if ( !phys->GetNumClipModels() ) {
		return;
	}



	num = clip.ClipModelsTouchingBounds( phys->GetAbsBounds(), phys->GetClipMask(), clipModels, MAX_GENTITIES );

	for ( i = 0; i < num; i++ ) {
		cm = clipModels[ i ];

		// don't check render entities
		if ( cm->IsRenderModel() ) {
			continue;
		}

		hit = cm->GetEntity();
		if ( ( hit == ent ) || !hit->fl.takedamage ) {
			continue;
		}

		if ( !phys->ClipContents( cm ) ) {
			continue;
		}

		// nail it

// jnewquist: Use accessor for static class type 
		if ( hit->IsType( idPlayer::GetClassType() ) && static_cast< idPlayer * >( hit )->IsInTeleport() ) {

			static_cast< idPlayer * >( hit )->TeleportDeath( ent->entityNumber );
		} else if ( !catch_teleport ) {
			hit->Damage( ent, ent, vec3_origin, "damage_telefrag", 1.0f, INVALID_JOINT );
		}

		if ( !gameLocal.isMultiplayer ) {
			// let the mapper know about it
			Warning( "'%s' telefragged '%s'", ent->name.c_str(), hit->name.c_str() );
		}
	}
}

/*
================
idGameLocal::RequirementMet
================
*/
bool idGameLocal::RequirementMet( idEntity *activator, const idStr &requires, int removeItem ) {

	return true;
}

/*
============
idGameLocal::AlertAI
============
*/
void idGameLocal::AlertAI( idEntity *ent ) {

// bdube: merged
	if ( ent ) {

// jnewquist: Use accessor for static class type 
		if ( ent->IsType( idActor::GetClassType() ) ) {

			// alert them for the next frame
			lastAIAlertActorTime = time + GetMSec();
			lastAIAlertActor = static_cast<idActor *>( ent );
		} else {
			lastAIAlertEntityTime = time + GetMSec();
			lastAIAlertEntity = ent;
		}
	} else {
		lastAIAlertEntityTime = 0;
		lastAIAlertActorTime = 0;
		lastAIAlertEntity = NULL;
		lastAIAlertActor = NULL;
	}

}


// bdube: alert entity returns an entity, alert actor a an actor
/*
============
idGameLocal::GetAlertEntity
============
*/
idEntity *idGameLocal::GetAlertEntity( void ) {
	if ( lastAIAlertEntityTime >= time ) {
		return lastAIAlertEntity.GetEntity();
	}

	return NULL;
}

/*
============
idGameLocal::GetAlertActor
============
*/
idActor *idGameLocal::GetAlertActor( void ) {
	if ( lastAIAlertActorTime >= time ) {
		return lastAIAlertActor.GetEntity();
	}

	return NULL;
}


/*
============
SortClipModelsByEntity
============
*/
static int SortClipModelsByEntity( const void* left, const void* right ) {
	idEntity* leftEntity  = left  ? (*((const idClipModel**)left))->GetEntity() : NULL;
	idEntity* rightEntity = right ? (*((const idClipModel**)right))->GetEntity() : NULL;

	int entityNumLeft = (leftEntity) ? leftEntity->entityNumber : 0;
	int entityNumRight = (rightEntity) ? rightEntity->entityNumber : 0;

	return entityNumLeft - entityNumRight;
}


/*
============
idGameLocal::RadiusDamage
Returns the number of actors damaged
============
*/
// abahr: changed to work with deathPush
void idGameLocal::RadiusDamage( const idVec3 &origin, idEntity *inflictor, idEntity *attacker, idEntity *ignoreDamage, idEntity *ignorePush, const char *damageDefName, float dmgPower, int* hitCount ) {
	float		dist, damageScale, attackerDamageScale, attackerPushScale;
	idEntity*	ent = NULL;
	idEntity*	lastEnt = NULL;
	idClipModel* clipModel = NULL;
	idClipModel* clipModelList[ MAX_GENTITIES ];
	int			numListedClipModels;
	modelTrace_t	result;
	idVec3 		v, damagePoint, dir;
	int			i, damage, radius, push;

	const idDict *damageDef = FindEntityDefDict( damageDefName, false );
	if ( !damageDef ) {
		Warning( "Unknown damageDef '%s'", damageDefName );
		return;
	}

	damageDef->GetInt( "damage", "20", damage );
	damageDef->GetInt( "radius", "50", radius );
	damageDef->GetInt( "push", va( "%d", damage * 100 ), push );
	damageDef->GetFloat( "attackerDamageScale", "0.5", attackerDamageScale );
	//if( gameLocal.isMultiplayer ) {
		damageDef->GetFloat( "attackerPushScale", "2", attackerPushScale );
	//} else {
	//	damageDef->GetFloat( "attackerPushScale", "0", attackerPushScale );
	//}

	if ( radius < 1 ) {
		radius = 1;
	}



	numListedClipModels = clip.ClipModelsTouchingBounds( idBounds(origin).Expand(radius), MASK_ALL, clipModelList, MAX_GENTITIES );
	if( numListedClipModels > 0 ) {
		//Sort list by unique entities for easier searching
		qsort( clipModelList, numListedClipModels, sizeof(clipModelList[0]), SortClipModelsByEntity );
	}

	for( int c = 0; c < numListedClipModels; ++c ) {
		clipModel = clipModelList[ c ];
		assert( clipModel );

		ent = clipModel->GetEntity();
		
		// Skip all entitys that arent primary damage entities
		if ( !ent ) {
			continue;
		}

		// Dont damage inflictor or the ignore entity
		if( ent == inflictor || ent == ignoreDamage ) {
			continue;
		}

		idBounds absBounds = clipModel->GetAbsBounds();

		// find the distance from the edge of the bounding box
		for ( i = 0; i < 3; i++ ) {
			if ( origin[ i ] < absBounds[0][ i ] ) {
				v[ i ] = absBounds[0][ i ] - origin[ i ];
			} else if ( origin[ i ] > absBounds[1][ i ] ) {
				v[ i ] = origin[ i ] - absBounds[1][ i ];
			} else {
				v[ i ] = 0;
			}
		}

		dist = v.Length();
		if ( dist >= radius ) {
			continue;
		}

		if( gameRenderWorld->FastWorldTrace(result, origin, absBounds.GetCenter()) ) {
			continue;
		}
		
		RadiusPushClipModel ( inflictor, origin, push, clipModel );

		// Only damage unique entities.  This works because we have a sorted list
		if( lastEnt == ent ) {
			continue;
		}

		lastEnt = ent;

		if ( ent->CanDamage( origin, damagePoint, ignoreDamage ) ) {						
			// push the center of mass higher than the origin so players
			// get knocked into the air more
			//if( gameLocal.isMultiplayer ) {
				// fudge the direction in MP to account for player height difference and origin shift
				// 31.875 = origin is 23.875 units lower in Q4 than Q3 + player is 8 units taller in Q4
				dir = ( ent->GetPhysics()->GetOrigin() + idVec3( 0.0f, 0.0f, 31.875f ) ) - origin;
			//} else {
			//	dir = ent->GetPhysics()->GetOrigin() - origin;
			//}		
			
			dir[2] += 24;
 
 			// get the damage scale
			damageScale = dmgPower * ( 1.0f - dist / radius );
			
			if ( ent == attacker ) {
				damageScale *= attackerDamageScale;
			}

			dir.Normalize();
			ent->Damage( inflictor, attacker, dir, damageDefName, damageScale, CLIPMODEL_ID_TO_JOINT_HANDLE(ent->GetPhysics()->GetClipModel()->GetId()) );

			// for stats, count the first 
			if( attacker && attacker->IsType( idPlayer::GetClassType() ) && inflictor && inflictor->IsType( idProjectile::GetClassType() ) && ent->IsType( idPlayer::GetClassType() ) && hitCount ) {
				// with splash damage projectiles, one projectile fire can damage multiple people.  If anyone is hit, 
				// the shot counts as a hit but only report accuracy on the first one to avoid accuracies > 100%
				(*hitCount)++;
			}
		} 
	}
}


/*
==============
idGameLocal::RadiusPush
==============
*/
void idGameLocal::RadiusPush( const idVec3 &origin, const float radius, const float push, const idEntity *inflictor, const idEntity *ignore, float inflictorScale, const bool quake ) {
	int i, numListedClipModels;
	idClipModel *clipModel;
	idClipModel *clipModelList[ MAX_GENTITIES ];
	idVec3 dir;
	idBounds bounds;
	modelTrace_t result;
	idEntity *ent;
	float scale;


// abahr: need to use gravity instead of assuming z is up
	dir = -GetCurrentGravity( const_cast<idEntity*>(inflictor) ).ToNormal();


	bounds = idBounds( origin ).Expand( radius );

	// get all clip models touching the bounds


	numListedClipModels = clip.ClipModelsTouchingBounds( bounds, -1, clipModelList, MAX_GENTITIES );

	// apply impact to all the clip models through their associated physics objects
	for ( i = 0; i < numListedClipModels; i++ ) {

		clipModel = clipModelList[i];

		// never push render models
		if ( clipModel->IsRenderModel() ) {
			continue;
		}

		ent = clipModel->GetEntity();
		
		// never push projectiles

// jnewquist: Use accessor for static class type 
		if ( ent->IsType( idProjectile::GetClassType() ) ) {

			continue;
		}

		// players use "knockback" in idPlayer::Damage

// jnewquist: Use accessor for static class type 
		if ( ent->IsType( idPlayer::GetClassType() ) && !quake ) {

			continue;
		}

		// don't push the ignore entity
		if ( ent == ignore ) {
			continue;
		}

		if ( gameRenderWorld->FastWorldTrace( result, origin, clipModel->GetOrigin() ) ) {
			continue;
		}

		// scale the push for the inflictor
		if ( ent == inflictor ) {
			scale = inflictorScale;
		} else {
			scale = 1.0f;
		}

		if ( quake ) {
			clipModel->GetEntity()->ApplyImpulse( world, clipModel->GetId(), clipModel->GetOrigin(), scale * push * dir );
		} else {

// bdube: inflictor
			RadiusPushClipModel( (idEntity*)inflictor, origin, scale * push, clipModel );

		}
	}
}

/*
==============
idGameLocal::RadiusPushClipModel
==============
*/

// bdube: inflictor
void idGameLocal::RadiusPushClipModel( idEntity* inflictor, const idVec3 &origin, const float push, const idClipModel *clipModel ) {

	int i, j;
	float dot, dist, area;
	const idTraceModel *trm;
	const traceModelPoly_t *poly;
	idFixedWinding w;
	idVec3 v, localOrigin, center, impulse;

	trm = clipModel->GetTraceModel();
	if ( !trm || 1 ) {
		impulse = clipModel->GetAbsBounds().GetCenter() - origin;
		impulse.Normalize();

// abahr: removed because z isn't always up
		//impulse.z += 1.0f;
		//impulse = idVec3( 0.0, 0.0, 1.0 );
		clipModel->GetEntity()->ApplyImpulse( inflictor, clipModel->GetId(), clipModel->GetOrigin(), push * impulse, true );

		return;
	}

	localOrigin = ( origin - clipModel->GetOrigin() ) * clipModel->GetAxis().Transpose();
	for ( i = 0; i < trm->numPolys; i++ ) {
		poly = &trm->polys[i];

		center.Zero();
		for ( j = 0; j < poly->numEdges; j++ ) {
			v = trm->verts[ trm->edges[ abs(poly->edges[j]) ].v[ INTSIGNBITSET( poly->edges[j] ) ] ];
			center += v;
			v -= localOrigin;
			v.NormalizeFast();	// project point on a unit sphere
			w.AddPoint( v );
		}
		center /= poly->numEdges;
		v = center - localOrigin;
		dist = v.NormalizeFast();
		dot = v * poly->normal;
		if ( dot > 0.0f ) {
			continue;
		}
		area = w.GetArea();
		// impulse in polygon normal direction
		impulse = poly->normal * clipModel->GetAxis();
		// always push up for nicer effect
		impulse.z -= 1.0f;
		// scale impulse based on visible surface area and polygon angle
		impulse *= push * ( dot * area * ( 1.0f / ( 4.0f * idMath::PI ) ) );
		// scale away distance for nicer effect
		impulse *= ( dist * 2.0f );
		// impulse is applied to the center of the polygon
		center = clipModel->GetOrigin() + center * clipModel->GetAxis();


// bdube: inflictor
		clipModel->GetEntity()->ApplyImpulse( inflictor, clipModel->GetId(), center, impulse );

	}
}

/*
===============
idGameLocal::ProjectDecal
===============
*/
void idGameLocal::ProjectDecal( const idVec3 &origin, const idVec3 &dir, float depth, bool parallel, float size, const char *material, float angle ) {
	float s, c;
	idMat3 axis, axistemp;
	idFixedWinding winding;
	idVec3 windingOrigin, projectionOrigin;

	static idVec3 decalWinding[4] = {
		idVec3(  1.0f,  1.0f, 0.0f ),
		idVec3( -1.0f,  1.0f, 0.0f ),
		idVec3( -1.0f, -1.0f, 0.0f ),
		idVec3(  1.0f, -1.0f, 0.0f )
	};

	if ( !g_decals.GetBool() ) {
		return;
	}


// rjohnson: no decals on dedicated server
	if ( isMultiplayer && !isClient && !isListenServer ) {
		// no decals on dedicated server
		return;
	}


	// randomly rotate the decal winding
	idMath::SinCos16( ( angle ) ? angle : random.RandomFloat() * idMath::TWO_PI, s, c );

	// winding orientation
	axis[2] = dir;
	axis[2].Normalize();
	axis[2].NormalVectors( axistemp[0], axistemp[1] );
	axis[0] = axistemp[ 0 ] * c + axistemp[ 1 ] * -s;
	axis[1] = axistemp[ 0 ] * -s + axistemp[ 1 ] * -c;

	windingOrigin = origin + depth * axis[2];
	if ( parallel ) {
		projectionOrigin = origin - depth * axis[2];
	} else {
		projectionOrigin = origin;
	}

	size *= 0.5f;

	winding.Clear();
	winding += idVec5( windingOrigin + ( axis * decalWinding[0] ) * size, idVec2( 1, 1 ) );
	winding += idVec5( windingOrigin + ( axis * decalWinding[1] ) * size, idVec2( 0, 1 ) );
	winding += idVec5( windingOrigin + ( axis * decalWinding[2] ) * size, idVec2( 0, 0 ) );
	winding += idVec5( windingOrigin + ( axis * decalWinding[3] ) * size, idVec2( 1, 0 ) );
	gameRenderWorld->ProjectDecalOntoWorld( winding, projectionOrigin, parallel, depth * 0.5f, declManager->FindMaterial( material ), time );
}

/*
==============
idGameLocal::BloodSplat
==============
*/

// ddynerman: multiple collision models
void idGameLocal::BloodSplat( const idEntity* ent, const idVec3 &origin, const idVec3 &dirArg, float size, const char *material ) {

	float halfSize = size * 0.5f;
	idVec3 verts[] = {	idVec3( 0.0f, +halfSize, +halfSize ),
						idVec3( 0.0f, +halfSize, -halfSize ),
						idVec3( 0.0f, -halfSize, -halfSize ),
						idVec3( 0.0f, -halfSize, +halfSize ) };
	idVec3 dir = dirArg;
	idTraceModel trm;
	idClipModel mdl;
	trace_t results;


// mekberg: changed from g_bloodEffects to g_decals
	if ( !g_decals.GetBool() ) {
		return;
	}


	size = halfSize + random.RandomFloat() * halfSize;
	trm.SetupPolygon( verts, 4 );
	mdl.LoadModel( trm, NULL );

	// I don't want dir to be axis aligned, as it is more likely to streak them (because most architecture is axis aligned
	dir.Set( dirArg.x*.1f, dirArg.y*.1f, -1 );
	dir.Normalize();



	Translation( results, origin, origin + dir * 72.0f, &mdl, mat3_identity, CONTENTS_SOLID, NULL );

	ProjectDecal( results.endpos, dir, 2.0f * size, true, size, material );
}

/*
=============
idGameLocal::SetCamera
=============
*/
void idGameLocal::SetCamera( idCamera *cam ) {
	int i;
	idEntity *ent;

	// this should fix going into a cinematic when dead.. rare but happens
	idPlayer *client = GetLocalPlayer();
	if ( client->health <= 0 || client->pfl.dead ) {
		return;
	}

	camera = cam;
	if ( camera ) {

// bdube: tool support
		inCinematic = false;
		if( !( gameLocal.editors & ( EDITOR_MODVIEW | EDITOR_PLAYBACKS ) ) ) {
			inCinematic = true;
		}


		if ( skipCinematic && camera->spawnArgs.GetBool( "disconnect" ) ) {
			camera->spawnArgs.SetBool( "disconnect", false );
			cvarSystem->SetCVarFloat( "r_znear", 3.0f );
			cmdSystem->BufferCommandText( CMD_EXEC_APPEND, "disconnect\n" );
			skipCinematic = false;
			return;
		}

		if ( time > cinematicStopTime ) {
			cinematicSkipTime = time + CINEMATIC_SKIP_DELAY;
		}

		// set r_znear so that transitioning into/out of the player's head doesn't clip through the view
		cvarSystem->SetCVarFloat( "r_znear", 1.0f );
		
		// hide all the player models
		for( i = 0; i < numClients; i++ ) {
			if ( entities[ i ] ) {
				client = static_cast< idPlayer* >( entities[ i ] );
				client->EnterCinematic();
			}
		}

		if ( !cam->spawnArgs.GetBool( "ignore_enemies" ) ) {
			// kill any active monsters that are enemies of the player
			for ( ent = spawnedEntities.Next(); ent != NULL; ent = ent->spawnNode.Next() ) {
				if ( ent->cinematic || ent->fl.isDormant ) {
					// only kill entities that aren't needed for cinematics and aren't dormant
					continue;
				}
				

// jnewquist: Use accessor for static class type 
				if ( ent->IsType( idProjectile::GetClassType() ) ) {

					// remove all projectiles
				} else if ( ent->spawnArgs.GetBool( "cinematic_remove" ) ) {
					// remove anything marked to be removed during cinematics
				} else {
					// ignore everything else
					continue;
				}

				// remove it
				DPrintf( "removing '%s' for cinematic\n", ent->GetName() );
				ent->PostEventMS( &EV_Remove, 0 );
			}
		}

	} else {
		inCinematic = false;
		cinematicStopTime = time + msec;

		// restore r_znear
		cvarSystem->SetCVarFloat( "r_znear", 3.0f );

		// show all the player models
		for( i = 0; i < numClients; i++ ) {
			if ( entities[ i ] ) {
				idPlayer *client = static_cast< idPlayer* >( entities[ i ] );
				client->ExitCinematic();
			}
		}
	}
}


// jscott: for portal skies
/*
=============
idGameLocal::GetPortalSky
=============
*/
idCamera *idGameLocal::GetPortalSky( void ) const
{
	if( !portalSkyVisible ) {

		return( NULL );
	}
	return( portalSky );
}
/*
=============
idGameLocal::SetPortalSky
=============
*/
void idGameLocal::SetPortalSky( idCamera *cam ) 
{
	portalSky = cam;
}


/*
=============
idGameLocal::GetCamera
=============
*/
idCamera *idGameLocal::GetCamera( void ) const {
	return camera;
}

/*
=============
idGameLocal::SkipCinematic
=============
*/
bool idGameLocal::SkipCinematic( void ) {
	if ( camera ) {
		if ( camera->spawnArgs.GetBool( "disconnect" ) ) {
			camera->spawnArgs.SetBool( "disconnect", false );
			cvarSystem->SetCVarFloat( "r_znear", 3.0f );
			cmdSystem->BufferCommandText( CMD_EXEC_APPEND, "disconnect\n" );
			skipCinematic = false;
			return false;
		}

		if ( camera->spawnArgs.GetBool( "instantSkip" ) ) {
			camera->Stop();
			return false;
		}
	}

	soundSystem->SetMute( true );
	if ( !skipCinematic ) {
		skipCinematic = true;
		cinematicMaxSkipTime = gameLocal.time + SEC2MS( g_cinematicMaxSkipTime.GetFloat() );
	}

	return true;
}


/*
======================
idGameLocal::StartViewEffect

For passing in an effect triggered view effect
======================
*/
void idGameLocal::StartViewEffect( int type, float time, float scale )
{
	idPlayer		*player;
	idPlayerView	*view;

	player = GetLocalPlayer();
	if( player )
	{
		view = &player->playerView;

		switch( type )
		{
		case VIEWEFFECT_DOUBLEVISION:
			view->SetDoubleVisionParms( time, scale );
			break;

		case VIEWEFFECT_SHAKE:
			//if( !gameLocal.isMultiplayer ) {
			//	view->SetShakeParms( time, scale );
			//}
			break;

		case VIEWEFFECT_TUNNEL:
			view->SetTunnelParms( time, scale );
			break;

		default:
			gameLocal.Warning( "Invalid view effect" );
			break;
		}
	}
}

/*
======================
idGameLocal::GetPlayerView
======================
*/
void idGameLocal::GetPlayerView( idVec3 &origin, idMat3 &axis )
{
	idPlayer		*player;
	renderView_t	*view;

	player = GetLocalPlayer();
	if( player )
	{
		view = player->GetRenderView();
		origin = view->vieworg;
		axis = view->viewaxis;
	}
	else
	{
		origin = vec3_origin;
		axis = mat3_identity;
	}
}

/*
======================
idGameLocal::Translation

small portion of physics required for the effects system
======================
*/
void idGameLocal::Translation( trace_t &trace, idVec3 &source, idVec3 &dest, idTraceModel *trm, int clipMask ) {	

	if( !trm ) {
		clip.Translation( trace, source, dest, NULL, mat3_identity, clipMask, NULL, NULL );
	}
	else {
		idClipModel		cm;
	
		cm.LoadModel( *trm, NULL );
		clip.Translation( trace, source, dest, &cm, mat3_identity, clipMask, NULL, NULL );
	}
}

/*
===================
idGameLocal::Translation
===================
*/
bool idGameLocal::Translation( trace_t &results, const idVec3 &start, const idVec3 &end, const idClipModel *mdl, const idMat3 &trmAxis, int contentMask, const idEntity *passEntity, const idEntity *passEntity2 ) {

	return clip.Translation( results, start, end, mdl, trmAxis, contentMask, passEntity, passEntity2 );
}

/*
======================
idGameLocal::SpawnClientMoveable
======================
*/
void idGameLocal::SpawnClientMoveable( const char* name, int lifetime, const idVec3& origin, const idMat3& axis, const idVec3& velocity, const idVec3& angular_velocity ) {
	// find the debris def
	const idDict* args = gameLocal.FindEntityDefDict( name, false );
	if ( !args ) {
		return;
	}

	// Ensure client moveables never last forever
	if ( lifetime <= 0 ) {
		lifetime = SEC2MS(args->GetFloat( "duration", "5" ));
	}
	int burn_time = idMath::ClampInt( 0, lifetime, SEC2MS(args->GetFloat( "burn_time", "2.5" )) );
	
	// Spawn the debris
	rvClientMoveable* cent = NULL;
	// force the args to spawn a rvClientMoveable
	SpawnClientEntityDef( *args, (rvClientEntity**)(&cent), false, "rvClientMoveable" );
	
	if( !cent ) {
		return;
	}

	cent->SetOrigin( origin );
	cent->SetAxis( axis );
		
	cent->GetPhysics()->SetLinearVelocity( velocity );
	cent->GetPhysics()->SetAngularVelocity( angular_velocity );

	if ( !burn_time ) {
		//just disappear
		cent->PostEventMS( &EV_Remove, lifetime );	
	} else {
		cent->PostEventMS( &CL_FadeOut, lifetime-burn_time, burn_time );
	}
}

/*
======================
idGameLocal::DebugSet
======================
*/
void idGameLocal::DebugSetString( const char* name, const char* value ) {
	gameDebug.SetString( name, value );
}
void idGameLocal::DebugSetFloat( const char* name, float value ) {
	gameDebug.SetFloat( name, value );
}
void idGameLocal::DebugSetInt( const char* name, int value ) {
	gameDebug.SetInt( name, value );
}

/*
======================
idGameLocal::DebugGetStat
======================
*/
const char* idGameLocal::DebugGetStatString ( const char* name ) {
	return gameDebug.GetStatString( name );
}

int idGameLocal::DebugGetStatInt ( const char* name ) {
	return gameDebug.GetStatInt( name );
}

float idGameLocal::DebugGetStatFloat ( const char* name ) {
	return gameDebug.GetStatFloat( name );
}

/*
======================
idGameLocal::IsDebugHudActive
======================
*/
bool idGameLocal::IsDebugHudActive ( void ) const {
	return gameDebug.IsHudActive( DBGHUD_ANY );
}


// rjohnson: added player info support for note taking system
/*
======================
idGameLocal::GetPlayerInfo
======================
*/
bool idGameLocal::GetPlayerInfo( idVec3 &origin, idMat3 &axis, int PlayerNum, idAngles *deltaViewAngles, int reqClientNum ) {
	idPlayer	*player;

	if ( PlayerNum == -1 ) {
		player = GetLocalPlayer();
	} else {
		player = GetClientByNum( PlayerNum );
	}

	if ( !player ) {
		return false;
	}

	player->GetViewPos( origin, axis );
	origin = player->GetPhysics()->GetOrigin();

	if ( deltaViewAngles ) {
		*deltaViewAngles = player->GetDeltaViewAngles();
	}

	return true;
};

/*
======================
idGameLocal::SetCurrentPlayerInfo
======================
*/
void idGameLocal::SetPlayerInfo( idVec3 &origin, idMat3 &axis, int PlayerNum ) {
	idPlayer	*player;

	if ( PlayerNum == -1 ) {
		player = GetLocalPlayer();
	} else {
		player = GetClientByNum( PlayerNum );
	}

	if ( !player ) {
		return;
	}

	player->Teleport( origin, axis.ToAngles(), NULL );

	player->CalculateFirstPersonView();
	player->CalculateRenderView();

	return;
};

bool idGameLocal::PlayerChatDisabled( int clientNum ) {
	if( clientNum < 0 || clientNum >= MAX_CLIENTS || !entities[ clientNum ] ) {
		return false;
	}

	return !( ((idPlayer*)entities[ clientNum ])->isChatting || ((idPlayer*)entities[ clientNum ])->pfl.dead );
}

void idGameLocal::SetViewComments( const char *text ) {
	return;
}

/*
===================
idGameLocal::GetNumGravityAreas
===================
*/
int	idGameLocal::GetNumGravityAreas() const {
	return gravityInfo.Num();
}

/*
===================
idGameLocal::GetGravityInfo
===================
*/
const rvGravityArea* idGameLocal::GetGravityInfo( int index ) const {
	return gravityInfo[ index ];
}

/*
===================
idGameLocal::SetGravityArea
===================
*/
void idGameLocal::SetGravityInfo( int index, rvGravityArea* info ) {
	gravityInfo[ index ] = info;
}

/*
===================
idGameLocal::AddUniqueGravityInfo
===================
*/
void idGameLocal::AddUniqueGravityInfo( rvGravityArea* info ) {
	gravityInfo.AddUnique( info );
}

/*
===================
idGameLocal::GetCurrentGravityInfoIndex
===================
*/
int idGameLocal::GetCurrentGravityInfoIndex( const idVec3& origin ) const {
	int numGravityAreas = GetNumGravityAreas();
	if( !numGravityAreas ) {
		return -1;
	}

	int areaNum = gameRenderWorld->PointInArea( origin );

	for( int ix = 0; ix < numGravityAreas; ++ix ) {
		if( !gameRenderWorld->AreasAreConnected(GetGravityInfo(ix)->GetArea(), areaNum, PS_BLOCK_GRAVITY) ) {
			continue;
		}
		 
		return ix;
	}

	return -1;
}

/*
===================
idGameLocal::InGravityArea
===================
*/
bool idGameLocal::InGravityArea( idEntity* entity ) const {
	return GetCurrentGravityInfoIndex( entity ) >= 0;
}

/*
===================
idGameLocal::GetCurrentGravityInfoIndex
===================
*/
int idGameLocal::GetCurrentGravityInfoIndex( idEntity* entity ) const {
	return GetCurrentGravityInfoIndex( entity->GetPhysics()->GetOrigin() );
}

/*
===================
idGameLocal::GetCurrentGravity
===================
*/
const idVec3 idGameLocal::GetCurrentGravity( idEntity* entity ) const {
	int index = GetCurrentGravityInfoIndex( entity );
	return (index >= 0) ? gravityInfo[ index ]->GetGravity(entity) : GetGravity();
}

/*
===================
idGameLocal::GetCurrentGravity
===================
*/
const idVec3 idGameLocal::GetCurrentGravity( const idVec3& origin, const idMat3& axis ) const {
	int index = GetCurrentGravityInfoIndex( origin );
	return (index >= 0) ? gravityInfo[ index ]->GetGravity(origin, axis, MASK_SOLID, NULL) : GetGravity();
}

/*
===================
idGameLocal::InGravityArea
===================
*/
bool idGameLocal::InGravityArea( rvClientEntity* entity ) const {
	return GetCurrentGravityInfoIndex( entity ) >= 0;
}

/*
===================
idGameLocal::GetCurrentGravityInfoIndex
===================
*/
int idGameLocal::GetCurrentGravityInfoIndex( rvClientEntity* entity ) const {
	return GetCurrentGravityInfoIndex( entity->GetPhysics()->GetOrigin() );
}

/*
===================
idGameLocal::GetCurrentGravity
===================
*/
const idVec3 idGameLocal::GetCurrentGravity( rvClientEntity* entity ) const {
	int index = GetCurrentGravityInfoIndex( entity );
	return (index >= 0) ? gravityInfo[ index ]->GetGravity(entity) : GetGravity();
}

/*
===================
idGameLocal::ReferenceScriptObjectProxy
===================
*/
idEntity* idGameLocal::ReferenceScriptObjectProxy( const char* scriptObjectName ) {
	idEntity*		proxy = NULL;
	idEntityPtr<idEntity> safeProxy;
	idDict			args;
	idScriptObject* object = NULL;

	for( int ix = 0; ix < scriptObjectProxies.Num(); ++ix ) {
		proxy = scriptObjectProxies[ ix ].GetEntity();
		assert( proxy );
		
		object = &proxy->scriptObject;
		if( !object->data ) {
			object->SetType( scriptObjectName );
			proxy->ConstructScriptObject();
			return proxy;
		}
	}

	args.Set( "classname", "func_static" );
	args.Set( "scriptobject", scriptObjectName );
	args.SetBool( "noclipmodel", true );
	bool spawned = SpawnEntityDef(args, &proxy);
	if ( !spawned ) {
		assert( 0 );
	}
	safeProxy = proxy;
	scriptObjectProxies.AddUnique( safeProxy );
	return proxy;
}

/*
===================
idGameLocal::ReleaseScriptObjectProxy
===================
*/
void idGameLocal::ReleaseScriptObjectProxy( const char* proxyName ) {
	idScriptObject* object = NULL;
	idEntity*		entity = NULL;

	for( int ix = 0; ix < scriptObjectProxies.Num(); ++ix ) {
		entity = scriptObjectProxies[ ix ].GetEntity();
		if( entity && !idStr::Icmp(entity->GetName(), proxyName) ) {
			object = &entity->scriptObject;
			if( !object ) {
				continue;
			}
			
			entity->DeconstructScriptObject();
			object->Free();
		}
	}
}


// rjohnson: entity usage stats
void idGameLocal::ListEntityStats( const idCmdArgs &args ) {
	int				i, j;
	idStr			currentMap;
	idList<idStr>	uniqueMapNames;


	for( i = 1; i < args.Argc(); i++ ) {
		if ( idStr::Icmp( args.Argv( i ), "clear" ) == 0 ) {
			entityUsageList.Clear();
			common->Printf("Entity stats cleared.\n");
			return;
		}
	}

	for( i = 0; i < entityUsageList.Num(); i++ ) {
		entityUsageList[ i ].SetInt( "reported_stat", false );
	}

	for( i = 0; i < entityUsageList.Num(); i++ ) {
		idStr	mapFileName, className;
		int		count;

		if ( entityUsageList[ i ].GetInt( "reported_stat" ) ) {
			continue;
		}

		entityUsageList[ i ].GetString( "mapFileName", "none", mapFileName );
		if ( currentMap != mapFileName )
		{
			if ( i ) {
				common->Printf( "\n" );
			}
			common->Printf( "================ %s ================\n", mapFileName.c_str() );
			currentMap = mapFileName;
			uniqueMapNames.Insert( mapFileName );
		}

		entityUsageList[ i ].GetString( "classname", "none", className );
		count = 0;

		for( j = i; j < entityUsageList.Num(); j++ ) {
			idStr	checkMapFileName, checkClassName;

			entityUsageList[ j ].GetString( "mapFileName", "none", checkMapFileName );
			if ( checkMapFileName != mapFileName ) {
				break;
			}

			entityUsageList[ j ].GetString( "classname", "none", checkClassName );

			if ( checkClassName == className ) {
				entityUsageList[ j ].SetInt( "reported_stat", 1 );
				count++;
			}
		}

		common->Printf("%d\t%s\n", count, className.c_str() );
	}

	common->Printf( "\n" );
	common->Printf( "\n" );
	common->Printf( "================ OVERALL ================\n" );

	for( i = 0; i < entityUsageList.Num(); i++ ) {
		idStr	mapFileName, className;
		int		count;

		if ( entityUsageList[ i ].GetInt( "reported_stat" ) == 2 ) {
			continue;
		}

		entityUsageList[ i ].GetString( "classname", "none", className );
		count = 0;

		for( j = i; j < entityUsageList.Num(); j++ ) {
			idStr	checkClassName;

			entityUsageList[ j ].GetString( "classname", "none", checkClassName );

			if ( checkClassName == className ) {
				entityUsageList[ j ].SetInt( "reported_stat", 2 );
				count++;
			}
		}

		common->Printf("%d\t%s\n", count, className.c_str() );
	}

	idFile *FH = fileSystem->OpenFileWrite( "EntityStats.csv" );
	if ( FH ) {
		int	size = sizeof( int ) * uniqueMapNames.Num();
		int	*count = ( int * )_alloca( size );

		FH->Printf("\"Definition\"");
		for( i = 0; i < uniqueMapNames.Num(); i++ ) {
			FH->Printf( ",\"%s\"", uniqueMapNames[ i ].c_str() );
		}
		FH->Printf(",Total\n");

		for( i = 0; i < entityUsageList.Num(); i++ ) {
			idStr	className;
			int		total;

			if ( entityUsageList[ i ].GetInt( "reported_stat" ) == 3 ) {
				continue;
			}

			entityUsageList[ i ].GetString( "classname", "none", className );

			memset( count, 0, size );
			for( j = i; j < entityUsageList.Num(); j++ )
			{
				idStr	checkMapFileName, checkClassName;

				entityUsageList[ j ].GetString( "classname", "none", checkClassName );

				if ( checkClassName == className ) {
					entityUsageList[ j ].SetInt( "reported_stat", 3 );
					entityUsageList[ j ].GetString( "mapFileName", "none", checkMapFileName );

					int loc = uniqueMapNames.FindIndex( checkMapFileName );
					if ( loc >= 0 ) {
						count[ loc ]++;
					}
				}
			}

			total = 0;
			FH->Printf( "\"%s\"", className.c_str() );
			for( j = 0; j < uniqueMapNames.Num(); j++ ) {
				FH->Printf( ",%d", count[ j ] );
				total += count[ j ];
			}
			FH->Printf( ",%d\n", total );
		}

		fileSystem->CloseFile( FH );
	}
}


/*
======================
idGameLocal::SpreadLocations

Now that everything has been spawned, associate areas with location entities
======================
*/
void idGameLocal::SpreadLocations() {

	//locationCollection.Init( mapFileNameStripped.c_s

	/*idEntity *ent;


	if( !gameRenderWorld ) {
		common->Error( "GameRenderWorld is NULL!" );
	}


	// allocate the area table
	int	numAreas = gameRenderWorld->NumAreas();
	locationEntities = new idLocationEntity *[ numAreas ];
	memset( locationEntities, 0, numAreas * sizeof( *locationEntities ) );

	// for each location entity, make pointers from every area it touches
	for( ent = spawnedEntities.Next(); ent != NULL; ent = ent->spawnNode.Next() ) {

// jnewquist: Use accessor for static class type 
		if ( !ent->IsType( idLocationEntity::GetClassType() ) ) {

			continue;
		}
		idVec3	point = ent->spawnArgs.GetVector( "origin" );
		int areaNum = gameRenderWorld->PointInArea( point );
		if ( areaNum < 0 ) {
			Printf( "SpreadLocations: location '%s' is not in a valid area\n", ent->spawnArgs.GetString( "name" ) );
			continue;
		}
		if ( areaNum >= numAreas ) {
			Error( "idGameLocal::SpreadLocations: areaNum >= gameRenderWorld->NumAreas()" );
		}
		if ( locationEntities[areaNum] ) {
			Warning( "location entity '%s' overlaps '%s'", ent->spawnArgs.GetString( "name" ),
				locationEntities[areaNum]->spawnArgs.GetString( "name" ) );
			continue;
		}
		locationEntities[areaNum] = static_cast<idLocationEntity *>(ent);

		// spread to all other connected areas
		for ( int i = 0 ; i < numAreas ; i++ ) {
			if ( i == areaNum ) {
				continue;
			}
			if ( gameRenderWorld->AreasAreConnected( areaNum, i, PS_BLOCK_LOCATION ) ) {
				locationEntities[i] = static_cast<idLocationEntity *>(ent);
			}
		}
	}*/
}

/*
===================
idGameLocal::AddLocation
===================
*/
idLocationEntity* idGameLocal::AddLocation ( const idVec3& point, const char* name ) {
	/*int areaNum = gameRenderWorld->PointInArea( point );
	if ( areaNum < 0 ) {
		Warning ( "idGameLocal::AddLocation: cannot add location entity '%s' at '%g %g %g'\n", name, point.x, point.y, point.z );
		return NULL;
	}
	if ( areaNum >= gameRenderWorld->NumAreas() ) {
		Error( "idGameLocal::AddLocation: areaNum >= gameRenderWorld->NumAreas()" );
	}
	if ( locationEntities[areaNum] ) {
		Warning ( "idGameLocal::AddLocation: location '%s' already exists at '%g %g %g'\n", locationEntities[areaNum]->GetName(), point.x, point.y, point.z );
		return NULL;
	}

	// Spawn the new location entity
	idDict args;
	args.Set ( "location", name );
	locationEntities[areaNum] = static_cast<idLocationEntity*>(SpawnEntityType ( idLocationEntity::GetClassType(), &args ));

	// spread to all other connected areas
	for ( int i = gameRenderWorld->NumAreas() - 1 ; i >= 0 ; i-- ) {
		if ( i == areaNum ) {
			continue;
		}
		if ( gameRenderWorld->AreasAreConnected( areaNum, i, PS_BLOCK_LOCATION ) ) {
			locationEntities[i] = static_cast<idLocationEntity *>(locationEntities[areaNum]);
		}
	}
	
	return locationEntities[areaNum];*/
	return NULL;
}

/*
===================
idGameLocal::LocationForPoint

The player checks the location each frame to update the HUD text display
May return NULL
===================
*/
idLocationEntity * idGameLocal::LocationForPoint( const idVec3 &point ) {
	/*if ( !locationEntities ) {
		// before SpreadLocations() has been called
		return NULL;
	}

	int areaNum = gameRenderWorld->PointInArea( point );
	if ( areaNum < 0 ) {
		return NULL;
	}
	if ( areaNum >= gameRenderWorld->NumAreas() ) {
		Error( "idGameLocal::LocationForPoint: areaNum >= gameRenderWorld->NumAreas()" );
	}

	return locationEntities[ areaNum ];
	*/
	return NULL;
}

q4fLocation* idGameLocal::LocationForPointQ4F( const idVec3 &point ) {
	return locationCollection.LocationForPoint( point );
}

q4fLocation* idGameLocal::AddLocation( const idVec3 &point, const char* name, int teamNum ) {
	q4fLocation* loc = locationCollection.AddLocation( point, name, teamNum );
	locationCollection.Save();
	return loc;
}

bool idGameLocal::RemoveLocation( int index ) {
	if ( locationCollection.RemoveLocationIndex( index ) ) {
		locationCollection.Save();
		return true;
	}

	return false;
}

void idGameLocal::PrintLocations() {
	locationCollection.PrintLocationIndices();
}

void idGameLocal::RefreshLocationStrings() {
	locationCollection.RefreshLocationStrings();
}

/*
============
idGameLocal::SetPortalState
============
*/
void idGameLocal::SetPortalState( qhandle_t portal, int blockingBits ) {
	idBitMsg outMsg;
	byte msgBuf[ MAX_GAME_MESSAGE_SIZE ];

	if ( !gameLocal.isClient ) {
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_PORTAL );
		outMsg.WriteLong( portal );
		outMsg.WriteBits( blockingBits, NUM_RENDER_PORTAL_BITS );
		networkSystem->ServerSendReliableMessage( -1, outMsg );
	}
	gameRenderWorld->SetPortalState( portal, blockingBits );
}


// ddynerman: new gametype specific spawn code
// TODO this should be moved to idMultiplayerGame
/*
===========
idGameLocal::InitializeSpawns
============
*/
void idGameLocal::InitializeSpawns( void ) {
	if ( isClient ) {
		return;
	}

//	tfGame.InitSpawns();
}

/*
===========
idGameLocal::SpotWouldTelefrag
===========
*/
bool idGameLocal::SpotWouldTelefrag( idPlayer* player, q4fPlayerStart* spawn ) {
	idPlayer*	playerList[ MAX_CLIENTS ];
	idBounds	bound = player->GetPhysics()->GetBounds();

	bound.TranslateSelf( spawn->GetPhysics()->GetOrigin() );
	int numEntities = clip.PlayersTouchingBounds( bound, CONTENTS_BODY, playerList, MAX_CLIENTS );

	return !( numEntities == 0 );

}

/*
===========
idGameLocal::SelectSpawnSpot
===========
*/
idEntity* idGameLocal::SelectSpawnPoint( idPlayer* player ) {
	if( player == NULL ) {
		return NULL;
	}

	// 3j_todo: start spectators at intermission camera
	idList<q4fPlayerStart*> validSpots;	

	for ( int i = 0; i < spawnSpots.Num(); i++ ) {
		// 3j_todo: spawn types
		// 3j_todo: check if spawn spot is enabled && not spec
		// 3j_todo: check if spawn spot is clear ( no telefrag ) and not spec ( rocket arena: waiting for spawn )
		if ( gameLocal.spawnSpots[i]->team == player->team && !SpotWouldTelefrag( player, gameLocal.spawnSpots[i] ) ) {
			validSpots.Append( gameLocal.spawnSpots[i] );
		}	
	}

	if ( validSpots.Num() > 0 ) {
		return validSpots[ random.RandomInt( validSpots.Num() - 1 ) ];
	}

	if ( player->spectating && player->wantSpectate && gameLocal.spawnSpots.Num() > 0 ) {
		return gameLocal.spawnSpots[ random.RandomInt( gameLocal.spawnSpots.Num() - 1 ) ];
	}

	// 3j_todo: don't error?
	//Error( "Could not find a spawn spot for player %s on team %d\n", player->GetUserInfo()->GetString( "ui_name" ), player->team + 1 );

	return NULL;
}

/*
================
idGameLocal::UpdateServerInfoFlags
================
*/

// ddynerman: new gametype strings
void idGameLocal::SetGameType( const char* mapName ) {
	si_gameType.SetString( "Q4F" );

	mpGame.SetGameType( mapName );
}


/*
================
idGameLocal::SetGlobalMaterial
================
*/
void idGameLocal::SetGlobalMaterial( const idMaterial *mat ) {
	globalMaterial = mat;
}

/*
================
idGameLocal::GetGlobalMaterial
================
*/
const idMaterial *idGameLocal::GetGlobalMaterial() {
	return globalMaterial;
}

/*
================
idGameLocal::GetSpawnId
================
*/
int idGameLocal::GetSpawnId( const idEntity* ent ) const {
	return ( gameLocal.spawnIds[ ent->entityNumber ] << GENTITYNUM_BITS ) | ent->entityNumber;
}

/*
================
idGameLocal::ThrottleUserInfo
================
*/
void idGameLocal::ThrottleUserInfo( void ) {
	mpGame.ThrottleUserInfo();
}

/*
===========
idGameLocal::ValidateServerSettings
============
*/
bool idGameLocal::ValidateServerSettings( const char* map, const char* gametype ) {
	return true;
}


/*
===========
idGameLocal::GetBestGameType
============
*/
/*idStr idGameLocal::GetBestGameType( const char* map, const char* gametype ) {
	return gametype;
}*/

/*
===========
idGameLocal::NeedRestart
============
*/
bool idGameLocal::NeedRestart() {

	idDict		newInfo;
	const idKeyValue *keyval, *keyval2;

	newInfo = *cvarSystem->MoveCVarsToDict( CVAR_SERVERINFO );

	for ( int i = 0; i < newInfo.GetNumKeyVals(); i++ ) {
		keyval = newInfo.GetKeyVal( i );
		keyval2 = serverInfo.FindKey( keyval->GetKey() );
		if ( !keyval2 ) {
			return true;
		}
		// a select set of si_ changes will cause a full restart of the server
//		if ( keyval->GetValue().Icmp( keyval2->GetValue() ) && ( !keyval->GetKey().Icmp( "si_pure" ) || !keyval->GetKey().Icmp( "si_map" ) ) ) {
		if ( keyval->GetValue().Icmp( keyval2->GetValue() ) && ( !keyval->GetKey().Icmp( "si_pure" ) || !keyval->GetKey().Icmp( "si_map" ) || !keyval->GetKey().Icmp( "si_fps" ) ) ) {
			return true;
		}
	}
	return false;
}


// jshepard: update player hud to alert to end of level
/*
===================
idGameLocal::UpdateEndLevel
===================
*/
void idGameLocal::UpdateEndLevel()	{
	idPlayer * player = GetLocalPlayer();

	if( player && player->GetHud() ) {
		player->GetHud()->HandleNamedEvent( "showExit" );
	}
}


// bdube: added
/*
================
idGameLocal::GetEffect

Get the handle of the effect with the given name
================
*/
const idDecl *idGameLocal::GetEffect ( const idDict& args, const char* effectName, const rvDeclMatType* materialType ) {
	const char *effectFile = NULL;

	/*float chance = args.GetFloat ( idStr("effectchance ") + effectName, "1" );	
	if ( random.RandomFloat ( ) > chance ) {
		return NULL;
	}*/

	// we should ALWAYS be playing sounds from the def.
	// hardcoded sounds MUST be avoided at all times because they won't get precached.
	if( idStr::Icmpn( effectName, "fx_", 3 ) ) {
		gameLocal.Warning( "idGameLocal::GetEffect - the effect '%s' does not begin with 'fx_', cannot play.", effectName );
		return NULL;
	}

	if ( materialType )	{
		idStr		temp;
		const char*	result = NULL;
		
		temp = effectName;
		temp += "_";
		temp += materialType->GetName();
	
		// See if the given material effect is specified
		/*if ( isMultiplayer ) {		// 3j_todo
			idStr	testMP = temp;
			testMP += "_mp";

			result = args.GetString( testMP );
		}
		if ( !result || !*result ) {*/
			result = args.GetString( temp );
		//}
		if ( result && *result) {
			return( ( const idDecl * )declManager->FindEffect( result ) );
		}
	}	

	// grab the non material effect name
	/*if ( isMultiplayer ) {		// 3j_todo
		idStr	testMP = effectName;
		testMP += "_mp";

		effectFile = args.GetString( testMP );
	}

	if ( !effectFile || !*effectFile ) {*/
		effectFile = args.GetString( effectName );
	//}

	if ( !effectFile || !*effectFile ) {
		return NULL;
	}

	return( ( const idDecl * )declManager->FindEffect( effectFile ) );
}

/*
================
idGameLocal::PlayEffect

Plays an effect at the given origin using the given direction
================
*/
rvClientEffect* idGameLocal::PlayEffect( 
	const idDecl			*effect, 
	const idVec3&			origin, 
	const idMat3&			axis, 
	bool					loop, 
	const idVec3&			endOrigin, 
	bool					broadcast,
	effectCategory_t		category,
	const idVec4&			effectTint ) {

	if ( !effect ) {
		return NULL;
	}

	if ( !gameLocal.isNewFrame ) {
		return NULL;
	}

	if ( isServer && broadcast ) {
		bool sendEnd = false;

		idBitMsg	msg;
		byte		msgBuf[MAX_GAME_MESSAGE_SIZE];
		idCQuat		quat;

		quat = axis.ToCQuat();
		msg.Init( msgBuf, sizeof( msgBuf ) );
		msg.BeginWriting();
		msg.WriteByte( GAME_UNRELIABLE_MESSAGE_EFFECT );
		idGameLocal::WriteDecl( msg, effect );
		msg.WriteFloat( origin.x );
		msg.WriteFloat( origin.y );
		msg.WriteFloat( origin.z );
		msg.WriteFloat( quat.x );
		msg.WriteFloat( quat.y );
		msg.WriteFloat( quat.z );
		msg.WriteBits( loop, 1 );
		if ( endOrigin != vec3_zero ) {
			sendEnd = true;
			msg.WriteBits( 1, 1 );
			msg.WriteFloat( endOrigin.x );
			msg.WriteFloat( endOrigin.y );
			msg.WriteFloat( endOrigin.z );
		}
		else {
			msg.WriteBits( 0, 1 );
		}

		msg.WriteByte( category );

		// send to everyone who has start or end in it's PVS
		SendUnreliableMessagePVS( msg, pvs.GetPVSArea( origin ), sendEnd ? pvs.GetPVSArea( endOrigin ) : -1 );
	}

	if ( isServer && localClientNum < 0 ) {
		// no effects on dedicated server
		return NULL;
	}

	if ( bse->Filtered( effect->GetName(), category ) ) {
		// Effect filtered out
		return NULL;
	}
	
	// mwhitlock: Dynamic memory consolidation
	RV_PUSH_SYS_HEAP_ID(RV_HEAP_ID_MULTIPLE_FRAME);
	rvClientEffect* clientEffect = new rvClientEffect( effect );
	RV_POP_HEAP();

	if( !clientEffect ) {
		common->Warning( "Failed to create effect \'%s\'\n", effect->GetName() );
		return NULL;
	}

	if( clientEffect->entityNumber == -1 ) {
		common->Warning( "Failed to spawn effect \'%s\'\n", effect->GetName() );
		delete clientEffect;
		return NULL;
	}

	clientEffect->SetOrigin( origin );
	clientEffect->SetAxis( axis );
	clientEffect->SetGravity( GetCurrentGravity( origin, axis ) );
	if ( !clientEffect->Play( gameLocal.time, loop, endOrigin ) ) {
		delete clientEffect;
		return NULL;
	}

	clientEffect->GetRenderEffect()->shaderParms[ SHADERPARM_RED ]		= effectTint[ 0 ];
	clientEffect->GetRenderEffect()->shaderParms[ SHADERPARM_GREEN ]	= effectTint[ 1 ];
	clientEffect->GetRenderEffect()->shaderParms[ SHADERPARM_BLUE ]		= effectTint[ 2 ];
	clientEffect->GetRenderEffect()->shaderParms[ SHADERPARM_ALPHA ]	= effectTint[ 3 ];

	return clientEffect;
}

void idGameLocal::CheckPlayerWhizzBy( idVec3 start, idVec3 end, idEntity* hitEnt, idEntity *attacker )
{
	//FIXME: make this client-side?  Work in MP?		// 3j_todo
	if ( gameLocal.isMultiplayer || true ) {
		return;
	}
	idPlayer* player = gameLocal.GetLocalPlayer();
	if ( !player ) {
		return;
	}
	if ( player->IsHidden() ) {
		return;
	}
	if ( player == attacker ) {
		return;
	}
	if ( player == hitEnt ) {
		return;
	}
	idVec3 center = player->firstPersonViewOrigin;
	idVec3 diff = end-center;
	if ( diff.Length() < 64.0f ) {
		//hit too close - didn't actually pass by, will hear impact sound instead
		return;
	}
	idVec3 closestPoint = player->firstPersonViewOrigin;
	if ( closestPoint.ProjectToLineSeg( start, end ) ) {
		//on line seg
		diff = closestPoint-center;
		if ( diff.Length() < 48.0f ) {
			//close enough to hear whizz-by
			idVec3 dir = end-start;
			dir.Normalize();
			idVec3 fxStart = closestPoint+dir*-32.0f;
			idVec3 fxEnd = closestPoint+dir*32.0f;
			player->PlayEffect( "fx_whizby", fxStart, player->firstPersonViewAxis, false, fxEnd );
		}
	}
}

#define PENETRATE_DIST 128.0f

/*
================
idGameLocal::HitScan

Run a hitscan trace from the given origin and direction
================
*/
idEntity* idGameLocal::HitScan(
	const AttackerInfo &attacker,
	const idDict	&attackDict,
	float			damageScale,
	idVec3			&dir,

	const idVec3&	origOrigin, 
	const idVec3&	origFxOrigin, 
	bool			noFX,
// twhitaker: added additionalIgnore parameter
	idEntity*		additionalIgnore,
	int				areas[ 2 ]
	) {

	idVec3		origin;
	idVec3		fxOrigin;
	idVec3		fxDir;
	idVec3		impulse;
	int			reflect;
	float		tracerChance;
	idEntity*	owner;
	float		penetrate;

	TFDamage myDamage;


	const char* dmgDirect = attackDict.GetString( "def_damage_direct", "" );
	const char* dmgHead = attackDict.GetString( "def_damage_head", "" );
	const char* dmgLegs = attackDict.GetString( "def_damage_legs", "" );

	if ( areas ) {
		areas[ 0 ] = pvs.GetPVSArea( origFxOrigin );
		areas[ 1 ] = -1;
	}

	owner    = attacker.GetEntity();
	penetrate = attackDict.GetFloat( "penetrate" );

	// twhitaker: additionalIgnore parameter
	if ( !additionalIgnore ) {
		additionalIgnore = owner;
	}	

	origin		 = origOrigin;
	fxOrigin	 = origFxOrigin;
	tracerChance = attackDict.GetFloat( "tracerchance", "0" );

	gameLocal.PlayEffect( attackDict, "fx_fire", fxOrigin, dir.ToMat3() );

	// Run reflections
	for ( reflect = attackDict.GetFloat( "reflect", "0" ); reflect >= 0; reflect-- ) {	
		idVec3		start;
		idVec3		end;
		idEntity*	ent;
		idEntity*	actualHitEnt;
		trace_t		tr;
		modelTrace_t modelTrace;
		int			contents;
		int			collisionArea;
		idVec3		collisionPoint;
		bool		tracer;
		
		// Calculate the end point of the trace
		start    = origin;



		end		 = start + (dir.ToMat3() * idVec3(attackDict.GetFloat ( "range", "40000" ),0,0));




		contents = MASK_SHOT_RENDERMODEL|CONTENTS_WATER|CONTENTS_PROJECTILECLIP;

		
		// Loop the traces to handle cases where something can be shot through
		while ( 1 ) {				























			clip.TracePoint( tr, start, end, contents, additionalIgnore );


			// If the hitscan hit a no impact surface we can just return out
			//assert( tr.c.material );
			if ( tr.fraction >= 1.0f || (tr.c.material && tr.c.material->GetSurfaceFlags() & SURF_NOIMPACT) ) {					
				PlayEffect( attackDict, "fx_path", fxOrigin, dir.ToMat3(), false, tr.endpos, false, EC_IGNORE );	
				if ( random.RandomFloat( ) < tracerChance ) {
					PlayEffect( attackDict, "fx_tracer", fxOrigin, dir.ToMat3(), false, tr.endpos );
					tracer = true;
				} else {
					tracer = false;
				}

				if ( areas ) {
					collisionArea = pvs.GetPVSArea( tr.endpos );
					if ( collisionArea != areas[0] ) {
						areas[1] = collisionArea;
					}
				}

				return NULL;
			}

			// computing the collisionArea from the collisionPoint fails sometimes
			if ( areas ) {
				collisionArea  = pvs.GetPVSArea( tr.c.point );
				if ( collisionArea != areas[0] ) {
					areas[1] = collisionArea;
				}
			}
			collisionPoint = tr.c.point - ( tr.c.normal * tr.c.point - tr.c.dist ) * tr.c.normal;
			ent			   = entities[ tr.c.entityNum ];
			actualHitEnt   = NULL;
			start		   = collisionPoint;

			// Keep tracing if we hit water
			if ( (ent->GetPhysics()->GetContents() & CONTENTS_WATER) || (tr.c.material && (tr.c.material->GetContentFlags() & CONTENTS_WATER)) ) {
				// Apply force to the water entity that was hit
				ent->ApplyImpulse( owner, tr.c.id, tr.c.point, -(attackDict.GetFloat( "push", "5000" )) * tr.c.normal );
				// Continue on excluding water
				contents &= (~CONTENTS_WATER);


				if ( ent->CanPlayImpactEffect( owner, ent ) ) {
					if ( ent->IsType( idMover::GetClassType( ) ) ) {
						ent->PlayEffect( GetEffect( attackDict, "fx_impact", tr.c.materialType ), collisionPoint, tr.c.normal.ToMat3(), false, vec3_origin, false, EC_IMPACT );
					} else {
						gameLocal.PlayEffect( GetEffect( attackDict, "fx_impact", tr.c.materialType ), collisionPoint, tr.c.normal.ToMat3(), false, vec3_origin, false, EC_IMPACT );
					}
				}


				continue;
			// Reflect off a bounce target?
			} else if (  (tr.c.material->GetSurfaceFlags ( ) & SURF_BOUNCE) && !attackDict.GetBool ( "noBounce" ) ) {
				reflect++;
			}

			// If the hit entity is bound to an actor use the actor instead
			if ( ent->fl.takedamage && ent->GetTeamMaster( ) && ent->GetTeamMaster( )->IsType ( idActor::GetClassType() ) ) {
				actualHitEnt = ent;
				ent = ent->GetTeamMaster( );
			}

			if ( !gameLocal.isClient ) {

				// Apply force to the entity that was hit
				// 3j: this is called in damage
				//ent->ApplyImpulse( owner, tr.c.id, tr.c.point, -tr.c.normal, &hitscanDict );

				// Handle damage to the entity
				idEntity* damageEnt = NULL;
				if ( ent->fl.takedamage && !(( tr.c.material != NULL ) && ( tr.c.material->GetSurfaceFlags() & SURF_NODAMAGE )) ) {	
					damageEnt = ent;
				} else { 
					if ( actualHitEnt
						 && actualHitEnt != ent
						 && (tr.c.material->GetSurfaceFlags ( ) & SURF_BOUNCE)
						 && actualHitEnt->spawnArgs.GetBool( "takeBounceDamage" ) )
						{//bleh...
							damageEnt = actualHitEnt;
						}
				}

				if ( damageEnt ) {

					int hitJoint = CLIPMODEL_ID_TO_JOINT_HANDLE(tr.c.id);
					float hitOffset = -1.0f;

					if ( ent->IsType(idActor::GetClassType()) )	{
						idActor* entActor = static_cast<idActor*>(ent);
						if ( entActor && entActor->GetHead() && entActor->GetHead()->IsType(idAFAttachment::GetClassType()) ) {
							idAFAttachment* headEnt = static_cast<idAFAttachment*>(entActor->GetHead());
							if ( headEnt && headEnt->entityNumber == tr.c.entityNum ) {//hit ent's head, get the proper joint for the head
								hitJoint = entActor->GetAnimator()->GetJointHandle("head");
							}
						}


						idBounds pBounds = entActor->GetPhysics()->GetAbsBounds();


						hitOffset =  ( tr.endpos.z - pBounds.b[0].z ) / ( pBounds.b[1].z - pBounds.b[0].z );

						hitOffset = idMath::ClampFloat( 0.0f, 1.0f, hitOffset );
					}

					if ( hitOffset >= WATERLEVEL_HEAD && dmgHead && dmgHead[0] ) {
						myDamage.Create( attacker, dmgHead, damageScale );
					}
					else if ( hitOffset < WATERLEVEL_WAIST && dmgLegs && dmgLegs[0] ) {
						myDamage.Create( attacker, dmgLegs, damageScale );
					}
					else {
						myDamage.Create( attacker, dmgDirect, damageScale );
					}

					
					myDamage.SetDir( dir );
					myDamage.SetLocation( hitJoint );
					ent->Damage_TF( myDamage, 1.0f );
					ent->AddDamageEffect ( tr, dir, myDamage.GetDamageDef()->GetName(), owner );
				}
			}

			if ( penetrate > 0.0f && ent->IsType ( idActor::GetClassType() ) ) {
				start = collisionPoint;
				additionalIgnore = ent;
				damageScale *= penetrate;
				continue;
			}
			break;
		}
			
		// Path effect 
		fxDir = collisionPoint - fxOrigin;
		fxDir.Normalize( );
		PlayEffect( attackDict, "fx_path", fxOrigin, fxDir.ToMat3(), false, collisionPoint, false, EC_IGNORE );	
		if ( !ent->fl.takedamage && random.RandomFloat ( ) < tracerChance ) {
			PlayEffect( attackDict, "fx_tracer", fxOrigin, fxDir.ToMat3(), false, collisionPoint );
			tracer = true;
		} else {
			tracer = false;
		}

		if ( !reflect ) {
			//on initial trace only
			if ( attackDict.GetBool( "doWhizz" ) ) {
				//play whizz-by sound if trace is close to player's head
				CheckPlayerWhizzBy( origin, collisionPoint, ent, owner );
			}
		}

		// Play a different effect when reflecting
		if ( !reflect || ent->fl.takedamage ) {
			idMat3 axis;
			
			// Effect axis when hitting actors is along the direction of impact because actor models are 
			// very detailed.
			if ( ent->IsType ( idActor::GetClassType() ) ) {
				axis = ((-dir + tr.c.normal) * 0.5f).ToMat3();
			} else {
				axis = tr.c.normal.ToMat3();
			}
			

			if ( ent->CanPlayImpactEffect( owner, ent ) ) {
				if ( ent->IsType( idMover::GetClassType( ) ) ) {
					ent->PlayEffect( GetEffect( attackDict, "fx_impact", tr.c.materialType ), collisionPoint, axis, false, vec3_origin, false, EC_IMPACT );					
				} else {
					gameLocal.PlayEffect( GetEffect( attackDict, "fx_impact", tr.c.materialType ), collisionPoint, axis, false, vec3_origin, false, EC_IMPACT );
				}
			}

			// End of reflection
			return ent;
		} else {
			PlayEffect( GetEffect( attackDict, "fx_reflect", tr.c.materialType ), collisionPoint, tr.c.normal.ToMat3() );
		}
		
		// Calc new diretion based on bounce
		origin = start;
		fxOrigin = start;
		dir = ( dir - ( 2.0f * DotProduct( dir, tr.c.normal ) * tr.c.normal ) );
		dir.Normalize( );

		// Increase damage scale on reflect
		damageScale += attackDict.GetFloat( "reflect_powerup", "0" );
	}

	assert( false );
	
	return NULL;
}

/*
===================
idGameLocal::RegisterClientEntity
===================
*/
void idGameLocal::RegisterClientEntity( rvClientEntity *cent ) {
	int entityNumber;

	assert ( cent );

	if ( clientSpawnCount >= ( 1 << ( 32 - CENTITYNUM_BITS ) ) ) {
		//Error( "idGameLocal::RegisterClientEntity: spawn count overflow" );
		clientSpawnCount = INITIAL_SPAWN_COUNT;
	}

	// Find a free entity index to use
	while( clientEntities[firstFreeClientIndex] && firstFreeClientIndex < MAX_CENTITIES ) {
		firstFreeClientIndex++;
	}
	if ( firstFreeClientIndex >= MAX_CENTITIES ) {
		cent->PostEventMS ( &EV_Remove, 0 );
		Warning( "idGameLocal::RegisterClientEntity: no free client entities" );
		return;
	}

	entityNumber = firstFreeClientIndex++;

	// Add the client entity to the lists
	clientEntities[ entityNumber ] = cent;
	clientSpawnIds[ entityNumber ] = clientSpawnCount++;
	cent->entityNumber = entityNumber;
	cent->spawnNode.AddToEnd( clientSpawnedEntities );
	cent->spawnArgs.TransferKeyValues( spawnArgs );

	if ( entityNumber >= num_clientEntities ) {
		num_clientEntities++;
	}
}

/*
===================
idGameLocal::UnregisterClientEntity
===================
*/
void idGameLocal::UnregisterClientEntity( rvClientEntity* cent ) {
	assert( cent );
	
	// No entity number then it failed to register
	if ( cent->entityNumber == -1 ) {
		return;
	}
	
	cent->spawnNode.Remove ( );
	cent->bindNode.Remove ( );

	if ( clientEntities [ cent->entityNumber ] == cent ) {
		clientEntities [ cent->entityNumber ] = NULL;
		clientSpawnIds[ cent->entityNumber ] = -1;
		if ( cent->entityNumber < firstFreeClientIndex ) {
			firstFreeClientIndex = cent->entityNumber;
		}
		cent->entityNumber = -1;
	}
}

/*
===================
idGameLocal::GetPlayerName
Returns the specified player name, max of 64 chars
===================
*/
void idGameLocal::GetPlayerName( int clientNum, char* name ) {
	if( !gameLocal.entities[ clientNum ] ) {
		return;
	}

	strncpy( name, gameLocal.GetUserInfo( clientNum )->GetString( "ui_name" ), 64 );
	name[ 63 ] = 0;
}

/*
===================
idGameLocal::GetPlayerClan
Returns the specified player clan, max of 64 chars
===================
*/
void idGameLocal::GetPlayerClan( int clientNum, char* clan ) {
	if( !gameLocal.entities[ clientNum ] ) {
		return;
	}

	strncpy( clan, gameLocal.GetUserInfo( clientNum )->GetString( "ui_clan" ), 64 );
	clan[ 63 ] = 0;
}

/*
===================
idGameLocal::SetFriend
===================
*/
void idGameLocal::SetFriend( int clientNum, bool isFriend ) {
	if( !gameLocal.GetLocalPlayer() ) {
		Warning( "idGameLocal::SetFriend() - SetFriend() called with NULL local player\n" );
		return;
	}

	gameLocal.GetLocalPlayer()->SetFriend( clientNum, isFriend );
}

/*
===================
idGameLocal::GetLongGametypeName
===================
*/
const char*	idGameLocal::GetLongGametypeName( const char* gametype ) {
	return mpGame.GetLongGametypeName( gametype );
}

void idGameLocal::Cmd_PrintSpawnIds_f( const idCmdArgs& args ) {
	for( int i = 0; i < MAX_GENTITIES; i++ ) {
		if( gameLocal.entities[ i ] ) {
			gameLocal.Printf( "Spawn id %d: %d\n", i, gameLocal.spawnIds[ i ] );
		}
	}
}

/*
===============
idGameLocal::GetDemoHud
===============
*/
idUserInterface	*idGameLocal::GetDemoHud( void ) {
	if ( !demo_hud ) {
		demo_hud = uiManager->FindGui( "guis/hud.gui", true, false, true );
		assert( demo_hud );
	}
	return demo_hud;
}

/*
===============
idGameLocal::GetDemoMphud
===============
*/
idUserInterface	*idGameLocal::GetDemoMphud( void ) {
	if ( !demo_mphud ) {
		demo_mphud = uiManager->FindGui( "guis/mphud.gui", true, false, true );
		assert( demo_mphud );
	}
	return demo_mphud;
}

/*
===============
idGameLocal::GetDemoCursor
===============
*/
idUserInterface *idGameLocal::GetDemoCursor( void ) {
	if ( !demo_cursor ) {
		demo_cursor = uiManager->FindGui( "guis/cursor.gui", true, false, true );	   
		assert( demo_cursor );
	}
	return demo_cursor;
}


// mwhitlock: Dynamic memory consolidation
#if defined(_RV_MEM_SYS_SUPPORT)
/*
===================
idGameLocal::FlushBeforelevelLoad
===================
*/
void idGameLocal::FlushBeforelevelLoad( void )
{
	TIME_THIS_SCOPE( __FUNCLINE__);

	MapShutdown();

	for(int i = 0; i < aasNames.Num(); i++)
	{
		aasList[i]->Shutdown();
	}
}
#endif


// dluetscher: moved the overloaded new/delete to sys_local.cpp and Game_local.cpp (from Heap.h)
//			   so that the tools.dll will link.
#if (defined(ID_REDIRECT_NEWDELETE) || defined(_RV_MEM_SYS_SUPPORT))

#undef new
#undef delete
#undef Mem_Alloc
#undef Mem_Free

#ifdef ID_DEBUG_MEMORY
void *operator new( size_t s, int t1, int t2, char *fileName, int lineNumber ) {
	return Mem_Alloc( s, fileName, lineNumber, MemScopedTag_GetTopTag() );
}

void operator delete( void *p, int t1, int t2, char *fileName, int lineNumber ) {
	Mem_Free( p, fileName, lineNumber );
}

void *operator new[]( size_t s, int t1, int t2, char *fileName, int lineNumber ) {
	return Mem_Alloc( s, fileName, lineNumber, MemScopedTag_GetTopTag() );
}

void operator delete[]( void *p, int t1, int t2, char *fileName, int lineNumber ) {
	Mem_Free( p, fileName, lineNumber );
}

void *operator new( size_t s ) {
	return Mem_Alloc( s, "", 0, MemScopedTag_GetTopTag() );
}

void operator delete( void *p ) {
	Mem_Free( p, "", 0 );
}

void *operator new[]( size_t s ) {
	return Mem_Alloc( s, "", 0, MemScopedTag_GetTopTag() );
}

void operator delete[]( void *p ) {
	Mem_Free( p, "", 0 );
}

#else	// #ifdef ID_DEBUG_MEMORY

void *operator new( size_t s ) {
	return Mem_Alloc( s, MemScopedTag_GetTopTag() );
}

void operator delete( void *p ) {
	Mem_Free( p );
}

void *operator new[]( size_t s ) {
	return Mem_Alloc( s, MemScopedTag_GetTopTag() );
}

void operator delete[]( void *p ) {
	Mem_Free( p );
}
#endif	// #else #ifdef ID_DEBUG_MEMORY
#endif	// #if defined(ID_REDIRECT_NEWDELETE) || defined(_RV_MEM_SYS_SUPPORT)


// <q4f> 


//--------------------------------------------------------------------------
// Simulate qwtf style radius damage
//--------------------------------------------------------------------------
void idGameLocal::RadiusDamage_TF( const idVec3 &origin, const TFDamage &tfDamage, idEntity* ignore, int numDamageEnts, entInRadius_t* list ) {

	idVec3 damagePoint;

	float radius = tfDamage.GetDamageDict()->GetFloat( "radius", "0" );
	if ( radius < 1.0f ) {
		radius = ((float)tfDamage.GetDamage());
	}

	entInRadius_t entList[MAX_CLIENTS];

	if ( list == NULL ) {
		numDamageEnts = GetEntitiesInRadius( entList, MAX_CLIENTS, origin, radius + 40.0f, false );
		list = entList;
	}

	TFDamage myDamage = tfDamage;

	float scale;
	idEntity* ent;

	for ( int i = 0; i < numDamageEnts; i++ ) {
		ent = list[i].ent;

		assert( ent );

		if ( ent == ignore || !ent->fl.takedamage )
			continue;

		if ( ent->CanDamage( origin, damagePoint, ignore ) ) {

			if ( ent->IsType( idPlayer::GetClassType() ) ) {
				list[i].point = static_cast<idPlayer*>(ent)->GetEyePosition();
				list[i].dir = ( list[i].point - origin ).ToNormal();
			}

			float points = list[i].distance * 0.5f;
			points = radius - points;

			scale = points / radius;

			myDamage.SetDir( list[i].dir );
			ent->Damage_TF( myDamage, scale );
		} 
	}
}

//--------------------------------------------------------------------------
// Get all entities in radius, ignores the world
// returns # of entities found
//--------------------------------------------------------------------------
int idGameLocal::GetEntitiesInRadius( entInRadius_t* entList, int entListLength, const idVec3 &origin, float radius, bool justPlayers ) {
	
	idEntity*	ent = NULL;
	idEntity*	lastEnt = NULL;

	idClipModel*	clipModel = NULL;
	idClipModel*	clipModelList[ MAX_GENTITIES ];
	int				numListedClipModels;

	idVec3 			v,dir,center;
	idBounds		absBounds;

	entInRadius_t	foundEnt;

	float			dist;

	int numFoundEnts = 0;
	

	if ( radius < 1.0f ) {
		radius = 1.0f;
	}

	numListedClipModels = clip.ClipModelsTouchingBounds( idBounds( origin ).Expand( radius ), MASK_ALL, clipModelList, entListLength );
	if( numListedClipModels > 0 ) {
		//Sort list by unique entities for easier searching
		qsort( clipModelList, numListedClipModels, sizeof(clipModelList[0]), SortClipModelsByEntity );
	}

	for( int c = 0; c < numListedClipModels; c++ ) {
		clipModel = clipModelList[ c ];
		assert( clipModel );

		ent = clipModel->GetEntity();

		// skip if we want just players and it isn't a player
		if ( justPlayers && !ent->IsType( idPlayer::GetClassType() ) ) {
			continue;
		}

		// Only count unique entities.  This works because we have a sorted list
		if( lastEnt == ent ) {
			continue;
		}

		lastEnt = ent;

		center = ent->GetCenter();

		dir = center - origin;
		dist = dir.Normalize();

		if ( dist > radius ) {
			continue;
		}

		foundEnt.dir = dir;
		foundEnt.distance = dist;
		foundEnt.ent = ent;
		foundEnt.point = center;

		entList[numFoundEnts] = foundEnt;
		numFoundEnts++;
	}

	return numFoundEnts;
}

void idGameLocal::DrawCharSize( float x, float y, int ch, float size, idVec4 color )
{
	float col, row;

	row = ch >> 4;
	row *= 0.0625;
	col = ch & 15;
	col *= 0.0625;
	
	const idMaterial *mtr = declManager->FindMaterial( "gfx/2d/bigchars" );

	renderSystem->SetColor( color );
	renderSystem->DrawStretchPic( x, y, size, size, col, row, col + 0.0625, row + 0.0625, mtr );
}

void idGameLocal::DrawStringSize( float x, float y, idStr string, float size, idVec4 color, bool centered, int _length )
{
	float offset = 0;
	const char *c;
	c = string.c_str();

	float length;
	length = string.Length();

	idStr str;

	for( int i = 0; i < length; i++ )
	{
		if ( *c == '^' )
		{
			c += 2;
			i++;
			continue;	
		}
		str += *c;
		c++;
	}

	if( _length )
		str.CapLength( _length );

	length = str.Length();
	if( centered )
	{
			x -= ( ( length / 2 ) * size );
			y -= size / 2;
	}

	c = str.c_str();
	for( int i = 0; i < length; i++ )
	{
		gameLocal.DrawCharSize( x + offset, y, *c, size, color );
		offset += size;
		c++;
	}
}

//--------------------------------------------------------------------------
// Sends a script sound to a client
//--------------------------------------------------------------------------
void idGameLocal::SendScriptSound( const idSoundShader* shader, int clientNum ) {
	assert( !gameLocal.isClient );

	if ( !shader ) {
		return;
	}

	assert( clientNum >= 0 && clientNum < numClients );

	if ( clientNum == gameLocal.localClientNum ) {
		soundSystem->PlayShaderDirectly( SOUNDWORLD_GAME, shader->GetName() );
	}
	else {
		// tell this client to play the sound
		byte msgBuf[MAX_GAME_MESSAGE_SIZE];

		idBitMsg outMsg;
		outMsg.Init( msgBuf, sizeof( msgBuf ) );
		outMsg.BeginWriting();
		outMsg.WriteByte( GAME_RELIABLE_MESSAGE_SCRIPTSOUND );	
		WriteDecl( outMsg, shader );

		networkSystem->ServerSendReliableMessage( clientNum, outMsg );
	}
}


//--------------------------------------------------------------------------
// Parses a comma-separated list of strings
//--------------------------------------------------------------------------
void idGameLocal::ParseCommaSeparation( const char* string, idList<idStr> &list ) {
	if ( !string || !string[0] )
		return;

	idStr word = string;
	word.Split( list, ',', 0 );

	for ( int i = 0; i < list.Num(); i++ ) {
		list[i].Strip( ' ' );
	}
}

void idGameLocal::AddNonAmbientLight( idLight* light ) {
	idLight* nodeLight;
	if ( nonAmbientLights.Next() == NULL ) {
		light->lightNode.AddToEnd( nonAmbientLights );
	}
	else {
		bool added = false;
		for( nodeLight = nonAmbientLights.Next(); nodeLight != NULL; nodeLight = nodeLight->lightNode.Next() ) {
			if ( nodeLight == light )
				return;

			if ( light->volume < nodeLight->volume )
				continue;

			added = true;
			light->lightNode.InsertAfter( nodeLight->lightNode );
			break;
		}

		if ( !added ) {
			light->lightNode.AddToEnd( nonAmbientLights );
		}
	}

	nonAmibentLightCount++;
}

void idGameLocal::UpdateLights( float newDetailLevel, bool singleAmbient ) {
	idLight* nodeLight;

	if ( singleAmbient ) {
		for ( nodeLight = nonAmbientLights.Next(); nodeLight != NULL; nodeLight = nodeLight->lightNode.Next() ) {
			nodeLight->ToggleDisplay( false );
		}
		for ( int i = 0; i < ambientLights.Num(); i++ ) {
			nodeLight = static_cast<idLight*>(ambientLights[i]);

			if ( !nodeLight->GetRenderLight()->shader->IsFogLight() )
				static_cast<idLight*>(ambientLights[i])->ToggleDisplay( false );
		}


		singleLight->ToggleDisplay( true );
		cvarSystem->SetCVarBool( "r_useSimpleInteraction", true );
	}
	else {
		singleLight->ToggleDisplay( false );
		cvarSystem->SetCVarBool( "r_useSimpleInteraction", false );

		for ( int i = 0; i < ambientLights.Num(); i++ ) {
			static_cast<idLight*>(ambientLights[i])->ToggleDisplay( true );
		}

		if ( nonAmibentLightCount <= 0 )
			return;

		int lightIndex = newDetailLevel * ( nonAmibentLightCount );
		
		int count = 0;
		for( nodeLight = nonAmbientLights.Next(); nodeLight != NULL; nodeLight = nodeLight->lightNode.Next() ) {
			if ( count >= lightIndex ) {
				nodeLight->ToggleDisplay( false );
			}
			else {
				nodeLight->ToggleDisplay( true );
			}
			count++;
		}
	}
}

void idGameLocal::ReceiveDetpackSplode( const idBitMsg &msg ) {
	idVec3 org;
	org.x = msg.ReadFloat();
	org.y = msg.ReadFloat();
	org.z = msg.ReadFloat();
	float radius = msg.ReadByte() / 255.0f;

	DrawDetpackSplode( org, radius );
}

#define DP_DEFAULT_RAD 2.0f

void idGameLocal::DrawDetpackSplode( const idVec3 &org, float radius ) {

	//gameRenderWorld->DebugBounds( colorRed, idBounds( org ).Expand( radius ), vec3_zero, 10000 );

	const idDecl * decl = ( ( const idDecl * )declManager->FindEffect( "effects/dp_explode.fx" ) );

	idMat3 axis = mat3_identity;
	axis *= ( DP_DEFAULT_RAD * radius );

	PlayEffect( decl, org, axis, false );
}

/*
void idGameLocal::PushPlayerPredictPositions( int fireTime ) {
	idPlayer* p;
	for ( int i = 0; i < numClients; i++ ) {
		p = GET_PLAYER( i );
		if ( p ) {
			p->ResetToTime( fireTime );
		}
	}
}

void idGameLocal::PopPlayerPredictPositions() {
	idPlayer* p;
	for ( int i = 0; i < numClients; i++ ) {
		p = GET_PLAYER( i );
		if ( p ) {
			p->RestoreFromReset();
		}
	}
}
*/

// </q4f>
