/*
==============================================================================

Fortress Bot

==============================================================================
*/

#define BOT_SOLDIER 1
#define BOT_SNIPER  2
#define BOT_MEDIC   3
#define BOT_HWGUY	4


void() set_default_bot;

void() RespawnBot =
{
	self.solid = #SOLID_SLIDEBOX;
	self.movetype = #MOVETYPE_STEP;

	if (self.playerclass == #BOT_SOLDIER)
		bot_soldier_settings();

	set_default_bot();
};

void() Bot_Respawn =
{
	CopyToBodyQue(self);

	self.model = string_null;
	self.solid = #SOLID_NOT;
	self.deadflag = #DEAD_DEAD;
	setmodel(self, self.model);
	self.origin = self.oldorigin;
	self.nextthink = time + 5;
	self.think = RespawnBot;
};


void() set_default_bot =
{
	self.solid = #SOLID_SLIDEBOX;
    self.movetype = #MOVETYPE_STEP;

    self.classname = "bot";
    self.frags = 0;

	if (!self.team_no)
		self.team = 0;
	else if (self.team_no == 1)
		self.team = team1col;
	else if (self.team_no == 2)
		self.team = team2col;
	else if (self.team_no == 3)
		self.team = team3col;
	else if (self.team_no == 4)
		self.team = team4col;

	self.colormap = self.team;

	if (self.target)
	    self.goalentity = find(world, targetname, self.target);
	else 
		self.goalentity = self;

	self.movetarget = self.goalentity;
	
   	self.deadflag = #DEAD_NO;
	self.takedamage = #DAMAGE_AIM;

	if (!self.pausetime)
		self.pausetime = 3;

	if (!self.speed)
		self.speed = 0.5;

	if (!self.delay)
		self.delay = 5;	// default 5 seconds respawn delay (too quick?)

	self.ideal_yaw = self.angles * '0 1 0';
    self.yaw_speed = 60;
	self.view_ofs = '0 0 25';
	self.th_stand = bot_stand1;
	self.th_walk = bot_walk1;
	self.th_run = bot_run1;
	self.th_pain = bot_pain;
	self.th_die = bot_die;
	self.th_missile = player_rocket1;
	self.oldorigin = self.origin;

	self.origin = self.dest;
    setmodel (self, "progs/player.mdl");
    setsize (self, #VEC_HULL_MIN, #VEC_HULL_MAX);
	setorigin (self, self.origin);
	spawn_tfog(self.origin);
	spawn_tdeath(self.origin, self);
	droptofloor();

	self.nextthink = time + 2; // don't come online for x seconds

	self.think = self.th_walk;
};