/*======================================================
	DEMOMAN.QC

	TeamFortress v2.5	 29/2/97
========================================================
Functions for the DEMOMAN class and associated weaponry                          
========================================================*/
// Functions outside this file
void() NormalGrenadeTouch;
void() NormalGrenadeExplode;

// Functions in this file
// Pipebomb Functions
void() TeamFortress_DetonatePipebombs;
void() PipebombTouch;
// Mirv Grenade Functions
void() MirvGrenadeTouch;
void() MirvGrenadeExplode;
void (vector org, entity shooter) MirvGrenadeLaunch;
// Detpack Functions
void(float timer) TeamFortress_SetDetpack;
void() TeamFortress_DetpackSet;
void() TeamFortress_DetpackStop;
void() TeamFortress_DetpackExplode;
void() TeamFortress_DetpackTouch;
void() TeamFortress_DetpackDisarm;
void() TeamFortress_DetpackCountDown;

//=========================================================================
// Detonate all thrown pipebombs
void() TeamFortress_DetonatePipebombs =
{
	local entity e;

	// Find all this players pipebombs
	e = find(world, classname, "pipebomb");
	while (e != world)
	{
    	if(e.owner == self)
			e.nextthink = time;
		
		e = find(e, classname, "pipebomb");
	}
};

//=========================================================================
// Pipebomb touch function
void() PipebombTouch =
{
	sound (self, #CHAN_WEAPON, "weapons/bounce.wav", 1, #ATTN_NORM);	// bounce sound
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
};

//=========================================================================
// Touch Function for Mirv Grenade
// Mirv Grenade heavily influenced by the Firewall Grenade by Steve Bond (wedge@nuc.net)
void() MirvGrenadeTouch =
{
	// If the Mirv Grenade hits a player, it just bounces off
	sound (self, #CHAN_WEAPON, "weapons/bounce.wav", 1, #ATTN_NORM);
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
};

//=========================================================================
// Mirv Grenade explode function, for when the PRIMETIME runs out
void() MirvGrenadeExplode =
{
	local float i;

	deathmsg = #DMSG_GREN_MIRV;
	T_RadiusDamage (self, self.owner, 100, world);

	WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
	WriteByte (#MSG_BROADCAST, #TE_EXPLOSION);
	WriteCoord (#MSG_BROADCAST, self.origin_x);
	WriteCoord (#MSG_BROADCAST, self.origin_y);
	WriteCoord (#MSG_BROADCAST, self.origin_z);
#ifdef QUAKE_WORLD
	multicast (self.origin, #MULTICAST_PHS);
#endif

	self.solid = #SOLID_NOT;

	// Launch mirvs
	i = 0;
	while (i < #GR_TYPE_MIRV_NO)
	{
		MirvGrenadeLaunch (self.origin + '0 0 -1',self.owner);
		i = i + 1;
	}

#ifdef DEMO_STUFF
	// Remove any camera's locks on this missile
	if (self.enemy)
		CamProjectileLockOff();
#endif

	BecomeExplosion();
};

//=========================================================================
// Launch a Mirv
void (vector org, entity shooter) MirvGrenadeLaunch =
{
	local float xdir,ydir,zdir;

	xdir = 150 * random() - 75;
	ydir = 150 * random() - 75;
	zdir = 40 * random();

	newmis = spawn ();
	newmis.owner = shooter;
	newmis.movetype = #MOVETYPE_BOUNCE;
	newmis.solid = #SOLID_BBOX;

	newmis.classname = "grenade";
	newmis.weapon = #DMSG_GREN_MIRV;

#ifdef NET_SERVER
	newmis.touch = NormalGrenadeTouch;
	newmis.think = NormalGrenadeExplode;
#else
	newmis.touch = GrenadeTouch;
	newmis.think = GrenadeExplode;
#endif

	newmis.nextthink = time + 2 + random();
	
	newmis.velocity_x = xdir * 2;
	newmis.velocity_y = ydir * 2;
	newmis.velocity_z = zdir * 15;

	newmis.avelocity='250 300 400';

	setmodel (newmis, "progs/grenade2.mdl");
	setsize (newmis, #VEC_ORIGIN, #VEC_ORIGIN);
	setorigin (newmis, org);
};

//=========================================================================
// Handles the Setting of Detpacks
void(float timer) TeamFortress_SetDetpack =
{
	local string stimer;

	// prevent detpack impulse from triggering anything else
	self.impulse = 0;
	self.last_impulse = 0;

	if (!(self.weapons_carried & #WEAP_DETPACK))
		return;

	if (self.ammo_detpack <= 0)
		return;

	// Cant set detpack if you're in the air
	if (!(self.flags & #FL_ONGROUND))
	{
		sprint (self, #PRINT_HIGH, "You can't set detpacks in the air!\n");
		return;
	}

	if (timer < 5)
	{
		sprint (self, #PRINT_HIGH, "You can't set detpacks for less that 5 seconds.\n");
		return;
	}

	self.is_detpacking = 1;
	self.ammo_detpack = self.ammo_detpack - 1;

	self.immune_to_check = time + 2;
	self.tfstate = self.tfstate | #TFSTATE_CANT_MOVE;
	// Save the current weapon and remove it
	self.weapon = self.current_weapon;
	self.current_weapon = 0;
	self.weaponmodel = "";
	self.weaponframe = 0;

#ifdef QUAKE_WORLD
	TeamFortress_SetSpeed(self);
#endif

	self.pausetime = time + #WEAP_DETPACK_SETTIME;

	stimer = ftos(timer);

	sprint(self, #PRINT_HIGH, "Setting detpack for ");
	sprint(self, #PRINT_HIGH, stimer);
	sprint(self, #PRINT_HIGH, " seconds...\n");

	newmis = spawn();
	newmis.owner = self;
	newmis.classname = "timer";
	newmis.netname = "detpack_timer";
	newmis.nextthink = time + #WEAP_DETPACK_SETTIME;
	newmis.think = TeamFortress_DetpackSet;
	newmis.health = timer;
};

//=========================================================================
// Stops the setting of the detpack
void() TeamFortress_DetpackStop =
{
	local entity detpack_timer;

	detpack_timer = find(world, netname, "detpack_timer");
	while ((detpack_timer.owner != self) && (detpack_timer != world))
		detpack_timer = find(detpack_timer, netname, "detpack_timer");

	if (detpack_timer == world)  
	    return;

    sprint(self, #PRINT_HIGH, "Detpack retrieved.\n");

	self.ammo_detpack = self.ammo_detpack + 1;
	dremove(detpack_timer);

	self.tfstate = self.tfstate - (self.tfstate & #TFSTATE_CANT_MOVE);

	self.is_detpacking = 0;
	self.current_weapon = self.weapon;
	W_SetCurrentAmmo();

#ifdef QUAKE_WORLD
	TeamFortress_SetSpeed(self);
#endif

	self.pausetime = time;
};

//=========================================================================
// The detpack is set, let the player go and start timer
void() TeamFortress_DetpackSet =
{
	local entity countd, oldself;

	self.is_detpacking = 0;
	self.owner.tfstate = self.owner.tfstate - (self.owner.tfstate & #TFSTATE_CANT_MOVE);

#ifdef QUAKE_WORLD
	TeamFortress_SetSpeed(self.owner);
#endif

#ifdef SPEECH
	stuffcmd(self.owner, "play speech/demo_dp.wav\n");
#endif

	oldself = self;
	self = self.owner;
	self.is_detpacking = 0;
	self.current_weapon = self.weapon;
	W_SetCurrentAmmo();
	self = oldself;

	newmis = spawn ();
	newmis.owner = self.owner;
    newmis.origin = self.owner.origin - '0 0 23';
	newmis.movetype = #MOVETYPE_BOUNCE;
#ifdef QUAKE_WORLD
	newmis.solid = #SOLID_BBOX;
#else
	newmis.solid = #SOLID_TRIGGER;
#endif
	newmis.classname = "detpack";
    newmis.flags = #FL_ITEM;
		
	newmis.angles = '90 0 0';
	newmis.angles_y = self.owner.angles_y;
	newmis.velocity = '0 0 0';
	newmis.avelocity = '0 0 0';

	newmis.weaponmode = 0;  // Detpack weaponmode = 1 when disarming
   	newmis.touch = TeamFortress_DetpackTouch;

	setmodel (newmis, "progs/detpack.mdl");
	setsize (newmis, '-16 -16 0', '16 16 8');
	setorigin (newmis, self.owner.origin);

	// Create the CountDown entity
    countd = spawn();
	newmis.linked_list = countd;    // attach count to its detpack
	countd.think = TeamFortress_DetpackCountDown;
	countd.health = self.health - 1;
	countd.owner = self.owner;
	countd.classname = "countdown_timer"; // Don't call it timer, because we
										  // don't want it removed if player dies
	countd.enemy = newmis;
	newmis.oldenemy = countd;
	if (self.health <= 10)
		countd.nextthink = time + 1;
	else
	{
		countd.nextthink = time + self.health - 10;
		countd.health = 9;
	}
	newmis.nextthink = time + self.health;
	newmis.think = TeamFortress_DetpackExplode;

	sprint(self.owner, #PRINT_HIGH, "Detpack set!\n");

	dremove(self);
};

//=========================================================================
// The detpack goes BOOM!
void() TeamFortress_DetpackExplode = 
{
	local float pos;

	bprint(#PRINT_MEDIUM, "FIRE IN THE HOLE!\n");

	// Check the pointcontents to prevent detpack outside the world
	pos = pointcontents(self.origin); 
	if (pos != #CONTENT_SOLID && pos != #CONTENT_SKY) 
	{
		deathmsg = #DMSG_DETPACK;
		T_RadiusDamage (self, self.owner, #WEAP_DETPACK_SIZE, world);

		WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
		WriteByte (#MSG_BROADCAST, #TE_EXPLOSION);
		WriteCoord (#MSG_BROADCAST, self.origin_x);
		WriteCoord (#MSG_BROADCAST, self.origin_y);
		WriteCoord (#MSG_BROADCAST, self.origin_z);
	#ifdef QUAKE_WORLD
		multicast (self.origin, #MULTICAST_PHS);
	#endif
	}
	else
	{
		bprint(#PRINT_HIGH, "Your detpack fizzled out.\n");
	}

	// This code handles a disarming scout with protection
	if (self.weaponmode == 1)     	  // Detpack was being disarmed
	{   
#ifdef QUAKE_WORLD
		TeamFortress_SetSpeed(self.enemy);
#else
		self.enemy.pausetime = time;		
#endif

		dremove(self.oldenemy);  	 // CountDown
		dremove(self.observer_list); //	Disarm timer
	}

	BecomeExplosion ();
};

//=========================================================================
// The detpack touch function. Scouts can disarm it.
void() TeamFortress_DetpackTouch = 
{
	local entity disarm;

	if (other.classname != "player")
		return;

	if (other.playerclass != #PC_SCOUT)
		return;
    
	if (self.weaponmode == 1)
	    return;

	if ((other.team_no == self.owner.team_no) && (self.owner.team_no != 0))
	    return;

	other.immune_to_check = time + 2;
	other.tfstate = other.tfstate | #TFSTATE_CANT_MOVE;

	sprint(other, #PRINT_HIGH, "Disarming detpack...\n");
#ifdef QUAKE_WORLD
	TeamFortress_SetSpeed(other);
#else
	other.pausetime = time + #WEAP_DETPACK_DISARMTIME;
#endif

	// Spawn disarming entity
	disarm = spawn();
	disarm.owner = other;		// the scout
	disarm.enemy = self;		// the detpack
	disarm.classname = "timer";
	disarm.nextthink = time + #WEAP_DETPACK_DISARMTIME;
	disarm.think = TeamFortress_DetpackDisarm;
	
	self.weaponmode = 1;  // indicates disarming
	self.enemy = other;   // points to scout
	self.observer_list = disarm;
};

//=========================================================================
// The detpack disarm function. Scout has finished disarming it
// .enemy is the detpack
// .owner is the scout
void() TeamFortress_DetpackDisarm = 
{
	bprint (#PRINT_MEDIUM, self.enemy.owner.netname);
	bprint (#PRINT_MEDIUM, "'s detpack was defused by ");
	bprint (#PRINT_MEDIUM, self.owner.netname);
	bprint (#PRINT_MEDIUM, "\n");
	
	self.owner.tfstate = self.owner.tfstate - (self.owner.tfstate & #TFSTATE_CANT_MOVE);

	// Reset speeds of scout
#ifdef QUAKE_WORLD
	TeamFortress_SetSpeed(self.owner);
#else
	self.owner.pausetime = time;		
#endif
	
	dremove(self.enemy.oldenemy);	// remove count down
	dremove(self.enemy);        	// remove detpack
	dremove(self);					// remove this timer
};

//=========================================================================
// The Detpack CountDown function. Displays the seconds left before the
// detpack detonates to the owner of the detpack, if <10
void() TeamFortress_DetpackCountDown = 
{
	local string cd;

	cd = ftos(self.health);

	sprint(self.owner, #PRINT_HIGH, cd);
	sprint(self.owner, #PRINT_HIGH, "...\n");

	self.nextthink = time + 1;
	self.health = self.health - 1;

	// Flash the red light
	if (self.health <= 4)
		self.enemy.skin = 1;

	if (self.health == 0)
		dremove(self);
};

