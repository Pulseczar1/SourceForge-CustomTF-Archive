/* Admin status:  anyone will be able to be admin using the impulse
power with the current numbers...

-- Inferno
This is to be more orginized too...so I could just add, trust me, it's
easier! :)
*/
/* ###################################################################
   #######################INTERNAL COMMANDS###########################
   ###################################################################
*/
void(entity client, string abcd, string bcde, string cdef, string defg, string efgh, string fghi, string ghij) ncenterprint = #73;  // like centerprint


//===============================================

/* ==================================================================
   ()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()
   ==================================================================
*/

// GLOBAL VARIABLES (RESET TO ??? ) AT EACH LEVEL START
// two sets will be created.  
float m4dToken;   // only 1 person can have this rune at a time
float m4dTimer;  // rune wont work until level has run for awhile

float firstSetLo;
float firstSetHi;
float secondSetLo;
float secondSetHi;
float flag_lockdown; // vote option prevents team flag pick-up

// tells whether or not the flags has been switched, set this to 1 if
// the teamplay flag is enabled and you want bases to exchange for
// this level.
// Set it to 2 if the teamplay flag is enabled, but you don't want
// the bases to change on this level.
// default (teamplay flag is not set, or not checked yet) is 0.
float flag_switched;

// used to lock a server to prevent people from leaving
// observer mode and disrupting your game.
float locked_flag;    // 0 is an unlocked server, 1 is locked
entity lastvotespawn;
// how many runes are allowed on a map?
// now we let cvar samelevel set it.
float MAX_RUNES_ON_MAP;  //  

float team1_flag_picked;  // red team
float team2_flag_picked;  // blue team
float team1_flag_pick;  // team1 is finding a flag spot
float team2_flag_pick;  // team2 is finding a flag spot

float max_time_to_pick;  // maximum time you have to pick a flag base!!
                              // to where it belongs
// just for changing the level
string nextmap;

// at the start
float gamestart;

/* ###################################################################
   ###########################MODELINDEXES############################
   ###################################################################
   things that specifically (spelled right? :) have to do with the
   player him/her self
*/
float modelindex_flame2;  // as it says..
float modelindex_enforcer;  // lasergun rune, you're just the enforcer
float modelindex_dog;  // that's right, when the witch curses you
float modelindex_fish;  // fish
float modelindex_wizard;  // looks like a wizard, but really gremlin
float modelindex_zombie;  // the zombie
float modelindex_hknight;  // hell knight
float modelindex_knight;  // rebel knight
float modelindex_player_head;  // the player's head
float modelindex_boss;  // the BIG BOSS
float modelindex_v_spike;  // the v_spike for the observer
float modelindex_oldone;  // the BIG OLDONE
float modelindex_gib2;  // gib2
float modelindex_rocket;  // rocket
float modelindex_soldier;  // soldier
float modelindex_shambler;  // shambler
float modelindex_shalrath;  // shalrath
float modelindex_conv;  // converter


// Some of the Ghost's rune modelindexes (BIG LIST!)
float modelindex_v_axe;  // the axe
float modelindex_v_star;  // if the person had the grappling hook
float modelindex_v_shot;  // shotgun
float modelindex_v_shot2;  // double barreled
float modelindex_v_nail;  // nailgun
float modelindex_v_nail2;  // super nailgun
float modelindex_v_rock;  // grenade launcher
float modelindex_v_rock2;  // rocket launcher
float modelindex_v_light;  // lightning gun


// for level transfers
float parm17, parm18, parm19, parm20;

float sicHoundCount;
float dogPatrolActive;  // 1 is active



// CONSTANT VARIABLES, MUST NEVER TRY TO CHANGE THESE AT RUN TIEM
/* ------------------------------------------------------------------- */


/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
           Goes with the above, values for different new weapons
   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*/
float BOMB_RADIUS = 750;  // tell the people in that radius that there is a bomb
float PLAYER_BAN_FLAG = 1;  // banning people
float OP_PLAYER_FLAG = 2;  // op flag
float ADMIN_PLAYER_FLAG = 4;  // admin flag
float STATUS_PLAYER_FLAG = 8;  // status flag
float ITEM_SECOND_RUNE = 16;  // second power of runes..
float STATUS_FL = 32;  // laser on

/* new weapons, yup yup!  This is for selections, must have diff values!!! */
float NEW_AXE = 0;  // axe
float NEW_HOOK = 1;  // hook
float NEW_RP = 2;
float NEW_SWING = 3;  // swing hook
float NEW_SHOTGUN = 4;  // shotgun
float NEW_MINE = 5;  // mine thrower
float NEW_SNIPER = 6;  // sniper gun
float NEW_SUPER_SHOTGUN = 7;  // super shotgun
float NEW_FLARE = 8;  // flaregun
float NEW_KSPIKE = 9;  // spike gun
float NEW_NAIL = 10;  // nailgun
float NEW_FLAME = 11;  // another flamethrower
float NEW_SUPER_NAIL = 12;  // super nailgun
float NEW_ACID = 13;  // acid gun
float NEW_GIBGUN = 14;  // gib gun
float NEW_GRENADE = 15;  // grenade launcher
float NEW_SHRAPNEL = 16;  // flamethrower
float NEW_PB = 17;  // pipe bomb
float NEW_ROCKET = 18;  // rocket launcher
float NEW_PLASMA = 19;  // plasma gun
float NEW_MINDG = 20;  // mind-gas
float NEW_LIGHTNING = 21;  // thunderbolt
float NEW_LASER = 22;  // laser gun
float NEW_SUPERM = 23;  // super missiles!
float NEW_LAVAGUN = 24;  // lavagun
float NEW_DOG = 25;  // dog launcher
float NEW_CGRENADE = 26;  // concussion grenades
float NEW_FREEZEGUN= 27;  // freezegun
float NEW_HGRENADE = 28;  // hand grenade
//float NEW_FGRENADE = 27;  // fragmentation grenades
//float NEW_HOMING = 24;
float NEW_MINES = 29;  // proximity mine

float MAX_MINES = 5; // how many proxi-mines can be on the map

// now, for the ammo
float AMMO_LASER = 2;  // for the lasergun
float AMMO_FIRE = 2;  // for the firegun
float AMMO_FLAME = 2; // Flame Thrower (little nailgun) uses Nails
float AMMO_MINE = 7;  // for the mines
//float AMMO_BOMB = 12;  // for the bomb
//float AMMO_HOMING = 6;  // for the homing missile
float AMMO_LAVAGUN = 10;  // for the lavagun
// float AMMO_FGRENADE=10;  // for the fragmentation grenades
// float AMMO_PLASMA = 4;  // cost 4 rockets for the plasma gun
float AMMO_PLASMA = 3;  // cost 3 rockets for the plasma gun
float AMMO_SHRAPNEL = 1; // Shrapnel takes Rockets
float AMMO_SNIPER = 7;  // Sniper takes Shells and Rockets
float AMMO_MINDG = 7;  // cost 7 rockets for the mind gas gun
float AMMO_FLARE = 16;  // how many cells and shells does it take to fire a flare?
float AMMO_KSPIKE = 8;  // how many nails does it take to fire it?
float AMMO_ACID = 10;  // nails for each acid shot
float AMMO_GIBGUN = 2;  // gibgun (rockets)
float AMMO_FREEZEGUN = 1;  // ammo for the freeze gun
//float AMMO_CGRENADE=1;  // 

// ORIGINAL RUNE SET
float RUNE_EARTH_MAGIC = 1;  // Earth Magic
float RUNE_BLACK_MAGIC = 2;  // Black Magic
float RUNE_HELL_MAGIC = 3;  // Hell Magic
float RUNE_ELDER_MAGIC = 4;  // Elder Magic
// MISC. SET
float RUNE_TELEPORT = 5;  // Teleport Rune
float RUNE_FUTURE = 6;  // Future Rune
float RUNE_ARMOR = 7;  // Power of Armor
float RUNE_STRONG = 8;  // Strong Magic
// MISC. SET2
float RUNE_LIQUID = 9;  // Liquid Rune
float RUNE_DISAPEAR = 10;  // Disapearance Rune
// CONFUSED SET
float RUNE_FOOLISH = 11;
// MEDIEVIL SET
float RUNE_WHITE_MAGIC = 12;  // White Magic
float RUNE_WIZARD = 13;  // Wizard Magic
float RUNE_WITCH = 14;  // Witch's Magic
float RUNE_KNIGHT = 15;  // Knight
// SUPERNATURAL SET
float RUNE_LUCK = 16;  // Luck Rune
float RUNE_GHOST = 17;  // Ghosts Rune
float RUNE_ILLUSION = 18;  // Illusion
// MYTH SET
float RUNE_ZEUS = 19;  // Zeus (spelled right? :)
float RUNE_POSEIDON = 20;  // Poseidon
float RUNE_MARS = 21;  // Mars
float RUNE_HERMES = 22;  // Hermes
// MYTH SET2
float RUNE_HADES = 23;  // Hades  INACTIVE!
float RUNE_ARTEMIS = 24;  // Artemis
float RUNE_DEMETER = 25;  // Demeter
// PRESENT SET
float RUNE_COP = 26;  // cop rune
float RUNE_NAVY_OFFICER = 27;  // navy officer
float RUNE_FPILOT = 28;  // fighter pilot
// PRESENT SET2
float RUNE_CWORKER = 29;  // construction worker
// MORTAL KOMBAT SET
float RUNE_SUBZERO = 30;  // Sub Zero
float RUNE_RAIDEN = 31;  // Raiden
// MORTAL KOMBAT SET2
float RUNE_JOHNNY_CAGE = 32;  // Johnny Cage
float RUNE_KANO = 33;  // Kano
float RUNE_KANG = 34;  // Liu Kang (this is for short)
// MORTAL KOMBAT II SET
float RUNE_REPTILE = 35;  // Reptile
// float RUNE_LAO = 36;  // Kung Lao
float RUNE_MIB = 36;
// MORTAL KOMBAT II SET2
float RUNE_TSUNG = 37;  // Shang Tsung
float RUNE_PORTAL_MASTER = 38;  // Portal Master
// MORTAL KOMBAT III SET
float RUNE_SEKTOR = 39;  // Sektor
float RUNE_SMOKE = 40;  // Smoke
// MORTAL KOMBAT MISC SET
float RUNE_KINTARO = 41;  // Kintaro
// DARKAGES SET
float RUNE_WEREWOLF = 42;  // Werewolf
float RUNE_DRAGON = 43;  // Dragon
float RUNE_ZOMBIE = 44;  // Zombie
float RUNE_VAMPIRE = 45;  // Vampire
// DARKAGES SET2
float RUNE_FP = 46;  // Pet Frankie
// EARTH SET      
float RUNE_WATER = 47;  // water
float RUNE_LIFE = 48;  // life
float RUNE_DEATH = 49;  // death
// HERO SET
float RUNE_SUPERMAN = 50;  // superman
float RUNE_PUNISHER = 51;  // the punisher
// HERO SET2
float RUNE_SPAWN = 52;  // Spawn
// FUTURE SET
float RUNE_WEAPONS = 53;  // weapons specialist
float RUNE_ROBOT = 54;  // Robot
// STORM SET         
float RUNE_THUNDER = 55;  // thunder storm
// IMAGINARY SET
float RUNE_DREAM = 56;  // dream
float RUNE_NIGHTMARE = 57;  // nightmare
float RUNE_POSSESSER = 58;  // possesser
// ANIMAL SET           
float RUNE_TURTLE = 59;  // Turtle
// INSECT SET         
float RUNE_ANT = 60;  // Ant
// COTC SET
float RUNE_MEDIC = 61; // medic
float RUNE_TARANTULA = 62; // Tarantula Rune
float RUNE_ORGANDONOR = 63;
float MAX_RUNES = 64; // Always one value higher then the last rune

float RUNE_M4D_SK1LLZ = 99;


float NITEM_PQ = 1;  // PentaQuad
float NITEM_RSHIELD = 2;  // Reflector Shield
float NITEM_CONV = 16;  // converter (from start)
float ITEM_YOUR_FLAG = 1;  // your flag
float ITEM_GET_YOUR_FLAG = 2;  // when you can get your flag
float ABLE_KEY5_FLAG = 4;  // when you have second rune power on

float RUNED_FLAG = 8;  // when you can do your help
float DIE_OBSERVER_FLAG = 16;  // turn into an observer when death comes
float CLEAR_OBSERVER_FLAG = 32;  // when the person can clear their observer
float OBSERVER_FLAG = 64;  // the person is the observer
float DO_OBSERVER_FLAG = 128;  // pointer to OBSERVER_FLAG
float ONFIRE_FLAG = 256;  // tells whether or not the person is on fire
float SET_BOMB_FLAG = 512;  // tells when a person could set his/her bomb
float JUST_JOINED_FLAG = 1024;  // when a person enters the game
float ABLE_KEY1_FLAG = 2048;  // when the person can teleport
float OBSERVER_CHANGE_FLAG = 4096;  // so we don't flood when changing views of observer
float MASSIVE_FLAME_FLAG = 8192;  // don't get confused...
float ABLE_KEY2_FLAG = 16384;  // when the person can turn invisible
float ABLE_TSUNG = 32768;  // enable shang tsung's morph
.float tsung_time;  // when to morph back
float CHASE_OBSERVER_FLAG = 65536;  // chase someone (observer)
float FR_RAIDEN = 262144;  // raiden's frames
float FR_JCAGE = 524288;  // Johnny Cage's frames
float FR_KANO = 1048576;  // Kano's frames
float FR_KANG = 2097152;  // Liu Kang's frames
float FR_LAO = 4194304;  // Kung Lao's frames
float FR_MILEENA = 8388608;  // mileena's frames

// the inferno cnt call
float ITEM_STAY = 0;
float ITEM_CARRIED = 1;

// thrown flag cnt for throwing the flag
float FLAG_THROWN = 3;

// new teamplay customs added by inferno
float TEAM_OBSERVER_MODE = 1024;  // go into observer mode
float TEAM_COUNT_WEAPONS = 2048;  // count the weapons so you can throw a lot
float TEAM_RANDOM_ITEMS = 4096;  // random items to be spawned
float PICK_UP_OWN_FLAG = 8192;   // allow team to pick up their own flag
float ALLOW_RETURN_TO_CTFSTART = 16384;   // allow return to ctfstart, from idctf maps
float TEAM_RANDOM_BASES = 32768;  // chooses random bases for the flags
// pick-your-own-base's flags
float TEAM_PICK_BASE = 65536;  // allow players to choose their own bases
float TEAM_PLEVELS = 131072;  // preferred levels
float OBSERVER_TIMELIMIT = 262144;    // observers get kicked after some time
float M4D_SK1LLZ_ALLOWED = 524288;  // allows the mad skills rune
float SCTF_GOD_MODE = 1048576; // all players spawn with all weaps and ammo
float SCTF_FAST_HOOK = 2097152; // speed up the hook
float BIGGEST_TEAMPLAY_BIT = 2097152;  // set this to largest teamplay bit

float PMAX=12;  // powerlevel 12 is the max!

float TEAM_CUSTOM_SCTF = 1048576;  // custom sctf

// how many runes are allowed on the map?
float MAX_NUM_RUNES = 60; // 8;

float OBSERVER_MAX_TIME = 900;  // 15 minutes


/* ###################################################################
   ###########################SCORING#################################
   ###################################################################
*/
float INFERNO_GET_FLAG = 10;  // what is the bonus for getting someone who has
float INFERNO_TEAM_GET_FLAG = 5;  // their own flag?  What does the team get?

float COTC_EGG = 1;
float HOC_EGG = 2;
float NP_EGG = 3;
float ANARCHY_EGG = 4;

float OTHER_TYPE = 0;
float PLAYER_TYPE = 1;
float CLONE_TYPE = 2;

float MAX_SIC = 1;

float M4D_FRAGGED = 4;  // how many consecutive frags until you get loser rune
float M4D_FRAGS = 2;  // how many consecutive frags until you lose the loser rune
float M4D_TIME = 60;  // max time they can keep the rune, like any powerup
float M4D_TIMER = 120; // how long before the rune is activated for a level
float M4D_DELTA = 50;  // team has to be losing by this much
float M4D_SHOTS = 3;             // how many shots they are allowed

float RESPAWN_INVINCIBLE_TIME = 10;  // secs to be initially invincible


// ENTITY VARIABLES

/* for the special weapon patches */
.float LaserCount;  // Laser must count up to 3
.float nweapon;  // for new weapons
.float prev_nweapon;  // previous weapon command, for the new weapons if needed

// time for weapon powerups to be fired
.float pweapon_time;

.float ss_count, n_count, sn_count, gl_count, rl_count, l_count, d_count;  // count the weapons

.float bubble_time;  // can't overload the entity fields, so use this

.float pl_block;  // when the player is blocking
.float pl_block_time;  // when to end it!

.string bugs;  // bugs...
.float bugs_time;  // how long they last?
.entity bugs_owner;  // the bugs' owner
.float bugs_dmg_time;  // damage time

.float freezeFinishSeconds; // how long an enemy will stay frozen
.float freezeMessageTime;   // display how long your frozen until
.float targframe;  // keeps the target's frame (freeze gun)
.entity firewood;  // gets the burner 
.float timer_bomb;  // how long will the bomb stay until it explodes?
.vector inforigin;
.float pb;  // pipe bomb
.float runeg_rune;  // rune, good powers
.float runeg_time;  // rune, good powers
.float rune_power;  // what type of power
.float rune_power_time;  // the time (some powers last longer)
.float rune_powerv;  // victum of the rune power

// for the other runes (flags)
.string runemodel;  // what model should the runes be
.float rune;  // indicator of what new runes there are

.float nitems;

// PentaQuad variables
.float pq_time;
.float pq_finished;
// Reflector Shield variables
.float rs_time;
.float rs_finished;
.float rsed;

// so you can create an entity for the person
.entity clone;
.float clone_use;  // to use the clone

// RUNE STUFF
.float runeb_rune;  // the bad rune type
.float runeb_flag;  // status_flag & ITEM_SECOND_RUNE or not
.float runeb_time;  // the time of how long it should last

// so you can duck (when duck is on)
.float pl_duck;
.float pl_duck_time;

// for ghosts rune, count the number of clones
.float rune12clone_count;

// for picking up a flag, each person picks it up in a different way
.float pick_flag;

// used when the server is locked
.float granted_flag;  // players are given a 1 when granted

// for the individual, if the person is also voting for exit
.float voting;
.float voted;

// tells the owner's last velocity
.vector oldvel;

// inferno's lovely flags
.float status_flag;  //status of people

.float inferno_flag;
.float bad_count;  // for BAD runes

// added to the key5 texture:
.float key5_flag_count;

// for the admin patch
.float accesslvl;
.float accessparm;
.float opercheck;

// old angle of the player
.vector oldangle;

// to show what a player died from more accurately
.float player_died;

// powerup, the more hits you do, the more powerful you get!
.float powerhealth;  // related to the level, number of health damaged gives you a point
.float powerlevel;  // the person's powerlevel

// when a person is in the help menu
.float help_time;  // checking service-time

.float flag_picked_time;  // how long till another person gets a chance

.float pick_flag_base;  // this flag is on if a person is the chosen one
.entity flag_chooser;  // who is going to choose where the flag goes?

// anyone (quakec writer) that wants to use a count, there's more than one!
.float count_count;
.float count_count2;

// reason of why a player died
.string reason_died;

// update_time, so the person (if the person has the mode on) can see
// how many kills (frags), blue score...etc...
.float update_time;

// added to show how many times the person died
.float died;

// easier for a quakec writer (like me :) that needs a count for time
.float time_count;
.float time_count2;

// since you can only have 1 rune, a rune count
.float rune_count;

// what creature is the player?
.string monster_type;
// monster impulses
.float mimpulse;
// dog jumps and touches a person..interesting weapon..really!
.float dog_ttouch;

// used by the medic
.entity plagueEntity;  // this keeps the victim sick
.entity MedicEntity;  // this keeps the team healthy

//stuff for IP banning
.float inputNo;
.float inputCount;
.float inputType;
.float ip1;
.float ip2;
.float ip3;
.float ip4;
.string ips1;
.string ips2;
.string ips3;
.string ips4;

// for the proximity mine
.float sctfWeaponCount; // Counts a fwe seconds before arming proximity mines 
.float proxiCount;  // max proxies active
.float boobCount;   // Max Boobies

// for flight
.float fly;

// for ee
// flag 1  cotc   2  hoc  3  nucka   4  std
// set eeflag to start display, do not set eemsg to anything
// set eetime for how long (15 is good)
// in nteam, customize the message, in sctfweap init the effect
// and play the sound
.float eeTime;          // how long to display
.float eeFlag;          // which egg
.float eeMsg;           // dont play with the values here

// for organ donor rune
.float napalmTime;

// inferno has abused the classname field to the point where it cannot
// be used to id the entity anymore.  This field will be positively
// set for players and clones, as a replacement.
.float entityType; // 0  other, 1  player, 2 clone, 

.float observerDoorTime;  // dont check for door every frame
.float cloneInitialized;  // when a clone has to perform a onetime
                           // initialization, like dropping to floor :)

// tarantula trick type
.float boobyType;   // 0 rox 1 backpack
.float bigHead;  // if the poison is attacking a player, dont let them pain think

// that dang motd can only display with this flag set.
.float motdDisplay;   // 0 no motd 1 motd

.void()		RuneEffect;

// siccing the doggies on bad characters
.float defcon;
.float mentalHound;
.float mentalHoundTime;
.float sicOneTime; // for testing only
.float sicHound;           // once a player is targeted, their entity is tagged
.float soundTime;  // how long between barks or growls

// for rune descriptions
.string runeName;
.string  power1;
.string  power2;
.float newRune;  // set when the rune is picked up, for status bar display

// 2-clone fields
//    CloneX fields are set in the owner, and used as a link to the clone.
//    Goalentity is set in the clone, and used as a link to the owner.
//    If the clone is killed, explodes, or times out, it is responsible for
//       updating the owner's clonex field.
//    If the owner changes powers, runes, or dies, it is responsible for
//       removing the clones, and clearing its clonex fields.
.entity clone1;
.entity clone2;

// for hook failsafe
.entity hooker;

// for player id
.float playerId;

// for observer time limit
.float observerTime;

// used for chase cam, possess 1st power, etc
.entity chase_observer;

// this is how we award the m4d sk1llz rune
.float fragTotal;
.float consecutiveFragged;
.float fraggedTotal;
.float m4dFrags;  // how many kills before you lose the rune
.float m4dTime;   // how long before you lose the rune
.float m4dShots;  // how many shots they have taken

// when the player respawns, they get an initial
// invincible time, which goes away if they fire,
// take the flag, or the time expires.  The difference
// between a power up and respawn is in this flag.
.float respawnInvincibleFlag;

// dont let players use sneaky names
.float name_warning_count;

// Some entities are being fired through walls.  This is 
// a bug in the engine (I cant find out where though),
// that only happens when the entity.owner is not set to
// the player.  But we need this capability in order to be
// able to interact with the entity later, to shoot it.
// In this case, set the goalentity and the owner to the
// player, but instead of the normal think/time, set the
// think to firstthink and the time to .5.  In these fields,
// put the intended think and the intended time minus .5.
// In the firstthink, we reset the owner field to world.
.float secondNextThink;
.void() secondThink;

// kickbot
.float lastspeed;
.float lastangle;
.float lastyaw;

.float botcount1;
.float botcount2;

.float isBot;

/*************************************************************************
**************************************************************************
*************************************************************************/

