void() PainSound;
void() RegenerationSound;  // regeneration sound
void() T_MissileTouch;
void() info_player_start;
void(entity targ, entity attacker, entity inflictor) ClientObituary;
void(string gibname, float dm) ThrowGib;  // since player.qc comes later
void(entity ppp) Inf_SetAmmo;  // set JUST ammo for player (currentammo)

//============================================================================

/*
============
CanDamage

Returns true if the inflictor can directly damage the target.  Used for
explosions and melee attacks.
============
*/
float(entity targ, entity inflictor) CanDamage =
{

// bmodels need special checking because their origin is 0,0,0
	if (targ.movetype == MOVETYPE_PUSH)
	{
		traceline(inflictor.origin, 0.5 * (targ.absmin + targ.absmax), TRUE, self);
		if (trace_fraction == 1)
			return TRUE;
		if (trace_ent == targ)
			return TRUE;
		return FALSE;
	}
	
	traceline(inflictor.origin, targ.origin, TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '15 15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '-15 -15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '-15 15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '15 -15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;

	return FALSE;
};


/*
============
Killed
============
*/
void(entity targ, entity attacker, entity inflictor) Killed =
{
	local entity oself;

	oself = self;
	self = targ;
	
   /* INFERNO:  man, the enemies core was destroyed..good news for the
      team who did it, poor enemy-team tho :(
   */

	if (self.health < -99)
		self.health = -99;		// don't let sbar look bad if a player

	if (self.movetype == MOVETYPE_PUSH || self.movetype == MOVETYPE_NONE)
	{	// doors, triggers, etc

		self.th_die ();
		self = oself;
		return;
	}

	self.enemy = attacker;

   // bump the monster counter
        if (self.flags & FL_MONSTER)
        {
                killed_monsters = killed_monsters + 1;
                WriteByte (MSG_ALL, SVC_KILLEDMONSTER);
        }

        ClientObituary(self, attacker, inflictor);
	
	self.takedamage = DAMAGE_NO;
	self.touch = SUB_Null;

   //  removed monsters
   //	monster_death_use();
	self.th_die ();
	
	self = oself;
};


// *TEAMPLAY*
// Prototypes

float(entity targ, entity inflictor, entity attacker, float damage) TeamArmorDam;
float(entity targ, entity inflictor, entity attacker, float damage) TeamHealthDam;

/*
============
T_Damage

The damage is coming from inflictor, but get mad at attacker
This should be the only function that ever reduces health.
============
*/
void(entity targ, entity inflictor, entity attacker, float damage) T_Damage=
{
	local	vector	dir;
   local   entity  oldself, asap, oself;
   local   float   save, take, damagee, f1;

   // set damagee
   damagee = damage;


   /*  nothing gets damage during picking your base!!! */
   if ((targ.flags & FL_GODMODE)&&(teamplay&TEAM_PICK_BASE))
		return;

   /* the spells that don't harm the owners */
   if(inflictor.owner==targ&&(inflictor.classname=="ground explosions"||
   (inflictor.classname=="lavagun"&&inflictor.rune_power==RUNE_HELL_MAGIC)))
           return;

	if (!targ.takedamage)
		return;

   if (targ.rune == RUNE_TURTLE && !(targ.status_flag & ITEM_SECOND_RUNE) &&
   ((targ.attack_finished + 6) < time) && vlen(targ.velocity) <= 20) {
           if (!teamplay || targ.team != attacker.team)
              targ.health=targ.health - 1;
           UpdatePlayerStatus(targ, "Your Shell is covering you!\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
           if (targ.health <= 0)
           {
                   Killed (targ, attacker, inflictor);
                   return;
           }
           return;
   }

   // used by buttons and triggers to set activator for target firing
   damage_attacker = attacker;

   // person used the block button
   if((targ.pl_block)&&targ.pl_block_time >= time) {
           damage=damage/2;
           if (targ.invincible_sound < time) {
                   sound (targ, CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM);
                   targ.invincible_sound = time + 2;
           }
   }

   // earth magic, power-resistance
   if ((targ.rune_power==RUNE_EARTH_MAGIC&&targ.rune_power_time>=time)||
   (targ.rune_power==RUNE_FUTURE&&targ.rune_power_time>=time)) {
           if (targ.invincible_sound < time) {
                   sound (targ, CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM);
                   targ.invincible_sound = time + 2;
           }
           damage=damage/4;
   }

   // person has reptile rune, do extra damage
   if (targ.rune == RUNE_REPTILE && (targ.status_flag & ITEM_SECOND_RUNE))
           damage = damage * 2;

   // oh no!  The target was caught with the OD rune invis, do extra damage!
   if ((targ.rune == RUNE_ORGANDONOR) ||
      (targ.rune == RUNE_FPILOT))
           damage = damage * 1.5;  // don't over damage the person

   // check for quad damage powerup on the attacker
	if (attacker.super_damage_finished > time)
		damage = damage * 4;

   // check for pq powerup on the attacker
   if (attacker.pq_finished > time)
           damage = damage * 2;

   // check for pq powerup on the targ
   if (targ.pq_finished > time) {
           damage = damage / 2;
           if (targ.invincible_sound < time) {
                   sound (targ, CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM);
                   targ.invincible_sound = time + 2;
           }
   }

   // targ shielded by spawn
   if (targ.runeg_rune==RUNE_SPAWN && targ.runeg_time > time) {
           damage = damage / 8;
           if (targ.invincible_sound < time) {
                   sound (targ, CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM);
                   targ.invincible_sound = time + 2;
           }
   }

   // RUNE: check for double damage for rune of Black Magic powerup
   if ((attacker.rune == RUNE_BLACK_MAGIC && !(attacker.status_flag & ITEM_SECOND_RUNE)) ||
   (attacker.rune == RUNE_ROBOT && !(attacker.status_flag & ITEM_SECOND_RUNE)))
		damage = damage * 2;

   // RUNE: check to see if the person has the superman rune
   if (attacker.rune == RUNE_SUPERMAN && !(attacker.status_flag & ITEM_SECOND_RUNE))
           damage = damage * 4;
   if (targ.rune == RUNE_SUPERMAN && !(targ.status_flag & ITEM_SECOND_RUNE) && targ != attacker)
           damage = damage * 2;

   // RUNE: check for double damage for rune of MARS powerup
   if ((attacker.rune == RUNE_MARS) && !(attacker.status_flag & ITEM_SECOND_RUNE)) {
           if (targ != attacker)
                   damage = damage * 4;
   }


   // if ((targ.rune == RUNE_DISAPEAR) && !(targ.status_flag & ITEM_SECOND_RUNE)) {
   //         if (targ != attacker)
   //                 damage = damage * 2;
   // }

   // RUNE: check for double damage for rune of MARS powerup (if target has it)
   if (targ.rune == RUNE_MARS && !(targ.status_flag & ITEM_SECOND_RUNE)) {
           if (targ != attacker)
                   damage = damage * 2;
   }

   // targ is caught jumping into the air with strength magic
   if (targ.rune == RUNE_STRONG && !(targ.status_flag & ITEM_SECOND_RUNE) && !(self.flags & FL_ONGROUND)) {
           if (targ != attacker)
                   damage = damage / 2;
   }

   // RUNE:  zombie rune, only damaged big time by rockets
   if (targ.rune == RUNE_ZOMBIE && !(targ.status_flag & ITEM_SECOND_RUNE) && attacker != targ) {
           if (inflictor.classname == "rocket" || inflictor.classname == "grenade")
                   damage = damage * 2;
           else damage = damage / 4;
   }

   // Do double damage if the player is found with the poseidon rune
   if (targ.rune == RUNE_POSEIDON && !(targ.status_flag & ITEM_SECOND_RUNE))
           damage = damage * 1.5;

   // target is caught with the possesser rune
   if (targ.rune == RUNE_POSSESSER && (targ.status_flag & ITEM_SECOND_RUNE))
           damage = damage * 1.5;


   // Check out if the person has the death rune (become stronger and more resistent with less life) or life
   // Warf: Reduce resistance of Life Rune
   if (((targ.rune == RUNE_DEATH && !(targ.status_flag & ITEM_SECOND_RUNE)) ||
   (targ.rune == RUNE_LIFE && !(targ.status_flag & ITEM_SECOND_RUNE))) && targ != attacker) {
           if (targ.rune == RUNE_LIFE) {
                   if (targ.health >= 100)
                           damage = damage / 2;
                   else if (targ.health >= 80)
                           damage = damage / 1.5;
           }
           if (targ.rune == RUNE_DEATH) {
                   if (targ.health >= 80)
                           damage = damage / 4;
                   else if (targ.health >= 60)
                           damage = damage / 6;
                   else if (targ.health >= 40)
                           damage = damage / 8;
                   else if (targ.health >= 20)
                           damage = damage / 10;
                   else if (targ.health)
                           damage = damage / 12;
           }
           if (teamplay & TEAM_CAPTURE_CUSTOM) {
                   if (targ.invincible_sound < time) {
                           sound (targ, CHAN_ITEM, "rune/rune1.wav", 1, ATTN_NORM);
                           targ.invincible_sound = time + 2;
                   }
           } else if (targ.invincible_sound < time) {
                   sound (targ, CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM);
                   targ.invincible_sound = time + 2;
           }
   }
   // now it's the attacker's turn
   if (((attacker.rune == RUNE_DEATH && !(attacker.status_flag & ITEM_SECOND_RUNE)) ||
   (attacker.rune == RUNE_LIFE && !(attacker.status_flag & ITEM_SECOND_RUNE))) && targ != attacker) {
           if (attacker.rune == RUNE_LIFE) {
                   if (attacker.health >= 100)
                           damage = damage * 4;
                   else if (attacker.health >= 80)
                           damage = damage * 3;
                   else if (attacker.health >= 60)
                           damage = damage * 2;
                   else if (attacker.health >= 30)
                           damage = damage;
           }
           if (attacker.rune == RUNE_DEATH) {
                   if (attacker.health >= 80)
                           damage = damage;
                   else if (attacker.health >= 60)
                           damage = damage * 2;
                   else if (attacker.health >= 40)
                           damage = damage * 3;
                   else if (attacker.health >= 30)
                           damage = damage * 4;
                   else if (attacker.health)
                           damage = damage * 5;
           }
   }

   // KEY: check for the knight key (stronger when closer to the flag) or rebel knight
   if (attacker.rune == RUNE_KNIGHT) {
      asap = findradius(attacker.origin, 400);
      while (asap)
      {
         if (((asap.team == attacker.team) && (is_flag(asap)) &&
         !(attacker.status_flag & ITEM_SECOND_RUNE)) ||
         ((asap.team != attacker.team) && (is_flag(asap)) &&
         (attacker.status_flag & ITEM_SECOND_RUNE)))
                 damagee = damage * 2;
         asap = asap.chain;
      }
      asap = findradius(attacker.origin, 250);
      while (asap)
      {
         if (((asap.team == attacker.team) && (is_flag(asap)) &&
         !(attacker.status_flag & ITEM_SECOND_RUNE)) ||
         ((asap.team != attacker.team) && (is_flag(asap)) &&
         !(attacker.status_flag & ITEM_SECOND_RUNE)))
                 damagee = damage * 3;
         asap = asap.chain;
      }
      asap = findradius(attacker.origin, 50);
      while (asap)
      {
         if (((asap.team == attacker.team) && (is_flag(asap)) &&
         !(attacker.status_flag & ITEM_SECOND_RUNE)) ||
         ((asap.team != attacker.team) && (is_flag(asap)) &&
         !(attacker.status_flag & ITEM_SECOND_RUNE)))
                 damagee = damage * 4;
         asap = asap.chain;
      }
      damage = damagee;
      if (targ.invincible_sound < time) {
              sound (targ, CHAN_ITEM, "wizard/wpain.wav", 1, ATTN_NORM);
              targ.invincible_sound = time + 2;
      }
   }

   // KEY: check for the knight key (stronger when closer to the flag) or rebel knight
   if (targ.rune == RUNE_KNIGHT) {
      asap = findradius(targ.origin, 400);
      while (asap)
      {
         if (((asap.team == targ.team) && (is_flag(asap)) &&
         !(targ.status_flag & ITEM_SECOND_RUNE)) ||
         ((asap.team != targ.team) && (is_flag(asap)) &&
         !(targ.status_flag & ITEM_SECOND_RUNE)))
                 damagee = damage / 3;
         asap = asap.chain;
      }
      asap = findradius(targ.origin, 250);
      while (asap)
      {
         if (((asap.team == targ.team) && (is_flag(asap)) &&
         !(targ.status_flag & ITEM_SECOND_RUNE)) ||
         ((asap.team != targ.team) && (is_flag(asap)) &&
         !(targ.status_flag & ITEM_SECOND_RUNE)))
                 damagee = damage / 4;
         asap = asap.chain;
      }
      asap = findradius(targ.origin, 50);
      while (asap)
      {
         if (((asap.team == targ.team) && (is_flag(asap)) &&
         !(targ.status_flag & ITEM_SECOND_RUNE)) ||
         ((asap.team != targ.team) && (is_flag(asap)) &&
         !(targ.status_flag & ITEM_SECOND_RUNE)))
                 damagee = damage / 6;
         asap = asap.chain;
      }
      damage = damagee;
      if (targ.invincible_sound < time) {
              sound (targ, CHAN_ITEM, "wizard/wpain.wav", 1, ATTN_NORM);
              targ.invincible_sound = time + 2;
      }
   }

   // check to see if it's a bouncer or not
   if (inflictor.classname == "bouncer" || targ.reason_died == "bouncer") {// || (targ.flags & FL_GODMODE2)) {
           if ( (inflictor != world) && (targ.movetype == MOVETYPE_WALK) )
           {
                   if (targ.reason_died == "bouncer") {
                           makevectors(inflictor.angles);
                           targ.velocity=targ.velocity+/*v_forward*1000+*/v_up*1000;
                   } else {
                           dir = targ.origin - (inflictor.absmin + inflictor.absmax) * 0.5;
                           dir = normalize(dir);
                           targ.velocity = targ.velocity + dir*damage*8;
                   }
           }
           return;
   }

   //RUNE check if target has rune of Earth Magic (half damage)
   if ((targ.rune == RUNE_EARTH_MAGIC && !(targ.status_flag & ITEM_SECOND_RUNE)) ||
   (targ.rune == RUNE_SUPERMAN && (targ.status_flag & ITEM_SECOND_RUNE))) {
           if (targ.rune == RUNE_SUPERMAN && attacker != targ) damage = damage / 4;
           else if (targ.rune == RUNE_EARTH_MAGIC) damage = damage / 2;
           if (teamplay & TEAM_CAPTURE_CUSTOM) {
                   if (targ.invincible_sound < time) {
                           sound (targ, CHAN_ITEM, "rune/rune1.wav", 1, ATTN_NORM);
                           targ.invincible_sound = time + 2;
                   }
           } else if (targ.invincible_sound < time) {
                   sound (targ, CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM);
                   targ.invincible_sound = time + 2;
           }
	}

   // superman
   if (attacker.rune == RUNE_SUPERMAN && (attacker.status_flag & ITEM_SECOND_RUNE) && attacker != targ)
           damage = damage / 2;

   //RUNE check if target has rune of Kung Lao (half damage there...)
   // if ((targ.rune == RUNE_LAO) && (targ.status_flag & ITEM_SECOND_RUNE)) {
   //         f1 = 0;
   //         asap = find(world, classname, "whirlwind spin");
   //         while (asap != world)
   //         {
   //                 if (asap.owner == targ && !asap.cnt)
   //                         f1 = 1;
   //                 asap = find(asap,classname,"whirlwind spin");
   //         }
   //         if (f1) {
   //                 damage = damage / 2;
   //                 if (teamplay & TEAM_CAPTURE_CUSTOM) {
   //                         if (targ.invincible_sound < time) {
   //                                 sound (targ, CHAN_ITEM, "rune/rune1.wav", 1, ATTN_NORM);
   //                                 targ.invincible_sound = time + 2;
   //                         }
   //                 } else if (targ.invincible_sound < time) {
   //                         sound (targ, CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM);
   //                         targ.invincible_sound = time + 2;
   //                 }
   //         }
   // }


   //RUNE check if target has rune of Ghost Rune
   if (targ.rune == RUNE_GHOST && !(targ.status_flag & ITEM_SECOND_RUNE)) {
           damage = damage / 1.5;
           if (teamplay & TEAM_CAPTURE_CUSTOM) {
                   if (targ.invincible_sound < time) {
                           sound (targ, CHAN_ITEM, "rune/rune1.wav", 1, ATTN_NORM);
                           targ.invincible_sound = time + 2;
                   }
           } else if (targ.invincible_sound < time) {
                   sound (targ, CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM);
                   targ.invincible_sound = time + 2;
           }
	}

   //RUNE check if target has rune of Illusion
   if ((targ.rune == RUNE_ILLUSION && !(targ.status_flag & ITEM_SECOND_RUNE)) || (targ.rune == RUNE_HERMES && (targ.status_flag & ITEM_SECOND_RUNE))) {
           if (targ.rune == RUNE_ILLUSION)
                   damage = damage / 1.4;
           else damage = damage / 1.2;
           if (teamplay & TEAM_CAPTURE_CUSTOM) {
                   if (targ.invincible_sound < time) {
                           sound (targ, CHAN_ITEM, "rune/rune1.wav", 1, ATTN_NORM);
                           targ.invincible_sound = time + 2;
                   }
           } else if (targ.invincible_sound < time) {
                   sound (targ, CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM);
                   targ.invincible_sound = time + 2;
           }
	}

   // check for the navy officer rune, anybody can do two times the damage to the person
   if (targ.rune == RUNE_NAVY_OFFICER &&
   (targ.status_flag & ITEM_SECOND_RUNE) && targ.nweapon == NEW_AXE &&
   targ.attack_finished >= time)
           damage = damage * 2;

   //RUNE check if target has rune of Cops (Bullet Proof Vest)
   if (targ.rune == RUNE_COP && (targ.status_flag & ITEM_SECOND_RUNE)) {
           damage = damage / 2;
           if (teamplay & TEAM_CAPTURE_CUSTOM) {
                   if (targ.invincible_sound < time) {
                           sound (targ, CHAN_ITEM, "rune/rune1.wav", 1, ATTN_NORM);
                           targ.invincible_sound = time + 2;
                   }
           } else if (targ.invincible_sound < time) {
                   sound (targ, CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM);
                   targ.invincible_sound = time + 2;
           }

           // no matter what, for special effects, throwgibs
           // for effects, use metal, in order to do this, we
           // must store the current entity
           oself = self;
           self = targ;
           if (self.regen_time < time) {
                   ThrowGib("progs/spike.mdl", -100);
                   ThrowGib("progs/spike.mdl", -50);
                   ThrowGib("progs/spike.mdl", -100);
                   self.regen_time = time + 1;
           }
           self = oself;
	}

   // KEY: check to see if the person has the witch's rune
   if (attacker.rune == RUNE_WITCH &&
   !(attacker.status_flag & ITEM_SECOND_RUNE) &&
   random() < 0.3 && targ.classname == "player" &&
   (!teamplay || attacker.team != targ.team || targ == attacker)) {// || (targ.runeb_type & ITEM_SECOND_RUNE)))) {
           targ.runeb_rune = RUNE_WITCH;
           targ.runeb_time = time + 15;
           UpdatePlayerStatus(targ, "You've been turned into a rotweiller\nfor 15 seconds!\n\n\n\n\n\n\n\n\n\n\n", "", "");
   }

   // CHECK:  *INFERNO* if the death rune is there
   if (attacker.rune == RUNE_DEATH) {
      if (attacker.status_flag & ITEM_SECOND_RUNE) {
         if (random() < 0.5) {
            if (targ.classname == "player") {
               if (!teamplay || (attacker.team != targ.team) || 
               (attacker == targ)) {
                 targ.runeb_rune = RUNE_DEATH;
                 targ.runeb_time = time + 20;
                 UpdatePlayerStatus(targ, "You've been turned into a zombie\nfor 20 seconds!\n\n\n\n\n\n\n\n\n\n\n", "", "");
               }
            }
         }
      }
   }
   if (attacker.rune == RUNE_ZOMBIE) {
      if (!(attacker.status_flag & ITEM_SECOND_RUNE)) {
         if (random() < 0.5) {
            if (targ.classname == "player") {
               if (!teamplay || (attacker.team != targ.team) || 
               (attacker == targ)) {
                 targ.runeb_rune = RUNE_DEATH;
                 targ.runeb_time = time + 20;
                 UpdatePlayerStatus(targ, "You've been turned into a zombie\nfor 20 seconds!\n\n\n\n\n\n\n\n\n\n\n", "", "");
               }
            }
         }
      }
   }

   // CHECK:  *INFERNO* if the smoke rune is there
   if (attacker.rune == RUNE_SMOKE && (attacker.status_flag & ITEM_SECOND_RUNE) &&
   random() < 0.3 && targ.classname == "player" && (!teamplay || attacker.team != targ.team || targ == attacker)) {
           targ.runeb_rune = RUNE_SMOKE;
           targ.runeb_time = time + 30;
           if (!targ.clone_use) {
                   targ.clone=spawn();
                   targ.clone.classname = "smoke block";
                   setmodel(targ.clone, "progs/oldone.mdl");
                   makevectors(targ.v_angle);
                   UpdatePlayerStatus(targ, "You've been smoked for 30 seconds!\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
                   targ.clone_use = 1;
           }
   }

   // KEY: check to see if the person has the cops' rune
   if (attacker.rune == RUNE_COP && !(attacker.status_flag & ITEM_SECOND_RUNE) &&
   random() < 0.3 && targ.classname == "player" && targ != attacker &&
   (!teamplay || targ.team != attacker.team)) {
           targ.runeb_rune = RUNE_COP;
           targ.runeb_time = time + 10;
           UpdatePlayerStatus(targ, "You've been arrested and your weapon\ntaken away for 10 seconds!\n\n\n\n\n\n\n\n\n\n\n", "", "");
   }

   // KEY: check to see if the person has the poseidon's rune
   if (attacker.rune == RUNE_POSEIDON &&
   (attacker.status_flag & ITEM_SECOND_RUNE) && random() < 0.5 &&
   targ.classname == "player" && targ != attacker && (!teamplay || attacker.team != targ.team)) {
           
           targ.runeb_rune = RUNE_POSEIDON;
           targ.runeb_time = time + 15;
           UpdatePlayerStatus(targ, "You've been turned into a fish\nfor 15 seconds!\n\n\n\n\n\n\n\n\n\n\n", "", "");
   }

   // KEY: check to see if the person has the mars' rune
   if (attacker.rune == RUNE_MARS && (attacker.status_flag & ITEM_SECOND_RUNE) && random() < 0.5 && targ.classname == "player" && targ != attacker) {
           targ.runeb_rune = RUNE_MARS;
           targ.runeb_time = time + 10;
           UpdatePlayerStatus(targ, "You've been cursed for 10 seconds!\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
           if ((teamplay) && targ.team == attacker.team) {
                   targ.runeb_time = time;
                   targ.runeb_rune = 0;
           }
   }

	// *XXX* EXPERT CTF mark players who hurt the flag carrier, so they 
	// are worth more points for a while.
 	if ( (attacker.classname == "player") && // attacker must be a player
 	     (targ.player_flag & ITEM_ENEMY_FLAG) && // target is a flag carrier
 	     (attacker.lastteam != targ.lastteam) && // target and attacker on diff teams
 	     (targ.lastteam > 0) ) // unconnected check?
 		attacker.last_hurt_carrier = time;
 
   // save damage based on the target's armor level

   // *TEAMPLAY*
   // TeamArmorDam returns true iff the attacker can damage the target's armor

	if (TeamArmorDam(targ, inflictor, attacker, damage))
		save = ceil(targ.armortype*damage);
	else
		save = 0;

	if (save >= targ.armorvalue)
	{
		save = targ.armorvalue;
		targ.armortype = 0;	// lost all armor
		targ.items = targ.items - (targ.items & (IT_ARMOR1 | IT_ARMOR2 | IT_ARMOR3));
	}
	
	targ.armorvalue = targ.armorvalue - save;
	take = ceil(damage-save);

   //RUNE check if the person has white magic
   if (targ.rune == RUNE_WHITE_MAGIC && 
      !(targ.status_flag & ITEM_SECOND_RUNE) && 
      (attacker != targ)) {
      if (attacker != world)
         attacker.reason_died = "mirror damage";
      if (attacker.rune != RUNE_WHITE_MAGIC)
      {
         if(targ.rune_power==RUNE_WHITE_MAGIC)
            T_Damage(attacker,asap,targ,damage*2);
         else T_Damage(attacker, asap, targ, damage/2);
      }
      if (attacker != world)
         attacker.reason_died="";
		if (targ.invincible_sound < time) {
			sound (targ, CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM);
			targ.invincible_sound = time + 2;
		}
   }

   // check to see if flying is enabled (cause player is slower)
   if ((targ.rune == RUNE_BLACK_MAGIC) && (targ.status_flag & ITEM_SECOND_RUNE))
      take = take / 3;

   //RUNE

   // add to the damage total for clients, which will be sent as a single
   // message at the end of the frame
   // FIXME: remove after combining shotgun blasts?
	if (targ.flags & FL_CLIENT)
	{
		targ.dmg_take = targ.dmg_take + take;
		targ.dmg_save = targ.dmg_save + save;
		targ.dmg_inflictor = inflictor;
	}

   // figure momentum add
	if ( (inflictor != world) && (targ.movetype == MOVETYPE_WALK) )
	{
		dir = targ.origin - (inflictor.absmin + inflictor.absmax) * 0.5;
		dir = normalize(dir);
      targ.velocity = targ.velocity + dir*damage*8;
	}

   // check if the person has regen rune
   if (attacker.rune == RUNE_ELDER_MAGIC && (attacker.status_flag & ITEM_SECOND_RUNE)) {
           if (teamplay && attacker.team == targ.team && targ.classname == "player" && attacker != targ) {
                   if (targ.health <= 250) {
                           targ.health = targ.health + 4;
                           UpdatePlayerStatus(targ, attacker.netname, " is healing you!\n\n\n\n\n\n\n\n\n\n\n\n", "");
                           RegenerationSound();
                   }
           } else if (attacker.health < 300 && targ != attacker && targ.classname == "player") {
                           if(attacker.health + take > 300)attacker.health=300;
                           else attacker.health = attacker.health + take;
                           UpdatePlayerStatus(targ, attacker.netname, " is sucking your blood!\n\n\n\n\n\n\n\n\n\n\n\n", "");
                           RegenerationSound();
           }
   }

   // check if the person has vampire rune
   if (attacker.rune == RUNE_VAMPIRE && attacker != targ) {// && (attacker.status_flag & ITEM_SECOND_RUNE)) {
           if ((teamplay) && (attacker.team == targ.team) && (targ.classname == "player")) {
                   if (targ.health <= 250) {
                           targ.health = targ.health + 4;
                           ncenterprint(targ, attacker.netname, " is on your side!", "", "", "", "", "");
                           RegenerationSound();
                   }
           } else if ((attacker.health < 300) && (targ != attacker) && (targ.classname == "player")) {
                           if (attacker.health + take > 300)
                                   attacker.health = 300;
                           else attacker.health = attacker.health + take;
                           UpdatePlayerStatus(targ, attacker.netname, " is a vampire and is\namong you!\n\n\n\n\n\n\n\n\n\n\n", "");
                           RegenerationSound();
           }
   }

   // check for godmode or invincibility
	if (targ.flags & FL_GODMODE)
		return;

   // KEY:  Power of Armor - Super Power, they don't get hurt as much
   if ((targ == attacker) && (targ.rune == RUNE_ARMOR) && (targ.status_flag & ITEM_SECOND_RUNE) && (inflictor.classname != "lightning gun"))
                return;

	if (targ.invincible_finished >= time)
	{
		if (self.invincible_sound < time)
		{
			sound (targ, CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM);
			self.invincible_sound = time + 2;
		}
		return;
	}

   // team play damage avoidance
   if ((teamplay == 1) && (targ.team > 0)&&(targ.team == attacker.team)) 
		return;
		
   // *TEAMPLAY*
   // TeamHealthDam will return true if the attacker can damage the target's
   // health

   if (!TeamHealthDam(targ, inflictor, attacker, damage))
      return;
		
   // adds to the powerlevel
   if(attacker.classname=="player" &&
      targ.classname=="player" &&
      (!teamplay || (targ.team!=attacker.team)) &&
      targ.classname!="ghost clone"){
           f1=attacker.powerlevel;  // store their current powerlevel
           if(take>=60){attacker.powerhealth=0;attacker.powerlevel=attacker.powerlevel+1;}
           else attacker.powerhealth=attacker.powerhealth+take;
           if(attacker.powerhealth>=60){attacker.powerhealth=0;attacker.powerlevel=attacker.powerlevel+1;}
           if(attacker.powerlevel>PMAX)attacker.powerlevel=PMAX;//don't over power the person
           //update the status if needed
           if(attacker.powerlevel>f1)UpdatePlayerStatus(attacker,"\n\n\n\n\n\n\n\n\n\n\n\n","","");
   }

   // do the damage
	targ.health = targ.health - take;
			
   if (targ.health <= 0)
	{
      Killed (targ, attacker, inflictor);
		return;
	}

   // react to the damage
	oldself = self;
	self = targ;

	if (self.th_pain)
   {
      // tarant poison give a big head, that looks funny if 
      // the pain frames are played.
      if (!self.bigHead)
   		self.th_pain (attacker, take);
      else
         PainSound();   // just the sound, no motion
   }
	self = oldself;
};

/*
============
DamageRadius
============
instead of T_RadiusDamage, this will spread the same amount of damage
if possible to the given people
*/
void(entity inflictor, entity attacker, entity ignore, float rad, float damage) DamageRadius =
{
        local entity e1;  // we do need a pointer

        e1 = findradius(inflictor.origin, rad);
        while (e1) {
                if (e1.classname == "player" && CanDamage(e1, inflictor) && e1 != ignore) {
                        T_Damage(e1, inflictor, attacker, damage);
                        if (inflictor.classname == "mind gas") {//extra special
                                e1.punchangle_y = random()*180 - 90;
                                e1.punchangle_z = random()*60 - 30;
                        }
                }
                e1 = e1.chain;
        }
};

/*
============
T_RadiusDamage
============
*/
void(entity inflictor, entity attacker, float damage, entity ignore) T_RadiusDamage =
{
	local	float 	points;
	local	entity	head;
	local	vector	org;

	head = findradius(inflictor.origin, damage+40);
	
	while (head)
	{
		if (head != ignore)
		{
			if (head.takedamage)
			{
				org = head.origin + (head.mins + head.maxs)*0.5;
				points = 0.5*vlen (inflictor.origin - org);
				if (points < 0)
					points = 0;
				points = damage - points;
				if (head == attacker)
					points = points * 0.5;
				if (points > 0)
				{
					if (CanDamage (head, inflictor))
                                        {
                                                if (inflictor.classname == "lightning gun" && head.waterlevel)
                                                        T_Damage (head, inflictor, attacker, points);
                                                else if (inflictor.classname != "lightning gun")
							T_Damage (head, inflictor, attacker, points);
					}
				}
			}
		}
		head = head.chain;
	}
};

/*
============
T_BeamDamage
============
*/
void(entity attacker, float damage) T_BeamDamage =
{
	local	float 	points;
	local	entity	head;
	
	head = findradius(attacker.origin, damage+40);
	
	while (head)
	{
		if (head.takedamage)
		{
			points = 0.5*vlen (attacker.origin - head.origin);
			if (points < 0)
				points = 0;
			points = damage - points;
			if (head == attacker)
				points = points * 0.5;
			if (points > 0)
			{
				if (CanDamage (head, attacker))
				{
					if (head.classname == "monster_shambler")						
						T_Damage (head, attacker, attacker, points*0.5);
					else
						T_Damage (head, attacker, attacker, points);
				}
			}
		}
		head = head.chain;
	}
};

