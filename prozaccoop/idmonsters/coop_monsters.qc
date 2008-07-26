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

/*
================
COOP_FindMonsterPath

This is a hack to allow monsters to have a path AND targets
it fires at death. Only call this if self.target is set.
================
*/
void() COOP_FindMonsterPath = {
	local entity	te;

	self.goalentity = self.movetarget = te = find( world, targetname, self.target );
	while ( te ) {
		if ( te.classname == "path_corner" ) {
			self.goalentity = self.movetarget = te;
			return;
		}

		te = find( te, targetname, self.target );
	}

	// if none are any path_corners, then goalentity and movetarget contain the first
	// target found, if any, like the standard behavior
};

void() coop_walkmonster_start_go =
{
	self.#npc_isCoopMonster = #TRUE;

	self.origin_z = self.origin_z + 1;	// raise off floor a bit
	droptofloor();

	// save original spawn angles
	self.#npc_originalAngles = self.angles;

	if (!walkmove(0,0))
	{
		dprint( "walkmonster " );
		dprint( self.classname );
		dprint( " in wall at: " );
		dprint( vtos( self.origin ) );
		dprint( "\n" );
	}

	self.takedamage = #DAMAGE_AIM;

	self.ideal_yaw = self.angles * '0 1 0';
	if (!self.yaw_speed)
		self.yaw_speed = 20;
	self.view_ofs = '0 0 25';
	self.use = coop_monster_use;
	
	self.flags = self.flags | #FL_MONSTER;
	
	if (self.target)
	{
		COOP_FindMonsterPath();
		self.ideal_yaw = vectoyaw(self.goalentity.origin - self.origin);
		if (!self.movetarget)
		{
			coop_debugtargetprint ();
		}
// this used to be an objerror
		if (self.movetarget.classname == "path_corner")
			self.th_walk ();
		else {
			self.pausetime = 99999999;
			self.th_stand ();
		}
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
	if (!server_spawned) {
		self.#npc_useTargetsOnRespawn = #TRUE;

		if ( !( self.spawnflags & #SPAWN_DONTCOUNT ) )
		if ( number_of_teams > 1 || !Teammate( self.team_no, 1 ) )		// don't count friendly monsters
			total_monsters = total_monsters + (self.lives + 1);
	}
};



void() coop_flymonster_start_go =
{
	self.#npc_isCoopMonster = #TRUE;

	// save original spawn angles
	self.#npc_originalAngles = self.angles;

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
		dprint( "flymonster " );
		dprint( self.classname );
		dprint( " in wall at: " );
		dprint( vtos( self.origin ) );
		dprint( "\n" );
	}

	if (self.target)
	{
		COOP_FindMonsterPath();
		if (!self.movetarget)
		{
			coop_debugtargetprint ();
		}
// this used to be an objerror
		if (self.movetarget.classname == "path_corner")
			self.th_walk ();
		else {
			self.pausetime = 99999999;
			self.th_stand ();
		}
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
	if (!server_spawned) {
		self.#npc_useTargetsOnRespawn = #TRUE;

		if ( !( self.spawnflags & #SPAWN_DONTCOUNT ) )
		if ( number_of_teams > 1 || !Teammate( self.team_no, 1 ) )		// don't count friendly monsters
			total_monsters = total_monsters + (self.lives + 1);
	}
};


void() coop_swimmonster_start_go =
{
	self.#npc_isCoopMonster = #TRUE;

	// save original spawn angles
	self.#npc_originalAngles = self.angles;

	self.takedamage = #DAMAGE_AIM;

	self.ideal_yaw = self.angles * '0 1 0';
	if (!self.yaw_speed)
		self.yaw_speed = 10;
	self.view_ofs = '0 0 10';
	self.use = coop_monster_use;
	
	self.flags = self.flags | #FL_SWIM;
	self.flags = self.flags | #FL_MONSTER;

	if (self.target)
	{
		COOP_FindMonsterPath();
		if (!self.movetarget)
		{
			coop_debugtargetprint ();
		}
// this used to be an objerror
		self.ideal_yaw = vectoyaw(self.goalentity.origin - self.origin);
		if (self.movetarget.classname == "path_corner")
			self.th_walk ();
		else {
			self.pausetime = 99999999;
			self.th_stand ();
		}
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

	// make up for monster respawns on total monsters
	if (!server_spawned) {
		self.#npc_useTargetsOnRespawn = #TRUE;

		if ( !( self.spawnflags & #SPAWN_DONTCOUNT ) )
		if ( number_of_teams > 1 || !Teammate( self.team_no, 1 ) )		// don't count friendly monsters
			total_monsters = total_monsters + (self.lives + 1);
	}
};


//============================================================================

/*
void() monster_spawner_spawn = {
	local entity e, oself;

	e = spawn();
	e.lives = 1;
	e.target = self.target;
	setorigin( e, self.origin );

	oself = self;
	self = e;

	if ( oself.netname == "monster_zombie" )
		monster_zombie();
	else if ( oself.netname == "monster_shambler" )
		monster_shambler();
	else if ( oself.netname == "monster_knight" )
		monster_knight();
	else if ( oself.netname == "monster_enforcer" )
		monster_enforcer();
	else if ( oself.netname == "monster_demon1" )
		monster_demon1();
	else if ( oself.netname == "monster_army" )
		monster_army();
	else if ( oself.netname == "monster_ogre" )
		monster_ogre();
	else if ( oself.netname == "monster_shalrath" )
		monster_shalrath();
	else if ( oself.netname == "monster_wizard" )
		monster_wizard();
	else if ( oself.netname == "monster_dog" )
		monster_dog();
	else if ( oself.netname == "monster_fish" )
		monster_fish();
	else if ( oself.netname == "monster_hell_knight" )
		monster_hell_knight();
	else if ( oself.netname == "monster_tarbaby" )
		monster_tarbaby();
	else {
		self = oself;
		objerror( "unknown monster classname in netname" );
	}

	self = oself;
};
*/

/*QUAKED monster_spawner (0 .5 .8) (-8 -8 -8) (8 8 8)
Spawns the specified monster when triggered if targetname is set, otherwise set wait and maximum monsters to be spawned at a time
*/
/*
void() monster_spawner = {
	local entity temp, oself;

	// first precache sounds and models
	temp = spawn();
	temp.netname = self.netname;

	oself = self;
	self = temp;

	if ( self.netname == "monster_zombie" )
		monster_zombie();
	else if ( self.netname == "monster_shambler" )
		monster_shambler();
	else if ( self.netname == "monster_knight" )
		monster_knight();
	else if ( self.netname == "monster_enforcer" )
		monster_enforcer();
	else if ( self.netname == "monster_demon1" )
		monster_demon1();
	else if ( self.netname == "monster_army" )
		monster_army();
	else if ( self.netname == "monster_ogre" )
		monster_ogre();
	else if ( self.netname == "monster_shalrath" )
		monster_shalrath();
	else if ( self.netname == "monster_wizard" )
		monster_wizard();
	else if ( self.netname == "monster_dog" )
		monster_dog();
	else if ( self.netname == "monster_fish" )
		monster_fish();
	else if ( self.netname == "monster_hell_knight" )
		monster_hell_knight();
	else if ( self.netname == "monster_tarbaby" )
		monster_tarbaby();
	else {
		self = oself;
		objerror( "unknown monster classname in netname" );
	}

	self = oself;
	remove( temp );

	// setup to be trigger
	if ( self.targetname ) {
		self.use = monster_spawner_spawn;
	}
};
*/

#endif
