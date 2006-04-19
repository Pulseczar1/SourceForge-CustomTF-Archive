
/*
==============================================================================

			SOURCE FOR GLOBALVARS_T C STRUCTURE

==============================================================================
*/

//
// system globals
//
entity		self;
entity		other;
entity		world;
float		time;
float		frametime;

#ifdef QUAKE_WORLD
entity		newmis;				// if this is set, the entity that just
								// run created a new missile that should
								// be simulated immediately
#endif

float		force_retouch;		// force all entities to touch triggers
								// next frame.  this is needed because
								// non-moving things don't normally scan
								// for triggers, and when a trigger is
								// created (like a teleport trigger), it
								// needs to catch everything.
								// decremented each frame, so set to 2
								// to guarantee everything is touched
string		mapname;

#ifndef QUAKE_WORLD
float		deathmatch;
float		coop;
float		teamplay;
#endif

float		serverflags;		// propagated from level to level, used to
								// keep track of completed episodes

float		total_secrets;
float		total_monsters;

float		found_secrets;		// number of secrets found
float		killed_monsters;	// number of monsters killed


// spawnparms are used to encode information about clients across server
// level changes
float		parm1, parm2, parm3, parm4, parm5, parm6, parm7, parm8, parm9, parm10, parm11, parm12, parm13, parm14, parm15, parm16;

//
// global variables set by built in functions
//	
vector		v_forward, v_up, v_right;	// set by makevectors()
	
// set by traceline / tracebox
float		trace_allsolid;
float		trace_startsolid;
float		trace_fraction;
vector		trace_endpos;
vector		trace_plane_normal;
float		trace_plane_dist;
entity		trace_ent;
float		trace_inopen;
float		trace_inwater;

entity		msg_entity;				// destination of single entity writes

//
// required prog functions
//
void() 		main;						// only for testing

void()		StartFrame;

void() 		PlayerPreThink;
void() 		PlayerPostThink;

void()		ClientKill;
void()		ClientConnect;
void() 		PutClientInServer;		// call after setting the parm1... parms
void()		ClientDisconnect;

void()		SetNewParms;			// called when a client first connects to
									// a server. sets parms so they can be
									// saved off for restarts

void()		SetChangeParms;			// call to set parms for self so they can
									// be saved for a level transition


//================================================
void		end_sys_globals;		// flag for structure dumping
//================================================

/*
==============================================================================

			SOURCE FOR ENTVARS_T C STRUCTURE

==============================================================================
*/

//
// system fields (*** = do not set in prog code, maintained by C code)
//
.float		modelindex;		// *** model index in the precached list
.vector		absmin, absmax;	// *** origin + mins / maxs

.float		ltime;			// local time for entity
#ifdef QUAKE_WORLD
.float		lastruntime;	// *** to allow entities to run out of sequence
#endif

.float		movetype;
.float		solid;

.vector		origin;			// ***
.vector		oldorigin;		// ***
.vector		velocity;
.vector		angles;
.vector		avelocity;

#ifndef QUAKE_WORLD
.vector		punchangle;		// temp angle adjust from damage or recoil
#endif

.string		classname;		// spawn function
.string		model;
.float		frame;
.float		skin;
.float		effects;

.vector		mins, maxs;		// bounding box extents reletive to origin
.vector		size;			// maxs - mins

.void()		touch;
.void()		use;
.void()		think;
.void()		blocked;		// for doors or plats, called when can't push other

.float		nextthink;
.entity		groundentity;

// stats
.float		health;
.float		frags;
.float		weapon;			// one of the IT_SHOTGUN, etc flags
.string		weaponmodel;
.float		weaponframe;
.float		currentammo;
.float		ammo_shells, ammo_nails, ammo_rockets, ammo_cells;

.float		items;			// bit flags

.float		takedamage;
.entity		chain;
.float		deadflag;

.vector		view_ofs;			// add to origin to get eye point


.float		button0;		// fire
.float		button1;		// use
.float		button2;		// jump

.float		impulse;		// weapon changes

.float		fixangle;
.vector		v_angle;		// view / targeting angle for players
#ifndef QUAKE_WORLD
.float		idealpitch;		// calculated pitch angle for lookup up slopes
#endif


.string		netname;

.entity 	enemy;

.float		flags;

.float		colormap;
.float		team;

.float		max_health;		// players maximum health is stored here

.float		teleport_time;	// don't back up

.float		armortype;		// save this fraction of incoming damage
.float		armorvalue;

.float		waterlevel;		// 0 = not in, 1 = feet, 2 = wast, 3 = eyes
.float		watertype;		// a contents value

.float		ideal_yaw;
.float		yaw_speed;

.entity		aiment;

.entity 	goalentity;		// a movetarget or an enemy

.float		spawnflags;

.string		target;
.string		targetname;

// damage is accumulated through a frame. and sent as one single
// message, so the super shotgun doesn't generate huge messages
.float		dmg_take;
.float		dmg_save;
.entity		dmg_inflictor;

.entity		owner;		// who launched a missile
.vector		movedir;	// mostly for doors, but also used for waterjump

.string		message;		// trigger messages

.float		sounds;		// either a cd track number or sound number

.string		noise, noise1, noise2, noise3;	// contains names of wavs to play

//================================================
void		end_sys_fields;			// flag for structure dumping
//================================================

/*
==============================================================================

				VARS NOT REFERENCED BY C CODE

==============================================================================
*/


//
// constants
//
// edict.flags
#define FL_FLY	1 
#define FL_SWIM	2 
#define FL_CLIENT	8 	// set for all client edicts
#define FL_INWATER	16 	// for enter / leave water splash
#define FL_MONSTER	32 
#define FL_GODMODE	64 	// player cheat
#define FL_NOTARGET	128 	// player cheat
#define FL_ITEM	256 	// extra wide size for bonus items
#define FL_ONGROUND	512 	// standing on something
#define FL_PARTIALGROUND	1024 	// not all corners are valid
#define FL_WATERJUMP	2048 	// player jumping out of water
#define FL_JUMPRELEASED	4096 	// for jump debouncing

// edict.movetype values
#define MOVETYPE_NONE			0 	// never moves
//#define MOVETYPE_ANGLENOCLIP	1 
//#define MOVETYPE_ANGLECLIP	2 
#define MOVETYPE_WALK			3 	// players only
#define MOVETYPE_STEP			4 	// discrete, not real time unless fall
#define MOVETYPE_FLY			5 
#define MOVETYPE_TOSS			6 	// gravity
#define MOVETYPE_PUSH			7 	// no clip to world, push and crush
#define MOVETYPE_NOCLIP			8 
#define MOVETYPE_FLYMISSILE		9 	// fly with extra size against monsters
#define MOVETYPE_BOUNCE			10 
#define MOVETYPE_BOUNCEMISSILE	11 	// bounce with extra size

// edict.solid values
#define SOLID_NOT		0 	// no interaction with other objects
#define SOLID_TRIGGER	1 	// touch on edge, but not blocking
#define SOLID_BBOX		2 	// touch on edge, block
#define SOLID_SLIDEBOX	3 	// touch on edge, but not an onground
#define SOLID_BSP		4 	// bsp clip, touch on edge, block

// range values
#define RANGE_MELEE	0 
#define RANGE_NEAR	1 
#define RANGE_MID	2 
#define RANGE_FAR	3 

// deadflag values

#define DEAD_NO				0 
#define DEAD_DYING			1 
#define DEAD_DEAD			2 
#define DEAD_RESPAWNABLE	3 

// takedamage values

#define DAMAGE_NO	0 
#define DAMAGE_YES	1 
#define DAMAGE_AIM	2 

// items
#define IT_AXE	4096 
#define IT_SHOTGUN	1 
#define IT_SUPER_SHOTGUN	2 
#define IT_NAILGUN	4 
#define IT_SUPER_NAILGUN 8 
#define IT_GRENADE_LAUNCHER	16 
#define IT_ROCKET_LAUNCHER	32 
#define IT_LIGHTNING	64 
#define IT_EXTRA_WEAPON	128 

#define IT_SHELLS	256 
#define IT_NAILS	512 
#define IT_ROCKETS	1024 
#define IT_CELLS	2048 

#define IT_ARMOR1	8192 
#define IT_ARMOR2	16384 
#define IT_ARMOR3	32768 
#define IT_SUPERHEALTH	65536 

#define IT_KEY1	131072 
#define IT_KEY2	262144 

#define IT_INVISIBILITY	524288 
#define IT_INVULNERABILITY	1048576 
#define IT_SUIT	2097152
#define IT_QUAD	4194304 
#define IT_HOOK	8388608

// point content values

#define CONTENT_EMPTY	-1 
#define CONTENT_SOLID	-2 
#define CONTENT_WATER	-3 
#define CONTENT_SLIME	-4 
#define CONTENT_LAVA	-5 
#define CONTENT_SKY		-6 

#define STATE_TOP	0 
#define STATE_BOTTOM	1 
#define STATE_UP	2 
#define STATE_DOWN	3 

#define VEC_ORIGIN		'0 0 0' 
#define VEC_HULL_MIN	'-16 -16 -24' 
#define VEC_HULL_MAX	'16 16 32' 

#define VEC_HULL2_MIN	'-32 -32 -24' 
#define VEC_HULL2_MAX	'32 32 64' 

// protocol bytes
#define SVC_TEMPENTITY	23 
#define SVC_KILLEDMONSTER	27 
#define SVC_FOUNDSECRET	28 
#define SVC_INTERMISSION	30 
#define SVC_FINALE	31 
#define SVC_CDTRACK	32 
#define SVC_SELLSCREEN	33 

#ifdef QUAKE_WORLD

	#define SVC_SMALLKICK	 34
	#define SVC_BIGKICK		 35
	#define SVC_MUZZLEFLASH	 39

#endif


#define TE_SPIKE			0 
#define TE_SUPERSPIKE		1 
#define TE_GUNSHOT			2 
#define TE_EXPLOSION		3 
#define TE_TAREXPLOSION		4 
#define TE_LIGHTNING1		5 
#define TE_LIGHTNING2		6 
#define TE_WIZSPIKE			7 
#define TE_KNIGHTSPIKE		8 
#define TE_LIGHTNING3		9 
#define TE_LAVASPLASH		10 
#define TE_TELEPORT			11 
#define TE_BLOOD        	12
#define TE_LIGHTNINGBLOOD	13

// sound channels
// channel 0 never willingly overrides
// other channels (1-7) allways override a playing sound on that channel
#define CHAN_AUTO	0 
#define CHAN_WEAPON	1 
#define CHAN_VOICE	2 
#define CHAN_ITEM	3 
#define CHAN_BODY	4 

#define ATTN_NONE	0 
#define ATTN_NORM	1 
#define ATTN_IDLE	2 
#define ATTN_STATIC	3 

// update types

#define UPDATE_GENERAL	0 
#define UPDATE_STATIC	1 
#define UPDATE_BINARY	2 
#define UPDATE_TEMP	3 

// entity effects

#define EF_BRIGHTFIELD	1 
#define EF_MUZZLEFLASH	2 
#define EF_BRIGHTLIGHT	4 
#define EF_DIMLIGHT	8 


// messages
// Since BROADCAST is never used in QW 1.5, and MULTICAST is used instead,
// just define BROADCAST as MULTICAST for QW 1.5
#define MSG_MULTICAST   4       
#ifdef QUAKE_WORLD
	#define MSG_BROADCAST 	#MSG_MULTICAST
#else
	#define MSG_BROADCAST	0 	// unreliable to all
#endif
#define MSG_ONE			1 		// reliable to one (msg_entity)
#define MSG_ALL			2 		// reliable to all
#define MSG_INIT		3 		// write to the init string


// message levels
#define	PRINT_LOW		 0		// pickup messages
#define	PRINT_MEDIUM	 1		// death messages
#define	PRINT_HIGH		 2		// critical messages
#define PRINT_CHAT		 3		// also goes to chat console

// multicast sets
#define MULTICAST_ALL    0    	// every client
#define MULTICAST_PHS    1    	// within hearing
#define MULTICAST_PVS    2    	// within sight
#define MULTICAST_ALL_R  3    	// every client, reliable
#define MULTICAST_PHS_R  4    	// within hearing, reliable
#define MULTICAST_PVS_R  5  	// within sight, reliable

//================================================

//
// globals
//
float	movedist;

#ifndef QUAKE_WORLD
float	gameover;		// set when a rule exits
#endif

string	string_null;	// null string, nothing should be held here
float	empty_float;


entity	activator;		// the entity that activated a trigger or brush

entity	damage_attacker;	// set by T_Damage
float	framecount;

float	skill;

// cvars checked each frame
//
float		teamplay;
float		timelimit;
float		fraglimit;
float		deathmatch;



//================================================

//
// world fields (FIXME: make globals)
//
.string		wad;
.string 	map;
.float		worldtype;	// 0=medieval 1=metal 2=base

//================================================

.string		killtarget;

//
// quakeed fields
//
.float		light_lev;		// not used by game, but parsed by light util
.float		style;


//
// monster ai
//

.void()		th_stand;

.void()		th_walk;
.void()		th_run;
.void()		th_missile;
.void()		th_melee;

.void(entity attacker, float damage)		th_pain;
.void()		th_die;


.entity		oldenemy;		// mad at this player before taking damage

.float	speed;

.float	lefty;

.float	search_time;
.float	attack_state;


#define AS_STRAIGHT	1 
#define AS_SLIDING	2 
#define AS_MELEE	3 
#define AS_MISSILE	4 

//
// player only fields
//
.float		walkframe;

.float 		attack_finished;
.float		pain_finished;

.float		invincible_finished;
.float		invisible_finished;
.float		super_damage_finished;
.float		radsuit_finished;

.float		invincible_time, invincible_sound;
.float		invisible_time, invisible_sound;
.float		super_time, super_sound;
.float		rad_time;
.float		fly_sound;

.float		axhitme;

.float		show_hostile;	// set to time+0.2 whenever a client fires a
							// weapon or takes damage.  Used to alert
							// monsters that otherwise would let the player go
.float		jump_flag;		// player jump flag
.float		swim_flag;		// player swimming sound flag
.float		air_finished;	// when time > air_finished, start drowning
.float		bubble_count;	// keeps track of the number of bubbles
.string		deathtype;		// keeps track of how the player died

//
// object stuff
//
.string		mdl;
.vector		mangle;			// angle at start

.vector		oldorigin;		// only used by secret door

.float		t_length, t_width;


//
// doors, etc
//
.vector		dest, dest1, dest2;
.float		wait;			// time from firing to restarting
.float		delay;			// time from activation to firing
.entity		trigger_field;	// door's trigger entity
.string		noise4;

//
// monsters
//
.float 		pausetime;
.entity 	movetarget;


//
// doors
//
.float		aflag;
.float		dmg;			// damage done by door when hit
	
//
// misc
//
.float		cnt; 			// misc flag
	
//
// subs
//
.void()		think1;
.vector		finaldest, finalangle;

//
// triggers
//
.float		count;			// for counting triggers


//
// plats / doors / buttons
//
.float		lip;
.float		state;
.vector		pos1, pos2;		// top and bottom positions
.float		height;

//
// sounds
//
.float		waitmin, waitmax;
.float		distance;
.float		volume;

//===========================================================================
	

//
// builtin functions
//

void(vector ang)	makevectors		= #1;		// sets v_forward, etc globals
void(entity e, vector o) setorigin	= #2;
void(entity e, string m) setmodel	= #3;		// set movetype and solid first
void(entity e, vector min, vector max) setsize = #4;
// #5 was removed
void() break						= #6;
float() random						= #7;		// returns 0 - 1
void(entity e, float chan, string samp, float vol, float atten) sound = #8;
vector(vector v) normalize			= #9;
void(string e) error				= #10;
void(string e) objerror				= #11;
float(vector v) vlen				= #12;
float(vector v) vectoyaw			= #13;
entity() spawn						= #14;
void(entity e) remove				= #15;

// sets trace_* globals
// nomonsters can be:
// An entity will also be ignored for testing if forent == test,
// forent->owner == test, or test->owner == forent
// a forent of world is ignored
void(vector v1, vector v2, float nomonsters, entity forent) traceline = #16;	

entity() checkclient				= #17;	// returns a client to look for
entity(entity start, .string fld, string match) find = #18;
string(string s) precache_sound		= #19;
string(string s) precache_model		= #20;
void(entity client, string s)stuffcmd = #21;
entity(vector org, float rad) findradius = #22;

#ifndef QUAKE_WORLD
//void(string s) bprint				= #23;
//void(entity client, string s) sprint = #24;
void(...) nqw_bprint			= #23;
void(...) nqw_sprint 			= #24;

// used for QW compatibility
/*
void(float level, string s) bprint;
void(entity client, float level, string s) sprint;

void(float level, string s1, string s2) bprint2;
void(entity client, float level, string s1, string s2) sprint2;

void(float level, string s1, string s2, string s3) bprint3;
void(entity client, float level, string s1, string s2, string s3) sprint3;

void(float level, string s1, string s2, string s3, string s4) bprint4;
void(entity client, float level, string s1, string s2, string s3, string s4) sprint4;

void(float level, string s1, string s2, string s3, string s4, string s5) bprint5;
void(entity client, float level, string s1, string s2, string s3, string s4, string s5) sprint5;

void(float level, string s1, string s2, string s3, string s4, string s5, string s6) bprint6;
void(entity client, float level, string s1, string s2, string s3, string s4, string s5, string s6) sprint6;

void(float level, string s1, string s2, string s3, string s4, string s5, string s6, string s7) bprint7;
void(entity client, float level, string s1, string s2, string s3, string s4, string s5, string s6, string s7) sprint7;

void(float level, string s1, string s2, string s3, string s4, string s5, string s6, string s7, string s8) bprint8;
*/
#else
//void(float level, string s) bprint				= #23;
//void(entity client, float level, string s) sprint = #24;
void(...) bprint				= #23;
void(...) sprint 				= #24;

void(...) bprint2				= #23;
void(...) sprint2 				= #24;

void(...) bprint3				= #23;
void(...) sprint3 				= #24;

void(...) bprint4				= #23;
void(...) sprint4 				= #24;

void(...) bprint5				= #23;
void(...) sprint5 				= #24;

void(...) bprint6				= #23;
void(...) sprint6 				= #24;

void(...) bprint7				= #23;
void(...) sprint7 				= #24;

void(...) bprint8				= #23;
#endif

void(string s) dprint				= #25;
string(float f) ftos				= #26;
string(vector v) vtos				= #27;
void() coredump						= #28;		// prints all edicts
void() traceon						= #29;		// turns statment trace on
void() traceoff						= #30;
void(entity e) eprint				= #31;		// prints an entire edict
float(float yaw, float dist) walkmove	= #32;	// returns #TRUE or #FALSE
// #33 was removed
float(float yaw, float dist) droptofloor= #34;	// #TRUE if landed on floor
void(float style, string value) lightstyle = #35;
float(float v) rint					= #36;		// round to nearest int
float(float v) floor				= #37;		// largest integer <= v
float(float v) ceil					= #38;		// smallest integer >= v
// #39 was removed
float(entity e) checkbottom			= #40;		// true if self is on ground
float(vector v) pointcontents		= #41;		// returns a CONTENT_*
// #42 was removed
float(float f) fabs = #43;
vector(entity e, float speed) aim = #44;		// returns the shooting vector
float(string s) cvar = #45;						// return cvar.value
void(string s) localcmd = #46;					// put string into local que
entity(entity e) nextent = #47;					// for looping through all ents
void(vector o, vector d, float color, float count) particle = #48;// start a particle effect
void() ChangeYaw = #49;						// turn towards self.ideal_yaw
											// at self.yaw_speed
// #50 was removed
vector(vector v) vectoangles			= #51;

//
// direct client message generation
//
void(float to, float f) WriteByte		= #52;
void(float to, float f) WriteChar		= #53;
void(float to, float f) WriteShort		= #54;
void(float to, float f) WriteLong		= #55;
void(float to, float f) WriteCoord		= #56;
void(float to, float f) WriteAngle		= #57;
void(float to, string s) WriteString	= #58;
void(float to, entity s) WriteEntity	= #59;


void(float step) movetogoal				= #67;

string(string s) precache_file			= #68;	// no effect except for -copy
void(entity e) makestatic				= #69;
void(string s) changelevel 				= #70;

//#71 was removed

void(string var, string val) cvar_set = #72;	// sets cvar.value

//void(entity client, string s) centerprint = #73;	// sprint, but in middle
void(...) centerprint = #73;
#ifndef STATUSBAR
void(entity pl, string s1) CenterPrint = #73;
void(entity pl, string s1, string s2) CenterPrint2 = #73;
#endif

void(vector pos, string samp, float vol, float atten) ambientsound = #74;

string(string s) precache_model2	= #75;		// registered version only
string(string s) precache_sound2	= #76;		// registered version only
string(string s) precache_file2		= #77;		// registered version only

void(entity e) setspawnparms		= #78;		// set parm1... to the
												// values at level start
												// for coop respawn

#ifdef QUAKE_WORLD
void(entity killer, entity killee) logfrag = #79;	// add to stats
string(entity e, string key) infokey	= #80;		// get a key value (world = serverinfo)
float(string s) stof					= #81;		// convert string to float
void(vector where, float set) multicast = #82;  // sends the temp message to a set
												// of clients, possibly in PVS or PHS
#endif

//============================================================================

//
// subs.qc
//
void(vector tdest, float tspeed, void() func) SUB_CalcMove;
void(entity ent, vector tdest, float tspeed, void() func) SUB_CalcMoveEnt;
void(vector destangle, float tspeed, void() func) SUB_CalcAngleMove;
void() SUB_CalcMoveDone;
void() SUB_CalcAngleMoveDone;
void() SUB_Null;
void() SUB_UseTargets;
void() SUB_Remove;


//
//	combat.qc
//
void(entity targ, entity inflictor, entity attacker, float damage) T_Damage;


float (entity e, float healamount, float ignore) T_Heal; // health function

float(entity targ, entity inflictor) CanDamage;


//===========================================================================
// TEAMFORTRESS Defs
//===========================================================================\
.float      playerclass;		
.float		nextpc;				// The playerclass you'll respawn as
.float		last_impulse;		// The previous impulse command from this player
.float		armorclass;			// Type of armor being worn
.float 		tf_items;			// Another flag for player items
.float		tf_items_flags;		// Flags for the player items
.float		no_grenades_1;		// Number of grenades of type 1 being carried
.float		no_grenades_2;		// Number of grenades of type 2 being carried
.float		tp_grenades_1;		// 1st type of grenades being carried
.float		tp_grenades_2;		// 2nd type of grenades being carried
.float		got_aliases;		// TRUE if the player has TeamFortress aliases
.float 		cheat_check;		// Time when we'll next check for team cheats
.float 		is_removed;			// TRUE if the entity has been removed
.float		is_undercover;		// TRUE for a SPY if they're undercover
.float		is_building;	 	// TRUE for an ENGINEER if they're building something
.float		is_detpacking;	 	// TRUE for a DEMOMAN if they're setting a detpack
.float		is_feigning;		// TRUE for a SPY if they're feigning death
.float		is_unabletospy;		// TRUE for a SPY if they can't go undercover
.float		has_disconnected;	// TRUE if the player has disconnected
.float		has_dispenser;		// TRUE for an ENGINEER if he has a dispenser
.float		has_sentry;			// TRUE for an ENGINEER if he has a sentry

// TeamFortress State Flags
.float 	tfstate;					// State flags for TeamFortress
#define TFSTATE_GRENPRIMED		1 	// Whether the player has a primed grenade
#define TFSTATE_RELOADING		2 	// Whether the player is reloading
#define TFSTATE_ALTKILL			4  	// #TRUE if killed with a weapon not in self.weapon: NOT USED ANYMORE
#define TFSTATE_RANDOMPC		8   // Whether Playerclass is random, new one each respawn
#define TFSTATE_INFECTED		16 	// set when player is infected by the bioweapon
#define TFSTATE_INVINCIBLE		32 	// Player has permanent Invincibility (Usually by GoalItem)
#define TFSTATE_INVISIBLE		64 	// Player has permanent Invisibility (Usually by GoalItem)
#define TFSTATE_QUAD			128 // Player has permanent Quad Damage (Usually by GoalItem)
#define TFSTATE_RADSUIT			256 // Player has permanent Radsuit (Usually by GoalItem)
#define TFSTATE_BURNING			512 // Is on fire
#define TFSTATE_GRENTHROWING	1024  // is throwing a grenade
#define TFSTATE_AIMING			2048  // is using the laser sight
#define TFSTATE_ZOOMOFF			4096  // doesn't want the FOV changed when zooming
#define TFSTATE_RESPAWN_READY	8192  // is waiting for respawn, and has pressed fire
#define TFSTATE_HALLUCINATING  16384  // set when player is hallucinating
#define TFSTATE_TRANQUILISED   32768  // set when player is tranquilised
#define TFSTATE_CANT_MOVE	   65536  // set when player is setting a detpack

.entity	linked_list;		// Used just like chain. Has to be separate so
								// it doesn't interfere with chain. See T_RadiusScan
.entity	observer_list;		// Used by undefined classes, see TF_MovePlayer

// Defines used by TF_T_Damage (see combat.qc)
#define TF_TD_IGNOREARMOUR	1  // Bypasses the armour of the target
#define TF_TD_NOTTEAM		2  // Doesn't damage a team member (indicates direct fire weapon)
#define TF_TD_NOTSELF		4  // Doesn't damage self

#define TF_TD_OTHER			0  // Ignore armorclass
#define TF_TD_SHOT			1  // Bullet damage
#define TF_TD_NAIL			2  // Nail damage
#define TF_TD_EXPLOSION		4  // Explosion damage
#define TF_TD_ELECTRICITY	8  // Electric damage
#define TF_TD_FIRE			16  // Fire damage
#define TF_TD_NOSOUND		256 // Special damage. Makes no sound/painframe, etc

// Playerclass handling variables
.float	maxammo_shells;		// Class holding details
.float	maxammo_nails;
.float	maxammo_cells;
.float	maxammo_rockets;
.float	items_allowed;
.float	armor_allowed;
.float 	maxarmor;
.float	maxfbspeed;			// Maximum forward/back speed
.float	maxstrafespeed;		// Maximum side speed

.float	weaponmode;			// Used for multiple mode weapons

.float	motd; 				// Used to display MOTD
.float  current_menu;		// is set to the number of the current menu, is 0 if they are not in a menu
.float  menu_count;			// keeps track of display times for menus
.float  menu_displaytime;	// keep track of how many times this menu is refreshed
				   

/*==================================================*/
/* Toggleable Game Settings							*/
/*==================================================*/
float toggleflags;					// toggleable flags

#define TF_RESPAWNDELAY1	5 	// seconds of waiting before player can respawn
#define TF_RESPAWNDELAY2	10 	// seconds of waiting before player can respawn
#define TF_RESPAWNDELAY3	20 	// seconds of waiting before player can respawn

float respawn_delay_time;

#define TEAMPLAY_NORMAL			 1			
#define TEAMPLAY_HALFDIRECT		 2
#define TEAMPLAY_NODIRECT		 4
#define TEAMPLAY_HALFEXPLOSIVE	 8
#define TEAMPLAY_NOEXPLOSIVE	 16
#define TEAMPLAY_LESSPLAYERSHELP 32
#define TEAMPLAY_LESSSCOREHELP	 64

// FortressMap stuff
float number_of_teams; // number of teams supported by the map
float illegalclasses;   // Illegal playerclasses for all teams
float illegalclasses1;  // Illegal playerclasses for team 1
float illegalclasses2;  // Illegal playerclasses for team 2
float illegalclasses3;  // Illegal playerclasses for team 3
float illegalclasses4;  // Illegal playerclasses for team 4
float civilianteams;    // Bitfield holding Civilian teams
#define TEAM1_CIVILIANS 1	
#define TEAM2_CIVILIANS 2
#define TEAM3_CIVILIANS 4	
#define TEAM4_CIVILIANS 8	
float team1col;		// Colours for each of the 4 teams
float team2col;		// If there's enough demand, we'll
float team3col;		// allow more than four teams...
float team4col;
float team1score;	// Goal Score of each team
float team2score;	
float team3score;	
float team4score;	
float team1lives;	// Number of lives each team's players have
float team2lives;	
float team3lives;	
float team4lives;	
float team1maxplayers;	// Max number of players allowed in each team
float team2maxplayers;	
float team3maxplayers;  
float team4maxplayers;  
float team1advantage;  // only used if the teamplay equalisation bits are set
float team2advantage;  // stores the damage ratio players take/give
float team3advantage;
float team4advantage;

.float team_no;		// The team you belong to
.float lives;		// The number of lives you have left

.float infection_team_no; // The team_no of the person who infected you

// CTF stuff
float CTF_Map;

#ifdef QUAKE_WORLD
float		coop;
float       rj;					// Rocket Jump Modifier
#endif



// Defines for the playerclass
#define PC_UNDEFINED	0 

#define PC_SCOUT		1 
#define PC_SNIPER		2 
#define PC_SOLDIER		3 
#define PC_DEMOMAN		4 
#define PC_MEDIC		5 
#define PC_HVYWEAP		6 
#define PC_PYRO			7
#define PC_SPY			8
#define PC_ENGINEER		9

// Insert new class definitions here

// PC_RANDOM _MUST_ be the third last class
#define PC_RANDOM		10 		// Random playerclass
#define PC_CIVILIAN		11		// Civilians are a special class. They cannot
								// be chosen by players, only enforced by maps
#define PC_LASTCLASS	12 		// Use this as the high-boundary for any loops
								// through the playerclass.
// Flare skin numbers
float TF_FLARE_LIT  = 0;
float TF_FLARE_OFF  = 1;

/*==================================================*/
/* Impulse Defines		                        	*/
/*==================================================*/
// Alias check to see whether they already have the aliases
#define TF_ALIAS_CHECK		13 

// CTF Support Impulses
#define HOOK_IMP1		22
#define FLAG_INFO		23
#define HOOK_IMP2		39

// Axe
#define AXE_IMP			40

// Camera Impulse
#define TF_CAM_TARGET			50
#define TF_CAM_ZOOM				51
#define TF_CAM_ANGLE			52
#define TF_CAM_VEC				53
#define TF_CAM_PROJECTILE		54
#define TF_CAM_PROJECTILE_Z		55
#define TF_CAM_REVANGLE			56
#define TF_CAM_OFFSET			57
#define TF_CAM_DROP				58	
#define TF_CAM_FADETOBLACK		59
#define TF_CAM_FADEFROMBLACK	60
#define TF_CAM_FADETOWHITE		61
#define TF_CAM_FADEFROMWHITE	62

// Status Bar Resolution Settings.  Same as CTF to maintain ease of use.
#define TF_STATUSBAR_RES_START	71
#define TF_STATUSBAR_RES_END	81

// Added to PC_??? to get impulse to use if this clashes with your 
// own impulses, just change this value, not the PC_??
#define TF_CHANGEPC			100 
// The next few impulses are all the class selections
//PC_SCOUT		101 
//PC_SNIPER		102 
//PC_SOLDIER	103 
//PC_DEMOMAN	104 
//PC_MEDIC		105 
//PC_HVYWEAP	106 
//PC_PYRO		107 
//PC_RANDOM		108
//PC_CIVILIAN	109  // Cannot be used
//PC_SPY		110
//PC_ENGINEER	111

// Help impulses
#define TF_DISPLAYLOCATION  118
#define TF_STATUS_QUERY		119

#define TF_HELP_MAP			131

// Information impulses
#define TF_INVENTORY		135
#define TF_SHOWTF			136 
#define TF_SHOWLEGALCLASSES	137

// Team Impulses
#define TF_TEAM_1			140   // Join Team 1
#define TF_TEAM_2			141   // Join Team 2
#define TF_TEAM_3			142   // Join Team 3
#define TF_TEAM_4			143   // Join Team 4
#define TF_TEAM_CLASSES		144   // Impulse to display team classes
#define TF_TEAM_SCORES		145   // Impulse to display team scores
#define TF_TEAM_LIST		146   // Impulse to display the players in each team.

// Grenade Impulses
#define TF_GRENADE_1		150   // Prime grenade type 1
#define TF_GRENADE_2		151   // Prime grenade type 2
#define TF_GRENADE_T		152   // Throw primed grenade

// Impulses for new items
#define TF_SCAN				159		// Scanner Pre-Impulse
#define TF_SCAN_ENEMY		160		// Impulses to toggle scanning of enemies
#define TF_SCAN_FRIENDLY	161		// Impulses to toggle scanning of friendlies 
#define TF_SCAN_10			162		// Scan using 10 enery (1 cell)
#define TF_SCAN_30			163		// Scan using 30 energy (2 cells)
#define TF_SCAN_100			164		// Scan using 100 energy (5 cells)
#define TF_DETPACK_5		165		// Detpack set to 5 seconds
#define TF_DETPACK_20		166		// Detpack set to 20 seconds
#define TF_DETPACK_50		167		// Detpack set to 50 seconds
#define TF_DETPACK			168		// Detpack Pre-Impulse
#define TF_DETPACK_STOP		169		// Impulse to stop setting detpack
#define TF_PB_DETONATE		170		// Detonate Pipebombs

// Special skill
#define TF_SPECIAL_SKILL	171

// Ammo Drop impulse
#define TF_DROP_AMMO        172

// Reload impulse
#define TF_RELOAD			173

// auto-zoom toggle
#define TF_AUTOZOOM			174

// drop/pass commands
#define TF_DROPKEY			175

// Select Medikit		
#define TF_MEDIKIT			176

// Spy Impulses
#define TF_SPY_SPY			177		// On net, go invisible, on LAN, change skin/color
#define TF_SPY_DIE			178		// Feign Death

// Engineer Impulses
#define TF_ENGINEER_BUILD	179
#define TF_ENGINEER_SANDBAG	180

// Medic!! 
#define TF_MEDIC_HELPME		181

// Status bar
#define TF_STATUSBAR_ON		182
#define TF_STATUSBAR_OFF	183

// Discard impulse
#define TF_DISCARD 	  		184

// ID Player impulse
#define TF_ID	 	  		185

/*==================================================*/
/*	Colors											*/
/*==================================================*/
#define WHITE 		1
#define BROWN 		2
#define BLUE 		3
#define GREEN   	4
#define RED 		5
#define TAN     	6
#define PINK    	7
#define ORANGE  	8
#define PURPLE  	9
#define DARKPURPLE 	10
#define GREY    	11
#define DARKGREEN  	12
#define YELLOW 		13
#define DARKBLUE   	14

/*==================================================*/
/* Defines for the ENGINEER's Building ability		*/
/*==================================================*/
// Ammo costs
#define AMMO_COST_SHELLS		3		// Metal needed to make 1 shell
#define AMMO_COST_NAILS			2
#define AMMO_COST_ROCKETS		5
#define AMMO_COST_CELLS			5

// Building types
#define BUILD_DISPENSER			1
#define BUILD_SENTRYGUN			2
#define BUILD_MORTAR			3

// Building metal costs
#define BUILD_COST_DISPENSER	100		// Built thru the menu
#define BUILD_COST_SENTRYGUN	130		// Built thru the menu
#define BUILD_COST_MORTAR		150		// Built thru the menu

#define BUILD_COST_SANDBAG		20		// Built with a separate alias

// Building times
#define BUILD_TIME_DISPENSER	2		// 2 seconds to build
#define BUILD_TIME_SENTRYGUN	5		// 5 seconds to build
#define BUILD_TIME_MORTAR		5		// 5 seconds to build

// Building health levels
#define BUILD_HEALTH_DISPENSER	150		// Built thru the menu
#define BUILD_HEALTH_SENTRYGUN	150		// Built thru the menu
#define BUILD_HEALTH_MORTAR		200		// Built thru the menu

// Dispenser's maximum carrying capability
#define BUILD_DISPENSER_MAX_SHELLS  400
#define BUILD_DISPENSER_MAX_NAILS   600
#define BUILD_DISPENSER_MAX_ROCKETS 300
#define BUILD_DISPENSER_MAX_CELLS   400
#define BUILD_DISPENSER_MAX_ARMOR   500

.entity building;	  // The building the ENGINEER is using
.float building_wait; // Used to prevent using a building again immediately
.entity real_owner;

/*==================================================*/
/* Ammo quantities for dropping            			*/
/*==================================================*/
#define DROP_SHELLS   20
#define DROP_NAILS    20
#define DROP_ROCKETS  10
#define DROP_CELLS    10
#define DROP_ARMOR	  40

/*==================================================*/
/* Team Defines				            			*/
/*==================================================*/
#define TM_MAX_NO	4 			// Max number of teams. Simply changing this value isn't enough.
								// A new global to hold new team colors is needed, and more flags
								// in the spawnpoint spawnflags may need to be used.
								// Basically, don't change this unless you know what you're doing :)

.float real_frags;	// Used to store the players frags when TeamFrags is On

.float respawn_time;	// players can't respawn within this time.
.float suicide_time;	// players can't suicide within this time.

/*==================================================*/
/* New Weapon Defines		                        */
/*==================================================*/
.float weapons_carried;		// the weapons the player is carrying
.float current_weapon;		// the weapon the player is using

#define WEAP_HOOK				1
#define WEAP_BIOWEAPON			2
#define WEAP_MEDIKIT			4
#define WEAP_SPANNER			8
#define WEAP_AXE				16
#define WEAP_SNIPER_RIFLE		32
#define WEAP_AUTO_RIFLE			64
#define WEAP_SHOTGUN			128
#define WEAP_SUPER_SHOTGUN		256
#define WEAP_NAILGUN			512
#define WEAP_SUPER_NAILGUN		1024
#define WEAP_GRENADE_LAUNCHER	2048
#define WEAP_FLAMETHROWER		4096
#define WEAP_ROCKET_LAUNCHER	8192
#define WEAP_INCENDIARY			16384
#define WEAP_ASSAULT_CANNON		32768
#define WEAP_LIGHTNING			65536
#define WEAP_DETPACK			131072
#define WEAP_TRANQ				262144
#define WEAP_LASER				524288
// still room for 12 more weapons
// but we can remove some by giving the weapons
// a weapon mode (like the rifle)

/*==================================================*/
/* New Weapon Related Defines		                */
/*==================================================*/
// shots per reload 
#define RE_SHOTGUN			8 
#define RE_SUPER_SHOTGUN	16 // 8 shots
#define RE_GRENADE_LAUNCHER	6 
#define RE_ROCKET_LAUNCHER	4 

// reload times
#define RE_SHOTGUN_TIME				2 
#define RE_SUPER_SHOTGUN_TIME		3 
#define RE_GRENADE_LAUNCHER_TIME	4 
#define RE_ROCKET_LAUNCHER_TIME		5 

// Maximum velocity you can move and fire the Sniper Rifle
#define WEAP_SNIPER_RIFLE_MAX_MOVE	50 

// Medikit
#define WEAP_MEDIKIT_HEAL	200  // Amount medikit heals per hit
#define WEAP_MEDIKIT_OVERHEAL 50 // Amount of superhealth over max_health the medikit will dispense
.float ammo_medikit;			 // Ammo used for the medikit
.float maxammo_medikit;

// Spanner
#define WEAP_SPANNER_REPAIR 10

// Detpack
#define WEAP_DETPACK_DISARMTIME	3   	//Time it takes to disarm a Detpack
#define WEAP_DETPACK_SETTIME		4   	// Time it takes to set a Detpack
#define WEAP_DETPACK_SIZE		1500 
#define WEAP_DETPACK_BITS_NO		12  	// Bits that detpack explodes into
.float ammo_detpack;					// Ammo used for the detpack
.float maxammo_detpack;

// Tranquiliser Gun
#define TRANQ_TIME			15

// Grenades
#define GR_PRIMETIME		3 
#define GR_TYPE_NONE		0 
#define GR_TYPE_NORMAL		1 
#define GR_TYPE_CONCUSSION	2 
#define GR_TYPE_NAIL		3 
#define GR_TYPE_MIRV		4 
#define GR_TYPE_NAPALM		5 
#define GR_TYPE_FLARE		6 
#define GR_TYPE_GAS			7
#define GR_TYPE_EMP			8
#define GR_TYPE_FLASH		9

// Defines for WeaponMode
#define GL_NORMAL	0 
#define GL_PIPEBOMB	1 

// Defines for Concussion Grenade
#define GR_CONCUSS_TIME	5 
#define GR_CONCUSS_DEC	20 

// Defines for the Gas Grenade
#define GR_HALLU_TIME	0.5
#define GR_HALLU_DEC	2.5

/*==================================================*/
/* New Items			                        	*/
/*==================================================*/
#define NIT_SCANNER				1 

#define NIT_SILVER_DOOR_OPENED 	#IT_KEY1	// 131072 
#define NIT_GOLD_DOOR_OPENED 	#IT_KEY2	// 262144

/*==================================================*/
/* New Item Flags		                        	*/
/*==================================================*/
#define NIT_SCANNER_ENEMY		1 	// Detect enemies
#define NIT_SCANNER_FRIENDLY	2 	// Detect friendlies (team members)
#define NIT_SCANNER_MOVEMENT	4 	// Motion detection. Only report moving entities.

/*==================================================*/
/* New Item Related Defines		                    */
/*==================================================*/
#define NIT_SCANNER_POWER			100	// The amount of power spent on a scan with the scanner
										// is multiplied by this to get the scanrange.
#define NIT_SCANNER_MAXCELL			50 	// The maximum number of cells than can be used in one scan
#define NIT_SCANNER_MIN_MOVEMENT	50 	// The minimum velocity an entity must have to be detected
										// by scanners that only detect movement

/*==================================================*/
/* Variables used for New Weapons and Reloading     */
/*==================================================*/
.float reload_shotgun;
.float reload_super_shotgun;
//.float reload_nailgun;
//.float reload_super_nailgun;
.float reload_grenade_launcher;
.float reload_rocket_launcher;
//.float reload_flamethrower;
//.float reload_incendiary;

// Assault Cannon
.float heat;

// Team Color Cheat Checking
.float immune_to_check;

// Make sure people don't do too many saveme sounds
.float last_saveme_sound;

// Armor Classes : Bitfields. Use the "armorclass" of armor for the Armor Type.
#define AT_SAVESHOT			1   // Kevlar  	 : Reduces bullet damage by 15%
#define AT_SAVENAIL			2   // Wood :) 	 : Reduces nail damage by 15%
#define AT_SAVEEXPLOSION	4  	// Blast   	 : Reduces explosion damage by 15%
#define AT_SAVEELECTRICITY	8 	// Shock	 : Reduces electricity damage by 15%
#define AT_SAVEFIRE			16 	// Asbestos	 : Reduces fire damage by 15%

/*==========================================================================*/
/* TEAMFORTRESS CLASS DETAILS												*/
/*==========================================================================*/
// Class Details for SCOUT
#define PC_SCOUT_SKIN				4 		// Skin for this class when Classkin is on.
#ifdef QUAKE_WORLD
	#define PC_SCOUT_MAXHEALTH			100		// Maximum Health Level
#else
	#define PC_SCOUT_MAXHEALTH			75 		// Maximum Health Level
#endif
#define PC_SCOUT_MAXSPEED			500		// Maximum movement speed
#define PC_SCOUT_MAXSTRAFESPEED		500		// Maximum strafing movement speed
#define PC_SCOUT_MAXARMOR			50 		// Maximum Armor Level, of any armor class
#define PC_SCOUT_INITARMOR			25 		// Armor level when respawned
#define PC_SCOUT_MAXARMORTYPE		0.3		// Maximum level of Armor absorption
#define PC_SCOUT_INITARMORTYPE		0.3		// Absorption Level of armor when respawned
#define PC_SCOUT_ARMORCLASSES		3 		// #AT_SAVESHOT | #AT_SAVENAIL   		<-Armor Classes allowed for this class
#define PC_SCOUT_INITARMORCLASS		0 		// Armorclass worn when respawned
#define PC_SCOUT_WEAPONS			#WEAP_AXE | #WEAP_SHOTGUN | #WEAP_NAILGUN
#define PC_SCOUT_MAXAMMO_SHOT		50 		// Maximum amount of shot ammo this class can carry
#define PC_SCOUT_MAXAMMO_NAIL		200		// Maximum amount of nail ammo this class can carry
#define PC_SCOUT_MAXAMMO_CELL		100		// Maximum amount of cell ammo this class can carry
#define PC_SCOUT_MAXAMMO_ROCKET		25 		// Maximum amount of rocket ammo this class can carry
#define PC_SCOUT_INITAMMO_SHOT		25 		// Amount of shot ammo this class has when respawned
#define PC_SCOUT_INITAMMO_NAIL		100		// Amount of nail ammo this class has when respawned
#define PC_SCOUT_INITAMMO_CELL		50 		// Amount of cell ammo this class has when respawned
#define PC_SCOUT_INITAMMO_ROCKET	0 		// Amount of rocket ammo this class has when respawned
//#define PC_SCOUT_GRENADE_TYPE_1		#GR_TYPE_NORMAL			 //    <- 1st Type of Grenade this class has
#define PC_SCOUT_GRENADE_TYPE_1		#GR_TYPE_FLASH			 //    <- 1st Type of Grenade this class has
#define PC_SCOUT_GRENADE_TYPE_2		#GR_TYPE_CONCUSSION      //    <- 2nd Type of Grenade this class has
#define PC_SCOUT_GRENADE_INIT_1		2 		// Number of grenades of Type 1 this class has when respawned
#define PC_SCOUT_GRENADE_INIT_2		3 		// Number of grenades of Type 2 this class has when respawned
#define PC_SCOUT_TF_ITEMS			#NIT_SCANNER  // <- TeamFortress Items this class has

#define PC_SCOUT_MOTION_MIN_I		0.5 	// < Short range
#define PC_SCOUT_MOTION_MIN_MOVE	50 		// Minimum vlen of player velocity to be picked up by motion detector

// Class Details for SNIPER
#define PC_SNIPER_SKIN				5 
#define PC_SNIPER_MAXHEALTH			90 
#define PC_SNIPER_MAXSPEED			300 		
#define PC_SNIPER_MAXSTRAFESPEED	300 
#define PC_SNIPER_MAXARMOR			50 
#define PC_SNIPER_INITARMOR			0 
#define PC_SNIPER_MAXARMORTYPE		0.3 
#define PC_SNIPER_INITARMORTYPE		0.3 
#define PC_SNIPER_ARMORCLASSES		3 		// #AT_SAVESHOT | #AT_SAVENAIL
#define PC_SNIPER_INITARMORCLASS	0 
#define PC_SNIPER_WEAPONS			#WEAP_SNIPER_RIFLE | #WEAP_AUTO_RIFLE | #WEAP_AXE | #WEAP_NAILGUN
#define PC_SNIPER_MAXAMMO_SHOT		75 
#define PC_SNIPER_MAXAMMO_NAIL		100 
#define PC_SNIPER_MAXAMMO_CELL		50 
#define PC_SNIPER_MAXAMMO_ROCKET	25 
#define PC_SNIPER_INITAMMO_SHOT		60 
#define PC_SNIPER_INITAMMO_NAIL		50 
#define PC_SNIPER_INITAMMO_CELL		0 
#define PC_SNIPER_INITAMMO_ROCKET	0 
#define PC_SNIPER_GRENADE_TYPE_1	#GR_TYPE_NORMAL
#define PC_SNIPER_GRENADE_TYPE_2	#GR_TYPE_FLARE
#define PC_SNIPER_GRENADE_INIT_1	2 	 
#define PC_SNIPER_GRENADE_INIT_2	3
#define PC_SNIPER_TF_ITEMS			0 

// Class Details for SOLDIER
#define PC_SOLDIER_SKIN				6 			
#define PC_SOLDIER_MAXHEALTH		100	 
#define PC_SOLDIER_MAXSPEED			200 		
#define PC_SOLDIER_MAXSTRAFESPEED	200 
#define PC_SOLDIER_MAXARMOR			200 
#define PC_SOLDIER_INITARMOR		100 
#define PC_SOLDIER_MAXARMORTYPE		0.8 
#define PC_SOLDIER_INITARMORTYPE	0.8 
#define PC_SOLDIER_ARMORCLASSES		31 		// ALL
#define PC_SOLDIER_INITARMORCLASS	0 
#define PC_SOLDIER_WEAPONS		 	#WEAP_AXE | #WEAP_SHOTGUN | #WEAP_SUPER_SHOTGUN | #WEAP_ROCKET_LAUNCHER
#define PC_SOLDIER_MAXAMMO_SHOT		100 
#define PC_SOLDIER_MAXAMMO_NAIL		100 
#define PC_SOLDIER_MAXAMMO_CELL		50 
#define PC_SOLDIER_MAXAMMO_ROCKET	50 
#define PC_SOLDIER_INITAMMO_SHOT	50 
#define PC_SOLDIER_INITAMMO_NAIL	0 
#define PC_SOLDIER_INITAMMO_CELL	0 
#define PC_SOLDIER_INITAMMO_ROCKET	10 
#define PC_SOLDIER_GRENADE_TYPE_1	#GR_TYPE_NORMAL
#define PC_SOLDIER_GRENADE_TYPE_2	#GR_TYPE_NAIL
#define PC_SOLDIER_GRENADE_INIT_1	4 	 
#define PC_SOLDIER_GRENADE_INIT_2	1 	 
#define PC_SOLDIER_TF_ITEMS			0 

// Class Details for DEMOLITION MAN
#define PC_DEMOMAN_SKIN				1 
#define PC_DEMOMAN_MAXHEALTH		90 
#define PC_DEMOMAN_MAXSPEED			300 		
#define PC_DEMOMAN_MAXSTRAFESPEED	300 
#define PC_DEMOMAN_MAXARMOR			100 
#define PC_DEMOMAN_INITARMOR		50 
#define PC_DEMOMAN_MAXARMORTYPE		0.6 
#define PC_DEMOMAN_INITARMORTYPE	0.6 
#define PC_DEMOMAN_ARMORCLASSES		31 		// ALL
#define PC_DEMOMAN_INITARMORCLASS	4 		// AT_SAVEEXPLOSION 
#define PC_DEMOMAN_WEAPONS			#WEAP_AXE | #WEAP_SHOTGUN | #WEAP_GRENADE_LAUNCHER | #WEAP_DETPACK
#define PC_DEMOMAN_MAXAMMO_SHOT		75 
#define PC_DEMOMAN_MAXAMMO_NAIL		50 
#define PC_DEMOMAN_MAXAMMO_CELL		50 
#define PC_DEMOMAN_MAXAMMO_ROCKET	50 
#define PC_DEMOMAN_MAXAMMO_DETPACK	1 
#define PC_DEMOMAN_INITAMMO_SHOT	30 
#define PC_DEMOMAN_INITAMMO_NAIL	0 
#define PC_DEMOMAN_INITAMMO_CELL	0 
#define PC_DEMOMAN_INITAMMO_ROCKET	20 
#define PC_DEMOMAN_INITAMMO_DETPACK	1 
#define PC_DEMOMAN_GRENADE_TYPE_1	#GR_TYPE_NORMAL
#define PC_DEMOMAN_GRENADE_TYPE_2	#GR_TYPE_MIRV
#define PC_DEMOMAN_GRENADE_INIT_1	4 	 
#define PC_DEMOMAN_GRENADE_INIT_2	4 	 
#define PC_DEMOMAN_TF_ITEMS			0 

// Class Details for COMBAT MEDIC
#define PC_MEDIC_SKIN				3 
#define PC_MEDIC_MAXHEALTH			90 
#define PC_MEDIC_MAXSPEED			300 
#define PC_MEDIC_MAXSTRAFESPEED		300 
#define PC_MEDIC_MAXARMOR			100
#define PC_MEDIC_INITARMOR			50 
#define PC_MEDIC_MAXARMORTYPE		0.6 
#define PC_MEDIC_INITARMORTYPE		0.3 
#define PC_MEDIC_ARMORCLASSES		11 		// ALL except EXPLOSION
#define PC_MEDIC_INITARMORCLASS		0 
#define PC_MEDIC_WEAPONS			#WEAP_BIOWEAPON | #WEAP_MEDIKIT | #WEAP_SHOTGUN | #WEAP_SUPER_SHOTGUN | #WEAP_SUPER_NAILGUN
#define PC_MEDIC_MAXAMMO_SHOT		75 
#define PC_MEDIC_MAXAMMO_NAIL		150 
#define PC_MEDIC_MAXAMMO_CELL		50 
#define PC_MEDIC_MAXAMMO_ROCKET		25 
#define PC_MEDIC_MAXAMMO_MEDIKIT	100 
#define PC_MEDIC_INITAMMO_SHOT		50 
#define PC_MEDIC_INITAMMO_NAIL		50 
#define PC_MEDIC_INITAMMO_CELL		0 
#define PC_MEDIC_INITAMMO_ROCKET	0 
#define PC_MEDIC_INITAMMO_MEDIKIT	50 
#define PC_MEDIC_GRENADE_TYPE_1		#GR_TYPE_NORMAL
#define PC_MEDIC_GRENADE_TYPE_2		#GR_TYPE_CONCUSSION
#define PC_MEDIC_GRENADE_INIT_1		3 	 
#define PC_MEDIC_GRENADE_INIT_2		2 	 
#define PC_MEDIC_TF_ITEMS			0 
#define PC_MEDIC_REGEN_TIME			3   // Number of seconds between each regen.
#define PC_MEDIC_REGEN_AMOUNT		2 	// Amount of health regenerated each regen.

// Class Details for HVYWEAP
#define PC_HVYWEAP_SKIN				2 
#define PC_HVYWEAP_MAXHEALTH		100 
#define PC_HVYWEAP_MAXSPEED			200 		
#define PC_HVYWEAP_MAXSTRAFESPEED	150 
#define PC_HVYWEAP_MAXARMOR			250 
#define PC_HVYWEAP_INITARMOR		150 
#define PC_HVYWEAP_MAXARMORTYPE		0.8 
#define PC_HVYWEAP_INITARMORTYPE	0.8 
#define PC_HVYWEAP_ARMORCLASSES		31 			// ALL
#define PC_HVYWEAP_INITARMORCLASS	0 		
#define PC_HVYWEAP_WEAPONS			#WEAP_ASSAULT_CANNON | #WEAP_AXE | #WEAP_SHOTGUN | #WEAP_SUPER_SHOTGUN
#define PC_HVYWEAP_MAXAMMO_SHOT		200 
#define PC_HVYWEAP_MAXAMMO_NAIL		200 
#define PC_HVYWEAP_MAXAMMO_CELL		50 
#define PC_HVYWEAP_MAXAMMO_ROCKET	25 
#define PC_HVYWEAP_INITAMMO_SHOT	200 
#define PC_HVYWEAP_INITAMMO_NAIL	0 
#define PC_HVYWEAP_INITAMMO_CELL	24 
#define PC_HVYWEAP_INITAMMO_ROCKET	0 
#define PC_HVYWEAP_GRENADE_TYPE_1	#GR_TYPE_NORMAL
#define PC_HVYWEAP_GRENADE_TYPE_2	#GR_TYPE_MIRV
#define PC_HVYWEAP_GRENADE_INIT_1	4 	 
#define PC_HVYWEAP_GRENADE_INIT_2	1 	 
#define PC_HVYWEAP_TF_ITEMS			0 


// Class Details for PYRO
#define PC_PYRO_SKIN			21 
#define PC_PYRO_MAXHEALTH		100 
#define PC_PYRO_MAXSPEED		300 
#define PC_PYRO_MAXSTRAFESPEED	250 
#define PC_PYRO_MAXARMOR		150 
#define PC_PYRO_INITARMOR		50 
#define PC_PYRO_MAXARMORTYPE	0.6 
#define PC_PYRO_INITARMORTYPE	0.6 
#define PC_PYRO_ARMORCLASSES	27 		// ALL except EXPLOSION
#define PC_PYRO_INITARMORCLASS	16  	// #AT_SAVEFIRE
#define PC_PYRO_WEAPONS			#WEAP_INCENDIARY | #WEAP_FLAMETHROWER | #WEAP_AXE | #WEAP_SHOTGUN
#define PC_PYRO_MAXAMMO_SHOT	40 
#define PC_PYRO_MAXAMMO_NAIL	50 
#define PC_PYRO_MAXAMMO_CELL	200 
#define PC_PYRO_MAXAMMO_ROCKET	60 
#define PC_PYRO_INITAMMO_SHOT	20 
#define PC_PYRO_INITAMMO_NAIL	0 
#define PC_PYRO_INITAMMO_CELL	120 
#define PC_PYRO_INITAMMO_ROCKET	15 
#define PC_PYRO_GRENADE_TYPE_1	#GR_TYPE_NORMAL
#define PC_PYRO_GRENADE_TYPE_2	#GR_TYPE_NAPALM
#define PC_PYRO_GRENADE_INIT_1	1 	 
#define PC_PYRO_GRENADE_INIT_2	4 	 
#define PC_PYRO_TF_ITEMS		0 

// Class Details for SPY
#define PC_SPY_SKIN				22 
#define PC_SPY_MAXHEALTH		90 
#define PC_SPY_MAXSPEED			300 
#define PC_SPY_MAXSTRAFESPEED	250 
#define PC_SPY_MAXARMOR			100 
#define PC_SPY_INITARMOR		25 
#define PC_SPY_MAXARMORTYPE		0.3 
#define PC_SPY_INITARMORTYPE	0.3 
#define PC_SPY_ARMORCLASSES		27 		// ALL except EXPLOSION
#define PC_SPY_INITARMORCLASS	0  
#define PC_SPY_WEAPONS			#WEAP_AXE | #WEAP_TRANQ | #WEAP_SUPER_SHOTGUN | #WEAP_NAILGUN
#define PC_SPY_MAXAMMO_SHOT		40 
#define PC_SPY_MAXAMMO_NAIL		50 
#define PC_SPY_MAXAMMO_CELL		30 
#define PC_SPY_MAXAMMO_ROCKET	15 
#define PC_SPY_INITAMMO_SHOT	40 
#define PC_SPY_INITAMMO_NAIL	0 
#define PC_SPY_INITAMMO_CELL	10 
#define PC_SPY_INITAMMO_ROCKET	0 
#define PC_SPY_GRENADE_TYPE_1	#GR_TYPE_NORMAL
#define PC_SPY_GRENADE_TYPE_2	#GR_TYPE_GAS
#define PC_SPY_GRENADE_INIT_1	2 	 
#define PC_SPY_GRENADE_INIT_2	2 	 
#define PC_SPY_TF_ITEMS			0 
#define PC_SPY_CELL_REGEN_TIME		5	
#define PC_SPY_CELL_REGEN_AMOUNT	1
#define PC_SPY_CELL_USAGE			3	// Amount of cells spent while invisible
#define PC_SPY_GO_UNDERCOVER_TIME	4	// Time it takes to go undercover

// Class Details for ENGINEER
#define PC_ENGINEER_SKIN			22 		// Not used anymore
#define PC_ENGINEER_MAXHEALTH		80 
#define PC_ENGINEER_MAXSPEED		300 
#define PC_ENGINEER_MAXSTRAFESPEED	250 
#define PC_ENGINEER_MAXARMOR		50
#define PC_ENGINEER_INITARMOR		25 
#define PC_ENGINEER_MAXARMORTYPE	0.6 
#define PC_ENGINEER_INITARMORTYPE	0.3 
#define PC_ENGINEER_ARMORCLASSES	31 		// ALL
#define PC_ENGINEER_INITARMORCLASS	0  
#define PC_ENGINEER_WEAPONS			#WEAP_SPANNER | #WEAP_LASER | #WEAP_SUPER_SHOTGUN
#define PC_ENGINEER_MAXAMMO_SHOT	50
#define PC_ENGINEER_MAXAMMO_NAIL	50 
#define PC_ENGINEER_MAXAMMO_CELL	200		// synonymous with metal 
#define PC_ENGINEER_MAXAMMO_ROCKET	30 
#define PC_ENGINEER_INITAMMO_SHOT	20 
#define PC_ENGINEER_INITAMMO_NAIL	25 
#define PC_ENGINEER_INITAMMO_CELL	100 	// synonymous with metal 
#define PC_ENGINEER_INITAMMO_ROCKET	0 
#define PC_ENGINEER_GRENADE_TYPE_1	#GR_TYPE_NORMAL
#define PC_ENGINEER_GRENADE_TYPE_2	#GR_TYPE_EMP
#define PC_ENGINEER_GRENADE_INIT_1	2 	 
#define PC_ENGINEER_GRENADE_INIT_2	2 	 
#define PC_ENGINEER_TF_ITEMS		0 

// Class Details for CIVILIAN
#define PC_CIVILIAN_SKIN			22 
#define PC_CIVILIAN_MAXHEALTH		50
#define PC_CIVILIAN_MAXSPEED		200
#define PC_CIVILIAN_MAXSTRAFESPEED	200
#define PC_CIVILIAN_MAXARMOR		0
#define PC_CIVILIAN_INITARMOR		0 
#define PC_CIVILIAN_MAXARMORTYPE	0
#define PC_CIVILIAN_INITARMORTYPE	0 
#define PC_CIVILIAN_ARMORCLASSES	0 		
#define PC_CIVILIAN_INITARMORCLASS	0
#define PC_CIVILIAN_WEAPONS			#WEAP_AXE
#define PC_CIVILIAN_MAXAMMO_SHOT	0
#define PC_CIVILIAN_MAXAMMO_NAIL	0 
#define PC_CIVILIAN_MAXAMMO_CELL	0 
#define PC_CIVILIAN_MAXAMMO_ROCKET	0 
#define PC_CIVILIAN_INITAMMO_SHOT	0 
#define PC_CIVILIAN_INITAMMO_NAIL	0 
#define PC_CIVILIAN_INITAMMO_CELL	0 
#define PC_CIVILIAN_INITAMMO_ROCKET	0 
#define PC_CIVILIAN_GRENADE_TYPE_1	0
#define PC_CIVILIAN_GRENADE_TYPE_2	0
#define PC_CIVILIAN_GRENADE_INIT_1	0 	 
#define PC_CIVILIAN_GRENADE_INIT_2	0 	 
#define PC_CIVILIAN_TF_ITEMS		0 


/*==========================================================================*/
/* TEAMFORTRESS GOALS														*/
/*==========================================================================*/
// For all these defines, see the tfortmap.txt that came with the zip
// for complete descriptions.
// Defines for Goal Activation types : goal_activation (in goals)
#define TFGA_TOUCH			1  // Activated when touched
#define TFGA_TOUCH_DETPACK	2  // Activated when touched by a detpack explosion
#define TFGA_REVERSE_AP		4  // Activated when AP details are _not_ met
#define TFGA_SPANNER		8  // Activated when hit by an engineer's spanner

// Defines for Goal Effects types : goal_effect
#define TFGE_AP				  1  // AP is affected. Default.
#define TFGE_AP_TEAM		  2  // All of the AP's team.
#define TFGE_NOT_AP_TEAM	  4  // All except AP's team.
#define TFGE_NOT_AP			  8  // All except AP.
#define TFGE_WALL			  16 // If set, walls stop the Radius effects
#define TFGE_SAME_ENVIRONMENT 32 // If set, players in a different environment to the Goal are not affected
#define TFGE_TIMER_CHECK_AP	  64 // If set, Timer Goals check their critera for all players fitting their effects

// Defines for Goal Result types : goal_result
#define TFGR_SINGLE			 1  // Goal can only be activated once
#define TFGR_ADD_BONUSES	 2 	// Any Goals activated by this one give their bonuses
#define TFGR_ENDGAME		 4 	// Goal fires Intermission, displays scores, and ends level
#define TFGR_NO_ITEM_RESULTS 8	// GoalItems given by this Goal don't do results
#define TFGR_REMOVE_DISGUISE 16 // Prevent/Remove undercover from any Spy

// Defines for Goal Group Result types : goal_group
// None!
// But I'm leaving this variable in there, since it's fairly likely
// that some will show up sometime.

// Defines for Goal Item types, : goal_activation (in items)
#define TFGI_GLOW			1   // Players carrying this GoalItem will glow
#define TFGI_SLOW			2   // Players carrying this GoalItem will move at half-speed
#define TFGI_DROP			4   // Players dying with this item will drop it
#define TFGI_RETURN_DROP	8   // Return if a player with it dies
#define TFGI_RETURN_GOAL	16  // Return if a player with it has it removed by a goal's activation
#define TFGI_RETURN_REMOVE	32  // Return if it is removed by TFGI_REMOVE
#define TFGI_REVERSE_AP		64  // Only pickup if the player _doesn't_ match AP Details
#define TFGI_REMOVE			128 // Remove if left untouched for 2 minutes after being dropped
#define TFGI_KEEP			256 // Players keep this item even when they die
#define TFGI_ITEMGLOWS		512	// Item glows when on the ground
#define TFGI_DONTREMOVERES	1024 // Don't remove results when the item is removed

// Defines for TeamSpawnpoints : goal_activation (in teamspawns)
#define TFSP_MULTIPLEITEMS	1  // Give out the GoalItem multiple times
#define TFSP_MULTIPLEMSGS	2  // Display the message multiple times

// Defines for TeamSpawnpoints : goal_effects (in teamspawns)
#define TFSP_REMOVESELF		1  // Remove itself after being spawned on

// Defines for Goal States
#define TFGS_ACTIVE		1 
#define TFGS_INACTIVE	2 
#define TFGS_REMOVED	3 
#define TFGS_DELAYED	4

// Variables used in the Goals
.float goal_no;				// Goal number of this goal
.float group_no;	 		// Goal group this goal is in
.float goal_state;			// State of this goal
.float owned_by;			// The team this goal/item/whatever belongs to

// Goal Activation details
.float goal_activation;		// Bitfields. Determines how this goal is activated
.float goal_effects;		// Bitfields. Determines which players are affected by this goal
.float goal_result;			// Bitfields. Determines the results of activation
.float goal_group;			// Bitfields. Determines how groups are affected by activation of this goal

.float else_goal;			// A Goal that's activated if this one fails to activate

.float if_goal_is_active;
.float if_goal_is_inactive;
.float if_goal_is_removed; 
.float if_group_is_active; 
.float if_group_is_inactive;
.float if_group_is_removed;

// Goal Result details
.float activate_goal_no;
.float inactivate_goal_no;
.float remove_goal_no;
.float restore_goal_no;		
.float activate_group_no;	
.float inactivate_group_no;	
.float remove_group_no;		
.float restore_group_no;

// Item State behaviour
.float has_item_from_group;
.float remove_item_group;
.float return_item_no;
.float if_item_has_moved;
.float if_item_hasnt_moved;

// Spawnpoint behaviour
.float remove_spawnpoint;
.float restore_spawnpoint;
.float remove_spawngroup;
.float restore_spawngroup;

// Item Displaying details
.float display_item_status1;	// Goal displays the status of these items
.float display_item_status2;	
.float display_item_status3;	
.float display_item_status4;	
.string team_str_home;		  // Displayed when the item is at home base
.string team_str_moved;		  // Displayed when the item has been moved
.string team_str_carried;     // Displayed when the item is being carried
.string non_team_str_home;	  // Displayed when the item is at home base
.string non_team_str_moved;	  // Displayed when the item has been moved
.string non_team_str_carried; // Displayed when the item is being carried

// Goal/Timer/GoalItem/Trigger existence checking
.float ex_skill_min;			// Exists when the skill is >= this value
.float ex_skill_max;			// Exists when the skill is <= this value
//.float ex_num_players_min;		// Exists when the number of players is >= this value
//.float ex_num_players_max;		// Exists when the number of players is <= this value

// Score increases
.float increase_team1;			// Increase the scores of particular teams
.float increase_team2;
.float increase_team3;
.float increase_team4;

// Centerprinting
.string broadcast;				// Centerprinted to all, overridden by the next two
.string team_broadcast;			// Centerprinted to AP's team members, but not the AP
.string non_team_broadcast; 	// Centerprinted to non AP's team members
.string owners_team_broadcast;  // Centerprinted to the members of the team that own the Goal/Item
.string netname_broadcast;				// same as above, prepended by AP netname and bprinted
.string netname_team_broadcast;			// same as above, prepended by AP netname and bprinted
.string netname_non_team_broadcast; 	// same as above, prepended by AP netname and bprinted
.string netname_owners_team_broadcast;  // same as above, prepended by AP netname and bprinted

.string team_drop;				// Centerprinted to item owners team
.string non_team_drop;			// Centerprinted to everone not on item owners team
.string netname_team_drop;		// same as above, prepended by AP netname and bprinted
.string netname_non_team_drop;  // same as above, prepended by AP netname and bprinted

string team_menu_string;	

.float all_active;

.float item_list;			// Used to keep track of which goalitems are 
							// affecting the player at any time.
							// GoalItems use it to keep track of their own 
							// mask to apply to a player's item_list
float item_list_bit;		// Global, used to determine what the bit of
							// each new GoalItem will be.

.float delay_time;			// For delayed goal results
.float dont_do_triggerwork;

// Abbreviations for the above
.float g_a;		// goal_activation
.float g_e;		// goal_effects

.string t_s_h;	// team_str_home
.string t_s_m;	// team_str_moved
.string t_s_c;	// team_str_carried
.string n_s_h;	// non_team_str_home
.string n_s_m;	// non_team_str_moved
.string n_s_c;	// non_team_str_carried

.string b_b;	// broadcast
.string b_t;	// team_broadcast
.string b_n;	// non_team_broadcast
.string b_o;	// owners_team_broadcast
.string n_b;	// netname_broadcast
.string n_t;	// netname_team_broadcast
.string n_n;	// netname_non_team_broadcast
.string n_o;	// netname_owners_team_broadcast

.string d_t;	// team_drop
.string d_n;	// non_team_drop
.string d_n_t;	// netname_team_drop
.string d_n_n;	// netname_non_team_drop

// Legal Playerclass Handling
#define TF_ILL_SCOUT 		1
#define TF_ILL_SNIPER		2
#define TF_ILL_SOLDIER		4
#define TF_ILL_DEMOMAN		8
#define TF_ILL_MEDIC		16
#define TF_ILL_HVYWEP		32
#define TF_ILL_PYRO			64
#define TF_ILL_RANDOMPC		128
#define TF_ILL_SPY			256
#define TF_ILL_ENGINEER		512
	   
/*==========================================================================*/
/* Flamethrower																*/
/*==========================================================================*/
float num_world_flames;

.float numflames; //number of flames on entity
// .float timecount; //timelength of the flames on entity
// this uses .health now
.string flame_id;  // has to be string so that the C function find() can be used

#define FLAME_PLYRMAXTIME	45  // lifetime in 0.1 sec of a flame on a player
#define FLAME_MAXBURNTIME	8  	// lifetime in seconds of a flame on the world (big ones)
#define NAPALM_MAXBURNTIME	20 	// lifetime in seconds of flame from a napalm grenade
#define FLAME_MAXPLYRFLAMES	4 	// maximum number of flames on a player
#define FLAME_NUMLIGHTS		1 	// maximum number of light flame 
#define FLAME_BURNRATIO		0.3 // the chance of a flame not 'sticking'
#define GR_TYPE_FLAMES_NO	15 	// number of flames spawned when a grenade explode

/*==========================================================================*/
/* Limit handling for various things										*/
/*==========================================================================*/
// pipebomb limits
// when the limit is exceeded, older pipebombs explode
float num_world_pipebombs;
float num_team_pipebombs_1;
float num_team_pipebombs_2;
float num_team_pipebombs_3;
float num_team_pipebombs_4;

// ammobox limits
// when the limit is exceeded, older ammoboxes disappear
float num_world_ammoboxes;
float num_team_ammoboxes_1;
float num_team_ammoboxes_2;
float num_team_ammoboxes_3;
float num_team_ammoboxes_4;

/*==================================================*/
/* Spy variables	 								*/
/*==================================================*/
.float undercover_team;		// The team the Spy is pretending to be in
.float undercover_skin;		// The skin the Spy is pretending to have
.string undercover_name;   	// The name of the player the Spy is pretending to be

/*==================================================*/
/* CTF Support defines 								*/
/*==================================================*/
#define CTF_FLAG1 		1
#define CTF_FLAG2 		2
#define CTF_DROPOFF1 	3
#define CTF_DROPOFF2 	4
#define CTF_SCORE1   	5
#define CTF_SCORE2   	6

float	spy_off;	// Spy class off/on
float	invis_only; // Spy invisible instead of color/skin changing
float   allow_hook;	// Allow players to use the hook
.float	hook_out;

/*==================================================*/
/* Camera defines	 								*/
/*==================================================*/
float live_camera;
.float camdist;
.vector camangle;
.entity camera_list;

/*==================================================*/
/* QuakeWorld defines 								*/
/*==================================================*/
// some redecs for printing in QW

float already_chosen_map;

#ifndef QUAKE_WORLD
entity		newmis;				// if this is set, the entity that just
								// run created a new missile that should
								// be simulated immediately
#endif

// grappling hook variables

.entity	hook;	
.float	on_hook;
.float  fire_held_down;// flag - TRUE if player is still holding down the
                       // fire button after throwing a hook.


// sniper location damage stuff

.vector head_shot_vector;
.float leg_damage;

.float cheat_level;

// flash grenade level
.float FlashTime;

// status bar stuff
.float StatusRefreshTime;		// time to next refresh the status bar
								// any function that uses a CenterPrintnt
								// should reset this value
.float StatusBarSize;		// the size of the bar. 1 is default, 0 is off
.float StatusBarRes;		// the gfx res the player's running in

/*==================================================*/
/* Death Message defines							*/
/*==================================================*/
float deathmsg;		// Global, which is set before every T_Damage, to indicate
					// the death message that should be used.

#define DMSG_SHOTGUN			1
#define DMSG_SSHOTGUN			2
#define DMSG_NAILGUN			3
#define DMSG_SNAILGUN			4
#define DMSG_GRENADEL			5
#define DMSG_ROCKETL			6
#define DMSG_LIGHTNING			7
#define DMSG_GREN_HAND			8
#define DMSG_GREN_NAIL			9
#define DMSG_GREN_MIRV			10
#define DMSG_GREN_PIPE			11
#define DMSG_DETPACK			12
#define DMSG_BIOWEAPON			13
#define DMSG_BIOWEAPON_ATT		14
#define DMSG_FLAME				15
#define DMSG_DETPACK_DIS		16
#define DMSG_AXE				17
#define DMSG_SNIPERRIFLE		18
#define DMSG_AUTORIFLE			19
#define DMSG_ASSAULTCANNON		20
#define DMSG_HOOK				21
#define DMSG_BACKSTAB			22
#define DMSG_MEDIKIT			23
#define DMSG_GREN_GAS			24
#define DMSG_TRANQ				25
#define DMSG_LASERBOLT			26
#define DMSG_SENTRYGUN_BULLET 	27
#define DMSG_SNIPERLEGSHOT		28
#define DMSG_SNIPERHEADSHOT		29
#define DMSG_GREN_EMP			30
#define DMSG_GREN_EMP_AMMO		31
#define DMSG_SPANNER			32
#define DMSG_INCENDIARY			33
#define DMSG_SENTRYGUN_ROCKET	34
#define DMSG_GREN_FLASH			35
#define DMSG_TRIGGER			36
