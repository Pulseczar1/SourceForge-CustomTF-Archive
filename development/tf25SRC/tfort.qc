/*======================================================
	TFORT.QC			TeamFortress v2.5	

	(c) TeamFortress Software Pty Ltd 	29/2/97
========================================================
Class handling and other utility functions
======================================================*/
// Function Prototypes
void() RemoveFlare;
void() GrenadeExplode;
void() spike_touch;
void(entity p) bound_other_ammo;
void(entity Goal, entity Player, entity Item) DisplayItemStatus;

// Map Function Prototypes
void(entity Item, entity AP, float method) tfgoalitem_RemoveFromPlayer;

// Help Functions
void() TeamFortress_MOTD;

// Team Functions
float(float tno) TeamFortress_TeamGetColor;
void(float tno) TeamFortress_TeamSetColor;
float() TeamFortress_TeamPutPlayerInTeam;
float(float tno) TeamFortress_TeamGetScore;
float(float tno) TeamFortress_TeamGetIllegalClasses;

// Impulse Functions
void() TeamFortress_ChangeClass;
void() TeamFortress_DisplayLegalClasses;
void() TeamFortress_Inventory;
void() TeamFortress_ShowTF;
void() TeamFortress_PrimeGrenade;
void() TeamFortress_ThrowGrenade;
void() TeamFortress_DisplayDetectionItems;

// Player Class Handling Functions
float(float pc) IsLegalClass;
void() TeamFortress_SetHealth;
void() TeamFortress_SetEquipment;
void(entity p) TeamFortress_SetSpeed;
void(entity p) TeamFortress_SetSkin;
void(entity Viewer, float pc, float rpc) TeamFortress_PrintClassName;
void() TeamFortress_RemoveTimers;
void(float Suicided) TeamFortress_SetupRespawn;
void() TeamFortress_CheckClassStats;
float(entity Retriever, float AmmoType) TeamFortress_GetMaxAmmo;
float(entity Retriever, float WeaponType) TeamFortress_CanGetWeapon;
float(entity Retriever, entity Items) TeamFortress_AddBackpackItems;
void(entity Player, float Armorclass) TeamFortress_DescribeArmor;
#ifdef SPEECH
void(entity player) TeamFortress_SayClassName;
#endif

// AmmoBox Handling Functions
void () TeamFortress_AmmoboxTouch;
float (float tno) num_team_ammoboxes;
void(float tno) RemoveOldAmmobox;
void(float tno) increment_team_ammoboxes;
void(float tno) decrement_team_ammoboxes;

// Weapon Handling Functions
void() TeamFortress_ExplodePerson;
void() NormalGrenadeTouch;
void() NormalGrenadeExplode;
void() PlayerObserverMode;

// Utility Functions
void(string halias, float himpulse1, float himpulse2) TeamFortress_Alias;

// Cyclic Event Functions
void() TeamFortress_Regenerate;
void() TeamFortress_CheckforCheats;
void() TeamFortress_RegenerateCells;

//=========================================================================
// IMPULSE FUNCTIONS
//=========================================================================
// Uses a class dependant special skill
void() UseSpecialSkill =
{
	local vector src;

	self.impulse = 0;

	if (self.playerclass == #PC_SCOUT)
	{
		self.impulse = #TF_SCAN_30;
	}
	else if (self.playerclass == #PC_SNIPER)
	{
		self.impulse = #TF_AUTOZOOM;
	}
	else if (self.playerclass == #PC_SOLDIER)
	{
		self.impulse = #TF_RELOAD;
	}
	else if (self.playerclass == #PC_DEMOMAN)
	{
		self.impulse = #TF_PB_DETONATE;
	}
	else if (self.playerclass == #PC_MEDIC)
	{
		self.impulse = #TF_MEDIKIT;
	}
	else if (self.playerclass == #PC_HVYWEAP)
	{
		self.impulse = 7;
	}
	else if (self.playerclass == #PC_PYRO)
	{
		self.impulse = 6;
	}
	else if (self.playerclass == #PC_SPY)
	{
		self.impulse = #TF_SPY_SPY;
	}
	else if (self.playerclass == #PC_ENGINEER)
	{
		self.impulse = #TF_ENGINEER_BUILD;
	}
	else if (self.playerclass == #PC_UNDEFINED)
	{
		// CameraMan special locks onto an entity
		if (self.enemy == world)
		{
	 		src = self.origin + v_forward*10;
			src_z = self.absmin_z + self.size_z * 0.7;

			traceline (src, src + v_forward*2048, #FALSE, self);

			if (trace_ent != world && trace_ent.origin != world.origin)
			{
				sprint3(self, #PRINT_HIGH, "Locked onto ", trace_ent.classname, "\n");
				self.enemy = trace_ent;
				self.camdist = vlen(self.enemy.origin - self.origin); 
				self.camangle = self.origin - self.enemy.origin;
				self.camangle_z = 0 - self.camangle_z;
				self.camangle = vectoangles(self.camangle);
			}
		}
		else
		{
			sprint(self, #PRINT_HIGH, "Removed Lock\n");
			self.enemy = world;
		}
	}
};


//=========================================================================
// Player change class function
// If self.impulse == 1, change to Civilian class
void() TeamFortress_ChangeClass =
{
	local entity spot, te;
	local float tc;
	local string st;

	// Only change playerclass once - remove this if you want to change on the fly
	// In deathmatch 3, you can change classes after you die
	if (self.playerclass != #PC_UNDEFINED)
	{
		// In Deathmatch 3, you can change class after you die
		if (deathmatch != 3)
			return;

		// Civilian Teams can never change class
		if (TeamFortress_TeamIsCivilian(self.team_no))
		{
			sprint(self, #PRINT_HIGH, "You cannot change class.\n");

			return;			
		}

		if (!IsLegalClass(self.impulse - #TF_CHANGEPC))
		{
			sprint(self, #PRINT_HIGH, "Your team cannot play that class.\n");

			TeamFortress_DisplayLegalClasses();
			return;
		}

		// Spy may be disabled
		if ((spy_off == #TRUE) && ((self.impulse - #TF_CHANGEPC) == #PC_SPY))
		{
			sprint(self, #PRINT_HIGH, "The spy class has been disabled on the server by the administrator.\n");
			return;
		}

		self.nextpc = self.impulse - #TF_CHANGEPC;

		sprint(self, #PRINT_HIGH, "After dying, you will return as a ");

		TeamFortress_PrintClassName(self,self.nextpc,(self.tfstate & #TFSTATE_RANDOMPC));

		// Prevent the cheatchecking mechanism from nabbing them b4 they change
		self.immune_to_check = time + 10;

		return;
	}

	// players must join a team, if teamplay is on
	if (teamplay && self.team_no == 0) 
	{
		// check for auto team placement
		if (toggleflags & #TFLAG_AUTOTEAM)
		{
			// If it failed, return
			if (TeamFortress_TeamPutPlayerInTeam() == #FALSE)
				return;
		}
		else
		{
			sprint(self, #PRINT_HIGH, "You must join a team first. \n");
			sprint(self, #PRINT_HIGH, "use imin1, imin2, imin3, or imin4\n");
			return;
		}
	}

	// Only change if you've got any lives left
	if ( self.lives == 0 )
	{
		sprint(self, #PRINT_HIGH, "You have no lives left.\n");

		return;
	}

	if (!IsLegalClass(self.impulse - #TF_CHANGEPC) && (self.impulse != 1))
	{
		sprint(self, #PRINT_HIGH, "You cannot play that playerclass on this map. \n");

		TeamFortress_DisplayLegalClasses();
		return;
	}

	// Spy may be disabled
	if ((spy_off == #TRUE) && ((self.impulse - #TF_CHANGEPC) == #PC_SPY))
	{
		sprint(self, #PRINT_HIGH, "The spy class has been disabled on the server by the administrator.\n");
		return;
	}

	if (self.impulse != 1)
		self.playerclass = self.impulse - #TF_CHANGEPC;
	else
		self.playerclass = #PC_CIVILIAN;

	self.nextpc = 0;

	// Turn off #PC_UNDEFINED's nomove and invincibility
	self.takedamage = #DAMAGE_AIM;
	self.movetype = #MOVETYPE_WALK;
	self.flags = #FL_CLIENT | #FL_ONGROUND;
	self.waterlevel = 0;
	self.air_finished = time + 12;

	// give them a model, and a new spawn point
	self.solid = #SOLID_SLIDEBOX;
	// pausetime is set by teleporters to keep the player from moving a while
	self.pausetime = 0;
	
	spot = SelectSpawnPoint ();

#ifdef MAP_DEBUG
	dprint(self.netname);
	dprint(" spawned at a ");
	dprint(spot.netname);
	if (spot.team_no != 0)
	{
		dprint(", team_no of ");
		st = ftos(spot.team_no);
		dprint(st);
	}
	dprint("\n");
#endif

	self.origin = spot.origin + '0 0 1';
	self.angles = spot.angles;
	self.fixangle = #TRUE;		// turn this way immediately

	setmodel (self, string_null);
	modelindex_null = self.modelindex;

	setmodel (self, "progs/eyes.mdl");
	modelindex_eyes = self.modelindex;

	setmodel (self, "progs/player.mdl");
	modelindex_player = self.modelindex;
	
	setsize (self, #VEC_HULL_MIN, #VEC_HULL_MAX);	
#ifdef QUAKE_WORLD
	if (self.playerclass == #PC_SCOUT)
		setsize (self, '-8 -8 -24', '8 8 32');	
#endif

	self.view_ofs = '0 0 22';
	player_stand1 ();
	if (deathmatch || coop)
	{
		makevectors(self.angles);
		spawn_tfog (self.origin + v_forward*20);
	}

	// Display chosen class
	if ( self.playerclass == #PC_RANDOM )
	{
		sprint(self, #PRINT_HIGH, "Random Playerclass.\n");

		self.tfstate = (self.tfstate | #TFSTATE_RANDOMPC);
		self.playerclass = 1 + floor(random() * (#PC_RANDOM - 1));
	}

	// If this is a TeamSpawnpoint, check to see if it
	// gives out a GoalItem, or displays a message
	if (spot.classname == "info_player_teamspawn")
	{
		if (spot.items != 0)
		{
			te = Finditem(spot.items);
			if (te)
				tfgoalitem_GiveToPlayer(te, self, self);

			if (!(spot.goal_activation & #TFSP_MULTIPLEITEMS))
				spot.items = 0;
		}

		if (spot.message)
		{
			CenterPrint(self, spot.message);

			if (!(spot.goal_activation & #TFSP_MULTIPLEMSGS))
				spot.message = string_null;
		}

		// TeamSpawn points can remove themselves after being spawned on
		if (spot.goal_effects == #TFSP_REMOVESELF)
		{
			spot.classname = "deadpoint";
			spot.team_str_home = string_null;
			spot.nextthink = time + 1;
			spot.think = SUB_Remove;
		}
	}

	// Tell the rest of the team
	spot = find(world, classname, "player");
	while (spot)
	{
		if ((spot.team_no == self.team_no) && (spot != self))
		{
			sprint(spot, #PRINT_HIGH, self.netname);
			sprint(spot, #PRINT_HIGH, " is playing as a ");

			TeamFortress_PrintClassName(spot,self.playerclass, (self.tfstate & #TFSTATE_RANDOMPC));
		}
		spot = find(spot, classname, "player");
	}

	TeamFortress_PrintClassName(self,self.playerclass, (self.tfstate & #TFSTATE_RANDOMPC));
#ifdef SPEECH
	TeamFortress_SayClassName(self);
#endif
	TeamFortress_SetEquipment();
	TeamFortress_SetHealth();
	TeamFortress_SetSpeed(self);
	TeamFortress_SetSkin(self);
};

//=========================================================================
// Display a list of all the legal classes for this map
void() TeamFortress_DisplayLegalClasses =
{
	local float gotone, ill;

	sprint(self, #PRINT_HIGH, "Legal Classes for your team are:\n");
	gotone = #FALSE;

	ill = TeamFortress_TeamGetIllegalClasses(self.team_no);

	if (!(illegalclasses & #TF_ILL_SCOUT) && !(ill & #TF_ILL_SCOUT))
	{
		if (gotone)
			sprint(self, #PRINT_HIGH, ", ");
		gotone = #TRUE;
		sprint(self, #PRINT_HIGH, "Scout");
	}
	if (!(illegalclasses & #TF_ILL_SNIPER) && !(ill & #TF_ILL_SNIPER))
	{
		if (gotone)
			sprint(self, #PRINT_HIGH, ", ");
		gotone = #TRUE;
		sprint(self, #PRINT_HIGH, "Sniper");
	}
	if (!(illegalclasses & #TF_ILL_SOLDIER) && !(ill & #TF_ILL_SOLDIER))
	{
		if (gotone)
			sprint(self, #PRINT_HIGH, ", ");
		gotone = #TRUE;
		sprint(self, #PRINT_HIGH, "Soldier");
	}
	if (!(illegalclasses & #TF_ILL_DEMOMAN) && !(ill & #TF_ILL_DEMOMAN))
	{
		if (gotone)
			sprint(self, #PRINT_HIGH, ", ");
		gotone = #TRUE;
		sprint(self, #PRINT_HIGH, "Demolitions Man");
	}
	if (!(illegalclasses & #TF_ILL_MEDIC) && !(ill & #TF_ILL_MEDIC))
	{
		if (gotone)
			sprint(self, #PRINT_HIGH, ", ");
		gotone = #TRUE;
		sprint(self, #PRINT_HIGH, "Combat Medic");
	}
	if (!(illegalclasses & #TF_ILL_HVYWEP) && !(ill & #TF_ILL_HVYWEP))
	{
		if (gotone)
			sprint(self, #PRINT_HIGH, ", ");
		gotone = #TRUE;
		sprint(self, #PRINT_HIGH, "Heavy Weapons Guy");
	}
	if (!(illegalclasses & #TF_ILL_PYRO) && !(ill & #TF_ILL_PYRO))
	{
		if (gotone)
			sprint(self, #PRINT_HIGH, ", ");
		gotone = #TRUE;
		sprint(self, #PRINT_HIGH, "Pyro");
	}
	if (!(illegalclasses & #TF_ILL_SPY) && !(ill & #TF_ILL_SPY))
	{
		if (gotone)
			sprint(self, #PRINT_HIGH, ", ");
		gotone = #TRUE;
		sprint(self, #PRINT_HIGH, "Spy");
	}
	if (!(illegalclasses & #TF_ILL_ENGINEER) && !(ill & #TF_ILL_ENGINEER))
	{
		if (gotone)
			sprint(self, #PRINT_HIGH, ", ");
		gotone = #TRUE;
		sprint(self, #PRINT_HIGH, "Engineer");
	}
	if (!(illegalclasses & #TF_ILL_RANDOMPC) && !(ill & #TF_ILL_RANDOMPC))
	{
		if (gotone)
			sprint(self, #PRINT_HIGH, ", ");
		gotone = #TRUE;
		sprint(self, #PRINT_HIGH, "RandomPC");
	}

	sprint(self, #PRINT_HIGH, "\n");
};

//=========================================================================
// Displays the player's inventory
void() TeamFortress_Inventory =
{
	local entity tg;
	local string ac;
	local float col;

	// Display Team
	col = TeamFortress_TeamGetColor(self.team_no);

	sprint(self, #PRINT_HIGH, "You're in team ");
	ac = ftos(self.team_no);
	sprint(self, #PRINT_HIGH, ac);
	sprint(self, #PRINT_HIGH, ", color ");
	ac = ftos(col);
	sprint(self, #PRINT_HIGH, ac);
	sprint(self, #PRINT_HIGH, ".\n");

	// Display Lives, if applicable
	if (self.lives != -1)
	{
		ac = ftos(self.lives);

		sprint(self, #PRINT_HIGH, "You've got ");
		sprint(self, #PRINT_HIGH, ac);
		if (self.lives == 1)
			sprint(self, #PRINT_HIGH, " life.\n");
		else 
			sprint(self, #PRINT_HIGH, " lives.\n");

	}

	// Display Number of Grenades of each type
	if (self.no_grenades_1 > 0)
	{
		sprint(self, #PRINT_HIGH, "Gren.Type 1 : ");
		if (self.tp_grenades_1 == #GR_TYPE_NORMAL)
			sprint(self, #PRINT_HIGH, " Normal(");
		else if (self.tp_grenades_1 == #GR_TYPE_CONCUSSION)
			sprint(self, #PRINT_HIGH, " Concussion(");
		else if (self.tp_grenades_1 == #GR_TYPE_NAIL)
			sprint(self, #PRINT_HIGH, " Nail(");
		else if (self.tp_grenades_1 == #GR_TYPE_MIRV)
			sprint(self, #PRINT_HIGH, " Mirv(");
		else if (self.tp_grenades_1 == #GR_TYPE_NAPALM)
			sprint(self, #PRINT_HIGH, " Napalm(");
		else if (self.tp_grenades_1 == #GR_TYPE_FLARE)
			sprint(self, #PRINT_HIGH, " Flare(");
		else if (self.tp_grenades_1 == #GR_TYPE_GAS)
			sprint(self, #PRINT_HIGH, " Hallucinogenic(");
		else if (self.tp_grenades_1 == #GR_TYPE_EMP)
			sprint(self, #PRINT_HIGH, " EMP(");
		else if (self.tp_grenades_1 == #GR_TYPE_FLASH)
			sprint(self, #PRINT_HIGH, " Flash(");
		else 
			sprint(self, #PRINT_HIGH, "BUG(");

		ac = ftos(self.no_grenades_1);
		sprint(self, #PRINT_HIGH, ac);
		sprint(self, #PRINT_HIGH, ")\n");
	}
	if (self.no_grenades_2 > 0)
	{
		sprint(self, #PRINT_HIGH, "Gren.Type 2 : ");
		if (self.tp_grenades_2 == #GR_TYPE_NORMAL)
			sprint(self, #PRINT_HIGH, " Normal(");
		else if (self.tp_grenades_2 == #GR_TYPE_CONCUSSION)
			sprint(self, #PRINT_HIGH, " Concussion(");
		else if (self.tp_grenades_2 == #GR_TYPE_NAIL)
			sprint(self, #PRINT_HIGH, " Nail(");
		else if (self.tp_grenades_2 == #GR_TYPE_MIRV)
			sprint(self, #PRINT_HIGH, " Mirv(");
		else if (self.tp_grenades_2 == #GR_TYPE_NAPALM)
			sprint(self, #PRINT_HIGH, " Napalm(");
		else if (self.tp_grenades_2 == #GR_TYPE_FLARE)
			sprint(self, #PRINT_HIGH, " Flare(");
		else if (self.tp_grenades_2 == #GR_TYPE_GAS)
			sprint(self, #PRINT_HIGH, " Hallucinogenic(");
		else if (self.tp_grenades_2 == #GR_TYPE_EMP)
			sprint(self, #PRINT_HIGH, " EMP(");
		else if (self.tp_grenades_2 == #GR_TYPE_FLASH)
			sprint(self, #PRINT_HIGH, " Flash(");
		else 
			sprint(self, #PRINT_HIGH, "BUG(");

		ac = ftos(self.no_grenades_2);
		sprint(self, #PRINT_HIGH, ac);
		sprint(self, #PRINT_HIGH, ")\n");
	}


	// Scanner
	if (self.tf_items & #NIT_SCANNER)
		sprint(self, #PRINT_HIGH, "Scanner. ");

	// Medikit and ammo
	if (self.weapons_carried & #WEAP_MEDIKIT)
	{
		sprint(self, #PRINT_HIGH, "Medikit (");
		ac = ftos(self.ammo_medikit);
		sprint(self, #PRINT_HIGH, ac);
		sprint(self, #PRINT_HIGH, ") ");
	}

	// Detpack
	if (self.weapons_carried & #WEAP_DETPACK)
	{
		if (self.ammo_detpack > 0)
		{
			ac = ftos(self.ammo_detpack);

			sprint(self, #PRINT_HIGH, ac);
			sprint(self, #PRINT_HIGH, " Detpack");
			if (self.ammo_detpack > 1)
				sprint(self, #PRINT_HIGH, "s");
			sprint(self, #PRINT_HIGH, ". ");
		}
	}

	// GoalItems
	tg = find (world, classname, "item_tfgoal");
	while (tg)
	{
		if (tg.owner == self)
		{
			sprint(self, #PRINT_HIGH, tg.netname);
			sprint(self, #PRINT_HIGH, ". ");
		}

		tg = find(tg, classname, "item_tfgoal");
	}

	// Armor
	if (self.armorvalue > 0)
	{
		TeamFortress_DescribeArmor(self, self.armorclass);
	}

if (!invis_only)
{
	// Spy gets told what skin and color he/she is wearing
	if (self.playerclass == #PC_SPY && invis_only == #FALSE)
	{
		sprint (self, #PRINT_HIGH, "Skin : ");
		if (self.undercover_skin != 0)
			TeamFortress_PrintClassName(self,self.undercover_skin,0);
		else
			sprint (self, #PRINT_HIGH, "Spy\n");

		sprint (self, #PRINT_HIGH, "Colors : Team ");
		if (self.undercover_team != 0)
			ac = ftos(self.undercover_team);
		else
			ac = ftos(self.team_no);
		sprint (self, #PRINT_HIGH, ac);
	}
}

	sprint (self, #PRINT_HIGH, "\n");
};

//=========================================================================
// Displays the state of the ToggleFlags
void() TeamFortress_ShowTF =
{
	local string st;

	// Class Persistence between lvls On/Off
	if (toggleflags & #TFLAG_CLASS_PERSIST)
		sprint (self, #PRINT_HIGH, "Class Persistence On.\n");
	else
		sprint (self, #PRINT_HIGH, "Class Persistence Off.\n");

	// Cheat Checking On/Off
	if (toggleflags & #TFLAG_CHEATCHECK)
		sprint (self, #PRINT_HIGH, "Cheat Checking On.\n");
	else
		sprint (self, #PRINT_HIGH, "Cheat Checking Off.\n");

	// AutoTeam On/Off
	if (toggleflags & #TFLAG_AUTOTEAM)
		sprint (self, #PRINT_HIGH, "AutoTeam On.\n");
	else
		sprint (self, #PRINT_HIGH, "AutoTeam Off.\n");

	// RespawnDelay
	if (toggleflags & #TFLAG_RESPAWNDELAY)
		st = ftos(respawn_delay_time);
	else
		st = "No";
	sprint (self, #PRINT_HIGH, st);
	if (st != "No")
		sprint (self, #PRINT_HIGH, " second");
	sprint (self, #PRINT_HIGH, " Respawn Delay.\n");

	// TeamFrags On/Off
	if (toggleflags & #TFLAG_TEAMFRAGS)
		sprint (self, #PRINT_HIGH, "TeamFrags On.\n");
	else
		sprint (self, #PRINT_HIGH, "TeamFrags Off.\n");

	// Grapple hook
	if (allow_hook)
		sprint (self, #PRINT_HIGH, "Grapple On.\n");
	else
		sprint (self, #PRINT_HIGH, "Grapple Off.\n");

};

void() TeamFortress_GrenadePrimed;

//=========================================================================
// Primes a grenade of the type corresponding to the player's impulse
void() TeamFortress_PrimeGrenade =
{
	local float gtype;
	local string gs, ptime;
	local entity tGrenade;

	// If you've already primed a grenade, return
	if ((self.tfstate & #TFSTATE_GRENPRIMED) || (self.tfstate & #TFSTATE_GRENTHROWING))
	{
		return;
	}

	if (self.impulse == #TF_GRENADE_1)
	{
		gtype = self.tp_grenades_1;
		if (self.tp_grenades_1 == #GR_TYPE_CONCUSSION)
			gs = "Concussion grenade";
		else if (self.tp_grenades_1 == #GR_TYPE_NAIL)
			gs = "Nail grenade";
		else if (self.tp_grenades_1 == #GR_TYPE_MIRV)
			gs = "Mirv grenade";
		else if (self.tp_grenades_1 == #GR_TYPE_NAPALM)
			gs = "Napalm grenade";
		else if (self.tp_grenades_1 == #GR_TYPE_FLARE)
			gs = "Flare";
		else if (self.tp_grenades_1 == #GR_TYPE_GAS)
			gs = "Gas grenade";
		else if (self.tp_grenades_1 == #GR_TYPE_EMP)
			gs = "EMP grenade";
		else if (self.tp_grenades_1 == #GR_TYPE_FLASH)
			gs = "Flash grenade";
		else
			gs = "Grenade";

		if (self.no_grenades_1 > 0)
		{
			ptime = ftos( #GR_PRIMETIME );

			sprint(self, #PRINT_HIGH, gs);
			sprint(self, #PRINT_HIGH, " primed, ");
			sprint(self, #PRINT_HIGH, ptime);
			sprint(self, #PRINT_HIGH, " seconds...\n");

			self.no_grenades_1 = self.no_grenades_1 - 1;
		}
		else
		{
			sprint(self, #PRINT_HIGH, "No ");
			sprint(self, #PRINT_HIGH, gs);
			sprint(self, #PRINT_HIGH, "s left.\n");
			return;
		}
	}
	if (self.impulse == #TF_GRENADE_2)
	{
		gtype = self.tp_grenades_2;
		if (self.tp_grenades_2 == #GR_TYPE_CONCUSSION)
			gs = "Concussion grenade";
		else if (self.tp_grenades_2 == #GR_TYPE_NAIL)
			gs = "Nail grenade";
		else if (self.tp_grenades_2 == #GR_TYPE_MIRV)
			gs = "Mirv grenade";
		else if (self.tp_grenades_2 == #GR_TYPE_NAPALM)
			gs = "Napalm grenade";
		else if (self.tp_grenades_2 == #GR_TYPE_FLARE)
			gs = "Flare";
		else if (self.tp_grenades_2 == #GR_TYPE_GAS)
			gs = "Gas grenade";
		else if (self.tp_grenades_2 == #GR_TYPE_EMP)
			gs = "EMP grenade";
		else if (self.tp_grenades_2 == #GR_TYPE_FLASH)
			gs = "Flash grenade";
		else
			gs = "Grenade";

		if (self.no_grenades_2 > 0)
		{
			ptime = ftos( #GR_PRIMETIME );

			sprint(self, #PRINT_HIGH, gs);
			sprint(self, #PRINT_HIGH, " primed, ");
			sprint(self, #PRINT_HIGH, ptime);
			sprint(self, #PRINT_HIGH, " seconds...\n");

			self.no_grenades_2 = self.no_grenades_2 - 1;
		}
		else
		{
			sprint(self, #PRINT_HIGH, "No ");
			sprint(self, #PRINT_HIGH, gs);
			sprint(self, #PRINT_HIGH, "s left.\n");
			return;
		}
	}

	self.tfstate = (self.tfstate | #TFSTATE_GRENPRIMED);
	tGrenade = spawn();
	tGrenade.owner = self;
	tGrenade.weapon = gtype;
//	tGrenade.classname = "timer";
	tGrenade.nextthink = time + 0.8;
	tGrenade.heat = time + #GR_PRIMETIME + 0.8;
	tGrenade.think = TeamFortress_GrenadePrimed;
};

void() TeamFortress_GrenadePrimed =
{
	local entity user;
	local entity oldself;

	user = self.owner;

	if (!(user.tfstate & #TFSTATE_GRENTHROWING) && !user.deadflag)
	{
		self.nextthink = time + 0.1;

		if (!self.think)
			dremove(self);
		
		if (time > self.heat)
			TeamFortress_ExplodePerson();

		return;
	}

	if (!(user.tfstate & #TFSTATE_GRENPRIMED))
	{
		dprint("GrenadePrimed logic error\n");
	}

	user.tfstate = user.tfstate - (user.tfstate & #TFSTATE_GRENPRIMED);
	user.tfstate = user.tfstate - (user.tfstate & #TFSTATE_GRENTHROWING);

	sound (user, #CHAN_WEAPON, "weapons/grenade.wav", 1, #ATTN_NORM);
	KickPlayer(-1, user);
	newmis = spawn ();
	newmis.owner = user;
	newmis.movetype = #MOVETYPE_BOUNCE;
	newmis.solid = #SOLID_BBOX;
	newmis.classname = "grenade";
		
	// set grenade speed
	makevectors (user.v_angle);

	if (user.deadflag)
	{
		// if user is dead, throw grenade directly up
		newmis.velocity = '0 0 200';
	}
	else
	{
		if (user.v_angle_x)
		{
			newmis.velocity = v_forward*600 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
		}
		else
		{
			newmis.velocity = aim(user, 10000);
			newmis.velocity = newmis.velocity * 600;
			newmis.velocity_z = 200;
		}
	}

	newmis.angles = vectoangles(newmis.velocity);

	// set the grenade's thinktime to when the PRIMETIME runs out
	newmis.think = SUB_Null;
	newmis.nextthink = self.heat;

	// set the think and touches to the appropriate grenade type
	if (self.weapon == #GR_TYPE_NORMAL)
	{
		newmis.touch = NormalGrenadeTouch;
		newmis.think = NormalGrenadeExplode;
		newmis.skin = 0;
		newmis.avelocity = '300 300 300';
		setmodel (newmis, "progs/hgren2.mdl");

	}
	else if (self.weapon == #GR_TYPE_CONCUSSION)
	{
		newmis.touch = ConcussionGrenadeTouch;
		newmis.think = ConcussionGrenadeExplode;
		newmis.skin = 1;
		newmis.avelocity = '300 300 300';
		setmodel (newmis, "progs/hgren2.mdl");
	}
	else if (self.weapon == #GR_TYPE_NAIL)
	{
		newmis.touch = NailGrenadeTouch;
		newmis.think = NailGrenadeExplode;
		newmis.skin = 1;
		newmis.avelocity = '0 300 0';
		setmodel (newmis, "progs/biggren.mdl");
	}
	else if (self.weapon == #GR_TYPE_MIRV)
	{
		newmis.touch = MirvGrenadeTouch;
		newmis.think = MirvGrenadeExplode;
		newmis.skin = 0;
		newmis.avelocity = '0 300 0';
		setmodel (newmis, "progs/biggren.mdl");
	}
	else if (self.weapon == #GR_TYPE_NAPALM)
	{
		newmis.touch = NapalmGrenadeTouch;
		newmis.think = NapalmGrenadeExplode;
		newmis.skin = 2;
		newmis.avelocity = '0 300 0';
		setmodel (newmis, "progs/biggren.mdl");
	}
	else if (self.weapon == #GR_TYPE_FLARE)
	{
		newmis.touch = FlareGrenadeTouch;
		newmis.think = FlareGrenadeExplode;
		newmis.skin  = TF_FLARE_OFF;
		newmis.avelocity = '300 300 300';
		setmodel (newmis, "progs/flare.mdl");
	}
	else if (self.weapon == #GR_TYPE_GAS)
	{
		newmis.touch = GasGrenadeTouch;
		newmis.think = GasGrenadeExplode;
		newmis.skin = 3;
		newmis.avelocity = '300 300 300';
		setmodel (newmis, "progs/grenade2.mdl");
	}
	else if (self.weapon == #GR_TYPE_EMP)
	{
		newmis.touch = EMPGrenadeTouch;
		newmis.think = EMPGrenadeExplode;
		newmis.skin = 4;
		newmis.avelocity = '300 300 300';
		setmodel (newmis, "progs/grenade2.mdl");
	}
	else if (self.weapon == #GR_TYPE_FLASH)
	{
		newmis.touch = FlashGrenadeTouch;
		newmis.think = FlashGrenadeExplode;
		newmis.skin = 2;
		newmis.avelocity = '300 300 300';
		setmodel (newmis, "progs/hgren2.mdl");
	}

	setsize (newmis, '0 0 0', '0 0 0');		
	setorigin (newmis, user.origin);

	oldself = self;
	self = self.owner;

#ifdef DEMO_STUFF
	if (live_camera)
		CamProjectileLockOn();
#endif

	self = oldself;

	// Remove primed grenade object	
	dremove(self);
};

//=========================================================================
// Throws a currently primed grenade
void() TeamFortress_ThrowGrenade =
{
	// If no grenade is primed, return
	if (!(self.tfstate & #TFSTATE_GRENPRIMED))
		return;

	self.tfstate = self.tfstate | #TFSTATE_GRENTHROWING;
};

//=========================================================================
// PLAYER CLASS HANDLING FUNCTIONS
//=========================================================================
// Return #TRUE is this class is allowed on this map
float(float pc) IsLegalClass =
{
	local float bit;

	// Spy may be turned off
	if (spy_off == #TRUE && pc == #PC_SPY)
		return #FALSE;

	if (pc == #PC_SCOUT)
		bit = #TF_ILL_SCOUT;
	else if (pc == #PC_SNIPER)
		bit = #TF_ILL_SNIPER;
	else if (pc == #PC_SOLDIER)
		bit = #TF_ILL_SOLDIER;
	else if (pc == #PC_DEMOMAN)
		bit = #TF_ILL_DEMOMAN;
	else if (pc == #PC_MEDIC)
		bit = #TF_ILL_MEDIC;
	else if (pc == #PC_HVYWEAP)
		bit = #TF_ILL_HVYWEP;
	else if (pc == #PC_PYRO)
		bit = #TF_ILL_PYRO;
	else if (pc == #PC_SPY)
		bit = #TF_ILL_SPY;
	else if (pc == #PC_ENGINEER)
		bit = #TF_ILL_ENGINEER;
	else if (pc == #PC_RANDOM)
		bit = #TF_ILL_RANDOMPC;

	if ((illegalclasses & bit) || (TeamFortress_TeamGetIllegalClasses(self.team_no) & bit))
		return #FALSE;

	return #TRUE;
};

//=========================================================================
// Alter the player's Movement based on class
void(entity p) TeamFortress_SetSpeed =
{
	local string sp;
	local float tf;
	local entity te;

	stuffcmd(p,"cl_movespeedkey 1\n");
	// Check for any reason why they can't move at all
	if (p.tfstate & #TFSTATE_CANT_MOVE)
	{
		if (#STOP_MOUSE_MOVEMENT == #ON)
		{
			stuffcmd(p,"m_forward 0\n");
			stuffcmd(p,"m_side 0\n");
		}

		p.velocity = '0 0 0';
		stuffcmd(p,"cl_backspeed 0\n");
		stuffcmd(p,"cl_forwardspeed 0\n");
		stuffcmd(p,"cl_sidespeed 0\n");
		return;
	}
	else
	{
		if (#STOP_MOUSE_MOVEMENT == #ON)
		{
			stuffcmd(p,"m_forward 1\n");
			stuffcmd(p,"m_side 0.8\n");
		}
	}

	// First, get their max class speed
	if ( p.playerclass == #PC_SCOUT )
	{
		p.maxfbspeed = #PC_SCOUT_MAXSPEED;
		p.maxstrafespeed = #PC_SCOUT_MAXSTRAFESPEED;
	}
	else if ( p.playerclass == #PC_SNIPER )
	{
		p.maxfbspeed = #PC_SNIPER_MAXSPEED;
		p.maxstrafespeed = #PC_SNIPER_MAXSTRAFESPEED;
	}
	else if ( p.playerclass == #PC_SOLDIER )
	{
		p.maxfbspeed = #PC_SOLDIER_MAXSPEED;
		p.maxstrafespeed = #PC_SOLDIER_MAXSTRAFESPEED;
	}
	else if ( p.playerclass == #PC_DEMOMAN )
	{
		p.maxfbspeed = #PC_DEMOMAN_MAXSPEED;
		p.maxstrafespeed = #PC_DEMOMAN_MAXSTRAFESPEED;
	}
	else if ( p.playerclass == #PC_MEDIC )
	{
		p.maxfbspeed = #PC_MEDIC_MAXSPEED;
		p.maxstrafespeed = #PC_MEDIC_MAXSTRAFESPEED;
	}
	else if ( p.playerclass == #PC_HVYWEAP )
	{
		p.maxfbspeed = #PC_HVYWEAP_MAXSPEED;
		p.maxstrafespeed = #PC_HVYWEAP_MAXSTRAFESPEED;
	}
	else if ( p.playerclass == #PC_PYRO )
	{
		p.maxfbspeed = #PC_PYRO_MAXSPEED;
		p.maxstrafespeed = #PC_PYRO_MAXSTRAFESPEED;
	}
	else if ( p.playerclass == #PC_CIVILIAN )
	{
		p.maxfbspeed = #PC_CIVILIAN_MAXSPEED;
		p.maxstrafespeed = #PC_CIVILIAN_MAXSTRAFESPEED;
	}
	else if ( p.playerclass == #PC_SPY )
	{
		p.maxfbspeed = #PC_SPY_MAXSPEED;
		p.maxstrafespeed = #PC_SPY_MAXSTRAFESPEED;
	}
	else if ( p.playerclass == #PC_ENGINEER )
	{
		p.maxfbspeed = #PC_ENGINEER_MAXSPEED;
		p.maxstrafespeed = #PC_ENGINEER_MAXSTRAFESPEED;
	}
	else if ( p.playerclass == #PC_UNDEFINED )
	{
		p.maxfbspeed = 320;
		p.maxstrafespeed = 320;
		return;
	}

	// 2nd, see if any GoalItems are slowing them down
	tf = 0;
	te = find (world, classname, "item_tfgoal");
	while ((te != world) && (tf == 0))
	{
		if (te.owner == p)
		{
			if (te.goal_activation & #TFGI_SLOW)
			{
				tf = 1;
				p.maxfbspeed = p.maxfbspeed / 2;
				p.maxstrafespeed = p.maxstrafespeed / 2;
			}
		}
		te = find(te, classname, "item_tfgoal");
	}

	// 3rd, See if they're tranquilised
	if (p.tfstate & #TFSTATE_TRANQUILISED)
	{
		p.maxfbspeed = (p.maxfbspeed / 3) * 2;
		p.maxstrafespeed = (p.maxstrafespeed / 3) * 2;
	}

	// 4th, check for leg wounds
	if (p.leg_damage)
	{
		if (p.leg_damage > 6)
			p.leg_damage = 6;

		// reduce speed by 10% per leg wound
		p.maxfbspeed = (p.maxfbspeed * ((10 - p.leg_damage) / 10));
		p.maxstrafespeed = (p.maxstrafespeed * (10 - p.leg_damage) / 10);
	}

	// 5th, if they're a sniper, and they're aiming, their speed must be 60 or less
	if (p.tfstate & #TFSTATE_AIMING)
	{
		if (p.maxfbspeed > 60)
			p.maxfbspeed = 60;
		if (p.maxstrafespeed > 60)
			p.maxstrafespeed = 60;
	}

	sp = ftos(p.maxfbspeed);
	stuffcmd(p,"cl_backspeed ");
	stuffcmd(p,sp);
	stuffcmd(p,"\n");
	stuffcmd(p,"cl_forwardspeed ");
	stuffcmd(p,sp);
	stuffcmd(p,"\n");
	sp = ftos(p.maxstrafespeed);
	stuffcmd(p,"cl_sidespeed ");
	stuffcmd(p,sp);
	stuffcmd(p,"\n");
};

//=========================================================================
// Set the max_health of a player based on his/her class
void() TeamFortress_SetHealth = 
{
	if ( self.playerclass == #PC_SCOUT )
		self.max_health = #PC_SCOUT_MAXHEALTH;
	else if ( self.playerclass == #PC_SNIPER )
		self.max_health = #PC_SNIPER_MAXHEALTH;
	else if ( self.playerclass == #PC_SOLDIER )
		self.max_health = #PC_SOLDIER_MAXHEALTH;
	else if ( self.playerclass == #PC_DEMOMAN )
		self.max_health = #PC_DEMOMAN_MAXHEALTH;
	else if ( self.playerclass == #PC_MEDIC )
		self.max_health = #PC_MEDIC_MAXHEALTH;
	else if ( self.playerclass == #PC_HVYWEAP )
		self.max_health = #PC_HVYWEAP_MAXHEALTH;
	else if ( self.playerclass == #PC_PYRO )
		self.max_health = #PC_PYRO_MAXHEALTH;
	else if ( self.playerclass == #PC_CIVILIAN )
		self.max_health = #PC_CIVILIAN_MAXHEALTH;
	else if ( self.playerclass == #PC_SPY )
		self.max_health = #PC_SPY_MAXHEALTH;
	else if ( self.playerclass == #PC_ENGINEER )
		self.max_health = #PC_ENGINEER_MAXHEALTH;
	else if ( self.playerclass == #PC_UNDEFINED )
	{
		self.max_health = 1; 
		self.takedamage = 0; // Prevent damage to #PC_UNDEFINED players
	}

	self.health = self.max_health;
};

//=========================================================================
// Set the skin of a player based on his/her class, if Classkin is on
void(entity p) TeamFortress_SetSkin = 
{
	local string st;

	self.immune_to_check = time + 4;

	if (p.playerclass == #PC_SPY && p.undercover_skin != 0)
		p.skin = p.undercover_skin;
	else
		p.skin = p.playerclass;

#ifdef QUAKE_WORLD
	if (p.skin != #PC_UNDEFINED)
	{
		stuffcmd(p, "skin ");

		if ( p.team_no == 4)
		{
			if ( p.skin == #PC_SCOUT )
				stuffcmd(p, #TEAM4_SCOUT_SKIN);
			else if ( p.skin == #PC_SNIPER )
				stuffcmd(p, #TEAM4_SNIPER_SKIN);
			else if ( p.skin == #PC_SOLDIER )
				stuffcmd(p, #TEAM4_SOLDIER_SKIN);
			else if ( p.skin == #PC_DEMOMAN )
				stuffcmd(p, #TEAM4_DEMOMAN_SKIN);
			else if ( p.skin == #PC_MEDIC )
				stuffcmd(p, #TEAM4_MEDIC_SKIN);
			else if ( p.skin == #PC_HVYWEAP )
				stuffcmd(p, #TEAM4_HVYWEAP_SKIN);
			else if ( p.skin == #PC_PYRO )
				stuffcmd(p, #TEAM4_PYRO_SKIN);
			else if ( p.skin == #PC_SPY )
				stuffcmd(p, #TEAM4_SPY_SKIN);
			else if ( p.skin == #PC_ENGINEER )
				stuffcmd(p, #TEAM4_ENGINEER_SKIN);
		}
		else if ( p.team_no == 3)
		{
			if ( p.skin == #PC_SCOUT )
				stuffcmd(p, #TEAM3_SCOUT_SKIN);
			else if ( p.skin == #PC_SNIPER )
				stuffcmd(p, #TEAM3_SNIPER_SKIN);
			else if ( p.skin == #PC_SOLDIER )
				stuffcmd(p, #TEAM3_SOLDIER_SKIN);
			else if ( p.skin == #PC_DEMOMAN )
				stuffcmd(p, #TEAM3_DEMOMAN_SKIN);
			else if ( p.skin == #PC_MEDIC )
				stuffcmd(p, #TEAM3_MEDIC_SKIN);
			else if ( p.skin == #PC_HVYWEAP )
				stuffcmd(p, #TEAM3_HVYWEAP_SKIN);
			else if ( p.skin == #PC_PYRO )
				stuffcmd(p, #TEAM3_PYRO_SKIN);
			else if ( p.skin == #PC_SPY )
				stuffcmd(p, #TEAM3_SPY_SKIN);
			else if ( p.skin == #PC_ENGINEER )
				stuffcmd(p, #TEAM3_ENGINEER_SKIN);
		}
		else if ( p.team_no == 2)
		{
			if ( p.skin == #PC_SCOUT )
				stuffcmd(p, #TEAM2_SCOUT_SKIN);
			else if ( p.skin == #PC_SNIPER )
				stuffcmd(p, #TEAM2_SNIPER_SKIN);
			else if ( p.skin == #PC_SOLDIER )
				stuffcmd(p, #TEAM2_SOLDIER_SKIN);
			else if ( p.skin == #PC_DEMOMAN )
				stuffcmd(p, #TEAM2_DEMOMAN_SKIN);
			else if ( p.skin == #PC_MEDIC )
				stuffcmd(p, #TEAM2_MEDIC_SKIN);
			else if ( p.skin == #PC_HVYWEAP )
				stuffcmd(p, #TEAM2_HVYWEAP_SKIN);
			else if ( p.skin == #PC_PYRO )
				stuffcmd(p, #TEAM2_PYRO_SKIN);
			else if ( p.skin == #PC_SPY )
				stuffcmd(p, #TEAM2_SPY_SKIN);
			else if ( p.skin == #PC_ENGINEER )
				stuffcmd(p, #TEAM2_ENGINEER_SKIN);
		}
		else // if ( p.team_no == 1)
		{
			if ( p.skin == #PC_SCOUT )
				stuffcmd(p, #TEAM1_SCOUT_SKIN);
			else if ( p.skin == #PC_SNIPER )
				stuffcmd(p, #TEAM1_SNIPER_SKIN);
			else if ( p.skin == #PC_SOLDIER )
				stuffcmd(p, #TEAM1_SOLDIER_SKIN);
			else if ( p.skin == #PC_DEMOMAN )
				stuffcmd(p, #TEAM1_DEMOMAN_SKIN);
			else if ( p.skin == #PC_MEDIC )
				stuffcmd(p, #TEAM1_MEDIC_SKIN);
			else if ( p.skin == #PC_HVYWEAP )
				stuffcmd(p, #TEAM1_HVYWEAP_SKIN);
			else if ( p.skin == #PC_PYRO )
				stuffcmd(p, #TEAM1_PYRO_SKIN);
			else if ( p.skin == #PC_SPY )
				stuffcmd(p, #TEAM1_SPY_SKIN);
			else if ( p.skin == #PC_ENGINEER )
				stuffcmd(p, #TEAM1_ENGINEER_SKIN);
		}

		if ( p.skin == #PC_CIVILIAN )
			stuffcmd(p, "base\n"); // Need a civilian skin
	}
	else
	{
		stuffcmd(p, "skin base\n");
	}
#endif
};

//=========================================================================
// Set the details of a player based on his/her class
void() TeamFortress_SetEquipment =
{
	local entity te;
	local string st;
	local float kept_items;

	if (self.classname != "player")
		return;

	kept_items = self.tf_items & (#IT_KEY1 | #IT_KEY2);

	self.items = 0;
	self.current_weapon = 0;
	self.weapons_carried = 0;

	self.tf_items = 0;
	self.tf_items_flags = 0;
	self.armorclass = 0;
	self.impulse = 0;

	self.undercover_skin = 0;
	if (self.undercover_team != 0)
	{
		self.immune_to_check = time + 4;

		self.undercover_team = 0;
		// Set their color 
		stuffcmd(self, "color ");
		st = ftos(TeamFortress_TeamGetColor(self.team_no) - 1);
		stuffcmd(self, st);
		stuffcmd(self, "\n");
	}

	self.is_building = 0;
	self.is_detpacking = 0;
	self.is_undercover = 0;
	self.is_feigning = 0;
	self.is_unabletospy = 0;

	self.ammo_medikit = 0;
	self.maxammo_medikit = 0;
	self.ammo_detpack = 0;
	self.maxammo_detpack = 0;
	self.items_allowed = 0;
   	self.armor_allowed = 0;
   	self.maxarmor = 0;
	self.weaponmode = 0;
	self.respawn_time = 0;
	self.heat = 0;
	self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_RELOADING);

	if (self.team_no == 0)
		self.lives = -1;

	self.items = self.items | kept_items;

	// Start the Cheat-Checking Cyclic Event if CheatChecking Toggleflag is on
	if (toggleflags & #TFLAG_CHEATCHECK)
	{
		te = spawn();
		te.nextthink = time + 2;
		te.think = TeamFortress_CheckforCheats;
		te.owner = self;
		te.classname = "timer";
	}

	if ( self.playerclass == #PC_SCOUT )
	{
		self.weapons_carried = self.weapons_carried | #PC_SCOUT_WEAPONS;
		self.ammo_rockets = #PC_SCOUT_INITAMMO_ROCKET;
		self.ammo_nails = #PC_SCOUT_INITAMMO_NAIL;
		self.ammo_shells = #PC_SCOUT_INITAMMO_SHOT;
		self.ammo_cells = #PC_SCOUT_INITAMMO_CELL;
		self.maxammo_rockets = #PC_SCOUT_MAXAMMO_ROCKET;
		self.maxammo_nails = #PC_SCOUT_MAXAMMO_NAIL;
		self.maxammo_shells = #PC_SCOUT_MAXAMMO_SHOT;
		self.maxammo_cells = #PC_SCOUT_MAXAMMO_CELL;

		self.no_grenades_1 = #PC_SCOUT_GRENADE_INIT_1;
		self.no_grenades_2 = #PC_SCOUT_GRENADE_INIT_2;
		self.tp_grenades_1 = #PC_SCOUT_GRENADE_TYPE_1;
		self.tp_grenades_2 = #PC_SCOUT_GRENADE_TYPE_2;
		self.tf_items = #PC_SCOUT_TF_ITEMS;

		// the scanner defaults to enemy scanning ON, friendly scanning OFF
		// and movement scanner only OFF
		self.tf_items_flags = self.tf_items_flags | #NIT_SCANNER_ENEMY;

		self.armorclass = self.armorclass | #PC_SCOUT_INITARMORCLASS;
		self.armortype = #PC_SCOUT_INITARMORTYPE;
		self.armorvalue = #PC_SCOUT_INITARMOR;
	   	self.armor_allowed = #PC_SCOUT_MAXARMORTYPE;
	   	self.maxarmor = #PC_SCOUT_MAXARMOR;
		self.current_weapon = #WEAP_NAILGUN;

		self.items_allowed = #PC_SCOUT_WEAPONS;

		// set the weapon icons on the status bar
		self.items = self.items | #IT_SHOTGUN | #IT_NAILGUN;
	}
	else if ( self.playerclass == #PC_SNIPER )
	{
		self.weapons_carried = self.weapons_carried | #PC_SNIPER_WEAPONS;
		self.ammo_rockets = #PC_SNIPER_INITAMMO_ROCKET;
		self.ammo_nails = #PC_SNIPER_INITAMMO_NAIL;
		self.ammo_shells = #PC_SNIPER_INITAMMO_SHOT;
		self.ammo_cells = #PC_SNIPER_INITAMMO_CELL;
		self.maxammo_rockets = #PC_SNIPER_MAXAMMO_ROCKET;
		self.maxammo_nails = #PC_SNIPER_MAXAMMO_NAIL;
		self.maxammo_shells = #PC_SNIPER_MAXAMMO_SHOT;
		self.maxammo_cells = #PC_SNIPER_MAXAMMO_CELL;
	
		self.no_grenades_1 = #PC_SNIPER_GRENADE_INIT_1;
		self.no_grenades_2 = #PC_SNIPER_GRENADE_INIT_2;
		self.tp_grenades_1 = #PC_SNIPER_GRENADE_TYPE_1;
		self.tp_grenades_2 = #PC_SNIPER_GRENADE_TYPE_2;
		self.tf_items = #PC_SNIPER_TF_ITEMS;

		self.armorclass = self.armorclass | #PC_SNIPER_INITARMORCLASS;
		self.armortype = #PC_SNIPER_INITARMORTYPE;
		self.armorvalue = #PC_SNIPER_INITARMOR;
	   	self.armor_allowed = #PC_SNIPER_MAXARMORTYPE;
	   	self.maxarmor = #PC_SNIPER_MAXARMOR;
		self.current_weapon = #WEAP_SNIPER_RIFLE;

		self.items_allowed = #PC_SNIPER_WEAPONS;

		// set the weapon icons on the status bar
		self.items = self.items | #IT_SHOTGUN | #IT_SUPER_SHOTGUN | #IT_NAILGUN;
	}
	else if ( self.playerclass == #PC_SOLDIER )
	{
		self.weapons_carried = self.weapons_carried | #PC_SOLDIER_WEAPONS;
		self.ammo_rockets = #PC_SOLDIER_INITAMMO_ROCKET;
		self.ammo_nails = #PC_SOLDIER_INITAMMO_NAIL;
		self.ammo_shells = #PC_SOLDIER_INITAMMO_SHOT;
		self.ammo_cells = #PC_SOLDIER_INITAMMO_CELL;
		self.maxammo_rockets = #PC_SOLDIER_MAXAMMO_ROCKET;
		self.maxammo_nails = #PC_SOLDIER_MAXAMMO_NAIL;
		self.maxammo_shells = #PC_SOLDIER_MAXAMMO_SHOT;
		self.maxammo_cells = #PC_SOLDIER_MAXAMMO_CELL;
	
		self.no_grenades_1 = #PC_SOLDIER_GRENADE_INIT_1;
		self.no_grenades_2 = #PC_SOLDIER_GRENADE_INIT_2;
		self.tp_grenades_1 = #PC_SOLDIER_GRENADE_TYPE_1;
		self.tp_grenades_2 = #PC_SOLDIER_GRENADE_TYPE_2;
		self.tf_items = #PC_SOLDIER_TF_ITEMS;

		self.armorclass = self.armorclass | #PC_SOLDIER_INITARMORCLASS;
		self.armortype = #PC_SOLDIER_INITARMORTYPE;
		self.armorvalue = #PC_SOLDIER_INITARMOR;
	   	self.armor_allowed = #PC_SOLDIER_MAXARMORTYPE;
	   	self.maxarmor = #PC_SOLDIER_MAXARMOR;
		self.current_weapon = #WEAP_ROCKET_LAUNCHER;

		self.items_allowed = #PC_SOLDIER_WEAPONS;

		// set the weapon icons on the status bar
		self.items = self.items | #IT_SHOTGUN | #IT_SUPER_SHOTGUN | #IT_ROCKET_LAUNCHER;
	}
	else if ( self.playerclass == #PC_DEMOMAN )
	{
		self.weapons_carried = self.weapons_carried | #PC_DEMOMAN_WEAPONS;
		self.ammo_rockets = #PC_DEMOMAN_INITAMMO_ROCKET;
		self.ammo_nails = #PC_DEMOMAN_INITAMMO_NAIL;
		self.ammo_shells = #PC_DEMOMAN_INITAMMO_SHOT;
		self.ammo_cells = #PC_DEMOMAN_INITAMMO_CELL;
		self.maxammo_rockets = #PC_DEMOMAN_MAXAMMO_ROCKET;
		self.maxammo_nails = #PC_DEMOMAN_MAXAMMO_NAIL;
		self.maxammo_shells = #PC_DEMOMAN_MAXAMMO_SHOT;
		self.maxammo_cells = #PC_DEMOMAN_MAXAMMO_CELL;
	
		self.no_grenades_1 = #PC_DEMOMAN_GRENADE_INIT_1;
		self.no_grenades_2 = #PC_DEMOMAN_GRENADE_INIT_2;
		self.tp_grenades_1 = #PC_DEMOMAN_GRENADE_TYPE_1;
		self.tp_grenades_2 = #PC_DEMOMAN_GRENADE_TYPE_2;
		self.tf_items = #PC_DEMOMAN_TF_ITEMS;

		// Detpacks
		self.ammo_detpack = #PC_DEMOMAN_INITAMMO_DETPACK;
		self.maxammo_detpack = #PC_DEMOMAN_MAXAMMO_DETPACK;

		self.armorclass = self.armorclass | #PC_DEMOMAN_INITARMORCLASS;
		self.armortype = #PC_DEMOMAN_INITARMORTYPE;
		self.armorvalue = #PC_DEMOMAN_INITARMOR;
	   	self.armor_allowed = #PC_DEMOMAN_MAXARMORTYPE;
	   	self.maxarmor = #PC_DEMOMAN_MAXARMOR;
		self.current_weapon = #WEAP_GRENADE_LAUNCHER;

		self.items_allowed = #PC_DEMOMAN_WEAPONS;

		// set the weapon icons on the status bar
		self.items = self.items | #IT_SHOTGUN | #IT_GRENADE_LAUNCHER;
	}
	else if ( self.playerclass == #PC_MEDIC )
	{
		self.weapons_carried = self.weapons_carried | #PC_MEDIC_WEAPONS;
		self.ammo_rockets = #PC_MEDIC_INITAMMO_ROCKET;
		self.ammo_nails = #PC_MEDIC_INITAMMO_NAIL;
		self.ammo_shells = #PC_MEDIC_INITAMMO_SHOT;
		self.ammo_cells = #PC_MEDIC_INITAMMO_CELL;
		self.maxammo_rockets = #PC_MEDIC_MAXAMMO_ROCKET;
		self.maxammo_nails = #PC_MEDIC_MAXAMMO_NAIL;
		self.maxammo_shells = #PC_MEDIC_MAXAMMO_SHOT;
		self.maxammo_cells = #PC_MEDIC_MAXAMMO_CELL;
	
		self.no_grenades_1 = #PC_MEDIC_GRENADE_INIT_1;
		self.no_grenades_2 = #PC_MEDIC_GRENADE_INIT_2;
		self.tp_grenades_1 = #PC_MEDIC_GRENADE_TYPE_1;
		self.tp_grenades_2 = #PC_MEDIC_GRENADE_TYPE_2;
		self.tf_items = #PC_MEDIC_TF_ITEMS;

		self.armorclass = self.armorclass | #PC_MEDIC_INITARMORCLASS;
		self.armortype = #PC_MEDIC_INITARMORTYPE;
		self.armorvalue = #PC_MEDIC_INITARMOR;
	   	self.armor_allowed = #PC_MEDIC_MAXARMORTYPE;
	   	self.maxarmor = #PC_MEDIC_MAXARMOR;
		self.current_weapon = #WEAP_SUPER_NAILGUN;

		self.ammo_medikit = #PC_MEDIC_INITAMMO_MEDIKIT;
		self.maxammo_medikit = #PC_MEDIC_MAXAMMO_MEDIKIT;

		// Start the Regeneration Cyclic Event
		te = spawn();
		te.nextthink = time + #PC_MEDIC_REGEN_TIME;
		te.think = TeamFortress_Regenerate;
		te.owner = self;
		te.classname = "timer";

		self.items_allowed = #PC_MEDIC_WEAPONS;

		// set the weapon icons on the status bar
		self.items = self.items | #IT_SHOTGUN | #IT_SUPER_SHOTGUN | #IT_SUPER_NAILGUN;
	}
	else if ( self.playerclass == #PC_HVYWEAP )
	{
		self.weapons_carried = self.weapons_carried | #PC_HVYWEAP_WEAPONS;
		self.ammo_rockets = #PC_HVYWEAP_INITAMMO_ROCKET;
		self.ammo_nails = #PC_HVYWEAP_INITAMMO_NAIL;
		self.ammo_shells = #PC_HVYWEAP_INITAMMO_SHOT;
		self.ammo_cells = #PC_HVYWEAP_INITAMMO_CELL;
		self.maxammo_rockets = #PC_HVYWEAP_MAXAMMO_ROCKET;
		self.maxammo_nails = #PC_HVYWEAP_MAXAMMO_NAIL;
		self.maxammo_shells = #PC_HVYWEAP_MAXAMMO_SHOT;
		self.maxammo_cells = #PC_HVYWEAP_MAXAMMO_CELL;
	
		self.no_grenades_1 = #PC_HVYWEAP_GRENADE_INIT_1;
		self.no_grenades_2 = #PC_HVYWEAP_GRENADE_INIT_2;
		self.tp_grenades_1 = #PC_HVYWEAP_GRENADE_TYPE_1;
		self.tp_grenades_2 = #PC_HVYWEAP_GRENADE_TYPE_2;
		self.tf_items = #PC_HVYWEAP_TF_ITEMS;

		self.armorclass = self.armorclass | #PC_HVYWEAP_INITARMORCLASS;
		self.armortype = #PC_HVYWEAP_INITARMORTYPE;
		self.armorvalue = #PC_HVYWEAP_INITARMOR;
	   	self.armor_allowed = #PC_HVYWEAP_MAXARMORTYPE;
	   	self.maxarmor = #PC_HVYWEAP_MAXARMOR;
		self.current_weapon = #WEAP_SUPER_SHOTGUN;

		self.items_allowed = #PC_HVYWEAP_WEAPONS;

		// set the weapon icons on the status bar
		self.items = self.items | #IT_SHOTGUN | #IT_SUPER_SHOTGUN | #IT_ROCKET_LAUNCHER;
	}
	else if ( self.playerclass == #PC_PYRO )
	{
		self.weapons_carried = self.weapons_carried | #PC_PYRO_WEAPONS;
		self.ammo_rockets = #PC_PYRO_INITAMMO_ROCKET;
		self.ammo_nails = #PC_PYRO_INITAMMO_NAIL;
		self.ammo_shells = #PC_PYRO_INITAMMO_SHOT;
		self.ammo_cells = #PC_PYRO_INITAMMO_CELL;
		self.maxammo_rockets = #PC_PYRO_MAXAMMO_ROCKET;
		self.maxammo_nails = #PC_PYRO_MAXAMMO_NAIL;
		self.maxammo_shells = #PC_PYRO_MAXAMMO_SHOT;
		self.maxammo_cells = #PC_PYRO_MAXAMMO_CELL;
	
		self.no_grenades_1 = #PC_PYRO_GRENADE_INIT_1;
		self.no_grenades_2 = #PC_PYRO_GRENADE_INIT_2;
		self.tp_grenades_1 = #PC_PYRO_GRENADE_TYPE_1;
		self.tp_grenades_2 = #PC_PYRO_GRENADE_TYPE_2;
		self.tf_items = #PC_PYRO_TF_ITEMS;

		self.armorclass = self.armorclass | #PC_PYRO_INITARMORCLASS;
		self.armortype = #PC_PYRO_INITARMORTYPE;
		self.armorvalue = #PC_PYRO_INITARMOR;
	   	self.armor_allowed = #PC_PYRO_MAXARMORTYPE;
	   	self.maxarmor = #PC_PYRO_MAXARMOR;
		self.current_weapon = #WEAP_FLAMETHROWER;
		self.items_allowed = #PC_PYRO_WEAPONS;

		// set the weapon icons on the status bar
		self.items = self.items | #IT_SHOTGUN | #IT_GRENADE_LAUNCHER | #IT_ROCKET_LAUNCHER;
	}
	else if ( self.playerclass == #PC_CIVILIAN )
	{
		self.weapons_carried = self.weapons_carried | #PC_CIVILIAN_WEAPONS;
		self.ammo_rockets = #PC_CIVILIAN_INITAMMO_ROCKET;
		self.ammo_nails = #PC_CIVILIAN_INITAMMO_NAIL;
		self.ammo_shells = #PC_CIVILIAN_INITAMMO_SHOT;
		self.ammo_cells = #PC_CIVILIAN_INITAMMO_CELL;
		self.maxammo_rockets = #PC_CIVILIAN_MAXAMMO_ROCKET;
		self.maxammo_nails = #PC_CIVILIAN_MAXAMMO_NAIL;
		self.maxammo_shells = #PC_CIVILIAN_MAXAMMO_SHOT;
		self.maxammo_cells = #PC_CIVILIAN_MAXAMMO_CELL;
	
		self.no_grenades_1 = #PC_CIVILIAN_GRENADE_INIT_1;
		self.no_grenades_2 = #PC_CIVILIAN_GRENADE_INIT_2;
		self.tp_grenades_1 = #PC_CIVILIAN_GRENADE_TYPE_1;
		self.tp_grenades_2 = #PC_CIVILIAN_GRENADE_TYPE_2;
		self.tf_items = #PC_CIVILIAN_TF_ITEMS;

		self.armorclass = self.armorclass | #PC_CIVILIAN_INITARMORCLASS;
		self.armortype = #PC_CIVILIAN_INITARMORTYPE;
		self.armorvalue = #PC_CIVILIAN_INITARMOR;
	   	self.armor_allowed = #PC_CIVILIAN_MAXARMORTYPE;
	   	self.maxarmor = #PC_CIVILIAN_MAXARMOR;
		self.current_weapon = #WEAP_AXE;
		self.items_allowed = #PC_CIVILIAN_WEAPONS;

		// set the weapon icons on the status bar
		self.items = 0;
	}
	else if ( self.playerclass == #PC_SPY )
	{
		self.weapons_carried = self.weapons_carried | #PC_SPY_WEAPONS;
		self.ammo_rockets = #PC_SPY_INITAMMO_ROCKET;
		self.ammo_nails = #PC_SPY_INITAMMO_NAIL;
		self.ammo_shells = #PC_SPY_INITAMMO_SHOT;
		self.ammo_cells = #PC_SPY_INITAMMO_CELL;
		self.maxammo_rockets = #PC_SPY_MAXAMMO_ROCKET;
		self.maxammo_nails = #PC_SPY_MAXAMMO_NAIL;
		self.maxammo_shells = #PC_SPY_MAXAMMO_SHOT;
		self.maxammo_cells = #PC_SPY_MAXAMMO_CELL;
	
		self.no_grenades_1 = #PC_SPY_GRENADE_INIT_1;
		self.no_grenades_2 = #PC_SPY_GRENADE_INIT_2;
		self.tp_grenades_1 = #PC_SPY_GRENADE_TYPE_1;
		self.tp_grenades_2 = #PC_SPY_GRENADE_TYPE_2;
		self.tf_items = #PC_SPY_TF_ITEMS;

		self.armorclass = self.armorclass | #PC_SPY_INITARMORCLASS;
		self.armortype = #PC_SPY_INITARMORTYPE;
		self.armorvalue = #PC_SPY_INITARMOR;
	   	self.armor_allowed = #PC_SPY_MAXARMORTYPE;
	   	self.maxarmor = #PC_SPY_MAXARMOR;
		self.current_weapon = #WEAP_TRANQ;
		self.items_allowed = #PC_SPY_WEAPONS;

		// set the weapon icons on the status bar
		self.items = self.items | #IT_SHOTGUN | #IT_SUPER_SHOTGUN | #IT_NAILGUN;

		// If the Spy only has invis, start the Spy's cell regen timer
		if (invis_only == #TRUE)
		{
			te = spawn();
			te.nextthink = time + #PC_SPY_CELL_REGEN_TIME;
			te.think = TeamFortress_RegenerateCells;
			te.owner = self;
			te.classname = "timer";
		}
	}
	else if ( self.playerclass == #PC_ENGINEER )
	{
		self.weapons_carried = self.weapons_carried | #PC_ENGINEER_WEAPONS;
		self.ammo_rockets = #PC_ENGINEER_INITAMMO_ROCKET;
		self.ammo_nails = #PC_ENGINEER_INITAMMO_NAIL;
		self.ammo_shells = #PC_ENGINEER_INITAMMO_SHOT;
		self.ammo_cells = #PC_ENGINEER_INITAMMO_CELL;
		self.maxammo_rockets = #PC_ENGINEER_MAXAMMO_ROCKET;
		self.maxammo_nails = #PC_ENGINEER_MAXAMMO_NAIL;
		self.maxammo_shells = #PC_ENGINEER_MAXAMMO_SHOT;
		self.maxammo_cells = #PC_ENGINEER_MAXAMMO_CELL;
	
		self.no_grenades_1 = #PC_ENGINEER_GRENADE_INIT_1;
		self.no_grenades_2 = #PC_ENGINEER_GRENADE_INIT_2;
		self.tp_grenades_1 = #PC_ENGINEER_GRENADE_TYPE_1;
		self.tp_grenades_2 = #PC_ENGINEER_GRENADE_TYPE_2;
		self.tf_items = #PC_ENGINEER_TF_ITEMS;

		self.armorclass = self.armorclass | #PC_ENGINEER_INITARMORCLASS;
		self.armortype = #PC_ENGINEER_INITARMORTYPE;
		self.armorvalue = #PC_ENGINEER_INITARMOR;
	   	self.armor_allowed = #PC_ENGINEER_MAXARMORTYPE;
	   	self.maxarmor = #PC_ENGINEER_MAXARMOR;
		self.current_weapon = #WEAP_LASER;
		self.items_allowed = #PC_ENGINEER_WEAPONS;

		// set the weapon icons on the status bar
		self.items = self.items | #IT_SHOTGUN | #IT_SUPER_SHOTGUN;
	}
	else if ( self.playerclass == #PC_UNDEFINED )
	{
		self.items = 0;
		self.ammo_rockets = 0;
		self.ammo_nails = 0;
		self.ammo_shells = 0;
		self.ammo_cells = 0;

		self.no_grenades_1 = 0;
		self.no_grenades_2 = 0;
		self.tp_grenades_1 = 0;
		self.tp_grenades_2 = 0;
	
		self.armorclass = 0;
		self.armortype = 0;
		self.armorvalue = 0;
		self.weapon = 0;
		self.current_weapon = 0;
		self.weapons_carried = 0;

		self.flags = #FL_CLIENT | #FL_NOTARGET; // | #FL_ONGROUND;
		self.waterlevel = 3;
		self.takedamage = #DAMAGE_NO;
		self.solid = #SOLID_NOT;
		self.movetype = #MOVETYPE_NOCLIP;

		self.model = string_null;
		self.mdl = string_null;
		self.modelindex = 0;
		self.weaponmodel = string_null;
		modelindex_player = 0;
		self.tfstate = self.tfstate | #TFSTATE_RELOADING;
	
		setmodel(self, string_null);
	}

	// Update armor picture
	if (self.armortype >= 0.8)
		self.items = self.items | #IT_ARMOR3;
	else if (self.armortype >= 0.6)
		self.items = self.items | #IT_ARMOR2;
	else if (self.armortype >= 0.3)
		self.items = self.items | #IT_ARMOR1;

	// Give everyone the hook
	if (allow_hook && self.playerclass != #PC_UNDEFINED)
		self.weapons_carried = self.weapons_carried | #WEAP_HOOK;

	W_SetCurrentAmmo ();
};

//=========================================================================
// Return the max amount of ammo the Retriever can carry, based on his class
float(entity Retriever, float AmmoType) TeamFortress_GetMaxAmmo =
{
	if (AmmoType == #IT_SHELLS)
		return Retriever.maxammo_shells;
	else if (AmmoType == #IT_NAILS)
		return Retriever.maxammo_nails;
	else if (AmmoType == #IT_CELLS)
		return Retriever.maxammo_cells;
	else if (AmmoType == #IT_ROCKETS)
		return Retriever.maxammo_rockets;
	else if (AmmoType == #WEAP_MEDIKIT)
		return Retriever.maxammo_medikit;
	else if (AmmoType == #WEAP_DETPACK)
		return Retriever.maxammo_detpack;

	dprint("Error in TeamFortress_GetMaxAmmo()\n");
	dprint("Invalid ammo type passed.\n");
	return 0;
};

//=========================================================================
// Return 1 if the Retriever is allowed to pick up the Weapon
float(entity Retriever, float WeaponType) TeamFortress_CanGetWeapon =
{
	if ( Retriever.items_allowed & WeaponType )
		return #TRUE;

	return #FALSE;
};


//=========================================================================
// Print a string to Player, describing this type of armor
void(entity Player, float Armorclass) TeamFortress_DescribeArmor =
{
	local string st;

	if (Armorclass == 0)
		return;

	if (Armorclass & #AT_SAVEFIRE)
		sprint (Player, #PRINT_HIGH, "Asbestos ");
	if (Armorclass & #AT_SAVENAIL)
		sprint (Player, #PRINT_HIGH, "Wooden ");
	if (Armorclass & #AT_SAVEEXPLOSION)
		sprint (Player, #PRINT_HIGH, "Blast ");
	if (Armorclass & #AT_SAVEELECTRICITY)
		sprint (Player, #PRINT_HIGH, "Shockproof ");
	if (Armorclass & #AT_SAVESHOT)
		sprint (Player, #PRINT_HIGH, "Kevlar ");

	sprint (Player, #PRINT_HIGH, "armor\n");
};

//=========================================================================
// Controls the equipment a class receives from backpacks
float(entity Retriever, entity Items) TeamFortress_AddBackpackItems =
{
	// If you want the classes to _not_ start off with all their legal
	// weapons, then you may want them to be able to pick up weapons
	// from backpacks. If so, this is where to do it.
	// For now, return. 
	return;
};

//=========================================================================
// Return a string containing the class name for pc
string(float pc) TeamFortress_GetClassName =
{
	if ( pc == #PC_SCOUT )
		return "Scout";
	else if ( pc == #PC_SNIPER )
		return "Sniper";
	else if ( pc == #PC_SOLDIER )
		return "Soldier";
	else if ( pc == #PC_DEMOMAN )
		return "Demolitions Man";
	else if ( pc == #PC_MEDIC )
		return "Combat Medic";
	else if ( pc == #PC_HVYWEAP )
		return "Heavy Weapons Guy";
	else if ( pc == #PC_PYRO )
		return "Pyro";
	else if ( pc == #PC_SPY )
		return "Spy";
	else if ( pc == #PC_ENGINEER )
		return "Engineer";
	else if ( pc == #PC_CIVILIAN )
		return "Civilian";
	else if ( pc == #PC_UNDEFINED )
		return "Observer";
	else if ( pc == #PC_RANDOM)
		return "Random Playerclass";
};

//=========================================================================
// Display the class of Player to Viewer
void(entity Viewer, float pc, float rpc) TeamFortress_PrintClassName =
{
	local string st;

	st = TeamFortress_GetClassName(pc);
	sprint (Viewer, #PRINT_HIGH, st);

	if (rpc != 0)
		sprint (Viewer, #PRINT_HIGH, " (Random)");
	sprint (Viewer, #PRINT_HIGH, "\n");
};

//=========================================================================
// Say the class of Player to him/her
#ifdef SPEECH
void(entity player) TeamFortress_SayClassName =
{
	if ( player.playerclass == #PC_SCOUT )
		stuffcmd(player, "play speech/scout.wav\n");
	else if ( player.playerclass == #PC_SNIPER )
		stuffcmd(player, "play speech/sniper.wav\n");
	else if ( player.playerclass == #PC_SOLDIER )
		stuffcmd(player, "play speech/soldier.wav\n");
	else if ( player.playerclass == #PC_DEMOMAN )
		stuffcmd(player, "play speech/demoman.wav\n");
	else if ( player.playerclass == #PC_MEDIC )
		stuffcmd(player, "play speech/medic.wav\n");
	else if ( player.playerclass == #PC_HVYWEAP )
		stuffcmd(player, "play speech/hvyweap.wav\n");
	else if ( player.playerclass == #PC_PYRO )
		stuffcmd(player, "play speech/pyro.wav\n");
	else if ( player.playerclass == #PC_SPY )
		stuffcmd(player, "play speech/spy.wav\n");
	else if ( player.playerclass == #PC_ENGINEER )
		stuffcmd(player, "play speech/engineer.wav\n");
	else if ( player.playerclass == #PC_CIVILIAN )
		stuffcmd(player, "play speech/civilian.wav\n");
};
#endif

//=========================================================================
// Remove all the timers for this player
// This function is _always_ called when a player dies.
void() TeamFortress_RemoveTimers =
{
	local entity te;

	self.leg_damage = 0;
	self.is_undercover = 0;
	self.is_building = 0;
	self.building = world;

	// Clear the sniper's aiming
	if (self.tfstate & #TFSTATE_AIMING)
	{
		self.tfstate = self.tfstate - #TFSTATE_AIMING;
		TeamFortress_SetSpeed(self);
		self.heat = 0;
	}

	// Remove all the timer entities for this player
	te = find(world, classname, "timer");
	while (te != world)
	{
		if (te.owner == self)
		{
			dremove(te);
			te = find(world, classname, "timer");
		}
		else
			te = find(te, classname, "timer");
	}

	// Drop any GoalItems
	te = find (world, classname, "item_tfgoal");
	while (te)
	{
		if (te.owner == self)
		{
			// Remove it from the player, if it is supposed to be
			if (!(te.goal_activation & #TFGI_KEEP))
			{
				tfgoalitem_RemoveFromPlayer(te, self, 0);
			}

			// CTF support
			if (CTF_Map == #TRUE && te.goal_no == #CTF_FLAG1)
			{
				bprint(#PRINT_HIGH, self.netname);
      			bprint(#PRINT_HIGH, " лост the блуе flag!\n");
			}
			else if (CTF_Map == #TRUE && te.goal_no == #CTF_FLAG2)
			{
				bprint(#PRINT_HIGH, self.netname);
                bprint(#PRINT_HIGH, " лост the ред flag!\n");
			}

		}
		te = find(te, classname, "item_tfgoal");
	}

	// Reset detpacks being disarmed to not being disarmed
	te = find (world, classname, "detpack");
	while (te)
	{
		if ((te.weaponmode == 1) && (te.enemy == self))
		{
			te.weaponmode = 0;
		}
		te = find(te, classname, "detpack");
	}

	// detonate all of the players pipebombs
	TeamFortress_DetonatePipebombs();

	stuffcmd(self, "v_idlescale 0\n");
	stuffcmd(self, "v_cshift 0 0 0 0\n");
	self.item_list = 0;
	self.FlashTime = 0;

	// Remove Menu
	CenterPrint(self, "\n");
	self.menu_count = #MENU_REFRESH_RATE;
	self.current_menu = #MENU_DEFAULT;
	self.impulse = 0;
};

//=========================================================================
// Setup the Respawn delays for this player
void(float Suicided) TeamFortress_SetupRespawn =
{
	local float restime;
	local string db;

	if (self.respawn_time > time)
		return;		// already respawning

	// Setup Respawn Delay
	if (toggleflags & #TFLAG_RESPAWNDELAY)
		restime = respawn_delay_time;
	else 
		restime = 0;

	// Penalise suiciders
	if (Suicided)
	{
		// Lose 2 lives for suiciding
		if (self.lives > 0)
			self.lives = self.lives - 1;
		restime = restime + 5;
	}

	// Setup Lives
	if (self.lives > 0)
		self.lives = self.lives - 1;

	if (self.lives != -1)
	{
		if (self.lives == 0)
		{
			// Move to Observer mode
			sprint (self, #PRINT_HIGH, "NO lives left, returning to Observer mode.\n");
			self.playerclass = #PC_UNDEFINED;
			self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_RANDOMPC);
			self.movetype = #MOVETYPE_NOCLIP;
			self.solid = #SOLID_NOT;
			self.model = "";
			self.mdl = "";
			self.velocity = '0 0 0';
			self.avelocity = '0 0 0';
			self.enemy = world;		// clear camera lock
			setmodel(self, "");

			return;
		}

		if (self.lives == 1)
			sprint (self, #PRINT_HIGH, "LAST life.\n");
		else
		{
			db = ftos(self.lives);
			sprint(self, #PRINT_HIGH, db);
			sprint (self, #PRINT_HIGH, " lives left.\n");
		}
	}

	// Do this after life calculation, so people without any
	// lives left can respawn back to Observer mode without a delay.
	self.respawn_time = time + restime;

	if (restime > 3)
	{
		db = ftos(restime);

		sprint(self, #PRINT_HIGH, db);
		sprint(self, #PRINT_HIGH, " seconds till respawn.\n");
	}
};

//=========================================================================
// Check all stats to make sure they're good for this class
void() TeamFortress_CheckClassStats =
{
	// Check armor
	if (self.armortype > self.armor_allowed)
		self.armortype = self.armor_allowed;
	if (self.armorvalue > self.maxarmor)
		self.armorvalue = self.maxarmor;
	if (self.armortype < 0)
		self.armortype = 0;
	if (self.armorvalue < 0)
		self.armorvalue = 0;
	// Check ammo
	if (self.ammo_shells > TeamFortress_GetMaxAmmo(self,#IT_SHELLS))
		self.ammo_shells = TeamFortress_GetMaxAmmo(self,#IT_SHELLS);
	if (self.ammo_shells < 0)
		self.ammo_shells = 0;
	if (self.ammo_nails > TeamFortress_GetMaxAmmo(self,#IT_NAILS))
		self.ammo_nails = TeamFortress_GetMaxAmmo(self,#IT_NAILS);
	if (self.ammo_nails < 0)
		self.ammo_nails = 0;
	if (self.ammo_rockets > TeamFortress_GetMaxAmmo(self,#IT_ROCKETS))
		self.ammo_rockets = TeamFortress_GetMaxAmmo(self,#IT_ROCKETS);		
	if (self.ammo_rockets < 0)
		self.ammo_rockets = 0;
	if (self.ammo_cells > TeamFortress_GetMaxAmmo(self,#IT_CELLS))
		self.ammo_cells = TeamFortress_GetMaxAmmo(self,#IT_CELLS);		
	if (self.ammo_cells < 0)
		self.ammo_cells = 0;
	if (self.ammo_medikit > TeamFortress_GetMaxAmmo(self,#WEAP_MEDIKIT))
		self.ammo_medikit = TeamFortress_GetMaxAmmo(self,#WEAP_MEDIKIT);		
	if (self.ammo_medikit < 0)
		self.ammo_medikit = 0;
	if (self.ammo_detpack > TeamFortress_GetMaxAmmo(self,#WEAP_DETPACK))
		self.ammo_detpack = TeamFortress_GetMaxAmmo(self,#WEAP_DETPACK);		
	if (self.ammo_detpack < 0)
		self.ammo_detpack = 0;
	// Check Grenades
	if (self.no_grenades_1 < 0)
		self.no_grenades_1 = 0;
	if (self.no_grenades_2 < 0)
		self.no_grenades_2 = 0;
	// Check health
	if (self.health > self.max_health && !(self.items & #IT_SUPERHEALTH))
		TF_T_Damage (self, world, world, (self.max_health - self.health), 0, #TF_TD_NOSOUND);
	if (self.health < 0)
		T_Heal(self, (self.health - self.health), 0);

	// Update armor picture
	self.items = self.items - (self.items & (#IT_ARMOR1 | #IT_ARMOR2 | #IT_ARMOR3));
	if (self.armortype >= 0.8)
		self.items = self.items | #IT_ARMOR3;
	else if (self.armortype >= 0.6)
		self.items = self.items | #IT_ARMOR2;
	else if (self.armortype >= 0.3)
		self.items = self.items | #IT_ARMOR1;
};

//=========================================================================
// AMMOBOX Handling
//=========================================================================
// Throw an ammo box with 10 shells, 10 nails, 5 cells or 5 rockets
void (float type) TeamFortress_DropAmmo =
{
	local float ammo;

    if (type == 1)
	{
		ammo = #DROP_SHELLS;
		if (self.ammo_shells < ammo)
		{
			// ENGINEER can make ammo
			if (self.playerclass == #PC_ENGINEER)
			{
				if ((self.ammo_cells / #AMMO_COST_SHELLS) > (ammo - self.ammo_shells))
				{
					sprint (self, #PRINT_HIGH, "you make some shells.\n");
					self.ammo_cells = self.ammo_cells - ((ammo - self.ammo_shells) * #AMMO_COST_SHELLS);
					self.ammo_shells = ammo;
				}
			}

			if (self.ammo_shells < ammo)
				return;
		}

		self.ammo_shells = self.ammo_shells - ammo;
	}
	else if (type == 2)
	{
		ammo = #DROP_NAILS;
		if (self.ammo_nails < ammo)
		{
			// ENGINEER can make ammo
			if (self.playerclass == #PC_ENGINEER)
			{
				if ((self.ammo_cells / #AMMO_COST_NAILS) > (ammo - self.ammo_nails))
				{
					sprint (self, #PRINT_HIGH, "you make some nails.\n");
					self.ammo_cells = self.ammo_cells - ((ammo - self.ammo_nails) * #AMMO_COST_NAILS);
					self.ammo_nails = ammo;
				}
			}

			if (self.ammo_nails < ammo)
				return;
		}

		self.ammo_nails = self.ammo_nails - ammo;
	}
	else if (type == 3)
	{
		ammo = #DROP_ROCKETS;
		if (self.ammo_rockets < ammo)
		{
			// ENGINEER can make ammo
			if (self.playerclass == #PC_ENGINEER)
			{
				if ((self.ammo_cells / #AMMO_COST_ROCKETS) > (ammo - self.ammo_rockets))
				{
					sprint (self, #PRINT_HIGH, "you make some rockets.\n");
					self.ammo_cells = self.ammo_cells - ((ammo - self.ammo_rockets) * #AMMO_COST_ROCKETS);
					self.ammo_rockets = ammo;
				}
			}

			if (self.ammo_rockets < ammo)
				return;
		}

		self.ammo_rockets = self.ammo_rockets - ammo;
	}
	else if (type == 4)
	{
		ammo = #DROP_CELLS;
		if (self.ammo_cells < ammo)
		{
			// ENGINEER can make ammo
			if (self.playerclass == #PC_ENGINEER)
			{
				if ((self.ammo_cells / #AMMO_COST_CELLS) > (ammo - self.ammo_cells))
				{
					sprint (self, #PRINT_HIGH, "you make some cells.\n");
					self.ammo_cells = self.ammo_cells - ((ammo - self.ammo_cells) * #AMMO_COST_CELLS);
					self.ammo_cells = ammo;
				}
			}

			if (self.ammo_cells < ammo)
				return;
		}

		self.ammo_cells = self.ammo_cells - ammo;
	}
	W_SetCurrentAmmo();

	if (self.team_no != 0)
	{
		increment_team_ammoboxes(self.team_no);
		if (num_team_ammoboxes(self.team_no) > (#MAX_WORLD_AMMOBOXES / number_of_teams))
			RemoveOldAmmobox(self.team_no);
	}
	else 
	{
		num_world_ammoboxes = num_world_ammoboxes + 1;
		if (num_world_ammoboxes > #MAX_WORLD_AMMOBOXES)
			RemoveOldAmmobox(0);
	}

	newmis = spawn();
	newmis.aflag = ammo;
	newmis.weapon = type;
	if (newmis.weapon == 1)
		newmis.ammo_shells = ammo;
	else if (newmis.weapon == 2)
		newmis.ammo_nails = ammo;
	else if (newmis.weapon == 3)
		newmis.ammo_rockets = ammo;
	else if (newmis.weapon == 4)
		newmis.ammo_cells = ammo;
	newmis.enemy = self;
	newmis.health = time;
	newmis.movetype = #MOVETYPE_TOSS;
	newmis.solid = #SOLID_TRIGGER;
	newmis.classname = "ammobox";
	newmis.team_no = self.team_no;

	makevectors (self.v_angle);

	if (self.v_angle_x)
		newmis.velocity = v_forward*400 + v_up * 200;
	else
	{
		newmis.velocity = aim(self, 10000);
		newmis.velocity = newmis.velocity * 400;
		newmis.velocity_z = 200;
	}

	newmis.avelocity = '0 300 0';
	setsize (newmis, '0 0 0', '0 0 0');		
	setorigin (newmis, self.origin);
	newmis.nextthink = time + 30;	// remove after 30 seconds
	newmis.think = SUB_Remove;
	newmis.touch = TeamFortress_AmmoboxTouch;
	newmis.skin = type - 1;
	setmodel (newmis, "progs/ammobox.mdl");
};

void () TeamFortress_AmmoboxTouch =
{
	local float took;
	local string quantity;

	took = 0;

	// Cant touch own ammobox for 2 seconds after throwing
	if ((other == self.enemy) && (time < self.health + 2))
		return;			

	// Return if other is not a player
	if (other.classname != "player")
		return;
	if (other.health <= 0)
		return;

	num_world_ammoboxes = num_world_ammoboxes - 1;
	decrement_team_ammoboxes(self.team_no);

	// discard backpack
	if (self.weapon == 0)
	{
		sprint(other, #PRINT_LOW, "You got ");
		if (self.ammo_shells > 0)
		{
			other.ammo_shells = other.ammo_shells + self.ammo_shells;
			quantity = ftos(self.ammo_shells);
			sprint2(other, #PRINT_LOW, quantity, " shells  ");
		}	
		if (self.ammo_nails > 0)
		{
			other.ammo_nails = other.ammo_nails + self.ammo_nails;
			quantity = ftos(self.ammo_nails);
			sprint2(other, #PRINT_LOW, quantity, " nails  ");
		}	
		if (self.ammo_rockets > 0)
		{
			other.ammo_rockets = other.ammo_rockets + self.ammo_rockets;
			quantity = ftos(self.ammo_rockets);
			sprint2(other, #PRINT_LOW, quantity, " rockets  ");
		}	
		if (self.ammo_cells > 0)
		{
			other.ammo_cells = other.ammo_cells + self.ammo_cells;
			quantity = ftos(self.ammo_cells);
			sprint2(other, #PRINT_LOW, quantity, " cells  ");
		}	
		sprint(other, #PRINT_LOW, "\n");
	}
	// shotgun
	else if (self.weapon == 1)
	{
		if (other.ammo_shells >= TeamFortress_GetMaxAmmo(other,#IT_SHELLS))
			return;
		other.ammo_shells = other.ammo_shells + self.aflag;
		self.netname = "shells";
	}
	// spikes
	else if (self.weapon == 2)
	{
		if (other.ammo_nails >= TeamFortress_GetMaxAmmo(other,#IT_NAILS))
			return;
		other.ammo_nails = other.ammo_nails + self.aflag;
		self.netname = "nails";
	}
	//	rockets
	else if (self.weapon == 3)
	{
		if (other.ammo_rockets >= TeamFortress_GetMaxAmmo(other,#IT_ROCKETS))
			return;
		other.ammo_rockets = other.ammo_rockets + self.aflag;
		self.netname = "rockets";
	}
	//	cells
	else if (self.weapon == 4)
	{
		if (other.ammo_cells >= TeamFortress_GetMaxAmmo(other,#IT_CELLS))
			return;
		other.ammo_cells = other.ammo_cells + self.aflag;
		self.netname = "cells";
	}

	bound_other_ammo (other);

	// Discard backpacks do their own printing
	if (self.weapon > 0)
	{
		quantity = ftos(self.aflag);
		sprint5(other, #PRINT_LOW, "You picked up ", quantity, " ", self.netname, "\n");
	}

	sound (other, #CHAN_ITEM, "weapons/lock4.wav", 1, #ATTN_NORM);
	stuffcmd (other, "bf\n");

	dremove(self);
	self = other;
	W_SetCurrentAmmo();
};

// Return the number of pipebombs in existence for a particular team
float (float tno) num_team_ammoboxes =
{
	if (tno == 1)
		return num_team_ammoboxes_1;
	else if (tno == 2)
		return num_team_ammoboxes_2;
	else if (tno == 3)
		return num_team_ammoboxes_3;
	else if (tno == 4)
		return num_team_ammoboxes_4;

	return 0;
};

// Remove enough old ammoboxes to bring the count down to the max level
void(float tno) RemoveOldAmmobox =
{
	local entity old;
	local float index;

	if (tno != 0)
	{
		index = num_team_ammoboxes(tno);
		index = index - (#MAX_WORLD_AMMOBOXES / number_of_teams);
	}
	else
	{
		index = num_world_ammoboxes - #MAX_WORLD_AMMOBOXES;
	}

	old = find(world, classname, "ammobox");
	while (index > 0)
	{
		if (old == world)
		{
			dprint("*** ERROR: RemoveOldAmmobox. ***\n");
			dprint("*** Please report this.        ***\n");
			return;
		}

		if (old.team_no == tno || tno == 0)
		{
			old.think = SUB_Remove;
			old.nextthink = time + 0.1;
			index = index - 1;

			num_world_ammoboxes = num_world_ammoboxes - 1;
			decrement_team_ammoboxes(old.team_no);
		}

		old = find(old, classname, "ammobox");
	}
};

void(float tno) increment_team_ammoboxes =
{
	if (tno == 1)
		num_team_ammoboxes_1 = num_team_ammoboxes_1 + 1;
	else if (tno == 2)
		num_team_ammoboxes_2 = num_team_ammoboxes_2 + 1;
	else if (tno == 3)
		num_team_ammoboxes_3 = num_team_ammoboxes_3 + 1;
	else if (tno == 4)
		num_team_ammoboxes_4 = num_team_ammoboxes_4 + 1;
};

void(float tno) decrement_team_ammoboxes =
{
	if (tno == 1)
		num_team_ammoboxes_1 = num_team_ammoboxes_1 - 1;
	else if (tno == 2)
		num_team_ammoboxes_2 = num_team_ammoboxes_2 - 1;
	else if (tno == 3)
		num_team_ammoboxes_3 = num_team_ammoboxes_3 - 1;
	else if (tno == 4)
		num_team_ammoboxes_4 = num_team_ammoboxes_4 - 1;
};

//=========================================================================
// WEAPON HANDLING FUNCTIONS
//=========================================================================
//=========================================================================
// Assault Cannon selection function
void() TeamFortress_AssaultWeapon =
{
	local	float	it;
	
	self.impulse = 0;

    if (self.tfstate & #TFSTATE_RELOADING)
   		return;

	if (!(self.weapons_carried & #WEAP_ASSAULT_CANNON)) 
		return;

	if (self.heat > 0)
	{
		sprint (self, #PRINT_HIGH, "the assault cannon is still overheated.\n");
		return;
	}

	if (self.ammo_shells < 1)
	{	// don't have the ammo
		sprint (self, #PRINT_HIGH, "not enough ammo.\n");
		return;
	}
	// The cannon also needs 6 cells to power up 
	if (self.ammo_cells < 6)
	{
		sprint (self, #PRINT_HIGH, "not enough cells to power the assault cannon.\n");
		return;
	}

	self.current_weapon = #WEAP_ASSAULT_CANNON;

	W_SetCurrentAmmo ();
};

//=========================================================================
// If this gets called, the players holding onto an exploding grenade :)
void() TeamFortress_ExplodePerson =
{
	local entity te;

	// Removes the owners grenade
	self.owner.tfstate = self.owner.tfstate - (self.owner.tfstate & #TFSTATE_GRENPRIMED);

	KickPlayer(-2, self.owner);

	newmis = spawn ();
	newmis.movetype = #MOVETYPE_BOUNCE;
	newmis.solid = #SOLID_BBOX;
	newmis.classname = "grenade";
	newmis.team_no = self.owner.team_no;
	newmis.owner = self.owner;
		
	// Don't bother calculating a velocity
	newmis.velocity = '0 0 0';
	newmis.angles = vectoangles(newmis.velocity);
	
	// set the grenades thinktime to now
	newmis.think = SUB_Null;
	newmis.nextthink = time + 0.1;

	// set the think and touches to the appropriate grenade type
	if (self.weapon == #GR_TYPE_NORMAL)
	{
		newmis.touch = NormalGrenadeTouch;
		newmis.think = NormalGrenadeExplode;
		newmis.skin = 0;
		newmis.avelocity = '300 300 300';
		setmodel (newmis, "progs/hgren2.mdl");
	}
	else if (self.weapon == #GR_TYPE_CONCUSSION)
	{
		newmis.touch = ConcussionGrenadeTouch;
		newmis.think = ConcussionGrenadeExplode;
		newmis.skin = 1;
		newmis.avelocity = '300 300 300';
		setmodel (newmis, "progs/hgren2.mdl");
	}
	else if (self.weapon == #GR_TYPE_NAIL)
	{
		newmis.touch = NailGrenadeTouch;
		newmis.think = NailGrenadeExplode;
		newmis.skin = 1;
		newmis.avelocity = '0 300 0';
		setmodel (newmis, "progs/biggren.mdl");
	}
	else if (self.weapon == #GR_TYPE_MIRV)
	{
		newmis.touch = MirvGrenadeTouch;
		newmis.think = MirvGrenadeExplode;
		newmis.skin = 0;
		newmis.avelocity = '0 300 0';
		setmodel (newmis, "progs/biggren.mdl");
	}
	else if (self.weapon == #GR_TYPE_NAPALM)
	{
		newmis.touch = NapalmGrenadeTouch;
		newmis.think = NapalmGrenadeExplode;
		newmis.skin = 2;
		newmis.avelocity = '0 300 0';
		setmodel (newmis, "progs/biggren.mdl");
	}
	else if (self.weapon == #GR_TYPE_FLARE)
	{
		sprint(self.owner, #PRINT_HIGH, "Flare lit.\n");
		te = spawn();
   		te.touch = SUB_Null;
		te.think = RemoveFlare;
		te.nextthink = time + 25;
		te.owner = self.owner;
		te.solid = #SOLID_NOT;
		self.owner.effects = self.owner.effects | #EF_BRIGHTLIGHT;
   		dremove(self);
		dremove(newmis);
		return;
	}
	else if (self.weapon == #GR_TYPE_GAS)
	{
		newmis.touch = GasGrenadeTouch;
		newmis.think = GasGrenadeExplode;
		newmis.skin = 2;
		newmis.avelocity = '300 300 300';
		setmodel (newmis, "progs/grenade2.mdl");
	}
	else if (self.weapon == #GR_TYPE_EMP)
	{
		newmis.touch = EMPGrenadeTouch;
		newmis.think = EMPGrenadeExplode;
		newmis.skin = 4;
		newmis.avelocity = '300 300 300';
		setmodel (newmis, "progs/grenade2.mdl");
	}
	else if (self.weapon == #GR_TYPE_FLASH)
	{
		newmis.touch = FlashGrenadeTouch;
		newmis.think = FlashGrenadeExplode;
		newmis.skin = 1;
		newmis.avelocity = '300 300 300';
		setmodel (newmis, "progs/grenade2.mdl");
	}

	setsize (newmis, '0 0 0', '0 0 0');		
	setorigin (newmis, self.owner.origin);

	bprint(#PRINT_MEDIUM, "No ");
	bprint(#PRINT_MEDIUM, self.owner.netname);
	bprint(#PRINT_MEDIUM, ", throw the grenade, not the pin!\n");

	// Remove primed grenade object	
	dremove(self);
};

//=========================================================================
// Thrown Grenade touch function.
void() NormalGrenadeTouch =
{
	if (other == self.owner)
		return;		// don't explode on owner

	// Thrown grenades don't detonate when hitting an enemy

	sound (self, #CHAN_WEAPON, "weapons/bounce.wav", 1, #ATTN_NORM);	// bounce sound
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
};

//=========================================================================
// Thrown grenade explosion. 50% more powerful as grenade launcher grenades.
void() NormalGrenadeExplode =
{
	deathmsg = #DMSG_GREN_HAND;
	T_RadiusDamage (self, self.owner, 180, world);

#ifdef DEMO_STUFF
	// Remove any camera's locks on this missile
	if (self.enemy)
		CamProjectileLockOff();
#endif

	WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
	WriteByte (#MSG_BROADCAST, #TE_EXPLOSION);
	WriteCoord (#MSG_BROADCAST, self.origin_x);
	WriteCoord (#MSG_BROADCAST, self.origin_y);
	WriteCoord (#MSG_BROADCAST, self.origin_z);
#ifdef QUAKE_WORLD
	multicast (self.origin, #MULTICAST_PHS);
	dremove(self);
#else
	BecomeExplosion ();
#endif
};

//=========================================================================
// Displays the state of the items in the Detection Entity
void() TeamFortress_DisplayDetectionItems =
{
	local entity Goal, te;

	Goal = find(world, classname, "info_tfdetect");
	if (!Goal)
		return;

	// Check to make sure they've got some strings
	if (Goal.team_str_home == string_null)
		return;

	if (Goal.display_item_status1 != 0)
	{
		te = Finditem(Goal.display_item_status1);
		if (te)
			DisplayItemStatus(Goal, self, te);
		else
			sprint (self, #PRINT_HIGH, "Item is missing.\n");
	}
	else
		return;

	if (Goal.display_item_status2 != 0)
	{
		te = Finditem(Goal.display_item_status2);
		if (te)
			DisplayItemStatus(Goal, self, te);
		else
			sprint (self, #PRINT_HIGH, "Item is missing.\n");
	}
	else
		return;

	if (Goal.display_item_status3 != 0)
	{
		te = Finditem(Goal.display_item_status3);
		if (te)
			DisplayItemStatus(Goal, self, te);
		else
			sprint (self, #PRINT_HIGH, "Item is missing.\n");
	}
	else
		return;

	if (Goal.display_item_status4 != 0)
	{
		te = Finditem(Goal.display_item_status4);
		if (te)
			DisplayItemStatus(Goal, self, te);
		else
			sprint (self, #PRINT_HIGH, "Item is missing.\n");
	}
};

//=========================================================================
// ITEM HANDLING FUNCTIONS
//=========================================================================
// Function for handling the BioInfection Decay of players
void() BioInfection_Decay =
{
	// Remove infections which can't hurt the owner
	if ((teamplay & #TEAMPLAY_NOEXPLOSIVE) && (self.owner.team_no == self.enemy.team_no) && (self.owner.team_no != 0))
	{
		self.owner.tfstate = self.owner.tfstate - (self.owner.tfstate & #TFSTATE_INFECTED);
		dremove(self);
		return;
	}

	if (self.invincible_finished > time)
	{
		self.owner.tfstate = self.owner.tfstate - (self.owner.tfstate & #TFSTATE_INFECTED);
		dremove(self);
		return;
	}
	
	self.nextthink = time + 2;

	deathmsg = #DMSG_BIOWEAPON;
	TF_T_Damage(self.owner, self, self.enemy, 5, #TF_TD_IGNOREARMOUR, #TF_TD_OTHER);

	SpawnBlood(self.owner.origin, 30);

	// remove this entity if the infection is gone
	if ( !(self.owner.tfstate & #TFSTATE_INFECTED) )
		dremove(self);
};

//========================================================================
// Function for handling the BioInfection Decay of monsters
void() BioInfection_MonsterDecay =
{
	self.nextthink = time + 2;

	T_Damage(self.enemy, self, self.owner, 5);
	SpawnBlood(self.enemy.origin, 20);
	
	if (self.enemy.health < 1)
		dremove(self);
		
};

//=========================================================================
// UTILITY FUNCTIONS
//=========================================================================
// Stuff an alias. This is a little messy since we insisted
// on maintaining the ability to alter the impulse numbers in the defs.qc 
// and not have to change any code. 
void(string halias, float himpulse1, float himpulse2) TeamFortress_Alias =
{
	local string imp;

	stuffcmd(self, "alias ");
	stuffcmd(self, halias);
	stuffcmd(self, " \"impulse ");
	imp = ftos(himpulse1);
	stuffcmd(self, imp);

	// if himpulse2 is not zero, assume that himpulse1 is a preimpulse 
	// and complete the alias
	if (himpulse2 != 0)
	{
		stuffcmd(self, ";wait; impulse ");
		imp = ftos(himpulse2);
		stuffcmd(self, imp);
	}
	stuffcmd(self, "\"\n");
};

//=========================================================================
// CYCLIC EVENT FUNCTIONS
//=========================================================================
//=========================================================================
// Regenerates the entity which owns this cyclictimer
void() TeamFortress_Regenerate =
{
	if (self.owner.playerclass == #PC_MEDIC)
	{
		self.nextthink = time + #PC_MEDIC_REGEN_TIME;

		if (self.owner.health >= self.owner.max_health)
			return;

		if (self.owner.ammo_medikit == 0)
			return;

		if (self.owner.ammo_medikit < #PC_MEDIC_REGEN_AMOUNT)
		{
			self.owner.health = self.owner.health + self.owner.ammo_medikit;
			self.owner.ammo_medikit = 0;
		}
		else
		{
			self.owner.health = self.owner.health + #PC_MEDIC_REGEN_AMOUNT;
			self.owner.ammo_medikit = self.owner.ammo_medikit - #PC_MEDIC_REGEN_AMOUNT;
		}

		if (self.owner.health > self.owner.max_health)
			self.owner.health = self.owner.max_health;
	}
};

//=========================================================================
// Regenerates the number of cells the owner of this timer has if they're
// not invisible, or removes cells if they're invisible.
void() TeamFortress_RegenerateCells =
{
	if (self.owner.playerclass == #PC_SPY)
	{
		self.nextthink = time + #PC_SPY_CELL_REGEN_TIME;

		// If the spy is undercover, decrease the number of cells
		if (self.owner.is_undercover == 1)
		{
			// If the spy has no cells left, he becomes visible again
			if (self.owner.ammo_cells == 0)
			{
				self.owner.is_undercover = 0;
				self.owner.modelindex = modelindex_player;	// return to normal
				self.owner.items = self.owner.items - (self.owner.items & #IT_INVISIBILITY);
			}
			else // Decrease cells
			{
				self.owner.ammo_cells = self.owner.ammo_cells - #PC_SPY_CELL_USAGE;
				if (self.owner.ammo_cells < 0)
					self.owner.ammo_cells = 0;
			}
		}
		else	// Increase cell ammo
		{
			if (self.owner.ammo_cells >= self.owner.maxammo_cells)
				return;

			self.owner.ammo_cells = self.owner.ammo_cells + #PC_SPY_CELL_REGEN_AMOUNT;

			if (self.owner.ammo_cells > self.owner.maxammo_cells)
				self.owner.ammo_cells = self.owner.maxammo_cells;
		}

		return;
	}
};

//=========================================================================
// Check for cheats :) Mainly for internet play
// This is _far_ from a good solution. It will catch non-scouts that
// set their speeds to maxspeed, but not much else.
// It will occasionally catch someone who only sets their speed up 
// by a little bit.
// Still, in my opinion it was better than not checking at all.
// If anyone knows of a better way to do this, or knows how to
// get the value of a _client_ cvar, please mail me.
void() TeamFortress_CheckforCheats =
{
	local float tf, pf;
	local string st;
	local vector vplf, vf;

	self.nextthink = time + 2;

	if (self.owner.immune_to_check > time)
		return;

	if (self.owner.deadflag)
		return;

	// Make sure they're on the ground
	if (!(self.owner.flags & #FL_ONGROUND) || (self.velocity_z != 0))
		return;

	vplf = self.owner.velocity;

	makevectors(self.owner.angles);

	vf = v_forward;
	vf_z = 0;

	vf = normalize(vf);

	tf = (vplf_x * vf_x) + (vplf_y * vf_y);

//	tf = vlen(vplf);

//	pf = self.owner.maxfbspeed * 1.4;
	pf = self.owner.maxfbspeed + 100;

/*
	dprint("speeds:    ");
	st = ftos(tf);
	dprint("tf : ");
	dprint(st);
	dprint("    pf : ");
	st = ftos(pf);
	dprint(st);
	dprint("\n");
*/
	if (self.owner.tfstate & #TFSTATE_CANT_MOVE && (tf > 20))
	{
	 	// this player was obviously cheating, so don't let up on them!
	 	self.nextthink = time + 0.5;
	 	self.owner.cheat_level = self.owner.cheat_level + 600;

		#ifdef CHEAT_WARNINGS
			dprint(self.owner.netname);
			dprint(" is moving, when he should not\n");
		#endif
	}

	if (tf > pf)
	{
//		dprint("tf > bf\n");

//		pf = pf * 1.2;
		pf = pf + 100;

		if (tf > pf)
		{
			#ifdef CHEAT_WARNINGS
				dprint(self.owner.netname);
				dprint(" has had his speeds reset\n");
			#endif

			// this player was obviously cheating, so don't let up on them!
			self.nextthink = time + 2;

			self.owner.cheat_level = self.owner.cheat_level + 300;
		}
		else
		{
			#ifdef CHEAT_WARNINGS
				dprint(self.owner.netname);
				dprint(" has had his speeds cautiously reset\n");
			#endif

			// give the player a break, so it doesn't happen too often
			self.nextthink = time + 3;

			self.owner.cheat_level = self.owner.cheat_level + 150;
		}

		TeamFortress_SetSpeed(self.owner);
 	}

#ifdef COOP_MODE
	if (coop)
		return;	// don't worry about cheat checking in coop
#endif

	if (self.owner.cheat_level > 1200)
	{
		self.owner.cheat_level = 0;
		bprint2(#PRINT_MEDIUM, self.owner.netname, " has been kicked for cheating.\n");
		sprint(self.owner, #PRINT_HIGH, "You have been kicked for cheating, because of your speed.\n");
		stuffcmd(self.owner, "disconnect\n");
	}
};

//============================================================================
// sends a player to observer mode
void() PlayerObserverMode =
{
	self.current_menu = #MENU_DEFAULT;
	self.impulse = 0;
	self.playerclass = #PC_UNDEFINED;
	self.lives = 0;
	self.team_no = -1;

	self.flags = #FL_CLIENT | #FL_NOTARGET | #FL_ONGROUND;
	self.waterlevel = 3;
	self.takedamage = #DAMAGE_NO;
	self.solid = #SOLID_NOT;
	self.movetype = #MOVETYPE_NOCLIP;

#ifndef QUAKE_WORLD
	setmodel(self, string_null);
#endif

	sprint (self, #PRINT_HIGH, "Observer mode\n");
	CenterPrint(self, "\n");
	stuffcmd(self, "cl_rollangle 0\n");
};

//============================================================================
// Return the crossproduct of 2 vectors
float(vector veca, vector vecb) crossproduct =
{
	local float result;

	result = (veca_x * vecb_y) - (vecb_x * veca_y);
	return result;
};

