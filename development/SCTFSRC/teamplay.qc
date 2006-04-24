/* teamplay.qc

   From
        The Complete Enhanced Teamplay

   John Spickes -- jspickes@eng.umd.edu

	$Id: teamplay.qc 1.17 1996/08/17 16:52:45 jspickes Exp $

	$Log: teamplay.qc $
	Revision 1.17  1996/08/17 16:52:45  jspickes
	Fixed a problem with displaying the current team settings that could cause
	the wrong output when teamplay was negative.  Also added code to indicate
	when ID's silly teamplay code is being used.

	Revision 1.16  1996/08/17 00:41:52  jspickes
	Turned off strict coop by default.
	Fixed a bug that could have caused strange behavior if TEAM_COLOR* was
	set to -2.

	Revision 1.15  1996/08/17 00:34:17  jspickes
	Added instructions on drop-item use in current settings output.
	Fixed a problem that would allow you to drop lots of backpacks with
	nothing in them.

(Inferno) - I commented out the old code of
            Team_Pick_Base mode so I could write a new
            one which would be less buggy and actually works (and it was
            easier to write, also commented out the NewBase function since
            I'll be rewriting a totally new code, this is in conjunction
            with weapons.qc - 10/11/98

*/

// Things to come in the future....
float () crandom;
float (float gweapon) W_BestNWeapon;
void (float newcolor) StuffPlayerColor;
void (entity who, string s4, string s5, string s7) UpdatePlayerStatus;  // status of player
void (string gibname, float dm) ThrowGib;
void (entity targ, entity attacker, entity inflictor) Killed;
void () RegenerationSound;
void (entity ppp) ExEffect;
//void () FlagDropFloor;  // what happens when the flag drops out of the level

// Define some functions, tell Quake to look for them farther within the file. (RED)
//void () TeamCaptureSetUpdate;
void (entity e) takeOffInitialInvincibility;

/** Defs **/
void (float theteam, string j) TeamPrint;
void () FlagNextThing;

/** MODIFIABLE CONSTANTS **/

float TEAM_DEFAULT_PENALTY =    1;      // Default frag penalty
float TEAM_STRICT_COOP =	0;	// Strict Coop

// Allowed team colors
// -1 indicates no color

float TEAM_COLOR1       =       4;
float TEAM_COLOR2       =       13;
float TEAM_COLOR3       =       -1;
float TEAM_COLOR4       =       -1;

/** End of MODIFIABLE CONSTANTS **/

// Globals

entity team1_lastspawn;
entity team2_lastspawn;
float	nextteamupdtime;	// time until next team update

// Teamplay bitfield entries

float TEAM_HEALTH_PROTECT =     1;      // No health damage from friendly fire
float TEAM_ARMOR_PROTECT =      2;      // No armor damage from friendly fire
float TEAM_ATTACKER_DAMAGE =    4;      // Attacker takes damage from hitting teammates
float TEAM_FRAG_PENALTY =       8;      // One frag penalty for killing teammate
float TEAM_DEATH_PENALTY =      16;     // Die when you kill a teammate.
float TEAM_LOCK_COLORS =        32;     // Allow only team colors
float TEAM_STATIC_TEAMS =       64;     // Don't allow players to switch teams
float TEAM_DROP_ITEMS =         128;    // Allow players to drop packs and 
float TEAM_CAPTURE_FLAG =       256;    // Play capture the flag
float TEAM_CAPTURE_CUSTOM =     512;        // custom models

float TEAM_CAPTURE_CAPTURE_BONUS = 15; // what you get for capture
float TEAM_CAPTURE_TEAM_BONUS = 10; // what your team gets for capture
float TEAM_CAPTURE_RECOVERY_BONUS = 1; // what you get for recovery
float TEAM_CAPTURE_FLAG_BONUS = 0; // what you get for picking up enemy flag
float TEAM_CAPTURE_FRAG_CARRIER_BONUS = 2; // what you get for fragging
	//enemy flag carrier
float TEAM_CAPTURE_FLAG_RETURN_TIME = 40; // seconds until auto return

// XXX EXPERT CTF Additional scoring system

// bonuses

float TEAM_CAPTURE_CARRIER_DANGER_PROTECT_BONUS = 2; // bonus for fraggin someone
// who has recently hurt your flag carrier
float TEAM_CAPTURE_CARRIER_PROTECT_BONUS = 1; // bonus for fraggin someone while
// either you or your target are near your flag carrier
float TEAM_CAPTURE_FLAG_DEFENSE_BONUS = 1; // bonus for fraggin someone while
// either you or your target are near your flag
float TEAM_CAPTURE_RETURN_FLAG_ASSIST_BONUS = 1; // awarded for returning a flag that causes a
// capture to happen almost immediately
float TEAM_CAPTURE_FRAG_CARRIER_ASSIST_BONUS = 2; // award for fragging a flag carrier if a
// capture happens almost immediately

// radii

float TEAM_CAPTURE_TARGET_PROTECT_RADIUS = 400; // the radius around an object being
// defended where a target will be worth extra frags
float TEAM_CAPTURE_ATTACKER_PROTECT_RADIUS = 400; // the radius around an object being
// defended where an attacker will get extra frags when making kills

// timeouts

float TEAM_CAPTURE_CARRIER_DANGER_PROTECT_TIMEOUT = 4;
float TEAM_CAPTURE_CARRIER_FLAG_SINCE_TIMEOUT = 2;
float TEAM_CAPTURE_FRAG_CARRIER_ASSIST_TIMEOUT = 6;
float TEAM_CAPTURE_RETURN_FLAG_ASSIST_TIMEOUT = 4;

float TEAM_CAPTURE_UPDATE_TIME = 120;

// END EXPERT CTF

// flag status used in cnt field of flag
float FLAG_AT_BASE = 0;
float FLAG_CARRIED = 1;
float FLAG_DROPPED = 2;
float FLAG_AT_HOME = 4;


// Prototypes
float() W_BestWeapon;
void() W_SetCurrentAmmo;
void() bound_other_ammo;
void(float o, float n) Deathmatch_Weapon;
void() BackpackTouch;

// Return a name for the color of a team
string(float Team) GetTeamColor =
{
	if(Team == 0) return("Blue");
	else if(Team == 1) return("Steel blue");
	else if(Team == 2) return("Brown");
	else if(Team == 3) return("Baby blue");
	else if(Team == 4) return("Green");
	else if(Team == 5) return("Red");
	else if(Team == 6) return("Olive");
	else if(Team == 7) return("Orange");
	else if(Team == 8) return("Peech");
	else if(Team == 9) return("Purple");
	else if(Team == 10) return("Majenta");
	else if(Team == 11) return("Grey");
	else if(Team == 12) return("Aqua");
	else if(Team == 13) return("Yellow");
	else if(Team == 14) return("Blue");
	return "Unknown";
};

// *XXX* EXPERT CTF
// Just a quickie to return the ASCII-ized team names for CTF
string(float Team) GetCTFTeam =
{

	if (Team == (TEAM_COLOR1 + 1)) return "“≈ƒ";
	if (Team == (TEAM_COLOR2 + 1)) return "¬Ã’≈";
	return "";

};


/*
================
TeamPrintSettings

Print out current teamplay options
================
*/

void() TeamPrintSettings =
{
	local string s;
	
	sprint(self,"The following Teamplay options are set:\n");
	
	if(teamplay < 0)
	{
		sprint(self, "Frag penalty manually set to ");
		s = ftos(teamplay);
		sprint(self, s);
		sprint(self, "\n");
		return;
	}
	
	if(!teamplay) 
	{
		sprint(self, "None\n");
		return;
	}
	
	if(1 == teamplay)
	{
		sprint(self, "ID's original teamplay 1\n");
		return;
	}
	
	if(teamplay & TEAM_HEALTH_PROTECT)
		sprint(self, "Health-Protect ");
	
	if(teamplay & TEAM_ARMOR_PROTECT)
		sprint(self, "Armor-Protect ");
		
	if(teamplay & TEAM_ATTACKER_DAMAGE)
		sprint(self, "Mirror-Damage ");
		
	if(teamplay & TEAM_FRAG_PENALTY)
		sprint(self, "Frag-Penalty ");
		
	if(teamplay & TEAM_DEATH_PENALTY)
		sprint(self, "Death-Penalty ");
		
	if(teamplay & TEAM_LOCK_COLORS)
		sprint(self, "Lock-Colors ");
		
	if(teamplay & TEAM_STATIC_TEAMS)
		sprint(self, "Static-Teams ");
		
	if(teamplay & TEAM_DROP_ITEMS)
		sprint(self, "Drop-Items (Backpack Impulse 20, Weapon Impulse 21) ");
		
	if(teamplay & TEAM_CAPTURE_FLAG)
		sprint(self, "Capture-The-Flag ");

	sprint(self, "\n");
};

/*
================
TeamArmorDam

Return TRUE if the target's armor can take damage from this attacker.
================
*/

float(entity targ, entity inflictor, entity attacker, float damage) TeamArmorDam =
{
        if((teamplay < 0) || gamestart)
                return TRUE;
        if( (teamplay & TEAM_ARMOR_PROTECT) && 
			(attacker.lastteam == targ.lastteam) && 
			(attacker != targ) && (targ.lastteam > 0) )
        {
                // Armor is protected
                return FALSE;
        }
        return TRUE;
};

/*
================
TeamHealthDam

Return TRUE if the target can take health damage from this attacker.
================
*/

float(entity targ, entity inflictor, entity attacker, float damage) TeamHealthDam =
{
        if((teamplay < 0) || gamestart)
        {
                return TRUE;
        }
        if( (attacker.lastteam == targ.lastteam) && 
			(attacker != targ) && (targ.lastteam > 0) )
        {
                // Attacker and target are on the same team.
                if( teamplay & TEAM_ATTACKER_DAMAGE )
                {
                        // Damage applied to teammate.
                        T_Damage(attacker, inflictor, attacker, damage);
                }
                if( teamplay & TEAM_HEALTH_PROTECT )
                {
                        // Health is protected
                        return FALSE;
                }
        }
        return TRUE;
};

/*
================
TeamPFrags

Return the number of frags we should penalize attacker for killing targ.
================
*/

float(entity targ, entity attacker) TeamPFrags =
{
        if( teamplay < 0 )
                return (-1 * teamplay);
        if( (targ.lastteam > 0) && (targ != attacker) && (targ.lastteam ==
			attacker.lastteam) )
        {
                // targ and attacker are on the same team
                if( teamplay < 0 )
                {
                        // teamplay indicates frag penalty
                        return ( -1 * teamplay );
                }
                if( teamplay & TEAM_FRAG_PENALTY )
                {
                        // default penalty
                        return TEAM_DEFAULT_PENALTY;
                }
        }
        // No frag penalty
        return 0;
};

/*
================
TeamFragPenalty

If attacker should be penalized for killing targ, penalize attacker
and return TRUE.
================
*/

float(entity targ, entity attacker) TeamFragPenalty =
{
        local float f;

        f = TeamPFrags(targ, attacker);

        if( f )
        {
                // We should penalize some frags.

                attacker.frags = attacker.frags - f;
                return TRUE;
        }
        // No penalty
        return FALSE;
};

/*
=================
TeamDeathPenalty

If attacker should be killed for killing targ, kill attacker and
add a frag to offset the one attacker will lose for killing himself.
*/

void(entity targ, entity attacker) TeamDeathPenalty =
{
        //Don't kill anyone if teamplay is negative.
        if ( teamplay < 0 )
                return;

        if ( (teamplay & TEAM_DEATH_PENALTY) && (targ.lastteam > 0) &&
			(attacker != targ) && (attacker.lastteam == targ.lastteam) )
        {
                //We should kill the attacker.
                local entity e;
                e = spawn();
                e.classname = "teamdeath";
                T_Damage(attacker,attacker,attacker,1000);
                remove(e);
                //Add a frag to offset the self-kill penalty.

                attacker.frags = attacker.frags + 1;
        }
};

/*
==================
TeamColorIsLegal

Return TRUE if the indicated color is legal
==================
*/
float(float color) TeamColorIsLegal =
{
        // All colors are legal if teamplay is negative.
        if( teamplay < 0 )
                return TRUE;
        // All colors are legal if TEAM_LOCK_COLORS is off.
        if( !(teamplay & TEAM_LOCK_COLORS) )
                return TRUE;
        if( (color == TEAM_COLOR1) && (TEAM_COLOR1 >= 0) )
                return TRUE;
        if( (color == TEAM_COLOR2) && (TEAM_COLOR2 >= 0) )
                return TRUE;
        if( (color == TEAM_COLOR3) && (TEAM_COLOR3 >= 0) )
                return TRUE;
        if( (color == TEAM_COLOR4) && (TEAM_COLOR4 >= 0) )
                return TRUE;
};

/*
==================
TeamCheckTeam

Check if the team self is on is legal, and put self in a legal team if not.
==================
*/
void() TeamCheckTeam =
{
        local float TEAM1, TEAM2, TEAM3, TEAM4, newcolor, t, rand;
        local entity p;
	local string n; 

	if( self.lastteam >= 0 )
	{
			if(TeamColorIsLegal(self.team - 1)) {
				self.lastteam = self.team;
				return;
			}
	}

	// Assign the player to a team.

	// Sum the players on all the teams.

        TEAM1 = TEAM2 = TEAM3 = TEAM4 = 0;

	p = find (world, classname, "player");

	while(p)
	{
		if (p != self) {
			if( (TEAM_COLOR1 >= 0) && (p.team == (TEAM_COLOR1 +1)) )
					TEAM1 = TEAM1 + 1;
			if( (TEAM_COLOR2 >= 0) && (p.team == (TEAM_COLOR2 +1)) )
					TEAM2 = TEAM2 + 1;
			if( (TEAM_COLOR3 >= 0) && (p.team == (TEAM_COLOR3 +1)) )
					TEAM3 = TEAM3 + 1;
			if( (TEAM_COLOR4 >= 0) && (p.team == (TEAM_COLOR4 +1)) )
					TEAM4 = TEAM4 + 1;
		}
		p = find(p, classname, "player");
	}

	// Find the team with the least players.
	newcolor = TEAM_COLOR1;
	t = TEAM1;

	if ( (TEAM_COLOR2 >= 0) && (TEAM2 < t) ) {
			newcolor = TEAM_COLOR2;
			t = TEAM2;
	}

	if ( (TEAM_COLOR3 >= 0) && (TEAM3 < t) ) {
			newcolor = TEAM_COLOR3;
			t = TEAM3;
	}

	if ( (TEAM_COLOR4 >= 0) && (TEAM4 < t) ) {
			newcolor = TEAM_COLOR4;
			t = TEAM4;
	}

	// Put the player on a the new team.
        StuffPlayerColor (newcolor);


	sprint(self, "You have been assigned color ");
	sprint(self, n);
	sprint(self, "\nLegal colors are:");
        if (TEAM_COLOR1 >= 0)
	{
                n = ftos(TEAM_COLOR1);
                sprint(self, " ");
                sprint(self, n);
	}
        if (TEAM_COLOR2 >= 0)
	{
                n = ftos(TEAM_COLOR2);
                sprint(self, " ");
                sprint(self, n);
	}
        if (TEAM_COLOR3 >= 0)
	{
                n = ftos(TEAM_COLOR3);
                sprint(self, " ");
                sprint(self, n);
	}
        if (TEAM_COLOR4 >= 0)
	{
                n = ftos(TEAM_COLOR4);
                sprint(self, " ");
                sprint(self, n);
	}

	sprint(self, "\n");

	self.lastteam = newcolor + 1;      // Remember what team we're on
	self.team = newcolor + 1;
};

/*
===============
TeamCheckLock

Check for team changing and perform whatever actions are neccessary.
===============
*/
void() TeamCheckLock =
{
        local entity e;
        local   float   n;
        local   string  s;

        // Don't do anything if teamplay is negative
        if ( teamplay < 0 )
                return;

        // for the oberserver patch
        if ((self.inferno_flag & OBSERVER_FLAG) || (self.inferno_flag & DO_OBSERVER_FLAG) || gamestart) {
                if (teamplay & TEAM_CAPTURE_FLAG) {
                        if (self.team != 12)
                                stuffcmd(self, "color 11\n");
//                        self.lastteam = 12;
                }
                return;
        }

        if (self.player_flag & TEAM_STUFF_COLOR) {
                self.player_flag = self.player_flag - TEAM_STUFF_COLOR;
                // make the player's team possible
                StuffPlayerColor(self.lastteam - 1);
//                stuffcmd(self, "color ");
//                n = self.lastteam - 1;
//                s = ftos(n);
//                stuffcmd(self, s);
//                stuffcmd(self, "\n");
                return;
        }

        if ( !TeamColorIsLegal(self.team - 1) && (self.team == self.lastteam)) {
			self.lastteam = -1;
		}

        // Check to see if the player has changed colors
        if ((self.team != self.lastteam) && (self.lastteam >= 0))
        {
                // Player has changed colors

                // If teams are static and we've been on some team already,
                // put us back on the team we were on.

                if ( (teamplay & TEAM_STATIC_TEAMS) && (self.lastteam >= 0) )
                {
                        if ( TeamColorIsLegal(self.lastteam - 1) )
                        {
                                // changing teams sucks, kill him

                                // if he has tried to change teams several
                                // times, kick him off the server.
                                if (self.suicide_count > 3) {
                                        sprint(self, "You were told you can't change teams.\nGo play color games somewhere else.\n");
                                        stuffcmd(self, "disconnect\n");
                                        bprint(self.netname);
                                        bprint(" has bad color sense\n");
                                }
                                // case base respawn
                                if (self.killed != 1)
                                        self.killed = 2;
                                e = spawn();
                                e.classname = "teamdeath";
                                T_Damage(self,e,self,1000);  // Kill the player
                                remove(e);
                                // trying to change teams counts as a suicide
                                self.suicide_count = self.suicide_count + 1;

                                dprint("DDT: ");
                                dprint(self.netname); dprint(" was killed for changing teams\n");
                                bprint(self.netname); bprint(" was killed for changing teams\n");
                                sprint(self, "You cannot change teams.\n");
                                stuffcmd(self, "color ");
                                n = self.lastteam - 1;
                                s = ftos(n);
                                stuffcmd(self, s);
                                stuffcmd(self, "\n");
                                self.team = self.lastteam;
                                return;
                        } else {
                                // If we're on an illegal team, force a change.
                                self.lastteam = -50;
                        }
                }

                // If teamlock is turned off, don't do anything more.
                if ( !(teamplay & TEAM_LOCK_COLORS) )
                {
                        self.lastteam = self.team;
                        return;
                }

                if (self.lastteam > 0) {
                        // case base respawn
                        if (self.killed != 1)
                                self.killed = 2;
                        e = spawn();
                        e.classname = "teamdeath";
                        T_Damage(self,e,self,1000);  // Kill the player
                        remove(e);
                }
                self.frags = 0;                 // Zero out frags
                self.died = 0;
                TeamCheckTeam();
        }


   
   if (self.netname == "" || self.netname == " " || self.netname == "\n") {
      stuffcmd(self, "name Player");
      stuffcmd(self, "\n");
      bprint("SERVER WARNING: –Ï·˘ÂÚ is trying to name spoof\n"); // Player
      self.name_warning_count = self.name_warning_count + 1;
      if (self.name_warning_count >= 3) {
              sprint(self, "SCTF Server: You were kicked for hiding your name\n");
              stuffcmd(self, "disconnect");
              stuffcmd(self, "\n");
              stuffcmd(self, "dsiconnect"); // some spoofs use this to disconnect
              stuffcmd(self, "\n");
      }
   }


};

/*
=======================
TossBackPack

Original idea by Vhold
Rewritten by John Spickes
Rewritten by [Inferno] (waije@titan.oit.umass.edu)

Toss out a backpack containing some ammo from your current weapon,
and any weapons you don't have.
=======================
*/
/* INFERNO:  I've basically changed the code totally!!  So you'll have
   to be facing a teammate to send them ammo.  The original code is still
   here but all commented out, so if you like the old one better, just
   uncomment the correct command-lines (if you know what I mean...) or just
   SIMPLY cut and paste from other mods (this is very popular :)

   --btw:  just been deleted so cut and paste (disk space)
*/
void() TossBackpack =
{
        local vector v;
        local entity oself;
        local float sh, na, ro, ce;

	// If we don't have any ammo, return
	if(self.currentammo <= 0)
		return;

/* INFERNO: rune check, you don't want some runes cheating with teammates..
   (but cool teamplay tho :)
*/
        if(self.rune == RUNE_POSEIDON && !(self.status_flag & ITEM_SECOND_RUNE)) {
                sprint(self, "You cannot throw the power of your trident!\n");
                return;
        }

        v=self.origin + '0 0 16';
        makevectors(self.v_angle);
        traceline(v, v + v_forward*2000, FALSE, self);
        if (trace_ent.classname!="player" || trace_ent.team != self.team) {
                sprint(self, "Can't be facing the world or enemy!\n");
                return;
        }

	// See if you have the Shotgun or Super Shotgun on
        if (self.weapon == IT_SHOTGUN || self.weapon == IT_SUPER_SHOTGUN) {
                if(self.ammo_shells >= 20) {
                        sh = 20;
			self.ammo_shells = self.ammo_shells - 20;
		}
                else 
		{
                        sh = self.ammo_shells;
			self.ammo_shells = 0;
		}
	}		
	
	// See if you have neither the Shotgun or Super Shotgun
        if ( !(self.items & IT_SHOTGUN) && !(self.items & IT_SUPER_SHOTGUN)) {
		if( self.ammo_shells >= 20 ) {
                        sh = 20;
			self.ammo_shells = self.ammo_shells - 20;
		}
		else
		{
                        sh = self.ammo_shells;
			self.ammo_shells = 0;
		}
	}		
	
	// See if we are using a nailgun
        if ( (self.weapon == IT_NAILGUN) || (self.weapon == IT_SUPER_NAILGUN) )
	{
		if( self.ammo_nails >= 20 )
		{
                        na = 20;
			self.ammo_nails = self.ammo_nails - 20;
		}
		else
		{
                        na = self.ammo_nails;
			self.ammo_nails = 0;
		}
	}	
	// Check to see if we have neither nailgun
        if ( !(self.items & IT_NAILGUN) && !(self.items & IT_SUPER_NAILGUN) )
	{
		if( self.ammo_nails >= 20 )
		{
                        na = 20;
			self.ammo_nails = self.ammo_nails - 20;
		}
		else
		{
                        na = self.ammo_nails;
			self.ammo_nails = 0;
		}
	}	
	
	// See if we are using a grenade or rocket launcher
        if ( (self.weapon == IT_GRENADE_LAUNCHER) || (self.weapon == IT_ROCKET_LAUNCHER) )
	{
		if( self.ammo_rockets >= 10 )
		{
                        ro = 10;
			self.ammo_rockets = self.ammo_rockets - 10;
		}
		else
		{
                        ro = self.ammo_rockets;
			self.ammo_rockets = 0;
		}
	}
	// See if we have neither the Grenade or rocket launcher
        if ( !(self.items & IT_GRENADE_LAUNCHER) && !(self.items & IT_ROCKET_LAUNCHER) )
	{
		if( self.ammo_rockets >= 10 )
		{
                        ro = 10;
			self.ammo_rockets = self.ammo_rockets - 10;
		}
		else
		{
                        ro = self.ammo_rockets;
			self.ammo_rockets = 0;
		}
	}

	// See if we're using the lightning gun
	if ( self.weapon == IT_LIGHTNING )
	{	
		if( self.ammo_cells >= 20 )
		{
                        ce = 20;
			self.ammo_cells = self.ammo_cells - 20;
		}
		else
		{
                        ce = self.ammo_cells;
			self.ammo_cells = 0;
		}
	}
	// see if we don't have the lightning gun
        if ( !(self.items & IT_LIGHTNING) )
	{	
		if( self.ammo_cells >= 20 )
		{
                        ce = 20;
			self.ammo_cells = self.ammo_cells - 20;
		}
		else
		{
                        ce = self.ammo_cells;
			self.ammo_cells = 0;
		}
	}

        trace_ent.ammo_shells=trace_ent.ammo_shells + sh;  // update the shells
        trace_ent.ammo_nails=trace_ent.ammo_nails + na;  // update the nails
        trace_ent.ammo_rockets=trace_ent.ammo_rockets + ro;  // update the rockets
        trace_ent.ammo_cells=trace_ent.ammo_cells + ce;  // update the cells
        sprint(trace_ent, self.classname);
        sprint(trace_ent, " just gave you some ammo!\n");
        oself=self;
        self=trace_ent;
        bound_other_ammo();
        self=oself;
	W_SetCurrentAmmo();
};


// the resistance key is gold keycard
//void() territory_resistance =
//{
//		remove(self);
//};

// the strength key is blue keycard
//void() territory_strength =
//{
//		remove(self);
//};

void(entity flg) RegenFlag =
{
	flg.movetype = MOVETYPE_TOSS;
	flg.solid = SOLID_TRIGGER;
	sound (flg, CHAN_VOICE, "items/itembk2.wav", 1, ATTN_NORM);	// play respawn sound
	setorigin(flg, flg.oldorigin);
	flg.angles = flg.mangle;
	flg.cnt = FLAG_AT_BASE; // it's at home base
   flg.owner = world;
};

void () TeamCaptureRegenFlags =
{
	local entity f;

	f = find(world, classname, "item_flag_team1");
	if (f != world)
		RegenFlag(f);
	f = find(world, classname, "item_flag_team2");
	if (f != world)
		RegenFlag(f);
};

void(entity flg) TeamCaptureReturnFlag =
{
	local entity p;

	RegenFlag(flg);

	p = find(world, classname, "player");
	while (p != world) {
      
             if (p.team != flg.team) 
                     UpdatePlayerStatus(p, "\n\n\n\n\n\n\n\n\n\n\nEnemy flag has been returned to base!\n", "", "");
             else if (p.team == flg.team) {
                     UpdatePlayerStatus(p, "\n\n\n\n\n\n\n\n\n\n\nYour flag has been returned to base!\n", "", "");
                     sound (other, CHAN_VOICE, "misc/medkey.wav", 1, ATTN_NONE);
             }
             p = find(p, classname, "player");
	}
};

void(entity flg) TeamDropFlag =
{
	local entity item, f, oself;
	local entity p;

	p = flg.owner;
        sound (other, CHAN_VOICE, "shalrath/pain.wav", 1, ATTN_NONE);

        bprint(p.netname);
        // did the person have their team's flag?
        if (p.inferno_flag & ITEM_YOUR_FLAG) {
                if (p.lastteam == TEAM_COLOR1 + 1)
                        bprint(" ÏÔÛÙ the “≈ƒ flag!\n"); // red
                else
                        bprint(" ÏÔÛÙ the ¬Ã’≈ flag!\n"); // blue
        } else

        // ok, the person must have had the enemy's flag
        if (p.player_flag & ITEM_ENEMY_FLAG) {
                if (p.lastteam == TEAM_COLOR1 + 1)
                        bprint(" ÏÔÛÙ the ¬Ã’≈ flag!\n"); // blue
                else
                        bprint(" ÏÔÛÙ the “≈ƒ flag!\n"); // red
        }// else if (p.nitems & NITEM_RESISTANCE) bprint(" lost the key to resistance!\n");
        //else if (p.nitems & NITEM_STRENGTH) bprint(" lost the key to strength!\n");

	LogMsg(p, "FLAG-DROP");

	flg.origin = p.origin - '0 0 24';
	flg.cnt = FLAG_DROPPED;
	//NOTE! We check lastteam here instead of team--this is because
	//in the mode where we change colors, we get killed
        flg.velocity_z = 600;//300;
	flg.velocity_x = 0;
	flg.velocity_y = 0;
	flg.flags = FL_ITEM;
	flg.solid = SOLID_TRIGGER;
	flg.movetype = MOVETYPE_TOSS;
	if (teamplay & TEAM_CAPTURE_CUSTOM)
		setsize(self, '-16 -16 0', '16 16 74');
	else
		setsize(item, '-16 -16 -24', '16 16 32');
	// return it after so long
	flg.super_time = time + TEAM_CAPTURE_FLAG_RETURN_TIME;

        flg.owner=world;
        if(flg.firewood!=world)flg.firewood.nitems=flg.firewood.nitems - (flg.firewood.nitems & flg.nitems);
        flg.firewood=world;
};

void(entity player) TeamCaptureDropFlagOfPlayer =
{
	local string kn;
	local entity e;

   if (!(player.player_flag & ITEM_ENEMY_FLAG) && !(player.inferno_flag & ITEM_YOUR_FLAG))
		return;
   if (player.player_flag & ITEM_ENEMY_FLAG) {
           if (player.lastteam == TEAM_COLOR1 + 1)
                   kn = "item_flag_team2";
           else
                   kn = "item_flag_team1";
   } else if (player.inferno_flag & ITEM_YOUR_FLAG) {
           if (player.lastteam == TEAM_COLOR1 + 1)
                   kn = "item_flag_team1";
           else
                   kn = "item_flag_team2";
   }

	e = find(world, classname, kn);
	if (e != world)
		TeamDropFlag(e);

   if (player.player_flag & ITEM_ENEMY_FLAG)
           player.player_flag = player.player_flag - ITEM_ENEMY_FLAG;
   else if (player.inferno_flag & ITEM_YOUR_FLAG)
           player.inferno_flag = player.inferno_flag - ITEM_YOUR_FLAG;
};

// remove initial invincibility when:
// 1. recover own flag
// 2. touch the enemy flag
// 3. pick up own flag
void() TeamCaptureFlagTouch =
{
	local entity p, oself;
   local float bon;

   // Pick your base!!
   if ((teamplay & TEAM_PICK_BASE) && (!team1_flag_picked || !team2_flag_picked))
           return;

   // forget about touching anything when this mode is on
   if (self.cnt == FLAG_THROWN) { // flagnextthink now
           FlagNextThing();
           return;
   }

	if (other.classname != "player")
		return;
	if (other.health <= 0)
		return;
	if (other.sicHound)     // don't let the bad guys touch a flag
		return;

	if (other.team != other.lastteam)
		return; // something is fishy, somebody is playing with colors

	if (self.team == other.team) {
      if (((other.inferno_flag & ITEM_GET_YOUR_FLAG) && 
         !(other.player_flag & ITEM_ENEMY_FLAG))) {

         takeOffInitialInvincibility (other);  // pick up own flag
         bprint(other.netname);
         if (other.team == TEAM_COLOR1 + 1)
                 bprint(" GOT THEIR TEAM'S (red) FLAG!!\n");  // red
         else
                 bprint(" GOT THEIR TEAM'S (blue) FLAG!!\n");  // blue
         other.items = other.items | self.items;
         sound (other, CHAN_ITEM, self.noise, 1, ATTN_NORM);
 
         // pick up the flag
         self.cnt = FLAG_CARRIED;
         self.movetype = MOVETYPE_NOCLIP;
         self.solid = SOLID_NOT;
         self.owner = other;
         other.inferno_flag = other.inferno_flag | ITEM_YOUR_FLAG;
         other.inferno_flag = other.inferno_flag - (other.inferno_flag & ITEM_GET_YOUR_FLAG);
         TeamPrint(self.team, "Your flag has been taken by one\nof your teammates!\n");
         sound (other, CHAN_VOICE, "misc/trigger1.wav", 1, ATTN_NONE);
         return;
      }
		// same team, if the flag is *not* at the base, return
		// it to base.  we overload the 'cnt' field for this
		if (self.cnt == FLAG_AT_BASE) {
			// the flag is at home base.  if the player has the enemy
			// flag, he's just won!

			if (other.player_flag & ITEM_ENEMY_FLAG) {
				bprint(other.netname);
				if (other.team == TEAM_COLOR1 + 1)
					bprint(" „·ÙıÚÂ‰ the ¬Ã’≈ flag!\n"); // blue
				else
					bprint(" „·ÙıÚÂ‰ the “≈ƒ flag!\n"); // red
				LogMsg(other, "FLAG-CAPTURE");
				other.items = other.items - (other.items & (IT_KEY1 | IT_KEY2));

				if (cvar("teamplay") & TEAM_CAPTURE_CUSTOM)
					sound (other, CHAN_VOICE, "misc/flagcap.wav", 1, ATTN_NONE);
				else
               sound (other, CHAN_VOICE, "boss2/pop2.wav", 1, ATTN_NONE);

				// other gets another 10 frag bonus
				other.frags = other.frags + TEAM_CAPTURE_CAPTURE_BONUS;
				// Ok, let's do the player loop, hand out the bonuses
				p = find(world, classname, "player");
				while (p != world) {
					self = p;
					self.killed = 0;
					if (self.team == other.team && self != other)
						self.frags = self.frags + TEAM_CAPTURE_TEAM_BONUS;

					if (self.team != other.team) {
                  UpdatePlayerStatus(self, "\n\n\n\n\n\n\n\n\n\n\nYour flag was captured!\n", "", "");
						// *XXX* EXPERT CTF
						// reset the last_hurt_carrier variable in all enemy players, so that you don't get
						// bonuses for defending the flag carrier if the flag carrier has already
						// completed a capture
						self.last_hurt_carrier = -5;
					} else if (self.team == other.team) {
						// done to all players on the capturing team
                  UpdatePlayerStatus(self, "\n \n \n \n \n \n \n \n \n \n \nYour team captured the flag!\n", "", "");

						// *XXX* EXPERT CTF
						// award extra points for capture assists
						if (self.last_returned_flag + TEAM_CAPTURE_RETURN_FLAG_ASSIST_TIMEOUT > time) {
							bprint(self.netname);
							bprint(" gets an assist for returning his flag!\n");
							self.frags = self.frags + TEAM_CAPTURE_RETURN_FLAG_ASSIST_BONUS;

						}
						if (self.last_fragged_carrier + TEAM_CAPTURE_FRAG_CARRIER_ASSIST_TIMEOUT > time) {
							bprint(self.netname);
							bprint(" gets an assist for fragging the flag carrier!\n");
							self.frags = self.frags + TEAM_CAPTURE_FRAG_CARRIER_ASSIST_BONUS;
						}
					}
					self.player_flag = self.player_flag - (self.player_flag & ITEM_ENEMY_FLAG);
					
					p = find(p, classname, "player");
				}
				// respawn flags
				TeamCaptureRegenFlags();
				return;
			}
			return; // its at home base already
		}

		// hey, its not home.  return it by teleporting it back
      takeOffInitialInvincibility (other);  // return own flag to base
		bprint(other.netname);
		if (other.team == TEAM_COLOR1 + 1)
			bprint(" ÚÂÙıÚÓÂ‰ the “≈ƒ flag!\n"); // red
		else
			bprint(" ÚÂÙıÚÓÂ‰ the ¬Ã’≈ flag!\n"); // blue
		LogMsg(other, "FLAG-RECOVERY");
      bon=0;
      if (pointcontents(self.origin)==CONTENT_SLIME ||
         pointcontents(self.origin)==CONTENT_LAVA)
         bon=1;
      other.frags = other.frags + TEAM_CAPTURE_RECOVERY_BONUS + bon;
		// *XXX* EXPERT CTF set time when player last returned his flag
		other.last_returned_flag = time;
		sound (other, CHAN_ITEM, self.noise1, 1, ATTN_NORM);
		TeamCaptureReturnFlag(self);
		return;
	}

   // does the person have his own flag?
   if (other.inferno_flag & ITEM_YOUR_FLAG) {
      UpdatePlayerStatus(other, "\n\n\n\n\n\n\n\n\n\nYou cannot get the flag cause\n you're already holding one!\n", "", "");
      return;
   }

	// hey, its not our flag, pick it up
   takeOffInitialInvincibility (other);  // pick up enemy flag
	bprint(other.netname);
	if (other.team == TEAM_COLOR1 + 1)
		bprint(" ÁÔÙ the ¬Ã’≈ flag!\n"); // blue
	else
		bprint(" ÁÔÙ the “≈ƒ flag!\n"); // red
	LogMsg(other, "FLAG-PICKUP");
   if (TEAM_CAPTURE_FLAG_BONUS) 
		other.frags = other.frags + TEAM_CAPTURE_FLAG_BONUS;

   UpdatePlayerStatus(other, "\n\n\n\n\n\n\n\n\nŸœ’ «œ‘ ‘»≈ ≈Œ≈ÕŸ ∆Ã¡«\n\n“≈‘’“Œ ‘œ ¬¡”≈\n", "", "");
   sound (other, CHAN_ITEM, self.noise, 1, ATTN_NORM);

   other.player_flag = other.player_flag + ITEM_ENEMY_FLAG;
	other.items = other.items | self.items;

	// *XXX* EXPERT CTF set the time at which the carrier picked up the flag
	other.flag_since = time;

	// pick up the flag
	self.cnt = FLAG_CARRIED;
	self.movetype = MOVETYPE_NOCLIP;
	self.solid = SOLID_NOT;
	self.owner = other;

	p = find(world, classname, "player");
	while (p != world) {
		if (p != other) {
         if (p.team != other.team) {
                 UpdatePlayerStatus(p, "\n\n\n\n\n\n\n\n\n\n\nYour flag has been taken!\n", "", "");
         } else if (p.team == other.team)
                 UpdatePlayerStatus(p, "\n\n\n\n\n\n\n\n\n\n\nYour team has the enemy flag!\n", "", "");
		}
		p = find(p, classname, "player");
	}
};

void() TeamCaptureFlagThink =
{
        local entity e;
	local vector v;
        local float f, team1found, team2found;
        local string s;
        local entity e1;

        team1found=0;
        team2found=0;

        if (self.cnt == FLAG_THROWN) {
                self.think = FlagNextThing;
                self.nextthink = time + 1;
                return;
        }

	self.nextthink = time + 0.1;

        if ((teamplay & TEAM_PICK_BASE) && (!team1_flag_picked || !team2_flag_picked)) {
                local entity e;

                if ((self.team == TEAM_COLOR1 + 1)&&(!team1_flag_pick)) {
                        self.flag_chooser=find(self.flag_chooser,classname,"player");
                        if(self.flag_chooser!=world && self.flag_chooser.team==self.team && random()<0.5&&
                        (!self.inferno_flag&OBSERVER_FLAG)) {
                                self.flag_chooser.flag_picked_time=0;
                                self.flag_chooser.pick_flag_base=1;
                                self.flag_chooser.flag_picked_time=time + 40;
                                team1_flag_pick=1;
                                UpdatePlayerStatus(self.flag_chooser,"Congrats, you get to pick a base now!\n\n\n\n\n\n\n\n\n\n\n\n","","");
                        }
                }
                if ((self.team == TEAM_COLOR2 + 1)&&(!team2_flag_pick)) {
                        self.flag_chooser=find(self.flag_chooser,classname,"player");
                        if(self.flag_chooser!=world && self.flag_chooser.team==self.team && random()<0.5 &&
                        (!self.inferno_flag&OBSERVER_FLAG)) {
//                                bprint("Hi!\n");
                                self.flag_chooser.flag_picked_time=0;
                                self.flag_chooser.pick_flag_base=1;
                                self.flag_chooser.flag_picked_time=time + 40;
                                team2_flag_pick=1;
                                UpdatePlayerStatus(self.flag_chooser,"Congrats, you get to pick a base now!\n\n\n\n\n\n\n\n\n\n\n\n","","");
                        }
                }
                if(max_time_to_pick && 
                  (max_time_to_pick < time)) {  // time's up dude
                        team1_flag_picked=1;
                        team2_flag_picked=1;
                        bprint("TIMEOUT!!!  ALL BASES SELECTED!\n");
                }
                return;
        }


        if (self.cnt == FLAG_AT_BASE || self.cnt == FLAG_AT_HOME) {
//                if(!droptofloor()&&self.count_count < time) { // we're in trouble now, the flag dropped!
//                        RegenFlag(self);
//                }
		return; // just sitting around waiting to be picked up
        }

	if (self.cnt == FLAG_DROPPED) {
		if (time - self.super_time > TEAM_CAPTURE_FLAG_RETURN_TIME)
			TeamCaptureReturnFlag(self);
		return;
	}

        if (self.cnt != FLAG_CARRIED)
		objerror("Flag in invalid state\n");

	e = self.owner;
        if (!(e.inferno_flag & ITEM_YOUR_FLAG)) {
                if ((e.classname != "player") || (e.deadflag) ||
                        (!(e.player_flag & ITEM_ENEMY_FLAG))) {
                        TeamDropFlag(self);
                        return;
                }
        }
	makevectors (e.angles);
	v = v_forward;
//dprint("fwd: ");
//s = vtos(v);
//dprint(s);
//dprint("\n");
//	if (v_z < 0) { 
//		v_z = (-1)*v_z; 
//		v = v + v * 1.2 * v_z; 
//	}
//dprint("adj: ");
//s = vtos(v);
//dprint(s);
//dprint("\n");
	v_z = (-1) * v_z; // reverse z component

	f = 14;
	if (self.owner.frame >= 29 && self.owner.frame <= 40) {
		if (self.owner.frame >= 29 && self.owner.frame <= 34) { //axpain
			if      (self.owner.frame == 29) f = f + 2; 
			else if (self.owner.frame == 30) f = f + 8;
			else if (self.owner.frame == 31) f = f + 12;
			else if (self.owner.frame == 32) f = f + 11;
			else if (self.owner.frame == 33) f = f + 10;
			else if (self.owner.frame == 34) f = f + 4;
		} else if (self.owner.frame >= 35 && self.owner.frame <= 40) { // pain
			if      (self.owner.frame == 35) f = f + 2; 
			else if (self.owner.frame == 36) f = f + 10;
			else if (self.owner.frame == 37) f = f + 10;
			else if (self.owner.frame == 38) f = f + 8;
			else if (self.owner.frame == 39) f = f + 4;
			else if (self.owner.frame == 40) f = f + 2;
		}
	} else if (self.owner.frame >= 103 && self.owner.frame <= 118) {
		if      (self.owner.frame >= 103 && self.owner.frame <= 104) f = f + 6;  //nailattack
		else if (self.owner.frame >= 105 && self.owner.frame <= 106) f = f + 6;  //light 
		else if (self.owner.frame >= 107 && self.owner.frame <= 112) f = f + 7;  //rocketattack
		else if (self.owner.frame >= 112 && self.owner.frame <= 118) f = f + 7;  //shotattack
	}
        // new effects
        if (e.pick_flag == 5)
                self.origin = e.origin + v_forward*-22 + v_up*-5;
        else if (e.pick_flag == 4) {
                self.origin = e.origin + '0 0 -16' - f*v + v_right * 22;
                self.angles = e.angles + '0 0 -45';
        } else if (e.pick_flag == 3) {
                self.origin = e.origin + '0 0 -16' - f*v + v_right * -22;
                self.angles = e.angles + '0 0 -45';
        } else if (e.pick_flag == 2) {
                self.origin = e.origin + v_forward*-22;
                self.velocity = v_right*44;
        } else {
                self.origin = e.origin + v_forward*-22;
                self.angles = e.angles + '0 0 -90';
        }
};

// self is player
entity() TeamCaptureSpawn =
{
	
        if (!(teamplay & TEAM_CAPTURE_FLAG))
		return world;

	if (self.team == TEAM_COLOR1 + 1) {
                if (flag_switched == 1) {
                        team1_lastspawn = find(team1_lastspawn, classname, "info_player_team2");
                        if (team1_lastspawn == world)
                                team1_lastspawn = find(team1_lastspawn, classname, "info_player_team2");
                        return team1_lastspawn;
                }
                team1_lastspawn = find(team1_lastspawn, classname, "info_player_team1");
                if (team1_lastspawn == world)
                        team1_lastspawn = find(team1_lastspawn, classname, "info_player_team1");
                return team1_lastspawn;
        } else {
                if (flag_switched == 1) {
                        team2_lastspawn = find(team2_lastspawn, classname, "info_player_team1");
                        if (team2_lastspawn == world)
                                team2_lastspawn = find(team2_lastspawn, classname, "info_player_team1");
                        return team2_lastspawn;
                }
		team2_lastspawn = find(team2_lastspawn, classname, "info_player_team2");
		if (team2_lastspawn == world)
			team2_lastspawn = find(team2_lastspawn, classname, "info_player_team2");
		return team2_lastspawn;
	}
	return world;
};

/*
	From byron@caseware.com Wed Oct 16 18:57:44 1996
	Date: Wed, 16 Oct 1996 21:22:37 -0400
	From: Byron Long <byron@caseware.com>
	To: zoid@mindlink.net
	Subject: Team Status Command (source code included) :-)

	A co-worker of mine wondered if it was possible to add a function to
	your capture the flag code that would give a status report on an
	impulse. I think he may have mailed you, but I wrote a quick version
	myself, which your welcome to use if you like the feature (it offsets
	some of the problems with the chat capabilities in Quake so it seems
	like a worthwhile feature). Feel free to change it
	as necessary.
*/

// *Capture The Flag - Status report by Wonko
void() TeamFlagStatusReport =
{
	local entity flag1, flag2, p;

	if (!(teamplay & TEAM_CAPTURE_FLAG)) {
		sprint(self, "Capture the Flag is not enabled.\n");
		return;
	}

	// Find the flags at home base
	flag1 = find (world,classname, "item_flag_team1");
	flag2 = find (world,classname, "item_flag_team2");

	// If on team 2 switch meanings of flags
	if (self.team != TEAM_COLOR1 + 1) {
		p = flag1;
		flag1 = flag2;
		flag2 = p;
	}

	if (flag1 != world && flag1.cnt == FLAG_CARRIED) {
		sprint(self, flag1.owner.netname);
		sprint(self, " has your flag. ");
	} else {
		sprint(self, "Your flag is ");
		if (flag1 == world)
			sprint(self, "missing! ");
		if (flag1.cnt == FLAG_AT_BASE)
			sprint(self, "in your base. ");
		else if (flag1.cnt == FLAG_DROPPED)
			sprint(self, "lying about. ");
		else
			sprint(self, " corrupt. ");
	}

	if (flag2 != world && flag2.cnt == FLAG_CARRIED) {
		if (self == flag2.owner) 
			sprint(self, "You have the enemy flag.\n");
		else {
			sprint(self, flag2.owner.netname);
			sprint(self, " has the enemy flag.\n");
		}
	} else {
		sprint(self, "The enemy flag is ");
		if (flag2 == world)
			sprint(self, "missing!\n");
		if (flag2.cnt == FLAG_AT_BASE)
			sprint(self, "in their base.\n");
		else if (flag2.cnt == FLAG_DROPPED)
			sprint(self, "lying about.\n");
		else
			sprint(self, " corrupt.\n");
	}
};

/////////////////////////////////////////////////////////////////////////

$cd id1/models/flag
$base base
$skin skin

void() place_flag;

void() FlagDropFloor = {
   if (self.count_count < time && !droptofloor()) {
		dprint ("Flag fell out of level at ");
		dprint (vtos(self.origin));
		dprint ("\n");
                remove(self);
                return;
   }
   self.oldorigin = self.origin;
   self.nextthink = time + 0.1;
};

void() place_flag = {
	self.mdl = self.model;		// so it can be restored on respawn
	self.flags = FL_ITEM;		// make extra wide
	self.solid = SOLID_TRIGGER;
	self.movetype = MOVETYPE_TOSS;	
	self.velocity = '0 0 0';
   self.think = TeamCaptureFlagThink;
   self.touch = TeamCaptureFlagTouch;
   self.nextthink = time + 0.1;
   self.cnt = FLAG_AT_BASE;
   self.mangle = self.angles;
   self.effects = self.effects | EF_DIMLIGHT;

   // 2 minutes to pick the flag's origin or else!!!
   max_time_to_pick = time + 240;

   // random bases...
   if (flag_switched == 1) {
           local entity e, e2;

           if (self.classname == "item_flag_team1") {
                   e = find(world,classname, "item_flag_team2");
                   if (e != world) 
                           self.origin = e.inforigin;
           }
           if (self.classname == "item_flag_team2") {
                   e = find(world,classname, "item_flag_team1");
                   if (e != world)
                           self.origin = e.inforigin;
           }
   }

	if (!droptofloor()) {
		dprint ("Flag fell out of level at ");
		dprint (vtos(self.origin));
		dprint ("\n");
      self.count_count = time + 10;  // can't try in 10 seconds, remove it
      self.nextthink = time + 1;
      self.think = FlagDropFloor;
      return;
      remove(self);
		return;
	}
        self.oldorigin = self.origin; // save for flag return

};

// INFERNO Super Capture, tells whether or not the entity is a flag..
float(entity flg) is_flag =
{
        if (flg.classname == "item_flag_team1" || flg.classname == "item_flag_team2")
                return TRUE;
        else return FALSE;
};

// ZOID Capture the flag
//void() item_flag_team2;  // what the team2 flag is
void() item_flag_team1 =
{
   if ((!(cvar("teamplay") & TEAM_CAPTURE_FLAG))) {
		remove(self);
		return;
	}

	self.team = TEAM_COLOR1 + 1;
	self.items = IT_KEY2;
	if (cvar("teamplay") & TEAM_CAPTURE_CUSTOM) {
                precache_model ("progs/flag.mdl");
                setmodel (self, "progs/flag.mdl");
		self.skin = 0;
		precache_sound ("misc/flagtk.wav");			// flag taken
		precache_sound ("misc/flagcap.wav");			// flag capture
		precache_sound ("doors/runetry.wav");
		self.noise = "misc/flagtk.wav";
		self.noise1 = "doors/runetry.wav";
		setsize(self, '-16 -16 0', '16 16 74');
	} else {
		precache_model ("progs/w_g_key.mdl");
		setmodel (self, "progs/w_g_key.mdl");

//                precache_sound ("misc/medkey.wav");
                  precache_sound2 ("shalrath/sight.wav");
                precache_sound2 ("shambler/ssight.wav");
//                precache_sound ("doors/meduse.wav");
                precache_sound2 ("boss2/pop2.wav");  // capture sound
                precache_sound ("misc/trigger1.wav");  // Team pick-up sound
//              precache_sound ("ogre/runetry.wav");
//                self.noise = "misc/medkey.wav";
                self.noise = "shalrath/sight.wav";  // taken flag sound
                self.noise1 = "shambler/ssight.wav";
                self.origin_z = self.origin_z + 24;
		setsize(self, '-16 -16 -24', '16 16 32');
	}

	self.origin_z = self.origin_z + 6;
        self.inforigin = self.origin;
	self.nextthink = time + 0.2;	// items start after other solids
	self.think = place_flag;
};

void() item_flag_team2 =
{
   if ((!(cvar("teamplay") & TEAM_CAPTURE_FLAG))) {
		remove(self);
		return;
	}

	self.team = TEAM_COLOR2 + 1;
	self.items = IT_KEY1;
	if (cvar("teamplay") & TEAM_CAPTURE_CUSTOM) {
                precache_model ("progs/flag.mdl");
                setmodel (self, "progs/flag.mdl");
		self.skin = 1;
		precache_sound ("misc/flagtk.wav");			// flag taken
		precache_sound ("misc/flagcap.wav");			// flag capture
		precache_sound ("doors/runetry.wav");
		self.noise = "misc/flagtk.wav";
		self.noise1 = "doors/runetry.wav";
		setsize(self, '-16 -16 0', '16 16 74');
	} else {
                precache_model ("progs/w_s_key.mdl");
                setmodel (self, "progs/w_s_key.mdl");

//                precache_sound ("misc/medkey.wav");
                  precache_sound2 ("shalrath/sight.wav");
                precache_sound ("shambler/ssight.wav");
                precache_sound ("misc/trigger1.wav");  // Team pick-up sound
//                precache_sound ("doors/meduse.wav");
                precache_sound2 ("boss2/pop2.wav");  // capture sound
//              precache_sound ("ogre/runetry.wav");
//                self.noise = "misc/medkey.wav";
                self.noise = "shalrath/sight.wav";  // taken flag sound
                self.noise1 = "shambler/ssight.wav";
                self.origin_z = self.origin_z + 24;
		setsize(self, '-16 -16 -24', '16 16 32');
	}

        // Check to see if the origin needs to be used
        if (teamplay & TEAM_RANDOM_BASES) {
//                if (random() < 0.5) {
                        local entity e;
                        e = find(world, classname, "item_flag_team1");
                        self.origin = e.origin;
                        setorigin(self, e.origin);
//                }
        }

	// make it glow
        self.origin_z = self.origin_z + 6;
        self.inforigin = self.origin;
	self.nextthink = time + 0.2;	// items start after other solids
	self.think = place_flag;
};

void() TeamCaptureSetUpdate = 
{
	nextteamupdtime = time + TEAM_CAPTURE_UPDATE_TIME;
};

