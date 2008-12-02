// misc and/or un-finished ents

// health and armor (HEV suit) chargers
void () func_chargerunit_use =
{
	if (self.has_tesla == 0) {
		if (activator.health == activator.max_health)
			return;
		activator.health = activator.health + 5;
		if (activator.health > activator.max_health)
			activator.health = activator.max_health;
			
		self.max_health -= 5;
		
		if (self.max_health <= 0) {
			self.hl_use = SUB_Null;
			self.frame = 1;
		}
	}
	else if (self.has_tesla == 1) {
		if (activator.armorvalue == 200)
			return;
		activator.armorvalue = activator.armorvalue + 5;
		if (activator.armorvalue > 200)
			activator.armorvalue = 200;
			
		self.armorvalue -= 5;
		
		if (self.armorvalue <= 0) {
			self.hl_use = SUB_Null;
			self.frame = 1;
		}
	}
};

void () func_chargerunit =
{
	self.solid = SOLID_BSP;
	setmodel(self, self.model);
	setorigin(self, self.origin);
	self.hl_use = func_chargerunit_use;
};

void () func_healthcharger =
{
	self.has_tesla = 0;	// health unit
	self.max_health = 75;
	func_chargerunit();
};

void () func_recharge =
{
	self.has_tesla = 1;	// armor unit
	self.armorvalue = 75;
	func_chargerunit();
};

// generally used in the training levels..
void () func_guntarget_die =
{
	self.velocity = '0 0 0';
	self.think = SUB_Null;
	self.takedamage = 0;
	self.target = self.message;
	SUB_UseTargets();
};
void () func_guntarget =
{
	func_train();
	self.takedamage = 1;
	self.th_die = func_guntarget_die;
};

//trigger_gravity: changes gravity of the palyer that touches it. Not exactly rocket science.
void () trigger_gravity_touch =
{
	if (other.classname != "player")
		return;
		
	if (#HL_MAP)
		other.gravity = self.gravity * .65;	// adjust it slightly, since half-life players can jump farther generally
	else
		other.gravity = self.gravity;
		
	other.oldgravity = other.gravity;
};

void () trigger_gravity =
{
	InitTrigger();
	self.touch = trigger_gravity_touch;
};

// Items that trigger things (like the HEV suit)
void () world_items_touch =
{
	if (other.classname != "player")
		return;

	SUB_UseTargets();
	dremove(self);
};

void () world_items =
{
//	self.origin_z += 30;

	if (self.type == 42)		// health
	{
		item_health();
	}
	else if (self.type == 43)	// security?
	{
		item_armor1();
	}
	else if (self.type == 44)	// Battery?
	{
		item_armor2();
	}
	else if (self.type == 45)	// HEV
	{
		setmodel(self,"progs/player.mdl");
		self.solid = SOLID_TRIGGER;
		self.touch = world_items_touch;
	}
	else
	{
		setmodel(self,"progs/player.mdl");
		dprint("world_items: no .type\n");
		self.solid = SOLID_TRIGGER;
		//self.nextthink = time + 5;
		//self.think = world_items_touch;
		self.touch = world_items_touch;
	}
	
};

void () env_bubbles =
{
	air_bubbles();
};

// UNFINISHED/UNSTARTED ENTITIES:
//(and I'm sure there's more than that, I just haven't gotten around to em yet)

// env_render: change the rendering properties of target based on own properties.
// I hope I got this right.
void () env_render_use =
{
	local entity targ, oself;
	oself = self;
	
	targ = find( world, targetname, self.target );
	while (targ)
	{
		//_bprint( "Running render effects on ", targ.classname, " with targetname ", targ.targetname, "\n" );
		targ.rendermode = self.rendermode;
		targ.renderamt = self.renderamt;
		targ.rendercolor = self.rendercolor;
		self = targ;
		HalfLife_DoRender();
		self = oself;
		targ = find( targ, targetname, self.target );
	}
};

void () env_render =
{
	self.use = env_render_use;
};

// func_friction: changes player friction when touched
// Note: .friction value does nothing yet
void () func_friction_touch =
{
	if (other.classname != "player")
		return;
		
	other.friction_time = time + .1;
	other.friction_new = self.modifier*.01;	// .modifier value is between 0 and 100
	
	//_bprint("New friction: ", ftos(other.friction_new), "\n");
};

void () func_friction =
{
	self.solid = SOLID_TRIGGER;
	setmodel( self, self.model );
	self.movetype = MOVETYPE_NONE;
	self.touch = func_friction_touch;
	
	HalfLife_DoRender();
};

void () monster_scientist_dead =
{
	dremove(self);
}

void () monster_barney_dead =
{
	dremove(self);
}

void () info_node =
{
	self.solid = SOLID_TRIGGER;
	setsize (self, '-32 -32 -4', '32 32 4');
	self.targetname = vtos (self.origin);
};



void () trigger_autosave =
{
	dremove(self);
};

void () light_spot =
{
	light ();
};

void () gibshooter =
{
	dremove(self);
};

// env_sound is a sound-shaper (IE adjusts sounds for hallways and such)
void () env_sound =
{
	dremove(self);
};

// EXTRAS_R4 STUFF:
//============================================================================
float VIEWONLY = 1;

void() shake_think =
{
	if (self.attack_finished < time) {// Done
		
		self.nextthink = -1;
		
		if (self.noise1)
			sound (self, CHAN_VOICE, self.noise1, 1, ATTN_NORM);
		
		return;
	}
	
	local	entity plyr;
	
	// Shake all players in the effect radius...
	
	plyr = findradius(self.origin, self.count);
	
	while(plyr)
	{
		if (plyr.classname == "player") {
			
			local float	d;
			
			// Scale effect by distance
			d = vlen(self.origin - plyr.origin);
			d = (self.count - d)/self.count;
			
			if (d > 0) {

				// shake up the view
				plyr.punchangle_x = -1 * (random() + (0.025*self.dmg*d));
				
				// push the player around
				if (plyr.flags & FL_ONGROUND && !self.spawnflags & VIEWONLY) {
					d = self.dmg*d;
					plyr.velocity_x = plyr.velocity_x + (random()*d*2 - d);
					plyr.velocity_y = plyr.velocity_y + (random()*d*2 - d);
					plyr.velocity_z = plyr.velocity_z + (random()*d);// always push up
				}	
			}
		}
		
		plyr = plyr.chain;
	}
	
	// keep going
	self.nextthink = time + 0.1;
};

void() shake_use =
{
	if (self.attack_finished > time) return;// already active

	// Start...
	
	if (self.noise)
		sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
	
	self.attack_finished = time + self.wait;
	self.nextthink = time + 0.01;
};

/*QUAKED trigger_shake (.5 .5 .5) ? VIEWONLY
Earthquake trigger - shakes players in it's radius when active.
Strength of tremor is greatest at the centre.

"dmg"			Strength at center (default is 120)
"wait"			Duration of shake (default is 1)
"count"			Affect radius (defalt is 200)
"noise"			Noise to play when starting to shake
"noise1"		Noise to play when stopping
"targetname"	Must be triggered

Spawnflags:
"VIEWONLY"		Shakes the view, but player movement is not affected

*/
void() trigger_shake =
{	
	if (!self.targetname) objerror("trigger_shake without name");

	if (self.noise) precache_sound (self.noise);
	if (self.noise1) precache_sound (self.noise1);
	
	if (!self.dmg) self.dmg = 120;
	if (self.count <= 0) self.count = 200;
	if (self.wait <= 0) self.wait = 1.0;
	
	setorigin(self, self.origin);
	
	self.nextthink = -1;
	self.think = shake_think;
	self.use = shake_use;
};

void () env_shake =
{
	trigger_shake();
};

//============================================================================
