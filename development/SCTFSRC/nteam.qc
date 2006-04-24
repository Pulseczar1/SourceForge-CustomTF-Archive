/* nteam.qc - by inferno (waije@titan.oit.umass.edu), has
everything I (inferno) added on for extra teamplay stuff
*/
float (float gweapon) W_BestNWeapon;
string (float runekind) RuneDescription;
string (float f) GetPowerLevel;
void(entity who) eeMarquee;


void() togglePlayerId =
{
    if (self.playerId) {
       self.playerId = 0;
       sprint(self,"player ID is now OFF\n");
    }
    else {
       self.playerId = 1;
       sprint(self,"player ID is now ON\n");
    }
};

void(float newcolor) StuffPlayerColor =
{
        local float rand, ppp, pppp;
        local string n;

        // set the random things
        rand = random()*10;
        pppp = random();

        // now to create a color
        ppp = 0;
        while (rand >= 0) {
                if (ppp == 9) {
                        if (pppp < 0.2)
                                ppp = 9;
                        else if (pppp < 0.4)
                                ppp = 10;
                        else if (pppp < 6)
                                ppp = 11;
                        else if (pppp < 8)
                                ppp = 12;
                        else ppp = 13;
                }
                rand = rand - 1;
                ppp = ppp + 1;
        }
                
        // what is the shirt color?
        if (ppp == 4 || ppp == 13) // Don't assign other teams color
           ppp = ppp - 1;
        n = ftos(ppp);
           
        // stuff the color to the player
        stuffcmd(self, "color ");
        stuffcmd(self, n);

        // now stuff the other color
        n = ftos(newcolor);
        stuffcmd(self, " ");
        stuffcmd(self, n);
        stuffcmd(self, "\n");
};

// SCTF status for player by inferno (waije@titan.oit.umass.edu)
void(entity who, string s4, string s5, string s7) UpdatePlayerStatus =
{
   local string s1, s2, s3, s6, blue_stat, red_stat, team_stat;
   local float total1, total2, wpower;
   local entity frinder, e;

   // if the player id is on, then only that gets displayed, even
   // if they are observer
   if (who.playerId)
   {
      // sprint(who,"checking playerid\n");
      local entity e1;
      e1 = world;
      local vector dir;
      dir = aim(who, 1000);
      makevectors (who.v_angle);
      traceline (who.origin, who.origin + v_forward*5000, FALSE, who);
      if (trace_fraction <  1) {
         // sprint(who,"classname="); 
         // sprint(who,trace_ent.classname); 
         // sprint(who,"\n");
         if (trace_ent.classname == "player") {
            // sprint(who,"playerfound\n");
            e1 = trace_ent;
            s1 = s2 = s3 = s4 = s5 = s6 = s7 = "";
            s5 = "PlayerID: ";
            s7 = e1.netname;
            s1 = "\n";
            if (e1.rune)
            {
               s6 = e1.runeName;
               s3 = "\n";
               if (e1.status_flag & ITEM_SECOND_RUNE)
               s2 = e1.power2;
               else
                  s2 = e1.power1;
            }
            else
               s6 = "NoRune";
            ncenterprint(who, s4, s5, s7, s1, s6, s3, s2);
            who.update_time = time + 0.5;
            return;
         }
      }
   }



   // cannot have status on while being an observer or motd is on
   if (who.motd_time && !(self.inferno_flag & OBSERVER_FLAG))
           return;

   // special handling for when a player first picks up the rune
   if (who.newRune)
   {
      ncenterprint(who, "","\n   ",who.runeName,"\n\n",who.power1,"\n\n",who.power2);
      if (who.newRune < 3)
         who.newRune = who.newRune + 1;
      else 
         who.newRune = 0;
      return;
   }

   // get the scores
   if ((teamplay & TEAM_CAPTURE_FLAG)) {
           frinder = find(world, classname, "player");
           while (frinder)
           {
                   if (frinder.team == TEAM_COLOR1 + 1)
                           total1 = total1 + frinder.frags;
                   if (frinder.team == TEAM_COLOR2 + 1)
                           total2 = total2 + frinder.frags;
                   frinder = find(frinder, classname, "player");
           }

           if (total1 > total2)
                   s2 = ftos(total1 - total2);
           else if (total2 > total1)
                   s2 = ftos(total2 - total1);

   } else s2 = ftos((who.frags*60*60)/(time));  // else count Frags Per Minute

   s1 = who.runeName;
   
   if ((teamplay & TEAM_CAPTURE_FLAG)) {
           if (total1 > total2)
                   s3 = "     “≈ƒ ";
           else if (total2 > total1)
                   s3 = "     ¬ÏıÂ ";
           else if (total1 == total2)
                   s3 = "     TIED ";
           if (total1 == 0 && total2 == 0) 
                   if (teamplay & TEAM_CAPTURE_FLAG)  
                   {
                      if (!who.rune) 
                           s3 = " Super Capture ";
                   }
   } else
           s3 = "        FPM:";

   // makesure the person has sctfstatus on
   if (!(who.status_flag & STATUS_PLAYER_FLAG))
           s1 = s2 = s3 = "";
   
   if (who.status_flag & ITEM_SECOND_RUNE) 
      s6 = who.power2;
   else 
      s6 = who.power1;

   
   // dont distplay strings s1 and s6 when observer
   if ((who.inferno_flag & OBSERVER_FLAG)) {
           s6 = "";
           s1 = "  ";
           s4="";
           s5 = "\n\n\n\n\n\n\n\n\n\n\nSuper Capture the Flag\n";
           if (who.chase_observer != world) {
                   s6="";
                   s7 = who.chase_observer.runeName;
                   s3=who.chase_observer.netname;
                   s2="\n";
           }
           else s7 = "";
   }
   if ((who.flag_picked_time >= time)&&!(who.inferno_flag&OBSERVER_FLAG)) {
           s4 = ftos(who.flag_picked_time - time);
           s5 = " seconds until you must\nplace your flag!\nUse your axe!!\n\n\n\n\n\n\n\n\n\n";
           s7 = "";
   }

   // oh really, the rune descriptions cannot be overwritten
   // runed_flag is a toggle which says whether to display runedesc.
   if (who.inferno_flag & RUNED_FLAG) 
   {
       if (who.rune) {
         s4 = who.message;
         s5 = s7 = "";
       }
       else {
         s4 = "You need a rune to see its description!\n\n\n\n\n\n\n\n\n\n\n\n";
          s5 = s7 = "";
       }
   }
   else if (who.eeFlag)
   {
      eeMarquee(who);
      self.update_time = time + 0.25;
      return;
   }

   // powerlevel, please show them your power level
   if (s4=="\n\n\n\n\n\n\n\n\n\n\n\n"&&s5==""&&s7==""&&!gamestart){
           s4=GetPowerLevel(who.powerlevel);        
           e = find(world, classname, "item_flag_team1");
           if (e.cnt == FLAG_AT_BASE)
                   s5="   ù û"; // Blank Red Flag Status
           else if (e.cnt == FLAG_CARRIED)
                   s5="   ù“û"; // Red Flag picked up  ù û ü
           else    s5="   ùRû"; // Red Flag dropped    < - >

           e = find(world, classname, "item_flag_team2");
           if (e.cnt == FLAG_AT_BASE)
                   s7=" ü\n";
           else if (e.cnt == FLAG_CARRIED)
                   s7="¬ü\n";  // Blue flag picked up
           else    s7="Bü\n";  // Blue flag droppeds6 = " -srune";  // -srune    
   }

   // you are the chosen one, now choose a base!!!
   if((teamplay&TEAM_PICK_BASE)&&(who.pick_flag_base)&&!(who.inferno_flag&OBSERVER_FLAG)) s1="Pick a Homebase";

   if (gamestart && (voteexit_time >= 0)) {
           s2 = ftos(voteexit_time - time);
           if(s4==""||((s4=="\n\n\n\n\n\n\n\n\n\n\n\n"||s5=="\n\n\n\n\n\n\n\n\n\n\n\n")&&vote_leader!=world)){if(s4=="\n\n\n\n\n\n\n\n\n\n\n\n")s4="\n\n\n\n\n\n\n\n\n\n\n";if(s5=="\n\n\n\n\n\n\n\n\n\n\n\n")s5="\n\n\n\n\n\n\n\n\n\n\n";}
           if (vote_leader != world)
                   ncenterprint(who, s1, s6, "\n", vote_leader.message, " leads\n", s2, " seconds until exit");
           else ncenterprint(who, s4, s5, s7, s1, s6, "\nChoose an exit...Super Capture The Flag", "");
   } else ncenterprint(who, s4, s5, s7, s1, s6, s3, s2);

   self.update_time = time + 1.75;
};

void() PlayerBlock =
{
        if(self.pl_block||self.powerlevel<4)return;
        self.pl_block=1;
        self.attack_finished=time+1;
        self.pl_block_time=time+4;  // lasts for two seconds
        // now take away energy points
        self.powerlevel=self.powerlevel - 4;  // awww, 6 taken away
        UpdatePlayerStatus(self, "\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
};

void(float theteam, string j) TeamPrint =
{
        local entity ppp;

        ppp = find(world, classname, "player");
        while (ppp != world)
        {
                if (ppp.team == theteam)
                        UpdatePlayerStatus(ppp, "\n\n\n\n\n\n\n\n\n\n", j, "");
                ppp = find(ppp, classname, "player");
        }
};

/* Throw weapon, so people can throw weapons at eachother
   for helpfulness
*/

void() Team_weapon_touch =
{
        local float hadammo, best, new, old;
	local entity stemp;

	if (!(other.flags & FL_CLIENT))
		return;
	// Don't let the owner pick up his own weapon for a second.
	if ( (other == self.owner) && ( (self.nextthink - time) > 119 ) )
		return;

// if the player was using his best weapon, change up to the new one if better		
	stemp = self;
	self = other;
	best = W_BestWeapon();
	self = stemp;

	if (self.classname == "weapon_nailgun")
	{
		hadammo = other.ammo_nails;			
		new = IT_NAILGUN;

// *WEAPON COUNT*
                if ((teamplay & TEAM_COUNT_WEAPONS)) 
                        other.n_count = other.n_count + 1;
	}
	else if (self.classname == "weapon_supernailgun")
	{
		hadammo = other.ammo_rockets;			
		new = IT_SUPER_NAILGUN;

// *WEAPON COUNT*
                if ((teamplay & TEAM_COUNT_WEAPONS)) 
                        other.sn_count = other.sn_count + 1;
	}
	else if (self.classname == "weapon_supershotgun")
	{
		hadammo = other.ammo_rockets;			
		new = IT_SUPER_SHOTGUN;

// *WEAPON COUNT*
                if ((teamplay & TEAM_COUNT_WEAPONS)) 
                        other.ss_count = other.ss_count + 1;
	}
	else if (self.classname == "weapon_rocketlauncher")
	{
		hadammo = other.ammo_rockets;			
		new = IT_ROCKET_LAUNCHER;

// *WEAPON COUNT*
                if ((teamplay & TEAM_COUNT_WEAPONS)) 
                        other.rl_count = other.rl_count + 1;
	}
	else if (self.classname == "weapon_grenadelauncher")
	{
		hadammo = other.ammo_rockets;			
		new = IT_GRENADE_LAUNCHER;

// *WEAPON COUNT*
                if ((teamplay & TEAM_COUNT_WEAPONS)) 
                        other.gl_count = other.gl_count + 1;
	}
	else if (self.classname == "weapon_lightning")
	{
		hadammo = other.ammo_rockets;			
		new = IT_LIGHTNING;

// *WEAPON COUNT*
                if ((teamplay & TEAM_COUNT_WEAPONS)) 
                        other.rl_count = other.rl_count + 1;
        }
	else
		objerror ("Team_weapon_touch: unknown classname");

	sprint (other, "You got the ");
	sprint (other, self.netname);
	sprint (other, "\n");
// weapon touch sound
	sound (other, CHAN_ITEM, "weapons/pkup.wav", 1, ATTN_NORM);
	stuffcmd (other, "bf\n");

	bound_other_ammo ();

// change to the weapon
	old = other.items;
	other.items = other.items | new;
	
	remove(self);
	self = other;

   Deathmatch_Weapon (old, new);


// make sure the weapon is appropriate
        self.nweapon = W_BestNWeapon(self.weapon);

	W_SetCurrentAmmo();

	activator = other;
	SUB_UseTargets();				// fire all targets / killtargets
};
        
/* INFERNO:  this was rewritten to match the code of tossbackpack so
   people can only GIVE teammates the weapon, otherwise it just creates
   lag and that ain't good.  (TOTALLY rewritten BTW, cut and paste from
   another mod if you want this back...)
*/
void() TossWeapon =
{
        local vector v;
	
        if (deathmatch != 1 || self.weapon == IT_AXE || self.weapon == IT_SHOTGUN)
		return;  // only in deathmatch 1
		
/* INFERNO:  don't want to have teammates cheating because of the
   runes they have.
*/
        if(self.rune == RUNE_POSEIDON && !(self.status_flag & ITEM_SECOND_RUNE)) {
                sprint(self, "Can't throw your trident!\n");
                return;
        }

        v=self.origin + '0 0 16';
	makevectors(self.v_angle);
        traceline(v, v + v_forward*2000, FALSE, self);
        if (trace_ent.classname != "player" || trace_ent.team != self.team) {
                sprint(self, "Can't be facing the world or the enemy!\n");
                return;
        }

	if(self.weapon == IT_SUPER_SHOTGUN)
	{
// *WEAPON COUNT*
                if (teamplay & TEAM_COUNT_WEAPONS) {
                        if (self.ss_count > 1)
                                self.ss_count = self.ss_count - 1;
                        else {
                                self.items = self.items - IT_SUPER_SHOTGUN;
                                self.ss_count = 0;
                        }
                } else
                        self.items = self.items - IT_SUPER_SHOTGUN;
	}

        if(self.weapon == IT_NAILGUN)
	{
// *WEAPON COUNT*
                if (teamplay & TEAM_COUNT_WEAPONS) {
                        if (self.n_count > 1)
                                self.n_count = self.n_count - 1;
                        else {
                                self.items = self.items - IT_NAILGUN;
                                self.n_count = 0;
                        }
                } else
                        self.items = self.items - IT_NAILGUN;
	}
		
        if(self.weapon == IT_SUPER_NAILGUN)
	{
// *WEAPON COUNT*
                if (teamplay & TEAM_COUNT_WEAPONS) {
                        if (self.sn_count > 1)
                                self.sn_count = self.sn_count - 1;
                        else {
                                self.items = self.items - IT_SUPER_NAILGUN;
                                self.sn_count = 0;
                        }
                } else
                        self.items = self.items - IT_SUPER_NAILGUN;
	}
	
        if(self.weapon == IT_GRENADE_LAUNCHER)
	{
// *WEAPON COUNT*
                if (teamplay & TEAM_COUNT_WEAPONS) {
                        if (self.gl_count > 1)
                                self.gl_count = self.gl_count - 1;
                        else {
                                self.items = self.items - IT_GRENADE_LAUNCHER;
                                self.gl_count = 0;
                        }
                } else
                        self.items = self.items - IT_GRENADE_LAUNCHER;
	}
	
        if(self.weapon == IT_ROCKET_LAUNCHER)
	{
// *WEAPON COUNT*
                if ((teamplay & TEAM_COUNT_WEAPONS)) {
                        if (self.rl_count > 1)
                                self.rl_count = self.rl_count - 1;
                        else {
                                self.items = self.items - IT_ROCKET_LAUNCHER;
                                self.rl_count = 0;
                        }
                } else
                        self.items = self.items - IT_ROCKET_LAUNCHER;
	}
	
        if(self.weapon == IT_LIGHTNING)
	{
// *WEAPON COUNT*
                if (teamplay & TEAM_COUNT_WEAPONS) {
                        if (self.l_count > 1)
                                self.l_count = self.l_count - 1;
                        else {
                                self.items = self.items - IT_LIGHTNING;
                                self.l_count = 0;
                        }
                } else 
                        self.items = self.items - IT_LIGHTNING;
	}
        trace_ent.items = trace_ent.items | self.weapon;  // give the person the weapon
        sprint(trace_ent, self.netname);
        sprint(trace_ent, " just gave you a ");
        if(self.weapon==IT_SUPER_SHOTGUN)sprint(trace_ent,"super shotgun!\n");
        else if(self.weapon==IT_NAILGUN)sprint(trace_ent,"nailgun!\n");
        else if(self.weapon==IT_SUPER_NAILGUN)sprint(trace_ent,"super nailgun!\n");
        else if(self.weapon==IT_GRENADE_LAUNCHER)sprint(trace_ent,"grenade launcher!\n");
        else if(self.weapon==IT_ROCKET_LAUNCHER)sprint(trace_ent,"rocket launcher!\n");
        else if(self.weapon==IT_LIGHTNING)sprint(trace_ent,"thunderbolt!\n");
        else sprint(trace_ent,"'have no idea'!\n");
        
	self.weapon = W_BestWeapon();
        self.nweapon = W_BestNWeapon(self.weapon);
	W_SetCurrentAmmo();
};

/* Toss armor - made possible by Inferno (waije@titan.oit.umass.edu)
  You are able to throw armor around to help your teammates
*/
void() Team_armor_touch =
{
	if (!(other.flags & FL_CLIENT))
		return;
	// Don't let the owner pick up his own weapon for a second.
	if ( (other == self.owner) && ( (self.nextthink - time) > 119 ) )
		return;
        if (self.armorvalue > 200)
                return;

// if the player was using his best weapon, change up to the new one if better		
        if (self.classname == "item_armor1")
	{
                if (other.items & (IT_ARMOR2 | IT_ARMOR3))
                        return;

                if (!(other.items & IT_ARMOR1))
                        other.items = other.items | IT_ARMOR1;
                other.armorvalue = other.armorvalue + self.count_count;
	}
        else if (self.classname == "item_armor2")
	{
                if (other.items & (IT_ARMOR3))
                        return;

                if (!(other.items & IT_ARMOR2))
                        other.items = other.items | IT_ARMOR2;
                if (other.items & IT_ARMOR1)
                        other.items = other.items - IT_ARMOR1;
                other.armorvalue = other.armorvalue + self.count_count;
	}
        else if (self.classname == "item_armor3")
	{
                if (!(other.items & IT_ARMOR3))
                        other.items = other.items | IT_ARMOR3;
                if ((other.items & IT_ARMOR2) || (other.items & IT_ARMOR1))
                        other.items = other.items - (IT_ARMOR1 | IT_ARMOR2);
                other.armorvalue = other.armorvalue + self.count_count;
	}
	else
                objerror ("Team_armor_touch: unknown classname");

	sprint (other, "You got the ");
	sprint (other, self.netname);
	sprint (other, "\n");
// armor touch sound
        sound (other, CHAN_ITEM, "items/armor1.wav", 1, ATTN_NORM);
	stuffcmd (other, "bf\n");

        remove(self);
};

void() TossArmor =
{
        local entity item;
        local float removeitem;
	
	if (deathmatch != 1)
                return;  // only on deathmatch 1

        if (self.armorvalue == 0)
		return;
		
	item = spawn();
	item.owner = self;
	makevectors(self.v_angle);

	setorigin(item, self.origin + '0 0 16');
	item.velocity = aim(self, 1000);
	item.velocity = item.velocity * 500;
	item.flags = FL_ITEM;
	item.solid = SOLID_TRIGGER;
	item.movetype = MOVETYPE_BOUNCE;
        setmodel (item, "progs/armor.mdl");
        item.count_count = 20;
	
        if (self.items & IT_ARMOR1)
	{
                item.skin = 0;
                item.classname = "item_armor1";
                if (item.count_count == self.armorvalue) {
                        removeitem = 1;
                        self.armorvalue = 0;
                }
                if (item.count_count > self.armorvalue) {
                        removeitem = 1;
                        item.count_count = self.armorvalue;
                        self.armorvalue = 0;
                }
                if (removeitem)
                        self.items = self.items - IT_ARMOR1;

                if (self.armorvalue != 0)
                        self.armorvalue = self.armorvalue - item.count_count;

                item.netname = "green armor";
        }

        if (self.items & IT_ARMOR2)
	{
                item.skin = 1;
                item.classname = "item_armor2";
                if (item.count_count == self.armorvalue) {
                        removeitem = 1;
                        self.armorvalue = 0;
                }
                if (item.count_count > self.armorvalue) {
                        removeitem = 1;
                        item.count_count = self.armorvalue;
                        self.armorvalue = 0;
                }
                if (removeitem)
                        self.items = self.items - IT_ARMOR2;

                if (self.armorvalue != 0)
                        self.armorvalue = self.armorvalue - item.count_count;

                item.netname = "yellow armor";
	}
		
        if (self.items & IT_ARMOR3)
	{
                item.skin = 2;
                item.classname = "item_armor3";
                if (item.count_count == self.armorvalue) {
                        removeitem = 1;
                        self.armorvalue = 0;
                }
                if (item.count_count > self.armorvalue) {
                        removeitem = 1;
                        item.count_count = self.armorvalue;
                        self.armorvalue = 0;
                }
                if (removeitem)
                        self.items = self.items - IT_ARMOR3;

                if (self.armorvalue != 0)
                        self.armorvalue = self.armorvalue - item.count_count;

                item.netname = "red armor";
	}

	setsize(item, '-16 -16 0', '16 16 56');
        item.touch = Team_armor_touch;
        item.think = SUB_Remove;
        item.nextthink = time + 60;  // if no one touches it, heh, remove
};

/* From this line on, capture the flag... */
// return the flag
void() ReturnFlag =
{
        local entity flag1, flag2;
        if (!(self.inferno_flag & ITEM_YOUR_FLAG) ||
        ((((self.team == TEAM_COLOR1 + 1) && !team1_flag_picked) ||
        ((self.team == TEAM_COLOR2 + 1) && !team2_flag_picked)) &&
        (teamplay & TEAM_PICK_BASE))) {
                sprint(self, "You don't even have your own flag!!\n");
                return;
        }
        bprint(self.netname);
        flag1 = find (world,classname, "item_flag_team1");
        flag2 = find (world,classname, "item_flag_team2");
        if (self.team == TEAM_COLOR1 + 1)
                bprint(" ÚÂÙıÚÓÂ‰ the “≈ƒ flag!\n"); // returned the red flag
        else
                bprint(" ÚÂÙıÚÓÂ‰ the ¬Ã’≈ flag!\n"); // returned the blue flag
        LogMsg(other, "FLAG-RETURN");
        // *XXX* EXPERT CTF set time when player last returned his flag
        self.last_returned_flag = time;
//        sound (other, CHAN_ITEM, self.noise1, 1, ATTN_NORM);
        if (self.team != TEAM_COLOR1 + 1) {
                TeamCaptureReturnFlag(flag2);
                flag2.cnt = FLAG_AT_BASE;
        } else {
                TeamCaptureReturnFlag(flag1);
                flag1.cnt = FLAG_AT_BASE;
        }
        self.items = self.items - (self.items & (IT_KEY1 | IT_KEY2));
        self.inferno_flag = self.inferno_flag - 
         (self.inferno_flag & ITEM_YOUR_FLAG);
};

// just so when a person throws a flag, he doesn't
// automatically get it
void() FlagNextThing =
{
        if (!droptofloor())
        {
                self.cnt = FLAG_AT_BASE;
                TeamCaptureReturnFlag(self);
                if (self.team == TEAM_COLOR1 + 1)
                        bprint("RED flag has been returned to base\n");
                else bprint("BlUE flag has been returned to base\n");
        } else self.cnt = FLAG_DROPPED;
//        self.movetype = MOVETYPE_TOSS;
        self.think = TeamCaptureFlagThink;
        self.nextthink = time + 0.01;
};

// throw the enemy flag
void(entity flagg) ThrowFlag =
{
// tell everybody the news
        bprint(self.netname);
        if (self.team == TEAM_COLOR1 + 1)
                bprint(" THROWN the ¬Ã’≈ flag!\n"); // blue
        else
                bprint(" THROWN the “≈ƒ flag!\n"); // red

        self.player_flag = self.player_flag - ITEM_ENEMY_FLAG;
        self.items = self.items - (self.items & (IT_KEY1 | IT_KEY2));

//        traceline(self.origin + '0 0 16', self.origin + '0 0 16' + v_forward*400, FALSE, self);
//        flagg.origin = trace_endpos;
//        setorigin(flagg, trace_endpos);

        // make sure the flag goes far enough so the person won't get it

        flagg.cnt = FLAG_THROWN;
        flagg.velocity = aim(self, 10000);
        flagg.velocity = flagg.velocity * 1000;
        flagg.origin = flagg.owner.origin + '0 0 24' + v_forward*100;
        setorigin(flagg, flagg.owner.origin + '0 0 24' + v_forward*100);
        flagg.flags = FL_ITEM;
        flagg.solid = SOLID_TRIGGER;
        flagg.movetype = MOVETYPE_FLY;
        // return it after so long
        flagg.super_time = time + TEAM_CAPTURE_FLAG_RETURN_TIME;
        flagg.owner=world;
};

/* Put it the nail for the flag (in pick your base mode) */
void() NailForFlagTouch =
{
        local entity e1;

        if((other==self.owner)||(self.movetype=MOVETYPE_NONE))return;
        self.movetype=MOVETYPE_NONE;
        self.solid=SOLID_NOT;
        self.velocity = '0 0 0';
        self.owner.pick_flag_base=0;
        if(self.team==TEAM_COLOR1 + 1){
                team1_flag_picked=1;
                e1 = find(world,classname,"item_flag_team1");
                e1.inforigin=self.origin;
                setorigin(e1,self.origin);
                setmodel(self, "progs/grenade.mdl");
        }
        if(self.team==TEAM_COLOR2 + 1){
                team2_flag_picked=1;
                e1 = find(world,classname,"item_flag_team2");
                e1.inforigin=self.origin;
                setorigin(e1,self.origin);
                setmodel(self, "progs/grenade.mdl");
        }
        setsize(self, '0 0 0', '0 0 0');
        self.mdl = self.model;
};

void() FireNailForFlag =
{
        local vector dir;
        local entity nailent;
        local entity e1;

        dir=aim(self, 1000);
        nailent=spawn();
        nailent.owner=self;

//        if((other==self.owner)||(self.movetype=MOVETYPE_NONE))return;
        setorigin(nailent,self.origin);
        nailent.movetype=MOVETYPE_NONE;
        nailent.solid=SOLID_NOT;
        nailent.velocity = '0 0 0';
        nailent.owner.pick_flag_base=0;
        if(self.team==TEAM_COLOR1 + 1){
                bprint("RED has chosen their spot!\n");
                team1_flag_picked=1;
                e1 = find(world,classname,"item_flag_team1");
                e1.inforigin=self.origin;
                e1.oldorigin=self.origin;
                setorigin(e1,self.origin);
        }
        if(self.team==TEAM_COLOR2 + 1){
                bprint("BLUE has chosen their spot!\n");
                team2_flag_picked=1;
                e1 = find(world,classname,"item_flag_team2");
                e1.inforigin=self.origin;
                e1.oldorigin=self.origin;
                setorigin(e1,self.origin);
        }
        setmodel(nailent,"progs/grenade.mdl");
        setsize(nailent, '0 0 0', '0 0 0');
        nailent.mdl = nailent.model;
        self.flag_picked_time=0;
/*
        nailent.movetype=MOVETYPE_FLY;
        nailent.solid = SOLID_BBOX;
        nailent.touch = NailForFlagTouch;
        nailent.team=self.team;

        makevectors(self.v_angle);
        nailent.velocity = dir * 1000;
        nailent.classname = "Nail Class";
        setorigin(nailent, self.origin + v_forward*8 + '0 0 16');
*/
};

