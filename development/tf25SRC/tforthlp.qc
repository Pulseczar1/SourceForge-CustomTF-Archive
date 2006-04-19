/*======================================================
	TFORTHLP.QC			TeamFortress v2.5	

	(c) TeamFortress Software Pty Ltd 	29/2/97
========================================================
Functions handling all the help displaying for TeamFortress. 
========================================================*/
// Prototypes
// Help Functions
void() TeamFortress_MOTD;
void() TeamFortress_HelpMap;

//=========================================================================
// HELP FUNCTIONS
//=========================================================================
void() TeamFortress_MOTD =
{
	local string ya;

	// check if player already has aliases
	if (self.motd == 4)
		stuffcmd(self,"is_aliased\n");

	if (self.motd <= 20)
	{
		self.motd = self.motd + 1;
		return;
	}

	if (self.motd == 21)
	{
		// Set Default autozoom
		if (#DEFAULT_AUTOZOOM == #OFF)
			self.tfstate = self.tfstate | #TFSTATE_ZOOMOFF;

		// Set their color to white, so they stand out from teams
		if ((teamplay != 0) && (self.team_no == 0))
		{
			stuffcmd(self, "color ");
			ya = ftos(#WHITE - 1);
			stuffcmd(self, ya);
			stuffcmd(self, "\n");
		}

		if (self.got_aliases == #FALSE)
			sprint(self, #PRINT_HIGH, "\n\n\n");

		// If you run this is a server, you're welcome to change to initial
		// message here, but _please_ leave in the first line.
		// display welcome
		// sprint this bit so it gets put into the console log
		sprint(self, #PRINT_HIGH, "Type help for more info.\n");

		#ifdef COOP_MODE
			sprint (self, #PRINT_HIGH, "TeamFortress Coop version\n");
		#endif

		#ifndef QUAKE_WORLD
			#ifdef NET_SERVER
				sprint (self, #PRINT_HIGH, "TeamFortress Net version\n");
			#endif
		#endif

		#ifdef QUAKE_WORLD
			sprint(self, #PRINT_HIGH, "TeamFortress QuakeWorld 2.5\n");
		#endif
		
		sprint (self, #PRINT_HIGH, "www.planetquake.com/teamfortress/\n");

		self.current_menu = #MENU_INTRO;
		self.menu_count = #MENU_REFRESH_RATE;
   
		self.motd = 22;

		// check if player already has aliases
	   	if (self.got_aliases == #TRUE)
			return;

		sprint (self, #PRINT_HIGH, "binding aliases...\n");

		// Stuff Aliases
		// General
		TeamFortress_Alias("inv",#TF_INVENTORY, 0);
		TeamFortress_Alias("showtf",#TF_SHOWTF, 0);
		TeamFortress_Alias("autozoom", #TF_AUTOZOOM, 0);

		// Class Changing
		TeamFortress_Alias("scout",(#TF_CHANGEPC + #PC_SCOUT), 0);
		TeamFortress_Alias("sniper",(#TF_CHANGEPC + #PC_SNIPER), 0);
		TeamFortress_Alias("soldier",(#TF_CHANGEPC + #PC_SOLDIER), 0);
		TeamFortress_Alias("demoman",(#TF_CHANGEPC + #PC_DEMOMAN), 0);
		TeamFortress_Alias("medic",(#TF_CHANGEPC + #PC_MEDIC), 0);
		TeamFortress_Alias("hwguy",(#TF_CHANGEPC + #PC_HVYWEAP), 0);
		TeamFortress_Alias("pyro",(#TF_CHANGEPC + #PC_PYRO), 0);
		TeamFortress_Alias("spy",(#TF_CHANGEPC + #PC_SPY), 0);
		TeamFortress_Alias("engineer",(#TF_CHANGEPC + #PC_ENGINEER), 0);
		TeamFortress_Alias("randompc",(#TF_CHANGEPC + #PC_RANDOM), 0);

		// Grenades
		TeamFortress_Alias("primeone", #TF_GRENADE_1, 0);
		TeamFortress_Alias("primetwo", #TF_GRENADE_2, 0);
		TeamFortress_Alias("throwgren", #TF_GRENADE_T, 0);
		TeamFortress_Alias("+gren1", #TF_GRENADE_1, 0);
		TeamFortress_Alias("+gren2", #TF_GRENADE_2, 0);
		TeamFortress_Alias("-gren1", #TF_GRENADE_T, 0);
		TeamFortress_Alias("-gren2", #TF_GRENADE_T, 0);

		// Pipebombs
		TeamFortress_Alias("detpipe", #TF_PB_DETONATE, 0);

		// Reloading
		TeamFortress_Alias("reload", #TF_RELOAD, 0);

		// Sample aliases for the Scanner
		TeamFortress_Alias("scan10", #TF_SCAN_10, 0);
		TeamFortress_Alias("scan30", #TF_SCAN_30, 0);
		TeamFortress_Alias("scan100", #TF_SCAN_100, 0);
		TeamFortress_Alias("scanf", #TF_SCAN_FRIENDLY, 0);
		TeamFortress_Alias("scane", #TF_SCAN_ENEMY, 0);

		// Sample aliases for the Detpack
		TeamFortress_Alias("det5", #TF_DETPACK_5, 0);
		TeamFortress_Alias("det20", #TF_DETPACK_20, 0);
		TeamFortress_Alias("det50", #TF_DETPACK_50, 0);
		TeamFortress_Alias("+det5", #TF_DETPACK_5, 0);
		TeamFortress_Alias("-det5", #TF_DETPACK_STOP, 0);
		TeamFortress_Alias("+det20", #TF_DETPACK_20, 0);
		TeamFortress_Alias("-det20", #TF_DETPACK_STOP, 0);
		TeamFortress_Alias("+det50", #TF_DETPACK_50, 0);
		TeamFortress_Alias("-det50", #TF_DETPACK_STOP, 0);

		// Team handlers
		TeamFortress_Alias("showscores",#TF_TEAM_SCORES, 0);
		TeamFortress_Alias("showclasses",#TF_TEAM_CLASSES, 0);
		TeamFortress_Alias("query", #TF_STATUS_QUERY, 0);

		// Actions
		TeamFortress_Alias("dropkey", #TF_DROPKEY, 0);
		TeamFortress_Alias("dropammo", #TF_DROP_AMMO, 0);
		TeamFortress_Alias("showloc", #TF_DISPLAYLOCATION, 0);
		TeamFortress_Alias("special", #TF_SPECIAL_SKILL, 0);
		TeamFortress_Alias("saveme", #TF_MEDIC_HELPME, 0);
		TeamFortress_Alias("discard", #TF_DISCARD, 0);
		TeamFortress_Alias("id", #TF_ID, 0);

		// Map Impulses
		TeamFortress_Alias("flaginfo", #FLAG_INFO, 0);
		TeamFortress_Alias("maphelp", #TF_HELP_MAP, 0);
			
		// Class Ability Impulses
		TeamFortress_Alias("disguise", #TF_SPY_SPY, 0);
		TeamFortress_Alias("feign", #TF_SPY_DIE, 0);
		TeamFortress_Alias("build", #TF_ENGINEER_BUILD, 0);
//		TeamFortress_Alias("sandbag", #TF_ENGINEER_SANDBAG, 0);

#ifdef STATUSBAR
		TeamFortress_Alias("sbar_on", #TF_STATUSBAR_ON, 0);
		TeamFortress_Alias("sbar_off", #TF_STATUSBAR_OFF, 0);
		TeamFortress_Alias("sbar_200", #TF_STATUSBAR_RES_START, 0);
		TeamFortress_Alias("sbar_240", #TF_STATUSBAR_RES_START + 1, 0);
		TeamFortress_Alias("sbar_300", #TF_STATUSBAR_RES_START + 2, 0);
		TeamFortress_Alias("sbar_350", #TF_STATUSBAR_RES_START + 3, 0);
		TeamFortress_Alias("sbar_384", #TF_STATUSBAR_RES_START + 4, 0);
		TeamFortress_Alias("sbar_400", #TF_STATUSBAR_RES_START + 5, 0);
		TeamFortress_Alias("sbar_480", #TF_STATUSBAR_RES_START + 6, 0);
		TeamFortress_Alias("sbar_600", #TF_STATUSBAR_RES_START + 7, 0);
		TeamFortress_Alias("sbar_768", #TF_STATUSBAR_RES_START + 8, 0);
#endif

#ifdef DEMO_STUFF										  
		// Camera Impulse
		TeamFortress_Alias("lock", #TF_CAM_TARGET, 0);
		TeamFortress_Alias("distlock", #TF_CAM_ZOOM, 0);
		TeamFortress_Alias("veclock", #TF_CAM_VEC, 0);
		TeamFortress_Alias("anglelock", #TF_CAM_ANGLE, 0);
		TeamFortress_Alias("revanglelock", #TF_CAM_REVANGLE, 0);
		TeamFortress_Alias("projlock", #TF_CAM_PROJECTILE, 0);
		TeamFortress_Alias("projzoom", #TF_CAM_PROJECTILE_Z, 0);
#endif

		// Set up the alias check
		TeamFortress_Alias("is_aliased", #TF_ALIAS_CHECK, 0);

		// Do the binds
		stuffcmd(self, "bind 9 \"impulse 9\"\n");
		stuffcmd(self, "bind 0 \"impulse 10\"\n");
	}
};

//=========================================================================
// Help displayed when someone types the alias "maphelp"
void() TeamFortress_HelpMap =
{
	local entity te;

	te = find(world, classname, "info_tfdetect");
	if (te)
	{
		if (te.non_team_broadcast != string_null)
		{
			sprint (self, #PRINT_HIGH, te.non_team_broadcast);
			return;
		}
	}

	sprint (self, #PRINT_HIGH, "There is no help for this map.\n");
};
