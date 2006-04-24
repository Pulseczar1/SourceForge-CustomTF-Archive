/* nweapons.qc - by inferno (waije@titan.oit.umass.edu)
this script file has all the new weapons that were added to quake.
*/
// void () FragmUp;
void() doggy_run1;
void() doggy_stand1;
void(entity e, float eeflag) startEEManager;
void() firstThink;


//  The most important to make things easier which will be used
//  so many times is this.  It's like launch_spike except this
//  gives more possibilities to the launching of some kind of
//  projectile.  At this point SCTF really needs it so I made
//  it :)
void(string c, string m, void() t) launch_inf =
{
   local vector dir;

   dir = aim(self, 1000);
   newmis = spawn();
   newmis.owner = self;
   if (c == "grenade1" || c == "grenade2" || c == "fragm") newmis.movetype = MOVETYPE_BOUNCE;
   else newmis.movetype = MOVETYPE_FLY;
   newmis.solid = SOLID_BBOX;

   newmis.touch = t;
	
   // set missile speed	

	makevectors (self.v_angle);

   if (c == "grenade1" || c == "grenade2" || c == "fragm") {
      if (self.v_angle_x) 
         newmis.velocity = v_forward*600 + v_up*200 + crandom()*v_up*10;
      else {
         newmis.velocity = aim(self,10000);
         newmis.velocity = newmis.velocity * 600;
         newmis.velocity_z = 200;
      }
      newmis.avelocity = '300 300 300';
      newmis.angles = vectoangles(newmis.velocity);
      newmis.think = GrenadeExplode;
      newmis.nextthink = time + 2.5;
   } else {
      if (c == "gib2")
              newmis.velocity = dir * 600;
      else if (c == "gib3")
              newmis.velocity = dir * 300;
      else if (c == "teleporter"||c=="laser bouncer") // c == "green arrow" || 
              newmis.velocity = dir * 600;
      else if (c == "fragm2")
              newmis.velocity = dir * 550;
      else if (c == "lightning bolt" && self.rune == RUNE_FP && (self.status_flag & ITEM_SECOND_RUNE))
              newmis.velocity = dir * 2000;
      else if (c=="leftpm"||c=="rightpm"||c=="medpm")
              newmis.velocity = dir * 500;
      else newmis.velocity = dir * 1000;

      if (c == "gib2" || c == "gib3" || c == "gib1") {
              newmis.avelocity = '1200 0 0';
              c = "gibs";
      }

      if (m == "progs/bolt3.mdl")
              newmis.angles = vectoangles(newmis.velocity) + '0 0 90';
      else newmis.angles = vectoangles(newmis.velocity);
   }

   newmis.classname = c;
   if (!newmis.think)
           newmis.think = SUB_Remove;
   if (!newmis.nextthink)
           newmis.nextthink = time + 10;

   if (c == "torch") {
           newmis.nextthink = time + 0.4;
           newmis.velocity = newmis.velocity * 0.5;
   }
//   if (c == "fragm") {
//           newmis.think = FragmUp;
//           newmis.nextthink = time + 5;
//   }
   
   setmodel(newmis, m);
   setsize(newmis, '0 0 0', '0 0 0');
   if (c == "rocket1") {
           setorigin (newmis, self.origin + v_forward*8 + '0 0 16' + v_right*12);
           newmis.classname = "double rockets";
   } else if (c == "rocket2") {
           setorigin (newmis, self.origin + v_forward*8 + '0 0 16' + v_right*-12);
           newmis.classname = "double rockets";
   } else if (c == "grenade1" || c == "grenade2" || c == "fragm") {
           if (c == "grenade1") setorigin (newmis, self.origin + v_right*16);
           if (c == "grenade2") setorigin (newmis, self.origin + v_right*-16);
           if (c == "fragm") setorigin (newmis, self.origin);
           newmis.classname = "double grenades";
   } else if (c == "noisy cricket") {
           dir=self.origin + '0 0 16';
           traceline (dir, dir + v_forward*2000, FALSE, self);
           setorigin (newmis, trace_endpos + v_forward*-10);
   } else if (c == "lightning bolt" && 
      self.rune == RUNE_FP && (self.status_flag & ITEM_SECOND_RUNE)) {
           setorigin (newmis, self.origin + v_forward*8 + '0 0 16' + v_right*infrandom()*80);
           newmis.rune = RUNE_FP;
   } else setorigin (newmis, self.origin + v_forward*8 + '0 0 16');

   // INFERNO: power check, lets see if the power needs to intervene
   if (c=="teleporter" && self.nweapon==NEW_RP)
      newmis.rune_power=RUNE_TELEPORT;
};

/* trip wire think - by inferno (waije@titan.oit.umass.edu)
-------------------------------------------------------------
enough said
-------------------------------------------------------------
*/
//void()TWireThink={
//        if(self.count_count<time){remove(self);return;}
//        makevectors(self.angles);
//        traceline(self.origin,self.origin + v_forward*-2000, FALSE, self);
//        WriteByte (MSG_BROADCAST,SVC_TEMPENTITY);WriteByte(MSG_BROADCAST,TE_LIGHTNING2);
//        WriteEntity(MSG_BROADCAST,self);
//        WriteCoord(MSG_BROADCAST,self.origin_x);
//        WriteCoord(MSG_BROADCAST,self.origin_y);
//        WriteCoord(MSG_BROADCAST,self.origin_z);
//        WriteCoord(MSG_BROADCAST,trace_endpos_x);
//        WriteCoord(MSG_BROADCAST,trace_endpos_y);
//        WriteCoord(MSG_BROADCAST,trace_endpos_z);
//        if(trace_ent.health&&trace_ent.classname=="player") {
//                T_Damage(trace_ent,self,self.owner,300);
//                T_RadiusDamage(self,self.owner, 300, world);
//                remove(self);
//                return;
//        }
//        self.nextthink=time + 0.1;
//};

/* black magic ground explosions - by inferno (waije@titan.oit.umass.edu)
------------------------------------------------------------------------
here's something really cool, a bunch of explosions are on the ground
giving off radius damage to people except for the owner...only goes
in one direction though
------------------------------------------------------------------------
*/
//void(vector org)BMCreate={
//        local entity e;

//        e=spawn();
//        e.owner=self.owner;
//        e.classname="ground explosions";
//        e.movetype=MOVETYPE_NONE;
//        setmodel(e,"progs/s_explod.spr");
//        setsize(e,'0 0 0', '0 0 0');
//        setorigin(e,org);
//        T_RadiusDamage(e, self, 75, world);
//        sound(e, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);
//        e.think=s_explode1;
//        e.nextthink=time + 0.1;
//};

//void() StartExplosions=
//{
//        local vector org;

//        org=self.owner.origin + '0 0 16';
//        self.count_count=self.count_count + 1;
//        if(self.count_count==1) traceline(org, org + v_forward*100, TRUE, self);
//        else if (self.count_count==2) traceline(org, org + v_forward*400, TRUE, self);
//        else if (self.count_count==3) traceline(org, org + v_forward*700, TRUE, self);
//        else if (self.count_count>3){remove(self);return;}
//        BMCreate(trace_endpos);
//        self.nextthink=time + 0.5;
//};

//void()BMGroundExplosions=
//{
//        local entity e;
//        e=spawn();
//        e.owner=self;
//        e.think=StartExplosions;
//        e.nextthink=time + 0.5;
//};

/* torch - by inferno (waije@titan.oit.umass.edu)
---------------------------------------------------------------
another MIB weapon, acts like the flamethrower in a way but
can't make people catch on fire
---------------------------------------------------------------
*/
void() T_TorchTouch =
{
//        other = self.owner;
        self.velocity = '0 0 0';
        if (other.takedamage && other.health) {
                T_Damage(other, self, self.owner, 20);
                spawn_touchblood(20);
        }
        remove(self);
};
/***END OF THE TORCH TOUCH***/
  
/* noisy cricket - by inferno (waije@titan.oit.umass.edu)
---------------------------------------------------------------
the small little weapon "I'm going to break this thang" from the
Men In Black that does a lot of damage
---------------------------------------------------------------
*/
void() T_CTouch =
{
        local entity e;

        sound(self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);
        e = findradius(self.origin, 200);
        while (e) {
                if (e.takedamage && e.health && CanDamage(e, self))
                        T_Damage(e, self, self.owner, 35);
                e = e.chain;
        }
        e=findradius(self.origin,600);
        while(e) {
                if (e.classname == "player" && CanDamage(e, self)) {
                        makevectors(self.owner.v_angle);
                        e.velocity=e.velocity + v_forward*-3000;
                }
                e=e.chain;
        }
        WriteByte(MSG_BROADCAST,SVC_TEMPENTITY);
        WriteByte(MSG_BROADCAST,TE_EXPLOSION);
        WriteCoord(MSG_BROADCAST,self.origin_x);
        WriteCoord(MSG_BROADCAST,self.origin_y);
        WriteCoord(MSG_BROADCAST,self.origin_z);
        BecomeExplosion();
};
/***END OF NOISY CRICKET TOUCH***/

/* zombie gibs - by inferno (waije@titan.oit.umass.edu)
---------------------------------------------------------------
shot by the zombie, just gibs FLYING ALL OVER the place
---------------------------------------------------------------
*/
void() T_ZombieGTouch =
{
        T_RadiusDamage (self, self.owner, 100, other);
//        other = self.owner;
        if (other.takedamage && other.health) {
                T_Damage (other, self, self.owner, 60);
                if (other.classname == "player")
                        other.velocity = self.velocity;
        }
        sound (self, CHAN_WEAPON, "zombie/z_miss.wav", 1, ATTN_NORM);
        BecomeExplosion();
};
/***END OF ZOMBIE GIBS POWER***/
 
/* nature power - by inferno (waije@titan.oit.umass.edu)
---------------------------------------------------------------
spawned by artemis, it shoots dogs which do extra damage and just
bites the person (exploding dogs!)
---------------------------------------------------------------
*/
void() T_DogTouch =
{
//        T_RadiusDamage (self, self.owner, 90, other);
//        other = self.owner;
        if (other.takedamage && other.health) {
                T_Damage (other, self, self.owner, 22);
                if (other.classname == "player")
                        other.velocity = self.velocity;
        }
        BecomeExplosion();
};
/***END OF NATURE POWER***/


/* whirlwind spin - by inferno (waije@titan.oit.umass.edu)
---------------------------------------------------------------
this will work, spawned by the kung lao rune he can damage anyone
severely whoever touches him!
---------------------------------------------------------------
*/

// void() LaosThink =
// {
//         local entity e1;
// 
//         if (self.regen_time < time)// || self.firewood.health <= 0)
//         {
//                 if (self.cnt) {
//                         self.owner.rune12clone_count = self.owner.rune12clone_count - 1;
//                         remove(self);
//                 } else {
//                         self.cnt = 1;
//                         self.nextthink = time + 4;
//                 }
//                 return;
//         }
//         setorigin(self, self.owner.origin + '0 0 16' + v_up*10);
//         self.origin = self.owner.origin + '0 0 16' + v_up*10;
//         particle(self.origin, '0 0 200', 1111, 50);
//         self.nextthink = time + 0.1;
//         if (self.rune_count < time) {
//                 sound (self, CHAN_WEAPON, "hknight/slash1.wav", 1, ATTN_NORM);
//                 self.rune_count = time + 0.2;
//         }
// };

// void() W_LaoSpin =
// {
//         local   entity laos, mpuff, head; 
// 
// 	self.punchangle_x = -2;
// 
//         if (self.rune12clone_count >= 1) {
//                 UpdatePlayerStatus(self, "You can't use your whirlwind spin\nbecause you just did!\n\n\n\n\n\n\n\n\n\n\n", "", "");
//                 return;
//         }
// 
//         self.rune12clone_count = self.rune12clone_count + 1;
// 
//         laos = spawn ();
//         laos.owner = self;
//         laos.movetype = MOVETYPE_FLY;
//         laos.solid = SOLID_BBOX;
//         laos.classname = "whirlwind spin";
// 		
// // set missile speed
// 
// 	makevectors (self.v_angle);
// 
//         laos.velocity = aim(self, 1000);
//         laos.velocity = laos.velocity * 0;
//         laos.angles = vectoangles(laos.velocity);
// 
//         laos.avelocity = '600 0 0';
// 
//         // now to bring people in the air
//         laos.think = LaosThink;
//         laos.nextthink = time + 0.1;
// 
//         laos.regen_time = time + 5;
// 		
//         setmodel (laos, "progs/bolt3.mdl");
//         setsize (laos, '0 0 0', '0 0 0');
//         setorigin (laos, self.origin + '0 0 16' + v_up*10);
//         laos.origin = self.origin + '0 0 16' + v_up*10;
// };        

/***END OF KUNG LAO'S WHIRLWIND SPIN***/

/* Head Throw - by inferno (waije@titan.oit.umass.edu)
---------------------------------------------------------------
ok, ok, this is a little different than the original..in the
original Kung Lao throws a hat, but this guy throws a head!
---------------------------------------------------------------
*/

void() T_HeadTouch =
{
        local vector spray;

        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
        WriteByte (MSG_BROADCAST, TE_WIZSPIKE);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

        if ((other.takedamage) && (other.health > 0)) {
                spray_x = 100 * crandom();
                spray_y = 100 * crandom();
                spray_z = 100 * crandom() + 50;
                SpawnBlood (self.origin, spray, 100);
                T_Damage (other, self, self.owner, 22);  // damage them
                self.classname = "bouncer";
                T_Damage (other, self, self.owner, 2000);  // bounce them
        }
        BecomeExplosion();
};

/*
================
W_FireHead
================
*/
/*
void() W_FireHead =
{
        local   entity headd, mpuff, head;
	
//        sound (self, CHAN_WEAPON, "misc/medkey.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

        headd = spawn ();
        headd.owner = self;
        headd.movetype = MOVETYPE_FLY;
        headd.solid = SOLID_BBOX;
        headd.classname = "head";
		
// set missile speed	

	makevectors (self.v_angle);

        headd.avelocity = '300 0 0';

        headd.velocity = aim(self, 1000);
        headd.velocity = headd.velocity * 1000;
        headd.angles = vectoangles(headd.velocity);
	
        headd.touch = T_HeadTouch;

        headd.think = SUB_Remove;
        headd.nextthink = time + 5;
	
        setmodel (headd, "progs/h_player.mdl");
        setsize (headd, '0 0 0', '0 0 0');
        setorigin (headd, self.origin + v_forward*8 + '0 0 16');
};*/
/***END OF THE HEAD***/

/* Flying Kick - by inferno (waije@titan.oit.umass.edu)
---------------------------------------------------------------
made by Liu Kang rune, it happens just like in Mortal Kombat,
the frames are a little different since we have to work with what
we have
---------------------------------------------------------------
*/

void() W_FireKang =
{
        self.touch = PlayerTouch;

        // give the person the right flag
        self.inferno_flag = self.inferno_flag | FR_KANG;

        // now give a time when to automatically stop
        if (self.rune_count < time)
                self.rune_count = time + 2;  // stop in 2 seconds
};

// remove the shadow-ram
void() RemoveKang =
{
        local entity e1;
        self.touch = SUB_Null;

        // take away the flag if the person has it
        if (self.inferno_flag & FR_KANG)
                self.inferno_flag = self.inferno_flag - FR_KANG;

        // special effects:  just like in MK
//        makevectors(self.v_angle);
//        self.velocity = v_forward*-500 + v_up*500;
        self.attack_finished = time + 0.5;  // attack_finished resets
};
/***END OF THE FLYING KICK***/

/* cannonball - by inferno (waije@titan.oit.umass.edu)
---------------------------------------------------------------
spawned by the kano rune, this makes the person do a cannonball
like move
---------------------------------------------------------------
*/

void() W_FireKano =
{
        self.touch = PlayerTouch;
        // give the person the right flag
        self.inferno_flag = self.inferno_flag | FR_KANO;

        // now give a time when to automatically stop
        if (self.rune_count < time) {
                self.rune_count = time + 2;  // stop in 2 seconds
        }

};

// remove the shadow-ram
void() RemoveKano =
{
        local entity e1;

        self.touch = SUB_Null;

        // take away the flag if the person has it
        if (self.inferno_flag & FR_KANO)
                self.inferno_flag = self.inferno_flag - FR_KANO;

        // special effects:  just like in MK
        makevectors(self.v_angle);
        self.velocity = v_forward*-500 + v_up*500;
        self.attack_finished = time + 0.5;  // attack_finished resets
};
/***END OF THE CANNONBALL***/

/* knife - by inferno (waije@titan.oit.umass.edu)
---------------------------------------------------------------
spawned by the kano rune, throws a knife which does a fair amount
of damage!
---------------------------------------------------------------
*/

void() KnifeThink =
{
   local float done;
   done = 0;
   if (self.owner.health <= 0)
      done = 1;
   else if ((self.owner.rune != RUNE_KANO) ||
      (self.owner.status_flag & ITEM_SECOND_RUNE))
      done = 1;
   else if (self.regen_time < time) 
   {
      done = 1;
      self.owner.rune12clone_count = self.owner.rune12clone_count - 1;
   }
   if (done)
   {
      T_MissileTouch();
      remove(self);
      return;
   }
   self.nextthink = time + 0.5;
};

void() KnifeTouch =
{
//        if (self.flags & FL_ONGRO
        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
        WriteByte (MSG_BROADCAST, TE_WIZSPIKE);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

        if (other.classname == "player") {
                self.owner.rune12clone_count = self.owner.rune12clone_count - 1;
                T_Damage(other, self, self.owner, 40);
                T_MissileTouch();
                remove(self);
        }

//        self.flags = self.flags - (self.flags & FL_ONGROUND);
        self.velocity_y = -500 + (random()*1000);
        self.velocity_x = -500 + (random()*1000);

};

/*
================
W_FireKnife
================
*/
void() W_FireKnife =
{
        local   entity knife, mpuff, head;
	
//        sound (self, CHAN_WEAPON, "misc/medkey.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

        if (self.rune12clone_count >= 4) {
                UpdatePlayerStatus(self, "You already have 4 knives flying!\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
                return;
        }
        self.rune12clone_count = self.rune12clone_count + 1;

        knife = spawn ();
        knife.owner = self;
        knife.movetype = MOVETYPE_FLY;
        knife.solid = SOLID_BBOX;
        knife.classname = "knife";
		
// set missile speed	

	makevectors (self.v_angle);

        knife.avelocity = '300 300 300';

        knife.velocity = aim(self, 1000);
        knife.velocity = knife.velocity * 1000;
        knife.angles = vectoangles(knife.velocity);
	
        knife.touch = KnifeTouch;

        // when to remove it
        knife.regen_time = time + 4;  // four seconds

        knife.think = KnifeThink;
        knife.nextthink = time + 0.5;
	
        setmodel (knife, "progs/bolt3.mdl");
        setsize (knife, '0 0 0', '0 0 0');
        setorigin (knife, self.origin + v_forward*8 + '0 0 16');
};
/***END OF THE KNIFE***/

/* shadow-ram - by inferno (waije@titan.oit.umass.edu)
---------------------------------------------------------------
called by johnny cage's rune, it makes him move fast and do damage
to whomever he touches, a shadow-like figure and effects follow
the person
---------------------------------------------------------------
*/

void() W_FireJCage =
{
        self.touch = PlayerTouch;
        // give the person the right flag
        self.inferno_flag = self.inferno_flag | FR_JCAGE;

        // now give a time when to automatically stop
        if (self.rune_count < time)
                self.rune_count = time + 2;  // stop in 2 seconds
};

// remove the shadow-ram
void() RemoveShadowRam =
{
        local entity e1;

        self.touch = SUB_Null;
        // take away the flag if the person has it
        if (self.inferno_flag & FR_JCAGE)
                self.inferno_flag = self.inferno_flag - FR_JCAGE;

        e1 = find(world, classname, "shadow person");
        while (e1 != world) {
                remove(e1);
                e1 = find(e1, classname, "shadow person");
        }
};
/***END OF THE SHADOW RAM***/

/* green fireball - by inferno (waije@titan.oit.umass.edu)
----------------------------------------------------------------
spawned by the johnny cage rune, this is like a discus and it
does tremendous amounts of damage once it hits!
----------------------------------------------------------------
*/
void() GreenFireThink =
{
//        if (self.velocity = '0 0 0') {
//                self.velocity_z = -400 + (random()*1000);
//                self.velocity_y = -500 + (random()*1000);
//                self.velocity_x = -500 + (random()*1000);
//        }
//        self.flags = self.flags - (self.flags & FL_ONGROUND);
        if (self.regen_time < time) {
                self.owner.rune12clone_count = self.owner.rune12clone_count - 1;
                T_MissileTouch();
                remove(self);
                return;
        }
        self.nextthink = time + 0.5;
};

void() GreenFireTouch =
{
        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
        WriteByte (MSG_BROADCAST, TE_WIZSPIKE);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

        if (other.classname == "player") {
                self.owner.rune12clone_count = self.owner.rune12clone_count - 1;
//                T_Damage(other, self, self.owner, 80);
                T_MissileTouch();
                remove(self);
        }

        self.velocity_y = -500 + (random()*1000);
        self.velocity_x = -500 + (random()*1000);

};
/*
================
W_FireRune2Vampire
================
*/
void() W_FireGreenFireball =
{
        local   entity gfire, mpuff, head;
	
//        sound (self, CHAN_WEAPON, "misc/medkey.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

        if (self.rune12clone_count >= 4) {
                UpdatePlayerStatus(self, "You already got a fireball on\nthe loose!\n\n\n\n\n\n\n\n\n\n\n", "", "");
                return;
        }
        self.rune12clone_count = self.rune12clone_count + 1;

        gfire = spawn ();
        gfire.owner = self;
        gfire.movetype = MOVETYPE_FLY;
        gfire.solid = SOLID_BBOX;
        gfire.classname = "green fireball";
		
// set missile speed	

	makevectors (self.v_angle);

//        vampire.avelocity = '300 300 300';

        gfire.velocity = aim(self, 1000);
        gfire.velocity = gfire.velocity * 1000;
        gfire.angles = vectoangles(gfire.velocity);
	
        gfire.touch = GreenFireTouch;

        // when to remove it
        gfire.regen_time = time + 4;  // four seconds

        gfire.think = GreenFireThink;
        gfire.nextthink = time + 0.5;
	
        setmodel (gfire, "progs/w_spike.mdl");
        setsize (gfire, '0 0 0', '0 0 0');
        setorigin (gfire, self.origin + v_forward*8 + '0 0 16');
};
/***END OF THE GREEN FIREBALL***/

/* howl - by inferno (waije@titan.oit.umass.edu)
---------------------------------------------------------------
this is spawned by the werewolf rune, it makes it so all
projectiles that are near him go up, and he regenerates while
doing this too...enemies at a close distance will even go up!
---------------------------------------------------------------
*/

void() HowlThink =
{
        local entity e1;

        if (self.regen_time < time)// || self.firewood.health <= 0)
        {
                if (self.cnt) {
                        self.owner.rune12clone_count = 0;
                        remove(self);
                } else {
                        self.cnt = 1;
                        self.nextthink = time + 4;
                }
                return;
        }
        e1 = findradius(self.origin, 200);
        while (e1) {
                if (e1 != self.owner && ((e1.health && e1.classname == "player") || e1.owner.classname == "player")) {
//                && e1.classname != "door" && e1.classname != "path_corner"
//                && e1.classname != "plat" && e1.classname != "func_button" &&
//                e1.classname != "func_wall" && e1.classname != "trigger_teleport" &&
//                e1.classname != "func_train" && e1.classname != "info_null" && e1.classname != "trigger_once" &&
//                e1.classname != "info_teleport_destination" && e1.classname != "trigger_counter") {
                        if (e1.classname == "player") {
                                if (self.rune_count < time) {
                                        e1.reason_died = "howl noise";
                                        T_Damage(e1, self, self.owner, 7);
                                        e1.reason_died = "";
                                }
                                e1.velocity_z = 600;
                        }
                        if (e1.flags & FL_ONGROUND)
                                e1.flags = e1.flags - FL_ONGROUND;
                        makevectors(e1.v_angle);
                        e1.velocity = v_up*300;
               }
               e1 = e1.chain;
       }
       setorigin(self, self.owner.origin + '0 0 16' + v_up*10);
       self.origin = self.owner.origin + '0 0 16' + v_up*10;
//       particle(self.origin, '0 0 200', 1111, 50);
       self.nextthink = time + 0.1;
       if (self.rune_count < time) {
               sound (self, CHAN_WEAPON, "dog/ddeath.wav", 1, ATTN_NORM);
               self.rune_count = time + 0.6;
       }
       if (self.time_count < time && self.owner.health < 200) {
               self.owner.health = self.owner.health + 1;
               self.time_count = time + 0.1;
       }
};

void() W_Howl =
{
        local   entity howl, mpuff, head; 

	self.punchangle_x = -2;

        if (self.rune12clone_count >= 1) {
                UpdatePlayerStatus(self, "You can't howl because\nyou just did!\n\n\n\n\n\n\n\n\n\n\n", "", "");
                return;
        }

        self.rune12clone_count = 1;

        howl = spawn ();
        howl.owner = self;
        howl.movetype = MOVETYPE_FLY;
        howl.solid = SOLID_BBOX;
        howl.classname = "howl";
		
// set missile speed

	makevectors (self.v_angle);

        howl.velocity = aim(self, 1000);
        howl.velocity = howl.velocity * 0;
        howl.angles = vectoangles(howl.velocity);

//        fanl.avelocity = '600 0 0';

        // now to bring people in the air
        howl.think = HowlThink;
        howl.nextthink = time + 0.1;

        howl.regen_time = time + 4;

        // howl frame
        self.time_count = time + 4;
		
//        setmodel (fanl, "progs/spike.mdl");
//        setsize (fanl, '0 0 0', '0 0 0');
//        setorigin (fanl, self.origin + '0 0 16' + v_up*10);
        howl.origin = self.origin + '0 0 16' + v_up*10;
};        

/***END OF THE TELEPORT-PUNCH***/

/* teleport sektor - by inferno (waije@titan.oit.umass.edu)
---------------------------------------------------------------
spawned by the sektor rune, this is used to teleport the person
and punch the nearest person, the punch doesn't really look real
but the velocities do!
---------------------------------------------------------------
*/

void() W_TeleportSektor =
{
        local entity e1, e2;

        e2 = world;
        e1 = findradius(self.origin, 300);
        while ((e1 != world) && (e2 == world)) {
           if ((e1.classname == "player") && 
           (e1.health > 0) &&  (e1 != self) &&
           (!teamplay || (e1.team != self.team)))
              e2 = e1;
           e1 = e1.chain;
        }

        // now the good part
        if (e2 != world) {
                e1 = spawn();

                e1.classname = "teleport-punch";
                makevectors(e2.v_angle);
                e2.flags = e2.flags - (e2.flags & FL_ONGROUND);
                TeleportEffect(self);
                self.origin = e2.origin + v_forward*-60;
                TeleportEffect(self);
                self.velocity = v_up*500;
                e2.velocity = v_up*500;
                T_Damage(e2, e1, self, 50);
                remove(e1);
        } else self.attack_finished = time + 0.5;
};
/***END OF THE TELEPORT-PUNCH***/

/* raiden move - by inferno (waije@titan.oit.umass.edu)
---------------------------------------------------------------
what else should I call it??  "raiden pusher"??  Well, this makes
raiden fly or do his "superman move" -- spawned by the raiden
rune, also use nitems.qc
---------------------------------------------------------------
*/

void() W_FireRaiden =
{
        self.touch = PlayerTouch;

        // give the person the right flag
        self.inferno_flag = self.inferno_flag | FR_RAIDEN;

        // now give a time when to automatically stop
        if (self.rune_count < time)
                self.rune_count = time + 3;  // stop in 3 seconds
};

// remove the raiden move
void() RemoveRaidenMove =
{
        self.touch = SUB_Null;

        // take away the flag if the person has it
        if (self.inferno_flag & FR_RAIDEN)
                self.inferno_flag = self.inferno_flag - FR_RAIDEN;

        // special effects:  just like in MK
        makevectors(self.v_angle);
        self.velocity = v_forward*-500 + v_up*500;
};
/***END OF THE RAIDEN MOVE***/


/* portal - by inferno (waije@titan.oit.umass.edu)
-------------------------------------------------------------
This is a gateway to a random place on the map, if the person
is lucky, the gateway could open up right ON THE FLAG!!  This
is called by 
-------------------------------------------------------------
*/

void() PortalThink =
{
        local entity e1;

        if (self.regen_time < time) {
                // take away a count
                self.owner.rune12clone_count = self.owner.rune12clone_count - 1;

                remove(self);
                return;
        }
        if (self.cnt) {
                e1 = findradius(self.origin, 50);
                while (e1)
                {
                        if (e1.classname == "player") {
                                TeleportEffect(e1);
                                sound(self, CHAN_WEAPON, "misc/r_tele4.wav", 1, ATTN_NORM);
                                e1.origin = self.inforigin;
                                setorigin(e1, self.inforigin);
                                TeleportEffect(e1);
                                sound(self, CHAN_WEAPON, "misc/r_tele3.wav", 1, ATTN_NORM);
                                e1.velocity_x = e1.velocity_x*2;
                                e1.velocity_y = e1.velocity_y*2;
                                spawn_tdeath(e1.origin, e1);
                                self.nextthink = time + 2;
                                return;
                        }
                        e1 = e1.chain;
                }
                e1 = findradius(self.inforigin, 50);
                while (e1)
                {
                        if (e1.classname == "player") {
                                TeleportEffect(e1);
                                sound(self, CHAN_WEAPON, "misc/r_tele4.wav", 1, ATTN_NORM);
                                e1.origin = self.origin;
                                setorigin(e1, self.origin);
                                TeleportEffect(e1);
                                sound(self, CHAN_WEAPON, "misc/r_tele3.wav", 1, ATTN_NORM);
                                e1.velocity_x = e1.velocity_x*2;
                                e1.velocity_y = e1.velocity_y*2;
                                spawn_tdeath(e1.origin, e1);
                                self.nextthink = time + 2;
                                return;
                        }
                        e1 = e1.chain;
                }
        }
        if (!(self.cnt)) {
                // start out with self.origin;
//                self.inforigin = self.origin;
                // update players
                UpdatePlayerStatus(self.owner, "Portal Activated!\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
                bprint(self.owner.netname);
                bprint(" has opened a portal!\n");
                e1 = SelectRuneSpawnPoint();
                self.inforigin = e1.origin;
                self.cnt = 1;
        }
        particle(self.origin + '0 0 16', '0 0 16', 150, 100);
        particle(self.inforigin + '0 0 16', '0 0 16', 150, 100);
        self.nextthink = time + 0.1;
//        pclose();
};

void()  T_PortalTouch =
{
        local float rand;
        local entity oself, e1;

        // damage the player a little
        if ((other.takedamage) && (other.health > 0) && !(self.cnt)) {
                T_Damage (other, self, self.owner, 20);  // damage them
                particle (other.origin + '0 0 16', '0 0 16', 20, 150);
                // remove 1 at a time
                self.owner.rune12clone_count = self.owner.rune12clone_count - 1;
                remove(self);
                return;
        }
//        if (!(self.cnt)) {
//        }
//        if (other.classname == "player") {
//                TeleportEffect(other);
//                makevectors(other.v_angle);  // push other forward
//                other.origin = self.inforigin + v_forward*200;
//                TeleportEffect(other);
//                spawn_tdeath(other.origin, other);
//                return;
//        }
        self.velocity = '0 0 0';
//        self.touch = T_PortalTouch;
//        self.solid = SOLID_BBOX;
//        self.solid = SOLID_TRIGGER;
};

void() W_FirePortal =
{
        local   entity portal, mpuff, head;
	
	
        if (self.rune12clone_count > 2) {
                UpdatePlayerStatus(self, "You already reached the maximum number\nof portals!\n\n\n\n\n\n\n\n\n\n\n", "", "");
                return;
        }

        // counter goes up
        self.rune12clone_count = self.rune12clone_count + 1;

//        sound (self, CHAN_WEAPON, "weapons/lstart.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

        portal = spawn ();
        portal.owner = self;
        portal.movetype = MOVETYPE_FLY;
        portal.solid = SOLID_BBOX;
        portal.classname = "portal";
        portal.netname = "portal-entrance";
		
// set missile speed

	makevectors (self.v_angle);

        portal.velocity = aim(self, 1000);
        portal.velocity = portal.velocity * 1000;
        portal.angles = vectoangles(portal.velocity);
	
        // when will the portal be removed?
        portal.regen_time = time + 20;  // 20 seconds

        // keep it all colorful
        portal.think = PortalThink;
        portal.nextthink = time + 2;

        portal.touch = T_PortalTouch;
	
        setmodel (portal, "progs/teleport.mdl");
        setsize (portal, VEC_HULL_MIN, VEC_HULL_MAX);
        setorigin (portal, self.origin + v_forward*8 + '0 0 16');
};        

/***END OF THE PORTAL***/

/* multi rockets - by inferno (waije@titan.oit.umass.edu)
-------------------------------------------------------------
I know, I know, this is a bit overboard, but it's the way!
These rockets are spawned by the navy officer, but to make
things fair, it takes about 1 second to load a rocket, and
you can only load a maximum of 20 rockets...
-------------------------------------------------------------
*/

void(float ox) W_FireMulti2Rockets;  // the second step
// this is called through weapons.qc in W_Attack
void() W_FireMultiRockets =
{
        local entity stemp;

        if (self.count_count > 5 || self.owner.health <= 0) {
                remove(self);
                return;
        }

        // store current entity
        stemp = self;
        self = self.owner;

        if (stemp.count_count == 0)
                W_FireMulti2Rockets(0);
        else if (stemp.count_count == 1) {
                W_FireMulti2Rockets(-10);
                W_FireMulti2Rockets(10);
        } else if (stemp.count_count == 2) {
                W_FireMulti2Rockets(-20);
                W_FireMulti2Rockets(20);
        } else if (stemp.count_count == 3) {
                W_FireMulti2Rockets(-30);
                W_FireMulti2Rockets(30);
        } else if (stemp.count_count == 4) {
                W_FireMulti2Rockets(-40);
                W_FireMulti2Rockets(40);
        } else if (stemp.count_count == 5) {
                W_FireMulti2Rockets(-50);
                W_FireMulti2Rockets(50);
        } else if (stemp.count_count == 5) {
                W_FireMulti2Rockets(-60);
                W_FireMulti2Rockets(60);
        }
	
        self = stemp;
        self.count_count = self.count_count + 1;
        self.nextthink = time + 0.2;  // keep the timer going...
};

/*
===============
launch_mrockets

Just a launch_spike that has been changed
===============
*/
void(vector org, vector dir) launch_mrockets =
{
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;

	newmis.angles = vectoangles(dir);
	
        newmis.touch = T_MissileTouch;
        newmis.classname = "multi rockets";
	newmis.think = SUB_Remove;
	newmis.nextthink = time + 6;

        setmodel (newmis, "progs/missile.mdl");
        setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (newmis, org);

        newmis.velocity = dir * 2000;
};

void(float ox) W_FireMulti2Rockets =
{
        local vector dir;
        local entity old;

	makevectors (self.v_angle);
	
        sound (self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);

	dir = aim (self, 1000);
        launch_mrockets (self.origin + '0 0 16' + v_right*ox, dir);

        self.punchangle_x = -2;
};
/***END OF THE MULTI ROCKETS***/

/***END OF THE GREMLIN WEAPON***/

/* gremlin weapon - by inferno (waije@titan.oit.umass.edu)
----------------------------------------------------------------
does nothing much, it comes with the gremlin rune, does a little
bit more damage, and when it hits, the person flies!
----------------------------------------------------------------
*/

//void()  T_GremlinWTouch =
//{
//        if ((other.takedamage) && (other.health > 0)) {
//                T_Damage (other, self, self.owner, 60);
//                self.classname = "bouncer";
//                T_Damage (other, self, self.owner, 2000);
//        }
//        sound (self, CHAN_WEAPON, "weapons/lhit.wav", 1, ATTN_NORM);
//        remove(self);
//};

/*
void() W_FireGremlinW =
{
        local   entity grem, mpuff, head;
	
//        sound (self, CHAN_WEAPON, "weapons/lstart.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

        grem = spawn ();
        grem.owner = self;
        grem.movetype = MOVETYPE_FLY;
        grem.solid = SOLID_BBOX;
        grem.classname = "gremlin weapon";
		
// set missile speed	

	makevectors (self.v_angle);

//        lightb.avelocity = '300 -300 300';

        grem.velocity = aim(self, 1000);
        grem.velocity = grem.velocity * 1500;
        grem.angles = vectoangles(grem.velocity) + '0 0 90';
	
        grem.touch = T_GremlinWTouch;
	
        setmodel (grem, "progs/k_spike.mdl");
        setsize (grem, '0 0 0', '0 0 0');
        setorigin (grem, self.origin + v_forward*8 + '0 0 16');
};
*/
/***END OF THE GREMLIN WEAPON***/

/* bolt - by inferno (waije@titan.oit.umass.edu)
----------------------------------------------------------------
this is what makes zeus' (the rune), lightning bolt work
----------------------------------------------------------------
*/

void() T_LightningBTouch =
{
        local float damg;

        damg = 60;
        if ((other.takedamage) && (other.health > 0) && (other != self) && (other.owner != self))
                T_Damage (other, self, self.owner, damg);
        sound (self, CHAN_WEAPON, "weapons/lhit.wav", 1, ATTN_NORM);
        remove(self);
};

/*
void() W_FireLightningB =
{
        local   entity lightb, mpuff, head;
	
        sound (self, CHAN_WEAPON, "weapons/lstart.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

        lightb = spawn ();
        lightb.owner = self;
        lightb.movetype = MOVETYPE_FLY;
        lightb.solid = SOLID_BBOX;
        lightb.classname = "lightning bolt";
		
// set missile speed	

	makevectors (self.v_angle);

//        lightb.avelocity = '300 -300 300';

        lightb.velocity = aim(self, 1000);
        lightb.velocity = lightb.velocity * 1000;
        lightb.angles = vectoangles(lightb.velocity) + '0 0 90';
	
        lightb.touch = T_LightningBTouch;
	
        setmodel (lightb, "progs/bolt3.mdl");
        setsize (lightb, '0 0 0', '0 0 0');
        setorigin (lightb, self.origin + v_forward*8 + '0 0 16');
};        */
/***END OF THE BOLT***/

/* clone - by inferno (waije@titan.oit.umass.edu)
----------------------------------------------------------------
fires a clone when you have the ghosts rune, when someone gets
close it will explode or if someone fires at it
----------------------------------------------------------------
*/

// rain, bubbles for the thunder rune
void() ThunderBTouch =
{
        local entity e;
        particle (self.origin, '0 0 20', 40, 100);
        e = findradius(self.origin, 100);
        while(e) {
                if (e.takedamage && e.health)
                        T_Damage(e, self, self.owner.goalentity, 30);
                e = e.chain;
        }
//        if (other.takedamage && other.health)
//                T_Damage(other, self, self.owner.goalentity, 40);
        sound (self, CHAN_WEAPON, "blob/land1.wav", 1, ATTN_NORM);
	self.origin = self.origin - 8*normalize(self.velocity);

        remove(self);
};

void() CloneDieOut =
{
   local string s1;
   if (self.goalentity.rune12clone_count)
      self.goalentity.rune12clone_count = 
         self.goalentity.rune12clone_count - 1;

   // bprint("clonedieout() count=");
   // s1 = ftos(self.goalentity.rune12clone_count);
   // bprint(s1);
   // bprint("\n");
   
   if (self.rune == RUNE_SUBZERO && 
      (self.firewood.classname == "player")) 
   {
      self.firewood.inferno_flag = 
         self.firewood.inferno_flag - 
         (self.firewood.inferno_flag & ABLE_KEY2_FLAG);
   }
   BecomeExplosion();
};

void() RuneFrozenClone =
{
        local string s1;
        local vector velotica;

        velotica = '0 0 16';
        if (self.count_count < time || self.firewood.health <= 0) {
                self.firewood.inferno_flag = 
                  self.firewood.inferno_flag - 
                  (self.firewood.inferno_flag & ABLE_KEY2_FLAG);
                WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
                WriteByte (MSG_BROADCAST, TE_EXPLOSION);
                WriteCoord (MSG_BROADCAST, self.origin_x);
                WriteCoord (MSG_BROADCAST, self.origin_y);
                WriteCoord (MSG_BROADCAST, self.origin_z);
                BecomeExplosion ();
                return;
        }
        // freeze count
        if (self.regen_time <= time) {
                local entity attacker;
                attacker = find(world, classname, "player");
                particle (self.firewood.origin + velotica * 0.01 + v_right*22, velotica, 40, 200);
                particle (self.firewood.origin + velotica * 0.01 + v_right*-22, velotica, 40, 200);
                particle (self.firewood.origin + velotica * 0.01 + v_forward*-22, velotica, 40, 200);
                particle (self.firewood.origin + velotica * 0.01 + v_forward*22, velotica, 40, 200);
                sound(self.firewood, CHAN_WEAPON, "misc/power.wav", 1, ATTN_NORM); //sound
                s1 = ftos(self.rune_count);
                UpdatePlayerStatus(self.firewood, attacker.netname, " has frozen you!","\n\n\n\n\n\n\n\n\n\n\n\n");
                self.rune_count = self.rune_count - 1;
                self.regen_time = time + 1;

                // make sure the PERSON HAS IT ON!!!
                if (!(self.firewood.inferno_flag & ABLE_KEY2_FLAG))
                        self.firewood.inferno_flag = self.firewood.inferno_flag | ABLE_KEY2_FLAG;
        }
        // look like ice is stuck onto the targ for effects sake
        particle (self.firewood.origin + velotica, '0 0 0', 40, 200);

        // keep the target's frame
        self.firewood.frame = self.targframe;

        // now update think
        self.nextthink = time + 0.1;
};

void() CloneExplode =
{
   local string s1;
        if (self.rune == RUNE_SUBZERO && 
        (self.firewood.classname == "player")) {

             // the clone will go away after freezing
             if (self.goalentity.rune12clone_count)
                self.goalentity.rune12clone_count = 
                   self.goalentity.rune12clone_count - 1;
             // bprint("cloneexplode() subzero count=");
             // s1 = ftos(self.goalentity.rune12clone_count);
             // bprint(s1);
             // bprint("\n");

             // freeze the owner has the sub-zero rune and second-power
             self.count_count = time + 5;
             self.rune_count = 5;  // 5 seconds till unfreeze
             self.regen_time = time + 0.1;  // when to update time-freeze message
             // this will explode the clone when it expires
             self.think = RuneFrozenClone;
             self.nextthink = time + 0.1;

             // keep the person in a freeze frame
             self.targframe = self.firewood.frame;

             self.firewood.inferno_flag = self.firewood.inferno_flag | ABLE_KEY2_FLAG;  // freeze flag

             // damage them for coldness
             T_Damage(self.firewood,self,self.goalentity,35);
             return;
        }

        // all but the subzero damages when it explodes
        if (self.goalentity.rune12clone_count)
           self.goalentity.rune12clone_count = 
           self.goalentity.rune12clone_count - 1;
        // bprint("cloneexplode() NONsubzero count=");
        // s1 = ftos(self.goalentity.rune12clone_count);
        // bprint(s1);
        // bprint("\n");
        T_RadiusDamage (self, self.goalentity, 280, world);

        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
        WriteByte (MSG_BROADCAST, TE_EXPLOSION);
        WriteCoord (MSG_BROADCAST, self.origin_x);
        WriteCoord (MSG_BROADCAST, self.origin_y);
        WriteCoord (MSG_BROADCAST, self.origin_z);
        BecomeExplosion ();
};

void() CloneThink =
{
   local entity head, selected, e;
   local float dist;
   local string ppp;
   local float okToExplode;
   local float okToDie;
   local string s1;

   // think rules
   /*
   Any clone can be killed by enemy fire.
   Ghost and subzero are harmless against the owner, and his team.
   But you can be damaged by your own thunder and nightmare.

   Ghost (Supernatural Set) First Power (Ghost-Weapon): Makes your 
   weapon the only thing visible, But you take 50% more damage!
   Second Power (Clone): Swing your axe to leave a clone where
   you stand. The clone will explode when someone steps within a 
   certain radius. (2 Clones Max)

   Nightmare (Imaginary Set)  First Power (Mind Melt Power): Anyone 
   near you will have their Mind Melted like they just got hit with 
   the Mind gas gun! It will damage them too!  
   Second Power (Clone Person): Swing your axe to leave a clone that 
   fires rockets in whatever direction you are facing. (2 Clones MAX!) 

   Sub Zero (Mortal Kombat Set)  First Power (Freeze): Any weapon you 
   shoot will shoot out a small bubble, Which at random will freeze 
   the enemy.   
   Second Power (Cold Clone): Swing your axe and you will leave a clone
   where you stand! Anyone that comes near it will freeze for a while   
   allowing an easy gib for you! After freezing one enemy, it explodes.

   Thunder (Storm Set)  First Power (Lightning Strike): Your Thunder 
   Bolt is replaced with a  special Lightning Rod that regens cells.  
   Second Power (Rain): Use your axe to launch a clone into the sky. 
   It rains acid rain which damages the enemy.
   */
 
   okToExplode = 0;  // ok to explode due to timeout or target found
   self.firewood = world;   // default is no target found

   // handle the case where the rune was dropped
   if (self.goalentity.rune != RUNE_THUNDER) {
      if (!self.cloneInitialized)
      {
         self.cloneInitialized = 1;
         if (!droptofloor()) 
         {
            centerprint(self.goalentity, "You are too close to the walls!\n");
            BecomeExplosion();
            if (self.goalentity.rune12clone_count)
              self.goalentity.rune12clone_count = 
                  self.goalentity.rune12clone_count - 1;
            return;
         }
      }
   }
   
   if ((self.goalentity.rune != RUNE_NIGHTMARE) &&
      (self.goalentity.rune != RUNE_THUNDER) &&
      (self.goalentity.rune != RUNE_GHOST) && 
      (self.goalentity.rune != RUNE_SUBZERO))
      okToExplode = 1;

   // handle the case where the owner has changed to first power
   else if (!(self.goalentity.status_flag & ITEM_SECOND_RUNE)) 
      okToExplode = 1;

   // handle the case where the clone time is up
   else if (time > self.count_count)
      okToExplode = 1;

   // handle the case where the owner has died
   else if (self.goalentity.health <= 0) 
      okToExplode = 1;
  
   // even if subzero, termination means blow up, not freeze someone
   if (okToExplode)
   {
      if (self.goalentity.rune12clone_count)
        self.goalentity.rune12clone_count = 
         self.goalentity.rune12clone_count - 1;
      // bprint("oktoexplode count=");
      // s1 = ftos(self.goalentity.rune12clone_count);
      // bprint(s1);
      // bprint("\n");
      BecomeExplosion();
      return;
   }

   // handle the case where the 4 second safety timer is running.
   // this is not needed for ghost or subzero if teamplay or 
   // noharm owner?  But nightmare and thunder still needs it.
   if (time < self.count_count2)     // 4 second timer
   {
      if (self.rune == RUNE_NIGHTMARE)
      {
         self.angles = self.goalentity.angles;
         self.v_angle = self.goalentity.v_angle;
      }

      // self.count_count = self.count_count + 0.1;
      self.nextthink = time + 0.2;
      return;
   }

   // only ghost and subzero have proximity fuses
   if ((self.goalentity.rune == RUNE_GHOST) ||
      (self.goalentity.rune == RUNE_SUBZERO))
   {

      dist = 175;
      // returns a chain of ents within the radius
      head = findradius(self.origin, 175);

      while (head)
      {
         if (  (head.health > 0) && (head != self) &&
               // (head != self.goalentity) && 
               (  (head.classname == "player") ||
                  (head.classname == "sniper gun") ||
                  (head.classname == "ghost clone") 
               ) && 
               ((!teamplay || (self.goalentity.team!=head.team)) ||
               (head == self.goalentity))
            ) 
         {
            traceline(self.origin, head.origin, TRUE, self);

            // dont update if the line was blocked
            if (trace_fraction == 1)
            {
               if ( (vlen(head.origin - self.origin) < dist) )
               {
                  selected = head;
                  dist = vlen(head.origin - self.origin);
                  // if (dist < 16)
                  if (dist < 160)
                     okToExplode = 1;
               }
            }     
         }
         head = head.chain;
      }

      if (okToExplode) {
         // s1 = ftos(dist);
         // bprint(s1);
         // bprint("   oktoExplode\n"); 

         self.firewood = selected;
         CloneExplode();  // ghost blows up, subzero freezes
         return;
      }

      // self.count_count = self.count_count + 0.1;
      self.nextthink = time + 0.2;

      // nothing else for ghost or subzero to do in this function
      return;
   }

   // its good to go, and must be nightmare or thunder 
   if (self.attack_finished < time) {
           if (self.rune == RUNE_NIGHTMARE) {
               if (time > self.count_count2) {
                   player_rocket1();
                   W_FireRocket();
                   self.ammo_rockets = 200;
                   self.attack_finished = time + 1.2;
               }
           }

           if (self.rune == RUNE_THUNDER) {
                   makevectors(self.angles);

                   head = spawn();
                   head.solid = SOLID_BBOX;
                   head.touch = ThunderBTouch;
                   head.goalentity = self;
                   head.classname = "thunder-rain";
                   head.movetype = MOVETYPE_FLY;
                   setmodel(head, "progs/s_bubble.spr");
                   setsize(head, '0 0 0', '0 0 0');
                   setorigin(head, self.origin + '0 0 16' + v_up*-48);
                   head.think = SUB_Remove;
                   head.nextthink = time + 5;
                   head.velocity_x = infrandom()*500;
                   head.velocity_y = infrandom()*500;
                   head.velocity_z = -300/*-650*/ + random()*-500;//-800;
           }
   }
   
   // what is this for????
   // if (self.rune != RUNE_NIGHTMARE && self.rune != RUNE_THUNDER)
   //         self.frame = self.goalentity.frame;

   if (self.rune == RUNE_NIGHTMARE)
   {
      self.angles = self.goalentity.angles;
      self.v_angle = self.goalentity.v_angle;
   }

   // self.count_count = self.count_count + 0.1;
   self.nextthink = time + 0.2;
   // the clone spawned normally
};

/*
================
W_FireClone
================
*/
void() W_FireClone =
{
   local   entity rune12clone, mpuff, head;
	
   if (self.rune12clone_count > 1) {// && self.rune == RUNE_NIGHTMARE && (self.status_flag & ITEM_SECOND_RUNE)) {
      centerprint(self, "You already reached the maximum number\nof clones!");
      return;
   }

   // set up our forward vector
	makevectors (self.v_angle);
   
	self.punchangle_x = -2;

   rune12clone = spawn ();
   rune12clone.entityType = CLONE_TYPE;

   // place the clone about 1 ft in front of you
   //rune12clone.origin = self.origin;
	//rune12clone.origin_x = self.origin_x + v_forward_x * 10;
	//rune12clone.origin_y = self.origin_y + v_forward_y * 10;

	rune12clone.solid = SOLID_BBOX;
	rune12clone.movetype = MOVETYPE_BOUNCE;
		
   rune12clone.angles = self.angles;
   // rune12clone.owner = self;
   rune12clone.goalentity = self;

   rune12clone.velocity = aim(self, 10000);
   rune12clone.velocity = rune12clone.velocity * 450;
	setorigin (rune12clone, self.origin + '0 0 32' + v_forward);
   //setorigin (rune12clone, self.origin);
   
   rune12clone.th_die = CloneDieOut;
   rune12clone.classname = "ghost clone";

   // looks exactly the same as its owner
   rune12clone.colormap = self.colormap;
   rune12clone.skin = self.skin;
   rune12clone.count_count = time + 60;

   // count the number of clones that are being used
   self.rune12clone_count = self.rune12clone_count + 1;
		
   // the clone is not solid (hint)
   // rune12clone.solid = SOLID_NOT;

   // all the clones can damage you
   sprint(self, "You have 4 seconds to get away!\n");
   rune12clone.count_count2 = time + 4;

   rune12clone.think = CloneThink;
   // rune12clone.nextthink = time + 4;
   rune12clone.nextthink = time + 0.2;
	
   // rune12clone.takedamage = DAMAGE_AIM;
   rune12clone.takedamage = DAMAGE_YES;
   rune12clone.ammo_rockets = rune12clone.ammo_shells = rune12clone.ammo_cells = rune12clone.ammo_nails = 200;
   rune12clone.health = 200;
   // rune12clone.armortype = 0.5;
   // rune12clone.armorvalue = 250;
   // rune12clone.deadflag = DEAD_NO;

   // rune12clone.solid = SOLID_SLIDEBOX;
   // rune12clone.solid = SOLID_BBOX;

   if (self.rune == RUNE_THUNDER) {
   	rune12clone.origin = self.origin;
   	rune12clone.origin_x = self.origin_x + v_forward_x * 60;
   	rune12clone.origin_y = self.origin_y + v_forward_y * 60;
      rune12clone.velocity_x = 0;
      rune12clone.velocity_y = 0;
      rune12clone.velocity_z = 400;
      rune12clone.nextthink = time + 2;
      rune12clone.movetype = MOVETYPE_FLY;
   }

   setmodel (rune12clone, "progs/player.mdl");
   setsize (rune12clone, VEC_HULL_MIN, VEC_HULL_MAX); // Allowed clones to stick in walls
   // setsize (rune12clone, '-12 -12 -12', '12 12 12'); // Smaller sizes works a little better
   // setorigin (rune12clone, self.origin);

   if ((self.rune == RUNE_SUBZERO && (self.status_flag & ITEM_SECOND_RUNE)) ||
   (self.rune == RUNE_NIGHTMARE && (self.status_flag & ITEM_SECOND_RUNE)) ||
   (self.rune == RUNE_GHOST && (self.status_flag & ITEM_SECOND_RUNE)) ||
   (self.rune == RUNE_THUNDER && (self.status_flag & ITEM_SECOND_RUNE)))
           rune12clone.rune = self.rune;

   // push the owner back if needed (not needed with safe owner enabled)
   // if (self.rune == RUNE_SUBZERO && (self.status_flag & ITEM_SECOND_RUNE))
   //         self.velocity = v_forward*-800 + v_up*800;  // jump back
};
/***END OF THE CLONE MAKER***/

/* vampire - by inferno (waije@titan.oit.umass.edu)
----------------------------------------------------------------
this just does extra damage if it hits, it automatically shoots
out when you have the vampire rune
----------------------------------------------------------------
*/

//void() Rune4VampireTouch =
//{
//        if (other == self.owner)
//                return;

//        if (other.classname != "player")
//                T_Damage(other, self, self.owner, 15);

//        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
//        WriteByte (MSG_BROADCAST, TE_WIZSPIKE);
//	WriteCoord (MSG_BROADCAST, self.origin_x);
//	WriteCoord (MSG_BROADCAST, self.origin_y);
//	WriteCoord (MSG_BROADCAST, self.origin_z);

//        remove(self);
//};
 
/*
================
W_FireRune2Vampire
================
*/
/*
void() W_FireRune4Vampire =
{
//        local vector dir;

        launch_inf("vampire", "progs/w_spike.mdl", Rune4VampireTouch);
        dir = aim(self, 1000);
        launch_spike(self.origin + '0 0 16' + v_forward*8, dir);
        newmis.classname = "vampire";
        newmis.rune = RUNE_ELDER_MAGIC;
        newmis.status_flag = ITEM_SECOND_RUNE;
        setmodel (newmis, "progs/w_spike.mdl");
        setsize (newmis, '0 0 0', '0 0 0');
        newmis.touch = Rune4VampireTouch;
        local   entity vampire, mpuff, head;
	
//        sound (self, CHAN_WEAPON, "misc/medkey.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

        vampire = spawn ();
        vampire.owner = self;
        vampire.movetype = MOVETYPE_FLY;
        vampire.solid = SOLID_BBOX;
        vampire.classname = "vampire";
		
// set missile speed	

	makevectors (self.v_angle);

//        vampire.avelocity = '300 300 300';

        vampire.velocity = aim(self, 1000);
        vampire.velocity = vampire.velocity * 1000;
        vampire.angles = vectoangles(vampire.velocity);
	
        vampire.touch = Rune4VampireTouch;
	
        setmodel (vampire, "progs/w_spike.mdl");
        setsize (vampire, '0 0 0', '0 0 0');
        setorigin (vampire, self.origin + v_forward*8 + '0 0 16');
};*/
/***END OF THE VAMPIRE GUN***/

/* Fire Ball script - by Inferno (waije@titan.oit.umass.edu)
----------------------------------------------------------------------
When the person gets hit with this, their switch places with the owner
of this projectile, when it hits something with no health, the person
just gets transported there
----------------------------------------------------------------------
*/

void() T_Fire_BallTouch =
{
	local float	damg;
        local entity e;
        local vector inforg1, inforg2;

	if (other == self.owner)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

        if ((other.health) && (other.classname == "player")) {
                inforg1 = other.origin;
                inforg2 = self.owner.origin;

// transport and damage other
                T_Damage (other, self, self.owner, 30);
                WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
                WriteByte (MSG_BROADCAST, TE_TELEPORT);
                WriteCoord (MSG_BROADCAST, other.origin_x);
                WriteCoord (MSG_BROADCAST, other.origin_y);
                WriteCoord (MSG_BROADCAST, other.origin_z);

                other.origin = inforg2;
//                other.fixangle = 1;

                WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
                WriteByte (MSG_BROADCAST, TE_TELEPORT);
                WriteCoord (MSG_BROADCAST, other.origin_x);
                WriteCoord (MSG_BROADCAST, other.origin_y);
                WriteCoord (MSG_BROADCAST, other.origin_z);
                sound(other, CHAN_WEAPON, "misc/r_tele3.wav", 1, ATTN_NORM);

                spawn_tdeath(inforg2, other);

        } else inforg1 = self.origin + self.owner.mins + self.owner.maxs;// + VEC_HULL_MIN + VEC_HULL_MAX;


// now transport self.owner
        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
        WriteByte (MSG_BROADCAST, TE_TELEPORT);
        WriteCoord (MSG_BROADCAST, self.owner.origin_x);
        WriteCoord (MSG_BROADCAST, self.owner.origin_y);
        WriteCoord (MSG_BROADCAST, self.owner.origin_z);

        self.owner.origin = inforg1;
//        setorigin(self, inforg1);

        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
        WriteByte (MSG_BROADCAST, TE_TELEPORT);
        WriteCoord (MSG_BROADCAST, self.owner.origin_x);
        WriteCoord (MSG_BROADCAST, self.owner.origin_y);
        WriteCoord (MSG_BROADCAST, self.owner.origin_z);
        sound(self.owner, CHAN_WEAPON, "misc/r_tele3.wav", 1, ATTN_NORM);

        spawn_tdeath(inforg1, self.owner);

        sound (self, CHAN_WEAPON, "blob/land1.wav", 1, ATTN_NORM);
	self.origin = self.origin - 8*normalize(self.velocity);

        remove(self);

//        BecomeExplosion ();
};

/*
=================
W_FireFire_Ball
=================
*/
void() W_FireFire_Ball =
{
        local   entity fireball, mpuff;

        sound (self, CHAN_WEAPON, "blob/sight1.wav", 1, ATTN_NORM);//"weapons/waije.wav", 1, ATTN_NORM);//"shambler/sboom.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

        fireball = spawn ();
        fireball.owner = self;
        fireball.movetype = MOVETYPE_FLYMISSILE;
        fireball.solid = SOLID_BBOX;
        fireball.classname = "fire ball";
		
// set missile speed	

	makevectors (self.v_angle);
        fireball.velocity = aim(self, 1000);
        fireball.velocity = fireball.velocity * 500;
        fireball.angles = vectoangles(fireball.velocity);
        fireball.angles = fireball.angles + '-90 0 0';
	
        fireball.touch = T_Fire_BallTouch;
	
// set missile duration
        setmodel (fireball, "progs/flame.mdl");
//        setsize (fireball, '0 0 0', '0 0 0');
        setsize (fireball, VEC_HULL_MIN, VEC_HULL_MAX);
        setorigin (fireball, self.origin + v_forward*8 + '0 0 16');
};
/***END OF THE FIRE BALL***/

/* Bubbler script - by Inferno (waije@titan.oit.umass.edu)
---------------------------------------------------------------------
This is activated when you have the liquid rune, this will just then
shoot bubbles along with the kind of ammo your firing....
---------------------------------------------------------------------
*/

//void() BOffGround={self.flags=self.flags - (self.flags&FL_ONGROUND);self.nextthink=time + 0.1;};
void() T_BubblerTouch =
{
	local float	damg;
        local entity e;
        local vector velotica;

	if (other == self.owner)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

//        other = self.owner;
//        other = self.owner;
        if (other.health) {
                T_Damage (other, self, self.owner, 45);
                if (other.classname == "player") {
                        if (!(teamplay) || (other.team != self.owner.team)) {
                                other.inferno_flag = other.inferno_flag | ABLE_KEY5_FLAG;
                                other.key5_flag_count = time + 20;
                                centerprint(other, "You have been liquidized for 20 seconds");
                                other.movetype = MOVETYPE_FLY;
                                other.flags = other.flags | FL_FLY;
                                other.waterlevel = 2;
                                other.watertype = CONTENT_WATER;
                        }
                }
        }


        if(self.rune_power==RUNE_LIQUID)T_RadiusDamage(self,self.owner,300,world);

        velotica = '0 0 150';
        particle (self.origin + velotica * 0.01, velotica, 40, 5);
        velotica = '0 0 100';
        particle (self.origin + velotica * 0.01, velotica, 40, 5);
        sound (self, CHAN_WEAPON, "blob/land1.wav", 1, ATTN_NORM);
	self.origin = self.origin - 8*normalize(self.velocity);
        remove(self);

//        BecomeExplosion ();
};

/*
=================
W_FireBubbler
=================
*/
void() W_FireBubbler =
{
        local   entity bubbler, mpuff;

        sound (self, CHAN_WEAPON, "player/inlava.wav", 1, ATTN_NORM);//"weapons/waije.wav", 1, ATTN_NORM);//"shambler/sboom.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

        bubbler = spawn ();
        bubbler.owner = self;
        bubbler.movetype = MOVETYPE_FLY;
        bubbler.solid = SOLID_BBOX;
        bubbler.classname = "bubbler";
		
// set missile speed	

	makevectors (self.v_angle);
        bubbler.velocity = aim(self, 1000);
        bubbler.velocity = bubbler.velocity * 850;
        bubbler.angles = vectoangles(bubbler.velocity);
	
        bubbler.touch = T_BubblerTouch;

        if(self.nweapon==NEW_RP)bubbler.rune_power=RUNE_LIQUID;
	
// set missile duration
        setmodel (bubbler, "progs/s_bubble.spr");
        setsize (bubbler, '0 0 0', '0 0 0');
        setorigin (bubbler, self.origin + v_forward*8 + '0 0 16');
};
/***END OF THE BUBBLER***/

/* Fragmentation script -- by Inferno (waije@titan.oit.umass.edu)
----------------------------------------------------------------------
Very interesting, a missile goes up then spits out missiles who then
fly everywhere like crazy!
----------------------------------------------------------------------
*/
/* void() FragSplit =
{
        local entity head;
        local float f1, f2;

        if(self.classname=="fragm2"){f1=self.velocity_x*-1 + random()*800;
        f2=self.velocity_y*-1 + random()*800;}else{f1=self.velocity_x*-1 + random()*800;f2=self.velocity_y*-1 + random()*800;}
        if(f1==0)f1=random()*100 + 500;if(f2==0)f2=random()*100 + 500;

        head=spawn();head.owner=self.owner;head.movetype=MOVETYPE_FLY;
        head.solid=SOLID_BBOX;head.touch=T_MissileTouch;if(self.classname!="fragm2")head.velocity_z=-300 + random()*-500;
        head.velocity_x=f1;head.velocity_y=f2;
        setmodel(head,"progs/missile.mdl");setsize(head,'0 0 0', '0 0 0');
        makevectors(self.angles);if(self.classname=="fragm2")setorigin(head,self.origin + v_forward*-22 + v_right*(infrandom()*40));
        else setorigin(head,self.origin + v_up*-44);head.angles=vectoangles(head.velocity);
        head.classname=self.classname;
};

void()T_FragmTouch = {
        if (self.classname == "fragm2") {
                // take four of them to blow the enemy below
                FragSplit();
                FragSplit();
                FragSplit();
                FragSplit();
                FragSplit();
                FragSplit();
                sound(self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);
                self.owner.rune12clone_count = self.owner.rune12clone_count - 1;
                BecomeExplosion();
                return;
        }
        sound(self,CHAN_WEAPON,"weapons/bounce.wav",1,ATTN_NORM);
};

void() T_FragTouch =
{
	local float	damg;
        local entity e;

	if (other == self.owner)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

        if (other.takedamage == DAMAGE_AIM)
                T_Damage(other, self, self.owner, 20);  // do extra damage

        // take four of them to blow the enemy below
        FragSplit();
        FragSplit();
        FragSplit();
        FragSplit();
        FragSplit();
        FragSplit();
        sound(self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);

	self.origin = self.origin - 8*normalize(self.velocity);
        self.owner.rune12clone_count=self.owner.rune12clone_count - 1;
        BecomeExplosion();
//        self.think = FragRemove;
//        self.nextthink
//        remove(self);
};

// make it go upward
void() FragmUp =
{
        local entity fragm;


        fragm = spawn ();
        fragm.owner = self.owner;
        self.movetype = MOVETYPE_NONE;
        self.velocity = '0 0 0';
        setmodel(self, "progs/s_explod.spr");
        sound(self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);
//        s_explode1();
        // now take away

	makevectors (self.v_angle);

        BecomeExplosion();


        fragm.movetype = MOVETYPE_FLYMISSILE;
//        fragm.movetype = MOVETYPE_BOUNCE;
        fragm.solid = SOLID_BBOX;
        fragm.classname = "fragm";
		
// set missile speed	

        fragm.velocity_z = 200;

        fragm.angles = vectoangles(fragm.velocity);
	
        fragm.touch = T_FragTouch;
	
// tell the warnings.
        // warn yourself

// set missile duration
//        fragm.think = FraggtNextStep;
//        fragm.nextthink = time + 0.2;

        setmodel (fragm, "progs/missile.mdl");
        setsize (fragm, '0 0 0', '0 0 0');
        setorigin (fragm, self.origin);
};
*/
/***END OF THE FRAGMENTATION GRENADE***/

/* JetPack script - by Inferno (waije@titan.oit.umass.edu)
---------------------------------------------------------------------
Jet Power!!  Makes you go fast, and when that jetpack hits someone,
they go flying and take some damage
---------------------------------------------------------------------
*/

void() T_JetPackTouch =
{
	local float	damg;
        local entity e;

	if (other == self.owner)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

        if (other.takedamage == DAMAGE_AIM) {
                T_Damage(other, self, self.owner,5000);
                self.classname = "jet pack";
                T_Damage(other, self, self.owner, 30);
        } else
                self.origin = self.origin - 8*normalize(self.velocity);
        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
        WriteByte (MSG_BROADCAST, TE_EXPLOSION);
        WriteCoord (MSG_BROADCAST, self.origin_x);
        WriteCoord (MSG_BROADCAST, self.origin_y);
        WriteCoord (MSG_BROADCAST, self.origin_z);
        self.classname = "bouncer";
        BecomeExplosion();

};

void() JetThink =
{
        local entity e;

        setorigin (self, self.owner.origin + v_forward*25 + '0 0 16');
        self.origin = self.owner.origin + v_forward*25 + '0 0 16';
        self.owner.velocity = self.owner.oldvel;// + self.v_angle;

        e = find(self,classname,"bouncer");
        if (e.owner == self.owner)
                self.count_count = 3;

        if (self.count_count >= 1) {
                if (self.count_count != 3) {
//                        self.owner.velocity = '0 0 0';
                        self.owner.oldvel = '0 0 0';
                }
                WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
                WriteByte (MSG_BROADCAST, TE_EXPLOSION);
                WriteCoord (MSG_BROADCAST, self.origin_x);
                WriteCoord (MSG_BROADCAST, self.origin_y);
                WriteCoord (MSG_BROADCAST, self.origin_z);
                self.classname = "bouncer";
                BecomeExplosion();
                return;
        }
        self.count_count = self.count_count + 0.1;
        self.nextthink = time + 0.1;
};

/*
=================
W_FireJetPack
=================
*/
void() W_FireJetPack =
{
        local   entity jet, mpuff;

        sound (self, CHAN_WEAPON, "items/protect.wav", 1, ATTN_NORM);//"weapons/waije.wav", 1, ATTN_NORM);//"shambler/sboom.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

        jet = spawn ();
        jet.owner = self;
        jet.movetype = MOVETYPE_FLYMISSILE;
        jet.solid = SOLID_BBOX;
        jet.classname = "bouncer";
		
// make sure counter is 0
        jet.count_count = 0;

// set missile speed

	makevectors (self.v_angle);
        jet.velocity = aim(self, 1000);
        jet.velocity = jet.velocity * 1500;
        self.velocity = jet.velocity;
        self.oldvel = self.velocity;
        jet.angles = vectoangles(jet.velocity);
        jet.velocity = '0 0 0';

        jet.think = JetThink;
        jet.nextthink = time + 0.1;
	
        jet.touch = T_JetPackTouch;
	
// set missile duration
        setmodel (jet, "progs/missile.mdl");
        setsize (jet, '0 0 0', '0 0 0');
//        setorigin (jet, self.origin + v_forward*8 + '0 0 16');
        setorigin (jet, self.origin + v_forward*8 + '0 0 16');
};
/***END OF THE JETPACK***/

/* Teleporter script - by Inferno (waije@titan.oit.umass.edu)
---------------------------------------------------------------------
When a person hits this they will get a little damage and will be
transported someplace else so no one can bother the attacker.
---------------------------------------------------------------------
*/

void() T_TeleTouch =
{
	local float	damg;
        local entity e, e2;

	if (other == self.owner)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

//        other=self.owner;
        if (other.health && other.classname == "player") {
                T_Damage (other, self, self.owner, 75);
//                TeleportEffect (other);
                WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
                WriteByte (MSG_BROADCAST, TE_TELEPORT);
                WriteCoord (MSG_BROADCAST, other.origin_x);
                WriteCoord (MSG_BROADCAST, other.origin_y);
                WriteCoord (MSG_BROADCAST, other.origin_z);

                e = SelectRuneSpawnPoint();
                other.origin = e.origin;
//                other.fixangle = 1;

                TeleportEffect(other);  // give the correct effects
                sound(other, CHAN_WEAPON, "misc/r_tele3.wav", 1, ATTN_NORM);

                spawn_tdeath(other.origin, other);
        }


        // with super power, the radius will start to teleport
        if(self.rune_power==RUNE_TELEPORT){
                e2=findradius(self.origin, 400);
                while(e2){
                        if(e2.classname=="player"&&e2!=self.owner&&e2!=self&&CanDamage(self,e2)){
                                e=SelectRuneSpawnPoint();
                                e2.origin=e.origin;
                                TeleportEffect(e2);
                        }
                        e2=e2.chain;
                }
        }

        sound (self, CHAN_WEAPON, "blob/land1.wav", 1, ATTN_NORM);
	self.origin = self.origin - 8*normalize(self.velocity);

        TeleportEffect(self);  // give the correct effects

        remove(self);

//        BecomeExplosion ();
};

/*
=================
W_FireTeleporter
=================
*/
/*
void() W_FireTeleporter =
{
        local   entity tele, mpuff;

        sound (self, CHAN_WEAPON, "blob/sight1.wav", 1, ATTN_NORM);//"weapons/waije.wav", 1, ATTN_NORM);//"shambler/sboom.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

        tele = spawn ();
        tele.owner = self;
        tele.movetype = MOVETYPE_FLYMISSILE;
        tele.solid = SOLID_BBOX;
        tele.classname = "teleporter";
		
// set missile speed	

	makevectors (self.v_angle);
        tele.velocity = aim(self, 1000);
        tele.velocity = tele.velocity * 600;
        tele.angles = vectoangles(tele.velocity);
	
        tele.touch = T_TeleTouch;
	
// set missile duration
        setmodel (tele, "progs/k_spike.mdl");
        setsize (tele, '0 0 0', '0 0 0');
        setorigin (tele, self.origin + v_forward*8 + '0 0 16');
};
*/
/***END OF THE TELEPORTER***/

/* hook - from the ctf hook.qc which came from some other place I don't remember
------------------------------------------------------------------
this thing will be thrown, and when it touches, you will be pulled
toward the object, if it is a player then the player well slowly
die.
------------------------------------------------------------------
*/

/************\
* BreakChain *
\************/

void (entity Head) BreakChain =
{
        local entity link;

        link = Head.goalentity;
        while (link != world)
        {
                Head = link.goalentity;
                remove (link);
                link = Head;
        }
};

/*********\
* LinkPos *
\*********/

void () LinkPos =
{
        makevectors (self.enemy.angles);
        setorigin (self, self.owner.origin + ( ( ( self.enemy.origin + 
                (v_up * 16 * (!self.enemy.button2)) + (v_forward * 16) ) - self.owner.origin ) *
                ( self.weapon ) ) );
        self.nextthink = time + 0.1;
};

/***********\
* MakeChain *
\***********/

entity (entity head, entity tail, float num) MakeChain =
{
        local entity link, prevlink;
        local float linknum;

        linknum = num;
        num = num + 1;
        prevlink = world;
        while (linknum > 0)
        {
                link = spawn();

                link.goalentity = prevlink;
                prevlink = link;

                link.owner = head;
                link.enemy = tail;
                link.weapon = linknum / num;
                link.movetype = MOVETYPE_NOCLIP;
                link.solid = SOLID_NOT;
                link.angles_z = 51 * linknum;
                link.angles_y = 41 * linknum;
                link.angles_x = 31 * linknum;
                link.avelocity = '310 410 510';
				if (teamplay & TEAM_CAPTURE_CUSTOM)
					setmodel (link, "progs/bit.mdl");
				else
					setmodel (link, "progs/s_spike.mdl");
                setsize (link, '0 0 0', '0 0 0');
                makevectors (tail.angles);
                setorigin (link, head.origin + ( ( ( tail.origin 
                        + (v_up * 16 * (!tail.button2)) + ( v_forward * 16 ) ) - head.origin )
                        * ( link.weapon ) ) );
                link.nextthink = time + 0.1;
                link.think = LinkPos;
                linknum = linknum - 1;
        }
        return link;
};


/************\
* HookVanish *
\************/

void () HookVanish =
{
        local entity e;

        self.owner.hook_out = FALSE;
        self.owner.hooker = world;

/*
        if (self.enemy.classname == "player")
                self.enemy.attack_finished = time + 0.1;
*/
		if (teamplay & TEAM_CAPTURE_CUSTOM)
			sound(self.owner, CHAN_WEAPON, "weapons/bounce2.wav", 1, ATTN_NONE);
        BreakChain (self);
        remove (self);
};

/**********\
* HookPull *
\**********/

void () HookPull =
{
   local vector vel, spray, dir, vtemp;
   local float v, dorg;
   local entity e;

   if ((!self.owner.button0&&self.owner.nweapon == NEW_HOOK) ||
           (self.owner.teleport_time > time ) || self.owner.deadflag) {
		HookVanish();
		return;
	} else {
	   if (self.enemy.takedamage) {
			// don't hurt teammates
         if (self.enemy.classname != "player" || !teamplay ||
         self.enemy.lastteam != self.owner.lastteam) {

				// 4.1, if we can't see our enemy, unlock
				if (!CanDamage(self.enemy, self.owner)) {
               dprint(self.netname);
               dprint(" HOOK found active in Hookpull() when !candamage()\n");
					HookVanish();
					return;
				}


				sound (self, CHAN_WEAPON, "blob/land1.wav", 1, ATTN_NORM);
            if (self.enemy.rune != RUNE_TURTLE || (self.enemy.status_flag & ITEM_SECOND_RUNE)) {
            
                  T_Damage (self.enemy, self, self.owner, 1);
            }   
				makevectors (self.v_angle);
				spray_x = 100 * crandom();
				spray_y = 100 * crandom();
				spray_z = 100 * crandom() + 50;
				SpawnBlood (self.origin, spray, 20);
			}
			if (self.enemy.solid == SOLID_SLIDEBOX) {
					self.velocity = '0 0 0';
					setorigin (self, self.enemy.origin +
							self.enemy.mins + (self.enemy.size * 0.5));
			} else {
					self.velocity = self.enemy.velocity;
			}
		} else {
				self.velocity = self.enemy.velocity;
		}
		if (self.enemy.solid == SOLID_NOT) {
				HookVanish();
				return;
		}
      makevectors (self.owner.angles);
      vel = self.origin - ( self.owner.origin + (v_up * 16 *
                      (!self.owner.button2)) + (v_forward * 16));
      v = vlen (vel);
      if (v <= 100)
              vel = normalize(vel) * v * 10;  
      if ( v > 100 ) {
         if ( !(teamplay & SCTF_FAST_HOOK) )
              vel = normalize(vel) * 1000;
         else 
              vel = normalize(vel) * 2000;
      }
		if (teamplay & TEAM_CAPTURE_CUSTOM) {
			dorg = vlen(self.owner.origin - self.dest);
			if (dorg > 10 && self.style == 3) {
				sound(self.owner, CHAN_WEAPON, "weapons/chain2.wav", 1, ATTN_NORM);
				self.style = 2;
			}
			if (dorg < 10 && self.style == 2) {
				sound(self.owner, CHAN_WEAPON, "weapons/chain3.wav", 1, ATTN_NORM);
				self.style = 3;
			}
		}

      if ((self.owner.rune == RUNE_SMOKE && !(self.owner.status_flag & ITEM_SECOND_RUNE)) && self.enemy.classname == "player") {
              vtemp = self.owner.origin;
              dir = normalize(vtemp - self.enemy.origin);
              self.enemy.velocity = dir * 600;
              self.dest = self.enemy.origin;

      } else {
              self.owner.velocity = vel;// * 0.2;
              self.dest = self.owner.origin;
      }
		self.nextthink = time + 0.1;
	}
};

/**************\
* T_ChainTouch *
\**************/

void() T_ChainTouch =
{
	if (other == self.owner)
			return;         // don't attach to owner

	if (pointcontents(self.origin) == CONTENT_SKY) {
                HookVanish();
                return;
	}

	if (other.classname == "player" && teamplay &&
		other.team == self.owner.lastteam)
		return; // just pass through teammates

	if (other.takedamage) {

		// don't damage teammates
		if (other.classname == "player")
			other.axhitme = 1; // make axe noise
		else
			sound (self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
		T_Damage (other, self, self.owner, 10 );
		SpawnBlood (self.origin, self.velocity, 10);
	} else {
		sound (self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
                self.avelocity = '0 0 0';
	}
                
   if (!self.owner.button0) {
			HookVanish();
			return;
	} else {
			if (other.solid == SOLID_SLIDEBOX) {
					setorigin (self, other.origin + other.mins +
							(other.size * 0.5));
					self.velocity = '0 0 0';
			} else {
					self.velocity = other.velocity;
			}
			self.weapon = other.nextthink - time;
			if (teamplay & TEAM_CAPTURE_CUSTOM)
				sound (self.owner, CHAN_WEAPON, "weapons/chain2.wav", 1, ATTN_NORM);

         // we can not let the hook grab onto created entities, unless
         // they have been adapted for hook compatibility. At this time
         // none have.
         if (other.entityType != CLONE_TYPE)
         {
   			self.style = 2;
	   		self.enemy = other;
			   self.nextthink = time + 0.1;
		   	self.think = HookPull;
   			self.touch = SUB_Null;

         }
	}
};

/*************\
* W_FireChain *
\*************/

void(float ox) W_FireChain =
{
   local entity hook;

   self.hook_out = TRUE;
   hook = spawn ();
   self.hooker = hook;
   hook.owner = self;
   hook.movetype = MOVETYPE_FLY;
   hook.solid = SOLID_BBOX;
		
   // set hook speed 

   makevectors (self.v_angle);

   // only done here because of some confusion
   hook.velocity = aim(self, 800);//1000);
   if ( !(teamplay & SCTF_FAST_HOOK) )
      hook.velocity = hook.velocity * 800;
   else 
      hook.velocity = hook.velocity * 2000;

   hook.angles = vectoangles(hook.velocity);
   hook.avelocity = '0 0 -500';
	
   hook.touch = T_ChainTouch;

   if (self.rune == RUNE_SMOKE && !(self.status_flag & ITEM_SECOND_RUNE))
           hook.classname = "harpoon";
   else
           hook.classname = "grapple";
	
   hook.rune_power=12345678;  // can't be effected by change

   // set hook sound
   hook.nextthink = time + 5;
   hook.think = HookVanish;

	if (teamplay & TEAM_CAPTURE_CUSTOM)
		setmodel (hook, "progs/star.mdl");
	else
		setmodel (hook, "progs/v_spike.mdl");


   if (self.rune == RUNE_DISAPEAR && (self.status_flag & ITEM_SECOND_RUNE))
           setmodel (hook, string_null);

   setsize (hook, '0 0 0', '0 0 0');
   setorigin (hook, self.origin + (v_forward*16) + '0 0 16' + v_right*ox);

	if (teamplay & TEAM_CAPTURE_CUSTOM)
		sound (self, CHAN_WEAPON, "weapons/chain1.wav", 1, ATTN_NORM);	
	else
		sound (self, CHAN_WEAPON, "hknight/hit.wav", 1, ATTN_NORM);	

   hook.goalentity = MakeChain (hook, self, 3);

   // if (hook.classname == "blade" || hook.classname == "web")
   //         hook.count_count = time + 10;  // remove in 10 seconds
   // if (hook.classname == "web" || hook.classname == "blood sucker")
   //         hook.velocity = hook.velocity * 2.5;
};
/***END OF HOOK***/


/* PlasmaGun script - by Inferno (waije@titan.oit.umass.edu)
---------------------------------------------------------------------
Pretty cool, does a fair amount of damage and moves the opponent a fair
distance, also has that "plasma" effect, but it's not quite right...
---------------------------------------------------------------------
*/

// for the plasma gun (effects)
void() PlasmaEffects =
{
        local float c;

        c=40;
        if(self.runemodel=="pulsar blaster")
                c=450;
        particle (self.origin, '0 0 0', c, 50);
        self.nextthink = time;
};

void() T_PlasmaTouch =
{
	local float	damg;

	if (other == self.owner)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

        // damg = 120 + random()*20;
        damg = 80 + random()*20;

//        other = self.owner;
	if (other.health)
	{
                T_Damage (other, self, self.owner, damg);
                self.classname = "bouncer";
                T_Damage (other, self, self.owner, 1000);
                self.classname = self.runemodel;
	}

	// don't do radius damage to the other, because all the damage
	// was done in the impact
        T_RadiusDamage (self, self.owner, 175, other);

        sound (self, CHAN_WEAPON, "weapons/lhit.wav", 1, ATTN_NORM);
	self.origin = self.origin - 8*normalize(self.velocity);

        // create the special effects
        particle (self.origin + '0 0 16' + v_forward*30, '0 0 0', 40, 1);
        particle (self.origin + '0 0 16' + v_forward*-30, '0 0 0', 40, 1);
        particle (self.origin + '0 0 16' + v_forward*60, '0 0 0', 40, 1);
        particle (self.origin + '0 0 16' + v_forward*-60, '0 0 0', 40, 1);
        particle (self.origin + '0 0 16' + v_up*30, '0 0 0', 40, 1);
        particle (self.origin + '0 0 16' + v_up*-30, '0 0 0', 40, 1);
        particle (self.origin + '0 0 16' + v_up*60, '0 0 0', 40, 1);
        particle (self.origin + '0 0 16' + v_up*-60, '0 0 0', 40, 1);

	BecomeExplosion ();
};

/*
=================
W_FirePlasma
=================
*/
void() W_FirePlasma =
{
        local   entity plasma, mpuff;

        if (self.nweapon==NEW_PLASMA)
                self.currentammo = self.ammo_rockets = self.ammo_rockets - AMMO_PLASMA;
        W_SetCurrentAmmo();

        sound (self, CHAN_WEAPON, "misc/outwater.wav", 1, ATTN_NORM);//"weapons/waije.wav", 1, ATTN_NORM);//"shambler/sboom.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

        plasma = spawn ();
        plasma.owner = self;
        plasma.movetype = MOVETYPE_FLYMISSILE;
        plasma.solid = SOLID_BBOX;
        plasma.classname = "plasma";

        if(self.rune==RUNE_MIB&&(self.status_flag&ITEM_SECOND_RUNE)&&self.nweapon==NEW_SHOTGUN)
                plasma.classname = "pulsar blaster";

// store the classname
        plasma.runemodel=plasma.classname;
		
// set missile speed	

	makevectors (self.v_angle);
        plasma.velocity = aim(self, 1000);
        plasma.velocity = plasma.velocity * 700;//600;
        plasma.angles = vectoangles(plasma.velocity);
	
        plasma.touch = T_PlasmaTouch;

        plasma.think = PlasmaEffects;
        plasma.nextthink = time;

	
// set missile duration
        setmodel (plasma, "progs/s_bubble.spr");
        setsize (plasma, '0 0 0', '0 0 0');     
        setorigin (plasma, self.origin + v_forward*8 + '0 0 16');

        if ((self.rune == RUNE_DISAPEAR) && (self.status_flag & ITEM_SECOND_RUNE))
                setmodel (plasma, string_null);

        if (self.ammo_rockets < AMMO_PLASMA && self.nweapon == NEW_PLASMA) {
                self.weapon = W_BestWeapon ();
                self.nweapon = W_BestNWeapon(self.weapon);
                W_SetCurrentAmmo ();
                return;
        }
};
/***END OF THE PLASMA GUN***/

/* sniper gun - by inferno (waije@titan.oit.umass.edu)
------------------------------------------------------------------------
Guess what this could do??  It is a sniper gun, you aim at a person, and
fire!!!  This is extremely powerful, enjoy the gib! :)
------------------------------------------------------------------------
*/

void() SniperExplode =
{
//        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
//        WriteByte (MSG_BROADCAST, TE_EXPLOSION);
//        WriteCoord (MSG_BROADCAST, self.origin_x);
//        WriteCoord (MSG_BROADCAST, self.origin_y);
//        WriteCoord (MSG_BROADCAST, self.origin_z);
        setmodel(self, "progs/s_explod.spr");
        self.think = s_explode1;
        self.nextthink = time + 0.25;
};

void() T_SniperTouch =
{
	local float	damg;
        local vector velotica;

        if (other == self.owner)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

        damg = 600 + random()*100;
//        damg = 600 + random()*100;
	
//        other = self.owner;
	if (other.health)
                T_Damage (other, self, self.owner, 1000);

	// don't do radius damage to the other, because all the damage
	// was done in the impact
        T_RadiusDamage (self, self.owner, 15, other);

        sound (self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);
	self.origin = self.origin - 8*normalize(self.velocity);

        velotica = '0 0 150';
        particle (self.origin + velotica * 0.01, velotica, 111, 25);
        velotica = '0 0 120';
        particle (self.origin + velotica * 0.01, velotica, 111, 25);
        velotica = '0 0 -150';
        particle (self.origin + velotica * 0.01, velotica, 111, 25);
        velotica = '0 0 -120';
        particle (self.origin + velotica * 0.01, velotica, 73, 25);
        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
        WriteByte (MSG_BROADCAST, TE_TAREXPLOSION);
        WriteCoord (MSG_BROADCAST, self.origin_x);
        WriteCoord (MSG_BROADCAST, self.origin_y);
        WriteCoord (MSG_BROADCAST, self.origin_z);
        SUB_Remove();
};

/*
===============
W_FireSniper
===============
*/
void() W_FireSniper =
{
        local   entity sniper, mpuff;

        self.ammo_shells = self.ammo_shells - AMMO_SNIPER;
        self.ammo_rockets = self.ammo_rockets - AMMO_SNIPER;
        W_SetCurrentAmmo ();
        
        sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

        sniper = spawn ();
        sniper.owner = self;
        sniper.movetype = MOVETYPE_FLYMISSILE;
        sniper.solid = SOLID_BBOX;
        sniper.classname = "sniper gun";
		
// set missile speed	

	makevectors (self.v_angle);
        sniper.velocity = aim(self, 100);
        sniper.velocity = sniper.velocity * 2000;//600;
        sniper.angles = vectoangles(sniper.velocity);
	
        sniper.touch = T_SniperTouch;
	
// set missile duration
//        sniper.nextthink = time + 5;
//        sniper.think = SUB_Remove;
        sniper.avelocity = '0 0 -500';

//        if (teamplay & TEAM_CUSTOM_SCTF)
//                setmodel (sniper, "progs/bullet.mdl");
//        else
                setmodel (sniper, "progs/k_spike.mdl");

        if ((self.rune == RUNE_DISAPEAR) && (self.status_flag & ITEM_SECOND_RUNE))
                setmodel (sniper, string_null);

        setsize (sniper, '0 0 0', '0 0 0');     
//        local vector src;
//        src = self.origin + v_forward*10;
//        src_z = self.owner.absmin_z + self.size_z * 0.7;
//        traceline(src, src + v_forward*2048, FALSE, self);
//        setorigin (sniper, (0.1*src + 0.9*trace_endpos));//self.origin + '0 0 16');
        setorigin (sniper, self.origin + '0 0 16');

        if (self.ammo_shells < AMMO_SNIPER || self.ammo_rockets < AMMO_SNIPER) {
                self.weapon = W_BestWeapon ();
                self.nweapon = W_BestNWeapon (self.weapon);
                W_SetCurrentAmmo ();
                return;
        }
};
/***END OF THE SNIPER GUN***/

/* FlareGun script - by inferno (waije@titan.oit.umass.edu)
----------------------------------------------------------
when it hits the wall, it will make that corner go bright,
but when it hits someone, they will be bright!
----------------------------------------------------------
*/

void() StartFlaring =
{
   local vector velotica;

   if (self.count_count >= 15) {
           self.count_count = 0;
           remove(self);
           return;
   }

   //special effects
   sound(self, CHAN_WEAPON, "misc/power.wav", 1, ATTN_NORM); //sound

   velotica = '0 0 150';
   particle (self.origin + velotica * 0.01, velotica, 111, 150);
   velotica = '0 0 120';
   particle (self.origin + velotica * 0.01, velotica, 73, 200);

   self.flags = self.flags - (self.flags & FL_ONGROUND);
   self.avelocity = '0 0 -800';
   self.nextthink = time + 1;
   self.count_count = self.count_count + 1;

   // find any enemy in radius and line of sight who
   // we can burn up
   local entity e1;
   e1 = findradius(self.origin, 180);
   while (e1) {
      if ((e1.health) && 
         (e1.entityType == PLAYER_TYPE))
      {
         traceline(self.origin, e1.origin, TRUE, self);
         // other player must be visible
         if (trace_fraction >= 1) {
            if (!e1.eeFlag) {
               BurnSetOnFire (e1, self.goalentity, "flare");
               e1.effects = e1.effects | EF_DIMLIGHT;
            }
         }
      }
      e1 = e1.chain;
    }
};

void() T_FlareTouch =
{
   if (other == self.goalentity)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

   if (other.health) { // all the damage was on impact
           T_Damage (other, self, self.goalentity, 100);//15 );
           remove(self);
           return;
   }
   else {

           //Around the world damage goes! :)
           T_RadiusDamage (self, self.goalentity, 30, other);//30, other);
  
           // tell firewood
           self.firewood = world;
   }
   // bprint("in touch\n");
   if (other.classname == "acid")
   {
      // bprint("other acid \n");
      if (!other.owner.eeFlag)
      {
         if (!other.owner.rune) {
            // bprint("other flag\n");
            startEEManager(other.owner, HOC_EGG);
         }
      }
   }

   if (self.think != StartFlaring)
   {
      // self.solid = SOLID_NOT;
      self.flags = self.flags - (self.flags & FL_ONGROUND);
      self.avelocity = '0 0 -800';
      self.origin = self.origin - 8*normalize(self.velocity);
      self.velocity = '0 0 0';
      self.firewood = world;
      self.think = StartFlaring;
      self.nextthink = time + 4;
      sprint(self.goalentity, "You have 4 seconds to get away from the Flare!\n");
   
   
      WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
      WriteByte (MSG_BROADCAST, TE_EXPLOSION);
   	WriteCoord (MSG_BROADCAST, self.origin_x);
   	 WriteCoord (MSG_BROADCAST, self.origin_y);
   	WriteCoord (MSG_BROADCAST, self.origin_z);
   
      // always end in special effects ;)
      self.effects = EF_BRIGHTLIGHT;
   }
};

/*
=================
W_FireFlare
=================
*/
void() W_FireFlare =
{
   local   entity flare, mpuff;

   self.currentammo = self.ammo_shells = self.ammo_shells - AMMO_FLARE;
   self.currentammo = self.ammo_cells = self.ammo_cells - AMMO_FLARE;
   W_SetCurrentAmmo ();

   sound (self, CHAN_WEAPON, "misc/runekey.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

   flare = spawn ();
   // flare.goalentity = self;
   flare.goalentity = flare.owner = self;
   flare.think = firstThink;
   flare.nextthink = time + 0.1;
   // No more thinks,
   // the touch handles expiration
   flare.secondNextThink = 0;  

   flare.movetype = MOVETYPE_FLYMISSILE;
   flare.solid = SOLID_BBOX;
   flare.classname = "flare";
		
   // set missile speed	

	makevectors (self.v_angle);
   flare.velocity = aim(self, 1000);
   flare.velocity = flare.velocity * 2000;//2000;//600;
   flare.angles = vectoangles(flare.velocity);
	
   flare.touch = T_FlareTouch;  // make sure the people get damage
	
   setmodel (flare, "progs/grenade.mdl");

   if ((self.rune == RUNE_DISAPEAR) && (self.status_flag & ITEM_SECOND_RUNE))
           setmodel (flare, string_null);

   // setsize (flare, '-2 -2 -2', '2 2 2');     
   setsize (flare, '0 0 0', '0 0 0');
   // setorigin (flare, self.origin + v_forward*8 + '0 0 16');
   flare.origin = self.origin;

   if ((self.ammo_shells < AMMO_FLARE) | (self.ammo_cells < AMMO_FLARE)) {
           self.weapon = W_BestWeapon ();
           self.nweapon = W_BestNWeapon(self.weapon);
           W_SetCurrentAmmo ();
           return;
   }
};
/***END OF THE FLAREGUN***/

/* knightspike - by inferno (waije@titan.oit.umass.edu)
-------------------------------------------------------------
we're at it again, aren't we?? :P  This weapon came from id's
hell knight, but this might be a little more powerful.  You
don't have to worry about aiming with this one ;)  but it's
incredibly slow.
-------------------------------------------------------------
*/

// this is called through weapons.qc in W_Attack
void() W_FireMassiveKSpikes =
{
        local entity stemp;

        W_SetCurrentAmmo ();

        if (self.count_count > 4) {
                if (self.owner.ammo_nails < AMMO_KSPIKE) {
                        stemp = self;
                        self = self.owner;
                        self.weapon = W_BestWeapon();
                        self.nweapon = W_BestNWeapon(self.weapon);
                        W_SetCurrentAmmo();
                        self = stemp;
                }
                remove(self);
                return;
        }
        if (self.owner.weapon != IT_SUPER_SHOTGUN || self.owner.nweapon != NEW_KSPIKE) {
                remove(self);
                return;
        }

        // store current entity
        stemp = self;
        self = self.owner;

        if (stemp.count_count == 0)
                W_FireKSpike(0);
        else if (stemp.count_count == 1) {
                W_FireKSpike(-10);
                W_FireKSpike(10);
        } else if (stemp.count_count == 2) {
                W_FireKSpike(-20);
                W_FireKSpike(20);
        } else if (stemp.count_count == 3) {
                W_FireKSpike(-30);
                W_FireKSpike(30);
        } else if (stemp.count_count == 4) {
                W_FireKSpike(-40);
                W_FireKSpike(40);
        }
	
        self = stemp;
        self.count_count = self.count_count + 1;
        self.nextthink = time + 0.2;  // keep the timer going...
};

void() kspike_touch =
{
        
//        sound(self, CHAN_WEAPON, "shambler/sboom.wav", 1, ATTN_NORM);
        if (other == self.owner)
                return;

	if (other.solid == SOLID_TRIGGER)
		return;	// trigger field, do nothing

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	
// hit something that bleeds
	if (other.takedamage)
	{
                spawn_touchblood (12);
                T_Damage (other, self, self.owner, 30);
        } else {
                WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
                WriteByte (MSG_BROADCAST, TE_KNIGHTSPIKE);
                WriteCoord (MSG_BROADCAST, self.origin_x);
                WriteCoord (MSG_BROADCAST, self.origin_y);
                WriteCoord (MSG_BROADCAST, self.origin_z);
        }

// no matter what it hits, disappear
	remove(self);

};

/*
===============
launch_kspike

Just a launch_spike that has been changed
===============
*/
void(vector org, vector dir) launch_kspike =
{
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;

	newmis.angles = vectoangles(dir);
	
        newmis.touch = kspike_touch;
        newmis.classname = "knight spike";
	newmis.think = SUB_Remove;
	newmis.nextthink = time + 6;

        setmodel (newmis, "progs/k_spike.mdl");

        if ((self.rune == RUNE_DISAPEAR) && (self.status_flag & ITEM_SECOND_RUNE))
                setmodel (newmis, string_null);

        setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (newmis, org);

        newmis.velocity = dir * 300;
};

void(float ox) W_FireKSpike =
{
        local vector dir;
        local entity old;

	makevectors (self.v_angle);
	
        sound (self, CHAN_WEAPON, "hknight/attack1.wav", 1, ATTN_NORM);

//        self.currentammo = self.ammo_nails = self.ammo_nails - AMMO_KSPIKE;
        W_SetCurrentAmmo ();

	dir = aim (self, 1000);
        launch_kspike (self.origin + '0 0 16' + v_right*ox, dir);

        self.punchangle_x = -2;
};
/***END OF THE HELL KNIGHT SPIKE***/

/* flamethrower (real flames!!) - by inferno (waije@titan.oit.umass.edu)
----------------------------------------------------------------------
this nailgun is no more a nailgun but a flamethrower.  It will spit
out flames, and when they hit a person, the person will catch on fire.
This is more effective than the other flamethrower, but cost a lot
of nails!
----------------------------------------------------------------------
*/

void (float num_bubbles, vector bub_origin) NewBubbles;  // something that will
// come up

// this is called through weapons.qc in W_Attack
void() W_FireMassiveFlames =
{
        local float rand;
        local entity stemp;

        if (self.count_count >= 22 && ((self.owner.rune != RUNE_TSUNG) || (self.owner.status_flag & ITEM_SECOND_RUNE))) {
                self.owner.inferno_flag = 
                  self.owner.inferno_flag - 
                  (self.owner.inferno_flag & MASSIVE_FLAME_FLAG);
                remove(self);
                return;
        }
        if (self.count_count >= 35 && ((self.owner.rune == RUNE_TSUNG) && !(self.status_flag & ITEM_SECOND_RUNE))) {
                self.owner.inferno_flag = 
                  self.owner.inferno_flag - 
                  (self.owner.inferno_flag & MASSIVE_FLAME_FLAG);
                remove(self);
                return;
        }
        if (((self.owner.rune != RUNE_EARTH_MAGIC) || !(self.owner.status_flag & ITEM_SECOND_RUNE)) &&
        ((self.owner.rune != RUNE_TSUNG) || (self.owner.status_flag & ITEM_SECOND_RUNE))) {
                self.owner.inferno_flag = self.owner.inferno_flag - 
                  (self.owner.inferno_flag & MASSIVE_FLAME_FLAG);
                remove(self);
                return;
        }

        rand = random();  // random targets

        stemp = self;
        self = self.owner;
        if (rand < 0.1)
                W_FireFlame2(-1);
        else if (rand < 0.2)
                W_FireFlame2(1);
        else if (rand < 0.3)
                W_FireFlame2(-14);
        else if (rand < 0.4)
                W_FireFlame2(14);
        else if (rand < 0.5)
                W_FireFlame2(-21);
        else if (rand < 0.6)
                W_FireFlame2(21);
        else if (rand < 0.7)
                W_FireFlame2(-27);
        else if (rand < 0.8)
                W_FireFlame2(27);
        else if (rand < 0.9)
                W_FireFlame2(-33);
        else if (rand < 1)
                W_FireFlame2(33);

        self = stemp;
        self.count_count = self.count_count + 1;
        self.nextthink = time + 0.1;  // keep the timer going...
};

void() flame2_touch =
{
        local float rand, radd;
        local entity firefff, e, burned;
        
        if (other == self.owner)
                return;

        radd = random();
        sound(self, CHAN_WEAPON, "shambler/sboom.wav", 1, ATTN_NORM);

	if (other.solid == SOLID_TRIGGER)
		return;	// trigger field, do nothing

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	
//        other = self.owner;
// hit something that bleeds
        burned=other;
        e = findradius(self.origin, 25);
        while(e) {if (e.classname=="player"&&e==self.owner)burned=self.owner;e=e.chain;}
        if (burned.takedamage)
	{
             //   if (radd < 0.3 && burned.classname=="player") // 30% chance
                if (burned.classname=="player") 
                {
                        // don't let teammates catch onfire
                        if ((!(teamplay) || (self.owner.team != burned.team) || burned==self.owner) && other.waterlevel <= 2) {
                           BurnSetOnFire (burned, self.owner, "fire thrower");
                        }
                }

                spawn_touchblood (10);
                if (self.owner.rune == RUNE_TSUNG)
                        T_Damage (other, self, self.owner, 15);
                else if (self.rune == RUNE_KANG) {
                        T_Damage(other, self, self.owner, 55);
                        if (other.classname=="player") {
                                makevectors(self.angles);
                                other.velocity = self.velocity*2;
                        }
                }
                else if (self.rune_power==RUNE_EARTH_MAGIC)
                        T_Damage (other, self, self.owner, 150);
                else T_Damage (other, self, self.owner, 8);

                // shang tsung rune makes the person "bounce"
                if (self.owner.rune == RUNE_TSUNG) {
                        self.classname = "bouncer";
                        T_Damage (other, self, self.owner, 1000);
                        self.classname = "fire thrower";
                }
	}
// no matter what it hits, end in special effects
//        fireff = spawn();
//        fireff.origin = self.origin;
//        setmodel(fireff, "progs/s_explod.spr");
//        setsize(fireff, '0 0 0', '0 0 0');
//        fireff.velocity = '0 0 0';
//        fireff.think = s_explode1;
//        fireff.nextthink = time + 0.1;
//        fireff.movetype = MOVETYPE_NONE;

        if(self.rune_power==RUNE_EARTH_MAGIC)
                T_RadiusDamage (self, self.owner, 160, world);
        else T_RadiusDamage (self, self.owner, 20, world);

        BecomeExplosion();
//        remove(self);

};

/*      
===============
launch_flame2

Just a launch_spike that has been changed
===============
*/
void(vector org, vector dir) launch_flame2 =
{
	newmis = spawn ();
	newmis.owner = self;
//        if (self.inferno_flag & MASSIVE_FLAME_FLAG)
                newmis.movetype = MOVETYPE_FLYMISSILE;
//        else
//                newmis.movetype = MOVETYPE_BOUNCE;

	newmis.solid = SOLID_BBOX;

	newmis.angles = vectoangles(dir);
	
        newmis.touch = flame2_touch;
        newmis.classname = "fire thrower";
	newmis.think = SUB_Remove;
	newmis.nextthink = time + 6;
        newmis.angles = newmis.angles + '90 0 0';
        if ((
        (self.rune == RUNE_KANG && !(self.status_flag & ITEM_SECOND_RUNE))) && self.nweapon == NEW_AXE)
                newmis.rune = self.rune;

        // check if the model is appropriate
        if (self.waterlevel > 2)
                setmodel (newmis, "progs/s_bubble.spr");
        else
                setmodel (newmis, "progs/flame2.mdl");

        if (self.rune == RUNE_DISAPEAR && (self.status_flag & ITEM_SECOND_RUNE))
                setmodel (newmis, string_null);


        setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);

	setorigin (newmis, org);

        // go up if shang tsung rune is prevailed
//        if ((self.rune == RUNE_TSUNG) && !(self.status_flag & ITEM_SECOND_RUNE))
//                newmis.velocity = dir * 1000 + '0 0 700';
        newmis.velocity = dir * 2000;

};

void(float ox) W_FireFlame2 =
{
        local vector dir, vec1;
        local entity old;

	makevectors (self.v_angle);
	
        sound (self, CHAN_WEAPON, "blob/hit1.wav", 1, ATTN_NORM);
        if (!(self.rune == RUNE_DRAGON)) {
        	if (!(self.inferno_flag & MASSIVE_FLAME_FLAG) && self.nweapon != NEW_AXE) {
                	self.attack_finished = time + 0.2;
                	self.currentammo = self.ammo_nails = self.ammo_nails - AMMO_FIRE;
        	} 
        }
	dir = aim (self, 1000);

        // shang tsung can make flames fly randomly around
//        if ((self.rune == RUNE_TSUNG) && !(self.status_flag & ITEM_SECOND_RUNE)) {
//                ox = ox*10;
//                launch_flame2 (self.origin + '0 0 16' + v_forward*ox, dir);
        launch_flame2 (self.origin + '0 0 16' + v_right*ox, dir);

        self.punchangle_x = -2;
	
        if (self.inferno_flag & MASSIVE_FLAME_FLAG || self.nweapon == NEW_AXE)
                return;

        if (self.ammo_nails < AMMO_FIRE && !(self.rune == RUNE_DRAGON))
        {
		self.weapon = W_BestWeapon ();
                self.nweapon = W_BestNWeapon(self.weapon);
		W_SetCurrentAmmo ();
	}
};
/***END OF THE FLAME THROWER***/

/* Acid script - by Inferno (waije@titan.oit.umass.edu)
----------------------------------------------------------------------
This thing will give damage to a person, it might not be a lot, but it
it sure gives off a new special effect.
---------------------------------------------------------------------
*/

void() AcidStay =
{
   local vector velotica;

   setorigin(self, self.firewood.origin);
   self.origin = self.firewood.origin;
   // double the fun!
   T_Damage(self.firewood, self, self.owner, 8);
   SpawnBlood (self.origin, self.velocity, 10);
   velotica = '0 0 150';
   particle (self.origin + velotica * 0.01, velotica, 55554, 150);
   velotica = '0 0 120';
   particle (self.origin + velotica * 0.01, velotica, 55555, 200);

   if (self.firewood.health <= 0) {
           self.firewood.inferno_flag = self.firewood.inferno_flag - 
             (self.firewood.inferno_flag & ONFIRE_FLAG);
           remove(self);
           return;
   }
   if (self.count_count >= 6) {
      T_Damage(self.firewood, self, self.owner, 10);
		SpawnBlood (self.origin, self.velocity, 10);
      velotica = '0 0 150';
      particle (self.origin + velotica * 0.01, velotica, 55554, 150);
      velotica = '0 0 120';
      particle (self.origin + velotica * 0.01, velotica, 55555, 200);
      self.firewood.inferno_flag = self.firewood.inferno_flag - 
        (self.firewood.inferno_flag & ONFIRE_FLAG);
      remove(self);
      return;
   }
   self.nextthink = time + 0.25;
   self.count_count = self.count_count + 0.25;
};

void() T_AcidTouch =
{
   local float rand;
   local vector velotica;

   rand = random();

   if (other == self.owner)
           return;

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

   // bprint("acid touch, other = "); bprint(other.classname); bprint("\n");

   if (other.health) {
           if ((self.owner.rune == RUNE_REPTILE) && !(self.owner.status_flag & ITEM_SECOND_RUNE))
                   // double the fun!
                   T_Damage (other, self, self.owner, 40);
           else
                   // double the fun!
                   T_Damage (other, self, self.owner, 75);
           if (rand < 0.5 && !(other.inferno_flag & ONFIRE_FLAG)) {
                   other.inferno_flag = other.inferno_flag | ONFIRE_FLAG;
                   self.firewood = other;
                   self.count_count = 0;
                   self.think = AcidStay;
                   self.nextthink = time + 0.01;
                   if (other.classname == "player")
                           UpdatePlayerStatus(self.firewood, "You are burning from acid!\nOuch!\nOuch!\n\n\n\n\n\n\n\n\n\n", "", "");
           }
   } else rand = 1;

   sound (self, CHAN_WEAPON, "wizard/hit.wav", 1, ATTN_NORM);
	self.origin = self.origin - 8*normalize(self.velocity);

   WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
   WriteByte (MSG_BROADCAST, TE_WIZSPIKE);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

   // special effects..(always end in them)

   velotica = '0 0 150';
   particle (self.origin + velotica * 0.01, velotica, 55554, 25);
   velotica = '0 0 120';
   particle (self.origin + velotica * 0.01, velotica, 55555, 50);

   if (rand >= 0.5)
           remove(self);
};

/*
=================
W_FireAcid
=================
*/
void() W_FireAcid =
{
   local   entity acid, mpuff;

   // see if the person has the key3 key
   if ((self.rune != RUNE_REPTILE) || (self.status_flag & ITEM_SECOND_RUNE)) {
           self.currentammo = self.ammo_nails = self.ammo_nails - AMMO_ACID;
           // wizard's attack for the sound
           sound (self, CHAN_WEAPON, "wizard/wattack.wav", 1, ATTN_NORM);//"weapons/waije.wav", 1, ATTN_NORM);//"shambler/sboom.wav", 1, ATTN_NORM);
   }

	self.punchangle_x = -2;

   acid = spawn ();
   acid.owner = self;
   acid.movetype = MOVETYPE_FLYMISSILE;
   acid.solid = SOLID_BBOX;
   acid.classname = "acid";
		
   // set missile speed	

	makevectors (self.v_angle);
   acid.velocity = aim(self, 1000);
   acid.velocity = acid.velocity * 2000; // 800;
   acid.angles = vectoangles(acid.velocity);
	
   acid.touch = T_AcidTouch;
	
   // set missile duration
   setmodel (acid, "progs/w_spike.mdl");

   if ((self.rune == RUNE_DISAPEAR) && (self.status_flag & ITEM_SECOND_RUNE))
           setmodel (acid, string_null);

   setsize (acid, '0 0 0', '0 0 0');     
   setorigin (acid, self.origin + v_forward*8 + '0 0 16');

   if ((self.rune == RUNE_REPTILE) && !(self.status_flag & ITEM_SECOND_RUNE))
           return;  // return if reptile rune

   W_SetCurrentAmmo ();

   if (self.ammo_nails < AMMO_ACID) {
           self.weapon = W_BestWeapon ();
           self.nweapon = W_BestNWeapon(self.weapon);
           W_SetCurrentAmmo ();
           return;
   }
};
/***END OF THE ACIDGUN***/

/* GibGun script - by Inferno (waije@titan.oit.umass.edu)
---------------------------------------------------------------------
This thing sticks to a person and randomly has a timer when it's going
to explode, meanwhile the person is hearting...
---------------------------------------------------------------------
*/

void() GibThink =
{
        self.firewood.axhitme = 1;
        setorigin(self, self.firewood.origin);
        self.origin = self.firewood.origin;
        T_Damage(self.firewood, self, self.owner, 1);
        self.nextthink = time + 0.1;
        if (self.count_count >= 5 || self.firewood.health <= 0) {  // explode after counts hits 6
                self.firewood.inferno_flag = self.firewood.inferno_flag - 
                  (self.firewood.inferno_flag & ONFIRE_FLAG);
                T_MissileTouch();
                return;
        }
        self.count_count = self.count_count + 0.1;
};

void() T_GibTouch =
{
        if (other == self.owner)
                return;

	if (pointcontents(self.origin) == CONTENT_SKY) {
                remove(self);
                return;
	}

        if (other.inferno_flag & ONFIRE_FLAG)
                return;

//        other = self.owner;
        if (other.classname == "player") {
                other.inferno_flag = other.inferno_flag | ONFIRE_FLAG;
                self.firewood = other;
                setorigin(self, other.origin);
                self.origin = other.origin;
                self.think = GibThink;
                self.nextthink = time + 0.1;
        } else {
                sound(self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
                remove(self);
        }
};

void() T_Gib2Touch =
{
	local float	damg;

	if (other == self.owner)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

        other = self.owner;
        if (other.takedamage && self.count_count < 10)
	{
//                if (!(other.inferno_flag & ONFIRE_FLAG)) {
//                        T_Damage (other, self, self.owner, 1);
//                        self.firewood = other;
//                        other.inferno_flag = other.inferno_flag | ONFIRE_FLAG;
//                        self.think = GibThink;
//                        self.nextthink = time + 0.01;
                        setorigin(self, other.origin);// + v_up*10);
                        self.origin = other.origin;// + v_up*10;
                        T_Damage (self.firewood, self, self.owner, 2);
                        SpawnBlood (self.origin, self.velocity, 10);
                        sound (self, CHAN_WEAPON, "blob/land1.wav", 1, ATTN_NORM);
                        self.count_count = self.count_count + 1;
                        return;
//                }
	}

	// don't do radius damage to the other, because all the damage
	// was done in the impact
        T_RadiusDamage (self, self.owner, 120, other);

        sound (self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);
	self.origin = self.origin - 8*normalize(self.velocity);

        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
        WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

	BecomeExplosion ();
};

/*
=================
W_FireGibGun
=================
*/
void() W_FireGibGun =
{
        local   entity gib, mpuff;

        // see if the person has the key3 key
        self.currentammo = self.ammo_rockets = self.ammo_rockets - AMMO_GIBGUN;
        W_SetCurrentAmmo ();

        sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 1, ATTN_NORM);//"weapons/waije.wav", 1, ATTN_NORM);//"shambler/sboom.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

        gib = spawn ();
        gib.owner = self;
        gib.movetype = MOVETYPE_FLYMISSILE;
        gib.solid = SOLID_BBOX;
        gib.classname = "gib gun";
		
// set missile speed	

	makevectors (self.v_angle);
        gib.velocity = aim(self, 1000);
        gib.velocity = gib.velocity * 1000;
        gib.angles = vectoangles(gib.velocity);
	
        gib.touch = T_GibTouch;
	
        gib.avelocity = '0 0 -600';

// set missile duration
        setmodel (gib, "progs/v_spike.mdl");

        if ((self.rune == RUNE_DISAPEAR) && (self.status_flag & ITEM_SECOND_RUNE))
                setmodel (gib, string_null);

        setsize (gib, '0 0 0', '0 0 0');     
        setorigin (gib, self.origin + v_forward*8 + '0 0 16');

        if (self.ammo_rockets < AMMO_GIBGUN) {
                self.weapon = W_BestWeapon ();
                self.nweapon = W_BestNWeapon(self.weapon);
                W_SetCurrentAmmo ();
                return;
        }
};
/***END OF THE GIBGUN***/

/*
============================================================================

Quake Flamethrower 1.0

Another groovy patch from Quake Command - http://www.nuc.net/quake

QC Code By : Steve Bond         wedge@nuc.net

Apologies in advance... I was unable to comment this as well as I'd have
liked to. (I used some weird variable names - hope they don't cause problems.

============================================================================
*/

// Internal declaration
        void (vector fireorg) SpawnTouchFlame;

// Player.qc declaration
        void () DeathBubblesSpawn;



// Slightly varied version of DEATHBUBBLES
void(float num_bubbles, vector bub_origin) NewBubbles =
{
local entity	bubble_spawner;
	
	bubble_spawner = spawn();
        setorigin (bubble_spawner, bub_origin);
	bubble_spawner.movetype = MOVETYPE_NONE;
	bubble_spawner.solid = SOLID_NOT;
	bubble_spawner.nextthink = time + 0.1;

        if (self.classname == "player")
                bubble_spawner.owner = self;
        else
                bubble_spawner.owner = self.firewood;

        bubble_spawner.think = DeathBubblesSpawn;
	bubble_spawner.bubble_count = num_bubbles;
	return;
};


/*
================
SpawnTouchFlame
================
*/

void (vector fireorg) SpawnTouchFlame =
{
        local entity    flame;
        local   float   rn;

        makevectors (self.v_angle);

//        if(random()<0.4||other!=world){
        flame = spawn ();
        flame.owner = self;
        flame.movetype = MOVETYPE_FLYMISSILE;
        flame.velocity = '0 0 75';
        flame.solid = SOLID_NOT;
        flame.classname = "fire";
        flame.origin = fireorg + '0 0 70' + v_forward*16;
        flame.think = s_explode1;
        flame.nextthink = time;
        setmodel (flame, "progs/s_explod.spr");
//        setmodel (flame, "progs/flame2.mdl");
//        flame.frame = 1;
        setsize (flame, '0 0 0', '0 0 0');
//        }
};

/*
================
FlameTouch
================
*/
void () FlameTouch =
{
   local entity e;
   if (self.owner)
      e = self.owner;
   else if (self.goalentity)
      e = self.goalentity;
   else
      e = world;
   if (e == world)
      return world;

   local   float   rn;

   if (other == e)
           return;

   if (other.takedamage)
   {
      rn = random();
      // 30% chance
      if (rn <= 0.3)
      {
         // make sure teammates are safe
         if ((teamplay) && e.team != other.team) {
            BurnSetOnFire (other, e, "");
         }
      }
      else
      {
              SpawnTouchFlame(other.origin);
              T_Damage (other, self, e, 10 );
              remove (self);
      }
   }
   else if (other.classname == "worldspawn")
   {
           self.velocity = '0 0 0';
   }
};

/*
================
W_FireFlame
================
*/
// void() W_FireFlame =
// {
//   local   entity flame;
//   local   float rn;
//
//   if (self.waterlevel > 2)
//   {
//           makevectors (self.v_angle);
//           NewBubbles(2, self.origin+v_forward*64);
//
//           rn = random();
//           if (rn < 0.5)
//                   sound (self, CHAN_WEAPON, "misc/water1.wav", 1, ATTN_NORM);
//           else
//                   sound (self, CHAN_WEAPON, "misc/water2.wav", 1, ATTN_NORM);
//
//           return;
//   }
//
   // Take away a shell
//   if ((self.rune != RUNE_DRAGON) || !(self.status_flag & ITEM_SECOND_RUNE)) {
//           self.currentammo = self.ammo_shells = self.ammo_shells - 1;
//           sound (self, CHAN_WEAPON, "hknight/hit.wav", 1, ATTN_NORM);
//   }

//   flame = spawn ();

   // check for the dragon
//   if ((self.rune == RUNE_DRAGON) && (self.status_flag & ITEM_SECOND_RUNE))
//           flame.rune_count = 1;
//   flame.goalentity = self;
//   flame.movetype = MOVETYPE_FLYMISSILE;
//   flame.solid = SOLID_BBOX;
//   flame.classname = "fire";
		
   // set flame speed    
   
//	makevectors (self.v_angle);

//   flame.velocity = aim(self, 10000);
//   if (flame.rune_count)
//           flame.velocity = flame.velocity * 600;
//   else
//           flame.velocity = flame.velocity * 300;
//
//   flame.touch = FlameTouch;
//	
//   if (flame.rune_count)
//           flame.think = inf_exp1;
//   else
//           flame.think = s_explode1;
//   flame.nextthink = time + 0.15;

//   setmodel (flame, "progs/s_explod.spr");
//
//   if ((self.rune == RUNE_DISAPEAR) && (self.status_flag & ITEM_SECOND_RUNE))
//          setmodel (flame, string_null);

//   setsize (flame, '0 0 0', '0 0 0');            
//   setorigin (flame, self.origin + v_forward * 16 + '0 0 16');
//
//   if (self.ammo_shells < 1) {
//           self.weapon = W_BestWeapon ();
//           self.nweapon = W_BestNWeapon(self.weapon);
//           W_SetCurrentAmmo ();
//           return;
//   }
// };
/***END OF THE FLAMETHROWER***/

/* FreezGun script -- by Inferno (waije@titan.oit.umass.edu)
----------------------------------------------------------------------
When somebody hits this, they freeze for a number of seconds, about
5 seconds...
----------------------------------------------------------------------
*/

void() FreezeThink =
{
        local string e;
        local vector velotica;

        velotica = '0 0 16';
        sound(self, CHAN_WEAPON, "enforcer/sight2.wav", 1, ATTN_NORM); //sound
        if (self.regen_time <= time) {
                e = ftos(self.count_count);
                UpdatePlayerStatus(self.firewood, "You have ", e, " seconds until you\ncan move again...\n\n\n\n\n\n\n\n\n\n\n");
                self.count_count = self.count_count - 1;
                self.regen_time = time + 1;

                //special effects
                particle (self.firewood.origin + velotica * 0.01 + v_right*22, velotica, 40, 200);
                particle (self.firewood.origin + velotica * 0.01 + v_right*-22, velotica, 40, 200);
                particle (self.firewood.origin + velotica * 0.01 + v_forward*-22, velotica, 40, 200);
                particle (self.firewood.origin + velotica * 0.01 + v_forward*22, velotica, 40, 200);
                sound(self, CHAN_WEAPON, "misc/power.wav", 1, ATTN_NORM); //sound

                //MAKE SURE THE PERSON CAN'T MOVE!!
                if (!(self.firewood.inferno_flag & ABLE_KEY2_FLAG))
                        self.firewood.inferno_flag = self.firewood.inferno_flag | ABLE_KEY2_FLAG;

        }
        if (self.firewood.health <= 0 || self.count_count < 1) {
                self.firewood.inferno_flag = self.firewood.inferno_flag - 
                  (self.firewood.inferno_flag & ABLE_KEY2_FLAG);
                remove(self);
                return;
        }
        if (!(self.firewood.inferno_flag & ABLE_KEY2_FLAG)) {
//                self.firewood.effects = self.firewood.effects - EF_BRIGHTFIELD;
                remove(self);
                return;
        }

        // look like ice is stuck onto the targ for effects sake
        particle (self.firewood.origin + velotica, '0 0 0', 40, 200);

        // keep the target's frame
        self.firewood.frame = self.targframe;

        self.nextthink = time + 0.1;
};

void() T_FreezeTouch =
{
        local float rr;  // random command is going to be spawned

        if (other == self.owner)
                return;

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

//        if (!(self.owner.key2_flag & ITEM2_KEY2_FLAG) || (self.owner.status_flag & ITEM_SECOND_RUNE))
                sound(self, CHAN_WEAPON, "shambler/sboom.wav", 1, ATTN_NORM);

        self.origin = self.origin - 8*normalize(self.velocity);

        if ((teamplay) && (other.team == self.owner.team)) {
                BecomeExplosion();
                return;
        }
        if (self.owner.rune == RUNE_SUBZERO && !(self.owner.status_flag & ITEM_SECOND_RUNE))
                rr = random();
        else rr = 0;
//        other = self.owner;
        if (!(other.inferno_flag & ABLE_KEY2_FLAG) && (other.classname == "player") && (rr < 0.5)) {
                local entity ppp;

                ppp = spawn();
                ppp.classname = "freeze";
                ppp.owner = self.owner;
                ppp.firewood = other;
                ppp.think = FreezeThink;
                ppp.nextthink = time + 0.1;
                ppp.count_count = 4;
                ppp.regen_time = time + 1;  // for updating
                other.inferno_flag = other.inferno_flag | ABLE_KEY2_FLAG;
                ppp.origin = other.origin;

                // store the target's frame
                self.targframe = other.frame;
//                other.effects = other.effects | EF_BRIGHTFIELD;
//                UpdatePlayerStatus(self.firewood, "You have ", "5", " seconds until you\ncan move again...\n\n\n\n\n\n\n\n\n\n\n");
                setmodel(ppp, "progs/s_bubble.spr");
                setorigin(ppp, ppp.origin + v_forward*22 + v_up*10);
                ppp.origin = ppp.origin + v_forward*22 + v_up*10;

        }

	BecomeExplosion ();
};

/*
=================
W_FireFreez
=================
*/
void() W_FireFreez =
{
        local   entity freeze, mpuff;

        if (self.rune != RUNE_SUBZERO || (self.status_flag & ITEM_SECOND_RUNE)) {
                self.currentammo = self.ammo_cells = self.ammo_cells - AMMO_FREEZEGUN;
                sound (self, CHAN_WEAPON, "enforcer/enfstop.wav", 1, ATTN_NORM);
                W_SetCurrentAmmo ();
        }

	self.punchangle_x = -2;

        freeze = spawn ();
        freeze.owner = self;
        freeze.movetype = MOVETYPE_FLYMISSILE;
        freeze.solid = SOLID_BBOX;
        freeze.classname = "freeze";
		
// set missile speed	

	makevectors (self.v_angle);
        freeze.velocity = aim(self, 1000);
        freeze.velocity = freeze.velocity * 900;//600;
        freeze.angles = vectoangles(freeze.velocity);
//        freeze.angles = freeze.angles + '90 0 0';
	
        freeze.touch = T_FreezeTouch;
	
// set missile duration
        freeze.nextthink = time + 5;
        freeze.think = SUB_Remove;

        setmodel (freeze, "progs/s_bubble.spr");

        if ((self.rune == RUNE_DISAPEAR) && (self.status_flag & ITEM_SECOND_RUNE))
                setmodel (freeze, string_null);

        setsize (freeze, '0 0 0', '0 0 0');     
        setorigin (freeze, self.origin + v_forward*8 + '0 0 16');

        if (self.ammo_nails < AMMO_FREEZEGUN && ((self.rune != RUNE_SUBZERO) || (self.status_flag & ITEM_SECOND_RUNE))) {
                self.weapon = W_BestWeapon ();
                self.nweapon = W_BestNWeapon(self.weapon);
                W_SetCurrentAmmo ();
                return;
        }
};
/***END OF THE FREEZEGUN***/

/* Mod by Inferno (waije@titan.oit.umass.edu)
--------------------------------------------------------------------
This will shoot out in a sphere model, you and everybody around that
area will have the number of given seconds to get out of there.
--------------------------------------------------------------------
*/

// first, we'll start with the setting-the-timer part
//void() BombSet =
//{
//        local string frutoss;
//        if (self.inferno_flag & SET_BOMB_FLAG) {
//                if (self.impulse <= 0 || self.impulse > 20) {
//                        sprint(self, "The number you've given was illegal.\n");
//                        sprint(self, "Please set the time for the bomb between\n");
//                        sprint(self, "0 and 21.\n");
//                } else {
//                        self.timer_bomb = self.impulse;
//                        frutoss = ftos(self.impulse);
//                        sprint(self, "Done, your bomb will now explode in ");
//                        sprint(self, frutoss);
//                        sprint(self, " seconds\n");
//                }
//                self.inferno_flag = self.inferno_flag - SET_BOMB_FLAG;
//                return;
//        }
//        sprint(self, "Now, you can set your bomb by using the\n");
//        sprint(self, "command impulse <n>, where as <n> = the number\n");
//        sprint(self, "of seconds you want the bomb to explode in.\n");
//        self.inferno_flag = self.inferno_flag | SET_BOMB_FLAG;
//};

/*
void() BombExplode2 =
{
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);
        SUB_Remove();
};

void(float flame) BombExplosion =
{
        if (flame == 1) {
                self.solid = SOLID_NOT;
                self.think = s_explode1;
                self.nextthink = 240;//120;
                setmodel (self, "progs/flame2.mdl");
                setsize (self, '0 0 0', '0 0 0');
                
//                setsize (self, '10000 10000 10000', '10000 10000 10000');
//                self.size = '10000 10000 10000';
//                self.frame = -1;
//                makestatic (self);
        } else if (flame == 0) {
                self.movetype = MOVETYPE_NONE;
                self.velocity = '0 0 0';
                self.touch = SUB_Null;
                setmodel (self, "progs/s_explod.spr");
                self.solid = SOLID_NOT;
        }
};

void() BombExplode =
{
        T_RadiusDamage (self, self.owner, 700, world);

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

        BombExplosion (0);
        BombExplosion (1);
};

void() BombTouch =
{
	if (other == self.owner)
		return;		// don't explode on owner
//        if (other.takedamage == DAMAGE_AIM)
//        {                       
//                BombExplode();
//                return;
//        }
	sound (self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);	// bounce sound
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
};
*/

/*
================
W_FireBomb
================
*/

/*
void() W_FireBomb =
{
        local   entity bomb, mpuff, head;
        local   string frutoss;

        self.currentammo = self.ammo_rockets = self.ammo_rockets - AMMO_BOMB;
        W_SetCurrentAmmo ();
	
	sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

        bomb = spawn ();
        bomb.owner = self;
        bomb.movetype = MOVETYPE_BOUNCE;
        bomb.solid = SOLID_BBOX;
        bomb.classname = "bomb";
		
// set missile speed	

	makevectors (self.v_angle);

	if (self.v_angle_x)
                bomb.velocity = v_forward*600 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
	else
	{
                bomb.velocity = aim(self, 10000);
                bomb.velocity = bomb.velocity * 600;
                bomb.velocity_z = 200;
	}

        bomb.avelocity = '300 300 300';

        bomb.angles = vectoangles(bomb.velocity);
	
        bomb.touch = BombTouch;
	
// tell the warnings.
        // warn yourself
        frutoss = ftos(self.timer_bomb);
        bprint(self.netname);
        bprint(" has unleashed an atomic bomb!!\n");
        // now warn the others
        head = findradius(self.origin, BOMB_RADIUS);
        ncenterprint(self, "YOU HAVE ", frutoss, " SECONDS TO ESCAPE!\n", "", "", "", "");

        while (head) {
                if (head.classname == "player") {
                        if ((teamplay & TEAM_CAPTURE_CUSTOM) || (teamplay & TEAM_CAPTURE_FLAG) && head != self) {
                                if (head.team != self.team) {
                                        ncenterprint(head, "YOU HAVE ", frutoss, " SECONDS TO ESCAPE!\n", "", "", "", "");
                                }
                        } else {
                                ncenterprint(head, "YOU HAVE ", frutoss, " SECONDS TO ESCAPE!\n", "", "", "", "");
                        }
                }
                head = head.chain;
        }

// set missile duration
        bomb.nextthink = time + self.timer_bomb;
        bomb.think = BombExplode;

//        setmodel (flame, "progs/flame2.mdl");
//        setsize (flame, '0 0 0', '0 0 0');
//        setorigin (flame, self.origin);

//        setmodel (bomb, "progs/flame2.mdl");
        setmodel (bomb, "progs/s_light.spr");
        setsize (bomb, '0 0 0', '0 0 0');
        setorigin (bomb, self.origin);

        if (self.ammo_rockets < AMMO_BOMB) {
                self.weapon = W_BestWeapon ();
                self.nweapon = W_BestNWeapon(self.weapon);
                W_SetCurrentAmmo ();
                return;
        }
};
*/
/***END OF THE BOMB***/

void() PipeBombRemove=
{
        self.goalentity.pb=0;
        GrenadeExplode();
};

/*
=================
W_FirePipeBomb
=================
*/
void() W_FirePipeBomb =
{
   local   entity fd, fs, mpuff;

   if(self.pb){
      fs=world;
      fd=find(world,classname,"pipe bomb");
      if (fd != world && fd.goalentity == self)
         fs=fd;
      while(fd){
         if (fd!=world && fd.goalentity == self)
            fs=fd;
         fd=find(fd,classname,"pipe bomb");
      }
      if(fs==world){self.pb=0;return;}
      mpuff=self;
      self=fs;
      GrenadeExplode();
      self=mpuff;
      self.pb=0;
      return;
   }
   if(!self.pb) {
      self.currentammo = self.ammo_rockets = self.ammo_rockets - 1;
      W_SetCurrentAmmo ();
      self.pb=1;
   }

   sound (self, CHAN_WEAPON, "enforcer/enfstop.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

   fd = spawn ();
   fd.goalentity = fd.owner = self;
   // fd.goalentity = self;
   fd.movetype = MOVETYPE_BOUNCE;
   fd.solid = SOLID_BBOX;
   fd.classname = "pipe bomb";

   // fd.think = PipeBombRemove;
   // fd.nextthink = time + 10;
   fd.think = firstThink;
   fd.nextthink = time + 0.5;
   fd.secondThink = PipeBombRemove;
   fd.secondNextThink = 9.5;
		
   // set missile speed	
	makevectors (self.v_angle);
	if (self.v_angle_x)
      fd.velocity = v_forward*600 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
	else
	{
      fd.velocity = aim(self, 10000);
      fd.velocity = fd.velocity * 600;
      fd.velocity_z = 200;
	}
   fd.angles = vectoangles(fd.velocity);
	
   fd.touch = GrenadeTouch;
	
   // set missile duration
   setmodel (fd, "progs/grenade.mdl");
   // setsize (fd, '-2 -2 -2', '2 2 2');
   setsize (fd, '0 0 0', '0 0 0');     
   setorigin (fd, self.origin + v_forward*8 + '0 0 16');

   if (self.rune == RUNE_DISAPEAR && (self.status_flag & ITEM_SECOND_RUNE))
      setmodel (fd, string_null);

   // set the velocity
   fd.inforigin=fd.velocity; 

   if (self.ammo_rockets < 1) {
      self.weapon = W_BestWeapon ();
      self.nweapon = W_BestNWeapon(self.weapon);
      W_SetCurrentAmmo ();
      fd.secondThink=GrenadeExplode;
      fd.secondNextThink=time + 2;
      return;
   }
};


/* MindGas script - by Inferno (waije@titan.oit.umass.edu)
---------------------------------------------------------------------
Shoots a lavaball, this will probably almost kill everyone in a small
room, but it is quite slow...(don't get trapped in a corner using this
weapon!)
---------------------------------------------------------------------
*/

void() MindGasThink =
{
//        local entity e1;
//        e1 = findradius(self.origin, 300);
//        while(e1) {
//                if (e1.classname == "player" && CanDamage(e1, self)) {
//                        T_Damage(e1, self, self.owner, 6);
//                        e1.punchangle_y = random()*180 - 90;
//                        e1.punchangle_z = random()*60 - 30;
//                }
//                e1 = e1.chain;
//        }
        DamageRadius(self, self.owner, world, 300, 6);
        if (self.regen_time < time) {
                remove(self);
                return;
        }
        self.nextthink = time + 0.2;
};

void() T_MindGasTouch =
{
	local float	damg;

	if (other == self.owner)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

        damg = 55 + random()*20;
	
	if (other.health)
		T_Damage (other, self, self.owner, damg );

	// don't do radius damage to the other, because all the damage
	// was done in the impact
//        T_RadiusDamage (self, self.owner, 500, other);

        sound (self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);
	self.origin = self.origin - 8*normalize(self.velocity);

        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
        WriteByte (MSG_BROADCAST, TE_LAVASPLASH);
        WriteCoord (MSG_BROADCAST, self.origin_x);
        WriteCoord (MSG_BROADCAST, self.origin_y);
        WriteCoord (MSG_BROADCAST, self.origin_z);

        self.think = MindGasThink;
        self.nextthink = time + 0.2;  // update the mind gas every 0.2 seconds
        self.regen_time = time + 4;  // remove it in four seconds
        self.solid = SOLID_NOT;

        // some people aren't lucky on the time of the explosion, so they get hurt
        DamageRadius(self, self.owner, world, 300, 40);
/*
        e1 = findradius(self.origin, 300);
        while(e1) {
                if (e1.classname == "player" && CanDamage(e1, self)) {
                        T_Damage(e1, self, self.owner, 40);
                        e1.punchangle_y = random()*180 - 90;
                        e1.punchangle_z = random()*60 - 30;
                }
                e1 = e1.chain;
        }*/
        // stay in one place
        self.velocity = '0 0 0';
        self.touch = SUB_Null;

//        BecomeExplosion ();
};

/*
=================
W_FireMindGas
=================
*/
void() W_FireMindGas =
{
        local   entity mindg, mpuff;

        self.currentammo = self.ammo_rockets = self.ammo_rockets - AMMO_MINDG;
        W_SetCurrentAmmo ();

        sound (self, CHAN_WEAPON, "shambler/sboom.wav", 1, ATTN_NORM);//"weapons/waije.wav", 1, ATTN_NORM);//"shambler/sboom.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

        mindg = spawn ();
        mindg.owner = self;
        mindg.movetype = MOVETYPE_FLYMISSILE;
        mindg.solid = SOLID_BBOX;
        mindg.classname = "mind gas";
		
// set missile speed	

	makevectors (self.v_angle);
        mindg.velocity = aim(self, 1000);
        mindg.velocity = mindg.velocity * 400;//600;
        mindg.angles = vectoangles(mindg.velocity);
	
        mindg.touch = T_MindGasTouch;
	
// set missile duration
        setmodel (mindg, "progs/lavaball.mdl");
        setsize (mindg, '0 0 0', '0 0 0');     
        setorigin (mindg, self.origin + v_forward*8 + '0 0 16');

        if ((self.rune == RUNE_DISAPEAR) && (self.status_flag & ITEM_SECOND_RUNE))
                setmodel (mindg, string_null);

        if (self.ammo_rockets < AMMO_MINDG) {
                self.weapon = W_BestWeapon ();
                self.nweapon = W_BestNWeapon(self.weapon);
                W_SetCurrentAmmo ();
                return;
        }
};
/***END OF THE MIND GAS***/


/* Mod wedge@nuc.net...but modified by Inferno (waije@titan.oit.umass.edu)
--------------------------------------------------------------------
Follows your opponents, it is slow though, the only way you can stop
it is to outrun it.
--------------------------------------------------------------------
*/

/*
=============
W_FireHome
=============
*/

void() HomeThink;
entity() HomeFindTarget;

void() DoggyDie =
{
   sound (self, CHAN_WEAPON, "dog/dpain1.wav", 1, ATTN_NORM);
   if (self.goalentity.clone1 == self)
      self.goalentity.clone1 = world;
   else if (self.goalentity.clone2 == self)
      self.goalentity.clone2 = world;

	BecomeExplosion ();
};



void() W_FireHome =
{
   local   entity home, mpuff;
	
   // don't go overboard
   // we are moving from rune12clone_count to cloneX
   if ((self.rune == RUNE_LIFE && (self.status_flag & ITEM_SECOND_RUNE)) ||
      (self.rune == RUNE_ARTEMIS))
   {
      if ((self.clone1 != world) &&
         (self.clone2 != world)) {
         UpdatePlayerStatus(self, "You already have 2 clones/missiles active!\n\n\n\n\n\n\n\n\n\n\n", "", "");
         return;
      }
   }
   else if (self.rune12clone_count >= 2) {
      if (self.rune == RUNE_ARTEMIS)
         UpdatePlayerStatus(self, "You have reached the maximum number\nof loosed Hounds!\n\n\n\n\n\n\n\n\n\n\n", "", "");
      else 
         UpdatePlayerStatus(self, "You have reached the maximum number\nof heat-seekers!\n\n\n\n\n\n\n\n\n\n\n", "", "");
      return;
   }
   

   home = spawn ();

	self.punchangle_x = -2;
   
   home.rune = self.rune;

   if (self.nweapon==NEW_RP &&
      self.rune==RUNE_HELL_MAGIC &&
      (self.status_flag&ITEM_SECOND_RUNE))
      home.rune_power=RUNE_HELL_MAGIC;

   if ((self.rune == RUNE_LIFE && (self.status_flag & ITEM_SECOND_RUNE)) ||
      (self.rune == RUNE_ARTEMIS))
   {
      if (self.clone1 == world)
         self.clone1 = home;
      else if (self.clone2 == world)
         self.clone2 = home;
      else {
         UpdatePlayerStatus(self, "You have 2 clones/missiles active!\n\n\n\n\n\n\n\n\n\n\n", "", "");
         remove(home);
         return;
      }
   }
   else
      self.rune12clone_count = self.rune12clone_count + 1;

   home.count_count = 0;

   home.movetype = MOVETYPE_FLYMISSILE;
   home.solid = SOLID_BBOX;
   home.touch = T_MissileTouch;
   home.goalentity = self;
   home.owner = self;
   home.nextthink = time + 0.1;
   home.secondNextThink = 0.1;
		
   // set doggy special handling
   if (self.rune == RUNE_ARTEMIS) {
      home.takedamage = 1;
      home.health = 200;
      home.entityType = CLONE_TYPE;
		home.th_die = DoggyDie;
      setmodel (home, "progs/dog.mdl");
      // we shall let the doggys be shootable, but not too big
      setsize(home, '-2 -2 -2', '2 2 2');
      if (!(self.status_flag & ITEM_SECOND_RUNE))  { // must be guard dog
         home.classname = "doggyGuard";
         // a single bark when created
         sound (self, CHAN_WEAPON, "dog/dsight.wav", 1, ATTN_NORM);
         home.think = firstThink;
         home.secondThink = doggy_stand1;
         // when to remove the seeking missile
         home.count_count = time + 120;
      	home.origin = self.origin;
      	home.origin_x = self.origin_x + v_forward_x * 50;
      	home.origin_y = self.origin_y + v_forward_y * 50;
      	makevectors (self.v_angle);
         local vector v;
         v = aim(self, 1000);
         home.angles = vectoangles(v);
         home.velocity = '0 0 0';
      }
      else { // must be attack dog
         home.classname = "doggyAttack";
         sound (self, CHAN_WEAPON, "dog/dattack1.wav", 1, ATTN_NORM);
         home.think = firstThink;
         home.secondThink = doggy_run1;
         // when to remove the seeking missile
         home.count_count = time + 5;  
         // set missile speed	
      	makevectors (self.v_angle);
         home.velocity = aim(self, 1000);
         home.velocity = home.velocity * 500; 
         home.angles = vectoangles(home.velocity);
         setorigin (home, self.origin + v_forward*8 + '0 0 16');
      }
   }
   else {
      local string s1;
      // set missile speed	
      // s1 = vtos(home.size);
      // bprint("1. "); bprint(s1); bprint("\n");
   	makevectors (self.v_angle);
      home.velocity = aim(self, 1000);
      home.velocity = home.velocity * 360; // Launch Speed
      home.angles = vectoangles(home.velocity);
      // s1 = vtos(home.size);
      // bprint("2. "); bprint(s1); bprint("\n");
      sound (self, CHAN_WEAPON, "misc/runekey.wav", 1, ATTN_NORM);
      home.think = firstThink;
      home.secondThink = HomeThink;
      home.nextthink = time + 0.1;
      home.secondNextThink = 0.1;
      // when to remove the seeking missile
      home.count_count = time + 5;  // five seconds
      setorigin (home, self.origin + v_forward*8 + '0 0 16');
      // s1 = vtos(home.size);
      // bprint("3. "); bprint(s1); bprint("\n");
      // if(home.rune_power==RUNE_HELL_MAGIC) { // No longer used - Neo
      //      setmodel(home,"progs/flame2.mdl");
      //      home.angles=home.angles + '90 0 0';
      //      home.classname="homing flame";
      // }
      // else
      // {
         setmodel (home, "progs/missile.mdl");
         if (self.rune == RUNE_LIFE && (self.status_flag & ITEM_SECOND_RUNE)) 
            home.classname = "life missile";
         else
            home.classname = "homing missile";
         // home.angles = vectoangles(home.velocity);
      // }
      // the lesson here is, don't change the size, until after you
      // set the model, cause the model carries its own size.
      setsize(home, '0 0 0', '0 0 0');
      // s1 = vtos(home.size);
      // bprint("4. "); bprint(s1); bprint("\n");

   }
   home.enemy = world;
   // s1 = vtos(home.size);
   // bprint("5. "); bprint(s1); bprint("\n");
};

entity() HomeFindTarget =
{
   local entity e;
   if (self.owner)
      e = self.owner;
   else if (self.goalentity)
      e = self.goalentity;
   else
      e = world;
   if (e == world)
      return world;
   local entity head, selected;
   local float dist;

   dist = 500;
   head = findradius(self.origin, 500);
   selected = world;
   while(head)
   {
      if ( (head.health > 0) && (head != self) && 
         (head != e) && (head.entityType == PLAYER_TYPE))
      {
         if (!teamplay || (head.team != e.team))
         {
            // we must have clear line of sight
            traceline(self.origin,head.origin,TRUE,self);
            if ( (trace_fraction >= 1) && 
               (vlen(head.origin -  self.origin) < dist) )
            {
               // first attempt at limiting the POV to pi/2
               local float cosTheta;
               local vector fwdN;
               local vector targV;
               local vector targN;
            	makevectors (self.angles);
               local string s1;
               fwdN = v_forward;  // its already normalized
               // s1 = vtos(fwdN);
               // bprint("fwdN = "); bprint(s1); bprint("\n");
               targV = head.origin - self.origin;
               targN = normalize(targV);
               // s1 = vtos(targN);
               // bprint("targN = "); bprint(s1); bprint("\n");
               cosTheta = 
                  fwdN_x * targN_x +
                  fwdN_y * targN_y +
                  fwdN_z * targN_z;
               // s1 = ftos(cosTheta);
               // bprint("costheta = "); bprint(s1); bprint("\n");
               if (cosTheta >= 0.5)
               {
                  selected = head;
                  dist = vlen(head.origin - self.origin);
               }
            }
         }
      }  // end while in radius chain
      head = head.chain;
      
   }
   if (selected != world && 
      (e.classname=="player"))
   {
      sprint (e,"Homing --> ");
      if (selected.classname == "player")
           sprint (e,selected.netname);
      else
           sprint (e,selected.classname);
      sprint (e,"\n");
   }
   return selected;
};

void() HomeThink =
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
   local vector dir, vtemp;


   if ( !(self.enemy) || (self.enemy == world) || 
      (self.enemy.classname == "door"))
      self.enemy = HomeFindTarget();

   if (self.enemy != world)
   {

      if (e.rune == RUNE_ARTEMIS)
      {
         if (!(e.status_flag & ITEM_SECOND_RUNE))  { // must be guard dog
            sound (self, CHAN_WEAPON, "dog/dattack1.wav", 1, ATTN_NORM);
            self.think = doggy_run1;
         }
      }
      vtemp = self.enemy.origin + '0 0 10';
      local vector fwdN;
      local vector targV;
      local vector targN, targN2;
      local vector newTarg, newTargN;

      makevectors (self.angles);
      local string s1;

      // handle the case of the guard dog, first detecting the target
      makevectors (self.angles);
      if (self.velocity == '0 0 0') 
         fwdN = v_forward;  // its already normalized
      else
         fwdN = normalize(self.velocity);
      local float cosTheta;

      // s1 = vtos(fwdN);
      // bprint("fwdN = "); bprint(s1); bprint("\n");
      targV = self.enemy.origin - self.origin;
      targN = normalize(targV);

      cosTheta = 
         fwdN_x * targN_x +
         fwdN_y * targN_y +
         fwdN_z * targN_z;
      // s1 = ftos(cosTheta);
      // bprint("cos = "); bprint(s1); // bprint("\n");

      if (cosTheta >= 0.98)
         dir = targN;
      else if (cosTheta >= 0.94) {        // 20
         // newTarg = fwdN + targN;
         newTarg = fwdN + 2 * targN;
         dir = normalize(newTarg);
      }
      else if (cosTheta >= 0.87) {        // 30
         // newTarg = fwdN + targN;
         newTarg = fwdN + 2 * targN;
         dir = normalize(newTarg);
      }
      else if (cosTheta >= 0.77) {        // 40
         // newTarg = 2 * fwdN + targN;
         newTarg = 1 * fwdN + targN;
         dir = normalize(newTarg);
      }
      else if (cosTheta >= 0.64) {        // 50
         // newTarg = 4 * fwdN + targN;
         newTarg = 3 * fwdN + targN;
         dir = normalize(newTarg);
      }
      else if (cosTheta >= 0.50) {     // 60
         // newTarg = 4 * fwdN + targN;
         newTarg = 3 * fwdN + targN;
         dir = normalize(newTarg);
      }
      else
         dir = fwdN;

      // s1 = vtos(targN);
      // bprint("targN = "); bprint(s1); bprint("\n");
      // targN2 = targN * 0.5;
      // newTarg = targN + fwdN;
      // dir = normalize(newTarg);
      // cosTheta = 
      //    dir_x * targN_x +
      //    dir_y * targN_y +
      //    dir_z * targN_z;
      // s1 = ftos(cosTheta);
      // bprint("   new = "); bprint(s1); bprint("\n");

      self.velocity = dir * 360;
      if(self.rune_power==RUNE_HELL_MAGIC)
         self.angles=vectoangles(self.velocity) + '90 0 0';
      else self.angles = vectoangles(self.velocity);
      if (self.enemy.entityType == PLAYER_TYPE) {
         if (e.rune == RUNE_ARTEMIS)
            UpdatePlayerStatus(self.enemy, e.netname, " has a loosed a Hound on you!\n\n\n\n\n\n\n\n\n\n\n\n", "");
         else
            UpdatePlayerStatus(self.enemy, e.netname, " has a missile on you!\n\n\n\n\n\n\n\n\n\n\n\n", "");
      }
   }
   if (self.count_count < time) {
      T_MissileTouch();
      return;
   }

   if (e.rune != RUNE_ARTEMIS)
      self.nextthink = time + 0.2;
};
/***END OF THE HOMING MISSILES***/
/***END OF THE HOMING MISSILES***/

/* LavaGun script - by Inferno (waije@titan.oit.umass.edu)
---------------------------------------------------------------------
Shoots a lavaball, this will probably almost kill everyone in a small
room, but it is quite slow...(don't get trapped in a corner using this
weapon!)
---------------------------------------------------------------------
*/
// float lcount;
void() T_LavaTouch =
{
	local float	damg;

   // bprint("lcount "); local string s1; s1 = ftos(lcount); 
   // lcount = lcount + 1; bprint(s1); bprint("\n");

   if (other == self.owner)
           return;         // don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

   if (other.classname == "rocket")
   {
      if (!other.owner.eeFlag)
      {
         if (!other.owner.rune) {
            startEEManager(other.owner, ANARCHY_EGG);
            // disable the bomb, for the consideration of observers
            remove (self); 
            return;
         }
      }
   }

   if (self.regen_time>time&&other.classname!="player"){// && !(self.cnt)) {
           self.think = T_LavaTouch;
           self.nextthink = time + 0.2;  // update for when to explode
           self.velocity = '0 0 0';
           setsize (self, '-5 -5 -5', '5 5 5');     
           return;
   }

   damg = 500 + random()*20;
	
	if (other.health >= 0)
	{
		if (other.classname == "monster_shambler")
			damg = damg * 0.5;	// mostly immune
		T_Damage (other, self, self.owner, damg );
	}

	// don't do radius damage to the other, because all the damage
	// was done in the impact
   T_RadiusDamage (self, self.owner, 500, other);

   sound (self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);
	self.origin = self.origin - 8*normalize(self.velocity);

   WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
   WriteByte (MSG_BROADCAST, TE_LAVASPLASH);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

	BecomeExplosion ();
};

/*
=================
W_FireLavaball
=================
*/
void() W_FireLavaball =
{
        local   entity lavaball, mpuff;

//        centerprint(self, "Cheap, so removed!");
//        return;
        // see if the person has the key3 key
        if(self.nweapon != NEW_AXE&&self.nweapon!=NEW_RP) {
                self.currentammo = self.ammo_rockets = self.ammo_rockets - AMMO_LAVAGUN;
                W_SetCurrentAmmo ();
        }

        sound (self, CHAN_WEAPON, "shambler/sboom.wav", 1, ATTN_NORM);//"weapons/waije.wav", 1, ATTN_NORM);//"shambler/sboom.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

        lavaball = spawn ();
        lavaball.owner = self;
        lavaball.movetype = MOVETYPE_FLYMISSILE;
        lavaball.solid = SOLID_BBOX;
        lavaball.classname = "lavagun";
		
// set missile speed	

	makevectors (self.v_angle);
        lavaball.velocity = aim(self, 1000);
        lavaball.velocity = lavaball.velocity * 200;//600;
        lavaball.angles = vectoangles(lavaball.velocity);
	
        lavaball.touch = T_LavaTouch;

        lavaball.regen_time = time + 5;  // if hit wall, 6 seconds to escape

        // goes faster because of the spell
        if(self.nweapon==NEW_RP){
                if(self.rune==RUNE_HELL_MAGIC)
                        lavaball.rune_power=RUNE_HELL_MAGIC;
                lavaball.velocity=lavaball.velocity*4;
                lavaball.regen_time=time + 1;
        }

        lavaball.think = T_LavaTouch;
        lavaball.nextthink = time + 20;  // explode in 20 seconds anyway
	
// set missile duration
        setmodel (lavaball, "progs/lavaball.mdl");
        // setsize (lavaball, '-5 -5 -5', '5 5 5');     
        setsize (lavaball, '0 0 0', '0 0 0');     
        setorigin (lavaball, self.origin + v_forward*8 + '0 0 16');

        if (self.rune==RUNE_DISAPEAR&&(self.status_flag&ITEM_SECOND_RUNE))
                setmodel (lavaball, string_null);

        if (self.ammo_rockets < AMMO_LAVAGUN&&self.nweapon != NEW_AXE&&self.nweapon!=NEW_RP) {
                self.weapon = W_BestWeapon ();
// bprint("w_bestweapon = "); local string s1; s1 = ftos(self.weapon);
// bprint(s1); bprint("\n");
                self.nweapon = W_BestNWeapon(self.weapon);
                W_SetCurrentAmmo ();
// bprint("w_bestnweapon = "); s1 = ftos(self.nweapon);
// bprint(s1); bprint("\n");
                return;
        }
};
/***END OF THE LAVAGUN***/

/* LaserGun script -- by Inferno (waije@titan.oit.umass.edu)
----------------------------------------------------------------------
Shoots out lasers, it is best effective when you actually hit someone.
It explodes on anything though, just for effects.
----------------------------------------------------------------------
*/

void() T_LaserTouch =
{
        if (other == self.owner)
                return;

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

	if (other.health)
	{
                if (self.owner.rune == RUNE_FUTURE && (self.owner.status_flag & ITEM_SECOND_RUNE))
                        T_Damage (other, self, self.owner, 25);
                else if(self.rune_power==RUNE_FUTURE)
                        T_Damage(other, self, self.owner, 300);
                else
                        T_Damage (other, self, self.owner, 30);//15 );
        }

        //Around the world damage goes! :)
        if(self.rune_power==RUNE_FUTURE)T_RadiusDamage(self,self.owner,300,world);
        else T_RadiusDamage (self, self.owner, 30, world);//15, other);

        self.origin = self.origin - 8*normalize(self.velocity);

        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
        WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

	BecomeExplosion ();
};

/*
=================
W_FireLaser
=================
*/
void() W_FireLaser =
{
        local   entity laser, mpuff;

        if ((self.rune != RUNE_FUTURE || !(self.status_flag & ITEM_SECOND_RUNE))&&self.nweapon!=NEW_RP) {
                self.currentammo = self.ammo_nails = self.ammo_nails - AMMO_LASER;
                W_SetCurrentAmmo ();
        }

        // Count how many times you shot it
        self.LaserCount = self.LaserCount + 1;

        sound (self, CHAN_WEAPON, "enforcer/enfire.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

        laser = spawn ();
        laser.owner = self;
        laser.movetype = MOVETYPE_FLYMISSILE;
        laser.solid = SOLID_BBOX;
        laser.classname = "laser";
		
// set missile speed	

	makevectors (self.v_angle);
        laser.velocity = aim(self, 1000);
        laser.velocity = laser.velocity * 900;//600;
        laser.angles = vectoangles(laser.velocity);
	
        laser.touch = T_LaserTouch;
	
// set missile duration
        laser.nextthink = time + 5;
        laser.think = SUB_Remove;

        setmodel (laser, "progs/laser.mdl");

        if ((self.rune == RUNE_DISAPEAR) && (self.status_flag & ITEM_SECOND_RUNE))
                setmodel (laser, string_null);

        setsize (laser, '0 0 0', '0 0 0');     
        setorigin (laser, self.origin + v_forward*8 + '0 0 16');

        if(self.nweapon==NEW_RP) laser.rune_power=RUNE_FUTURE;

        if (self.ammo_nails < AMMO_LASER && (self.rune != RUNE_FUTURE || !(self.status_flag & ITEM_SECOND_RUNE))&&self.nweapon!=NEW_RP) {
                self.weapon = W_BestWeapon ();
                self.nweapon = W_BestNWeapon(self.weapon);
                W_SetCurrentAmmo ();
                return;
        }
};
/***END OF THE LASERGUN***/

/* SuperMissile script -- by Inferno (waije@titan.oit.umass.edu),
                     idea by 666*SuN! (sun@imaginet.fr)
----------------------------------------------------------------------
I don't know if this is cheap, 666 sun says it isn't, so I guess I'll
use it!  This fella is so nasty, it flies at super speed, it's sorta
like the real sniper gun!
----------------------------------------------------------------------
*/

/*
=================
W_FireSuperM
=================
*/
void() W_FireSuperM =
{
        local   entity superm, mpuff;

        self.currentammo = self.ammo_cells = self.ammo_cells - 2;
        self.ammo_rockets = self.ammo_rockets - 2;
        W_SetCurrentAmmo ();

        sound (self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

        superm = spawn ();
        superm.owner = self;
        superm.movetype = MOVETYPE_FLYMISSILE;
        superm.solid = SOLID_BBOX;
        superm.classname = "super missile";
		
// set missile speed	

	makevectors (self.v_angle);
        superm.velocity = aim(self, 1000);
        superm.velocity = superm.velocity * 2000;//2000;//600;
        superm.angles = vectoangles(superm.velocity);
	
        superm.touch = T_MissileTouch;
	
// set missile duration
//        superm.nextthink = time + 5;
//        superm.think = SUB_Remove;

        setmodel (superm, "progs/missile.mdl");

        if ((self.rune == RUNE_DISAPEAR) && (self.status_flag & ITEM_SECOND_RUNE))
                setmodel (superm, string_null);

        setsize (superm, '0 0 0', '0 0 0');     
        setorigin (superm, self.origin + v_forward*8 + '0 0 16');

        if (self.ammo_cells < 2 || self.ammo_rockets < 2) {
                self.weapon = W_BestWeapon ();
                self.nweapon = W_BestNWeapon(self.weapon);
                W_SetCurrentAmmo ();
                return;
        }
};
/***END OF THE SUPERM***/

/***********\
Key8ArmorTake
\***********/
float(float gweapon) Key8ArmorTake =
{
        if (gweapon == IT_SUPER_SHOTGUN) {
                if (self.items & IT_ARMOR1)
                        return 20;
                if (self.items & IT_ARMOR2)
                        return 10;
                if (self.items & IT_ARMOR3)
                        return 5;
        }
        if (gweapon == IT_NAILGUN) {
                if (self.items & IT_ARMOR1)
                        return 40;
                if (self.items & IT_ARMOR2)
                        return 30;
                if (self.items & IT_ARMOR3)
                        return 10;
        }
        if (gweapon == IT_SUPER_NAILGUN) {
                if (self.items & IT_ARMOR1)
                        return 60;
                if (self.items & IT_ARMOR2)
                        return 46;
                if (self.items & IT_ARMOR3)
                        return 20;
        }
        if (gweapon == IT_GRENADE_LAUNCHER) {
                if (self.items & IT_ARMOR1)
                        return 90;
                if (self.items & IT_ARMOR2)
                        return 70;
                if (self.items & IT_ARMOR3)
                        return 36;
        }
        if (gweapon == IT_ROCKET_LAUNCHER) {
                if (self.items & IT_ARMOR1)
                        return 140;
                if (self.items & IT_ARMOR2)
                        return 110;
                if (self.items & IT_ARMOR3)
                        return 70;
        }
        if (gweapon == IT_LIGHTNING) {
                if (self.items & IT_ARMOR1)
                        return 220;
                if (self.items & IT_ARMOR2)
                        return 140;
                if (self.items & IT_ARMOR3)
                        return 106;
        }
};

/**********\
Key8ArmorVal
\**********/
float(float gweapon) Key8ArmorVal = {return self.armorvalue - Key8ArmorTake(gweapon);};

/***********\
W_BestNWeapon
\***********/
// a number that is returned so it all works out well
float(float gweapon) W_BestNWeapon =
{
        if (gweapon == IT_AXE) {
                if (self.nweapon != NEW_HOOK)
                        return NEW_AXE;
                else return self.nweapon;
        } else
        if (gweapon == IT_SHOTGUN) {
                if (self.nweapon == NEW_PLASMA) {
                        if (self.ammo_rockets < AMMO_PLASMA)
                                return NEW_SHOTGUN;
                } else if (self.nweapon == NEW_SNIPER) {
                        if (self.ammo_rockets < AMMO_SNIPER || self.ammo_shells < AMMO_SNIPER)
                                return NEW_SHOTGUN;
                } else return NEW_SHOTGUN;
        } else
        if (gweapon == IT_SUPER_SHOTGUN) {
                if (self.nweapon == NEW_FLARE) {
                        if (self.ammo_cells < AMMO_FLARE)
                                return NEW_SUPER_SHOTGUN;
                } else if (self.nweapon == NEW_KSPIKE) {
                        if (self.ammo_nails < AMMO_KSPIKE)
                                return NEW_SUPER_SHOTGUN;
                } else return NEW_SUPER_SHOTGUN;
        } else if (gweapon == IT_NAILGUN) {
                if (self.nweapon == NEW_FLAME) {
                        if (self.ammo_nails < AMMO_FIRE)
                                return NEW_NAIL;
                } else if (self.nweapon == NEW_MINE) {
                        if (self.ammo_rockets < AMMO_MINE)
                                return NEW_NAIL;
                } else return NEW_NAIL;
        } else if (gweapon == IT_SUPER_NAILGUN) {
                if (self.nweapon == NEW_ACID) {
                        if (self.ammo_nails < AMMO_ACID)
                                return NEW_SUPER_NAIL;
                } else return NEW_SUPER_NAIL;
        } else if (gweapon == IT_GRENADE_LAUNCHER) {
                if (self.nweapon == NEW_SHRAPNEL) {
                        if (self.ammo_shells < 1)
                                return NEW_GRENADE;
                } else if (self.nweapon == NEW_PB) {
                        if (self.ammo_nails < 1)
                                return NEW_GRENADE;
                } else return NEW_GRENADE;
        } else if (gweapon == IT_ROCKET_LAUNCHER) {
                if (self.nweapon == NEW_LAVAGUN) {
                        if (self.ammo_rockets < AMMO_LAVAGUN)
                                return NEW_ROCKET;
                } else if (self.nweapon == NEW_MINDG) {
                        if (self.ammo_rockets < AMMO_MINDG)
                                return NEW_ROCKET;
                } else return NEW_ROCKET;
        } else if (gweapon == IT_LIGHTNING) {
                if (self.nweapon == NEW_LASER) {
                        if (self.ammo_nails < AMMO_LASER)
                                return NEW_LIGHTNING;
                } else if (self.nweapon == NEW_SUPERM) {
                        if (self.ammo_cells < 2 || self.ammo_rockets < 2)
                                return NEW_LIGHTNING;
                } else return NEW_LIGHTNING;
        } 
        return self.nweapon;
};

/*******\
InfNotify
\*******/
// notifies the current weapon you have, it is used by weapons.qc
void(string s1) InfNotify =
{
        sprint(self, s1);
        sprint(self, "\n");
};

/**********\
NotifyWeapon
\**********/
// notifies the current weapon you have, it is used by weapons.qc
void() NotifyWeapon =
{
        if (self.weapon == IT_AXE) {
                if (self.nweapon == NEW_AXE)
                        InfNotify("Axe selected.");
                else if (self.nweapon == NEW_HOOK) {
                        // check if the person has Scorpion rune (message is different if TRUE)
                        if (self.rune == RUNE_SMOKE && !(self.status_flag & ITEM_SECOND_RUNE))
                                InfNotify("Harpoon selected.");
                        else
                                InfNotify("Grappling hook selected.");
                }
                else if (self.nweapon == NEW_RP)
                        InfNotify("Rune Super Power selected.");
                else if (self.nweapon == NEW_HGRENADE)
                        InfNotify("Hand grenades selected.");
        }

        if (self.weapon == IT_SHOTGUN) {
                if (self.nweapon == NEW_SHOTGUN)
                        InfNotify("Shotgun selected.");
                else if (self.nweapon == NEW_SNIPER)
                        InfNotify("Sniper gun selected.");
                else if (self.nweapon == NEW_PLASMA)
                        InfNotify("Plasma Gun selected.");
                else if (self.nweapon == NEW_MINE)
                        InfNotify("Proximity mine thrower selected.");
        } else if (self.weapon == IT_SUPER_SHOTGUN) {
                if (self.nweapon == NEW_SUPER_SHOTGUN)
                        InfNotify("Super shotgun selected.");
                else if (self.nweapon == NEW_FLARE)
                        InfNotify("Flaregun selected.");
                else if (self.nweapon == NEW_KSPIKE)
                        InfNotify("Spikegun selected.");
        } else if (self.weapon == IT_NAILGUN) {
                if (self.nweapon == NEW_NAIL) {
                   if (self.rune == RUNE_TARANTULA && !(self.status_flag & ITEM_SECOND_RUNE))
                        InfNotify("Poisonous Darts Selected.");
                   else
                        InfNotify("Nailgun selected.");
                }
                else if (self.nweapon == NEW_FLAME)
                        InfNotify("Fire thrower selected.");
                else if (self.nweapon == NEW_MINES) {
                       if (self.proxiCount == MAX_MINES) {
                               local string tomany;
                               tomany = ftos (MAX_MINES);
                               sprint(self,"You already have ");
                               sprint(self, tomany);
                               sprint(self, " active proxy mines!\n");
                       } else
                               InfNotify("Proximity mine thrower selected.");
                }
        } else if (self.weapon == IT_SUPER_NAILGUN) {
                if (self.nweapon == NEW_SUPER_NAIL)
                        InfNotify("Super nailgun selected.");
                else if (self.nweapon == NEW_ACID)
                        InfNotify("Acid gun selected.");
                else if (self.nweapon == NEW_GIBGUN)
                        InfNotify("Gib gun selected.");
        } else if (self.weapon == IT_GRENADE_LAUNCHER) {
                if (self.nweapon == NEW_GRENADE)
                        InfNotify("Grenade launcher selected.");
                else if (self.nweapon == NEW_SHRAPNEL)
                        InfNotify("Shrapnel Gun Selected.");
                else if (self.nweapon == NEW_PB)
                        InfNotify("Pipe bomb selected.");
        } else if (self.weapon == IT_ROCKET_LAUNCHER) {
                if (self.nweapon == NEW_ROCKET)
                        InfNotify("Rocket launcher selected.");
                else if (self.nweapon == NEW_MINDG)
                        InfNotify("Mind Gas Gun selected.");
                else if (self.nweapon == NEW_LAVAGUN)
                        InfNotify("Lavagun selected.");
        } else if (self.weapon == IT_LIGHTNING) {
                if (self.nweapon == NEW_LIGHTNING)
                        InfNotify("Thunderbolt selected.");
                else if (self.nweapon == NEW_LASER)
                        InfNotify("Laser gun selected.");
                else if (self.nweapon == NEW_SUPERM)
                        InfNotify("Super missile launcher selected.");
        } else if (self.weapon == IT_DOG_LAUNCHER) {
                if (self.nweapon == NEW_DOG)
                        InfNotify("Dog launcher selected.");
                else if (self.nweapon == NEW_CGRENADE)
                        InfNotify("Concussion grenades selected.");
                else if (self.nweapon==NEW_FREEZEGUN)
                        InfNotify("Freezegun selected.");
        }
};


void() firstThink =
{
   // this is just for pipe bombs and proxy mines
   // and flare guns (new_flare).
   // I guess they are
   // small enough to go through skinny walls, so they
   // are initialized to 0 size.  As far as I know, 
   // all of the other firsthink entities are larger
   // than this.
   if (self.size == '0 0 0')
      setsize (self, '-2 -2 -2', '2 2 2');
   self.owner = world;
   // if secondnextthink is not set, it means the  entity
   // has no other thinks pending.
   if (self.secondNextThink > 0) {
      self.think = self.secondThink;
      self.nextthink = time + self.secondNextThink;
   }
};

