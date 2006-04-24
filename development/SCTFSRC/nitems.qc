/* nitems.qc - by inferno (waije@titan.oit.umass.edu), this makes
new game "runes" and other powerups made by inferno!!  Just
notice that some powerups are called by client.qc
*/

/********************************************************************\
* How to add a new rune to sctf
* 
* settings.qc
* Add a float with the new rune no, to the CotC set.  Bump MAX_RUNES.
* 
* nitems.qc  RuneDescription()
* Add the long rune desc text, max 40 chars per line, 12 lines.
* 
* nitems.qc GetRuneNames()
* Add the short rune desc text
* 
* nitems.qc NRunesTouch()
* Add the short rune desc
* 
* nitems.qc UpdateRuneModel()
* Add the rune model
*
* Add the rune functionality as needed.
*
\********************************************************************/
 

/***DEFS***/
void ()OrganDonorNapalmThink;
void(float num_bubbles, vector bub_origin) NewBubbles;  // new bubbles
void() RemoveRaidenMove;  // removes raiden's frames
void() RemoveShadowRam;  // removes johnny cage's frames
void() RemoveKano;  // remove kano's frames
void() RemoveKang;  // remove liu kang's frames
void() W_FireHome;  // homing missiles
void() handleFlight; // by the flying runes
void() RuneApplyPowers;
//void() infrandom;  // inferno's random that gives negative numbers too!

// just for powerups, so you can get a cool effect (teleport)
void(entity ppp) TeleportEffect =
{
        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
        WriteByte (MSG_BROADCAST, TE_TELEPORT);
        WriteCoord (MSG_BROADCAST, ppp.origin_x);
        WriteCoord (MSG_BROADCAST, ppp.origin_y);
        WriteCoord (MSG_BROADCAST, ppp.origin_z);
};

// explosive effect
void(entity ppp) ExEffect =
{
        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
        WriteByte (MSG_BROADCAST, TE_EXPLOSION);
        WriteCoord (MSG_BROADCAST, ppp.origin_x);
        WriteCoord (MSG_BROADCAST, ppp.origin_y);
        WriteCoord (MSG_BROADCAST, ppp.origin_z);
};

// gets the person's current power level
string(float f)GetPowerLevel=
{
//        self.powerlevel=12;
        if(f==0)return  "\n\n\n\n\n\n\n\n\n\n\nENERGY LEVEL  ………………………………";
        if(f==1)return  "\n\n\n\n\n\n\n\n\n\n\nENERGY LEVEL  *……………………………";
        if(f==2)return  "\n\n\n\n\n\n\n\n\n\n\nENERGY LEVEL  **…………………………";
        if(f==3)return  "\n\n\n\n\n\n\n\n\n\n\nENERGY LEVEL  ***………………………";
        if(f==4)return  "\n\n\n\n\n\n\n\n\n\n\nENERGY LEVEL  ****……………………";
        if(f==5)return  "\n\n\n\n\n\n\n\n\n\n\nENERGY LEVEL  *****…………………";
        if(f==6)return  "\n\n\n\n\n\n\n\n\n\n\nENERGY LEVEL  ******………………";
        if(f==7)return  "\n\n\n\n\n\n\n\n\n\n\nENERGY LEVEL  *******……………";
        if(f==8)return  "\n\n\n\n\n\n\n\n\n\n\nENERGY LEVEL  ********…………";
        if(f==9)return  "\n\n\n\n\n\n\n\n\n\n\nENERGY LEVEL  *********………";
        if(f==10)return "\n\n\n\n\n\n\n\n\n\n\nENERGY LEVEL  **********……";
        if(f==11)return "\n\n\n\n\n\n\n\n\n\n\nENERGY LEVEL  ***********…";
        if(f==12)return "\n\n\n\n\n\n\n\n\n\n\nENERGY LEVEL  ªªªªªªªªªªªª";
//        if(f==13)return "*************-";
//        if(f==14)return "**************";
};

// set current ammo (different than W_SET)
float CHSCAM_ON;
void(entity e) Inf_SetAmmo =
{
        //if (e.items & IT_CELLS) e.currentammo = e.ammo_cells;
        //if (e.items & IT_ROCKETS) e.currentammo = e.ammo_rockets;
        //if (e.items & IT_NAILS) e.currentammo = e.ammo_nails;
        //if (e.items & IT_SHELLS) e.currentammo = e.ammo_shells;
        if (e.weapon == IT_AXE) {
                e.weaponmodel = "progs/v_axe.mdl";
                if (e.nweapon == NEW_HOOK && (teamplay & TEAM_CAPTURE_CUSTOM))
                        e.weaponmodel = "progs/v_star.mdl";
        }
        if (e.weapon == IT_SHOTGUN) e.weaponmodel = "progs/v_shot.mdl";
        if (e.weapon == IT_SUPER_SHOTGUN) e.weaponmodel = "progs/v_shot2.mdl";
        if (e.weapon == IT_NAILGUN) e.weaponmodel = "progs/v_nail.mdl";
        if (e.weapon == IT_SUPER_NAILGUN) e.weaponmodel = "progs/v_nail2.mdl";
        if (e.weapon == IT_GRENADE_LAUNCHER) e.weaponmodel = "progs/v_rock.mdl";
        if (e.weapon == IT_ROCKET_LAUNCHER) e.weaponmodel = "progs/v_rock2.mdl";
        if (e.weapon == IT_LIGHTNING) e.weaponmodel = "progs/v_light.mdl";

        // looks cheezy
        // if (e.weapon == IT_DOG_LAUNCHER) e.weaponmodel = "progs/dog.mdl";
        if (e.weapon == IT_DOG_LAUNCHER) e.weaponmodel = "";

        // chasecam, disable model in chase view
        if ((e.speed & CHSCAM_ON) || (e.runeb_rune == RUNE_WITCH &&
        self.runeb_time >= time) || (e.rune == RUNE_DISAPEAR &&
        !(e.status_flag & ITEM_SECOND_RUNE)) ||
        (e.rune == RUNE_REPTILE && (e.status_flag & ITEM_SECOND_RUNE)) ||
        (e.rune == RUNE_GHOST && !(e.status_flag & ITEM_SECOND_RUNE)) ||
        (e.rune == RUNE_ORGANDONOR && (e.status_flag & ITEM_SECOND_RUNE)) ||
        (e.rune == RUNE_WATER && !(e.status_flag & ITEM_SECOND_RUNE) &&
        (e.waterlevel)) || 
            (e.runeb_rune == RUNE_DEATH && e.runeb_time >= time) ||
            (e.runeb_rune == RUNE_ZOMBIE && e.runeb_time >= time) ||
        e.rune == RUNE_ZOMBIE || (e.rune == RUNE_POSSESSER && (e.status_flag & ITEM_SECOND_RUNE)) ||
        (e.rune == RUNE_FP) || (e.rune == RUNE_TARANTULA))
                e.weaponmodel = "";
};

// this item is the inferno teleport, very simple
void() InfTeleTouch =
{
        if(other.classname=="player") {
                if(self.inforigin) {
                        TeleportEffect(other);sound(other, CHAN_AUTO, "misc/r_tele4.wav", 1, ATTN_NORM);
                        other.origin=self.inforigin;
                        TeleportEffect(other);sound(other, CHAN_AUTO, "misc/r_tele3.wav", 1, ATTN_NORM);
                }
        }
        if(!self.inforigin)objerror("InfTeleTouch():  No inforigin set!");
};

// good for spawning message entities
void() InfMessageTouch =
{
        if (other.classname == "player" && self.count_count < time) {
                UpdatePlayerStatus(other,self.message,"\n\n\n\n\n\n\n\n\n\n\n\n","");
                sound(self, CHAN_WEAPON, "misc/talk.wav", 1, ATTN_NORM);
                self.count_count = time + 2;
        }
};

// this will randomly return a negative number too!
float() infrandom =
{
        local float rand;

        rand = random();
        if (random() < 0.5) rand = rand * -1;
        return rand;
};

// new bubbles
void(vector v) InfBubbles2 =
{
        local entity bub;

        bub=spawn();bub.classname="bubble";bub.solid=SOLID_NOT;bub.think=SUB_Remove;
        bub.nextthink=time + 2;bub.movetype=MOVETYPE_FLY;bub.velocity_z=40 + random()*50;
        bub.velocity_x=infrandom()*70;bub.velocity_y=infrandom()*70;setmodel(bub,"progs/s_bubble.spr");
        setorigin(bub,v);
};

// to get the number you want
void(vector v, float num_b) InfBubbles =
{
        while (num_b > 0) {
                InfBubbles2(v);
                num_b = num_b - 1;
        }
};

/*----------------------------------------------------------------------
  The Key Game modes

  Key 1 - Medievil gold key (Teleport Rune)
         Teleport Weapon
         Teleport Power
         
  Key 2 - Medievil silver key (Future Technology)
         JetPack
         Cloaking Mechanism         

  Key 3 - Gold keycard (Power of Armor)
         Armor
         Super Armor

  Key 4 - Strong Magic
         Jumping
         ForceField

  Key 5 - Liquid Rune
         Liquid Aid
         Bubbler

  Key 6 - Disapearance Rune
         Cloak
         Weapon Invisibility

  Key 7 - White Magic
         Mirror Damage
         Regeneration Radius

  Key 8 - Wizard Magic
         Fireball Teleporter
         Weapons
 ----------------------------------------------------------------------*/

/* ** * The one and only rune descriptions * ** */
string(float runekind) RuneDescription =
{
   if (runekind == 0)  // no rune here
           return "You need a rune to see its description!\n\n\n\n\n\n\n\n\n\n\n\n";
   if (runekind == RUNE_EARTH_MAGIC )
   return "Earth Magic (Original Set)\n\nFirst Power (Resistance):\nFrom the powers of the earth, you\nare resistant and take 1/2 damage\nthan usual.\n\nSecond Power (Firepower):\nYou have one of the earth's most\nstrongest force, fire!!  Just swing\nyour axe and you'll get a row of\nflames!\n";
   if (runekind == RUNE_BLACK_MAGIC )
   return "Black Magic (Original Set)\n\nFirst Power (Strength):  \nThis is hell for enemies, you can\ndo 2 times the damage to them!\n\nSecond Power (Flying Power):\nThis is definately magic, you can now\nmove like water, and float up!\n\n\n\n";
   if (runekind == RUNE_HELL_MAGIC )
   return "Hell Magic (Original Set)\n\nFirst Power (Haste):\nCreate hell for your enemies by\nshooting at them!!  You will\nbe able to fire two times faster (hint:\nuse rockets ! :)\n\nSecond Power (Ammo Regeneration):\nThis rune will regenerate your ammo\nfor you, for shells to cells\n\n";
   if (runekind == RUNE_ELDER_MAGIC )
   return "Elder Magic (Original Set)\n\nFirst Power (Regeneration):\nWhen you have this rune, you can\nregenerate your health by 5 up to\n150!!\n\nSecond Power (Vampirism):\nThis rune will make you act like a\nvampire!!  When you damage an enemy, you\nget their damage added to your health!\nIf you hit a teammate, you heal them!\n";
   if (runekind == RUNE_TELEPORT )
   return "Teleport Rune (Misc Set)\n\nFirst Power (Teleport weapon):\nUse your axe and a Teleporter will\ncome out!  This can do a lot of\ndamage to an enemy.\n\nSecond Power (Teleport Power):\nSwing your axe to save your location\nthen swing it again to go to that\nlocation, this is very powerful\nif you know how to use it!\n";
   if (runekind == RUNE_FUTURE )
   return "Future Rune (Misc Set)\n\nFirst Power (JetPack):\nUse your axe and you'll go\nflying in the direction your pointing\nat, this is good to get out of\ntough situations.\n\nSecond Power (Laser Gun):\nUse your shotgun and you'll shoot\nUNLIMITED lasers\n";
   if (runekind == RUNE_ARMOR )
   return "Power of Armor (Misc Set)\n\nFirst Power (Armor Regeneration):\nYou start regenerating armor, and you\nautomatically have red armor.\n\nSecond Power (Super Armor):\nYou have magic armor that won't take\nyour own damage, meaning that you\ncan't really kill yourself\n\n";
   if (runekind == RUNE_STRONG )
   return "Strong Magic (Misc Set)\n\nFirst Power (Jumping):\nGuess what, you're able to jump\ntwice as high and swim to the surface\nof a liquid two times the normal speed!\n\nSecond Power (ForceField):\nYou are currently protected by a small\nforcefield that will damage \nan enemy nearby\n";
   if (runekind == RUNE_LIQUID )
   return "Liquid Rune (Misc Set)\n\nFirst Power (Liquid Aid):\nGo into the water, and you start\nhealing yourself!\n\nSecond Power (Bubbler):\nFire shotgun and an extra\nbubble will accompany your projectile\nto add more damage.\n\n\n";
   if (runekind == RUNE_DISAPEAR )
   return "Disapearance Rune (Misc Set)\n\nFirst Power (Small-Flame):\nYou're not quite invisible, but you\nare one little flame.\n\nSecond Power (Weapon Invisibility):\nEvery projectile you shoot is invisible\n\n\n\n\n";
   if (runekind == RUNE_MIB )
   return "Men In Black Rune (Misc Set)\n\nFirst Power (Noisy Cricket):\nThe shotgun is your noisy cricket.\nEach shot causes a huge\noutburst of energy, inflicting\nsplash damage on people\nnear the explosion\n\nSecond Power (Pulsar Blaster):\nThe shotgun is this powerful\nweapon that compresses energy to\ncause a huge amount of damage\n";
   if (runekind == RUNE_FOOLISH )
   return "Foolish Rune (Confused Set)\n\nFirst Power (Flying Dumpster):\nYou can Fly! Swing your axe to fire\nexplosive corprolites out of your butt.\n\nSecond Power (Dead Man Walking):\nYou look bad! Dead, in fact.\nBut you can still crawl around\nand fire your weapons.  \nGreat for camping.\n";
   if (runekind == RUNE_WHITE_MAGIC )
   return "White Magic (Medieval Set)\n\nFirst Power (Mirror Damage):\nPeople are damaged for shooting you.\nThey take 1/2 the damage they give to\nyou as if it was reflected on to them.\n\nSecond Power (Regeneration-Radius):\nYou can now heal yourself up to 150\npoints. And you heal team mates in\na small radius to 100 points.\n\n";
   if (runekind == RUNE_WIZARD )
   return "Wizard Magic (Medieval Set)\n\nFirst Power (Fireball Teleport):\nThis magic fireball will switch places\nwith the person you hit. If your close,\nyou will telefrag them. Uses Axe.\n\nSecond Power (Weapons):\nYour magic skills regenerate ammo for\nweapons you pick up.\n\n";
   if (runekind == RUNE_WITCH )
   return "Witch Magic (Medieval Set)\n\nFirst Power (Curse):\nYou curse someone by randomly turning\nthem into a dog! All they can do is\nbark or bite for 10 seconds. Be careful,\nthis can back fire on you!\n\nSecond Power (Protector):\nA yellow shield surrounds you, and\nflings people out of your way.\n\n";
   if (runekind == RUNE_KNIGHT )
   return "Knight (Medieval Set)\n\nFirst power (Flag Power):\nKnights are dependant on their leaders\nThe flag is your leader, so the closer\nyou are the stronger and more\nresistant you get!\n\nSecond Power (Rebel Knight):\nThe closer you are to the enemy flag,\nThe more Strong and Resistant you get.\n\n";
   if (runekind == RUNE_LUCK )
   return "Luck (Supernatural Set)\n\nFirst Power (Good Luck):\nYou have good luck and automatically\npick-up everything that is near you,\nammo, weapons, armor, etc...\n\nSecond Power (Bad Luck):\n\nGives everyone near you bad luck. They\nstart bouncing up & down, shooting at\nthe same time...bad luck for them!\n";
   if (runekind == RUNE_GHOST )
   return "Ghost (Supernatural Set)\n\nFirst Power (Ghost-Weapon):\nMakes your weapon the only thing\nvisible, But you take 50% more damage!\n\nSecond Power (Clone):\nSwing your axe to leave a clone where\nyou stand. The clone will explode when\nsomeone steps within a certain radius.\n(2 Clones Max)\n\n";
   if (runekind == RUNE_ILLUSION )
   return "Illusion (Supernatural Set)\n\nFirst Power (Huge Monster):\nTo everyone else, you look like this \nVERY BIG monster walking around\nYou can confuse people with this.\n\nSecond Power (Monster Rockets):\nYay!! You get free rockets. All your\nrockets are HUGE MONSTERS. Use your\naxe to fire your rockets.\n";
   if (runekind == RUNE_ZEUS )
   return "Zeus (Myth Set)\n\nFirst Power (Lightning Bolt):\nZeus was the god of all gods, and can\ncast a lightning bolt with every\nweapon he uses now.\n\nSecond Power (Shield):\nZeus's shield can stop projectiles 50%\nof the time. Some people might even\nkill themselfs trying to get rockets\ninside of your shield!\n";
   if (runekind == RUNE_POSEIDON )
   return "Poseidon (Myth Set)\n\nFirst Power (Trident):\nYou are given a trident (lightning gun)\nwith unlimited ammo! You regenerate in\nliquids, but take 1/5 the damage!\nWorks in water too :)\n\nSecond Power (Drown):\nWhen you shoot an enemy it will turn\nthem into a fish by random, and fish\ndrown when they're out of water.\n";
   if (runekind == RUNE_MARS )
   return "Mars (Supernatural Set)\n\nFirst Power (Strength):\nSince Mars (Aries) was the god of war,\nhe can do 4 times the damage! but\ntakes 2 times since once he got hurt\nduring battle, he chickened out.\n\nSecond Power (Firenemy Curse):\nYou damage someone and you may curse\nthem, which means they will start\njumping out of control.\n";
   if (runekind == RUNE_HERMES )
   return "Hermes (Myth Set)\n\nFirst Power (Flight):\nHermes was a messenger,\nwith the power of flight\nhe can travel at great speeds\n\nSecond Power (Trickiness):\nHermes can disappear into the shadows.\nBut when he shoots, people can see him.\nIt's only for a few seconds, so hide\nwell.\n";
   if (runekind == RUNE_ARTEMIS )
   return "Artemis (Myth Set)\n\nFirst Power (Guard Dog):\nSwing your axe and set a vicious dog \nto stand guard for you!\n\nSecond Power (Attack Dog):\nSwing your axe and loose a Dog to \ntrack down and kill the enemy!\n\n\n\n";
   if (runekind == RUNE_DEMETER )
   return "Demeter (Myth Set)\n\nFirst Power (Trapped in Soda Bubbles):\nGet Perforator and shoots out bubbles\ninstead of nails. These can trap people\nand make them swim around in the bubble.\n\nSecond Power (Drunkenness):\nPlayers around you will get drunk, if \nthe player is enemy it will take away\nfrom their health.\n\n";
   if (runekind == RUNE_COP )
   return "Cop (Present Set)\n\nFirst Power (Arrest):\nWhen you shoot your enemy it randomly\narrests or takes away their weapons\nfor a small amount of time\n\nSecond Power (Bullet Proof Vest):\nLike resistance, you take a smaller\namount of damage, and it gives off\nthe effect that metal is flying\noff your jacket.\n";
   if (runekind == RUNE_NAVY_OFFICER )
   return "Navy Officer (Present Set)\n\nFirst Power (Rocket Regeneration):\nYour a navy officer so you get a\na grenade launcher, rocket launcher,\nand regenerating ammo! BUT all that\nheavy equipment will make you slower\n\nSecond Power (Maximum Power):\nSwing your axe to shoot a huge party\nof rockets! Don't stand too close\nto any objects!\n";
   if (runekind == RUNE_FPILOT )
   return "Fighter Pilot <flight> (Present Set)\n\nFirst Power (Target Missiles):\nUNLIMITED homing missiles! use your\nfree rocket launcher,\n and your rockets will \nhome in on the enemy!\n\nSecond Power (Machine gun):\nYour super nailgun now shoots \nunlimited small rockets\nthat do more damage then nails.\n";
   if (runekind == RUNE_CWORKER )
   return "Construction Worker (Present Set 2)\n\nFirst Power (Drill):\nGives you Thunderbolt and regenerates\ncells. When you fire, a Megabolt comes\nout and does Mega damage to enemies!\n\nSecond Power (Torch):\nUse your shotgun to shoot bubbles\nout at a very rapid pace. Ammo is\nunlimited and does a fair amount\nof damage\n";
   if (runekind == RUNE_SUBZERO )
   return "Sub Zero (Mortal Kombat Set)\n\nFirst Power (Freeze):\nAny weapon you shoot will shoot out a\nsmall bubble, Which at random will\nfreeze the enemy. \n\nSecond Power (Cold Clone):\nSwing your axe and you will leave a\nclone where you stand! Anyone that\ncomes near it will freeze for a while\n  allowing an easy gib for you!\n";
   if (runekind == RUNE_RAIDEN )
   return "Raiden (Mortal Kombat Set)\n\nFirst Power (Lightning):\nGives You lightning gun with \nregenerating ammo. When you damage an\nenemy with it they will go flying!\n\nSecond Power (Superman Move):\nSwing your axe to fly like superman.\nWhen you hit an enemy they get \ndamaged and go the speed your flying!\n";
   if (runekind == RUNE_JOHNNY_CAGE )
   return "Johnny Cage (Mortal Kombat Set)\n\nFirst Power (Shadow-Ram):\nJonny Cage can use his body as a\nweapon and throw himself at enemies!\nThe Axe also triggers this attack.\n\nSecond Power (Green Fireball):\nUse your axe to throw a Green Fireball\nit will bounce around and explode\nafter a few seconds.\n\n";
   if (runekind == RUNE_KANO )
   return "Kano (Mortal Kombat Set)\n\nFirst Power (Knife):\nSwing your axe to throw out your\nGlowing Knife, it will bounce around\nand explode after a while.\n\nSecond Power (Cannonball):\nSwing your axe to curl up in a ball\nand cannonball your enemies. Great\nwith Quad Damage!\n\n";
   if (runekind == RUNE_KANG )
   return "Liu Kang (Mortal Kombat Set)\n\nFirst Power (Fireball):\nMakes a fireball come out when you\nshoot any of your weapons. Giving you\na chance to catch the enemy on fire!\n\nSecond Power (Flying Kick):\nSwing your axe and you will do a\nflying kick and damage your enemy\nimmensely if you hit them.\n\n";
   if (runekind == RUNE_REPTILE )
   return "Reptile (Mortal Kombat II Set)\n\nFirst Power (Acid):\nWhen you shoot any weapon you will\nspit out acid, which will burn any\nenemies hit.\n\nSecond Power (Invisibility):\nMakes you completely invisible to\neveryone! one drawback though, You\ntake twice as much damage.\n\n";
   // if (runekind == RUNE_LAO )
   // return "Kung Lao (Mortal Kombat II Set)\n\nFirst Power (Head Throw):Shoots out Flaming head with every\nshot, causing greater damage.\n\nSecond Power (Whirlwind Spin):\nSwing your axe to Swing a lightning\nbolt around, causing enemies to fly\nupwards and get damaged when the come\nin contact with it.\n\n";
   if (runekind == RUNE_TSUNG )
   return "Shang Tsung (Mortal Kombat II Set)\n\nFirst Power (Fireballs):\nSwing your axe to throw a huge amount\nof fireballs in the direction your\nfacing. enemies may even catch on fire\nif hit!\n\nSecond Power (Morph):\nSwing your axe and you will morph into\na random Mortal Kombat character for\na few seconds!\n";
   if (runekind == RUNE_PORTAL_MASTER )
   return "Portal Master (Mortal Kombat II Set)\n\nFirst Power (Portal):\nSwing your axe to open up a portal\nthat once walked through will warp you\nto a random part of the map. You can\ncome back through it also.\n\nSecond Power (Speed):\nMakes you run very fast! Which will\nhelp you in many ways, BUT it is hard\nto control!\n";
   if (runekind == RUNE_SEKTOR )
   return "Sektor (Mortal Kombat III Set)\n\nFirst Power (Homing missile):\nSwing your axe to throw UNLIMITED,\nslow moving, heat seeking missiles!\n(2 at a time max!)\n\nSecond Power (TelePunch):\nSwing your axe,and you will\nTeleport to the nearest player\nand punch them severely!\nThey must be within 30 feet of you.\n\n";
   if (runekind == RUNE_SMOKE )
   return "Smoke (Mortal Kombat III Set)\n\nFirst Power (Harpoon):\nGrapple into an enemy and instead of\nyou going to them, they come to you!\n\nSecond Power (Smoke Block):\nUse any weapon to damage an enemy and\nyou will randomly place a large shroud\nin front of them making it very hard\nfor them to see\n(Be Careful it can backfire on you!)\n";
   if (runekind == RUNE_KINTARO )
   return "Kintaro (Mortal Kombat Misc Set)\n\nFirst Power (Four Axe-Power):\nThis ones pretty self explanatory, \njust swing your axe and it has four\ntimes the power.\n\nSecond Power (Combo):\nGives you a grenade launcher with\nregenerating ammo, when fired shoots\na grenade as well as a rocket.\n(A campers dream!)\n";
   if (runekind == RUNE_WEREWOLF )
   return "Werewolf (Darkages Set)\n\nFirst Power (Speed-Bite):\nYou are faster and you bite people\nwhen they get too close to you.\n\nSecond Power (Howl):\nUse your axe to use the healing power\nWarewolf's have. You will also scare\neveryone to the ceilings!\nHAHAHAHAHA!!\n\n";
   if (runekind == RUNE_DRAGON )
   return "Dragon (Darkages Set)\n\nFirst Power (Flight):\nHey some Dragons Flew, and now\nso can you!\n\nSecond Power (Fire):\nAll your weapons shoot fire out as\nwell as the regular projectile. If\nyour lucky you will catch enemies\non fire!\n\n";
   if (runekind == RUNE_ZOMBIE )
   return "Zombie (Darkages Set)\n\nFirst Power (Immunity):\nHit an enemy, and there is a random\nchance that you will turn them into\na zombie. All they can do is throw\nGibs back at you.\n\nSecond Power (Gibfest):\nUse your axe to throw flaming gibs.\nThese do a lot of damage, and can send\npeople flying backwards.\n";
   if (runekind == RUNE_VAMPIRE )
   return "Vampire (Darkages Set)\n\nFirst Power (Vampire Bat):\nYou are a blood sucking bat. You can\nfly, and each enemy you shoot, you\nsuck the life from, and add it to you.\n\nSecond Power (Vampire Vemon):\nYou are infected with poison. Your\nSuper Nail Gun will now shoot venom\nand regenerate nails.\n\n";
   if (runekind == RUNE_FP )
   return "Frankensteins Pet (Darkages Set)\n\nFirst Power (Lightning bolt):\nSwing your axe to throw a lightning\nbolt at your enemies.\n\nSecond Power (Lavaball):\nShoot unlimited Lavaballs when you\nswing your axe. Be sure to to stand\ntoo close though!\n\n\n";
   if (runekind == RUNE_WATER )
   return "Water (Earth Set)\n\nFirst Power (Water Aid):\nWhen your in water, you are totally\ninvisible, while regenerating health.\n\nSecond Power (Bring Water):\nYou can now take that healing water\nwith you. And now when people are near\nyou, the move as if there were in water.\n\n\n";
   if (runekind == RUNE_LIFE )
   return "Life (Earth Set)\n\nFirst Power (Life Power):\nWhen you Die you will respawn in the\nsame exact spot, thus giving you a\nsecond chance at life. You weapons\nare also more powerful then normal.\n\nSecond Power (Life-Shield):\nGives you homing rockets that will\nhunt down any enemy or projectile.\n\n";
   if (runekind == RUNE_DEATH )
   return "Death (Earth Set)\n\nFirst Power (Death Power):\nThe less health you have, the more\nresistant and stronger you get.\n\nSecond Power (Zombie Creator):\nRandomly turns enemies into zombies\nwhen you damage them.\n\n\n\n";
   if (runekind == RUNE_SUPERMAN )
   return "Superman (Hero Set)\n\nFirst Power (Strength):\nAny damage you do to an enemy will be\ndoubled! Plus you get to fly!\n\nSecond Power (Resistance):\nYou will take 50% less damage!\nand of course you get to fly as well!\n\n\n\n";
   if (runekind == RUNE_PUNISHER )
   return "Punisher (Hero Set)\n\n1st Power (Dbl. Brl. Grenade Lnchr.):\nGives you a grenade launcher with\n regenerating ammo. When Fired Two\ngrenades fire at once! but the reload\ntime is twice as slow.\n\nSecond Power (Shotgun Specialist):\nLets you fire your shotgun at an\nextremely fast pace!\n\n";
   if (runekind == RUNE_SPAWN )
   return "Spawn (Hero Set 2)\n\nFirst Power (Healing):\nAutomatically will regenerate your\nhealth and armor to 150!\n\nSecond Power (Cape Protection):\nReduces the damage you take by 50%\n\n\n\n\n";
   if (runekind == RUNE_WEAPONS )
   return "Future Weapons (Future set)\n\nFirst Power (Spark Cannon):\nYour Shotgun is now a Spark Cannon.\n\nSecond Power (Controller Shield):\nYou now have a futuristic shield\naround you that blocks players off of\nyou. It will damage them too.\n\n\n";
   if (runekind == RUNE_ROBOT )
   return "Robot (Future Set)\n\nFirst Power (Strength):\nAttack an enemy and cause twice as\nmuch damage!\n\nSecond Power (Lasers):\nGives you a Super nailgun that\nregenerates ammo fairly fast. When\nfired it shoots lasers that do more\ndamage then nails!\n\n";
   if (runekind == RUNE_THUNDER )
   return "Thunder (Storm Set)\n\nFirst Power (Lightning Strike):\nYour Thunder Bolt is replaced with a\n special Lightning Rod that regens\ncells.\n\nSecond Power (Rain):\nUse your axe to launch a clone\ninto the sky. It rains acid rain\nwhich damages the enemy.\n\n";
   if (runekind == RUNE_DREAM )
   return "Dream (Imaginary Set)\n\nFirst Power (Rainbow):\nGives you a Super Nailgun that\nregenerates ammo, and shoots out\na rainbow shotgun spray.\n\n2nd Power (Double Barreled Rockets):\nSwing your axe to shoot out 2 rockets\nat the same time!\n\n\n";
   if (runekind == RUNE_NIGHTMARE )
   return "Nightmare (Imaginary Set)\n\nFirst Power (Mind Melt Power):\nAnyone near you will have their Mind\nMelted like they just got hit with the\nMind gas gun! It will damage them too!\n\nSecond Power (Clone Person):\nSwing your axe to leave a clone that\nfires rockets in whatever direction\nyou are facing. (2 Clones MAX!)\n\n";
   if (runekind == RUNE_POSSESSER )
   return "Possessor (Imaginary Set)\n\nFirst Power (Possess):\nFace a teammate and swing your axe.\nNow they are marked.\nSwitch to 2nd power.  You can return\nto your teammate when you switch\nback to possess.\n\nSecond Power (Rocketman):\nYou will become a small flying rocket\nthat is immune to all liquids!\n";
   if (runekind == RUNE_TURTLE )
   return "Turtle (Animal Set)\n\nFirst Power (Shell):\nYou have a real strong shell. If you\nHold absolutely still, and don't shoot\nall attacks will only cost 1 point\ndamage.\nSecond Power (Snapper):\nYou have a powerful Turtle Mouth, and\nwhen you swing your axe, you bite\npeople.\n";
   if (runekind == RUNE_ANT )
   return "Ant (Insect Set)\n\nFirst Power (Strong Jaw):\nYou are and ant with a strong jaw!\nSwing you axe and shoot Deadly\nPersonbombs.\n\nSecond Power (Speed):\nYour a big ant you can now move\ntwice as fast!\n\n\n";
   if (runekind == RUNE_MEDIC )
   return "Medic (CotC Set)\n\nFirst Power (Healer):\nYou have the power to heal your team,\njust by standing nearby.\nReplenishes armor too.\n\n\nSecond Power (Plague):\nAxe fires a Plague Culture. Enemies\nnearby become sick until they cure\nthemselves in liquid, or it wears off.\n";
   if (runekind == RUNE_TARANTULA )
   return "Tarantula (CotC Set)\n\nFirst Power (Poison Darts):\nYou get a nailgun with some\npoisonous darts. Hit the bad\nguys with this, they swell up.\n\n\nSecond Power (Trick-Traps):\nTarantulas are masters at tricking\ntheir enemy into consequences.\nUse your Axe to drop traps!\n";
   if (runekind == RUNE_ORGANDONOR )
   return "OrganDonor (CotC Set)\n\nFirst Power (Napalm):\nYou generate a field of fire!\nEnemies who enter this field will\nburst into flames!\n\n\nSecond Power (Cap of invisibility):\nYou are invisible except\nwhen shooting\n\n";
   if (runekind == RUNE_M4D_SK1LLZ )
   return "M4D SK1LLZ (Loser Set)\n\nFirst Power (StreetSweeper):\nYour shotgun is a deadly weapon.\nUse it.\n\nSecond Power (StreetSweeper):\nJust like the first power\n\n\n\n\n";
   else return "Sorry\nThere is no current description\nfor the rune you have!\n\n(the description hasn't been written yet!)\n\n\n\n\n\n\n\n";
};


void (entity e) GetRuneNames =
{
   // find the kind of rune (key)
   if (e.rune == RUNE_EARTH_MAGIC) {
      e.runeName = "Εαςτθ Ναηιγ   ";
      e.power1 = "Resist";
      e.power2 = "FirePower";
   } else if (e.rune == RUNE_BLACK_MAGIC) {
      e.runeName = "Βμαγλ Ναηιγ   ";
      e.power1 = "Strength";
      e.power2 = "Flight";
   } else if (e.rune == RUNE_HELL_MAGIC) {
      e.runeName = "Θεμμ Ναηιγ   ";
      e.power1 = "Haste";
      e.power2 = "AmmoRegen";
   } else if (e.rune == RUNE_ELDER_MAGIC) {
      e.runeName = "Εμδες Ναηιγ   ";
      e.power1 = "Regen";
      e.power2 = "Vampirism";
   } else if (e.rune == RUNE_TELEPORT) {
      e.runeName = "Τεμεποςτ Òυξε   ";
      e.power1 = "TeleWeapon";
      e.power2 = "TelePower";
   } else if (e.rune == RUNE_FUTURE) {
      e.runeName = "Ζυτυςε Òυξε   ";
      e.power1 = "JetPack";
      e.power2 = "LaserGun";
   } else if (e.rune == RUNE_ARMOR) {
      e.runeName = "Ποχες οζ Αςνος   ";
      e.power1 = "ArmorRegen";
      e.power2 = "SuperArmor";
   } else if (e.rune == RUNE_STRONG) {
      e.runeName = "Στςοξη Ναηιγ   ";
      e.power1 = "Jumping";
      e.power2 = "ForceField";
   } else if (e.rune == RUNE_LIQUID) {
      e.runeName = "Μιρυιδ Òυξε   ";
      e.power1 = "LiquidAid";
      e.power2 = "Bubbler";
   } else if (e.rune == RUNE_DISAPEAR) {
      e.runeName = "Δισαπεας Òυξε   ";
      e.power1 = "SmallFlame";
      e.power2 = "WeaponInvis";
   } else if (e.rune == RUNE_MIB) {
      e.runeName = "Νεξ Ιξ Βμαγλ   ";
      e.power1 = "NoisyCricket";
      e.power2 = "PulsarBlast";
   } else if (e.rune == RUNE_FOOLISH) {
      e.runeName = "Ζοομισθ       ";
      e.power1 = "FlyingDumpster";
      e.power2 = "DeadManWalking";
   } else if (e.rune == RUNE_WHITE_MAGIC) {
      e.runeName = "Χθιτε Ναηιγ   ";
      e.power1 = "MirrorDamage";
      e.power2 = "RegenRadius";
   } else if (e.rune == RUNE_WIZARD) {
      e.runeName = "Χιϊαςδ Ναηιγ   ";
      e.power1 = "Fireball";
      e.power2 = "Weapons";
   } else if (e.rune == RUNE_WITCH) {
      e.runeName = "Χιτγθ Ναηιγ   ";
      e.power1 = "Curse";
      e.power2 = "Protector";
   } else if (e.rune == RUNE_KNIGHT) {
      e.runeName = "Λξιηθτ   ";
      e.power1 = "FlagPower";
      e.power2 = "RebelKnight";
   } else if (e.rune == RUNE_LUCK) {
      e.runeName = "Μυγλ Òυξε   ";
      e.power1 = "GoodLuck";
      e.power2 = "BadLuck";
   } else if (e.rune == RUNE_GHOST) {
      e.runeName = "Ηθοστσ Òυξε   ";
      e.power1 = "GhostWweapon";
      e.power2 = "Clone";
   } else if (e.rune == RUNE_ILLUSION) {
      e.runeName = "Ιμμυσιοξ   ";
      e.power1 = "HugeMonster";
      e.power2 = "MonsterRocks";
   } else if (e.rune == RUNE_ZEUS) {
      e.runeName = "Ϊευσ   ";
      e.power1 = "Lightning";
      e.power2 = "Shield";
   } else if (e.rune == RUNE_POSEIDON) {
      e.runeName = "Ποσειδοξ   ";
      e.power1 = "Trident";
      e.power2 = "Drown";
   } else if (e.rune == RUNE_MARS) {
      e.runeName = "Ναςσ   ";
      e.power1 = "Strength";
      e.power2 = "FireCurse";
   } else if (e.rune == RUNE_HERMES) {
      e.runeName = "Θεςνεσ   ";
      e.power1 = "Flight";
      e.power2 = "Trickiness";
   } else if (e.rune == RUNE_ARTEMIS) {
      e.runeName = "Αςτενισ   ";
      e.power1 = "GuardDog";
      e.power2 = "AttackDog";
   } else if (e.rune == RUNE_DEMETER) {
      e.runeName = "Δενετες   ";
      e.power1 = "SodaBubbles";
      e.power2 = "Drunkeness";
   } else if (e.rune == RUNE_COP) {
      e.runeName = "Γοπ Òυξε   ";
      e.power1 = "Arrest";
      e.power2 = "Bulletproof";
   } else if (e.rune == RUNE_NAVY_OFFICER) {
      e.runeName = "Ξαφω Οζζιγες   ";
      e.power1 = "RocketRegen";
      e.power2 = "MaximumPower";
   } else if (e.rune == RUNE_FPILOT) {
      e.runeName = "Ζιηθτες Πιμοτ   ";
      e.power1 = "HomeRocket";
      e.power2 = "MachineGun";
   } else if (e.rune == RUNE_CWORKER) {
      e.runeName = "Γξστςγτ Χοςλες   ";
      e.power1 = "Drill";
      e.power2 = "Torch";
   } else if (e.rune == RUNE_SUBZERO) {
      e.runeName = "Συβ Ϊεςο   ";
      e.power1 = "Freeze";
      e.power2 = "ColdClone";
   } else if (e.rune == RUNE_RAIDEN) {
      e.runeName = "Òαιδεξ   ";
      e.power1 = "Lightning";
      e.power2 = "Superman";
   } else if (e.rune == RUNE_JOHNNY_CAGE) {
      e.runeName = "Κοθξξω Γαηε   ";
      e.power1 = "ShadowRam";
      e.power2 = "GreenFireball";
   } else if (e.rune == RUNE_KANO) {
      e.runeName = "Λαξο   ";
      e.power1 = "Knife";
      e.power2 = "Cannonball";
   } else if (e.rune == RUNE_KANG) {
      e.runeName = "Μιυ Λαξη   ";
      e.power1 = "Fireball";
      e.power2 = "FlyingKick";
   } else if (e.rune == RUNE_REPTILE) {
      e.runeName = "Òεπτιμε   ";
      e.power1 = "Acid";
      e.power2 = "Invisible";
   // } else if (e.rune == RUNE_LAO) {
   //    e.runeName = "Λυξη Μαο   ";
   //    e.power1 = "HeadToss";
   //    e.power2 = "Whirlwind";
   } else if (e.rune == RUNE_TSUNG) {
      e.runeName = "Σθαξη Τσυξη   ";
      e.power1 = "Fireballs";
      e.power2 = "Morph";
   } else if (e.rune == RUNE_PORTAL_MASTER) {
      e.runeName = "Ποςταμ Ναστες   ";
      e.power1 = "Portal";
      e.power2 = "Speed";
   } else if (e.rune == RUNE_SEKTOR) {
      e.runeName = "Σελτος   ";
      e.power1 = "HomeRocket";
      e.power2 = "Telepunch";
   } else if (e.rune == RUNE_SMOKE) {
      e.runeName = "Σνολε   ";
      e.power1 = "Harpoon";
      e.power2 = "SmokeHide";
   } else if (e.rune == RUNE_KINTARO) {
      e.runeName = "Λιξταςο   ";
      e.power1 = "AxePower";
      e.power2 = "Combo";
   } else if (e.rune == RUNE_WEREWOLF) {
      e.runeName = "Χεςεχομζ   ";
      e.power1 = "SpeedBite";
      e.power2 = "Howl";
   } else if (e.rune == RUNE_DRAGON) {
      e.runeName = "Δςαηοξ   ";
      e.power1 = "Flight";
      e.power2 = "Fire";
   } else if (e.rune == RUNE_ZOMBIE) {
      e.runeName = "Ϊονβιε   ";
      e.power1 = "Immunity";
      e.power2 = "Gibfest";
   } else if (e.rune == RUNE_VAMPIRE) {
      e.runeName = "Φανπιςε   ";
      e.power1 = "Flight";
      e.power2 = "Venom";
   } else if (e.rune == RUNE_FP) {
      e.runeName = "Ζςαξλιεΰσ Πετ   ";
      e.power1 = "Lightning";
      e.power2 = "Lavaball";
   } else if (e.rune == RUNE_WATER) {
      e.runeName = "Χατες   ";
      e.power1 = "WaterAid";
      e.power2 = "BringWater";
   } else if (e.rune == RUNE_LIFE) {
      e.runeName = "Μιζε   ";
      e.power1 = "LifePower";
      e.power2 = "LifeShield";
   } else if (e.rune == RUNE_DEATH) {
      e.runeName = "Δεατθ   ";
      e.power1 = "DeathPower";
      e.power2 = "Zombie";
   } else if (e.rune == RUNE_SUPERMAN) {
      e.runeName = "Συπεςναξ   ";
      e.power1 = "Strength";
      e.power2 = "Resist";
   } else if (e.rune == RUNE_PUNISHER) {
      e.runeName = "Πυξισθες   ";
      e.power1 = "DualGrenade";
      e.power2 = "ShotgunSpec";
   } else if (e.rune == RUNE_SPAWN) {
      e.runeName = "Σπαχξ   ";
      e.power1 = "Healing";
      e.power2 = "Protection";
   } else if (e.rune == RUNE_WEAPONS) {
      e.runeName = "Ζυτυςε Χεαποξσ   ";
      e.power1 = "SparkCannon";
      e.power2 = "Controller";
   } else if (e.rune == RUNE_ROBOT) {
      e.runeName = "Òοβοτ   ";
      e.power1 = "Strength";
      e.power2 = "Lasers";
   } else if (e.rune == RUNE_DREAM) {
      e.runeName = "Δςεαν   ";
      e.power1 = "Rainbow";
      e.power2 = "DualRockets";
   } else if (e.rune == RUNE_NIGHTMARE) {
      e.runeName = "Ξιηθτναςε   ";
      e.power1 = "Mind melt";
      e.power2 = "CloneMan";
   } else if (e.rune == RUNE_POSSESSER) {
      e.runeName = "Ποσσεσσος   ";
      e.power1 = "Possess";
      e.power2 = "Rocketman";
   } else if (e.rune == RUNE_THUNDER) {
      e.runeName = "Τθυξδες Στοςν   ";
      e.power1 = "Lightning";
      e.power2 = "RainClone";
   } else if (e.rune == RUNE_TURTLE) {
      e.runeName = "Τυςτμε   ";
      e.power1 = "Shell";
      e.power2 = "Snapper";
   } else if (e.rune == RUNE_ANT) {
      e.runeName = "Αξτ   ";
      e.power1 = "StrongJaw";
      e.power2 = "Speed";
   } else if (e.rune == RUNE_MEDIC) {
      e.runeName = "Νεδιγ   ";
      e.power1 = "Healer";
      e.power2 = "Plague";
   } else if (e.rune == RUNE_TARANTULA) {
      e.runeName = "Ταςαξτυμα   ";                       
      e.power1 = "Poison darts";
      e.power2 = "tricks";
   } else if (e.rune == RUNE_ORGANDONOR) {
      e.runeName = "Οςηαξ Δοξος   ";
      e.power1 = "Napalm";
      e.power2 = "Invisibility";
   } else if (e.rune == RUNE_M4D_SK1LLZ) {
      e.runeName = "M4d Sk1llz    ";
      e.power1 = "StreetSweeper";
      e.power2 = "StreetSweeper";
   } else {
      e.runeName = "";
      e.power1 = "";
      e.power2 = "";
   }
};

// preconditions:
// other = player with rune
// self = rune
void () doBprintRunePickup =
{
   GetRuneNames(self);
   bprint(other.netname);
   bprint(" got the rune of ");
   bprint(self.runeName);
   bprint("\n");
};

void() NRunesTouch =
{
   local string s;
   local float best;
   local entity stemp;
	
	if (other.classname != "player")
		return;
	if (other.health <= 0)
		return;
   if (other.rune) {
		if (other.rune_notice_time < time) {
         UpdatePlayerStatus(other, "\n\n\n\n\n\n\n\n\n\n\nYou already have a key or rune.\n", "", "");
			other.rune_notice_time = time + 5;
		}
		return; // one per customer
	}
		
   // give the person the correct item
   other.rune = self.rune;
   other.runemodel = self.runemodel;
   other.message = self.message;

	// notification of rune, no nofity in team mode
   if (!teamplay)
      doBprintRunePickup();
   
   local entity e1;
   e1 = self;
   self = other;
   RuneApplyPowers();
   self = e1;

	// backpack touch sound
	sound (other, CHAN_ITEM, "weapons/lock4.wav", 1, ATTN_NORM);
	stuffcmd (other, "bf\n");

   // when tsung 2nd power morphs, we cant get the new msgs.  Make sure
   // the old msgs are not lost.  But someday, we should arrange to display
   // the morphed desc, and then restore the tsung desc.  Or better yet,
   // just get rid of this loser rune :)
   if (!(other.inferno_flag & ABLE_TSUNG))
   {
      other.message = self.message;
   }
   other.newRune = 1;
   UpdatePlayerStatus(other, "", "", "");
   remove(self);
};

void (float flag) Do_DropNRunes;

void() NRunesRespawn =
{
	local entity oself;

	oself = self;

	// choose random starting points
	self = SelectRuneSpawnPoint();
        Do_DropNRunes(oself.rune);

	remove(oself);
};

void() NextNRunesThing =
{
        self.touch = NRunesTouch;
	
        self.nextthink = time + 120; 
               /* if no one touches it in two minutes,
                respawn it somewhere else, so inaccessible ones will come 'back' */
        self.think = NRunesRespawn;
};


void () ThrowM4D = {
   m4dToken = 0;
   self.message = "";
   self.runeName = "";
   self.power1 = "";
   self.power2 = "";
   self.rune = 0;  
};

void (float flag) ThrowNRunes =
{
   if (flag == RUNE_M4D_SK1LLZ) {
      ThrowM4D();
      return;
   }

   local entity item;
   local float floss;

   // can't throw when you're morphed (shang tsung)
   if (self.inferno_flag & ABLE_TSUNG) {
           UpdatePlayerStatus(self, "You cannot be morphed!\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
           return;
   }
   item = spawn();
	
   item.rune = flag;

   item.velocity = aim(self, 10000);
   item.velocity = item.velocity * 450;
	
   item.classname="rune";
   item.flags = FL_ITEM;
   item.solid = SOLID_TRIGGER;
   item.movetype = MOVETYPE_BOUNCE;
   item.message = self.message;

   self.message = "";
   self.rune = 0;  // this is how you show that the person doesn't have a rune(key)
   item.runemodel = self.runemodel;
   setmodel (item, item.runemodel);
	setsize (item, '-16 -16 0', '16 16 56');
   setorigin(item, self.origin + v_forward*8 + '0 0 16');
   self.runemodel = "";
   item.think = NextNRunesThing;
   item.nextthink = time + 0.5;

   // RUNE ORGANDONOR special effects
   if (item.rune == RUNE_ORGANDONOR)
      item.effects = item.effects | EF_DIMLIGHT;
        
};


void (entity item, float flag) UpdateRuneModel =
{
   if (flag == RUNE_EARTH_MAGIC)
           item.runemodel = "progs/end1.mdl";
   else if (flag == RUNE_BLACK_MAGIC)
           item.runemodel = "progs/end2.mdl";
   else if (flag == RUNE_HELL_MAGIC)
           item.runemodel = "progs/end3.mdl";
   else if (flag == RUNE_ELDER_MAGIC)
           item.runemodel = "progs/end4.mdl";

   /*** === MISC SET === ***/
   else if (flag == RUNE_TELEPORT)
           item.runemodel = "progs/m_g_key.mdl";
   else if (flag == RUNE_FUTURE)
           item.runemodel = "progs/m_s_key.mdl";
   else if (flag == RUNE_ARMOR) 
           item.runemodel = "progs/w_g_key.mdl";
   else if (flag == RUNE_STRONG)
           item.runemodel = "progs/w_s_key.mdl";
   else if (flag == RUNE_LIQUID) 
           item.runemodel = "progs/b_g_key.mdl";
   else if (flag == RUNE_DISAPEAR) 
           item.runemodel = "progs/b_s_key.mdl";
   else if (flag == RUNE_MIB) 
           item.runemodel = "progs/end1.mdl";
   else if (flag == RUNE_FOOLISH) 
           item.runemodel = "progs/end1.mdl";

   /*** === MEDIEVIL SET === ***/
   else if (flag == RUNE_WHITE_MAGIC) 
           item.runemodel = "progs/end3.mdl";
   else if (flag == RUNE_WIZARD) 
           item.runemodel = "progs/end4.mdl";
   else if (flag == RUNE_WITCH) 
           item.runemodel = "progs/m_g_key.mdl";
   else if (flag == RUNE_KNIGHT)
           item.runemodel = "progs/m_s_key.mdl";

   /*** === SUPERNATURAL SET === ***/
   else if (flag == RUNE_LUCK)
           item.runemodel = "progs/b_g_key.mdl";
   else if (flag == RUNE_GHOST)
           item.runemodel = "progs/b_s_key.mdl";
   else if (flag == RUNE_ILLUSION)
           item.runemodel = "progs/end2.mdl";

   /*** === MYTH SET === ***/
   else if (flag == RUNE_ZEUS)
           item.runemodel = "progs/end3.mdl";
   else if (flag == RUNE_POSEIDON)
           item.runemodel = "progs/end4.mdl";
   else if (flag == RUNE_MARS)
           item.runemodel = "progs/m_g_key.mdl";
   else if (flag == RUNE_HERMES)
           item.runemodel = "progs/m_s_key.mdl";
   else if (flag == RUNE_ARTEMIS)
           item.runemodel = "progs/w_s_key.mdl";
   else if (flag == RUNE_DEMETER)
           item.runemodel = "progs/b_g_key.mdl";

   /*** === PRESENT SET === ***/
   else if (flag == RUNE_COP)
           item.runemodel = "progs/end1.mdl";
   else if (flag == RUNE_NAVY_OFFICER)
           item.runemodel = "progs/end2.mdl";
   else if (flag == RUNE_FPILOT)
           item.runemodel = "progs/end3.mdl";

   /*** === MORTAL KOMBAT SET === ***/
   else if (flag == RUNE_SUBZERO)
           item.runemodel = "progs/m_g_key.mdl";
   else if (flag == RUNE_RAIDEN)
           item.runemodel = "progs/m_s_key.mdl";
   else if (flag == RUNE_JOHNNY_CAGE)
           item.runemodel = "progs/w_s_key.mdl";
   else if (flag == RUNE_KANO)
           item.runemodel = "progs/b_g_key.mdl";
   else if (flag == RUNE_KANG)
           item.runemodel = "progs/b_s_key.mdl";

   /*** === MORTAL KOMBAT II SET === ***/
   else if (flag == RUNE_REPTILE)
           item.runemodel = "progs/end1.mdl";
   else if (flag == RUNE_PORTAL_MASTER)
           item.runemodel = "progs/end3.mdl";
   else if (flag == RUNE_TSUNG)
           item.runemodel = "progs/end4.mdl";
   // else if (flag == RUNE_LAO)
   //         item.runemodel = "progs/m_g_key.mdl";

   /*** === MORTAL KOMBAT III SET === ***/
   else if (flag == RUNE_SEKTOR)
           item.runemodel = "progs/b_g_key.mdl";
   else if (flag == RUNE_SMOKE)
           item.runemodel = "progs/b_s_key.mdl";
//   else if (flag == 

   /*** === MORTAL KOMBAT MISC SET === ***/
   else if (flag == RUNE_KINTARO)
           item.runemodel = "progs/end2.mdl";

   /*** === DARKAGES SET === ***/
   else if (flag == RUNE_WEREWOLF)
           item.runemodel = "progs/m_g_key.mdl";
   else if (flag == RUNE_DRAGON)
           item.runemodel = "progs/m_s_key.mdl";
   else if (flag == RUNE_ZOMBIE)
           item.runemodel = "progs/w_g_key.mdl";
   else if (flag == RUNE_VAMPIRE)
           item.runemodel = "progs/w_s_key.mdl";
   else if (flag == RUNE_FP)
           item.runemodel = "progs/b_s_key.mdl";

   /*** === EARTH SET === ***/
   else if (flag == RUNE_WATER)
           item.runemodel = "progs/end1.mdl";
   else if (flag == RUNE_LIFE)
           item.runemodel = "progs/end3.mdl";
   else if (flag == RUNE_DEATH)
           item.runemodel = "progs/end4.mdl";

   /*** === HERO SET === ***/
   else if (flag == RUNE_SUPERMAN)
           item.runemodel = "progs/m_s_key.mdl";
   else if (flag == RUNE_PUNISHER)
           item.runemodel = "progs/w_g_key.mdl";

   /*** === HERO SET2 === ***/
   else if (flag == RUNE_SPAWN)
           item.runemodel = "progs/b_g_key.mdl";

   /*** === FUTURE SET === ***/
   else if (flag == RUNE_WEAPONS)
           item.runemodel = "progs/end1.mdl";
   else if (flag == RUNE_ROBOT)
           item.runemodel = "progs/end3.mdl";

   /*** === IMAGINARY SET === ***/
   else if (flag == RUNE_DREAM)
           item.runemodel = "progs/end4.mdl";
   else if (flag == RUNE_NIGHTMARE)
           item.runemodel = "progs/m_g_key.mdl";
   else if (flag == RUNE_POSSESSER)
           item.runemodel = "progs/m_s_key.mdl";

   /*** === STORM SET === ***/
   else if (flag == RUNE_THUNDER)
           item.runemodel = "progs/b_g_key.mdl";

   /*** === INSECT SET === ***/
   else if (flag == RUNE_ANT)
           item.runemodel = "progs/end3.mdl";

   /*** === ANIMAL SET === ***/
   else if (flag == RUNE_TURTLE)
           item.runemodel = "progs/m_s_key.mdl";

   /*** === PRESENT SET2 === ***/
   else if (flag == RUNE_CWORKER)
           item.runemodel = "progs/w_g_key.mdl";

   /*** === COTC SET === ***/
   else if (flag == RUNE_MEDIC)
           item.runemodel = "progs/end1.mdl";
   else if (flag == RUNE_TARANTULA)
           item.runemodel = "progs/end2.mdl";           
   else if (flag == RUNE_ORGANDONOR) {
           item.runemodel = "progs/end3.mdl";
           item.effects = item.effects | EF_DIMLIGHT;
   }
};


void (float flag) Do_DropNRunes =
{
   local entity    item;
   local string s1;

   if (!flag)
      return;

	item = spawn();
	item.origin = self.origin - '0 0 24';
	
   if (self.inferno_flag & ABLE_TSUNG)
           flag = RUNE_TSUNG;
   item.rune = flag;
   GetRuneNames(item);
   item.message = RuneDescription(flag);

	item.velocity_z = 400;
	item.velocity_x = -500 + (random() * 1000);
	item.velocity_y = -500 + (random() * 1000);
	
	item.flags = FL_ITEM;
	item.solid = SOLID_TRIGGER;
	item.movetype = MOVETYPE_TOSS;

        item.classname = "rune";


        /*** === ORIGINAL SET === ***/
        UpdateRuneModel (item, flag);


        // debugging
        // s1 = ftos(flag);
        // dprint("Spawning rune #");        dprint(s1);        dprint("\n");
        // bprint("Spawning rune #");
        // bprint(s1);
        // bprint("\n");
        if (item.runemodel == "") {
                local string f;
                f = ftos(flag);
                dprint(f);
                dprint(" has disapeared!\n");
        }

        setmodel (item, item.runemodel);
        setsize (item, '-16 -16 0', '16 16 56');
        item.touch = NRunesTouch;
	
        item.nextthink = time + 120; /* if no one touches it in two minutes,
                respawn it somewhere else, so inaccessible ones will come 'back' */
        item.think = NRunesRespawn;
};



/***PLAYER FLIGHT***/
void() PlayerFlight =
{
        {
                local float invcos,nv,nvp,nvpmax,nvs,nsp,sp,svz;
                local vector f,vp,vs;
    
                svz = self.velocity_z * 0.75;
                self.velocity_z = 0;
    
                // v_forward is already normalized
                f_x = v_forward_x; 
                f_y = v_forward_y; 
                f_z = 0;
                invcos = vlen(f); if (invcos) invcos= 1/invcos; else invcos=0;
                f = f*invcos; // normalize f
       
                sp = f * self.velocity;
                vp = sp*f;
                nvp = vlen(vp); if (sp<0) nvp = nvp*(-1);
                vs = self.velocity - vp;
     
                vp = v_forward * (nvp * invcos);
                vp_z = vp_z + svz;
                nvp = vlen(vp);
                nvpmax = (320 - 100*(v_forward * '0 0 1'));
                if (nvp > nvpmax) { vp = vp * (nvpmax/nvp); }
     
                self.velocity = vp + vs;
        }
};

// shield, shield a person with a "shield like figure"
void(vector v, float f1) Shield =
{
        local float f2;
        f2=f1;
        if(f2==12345678)f1=333;
        v=v+'0 0 16';
        particle(v+v_right*20,'0 0 5',f1,10);
        particle(v+v_right*-20,'0 0 5',f1,10);
        if (f2==12345678)f1=472;
        particle(v+v_forward*20,'0 0 5',f1,10);
        particle(v+v_forward*-20,'0 0 5',f1,10);
};

// shield2 situation (fully covered)
void(vector v, float f1) Shield2 =
{
        local entity vv;
        v=v+'0 0 16';

        particle(v+v_right*random()*40, '0 0 0', f1, 1);
        particle(v+v_right*random()*40, '0 0 0', f1, 1);
        particle(v+v_right*random()*40, '0 0 0', f1, 1);
        particle(v+v_right*random()*40, '0 0 0', f1, 1);
        particle(v+v_right*random()*40, '0 0 0', f1, 1);

        particle(v+v_right*random()*-40, '0 0 0', f1, 1);
        particle(v+v_right*random()*-40, '0 0 0', f1, 1);
        particle(v+v_right*random()*-40, '0 0 0', f1, 1);
        particle(v+v_right*random()*-40, '0 0 0', f1, 1);
        particle(v+v_right*random()*-40, '0 0 0', f1, 1);

        particle(v+v_forward*random()*40, '0 0 0', f1, 1);
        particle(v+v_forward*random()*40, '0 0 0', f1, 1);
        particle(v+v_forward*random()*40, '0 0 0', f1, 1);
        particle(v+v_forward*random()*40, '0 0 0', f1, 1);
        particle(v+v_forward*random()*40, '0 0 0', f1, 1);

        particle(v+v_forward*random()*-40, '0 0 0', f1, 1);
        particle(v+v_forward*random()*-40, '0 0 0', f1, 1);
        particle(v+v_forward*random()*-40, '0 0 0', f1, 1);
        particle(v+v_forward*random()*-40, '0 0 0', f1, 1);
        particle(v+v_forward*random()*-40, '0 0 0', f1, 1);

        particle(v+v_up*random()*40, '0 0 0', f1, 1);
        particle(v+v_up*random()*40, '0 0 0', f1, 1);
        particle(v+v_up*random()*40, '0 0 0', f1, 1);
        particle(v+v_up*random()*40, '0 0 0', f1, 1);
        particle(v+v_up*random()*40, '0 0 0', f1, 1);

        particle(v+v_up*random()*-40, '0 0 0', f1, 1);
        particle(v+v_up*random()*-40, '0 0 0', f1, 1);
        particle(v+v_up*random()*-40, '0 0 0', f1, 1);
        particle(v+v_up*random()*-40, '0 0 0', f1, 1);
        particle(v+v_up*random()*-40, '0 0 0', f1, 1);
};

void() handleNailRegen =
{
   // person has sonya rune
   if (self.regen_time < time) {
      if (self.ammo_nails < 200) {
         if (self.ammo_nails >= 190)
            self.ammo_nails = 200;
         else
            self.ammo_nails = self.ammo_nails + 10;
      }
      if (self.rune == RUNE_WEAPONS || self.rune == RUNE_DREAM)
            self.regen_time = time + 10;
      else self.regen_time = time + 1.5;
      RegenerationSound();
      Inf_SetAmmo(self);
   }
   if (!(self.items & IT_SUPER_NAILGUN))
      self.items = self.items | IT_SUPER_NAILGUN;
};


/*
================
CheckInfPowerups

Called every frame before physics are run, by PlayerPreThink(); in client.qc
================
*/
.float speed;
float CHSCAM_ON;

void() CheckInfPowerups =
{
   local float f1, f2, f3;
   local entity e, ppp;
   local vector v1, org;


   /*******************************************************\
   *  Misc checks, powerups, and special effects
   \*******************************************************/

   // yellow respawn safety field
   if (self.respawnInvincibleFlag) {
      particle (self.origin + '0 0 16', '0 0 16', 105, 50);
   }

   // #1 Check, to see if the person has a weapon at hand
   if (self.weaponmodel == "")
   {
      if (!(self.speed & CHSCAM_ON))
         Inf_SetAmmo(self);
   }

   // reflector shield
   if(self.nitems&NITEM_RSHIELD){
      e=findradius(self.origin,300);
      while(e){
         if(e.owner.classname=="player" &&
            e.owner!=self&&e.classname!="ghost clone" &&
            (!teamplay||e.owner.team!=self.team) &&
            e.rune_power!=12345678){
            if(e.velocity) {
               if(!e.rsed) {
                       e.rsed=1;
                       e.owner=self;
                       e.velocity=e.velocity*-1;
               }
            }
         }
         e=e.chain;
      }
      Shield(self.origin + v_up*30,450);
   }

   // special effects if the person has the PQ powerup
   if (self.nitems & NITEM_PQ) 
      Shield(self.origin, 12345678);

   // when you're ducking, you cannot move fast
   if(self.pl_duck==1)
   {
      if (!(self.velocity_z)) 
         self.velocity=self.velocity - 0.8*6*frametime*self.velocity;
   }


   // +++depends on classname = dog missile, ie nweapon= new_dog
   if(self.bugs=="flees")
   {
      if (
         self.bugs_time>time &&
         self.bugs_owner.classname=="player" &&
         self.bugs_dmg_time<time) 
      {

         Shield2(self.origin, 1);
         self.reason_died="flees";
         T_Damage(self, self.bugs_owner, self.bugs_owner, 4);
         self.reason_died="";
         self.bugs_dmg_time = time + 0.4;
      }
   }

   // Super Powers

   if(self.rune_power){
           if(self.rune_power_time<time)self.rune_power=0;
   }


   if(self.pl_block){//person's blocking
      if(self.pl_block_time<time){self.pl_block=0;}else{
      particle(self.origin + '0 0 16' + v_forward*40, '0 0 100', 322, 25);
      particle(self.origin + '0 0 16' + v_forward*40+v_right*20, '0 0 100', 322, 25);
      particle(self.origin + '0 0 16' + v_forward*40+v_right*-20, '0 0 100', 322, 25);
      }
   }


   /*******************************************************\
   *  Player has a rune effect
   \*******************************************************/

   // person got cursed by the hounds
   if (self.mentalHound)
   {
      if (self.mentalHoundTime >= time) {
           self.angles_y = self.angles_y + random()*100;
           self.angles_z = self.angles_z + random()*100;
           if (self.bad_count < time) {
                self.punchangle_y = random()*100 - 80;
                self.punchangle_z = random()*100 - 50;
                self.bad_count = time + 1.5;
           }
      }
      else
      {
         self.bad_count = 0;
         self.mentalHound = 0;
         self.mentalHoundTime = 0;
      }
   }   


   if (self.runeb_rune)
   {
      // now someone whose been bad
      if (self.runeb_rune == RUNE_SMOKE) {
         if (self.runeb_time >= time) 
            setorigin(self.clone, self.origin + '0 0 16' + v_forward*160);
         else if (self.clone_use) {
            remove(self.clone);
            self.clone_use = 0;
         }
      }

      // been trapped in a bubble by a person with demeter
      else if (self.runeb_rune == RUNE_DEMETER) {
         if (self.runeb_time >= time)
            self.velocity_z=self.velocity_z+40;
      }

      // make sure the person has a symbol for the spell
      else if (self.runeb_rune == RUNE_WITCH) {
         if (self.runeb_time >= time)
           particle(self.origin + '0 0 16', '0 0 0', 55555, 50);
      }

      else if (self.runeb_rune == RUNE_DEATH) {
         if (self.runeb_time >= time)
           particle(self.origin + '0 0 16', '0 0 0', 55555, 50);
      }

      // w00p, the player has been cursed by the god of war (Mars)!
      else if (self.runeb_rune == RUNE_MARS) {
         if ((self.runeb_time >= time) && 
            (self.bad_count < time)) {
            self.button0 = 1;
            self.button2 = 1;
            particle (self.origin + '0 0 16', '0 0 0', 999, 50);
            self.bad_count = time + 0.2;
         }
      }

      else if (self.runeb_rune == RUNE_WITCH) {
         if ((self.runeb_time >= time) &&
            (self.weaponmodel != ""))
               self.weaponmodel = "";
      }
      
      else if (self.runeb_rune == RUNE_DEATH) { 
         if ((self.runeb_time >= time) &&
            (self.weaponmodel != ""))
               self.weaponmodel = "";
      }
      else if (self.runeb_rune == RUNE_ZOMBIE) { 
         if ((self.runeb_time >= time) &&
            (self.weaponmodel != ""))
               self.weaponmodel = "";
      }


      // been cursed by poseidon
      if (self.runeb_rune == RUNE_POSEIDON) { 
         if (self.runeb_time >= time)
         {
            if (!(self.waterlevel) && (self.bad_count < time)) {
               self.reason_died = "drown";
               T_Damage(self, self, self, 15);
               self.reason_died = "";
               self.bad_count = time + 4;  // 4 seconds until it happens again
               NewBubbles(4, self.origin);
               sound (self, CHAN_BODY, "player/drown1.wav", 1, ATTN_NORM);
               UpdatePlayerStatus(self, "You're drowning!!  Find Water!!\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
            }
            particle (self.origin + '0 0 16', '0 0 16', 40, 50);//73
         }
      }
   }

   // +++Assumes the owner is holding a temp rune?
   // morph back into a person (shang tsung rune)
   if (self.inferno_flag & ABLE_TSUNG) {
      if (self.tsung_time < time) {
         self.inferno_flag = self.inferno_flag - 
            (self.inferno_flag & ABLE_TSUNG);
         self.rune = RUNE_TSUNG;
         UpdatePlayerStatus(self, "Morphed Back\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
      }
   }

   /*******************************************************\
   *  RUNES ONLY AFTER THIS POINT
   *  All the rune power code must be in a single block
   \*******************************************************/

   if (!self.rune)
      return;
   local float dummy;
   if (self.rune > 32) {
      // bprint("if (self.rune > 32) {\n");
      if (self.rune > 48) {
         // bprint("if (self.rune > 48) {\n");
         if (self.rune > 56) {
            // bprint("if (self.rune > 56) {\n");
            if (self.rune > 60) {
               // bprint("if (self.rune > 60) {\n");
               if (self.rune == 63) {
                  // bprint("if (self.rune == 63) {\n");
                  // 63 Organ Donor
                  if (!(self.status_flag & ITEM_SECOND_RUNE)) {
                     if (self.napalmTime < time) {
                        OrganDonorNapalmThink();
                     }
                  } else {
                     // bprint("} else 63 1st power {\n");
                     if (self.attack_finished < time) {
                        setmodel(self, string_null);
                        self.weaponmodel = "";
                        setsize(self, VEC_HULL_MIN, VEC_HULL_MAX);
                     }
                  } 
               } else if (self.rune == 62) {
                  // bprint("} else if (self.rune == 62) {\n");
                  // 62
                  if (!(self.status_flag & ITEM_SECOND_RUNE)) {
                     if (!(self.items & IT_NAILGUN))
                        self.items = self.items | IT_NAILGUN;
                     if (self.ammo_nails < 1)
                        self.ammo_nails = 40;
                  }
               } else {
                  // bprint("} else 61 {\n");
                  // 61
                  dummy = 0;
               }
            } else if (self.rune > 58) {
               // bprint("} else if self.rune > 58) {\n");
               if (self.rune == 60) {
                  // bprint("if (self.rune == 60) {\n");
                  // 60 Ant
                  // they can jump forward too!
                  if (self.status_flag & ITEM_SECOND_RUNE) {
                     if (!(self.velocity_z))
                     self.velocity = self.velocity - 
                        0.8 * 4 * frametime * self.velocity - 
                        0.8 * -8 * frametime * self.velocity;
                  }
               } else {
                  // bprint("} else 59 {\n");
                  // 59
                  dummy = 0;
               }
            } else if (self.rune == 58) {
               // bprint("} else if (self.rune == 58) {\n");
               // 58 Possesser
               if (self.status_flag & ITEM_SECOND_RUNE) {
                  handleFlight();
               }
            } else {
               // bprint("} else 57 {\n");
               // 57  Nightmare
               if (!(self.status_flag & ITEM_SECOND_RUNE)) {
                  // bprint("57 1st power\n");
                  if (self.regen_time < time) {
                     // bprint("57 regen < time\n");
                     e = findradius(self.origin, 300);
                     while(e) {
                        // bprint("while e\n");
                        if (e.classname == "player") {
                           if (!teamplay || (self.team!=e.team)) {
                              if (e.health) {
                                 if (CanDamage(e, self)) {
                                    if (e != self) {
                                       e.punchangle_y = random()*180 - 90;
                                       e.punchangle_z = random()*60 - 30;
                                       e.reason_died = "mind melt";
                                       T_Damage(e,self,self,4);
                                       e.reason_died = "";
                                    }
                                 }
                              }
                           }
                        }
                        e = e.chain;
                     }
                     self.regen_time = time + 1;
                  }
               }
            }
         } else if (self.rune > 52) {
            // bprint("} else if (self.rune > 52) {\n");
            if (self.rune > 54) {
               // bprint("if (self.rune > 54) {\n");
               if (self.rune == 56) {
                  // bprint("if (self.rune == 56) {\n");
                  // 56 Dream
                  if (!(self.status_flag & ITEM_SECOND_RUNE)) 
                     handleNailRegen();
               } else {
                  // bprint("} else 55 {\n");
                  // 55 Thunder
                  // thunder rune, the cells, make sure he/she regenerates!
                  if (!(self.status_flag & ITEM_SECOND_RUNE)) {
                     if (!(self.items & IT_LIGHTNING))
                        self.items = self.items | IT_LIGHTNING;
                     if (self.regen_time < time && self.ammo_cells < 100) {
                        self.ammo_cells = self.ammo_cells + 3;
                        Inf_SetAmmo(self);
                        self.regen_time = time + 1.6;
                     }
                  }
               }
            } else if (self.rune == 54) {
               // bprint("} else if (self.rune == 54) {\n");
               // 54 Robot
               if (self.status_flag & ITEM_SECOND_RUNE) {
                  // bprint("54 2nd power\n");
                  handleNailRegen();
               }
            } else {
               // bprint("} else 53 {\n");
               // 53 weapons
               if (!(self.status_flag & ITEM_SECOND_RUNE)) {
                  // bprint("53 1st power \n");
                  handleNailRegen();
               } else {
                  // symbol for the controller shield to be on 
                  // (weapons specialist)
                  e = findradius(self.origin, 200);
                  while (e) {
                     if (e.classname == "player") {
                        if (!teamplay || self.team != e.team) {
                           if (e.health) {
                              if (CanDamage(e, self)) {
                                 if (e != self) {
                                    e.velocity = self.velocity;            
                                 }
                              }
                           }
                        }
                     }
                     e = e.chain;
                  }
                  Shield(self.origin, 130);
               }
            }
         } else if (self.rune > 50) {
            // bprint("} else if (self.rune > 50) {\n");
            if (self.rune == 52) {
               // bprint("if (self.rune == 52) {\n");
               // 52 Spawn
               // check the spawn rune (effects)
               particle (self.origin + '0 0 16' + v_forward*-20 + v_right*10, v_forward*-40 + v_up*-5, 999, 23);
               particle (self.origin + '0 0 16' + v_forward*-20, v_forward*-40 + v_up*-5, 999, 23);
               particle (self.origin + '0 0 16' + v_forward*-20 + v_right*-10, v_forward*-40 + v_up*-5, 999, 23);
               particle (self.origin + '0 0 16' + v_forward*-20 + v_right*10, v_forward*-40 + v_up*-5, 55555, 2);
               particle (self.origin + '0 0 16' + v_forward*-20, v_forward*-40 + v_up*-5, 55555, 2);
               particle (self.origin + '0 0 16' + v_forward*-20 + v_right*-10, v_forward*-40 + v_up*-5, 55555, 2);

               // THIS LOOKS DEFECTIVE
               // check for spawn block
               if (self.status_flag & ITEM_SECOND_RUNE) {
                    if (self.runeg_time > time)
                        Shield(self.origin + '0 0 16',55555);
                    else 
                        self.runeg_rune=0;
                    self.runeg_time=0;
                }
                // Regen the armor (if any) and health to 150 with 
               // the spawn rune!
               else {
                  if (self.regen_time < time) {
                     self.regen_time = time;
                     if (self.health < 150) {
                        self.health=self.health+5;
                        if (self.health > 150)
                           self.health=150;
                        RegenerationSound();
                        self.regen_time = self.regen_time+0.5;
                     }
                     if (self.armorvalue < 150 && self.armortype) {
                        self.armorvalue=self.armorvalue+5;
                        if (self.armorvalue > 150)
                           self.armorvalue=150;
                        RegenerationSound();
                        self.regen_time=self.regen_time+0.5;
                     }
                  }
               }
            } else {
               // bprint("} else {\n");
               // 51 Punisher
               // the person has the punisher rune (regenerate the ammo..)
               if (self.regen_time < time) {
                  if (!(self.status_flag & ITEM_SECOND_RUNE)) {
                     if (!(self.items & IT_GRENADE_LAUNCHER)) 
                        self.items = self.items | IT_GRENADE_LAUNCHER;
                     if (self.ammo_rockets < 100) 
                        self.ammo_rockets = self.ammo_rockets + 1;
                  }
                  self.regen_time = time + 3;
               }
               if (self.status_flag & ITEM_SECOND_RUNE && 
                  self.ammo_shells < 100) {
                  self.ammo_shells = self.ammo_shells + 2;
                  self.regen_time = time + 3;
               }
               Inf_SetAmmo(self);
            }
         } else if (self.rune == 50) {
            // bprint("} else if (self.rune == 50) {\n");
            // 50 Superman
            // check the superman rune (effects)
            particle (self.origin + '0 0 16' + v_forward*-20 + v_right*10, v_forward*-2 + v_up*-10, 999, 25);
            particle (self.origin + '0 0 16' + v_forward*-20, v_forward*-2 + v_up*-10, 999, 25);
            particle (self.origin + '0 0 16' + v_forward*-20 + v_right*-10, v_forward*-2 + v_up*-10, 999, 25);
            handleFlight();
         } else {
            // bprint("} else {\n");
            // 49 
            dummy = 0;
         }
      } else if (self.rune > 40) {
         // bprint("} else if (self.rune > 40) {\n");
         if (self.rune > 44) {
            // bprint("if (self.rune > 44) {\n");
            if (self.rune > 46) {
               // bprint("if (self.rune > 46) {\n");
               if (self.rune == 48) {
                  // bprint("if (self.rune == 48) {\n");
                  // 48 Life
                  // (regenerate the ammo..)
                  if (self.status_flag & ITEM_SECOND_RUNE) {
                     if (self.regen_time < time) {
                        if (!(self.items & IT_ROCKET_LAUNCHER)) 
                           self.items = self.items | IT_ROCKET_LAUNCHER;
                        if (self.ammo_rockets < 100) 
                           self.ammo_rockets = self.ammo_rockets + 1;
                        if (self.ammo_shells < 100) 
                           self.ammo_shells = self.ammo_shells + 2;
                        self.regen_time = time + 3;
                     }
                     Inf_SetAmmo(self);
                  }
               } else {
                  // 47 Water
                  // water rune from the earth set
                  if (!(self.status_flag & ITEM_SECOND_RUNE)) {
                     if (self.waterlevel) {
                        if (pointcontents(self.origin)==CONTENT_WATER) {
                           setmodel(self, string_null);
                           self.weaponmodel = "";
                           setsize(self, VEC_HULL_MIN, VEC_HULL_MAX);
                           if (self.regen_time < time) {
                              if (self.health < 100) {
                                 self.health = self.health + 3;
                                 RegenerationSound();
                              }
                              self.regen_time = time + 0.5;
                           }
                        } 
                     }
                  } else {
                     if (self.regen_time < time) {
                        ppp = findradius(self.origin, 400);
                        while (ppp) {
                           if (ppp.classname == "player") {
                              if (ppp.health > 0) {
                                 if (!ppp.waterlevel) {
                                    if (!teamplay || self.team != ppp.team) {
                                       if (ppp != self) {
                                          ppp.key5_flag_count = time + 0.5;
                                       }
                                    }
                                 }
                              }
                           }
                           ppp = ppp.chain;
                        }
                        if (self.health < 100) {
                           self.health = self.health + 3;
                           RegenerationSound();
                        }
                        self.regen_time = time + 0.2;
                     }
                  }
               } 
            } else if (self.rune == 46) {
               // 46
               dummy = 0;
            } else {
               // 45 Vampire
               if (self.status_flag & ITEM_SECOND_RUNE) {
                  if (!(self.items & IT_SUPER_NAILGUN))
                     self.items = self.items | IT_SUPER_NAILGUN;
                  if (self.time_count < time && 
                     self.ammo_nails < 200) {
                     if (self.ammo_nails >= 190)
                        self.ammo_nails = 200;
                     else self.ammo_nails = self.ammo_nails + 10;
                     self.time_count = time + 1.5;
                     Inf_SetAmmo(self);
                  }  
               } else {
                  handleFlight();
               }
               // check for vampire rune (don't forget to drain blood!)
               if (self.rune_count < time && self.health > 0) {
                  self.rune_count = time + 1;
                  self.health = self.health - 3;
               }
               if (self.health <= 0) {
                  self.reason_died = "vampire death";
                  Killed(self, self, self);
                  self.reason_died = "";
                  return;
               }
               if (self.health <= 30)
                  UpdatePlayerStatus(self, "Argh, you need some blood to\nquinch your thirst, vampire!\n\n\n\n\n\n\n\n\n\n\n", "", "");
            }
         } else if (self.rune > 42) {
            if (self.rune == 44) {
               // 44
               dummy = 0;
            } else {
               // 43 Dragon
               if (!(self.status_flag & ITEM_SECOND_RUNE)) {
                  handleFlight();
               }
            }
         } else if (self.rune == 42) {
            // 42 Werewolf
            // check if the person has the werewolf rune, 
            // they can jump forward too!
            if (!(self.status_flag & ITEM_SECOND_RUNE)) {
               if (!(self.velocity_z)) {
                  self.velocity = 
                     self.velocity - 0.8*4*frametime*self.velocity - 
                     0.8 * -8 * frametime * self.velocity;
               }
            }
         } else {
            // 41 Kintaro
            // (regenerate the ammo..)
            if (self.status_flag & ITEM_SECOND_RUNE) {
               if (self.regen_time < time) {
                  if (!(self.items & IT_GRENADE_LAUNCHER))  
                      self.items = self.items | IT_GRENADE_LAUNCHER;
                  if (self.ammo_rockets < 100) 
                      self.ammo_rockets = self.ammo_rockets + 1;
                  if (self.ammo_shells < 100) 
                      self.ammo_shells = self.ammo_shells + 2;
                  self.regen_time = time + 3;
               }
            }
            Inf_SetAmmo(self);
         }
      } else if (self.rune > 36) {
         if (self.rune > 38) {
            if (self.rune == 40) {
               // 40 Smoke
               // special effects for the person who has the smoke rune
               particle(self.origin + '0 0 16', '0 0 16', 55554, 50);
            } else {
               // 39
               dummy = 0;
            }
         } else if (self.rune == 38) {
            // 38 Portal Master
            // if the attacker has the portal rune...transport (second power)
            if ((self.status_flag & ITEM_SECOND_RUNE) && 
               !(self.velocity_z)) {
               self.velocity = 
                  self.velocity - 0.8*4*frametime*self.velocity - 
                  0.8*-10*frametime*self.velocity;
            }
         } else {
            // 37
            dummy = 0;
         }
      } else if (self.rune > 34) {
         if (self.rune == 36) {
            // 36
            dummy = 0;
         } else {
            // 35
            if (self.status_flag & ITEM_SECOND_RUNE) {
               setmodel(self, string_null);
               self.weaponmodel = "";
               setsize(self, VEC_HULL_MIN, VEC_HULL_MAX);
            }
         }
      } else if (self.rune = 34) {
         // 34 Kang
         // person has kang rune, set the person's velocity
         if (self.inferno_flag & FR_KANG) {
            if (self.pl_duck == 1) { 
               // remove ducking
               // sprint(self, "duck and wine, yummy!\n");
               self.pl_duck = 4; // stop ducking
               self.pl_duck_time = 0;
               self.velocity_z = 450; // stand up
            }
            self.velocity = v_forward*600;
            self.angles = self.angles + '180 0 0';
      
            // sound effects
            if (self.time_count < time) {
               sound (self, CHAN_BODY, "hknight/idle.wav", 1, ATTN_NORM);
               self.time_count = time + 0.3;
            }
            if (self.rune_count < time)
               RemoveKang();
         }
      } else {
         // 33  Kano
         // person has kano rune, and has fired kano, set the person's velocity
         if (self.inferno_flag & FR_KANO) {
            if (self.pl_duck == 1) { 
               // remove ducking
               // sprint(self, "duck and wine, yummy!\n");
               self.pl_duck = 4; // stop ducking
               self.pl_duck_time = 0;
               self.velocity_z = 450; // stand up
            }
            self.velocity = v_forward*700;

            // sound effects
            if (self.time_count < time) {
                 sound (self, CHAN_BODY, "hknight/idle.wav", 1, ATTN_NORM);
                 self.time_count = time + 0.3;
            }
            if (self.rune_count < time)
                 RemoveKano();
         }
      }
   } else if (self.rune > 16) {
      if (self.rune > 24) {
         if (self.rune > 30) {
            if (self.rune == 32) {
               // 32  Johnny Cage
               if (self.inferno_flag & FR_JCAGE) {
                  if (self.pl_duck == 1) { // remove ducking
                     self.pl_duck = 4; // stop ducking
                     self.pl_duck_time = 0;
                     self.velocity_z = 450; // stand up
                  }
                  self.velocity = v_forward*650;
                  // shadow effects
                  particle (self.origin + '0 0 16', '0 0 0', 55558, 50);

                  // sound effects
                  if (self.time_count < time) {
                       sound (self, CHAN_BODY, "hknight/idle.wav", 1, ATTN_NORM);
                       // shadow person
                       e = spawn();
                       setmodel (e, "progs/player.mdl");
                       e.owner = self;
                       e.classname = "shadow person";
                       e.origin = self.origin;
                       setorigin(e, self.origin);
                       e.frame = self.frame;
                       e.colormap = self.colormap;
                       e.angles = self.angles;
                       e.think = SUB_Remove;
                       e.nextthink = time + 0.2;
                       self.time_count = time + 0.2;
                  }
                  if (self.rune_count < time)
                       RemoveShadowRam();
               }
            } else {
               // 31 Raiden
               f1 = 80;
               f2 = ceil(2 * 0.04) + 1;
               f3 = 350+random()*12;
               v1 = self.origin;
               v1_x = v1_x + random()*f1 - 50;
               v1_y = v1_y + random()*f1 - 50;
               v1_z = v1_z + random()*50 - 40;
               particle (v1, '0 0 0', f3, 50);//73

               // person has raiden rune, set the person's velocity
               // +++raiden rune 2nd power?
               if (self.inferno_flag & FR_RAIDEN) {
                  if (self.pl_duck == 1) { // remove ducking
                     // sprint(self, "duck and wine, yummy!\n");
                     self.pl_duck = 4; // stop ducking
                     self.pl_duck_time = 0;
                  }
                  self.velocity = v_forward*700;
                  // sound effects
                  if (self.time_count < time) {
                     sound (self, CHAN_BODY, "hknight/idle.wav", 1, ATTN_NORM);
                     self.time_count = time + 0.3;
                  }
                  if (self.rune_count < time)
                     RemoveRaidenMove();
               }

               // raiden rune, the cells, make sure he/she regenerates!
               if (!(self.status_flag & ITEM_SECOND_RUNE)) {
                  if (!(self.items & IT_LIGHTNING))
                     self.items = self.items | IT_LIGHTNING;
                  if (self.regen_time < time && 
                     self.ammo_cells < 100) {
                     self.ammo_cells = self.ammo_cells + 2;
                     Inf_SetAmmo(self);
                     self.regen_time = time + 0.7;
                  }
               }
            }
         } else if (self.rune > 28) {
            if (self.rune == 30) {
               // 30
               dummy = 0;
            } else {
               // 29 Cworker
               // rune of the construction worker
               if (!(self.status_flag & ITEM_SECOND_RUNE)) {
                  if (self.regen_time < time) {
                     if(self.ammo_cells < 100)
                        self.ammo_cells = self.ammo_cells + 1;
                     if(!(self.items & IT_LIGHTNING))
                        self.items=self.items | IT_LIGHTNING;
                     if(self.items&IT_CELLS)
                        W_SetCurrentAmmo();
                     self.regen_time=time + 1;
                  }
               }
            }
         } else if (self.rune > 26) {
            if (self.rune == 28) {
               // 28 Fighter Pilot (FPILOT)
               // Flight, Fighter Pilot's targeter
               if (!(self.status_flag & ITEM_SECOND_RUNE)) {
                  if (!(self.items & IT_ROCKET_LAUNCHER))
                      self.items = self.items | IT_ROCKET_LAUNCHER;
                  // used to be 100
                  if (self.ammo_rockets < 20 && self.time_count < time) {
                      self.ammo_rockets = self.ammo_rockets + 1;
                      self.time_count = time + 3;
                      Inf_SetAmmo(self);
                  }
                  Inf_SetAmmo(self);
               } else {
                  if (!(self.items & IT_SUPER_NAILGUN))
                     self.items = self.items | IT_SUPER_NAILGUN;
                  if (self.rune_count < time) {
                     if (self.ammo_nails >= 195)
                        self.ammo_nails = 200;
                     else self.ammo_nails = self.ammo_nails + 5;
                     self.rune_count = time + 1.4;
                     Inf_SetAmmo(self);
                  }
               }
               handleFlight();
            } else {
               // 27 Navy Officer
               // player has key20 flag, move slow!
               if (!(self.status_flag & ITEM_SECOND_RUNE)) {
                  if (!(self.items & IT_ROCKET_LAUNCHER))
                     self.items = self.items | IT_ROCKET_LAUNCHER;
                  if (!(self.items & IT_GRENADE_LAUNCHER))
                     self.items = self.items | IT_GRENADE_LAUNCHER;
                  if (self.ammo_rockets < 100 && self.time_count < time) {
                     self.ammo_rockets = self.ammo_rockets + 1;
                     self.time_count = time + 2.5;
                     Inf_SetAmmo(self);
                  }
                  self.velocity = 
                     self.velocity - 0.8*4*frametime*self.velocity;
               }
            }
         } else if (self.rune == 26) {
            // 26
            dummy = 0;
         } else {
            // 25 Demeter
            if (!(self.status_flag & ITEM_SECOND_RUNE)) 
               handleNailRegen();
            else {
               // demeter rune, make people drunk!
               if (self.regen_time < time) {
                  e = findradius(self.origin, 300);
                  while(e) {
                     if (e.classname == "player") {
                        if (e.health) {
                           if (CanDamage(e, self)) {
                              if (e != self) {
                                 e.reason_died = "drunk";
                                 T_Damage (e, self, self, 25);
                                 e.reason_died = "";
                                 sound (e, CHAN_VOICE, "player/drown1.wav", 1, ATTN_NORM);
                                 if (random() < 0.5) InfBubbles(e.origin, 3);
                                 else InfBubbles(e.origin, 2);
                                 UpdatePlayerStatus(e, "You're DRUNK!\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
                                 e.angles = e.angles + '180 0 0';
                              }
                           }
                        }
                     }
                     e=e.chain;
                  }
                  self.regen_time = time + 2;
               }
            }
         }             
      } else if (self.rune > 20) {
         if (self.rune > 22) {
            if (self.rune == 24) {
               // 24
               dummy = 0;
            } else {
               // 23
               dummy = 0;
            }
         } else if (self.rune == 22) {
            // 22 Hermes
            if (!(self.status_flag & ITEM_SECOND_RUNE)) 
               handleFlight();
         } else {
            // 21  Mars
            particle (self.origin + '0 0 16', '0 0 16', 999, 50);
         }
      } else if (self.rune > 18) {
         if (self.rune == 20) {
            // 20 Poseiden
            if (!(self.status_flag & ITEM_SECOND_RUNE)) {
               if (self.regen_time < time) {
                  if (self.health < 100) {
                     if (self.waterlevel) {
                        self.health = self.health + 3;
                        self.regen_time = time + 0.5;
                        RegenerationSound();
                     }
                  }
               }
               if (!(self.items & IT_LIGHTNING))
                  self.items = self.items | IT_LIGHTNING;
               if (self.ammo_cells < 1)
                  self.ammo_cells = 3;
               if (self.items & IT_CELLS) {
                  if (self.currentammo < 1)
                      self.currentammo = 3;
               }
            }
         } else {
            // 19 Zeus
            // does the person have the shield on? (zeus)
            if (self.status_flag & ITEM_SECOND_RUNE) {
               if (self.regen_time < time) {
                  e = findradius(self.origin, 250);
                  while (e != world)
                  {
                     if ((e != self) && (e.owner != self)) {
                        ppp = self;  // store your entity
                        self = e;
                        other = world;
                        if (self.owner.classname == "player") {
                           if (self.touch)
                              self.touch();
                        }
                        self = ppp;  // restore your entity
                     }
                     e = e.chain;
                  }
                  self.regen_time = time + 0.1;
               }  // 444 = green :) [TGM] or 8888
               Shield (self.origin, 422);
            }
         }
      } else if (self.rune == 18) {
         // 18
         dummy = 0;
      } else {
         // 17
         dummy = 0;
      }
   } else if (self.rune > 8) {
      if (self.rune > 12) {
         if (self.rune > 14) {
            if (self.rune == 16) {
               // 16 Luck
               // CHECK: Rune of luck, just to grab things...
               if (self.regen_time < time) {
                  e = findradius(self.origin, 300);
                  if (!(self.status_flag & ITEM_SECOND_RUNE)) {
                     while (e)
                     {
                        if ((e.classname == "item_shells") || 
                           (e.classname == "item_spikes") || 
                           (e.classname == "item_rockets") || 
                           (e.classname == "item_cells")) {
                               other = self;
                               self = e;
                               ammo_touch ();
                               self = other;
                        }
                        if (e.classname == "item_health") {
                           other = self;
                           self = e;
                           health_touch ();
                           self = other;
                        }
                        if ((e.classname == "weapon_supershotgun") || 
                           (e.classname == "weapon_nailgun") || 
                           (e.classname == "weapon_supernailgun") || 
                           (e.classname == "weapon_grenadelauncher") || 
                           (e.classname == "weapon_rocketlauncher") || 
                           (e.classname == "weapon_lightning")) {
                           other = self;
                           self = e;
                           weapon_touch ();
                           self = other;
                        }
                        if ((e.classname == "item_armor1") || 
                           (e.classname == "item_armor2") || 
                           (e.classname == "item_armorInv")) {
                           other = self;
                           self = e;
                           armor_touch ();
                           self = other;
                        }
                        e = e.chain;
                     }
                  }
                  self.regen_time = time + 0.5;
               }
               if (self.status_flag & ITEM_SECOND_RUNE) {
                  while (e)
                  {
                     if (e.classname == "player") {
                        if (e.health > 0) {
                           if ((teamplay) && (self.team != e.team)) {
                              if (e != self) {
                                 e.button2 = 1;
                                 e.button0 = 1;
                              }
                           } else if (!teamplay) {
                              e.button2 = 1;
                              e.button0 = 1;
                           }
                        }
                     }
                     e = e.chain;
                  }
                  self.regen_time = time + 0.2;
               }
            } else {
               // 15
               dummy = 0;
            }
         } else if (self.rune == 14) {
            // 14 Witch
            // witch's shield
            if (self.status_flag & ITEM_SECOND_RUNE) {
               if (!(self.effects & EF_BRIGHTFIELD))
                  self.effects = self.effects | EF_BRIGHTFIELD;
               if (self.regen_time < time) {
                  ppp = spawn();
                  ppp.classname = "bouncer";
                  e = findradius(self.origin, 200);
                  while (e) {
                     if ((e.classname == "player") && 
                        (e.health > 0) && (e != self) && 
                        ((self.team != e.team) || !(teamplay)))
                        T_Damage(e, ppp, self, 4000);
                     e = e.chain;
                  }
                  remove(ppp);
                  self.regen_time = time + 0.6;
               } 
            }
         } else {
            // 13
            dummy = 0;
         }
      } else if (self.rune > 10) {
         if (self.rune == 12) {
            // 12 White Magic
            if (self.status_flag & ITEM_SECOND_RUNE) {
               if (self.regen_time < time) {
                  if (self.health < 150) {
                     self.health = self.health + 3;
                     e = findradius(self.origin, 300);
                     while (e) {
                        if (e.classname == "player") {
                           if (e.health < 100) {
                              if (e.team == self.team) {
                                 if (teamplay) {
                                    e.health = e.health + 3;
                                 }
                              }
                           }
                        }
                        e = e.chain;
                     }
                     RegenerationSound();
                  }
                  self.regen_time = time + 0.5;
               }
            }
         } else {
            // 11 Foolish
            if (!(self.status_flag & ITEM_SECOND_RUNE)) {
               handleFlight();
            }
         }
      } else if (self.rune == 10) {
         // 10
         dummy = 0;
      } else {
         // 9 Liquid
         e=findradius(self.origin,400);
         while(e){
            if(e.owner.classname=="player" &&
               e.owner!=self&&e.classname!="ghost clone" &&
               (!teamplay||e.owner.team!=self.team)){
               if(e.velocity){
                       if(!e.rune_powerv){
                               e.rune_powerv=1;
                               e.velocity=e.velocity*0.5;
                       }
               }
            }
            e=e.chain;
         }
         if (!(self.status_flag & ITEM_SECOND_RUNE)) {
            if ((self.regen_time < time) && 
               (self.waterlevel >= 1) && 
               (self.health < 150)) {
               if (self.waterlevel >= 2)
                    self.health = self.health + 3;
               else if (self.waterlevel >= 1)
                    self.health = self.health + 2;
   
               self.regen_time = time + 0.5;
               RegenerationSound();
            }
         }
         self.velocity = self.velocity - 0.8*0*frametime*self.velocity;
   
         if (self.rune_count < time) {
               sound (self, CHAN_BODY, "fish/idle.wav", 1, ATTN_NORM);
               self.rune_count = time + 4;
         }
      }
   } else if (self.rune > 4) {
      if (self.rune > 6) {
         if (self.rune == 8) {
            // 8 Strong
            // strong magic
            if (self.status_flag & ITEM_SECOND_RUNE) {
               if (self.regen_time < time) {
                  ppp = findradius(self.origin, 300);
                  while (ppp)
                  {
                     if (ppp.classname == "player") {
                        if (ppp.health > 0) {
                           if (ppp != self) {
                              ppp.reason_died = "radioactive";
                              T_Damage(ppp, self, self, 25);
                              ppp.reason_died = "";
                           }
                        }
                     }
                     ppp = ppp.chain;
                  }
                  self.regen_time = time + 2;
               }
               Shield(self.origin, 450);
            }
         } else {
            // 7 Armor
            // KEY: If player has golden keycard (3), armor
            if (!(self.status_flag & ITEM_SECOND_RUNE)) {
               if (self.regen_time < time) {
                  if (self.armorvalue < 230) {
                     if (!(self.items & IT_ARMOR3)) {
                        self.items = self.items - 
                           (self.items & (IT_ARMOR1 | IT_ARMOR2));
                        self.items = self.items | IT_ARMOR3;
                     }
                     self.armortype = 0.8;
                     self.armorvalue = self.armorvalue + 6;
                     RegenerationSound();
                  }
                  self.regen_time = time + 0.5;
               }
            }
         }
      } else if (self.rune == 6) {
         // 6
         dummy = 0;
      } else {
         // 5 Teleport
         // +++depends on owning rune teleport 
         if(self.rune_power==RUNE_TELEPORT){
            e=findradius(self.origin,200);
            while(e){
               if(e.owner.classname=="player") {
                  if (e.owner!=self) {
                     if (e.classname!="ghost clone") {
                        if (!teamplay||e.owner.team!=self.team) {
                           if (e.velocity) {
                              e.owner=self;
                              ppp=SelectRuneSpawnPoint();
                              e.origin=ppp.origin;
                           }
                        }
                     }
                  }
               }
               e=e.chain;
            }
         }
      }
   } else if (self.rune > 2) {
      if (self.rune == 4) {
         // 4 Elder Magic
         // RUNE: If player has rune of elder magic (4), regeneration
         if (!(self.status_flag & ITEM_SECOND_RUNE)) {
            if (self.regen_time < time) {
               if (self.health < 150) {
                  self.health = self.health + 5;
                  if(self.health>150)self.health=150;
         	      RegenerationSound();
               }
               self.regen_time = time + 0.5;
      		}
      	}
      } else {
         // 3 Hell Magic
         // RUNE: If player has rune of haste (3), ammo
         if (self.status_flag & ITEM_SECOND_RUNE) {
            if (self.regen_time < time) {
               if (self.ammo_shells < 100 && self.ammo_shells <= 95)
                  self.ammo_shells = self.ammo_shells + 5;
               if (self.ammo_shells > 195)
                  self.ammo_shells = 100;
               if (self.ammo_nails < 200 && self.ammo_nails <= 190)
                  self.ammo_nails = self.ammo_nails + 10;
               if (self.ammo_nails > 190)
                  self.ammo_nails = 200;
               if (self.ammo_rockets < 100)
                  self.ammo_rockets = self.ammo_rockets + 1;
               if (self.ammo_cells < 100)
                  self.ammo_cells = self.ammo_cells + 1;
               Inf_SetAmmo(self);
               self.regen_time = time + 4;
               RegenerationSound();
            }
         }
      }
   } else if (self.rune == 2) {
      // 2 Black Magic
      if ((self.status_flag & ITEM_SECOND_RUNE) ||
         (self.key5_flag_count >= time)) {
           // check for water...
           if (self.watertype != CONTENT_WATER)
                   self.watertype = CONTENT_WATER;
           if (self.waterlevel != 2)
                   self.waterlevel = 2;
           if (!(self.flags & FL_FLY))
                   self.flags = self.flags | FL_FLY;
           if (self.movetype != MOVETYPE_FLY)
                   self.movetype = MOVETYPE_FLY;
      }
      if (self.status_flag & ITEM_SECOND_RUNE) {
         if ((self.regen_time < time)) {
            if (self.velocity != '0 0 0') {
               sound (self, CHAN_WEAPON, "hknight/hit.wav", 1, ATTN_NORM);
               self.regen_time = time + 2;
            }
         }
      }
   } else {
      // 1
      dummy = 0;
   }
};

void() handleFlight =
{
   // bprint("handleflight\n");

   PlayerFlight();
   if (!(self.flags & FL_ONGROUND))
           self.flags = self.flags | FL_ONGROUND;
   if (self.flags & FL_JUMPRELEASED)  // make sure the person can't jump
           self.flags = self.flags - FL_JUMPRELEASED;
   if (self.movetype != MOVETYPE_FLY)
           self.movetype = MOVETYPE_FLY;
   if (self.regen_time < time && self.rune != RUNE_FPILOT) {
           sound (self, CHAN_BODY, "hknight/hit.wav", 1, ATTN_NORM);  // special effects
           self.regen_time = time + 2;
   }
   // dont let the person drown
   if (self.waterlevel != 0)
           self.waterlevel = 0;
   // give hermes golden wings
   if (self.rune == RUNE_HERMES) {
           particle (self.origin + '0 0 16' + v_right*20, '0 0 5', 105, 10);
           particle (self.origin + '0 0 16' + v_right*-20, '0 0 5', 105, 10);
   }
};
