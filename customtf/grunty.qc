/*
==============================================================================

GRUNTY.QC

==============================================================================
*/

/* ALREADY DEFINED IN ARMY.QC

#define WAYPOINT_TYPE_PRIMARY 0
#define WAYPOINT_TYPE_SECONDARY 1
#define WAYPOINT_TYPE_ENEMYLASTSEEN 2

*/

// Function Prototypes
// Whenever a function is added within the grunty, add it up here

void(entity wyp, entity soldier) RemoveWaypoint;

void () GruntyThink;
void () GRun;
void () GruntyScanTargets;
void () GruntyCheckFire;
void (entity targ) GetRank;
void () Grunty_Check_Frags;
void (float angle, float dist) botmovedist;
float () ReturnWeaponVelocity;
void () GruntyPayThink;
void () GruntyDrawPay;


// External Functions
// List all external functions used here
float () isMelee;
//entity (entity scanner) LookAround;

//=- OfN -=//
void(entity sld, entity player, string msg, float priority) PrintFromSoldier;
string(entity sld) GetOwnerMessage;
string(entity sld) GetFriendlyMessage;
entity (entity sold, entity viewpoint) ReturnEasyWaypoint;
string(entity thething) GetEnemyName;
void () CheckWaterJump;


// The Frames of Grunty

$cd /raid/quake/id1/models/player_4
$origin 0 -6 24
$base base
$skin skin0
$skin skin1
$skin skin2
$skin skin3

// Frames, from player.qc

//
// running
//
$frame axrun1 axrun2 axrun3 axrun4 axrun5 axrun6

$frame rockrun1 rockrun2 rockrun3 rockrun4 rockrun5 rockrun6

//
// standing
//
$frame stand1 stand2 stand3 stand4 stand5

$frame axstnd1 axstnd2 axstnd3 axstnd4 axstnd5 axstnd6
$frame axstnd7 axstnd8 axstnd9 axstnd10 axstnd11 axstnd12


//
// pain
//
$frame axpain1 axpain2 axpain3 axpain4 axpain5 axpain6

$frame pain1 pain2 pain3 pain4 pain5 pain6


//
// death
//
$frame axdeth1 axdeth2 axdeth3 axdeth4 axdeth5 axdeth6
$frame axdeth7 axdeth8 axdeth9

$frame deatha1 deatha2 deatha3 deatha4 deatha5 deatha6 deatha7 deatha8
$frame deatha9 deatha10 deatha11

$frame deathb1 deathb2 deathb3 deathb4 deathb5 deathb6 deathb7 deathb8
$frame deathb9

$frame deathc1 deathc2 deathc3 deathc4 deathc5 deathc6 deathc7 deathc8
$frame deathc9 deathc10 deathc11 deathc12 deathc13 deathc14 deathc15

$frame deathd1 deathd2 deathd3 deathd4 deathd5 deathd6 deathd7
$frame deathd8 deathd9

$frame deathe1 deathe2 deathe3 deathe4 deathe5 deathe6 deathe7
$frame deathe8 deathe9

//
// attacks
//
$frame nailatt1 nailatt2

$frame light1 light2

$frame rockatt1 rockatt2 rockatt3 rockatt4 rockatt5 rockatt6

$frame shotatt1 shotatt2 shotatt3 shotatt4 shotatt5 shotatt6

$frame axatt1 axatt2 axatt3 axatt4 axatt5 axatt6

$frame axattb1 axattb2 axattb3 axattb4 axattb5 axattb6

$frame axattc1 axattc2 axattc3 axattc4 axattc5 axattc6

$frame axattd1 axattd2 axattd3 axattd4 axattd5 axattd6

void(entity grunty) grunty_setstartframe =
{
	grunty.frame = $stand1;
};


// Grunty is standing with his axe or other melee weapon
// Note that he must do a GruntyThink each frame
// (each frame is 0.05 seconds)
// However, he may only animate every 0.1 seconds, hence the flooring and odd incrementing
// of his frame variable. (0.05 animation is very smooth and twice as fast as normal)

void() grunty_run;

void() grunty_stand = // We need two stand sections for axe and weapon
{
	//self.nextthink = time + 0.05; //needed?? nope
	if (self.health > 0)
		self.think = grunty_stand;

	self.weaponframe = 0;

	if (isMelee())
	{
		if (self.walkframe >= 12)
			self.walkframe = 0;
		self.frame = $axstnd1 + floor(self.walkframe);
	}
	else
	{
		if (self.walkframe >= 5)
			self.walkframe = 0;
		self.frame = $stand1 + floor(self.walkframe);
	}

	self.walkframe = self.walkframe + 0.5;
	//self.walkframe = self.walkframe + 0.5;

	// allow grunty pick up ammo when standing
	//touchworld();

	#ifdef VERBOSE_GRUNTY
	if (self.super_time <= time)
	{
		sprint(self.real_owner, #PRINT_HIGH, "Soldier in position and awaiting target.\n");
		self.super_time = time + 5;
	}
	#endif

	Grunty_Check_Frags();

	if (self.goalentity != world)
	{
		self.walkframe = 0;
		self.think = grunty_run;
		//return;
	}

	GruntyThink();
	//sprint(self.real_owner, #PRINT_HIGH, "Done gruntythink in stand().\n");
};


// Again we have a choice of which animation to use
void() grunty_run =
{
//	local string st;

	if (self.health > 0) self.think = grunty_run;

	self.weaponframe = 0; //needed?

	if (isMelee())
	{
		if (self.walkframe >= 6)
			self.walkframe = 0;
		self.frame = $axrun1 + floor(self.walkframe);
	}
	else
	{
		if (self.walkframe >= 6)
			self.walkframe = 0;
		self.frame = $rockrun1 + floor(self.walkframe);
	}

	self.walkframe = self.walkframe + 0.5;

	#ifdef VERBOSE_GRUNTY
	if (self.super_time <= time)
	{
		sprint(self.real_owner, #PRINT_HIGH, "Hello, commander! I am currently running at speed ");
		st = ftos(self.custom_speed);
		sprint(self.real_owner, #PRINT_HIGH, st);
		sprint(self.real_owner, #PRINT_HIGH, " towards ");
		sprint(self.real_owner, #PRINT_HIGH, self.goalentity.netname);
		sprint(self.real_owner, #PRINT_HIGH, "\n");
		self.super_time = time + 5;
	}
	#endif

	if (self.goalentity == world)
	{
		self.walkframe = 0;
		self.think = grunty_stand;
		//return;
	}

	GruntyThink();

	#ifdef VERBOSE_GRUNTY
	sprint(self.real_owner, #PRINT_HIGH, "I have just finished GruntyThink (self.enemy = ");
	sprint(self.real_owner, #PRINT_HIGH, self.enemy);
	sprint(self.real_owner, #PRINT_HIGH, ")\n");
	#endif

	GRun();

	#ifdef VERBOSE_GRUNTY
	sprint(self.real_owner, #PRINT_HIGH, "I have just finished GRun (self.enemy = ");
	sprint(self.real_owner, #PRINT_HIGH, self.enemy);
	sprint(self.real_owner, #PRINT_HIGH, ")\n");
	#endif

	Grunty_Check_Frags();
};

void() stand_frames = //- ofn - used when soldier is following us, and when hes stuck and set to not jump
{
	self.weaponframe=0;

	if (isMelee())
	{
		if (self.walkframe >= 12)
			self.walkframe = 0;
		self.frame = $axstnd1 + floor(self.walkframe);
	}
	else
	{
		if (self.walkframe >= 5)
			self.walkframe = 0;
		self.frame = $stand1 + floor(self.walkframe);
	}
	self.walkframe = self.walkframe + 0.1;
};


// Grunty's first axe attack
void() grunty_axeatta =
{
	self.frame = $axatt1 + floor(self.weaponframe);

	if (self.weaponframe == 1)
		if (self.current_weapon == #WEAP_AXE)
			W_FireAxe();
		else
			W_FireSpanner();

	self.weaponframe = self.weaponframe + 0.5;
	GruntyThink();
	GRun();
	//self.nextthink = time + 0.05;
	if (self.weaponframe > 3)
		if (self.health > 0) self.think = grunty_run;
};

// Grunty's second axe attack
void() grunty_axeattb =
{
	self.frame = $axattb1 + floor(self.weaponframe);

	if (self.weaponframe == 2)
		if (self.current_weapon == #WEAP_AXE)
			W_FireAxe();
		else
			W_FireSpanner();

	self.weaponframe = self.weaponframe + 0.5;
	GruntyThink();
	GRun();
	//self.nextthink = time + 0.05;
	if (self.weaponframe > 3)
		if (self.health > 0) self.think = grunty_run;
};

// Grunty's third axe attack
void() grunty_axeattc =
{
	self.frame = $axattc1 + floor(self.weaponframe);

	if (self.weaponframe == 2)
		if (self.current_weapon == #WEAP_AXE)
			W_FireAxe();
		else
			W_FireSpanner();

	self.weaponframe = self.weaponframe + 0.5;
	GruntyThink();
	GRun();
	//self.nextthink = time + 0.05;
	if (self.weaponframe > 3)
		if (self.health > 0) self.think = grunty_run;
};

// Grunty's fourth axe attack
void() grunty_axeattd =
{
	self.frame = $axattd1 + floor(self.weaponframe);

	if (self.weaponframe == 2)
		if (self.current_weapon == #WEAP_AXE)
			W_FireAxe();
		else
			W_FireSpanner();

	self.weaponframe = self.weaponframe + 0.5;
	GruntyThink();
	GRun();
	//self.nextthink = time + 0.05;
	if (self.weaponframe > 3)
		if (self.health > 0) self.think = grunty_run;
};

// Axe attack chooser
void() grunty_axeatt =
{
	MonsterAuraPower();

	local float r;

	self.walkframe = 0; // Reset walkframe to avoid freaky animations?

	r = random();

	if (r < 0.25)
		grunty_axeatta();
	else if (r < 0.5)
		grunty_axeattb();
	else if (r < 0.75)
		grunty_axeattc();
	else
		grunty_axeattd();
};


// Grunty uses the shotgun
// The firing is done after he chooses the attack
void() grunty_shotgun =
{
	MonsterAuraPower();

	self.frame = $shotatt1 + floor(self.weaponframe);

	if (self.weaponframe == 0)
		self.effects = self.effects | #EF_DIMLIGHT;
	else if (self.weaponframe == 0.5)
		self.effects = self.effects - (self.effects & #EF_DIMLIGHT);

	self.weaponframe = self.weaponframe + 0.5;
	GruntyThink();
	GRun();
	//self.nextthink = time + 0.05;
	if (self.weaponframe > 5)
	{
		self.walkframe = 0;
		if (self.ammo_shells < 1)
			PrintFromSoldier(self,self.real_owner,"I've run out of shells!\n",#PRINT_LOW);
		if (self.health > 0) self.think = grunty_run;
	}
};

// Grunty fires his rocket launcher! muahahahahaha
// The firing is done after he chooses the attack
void() grunty_rocket =
{
	MonsterAuraPower();

	self.frame = $rockatt1 + floor(self.weaponframe);

	if (self.weaponframe == 0)
		self.effects = self.effects | #EF_DIMLIGHT;
	else if (self.weaponframe == 0.5)
		self.effects = self.effects - (self.effects & #EF_DIMLIGHT);

	self.weaponframe = self.weaponframe + 0.5;
	GruntyThink();
	GRun();
	//self.nextthink = time + 0.05;
	if (self.weaponframe > 5)
	{
		self.walkframe = 0;
		if (self.ammo_rockets < 1)
			PrintFromSoldier(self,self.real_owner,"I've run out of rockets!\n",#PRINT_LOW);
		if (self.health > 0) self.think = grunty_run;
	}
};

//- ofn - this to compensate no prediction
//- GRUNTY'S NAILS GO FASTER AS HIS RANK IS INCREASED (up to 2200)-//
void(vector org, vector dir) grunty_spike =
{
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = #MOVETYPE_FLYMISSILE;
	newmis.solid = #SOLID_BBOX;

	newmis.angles = vectoangles(dir);

	newmis.touch = spike_touch;
	newmis.weapon = #DMSG_NAILGUN;
	newmis.classname = "spike";
	newmis.think = SUB_Remove;
	newmis.nextthink = time + 6;
	setmodel (newmis, "progs/spike.mdl");
	setsize (newmis, #VEC_ORIGIN, #VEC_ORIGIN);
	setorigin (newmis, org);

	newmis.velocity = dir*(1100+1100*(self.has_sensor/17));
};

// Grunty uses the nailgun
void() grunty_nail1 = [$nailatt1, grunty_nail2]
{
	MonsterAuraPower();

	GruntyThink(); GRun(); self.effects = self.effects | #EF_DIMLIGHT;
	if (self.ammo_nails > 0)
	{
		W_FireSpikes(4);
		if (self.ammo_nails < 1) PrintFromSoldier(self,self.real_owner,"I've run out of nails!\n",#PRINT_LOW);
	}
};
void() grunty_nail2 = [$nailatt1, grunty_nail3]
{
	GruntyThink(); GRun(); self.effects = self.effects | #EF_DIMLIGHT;
};
void() grunty_nail3 = [$nailatt2, grunty_nail4]
{
	GruntyThink(); GRun(); self.effects = self.effects - (self.effects & #EF_DIMLIGHT);
	if (self.ammo_nails > 0)
	{
		W_FireSpikes(-4);
		if (self.ammo_nails < 1) PrintFromSoldier(self,self.real_owner,"I've run out of nails!\n",#PRINT_LOW);
	}
};
void() grunty_nail4 = [$nailatt2, grunty_nail1]
{
	GruntyThink(); GRun(); self.effects = self.effects - (self.effects & #EF_DIMLIGHT);

	local float vis, dist;

	vis = visible(self.enemy);
	dist = vlen(self.origin - self.enemy.origin);

	if (!vis || self.ammo_nails < 1 || self.enemy.health <= 0 || dist < 200 || random() < 0.025)
	{
		self.walkframe = 0;
		grunty_run();
		return;
	}
};

vector () Grunty_LeadShot =
{
	local vector pvel, dir, loc;//, lead;
	local vector src, targ;

	src = self.origin + '0 0 16';
	targ = self.enemy.origin;


	pvel = '0 0 0'; // ofn - no prediction

	/*if (self.enemy.classname == "player")
		pvel='0 0 0';//pvel = self.enemy.velocity;
	else if (self.enemy.classname == "monster_army")
	{
		makevectors(self.enemy.angles);
		pvel = self.enemy.velocity + v_forward * self.enemy.custom_speed * 20;// * 10; //- ? was 20
	}
	else
		pvel = '0 0 0';*/

	//if (!self.enemy.flags & #FL_ONGROUND)
	//	pvel_z = pvel_z / 20;

	//lead = pvel * (vlen(src - targ) / ReturnWeaponVelocity());
	loc = targ;// + lead;

	// do the following do anything?-----//
	//lead = pvel * (vlen(src - loc) / ReturnWeaponVelocity());
	//lead_x = lead_x + (10 - random() * 20);
	//lead_y = lead_y + (10 - random() * 20);
	//------------------------------------//    self.view_ofs

	dir = normalize (loc - src);

	traceline(src, targ, #TL_BSP_ONLY, self);
	if (trace_fraction != 1.0)
	{
		loc_z = loc_z + self.enemy.maxs_z; // already commented
		//if (self.current_weapon == #WEAP_ROCKET_LAUNCHER)
		//	loc_z = loc_z + self.enemy.mins_z * -1;
	}
	else
	{
		if (self.current_weapon == #WEAP_ROCKET_LAUNCHER && random() > 0.3)
			loc_z = loc_z - self.enemy.maxs_z/2;
			//- OFN - makes grunty aim to the ground with RL sometimes, so evil!
	}

	dir = normalize (loc - src);

	return dir;
};


void() GruntyThink =
{
	AI_Check_Contents(self);

	if (self.health <= 0)
		return;

	self.nextthink = time + 0.05; //was 0.05

	// check for Follow Me Grunty's owner death
	if (self.goalentity == self.real_owner)
		if (self.goalentity.health <= 0)
			self.goalentity = world;


	// Check to buy
	if (self.suicide_time <= time)
		GruntyPayThink();
	// scan for targets

	GruntyScanTargets();

};

// LookAround for grunty
entity (entity scanner) LookAroundGrunty =
{
	//if (infokey(world,"ceasefire")=="on") //OfN
	if (ceasefire)
		return scanner;

	local entity client;
	//local entity list_client;
	//local entity list;
	local float gotatarget;

	client = findradius(scanner.origin, 2500);

	while (client)
	{
		gotatarget = 0;

		if (client != scanner && visible2(client, scanner))
		{

			#ifdef MAD_MONSTERS

			if (client.classname == "player" && IsMonsterNonArmy(scanner)) gotatarget = 1;

			#else

			if (client.classname == "player" && !Teammate(client.team_no, scanner.real_owner.team_no))
			{
				gotatarget = Pharse_Client(client, scanner, 1, 0, 0, 0);

				if (client.is_undercover)
					if (client.cutf_items & #CUTF_JAMMER || !scanner.tf_items & #NIT_SCANNER)
						gotatarget=0;
				if (client.modelindex == modelindex_null)
					if (client.cutf_items & #CUTF_JAMMER || !scanner.tf_items & #NIT_SCANNER)
						gotatarget=0;
				if (client.modelindex == modelindex_eyes)
					if (client.cutf_items & #CUTF_JAMMER || !scanner.tf_items & #NIT_SCANNER)
						if (random() < 2 - scanner.has_tesla * random())
							gotatarget=0;
			}

			#endif

			else if (IsMonster(client))
			{
				if (!Teammate(client.real_owner.team_no,scanner.real_owner.team_no))
					gotatarget = 1;
			}
			else if (client.classname == "grenade" && client.netname == "land_mine")
			{
				if (!Teammate(client.owner.team_no,scanner.real_owner.team_no))
					gotatarget = 1;
			}
			else if (!Teammate(client.team_no, scanner.real_owner.team_no))
			{ //  && client.classname != "building_sentrygun_base"
				if (IsOffenseBuilding(client)) // for teslas isoffensiveb only returns true if not cloaked
					gotatarget = 1;
			}

		}
		if (gotatarget)
			return client;

		client = client.chain;
	}
	return scanner;
};


entity () GruntyPharse =
{
	local entity retarg;
	local float r;
	r = random();

	#ifdef MAD_GRUNTY

	if (r < 0.30 && (visible(self.real_owner)) && self.real_owner.health > 0)
		retarg = self.real_owner;

	#else

	//- ofn - lot of shit changed in lookaround to make them target well
	if (r < 0.30)
		retarg = LookAroundGrunty(self);

	#endif

	return retarg;
};

void() GruntyScanTargets =
{
	local entity targ; // our hapless foe
	local string st;

	if (self.enemy != world)
		if (self.enemy.health <= 0 || !self.enemy.is_connected)
		{

			self.enemy = world;
			self.goalentity = ReturnEasyWaypoint(self,self);

			// self.enemy = world;
			// self.goalentity = world;
			if (self.demon_one != world)
			{
				RemoveWaypoint(self.demon_one,self);
				self.demon_one = world;
			}

			self.has_teleporter = 0;
			self.effects = self.effects - (self.effects & #EF_DIMLIGHT);
			return;
		}
	// If we have a target already
	if (self.enemy != world)
	{
		local float vis;
		vis = visible(self.enemy);
		if (vis)
		{
			if (self.demon_one != world)
			{
				RemoveWaypoint(self.demon_one,self);
				self.demon_one=world;

			} //often =world
			self.search_time = time + 3;
			if (self.attack_finished <= time)
				GruntyCheckFire();
		}
		else
		{
			if (self.is_malfunctioning==0 || self.is_malfunctioning==2)
			{
				self.enemy = world;
				self.goalentity = ReturnEasyWaypoint(self,self);

				self.has_teleporter = 0;
				self.effects = self.effects - (self.effects & #EF_DIMLIGHT);

				return;
			}
			// tactic

			if (self.demon_one == world) // if we don't have a enemy last seen marker
			{
				if (self.demon_one!=world)
				{
					RemoveWaypoint(self.demon_one,self);
				}

				self.demon_one = CreateWaypoint(self.enemy.origin - self.enemy.velocity * 0.05, #WAYPOINT_AI_LIFE, #WAYPOINT_TYPE_ENEMYLASTSEEN, self);
				self.demon_one.goalentity = ReturnEasyWaypoint(self,self.demon_one);
				self.goalentity = self.demon_one;
				self.search_time = time + #GRUNTY_SEEKTIME; // was 8
				//- OfN -
				self.has_teleporter = 0;
			}
			if (self.search_time <= time) // we seeked enemy for GRUNTY_SEEKTIME already so...
			{
				self.enemy = world;
				self.goalentity = world;

				if (self.demon_one != world) // d1 remove contingency check
				{
					RemoveWaypoint(self.demon_one,self);
					self.demon_one = world;
					self.goalentity = ReturnEasyWaypoint(self,self);
				}
			}

		}
	}
	else // otherwise look for a target
	{
		targ=GruntyPharse();

		if (targ == self)
			return;
		if (targ == world)
			return;

		if (!self.is_detpacking || ceasefire)//infokey(world,"ceasefire")=="on")
		{
			if (!IsBuilding(targ) && self.super_time < time && targ.netname != "land_mine")
			{
				st = strcat("I can see ",targ.netname);
				st = strcat(st," around there...\n");

				PrintFromSoldier(self,self.real_owner,st,#PRINT_HIGH);
				//sprint(self.real_owner, #PRINT_HIGH, targ.netname);
				//sprint(self.real_owner, #PRINT_HIGH, " around there...\n");
				self.super_time = time + 4;
			}
			return;
		}

		if (self.super_time < time)
		{
			//local string targetstr;
			//targetstr=GetEnemyName(targ);//targ.netname;

			st = strcat("Target ",targ.netname);
			st = strcat(st, " spotted!\n Engaging target...\n");
			PrintFromSoldier(self,self.real_owner,st,#PRINT_HIGH);

			//sprint(self.real_owner, #PRINT_HIGH, targ.netname);
			//sprint(self.real_owner, #PRINT_HIGH, " spotted!\n Engaging target...\n");
			self.super_time = time + 2.5;
		}

		self.enemy = targ;
		self.goalentity = self.enemy;
		self.search_time = time + 3;
	}
};

void() GruntyCheckFire =
{
	local float dist, vis;

	if (self.attack_finished > time)
		return;

	if (self.enemy == world)
		return;

	//if (infokey(world,"ceasefire")=="on")
	if (ceasefire)
	{
		self.goalentity=ReturnEasyWaypoint(self,self);
		self.enemy=world;
		return;
	}

	vis = visible(self.enemy);
	if (!vis)
	{
		#ifdef VERBOSE_GRUNTY
		//if (self.super_time <= time)
		//{
			sprint(self.real_owner, #PRINT_HIGH, "Target not visible! Cancelling firing...\n");
			self.super_time = time + 5;
		//}
		#endif

		//self.weaponframe = 0;
		//self.think = grunty_run;
		//self.nextthink = time + 0.05;
		return;
	}

	//-- OFN --// no need as yaw is set in GRun
	//enemy_yaw = vectoyaw(self.enemy.origin - self.origin);
	//self.ideal_yaw = enemy_yaw;
	//ChangeYaw();
	//---------//

	/*if (!FacingIdeal())
		return; */

	dist = vlen(self.origin - self.enemy.origin);
	self.weaponframe = 0;


	if (dist < 64 && self.weapons_carried & #WEAP_AXE && self.cutf_items & #CUTF_KNIFE)
	{
		self.current_weapon = #WEAP_AXE;
		/*if (self.cutf_items & #CUTF_KNIFE)
			self.attack_finished = time + 0.5;
		else
			self.attack_finished = time + 0.5;*/
		Attack_Finished(0.5);
		if (self.health > 0) self.think = grunty_axeatt;
		#ifdef VERBOSE_GRUNTY
		sprint(self.real_owner, #PRINT_HIGH, "Attempting to knife...\n");
		#endif
		return;
	}
	if (dist < 200 && self.weapons_carried & #WEAP_SUPER_SHOTGUN)
	{
		if (self.ammo_shells > 1)
		{
			self.current_weapon = #WEAP_SUPER_SHOTGUN;
			//self.attack_finished = time + 0.7;
			Attack_Finished(0.7);
			W_FireSuperShotgun();
			if (self.health > 0) self.think = grunty_shotgun;
			#ifdef VERBOSE_GRUNTY
			sprint(self.real_owner, #PRINT_HIGH, "Attempting to super shotgun...\n");
			#endif
			return;
		}
	}
	if (dist < 64 && self.weapons_carried & #WEAP_AXE)
	{
		self.current_weapon = #WEAP_AXE;
		/*if (self.cutf_items & #CUTF_KNIFE)
			self.attack_finished = time + 0.5;
		else
			self.attack_finished = time + 0.5;*/
		Attack_Finished(0.5);
		if (self.health > 0) self.think = grunty_axeatt;
		#ifdef VERBOSE_GRUNTY
		sprint(self.real_owner, #PRINT_HIGH, "Attempting to axe...\n");
		#endif
		return;
	}                       //was 800
	if (dist > 200 && dist < 1100 && self.weapons_carried & #WEAP_ROCKET_LAUNCHER)
	{
		if (self.ammo_rockets > 1)
		{
			self.current_weapon = #WEAP_ROCKET_LAUNCHER;
			//self.attack_finished = time + 0.8;
			Attack_Finished(0.8);
			W_FireRocket();
			if (self.health > 0) self.think = grunty_rocket;
			#ifdef VERBOSE_GRUNTY
			sprint(self.real_owner, #PRINT_HIGH, "Attempting to rocket...\n");
			#endif
			return;
		}
	}
	if (dist < 1400 && self.weapons_carried & #WEAP_ROCKET_LAUNCHER && random() > 0.75)
	{
		if (self.ammo_rockets > 1)
		{
			self.current_weapon = #WEAP_ROCKET_LAUNCHER;
			//self.attack_finished = time + 0.8;
			Attack_Finished(0.8);
			W_FireRocket();
			if (self.health > 0) self.think = grunty_rocket;
			return;
		}
	}
	if (dist < 2000 && self.weapons_carried & #WEAP_ROCKET_LAUNCHER && self.ammo_rockets > 1 && random() > 0.98)
	{
		self.current_weapon = #WEAP_ROCKET_LAUNCHER;
		//self.attack_finished = time + 0.8;
		Attack_Finished(0.8);
		W_FireRocket();
		if (self.health > 0) self.think = grunty_rocket;
		return;
	}

	//- OfN
	if (dist < 400 && self.weapons_carried & #WEAP_SHOTGUN && self.ammo_shells > 0)
	{
		//if (self.ammo_shells > 0)
		//{
			self.current_weapon = #WEAP_SHOTGUN;
			//self.attack_finished = time + 0.5; // TODO: MAKE ATTACK FINISHED
			Attack_Finished(0.5);
			W_FireShotgun();
			if (self.health > 0) self.think = grunty_shotgun;
			#ifdef VERBOSE_GRUNTY
			sprint(self.real_owner, #PRINT_HIGH, "Attempting to shotgun...\n");
			#endif
			//RPrint("SHOTGUN\n");
			return;
		//}
	}
	if (dist < 2000 && self.weapons_carried & #WEAP_NAILGUN && self.ammo_nails > 0)
	{
		//if (self.ammo_nails > 0)
		//{
			self.current_weapon = #WEAP_NAILGUN;
			//self.attack_finished = time + 0.2;//+ 0.1;
			Attack_Finished(0.2);
			if (self.health > 0) self.think = grunty_nail1;
			#ifdef VERBOSE_GRUNTY
			sprint(self.real_owner, #PRINT_HIGH, "Attempting to nail...\n");
			#endif
			//RPrint("NAIL\n");
			return;
		//}
	}
	else
	{
		// Do whatever you want
		self.effects = self.effects - (self.effects & #EF_DIMLIGHT);
		//self.walkframe = 0; ofn
		if (self.health > 0) self.think = grunty_run;
		#ifdef VERBOSE_GRUNTY
		sprint(self.real_owner, #PRINT_HIGH, "GruntyCheckFire defaulting to none...\n");
		#endif
		//RPrint("NONE\n");
	}
};

void() GRun =
{
	local float dist;
	local vector loc;

	// ok, we're trying to get somewhere
	// first look at where we are trying to go
	// Version 1.0 of GruntyLead(tm)
	if (self.enemy != world)
	{
		local vector pvel;

		if (self.enemy.classname == "player")
			pvel = self.enemy.velocity;
		else if (self.enemy.classname == "monster_army")
		{
			makevectors(self.enemy.angles);
			pvel = self.enemy.velocity + v_forward * self.enemy.custom_speed * 20;
		}
		else
			pvel = '0 0 0';
		if (ReturnWeaponVelocity() == 99999999)
			pvel = '0 0 0';
		loc = self.enemy.origin + pvel * (vlen(self.enemy.origin - self.origin) / ReturnWeaponVelocity());
		self.ideal_yaw = vectoyaw(loc - self.origin);
		self.ideal_yaw = anglemod(self.ideal_yaw);
	}
	else
	{
		if (self.goalentity!=world) //- OfN - dont change yaw if we r not after a goal
		{
			self.ideal_yaw = vectoyaw(self.goalentity.origin - self.origin);
			self.ideal_yaw = anglemod(self.ideal_yaw);
		}
	}

	ChangeYaw();

	// makevectors sets the global vars v_forward, v_right and v_up
	makevectors(self.angles);

	dist = self.custom_speed;

	if (self.tfstate & #TFSTATE_TRANQUILISED)
		dist = dist * (#AI_TRANQ_FACTOR_UP / #AI_TRANQ_FACTOR_DN); //Tranq

	/* - OfN -if (self.enemy.classname == "monster_shambler" || self.enemy.weapons_carried & #WEAP_ASSAULT_CANNON)
		if (self.has_teleporter == 0)
			self.has_teleporter = 3;*/

	if (random() < 0.02) // to prevent us from strafing or whatever forever.
		self.has_teleporter = 0;

	// Test to see if we want to do an evasive maneuver
	// If we're already doing a move, don't do another
	if (self.has_teleporter == -1) // left dodge move
		botmovedist(vectoyaw(v_right * -1), dist);// move left

	else if (self.has_teleporter == 1) // right dodge move
		botmovedist(vectoyaw(v_right), dist); // move right

	else if (self.has_teleporter == 2) // jump!
	{
		if (self.flags & #FL_ONGROUND) // only jump if we're on the ground
		{
			self.velocity_z = self.velocity_z + 270; // boing
			//sound (self, #CHAN_BODY, "player/plyrjmp8.wav", 1, #ATTN_NORM);
			sound (self, #CHAN_VOICE, "player/plyrjmp8.wav", 1, #ATTN_NORM);
		}
		self.has_teleporter = 0; // don't jump
	}
	else if (self.has_teleporter == 3) //(backwards)// HE'S AFTER US, RUN!@#$ HE WILL KILL US ALL!!@
		botmovedist(vectoyaw(v_forward), dist * -1); // flee, I tell you!

	else if (self.has_teleporter == 0) // no evasive, standard move (forward)
	{
		//- OfN - force move to forward if we r going to a last seen enemy waypoint
		if (self.goalentity == self.demon_one && self.demon_one!=world)
		{
			self.has_teleporter = 0;
			botmovedist(vectoyaw(v_forward), dist); // move
			return;
		}

		botmovedist(vectoyaw(v_forward), dist); // move
		if (random() * 20 < 1 && self.enemy != world)				// if we get a score
		{															// of one on a d20,
			local float r;											// special
			r = random();
			if (r < 0.25)
				self.has_teleporter = -1; // left
			else if (r < 0.5)
				self.has_teleporter = 1; // right
			else if (r < 0.75)
				self.has_teleporter = 2; // jump!
			else
				self.has_teleporter = 3; // italian style!
		}
	}
};

void (float angle, float dist) botmovedist =
{

	local float success;
	//local float suitable;

	//- OfN - Don't annoy owner if following him! heh
	#ifndef MAD_GRUNTY
	if (self.goalentity==self.real_owner) //if in "follow me!" state...
	{
		local float dist2;

		dist2 = vlen(self.origin - self.real_owner.origin);

		if (dist2<64)
		{
			stand_frames();
			self.has_cheated = time + 0.5;
			walkmove(angle, 0);
			return;
		}
	}
	#endif

	/*if (pointcontents(self.origin) == #CONTENT_EMPTY) // We're in open air
	{*/

		success = walkmove(angle, dist);

		if (success) // We walked sucessfully, woohoo
		{
			self.has_cheated = time + 0.5;
			return;
		}
		else // We just ran into something...
		{
			if (self.is_toffingadet==1) //if we are on stop on obstacles mode
			{
				self.has_cheated = time + 0.5;
				if (self.attack_finished < time) stand_frames();
				return;
			}

			if (self.has_cheated > time)
				return;
			self.has_teleporter = 0; // abort dodging
			makevectors(self.angles);
			// First, we'll see if jumping would be suitable
			if (self.flags & #FL_ONGROUND) // don't bother if we aren't on the ground
			{
				traceline(self.origin + '0 0 20', self.origin + '0 0 20' + v_forward * 10, #TL_ANY_SOLID, self);
				if (trace_fraction == 1.0)
				{
					self.velocity = self.velocity + v_forward * self.custom_speed * 20;
					self.velocity_z = self.velocity_z + 270;
					//sound (self, #CHAN_BODY, "player/plyrjmp8.wav", 1, #ATTN_NORM);
					sound (self, #CHAN_VOICE, "player/plyrjmp8.wav", 1, #ATTN_NORM);
					self.has_cheated = time + 0.5;
					return;
				}
			}
		}
	/*}
	else
	{
		self.velocity = normalize(self.goalentity.origin - self.origin) * self.custom_speed * 20;
		if (self.teleport_time < time)
			CheckWaterJump();
	}*/

};

void () Grunty_StateInv =
{
	local string talk;

	talk = ftos(self.health);
	sprint(self.real_owner, #PRINT_HIGH, "Your \ssoldier\s has ");
	sprint(self.real_owner, #PRINT_HIGH, talk);
	talk = ftos(self.max_health);
	sprint(self.real_owner, #PRINT_HIGH, "\{175}");
	sprint(self.real_owner, #PRINT_HIGH, talk);
	sprint(self.real_owner, #PRINT_HIGH, " \shealth\s");
	if (self.weapons_carried & #WEAP_AXE)
		if (self.cutf_items & #CUTF_KNIFE)
			sprint(self.real_owner, #PRINT_HIGH, ", a combat knife");
		else
			sprint(self.real_owner, #PRINT_HIGH, ", an axe");
	if (self.weapons_carried & #WEAP_SHOTGUN)
		sprint(self.real_owner, #PRINT_HIGH, ", a shotgun");
	if (self.weapons_carried & #WEAP_NAILGUN)
		sprint(self.real_owner, #PRINT_HIGH, ", a nailgun");
	if (self.weapons_carried & #WEAP_SUPER_SHOTGUN)
		sprint(self.real_owner, #PRINT_HIGH, ", a double barreled shotgun");
	if (self.weapons_carried & #WEAP_ROCKET_LAUNCHER)
		sprint(self.real_owner, #PRINT_HIGH, ", a rocket launcher");
	if (self.tf_items & #NIT_SCANNER)
		sprint(self.real_owner, #PRINT_HIGH, ", a scanner");
	talk = ftos(self.custom_speed * 20);
	sprint(self.real_owner, #PRINT_HIGH, ", moves at speed ");
	sprint(self.real_owner, #PRINT_HIGH, talk);
	talk = ftos(self.money);
	sprint(self.real_owner, #PRINT_HIGH, " with $");
	sprint(self.real_owner, #PRINT_HIGH, talk);
	sprint(self.real_owner, #PRINT_HIGH, "\n");

	sprint(self.real_owner, #PRINT_HIGH, "\sammo\s: ");

	talk = ftos(self.ammo_shells);
	sprint(self.real_owner, #PRINT_HIGH, talk);
	sprint(self.real_owner, #PRINT_HIGH, " shells, ");

		talk = ftos(self.ammo_nails);
	sprint(self.real_owner, #PRINT_HIGH, talk);
	sprint(self.real_owner, #PRINT_HIGH, " nails and ");

	/*    talk = ftos(self.ammo_cells);
	sprint(self.real_owner, #PRINT_HIGH, talk);
	sprint(self.real_owner, #PRINT_HIGH, " cells\n");*/

	talk = ftos(self.ammo_rockets);
	sprint(self.real_owner, #PRINT_HIGH, talk);
	sprint(self.real_owner, #PRINT_HIGH, " rockets\n");
};


void () gruntyDead =
{
	//self.think = SUB_Remove;
	//self.nextthink = time + 40 + 40*random();
	MonsterCorpse();
};


void()	grunty_diea1	=	[	$deatha1,	grunty_diea2	] {};
void()	grunty_diea2	=	[	$deatha2,	grunty_diea3	] {};
void()	grunty_diea3	=	[	$deatha3,	grunty_diea4	] {};
void()	grunty_diea4	=	[	$deatha4,	grunty_diea5	] {};
void()	grunty_diea5	=	[	$deatha5,	grunty_diea6	] {};
void()	grunty_diea6	=	[	$deatha6,	grunty_diea7	] {};
void()	grunty_diea7	=	[	$deatha7,	grunty_diea8	] {};
void()	grunty_diea8	=	[	$deatha8,	grunty_diea9	] {};
void()	grunty_diea9	=	[	$deatha9,	grunty_diea10	] {};
void()	grunty_diea10	=	[	$deatha10,	grunty_diea11	] {};
void()	grunty_diea11	=	[	$deatha11,	grunty_diea11 ] {gruntyDead();};

void()	grunty_dieb1	=	[	$deathb1,	grunty_dieb2	] {};
void()	grunty_dieb2	=	[	$deathb2,	grunty_dieb3	] {};
void()	grunty_dieb3	=	[	$deathb3,	grunty_dieb4	] {};
void()	grunty_dieb4	=	[	$deathb4,	grunty_dieb5	] {};
void()	grunty_dieb5	=	[	$deathb5,	grunty_dieb6	] {};
void()	grunty_dieb6	=	[	$deathb6,	grunty_dieb7	] {};
void()	grunty_dieb7	=	[	$deathb7,	grunty_dieb8	] {};
void()	grunty_dieb8	=	[	$deathb8,	grunty_dieb9	] {};
void()	grunty_dieb9	=	[	$deathb9,	grunty_dieb9	] {gruntyDead();};

void()	grunty_diec1	=	[	$deathc1,	grunty_diec2	] {};
void()	grunty_diec2	=	[	$deathc2,	grunty_diec3	] {};
void()	grunty_diec3	=	[	$deathc3,	grunty_diec4	] {};
void()	grunty_diec4	=	[	$deathc4,	grunty_diec5	] {};
void()	grunty_diec5	=	[	$deathc5,	grunty_diec6	] {};
void()	grunty_diec6	=	[	$deathc6,	grunty_diec7	] {};
void()	grunty_diec7	=	[	$deathc7,	grunty_diec8	] {};
void()	grunty_diec8	=	[	$deathc8,	grunty_diec9	] {};
void()	grunty_diec9	=	[	$deathc9,	grunty_diec10	] {};
void()	grunty_diec10	=	[	$deathc10,	grunty_diec11	] {};
void()	grunty_diec11	=	[	$deathc11,	grunty_diec12	] {};
void()	grunty_diec12	=	[	$deathc12,	grunty_diec13	] {};
void()	grunty_diec13	=	[	$deathc13,	grunty_diec14	] {};
void()	grunty_diec14	=	[	$deathc14,	grunty_diec15	] {};
void()	grunty_diec15	=	[	$deathc15,	grunty_diec15 ] {gruntyDead();};

void()	grunty_died1	=	[	$deathd1,	grunty_died2	] {};
void()	grunty_died2	=	[	$deathd2,	grunty_died3	] {};
void()	grunty_died3	=	[	$deathd3,	grunty_died4	] {};
void()	grunty_died4	=	[	$deathd4,	grunty_died5	] {};
void()	grunty_died5	=	[	$deathd5,	grunty_died6	] {};
void()	grunty_died6	=	[	$deathd6,	grunty_died7	] {};
void()	grunty_died7	=	[	$deathd7,	grunty_died8	] {};
void()	grunty_died8	=	[	$deathd8,	grunty_died9	] {};
void()	grunty_died9	=	[	$deathd9,	grunty_died9	] {gruntyDead();};

void()	grunty_diee1	=	[	$deathe1,	grunty_diee2	] {};
void()	grunty_diee2	=	[	$deathe2,	grunty_diee3	] {};
void()	grunty_diee3	=	[	$deathe3,	grunty_diee4	] {};
void()	grunty_diee4	=	[	$deathe4,	grunty_diee5	] {};
void()	grunty_diee5	=	[	$deathe5,	grunty_diee6	] {};
void()	grunty_diee6	=	[	$deathe6,	grunty_diee7	] {};
void()	grunty_diee7	=	[	$deathe7,	grunty_diee8	] {};
void()	grunty_diee8	=	[	$deathe8,	grunty_diee9	] {};
void()	grunty_diee9	=	[	$deathe9,	grunty_diee9	] {gruntyDead();};

void()	grunty_die_ax1	=	[	$axdeth1,	grunty_die_ax2	] {};
void()	grunty_die_ax2	=	[	$axdeth2,	grunty_die_ax3	] {};
void()	grunty_die_ax3	=	[	$axdeth3,	grunty_die_ax4	] {};
void()	grunty_die_ax4	=	[	$axdeth4,	grunty_die_ax5	] {};
void()	grunty_die_ax5	=	[	$axdeth5,	grunty_die_ax6	] {};
void()	grunty_die_ax6	=	[	$axdeth6,	grunty_die_ax7	] {};
void()	grunty_die_ax7	=	[	$axdeth7,	grunty_die_ax8	] {};
void()	grunty_die_ax8	=	[	$axdeth8,	grunty_die_ax9	] {};
void()	grunty_die_ax9	=	[	$axdeth9,	grunty_die_ax9	] {gruntyDead();};

// For now we'll just have this
// Later we'll have hard and soft deaths
void() ArmyDeathSound;

void() custom_grunt_die =
{
	self.effects=0;

	if (self.real_owner.classname == "player")
	{
		sprint(self.real_owner,#PRINT_HIGH,"Your soldier ");
		sprint(self.real_owner,#PRINT_HIGH,self.netname);
		sprint(self.real_owner,#PRINT_HIGH," is dead.\n");
		self.real_owner.job_finished = time + 2; //Can't summon streams of demons SB can so
		ResetSlotPointer(self.real_owner, self.increase_team1);

		if (self.martyr_enemy != world)
		RemoveWaypoint(self.martyr_enemy, self);

		if (self.demon_one != world)
		RemoveWaypoint(self.demon_one, self);

		if (self.demon_two != world)
		RemoveWaypoint(self.demon_two, self);

		local entity oself;
		oself=self;
		self=self.real_owner;
		UpdateReserves(self);
		SetArmyTimer(self,#FALSE);
		self=oself;
	}

	if (self.health < -40)
	{
		if (random() < 0.5)
			sound (self, #CHAN_VOICE, "player/gib.wav", 1, #ATTN_MONSTERDIE);
		else
			sound (self, #CHAN_VOICE, "player/udeath.wav", 1, #ATTN_MONSTERDIE);

		ThrowMonsterHead ("progs/h_player.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health, #TRUE, 0, #GIB1_KGS, #FALSE);
		ThrowGib ("progs/gib2.mdl", self.health, #TRUE, 0, #GIB2_KGS, #FALSE);
		ThrowGib ("progs/gib3.mdl", self.health, #TRUE, 0, #GIB3_KGS, #FALSE);
		SpawnBloodEx(self.origin,0.66,9);
		//ThrowGib ("progs/gib3.mdl", self.health);
		dremove(self);
		return;
	}

	self.solid = #SOLID_NOT;

	ArmyDeathSound();
	//self.classname = "monster_corpse";
	MonsterDead();

	self.think=SUB_Null;
	self.touch=SUB_Null;

	if (isMelee())
	{
		grunty_die_ax1();
	}
	else
	{
		local float r;
		r=random();
		if (r<0.2)
			grunty_diea1();
		else if (r<0.4)
			grunty_dieb1();
		else if (r<0.6)
			grunty_diec1();
		else if (r<0.8)
			grunty_died1();
		else grunty_diee1();
	}
};

void() ArmyDeathSound =
{
	local float rs;

	// water death sounds
	if (self.waterlevel == 3)
	{
		DeathBubbles(7); // was 10
		sound (self, #CHAN_VOICE, "player/h2odeath.wav", 1, #ATTN_MONSTERDIE);
		return;
	}

	rs = rint ((random() * 4) + 1);
	if (rs == 1)
		self.noise = "player/death1.wav";
	if (rs == 2)
		self.noise = "player/death2.wav";
	if (rs == 3)
		self.noise = "player/death3.wav";
	if (rs == 4)
		self.noise = "player/death4.wav";
	if (rs == 5)
		self.noise = "player/death5.wav";

	sound (self, #CHAN_VOICE, self.noise, 1, #ATTN_MONSTERDIE);
};

// We'll include pain here

void() grunty_pain1 = [$pain1, grunty_pain2] {PainSound();self.weaponframe=0;self.effects=0;};
void() grunty_pain2 = [$pain2, grunty_pain3] {};
void() grunty_pain3 = [$pain3, grunty_pain4] {};
void() grunty_pain4 = [$pain4, grunty_pain5] {};
void() grunty_pain5 = [$pain5, grunty_pain6] {};
void() grunty_pain6 = [$pain6, grunty_run]
{
	self.walkframe = 0;
	self.pain_finished = time + random()*1.5*(self.has_sensor/17);
};

void() grunty_axepain1 =	[	$axpain1,	grunty_axepain2	] {PainSound();self.weaponframe=0;self.effects=0;};
void() grunty_axepain2 =	[	$axpain2,	grunty_axepain3	] {};
void() grunty_axepain3 =	[	$axpain3,	grunty_axepain4	] {};
void() grunty_axepain4 =	[	$axpain4,	grunty_axepain5	] {};
void() grunty_axepain5 =	[	$axpain5,	grunty_axepain6	] {};
void() grunty_axepain6 =	[	$axpain6,	grunty_run		]
{
	self.walkframe = 0;                                     // - 1)/16);
	self.pain_finished = time + random()*1.5*(self.has_sensor/17);
};

void(entity attacker, float damage) grunty_pain =
{
	//self.real_owner.StatusRefreshTime = time + 0.2;
	//self.real_owner.StatusBarScreen = 3;

#ifdef VERBOSE_GRUNTY
	//RPrint(self.real_owner, #PRINT_HIGH, "Grunty PAIN!\n");
#endif

	if (self.pain_finished > time)
		return;

	//if (random()*40 > damage) // random()*40+40*((self.has_sensor-1)/16)
	if (random()*50 + 60*((self.has_sensor - 1)/16) > damage)
		return;

	if (isMelee())
		grunty_axepain1();
	else
		grunty_pain1();
};


/*void() Grunty_PhysUpdate =
{
	setorigin(self, self.origin + self.velocity * 0.05);
};*/

void() Waypoint_Touch =
{
	// If the toucher isn't a grunt, return.
	if (other.classname != "monster_army")
		return;

	// If the toucher isn't trying to reach us, return.
	// We could do this with self.owner but it might accidentally touch a home waypoint
	// making this a bad option.
	if (other.goalentity != self)
		return;

	if (self.has_sensor == #WAYPOINT_TYPE_ENEMYLASTSEEN)
	{
		if (self.real_owner.demon_one == self)
			self.real_owner.demon_one = world;

		dremove(self);
		return;
	}

	if (self.has_sensor == #WAYPOINT_TYPE_PRIMARY)
		self.real_owner.job=2;
	else if (self.has_sensor == #WAYPOINT_TYPE_SECONDARY)
		self.real_owner.job=1;

	self.all_active = time + self.has_holo; // reset entity life time
	//has_holo is the asigned life time in createwaypoint


	other.goalentity = self.goalentity; // Set grunty's movement target
};

void() Waypoint_DoNothing = // A waypoint checks for redundancy
{
	self.nextthink = time + 5; // next check in 5 seconds

	//- OfN - remove waypoint entity?
	if (!self.owner.is_connected
		|| !(self.owner.job & #JOB_ARMY)
		|| !(HasMonster(self.owner))
		|| self.real_owner.classname != "monster_army"
		|| self.owner.classname != "player")
	{
		dremove(self); // no pointer set to world needed cause soldier shouldnt be present on game
		return;
	}

	if (self.all_active < time) // if it wasnt touched for specified life-time remove it
	{
		// FIXME: Do .goalentity clean up on other waypoints (using removewaypoint() instead?)

		if (self.has_sensor == #WAYPOINT_TYPE_PRIMARY
		&& self.real_owner.martyr_enemy == self)
		{
			self.real_owner.martyr_enemy = world;
			PrintFromSoldier(self.real_owner,self.owner,"Hmmm.. I've forgotten my primary waypoint sir!\n",#PRINT_HIGH);
		}
		else if (self.has_sensor == #WAYPOINT_TYPE_SECONDARY
		&& self.real_owner.demon_two == self)
		{
			self.real_owner.demon_two = world;
			PrintFromSoldier(self.real_owner,self.owner,"Hmmm.. I've forgotten my secondary waypoint sir!\n",#PRINT_HIGH);
		}
		else if (self.has_sensor == #WAYPOINT_TYPE_ENEMYLASTSEEN && self.real_owner.demon_one == self)
			self.real_owner.demon_one = world;

		dremove(self);
		return;
	}
};

/* CreateWaypoint
 *
 * Creates a waypoint for use by grunty
 * waypoint.goalentity = next target
 * waypoint.owner = owner grunt
 */

entity (vector location, float life, float type, entity sld) CreateWaypoint =
{
	newmis = spawn(); // Spawn a new entity (the waypoint)

	// set the origin.
	setsize (newmis, '-20 -20 -20', '20 20 20'); // set the size of the waypoint

	newmis.solid = #SOLID_TRIGGER; // We're a solid trigger type - touch, but don't block

	//newmis.netname = "grunty_waypoint"; // set the name so grunty can talk about us
	newmis.classname = "grunty_waypoint";
	newmis.touch = Waypoint_Touch; // Set the waypoint's touch function
	newmis.think = Waypoint_DoNothing; // Set the waypoint's redundancy check function
	newmis.nextthink = time + 2; // Think in 2 seconds

	if (self.classname == "player")
	{
		newmis.owner = self;
		newmis.real_owner = sld;
	}
	else if (self.classname == "monster_army")
	{
		newmis.owner = self.real_owner;
		newmis.real_owner = sld;
	}

	newmis.all_active = time + life; //#WAYPOINT_LIFE;
	newmis.has_holo = life;
	newmis.has_sensor = type; // sets the type of waypoint to has_sensor

	setorigin(newmis, location);

	return newmis; // return the entity
};


void (entity targ) GetRank =
{
	if (targ.has_sensor == 1)
		targ.undercover_name = "Private ";
	else if (targ.has_sensor == 2)
		targ.undercover_name = "Private First Class ";
	else if (targ.has_sensor == 3)
		targ.undercover_name = "Specialist ";
	else if (targ.has_sensor == 4)
		targ.undercover_name = "Corporal ";
	else if (targ.has_sensor == 5)
		targ.undercover_name = "Sergeant ";
	else if (targ.has_sensor == 6)
		targ.undercover_name = "Staff Sergeant ";
	else if (targ.has_sensor == 7)
		targ.undercover_name = "Sergeant First Class ";
	else if (targ.has_sensor == 8)
		targ.undercover_name = "Master Sergeant ";
	else if (targ.has_sensor == 9)
		targ.undercover_name = "2nd Lieutenant ";
	else if (targ.has_sensor == 10)
		targ.undercover_name = "1st Lieutenant ";
	else if (targ.has_sensor == 11)
		targ.undercover_name = "Captain ";
	else if (targ.has_sensor == 12)
		targ.undercover_name = "Major ";
	else if (targ.has_sensor == 13)
		targ.undercover_name = "Colonel ";
	else if (targ.has_sensor == 14)
		targ.undercover_name = "Brigadier General ";
	else if (targ.has_sensor == 15)
		targ.undercover_name = "Major General ";
	else if (targ.has_sensor == 16)
		targ.undercover_name = "Lieutenant General ";
	else if (targ.has_sensor == 17)
		targ.undercover_name = "General ";
	else
		targ.undercover_name = "Error producer ";
};

void() Grunty_Check_Frags =
{
	if (self.frags >= self.has_sentry && self.has_sensor < 17)
	{
		self.has_tesla = self.has_tesla + 0.1;
		self.has_sensor = self.has_sensor + 1;
		self.has_sentry = self.has_sentry + 2;
		//self.health = self.health + self.has_sensor * 25; //-this before
		self.health = self.health + 20 + self.has_sensor * 12; //-this now
		self.max_health = self.max_health + 20 + self.has_sensor * 16;//-was 25

		//ofn
		if (self.max_health > #GRUNT_MAX_HP)
			self.max_health = #GRUNT_MAX_HP;

		if (self.health > self.max_health)
			self.health = self.max_health;

		GetRank(self);

		sprint(self.real_owner, #PRINT_HIGH, "Your soldier, ");
		sprint(self.real_owner, #PRINT_HIGH, self.netname);
		sprint(self.real_owner, #PRINT_HIGH, ", has reached the rank of ");
		sprint(self.real_owner, #PRINT_HIGH, self.undercover_name);
		sprint(self.real_owner, #PRINT_HIGH, "\n");

		if (extras_mode == 2)
			return;

		if (self.has_sensor == 17)
		{
			local float extras;
			extras = GetJobExtras(self.real_owner);

			if (extras < 2)
				sprint(self.real_owner, #PRINT_HIGH, "The generals are impressed by your tactical skills..\n");
			else
				return;

			if (!extras)
			{
				sprint(self.real_owner, #PRINT_HIGH,"You are rewarded with an extra soldier reserve!\n");
				SetJobExtras(self.real_owner,1);
				UpdateReserves(self.real_owner);
			}
			else if (extras == 1)
			{
				sprint(self.real_owner, #PRINT_HIGH,"You now have access to 3 soldier reserves!\n");
				SetJobExtras(self.real_owner,2);
				UpdateReserves(self.real_owner);
			}
		}
	}
};

float () ReturnWeaponVelocity =
{
	if (self.current_weapon == #WEAP_NAILGUN)
		//return 1250;
		return 99999999;
	else if (self.current_weapon == #WEAP_ROCKET_LAUNCHER)
		//return 1100;
		return 99999999;
	else
		return 99999999;
};

#define GRUNTY_COST_HEALTHPACK		35 // was 20
#define GRUNTY_COST_SHOTGUN			100 // was 50
#define GRUNTY_COST_NAILGUN			300 // was 300
#define GRUNTY_COST_SUPER_SHOTGUN	500 // was 500
#define GRUNTY_COST_KNIFE			500 // was 700 // then 400
#define GRUNTY_COST_ROCKET_LAUNCHER 3000 // was 3000 // then 2000
#define GRUNTY_COST_SCANNER			1200 // was 1000 // then 800
#define GRUNTY_COST_SHELL			4 // was 2
#define GRUNTY_COST_NAIL			2 // was 1
#define GRUNTY_COST_ROCKET			12 // was 3
//#define GRUNTY_COST_CELL			2
#define GRUNTY_COST_MAXHEALTH		120 // was 100
#define GRUNTY_COST_SPEED			800 // was 400 // then 400
#define GRUNTY_MAX_SPEED			13 //- was 30

void () GruntyPayThink =
{
	local float chance;
	local float r;
	local float spendalloc;
	// If it's salary time, draw pay
	if (self.respawn_time < time)
	{
		GruntyDrawPay();
		self.respawn_time = time + 20;
	}
	// Grunty is on a SHOPPING SPREE!
	if (!self.weapons_carried & #WEAP_ROCKET_LAUNCHER)
		spendalloc = self.money * 0.2; // amount to spend on health/speed upgrades
	else
		spendalloc = self.money;
	// Consider buying more max health      )//- added
	if (spendalloc >= #GRUNTY_COST_MAXHEALTH && self.max_health < #GRUNT_MAX_HP)
	{
		if (self.weapons_carried & #WEAP_ROCKET_LAUNCHER)
			chance = 0.75; //- was 0.9
		else
			chance = 0.25;

		r = random();
		if (r < chance)
		{
			self.max_health = self.max_health + 25;
			self.money = self.money - #GRUNTY_COST_MAXHEALTH;
			spendalloc = spendalloc - #GRUNTY_COST_MAXHEALTH;
			//#ifdef VERBOSE_GRUNTY
			PrintFromSoldier(self,self.real_owner,"my health maximum has been increased!\n",#PRINT_MEDIUM);
			//sprint(self.real_owner, #PRINT_HIGH, "BUYS more MAX HP\n");
			//#endif
		}
	}
	// Consider buying a health pack
	if (self.health < self.max_health && self.money >= #GRUNTY_COST_HEALTHPACK)
	{
		local float loops, bought;
		bought=0;

		while (loops < (0.75+(self.has_sensor/4)) && self.money >= #GRUNTY_COST_HEALTHPACK && self.max_health > self.health)
		{
			if (self.health < self.max_health - 25)
				chance = 1;
			else if (self.health < self.max_health - 15)
				chance = 0.25;
			else
				chance = 0.1;

			r = random();
			if (r < chance)
			{
				self.health = self.health + 25;
				if (self.health > self.max_health)
					self.health = self.max_health;
				self.money = self.money - #GRUNTY_COST_HEALTHPACK;

				//#ifdef VERBOSE_GRUNTY
				//sprint(self.real_owner, #PRINT_HIGH, "BUYS A HEALTHPACK\n");
				//PrintFromSoldier(self,self.real_owner,"i've bought a healthpack.\n");
				bought=bought+1;
				//#endif
			}
			loops = loops + 1;
		}

		if (bought>0)
		{
			if (bought==1)
				PrintFromSoldier(self,self.real_owner,"I've bought a healthpack.\n",#PRINT_MEDIUM);
			else
			{
				local string tempst, st2;
				st2=ftos(bought);
				tempst = strcat("I've bought ",st2);
				tempst = strcat(tempst," healthpacks.\n");

				PrintFromSoldier(self,self.real_owner,tempst,#PRINT_MEDIUM);
				//sprint(self.real_owner,#PRINT_HIGH,tempst);
				//sprint(self.real_owner,#PRINT_HIGH," healthpacks.\n");

			}

			sound(self,#CHAN_MISC,"items/r_item1.wav",1,#ATTN_IDLE);
			SpawnBlood (self.origin, 20);
		}

	}

	// Consider buying a shotgun
	if (!self.weapons_carried & #WEAP_SHOTGUN)
		if (self.money >= #GRUNTY_COST_SHOTGUN)
		{
			r = random();
			if (r < 0.5)
			{
				self.weapons_carried = self.weapons_carried | #WEAP_SHOTGUN;
				self.money = self.money - #GRUNTY_COST_SHOTGUN;
				PrintFromSoldier(self,self.real_owner,"I have bought a shotgun.\n",#PRINT_MEDIUM);
				//sprint(self.real_owner, #PRINT_HIGH, "Your soldier has just purchased a shotgun.\n");
			}
		}
	// Consider buying a knife
	if (!self.cutf_items & #CUTF_KNIFE)
		if (self.money >= #GRUNTY_COST_KNIFE)
		{
			r = random();
			if (r < 0.5)
			{
				self.cutf_items = self.cutf_items | #CUTF_KNIFE;
				self.money = self.money - #GRUNTY_COST_KNIFE;
				PrintFromSoldier(self,self.real_owner,"I have bought a knife.\n",#PRINT_MEDIUM);
				//sprint(self.real_owner, #PRINT_HIGH, "Your soldier has just purchased a knife.\n");
			}
		}
	// Consider buying a nailgun
	if (!self.weapons_carried & #WEAP_NAILGUN)
		if (self.money >= #GRUNTY_COST_NAILGUN)
		{
			r = random();
			if (r < 0.25)
			{
				self.weapons_carried = self.weapons_carried | #WEAP_NAILGUN;
				self.money = self.money - #GRUNTY_COST_NAILGUN;
				PrintFromSoldier(self,self.real_owner,"I now own a nailgun.\n",#PRINT_MEDIUM);
				//sprint(self.real_owner, #PRINT_HIGH, "Your soldier now owns a nailgun.\n");
			}
		}
	// Consider buying a double barrel
	if (!self.weapons_carried & #WEAP_SUPER_SHOTGUN)
		if (self.money >= #GRUNTY_COST_SUPER_SHOTGUN)
		{
			r = random();
			if (r < 0.25)
			{
				self.weapons_carried = self.weapons_carried | #WEAP_SUPER_SHOTGUN;
				self.money = self.money - #GRUNTY_COST_SUPER_SHOTGUN;
				PrintFromSoldier(self,self.real_owner,"I've just bought a super shotgun.\n",#PRINT_MEDIUM);
				//sprint(self.real_owner, #PRINT_HIGH, "Your soldier just bought a super shotgun.\n");

			}
		}
	// Consider buying a scanner
	if (!self.tf_items & #NIT_SCANNER)
		if (self.money >= #GRUNTY_COST_SCANNER)
		{
			r = random();
			if (r < 0.15)
			{
				self.tf_items = self.tf_items | #NIT_SCANNER;
				self.money = self.money - #GRUNTY_COST_SCANNER;
				PrintFromSoldier(self,self.real_owner,"I now own a scanner.\n",#PRINT_MEDIUM);
				//sprint(self.real_owner, #PRINT_HIGH, "Your soldier now owns a scanner.\n");
			}
		}
	// Consider buying...a rocket launcher.
	if (!self.weapons_carried & #WEAP_ROCKET_LAUNCHER)
		if (self.money >= #GRUNTY_COST_ROCKET_LAUNCHER)
		{
			r = random();
			if (r < 0.3) //- was 0.2
			{
				self.weapons_carried = self.weapons_carried | #WEAP_ROCKET_LAUNCHER;
				self.money = self.money - #GRUNTY_COST_ROCKET_LAUNCHER;
				PrintFromSoldier(self,self.real_owner,"I have bought a ROCKET LAUNCHER!! hehe\n",#PRINT_MEDIUM);
				//sprint(self.real_owner, #PRINT_HIGH, "Your soldier is now the proud owner of a brand new rocket launcher.\n");
			}
		}

	// Buy ammo
	if ((self.weapons_carried & #WEAP_ROCKET_LAUNCHER) && self.ammo_rockets < self.maxammo_rockets)
	{
		local float rocketstobuy;

		rocketstobuy = self.maxammo_rockets - self.ammo_rockets;
		if (rocketstobuy > 4)
			rocketstobuy = 4;
		if (self.money >= rocketstobuy * #GRUNTY_COST_ROCKET)
		{
			self.ammo_rockets = self.ammo_rockets + rocketstobuy;
			self.money = self.money - rocketstobuy * #GRUNTY_COST_ROCKET;

			//#ifdef VERBOSE_GRUNTY
			PrintFromSoldier(self,self.real_owner,"I've bought some rockets.\n",#PRINT_LOW);
			//sprint(self.real_owner, #PRINT_HIGH, "BUYS SOME ROCKETS\n");
			//#endif
		}
	}

	if ((self.weapons_carried & #WEAP_NAILGUN) && self.ammo_nails < self.maxammo_nails)
	{
		local float nailstobuy;

		nailstobuy = self.maxammo_nails - self.ammo_nails;
		if (nailstobuy > 50) // was 50
			nailstobuy = 50;
		if (self.money >= nailstobuy * #GRUNTY_COST_NAIL)
		{
			self.ammo_nails = self.ammo_nails + nailstobuy;
			self.money = self.money - nailstobuy * #GRUNTY_COST_NAIL;
			//#ifdef VERBOSE_GRUNTY
			PrintFromSoldier(self,self.real_owner,"I've bought some nails.\n",#PRINT_LOW);
			//sprint(self.real_owner, #PRINT_HIGH, "BUYS SOME NAILS\n");
			//#endif

		}
	}

	if ((self.weapons_carried & #WEAP_SHOTGUN ||
		self.weapons_carried & #WEAP_SUPER_SHOTGUN)
		&& self.ammo_shells < self.maxammo_shells)
	{
		local float shellstobuy;

		shellstobuy = self.maxammo_shells - self.ammo_shells;
		if (shellstobuy > 15)
			shellstobuy = 15;
		if (self.money >= shellstobuy * #GRUNTY_COST_SHELL)
		{
			self.ammo_shells = self.ammo_shells + shellstobuy;
			self.money = self.money - shellstobuy * #GRUNTY_COST_SHELL;
			//#ifdef VERBOSE_GRUNTY
			PrintFromSoldier(self,self.real_owner,"I've bought some shells.\n",#PRINT_LOW);
			//sprint(self.real_owner, #PRINT_HIGH, "BUYS SOME SHELLS\n");
			//#endif
		}
	}

	// Consider buying more speed
	if (spendalloc >= #GRUNTY_COST_SPEED)
	{
		if (self.custom_speed < #GRUNTY_MAX_SPEED)
		{
			r = random();
			if (r < 0.3)
			{
				self.custom_speed = self.custom_speed + 1;
				self.money = self.money - #GRUNTY_COST_SPEED;
				spendalloc = spendalloc - #GRUNTY_COST_SPEED;

				PrintFromSoldier(self,self.real_owner,"I'm faster now.\n",#PRINT_MEDIUM);
				//sprint(self.real_owner, #PRINT_HIGH, "Your soldier is now faster.\n");
			}
		}
	}

	//- OfteN: don't let grunt have more HP than #GRUNT_MAX_HP -//
	if (self.health > #GRUNT_MAX_HP)
		self.health = #GRUNT_MAX_HP;

	if (self.max_health > #GRUNT_MAX_HP)
		self.max_health = #GRUNT_MAX_HP;

	self.suicide_time = time + 10;
};

void () GruntyDrawPay =
{
	self.money = self.money + 70 + floor((self.has_sensor/2)+1) * 25;//-was 30 and has_sensor wasnt/2 // then was 30 again
	self.respawn_time = time + 20;
	return;
};

//-----------------------------------------------------//
void() grunty_touch =
{
	if (self.health <= 0) // If we r dead, go away
		return;
	/* // PZ - don't need.. summons can no longer be infected
	local entity Bio;

	if (self.tfstate & #TFSTATE_INFECTED)
	{
		if (other.classname == "player")
		{
			if (!(other.invincible_finished > time)) // Dont infect if we r invincible
			if (!(other.weapons_carried & #WEAP_MEDIKIT)) // neither if we got medikit
			if (!(other.tfstate & #TFSTATE_INFECTED)) // Dont if we r already infected
			{
				// infect 'em
				Bio = spawn ();
				Bio.nextthink = time + 2;
				Bio.think = BioInfection_Decay;
				Bio.enemy = self; //Person causing infection
				Bio.owner = other; //Person getting hurt
				Bio.classname = "timer";
				Bio.netname = "biotimer";

				other.tfstate = other.tfstate | #TFSTATE_INFECTED;
				other.infection_team_no = self.infection_team_no;

				local string tmps;
				tmps = GetMonsterName(self);

				sprint(other, #PRINT_MEDIUM, "You have been infected by the ");
				sprint(other, #PRINT_MEDIUM, tmps);
				sprint(other, #PRINT_MEDIUM, " ");
				sprint(other, #PRINT_MEDIUM, self.netname);
				sprint(other, #PRINT_MEDIUM, "!\n");

				teamprefixsprint(other.team_no,other);
				teamsprint(other.team_no,other, other.netname);
				teamsprint(other.team_no,other, " has been infected!\n");
			}
		}
		else if (IsMonster(other))
		{
			if (!(other.tfstate & #TFSTATE_INFECTED))
			{
				// Report to owner
				local string tmps;
				tmps = GetMonsterName(other);
				sprint(other.real_owner,#PRINT_HIGH,"Your ",tmps," ",other.netname," has been infected!\n");

				// Report to teammates of owner
				local string tmps;
				tmps = GetMonsterName(other);
				teamprefixsprint(other.real_owner.team_no,other.real_owner);
				teamsprint6(other.real_owner,"The ",tmps," ", other.netname," has been infected!\n","");

				// Update infection flag
				other.tfstate = other.tfstate | #TFSTATE_INFECTED;

				// Infect it!
				Bio = spawn ();
				Bio.classname = "timer";
				Bio.classname = "biotimer";
				Bio.nextthink = time + 2;
				Bio.think = BioInfection_MonsterDecay;
				Bio.owner = self;
				Bio.enemy = other;

				other.infection_team_no = self.infection_team_no;
			}
		}

		return; // Dont display funny messages if we r going to infect half of our own team =)
	} */

	if (other.classname=="player" && self.has_holo < time && self.enemy == world)
	{
		local string st;

		if (self.real_owner==other)
		{
			st=GetOwnerMessage(self);
			PrintFromSoldier(self,other,st,#PRINT_CHAT);

			self.has_holo=time+5;
		}
		else if (Teammate(self.real_owner.team_no, other.team_no))
		{
			local float rnum;
			rnum=random();

			if (rnum < 0.4)
			{
				PrintFromSoldier(self,other,"Hi ",#PRINT_CHAT);
				sprint(other,#PRINT_HIGH,other.netname);
				sprint(other,#PRINT_HIGH,", I'm ");
				sprint(other,#PRINT_HIGH,self.netname);
				sprint(other,#PRINT_HIGH,", ");
				sprint(other,#PRINT_HIGH,self.real_owner.netname);
				sprint(other,#PRINT_HIGH,"'s soldier!\n");

			}
			else
			{
				st=GetFriendlyMessage(self);
				PrintFromSoldier(self,other,st,#PRINT_CHAT);
			}

			self.has_holo=time+5;
		}
	}
};

//========================================================================
// lets make the server to not crash when removing waypoints ok? :)

void(entity wyp, entity soldier) RemoveWaypoint =
{
	if (wyp==world)
		return;

	if (wyp.classname == "grunty_waypoint" && wyp.owner == soldier.real_owner)
	{
		if (soldier.martyr_enemy != world)
		{
			if (soldier.martyr_enemy.goalentity == wyp)
				soldier.martyr_enemy.goalentity = world;
		}

		if (soldier.demon_two != world)
		{
			if (soldier.demon_two.goalentity == wyp)
				soldier.demon_two.goalentity = world;
		}

		if (wyp.has_sensor == #WAYPOINT_TYPE_PRIMARY
		 && soldier.martyr_enemy == wyp)
			soldier.martyr_enemy = world;
		else if (wyp.has_sensor == #WAYPOINT_TYPE_SECONDARY
		 && soldier.demon_two == wyp)
			soldier.demon_two = world;
		else if (wyp.has_sensor == #WAYPOINT_TYPE_ENEMYLASTSEEN
		 && soldier.demon_one == wyp)
			soldier.demon_one = world;

		dremove(wyp);
	}
};

//=======================================================================//
// OfN returns the goalentity the grunt should be going to if its able

entity(entity sold, entity viewpoint) ReturnEasyWaypoint =
{
	if (sold.penance_time==2)
		return world;
	if (sold.penance_time==0)
		return world;

	if (sold.penance_time==1)
	{
		if (sold.real_owner.health <= 0)
		{
			sold.penance_time=0;
			return world;
		}

		if (visible2(sold,sold.real_owner))
			return sold.real_owner;
		else
		{
			PrintFromSoldier(sold,sold.real_owner,"I was following you but I can't see you now!\n",#PRINT_HIGH);
			return world;
		}
	}

	if (sold.martyr_enemy!=world && sold.job==1 && visible2(viewpoint,sold.martyr_enemy))
		return sold.martyr_enemy;

	if (sold.demon_two!=world && sold.job==2 && visible2(viewpoint,sold.demon_two))
		return sold.demon_two;

	// no last waypoint walk so lets see whats easier to reach...

	local entity retENT;
	retENT=world;

	if (sold.demon_two!=world && sold.martyr_enemy!=world) // both waypoints assigned? ok...
	{
		if (visible2(viewpoint,sold.martyr_enemy) && visible2(viewpoint,sold.demon_two)) // both waypoints visible? lets see which one is closest...
		{
			local float dist1,dist2;
			dist1 = vlen(viewpoint.origin - sold.martyr_enemy.origin);
			dist2 = vlen(viewpoint.origin - sold.demon_two.origin);

			if (dist1 > dist2) // which is the closest one?
				retENT=sold.demon_two;
			else
				retENT=sold.martyr_enemy;
		}
		else if (visible2(viewpoint,sold.martyr_enemy)) // only primary wayp is visible?
			retENT=sold.martyr_enemy;
		else if (visible2(viewpoint,sold.demon_two)) // only secondary wayp is visible?
			retENT=sold.demon_two;
	}
	else if (sold.demon_two!=world) // only secondary wayp is assigned?
	{
		if (visible2(viewpoint,sold.demon_two))
			retENT=sold.demon_two;
	}
	else if (sold.martyr_enemy!=world) // only primary wayp is assigned?
	{
		if (visible2(viewpoint,sold.martyr_enemy))
			retENT=sold.martyr_enemy;
	}

	if (sold.penance_time == 3 && retENT==world)
		PrintFromSoldier(sold,sold.real_owner,"can't see my waypoints around here!\n",#PRINT_HIGH);

	return retENT;
};

//== OfN, used when picking up ammo ==//
void(entity sld) grunty_boundammo =
{
	if (sld.classname!="monster_army")
		return;

	if (sld.ammo_nails > sld.maxammo_nails) sld.ammo_nails = sld.maxammo_nails;
	if (sld.ammo_cells > sld.maxammo_cells) sld.ammo_cells = sld.maxammo_cells;
	if (sld.ammo_shells > sld.maxammo_shells) sld.ammo_shells = sld.maxammo_shells;
	if (sld.ammo_rockets > sld.maxammo_rockets) sld.ammo_rockets = sld.maxammo_rockets;
};
