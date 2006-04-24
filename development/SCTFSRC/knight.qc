/*** DEFS ***/
void() knight_chain4;
void() knight_chain5;

/*
==============================================================================

KNIGHT

==============================================================================
*/

$cd id1/models/knight
$origin 0 0 24
$base base
$skin badass3

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9

$frame runb1 runb2 runb3 runb4 runb5 runb6 runb7 runb8

//frame runc1 runc2 runc3 runc4 runc5 runc6

$frame runattack1 runattack2 runattack3 runattack4 runattack5
$frame runattack6 runattack7 runattack8 runattack9 runattack10
$frame runattack11

$frame pain1 pain2 pain3

$frame painb1 painb2 painb3 painb4 painb5 painb6 painb7 painb8 painb9
$frame painb10 painb11

//frame attack1 attack2 attack3 attack4 attack5 attack6 attack7
//frame attack8 attack9 attack10 attack11

$frame attackb1 attackb1 attackb2 attackb3 attackb4 attackb5
$frame attackb6 attackb7 attackb8 attackb9 attackb10

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8 walk9
$frame walk10 walk11 walk12 walk13 walk14

$frame kneel1 kneel2 kneel3 kneel4 kneel5

$frame standing2 standing3 standing4 standing5

$frame death1 death2 death3 death4 death5 death6 death7 death8
$frame death9 death10

$frame deathb1 deathb2 deathb3 deathb4 deathb5 deathb6 deathb7 deathb8
$frame deathb9 deathb10 deathb11




void()	knight_pain1	=[	$pain1,		knight_pain2	] {};
void()	knight_pain2	=[	$pain2,		knight_pain3	] {};
void()  knight_pain3    =[      $pain3,         knight_run      ] {};

void()  knight_painb1   =[      $painb1,        knight_painb2   ] {};
void()  knight_painb2   =[      $painb2,        knight_painb3   ] {};
void()	knight_painb3	=[	$painb3,	knight_painb4	] {};
void()	knight_painb4	=[	$painb4,	knight_painb5	] {};
void()  knight_painb5   =[      $painb5,        knight_painb6   ] {};
void()  knight_painb6   =[      $painb6,        knight_painb7   ] {};
void()  knight_painb7   =[      $painb7,        knight_painb8   ] {};
void()  knight_painb8   =[      $painb8,        knight_painb9   ] {};
void()  knight_painb9   =[      $painb9,        knight_painb10  ] {};
void()  knight_painb10  =[      $painb10,       knight_painb11  ] {};
void()  knight_painb11  =[      $painb11,       knight_run      ] {};


// easter egg clone
void() eeKnight;
void() eeKnight_think =
{
   if (self.count_count < time)
      BecomeExplosion();
   else
      eeKnight();
};

void() eeKnight = [$runattack1, eeKnight_think]
{
   if (intermission_running)
   {
      remove(self);
      return;
   }
   if (self.walkframe >= 11) self.walkframe=0;
   self.frame = $runattack1 + self.walkframe;
   self.walkframe=self.walkframe + 1;

};



// knight running
void() knight_run = [ $runb1, player_run ]
{
        if (self.walkframe >= 8)
                self.walkframe = 0;
        self.frame = $runb1 + self.walkframe;
        self.walkframe = self.walkframe + 1;
};

// knight standing
void() knight_stand = [ $stand1, player_stand1 ]
{
        if (self.walkframe >= 9)
                self.walkframe = 0;
        self.frame = $stand1 + self.walkframe;
        self.walkframe = self.walkframe + 1;
};

/*** ### Knight's Attack Frames ### ***/
void() knight_attack = [$attackb1, knight_attack2] {};
void() knight_attack2 = [$attackb2, knight_attack3] {};
void() knight_attack3 = [$attackb3, knight_attack4] {if (self.nweapon == NEW_AXE) W_FireAxe();};
void() knight_attack4 = [$attackb4, knight_attack5] {};
void() knight_attack5 = [$attackb5, knight_attack6] {};
void() knight_attack6 = [$attackb6, knight_attack7] {};
void() knight_attack7 = [$attackb7, knight_attack8] {};
void() knight_attack8 = [$attackb8, knight_attack9] {};
void() knight_attack9 = [$attackb9, knight_attack10] {};
void() knight_attack10 = [$attackb10, knight_run] {};

/*** ### Knight's Nailgun Frames ### ***/
void() knight_nail1 = [$attackb6, knight_nail2]
{
        // effects
        self.effects = self.effects | EF_MUZZLEFLASH;

        if (!self.button0) {player_run();return;}

        SuperDamageSound();
        if (self.nweapon == NEW_NAIL)
                W_FireSpikes(4);
        else if (self.nweapon == NEW_FLAME)
                W_FireFlame2(4);
        else if (self.nweapon == NEW_SUPER_NAIL)
                W_FireSuperSpikes();

        self.attack_finished = time + 0.2;
};

void() knight_nail2 = [$attackb8, knight_nail1]
{
        // effects
        self.effects = self.effects | EF_MUZZLEFLASH;

        if (!self.button0) {player_run();return;}

        SuperDamageSound();
        if (self.nweapon == NEW_NAIL)
                W_FireSpikes(-4);
        else if (self.nweapon == NEW_FLAME)
                W_FireFlame2(-4);
        else if (self.nweapon == NEW_SUPER_NAIL)
                W_FireSuperSpikes();

        self.attack_finished = time + 0.2;
};

/*** ### Knight's Lightning Frames ### ***/
void() knight_light1 = [$attackb6, knight_light2]
{
        // effects
        self.effects = self.effects | EF_MUZZLEFLASH;

        if (!self.button0) {player_run();return;}

        SuperDamageSound();
        W_FireLightning();
        self.attack_finished = time + 0.2;
};

void() knight_light2 = [$attackb8, knight_light1]
{
        // effects
        self.effects = self.effects | EF_MUZZLEFLASH;

        if (!self.button0) {player_run();return;}

        SuperDamageSound();
        W_FireLightning();
        self.attack_finished = time + 0.2;
};

/*** ### Knight's Chain Frames ### ***/
void() knight_chain1 = [$attackb7, knight_chain2] {};
void() knight_chain2 = [$attackb8, knight_chain3] {W_FireChain();};
void() knight_chain3 = [$attackb9, knight_chain3]
{
        if (!self.hook_out) {
                knight_chain5();
                return;
        }
        if (vlen(self.velocity) >= 750) {
                knight_chain4();
                return;
        }
};
void() knight_chain4 = [$deathb11, knight_chain4]
{
        if (!self.hook_out) {
                knight_chain5();
                return;
        }
        if (vlen(self.velocity) < 750) {
                knight_chain3();
                return;
        }
};
void() knight_chain5 = [$attackb10, knight_run] {};

void()     knight_pain =
{
        if (self.invisible_finished > time) return;
	sound (self, CHAN_VOICE, "knight/khurt.wav", 1, ATTN_NORM);
        if (random() < 0.5)
		knight_pain1 ();
	else
		knight_painb1 ();
	
};

//===========================================================================

/*
void()	knight_bow1	=[	$kneel1,		knight_bow2	] {ai_turn();};
void()	knight_bow2	=[	$kneel2,		knight_bow3	] {ai_turn();};
void()	knight_bow3	=[	$kneel3,		knight_bow4	] {ai_turn();};
void()	knight_bow4	=[	$kneel4,		knight_bow5	] {ai_turn();};

void()	knight_bow5	=[	$kneel5,		knight_bow5	] {ai_turn();};

void()	knight_bow6	=[	$kneel4,		knight_bow7	] {ai_turn();};
void()	knight_bow7	=[	$kneel3,		knight_bow8	] {ai_turn();};
void()	knight_bow8	=[	$kneel2,		knight_bow9	] {ai_turn();};
void()	knight_bow9	=[	$kneel1,		knight_bow10	] {ai_turn();};
void()	knight_bow10	=[	$walk1,		knight_walk1	] {ai_turn();};
*/


void()	knight_die1	=[	$death1,	knight_die2	] {};
void()	knight_die2	=[	$death2,	knight_die3	] {};
void()	knight_die3	=[	$death3,	knight_die4	] 
{self.solid = SOLID_NOT;};
void()	knight_die4	=[	$death4,	knight_die5	] {};
void()	knight_die5	=[	$death5,	knight_die6	] {};
void()	knight_die6	=[	$death6,	knight_die7	] {};
void()	knight_die7	=[	$death7,	knight_die8	] {};
void()	knight_die8	=[	$death8,	knight_die9	] {};
void()	knight_die9	=[	$death9,	knight_die10] {};
void()  knight_die10=[  $death10,       knight_die10] {PlayerDead();};


void()	knight_dieb1	=[	$deathb1,	knight_dieb2	] {};
void()	knight_dieb2	=[	$deathb2,	knight_dieb3	] {};
void()	knight_dieb3	=[	$deathb3,	knight_dieb4	] 	
{self.solid = SOLID_NOT;};
void()	knight_dieb4	=[	$deathb4,	knight_dieb5	] {};
void()	knight_dieb5	=[	$deathb5,	knight_dieb6	] {};
void()	knight_dieb6	=[	$deathb6,	knight_dieb7	] {};
void()	knight_dieb7	=[	$deathb7,	knight_dieb8	] {};
void()	knight_dieb8	=[	$deathb8,	knight_dieb9	] {};
void()	knight_dieb9	=[	$deathb9,	knight_dieb10] {};
void()	knight_dieb10 = [	$deathb10,	knight_dieb11] {};
void()  knight_dieb11 = [       $deathb11,      knight_dieb11] {PlayerDead();};

