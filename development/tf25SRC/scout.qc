/*======================================================
	SCOUT.QC

	TeamFortress v2.5	 29/2/97
========================================================
Functions for the SCOUT class and associated weaponry                          
========================================================*/
// Functions outside this file

// Functions inside this file
// Concussion Grenade Functions
void() ConcussionGrenadeTouch;
void() ConcussionGrenadeExplode;
void() ConcussionGrenadeTimer;
// Scanner Functions
void(float scanrange) TeamFortress_Scan;
void(entity inflictor, entity attacker, float bounce, entity ignore) T_RadiusBounce;
entity(entity scanner, float scanrange, float enemies, float friends) T_RadiusScan;

//=========================================================================
// Touch Function for Flash Grenade
void() FlashGrenadeTouch =
{
	// If the Flash Grenade hits a player, it just bounces off
	sound (self, #CHAN_WEAPON, "weapons/bounce.wav", 1, #ATTN_NORM);
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
};

#ifdef NET_SERVER
	#define SMOOTH_FLASH 0.6
#else
    #define SMOOTH_FLASH 0.1
#endif

void() FlashTimer =
{
	local entity te;

	te = self.owner;

	te.FlashTime = te.FlashTime - #SMOOTH_FLASH;

	if (te.FlashTime < 5)
	{
		te.FlashTime = 0;
		stuffcmd(te, "v_cshift 0\n");
		remove(self);
		return;
	}

	local string st;

	st = ftos(te.FlashTime * 10);

	stuffcmd(te, "v_cshift ");
	stuffcmd(te, st);
	stuffcmd(te, " ");
	stuffcmd(te, st);
	stuffcmd(te, " ");
	stuffcmd(te, st);
	stuffcmd(te, " ");
	stuffcmd(te, st);
	stuffcmd(te, "\n");

	self.nextthink = time + #SMOOTH_FLASH;
};

//=========================================================================
// Flash Grenade explode function, for when the PRIMETIME runs out
void() FlashGrenadeExplode =
{
	local float expsize;
	local entity te, oldself;

	self.effects = self.effects | #EF_BRIGHTLIGHT;

	WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
	WriteByte (#MSG_BROADCAST, #TE_TAREXPLOSION);
	WriteCoord (#MSG_BROADCAST, self.origin_x);
	WriteCoord (#MSG_BROADCAST, self.origin_y);
	WriteCoord (#MSG_BROADCAST, self.origin_z);
#ifdef QUAKE_WORLD
	multicast (self.origin, #MULTICAST_PHS);
#endif

	// Find all people in area
	te = findradius(self.origin, 200);
	while (te)
	{	
		// Player?
		if (te.classname == "player")
		{
			// Damage player and explode
			deathmsg = #DMSG_GREN_FLASH;
			TF_T_Damage(te, self, self.owner, 60, 0, #TF_TD_FIRE);

			if (te.health > 0)
			{
				if (te.FlashTime == 0)
				{
					// create flash timer
					newmis = spawn();

					newmis.classname = "timer";
					newmis.netname = "flashtimer";
					newmis.team_no = self.owner.team_no;
					newmis.owner = te;
					newmis.think = FlashTimer;
					newmis.nextthink = time + 1;
				}

				if (te == self.owner)
					te.FlashTime = 16;
				else
					te.FlashTime = 24;

				local string st;

				st = ftos(te.FlashTime * 10);
				stuffcmd(te, "v_cshift ");
				stuffcmd(te, st);
				stuffcmd(te, " ");
				stuffcmd(te, st);
				stuffcmd(te, " ");
				stuffcmd(te, st);
				stuffcmd(te, " ");
				stuffcmd(te, st);
				stuffcmd(te, "\n");
			}
		}

		te = te.chain;
	}

#ifdef DEMO_STUFF
	// Remove any camera's locks on this missile
	if (self.enemy)
		CamProjectileLockOff();
#endif

#ifdef QUAKE_WORLD
	dremove(self);
#else
	BecomeExplosion();
#endif
};



//=========================================================================
// Touch function for a concussion grenade
void() ConcussionGrenadeTouch =
{
	// concussion grenades bounce off other players now

	sound (self, #CHAN_WEAPON, "weapons/bounce.wav", 1, #ATTN_NORM);	// bounce sound
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
};

//=========================================================================
// Concussion grenade explosion function
void() ConcussionGrenadeExplode =
{	
	T_RadiusBounce (self, self.owner, 240, world);

#ifdef DEMO_STUFF
	// Remove any camera's locks on this missile
	if (self.enemy)
		CamProjectileLockOff();
#endif

	WriteByte (#MSG_BROADCAST, #SVC_TEMPENTITY);
	WriteByte (#MSG_BROADCAST, #TE_EXPLOSION);
	WriteCoord (#MSG_BROADCAST, self.origin_x);
	WriteCoord (#MSG_BROADCAST, self.origin_y);
	WriteCoord (#MSG_BROADCAST, self.origin_z);
#ifdef QUAKE_WORLD
	multicast (self.origin, #MULTICAST_PHS);
	dremove(self);
#else
	BecomeExplosion ();
#endif
};

//=========================================================================
// Concussion grenade timer to remove idlescale
void() ConcussionGrenadeTimer =
{
	local string st;

	if (self.owner.invincible_finished > time)
	{
		stuffcmd(self.owner, "v_idlescale 0\n");
		dremove(self);
		return;
	}

	// Bubble
	newmis = spawn();
	setmodel (newmis, "progs/s_bubble.spr");
	setorigin (newmis, self.owner.origin);
	newmis.movetype = #MOVETYPE_NOCLIP;
	newmis.solid = #SOLID_NOT;
	newmis.velocity = '0 0 15';
	newmis.nextthink = time + 0.5;
	newmis.think = bubble_bob;
	newmis.touch = bubble_remove;
	newmis.classname = "bubble";
	newmis.frame = 0;
	newmis.cnt = 0;
	setsize(newmis, '-8 -8 -8', '8 8 8');

	self.health = self.health - #GR_CONCUSS_DEC;
	
	// medic recovers twice as fast
	if (self.owner.playerclass == #PC_MEDIC)
		self.health = self.health - #GR_CONCUSS_DEC;

	if (self.health < 0)
		self.health = 0;
	self.nextthink = time + #GR_CONCUSS_TIME;

	st = ftos(self.health);
	stuffcmd(self.owner, "v_idlescale ");
	stuffcmd(self.owner, st);
	stuffcmd(self.owner, "\n");

	if (self.health == 0)
		dremove(self);
};

//=========================================================================
// Handles the scanner function for Scouts
void(float scanrange) TeamFortress_Scan = 
{
	local string power;
	local entity list;
	local float scen, scfr;
	local vector lightningvec;

	// added in for the direction scanner code
	local float enemy_detected;
	local float any_detected;

	local vector vf, vr, e;  // transformed versions of v_forward, v_right and the enemy vector
	local float res1, res2, res3; // for the vector work
	local float vf_e_angle, vr_e_angle; // results

	// prevent scan impulse from triggering anything else
	self.impulse = 0;
	self.last_impulse = 0;

	if (self.classname == "player")
	{
		if (!(self.tf_items & #NIT_SCANNER))
			return;

		// If Impulse is #TF_SCAN_ENEMY, toggle Scanning for Enemies
		if (scanrange == #TF_SCAN_ENEMY)
		{
			if (self.tf_items_flags & #NIT_SCANNER_ENEMY)
			{
				sprint (self, #PRINT_HIGH, "Enemy Scanning disabled.\n");
				self.tf_items_flags = self.tf_items_flags - #NIT_SCANNER_ENEMY;
				return;
			}
			sprint (self, #PRINT_HIGH, "Enemy Scanning enabled.\n");
			self.tf_items_flags = self.tf_items_flags | #NIT_SCANNER_ENEMY;
			return;
		}

		// If Impulse is #TF_SCAN_FRIENDLY, toggle Scanning for Friendlies
		if (scanrange == #TF_SCAN_FRIENDLY)
		{
			if (self.tf_items_flags & #NIT_SCANNER_FRIENDLY)
			{
				sprint (self, #PRINT_HIGH, "Friendly Scanning disabled.\n");
				self.tf_items_flags = self.tf_items_flags - #NIT_SCANNER_FRIENDLY;
				return;
			}
			sprint (self, #PRINT_HIGH, "Friendly Scanning enabled.\n");
			self.tf_items_flags = self.tf_items_flags | #NIT_SCANNER_FRIENDLY;
			return;
		}

		// If the user doesn't have as many cells as he/she specified, just
		// use as many as they've got.

		local float scancost;

		scancost = ceil(scanrange / 20);

		if (scancost > self.ammo_cells)
		{
			scanrange = self.ammo_cells * 20;
			scancost = self.ammo_cells;
		}

		if (scanrange <= 0)
		{
			sprint(self, #PRINT_HIGH, "No cells.\n");
			return;
		}

		if (scanrange > #NIT_SCANNER_MAXCELL)
			scanrange = #NIT_SCANNER_MAXCELL;

		scen = 0;
		scfr = 0;
		// Set the Scanner flags
		if (self.tf_items_flags & #NIT_SCANNER_ENEMY)
			scen = 1;
		if (self.tf_items_flags & #NIT_SCANNER_FRIENDLY)
			scfr = 1;

		// If no entity type is enabled, don't scan
		if ((scen == 0) && (scfr == 0))
		{
			sprint(self, #PRINT_HIGH, "All scanner functions are disabled.\n");
			return;
		}

		sprint (self, #PRINT_HIGH, "Power Usage: ");
		power = ftos(scancost);
		sprint (self, #PRINT_HIGH, power);
		sprint (self, #PRINT_HIGH, ". Scanning...\n");

		// Use up cells to power the scanner
		// additions:
		// altered this so scanner could be more easily tested
		self.ammo_cells = self.ammo_cells - scancost;
		scanrange = scanrange * #NIT_SCANNER_POWER;

		// Get the list of entities the scanner finds
		list = T_RadiusScan(self, scanrange, scen, scfr);
	}
	// Base Defence scanning code here

	// Reset the entity counts
	scen = 0;
	scfr = 0;

	// the vectors v_forward and v_right are required to 
	// 'triangulate' the enemies position
	makevectors(self.v_angle);

	// Walk the list
	// For now, just count the entities.
	// In the future, we'll display bearings :)
	// additions: the future is now!
	while (list)
	{
		// sets the enemy_detected flag to #TRUE if not on your team, #FALSE if so
		any_detected = #TRUE; // this flag is set to false if bogie is moving
							 // too slow to be detected (and velocity checking is on)

		// If this scanner is a motion detector, don't record
		// object that don't have the required velocity to be detected.
		if (self.tf_items_flags & #NIT_SCANNER_MOVEMENT)
		{
			if (vlen(list.velocity) > #NIT_SCANNER_MIN_MOVEMENT)
			{
				if ((list.team_no > 0) && (self.team_no > 0) && (list.team_no == self.team_no)) 
				{
					scfr = scfr + 1;
					enemy_detected = #FALSE;
				}
				else
				{
					scen = scen + 1;
					enemy_detected = #TRUE;
				}
			}
			else
			{
				any_detected = #FALSE;
			}
		}
		else
		{
 			if ((list.team_no > 0) && (self.team_no > 0) && (list.team_no == self.team_no))
			{
				scfr = scfr + 1;
				enemy_detected = #FALSE;
			}
			else
			{
				scen = scen + 1;
				enemy_detected = #TRUE;
			}
		}

		// this displays the direction of the detected player
		// using the cosine rule to find the angle   
		//  cos theta = A.B divided by |A||B|
		// it should return a value between 1 and -1
		if (any_detected)
		{
			// Get the unit vector
			lightningvec = normalize(list.origin - self.origin);
			lightningvec = lightningvec * (vlen(list.origin - self.origin) / 5);
			lightningvec = lightningvec + self.origin;

			// Create the Lightning 
			msg_entity = self;
			WriteByte (#MSG_ONE, #SVC_TEMPENTITY);
			WriteByte (#MSG_ONE, #TE_LIGHTNING1);
			WriteEntity (#MSG_ONE, self);
			WriteCoord (#MSG_ONE, self.origin_x);
			WriteCoord (#MSG_ONE, self.origin_y);
			WriteCoord (#MSG_ONE, self.origin_z + 8);
			WriteCoord (#MSG_ONE, lightningvec_x);
			WriteCoord (#MSG_ONE, lightningvec_y);
			WriteCoord (#MSG_ONE, lightningvec_z + 8);
		} // end if(any_detected)

		list = list.linked_list;
	}

	// Display the counts
	// For Base Defences, it will display the counts to all team members
	if ((scen == 0) && (scfr == 0))
	{
		sprint (self, #PRINT_HIGH, "No blips.\n");
		return;
	}

	// Update ammo levels
	W_SetCurrentAmmo ();

	return;
};

//=========================================================================
// Acts just like T_RadiusDamage, but doesn't damage things, just pushes them away
// from the explosion at a speed relative to the distance from the explosion's origin.
void(entity inflictor, entity attacker, float bounce, entity ignore) T_RadiusBounce =
{
	local	float 	points;
	local	entity	head, te;
	local	vector	org;
	local	string	st;

	head = findradius(inflictor.origin, bounce+40);
	
	while (head)
	{
		if (head != ignore)
		{
			if (head.takedamage)
			{
				org = head.origin + (head.mins + head.maxs)*0.5;
				points = 0.5*vlen (org - inflictor.origin);
				if (points < 0)
					points = 0;
				points = bounce - points;

				if (head.classname != "building_sentrygun" && head.classname != "building_sentrygun_base" && points > 0)
				{
					// Bounce!!
					head.velocity = org - inflictor.origin;
					head.velocity = head.velocity * (points / 20);

					if (head.classname != "player")
					{
						if(head.flags & #FL_ONGROUND)
							head.flags = head.flags - #FL_ONGROUND;
					}
					else
					{
						// Concuss 'em!!
						// If they are already concussed, set the concussion back up
						// Try to find a concusstimer entity for this player
						te = find(world, classname, "timer");
						while (((te.owner != head) || (te.think != ConcussionGrenadeTimer)) && (te != world))
							te = find(te, classname, "timer");
						if (te != world)
						{
							stuffcmd(head,"v_idlescale 100\n");
							te.health = 100;
							te.nextthink = time + #GR_CONCUSS_TIME;
						}
						else
						{
							stuffcmd(head,"v_idlescale 100\n");
							stuffcmd(head,"bf\n");
							// Create a timer entity
							te = spawn();
							te.nextthink = time + #GR_CONCUSS_TIME;
							te.think = ConcussionGrenadeTimer;
							te.team_no = attacker.team_no;
							te.classname = "timer";
							te.owner = head;
							te.health = 100;
						}
					}
				}
			}
		}
		head = head.chain;
	}
};

//=========================================================================
// Returns a list of players within a radius around the origin, like findradius,
// except that some parsing of the list can be done based on the parameters passed in.
// Make sure you check that the return value is not NULL b4 using it.
entity(entity scanner, float scanrange, float enemies, float friends) T_RadiusScan =
{
	local entity head;
	local entity list_head;
	local entity list;
	local float gotatarget;

	head = findradius(scanner.origin, scanrange+40);

	while (head)
	{
		gotatarget = 0;
		if (head != scanner)			// Don't pick up the entity that's scanning
		{
			if (head.takedamage)
			{
				if ((head.classname == "player") && (friends || enemies))
				{
					if (teamplay)
					{
						if ( friends && (head.team_no > 0) && (scanner.team_no > 0) && (head.team_no == scanner.team_no) )
							gotatarget = 1;
						if ( enemies && (head.team_no > 0) && (scanner.team_no > 0) && (head.team_no != scanner.team_no) )
							gotatarget = 1;
					}
					else
						gotatarget = 1;
				}
			}
		}

		// Add this entity to the linked list if it matches the target criteria
		if (gotatarget)
		{
			if (list)
			{
				list.linked_list = head;
				list = list.linked_list;
			}
			else
			{
				list_head = head;
				list = head;
			}
		}

		head = head.chain;
	}

	return list_head;
};

