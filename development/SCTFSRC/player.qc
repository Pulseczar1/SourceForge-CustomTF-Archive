
void() CloneThink;
void() W_LayProximityMine;
void() bubble_bob;
void()	deadStand;

// kano defs
void() kano_fire5;
void() W_FireKano;

// raiden defs
void() raiden_fire5;
void() W_FireRaiden;

// liu kang defs
void() kang_fire5;
void() W_FireKang;

// hook defs
void(float ox) W_FireChain;
void() player_chain5;
void() player_chain4;

// dog's defs
void() dog_run;
void() dog_stand;
void() dog_die1;
void() dog_dieb1;

void() f_death1;

// knight's defs
void() hknight_die1;
void() hknight_dieb1;
void() hknight_stand;
void() hknight_run;

// shambler's defs
void() sham_run;
void() sham_stand;
void() sham_death1;

// shalrath's defs
void() shal_stand;
void() shal_run1;
void() shal_death1;

// zombie's defs
void() zombie_run;
void() zombie_stand;

// soldier's defs
// void() soldier_run;
// void() soldier_stand;
// void() army_die1;
// void() army_cdie1;

// enforcer's defs
void() enf_run;
void() enf_stand;
void() enf_die1;
void() enf_fdie1;

// knight's (rebel) defs
void() knight_run;
void() knight_stand;
void() knight_die1;
void() knight_dieb1;

void(float ox) W_FireFlame2;  // flame thrower (another one!)

/*
==============================================================================

PLAYER

==============================================================================
*/

$cd id1/models/player_4
$origin 0 -6 24
$base base		
$skin skin

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

/*
==============================================================================
PLAYER
==============================================================================
*/

void() player_run;

void()	player_stand1 =[	$axstnd1,	player_stand1	]
{
	self.weaponframe=0;
	if (self.velocity_x || self.velocity_y)
	{
                self.walkframe=0;
                player_run();
		return;

	}
        // think will change if the nightmare rune is there
        if (self.classname == "ghost clone") {
                self.nextthink = time + 0.1;
                self.think = CloneThink;
        }

        // person is in the raiden mode (don't change frames)
        if (self.inferno_flag & FR_RAIDEN) {
                raiden_fire1();
                return;
        }

        // person is in the kano mode (don't change frames)
        if (self.inferno_flag & FR_KANO) {
                kano_fire1();
                return;
        }

        // person is in the kang mode (don't change frames)
        if (self.inferno_flag & FR_KANG) {
                kang_fire1();
                return;
        }
        if (self.rune == RUNE_FOOLISH) {
            if (self.status_flag & ITEM_SECOND_RUNE) {
               deadStand();
               return;
            }
        }
        // check for the future rune...
        if (self.rune == RUNE_FUTURE) {
                enf_stand();
                return;
        }

        // person got turned into a dog
        if ((self.runeb_rune == RUNE_WITCH && self.runeb_time >= time)
        || self.rune == RUNE_WEREWOLF) {
                dog_stand();
                return;
        }

        // check for knight rune (hint)
        if (self.rune == RUNE_KNIGHT) {
                hknight_stand();
                return;
        }

        // check for zombie rune
        if (self.rune == RUNE_ZOMBIE || 
         (self.runeb_rune == RUNE_DEATH && self.runeb_time >= time) ||
         (self.runeb_rune == RUNE_ZOMBIE && self.runeb_time >= time)) {
                zombie_stand();
                return;
        }

        // check for the pet frankie rune
        if (self.rune == RUNE_FP) {
                sham_stand();
                return;
        }

        // check for tarantula
        if (self.rune == RUNE_TARANTULA) {
                shal_stand();
                return;
        }      
        
        if (self.weapon == IT_AXE)
	{
		if (self.walkframe >= 12)
			self.walkframe = 0;
		self.frame = $axstnd1 + self.walkframe;
	}
	else
	{
		if (self.walkframe >= 5)
			self.walkframe = 0;
		self.frame = $stand1 + self.walkframe;
	}
        self.walkframe = self.walkframe + 1;
};

void()  player_run = [   $rockrun1,      player_run      ]
{
	self.weaponframe=0;
	if (!self.velocity_x && !self.velocity_y)
	{
                self.walkframe=0;
                player_stand1();
		return;
        }
        // think will change if the nightmare rune is there
        if (self.classname == "ghost clone") {
                self.nextthink = time + 0.1;
                self.think = CloneThink;
        }


        // person is in the raiden mode (don't change frames)
        if (self.inferno_flag & FR_RAIDEN) {
                raiden_fire1();
                return;
        }

        // person is in the kano mode (don't change frames)
        if (self.inferno_flag & FR_KANO) {
                kano_fire1();
                return;
        }

        // person is in the kang mode (don't change frames)
        if (self.inferno_flag & FR_KANG) {
                kang_fire1();
                return;
        }

        if (self.rune == RUNE_FOOLISH) {
            if (self.status_flag & ITEM_SECOND_RUNE) {
               deadStand();
               return;
            }
        }

        // person got turned into a dog
        if ((self.runeb_rune == RUNE_WITCH && self.runeb_time >= time)
        || self.rune == RUNE_WEREWOLF) {
                dog_run();
                return;
        }

        // check for the future rune...
        if (self.rune == RUNE_FUTURE) {
                enf_run();
                return;
        }

        // check for knight rune (hint)
        if (self.rune == RUNE_KNIGHT) {
                hknight_run();
                return;
        }

        // check for zombie rune
        if (self.rune == RUNE_ZOMBIE || 
         (self.runeb_rune == RUNE_DEATH && self.runeb_time >= time) ||
         (self.runeb_rune == RUNE_DEATH && self.runeb_time >= time)) {
                zombie_run();
                return;
        }

        // check for the pet frankie rune
        if (self.rune == RUNE_FP) {
                sham_run();
                return;
        }

        // chech for tarantula
        if (self.rune == RUNE_TARANTULA) {
                shal_run1();
                return;
        }

        if (self.weapon == IT_AXE)
	{
                if (self.walkframe >= 6)
			self.walkframe = 0;
		self.frame = $axrun1 + self.walkframe;
	}
	else
	{
                if (self.walkframe >= 6)
			self.walkframe = 0;
		self.frame = self.frame + self.walkframe;
	}
        // walk fast if you need to!
        if ((self.rune == RUNE_PORTAL_MASTER) && (self.status_flag & ITEM_SECOND_RUNE)) 
                self.walkframe = self.walkframe + 2;
        else
                self.walkframe = self.walkframe + 1;
};


void()  player_shot1 = [$shotatt1, player_shot2        ] {self.weaponframe=1;
self.effects = self.effects | EF_MUZZLEFLASH;};
void()	player_shot2 =	[$shotatt2, player_shot3	] {self.weaponframe=2;};
void()	player_shot3 =	[$shotatt3, player_shot4	] {self.weaponframe=3;};
void()	player_shot4 =	[$shotatt4, player_shot5	] {self.weaponframe=4;};
void()	player_shot5 =	[$shotatt5, player_shot6	] {self.weaponframe=5;};
void()	player_shot6 =	[$shotatt6, player_run	] {self.weaponframe=6;};

void()	player_axe1 =	[$axatt1, player_axe2	] {self.weaponframe=1;};
void()	player_axe2 =	[$axatt2, player_axe3	] {self.weaponframe=2;};
void()	player_axe3 =	[$axatt3, player_axe4	] {self.weaponframe=3;W_FireAxe();};
void()	player_axe4 =	[$axatt4, player_run	] {self.weaponframe=4;};

void()	player_axeb1 =	[$axattb1, player_axeb2	] {self.weaponframe=5;};
void()	player_axeb2 =	[$axattb2, player_axeb3	] {self.weaponframe=6;};
void()	player_axeb3 =	[$axattb3, player_axeb4	] {self.weaponframe=7;W_FireAxe();};
void()	player_axeb4 =	[$axattb4, player_run	] {self.weaponframe=8;};

void()	player_axec1 =	[$axattc1, player_axec2	] {self.weaponframe=1;};
void()	player_axec2 =	[$axattc2, player_axec3	] {self.weaponframe=2;};
void()	player_axec3 =	[$axattc3, player_axec4	] {self.weaponframe=3;W_FireAxe();};
void()	player_axec4 =	[$axattc4, player_run	] {self.weaponframe=4;};

void()	player_axed1 =	[$axattd1, player_axed2	] {self.weaponframe=5;};
void()	player_axed2 =	[$axattd2, player_axed3	] {self.weaponframe=6;};
void()	player_axed3 =	[$axattd3, player_axed4	] {self.weaponframe=7;W_FireAxe();};
void()	player_axed4 =	[$axattd4, player_run	] {self.weaponframe=8;};

void()  player_chain1=  [$axattd1, player_chain2 ] {self.weaponframe=2;};
void()  player_chain2=  [$axattd2, player_chain3 ]
{
        local entity e;

        self.weaponframe=3;
        W_FireChain(0);
};

void()  player_chain3=  [$axattd3, player_chain3 ]
{
        self.weaponframe=3;
        if (!self.hook_out)
        {
                player_chain5();
                return;
        }
        if (vlen(self.velocity) >= 750)
        {
                player_chain4();
                return;
        }
};

void() player_chain4=  [$deathc4, player_chain4 ]
{
        self.weaponframe=4;
        if (!self.hook_out)
        {
                player_chain5();
                return;
        }
        if (vlen(self.velocity) < 750)
        {
                player_chain3();
                return;
        }
};

void()  player_chain5=  [$axattd4, player_run    ] {self.weaponframe=5;};


/*** To fire something if the person has some kind of powerup ***/
void() W_CheckPF =
{
   if (self.pweapon_time < time) {
      // sub zero rune
      if (self.rune == RUNE_SUBZERO && !(self.status_flag & ITEM_SECOND_RUNE))
              W_FireFreez();

      // reptile rune
      if (self.rune == RUNE_REPTILE && !(self.status_flag & ITEM_SECOND_RUNE))
              W_FireAcid();

      // kung lao
      // if (self.rune == RUNE_LAO && !(self.status_flag & ITEM_SECOND_RUNE))
      //         launch_inf("head", "progs/h_player.mdl", T_HeadTouch);

      // dragon
      if (self.rune == RUNE_DRAGON && (self.status_flag & ITEM_SECOND_RUNE))
              W_FireFlame2(15);

      // now add to the regen time so you won't fire VERY rapidly
      self.pweapon_time = time + 0.3;
   }
};

//============================================================================

void() player_nail1   =[$nailatt1, player_nail2  ]
{
	self.effects = self.effects | EF_MUZZLEFLASH;

	if (!self.button0) {
      player_run ();
      return;
   }
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 9)
		self.weaponframe = 1;
	SuperDamageSound();

   if (self.nweapon != NEW_MINES) {
      if (self.nweapon == NEW_FLAME)
         W_FireFlame2 (4);
      else
         W_FireSpikes (4);
      self.attack_finished = time + 0.2;
   }
   else {
      W_LayProximityMine();
      self.nextthink = time + 0.3; // time before switching weapons
      self.attack_finished = time + 1.0; // time before switching barrels
   } 

   // check powerups
   W_CheckPF();
};

void() player_nail2   =[$nailatt2, player_nail1  ]
{
	self.effects = self.effects | EF_MUZZLEFLASH;

	if (!self.button0)
		{player_run ();return;}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 9)
		self.weaponframe = 1;
	SuperDamageSound();

   // check what weapon is appropriate
   if (self.nweapon != NEW_MINES) {
      if (self.nweapon == NEW_FLAME)
         W_FireFlame2 (-4);
      else
         W_FireSpikes (-4);
      self.attack_finished = time + 0.2;
   }
   else {
      W_LayProximityMine();
      self.nextthink = time + 0.3; // time before switching weapons
      self.attack_finished = time + 1.0; // time before switching barrels
   } 

   // check powerups
   W_CheckPF();
};

//============================================================================

void() player_light1   =[$light1, player_light2  ] 
{
	self.effects = self.effects | EF_MUZZLEFLASH;

	if (!self.button0)
		{player_run ();return;}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 5)
		self.weaponframe = 1;
	SuperDamageSound();
	W_FireLightning();
	self.attack_finished = time + 0.2;

        // check powerups
        W_CheckPF();
};

void() player_light2   =[$light2, player_light1  ]
{
	self.effects = self.effects | EF_MUZZLEFLASH;

	if (!self.button0)
		{player_run ();return;}
	self.weaponframe = self.weaponframe + 1;
	if (self.weaponframe == 5)
		self.weaponframe = 1;
	SuperDamageSound();
	W_FireLightning();
	self.attack_finished = time + 0.2;

        // check powerups
        W_CheckPF();
};

//============================================================================

/***  These are Raiden's frames, it kinda looks the same as the original :)  ***/
void() raiden_fire1 = [$axattd1, raiden_fire2] {self.weaponframe = 2;};
void() raiden_fire2 = [$axattd1, raiden_fire3] {self.weaponframe = 2;};
void() raiden_fire3 = [$axattd2, raiden_fire4] {self.weaponframe = 2;W_FireRaiden();};
void() raiden_fire4=  [$deathc4, raiden_fire4 ]
{
        self.weaponframe=4;
        if (!(self.inferno_flag & FR_RAIDEN) || (self.health <= 0) ||
        ((self.rune != RUNE_RAIDEN) || !(self.status_flag & ITEM_SECOND_RUNE))) {
                // remove the "flying mode" if neccessary
                if (self.inferno_flag & FR_RAIDEN)
                        self.inferno_flag = self.inferno_flag - FR_RAIDEN;
                raiden_fire5();
                return;
        }
};
void()  raiden_fire5=  [$axattd4, player_run    ] {self.weaponframe=5;};
//============================================================================

/***  These are Kano's frames, it kinda looks the same as the original :)  ***/
void() kano_fire1 = [$axattd1, kano_fire2] {self.weaponframe = 2;};
void() kano_fire2 = [$axattd1, kano_fire3] {self.weaponframe = 2;};
void() kano_fire3 = [$axattd2, kano_fire4] {self.weaponframe = 2;W_FireKano();};
void() kano_fire4=  [$deathb4, kano_fire4 ]
{
        self.weaponframe=4;
        if (!(self.inferno_flag & FR_KANO) || (self.health <= 0) ||
        (!self.rune)) {
                // remove the "flying mode" if neccessary
                if (self.inferno_flag & FR_KANO)
                        self.inferno_flag = self.inferno_flag - FR_KANO;
                kano_fire5();
                return;
        }
};
void()  kano_fire5=  [$axattd4, player_run    ] {self.weaponframe=5;};

//============================================================================

/***  These are Liu Kang's frames, it kinda looks the same as the original :)  ***/
void() kang_fire1 = [$axattd1, kang_fire2] {self.weaponframe = 2;};
void() kang_fire2 = [$axattd1, kang_fire3] {self.weaponframe = 2;};
void() kang_fire3 = [$axattd2, kang_fire4] {self.weaponframe = 2;W_FireKang();};
void() kang_fire4=  [$deathc4, kang_fire4 ]
{
        self.weaponframe=4;
//        self.angles = self.angles*-2;
        if (!(self.inferno_flag & FR_KANG) || (self.health <= 0) ||
        ((self.rune != RUNE_KANG) || !(self.status_flag & ITEM_SECOND_RUNE))) {
                // remove the "flying mode" if neccessary
                if (self.inferno_flag & FR_KANG)
                        self.inferno_flag = self.inferno_flag - FR_KANG;
                kang_fire5();
                return;
        }
};
void()  kang_fire5=  [$axattd4, player_run    ] {self.weaponframe=5;};

//============================================================================



void() player_rocket1   =[$rockatt1, player_rocket2  ] {self.weaponframe=1;
self.effects = self.effects | EF_MUZZLEFLASH;};
void() player_rocket2   =[$rockatt2, player_rocket3  ] {self.weaponframe=2;};
void() player_rocket3   =[$rockatt3, player_rocket4  ] {self.weaponframe=3;};
void() player_rocket4   =[$rockatt4, player_rocket5  ] {self.weaponframe=4;};
void() player_rocket5   =[$rockatt5, player_rocket6  ] {self.weaponframe=5;};
void() player_rocket6   =[$rockatt6, player_run  ] {self.weaponframe=6;};
void(float num_bubbles) DeathBubbles;


void() PainSound =
{
        local float             rs;

	if (self.health < 0)
		return;

        // is the person currently a dog?
        if (self.runeb_rune == RUNE_WITCH && self.runeb_time >= time) {
                sound (self, CHAN_VOICE, "dog/dpain1.wav", 1, ATTN_NONE);
                return;
        }

	if (damage_attacker.classname == "teledeath")
	{
		sound (self, CHAN_VOICE, "player/teledth1.wav", 1, ATTN_NONE);
		return;
	}

// water pain sounds
	if (self.watertype == CONTENT_WATER && self.waterlevel == 3)
	{
                if (self.bubble_time < time) {
                        DeathBubbles(1);
                        self.bubble_time = time + 0.5;
                }
		if (random() > 0.5)
			sound (self, CHAN_VOICE, "player/drown1.wav", 1, ATTN_NORM);
		else
			sound (self, CHAN_VOICE, "player/drown2.wav", 1, ATTN_NORM);
		return;
	}

// slime pain sounds
	if (self.watertype == CONTENT_SLIME)
	{
// FIX ME	put in some steam here
		if (random() > 0.5)
			sound (self, CHAN_VOICE, "player/lburn1.wav", 1, ATTN_NORM);
		else
			sound (self, CHAN_VOICE, "player/lburn2.wav", 1, ATTN_NORM);
		return;
	}

	if (self.watertype == CONTENT_LAVA)
	{
		if (random() > 0.5)
			sound (self, CHAN_VOICE, "player/lburn1.wav", 1, ATTN_NORM);
		else
			sound (self, CHAN_VOICE, "player/lburn2.wav", 1, ATTN_NORM);
		return;
	}

	if (self.pain_finished > time)
	{
		self.axhitme = 0;
		return;
	}
	self.pain_finished = time + 0.5;

// don't make multiple pain sounds right after each other

// ax pain sound
	if (self.axhitme == 1)
	{
		self.axhitme = 0;
		sound (self, CHAN_VOICE, "player/axhit1.wav", 1, ATTN_NORM);
		return;
	}
	

	rs = rint((random() * 5) + 1);

	self.noise = "";
	if (rs == 1)
		self.noise = "player/pain1.wav";
	else if (rs == 2)
		self.noise = "player/pain2.wav";
	else if (rs == 3)
		self.noise = "player/pain3.wav";
	else if (rs == 4)
		self.noise = "player/pain4.wav";
	else if (rs == 5)
		self.noise = "player/pain5.wav";
	else
		self.noise = "player/pain6.wav";

	sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);
	return;
};

void()	player_pain1 =	[	$pain1,	player_pain2	] {PainSound();self.weaponframe=0;};
void()	player_pain2 =	[	$pain2,	player_pain3	] {};
void()	player_pain3 =	[	$pain3,	player_pain4	] {};
void()	player_pain4 =	[	$pain4,	player_pain5	] {};
void()	player_pain5 =	[	$pain5,	player_pain6	] {};
void()	player_pain6 =	[	$pain6,	player_run	] {};

void()	player_axpain1 =	[	$axpain1,	player_axpain2	] {PainSound();self.weaponframe=0;};
void()	player_axpain2 =	[	$axpain2,	player_axpain3	] {};
void()	player_axpain3 =	[	$axpain3,	player_axpain4	] {};
void()	player_axpain4 =	[	$axpain4,	player_axpain5	] {};
void()	player_axpain5 =	[	$axpain5,	player_axpain6	] {};
void()	player_axpain6 =	[	$axpain6,	player_run	] {};

void() player_pain =
{
	if (self.weaponframe)
		return;

	if (self.invisible_finished > time)
		return;		// eyes don't have pain frames

        if (self.weapon == IT_AXE)
		player_axpain1 ();
	else
		player_pain1 ();
};

void() player_diea1;
void() player_dieb1;
void() player_diec1;
void() player_died1;
void() player_diee1;
void() player_die_ax1;

void() DeathBubblesSpawn =
{
local entity	bubble;
	if (self.owner.waterlevel != 3)
		return;
	bubble = spawn();
	setmodel (bubble, "progs/s_bubble.spr");
	setorigin (bubble, self.owner.origin + '0 0 24');
	bubble.movetype = MOVETYPE_NOCLIP;
	bubble.solid = SOLID_NOT;
	bubble.velocity = '0 0 15';
	bubble.nextthink = time + 0.5;
	bubble.think = bubble_bob;
	bubble.classname = "bubble";
	bubble.frame = 0;
	bubble.cnt = 0;
	setsize (bubble, '-8 -8 -8', '8 8 8');
	self.nextthink = time + 0.1;
	self.think = DeathBubblesSpawn;
	self.air_finished = self.air_finished + 1;
	if (self.air_finished >= self.bubble_count)
		remove(self);
};

void(float num_bubbles) DeathBubbles =
{
local entity	bubble_spawner;
	
	bubble_spawner = spawn();
	setorigin (bubble_spawner, self.origin);
	bubble_spawner.movetype = MOVETYPE_NONE;
	bubble_spawner.solid = SOLID_NOT;
	bubble_spawner.nextthink = time + 0.1;
	bubble_spawner.think = DeathBubblesSpawn;
	bubble_spawner.air_finished = 0;
	bubble_spawner.owner = self;
	bubble_spawner.bubble_count = num_bubbles;
	return;
};


void() DeathSound =
{
        local float             rs;

	// water death sounds
	if (self.waterlevel == 3)
	{
		DeathBubbles(20);
		sound (self, CHAN_VOICE, "player/h2odeath.wav", 1, ATTN_NONE);
		return;
	}
	
        if (self.rune == RUNE_KNIGHT)
                self.noise = "hknight/death1.wav";
        else {
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
        }

	sound (self, CHAN_VOICE, self.noise, 1, ATTN_NONE);
	return;
};


void() PlayerDead =
{
	self.nextthink = -1;
// allow respawn after a certain time
	self.deadflag = DEAD_DEAD;
};

vector(float dm) VelocityForDamage =
{
	local vector v;

	v_x = 100 * crandom();
	v_y = 100 * crandom();
	v_z = 200 + 100 * random();

	if (dm > -50)
	{
//		dprint ("level 1\n");
		v = v * 0.7;
	}
	else if (dm > -200)
	{
//		dprint ("level 3\n");
		v = v * 2;
	}
	else
		v = v * 10;

	return v;
};

void() gib_float =
{
        if (pointcontents(self.origin) == CONTENT_WATER) {
                self.movetype = MOVETYPE_FLY;
                self.velocity_z = 50;
        } else self.velocity_z = 0;
        if (self.count_count < time && self.classname != "player" && self.count_count)
                remove(self);
        self.nextthink = time + 0.5;
};

void(string gibname, float dm) ThrowGib =
{
	local	entity new;

	new = spawn();
	new.origin = self.origin;
	setmodel (new, gibname);
	setsize (new, '0 0 0', '0 0 0');
	new.velocity = VelocityForDamage (dm);
//        if (new.waterlevel)
//                new.movetype = MOVETYPE_FLY;
        new.movetype = MOVETYPE_BOUNCE;
        new.solid = SOLID_NOT;
	new.avelocity_x = random()*600;
	new.avelocity_y = random()*600;
	new.avelocity_z = random()*600;
        new.think = SUB_Remove;
//        new.count_count = time + 1 + random();
	new.ltime = time;
        if (gibname != "progs/spike.mdl")  // cannot do if spike, or overload
                new.nextthink = time + 10 + random()*10;
        else new.nextthink = time + 0.8 + random();
//        new.nextthink = time + 0.5;
	new.frame = 0;
	new.flags = 0;
};

void(string gibname, float dm) ThrowHead =
{
	setmodel (self, gibname);
	self.frame = 0;
	self.nextthink = -1;
//        if (self.waterlevel)
        self.movetype = MOVETYPE_BOUNCE;
	self.takedamage = DAMAGE_NO;
        self.solid = SOLID_NOT;
	self.view_ofs = '0 0 8';
	setsize (self, '-16 -16 0', '16 16 56');
	self.velocity = VelocityForDamage (dm);
	self.origin_z = self.origin_z - 24;
	self.flags = self.flags - (self.flags & FL_ONGROUND);
	self.avelocity = crandom() * '0 600 0';
//        self.think = gib_float;
//        self.nextthink = time + 0.5;

        // what is the classname?
//        self.classname = gibname;  // this will make it more specific
};


void() GibPlayer =
{
        if (self.runeb_rune == RUNE_WITCH && self.runeb_time >= time)
                ThrowHead ("progs/h_dog.mdl", self.health);
        else if (self.rune == RUNE_KNIGHT)
                ThrowHead ("progs/h_hellkn.mdl", self.health);
        else if (self.rune == RUNE_DISAPEAR && !(self.status_flag & ITEM_SECOND_RUNE))
                ThrowHead ("progs/flame2.mdl", self.health);
        else if (self.rune == RUNE_POSSESSER && (self.status_flag & ITEM_SECOND_RUNE))
                ThrowHead ("progs/missile.mdl", self.health);
        else if (self.rune == RUNE_FUTURE)
                ThrowHead ("progs/h_mega.mdl", self.health);
        else if ((self.runeb_rune == RUNE_DEATH && self.runeb_time >= time) || 
         (self.runeb_rune == RUNE_ZOMBIE && self.runeb_time >= time) || 
         self.rune == RUNE_ZOMBIE)
                ThrowHead ("progs/h_zombie.mdl", self.health);
        else if (self.rune == RUNE_FP)
                ThrowHead ("progs/h_shams.mdl", self.health);
        else if (self.rune == RUNE_TARANTULA)
                ThrowHead ("progs/h_shal.mdl", self.health);                
        else
                ThrowHead ("progs/h_player.mdl", self.health);
        if (self.rune == RUNE_DISAPEAR && !(self.status_flag & ITEM_SECOND_RUNE)) {
                ThrowGib ("progs/flame2.mdl", self.health);
                ThrowGib ("progs/flame2.mdl", self.health);
                ThrowGib ("progs/flame2.mdl", self.health);
        } else if (self.rune == RUNE_POSSESSER && (self.status_flag & ITEM_SECOND_RUNE)) {
                ThrowGib ("progs/missile.mdl", self.health);
                ThrowGib ("progs/missile.mdl", self.health);
                ThrowGib ("progs/missile.mdl", self.health);
        } else {
                ThrowGib ("progs/gib1.mdl", self.health);
                ThrowGib ("progs/gib2.mdl", self.health);
                ThrowGib ("progs/gib3.mdl", self.health);
        }

	self.deadflag = DEAD_DEAD;

	if (damage_attacker.classname == "teledeath")
	{
		self.staydeadtime = time + 2 + (random() * 3);
		sound (self, CHAN_VOICE, "player/teledth1.wav", 1, ATTN_NONE);
		return;
	}

	if (damage_attacker.classname == "teledeath2")
	{
		self.staydeadtime = time + 3 + (random() * 6);
		sound (self, CHAN_VOICE, "player/teledth1.wav", 1, ATTN_NONE);
		return;
	}
		
	if (random() < 0.5)
		sound (self, CHAN_VOICE, "player/gib.wav", 1, ATTN_NONE);
	else
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NONE);
};

void() PlayerDie =
{
	local	float	i;

        // was going to choose a base, lost his turn!!!
        self.flag_picked_time = time;
	self.items = self.items - (self.items & IT_INVISIBILITY);
	self.invisible_finished = 0;	// don't die as eyes
	self.invincible_finished = 0;
	self.super_damage_finished = 0;
	self.radsuit_finished = 0;
        if (self.modelindex == modelindex_eyes)
                self.modelindex = modelindex_player;    // don't use eyes
        self.key5_flag_count = 0;

        self.bugs="";self.bugs_time=0;  // flies, bees, etc...

	if (self.killed == 2)
		self.killed = 0;
	else
		self.killed = 1;
	self.weaponmodel="";
	self.view_ofs = '0 0 -8';
	self.deadflag = DEAD_DYING;
	self.solid = SOLID_NOT;
	self.flags = self.flags - (self.flags & FL_ONGROUND);
	self.movetype = MOVETYPE_TOSS;
	if (self.velocity_z < 10)
		self.velocity_z = self.velocity_z + random()*300;

        if (self.health < -40)
	{
                GibPlayer ();
                // have to do this here, so things won't mess up with frames and stuff
                DropBackpack();
                DropRune();
                TeamCaptureDropFlagOfPlayer(self);
		return;
	}

	DeathSound();
	
        self.angles_x = 0;
        self.angles_z = 0;

        // is the person a dog?
        if ((self.runeb_rune == RUNE_WITCH && self.runeb_time >= time) ||
        (self.rune == RUNE_WEREWOLF)) {
                if (random() < 0.5)
                        dog_die1 ();
                else dog_dieb1 ();
        } else if ((self.runeb_time >= time && self.runeb_rune == RUNE_DEATH) || 
         (self.runeb_time >= time && self.runeb_rune == RUNE_ZOMBIE) || 
         self.rune == RUNE_ZOMBIE)
                GibPlayer();
        else if (self.rune == RUNE_KNIGHT) {
                if (random() < 0.5)
                        hknight_die1 ();
                else hknight_dieb1 ();
        } else if (self.rune == RUNE_LIQUID || (self.runeb_time >= time && self.runeb_rune == RUNE_POSEIDON))  { // a fish?
                f_death1();
        // else if ((self.rune == RUNE_DISAPEAR) && !(self.status_flag & ITEM_SECOND_RUNE)) {
        //         self.angles = self.angles + '90 0 0';
        //         PlayerDead();
        } else if (self.rune == RUNE_FUTURE) {
                if (random() < 0.5)
                        enf_die1();
                else enf_fdie1();
        } else if (self.rune == RUNE_FP)
                sham_death1();
        else if (self.rune == RUNE_TARANTULA)
                shal_death1();
        else {
                if (self.weapon == IT_AXE)
                { 
                        player_die_ax1 ();
                        // have to do this here, so things won't mess up with frames and stuff
                        DropBackpack();
                        DropRune();
                        TeamCaptureDropFlagOfPlayer(self);
                        
                        return;
                }
	
        //        i = cvar("temp1");
        //        if (!i)
                        i = 1 + floor(random()*6);
	
                if (i == 1)
                        player_diea1();
                else if (i == 2)
                        player_dieb1();
                else if (i == 3)
                        player_diec1();
                else if (i == 4)
                        player_died1();
                else
                        player_diee1();
        }
        // have to do this here, so things won't mess up with frames and stuff
        DropBackpack();
        DropRune();
        TeamCaptureDropFlagOfPlayer(self);
        
};

void() set_suicide_frame =
{	// used by klill command and diconnect command
/*
	if (self.model != "progs/player.mdl")
		return;	// allready gibbed
*/
	if (self.health <= 0)
		return;
	self.frame = $deatha11;
	self.solid = SOLID_NOT;
	self.movetype = MOVETYPE_TOSS;
	self.deadflag = DEAD_DEAD;
	self.nextthink = -1;
};


void()	player_diea1	=	[	$deatha1,	player_diea2	] {};
void()	player_diea2	=	[	$deatha2,	player_diea3	] {};
void()	player_diea3	=	[	$deatha3,	player_diea4	] {};
void()	player_diea4	=	[	$deatha4,	player_diea5	] {};
void()	player_diea5	=	[	$deatha5,	player_diea6	] {};
void()	player_diea6	=	[	$deatha6,	player_diea7	] {};
void()	player_diea7	=	[	$deatha7,	player_diea8	] {};
void()	player_diea8	=	[	$deatha8,	player_diea9	] {};
void()	player_diea9	=	[	$deatha9,	player_diea10	] {};
void()	player_diea10	=	[	$deatha10,	player_diea11	] {};
void()	player_diea11	=	[	$deatha11,	player_diea11 ] {PlayerDead();};

void()	player_dieb1	=	[	$deathb1,	player_dieb2	] {};
void()	player_dieb2	=	[	$deathb2,	player_dieb3	] {};
void()	player_dieb3	=	[	$deathb3,	player_dieb4	] {};
void()	player_dieb4	=	[	$deathb4,	player_dieb5	] {};
void()	player_dieb5	=	[	$deathb5,	player_dieb6	] {};
void()	player_dieb6	=	[	$deathb6,	player_dieb7	] {};
void()	player_dieb7	=	[	$deathb7,	player_dieb8	] {};
void()	player_dieb8	=	[	$deathb8,	player_dieb9	] {};
void()	player_dieb9	=	[	$deathb9,	player_dieb9	] {PlayerDead();};

void()	player_diec1	=	[	$deathc1,	player_diec2	] {};
void()	player_diec2	=	[	$deathc2,	player_diec3	] {};
void()	player_diec3	=	[	$deathc3,	player_diec4	] {};
void()	player_diec4	=	[	$deathc4,	player_diec5	] {};
void()	player_diec5	=	[	$deathc5,	player_diec6	] {};
void()	player_diec6	=	[	$deathc6,	player_diec7	] {};
void()	player_diec7	=	[	$deathc7,	player_diec8	] {};
void()	player_diec8	=	[	$deathc8,	player_diec9	] {};
void()	player_diec9	=	[	$deathc9,	player_diec10	] {};
void()	player_diec10	=	[	$deathc10,	player_diec11	] {};
void()	player_diec11	=	[	$deathc11,	player_diec12	] {};
void()	player_diec12	=	[	$deathc12,	player_diec13	] {};
void()	player_diec13	=	[	$deathc13,	player_diec14	] {};
void()	player_diec14	=	[	$deathc14,	player_diec15	] {};
void()	player_diec15	=	[	$deathc15,	player_diec15 ] {PlayerDead();};

void()	player_died1	=	[	$deathd1,	player_died2	] {};
void()	player_died2	=	[	$deathd2,	player_died3	] {};
void()	player_died3	=	[	$deathd3,	player_died4	] {};
void()	player_died4	=	[	$deathd4,	player_died5	] {};
void()	player_died5	=	[	$deathd5,	player_died6	] {};
void()	player_died6	=	[	$deathd6,	player_died7	] {};
void()	player_died7	=	[	$deathd7,	player_died8	] {};
void()	player_died8	=	[	$deathd8,	player_died9	] {};
void()	player_died9	=	[	$deathd9,	player_died9	] {PlayerDead();};

void()	player_diee1	=	[	$deathe1,	player_diee2	] {};
void()	player_diee2	=	[	$deathe2,	player_diee3	] {};
void()	player_diee3	=	[	$deathe3,	player_diee4	] {};
void()	player_diee4	=	[	$deathe4,	player_diee5	] {};
void()	player_diee5	=	[	$deathe5,	player_diee6	] {};
void()	player_diee6	=	[	$deathe6,	player_diee7	] {};
void()	player_diee7	=	[	$deathe7,	player_diee8	] {};
void()	player_diee8	=	[	$deathe8,	player_diee9	] {};
void()	player_diee9	=	[	$deathe9,	player_diee9	] {PlayerDead();};

void()	player_die_ax1	=	[	$axdeth1,	player_die_ax2	] {};
void()	player_die_ax2	=	[	$axdeth2,	player_die_ax3	] {};
void()	player_die_ax3	=	[	$axdeth3,	player_die_ax4	] {};
void()	player_die_ax4	=	[	$axdeth4,	player_die_ax5	] {};
void()	player_die_ax5	=	[	$axdeth5,	player_die_ax6	] {};
void()	player_die_ax6	=	[	$axdeth6,	player_die_ax7	] {};
void()	player_die_ax7	=	[	$axdeth7,	player_die_ax8	] {};
void()	player_die_ax8	=	[	$axdeth8,	player_die_ax9	] {};
void()	player_die_ax9	=	[	$axdeth9,	player_die_ax9	] {PlayerDead();};

void()	deadStand	=	[	$deatha11,	player_stand1 ] {};
