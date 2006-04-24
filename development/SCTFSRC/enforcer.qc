/*** DEFS ***/
void() enf_chain4;
void() enf_chain5;

/*
==============================================================================

SOLDIER / PLAYER

==============================================================================
*/

$cd id1/models/enforcer
$origin 0 -6 24
$base base		
$skin skin

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8 walk9 walk10
$frame walk11 walk12 walk13 walk14 walk15 walk16

$frame run1 run2 run3 run4 run5 run6 run7 run8

$frame attack1 attack2 attack3 attack4 attack5 attack6
$frame attack7 attack8 attack9 attack10

$frame death1 death2 death3 death4 death5 death6 death7 death8
$frame death9 death10 death11 death12 death13 death14

$frame fdeath1 fdeath2 fdeath3 fdeath4 fdeath5 fdeath6 fdeath7 fdeath8
$frame fdeath9 fdeath10 fdeath11

$frame paina1 paina2 paina3 paina4

$frame painb1 painb2 painb3 painb4 painb5

$frame painc1 painc2 painc3 painc4 painc5 painc6 painc7 painc8

$frame paind1 paind2 paind3 paind4 paind5 paind6 paind7 paind8
$frame paind9 paind10 paind11 paind12 paind13 paind14 paind15 paind16
$frame paind17 paind18 paind19


/*
void() Laser_Touch =
{
	local vector org;
	
	if (other == self.owner)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	
	sound (self, CHAN_WEAPON, "enforcer/enfstop.wav", 1, ATTN_STATIC);
	org = self.origin - 8*normalize(self.velocity);

	if (other.health)
	{
		SpawnBlood (org, self.velocity*0.2, 15);
		T_Damage (other, self, self.owner, 15);
	}
	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_GUNSHOT);
		WriteCoord (MSG_BROADCAST, org_x);
		WriteCoord (MSG_BROADCAST, org_y);
		WriteCoord (MSG_BROADCAST, org_z);
	}
	
	remove(self);	
};

void(vector org, vector vec) LaunchLaser =
{
	local	vector	vec;
		
	if (self.classname == "monster_enforcer")
		sound (self, CHAN_WEAPON, "enforcer/enfire.wav", 1, ATTN_NORM);

	vec = normalize(vec);
	
	newmis = spawn();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLY;
	newmis.solid = SOLID_BBOX;
	newmis.effects = EF_DIMLIGHT;

	setmodel (newmis, "progs/laser.mdl");
	setsize (newmis, '0 0 0', '0 0 0');		

	setorigin (newmis, org);

	newmis.velocity = vec * 600;
	newmis.angles = vectoangles(newmis.velocity);

	newmis.nextthink = time + 5;
	newmis.think = SUB_Remove;
	newmis.touch = Laser_Touch;
};


void() enforcer_fire =
{
	local vector org;

	self.effects = self.effects | EF_MUZZLEFLASH;
	makevectors (self.angles);
	
	org = self.origin + v_forward * 30 + v_right * 8.5 + '0 0 16';

	LaunchLaser(org, self.enemy.origin - self.origin);
};*/

//============================================================================
/*
void()  enf_stand1      =[      $stand1,        enf_stand2      ] {};
void()  enf_stand2      =[      $stand2,        enf_stand3      ] {};
void()  enf_stand3      =[      $stand3,        enf_stand4      ] {};
void()  enf_stand4      =[      $stand4,        enf_stand5      ] {};
void()  enf_stand5      =[      $stand5,        enf_stand6      ] {};
void()  enf_stand6      =[      $stand6,        enf_stand7      ] {};
void()  enf_stand7      =[      $stand7,        enf_stand1      ] {};

void()	enf_walk1	=[	$walk1 ,	enf_walk2	] {
if (random() < 0.2)
        sound (self, CHAN_VOICE, "enforcer/idle1.wav", 1, ATTN_IDLE);};
void()  enf_walk2       =[      $walk2 ,        enf_walk3       ] {};
void()  enf_walk3       =[      $walk3 ,        enf_walk4       ] {};
void()  enf_walk4       =[      $walk4 ,        enf_walk5       ] {};
void()  enf_walk5       =[      $walk5 ,        enf_walk6       ] {};
void()  enf_walk6       =[      $walk6 ,        enf_walk7       ] {};
void()  enf_walk7       =[      $walk7 ,        enf_walk8       ] {};
void()  enf_walk8       =[      $walk8 ,        enf_walk9       ] {};
void()  enf_walk9       =[      $walk9 ,        enf_walk10      ] {};
void()  enf_walk10      =[      $walk10,        enf_walk11      ] {};
void()  enf_walk11      =[      $walk11,        enf_walk12      ] {};
void()  enf_walk12      =[      $walk12,        enf_walk13      ] {};
void()  enf_walk13      =[      $walk13,        enf_walk14      ] {};
void()  enf_walk14      =[      $walk14,        enf_walk15      ] {};
void()  enf_walk15      =[      $walk15,        enf_walk16      ] {};
void()  enf_walk16      =[      $walk16,        enf_walk1       ] {};
*/
// enforcer running
void() enf_run = [ $run1, player_run ]
{
        if (self.walkframe >= 8)
                self.walkframe = 0;
        self.frame = $run1 + self.walkframe;
        self.walkframe = self.walkframe + 1;
};

void()  enf_atk5        =[      $attack1,       enf_atk6        ] {};
void()  enf_atk6        =[      $attack6,       enf_atk7        ] {};
void()  enf_atk7        =[      $attack7,       enf_atk8        ] {if(self.nweapon==NEW_AXE||self.nweapon==NEW_RP)W_FireAxe();};
void()  enf_atk8        =[      $attack8,       enf_atk9        ] {};
void()  enf_atk9        =[      $attack5,       enf_atk10       ] {};
void()  enf_atk10       =[      $attack5,       enf_atk11         ] {};//W_Attack();};
void()  enf_atk11       =[      $attack5,       enf_run          ] {};
void()  enf_atk12       =[      $attack8,       enf_atk13       ] {};
void()  enf_atk13       =[      $attack9,       enf_atk14       ] {};
void()  enf_atk14       =[      $attack10,      enf_run        ] {};

// enforcer standing
void() enf_stand = [ $stand1, player_stand1 ]
{
        if (self.walkframe >= 7)
                self.walkframe = 0;
        self.frame = $stand1 + self.walkframe;
        self.walkframe = self.walkframe + 1;
};

/*** ### Enforcer's Nailgun Frames ### ***/
void()  enf_nail1 = [$attack6, enf_nail2]
{
        // effects
        self.effects = self.effects | EF_MUZZLEFLASH;

        if (!self.button0)
                {player_run ();return;}

        SuperDamageSound();
        if (self.nweapon == NEW_NAIL)
                W_FireSpikes(4);
        else if (self.nweapon == NEW_FLAME)
                W_FireFlame2(4);
        else if (self.nweapon == NEW_SUPER_NAIL)
                W_FireSuperSpikes();

        self.attack_finished = time + 0.2;
};

void()  enf_nail2 = [$attack8, enf_nail1]
{
        // effects
        self.effects = self.effects | EF_MUZZLEFLASH;

        if (!self.button0)
                {player_run ();return;}

        SuperDamageSound();
        if (self.nweapon == NEW_NAIL)
                W_FireSpikes(-4);
        else if (self.nweapon == NEW_FLAME)
                W_FireFlame2(-4);
        else if (self.nweapon == NEW_SUPER_NAIL)
                W_FireSuperSpikes();

        self.attack_finished = time + 0.2;
};

/*** ### Enforcer's CHAIN Frames ### ***/
void() enf_chain1 = [$attack6, enf_chain2] {};
void() enf_chain2 = [$attack7, enf_chain3] {W_FireChain();};
void() enf_chain3 = [$attack8, enf_chain3]
{
        if (!self.hook_out)
        {
                enf_chain5();
                return;
        }
        if (vlen(self.velocity) >= 750)
        {
                enf_chain4();
                return;
        }
};

void() enf_chain4 = [$death14, enf_chain4]
{
        if (!self.hook_out)
        {
                enf_chain5();
                return;
        }
        if (vlen(self.velocity) < 750)
        {
                enf_chain3();
                return;
        }
};

void() enf_chain5 = [$attack9, enf_run] {};

/*** ### Enforcer's LIGHT Frames ### ***/
void() enf_light1 = [$attack6, enf_light2]
{
        self.effects = self.effects | EF_MUZZLEFLASH;

        if (!self.button0)
                {enf_run();return;}

        SuperDamageSound();
        W_FireLightning();
        self.attack_finished = time + 0.2;
};

void() enf_light2 = [$attack8, enf_light1]
{
        self.effects = self.effects | EF_MUZZLEFLASH;

        if (!self.button0)
                {enf_run();return;}

        SuperDamageSound();
        W_FireLightning();
        self.attack_finished = time + 0.2;
};


void()	enf_paina1	=[	$paina1,	enf_paina2	] {};
void()	enf_paina2	=[	$paina2,	enf_paina3	] {};
void()	enf_paina3	=[	$paina3,	enf_paina4	] {};
void()  enf_paina4      =[      $paina4,        enf_run        ] {};

void()	enf_painb1	=[	$painb1,	enf_painb2	] {};
void()	enf_painb2	=[	$painb2,	enf_painb3	] {};
void()	enf_painb3	=[	$painb3,	enf_painb4	] {};
void()	enf_painb4	=[	$painb4,	enf_painb5	] {};
void()  enf_painb5      =[      $painb5,        enf_run        ] {};

void()	enf_painc1	=[	$painc1,	enf_painc2	] {};
void()	enf_painc2	=[	$painc2,	enf_painc3	] {};
void()	enf_painc3	=[	$painc3,	enf_painc4	] {};
void()	enf_painc4	=[	$painc4,	enf_painc5	] {};
void()	enf_painc5	=[	$painc5,	enf_painc6	] {};
void()	enf_painc6	=[	$painc6,	enf_painc7	] {};
void()	enf_painc7	=[	$painc7,	enf_painc8	] {};
void()  enf_painc8      =[      $painc8,        enf_run        ] {};

void()	enf_paind1	=[	$paind1,	enf_paind2	] {};
void()	enf_paind2	=[	$paind2,	enf_paind3	] {};
void()	enf_paind3	=[	$paind3,	enf_paind4	] {};
void()  enf_paind4      =[      $paind4,        enf_paind5      ] {PainSound();};
void()  enf_paind5      =[      $paind5,        enf_paind6      ] {};
void()	enf_paind6	=[	$paind6,	enf_paind7	] {};
void()	enf_paind7	=[	$paind7,	enf_paind8	] {};
void()	enf_paind8	=[	$paind8,	enf_paind9	] {};
void()	enf_paind9	=[	$paind9,	enf_paind10	] {};
void()	enf_paind10	=[	$paind10,	enf_paind11	] {};
void()  enf_paind11     =[      $paind11,       enf_paind12     ] {};
void()  enf_paind12     =[      $paind12,       enf_paind13     ] {};
void()  enf_paind13     =[      $paind13,       enf_paind14     ] {};
void()	enf_paind14	=[	$paind14,	enf_paind15	] {};
void()	enf_paind15	=[	$paind15,	enf_paind16	] {};
void()  enf_paind16     =[      $paind16,       enf_paind17     ] {};
void()  enf_paind17     =[      $paind17,       enf_paind18     ] {};
void()	enf_paind18	=[	$paind18,	enf_paind19	] {};
void()  enf_paind19     =[      $paind19,       enf_run        ] {};

void()     enf_pain =
{
	local float r;

	r = random ();
        if (self.invisible_finished > time) return;

	
	if (r < 0.5)
		sound (self, CHAN_VOICE, "enforcer/pain1.wav", 1, ATTN_NORM);
	else
		sound (self, CHAN_VOICE, "enforcer/pain2.wav", 1, ATTN_NORM);

	if (r < 0.2)
	{
		self.pain_finished = time + 1;
		enf_paina1 ();
	}
	else if (r < 0.4)
	{
		self.pain_finished = time + 1;
		enf_painb1 ();
	}
	else if (r < 0.7)
	{
		self.pain_finished = time + 1;
		enf_painc1 ();
	}
	else
	{
		self.pain_finished = time + 2;
		enf_paind1 ();
	}
};

//============================================================================




void()	enf_die1	=[	$death1,	enf_die2	] {};
void()	enf_die2	=[	$death2,	enf_die3	] {};
void()  enf_die3        =[      $death3,        enf_die4        ] {};
void()  enf_die4        =[      $death4,        enf_die5        ] {};
void()  enf_die5        =[      $death5,        enf_die6        ] {};
void()	enf_die6	=[	$death6,	enf_die7	] {};
void()	enf_die7	=[	$death7,	enf_die8	] {};
void()	enf_die8	=[	$death8,	enf_die9	] {};
void()  enf_die9        =[      $death9,        enf_die10       ] {};
void()  enf_die10       =[      $death10,       enf_die11       ] {};
void()  enf_die11       =[      $death11,       enf_die12       ] {};
void()  enf_die12       =[      $death12,       enf_die13       ] {};
void()	enf_die13	=[	$death13,	enf_die14	] {};
void()  enf_die14       =[      $death14,       enf_die14       ] {PlayerDead();};

void()	enf_fdie1	=[	$fdeath1,	enf_fdie2	] {};
void()	enf_fdie2	=[	$fdeath2,	enf_fdie3	] {};
void()  enf_fdie3       =[      $fdeath3,       enf_fdie4       ] {};
void()	enf_fdie4	=[	$fdeath4,	enf_fdie5	] {};
void()	enf_fdie5	=[	$fdeath5,	enf_fdie6	] {};
void()	enf_fdie6	=[	$fdeath6,	enf_fdie7	] {};
void()	enf_fdie7	=[	$fdeath7,	enf_fdie8	] {};
void()	enf_fdie8	=[	$fdeath8,	enf_fdie9	] {};
void()	enf_fdie9	=[	$fdeath9,	enf_fdie10	] {};
void()	enf_fdie10	=[	$fdeath10,	enf_fdie11	] {};
void()  enf_fdie11      =[      $fdeath11,      enf_fdie11      ] {PlayerDead();};


void() enf_die =
{
// check for gib
	if (self.health < -35)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead ("progs/h_mega.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}

// regular death
	sound (self, CHAN_VOICE, "enforcer/death1.wav", 1, ATTN_NORM);
	if (random() > 0.5)
		enf_die1 ();
	else
		enf_fdie1 ();
};


