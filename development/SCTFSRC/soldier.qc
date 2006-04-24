/*
==============================================================================

SOLDIER / PLAYER

==============================================================================
*/

$cd id1/models/soldier3
$origin 0 -6 24
$base base		
$skin skin

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8

$frame death1 death2 death3 death4 death5 death6 death7 death8
$frame death9 death10

$frame deathc1 deathc2 deathc3 deathc4 deathc5 deathc6 deathc7 deathc8
$frame deathc9 deathc10 deathc11

$frame load1 load2 load3 load4 load5 load6 load7 load8 load9 load10 load11

$frame pain1 pain2 pain3 pain4 pain5 pain6

$frame painb1 painb2 painb3 painb4 painb5 painb6 painb7 painb8 painb9 painb10
$frame painb11 painb12 painb13 painb14

$frame painc1 painc2 painc3 painc4 painc5 painc6 painc7 painc8 painc9 painc10
$frame painc11 painc12 painc13

$frame run1 run2 run3 run4 run5 run6 run7 run8

$frame shoot1 shoot2 shoot3 shoot4 shoot5 shoot6 shoot7 shoot8 shoot9

$frame prowl_1 prowl_2 prowl_3 prowl_4 prowl_5 prowl_6 prowl_7 prowl_8
$frame prowl_9 prowl_10 prowl_11 prowl_12 prowl_13 prowl_14 prowl_15 prowl_16
$frame prowl_17 prowl_18 prowl_19 prowl_20 prowl_21 prowl_22 prowl_23 prowl_24

/*
==============================================================================
SOLDIER CODE
==============================================================================
*/

//soldier standing
void() soldier_stand = [$stand1, player_stand1]
{
        if (self.walkframe >= 8) self.walkframe = 0;
        self.frame = $stand1 + self.walkframe;
        self.walkframe = self.walkframe + 1;
};

// soldier running
void() soldier_run = [$run1, player_run]
{
        if (self.walkframe >= 8) self.walkframe = 0;
        self.frame = $run1 + self.walkframe;
        self.walkframe = self.walkframe + 1;
};

/*** ### Soldier's Attack Frames ### ***/
void() sol_attk = [$shoot3, sol_attk2] {};
void() sol_attk2 = [$shoot4, sol_attk3] {};
void() sol_attk3 = [$shoot5, sol_attk4] {if(self.nweapon==NEW_AXE)W_FireAxe();};
void() sol_attk4 = [$shoot6, sol_attk5] {};
void() sol_attk5 = [$shoot7, sol_attk6] {};
void() sol_attk6 = [$shoot8, sol_attk7] {};
void() sol_attk7 = [$shoot9, soldier_run] {};

/*** ### Soldier's Fragmentation Frames ### ***/
/*
void() sol_fragm = [$load1, sol_fragm2] {};
void() sol_fragm2 = [$load2, sol_fragm3] {};
void() sol_fragm3 = [$load3, sol_fragm4] {};
void() sol_fragm4 = [$load4, sol_fragm5] {};
void() sol_fragm5 = [$load5, sol_fragm6] {};
void() sol_fragm6 = [$load6, sol_fragm7] {};
void() sol_fragm7 = [$load7, sol_fragm8] {};
void() sol_fragm8 = [$load8, sol_fragm9] {};
void() sol_fragm9 = [$load9, sol_fragm10] {};
void() sol_fragm10 = [$load10, sol_fragm11] {};
void() sol_fragm11 = [$load11, sol_fragm12] {};
void() sol_fragm12 = [$shoot3, sol_fragm13] {};
void() sol_fragm13 = [$shoot4, sol_fragm14] {};
void() sol_fragm14 = [$shoot5, sol_fragm15] {launch_inf("fragm2", "progs/grenade.mdl", T_FragmTouch);};
void() sol_fragm15 = [$shoot6, soldier_run] {};
*/

//void() sol_attk8 = [$shoot8, sol_attk9] {};
//void() sol_attk9 = [$shoot9, soldier_run] {};
//void() sol_attk10 = [$load10, sol_attk11] {};
//void() sol_attk11 = [$load11, soldier_run] {};

void()	army_pain1	=[	$pain1,		army_pain2	] {};
void()	army_pain2	=[	$pain2,		army_pain3	] {};
void()	army_pain3	=[	$pain3,		army_pain4	] {};
void()	army_pain4	=[	$pain4,		army_pain5	] {};
void()	army_pain5	=[	$pain5,		army_pain6	] {};
void()  army_pain6      =[      $pain6,         soldier_run       ] {};

void()	army_painb1	=[	$painb1,	army_painb2	] {};
void()  army_painb2     =[      $painb2,        army_painb3     ] {};
void()  army_painb3     =[      $painb3,        army_painb4     ] {};
void()	army_painb4	=[	$painb4,	army_painb5	] {};
void()	army_painb5	=[	$painb5,	army_painb6	] {};
void()	army_painb6	=[	$painb6,	army_painb7	] {};
void()	army_painb7	=[	$painb7,	army_painb8	] {};
void()	army_painb8	=[	$painb8,	army_painb9	] {};
void()	army_painb9	=[	$painb9,	army_painb10] {};
void()	army_painb10=[	$painb10,	army_painb11] {};
void()	army_painb11=[	$painb11,	army_painb12] {};
void()  army_painb12=[  $painb12,       army_painb13] {};
void()	army_painb13=[	$painb13,	army_painb14] {};
void()  army_painb14=[  $painb14,       soldier_run       ] {};

void()	army_painc1	=[	$painc1,	army_painc2	] {};
void()  army_painc2     =[      $painc2,        army_painc3     ] {};
void()	army_painc3	=[	$painc3,	army_painc4	] {};
void()	army_painc4	=[	$painc4,	army_painc5	] {};
void()  army_painc5     =[      $painc5,        army_painc6     ] {};
void()  army_painc6     =[      $painc6,        army_painc7     ] {};
void()	army_painc7	=[	$painc7,	army_painc8	] {};
void()  army_painc8     =[      $painc8,        army_painc9     ] {};
void()  army_painc9     =[      $painc9,        army_painc10] {};
void()  army_painc10=[  $painc10,       army_painc11] {};
void()  army_painc11=[  $painc11,       army_painc12] {};
void()  army_painc12=[  $painc12,       army_painc13] {};
void()  army_painc13=[  $painc13,       soldier_run] {};

void()     army_pain =
{
	local float r;

        if(self.invisible_finished > time) return;
	r = random();

	if (r < 0.2)
	{
//                self.pain_finished = time + 0.6;
		army_pain1 ();
		sound (self, CHAN_VOICE, "soldier/pain1.wav", 1, ATTN_NORM);
	}
	else if (r < 0.6)
	{
//                self.pain_finished = time + 1.1;
		army_painb1 ();
		sound (self, CHAN_VOICE, "soldier/pain2.wav", 1, ATTN_NORM);
	}
	else
	{
//                self.pain_finished = time + 1.1;
		army_painc1 ();
		sound (self, CHAN_VOICE, "soldier/pain2.wav", 1, ATTN_NORM);
	}
};

/*
void() army_fire =
{
	local	vector	dir;
	local	entity	en;
	
	ai_face();
	
	sound (self, CHAN_WEAPON, "soldier/sattck1.wav", 1, ATTN_NORM);	

// fire somewhat behind the player, so a dodging player is harder to hit
	en = self.enemy;
	
	dir = en.origin - en.velocity*0.2;
	dir = normalize (dir - self.origin);
	
	FireBullets (4, dir, '0.1 0.1 0');
};

*/

void()	army_die1	=[	$death1,	army_die2	] {};
void()	army_die2	=[	$death2,	army_die3	] {};
void()  army_die3       =[      $death3,        army_die4       ] {};
void()	army_die4	=[	$death4,	army_die5	] {};
void()	army_die5	=[	$death5,	army_die6	] {};
void()	army_die6	=[	$death6,	army_die7	] {};
void()	army_die7	=[	$death7,	army_die8	] {};
void()	army_die8	=[	$death8,	army_die9	] {};
void()	army_die9	=[	$death9,	army_die10	] {};
void()  army_die10      =[      $death10,       army_die10      ] {PlayerDead();};

void()	army_cdie1	=[	$deathc1,	army_cdie2	] {};
void()  army_cdie2      =[      $deathc2,       army_cdie3      ] {};
void()  army_cdie3      =[      $deathc3,       army_cdie4      ] {};
void()  army_cdie4      =[      $deathc4,       army_cdie5      ] {};
void()  army_cdie5      =[      $deathc5,       army_cdie6      ] {};
void()  army_cdie6      =[      $deathc6,       army_cdie7      ] {};
void()	army_cdie7	=[	$deathc7,	army_cdie8	] {};
void()	army_cdie8	=[	$deathc8,	army_cdie9	] {};
void()	army_cdie9	=[	$deathc9,	army_cdie10	] {};
void()	army_cdie10	=[	$deathc10,	army_cdie11	] {};
void()  army_cdie11     =[      $deathc11,      army_cdie11     ] {PlayerDead();};

/*
void() army_die =
{
// check for gib
	if (self.health < -35)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead ("progs/h_guard.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}

// regular death
	sound (self, CHAN_VOICE, "soldier/death1.wav", 1, ATTN_NORM);
	if (random() < 0.5)
		army_die1 ();
	else
		army_cdie1 ();
};*/


/*QUAKED monster_army (1 0 0) (-16 -16 -24) (16 16 40) Ambush
*/
