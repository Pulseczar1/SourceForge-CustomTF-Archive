// misc and/or un-finished ents


/*
	Written by Frank Condello <pox@planetquake.com>
	
	Misc functions/entities....
	
	func_ladder
	func_explobsp
	func_breakaway
	func_nodraw
	func_bspframe
	func_model
*/

//============================================================================

float LADDEROFS = 0.36;// touchy...
#define LADDER_MOVESPEED	400

// This is tricky cause we can't just check key presses...
void() ladder_touch =
{
	local vector vel;
	float fvel, spd;
	
	if (other.classname != "player") return;
	
	// FIXME! - time out for teleporters?
	
	// Don't stick underwater, or in the middle of a waterjump
	if (other.waterlevel > 1 || other.fwatershifttime > time) return;
	if (other.flags & FL_WATERJUMP) return;
	
	// Don't re-grab right away if jumping
	if (other.ladderjump > time) return;
	
	// Check if the player can grab the ladder
	makevectors (other.angles);
	if (v_forward*self.movedir<-0.5)// a little more than 180¼ of freedom
		return;// not facing the right way
	
	// Avoid problems if the player is on the top edge (act like an 8 unit step)
	if (other.origin_z + other.mins_z + 8 >= self.absmax_z) {
		if ((!other.flags & FL_ONGROUND))
			other.flags = other.flags + FL_ONGROUND;
		return;
	}
	
	// Null out gravity in PreThink
	other.laddertime = other.zerogtime = time + 0.1;

/*	FIXME! - Physics on a moving ladder don't quite work
	// Factor in the parent train's movement
	if (self.owner) {
		
		// Stop all vertical movement
		other.velocity_z = self.owner.velocity_z;
		
		// Check if the player is moving sideways (don't go up/down)
		if (v_right*(other.velocity - self.owner.velocity) > 25) {
			other.velocity = self.owner.velocity;
			other.origin = other.origin + v_right*0.5;
			return;
		}
		else if (v_right*(other.velocity - self.owner.velocity) < -25) {
			other.velocity = self.owner.velocity;
			other.origin = other.origin - v_right*0.5;
			return;
		}
		
		// Get the player's forward speed	
		fvel = v_forward*(other.velocity - self.owner.velocity);
	
	} else {// Stationary		
*/	
		// Stop all vertical movement
		other.velocity_z = 0;
		
		// Check if the player is moving sideways (don't go up/down)
		/*if (fabs(v_right*other.velocity) > 25) {
			other.velocity = '0 0 0';
			return;
		}*/
		if (v_right*other.velocity > 25) {
			other.velocity = '0 0 0';
			other.origin = other.origin + v_right*0.5;// boost strafes
			return;
		}
		else if (v_right*other.velocity < -25) {
			other.velocity = '0 0 0';
			other.origin = other.origin - v_right*0.5;// boost strafes
			return;
		}
		
		// Get the player's forward speed	
		fvel = v_forward*other.velocity;
//	}
	
	vel = '0 0 0';// Our new velocity
	
	// Up (facing up/forward)
	if (other.v_angle_x <= 15 && fvel>0 ) {
		other.origin = other.origin - self.movedir*LADDEROFS;// Pull back to keep from hitting the backing wall
		vel_z = fabs(other.v_angle_x)*6;// go faster when facing forward	
		if (vel_z < 90) vel_z = 90;// minimum speed
	}
	// Up (facing down)
 	else if ( other.v_angle_x >= 15 && fvel<0 ) {
		other.origin = other.origin + self.movedir*LADDEROFS;// Pull in to keep from falling off
		vel_z = other.v_angle_x*4;
	}
	// Down (facing up/forward)
	else if (other.v_angle_x <= 15 && fvel<0 ) {	
		other.origin = other.origin + self.movedir*LADDEROFS;// Pull in to keep from falling off
		vel_z = fabs(other.v_angle_x)*-5;// go faster when facing forward	
		if (vel_z > -80) vel_z = -80;// minimum speed
	}
	// Down (facing down)
	else if ( other.v_angle_x >= 15 && fvel>0 ) {		
		other.origin = other.origin - self.movedir*LADDEROFS;// Pull back to keep from hitting the backing wall
		vel_z = other.v_angle_x*-4;
	}
	
	// Cap vertical moves to the server limits
	//spd = cvar("cl_upspeed");
	spd = LADDER_MOVESPEED;
	if (vel_z > spd) vel_z = spd;
	else if (vel_z < -1*spd) vel_z = -1*spd;
	
	// Add the parent's velocity - FIXME! - Physics on a moving ladder don't quite work
	//if (self.owner) vel = vel + self.owner.velocity;
	
	// Set the player's new veloctity
	other.velocity = vel;
};

/*QUAKED func_ladder (0 .5 .8) ?
Creates an invisible trigger area that the player can "climb" vertically.

Dependant on additions in client.qc, and player.qc

The movement was initially intended to mimic ladders in RTCW, but there
are some differences due to QuakeC limitations, and personal preference
(jumping behaviour and speed can easily be changed).

"angle" The direction the player must be facing in order to climb
"targetname" use as a killtarget to delete the ladder
DISABLED: "target" Attach the ladder to a func_train_ext

------------------------------------------------------------------------------------
BUGS:
- up/down keys don't climb (only way is to use MOVETYPE_FLY, which means current touch code is useless)
- DISABLED: physics break when the player is trying to move in the same direction as a ladder's parent train

------------------------------------------------------------------------------------
USEAGE NOTES:

These work best when they are at least 8 units thick.

Make sure the angle is set correctly. All movement revolves around the ladder's
facing angle. (Remember: It's the angle the PLAYER must be facing to climb)

The top of the func_ladder brush should be flush with the top of the ledge (if the
ladder leads to a ledge). Ladders behave as if there's an 8 unit "step" at the top.

It's a good idea to back these up with a solid brush or a clipping brush.
Especially if using real geometry for the rungs. (i.e. to fill the gaps between the rungs)

If you need a "two-way" ladder (like a ladder hanging from a fire-escape) use a clip
brush in the middle, and two func_ladders on either end with opposite facing angles.

Avoid situations where more than one func_ladder can be touched at the same time.

*/
void() func_ladder =
{
	InitTrigger();
	self.touch = ladder_touch;

/*	FIXME! - Physics on a moving ladder don't quite work
	// Attach the ladder to it's parent
	if (self.target) {
		self.think = train_ext_linkchild;
		self.nextthink = time + 0.2;
	}
*/
};

/*
void () ladder_touch =
{
	local vector pvec;

	if (other.classname != "player")
		return;
	
	makevectors (other.v_angle);
	pvec = v_forward;
	pvec = (pvec * 250);
	if (other.button2)		// jump off the ladder
		other.velocity = pvec;
	else
		other.velocity_z = pvec_z;
	//bprint(2," TOUCHINGGG\n");
};
void () func_ladder =
{
	InitTrigger();
	self.touch = ladder_touch;
};
*/
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
	dremove(self);
};


void () env_spark =
{
	dremove(self);
};

void () trigger_autosave =
{
	dremove(self);
};

void () light_spot =
{
	dremove(self);
};

void () gibshooter =
{
	dremove(self);
};

void () env_sound =
{
	dremove(self);
};
