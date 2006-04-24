/* world.qc
precaches all the files needed to play quake
*/

// for inferno's precaches
void () gib_float;

// Define some functions, tell Quake to look for them farther within the file. (RED)
//void () worldspawn;

void() InitBodyQue;

void() main = {};

entity	lastspawn;

//=======================
/*QUAKED worldspawn (0 0 0) ?
Only used for the world entity.
Set message to the level name.
Set sounds to the cd track to play.

World Types:
0: medieval
1: metal
2: base
*/
//=======================
void() worldspawn =
{
   //INFERNO: some changes here
   local entity ctf1, ctf2, idctf, oself, head2, e1, e2, e3, e4;
   local string s;

	lastspawn = world;
	runespawn = world;
	runespawned = 0;
	capturespawned = 0;
	teamscored = 0;
	InitBodyQue ();

   // custom map attributes
	if (self.model == "maps/e1m8.bsp")
		cvar_set ("sv_gravity", "100");
	else
		cvar_set ("sv_gravity", "800");

   // it is just silly not to log mapchanges!!!!
   dprint ("DDT: NEW MAP = ");
   dprint(self.model); dprint("\n");

   // dont let the rune become active until some time has passed.
   m4dTimer = time + M4D_TIMER;
   m4dToken = 0;

   // this is how we disable m4d
   if (!(teamplay & M4D_SK1LLZ_ALLOWED))
      m4dToken = 1;
   

   // tell when the gamestart variable should be on
   if (self.model == "maps/start.bsp" || self.model == "maps/sctfs4.bsp") {
      gamestart = 1;
      if (teamplay & ALLOW_RETURN_TO_CTFSTART) {
         idctf = spawn();
         setmodel(idctf, string_null);
         setorigin(idctf, '1536 1726 160');
         setsize(idctf, '0 0 0', '0 0 0');
         oself = self;
         self = idctf;
         InitTrigger ();
         self = oself;
         idctf.touch = voteexit_touch;
         idctf.message = "IDCTF1 Gloom Castles";
         idctf.map = "idctf1";
         idctf.target="e4";
         idctf.cnt = 0;
         
         ctf1 = spawn();
         setmodel(ctf1, string_null);
         setorigin(ctf1, '10 2074 -148');
         setsize(ctf1, '0 0 0', '0 0 0');
         oself = self;
         self = ctf1;
         InitTrigger ();
         self = oself;
         ctf1.touch = voteexit_touch;
         ctf1.message = "Threewave CTF 1 Levels";
         ctf1.map = "ctf1";
         ctf1.target="e4";
         ctf1.cnt = 0;                        
         
         ctf2 = spawn();
         setmodel(ctf2, string_null);
         setorigin(ctf2, '-624 2566 212');
         setsize(ctf2, '0 0 0', '0 0 0');
         oself = self;
         self = ctf2;
         InitTrigger ();
         self = oself;
         ctf2.touch = voteexit_touch;
         ctf2.message = "Threewave CTF 2 Levels";
         ctf2.map = "ctf2m1";
         ctf2.target="e4";
         ctf2.cnt = 0;
      
         e1=spawn();setmodel(e1,string_null);setorigin(e1,'1125 1734 128');
         setsize(e1,'-40 -40 -40','40 40 40');e1.solid=SOLID_TRIGGER;e1.classname="inftriggerm";
         e1.message="Something's Burning here...Smell it?";e1.touch=InfMessageTouch;
      }
   }
   else gamestart = 0;
   // if((self.model=="maps/e2m5.bsp")&&deathmatch){
   //    head2=spawn();head2.touch=InfTeleTouch;head2.classname = "Inferno Teleport";
   //    head2.velocity='0 0 0';head2.movetype=MOVETYPE_NONE;head2.solid=SOLID_TRIGGER;
   //    if(self.model=="maps/e2m5.bsp"){setorigin(head2,'-332 1984 227');head2.inforigin='844 1617 152';}
   //    oself=self;self=head2;self=oself;setsize(head2,'0 0 0', '0 0 0');
   // }


// the area based ambient sounds MUST be the first precache_sounds


   // modules precaches
   BurnPrecacheSounds();
   ShrapnelPrecacheSounds();

// player precaches	
	W_Precache ();			// get weapon precaches

// Set up team notices
	TeamCaptureSetUpdate();

// sounds used from C physics code
	precache_sound ("misc/h2ohit1.wav");		// landing splash

// setup precaches allways needed
	precache_sound ("items/protect.wav");
	precache_sound ("items/protect2.wav");
	precache_sound ("items/protect3.wav");

	precache_sound ("player/plyrjmp8.wav");		// player jump
	precache_sound ("player/land.wav");			// player landing
	precache_sound ("player/land2.wav");		// player hurt landing
	precache_sound ("player/drown1.wav");		// drowning pain
	precache_sound ("player/drown2.wav");		// drowning pain
	precache_sound ("player/gasp1.wav");		// gasping for air
	precache_sound ("player/gasp2.wav");		// taking breath
	precache_sound ("player/h2odeath.wav");		// drowning death

	precache_sound ("misc/talk.wav");			// talk
	precache_sound ("player/teledth1.wav");		// telefrag
	precache_sound ("misc/r_tele1.wav");		// teleport sounds
	precache_sound ("misc/r_tele2.wav");
	precache_sound ("misc/r_tele3.wav");
	precache_sound ("misc/r_tele4.wav");
	precache_sound ("misc/r_tele5.wav");
	precache_sound ("weapons/lock4.wav");		// ammo pick up
	precache_sound ("weapons/pkup.wav");		// weapon up
	precache_sound ("weapons/lhit.wav");		//lightning
	precache_sound ("weapons/lstart.wav");		//lightning start

	precache_sound ("misc/power.wav");			//lightning for boss

// player gib sounds
	precache_sound ("player/gib.wav");			// player gib sound
	precache_sound ("player/udeath.wav");		// player gib sound
	precache_sound ("player/tornoff2.wav");		// gib sound

// player pain sounds

	precache_sound ("player/pain1.wav");
	precache_sound ("player/pain2.wav");
	precache_sound ("player/pain3.wav");
	precache_sound ("player/pain4.wav");
	precache_sound ("player/pain5.wav");
	precache_sound ("player/pain6.wav");

// player death sounds
	precache_sound ("player/death1.wav");
	precache_sound ("player/death2.wav");
	precache_sound ("player/death3.wav");
	precache_sound ("player/death4.wav");
	precache_sound ("player/death5.wav");

// ax sounds	
	precache_sound ("weapons/ax1.wav");			// ax swoosh
	precache_sound ("player/axhit1.wav");		// ax hit meat
	precache_sound ("player/axhit2.wav");		// ax hit world

	precache_sound ("player/h2ojump.wav");		// player jumping into water
	precache_sound ("player/slimbrn2.wav");		// player enter slime
	precache_sound ("player/inh2o.wav");		// player enter water
	precache_sound ("player/inlava.wav");		// player enter lava
	precache_sound ("misc/outwater.wav");		// leaving water sound

	precache_sound ("player/lburn1.wav");		// lava burn
	precache_sound ("player/lburn2.wav");		// lava burn

	precache_sound ("misc/water1.wav");			// swimming
	precache_sound ("misc/water2.wav");			// swimming

	precache_model ("progs/invulner.mdl");
	precache_model ("progs/player.mdl");
	precache_model ("progs/h_player.mdl");

	precache_model ("progs/eyes.mdl");
	precache_model ("progs/gib1.mdl");
	precache_model ("progs/gib2.mdl");
	precache_model ("progs/gib3.mdl");

	precache_model ("progs/s_bubble.spr");	// drowning bubbles
	precache_model ("progs/s_explod.spr");	// sprite explosion

	precache_model ("progs/v_axe.mdl");
	precache_model ("progs/v_shot.mdl");
	precache_model ("progs/v_nail.mdl");
	precache_model ("progs/v_rock.mdl");
	precache_model ("progs/v_shot2.mdl");
	precache_model ("progs/v_nail2.mdl");
	precache_model ("progs/v_rock2.mdl");

	precache_model ("progs/bolt.mdl");		// for lightning gun
	precache_model ("progs/bolt2.mdl");		// for lightning gun
	precache_model ("progs/bolt3.mdl");		// for boss shock
	precache_model ("progs/lavaball.mdl");	// for testing
	
	precache_model ("progs/missile.mdl");
	precache_model ("progs/grenade.mdl");
	precache_model ("progs/spike.mdl");
	precache_model ("progs/s_spike.mdl");

// for hook
	if (cvar("teamplay") & TEAM_CAPTURE_CUSTOM) {
		precache_model ("progs/star.mdl");
		precache_model ("progs/bit.mdl");
		precache_model ("progs/v_star.mdl");
        }
        precache_model ("progs/v_spike.mdl");

	precache_model ("progs/backpack.mdl");

	precache_model ("progs/zom_gib.mdl");

	precache_model ("progs/v_light.mdl");

	

//
// Setup light animation tables. 'a' is total darkness, 'z' is maxbright.
//

	// 0 normal
	lightstyle(0, "m");
	
	// 1 FLICKER (first variety)
	lightstyle(1, "mmnmmommommnonmmonqnmmo");
	
	// 2 SLOW STRONG PULSE
	lightstyle(2, "abcdefghijklmnopqrstuvwxyzyxwvutsrqponmlkjihgfedcba");
	
	// 3 CANDLE (first variety)
	lightstyle(3, "mmmmmaaaaammmmmaaaaaabcdefgabcdefg");
	
	// 4 FAST STROBE
	lightstyle(4, "mamamamamama");
	
	// 5 GENTLE PULSE 1
	lightstyle(5,"jklmnopqrstuvwxyzyxwvutsrqponmlkj");
	
	// 6 FLICKER (second variety)
	lightstyle(6, "nmonqnmomnmomomno");
	
	// 7 CANDLE (second variety)
	lightstyle(7, "mmmaaaabcdefgmmmmaaaammmaamm");
	
	// 8 CANDLE (third variety)
	lightstyle(8, "mmmaaammmaaammmabcdefaaaammmmabcdefmmmaaaa");
	
	// 9 SLOW STROBE (fourth variety)
	lightstyle(9, "aaaaaaaazzzzzzzz");
	
	// 10 FLUORESCENT FLICKER
	lightstyle(10, "mmamammmmammamamaaamammma");

	// 11 SLOW PULSE NOT FADE TO BLACK
	lightstyle(11, "abcdefghijklmnopqrrqponmlkjihgfedcba");
	
	// styles 32-62 are assigned by the light program for switchable lights

	// 63 testing
	lightstyle(63, "a");

// inferno precaches


   if (cvar("teamplay") & TEAM_CAPTURE_CUSTOM) {
           precache_sound ("misc/flagtk.wav");
           precache_sound ("misc/flagcap.wav");
   } else {
           precache_sound ("misc/medkey.wav");
           precache_sound ("doors/meduse.wav");
   }

   precache_model ("progs/w_spike.mdl");
   precache_model ("progs/s_light.spr");
   precache_model ("progs/k_spike.mdl");
   precache_model ("progs/flame2.mdl");
   precache_model ("progs/flame.mdl");
   precache_model ("progs/laser.mdl");
   precache_model ("progs/v_spike.mdl");
   precache_model ("progs/tarbaby.mdl");
   precache_model ("progs/teleport.mdl");
   if (cvar("teamplay") & TEAM_CAPTURE_CUSTOM)
           precache_model ("progs/flag.mdl");
   else {
           precache_model ("progs/w_g_key.mdl");
           precache_model ("progs/w_s_key.mdl");
   }
   precache_model ("progs/v_light.mdl");
   precache_model ("maps/b_rock0.bsp");
   precache_model ("maps/b_shell0.bsp");
   precache_model ("maps/b_shell1.bsp");
   precache_model ("maps/b_bh10.bsp");
   precache_model ("maps/b_bh100.bsp");
   precache_model ("maps/b_bh25.bsp");
   precache_model ("progs/invisibl.mdl");
   precache_model ("progs/invulner.mdl");
   precache_model ("maps/b_batt0.bsp");
   precache_model ("maps/b_batt1.bsp");
   precache_model ("progs/suit.mdl");
   precache_model ("progs/invulner.mdl");

// rune precaches
   precache_model ("progs/end1.mdl");
   precache_model ("progs/end2.mdl");
   precache_model ("progs/end3.mdl");
   precache_model ("progs/end4.mdl");
   precache_model ("progs/m_g_key.mdl");
   precache_model ("progs/m_s_key.mdl");
   precache_model ("progs/b_g_key.mdl");
   precache_model ("progs/b_s_key.mdl");
   precache_model ("progs/w_g_key.mdl");
   precache_model ("progs/w_s_key.mdl");

   // an illusion
   precache_model ("progs/boss.mdl");

   // trickery
   precache_model ("progs/oldone.mdl");

   // death soldier's precaches
   precache_model ("progs/soldier.mdl");
   precache_model ("progs/h_guard.mdl");

   // dog precaches
   precache_model ("progs/dog.mdl");
   precache_model ("progs/h_dog.mdl");

   // rebel knight precaches
   precache_model ("progs/knight.mdl");
   precache_model ("progs/h_knight.mdl");

   precache_model ("progs/fish.mdl");

   // enforcer's models
   precache_model ("progs/enforcer.mdl");
   precache_model ("progs/h_mega.mdl");

   precache_model ("progs/bolt3.mdl");

   // wizard's models
   precache_model2 ("progs/wizard.mdl");
   precache_model2 ("progs/h_wizard.mdl");

   precache_model ("progs/hknight.mdl");
   precache_model ("progs/h_hellkn.mdl");

   // shambler's models
   precache_model ("progs/shambler.mdl");
   precache_model ("progs/h_shams.mdl");

   // zombie's models
   precache_model ("progs/zombie.mdl");
   precache_model ("progs/zom_gib.mdl");
   precache_model ("progs/h_zombie.mdl");

   // shalrath's models
   precache_model2 ("progs/shalrath.mdl");
   precache_model2 ("progs/h_shal.mdl");

   precache_model ("progs/backpack.mdl");

   if (cvar("teamplay") & TEAM_CAPTURE_CUSTOM) {
           precache_sound("rune/rune1.wav");
           precache_sound("rune/rune2.wav");
           precache_sound("rune/rune22.wav");  // special rune and quad combo
           precache_sound("rune/rune3.wav");
           precache_sound("rune/rune4.wav");
   } else {
           precache_sound("boss1/sight1.wav");
           precache_sound("items/r_item1.wav");
           precache_sound("items/damage3.wav");
           precache_sound("items/protect3.wav");
   }

   // ambience
   precache_sound("ambience/thunder1.wav");

   // doors
   precache_sound("doors/runeuse.wav");
   precache_sound ("doors/runetry.wav");

   // misc
   precache_sound("misc/basekey.wav");
   precache_sound ("misc/medkey.wav");
   precache_sound ("misc/runekey.wav");

   // blob
   precache_sound ("blob/hit1.wav");
   precache_sound ("blob/death1.wav");
   precache_sound ("blob/sight1.wav");

   // dog
   precache_sound ("dog/dsight.wav");
   precache_sound("dog/dattack1.wav");
   precache_sound("dog/dpain1.wav");
   precache_sound("dog/ddeath.wav");

   // items
	precache_sound ("items/itembk2.wav");		// item respawn sound
	precache_sound ("items/armor1.wav");		// armor up
	precache_sound ("items/damage3.wav");
   precache_sound ("items/protect.wav");
	precache_sound ("items/protect3.wav");
   precache_sound ("items/r_item1.wav");
   precache_sound ("items/r_item2.wav");
   precache_sound("items/inv1.wav");

   // fish
   precache_sound("fish/bite.wav");
   precache_sound("fish/idle.wav");
   precache_sound("fish/death.wav");

   // ogre
   precache_sound("ogre/ogwake.wav");

   // demon
	precache_sound ("demon/dland2.wav");		// landing thud
   precache_sound("demon/dhit2.wav");

   // wizard
   precache_sound ("wizard/wattack.wav");
   precache_sound ("wizard/hit.wav");
   precache_sound("wizard/wpain.wav");
   precache_sound("wizard/widle1.wav");
   precache_sound("wizard/wsight.wav");

   // boss1
	precache_sound ("boss1/sight1.wav");
   precache_sound ("boss1/out1.wav");
   precache_sound("boss1/pain.wav");

   // boss2
   precache_sound("boss2/idle.wav");

   // death soldier's sounds
   precache_sound ("soldier/sight1.wav");
   precache_sound("soldier/pain1.wav");
   precache_sound("soldier/pain2.wav");
   precache_sound("soldier/idle.wav");

   // earthquake sounds
   precache_sound("misc/menu3.wav");

   // hell knight's sounds 
	precache_sound ("hknight/hit.wav");			// ZOID: hook launch
   precache_sound ("hknight/attack1.wav");
   precache_sound("hknight/sight1.wav");
   precache_sound("hknight/pain1.wav");
   precache_sound("hknight/death1.wav");
   precache_sound("hknight/idle.wav");
   precache_sound("hknight/slash1.wav");

   // knight's sounds 
   precache_sound("knight/ksight.wav");
   precache_sound("knight/khurt.wav");
   precache_sound("knight/idle.wav");

   // enforcer's sounds
   precache_sound ("enforcer/sight2.wav");
   precache_sound ("enforcer/enfire.wav");
   precache_sound ("enforcer/enfstop.wav");
   precache_sound("enforcer/pain1.wav");
   precache_sound("enforcer/pain2.wav");
   precache_sound("enforcer/idle1.wav");

   // zombie's sounds
   precache_sound("zombie/z_pain.wav");
   precache_sound("zombie/z_idle.wav");
   precache_sound("zombie/z_idle1.wav");
   precache_sound("zombie/z_miss.wav");
   precache_sound("zombie/z_hit.wav");

   // shambler's sounds
   precache_sound ("shambler/sboom.wav");
   precache_sound("shambler/melee1.wav");
   precache_sound("shambler/sidle.wav");
   precache_sound("shambler/sattck1.wav");
   precache_sound("shambler/shurt2.wav");

   // shalrath's sounds
   precache_sound2 ("shalrath/attack.wav");
   precache_sound2 ("shalrath/attack2.wav");
   precache_sound2 ("shalrath/death.wav");
   precache_sound2 ("shalrath/idle.wav");
   precache_sound2 ("shalrath/pain.wav");
   precache_sound2 ("shalrath/sight.wav");


};

void() StartFrame =
{
	teamplay = cvar("teamplay");
	skill = cvar("skill");
	framecount = framecount + 1;

   // do it now (random bases?)
   if ((teamplay & TEAM_RANDOM_BASES) &&
   flag_switched != 1 && (flag_switched != 2)) {
      if (random() < 0.5)
         flag_switched = 1;
      else flag_switched = 2;
   }
};

/*
==============================================================================

BODY QUE

==============================================================================
*/

entity	bodyque_head;

void() bodyque =
{	// just here so spawn functions don't complain after the world
	// creates bodyques
};

void() InitBodyQue =
{
	local entity	e;
	
	bodyque_head = spawn();
	bodyque_head.classname = "bodyque";
	bodyque_head.owner = spawn();
	bodyque_head.owner.classname = "bodyque";
	bodyque_head.owner.owner = spawn();
	bodyque_head.owner.owner.classname = "bodyque";
	bodyque_head.owner.owner.owner = spawn();
	bodyque_head.owner.owner.owner.classname = "bodyque";
	bodyque_head.owner.owner.owner.owner = bodyque_head;
};


// make a body que entry for the given ent so the ent can be
// respawned elsewhere
void(entity ent) CopyToBodyQue =
{
	bodyque_head.skin = ent.skin;
	bodyque_head.angles = ent.angles;
	bodyque_head.model = ent.model;
//        bodyque_head.modelindex = modelindex_dog;
        bodyque_head.modelindex = ent.modelindex;
	bodyque_head.frame = ent.frame;
	bodyque_head.colormap = ent.colormap;
	bodyque_head.movetype = ent.movetype;
	bodyque_head.velocity = ent.velocity;
	bodyque_head.flags = 0;
	setorigin (bodyque_head, ent.origin);
	setsize (bodyque_head, ent.mins, ent.maxs);
	bodyque_head = bodyque_head.owner;

        // water flags
//        bodyque_head.think = gib_float;
//        bodyque_head.nextthink = time + 0.5;
        bodyque_head.solid = SOLID_NOT;
};


