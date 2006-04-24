/* weapons.qc - by idsoftware, modified by a whole bunch
of people and finally me!! :)  This script deals with the weapons
being used and other stuff (like impulse commands)...
*/

void (entity e, float f) startEEManager;

void () togglePlayerId;
void () W_FirePlague;
void() T_ChainTouch;
void() HookVanish;
void() HookPull;
void (entity e) BreakChain;
void (float accessParm) StartSelectPlayer;
float () HandleDigitInput;

void (entity targ, entity inflictor, entity attacker, float damage) T_Damage;
void () player_run;
//void () enf_run1;
void() RuneApplyPowers;  
void () VengHead_Spawn;
// important thing is here
void (string c, string m, void() t) launch_inf;

/*### RAIDEN'S FRAMES ###*/
void () raiden_fire1;

/*### KANO'S FRAMES ###*/
void () kano_fire1;

/*### KANG'S FRAMES ###*/
void () kang_fire1;

/*### ZOMBIE'S FRAMES ###*/
void () zombie_atta1;

/*### SOLDIER'S FRAMES ###*/
void () sol_attk;
// void () sol_fragm;

/*### SHAMBLER'S FRAMES ###*/
void () sham_attk;
void () sham_magic1;
void () sham_madness;

/*### SHALRATH'S FRAMES ###*/
void () shal_attack1;
void () shal_attk1;
void () shal_chain1;
void () shal_axe1;

/*### ENFORCER'S FRAMES ###*/
void () enf_atk5;
void () enf_nail1;

/*### ZOMBIE'S FRAMES ###*/
void () zomb_att1;
void () zomb_nail1;

/*### KNIGHT'S FRAMES ###*/
void () knight_attack;
void () knight_nail1;

void(entity bomb, entity attacker, float rad, entity ignore) T_RadiusDamage;
void(vector org, vector vel, float damage) SpawnBlood;
void() SuperDamageSound;
void() HasteSound;
void() W_FireRocket;

// for new admin control
void () OperChk;

// take armor for key8
float (float gweapon) Key8ArmorTake;
float (float gweapon) Key8ArmorVal;

/* Super Powerups */
// void() BMGroundExplosions;
//void() T_LBTouch;

/* RUNES/KEYS ## Weapons for runes or keys ## */
void () W_FireBubbler;  // bubbler
void () W_FireFire_Ball;  // fire ball (KEY8_FLAG)
//void () W_FireTeleporter;  // teleporter gun spawned by a rune
void () T_TeleTouch;  // teleporter gun touch
void () W_FireJetPack;  // bouncer gun
void () W_FireClone;  // clone maker
void () T_LightningBTouch;  // lightning bolt
void () W_FireMultiRockets;  // now this IS REALLY SCARY!
void () W_FirePortal;  // portal master's main weapon (escape!)
// void () W_FireFan;  // fan from Kitana
//void () W_FireHome;  // homing missiles for sektor
void () W_TeleportSektor;  // the teleport-punch for sektor
void () W_Howl;  // the werewolf's howl
void () W_FireGreenFireball;  // johnny cage's green fireball
void () W_FireJCage;  // fire johnny cage's move
void () W_FireKnife;  // kano's knife
void () T_HeadTouch;  // kung lao's head (hat)
// void () W_LaoSpin;  // kung lao's whirlwind spin
void () T_ZombieGTouch;  // Zombie's gibs touch
void () T_CTouch;  // Noisy Cricket
void () T_TorchTouch;  // torch touch
// void () T_FragmTouch;  // fragmentation grenade
// void () TWireThink;  // trip wire think
void (float ox) W_FireDarts;  // Tarantula's Poison Darts
void () SetBoobyTrap;     // Tarantula's Traps
void (float ox) W_FireDarts;  // Tarantula's Poison Darts
void () SetBoobyTrap;     // Tarantula's Traps
//void () W_FireTripWire;//trip wire
//void () T_SewerTouch;  // Sewertouch

// ** BEGINNING ** //
// weapons for using
void () NotifyWeapon;  // notifies what current weapon you have
//void () W_FireIdent;  // identifier
//void () W_FireBlackhole;  // blackhole
//void () W_FireFreez;  // freeze weapon
void () W_FireSniper;  // sniper gun
//void () W_FireMine;  // mine thrower
void () W_FireFlare;  // flaregun
void (float ox) W_FireKSpike;  // hell knight spike gun
void () W_FireMassiveKSpikes;  // massive spikes!
// void () W_FireFlame;  // flamethrower
void (float ox) W_FireFlame2;  // firethrower
void () W_FireMassiveFlames;  // massive flames!!
void () W_FireAcid;  // acid thrower
void () W_FireGibGun;  // gib gun
void () W_FireLavaball;  // lavagun
void () W_FirePlasma;  // plasma gun
void () W_FireMindGas;  // mind gas
void () W_FireFreez;  // Freeze gun
void () W_FireLaser;  // laser
void () W_FireSuperM;  // super missile
void () W_FirePipeBomb;  // pipe bomb
void () ShrapnelMissileFire;// Shrapnel missle
void (entity flagg) ThrowFlag;  // toss the flag
// void () BombSet;  // setting the timer for the bomb
// ** END ** //

// ** BEGINNING ** //
// commands for use
void () ShowWhoOn;
void () ShowTeamplay;
void () ShowDeathmatch;
void () VoteForExit;  // exiting levels
void () VoteLockDownFlags; // prevent team flag pick-up
void () ShowTimelimit;
void () ShowFraglimit;
void (vector org, entity death_owner) spawn_tdeath;
// ** END ** //

// sound for regenerating
void () RegenerationSound;

// When we want to test new impulses, put them here
float() CheckDevCmd;

// called by worldspawn
void() W_Precache =
{

   precache_sound ("dog/dsight.wav");
   precache_model ("progs/dog.mdl");

   precache_sound ("hknight/hit.wav");  // flamethrower

   precache_sound ("weapons/r_exp3.wav");   // new rocket explosion
   precache_sound ("weapons/rocket1i.wav");   // spike gun
   precache_sound ("weapons/sgun1.wav");
   precache_sound ("weapons/guncock.wav");   // player shotgun
   precache_sound ("weapons/ric1.wav");   // ricochet (used in c code)
   precache_sound ("weapons/ric2.wav");   // ricochet (used in c code)
   precache_sound ("weapons/ric3.wav");   // ricochet (used in c code)
   precache_sound ("weapons/spike2.wav");   // super spikes
   precache_sound ("weapons/tink1.wav");   // spikes tink (used in c code)
   precache_sound ("weapons/grenade.wav");   // grenade launcher
   precache_sound ("weapons/bounce.wav");      // grenade bounce
   precache_sound ("weapons/shotgn2.wav");   // super shotgun
   precache_sound ("zombie/z_fall.wav");   // tarantula darts
   
   precache_sound2 ("blob/land1.wav");     // chain go splorch!
   if (cvar("teamplay") & TEAM_CAPTURE_CUSTOM) {
      precache_sound ("weapons/chain1.wav");
      precache_sound ("weapons/chain2.wav");
      precache_sound ("weapons/chain3.wav");
      precache_sound ("weapons/bounce2.wav");
   }

   // ZOID:
   // normally the weapon models are precached in the individual item
   // creation routines.  But since we've added impulse 21 we can drop
   // weapons at any time.  Must precache all weapon models.
   precache_model ("progs/g_shot.mdl");
   precache_model ("progs/g_nail.mdl");
   precache_model ("progs/g_nail2.mdl");
   precache_model ("progs/g_rock.mdl");
   precache_model ("progs/g_rock2.mdl");
   precache_model ("progs/g_light.mdl");
};

float() crandom = {return 2*(random() - 0.5);};

void() Duck2Stand =
{
         if (self.pl_duck == 1) { // remove ducking
            // sprint(self, "duck and wine, yummy!\n");
            self.pl_duck = 4; // stop ducking
            self.pl_duck_time = 0;
            self.velocity_z = 450; // stand up
         }
};
/*
void() WizardsRadius =
{
        local entity tntn;

        if (self.owner.key_flag & ITEM_KEY1_FLAG) {
                tntn = findradius(self.owner.origin, 600);
                while (tntn)
                {
                        if ((tntn != self.owner) && (tntn != world) && (tntn.takedamage))
                                T_Damage (tntn, self.owner, self.owner, 120);
                        tntn = tntn.chain;
                }
        }
        self.owner.effects = self.owner.effects - EF_BRIGHTLIGHT;
        remove(self);
        return;
};

void() WarningWizard =
{
        local entity tntn;
        local string ppp;

        ppp = ftos(self.count_count);
        tntn = findradius(self.owner.origin, 500);
        while (tntn)
        {
                if (tntn != self.owner && tntn != world && tntn.classname == "player")
                        ncenterprint(tntn, "You have ", ppp, " seconds and counting to\nescape from ", self.owner.netname, "'s magic!", "", "");
                if (tntn == self.owner)
                        ncenterprint(tntn, "You have ", ppp, " seconds till reload", "", "", "", "");
                tntn = tntn.chain;
        }
        if (self.count_count <= 0) {
                WizardsRadius();
                return;
        }
        if (!(self.owner.key_flag & ITEM_KEY1_FLAG)) {
                self.owner.effects = self.owner.effects - EF_BRIGHTLIGHT;
                remove(self);
                return;
        }
        self.count_count = self.count_count - 1;
        self.nextthink = time + 1;
};
*/

/****************************************************************\
*
* HOW TO GET MULTIKEY NUMERIC INPUT FROM THE USER
* - generic input, player mode
* 
* Define an impulse, < 256, which will be used to signal user 
* input.
* When the player sends the impulse, set entity field inputType
* to the impulse, clear the impulse, set inputCount to 1 for the
* first digit, and set inputNo to 0.
* When the inputType is set, bump inputCount for each digit,
* and save the accumulated value in inputNo.  
* When input is complete, clear the inputType, inputCount,
* and inputNo.
* When checking digit input, the user is expected to type 
* impulse 10 for 0 and impulse 22 for 9.
*
\****************************************************************/

void() handleNumericInput = 
{
   sprint(self, "\n");
   if (self.impulse == 10)
      self.impulse = 0;
      
   // handle the case of 12 digit IP input for banning players 
   if (self.inputType == 57)
   {
      if (self.inputCount == 12)
      {
         // last digit in
         self.inputNo = self.inputNo * 10;
         self.inputNo = self.inputNo + self.impulse;
         self.ip4 = self.inputNo;
         self.inputNo = 0;
         self.ips4 = ftos(self.ip4);
         localcmd ("ban on \n"); 
         localcmd ("ban "); 
         self.ips1 = ftos(self.ip1);
         sprint(self, "[");
         sprint(self,self.ips1);
         sprint(self, ".");
         localcmd(self.ips1); 
         localcmd("."); 

         self.ips2 = ftos(self.ip2); 
         sprint(self,self.ips2);
         sprint(self, ".");
         localcmd(self.ips2); 
         localcmd("."); 

         self.ips3 = ftos(self.ip3);
         sprint(self,self.ips3);
         sprint(self, ".");
         localcmd(self.ips3); 
         localcmd("."); 

         self.ips4 = ftos(self.ip4);
         sprint(self,self.ips4);
         sprint(self, "]\n");
         localcmd(self.ips4); 
         localcmd("\n");

         self.inputType = 0;
         self.inputCount = 0;
         self.impulse = 0;
         return;

      }
      else if (self.inputCount == 11)
      {
         self.inputNo = self.inputNo * 10;
         self.inputNo = self.inputNo + self.impulse;
         sprint(self, "enter last digit now: \n");
         self.inputCount = self.inputCount + 1;
      }
      else if (self.inputCount == 10)
      {
         self.inputNo = self.inputNo * 10;
         self.inputNo = self.inputNo + self.impulse;
         sprint(self, "enter eleventh digit now: \n");
         self.inputCount = self.inputCount + 1;
      }
      else if (self.inputCount == 9)
      {
         self.inputNo = self.inputNo * 10;
         self.inputNo = self.inputNo + self.impulse;
         self.ip3 = self.inputNo;
         self.ips3 = ftos(self.ip3);
         self.inputNo = 0;
         sprint(self, "enter tenth digit now: \n");
         self.inputCount = self.inputCount + 1;
      }
      else if (self.inputCount == 8)
      {
         self.inputNo = self.inputNo * 10;
         self.inputNo = self.inputNo + self.impulse;
         sprint(self, "enter ninth digit now: \n");
         self.inputCount = self.inputCount + 1;
      }
      else if (self.inputCount == 7)
      {
         self.inputNo = self.inputNo * 10;
         self.inputNo = self.inputNo + self.impulse;
         sprint(self, "enter eighth digit now: \n");
         self.inputCount = self.inputCount + 1;
      }
      else if (self.inputCount == 6)
      {
         self.inputNo = self.inputNo * 10;
         self.inputNo = self.inputNo + self.impulse;
         self.ip2 = self.inputNo;
         self.ips2 = ftos(self.ip2);
         self.inputNo = 0;
         sprint(self, "enter seventh digit now: \n");
         self.inputCount = self.inputCount + 1;
      }
      else if (self.inputCount == 5)
      {
         self.inputNo = self.inputNo * 10;
         self.inputNo = self.inputNo + self.impulse;
         sprint(self, "enter sixth digit now: \n");
         self.inputCount = self.inputCount + 1;
      }
      else if (self.inputCount == 4)
      {
         self.inputNo = self.inputNo * 10;
         self.inputNo = self.inputNo + self.impulse;
         sprint(self, "enter fifth digit now: \n");
         self.inputCount = self.inputCount + 1;
      }
      else if (self.inputCount == 3)
      {
         self.inputNo = self.inputNo * 10;
         self.inputNo = self.inputNo + self.impulse;
         self.ip1 = self.inputNo;
         self.ips1 = ftos(self.ip1);
         self.inputNo = 0;
         sprint(self, "enter fourth digit now: \n");
         self.inputCount = self.inputCount + 1;
      }
      else if (self.inputCount == 2)
      {
         self.inputNo = self.inputNo * 10;
         self.inputNo = self.inputNo + self.impulse;
         sprint(self, "enter third digit now: \n");
         self.inputCount = self.inputCount + 1;
      }
      else if (self.inputCount == 1)
      {
         self.inputNo = self.impulse;
         sprint(self, "enter second digit now: \n");
         self.inputCount = self.inputCount + 1;
      }
      return;
   }

};

/*
================
W_FireAxe
================
*/
void() W_FireAxe =
{
   local vector source, org;
   local float col;

   // woopie, gamestart
   if(gamestart&&(teamplay&TEAM_CUSTOM_SCTF)&&(self.nitems&NITEM_CONV)&&self.ammo_rockets>=1) {
           W_FireRocket();
           self.attack_finished = time + 1;
           return;
   }

//   if ((self.inferno_flag & ABLE_KEY9_FLAG) && (self.key9_flag_count >= time))
//           sound (self, CHAN_WEAPON, "dog/dsight.wav", 1, ATTN_NORM);

   makevectors (self.v_angle);
   source = self.origin + '0 0 16';

   if ((self.rune == RUNE_KINTARO && !(self.status_flag & ITEM_SECOND_RUNE)) ||
   (self.rune == RUNE_TURTLE && (self.status_flag & ITEM_SECOND_RUNE))) {
           traceline (source, source + v_forward*128, FALSE, self);
           if(self.rune==RUNE_KINTARO){col=450;if(self.rune_count<time){sound(self,CHAN_AUTO,"shambler/melee1.wav",1,ATTN_NORM);self.rune_count=time+0.5;}}
           if(self.rune==RUNE_TURTLE){col=50+random()*12;if(self.rune_count<time){sound(self,CHAN_AUTO,"demon/dhit2.wav",1,ATTN_NORM);self.rune_count=time+0.5;}}
           particle (source + v_forward*60, v_forward*-6, col, 10);
           particle (source + v_forward*60 + v_right*20, v_forward*-6, col, 10);
           particle (source + v_forward*60 + v_right*-20, v_forward*-6, col, 10);
   } else
           traceline (source, source + v_forward*64, FALSE, self);
   if (trace_fraction == 1.0)
      return;
   
   org = trace_endpos - v_forward*4;
   if (trace_ent.takedamage)
   {
      trace_ent.axhitme = 1;
      SpawnBlood (org, '0 0 0', 20);
      if (self.runeb_rune == RUNE_WITCH && self.runeb_time >= time) {
              if (trace_ent.classname == "player")
                      trace_ent.reason_died = "dog bite";
              T_Damage (trace_ent, self, self, 40);
              if (trace_ent.classname == "player")
                      trace_ent.reason_died = "";
      } else if (self.rune == RUNE_KINTARO && !(self.status_flag & ITEM_SECOND_RUNE))
              T_Damage (trace_ent, self, self, 35);
      else
              T_Damage (trace_ent, self, self, 20);
   }
   else
   {   // hit wall
      sound (self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
      WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
      WriteByte (MSG_BROADCAST, TE_GUNSHOT);
      WriteCoord (MSG_BROADCAST, org_x);
      WriteCoord (MSG_BROADCAST, org_y);
      WriteCoord (MSG_BROADCAST, org_z);
   }
};


//============================================================================


vector() wall_velocity =
{
   local vector   vel;
   
   vel = normalize (self.velocity);
   vel = normalize(vel + v_up*(random()- 0.5) + v_right*(random()- 0.5));
   vel = vel + 2*trace_plane_normal;
   vel = vel * 200;
   
   return vel;
};


/*
================
SpawnMeatSpray
================
*/
void(vector org, vector vel) SpawnMeatSpray =
{
   local   entity missile, mpuff;
   local   vector   org;

   missile = spawn ();
   missile.owner = self;
   missile.movetype = MOVETYPE_BOUNCE;
   missile.solid = SOLID_NOT;

   makevectors (self.angles);

   missile.velocity = vel;
   missile.velocity_z = missile.velocity_z + 250 + 50*random();

   missile.avelocity = '3000 1000 2000';
   
// set missile duration
   missile.nextthink = time + 1;
   missile.think = SUB_Remove;

   setmodel (missile, "progs/zom_gib.mdl");
   setsize (missile, '0 0 0', '0 0 0');      
   setorigin (missile, org);
};

/*
================
SpawnBlood
================
*/
void(vector org, vector vel, float damage) SpawnBlood =
{
   particle (org, vel*0.1, 73, damage*2);
};

/*
================
spawn_touchblood
================
*/
void(float damage) spawn_touchblood =
{
   local vector   vel;

   vel = wall_velocity () * 0.2;
   SpawnBlood (self.origin + vel*0.01, vel, damage);
};


/*
================
SpawnChunk
================
*/
void(vector org, vector vel) SpawnChunk =
{
   particle (org, vel*0.02, 0, 10);
};

/*
==============================================================================

MULTI-DAMAGE

Collects multiple small damages into a single damage

==============================================================================
*/

entity   multi_ent;
float   multi_damage;

void() ClearMultiDamage =
{
   multi_ent = world;
   multi_damage = 0;
};

void() ApplyMultiDamage =
{
   if (!multi_ent)
      return;

        multi_ent.reason_died = "bullets";
        T_Damage (multi_ent, self, self, multi_damage);
        multi_ent.reason_died = "";
};

void(entity hit, float damage) AddMultiDamage =
{
   if (!hit)
      return;
   
   if (hit != multi_ent)
   {
      ApplyMultiDamage ();
      multi_damage = damage;
      multi_ent = hit;
   }
   else {
      if (self.rune == RUNE_M4D_SK1LLZ)
         multi_damage = multi_damage + damage * 100;
      else
         multi_damage = multi_damage + damage;
   }
};

/*
==============================================================================

BULLETS

==============================================================================
*/

/*
================
TraceAttack
================
*/
void(float damage, vector dir) TraceAttack =
{
   local   vector   vel, org;
   
   vel = normalize(dir + v_up*crandom() + v_right*crandom());
   vel = vel + 2*trace_plane_normal;
   vel = vel * 200;

   org = trace_endpos - dir*4;

   if (trace_ent.takedamage)
   {
      SpawnBlood (org, vel*0.2, damage);
      AddMultiDamage (trace_ent, damage);
   }
   else
   {
      WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
      WriteByte (MSG_BROADCAST, TE_GUNSHOT);
      WriteCoord (MSG_BROADCAST, org_x);
      WriteCoord (MSG_BROADCAST, org_y);
      WriteCoord (MSG_BROADCAST, org_z);
   }
};

/*
================
FireBullets

Used by shotgun, super shotgun, and enemy soldier firing
Go to the trouble of combining multiple pellets into a single damage call.
================
*/
void(float shotcount, vector dir, vector spread) FireBullets =
{
        local   vector direction, src;
   
   makevectors(self.v_angle);

   src = self.origin + v_forward*10;
   src_z = self.absmin_z + self.size_z * 0.7;

   ClearMultiDamage ();
   while (shotcount > 0)
   {
      direction = dir + crandom()*spread_x*v_right + crandom()*spread_y*v_up;

      traceline (src, src + direction*2048, FALSE, self);
      if (trace_fraction != 1.0)
         TraceAttack (4, direction);

      shotcount = shotcount - 1;
   }
   ApplyMultiDamage ();
};

/*
================
W_FireShotgun
================
*/
void() W_FireShotgun =
{
   local vector dir;

        sound (self, CHAN_WEAPON, "weapons/guncock.wav", 1, ATTN_NORM);

   self.punchangle_x = -2;
   
   self.currentammo = self.ammo_shells = self.ammo_shells - 1;
   dir = aim (self, 100000);
        FireBullets (6, dir, '0.04 0.04 0');

        if (self.ammo_shells < 1) {
                self.weapon = W_BestWeapon ();
                self.nweapon = W_BestNWeapon (self.weapon);
                W_SetCurrentAmmo ();
        }
};


/*
================
W_FireSuperShotgun
================
*/
void() W_FireSuperShotgun =
{
   local vector dir;

   if (self.currentammo == 1)
   {
      W_FireShotgun ();
      return;
   }
      
   sound (self ,CHAN_WEAPON, "weapons/shotgn2.wav", 1, ATTN_NORM);   

   self.punchangle_x = -4;
   
   self.currentammo = self.ammo_shells = self.ammo_shells - 2;
   dir = aim (self, 100000);
   FireBullets (14, dir, '0.14 0.08 0');

        if (self.ammo_shells < 2) {
                self.weapon = W_BestWeapon ();
                self.nweapon = W_BestNWeapon (self.weapon);
                W_SetCurrentAmmo ();
        }
};


/*
==============================================================================

ROCKETS

==============================================================================
*/

void()   s_explode1   =   [0,      s_explode2] {};
void()   s_explode2   =   [1,      s_explode3] {};
void()   s_explode3   =   [2,      s_explode4] {};
void()   s_explode4   =   [3,      s_explode5] {};
void()   s_explode5   =   [4,      s_explode6] {};
void()  s_explode6      =       [5,             SUB_Remove] {};

void() inf_exp1 = [0, inf_exp2] {};
void() inf_exp2 = [1, inf_exp3] {};
void() inf_exp3 = [2, inf_exp4] {};
void() inf_exp4 = [3, inf_exp5] {};
void() inf_exp5 = [0, inf_exp6] {};
void() inf_exp6 = [1, inf_exp7] {};
void() inf_exp7 = [2, inf_exp8] {};
void() inf_exp8 = [3, inf_exp9] {};
void() inf_exp9 = [0, inf_exp10] {};
void() inf_exp10 = [2, inf_exp11] {};
void() inf_exp11 = [4, inf_exp12] {};
void() inf_exp12 = [5, SUB_Remove] {};

void() BecomeExplosion =
{
   // bprint("become ex\n");
   self.movetype = MOVETYPE_NONE;
   self.velocity = '0 0 0';
   self.touch = SUB_Null;
   setmodel (self, "progs/s_explod.spr");
   self.solid = SOLID_NOT;
   s_explode1 ();
};

void() T_MissileTouch =
{
   local float   damg;
   local entity e;
   if (self.owner)
      e = self.owner;
   else if (self.goalentity)
      e = self.goalentity;
   else
      e = world;
   if (e == world) {
      // bprint("returning world\n");
      return world;
   }

   // ahem.  some would call this a hack :)
   // if owner had a quad type powerup, radius damage may kill
   // the missile before it can explode on a wall.
   // if ((self.classname == "doggyGuard") ||
   //    (self.classname == "doggyAttack"))
   //    self.health = self.health + 500;

   if (other == e)// && self.classname != "ghost's missile")
   {
      // bprint("other = e\n");
      return;         // don't explode on owner
   }

   if (pointcontents(self.origin) == CONTENT_SKY)
   {
      // counter
      if (self.classname == "homing missile")
         e.rune12clone_count = e.rune12clone_count - 1;
      else if ((self.classname == "life missile") ||
         (self.classname == "doggyGuard") ||
         (self.classname == "doggyAttack"))
      {
         if (e.clone1 == self)
            e.clone1 = world;
         else if (e.clone2 == self)
            e.clone2 = world;
      }
      // bprint("hit sky\n");
      remove(self);
      return;
   }

   if(self.rune_power==RUNE_HELL_MAGIC)
           damg = 140 + random()*40;
   else damg = 100 + random()*20;
   
   if (other.health)
   {
      if (self.count_count == 2) {
              if (e.classname == "ghost clone")
                      T_Damage (other, self, e.goalentity, 10);
              else T_Damage (other, self, e, 10);
      } else if (e.classname == "ghost clone")
              T_Damage (other, self, e.goalentity, damg);
      else if (self.classname == "dog missile")
              T_Damage(other, self, e, 5);
      else T_Damage (other, self, e, damg );

      if(other.classname=="player"&&self.classname=="dog missile") {
              other.bugs="flees";
              other.bugs_time=time + 8;  // eat em up for 5 seconds
              other.bugs_owner=e;  // who do they belong to?
      }
   }

   // don't do radius damage to the other, because all the damage
   // was done in the impact
   if (e.classname == "ghost clone")
      T_RadiusDamage (self, e.goalentity, 120, other);
   else if (self.classname != "dog missile") 
      T_RadiusDamage (self, e, 120, other);

   self.origin = self.origin - 8*normalize(self.velocity);

   WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
   WriteByte (MSG_BROADCAST, TE_EXPLOSION);
   WriteCoord (MSG_BROADCAST, self.origin_x);
   WriteCoord (MSG_BROADCAST, self.origin_y);
   WriteCoord (MSG_BROADCAST, self.origin_z);

   // counter
   if (self.classname == "homing missile")
      e.rune12clone_count = e.rune12clone_count - 1;
   else if ((self.classname == "life missile") ||
      (self.classname == "doggyGuard") || 
      (self.classname == "doggyAttack"))
   {
      if (e.clone1 == self)
         e.clone1 = world;
      else if (e.clone2 == self)
         e.clone2 = world;
   }

   // bprint("calling becomeexplosion\n");
   BecomeExplosion ();
};

/*
================
W_FireRocket
================
*/
void() W_FireRocket =
{
   local   entity missile, mpuff;
   
        if (self.nweapon != NEW_AXE || ((self.rune != RUNE_NAVY_OFFICER ||
        (self.status_flag & ITEM_SECOND_RUNE)) &&
        (self.rune != RUNE_ILLUSION || !(self.status_flag & ITEM_SECOND_RUNE)))) {
                if (self.nweapon==NEW_DOG)
                        self.currentammo=self.ammo_cells=self.ammo_cells - 1;
                else self.currentammo = self.ammo_rockets = self.ammo_rockets - 1;
        }
   
        if (self.nweapon==NEW_DOG)
                sound (self, CHAN_WEAPON, "dog/dattack1.wav", 1, ATTN_NORM);
        else sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);

   self.punchangle_x = -2;

   missile = spawn ();
   missile.owner = self;
   missile.movetype = MOVETYPE_FLYMISSILE;
   missile.solid = SOLID_BBOX;
        missile.classname = "rocket";
        if (self.classname == "ghost clone")
                missile.classname = "ghost's missile";
        if(self.nweapon==NEW_DOG)
                missile.classname = "dog missile";
      
// set missile speed   

   makevectors (self.v_angle);
   missile.velocity = aim(self, 1000);

        if(gamestart&&self.nweapon==NEW_AXE&&(teamplay & TEAM_CUSTOM_SCTF)&&(self.nitems&NITEM_CONV)) {
                missile.velocity=missile.velocity * 400;
                missile.frame=3;
                if(random()<0.5)missile.skin=1;
        }
        else missile.velocity = missile.velocity * 1000;
   missile.angles = vectoangles(missile.velocity);
   
   missile.touch = T_MissileTouch;
   
// set missile duration
        missile.nextthink = time + 5;
        missile.think = SUB_Remove;

        if ((self.rune == RUNE_DISAPEAR) && (self.status_flag & ITEM_SECOND_RUNE))
                setmodel (missile, string_null);
        else if ((self.rune == RUNE_ILLUSION) && (self.status_flag & ITEM_SECOND_RUNE))
                setmodel (missile, "progs/boss.mdl");
        else if (self.nweapon==NEW_DOG)
                setmodel (missile, "progs/dog.mdl");
        else
                setmodel (missile, "progs/missile.mdl");
   setsize (missile, '0 0 0', '0 0 0');      
   setorigin (missile, self.origin + v_forward*8 + '0 0 16');

        if (self.nweapon==NEW_DOG) {
                if(self.ammo_cells<1) {
                        self.weapon=W_BestWeapon();
                        self.nweapon=W_BestNWeapon(self.weapon);
                        W_SetCurrentAmmo();
                }
                return;
        }
   
        if (self.ammo_rockets < 1 && self.nweapon != NEW_AXE && ((self.rune != RUNE_NAVY_OFFICER
        || (self.status_flag & ITEM_SECOND_RUNE)) &&
        (self.rune != RUNE_ILLUSION || !(self.status_flag & ITEM_SECOND_RUNE)))) {
                self.weapon = W_BestWeapon();
                self.nweapon = W_BestNWeapon(self.weapon);
                W_SetCurrentAmmo();
        }

};

/*
===============================================================================

LIGHTNING

===============================================================================
*/

/*
=================
LightningDamage
=================
*/
void(vector p1, vector p2, entity from, float damage) LightningDamage =
{
   local float hasrune;
   local entity            e1, e2;
   local vector      f;

   if (from.rune == RUNE_RAIDEN && !(from.status_flag & ITEM_SECOND_RUNE))
           hasrune = 1;

   f = p2 - p1;
   normalize (f);
   f_x = 0 - f_y;
   f_y = f_x;
   f_z = 0;
   f = f*16;

   e1 = e2 = world;

   traceline (p1, p2, FALSE, self);

   // INFERNO:  person's damage doubles because of the frankenstein-pet rune (lightning)
   if ((from.rune == RUNE_FP && !(from.status_flag & ITEM_SECOND_RUNE)) ||
   (from.rune==RUNE_CWORKER&&!(from.status_flag & ITEM_SECOND_RUNE)))
           damage = damage * 2;

   if(from.classname=="mlightning")damage=damage*4;

   if (trace_ent.takedamage)
   {
      particle (trace_endpos, '0 0 100', 225, damage*4);
      T_Damage (trace_ent, from, from, damage);
      if (hasrune) {
         if (trace_ent.classname == "player") {
              trace_ent.reason_died = "bouncer";
              T_Damage (trace_ent, from, from, 1000);
              trace_ent.reason_died = "";
         }
      }
      if (self.classname == "player")
      {
         if (other.classname == "player")
            trace_ent.velocity_z = trace_ent.velocity_z + 400;
      }
   }
   e1 = trace_ent;

   traceline (p1 + f, p2 + f, FALSE, self);
   if ((trace_ent != e1) && trace_ent.takedamage)
   {
      particle (trace_endpos, '0 0 100', 225, damage*4);
      T_Damage (trace_ent, from, from, damage);
      if (hasrune) {
         if (trace_ent.classname == "player") {
            trace_ent.reason_died = "bouncer";
            T_Damage (trace_ent, from, from, 1000);
            trace_ent.reason_died = "";
         }
      }
   }
   e2 = trace_ent;

   traceline (p1 - f, p2 - f, FALSE, self);
   if ((trace_ent != e1) && (trace_ent != e2) && trace_ent.takedamage)
   {
      particle (trace_endpos, '0 0 100', 225, damage*4);
      T_Damage (trace_ent, from, from, damage);
      if (hasrune) {
         if (trace_ent.classname == "player") {
            trace_ent.reason_died = "bouncer";
            T_Damage (trace_ent, from, from, 1000);
            trace_ent.reason_died = "";
         }
      }
   }
};


void() W_FireLightning =
{
   local   vector      org;
   local   float           cells, ifcan;
   local entity lightn;

   ifcan = 0;

   if(self.classname=="mlightning")makevectors(self.angles);
   if (self.waterlevel <= 1)
           ifcan = 1;
   if ((self.rune == RUNE_POSEIDON) && !(self.status_flag & ITEM_SECOND_RUNE))
           ifcan = 1;
   if ((self.rune == RUNE_BLACK_MAGIC) && (self.status_flag & ITEM_SECOND_RUNE))
           ifcan = 1;

   if (self.ammo_cells < 1 && self.nweapon != NEW_AXE)
   {
      self.weapon = W_BestWeapon ();
      self.nweapon = W_BestNWeapon(self.weapon);
      W_SetCurrentAmmo ();
      return;
   }

   // explode if under water
   if (!ifcan)
   {
      lightn = spawn();
      lightn.classname = "lightning gun";
      cells = self.ammo_cells;
      self.ammo_cells = 0;
      W_SetCurrentAmmo ();
      T_Damage (self, lightn, self, 35*cells);
      T_RadiusDamage (lightn, self, 35*cells, world);
      remove(lightn);
      return;
   }

   if (self.t_width < time)
   {
      if (self.rune == RUNE_THUNDER && !(self.status_flag & ITEM_SECOND_RUNE)) {
              sound (self, CHAN_WEAPON, "ambience/thunder1.wav", 1, ATTN_NORM);
              self.t_width = time + 3.5;
      } else {
              sound (self, CHAN_WEAPON, "weapons/lhit.wav", 1, ATTN_NORM);
              self.t_width = time + 0.6;
      }
   }
   self.punchangle_x = -2;

   if ((self.rune != RUNE_POSEIDON || (self.status_flag & ITEM_SECOND_RUNE)) &&
   (self.nweapon != NEW_AXE))
           self.currentammo = self.ammo_cells = self.ammo_cells - 1;

   
   if (self.rune == RUNE_FP && !(self.status_flag & ITEM_SECOND_RUNE)) {
           org = self.origin + '0 0 16' + v_up*40;
           traceline (org, org + v_forward*600, TRUE, self);
   } else if (self.rune==RUNE_CWORKER && !(self.status_flag & ITEM_SECOND_RUNE)) {
           org = self.origin + '0 0 16';
           traceline(org, org + v_forward*450, TRUE, self);
   } else {
           org = self.origin + '0 0 16';
           traceline (org, org + v_forward*600, TRUE, self);
   }

   WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
   if (self.rune == RUNE_FP && !(self.status_flag & ITEM_SECOND_RUNE))
           WriteByte (MSG_BROADCAST, TE_LIGHTNING1);
   else if (self.rune == RUNE_CWORKER&&!(self.status_flag & ITEM_SECOND_RUNE))
           WriteByte(MSG_BROADCAST, TE_LIGHTNING3);
   else WriteByte (MSG_BROADCAST, TE_LIGHTNING2);
   WriteEntity (MSG_BROADCAST, self);
   WriteCoord (MSG_BROADCAST, org_x);
   WriteCoord (MSG_BROADCAST, org_y);
   WriteCoord (MSG_BROADCAST, org_z);
   WriteCoord (MSG_BROADCAST, trace_endpos_x);
   WriteCoord (MSG_BROADCAST, trace_endpos_y);
   WriteCoord (MSG_BROADCAST, trace_endpos_z);

   if ((pointcontents(trace_endpos) == CONTENT_WATER || pointcontents(trace_endpos) == CONTENT_SLIME ||
   pointcontents(trace_endpos) == CONTENT_LAVA) && (self.rune == RUNE_THUNDER &&
   !(self.status_flag & ITEM_SECOND_RUNE)) && self.time_count < time) {
           lightn = findradius(trace_endpos, 200);
           while (lightn) {
                   if (lightn.waterlevel && lightn.classname == "player") {
                           lightn.reason_died = "thunder-lightning";
                           T_Damage(lightn, self, self, 5);
                           lightn.reason_died = "";
                   }
                   lightn = lightn.chain;
           }
           lightn = spawn();
           lightn.movetype = MOVETYPE_FLY;
           setmodel(lightn, "progs/s_bubble.spr");
           setsize(lightn, '0 0 0', '0 0 0');
           setorigin(lightn, trace_endpos);
           lightn.velocity_z = 55 + random()*100;
           lightn.velocity_x = random()*100 - 80;
           lightn.velocity_y = random()*100 - 50;
           lightn.classname = "bubble";
           lightn.solid = SOLID_NOT;
           lightn.think = SUB_Remove;
           lightn.nextthink = time + 2;
           self.time_count = time + 0.3;
   }

   LightningDamage (self.origin, trace_endpos + v_forward*4, self, 30);

   if (self.ammo_shells < 1 && self.nweapon != NEW_AXE) {
           self.weapon = W_BestWeapon ();
           self.nweapon = W_BestNWeapon (self.weapon);
           W_SetCurrentAmmo ();
   }
};


//=============================================================================


void() GrenadeExplode =
{
   local entity e;
   if (self.owner)
      e = self.owner;
   else if (self.goalentity)
      e = self.goalentity;
   else
      e = world;
   if (e != world)
   {
      local entity head, selected;
      local float dist;
      if (self.rune == RUNE_ANT) T_RadiusDamage (self, e, 160, world);
      else if(self.classname=="pipe bomb") {T_RadiusDamage(self, e, 140, world);e.pb=0;}
      // Warf: Bump damage for tarantula trap
      else if(self.classname=="boobytrap") {
              T_RadiusDamage(self, e, 200, world);
              // sprint (self.goalentity, "Booby Trap explode!\n"); //
              }
      else if (self.classname=="cgrenade") {
              local entity e1;
              e=findradius(self.origin, 200);
              while(e1) {
                      if(e1.takedamage && e1.health)
                              T_Damage(e1, self, e, 15);
                      e1=e1.chain;
              }
              self.classname="bouncer";
              T_RadiusDamage(self, e, 600, world);
      } else T_RadiusDamage (self, e, 120, world);
   }
   WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
   WriteByte (MSG_BROADCAST, TE_EXPLOSION);
   WriteCoord (MSG_BROADCAST, self.origin_x);
   WriteCoord (MSG_BROADCAST, self.origin_y);
   WriteCoord (MSG_BROADCAST, self.origin_z);

   BecomeExplosion ();
};


void() GrenadeTouch =
{
   local entity e;
   if (self.owner)
      e = self.owner;
   else if (self.goalentity)
      e = self.goalentity;
   else
      e = world;
   if (e == world)
      return;

   // bprint("touch grenade\n");
   if (other == e)
   {
      // bprint("touch by owner\n");
      if (self.classname == "pipe bomb")
      {
         // bprint("a pb\n");
         if (!other.eeFlag)
         {
            if (other.nweapon == NEW_AXE)
            {
               // bprint("a axe\n");
               if (!other.rune)
               {
                  // bprint("no rune\n");
                  {
                     // bprint("no eeflag\n");
                     startEEManager (other, NP_EGG);
                  }
               }
            }
         }
      }
      return;         // don't explode on owner
   }
   if (other.takedamage == DAMAGE_AIM && self.classname != "cgrenade")
   {
      GrenadeExplode();
      return;
   }
   sound (self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);   // bounce sound
   if (self.velocity == '0 0 0')
      self.avelocity = '0 0 0';
};

/*
================
W_FireGrenade
================
*/
void() W_FireGrenade =
{
   local   entity missile, mpuff;
   
        if(self.nweapon!=NEW_AXE) {
                if(self.nweapon == NEW_CGRENADE)
                        self.currentammo = self.ammo_cells = self.ammo_cells - 1;
                else self.currentammo = self.ammo_rockets = self.ammo_rockets - 1;
        }
   
        if (self.rune == RUNE_ANT && !(self.status_flag & ITEM_SECOND_RUNE))
                sound (self, CHAN_WEAPON, "wizard/wsight.wav", 1, ATTN_NORM);
        else sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);

   self.punchangle_x = -2;

        if (self.rune == RUNE_PUNISHER && !(self.status_flag & ITEM_SECOND_RUNE) && self.ammo_rockets >= 2) {
                self.ammo_rockets = self.ammo_rockets - 1;
                launch_inf("grenade1", "progs/grenade.mdl", GrenadeTouch);
                launch_inf("grenade2", "progs/grenade.mdl", GrenadeTouch);
                return;
        }

   missile = spawn ();
   missile.owner = self;
   missile.movetype = MOVETYPE_BOUNCE;
   missile.solid = SOLID_BBOX;
        if(self.weapon==IT_DOG_LAUNCHER&&self.nweapon==NEW_CGRENADE)
                missile.classname = "cgrenade";
        else
                missile.classname = "grenade";
      
        if (self.rune == RUNE_ANT && !(self.status_flag & ITEM_SECOND_RUNE) && self.nweapon == NEW_AXE) {missile.rune=self.rune;missile.classname="explode person";}

// set missile speed   

        makevectors (self.v_angle);

        if (self.v_angle_x)
      missile.velocity = v_forward*600 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
   else
   {
      missile.velocity = aim(self, 10000);
                missile.velocity = missile.velocity * 1000;
      missile.velocity_z = 200;
   }

        if (missile.rune != RUNE_ANT) missile.avelocity = '300 300 300';

   missile.angles = vectoangles(missile.velocity);
   
   missile.touch = GrenadeTouch;
   
// set missile duration
        missile.nextthink = time + 2.5;
   missile.think = GrenadeExplode;

        if (self.rune == RUNE_DISAPEAR && (self.status_flag & ITEM_SECOND_RUNE))
                setmodel (missile, string_null);
        else if (missile.rune==RUNE_ANT) {
                setmodel (missile, "progs/player.mdl");
                missile.avelocity_x=600;
        } else if (self.nweapon==NEW_CGRENADE)
                setmodel (missile, "progs/s_light.spr");
        else
                setmodel (missile, "progs/grenade.mdl");
        if (missile.rune == RUNE_ANT) setsize (missile, '-12 -12 -12', '12 12 12');
        else setsize (missile, '0 0 0', '0 0 0');
   setorigin (missile, self.origin);

        if (self.nweapon==NEW_CGRENADE) {
                if (self.ammo_cells<1) {
                        self.weapon=W_BestWeapon();
                        self.nweapon=W_BestNWeapon(self.weapon);
                        W_SetCurrentAmmo();
                }
                return;
        }

        if (self.ammo_rockets < 1 && self.nweapon != NEW_AXE) {
                self.weapon = W_BestWeapon();
                self.nweapon = W_BestNWeapon(self.weapon);
                W_SetCurrentAmmo();
        }
         if (self.rune == RUNE_FOOLISH && 
            !(self.status_flag & ITEM_SECOND_RUNE)) {
            local float fx;
            local float fy;
            local float fz;
            fx = random() * 320 - 160;
            fy = random() * 320 - 160;
            fz = 320 - fx - fy;
            fz = fz * (-1);
            missile.velocity_x = fx;
            missile.velocity_y = fy;
            missile.velocity_z = fz;
         }
};


//=============================================================================

void() spike_touch;
void() superspike_touch;


/*
===============
launch_spike

Used for both the player and the ogre
===============
*/
void(vector org, vector dir) launch_spike =
{
   newmis = spawn ();
   newmis.owner = self;
   newmis.movetype = MOVETYPE_FLYMISSILE;
   newmis.solid = SOLID_BBOX;

   newmis.angles = vectoangles(dir);
   
   newmis.touch = spike_touch;
   newmis.classname = "spike";
   newmis.think = SUB_Remove;
   newmis.nextthink = time + 6;
   setmodel (newmis, "progs/spike.mdl");

        if ((self.rune == RUNE_DISAPEAR) && (self.status_flag & ITEM_SECOND_RUNE))
                setmodel (newmis, string_null);

   setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);      
   setorigin (newmis, org);

   newmis.velocity = dir * 1000;
};

void() W_FireSuperSpikes =
{
   local vector   dir;
   local entity   old;
        local float r;
   
        if (self.rune == RUNE_FPILOT && (self.status_flag & ITEM_SECOND_RUNE))
                sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 1, ATTN_NORM);
        else if (self.rune == RUNE_ROBOT && (self.status_flag & ITEM_SECOND_RUNE))
                sound (self, CHAN_WEAPON, "enforcer/enfire.wav", 1, ATTN_NORM);
        else if (self.rune == RUNE_VAMPIRE && (self.status_flag & ITEM_SECOND_RUNE)) {
                if (self.time_count2 < time) {
                        sound (self, CHAN_WEAPON, "wizard/wattack.wav", 1, ATTN_NORM);
                        self.time_count2 = time + 1.4;
                }
        } else if (self.rune == RUNE_DEMETER && !(self.status_flag & ITEM_SECOND_RUNE)) {
                if (self.time_count2 < time) {
                        sound (self, CHAN_WEAPON, "player/inh2o.wav", 1, ATTN_NORM);
                        self.time_count2 = time + 0.5;
                }
        } else sound (self, CHAN_WEAPON, "weapons/spike2.wav", 1, ATTN_NORM);
   self.attack_finished = time + 0.2;
        if ((self.rune == RUNE_WEAPONS && !(self.status_flag & ITEM_SECOND_RUNE)) ||
        (self.rune == RUNE_DREAM && !(self.status_flag & ITEM_SECOND_RUNE))) {
                dir = self.origin + '0 0 16';
                traceline (dir, dir + v_forward*300, FALSE, self);
                if (self.rune == RUNE_WEAPONS)
                        particle (trace_endpos, '0 0 0', 111, 15);
                else {
                        r = random()*100;
                        particle (trace_endpos, '0 0 0', r, 15);
                }

                if (trace_ent.takedamage)
                        SpawnBlood (trace_endpos, '0 0 0', 30);
                if (trace_ent.health > 0 && trace_ent.classname == "player") {
                        if (self.rune == RUNE_WEAPONS)
                                trace_ent.reason_died = "spark cannon";
                        else trace_ent.reason_died = "rainbow";
                        T_Damage (trace_ent, self, self, 10);
                        trace_ent.reason_died = "";
                } else if (trace_ent.takedamage) T_Damage (trace_ent, self, self, 10);
                return;
        }
//        if ((self.rune != RUNE_ROBOT || !(self.status_flag & ITEM_SECOND_RUNE)) &&
//        (self.rune != RUNE_VAMPIRE || !(self.status_flag & ITEM_SECOND_RUNE)))
        self.currentammo = self.ammo_nails = self.ammo_nails - 2;
   dir = aim (self, 1000);
   launch_spike (self.origin + '0 0 16', dir);
   newmis.touch = superspike_touch;
        newmis.classname = "superspike";
        if ((self.rune == RUNE_FPILOT && (self.status_flag & ITEM_SECOND_RUNE)) ||
        (self.rune == RUNE_ROBOT && (self.status_flag & ITEM_SECOND_RUNE)) ||
        (self.rune == RUNE_VAMPIRE && (self.status_flag & ITEM_SECOND_RUNE)) ||
        (self.rune == RUNE_DEMETER && !(self.status_flag & ITEM_SECOND_RUNE)))
                newmis.rune = self.rune;
//        newmis.status_flag = self.status_flag;

//        if (self.rune == RUNE_FPILOT && (self.status_flag & ITEM_SECOND_RUNE))
//                newmis.rune = 1;

        if (self.rune == RUNE_DISAPEAR && (self.status_flag & ITEM_SECOND_RUNE))
                setmodel (newmis, string_null);
        else if (self.rune == RUNE_FPILOT && (self.status_flag & ITEM_SECOND_RUNE))
                setmodel (newmis, "progs/missile.mdl");
        else if (self.rune == RUNE_ROBOT && (self.status_flag & ITEM_SECOND_RUNE))
                setmodel (newmis, "progs/laser.mdl");
        else if (self.rune == RUNE_DEMETER && !(self.status_flag & ITEM_SECOND_RUNE))
                setmodel (newmis, "progs/s_bubble.spr");
        else if (self.rune == RUNE_VAMPIRE && (self.status_flag & ITEM_SECOND_RUNE))
                setmodel (newmis, "progs/w_spike.mdl");
        else
                setmodel (newmis, "progs/s_spike.mdl");
   setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);      
   self.punchangle_x = -2;

        if (self.ammo_nails < 2) {
                self.weapon = W_BestWeapon();
                self.nweapon = W_BestNWeapon(self.weapon);
                W_SetCurrentAmmo();
        }

};

void(float ox) W_FireSpikes =
{
   local vector   dir;
   local entity   old;
   
   makevectors (self.v_angle);
   
   if (self.ammo_nails >= 2 && self.weapon == IT_SUPER_NAILGUN)
   {
      W_FireSuperSpikes ();
      return;
   }

   if (self.ammo_nails < 1)
   {
      self.weapon = W_BestWeapon ();
                self.nweapon = W_BestNWeapon (self.weapon);
      W_SetCurrentAmmo ();
      return;
   }

        sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 1, ATTN_NORM);
   self.attack_finished = time + 0.2;
   self.currentammo = self.ammo_nails = self.ammo_nails - 1;
   dir = aim (self, 1000);
   launch_spike (self.origin + '0 0 16' + v_right*ox, dir);

   self.punchangle_x = -2;

        if (self.ammo_nails < 1) {
                self.weapon = W_BestWeapon();
                self.nweapon = W_BestNWeapon(self.weapon);
                W_SetCurrentAmmo();
        }

};



.float hit_z;
void() spike_touch =
{
        local float rand;

        if (other == self.owner)
                return;


   if (other.solid == SOLID_TRIGGER)
      return;   // trigger field, do nothing

   if (pointcontents(self.origin) == CONTENT_SKY)
   {
      remove(self);
      return;
   }
   
// hit something that bleeds
   if (other.takedamage)
   {
      
      spawn_touchblood (9);
      T_Damage (other, self, self.owner, 9);
      
   }
   else
   {
      WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
      
      if (self.classname == "wizspike")
         WriteByte (MSG_BROADCAST, TE_WIZSPIKE);
      else if (self.classname == "knightspike")
         WriteByte (MSG_BROADCAST, TE_KNIGHTSPIKE);
      else
         WriteByte (MSG_BROADCAST, TE_SPIKE);
      WriteCoord (MSG_BROADCAST, self.origin_x);
      WriteCoord (MSG_BROADCAST, self.origin_y);
      WriteCoord (MSG_BROADCAST, self.origin_z);
   }
        if (self.rune)
                BecomeExplosion();
        else remove(self);

};

void() superspike_touch =
{
        local float rand;

        if (other == self.owner) 
                return;

   if (other.solid == SOLID_TRIGGER)
      return;   // trigger field, do nothing

   if (pointcontents(self.origin) == CONTENT_SKY)
   {
      remove(self);
      return;
   }
   
// hit something that bleeds
//        other =self.owner;
   if (other.takedamage)
   {
                if (self.rune == RUNE_FPILOT || self.rune == RUNE_ROBOT ||
                self.rune == RUNE_VAMPIRE) {
                        spawn_touchblood (20);
                        T_Damage (other, self, self.owner, 20);
//                } else if (self.rune == RUNE_ROBOT || self.rune == RUNE_VAMPIRE) {
//                        spawn_touchblood (7);
//                        T_Damage (other, self, self.owner, 7);
                } else if (self.rune == RUNE_DEMETER) {
                        spawn_touchblood (10);
                        T_Damage (other, self, self.owner, 10);
                        if (other.classname == "player") {
                                other.runeb_rune = RUNE_DEMETER;
                                other.runeb_time = time + 10;
                                UpdatePlayerStatus(other, "You have been trapped in a Soda's\nBubble for 10 seconds!\n\n\n\n\n\n\n\n\n\n\n", "", "");
                        }
                } else {
                        spawn_touchblood (18);
                        T_Damage (other, self, self.owner, 18);
                }
   }
   else
   {
      WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
      WriteByte (MSG_BROADCAST, TE_SUPERSPIKE);
      WriteCoord (MSG_BROADCAST, self.origin_x);
      WriteCoord (MSG_BROADCAST, self.origin_y);
      WriteCoord (MSG_BROADCAST, self.origin_z);
   }
        if (self.rune == RUNE_ROBOT)
                sound (self, CHAN_BODY, "enforcer/enfstop.wav", 1, ATTN_NORM);
        remove(self);

};


/*
===============================================================================

PLAYER WEAPON USE

===============================================================================
*/

void() W_SetCurrentAmmo =
{
   local float quantity = 0; // Allows me to change ammo counts without removing ammo

//        if ((self.key_flag & ITEM_KEY2_FLAG) && (self.status_flag & ITEM_SECOND_RUNE))
//                enf_run1 ();
//        else

        // if dog
        player_run ();          // get out of any weapon firing states

   self.items = self.items - ( self.items & (IT_SHELLS | IT_NAILS | IT_ROCKETS | IT_CELLS) );
   
   if (self.weapon == IT_AXE)
   {
                if (self.nweapon == NEW_AXE || self.nweapon == NEW_RP) {
                        self.currentammo = 0;
//                        self.weaponmodel = "progs/v_axe.mdl";
                        self.weaponframe = 0;
                } else if (self.nweapon == NEW_HGRENADE) {
                        self.items = self.items | IT_ROCKETS;
                        self.currentammo = self.ammo_rockets;
//                      self.weaponmodel = "progs/v_axe.mdl";
                        self.weaponframe = 0;
                } else if (self.nweapon == NEW_HOOK) {
                        self.currentammo = 0;
                        if (teamplay & TEAM_CAPTURE_CUSTOM) 
//                                self.weaponmodel = "progs/v_star.mdl";
//                        else
//                                self.weaponmodel = "progs/v_axe.mdl";
                        self.weaponframe = 0;
                }
   }
   else if (self.weapon == IT_SHOTGUN)
   {
		self.weaponmodel = "progs/v_shot.mdl";
		self.weaponframe = 0;
		if (self.nweapon == NEW_PLASMA)
		{
			quantity = (self.ammo_rockets / AMMO_PLASMA);
			self.currentammo = quantity;
			self.items = self.items | IT_ROCKETS;
		}
		if (self.nweapon == NEW_SNIPER)
		{
			if (self.ammo_shells > self.ammo_rockets) {
				quantity = (self.ammo_rockets / AMMO_SNIPER);
			} else
				quantity = (self.ammo_shells / AMMO_SNIPER);
			self.currentammo = quantity;
			self.items = self.items | IT_ROCKETS;
		}
		else if (self.nweapon == NEW_SHOTGUN) {
			self.currentammo = self.ammo_shells;
			self.items = self.items | IT_SHELLS;
		}
   }
   else if (self.weapon == IT_SUPER_SHOTGUN)
   {
		self.weaponmodel = "progs/v_shot2.mdl";
		self.weaponframe = 0;
		if (self.nweapon == NEW_FLARE) {
			quantity = self.ammo_shells / AMMO_FLARE;
			self.currentammo = quantity;
			self.items = self.items | IT_SHELLS;
		}
		else if (self.nweapon == NEW_KSPIKE) {
			quantity = self.ammo_nails / AMMO_KSPIKE;
			self.currentammo = quantity;
			self.items = self.items | IT_NAILS;
		}
		else if (self.nweapon == NEW_SUPER_SHOTGUN) {
			self.currentammo = self.ammo_shells;
			self.items = self.items | IT_SHELLS;
		}
   }
   else if (self.weapon == IT_NAILGUN)
   {
		self.weaponmodel = "progs/v_nail.mdl";
		self.weaponframe = 0;
		if (self.nweapon == NEW_FLAME) {
//			quantity = self.ammo_nails / AMMO_FLAME;
			self.currentammo = self.ammo_nails;
			self.items = self.items | IT_NAILS;
		}
		else if (self.nweapon == NEW_MINES) {
		        local float available = 0;
		        
			available = MAX_MINES - self.proxiCount;
			quantity = self.ammo_rockets / AMMO_MINE;
			if (quantity > MAX_MINES) { quantity = MAX_MINES; }
			if (quantity < available) { self.currentammo = quantity; }
			else self.currentammo = available;
			
			self.items = self.items | IT_ROCKETS;
		} 
		else if (self.nweapon == NEW_NAIL) {
			self.currentammo = self.ammo_nails;
			self.items = self.items | IT_NAILS;
		}
   }
   else if (self.weapon == IT_SUPER_NAILGUN)
   {
		self.weaponmodel = "progs/v_nail2.mdl";
		self.weaponframe = 0;
		if (self.nweapon == NEW_ACID) {
			quantity = self.ammo_nails / AMMO_ACID;
			self.currentammo = quantity;
			self.items = self.items | IT_NAILS;
		}
		else if (self.nweapon == NEW_GIBGUN) {
			quantity = self.ammo_rockets / AMMO_GIBGUN;
			self.currentammo = quantity;
			self.items = self.items | IT_ROCKETS;
		} 
		else if (self.nweapon == NEW_SUPER_NAIL) {
			self.currentammo = self.ammo_nails;
			self.items = self.items | IT_NAILS;
		}
   }
   else if (self.weapon == IT_GRENADE_LAUNCHER)
   {
		self.weaponmodel = "progs/v_rock.mdl";
		self.weaponframe = 0;
		if (self.nweapon == NEW_PB) {
			self.currentammo = self.ammo_rockets;
			self.items = self.items | IT_ROCKETS;
		}
		else if (self.nweapon == NEW_SHRAPNEL) {
          		quantity = self.ammo_rockets / AMMO_SHRAPNEL;
			self.currentammo = quantity;
			self.items = self.items | IT_ROCKETS;
		} 
		else if (self.nweapon == NEW_GRENADE) {
			self.currentammo = self.ammo_rockets;
			self.items = self.items | IT_ROCKETS;
		}
   }
   else if (self.weapon == IT_ROCKET_LAUNCHER)
   {
		self.weaponmodel = "progs/v_rock2.mdl";
		self.weaponframe = 0;
		self.items = self.items | IT_ROCKETS;
		if (self.nweapon == NEW_MINDG) {
			quantity = self.ammo_rockets / AMMO_MINDG;
			self.currentammo = quantity;
		}
		else if (self.nweapon == NEW_LAVAGUN) {
			quantity = self.ammo_rockets / AMMO_LAVAGUN;
			self.currentammo = quantity;
		} 
		else if (self.nweapon == NEW_ROCKET)
			self.currentammo = self.ammo_rockets;
   }
   else if (self.weapon == IT_LIGHTNING)
   {
		self.weaponmodel = "progs/v_light.mdl";
		self.weaponframe = 0;
		if (self.nweapon == NEW_LASER) {
			quantity = self.ammo_nails / AMMO_LASER;
			self.currentammo = quantity;
			self.items = self.items | IT_NAILS;
		}
		else if (self.nweapon == NEW_SUPERM) {
			quantity = self.ammo_rockets;
			self.currentammo = quantity;
			self.items = self.items | IT_ROCKETS;
		} 
		else if (self.nweapon == NEW_LIGHTNING) {
			self.currentammo = self.ammo_cells;
			self.items = self.items | IT_CELLS;
		}
   }
        else if (self.weapon == IT_DOG_LAUNCHER)
        {
                self.weaponframe=0;
                self.items = self.items | IT_CELLS;
        }
        else
   {
      self.currentammo = 0;
      self.weaponmodel = "";
      self.weaponframe = 0;
   }

        // set the current ammo
        Inf_SetAmmo(self);

        // chasecam, disable model in chase view
/*
        if ((self.speed & CHSCAM_ON) || ((self.inferno_flag & ABLE_KEY9_FLAG) &&
        (self.key9_flag_count >= time)) || ((self.rune == RUNE_DISAPEAR) &&
        !(self.status_flag & ITEM_SECOND_RUNE)) ||
        ((self.rune == RUNE_REPTILE) && (self.status_flag & ITEM_SECOND_RUNE)) ||
        ((self.rune == RUNE_GHOST) && !(self.status_flag & ITEM_SECOND_RUNE)) ||
        ((self.rune == RUNE_HERMES) && (self.status_flag & ITEM_SECOND_RUNE)))
                self.weaponmodel = "";*/
};

float() W_BestWeapon =
{
   local   float   it;
   
   it = self.items;

        if (self.waterlevel <= 1 && self.ammo_cells >= 1 && (it & IT_LIGHTNING) )
                return IT_LIGHTNING;
   if(self.ammo_nails >= 2 && (it & IT_SUPER_NAILGUN) )
      return IT_SUPER_NAILGUN;
        if (self.ammo_shells >= 2 && (it & IT_SUPER_SHOTGUN))
      return IT_SUPER_SHOTGUN;
        if (self.ammo_nails >= 2 && (it & IT_NAILGUN) )
                return IT_NAILGUN;
        if (self.ammo_nails >= 1 && (it & IT_NAILGUN) )
      return IT_NAILGUN;
        if (self.ammo_shells >= 1 && (it & IT_SHOTGUN) )
      return IT_SHOTGUN;
        return IT_AXE;
};

float() W_CheckNoAmmo =
{
   //if (self.proxiCount >= MAX_MINES)
   //   return TRUE;

   if (self.currentammo > 0)
      return TRUE;

        if (self.weapon == IT_AXE)
      return TRUE;
   
   self.weapon = W_BestWeapon ();

        self.nweapon = W_BestNWeapon(self.weapon);

   W_SetCurrentAmmo ();
   
// drop the weapon down
   return FALSE;
};

/*
============
W_Attack

An attack impulse can be triggered now
============
*/
// DOG DEFS
void()  dog_atta1;
void() dog_howl;

void()   player_axe1;
void()   player_axeb1;
void()   player_axec1;
void()   player_axed1;
void()   player_shot1;
void()   player_nail1;
void()   player_light1;
void()   player_rocket1;
void()   player_chain1;
void()  player_chain3;

// Enforcer's DEFS
void()  enf_chain1;
void()  enf_chain3;
void()  enf_light1;

// Knight's DEFS
void()  knight_chain1;
void()  knight_chain3;
void()  knight_light1;

// Zombie's DEFS
void()  zomb_chain1;
void()  zomb_chain3;
void()  zomb_light1;

void() W_Attack =
{
   local float r, tntn, fpbf;
   local entity pumpers, ppp, fpbe;
   local vector v1, v2;  // never can be too sure!

   if ( self.isBot )
      return;

   // take off initial invincibility
   takeOffInitialInvincibility (self);

   // can't shoot when you're arrested
   if ((self.runeb_rune == RUNE_COP) && (self.runeb_time >= time))
           return;

   // can't shoot when you're a zombie-made zombie
   if ((self.runeb_rune == RUNE_ZOMBIE) && (self.runeb_time >= time))
           return;


   // can't shoot anything if you're a dog
   if (self.runeb_rune == RUNE_WITCH && self.runeb_time >= time) {
           sound (self, CHAN_WEAPON, "dog/dsight.wav", 1, ATTN_NORM);
           dog_atta1();
           self.attack_finished = time + 0.5;
           return;
   }
   // or a zombie
   if (self.runeb_rune == RUNE_DEATH && self.runeb_time >= time)
           return;
   // if (self.runeb_rune == RUNE_DEATH && self.runeb_time >= time) {
   //         sound (self, CHAN_WEAPON, "zombie/z_idle1.wav", 1, ATTN_NORM);
   //         zombie_atta1();
   //         self.attack_finished = time + 0.5;
   //         return;
   // }

   if (!(self.status_flag & ITEM_SECOND_RUNE) && (self.rune == RUNE_HELL_MAGIC))
           tntn = 0;
   else tntn = 1;

   if (!W_CheckNoAmmo ())
      return;

   makevectors   (self.v_angle);         // calculate forward angle for velocity
   self.show_hostile = time + 1;   // wake monsters up

   if (self.weapon == IT_AXE)
   {
      if (self.nweapon == NEW_AXE) {
         sound (self, CHAN_WEAPON, "weapons/ax1.wav", 1, ATTN_NORM);
         r = random();
         if (r < 0.25)
                 player_axe1 ();
         else if (r<0.5)
                 player_axeb1 ();
         else if (r<0.75)
                 player_axec1 ();
         else
                 player_axed1 ();

         // Put the nail in for the flag!!!
         if((teamplay&TEAM_PICK_BASE)&&(!team1_flag_picked||
         !team2_flag_picked)&&(self.pick_flag_base)){
            fpbf=0;
            if(self.watertype==CONTENT_SLIME||self.watertype==CONTENT_LAVA)
                    sprint(self,"Fool!  You can't place the flag in slime or lava\n");
            else {
               fpbe=findradius(self.origin,1000);
               while(fpbe){
                  if(self.team==TEAM_COLOR1+1&&fpbe.classname=="item_flag_team2"&&CanDamage(fpbe,self)){
                          sprint(self,"Sorry, you're too close to the enemy flag!\n");
                          fpbf=1;
                  }
                  if(self.team==TEAM_COLOR2+1&&fpbe.classname=="item_flag_team1"&&CanDamage(fpbe,self)){
                          sprint(self,"Sorry, you're too close to the enemy flag!\n");
                          fpbf=1;
                  }
                  fpbe=fpbe.chain;
               }
               fpbe=world;
               fpbe=findradius(self.origin,250);
               while(fpbe){
                  if(fpbe.classname=="plat"||fpbe.classname=="train"||fpbe.classname=="func_plat"||fpbe.classname=="func_train"||fpbe.classname=="func_button"||fpbe.classname=="door"||fpbe.classname=="func_door"){
                          sprint(self,"Sorry, you can't put it next to a moving object!\n");
                          fpbf=1;
                  }
                  fpbe=fpbe.chain;
               }
               if(!fpbf) FireNailForFlag();
            }
         }

         // RUNE: 
         if (self.rune == RUNE_MEDIC && (self.status_flag & ITEM_SECOND_RUNE)) {
                 W_FirePlague();
                 self.attack_finished = time + 0.8;  // rox reload time
         } else if (!(tntn)) {   // hell magic
                 self.attack_finished = time + 0.25;
                 HasteSound();
         } else if (self.rune == RUNE_FUTURE && !(self.status_flag & ITEM_SECOND_RUNE)) {
                 Duck2Stand();
                 W_FireJetPack();
                 self.attack_finished = time + 0.5;
         } else if (self.rune == RUNE_TELEPORT && !(self.status_flag & ITEM_SECOND_RUNE)) {
                 sound (self, CHAN_WEAPON, "blob/sight1.wav", 1, ATTN_NORM);
                 launch_inf("teleporter", "progs/k_spike.mdl", T_TeleTouch);
                 self.attack_finished = time + 1;
         } else if (self.rune == RUNE_FOOLISH) {
            if (!(self.status_flag & ITEM_SECOND_RUNE)) {
                player_rocket1();
                W_FireGrenade();
                W_FireGrenade();
                W_FireGrenade();
                W_FireGrenade();
                W_FireGrenade();
                W_FireGrenade();
                self.attack_finished = time + 1.2;
            }
         } else if (self.rune == RUNE_ARTEMIS) {
                 W_FireHome();
                 self.attack_finished = time + 1.2;
         } else if (self.rune == RUNE_KANG && !(self.status_flag & ITEM_SECOND_RUNE)) {
                 W_FireFlame2(0);
                 self.attack_finished = time + 0.5;
         } else if (self.rune == RUNE_DREAM && (self.status_flag & ITEM_SECOND_RUNE)) {
                 launch_inf("rocket1", "progs/missile.mdl", T_MissileTouch);
                 launch_inf("rocket2", "progs/missile.mdl", T_MissileTouch);
                 self.attack_finished = time + 2.4;
         } else if (self.rune == RUNE_ZOMBIE && (self.status_flag & ITEM_SECOND_RUNE)) {
                 launch_inf("gib1", "progs/gib1.mdl", T_ZombieGTouch);
                 launch_inf("gib2", "progs/gib2.mdl", T_ZombieGTouch);
                 launch_inf("gib3", "progs/gib3.mdl", T_ZombieGTouch);
                 self.attack_finished = time + 2;
         } else if (self.rune == RUNE_FP) {
                 if (!(self.status_flag & ITEM_SECOND_RUNE)) {
                         sham_magic1();
                         self.attack_finished = time + 1.8;
                 }
                 if (self.status_flag & ITEM_SECOND_RUNE) {
                         sham_madness();
                         self.attack_finished = time + 4;
                 } 
         } else if (self.rune == RUNE_POSSESSER && !(self.status_flag & ITEM_SECOND_RUNE)) {
            if (self.chase_observer != world) {
                    sprint(self, "Done possessing ");
                    sprint(self, self.chase_observer.netname);
                    sprint(self, "\n");
                    self.chase_observer = world;
                    self.inforigin = self.origin;
            } else {
                    pumpers = identify(0,"player");
                    if (pumpers != world) {
                            sprint(self, "Now possessing ");
                            sprint(self, pumpers.netname);
                            sprint(self, "\n");
                            self.chase_observer = pumpers;
                    }
                    if (pumpers == world)
                            sprint(self, "You must be facing someone!\n");
            }
            self.attack_finished = time + 1;
         } else if (self.rune == RUNE_TELEPORT && (self.status_flag & ITEM_SECOND_RUNE)) {
            if (!(self.inferno_flag & ABLE_KEY1_FLAG)) {
                    self.inforigin = self.origin;
                    self.inferno_flag = self.inferno_flag | ABLE_KEY1_FLAG;
                    centerprint(self, "Location stored");
                    sound(self, CHAN_WEAPON, "misc/talk.wav", 1, ATTN_NORM);
            } else if (self.inferno_flag & ABLE_KEY1_FLAG) {
                    TeleportEffect(self);
                    sound(self, CHAN_WEAPON, "misc/r_tele4.wav", 1, ATTN_NORM);

                    // teleport self
                    self.origin = self.inforigin;

                    TeleportEffect(self);
                    sound(self, CHAN_WEAPON, "misc/r_tele3.wav", 1, ATTN_NORM);

                    self.inferno_flag = self.inferno_flag - 
                      (self.inferno_flag & ABLE_KEY1_FLAG);

                    spawn_tdeath(self.inforigin, self);  // make sure telefrag happens
            }
            self.attack_finished = time + 3;
         } else if (self.rune == RUNE_EARTH_MAGIC && (self.status_flag & ITEM_SECOND_RUNE)) {
            pumpers = spawn();
            pumpers.owner = self;
            pumpers.count_count = 0;
            pumpers.think = W_FireMassiveFlames;
            pumpers.nextthink = time + 0.1;
            self.inferno_flag = self.inferno_flag | MASSIVE_FLAME_FLAG;
            self.attack_finished = time + 5;
         } else if ((self.rune == RUNE_WIZARD) && !(self.status_flag & ITEM_SECOND_RUNE)) {
                 W_FireFire_Ball();
                 // this has to come second, or the teleport
                 // won't fire.
                 Duck2Stand();
                 self.attack_finished = time + 1.5;
         } else if ((self.rune == RUNE_GHOST && (self.status_flag & ITEM_SECOND_RUNE)) ||
         (self.rune == RUNE_SUBZERO && (self.status_flag & ITEM_SECOND_RUNE)) ||
         (self.rune == RUNE_NIGHTMARE && (self.status_flag & ITEM_SECOND_RUNE)) ||
         (self.rune == RUNE_THUNDER && (self.status_flag & ITEM_SECOND_RUNE))) {
                 W_FireClone();
                 self.attack_finished = time + 1.5;
         } else if (self.rune == RUNE_NAVY_OFFICER && (self.status_flag & ITEM_SECOND_RUNE)) {
                 pumpers = spawn();
                 pumpers.owner = self;
                 pumpers.count_count = 0;
                 pumpers.think = W_FireMultiRockets;
                 pumpers.nextthink = time + 0.1;
                 self.attack_finished = time + 5.5;
         } else if (self.rune == RUNE_PORTAL_MASTER && !(self.status_flag & ITEM_SECOND_RUNE)) {
                 W_FirePortal();
                 self.attack_finished = time + 1;
         } else if (self.rune == RUNE_ANT && !(self.status_flag & ITEM_SECOND_RUNE)) {
                 W_FireGrenade();
                 self.attack_finished = time + 1.5;
         } else if (self.rune == RUNE_RAIDEN && (self.status_flag & ITEM_SECOND_RUNE)) {
                 Duck2Stand();
                 raiden_fire1();
                 self.attack_finished = time + 4;  // don't cut it close
         } else if ((self.rune == RUNE_KANO) && (self.status_flag & ITEM_SECOND_RUNE)) {
                 Duck2Stand();
                 kano_fire1();
                 self.attack_finished = time + 2.5;  // don't cut it close
         } else if (self.rune == RUNE_KANG && (self.status_flag & ITEM_SECOND_RUNE)) {
                 Duck2Stand();
                 kang_fire1();
                 self.attack_finished = time + 2.5;  // don't cut it close
         } else if ((self.rune == RUNE_JOHNNY_CAGE) && !(self.status_flag & ITEM_SECOND_RUNE)) {
                 Duck2Stand();
                 W_FireJCage();
                 self.attack_finished = time + 2.5;  // when to end it
         } else if (self.rune == RUNE_SEKTOR) {
            if (!(self.status_flag & ITEM_SECOND_RUNE)) {
                 W_FireHome();
                 self.attack_finished = time + 1.2;
            } else {
                 W_TeleportSektor();
                 self.attack_finished = time + 4;
            }
         } else if ((self.rune == RUNE_KINTARO && !(self.status_flag & ITEM_SECOND_RUNE)) ||
         (self.rune == RUNE_TURTLE && (self.status_flag & ITEM_SECOND_RUNE)))
                 self.attack_finished = time + 0.2;
         else if ((self.rune == RUNE_WEREWOLF) && (self.status_flag & ITEM_SECOND_RUNE)) {
                 W_Howl();
                 dog_howl();  // set the frames
                 self.attack_finished = time + 4;
                 return;
         } else if ((self.rune == RUNE_JOHNNY_CAGE) && (self.status_flag & ITEM_SECOND_RUNE)) {
                 W_FireGreenFireball();
                 W_FireGreenFireball();
                 W_FireGreenFireball();
                 W_FireGreenFireball();
                 self.attack_finished = time + 0.5;
         } else if ((self.rune == RUNE_KANO) && !(self.status_flag & ITEM_SECOND_RUNE)) {
                 W_FireKnife();
                 self.attack_finished = time + 0.5;
         } else if ((self.rune == RUNE_TSUNG) && !(self.status_flag & ITEM_SECOND_RUNE)) {
                 pumpers = spawn();
                 pumpers.owner = self;
                 pumpers.count_count = 0;
                 pumpers.think = W_FireMassiveFlames;  // Tsung uses this too
                 pumpers.nextthink = time + 0.1;
                 self.inferno_flag = self.inferno_flag | MASSIVE_FLAME_FLAG;
                 self.attack_finished = time + 5;
         } else if ((self.rune == RUNE_TSUNG) && (self.status_flag & ITEM_SECOND_RUNE) && (self.tsung_time < time)) {
            self.tsung_time = time + 20;  // morph back in 20 seconds
            pumpers = spawn();
            r = (random()*8);
            self.inferno_flag = self.inferno_flag | ABLE_TSUNG;

            // need to adjust for: kitana  jax mileena baraka
            // MK SET
            if (r <= 1) pumpers.rune = RUNE_SUBZERO;
            else if (r <= 2) pumpers.rune = RUNE_RAIDEN;
            else if (r <= 3) pumpers.rune = RUNE_JOHNNY_CAGE;
            else if (r <= 4) pumpers.rune = RUNE_KANO;
            else if (r <= 5) pumpers.rune = RUNE_KANG;
            // MK2 SET
            else if (r <= 6) pumpers.rune = RUNE_REPTILE;
            else if (r <= 7) pumpers.rune = RUNE_PORTAL_MASTER;
            // else if (r <= 8) pumpers.rune = RUNE_LAO;
            else if (r <= 8) pumpers.rune = RUNE_MIB;
            pumpers.runemodel = self.runemodel;
            self.rune = 0;  // remove this so you can have more runes
            other = self;
            self = pumpers;
            NRunesTouch();
            self = other;
         // } else if ((self.rune == RUNE_LAO) && (self.status_flag & ITEM_SECOND_RUNE)) {
         //         W_LaoSpin();
         //         self.attack_finished = time + 3;
         } else if (self.rune == RUNE_ILLUSION && (self.status_flag & ITEM_SECOND_RUNE)) {
                 W_FireRocket();
                 self.attack_finished = time + 0.8;
         } else if (self.rune == RUNE_SPAWN && (self.status_flag & ITEM_SECOND_RUNE)) {
                 self.runeg_rune=RUNE_SPAWN;
                 self.runeg_time=time + 4;
                 self.attack_finished = time + 8;
                 sprint(self, "Shielded for 4 seconds!\n");
         } else
                 self.attack_finished = time + 0.5;
      } else if (self.nweapon == NEW_HOOK) {
                 Duck2Stand();
                 if (!self.hook_out)
                         player_chain1();
                 else
                         player_chain3();
                 self.attack_finished = time + 0.1;
      } else if (self.nweapon == NEW_RP) {
         sound (self, CHAN_WEAPON, "weapons/ax1.wav", 1, ATTN_NORM);
         r = random();
         if (r < 0.25)
                 player_axe1 ();
         else if (r<0.5)
                 player_axeb1 ();
         else if (r<0.75)
                 player_axec1 ();
         else
                 player_axed1 ();
         if(self.rune==RUNE_EARTH_MAGIC){
                 if (!(self.status_flag & ITEM_SECOND_RUNE)) {
                         self.rune_power=RUNE_EARTH_MAGIC;
                         self.rune_power_time=time + 8;  // resistance will last for 6 seconds
                 } else if(self.status_flag&ITEM_SECOND_RUNE){
                        W_FireFlame2();
                        W_FireFlame2(-10);
                        W_FireFlame2(10);
                        self.attack_finished=time + 0.5;
                 }
         //} else if(self.rune==RUNE_BLACK_MAGIC){
         //        if(!(self.status_flag&ITEM_SECOND_RUNE))
         //                BMGroundExplosions();
         //        else if(self.status_flag&ITEM_SECOND_RUNE){
         //                traceline(self.origin + '0 0 16', self.origin + '0 0 16' + v_forward*2000, FALSE, self);
         //                if(trace_ent.classname=="player"&&trace_ent.health>0){
         //                        pumpers=spawn();
         //                        pumpers.owner=self;
         //                        pumpers.classname="ground explosion";
         //                        setorigin(pumpers,trace_endpos);
         //                        setsize(pumpers,'0 0 0','0 0 0');
         //                        setmodel(pumpers,"progs/s_explod.spr");
         //                        T_RadiusDamage(pumpers,self,500,world);
         //                        pumpers.think=s_explode1;
         //                        pumpers.nextthink=time + 0.5;
         //                } else sprint(self, "Target missed\n");
         //        }
         } else if(self.rune==RUNE_HELL_MAGIC){
                 if(!(self.status_flag&ITEM_SECOND_RUNE))
                         W_FireLavaball();
                 // else if(self.status_flag&ITEM_SECOND_RUNE)
                 //         W_FireHome();
         } else if(self.rune==RUNE_ELDER_MAGIC){
                 if(!(self.status_flag&ITEM_SECOND_RUNE))
                         self.health=400;
                 else if(self.status_flag&ITEM_SECOND_RUNE) {
                         traceline(self.origin + '0 0 16', self.origin + '0 0 16' + v_forward*2000, FALSE, self);
                         if(trace_ent.classname=="player"&&trace_ent.health>0){
                                 self.health=self.health + trace_ent.health;
                                 if(self.health>400)self.health=400;
                                 trace_ent.reason_died="life sucked out";
                                 T_Damage(trace_ent, self, self, 250);
                                 trace_ent.reason_died="";
                         } else sprint(self, "Target missed\n");
                 }
         } else if(self.rune==RUNE_TELEPORT){
                 if(!(self.status_flag&ITEM_SECOND_RUNE)) {
                         sound (self, CHAN_WEAPON, "blob/sight1.wav", 1, ATTN_NORM);
                         launch_inf("teleporter", "progs/k_spike.mdl", T_TeleTouch);
                 } else if(self.status_flag&ITEM_SECOND_RUNE){
                         self.rune_power=RUNE_TELEPORT;
                         self.rune_power_time=time + 8;
                 }
         } else if(self.rune==RUNE_FUTURE){
                 if(!(self.status_flag&ITEM_SECOND_RUNE))
                          W_FireLaser();
                 else if(self.status_flag&ITEM_SECOND_RUNE){
                         self.rune_power=RUNE_FUTURE;
                         self.rune_power_time=time + 8;
                 }
         } else if(self.rune==RUNE_ARMOR){
                 if(!(self.status_flag&ITEM_SECOND_RUNE)){
                         self.armortype=0.8;
                         self.armorvalue=800;
                 } else if(self.status_flag&ITEM_SECOND_RUNE){
                         self.rune_power=RUNE_FUTURE;
                         self.rune_power_time=time + 8;
                 }
         } else if(self.rune==RUNE_STRONG){
                 if(!(self.status_flag&ITEM_SECOND_RUNE)){
                         ppp=findradius(self.origin, 500);
                         while(ppp){
                                 if(ppp.classname=="player"&&(ppp.flags&FL_ONGROUND)&&CanDamage(ppp,self)&&ppp!=self){
                                         ppp.reason_died="sonic wave";
                                         T_Damage(ppp,self,self,60);
                                         ppp.reason_died="";
                                         ppp.velocity_z=800;
                                 }
                                 ppp=ppp.chain;
                         }
                 } //else if(self.status_flag&ITEM_SECOND_RUNE){
                   //      ppp=spawn();
                   //      ppp.classname="trip wire";
                   //      ppp.owner=self;
                   //      setmodel(ppp,"progs/missile.mdl");
                   //      setsize(ppp,'0 0 0','0 0 0');
                   //      traceline(self.origin + '0 0 16',self.origin + '0 0 16' + v_forward*2000,FALSE,self);
                   //      ppp.angles=self.v_angle;
                   //      ppp.origin=trace_endpos;
                   //      ppp.count_count=time + 480;
                   //      ppp.think=TWireThink;
                   //      ppp.nextthink=time + 2;
                   //}
         } else if(self.rune==RUNE_LIQUID){
                 if(!(self.status_flag&ITEM_SECOND_RUNE)){
                         self.rune_power=RUNE_LIQUID;
                         self.rune_power_time=time + 6;
                 } else if(self.status_flag&ITEM_SECOND_RUNE)
                         W_FireBubbler();
         } else if(self.rune==RUNE_DISAPEAR){
                 if(!(self.status_flag&ITEM_SECOND_RUNE)){
                         self.rune_power=RUNE_FUTURE;
                         self.rune_power_time=time + 8;
                 } else if(self.status_flag&ITEM_SECOND_RUNE)
                         W_FireLavaball();
         } else if(self.rune==RUNE_WHITE_MAGIC){
                 if(!(self.status_flag&ITEM_SECOND_RUNE)){
                         self.rune_power=RUNE_WHITE_MAGIC;
                         self.rune_power=time + 8;
                 } else if(self.status_flag&ITEM_SECOND_RUNE){
                         self.health=200;
                         ppp=findradius(self.origin, 200);
                         while(ppp){
                                 if(self.team==ppp.team&&self!=ppp)ppp.health=200;
                                 ppp=ppp.chain;
                         }
                 }
         } else if(self.rune==RUNE_WIZARD){
                 if(!(self.status_flag&ITEM_SECOND_RUNE)){
                         self.rune_power=RUNE_WIZARD;
                         self.rune_power_time=time + 8;
                 } else if(self.status_flag&ITEM_SECOND_RUNE){
                         self.items=self.items|IT_SUPER_SHOTGUN|IT_NAILGUN|IT_SUPER_NAILGUN|IT_GRENADE_LAUNCHER|IT_ROCKET_LAUNCHER|IT_LIGHTNING|IT_DOG_LAUNCHER;
                         self.ammo_shells=self.ammo_shells + 50;
                         self.ammo_nails=self.ammo_nails + 50;
                         self.ammo_rockets=self.ammo_rockets + 15;
                         self.ammo_cells=self.ammo_cells + 20;
                         other=self;
                         bound_other_ammo();
                 }
         } else if(self.rune==RUNE_WITCH){
                 if(!(self.status_flag&ITEM_SECOND_RUNE)){
                         ppp=findradius(self.origin, 250);
                         while(ppp){
                                 if(ppp!=self&&ppp.classname=="player"&&(!teamplay||ppp.team!=self.team)){
                                         ppp.runeb_rune=RUNE_WITCH;
                                         ppp.runeb_time=time + 15;
                                         UpdatePlayerStatus(ppp,"You've been turned into a dog\nfor 15 seconds!\n\n\n\n\n\n\n\n\n\n\n","","");
                                 }
                                 ppp=ppp.chain;
                         }
                 }else if(self.status_flag&ITEM_SECOND_RUNE){
                         self.ammo_cells=100;
                         self.ammo_nails=200;
                         self.items|IT_LIGHTNING|IT_SUPER_NAILGUN;
                 }
//         } else if (self.rune == RUNE_TARANTULA) {
//                 if(self.status_flag & ITEM_SECOND_RUNE)
//                         SetBoobyTrap();
         }

         self.attack_finished=time + 0.5;
         self.powerlevel=0;UpdatePlayerStatus(self,"\n\n\n\n\n\n\n\n\n\n\n\n","","");
         // change the weapon back to the axe
         self.nweapon=NEW_AXE;
         sprint(self, "Axe selected.\n");
      } else if (self.nweapon == NEW_HGRENADE) {
         sound (self, CHAN_WEAPON, "weapons/ax1.wav", 1, ATTN_NORM);
         r = random();
         if (r < 0.25)
                 player_axe1 ();
         else if (r<0.5)
                 player_axeb1 ();
         else if (r<0.75)
                 player_axec1 ();
         else
                 player_axed1 ();
         W_FireGrenade();
         if(!(tntn)){
                 self.attack_finished = time + 0.75;
                 HasteSound();
         } else self.attack_finished=time + 1.5;
      }                        
   }
   else if (self.weapon == IT_SHOTGUN)
   {
      if (self.nweapon == NEW_SHOTGUN) {
              if (self.rune == RUNE_M4D_SK1LLZ)
                  self.m4dShots = self.m4dShots + 1;
              player_shot1 ();
              if (self.rune == RUNE_FUTURE && (self.status_flag & ITEM_SECOND_RUNE)) {
                      W_FireLaser();
                      if (self.LaserCount >= 3) {
                              self.attack_finished = time + 0.4;
                              self.LaserCount = 0;
                      } else self.attack_finished = time + 0.2;
              } else if (self.rune == RUNE_MIB) {
                      if (!(self.status_flag&ITEM_SECOND_RUNE)) {
                              launch_inf("noisy cricket", "progs/missile.mdl", T_CTouch);
                              self.attack_finished = time + 2;
                      }
                      if(self.status_flag&ITEM_SECOND_RUNE){
                              W_FirePlasma();
                              self.attack_finished=time + 1.6;
                      }
              } else if (self.rune == RUNE_CWORKER && (self.status_flag & ITEM_SECOND_RUNE)) {
                      launch_inf("torch", "progs/s_bubble.spr", T_TorchTouch);
                      self.attack_finished = time + 0.1;
              } else if (self.rune==RUNE_LIQUID&&(self.status_flag&ITEM_SECOND_RUNE))
                      W_FireBubbler();
              else if(self.rune == RUNE_ZEUS && !(self.status_flag & ITEM_SECOND_RUNE))
                      launch_inf("lightning bolt", "progs/bolt3.mdl", T_LightningBTouch);
              else
                      W_FireShotgun ();
              // RUNE: rune of hell magic
              if (!(tntn)) {
                      self.attack_finished = time + 0.3;
                      HasteSound();
              } else if (((self.rune != RUNE_FUTURE ) ||
              // !(self.status_flag & ITEM_SECOND_RUNE)) && (self.rune != RUNE_CWORKER||!(self.status_flag & ITEM_SECOND_RUNE)))
              !(self.status_flag & ITEM_SECOND_RUNE)) && (self.rune != RUNE_CWORKER||!(self.status_flag & ITEM_SECOND_RUNE)) &&
              (self.rune != RUNE_MIB))
                      self.attack_finished = time + 0.5;
              if (self.rune == RUNE_PUNISHER && (self.status_flag & ITEM_SECOND_RUNE))
                      self.attack_finished = time + 0.2;
      } else if (self.nweapon == NEW_PLASMA) {
              player_rocket1();
              W_FirePlasma();
              //RUNE: rune of hell magic
              if (!(tntn)) {
                      self.attack_finished = time + 0.6;
                      HasteSound();
              } else
                      self.attack_finished = time + 1.2;
      } else if (self.nweapon == NEW_SNIPER) {
              player_shot1 ();
              W_FireSniper ();
              // RUNE: rune of hell magic
              if (!(tntn)) {
                      self.attack_finished = time + 1.2;
                      HasteSound();
              } else
                      self.attack_finished = time + 2.4;
      } 
   }
   else if (self.weapon == IT_SUPER_SHOTGUN)
   {
      if (self.nweapon == NEW_SUPER_SHOTGUN) {
              if (self.rune == RUNE_M4D_SK1LLZ)
                  self.m4dShots = self.m4dShots + 1;
              player_shot1 ();
              W_FireSuperShotgun ();
              // RUNE: rune of hell magic
              if (!(tntn)) {
                      self.attack_finished = time + 0.4;
                      HasteSound();
              } else
                      self.attack_finished = time + 0.7;
      } else if (self.nweapon == NEW_FLARE) {
              player_shot1();
              W_FireFlare();
              // RUNE: rune of hell magic
              if (!(tntn)) {
                      self.attack_finished = time + 0.35;
                      HasteSound();
              } else
                      self.attack_finished = time + 0.7;
      } else if (self.nweapon == NEW_KSPIKE) {
              player_shot1();
              pumpers = spawn();
              pumpers.owner = self;
              pumpers.count_count = 0;
              pumpers.think = W_FireMassiveKSpikes;
              pumpers.nextthink = time + 0.01;
              self.currentammo = self.ammo_nails = self.ammo_nails - AMMO_KSPIKE;
              // RUNE: rune of hell magic
              if (!(tntn)) {
                      self.attack_finished = time + 1;
                      HasteSound();
              } else
                      self.attack_finished = time + 2;
      }
   }
   else if (self.weapon == IT_NAILGUN) {
      if (self.rune == RUNE_TARANTULA && 
         !(self.status_flag & ITEM_SECOND_RUNE) &&
         self.nweapon == NEW_NAIL) {
         W_FireDarts();
//         self.attack_finished = time + 0.6 ;
      }
      else if (self.nweapon == NEW_MINES) // proxy  mines
      {
         if (self.proxiCount >= MAX_MINES) {
            sprint(self,"You can not fire any more mines!\n");
            self.nweapon = W_BestNWeapon(self.weapon);
         } else 
            player_nail1();
      }
      else
      {
         player_nail1 ();
      }
   }
   else if (self.weapon == IT_SUPER_NAILGUN) {
           if (self.nweapon == NEW_SUPER_NAIL)
                   player_nail1 ();
           else if (self.nweapon == NEW_ACID) {
                   player_shot1();
                   W_FireAcid();
                   // RUNE: rune of hell magic
                   if (!(tntn)) {
                           self.attack_finished = time + 0.4;
                           HasteSound();
                   } else self.attack_finished = time + 0.8;
           } else if (self.nweapon == NEW_GIBGUN) {
                   player_shot1();
                   W_FireGibGun();
                   // RUNE: rune of hell magic
                   if (!(tntn)) {
                           self.attack_finished = time + 0.6;
                           HasteSound();
                   } else self.attack_finished = time + 1.2;
           }
   }
   else if (self.weapon == IT_GRENADE_LAUNCHER)
   {
      if (self.nweapon == NEW_GRENADE) {
              player_rocket1();
              W_FireGrenade();
              // RUNE: rune of hell magic
             if (!(tntn)) {
                      self.attack_finished = time + 0.3;
                      HasteSound();
              } else
                      self.attack_finished = time + 0.6;
              if (self.rune == RUNE_NAVY_OFFICER && !(self.status_flag & ITEM_SECOND_RUNE))
                      self.attack_finished = time + 0.8;
              if (self.rune == RUNE_PUNISHER && !(self.status_flag & ITEM_SECOND_RUNE))
                      self.attack_finished = time + 1.8;
              if (self.rune == RUNE_KINTARO && (self.status_flag & ITEM_SECOND_RUNE)) {
                      if (self.ammo_rockets >= 1) W_FireRocket();
                      if (self.ammo_shells >= 1) W_FireShotgun();
              }
      } else if (self.nweapon == NEW_SHRAPNEL) {
              player_shot1();
             // W_FireFlame();
             // Warf: add module shrapnel gun
             ShrapnelMissileFire();
             if(!(tntn)) {
                          self.attack_finished = time + 0.8;
                          HasteSound();
             } else self.attack_finished = time + 1.2;

	    

             // if (self.waterlevel > 2)
             //         self.attack_finished = time + 1;
             // else
             //         self.attack_finished = time + 0.2;
              // RUNE: rune of hell magic -- too fast to do it
      } else if (self.nweapon == NEW_PB) {
              player_rocket1();
              //W_FireFreez();
              W_FirePipeBomb();
              // RUNE: rune of hell magic
              self.attack_finished = time + 1;
              if(self.pb)self.attack_finished = time + 0.5;
      }
   }
   else if (self.weapon == IT_ROCKET_LAUNCHER)
   {
      if (self.nweapon == NEW_ROCKET) {
         player_rocket1();
         if (self.rune == RUNE_FPILOT && !(self.status_flag & ITEM_SECOND_RUNE)) {
            // we need to make it costly to fire a rocket since they have regen
            // and no missile lock anymore.
            W_FireHome();
            self.attack_finished = time + 1.2;
            self.ammo_rockets = self.ammo_rockets - 1;
            if (self.ammo_rockets < 1) {
                    self.weapon = W_BestWeapon();
                    self.nweapon = W_BestNWeapon(self.weapon);
                    W_SetCurrentAmmo ();
                    // local string s1;
                    // bprint("rox chg weap weap=\n");
                    // s1 = ftos(self.weapon);
                    // bprint(s1);  bprint("  nweap=");
                    // s1 = ftos(self.nweapon);
                    // bprint(s1);  bprint("  ammo=");
                    // s1 = ftos(self.currentammo);
                    // bprint(s1);  bprint("\n");
            
            }
         } else if (self.rune == RUNE_LIFE && (self.status_flag & ITEM_SECOND_RUNE)) {
            W_FireHome();
            self.ammo_rockets = self.ammo_rockets - 1;
            if (self.ammo_rockets < 1) {
                    self.weapon = W_BestWeapon();
                    self.nweapon = W_BestNWeapon(self.weapon);
                    W_SetCurrentAmmo ();
            }
         }
         else 
            W_FireRocket();
         // RUNE: rune of hell magic
         if (!(tntn)) {
            self.attack_finished = time + 0.4;
            HasteSound();
         } else
            self.attack_finished = time + 0.8;
      } else if (self.nweapon == NEW_MINDG) {
         player_rocket1();
         W_FireMindGas();
         //RUNE: rune of hell magic
         if (!(tntn)) {
                 self.attack_finished = time + 1;
                 HasteSound();
         } else
                 self.attack_finished = time + 2;
      } else if (self.nweapon == NEW_LAVAGUN) {
         player_rocket1();
         W_FireLavaball();
         //RUNE: rune of hell magic
         if (!(tntn)) {
                 self.attack_finished = time + 0.7;
                 HasteSound();
         } else
                 self.attack_finished = time + 1.4;
      }
   }
   else if (self.weapon == IT_LIGHTNING)
   {
      if (self.nweapon == NEW_LIGHTNING) {
        player_light1();
        self.attack_finished = time + 0.1;
        if ((self.rune != RUNE_THUNDER || (self.status_flag & ITEM_SECOND_RUNE)) &&
        (self.rune != RUNE_FP || (self.status_flag & ITEM_SECOND_RUNE)))
                sound (self, CHAN_AUTO, "weapons/lstart.wav", 1, ATTN_NORM);
      } else if (self.nweapon == NEW_LASER) {
        player_shot1();
        W_FireLaser();
        if (self.LaserCount >= 3) {
                //RUNE: rune of hell magic
                if (!(tntn)) {
                        self.attack_finished = time + 0.2;
                        HasteSound();
                } else
                        self.attack_finished = time + 0.4;
                self.LaserCount = 0;
        } else 
            self.attack_finished = time + 0.2;
     } else if (self.nweapon == NEW_SUPERM) {
        player_shot1();
        W_FireSuperM();
        // RUNE: rune of hell magic
        if (!(tntn)) {
                self.attack_finished = time + 0.55;
                HasteSound();
        } else
                self.attack_finished = time + 1.1;
     }
  }
  else if (self.weapon == IT_DOG_LAUNCHER)
  {
          if (self.nweapon==NEW_DOG) {
                  player_rocket1();
                  W_FireRocket();
                  // RUNE: rune of hell magic
                  if (!(tntn)) {
                          self.attack_finished = time + 0.7;
                          HasteSound();
                  } else self.attack_finished = time + 1.4;
          }
          if(self.nweapon==NEW_CGRENADE) {
                  player_rocket1();
                  W_FireGrenade();
                  // RUNE: rune of hell magic
                  if (!(tntn)) {
                          self.attack_finished = time + 0.7;
                          HasteSound();
                  } else self.attack_finished = time + 1.4;
          }
          if(self.nweapon==NEW_FREEZEGUN){
                  player_rocket1();
                  W_FireFreez();
                  self.attack_finished=time + 1.5;
          }
  }

  if (self.nweapon!=NEW_HOOK &&
      self.nweapon!=NEW_NAIL &&
      self.nweapon!=NEW_SUPER_NAIL &&
      self.nweapon!=NEW_SHRAPNEL) {

      // check for the sub zero rune
      if (self.rune == RUNE_SUBZERO && !(self.status_flag & ITEM_SECOND_RUNE))
              W_FireFreez();

      // check for the reptile rune
      if (self.rune == RUNE_REPTILE && !(self.status_flag & ITEM_SECOND_RUNE))
              W_FireAcid();

      // check for kung lao rune
      // if (self.rune == RUNE_LAO && !(self.status_flag & ITEM_SECOND_RUNE))
      //         launch_inf("head", "progs/h_player.mdl", T_HeadTouch);

      // check for the Dragon rune
      if (self.rune == RUNE_DRAGON && (self.status_flag & ITEM_SECOND_RUNE))
              W_FireFlame2(0);
   }

   /***   These are All Shambler Frames, they had to be Redone...   ***/
   // soldier attack!
   if (self.rune == RUNE_FP) {
           if (self.nweapon == NEW_NAIL ||
           self.nweapon == NEW_SUPER_NAIL || self.nweapon == NEW_FLAME)
                    zomb_nail1();
           else if (self.nweapon == NEW_HOOK) {
                   if (!self.hook_out)
                           knight_chain1();
                   else
                           knight_chain3();
           } else if (self.nweapon == NEW_LIGHTNING)
                   zomb_light1();
           else if (self.nweapon != NEW_AXE) sham_attk();
   }
   /*** Here are my Custom Shalrath frames! ***/
   if (self.rune == RUNE_TARANTULA) {
      if (!(self.status_flag & ITEM_SECOND_RUNE)) {
          self.nweapon == NEW_NAIL;
          if (self.nweapon == NEW_NAIL)
             W_FireDarts();
      }
      if ((self.status_flag & ITEM_SECOND_RUNE)) {
          if (self.nweapon == NEW_AXE)
             SetBoobyTrap();
      }
      if (self.nweapon == NEW_SUPER_NAIL || self.nweapon == NEW_FLAME || 
         ((self.status_flag & ITEM_SECOND_RUNE) && self.nweapon == NEW_NAIL))
         zomb_nail1();
      else if (self.nweapon == NEW_ROCKET)
         player_rocket1();
      else if (self.nweapon == NEW_HOOK) {
         if (!self.hook_out)
            shal_chain1();
         else
            knight_chain3();
      } 
      else if (self.nweapon == NEW_LIGHTNING)
            shal_attk1();
      else if (self.nweapon == NEW_AXE || self.nweapon == NEW_GRENADE)
            shal_axe1();
      else shal_attack1();
   }

   /***   These are All Zombie Frames, they had to be Redone...   ***/
   // zombie attack!
   if (self.rune == RUNE_ZOMBIE) {
           if (self.nweapon == NEW_NAIL ||
           self.nweapon == NEW_SUPER_NAIL || self.nweapon == NEW_FLAME)
                    zomb_nail1();
           else if (self.nweapon == NEW_HOOK) {
                   if (!self.hook_out)
                           zomb_chain1();
                   else
                           zomb_chain3();
           } else if (self.nweapon == NEW_LIGHTNING)
                   zomb_light1();
           else zomb_att1();
   }

   /***   These are All Enforcer Frames, they had to be Redone...   ***/
   // enforcer attack!
   if (self.rune == RUNE_FUTURE) {
           if (self.nweapon == NEW_NAIL ||
           self.nweapon == NEW_SUPER_NAIL || self.nweapon == NEW_FLAME)
                   enf_nail1();
           else if (self.nweapon == NEW_HOOK) {
                   if (!self.hook_out)
                           enf_chain1();
                   else
                           enf_chain3();
           } else if (self.nweapon == NEW_LIGHTNING)
                   enf_light1();
           else enf_atk5();
   }
   /***   End of the Enforcer Frames   ***/
};

/*
============
W_ChangeWeapon

============
*/
void() W_ChangeWeapon =
{
   local   float   it, am, fl, fll, tiddr;

   
   it = self.items;
   am = tiddr = 0;
   
   if (self.impulse == 120){ // check for handgrenades first
           fl=IT_AXE;
           if(self.ammo_rockets<1)
                   am=1;
           else fll=NEW_HGRENADE;
   } else if (self.impulse == 1) {
           fl = IT_AXE;
           if (self.weapon != IT_AXE)
                   fll = NEW_AXE;
           else if (self.nweapon == NEW_AXE)
                   fll = NEW_HOOK;
           else if(self.nweapon == NEW_HOOK)
                   fll = NEW_AXE;
           else if (self.nweapon == NEW_RP)
                   fll = NEW_AXE;
   } else if (self.impulse == 31) {
      fl = IT_AXE;
   } else if (self.impulse == 2) {// || self.impulse == 32) {
      fl = IT_SHOTGUN;
      if (self.nweapon == NEW_SHOTGUN) {
              if (self.ammo_rockets < AMMO_PLASMA)
                      fll = NEW_SHOTGUN;
              else fll = NEW_PLASMA;
      } else if (self.nweapon == NEW_PLASMA) {
              if (self.ammo_shells < 7 || self.ammo_rockets < 7) {
                      if (self.ammo_shells < 1)
                              am = 1;
                      else fll = NEW_SHOTGUN;
              } else fll = NEW_SNIPER;
      } else {
              if (self.ammo_shells < 1)
                      am = 1;
              else fll = NEW_SHOTGUN;
      }
   } else if (self.impulse == 3) {// || self.impulse == 33) {
      fl = IT_SUPER_SHOTGUN;
      if (self.nweapon == NEW_SUPER_SHOTGUN) {
              if ((self.ammo_cells < AMMO_FLARE) | (self.ammo_shells < AMMO_FLARE)){
                      if (self.ammo_nails < AMMO_KSPIKE)
                              fll = NEW_SUPER_SHOTGUN;
                      else
                              fll = NEW_KSPIKE;
              } else fll = NEW_FLARE;
      } else if (self.nweapon == NEW_FLARE) {
              if (self.ammo_nails < AMMO_KSPIKE)
                      fll = NEW_SUPER_SHOTGUN;
              else
                      fll = NEW_KSPIKE;
      } else {
              if (self.ammo_shells < 1)
                      am = 1;
              else fll = NEW_SUPER_SHOTGUN;
      }
   } else if (self.impulse == 4) {
      fl = IT_NAILGUN;
      if (self.nweapon == NEW_NAIL) {
              if (self.ammo_nails < 2) {
                  if (self.ammo_rockets < AMMO_MINE) {
                      if (self.ammo_nails < 1)
                              am = 1;
                      else fll = NEW_NAIL;
                  } else fll = NEW_MINES;
              } else fll = NEW_FLAME;
      } else if (self.nweapon == NEW_FLAME) {
         if (self.ammo_rockets < AMMO_MINE) {
            if (self.ammo_nails < 1) 
               am = 1;
            else fll = NEW_NAIL;
         } else fll = NEW_MINES;
      } else {
         if (self.ammo_nails < 1)
                 am = 1;
         else fll = NEW_NAIL;
      }
   } else if (self.impulse == 5) {
      fl = IT_SUPER_NAILGUN;
      if (self.nweapon == NEW_SUPER_NAIL) {
              if (self.ammo_nails < AMMO_ACID) {
                      if (self.ammo_rockets < AMMO_GIBGUN) {
                              if (self.ammo_nails < 2)
                                      am = 1;
                              else fll = NEW_SUPER_NAIL;
                      } else fll = NEW_GIBGUN;
              } else fll = NEW_ACID;
      } else if (self.nweapon == NEW_ACID) {
              if (self.ammo_rockets < AMMO_GIBGUN) {
                      if (self.ammo_nails < 2)
                              am = 1;
                      else fll = NEW_SUPER_NAIL;
              } else fll = NEW_GIBGUN;
      } else {
              if (self.ammo_nails < 2)
                      am = 1;
              else fll = NEW_SUPER_NAIL;
      }
   } else if (self.impulse == 35) {
      fl = IT_SUPER_NAILGUN;
      if (self.ammo_nails < 2)
         am = 1;
      else fll = NEW_SUPER_NAIL;
   } else if (self.impulse == 6) {// || self.impulse == 36) {
      fl = IT_GRENADE_LAUNCHER;
      if (self.weapon != IT_GRENADE_LAUNCHER) {
              if (self.ammo_rockets < 1)
                      am = 1;
              else fll = NEW_GRENADE;
      } else if (self.nweapon == NEW_GRENADE) {
              if (self.ammo_shells < 1) {
                      if (self.ammo_rockets < 1)
                              fll = NEW_GRENADE;//am = 1;
                      else fll = NEW_PB;
              }
              else if (self.ammo_rockets < 3)
                           fll = NEW_GRENADE; 
                  else fll = NEW_SHRAPNEL;
      } else if (self.nweapon == NEW_SHRAPNEL) {
              if (self.ammo_rockets < 3)
                      am = 1;
              else fll = NEW_PB;
      } else if (self.nweapon == NEW_PB) {
              if (self.ammo_rockets < 1)
                      am = 1;
              else fll = NEW_GRENADE;
      }
   } else if (self.impulse == 36) {
      fl = IT_GRENADE_LAUNCHER;
      if (self.ammo_rockets < 1)
              am = 1;
      else fll = NEW_GRENADE;
   } else if (self.impulse == 7) {// || self.impulse == 37) {
      fl = IT_ROCKET_LAUNCHER;
      if (self.nweapon == NEW_ROCKET) {
              if (self.ammo_rockets < AMMO_MINDG) {
                      if (self.ammo_rockets < 1)
                              am = 1;
                      else fll = NEW_ROCKET;
                        
              } else fll = NEW_MINDG;
      } else if (self.nweapon == NEW_MINDG) {
              if (self.ammo_rockets < AMMO_LAVAGUN) {
                      if (self.ammo_rockets < 1)
                              am = 1;
                      else fll = NEW_ROCKET;
              } else fll = NEW_LAVAGUN;
      } else {
              if (self.ammo_rockets < 1)
                      am = 1;
              else fll = NEW_ROCKET;
      }

   } else if (self.impulse == 37) {
      fl = IT_ROCKET_LAUNCHER;
      if (self.ammo_rockets < 1)
              am = 1;
      else fll = NEW_ROCKET;
   } else if (self.impulse == 8) {// || self.impulse == 38) {
      fl = IT_LIGHTNING;
      if (self.weapon != IT_LIGHTNING) {
              if (self.ammo_cells < 1)
                      am = 1;
              else fll = NEW_LIGHTNING;
      } else if (self.nweapon == NEW_LIGHTNING) {
              if (self.ammo_nails < AMMO_LASER) {
                      if (self.ammo_cells >= 1) {
                              if (self.ammo_cells >= 2 && self.ammo_rockets >= 2)
                                      fll = NEW_SUPERM;
                              else
                                      fll = NEW_LIGHTNING;
                      } else
                              am = 1;
              } else
                      fll = NEW_LASER;
      } else if (self.nweapon == NEW_LASER) {
              if (self.ammo_cells < 2 || self.ammo_rockets < 2) {
                      if (self.ammo_cells < 1)
                              am = 1;
                      else if (self.ammo_cells >= 1)
                              fll = NEW_LIGHTNING;
              } else
                      fll = NEW_SUPERM;
      } else if (self.nweapon == NEW_SUPERM)
          fll = NEW_LIGHTNING;
   } else if (self.impulse == 9) {
      fl = IT_DOG_LAUNCHER;
      if (self.weapon != IT_DOG_LAUNCHER) {
              if (self.ammo_cells < 1)
                      am=1;
              else fll=NEW_DOG;
      } else if (self.nweapon==NEW_DOG) {
              if (self.ammo_cells < 1)
                      am=1;
              else fll=NEW_CGRENADE;
      } else if(self.nweapon==NEW_CGRENADE){
              if(self.ammo_cells<AMMO_FREEZEGUN)
                      am=1;
              else fll=NEW_FREEZEGUN;
      } else {
              if (self.ammo_cells < 1)
                      am=1;
              else fll=NEW_DOG;
      }
   } else if (self.impulse == 22 || self.impulse == 39) {
      fl = IT_AXE;
      fll = NEW_HOOK;
   } else if (self.impulse == 40) {
      fl = IT_GRENADE_LAUNCHER;
      if (self.ammo_shells < 1)
              am = 1;
      else fll = NEW_SHRAPNEL;
   } else if (self.impulse == 41) {
      fl = IT_GRENADE_LAUNCHER;
      if (self.ammo_rockets < 1)
              am = 1;
      else fll = NEW_PB;
   } else if (self.impulse == 42) {
      fl = IT_ROCKET_LAUNCHER;
      if (self.ammo_rockets < AMMO_LAVAGUN)
              am = 1;
      else fll = NEW_LAVAGUN;
   } else if (self.impulse == 43) {
      fl = IT_ROCKET_LAUNCHER;
      if (self.ammo_rockets < AMMO_MINDG)
              am = 1;
      else fll = NEW_MINDG;
   } else if (self.impulse == 44) {
      fl = IT_LIGHTNING;
      if (self.ammo_nails < AMMO_LASER)
              am = 1;
      else fll = NEW_LASER;
   } else if (self.impulse == 45) {
      fl = IT_LIGHTNING;
      if (self.ammo_rockets < 2 || self.ammo_cells < 2)
              am = 1;
      else fll = NEW_SUPERM;
   } else if (self.impulse == 46) {
      fl = IT_SHOTGUN;
      if (self.ammo_rockets < AMMO_SNIPER || self.ammo_shells < AMMO_SNIPER)
              am = 1;
      else fll = NEW_SNIPER;
   } else if (self.impulse == 47) {
      fl = IT_SHOTGUN;
      if (self.ammo_rockets < AMMO_PLASMA)
              am = 1;
      else fll = NEW_PLASMA;
   } else if (self.impulse == 48) {
      fl = IT_NAILGUN;
      if (self.ammo_rockets < AMMO_FIRE)
              am = 1;
      else fll = NEW_FLAME;
   } else if (self.impulse == 49) {
      fl = IT_SUPER_SHOTGUN;
      if (self.ammo_shells < AMMO_FLARE || self.ammo_cells < AMMO_FLARE)
              am = 1;
      else fll = NEW_FLARE;
   } else if (self.impulse == 50) {
      fl = IT_SUPER_SHOTGUN;
      if (self.ammo_nails < AMMO_KSPIKE)
              am = 1;
      else fll = NEW_KSPIKE;
   } else if (self.impulse == 51) {
      fl = IT_SUPER_NAILGUN;
      if (self.ammo_nails < 1)
              am = 1;
      else fll = NEW_ACID;
   } else if (self.impulse == 52) {
      fl = IT_SUPER_NAILGUN;
      if (self.ammo_rockets < AMMO_GIBGUN)
              am = 1;
      else fll = NEW_GIBGUN;
   } else if (self.impulse == 53) {
      fl=IT_DOG_LAUNCHER;
      if (self.ammo_cells < 1)
              am=1;
      else fll=NEW_DOG;
   } else if(self.impulse==54){
      fl=IT_DOG_LAUNCHER;
      if (self.ammo_cells < 1)
              am=1;
      else fll=NEW_CGRENADE;
   } else if(self.impulse==55){
      fl=IT_DOG_LAUNCHER;
      if (self.ammo_cells < 1)
              am=1;
      else fll=NEW_FREEZEGUN;
   }

   self.impulse = 0;
   
   if ((self.rune == RUNE_WIZARD) && (self.status_flag & ITEM_SECOND_RUNE)) {
      if (fl == IT_SUPER_SHOTGUN) {
         if (!(self.items & fl) && (Key8ArmorVal(fl) >= 0)) {
                 self.items = self.items | fl;
                 self.armorvalue = self.armorvalue - Key8ArmorTake(fl);
                 sprint(self, "Double Barrelled Shotgun Formed\n");
                 tiddr = 1;
         } else if ((self.items & fl) && ((Key8ArmorVal(fl)/2) >= 0) && (fl == self.weapon)) {
                 self.armorvalue = self.armorvalue - (Key8ArmorTake(self.weapon)/2);
                 sprint(self, "Added 20 shells\n");
                 tiddr = 1;
         }
         if ((self.ammo_shells <= 80) && (tiddr))
                 self.ammo_shells = self.ammo_shells + 20;
         else if (!(tiddr) && !(self.items & fl)) sprint(self, "Cannot Form Double Barrelled Shotgun\n");
      }
      if (fl == IT_NAILGUN) {
         if (!(self.items & fl) && (Key8ArmorVal(fl) >= 0)) {
                 self.items = self.items | fl;
                 self.armorvalue = self.armorvalue - Key8ArmorTake(fl);
                 sprint(self, "Nailgun Formed\n");
                 tiddr = 1;
         } else if ((self.items & fl) && ((Key8ArmorVal(fl)/2) >= 0) && (fl == self.weapon)) {
                 self.armorvalue = self.armorvalue - (Key8ArmorTake(fl)/2);
                 sprint(self, "Added 25 nails\n");
                 tiddr = 1;
         }
         if ((self.ammo_nails <= 75) && (tiddr))
                 self.ammo_nails = self.ammo_nails + 25;
         else if (!(tiddr) && !(self.items & fl)) sprint(self, "Cannot Form Nailgun\n");
      }
      if (fl == IT_SUPER_NAILGUN) {
         if (!(self.items & fl) && (Key8ArmorVal(fl) >= 0)) {
                 self.items = self.items | fl;
                 self.armorvalue = self.armorvalue - Key8ArmorTake(fl);
                 sprint(self, "Super Nailgun Formed\n");
                 tiddr = 1;
         } else if ((self.items & fl) && ((Key8ArmorVal(fl)/2) >= 0) && (fl == self.weapon)) {
                 self.armorvalue = self.armorvalue - (Key8ArmorTake(fl)/2);
                 sprint(self, "Added 30 nails\n");
                 tiddr = 1;
         }
         if ((self.ammo_nails <= 70) && (tiddr))
                 self.ammo_nails = self.ammo_nails + 30;
         else if (!(tiddr) && !(self.items & fl)) sprint(self, "Cannot Form Super Nailgun\n");
      }
      if (fl == IT_GRENADE_LAUNCHER) {
         if (!(self.items & fl) && (Key8ArmorVal(fl) >= 0)) {
                 self.items = self.items | fl;
                 self.armorvalue = self.armorvalue - Key8ArmorTake(fl);
                 sprint(self, "Grenade Launcher Formed\n");
                 tiddr = 1;
         } else if ((self.items & fl) && ((Key8ArmorVal(fl)/2) >= 0) && (fl == self.weapon)) {
                 self.armorvalue = self.armorvalue - (Key8ArmorTake(fl)/2);
                 sprint(self, "Added 2 rockets\n");
                 tiddr = 1;
         }
         if ((self.ammo_rockets <= 98) && (tiddr))
                 self.ammo_rockets = self.ammo_rockets + 2;
         else if (!(tiddr) && !(self.items & fl)) sprint(self, "Cannot Form Grenade Launcher\n");
      }
      if (fl == IT_ROCKET_LAUNCHER) {
         if (!(self.items & fl) && (Key8ArmorVal(fl) >= 0)) {
                 self.items = self.items | fl;
                 self.armorvalue = self.armorvalue - Key8ArmorTake(fl);
                 sprint(self, "Rocket Launcher Formed\n");
                 tiddr = 1;
         } else if ((self.items & fl) && ((Key8ArmorVal(fl)/2) >= 0) && (fl == self.weapon)) {
                 self.armorvalue = self.armorvalue - (Key8ArmorTake(fl)/2);
                 sprint(self, "Added 2 rockets\n");
                 tiddr = 1;
         }
         if ((self.ammo_rockets <= 98) && (tiddr))
                 self.ammo_rockets = self.ammo_rockets + 2;
         else if (!(tiddr) && !(self.items & fl)) sprint(self, "Cannot Form Rocket Launcher\n");
      }
      if (fl == IT_LIGHTNING) {
         if (!(self.items & fl) && (Key8ArmorVal(fl) >= 0)) {
                 self.items = self.items | fl;
                 self.armorvalue = self.armorvalue - Key8ArmorTake(fl);
                 sprint(self, "Lightning Gun Formed\n");
                 tiddr = 1;
         } else if ((self.items & fl) && ((Key8ArmorVal(fl)/2) >= 0) && (fl == self.weapon)) {
                 self.armorvalue = self.armorvalue - (Key8ArmorTake(self.weapon)/2);
                 sprint(self, "Added 15 cells\n");
                 tiddr = 1;
         }
         if ((self.ammo_cells <= 85) && (tiddr))
                 self.ammo_cells = self.ammo_cells + 15;
         else if (!(tiddr) && !(self.items & fl)) sprint(self, "Cannot Form Lightning Gun\n");
      }
   }

   // KEY8:  Make sure the correct sound is done
   if (tiddr)
      sound(self, CHAN_WEAPON, "hknight/sight1.wav", 1, ATTN_NORM);

   if (!(self.items & fl))
   {       
      // don't have the weapon or the ammo, but if the person
      // has the wizard rune, it's an exception
      sprint (self, "no weapon.\n");
      return;
   }
   
   if (am)
   {   // don't have the ammo
      sprint (self, "not enough ammo.\n");
      return;
   }

   //McBain: save current weapon
   // For explicite weapon selection, allow previous weapon and new weapon to be
   // same except for IT_HOOK.
   if (self.nweapon != NEW_HOOK || fll != NEW_HOOK) {
      self.previous_weapon = self.weapon;
      self.prev_nweapon = self.nweapon;
   }

   self.nweapon = fll;
   //
   // set weapon, set ammo
   //
   self.weapon = fl;      
   NotifyWeapon();
   W_SetCurrentAmmo ();
};

/*
============
CycleWeaponCommand

Go to the next weapon with ammo
============
*/
void() CycleWeaponCommand =
{
   local   float   it, am;
   
   it = self.items;
   self.impulse = 0;
   if(self.nweapon==NEW_HGRENADE)self.nweapon=NEW_AXE;
   
   //McBain: save current weapon
   self.previous_weapon = self.weapon;
      self.prev_nweapon = self.nweapon;

   while (1)
   {
      am = 0;

      if (self.weapon == IT_AXE) {
         if (self.nweapon == NEW_AXE)
                 self.nweapon = NEW_HOOK;
         else if (self.nweapon == NEW_HOOK) {
                 self.weapon = IT_SHOTGUN;
                 self.nweapon = NEW_SHOTGUN;
                 if (self.ammo_shells < 1)
                         am = 1;
         }
      } else if (self.weapon == IT_SHOTGUN) {
         if (self.nweapon == NEW_SHOTGUN) {
                 self.nweapon = NEW_PLASMA;
                 if (self.ammo_rockets < AMMO_PLASMA)
                         am = 1;
         } else if (self.nweapon == NEW_PLASMA) {
                 self.nweapon = NEW_SNIPER;
                 if (self.ammo_shells < AMMO_SNIPER || self.ammo_rockets < AMMO_SNIPER)
                         am = 1;
         } else {//if (self.nweapon == NEW_SNIPER) {
                 self.weapon = IT_SUPER_SHOTGUN;
                 self.nweapon = NEW_SUPER_SHOTGUN;
                 if (self.ammo_shells < 2)
                         am = 1;
         }
      } else if (self.weapon == IT_SUPER_SHOTGUN) {
         if (self.nweapon == NEW_SUPER_SHOTGUN) {
                 self.nweapon = NEW_FLARE;
                 if (self.ammo_shells < AMMO_FLARE)
                      if (self.ammo_cells < AMMO_FLARE)
                         am = 1;
         } else if (self.nweapon == NEW_FLARE) {
                 self.nweapon = NEW_KSPIKE;
                 if (self.ammo_nails < AMMO_KSPIKE)
                         am = 1;
         } else {
                 self.weapon = IT_NAILGUN;
                 self.nweapon = NEW_NAIL;
                 if (self.ammo_nails < 1)
                         am = 1;
         }
      } else if (self.weapon == IT_NAILGUN) {
         if (self.nweapon == NEW_NAIL) {
                 self.nweapon = NEW_FLAME;
                 if (self.ammo_nails < AMMO_FIRE)
                         am = 1;
         } else if (self.nweapon == NEW_FLAME) {
            self.nweapon = NEW_MINES;
            if (self.ammo_rockets < AMMO_MINE)
               am = 1;
         } else {//if (self.nweapon == NEW_FLAME) {
                 self.weapon = IT_SUPER_NAILGUN;
                 self.nweapon = NEW_SUPER_NAIL;
                 if (self.ammo_nails < 2)
                         am = 1;
         }
      } else if (self.weapon == IT_SUPER_NAILGUN) {
         if (self.nweapon == NEW_SUPER_NAIL) {
                 self.nweapon = NEW_ACID;
                 if (self.ammo_nails < AMMO_ACID)
                         am = 1;
         } else if (self.nweapon == NEW_ACID) {
                 self.nweapon = NEW_GIBGUN;
                 if (self.ammo_rockets < AMMO_GIBGUN)
                         am = 1;
         } else {//if (self.nweapon == NEW_GIBGUN) {
                 self.weapon = IT_GRENADE_LAUNCHER;
                 self.nweapon = NEW_GRENADE;
                 if (self.ammo_rockets < 1)
                         am = 1;
         }
      } else if (self.weapon == IT_GRENADE_LAUNCHER) {
         if (self.nweapon == NEW_GRENADE) {
                 self.nweapon = NEW_SHRAPNEL;
                 if (self.ammo_shells < 1 || self.ammo_rockets < 1)
                         am = 1;
         } else if (self.nweapon == NEW_SHRAPNEL) {
                 self.nweapon = NEW_PB;
                 if (self.ammo_rockets < 1)
                         am = 1;
         } else {//if (self.nweapon == NEW_FREEZEGUN) {
                 self.weapon = IT_ROCKET_LAUNCHER;
                 self.nweapon = NEW_ROCKET;
                 if (self.ammo_rockets < 1)
                         am = 1;
         }
      } else if (self.weapon == IT_ROCKET_LAUNCHER) {
         if (self.nweapon == NEW_ROCKET) {
                 self.nweapon = NEW_MINDG;
                 if (self.ammo_rockets < AMMO_MINDG)
                         am = 1;
         } else if (self.nweapon == NEW_MINDG) {
                 self.nweapon = NEW_LAVAGUN;
                 if (self.ammo_rockets < AMMO_LAVAGUN)
                         am = 1;
         } else {//if (self.nweapon == NEW_LAVAGUN) {
                 self.weapon = IT_LIGHTNING;
                 self.nweapon = NEW_LIGHTNING;
                 if (self.ammo_cells < 1)
                         am = 1;
         }
      }
      else if (self.weapon == IT_LIGHTNING) {
         if (self.nweapon == NEW_LIGHTNING) {
                 self.nweapon = NEW_LASER;
                 if (self.ammo_nails < AMMO_LASER)
                         am = 1;
         } else if (self.nweapon == NEW_LASER) {
                 self.nweapon = NEW_SUPERM;
                 if (self.ammo_cells < 2 || self.ammo_rockets < 2)
                         am = 1;
         } else {//if (self.nweapon == NEW_SUPERM) {
                 self.weapon=IT_DOG_LAUNCHER;
                 self.nweapon=NEW_DOG;
                 if(self.ammo_cells<1)
                         am=1;
         }
      } else if(self.weapon=IT_DOG_LAUNCHER){
         if(self.ammo_cells<1)
                 am=1;
         if(self.nweapon==NEW_DOG){
                 self.nweapon=NEW_CGRENADE;
                 if(self.ammo_cells<1)
                         am=1;
         } else if(self.nweapon==NEW_CGRENADE){
                 self.nweapon=NEW_FREEZEGUN;
                 if(self.ammo_cells<1)
                         am=1;
         } else if(self.nweapon==NEW_FREEZEGUN){
                 self.weapon = IT_AXE;
                 self.nweapon = NEW_AXE;
         }
      }
   
      if ( (it & self.weapon) && am == 0)
      {
         NotifyWeapon();
         W_SetCurrentAmmo ();
         return;
      }
   }
};

/*
============
CycleWeaponReverseCommand

Go to the prev weapon with ammo
============
*/
void() CycleWeaponReverseCommand =
{
   local   float   it, am;
   
   it = self.items;
   self.impulse = 0;
   if(self.nweapon==NEW_HGRENADE)self.nweapon=NEW_AXE;

   //McBain: save current weapon
   self.previous_weapon = self.weapon;
      self.prev_nweapon = self.nweapon;

   while (1)
   {
      am = 0;

      if(self.weapon==IT_DOG_LAUNCHER){
         if(self.nweapon==NEW_FREEZEGUN){
                 self.nweapon=NEW_CGRENADE;
                 if(self.ammo_cells<1)
                         am=1;
         } else if (self.nweapon==NEW_CGRENADE){
                 self.nweapon=NEW_DOG;
                 if(self.ammo_cells<1)
                         am=1;
         } else if(self.nweapon==NEW_DOG){
                 self.weapon=IT_LIGHTNING;
                 self.nweapon=NEW_LIGHTNING;
                 if(self.ammo_cells<1)
                         am=1;
         }
      }
      else if (self.weapon == IT_LIGHTNING)
      {
         if (self.nweapon == NEW_SUPERM) {
                 self.nweapon = NEW_LASER;
                 if (self.ammo_nails < AMMO_LASER)
                         am = 1;
         } else if (self.nweapon == NEW_LASER) {
                 self.nweapon = NEW_LIGHTNING;
                 if (self.ammo_cells < 1)
                         am = 1;
         } else if (self.nweapon == NEW_LIGHTNING) {
                 self.weapon = IT_ROCKET_LAUNCHER;
                 self.nweapon = NEW_LAVAGUN;
                 if (self.ammo_rockets < AMMO_LAVAGUN)
                         am = 1;
         }
      }
      else if (self.weapon == IT_ROCKET_LAUNCHER)
      {
         if (self.nweapon == NEW_LAVAGUN) {
                 self.nweapon = NEW_MINDG;
                 if (self.ammo_rockets < AMMO_MINDG)
                         am = 1;
         } else if (self.nweapon == NEW_MINDG) {
                 self.nweapon = NEW_ROCKET;
                 if (self.ammo_rockets < 1)
                         am = 1;
         } else if (self.nweapon == NEW_ROCKET) {
                 self.weapon = IT_GRENADE_LAUNCHER;
                 self.nweapon = NEW_PB;
                 if (self.ammo_rockets < 1)
                         am = 1;
         }
      }
      else if (self.weapon == IT_GRENADE_LAUNCHER)
      {
         if (self.nweapon == NEW_PB) {
                 self.nweapon = NEW_SHRAPNEL;
                 if (self.ammo_shells < 1 || self.ammo_rockets < 1)
                         am = 1;
         } else if (self.nweapon == NEW_SHRAPNEL) {
                 self.nweapon = NEW_GRENADE;
                 if (self.ammo_rockets < 1)
                         am = 1;
         } else if (self.nweapon == NEW_GRENADE) {
                 self.weapon = IT_SUPER_NAILGUN;
                 self.nweapon = NEW_GIBGUN;
                 if (self.ammo_rockets < AMMO_GIBGUN)
                         am = 1;
         }
      }
      else if (self.weapon == IT_SUPER_NAILGUN)
      {
         if (self.nweapon == NEW_GIBGUN) {
                 self.nweapon = NEW_ACID;
                 if (self.ammo_nails < AMMO_ACID)
                         am = 1;
         }
         if (self.nweapon == NEW_ACID) {
                 self.nweapon = NEW_SUPER_NAIL;
                 if (self.ammo_nails < 2)
                         am = 1;
         } else if (self.nweapon == NEW_SUPER_NAIL) {
                 self.weapon = IT_NAILGUN;
                 self.nweapon = NEW_MINES;
                 if (self.ammo_rockets < AMMO_MINE)
                         am = 1;
         }
      }
      else if (self.weapon == IT_NAILGUN)
      {
         if (self.nweapon == NEW_MINES) {
             self.nweapon = NEW_FLAME;
             if (self.ammo_nails < 2)
                am = 1;
         } else if (self.nweapon == NEW_FLAME) {
             self.nweapon = NEW_NAIL;
             if (self.ammo_nails < 1)
                am = 1;
         } else {
                 self.weapon = IT_SUPER_SHOTGUN;
                 self.nweapon = NEW_FLARE;
                 if (self.ammo_shells < AMMO_FLARE) {
                     if (self.ammo_cells < AMMO_FLARE)
                         am = 1;
                 }
         }
      }      
      else if (self.weapon == IT_SUPER_SHOTGUN)
      {
         if (self.nweapon == NEW_KSPIKE) {
                  self.nweapon = NEW_FLARE;
                  if (self.ammo_shells < AMMO_FLARE) {
                     if (self.ammo_cells < AMMO_FLARE)
                          am = 1;
                  }
         } else if (self.nweapon == NEW_FLARE) {
                 self.nweapon = NEW_SUPER_SHOTGUN;
                 if (self.ammo_shells < 2)
                         am = 1;
         } else {
                 self.nweapon = NEW_SNIPER;
                 self.weapon = IT_SHOTGUN;
                 if (self.ammo_shells < AMMO_SNIPER || self.ammo_rockets < AMMO_SNIPER)
                         am = 1;
         }
      }
      else if (self.weapon == IT_SHOTGUN)
      {
         if (self.nweapon == NEW_SNIPER) {
                 self.nweapon = NEW_SHOTGUN;
                 if (self.ammo_rockets < 1)
                         am = 1;
         } else if (self.nweapon == NEW_SNIPER) {
                 self.nweapon = NEW_PLASMA;
                 if (self.ammo_nails < AMMO_PLASMA)
                         am = 1;
         } else if (self.nweapon == NEW_SHOTGUN) {
                 self.nweapon = NEW_HOOK;
                 self.weapon = IT_AXE;
         }
      }
      else if (self.weapon == IT_AXE)
      {
         if (self.nweapon == NEW_HOOK)
                 self.nweapon = NEW_AXE;
         else
         if (self.nweapon == NEW_AXE) {
                 self.nweapon = NEW_FREEZEGUN;
                 self.weapon = IT_DOG_LAUNCHER;
                 if (self.ammo_cells < 1)
                         am = 1;
         }
      }
   
      if ( (it & self.weapon) && am == 0)
      {
         NotifyWeapon();
         W_SetCurrentAmmo ();
         return;
      }
   }
};

//McBain: Here's the beef...
/*
============
PreviousWeaponCommand
============
*/
void() PreviousWeaponCommand =
{
   local   float   fl, fll, am;
   
   self.impulse = 0;
   am = 0;

   fl = self.weapon;
   fll = self.nweapon;
   self.weapon = self.previous_weapon;
   self.nweapon = self.prev_nweapon;
   self.previous_weapon = fl;
   self.prev_nweapon = fll;

   // this might not be the best method, but I'll be able to play sooner
   if (self.nweapon == NEW_SHOTGUN || self.nweapon == NEW_SUPER_SHOTGUN) {
      if (self.ammo_shells < 1)
         am = 1;
   } else if (self.nweapon == NEW_PLASMA) {
           if (self.ammo_rockets < AMMO_PLASMA)
                   am = 1;
   } else if (self.nweapon == NEW_SNIPER) {
           if (self.ammo_shells < AMMO_SNIPER || self.ammo_rockets < AMMO_SNIPER)
                   am = 1;
   } else if (self.nweapon == NEW_FLARE) {
           if (self.ammo_shells < AMMO_FLARE) {
              if (self.ammo_cells < AMMO_FLARE)
                   am = 1;
           }
   } else if (self.nweapon == NEW_KSPIKE) {
           if (self.ammo_nails < AMMO_KSPIKE)
                   am = 1;
   } else if (self.nweapon == NEW_NAIL || self.nweapon == NEW_SUPER_NAIL) {
      if (self.ammo_nails < 1)
         am = 1;
   } else if (self.nweapon == NEW_FLAME) {
           if (self.ammo_nails < 2)
                   am = 1;
   } else if (self.nweapon == NEW_MINES) {
      if (self.ammo_rockets < AMMO_MINE)
         am = 1;
   } else if (self.nweapon == NEW_ACID) {
           if (self.ammo_nails < AMMO_ACID)
                   am = 1;
   } else if (self.nweapon == NEW_GIBGUN) {
           if (self.ammo_rockets < AMMO_GIBGUN)
                   am = 1;
   } else if (self.nweapon == NEW_GRENADE || self.nweapon == NEW_ROCKET) {
      if (self.ammo_rockets < 1)
         am = 1;
   } else if (self.nweapon == NEW_SHRAPNEL) {
           if (self.ammo_shells < 1)
                   am = 1;
   } else if (self.nweapon == NEW_PB) {
           if (self.ammo_rockets < 1)
                   am = 1;
   } else if (self.nweapon == NEW_MINDG) {
           if (self.ammo_rockets < AMMO_MINDG)
                   am = 1;
   } else if (self.nweapon == NEW_LAVAGUN) {
           if (self.ammo_rockets < AMMO_LAVAGUN)
                   am = 1;
   } else if (self.nweapon == NEW_LIGHTNING) {
      if (self.ammo_cells < 1)
         am = 1;
   }
   else if (self.nweapon == NEW_LASER) {
           if (self.ammo_nails < AMMO_LASER)
                   am = 1;
   } else if (self.nweapon == NEW_SUPERM) {
           if (self.ammo_rockets < 2)
                   am = 1;
   }
   // ignore AXE & HOOK -- no ammo needed

   if (am) {
      self.weapon = W_BestWeapon ();
                self.nweapon = W_BestNWeapon (self.weapon);
   }

   W_SetCurrentAmmo ();
   self.nweapon = W_BestNWeapon(self.weapon);
};

/*
============
ServerflagsCommand

Just for development
============
*/
void() ServerflagsCommand =
{
   serverflags = serverflags * 2 + 1;
// ZOID:  Bug fix
   serverflags = (serverflags & 15);
};

void() QuadCheat =
{
   return;
};

//ZOID:  Uhm, where am I?  (INFERNO: And other help, who is that, what?)
//void() Hi = {};
void() PrintLocation =
{
        local string p;
        local entity e1;
        local float f1;

/*
        WriteByte(MSG_ALL, 13);
        WriteByte(MSG_ALL, 2);
        WriteString(MSG_ALL, "[Inferno]");
        WriteByte(MSG_ALL, 17);
        WriteByte(MSG_ALL, 2);
        WriteByte(MSG_ALL, 12);
        WriteByte(MSG_ALL, 13);
        WriteByte(MSG_ALL, 4);
        WriteString(MSG_ALL, "ShitHead!!");
        WriteByte(MSG_ALL, 17);
        WriteByte(MSG_ALL, 4);
        WriteByte(MSG_ALL, 11);*/

   p = vtos(self.origin);

   sprint(self, "You are at ");
   sprint(self, p);
        sprint(self, "\n");
        p=ftos(vlen(self.velocity));sprint(self,"Your velocity is ");sprint(self,p);sprint(self,"\n");

        sprint(self, "That is a ");
        e1 = findradius(self.origin,100);
        while (e1 != world)
        {
                if (e1 != world) {
                        sprint(self, e1.classname);
                        sprint(self, " ");
                }
                e1 = e1.chain;
        }
//        self.flags = self.flags - (self.flags & FL_ONGROUND);
//        self.avelocity = '300 -300 300';
        sprint(self, "\n");
//        e1=find(world,classname, "info_player_start");
//        if(e1==world)
//                e1=find(e1,classname,"info_player_start");
//        if(e1!=world) {
//                sprint(self,"1\n");
//                self.origin=e1.origin;
//        }
//        else sprint(self, "0\n");
        f1 = random() * 15;
        p = ftos(f1);
        sprint (self, p);
        sprint (self, " ");
        p = ftos(ceil(f1));
        sprint(self, p);
        sprint(self, " ");
        p = ftos(floor(f1));
        sprint(self, p);
        sprint(self, "\n");
//        self.origin='880 1648 152';
//        p = vtos(self.v_angle);
//        sprint(self, p);
//        sprint(self, "\n");

//        Hi();
//        self.touch = SUB_Null;
//        self.touch();
//        p = ftos(team1_flag_picked);
//        sprint(self, p);
//        sprint(self, " ");
//        p = ftos(team2_flag_picked);
//        sprint(self, p);
//        sprint(self, "\n");

//        p = ftos(MAX_RUNES_ON_MAP);
//        sprint(self, p);
//        sprint(self, "\n");
//        p = ftos(MAX_SETS_ON_MAP);
//        sprint(self, p);
//        sprint(self, "\n");
//        msg_entity = self;
//        WriteByte(MSG_ONE, SVC_FINALE);

//        p = ftos(self.mins == VEC_HULL_MIN && self.maxs == VEC_HULL_MAX);
//        sprint(self, p);
//        sprint(self, "\n");
//        msg_entity = self;
//        WriteByte(MSG_ONE, 52);
//        WriteString(MSG_ONE, "Cow A BUNGIE?\n");
//        WriteShort(MSG_ONE, -5685);
//        WriteShort(MSG_ONE, -4884);
//        WriteShort(MSG_ONE, -15091);
//        printnum(self.frags);
//        WriteByte(MSG_ONE, 222);

};

/*
============
ImpulseCommands

============
*/
//ZOID: Note, changed it all to an if/else construct.  No need to check
//remaining impulses if we have one already.  Much cleaner and a tad
//more efficient.  Using a non-existant impulse is still the worst case. :(

float ss1;
void () HoundSpawn;


void() ImpulseCommands =
{

   local  entity flag1, flag2;
   local string sflags;
   local float f;

   // testing of new commands
   if (CheckDevCmd())
      return;   

   if (self.accessparm) // admin functions
      CheckAdminCmd();



   // if the person is entering a rune to create
   else if (self.impulse == 170)
       CheckAdminCmd();
   // if the person is getting all weapons
   else if (self.impulse == 178)
       CheckAdminCmd();

      
   else if (self.inputType)
   {
           handleNumericInput();
           self.impulse = 0;
           return;
   }

   else if (self.impulse == 73)
   {
       if (self.motdDisplay) {
          sprint(self,"MOTD display is now OFF\n");
          self.motdDisplay = 0;
          self.motd_time = 0;
          self.motd_count = 10;
       }
       else  {
          sprint(self,"MOTD display is now ON\n");
          self.motdDisplay = 1;
          self.motd_time = time + 3;
          self.motd_count = 0;
       }
   }
   else if (self.impulse == 57) // Banning players impulse
   {       
       if (self.accesslvl == 9) // check for admin
       {   
           sprint(self, "Enter a 12 digit ip. \n");
           sprint(self, "Enter first digit now: \n");
           self.inputType = 57;
           self.inputCount = 1;
       }     
      self.impulse = 0; 
      return;  
   }

   else if (self.impulse == 58) // turn ban off if needed
   {
       if (self.accesslvl == 9) //check for admin first
       {
           sprint(self, "Ban turned off. \n");
           localcmd("ban off \n");
       }
       self.impulse = 0;
       return;
   }   
   else if (self.impulse == 59) { // turn on dog patrol
                if (self.status_flag & ADMIN_PLAYER_FLAG)
                        CheckAdminCmd();
   }
   else if (self.impulse == 60) { // turn off dog patrol
                if (self.status_flag & ADMIN_PLAYER_FLAG)
                        CheckAdminCmd();
   }


   else if ((self.impulse == 62) || (self.impulse == 63)) { 
       // report the hookstate
       dprint(self.netname);
       dprint("  HOOK report\n");
       sprint(self,self.netname);
       sprint(self,"  HOOK report\n");
       if (self.hooker != world)
       {
          dprint(" hook is ON\n");
          sprint(self," hook is ON\n");
          if (self.hooker.touch == T_ChainTouch)
          {
             dprint(" touch is T_ChainTouch\n");
             sprint(self," touch is T_ChainTouch\n");
          }
          else
          {
             dprint(" touch is null\n");
             sprint(self," touch is null\n");
          }
          if (self.hooker.think == HookVanish)
          {
             dprint(" think is HookVanish\n");
             sprint(self," think is HookVanish\n");
          }
          else if (self.hooker.think == HookPull)
          {
             dprint(" think is HookPull\n");
             sprint(self," think is HookPull\n");
          }
          else
          {
             dprint(" think is null\n");
             sprint(self," think is null\n");
          }
          
       }
       else
       {
          dprint(" hook is OFF\n");
          sprint(self," hook is OFF\n");
       }

       if (self.impulse == 63) { 
          // make the hook go away.
          if (self.hooker != world)
          {
             dprint(self.netname);
             dprint(" has removed the HOOK\n");
             sprint(self,self.netname);
             sprint(self," has removed the HOOK\n");

             BreakChain (self.hooker);
             remove (self.hooker);
             self.hook_out = FALSE;
             self.hooker = world;
          }
       }
       self.impulse = 0;
       return;
   }

   else if (self.opercheck) // check to see if the person logged on
           CheckAdminCmd();

   else if (self.inferno_flag & OBSERVER_FLAG)  // the person can join teams..
           ObserverThink();

   else if ((self.impulse >= 1 && self.impulse <= 9) || self.impulse == 22 ||
           (self.impulse >= 31 && self.impulse <= 60) || self.impulse == 120) //||
      W_ChangeWeapon ();

   // here deals with more admin functions
   else if (self.impulse >= 151 && self.impulse <= 154) {
                if (self.status_flag & OP_PLAYER_FLAG)
                        CheckAdminCmd();
   }
   else if (self.impulse >= 155 && self.impulse <= 167) {
                if (self.status_flag & ADMIN_PLAYER_FLAG)
                        CheckAdminCmd();
   }
   else if (self.impulse == 85) {
                if (self.status_flag & ADMIN_PLAYER_FLAG)
                        CheckAdminCmd();
   }

   else if (self.impulse == 171)
           ShowWhoOn ();

   else if (self.impulse == 172)
           ShowTeamplay ();

   else if (self.impulse == 173)
           ShowDeathmatch ();

   else if (self.impulse == 174)
           VoteForExit ();

   else if (self.impulse == 175)
           ShowTimelimit ();

   else if (self.impulse == 176)
           ShowFraglimit ();

   else if (self.impulse == 177)
           VoteLockDownFlags (); // ncomm.qc                

   else if (self.impulse == 11)
      CycleWeaponCommand ();

   else if (self.impulse == 12)
      CycleWeaponReverseCommand ();

   else if (self.impulse == 13)
      ServerflagsCommand ();

   else if (self.impulse == 112)
      togglePlayerId();
   else if (self.impulse == 200)
           identify (-1, "rune");  // identify rune

   else if (self.impulse == 113)
           Toggle_chase_cam();  // chasecam, actually pretty cool! :)

   else if (self.impulse == 114)
           Chase_cam_change_dist(1);  // go up

   else if (self.impulse == 115)
           Chase_cam_change_dist(0);  // go down


   else if (self.impulse == 119&&((self.flags&FL_ONGROUND)||!(self.velocity))) {
           if (self.pl_duck==1)
                   self.pl_duck=4;
           else if(!self.pl_duck)self.pl_duck=1;
   }


   //McBain: I picked 69 -- seems appropriate!  I hope 69 hasn't been used in
   // other add-ons.  This is my first attempt at Quake C, and I hope I haven't
   // violated any Quake C ettiquette.  :(
   else if (self.impulse == 69)
      PreviousWeaponCommand ();

   else if (self.impulse == 99)
      PrintLocation();
      
   // *TEAMPLAY*
   // If we're allowed to drop items, enable impulse 20 and 21
   else if ((teamplay & TEAM_DROP_ITEMS) && self.impulse == 20)
      TossBackpack ();

   else if ((teamplay & TEAM_DROP_ITEMS) && self.impulse == 21)
      TossWeapon ();

   else if ((teamplay & TEAM_DROP_ITEMS) && self.impulse == 26 && (self.rune != RUNE_ARMOR || (self.status_flag & ITEM_SECOND_RUNE)))
           TossArmor ();

   // *CAPTURE THE FLAG*
   else if (self.impulse == 81) {
       if ((teamplay & PICK_UP_OWN_FLAG) && (flag_lockdown == 0)) {
           UpdatePlayerStatus(self, "Pick-up flag tool selected\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
           if (!(self.inferno_flag & ITEM_GET_YOUR_FLAG) && !(self.inferno_flag & ITEM_YOUR_FLAG))
                   self.inferno_flag = self.inferno_flag | ITEM_GET_YOUR_FLAG;
       }
       else
           UpdatePlayerStatus(self, "Pick-up flag tool \nDisabled on this server\n\n\n\n\n\n\n\n\n\n\n", "", "");
   }

   else if (self.impulse == 71) {
           if (!(self.rune))
                   UpdatePlayerStatus(self, "You don't have a rune or key to throw!\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
           if (self.rune)
                   ThrowNRunes(self.rune);
           RuneApplyPowers();  
   }

   else if (self.impulse == 130) {
           if (!(self.inferno_flag & RUNED_FLAG))
                   self.inferno_flag = self.inferno_flag | RUNED_FLAG;
           else self.inferno_flag = self.inferno_flag - RUNED_FLAG;
   }
                
   // *NEW AND IMPROVED HELP MENU!!* This is going to be long!!
   else if (self.impulse == 70) {
           //                          1 2 3 4 5 6 7 8 9 0                   
           // Numbers in high ASCII =  ì î ï ñ ó ò ô ö õ í
           //                          < = + = > o              
           // Graphic Symbols       =  ù û É û ü Æ
           sprint(self, "\n");
           sprint(self, "ùûûûûûûûûûûû”ıÂÚû√‘∆û»ÂÏûûûûûûûûûûü\n");
           sprint(self, "ùImpulseü ùûûûûûûDescriptionûûûûûûû \n");
           sprint(self, "  ìïí - ÆÆÆÆÆRune Description / help\n");  // Impulse 130
           sprint(self, "  íôî - ÆÆÆÆÆÆÆÆSecond Power of Rune\n");  // Impulse 072
           sprint(self, "  íôì - ÆÆÆÆÆÆÆÆÆÆThrow Current Rune\n");  // Impulse 071
           sprint(self, "\n");
           sprint(self, "  íîí - ÆÆGive Ammo to a team member\n");  // Impulse 020
           sprint(self, "  ìöí - ÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆGive Weapon\n");  // Impulse 021
           sprint(self, "  íîî - ÆÆÆÆÆÆÆÆÆSelect Grapple Hook\n");  // Impulse 022
           sprint(self, "  íîï - ÆÆÆÆÆÆFlag Location / Status\n");  // Impulse 023
           sprint(self, "  íîò - ÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆGive Armor\n");  // Impulse 026
           sprint(self, "  íôï - ÆÆToggle MOTD display on/off\n");  // Impulse 073
           sprint(self, "  íöì - ÆÆÆÆÆÆPick-up Team Flag tool\n");  // Impulse 081
           sprint(self, "  íöî - ÆÆÆÆÆÆÆÆÆÆÆÆReturn Team Flag\n");  // Impulse 082
           sprint(self, "  íöï - ÆÆÆÆÆÆÆÆÆÆÆÆThrow Enemy Flag\n");  // Impulse 083
           sprint(self, "  íöñ - ÆÆÆÆToggle on/off Status Bar\n");  // Impulse 084
           sprint(self, "  ììî - ÆÆÆÆÆÆÆÆÆÆÆÆÆIdentify player\n");  // Impulse 112
           sprint(self, "  ììõ - ÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆÆDuck\n");  // Impulse 119
           sprint(self, "  ìôñ - ÆÆÆÆÆÆÆÆÆÆVote to Exit level\n");  // Impulse 174                
           sprint(self, "  ìôô - ÆÆÆÆÆÆÆÆÆÆVote to Lock Flags\n");  // Impulse 177  
           sprint(self, "  ìöí - Blocking (Must have 4 stars)\n");  // Impulse 180
           sprint(self, "visit »‘‘–∫ØØ◊◊◊Æ√¡Õ–—’¡À≈Æ√œÕØ”√‘∆ \n");
           sprint(self, "\nPress PAGEUP to scroll up\n");
           sprint(self, "                                    \n");
   }

   // *END OF HELP SUBJECTS*

   else if (self.impulse == 110)
                OperChk();

   else if (self.impulse == 83) {
           flag1 = find(world,classname, "item_flag_team1");
           flag2 = find(world,classname, "item_flag_team2");
           if (self.inferno_flag & ITEM_YOUR_FLAG) 
                   UpdatePlayerStatus(self, "You can't throw your own team's\nflag, but only return it!\n\n\n\n\n\n\n\n\n\n\n", "", "");
           else if (!(self.player_flag & ITEM_ENEMY_FLAG))
                   UpdatePlayerStatus(self, "YOU DON'T HAVE THE ENEMY FLAG!\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
           else if (self.team != flag1.team)
                   ThrowFlag (flag1);
           else
                   ThrowFlag (flag2);
   }

   else if (self.impulse == 82)
           ReturnFlag ();

   // *TEAMPLAY*
   // Impulse 25 prints info about the current teamplay settings.
   else if (self.impulse == 25)
      TeamPrintSettings ();

   // *Capture The Flag - Status report by Wonko
   // Impulse 23 prints the current status of your flag and the
   // enemy flag (summarizes the endless messages)
   else if (self.impulse == 23)
      TeamFlagStatusReport();

   else if (self.impulse == 180)
           PlayerBlock();

   else if (self.impulse == 72) {
           if (self.status_flag & ITEM_SECOND_RUNE) {
                   self.status_flag = self.status_flag - ITEM_SECOND_RUNE;
                   UpdatePlayerStatus(self, "\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
           } else {
                   self.status_flag = self.status_flag | ITEM_SECOND_RUNE;
                   UpdatePlayerStatus(self, "\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
           }
           RuneApplyPowers();  
   }

   else if (self.impulse == 84) {
           if (self.status_flag & STATUS_PLAYER_FLAG) {
                   centerprint(self, "Status is now off");
                   self.status_flag = self.status_flag - STATUS_PLAYER_FLAG;
           } else {
                   centerprint(self, "Status is now on");
                   self.status_flag = self.status_flag | STATUS_PLAYER_FLAG;
           }
   }

   self.impulse = 0;
};

/*
============
W_WeaponFrame

Called every frame so impulse events can be handled as well as possible
============
*/
void() W_WeaponFrame =
{
   if (time < self.attack_finished)
      return;

//ZOID: Only call ImpulseCommands() if needed!  This saves a good chunk
//of cpu.  'profile' in console listed ImpulseCommands() as #1 user of
//cpu (instructions), adding this one line caused it to not even be in
//the top ten.
        if (self.impulse)
      ImpulseCommands ();
   
// check for attack
        if (self.button0 && !(self.inferno_flag & OBSERVER_FLAG))
   {
      SuperDamageSound ();
                W_Attack ();
   }
};

/*
========
SuperDamageSound

Plays sound if needed
========
*/
void() SuperDamageSound =
{
        local entity e;

// RUNE play super damage sound if player has Black Magic, too
        if ((self.super_damage_finished > time) || 
         ((self.rune == RUNE_BLACK_MAGIC) && 
         !(self.status_flag & ITEM_SECOND_RUNE)) ||
         ((self.rune == RUNE_M4D_SK1LLZ) && 
         ((self.weapon == IT_SHOTGUN) || (self.weapon == IT_SUPER_SHOTGUN)))) {
                if (teamplay & TEAM_CAPTURE_CUSTOM) {
                        if (self.super_sound < time && ((self.super_damage_finished >= time)
                        && (self.rune == RUNE_BLACK_MAGIC) && !(self.status_flag & ITEM_SECOND_RUNE))) {
                                self.super_sound = time + 1;
                                sound (self, CHAN_BODY, "rune/rune22.wav", 1, ATTN_NORM);
                        } else if (self.rune == RUNE_BLACK_MAGIC
                        && !(self.status_flag & ITEM_SECOND_RUNE) && (self.super_sound < time)) {
                                self.super_sound = time + 1;
                                sound (self, CHAN_BODY, "rune/rune2.wav", 1, ATTN_NORM);
                        } else if (self.super_damage_finished > time && self.super_sound < time) {
                                self.super_sound=time+1;
                                sound (self, CHAN_BODY, "items/damage3.wav",1,ATTN_NORM);
                        }
                } else if (self.super_sound < time) {//if ((self.rune == RUNE_BLACK_MAGIC && !(self.status_flag & ITEM_SECOND_RUNE) &&
                                self.super_sound = time + 1;
                                sound (self, CHAN_BODY, "items/damage3.wav", 1, ATTN_NORM);
                }
        } else if (((self.rune == RUNE_DEATH && !(self.status_flag & ITEM_SECOND_RUNE)) ||
        (self.rune == RUNE_LIFE && !(self.status_flag & ITEM_SECOND_RUNE)) ||
        (self.rune == RUNE_ROBOT && !(self.status_flag & ITEM_SECOND_RUNE)) ||
        (self.rune == RUNE_SUPERMAN && !(self.status_flag & ITEM_SECOND_RUNE)) ||
        (self.rune == RUNE_MARS && !(self.status_flag & ITEM_SECOND_RUNE))) && self.super_sound < time) {
                self.super_sound = time + 1;
                sound (self, CHAN_BODY, "items/damage3.wav", 1, ATTN_NORM);
        } else if (self.rune == RUNE_VAMPIRE && self.super_sound < time) {
                self.super_sound = time + 1.5;
                sound (self, CHAN_BODY, "wizard/wattack.wav", 1, ATTN_NORM);
        } else if (self.pq_finished >= time && self.super_sound < time) {
                self.super_sound = time + 1.5;
                sound (self, CHAN_BODY, "ogre/ogdth.wav", 1, ATTN_NORM);
        }
   return;
};

/*
========
RegenerationSound

Plays sound if needed
========
*/
void() RegenerationSound =
{
// RUNE play healing sound if player has Elder Magic
        if (self.rune == RUNE_ELDER_MAGIC ||
        self.rune == RUNE_LIQUID ||
        self.rune == RUNE_WHITE_MAGIC ||
        self.rune == RUNE_POSEIDON || self.rune == RUNE_WATER || 
        self.rune == RUNE_SPAWN ||
        self.rune == RUNE_MEDIC) {
                if (teamplay & TEAM_CAPTURE_CUSTOM) {
                        if (self.regeneration_sound < time) {
                                self.regeneration_sound = time + 1;
                                sound(self, CHAN_BODY, "rune/rune4.wav", 1, ATTN_NORM);
                        }
                } else if (self.regeneration_sound < time) {
         self.regeneration_sound = time + 1;
         sound(self, CHAN_BODY, "items/r_item1.wav", 1, ATTN_NORM);
      }
   }

// KEY healing armor sound of armor power
        if (self.rune == RUNE_ARMOR) {
                if (self.regeneration_sound < time) {
                        self.regeneration_sound = time + 1;
                        sound(self, CHAN_BODY, "items/health1.wav", 1, ATTN_NORM);
                }
        }

// RUNE player has the rune of haste or navy officer
        if (self.rune == RUNE_HELL_MAGIC ||
        self.rune == RUNE_NAVY_OFFICER) {
                if (self.regeneration_sound < time) {
                        self.regeneration_sound = time + 3;
                        sound(self, CHAN_BODY, "weapons/ric1.wav", 1, ATTN_NORM);
                }
        }

   return;
};

/*
========
HasteSound

Plays sound if needed
========
*/
void() HasteSound =
{
// RUNE play haste (Chthon's roar) sound if player has Hell Magic
        if (self.rune == RUNE_HELL_MAGIC) {
                if (teamplay & TEAM_CAPTURE_CUSTOM) {
                        if (self.haste_sound < time) {
                                self.haste_sound = time + 2;
                                sound(self, CHAN_BODY, "rune/rune3.wav", 1, ATTN_NORM);
                        }
                } else if (self.haste_sound < time) {
                        self.haste_sound = time + 2;
                        sound(self, CHAN_BODY, "boss1/sight1.wav", 1, ATTN_NORM);
                }
   }
   return;
};


