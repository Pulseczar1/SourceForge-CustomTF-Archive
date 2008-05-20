/*
	common.qc - ai replacement functions, less messy and possibly improved upon
*/

#ifndef COOP_MODE_ENHANCED
#pragma DONT_COMPILE_THIS_FILE
#else


.float() OnNoticeEnemy;						// self.enemy is the enemy noticed, return false for invalid targets
//.void() OnRespawn;						// self is the new entity respawning
.float() OnPreAttack;						// self is about to attack self.enemy, return false to prevent


/*
	COOP_IsCoopMonster - returns true only if this is a coop monster, not if it's a monster in general
*/

float( entity test ) COOP_IsCoopMonster = {
	if (test.#npc_isCoopMonster == #TRUE)
		return #TRUE;
	return #FALSE;
};


/*
	COOP_FindShootOffset - replacement for COOP_SightBlocked()
*/

float (entity start, entity end) COOP_FindShootOffset =
{
	local vector startVec, tempVec;

	makevectors (start.angles);

// set the initial monster's point of view for the line of sight check
	startVec = start.origin + start.#npc_attackoffset;

// start checking for any visible line of sight to enemy
	traceline (startVec, end.origin, #TL_ANY_SOLID, start);
	if (trace_ent == end && (!trace_inopen || !trace_inwater)) {
		start.#npc_enemyoffset = '0 0 0';
		return #TRUE;
	}

	start.#npc_enemyoffset = '0 0 16';
	traceline (startVec, end.origin + start.#npc_enemyoffset, #TL_ANY_SOLID, start);
	if (trace_ent == end && (!trace_inopen || !trace_inwater))
		return #TRUE;

	start.#npc_enemyoffset = end.view_ofs;
	traceline (startVec, end.origin + start.#npc_enemyoffset, #TL_ANY_SOLID, start);
	if (trace_ent == end && (!trace_inopen || !trace_inwater))
		return #TRUE;

	// start on end
//	makevectors (end.angles);
	tempVec = end.origin - startVec;
	tempVec_y = vectoyaw (tempVec);
	tempVec_x = 0;
	tempVec_z = 0;
	makevectors (tempVec);

	start.#npc_enemyoffset = v_right * end.mins_y;
	traceline (startVec, end.origin + start.#npc_enemyoffset, #TL_ANY_SOLID, start);
	if (trace_ent == end && (!trace_inopen || !trace_inwater))
		return #TRUE;

	start.#npc_enemyoffset = v_right * end.maxs_y;
	traceline (startVec, end.origin + start.#npc_enemyoffset, #TL_ANY_SOLID, start);
	if (trace_ent == end && (!trace_inopen || !trace_inwater))
		return #TRUE;

	start.#npc_enemyoffset = v_up * end.mins_z;
	traceline (startVec, end.origin + start.#npc_enemyoffset, #TL_ANY_SOLID, start);
	if (trace_ent == end && (!trace_inopen || !trace_inwater))
		return #TRUE;

	start.#npc_enemyoffset = v_up * end.maxs_z;
	traceline (startVec, end.origin + start.#npc_enemyoffset, #TL_ANY_SOLID, start);
	if (trace_ent == end && (!trace_inopen || !trace_inwater))
		return #TRUE;

	// corners
	start.#npc_enemyoffset = (v_up * end.maxs_z) + (v_right * end.maxs_y);
	traceline (startVec, end.origin + start.#npc_enemyoffset, #TL_ANY_SOLID, start);
	if (trace_ent == end && (!trace_inopen || !trace_inwater))
		return #TRUE;

	start.#npc_enemyoffset = (v_up * end.maxs_z) + (v_right * end.mins_y);
	traceline (startVec, end.origin + start.#npc_enemyoffset, #TL_ANY_SOLID, start);
	if (trace_ent == end && (!trace_inopen || !trace_inwater))
		return #TRUE;

	start.#npc_enemyoffset = (v_up * end.mins_z) + (v_right * end.maxs_y);
	traceline (startVec, end.origin + start.#npc_enemyoffset, #TL_ANY_SOLID, start);
	if (trace_ent == end && (!trace_inopen || !trace_inwater))
		return #TRUE;

	start.#npc_enemyoffset = (v_up * end.mins_z) + (v_right * end.mins_y);
	traceline (startVec, end.origin + start.#npc_enemyoffset, #TL_ANY_SOLID, start);
	if (trace_ent == end && (!trace_inopen || !trace_inwater))
		return #TRUE;

	return #FALSE;
};


/*
	COOP_SightBlocked - checks if an entity's sight to the given entity is blocked

	8/8/07: Gizmo - updated this function for better monster targeting
*/

float (entity start, entity end) COOP_SightBlocked =
{
	makevectors (start.angles);

	// return false if another entity or the map blocked our sight, also if we crossed contents

	traceline (start.origin + start.#npc_attackoffset, end.origin, #TL_ANY_SOLID, start);
	if (trace_ent != end)
		return #TRUE;
	if (trace_inopen && trace_inwater)
		return #TRUE;

/*
	traceline (start.origin + (v_right * start.mins_y), end.origin, #TL_ANY_SOLID, start);
	if (trace_ent != end)
		return #TRUE;
	if (trace_inopen && trace_inwater)
		return #TRUE;

	traceline (start.origin + (v_right * start.maxs_y), end.origin, #TL_ANY_SOLID, start);
	if (trace_ent != end)
		return #TRUE;
	if (trace_inopen && trace_inwater)
		return #TRUE;
*/

	return #FALSE;
};


/*
	COOP_IsValidTarget

	NOTE: health and takedamage are not checked by this function
*/

float( entity us, entity test ) COOP_IsValidTarget = {
	local float r;

	if (test.classname == "monster_demon1" || test.classname == "monster_army" || test.classname == "monster_shambler" ||
		test.classname == "monster_wizard" || test.classname == "monster_fish" || test.classname == "monster_gremlin") {
		if (!Teammate(test.real_owner.team_no, us.team_no))
			return #TRUE;
/*
	} else if (test.classname == "grenade" && test.netname == "land_mine") {
		if (!Teammate(test.owner.team_no, us.team_no))
			return #TRUE;
*/
	} else if (!Teammate(test.team_no, us.team_no)) {
		if (IsBuilding(test) && test.classname != "building_sentrygun_base")
			return #TRUE;
		else if (test.classname == "player") {
			r = vlen(test.origin - us.origin);

			// use Pharse_Client for client checking
			if ( Pharse_Client( test, us, 0, 0, 0, 0 ) ) {
				if ( r > 2048 && !visible2( test, us ) )
					return #FALSE;
				if (!(test.flags & #FL_NOTARGET) && !(test.items & #IT_INVISIBILITY)) {
					// check if he's a theif
					if (test.job & #JOB_THIEF && ((test.job & #JOB_ACTIVE && !(test.job & #JOB_FULL_HIDE) && r >= 140) || test.job & #JOB_FULL_HIDE))
						return #FALSE;

					return #TRUE;
				}
			}
		}
		else if ( IsMonster( test ) )		// IsMonster() should return true for both coop and non-coop monsters
			return #TRUE;
	}

	return #FALSE;
};


/*
	COOP_FindTarget - finds something we should attack
*/

float worldscan_delay;
entity npc_teamLists;
.entity npc_nextTeamList;
.entity npc_nextEntInTeamList;

entity( float t ) COOP_GetTeamList = {
	local entity cur;

	cur = npc_teamLists;
	while ( cur ) {
		if ( Teammate( cur.team_no, t ) )
			return cur;

		cur = cur.npc_nextTeamList;
	}

	return world;
};

void( entity list ) COOP_AddTeamList = {
	// npc_teamLists points to the first one
	if ( npc_teamLists == world ) {
		npc_teamLists = list;
		list.npc_nextTeamList = world;
		list.npc_nextEntInTeamList = world;
		return;
	}

	list.npc_nextEntInTeamList = world;
	list.npc_nextTeamList = npc_teamLists;
	npc_teamLists = list;
};

entity _npc_lastTeamEntity;
void( entity e ) COOP_AddToTeamList = {
	local entity list;

	// this is to enhance performance, and to prevent runaway loop errors
	// it prevents us from going through every ent every time in the current list for every entity we add to it
	if ( npc_teamLists == world || _npc_lastTeamEntity == world || !Teammate( _npc_lastTeamEntity.team_no, e.team_no ) ) {
		list = COOP_GetTeamList( e.team_no );

		if ( list == world ) {
			COOP_AddTeamList( e );
			return;
		}

		while ( list.npc_nextEntInTeamList != world )
			list = list.npc_nextEntInTeamList;
	} else
		list = _npc_lastTeamEntity;

	list.npc_nextEntInTeamList = e;
	e.npc_nextEntInTeamList = world;
	e.npc_nextTeamList = world;
	_npc_lastTeamEntity = e;
};

entity (entity scanner) COOP_FindTarget =
{
	local entity	head;
	local entity	bestp;
	local float		monster_mode;

	bestp = world;

/*
	// this is here to ease cpu with maps that have a lot of monsters, also adds a human factor for delayed notice
	if (scanner.#npc_noticedelay > time)
		return world;

	// use a random delay so it doesn't all happen at once
	self.#npc_noticedelay = time + 0.5 + random();		// old delay was 1.3

	// FIXME: weigh pros and cons of find vs findradius: cpu, etc.
	head = findradius (scanner.origin, 2048);

	while (head) {
		// seems to be a compiler bug or something, it doesn't work right when the "if" is all on one line
		if (visible2(head, scanner) && head.takedamage && head.health > 0) {
			if (COOP_IsValidTarget(scanner, head))
				return head;
		}

		head = head.chain;
	}

	return world;
*/

	// check if we should scan for new entities that weren't present before
	if (worldscan_delay <= time) {
		npc_teamLists = world;

		head = findradius (world.origin, 65536);

		while (head) {
			if ( head.classname == "monster_demon1" || head.classname == "monster_army" || head.classname == "monster_shambler" ||
				head.classname == "monster_wizard" || head.classname == "monster_fish" || head.classname == "monster_gremlin" )
				COOP_AddToTeamList( head );
			else if ( IsBuilding(head) && head.classname != "building_sentrygun_base" )
				COOP_AddToTeamList( head );
			else if ( head.flags & #FL_CLIENT )
				COOP_AddToTeamList( head );
			else if ( COOP_IsCoopMonster( head ) )
				COOP_AddToTeamList( head );

			head = head.chain;
		}

		worldscan_delay = time + 1.3;
	}

	// this is here to ease cpu with maps that have a lot of monsters, also adds a human factor for delayed notice
	if (scanner.#npc_noticedelay > time)
		return world;

	// check for the non-targeting mode
	monster_mode = stof (infokey(world, "monster_mode"));
	if (monster_mode & 4)
		return world;

	// use a random delay so it doesn't all happen at once
	self.#npc_noticedelay = time + 0.3 + random();		// old delay was 1.3

	if ( npc_teamLists == world )
		return world;

	head = npc_teamLists;
	while ( head != world && Teammate( head.team_no, scanner.team_no ) )
		head = head.npc_nextTeamList;

	while ( head ) {
		if (visible2(head, scanner) && head.takedamage && head.health > 0) {
			if (COOP_IsValidTarget(scanner, head)) {
				// pick the closest player if only players are visible
				if (head.flags & #FL_CLIENT) {
					if (bestp == world || vlen(head.origin - scanner.origin) < vlen(bestp.origin - scanner.origin))
						bestp = head;
				} else
					return head;
			}
		}

		if ( head.npc_nextEntInTeamList == world ) {
			do {
				head = head.npc_nextTeamList;
			} while ( head != world && Teammate( head.team_no, scanner.team_no ) );
		} else
			head = head.npc_nextEntInTeamList;
	}

	// players are always picked last, so if a player was found then return it, but if not bestp will be world
	// findradius() did this automatically because it returns a chain backward through the entity list
	return bestp;
};


//====================================


#define NPC_FRAMETIME			0.1
#define NPC_LERPTIME			0.031


/*
	COOP_SmoothFrame
*/

void () COOP_SmoothFrame =
{
	local float oldyaw;

	if (time >= self.#npc_smoothtime) {
		// FIXME: is it ok to call #npc_oldthink directly here?
		self.nextthink = time;
		self.think = self.#npc_oldthink;
		self.#npc_lastruntime = 0;
		return;
	}

	// make sure lastruntime is set to something
	if (!self.#npc_lastruntime) {
		self.#npc_lastruntime = self.lastruntime;

		self.nextthink = time + #NPC_LERPTIME;
		return;
	}

	movedist = (self.#npc_smoothdist / #NPC_FRAMETIME) * (self.lastruntime - self.#npc_lastruntime);

	// movetogoal if there's distance to move, it should only be zero if SV_RunThink is in an infinite loop
	// this prevents infinite SV_RunThink loops in the engine
	if (movedist) {
		oldyaw = self.yaw_speed;
		self.yaw_speed = (oldyaw / #NPC_FRAMETIME) * (self.lastruntime - self.#npc_lastruntime);
		movetogoal (movedist);
		self.yaw_speed = oldyaw;

		self.#npc_lastruntime = self.lastruntime;
		self.#npc_attemptednextthink = self.nextthink = time + #NPC_LERPTIME;
	} else if (self.#npc_smoothdist) {
		//bprint (#PRINT_HIGH, "infinite loop prevented!\n");
		self.#npc_attemptednextthink = self.nextthink = self.#npc_attemptednextthink + 0.01;
	}
};


/*
	COOP_WalkSmooth - this is called, in sort of like a wrapper to movetogoal, to provide lerping movement
*/

void (float dist) COOP_WalkSmooth =
{
	if (!dist)
		return;

	// save old stuff
	self.#npc_oldthink = self.think;
	self.#npc_smoothtime = time + #NPC_FRAMETIME;

	self.#npc_smoothdist = dist;

	// set think function
//	self.nextthink = time + 0.031;
	self.think = COOP_SmoothFrame;

	// do one right away
	COOP_SmoothFrame ();
};


//====================================


/*
	COOP_CanAttackEnemy
*/

float (entity en) COOP_CanAttackEnemy =
{
	if (/*!visible2(en, self) || */!en.takedamage || en.health <= 0)
		return #FALSE;
	return #TRUE;
};



/*
	COOP_AttackTarget - sets up the monster to start attacking his enemy

	TODO: add random delay for first catching a player, 0.1 is the standard in-between frame time
*/

void (entity en) COOP_AttackTarget =
{
	self.goalentity = self.enemy = en;

	self.nextthink = time + 0.1;
	self.think = self.th_run;

	self.ideal_yaw = vectoyaw (en.origin - self.origin);

	// erase last time
	self.#npc_lastEnemyTime = 0;
};


/*
	COOP_NoticeEnemy
*/

float () COOP_NoticeEnemy =
{
	local entity e, lasten;
	local float ret;

	e = COOP_FindTarget (self);

	if (e == world)
		return #FALSE;

// check if enemy is valid
	lasten = self.enemy;
	self.enemy = e;
	if (self.OnNoticeEnemy)
		ret = self.OnNoticeEnemy ();
	else
		ret = #TRUE;

	// FIXME: check self.enemy, self.movetarget, and self.goalentity (like COOP_Run() does for invalid targets)
	// be sure not to call any run, walk, etc. functions here (could make the monster's frames stop)
	if (!ret) {
		self.enemy = lasten;
		return #FALSE;
	}

// attack the target if it was valid
	COOP_AttackTarget (e);

	return #TRUE;
};



/*
	COOP_Idle - default idle function for searching
*/

void () COOP_Idle =
{
	// if we got a target somehow, attack it
	if (self.enemy != world && self.enemy != self)
		COOP_AttackTarget (self.enemy);

	if (COOP_NoticeEnemy())
		return;

	// check for pausetime
	if (time > self.pausetime)
		self.th_walk ();
};


/*
	COOP_Walk - default walking function
*/

void (float dist) COOP_Walk =
{
	// if we got a target somehow, attack it
	if (self.enemy != world && self.enemy != self)
		COOP_AttackTarget (self.enemy);

	if (COOP_NoticeEnemy())
		return;

	movedist = dist;
	movetogoal (dist);
};


/*
	COOP_Turn - faces ideal_yaw slowly, doesn't move the monster
*/

void () COOP_Turn =
{
	if (self.enemy)
		self.ideal_yaw = vectoyaw (self.enemy.origin - self.origin);
	else if (COOP_NoticeEnemy())
		return;

	ChangeYaw ();
};


/*
	COOP_Run - default run function
*/

void (float dist) COOP_Run =
{
	local entity	e;
	local float		sightblocked, r;
	local float		c_attack;

	// for other functions like slide if we use them
	movedist = dist;

// first check if our target is still valid
	if (self.enemy == world || self.enemy == self || self.enemy.health < 0 || !COOP_IsValidTarget(self, self.enemy)) {
		self.enemy = world;
		self.attack_state = #AS_STRAIGHT;

		if (self.movetarget) {
			// walk our path again
			self.goalentity = self.movetarget;
			self.th_walk ();
		} else
			self.th_stand ();
		return;
	}

// get default variables so we don't have to calculate them over and over
	sightblocked = (!COOP_FindShootOffset(self, self.enemy));
	r = range (self.enemy);

// check if he's in an attack state (usually for telling the monster to attack but face him first, attacking resets the state)
	// use these to tell the monster to not fire right away and aim at him
	if (self.attack_state && self.attack_state != #AS_STRAIGHT) {
		self.ideal_yaw = vectoyaw ((self.enemy.origin + self.#npc_enemyoffset) - self.origin);
		ChangeYaw ();

		// if sight is blocked, reset the attack state
		if (sightblocked) {
			self.attack_state = #AS_STRAIGHT;
			return;
		}

		if (self.attack_state == #AS_MELEE) {
			if (FacingIdeal()) {
				if (self.th_melee)
					self.th_melee ();
				self.attack_state = #AS_STRAIGHT;
			}
			return;
		} else if (self.attack_state == #AS_SLIDING) {
			local float ofs;

			if (sightblocked) {
				self.attack_state = #AS_STRAIGHT;
				return;
			}

			if (self.lefty)
				ofs = 90;
			else
				ofs = -90;
	
			if (!walkmove(self.ideal_yaw + ofs, movedist)) {
				self.lefty = 1 - self.lefty;
	
				walkmove (self.ideal_yaw - ofs, movedist);
			}
		} else if (self.attack_state == #AS_MISSILE) {
			if (FacingIdeal()) {
				if (self.th_missile)
					self.th_missile ();
				self.attack_state = #AS_STRAIGHT;
			}
			return;
		}
	}

// check if we can attack
	// TODO: possibly add another time for melee?
	if (!sightblocked && COOP_CanAttackEnemy(self.enemy)) {
		// call the entity's custom attack checkers if they are present
		if (self.OnPreAttack)
			c_attack = self.OnPreAttack ();
		else
			c_attack = #TRUE;

		if (c_attack) {
			// mark this position as valid
			self.#npc_lastEnemyOrigin = self.enemy.origin;
			self.#npc_lastEnemyTime = time;

			if (r <= #RANGE_MELEE && visible(self.enemy)) {
				if (self.th_melee) {
					// TODO: check if facing, no that's done above if state is set
					self.th_melee ();
					return;
				}
			}
			if (self.th_missile) {
				if (self.attack_finished < time) {
					// TODO: add randomness on when he attacks and just keeps walking
					self.th_missile ();
					return;
				}
			}
		}

		if (r <= #RANGE_MELEE) {
			self.ideal_yaw = vectoyaw ((self.enemy.origin + self.#npc_enemyoffset) - self.origin);
			ChangeYaw ();
		}
	} else if (sightblocked) {
		e = COOP_FindTarget (self);

		if (e != world && e != self.enemy)
			COOP_AttackTarget (e);
/*	TODO: need to also face that direction
		else if ( random() > 0.80 ) {
			// check if we can shoot blindly where they last were, in hopes for a lucky shot
			if ( self.#npc_lastEnemyTime && time - self.#npc_lastEnemyTime < 10 ) {
				if ( self.attack_finished < time ) {
					if ( self.#NPCFireBlind ) {
						self.#NPCFireBlind();
						return;
					}
				}
			}
		}
*/
	}

// at this point we're either sliding or are just heading straight into the enemy
	if (self.attack_state == #AS_SLIDING)
		return;

	// decrease our speed if tranqed
	if (self.tfstate & #TFSTATE_TRANQUILISED)
		dist = dist * #NPC_TRANQ_FACTOR;
	// increase our speed by the factor if there is one set
	if (self.#npc_speedfactor)
		COOP_WalkSmooth (dist * self.#npc_speedfactor);
		//movetogoal (dist * self.#npc_speedfactor);
	else
		COOP_WalkSmooth (dist);
};


//====================================


// FIXME: this stuff isn't used, yet


/*
	COOP_RandomName
*/

/*
string () COOP_RandomName =
{
	local float rnum;

	rnum = random();

	if (rnum < 0.5)
		return "fido";
	else
		return "bob";
};
*/


/*
	COOP_GenerateMonsterName
*/

/*
string (entity monster) COOP_GenerateMonsterName =
{
	return monster.netname;
};
*/


//====================================


/*
	COOP_SetLives - automatically sets a monster's lives, either by localinfo or the default
*/

void () COOP_SetLives =
{
	local string temp;

	// if the map already has this set, return
	// a respawning monster will ingore any changes made to .lives
	if ( self.lives ) {
		// subtract one for the initial life
		self.lives = self.lives - 1;
		return;
	}

	temp = infokey( world, "monster_lives" );
	self.lives = stof( temp );

	// set default if none set already
	if ( !self.lives )
		self.lives = 3;

	// subtract one for the initial life
	self.lives = self.lives - 1;
};


/*
	COOP_SetupRespawn - sets up a monster to respawn, self will be the newly allocated entity to respawn.
	This way we can simply put the same function that the map calls to spawn monsters
	self must be the monster respawning, that means you must call this BEFORE the monster is removed
*/

void () respawn_monster =
{
	local float savedlives;

	// make sure to erase the touch function, the rest should be reset by the spawn function (size, solid, and movetype)
	self.touch = SUB_Null;

	// play teleport effect
	spawn_tfog (self.origin);

	// respawn the monster
	savedlives = self.lives;
	self.think1 ();
	self.lives = savedlives;

	// check if he's in a wall
	if (InSolid(self)) {
		// this is kind of like a hack, but it works to ensure monster count is bumped
		self.flags = self.flags | #FL_MONSTER;
		self.deathtype = "monster_respawn";
		self.health = -60;
		Killed (self, world);
	}
};

void () respawn_think;
void() respawn_verify =
{
	// if something is in the way, then extend the respawn time 5 seconds and resetup the trigger
	// at that time so we can check for still objects again after the 5 seconds are up
	if (other.takedamage && other.health > 0) {
		self.nextthink = time + 5;
		self.think = respawn_think;

		// don't let anything else touching within 5 seconds reset the timer back to 5 seconds
		self.touch = SUB_Null;
		// don't let the sizebox continue to grow each time
		setsize (self, self.mins + '1 1 1', self.maxs - '1 1 1');
	}
};

void () respawn_think =
{
	// setup the monster to be a trigger before it's spawned, to check for things in the way
	self.movetype	= #MOVETYPE_NONE;
	self.solid		= #SOLID_TRIGGER;
	self.touch		= respawn_verify;
	setsize (self, self.mins - '1 1 1', self.maxs + '1 1 1');

	self.nextthink = time + 0.2;
	self.think = respawn_monster;
	
	force_retouch = 2;		// make sure even still objects get hit
};

void( float respawntime, void() spawn_func ) COOP_SetupRespawn = {
	local entity newmon;

	// check for a valid spawn function
	if ( !spawn_func )
		return;

	// check if it's out of lives
	if ( self.lives <= 0 )
		return;

	newmon = spawn();
	newmon.lives = self.lives - 1;
	newmon.angles = newmon.#npc_originalAngles = self.#npc_originalAngles;
	newmon.target = self.target;
	setsize( newmon, self.mins, self.maxs );
	setorigin( newmon, self.#npc_originalloc );

	newmon.nextthink = time + respawntime;
	newmon.think = respawn_think;
	newmon.think1 = spawn_func;
};


/*
	COOP_CalcEntityDamage - calculates how much damage an entity should take based on it's damage multipliers

	attacktype is the same as the last field on TF_T_Damage
*/

float (entity targ, entity attacker, float indmg, float attacktype) COOP_CalcEntityDamage =
{
	local float monster_mode;

	// check for insane mode, thought about putting this in StartFrame, but I'd bet T_Damage gets called less overall
	monster_mode = stof (infokey(world, "monster_mode"));
	if (monster_mode & 1) {
		if ( COOP_IsCoopMonster( attacker ) && targ.classname == "player" )
			return indmg * 2;
	}
	if (monster_mode & 2) {
		if (attacker.flags & #FL_CLIENT && COOP_IsCoopMonster(targ))
			indmg = indmg * 0.5;
	}

	if ( !COOP_IsCoopMonster( targ ) ) {
		// make summons and army soldiers stronger
		if (GetMonsterName(targ) != "unknown monster")
			return indmg * 0.5;
		else
			return indmg;
	}

	// automatic adjustment to the number of players
	if (attacker.flags & #FL_CLIENT) {
		if (num_players <= 2)
			indmg = indmg * 1.7;	// 2
		else if (num_players <= 4)
			indmg = indmg * 1.4;	// 1.6
		else if (num_players == 5)
			indmg = indmg * 1.2;
		else if (num_players >= 8)
			indmg = indmg * 0.8;
	}

	if (!targ.#npc_bulletmult)
		targ.#npc_bulletmult = 1;
	if (!targ.#npc_spikemult)
		targ.#npc_spikemult = 1;
	if (!targ.#npc_explosionmult)
		targ.#npc_explosionmult = 1;
	if (!targ.#npc_electricitymult)
		targ.#npc_electricitymult = 1;
	if (!targ.#npc_firemult)
		targ.#npc_firemult = 1;
	if (!targ.#npc_meleemult)
		targ.#npc_meleemult = 1;
	if (!targ.#npc_othermult)
		targ.#npc_othermult = 1;

	// if the target is a coop monster then do the special stuff
	if (attacktype == #TF_TD_SHOT)
		indmg = indmg * targ.#npc_bulletmult;
	else if (attacktype == #TF_TD_NAIL)
		indmg = indmg * targ.#npc_spikemult;
	else if (attacktype == #TF_TD_EXPLOSION)
		indmg = indmg * targ.#npc_explosionmult;
	else if (attacktype == #TF_TD_ELECTRICITY)
		indmg = indmg * targ.#npc_electricitymult;
	else if (attacktype == #TF_TD_FIRE)
		indmg = indmg * targ.#npc_firemult;
	else if (attacktype == #TF_TD_MELEE)
		indmg = indmg * targ.#npc_meleemult;
	else if (attacktype == #TF_TD_OTHER)
		indmg = indmg * targ.#npc_othermult;

	return indmg;
};

#endif
