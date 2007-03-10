/*
	common.qc - ai replacement functions, less messy and possibly improved upon
*/

#ifndef COOP_MODE_ENHANCED
#pragma DONT_COMPILE_THIS_FILE
#else


.float() OnNoticeEnemy;						// self.enemy is the enemy noticed, return false for invalid targets
.void() OnRespawn;						// self is the new entity respawning
.float() OnPreAttack;						// self is about to attack self.enemy, return false to prevent


/*
	COOP_SightBlocked - checks if an entities sight to the given entity is blocked
*/

float (entity start, entity end) COOP_SightBlocked =
{
	makevectors (start.angles);

	// return false if another entity or the map blocked our sight, also if we crossed contents

	traceline (start.origin, end.origin, #TL_ANY_SOLID, start);
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

	NOTE: all targeting is done in common.qc, so the prozac bugs where monsters and sentries spaz out because of
	dead enemy monster (etc) corpses shouldn't be present... That bug was caused by Often forgetting to check the
	enemy's health before targeting the enemy monster, a simple "if (head.health <= 0)" fixed that (I fixed it).
*/

float (entity us, entity test) COOP_IsValidTarget =
{
	local float r;

	//if (us.team_no != #TEAMNO_MONSTERS && test.team_no == #TEAMNO_MONSTERS)
	//	return #TRUE;
	if (test.classname == "monster_demon1" || test.classname == "monster_army" || test.classname == "monster_shambler" ||
		test.classname == "monster_wizard" || test.classname == "monster_fish" || test.classname == "monster_gremlin") {
		if (!Teammate(test.real_owner.team_no, us.team_no))
			return #TRUE;
	} else if (test.classname == "grenade" && test.netname == "land_mine") {
		if (!Teammate(test.owner.team_no, us.team_no))
			return #TRUE;
	} else if (!Teammate(test.team_no, us.team_no)) {
		if (IsBuilding(test) && test.classname != "building_sentrygun_base")
			return #TRUE;
		else if (test.classname == "player") {
			r = vlen(test.origin - us.origin);

			// use Pharse_Client for client checking
			if (Pharse_Client(test, us, 0, 0, 0, 0) && r < 2000) {
				if (!(test.flags & #FL_NOTARGET) && !(test.items & #IT_INVISIBILITY)) {
					// Check if he's a theif
					if (test.job & #JOB_THIEF && test.job & #JOB_ACTIVE && r >= 200)	// #JOB_FULL_HIDE
						return #FALSE;

					return #TRUE;
				}
			}
		}
	}

	return #FALSE;
};


/*
	COOP_FindTarget - finds something we should attack

	NOTE: this shouldn't be the cause of cpu lag anymore, since it doesn't happen very often
*/

entity (entity scanner) COOP_FindTarget =
{
	local entity head;

	// This is here to ease cpu with maps that have a lot of monsters, also adds a human factor for delayed notice
	if (scanner.#npc_noticedelay > time)
		return world;

	self.#npc_noticedelay = time + 1.3;


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
};


//====================================


/*
	COOP_CanAttackEnemy
*/

float (entity en) COOP_CanAttackEnemy =
{
	if (!visible2(en, self) || !en.takedamage || en.health <= 0)
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
	local entity e;
	local float sightblocked, r, chance;
	local float c_attack;

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
	sightblocked = COOP_SightBlocked (self, self.enemy);
	r = range (self.enemy);

// check if he's in an attack state (usually for telling the monster to attack but face him first, attacking resets the state)
	// use these to tell the monster to not fire right away and aim at him
	if (self.attack_state && self.attack_state != #AS_STRAIGHT) {
		self.ideal_yaw = vectoyaw (self.enemy.origin - self.origin);
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
			if (r <= #RANGE_MELEE) {
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
	} else if (sightblocked) {
		e = COOP_FindTarget (self);

		if (e != world && e != self.enemy)
			COOP_AttackTarget (e);
	}

// at this point we're either sliding or are just heading straight into the enemy
	if (self.attack_state == #AS_SLIDING)
		return;

	// increase our speed by the factor if there is one set
	if (self.#npc_speedfactor)
		movetogoal (dist * self.#npc_speedfactor);
	else
		movetogoal (dist);
};


//====================================


// FIXME: this stuff isn't used, yet


/*
	COOP_RandomName
*/

string () COOP_RandomName =
{
	local float rnum;

	rnum = random();

	if (rnum < 0.5)
		return "fido";
	else
		return "bob";
};


/*
	COOP_GenerateMonsterName
*/

string (entity monster) COOP_GenerateMonsterName =
{
	return monster.netname;
};


//====================================


/*
	COOP_SetLives - automatically sets a monster's lives, either by localinfo or the default
*/

void () COOP_SetLives =
{
	local string temp;

/*
	// already set, return
	if (self.lives)
		return;
*/

	temp = infokey (world, "monster_lives");
	self.lives = stof (temp);

	// set default if none set already
	if (!self.lives)
		self.lives = 3;

	// subtract one for the initial life
	self.lives = self.lives - 1;
};


/*
	COOP_SetupRespawn - sets up a monster to respawn, self will be the newly allocated entity to respawn.
	This way we can simple put the same function that the map calls to spawn monsters
	self must be the monster respawning, that means you must call this BEFORE the monster is removed
*/

void () respawn_think =
{
	local entity head;
	local float savedlives;

	head = findradius (self.origin, 56);

	while (head) {
		if (head.takedamage && head.health > 0) {
			self.nextthink = time + 5;
			self.think = respawn_think;
			return;
		}

		head = head.chain;
	}

	// play teleport effect
	spawn_tfog (self.origin);
/*
	WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
	WriteByte (#MSG_BROADCAST, #TE_TELEPORT);
	WriteCoord (#MSG_BROADCAST, self.origin_x);
	WriteCoord (#MSG_BROADCAST, self.origin_y);
	WriteCoord (#MSG_BROADCAST, self.origin_z);
	multicast (self.origin, #MULTICAST_PHS);
*/

	// respawn the monster
	savedlives = self.lives;
	self.think1 ();
	self.lives = savedlives;
};

void (float respawntime, void() spawn_func) COOP_SetupRespawn =
{
	local entity newmon;

	if (!spawn_func) {
//		bprint (#PRINT_HIGH, "Invalid spawn func!\n");
		return;
	}

	if (self.lives <= 0) {
//		bprint (#PRINT_HIGH, "Out of lives!\n");
		return;
	}

	newmon = spawn ();
	newmon.lives = self.lives - 1;
	setorigin (newmon, self.#npc_originalloc);

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
	if (monster_mode == 1) {
		if (attacker.team_no == #TEAMNO_MONSTERS && targ.classname == "player")
			return indmg * 2;
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
	if (!targ.#npc_othermult)
		targ.#npc_othermult = 1;

	// make summons and army soldiers stronger
	if (GetMonsterName(targ) != "unknown monster" && targ.team_no != #TEAMNO_MONSTERS)
		return indmg * 0.50;
	else if (targ.team_no != #TEAMNO_MONSTERS)
		return indmg;

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
	else if (attacktype == #TF_TD_OTHER)
		indmg = indmg * targ.#npc_othermult;

	return indmg;
};

#endif
