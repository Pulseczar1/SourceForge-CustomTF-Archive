/*
**
** _shrapnel.qc (Shrapnel Code, 1.0)
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

// void(entity player) ShrapnelInfo =
// {
// 
// };

// void(entity player) ShrapnelInit =
// {
//   
// };

// void(entity player) ShrapnelActiveMessage =
// {
//   
// };

// void(entity player) ShrapnelHelp =
// {
//  
// };

//==============================================================
//   ShrapnelPrecacheSounds
//==============================================================

void() ShrapnelPrecacheSounds =
{
  shrapnel_launch_sound_1 = "weapons/sgun1.wav";
  shrapnel_launch_sound_2 = "knight/sword1.wav";
  shrapnel_explode_sound  = "weapons/sgun1.wav";
  precache_sound (shrapnel_launch_sound_1);
  precache_sound (shrapnel_launch_sound_2);
  precache_sound (shrapnel_explode_sound);
};

//========================================================================
//   ShrapnelToggleWeapon
//========================================================================

// void(entity player) ShrapnelToggleWeapon =
// {
  
  
 // if (player.modules_weapon & MODULES_WEAPON_SHRAPNEL) {
 //   player.modules_weapon = player.modules_weapon - MODULES_WEAPON_SHRAPNEL;
 //   player.items = player.items - (player.items & IT_KEY1);
 // } else {
 //   if ((player.weapon == IT_ROCKET_LAUNCHER) && (player.ammo_rockets >= 1)) {
 //     player.modules_weapon = player.modules_weapon | MODULES_WEAPON_SHRAPNEL;
 //     player.items = player.items | IT_KEY1;
 //   }
  //}
// };

//========================================================================
//   ShrapnelResetWeapon
//========================================================================

// void(entity player) ShrapnelResetWeapon =
// {
  
 // if (player.modules_weapon & MODULES_WEAPON_SHRAPNEL) {
 //   player.modules_weapon = player.modules_weapon - MODULES_WEAPON_SHRAPNEL;
 //   player.items = player.items - (player.items & IT_KEY1);
//  }
// };

//==================================================================
//   ShrapnelMissileFire
//==================================================================

void() ShrapnelMissileFire =
{
  local entity proj,flame;

   if (self.ammo_rockets < 1) 
   {
      bprint("Not enough ammo\n");
      return;
   }	   
  
  self.currentammo = self.ammo_rockets = self.ammo_rockets - 1;
  W_SetCurrentAmmo ();
  
  self.punchangle_x = -2;
  makevectors (self.v_angle);
  
  proj                 = spawn();
  proj.classname       = "shrapnel projectile";
  proj.owner           = self;
  proj.shrapnel_owner  = self;
  proj.movetype        = MOVETYPE_FLYMISSILE;
  proj.solid           = SOLID_BBOX;
  proj.velocity        = aim(self,850);
  proj.velocity        = proj.velocity * 850;
  proj.angles          = vectoangles(proj.velocity);
  proj.angles_x        = proj.angles_x + 180;
  proj.touch           = ShrapnelMissileTouch;
  proj.think           = SUB_Remove;
  proj.nextthink       = time + 6;
  proj.ltime           = time + 6;
  // proj.modules_weapon  = MODULES_WEAPON_SHRAPNEL;
  setmodel(proj, "progs/grenade.mdl");
  setsize(proj, '0 0 0', '0 0 0');		
  // setorigin(proj, self.origin + v_forward*36 + '0 0 14');
  setorigin (proj, self.origin + v_forward*8 + '0 0 16');

  flame           = spawn();
  flame.classname = "shrapnel flame";
  flame.owner     = proj.owner;
  flame.origin    = proj.origin;
  flame.velocity  = proj.velocity;
  flame.movetype  = proj.movetype;
  flame.solid     = proj.solid;
  flame.think     = SUB_Remove;
  flame.touch     = SUB_Remove;
  flame.nextthink = proj.ltime;
  flame.ltime     = proj.ltime;
  flame.angles     = vectoangles(flame.velocity);
  flame.angles_x   = flame.angles_x + 90;
  flame.frame      = 1;
  setmodel (flame, "progs/flame2.mdl");
  setsize (flame, '0 0 0', '0 0 0');
  setorigin(flame, self.origin + v_forward*18 + '0 0 14');
  
  sound (self, CHAN_WEAPON, shrapnel_launch_sound_1, 0.7, ATTN_NORM);
  sound (proj, CHAN_BODY  , shrapnel_launch_sound_2, 1, ATTN_NORM);
   if (self.ammo_rockets < 1) 
   {
      self.weapon = W_BestWeapon ();
      self.nweapon = W_BestNWeapon(self.weapon);
      W_SetCurrentAmmo ();
   }	   
};

//==================================================================
//   ShrapnelBounceDirection
//==================================================================

void() ShrapnelBounceDirection =
{
  local vector vo,vn;

  vn = normalize(self.velocity);
  vo = self.origin - vn;
  vn = self.origin + vn;
  traceline(vo, vn, TRUE,self);
  v_forward = normalize(self.velocity - 2*(self.velocity*trace_plane_normal)*trace_plane_normal);
  v_forward_z = v_forward_z * (-1);  // ?????????????
};

//==================================================================
//   ShrapnelMissileTouch
//==================================================================

void() ShrapnelMissileTouch =
{
  local float damg,r;
  local vector v;

  //dprint("ShrapnelMissileTouch\n");

  if (pointcontents(self.origin) == CONTENT_SKY) {
    remove(self);
    return;
  }

  sound (self, CHAN_WEAPON, shrapnel_explode_sound, 0.7, ATTN_NORM);

  if (other.solid == SOLID_BSP) {
    r = random();
    damg = 60 + r*10;
    T_RadiusDamage (self,self.owner,damg,world);
    if (r > 0.5) BurnSetOnFire(other,self.owner,"Shrapnel Fire");       //#jp#(Burn)
  }

  ShrapnelBounceDirection();
  v = vectoangles(v_forward);
  makevectors(v);
  v = v_forward;
  ShrapnelDebrisFire(v_forward);
  v = normalize(v_forward + 1.5*(0.5-random())*v_up + 1.5*(0.5-random())*v_right); 
  ShrapnelDebrisFire(v);
  v = normalize(v_forward + 1.5*(0.5-random())*v_up + 1.5*(0.5-random())*v_right); 
  ShrapnelDebrisFire(v);
  if (r>0.5) {
    v = normalize(v_forward + 1.5*(0.5-random())*v_up + 1.5*(0.5-random())*v_right); 
     ShrapnelDebrisFire(v);
  }
  if (r>0.6) {
    v = normalize(v_forward + 1.5*(0.5-random())*v_up + 1.5*(0.5-random())*v_right); 
     ShrapnelDebrisFire(v);
  }
  if (r>0.7) {
    v = normalize(v_forward + 1.5*(0.5-random())*v_up + 1.5*(0.5-random())*v_right); 
     ShrapnelDebrisFire(v);
  }
  self.origin = self.origin - 4 * normalize(self.velocity);
  BecomeExplosion();
};

//==================================================================
//   ShrapnelDebrisFire
//==================================================================

float SHRAPNEL_DEBRIS_VELOCITY = 600;

entity(vector vel) ShrapnelDebrisFire =
{
   local entity debris;

   debris = spawn();
   debris.origin         = self.origin;
   debris.classname      = "shrapnel debris";
   debris.owner          = world;
   debris.shrapnel_owner   = self.shrapnel_owner;
   debris.velocity       = vel*SHRAPNEL_DEBRIS_VELOCITY;
   debris.angles         = vectoangles(debris.velocity);
   debris.angles_x       = debris.angles_x + 90;
   debris.movetype       = MOVETYPE_FLYMISSILE;
   debris.solid          = SOLID_BBOX;
   debris.think          = ShrapnelDebrisThink;
   debris.touch          = ShrapnelDebrisTouch;
   debris.ltime          = time + 1.0 + random()*0.3;
   debris.nextthink      = debris.ltime + 2;
   // debris.modules_weapon = MODULES_WEAPON_SHRAPNEL;
   debris.effects        = EF_DIMLIGHT;
   setmodel (debris, "progs/flame2.mdl");
   setsize (debris, '0 0 0', '0 0 0');
   setorigin (debris, debris.origin);
   return(debris);
};

//==================================================================
//   ShrapnelDebrisExplode
//==================================================================

void() ShrapnelDebrisExplode1 = [0, ShrapnelDebrisExplode2] {};
void() ShrapnelDebrisExplode2 = [3, ShrapnelDebrisExplode3] {};
void() ShrapnelDebrisExplode3 = [4, SUB_Remove]   {};

float SHRAPNEL_DAMAGE_RADIUS = 70;

void(float do_damage) ShrapnelDebrisExplode = 
{
  local entity e;
  local float r,d,db;

  if (do_damage) {
    self.owner = self.shrapnel_owner;
    if (other.takedamage) { spawn_touchblood (9); }
    e = findradius(self.origin, SHRAPNEL_DAMAGE_RADIUS);
    while (e) {
      if (e.takedamage) {
	if (e.takedamage != DAMAGE_AIM) {
	  T_Damage (e, self, self.owner, 10);
	} else {
	  r  = random();
	  db = 35 + (0.5 - r)*5;
	  d  = vlen(e.origin + '0 0 16' - self.origin);
	  if      (d<SHRAPNEL_DAMAGE_RADIUS - 2*db) d = db;
	  else if (d<SHRAPNEL_DAMAGE_RADIUS) d = (SHRAPNEL_DAMAGE_RADIUS-d)*0.5;
	  else d = 0;
	  if (d) {
	    T_Damage (e, self, self.owner, d);
	    if (r > 0.66) {			//#jp#(Burn)
	      if (d > 6) {			//#jp#(Burn)
                BurnSetOnFire(e,self.owner,"Shrapnel Fire");    //#jp#(Burn)
	      }					//#jp#(Burn)
	    }					//#jp#(Burn)
	  }
	}
      }
      e = e.chain;
    }
    self.owner   = world;
  }

  self.classname = "shrapnel explosion";
  self.origin    = self.origin - 4 * normalize(self.velocity);
  self.movetype  = MOVETYPE_NONE;
  self.velocity  = '0 0 0';
  self.touch     = SUB_Null;
  self.solid     = SOLID_NOT;
  self.think     = SUB_Remove;  // be on the
  self.nextthink = time + 4;    // safe side
  setmodel(self, "progs/s_explod.spr");
  setorigin(self, self.origin);

  ShrapnelDebrisExplode1();
};


//==================================================================
//   ShrapnelDebrisTouch
//==================================================================

void() ShrapnelDebrisTouch =
{
  local float r,do_damage,play_sound;
  local vector v;
  local entity e, self_old;

  //dprint("lamerDebrisTouch"\n);
  //dprint(other.classname); dprint("\n");

  if (pointcontents(self.origin) == CONTENT_SKY) {
    remove(self);
    return;
  }

  if (time > self.shrapnel_bounce_time + 0.1) {
    ShrapnelBounceDirection();
    self.movetype  = MOVETYPE_BOUNCE;
    self.velocity  = self.velocity + (v_forward*self.velocity)*v_forward;
    self.nextthink = time;
    self.angles    = vectoangles(self.velocity);
    self.angles_x  = self.angles_x + 90;
  } else self.ltime = time;

  do_damage  = FALSE;
  play_sound = 0;
  if (other.solid != SOLID_BSP) {
    e = self;
    do_damage = TRUE;
    play_sound = 1;
  }
  else if (time < self.ltime) {
    if (time > self.shrapnel_damage_time + 0.1) {
      do_damage = TRUE;
      self.shrapnel_damage_time = time;
    }
    if (time > self.shrapnel_sound_time + 0.1) {
      self.shrapnel_sound_time = time;
      play_sound = 1;
    }
    e                = spawn();
    e.origin         = self.origin;
    e.velocity       = self.velocity;
    e.shrapnel_owner   = self.shrapnel_owner;
    // e.modules_weapon = MODULES_WEAPON_SHRAPNEL;
    e.effects        = EF_DIMLIGHT;
    setsize (e, '0 0 0', '0 0 0');
  } else {
    e = self;
    play_sound = 1;
    do_damage = TRUE;
  }
  self_old = self;
  self = e;
  if (play_sound) sound (self, CHAN_WEAPON, shrapnel_explode_sound, 0.6, ATTN_NORM);
  ShrapnelDebrisExplode(do_damage);
  self = self_old;
};

//==================================================================
//   ShrapnelDebrisThink
//==================================================================

void() ShrapnelDebrisThink =
{
  local entity other_old;

  if (time < self.ltime + 2) {
    if (vlen(self.velocity) > 100) {
      self.flags     = self.flags - (self.flags & FL_ONGROUND);
      self.velocity  = normalize(self.velocity) * SHRAPNEL_DEBRIS_VELOCITY;
      self.movetype  = MOVETYPE_FLYMISSILE;
      self.nextthink = self.ltime + 2;
      self.angles    = vectoangles(self.velocity);
      self.angles_x  = self.angles_x + 90;
      return; 
    }
  }
  other_old = other;
  ShrapnelDebrisExplode(TRUE);
  other = other_old;
};

