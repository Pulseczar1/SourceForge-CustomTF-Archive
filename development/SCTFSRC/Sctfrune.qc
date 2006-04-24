void() OrganDonorNapalmThink;
void () HealerThink;
void  (entity e) GetRuneNames;

void()  checkForGodMode;

/*************************************************************************\
*
*  RuneApplyPowers()
*  Adjust player for the rune first and second powers 
*  Called on putclientinserver, clientdie, srune, throwrune, runetouch
*  Here is the trick to using this function in the future:
*  1. If a nonstandard skin, think, etc is applied for a rune, then 
*     you should un-apply it whenever that rune is not held.
*  2. If a rune uses a flag, counter, or other entity field, then that
*     field should get reset whenever this function is called.
*
\*************************************************************************/

void() RuneApplyPowers =
{
   dprint(self.netname);
   if (self.rune)
   {
      GetRuneNames(self);
      local string s1;
      dprint(" rune[");
      s1 = ftos(self.rune);
      dprint(s1);
      if (!(self.status_flag & ITEM_SECOND_RUNE))
         dprint(" 1stPower]\n");
      else
         dprint(" 2ndPower]\n");
   }
   else {
      dprint(" no rune\n");
      self.runeName = "";
      self.power1 = "";
      self.power2 = "";
   }

   // any time a rune changes, these fields are cleared.
   setmodel(self, "progs/player.mdl");
   setsize(self, VEC_HULL_MIN, VEC_HULL_MAX);
   self.touch = SUB_Null;   // only a few runes use this
   self.napalmTime = 0;
   self.boobyType = 0;
   self.fly = 0;
   if (self.flags & FL_FLY)
      self.flags = self.flags - FL_FLY;
   if (self.movetype == MOVETYPE_FLY)
      self.movetype = MOVETYPE_WALK;
   if (self.effects & EF_BRIGHTFIELD)
      self.effects = self.effects - (self.effects & EF_BRIGHTFIELD);


   // start with a clean clone state
   if (self.clone1 != world) {
      remove(self.clone1);
      self.clone1 = world;
   }
   if (self.clone2 != world) {
      remove(self.clone2);
      self.clone2 = world;
   }

   if (self.rune == RUNE_MEDIC) {
      if (!(self.status_flag & ITEM_SECOND_RUNE)) 
      {
         self.MedicEntity = spawn();
         self.MedicEntity.team = self.team;
         self.MedicEntity.think = HealerThink;
         // we think a lot, in case the owner dies
         self.MedicEntity.nextthink = time + 0.5;
         // but we dont bump health quite so often
         self.MedicEntity.regen_time = time + 0.5;
         self.MedicEntity.owner = self;
      }
   }
   else if (self.rune == RUNE_VAMPIRE) {
      if (!(self.status_flag & ITEM_SECOND_RUNE))
         self.fly = 1;
   }
   else if (self.rune == RUNE_FOOLISH) {
      if (!(self.status_flag & ITEM_SECOND_RUNE)) {
         self.fly = 1;
      }
   }
   else if (self.rune == RUNE_FPILOT) 
      self.fly = 1;
   else if (self.rune == RUNE_SUPERMAN)
      self.fly = 1;
   else if (self.rune == RUNE_HERMES) {
      if (!(self.status_flag & ITEM_SECOND_RUNE))
         self.fly = 1;
   }
   else if (self.rune == RUNE_DRAGON) {
      if (!(self.status_flag & ITEM_SECOND_RUNE)) 
         self.fly = 1;
   }
   else if (self.rune == RUNE_POSSESSER) {
      if (self.status_flag & ITEM_SECOND_RUNE)
         self.fly = 1;
      else {
         if (self.chase_observer != world) {
            TeleportEffect(self);
            sound(self, CHAN_WEAPON, "misc/r_tele4.wav", 1, ATTN_NORM);

            // teleport self
            makevectors(self.chase_observer.v_angle);
            self.origin = (self.chase_observer.origin + v_forward*-60);
            // make sure we can actually teleport???

            TeleportEffect(self);
            sound(self, CHAN_WEAPON, "misc/r_tele3.wav", 1, ATTN_NORM);

            // spawn_tdeath(self.inforigin, self);  // make sure telefrag happens
         }
      }
   }
   else if (self.rune == RUNE_BLACK_MAGIC) {
      if (!(self.status_flag & ITEM_SECOND_RUNE))
         self.fly = 1;
   }
   else if (self.rune == RUNE_WEREWOLF) {
      if (!(self.status_flag & ITEM_SECOND_RUNE)) {
         self.touch = PlayerTouch;
      }
   }
   // else if (self.rune == RUNE_LAO) {
   //    if (self.status_flag & ITEM_SECOND_RUNE) {
   //       self.touch = PlayerTouch;
   //    }
   // }

   // we cant go by player boobcount because 
   // it might have been set to 0 if the client was
   // killed or suicided.
   local entity e1;
   e1 = find(world, classname, "boobytrap");
   while (e1 != world) {
      if ( e1.goalentity == self ) {
         local entity tmp1;
         tmp1 = self;
         self = e1;
         BoobTimeout();
         self = tmp1;
      }
      // increment the loop whether or not an owned trap was found.
      e1 = find(e1, classname, "boobytrap");
   }
   self.boobCount = 0;


   checkForGodMode();
};

void()  checkForGodMode = 
{
   if (teamplay & SCTF_GOD_MODE) {
      self.items=self.items|IT_SUPER_SHOTGUN|IT_NAILGUN|IT_SUPER_NAILGUN|IT_GRENADE_LAUNCHER|IT_ROCKET_LAUNCHER|IT_LIGHTNING|IT_DOG_LAUNCHER;
      self.ammo_shells=self.ammo_shells + 200;
      self.ammo_nails=self.ammo_nails + 200;
      self.ammo_rockets=self.ammo_rockets + 200;
      self.ammo_cells=self.ammo_cells + 200;

   	self.armortype = 0.8;
   	self.armorvalue = 200;
   	self.items = 
      self.items - (self.items & (IT_ARMOR1 | IT_ARMOR2 | IT_ARMOR3)) + 
      IT_ARMOR3;

      local entity o1;
      o1 = other;
      other=self;
      bound_other_ammo();
      other = o1;
      W_SetCurrentAmmo();
      
   }

};


void() OrganDonorNapalmThink = 
{
   // how often to check the napalm effect
   self.napalmTime = time + 1.0;
   
   // if (intermission_running)
   // {
   //    remove(self);
   //    self.owner.ODNapalm = world;
   //    return;
   // }
   // // check to see if player has expired
   // if (self.owner.health <= 0) 
   // {
   //    remove(self);
   //    self.owner.ODNapalm = world;
   //    return;
   // }
   // if ((self.owner.rune != RUNE_ORGANDONOR) ||
   //    (self.owner.status_flag & ITEM_SECOND_RUNE)) 
   // {
   //    remove(self);
   //    self.owner.ODNapalm = world;
   //    return;
   // }

   // find any enemy in radius and line of sight who
   // we can burn up
   local entity e1;
   e1 = findradius(self.origin, 600);
   while (e1) {
      if ((e1 != self) && (e1.health) && 
         (e1.entityType == PLAYER_TYPE) && 
         (!teamplay || (e1.team != self.team)))
      {
         traceline(self.origin, e1.origin, TRUE, self);
         // other player must be visible
         if (trace_fraction >= 1)
            BurnSetOnFire (e1, self, "ODFire");
      }
      e1 = e1.chain;
    }
};

void (entity ppp) RegenHealthAndArmor =
{
   local float regen;
   regen = 0;
   if (ppp.health < 100) {
      ppp.health=ppp.health+5;
      if(ppp.health>100)ppp.health=100;
      regen = 1;
   }
   if ((ppp.armortype > 0)  &&
      (ppp.armortype <= 0.3)) {  // armor 1
      if (ppp.armorvalue < 100) {
         ppp.armorvalue=ppp.armorvalue+5;
         if(ppp.armorvalue>100)ppp.armorvalue=100;
         regen = 1;
      }
   } else if (ppp.armortype <= 0.6) {  // armor 2
      if (ppp.armorvalue < 150) {
         ppp.armorvalue=ppp.armorvalue+5;
         if(ppp.armorvalue>150)ppp.armorvalue=150;
         regen = 1;
      }
   } else {   // armor 3
      if (ppp.armorvalue < 200) {
         ppp.armorvalue=ppp.armorvalue+5;
         if(ppp.armorvalue>200)ppp.armorvalue=200;
         regen = 1;
      }
   }
   if (regen)
      sound(ppp, CHAN_BODY, "items/r_item1.wav", 1, ATTN_NORM);
};

void () HealerThink =
{
   if (intermission_running)
   {
      remove(self);
      self.owner.MedicEntity = world;
      return;
   }
   if (self.owner.health <= 0.0)
   {
      remove(self);
      self.owner.MedicEntity = world;
      return;
   }
   if ((self.owner.rune != RUNE_MEDIC) || (self.owner.status_flag & ITEM_SECOND_RUNE))
   {
      remove(self);
      self.owner.MedicEntity = world;
      return;
   }

   self.nextthink = time + 0.5;

   // make sure its time for an update
   // if (self.regen_time > time)
   //    return;
   // self.regen_time = time + 0.5;

   RegenHealthAndArmor(self.owner);

   // help your friends
   local entity ppp;
   ppp = findradius(self.owner.origin, 400);
   while (ppp) {
      if (ppp.entityType == PLAYER_TYPE) {
         if (ppp.health) {
            if (ppp != self) {
               if (self.team == ppp.team) {
                  RegenHealthAndArmor(ppp);
               }
            }
         }
      }
      ppp = ppp.chain;
   }
};
