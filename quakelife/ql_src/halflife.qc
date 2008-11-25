// Half-Life entity support
//A lot of these are from merc's oztf mod, so props to him!!

//xavior: wrapper functions from tf/qw
void (float nmb, string bpstr) bprint =
{
	_bprint(bpstr);
};

void (entity t_plyr, float nmb, string bpstr) sprint =
{
	_sprint(t_plyr, bpstr);
};

void (entity t_rmove) dremove =
{
	if (t_rmove == world) {
		bprint(2, "Some shlub tried to remove da woild! oi!\n");
		return;
	}
	remove(t_rmove);
};

float () CheckExistence =
{
	// always true, because we're a singleplayer/coop mod
	return true;
};

string (entity t_world, string t_infokey) infokey =
{
	// use cvars
	return( cvar_string(t_infokey) );
};

void () BecomeExplosion =
{
	dremove (self);
};

void () CenterPrint =
{
};
//END wrapper fucntions

//.string areaname;
//.float material;
string __fullspawndata;

//string _delaydata;

.string LightningEnd;
.string LightningStart;

.vector rendercolor;
//.float renderamt;


.string LaserTarget;

void () info_target = {

};

void () item_healthkit = {

   self.origin_z = self.origin_z + 40;
   item_health ();
};

.float damage;
void() lightning_fire2 = {

   local entity te;


   te = find (world,targetname,self.LaserTarget);


   if (te) {

   self.team_no = 666;
   traceline (self.origin, te.origin, true, self);
   LightningDamage (self.origin, te.origin, self, self.damage*5, MOD_SHAFT);
      sound (self,2.000,"misc/power.wav",1.000,1.000);

      WriteByte (4.000,23.000);
      WriteByte (4.000,6.000);
      WriteEntity(4.000, self);
	WriteCoord (4.000, self.origin_x);
	WriteCoord (4.000, self.origin_y);
	WriteCoord (4.000, self.origin_z);
	WriteCoord (4.000, te.origin_x);
	WriteCoord (4.000, te.origin_y);
      WriteCoord (4.000, te.origin_z);
      multicast (self.origin ,1.000);



   }
   else
   {
      dprint (te.classname);
      dprint (" missing laser targets\n");

   }
   

};
void()lbeam_think;
void () laser_use = {
local entity lbeam;
   if (self.spawnflags & 1.000) {
      //lightning_fire2();
      self.spawnflags = (self.spawnflags - 1.000);
   }
   else 
   {
  		lbeam = spawn();
		lbeam.owner = self;
		lbeam.think = lbeam_think;
		lbeam.nextthink = time;
      SUB_Null();
      self.spawnflags = (self.spawnflags + 1.000);
   }

};

void () env_laser = {
local entity lbeam;
		lbeam = spawn();
		lbeam.owner = self;
		lbeam.think = lbeam_think;
		lbeam.nextthink = time;
//dremove(self);
   self.use = laser_use;

};


void () Explode = {

   WriteByte (4.000,23.000);
   WriteByte (4.000,3.000);
   WriteCoord (4.000,self.origin_x);
   WriteCoord (4.000,self.origin_y);
   WriteCoord (4.000,self.origin_z);
   multicast (self.origin,1.000);
   
	// todo: maybe dynamicize damage?
	if (!self.spawnflags & 1)	// spawnflags & 1 == players take no damage
		T_RadiusDamage(self, self.owner, 120, self.iMagnitude, world, MOD_HLIFE);
};

void () env_explosion = {

	if (!self.iMagnitude)
		self.iMagnitude = 120;
  self.use = Explode;

};

void () env_glow = {

   dremove(self);

};


void () FadeUse {

   eprint(activator);
}

void () env_fade = {

   self.use = FadeUse;

};

void () env_beam_think =
{
local entity lstart, lend;
	self.think = env_beam_think;
	self.nextthink = self.ltime + .5;
	
   lstart = find(world, targetname, self.LightningStart);
   lend = find(world, targetname, self.LightningEnd);
   // xavior: quake lets us use lightning.. SO LET THERE BE LIGHT :)
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_LIGHTNING1);
	WriteEntity (MSG_BROADCAST, self);
	WriteCoord (MSG_BROADCAST, lstart.origin_x);
	WriteCoord (MSG_BROADCAST, lstart.origin_y);
	WriteCoord (MSG_BROADCAST, lstart.origin_z);
	WriteCoord (MSG_BROADCAST, lend.origin_x);
	WriteCoord (MSG_BROADCAST, lend.origin_y);
	WriteCoord (MSG_BROADCAST, lend.origin_z);
};

void () lbeam_think =
{
	local entity lstart, lend, oself;
	oself = self;
	
	if (!self.owner.spawnflags & 1) {
		dremove(self);
		return;
	}
	self = self.owner;
	if (self.LightningStart) {
	   lstart = find(world, targetname, self.LightningStart);
	   lend = find(world, targetname, self.LightningEnd);
	   // xavior: quake lets us use lightning.. SO LET THERE BE LIGHT :)
	   TE_lightning1(self, lstart.origin, lend.origin);
	   /*
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_LIGHTNING3);
		WriteEntity (MSG_BROADCAST, self);
		WriteCoord (MSG_BROADCAST, lstart.origin_x);
		WriteCoord (MSG_BROADCAST, lstart.origin_y);
		WriteCoord (MSG_BROADCAST, lstart.origin_z);
		WriteCoord (MSG_BROADCAST, lend.origin_x);
		WriteCoord (MSG_BROADCAST, lend.origin_y);
		WriteCoord (MSG_BROADCAST, lend.origin_z);
		*/
	}
	else {
		if (self.LaserTarget) {
			lend = find(world, targetname, self.LaserTarget);
			//traceline (self.origin, lend.origin, true, self);
			LightningDamage (self.origin, lend.origin, self, self.damage*5, MOD_SHAFT);
			TE_lightning3(self, self.origin, lend.origin);
		}
		else {
			// ADDME: create random beams
		}
	}
	
	self = oself;
	self.nextthink = time + .2;
};

void () env_beam_use = {

	local entity lbeam;
   if ( (self.spawnflags & 1.000) ) {

      self.solid = 0.000;
      //setmodel (self, string_null);
      self.spawnflags = (self.spawnflags - 1.000);

   } else {

		lbeam = spawn();
		lbeam.owner = self;
		lbeam.think = lbeam_think;
		lbeam.nextthink = time;
      self.solid = 1.000;
      //setmodel (self,self.mdl);
      self.spawnflags = (self.spawnflags + 1.000);

   }
   
   if (self.think == env_beam_think) {
		self.think = SUB_Null;
		return;
	}

};

void () beam_delayed_spawn = {

   local vector orgStart;
   local vector orgEnd;
   local entity te;

   te = find( world, targetname,self.LightningStart);

   if (te != world)
   {
//dprint("found start\n");
      orgStart = te.origin;
   }

   te = find( world, targetname, self.LightningEnd);

   if (te != world)
   {
      orgEnd = te.origin;
//dprint("found end\n");
    }

   if (orgStart)
     setorigin(self, orgStart);

   self.angles = vectoangles (orgEnd - orgStart);
   //self.angles = vectoangles (orgEnd);


   self.think = SUB_Null;
};

void () env_beam = {
local entity lbeam;
   self.solid = 1.000;
   self.movetype = 5.000;

   if ( self.mdl ) {

      precache_model (self.mdl);

   } else {
      precache_model ("progs/beam.mdl");
      self.mdl = "progs/beam.mdl";
      //if (self.team_no = 2.000
   }

   
//beams have a set destination in code and generated by 
//each vector specified in halflife. Unfortunately this 
//isnt a feature i have so we must be a bit dodgy and 
//use a beam model and try to correct its orientation

   self.use = env_beam_use;
   self.think = beam_delayed_spawn;
   self.nextthink = (time + 3.000);

   if (self.rendercolor_z < self.rendercolor_x) 
      self.skin = 1.000;
  
   if (self.spawnflags & 1.000) {
  		lbeam = spawn();
		lbeam.owner = self;
		lbeam.think = lbeam_think;
		lbeam.nextthink = time;
      //setmodel (self,self.mdl);
   }
};


void () Item_Use = {

      if ( (self.use != SUB_Null) )
      {
         if ( self.use )
         {

            self.use ();
         }
      }

};


void () Delayed_Use = {

//   local entity t;
 //  local entity ste;
              
			  
	SUB_UseTargets();
	strunzone(self.target);		// UNZONE OR DIEEEEEEish. well it's quite nasty anyways..
	dremove(self);
};

#define NEW_METHOD
void () multi_spawn = {


	local float args, i, d_time, stlen;
	local string c_a, st, st2, c_a2;
	local entity t, timer;
	local string key;
	local string value;
	
	//hldprint(2,self.netname);
	//hldprint(2, " is my netname\n");
	
	self.activated = #TRUE;
	self.use = SUB_Null;
	if (self.has_tesla == 0 || self.has_tesla == 2) {
		

		i = 0;
		if (self.has_tesla == 2)
			i = 1;		// skip the "}"

		args = tokenize(self.netname);

		while(args>0)
		{
			c_a = argv(args - 2);
			c_a = strzone(c_a);
#ifdef NEW_METHOD
			c_a2 = c_a;
			c_a2 = strzone(c_a2);

			stlen = strlen (c_a2);
			st2 = substr(c_a2 , stlen - 2, stlen - 1);
			//bprint(2,st2);
			//bprint(2," is st2!\n");
			if (st2 == "#1" || st2 == "#2" || st2 == "#3" || st2 == "#4" || st2 == "#5" || st2 == "#6")
			{
	            st = substr(argv(args-2), 0 , stlen - 2);
				st = strzone(st);
				strunzone(c_a);
				c_a = st;
				c_a = strzone(c_a);
				strunzone(st);
			}
			strunzone(c_a2);

#else
	        st = strstr (c_a, "#1");	
	        if (st != string_null)
	        {
	            stlen = strlen (c_a);
	            st = substr(c_a , 0 , stlen - 2);
				strunzone(c_a);
				st = strzone(st);
				c_a = st;
				c_a = strzone(c_a);
				strunzone(st);
	        }
#endif
			d_time = stof(argv(args-1));
			
			//_bprint(c_a, " is c_a and ", ftos(d_time), " is d_time\n");
			//_bprint(ftos(args), " is args!\n");
			
			
			t = find (world,targetname, c_a);
			if ( t )
			{
				if (c_a != self.targetname) {
					if (d_time > 0) {
						timer = spawn ();
						timer.classname = "DelayedTimer";
						timer.target = c_a;
						timer.target = strzone(timer.target);
						timer.nextthink = (time + d_time);
						timer.think = Delayed_Use;
					}
					else if (t.classname == "multi_manager") {
						// delay multi_spawns because they interfere with argv calls.
						timer = spawn ();
						timer.classname = "DelayedTimer";
						timer.target = c_a;
						timer.target = strzone(timer.target);
						timer.nextthink = (time + .1);
						timer.think = Delayed_Use;
					}
					else {
						timer = spawn ();
						timer.classname = "DelayedTimer";
						timer.target = c_a;
						timer.target = strzone(timer.target);
						timer.nextthink = (time);
						timer.think = Delayed_Use;
						//self.target = c_a;
						//SUB_UseTargets();
					}
				}
			}

			strunzone(c_a);
			args = args - 2;
			//i = i + 2;//i++;i++;
		}
	}
	else {		// Note: this is almost NEVER used
		  tokenize(self.netname);
		  args = argc() - 2; 

		  while(args>0)
		  {

		   key = (argv(args - 1));
		   value = (argv(args));
			key = strzone(key);
			value = strzone(value);

		     if ((((key != "classname") && (key != "targetname")) && (key != "origin")))
		     {
		        self.target = key;
				self.target = strzone(self.target);
		        self.delay = stof(value);

		        st = strstr (key, "#1");

		        if (st != string_null)
		        {
		            stlen = strlen (key);
					strunzone(key);
		            key = substr(self.target , 0 , stlen - 2);
					key = strzone(key);
		        }


		               //  bprint(2.000,key);
		               //  bprint(2.000,"  ");
		               //  bprint2(2.000, ftos(stlen), "\n");

		        if (self.delay)
		        {
		              
		           if (stlen)
		           {

		              timer = spawn ();
		              timer.classname = "DelayedTimer";
		              timer.target = strzone(key);
		              timer.nextthink = (time + self.delay);
		              timer.think = Delayed_Use;

		           }
		           else
		           {
		              t = find (world,targetname, key);
		              if ( t )
		              { 
						if (t.classname == "multi_manager") {
							// delay multi_spawns because they interfere with argv calls.
			              timer = spawn ();
			              timer.classname = "DelayedTimer";
						  timer.target = key;
			              timer.target = strzone(timer.target);
			              timer.nextthink = (time + .1);
			              timer.think = Delayed_Use;
						}
						else {
		                 t.nextthink = (time + self.delay);
		                 t.think = Item_Use;
						}
		              }


		           }

		        }
		        else
		        {

		           SUB_UseTargets();
		        }
		      stlen = 0.000;
		     }
				strunzone(key);
				strunzone(value);
		     args = args - 2;
		  }
  }
  self.use = multi_spawn;
};

//NOTE: c3a1 has a multi_manager that has a field value of "blocked" "0".. need to change that in the .ent or use FTE
void () multi_manager = {
	local float i;

	if (__fullspawndata != string_null) {
		if (checkextension("FRIK_FILE"))
		{
			// whee, nothing - just allows compat for frik_file's strzone
		}
		if (checkextension("KRIMZON_SV_PARSECLIENTCOMMAND"))
		{
			// same
		}
		//self.has_tesla = 2;	// use FTE method to parse multi_manager
		
		tokenize(__fullspawndata);
		i = 1;
		while (argv(i) != string_null && argv(i) != "}") {
			self.netname = strcat(self.netname, argv(i));
			self.netname = strcat(self.netname, " ");
			i++;
		}
		
		//self.netname = __fullspawndata;
	}
	if (self.netname) {
		self.use = multi_spawn;
	}
	self.netname = strzone(self.netname);
};

void () SplashTouch = {

  if (other.classname != "player") return;

      other.watertype = -3;
      other.waterlevel = 1;

};

void ()ladder_touch;
void () func_water_use =
{
	if (self.has_tesla == 1) {
		SUB_CalcMove(self.pos1, self.speed, SUB_Null);
		self.has_tesla = 0;
	}
	else {
		SUB_CalcMove(self.pos2, self.speed, SUB_Null);
		self.has_tesla = 1;
	}
};

void () func_water = {

if (mapname == "openfire" || mapname == "tfc_openfire") 
   dremove(self);
   
   self.solid = 1.000;
   self.movetype = 0.000;
   //setorigin (self,self.origin);
   setmodel (self,self.model);
  // setorigin (self,((self.absmax+self.absmin)*.5));
  setorigin(self, self.origin);
  
	SetMovedir ();
	if (!self.lip)
		self.lip = 8;
	if (!self.speed)
		self.speed = 100;
		
	self.pos1 = self.origin;
	self.pos2 = self.pos1 + self.movedir*(fabs(self.movedir*self.size) - self.lip);
	
	if (self.spawnflags & 1) { // start moved
		setorigin(self, self.pos2);
		self.has_tesla = 1;
	}
	
	self.use = func_water_use;
	
   if (#HL_MAP) {
	self.touch = ladder_touch; // better swim function is required lol
   }
   else
	self.touch = SplashTouch;

	HalfLife_DoRender();
};


void () func_wall_toggle_use =
{
	if (self.solid == 0) {
	   self.movetype = 7.000;
	   self.solid = 4.000;
	   setmodel (self,self.mdl);
	}
	else {
      self.solid = 0.000;
      setmodel (self,string_null);
	}
};

void () func_wall_toggle = {

   self.movetype = 7.000;
   self.solid = 4.000;
   self.mdl = self.model;
   setmodel (self,self.mdl);
   
 if (self.targetname)
  self.use = func_wall_toggle_use; 
   
  	if (self.spawnflags & 1) {	// starts invisible
      self.solid = 0.000;
      setmodel (self,string_null);
	}
   
   //self.spawnflags = 1.000;
   
   HalfLife_DoRender();
};



void () info_areadef = {

   dremove(self);

};  

void () infodecal = {

   dremove(self);

};  

void ( string t_Target, float t_Time ) Delayed_Timer =
{
	local entity timer;

	if (t_Time < 0) {
		bprint(2, "Delayed_Timer: t_Time < 0\n");
		t_Time = .1;
	}
	
	timer = spawn ();
	timer.classname = "DelayedTimer";
	timer.target = t_Target;
	timer.target = strzone(timer.target);
	timer.nextthink = (time + t_Time);
	timer.think = Delayed_Use;
};


/*
void () trigger_camera = {

   self.classname = "info_player_start";

};



*/
// Do *some* of the half-life render stuff.
void () HalfLife_DoRender =
{
	local vector osize, omins, omaxs, oabsmin, oabsmax;

	if (self.rendercolor != '0 0 0') {}	// ADDME
	
	if (self.rendermode > 0)
		if (self.renderamt > 0) {
			self.alpha = self.renderamt/255;
			if (self.alpha == 0)
				self.alpha = .01;
		}
		if (self.rendermode == 2) {
			self.alpha = self.renderamt/255;
			if (self.alpha == 0) {
				//self.alpha = 0.01;
				osize = self.size;
				omins = self.mins;
				omaxs = self.maxs;
				oabsmin = self.absmin;
				oabsmax = self.absmax;
				setmodel(self, string_null);
				if (self.classname == "func_breakable")
					self.solid = SOLID_NOT;
				else
					self.solid = SOLID_BBOX;
				self.size = osize;
				self.mins = omins;
				self.maxs = omaxs;
				self.absmin = oabsmin;
				self.absmax = oabsmax;
				//setorigin(self, self.origin);
			}
		}
};