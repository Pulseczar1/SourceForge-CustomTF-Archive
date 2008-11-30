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



// UNFINISHED/UNSTARTED ENTITIES:
//(and I'm sure there's more than that, I just haven't gotten around to em yet)
void () monster_scientist_dead =
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

void () env_sound =
{
	dremove(self);
};
