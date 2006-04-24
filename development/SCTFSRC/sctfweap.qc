void() GrenadeExplode;
void(entity e, float eeflag) startEEManager;

/*************************************************************************\
*
* W_FireMine ()
* proximity mine - by Neophyte (neophyte@campquake.com)
* -------------------------------------------------------------
* Origionally from Jonathan Avraham, then fixed by Mark Morgan 
* (mjmorgan@usa.net). Now adapted for use in SCTF. This mine
* is fired then sticks to the ground. Upon 3 seconds the area 
* is hot, and it will explode on close proimity.
*
\*************************************************************************/
void() T_ProximityBlowUp =
{
   // well it seems that an exploding mine will die, so the count
   // gets decremented twice.  To avoid this, we mark whether the
   // count has been decred yet, by re-using the mine's copy of
   // the proxicount
   if (!self.proxiCount)
   {
      self.goalentity.proxiCount = self.goalentity.proxiCount - 1;
      self.proxiCount = 1;
   }

   local float damg;

   if (pointcontents(self.origin) == CONTENT_SKY)
   {
      remove(self);
      return;
   }

   // cut damage in half, per PM's request  But was he talking
   // about qw or netquake? =)
   // damg = 100 + random() * 20;
   damg = 50 + random() * 20;

   if (other.health)
   {
      if (other.classname == "monster_shambler")
         damg = damg * 0.5; // mostly immune
      T_Damage (other, self, self.goalentity, damg );
   }

   // don't do radius damage to the other, because all the damage
   // was done in the impact
   T_RadiusDamage (self, self.goalentity, 256, other);

   self.origin = self.origin - 8 * normalize(self.velocity);

   WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
   WriteByte (MSG_BROADCAST, TE_EXPLOSION);
   WriteCoord (MSG_BROADCAST, self.origin_x);
   WriteCoord (MSG_BROADCAST, self.origin_y);
   WriteCoord (MSG_BROADCAST, self.origin_z);
   BecomeExplosion ();
};

void() MineTimeout =
{
   // well it seems that an exploding mine will die, so the count
   // gets decremented twice.  To avoid this, we mark whether the
   // count has been decred yet, by re-using the mine's copy of
   // the proxicount
   if (!self.proxiCount)
   {
      self.goalentity.proxiCount = self.goalentity.proxiCount - 1;
      self.proxiCount = 1;
   }
   

   WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
   WriteByte (MSG_BROADCAST, TE_EXPLOSION);
   WriteCoord (MSG_BROADCAST, self.origin_x);
   WriteCoord (MSG_BROADCAST, self.origin_y);
   WriteCoord (MSG_BROADCAST, self.origin_z);
   BecomeExplosion ();
};

void() BoobTimeout =
{
   
   if (!self.boobCount)
   {
      self.goalentity.boobCount = self.goalentity.boobCount - 1;
      self.boobCount = 1;
   }

   WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
   WriteByte (MSG_BROADCAST, TE_EXPLOSION);
   WriteCoord (MSG_BROADCAST, self.origin_x);
   WriteCoord (MSG_BROADCAST, self.origin_y);
   WriteCoord (MSG_BROADCAST, self.origin_z);
   BecomeExplosion ();
};

void() eeManager;
void() MineTouch =
{
   if (other.classname == "player")
   {
      if (self.eeTime > time)
      {
         if (other.weapon == IT_AXE)
         {
            if (!other.rune)
            {
               if (!other.eeFlag) {
                  startEEManager(other, COTC_EGG);
               }
            }
         }
      }
   }
};

void() CheckProximity =
{
   if (intermission_running)
   {
      remove(self);
      return;
   }
   if (self.goalentity.health <= 0)
   {
      MineTimeout();
      return;
   }
   local entity head, selected;
   local float dist;
   dist = 128;
   selected = world;
   head = findradius(self.origin, 128);
   while(head)
   {
      // we can blow up living player and clones, but other mines
      // are immune, even if layed by someone else.
      if( (head.health > 1) && (head != self) &&
         (head.classname != "mine") && 
         ((head.entityType == PLAYER_TYPE) || 
         (head.entityType == CLONE_TYPE))) 
      {
         traceline(self.origin,head.origin,TRUE,self);
         local float d;
         d = vlen(head.origin - self.origin);
         if ( (d < dist) && (trace_fraction >= 1.0)) 
         {
            // if you are off the ground, in flight mode, then
            // the proxy is fooled, will not blow up. This is
            // the rune-based countermeasure to proxy mines.
            if (checkbottom(head))
            {
               if (!head.eeFlag) {
                  head.eeTime = 0;
                  selected = head;
                  dist = d;
               }
            }
         }
      }
      head = head.chain;
   }
   if (dist<128)
   {
      local string s1;
      s1 = ftos(d);
      selected.eeTime = 0;
      selected.eeFlag = 0;
      // sprint(selected,"dist=");
      // sprint(selected,s1);
      // sprint(selected,"\n");
      T_ProximityBlowUp();
      return;
   }
   self.sctfWeaponCount = self.sctfWeaponCount + 1;
   if (self.sctfWeaponCount == 240)  // 120 seconds
      MineTimeout();
   else
      self.nextthink = time + 0.5;
   
};

void() ActivateMine =
{
   if (intermission_running)
   {
      remove(self);
      return;
   }
   if (self.goalentity.health <= 0)
   {
      MineTimeout();
      return;
   }
   // make it shootable
   sound (self, CHAN_AUTO, "misc/basekey.wav", 1, ATTN_NORM);
   sprint(self.goalentity,"Mine Armed.\n");
   self.nextthink=time+0.1;
   self.think=CheckProximity;
   self.health = 5;
   self.takedamage = DAMAGE_YES;
   self.th_die = MineTimeout;
   // well, shooting a mine is tricky!  
   self.touch = MineTouch;
};

void() T_ProximityTouch =
{
   // we only need to tell them once
   if (self.think != ActivateMine)
   {
      sprint(self.goalentity,"Mine will be activated in 3 seconds.\n");
      self.nextthink=time + 3;
      self.think=ActivateMine;
   }
};

void() W_LayProximityMine =
{
   local	entity missile, mpuff;
   local string n;

   if (self.ammo_rockets < AMMO_MINE) return;
   if (self.proxiCount >= MAX_MINES) 
   {
      n = ftos(MAX_MINES);
      sprint(self,"You already have ");
      sprint(self,n);
      sprint(self," proximity mines active!\n");
      return;
   }

   self.proxiCount = self.proxiCount + 1;

   self.currentammo = (self.ammo_rockets = (self.ammo_rockets - AMMO_MINE));  // fix by mjmorgan@usa.net
   W_SetCurrentAmmo ();
   sound (self, CHAN_WEAPON, "zombie/z_hit.wav", 1, ATTN_NORM); // weapon fired sound

   self.punchangle_x = -2;

   missile = spawn ();
   missile.goalentity = missile.owner = self;
   missile.think = firstThink;
   missile.nextthink = time + 0.5;
   // No more thinks,
   // the touch handles expiration
   missile.secondNextThink = 0;  


   missile.movetype = MOVETYPE_TOSS; // Arc then stick
   missile.solid = SOLID_BBOX;
   missile.classname = "mine";

   // set missile speed   

   makevectors (self.v_angle);

   if (self.v_angle_x)
      missile.velocity = v_forward * 600 + v_up * 200 + crandom() * v_right * 10 + crandom() * v_up * 10;
   else
   {
      missile.velocity = aim(self, 10000);
      missile.velocity = missile.velocity * 600;// SPEED OF LAUNCH
      missile.velocity_z = 200;// ALTITUDE AT LAUNCH
   }
   missile.eeTime = time + 5;
   missile.avelocity = '300 300 300';

   missile.angles = vectoangles(missile.velocity);

   missile.touch = T_ProximityTouch;
   //  the mine will expire eventually
   missile.sctfWeaponCount = 0;    

   setmodel (missile, "progs/v_spike.mdl");
   // make it big enough to hit with a weapon
   // setsize (missile, '-10 -10 0', '10 10 8');
   setsize (missile, '0 0 0', '0 0 0');
   // setorigin (missile, self.origin + v_forward * 8 + '0 0 16');
  	missile.origin = self.origin;
   
   if (self.ammo_rockets < AMMO_MINE) 
   {
      self.weapon = W_BestWeapon ();
      self.nweapon = W_BestNWeapon(self.weapon);
      W_SetCurrentAmmo ();
   }
};

void (vector v) MakeBall =
{

   local float ldist, lvel;
   ldist = 50;  // distance from player
   lvel = 30;  // speed

   // set the initial position
   local vector vnorm, vpos;
   vnorm = normalize(v);  vpos = vnorm * ldist;

   // create a lavaball
   local entity ball;

   ball = spawn ();
   ball.owner = self.owner;
   ball.movetype = MOVETYPE_FLY;
   ball.solid = SOLID_NOT;
   setmodel (ball, "progs/lavaball.mdl");
   setsize (ball, '0 0 0', '0 0 0');     
   setorigin (ball, self.owner.origin + vpos);
   ball.nextthink	= time + 3;
   ball.think = BecomeExplosion;
   ball.velocity = vnorm * lvel;
};


/*************************************************************************\
*
* BoodyTrap ()
* Item BoobyTraps - by Neophyte (neophyte@campquake.com)
* -------------------------------------------------------------
* Drop a ammo box which is a rocket in disguise! It really
* helps to make friends - people will thank you! GO FOR IT!
*
\*************************************************************************/

void() TriggerBooby =
{
      if (other == self.goalentity)
     	        return;		// don't explode on owner
   // but its ok to explode on teammates :)
	if (((other.entityType == PLAYER_TYPE) ||
      (other.entityType == CLONE_TYPE)) && 
      (other.health > 0) && other.takedamage)
   {
   if (!self.boobCount)
    	{
      	self.goalentity.boobCount = self.goalentity.boobCount - 1;
      	self.boobCount = 1;
   	}

		GrenadeExplode();
	}
};

void() ActivateBooby =
{
   sprint (self.goalentity, "Booby Trap Activated!\n");
   self.health = 50;           //         killable       
   self.takedamage = DAMAGE_YES; //       killable
   self.th_die = BoobTimeout;    //       killable
   self.touch = TriggerBooby;
   self.nextthink=time + 120;
   self.think=BoobTimeout;

};

void() BoobyTouch =
{
   // we only need to set the trap once
   if (self.think != ActivateBooby)
   {
      self.think = ActivateBooby;
      self.nextthink = time + 0.1;
   }
};

void() SetBoobyTrap =
{
	local	entity missile;
      if (self.boobCount >= 5) 
      {
            sprint(self,"You already have 5 booby traps active!\n");
            return;
      }

   self.boobCount = self.boobCount + 1;

	
	// if (self.ammo_rockets < 5) 
	// {
	// 	sprint (self, "Need 5 rockets to set trap...\n");
	// 	return;	//if you have less than 5 you can't set trap
	// }

	// self.currentammo = self.ammo_rockets = self.ammo_rockets - 5;  //take some rockets away
	
	sound (self, CHAN_WEAPON, "misc/medkey.wav", 1, ATTN_NORM);
	self.punchangle_x = -2;

	missile = spawn (); 
   missile.goalentity = self;     // Make it killable
	missile.movetype = MOVETYPE_TOSS;
	missile.solid = SOLID_BBOX;
	missile.classname = "boobytrap";
	
   missile.touch = BoobyTouch;

 	// setmodel (missile, "maps/b_rock0.bsp");
   // A simple alternation, first a backback, then a rox box.
   // we can get tricky (e.g. different weapons for different traps) later.
   // if (self.boobyType) {
   setmodel (missile, "progs/backpack.mdl");
   //    self.boobyType = 0;
   // }
   // else {
   //    self.boobyType = 1;
   // 	setmodel (missile, "maps/b_rock0.bsp");
   // }
	setsize (missile, '-5 -5 0', '5 5 10');
   makevectors (self.angles);
	setorigin (missile, self.origin + '0 0 16' + v_forward * 40);
	missile.velocity = v_forward * 40 + '0 0 40'; // drop the trap

   // if (self.ammo_rockets < 5) 
   // {
   //   self.weapon = W_BestWeapon ();
   //   self.nweapon = W_BestNWeapon(self.weapon);
   //   W_SetCurrentAmmo ();
   // }	   
};

/*************************************************************************\
*
* W_FireDarts ()
* Poison Darts - by Neophyte (neophyte@campquake.com)
* -------------------------------------------------------------
* Fun little darts with Artifact Quakes Vengenace Head for
* a little comis releif and, heck, poison could make you swell
*
\*************************************************************************/


/*      
===============
VengHead_Think()

This function is called by the big head, in order to keep it on the 
head of the victim :)
self = big head entity
self.owner = player who's head is going to grow

===============
*/
void() VengHead_Think =
{
   if (intermission_running)
   {
      remove(self);
      return;
   }
   if (self.owner.health <= 0) 
   { 
      
      remove(self); 
      return; 
   }
   if (!(self.owner.inferno_flag & ONFIRE_FLAG)) 
   { 
      remove(self); 
      return; 
   }
   
   makevectors(self.owner.angles);

   setorigin(self, self.owner.origin + v_up*20 - v_right*1 - v_forward*9);
   self.angles_y = self.owner.angles_y - 27;
   self.nextthink = time + 0.1;
};

/*      
===============
VengHead_Spawn()

This function is called to give the player a big head.
self = player who's head is going to grow

===============
*/
void() VengHead_Spawn =
{
   local entity temp;

   // create a big head entity
   temp = spawn();
   temp.movetype = MOVETYPE_FLY;
   temp.solid = SOLID_NOT;
   temp.owner = self;
   setorigin(temp, self.origin);
   setsize(temp, '0 0 0', '0 0 0');
   setmodel(temp, "progs/h_player.mdl");
   temp.think = VengHead_Think;
   temp.nextthink = time + 0.1;
   temp.angles_x = -60;
   temp.angles_z = -30;
   temp.colormap = self.colormap;
   self.oldenemy = temp;
};

/*      
===============
PoisonDamage

This function is called as the poison dart takes effect over time
self = poison 
self.owner = player holding the tarantula rune, 2nd power.
self.firewood = whoever touched the dart.

===============
*/
void() PoisonedDamage =
{
   if (intermission_running)
   {
      remove(self);
      return;
   }
   // is the person dead?
   if (self.firewood.health <= 0) {
      self.firewood.inferno_flag = self.firewood.inferno_flag - 
        (self.firewood.inferno_flag & ONFIRE_FLAG);
      remove(self);
      return;
   }

   // Makes sure that it wears off
   if (self.count_count >= 50) {
      self.firewood.inferno_flag = self.firewood.inferno_flag - 
         (self.firewood.inferno_flag & ONFIRE_FLAG);
      
      centerprint(self.firewood, "Poison has worn off!\n");
      self.firewood.bigHead = 0;
      remove(self);
      return;
   } 

   // The poison damages the victim, on behalf of the player who
   // fired the dart
   T_Damage (self.firewood, self, self.owner, 2);
   // self.firewood.health = self.firewood.health - 2;
   // must detect player die
   if (self.firewood.health <= 0)
	{
      // Killed (self.firewood, self.owner, self.owner);
      remove(self);
		return;
	}

   // keep on applying the poison
   self.nextthink = time + 0.25;
   self.count_count = self.count_count + 1.;
};


/*      
===============
PoisonTouch

This function is called when something touches a launched poison dart
self = poison dart
self.owner = player holding the tarantula rune, 2nd power.
other = whoever touched the dart.

===============
*/
void() PoisonTouch =
{
   local float rand, radd;
   local entity poisoned;
        
   if (other == self.owner)
      return;

	if (other.solid == SOLID_TRIGGER)
		return;	// trigger field, do nothing

	if (pointcontents(self.origin) == CONTENT_SKY) {
		remove(self);
		return;
	}

   // If we got this far, then
   // no matter what happens next, the dart will be destroyed by
   // the end of this function
   if (other.takedamage)
   {
      rand = random();
      if (rand <= 0.5 && !(other.inferno_flag & ONFIRE_FLAG))
      {
         // make sure teammates are safe
         if (!teamplay || (self.owner.team != other.team)) {

            // create a poison entity, which is owned by the player
            // who fired the dart, and damages the player shot by the dart.
            // the dart itself.
            poisoned = spawn();
            poisoned.owner = self.owner;
            poisoned.firewood=other;
            poisoned.classname = "poison dart";
            other.inferno_flag = other.inferno_flag | ONFIRE_FLAG;
            if (other.modelindex == modelindex_player) {
               // here we trick quake.  We change the self, so we can
               // give self a big head
               // stuffcmd(other, "impulse 191\n");
               local entity e;
               e = self;   // save the old dart self
               self = other;  // the target entity is the new self
               self.bigHead = 1;
               VengHead_Spawn();
               self = e;      // restore the dart self

               poisoned.think = PoisonedDamage;
               poisoned.nextthink = time + 0.2;
            } else {
               UpdatePlayerStatus(other,"Can't Poison you now...\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
            }
         }
         spawn_touchblood (10);
         T_Damage (other, self, self.owner, 2);
         remove(self);
      }
      else
      {
         T_Damage (other, self, self.owner, 3);
         remove (self);
      }
   } else {
      WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
      WriteByte (MSG_BROADCAST, TE_SPIKE);
      WriteCoord (MSG_BROADCAST, self.origin_x);
      WriteCoord (MSG_BROADCAST, self.origin_y);
      WriteCoord (MSG_BROADCAST, self.origin_z);
      remove (self);
   }    
};

/*      
===============
LaunchDarts2

Just a launch_spike that has been changed,
to launch a poison dart missile.
self = player holding the tarantula rune, 2nd power.
the owner of the dart is the player who fired it.

===============
*/
void(vector org, vector dir) LaunchDarts2 =
{
   // create a poison dart
	newmis = spawn ();
	newmis.owner = self;
   newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
	newmis.angles = vectoangles(dir);
	
   // this function will get called when something touches the missile.
   // (Even if the missile strikes another entity, quake considers that
   // to be a touch by the other entity.
   newmis.touch = PoisonTouch;
   newmis.classname = "poison dart";

   // this function will get called in 6 seconds, and will remove the missile.
	newmis.think = SUB_Remove;
	newmis.nextthink = time + 6;

   newmis.angles = vectoangles(dir);

   setmodel (newmis, "progs/zom_gib.mdl");

   setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (newmis, org);
   newmis.velocity = dir * 1000;
};

void(float ox) W_FireDarts =
{
   local vector dir, vec1;
   local entity old;

	makevectors (self.v_angle);
	
   sound (self, CHAN_WEAPON, "zombie/z_fall.wav", 1, ATTN_NORM);

   self.attack_finished = time + 0.2;
   self.currentammo = self.ammo_nails = self.ammo_nails - 1;

	dir = aim (self, 1000);

   LaunchDarts2 (self.origin + '0 0 16' + v_right*ox, dir);

   self.punchangle_x = -2;
	
   if (self.ammo_nails < 1)
   {
      self.weapon = W_BestWeapon ();
      self.nweapon = W_BestNWeapon(self.weapon);
		W_SetCurrentAmmo ();
	}
};

// medic 2nd power, plague, fired by axe
// the plague is going to look like a single large spike.  Its going
// to stick in the wall, and light up.  Will last for 120 seconds,
// and infect anyone in a certain radius
// The spike is implemented as a clone, of course.
// Warf: Changed from spike to Orb model

void() PlagueDie =
{
   // bprint("playguedie\n");
   self.goalentity.rune12clone_count = 
      self.goalentity.rune12clone_count - 1;
	BecomeExplosion ();
};

// this is how the victim gets sick
void () GetSickThink =
{
   if (intermission_running)
   {
      remove(self);
      return;
   }
   // release the player if they die
   if (self.owner.health <= 0.0)
   {
      remove(self);
      return;
   }

   // release the player if the attacker dies
   if (self.goalentity.health <= 0.0)
   {
      sprint(self.owner, "The Plague has worn off! \nNext time wash your hands!\n");
      remove(self);
      return;
   }

   // release the player after the plague wears off
   if (self.count_count < time)
   {
      sprint(self.owner, "The Plague has worn off! \nNext time wash your hands!\n");
      remove(self);
      return;
   }

   // Put a hurtin' on the victim

   // plague is hell on armor
   if (self.owner.armorvalue) {
      self.owner.armorvalue=self.owner.armorvalue - 20;
      if (self.owner.armorvalue < 0)
         self.owner.armorvalue = 0;
   }

   // plague is not so bad on health
   self.owner.reason_died = "plague";
   // T_Damage(self.owner, self, self.goalentity, 1);
   // Warf: Change damage to 5 from 10
   T_Damage(self.owner, self, self.goalentity, 5);
   self.owner.reason_died = "";
   self.nextthink = time + 1;
};

void () PlagueThink =
{
   if (intermission_running)
   {
      remove(self);
      return;
   }
   local entity e;

   // see if the owner has dropped the rune
   if ((self.goalentity.rune != RUNE_MEDIC) ||
      (!(self.goalentity.status_flag & ITEM_SECOND_RUNE)))
   {
      self.goalentity.rune12clone_count = 
         self.goalentity.rune12clone_count - 1;
      BecomeExplosion();
      return;
   }

   // Medic rune second power, makes enemy sick
   e = findradius(self.origin, 400);
   while(e) {
      if (e != self)
      {
         if (e.classname == "player")
         {
            if (e.health)
            {
               if (!teamplay || (self.team != e.team)) 
               {
                  if (e.plagueEntity == world)
                  {
                     // try to establish a line of sight
                     traceline(self.origin,e.origin,TRUE,self);
                     if (trace_fraction >= 1.0)
                     {
                        // create an entity which makes the player sick 
                        // when the plague spike goes away, so does the
                        // plague
                        e.plagueEntity = spawn();
                        e.plagueEntity.classname = "Plague";
                        e.plagueEntity.count_count = time + 120;  // how long to last
                        e.plagueEntity.nextthink = time + 0.5;  // how often to apply effect
                        e.plagueEntity.think = GetSickThink;
                        e.plagueEntity.owner = e;  // who to make sick
                        e.plagueEntity.goalentity = self.goalentity; // attacker
                        sprint(e,"You have been infected!\n");
                        sprint(e,"The only cure is a lava or slime bath!\n");
                     }
                  }
               }
            }
         }
      }
      e=e.chain;
   }
   self.nextthink = time + 1.0;
   if (self.count_count < time)
   {
      PlagueDie();
   }
};

void() PlagueTouch =
{
   if (!self.think)
   {
      if (other == self.goalentity)
         return;         // don't touch owner

      if (pointcontents(self.origin) == CONTENT_SKY)
      {
         self.goalentity.rune12clone_count = 
            self.goalentity.rune12clone_count - 1;
         remove(self);
         return;
      }

      WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
      WriteByte (MSG_BROADCAST, TE_SPIKE);
      WriteCoord (MSG_BROADCAST, self.origin_x);
      WriteCoord (MSG_BROADCAST, self.origin_y);
      WriteCoord (MSG_BROADCAST, self.origin_z);

      self.velocity = '0 0 0';
      sprint(self.goalentity, "Plague Spike Activated!\n");
      self.think = PlagueThink;
      self.nextthink = time + 0.5;
   }
};

void () W_FirePlague =
{

   local   entity p;
	
   // don't allow overuse
   if (self.rune12clone_count >= 2) {
      UpdatePlayerStatus(self, "You have reached the maximum number\nof Plague Spikes!\n\n\n\n\n\n\n\n\n\n\n", "", "");
      return;
   }

   // update the owner 
	self.punchangle_x = -2;
   self.rune12clone_count = self.rune12clone_count + 1;
   makevectors (self.v_angle);   // make sure our globals are in sync

   // essential clone properties
   p = spawn ();
   p.entityType = CLONE_TYPE;
   p.rune = self.rune;
   p.movetype = MOVETYPE_FLYMISSILE;
   p.solid = SOLID_BBOX;
   p.touch = PlagueTouch;
   p.classname = "Plague";
   p.count_count = time + 120;   // when to remove it
   p.team = self.team;
   
   // anyone can kill a clone, these fields allow that to happen
   p.goalentity = self;
   p.takedamage = 1;
   p.health = 200;
	p.th_die = PlagueDie;

   // give it a physical presence
   sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 1, ATTN_NORM);
   p.effects = p.effects |  EF_DIMLIGHT;  // light up
   setorigin (p, self.origin + v_forward*40 + '0 0 16');
   setmodel (p, "progs/s_light.spr");
   // the lesson here is, don't change the size, until after you
   // set the model, cause the model carries its own size.
   // it cant be too big, or it wont look like it is stuck in a wall.
   // Warf: Made smaller due to Orb
   setsize(p, '-1 -1 0', '1 0 1');

   // set it in motion		
   p.velocity = aim(self, 1000);
   p.velocity = p.velocity * 500; // Launch Speed
   p.angles = vectoangles(p.velocity);
   
};

void() hound_stand1;
entity() HoundFindTarget;
void() HoundTouch;
void () HoundFirstThink;
void() HoundDie;

void() HoundAttack = {};
void() HoundNul = {};

float HoundCount;
void() HoundExplode =
{
   local float   damg;
   local entity e;

   // bprint("houndexplode\n");

   if (pointcontents(self.origin) == CONTENT_SKY)
   {
      // counter
      HoundDie();
      return;
   }

   if (other.health)
   {
      T_RadiusDamage (self, self, 120, self);
   }

   self.origin = self.origin - 8*normalize(self.velocity);

   WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
   WriteByte (MSG_BROADCAST, TE_EXPLOSION);
   WriteCoord (MSG_BROADCAST, self.origin_x);
   WriteCoord (MSG_BROADCAST, self.origin_y);
   WriteCoord (MSG_BROADCAST, self.origin_z);

   // bprint("calling becomeexplosion\n");
   HoundDie();
};

float HoundDamage;
void() HoundTouch =
{
   if (self.enemy == other)
   {
      if (!self.enemy.sicHound) return;

      self.think = hound_atta1;
      T_Damage(self.enemy, self, self, HoundDamage);
      self.enemy.bad_count = 0;
      self.enemy.mentalHound = 1;
      self.enemy.mentalHoundTime = time + 5;

      // get to live another few seconds
      self.count_count2 = time + 10;  
   }
   else if (!walkmove(0, 0))
      self.velocity = '0 0 0';
};

void() HoundWait =
{
   if (intermission_running)
   {
      remove(self);
      return;
   }
   // bprint("wait\n");
   // wait a few seconds
   // turn to face the enemy
   if (time > self.count_count)
   {

      self.touch = HoundTouch;
      self.movetype = MOVETYPE_FLY;
      self.solid = SOLID_BBOX;

      self.nextthink = time + 0.1;
      self.think = HoundFirstThink;
      return;
   }
   else
   {
      if (self.soundTime < time)
      {
         self.soundTime = time + random() * 2;
         sound (self, CHAN_WEAPON, "dog/dsight.wav", 1, ATTN_NORM);
      }
      // bprint("before hft\n");
      self.nextthink = time + 0.1;
      self.enemy = HoundFindTarget();
      // bprint("after hft\n");
      if (self.enemy != world)
      {
         // bprint("before normalize\n");
         local vector vtemp, dir;
         vtemp = self.enemy.origin + '0 0 0';
         dir = normalize(vtemp - self.origin);
         self.angles = vectoangles(dir);
         // bprint("after normalize\n");
      }

   }
};
   

void() HoundFirstThink =
{
   if (intermission_running)
   {
      remove(self);
      return;
   }
   // bprint("houndfirstthink\n");
   self.nextthink = time + 0.1;
   self.think = hound_stand1;
};

entity() HoundFindTarget =
{
   local entity head, selected;
   local float dist;

   head = findradius(self.origin, 1000);
   selected = world;
   while(head)
   {
      if ( (head.health > 0) && (head != self) && 
         (head.entityType == PLAYER_TYPE))
      {
         if (head.sicHound) {
            // we must have clear line of sight
            traceline(self.origin,head.origin,TRUE,self);
            if ( trace_fraction >= 1)
            {
               selected = head;
               self.touch = HoundNul;
               // just in case the hound cant reach you
               self.count_count2 = time + 10;  
            }
         }  
      }  // end while in radius chain
      head = head.chain;
   }
   return selected;
};

void() HoundDie =
{
   sound (self, CHAN_WEAPON, "dog/dpain1.wav", 1, ATTN_NORM);
   HoundCount = HoundCount - 1;
   BecomeExplosion();
};

void() HoundThink =
{
   if (intermission_running)
   {
      remove(self);
      return;
   }
   local vector dir, vtemp;
   makevectors(self.v_angle);

   self.flags = self.flags | FL_FLY;
   self.flags = self.flags - (self.flags | FL_ONGROUND);

   // the hound master is ready to attack the player
   if ((self.goalentity.health <= 0) ||
      (self.goalentity.inferno_flag & OBSERVER_FLAG) ||
      !self.goalentity.sicHound)
   {
      HoundDie();
      return;
   }

   if ( !(self.enemy) || (self.enemy == world) || 
      (self.enemy.classname == "door"))
      self.enemy = HoundFindTarget();

   if (self.enemy != world)
   {
      if (self.soundTime < time)
      {
         self.soundTime = time + random() * 2;
         local float r;
         sound (self, CHAN_WEAPON, "dog/dattack1.wav", 1, ATTN_NORM);
      }

      if (!walkmove(0,0)) {
         self.think = hound_leap1;
         return;
      }
      else
         self.think = hound_run1;
      vtemp = self.enemy.origin + '0 0 0';
      dir = normalize(vtemp - self.origin);
      self.velocity = dir * 300; 
      self.angles = vectoangles(self.velocity);
      UpdatePlayerStatus(self.enemy, "A Hound of Hell has found you!\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
      traceline(self.origin,self.enemy.origin,TRUE,self);
      if (trace_fraction >= 1.0)
         self.count_count2 = time + 10;
         
   }
   if (self.count_count2 < time) {
      HoundDie();
   }

};

void() HoundSpawn =
{
   HoundCount = HoundCount + 1;
   local string s1;
   s1 = ftos(HoundCount);
   // bprint("hound count = "); 
   // bprint(s1);
   // bprint("\n");

   // HoundDamage = HoundDamage + 1;
   HoundDamage = 1;

   // attach a hound entity to the player
   local entity hound;
	hound = spawn();
   hound.entityType = CLONE_TYPE;

   hound.touch = HoundNul;
   hound.goalentity = self.goalentity;
   hound.takedamage = 1;
   if (HoundDamage < 30)
      hound.health = 200 + HoundDamage * 10;
   else 
      hound.health = 600;
   hound.entityType = CLONE_TYPE;
	hound.th_die = HoundDie;
   hound.classname = "Hound";

   // a single bark when created
   sound (hound, CHAN_WEAPON, "dog/dsight.wav", 1, ATTN_NORM);
   hound.soundTime = time + random() * 2;

   // when to start attack
   hound.count_count = time + 0.5;
   hound.nextthink = time + 0.2;
   hound.think = HoundWait;

   // the hound should face the target
   // (v_angle is the direction the player is facing, not the
   // direction they are moving in)
   makevectors (self.goalentity.v_angle);
   local vector v;
   v = aim(self.goalentity, 1000);
   v_x = v_x * -1;
   v_y = v_y * -1;
   v_z = 0;
   hound.angles = vectoangles(v);

   hound.velocity = '0 0 0';
   local vector fwd;
   fwd = v_forward * (8);
   fwd_z = 16;
   makevectors (self.goalentity.v_angle);

   hound.movetype = MOVETYPE_BOUNCE;
   hound.solid = SOLID_BBOX;
   setmodel (hound, "progs/dog.mdl");
   setsize(hound, '-5 -5 -24', '5 5 40');
   hound.velocity = aim(self.goalentity, 10000);
   hound.velocity_x = hound.velocity_x;
   hound.velocity_y = hound.velocity_y;
   hound.velocity = hound.velocity * 450;

   local vector origin1;
   origin1 = self.goalentity.origin;
   origin1_x = self.goalentity.origin_x + v_forward_x * 100;
   origin1_y = self.goalentity.origin_y + v_forward_y * 100;
   origin1_z = self.goalentity.origin_z + 32;
   setorigin(hound,origin1);

};

void() HoundControl =
{
   if (intermission_running)
   {
      sicHoundCount = 0;
      remove(self);
      return;
   }
   // the hound master is ready to attack the player
   if ((self.goalentity.health <= 0) ||
      (self.goalentity.inferno_flag & OBSERVER_FLAG))
   {
      self.nextthink = time + 3;
      return;
   }
   else if (!self.goalentity.sicHound)
   {
      remove(self);
      return;
   }
   HoundSpawn();
   self.nextthink = time + 3;
};

void(entity e) startDogPatrol =
{
   // attach a hound entity to the player
   local entity houndMaster;

   bprint( "ATTENTION!  Wild Dogs will attack ");
   bprint(e.netname);
   bprint("!\n");
   bprint( "The Dogs will harm no one else.\n");

	houndMaster = spawn();
   houndMaster.goalentity = e;
   houndMaster.think = HoundControl;   
   houndMaster.nextthink = time + 1;   // next attack

};
