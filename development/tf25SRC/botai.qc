/*
==============================================================================
                                                        
FortressBot AI

==============================================================================
*/
float	current_yaw;
float	enemy_vis, enemy_infront, enemy_range;
float	enemy_yaw;

void() Bot_Respawn;
void(float dist) bot_ai_run;
void() bot_attack;
void() bot_soldier_settings;

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
ai_face

Stay facing the enemy
=============
*/
void() ai_face =
{
	self.ideal_yaw = vectoyaw(self.enemy.origin - self.origin);
	ChangeYaw ();
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


// Prototypes

float   ()                                              BotFindTarget;
void    ()                                              bot_ai_stand;
void    (entity attacker, float damage)                 bot_pain;
void    ()                                              bot_die;
void    ()                                              BotFoundTarget;
void    ()                                              BotHuntTarget;
void    (float dist)                                    bot_ai_walk;
void    (void () thinkst)                               BotCheckRefire;
void    ()                                              BotSelfDeActivate;
// Frame macros

$cd /raid/quake/id1/models/player_4
$origin 0 -6 24
$base base		
$skin skin

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

void()  bot_walk1       =[      $rockrun1,        bot_walk2       ] {bot_ai_walk(7);};
void()  bot_walk2       =[      $rockrun2,        bot_walk3       ] {bot_ai_walk(6);};
void()  bot_walk3       =[      $rockrun3,        bot_walk4       ] {bot_ai_walk(8);};
void()  bot_walk4       =[      $rockrun4,        bot_walk5       ] {bot_ai_walk(5);};
void()  bot_walk5       =[      $rockrun5,        bot_walk6       ] {bot_ai_walk(10);};
void()  bot_walk6       =[      $rockrun6,        bot_walk7       ] {bot_ai_walk(7);};
void()  bot_walk7       =[      $rockrun1,        bot_walk8       ] {bot_ai_walk(7);};
void()  bot_walk8       =[      $rockrun2,        bot_walk9       ] {bot_ai_walk(8);};
void()  bot_walk9       =[      $rockrun3,        bot_walk10      ] {bot_ai_walk(6);};
void()  bot_walk10      =[      $rockrun4,        bot_walk11      ] {bot_ai_walk(10);};
void()  bot_walk11      =[      $rockrun5,        bot_walk12      ] {bot_ai_walk(5);};
void()  bot_walk12      =[      $rockrun6,        bot_walk1      ] {bot_ai_walk(7);};


void()  bot_run1        =[      $rockrun1,        bot_run2        ] {bot_ai_run(18);};
void()  bot_run2        =[      $rockrun2,        bot_run3        ] {bot_ai_run(14);};
void()  bot_run3        =[      $rockrun3,        bot_run4        ] {bot_ai_run(9);};
void()  bot_run4        =[      $rockrun4,        bot_run5        ] {bot_ai_run(12);};
void()  bot_run5        =[      $rockrun5,        bot_run6        ] {bot_ai_run(14);};
void()  bot_run6        =[      $rockrun6,        bot_run1        ] {bot_ai_run(20);};

void()  bot_atk1        =[      $rockatt1,       bot_atk2        ] {ai_face();};
void()  bot_atk2        =[      $rockatt2,       bot_atk3        ] {ai_face();};
void()  bot_atk3        =[      $rockatt3,       bot_atk4        ] {ai_face();};
void()  bot_atk4        =[      $rockatt4,       bot_atk5        ] {bot_attack();};
void()  bot_atk5        =[      $rockatt5,       bot_atk6        ] {ai_face();};
void()  bot_atk6        =[      $rockatt6,       bot_run1        ]
{
	ai_face();
//	BotCheckRefire (bot_atk1);
};


void()  bot_pain1      =[      $pain1   ,        bot_pain2      ] {};
void()  bot_pain2      =[      $pain2   ,        bot_pain3      ] {};
void()  bot_pain3      =[      $pain4   ,        bot_pain4      ] {ai_painforward(2);};
void()  bot_pain4      =[      $pain3   ,        bot_pain5      ] {};
void()  bot_pain5      =[      $pain4   ,        bot_pain6      ] {ai_pain(1);};
void()  bot_pain6      =[      $pain6   ,        bot_walk1      ] {};

void()  bot_die1        =[      $deatha1,        bot_die2        ] {};
void()  bot_die2        =[      $deatha2,        bot_die3        ] {};
void()  bot_die3        =[      $deatha3,        bot_die4        ]
{
	self.solid = #SOLID_NOT;
	DropBackpack();
};
void()  bot_die4        =[      $deatha4,       bot_die5        ] {ai_forward(14);};
void()  bot_die5        =[      $deatha5,       bot_die6        ] {ai_forward(2);};
void()  bot_die6        =[      $deatha6,       bot_die7        ] {};
void()  bot_die7        =[      $deatha7,       bot_die7        ] {BotSelfDeActivate();};

void()  bot_fdie1       =[      $deathd1,       bot_fdie2       ] {};
void()  bot_fdie2       =[      $deathd2,       bot_fdie3       ] {};
void()  bot_fdie3       =[      $deathd3,       bot_fdie4       ] 
{
	self.solid = #SOLID_NOT;
	DropBackpack();
};
void()  bot_fdie4       =[      $deathd4,       bot_fdie5       ] {};
void()  bot_fdie5       =[      $deathd5,       bot_fdie6       ] {};
void()  bot_fdie6       =[      $deathd6,       bot_fdie7       ] {};
void()  bot_fdie7       =[      $deathd7,       bot_fdie8       ] {};
void()  bot_fdie8       =[      $deathd8,       bot_fdie9       ] {};
void()  bot_fdie9       =[      $deathd9,       bot_fdie9       ] {BotSelfDeActivate();};


float() BotFindTarget =
{
    local entity head, selected;
	local float dist;

	selected = world;
	head = find (world, classname, "player");
	while(head)
	{
		if (visible(head))
        	if ((head.health > 0) && (head != self))
				if (self.team_no != head.team_no)
               	{
                	selected = head;
                    dist = trace_plane_dist;
                }
		head = find (head, classname, "player");
	}

	self.enemy = selected;

	if (self.enemy == world)
		return #FALSE;
    else
    {
		BotFoundTarget();
		return #TRUE;
	}
};


//=============================================================
// bot_ai_stand - bot stands in place until target acquired,
// and starts to walk if pausetime has expired
//=============================================================
void() bot_ai_stand =
{
	if (BotFindTarget ())
    	return;
	
    self.th_walk ();
};


//=============================================================
// bot_pain
//=============================================================
void(entity attacker, float damage)	bot_pain =
{
	local float r;
	local entity oldself;

    r = rint((random() * 5) + 1);

	if (self.pain_finished > time)
		return;
   	
    if (r == 1)
    	sound (self, #CHAN_VOICE, "player/pain1.wav", 1, #ATTN_NORM);
    else if (r == 2)
		sound (self, #CHAN_VOICE, "player/pain2.wav", 1, #ATTN_NORM);
    else if (r == 3)
    	sound (self, #CHAN_VOICE, "player/pain3.wav", 1, #ATTN_NORM);
    else if (r == 4)
    	sound (self, #CHAN_VOICE, "player/pain4.wav", 1, #ATTN_NORM);
    else if (r == 5)
    	sound (self, #CHAN_VOICE, "player/pain5.wav", 1, #ATTN_NORM);
	else
		sound (self, #CHAN_VOICE, "player/pain6.wav", 1, #ATTN_NORM);

	self.pain_finished = time + 1;
    bot_pain1 ();
};

//=============================================================
// bot_die
//=============================================================
void() bot_die =
{
	if (self.health < -40)
	{
		GibPlayer ();
        if (deathmatch)
        	Bot_Respawn();
		return;
	}
        
    sound (self, #CHAN_VOICE, "player/death1.wav", 1, #ATTN_NORM);

	if (random() > 0.5)
		bot_die1 ();
	else
		bot_fdie1 ();
};

//=============================================================
// BotHuntTarget
//=============================================================
void() BotHuntTarget =
{
	self.goalentity = self.enemy;
	self.think = self.th_run;
	self.ideal_yaw = vectoyaw(self.enemy.origin - self.origin);
	self.nextthink = time + 0.1;
    SUB_AttackFinished (0.1);       // wait a while before first attack
};


//=============================================================
// BotFoundTarget
//=============================================================
void() BotFoundTarget =
{
	local float f_dist;
	local string s_dist;
	
	f_dist = vlen (self.enemy.origin - self.origin);
	s_dist = ftos (f_dist);

	self.show_hostile = time + 1;		// wake up other monsters
	
	BotHuntTarget ();
};

//=============================================================
// bot_ai_walk - bot is walking, looking for enemies
//=============================================================
void(float dist) bot_ai_walk =
{
	if (BotFindTarget ())
    	return;

	enemy_infront = infront(self.movetarget);
	enemy_range = range(self.movetarget);
	enemy_yaw = vectoyaw(self.movetarget.origin - self.movetarget.origin);

    movetogoal (dist);
};

void() Strafe_Bot =
{
	makevectors(self.angles);

	// strafe the bot right (i think)
	self.velocity = self.velocity + (v_right*16);

};

//=============================================================
// bot_ai_run - bot is attacking enemy
//=============================================================
void(float dist) bot_ai_run =
{
	if (self.enemy == world)
	{
		self.th_walk();
		return;
	}

	enemy_infront = infront(self.movetarget);
	enemy_range = range(self.movetarget);
	enemy_yaw = vectoyaw(self.movetarget.origin - self.movetarget.origin);

    movetogoal (dist);

	// strafe code
	Strafe_Bot();

	if (self.attack_finished > time)
		return;
	
	if (visible(self.enemy))
		bot_atk1();
	else
	{
		self.enemy = world;
		self.think = self.th_walk;
	}
};


//=============================================================
// BotCheckRefire
//=============================================================
void (void() thinkst) BotCheckRefire =
{
	if (!visible (self.enemy) || (self.enemy.health <= 0))
		return;

	self.think = thinkst;
};


//=============================================================
// BotSelfDeActivate - Bot deactivates itself
//=============================================================
void () BotSelfDeActivate =
{
        self.solid = #SOLID_NOT;
        self.deadflag = #DEAD_DEAD;
        	
        Bot_Respawn();
};

//=============================================================
// BG Bot Weapons Hack - still needs a lot of work
//=============================================================
void() bot_FireShotgun =
{
	local vector dir;
	local vector alter;

	self.currentammo = self.ammo_shells = self.ammo_shells - 1;
	sound (self, #CHAN_WEAPON, "weapons/guncock.wav", 1, #ATTN_NORM);	
	muzzleflash();
    dir = self.enemy.origin - self.origin;
	// add in some randomizing code to change the fire pattern
    dir = normalize(dir);	
		// change this value to alter the amount of 'miss aiming'
	dir = dir * 400;
	alter = self.enemy.velocity * (random() - 0.2);
	dir = dir - alter; // so they shoot where the player was
	dir = normalize(dir);
 
	FireBullets (6, dir, '0.04 0.04 0');
};

void() bot_FireSuperShotgun =
{
	local vector dir;

	if (self.currentammo == 1)
	{
        bot_FireShotgun ();
		return;
	}
		
	self.currentammo = self.ammo_shells = self.ammo_shells - 2;

	muzzleflash();

	sound (self, #CHAN_WEAPON, "weapons/shotgn2.wav", 1, #ATTN_NORM);

    dir = self.enemy.origin - self.origin;

    dir = normalize(dir);
	FireBullets (14, dir, '0.14 0.08 0');
};

void() bot_FireRocket =
{
	local	entity missile,  mpuff;

	sound (self, #CHAN_WEAPON, "weapons/sgun1.wav", 1, #ATTN_NORM);

	missile = spawn ();
	missile.owner = self;
	missile.movetype = #MOVETYPE_FLYMISSILE;
	missile.solid = #SOLID_BBOX;

    makevectors (self.angles);

    missile.velocity = self.enemy.origin - self.origin;
    missile.velocity = normalize(missile.velocity);
	missile.velocity = missile.velocity * 1000;
	missile.angles = vectoangles(missile.velocity);
	missile.touch = T_MissileTouch;
	missile.nextthink = time + 5;
	missile.think = SUB_Remove;
	newmis.weapon = #DMSG_ROCKETL;
	setmodel (missile, "progs/missile.mdl");
	setsize (missile, '0 0 0', '0 0 0');		
        setorigin (missile, self.origin + '0 0 16');

	self.attack_finished = time + 0.9;
	self.reload_rocket_launcher = self.reload_rocket_launcher + 1;

	if (self.reload_rocket_launcher >= #RE_ROCKET_LAUNCHER)
	{
		self.reload_rocket_launcher = 0;
		self.attack_finished = time + 0.9 + #RE_ROCKET_LAUNCHER_TIME;
	}
};

/*
==========================
bot_attack - fires weapon
==========================
*/
void() bot_attack =
{
	local	float	r;

    if (!visible (self.enemy) || (self.enemy.health <= 0))
	{
		self.enemy = world;
    	return;
	}

	if (self.attack_finished > time)
		return;

    makevectors (self.angles);     

	if (self.weapon & #WEAP_ROCKET_LAUNCHER)
	{
        bot_FireRocket();
	}
	else if (self.weapon & #WEAP_SUPER_SHOTGUN)
	{
        bot_FireSuperShotgun ();
	}
    else if (self.weapon & #WEAP_SHOTGUN)
	{
    	bot_FireShotgun ();
	}
};
