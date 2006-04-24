void() HoundThink;
void() HoundAttack;
/*
==============================================================================

DOG

==============================================================================
*/
$cd id1/models/dog
$origin 0 0 24
$base base
$skin skin

$frame attack1 attack2 attack3 attack4 attack5 attack6 attack7 attack8

$frame death1 death2 death3 death4 death5 death6 death7 death8 death9

$frame deathb1 deathb2 deathb3 deathb4 deathb5 deathb6 deathb7 deathb8
$frame deathb9

$frame pain1 pain2 pain3 pain4 pain5 pain6

$frame painb1 painb2 painb3 painb4 painb5 painb6 painb7 painb8 painb9 painb10
$frame painb11 painb12 painb13 painb14 painb15 painb16

$frame run1 run2 run3 run4 run5 run6 run7 run8 run9 run10 run11 run12

$frame leap1 leap2 leap3 leap4 leap5 leap6 leap7 leap8 leap9

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8


//void() dog_leap1;
//void() dog_run1;

/*
================
dog_bite

================
*/
/*
void() dog_bite =
{
        local vector    delta;
        local float     ldmg;

	if (!self.enemy)
		return;

//        ai_charge(10);
        makevectors(self.v_angle);
        traceline(self.origin + '0 0 16', self.origin + '0 0 16' + v_forward*64, FALSE, self);

	if (!CanDamage (self.enemy, self))
		return;

	delta = self.enemy.origin - self.origin;

	if (vlen(delta) > 100)
		return;
		
	ldmg = (random() + random() + random()) * 8;
        T_Damage (trace_ent, self, self, ldmg);
};

void()	Dog_JumpTouch =
{
	local	float	ldmg;

	if (self.health <= 0)
		return;
		
	if (other.takedamage)
	{
		if ( vlen(self.velocity) > 300 )
		{
			ldmg = 10 + 10*random();
			T_Damage (other, self, self, ldmg);	
		}
	}

	if (!checkbottom(self))
	{
		if (self.flags & FL_ONGROUND)
		{	// jump randomly to not get hung up
//dprint ("popjump\n");
	self.touch = SUB_Null;
	self.think = dog_leap1;
	self.nextthink = time + 0.1;

//			self.velocity_x = (random() - 0.5) * 600;
//			self.velocity_y = (random() - 0.5) * 600;
//			self.velocity_z = 200;
//			self.flags = self.flags - FL_ONGROUND;
		}
		return;	// not on ground yet
	}

	self.touch = SUB_Null;
	self.think = dog_run1;
	self.nextthink = time + 0.1;
};


void() dog_stand1       =[      $stand1,        dog_stand2      ] {};
void() dog_stand2       =[      $stand2,        dog_stand3      ] {};
void() dog_stand3       =[      $stand3,        dog_stand4      ] {};
void() dog_stand4       =[      $stand4,        dog_stand5      ] {};
void() dog_stand5       =[      $stand5,        dog_stand6      ] {};
void() dog_stand6       =[      $stand6,        dog_stand7      ] {};
void() dog_stand7       =[      $stand7,        dog_stand8      ] {};
void() dog_stand8       =[      $stand8,        dog_stand9      ] {};
void() dog_stand9       =[      $stand9,        dog_stand1      ] {};

void() dog_walk1	=[	$walk1 ,	dog_walk2	] {};
void() dog_walk2        =[      $walk2 ,        dog_walk3       ] {};
void() dog_walk3        =[      $walk3 ,        dog_walk4       ] {};
void() dog_walk4        =[      $walk4 ,        dog_walk5       ] {};
void() dog_walk5        =[      $walk5 ,        dog_walk6       ] {};
void() dog_walk6        =[      $walk6 ,        dog_walk7       ] {};
void() dog_walk7        =[      $walk7 ,        dog_walk8       ] {};
void() dog_walk8        =[      $walk8 ,        dog_walk1       ] {};

void() dog_run1		=[	$run1  ,	dog_run2	] {};
void() dog_run2         =[      $run2  ,        dog_run3        ] {};
void() dog_run3         =[      $run3  ,        dog_run4        ] {};
void() dog_run4         =[      $run4  ,        dog_run5        ] {};
void() dog_run5         =[      $run5  ,        dog_run6        ] {};
void() dog_run6         =[      $run6  ,        dog_run7        ] {};
void() dog_run7         =[      $run7  ,        dog_run8        ] {};
void() dog_run8         =[      $run8  ,        dog_run9        ] {};
void() dog_run9         =[      $run9  ,        dog_run10       ] {};
void() dog_run10        =[      $run10  ,       dog_run11       ] {};
void() dog_run11        =[      $run11  ,       dog_run12       ] {};
void() dog_run12        =[      $run12  ,       dog_run1        ] {};*/

void() dog_atta1        =[      $attack1,       dog_atta2       ] {};
void() dog_atta2        =[      $attack2,       dog_atta3       ] {};
void() dog_atta3        =[      $attack3,       dog_atta4       ] {};
void() dog_atta4        =[      $attack4,       dog_atta5       ] {W_FireAxe();};
void() dog_atta5        =[      $attack5,       dog_atta6       ] {};
void() dog_atta6        =[      $attack6,       dog_atta7       ] {};
void() dog_atta7        =[      $attack7,       dog_atta8       ] {};
void() dog_atta8        =[      $attack8,       player_run      ] {};

void() dog_howl = [$attack5, dog_howl]
{
        if (self.time_count < time) {
                player_run();
                return;
        }
};

/*
void() dog_leap1        =[      $leap1,         dog_leap2       ] {};
void() dog_leap2	=[	$leap2,		dog_leap3	]
{
	self.touch = Dog_JumpTouch;
	makevectors (self.angles);
	self.origin_z = self.origin_z + 1;
	self.velocity = v_forward * 300 + '0 0 200';
	if (self.flags & FL_ONGROUND)
		self.flags = self.flags - FL_ONGROUND;
};

void() dog_leap3	=[	$leap3,		dog_leap4	] {};
void() dog_leap4	=[	$leap4,		dog_leap5	] {};
void() dog_leap5	=[	$leap5,		dog_leap6	] {};
void() dog_leap6	=[	$leap6,		dog_leap7	] {};
void() dog_leap7	=[	$leap7,		dog_leap8	] {};
void() dog_leap8	=[	$leap8,		dog_leap9	] {};
void() dog_leap9        =[      $leap9,         dog_leap9       ] {};*/

void() dog_stand = [$stand1, player_stand1]
{
        if (self.walkframe >= 9)
                self.walkframe = 0;
        self.frame = $stand1 + self.walkframe;
        self.walkframe = self.walkframe + 1;
};

void() dog_run = [$run1, player_run]
{
        if (self.walkframe >= 12)
                self.walkframe = 0;
        self.frame = $run1 + self.walkframe;
        self.walkframe = self.walkframe + 1;
};


void() dog_pain1	=[	$pain1 ,	dog_pain2	] {};
void() dog_pain2	=[	$pain2 ,	dog_pain3	] {};
void() dog_pain3	=[	$pain3 ,	dog_pain4	] {};
void() dog_pain4	=[	$pain4 ,	dog_pain5	] {};
void() dog_pain5	=[	$pain5 ,	dog_pain6	] {};
void() dog_pain6        =[      $pain6 ,        player_run      ] {};

void() dog_painb1	=[	$painb1 ,	dog_painb2	] {};
void() dog_painb2	=[	$painb2 ,	dog_painb3	] {};
void() dog_painb3       =[      $painb3 ,       dog_painb4      ] {};
void() dog_painb4       =[      $painb4 ,       dog_painb5      ] {};
void() dog_painb5       =[      $painb5 ,       dog_painb6      ] {};
void() dog_painb6       =[      $painb6 ,       dog_painb7      ] {};
void() dog_painb7	=[	$painb7 ,	dog_painb8	] {};
void() dog_painb8       =[      $painb8 ,       dog_painb9      ] {};
void() dog_painb9	=[	$painb9 ,	dog_painb10	] {};
void() dog_painb10      =[      $painb10 ,      dog_painb11     ] {};
void() dog_painb11	=[	$painb11 ,	dog_painb12	] {};
void() dog_painb12	=[	$painb12 ,	dog_painb13	] {};
void() dog_painb13	=[	$painb13 ,	dog_painb14	] {};
void() dog_painb14	=[	$painb14 ,	dog_painb15	] {};
void() dog_painb15	=[	$painb15 ,	dog_painb16	] {};
void() dog_painb16      =[      $painb16 ,      player_run      ] {};

void() dog_pain =
{
        if (self.invisible_finished > time) return;

	sound (self, CHAN_VOICE, "dog/dpain1.wav", 1, ATTN_NORM);

	if (random() > 0.5)
		dog_pain1 ();
	else
		dog_painb1 ();
};

void() dog_die1		=[	$death1,	dog_die2	] {};
void() dog_die2		=[	$death2,	dog_die3	] {};
void() dog_die3		=[	$death3,	dog_die4	] {};
void() dog_die4		=[	$death4,	dog_die5	] {};
void() dog_die5		=[	$death5,	dog_die6	] {};
void() dog_die6		=[	$death6,	dog_die7	] {};
void() dog_die7		=[	$death7,	dog_die8	] {};
void() dog_die8		=[	$death8,	dog_die9	] {};
void() dog_die9         =[      $death9,        dog_die9        ] {PlayerDead();};

void() dog_dieb1		=[	$deathb1,	dog_dieb2	] {};
void() dog_dieb2		=[	$deathb2,	dog_dieb3	] {};
void() dog_dieb3		=[	$deathb3,	dog_dieb4	] {};
void() dog_dieb4		=[	$deathb4,	dog_dieb5	] {};
void() dog_dieb5		=[	$deathb5,	dog_dieb6	] {};
void() dog_dieb6		=[	$deathb6,	dog_dieb7	] {};
void() dog_dieb7		=[	$deathb7,	dog_dieb8	] {};
void() dog_dieb8		=[	$deathb8,	dog_dieb9	] {};
void() dog_dieb9                =[      $deathb9,       dog_dieb9       ] {PlayerDead();};


//============================================================================
void() HomeThink;

// we used to check the rune here too, but now the owner
// handles that in runeapplypowers().
float() DoggyCheck =
{
   local float tolive;
   tolive = 1;
   
   // make a sound
   if (self.classname == "doggyGuard")
   {
      if (self.enemy != world)  // must be guard dog with target
         sound (self, CHAN_WEAPON, "dog/dattack1.wav", 1, ATTN_NORM);
   }
   else if (self.classname == "doggyAttack")
   {
      sound (self, CHAN_WEAPON, "dog/dattack1.wav", 1, ATTN_NORM);
   }
   return tolive;
};

void() doggy_run1		=[	$run1  ,	doggy_run2	] 
{ 
   if (!DoggyCheck()) {
      BecomeExplosion();
   }
   else
      HomeThink(); 
};
void() doggy_run2         =[      $run2  ,        doggy_run3        ] {};
void() doggy_run3         =[      $run3  ,        doggy_run4        ] {};
void() doggy_run4         =[      $run4  ,        doggy_run5        ] {};
void() doggy_run5         =[      $run5  ,        doggy_run6        ] {};
void() doggy_run6         =[      $run6  ,        doggy_run7        ] 
{ 
   if (!DoggyCheck()) {
      BecomeExplosion();
   }
   else
      HomeThink(); 
};
void() doggy_run7         =[      $run7  ,        doggy_run8        ] {};
void() doggy_run8         =[      $run8  ,        doggy_run9        ] {};
void() doggy_run9         =[      $run9  ,        doggy_run10       ] {};
void() doggy_run10        =[      $run10  ,       doggy_run11       ] {};
void() doggy_run11        =[      $run11  ,       doggy_run12       ] {};
void() doggy_run12        =[      $run12  ,       doggy_run1        ] {};

void() doggy_stand1       =[      $stand1,        doggy_stand2      ] 
{ 
   if (!DoggyCheck()) {
      BecomeExplosion();
   }
   else
      HomeThink(); 
};
void() doggy_stand2       =[      $stand2,        doggy_stand3      ] {};
void() doggy_stand3       =[      $stand3,        doggy_stand4      ] {};
void() doggy_stand4       =[      $stand4,        doggy_stand5      ] {};
void() doggy_stand5       =[      $stand5,        doggy_stand6      ] 
{ 
   if (!DoggyCheck()) {
      BecomeExplosion();
   }
   else
      HomeThink(); 
};
void() doggy_stand6       =[      $stand6,        doggy_stand7      ] {};
void() doggy_stand7       =[      $stand7,        doggy_stand8      ] {};
void() doggy_stand8       =[      $stand8,        doggy_stand9      ] {};
void() doggy_stand9       =[      $stand9,        doggy_stand1      ] {};

void() hound_atta1        =[      $attack1,       hound_atta2       ] {};
void() hound_atta2        =[      $attack2,       hound_atta3       ] 
{
   HoundThink();
};
void() hound_atta3        =[      $attack3,       hound_atta4       ] {};
void() hound_atta4        =[      $attack4,       hound_atta5       ] {};
void() hound_atta5        =[      $attack5,       hound_atta6       ] {};
void() hound_atta6        =[      $attack6,       hound_atta7       ] 
{
   HoundThink();
};
void() hound_atta7        =[      $attack7,       hound_atta8       ] {};
void() hound_atta8        =[      $attack8,       hound_atta1      ] {};


void() hound_run1		=[	$run1  ,	hound_run2	] {};
void() hound_run2         =[      $run2  ,        hound_run3        ] 
{ 
   HoundThink(); 
};
void() hound_run3         =[      $run3  ,        hound_run4        ] {};
void() hound_run4         =[      $run4  ,        hound_run5        ] {};
void() hound_run5         =[      $run5  ,        hound_run6        ] {};
void() hound_run6         =[      $run6  ,        hound_run7        ]
{ 
   HoundThink(); 
};
void() hound_run7         =[      $run7  ,        hound_run8        ] {};
void() hound_run8         =[      $run8  ,        hound_run9        ] {};
void() hound_run9         =[      $run9  ,        hound_run10       ] {};
void() hound_run10        =[      $run10  ,       hound_run11       ] 
{ 
   HoundThink(); 
};
void() hound_run11        =[      $run11  ,       hound_run12       ] {};
void() hound_run12        =[      $run12  ,       hound_run1        ] {};


void() hound_stand1       =[      $stand1,        hound_stand2      ] {};
void() hound_stand2       =[      $stand2,        hound_stand3      ] {};
void() hound_stand3       =[      $stand3,        hound_stand4      ]
{ 
   HoundThink(); 
};
void() hound_stand4       =[      $stand4,        hound_stand5      ] {};
void() hound_stand5       =[      $stand5,        hound_stand6      ] {};
void() hound_stand6       =[      $stand6,        hound_stand7      ] {};
void() hound_stand7       =[      $stand7,        hound_stand8      ] 
{ 
   HoundThink(); 
};
void() hound_stand8       =[      $stand8,        hound_stand9      ] {};
void() hound_stand9       =[      $stand9,        hound_stand1      ] {};

void() hound_leap1        =[      $leap1,         hound_leap2       ] {};
void() hound_leap2	=[	$leap2,		hound_leap3	]
{
	makevectors (self.angles);
	self.origin_z = self.origin_z + 1;
	self.velocity = v_forward * 300 + '0 0 200';
	if (self.flags & FL_ONGROUND)
		self.flags = self.flags - FL_ONGROUND;

};

void() hound_leap3	=[	$leap3,		hound_leap4	] {};
void() hound_leap4	=[	$leap4,		hound_leap5	]
{
   HoundThink();
};
void() hound_leap5	=[	$leap5,		hound_leap6	] {};
void() hound_leap6	=[	$leap6,		hound_leap7	]
{
   HoundThink();
};
void() hound_leap7	=[	$leap7,		hound_leap8	] {};
void() hound_leap8	=[	$leap8,		hound_leap9	] {};
void() hound_leap9        =[      $leap9,         hound_leap9       ] 
{
   HoundThink();
};



















