/*
==============================================================================

SHAMBLER

==============================================================================
*/

$cd id1/models/shams
$origin 0 0 24
$base base		
$skin base

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9
$frame stand10 stand11 stand12 stand13 stand14 stand15 stand16 stand17

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 
$frame walk8 walk9 walk10 walk11 walk12

$frame	run1 run2 run3 run4 run5 run6

$frame smash1 smash2 smash3 smash4 smash5 smash6 smash7 
$frame smash8 smash9 smash10 smash11 smash12

$frame swingr1 swingr2 swingr3 swingr4 swingr5 
$frame swingr6 swingr7 swingr8 swingr9

$frame swingl1 swingl2 swingl3 swingl4 swingl5 
$frame swingl6 swingl7 swingl8 swingl9

$frame magic1 magic2 magic3 magic4 magic5 
$frame magic6 magic7 magic8 magic9 magic10 magic11 magic12

$frame pain1 pain2 pain3 pain4 pain5 pain6

$frame death1 death2 death3 death4 death5 death6 
$frame death7 death8 death9 death10 death11

// shambler standing
void() eeSham;
void() eeSham_think =
{
   if (self.count_count < time)
      BecomeExplosion();
   else
      eeSham();
};

void() eeSham = [$stand1, eeSham_think]
{
   if (intermission_running)
   {
      remove(self);
      return;
   }
   // if (self.walkframe >= 17) self.walkframe=0;
   // self.frame = $stand1 + self.walkframe;

   if (self.walkframe >= 12) self.walkframe=0;
   self.frame = $smash1 + self.walkframe;

   self.walkframe=self.walkframe + 1;

   // sound (self, CHAN_BODY, "shambler/melee1.wav", 1, ATTN_NORM);
   // sound (self, CHAN_BODY, "shambler/sidle.wav", 1, ATTN_NORM);
   // sound (self, CHAN_BODY, "shambler/sdeath.wav", 1, ATTN_NORM);
   // sound(self, CHAN_BODY, "shambler/sboom.wav", 1, ATTN_NORM);
};

void() testSham;
void() testSham_think =
{
      testSham();
};
void() testSham = [$stand1, testSham_think]
{
   if (intermission_running)
   {
      remove(self);
      return;
   }
   if (self.count_count == 0) {  // stand
      if (self.walkframe >= 17) {
         self.walkframe=0;
         self.count_count = self.count_count + 1;
         bprint("walk\n");
      }
      self.frame = $stand1 + self.walkframe;
   } else
   if (self.count_count == 1) { // walk
      if (self.walkframe >= 12) {
         self.walkframe=0;
         self.count_count = self.count_count + 1;
         bprint("run\n");
      }
      self.frame = $walk1 + self.walkframe;
   } else
   if (self.count_count == 2) { // run
      if (self.walkframe >= 6) {
         self.walkframe=0;
         self.count_count = self.count_count + 1;
         bprint("smash\n");
      }
      self.frame = $run1 + self.walkframe;
   } else
   if (self.count_count == 3) {  // smash
      if (self.walkframe >= 12) {
         self.walkframe=0;
         self.count_count = self.count_count + 1;
         bprint("swingr\n");
      }
      self.frame = $smash1 + self.walkframe;
   } else
   if (self.count_count == 4) {  //swingr
      if (self.walkframe >= 9) {
         self.walkframe=0;
         self.count_count = self.count_count + 1;
         bprint("swingl\n");
      }
      self.frame = $swingr1 + self.walkframe;
   } else
   if (self.count_count == 5) { // swingl
      if (self.walkframe >= 9) {
         self.walkframe=0;
         self.count_count = self.count_count + 1;
         bprint("magic\n");
      }
      self.frame = $swingl1 + self.walkframe;
   } else
   if (self.count_count == 6) { // magic
      if (self.walkframe >= 12) {
         self.walkframe=0;
         self.count_count = self.count_count + 1;
         bprint("pain\n");
      }
      self.frame = $magic1 + self.walkframe;
   } else
   if (self.count_count == 7) {
      if (self.walkframe >= 6) {
         self.walkframe=0;
         // self.count_count = self.count_count + 1;
         self.count_count = 6;
         bprint("death\n");
      }
      self.frame = $pain1 + self.walkframe;
   } else
   if (self.count_count == 8) {// death
      if (self.walkframe >= 6) {
         self.walkframe=0;
         self.count_count = 0;
         bprint("stand\n");
      }
      self.frame = $death1 + self.walkframe;
   } 

   self.walkframe=self.walkframe + 1;
};

// shambler standing
void() sham_stand = [$stand1, player_stand1]
{
        if (self.walkframe >= 17) self.walkframe=0;
        self.frame = $stand1 + self.walkframe;
        self.walkframe=self.walkframe + 1;
};

// shambler running
void() sham_run = [$run1, player_run]
{
        if (self.walkframe >= 6) self.walkframe=0;
        self.frame = $run1 + self.walkframe;
        self.walkframe=self.walkframe + 1;
};

/* Shambler Attack Frames */
// right arm
void() sham_attkr1 = [$swingr1, sham_attkr3] {};
void() sham_attkr2 = [$swingr2, sham_attkr3] {};
void() sham_attkr3 = [$swingr3, sham_attkr6] {};
void() sham_attkr4 = [$swingr4, sham_attkr5] {};
void() sham_attkr5 = [$swingr5, sham_attkr9] {};
void() sham_attkr6 = [$swingr6, sham_attkr7] {};
void() sham_attkr7 = [$swingr7, sham_attkr8] {};
void() sham_attkr8 = [$swingr8, sham_attkr9] {};
void() sham_attkr9 = [$swingr9, sham_run   ] {};

// left arm
void() sham_attkl1 = [$swingl1, sham_attkl3] {};
void() sham_attkl2 = [$swingl2, sham_attkl3] {};
void() sham_attkl3 = [$swingl3, sham_attkl6] {};
void() sham_attkl4 = [$swingl4, sham_attkl5] {};
void() sham_attkl5 = [$swingl5, sham_attkl9] {};
void() sham_attkl6 = [$swingl6, sham_attkl7] {};
void() sham_attkl7 = [$swingl7, sham_attkl8] {};
void() sham_attkl8 = [$swingl8, sham_attkl9] {};
void() sham_attkl9 = [$swingl9, sham_run   ] {};
void() sham_attk =
{
        if (random() < 0.5) sham_attkr1();
        else sham_attkl1();
};

// lightning
void() sham_magic1     =[      $magic1,       sham_magic2    ] {sound (self, CHAN_WEAPON, "shambler/sattck1.wav", 1, ATTN_NORM);};
void() sham_magic2     =[      $magic2,       sham_magic3    ] {};
void() sham_magic3     =[      $magic3,       sham_magic4    ] {W_FireLightning();};
void() sham_magic4     =[      $magic4,       sham_magic5    ] {W_FireLightning();};
void() sham_magic5     =[      $magic5,       sham_magic6    ] {W_FireLightning();};
void() sham_magic6     =[      $magic6,       sham_magic9    ] {W_FireLightning();};
void() sham_magic9     =[      $magic9,       sham_magic10   ] {W_FireLightning();};
void() sham_magic10    =[      $magic10,      sham_magic11   ] {W_FireLightning();};
void() sham_magic11    =[      $magic11,      sham_magic12   ] {};
void() sham_magic12    =[      $magic12,      sham_run       ] {};

void() sham_madness     =[      $magic1,       sham_madness1    ] {sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);};
void() sham_madness1     =[      $magic2,       sham_madness2    ] {};
void() sham_madness2     =[      $magic3,       sham_madness3    ] {};
void() sham_madness3     =[      $magic4,       sham_madness4    ] {};
void() sham_madness4     =[      $magic5,       sham_madness5    ] {Shield(self.origin,10);};
void() sham_madness5     =[      $magic6,       sham_madness6    ] {Shield(self.origin,10);};
void() sham_madness6     =[      $magic7,       sham_madness7   ] {Shield(self.origin,10);};
void() sham_madness7    =[      $magic8,      sham_madness8   ] {Shield(self.origin,10);};
void() sham_madness8    =[      $magic9,      sham_madness9   ] {Shield(self.origin,10);};
void() sham_madness9    =[      $magic10,      sham_madness10       ] {Shield(self.origin,10);};
void() sham_madness10     =[      $magic11,       sham_madness11    ] {Shield(self.origin,10);makevectors(self.v_angle);W_FireLavaball();self.attack_finished=time + 4;};
void() sham_madness11     =[      $magic12,       sham_run   ] {};


void() sham_pain1       =[      $pain1, sham_pain2      ] {};
void() sham_pain2       =[      $pain2, sham_pain3      ] {};
void() sham_pain3       =[      $pain3, sham_pain4      ] {};
void() sham_pain4       =[      $pain4, sham_pain5      ] {};
void() sham_pain5       =[      $pain5, sham_pain6      ] {};
void() sham_pain6       =[      $pain6, sham_run        ] {};

void() sham_pain =
{
        if (self.invisible_finished > time)
                return;

	sound (self, CHAN_VOICE, "shambler/shurt2.wav", 1, ATTN_NORM);
		
	sham_pain1 ();
};
//============================================================================

void() sham_death1      =[      $death1,       sham_death2     ] {};
void() sham_death2      =[      $death2,       sham_death3     ] {};
void() sham_death3      =[      $death3,       sham_death4     ] {};
void() sham_death4      =[      $death4,       sham_death5     ] {};
void() sham_death5      =[      $death5,       sham_death6     ] {};
void() sham_death6      =[      $death6,       sham_death7     ] {};
void() sham_death7      =[      $death7,       sham_death8     ] {};
void() sham_death8      =[      $death8,       sham_death9     ] {};
void() sham_death9      =[      $death9,       sham_death10    ] {};
void() sham_death10     =[      $death10,      sham_death11    ] {};
void() sham_death11     =[      $death11,      sham_death11    ] {PlayerDead();};

/*
void() sham_die =
{
// check for gib
	if (self.health < -60)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead ("progs/h_shams.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}

// regular death
	sound (self, CHAN_VOICE, "shambler/sdeath.wav", 1, ATTN_NORM);
	sham_death1 ();
};
*/
//============================================================================


/*QUAKED monster_shambler (1 0 0) (-32 -32 -24) (32 32 64) Ambush
*/
