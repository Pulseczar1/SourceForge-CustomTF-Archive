/*** DEFS ***/
void() zomb_chain4;
void() zomb_chain5;

/*
==============================================================================

ZOMBIE

==============================================================================
*/
$cd id1/models/zombie

$origin	0 0 24

$base base
$skin skin

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8
$frame stand9 stand10 stand11 stand12 stand13 stand14 stand15

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8 walk9 walk10 walk11
$frame walk12 walk13 walk14 walk15 walk16 walk17 walk18 walk19

$frame run1 run2 run3 run4 run5 run6 run7 run8 run9 run10 run11 run12
$frame run13 run14 run15 run16 run17 run18

$frame atta1 atta2 atta3 atta4 atta5 atta6 atta7 atta8 atta9 atta10 atta11
$frame atta12 atta13

$frame attb1 attb2 attb3 attb4 attb5 attb6 attb7 attb8 attb9 attb10 attb11
$frame attb12 attb13 attb14

$frame attc1 attc2 attc3 attc4 attc5 attc6 attc7 attc8 attc9 attc10 attc11
$frame attc12

$frame paina1 paina2 paina3 paina4 paina5 paina6 paina7 paina8 paina9 paina10
$frame paina11 paina12

$frame painb1 painb2 painb3 painb4 painb5 painb6 painb7 painb8 painb9 painb10
$frame painb11 painb12 painb13 painb14 painb15 painb16 painb17 painb18 painb19
$frame painb20 painb21 painb22 painb23 painb24 painb25 painb26 painb27 painb28

$frame painc1 painc2 painc3 painc4 painc5 painc6 painc7 painc8 painc9 painc10
$frame painc11 painc12 painc13 painc14 painc15 painc16 painc17 painc18

$frame paind1 paind2 paind3 paind4 paind5 paind6 paind7 paind8 paind9 paind10
$frame paind11 paind12 paind13

$frame paine1 paine2 paine3 paine4 paine5 paine6 paine7 paine8 paine9 paine10
$frame paine11 paine12 paine13 paine14 paine15 paine16 paine17 paine18 paine19
$frame paine20 paine21 paine22 paine23 paine24 paine25 paine26 paine27 paine28
$frame paine29 paine30

$frame cruc_1 cruc_2 cruc_3 cruc_4 cruc_5 cruc_6

//float   SPAWN_CRUCIFIED = 1;

//=============================================================================

.float inpain;

void() zombie_cruc1	=	[	$cruc_1,		zombie_cruc2	] {
if (random() < 0.1)
	sound (self, CHAN_VOICE, "zombie/idle_w2.wav", 1, ATTN_STATIC);};
void() zombie_cruc2	=	[	$cruc_2,		zombie_cruc3	] {self.nextthink = time + 0.1 + random()*0.1;};
void() zombie_cruc3	=	[	$cruc_3,		zombie_cruc4	] {self.nextthink = time + 0.1 + random()*0.1;};
void() zombie_cruc4	=	[	$cruc_4,		zombie_cruc5	] {self.nextthink = time + 0.1 + random()*0.1;};
void() zombie_cruc5	=	[	$cruc_5,		zombie_cruc6	] {self.nextthink = time + 0.1 + random()*0.1;};
void() zombie_cruc6	=	[	$cruc_6,		zombie_cruc1	] {self.nextthink = time + 0.1 + random()*0.1;};

void() zombie_stand = [$stand1, player_stand1]
{
        if (self.walkframe >= 15)
                self.walkframe = 0;
        self.frame = $stand1 + self.walkframe;
        self.walkframe = self.walkframe + 1;
};

void() zombie_run = [$run1, player_run]
{
        if (self.walkframe >= 18)
                self.walkframe = 0;
        self.frame = $run1 + self.walkframe;
        self.walkframe = self.walkframe + 1;
};

/*** ### Zombie's Nailgun Frames ### ***/
void() zomb_nail1 = [$atta11, zomb_nail2]
{
        // effects
        self.effects = self.effects | EF_MUZZLEFLASH;

        if (!self.button0)
                {player_run();return;}

        SuperDamageSound();
        if (self.nweapon == NEW_NAIL)
                W_FireSpikes(4);
        else if (self.nweapon == NEW_FLAME)
                W_FireFlame2(4);
        else if (self.nweapon == NEW_SUPER_NAIL)
                W_FireSuperSpikes();

        self.attack_finished = time + 0.2;
};

void() zomb_nail2 = [$atta13, zomb_nail1]
{
        // effects
        self.effects = self.effects | EF_MUZZLEFLASH;

        if (!self.button0)
                {player_run();return;}

        SuperDamageSound();
        if (self.nweapon == NEW_NAIL)
                W_FireSpikes(-4);
        else if (self.nweapon == NEW_FLAME)
                W_FireFlame2(-4);
        else if (self.nweapon == NEW_SUPER_NAIL)
                W_FireSuperSpikes();

        self.attack_finished = time + 0.2;
};

/*** ### Zombie's Chain Frames ### ***/
void() zomb_chain1 = [$attc9, zomb_chain2] {};
void() zomb_chain2 = [$attc10, zomb_chain3] {W_FireChain();};
void() zomb_chain3 = [$attc11, zomb_chain3]
{
        if (!self.hook_out) {zomb_chain5();return;}
        if (vlen(self.velocity) >= 750) {zomb_chain4();return;}
};

void() zomb_chain4 = [$paine11, zomb_chain4]
{
        if (!self.hook_out) {zomb_chain5();return;}
        if (vlen(self.velocity) < 750) {zomb_chain3();return;}
};
void() zomb_chain5 = [$attc12, zombie_run] {};

/*** ### Zombie's Lightning Frames ### ***/
void() zomb_light1 = [$atta11, zomb_light2]
{
        // effects
        self.effects = self.effects | EF_MUZZLEFLASH;

        if (!self.button0) {player_run();return;}

        SuperDamageSound();
        W_FireLightning();
        self.attack_finished = time + 0.2;
};

void() zomb_light2 = [$atta13, zomb_light1]
{
        // effects
        self.effects = self.effects | EF_MUZZLEFLASH;

        if (!self.button0) {player_run();return;}

        SuperDamageSound();
        W_FireLightning();
        self.attack_finished = time + 0.2;
};

/*** ### Zombie's Attack Frames ### ***/
void() zomb_att1 = [$attb8, zomb_att2] {};
void() zomb_att2 = [$attb9, zomb_att3] {};
void() zomb_att3 = [$attb10, zomb_att4] {if (self.nweapon == NEW_AXE) W_FireAxe();};
void() zomb_att4 = [$attb11, zomb_att5] {};
void() zomb_att5 = [$attb12, zomb_att6] {};
void() zomb_att6 = [$attb13, zombie_run] {};
/*
=============================================================================

ATTACKS

=============================================================================
*/

void() ZombieGrenadeTouch =
{
	if (other == self.owner)
		return;		// don't explode on owner
	if (other.takedamage)
	{
                T_Damage (other, self, self.owner, 30 );
		sound (self, CHAN_WEAPON, "zombie/z_hit.wav", 1, ATTN_NORM);
		remove (self);
		return;
	}
	sound (self, CHAN_WEAPON, "zombie/z_miss.wav", 1, ATTN_NORM);	// bounce sound
	self.velocity = '0 0 0';
	self.avelocity = '0 0 0';
        remove(self);
//        self.touch = SUB_Remove;
};

/*
================
ZombieFireGrenade
================
*/

void() ZombieFireGrenade =
{
	local	entity missile, mpuff;
	local	vector	org;

//        sound (self, CHAN_WEAPON, "zombie/z_shot1.wav", 1, ATTN_NORM);

	missile = spawn ();
	missile.owner = self;
        missile.movetype = MOVETYPE_FLY;
	missile.solid = SOLID_BBOX;

// calc org
//        org = self.origin + st_x * v_forward + st_y * v_right + (st_z - 24) * v_up;
	
// set missile speed	

        makevectors (self.v_angle);

        missile.velocity = aim(self, 1000);
        missile.velocity = missile.velocity * 900;
//        missile.velocity_z = 200;

	missile.avelocity = '3000 1000 2000';

	missile.touch = ZombieGrenadeTouch;
	
// set missile duration
	missile.nextthink = time + 2.5;
	missile.think = SUB_Remove;

        missile.classname = "zombie missile";

	setmodel (missile, "progs/zom_gib.mdl");
	setsize (missile, '0 0 0', '0 0 0');		
        setorigin (missile, self.origin + v_forward*8 + '0 0 16');
};


void() zombie_atta1             =[      $atta1,         zombie_atta2    ] {};
void() zombie_atta2             =[      $atta2,         zombie_atta4    ] {};
void() zombie_atta3             =[      $atta3,         zombie_atta4    ] {};
void() zombie_atta4             =[      $atta4,         zombie_atta6    ] {};
void() zombie_atta5             =[      $atta5,         zombie_atta6    ] {};
void() zombie_atta6             =[      $atta6,         zombie_atta8    ] {};
void() zombie_atta7             =[      $atta7,         zombie_atta10    ] {ZombieFireGrenade();};
void() zombie_atta8             =[      $atta8,         zombie_atta10    ] {ZombieFireGrenade();};
void() zombie_atta9             =[      $atta9,         zombie_atta12   ] {};
void() zombie_atta10    =[      $atta10,        zombie_atta11   ] {};
void() zombie_atta11    =[      $atta11,        zombie_atta14   ] {};
void() zombie_atta12    =[      $atta12,        zombie_atta13   ] {};
void() zombie_atta13    =[      $atta12,        zombie_atta14   ] {};
void() zombie_atta14    =[      $atta13,        zombie_run     ] {};
/*
=============================================================================

PAIN

=============================================================================
*/

void() zombie_paina1    =[      $paina1,        zombie_paina2   ] {};
void() zombie_paina2    =[      $paina2,        zombie_paina3   ] {};
void() zombie_paina3    =[      $paina3,        zombie_paina4   ] {};
void() zombie_paina4    =[      $paina4,        zombie_paina5   ] {};
void() zombie_paina5    =[      $paina5,        zombie_paina6   ] {};
void() zombie_paina6    =[      $paina6,        zombie_paina7   ] {};
void() zombie_paina7	=[	$paina7,	zombie_paina8	] {};
void() zombie_paina8	=[	$paina8,	zombie_paina9	] {};
void() zombie_paina9	=[	$paina9,	zombie_paina10	] {};
void() zombie_paina10	=[	$paina10,	zombie_paina11	] {};
void() zombie_paina11	=[	$paina11,	zombie_paina12	] {};
void() zombie_paina12   =[      $paina12,       zombie_run             ] {};

void() zombie_painb1    =[      $painb1,        zombie_painb2   ] {};
void() zombie_painb2    =[      $painb2,        zombie_painb3   ] {};
void() zombie_painb3    =[      $painb3,        zombie_painb4   ] {};
void() zombie_painb4    =[      $painb4,        zombie_painb5   ] {};
void() zombie_painb5    =[      $painb5,        zombie_painb6   ] {};
void() zombie_painb6	=[	$painb6,	zombie_painb7	] {};
void() zombie_painb7	=[	$painb7,	zombie_painb8	] {};
void() zombie_painb8	=[	$painb8,	zombie_painb9	] {};
void() zombie_painb9    =[      $painb9,        zombie_painb10  ] {};
void() zombie_painb10	=[	$painb10,	zombie_painb11	] {};
void() zombie_painb11	=[	$painb11,	zombie_painb12	] {};
void() zombie_painb12	=[	$painb12,	zombie_painb13	] {};
void() zombie_painb13	=[	$painb13,	zombie_painb14	] {};
void() zombie_painb14	=[	$painb14,	zombie_painb15	] {};
void() zombie_painb15	=[	$painb15,	zombie_painb16	] {};
void() zombie_painb16	=[	$painb16,	zombie_painb17	] {};
void() zombie_painb17	=[	$painb17,	zombie_painb18	] {};
void() zombie_painb18	=[	$painb18,	zombie_painb19	] {};
void() zombie_painb19	=[	$painb19,	zombie_painb20	] {};
void() zombie_painb20	=[	$painb20,	zombie_painb21	] {};
void() zombie_painb21	=[	$painb21,	zombie_painb22	] {};
void() zombie_painb22	=[	$painb22,	zombie_painb23	] {};
void() zombie_painb23	=[	$painb23,	zombie_painb24	] {};
void() zombie_painb24	=[	$painb24,	zombie_painb25	] {};
void() zombie_painb25   =[      $painb25,       zombie_painb26  ] {};
void() zombie_painb26	=[	$painb26,	zombie_painb27	] {};
void() zombie_painb27	=[	$painb27,	zombie_painb28	] {};
void() zombie_painb28   =[      $painb28,       zombie_run             ] {};

void() zombie_painc1    =[      $painc1,        zombie_painc2   ] {};
void() zombie_painc2	=[	$painc2,	zombie_painc3	] {};
void() zombie_painc3    =[      $painc3,        zombie_painc4   ] {};
void() zombie_painc4    =[      $painc4,        zombie_painc5   ] {};
void() zombie_painc5	=[	$painc5,	zombie_painc6	] {};
void() zombie_painc6	=[	$painc6,	zombie_painc7	] {};
void() zombie_painc7	=[	$painc7,	zombie_painc8	] {};
void() zombie_painc8	=[	$painc8,	zombie_painc9	] {};
void() zombie_painc9	=[	$painc9,	zombie_painc10	] {};
void() zombie_painc10	=[	$painc10,	zombie_painc11	] {};
void() zombie_painc11   =[      $painc11,       zombie_painc12  ] {};
void() zombie_painc12   =[      $painc12,       zombie_painc13  ] {};
void() zombie_painc13	=[	$painc13,	zombie_painc14	] {};
void() zombie_painc14	=[	$painc14,	zombie_painc15	] {};
void() zombie_painc15	=[	$painc15,	zombie_painc16	] {};
void() zombie_painc16	=[	$painc16,	zombie_painc17	] {};
void() zombie_painc17	=[	$painc17,	zombie_painc18	] {};
void() zombie_painc18   =[      $painc18,       zombie_run     ] {};

void() zombie_paind1    =[      $paind1,        zombie_paind2   ] {};
void() zombie_paind2	=[	$paind2,	zombie_paind3	] {};
void() zombie_paind3	=[	$paind3,	zombie_paind4	] {};
void() zombie_paind4	=[	$paind4,	zombie_paind5	] {};
void() zombie_paind5	=[	$paind5,	zombie_paind6	] {};
void() zombie_paind6	=[	$paind6,	zombie_paind7	] {};
void() zombie_paind7	=[	$paind7,	zombie_paind8	] {};
void() zombie_paind8	=[	$paind8,	zombie_paind9	] {};
void() zombie_paind9    =[      $paind9,        zombie_paind10  ] {};
void() zombie_paind10	=[	$paind10,	zombie_paind11	] {};
void() zombie_paind11	=[	$paind11,	zombie_paind12	] {};
void() zombie_paind12	=[	$paind12,	zombie_paind13	] {};
void() zombie_paind13   =[      $paind13,       zombie_run     ] {};

void() zombie_paine1    =[      $paine1,        zombie_paine2   ] {};
void() zombie_paine2    =[      $paine2,        zombie_paine3   ] {};
void() zombie_paine3    =[      $paine3,        zombie_paine4   ] {};
void() zombie_paine4    =[      $paine4,        zombie_paine5   ] {};
void() zombie_paine5    =[      $paine5,        zombie_paine6   ] {};
void() zombie_paine6    =[      $paine6,        zombie_paine7   ] {};
void() zombie_paine7    =[      $paine7,        zombie_paine8   ] {};
void() zombie_paine8    =[      $paine8,        zombie_paine9   ] {};
void() zombie_paine9    =[      $paine9,        zombie_paine10  ] {};
void() zombie_paine10   =[      $paine10,       zombie_paine11  ] {};
void() zombie_paine11   =[      $paine11,       zombie_paine12  ] {};
void() zombie_paine12   =[      $paine12,       zombie_run  ]{
// see if ok to stand up
//self.health = 60;
//sound (self, CHAN_VOICE, "zombie/z_idle.wav", 1, ATTN_IDLE);
//self.solid = SOLID_SLIDEBOX;
//if (!walkmove (0, 0))
//{
//        self.think = zombie_paine11;
//        self.solid = SOLID_NOT;
//        return;
//}
};
void() zombie_paine13	=[	$paine13,	zombie_paine14	] {};
void() zombie_paine14	=[	$paine14,	zombie_paine15	] {};
void() zombie_paine15	=[	$paine15,	zombie_paine16	] {};
void() zombie_paine16	=[	$paine16,	zombie_paine17	] {};
void() zombie_paine17	=[	$paine17,	zombie_paine18	] {};
void() zombie_paine18	=[	$paine18,	zombie_paine19	] {};
void() zombie_paine19	=[	$paine19,	zombie_paine20	] {};
void() zombie_paine20	=[	$paine20,	zombie_paine21	] {};
void() zombie_paine21	=[	$paine21,	zombie_paine22	] {};
void() zombie_paine22	=[	$paine22,	zombie_paine23	] {};
void() zombie_paine23	=[	$paine23,	zombie_paine24	] {};
void() zombie_paine24	=[	$paine24,	zombie_paine25	] {};
void() zombie_paine25   =[      $paine25,       zombie_paine26  ] {};
void() zombie_paine26   =[      $paine26,       zombie_paine27  ] {};
void() zombie_paine27   =[      $paine27,       zombie_paine28  ] {};
void() zombie_paine28   =[      $paine28,       zombie_paine29  ] {};
void() zombie_paine29	=[	$paine29,	zombie_paine30	] {};
void() zombie_paine30   =[      $paine30,       zombie_run             ] {};

/*
=================
zombie_pain

Zombies can only be killed (gibbed) by doing 60 hit points of damage
in a single frame (rockets, grenades, quad shotgun, quad nailgun).

A hit of 25 points or more (super shotgun, quad nailgun) will allways put it
down to the ground.

A hit of from 10 to 40 points in one frame will cause it to go down if it
has been twice in two seconds, otherwise it goes into one of the four
fast pain frames.

A hit of less than 10 points of damage (winged by a shotgun) will be ignored.

FIXME: don't use pain_finished because of nightmare hack
=================
*/
void() zombie_pain =
{
	local float r;

        if (self.invisible_finished > time) return;

//        self.health = 60;               // allways reset health

//        if (take < 9)
//                return;                         // totally ignore

//        if (self.inpain == 2)
//                return;                 // down on ground, so don't reset any counters

// go down immediately if a big enough hit
//        if (take >= 25)
//        {
//                self.inpain = 2;
//                zombie_paine1 ();
//              return;
//        }
	
//        if (self.inpain)
//        {
// if hit again in next gre seconds while not in pain frames, definately drop
//                self.pain_finished = time + 3;
//                return;                 // currently going through an animation, don't change
//        }
	
//        if (self.pain_finished > time)
//        {
// hit again, so drop down
//                self.inpain = 2;
//                zombie_paine1 ();
//                return;
//        }

// gp into one of the fast pain animations	
//        self.inpain = 1;

        sound (self, CHAN_VOICE, "zombie/z_pain.wav", 1, ATTN_NORM);
	r = random();
        if (r < 0.2)
		zombie_paina1 ();
        else if (r <  0.4)
		zombie_painb1 ();
        else if (r <  0.6)
		zombie_painc1 ();
        else if (r < 0.8)
		zombie_paind1 ();
        else if (r < 1)
                zombie_paine1 ();
};
