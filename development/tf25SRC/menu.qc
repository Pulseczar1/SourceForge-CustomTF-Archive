/*======================================================
	MENU.QC			TeamFortress v2.5	

	(c) TeamFortress Software Pty Ltd 	29/2/97
========================================================
This file handles all menu functions and displays.
======================================================*/

#define MENU_DEFAULT				1
#define MENU_TEAM 					2
#define MENU_CLASS 					3
#define MENU_DROP  					4
#define MENU_INTRO 					5
#define MENU_CLASSHELP				6
#define MENU_CLASSHELP2 			7
#define MENU_REPEATHELP 			8
#define MENU_PICKBINDS  			9
#define MENU_SHOWBINDS1 			10
#define MENU_SHOWBINDS2 			11
#define MENU_SPY					12
#define MENU_SPY_SKIN				13
#define MENU_SPY_COLOR				14
#define MENU_ENGINEER				15
#define MENU_ENGINEER_FIX_DISPENSER	16
#define MENU_ENGINEER_FIX_SENTRYGUN	17
#define MENU_ENGINEER_FIX_MORTAR	18
#define MENU_DISPENSER				19

#define MENU_REFRESH_RATE 			25

void(entity targ, entity inflictor, entity attacker, float damage, float T_flags, float T_AttackType) TF_T_Damage;
void() W_SetCurrentAmmo;
void(entity p) bound_other_ammo;
float(float tno) TeamFortress_TeamSet;
void(entity p) TeamFortress_SetSkin;
float(float tno) TeamFortress_TeamGetColor;
void() TeamFortress_ChangeClass;
void(float type) TeamFortress_DropAmmo;
float() TeamFortress_TeamPutPlayerInTeam;
float(float tno) TeamFortress_TeamIsCivilian;
void(float class) TeamFortress_SpyChangeSkin;
void(float teamno) TeamFortress_SpyChangeColor;
void(float building) TeamFortress_Build;
void() TeamFortress_SpyFeignDeath;
void(entity spy) Spy_RemoveDisguise;
void() lvl1_sentry_stand;
void() lvl2_sentry_stand;
void() lvl3_sentry_stand;
float (float tno) TeamFortress_TeamGetNoPlayers;

void(float menu_no) DisplayMenu;
// Assorted menus
void() Menu_Team;
void() Menu_Class;
void() Menu_Drop;
void() Menu_Intro;
void() PlayerObserverMode;
// Classhelp
void() Menu_ClassHelp;
void() Menu_ClassHelp2;
void() Menu_StuffClassHelp;
void(float inp) Menu_ClassHelp_Input;
// Bindings
void() Menu_DoBindings;
void() Menu_ShowBindings1;
void() Menu_ShowBindings2;
void() Menu_RepeatHelp;
// Spy
void() Menu_Spy;
void() Menu_Spy_Skin;
void() Menu_Spy_Color;
void(float inp) Menu_Spy_Input;
void(float inp) Menu_Spy_Skin_Input;
void(float inp) Menu_Spy_Color_Input;
// Engineer
void() Menu_Engineer;
void() Menu_EngineerFix_Dispenser;
void() Menu_EngineerFix_SentryGun;
void() Menu_EngineerFix_Mortar;
void(float inp) Menu_Engineer_Input;
void(float inp) Menu_EngineerFix_Dispenser_Input;
void(float inp) Menu_EngineerFix_SentryGun_Input;
void(float inp) Menu_EngineerFix_Mortar_Input;
// Buildings
void() Menu_Dispenser;
void(float inp) Menu_Dispenser_Input;
void(entity pl, string s1) CenterPrint;
void(entity pl, string s1, string s2) CenterPrint2;

void() ResetMenu =
{
	if (self.StatusBarSize == 0)
		CenterPrint(self, "\n");
	else
		self.StatusRefreshTime = time + 0.1;
	self.menu_count = #MENU_REFRESH_RATE;
	self.current_menu = #MENU_DEFAULT;
};

void() Player_Menu =
{
	// loop function
	if (self.menu_count > #MENU_REFRESH_RATE)
	{
		self.menu_count = 0;
	}
	else
	{
		self.menu_count = self.menu_count + 1;
		return;
	}

	// determine which menu to display
	if (self.current_menu == #MENU_INTRO)
	{
		Menu_Intro();
		self.current_menu = #MENU_DEFAULT;
	}
	else if (self.current_menu == #MENU_CLASSHELP)
	{
		Menu_ClassHelp();
		if (self.menu_displaytime > 8)
		{
			Menu_StuffClassHelp();
			self.current_menu = #MENU_DEFAULT;
		}
		else
			self.menu_displaytime = self.menu_displaytime + 1;
	}
	else if (self.current_menu == #MENU_CLASSHELP2)
	{
		Menu_ClassHelp2();
		if (self.menu_displaytime > 5)
		{
			Menu_StuffClassHelp();
			self.current_menu = #MENU_DEFAULT;
		}
		else
			self.menu_displaytime = self.menu_displaytime + 1;
	}
	else if (self.current_menu == #MENU_SHOWBINDS1)
	{
		Menu_ShowBindings1();
		if (self.menu_displaytime > 8)
		{
			self.current_menu = #MENU_DEFAULT;
		}
		else
			self.menu_displaytime = self.menu_displaytime + 1;
	}
	else if (self.current_menu == #MENU_SHOWBINDS2)
	{
		Menu_ShowBindings2();
		if (self.menu_displaytime > 8)
		{
			self.current_menu = #MENU_DEFAULT;
		}
		else
			self.menu_displaytime = self.menu_displaytime + 1;
	}
	else if (self.current_menu == #MENU_DROP)
	{	
		Menu_Drop();
	}
	else if (self.current_menu == #MENU_SPY)
	{
		Menu_Spy();
	}
	else if (self.current_menu == #MENU_SPY_SKIN)
	{
		Menu_Spy_Skin();
	}
	else if (self.current_menu == #MENU_SPY_COLOR)
	{
		Menu_Spy_Color();
	}
	else if (self.current_menu == #MENU_ENGINEER)
	{
		Menu_Engineer();
	}
	else if (self.current_menu == #MENU_ENGINEER_FIX_DISPENSER)
	{
		Menu_EngineerFix_Dispenser();
	}
	else if (self.current_menu == #MENU_ENGINEER_FIX_SENTRYGUN)
	{
		Menu_EngineerFix_SentryGun();
	}
	else if (self.current_menu == #MENU_DISPENSER)
	{
		Menu_Dispenser();
	}
	else if (self.current_menu == #MENU_REPEATHELP)
	{	
		Menu_RepeatHelp();
		self.current_menu = #MENU_DEFAULT;
	}
	else if (self.current_menu == #MENU_PICKBINDS)
	{	
		Menu_DoBindings();
	}
	else if (self.team_no == 0 && teamplay && (self.lives != 0))
	{
		self.current_menu = #MENU_TEAM;
		Menu_Team();
	}
	else if (self.playerclass == #PC_UNDEFINED && (self.lives != 0))
	{
		self.current_menu = #MENU_CLASS;
		Menu_Class();
	}
	else
		self.current_menu = 0;
};


void(float menu_no) DisplayMenu =
{
	self.current_menu = menu_no;

	if (menu_no == #MENU_TEAM)
	{
		Menu_Team();
	}
	else if (menu_no == #MENU_CLASS)
	{
		Menu_Class();
	}
};

void() Menu_Team =
{
	if ((toggleflags & #TFLAG_AUTOTEAM) && teamplay)
	{
		// assign player a team
		if (TeamFortress_TeamPutPlayerInTeam())
			return;
	}

	// The Detection entity may have specified a Team Menu String
	if (team_menu_string != string_null)
	{
		CenterPrint(self, team_menu_string);
		return;
	}

	if (CTF_Map == #TRUE)							   							 
		CenterPrint(self, "=== Choose your team ===\n\n“.. Blue Team           \n”.. Red Team            \n\n\n\n™.. Bind my keys for me!\n\nFor full details on this patch:\nhttp://www.telefragged.com/teamfortress/\n");
	else if (number_of_teams == 1)
		CenterPrint(self, "=== Choose your team ===\n\n“.. Team One  \n");
	else if (number_of_teams == 2)
		CenterPrint(self, "=== Choose your team ===\n\n“.. Team One  \n”.. Team Two  \n              \n              \n—.. Auto team \n");
	else if (number_of_teams == 3)
		CenterPrint(self, "=== Choose your team ===\n\n“.. Team One  \n”.. Team Two  \n•.. Team Three\n              \n—.. Auto team \n");
	else // if (number_of_teams == 4)
		CenterPrint(self, "=== Choose your team ===\n\n“.. Team One  \n”.. Team Two  \n•.. Team Three\n–.. Team Four \n—.. Auto team \n");
};

void(float inp) Menu_Team_Input =
{
	if (inp == 5) // auto team
		TeamFortress_TeamPutPlayerInTeam();
	else if (inp <= number_of_teams && inp > 0)
		TeamFortress_TeamSet(inp);		
	else if (number_of_teams == 0 && inp <= #TM_MAX_NO)
		TeamFortress_TeamSet(inp);
	else if (inp == 7)
		self.current_menu = #MENU_PICKBINDS;
	else if (inp == 8)
		PlayerObserverMode();

	ResetMenu();		
	self.impulse = 0;
};

void() Menu_Class =
{
	local entity AD;

	AD = find(world, classname, "info_tfdetect");

	if (AD)
	{
		if (self.team_no == 1)
		{
			if (AD.noise1 != string_null)
			{
				CenterPrint(self, AD.noise1);
				return;
			}
		}
		else if (self.team_no == 2)
		{
			if (AD.noise2 != string_null)
			{
				CenterPrint(self, AD.noise2);
				return;
			}
		}
		else if (self.team_no == 3)
		{
			if (AD.noise3 != string_null)
			{
				CenterPrint(self, AD.noise3);
				return;
			}
		}
		else if (self.team_no == 4)
		{
			if (AD.noise4 != string_null)
			{
				CenterPrint(self, AD.noise4);
				return;
			}
		}
	}

	if (TeamFortress_TeamIsCivilian(self.team_no))
		CenterPrint(self, "Your team can only be Civilians.\n");
	else if (spy_off == #TRUE)
		CenterPrint(self, "=== Choose your class ===\n\n“.. Scout   \n”.. Sniper  \n•.. Soldier \n–.. Demoman \n—.. Medic   \n˜.. Hvwep   \n™.. Pyro    \n›.. Engineer\n’.. Randompc\n");
	else  
		CenterPrint(self, "=== Choose your class ===\n\n“.. Scout   \n”.. Sniper  \n•.. Soldier \n–.. Demoman \n—.. Medic   \n˜.. Hvwep   \n™.. Pyro    \nš.. Spy     \n›.. Engineer\n’.. Randompc\n");
};

void(float inp) Menu_Class_Input =
{
	if (inp > 10 || inp < 1)
		return;

	self.impulse = inp + #TF_CHANGEPC;
		
	TeamFortress_ChangeClass();			
	ResetMenu();		

	if ( #DISPLAY_CLASS_HELP ) 
		self.current_menu = #MENU_CLASSHELP;
	else
		self.current_menu = #MENU_DEFAULT;

	self.menu_displaytime = 0;

	self.impulse = 0;
};

void () Menu_Drop =
{
	if (self.playerclass == #PC_ENGINEER)
		CenterPrint(self, "Drop or Make:                   \n“.. Shells                      \n”.. Nails                       \n•.. Rockets                     \n–.. Cells                       \n—.. Nothing                     \n\n");
	else
		CenterPrint(self, "Drop:                           \n“.. Shells                      \n”.. Nails                       \n•.. Rockets                     \n–.. Cells                       \n—.. Nothing                     \n\n");
};

void () Menu_RepeatHelp =
{
	CenterPrint(self, "Press š to see this help again\n");
};

void(float inp) Menu_Drop_Input =
{
	if ((inp > 0) && (inp < 5))
	{
		TeamFortress_DropAmmo(inp);
	}
	
	if ((inp > 0) && (inp < 6))
		ResetMenu();		

	self.impulse = 0;
};

void(float inp) Menu_DoBindings_Input =
{
	local string st;

	if (inp < 4)
	{
		self.impulse = 0;
		if (inp == 1)
		{
			// Flag info
			stuffcmd(self, "bind q \"impulse 23\"\n");
			// Hook
			stuffcmd(self, "bind e \"impulse 22\"\n");
			// Grenade 1
			stuffcmd(self, "bind r \"+gren1\"\n");
			// Grenade 2
			stuffcmd(self, "bind f \"+gren2\"\n");
			// Detonate Pipebombs
			stuffcmd(self, "bind v \"detpipe\"\n");
			// Drop ammo
			stuffcmd(self, "bind c \"dropammo\"\n");
			// Scan
			stuffcmd(self, "bind x \"scan50\"\n");
			// Showclasses
			stuffcmd(self, "bind g \"showclasses\"\n");
			// Inventory
			stuffcmd(self, "bind z \"inv\"\n");
		
			self.menu_count = #MENU_REFRESH_RATE;
			self.current_menu = #MENU_SHOWBINDS1;
			self.menu_displaytime = 0;
			return;
		}
		else if (inp == 2)
		{
			// Flag info
			stuffcmd(self, "bind s \"impulse 23\"\n");
			// Hook
			stuffcmd(self, "bind x \"impulse 22\"\n");
			// Grenade 1
			stuffcmd(self, "bind d \"+gren1\"\n");
			// Grenade 2
			stuffcmd(self, "bind c \"+gren2\"\n");
			// Detonate Pipebombs
			stuffcmd(self, "bind f \"detpipe\"\n");
			// Drop ammo
			stuffcmd(self, "bind v \"dropammo\"\n");
			// Scan
			stuffcmd(self, "bind b \"scan50\"\n");
			// Showclasses
			stuffcmd(self, "bind g \"showclasses\"\n");
			// Inventory
			stuffcmd(self, "bind n \"inv\"\n");
		
			self.menu_count = #MENU_REFRESH_RATE;
			self.current_menu = #MENU_SHOWBINDS2;
			self.menu_displaytime = 0;
			return;
		}
		ResetMenu();		
	}
};

void(float inp) Menu_Input =
{
	if (self.current_menu == #MENU_TEAM)
		Menu_Team_Input(inp);
	else if (self.current_menu == #MENU_CLASS)
		Menu_Class_Input(inp);
	else if (self.current_menu == #MENU_DROP)
	    Menu_Drop_Input(inp);
	else if (self.current_menu == #MENU_SPY)
	    Menu_Spy_Input(inp);
	else if (self.current_menu == #MENU_SPY_SKIN)
	    Menu_Spy_Skin_Input(inp);
	else if (self.current_menu == #MENU_SPY_COLOR)
	    Menu_Spy_Color_Input(inp);
	else if (self.current_menu == #MENU_ENGINEER)
	    Menu_Engineer_Input(inp);
	else if (self.current_menu == #MENU_ENGINEER_FIX_DISPENSER)
	    Menu_EngineerFix_Dispenser_Input(inp);
	else if (self.current_menu == #MENU_ENGINEER_FIX_MORTAR)
	    Menu_EngineerFix_Mortar_Input(inp);
	else if (self.current_menu == #MENU_ENGINEER_FIX_SENTRYGUN)
	    Menu_EngineerFix_SentryGun_Input(inp);
	else if (self.current_menu == #MENU_DISPENSER)
		Menu_Dispenser_Input(inp);
	else if (self.current_menu == #MENU_CLASSHELP)
		Menu_ClassHelp_Input(inp);
	else if (self.current_menu == #MENU_PICKBINDS)
		Menu_DoBindings_Input(inp);
};

void() Menu_Intro =
{
	CenterPrint(self, #MSG_INTRO);
};

void() Menu_ClassHelp =
{
	if (self.menu_displaytime < 5)
	{
		if (self.playerclass == #PC_SCOUT)																							  																		                                                                                            
			CenterPrint(self, "ÓÃÏÕÔ Details:               \n\n×ÅÁÐÏÎÓ:                     \n2.. Shotgun                  \n4.. Nailgun                  \n\nPress š for alias help\n");
		else if (self.playerclass == #PC_SNIPER)
			CenterPrint(self, "ÓÎÉÐÅÒ Details:              \n\n×ÅÁÐÏÎÓ:                     \n2.. Sniper Rifle/Auto Rifle  \n4.. Nailgun                  \n\nPress š for alias help\n");
		else if (self.playerclass == #PC_SOLDIER)																							
			CenterPrint(self, "ÓÏÌÄÉÅÒ Details:             \n\n×ÅÁÐÏÎÓ:                     \n2.. Shotgun                  \n3.. Super Shotgun            \n7.. Rocket Launcher          \n\nPress š for alias help\n");
		else if (self.playerclass == #PC_DEMOMAN)																																							                                                                                                
			CenterPrint(self, "ÄÅÍÏÌÉÔÉÏÎÓ ÍÁÎ Details:     \n\n×ÅÁÐÏÎÓ:                     \n2.. Shotgun                  \n6.. Grenade/Pipebomb Launcher\n                             \n\nPress š for alias help\n");
		else if (self.playerclass == #PC_MEDIC)
			CenterPrint(self, "ÍÅÄÉÃ Details:               \n\n×ÅÁÐÏÎÓ:                     \n1.. Medikit/BioWeapon        \n2.. Shotgun                  \n3.. Super Shotgun            \n5.. Super Nailgun            \n\nPress š for alias help\n");
		else if (self.playerclass == #PC_HVYWEAP)
			CenterPrint(self, "ÈÅÁÖÙ ×ÅÁÐÏÎÓ ÇÕÙ Details:   \n\n×ÅÁÐÏÎÓ:                     \n2.. Shotgun                  \n3.. Super Shotgun            \n7.. Assault Cannon           \n\nPress š for alias help\n");
		else if (self.playerclass == #PC_PYRO)
			CenterPrint(self, "ÐÙÒÏ Details:                \n\n×ÅÁÐÏÎÓ:                     \n2.. Shotgun                  \n6.. Flamethrower             \n7.. Incendiary Cannon        \n\nPress š for alias help\n");
		else if (self.playerclass == #PC_SPY)
			CenterPrint(self, "ÓÐÙ Details:                 \n\n×ÅÁÐÏÎÓ:                     \n2.. Tranquiliser Gun         \n3.. Super Shotgun            \n4.. Nailgun                  \n\nPress š for alias help\n");
		else if (self.playerclass == #PC_ENGINEER)
			CenterPrint(self, "ÅÎÇÉÎÅÅÒ Details:            \n\n×ÅÁÐÏÎÓ:                     \n1.. Spanner                  \n2.. RailGun                  \n3.. Super Shotgun            \n\nPress š for alias help\n");
	}
	else
	{
		if (self.playerclass == #PC_SCOUT)																							  																		                                                                                            
			CenterPrint(self, "ÇÒÅÎÁÄÅÓ:            \nFlash Grenade       \nConcussion Grenade  \n\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nScanner: scan10,scan50,scan250\n\n\nPress š for alias help\n");
		else if (self.playerclass == #PC_SNIPER)
			CenterPrint(self, "ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nFlare               \n\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nautozoom : Toggle Rifle Autozooming\n\n\nPress š for alias help\n");
		else if (self.playerclass == #PC_SOLDIER)																							
			CenterPrint(self, "ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nNail Grenade        \n\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nNone\n\n\nPress š for alias help\n");
		else if (self.playerclass == #PC_DEMOMAN)																																							                                                                                                
			CenterPrint(self, "ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nMirv Grenade        \n\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nThe Detpack : det5,det20,det50\nDetonate Pipebombs : detpipe  \n\n\nPress š for alias help\n");
		else if (self.playerclass == #PC_MEDIC)
			CenterPrint(self, "ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nConcussion Grenade  \n\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nNone\n\n\nPress š for alias help\n");
		else if (self.playerclass == #PC_HVYWEAP)
			CenterPrint(self, "ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nMirv Grenade        \n\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nNone\n\n\nPress š for alias help\n");
		else if (self.playerclass == #PC_PYRO)
			CenterPrint(self, "ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nNapalm Grenade      \n\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nNone\n\n\nPress š for alias help\n");
		else if (self.playerclass == #PC_SPY)
			CenterPrint(self, "ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nHallucinogen Grenade\n\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nGo Undercover : disguise\n\n\nPress š for alias help\n");
		else if (self.playerclass == #PC_ENGINEER)
			CenterPrint(self, "ÇÒÅÎÁÄÅÓ:            \nHand Grenade        \nEMP Grenade         \n\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:   \nStart Building : build  \n\n\nPress š for alias help\n");
	}
};

void() Menu_StuffClassHelp =
{
	if (self.playerclass == #PC_SCOUT)
	{
		sprint(self, #PRINT_HIGH, "ÓÃÏÕÔ Details:\n×ÅÁÐÏÎÓ:\n   2.. Shotgun\n   4.. Nailgun\n");
		sprint(self, #PRINT_HIGH, "ÇÒÅÎÁÄÅÓ:\n   Concussion Grenade\n   Flare\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n");
		sprint(self, #PRINT_HIGH, "Scanner: scan10,scan30,scan100\n\n\n");
	}
	else if (self.playerclass == #PC_SNIPER)
	{
		sprint (self, #PRINT_HIGH, "ÓÎÉÐÅÒ Details:\n\n×ÅÁÐÏÎÓ:\n   2.. Sniper Rifle/Auto Rifle\n");
		sprint (self, #PRINT_HIGH, "4.. Nailgun\nÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n\n\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n");
		sprint (self, #PRINT_HIGH, "  autozoom : Toggle Rifle Autozooming\n\n\n");
	}
	else if (self.playerclass == #PC_SOLDIER)
	{
		sprint (self, #PRINT_HIGH, "ÓÏÌÄÉÅÒ Details:\n\n×ÅÁÐÏÎÓ:\n   2.. Shotgun\n   3.. Super Shotgun\n");
		sprint (self, #PRINT_HIGH, "   7.. Rocket Launcher\nÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n   Nail Grenade\n");
		sprint (self, #PRINT_HIGH, "ÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   None\n\n\n");
	}
	else if (self.playerclass == #PC_DEMOMAN)
	{
		sprint (self, #PRINT_HIGH, "ÄÅÍÏÌÉÔÉÏÎÓ ÍÁÎ Details:\n\n×ÅÁÐÏÎÓ:\n   2.. Shotgun\n   6.. Grenade/Pipebomb Launcher\n");
		sprint (self, #PRINT_HIGH, "ÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n   Mirv Grenade\n");
		sprint (self, #PRINT_HIGH, "ÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   The Detpack : det5,det20,det50\n   Detonate Pipebombs : detpipe\n\n\n");
	}
	else if (self.playerclass == #PC_MEDIC)
	{
		sprint (self, #PRINT_HIGH, "ÍÅÄÉÃ Details:\n\n×ÅÁÐÏÎÓ:\n   1.. Medikit/BioWeapon\n   2.. Shotgun\n   3.. Super Shotgun\n");
		sprint (self, #PRINT_HIGH, "   5.. Super Nailgun\nÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n   Concussion Grenade\n");
		sprint (self, #PRINT_HIGH, "ÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   None\n\n\n");
	}
	else if (self.playerclass == #PC_HVYWEAP)
	{
		sprint (self, #PRINT_HIGH, "ÈÅÁÖÙ ×ÅÁÐÏÎÓ ÇÕÙ Details:\n\n×ÅÁÐÏÎÓ:\n   2.. Shotgun\n   3.. Super Shotgun\n");
		sprint (self, #PRINT_HIGH, "   7.. Assault Cannon\nÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n");
		sprint (self, #PRINT_HIGH, "   Mirv Grenade\nÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   None\n\n\n");
	}
	else if (self.playerclass == #PC_PYRO)
	{
		sprint (self, #PRINT_HIGH, "ÐÙÒÏ Details:\n\n×ÅÁÐÏÎÓ:\n   2.. Shotgun\n   6.. Flamethrower\n   7.. Incendiary Cannon\n");
		sprint (self, #PRINT_HIGH, "ÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n   Napalm Grenade\n");
		sprint (self, #PRINT_HIGH, "ÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   None\n\n\n");
	}
	else if (self.playerclass == #PC_SPY)
	{
		sprint (self, #PRINT_HIGH, "ÓÐÙ Details:\n\n×ÅÁÐÏÎÓ:\n   2.. Tranquiliser Gun\n   3.. Super Shotgun\n   4.. Nailgun\n");
		sprint (self, #PRINT_HIGH, "ÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n   Hallucinogenic Grenade\n");
		sprint (self, #PRINT_HIGH, "ÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   Go Undercover : disguise\n\n\n");
	}
	else if (self.playerclass == #PC_ENGINEER)
	{
		sprint (self, #PRINT_HIGH, "ÅÎÇÉÎÅÅÒ Details:\n\n×ÅÁÐÏÎÓ:\n   1.. Spanner\n   2.. RailGun\n   3.. Super Shotgun\n");
		sprint (self, #PRINT_HIGH, "ÇÒÅÎÁÄÅÓ:\n   Hand Grenade\n   EMP Grenade\n");
		sprint (self, #PRINT_HIGH, "ÓÐÅÃÉÁÌ ÃÏÍÍÁÎÄÓ:\n   Start Building : build\n\n\n");
	}
};

void() Menu_ClassHelp2 =
{								  
	CenterPrint(self, "Commands:\ninv       : Show inventory \n+gren1    : Throw grenade 1\n+gren2    : Throw Grenade 2\nreload    : Force a reload \ndropammo  : drop some ammo \n\n");
};

void(float inp) Menu_ClassHelp_Input =
{
	if (inp == 8)
	{
		Menu_ClassHelp2();
		self.menu_count = #MENU_REFRESH_RATE;
		self.current_menu = #MENU_CLASSHELP2;
		self.menu_displaytime = 0;
		self.impulse = 0;
	}

	// Otherwise, the impulse is passed on
};

void() Menu_DoBindings =
{																		   				 
	CenterPrint(self, "“.. Use keys: E R F V C Q X G Z\n”.. Use keys: S X D C F V B G N\n•.. Don't make bindings        \n");
};

void() Menu_ShowBindings1 =
{
	CenterPrint(self, "Ñ.. Flaginfo      \nÅ.. Hook          \nÒ.. Throw Gren 1  \nÆ.. Throw Gren 2  \nÖ.. Det. Pipebombs\nÃ.. Drop ammo     \nØ.. Use Scanner   \nÇ.. Showclasses   \nÚ.. inventory     \n");
};

void() Menu_ShowBindings2 =
{
	CenterPrint(self, "Ó.. Flaginfo      \nØ.. Hook          \nÄ.. Throw Gren 1  \nÃ.. Throw Gren 2  \nÆ.. Det. Pipebombs\nÖ.. Drop ammo     \nÂ.. Use Scanner   \nÇ.. Showclasses   \nÎ.. inventory     \n");
};

//============================================================================
// SPY menus for the Skin and Color changing ability
void() Menu_Spy =
{
	if (self.is_feigning)
	{
		if (self.undercover_team != 0 && self.undercover_skin != 0)
			CenterPrint(self, "Action:                           \n“.. Change Skin                 \n”.. Change Color                \n•.. Stop Feigning               \n–.. Reset Skin and Color        \n—.. Nothing                     \n\n");
		else if (self.undercover_team != 0)
			CenterPrint(self, "Action:                           \n“.. Change Skin                 \n”.. Change Color                \n•.. Stop Feigning               \n–.. Reset Color                 \n—.. Nothing                     \n\n");
		else if (self.undercover_skin != 0)
			CenterPrint(self, "Action:                           \n“.. Change Skin                 \n”.. Change Color                \n•.. Stop Feigning               \n–.. Reset Skin                  \n—.. Nothing                     \n\n");
		else
			CenterPrint(self, "Action:                           \n“.. Change Skin                 \n”.. Change Color                \n•.. Stop Feigning               \n–.. Nothing                     \n\n");
	}
	else
	{
		if (self.undercover_team != 0 && self.undercover_skin != 0)
			CenterPrint(self, "Action:                           \n“.. Change Skin                 \n”.. Change Color                \n•.. Start Feigning              \n–.. Reset Skin and Color        \n—.. Nothing                     \n\n");
		else if (self.undercover_team != 0)
			CenterPrint(self, "Action:                           \n“.. Change Skin                 \n”.. Change Color                \n•.. Start Feigning              \n–.. Reset Color                 \n—.. Nothing                     \n\n");
		else if (self.undercover_skin != 0)
			CenterPrint(self, "Action:                           \n“.. Change Skin                 \n”.. Change Color                \n•.. Start Feigning              \n–.. Reset Skin                  \n—.. Nothing                     \n\n");
		else
			CenterPrint(self, "Action:                           \n“.. Change Skin                 \n”.. Change Color                \n•.. Start Feigning              \n–.. Nothing                     \n\n");
	}
};

void(float inp) Menu_Spy_Input =
{
	local float tc;
	local string st;
	
	if (inp == 1 || inp == 2)
	{
		if (self.effects & (#EF_DIMLIGHT | #EF_BRIGHTLIGHT))
		{
			sprint(self, #PRINT_HIGH, "You can't go undercover while glowing.\n");
			ResetMenu();		
			self.impulse = 0;
			return;
		}
		if (self.is_unabletospy == 1)
		{
			sprint(self, #PRINT_HIGH, "You can't go undercover right now.\n");
			ResetMenu();		
			self.impulse = 0;
			return;
		}
	}

	if (inp == 1)
	{
		Menu_Spy_Skin();
		self.menu_count = #MENU_REFRESH_RATE;
		self.current_menu = #MENU_SPY_SKIN;
		self.menu_displaytime = 0;
		self.impulse = 0;
	}
	else if (inp == 2)
	{
		Menu_Spy_Color();
		self.menu_count = #MENU_REFRESH_RATE;
		self.current_menu = #MENU_SPY_COLOR;
		self.menu_displaytime = 0;
		self.impulse = 0;
	}
	else if (inp == 3)
	{
		TeamFortress_SpyFeignDeath();
		ResetMenu();		
		self.impulse = 0;
	}
	else if (inp == 4)
	{
		Spy_RemoveDisguise(self);

		ResetMenu();		
		self.impulse = 0;
	}
	else if (inp == 5 && (self.undercover_team != 0 || self.undercover_skin != 0))
	{
		ResetMenu();		
		self.impulse = 0;
	}

	// Otherwise, the impulse is passed on
};

void() Menu_Spy_Skin =
{
	CenterPrint(self, "Change Skin to:\n“.. Scout   \n”.. Sniper  \n•.. Soldier \n–.. Demoman \n—.. Medic   \n˜.. Hvwep   \n™.. Pyro    \nš.. Spy     \n›.. Engineer\n\n");
};

void(float inp) Menu_Spy_Skin_Input =
{
	if (inp < 10 && inp > 0)
	{
		TeamFortress_SpyChangeSkin(inp);
		ResetMenu();		
		self.impulse = 0;
	}

	// Otherwise, the impulse is passed on
};

void() Menu_Spy_Color =
{
	if (number_of_teams == 0)
	{
		sprint(self, #PRINT_HIGH, "No Color changing allowed in deathmatch.\n");
		ResetMenu();		
		self.impulse = 0;
		return;
	}

	if (number_of_teams == 1)											 
		CenterPrint(self, "=== Change Color to the Same Color as  ===\n\n“.. Team One  \n\n");
	else if (number_of_teams == 2)
		CenterPrint(self, "=== Change Color to the Same Color as  ===\n\n“.. Team One  \n”.. Team Two  \n\n");
	else if (number_of_teams == 3)
		CenterPrint(self, "=== Change Color to the Same Color as  ===\n\n“.. Team One  \n”.. Team Two  \n•.. Team Three\n\n");
	else // if (number_of_teams == 4)
		CenterPrint(self, "=== Change Color to the Same Color as  ===\n\n“.. Team One  \n”.. Team Two  \n•.. Team Three\n–.. Team Four \n\n");
};

void(float inp) Menu_Spy_Color_Input =
{
	if (inp >= 1 && inp <= number_of_teams)
	{
		TeamFortress_SpyChangeColor(inp);
		ResetMenu();		
		self.impulse = 0;
	}

	// Otherwise, the impulse is passed on
};

//============================================================================
// ENGINEER menus for the building ability
void() Menu_Engineer =
{
	if (self.has_dispenser == #TRUE && self.has_sentry == #TRUE )
		CenterPrint(self, "Action:                           \n“.. Remotely Detonate Dispenser \n”.. Remotely Detonate Sentry Gun\n–.. Nothing                     \n\n");
	else if ((self.has_dispenser) && (self.ammo_cells >= #BUILD_COST_SENTRYGUN))
		CenterPrint(self, "Action:                           \n“.. Remotely Detonate Dispenser \n”.. Build Sentry Gun            \n–.. Nothing                     \n\n");
	else if (self.has_dispenser)
		CenterPrint(self, "Action:                           \n“.. Remotely Detonate Dispenser \n–.. Nothing                     \n\n");
	else if ((self.has_sentry) && (self.ammo_cells >= #BUILD_COST_DISPENSER))
		CenterPrint(self, "Action:                           \n“.. Build Ammo&Armor Dispenser  \n”.. Remotely Detonate Sentry Gun\n–.. Nothing                     \n\n");
	else if (self.has_sentry)
		CenterPrint(self, "Action:                           \n”.. Remotely Detonate Sentry Gun\n–.. Nothing                     \n\n");
	else if (self.ammo_cells >= #BUILD_COST_SENTRYGUN)
		CenterPrint(self, "Action:                           \n“.. Build Ammo&Armor Dispenser  \n”.. Build Sentry Gun            \n–.. Nothing                     \n\n");
	else if (self.ammo_cells >= #BUILD_COST_DISPENSER)
		CenterPrint(self, "Action:                           \n“.. Build Ammo&Armor Dispenser  \n–.. Nothing                     \n\n");
	else
		ResetMenu();		
};

void(float inp) Menu_Engineer_Input =
{
	local entity te;

	if (inp == 1 && (self.ammo_cells >= #BUILD_COST_DISPENSER || self.has_dispenser == #TRUE))
	{
		if (self.has_dispenser)
		{
			te = find(world, classname, "building_dispenser");
			while (te)
			{
				if (te.real_owner == self)
					TF_T_Damage(te, world, world, 500, 0, 0);

				te = find(te, classname, "building_dispenser");
			}
		}
		else
		{
			TeamFortress_Build(#BUILD_DISPENSER);
		}
		ResetMenu();		
		self.impulse = 0;
	}
	else if (inp == 2 && (self.ammo_cells >= #BUILD_COST_SENTRYGUN || self.has_sentry == #TRUE))
	{
		if (self.has_sentry)
		{
			te = find(world, classname, "building_sentrygun");
			while (te)
			{
				if (te.real_owner == self)
					TF_T_Damage(te, world, world, 500, 0, 0);

				te = find(te, classname, "building_sentrygun");
			}
		}
		else
		{
			TeamFortress_Build(#BUILD_SENTRYGUN);
		}
		ResetMenu();		
		self.impulse = 0;
	}
/*	else if (inp == 3 && self.ammo_cells >= #BUILD_COST_MORTAR)
	{
		TeamFortress_Build(#BUILD_MORTAR);
		ResetMenu();		
		self.impulse = 0;
	} */
	else if (inp == 4)
	{
		ResetMenu();		
		self.impulse = 0;
	}

	// Otherwise, the impulse is passed on
};

//============================================================================
// ENGINEER menus for fixing buildings
void() Menu_EngineerFix_Dispenser =
{
	CenterPrint(self, "Action:                            \n“.. Put Ammo into Dispenser     \n”.. Put Armor into Dispenser    \n•.. Repair Dispenser            \n–.. Dismantle Dispenser         \n—.. Nothing                     \n\n");
};

void(float inp) Menu_EngineerFix_Dispenser_Input =
{
	local float metalcost;
	local float am;

	if (self.classname != "player" || self.building == world)
		return;

	if (inp == 1)
	{
		// shells
		am = (#DROP_SHELLS * 2);
		if (am > self.ammo_shells)
			am = self.ammo_shells; 
		if (am > (#BUILD_DISPENSER_MAX_SHELLS - self.building.ammo_shells))
			am = #BUILD_DISPENSER_MAX_SHELLS - self.building.ammo_shells;
		self.ammo_shells = self.ammo_shells - am;
		self.building.ammo_shells = self.building.ammo_shells + am;

		// nails
		am = (#DROP_NAILS * 2);
		if (am > self.ammo_nails)
			am = self.ammo_nails; 
		if (am > (#BUILD_DISPENSER_MAX_NAILS - self.building.ammo_nails))
			am = #BUILD_DISPENSER_MAX_NAILS - self.building.ammo_nails;
		self.ammo_nails = self.ammo_nails - am;
		self.building.ammo_nails = self.building.ammo_nails + am;

		// rockets
		am = (#DROP_ROCKETS * 2);
		if (am > self.ammo_rockets)
			am = self.ammo_rockets; 
		if (am > (#BUILD_DISPENSER_MAX_ROCKETS - self.building.ammo_rockets))
			am = #BUILD_DISPENSER_MAX_ROCKETS - self.building.ammo_rockets;
		self.ammo_rockets = self.ammo_rockets - am;
		self.building.ammo_rockets = self.building.ammo_rockets + am;

		// cells
		am = (#DROP_CELLS * 2);
		if (am > self.ammo_cells)
			am = self.ammo_cells; 
		if (am > (#BUILD_DISPENSER_MAX_CELLS - self.building.ammo_cells))
			am = #BUILD_DISPENSER_MAX_CELLS - self.building.ammo_cells;
		self.ammo_cells = self.ammo_cells - am;
		self.building.ammo_cells = self.building.ammo_cells + am;
	}
	else if (inp == 2)
	{
		// armor
		am = (#DROP_ARMOR * 2);
		if (am > self.armorvalue)
			am = self.armorvalue; 
		if (am > (#BUILD_DISPENSER_MAX_ARMOR - self.building.armorvalue))
			am = #BUILD_DISPENSER_MAX_ARMOR - self.building.armorvalue;
		self.armorvalue = self.armorvalue - am;
		self.building.armorvalue = self.building.armorvalue + am;
	}
	else if (inp == 3)
	{
		local string f1;

		metalcost = (self.building.max_health - self.building.health) / 5;

		if (metalcost > self.ammo_cells)
			metalcost = self.ammo_cells;

		self.ammo_cells = self.ammo_cells - metalcost;
		self.building.health = self.building.health + (metalcost * 5);
	}
	else if (inp == 4)
	{
		sprint (self, #PRINT_HIGH, "You dismantle the Dispenser.\n");
		self.ammo_cells = self.ammo_cells + (#BUILD_COST_DISPENSER / 2);
		dremove(self.building);
		self.building.real_owner.has_dispenser = #FALSE;
	}

	if (inp >= 1 && inp <= 5)
	{
		ResetMenu();		
		self.impulse = 0;
		self.building = world;

		bound_other_ammo(self);

		if (self.armorvalue == 0)
		{
			self.armortype = 0;	// lost all armor
			self.armorclass = 0; // lost special armor
			self.items = self.items - (self.items & (#IT_ARMOR1 | #IT_ARMOR2 | #IT_ARMOR3));
		}

		W_SetCurrentAmmo();
	}

	// Otherwise, the impulse is passed on
};

void() Menu_EngineerFix_SentryGun =
{
	if (self.building.weapon < 3 && self.ammo_cells >= #BUILD_COST_SENTRYGUN)
		CenterPrint(self, "Action:                            \n“.. Put Ammo into Sentry Gun    \n”.. Upgrade Sentry Gun          \n•.. Repair Sentry Gun           \n–.. Dismantle Sentry Gun        \n—.. Nothing                     \n\n");
	else
		CenterPrint(self, "Action:                            \n“.. Put Ammo into Sentry Gun    \n\n•.. Repair Sentry Gun           \n–.. Dismantle Sentry Gun        \n—.. Nothing                     \n\n");
};

void(float inp) Menu_EngineerFix_SentryGun_Input =
{
	local float am, metalcost;
	local string st;

	if (self.classname != "player" || self.building == world)
		return;

	if (inp == 1)
	{
		// shells
		am = (#DROP_SHELLS * 2);
		if (am > self.ammo_shells)
			am = self.ammo_shells;
		if (am > (self.building.maxammo_shells - self.building.ammo_shells))
			am = (self.building.maxammo_shells - self.building.ammo_shells);
		self.ammo_shells = self.ammo_shells - am;
		self.building.ammo_shells = self.building.ammo_shells + am;

		// If it's level 3, put some rockets in too
		if (self.building.weapon == 3)
		{
			am = (#DROP_ROCKETS * 2);
			if (am > self.ammo_rockets)
				am = self.ammo_rockets;
			if (am > (self.building.maxammo_rockets - self.building.ammo_rockets))
				am = (self.building.maxammo_rockets - self.building.ammo_rockets);
			self.ammo_rockets = self.ammo_rockets - am;
			self.building.ammo_rockets = self.building.ammo_rockets + am;
		}
	}
	else if (self.building.weapon < 3 && inp == 2 && self.ammo_cells >= #BUILD_COST_SENTRYGUN)
	{
		self.ammo_cells = self.ammo_cells - #BUILD_COST_SENTRYGUN;
		self.building.weapon = self.building.weapon + 1;

		// more health
		self.building.max_health = self.building.max_health * 1.2;
		self.building.health = self.building.max_health;
		// more ammo capability
		self.building.maxammo_shells = self.building.maxammo_shells * 1.2;
		// Change the skin and frames
		if (self.building.weapon == 2)
		{
			sound (self.building, #CHAN_ITEM, "weapons/turrset.wav", 1, #ATTN_NORM);
			self.building.think = lvl2_sentry_stand;
			self.building.skin = 1;
		}
		else // if (self.building.weapon == 3)
		{
			sound (self.building, #CHAN_ITEM, "weapons/turrset.wav", 1, #ATTN_NORM);
			self.building.think = lvl3_sentry_stand;
			self.building.skin = 2;
		}

		sprint(self, #PRINT_HIGH, "You upgrade the Sentry Gun to level ");
		st = ftos(self.building.weapon); 
		sprint(self, #PRINT_HIGH, st);
		sprint(self, #PRINT_HIGH, "\n");
	}
	else if (inp == 3)
	{
		metalcost = (self.building.max_health - self.building.health) / 5;

		if (metalcost > self.ammo_cells)
			metalcost = self.ammo_cells;

		self.ammo_cells = self.ammo_cells - metalcost;
		self.building.health = self.building.health + (metalcost * 5);
	}
	else if (inp == 4)
	{
		sprint(self, #PRINT_HIGH, "You dismantle the Sentry Gun.\n");
		self.ammo_cells = self.ammo_cells + (#BUILD_COST_SENTRYGUN / 2);
		dremove(self.building.trigger_field);
		dremove(self.building);
		self.building.real_owner.has_sentry = #FALSE;
	}

	if (inp >= 1 && inp <= 5)
	{
		ResetMenu();		
		self.impulse = 0;

		bound_other_ammo(self);

		if (self.armorvalue == 0)
		{
			self.armortype = 0;	// lost all armor
			self.armorclass = 0; // lost special armor
			self.items = self.items - (self.items & (#IT_ARMOR1 | #IT_ARMOR2 | #IT_ARMOR3));
		}

		W_SetCurrentAmmo();
	}
};

void() Menu_EngineerFix_Mortar =
{
	CenterPrint(self, "Action:                            \n“.. Reload Mortar               \n•.. Repair Mortar               \n–.. Dismantle Mortar            \n—.. Nothing                     \n\n");
};

void(float inp) Menu_EngineerFix_Mortar_Input =
{
	if (inp >= 1 && inp <= 5)
	{
		ResetMenu();		
		self.impulse = 0;

		bound_other_ammo(self);

		if (self.armorvalue == 0)
		{
			self.armortype = 0;	// lost all armor
			self.armorclass = 0; // lost special armor
			self.items = self.items - (self.items & (#IT_ARMOR1 | #IT_ARMOR2 | #IT_ARMOR3));
		}

		W_SetCurrentAmmo();
	}
};

//============================================================================
// Menu for using buildings
void() Menu_Dispenser =
{
	CenterPrint(self, "Use Dispenser:                     \n“.. Withdraw some ammo          \n”.. Withdraw some Armor         \n•.. Nothing                     \n\n");
};

void(float inp) Menu_Dispenser_Input =
{
	local float am, empty;

	empty = #FALSE;
	if (inp == 1)
	{
		if (self.building.ammo_shells == 0 && self.building.ammo_nails == 0 && 
			self.building.ammo_rockets == 0 && self.building.ammo_cells == 0)
		{
			empty = #TRUE;
		}
		else
		{
			// shells
			am = self.maxammo_shells - self.ammo_shells;
			if (am > self.building.ammo_shells)
				am = self.building.ammo_shells; 
			self.building.ammo_shells = self.building.ammo_shells - am;
			self.ammo_shells = self.ammo_shells + am;

			// nails
			am = self.maxammo_nails - self.ammo_nails;
			if (am > self.building.ammo_nails)
				am = self.building.ammo_nails; 
			self.building.ammo_nails = self.building.ammo_nails - am;
			self.ammo_nails = self.ammo_nails + am;

			// rockets
			am = self.maxammo_rockets - self.ammo_rockets;
			if (am > self.building.ammo_rockets)
				am = self.building.ammo_rockets; 
			self.building.ammo_rockets = self.building.ammo_rockets - am;
			self.ammo_rockets = self.ammo_rockets + am;

			// cells
			am = self.maxammo_cells - self.ammo_cells;
			if (am > self.building.ammo_cells)
				am = self.building.ammo_cells; 
			self.building.ammo_cells = self.building.ammo_cells - am;
			self.ammo_cells = self.ammo_cells + am;
		}
	}
	else if (inp == 2)
	{
		if (self.building.armorvalue == 0)
		{
			empty = #TRUE;
		}
		else
		{
			// armor
			am = self.maxarmor - self.armorvalue;
			if (am > self.building.armorvalue)
				am = self.building.armorvalue; 

			if (self.armortype == 0)
			{
				self.armortype = 0.3;
				self.items = self.items | #IT_ARMOR1;
			}

			self.building.armorvalue = self.building.armorvalue - am;
			self.armorvalue = self.armorvalue + am;
		}
	}

	if (inp >= 1 && inp <= 3)
	{
		if (empty)
			sprint(self, #PRINT_HIGH, "The dispenser is empty.\n");
		ResetMenu();		
		self.impulse = 0;
		self.building = world;
		self.building_wait = time + 0.5;

		bound_other_ammo(self);

		if (self.armorvalue == 0)
		{
			self.armortype = 0;	// lost all armor
			self.armorclass = 0; // lost special armor
			self.items = self.items - (self.items & (#IT_ARMOR1 | #IT_ARMOR2 | #IT_ARMOR3));
		}

		W_SetCurrentAmmo();
	}

	// Otherwise, the impulse is passed on
};
