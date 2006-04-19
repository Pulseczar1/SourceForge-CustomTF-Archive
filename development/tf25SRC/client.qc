
// prototypes
void () W_WeaponFrame;
void() W_SetCurrentAmmo;
void() player_pain;
void() player_stand1;
void (vector org) spawn_tfog;
void (vector org, entity death_owner) spawn_tdeath;
float modelindex_eyes, modelindex_player, modelindex_null;
float(float v) anglemod;

// TeamFortress prototypes
void() TeamFortress_MOTD;
void() TeamFortress_CheckTeamCheats;
float(float tno) TeamFortress_TeamGetColor;
void(entity Viewer, float pc, float rpc) TeamFortress_PrintClassName;
void() TeamFortress_RemoveTimers;
void(float Suicided) TeamFortress_SetupRespawn;
void() TeamFortress_ShowTF;
float(float pc) IsLegalClass;
void() SetupTeamEqualiser;
#ifdef QUAKE_WORLD
void(entity p) SetTeamName;
#endif

// Hook prototypes
void () Service_Grapple;

// TeamFortressMap prototypes
void(entity AD) ParseTFDetect;
entity(float ino) Finditem;
void(entity Item, entity AP, entity Goal) tfgoalitem_GiveToPlayer;
void(entity Goal, entity AP, entity ActivatingGoal) AttemptToActivate;
void() CTF_FlagCheck;

/*
=============================================================================

				LEVEL CHANGING / INTERMISSION

=============================================================================
*/

string nextmap;

float	intermission_running;
float	intermission_exittime;

/*QUAKED info_intermission (1 0.5 0.5) (-16 -16 -16) (16 16 16)
This is the camera point for the intermission.
Use mangle instead of angle, so you can set pitch or roll as well as yaw.  'pitch roll yaw'
*/
void() info_intermission =
{
	if (CheckExistence() == #FALSE)
	{
		dremove(self);
		return;
	}
};


void() SetChangeParms =
{
	if (self.health <= 0)
 	{
 		SetNewParms ();
 		return;
 	}

	// remove items
	self.items = self.items - (self.items &	(#IT_KEY1 | #IT_KEY2 | #IT_INVISIBILITY | #IT_INVULNERABILITY | #IT_SUIT | #IT_QUAD) );
	
	// cap super health
	if (self.health > 100)
		self.health = 100;
	if (self.health < 50)
		self.health = 50;
	parm1 = self.items;
	parm2 = self.health;
	parm3 = self.armorvalue;
	if (self.ammo_shells < 25)
		parm4 = 25;
	else
		parm4 = self.ammo_shells;
	parm5 = self.ammo_nails;
	parm6 = self.ammo_rockets;
	parm7 = self.ammo_cells;
	parm8 = self.current_weapon;
	parm9 = self.armortype * 100;

	// TeamFortress Parameters
	parm10 = toggleflags;  // Store the global ToggleFlag settings
	parm11 = 0;   		   // Random Playerclass
	parm12 = 0;

#ifdef COOP_MODE
	if (toggleflags & #TFLAG_CLASS_PERSIST)
	{
		if (self.tfstate & #TFSTATE_RANDOMPC)
		{
			parm11 = (parm11 | #TFSTATE_RANDOMPC);
			self.playerclass = 1 + floor(random() * (#PC_RANDOM - 1));
			while(!IsLegalClass(self.playerclass))
				self.playerclass = 1 + floor(random() * (#PC_RANDOM - 1));
		}

		parm12 = self.playerclass;				// save the playerclass between levels in parm12
	}											// if the toggleflag CLASS_PERSIST is set
#endif

#ifdef STATUSBAR
	parm13 = self.StatusBarRes;
	parm14 = self.StatusBarSize;
#endif
};

void() SetNewParms =
{
	parm1 = 0;
	parm2 = 100;
	parm3 = 0;
	parm4 = 25;
	parm5 = 0;
	parm6 = 0;
	parm6 = 0;
	parm8 = 1;
	parm9 = 0;

	// TeamFortress Parameters
	parm10 = 0;
	parm11 = 0;
	parm12 = 0;
	parm13 = 0;
	parm14 = 0;
};

// This think kicks in 30 seconds into the map to
// turn autoteam on.
void() autoteam_think =
{
	toggleflags = toggleflags | #TFLAG_AUTOTEAM;
	dremove(self);
};

void() DecodeLevelParms =
{
	local string st;
	local entity ent;

	if (serverflags)
	{
		if (world.model == "maps/start.bsp")
			SetNewParms ();		// take away all stuff on starting new episode
	}
	
	self.items = parm1;
	self.health = parm2;
	self.armorvalue = parm3;
	self.ammo_shells = parm4;
	self.ammo_nails = parm5;
	self.ammo_rockets = parm6;
	self.ammo_cells = parm7;
	self.current_weapon = parm8;
	self.armortype = parm9 * 0.01;

	// TeamFortress Parameters
	// Detect whether this is the first entrance into a map
	if (toggleflags == 0)
	{
		toggleflags = parm10;
		allow_hook = 0;
		invis_only = #SPY_INVIS_ONLY;

		if (coop || !deathmatch)
			toggleflags = toggleflags | #TFLAG_CLASS_PERSIST;

		nextmap = mapname;

	#ifdef GRAPPLING_HOOK
		allow_hook = #TRUE;
	#endif

		// Is this a FortressMap?
		ent = find(world, classname, "info_tfdetect");
		if (ent != world)
		{
			// Turn on Teamplay
			if (teamplay == 0)
				cvar_set("teamplay","21?TeamFortress");

			// Parse the rest of the Detection details
			ParseTFDetect(ent);

			// If the number_of_teams wasn't set, then there's not TF
			// spawnpoints on this lvl... so guess at 4 teams.
			if (number_of_teams <= 0 || number_of_teams >= 5)
				number_of_teams = 4;
		}
		else
		{
			// Is this a CTF map?
			ent = find(world, classname, "info_player_team1");
			if ((ent != world) || (CTF_Map == #TRUE))
			{
				// Turn on CTF MAP
				CTF_Map = #TRUE;

				// Turn on Teamplay
				if (teamplay == 0)
					cvar_set("teamplay","21?TeamFortress");

				// Setup the CTF FlagCheck Timer
				ent = spawn();
				ent.nextthink = time + 30;
				ent.think = CTF_FlagCheck;

				number_of_teams = 2;
			}
			else // Normal map
			{
				number_of_teams = 4;
			}

			// Set speed limits
#ifndef QUAKE_WORLD
			cvar_set("sv_maxspeed", "500");
#endif
			// set aiming level
#ifndef NET_SERVER
			cvar_set("sv_aim", "1");
#endif
			// Set life limits
			team1lives = -1;
			team2lives = -1;
			team3lives = -1;
			team4lives = -1;
			// Set illegal playerclasses
			illegalclasses1 = 0;
			illegalclasses2 = 0;
			illegalclasses3 = 0;
			illegalclasses4 = 0;
			// Set Team Limits
			team1maxplayers = 100;
			team2maxplayers = 100;
			team3maxplayers = 100;
			team4maxplayers = 100;
			civilianteams = 0;
		}

		bprint (#PRINT_HIGH, "Mapname: ");
		bprint (#PRINT_HIGH, mapname);
		bprint (#PRINT_HIGH, "\n");

		SetupTeamEqualiser();

		if (#NEVER_TEAMFRAGS)
		{
			toggleflags = toggleflags - (toggleflags & #TFLAG_TEAMFRAGS);
		}
		
		if (#ALWAYS_TEAMFRAGS)
		{
			toggleflags = toggleflags | #TFLAG_TEAMFRAGS;
		}
		
		if (#CHECK_SPEEDS)
		{
			toggleflags = toggleflags | #TFLAG_CHEATCHECK;
		}

	#ifdef QUAKE_WORLD
		st = infokey(world, "temp1");
		toggleflags = (toggleflags | #TFLAG_FIRSTENTRY | stof(st));
	#else
		toggleflags = (toggleflags | #TFLAG_FIRSTENTRY | cvar("temp1"));
	#endif

		local float autoteam_time;
		autoteam_time = 30;

	#ifdef QUAKE_WORLD
		// check all serverinfo settings, to set the appropriate toggleflags
		local string st;

		// AUTOTEAM
		st = infokey(world, "a");
		if (st == string_null)
			st = infokey(world, "autoteam");
		if (st == "on")
			toggleflags = toggleflags | #TFLAG_AUTOTEAM;
		else if (st == "off")
			toggleflags = toggleflags - (toggleflags & #TFLAG_AUTOTEAM);
		else if (stof(st) != 0)
		{
			toggleflags = toggleflags | #TFLAG_AUTOTEAM;
			autoteam_time = stof(st);
		}

		// TEAMFRAGS
		st = infokey(world, "t");
		if (st == string_null)
			st = infokey(world, "teamfrags");
		if (st == "on")
			toggleflags = toggleflags | #TFLAG_TEAMFRAGS;
		else if (st == "off")
			toggleflags = toggleflags - (toggleflags & #TFLAG_TEAMFRAGS);

		// GRAPPLING HOOK
		st = infokey(world, "g");
		if (st == string_null)
			st = infokey(world, "grapple");
		if (st == "off")
			allow_hook = #FALSE;
		if (!(toggleflags & #TFLAG_GRAPPLE) && st != "on")
			allow_hook = #FALSE;

		// SPY OFF
		st = infokey(world, "spy");
		if (st == "off")
			spy_off = #TRUE;

		// SPY INVIS ONLY
		st = infokey(world, "s");
		if (st == string_null)
			st = infokey(world, "spyinvis");
		if (st == "on" || toggleflags & #TFLAG_SPYINVIS)
			invis_only = #TRUE;
		else if (st == "off")
			invis_only = #FALSE;

		// RespawnDelay
		st = infokey(world, "rd");
		if (st == string_null)
			st = infokey(world, "respawn_delay");
		respawn_delay_time = stof(st);
		if (respawn_delay_time)
			toggleflags = toggleflags | #TFLAG_RESPAWNDELAY;
	#else
		// GRAPPLING HOOK
		if (!(toggleflags & #TFLAG_GRAPPLE) && (CTF_Map == #FALSE))
			allow_hook = #FALSE;
	#endif

		// If no Respawndelay has been specified, set the default
		if (toggleflags & #TFLAG_RESPAWNDELAY && respawn_delay_time == 0)
			respawn_delay_time = #RESPAWN_DELAY_TIME;

		// Prevent autoteam from kicking in for 30 seconds.
		// Allows restructuring of the teams from the last map nicely.
		if (toggleflags & #TFLAG_AUTOTEAM)
		{
			toggleflags = toggleflags - (toggleflags & #TFLAG_AUTOTEAM);
			ent = spawn();
			ent.nextthink = time + autoteam_time;
			ent.think = autoteam_think;
		}
	}

	if (parm11)
		self.tfstate = parm11;
	if (self.playerclass == 0)
		self.playerclass = parm12;

#ifdef STATUSBAR
	if (parm13)
		self.StatusBarRes = parm13;
	if (parm14)
		self.StatusBarSize = parm14;
#endif
};

/*
============
FindIntermission

Returns the entity to view from
============
*/
entity() FindIntermission =
{
	local	entity spot;
	local	float cyc;

	// look for info_intermission first
	spot = find (world, classname, "info_intermission");
	if (spot)
	{	// pick a random one
		cyc = random() * 1;

		// Following removed for the observer code
		/*while (cyc > 1)
		{
			spot = find (spot, classname, "info_intermission");
			if (!spot)
				spot = find (spot, classname, "info_intermission");
			cyc = cyc - 1;
		}*/

		return spot;
	}

// then look for the start position
	spot = find (world, classname, "info_player_start");
	if (spot)
		return spot;

// then look through the deathmatch starts
	spot = find (world, classname, "info_player_deathmatch");
	if (spot)
	{	
		// pick a random one
		cyc = random() * 6;
		while (cyc > 1)
		{
			spot = find (spot, classname, "info_player_deathmatch");
			if (!spot)
				spot = find (spot, classname, "info_player_deathmatch");
			cyc = cyc - 1;
		}
		return spot;
	}
	
	
	objerror ("FindIntermission: no spot");
};

/*===========================
FindNextIntermission

returns the next intermission point
===========================*/
entity (entity start_point) FindNextIntermission =
{
	local	entity spot;
	local	float cyc;

	if (deathmatch)
	{
	// look through info_intermission first
		if (start_point.classname == "info_intermission" || start_point == world)
		{
			spot = find (start_point, classname, "info_intermission");
			if (spot)
				return spot;
			else
				start_point = world;
		}


	// then look through the deathmatch starts
		if (start_point.classname == "info_player_deathmatch" || start_point == world)
		{
			spot = find (start_point, classname, "info_player_deathmatch");
			if (spot)
				return spot;
		}

		// at the end of the list
		spot = find (world, classname, "info_intermission");
		if (spot)
			return spot;

		spot = find (world, classname, "info_player_deathmatch");
		if (spot)
			return spot;
	}
	else // do not cycle though in co-op or single
	{
		spot = find (world, classname, "info_player_start");
		if (spot)
			return spot;
	}

	// it should never reach this point
	return FindIntermission();
	
};


/*==================================================

TF_MovePlayer
Moves the player to another intermission viewpoint

====================================================*/

void() TF_MovePlayer =
{
	local entity place;

	place = FindNextIntermission(self.observer_list);

	self.observer_list = place;

	setorigin(self, place.origin + '0 0 1');
	self.angles = place.angles;
	self.fixangle = #TRUE;		// turn this way immediately

};

void() GotoNextMap =
{
	local float nextlevel;
	local string sl;
	local entity te;

	if (nextmap != mapname)
	{
		changelevel(nextmap);
		already_chosen_map = #TRUE;
	}

	// new map cycling code
	if (!already_chosen_map)
	{
	#ifdef QUAKE_WORLD
		sl = infokey(world, "n");
		nextlevel = stof(sl);
	#else
		nextlevel = cvar("samelevel");
	#endif

		nextlevel = nextlevel + 1;  // next level
		sl = ftos(nextlevel);
	#ifdef QUAKE_WORLD
		localcmd("serverinfo n ");
		localcmd(sl);
		localcmd("\n");
	#else
		cvar_set("samelevel", sl);
	#endif
			
		// change map
		#ifdef QUAKE_WORLD
			localcmd("exec qwmcycle/map");
		#else
			localcmd("exec mcycle/map");
		#endif

		localcmd(sl);
		localcmd(".cfg\n");

		already_chosen_map = #TRUE;
	}


#ifdef QUAKE_WORLD
	if (infokey(world, "n") == "0")
#else
	if (cvar("samelevel") == 0)
#endif
		already_chosen_map = #FALSE;
};


void() ExitIntermission =
{
	dprint("Exiting intermission...\n");
// skip any text in deathmatch
	if (deathmatch)
	{
		dprint("Exit Intermission in Deathmatch.\n");
		GotoNextMap ();
		return;
	}
	
	intermission_exittime = time + 1;
	intermission_running = intermission_running + 1;

//
// run some text if at the end of an episode
//
	if (intermission_running == 2)
	{
		if (world.model == "maps/e1m7.bsp")
		{
			WriteByte (#MSG_ALL, #SVC_CDTRACK);
			WriteByte (#MSG_ALL, 2);
			WriteByte (#MSG_ALL, 3);
			if (!cvar("registered"))
			{
				WriteByte (#MSG_ALL, #SVC_FINALE);
				WriteString (#MSG_ALL, "As the corpse of the monstrous entity\nChthon sinks back into the lava whence\nit rose, you grip the Rune of Earth\nMagic tightly. Now that you have\nconquered the Dimension of the Doomed,\nrealm of Earth Magic, you are ready to\ncomplete your task in the other three\nhaunted lands of Quake. Or are you? If\nyou don't register Quake, you'll never\nknow what awaits you in the Realm of\nBlack Magic, the Netherworld, and the\nElder World!");
			}
			else
			{
				WriteByte (#MSG_ALL, #SVC_FINALE);
				WriteString (#MSG_ALL, "As the corpse of the monstrous entity\nChthon sinks back into the lava whence\nit rose, you grip the Rune of Earth\nMagic tightly. Now that you have\nconquered the Dimension of the Doomed,\nrealm of Earth Magic, you are ready to\ncomplete your task. A Rune of magic\npower lies at the end of each haunted\nland of Quake. Go forth, seek the\ntotality of the four Runes!");
			}
			return;
		}
		else if (world.model == "maps/e2m6.bsp")
		{
			WriteByte (#MSG_ALL, #SVC_CDTRACK);
			WriteByte (#MSG_ALL, 2);
			WriteByte (#MSG_ALL, 3);

			WriteByte (#MSG_ALL, #SVC_FINALE);
			WriteString (#MSG_ALL, "The Rune of Black Magic throbs evilly in\nyour hand and whispers dark thoughts\ninto your brain. You learn the inmost\nlore of the Hell-Mother; Shub-Niggurath!\nYou now know that she is behind all the\nterrible plotting which has led to so\nmuch death and horror. But she is not\ninviolate! Armed with this Rune, you\nrealize that once all four Runes are\ncombined, the gate to Shub-Niggurath's\nPit will open, and you can face the\nWitch-Goddess herself in her frightful\notherworld cathedral.");
			return;
		}
		else if (world.model == "maps/e3m6.bsp")
		{
			WriteByte (#MSG_ALL, #SVC_CDTRACK);
			WriteByte (#MSG_ALL, 2);
			WriteByte (#MSG_ALL, 3);

			WriteByte (#MSG_ALL, #SVC_FINALE);
			WriteString (#MSG_ALL, "The charred viscera of diabolic horrors\nbubble viscously as you seize the Rune\nof Hell Magic. Its heat scorches your\nhand, and its terrible secrets blight\nyour mind. Gathering the shreds of your\ncourage, you shake the devil's shackles\nfrom your soul, and become ever more\nhard and determined to destroy the\nhideous creatures whose mere existence\nthreatens the souls and psyches of all\nthe population of Earth.");
			return;
		}
		else if (world.model == "maps/e4m7.bsp")
		{
			WriteByte (#MSG_ALL, #SVC_CDTRACK);
			WriteByte (#MSG_ALL, 2);
			WriteByte (#MSG_ALL, 3);

			WriteByte (#MSG_ALL, #SVC_FINALE);
			WriteString (#MSG_ALL, "Despite the awful might of the Elder\nWorld, you have achieved the Rune of\nElder Magic, capstone of all types of\narcane wisdom. Beyond good and evil,\nbeyond life and death, the Rune\npulsates, heavy with import. Patient and\npotent, the Elder Being Shub-Niggurath\nweaves her dire plans to clear off all\nlife from the Earth, and bring her own\nfoul offspring to our world! For all the\ndwellers in these nightmare dimensions\nare her descendants! Once all Runes of\nmagic power are united, the energy\nbehind them will blast open the Gateway\nto Shub-Niggurath, and you can travel\nthere to foil the Hell-Mother's plots\nin person.");
			return;
		}

		GotoNextMap();
	}
	
	if (intermission_running == 3)
	{
		if (!cvar("registered"))
		{	// shareware episode has been completed, go to sell screen
			WriteByte (#MSG_ALL, #SVC_SELLSCREEN);
			return;
		}
		
		if ( (serverflags&15) == 15)
		{
			WriteByte (#MSG_ALL, #SVC_FINALE);
			WriteString (#MSG_ALL, "Now, you have all four Runes. You sense\ntremendous invisible forces moving to\nunseal ancient barriers. Shub-Niggurath\nhad hoped to use the Runes Herself to\nclear off the Earth, but now instead,\nyou will use them to enter her home and\nconfront her as an avatar of avenging\nEarth-life. If you defeat her, you will\nbe remembered forever as the savior of\nthe planet. If she conquers, it will be\nas if you had never been born.");
			return;
		}
		
	}

	dprint("Exit Intermission.\n");
	GotoNextMap();
};

/*
============
IntermissionThink

When the player presses attack or jump, change to the next level
============
*/
void() IntermissionThink =
{
	if (time < intermission_exittime)
		return;

	if (!self.button0 && !self.button1 && !self.button2)
		return;
	
#ifdef QUAKE_WORLD
	dprint("Intermission think.\n");
	GotoNextMap();
#else
	ExitIntermission ();
#endif
};

#ifndef QUAKE_WORLD
void() execute_changelevel =
{
	local entity	pos;

	intermission_running = 1;
	
// enforce a wait time before allowing changelevel
	if (deathmatch)
		intermission_exittime = time + 5;
	else
		intermission_exittime = time + 2;

	WriteByte (#MSG_ALL, #SVC_CDTRACK);
	WriteByte (#MSG_ALL, 3);
	WriteByte (#MSG_ALL, 3);
	
	pos = FindIntermission ();

	other = find (world, classname, "player");
	while (other != world)
	{
		other.view_ofs = '0 0 0';
		other.angles = other.v_angle = pos.mangle;
		other.fixangle = #TRUE;		// turn this way immediately
		other.nextthink = time + 0.5;
		other.takedamage = #DAMAGE_NO;
		other.solid = #SOLID_NOT;
		other.movetype = #MOVETYPE_NONE;
		other.modelindex = 0;
		setorigin (other, pos.origin);
		other = find (other, classname, "player");
	}	

	WriteByte (#MSG_ALL, #SVC_INTERMISSION);
};

#else

void() execute_changelevel =
{
	local entity	pos;
	dprint("execute_changelevel()\n");

	intermission_running = 1;
	
	// enforce a wait time before allowing changelevel
	intermission_exittime = time + 5;

	pos = FindIntermission ();

	// play intermission music
	WriteByte (#MSG_ALL, #SVC_CDTRACK);
	WriteByte (#MSG_ALL, 3);

	WriteByte (#MSG_ALL, #SVC_INTERMISSION);
	WriteCoord (#MSG_ALL, pos.origin_x);
	WriteCoord (#MSG_ALL, pos.origin_y);
	WriteCoord (#MSG_ALL, pos.origin_z);
	WriteAngle (#MSG_ALL, pos.mangle_x);
	WriteAngle (#MSG_ALL, pos.mangle_y);
	WriteAngle (#MSG_ALL, pos.mangle_z);
	
	other = find (world, classname, "player");
	while (other != world)
	{
		other.takedamage = #DAMAGE_NO;
		other.solid = #SOLID_NOT;
		other.movetype = #MOVETYPE_NONE;
		other.modelindex = 0;
		other = find (other, classname, "player");
	}	

};
#endif

void() changelevel_touch =
{
	local entity pos;
	local float ne;
	local string st;

	if (other.classname != "player")
		return;

#ifndef QUAKE_WORLD
    if ((cvar("noexit") == 1) || ((cvar("noexit") == 2) && (mapname != "start")))
	{
		T_Damage (other, self, self, 50000);
		return;
	}
#else
	if (cvar("samelevel") == 2 || (cvar("samelevel") == 3 && mapname != "start"))
		return;
#endif

	bprint (#PRINT_HIGH, other.netname);
	bprint (#PRINT_HIGH, " exited the level\n");

	nextmap = self.map;

	SUB_UseTargets ();

	if ( (self.spawnflags & 1) && (deathmatch == 0) )
	{	// NO_INTERMISSION
		GotoNextMap();
		return;
	}
	
	self.touch = SUB_Null;

	// we can't move people right now, because touch functions are called
	// in the middle of C movement code, so set a think time to do it
	self.think = execute_changelevel;
	self.nextthink = time + 0.1;
};

/*QUAKED trigger_changelevel (0.5 0.5 0.5) ? NO_INTERMISSION
When the player touches this, he gets sent to the map listed in the "map" variable.  Unless the NO_INTERMISSION flag is set, the view will go to the info_intermission spot and display stats.
*/
void() trigger_changelevel =
{
	if (CheckExistence() == #FALSE)
	{
		dremove(self);
		return;
	}

	if (!self.map)
		objerror ("changelevel trigger doesn't have map");
	
	InitTrigger ();
	self.touch = changelevel_touch;
};


/*
=============================================================================

				PLAYER GAME EDGE FUNCTIONS

=============================================================================
*/

void() set_suicide_frame;

// called by ClientKill and DeadThink
void() respawn =
{
	if (coop)
	{
		// make a copy of the dead body for appearances sake
		CopyToBodyQue (self);
		// get the spawn parms as they were at level start
		setspawnparms (self);
		// respawn		
		PutClientInServer ();
	}
	else if (deathmatch)
	{
		// make a copy of the dead body for appearances sake
		CopyToBodyQue (self);
		// set default spawn parms
		SetNewParms ();
		// respawn		
		PutClientInServer ();
	}
	else
	{	// restart the entire server
		localcmd ("restart\n");
	}
};

/*
============
ClientKill

Player entered the suicide command
============
*/
void() ClientKill =
{
	local entity te;

	if (self.suicide_time > time)
		return;

	if (self.deadflag)
		return;

	// players can't suicide again for 10 seconds
	self.suicide_time = time + 5 + (random() * 5);

	bprint (#PRINT_MEDIUM, self.netname);
	bprint (#PRINT_MEDIUM, " suicides\n");

	set_suicide_frame();
	self.modelindex = modelindex_player;

	// If infected, give the medic a frag
	if (self.tfstate & #TFSTATE_INFECTED)
	{
		te = find(world, classname, "timer");
		while (te)
		{
			if (te.owner == self && te.think == BioInfection_Decay)
			{
			#ifdef QUAKE_WORLD
				logfrag(te, self);
			#endif
				te.enemy.real_frags = te.enemy.real_frags + 1;
			 	if (!(toggleflags & #TFLAG_TEAMFRAGS))
					te.enemy.frags = te.enemy.real_frags;
			}

			te = find(te, classname, "timer");
		}
	}
#ifdef QUAKE_WORLD
	else 
		logfrag (self, self);
#endif

	self.real_frags = self.real_frags - 1;
 	if (!(toggleflags & #TFLAG_TEAMFRAGS))
		self.frags = self.real_frags;

	self.weaponmodel= "";
	self.view_ofs = '0 0 -8';
	self.movetype = #MOVETYPE_NONE;

	// Remove all timers for this player
	TeamFortress_RemoveTimers();
	TeamFortress_SetupRespawn(#TRUE);

	self.health = -1;
	self.th_die();
	self.deadflag = #DEAD_RESPAWNABLE;
	self.tfstate = self.tfstate | #TFSTATE_RESPAWN_READY;
//	self.respawn_time = time;
};

////////////////////////////////////
// FindTeamSpawnPoint
//////////
entity lastspawn_team1;
entity lastspawn_team2;
entity lastspawn_team3;
entity lastspawn_team4;

entity(float team_num) FindTeamSpawnPoint =
{
	local entity spot;
	local entity at_spot;
	local float spot_found;
	local float attempts;

	if (team_num == 1)
	{
		spot = lastspawn_team1;

		attempts = 0;
		// search through until found or end-of-list
		while (1)
		{
			attempts = attempts + 1;

			spot = find(spot, team_str_home, "ts1");

			if (spot == world)
				spot = find(world, team_str_home, "ts1");

			if (spot == world)
				return world;
		
			at_spot = findradius(spot.origin, 40);
			spot_found = #TRUE;

			while (at_spot != world)
			{
				if (at_spot.classname == "player" && at_spot.deadflag == #DEAD_NO)
				{
					spot_found = #FALSE;					
				}	
				
				at_spot = at_spot.chain;			
			}

			// Check the Criteria of the spawnpoint
			if (!Activated(spot, self))
				spot_found = #FALSE;

			if ((spot_found) || (attempts >= 30))
			{
				lastspawn_team1 = spot;
				return spot;
			}
		}

	}
	else if (team_num == 2)
	{
		spot = lastspawn_team2;

		attempts = 0;
		// search through until found or end-of-list
		while (1)
		{
			attempts = attempts + 1;

			spot = find(spot, team_str_home, "ts2");

			if (spot == world)
				spot = find(world, team_str_home, "ts2");

			if (spot == world)
				return world;
		
			at_spot = findradius(spot.origin, 40);
			spot_found = #TRUE;

			while (at_spot != world)
			{
				if (at_spot.classname == "player" && at_spot.deadflag == #DEAD_NO)
				{
					spot_found = #FALSE;					
				}	
				
				at_spot = at_spot.chain;			
			}

			// Check the Criteria of the spawnpoint
			if (!Activated(spot, self))
				spot_found = #FALSE;

			if ((spot_found) || (attempts >= 30))
			{
				lastspawn_team2 = spot;
				return spot;
			}
		}
	}
	else if (team_num == 3)
	{
		spot = lastspawn_team3;

		attempts = 0;
		// search through until found or end-of-list
		while (1)
		{
			attempts = attempts + 1;

			spot = find(spot, team_str_home, "ts3");

			if (spot == world)
				spot = find(world, team_str_home, "ts3");

			if (spot == world)
				return world;
		
			at_spot = findradius(spot.origin, 40);
			spot_found = #TRUE;

			while (at_spot != world)
			{
				if (at_spot.classname == "player" && at_spot.deadflag == #DEAD_NO)
				{
					spot_found = #FALSE;					
				}	
				
				at_spot = at_spot.chain;			
			}

			// Check the Criteria of the spawnpoint
			if (!Activated(spot, self))
				spot_found = #FALSE;

			if ((spot_found) || (attempts >= 30))
			{
				lastspawn_team3 = spot;
				return spot;
			}
		}
	}
	else if (team_num == 4)
	{
		spot = lastspawn_team4;

		attempts = 0;
		// search through until found or end-of-list
		while (1)
		{
			attempts = attempts + 1;

			spot = find(spot, team_str_home, "ts4");

			if (spot == world)
				spot = find(world, team_str_home, "ts4");

			if (spot == world)
				return world;
		
			at_spot = findradius(spot.origin, 40);
			spot_found = #TRUE;

			while (at_spot != world)
			{
				if (at_spot.classname == "player" && at_spot.deadflag == #DEAD_NO)
				{
					spot_found = #FALSE;					
				}	
				
				at_spot = at_spot.chain;			
			}

			// Check the Criteria of the spawnpoint
			if (!Activated(spot, self))
				spot_found = #FALSE;

			if ((spot_found) || (attempts >= 30))
			{
				lastspawn_team4 = spot;
				return spot;
			}
		}
	}

	// failure
	return world;
};

#ifdef QUAKE_WORLD
float(entity e) ValidateUser =
{
/*
local string	s;
	local string	userclan;
	local float	rank, rankmin, rankmax;

//
// if the server has set "clan1" and "clan2", then it
// is a clan match that will allow only those two clans in
//
	s = serverinfo("clan1");
	if (s)
	{
		userclan = masterinfo(e,"clan");
		if (s == userclan)
			return true;
		s = serverinfo("clan2");
		if (s == userclan)
			return true;
		return false;
	}

//
// if the server has set "rankmin" and/or "rankmax" then
// the users rank must be between those two values
//
	s = masterinfo (e, "rank");
	rank = stof (s);

	s = serverinfo("rankmin");
	if (s)
	{
		rankmin = stof (s);
		if (rank < rankmin)
			return false;
	}
	s = serverinfo("rankmax");
	if (s)
	{
		rankmax = stof (s);
		if (rankmax < rank)
			return false;
	}

	return true;
*/

};
#endif

/*
============
SelectSpawnPoint

Returns the entity to spawn at
============
*/
entity() SelectSpawnPoint =
{
	local	entity spot;
	local 	entity at_spot;
	local 	float  spot_found;
	local   float  attempts;
	
	// testinfo_player_start is only found in regioned levels
	/*
	spot = find (world, classname, "testplayerstart");
	if (spot)
		return spot;
	*/

	// If FortressMap option is on, we want to make the player spawn on a 
	// spawnpoint marked as being one for his/her team.
	// The team that owns a spawnpoint is kept in the spawnpoints's teamno
	if (self.team_no != 0)
	{
		spot = FindTeamSpawnPoint(self.team_no);
		if (spot != world)
			return spot;

		// failure to find a team spawn point for that player
		// just move on
	}

	// choose a info_player_deathmatch point
	if (coop)
	{ 
		lastspawn = find(lastspawn, classname, "info_player_coop");
		if (lastspawn == world)
            lastspawn = find (world, classname, "info_player_coop");
                
        if (lastspawn != world)
        	return lastspawn;
	}
	else if (deathmatch)
	{
		// search through
		spot = find(lastspawn, classname, "info_player_deathmatch");
		if (spot == world)
			spot = find(world, classname, "info_player_deathmatch");

		attempts = 0;
		while (spot != world && attempts < 100)
		{
			attempts = attempts + 1;

			// reject spot if other players are found at point
			at_spot = findradius(spot.origin, 40);
			spot_found = #TRUE;
			while (at_spot)
			{
				if (at_spot.classname == "player" && at_spot.deadflag == #DEAD_NO)
				{
					spot_found = #FALSE;					
				}	
				
				at_spot = at_spot.chain;			
			}

			// Make sure we don't get locked by people standing on all
			// the spawnpoints.
			if ((spot_found) || (attempts >= 10))
			{
				lastspawn = spot;
				return spot;
			}
			
			spot = find(spot, classname, "info_player_deathmatch");	
			
			if (spot == world)
				spot = find(world, classname, "info_player_deathmatch");
		}
	}

	if (serverflags)
	{	// return with a rune to start
		spot = find (world, classname, "info_player_start2");
		if (spot)
			return spot;
	}
	
	spot = find (world, classname, "info_player_start");
	if (!spot)
		error ("PutClientInServer: no info_player_start on level\n");
	
	return spot;
};

/*
===========
PutClientInServer

called each time a player is spawned
============
*/
void() DecodeLevelParms;
void() PlayerDie;
void() TeamFortress_SetHealth;
void() TeamFortress_SetEquipment;
void() player_touch;
void(entity p) TeamFortress_SetSpeed;
void(entity p) TeamFortress_SetSkin;

void() PutClientInServer =
{
	local string st;
	local float iszoom, oldclass;
	local entity spot, te;

	self.touch = player_touch;
	self.classname = "player";
	self.health = 100;
	self.takedamage = #DAMAGE_AIM;
	self.solid = #SOLID_SLIDEBOX;
	self.movetype = #MOVETYPE_WALK;
	self.show_hostile = 0;
	self.FlashTime = 0;
	self.max_health = 100;
	self.flags = #FL_CLIENT;
	self.air_finished = time + 12;
	self.dmg = 2;   		// initial water damage
	self.super_damage_finished = 0;
	self.radsuit_finished = 0;
	self.invisible_finished = 0;
	self.invincible_finished = 0;
	self.effects = 0;
	self.invincible_time = 0;

	self.reload_shotgun = 0;
	self.reload_super_shotgun = 0;
	self.reload_grenade_launcher = 0;
	self.reload_rocket_launcher = 0;

	self.immune_to_check = time + 5;

    // grapple stuff
    self.on_hook = #FALSE;
    self.hook_out = #FALSE;
    self.fire_held_down = #FALSE;

	DecodeLevelParms ();

#ifdef COOP_MODE
	// Force all players to be on the same team in Coop mode
	if (coop)
	{
		teamplay = 21;
		cvar_set("teamplay", "21?TeamFortress");
		TeamFortress_TeamSet(1);
	}
#endif

	// Set the Civilian Class of anyone in a Civilian Team
	if (self.playerclass == #PC_UNDEFINED)
	{
		if (TeamFortress_TeamIsCivilian(self.team_no))
		{
			self.impulse = 1;
			TeamFortress_ChangeClass();
		}
	}

	// For players who've changed their classes in deathmatch 3, 
	// their class may be PC_RANDOM, in which case we set the toggleflag
	if ((deathmatch == 3) && (self.nextpc != 0))
	{
		self.playerclass = self.nextpc;

		if (self.nextpc == #PC_RANDOM)
			self.tfstate = self.tfstate | #TFSTATE_RANDOMPC;
		else
			self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_RANDOMPC);
	}

	// some states are kept
	iszoom = 0;

	if (self.tfstate & #TFSTATE_ZOOMOFF)
		iszoom = 1;

	// Reset all tfstate flags, except for RANDOMPC
	if (self.tfstate & #TFSTATE_RANDOMPC)
	{
		oldclass = self.playerclass;
		self.playerclass = 1 + floor(random() * (#PC_RANDOM - 1));
		while(!IsLegalClass(self.playerclass) || (self.playerclass == oldclass))
			self.playerclass = 1 + floor(random() * (#PC_RANDOM - 1));
		self.tfstate = #TFSTATE_RANDOMPC;
	}
	else
		self.tfstate = 0;

	if (iszoom == 1)
		self.tfstate = self.tfstate | #TFSTATE_ZOOMOFF;

	// If they're not an engineer, remove any buildings they own
	if (self.playerclass != #PC_ENGINEER)
	{
		te = find(world, classname, "building_dispenser");
		while (te)
		{
			if (te.real_owner == self)
				TF_T_Damage(te, world, world, 500, 0, 0);

			te = find(te, classname, "building_dispenser");
		}

		te = find(world, classname, "building_sentrygun");
		while (te)
		{
			if (te.real_owner == self)
				TF_T_Damage(te, world, world, 500, 0, 0);

			te = find(te, classname, "building_sentrygun");
		}
	}

	// Display the Player's Class
	TeamFortress_PrintClassName(self,self.playerclass, (self.tfstate & #TFSTATE_RANDOMPC));
	// Set the weapons and ammo for the player based on class
	TeamFortress_SetEquipment();
	// Set the health for the player based on class
	TeamFortress_SetHealth();
	// Set the speed for the player based on class
	TeamFortress_SetSpeed(self);
	// Set the skin for the player based on class
	TeamFortress_SetSkin(self);
	stuffcmd(self, "v_idlescale 0\n");
	stuffcmd(self, "v_cshift 0 0 0 0\n");

#ifdef QUAKE_WORLD
	SetTeamName(self);
#endif

	W_SetCurrentAmmo ();

	self.attack_finished = time + 0.3;

	self.th_pain = player_pain;
	self.th_die = PlayerDie;

	// make sure that autozoom is reset
	if (self.height != 0)
	{
		self.height = 0;
		TF_zoom(90);
	}
		
	self.deadflag = #DEAD_NO;
	// pausetime is set by teleporters to keep the player from moving a while
	self.pausetime = 0;
	
	spot = SelectSpawnPoint ();

	if (self.playerclass != #PC_UNDEFINED)
		spawn_tdeath (spot.origin, self);

	self.observer_list = spot;
	self.origin = spot.origin + '0 0 1';
	self.angles = spot.angles;
	self.fixangle = #TRUE;		// turn this way immediately

#ifdef MAP_DEBUG
	dprint(self.netname);
	dprint(" spawned at a ");
	dprint(spot.classname);
	if (spot.team_no != 0)
	{
		dprint(", team_no of ");
		st = ftos(spot.team_no);
		dprint(st);
	}
	dprint("\n");
#endif

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

		// Display teamspawn message
		if (spot.message)
		{
			CenterPrint(self, spot.message);

			if (!(spot.goal_activation & #TFSP_MULTIPLEMSGS))
				spot.message = string_null;
		}

		// Activate a Goal if needed
		if (spot.activate_goal_no != 0)
		{
			te = Findgoal(spot.activate_goal_no);
			if (te)
				AttemptToActivate(te, self, spot);
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

#ifdef QUAKE_WORLD
	setmodel (self, string_null);
	modelindex_null = self.modelindex;
#endif

	setmodel (self, "progs/eyes.mdl");
	modelindex_eyes = self.modelindex;

	setmodel (self, "progs/player.mdl");
	modelindex_player = self.modelindex;

	if (self.playerclass == #PC_UNDEFINED)
	{
#ifdef QUAKE_WORLD
		self.modelindex = modelindex_null;
#else
		setmodel(self, string_null);
#endif
		self.current_menu = 1;
	}

	setsize (self, #VEC_HULL_MIN, #VEC_HULL_MAX);
	
	self.view_ofs = '0 0 22';

	player_stand1 ();

	if (deathmatch || coop)
	{
		makevectors(self.angles);
		if (self.playerclass != #PC_UNDEFINED)
			spawn_tfog (self.origin + v_forward*20);
	}

#ifdef QUAKE_WORLD
	// Set Rocket Jump Modifiers
	if (stof(infokey(world, "rj")) != 0)
		rj = stof(infokey(world, "rj"));
	else
		rj = 1;
#endif
};


/*
=============================================================================

				QUAKED FUNCTIONS

=============================================================================
*/


/*QUAKED info_player_start (1 0 0) (-16 -16 -24) (16 16 24)
The normal starting point for a level.
*/
void() info_player_start =
{
	if (CheckExistence() == #FALSE)
	{
		dremove(self);
		return;
	}
};


/*QUAKED info_player_start2 (1 0 0) (-16 -16 -24) (16 16 24)
Only used on start map for the return point from an episode.
*/
void() info_player_start2 =
{
	if (CheckExistence() == #FALSE)
	{
		dremove(self);
		return;
	}
};


/*
saved out by quaked in region mode
*/
void() testplayerstart =
{
	if (CheckExistence() == #FALSE)
	{
		dremove(self);
		return;
	}

};

/*QUAKED info_player_deathmatch (1 0 1) (-16 -16 -24) (16 16 24)
potential spawning position for deathmatch games
*/
void() info_player_deathmatch =
{
	if (CheckExistence() == #FALSE)
	{
		dremove(self);
		return;
	}
};

/*QUAKED info_player_coop (1 0 1) (-16 -16 -24) (16 16 24)
potential spawning position for coop games
*/
void() info_player_coop =
{
	if (CheckExistence() == #FALSE)
	{
		dremove(self);
		return;
	}
};

/*
===============================================================================

RULES

===============================================================================
*/

void(entity c) PrintClientScore =
{
	if (c.frags > -10 && c.frags < 0)
		bprint (#PRINT_MEDIUM, " ");
	else if (c.frags >= 0)
	{
		if (c.frags < 100)
			bprint (#PRINT_MEDIUM, " ");
		if (c.frags < 10)
			bprint (#PRINT_MEDIUM, " ");
	}
	bprint (#PRINT_MEDIUM, ftos(c.frags));
	bprint (#PRINT_MEDIUM, " ");
	bprint (#PRINT_MEDIUM, c.netname);
	bprint (#PRINT_MEDIUM, "\n");
};

void() DumpScore =
{
	local entity	e, sort, walk;

	if (world.chain)
		error ("DumpScore: world.chain is set");

// build a sorted lis
	e = find(world, classname, "player");
	sort = world;
	while (e)
	{
		if (!sort)
		{
			sort = e;
			e.chain = world;
		}
		else
		{
			if (e.frags > sort.frags)
			{
				e.chain = sort;
				sort = e;
			}
			else
			{
				walk = sort;
				do
				{
					if (!walk.chain)
					{
						e.chain = world;
						walk.chain = e;
					}
					else if (walk.chain.frags < e.frags)
					{
						e.chain = walk.chain;
						walk.chain = e;
					}
					else
						walk = walk.chain;
				} while (walk.chain != e);
			}
		}
		
		e = find(e, classname, "player");
	}

// print the list
	
	bprint (#PRINT_MEDIUM, "\n");	
	while (sort)
	{
		PrintClientScore (sort);
		sort = sort.chain;
	}
	bprint (#PRINT_MEDIUM, "\n");
};

/*
go to the next level for deathmatch
*/
float already_cycled;

void() NextLevel =
{
	local entity o;
	local string st;
	
	if (already_cycled)
		return;

	already_cycled = #TRUE;

	o = spawn();
	o.map = nextmap;
	o.think = execute_changelevel;
	o.nextthink = time + 0.1;
};

/*
============
CheckRules

Exit deathmatch games upon conditions
============
*/
void() CheckRules =
{
	if (timelimit && time >= timelimit)
		NextLevel ();
	else if (fraglimit && self.frags >= fraglimit)
		NextLevel ();
};

//============================================================================

void() PlayerDeathThink =
{
	local entity	old_self;
	local float		forward;

	if ((self.flags & #FL_ONGROUND))
	{
		forward = vlen (self.velocity);
		forward = forward - 20;
		if (forward <= 0)
			self.velocity = '0 0 0';
		else	
			self.velocity = forward * normalize(self.velocity);
	}

	// wait for all buttons released
	if (self.deadflag == #DEAD_DEAD)
	{
		if (self.button2 || self.button1 || self.button0)
			return;
		self.deadflag = #DEAD_RESPAWNABLE;
		// make sure that respawn flag has not been set
		self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_RESPAWN_READY);
		return;
	}

	// wait for any button down
	if (!self.button2 && !self.button1 && !self.button0)
	{
		// if no buttons, but respawn_ready flag is set, respawn
		if (self.tfstate & #TFSTATE_RESPAWN_READY)
		{
			if (self.respawn_time <= time)
			{
				self.button0 = 0;
				self.button1 = 0;
				self.button2 = 0;
				respawn();
			}
		}
		return;
	}
	else
	{
		// button has been pressed, player is ready to respawn
		self.tfstate = self.tfstate | #TFSTATE_RESPAWN_READY;

		if (self.respawn_time <= time)
		{
			self.button0 = 0;
			self.button1 = 0;
			self.button2 = 0;
			respawn();
		}
		return;
	}
};

void() PlayerJump =
{
	local vector start, end;
	
	if (self.flags & #FL_WATERJUMP)
		return;
	
	if (self.waterlevel >= 2)
	{
		if (self.watertype == #CONTENT_WATER)
			self.velocity_z = 100;
		else if (self.watertype == #CONTENT_SLIME)
			self.velocity_z = 80;
		else
			self.velocity_z = 50;

// play swiming sound
		if (self.swim_flag < time)
		{
			self.swim_flag = time + 1;
			if (random() < 0.5)
				sound (self, #CHAN_BODY, "misc/water1.wav", 1, #ATTN_NORM);
			else
				sound (self, #CHAN_BODY, "misc/water2.wav", 1, #ATTN_NORM);
		}

		return;
	}

	if (!(self.flags & #FL_ONGROUND))
		return;

	if (!(self.flags & #FL_JUMPRELEASED) )
		return;		// don't pogo stick

	self.flags = self.flags - (self.flags & #FL_JUMPRELEASED);
	self.button2 = 0;
// player jumping sound
	sound (self, #CHAN_BODY, "player/plyrjmp8.wav", 1, #ATTN_NORM);

#ifndef QUAKE_WORLD
	self.velocity_z = self.velocity_z + 270;
#endif
};


/*
===========
WaterMove

============
*/
.float	dmgtime;

void() WaterMove =
{
//  dprint (ftos(self.waterlevel));
	if (self.movetype == #MOVETYPE_NOCLIP)
		return;
	if (self.health < 0)
		return;

	if (self.waterlevel != 3)
	{
		if (self.air_finished < time)
			sound (self, #CHAN_VOICE, "player/gasp2.wav", 1, #ATTN_NORM);
		else if (self.air_finished < time + 9)
			sound (self, #CHAN_VOICE, "player/gasp1.wav", 1, #ATTN_NORM);
		self.air_finished = time + 12;
		self.dmg = 2;
	}
	else if (self.air_finished < time)
	{	// drown!
		if (self.pain_finished < time)
		{
			self.dmg = self.dmg + 2;
			if (self.dmg > 15)
				self.dmg = 10;
			TF_T_Damage (self, world, world, self.dmg, #TF_TD_IGNOREARMOUR, #TF_TD_OTHER);
			self.pain_finished = time + 1;
		}
	}
	
	if (!self.waterlevel)
	{
		if (self.flags & #FL_INWATER)
		{	
			// play leave water sound
			sound (self, #CHAN_BODY, "misc/outwater.wav", 1, #ATTN_NORM);
			self.flags = self.flags - #FL_INWATER;
		}
		return;
	}

	if (self.watertype == #CONTENT_LAVA)
	{	// do damage
		if (self.dmgtime < time)
		{
			if (self.radsuit_finished > time)
				self.dmgtime = time + 1;
			else
				self.dmgtime = time + 0.2;

			// Ceramic armor helps against lava, but I doubt it'll save you :)
			TF_T_Damage (self, world, world, 10*self.waterlevel, 0, #TF_TD_FIRE);
		}
	}
	else if (self.watertype == #CONTENT_SLIME)
	{	// do damage
		if (self.dmgtime < time && self.radsuit_finished < time)
		{
			self.dmgtime = time + 1;
			T_Damage (self, world, world, 4*self.waterlevel);
		}
	}
	
	if ( !(self.flags & #FL_INWATER) )
	{	
		// player enter water sound
		if (self.watertype == #CONTENT_LAVA)
			sound (self, #CHAN_BODY, "player/inlava.wav", 1, #ATTN_NORM);
		if (self.watertype == #CONTENT_WATER)
			sound (self, #CHAN_BODY, "player/inh2o.wav", 1, #ATTN_NORM);
		if (self.watertype == #CONTENT_SLIME)
			sound (self, #CHAN_BODY, "player/slimbrn2.wav", 1, #ATTN_NORM);

		self.flags = self.flags + #FL_INWATER;
		self.dmgtime = 0;
	}

#ifndef QUAKE_WORLD	
	if (! (self.flags & #FL_WATERJUMP) )
		self.velocity = self.velocity - 0.8*self.waterlevel*frametime*self.velocity;
#endif
};

void() CheckWaterJump =
{
	local vector start, end;

	// check for a jump-out-of-water
	makevectors (self.angles);
	start = self.origin;
	start_z = start_z + 8; 
	v_forward_z = 0;
	normalize(v_forward);
	end = start + v_forward*24;
	traceline (start, end, #TRUE, self);
	if (trace_fraction < 1)
	{	// solid at waist
		start_z = start_z + self.maxs_z - 8;
		end = start + v_forward*24;
		self.movedir = trace_plane_normal * -50;
		traceline (start, end, #TRUE, self);
		if (trace_fraction == 1)
		{	// open at eye level
			self.flags = self.flags | #FL_WATERJUMP;
			self.velocity_z = 225;
			self.flags = self.flags - (self.flags & #FL_JUMPRELEASED);
			self.teleport_time = time + 2;	// safety net
			return;
		}
	}
};


/*
================
PlayerPreThink

Called every frame before physics are run
================
*/
void() PlayerPreThink =
{
	local float	mspeed, aspeed, r;
	local vector src;

	if (self.is_feigning && self.waterlevel == 1)
	{
		self.watertype = #CONTENT_WATER;
		self.waterlevel = 3;
	}

	if (self.cheat_level > 0)
		self.cheat_level = self.cheat_level - 1;

	if (intermission_running)
	{
		IntermissionThink ();	// otherwise a button could be missed between
		return;					// the think tics
	}

	makevectors (self.v_angle);		// is this still used

	if (self.playerclass == #PC_UNDEFINED)
	{
		if (self.button0)
			self.velocity = normalize(v_forward) * 300;

		if (self.button2 && self.current_menu == #MENU_TEAM && self.team_no == 0)
		{
			if (TeamFortress_TeamPutPlayerInTeam())
			{
				self.current_menu = #MENU_CLASS;
				self.menu_count = #MENU_REFRESH_RATE;
			}
		}

#ifdef DEMO_STUFF
		if (self.enemy != world)
		{
			// If Distance Lock is ON, move the player
			if (self.tfstate & #TFSTATE_ZOOMOFF)
			{
				// Vector Lock
				if (self.tfstate & #TFSTATE_AIMING)
				{
					makevectors(self.camangle);
					src = v_forward;
				}
				// Angle Lock
				else if (self.tfstate & #TFSTATE_TRANQUILISED)
				{
					makevectors(self.camangle + self.enemy.angles);
					src = v_forward;
				}
				// Reverse Angle Lock
				else if (self.tfstate & #TFSTATE_INVINCIBLE)
				{
					makevectors(self.camangle + self.enemy.angles);
					src = v_forward;
					src_y = anglemod(src_y + 180);
					src_x = anglemod(src_x + 180);
					src_z = anglemod(src_z + 180);
				}
				else
				{
					src = self.origin - self.enemy.origin;
				}

				src = normalize(src) * self.camdist;
				self.origin = self.enemy.origin + src;
			}

			src = self.enemy.origin - self.origin;
			src_z = 0 - src_z;

			self.angles = vectoangles(src);
			self.fixangle = #TRUE;
		}
#endif
	}

	if (self.view_ofs == '0 0 0')
		return;		// intermission or finale

	CheckRules ();
	if (self.playerclass != #PC_UNDEFINED)
		WaterMove();

#ifndef QUAKE_WORLD
	if (self.waterlevel == 2 && self.playerclass != #PC_UNDEFINED)
		CheckWaterJump ();
#endif

	if (self.deadflag >= #DEAD_DEAD)
	{
		PlayerDeathThink ();
		return;
	}

	if (self.undercover_team || self.undercover_skin || self.is_undercover)
	{
		if (self.effects & (#EF_DIMLIGHT | #EF_BRIGHTLIGHT))
		{
			sprint(self, #PRINT_MEDIUM, "The glowing removes your disguise.\n");
			Spy_RemoveDisguise(self);
		}
	}
	
	if (self.deadflag == #DEAD_DYING)
		return;	// dying, so do nothing

	if (!self.is_feigning)
	{
		if (self.button2)
		{
			PlayerJump ();
		}
		else
			self.flags = self.flags | #FL_JUMPRELEASED;
	}
	else if (self.waterlevel)
	{
		self.velocity_z = -100;
	}

	// teleporters can force a non-moving pause time	
	if (time < self.pausetime)
		self.velocity = '0 0 0';

 	if (time > self.attack_finished && self.currentammo == 0 && self.weapon > #WEAP_AXE)
 	{
 		self.weapon = W_BestWeapon ();
 		W_SetCurrentAmmo ();
 	}

    // Do grapple stuff if I'm on a hook
    if (self.on_hook)
    	Service_Grapple ();
};
	
/*
================
CheckPowerups

Check for turning off powerups
================
*/
void() CheckPowerups =
{
	local float lighton;
	local entity te;

	if (self.health <= 0)
		return;

	// invisibility
#ifdef QUAKE_WORLD
	if (self.playerclass == #PC_UNDEFINED)
	{
		self.modelindex = modelindex_null;	// don't use eyes
	}
	else if (self.is_undercover == 1 && invis_only == #TRUE)
#else
	if (self.is_undercover == 1 && invis_only == #TRUE)
#endif
	{
		self.frame = 0;
		self.modelindex = modelindex_eyes;
	}
	else if (self.invisible_finished)
	{
		// If this is being given by a goalitem, extend the time
		if (self.tfstate & #TFSTATE_INVISIBLE)
		{
			if (self.invisible_finished < time + 10)
				self.invisible_finished = time + 666;
		}

		// sound and screen flash when items starts to run out
		if (self.invisible_sound < time)
		{
			sound (self, #CHAN_AUTO, "items/inv3.wav", 0.5, #ATTN_IDLE);
			self.invisible_sound = time + ((random() * 3) + 1);
		}


		if (self.invisible_finished < time + 3)
		{
			if (self.invisible_time == 1)
			{
				sprint(self, #PRINT_HIGH, "Ring of Shadows magic is fading\n");
				stuffcmd (self, "bf\n");
				sound (self, #CHAN_AUTO, "items/inv2.wav", 1, #ATTN_NORM);
				self.invisible_time = time + 1;
			}
			
			if (self.invisible_time < time)
			{
				self.invisible_time = time + 1;
				stuffcmd (self, "bf\n");
			}
		}

		if (self.invisible_finished < time)
		{	// just stopped
			self.items = self.items - #IT_INVISIBILITY;
			self.invisible_finished = 0;
			self.invisible_time = 0;
		}
		
		// use the eyes
		self.frame = 0;
		self.modelindex = modelindex_eyes;
	}
	else
		self.modelindex = modelindex_player;	// don't use eyes

	// invincibility
	if (self.invincible_finished)
	{
		// If this is being given by a goalitem, extend the time
		if (self.tfstate & #TFSTATE_INVINCIBLE)
		{
			if (self.invincible_finished < time + 10)
				self.invincible_finished = time + 666;
		}

		// sound and screen flash when items starts to run out
		if (self.invincible_finished < time + 3)
		{
			if (self.invincible_time == 1)
			{
				sprint (self, #PRINT_HIGH, "Protection is almost burned out\n");

				stuffcmd (self, "bf\n");
				sound (self, #CHAN_AUTO, "items/protect2.wav", 1, #ATTN_NORM);
				self.invincible_time = time + 1;
			}
			
			if (self.invincible_time < time)
			{
				self.invincible_time = time + 1;
				stuffcmd (self, "bf\n");
			}
		}
		
		if (self.invincible_finished < time)
		{	// just stopped
			self.items = self.items - #IT_INVULNERABILITY;
			self.invincible_time = 0;
			self.invincible_finished = 0;
		}
		if (self.invincible_finished > time)
			self.effects = self.effects | #EF_DIMLIGHT;
		else
		{
			// Only remove dimlight if it's not being supplied by a GoalItem
			lighton = #FALSE;
			te = find (world, classname, "item_tfgoal");
			while (te)
			{
				if (te.owner == self)
				{
					if (te.goal_activation & #TFGI_GLOW)
						lighton = #TRUE;
				}
				te = find(te, classname, "item_tfgoal");
			}

			if (!lighton)
				self.effects = self.effects - (self.effects & #EF_DIMLIGHT);
		}
	}

	// super damage
	if (self.super_damage_finished)
	{
		// If this is being given by a goalitem, extend the time
		if (self.tfstate & #TFSTATE_QUAD)
		{
			if (self.super_damage_finished == time + 10)
				self.super_damage_finished = time + 666;
		}

		// sound and screen flash when items starts to run out
		if (self.super_damage_finished < time + 3)
		{
			if (self.super_time == 1)
			{
				sprint (self, #PRINT_HIGH, "Quad Damage is wearing off\n");
				stuffcmd (self, "bf\n");
				sound (self, #CHAN_AUTO, "items/damage2.wav", 1, #ATTN_NORM);
				self.super_time = time + 1;
			}	  
			
			if (self.super_time < time)
			{
				self.super_time = time + 1;
				stuffcmd (self, "bf\n");
			}
		}

		if (self.super_damage_finished < time)
		{	// just stopped
			self.items = self.items - #IT_QUAD;
			self.super_damage_finished = 0;
			self.super_time = 0;
		}
		if (self.super_damage_finished > time)
			self.effects = self.effects | #EF_DIMLIGHT;
		else
		{
			// Only remove dimlight if it's not being supplied by a GoalItem
			lighton = #FALSE;
			te = find (world, classname, "item_tfgoal");
			while (te)
			{
				if (te.owner == self)
				{
					if (te.goal_activation & #TFGI_GLOW)
						lighton = #TRUE;
				}
				te = find(te, classname, "item_tfgoal");
			}

			if (!lighton)
				self.effects = self.effects - (self.effects & #EF_DIMLIGHT);
		}
	}	

	// suit	
	if (self.radsuit_finished)
	{
		self.air_finished = time + 12;		// don't drown

		// If this is being given by a goalitem, extend the time
		if (self.tfstate & #TFSTATE_RADSUIT)
		{
			if (self.radsuit_finished == time + 10)
				self.radsuit_finished = time + 666;
		}

		// sound and screen flash when items starts to run out
		if (self.radsuit_finished < time + 3)
		{
			if (self.rad_time == 1)
			{
				sprint (self, #PRINT_HIGH, "Air supply in Biosuit expiring\n");
				stuffcmd (self, "bf\n");
				sound (self, #CHAN_AUTO, "items/suit2.wav", 1, #ATTN_NORM);
				self.rad_time = time + 1;
			}
			
			if (self.rad_time < time)
			{
				self.rad_time = time + 1;
				stuffcmd (self, "bf\n");
			}
		}

		if (self.radsuit_finished < time)
		{	// just stopped
			self.items = self.items - #IT_SUIT;
			self.rad_time = 0;
			self.radsuit_finished = 0;
		}
	}	

};

void() DeadImpulses;

/*
================
PlayerPostThink

Called every frame after physics are run
================
*/
void() PlayerPostThink =
{
	local	float	mspeed, aspeed;
	local	float	r;

	if (self.view_ofs == '0 0 0')
		return;		// intermission or finale

	if (self.deadflag)
	{
		DeadImpulses();	 // check for dead-only commands
		self.impulse = 0;
		return;
	}

	// check to see if player landed and play landing sound	
	if ((self.jump_flag < -300) && (self.flags & #FL_ONGROUND) && (self.health > 0))
	{
		if (self.watertype == #CONTENT_WATER)
			sound (self, #CHAN_BODY, "player/h2ojump.wav", 1, #ATTN_NORM);
		else if (self.jump_flag < -650)
		{
			T_Damage (self, world, world, 5); 
			sound (self, #CHAN_VOICE, "player/land2.wav", 1, #ATTN_NORM);
			self.deathtype = "falling";
		}
		else
			sound (self, #CHAN_VOICE, "player/land.wav", 1, #ATTN_NORM);
	}


	self.jump_flag = self.velocity_z;

	CheckPowerups ();

	W_WeaponFrame ();

	//  Display MOTD
	if (self.motd < 22)
		TeamFortress_MOTD();
	else if (self.cheat_check == 0)
		self.cheat_check = time + 5;
#ifdef STATUSBAR
	else if (time > self.StatusRefreshTime && self.StatusBarSize != 0)
		RefreshStatusBar(self);
#endif

	// Check for Team Cheats
	if (self.cheat_check <= time)
	{
		TeamFortress_CheckTeamCheats();

	#ifdef QUAKE_WORLD
		self.cheat_check = time + 3;
	#else
		self.cheat_check = time + 1;
	#endif
	}
};


/*
===========
ClientConnect

called when a player connects to a server
============
*/
void() ClientConnect =
{
	local string st;

	bprint (#PRINT_HIGH, self.netname);
	bprint (#PRINT_HIGH, " entered the game\n");

	// Set Default autozoom
	if (#DEFAULT_AUTOZOOM == #OFF)
		self.tfstate = self.tfstate | #TFSTATE_ZOOMOFF;

	// Set the MOTD on
	self.motd = 0;
	// Clear the Alias Flag
	self.got_aliases = 0;

#ifdef QUAKE_WORLD
	st = infokey(self, "sbar_res");
	if (st == "768")
		self.StatusBarRes = 8;
	else if (st == "600")
		self.StatusBarRes = 7;
	else if (st == "480")
		self.StatusBarRes = 6;
	else if (st == "400")
		self.StatusBarRes = 5;
	else if (st == "384")
		self.StatusBarRes = 4;
	else if (st == "350")
		self.StatusBarRes = 3;
	else if (st == "300")
		self.StatusBarRes = 2;
	else if (st == "240")
		self.StatusBarRes = 1;
	else 
		self.StatusBarRes = 0;

	st = infokey(self, "sbar_size");
	self.StatusBarSize = stof(st);
	if (self.StatusBarSize > 2 || self.StatusBarSize < 0)
		self.StatusBarSize = 0;
#endif

	self.has_disconnected = #FALSE;

	// a client connecting during an intermission can cause problems
	if (intermission_running)
		GotoNextMap();
};


/*
===========
ClientDisconnect

called when a player disconnects from a server
============
*/
void() ClientDisconnect =
{
	local entity te;

#ifndef QUAKE_WORLD
	if (gameover)
		return;
#endif

	bprint (#PRINT_HIGH, self.netname);
	bprint (#PRINT_HIGH, " left the game with ");
	bprint (#PRINT_HIGH, ftos(self.frags));
	bprint (#PRINT_HIGH, " frags\n");

	sound (self, #CHAN_BODY, "player/tornoff2.wav", 1, #ATTN_NONE);
	self.has_disconnected = #TRUE;

	// Remove Timers
	TeamFortress_RemoveTimers();

	// Remove Buildings
	te = find(world, classname, "building_dispenser");
	while (te)
	{
		if (te.real_owner == self)
			TF_T_Damage(te, world, world, 500, 0, 0);

		te = find(te, classname, "building_dispenser");
	}
	te = find(world, classname, "building_sentrygun");
	while (te)
	{
		if (te.real_owner == self)
			TF_T_Damage(te, world, world, 500, 0, 0);

		te = find(te, classname, "building_sentrygun");
	}

	// Remove Detpacks
	te = find(world, classname, "detpack");
	while (te)
	{
		if (te.owner == self)
		{
			if (te.weaponmode == 1)     	  // Detpack was being disarmed
			{   
		#ifdef QUAKE_WORLD
				TeamFortress_SetSpeed(te.enemy);
		#else
				te.enemy.pausetime = time;		
		#endif

				dremove(te.oldenemy);  	 // CountDown
				dremove(te.observer_list); //	Disarm timer
			}

			dremove(te);
			te = world;
		}

		te = find(te, classname, "detpack");
	}

	set_suicide_frame ();
	self.netname = string_null;
	self.team_no = 0;
	self.solid = #SOLID_NOT;
	setsize(self, '0 0 0', '0 0 0');
};

/*
===========
ClientObituary
	
called when a player dies
============
*/
void(entity targ, entity attacker) ClientObituary =
{
	local float rnum;
	local string deathstring, deathstring2;
	local float attackerteam, targteam;
	local entity te;

	rnum = random();

	if (targ.classname == "player")
	{
		if (attacker.classname == "teledeath")
		{
			bprint (#PRINT_MEDIUM, targ.netname);
			bprint (#PRINT_MEDIUM, " was telefragged by ");
			bprint (#PRINT_MEDIUM, attacker.owner.netname);
			bprint (#PRINT_MEDIUM, "\n");

		 	if ((attacker.owner.team_no != targ.team_no) || attacker.owner.team_no < 1)
				attacker.owner.real_frags = attacker.owner.real_frags + 1;
			if (!(toggleflags & #TFLAG_TEAMFRAGS))
				attacker.owner.frags = attacker.owner.real_frags;

			return;
		}

		if (attacker.classname == "teledeath2")
		{
			bprint (#PRINT_MEDIUM, "Satan's power deflects ");
			bprint (#PRINT_MEDIUM, targ.netname);
			bprint (#PRINT_MEDIUM, "'s telefrag\n");

			targ.real_frags = targ.real_frags - 1;
 			if (!(toggleflags & #TFLAG_TEAMFRAGS))
				targ.frags = targ.real_frags;
			
#ifdef QUAKE_WORLD
			logfrag (targ, targ);
#endif

			return;
		}

		// Killed by a goal
		if (attacker.classname == "info_tfgoal")
		{
			if (attacker.deathtype != "")
			{
				bprint (#PRINT_MEDIUM, targ.netname);
				bprint (#PRINT_MEDIUM, attacker.deathtype);
			}
#ifdef QUAKE_WORLD
			logfrag (targ, targ);
#endif
			return;
		}

		if (attacker.classname == "player" || attacker.classname == "bot")
		{
			if (targ == attacker)
			{
				// killed self
				attacker.real_frags = attacker.real_frags - 1;
	 			if (!(toggleflags & #TFLAG_TEAMFRAGS))
					attacker.frags = attacker.real_frags;

				bprint (#PRINT_MEDIUM, targ.netname);

				if (deathmsg == #DMSG_GREN_HAND)
					deathstring = " grenades himself\n";
				else if (deathmsg == #DMSG_GREN_NAIL)
					deathstring = " hammers himself\n";
				else if (deathmsg == #DMSG_GREN_MIRV)
					deathstring = " goes to pieces\n";
				else if (deathmsg == #DMSG_GREN_PIPE)
					deathstring = " ambushes himself with his own pipebombs\n";
				else if (deathmsg == #DMSG_GREN_GAS)
					deathstring = " chokes on his own gas\n";
				else if (deathmsg == #DMSG_GREN_EMP)
					deathstring = " explodes his ammo and body\n";
				else if (deathmsg == #DMSG_GREN_FLASH)
					deathstring = " is charred by his own flash grenade\n";
				else if (deathmsg == #DMSG_GREN_EMP_AMMO)
					deathstring = " detonates an ammo box too close to him\n";
				else if (deathmsg == #DMSG_DETPACK)
					deathstring = " set the detpack and forgot to run\n";
				else if (deathmsg == #DMSG_BIOWEAPON)
					deathstring = " died impossibly!\n";
				else if (deathmsg == #DMSG_ROCKETL)
				{
					if (rnum)
						deathstring = " becomes bored with life\n";
					else
						deathstring = " checks if his weapon is loaded\n";
				}
				else if (deathmsg == #DMSG_INCENDIARY)
					deathstring = " chars himself with an incendiary rocket\n";
				else if (deathmsg == #DMSG_GRENADEL)
					deathstring = " tries to put the pin back in\n";
				else if (deathmsg == #DMSG_FLAME)
					deathstring = " torches himself\n";
				else if (deathmsg == #DMSG_LIGHTNING && targ.waterlevel > 1)
				{
					bprint (#PRINT_MEDIUM, " discharges into the water.\n");
					return;
				}
				
				bprint(#PRINT_MEDIUM, deathstring);
				return;
			}
			else if ((teamplay) && (attacker.team_no == targ.team_no) && (attacker.team_no > 0))
			{
				// killed a team member
				if (attacker.team_no > 0 && (attacker.team_no == targ.team_no))
					attacker.real_frags = attacker.real_frags - 1; // killed a team member
				else
					attacker.real_frags = attacker.real_frags + 1;

			 	if (!(toggleflags & #TFLAG_TEAMFRAGS))
					attacker.frags = attacker.real_frags;
 				if (rnum < 0.25)
 					deathstring = " mows down a teammate\n";
 				else if (rnum < 0.50)
 					deathstring = " checks his glasses\n";
 				else if (rnum < 0.75)
 					deathstring = " gets a frag for the other team\n";
 				else
 					deathstring = " loses another friend\n";

				if (deathmsg == #DMSG_MEDIKIT)
				{
	 				bprint (#PRINT_MEDIUM, targ.netname);
 					bprint (#PRINT_MEDIUM, " didn't survive the operation.\n");
					return;
				}

 				bprint (#PRINT_MEDIUM, attacker.netname);
				bprint (#PRINT_MEDIUM, deathstring);
						
				return;
			}
			else
			{
				attacker.real_frags = attacker.real_frags + 1;
				#ifdef QUAKE_WORLD
					logfrag (attacker, targ);
				#endif

			 	if (!(toggleflags & #TFLAG_TEAMFRAGS))
					attacker.frags = attacker.real_frags;

				if (deathmsg == #DMSG_GREN_HAND)
				{
					deathstring = " surfs on a grenade from ";
					deathstring2 = "\n";
				}
				else if (deathmsg == #DMSG_GREN_NAIL)
				{
					deathstring = " gets flayed by ";
					deathstring2 = "'s nail grenade\n";
				}
				else if (deathmsg == #DMSG_GREN_MIRV)
				{
					deathstring = " gets spammed by ";
					deathstring2 = "'s Mirv grenade\n";
				}
				else if (deathmsg == #DMSG_GREN_PIPE)
				{
					deathstring = " is caught by ";
					deathstring2 = "'s pipebomb trap\n";
				}
				else if (deathmsg == #DMSG_GREN_GAS)
				{
					deathstring = " gags on ";
					deathstring2 = "'s noxious gasses\n";
				}
				else if (deathmsg == #DMSG_GREN_EMP)
				{
					deathstring = "'s ammo detonates him as ";
					deathstring2 = "'s EMP fries it.\n";
				}
				else if (deathmsg == #DMSG_GREN_FLASH)
				{
					deathstring = " is charred by ";
					deathstring2 = "'s flash grenade.\n";
				}
				else if (deathmsg == #DMSG_GREN_EMP_AMMO)
				{
					deathstring = " stands near some ammo as ";
					deathstring2 = "'s EMP nukes it\n";
				}
				else if (deathmsg == #DMSG_DETPACK)
				{
					deathstring = " reaches orbit via ";
					deathstring2 = "'s detpack\n";
				}
				else if (deathmsg == #DMSG_DETPACK_DIS)
				{
					deathstring = " cut the red wire of ";
					deathstring2 = "'s detpack\n";
				}
				else if (deathmsg == #DMSG_BIOWEAPON)
				{
					deathstring = " dies from ";
					deathstring2 = "'s mysterious tropical disease\n";			
				}
				else if (deathmsg == #DMSG_BIOWEAPON_ATT)
				{
					deathstring = " escapes infection from ";
					deathstring2 = " by dying first\n";
				}
				else if (deathmsg == #DMSG_GRENADEL)
				{
					deathstring = " eats ";
					deathstring2 = "'s pineapple\n";
					if (targ.health < -40)
					{
						deathstring = " was gibbed by ";
						deathstring2 = "'s grenade\n";
					}
				}
				else if (deathmsg == #DMSG_ROCKETL)
				{
					deathstring = " rides ";
					deathstring2 = "'s rocket\n";
					if (targ.health < -40)
					{
						deathstring = " was gibbed by ";
						deathstring2 = "'s rocket\n" ;
					}
				}
				else if (deathmsg == #DMSG_FLAME)
				{
					if (rnum < 0.2)
					{
						deathstring =  " is burnt up by ";
						deathstring2 = "'s flame\n";
					}
					else if (rnum < 0.4)
					{
						deathstring =  " is fried by ";
						deathstring2 = "'s fire\n";
					}
					else if (rnum < 0.6)
					{
						deathstring =  " feels ";
						deathstring2 = "'s fire of wrath\n";
					}
					else if (rnum < 0.8)
					{
						deathstring =  " is reduced to ashes by ";
						deathstring2 = "\n";
					}
					else
					{
						deathstring = " is grilled by ";
						deathstring2 = "'s flame\n";
					}
				}
				else if (deathmsg == #DMSG_AXE)
				{
					if (attacker.playerclass == #PC_SPY)
						deathstring = " was knife-murdered by ";
					else
						deathstring = " was ax-murdered by ";
					deathstring2 = "\n";
				}
				else if (deathmsg == #DMSG_SPANNER)
				{
					deathstring = " was spanner-murdered by ";
					deathstring2 = "\n";
				}
				else if (deathmsg == #DMSG_SHOTGUN)
				{
					deathstring = " chewed on ";
					deathstring2 = "'s boomstick\n";
				}
				else if (deathmsg == #DMSG_SSHOTGUN)
				{
					deathstring = " ate 2 loads of ";
					deathstring2 = "'s buckshot\n";
				}
				else if (deathmsg == #DMSG_NAILGUN)
				{
					deathstring = " was nailed by ";
					deathstring2 = "\n";
				}
				else if (deathmsg == #DMSG_SNAILGUN)
				{
					deathstring = " was punctured by ";
					deathstring2 = "\n";
				}	 
				else if (deathmsg == #DMSG_LIGHTNING)
				{
					deathstring = " accepts ";
					if (attacker.waterlevel > 1)
						deathstring2 = "'s discharge\n";
					else
						deathstring2 = "'s shaft\n";
				}
				else if (deathmsg == #DMSG_HOOK)
				{
					deathstring = " grappled with ";
					deathstring2 = "\n";
				}
				else if (deathmsg == #DMSG_SNIPERRIFLE)
				{
					if (rnum <= 0.3)
					{
						deathstring = " takes a bullet in the chest from ";
						deathstring2 = "\n";
					}
					else
					{
						deathstring = " succumbs to sniperfire from ";
						deathstring2 = "\n";
					}
				}
				else if (deathmsg == #DMSG_SNIPERHEADSHOT)
				{
					if (rnum <= 0.5)
					{
						deathstring = " gets a third eye from ";
						deathstring2 = "\n";
					}
					else
					{
						deathstring = " gets his head blown off by ";
						deathstring2 = "\n";
					}
				}
				else if (deathmsg == #DMSG_SNIPERLEGSHOT)
				{
					if (rnum <= 0.5)
					{
						deathstring = " is made legless by ";
						deathstring2 = "\n";
					}
					else
					{
						deathstring = " gets his legs blown off by ";
						deathstring2 = "\n";
					}
				}
				else if (deathmsg == #DMSG_AUTORIFLE)
				{
					deathstring = " collects ";
					deathstring2 = "'s bullet spray.\n";
				}
				else if (deathmsg == #DMSG_ASSAULTCANNON)
				{
					deathstring = " gets sawn in half by ";
					deathstring2 = "\n";
				}
				else if (deathmsg == #DMSG_BACKSTAB)
				{
					deathstring = " gets knifed from behind by ";
					deathstring2 = "\n";
				}
				else if (deathmsg == #DMSG_TRANQ)
				{
					deathstring = " is put to sleep by ";
					deathstring2 = "\n";
				}
				else if (deathmsg == #DMSG_LASERBOLT)
				{
					deathstring = " gets a hole in his heart from ";
					deathstring2 = "'s railgun\n";
				}
				else if (deathmsg == #DMSG_INCENDIARY)
				{
					deathstring = " gets well done by ";
					deathstring2 = "'s incendiary rocket\n";
				}

				bprint (#PRINT_MEDIUM, targ.netname);
				bprint (#PRINT_MEDIUM, deathstring);
				bprint (#PRINT_MEDIUM, attacker.netname);
				bprint (#PRINT_MEDIUM, deathstring2);
			}
			return;
		}
		else if (attacker.classname == "building_sentrygun")
		{
			if (targ == attacker.real_owner)
			{
				if (deathmsg == #DMSG_SENTRYGUN_ROCKET)
					deathstring = " intercepts his sentry gun's rocket\n";
				else if (deathmsg == #DMSG_SENTRYGUN_BULLET)
					deathstring = " crossed his sentry gun's line of fire\n";
				
				bprint(#PRINT_MEDIUM, targ.netname);
				bprint(#PRINT_MEDIUM, deathstring);
			}
			else
			{
				attacker.real_owner.real_frags = attacker.real_owner.real_frags + 1;
				#ifdef QUAKE_WORLD
					logfrag (attacker.real_owner, targ);
				#endif

	 			if (!(toggleflags & #TFLAG_TEAMFRAGS))
					attacker.real_owner.frags = attacker.real_owner.real_frags;

				if (deathmsg == #DMSG_SENTRYGUN_ROCKET)
				{
					deathstring = " hates ";
					deathstring2 = "'s sentry gun\n";
				}
				else if (deathmsg == #DMSG_SENTRYGUN_BULLET)
				{
					deathstring = " is mown down by ";
					deathstring2 = "'s sentry gun\n";
				}
				bprint(#PRINT_MEDIUM, targ.netname);
				bprint(#PRINT_MEDIUM, deathstring);
				bprint(#PRINT_MEDIUM, attacker.real_owner.netname);
				bprint(#PRINT_MEDIUM, deathstring2);
			}
		}
		else
		{
			#ifdef QUAKE_WORLD
				logfrag (targ, targ);
			#endif

			targ.real_frags = targ.real_frags - 1;   // killed self
		 	if (!(toggleflags & #TFLAG_TEAMFRAGS))
				targ.frags = targ.real_frags;

			rnum = targ.watertype;

			bprint (#PRINT_HIGH, targ.netname);

			if (rnum == -3)
			{
				if (random() < 0.5)
					deathstring = " sleeps with the fishes\n";
				else
					deathstring = " sucks it down\n";
			}
			else if (rnum == -4)
			{
				if (random() < 0.5)
					deathstring = " gulped a load of slime\n";
				else
					deathstring = " can't exist on slime alone\n";
			}
			else if (rnum == -5)
			{
				if (targ.health < -15)
				{
					deathstring = " burst into flames\n";
				}
				else if (random() < 0.5)
					deathstring = " turned into hot slag\n";
				else
					deathstring = " visits the Volcano God\n";
			}
#ifndef QUAKE_WORLD
	#ifdef COOP_MODE
			else if (attacker.flags & #FL_MONSTER)
			{
				if (attacker.classname == "monster_army")
					deathstring = " was shot by a Grunt\n";
				else if (attacker.classname == "monster_demon1")
					deathstring = " was eviscerated by a Fiend\n";
				else if (attacker.classname == "monster_dog")
					deathstring = " was mauled by a Rottweiler\n";
				else if (attacker.classname == "monster_dragon")
					deathstring = " was fried by a Dragon\n";
				else if (attacker.classname == "monster_enforcer")
					deathstring = " was blasted by an Enforcer\n";
				else if (attacker.classname == "monster_fish")
					deathstring = " was fed to the Rotfish\n";
				else if (attacker.classname == "monster_hell_knight")
					deathstring = " was slain by a Death Knight\n";
				else if (attacker.classname == "monster_knight")
					deathstring = " was slashed by a Knight\n";
				else if (attacker.classname == "monster_ogre")
					deathstring = " was destroyed by an Ogre\n";
				else if (attacker.classname == "monster_oldone")
					deathstring = " became one with Shub-Niggurath\n";
				else if (attacker.classname == "monster_shalrath")
					deathstring = " was exploded by a Vore\n";
				else if (attacker.classname == "monster_shambler")
					deathstring = " was smashed by a Shambler\n";
				else if (attacker.classname == "monster_tarbaby")
					deathstring = " was slimed by a Spawn\n";
				else if (attacker.classname == "monster_vomit")
					deathstring = " was vomited on by a Vomitus\n";
				else if (attacker.classname == "monster_wizard")
					deathstring = " was scragged by a Scrag\n";
				else if (attacker.classname == "monster_zombie")
					deathstring = " joins the Zombies\n";
			}
	#endif
#endif
			else if (attacker.classname == "explo_box")
			{
				deathstring = " blew up\n";
			}
			else if (attacker.solid == #SOLID_BSP && attacker != world)
			{	
				deathstring = " was squished\n";
			}
			else if (targ.deathtype == "falling")
			{
				targ.deathtype = "";
				deathstring = " fell to his death\n";
			}
			else if (attacker.classname == "trap_shooter" || attacker.classname == "trap_spikeshooter")
			{
				deathstring = " was spiked\n";
			}
			else if (attacker.classname == "fireball")
			{
				deathstring = " ate a lavaball\n";
			}
			else if (attacker.classname == "trigger_changelevel")
			{
				deathstring = " tried to leave\n";
			}
			else 
			{
				deathstring = " died\n";
			}

			bprint(#PRINT_MEDIUM, deathstring);
		}
	}
	else if (targ.classname == "building_sentrygun")
	{
		if (attacker.classname == "teledeath")
		{
			bprint (#PRINT_MEDIUM, targ.real_owner.netname);
			bprint (#PRINT_MEDIUM, "'s sentrygun was telefragged by ");
			bprint (#PRINT_MEDIUM, attacker.owner.netname);
			bprint (#PRINT_MEDIUM, "\n");
			return;
		}

		if (attacker.classname == "player")
		{
			if (attacker == targ.real_owner)
			{
				bprint (#PRINT_MEDIUM, targ.real_owner.netname);
				bprint (#PRINT_MEDIUM, " destroys his sentrygun\n");
				return;
			}

			bprint (#PRINT_MEDIUM, targ.real_owner.netname);
			bprint (#PRINT_MEDIUM, "'s sentrygun was destroyed by ");
			bprint (#PRINT_MEDIUM, attacker.netname);
			bprint (#PRINT_MEDIUM, "\n");

			if (attacker.team_no > 0 && (attacker.team_no != targ.real_owner.team_no))
			{
				attacker.real_frags = attacker.real_frags + 1;
			 	if (!(toggleflags & #TFLAG_TEAMFRAGS))
					attacker.frags = attacker.real_frags;
			}

			return;
		}
	}
};

