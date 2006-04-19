
void() T_MissileTouch;
void() info_player_start;
void(entity targ, entity attacker) ClientObituary;

// TeamFortress Prototypes
void(entity Goal, entity AP, float addb) DoResults;
float(entity Goal, entity AP) Activated;
void() monster_death_use;
float (entity targ, entity attacker, float damage) TeamEqualiseDamage;

#ifndef COOP_MODE

/*================
monster_death_use (from monsters.qc)

When a monster dies, it fires all of its targets with the current
enemy as activator.
================
*/
void() monster_death_use =
{
	local entity 	ent, otemp, stemp;

	// fall to ground
	if (self.flags & #FL_FLY)
		self.flags = self.flags - #FL_FLY;
	if (self.flags & #FL_SWIM)
		self.flags = self.flags - #FL_SWIM;

	if (!self.target)
		return;

	activator = self.enemy;
	SUB_UseTargets ();
};
#endif


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
	if (targ.movetype == #MOVETYPE_PUSH)
	{
		traceline(inflictor.origin, 0.5 * (targ.absmin + targ.absmax), #TRUE, self);
		if (trace_fraction == 1)
			return #TRUE;
		if (trace_ent == targ)
			return #TRUE;
		return #FALSE;
	}
	
	traceline(inflictor.origin, targ.origin, #TRUE, self);
	if (trace_fraction == 1)
		return #TRUE;
	traceline(inflictor.origin, targ.origin + '15 15 0', #TRUE, self);
	if (trace_fraction == 1)
		return #TRUE;
	traceline(inflictor.origin, targ.origin + '-15 -15 0', #TRUE, self);
	if (trace_fraction == 1)
		return #TRUE;
	traceline(inflictor.origin, targ.origin + '-15 15 0', #TRUE, self);
	if (trace_fraction == 1)
		return #TRUE;
	traceline(inflictor.origin, targ.origin + '15 -15 0', #TRUE, self);
	if (trace_fraction == 1)
		return #TRUE;

	return #FALSE;
};


/*
============
Killed
============
*/
void(entity targ, entity attacker) Killed =
{
	local entity oself;
	local string db;

	oself = self;
	self = targ;
	
	// don't let sbar look bad if a player
	if (self.health < -99)
		self.health = -99;		

	// doors, triggers, etc
	if (self.movetype == #MOVETYPE_PUSH || self.movetype == #MOVETYPE_NONE)
	{	
		self.th_die ();
		self = oself;
		return;
	}

	self.enemy = attacker;

	// bump the monster counter
	if (self.flags & #FL_MONSTER)
	{
		killed_monsters = killed_monsters + 1;
		WriteByte (#MSG_ALL, #SVC_KILLEDMONSTER);
	}

	ClientObituary(self, attacker);
	
	self.takedamage = #DAMAGE_NO;
	self.touch = SUB_Null;

	monster_death_use();
	self.th_die ();

	self = oself;
};


/*
============
T_Damage

The damage is coming from inflictor, but get mad at attacker
This should be the only function that ever reduces health.
============
*/
void(entity targ, entity inflictor, entity attacker, float damage) T_Damage =
{
	local	vector	dir;
	local	entity	oldself, te;
	local	float	save;
	local	float	take;

	if (!targ.takedamage)
		return;

	if (attacker.classname == "player")
		damage = damage * 0.9;

	if (attacker.classname == "player")
	{
		if (targ.classname != "player" && targ.classname != "bot")
		{
			if (!Activated(targ,attacker))
			{
				// If an else goal should be activated, activate it
				if (targ.else_goal != 0)
				{
					te = Findgoal(targ.else_goal);
					if (te)
						DoResults(te, attacker, (targ.goal_result & #TFGR_ADD_BONUSES));
				}

				return;
			}
		}
	}

// used by buttons and triggers to set activator for target firing
	damage_attacker = attacker;

// check for quad damage powerup on the attacker
	if (attacker.super_damage_finished > time)
		damage = damage * 4;

	if (teamplay & (#TEAMPLAY_LESSSCOREHELP | #TEAMPLAY_LESSPLAYERSHELP))
		damage = TeamEqualiseDamage(targ, attacker, damage);

// save damage based on the target's armor level

	save = ceil(targ.armortype*damage);
	if (save >= targ.armorvalue)
	{
		save = targ.armorvalue;
		targ.armortype = 0;	// lost all armor
		targ.armorclass = 0; // lost special armor
		targ.items = targ.items - (targ.items & (#IT_ARMOR1 | #IT_ARMOR2 | #IT_ARMOR3));
	}
	
	targ.armorvalue = targ.armorvalue - save;
	take = ceil(damage-save);

// add to the damage total for clients, which will be sent as a single
// message at the end of the frame
// FIXME: remove after combining shotgun blasts?
	if (targ.flags & #FL_CLIENT)
	{
		targ.dmg_take = targ.dmg_take + take;
		targ.dmg_save = targ.dmg_save + save;
		targ.dmg_inflictor = inflictor;
	}

// figure momentum add
	if ( (inflictor != world) && (targ.movetype == #MOVETYPE_WALK) )
	{
		// give them some immunity to cheat check
		targ.immune_to_check = time + (damage / 20);

		dir = targ.origin - (inflictor.absmin + inflictor.absmax) * 0.5;
		dir = normalize(dir);

#ifdef QUAKE_WORLD
		// Set kickback for smaller weapons
		// Read: only if it's not yourself doing the damage
		if ( (damage < 60) & ((attacker.classname == "player") & (targ.classname == "player")) & ( attacker.netname != targ.netname)) 
			targ.velocity = targ.velocity + dir * damage * 11;
		else                        
		// Otherwise, these rules apply to rockets and grenades                        
		// for blast velocity
			targ.velocity = targ.velocity + dir*damage*8;
		// Rocket Jump modifiers
		if ( (rj > 1) & ((attacker.classname == "player") & (targ.classname == "player")) & ( attacker.netname == targ.netname)) 
			targ.velocity = targ.velocity + dir * damage * rj;
#else
		targ.velocity = targ.velocity + dir*damage*8;
#endif
	}

	// check for godmode or invincibility
	if (targ.flags & #FL_GODMODE)
		return;
	if (targ.invincible_finished >= time)
	{
		if (self.invincible_sound < time)
		{
			sound (targ, #CHAN_ITEM, "items/protect3.wav", 1, #ATTN_NORM);
			self.invincible_sound = time + 2;
		}
		return;
	}

	if (attacker.classname == "player" && (targ.classname == "player" || targ.classname == "building_sentrygun"))
	{
		if ((targ.team_no > 0) && (targ.team_no == attacker.team_no) && (targ != attacker))
		{
			if (teamplay & #TEAMPLAY_NOEXPLOSIVE)
				return;
			else if (teamplay & #TEAMPLAY_HALFEXPLOSIVE)
				take = take / 2;	
		}
	}
	
	// do the damage
	if (take < 1)
		take = 1;

	targ.health = targ.health - take;

	if (targ.armorvalue < 1)
	{
		targ.armorclass = 0; // lost special armor
		targ.armorvalue = 0;
	}
			
	if (targ.health <= 0)
	{
		Killed (targ, attacker);
		return;
	}

// react to the damage
	oldself = self;
	self = targ;

	if (self.th_pain)
	{
		self.th_pain (attacker, take);
	// nightmare mode monsters don't go into pain frames often
		if (skill >= 3)
			self.pain_finished = time + 5;		
	}

	self = oldself;
};

 /*
 ============
 TF_T_Damage
 same thing as T_Damage (see above), just with some more details

 T_Flags:
	#TF_TD_IGNOREARMOUR: bypasses the armour of the target
	#TF_TD_NOTTEAM: doesn't damage a team member
	#TF_TD_NOTSELF: doesn't damage self

 The following is used to determine whether this attack is affected 
 the type of armor the defender is wearing.
 T_AttackType:		
	#TF_TD_OTHER			:	type ignored
	#TF_TD_SHOT			: 	bullet damage
	#TF_TD_NAIL			:	nailgun damage
	#TF_TD_EXPLOSION		:	explosion damage
	#TF_TD_ELECTRICITY	:	electricity damage
	#TF_TD_FIRE			:	fire damage

	#TF_TD_NOSOUND		:	Special Value. Health is adjusted without
						    any sound, painframe, etc
							Health is _set_ to damage, not altered.

============
*/
void(entity targ, entity inflictor, entity attacker, float damage, float T_flags, float T_AttackType) TF_T_Damage =
{
	local	vector	dir;
	local	entity	oldself, te;
	local	float	save;
	local	float	take;

	if (!targ.takedamage)
		return;

	if (attacker.classname == "player")
		damage = damage * 0.9;

	if (attacker.classname == "player")
	{
		if (targ.classname != "player" && targ.classname != "bot" && targ.classname != "building_sentrygun" && targ.classname != "building_dispenser")
		{
			if (!Activated(targ,attacker))
			{
				// If an else goal should be activated, activate it
				if (targ.else_goal != 0)
				{
					te = Findgoal(targ.else_goal);
					if (te)
						DoResults(te, attacker, (targ.goal_result & #TFGR_ADD_BONUSES));
				}

				return;
			}
		}
	}

	// used by buttons and triggers to set activator for target firing
	damage_attacker = attacker;

	// check for quad damage powerup on the attacker
	if (attacker.super_damage_finished > time)
		damage = damage * 4;

	if (teamplay & (#TEAMPLAY_LESSSCOREHELP | #TEAMPLAY_LESSPLAYERSHELP))
		damage = TeamEqualiseDamage(targ, attacker, damage);

	// Do armorclass stuff
	if ((targ.armorclass != 0) && (T_AttackType != 0))
	{
		if ((targ.armorclass & #AT_SAVESHOT) && (T_AttackType == #TF_TD_SHOT))
			damage = floor(damage * 0.5);
		else if ((targ.armorclass & #AT_SAVENAIL) && (T_AttackType == #TF_TD_NAIL))
			damage = floor(damage * 0.5);
		else if ((targ.armorclass & #AT_SAVEEXPLOSION) && (T_AttackType == #TF_TD_EXPLOSION))
			damage = floor(damage * 0.5);
		else if ((targ.armorclass & #AT_SAVEELECTRICITY) && (T_AttackType == #TF_TD_ELECTRICITY))
			damage = floor(damage * 0.5);
		else if ((targ.armorclass & #AT_SAVEFIRE) && (T_AttackType == #TF_TD_FIRE))
			damage = floor(damage * 0.5);
	}

	// save damage based on the target's armor level
	if (T_flags & #TF_TD_IGNOREARMOUR)
	{
		take = damage;
		save = 0;
	}
	else
	{
		save = ceil(targ.armortype*damage);
		if (save >= targ.armorvalue)
		{
			save = targ.armorvalue;
			targ.armortype = 0;	// lost all armor
			targ.armorclass = 0; // lost special armor
			targ.items = targ.items - (targ.items & (#IT_ARMOR1 | #IT_ARMOR2 | #IT_ARMOR3));
		}
	
		targ.armorvalue = targ.armorvalue - save;
		take = ceil(damage-save);
	}

	// add to the damage total for clients, which will be sent as a single
	// message at the end of the frame
	// FIXME: remove after combining shotgun blasts?
	if (targ.flags & #FL_CLIENT)
	{
		targ.dmg_take = targ.dmg_take + take;
		targ.dmg_save = targ.dmg_save + save;
		targ.dmg_inflictor = inflictor;
	}

	// figure momentum add
	if ( (inflictor != world) && (targ.movetype == #MOVETYPE_WALK) )
	{
		// Nail Gren doesn't knock ppl
		if (deathmsg != #DMSG_GREN_NAIL || targ.playerclass == #PC_HVYWEAP)
		{
			// give them some immunity to cheat check
			targ.immune_to_check = time + (damage / 20);

			dir = targ.origin - (inflictor.absmin + inflictor.absmax) * 0.5;
			dir = normalize(dir);

	#ifdef QUAKE_WORLD
			// Set kickback for smaller weapons
			// Read: only if it's not yourself doing the damage
			if ( (damage < 60) & ((attacker.classname == "player") & (targ.classname == "player")) & ( attacker.netname != targ.netname)) 
				targ.velocity = targ.velocity + dir * damage * 11;
			else                        
			// Otherwise, these rules apply to rockets and grenades                        
			// for blast velocity
				targ.velocity = targ.velocity + dir*damage*8;
			// Rocket Jump modifiers
			if ( (rj > 1) & ((attacker.classname == "player") & (targ.classname == "player")) & ( attacker.netname == targ.netname)) 
				targ.velocity = targ.velocity + dir * damage * rj;
	#else
			targ.velocity = targ.velocity + dir*damage*8;
	#endif
		}
	}

	// check for godmode or invincibility
	if (targ.flags & #FL_GODMODE)
		return;
	if (targ.invincible_finished >= time)
	{
		if (self.invincible_sound < time)
		{
			sound (targ, #CHAN_ITEM, "items/protect3.wav", 1, #ATTN_NORM);
			self.invincible_sound = time + 2;
		}
		return;
	}

	// team play damage avoidance
	if (attacker.classname == "player" && (targ.classname == "player" || targ.classname == "building_sentrygun"))
	{
		if (T_flags & #TF_TD_NOTTEAM)
		{
			if ((targ.team_no > 0) && (targ.team_no == attacker.team_no) && (targ != attacker))
			{
				if (teamplay & #TEAMPLAY_NODIRECT)
					return;
				else if (teamplay & #TEAMPLAY_HALFDIRECT)
					take = take / 2;	
			}
		}
		else
		{
			if ((targ.team_no > 0) && (targ.team_no == attacker.team_no) && (targ != attacker))
			{
				if (teamplay & #TEAMPLAY_NOEXPLOSIVE)
					return;
				else if (teamplay & #TEAMPLAY_HALFEXPLOSIVE)
					take = take / 2;	
			}
		}
	}

	if (T_flags & #TF_TD_NOTSELF)
	{
		if (targ == attacker)
			return;
	}

	// do the damage, min 1
	if (take < 1)
		take = 1;

	targ.health = targ.health - take;

	if (targ.armorvalue < 1)
	{
		targ.armorclass = 0; // lost special armor
		targ.armorvalue = 0;
	}

	if (targ.health <= 0)
	{
		if (inflictor.classname == "detpack" && inflictor.weaponmode == 1 && inflictor.enemy == targ)
			deathmsg = #DMSG_DETPACK_DIS;
		Killed(targ, attacker);
		return;
	}

	// react to the damage
	oldself = self;
	self = targ;

	if (self.th_pain)
	{
		self.th_pain (attacker, take);
		// nightmare mode monsters don't go into pain frames often
		if (skill >= 3)
			self.pain_finished = time + 5;		
	}

	self = oldself;
};

/*
============
T_RadiusDamage
============
*/
void(entity inflictor, entity attacker, float damage, entity ignore) T_RadiusDamage =
{
	local	float 	points;
	local	entity	head, te; 
	local	vector	org;

	head = findradius(inflictor.origin, damage+40);
	
	while (head)
	{
		if (head != ignore)
		{
			// Check for TeamFortress Goals that can be triggered by Detpacks
			if (head.classname == "info_tfgoal")
			{
				if (inflictor.classname == "detpack")
				{
					// Don't activate timer goals
					if ((head.goal_activation & #TFGA_TOUCH_DETPACK) && (head.search_time == 0))
					{
						traceline (inflictor.origin, head.origin, #TRUE, inflictor);

						if (trace_fraction == 1)
						{
							// Does the AP match the AP Criteria?
							if (Activated(head,attacker))
							{
								DoResults(head, attacker, #TRUE);
							}
							else
							{
								// If an else goal should be activated, activate it
								if (head.else_goal != 0)
								{
									te = Findgoal(head.else_goal);
									if (te)
										DoResults(te, attacker, (head.goal_result & #TFGR_ADD_BONUSES));
								}

								return;
							}
						}
					}
				}
			}
			else if (head.takedamage)
			{
				org = head.origin + (head.mins + head.maxs)*0.5;
				points = 0.5*vlen (inflictor.origin - org);
				if (points < 0)
					points = 0;
				points = damage - points;
				if (head == attacker)
					points = points * 0.75;
				if (points > 0)
				{
					if (CanDamage (head, inflictor))
					{	// shambler takes half damage from all explosions
						if (head.classname == "monster_shambler")						
							T_Damage (head, inflictor, attacker, points*0.5);
						else
							TF_T_Damage (head, inflictor, attacker, points, #TF_TD_NOTTEAM, #TF_TD_EXPLOSION);
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
				/*
					if (head.classname == "monster_shambler")						
						T_Damage (head, attacker, attacker, points*0.5);
					else
				*/
						T_Damage (head, attacker, attacker, points);
				}
			}
		}
		head = head.chain;
	}
};