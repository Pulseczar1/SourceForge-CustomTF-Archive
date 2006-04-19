/*======================================================
	ENGINEER.QC			TeamFortress v2.5	

	(c) TeamFortress Software Pty Ltd 	2/3/97
========================================================
Weapons and functions for the ENGINEER class and associated weaponry                          
=======================================================*/
// Weapon Functions
void() LaserBolt_Touch;
void() LaserBolt_Think;
void() W_FireLaser;

// EMP Grenade Functions
void() EMPExplode;
void() EMPGrenadeTouch;
void() EMPGrenadeExplode;

// Building Functions
void() TeamFortress_EngineerBuild;
void(float objtobuild) TeamFortress_Build;
void() TeamFortress_FinishedBuilding;
void() T_Mortar;
void() T_Dispenser;
void() Dispenser_Die;
void(entity disp) Engineer_UseDispenser;
void(entity gun) Engineer_UseSentryGun;
void(entity mortar) Engineer_UseMortar;
void() CheckDistance;
float(entity obj, entity builder) CheckArea;

//=========================================================================
// Laserbolt think function
void() LaserBolt_Think =
{
	self.solid = #SOLID_TRIGGER;
	self.movetype = #MOVETYPE_FLYMISSILE;
	self.velocity = self.oldorigin;
	self.touch = LaserBolt_Touch;
	setmodel(self, "progs/e_spike2.mdl");

	self.nextthink = time + 1.0;
	self.think = SUB_Remove;
};

//=========================================================================
// Laserbolt touch function. Just moves through the player and comes out
// the other side.
void() LaserBolt_Touch =
{
	local vector org;
	
	if (other == self.owner)
		return;		

	if (other == self.enemy && self.enemy != world)
		return;		// don't explode on same person twice

	if (pointcontents(self.origin) == #CONTENT_SKY)
	{
		dremove(self);
		return;
	}

	org = self.origin - 8*normalize(self.velocity);

	if (other.health)
	{
		SpawnBlood (org, 15);
		deathmsg = #DMSG_LASERBOLT;
		TF_T_Damage (other, self, self.enemy, 25, 0, #TF_TD_ELECTRICITY);
		self.velocity = self.oldorigin;
		self.owner = other;

		setmodel (self, string_null);
		self.touch = SUB_Null;
//		self.solid = #SOLID_NOT;
//		self.movetype = #MOVETYPE_NOCLIP;

		self.nextthink = time + 0.1;
		self.think = LaserBolt_Think;
		return;
	}
	else
	{
		WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
		WriteByte (#MSG_BROADCAST, #TE_SPIKE);
		WriteCoord (#MSG_BROADCAST, self.origin_x);
		WriteCoord (#MSG_BROADCAST, self.origin_y);
		WriteCoord (#MSG_BROADCAST, self.origin_z);
	#ifdef QUAKE_WORLD
		multicast (self.origin, #MULTICAST_PHS);
	#endif
	}
	
	dremove(self);	
};

//=========================================================================
// Fire a laserbolt
void() W_FireLaser =
{
	local	vector	vec, org;

	self.currentammo = self.ammo_nails = self.ammo_nails - 1;

	makevectors(self.v_angle);
	org = self.origin + (v_forward * 8);
	vec = aim(self, 10000);
	vec = normalize(vec);
		
	newmis = spawn();
	newmis.owner = self;
	newmis.enemy = self;	// The real owner
	newmis.movetype = #MOVETYPE_FLYMISSILE;
	newmis.solid = #SOLID_TRIGGER;

	setmodel (newmis, "progs/e_spike1.mdl");
	setsize (newmis, '0 0 0', '0 0 0');		

	setorigin (newmis, org + '0 0 16');

	newmis.velocity = vec * 1500;
	newmis.angles = vectoangles(newmis.velocity);
	newmis.oldorigin = newmis.velocity;

	newmis.nextthink = time + 5;

	newmis.think = SUB_Remove;
	newmis.touch = LaserBolt_Touch;
};

//=========================================================================
// Ammo/Weapon exploded by the EMP grenade
void() EMPExplode =
{
	local float expsize;

	expsize = 10;
	// Weapon?
	if (self.touch == weapon_touch)
		expsize = 60;
	else if (self.classname == "item_shells")
		expsize = 50 + self.aflag;
	else if (self.classname == "item_spikes")
		expsize = 40;
	else if (self.classname == "item_rockets")
		expsize = 100 + (self.aflag * 4);
	else if (self.classname == "item_cells")
		expsize = 100 + (self.aflag * 3);
	else if (self.classname == "item_weapon")
		expsize = 60;
	else
	{
		dprint("EMPExplode: Attempting to explode a ");
		dprint(self.classname);
		dprint("\n");
		return;
	}

	deathmsg = #DMSG_GREN_EMP_AMMO;
	T_RadiusDamage (self, self.enemy, expsize, world);

	WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
	WriteByte (#MSG_BROADCAST, #TE_EXPLOSION);
	WriteCoord (#MSG_BROADCAST, self.origin_x);
	WriteCoord (#MSG_BROADCAST, self.origin_y);
	WriteCoord (#MSG_BROADCAST, self.origin_z);
#ifdef QUAKE_WORLD
	multicast (self.origin, #MULTICAST_PHS);
#endif

	// Respawn
	Respawn_Item(self, self.enemy);
};

//=========================================================================
// Touch Function for EMP Grenade
void() EMPGrenadeTouch =
{
	// If the EMP Grenade hits a player, it just bounces off
	sound (self, #CHAN_WEAPON, "weapons/bounce.wav", 1, #ATTN_NORM);
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
};

//=========================================================================
// EMP Grenade explode function, for when the PRIMETIME runs out
void() EMPGrenadeExplode =
{
	local float expsize;
	local entity te, oldself;

	WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
	WriteByte (#MSG_BROADCAST, #TE_TAREXPLOSION);
	WriteCoord (#MSG_BROADCAST, self.origin_x);
	WriteCoord (#MSG_BROADCAST, self.origin_y);
	WriteCoord (#MSG_BROADCAST, self.origin_z);
#ifdef QUAKE_WORLD
	multicast (self.origin, #MULTICAST_PHS);
#endif

	// Find all ammo in the area
	te = findradius(self.origin, 240);
	while (te)
	{	
		// Ammo/Weapon?
		if (te.touch == ammo_touch || te.touch == weapon_touch)
		{
			// Make sure it isn't picked up in the next second
			te.solid = #SOLID_NOT;
			te.enemy = self.owner;
			te.nextthink = time + 1 + (random() * 2);
			te.think = EMPExplode;
		}
		// Detpack?
		else if (te.think == TeamFortress_DetpackExplode)
		{
			te.solid = #SOLID_NOT;
			te.nextthink = time + 1 + (random() * 2);
			dremove(te.oldenemy); // Countdown ent
		}
		// Pipebomb?
		else if (te.classname == "pipebomb")
		{
			te.nextthink = time + 0.1 + (random() * 2);
		}
		// Building?
		else if (te.classname == "building_dispenser")
		{
			TF_T_Damage (te, self, self.owner, 200, 0, #TF_TD_EXPLOSION);
		}
		// Ammobox?
		else if (te.classname == "ammobox")
		{
			expsize = 0;
			expsize = expsize + (te.ammo_shells * 0.75);
			expsize = expsize + ((te.ammo_rockets * 0.75) * 2);
			expsize = expsize + ((te.ammo_cells * 0.75) * 2);

			if (expsize > 0)
			{
				te.solid = #SOLID_NOT;
				
				// Damage player and explode
				deathmsg = #DMSG_GREN_EMP;
				T_RadiusDamage (te, self.owner, expsize, te);

				te.think = SUB_Remove;
				te.nextthink = time + 0.1;

				WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
				WriteByte (#MSG_BROADCAST, #TE_EXPLOSION);
				WriteCoord (#MSG_BROADCAST, te.origin_x);
				WriteCoord (#MSG_BROADCAST, te.origin_y);
				WriteCoord (#MSG_BROADCAST, te.origin_z);
			#ifdef QUAKE_WORLD
				multicast (te.origin, #MULTICAST_PHS);
			#endif
			}
		}
		// Backpack/Player?
		else if ((te.classname == "player") || (te.touch == BackpackTouch))
		{
			expsize = 0;
			// calculate explosion size
			expsize = expsize + (te.ammo_shells * 0.75);
			expsize = expsize + ((te.ammo_rockets * 0.75) * 2);
			if (te.playerclass != #PC_ENGINEER)
				expsize = expsize + (te.ammo_cells * 0.75);

			if (expsize > 0)
			{
				// Damage player and explode
				deathmsg = #DMSG_GREN_EMP;
				T_RadiusDamage (te, self.owner, expsize, te);
				if (te.touch != BackpackTouch)
				{
					TF_T_Damage (te, self, self.owner, expsize, 0, #TF_TD_EXPLOSION);

					// Remove ammo
					te.ammo_shells = ceil(te.ammo_shells * 0.25);
					te.ammo_rockets = ceil(te.ammo_rockets * 0.25);
					if (te.playerclass != #PC_ENGINEER)
						te.ammo_cells = ceil(te.ammo_cells * 0.25);

					// Update console
					oldself = self;
					self = te;
					W_SetCurrentAmmo();
					self = oldself;
				}
				else
				{
					te.think = SUB_Remove;
					te.nextthink = time + 0.1;
				}

				WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
				WriteByte (#MSG_BROADCAST, #TE_EXPLOSION);
				WriteCoord (#MSG_BROADCAST, te.origin_x);
				WriteCoord (#MSG_BROADCAST, te.origin_y);
				WriteCoord (#MSG_BROADCAST, te.origin_z);
			#ifdef QUAKE_WORLD
				multicast (te.origin, #MULTICAST_PHS);
			#endif
			}
		}

		te = te.chain;
	}

#ifdef DEMO_STUFF
	// Remove any camera's locks on this missile
	if (self.enemy)
		CamProjectileLockOff();
#endif

#ifdef QUAKE_WORLD
	dremove(self);
#else
	BecomeExplosion();
#endif
};

//=========================================================================
// Function handling the Engineer's build impulse
void() TeamFortress_EngineerBuild =
{
	local entity te;

	// Can't build in the air
	if (!(self.flags & #FL_ONGROUND))
	{
		CenterPrint(self, "You can't build in the air!\n\n");
		return;
	}

	// Pop up the menu
	if (self.is_building == 0)
	{
		// Check to see if they've got enuf metal to build anything
		if (self.ammo_cells < #BUILD_COST_DISPENSER && self.has_dispenser == #FALSE && self.has_sentry == #FALSE)
		{
			CenterPrint(self, "You don't have enough metal to \nbuild anything.\n\n");
			return;
		}

		self.current_menu = #MENU_ENGINEER;
		self.menu_count = #MENU_REFRESH_RATE;
	}
	else if (self.is_building == 1)	
	{
		sprint(self, #PRINT_HIGH, "You stop building.\n");

		self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_CANT_MOVE);

#ifdef QUAKE_WORLD
		TeamFortress_SetSpeed(self);
#else
		self.pausetime = time;
#endif

		// Remove the timer
		te = find(world, netname, "build_timer");
		while (te)
		{
			if (te.owner == self)
			{
				dremove(te);
				te = world;
			}
			else
			{
				te = find(te, netname, "build_timer");
			}
		}

		self.is_building = 0;
		self.current_weapon = self.weapon;
		W_SetCurrentAmmo();
	}
};


float(entity obj, entity builder) CheckArea =
{
	local vector src, end;
	local float pos;

	// Check the origin
	pos = pointcontents(obj.origin); 
	if (pos == #CONTENT_SOLID || pos == #CONTENT_SKY) 
		return #FALSE;

	// Check the surrounding area
	src_x = obj.origin_x + obj.maxs_x + 16;
	src_y = obj.origin_y + obj.maxs_y + 16;
	src_z = obj.origin_z + obj.maxs_z + 16;  // check upwards more

	pos = pointcontents(src); 
	if (pos == #CONTENT_SOLID || pos == #CONTENT_SKY) 
		return #FALSE;

	end_x = obj.origin_x + obj.mins_x - 16;
	end_y = obj.origin_y + obj.mins_y - 16;
	end_z = obj.origin_z + obj.mins_z - 16;
	traceline (src, end, #TRUE, obj);
	if (trace_fraction != 1)
		return #FALSE;

	pos = pointcontents(end); 
	if (pos == #CONTENT_SOLID || pos == #CONTENT_SKY) 
		return #FALSE;

	// extend the size a little
	src_x = obj.origin_x + obj.mins_x - 16;
	src_y = obj.origin_y + obj.maxs_y + 16;
	src_z = obj.origin_z + obj.maxs_z + 16;

	pos = pointcontents(src); 
	if (pos == #CONTENT_SOLID || pos == #CONTENT_SKY) 
		return #FALSE;

	end_x = obj.origin_x + obj.maxs_x + 16;
	end_y = obj.origin_y + obj.mins_y - 16;
	end_z = obj.origin_z + obj.mins_z - 16;		// check downwards less

	traceline (src, end, #TRUE, obj);

	if (trace_fraction != 1)
		return #FALSE;

	pos = pointcontents(end); 
	if (pos == #CONTENT_SOLID || pos == #CONTENT_SKY) 
		return #FALSE;

	// Trace a line from the player to the object too
	traceline(builder.origin, obj.origin, #TRUE, builder);

	if (trace_fraction != 1)
		return #FALSE;

	// may add in more checks later

	return #TRUE;
};

//////////////////////////////////////////////////////////////////////////
// rehashed version of TF_Build 
void(float objtobuild) TeamFortress_Build =
{
	local float btime;
	local entity te;
	local vector tmp1, tmp2;

	newmis = spawn();

	// get an origin
	makevectors(self.v_angle);
	v_forward_z = 0;
	v_forward = normalize(v_forward) * 64;
	newmis.origin = self.origin + v_forward; // '0 0 0'

	if (objtobuild == #BUILD_DISPENSER)
	{
		if (self.has_dispenser)
		{
			sprint(self, #PRINT_HIGH, "You can only have one dispenser.\nTry dismantling your old one.\n");
			return;
		}

		tmp1 = '-16 -16 0';
		tmp2 = '16 16 48';
		newmis.mdl = "progs/disp.mdl";
		newmis.netname = "dispenser";

		btime = time + #BUILD_TIME_DISPENSER;
	}
	else if (objtobuild == #BUILD_SENTRYGUN)
	{
		if (self.has_sentry)
		{
			sprint(self, #PRINT_HIGH, "You can only have one sentry gun.\nTry dismantling your old one.\n");
			return;
		}

		tmp1 = '-16 -16 0';
		tmp2 = '16 16 48';
   		newmis.mdl = "progs/turrbase.mdl";  
		newmis.netname = "sentrygun";
	
		btime = time + #BUILD_TIME_SENTRYGUN;
	}

	// before we start building it, check it out
	// check for validity of point
	if (CheckArea(newmis, self) == #FALSE)
	{
		sprint(self, #PRINT_HIGH, "Not enough room to build here\n");
		dremove(newmis);
		return;
	}

	self.is_building = 1;
	self.immune_to_check = time + 2;
	self.tfstate = self.tfstate | #TFSTATE_CANT_MOVE;

	// Save the current weapon and remove it
	self.weapon = self.current_weapon;
	self.current_weapon = 0;
    self.weaponmodel = "";
    self.weaponframe = 0;

#ifdef QUAKE_WORLD
	TeamFortress_SetSpeed(self);
#else
	self.pausetime = btime;
#endif

	newmis.owner = self;
	newmis.classname = "timer";
	newmis.netname = "build_timer";
	newmis.nextthink = btime;
	newmis.think = TeamFortress_FinishedBuilding;
	newmis.colormap = self.colormap;
	newmis.weapon = objtobuild;
	newmis.angles_y = anglemod(self.angles_y + 180);

	newmis.velocity = '0 0 8';
	newmis.movetype = #MOVETYPE_TOSS;

	newmis.solid = #SOLID_BBOX;
	setmodel (newmis, newmis.mdl);
	setsize (newmis, tmp1, tmp2);
	setorigin (newmis, newmis.origin);

	newmis.flags = newmis.flags - (newmis.flags & #FL_ONGROUND);
};

void() DispenserThink =
{
	// dispenser refilling itself 5%
	self.ammo_shells = self.ammo_shells + rint(#BUILD_DISPENSER_MAX_SHELLS / 20);
	self.ammo_cells = self.ammo_cells + rint(#BUILD_DISPENSER_MAX_CELLS / 20);
	self.ammo_nails = self.ammo_nails + rint(#BUILD_DISPENSER_MAX_NAILS / 20);
	self.ammo_rockets = self.ammo_rockets + rint(#BUILD_DISPENSER_MAX_ROCKETS / 20);
	self.armorvalue = self.armorvalue + rint(#BUILD_DISPENSER_MAX_ARMOR / 20);

	if (self.ammo_shells > #BUILD_DISPENSER_MAX_SHELLS)
		self.ammo_shells = #BUILD_DISPENSER_MAX_SHELLS;	
	if (self.ammo_nails > #BUILD_DISPENSER_MAX_NAILS)
		self.ammo_nails = #BUILD_DISPENSER_MAX_NAILS;	
	if (self.ammo_rockets > #BUILD_DISPENSER_MAX_ROCKETS)
		self.ammo_rockets = #BUILD_DISPENSER_MAX_ROCKETS;	
	if (self.ammo_cells > #BUILD_DISPENSER_MAX_CELLS)
		self.ammo_cells = #BUILD_DISPENSER_MAX_CELLS;	
	if (self.armorvalue > #BUILD_DISPENSER_MAX_ARMOR)
		self.armorvalue = #BUILD_DISPENSER_MAX_ARMOR;	
	
	self.nextthink = time + 10;
};

void() TeamFortress_FinishedBuilding =
{
	local entity oldself;
	local float current_yaw;
	local vector source;

	if (self.owner.is_building != 1)
		return;

	oldself = self;
	self = self.owner;
	oldself.owner = world;
	oldself.real_owner = self;

	self.is_building = 0;
	self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_CANT_MOVE);
	self.current_weapon = self.weapon;
	self.StatusRefreshTime = time + 0.1;

	TeamFortress_SetSpeed(self);

	if (oldself.weapon == #BUILD_DISPENSER)
	{
		self.has_dispenser = #TRUE;
		sprint (self, #PRINT_HIGH, "You finish building the dispenser.\n");
		teamsprint(self.team_no, self, self.netname);
		teamsprint(self.team_no, self, " has built a Dispenser.\n");

		self.ammo_cells = self.ammo_cells - #BUILD_COST_DISPENSER;
		
		// Create the dispenser
		oldself.classname = "building_dispenser";
		oldself.netname = "dispenser";
		oldself.blocked = T_Dispenser;		// Actual touch function
		oldself.touch = T_Dispenser;
		oldself.max_health = #BUILD_HEALTH_DISPENSER;
		oldself.health = #BUILD_HEALTH_DISPENSER;
		oldself.think = DispenserThink;
		oldself.nextthink = time + 5;
		oldself.th_die = Dispenser_Die;		// Death function
		oldself.mdl = "progs/disp.mdl";		// Actual mdl
		oldself.team_no = self.team_no;

		oldself.real_owner = self;			// The Engineer owns this item
		oldself.colormap = self.colormap;	// Set the Color
		oldself.takedamage = #DAMAGE_AIM;
		oldself.owner = world;
		oldself.movetype = #MOVETYPE_TOSS;
		oldself.velocity = '0 0 8';
		oldself.flags = oldself.flags - (oldself.flags & #FL_ONGROUND);

		// Put some ammo in the Dispenser
		oldself.ammo_shells = ceil(self.ammo_shells * 0.25);
		oldself.ammo_nails = ceil(self.ammo_nails * 0.25);
		oldself.ammo_rockets = ceil(self.ammo_rockets * 0.25);
		oldself.ammo_cells = ceil(self.ammo_cells * 0.25);
		oldself.armorvalue = ceil(self.armorvalue * 0.25);

		// Remove ours
		self.ammo_shells = ceil(self.ammo_shells * 0.75);
		self.ammo_nails = ceil(self.ammo_nails * 0.75);
		self.ammo_rockets = ceil(self.ammo_rockets * 0.75);
		self.ammo_cells = ceil(self.ammo_cells * 0.75);
		self.armorvalue = ceil(self.armorvalue * 0.75);

		oldself.solid = #SOLID_BBOX;
		setmodel(oldself, oldself.mdl);
		setsize (oldself, '-8 -8 0', '8 8 24');
		setorigin(oldself, oldself.origin);
	}
	else if (oldself.weapon == #BUILD_SENTRYGUN)
	{
		self.has_sentry = #TRUE;
		sprint (self, #PRINT_HIGH, "You finish building the sentry gun.\n");
		teamsprint(self.team_no, self, self.netname);
		teamsprint(self.team_no, self, " has built a Sentry Gun.\n");
			
		oldself.classname = "building_sentrygun_base";
		oldself.netname = "sentry gun";
		oldself.takedamage = 0;
		oldself.th_die = Sentry_Die; 		// Death function
		self.ammo_cells = self.ammo_cells - #BUILD_COST_SENTRYGUN;

		setsize (oldself, '-16 -16 0', '16 16 4'); // '-16 -16 0' '16 16 4'
		newmis = spawn();
		newmis.classname = "building_sentrygun";
		newmis.health = #BUILD_HEALTH_SENTRYGUN;
		newmis.max_health = newmis.health;
		newmis.weapon = 1;					// Level 1 Turret
		newmis.th_die = Sentry_Die;			// Death function
		newmis.th_pain = Sentry_Pain;
		newmis.mdl = "progs/turrgun.mdl";  
		sound (oldself, #CHAN_ITEM, "weapons/turrset.wav", 1, #ATTN_NORM);
		newmis.solid = #SOLID_BBOX;
		setmodel(newmis, newmis.mdl);
		setsize (newmis, '-16 -16 0', '16 16 48'); 
		setorigin(newmis, oldself.origin + '0 0 8'); 
		newmis.real_owner = oldself.real_owner;	// The Engineer owns this item
		newmis.trigger_field = oldself;
		oldself.oldenemy = newmis;
		newmis.movetype = #MOVETYPE_STEP;
		oldself.colormap = self.colormap;	// Set the Base Color
		newmis.colormap = self.colormap;	// Set the Color
		newmis.takedamage = #DAMAGE_AIM;
		newmis.velocity = '0 0 -8';
		newmis.flags = newmis.flags - (newmis.flags & #FL_ONGROUND);
		oldself.flags = oldself.flags - (oldself.flags & #FL_ONGROUND);

		newmis.team_no = self.team_no;
		newmis.think = lvl1_sentry_stand;
		newmis.nextthink = time + 0.5;
		// Rotate Details
		newmis.yaw_speed = 10;
		newmis.heat = 0;	// Turn Right
		newmis.angles_x = 0;
		newmis.angles_y = oldself.angles_y;
		newmis.angles_z = 0;
		newmis.waitmin = anglemod(newmis.angles_y - 50);
		newmis.waitmax = anglemod(newmis.angles_y + 50);

		if (newmis.waitmin > newmis.waitmax)
		{
			newmis.waitmin = newmis.waitmax;
			newmis.waitmax = anglemod(newmis.angles_y - 50);
		}

		// Give the Gun some ammo
		newmis.ammo_shells = 25;
		newmis.maxammo_shells = 100;
		newmis.maxammo_rockets = 20;
	}

	W_SetCurrentAmmo();
};

//=========================================================================
// Mortar Touch function. Allows Players to operate the mortar.
void() T_Mortar =
{
	self.touch = T_Mortar;
};


//=========================================================================
// Dispenser Touch function. Allows players to get stuff from the Dispenser.
void() T_Dispenser =
{
	local entity dist_checker;

	if (other.classname != "player")
		return;

	// Ignore any engineer working on this dispenser
	if (other.building == world && other.building_wait < time)
	{
		// Pop up the menu
		other.current_menu = #MENU_DISPENSER;
		other.menu_count = #MENU_REFRESH_RATE;

		other.building = self;

		// Start a Distance checker, which removes the menu if the player
		// gets too far away from the Dispenser.
		dist_checker = spawn();
		dist_checker.classname = "timer";
		dist_checker.owner = other;
		dist_checker.enemy = self;
		dist_checker.think = CheckDistance;
		dist_checker.nextthink = time + 0.3;
	}
};

void() Dispenser_Die =
{
	self.real_owner.has_dispenser = #FALSE;

	ThrowGib("progs/dgib1.mdl", -30);
	ThrowGib("progs/dgib2.mdl", -50);
	ThrowGib("progs/dgib3.mdl", -50);

	WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
	WriteByte (#MSG_BROADCAST, #TE_EXPLOSION);
	WriteCoord (#MSG_BROADCAST, self.origin_x);
	WriteCoord (#MSG_BROADCAST, self.origin_y);
	WriteCoord (#MSG_BROADCAST, self.origin_z);
#ifdef QUAKE_WORLD
	multicast (self.origin, #MULTICAST_PHS);
#endif

	BecomeExplosion ();
};

//=========================================================================
// Engineer has used a Spanner on the Dispenser
void(entity disp) Engineer_UseDispenser =
{
	local entity dist_checker;
	local string st;

	// Print the dispenser's details
	sprint (self, #PRINT_HIGH, "Dispenser has ");
	st = ftos(disp.health);
	sprint (self, #PRINT_HIGH, st);
	sprint (self, #PRINT_HIGH, " health\n");
	st = ftos(disp.ammo_shells);
	sprint (self, #PRINT_HIGH, st);
	sprint (self, #PRINT_HIGH, " shells, ");
	st = ftos(disp.ammo_nails);
	sprint (self, #PRINT_HIGH, st);
	sprint (self, #PRINT_HIGH, " nails,");
	st = ftos(disp.ammo_rockets);
	sprint (self, #PRINT_HIGH, st);
	sprint (self, #PRINT_HIGH, " rockets\n");
	st = ftos(disp.ammo_cells);
	sprint (self, #PRINT_HIGH, st);
	sprint (self, #PRINT_HIGH, " cells, and ");
	st = ftos(disp.armorvalue);
	sprint (self, #PRINT_HIGH, st);
	sprint (self, #PRINT_HIGH, " armor\n");

	// Pop up the menu
	self.current_menu = #MENU_ENGINEER_FIX_DISPENSER;
	self.menu_count = #MENU_REFRESH_RATE;

	self.building = disp;

	// Start a Distance checker, which removes the menu if the player
	// gets too far away from the Dispenser.
	dist_checker = spawn();
	dist_checker.classname = "timer";
	dist_checker.owner = self;
	dist_checker.enemy = disp;
	dist_checker.think = CheckDistance;
	dist_checker.nextthink = time + 0.3;
};

//=========================================================================
// Engineer has used a Spanner on the SentryGun
void(entity gun) Engineer_UseSentryGun =
{
	local entity dist_checker;
	local string st;

	// Print the gun's details
	sprint(self, #PRINT_HIGH, "Level ");
	st = ftos(gun.weapon);
	sprint(self, #PRINT_HIGH, st);
	sprint(self, #PRINT_HIGH, " Sentry Gun has ");
	st = ftos(gun.health);
	sprint(self, #PRINT_HIGH, st);
	sprint(self, #PRINT_HIGH, " health, ");
	st = ftos(gun.ammo_shells);
	sprint(self, #PRINT_HIGH, st);
	sprint(self, #PRINT_HIGH, " shells");
	if (gun.weapon == 3)
	{
		st = ftos(gun.ammo_rockets);
		sprint(self, #PRINT_HIGH, ", ");
		sprint(self, #PRINT_HIGH, st);
		sprint(self, #PRINT_HIGH, " rockets");
	}
	sprint(self, #PRINT_HIGH, "\n");

	// Pop up the menu
	self.current_menu = #MENU_ENGINEER_FIX_SENTRYGUN;
	self.menu_count = #MENU_REFRESH_RATE;

	self.building = gun;

	// Start a Distance checker, which removes the menu if the player
	// gets too far away from the Dispenser.
	dist_checker = spawn();
	dist_checker.classname = "timer";
	dist_checker.owner = self;
	dist_checker.enemy = gun;
	dist_checker.think = CheckDistance;
	dist_checker.nextthink = time + 0.3;
};

//=========================================================================
// Engineer has used a Spanner on the Mortar
void(entity mortar) Engineer_UseMortar =
{

};

//=========================================================================
// Think function for the timer which checks the distance between the 
// Engineer and the building he's using
void() CheckDistance =
{
	local vector dist;
	
	// Check to see if the Engineer's spanner'ed a different building 
	// without leaving the area of this one.
	if (self.owner.building != self.enemy)
	{
		dremove(self);
		return;
	}

	dist = self.enemy.origin - self.owner.origin;
	if (vlen(dist) > 64)
	{
		CenterPrint(self.owner, "\n");
		self.owner.menu_count = #MENU_REFRESH_RATE;
		self.owner.current_menu = #MENU_DEFAULT;
		self.owner.building = world;
		dremove(self);
		return;
	}

	self.nextthink = time + 0.3;
};

