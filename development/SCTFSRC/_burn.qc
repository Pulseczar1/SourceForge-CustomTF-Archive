/*
**
** _burn.qc (Burn Code, 1.0)
**
** Copyright (C) 1996, 1997 Johannes Plass
** 
** This program is free software; you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation; either version 2 of the License, or
** (at your option) any later version.
** 
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with this program; if not, write to the Free Software
** Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
** 
** Author:   Johannes Plass (plass@dipmza.physik.uni-mainz.de)
**
*/

void(entity player) BurnInfo =
{
  if (!USE_MODULE_BURN) return;
};

void(entity player) BurnInit =
{
  if (!USE_MODULE_BURN) return;
};

void(entity player) BurnActiveMessage =
{
  if (!USE_MODULE_BURN) return;
              // 123456789#123456789#123456789#12345678
  sprint(player,"  Burn\n");
};

//==============================================================
//   BurnPrecacheSounds
//==============================================================

void() BurnPrecacheSounds =
{
  burn_pain_sound_1     = "player/lburn1.wav";
  burn_pain_sound_2     = "player/lburn2.wav";
  burn_extinguish_sound = "player/slimbrn2.wav";
  burn_light_sound      = "boss1/throw.wav";
  //precache_sound (burn_pain_sound_1);
  //precache_sound (burn_pain_sound_2);
  //precache_sound (burn_extinguish_sound);
  precache_sound (burn_light_sound);
};

//==================================================================
//   BurnMakeBubble
//==================================================================

void() BurnMakeBubble =
{
  local entity        bubble;

  //dprint("BurnMakeBubble\n");
  
  bubble              = spawn();
  bubble.movetype     = MOVETYPE_NOCLIP;
  bubble.solid        = SOLID_NOT;
  bubble.velocity     = '0 0 15';
  bubble.nextthink    = time + 0.5;
  bubble.think        = bubble_bob;
  bubble.classname    = "bubble";
  bubble.owner        = self.owner;
  bubble.frame        = 0;
  bubble.cnt          = 0;
  setmodel (bubble, "progs/s_bubble.spr");
  setorigin (bubble, self.owner.origin + '0 0 24');
  setsize (bubble, '-8 -8 -8', '8 8 8');
  
  self.nextthink      = time + 0.1 + random()*0.2;
  self.think          = BurnMakeBubble;
  self.air_finished   = self.air_finished + 1;
  if (self.air_finished >= self.bubble_count) remove(self);
};


//==================================================================
//   BurnSteam
//==================================================================

void(float num_bubbles) BurnSteam =
{
  local entity steam;
  
  //dprint("BurnSteam\n");
  
  steam              = spawn();
  steam.movetype     = MOVETYPE_NONE;
  steam.solid        = SOLID_NOT;
  steam.nextthink    = time + 0.1;
  steam.think        = BurnMakeBubble;
  steam.air_finished = 0;
  steam.owner        = self.enemy;
  steam.bubble_count = num_bubbles;
  setorigin (steam, self.enemy.origin);
  sound (steam.owner, CHAN_BODY, burn_extinguish_sound, 1, ATTN_NORM);
};

//==================================================================
//   BurnThink
//==================================================================

void (entity victim) RemoveSctfBurnEffects =
{
  victim.effects = victim.effects - (victim.effects & EF_DIMLIGHT);
};

void (entity victim) SubsideSctfBurnEffects =
{
   RemoveSctfBurnEffects(victim);
   UpdatePlayerStatus(victim, "Fire just went out!\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
};

void (entity victim) DrenchSctfBurnEffects =
{
   RemoveSctfBurnEffects(victim);
   UpdatePlayerStatus(victim, "You have put out the fire!\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
};

void (entity victim) NoNapalmSctfBurnEffects =
{
   RemoveSctfBurnEffects(victim);
   UpdatePlayerStatus(victim, "You have escaped the Napalm!\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
};

void (entity victim) ApplySctfBurnEffects =
{
  UpdatePlayerStatus(victim,"You are on fire! Find WATER!\n\n\n\n\n\n\n\n\n\n\n\n", "", "");
  stuffcmd (victim,"bf\n");
  victim.effects = victim.effects | EF_DIMLIGHT;
};


void() BurnThink =
{
  local float damage,r;
  local entity        e;

  //dprint("BurnThink\n");

  if (self.enemy.deadflag != DEAD_NO) {
    if (self.enemy.burn_burning) {
      // if (self.enemy.modules_killweapon != MODULES_WEAPON_BURN) {
      //   self.enemy.burn_burning = 0;
      // } else {
        if (self.enemy.deadflag == DEAD_DEAD) {
          remove(self.burn_flame);
          setorigin(self,self.origin-'0 0 12');
          RemoveSctfBurnEffects(self.enemy);
          BecomeExplosion();
          return;
        }
      // }
    }
  }

  if (time > self.burn_damage_time) {
    if (self.enemy.waterlevel > 1) {
      BurnSteam(8);
      self.enemy.burn_burning = 0;
      DrenchSctfBurnEffects(self.enemy);
    }
    if (self.enemy.burn_burning) {
      damage = 0;
      if (self.enemy.burn_burning & 1) {
        damage = damage + 3;
        if (time > self.burn_lifetime1) self.enemy.burn_burning = self.enemy.burn_burning - 1;
        if (!self.enemy.burn_burning) SubsideSctfBurnEffects(self.enemy);
      }
      if (self.enemy.burn_burning & 2) {
        damage = damage + 3;
        if (time > self.burn_lifetime2) self.enemy.burn_burning = self.enemy.burn_burning - 2;
        if (!self.enemy.burn_burning) SubsideSctfBurnEffects(self.enemy);
      }
      if (self.enemy.burn_burning & 4) {
        damage = damage + 3;
        if (time > self.burn_lifetime4) self.enemy.burn_burning = self.enemy.burn_burning - 4;
        if (!self.enemy.burn_burning) SubsideSctfBurnEffects(self.enemy);
      }
      r = random();
      if (damage > 0 && self.enemy.health > 0) 
      T_Damage (self.enemy, self, self.owner, damage);

      // not sure if this will be handled correctly in sctf
      e = findradius(self.enemy.origin+'0 0 18', 50);
      while (e) {
        if (e != self.enemy) {
          if (e.takedamage == DAMAGE_AIM) {
            T_Damage (e, self, self.enemy, 6+r*4);
            if (r > 0.5) { BurnSetOnFire(e,self.enemy, self.classname); }
          }
        }
        e = e.chain;
      }
    }
    self.burn_damage_time = time + 1;
  }

  // check for organ donor line of sight
  if (self.enemy.burn_burning) {
     if (self.classname == "ODFire") {
        traceline(self.enemy.origin, self.owner.origin, TRUE, self.enemy);
        if (trace_fraction < 1) {
           NoNapalmSctfBurnEffects(self.enemy);
           self.enemy.burn_burning = 0;
        }
     }
  }         

  if (self.enemy.burn_burning) {
     local vector vf,vr;
     makevectors(self.enemy.v_angle);
     vf = (crandom()*2) * v_forward;
     vr = (crandom()*4) * v_right;
     self.origin = self.enemy.origin + '0 0 18' - 7*v_forward + vf + vr; 
     self.burn_flame.origin = self.enemy.origin + '0 0 18' - 7*v_forward - vf - vr; 
     if (self.enemy.deadflag != DEAD_NO) {
       self.origin = self.origin - '0 0 12';
       self.burn_flame.origin = self.burn_flame.origin - '0 0 12';
     }
     setorigin(self,self.origin);
     setorigin(self.burn_flame,self.burn_flame.origin);
     self.nextthink = time + 0.02;
     return;
  }
  remove(self.burn_flame);
  remove(self);
};

//==================================================================
//   BurnSetOnFire
//==================================================================

void () barrel_explode; // defined in misc.qc

void(entity victim, entity attacker, string burnClassName) BurnSetOnFire =
{
  local entity flame;
  local float r;

  if (!USE_MODULE_BURN) return;

  //dprint("BurnSetOnFire\n");

  if (victim.entityType != PLAYER_TYPE) return;  
  if (victim.waterlevel > 1) return;
  if (victim.invincible_finished >= time) return;
  // if (victim.protect_finished >= time) return; //#jp#(Protect)
  if (victim.classname == "drone") return;     //#jp#(Drone)
  if (victim.th_die == barrel_explode) return;
  if (victim.health <= 0) return;
  // if (USE_MODULE_CTF) {                         //#jp#(Ctf)
  if (teamplay) {                         //#jp#(Ctf)
    // if (victim.ctf_team == attacker.ctf_team) { //#jp#(Ctf)
    if (victim.team == attacker.team) { //#jp#(Ctf)
      if (victim != attacker) return;           //#jp#(Ctf)
    }                                           //#jp#(Ctf)
  }                                             //#jp#(Ctf)

  if (!victim.burn_burning) {
    flame                 = spawn ();
    flame.owner           = attacker;
    flame.enemy           = victim;
    flame.movetype        = MOVETYPE_NONE;
    flame.velocity        = '0 0 0';
    flame.solid           = SOLID_NOT;
    flame.ltime           = time + 10;
    flame.classname       = "burn_flame";
    flame.origin          = victim.origin + '-4 0 18';
    flame.think           = BurnThink;
    flame.nextthink       = time+0.1;
    // flame.modules_weapon  = MODULES_WEAPON_BURN;
    flame.effects         = flame.effects | EF_DIMLIGHT;
    setmodel (flame, "progs/flame2.mdl");
    flame.frame           = 1;
    setsize (flame, '0 0 0', '0 0 0');            
    setorigin (flame, victim.origin+'-4 0 18');
    victim.burn_flame = flame;

    local entity flame2;
    flame2                 = spawn ();
    flame2.owner           = attacker;
    flame2.enemy           = victim;
    flame2.movetype        = MOVETYPE_NONE;
    flame2.velocity        = '0 0 0';
    flame2.solid           = SOLID_NOT;
    flame2.ltime           = time + 15;
    flame2.origin          = victim.origin + '4 0 18';
    flame2.think           = SUB_Null;
    setmodel (flame2, "progs/flame2.mdl");
    flame2.frame           = 1;
    setsize (flame2, '0 0 0', '0 0 0');            
    setorigin (flame2, victim.origin+'4 0 18');
    victim.burn_flame2 = flame2;
    flame.burn_flame = flame2;
  }
  else flame = victim.burn_flame;
  
  if (victim.burn_burning == 7) {
    if (flame.burn_lifetime1 <= flame.burn_lifetime2) {
      if (flame.burn_lifetime1 <= flame.burn_lifetime4) {
        flame.burn_lifetime1 = time + 15;
      }
    }
    else if (flame.burn_lifetime2 <= flame.burn_lifetime4) {
      if (flame.burn_lifetime2 <= flame.burn_lifetime1) {
        flame.burn_lifetime2 = time + 15;
      }
    }
    else flame.burn_lifetime4 = time + 15;
  }
  else if (!(victim.burn_burning & 1)) {
    flame.burn_lifetime1 = time + 15;
    victim.burn_burning = victim.burn_burning | 1;
  }
  else if (!(victim.burn_burning & 2)) {
    flame.burn_lifetime2 = time + 15;
    victim.burn_burning = victim.burn_burning | 2;
  }
  else {
    flame.burn_lifetime4 = time + 15;
    victim.burn_burning = victim.burn_burning | 4;
  }
  sound (flame, CHAN_WEAPON, burn_light_sound, 1, ATTN_NORM);

  // these are the sctf effects
  ApplySctfBurnEffects (victim);
  flame.classname = burnClassName;

};

//==================================================================
//   BurnPainSound
//==================================================================

void() BurnPainSound =
{
  if (time < self.burn_painsound_time) return;
  if (random() > 0.5) sound (self, CHAN_VOICE, burn_pain_sound_1, 1, ATTN_NORM);
  else                sound (self, CHAN_VOICE, burn_pain_sound_2, 1, ATTN_NORM);
  self.burn_painsound_time = time+0.8;
};







