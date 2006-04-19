/*======================================================
	ACTIONS.QC			TeamFortress v2.5	

	(c) TeamFortress Software Pty Ltd 	13/5/97
========================================================
Non Class-Specific Impulse Commands
=======================================================*/
// Prototypes
void() TeamFortress_Discard;
void() TeamFortress_SaveMe;
void() TeamFortress_ID;
void() TeamFortress_ReloadCurrentWeapon;

//=========================================================================
// Discard Command. Drops all ammo useless to the player's class.
void() TeamFortress_Discard =
{ 
	// Create a backpack
	newmis = spawn();
	
	// Fill it with ammo based upon the player's class
	if (self.playerclass == #PC_SCOUT)
	{
		// Doesn't need rockets
		newmis.ammo_rockets = self.ammo_rockets;
	}
	else if (self.playerclass == #PC_SNIPER)
	{
		// Doesn't need rockets or cells
		newmis.ammo_rockets = self.ammo_rockets;
		newmis.ammo_cells = self.ammo_cells;
	}
	else if (self.playerclass == #PC_SOLDIER)
	{
		// Doesn't need cells or nails
		newmis.ammo_cells = self.ammo_cells;
		newmis.ammo_nails = self.ammo_nails;
	}
	else if (self.playerclass == #PC_DEMOMAN)
	{
		// Doesn't need cells or nails
		newmis.ammo_cells = self.ammo_cells;
		newmis.ammo_nails = self.ammo_nails;
	}
	else if (self.playerclass == #PC_MEDIC)
	{
		// Doesn't need rockets or cells
		newmis.ammo_rockets = self.ammo_rockets;
		newmis.ammo_cells = self.ammo_cells;
	}
	else if (self.playerclass == #PC_HVYWEAP)
	{
		// Doesn't need rockets or nails
		newmis.ammo_rockets = self.ammo_rockets;
		newmis.ammo_nails = self.ammo_nails;
	}
	else if (self.playerclass == #PC_PYRO)
	{
		// Doesn't need nails
		newmis.ammo_nails = self.ammo_nails;
	}
	else if (self.playerclass == #PC_SPY)
	{
		// Doesn't need rockets
		newmis.ammo_rockets = self.ammo_rockets;
	}
	else if (self.playerclass == #PC_ENGINEER)
	{
		// Doesn't need rockets 
		newmis.ammo_rockets = self.ammo_rockets;
	}

	// If there's nothing in the backpack, remove it and return
	if (!(newmis.ammo_shells + newmis.ammo_nails + newmis.ammo_rockets + newmis.ammo_cells))
	{
		dremove(newmis);
		return;
	}

	// Remove the ammo from the player
	if (newmis.ammo_shells)
		self.ammo_shells = 0;
	if (newmis.ammo_nails)
		self.ammo_nails = 0;
	if (newmis.ammo_rockets)
		self.ammo_rockets = 0;
	if (newmis.ammo_cells)
		self.ammo_cells = 0;
	W_SetCurrentAmmo();

	sound(self, #CHAN_ITEM, "weapons/lock4.wav", 1, #ATTN_NORM);

	// The backpack is treated as an ammobox, so people can't crash svrs
	// by making too many of them.
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

	// Throw the backpack
	newmis.enemy = self;
	newmis.health = time;
	newmis.weapon = 0;
	newmis.movetype = #MOVETYPE_TOSS;
	newmis.solid = #SOLID_TRIGGER;
	newmis.classname = "ammobox";
	newmis.team_no = self.team_no;
	makevectors (self.v_angle);
	if (self.v_angle_x)
	{
		newmis.velocity = v_forward*400 + v_up * 200;
	}
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
	setmodel (newmis, "progs/backpack.mdl");
};

//=========================================================================
// Shows any medics/engineers on your team that you need help.
// Spy's see all requests.
void() TeamFortress_SaveMe =
{
	local entity te, tl;

	if (self.last_saveme_sound < time)
	{
		if (random() < 0.8)
			sound(self, #CHAN_WEAPON, "speech/saveme1.wav", 1, #ATTN_NORM);	// MEDIC!
		else
			sound(self, #CHAN_WEAPON, "speech/saveme2.wav", 1, #ATTN_NORM);	// Excuse me...
		self.last_saveme_sound = time + 4;
	}

	te = find(world, classname, "player");
	while (te)
	{
		if (self == te || te.playerclass == #PC_MEDIC || te.playerclass == #PC_ENGINEER || te.playerclass == #PC_SPY)
		{
			if ((te.team_no == self.team_no && self.team_no != 0) || (te.playerclass == #PC_SPY))
			{
				// If the other teammate is visible, show them I need help
				if (visible(te))
				{
					msg_entity = te;
					tl = spawn();
					tl.origin = self.origin;
					tl.origin_z = tl.origin_z + 32;
					WriteByte (#MSG_ONE, #SVC_TEMPENTITY);
					WriteByte (#MSG_ONE, #TE_LIGHTNING3);
					WriteEntity (#MSG_ONE, tl);
					WriteCoord (#MSG_ONE, tl.origin_x);
					WriteCoord (#MSG_ONE, tl.origin_y);
					WriteCoord (#MSG_ONE, tl.origin_z + 24);
					WriteCoord (#MSG_ONE, self.origin_x);
					WriteCoord (#MSG_ONE, self.origin_y);
					WriteCoord (#MSG_ONE, self.origin_z);
					dremove(tl);
				}
			}
		}

		te = find(te, classname, "player");
	}
};

//=========================================================================
// ID's the player in your sights, and if you're a medic or engineer,
// reports their health and armor.
void() TeamFortress_ID =
{
	local vector src;
	local string st, cls;

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;
	traceline (src, src + v_forward*2048, #FALSE, self);

	if (trace_ent != world && trace_ent.origin != world.origin )
	{
		if (trace_ent.classname == "player" && trace_ent.health > 0)
		{
			self.StatusRefreshTime = time + 1.5;

			if (self.team_no != 0 && (self.team_no == trace_ent.team_no))
			{
				cls = TeamFortress_GetClassName(trace_ent.playerclass);
				if (self.playerclass == #PC_MEDIC)
				{
					st = NumberToString1000(trace_ent.health);
					centerprint(self, "\n\n\n\n", trace_ent.netname, "\nFriendly ", cls, "\n", st, " health\n");
					return;
				}
				else if (self.playerclass == #PC_ENGINEER)
				{
					st = NumberToString1000(trace_ent.armorvalue);
					centerprint(self, "\n\n\n\n", trace_ent.netname, "\nFriendly ", cls, "\n", st, " armor\n");
					return;
				}

				centerprint(self, "\n\n\n\n", trace_ent.netname, "\nFriendly ", cls);
				return;
			}

			if (trace_ent.playerclass == #PC_SPY)
			{
				cls = TeamFortress_GetClassName(trace_ent.undercover_skin);
				// Report a false name
				if (self.team_no != 0 && (self.team_no == trace_ent.undercover_team))
				{
					if (self.playerclass == #PC_MEDIC)
					{
						st = NumberToString1000(trace_ent.health);
						if (trace_ent.undercover_skin != 0)
							centerprint(self, "\n\n\n\n", trace_ent.undercover_name, "\nFriendly ", cls, "\n", st, " health\n");
						else
							centerprint(self, "\n\n\n\n", trace_ent.undercover_name, "\nFriendly Spy\n", st, " health\n");
						return;
					}
					else if (self.playerclass == #PC_ENGINEER)
					{
						st = NumberToString1000(trace_ent.armorvalue);
						if (trace_ent.undercover_skin != 0)
							centerprint(self, "\n\n\n\n", trace_ent.undercover_name, "\nFriendly ", cls, "\n", st, " armor\n");
						else
							centerprint(self, "\n\n\n\n", trace_ent.undercover_name, "\nFriendly Spy\n", st, " armor\n");
						return;
					}
					else
					{
						st = NumberToString1000(trace_ent.armorvalue);
						if (trace_ent.undercover_skin != 0)
							centerprint(self, "\n\n\n\n", trace_ent.undercover_name, "\nFriendly ", cls);
						else
							centerprint(self, "\n\n\n\n", trace_ent.undercover_name, "\nFriendly Spy\n");
						return;
					}
				}

				if (trace_ent.undercover_name != string_null)
				{
					if (trace_ent.undercover_skin != 0)
						centerprint(self, "\n\n\n\n", trace_ent.undercover_name, "\nEnemy ", cls);
					else
						centerprint(self, "\n\n\n\n", trace_ent.undercover_name, "\nEnemy Spy");
				}
				else
				{
					if (trace_ent.undercover_skin != 0)
						centerprint(self, "\n\n\n\n", trace_ent.netname, "\nEnemy ", cls);
					else
						centerprint(self, "\n\n\n\n", trace_ent.netname, "\nEnemy Spy");
				}
			}
			else 
			{
				cls = TeamFortress_GetClassName(trace_ent.playerclass);
				centerprint(self, "\n\n\n\n", trace_ent.netname, "\nEnemy ", cls);
			}
		}
		else if (trace_ent.classname == "building_dispenser")
		{
			self.StatusRefreshTime = time + 1.5;
			
			if (self == trace_ent.real_owner)
				centerprint(self, "\n\n\n\nYour Dispenser");
			else
				centerprint(self, "\n\n\n\nDispenser made by ", trace_ent.real_owner.netname);
		}
		else if (trace_ent.classname == "building_sentrygun" || trace_ent.classname == "building_sentrygun_base")
		{
			self.StatusRefreshTime = time + 1.5;
			if (self == trace_ent.real_owner)
				centerprint(self, "\n\n\n\nYour SentryGun");
			else if (!teamplay)
				centerprint(self, "\n\n\n\nSentrygun made by\n", trace_ent.real_owner.netname);
			else if (self.team_no != 0 && (self.team_no == trace_ent.team_no))
				centerprint(self, "\n\n\n\nFriendly Sentrygun made by\n", trace_ent.real_owner.netname);
			else 
				centerprint(self, "\n\n\n\nEnemy Sentrygun made by\n", trace_ent.real_owner.netname);
		}
	}
};

//=========================================================================
// Reloads the current weapon
void() TeamFortress_ReloadCurrentWeapon =
{
	local float rt;
	local entity tWeapon;

	if (self.current_weapon == #WEAP_SHOTGUN)
	{
		if (self.reload_shotgun == 0)
		{
			sprint(self, #PRINT_HIGH, "clip full.\n");
			return;
		}

        if ( self.reload_shotgun < self.ammo_shells)
        {
			Attack_Finished(0.4);

			// Calculate the reload time needed
			rt = (#RE_SHOTGUN - self.reload_shotgun) / #RE_SHOTGUN;
			rt = #RE_SHOTGUN_TIME - (#RE_SHOTGUN_TIME * rt);

			self.reload_shotgun = 0;
			if (self.ammo_shells < #RE_SHOTGUN)
				self.reload_shotgun = #RE_SHOTGUN - self.ammo_shells;
		   
			sprint(self, #PRINT_HIGH, "reloading...\n");
			self.tfstate = (self.tfstate | #TFSTATE_RELOADING);
			tWeapon = spawn();
			tWeapon.owner = self;
			tWeapon.classname = "timer";
			tWeapon.nextthink = time + rt;
			tWeapon.think = W_Reload_shotgun;

			self.weaponmodel = "";
			self.weaponframe = 0;
        }
		else
		{
			sprint(self, #PRINT_HIGH, "not enough ammo to reload\n");
		}
	}
	else if (self.current_weapon == #WEAP_SUPER_SHOTGUN)
	{
		if (self.reload_super_shotgun == 0)
		{
			sprint (self, #PRINT_HIGH, "clip full.\n");
			return;
		}

        if ( self.reload_super_shotgun < self.ammo_shells)
        {
        	Attack_Finished(0.7);

			// Calculate the reload time needed
			rt = (#RE_SUPER_SHOTGUN - self.reload_super_shotgun) / #RE_SUPER_SHOTGUN;
			rt = #RE_SUPER_SHOTGUN_TIME - (#RE_SUPER_SHOTGUN_TIME * rt);

            self.reload_super_shotgun = 0;
			if (self.ammo_shells < #RE_SUPER_SHOTGUN)
				self.reload_super_shotgun = #RE_SUPER_SHOTGUN - self.ammo_shells;

	      	sprint (self, #PRINT_HIGH, "reloading...\n");
            self.tfstate = (self.tfstate | #TFSTATE_RELOADING);
	        tWeapon = spawn();
    	    tWeapon.owner = self;
 		    tWeapon.classname = "timer";
        	tWeapon.nextthink = time + rt;
         	tWeapon.think = W_Reload_super_shotgun;

         	self.weaponmodel = "";
         	self.weaponframe = 0;
	  	}
		else
		{
			sprint (self, #PRINT_HIGH, "not enough ammo to reload\n");
		}
	}
	else if (self.current_weapon == #WEAP_GRENADE_LAUNCHER)
	{
		if (self.reload_grenade_launcher == 0)
		{
			sprint (self, #PRINT_HIGH, "clip full.\n");
			return;
		}
		
        if (self.reload_grenade_launcher < self.ammo_rockets)
        {
			Attack_Finished(0.6);

			// Calculate the reload time needed
			rt = (#RE_GRENADE_LAUNCHER - self.reload_grenade_launcher) / #RE_GRENADE_LAUNCHER;
			rt = #RE_GRENADE_LAUNCHER_TIME - (#RE_GRENADE_LAUNCHER_TIME * rt);

    	  	self.reload_grenade_launcher = 0;
			if (self.ammo_rockets < #RE_GRENADE_LAUNCHER)
				self.reload_grenade_launcher = #RE_GRENADE_LAUNCHER - self.ammo_rockets;

      	  	sprint (self, #PRINT_HIGH, "reloading...\n");
			self.tfstate = (self.tfstate | #TFSTATE_RELOADING);
          	tWeapon = spawn();
          	tWeapon.owner = self;
 		    tWeapon.classname = "timer";
          	tWeapon.nextthink = time + rt;
         	tWeapon.think = W_Reload_grenade_launcher;

         	self.weaponmodel = "";
         	self.weaponframe = 0;
      	}
		else
		{
			sprint (self, #PRINT_HIGH, "not enough ammo to reload\n");
		}
	}
	else if (self.current_weapon == #WEAP_ROCKET_LAUNCHER)
	{
		if (self.reload_rocket_launcher == 0)
		{
			sprint (self, #PRINT_HIGH, "clip full.\n");
			return;
		}

	    if (self.reload_rocket_launcher < self.ammo_rockets)
      	{
        	Attack_Finished(0.8);

			// Calculate the reload time needed
			rt = (#RE_ROCKET_LAUNCHER - self.reload_rocket_launcher) / #RE_ROCKET_LAUNCHER;
			rt = #RE_ROCKET_LAUNCHER_TIME - (#RE_ROCKET_LAUNCHER_TIME * rt);

        	self.reload_rocket_launcher = 0;
			if (self.ammo_rockets < #RE_ROCKET_LAUNCHER)
				self.reload_rocket_launcher = #RE_ROCKET_LAUNCHER - self.ammo_rockets;

      		sprint (self, #PRINT_HIGH, "reloading...\n");
			self.tfstate = (self.tfstate | #TFSTATE_RELOADING);
         	tWeapon = spawn();
         	tWeapon.owner = self;
 		    tWeapon.classname = "timer";
         	tWeapon.nextthink = time + rt;
         	tWeapon.think = W_Reload_rocket_launcher;

         	self.weaponmodel = "";
         	self.weaponframe = 0;
      	}
	}
};
