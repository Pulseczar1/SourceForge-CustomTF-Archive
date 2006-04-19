/*======================================================
	TFORTMAP.QC			TeamFortress v2.5	

	(c) TeamFortress Software Pty Ltd 	29/2/97
========================================================
Weapons and functions for the Sentry Guns
======================================================*/
// This is a temporary hack... they'll be replaced with real bots when
// the bot code is in (should that be if? :)
// SentryGun AI Functions
void() Sentry_Rotate;
float() Sentry_FindTarget;
void() Sentry_FoundTarget;
void() Sentry_HuntTarget;
void() Sentry_Pain;
void() Sentry_Die;
float() Sentry_Fire;

//==============================================
#ifndef #COOP_MODE
void() ai_face =
{
	self.ideal_yaw = vectoyaw(self.enemy.origin - self.origin);
	self.ideal_yaw = anglemod(self.ideal_yaw);
	ChangeYaw ();
};
#endif

//==============================================
$cd /quake/fortress/progs/turrgun
$origin 0 -6 24
$base base		
$skin skin

$frame lvl1_stand1
$frame lvl1_shoot1 lvl1_shoot2 
$frame lvl2_stand1
$frame lvl2_shoot1 lvl2_shoot2 
$frame lvl3_stand1
$frame lvl3_shoot1 lvl3_shoot2 

//===========================
// Level 1 Sentry Gun Frames
void()	lvl1_sentry_atk3;
void()  lvl1_sentry_stand =[ $lvl1_stand1, 	lvl1_sentry_stand ] {Sentry_Rotate();};
void()	lvl1_sentry_atk1 =[	$lvl1_shoot1,	lvl1_sentry_atk3 ] 
{
	ai_face();
	if (self.enemy == world || self.enemy.health <= 0 || !visible(self.enemy) || self.enemy.has_disconnected == #TRUE)
		lvl1_sentry_stand();
	else if (self.ammo_shells <= 0)
		lvl1_sentry_stand();
	else if (Sentry_Fire() == #FALSE)
		lvl1_sentry_atk3();
};
void()	lvl1_sentry_atk2 =[	$lvl1_shoot2,	lvl1_sentry_atk3 ]
{
	ai_face();
	Sentry_Fire();
};
void()	lvl1_sentry_atk3 =[	$lvl1_stand1,	lvl1_sentry_atk1 ]  {ai_face();};

//===========================
// Level 2 Sentry Gun Frames
void()	lvl2_sentry_atk3;
void()  lvl2_sentry_stand=	[  $lvl2_stand1, 	lvl2_sentry_stand ] {Sentry_Rotate();};
void()	lvl2_sentry_atk1 =  [	$lvl2_shoot1,	lvl2_sentry_atk2	] 
{
	ai_face();
	if (self.enemy == world || self.enemy.health <= 0 || !visible(self.enemy) || self.enemy.has_disconnected == #TRUE)
		lvl2_sentry_stand();
	else if (self.ammo_shells <= 0)
		lvl2_sentry_stand();
	else if (Sentry_Fire() == #FALSE)
		lvl2_sentry_atk3();
};
void()	lvl2_sentry_atk2	=[	$lvl2_shoot2,	lvl2_sentry_atk3	] 
{
	ai_face();
	Sentry_Fire();
};
void()	lvl2_sentry_atk3 =[	$lvl2_stand1,	lvl2_sentry_atk1 ]
{
	ai_face(); 
	Sentry_Fire();
};

//===========================
// Level 3 Sentry Gun Frames
void()	lvl3_sentry_atk3;
void()  lvl3_sentry_stand=	[   $lvl3_stand1, 	lvl3_sentry_stand ] {Sentry_Rotate();};
void()	lvl3_sentry_atk1 =  [	$lvl3_shoot1,	lvl3_sentry_atk2  ] 
{
	ai_face();
	if (self.enemy == world || self.enemy.health <= 0 || !visible(self.enemy) || self.enemy.has_disconnected == #TRUE)
		lvl3_sentry_stand();
	else if (self.ammo_shells <= 0 && self.ammo_rockets <= 0)
		lvl3_sentry_stand();
	else if (Sentry_Fire() == #FALSE)
		lvl3_sentry_atk3();
};
void()	lvl3_sentry_atk2 =[	$lvl3_shoot2,	lvl3_sentry_atk3  	] 
{
	ai_face();
  	Sentry_Fire();
};
void()	lvl3_sentry_atk3 =[	$lvl3_stand1,	lvl3_sentry_atk1	] 
{
	ai_face(); 
	Sentry_Fire();
};

//=============
void() Sentry_Rotate =
{
	local string st;

	if (Sentry_FindTarget())
		return;

	// Rotate
	if (self.heat == 0)
	{
		self.ideal_yaw = anglemod(self.waitmin);
		ChangeYaw();

		if (anglemod(self.angles_y) <= (self.waitmin + 1))
		{
			self.heat = 1;
			if (random() < 0.1)
				sound (self, #CHAN_ITEM, "weapons/turridle.wav", 1, #ATTN_NORM);
		}
	}
	else
	{
		self.ideal_yaw = anglemod(self.waitmax);
		ChangeYaw();

		if (anglemod(self.angles_y) >= (self.waitmax - 1))
			self.heat = 0;
	}
};

float() Sentry_FindTarget =
{
	local entity client;
	local float	r, gotone, loopc;

	// Try a few checks to make it react faster
	r = 0;
	loopc = 0;
	gotone = #FALSE;
	while (loopc < 3 && gotone == #FALSE)
	{
		client = checkclient();

		gotone = #TRUE;

		if (!client)
			gotone = #FALSE;

	//	if (client == self.enemy)
	//		gotone = #FALSE;

		if (teamplay)
		{
			// Only attack enemies
			if (client.team_no == self.team_no && self.team_no != 0)
				gotone = #FALSE;

			// Cant see Undercover spies
			if (client.undercover_team == self.team_no && self.team_no != 0)
				gotone = #FALSE;
		}

		if (client == self.real_owner)
			gotone = #FALSE;

		if (client.is_feigning)
			gotone = #FALSE;

		if (client.flags & #FL_NOTARGET)
			gotone = #FALSE;
		if (client.items & #IT_INVISIBILITY)
			gotone = #FALSE;

		r = range (client);
		if (r == #RANGE_FAR)
			gotone = #FALSE;
			
		if (!visible (client))
			gotone = #FALSE;

		if (r == #RANGE_NEAR)
		{
			if (client.show_hostile < time && !infront (client))
				gotone = #FALSE;
		}
		else if (r == #RANGE_MID)
		{
			if ( /* client.show_hostile < time || */ !infront (client))
				gotone = #FALSE;
		}

		loopc = loopc + 1;
	}

	if (!gotone)
		return #FALSE;

	// Found a Target
	self.enemy = client;
	if (self.enemy.classname != "player")
	{
		self.enemy = self.enemy.enemy;
		if (self.enemy.classname != "player")
		{
			self.enemy = world;
			return #FALSE;
		}
	}
	
	Sentry_FoundTarget ();

	return #TRUE;
};

void() Sentry_FoundTarget =
{
	// Cannon Powerup Sound?
	if (self.ammo_shells > 0 || (self.ammo_rockets > 0 && self.weapon == 3))
		sound (self, #CHAN_VOICE, "weapons/turrspot.wav", 1, #ATTN_NORM);

	Sentry_HuntTarget ();
	if (self.super_damage_finished < time)
		self.super_damage_finished = time + 0.5;
};

void() Sentry_HuntTarget =
{
	self.goalentity = self.enemy;
	if (self.weapon == 1)
		self.think = lvl1_sentry_atk1;
	else if (self.weapon == 2)
		self.think = lvl2_sentry_atk1;
	else // if (self.weapon == 3)
		self.think = lvl3_sentry_atk1;
	self.ideal_yaw = vectoyaw(self.enemy.origin - self.origin);
	self.nextthink = time + 0.1;
	SUB_AttackFinished (1);	// wait a while before first attack
};

void() Sentry_Pain =
{
	// Update the owner's status bar
	self.real_owner.StatusRefreshTime = time + 0.2;
};

void() Sentry_Die =
{
	sprint(self.real_owner, #PRINT_HIGH, "Your sentry gun was destroyed.\n");
	self.real_owner.has_sentry = #FALSE;

	ThrowGib("progs/tgib1.mdl", -70);
	ThrowGib("progs/tgib2.mdl", -70);
	ThrowGib("progs/tgib3.mdl", -70);

	if (self.classname == "building_sentrygun_base")
	{
		if (self.oldenemy)
			dremove(self.oldenemy);
	}
	else
	{
		dremove(self.trigger_field);
	}

	WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
	WriteByte (#MSG_BROADCAST, #TE_EXPLOSION);
	WriteCoord (#MSG_BROADCAST, self.origin_x);
	WriteCoord (#MSG_BROADCAST, self.origin_y);
	WriteCoord (#MSG_BROADCAST, self.origin_z);
#ifdef QUAKE_WORLD
	multicast (self.origin, #MULTICAST_PHS);
#endif

	BecomeExplosion ();
};

float() Sentry_Fire =
{
	local vector dir;
	
	// Only fire if they're within sight
	dir = self.enemy.origin - self.origin;
	if ((self.ideal_yaw - anglemod(self.angles_y)) < -10 || (self.ideal_yaw - anglemod(self.angles_y)) > 10)
		return #FALSE;

	muzzleflash();
	sound (self ,#CHAN_WEAPON, "weapons/sniper.wav", 1, #ATTN_NORM);

	self.ammo_shells = self.ammo_shells - 1;
	if (self.ammo_shells < 0)
	{
		self.ammo_shells = 0;
		return #FALSE;
	}
		
	deathmsg = #DMSG_SENTRYGUN_BULLET;
	FireBullets (1, dir, '0.1 0.1 0');

	// Level 3 Turrets fire rockets every 3 seconds
	if (self.weapon == 3 && self.ammo_rockets > 0 && self.super_damage_finished < time)
	{
		sound (self, #CHAN_WEAPON, "weapons/rocket1i.wav", 1, #ATTN_NORM);

		newmis = spawn ();
		newmis.owner = self;
		newmis.movetype = #MOVETYPE_FLYMISSILE;
		newmis.solid = #SOLID_BBOX;
			
		// set newmis speed	
		newmis.velocity = normalize(self.enemy.origin - self.origin) * 800;
		newmis.angles = vectoangles(newmis.velocity);
		newmis.weapon = #DMSG_SENTRYGUN_ROCKET;
		newmis.touch = T_MissileTouch;

		// set newmis duration
		newmis.nextthink = time + 5;
		newmis.think = SUB_Remove;

		setmodel (newmis, "progs/missile.mdl");
		setsize (newmis, '0 0 0', '0 0 0');		
		setorigin (newmis, self.origin + v_forward*8 + '0 0 16');

		self.super_damage_finished = time + 3;
		self.ammo_rockets = self.ammo_rockets - 1;

		if (self.ammo_rockets == 10)
			sprint(self.real_owner, #PRINT_HIGH, "Sentry Gun is low on rockets.\n");
	}

	// Warn owner that it's low on ammo
	if (self.ammo_shells == 0 && (random() < 0.1))
		sprint(self.real_owner, #PRINT_HIGH, "Sentry Gun is out of shells.\n");
	else if (self.ammo_shells == 20)
		sprint(self.real_owner, #PRINT_HIGH, "Sentry Gun is low on shells.\n");

	if (self.ammo_rockets == 0 && self.weapon == 3 && (random() < 0.1))
		sprint(self.real_owner, #PRINT_HIGH, "Sentry Gun is out of rockets.\n");

	return #TRUE;
};
