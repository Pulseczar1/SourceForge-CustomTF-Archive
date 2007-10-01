/*
	coop_defs.qc
*/

#ifndef COOP_MODE_ENHANCED
#pragma DONT_COMPILE_THIS_FILE
#else


// misc monster stuff
#define NPC_TRANQ_FACTOR			0.6				// how much monsters slow down when tranqed

// alternate teams
#define TEAMNO_MONSTERS				100				// team number for monsters

// monster weights, a monster can be inbetween these
#define MWEIGHT_SMALL				80				// small monster
#define MWEIGHT_NORMAL				160
#define MWEIGHT_MEDIUM				290
#define MWEIGHT_LARGE				500
#define MWEIGHT_HUGE				1000

// monster flags
#define MFLAG_HASWEAPON				1				// used for judo, determines if he can be stunned
#define MFLAG_HUMANOID				2				// dogs and other similar monsters won't have this flag
#define MFLAG_ALMOSTHUMANOID			4				// almost looks like a humanoid
#define MFLAG_BITER				8				// the monster can bite (IE: dogs)
#define MFLAG_NOHEART				16				// mainly for warlock heart grabbing
#define MFLAG_NOBREATHING			32				// monster doesn't breathe, (IE: shambler, enforcer (has suit))

// macros for certain variables so we can reuse unused variables and still give it a unique name
#define npc_speedfactor				speed
#define npc_noticedelay				invisible_finished
#define npc_spawnfunc				think1			// safe to use?
#define npc_spawndelay				walkframe			// was gravity
#define npc_originalloc				pos1
#define npc_attackoffset			pos2				// where the npc shoots from, IE: '0 0 40' for shams
#define npc_enemyoffset				dest				// offset that our enemy is visible
#define npc_inpain				demon_one			// if the monster is currently in pain

// damage multipliers
#define npc_bulletmult				money
#define npc_spikemult				custom_speed
#define npc_explosionmult			ff_count
#define npc_electricitymult			hover_time
#define npc_firemult				penance_time
#define npc_meleemult				has_cheated
#define npc_othermult				has_cheated			// FIXME: right now melee works by other, we should make all melee weapons use TF_TD_MELEE

// used for smooth movement of monsters, FIXME: change vars I just made up some crap to see if it compiles
.void() npc_oldthink;

#define npc_oldthink				npc_oldthink
#define npc_smoothtime				maxspeed			// this is the time when we need to give back control to monster and stop lerping
#define npc_smoothdist				demon_blood			// total distance we need to go
#define npc_lastruntime				done_custom			// last time our lerp function was called
#define npc_attemptednextthink		cnt

// globals
float server_spawned;								// TRUE if server is spawned and ready to go

// coop monster fields
.float monsterweight;
.float monsterflags;								// MFLAG_*** flags

#endif
