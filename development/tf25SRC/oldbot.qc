void() movetarget_f;
void() t_movetarget;
float() FindTarget;
void(float dist) ai_forward;
void(float dist) ai_painforward;
void(float dist) ai_pain;

void() bot_die1;

void(entity etemp, entity stemp, entity stemp, float dmg) T_Damage;

void() bot_soldier_settings;


float BOT_SOLDIER 	= 1;
float BOT_SNIPER 	= 2;
float BOT_MEDIC		= 3;


/*============================
	Bot movement functions
============================*/

void() bot_ai_stand =
{
	bprint("standing bot\n");
};


/*
=============
bot_walk

The Bot on patrol
=============
*/

void(float dist) bot_ai_walk =
{
	movedist = dist * self.speed;

	movetogoal (movedist);
};

void(float dist) bot_ai_walk_scan =
{
	movedist = dist * self.speed;

	// scan for enemies	
/*
	if (FindTarget ())
		return;
*/
	if (self.health <= 0)
	{
		bprint("bot health low\n");
		bot_die1();
	}

	movetogoal (movedist);
};

/*===========
	setup the bot for respawn
=========*/

void() Bot_Respawn =
{
	bprint("respawning bot\n");
    setmodel (self, "progs/player.mdl");
    setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);

	self.nextthink = time + 2; // don't come online for 2 seconds
	self.takedamage = DAMAGE_AIM;
	if (self.target)
	    self.goalentity = find(world, targetname, self.target);
	else 
		self.goalentity = self;

	self.movetarget = self.goalentity;
	self.origin = self.oldorigin;
	setorigin(self, self.origin);
   	self.deadflag = DEAD_NO;
	self.solid = SOLID_SLIDEBOX;
	self.takedamage = TRUE;

	if (self.playerclass == BOT_SOLDIER)
		bot_soldier_settings();

	if (!self.movetarget)
		self.think = self.th_stand;
	else
		self.think = self.th_walk;
};

void() Bot_Deactivate =
{
	bprint("deactivating bot\n");
	self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_NONE;

	self.nextthink = time + 5;
	self.think = Bot_Respawn;
};

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


void()	bot_stand1	=[	$stand1,	bot_stand2	] {bot_ai_stand();};
void()	bot_stand2	=[	$stand2,	bot_stand3	] {bot_ai_stand();};
void()	bot_stand3	=[	$stand3,	bot_stand4	] {bot_ai_stand();};
void()	bot_stand4	=[	$stand4,	bot_stand5	] {bot_ai_stand();};
void()  bot_stand5      =[      $stand5,        bot_stand1      ] {bot_ai_stand();};

void()  bot_walk1       =[      $rockrun1,        bot_walk2       ] {bot_ai_walk(14);};
void()  bot_walk2       =[      $rockrun1,        bot_walk3       ] {bot_ai_walk_scan(12);};
void()  bot_walk3       =[      $rockrun2,        bot_walk4       ] {bot_ai_walk(15);};
void()  bot_walk4       =[      $rockrun2,        bot_walk5       ] {bot_ai_walk_scan(10);};
void()  bot_walk5       =[      $rockrun3,        bot_walk6       ] {bot_ai_walk(19);};
void()  bot_walk6       =[      $rockrun3,        bot_walk7       ] {bot_ai_walk_scan(14);};
void()  bot_walk7       =[      $rockrun4,        bot_walk8       ] {bot_ai_walk(13);};
void()  bot_walk8       =[      $rockrun4,        bot_walk9       ] {bot_ai_walk_scan(17);};
void()  bot_walk9       =[      $rockrun5,        bot_walk10      ] {bot_ai_walk(12);};
void()  bot_walk10      =[      $rockrun6,        bot_walk11      ] {bot_ai_walk_scan(20);};
void()  bot_walk11      =[      $rockrun6,        bot_walk12      ] {bot_ai_walk(10);};
void()  bot_walk12      =[      $rockrun6,        bot_walk1      ] {bot_ai_walk_scan(14);};

/*
void()  bot_stuff1        =[      $rockrun1,        bot_stuff2        ] {bot_ai_stuff(18);};
void()  bot_stuff2        =[      $rockrun2,        bot_stuff3        ] {bot_ai_stuff(14);};
void()  bot_stuff3        =[      $rockrun3,        bot_stuff4        ] {bot_ai_stuff(7);};
void()  bot_stuff4        =[      $rockrun4,        bot_stuff5        ] {bot_ai_stuff(12);};
void()  bot_stuff5        =[      $rockrun5,        bot_stuff6        ] {bot_ai_stuff(14);};
void()  bot_stuff6        =[      $rockrun6,        bot_walk1         ] {bot_ai_stuff(11);};


void()  bot_atk1        =[      $rockatt1,       bot_atk2        ] {ai_face();};
void()  bot_atk2        =[      $rockatt2,       bot_atk3        ] {ai_face();};
void()  bot_atk3        =[      $rockatt3,       bot_atk4        ] {ai_face();};
void()  bot_atk4        =[      $rockatt4,       bot_atk5        ] {bot_attack();};
void()  bot_atk5        =[      $rockatt5,       bot_atk6        ] {ai_face();};
void()  bot_atk6        =[      $rockatt6,       bot_run1        ] {ai_face();};
*/

void()  bot_pain1      =[      $pain1   ,        bot_pain2      ] {};
void()  bot_pain2      =[      $pain2   ,        bot_pain3      ] {};
void()  bot_pain3      =[      $pain4   ,        bot_pain4      ] {ai_painforward(2);};
void()  bot_pain4      =[      $pain3   ,        bot_pain5      ] {};
void()  bot_pain5      =[      $pain4   ,        bot_pain6      ] {ai_pain(1);};
void()  bot_pain6      =[      $pain6   ,        bot_walk1       ] {};

void()  bot_die1        =[      $deatha1,        bot_die2        ] {};
void()  bot_die2        =[      $deatha2,        bot_die3        ] {};
void()  bot_die3        =[      $deatha3,        bot_die4        ]
{
	self.solid = SOLID_NOT;
	DropBackpack();
};
void()  bot_die4        =[      $deatha4,       bot_die5        ] {ai_forward(14);};
void()  bot_die5        =[      $deatha5,       bot_die6        ] {ai_forward(2);};
void()  bot_die6        =[      $deatha6,       bot_die7        ] {};
void()  bot_die7        =[      $deatha7,       bot_die7        ] 
{ 
	Bot_Deactivate();
};

void()  bot_fdie1       =[      $deathd1,       bot_fdie2       ] {};
void()  bot_fdie2       =[      $deathd2,       bot_fdie3       ] {};
void()  bot_fdie3       =[      $deathd3,       bot_fdie4       ] 
{
	self.solid = SOLID_NOT;
	DropBackpack();
};

void()  bot_fdie4       =[      $deathd4,       bot_fdie5       ] {};
void()  bot_fdie5       =[      $deathd5,       bot_fdie6       ] {};
void()  bot_fdie6       =[      $deathd6,       bot_fdie7       ] {};
void()  bot_fdie7       =[      $deathd7,       bot_fdie8       ] {};
void()  bot_fdie8       =[      $deathd8,       bot_fdie9       ] {};
void()  bot_fdie9       =[      $deathd9,       bot_fdie9       ] 
{
	Bot_Deactivate();
};




//
// globals
//
float	current_yaw;
float	enemy_vis, enemy_infront, enemy_range;
float	enemy_yaw;






//=============================================================================

void(float dist) ai_forward =
{
	walkmove (self.angles_y, dist);
};

void(float dist) ai_back =
{
	walkmove ( (self.angles_y+180), dist);
};


/*
=============
ai_pain

stagger back a bit
=============
*/
void(float dist) ai_pain =
{
	ai_back (dist);
/*
	local float	away;
	
	away = anglemod (vectoyaw (self.origin - self.enemy.origin) 
	+ 180*(random()- 0.5) );
	
	walkmove (away, dist);
*/
};

/*
=============
ai_painforward

stagger back a bit
=============
*/
void(float dist) ai_painforward =
{
	walkmove (self.ideal_yaw, dist);
};



/*
=============
ai_stand

The monster is staying in one place for a while, with slight angle turns
=============
*/
void() ai_stand =
{
	if (FindTarget ())
		return;
	
	if (time > self.pausetime)
	{
		self.th_walk ();
		return;
	}
	
// change angle slightly

};

/*
=============
ai_turn

don't move, but turn towards ideal_yaw
=============
*/
void() ai_turn =
{
	if (FindTarget ())
		return;
	
	ChangeYaw ();
};

//=============================================================================


/*
============
FacingIdeal

============
*/
float() FacingIdeal =
{
	local	float	delta;
	
	delta = anglemod(self.angles_y - self.ideal_yaw);
	if (delta > 45 && delta < 315)
		return FALSE;
	return TRUE;
};



/*
=============
bot_run_melee

Turn and close until within an angle to launch a melee attack
=============
*/
void() bot_run_melee =
{
	self.ideal_yaw = enemy_yaw;
	ChangeYaw ();

	if (FacingIdeal())
	{
		self.th_melee ();
	}
};



/*
=============
bot_run_missile

Turn in place until within an angle to launch a missile attack
=============
*/
void() bot_run_missile =
{
	self.ideal_yaw = enemy_yaw;
	ChangeYaw ();
	if (FacingIdeal())
	{
		self.th_missile ();
	}
};



/*
=============
bot_run

The bot has an enemy it is trying to kill
=============
*/
/*
void(float dist) bot_run =
{
	local	vector	delta;
	local	float	axis;
	local	float	direct, ang_rint, ang_floor, ang_ceil;
	
	movedist = dist;
// see if the enemy is dead
	if (self.enemy.health <= 0)
	{
		self.enemy = world;
		if (self.movetarget)
			self.th_walk ();
		else
			self.th_stand ();
		return;
	}

// check knowledge of enemy
	enemy_vis = visible(self.enemy);
	if (enemy_vis)
		self.search_time = time + 5;


	enemy_infront = infront(self.enemy);
	enemy_range = range(self.enemy);
	enemy_yaw = vectoyaw(self.enemy.origin - self.origin);
		
// head straight in
	movetogoal (dist);		// done in C code...
};

*/


void() set_default_bot =
{
	self.solid = SOLID_SLIDEBOX;
    self.movetype = MOVETYPE_STEP;

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

	self.takedamage = DAMAGE_AIM;
	if (self.target)
	    self.goalentity = find(world, targetname, self.target);
	else 
		self.goalentity = self;

	self.movetarget = self.goalentity;
	
   	self.deadflag = DEAD_NO;
	self.takedamage = TRUE;

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
	self.th_run = bot_walk1;
	self.th_pain = bot_pain1;
	self.th_die = bot_die1;
	self.th_missile = player_rocket1;
	self.oldorigin = self.origin;
    
    setmodel (self, "progs/player.mdl");
    setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);

	self.nextthink = time + 5; // don't come online for x seconds

	if (!self.movetarget)
		self.think = self.th_stand;
	else
		self.think = self.th_walk;
};