/*
	coop_monsters.qc - standard functions for monsters
*/

#ifndef COOP_MODE_ENHANCED
#pragma DONT_COMPILE_THIS_FILE
#else


/* ALL MONSTERS SHOULD BE 1 0 0 IN COLOR */

// name =[framenum,	nexttime, nextthink] {code}
// expands to:
// name ()
// {
//		self.frame=framenum;
//		self.nextthink = time + nexttime;
//		self.think = nextthink
//		<code>
// };

/*
	coop_debugtargetprint
*/

void () coop_debugtargetprint =
{
	dprint ("Monster ");
	dprint (self.classname);
	dprint (" can't find target ");
	dprint (self.target);
	dprint (" at ");
	dprint (vtos(self.origin));
	dprint ("\n");
};


/*
================
monster_use

Using a monster makes it angry at the current activator
================
*/
void() coop_monster_use =
{
	if (self.enemy)
		return;
	if (self.health <= 0)
		return;
	if (activator.items & #IT_INVISIBILITY)
		return;
	if (activator.flags & #FL_NOTARGET)
		return;
	if (activator.classname != "player")
		return;
	
// delay reaction so if the monster is teleported, its sound is still
// heard
	self.enemy = activator;
	self.nextthink = time + 0.1;
	self.think = FoundTarget;
};

/*
================
monster_death_use

When a monster dies, it fires all of its targets with the current
enemy as activator.
================
*/
void() coop_monster_death_use =
{
// fall to ground
	if (self.flags & #FL_FLY)
		self.flags = self.flags - #FL_FLY;
	if (self.flags & #FL_SWIM)
		self.flags = self.flags - #FL_SWIM;

	if (!self.target)
		return;

	activator = self.enemy;
	SUB_UseTargets ();
};


//============================================================================

void() coop_walkmonster_start_go =
{
	self.origin_z = self.origin_z + 1;	// raise off floor a bit
	droptofloor();
	
	if (!walkmove(0,0))
	{
		dprint ("walkmonster in wall at: ");
		dprint (vtos(self.origin));
		dprint ("\n");
	}

	// test! Used to remove all monster but the one we're testing
//	if (self.classname != "idmonster_hell_knight") {
//		remove (self);
//		return;
//	} else
//		bprint (#PRINT_HIGH, "single monster spawned\n");
	
	self.takedamage = #DAMAGE_AIM;

	self.ideal_yaw = self.angles * '0 1 0';
	if (!self.yaw_speed)
		self.yaw_speed = 20;
	self.view_ofs = '0 0 25';
	self.use = coop_monster_use;
	
	self.flags = self.flags | #FL_MONSTER;
	
	if (self.target)
	{
		self.goalentity = self.movetarget = find(world, targetname, self.target);
		self.ideal_yaw = vectoyaw(self.goalentity.origin - self.origin);
		if (!self.movetarget)
		{
			coop_debugtargetprint ();
		}
// this used to be an objerror
		if (self.movetarget.classname == "path_corner")
			self.th_walk ();
		else
			self.pausetime = 99999999;
			self.th_stand ();
	}
	else
	{
		self.pausetime = 99999999;
		self.th_stand ();
	}

// spread think times so they don't all happen at same time
	self.nextthink = self.nextthink + random()*0.5;
};


void() coop_walkmonster_start =
{
	if (CheckExistence() == #FALSE) {
		remove(self);
		return;
	}

	self.#npc_originalloc = self.origin;

// delay drop to floor to make sure all doors have been spawned
// spread think times so they don't all happen at same time
	self.nextthink = self.nextthink + random()*0.5;
	self.think = coop_walkmonster_start_go;

	// make up for monster respawns on total monsters
	total_monsters = total_monsters + (self.lives + 1);
};



void() coop_flymonster_start_go =
{
	self.takedamage = #DAMAGE_AIM;

	self.ideal_yaw = self.angles * '0 1 0';
	if (!self.yaw_speed)
		self.yaw_speed = 10;
	self.view_ofs = '0 0 25';
	self.use = coop_monster_use;

	self.flags = self.flags | #FL_FLY;
	self.flags = self.flags | #FL_MONSTER;

	if (!walkmove(0,0))
	{
		dprint ("flymonster in wall at: ");
		dprint (vtos(self.origin));
		dprint ("\n");
	}

	if (self.target)
	{
		self.goalentity = self.movetarget = find(world, targetname, self.target);
		if (!self.movetarget)
		{
			coop_debugtargetprint ();
		}
// this used to be an objerror
		if (self.movetarget.classname == "path_corner")
			self.th_walk ();
		else
			self.pausetime = 99999999;
			self.th_stand ();
	}
	else
	{
		self.pausetime = 99999999;
		self.th_stand ();
	}
};

void() coop_flymonster_start =
{
	if (CheckExistence() == #FALSE) {
		remove(self);
		return;
	}

	self.#npc_originalloc = self.origin;

// spread think times so they don't all happen at same time
	self.nextthink = self.nextthink + random()*0.5;
	self.think = coop_flymonster_start_go;

	// make up for monster respawns on total monsters
	total_monsters = total_monsters + (self.lives + 1);
};


void() coop_swimmonster_start_go =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}

	self.takedamage = #DAMAGE_AIM;
	total_monsters = total_monsters + 1;

	self.ideal_yaw = self.angles * '0 1 0';
	if (!self.yaw_speed)
		self.yaw_speed = 10;
	self.view_ofs = '0 0 10';
	self.use = coop_monster_use;
	
	self.flags = self.flags | #FL_SWIM;
	self.flags = self.flags | #FL_MONSTER;

	if (self.target)
	{
		self.goalentity = self.movetarget = find(world, targetname, self.target);
		if (!self.movetarget)
		{
			coop_debugtargetprint ();
		}
// this used to be an objerror
		self.ideal_yaw = vectoyaw(self.goalentity.origin - self.origin);
		self.th_walk ();
	}
	else
	{
		self.pausetime = 99999999;
		self.th_stand ();
	}

// spread think times so they don't all happen at same time
	self.nextthink = self.nextthink + random()*0.5;
};

void() coop_swimmonster_start =
{
	if (CheckExistence() == #FALSE) {
		remove(self);
		return;
	}

	self.#npc_originalloc = self.origin;

// spread think times so they don't all happen at same time
	self.nextthink = self.nextthink + random()*0.5;
	self.think = coop_swimmonster_start_go;
	//total_monsters = total_monsters + 1;

	// make up for monster respawns on total monsters
	total_monsters = total_monsters + (self.lives + 1);
};

#endif
