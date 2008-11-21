// pushable stuff (code taken form nehahra+megatf coop
void () player_push2 =
{
	if ((other.classname != "player"))
	{
		return;
	}

	if ((walkmove (other.angles_y, 2) == FALSE))
	{
		self.velocity_x = (other.velocity_x + (4 * random ()));
		self.velocity_y = (other.velocity_y + (4 * random ()));
	}
};

void () func_pushable_think =
{
	if (self.buoyancy) {
		if (pointcontents((self.absmax+self.absmin)*.5) == CONTENT_WATER/* || pointcontents((self.absmax+self.absmin)*.5) == -1*/)
		{
			self.velocity_z = 100;
		}
		//bprint(2,"floatinnnggg\n");
	}
	self.nextthink = time + .1;
};

void () func_pushable =
{
	//precache_sound ("wall/push.wav");			// ADDME: New or dynamic push sound
	self.mangle = self.angles;
	self.angles = '0 0 0';
	self.classname = "pushwall";
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel (self, self.model);
	setorigin (self, self.origin);
	setsize (self, self.mins, self.maxs);

	// super: neherha intended for you to be able to push the barrels.
	// the other push function was messed up (pushed parallel to your direction) 
	self.touch = player_push2;

	if (mapname == "c1a2")
		if (self.model == "*29")
			self.origin_z -= 13;
			
	if (#HL_MAP) {
		if (self.buoyancy > 0)
		{
		self.origin_z += 10;
			self.movetype = MOVETYPE_BOUNCE;
			self.think = func_pushable_think;
			self.nextthink = time + .5;
		}
	}		
};