$cd id1/models/fish
$origin 0 0 24
$base base		
$skin skin

$frame attack1 attack2 attack3 attack4 attack5 attack6 
$frame attack7 attack8 attack9 attack10 attack11 attack12 attack13 
$frame attack14 attack15 attack16 attack17 attack18 

$frame death1 death2 death3 death4 death5 death6 death7 
$frame death8 death9 death10 death11 death12 death13 death14 death15 
$frame death16 death17 death18 death19 death20 death21 

$frame swim1 swim2 swim3 swim4 swim5 swim6 swim7 swim8 
$frame swim9 swim10 swim11 swim12 swim13 swim14 swim15 swim16 swim17 
$frame swim18 

$frame pain1 pain2 pain3 pain4 pain5 pain6 pain7 pain8 
$frame pain9 

//void() swimmonster_start;
/*
void() f_stand1  =[      $swim1, f_stand2 ] {};
void() f_stand2  =[      $swim2, f_stand3 ] {};
void() f_stand3  =[      $swim3, f_stand4 ] {};
void() f_stand4  =[      $swim4, f_stand5 ] {};
void() f_stand5  =[      $swim5, f_stand6 ] {};
void() f_stand6  =[      $swim6, f_stand7 ] {};
void() f_stand7  =[      $swim7, f_stand8 ] {};
void() f_stand8  =[      $swim8, f_stand9 ] {};
void() f_stand9  =[      $swim9, f_stand10  ] {};
void() f_stand10 =[      $swim10, f_stand11 ] {};
void() f_stand11 =[      $swim11, f_stand12 ] {};
void() f_stand12 =[      $swim12, f_stand13 ] {};
void() f_stand13 =[      $swim13, f_stand14 ] {};
void() f_stand14 =[      $swim14, f_stand15 ] {};
void() f_stand15 =[      $swim15, f_stand16 ] {};
void() f_stand16 =[      $swim16, f_stand17 ] {};
void() f_stand17 =[      $swim17, f_stand18 ] {};
void() f_stand18 =[      $swim18, f_stand1 ] {};

void() f_walk1  =[      $swim1, f_walk2 ] {};
void() f_walk2  =[      $swim2, f_walk3 ] {};
void() f_walk3  =[      $swim3, f_walk4 ] {};
void() f_walk4  =[      $swim4, f_walk5 ] {};
void() f_walk5  =[      $swim5, f_walk6 ] {};
void() f_walk6  =[      $swim6, f_walk7 ] {};
void() f_walk7  =[      $swim7, f_walk8 ] {};
void() f_walk8  =[      $swim8, f_walk9 ] {};
void() f_walk9  =[      $swim9, f_walk10  ] {};
void() f_walk10 =[      $swim10, f_walk11 ] {};
void() f_walk11 =[      $swim11, f_walk12 ] {};
void() f_walk12 =[      $swim12, f_walk13 ] {};
void() f_walk13 =[      $swim13, f_walk14 ] {};
void() f_walk14 =[      $swim14, f_walk15 ] {};
void() f_walk15 =[      $swim15, f_walk16 ] {};
void() f_walk16 =[      $swim16, f_walk17 ] {};
void() f_walk17 =[      $swim17, f_walk18 ] {};
void() f_walk18 =[      $swim18, f_walk1 ] {};

void() f_run1  =[      $swim1, f_run2 ] {};
void() f_run2  =[      $swim3, f_run3 ] {};
void() f_run3  =[      $swim5, f_run4 ] {};
void() f_run4  =[      $swim7, f_run5 ] {};
void() f_run5  =[      $swim9, f_run6 ] {};
void() f_run6  =[      $swim11, f_run7 ] {};
void() f_run7  =[      $swim13, f_run8 ] {};
void() f_run8  =[      $swim15, f_run9 ] {};
void() f_run9  =[      $swim17, f_run1 ] {};

void() fish_melee =
{
	local vector	delta;
	local float 	ldmg;

	if (!self.enemy)
		return;		// removed before stroke
		
	delta = self.enemy.origin - self.origin;

	if (vlen(delta) > 60)
		return;
		
	sound (self, CHAN_VOICE, "fish/bite.wav", 1, ATTN_NORM);
	ldmg = (random() + random()) * 3;
	T_Damage (self.enemy, self, self, ldmg);
};

void() f_attack1        =[      $attack1,       f_attack2 ] {};
void() f_attack2        =[      $attack2,       f_attack3 ] {};
void() f_attack3        =[      $attack3,       f_attack4 ] {};
void() f_attack4        =[      $attack4,       f_attack5 ] {};
void() f_attack5        =[      $attack5,       f_attack6 ] {};
void() f_attack6        =[      $attack6,       f_attack7 ] {};
void() f_attack7        =[      $attack7,       f_attack8 ] {};
void() f_attack8        =[      $attack8,       f_attack9 ] {};
void() f_attack9        =[      $attack9,       f_attack10] {};
void() f_attack10       =[      $attack10,      f_attack11] {};
void() f_attack11       =[      $attack11,      f_attack12] {};
void() f_attack12       =[      $attack12,      f_attack13] {};
void() f_attack13       =[      $attack13,      f_attack14] {};
void() f_attack14       =[      $attack14,      f_attack15] {};
void() f_attack15       =[      $attack15,      f_attack16] {};
void() f_attack16       =[      $attack16,      f_attack17] {};
void() f_attack17       =[      $attack17,      f_attack18] {};
void() f_attack18       =[      $attack18,      f_run1    ] {};
*/
void() f_death1 =[      $death1,        f_death2        ] {sound (self, CHAN_VOICE, "fish/death.wav", 1, ATTN_NORM);};
void() f_death2 =[      $death2,        f_death3        ] {};
void() f_death3 =[      $death3,        f_death4        ] {};
void() f_death4 =[      $death4,        f_death5        ] {};
void() f_death5 =[      $death5,        f_death6        ] {};
void() f_death6 =[      $death6,        f_death7        ] {};
void() f_death7 =[      $death7,        f_death8        ] {};
void() f_death8 =[      $death8,        f_death9        ] {};
void() f_death9 =[      $death9,        f_death10       ] {};
void() f_death10 =[      $death10,       f_death11       ] {};
void() f_death11 =[      $death11,       f_death12       ] {};
void() f_death12 =[      $death12,       f_death13       ] {};
void() f_death13 =[      $death13,       f_death14       ] {};
void() f_death14 =[      $death14,       f_death15       ] {};
void() f_death15 =[      $death15,       f_death16       ] {};
void() f_death16 =[      $death16,       f_death17       ] {};
void() f_death17 =[      $death17,       f_death18       ] {};
void() f_death18 =[      $death18,       f_death19       ] {};
void() f_death19 =[      $death19,       f_death20       ] {};
void() f_death20 =[      $death20,       f_death21       ] {};
void() f_death21 =[      $death21,       f_death21       ] {PlayerDead();};

void() f_pain1  =[      $pain1, f_pain2 ] {};
void() f_pain2  =[      $pain2, f_pain3 ] {};
void() f_pain3  =[      $pain3, f_pain4 ] {};
void() f_pain4  =[      $pain4, f_pain5 ] {};
void() f_pain5  =[      $pain5, f_pain6 ] {};
void() f_pain6  =[      $pain6, f_pain7 ] {};
void() f_pain7  =[      $pain7, f_pain8 ] {};
void() f_pain8  =[      $pain8, f_pain9 ] {};
void() f_pain9  =[      $pain9, player_run ] {};

void()     fish_pain =
{
        if (self.invisible_finished > time) return;
// fish allways do pain frames
	f_pain1 ();
};



/*QUAKED monster_fish (1 0 0) (-16 -16 -24) (16 16 24) Ambush
*/
